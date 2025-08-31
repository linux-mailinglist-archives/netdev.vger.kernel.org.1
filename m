Return-Path: <netdev+bounces-218536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5199BB3D143
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 09:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08F2117C803
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 07:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100EE1E3DD7;
	Sun, 31 Aug 2025 07:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="PKve0ihp"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B7179CD
	for <netdev@vger.kernel.org>; Sun, 31 Aug 2025 07:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756626354; cv=none; b=UOzv91Rvlyr4DE9yec3wpzqlTO8bAwIm/hhBjMjYywn81BO2wraeAz3pJrM3Zzjj3Z5/K32tKEVGsiT9bWsMWkaxCg3cEM3/jQf36ZDYT9ZDpJy0RZJDu5zsN4nfSM2+dSg/EFBqXzAPfQOAVhXh1hZ5Gx3+rgZzzzzvz7i9lgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756626354; c=relaxed/simple;
	bh=tVj3DzcUI3foj7DJE6+76LchUfLDxf9igkiEULU+ScU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a7v+Ckz785f63LR9SLM2sPGZCXwiiwdNFBngLZ4F0jS4CR8eadGxGqmxsl85pAcTl/QvggJCwCr3kpqhJ7Q0xQHSmUF25OJpZ7OuXzXdtisqTU64hcBDQvr+aN4hjamBcoFqgVM2YjzfMP8W8QdntpvY2ZF3pl2NvPSXk7iSQzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=PKve0ihp; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1756626350; x=1757231150;
	i=markus.stockhausen@gmx.de;
	bh=mfZ2R8mqQg2Xkvmq+6A+9tjLmmGs94AMeOaRvrpb7ig=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PKve0ihp0rrGexdOYdrnvchrE1cLpJtOFxgO34IRF3F+G4OgZAt1lDST8IOWpldw
	 CWkZ82HRWpWHUdvffHc3dz+ratwZS1HqCGjV2Pd4BKugPXNkbRm61jq4qoAPxHwUH
	 HfyIr3D7ry2A9QOogwC0qvaK/KgLz3iWIMj6I+JsarMpayacHK2CjaPlwjRVDVitK
	 CEi2KzKI9XH80wr7MRNLcQ0j9etISkZhcjVY0Q/dbooDWYsNm5FDH/E79fu5h1Uq9
	 XjyV60us6Pt8SmoPX+cdO1Zoc14o91UUSrFOlV4ybxc+cBopFFFZqrAZ61tswt0OI
	 29lzOSWruCn0lBpTMg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from colnote55 ([94.31.70.55]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M89Gj-1unNpl0cUt-008lIN; Sun, 31
 Aug 2025 09:45:50 +0200
From: <markus.stockhausen@gmx.de>
To: <andrew@lunn.ch>,
	<hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<netdev@vger.kernel.org>
Cc: <jan@3e8.eu>,
	"'Chris Packham'" <chris.packham@alliedtelesis.co.nz>
Subject: C22/C45 decision in phy_restart_aneg()
Date: Sun, 31 Aug 2025 09:45:46 +0200
Message-ID: <009a01dc1a4b$45452120$cfcf6360$@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: de
Thread-Index: AdwaSRidBM/J0VLkS3KSZs8FeWE8nw==
X-Provags-ID: V03:K1:gbktAY+ma9eMF0t4QmOuqhByCM8/XqqM8DSi8s883Qr/F35ZqJq
 ppUQf7hHSHaX0fp6i28YC5dLHtg1dihtuUewGkkks2WcgdqJzcOwii5q9Xz3Hyoc0v1hjJn
 dlXZgD6xl3bg1KYOmOwLieT2zrGZJ50Q73mE4jn6wnF2grp2AssSYE36iow/pyEwTk7Ohd6
 YCkzZ2tSQ4aaMh8vFkNmA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DJ56I4wURYU=;c0bHX6ADMD7aK9zVMXjPdQrLd3e
 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

Hi,

@Russell: Sorry for the inconvenience of my first mail. After a lengthy
analysis session, I focused too much on the initial C45 enhancement=20
of the below function that you wrote. I sent it off too hastily.

So, once again, here is some interesting finding regarding the=20
limitations of the Realtek MDIO driver. Remember that it can only run=20
in either C22 or C45. This time it is about autonegotiation restart.

int phy_restart_aneg(struct phy_device *phydev) {
  int ret;

  if (phydev->is_c45 && !(phydev->c45_ids.devices_in_package & BIT(0))
    ret =3D genphy_c45_restart_aneg(phydev);
  else
    ret =3D genphy_restart_aneg(phydev);

  return ret;
}

I assume that BIT(0) means MDIO_DEVS_C22_PRESENT. As I understand it,
this basically uses C22 commands for C45 PHYs if C22 support is detected.
Currently, I have no reasonable explanation for this additional check.
=20
In our case, this function fails for C45 PHYs because the bus and PHY are=
=20
locked down to this single mode. It's stupid, of course, but that's how=20
it is. I see two options for fixing the issue:

1) Mask the C22 presence in the bus for all PHYs when running in C45.
2) Drop the C22 condition check in the above function.

Any advice?

Thanks in advance.

Markus


