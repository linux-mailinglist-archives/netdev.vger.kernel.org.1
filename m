Return-Path: <netdev+bounces-87499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C13B8A34A5
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 19:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D67AF1C21FEF
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 17:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D5414D29E;
	Fri, 12 Apr 2024 17:23:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2CB148FE0
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 17:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712942630; cv=none; b=cwkZpRWT517+hsy38rJPFpeRseyH0EUDejvQJ/27GmZi3sqcrUPK/s33Z56aHemFzOUXiyDQVQxMec0X0EJV777UDEN2l7XebtxOOx5sPg4+u7JqcjLwKlcrKSHm6qo1/nnRY30PdcBZenynbA3L5/OBDbOFXMW7JY0WTcIlMW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712942630; c=relaxed/simple;
	bh=dS8is4oS/HwVsHM1/DmVT+Gjyg4PdsgmFNnRgJ/QDFE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=euZrmMb0P8xrSIo95BnLRVEEttjS/E1v06JGfwifvpgs8dw2rmQNfsU37it1YZcIRRp18h3D43FIM0orxV0nArPvSqNURVS3Bks0dwlr04x9TTPJULhhtZ07Hur3UDXNe80yNBRx2DVXWG3Fr121s7b6D0nxiDdD7sJ0r6xur34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-148-ZquVXkwYOmKWQng32vNsPw-1; Fri, 12 Apr 2024 18:23:38 +0100
X-MC-Unique: ZquVXkwYOmKWQng32vNsPw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 12 Apr
 2024 18:23:10 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 12 Apr 2024 18:23:10 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Eric Dumazet' <edumazet@google.com>, "David S . Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "eric.dumazet@gmail.com" <eric.dumazet@gmail.com>
Subject: RE: [PATCH net 0/3] net: start to replace copy_from_sockptr()
Thread-Topic: [PATCH net 0/3] net: start to replace copy_from_sockptr()
Thread-Index: AQHaiY6496QoEOBT80a0W2BpSdo75LFk5uNA
Date: Fri, 12 Apr 2024 17:23:10 +0000
Message-ID: <01ec9cbaedbd4d91976d10308b7b8e2d@AcuMS.aculab.com>
References: <20240408082845.3957374-1-edumazet@google.com>
In-Reply-To: <20240408082845.3957374-1-edumazet@google.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogRXJpYyBEdW1hemV0DQo+IFNlbnQ6IDA4IEFwcmlsIDIwMjQgMDk6MjkNCj4gDQo+IFdl
IGdvdCBzZXZlcmFsIHN5emJvdCByZXBvcnRzIGFib3V0IHVuc2FmZSBjb3B5X2Zyb21fc29ja3B0
cigpDQo+IGNhbGxzLiBBZnRlciBmaXhpbmcgc29tZSBvZiB0aGVtLCBpdCBhcHBlYXJzIHRoYXQg
d2UgY291bGQNCj4gdXNlIGEgbmV3IGhlbHBlciB0byBmYWN0b3JpemUgYWxsIHRoZSBjaGVja3Mg
aW4gb25lIHBsYWNlLg0KPiANCj4gVGhpcyBzZXJpZXMgdGFyZ2V0cyBuZXQgdHJlZSwgd2UgY2Fu
IGxhdGVyIHN0YXJ0IGNvbnZlcnRpbmcNCj4gbWFueSBjYWxsIHNpdGVzIGluIG5ldC1uZXh0Lg0K
DQpJIGhhdmUgd29uZGVyZWQgaWYgJ3NvY2twdHInIHNob3VsZCBiZSBjaGFuZ2VkIHRvIGluY2x1
ZGUgdGhlDQpsZW5ndGggYW5kIHRoZW4gcGFzc2VkIGJ5IHJlZmVyZW5jZS4NClRoYXQgd291bGQg
d29yayAncmVhZG9ubHknIGZvciBtb3N0IGNvZGUsIGJ1dCB0aGVyZSBhcmUgc29tZSBzdHJhbmdl
DQpvcHRpb25zIHRoYXQgZG9uJ3Qgb2JleSB0aGUgZXhwZWN0ZWQgcnVsZXMuDQpBdCBsZWFzdCBv
bmUgaGFzIGEgJ3JlY29yZCBjb3VudCcgaW4gdGhlICdub3JtYWwnIGJ1ZmZlciBhbmQgdGhlDQpy
ZXN0IG9mIHRoZSBkYXRhIGZvbGxvd3MgLSBhbiBhY2NpZGVudCB3YWl0aW5nIHRvIGhhcHBlbg0K
KGVzcGVjaWFsbHkgaWYgY2FsbGVkIGJ5IGJwZikuDQoNCkkgbXVzdCBmaW5kIHRpbWUgdG8gcHJv
ZCB0aGUgYnBmIHBlb3BsZSBhYm91dCBjaGFuZ2luZyBzb2NrcHRyX3QNCnRvIGJlIGEgc3RydWN0
IGluc3RlYWQgb2YgYSB1bmlvbiAtIGFsc28gc2FmZXIuDQoNClRoZSBvdGhlciBvYnZpb3VzIGNo
YW5nZSBpcyB0byBwdWxsIHRoZSB1c2VyY29weSBmb3IgdGhlIGxlbmd0aA0KYWxsIHRoZSB3YXkg
b3V0IG9mIGdldHNvY2tvcHQoKSB0byB0aGUgc3lzY2FsbCB3cmFwcGVyLg0KSSBzdGFydGVkIHdy
aXRpbmcgYSBwYXRjaCB0byB1c2UgdGhlIHJldHVybiB2YWx1ZSBmb3IgdGhlIHVwZGF0ZWQNCmxl
bmd0aCAtIGJ1dCBzb21lIG9mIHRoZSBjb2RlIGlzIHRvbyBwZXJ2ZXJ0ZWQuDQoNCglEYXZpZA0K
DQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFy
bSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAo
V2FsZXMpDQo=


