Return-Path: <netdev+bounces-133563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A76996460
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 11:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29EF9B21BD4
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 09:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E3F188714;
	Wed,  9 Oct 2024 09:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="gVFXMVlk"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5527117C22B;
	Wed,  9 Oct 2024 09:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728464663; cv=none; b=jaohQj/2lL+2ssiiywZyuiE6b7MxG2ZXbfUIFpSea5NeUurWK4u/a+LXKZl9B1V1rLiPNjmGe1oC4KtWc7WxkHd9DFih/5kY6VD/8cBCLx5Wms6XuNbHNRLR45m+wWcXcfiXkUxrbgd0VEdWFvXUXqYzymAprCUrSx6Q/I4S4tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728464663; c=relaxed/simple;
	bh=b7RJRJVgA89EWJjISnYqjjufULQlbCh9Igo5Ve3Av1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJ5DjXOsByZck3eu1ZTvyt+KhPChi3GAJGr1rscGEAjsFIyHPY7kOKpXnjc2eJF9ItXnSWSPIyZOaYFMOc5gap8w7NthhLM/Na0KlKpZx7O/hUJzaeRD9E5m95r+ZVNcZrJo7K/sqAOLT8YOOGlV7cWMjT7kcpRzrk0PfYfYU6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=gVFXMVlk; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=c8bp6/c7buf8wyfEKQc0rCpuGOfc8jy1CqBEMoOnPYM=; b=gVFXMVlkYWewi9O1/PZcq/2riG
	Xoy59hwqrTIRFBSYt5f9GXci0g/XZuf/B6+LHDbpJkm3+tu3ULnvjMV0+4RxpguAfezNTe551r86n
	xseHlKK3elKKsCYKWur3/fIESltF4mwYuGkFGY0a4XFx3+m/mdX2fZRRszF0rbKY+ahUOyM31WHEo
	1IyWPjORsSjQllWpkQa1BV3L374KmwkYxfg2SdtnPSSS9pp9zD3qUJS+ToF/+wbr3F/VSFy9F3odv
	4lCPQYuVCbg3XS3NdOXTKErA4qdoyj86BSwxz6prdiFdLAnTgPKvyxFR0un1BtTVsGQ8xos7n9tR4
	8oTzequQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40144)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sySc1-0000Eg-34;
	Wed, 09 Oct 2024 10:04:05 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sySbx-00069g-31;
	Wed, 09 Oct 2024 10:04:01 +0100
Date: Wed, 9 Oct 2024 10:04:01 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, andrew@lunn.ch, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	git@amd.com
Subject: Re: [RFC PATCH net-next 3/5] net: macb: Update USX_CONTROL reg's
 bitfields and constants.
Message-ID: <ZwZHAZrqLY1EBRHM@shell.armlinux.org.uk>
References: <20241009053946.3198805-1-vineeth.karumanchi@amd.com>
 <20241009053946.3198805-4-vineeth.karumanchi@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009053946.3198805-4-vineeth.karumanchi@amd.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Oct 09, 2024 at 11:09:44AM +0530, Vineeth Karumanchi wrote:
> New bitfeilds of USX_CONTROL register:
> - GEM_RX_SYNC: RX Reset: Reset the receive datapath.
> 
> Constants of the bitfeilds in USX_CONTROL reg:
> - HS_SPEED_*: Multiple speed constants of USX_SPEED bitfeild.
> - MACB_SERDES_RATE_*: Multiple serdes rate constants of
>   SERDES_RATE bitfeild.
> 
> Since MACB_SERDES_RATE_* and HS_SPEED_* are register constants,
> move them to the header file.
> 
> Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>

...

> +/* Constants for USX_CONTROL */
> +#define HS_SPEED_10000M				4
> +#define HS_SPEED_5000M				3
> +#define HS_SPEED_2500M				2
> +#define HS_SPEED_1000M				1
> +#define MACB_SERDES_RATE_10G			1
> +#define MACB_SERDES_RATE_5G			0
> +#define MACB_SERDES_RATE_2_5G			0
> +#define MACB_SERDES_RATE_1G			0

I'm not sure having multiple definitions for the same value for the same
field makes sense. Maybe call it MACB_SERDES_RATE_5G_2G5_1G ?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

