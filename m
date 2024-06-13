Return-Path: <netdev+bounces-103077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D677906297
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 05:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03CB8283A6D
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 03:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5D712E1FE;
	Thu, 13 Jun 2024 03:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="PeG9XABi"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186A118028
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 03:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718248419; cv=none; b=B1K8SOyjGo5cl588G1ofqAOvNG4Y2V9yjwlWDosN5nHV3WbvAXpG3ac0vqCPdhRrAbKuDlH7sW9aCrB0jch+X6VY6EWkhwjou+9SaQ72keL/gSER5/wYMwTi3STeOcoZ5Rwrp9eu6vYHWCMKdusG/ZWB99CQ0lRmPLOcv9CKJQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718248419; c=relaxed/simple;
	bh=bHLA5gavBcIqlUal6SJkpaYlPxsANCM2pXN2xMKNbeo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bHEmSwb0Z4bsHw7m0CvPZXa9jz9IkNFgiistWEUfs8mOX60Q1E/lhBNyPniW10lNcSTOqmiGQyaBS3mdqukSHf0H3Xd07rHGym0h8peDYE30p6VYGgyHpyXJ+xmrEhgqE+ZJ/boYtQ7MLQZqenmslKM/6L85YiNxN7jZF/rWrLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=PeG9XABi; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id DDC842C04C9;
	Thu, 13 Jun 2024 15:13:34 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1718248414;
	bh=bHLA5gavBcIqlUal6SJkpaYlPxsANCM2pXN2xMKNbeo=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=PeG9XABiz7TpySbNKshR1fLC/RtK9ASvmYGGl5EYUTdohdqm9EMsq2MYanv5hE/Qr
	 iwHlE2G657wzULSxcMU23HjLHoy3WQjaUJZjbQuBy93tFJXRqJiGiWYIbaRp79h8pI
	 /0deg8B2fxjJ2GWx/MlUHlkWI4nISzaJyvG6YFCjlKaeRvCDQYaof/KBMju6XwxQdd
	 BRwXRPuTINZP9heAi+db0HJ0xCbLw2pv7L7vMO/ORwhoawQEIKmwpj0csIDjHRT9wC
	 cBfqd2Mh7w0TERgVq3QqrjULeMLaldZyoTIZ7GgFgGqfEyqbbzzgY0yzN1fSPYheUE
	 86bsTmjHXR2jw==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B666a63de0001>; Thu, 13 Jun 2024 15:13:34 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1544.11; Thu, 13 Jun 2024 15:13:34 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.48; Thu, 13 Jun 2024 15:13:34 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.011; Thu, 13 Jun 2024 15:13:34 +1200
From: Aryan Srivastava <Aryan.Srivastava@alliedtelesis.co.nz>
To: "kees@kernel.org" <kees@kernel.org>
CC: "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "davem@davemloft.net"
	<davem@davemloft.net>, "mw@semihalf.com" <mw@semihalf.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "kuba@kernel.org"
	<kuba@kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH v1] net: mvpp2: use slab_build_skb for oversized frames
Thread-Topic: [PATCH v1] net: mvpp2: use slab_build_skb for oversized frames
Thread-Index: AQHavTxCpfA370i+oU29gaqwaSvBMbHEOXoAgAACO4A=
Date: Thu, 13 Jun 2024 03:13:34 +0000
Message-ID: <6c2592c517878a69d37e1957d9624d83dbc982ab.camel@alliedtelesis.co.nz>
References: <20240611193318.5ed8003a@kernel.org>
	 <20240613024900.3842238-1-aryan.srivastava@alliedtelesis.co.nz>
	 <202406122003.E02C37ADD1@keescook>
In-Reply-To: <202406122003.E02C37ADD1@keescook>
Accept-Language: en-US, en-NZ
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <147F947C260E8A4FA6DCCA162D53100F@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=CvQccW4D c=1 sm=1 tr=0 ts=666a63de a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=w1vUsAckAk8A:10 a=IkcTkHD0fZMA:10 a=T1WGqf2p2xoA:10 a=VwQbUJbxAAAA:8 a=Wywsl4saE9poe7uNVnUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-SEG-SpamProfiler-Score: 0

T24gV2VkLCAyMDI0LTA2LTEyIGF0IDIwOjA1IC0wNzAwLCBLZWVzIENvb2sgd3JvdGU6DQo+IE9u
IFRodSwgSnVuIDEzLCAyMDI0IGF0IDAyOjQ5OjAwUE0gKzEyMDAsIEFyeWFuIFNyaXZhc3RhdmEg
d3JvdGU6DQo+ID4gU2V0dGluZyBmcmFnX3NpemUgdG8gMCB0byBpbmRpY2F0ZSBrbWFsbG9jIGhh
cyBiZWVuIGRlcHJlY2F0ZWQsDQo+ID4gdXNlIHNsYWJfYnVpbGRfc2tiIGRpcmVjdGx5Lg0KPiA+
IA0KPiA+IEZpeGVzOiBjZTA5OGRhMTQ5N2MgKCJza2J1ZmY6IEludHJvZHVjZSBzbGFiX2J1aWxk
X3NrYigpIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBBcnlhbiBTcml2YXN0YXZhDQo+ID4gPGFyeWFu
LnNyaXZhc3RhdmFAYWxsaWVkdGVsZXNpcy5jby5uej4NCj4gPiAtLS0NCj4gPiBDaGFuZ2VzIGlu
IHYxOg0KPiA+IC0gQWRkZWQgRml4ZXMgdGFnDQo+IA0KPiBUaGlzIGxvb2tzIGxpa2Ugc2ltaWxh
ciB1cGRhdGVzIGxpa2UgY29tbWl0IDk5YjQxNWZlODk4NiAoInRnMzogVXNlDQo+IHNsYWJfYnVp
bGRfc2tiKCkgd2hlbiBuZWVkZWQiKQ0KWWVhaCwgSSBub3RpY2VkIHRoYXQgd2hlbiBJIHdhcyBs
b29raW5nIGZvciBleGFtcGxlcyBvZiBvdGhlciAiRml4ZXMiDQp0YWdzIGZvciB0aGUgInNrYnVm
ZjogSW50cm9kdWNlIHNsYWJfYnVpbGRfc2tiKCkiIGNvbW1pdC4gSSBzdXNwZWN0DQp0aGVyZSBh
cmUgbWFueSBkcml2ZXJzIHRoYXQgd2lsbCBuZWVkIHRoaXMgImZpeCIuDQo+IA0KPiBSZXZpZXdl
ZC1ieTogS2VlcyBDb29rIDxrZWVzQGtlcm5lbC5vcmc+DQo+IA0KDQo=

