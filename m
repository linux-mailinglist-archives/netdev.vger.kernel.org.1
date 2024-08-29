Return-Path: <netdev+bounces-123018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AD3963723
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 03:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64E97283981
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 01:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA749199A2;
	Thu, 29 Aug 2024 01:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDcNFx7J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F6479C4
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 01:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724893229; cv=none; b=rVdOdyF9O1qSJMESIo1ySNJfYtcglzjYVlfc91/63zL6trDQGvxfhK1Eg0kuuIfOgF/B5XCu3Q+p3EVuzromZp9mnqqkA07knN1lQntBzaEGzcEcE8+FfKGIEdI7H2gw7WiGwyn9H2KAGkk+tA32fliq3j6l1L4M8RdvDAA0jPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724893229; c=relaxed/simple;
	bh=zy/zI89NO5T5pPCu7LfYQlS5WfAuskUvq3fScRdF+fU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ij1KLwk7ax4RmHCXT1C8Z7AbOEBUQ/0WSQE1sYCk0vlV0HpJkWM5KjcJ7QKgxZX6Lod3iKy99XasgFiXbIsvyQoQMlcNo/ZpF06FQCG3Lj2Q+qYd3mATQMNvkiZaOqr7gtfIWVU65Z224H7DQoE7V+nE60Iv/zE3ZXrnMK0iYnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDcNFx7J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3990C4CEC0;
	Thu, 29 Aug 2024 01:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724893229;
	bh=zy/zI89NO5T5pPCu7LfYQlS5WfAuskUvq3fScRdF+fU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fDcNFx7J/QGulekbY/+YensrYS9NUAwf98hE9Jz4JsQm3Z7Gn1jD3QTJUkEt02KDv
	 CYdTFS48aWwvNKXfqGrr5N5i+lrkVhQmE8pgIxUy6jUsJZjNPWaiRx58bJP7aoCww7
	 zpLtew2XQ/W2gAWljng9vFI4j5F0U/tO9C0tBnkzLlF4fHsEwfwN2+Wr5J2iR/5K5C
	 sfheX06QDN1LPjyRXJKasQgOjnBQXeDOXgxEWX5hwFyjcuOewWRISGvEof4b5I56kD
	 Fy4WugeDmouYLfvvW9A5TsYlwSiKH7iAScA6sYrmFksLpl9kxsa3yKskZTFHcCcqz+
	 OJNOeZZSemnaA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D403809A80;
	Thu, 29 Aug 2024 01:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: busy-poll: use ktime_get_ns() instead of
 local_clock()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172489322910.1482642.11945212476848536774.git-patchwork-notify@kernel.org>
Date: Thu, 29 Aug 2024 01:00:29 +0000
References: <20240827114916.223377-1-edumazet@google.com>
In-Reply-To: <20240827114916.223377-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, almasrymina@google.com,
 willemb@google.com, jdamato@fastly.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 27 Aug 2024 11:49:16 +0000 you wrote:
> Typically, busy-polling durations are below 100 usec.
> 
> When/if the busy-poller thread migrates to another cpu,
> local_clock() can be off by +/-2msec or more for small
> values of HZ, depending on the platform.
> 
> Use ktimer_get_ns() to ensure deterministic behavior,
> which is the whole point of busy-polling.
> 
> [...]

Here is the summary with links:
  - [net] net: busy-poll: use ktime_get_ns() instead of local_clock()
    https://git.kernel.org/netdev/net/c/0870b0d8b393

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



