Return-Path: <netdev+bounces-149888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C364C9E7ECE
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 08:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83B04284F60
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 07:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9742682C7E;
	Sat,  7 Dec 2024 07:53:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from s1.jo-so.de (s1.jo-so.de [37.221.195.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3DD823DE
	for <netdev@vger.kernel.org>; Sat,  7 Dec 2024 07:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.221.195.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733558027; cv=none; b=aKzKou/oWRHKlGI3IbdqJbdvs3Uc/VJXL7OE/CQ4/OocmNYi0DB2JUr+ByAcgzTRa2G7P4bj+vyTm3GCorGI3XzYMizfjFolhej1zeZjhOdMFyZKXdaHiyvD8mt899l20Ipjg91NgKzsT5K+Dvobn5+cR3Rp0BA1fT5s1l0AsUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733558027; c=relaxed/simple;
	bh=0crVhjekl/TufH0e58YsLfi54DeRvyDwZuVYybgcy9M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=o3lwqHA1bHOoj7C1fuCCIVdKWXtIovRve9Ty539jPQfcJ/D2f+Tt25AkA0KyGTixkz+YhzImeeJDNbc+8m6QeHoxlj5qekxyuiEytyPPxwaOXxlMuDndI5mynYCbXXD+hyuBXHChbhQp25QJQ6v0DPyClGUD8+EY4qG2cdST980=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jo-so.de; spf=pass smtp.mailfrom=jo-so.de; arc=none smtp.client-ip=37.221.195.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jo-so.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jo-so.de
Received: from mail-relay (helo=jo-so.de)
	by s1.jo-so.de with local-bsmtp (Exim 4.96)
	(envelope-from <joerg@jo-so.de>)
	id 1tJpdC-000d4H-3A;
	Sat, 07 Dec 2024 08:53:38 +0100
Received: from joerg by zenbook.jo-so.de with local (Exim 4.98)
	(envelope-from <joerg@jo-so.de>)
	id 1tJpdC-00000000s0R-0QLE;
	Sat, 07 Dec 2024 08:53:38 +0100
Date: Sat, 7 Dec 2024 08:53:38 +0100
From: =?utf-8?B?SsO2cmc=?= Sommer <joerg@jo-so.de>
To: netdev@vger.kernel.org
Cc: Christian Eggers <ceggers@arri.de>
Subject: KSZ8795 not detected at start to boot from NFS
Message-ID: <ojegz5rmcjavsi7rnpkhunyu2mgikibugaffvj24vomvan3jqx@5v6fyz32wqoz>
OpenPGP: id=7D2C9A23D1AEA375; url=https://jo-so.de/pgp-key.txt;
 preference=signencrypt
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="z2zwuqovvefd5sle"
Content-Disposition: inline


--z2zwuqovvefd5sle
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: KSZ8795 not detected at start to boot from NFS
MIME-Version: 1.0

Hi,

I'm trying to load the root filesystem via NFS with a
NET_DSA_MICROCHIP_KSZ8795_SPI attached to an TI_DAVINCI_EMAC. With 5.10 it
works, but with later versions the kernel fails to detect the switch. It is
since

commit 8c4599f49841dd663402ec52325dc2233add1d32
Author: Christian Eggers <ceggers@arri.de>
Date:   Fri Nov 20 12:21:07 2020 +0100

    net: dsa: microchip: ksz8795: setup SPI mode

    This should be done in the device driver instead of the device tree.

    Signed-off-by: Christian Eggers <ceggers@arri.de>
    Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git drivers/net/dsa/microchip/ksz8795_spi.c drivers/net/dsa/microchi=
p/ksz8795_spi.c
index 8b00f8e6c02f..f98432a3e2b5 100644
--- drivers/net/dsa/microchip/ksz8795_spi.c
+++ drivers/net/dsa/microchip/ksz8795_spi.c
@@ -49,6 +49,12 @@ static int ksz8795_spi_probe(struct spi_device *spi)
        if (spi->dev.platform_data)
                dev->pdata =3D spi->dev.platform_data;

+       /* setup spi */
+       spi->mode =3D SPI_MODE_3;
+       ret =3D spi_setup(spi);
+       if (ret)
+               return ret;
+
        ret =3D ksz8795_switch_register(dev);

        /* Main DSA driver may not be started yet. */

The kernel reports

[    1.912756] ksz8795-switch: probe of spi0.1 failed with error -22
=E2=80=A6
[    2.048054] davinci_emac 1e20000.ethernet: incompatible machine/device t=
ype for reading mac address
[    2.062352] davinci_emac davinci_emac.1: failed to get EMAC clock
[    2.068632] davinci_emac: probe of davinci_emac.1 failed with error -16

It tries to initialize the switch before the ethernet of the SoC is ready.

Before this commit the kernel returned EPROBE_DEFER instead of EINVAL (or
ENODEV) as a quick

```
dev_err(&spi->dev, "ksz8795_spi_probe:%d: ret of ksz8795_switch_register=3D=
%d\n", __LINE__, ret);
```

reveals.

Without 8c4599f49841dd663402ec52325dc2233add1d32:

```
[    1.809914] ksz8795-switch spi0.1: ksz8795_spi_probe:60: ret of ksz8795_=
switch_register=3D-517
=E2=80=A6
[    2.069770] ksz8795-switch spi0.1: ksz8795_spi_probe:60: ret of ksz8795_=
switch_register=3D-517
[    2.209715] ksz8795-switch spi0.1: ksz8795_spi_probe:60: ret of ksz8795_=
switch_register=3D-517
[    2.223625] davinci_emac 1e20000.ethernet: incompatible machine/device t=
ype for reading mac address
[    3.110937] ksz8795-switch spi0.1 lan-x1 (uninitialized): PHY [dsa-0.0:0=
0] driver [Generic PHY] (irq=3DPOLL)
[    3.125766] ksz8795-switch spi0.1 lan-x2 (uninitialized): PHY [dsa-0.0:0=
1] driver [Generic PHY] (irq=3DPOLL)
[    3.140779] ksz8795-switch spi0.1 lan-x3 (uninitialized): PHY [dsa-0.0:0=
2] driver [Generic PHY] (irq=3DPOLL)
[    3.155026] ksz8795-switch spi0.1 lan-bp (uninitialized): PHY [dsa-0.0:0=
3] driver [Generic PHY] (irq=3DPOLL)
[    3.168579] ksz8795-switch spi0.1: configuring for fixed/rmii link mode
[    3.175324] eth0: mtu greater than device maximum
[    3.180273] davinci_emac 1e20000.ethernet eth0: error -22 setting MTU to=
 include DSA overhead
[    3.189075] DSA: tree 0 setup
[    3.192155] ksz8795-switch spi0.1: ksz8795_spi_probe:60: ret of ksz8795_=
switch_register=3D0
[    3.204819] device eth0 entered promiscuous mode
[    3.209962] ksz8795-switch spi0.1: Link is Up - 100Mbps/Full - flow cont=
rol rx/tx
[    3.221219] davinci_emac 1e20000.ethernet eth0: Link is Up - 100Mbps/Ful=
l - flow control off
[    3.232894] ksz8795-switch spi0.1 lan-x1: configuring for phy/gmii link =
mode
[    6.409818] ksz8795-switch spi0.1 lan-x1: Link is Up - 100Mbps/Full - fl=
ow control rx/tx
```

With 8c4599f49841dd663402ec52325dc2233add1d32:

```
[    1.808910] ksz8795-switch spi0.1: ksz8795_spi_probe:60: ret of ksz8795_=
switch_register=3D-22
[    1.817612] ksz8795-switch: probe of spi0.1 failed with error -22
[    1.823992] spi_davinci 1f0e000.spi: Controller at 0x(ptrval)
=E2=80=A6
[    1.952350] davinci_emac 1e20000.ethernet: incompatible machine/device t=
ype for reading mac address
```

So, I inserted these lines and it works.

```
        ret =3D ksz8_switch_register(dev);
+        if (ret =3D=3D -EINVAL || ret =3D=3D -ENODEV)
+            ret =3D -EPROBE_DEFER;
```

Is this the correct solution or should it be done something different?
Something like this is still missing in ksz_spi.c:88-100.


Thanks in advance.

Kind regards, J=C3=B6rg

--=20
Manchmal denke ich, das sicherste Indiz daf=C3=BCr, da=C3=9F anderswo im Un=
iversum
intelligentes Leben existiert, ist, da=C3=9F niemand versucht hat, mit uns
Kontakt aufzunehmen.                           (Calvin und Hobbes)

--z2zwuqovvefd5sle
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABEIAB0WIQS1pYxd0T/67YejVyF9LJoj0a6jdQUCZ1P+/QAKCRB9LJoj0a6j
dYn4AP9CcxlHDZwt7VVy+Ms5q/aRnPP9vW1bkIFxeAphHujNAwD/UdHk8Lo/VHz3
rbhcDHOgCzni5vWov9lGTeYuN2zy6SA=
=TIo5
-----END PGP SIGNATURE-----

--z2zwuqovvefd5sle--

