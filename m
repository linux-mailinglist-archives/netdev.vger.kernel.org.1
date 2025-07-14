Return-Path: <netdev+bounces-206749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71260B0442B
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 17:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21DFC3BB004
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 15:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0282676EB;
	Mon, 14 Jul 2025 15:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="nRCiH0M9"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17C8264A73;
	Mon, 14 Jul 2025 15:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506962; cv=none; b=R9gw07Z35NB0T1YxoK+4N8JZpTX8ma0+DMj6aEQjs6/osEKgdAwaXRxUUZwlhOabZ49cyL0Kk3kbLBYcQkbnaDz3nOZBpGr4bTtG/cf3oXitor7Lw2iSqtmvoW4U9JFMoZYpbakgLWaLAGNjOYvgRoyVi/R0IkuWg6GlfHikEMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506962; c=relaxed/simple;
	bh=kH+76pQfe8h+nA25aD3uhXFxx4VONMtqA+YpB33JP94=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZneXn3PQE2fdF/BVqoPnkVmAHnliGls9qxWhSzWJrWPlk7TIRaSEjNnFCWnBn/VFhdHMmAXkj6Cx1TrqbzX/X4jiQYPFBDQGV1wi8bZ+bD/mV/hFToYDIOsY1wHNuHqVybmZtdVofGrY6eQpQh/9NH5WsQ5bRNvGjAD9K+scj7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=nRCiH0M9; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56EFSctL62444685, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1752506918; bh=kH+76pQfe8h+nA25aD3uhXFxx4VONMtqA+YpB33JP94=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=nRCiH0M9XTTm+KVkMleEMU+EQFkvopUfvgApC7PkSX+yJu1mF6n5hJSxUpnBxMfj0
	 9ZsRmvCLon1TuuN4DZZyfogmbtBawZHeLdpvKr3KDZsOuUODA0hm+Gjd3VHOSM1bsQ
	 XL/+VvUCoh13bbDjF/X3FlFwdOWYNUrhuHKdNNoARBqXgm2XKMa4Q7307XVYAw/N6E
	 qdl/2FZ530FbKb9HzokeZdvVaATz+OaCoBLkfP5lRKH/HrlZHrYH1/7+biiHyBRZY+
	 cr+fe2AC8vZrXAwbOa53+GtJPHUdWuhR9BeDM/bkscT4MxASNH8CA7M4fkFQiSc1eT
	 mHtKLlGvbN0hw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56EFSctL62444685
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 23:28:38 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 14 Jul 2025 23:28:38 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 14 Jul 2025 23:28:37 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::81fc:50c6:85d5:cb47]) by
 RTEXMBS04.realtek.com.tw ([fe80::81fc:50c6:85d5:cb47%5]) with mapi id
 15.01.2507.035; Mon, 14 Jul 2025 23:28:37 +0800
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
Thread-Index: AQHb8hYZ3m83qQJc5k6oVaa3M0JZALQvxoaAgAH73gA=
Date: Mon, 14 Jul 2025 15:28:37 +0000
Message-ID: <50df9352e81e4688b917072949b2ee4c@realtek.com>
References: <20250711034412.17937-1-hau@realtek.com>
 <9291f271-eafe-4f65-aa08-3c6cb4236f64@lunn.ch>
In-Reply-To: <9291f271-eafe-4f65-aa08-3c6cb4236f64@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: en-US
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

>=20
> Can you give us a few more details. What is on the other end of the SERDE=
S?
> An SGMII PHY? An SFP cage? An Ethernet switch chip?
>=20
> A quick search suggests it is used with an SFP cage. How is the I2C bus
> connected? What about GPIOs? Does the RTL8116af itself have GPIOs and an
> I2C bus?
>=20
RTL8116af 's SERDES will connect to a SFP cage. It has GPIO and a I2C bus. =
But driver did not use it to access SFP cage.
Driver depends on mac io 0x6c (LinkStatus) to check link status.

