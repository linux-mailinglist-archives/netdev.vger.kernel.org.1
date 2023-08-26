Return-Path: <netdev+bounces-30875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7AC78979D
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 17:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C10DD28181C
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 15:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E20DF4F;
	Sat, 26 Aug 2023 15:04:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E78D51C
	for <netdev@vger.kernel.org>; Sat, 26 Aug 2023 15:04:01 +0000 (UTC)
X-Greylist: delayed 483 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 26 Aug 2023 08:03:59 PDT
Received: from mail.redxen.eu (chisa.nurnberg.hetzner.redxen.eu [IPv6:2a01:4f8:c2c:b2fc::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D3610F3
	for <netdev@vger.kernel.org>; Sat, 26 Aug 2023 08:03:59 -0700 (PDT)
Received: from localhost (karu.nurnberg.hetzner.redxen.eu [157.90.160.106])
	by mail.redxen.eu (RedXen Mail Postfix) with ESMTPSA id 093135FA6A;
	Sat, 26 Aug 2023 14:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redxen.eu;
	s=2021.05.31.01-mail; t=1693061754;
	bh=Ojoe/B4Mm1cwlI6ck2mGaQ/KU5DJj/sGdm/n4Pz9pGU=;
	h=Date:To:Cc:Subject:From;
	b=PbSNgU0kInsflNp/razhfl3OzYz3q3X0Lnlfypx6CAxCIjziIwYWbcjIZfZQijtDI
	 5uxJLsHltCH7XNLnsDjjgqZiywV8uQmX9fjT4zOfEOzq2Yvu5U4tkdTaXVb1Wlh9cu
	 BSSqOe4rucmVOVnx2VwqnCOmzm30XdKLUEI7cDzWOoEPtGwACvYzipYGDIeIuCWBGD
	 H8TC+Jo5vfyvXnTZc6zb4+AYLPUC3UQY5Kr4M5iJsGvnJzryUXmRZ5FKeJPvv/+LN/
	 v63AHae0c1EIFZ6PGj1L/XvR4hlOtRvq6cf3lfkqhTuqUsHYgHU0HpNfEz33knDXa5
	 FtE216IICMIew==
Authentication-Results: mail.redxen.eu;
	auth=pass smtp.auth=caskd smtp.mailfrom=caskd@redxen.eu
Date: Sat, 26 Aug 2023 14:55:53 +0000
To: Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov
 <razor@blackwall.org>
Cc: netdev@vger.kernel.org
Subject: IPv6 multicast and snooping on bridges
From: caskd <caskd@redxen.eu>
Message-Id: <2GFL0JKN91JCI.2BNDSFI1J4DTV@unix.is.love.unix.is.life>
User-Agent: mblaze/20220328-3140-g8658ea6aef
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="----_=_4015aa115e97db8371fe2c5d_=_"
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This is a multipart message in MIME format.

------_=_4015aa115e97db8371fe2c5d_=_
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_3a2b337b4757f0552fd7f937_=_"

This is a multipart message in MIME format.

------_=_3a2b337b4757f0552fd7f937_=_
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello everyone,

i've noticed that the bridges and IPv6 multicast snooping doesn't seem to p=
lay out together well. When a address gets assigned to the bridge it gets e=
ntered into it's bridge multicast database but it vanishes after a while. I=
 wasn't able to pinpoint the cause of the vanish, it's not the GC.

How to reproduce:

- Create a bridge
- Activate multicast snooping
- Assign a address to the bridge
- Watch multicast database (especially the ones with the device and port bo=
th being the bridge)
- Wait 5-10 minutes (i wasn't able to pinpoint a exact interval but it usua=
lly happens in this timeframe)

During the waiting timeframe the interface's own host groups should disappe=
ar from the bridge's database, resulting in the bridge not accepting any mo=
re packets for it's own group.

Is this intended behaviour? It would seem like the interface can be used as=
 a "switch-port" itself instead of configuring a dummy interface to be a pa=
rt of the bridge, as it behaves correctly except for this one case. This is=
n't a problem in the IPv4 world but creates routing problems in the IPv6 wo=
rld. If it is, could this be documented somewhere?

Thanks in advance.

--=20
Alex D.
RedXen System & Infrastructure Administration
https://redxen.eu/

------_=_3a2b337b4757f0552fd7f937_=_--

------_=_4015aa115e97db8371fe2c5d_=_
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQJEBAABCgAuFiEE2k4nnbsAOnatJfEW+SuoX2H0wXMFAmTqEngQHGNhc2tkQHJl
ZHhlbi5ldQAKCRD5K6hfYfTBc+CGD/9obN8zqptyjt1kPe8NOqzt4iu3ZOCQmY+E
QVGW6Q7zqmlCiuMI6gqoABlhaInnjXlAuCYW5zK0glelLjnDXztzCE57me5RjB/P
t0ThMd8uV0lu552oUuZND8iuarzn6ykgTEMFtfG6w/5sKSdfdbdr6ikf69TCfPOF
pkDkwkogRsp5pOARS7R3DYtWtwDle45mJpMZ7hX0yYE+q/dfWurmqStGMwRD3KPz
dDvqMS1O3IY29i8o/S1N3Q28z/lSB7RL2K6XFKZcHGg3mw5cftRnV7DztvXxhYsa
OIACgCcKHnFDC2U33KUtVGJeJG82TedCSqUZxijKmrHjV7YHwH3Z8yCImsxVUnlS
+hHEWx2F2FD5rs6XC5tUz8yTkHJLnL1CfPTZ/zTIVOEpCYY9mFViGDoJxNM216Ga
CgeJ6QUU+fsSuUm2YtXCnnIQNx6U9cTAxYxU9fkJSPmchyVYxaxEX/hwsMgP2+Zy
L9WafOqv9WzHIOfGAxwpE0m4l9aoPyU2gZfjyzhghxQIH/ikVada3luCD3k/UdrA
OiZhfeBo1iUvVJ3qW1lt1teCrL5tlNuW9wQg+tyLdR2/jLKcXjsnUNckH3D7ORbl
sS/Bc6OTBjxkoQYoBg2MqOY4qu1H6ph/9qfSV1xdpNQEKqrj0wksupXiNbQRbUOq
XiJeoAcewQ==
=b7BF
-----END PGP SIGNATURE-----

------_=_4015aa115e97db8371fe2c5d_=_--

