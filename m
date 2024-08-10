Return-Path: <netdev+bounces-117358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4AF94DAD7
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 07:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 998A8B22214
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 05:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA55013C836;
	Sat, 10 Aug 2024 05:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aM0kj+O/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CE613C81B
	for <netdev@vger.kernel.org>; Sat, 10 Aug 2024 05:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723266638; cv=none; b=eBMBNWc4/qLbKL/f8Fn7sGB5M99Hj3+RePCQXIoslSv1V/dTWQMCdpAuOchzASj3huyXmyC74dXj7csLuOWgKfwx725cEOYTtXEAbzK5XLWeHkJR/oD4aP6SZoufyupN1NzRDYPwZRKuPyvPqsUTYKDrb27yNyHuETU09YO0jxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723266638; c=relaxed/simple;
	bh=nQKDiudB9fAHm9bT5dgNMu4QzcGhpmnFUU4MZA2xaIA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LXT3sSRA1KOboH/Y8u9eZY22zIDg65MvCiVVy9l/rnREvE8amwLEWiLG/Zfiz9AGJR4eOaD4EcT3KVZQgPqUUgqlsUB+B/yCmllE+x6QuVPuVK0ae0wYGpyZ5BqCIwC5yH86BXpp+odttfbDlY4bmfcAw3iAnYCf0j6ZnBEd6J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aM0kj+O/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16AEEC32786;
	Sat, 10 Aug 2024 05:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723266638;
	bh=nQKDiudB9fAHm9bT5dgNMu4QzcGhpmnFUU4MZA2xaIA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aM0kj+O/AjmyPAxPYWs7Huu1WnbAS+Qgq+CKHnOh5vOQKTo/AsgdzlBbFtbwRxLqu
	 AvBWyIMWE2N4LeBNy6vzA3kQXjfdrEXbiQKecRORPz8TirKBYcfs6BEeQedvF9VDYK
	 vFMHRrpHWkq+7wliefaztIkDc/GpNqKvkeI3+fWFTUm+EmaZlSDxbRIb1oq4lyctwy
	 51dUqbilr82vy5M/QaIqE5ejXZIN5LQzJZDnirbBf0dFcFxhb73g6NW5qU1H9cCori
	 +LaeffWFSlYp8EPLjj9kVEiyjicmRakuYN7Bodrrh9OwX/GwzHztGI2TJKpYFYcbXf
	 WJblPk4yU2dKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C88382333F;
	Sat, 10 Aug 2024 05:10:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4 0/3] Don't take HW USO path when packets can't be
 checksummed by device
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172326663699.4144110.16861317918539744046.git-patchwork-notify@kernel.org>
Date: Sat, 10 Aug 2024 05:10:36 +0000
References: <20240808-udp-gso-egress-from-tunnel-v4-0-f5c5b4149ab9@cloudflare.com>
In-Reply-To: <20240808-udp-gso-egress-from-tunnel-v4-0-f5c5b4149ab9@cloudflare.com>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, willemdebruijn.kernel@gmail.com,
 kernel-team@cloudflare.com,
 syzbot+e15b7e15b8a751a91d9a@syzkaller.appspotmail.com, willemb@google.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 08 Aug 2024 11:56:20 +0200 you wrote:
> This series addresses a recent regression report from syzbot [1].
> 
> After enabling UDP_SEGMENT for egress devices which don't support checksum
> offload [2], we need to tighten down the checks which let packets take the
> HW USO path.
> 
> The fix consists of two parts:
> 
> [...]

Here is the summary with links:
  - [net,v4,1/3] net: Make USO depend on CSUM offload
    https://git.kernel.org/netdev/net/c/2b2bc3bab158
  - [net,v4,2/3] udp: Fall back to software USO if IPv6 extension headers are present
    https://git.kernel.org/netdev/net/c/30b03f2a0592
  - [net,v4,3/3] selftests/net: Add coverage for UDP GSO with IPv6 extension headers
    https://git.kernel.org/netdev/net/c/1d2c46c1bc56

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



