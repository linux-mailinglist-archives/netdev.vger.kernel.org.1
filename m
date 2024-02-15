Return-Path: <netdev+bounces-72003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D015856281
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 13:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2895CB228D8
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 11:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CF112B146;
	Thu, 15 Feb 2024 11:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="FlWP+oUI"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB187484
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 11:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707997931; cv=none; b=XwFyfRg8ROT/990KDUL33m3fh/V7RDc60XVL67U8B32y7xl3HNDcIyh2WnkunG46wItorX2KxxNoOnptrUzpr1OJ30smEIvO7bK38AT7S25DFeiI7eKVPgVB/7Jio8iUZCgf8ryiYHrXX/dn2VFYNeMpfDSt2XuC1yrh4lgNODg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707997931; c=relaxed/simple;
	bh=OxfEr0cHEXJfcIwE+RWlB+kC6yii81amUv+q8fB4J74=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c125ggG7Q8RusGDTajLOxw+bqvQoFN7SuzWxJ/+zz0MBEf81DWKD3d2F73VwGK6NFRhGR3qTub7BPpehRgsGi3MvgTSsi+kh3wHNMTS8io4Dy323gLpvxYIwm6lM5JFKMeMRfayUopGvz1KG2Ky+JdD+IP1hG9EtfjeTJvaX5Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=FlWP+oUI; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 5057687D6D;
	Thu, 15 Feb 2024 12:52:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1707997927;
	bh=vXaFxhlBPSuc9nW0J32/a8FMXPUPOVBigD5hlJuNKPs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FlWP+oUIj5DkB7bTWX1TkjqDs04sdVoJAxYXBWH6trlP1IsTzvkP8m66MEKInrTwd
	 yczK0eKqPdUwZEwtAmGJ7x8TVGNHdSgCkEY3xm75MLDGY8Z/43ssovGDAN2qSYRgPh
	 T+CRoig1ZDWLD7/o7pB3zU5SpqFjeUEv5Yu4OyzA07lRFTnWfy3PV3kxNOiCiiMmTR
	 KTunWDsnb+65GGwBiy3NWRYzvk14rA1s2neGFoo2SvmZCFrfOsQvnmaCysk1HVo4rX
	 imJFwhurKVW6vdm5dDIwCiTT84dOJwCWemu7spkYeoQrI8/D234Z7gUMsvd0IzErUO
	 LZyqxGA7v7dKw==
Date: Thu, 15 Feb 2024 12:51:56 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>
Cc: Tristram.Ha@microchip.com, Oleksij Rempel <o.rempel@pengutronix.de>,
 UNGLinuxDriver@microchip.com, netdev@vger.kernel.org, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, George McCollister
 <george.mccollister@gmail.com>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, <davem@davemloft.net>
Subject: Re: [net][hsr] Question regarding HSR RedBox functionality
 implementation (preferably on KSZ9477)
Message-ID: <20240215125156.0d9f3cb7@wsk>
In-Reply-To: <20240214114436.67568a49@wsk>
References: <20230928124127.379115e6@wsk>
	<20231003095832.4bec4c72@wsk>
	<20231003104410.dhngn3vvdfdcurga@skbuf>
	<20230922133108.2090612-1-lukma@denx.de>
	<20230926225401.bganxwmtrgkiz2di@skbuf>
	<20230928124127.379115e6@wsk>
	<20231003095832.4bec4c72@wsk>
	<20231003104410.dhngn3vvdfdcurga@skbuf>
	<20240109133234.74c47dcd@wsk>
	<20240109133234.74c47dcd@wsk>
	<20240109125205.u6yc3z4neter24ae@skbuf>
	<20240109150414.6a402fec@wsk>
	<20240214114436.67568a49@wsk>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/23dnf7=HLhLThC_1EnAz=M8";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/23dnf7=HLhLThC_1EnAz=M8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Dear Community,

> Hi Vladimir, Andrew,
>=20
> > Hi Vladimir,
> >  =20
> > > Hi Lukasz,
> > >=20
> > > On Tue, Jan 09, 2024 at 01:32:34PM +0100, Lukasz Majewski wrote:
> > >  =20
> > > > However, I'm wondering how the mainline Linux kernel could
> > > > handle HSR RedBox functionality (on document [1], Figure 2. we
> > > > do have "bridge" - OSI L2).
> > > >=20
> > > > To be more interesting - br0 can be created between hsr0 and
> > > > e.g. lan3. But as expected communication breaks on both
> > > > directions (to SAN and to HSR ring).     =20
> > >=20
> > > Yes, I suppose this is how a RedBox should be modeled. In
> > > principle it's identical to how bridging with LAG ports (bond,
> > > team) works - either in software or offloaded.=20
> > > The trouble is that the HSR driver
> > > seems to only work with the DANH/DANP roles (as also mentioned in
> > > Documentation/networking/dsa/dsa.rst). I don't remember what
> > > doesn't work (or if I ever knew at all).   =20
> >=20
> > In the newest net-next only PRP_TLV_REDBOX_MAC is defined, which
> > seems to be REDBOX for DAN P (PRP).
> >  =20
> > > It might be the address substitution
> > > from hsr_xmit() that masks the MAC address of the SAN side device?
> > >    =20
> >=20
> > This needs to be further investigated. =20
>=20
> I've looked into the HSR and Bridge drivers internals.
>=20
> The creation of hsrX device from command line ends with
> hsr_dev_finalize(), which then calls hsr_add_port() for HSR_PT_MASTER,
> HSR_PT_SLAVE_A and HSR_PT_SLAVE_B.
>=20
> Those three ports allows HSR DANH operation.
>=20
> For Redbox (SANH) it looks like the HSR_PT_INTERLINK shall be used.
>=20
> When calling:
> ip link add name br0 type bridge; ip link set br0 up;
> ip link set hsr1 master br0; ip link set lan3 master br0;
>=20
> (the hsr1 is the SW HSR - NO offloading).
>=20
> The br_add_if() is called, which calls:
> netdev_rx_handler_register(dev, br_get_rx_handler(dev), p);
>=20
> This setup of RX handler is problematic, as for HSR INTERLINK port the
> hsr_handle_frame() shall be used (so proper port->type =3D
> HSR_PT_INTERLINK would be used in the hsr driver).
>=20
> When the bridge handler is used, all the incoming frames are set as
> HSR_PT_MASTER type (and only some frames with "reserved" MAC address
> are passed to HSR network).
>=20
>=20
> The problem:
> ############
> Proper setup of rx_handler for network device, so L2 frames are
> handled by HSR driver.
>=20
>=20
> I've tried:
> ###########
> 1. In dsa_user_prechangeupper() (or ksz_port_bridge_join)
> if (netdev_is_rx_handler_busy(dp->user)) {
> 	rtnl_trylock();
> 	netdev_rx_handler_unregister(dp->user);
> 	rtnl_unlock();
> }
>=20
> hsr_add_interlink_port(dev->hsr_dev, dp->user, extack);
>=20
> But it looks like it is too low-level code to play with it by hand as
> several WARN_ONs are triggered.
>=20
> 2. Stop/unlink the bridge slave port (lan3) and then call
> hsr_add_interlink_port() for it.
>=20
> However, there are several warnings as well and this approach may harm
> the "bridging" modelling approach as I would use 'unlinked' device for
> normal operation.
>=20
>=20
> Idea:
> #####
>=20
> 1. In the br_get_rx_handler() I could add check if "sibling" port is
> the HSR master one and then set the RX handler for lan3 to this one.
>=20
> However, this would require "bridge" driver modification for HSR
> operation.
>=20
> 2. Maybe the way of HSR port creation shall be augmented [*]?
> For example from:
> ip link add name hsr1 type hsr slave1 lan4 slave2 lan5 supervision 45
>=20
> to:
> ip link add name hsr1 type hsr slave1 lan4 slave2 lan5 interlink lan3
> supervision 45

Please find the draft proposal of iproute2 patch to add support for HSR
interlink passing network device:

https://github.com/lmajewski/iproute2/commit/5edf2ab77786ab49419712a4defa42=
a600fe47c2

>=20
> In that way I could modify only the hsr_dev_finalize() and everything
> would be managed by hsr driver?
>=20
>=20
>=20
>=20
> Or maybe I've overlooked something, and there is easier solution for
> this problem?
>=20
>=20
>=20
> Note:
>=20
> [*] - this approach solves also another problem - when we do have e.g
> 5 ports in the switch how one can know which lanX port shall be added
> to HSR network? With the current approach the hsr1 device first needs
> to be created and then it is implicitly assumed that the next bridged
> port (lan3) shall be the Interlink one for HSR.
>=20
> >  =20
> > > > Is there a similar functionality already present in the Linux
> > > > kernel (so this approach could be reused)?
> > > >=20
> > > > My (very rough idea) would be to extend KSZ9477 bridge join
> > > > functions to check if HSR capable interface is "bridged" and
> > > > then handle frames in a special way.
> > > >=20
> > > > However, I would like to first ask for as much input as
> > > > possible - to avoid any unnecessary work.     =20
> > >=20
> > > First I'd figure out why the software data path isn't working, and
> > > if it can be fixed.    =20
> >=20
> > +1
> >  =20
> > > Then, fix that if possible, and add a new selftest to
> > > tools/testing/selftests/net/forwarding/, that should pass using
> > > veth interfaces as lower ports.
> > >=20
> > > Then, offloading something that has a clear model in software
> > > should be relatively easy, though you might need to add some
> > > logic to DSA. This is one place that needs to be edited, there
> > > may be others.
> > >=20
> > > 	/* dsa_port_pre_hsr_leave is not yet necessary since hsr
> > > devices cannot
> > > 	 * meaningfully placed under a bridge yet
> > > 	 */
> > >    =20
> >=20
> > Ok, the LAG approach in /net/dsa/user.c can be used as an example.
> >=20
> > Thanks for shedding some light on this issue :-)
> >  =20
> > > >=20
> > > > Thanks in advance for help :-)
> > > >=20
> > > > Link:
> > > >=20
> > > > [1] -
> > > > https://ww1.microchip.com/downloads/en/Appnotes/AN3474-KSZ9477-High=
-Availability-Seamless-Redundancy-Application-Note-00003474A.pdf
> > > >=20
> > > >=20
> > > > Best regards,
> > > >=20
> > > > Lukasz Majewski     =20
> >=20
> >=20
> >=20
> >=20
> > Best regards,
> >=20
> > Lukasz Majewski
> >=20
> > --
> >=20
> > DENX Software Engineering GmbH,      Managing Director: Erika Unter
> > HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell,
> > Germany Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email:
> > lukma@denx.de =20
>=20
>=20
>=20
>=20
> Best regards,
>=20
> Lukasz Majewski
>=20
> --
>=20
> DENX Software Engineering GmbH,      Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email:
> lukma@denx.de




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/23dnf7=HLhLThC_1EnAz=M8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmXN+twACgkQAR8vZIA0
zr1RFwf+OJyge2a9oJjqqQhcqpvrNPm/ejIQlJCqzEoEVdVQ5yvotiaLBaoKRuP4
2bjRtro+DBg/cj+y3Cws2NJAqI8P81S8gOP4lBC4qKFBeR/IGDnAn+sxFLc/tqAu
du9ZlqbPIBA7KYrRZ63hItcygYR0G/Vskw0onYyl0KKZ3Jn4ulUDR1Y8Q2FrxJTy
iqc3RVySofwJXHG4Ol93EDeRqDZ6PUP1PU+dmLVEOqWnPD6EXWFh9ODVZs/G01sF
NKpFyt8t1QgYUqrot/0t0h7lZftjn92AB1wm1OxtSaUMcuSC3ACfua3P+fd4RC/3
Fo1aN56LMkd9yEergAw5/dnCVi8Z9Q==
=QWZT
-----END PGP SIGNATURE-----

--Sig_/23dnf7=HLhLThC_1EnAz=M8--

