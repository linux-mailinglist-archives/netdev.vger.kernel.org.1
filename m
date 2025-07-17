Return-Path: <netdev+bounces-207994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A211B0938D
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 19:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A91ED166A43
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 17:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3679828507C;
	Thu, 17 Jul 2025 17:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="BVUwV39I"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184881BC9E2;
	Thu, 17 Jul 2025 17:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752774360; cv=none; b=kLSXV5ESgqOFvtd1EtKJr++f6V2k6L8+A63RrGV50FZDOjD7K0IpYOZTxMp1s8mBncEEQe0Gjyxevo471P5YlPv52cDvu9o/Kh0XBFZtPiuK55iwkkLNyez3E5Qt7cpd4n5opiQcXOlhxNTc91q/HhW0HNhMn/BCuOmPKRib+Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752774360; c=relaxed/simple;
	bh=jSg9M9xq3ydADWKsrSUaLkgM7GusH07ANZzgpTiTznw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G8ItsPTubD9psit0Bs1iBlXHmvtMhayITHiFXpCv3BjRh3DNjjXT67stt0kadiJkxleSb7f0XAc6fsKKoB+smx6TvIXczqyWCK1Y316Jy0Zmyb/n9rUciFileE4qzO5auPXbF+Sj97Ptzrj3Z4h15EvIy3dZtYB/zFMZTTIeOG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=BVUwV39I; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56HHjFXv9294376, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1752774315; bh=YJ+zT5/MB62bjNXoBMwmCBRMXQ3+FNMGUJo9CZpwvqI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=BVUwV39I5SJV4QhxXelrZhk+9YIh9Et3Qb2DEEoVbcz11hcBFqs3ywTi3ik6LiK+T
	 UT4bEOq0w1gYWMZy0A6fy4XM9m/Y4UR+oyv83+h4vjUMltGw9rEM5joycE8pt3qbRE
	 6glPdmagMCAOFWeLY7PtlzF6oSSX2sVkta3JgepVND2+WO59eCsNt/Nf7BtpgQ7a9X
	 4fkVAyH6WnkjEUu0OSYG6KfIScS48LxxDOr3gwmjq3P8T6sYamkoOk/1k+V8l72IOy
	 C4k5yGc9UzmUTHMuex9Ve44o4zbb4K3THyvl0Xm1Pi4Xf+JMKFBYUBJf/+IrXEnRon
	 uhQDjiOY6dwpQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56HHjFXv9294376
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 01:45:15 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 18 Jul 2025 01:45:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 18 Jul 2025 01:45:13 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::81fc:50c6:85d5:cb47]) by
 RTEXMBS04.realtek.com.tw ([fe80::81fc:50c6:85d5:cb47%5]) with mapi id
 15.01.2507.035; Fri, 18 Jul 2025 01:45:13 +0800
From: Hau <hau@realtek.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        nic_swsd
	<nic_swsd@realtek.com>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next] r8169: add quirk for RTL8116af SerDes
Thread-Topic: [PATCH net-next] r8169: add quirk for RTL8116af SerDes
Thread-Index: AQHb8hYZ3m83qQJc5k6oVaa3M0JZALQvxoaAgAH73gD//33vgIAFX8dQ
Date: Thu, 17 Jul 2025 17:45:13 +0000
Message-ID: <c8bf99d9c3fc49958bad7f66863f72c2@realtek.com>
References: <20250711034412.17937-1-hau@realtek.com>
 <9291f271-eafe-4f65-aa08-3c6cb4236f64@lunn.ch>
 <50df9352e81e4688b917072949b2ee4c@realtek.com>
 <e571d596-da26-4596-bf90-b858b5a2f5b4@lunn.ch>
In-Reply-To: <e571d596-da26-4596-bf90-b858b5a2f5b4@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> On Mon, Jul 14, 2025 at 03:28:37PM +0000, Hau wrote:
> > >
> > > Can you give us a few more details. What is on the other end of the
> SERDES?
> > > An SGMII PHY? An SFP cage? An Ethernet switch chip?
> > >
> > > A quick search suggests it is used with an SFP cage. How is the I2C
> > > bus connected? What about GPIOs? Does the RTL8116af itself have
> > > GPIOs and an I2C bus?
> > >
>=20
> > RTL8116af 's SERDES will connect to a SFP cage. It has GPIO and a I2C
> > bus. But driver did not use it to access SFP cage.  Driver depends on
> > mac io 0x6c (LinkStatus) to check link status.
>=20
> You cannot correctly use an SFP cage without using the I2C bus and the
> GPIOs. e.g. A copper SFP module likely needs SGMII, where as a fibre
> module needs 1000BaseX. You need to reprogram the PCS depending on
> what the SFP EEPROM says.
>=20
> The kernel has all the code needed to coordinate this, phylink. All you n=
eed
> to do is write a standard Linux I2C bus driver, a standard Linux GPIO dri=
ver,
> and turn your PCS into a Linux PCS. You can then instantiate an SFP devic=
e.
> The txgbe driver does this, you can probably copy the code from there.
>=20
> Have you licensed these parts? The txgbe hardware uses synopsys I2C and
> PCS. So all that was needed was a wrapper around the existing drivers.
>=20
Thanks for your advice. I will check this internally to see if we can do th=
is on device.

Thanks.

