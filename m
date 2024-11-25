Return-Path: <netdev+bounces-147122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FC69D795A
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 01:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32E82B21C52
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 00:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A416963D;
	Mon, 25 Nov 2024 00:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLpi/udp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C667747F;
	Mon, 25 Nov 2024 00:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732495218; cv=none; b=jurBfDlKolHL/LNxJg0Ui9PkdR620/0gsKGWKUg2hoYN7yAfqc3b11DH30/EEUSCMm/hQFiU8T4Fy30po++pJ5JVe1dRHvgNi3BYGTnsENTrXzhWcyAt4wESAi2iX/u9mfk+ydhn10+3Cq1HWZoM6vto5cvd0AwmdBr24fHrid4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732495218; c=relaxed/simple;
	bh=X8f4Yy3GzmVZUP75x6ZaTNmX2/B6rDxzA1VdO0mJ6HM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UqSAs6U7TIdniN2T0v1lCjhpC0M8lV7d88ueg3aAp9npDLa82YDyh/GEzDAdDnsT2JyMv4xWJ1NyuCOnYu4UHQ0dEujQTVPp+0G86nOw6Mng7CI5Kv1cjaF9kOfihIc3IzSwo8/FylVDtumwvYTRwVJULnZl1x409CtroZxtjm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLpi/udp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0068C4CECC;
	Mon, 25 Nov 2024 00:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732495218;
	bh=X8f4Yy3GzmVZUP75x6ZaTNmX2/B6rDxzA1VdO0mJ6HM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DLpi/udpxZLlXatzfcJU5KLF9fuSmWg/NdT/6emmlCKRyVVY05XJXqEX5zo6yob8G
	 9PURFk5Ew0pHIszrQsiwkqo5ZOh+GQP54QWsyBULLF5hLItOwAaG02XvWrIqrnWaif
	 9v/2HoJCIgScRvSwb9PWLoldO42QQbSSoRoORlJYduGu5iNbaPudac18kdausS+Hq+
	 vLHkARzWl8Rv5VWLS8uKq/LYGVSTyPYApm9Q1U5fc+rQteIgegKbHMIfVGHLPuNe1D
	 tD6dcGCJdHeMpsW5NdPGLmxQ8VFWoDeCEPrJ3z65mm6NAtIpqeFbedF+qGpOiES8Fh
	 FVVRpQUEjBmbQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AFDC73809A00;
	Mon, 25 Nov 2024 00:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1 1/2] net: usb: lan78xx: Fix double free issue with
 interrupt buffer allocation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173249523051.3406669.14794155201362335327.git-patchwork-notify@kernel.org>
Date: Mon, 25 Nov 2024 00:40:30 +0000
References: <20241116130558.1352230-1-o.rempel@pengutronix.de>
In-Reply-To: <20241116130558.1352230-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, woojung.huh@microchip.com, andrew+netdev@lunn.ch,
 john.efstathiades@pebblebay.com, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 UNGLinuxDriver@microchip.com, phil@raspberrypi.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 16 Nov 2024 14:05:57 +0100 you wrote:
> In lan78xx_probe(), the buffer `buf` was being freed twice: once
> implicitly through `usb_free_urb(dev->urb_intr)` with the
> `URB_FREE_BUFFER` flag and again explicitly by `kfree(buf)`. This caused
> a double free issue.
> 
> To resolve this, reordered `kmalloc()` and `usb_alloc_urb()` calls to
> simplify the initialization sequence and removed the redundant
> `kfree(buf)`.  Now, `buf` is allocated after `usb_alloc_urb()`, ensuring
> it is correctly managed by  `usb_fill_int_urb()` and freed by
> `usb_free_urb()` as intended.
> 
> [...]

Here is the summary with links:
  - [net,v1,1/2] net: usb: lan78xx: Fix double free issue with interrupt buffer allocation
    https://git.kernel.org/netdev/net/c/03819abbeb11
  - [net,v1,2/2] net: usb: lan78xx: Fix memory leak on device unplug by freeing PHY device
    https://git.kernel.org/netdev/net/c/ae7370e61c5d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



