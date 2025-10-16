Return-Path: <netdev+bounces-229835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 157C6BE1233
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 02:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E97F64E66D0
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 00:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6D61DF273;
	Thu, 16 Oct 2025 00:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1eSjp0e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5801DF261;
	Thu, 16 Oct 2025 00:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760575832; cv=none; b=ISki8xzUVrMY3MIH7rPn6KF4bB6qy9MBjB4vYd0uYWCZPARLx25UYNDEGuvOZY8t9K+1IH+4MoZtjXFlUldjLyazAqG2wAKAaisw0iRWqnmF1YKEfU7cubU2mgPGhnUK/3OlpWob5qFDTQRfnr1cmC+mZePOAB+LRp7x5PniieM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760575832; c=relaxed/simple;
	bh=G8v4J9gHkOvFgah5K7x3pIqZ6ejdYQX3ZUD61EJ4jvY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RqQsHTTPOA3/s3KgCatw7BXQhSWYqHK9wiNPsza9axEluwRZOhToxQoJpwx6r2bHe/gXNC2vXQMDVfTeb1k22G2DOHEy3agjssm4wdApfzj0AR5Ox/WDKrX/cxRGyuQVTfr5C4JHxnirPVoGOo1HvJbQNBBK/tIpj5zWICgQhGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1eSjp0e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5114C4CEF8;
	Thu, 16 Oct 2025 00:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760575831;
	bh=G8v4J9gHkOvFgah5K7x3pIqZ6ejdYQX3ZUD61EJ4jvY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T1eSjp0eBLDxUWg4uBAKqqczn1JaAkvRGwpRziWZ04dA5TLap5G/I0JwP6+yxLMsZ
	 1MPzDRyxDswu1ZH09PfKOKXJqs/q3WFZopoWqpeVJNegrPdq7FOtcPL4aByHNvewFv
	 JnFNH4/JjaHLlxkUvVQmkxoxFdYKE0npo15zlJJsZfIsC7oyADJDsYGrry7orw3Hxd
	 T3sKA06jSuJ90N/jopE5+oMOxHzB1dLgd2SYrsgwMDQ1txFK4T41J1dBDR+hOoPyhb
	 6kwV0186ByRDN9IeBTEXDvgiNranpuBgzUW0s5ULBCRiXHjzt0sgxvw3aiYjKZ6icQ
	 B7QPC16ClsaaQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71362380DBE9;
	Thu, 16 Oct 2025 00:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] netdevsim: set the carrier when the device goes up
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176057581624.1114538.7225603032888761375.git-patchwork-notify@kernel.org>
Date: Thu, 16 Oct 2025 00:50:16 +0000
References: <20251014-netdevsim_fix-v2-1-53b40590dae1@debian.org>
In-Reply-To: <20251014-netdevsim_fix-v2-1-53b40590dae1@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, dw@davidwei.uk,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 andrew@lunn.ch

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 14 Oct 2025 02:17:25 -0700 you wrote:
> Bringing a linked netdevsim device down and then up causes communication
> failure because both interfaces lack carrier. Basically a ifdown/ifup on
> the interface make the link broken.
> 
> Commit 3762ec05a9fbda ("netdevsim: add NAPI support") added supported
> for NAPI, calling netif_carrier_off() in nsim_stop(). This patch
> re-enables the carrier symmetrically on nsim_open(), in case the device
> is linked and the peer is up.
> 
> [...]

Here is the summary with links:
  - [net,v2] netdevsim: set the carrier when the device goes up
    https://git.kernel.org/netdev/net/c/1a8fed52f7be

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



