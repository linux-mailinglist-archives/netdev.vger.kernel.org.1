Return-Path: <netdev+bounces-127675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 755D297601F
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 06:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8CC91C21A61
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 04:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5FE7DA81;
	Thu, 12 Sep 2024 04:46:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A7964D
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 04:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726116400; cv=none; b=ApXdgWPY5mUfsBaR6I4MjvcIqp4AtHT1/xC6KyQQ9fWq03aA8EuXQVzdeh17bMqdQMNcp6cpXJ+HxJKp8n3LylTZ3EzA74Nvk2BEWv1LExGLsSAoTRA2TNTIejo1c2WzapOAfdZqzJg1DjqSfkf1nNfgYSeMsKtnUVIg/KGbZ20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726116400; c=relaxed/simple;
	bh=rDK4YjuaQg4NiLPMXjC8rO9M1iRf4vMaUlQViVoNIE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMBFgKVtvWDJvDmsMXgA88lT9iBJG5qf3lmcAvwonNtbH5p1G6ZGs4nXRW/XALN7Lw3WFxhUeGoycrfE/zKs2sXTFOxLH2L3IDrlq+gya7LrQy1EJGxC/o20JKpQslUf1dTzcX7/H/KR1qKK90KKQS6DM3aH1RIvpyT2OE/nalg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sobiy-0002gE-VJ; Thu, 12 Sep 2024 06:46:32 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sobiv-007IcP-F4; Thu, 12 Sep 2024 06:46:29 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sobiv-003i7R-14;
	Thu, 12 Sep 2024 06:46:29 +0200
Date: Thu, 12 Sep 2024 06:46:29 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
	=?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
Subject: Re: [PATCH net-next 5/7] net: phy: introduce ethtool_phy_ops to get
 and set phy configuration
Message-ID: <ZuJyJT-HgXJFe5ul@pengutronix.de>
References: <20240911212713.2178943-1-maxime.chevallier@bootlin.com>
 <20240911212713.2178943-6-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240911212713.2178943-6-maxime.chevallier@bootlin.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Maxime,

On Wed, Sep 11, 2024 at 11:27:09PM +0200, Maxime Chevallier wrote:
...
>  
> +/**
> + * struct phy_device_config - General PHY device configuration parameters for
> + * status reporting and bulk configuration
> + *
> + * A structure containing generic PHY device information, allowing to expose
> + * internal status to userspace, and perform PHY configuration in a controlled
> + * manner.
> + *
> + * @isolate: The MII-side isolation status of the PHY
> + * @loopback: The loopback state of the PHY
> + */
> +struct phy_device_config {
> +	bool isolate;
> +	bool loopback;
> +};
 
I would recommend to have loopback enum. There are different levels of
loopback:
https://www.ti.com/document-viewer/DP83TD510E/datasheet#GUID-50834313-DEF1-42FB-BA00-9B0902B2D7E4/TITLE-SNLS656SNLS5055224

I imagine something like this:

/*
 * enum phy_loopback_mode - PHY loopback modes
 * These modes represent different loopback configurations to
 * facilitate in-circuit testing of the PHY's digital and analog paths.
 */
enum phy_loopback_mode {
	PHY_LOOPBACK_NONE = 0,		/* No loopback mode enabled */
	PHY_LOOPBACK_MII,		/* MII Loopback: MAC to PHY internal loopback */
	PHY_LOOPBACK_PCS,		/* PCS Loopback: PCS layer loopback, no signal processing */
	PHY_LOOPBACK_DIGITAL,		/* Digital Loopback: Loops back entire digital TX/RX path */
	PHY_LOOPBACK_ANALOG,		/* Analog Loopback: Loops back after analog front-end */
	PHY_LOOPBACK_FAR_END		/* Far-End (Reverse) Loopback: Receiver to MAC interface loopback */
};

At same time, one interface will have multiple loopback providers, except of
multiple PHYs, MAC will provide it too.

I assume, we need a bit field per component to reflect supported loopback modes.

If you have time, please take a look at net/core/selftests.c this will be
one of consumers which should walk over different loopback levels to find the
location of potential problem.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

