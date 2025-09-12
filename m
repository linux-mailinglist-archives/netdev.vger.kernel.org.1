Return-Path: <netdev+bounces-222376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6BCB54012
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 04:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9D0E5A6E9A
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 02:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E37D19E97F;
	Fri, 12 Sep 2025 02:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IiJo/3Xm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768A619D8A3;
	Fri, 12 Sep 2025 02:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757642429; cv=none; b=E7oa9SGL6W5OetyI9U/2hsjzi/JjCxv91SRJRcnAzbK5gimK3ILFLEUrIPPW4D/NdQg/P5zoqrjBuWdgFk67IPiewwPnF7CV6NBokby5pK3hILCJsqaHEKMiHhtByETxGFfzoVqSG8/8l7RuI7RI2NwrAlMjpwRFXax6whuFfeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757642429; c=relaxed/simple;
	bh=lphVgeZ5on8hME4WbnO3PM9jKNXeDY52nLMTTDIR+fI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AqD0TcRduU1zZ0cgemwZG7m2qujU6Ztu8nzC+nGeoA3rKI4ZHuVbDSe+fIjszyERAsG/bV/gktro78UQuGxg1ZVC6ksejeTi4w8hhKbepD1daNG/LuRCpctLExBRCfBHgYj1gJKqaNumCfkwTz/SSAWto8Ybizkzw1jJWePRsGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IiJo/3Xm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44EF5C4CEF0;
	Fri, 12 Sep 2025 02:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757642429;
	bh=lphVgeZ5on8hME4WbnO3PM9jKNXeDY52nLMTTDIR+fI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IiJo/3XmDWnP64k5OqvMuwZWtlZLc2eV8+kg8outlM8OYe/leANyK0rZwaee0ZFQv
	 7W0OGUGgaGoouZb/DFyHBk0RyJGrxE2zePRtU8HEOwsXlnndj8wCHi/LqYpHlE2T8P
	 KMMS3zE2YUoh4Pzi6/sQ3SMLn4IatoGsjyXw28fiHnzegRsvUh8SfcSPRmKMCqqfjB
	 T/JzK1aGrDWPIIDhIDNNAnurr1qWkb3iNHuXEWUSHboIkufjN9KZdB0GWa2sA1/Juk
	 SagRdZ4zKFVuFyJtoQjhjVGgSZ2LOyiXx1k/rhlK8dKHZJi/ILNb81d4G0Rq5SR5eg
	 67rU7eXPvCbyQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE26383BF69;
	Fri, 12 Sep 2025 02:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v12 0/2] net: af_packet: optimize retire
 operation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175764243148.2373516.17876362727543730939.git-patchwork-notify@kernel.org>
Date: Fri, 12 Sep 2025 02:00:31 +0000
References: <20250908104549.204412-1-jackzxcui1989@163.com>
In-Reply-To: <20250908104549.204412-1-jackzxcui1989@163.com>
To: Xin Zhao <jackzxcui1989@163.com>
Cc: willemdebruijn.kernel@gmail.com, kerneljasonxing@gmail.com,
 edumazet@google.com, ferenc@fejes.dev, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  8 Sep 2025 18:45:47 +0800 you wrote:
> In a system with high real-time requirements, the timeout mechanism of
> ordinary timers with jiffies granularity is insufficient to meet the
> demands for real-time performance. Meanwhile, the optimization of CPU
> usage with af_packet is quite significant. Use hrtimer instead of timer
> to help compensate for the shortcomings in real-time performance.
> In HZ=100 or HZ=250 system, the update of TP_STATUS_USER is not real-time
> enough, with fluctuations reaching over 8ms (on a system with HZ=250).
> This is unacceptable in some high real-time systems that require timely
> processing of network packets. By replacing it with hrtimer, if a timeout
> of 2ms is set, the update of TP_STATUS_USER can be stabilized to within
> 3 ms.
> 
> [...]

Here is the summary with links:
  - [net-next,v12,1/2] net: af_packet: remove last_kactive_blk_num field
    https://git.kernel.org/netdev/net-next/c/28d2420d403a
  - [net-next,v12,2/2] net: af_packet: Use hrtimer to do the retire operation
    https://git.kernel.org/netdev/net-next/c/f7460d2989fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



