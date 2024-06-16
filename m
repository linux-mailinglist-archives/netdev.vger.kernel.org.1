Return-Path: <netdev+bounces-103892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A068990A008
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 23:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CF53281D09
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 21:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14842B2CF;
	Sun, 16 Jun 2024 21:51:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769E92BD18
	for <netdev@vger.kernel.org>; Sun, 16 Jun 2024 21:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718574718; cv=none; b=rHMqg+WV8INyCb4qdNxv6u0OtJAI3LgHmuuL36hzKp8OKLxYBhILq69avBJwj5Zt2VDEngcMgU5262yZuVds8STMacduYo++1rILGOipMYwhvsV1YyuLY82ncLZxceXw3QJ7qVq8F7LQKQs8PDo4MMtyr+g0V3cN99hm2SGvx2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718574718; c=relaxed/simple;
	bh=Jh38fFY1jsJz1TLAvGhQSBUq4K58MBDXKK8QwxU01kA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=Rf7W8rjRAdv7vFFzyv2VwDnjBibfc1q5Mcs/UfxgPLK4vIw8AXl7ofS0b45WbEkxnfarK/q+imNYi7QZCWL1GdqORy29oOWK1yZQK7Ay1IsNP+4UbiXWTRgJTm+eCAjK0i7pgeaMunnH1kMtcMrxX+EUAyrMSLnxmh4CZnqa8ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-116-n0_F1G1IMxuoN5XOZzHLJA-1; Sun, 16 Jun 2024 22:51:45 +0100
X-MC-Unique: n0_F1G1IMxuoN5XOZzHLJA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 16 Jun
 2024 22:51:05 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 16 Jun 2024 22:51:05 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Sagi Grimberg' <sagi@grimberg.me>, kernel test robot
	<oliver.sang@intel.com>, Matthew Wilcox <willy@infradead.org>
CC: "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>, "lkp@intel.com"
	<lkp@intel.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Subject: RE: [PATCH] net: micro-optimize skb_datagram_iter
Thread-Topic: [PATCH] net: micro-optimize skb_datagram_iter
Thread-Index: AQHav87vWshbN1FSGkaaeddPsMjEkbHK7lSQ
Date: Sun, 16 Jun 2024 21:51:05 +0000
Message-ID: <e2bce6704b20491e8eb2edd822ae6404@AcuMS.aculab.com>
References: <202406161539.b5ff7b20-oliver.sang@intel.com>
 <4937ffd4-f30a-4bdb-9166-6aebb19ca950@grimberg.me>
In-Reply-To: <4937ffd4-f30a-4bdb-9166-6aebb19ca950@grimberg.me>
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

RnJvbTogU2FnaSBHcmltYmVyZw0KPiBTZW50OiAxNiBKdW5lIDIwMjQgMTA6MjQNCi4uLg0KPiA+
IFsgMTMuNDk4NjYzXVsgVDE4OV0gRUlQOiB1c2VyY29weV9hYm9ydCAobW0vdXNlcmNvcHkuYzox
MDIgKGRpc2NyaW1pbmF0b3IgMTIpKQ0KPiA+IFsgICAxMy40OTk0MjRdWyAgVDE5NF0gdXNlcmNv
cHk6IEtlcm5lbCBtZW1vcnkgZXhwb3N1cmUgYXR0ZW1wdCBkZXRlY3RlZCBmcm9tIGttYXAgKG9m
ZnNldCAwLCBzaXplDQo+IDgxOTIpIQ0KPiANCj4gSG1tLCBub3Qgc3VyZSBJIHVuZGVyc3RhbmQg
ZXhhY3RseSB3aHkgY2hhbmdpbmcga21hcCgpIHRvDQo+IGttYXBfbG9jYWxfcGFnZSgpIGV4cG9z
ZSB0aGlzLA0KPiBidXQgaXQgbG9va3MgbGlrZSBtbS91c2VyY29weSBkb2VzIG5vdCBsaWtlIHNp
emU9ODE5MiB3aGVuIGNvcHlpbmcgZm9yDQo+IHRoZSBza2IgZnJhZy4NCg0KQ2FuJ3QgYSB1c2Vy
Y29weSBmYXVsdCBhbmQgaGF2ZSB0byByZWFkIHRoZSBwYWdlIGZyb20gc3dhcD8NClNvIHRoZSBw
cm9jZXNzIGNhbiBzbGVlcCBhbmQgdGhlbiBiZSByZXNjaGVkdWxlZCBvbiBhIGRpZmZlcmVudCBj
cHU/DQpTbyB5b3UgY2FuJ3QgdXNlIGttYXBfbG9jYWxfcGFnZSgpIGhlcmUgYXQgYWxsLg0KDQoJ
RGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1v
dW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEz
OTczODYgKFdhbGVzKQ0K


