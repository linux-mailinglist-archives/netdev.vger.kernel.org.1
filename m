Return-Path: <netdev+bounces-32971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D532079C132
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 02:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A9841C20A90
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 00:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4680623;
	Tue, 12 Sep 2023 00:43:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8848816
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 00:43:16 +0000 (UTC)
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9494415DEC6;
	Mon, 11 Sep 2023 17:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.jp; i=@amazon.co.jp; q=dns/txt;
  s=amazon201209; t=1694477426; x=1726013426;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=jCT7kEJb6bgjL9N2bbFsx73JfCVEKR+M/+x/SSKNcc0=;
  b=eZoRzifmGQ9cWm0CrX5NyLIqSr9TzlD5CS0U77HFNFis8n49ihIoD3td
   uv+rjsQSTXb7LJItxyI4qNJIplVchcStlX0lydKTEkvoRHR2fr9BGqE1K
   APfOat+3UgkfNvbIeywO0jFO3oNeQbPtEBo0FQDmnPeq6xcMUgiNXu2cV
   o=;
X-IronPort-AV: E=Sophos;i="6.02,244,1688428800"; 
   d="scan'208";a="153825934"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-bbc6e425.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 00:07:30 +0000
Received: from EX19MTAUWB002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
	by email-inbound-relay-iad-1a-m6i4x-bbc6e425.us-east-1.amazon.com (Postfix) with ESMTPS id F325081251;
	Tue, 12 Sep 2023 00:07:26 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 12 Sep 2023 00:06:55 +0000
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.37;
 Tue, 12 Sep 2023 00:06:32 +0000
Received: from EX19D004ANA001.ant.amazon.com ([fe80::f099:cbca:cc6b:91ec]) by
 EX19D004ANA001.ant.amazon.com ([fe80::f099:cbca:cc6b:91ec%5]) with mapi id
 15.02.1118.037; Tue, 12 Sep 2023 00:06:32 +0000
From: "Iwashima, Kuniyuki" <kuniyu@amazon.co.jp>
To: Andrei Vagin <avagin@gmail.com>, Joanne Koong <joannelkoong@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "kafai@fb.com" <kafai@fb.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "dccp@vger.kernel.org"
	<dccp@vger.kernel.org>, "Iwashima, Kuniyuki" <kuniyu@amazon.co.jp>
Subject: Re: [PATCH RESEND net-next v4 1/3] net: Add a bhash2 table hashed by
 port and address
Thread-Topic: [PATCH RESEND net-next v4 1/3] net: Add a bhash2 table hashed by
 port and address
Thread-Index: AQHZ5Qz8Gvyg13tCu0yF6Oy/qEthtw==
Date: Tue, 12 Sep 2023 00:06:32 +0000
Message-ID: <F4C44A92-4802-4165-97E9-C89E2E7BBFC9@amazon.co.jp>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [10.187.171.14]
Content-Type: text/plain; charset="utf-8"
Content-ID: <BACD76944850C54EA1A1E7B2C74B5389@amazon.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Precedence: Bulk
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,T_SPF_PERMERROR
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

RnJvbTogQW5kcmVpIFZhZ2luIDxhdmFnaW5AZ21haWwuY29tPg0KRGF0ZTogTW9uLCAxMSBTZXAg
MjAyMyAxNjozNjo1NSAtMDcwMA0KPiBPbiBNb24sIEF1ZyAyMiwgMjAyMiBhdCAxMToxMDoyMUFN
IC0wNzAwLCBKb2FubmUgS29vbmcgd3JvdGU6DQo+ID4NCj4gPiArc3RhdGljIGJvb2wgaW5ldF91
c2VfYmhhc2gyX29uX2JpbmQoY29uc3Qgc3RydWN0IHNvY2sgKnNrKQ0KPiA+ICt7DQo+ID4gKyNp
ZiBJU19FTkFCTEVEKENPTkZJR19JUFY2KQ0KPiA+ICsgICAgIGlmIChzay0+c2tfZmFtaWx5ID09
IEFGX0lORVQ2KSB7DQo+ID4gKyAgICAgICAgICAgICBpbnQgYWRkcl90eXBlID0gaXB2Nl9hZGRy
X3R5cGUoJnNrLT5za192Nl9yY3Zfc2FkZHIpOw0KPiA+ICsNCj4gPiArICAgICAgICAgICAgIHJl
dHVybiBhZGRyX3R5cGUgIT0gSVBWNl9BRERSX0FOWSAmJg0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICBhZGRyX3R5cGUgIT0gSVBWNl9BRERSX01BUFBFRDsNCj4gPg0KPiANCj4gV2h5IGRvIHdl
IHJldHVybiBmYWxzZSB0byBhbGwgbWFwcGVkIGFkZHJlc3Nlcz8gU2hvdWxkIGl0IGJlDQo+IA0K
PiAoYWRkcl90eXBlICE9IElQVjZfQUREUl9NQVBQRUQgfHwgc2stPnNrX3Jjdl9zYWRkciAhPSBo
dG9ubChJTkFERFJfQU5ZKSkNCj4gDQoNClllcywgdGhhdCBjb3VsZCBiZSBkb25lIGFzIG9wdGlt
aXNhdGlvbi4NCg0KDQo=

