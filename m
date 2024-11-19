Return-Path: <netdev+bounces-146204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E03D9D23F0
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 11:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7D9AB23D21
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 10:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02C91C68AA;
	Tue, 19 Nov 2024 10:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="g7jWs5Et"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C569B1C302C
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 10:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732013504; cv=none; b=ZYpJKMvTkSYpjj/inq5xynfB1wqbMz8UeTIseOzHKZqADOm+3QBzIxG9b3RqDwt/gSEEiZjxfjbopLyYIwLue3pWXdI2Hc9afS9Lj6ZGaVGCOjuE9hrE9RNI5ZqyCFIbHQpVZ+JZe6yTtts5LP3duHFOC0NIS4aGMTf2LXXCtWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732013504; c=relaxed/simple;
	bh=7iL1XS475ANJ2Yig/uM16IfiHC6nZNBpriUUEEf5IgI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=hM5dYumEnZEbnzGkNYl5LsRN0loMf3I/WukpX8b0XVF/1gjdcO87ZSJbqzsUE1Tz9/Ctt+Y5CQUImMLRmeEWsU/ihGAVBC7ak6O7Ipl0Sf+lkfN8r/nF81AqTrmcMqfjxmq9MPoCu4oTnis3x/uE3uIYDpfrnA9zunoD+ggefVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=g7jWs5Et; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9C76940003;
	Tue, 19 Nov 2024 10:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732013498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tcr9GVLPIzHgr8P8T++QvQfJBYgYKFJrLFexketQXq4=;
	b=g7jWs5EtUS++GXlmfLzywF7nz5JhWsOasBSkGYK0rRCtTyR21KyicwTcg+ivdkWjT85Tgu
	CySW9fW/sQX/zQVCYtmDEC2H73RITriFFRfMm9MK1kQZkUcsvDdWAK0gGKxvhGq5ildXkH
	OG+Qb7cWyUlE/cpE/Zn7i1be/6N4WTCPMP2LcsRdvMpolx4e2ye0hx52yZrCHQPYFNpKVD
	gKangt9C8OTjX3TemmJuwM+HV4JiCspt5d7iPHJI95rFyeCxcJv56E/7VXosSDAC7KnlP4
	XEguQ7o17QSH41hZ38GXiJt3wfViEFM1bFmYzTQ9kCMOby3JXf6TLX0lDbV00g==
Date: Tue, 19 Nov 2024 11:51:36 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>,
 Russell King <linux@armlinux.org.uk>, Romain Gantois
 <romain.gantois@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Oleksij Rempel <o.rempel@pengutronix.de>, Kory
 Maincent <kory.maincent@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Moving forward with stacked PHYs
Message-ID: <20241119115136.74297db7@fedora.home>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Netdev,

With Romain, we're currently trying to work on the stacked PHY problem,
where we'd like to get a proper support for Copper SFPs that are driven
by a media converter :

     RGMII       SGMII  +sfp----+
MAC ------- PHY ------- | PHY   |
                        +-------+

This is one of the cases where we have multiple PHYs on the link, on my
side I've been working on PHY muxes with parallel PHYs on the link :


       +-- PHY
MAC ---|
       +-- PHY
      =20
Both of these use-cases share one common issue, which is that some parts
of the kernel will try to directly access netdev->phydev, assuming there's
one and only PHY device that sits behind a MAC.

In the past months, I've worked on introducing the phy_link_topology, that
keeps track of all the PHYs that are sitting behind a netdev, and I've
used that infrastructure for some netlink commands that would access
the netdev->phydev field and replace that with :
  - A way to list the PHYs behind a netdev
  - Allowing netlink commands to target a specific PHY, and not "just"
    the netdev->phydev PHY.
   =20
On that front, there's more work coming to improve on that :
  - It would be good if the stats reported through ethtool would account
    for all the PHYs on the link, so that we would get a full overview
    of all stats from all components of the link
  - A netlink notification to indicate that a new PHY was found on the
    link is also in the plans.
   =20
There's a lot more work to do however, as these user-facing commands aren't
the only place where netdev->phydev is used.

The first place are the MAC drivers. For this, there seems to be 2 options :

 - move to phylink. The phylink API is pretty well designed as it makes
   the phydev totally irrelevant for the MAC driver. The MAC driver doesn't
   even need to know if it's connected to a PHY or something else (and SFP
   cage for example). That's nice, but there are still plenty of drivers
   that don't use phylink.
  =20
 - Introduce a new set of helpers that would abstact away the phydev from
   the netdev, but in a more straightforward way. MAC drivers that directly
   access netdev->phydev to configure the PHY's internal state or get some
   PHY info would instead be converted to using a set of helpers that will
   take the netdev as a parameter :
  =20
 static void ftgmac100_adjust_link(struct net_device *netdev)
 {
+	int phy_link, phy_speed, phy_duplex;
 	struct ftgmac100 *priv =3D netdev_priv(netdev);
 	struct phy_device *phydev =3D netdev->phydev;
 	bool tx_pause, rx_pause;
 	int new_speed;
=20
+	netdev_phy_link_settings(netdev, &phy_link, &phy_speed, &phy_duplex);
+
 	/* We store "no link" as speed 0 */
-	if (!phydev->link)
+	if (!phy_link)
 		new_speed =3D 0;
 	else
-		new_speed =3D phydev->speed;
+		new_speed =3D phy_speed;
[...]

   The above is just an example of such helpers, Romain is currently
   investigating this and going over all the MAC drivers out there to
   assess to what extent they are directly accessing the netdev->phydev,
   and wrapping that with phydev-independent helpers.

   The idea here is to avoid accessing phydev directly from the MAC
   driver, and have a helper query the parameters for us. This helper
   could make use of netdev->phydev, but also use phy_link_topology
   to get an aggregated version of these parameters, if there are chained
   PHYs for example.
  =20
There are other parts of the kernel that accesses the netdev->phydev. There
are a few places in DSA where this is done, but the same helpers as the ones
introduced for MAC drivers could be used. The other remaining part would
be the Timestamping code, but K=C3=B6ry Maincent is currently working on an
series to help deal with the various timestamping sources, that will also
help on removing this strong netdev->phydev dependency.
  =20
Finally, there's the whole work of actually configuring the PHY themselves
correctly when they are chained to one another, and getting the logic right
for the link-up/down detection, getting the ksettings values aggregated
correctly, etc.

We have some local patches as well for that, to handle the stacked PHY
state-machine synchronisation, link-reporting and negociation but
it's still WIP to cover all the corner-cases and hard-to-test features, for
example how to deal with WoL or EEE in these situations.

Please don't hesitate to give any comments, remarks or point some shortcomi=
ngs
if you see any. We've tried to keep this mail short but we'll be happy to
discuss any details. We're really looking for some feedback on that overall
approach before sending any RFC, but of course if you prefer to discuss over
some actual code we can move forward and send RFC code when it's a bit more
polished.

Thanks a lot,

Maxime Chevallier & Romain Gantois

