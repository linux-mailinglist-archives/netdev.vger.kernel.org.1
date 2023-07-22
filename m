Return-Path: <netdev+bounces-20094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FE575D964
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 05:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2242E2824EF
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 03:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089BD8835;
	Sat, 22 Jul 2023 03:17:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1DB27F3B
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 03:17:57 +0000 (UTC)
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831763AA7
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 20:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1689995876; x=1721531876;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=u4ZNEaUJjCKQkVcdpe+ZxHGgCUztLMC3wCxpWoZ6JAQ=;
  b=eMlHprFxkRQ4HENUNOkLOB1mMmrUJX84j9AFJjAAGiv81DnxCdlZ44TI
   dfwpzhN+2zfxYH7mYTRZ+KrOcZjzp4pTvLKZD24rT6/IdHDg8C0hssbhF
   391FpjlyItVF82W5oZoQUfksLPfTlnNWuQU15IiA6NTSeVzk9A3YRfq9j
   I=;
X-IronPort-AV: E=Sophos;i="6.01,223,1684800000"; 
   d="scan'208";a="17962930"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-1box-2bm6-32cf6363.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2023 03:17:56 +0000
Received: from EX19MTAUWA002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
	by email-inbound-relay-pdx-1box-2bm6-32cf6363.us-west-2.amazon.com (Postfix) with ESMTPS id B124580F19;
	Sat, 22 Jul 2023 03:17:55 +0000 (UTC)
Received: from EX19D001UWB003.ant.amazon.com (10.13.138.112) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sat, 22 Jul 2023 03:17:54 +0000
Received: from EX19D035UWB002.ant.amazon.com (10.13.138.97) by
 EX19D001UWB003.ant.amazon.com (10.13.138.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.30;
 Sat, 22 Jul 2023 03:17:54 +0000
Received: from EX19D035UWB002.ant.amazon.com ([fe80::90db:7d3a:2c4f:9bb4]) by
 EX19D035UWB002.ant.amazon.com ([fe80::90db:7d3a:2c4f:9bb4%6]) with mapi id
 15.02.1118.030; Sat, 22 Jul 2023 03:17:53 +0000
From: "Smith, Stewart" <trawets@amazon.com>
To: "Iwashima, Kuniyuki" <kuniyu@amazon.co.jp>
CC: "aksecurity@gmail.com" <aksecurity@gmail.com>, "Herrenschmidt, Benjamin"
	<benh@amazon.com>, "David S . Miller" <davem@davemloft.net>, David Ahern
	<dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, "kuni1840@gmail.com" <kuni1840@gmail.com>, "Iwashima,
 Kuniyuki" <kuniyu@amazon.co.jp>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Mendoza-Jonas,
 Samuel" <samjonas@amazon.com>
Subject: Re: [PATCH v2 net] tcp: Reduce chance of collisions in
 inet6_hashfn().
Thread-Topic: [PATCH v2 net] tcp: Reduce chance of collisions in
 inet6_hashfn().
Thread-Index: AQHZvD1t9mP8IjMqg0SYUlQZmnkkQ6/FHa2A
Date: Sat, 22 Jul 2023 03:17:53 +0000
Message-ID: <9A3D7F61-23CC-4A2F-9022-EAA17ECFA690@amazon.com>
References: <CANEQ_+KSPSy3cQmVf_WdkdHMaNdCh-Qyo_7M8p+qFXXqbeZWgw@mail.gmail.com>
 <20230722013948.42820-1-kuniyu@amazon.com>
In-Reply-To: <20230722013948.42820-1-kuniyu@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3731.600.7)
x-originating-ip: [10.187.171.26]
Content-Type: text/plain; charset="utf-8"
Content-ID: <63CDD7DB545AAC4B9C29AE1BE88AC172@amazon.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Precedence: Bulk
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

T24gSnVsIDIxLCAyMDIzLCBhdCA2OjM5IFBNLCBJd2FzaGltYSwgS3VuaXl1a2kgPGt1bml5dUBh
bWF6b24uY28uanA+IHdyb3RlOg0KPiANCj4gRnJvbTogQW1pdCBLbGVpbiA8YWtzZWN1cml0eUBn
bWFpbC5jb20+DQo+IERhdGU6IFNhdCwgMjIgSnVsIDIwMjMgMDM6MDc6NDkgKzAzMDANCj4+IFJl
c2VuZGluZyBiZWNhdXNlIHNvbWUgcmVjaXBpZW50cyByZXF1aXJlIHBsYWludGV4dCBlbWFpbC4g
U29ycnkuDQo+PiBPcmlnaW5hbCBtZXNzYWdlOg0KPj4gDQo+PiBUaGlzIGlzIGNlcnRhaW5seSBi
ZXR0ZXIgdGhhbiB0aGUgb3JpZ2luYWwgY29kZS4NCj4gDQo+IFRoYW5rcyBmb3IgcmV2aWV3aW5n
IQ0KPiANCj4gDQo+PiANCj4+IFR3byByZW1hcmtzOg0KPj4gDQo+PiAxLiBJbiBnZW5lcmFsLCB1
c2luZyBTaXBIYXNoIGlzIG1vcmUgc2VjdXJlLCBldmVuIGlmIG9ubHkgZm9yIGl0cw0KPj4gbG9u
Z2VyIGtleSAoMTI4IGJpdHMsIGNmLiBqaGFzaCdzIDMyIGJpdHMpLCB3aGljaCByZW5kZXJzIHNp
bXBsZQ0KPj4gZW51bWVyYXRpb24gYXR0YWNrcyBpbmZlYXNpYmxlLiBJIHVuZGVyc3RhbmQgdGhh
dCBpbiBhIGRpZmZlcmVudA0KPj4gY29udGV4dCwgc3dpdGNoaW5nIGZyb20gamhhc2ggdG8gc2lw
aGFzaCBpbmN1cnJlZCBzb21lIG92ZXJoZWFkLCBidXQNCj4+IG1heWJlIGhlcmUgaXQgd29uJ3Qu
DQo+IA0KPiBJIHNlZS4gIFN0ZXdhcnQgdGVzdGVkIGhzaXBoYXNoIGFuZCBvYnNlcnZlZCBtb3Jl
IG92ZXJoZWFkIGFzDQo+IG5vdGVkIGluIHRoZSBjaGFuZ2Vsb2csIGJ1dCBsZXQgbWUgZ2l2ZSBh
bm90aGVyIHNob3QgdG8gU2lwSGFzaA0KPiBhbmQgSFNpcGhhc2guDQoNCldoZW4gb3JpZ2luYWxs
eSBsb29raW5nIGF0IHdoYXQgdG8gZG8gZm9yIHRoZSBjb2xsaXNpb25zLCBpdCBkaWQgc2VlbSBs
aWtlIHNpcGhhc2ggd291bGQgYmUgdGhlIGJldHRlciBoYXNoLCBidXQgSSBkaWQgaGF2ZSBzb21l
IGNvbmNlcm4gYXJvdW5kIHdoYXQgdGhlIHJlYWwtd29ybGQgcGVyZm9ybWFuY2UgaW1wYWN0IGNv
dWxkIGJlLCBhbmQgd2FudGVkIHRvIGhhdmUgc29tZXRoaW5nIHRoYXQgd291bGQgYWxsZXZpYXRl
IHRoZSBpc3N1ZSBhdCBoYW5kIHRoYXQgbm9ib2R5IGNvdWxkIGV2ZW4gKnBvc3NpYmx5KiByZW1v
dGVseSBjb250ZW1wbGF0ZSBjb21wbGFpbmluZyB3YXMgYSBwcm9ibGVtIHRvIGFwcGx5IHRoZSBw
YXRjaCB0byB0aGVpciBzeXN0ZW1zIGJlY2F1c2Ugb2Yg4oCccGVyZm9ybWFuY2XigJ0uLiB3aGlj
aCB3YXMgd2h5IGtlZXBpbmcgamhhc2ggYnV0IHdpdGggbW9kaWZpY2F0aW9ucyB3YXMgd2hlcmUg
d2Ugc3RhcnRlZC4NCg0KVHdvIHRoaW5ncyBhYm91dCBzaXBoYXNoL2hzaXBoYXNoIHRoYXQgSSBo
YWQgb3BlbiBxdWVzdGlvbnMgYWJvdXQ6DQotIGlzIHRoZSBleHRyYSBvdmVyaGVhZCBvZiB0aGUg
aGFzaCBjYWxjdWxhdGlvbiBnb2luZyB0byBiZSBub3RpY2VhYmxlIGF0IGFsbCBpbiBhbnkgcmVn
dWxhciB3b3JrbG9hZA0KLSBhbGwgdGhlIGpoYXNoIHN0dWZmIGdldHMgaW5saW5lZCBuaWNlbHkg
YW5kIHRoZSBjb21waWxlciBkb2VzIHdvbmRlcmZ1bCB0aGluZ3MsIGJ1dCBpdOKAmXMgcG9zc2li
bGUgdGhhdCBzaXBoYXNoIHdpbGwgZW5kIHVwIGFsd2F5cyB3aXRoIGEganVtcCwgd2hpY2ggd291
bGQgYWRkIG1vcmUgdG8gdGhlIGV4dHJhIG92ZXJoZWFkIChhbmQgdGhhdCBsbHZtLW1jYSBkb2Vz
buKAmXQgcmVhbGx5IG1vZGVsIHdlbGwsIHNvIGl0IHdhcyBoYXJkZXIgdG8gcHJvdmUgaW4gc2lt
KS4gQWdhaW4sIG5vdCBxdWl0ZSBzdXJlIHRoZSByZWFsIHdvcmxkIGltcGFjdCB0byByZWFsIHdv
cmxkIHdvcmtsb2Fkcy4NCg0KPiANCj4gSSdsbCByZXBvcnQgYmFjayBoZXJlIG5leHQgd2Vlay4N
Cj4gDQo+IA0KPj4gDQo+PiAyLiBUYWtpbmcgYSBtb3JlIGhvbGlzdGljIGFwcHJvYWNoIHRvIF9f
aXB2Nl9hZGRyX2poYXNoKCksIEkgc3VydmV5ZWQNCj4+IHdoZXJlIGFuZCBob3cgaXQncyB1c2Vk
LiBJbiBtb3N0IGNhc2VzLCBpdCBpcyB1c2VkIGZvciBoYXNoaW5nDQo+PiB0b2dldGhlciB0aGUg
SVB2NiBsb2NhbCBhZGRyZXNzLCBmb3JlaWduIGFkZHJlc3MgYW5kIG9wdGlvbmFsbHkgc29tZQ0K
Pj4gbW9yZSBkYXRhIChlLmcuIGxheWVyIDQgcHJvdG9jb2wgbnVtYmVyLCBsYXllciA0IHBvcnRz
KS4NCj4+IFNlY3VyaXR5LXdpc2UsIGl0IG1ha2VzIG1vcmUgc2Vuc2UgdG8gaGFzaCBhbGwgZGF0
YSB0b2dldGhlciBvbmNlLCBhbmQNCj4+IG5vdCBwaWVjZXdpc2UgYXMgaXQncyBkb25lIHRvZGF5
IChpLmUuIHRvZGF5IGl0J3MNCj4+IGpoYXNoKC4uLi4samhhc2goZmFkZHIpLC4uLiksIHdoaWNo
IGNhc2VzIHRoZSBmYWRkciBpbnRvIDMyIGJpdHMsDQo+PiB3aGVyZWFzIHRoZSByZWNvbW1lbmRl
ZCB3YXkgaXMgdG8gaGFzaCBhbGwgaXRlbXMgaW4gdGhlaXIgZW50aXJldHksDQo+PiBpLmUuIGpo
YXNoKC4uLixmYWRkciwuLi4pKS4NCj4gDQo+IEFncmVlLg0KDQpXaGVuIGxvb2tpbmcgYXQgdGhp
cyBvcmlnaW5hbGx5LCBJIHdhcyB0cnlpbmcgdG8gd29yayBvdXQgd2hhdCB3YXMgaW50ZW50aW9u
YWwgZm9yIHNvbWUgcmVhc29uIEkgd2FzbuKAmXQgc21hcnQgZW5vdWdoIHRvIHVuZGVyc3RhbmQg
YW5kIHdoYXQgaGFkIGp1c3QgZ3Jvd24gb3ZlciB0aGUgcGFzdCAoZWVwLi4gbmVhcmx5IDMgZGVj
YWRlcyBJIHRoaW5rKSBhbmQgY291bGQgZG8gd2l0aCBhIGJpdCBvZiBhIHJldGhpbmsuDQoNCj4+
IFRoaXMgcmVxdWlyZXMgc2NydXRpbml6aW5nIGFsbCA2DQo+PiBpbnZvY2F0aW9ucyBvZiBfX2lw
djZfYWRkcl9qaGFzaCgpIG9uZSBieSBvbmUgYW5kIG1vZGlmeWluZyB0aGUNCj4+IGNhbGxpbmcg
Y29kZSBhY2NvcmRpbmdseS4NCj4gDQo+IEF0IGEgZ2xhbmNlLCBvbmx5IHJkc19jb25uX2J1Y2tl
dCgpIHNlZW1zIGEgbGl0dGxlIGJpdCB0cmlja3kNCj4gYXMgaXQgdXNlcyB2NCBoYXNoIGZ1bmN0
aW9uIGxhdGVyLg0KPiANCj4gQnV0IEknbGwgdGFrZSBhIGRlZXBlciBsb29rLg0KDQo=

