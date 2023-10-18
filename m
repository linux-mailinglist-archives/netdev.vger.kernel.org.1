Return-Path: <netdev+bounces-42221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9A57CDB2A
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 14:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74179B20E64
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 12:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F9C335B1;
	Wed, 18 Oct 2023 12:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F2C15AD7;
	Wed, 18 Oct 2023 12:01:44 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A0295;
	Wed, 18 Oct 2023 05:01:42 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39IC14goC1519562, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.93/5.92) with ESMTPS id 39IC14goC1519562
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Oct 2023 20:01:04 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 18 Oct 2023 20:01:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 18 Oct 2023 20:01:02 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Wed, 18 Oct 2023 20:01:02 +0800
From: Hayes Wang <hayeswang@realtek.com>
To: Grant Grundler <grundler@chromium.org>,
        Doug Anderson
	<dianders@chromium.org>
CC: Jakub Kicinski <kuba@kernel.org>,
        "David S . Miller"
	<davem@davemloft.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Simon Horman
	<horms@kernel.org>, Edward Hill <ecgh@chromium.org>,
        Laura Nao
	<laura.nao@collabora.com>,
        "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>,
        =?utf-8?B?QmrDuHJuIE1vcms=?= <bjorn@mork.no>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH v3 5/5] r8152: Block future register access if register access fails
Thread-Topic: [PATCH v3 5/5] r8152: Block future register access if register
 access fails
Thread-Index: AQHZ/UKPr2uppqw2y0WH24Vf4SC1orBMGX/AgAAGioCAAVSUAIAAE/SAgABIyACAAMBiAIAA3Ynw
Date: Wed, 18 Oct 2023 12:01:02 +0000
Message-ID: <a6f10400c04d48fbaa419310c0ae71de@realtek.com>
References: <20231012192552.3900360-1-dianders@chromium.org>
 <20231012122458.v3.5.Ib2affdbfdc2527aaeef9b46d4f23f7c04147faeb@changeid>
 <29f9a2ff1979406489213909b940184f@realtek.com>
 <CAD=FV=U4rGozXHoK8+ejPgRtyoACy1971ftoatQivqzk2tk5ng@mail.gmail.com>
 <052401da00fa$dacccd90$906668b0$@realtek.com>
 <CAD=FV=XQswgKZh-JQ6PuKGRmrDMfDmZwM+MUpAcOk1=7Ppjyiw@mail.gmail.com>
 <CAD=FV=Vp_KE_hjWy7bKJbvmqwCQ67jhzfFoV368vB5ZGge=Yzw@mail.gmail.com>
 <CANEJEGuEdGUAUufEHBfxbo_thXbgr8gMFVBaa+pCV_axWO=NGQ@mail.gmail.com>
In-Reply-To: <CANEJEGuEdGUAUufEHBfxbo_thXbgr8gMFVBaa+pCV_axWO=NGQ@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.22.228.6]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

R3JhbnQgR3J1bmRsZXIgPGdydW5kbGVyQGNocm9taXVtLm9yZz4NCj4gU2VudDogV2VkbmVzZGF5
LCBPY3RvYmVyIDE4LCAyMDIzIDI6MDYgUE0NClsuLi5dDQo+IEhheWVzLA0KPiBBcyBEb3VnIHBv
aW50cyBvdXQgdGhlIHByb2JhYmlsaXR5IGlzIHJlYWxseSBsb3cgb2YgdGhpcyBoYXBwZW5pbmcg
Zm9yDQo+IGFuIGV2ZW50IHRoYXQgaXMgYWxyZWFkeSByYXJlLiBEb3VnJ3MgcGF0Y2ggaXMgYSB2
ZXJ5IGdvb2Qgc3RlcCBpbiB0aGUNCj4gcmlnaHQgZGlyZWN0aW9uIChkcml2ZXIgcm9idXN0bmVz
cykgYW5kIEkgdGhpbmsgaGFzIGJlZW4gdGVzdGVkIGJ5DQo+IENocm9taXVtIE9TIHRlYW0gZW5v
dWdoIHRoYXQgaXQgaXMgc2FmZSB0byBhcHBseSB0byB0aGUgdXBzdHJlYW0gdHJlZS4NCj4gSSdt
IGEgYmlnIGZhbiBvZiB0YWtpbmcgc21hbGwgc3RlcHMgd2hlcmUgd2UgY2FuLiBXZSBjYW4gZnVy
dGhlcg0KPiBpbXByb3ZlIG9uIHRoaXMgaW4gdGhlIGZ1dHVyZSBhcyBuZWVkZWQuDQoNCkkgZG9u
J3QgcmVqZWN0IHRoZSBwYXRjaC4gQW5kLCBJIGRvbid0IGhhdmUgdGhlIHJpZ2h0IHRvIHJlamVj
dCBvciBhcHBseSB0aGUgcGF0Y2guDQpJIGp1c3QgZG9uJ3Qgd2lzaCB0aGUgcGF0Y2ggdG8gdHJv
dWJsZSB0aGUgb3RoZXJzLiBBbmQsIEkgbmVlZCB0aGUgcHJvZmVzc2lvbmFsDQpwZW9wbGUgdG8g
Y2hlY2sgbWUgdmlld3MsIHRvby4NCg0KSSB0aGluayBzb21lb25lIHdvdWxkIGRldGVybWluZSB3
aGV0aGVyIHRoZSBwYXRjaCBjb3VsZCBiZSBhcHBsaWVkLCBvciBub3QuDQoNCkJlc3QgUmVnYXJk
cywNCkhheWVzDQoNCj4gUGxlYXNlIGFkZDoNCj4gUmV2aWV3ZWQtYnk6IEdyYW50IEdydW5kbGVy
IDxncnVuZGxlckBjaHJvbWl1bS5vcmc+DQo+IA0KPiBjaGVlcnMsDQo+IGdyYW50DQo+IA0KPiA+
DQo+ID4gLURvdWcNCg==

