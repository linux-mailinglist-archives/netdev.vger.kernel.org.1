Return-Path: <netdev+bounces-103446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F375690810A
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 03:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E6071C2151D
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 01:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B79E18309C;
	Fri, 14 Jun 2024 01:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="dD7SW9eU"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F8A157A43
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 01:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718329786; cv=none; b=YEHxexSSeXdpcrJ8vAPpGhCZHXl7tyinFG9NFeoOVOTlmqfOwRSjv18XTgcgnKTfIdoMLEhDITj2OwK21eLL3tj1BkdVZCl3q6SBiReYgYdZfrAkfW+z50HMJ/P0M4FRPSPbJRL+E59E4uhUKMmEFRCdQVRjGlcb58HQudAdlKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718329786; c=relaxed/simple;
	bh=zECuM+kBREysbEmuYy+3OxQOBl3peTJV5i3RWRI+tFE=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VjS1Rye1TCtpothamfqe45Hb7jWhJTOQdMCswiauXjfTVRJqxlX81UxTEej5Jb7GL7QTjiFz2aPsdrvcdGWJb2vw2+36KJIPTQ0xiG5Q9soAB6ix6NrpxOvdXa5vmWk6/oJMGieQXU6gDfC7DC4fgPNaY3pOdKU1PZzpbnOGsx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=dD7SW9eU; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id A15A72C01F6;
	Fri, 14 Jun 2024 13:49:35 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1718329775;
	bh=zECuM+kBREysbEmuYy+3OxQOBl3peTJV5i3RWRI+tFE=;
	h=From:To:CC:Subject:Date:From;
	b=dD7SW9eUPDuFVBY9wE4gynh7COntzVVYxNT63YJCBvh1wI+cfo3DCkb3+ewIyaL5V
	 KofUY5+QkWNVox0N413Fi9yub4Zq6E90Ihnu/iS2cp/UQxHAZI65KfSzhc0iYbxcZU
	 hVirVgZn18wVDyvlS9bAc+16RbJgj10wgDj/EzTCYSOoGJI0lJaLrbcBHKUHWRlmQF
	 w+LbY8t6MxqAWQmr5rb4Dm6+VFcqPd7AmxqaRiQg+OXckdapcrdBmg5oOxEpjR6Orj
	 EHS4fsKPnR+v3eaZkzLFllGy91yrgpGVveOwmkGuDl3EnMrD0FKjKkioRdPyy/2VSq
	 M8aUi5vonOKYA==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B666ba1af0001>; Fri, 14 Jun 2024 13:49:35 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 14 Jun 2024 13:49:35 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.011; Fri, 14 Jun 2024 13:49:35 +1200
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"alsi@bang-olufsen.dk" <alsi@bang-olufsen.dk>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>, "olteanv@gmail.com"
	<olteanv@gmail.com>, =?utf-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>,
	"ericwouds@gmail.com" <ericwouds@gmail.com>
CC: David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"luizluca@gmail.com" <luizluca@gmail.com>, "justinstitt@google.com"
	<justinstitt@google.com>, "rmk+kernel@armlinux.org.uk"
	<rmk+kernel@armlinux.org.uk>, netdev <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: net: dsa: Realtek switch drivers
Thread-Topic: dsa: Realtek switch drivers
Thread-Index: AQHavf0bnp2fEmABNEu2NcsQo6lz5Q==
Date: Fri, 14 Jun 2024 01:49:35 +0000
Message-ID: <aa5ffa9a-62cc-4a79-9368-989f5684c29c@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <867CA41822A9F046AC91F6D0C65FFB83@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=CvQccW4D c=1 sm=1 tr=0 ts=666ba1af a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=T1WGqf2p2xoA:10 a=i_NKSM1G_qOCjhhImq0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

SGkgQWxsLA0KDQpJJ20gc3RhcnRpbmcgdG8gbG9vayBhdCBzb21lIEwyL0wzIHN3aXRjaGVzIHdp
dGggUmVhbHRlayBzaWxpY29uLiBJIHNlZSANCmluIHRoZSB1cHN0cmVhbSBrZXJuZWwgdGhlcmUg
YXJlIGRzYSBkcml2ZXJzIGZvciBhIGNvdXBsZSBvZiBzaW1wbGUgTDIgDQpzd2l0Y2hlcy4gV2hp
bGUgb3BlbndydCBoYXMgc3VwcG9ydCBmb3IgYSBsb3Qgb2YgdGhlIG1vcmUgYWR2YW5jZWQgDQpz
aWxpY29uLiBJJ20ganVzdCB3b25kZXJpbmcgaWYgdGhlcmUgaXMgYSBwYXJ0aWN1bGFyIHJlYXNv
biBuby1vbmUgaGFzIA0KYXR0ZW1wdGVkIHRvIHVwc3RyZWFtIHN1cHBvcnQgZm9yIHRoZXNlIHN3
aXRjaGVzPyBJZiBJIHdlcmUgdG8gc3RhcnQgDQpncmFiYmluZyBkcml2ZXJzIGZyb20gb3Blbndy
dCBhbmQgdHJ5aW5nIHRvIGdldCB0aGVtIGxhbmRlZCB3b3VsZCB0aGF0IA0KYmUgYSBwcm9ibGVt
Pw0KDQpUaGFua3MsDQpDaHJpcw0K

