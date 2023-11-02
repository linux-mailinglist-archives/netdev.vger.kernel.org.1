Return-Path: <netdev+bounces-45766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B3E7DF707
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 16:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D11F128061E
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 15:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72631D529;
	Thu,  2 Nov 2023 15:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uFE0xkaq"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52F21D523;
	Thu,  2 Nov 2023 15:49:58 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3E3192;
	Thu,  2 Nov 2023 08:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1mL40+ExHNZuGaOB+rQdlmEOkODuu6jCTNDp6aVzkic=; b=uFE0xkaqy6iZ53No0pBhtodBPX
	h/9SjeSRIwhwfwJFnK07vJv5ibpiyHuCps5CLD9qlsDJVRzhq56OVCo28GXOkaI5GaNn3MrTy8Pf4
	lZzRMm+5Tvae5bkpZrVc/f1sqADUwinAG6Wi2EJamJvSu46rAh9ORfk+SmEvP7BnoB+Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qyZwg-000lND-68; Thu, 02 Nov 2023 16:49:22 +0100
Date: Thu, 2 Nov 2023 16:49:22 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Robert Marko <robimarko@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH v3 1/4] net: phy: aquantia: move to separate
 directory
Message-ID: <3af56cbe-dd9a-4747-b7a7-376367df6f79@lunn.ch>
References: <20231102150032.10740-1-ansuelsmth@gmail.com>
 <5f60b2dc-4e97-49dc-8427-306400fb1b71@lunn.ch>
 <6543bb3e.df0a0220.385df.cdb1@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6543bb3e.df0a0220.385df.cdb1@mx.google.com>

On Thu, Nov 02, 2023 at 04:07:41PM +0100, Christian Marangi wrote:
> On Thu, Nov 02, 2023 at 04:03:33PM +0100, Andrew Lunn wrote:
> > > diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
> > > index 421d2b62918f..4b2451dd6c45 100644
> > > --- a/drivers/net/phy/Kconfig
> > > +++ b/drivers/net/phy/Kconfig
> > > @@ -68,6 +68,8 @@ config SFP
> > >  
> > >  comment "MII PHY device drivers"
> > >  
> > > +source "drivers/net/phy/aquantia/Kconfig"
> > > +
> > >  config AMD_PHY
> > >  	tristate "AMD and Altima PHYs"
> > >  	help
> > > @@ -96,11 +98,6 @@ config ADIN1100_PHY
> > >  	  Currently supports the:
> > >  	  - ADIN1100 - Robust,Industrial, Low Power 10BASE-T1L Ethernet PHY
> > >  
> > > -config AQUANTIA_PHY
> > > -	tristate "Aquantia PHYs"
> > > -	help
> > > -	  Currently supports the Aquantia AQ1202, AQ2104, AQR105, AQR405
> > > -
> > 
> > Does this move the PHY in the make menuconfig menu? We try to keep it
> > sorted based on the tristate string.
> >
> 
> Oh wasn't aware... Yes it does move it to the top of the list... I can
> just move the source entry where AQUANTIA_PHY was...

Yes, that would be best.

Thanks

    Andrew

---
pw-bot: cr


