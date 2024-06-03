Return-Path: <netdev+bounces-100230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFCD8D8402
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 15:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CFE51C21BA3
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 13:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B354312D769;
	Mon,  3 Jun 2024 13:32:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F1212D1FA;
	Mon,  3 Jun 2024 13:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717421529; cv=none; b=c4/jIXYVhpoS+Eu5stzG53TJMtGNuxqFFucpLrzZWU01CZcd8SPs7c5B22vpUlP2F0Ih27rB0tdda6R600JZNS0fAYqO6oHh5VgAx3jgcYMp8WelPhrkC1h7puKa/WgVYB26GMDTRH0r7y/M6EzxGaa0aXMX+1tY9RM6QlWO5Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717421529; c=relaxed/simple;
	bh=i7qyliEW3tXAHVQUR36q8o9p80BoaaM8/W3VFHNn2Wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTg3c5bmGFsZcKZ5Jcs9if7Os55gMR8f7Mue9UOLLSSZwYnLbyCHXTeNQxDeT4nSTH5vj0L2I3PDhs9dNBoEAF7VikadId9qm2CHr0X3ZgbQpmdFXXLlMHGGgAuGGbIiZfJfBCDbvCSvdV+wVUHQeiRDzwjL2JJXghe5gWoHRRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.97.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1sE7mv-000000001SM-47uV;
	Mon, 03 Jun 2024 13:31:50 +0000
Date: Mon, 3 Jun 2024 14:31:46 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Sky Huang <SkyLake.Huang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Qingfang Deng <dqfext@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Steven Liu <Steven.Liu@mediatek.com>
Subject: Re: [PATCH net-next v6 5/5] net: phy: add driver for built-in 2.5G
 ethernet PHY on MT7988
Message-ID: <Zl3Fwoiv1bJlGaQZ@makrotopia.org>
References: <20240603121834.27433-1-SkyLake.Huang@mediatek.com>
 <20240603121834.27433-6-SkyLake.Huang@mediatek.com>
 <Zl3ELbG8c8y0/4DN@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zl3ELbG8c8y0/4DN@shell.armlinux.org.uk>

On Mon, Jun 03, 2024 at 02:25:01PM +0100, Russell King (Oracle) wrote:
> On Mon, Jun 03, 2024 at 08:18:34PM +0800, Sky Huang wrote:
> > Add support for internal 2.5Gphy on MT7988. This driver will load
> > necessary firmware, add appropriate time delay and figure out LED.
> > Also, certain control registers will be set to fix link-up issues.
> 
> Based on our previous discussion, it may be worth checking in the
> .config_init() method whether phydev->interface is one of the
> PHY interface modes that this PHY supports. As I understand from one
> of your previous emails, the possibilities are XGMII, USXGMII or
> INTERNAL. Thus:
> 
> > +static int mt798x_2p5ge_phy_config_init(struct phy_device *phydev)
> > +{
> > +	struct pinctrl *pinctrl;
> > +	int ret;
> 
> 	/* Check that the PHY interface type is compatible */
> 	if (phydev->interface != PHY_INTERFACE_MODE_INTERNAL &&
> 	    phydev->interface != PHY_INTERFACE_MODE_XGMII &&
> 	    phydev->interface != PHY_INTERFACE_MODE_USXGMII)
> 		return -ENODEV;

The PHY is built-into the SoC, and as such the connection type should
always be "internal". The PHY does not exist as dedicated IC, only
as built-in part of the MT7988 SoC.

