Return-Path: <netdev+bounces-201501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35192AE9942
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 10:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7630C4A2B41
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 08:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF972957AD;
	Thu, 26 Jun 2025 08:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SagXCEEb"
X-Original-To: netdev@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0265295D96
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 08:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750928145; cv=none; b=O02VRU4irxsrV78z1rulw1uxkH94WucaOgj9o/jZhXPv4W2ZA/DwwuxfmzNvRlyWJ57a5pTAWvPg8kmgVDmuunhhadjAlxGDeF7agGG8ZRNTcjwimMckgq3Sdkw0OKDmzz7qyHnzrAHVFBgc7LurOKGLEFb+iMFlYeDMEb6jXgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750928145; c=relaxed/simple;
	bh=mWX7aKjl0Jd3AqjcU4aLtzWaaD4+uW5x0wsJ/uh9uVA=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=sPYrlL7blYrfVPV7/46zwkpgqRIJF0hRj6CuLmjEFnumPHC1F8vEnJ+csI4N5ieztOCK0nGkbAywBH1HKYfTTkqodMosFHt6JcDUw3ftQUCDgyyRgUgSw8JPIm10ndHuYcgmo5gkWb4Oa+oV/Jk4ebjT1vj4ggUq2agAAk9Y5go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=SagXCEEb; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250626085535euoutp021e6a6778dee58bc54eca86bfa3c0440d~Mi9yqbb3e2159121591euoutp02m
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 08:55:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250626085535euoutp021e6a6778dee58bc54eca86bfa3c0440d~Mi9yqbb3e2159121591euoutp02m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1750928135;
	bh=mWX7aKjl0Jd3AqjcU4aLtzWaaD4+uW5x0wsJ/uh9uVA=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=SagXCEEb8e04Xbekm3mUlE1u0Dv6zmsVuUZcVlWdc3eNMAMPI9MpS7jfGBL60IEDF
	 UKu9l/QECglLoZmcxYSBFvu9ofSLcBMBrqWmZwy949ymbvH7a/pPbWLp9APe4eU0+n
	 ZCdej0cI51R9UFUTsPOfKiXwr5iTspilakECUnBM=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH 1/2] net/mdiobus: Fix potential out-of-bounds read/write
 access
Reply-To: j.raczynski@samsung.com
Sender: Jakub Raczynski <j.raczynski@samsung.com>
From: Jakub Raczynski <j.raczynski@samsung.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: Dan Carpenter <dan.carpenter@linaro.org>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Wenjing Shan
	<wenjing.shan@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <aFzzdP4Og_oim4-l@shell.armlinux.org.uk>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20250626085534eucms1p384ebc44f8f5b2c5bab9b7431512dc45b@eucms1p3>
Date: Thu, 26 Jun 2025 10:55:34 +0200
X-CMS-MailID: 20250626085534eucms1p384ebc44f8f5b2c5bab9b7431512dc45b
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250609153151eucas1p12def205b1e442c456d043ab444418a56
X-EPHeader: Mail
X-ConfirmMail: N,general
X-CMS-RootMailID: 20250609153151eucas1p12def205b1e442c456d043ab444418a56
References: <aFzzdP4Og_oim4-l@shell.armlinux.org.uk>
	<aEb2WfLHcGBdI3_G@shell.armlinux.org.uk>
	<20250609153147.1435432-1-j.raczynski@samsung.com>
	<0d51f36d-eee3-4455-a886-d6a979e8e891@sabinyo.mountain>
	<CGME20250609153151eucas1p12def205b1e442c456d043ab444418a56@eucms1p3>

On Wed, Jun 25, 2025 at 10:23:17AM -0500, Dan Carpenter wrote:
> On Mon, Jun 09, 2025 at 05:31:46PM +0200, Jakub Raczynski wrote:
> > > When using publicly available tools like 'mdio-tools' to read/write d=
ata
> > > from/to network interface and its PHY via mdiobus, there is no verifi=
cation of
> > > parameters passed to the ioctl and it accepts any mdio address.
> > > Currently there is support for 32 addresses in kernel via PHY_MAX_ADD=
R define,
> > > but it is possible to pass higher value than that via ioctl.
> > > While read/write operation should generally fail in this case,
> > > mdiobus provides stats array, where wrong address may allow out-of-bo=
unds
> > > read/write.
> > >
> > > Fix that by adding address verification before read/write operation.
> > > While this excludes this access from any statistics, it improves secu=
rity of
> > > read/write operation.
> > >
> > > Fixes: 080bb352fad00 (=22net: phy: Maintain MDIO device and bus stati=
stics=22)
> > > Signed-off-by: Jakub Raczynski <j.raczynski=40samsung.com>
> > > Reported-by: Wenjing Shan <wenjing.shan=40samsung.com>
> > > ---
> > >=C2=A0=20drivers/net/phy/mdio_bus.c=206=20++++++=0D=0A>=20>=20>=C2=A0=
=201=20file=20changed,=206=20insertions(+)=0D=0A>=20>=20>=0D=0A>=20>=20>=20=
diff=20--git=20a/drivers/net/phy/mdio_bus.c=20b/drivers/net/phy/mdio_bus.c=
=0D=0A>=20>=20>=20index=20a6bcb0fee863..60fd0cd7cb9c=20100644=0D=0A>=20>=20=
>=20---=20a/drivers/net/phy/mdio_bus.c=0D=0A>=20>=20>=20+++=20b/drivers/net=
/phy/mdio_bus.c=0D=0A>=20>=20>=20=40=40=20-445,6=20+445,9=20=40=40=20int=20=
__mdiobus_read(struct=20mii_bus=20*bus,=20int=20addr,=20u32=20regnum)=0D=0A=
>=20>=20>=C2=A0=0D=0A>=20>=20>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0loc=
kdep_assert_held_once(&bus->mdio_lock);=0D=0A>=20>=20>=C2=A0=0D=0A>=20>=20>=
=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(addr=20>=3D=20PHY_MAX_ADDR)=
=0D=0A>=20>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0return=20-ENXIO;=0D=0A>=20>=0D=0A>=20>=20addr=20is=20an=
=20int=20so=20Smatch=20wants=20this=20to=20be:=0D=0A>=20>=0D=0A>=20>=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(addr=20<=200=20addr=20>=3D=20PHY_=
MAX_ADDR)=0D=0A>=20>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0return=20return=20-ENXIO;=0D=0A>=20>=0D=0A>=20>=20I=
=20think=20that=20although=20addr=20is=20an=20int,=20the=20actual=20values=
=20are=20limited=20to=0D=0A>=20>=200-U16_MAX?=0D=0A=0D=0A>=200=20to=2031=20=
inclusive.=0D=0A=0D=0AShould=20not=20be=20an=20issue.=20User=20calls=20use=
=20struct=20mii_ioctl_data=20which=20forces=20type=20of=20u16=20so=20should=
=20not=20be=20a=20case.=20And=20some=20drivers=20force=20it=20too.=20Probab=
ly=20proper=20fix=20would=20be=20converting=20addr=20parameter=20to=20u16=
=20to=20have=20consistent=20API.

