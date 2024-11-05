Return-Path: <netdev+bounces-141875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53ACB9BC968
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 10:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17E35281EC7
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 09:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B921CCED2;
	Tue,  5 Nov 2024 09:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="N/ciw9h6"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E5D18132A;
	Tue,  5 Nov 2024 09:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730799476; cv=none; b=UE48MG9Otw8hFPDr5FeiE6HiadqULfmMEZuOLwgdKtJi40a3ZRkYawCroj+elyYeiRUUKrYL0LG2xyRTpQsPEZxAXKu6G1IU6U6n+oLINwmHwAca17jTjwrRYxgbR0M0sUHZmG4Z2YFdZnjQrgbyRPh89sOisQ8+gB4ujwFYOfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730799476; c=relaxed/simple;
	bh=OPMyPZ/nN+s/36X28r03Byw7nSGvegOONAt4v90nVYA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m0GPcoECoznX6eUY72y4X2UUTWpUZLjGdSvTdZMR1UhzBs4Ouq+59QnlKwd34V03T0J68zjaBeCqtI56qvQTmdhO08KE51zUWCFpnMDTvdzq3ObrkB/Hs8f8OyBVUFZMJG8RCCPbIt8HxrsKZtADqhdK/NGs081c1hqLqScOpG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=N/ciw9h6; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 28C266000C;
	Tue,  5 Nov 2024 09:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730799471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VMZH9qjxYSsxGYOaVw8OePZ0Lknrw9sanV0iKJrFNwU=;
	b=N/ciw9h6pX84ScQNMrK/isvQ2TwTUFjte9wypoRRhw0Wyhskw5Ul9BMwrMZ9n8YhYel/gU
	1DwfodZTlMopWo6fZFXr3Hi4PV/33XZiAku+uSH06x2F3/pYr5n/gVzDsS+Fjv29PO3vur
	pqxj/Tv+cCAL1OiBAKveJmly1L+kKZclytc4B+8rWbv8hMTILi0L+VgHRCJ9tiwO090au/
	Lu2uRGLKaBoZE5497I+1v1F+viIS01EczaGmxln9llcqv/r/IRfuYxLo1MLP3DmMogbm+P
	Ue3aVmZX0jOGVTU4lOKSEs5a3Wd4m616cfL/Se4FiKVQzM46VBxu+iWJwOW/fg==
Date: Tue, 5 Nov 2024 10:37:49 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, Rob Herring
 <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman
 <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, Dent
 Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, Maxime
 Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH RFC net-next v2 07/18] net: ethtool: Add support for
 ethnl_info_init_ntf helper function
Message-ID: <20241105103749.0fe5a3a0@kmaincent-XPS-13-7390>
In-Reply-To: <3a2a2b15-cbda-45b5-ab09-8a783e9f48aa@lunn.ch>
References: <20241030-feature_poe_port_prio-v2-0-9559622ee47a@bootlin.com>
	<20241030-feature_poe_port_prio-v2-7-9559622ee47a@bootlin.com>
	<3a2a2b15-cbda-45b5-ab09-8a783e9f48aa@lunn.ch>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Thu, 31 Oct 2024 22:44:51 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> On Wed, Oct 30, 2024 at 05:53:09PM +0100, Kory Maincent wrote:
> > From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> >=20
> > Introduce support for the ethnl_info_init_ntf helper function to enable
> > initialization of ethtool notifications outside of the netlink.c file.
> > This change allows for more flexible notification handling.
> >=20
> > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> > ---
> >=20
> > changes in v2:
> > - new patch.
> > ---
> >  net/ethtool/netlink.c | 5 +++++
> >  net/ethtool/netlink.h | 2 ++
> >  2 files changed, 7 insertions(+)
> >=20
> > diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
> > index e3f0ef6b851b..808cc8096f93 100644
> > --- a/net/ethtool/netlink.c
> > +++ b/net/ethtool/netlink.c
> > @@ -805,6 +805,11 @@ static void ethnl_default_notify(struct net_device
> > *dev, unsigned int cmd, typedef void (*ethnl_notify_handler_t)(struct
> > net_device *dev, unsigned int cmd, const void *data);
> > =20
> > +void ethnl_info_init_ntf(struct genl_info *info, u8 cmd)
> > +{
> > +	genl_info_init_ntf(info, &ethtool_genl_family, cmd);
> > +}
> > + =20
>=20
> I've not looked at the users yet. Does this need EXPORT_SYMBOL_GPL()?

No it doesn't as the user is net/ethtool/pse-pd.c

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

