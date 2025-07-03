Return-Path: <netdev+bounces-203655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A40BAF6A29
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 08:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5ABA7B0EAC
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 06:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D960D27A904;
	Thu,  3 Jul 2025 06:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="tm+jYaq2"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CA62DE706
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 06:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751523516; cv=none; b=uYHO3ocmgbMo1ivVK8wRzFXa+8JPETlFngc2VA9eO/PX7f8C94TzMH89gy4ffHPKAcLZ0UWplqqKTP7+QcFaWd+y/HSFLmTx5jmdkSqXxm4WZIWzskxV2+KdtE2FhPk0QL23BRltsI9ZskYRE0CMUKO5A4df2X8YrrONMO//LNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751523516; c=relaxed/simple;
	bh=Gj8gWWdpyd8wCl7bWLIKUJ1mXeU1372Zc8dmU6OHMLg=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=FTOZHZP2gM1cyFtpBt1dRIOcQIKKGGFRbdkvOkpsx4QA5I/dQ+RETobAsOdMdS7KT31gv2J6BeGaGa90yr/rcsLNaKcDsGVlka48lV70p2q1bYOyeQO5sFmZXrMZhtgD//eEctY+oV1ic25QewzUNt+5/nggnSNMhU7/hCq13dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=tm+jYaq2; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1751523487; x=1752128287;
	i=markus.stockhausen@gmx.de;
	bh=4Iv7iB9MR/a4K478tZ2QbG92JFO8gYqgiOpH2P6crgw=;
	h=X-UI-Sender-Class:From:To:Cc:References:In-Reply-To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tm+jYaq26Y0x7c20DR3QAHYGu6dCmjWYpLH5Q8yQDD3Uk+wm1CzsbaLH61Pn4GD3
	 6zbb+qxLrh7CY9GSz5Ta9GOQLkxWtrF6qxilfmiSxZFnLNYBsbeuA+LBBTjNt5apQ
	 oSxjZS1t5xMH94j7UeUagR9AnnpzQAsr2JMJ/DdAOq6fWhDgjgGGgKxJWIrZAlM3E
	 dUVBwNbP3F9boF60s51U37+K+4MHosC62XiZ2LdhhB5N8oRcan/4rz+uS74UlpjX6
	 21XEpFjXzyaacLgS9FdIvvLcYaOQJCvBGQughbmNwQ6BvE2EZtXxNn99ZAWdyOFo4
	 LJXQnhgdBCLYZkRMgg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from colnote55 ([94.31.70.55]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mt79F-1urVCx3AmP-013H2S; Thu, 03
 Jul 2025 08:18:06 +0200
From: <markus.stockhausen@gmx.de>
To: <kuba@kernel.org>,
	"'Andrew Lunn'" <andrew@lunn.ch>
Cc: <linux@armlinux.org.uk>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<pabeni@redhat.com>,
	<michael@fossekall.de>,
	<daniel@makrotopia.org>,
	<netdev@vger.kernel.org>,
	"'Chris Packham'" <Chris.Packham@alliedtelesis.co.nz>,
	<hkallweit1@gmail.com>
References: <20250617150147.2602135-1-markus.stockhausen@gmx.de> <6e0e38b4-db64-4b63-ac36-4a432b762767@lunn.ch> <788b01dbe016$b92c4470$2b84cd50$@gmx.de> <e63c2332-ade2-4c93-be21-a550125c543e@alliedtelesis.co.nz> <5a1c5a4a-284e-47c6-af6f-cd95ac08b680@alliedtelesis.co.nz> 
In-Reply-To: 
Subject: AW: AW: [PATCH] net: phy: realtek: convert RTL8226-CG to c45 only
Date: Thu, 3 Jul 2025 08:18:00 +0200
Message-ID: <012b01dbebe2$3e0da720$ba28f560$@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: de
Thread-Index: AQHIkk1ZwrMdRrTYJJUEkbagN+qSQAGXWE03AJQn/QkCcrSzcwKzQYB/AX2FL/y0ACZ3sA==
X-Provags-ID: V03:K1:kPZ1tp8TOBDL5YBL5XQ4h2C3D50s5bsOwzRrFsUISKdx7e4A55l
 yIhUJpE4AW7yi5Cu22kjnKYtnjrfh7r1Pxuk4VeIOY5CAz03fvjsAIJgTaUCUnUygnS55QQ
 fKDJ6kM7SOsFSBM3Orzi+BP6afI+lzgfkEDHM41KrRwRl1rm3/+l3bed5ZDaeTyJMZIMeSw
 ak7YKYQ1X+Wz+YirJdhlQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:efHwzXJlRyY=;D8cSSbnNyBikxG4RDXwlIkPcEl8
 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

Hi,

> Von: markus.stockhausen@gmx.de <markus.stockhausen@gmx.de>=20
> Gesendet: Donnerstag, 19. Juni 2025 08:23
>
> > Von: Chris Packham <Chris.Packham@alliedtelesis.co.nz>=20
> > Gesendet: Donnerstag, 19. Juni 2025 04:48
> >
> > So I did another check. If I clear INTF_SEL bits in SMI_GLB_CTRL the =

> > switch will not detect the link status correctly. C45 MDIO access =
from=20
> > the kernel seems to work regardless.
> >=20
> > This is using the Realtek u-boot to do some HW init and my as yet=20
> > unpublished switchdev driver for the RTL9300. Something somewhere =
needs=20
> > to configure SMI_GLB_CTRL so the switch will get the port link =
status=20
> > correctly. It doesn't have to be the mdio driver, if I remove that =
code=20
> > completely everything still works (it's using the SMI_GLB_CTRL value =

> > that has been put there by Realtek's U-Boot).
>
> Thanks for the test. This fits some of my observations but has other
> dependencies on polling. Some c45 registers are still blocked. To find =

> a perfect solution that switches polling off/on and toggles the bus=20
> c22/c45 on demand will need a lot of testing.
> =20
> See also notes from my recent addition:
> =
https://github.com/openwrt/openwrt/blob/c9e934ffd87774a64fa0c8a2af92373ef=
1d0894f/target/linux/realtek/files-6.12/drivers/net/phy/rtl83xx-phy.c#L11=
72
>
> To sum it up. On those devices it is only safe to stay in a single
> clause access. Converting the RTL8226 from the current mixed  =20
> mode access should be hopefully ok.

Is there anything else you want me to do?

Best regards.

Markus


