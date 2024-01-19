Return-Path: <netdev+bounces-64420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2FE8330C2
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 23:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09A9F1C20EA5
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 22:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7F41E519;
	Fri, 19 Jan 2024 22:32:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F298E1DA46
	for <netdev@vger.kernel.org>; Fri, 19 Jan 2024 22:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705703559; cv=none; b=ulJDBNv8tJMbiu/ni7QVCO1+i7HJ269sN+WttLmiZHg819MMrN1MMJemBdH5KGhdHAGMeGg1fQc9omtBy37g2QRUXj4/YMLH0Fkt0wmRyoWxZJLO6viY3OiMt2UOZN6CMrFRsOAHEixpcza6f03KH1omT9oCzJhvhRZKPM4tT0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705703559; c=relaxed/simple;
	bh=MbW6HYUwrtZQllKOcUvm3R7LIQernrIPnyN1D4Iv5qE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=CVj4Iu5Wv4lA8oL5UEtAW9ijYbmwZN5yQCgDaqt3kdP4Gk1xDmPkDmGSBulpdBIZKWNrN7vvinjTxaHz3AUxpXfrtQaasyzEgAz53AWJ6LE2xUEd4P++eOhCrUlOoxav6b7KsCAeQg1lh1JfiK6Ce11KX3QqE3muvxBuBgsK8MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-311-rKtD4i7OMLafBvo47lSNfw-1; Fri, 19 Jan 2024 22:32:34 +0000
X-MC-Unique: rKtD4i7OMLafBvo47lSNfw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 19 Jan
 2024 22:32:18 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 19 Jan 2024 22:32:18 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Eric Dumazet' <edumazet@google.com>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>
CC: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn
	<willemb@google.com>, David Ahern <dsahern@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "eric.dumazet@gmail.com"
	<eric.dumazet@gmail.com>
Subject: RE: [PATCH net] udp: fix busy polling
Thread-Topic: [PATCH net] udp: fix busy polling
Thread-Index: AQHaSiZXbeFp191/2EKhYpcmQaFF4rDhtzzA
Date: Fri, 19 Jan 2024 22:32:18 +0000
Message-ID: <e1bc19b4b246478ea32cb2631cb514e8@AcuMS.aculab.com>
References: <20240118143504.3466830-1-edumazet@google.com>
 <65a9407bd77fc_1caa3f29452@willemb.c.googlers.com.notmuch>
 <CANn89i+x9qKCaQVbaf+TO8TJWMaLcW-efhAuNtatFuyrza-UaQ@mail.gmail.com>
In-Reply-To: <CANn89i+x9qKCaQVbaf+TO8TJWMaLcW-efhAuNtatFuyrza-UaQ@mail.gmail.com>
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

Li4uDQo+ID4gPiArc3RhdGljIGlubGluZSBib29sIHNrX2lzX3VkcChjb25zdCBzdHJ1Y3Qgc29j
ayAqc2spDQo+ID4gPiArew0KPiA+ID4gKyAgICAgcmV0dXJuIHNrLT5za190eXBlID09IFNPQ0tf
REdSQU0gJiYgc2stPnNrX3Byb3RvY29sID09IElQUFJPVE9fVURQOw0KPiA+ID4gK30NCj4gPiA+
ICsNCj4gPg0KPiA+IFNpbmNlIGJ1c3kgcG9sbGluZyBjb2RlIGlzIHByb3RvY29sIChmYW1pbHkp
IGluZGVwZW5kZW50LCBpcyBpdCBzYWZlDQo+ID4gdG8gYXNzdW1lIHNrLT5za19mYW1pbHkgPT0g
UEZfSU5FVCBvciBQRl9JTkVUNiBoZXJlPw0KPiANCj4gSG1tLiBUaGlzIGlzIGEgdmFsaWQgcG9p
bnQuDQoNCkRvICd3ZScgbmVlZCBzZXBhcmF0ZSAxNmJpdCBza19mYW1pbHksIHNrX3R5cGUgYW5k
IHNrX3Byb3RvY29sPw0KDQpTZWVtcyBhIGxvdCBvZiBiaXRzLg0KDQpJIHdhcyBzb3J0IG9mIHRo
aW5raW5nIHRoYXQgdGhlIGFib3ZlIHRlc3QgY291bGQgYmUgYSBzaW5nbGUgY29tcGFyZQ0KKG9m
IGEgY29tcG91bmQgdmFsdWUpLg0KQnV0IHNpbmNlIElQUFJPVE9fVURQID0+IFNPQ0tfREdSQU0g
YW5kIEkgZG9uJ3QgdGhpbmsgeW91IGNhbg0KcG9zc2libHkgcnVuIFVEUCBvdmVyIGFueXRoaW5n
IGVsc2UsIGdldHRpbmcgdGhlIHNrX3Byb3RvY29sIHZhbHVlcw0KdW5pcXVlIGFjcm9zcyBmYW1p
bGllcyAoaG93IG11Y2ggbm9uLUlQIHN0dWZmIGlzIHRoZXJlIGFueXdheSkNCndvdWxkIHNpbXBs
aWZ5IGFsbCBzaW1pbGFyIHRlc3RzLg0KTWlnaHQgaW1wYWN0IHRoZSBzb2NrZXQoKSBzeXN0ZW0g
Y2FsbCBhIGJpdCAtIGJ1dCBub3QgbXVjaC4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRk
cmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBN
SzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==


