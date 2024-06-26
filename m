Return-Path: <netdev+bounces-106819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F087917CDF
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 11:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 347171C2239A
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 09:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D052D16CD1F;
	Wed, 26 Jun 2024 09:48:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F7FEEDD
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 09:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719395335; cv=none; b=EDDIpnyfdGrE3FLOAMALwcijoFia5efKdAMDg7BbMpumR21KxMSOvKV86xfyw5NpcsuivLyNX8LCkmZZvdpsPiSclGNZR69fjGxh0ZvqQUXvm4liDpHvNMVT2jX1onQ2MsR+SykxrFND/rlm5l2iU0NqoY4qR3ekfG8EGzGsztE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719395335; c=relaxed/simple;
	bh=wTSg2C35AkZ1JPxh5AO+SGFFqFblZQ6XzUE632XfySY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GCI2noTj7bCNx4zMH21wKHWpN8H6P7yrd0MGF33FNRsVav8kxhWuceH/7pWJjAGiyuZff0ugHbETI8wyHtsVqlxNaIfVREqP9k+cQT9+o2Sle7+MKGgwaf67V6YUoAMhyHbbTxgvfbn1yWRbLzU3h+YVXibVta2shMS4TtOTmYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sMPG8-0001DI-Cd; Wed, 26 Jun 2024 11:48:12 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sMPG5-0056Cv-Hm; Wed, 26 Jun 2024 11:48:09 +0200
Received: from pengutronix.de (p5de45302.dip0.t-ipconnect.de [93.228.83.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 5B28B2F3F66;
	Wed, 26 Jun 2024 09:47:53 +0000 (UTC)
Date: Wed, 26 Jun 2024 11:47:52 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, 
	linux-arm-kernel@lists.infradead.org, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Herve Codina <herve.codina@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, 
	=?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>, 
	Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>, Piergiorgio Beruto <piergiorgio.beruto@gmail.com>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, =?utf-8?Q?Nicol=C3=B2?= Veronese <nicveronese@gmail.com>, 
	Simon Horman <horms@kernel.org>, mwojtas@chromium.org, Nathan Chancellor <nathan@kernel.org>, 
	Antoine Tenart <atenart@kernel.org>, kernel@pengutronix.de
Subject: Re: [PATCH net-next v13 00/13] Introduce PHY listing and
 link_topology tracking
Message-ID: <20240626-worm-of-remarkable-leadership-24f339-mkl@pengutronix.de>
References: <20240607071836.911403-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ub63hrz3rm74kdyo"
Content-Disposition: inline
In-Reply-To: <20240607071836.911403-1-maxime.chevallier@bootlin.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--ub63hrz3rm74kdyo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 07.06.2024 09:18:13, Maxime Chevallier wrote:
> Hello everyone,
>=20
> This is V13 for the link topology addition, allowing to track all PHYs
> that are linked to netdevices.
>=20
> This version is based on the V12, and addresses the missing
> documentation for the return code of some helpersn, and gathers the
> review from K=C3=B6ry.
>=20
> Discussions on the patch 01/13 updates can be found here :
>=20
> https://lore.kernel.org/netdev/20240412104615.3779632-1-maxime.chevallier=
@bootlin.com/
> https://lore.kernel.org/netdev/20240429131008.439231-1-maxime.chevallier@=
bootlin.com/
> https://lore.kernel.org/netdev/20240507102822.2023826-1-maxime.chevallier=
@bootlin.com/
>=20
> As a remainder, here's what the PHY listings would look like :
>  - eth0 has a 88x3310 acting as media converter, and an SFP module with
>    an embedded 88e1111 PHY
>  - eth2 has a 88e1510 PHY
>=20
> # ethtool --show-phys *

This creates the following warning for me:

[   51.877429] ------------[ cut here ]------------
[   51.882094] WARNING: CPU: 0 PID: 333 at lib/refcount.c:31 ref_tracker_fr=
ee+0x1ac/0x254
[   51.890222] refcount_t: decrement hit 0; leaking memory.
[   51.895611] Modules linked in: mcp251xfd flexcan imx_sdma can_dev spi_imx
[   51.902493] CPU: 0 PID: 333 Comm: ethtool Not tainted 6.10.0-rc4+ #327
[   51.909056] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[   51.915603] Call trace:=20
[   51.915623] [<c0d2cbd0>] (unwind_backtrace) from [<c0109bcc>] (show_stac=
k+0x10/0x14)
[   51.925979] [<c0109bcc>] (show_stack) from [<c0d4744c>] (dump_stack_lvl+=
0x50/0x64)
[   51.933605] [<c0d4744c>] (dump_stack_lvl) from [<c0d2d2ec>] (__warn+0x88=
/0xc0)
[   51.940877] [<c0d2d2ec>] (__warn) from [<c0120ba0>] (warn_slowpath_fmt+0=
x1b4/0x1c4)
[   51.948590] [<c0120ba0>] (warn_slowpath_fmt) from [<c0697f74>] (ref_trac=
ker_free+0x1ac/0x254)
[   51.957176] [<c0697f74>] (ref_tracker_free) from [<c0ae4b7c>] (ethnl_phy=
_done+0x24/0x54)
[   51.965318] [<c0ae4b7c>] (ethnl_phy_done) from [<c0acda68>] (genl_done+0=
x3c/0x88)
[   51.972845] [<c0acda68>] (genl_done) from [<c0ac9b6c>] (netlink_dump+0x2=
d8/0x3d0)
[   51.980387] [<c0ac9b6c>] (netlink_dump) from [<c0aca2fc>] (__netlink_dum=
p_start+0x1f4/0x2c4)
[   51.988889] [<c0aca2fc>] (__netlink_dump_start) from [<c0acd7bc>] (genl_=
family_rcv_msg+0x140/0x328)
[   51.997989] [<c0acd7bc>] (genl_family_rcv_msg) from [<c0acd9e8>] (genl_r=
cv_msg+0x44/0x88)
[   52.006204] [<c0acd9e8>] (genl_rcv_msg) from [<c0acc554>] (netlink_rcv_s=
kb+0xb8/0x118)
[   52.014157] [<c0acc554>] (netlink_rcv_skb) from [<c0acd038>] (genl_rcv+0=
x20/0x34)
[   52.021673] [<c0acd038>] (genl_rcv) from [<c0acbd24>] (netlink_unicast+0=
x23c/0x3d0)
[   52.029367] [<c0acbd24>] (netlink_unicast) from [<c0acc044>] (netlink_se=
ndmsg+0x18c/0x3d4)
[   52.037667] [<c0acc044>] (netlink_sendmsg) from [<c0a4b30c>] (__sys_send=
to+0xd4/0x128)
[   52.045626] [<c0a4b30c>] (__sys_sendto) from [<c0100080>] (ret_fast_sysc=
all+0x0/0x54)
[   52.053496] Exception stack(0xc3967fa8 to 0xc3967ff0)
[   52.058576] 7fa0:                   b6f1130c 0000000c 00000003 015dd238 =
00000018 00000000
[   52.066780] 7fc0: b6f1130c 0000000c b6fb6700 00000122 00571000 00000001 =
0052a2f8 015dd190
[   52.074978] 7fe0: 00000122 bec7cf38 b6ea847d b6e1fe86
[   52.080184] ---[ end trace 0000000000000000 ]---

While a "ethtool --show-phys lan0" works w/o problems.

| $ ip a s
| 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group=
 default qlen 1000
|     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
|     inet 127.0.0.1/8 scope host lo
|        valid_lft forever preferred_lft forever
|     inet6 ::1/128 scope host=20
|        valid_lft forever preferred_lft forever
| 2: sit0@NONE: <NOARP> mtu 1480 qdisc noop state DOWN group default qlen 1=
000
|     link/sit 0.0.0.0 brd 0.0.0.0
| 3: lan0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast stat=
e UP group default qlen 1000
|     link/ether xx:xx:xx:xx:xx:xx brd ff:ff:ff:ff:ff:ff
|     inet 192.168.178.140/24 metric 1024 brd 192.168.178.255 scope global =
dynamic lan0
|        valid_lft 863858sec preferred_lft 863858sec
|     inet6 2003:xx:xxxx:xxxx:xxx:xxxx:xxxx:xxxx/64 scope global temporary =
dynamic=20
|        valid_lft 7057sec preferred_lft 982sec
|     inet6 2003:xx:xxxx:xxxx:xxxx:xxxx:xxxx:xxxx/64 scope global dynamic m=
ngtmpaddr noprefixroute=20
|        valid_lft 7057sec preferred_lft 982sec
|     inet6 fe80::xxxx:xxxx:xxxx:xxxx/64 scope link=20
|        valid_lft forever preferred_lft forever
| 4: flexcan0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UP gr=
oup default qlen 10
|     link/can=20
| 5: mcp251xfd0: <NOARP,UP,LOWER_UP,ECHO> mtu 72 qdisc pfifo_fast state UP =
group default qlen 10
|     link/can=20

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ub63hrz3rm74kdyo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmZ748YACgkQKDiiPnot
vG8uXwf/eVROFYWU0qgKem49yy8iNInzwAADkea81Nd/ZrXSmu+2cc+WCnaAGLvr
ofmf1GF5YyeLNSlEqK3ywpHsKeA6V7HJ9XoJUMy2DEqi2o2KAjFzrtTxN/WCeQt8
ZhHBTv95teWnnL+2y9qsQ+d5gAKDBuctv2v+6ykH7ZMG5MbzY0/8GFWqwMz9/HlO
bFPbjOMpeBwvoQB1HKMYGguj/NaGzP/HJSppl2BZp1BM/3l+jQDVcBOqyu6Cyc9C
d/7QyBkLFPP7xnXkD8VGsgjfmndWeAYDAaEhSFjftFiutvh2LllTikPisaH7O/0k
LbOIXWrrOFivbuiYrQf9U9MimairPg==
=mxOh
-----END PGP SIGNATURE-----

--ub63hrz3rm74kdyo--

