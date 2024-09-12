Return-Path: <netdev+bounces-127739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CAD976434
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 10:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4952128374E
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 08:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31B718F2DA;
	Thu, 12 Sep 2024 08:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NFBW+g2V"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB6B17BA1;
	Thu, 12 Sep 2024 08:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726129051; cv=none; b=rTUp2xemQ2gu4EQZyn2IwKH03/te1+ek3dzNLVvr8HwOvr+B5ZFKsH9HFamfmwuzifXlvSPQDntlf0Kkk3cTOhEC0F3Op9Glr46KqsR6WKnMm9FfThHcrZkchUSjF4K7LSnoBEoODxE7a6EK2LSvjE12V952gDCqlJ13ohI9dQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726129051; c=relaxed/simple;
	bh=7BpITQX6khmdM16MtxZky2qxPd/ffcH9bYbjvDcC4r8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nt6Ek7bkB88IpGXShsXx4MGt61giJiXOA0wO8Igas07mxeCoyyQwFQPJgYHyXmQlxbWB7m8ZDlh1VXBqoOe4pgttPJteuAMXeANUS0W8CgCD24VLh7rbo8NURpKemI0ZRnaqD4kfcOMrFPhDZyoHnmwnwsCOoktsAdr1G8QxH5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NFBW+g2V; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 882A3C000F;
	Thu, 12 Sep 2024 08:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726129047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IJZp6x9VX7axuaNfrvvZ3iXuDDQ2g5dIWMn+g8OKNvw=;
	b=NFBW+g2VuFofFDN1sfjx90QeR7elqq/RJfMmaiO4AGUuxz/GnPBoaebA89+zIkI512P2G3
	hJ5g31chcW+FPgUZ/Stt1Cw2iVD38Z82KteGl0/FgZSIaCWlYj6iX/nEpLvIjXJ6F6zV1X
	wf+gkkus0DpYuwhYoBXBICquhPzzM96WMXkIsFf6me3yI6sTdcghoRYtX0Az+vqR8SNGqI
	Why50E6xie2Shp3XQn/Z9g7T0ovTomuUaTKyFQtRYe7qamjhAIYagxX87ks5PpgqyGM0Z+
	9tD7GWXLdVZ/Gxk8GtnVbc13CnzdS9s3DeB4MlsBB/j+6/pRL8x6R65K+GLJkw==
Date: Thu, 12 Sep 2024 10:17:24 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn
 <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Herve Codina
 <herve.codina@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, Heiner
 Kallweit <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>, =?UTF-8?B?S8O2cnk=?=
 Maincent <kory.maincent@bootlin.com>
Subject: Re: [PATCH net-next 5/7] net: phy: introduce ethtool_phy_ops to get
 and set phy configuration
Message-ID: <20240912101724.6233b1e4@fedora.home>
In-Reply-To: <ZuJyJT-HgXJFe5ul@pengutronix.de>
References: <20240911212713.2178943-1-maxime.chevallier@bootlin.com>
	<20240911212713.2178943-6-maxime.chevallier@bootlin.com>
	<ZuJyJT-HgXJFe5ul@pengutronix.de>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Oleksij,

On Thu, 12 Sep 2024 06:46:29 +0200
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> Hi Maxime,
> 
> On Wed, Sep 11, 2024 at 11:27:09PM +0200, Maxime Chevallier wrote:
> ...
> >  
> > +/**
> > + * struct phy_device_config - General PHY device configuration parameters for
> > + * status reporting and bulk configuration
> > + *
> > + * A structure containing generic PHY device information, allowing to expose
> > + * internal status to userspace, and perform PHY configuration in a controlled
> > + * manner.
> > + *
> > + * @isolate: The MII-side isolation status of the PHY
> > + * @loopback: The loopback state of the PHY
> > + */
> > +struct phy_device_config {
> > +	bool isolate;
> > +	bool loopback;
> > +};  
>  
> I would recommend to have loopback enum. There are different levels of
> loopback:
> https://www.ti.com/document-viewer/DP83TD510E/datasheet#GUID-50834313-DEF1-42FB-BA00-9B0902B2D7E4/TITLE-SNLS656SNLS5055224
> 
> I imagine something like this:
> 
> /*
>  * enum phy_loopback_mode - PHY loopback modes
>  * These modes represent different loopback configurations to
>  * facilitate in-circuit testing of the PHY's digital and analog paths.
>  */
> enum phy_loopback_mode {
> 	PHY_LOOPBACK_NONE = 0,		/* No loopback mode enabled */
> 	PHY_LOOPBACK_MII,		/* MII Loopback: MAC to PHY internal loopback */
> 	PHY_LOOPBACK_PCS,		/* PCS Loopback: PCS layer loopback, no signal processing */
> 	PHY_LOOPBACK_DIGITAL,		/* Digital Loopback: Loops back entire digital TX/RX path */
> 	PHY_LOOPBACK_ANALOG,		/* Analog Loopback: Loops back after analog front-end */
> 	PHY_LOOPBACK_FAR_END		/* Far-End (Reverse) Loopback: Receiver to MAC interface loopback */
> };

I agree with you on that, having the ability to fine-tune where the
loopback happens is really useful for debug. The main problem I would
see is to come-up with a set of modes that are somewhat generic, as
vendors implement a wide variety of loopback modes.

For example, on BaseT4 PHYs the Analog loopback doesn't exist and is
more akin to using a loopback stub, whereas the Digital loopback would
be a loopback at the PMD level (I don't know if that even exists).

That being said, the list of possible places to setup the loopback
within a PHY is finite and it's conceivable to come-up with a set of
loopback modes.

Thanks a lot for the feedback,

Maxime

