Return-Path: <netdev+bounces-215613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D80B2F8CD
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 14:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFDF5B63FE5
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 12:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B08E2EF662;
	Thu, 21 Aug 2025 12:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oPBDgy4w"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6022DC34C
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 12:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780515; cv=none; b=c+kZmo/MkR8mCzbKPR1ZeC/dX6WkjJq9COPeCf5ZdwhXEPOhD5enhnH1qa9fO6DcJPz/EW0n3xTb3q7wW10tVovJa5uBbahjj/8Hm9dxGX1R1ughhV5mMo2hYp616YZn7LRT9YPmr7keT2XsmY8ScwV5c+zuN9NJElXAz9Twwro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780515; c=relaxed/simple;
	bh=e5AxcMNFe2BmP6DgNRaFjmyz8146UxtEiz8JgyQYR5w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p9z2QTKCKM+LUhl9xJqKntsvD/YrhCnARNd83MkeHH2c78djjH6D1Yb7Tl/IRTKxJmUGK1PAcjB6LikBACUIFLMTFL4Ajvz12PuWErmqVbj7Cs3TMkYtYBNvd2TKUslNlzyzjiouIdKIxGG3aRISXzvpn+w94NnrIbA3GHWx+KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oPBDgy4w; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 092EE4E40B5C;
	Thu, 21 Aug 2025 12:48:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C5C6C60303;
	Thu, 21 Aug 2025 12:48:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C17B51C22C719;
	Thu, 21 Aug 2025 14:48:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1755780508; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=p8uUxuNsLfBmFT0zlKo0G7eW+/dKQR0Dj6mRGBqxQII=;
	b=oPBDgy4w0QUcLO4TwoWiFiQCaejSvwVTsMz91KWgY770lHRSAy+FtmThrUsMF9sWKZGgVX
	1ft1wk4m6FJ1RUO9ZV/lcLnzCVRqsS9TcRFkJ9FmN4kkJ7mFSbJxIPJmSTBKpDx2MQ+Ub6
	kloAf4CWZdQA9R/MNVbT1lSeBL6Cro6zep/6PiY7v3SGtARu6QakJxjorbXIUho2AaCD3y
	X/cQ5gLPrDPawtz0TZ+2DpDa+R0w0Exj/bamBj8Cnm+/HFo+KUQFqyAwwmyBhO8Zj2qvik
	RZm2KQJxZem+uOka/X4VQRHL57YEYsOVYKhoybDrUAYvWScSzaOhgnyuhRdQFQ==
Date: Thu, 21 Aug 2025 14:47:56 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Donald Hunter
 <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, Nishanth Menon
 <nm@ti.com>, kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
 linux-doc@vger.kernel.org, Michal Kubecek <mkubecek@suse.cz>, Roan van Dijk
 <roan@protonic.nl>
Subject: Re: [PATCH net-next v4 2/5] ethtool: netlink: add
 ETHTOOL_MSG_MSE_GET and wire up PHY MSE access
Message-ID: <20250821144756.7385b313@kmaincent-XPS-13-7390>
In-Reply-To: <aKbx1EoO0iWe2bMU@pengutronix.de>
References: <20250821091101.1979201-1-o.rempel@pengutronix.de>
	<20250821091101.1979201-3-o.rempel@pengutronix.de>
	<20250821115830.3a231885@kmaincent-XPS-13-7390>
	<aKbx1EoO0iWe2bMU@pengutronix.de>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Le Thu, 21 Aug 2025 12:15:48 +0200,
Oleksij Rempel <o.rempel@pengutronix.de> a =C3=A9crit :

> Hello Kory,
>=20
> On Thu, Aug 21, 2025 at 11:59:14AM +0200, Kory Maincent wrote:
> > Hello Oleksij,
> >=20
> > Le Thu, 21 Aug 2025 11:10:58 +0200,
> > Oleksij Rempel <o.rempel@pengutronix.de> a =C3=A9crit :
> >  =20
> > > Introduce the userspace entry point for PHY MSE diagnostics via
> > > ethtool netlink. This exposes the core API added previously and
> > > returns both configuration and one or more snapshots.
> > >=20
> > > Userspace sends ETHTOOL_MSG_MSE_GET with an optional channel
> > > selector. The reply carries:
> > >   - ETHTOOL_A_MSE_CONFIG: scale limits, timing, and supported
> > >     capability bitmask
> > >   - ETHTOOL_A_MSE_SNAPSHOT+: one or more snapshots, each tagged
> > >     with the selected channel
> > >=20
> > > If no channel is requested, the kernel returns snapshots for all
> > > supported selectors (per=E2=80=91channel if available, otherwise WORS=
T,
> > > otherwise LINK). Requests for unsupported selectors fail with
> > > -EOPNOTSUPP; link down returns -ENOLINK.
> > >=20
> > > Changes:
> > >   - YAML: add attribute sets (mse, mse-config, mse-snapshot) and
> > >     the mse-get operation
> > >   - UAPI (generated): add ETHTOOL_A_MSE_* enums and message IDs,
> > >     ETHTOOL_MSG_MSE_GET/REPLY
> > >   - ethtool core: add net/ethtool/mse.c implementing the request,
> > >     register genl op, and hook into ethnl dispatch
> > >   - docs: document MSE_GET in ethtool-netlink.rst
> > >=20
> > > The include/uapi/linux/ethtool_netlink_generated.h is generated
> > > from Documentation/netlink/specs/ethtool.yaml.
> > >=20
> > > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de> =20
> >=20
> > ...
> >  =20
> > > +MSE Configuration
> > > +-----------------
> > > +
> > > +This nested attribute contains the full configuration properties for=
 the
> > > MSE +measurements
> > > +
> > > +  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
  =3D=3D=3D=3D=3D=3D
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +  ETHTOOL_A_MSE_CONFIG_MAX_AVERAGE_MSE             u32     max avg_m=
se
> > > scale
> > > +  ETHTOOL_A_MSE_CONFIG_MAX_PEAK_MSE                u32     max peak_=
mse
> > > scale
> > > +  ETHTOOL_A_MSE_CONFIG_REFRESH_RATE_PS             u64     sample ra=
te
> > > (ps)
> > > +  ETHTOOL_A_MSE_CONFIG_NUM_SYMBOLS                 u64     symbols p=
er
> > > sample
> > > +  ETHTOOL_A_MSE_CONFIG_SUPPORTED_CAPS              bitset  capability
> > > bitmask
> > > +  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
  =3D=3D=3D=3D=3D=3D
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D + =20
> >=20
> > Why did you remove the kernel doc identifiers to phy_mse_config?
> > It was useful for the documentation.
> >  =20
> > > +MSE Snapshot
> > > +------------
> > > +
> > > +This nested attribute contains an atomic snapshot of MSE values for a
> > > specific +channel or for the link as a whole.
> > > +
> > > +  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
  =3D=3D=3D=3D=3D=3D
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +  ETHTOOL_A_MSE_SNAPSHOT_CHANNEL                   u32     channel e=
num
> > > value
> > > +  ETHTOOL_A_MSE_SNAPSHOT_AVERAGE_MSE               u32     average M=
SE
> > > value
> > > +  ETHTOOL_A_MSE_SNAPSHOT_PEAK_MSE                  u32     current p=
eak
> > > MSE
> > > +  ETHTOOL_A_MSE_SNAPSHOT_WORST_PEAK_MSE            u32     worst-case
> > > peak MSE
> > > +  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
  =3D=3D=3D=3D=3D=3D =20
> >=20
> > Same question here for phy_mse_snapshot. =20
>=20
> I had following warnings:
> Documentation/networking/ethtool-netlink:2499: ./include/linux/phy.h:3:
> WARNING: Duplicate C declaration, also defined at kapi:892. Declaration is
> '.. c:struct:: phy_mse_config'.
> Documentation/networking/ethtool-netlink:2515: ./include/linux/phy.h:3:
> WARNING: Duplicate C declaration, also defined at kapi:915. Declaration is
> '.. c:struct:: phy_mse_snapshot'
>=20
> I didn't found proper was to solve it, so I removed them.

Indeed kapi.rst is already referencing phy.h globally.
I don't know if there is a way to avoid this warning.

Else you could simply add something like that:
See ``struct phy_mse_config`` Kernel documentation defined in
``include/linux/phy.h``

Regards
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

