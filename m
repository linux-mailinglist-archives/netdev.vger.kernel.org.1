Return-Path: <netdev+bounces-134017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF49997ABD
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 04:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DBD9B22DD6
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 02:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47348198A24;
	Thu, 10 Oct 2024 02:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKbOd6Iz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234E8186607
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 02:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728528635; cv=none; b=EaTIOViIQv0/6RIAZgap9mMOqF1bA6iHeBf4TRWklR9Zq0in/BGI+7HKU4w+2q3SNvqhiUHQLJUUVPFLJqZt+CPGyw3ujxJUo0UqE4w4P07TIx3crbZ1r1fzQ8+RVubz46PL2HuMTO5qJoc6qSleROQavCQVPTNE3+7I8emdlwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728528635; c=relaxed/simple;
	bh=6dRbKZhOMNFty32mDpIir9d8d99mmMP+Bp1FvmcYcag=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ky65/835+TUSHhESv2+s40weeDuJb7Dx3uUeO0vlqejevJRXx3IiEyBafam9OMbOMtu5R1JKeTzE7nFqv88sV2LDljvBlSg21ro4xea8VzM2FqyT+BZDH5sIaXbY4oitF5NeVXlIUln6mS8pOlnLhGt407XzrkfhkGzonANJ0Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKbOd6Iz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A831AC4CECF;
	Thu, 10 Oct 2024 02:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728528634;
	bh=6dRbKZhOMNFty32mDpIir9d8d99mmMP+Bp1FvmcYcag=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eKbOd6IzZN3CY9uCweZ80Yc1qWAUsHM8WzzB59qZi+cqFiho2pkPn2XQ8szjNhJSh
	 PaC2TfRKWH9bTDJl6KHjgHopJNb8Snid51J1atBAiVe9g0Wnlp4E4+7E6/CE3C6psZ
	 zRmV1CrkNVohoKLhSddFaWHthgWoHQEfmzJB2nB9FAFI5fS14bflew6V7K8b90oGRq
	 PhJAqkTjL3i8nbYf/JKd0Ak+FFxEV9EO1kYLuvnGUkt+VUayS3GICqzpLD7Yv0XIHS
	 HDe7nBwZqXrqNST7qltmS3LZE5T885aApGZsrGMs59Cimt+/83r+8WsMd68pJHL9IQ
	 8B4NZTrqn0cNg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33AB93806644;
	Thu, 10 Oct 2024 02:50:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ipv6: switch inet6_acaddr_hash() to less predictable
 hash
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172852863873.1545809.12714815210092245223.git-patchwork-notify@kernel.org>
Date: Thu, 10 Oct 2024 02:50:38 +0000
References: <20241008121307.800040-1-edumazet@google.com>
In-Reply-To: <20241008121307.800040-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, kuniyu@amazon.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  8 Oct 2024 12:13:07 +0000 you wrote:
> commit 2384d02520ff ("net/ipv6: Add anycast addresses to a global hashtable")
> added inet6_acaddr_hash(), using ipv6_addr_hash() and net_hash_mix()
> to get hash spreading for typical users.
> 
> However ipv6_addr_hash() is highly predictable and a malicious user
> could abuse a specific hash bucket.
> 
> [...]

Here is the summary with links:
  - [net-next] ipv6: switch inet6_acaddr_hash() to less predictable hash
    https://git.kernel.org/netdev/net-next/c/4daf4dc275f1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



