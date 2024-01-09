Return-Path: <netdev+bounces-62660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E6782861F
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 13:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 407081F2492E
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 12:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C327364C6;
	Tue,  9 Jan 2024 12:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="MvUvSlDy"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CF4364A8
	for <netdev@vger.kernel.org>; Tue,  9 Jan 2024 12:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id B999787800;
	Tue,  9 Jan 2024 13:32:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1704803561;
	bh=edbNa+fah7HbWGEb+lguywsx9JjgnyEiDD6QO/Z8H9o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MvUvSlDyskcGY+HiMr38oQqBpBy7cp2bMvoeZJ7E7ullU+g8c4fx3frIWbuJyrilI
	 QHNlr+0tQ6tR2qptiIXZXSsbY5bsICdhu8qfDOt5Vy5BBFuPaOGXJqKbRthF7ZNGYe
	 wgouMeNx6AtPCIH3UvoCKtcVj7MI04pF8dhsk4a/i628Z7ZDzN0kgBYMDZh7e9+oQP
	 nXOXb0JIKZE9EbXN005sb/uwJDdNGj2SMYhiESXRqoZ++LJlo5AS9+dN3lY6EQbDus
	 Ug/bbwfKekiF60Gpc1cynsvMRTKirljX83Vl0juTzJOlM/bL0wjc3miHvr9BgqYW1J
	 vRRYnqJodv4bg==
Date: Tue, 9 Jan 2024 13:32:34 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>
Cc: Tristram.Ha@microchip.com, Oleksij Rempel <o.rempel@pengutronix.de>,
 UNGLinuxDriver@microchip.com, netdev@vger.kernel.org, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>
Subject: [net][hsr] Question regarding HSR RedBox functionality
 implementation (preferably on KSZ9477)
Message-ID: <20240109133234.74c47dcd@wsk>
In-Reply-To: <20231003104410.dhngn3vvdfdcurga@skbuf>
References: <20230922133108.2090612-1-lukma@denx.de>
	<20230926225401.bganxwmtrgkiz2di@skbuf>
	<20230928124127.379115e6@wsk>
	<20231003095832.4bec4c72@wsk>
	<20231003104410.dhngn3vvdfdcurga@skbuf>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/mIp0pM3xcMQUeaqq5JOJtet";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/mIp0pM3xcMQUeaqq5JOJtet
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Dear Community,

I would like to ask you for some help regarding HSR mainline
implementation.

As of now for KSZ9477 we do have working hsr0 (as offloading HW) for
HSR ring operation and some other ports for this IC (like lan3,4,5).

With current setup it is possible to forward packets from HSR ring to
non-HSR network (i.e. plain ethernet) with L3 routing.

However, I'm wondering how the mainline Linux kernel could handle HSR
RedBox functionality (on document [1], Figure 2. we do have "bridge" -
OSI L2).

To be more interesting - br0 can be created between hsr0 and e.g. lan3.
But as expected communication breaks on both directions (to SAN and to
HSR ring).

Is there a similar functionality already present in the Linux kernel
(so this approach could be reused)?

My (very rough idea) would be to extend KSZ9477 bridge join functions
to check if HSR capable interface is "bridged" and then handle frames
in a special way.

However, I would like to first ask for as much input as possible - to
avoid any unnecessary work.

Thanks in advance for help :-)

Link:

[1] -
https://ww1.microchip.com/downloads/en/Appnotes/AN3474-KSZ9477-High-Availab=
ility-Seamless-Redundancy-Application-Note-00003474A.pdf


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/mIp0pM3xcMQUeaqq5JOJtet
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmWdPOIACgkQAR8vZIA0
zr3KdwgArDhN6Uj3SziFT2/zLsYLhUKeuJxNmSXOFe4Fu6TNRdffUACNLYVdwdyl
bQ5CKcfMBEQ37x9aQrAfjJE3Q18cv9713dn6WP1/EVwOTSOqv1bQTDM1sBq165ai
qrl7gkusOmuoN4YkeqpKxSF4YZwWAoJjuQYyBZJz5btBXhQiG9zanWJFN6RBRNeT
6IJyF1ZyKa9w6rev37gcZxVVPNQNnGYe8HAXt2bAZ8srYkkzOFbSafA6wdZ6FgMe
NdIqL70usbPLL2E9LAbOSFQPHCKMAjpBPFpV00mTXRiHLFMigo5t8jrTR4fi44UA
cWnTu/3vDK5iTNz8MQkwwsjcQ/CzbA==
=Nl6G
-----END PGP SIGNATURE-----

--Sig_/mIp0pM3xcMQUeaqq5JOJtet--

