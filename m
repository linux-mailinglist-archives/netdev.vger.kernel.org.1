Return-Path: <netdev+bounces-19805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C40475C615
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 13:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D12D1C21666
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 11:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462C51DDCE;
	Fri, 21 Jul 2023 11:51:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C7C14F68
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 11:51:46 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AB930C1
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 04:51:43 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-148-z_DqXMMUPVCfSx5Bf5_Iew-1; Fri, 21 Jul 2023 12:51:40 +0100
X-MC-Unique: z_DqXMMUPVCfSx5Bf5_Iew-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 21 Jul
 2023 12:51:39 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 21 Jul 2023 12:51:39 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Alan Huang' <mmpgouride@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "rcu@vger.kernel.org" <rcu@vger.kernel.org>
CC: "Paul E. McKenney" <paulmck@kernel.org>, Eric Dumazet
	<edumazet@google.com>, "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>
Subject: RE: Question about the barrier() in hlist_nulls_for_each_entry_rcu()
Thread-Topic: Question about the barrier() in hlist_nulls_for_each_entry_rcu()
Thread-Index: AQHZuzuWW9UBwZmf30GL9p6MGC4yBq/EGshg
Date: Fri, 21 Jul 2023 11:51:39 +0000
Message-ID: <fedf0448966b44d5b9146508265874fd@AcuMS.aculab.com>
References: <04C1E631-725C-47AD-9914-25D5CE04DFF4@gmail.com>
In-Reply-To: <04C1E631-725C-47AD-9914-25D5CE04DFF4@gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

RnJvbTogQWxhbiBIdWFuZw0KPiBTZW50OiAyMCBKdWx5IDIwMjMgMTk6NTQNCj4gDQo+IEkgbm90
aWNlZCBhIGNvbW1pdCBjODdhMTI0YTVkNWUo4oCcbmV0OiBmb3JjZSBhIHJlbG9hZCBvZiBmaXJz
dCBpdGVtIGluIGhsaXN0X251bGxzX2Zvcl9lYWNoX2VudHJ5X3JjdeKAnSkNCj4gYW5kIGEgcmVs
YXRlZCBkaXNjdXNzaW9uIFsxXS4NCg0KSG1tbS4uLiB0aGF0IHdhcyBhbGwgYWJvdXQgdGhlIHJl
dHJ5IGxvb3AgaW4gaXB2NC91ZHAuYw0KDQpBRkFJQ1QgdGhhdCByZXRyeSBnb3QgZGVsZXRlZCBi
eSBjYTA2NWQwYy4NCg0KVGhhdCBhbHNvIGNoYW5nZXMgdGhlIGxpc3QgZnJvbSBobGlzdF9udWxs
c194eHggdG8gaGxpc3RfeHh4Lg0KKEknbSBub3Qgc3VyZSBvZiB0aGUgZGlmZmVyZW5jZSkNCg0K
VGhpcyBtaWdodCBiZSB3aHkgd2UncmUgc2VlaW5nIHVuZXhwZWN0ZWQgJ3BvcnQgdW5yZWFjaGFi
bGUnIG1lc3NhZ2VzPw0KDQpRdWl0ZSB3aHkgdGhhdCBoYXMganVzdCBzdGFydGVkIGhhcHBlbmlu
ZyBpcyBhbm90aGVyIGlzc3VlLg0KTW9zdCBvZiB0aGUgVURQIHNvY2tldHMgd2UgY3JlYXRlIGFy
ZW4ndCAnY29ubmVjdGVkJyBzbyBJIGRvbid0DQpiZWxpZXZlIHRoZXkgZ2V0IG1vdmVkIGJldHdl
ZW4gaGFzaCBjaGFpbnMgLSBqdXN0IGRlbGV0ZWQuDQpUaGUgZGVsZXRpb24gc2hvdWxkIGxlYXZl
IHRoZSBoYXNoIGNoYWluIGludGFjdC4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVz
cyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEg
MVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==


