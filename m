Return-Path: <netdev+bounces-76023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB61F86BFEF
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 05:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 612E228704B
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 04:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D6A3B7A0;
	Thu, 29 Feb 2024 04:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dPI63c1W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B084C3B190
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 04:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709181627; cv=none; b=klXmU+Hb/HxsT+Wh0zw6DYpaIKXKRpqv781DdySWEHedx42GwgLdeqsrpIyC8aCBjnnGd953FeWGWW9RXVtY49xyOuMdcYHaGjW7qU9rspDmWBuiSpdgX7CH8qcfFx7ExBlW2nEeIurFcdTTz3ifvf9HI8BJqKe57klDOCO9fKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709181627; c=relaxed/simple;
	bh=T4naJicyXrAgvgDUK3OFxsXHzRKnqiThgEquv4aYs8w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Yzc/1rJiVJZmjN0CvB1SzoRF0s1YlY/eqGnOgF4DJejwRpXazhFQahAONBw0zRABQy53EIpdW8rFRLM/Dic61jqG8fdilI70ENVHuXUdmdyUz/VULBJ+tuHoIXl0BDNhBA+Q0IPqSvluLaU9e79iz2eQQIHRKPbmuc5q9fvzpkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dPI63c1W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E61CC433B1;
	Thu, 29 Feb 2024 04:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709181627;
	bh=T4naJicyXrAgvgDUK3OFxsXHzRKnqiThgEquv4aYs8w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dPI63c1W9MiskjE5mv9w5r6t/M/Jm75IIbAiS4Y0OkimzedOGhNn2kuq2KmdLMKLr
	 +8IAoaUmsORD7Kuckg+25juy+pLbiP+YlqmooUtdfQLUkpN7gHS2VHCUdHv9tG+jCy
	 SDG8gNpBNvO/yZigJ9wMRN0IMNVgE0nWgoidv4XqG91dyxG3gEJkWecK9vsk42cTKI
	 tIprNn7ykQqTwAWwB4BYtlniNdnqpRnrP4V8Ic0BtkRfXy70/UvCg/EjOO0oZjtZI0
	 uqGeeckq6sjqBV+cN2yTpYd9m8ZlUruKorbCFuTmPFFaNVg5pue9hc+MpyylxRayca
	 tsNDZN2ouwzzA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1EE85D84BBA;
	Thu, 29 Feb 2024 04:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: call skb_defer_free_flush() from
 __napi_busy_loop()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170918162712.21906.8518636023122156699.git-patchwork-notify@kernel.org>
Date: Thu, 29 Feb 2024 04:40:27 +0000
References: <20240227210105.3815474-1-edumazet@google.com>
In-Reply-To: <20240227210105.3815474-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, skhawaja@google.com,
 sdf@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 27 Feb 2024 21:01:04 +0000 you wrote:
> skb_defer_free_flush() is currently called from net_rx_action()
> and napi_threaded_poll().
> 
> We should also call it from __napi_busy_loop() otherwise
> there is the risk the percpu queue can grow until an IPI
> is forced from skb_attempt_defer_free() adding a latency spike.
> 
> [...]

Here is the summary with links:
  - [net-next] net: call skb_defer_free_flush() from __napi_busy_loop()
    https://git.kernel.org/netdev/net-next/c/1200097fa8f0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



