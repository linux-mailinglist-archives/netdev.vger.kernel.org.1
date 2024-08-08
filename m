Return-Path: <netdev+bounces-116872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9B094BE91
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 15:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DE8528787E
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 13:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E428418DF6B;
	Thu,  8 Aug 2024 13:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="tAAQ/Ddb"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E8818C93D;
	Thu,  8 Aug 2024 13:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723124001; cv=none; b=IVlqW3ZVbzLq6h3VP3cgejOAWlrnP8offVDkp1OyvlyYfR7hnhhMPSUbH6BKBKAARjcFb6oQNO1/+id/q2zZBT60TqTVip04IjqzbG1sxvYyblOg7KLBj3MF6kUGqWqFsyTD9KPEf6WzcJeaLYJqH8iAYymQVAyXQpNe+wyjCPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723124001; c=relaxed/simple;
	bh=wmnKxVbPzikDzNZAIz/2FVFzEcuItdiV4rmSo58RfBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YgBDW0ofCVRoakGeOCaCMOjpVcqvz8nsVo3M3ClqGG8WXjMRuXyshzxuj9aNDBaPam4S7SSuV1y/6ZVFCFEdNhBzX6VWFiUP2SivyfTQ6H1aJ/0C3vyx4O+ykFlTE0fVw4dexbu3R8L3Kq4IhjtX4uP0J2W3tC4lGA1lwWVmEys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=tAAQ/Ddb; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=d5pOPLfYnkE7sSVybeZDehAOrf2KFe2CyLtqXeXS1ko=; b=tAAQ/DdbFu7eGZtaqiqvMg+nA7
	oMyYSB3Y73iGzm9V79Istt7eAhULfVHyixQcFWkfDebujtt9b63QsxOlfLJmwY4tZI+EOZ/6B7EkU
	IEs71RPo8surOMF0pTRfbF9HXbjvjIm95hkELHhoEVYPnqdlNiZXWE+Sj1uMOshmTt3H4PkMnSXM5
	ZhY99wntkDQGELzS67a1vJxcyuc1kh6v//ssDUGJXzgu7EuXV+wAHOf4YnPoN08SHFEjFdreC0Zkz
	kjM9bSShH/em4stz1gznakn+QtCbc8RmbADV9j44yWOeubSGu7GgKzmbpDBrHuTbG11lzU92CjRRt
	JI3ZHQHg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45304)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sc3GJ-0001QP-1S;
	Thu, 08 Aug 2024 14:33:03 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sc3GN-0005Eg-0K; Thu, 08 Aug 2024 14:33:07 +0100
Date: Thu, 8 Aug 2024 14:33:06 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/3] phy: Add Open Alliance helpers for the
 PHY framework
Message-ID: <ZrTJErF23yDpQunx@shell.armlinux.org.uk>
References: <20240808130833.2083875-1-o.rempel@pengutronix.de>
 <20240808130833.2083875-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808130833.2083875-2-o.rempel@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Aug 08, 2024 at 03:08:32PM +0200, Oleksij Rempel wrote:
> Introduce helper functions specific to Open Alliance diagnostics,
> integrating them into the PHY framework. Currently, these helpers
> are limited to 1000BaseT1 specific TDR functionality.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/net/phy/Makefile                |  2 +-
>  drivers/net/phy/open_alliance_helpers.c | 70 +++++++++++++++++++++++++
>  include/linux/open_alliance_helpers.h   | 47 +++++++++++++++++
>  3 files changed, 118 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/phy/open_alliance_helpers.c
>  create mode 100644 include/linux/open_alliance_helpers.h
> 
> diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
> index 202ed7f450da6..8a46a04af01a5 100644
> --- a/drivers/net/phy/Makefile
> +++ b/drivers/net/phy/Makefile
> @@ -2,7 +2,7 @@
>  # Makefile for Linux PHY drivers
>  
>  libphy-y			:= phy.o phy-c45.o phy-core.o phy_device.o \
> -				   linkmode.o
> +				   linkmode.o open_alliance_helpers.o

Given that most PHY drivers aren't open alliance, would it be better
to have a config symbol that can be selected by PHY drivers that need
it?

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

