Return-Path: <netdev+bounces-182312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E7EA887AC
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 17:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17DD33AFFA7
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 15:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650A52798FF;
	Mon, 14 Apr 2025 15:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0l+uGG6L"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AD22798E5;
	Mon, 14 Apr 2025 15:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744645405; cv=none; b=Q7oW4dMLfHLz0MxXBsiecHPDNUQvoTD7N8Cm2ur8yWIfr4vFr2ziFQi1On08LYNOAHAHORDPYBPFm8TpZ5fSnUtQRcolGl6kYq5bZrm5VLZ1+ltJEKa4yCn4cqczMj/pu861U0hyeLR7POu8gYt29zYAPjJDOx9g/3NoR8CPckA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744645405; c=relaxed/simple;
	bh=B5KZJPD2Ol/xPkllsKIrCK+2TfleyI75nZBYDMSJMCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FoqvlV70OAYNePkBYq36KNeUSXPuHR6jzyU1A0ysRHf0jsEBrVcfQXlvA/zrzrPM3qZldH4RVA8mYwAPhX1owgLHUrBPQROMWYSvO5GGq8kaTRaFR0uFQJTYoj/Muzi2OS7+FH+pX7kliNxANmnn7Rl/Fwb7N64m9lExxWlYuaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0l+uGG6L; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XKKz1Mm1pkCh0ixIzZHIXbDXcfT7TrB4EjgzGW2m2hI=; b=0l+uGG6LH6NZXT0UtwKd8Gt3Ex
	+omKHVWyNMTxImUtQfCMjuyK9Rj33fmTJSxVcNSYGVrmBGzUR2o4JAWFyTY7UGvWYHDBU4QEhM0BJ
	O15qkKn6lTlCh3ZTBiAph94LBvZjXUAbtRx26y34Wmkw2bPdnw87Ngg/wE2bdvmyKTqw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u4Lxm-009Dnl-0B; Mon, 14 Apr 2025 17:43:10 +0200
Date: Mon, 14 Apr 2025 17:43:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Fiona Klute <fiona.klute@gmx.de>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>,
	UNGLinuxDriver@microchip.com,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-list@raspberrypi.com
Subject: Re: [PATCH net] net: phy: microchip: force IRQ polling mode for
 lan88xx
Message-ID: <24541282-0564-4fb6-8bd1-430f6b1390b0@lunn.ch>
References: <20250414152634.2786447-1-fiona.klute@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414152634.2786447-1-fiona.klute@gmx.de>

On Mon, Apr 14, 2025 at 05:26:33PM +0200, Fiona Klute wrote:
> With lan88xx based devices the lan78xx driver can get stuck in an
> interrupt loop while bringing the device up, flooding the kernel log
> with messages like the following:
> 
> lan78xx 2-3:1.0 enp1s0u3: kevent 4 may have been dropped
> 
> Removing interrupt support from the lan88xx PHY driver forces the
> driver to use polling instead, which avoids the problem.
> 
> The issue has been observed with Raspberry Pi devices at least since
> 4.14 (see [1], bug report for their downstream kernel), as well as
> with Nvidia devices [2] in 2020, where disabling polling was the
> vendor-suggested workaround (together with the claim that phylib
> changes in 4.9 made the interrupt handling in lan78xx incompatible).
> 
> Iperf reports well over 900Mbits/sec per direction with client in
> --dualtest mode, so there does not seem to be a significant impact on
> throughput (lan88xx device connected via switch to the peer).
>
> [1] https://github.com/raspberrypi/linux/issues/2447
> [2] https://forums.developer.nvidia.com/t/jetson-xavier-and-lan7800-problem/142134/11
> 
> Link: https://lore.kernel.org/0901d90d-3f20-4a10-b680-9c978e04ddda@lunn.ch
> Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
> Cc: kernel-list@raspberrypi.com
> Cc: stable@vger.kernel.org

Thanks for submitting this. Two nit picks:

It needed a Fixes: tag. Probably:

Fixes: 792aec47d59d ("add microchip LAN88xx phy driver")

>  static int lan88xx_suspend(struct phy_device *phydev)
>  {
>  	struct lan88xx_priv *priv = phydev->priv;
> @@ -528,9 +487,6 @@ static struct phy_driver microchip_phy_driver[] = {
>  	.config_aneg	= lan88xx_config_aneg,
>  	.link_change_notify = lan88xx_link_change_notify,
>  
> -	.config_intr	= lan88xx_phy_config_intr,
> -	.handle_interrupt = lan88xx_handle_interrupt,
> -

Maybe add a comment somewhere around here that interrupts are broken,
so not supported. Developers frequently don't look at commit messages,
but are more likely to notice a comment.

Thanks
    Andrew

---
pw-bot: cr


