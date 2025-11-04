Return-Path: <netdev+bounces-235481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B161C31427
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 14:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8F72534B5F0
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 13:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BE6328615;
	Tue,  4 Nov 2025 13:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VlCMZErw"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AE925F99B
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 13:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762263552; cv=none; b=WrAMg6VoAoLTzyLbX59EgJInX1Xxtm31l24vfVekrwC47WEjlNVC/1lUu9v8ovP8xrDkoeC94aqyhIWXgMxPAJaWifmcaSqV/o0uk22V/vhaOn5/lBpzmd6KQgXdeQt/DgnoIcwO5z2Uz3v4eX1nd6AiYC4LrZScFEBT+w+bMYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762263552; c=relaxed/simple;
	bh=Z5TUtg9UvRYzNmCTzjmBRczD9vQcGnjKZ5Z3oJsnIgU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gie2BegY3OgW1anYL/tfXq2FM7Kmlubsx4tbI1y7INT87UKJIFRwRKV1KS6bzOR+m2yL5ZesuCpFcqdiOh6R77Qozer6ezpplroRrYT7EjEkiYLr9zDUAqW5iYt9nXjp4BafNFBsqLjM1il6Ucdkhs2i+ei14PPeMw5TlzHKeFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VlCMZErw; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 260A21A187C;
	Tue,  4 Nov 2025 13:39:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EEC4F606EF;
	Tue,  4 Nov 2025 13:39:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 338D910B50B4C;
	Tue,  4 Nov 2025 14:39:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762263546; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=5j38NInPoXhubX4VCSTV77Fcr9qWRuwFzbATxMEPohM=;
	b=VlCMZErwGtvQ+T07A8cDPkDAiKESAoZ+shruxfHG8i+ZZlrIl3d3BC1yVVrXaJGT/aGqdA
	5qpRgAUTEhqsBZs6sSlx6ESN/iQhU/ZUMfDIgl5HO0dFgrWWZo7NdifUXFt1HDELMIQHQx
	CHxK6Sdi8+eXhQ/hbbhdopov827bHXId++ckMrO8mypB5oqiq6As4iKkq4zRcB93n5vmcf
	rTsu2A/iLcu1G0H/Jeq0cFMNIpu9cBCCdJxCGSmw79fob7BIqiyoNuwVE6/kpEDKCVuI+y
	xaVLiON0gZd0D0P7AaDYsQnQAUCa5Dwf1sN0y9lQSOA2Z84XGiXzjVPukaWWvw==
Date: Tue, 4 Nov 2025 14:39:01 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net-next v2] ti: netcp: convert to ndo_hwtstamp
 callbacks
Message-ID: <20251104143901.5f030fa9@kmaincent-XPS-13-7390>
In-Reply-To: <afbddc5a-c051-4e45-9d4f-79d4543f6529@linux.dev>
References: <20251103172902.3538392-1-vadim.fedorenko@linux.dev>
	<20251103215240.7057f8cb@kmaincent-XPS-13-7390>
	<afbddc5a-c051-4e45-9d4f-79d4543f6529@linux.dev>
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

On Tue, 4 Nov 2025 12:15:32 +0000
Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:

> On 03/11/2025 20:52, Kory Maincent wrote:
> > On Mon,  3 Nov 2025 17:29:02 +0000
> > Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:
> >  =20
> >> Convert TI NetCP driver to use ndo_hwtstamp_get()/ndo_hwtstamp_set()
> >> callbacks. The logic is slightly changed, because I believe the origin=
al
> >> logic was not really correct. Config reading part is using the very
> >> first module to get the configuration instead of iterating over all of
> >> them and keep the last one as the configuration is supposed to be iden=
tical
> >> for all modules. HW timestamp config set path is now trying to configu=
re
> >> all modules, but in case of error from one module it adds extack
> >> message. This way the configuration will be as synchronized as possibl=
e.
> >>
> >> There are only 2 modules using netcp core infrastructure, and both use
> >> the very same function to configure HW timestamping, so no actual
> >> difference in behavior is expected.
> >>
> >> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> >> ---
> >> v1 -> v2:
> >> - avoid changing logic and hiding errors. keep the call failing after
> >>    the first error
> >> --- =20
> >=20
> > ...
> >  =20
> >> +
> >> +	for_each_module(netcp, intf_modpriv) {
> >> +		module =3D intf_modpriv->netcp_module;
> >> +		if (!module->hwtstamp_set)
> >> +			continue;
> >> +
> >> +		err =3D module->hwtstamp_set(intf_modpriv->module_priv,
> >> config,
> >> +					   extack);
> >> +		if ((err < 0) && (err !=3D -EOPNOTSUPP)) {
> >> +			NL_SET_ERR_MSG_WEAK_MOD(extack,
> >> +						"At least one module
> >> failed to setup HW timestamps");
> >> +			ret =3D err;
> >> +			goto out; =20
> >=20
> > Why don't you use break. =20
>=20
> That's the original code, I tried to make as less changes as possible
>=20
> >  =20
> >> +		}
> >> +		if (err =3D=3D 0)
> >> +			ret =3D err;
> >> +	}
> >> +
> >> +out:
> >> +	return (ret =3D=3D 0) ? 0 : err;
> >> +}
> >> + =20
> >=20
> > ...
> >  =20
> >> -static int gbe_hwtstamp_set(struct gbe_intf *gbe_intf, struct ifreq *=
ifr)
> >> +static int gbe_hwtstamp_set(void *intf_priv, struct kernel_hwtstamp_c=
onfig
> >> *cfg,
> >> +			    struct netlink_ext_ack *extack)
> >>   {
> >> -	struct gbe_priv *gbe_dev =3D gbe_intf->gbe_dev;
> >> -	struct cpts *cpts =3D gbe_dev->cpts;
> >> -	struct hwtstamp_config cfg;
> >> +	struct gbe_intf *gbe_intf =3D intf_priv;
> >> +	struct gbe_priv *gbe_dev;
> >> +	struct phy_device *phy;
> >>  =20
> >> -	if (!cpts)
> >> +	gbe_dev =3D gbe_intf->gbe_dev;
> >> +
> >> +	if (!gbe_dev->cpts)
> >>   		return -EOPNOTSUPP;
> >>  =20
> >> -	if (copy_from_user(&cfg, ifr->ifr_data, sizeof(cfg)))
> >> -		return -EFAULT;
> >> +	phy =3D gbe_intf->slave->phy;
> >> +	if (phy_has_hwtstamp(phy))
> >> +		return phy->mii_ts->hwtstamp(phy->mii_ts, cfg, extack); =20
> >=20
> > Sorry to come back to this but the choice of using PHY or MAC timestamp=
ing
> > is done in the core. Putting this here may conflict with the core.
> > I know this driver has kind of a weird PHYs management through slave
> > description but we shouldn't let the MAC driver call the PHY hwtstamp o=
ps.
> > If there is indeed an issue due to the weird development of this driver,
> > people will write a patch specifically tackling this issue and maybe (by
> > luck) refactoring this driver.
> >=20
> > Anyway, this was not in the driver before, so I think we should not make
> > this change in this patch. =20
>=20
> Well, that was actually in the original code:

Oh indeed, sorry, I missed that.
=20
> static int gbe_ioctl(void *intf_priv, struct ifreq *req, int cmd)
> {
>          struct gbe_intf *gbe_intf =3D intf_priv;
>          struct phy_device *phy =3D gbe_intf->slave->phy;
>=20
>          if (!phy_has_hwtstamp(phy)) {
>                  switch (cmd) {
>                  case SIOCGHWTSTAMP:
>                          return gbe_hwtstamp_get(gbe_intf, req);
>                  case SIOCSHWTSTAMP:
>                          return gbe_hwtstamp_set(gbe_intf, req);
>                  }
>          }
>=20
>          if (phy)
>                  return phy_mii_ioctl(phy, req, cmd);
>=20
>          return -EOPNOTSUPP;
> }
>=20
> SIOCGHWTSTAMP/SIOCSHWTSTAMP were sent to gbe functions only when there
> was no support for hwtstamps on phy layer. The original flow of the call
> is:
>=20
> netcp_ndo_ioctl -> gbe_ioctl -> gbe_hwtstamp_*/phy_mii_ioctl
>=20
> where netcp_ndo_ioctl operating over netdev while other function
> operating with other objects, with phy taken from gbe_intf.
>=20
> Checking on init part of phy devices, I found that the only phydev
> allocated structure is stored in gbe_slave object, which is definitely
> not accessible from the core. I haven't found any assignments to
> net_device->phydev in neither netcp_core.c nor netcp_ethss.c.
> Even though there are checks for some phy functions from netdev->phydev
> in RX and TX paths, I'm not quite sure it works properly.
>=20
> I decided to keep the original logic here with checking phy from
> gbe_intf->slave.

Ok. I still think this may conflict when associated to a PHY that support
hwtstamp, but if you keep the old logic then it is ok to me. Someone will f=
ix
it when the case appear. FYI you could use the phy_hwtstamp() helper
instead of phy->mii_ts->hwtstamp(). Relevant in case of v3.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

