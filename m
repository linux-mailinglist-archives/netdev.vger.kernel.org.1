Return-Path: <netdev+bounces-234075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2B6C1C372
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 17:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2077A344082
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 16:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A3F2F548C;
	Wed, 29 Oct 2025 16:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="P9JbqjjN"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652172F4A05
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 16:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761756478; cv=none; b=nV6PYI7jRh6xTOfhMy/9Mr9C0w809+mvXSLHBu9VhxqtGu9lHWTVmtfkxNKwNWXdUmRKBSlAxl4RqpnXt1ACMWNt27dubdqBHFSfrZfN5X6CHM9T3WkUB5JcDPZk/9qq2dybMkx4/HEhD13x0gvr0QZrhGBW1L7O8+Dx6q4h+mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761756478; c=relaxed/simple;
	bh=vIeGqyVGKrSdApqCZkZRhZ14gVeP6rCHTgitactBbW4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n5pZRLkT27nRnYyuhmGWuMCKKN+NCePTpPnItzcWGn25qiS+YU9lI1OueVsiiMNYXdlmg8+2EGfMymJkM7a/ounmd3HhbpsJE5zIf4Rb2bZtEZCgCtFZI4rXIgQ60IagGgkQG0Qytqf2D2clEgnLo3HsMDYrgCqlasiwWkr0l2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=P9JbqjjN; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 038721A1739;
	Wed, 29 Oct 2025 16:47:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BDEA4606E8;
	Wed, 29 Oct 2025 16:47:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E09BA117F83F2;
	Wed, 29 Oct 2025 17:47:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761756467; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+ZD8qKKAj7LLIn7XZPJ61tzZK6etWByMbTQs5Vyy61w=;
	b=P9JbqjjN9yPnHT3N4tDhHFGOu9FQV/HLNyBTOiqudEKDTT+oeEjRseC6TTgT/X8LViQLBM
	QVWNxol3vphN+liQJmMbKiJXyq2oz5f7v8TeIYAGg4WMaEC0Poc65n3Rotkejz8HjlkI/w
	NBC6MG2WU4JcOk94md6EVFWVXQuF7O7ELd8G/5VXdbXr9mLmyYfFX5NzfZpiEeeXlTIUQK
	IY+1OhN/5Jz5YuDfEBTonv5gNSd/EnEYDyNCfL8gEgf3he1e1c5PBqwujuG+VImdOWdvH+
	4qYNm/jHKrGQD0RHVWw7hG4xkyrMn1QiG7tRZxgFryO4ew0sm28S4lp+X6sCvw==
Date: Wed, 29 Oct 2025 17:47:40 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Jiaming Zhang <r772577952@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuniyu@google.com,
 linux-kernel@vger.kernel.org, sdf@fomichev.me, syzkaller@googlegroups.com,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: Re: [Linux Kernel Bug] KASAN: null-ptr-deref Read in
 generic_hwtstamp_ioctl_lower
Message-ID: <20251029174740.0f064865@kmaincent-XPS-13-7390>
In-Reply-To: <20251029161934.xwxzqoknqmwtrsgv@skbuf>
References: <CANypQFZ8KO=eUe7YPC+XdtjOAvdVyRnpFk_V3839ixCbdUNsGA@mail.gmail.com>
	<20251029110651.25c4936d@kmaincent-XPS-13-7390>
	<20251029161934.xwxzqoknqmwtrsgv@skbuf>
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

On Wed, 29 Oct 2025 18:19:34 +0200
Vladimir Oltean <vladimir.oltean@nxp.com> wrote:

> On Wed, Oct 29, 2025 at 11:06:51AM +0100, Kory Maincent wrote:
> > Hello Jiaming,
> >=20
> > +Vlad
> >=20
> > On Wed, 29 Oct 2025 16:45:37 +0800
> > Jiaming Zhang <r772577952@gmail.com> wrote:
> >  =20
> > > Dear Linux kernel developers and maintainers,
> > >=20
> > > We are writing to report a null pointer dereference bug discovered in
> > > the net subsystem. This bug is reproducible on the latest version
> > > (v6.18-rc3, commit dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa).
> > >=20
> > > The root cause is in tsconfig_prepare_data(), where a local
> > > kernel_hwtstamp_config struct (cfg) is initialized using {}, setting
> > > all its members to zero. Consequently, cfg.ifr becomes NULL.
> > >=20
> > > cfg is then passed as: tsconfig_prepare_data() ->
> > > dev_get_hwtstamp_phylib() -> vlan_hwtstamp_get() (via
> > > dev->netdev_ops->ndo_hwtstamp_get) -> generic_hwtstamp_get_lower() ->
> > > generic_hwtstamp_ioctl_lower().
> > >=20
> > > The function generic_hwtstamp_ioctl_lower() assumes cfg->ifr is a
> > > valid pointer and attempts to access cfg->ifr->ifr_ifru. This access
> > > dereferences the NULL pointer, triggering the bug. =20
> >=20
> > Thanks for spotting this issue!
> >=20
> > In the ideal world we would have all Ethernet driver supporting the
> > hwtstamp_get/set NDOs but that not currently the case.=09
> > Vladimir Oltean was working on this but it is not done yet.=20
> > $ git grep SIOCGHWTSTAMP drivers/net/ethernet | wc -l
> > 16 =20
>=20
> Vadim also took the initiative and submitted (is still submitting?) some
> more conversions, whereas I lost all steam.

Ok no worry I was simply pointing this out, people will convert it when they
want to use the new netlink API.
=20
> > > As a potential fix, we can declare a local struct ifreq variable in
> > > tsconfig_prepare_data(), zero-initializing it, and then assigning its
> > > address to cfg.ifr before calling dev_get_hwtstamp_phylib(). This
> > > ensures that functions down the call chain receive a valid pointer. =
=20
> >=20
> > If we do that we will have legacy IOCTL path inside the Netlink path and
> > that's not something we want.
> > In fact it is possible because the drivers calling
> > generic_hwtstamp_get/set_lower functions are already converted to hwtst=
amp
> > NDOs therefore the NDO check in tsconfig_prepare_data is not working on
> > these case. =20
>=20
> I remember we had this discussion before.
>=20
> | This is why I mentioned by ndo_hwtstamp_set() conversion, because
> | suddenly it is a prerequisite for any further progress to be done.
> | You can't convert SIOCSHWTSTAMP to netlink if there are some driver
> | implementations which still use ndo_eth_ioctl(). They need to be
> | UAPI-agnostic.
>=20
> https://lore.kernel.org/netdev/20231122140850.li2mvf6tpo3f2fhh@skbuf/
>=20
> I'm not sure what was your agreement with the netdev maintainer
> accepting the tsconfig netlink work with unconverted device drivers left
> in the tree.

I did like 21th versions and there was not many people active in the review=
s.
No one stand against this work.

> > IMO the solution is to add a check on the ifr value in the
> > generic_hwtstamp_set/get_lower functions like that:
> >=20
> > int generic_hwtstamp_set_lower(struct net_device *dev,
> > 			       struct kernel_hwtstamp_config *kernel_cfg,
> > 			       struct netlink_ext_ack *extack)
> > {
> > ...
> >=20
> > 	/* Netlink path with unconverted lower driver */
> > 	if (!kernel_cfg->ifr)
> > 		return -EOPNOTSUPP;
> >=20
> > 	/* Legacy path: unconverted lower driver */
> > 	return generic_hwtstamp_ioctl_lower(dev, SIOCSHWTSTAMP, kernel_cfg);
> > } =20
>=20
> This plugs one hole (two including _get). How many more are there? If
> this is an oversight, the entire tree needs to be reviewed for
> ndo_hwtstamp_get() / ndo_hwtstamp_test() pointer tests which were used
> as an indication that this net device is netlink ready. Stacked
> virtual interfaces are netlink-ready only when the entire chain down to
> the physical interface is netlink-ready.

I don't see this as a hole. The legacy ioctl path still works.
If people want to use the new Netlink path on their board, yes they need to
convert all the parts of the chain to hwtstamp NDOs. If they don't they will
get now a EOPNOTSUPP error instead of a null pointer dereference koops.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

