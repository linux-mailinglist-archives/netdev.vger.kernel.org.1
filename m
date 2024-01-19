Return-Path: <netdev+bounces-64422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 355B08330D4
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 23:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3EBCB23A5D
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 22:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C4656B7B;
	Fri, 19 Jan 2024 22:46:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E4A1E48B
	for <netdev@vger.kernel.org>; Fri, 19 Jan 2024 22:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705704367; cv=none; b=Lyi5ft68/lkgX50Y9S5i2j4hsrjsJmWeM1AE31IwF2q0a1gRj4L3my+Ku0f8Nvxy8g/eeqHax3sFR5QBpq7rgo1f2Zevs0J2lq+G8kb/16/LpWTzHmTwvNsRTJdbotypezw1dYzt7LCCZd2U+bZxQp3djABKxiTqK8d70ALsWSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705704367; c=relaxed/simple;
	bh=8pbdxEKhTp0mZRIEkpmX/TlfVdWY2jPZJxZr7uElhK0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=l3w7ecu1GQCD8Bd5sIJe978R3QiUyiEqm5AP909NlJyhZkIbW0wN7g20q0z5p4zoktUkHCPL5z00G6zm4Xf74RksG798f7x+HsNOiVCKEj8OgXzae6IFOfMfnKkSto9L8r9LAHasHFrBNLFogPHPU4XxVeZZjzBfOK9bPQb7QGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-245-pv2jeQNpNzW1mFGdygC3BA-1; Fri, 19 Jan 2024 22:46:02 +0000
X-MC-Unique: pv2jeQNpNzW1mFGdygC3BA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 19 Jan
 2024 22:45:46 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 19 Jan 2024 22:45:46 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Eric Dumazet' <edumazet@google.com>, "David S . Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "eric.dumazet@gmail.com"
	<eric.dumazet@gmail.com>
Subject: RE: [PATCH v2 net] udp: fix busy polling
Thread-Topic: [PATCH v2 net] udp: fix busy polling
Thread-Index: AQHaSjwilaR6aNCc7U6mUxjZ35E7HrDhvNlw
Date: Fri, 19 Jan 2024 22:45:45 +0000
Message-ID: <f3404710d9ab4692aa33501514122604@AcuMS.aculab.com>
References: <20240118182835.4004788-1-edumazet@google.com>
In-Reply-To: <20240118182835.4004788-1-edumazet@google.com>
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

Li4uDQo+ICtzdGF0aWMgaW5saW5lIGJvb2wgc2tfaXNfaW5ldChjb25zdCBzdHJ1Y3Qgc29jayAq
c2spDQo+ICt7DQo+ICsJaW50IGZhbWlseSA9IFJFQURfT05DRShzay0+c2tfZmFtaWx5KTsNCj4g
Kw0KPiArCXJldHVybiBmYW1pbHkgPT0gQUZfSU5FVCB8fCBmYW1pbHkgPT0gQUZfSU5FVDY7DQo+
ICt9DQo+ICsNCj4gIHN0YXRpYyBpbmxpbmUgYm9vbCBza19pc190Y3AoY29uc3Qgc3RydWN0IHNv
Y2sgKnNrKQ0KPiAgew0KPiAtCXJldHVybiBzay0+c2tfdHlwZSA9PSBTT0NLX1NUUkVBTSAmJiBz
ay0+c2tfcHJvdG9jb2wgPT0gSVBQUk9UT19UQ1A7DQo+ICsJcmV0dXJuIHNrX2lzX2luZXQoc2sp
ICYmDQo+ICsJICAgICAgIHNrLT5za190eXBlID09IFNPQ0tfU1RSRUFNICYmDQo+ICsJICAgICAg
IHNrLT5za19wcm90b2NvbCA9PSBJUFBST1RPX1RDUDsNCj4gK30NCj4gKw0KPiArc3RhdGljIGlu
bGluZSBib29sIHNrX2lzX3VkcChjb25zdCBzdHJ1Y3Qgc29jayAqc2spDQo+ICt7DQo+ICsJcmV0
dXJuIHNrX2lzX2luZXQoc2spICYmDQo+ICsJICAgICAgIHNrLT5za190eXBlID09IFNPQ0tfREdS
QU0gJiYNCj4gKwkgICAgICAgc2stPnNrX3Byb3RvY29sID09IElQUFJPVE9fVURQOw0KPiAgfQ0K
DQpEbyB5b3UgbmVlZCB0byBjaGVjayBza190eXBlIGFzIHdlbGwgYXMgc2tfcHJvdG9jb2w/DQpJ
J2QgaGF2ZSB0aG91Z2h0IGl0IHdhcyBlbm91Z2ggdG8gY2hlY2sgc2tfcHJvdG9jb2wNCmFuZCB0
aGVuIHNrX2ZhbWlseSA/DQpDZXJ0YWlubHkgdGVzdGluZyBza19wcm90b2NvbCBmaXJzdCB3aWxs
IGdlbmVyYXRlICdmYWxzZScNCnF1aWNrZXN0Lg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBB
ZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMs
IE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K


