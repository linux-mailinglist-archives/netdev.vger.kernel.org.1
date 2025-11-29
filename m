Return-Path: <netdev+bounces-242668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C7DC93815
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 05:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 60E04348024
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 04:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811B221D3D6;
	Sat, 29 Nov 2025 04:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pz3sYEwE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5755E17D2;
	Sat, 29 Nov 2025 04:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764390797; cv=none; b=DirmtEZ7bAFJZ2k0pSx0hZJeLY0gdFBdzX2/Bru6wcihtGw1UmrdRpjsGy2Jc2haYgmWphL7KVaDmpMfi5/vbNDRCeGPzzCLKGvS00+dei5o7BdQwKyoIbIrau62UknW+pOhyFam3CnxXuhxrovvhs4P8NLJ5ymxMvIx0Oi9ZtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764390797; c=relaxed/simple;
	bh=sZW9iuQUm/Ev2mS++BSfuXKbHMVKsbXF+sNm/Rc1aAI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bFy6ziTikdcUoJlFGASIidhVCARzbMCzsCWjb7V1CLftkp0ZT7KGP03n4P75NV5/fyKJqziDBw5L+BxTr/rFKAM2VB0KgJsZP7ZdF+JvdQXqri8wSpLAOGnEDO0d6XTFnBN8cj85SkPDXfw8+kkJZELzHm2WthN++HE0i+j9ME4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pz3sYEwE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFACFC4CEF7;
	Sat, 29 Nov 2025 04:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764390796;
	bh=sZW9iuQUm/Ev2mS++BSfuXKbHMVKsbXF+sNm/Rc1aAI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pz3sYEwEG3606Jmb8uvGMNFIBV5e9f+TS377XvFlpvQ3Bha165UT1V4lyt7jJOi9o
	 JQNs+dAx8C58Sc4TxW9hadvvpSlxi4DoJZvzfoEub3CKU6FCbVTIvaM0+hIPjkRgZf
	 2xyzmF5AUcCdDWnO+8ZS4pUBr1LLzzquKuUcqy3hZ5iQ14tayCg1nEedhMM8EFR2sT
	 /FWKnfzwzvE7I17pAeHtlzJO29qiTinV5z6FcgQLDM6a4x3NCYI69AcdcbYB4voUCY
	 1rXQkJ32Ojfoq9cb900C6JInhaaIp3NzbydO1iNpDG6YEfajdFz4u8BZlGSEOSYNkv
	 Z05oEt8lFQWPg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5D5F380692B;
	Sat, 29 Nov 2025 04:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: netpoll: initialize work queue before error
 checks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176439061855.907626.14454545998670880238.git-patchwork-notify@kernel.org>
Date: Sat, 29 Nov 2025 04:30:18 +0000
References: <20251127-netpoll_fix_init_work-v1-1-65c07806d736@debian.org>
In-Reply-To: <20251127-netpoll_fix_init_work-v1-1-65c07806d736@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, gustavold@gmail.com, asantostc@gmail.com,
 kernel-team@meta.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 27 Nov 2025 07:30:15 -0800 you wrote:
> Prevent a kernel warning when netconsole setup fails on devices with
> IFF_DISABLE_NETPOLL flag. The warning (at kernel/workqueue.c:4242 in
> __flush_work) occurs because the cleanup path tries to cancel an
> uninitialized work queue.
> 
> When __netpoll_setup() encounters a device with IFF_DISABLE_NETPOLL,
> it fails early and calls skb_pool_flush() for cleanup. This function
> calls cancel_work_sync(&np->refill_wq), but refill_wq hasn't been
> initialized yet, triggering the warning.
> 
> [...]

Here is the summary with links:
  - [net] net: netpoll: initialize work queue before error checks
    https://git.kernel.org/netdev/net/c/e5235eb6cfe0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



