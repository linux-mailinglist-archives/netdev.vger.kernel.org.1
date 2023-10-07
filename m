Return-Path: <netdev+bounces-38786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0317BC768
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 14:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 651661C208D6
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 12:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8117F1B267;
	Sat,  7 Oct 2023 12:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HL3MbAaB"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565A48473;
	Sat,  7 Oct 2023 12:07:38 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0057B6;
	Sat,  7 Oct 2023 05:07:36 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c72e235debso5796345ad.0;
        Sat, 07 Oct 2023 05:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696680456; x=1697285256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l1HZFwvxnZDs8waboyFuYasss13kV1adzgBJ83FKJyY=;
        b=HL3MbAaB4fhy0mXlNs4VhwrwsfwCUlsx4P7/IWT2wUgiLKd1/6mx2UKmf5Wv6NkTUM
         QtsEyNtWM785vq6UxdJHSTZ8EESAx0AdFLFReXGWl5V89CPmeFUVJMgtDys8KCqGMpqF
         5FY0Zq56UIFWJ/n21UfEnCVNI6DcaeoFtiFps2KWEViawzv6gjSZnmitEVDfTlWosJth
         rHXlXFGst3BSL112171CSB7z2fTi7OukNeRgZ3xfsp+elRbhNwHUjB/HjP0FkF3WJ1aU
         fU+adgK7Z9aoq0Kysm7sUNoKxsIjJiCnYWXWglr9x84pCo6cVQk4ARV9yGHxKi1j+3ze
         AUew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696680456; x=1697285256;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l1HZFwvxnZDs8waboyFuYasss13kV1adzgBJ83FKJyY=;
        b=Yjv0ZIzwDZcFuEscm4yhVa8/yQ0WU8mZYw7F1EA7vKmmZCWexqqQYOmudfDSjA4WkC
         5ZY2D9dFqIZ0L/vvffyiopeVzQMibjzDX7NvtQrq1FHmNbVcdtoCV02Dr6fcM6Zmpfcs
         nH4YzNmrWcnznPUlP0U5raZAb8pOtlQmkxOwu/NEGXXL5toVwZxr33ylf+IhVHGitI+w
         PQfAnmg4lCPbol/MmYlSb+Wk3GQcHYVPN22YbJALhpcDJtoN2z9curJTZQGfR8BJ0+RZ
         /SMnwXkOS8PxodoG4SvNBouQPK2iquM2tjMzRNwPo24JYmHLbiX/6ILQox2YhMLC3RSg
         uSmw==
X-Gm-Message-State: AOJu0Yzz/sT1ehcL6tKIKQMseIjEhVerfbxhnpCcwvhtZ0oggeiH2xdO
	1kqcTMBqLaViP95B57zAHchIduVJU9lxHagD
X-Google-Smtp-Source: AGHT+IE7l5mkR9Hvgjmq1WK97lvXfDQVoc3LcpisAnQqZCaqshnDPxOEbKmCh+dPTAm2k4LMYA3T9w==
X-Received: by 2002:a17:902:da8d:b0:1c1:fbec:bc3f with SMTP id j13-20020a170902da8d00b001c1fbecbc3fmr11741622plx.5.1696680456162;
        Sat, 07 Oct 2023 05:07:36 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id ja10-20020a170902efca00b001c731b62403sm5711919plb.218.2023.10.07.05.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 05:07:35 -0700 (PDT)
Date: Sat, 07 Oct 2023 21:07:34 +0900 (JST)
Message-Id: <20231007.210734.448113675800173824.fujita.tomonori@gmail.com>
To: tmgross@umich.edu
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 miguel.ojeda.sandonis@gmail.com, greg@kroah.com
Subject: Re: [PATCH v2 3/3] net: phy: add Rust Asix PHY driver
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CALNs47syMxiZBUwKLk3vKxzmCbX0FS5A37FjwUzZO9Fn-iPaoA@mail.gmail.com>
References: <20231006094911.3305152-1-fujita.tomonori@gmail.com>
	<20231006094911.3305152-4-fujita.tomonori@gmail.com>
	<CALNs47syMxiZBUwKLk3vKxzmCbX0FS5A37FjwUzZO9Fn-iPaoA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

T24gU2F0LCA3IE9jdCAyMDIzIDAzOjE5OjIwIC0wNDAwDQpUcmV2b3IgR3Jvc3MgPHRtZ3Jvc3NA
dW1pY2guZWR1PiB3cm90ZToNCg0KPiBPbiBGcmksIE9jdCA2LCAyMDIzIGF0IDU6NDnigK9BTSBG
VUpJVEEgVG9tb25vcmkNCj4gPGZ1aml0YS50b21vbm9yaUBnbWFpbC5jb20+IHdyb3RlOg0KPiAN
Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9waHkvYXg4ODc5NmJfcnVzdC5ycyBiL2RyaXZl
cnMvbmV0L3BoeS9heDg4Nzk2Yl9ydXN0LnJzDQo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4g
aW5kZXggMDAwMDAwMDAwMDAwLi5kMTFjODJhOWU4NDcNCj4+IC0tLSAvZGV2L251bGwNCj4+ICsr
KyBiL2RyaXZlcnMvbmV0L3BoeS9heDg4Nzk2Yl9ydXN0LnJzDQo+IA0KPiBNYXliZSB3YW50IHRv
IGxpbmsgdG8gdGhlIEMgdmVyc2lvbiwganVzdCBmb3IgdGhlIGNyb3NzcmVmPw0KDQpTdXJlLg0K
DQo+PiArICAgIGZuIHJlYWRfc3RhdHVzKGRldjogJm11dCBwaHk6OkRldmljZSkgLT4gUmVzdWx0
PHUxNj4gew0KPj4gKyAgICAgICAgZGV2LmdlbnBoeV91cGRhdGVfbGluaygpPzsNCj4+ICsgICAg
ICAgIGlmICFkZXYuZ2V0X2xpbmsoKSB7DQo+PiArICAgICAgICAgICAgcmV0dXJuIE9rKDApOw0K
Pj4gKyAgICAgICAgfQ0KPiANCj4gTG9va2luZyBhdCB0aGlzIHVzYWdlLCBJIHRoaW5rIGBnZXRf
bGluaygpYCBzaG91bGQgYmUgcmVuYW1lZCB0byBqdXN0DQo+IGBsaW5rKClgLiBgZ2V0X2xpbmtg
IG1ha2VzIG1lIHRoaW5rIHRoYXQgaXQgaXMgcGVyZm9ybWluZyBhbiBhY3Rpb24NCj4gbGlrZSBj
YWxsaW5nIGBnZW5waHlfdXBkYXRlX2xpbmtgLCBqdXN0IGBsaW5rKClgIHNvdW5kcyBtb3JlIGxp
a2UgYQ0KPiBzdGF0aWMgYWNjZXNzb3IuDQoNCkFuZHJldyBzdWdnZXN0ZWQgdG8gcmVuYW1lIGxp
bmsoKSB0byBnZXRfbGluaygpLCBJIHRoaW5rLg0KDQpUaGVuIHdlIGRpc2N1c3NlZCBhZ2FpbiBs
YXN0IHdlZWs6DQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3J1c3QtZm9yLWxpbnV4LzIwMjMx
MDA0LjA4NDY0NC41MDc4NDUzMzk1OTM5ODc1NS5mdWppdGEudG9tb25vcmlAZ21haWwuY29tLw0K
DQo+IE9yIG1heWJlIGl0J3Mgd29ydGggcmVwbGFjaW5nIGBnZXRfbGlua2Agd2l0aCBhIGBnZXRf
dXBkYXRlZF9saW5rYA0KPiB0aGF0IGNhbGxzIGBnZW5waHlfdXBkYXRlX2xpbmtgIGFuZCB0aGVu
IHJldHVybnMgYGxpbmtgLCB0aGUgdXNlciBjYW4NCj4gc3RvcmUgaXQgaWYgdGhleSBuZWVkIHRv
IHJldXNlIGl0LiBUaGlzIHNlZW1zIHNvbWV3aGF0IGxlc3MgYWNjaWRlbnQNCj4gcHJvbmUgdGhh
biBzb21lb25lIGNhbGxpbmcgYC5saW5rKClgL2AuZ2V0X2xpbmsoKWAgcmVwZWF0ZWRseSBhbmQN
Cj4gd29uZGVyaW5nIHdoeSB0aGVpciBwaHkgaXNuJ3QgY29taW5nIHVwLg0KDQpPbmNlIHRoaXMg
aXMgbWVyZ2VkLCBJJ2xsIHRoaW5rIGFib3V0IEFQSXMuIEkgbmVlZCB0byBhZGQgbW9yZQ0KYmlu
ZGluZ3MgYW55d2F5Lg0KDQoNCj4gSW4gYW55IGNhc2UsIHBsZWFzZSBtYWtlIHRoZSBkb2NzIGNs
ZWFyIGFib3V0IHdoYXQgYmVoYXZpb3IgaXMNCj4gZXhlY3V0ZWQgYW5kIHdoYXQgdGhlIHByZWNv
bmRpdGlvbnMgYXJlLCBpdCBzaG91bGQgYmUgY2xlYXIgd2hhdCdzDQo+IGdvaW5nIHRvIHdhaXQg
Zm9yIHRoZSBidXMgdnMuIHNpbXBsZSBmaWVsZCBhY2Nlc3MuDQoNClN1cmUuDQoNCj4+ICsgICAg
ICAgIGlmIHJldCBhcyB1MzIgJiB1YXBpOjpCTUNSX1NQRUVEMTAwICE9IDAgew0KPj4gKyAgICAg
ICAgICAgIGRldi5zZXRfc3BlZWQoMTAwKTsNCj4+ICsgICAgICAgIH0gZWxzZSB7DQo+PiArICAg
ICAgICAgICAgZGV2LnNldF9zcGVlZCgxMCk7DQo+PiArICAgICAgICB9DQo+IA0KPiBTcGVlZCBz
aG91bGQgcHJvYmFibHkgYWN0dWFsbHkgYmUgYW4gZW51bSBzaW5jZSBpdCBoYXMgZGVmaW5lZCB2
YWx1ZXMuDQo+IFNvbWV0aGluZyBsaWtlDQo+IA0KPiAgICAgI1tub25fZXhoYXVzdGl2ZV0NCj4g
ICAgIGVudW0gU3BlZWQgew0KPiAgICAgICAgIFNwZWVkMTBNLA0KPiAgICAgICAgIFNwZWVkMTAw
TSwNCj4gICAgICAgICBTcGVlZDEwMDBNLA0KPiAgICAgICAgIC8vIDIuNUcsIDVHLCAxMEcsIDI1
Rz8NCj4gICAgIH0NCj4gDQo+ICAgICBpbXBsIFNwZWVkIHsNCj4gICAgICAgICBmbiBhc19tYihz
ZWxmKSAtPiB1MzI7DQo+ICAgICB9DQo+IA0KDQpldGh0b29sLmggc2F5czoNCg0KLyogVGhlIGZv
cmNlZCBzcGVlZCwgaW4gdW5pdHMgb2YgMU1iLiBBbGwgdmFsdWVzIDAgdG8gSU5UX01BWCBhcmUg
bGVnYWwuDQogKiBVcGRhdGUgZHJpdmVycy9uZXQvcGh5L3BoeS5jOnBoeV9zcGVlZF90b19zdHIo
KSBhbmQNCiAqIGRyaXZlcnMvbmV0L2JvbmRpbmcvYm9uZF8zYWQuYzpfX2dldF9saW5rX3NwZWVk
KCkgd2hlbiBhZGRpbmcgbmV3IHZhbHVlcy4NCiAqLw0KDQpJIGRvbid0IGtub3cgdGhlcmUgYXJl
IGRyaXZlcnMgdGhhdCBzZXQgc3VjaCB2YWx1ZXMuDQoNCg0KPj4gKyAgICAgICAgbGV0IGR1cGxl
eCA9IGlmIHJldCBhcyB1MzIgJiB1YXBpOjpCTUNSX0ZVTExEUExYICE9IDAgew0KPj4gKyAgICAg
ICAgICAgIHBoeTo6RHVwbGV4TW9kZTo6RnVsbA0KPj4gKyAgICAgICAgfSBlbHNlIHsNCj4+ICsg
ICAgICAgICAgICBwaHk6OkR1cGxleE1vZGU6OkhhbGYNCj4+ICsgICAgICAgIH07DQo+IA0KPiBC
TUNSX3ggYW5kIE1JSV94IGFyZSBnZW5lcmF0ZWQgYXMgYHUzMmAgYnV0IHRoYXQncyBqdXN0IGEg
YmluZGdlbg0KPiB0aGluZy4gSXQgc2VlbXMgd2Ugc2hvdWxkIHJlZXhwb3J0IHRoZW0gYXMgdGhl
IGNvcnJlY3QgdHlwZXMgc28gdXNlcnMNCj4gZG9uJ3QgbmVlZCB0byBjYXN0IGFsbCBvdmVyOg0K
PiANCj4gICAgIHB1YiBNSUlfQk1DUjogdTggPSBiaW5kaW5nczo6TUlJX0JNQ1IgYXMgdTg7DQo+
ICAgICBwdWIgQk1DUl9SRVNWOiB1MTYgPSBiaW5kaW5nczo6Qk1DUl9SRVNWIGFzIHUxNjsgLi4u
DQo+ICAgICAvLyAoSSdkIGp1c3QgbWFrZSBhIG1hY3JvIGZvciB0aGlzKQ0KPiANCj4gQnV0IEkn
bSBub3Qgc3VyZSBob3cgdG8gaGFuZGxlIHRoYXQgc2luY2UgdGhlIHVhcGkgY3JhdGUgZXhwb3Nl
cyBpdHMNCj4gYmluZGluZ3MgZGlyZWN0bHkuIFdlJ3JlIHByb2JhYmx5IGdvaW5nIHRvIHJ1biBp
bnRvIHRoaXMgaXNzdWUgd2l0aA0KPiBvdGhlciB1YXBpIGl0ZW1zIGF0IHNvbWUgcG9pbnQsIGFu
eSB0aG91Z2h0cyBNaWd1ZWw/DQoNCnJlZXhwb3J0aW5nIGFsbCB0aGUgQk1DUl8gdmFsdWVzIGJ5
IGhhbmQgZG9lc24ndCBzb3VuZCBmdW4uIENhbiB3ZQ0KYXV0b21hdGljYWxsIGdlbmVyYXRlIHN1
Y2g/DQoNCj4+ICsgICAgICAgIGRldi5nZW5waHlfcmVhZF9scGEoKT87DQo+IA0KPiBTYW1lIHF1
ZXN0aW9uIGFzIHdpdGggdGhlIGBnZW5waHlfdXBkYXRlX2xpbmtgDQo+IA0KPj4gKyAgICBmbiBs
aW5rX2NoYW5nZV9ub3RpZnkoZGV2OiAmbXV0IHBoeTo6RGV2aWNlKSB7DQo+PiArICAgICAgICAv
LyBSZXNldCBQSFksIG90aGVyd2lzZSBNSUlfTFBBIHdpbGwgcHJvdmlkZSBvdXRkYXRlZCBpbmZv
cm1hdGlvbi4NCj4+ICsgICAgICAgIC8vIFRoaXMgaXNzdWUgaXMgcmVwcm9kdWNpYmxlIG9ubHkg
d2l0aCBzb21lIGxpbmsgcGFydG5lciBQSFlzLg0KPj4gKyAgICAgICAgaWYgZGV2LnN0YXRlKCkg
PT0gcGh5OjpEZXZpY2VTdGF0ZTo6Tm9MaW5rIHsNCj4+ICsgICAgICAgICAgICBsZXQgXyA9IGRl
di5pbml0X2h3KCk7DQo+PiArICAgICAgICAgICAgbGV0IF8gPSBkZXYuc3RhcnRfYW5lZygpOw0K
Pj4gKyAgICAgICAgfQ0KPj4gKyAgICB9DQo+PiArfQ0KPiANCj4gSXMgaXQgd29ydGggZG9pbmcg
YW55dGhpbmcgd2l0aCB0aGVzZSBlcnJvcnM/IEkga25vdyB0aGF0IHRoZSBDIGRyaXZlciBkb2Vz
bid0Lg0KDQpJJ2xsIGNoZWNrIG91dCB3aGF0IG90aGVyIGRyaXZlcnMgZG8gaW4gdGhlIHNpbWls
YXIgc2l0dWF0aW9ucy4NCg0KDQo+IFRoZSBvdmVyYWxsIGRyaXZlciBsb29rcyBjb3JyZWN0IHRv
IG1lLCBtb3N0IG9mIHRoZXNlIGNvbW1lbnRzIGFyZQ0KPiBhY3R1YWxseSBhYm91dCBbMS8zXQ0K
DQpUaGFua3MhDQo=

