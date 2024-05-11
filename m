Return-Path: <netdev+bounces-95630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B92A28C2E67
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 03:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A594282704
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 01:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A512FEEA9;
	Sat, 11 May 2024 01:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FkRmXTo1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0EDD527
	for <netdev@vger.kernel.org>; Sat, 11 May 2024 01:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715391029; cv=none; b=Xpr94feQcRagEMmzY0mhbmwrhTCjRkc0mGet36PpD7IVDTx52B3sDYRzyEIHyGSGy6kydBfCUayfB+F7oeDiuAJmcwEubDwf/4wH2YiQAh/JLMoC0R1cAMUnDo562XLHwRqh0h59J3zojtfUdSFg7Z3rvhQSWqA0WQiDpi4sFXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715391029; c=relaxed/simple;
	bh=BAoQl9cpm55xVvbE6uwChMWMNBpIHp56t66YeUpqT7g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A+9g9PCB6yGDlhholmR3SGKhjQJEOZqdcRVm23Md1YyvjfsXTKDWV2eMeNgWlYKw263i8dgE4RrY9ViZGFS020wm7eyHHXaRbxljuA9xXAwbk6xRNeQYSiENbJSX+E0vLBJJQ0yiN4foGhv6TcRoEQRGKGSXM3m14G9B8/WZQMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FkRmXTo1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16D6CC2BBFC;
	Sat, 11 May 2024 01:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715391029;
	bh=BAoQl9cpm55xVvbE6uwChMWMNBpIHp56t66YeUpqT7g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FkRmXTo1u8Ionw2KMjdGwVxTBU9V4UuoH4Rs/TlhhYIb4fdFyJeJ6GknuyzKK1ra5
	 GNX9pAJY27t31SRFHmEufIVT+AfC/E1yhxNIb5YLaStecijghuw2zga9WV/bAovAnV
	 t0O02hgedCDzz7b78Hos5NZxjCmVxDHTgLqO0GYXmhzNi3TRpg7VzWMNTLOPGIVc9u
	 /o9gl7Y/QKQko0AQ00szh40SK0CRfHWPvhB99sIeHUNXJVE8nuS+sjUoDxFxSt9wbD
	 wZM8u/4TfW/l+hiah/B0EDz6/64NAS3CUe8VFwsGUgU+c+0rXn1dmDiyI14j1JbyHp
	 6JU7ReuTVPW3g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 04FA5C32759;
	Sat, 11 May 2024 01:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] eth: sungem: remove .ndo_poll_controller to avoid
 deadlocks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171539102901.31003.5030547780750327077.git-patchwork-notify@kernel.org>
Date: Sat, 11 May 2024 01:30:29 +0000
References: <20240508134504.3560956-1-kuba@kernel.org>
In-Reply-To: <20240508134504.3560956-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, erhard_f@mailbox.org, robh@kernel.org, elder@kernel.org,
 wei.fang@nxp.com, bhupesh.sharma@linaro.org, benh@kernel.crashing.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  8 May 2024 06:45:04 -0700 you wrote:
> Erhard reports netpoll warnings from sungem:
> 
>   netpoll_send_skb_on_dev(): eth0 enabled interrupts in poll (gem_start_xmit+0x0/0x398)
>   WARNING: CPU: 1 PID: 1 at net/core/netpoll.c:370 netpoll_send_skb+0x1fc/0x20c
> 
> gem_poll_controller() disables interrupts, which may sleep.
> We can't sleep in netpoll, it has interrupts disabled completely.
> Strangely, gem_poll_controller() doesn't even poll the completions,
> and instead acts as if an interrupt has fired so it just schedules
> NAPI and exits. None of this has been necessary for years, since
> netpoll invokes NAPI directly.
> 
> [...]

Here is the summary with links:
  - [net] eth: sungem: remove .ndo_poll_controller to avoid deadlocks
    https://git.kernel.org/netdev/net/c/ac0a230f719b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



