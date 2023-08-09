Return-Path: <netdev+bounces-26090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 277A8776C5F
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 00:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 076841C2140C
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 22:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702A51DA30;
	Wed,  9 Aug 2023 22:41:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F279319BC6
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 22:41:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 302FFC433C9;
	Wed,  9 Aug 2023 22:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691620882;
	bh=/d1h3zZdC6MBhAEh+GJVInwucUuyQ5T2ZQZZuMkxqCk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mNK/5yrzWPZbtBopAaQwEplQwHvLCp5gPaD2U8w4QGRkGVzR2ryRUmmZDtrkiufi0
	 820aXUnNThl1pN+hmBDHGmDpqGqaRJK/FpDV63gbYdxTtiKgcWwdtRHCl+UXMZsgmA
	 y/CFsGmyjcI/cO5Vqwgg/KBcDLgb7v0tSQArZlQTK+4rxuFObt3VpMYkpprKfI6ap4
	 v8NTBlzl02vVCuNOnH9ZjCmBBVT0n0b8yWuHOMhq1oqOGbilbxUVI9PysCAzAWsuzi
	 vdPTkwrGwQ/JCNYJkB81lsTnEWJSRPsSPm4+Ca4fow/dh77jmiilBiqz8cU0Jv5/ZO
	 VA7iLBJSd3cNA==
Date: Wed, 9 Aug 2023 15:41:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 <nicolas.ferre@microchip.com>, <claudiu.beznea@microchip.com>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <robert.hancock@calian.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <git@amd.com>
Subject: Re: [PATCH net] net: macb: In ZynqMP resume always configure PS GTR
 for non-wakeup source
Message-ID: <20230809154121.673ec04b@kernel.org>
In-Reply-To: <1691414091-2260697-1-git-send-email-radhey.shyam.pandey@amd.com>
References: <1691414091-2260697-1-git-send-email-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Aug 2023 18:44:51 +0530 Radhey Shyam Pandey wrote:
> On Zynq UltraScale+ MPSoC ubuntu platform when systemctl issues suspend,
> network manager bring down the interface and goes into suspend. When it
> wakes up it again enables the interface.
> 
> This leads to xilinx-psgtr "PLL lock timeout" on interface bringup, as
> the power management controller power down the entire FPD (including
> SERDES) if none of the FPD devices are in use and serdes is not
> initialized on resume.
> 
> $ sudo rtcwake -m no -s 120 -v
> $ sudo systemctl suspend  <this does ifconfig eth1 down>
> $ ifconfig eth1 up
> xilinx-psgtr fd400000.phy: lane 0 (type 10, protocol 5): PLL lock timeout
> phy phy-fd400000.phy.0: phy poweron failed --> -110
> 
> macb driver is called in this way:
> 1. macb_close: Stop network interface. In this function, it
>    reset MACB IP and disables PHY and network interface.
> 
> 2. macb_suspend: It is called in kernel suspend flow. But because
>    network interface has been disabled(netif_running(ndev) is
>    false), it does nothing and returns directly;
> 
> 3. System goes into suspend state. Some time later, system is
>    waken up by RTC wakeup device;
> 
> 4. macb_resume: It does nothing because network interface has
>    been disabled;
> 
> 5. macb_open: It is called to enable network interface again. ethernet
>    interface is initialized in this API but serdes which is power-off
>    by PMUFW during FPD-off suspend is not initialized again and so
>    we hit GT PLL lock issue on open.
> 
> To resolve this PLL timeout issue always do PS GTR initialization
> when ethernet device is configured as non-wakeup source.
> 
> Fixes: f22bd29ba19a ("net: macb: Fix ZynqMP SGMII non-wakeup source resume failure")
> Fixes: 8b73fa3ae02b ("net: macb: Added ZynqMP-specific initialization")
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>

Could be more of a PHY than MAC question. Adding remaining PHY
maintainers to CC.

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index f6a0f12a6d52..82929ee76739 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -5194,6 +5194,9 @@ static int __maybe_unused macb_suspend(struct device *dev)
>  	unsigned int q;
>  	int err;
>  
> +	if (!device_may_wakeup(&bp->dev->dev))
> +		phy_exit(bp->sgmii_phy);
> +
>  	if (!netif_running(netdev))
>  		return 0;
>  
> @@ -5254,7 +5257,6 @@ static int __maybe_unused macb_suspend(struct device *dev)
>  	if (!(bp->wol & MACB_WOL_ENABLED)) {
>  		rtnl_lock();
>  		phylink_stop(bp->phylink);
> -		phy_exit(bp->sgmii_phy);
>  		rtnl_unlock();
>  		spin_lock_irqsave(&bp->lock, flags);
>  		macb_reset_hw(bp);
> @@ -5284,6 +5286,9 @@ static int __maybe_unused macb_resume(struct device *dev)
>  	unsigned int q;
>  	int err;
>  
> +	if (!device_may_wakeup(&bp->dev->dev))
> +		phy_init(bp->sgmii_phy);
> +
>  	if (!netif_running(netdev))
>  		return 0;
>  
> @@ -5344,8 +5349,6 @@ static int __maybe_unused macb_resume(struct device *dev)
>  	macb_set_rx_mode(netdev);
>  	macb_restore_features(bp);
>  	rtnl_lock();
> -	if (!device_may_wakeup(&bp->dev->dev))
> -		phy_init(bp->sgmii_phy);
>  
>  	phylink_start(bp->phylink);
>  	rtnl_unlock();


