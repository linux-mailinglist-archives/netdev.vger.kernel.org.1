Return-Path: <netdev+bounces-109712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 048D1929B1B
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 05:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 907EB1F213FA
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 03:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185765684;
	Mon,  8 Jul 2024 03:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="AFsSbFrc"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A95803
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 03:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720409854; cv=none; b=ronHGjM1VdVVzw12rVR9HDJuQugnA1qh4141NztNSTT3Fl4NdHeM14JdTCMiBy5tvMG2z3CT8AFDZXq/TX1nlZVOjedrsUY/U623Jm3HUoCt0Wd62Y8Ve4nESIeJbc4jcYJlRDstwU0fIJpUbVbXCNKTojl+s4jg1GNFGtqG20I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720409854; c=relaxed/simple;
	bh=nZtb3fqtHjQYbnr4/EHlFVLBCsry2py38iWT0smA61k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GYdJTcbnlzgLIzGxLJpdHMCHWVtCI7Ugz323YphXPavsQXAxXgaopwne1LbAH5Sz0eAElN4Z8HhDQqsei6YQLjQpyzKQCKKUI3rjuKSQtm91btYeTY5tlRlCGAUX66dFvLpm+lIbZZjc+WZnVpM+hYLDyAT0m5mH0Xf33POLmfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=AFsSbFrc; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 23F382C05E1;
	Mon,  8 Jul 2024 15:37:29 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1720409849;
	bh=nZtb3fqtHjQYbnr4/EHlFVLBCsry2py38iWT0smA61k=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=AFsSbFrcdINZ//uoaKjMnpmH2Njs8tesAYHsuBlIlLO9e1JVuqJvIVMvxPgM+2YLc
	 LBF4JK1foD+MMhehS90WsjGn01ADHeSyuwzE8pEq/RQINPCzGGYyfPNaQ7KLGnGgUs
	 3TUVJnNoq7/57HzyNDs5O602VqmYwFJtGKdkao98HvRC+v3d/MVxlGQlLa5jmot2lQ
	 XNKcD5QyJQ11/oln8G91KRbbd4jXLYEuUiioqZ5Hcw7rcuI3+xqMvJ6IVwzzRDnHnf
	 /BWULKXhfcosVUGx4/cDj4RadYVouzCDt0IgR0/vLWn4slgIlEdQcdWMb7wpe4EajE
	 8GxboMzEOxqTQ==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B668b5ef90000>; Mon, 08 Jul 2024 15:37:29 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 8 Jul 2024 15:37:28 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.011; Mon, 8 Jul 2024 15:37:28 +1200
From: Elliot Ayrey <Elliot.Ayrey@alliedtelesis.co.nz>
To: "tobias@waldekranz.com" <tobias@waldekranz.com>, "davem@davemloft.net"
	<davem@davemloft.net>
CC: "razor@blackwall.org" <razor@blackwall.org>, "bridge@lists.linux.dev"
	<bridge@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"roopa@nvidia.com" <roopa@nvidia.com>
Subject: Re: [PATCH net] net: bridge: mst: Check vlan state for egress
 decision
Thread-Topic: [PATCH net] net: bridge: mst: Check vlan state for egress
 decision
Thread-Index: AQHazoeK2RFj5W41rU2gTV+Zn4+o7LHn52SAgAOCsgA=
Date: Mon, 8 Jul 2024 03:37:28 +0000
Message-ID: <e321ca8e6d737034d4fa19fe89f2e8373d683cae.camel@alliedtelesis.co.nz>
References: <20240705030041.1248472-1-elliot.ayrey@alliedtelesis.co.nz>
	 <87plrrfqi0.fsf@waldekranz.com>
In-Reply-To: <87plrrfqi0.fsf@waldekranz.com>
Accept-Language: en-US, en-NZ
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <BDCAAD65A35A4045B2010C478E20D3D6@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=CvQccW4D c=1 sm=1 tr=0 ts=668b5ef9 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=nyesw9g_oEEA:10 a=IkcTkHD0fZMA:10 a=4kmOji7k6h8A:10 a=Aqyi4vuZLlZgQ7HhWL8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

T24gU2F0LCAyMDI0LTA3LTA2IGF0IDAwOjAwICswMjAwLCBUb2JpYXMgV2FsZGVrcmFueiB3cm90
ZToNCj4gSSB0aGluayBpdCBtaWdodCByZWFkIGEgYml0IGJldHRlciBpZiB3ZSBtb2RlbCBpdCBs
aWtlIHRoZSBoYWlycGluIGNoZWNrDQo+IGFib3ZlLiBJLmUuIChzcGVjaWFsX21vZGUgfHwgcmVn
dWxhcl9jb25kaXRpb24pDQo+IA0KPiBJdCdzIG5vdCByZWFsbHkgdGhhdCB0aGUgc3RhdGUgaXMg
Zm9yd2FyZGluZyB3aGVuIG1zdCBpcyBlbmFibGVkLCB3ZQ0KPiBzaW1wbHkgaWdub3JlIHRoZSBw
b3J0LWdsb2JhbCBzdGF0ZSBpbiB0aGF0IGNhc2UuDQo+IA0KPiA+IC0JCXAtPnN0YXRlID09IEJS
X1NUQVRFX0ZPUldBUkRJTkcgJiYgYnJfYWxsb3dlZF9lZ3Jlc3ModmcsIHNrYikgJiYNCj4gPiAr
CQlzdGF0ZSA9PSBCUl9TVEFURV9GT1JXQVJESU5HICYmIGJyX2FsbG93ZWRfZWdyZXNzKHZnLCBz
a2IpICYmDQo+IA0KPiBzbyBzb21ldGhpbmcgbGlrZToNCj4gDQo+ICAgICAuLi4NCj4gICAgIChi
cl9tc3RfaXNfZW5hYmxlZChwLT5icikgfHwgcC0+c3RhdGUgPT0gQlJfU1RBVEVfRk9SV0FSRElO
RykgJiYNCj4gICAgIGJyX2FsbG93ZWRfZWdyZXNzKHZnLCBza2IpICYmIG5icF9zd2l0Y2hkZXZf
YWxsb3dlZF9lZ3Jlc3MocCwgc2tiKSAmJg0KPiAgICAgLi4uDQoNClllcyB5b3UncmUgcmlnaHQs
IHRoYXQncyBtdWNoIGNsZWFyZXIuIEknbGwgZ28gd2l0aCB0aGF0Lg0K

