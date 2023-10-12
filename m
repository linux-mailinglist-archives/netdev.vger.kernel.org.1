Return-Path: <netdev+bounces-40223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF2A7C6399
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 05:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 662D01C209FC
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 03:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8290453A6;
	Thu, 12 Oct 2023 03:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2KyE25f"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5732B771;
	Thu, 12 Oct 2023 03:59:41 +0000 (UTC)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544D41729;
	Wed, 11 Oct 2023 20:59:39 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c76ef40e84so1114765ad.0;
        Wed, 11 Oct 2023 20:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697083179; x=1697687979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pktqnTbnccOKrm3NTGufz6jVENECPcDJID1YL/hRLg8=;
        b=C2KyE25fbouqak3Tchymw9rZiG6ypNk51AaIJUMo7WtXy0gCnR3zmx0iU83uyHFFMp
         N4hBBHeqKX8fmkU+LXXL+7xxLPIp7Mao8IUe289LguMcu/OTYKHFAPmnE/9ykbAZIGkQ
         ++nYhFiVN/j+kVS9a9VuXai232hN4lZTFOOmnFTWbujeYmnyMKBcdTmVga59pF+WyIhu
         UFkUDAp3iS1Kwp8nzTbGmuXANB4fws20Hnkri3MZLvG2wqA5bJixyLG0nhDGTE0zFFHc
         GsjRpCmLahSjfa2XYYoOWP5oiWJbrhyDjp/vTJWvTf5pibVZUnkjMBRh1I0L1yT6OmlB
         StHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697083179; x=1697687979;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pktqnTbnccOKrm3NTGufz6jVENECPcDJID1YL/hRLg8=;
        b=TGEo22BO3ElCWY2YaPxv8lzxuZPcUuUNg7RFQSROg8EBz1WLJf9PMyHZGcGPYkeHvF
         R5V0+sK7RKt3udilySQYE2CTMTY5/cTs8n0VG9VhJTVG8qi0pMGGp37fKI5Djn5q5OEH
         motMKTEWORpDZh2ORifkp2cdjg3GVjLvi3FBu0YaDnbgerjm14fptXC12Nuk4k1Vp9SP
         RIApry+DkuKZ58UYtVfo50Kztvoo+0Mz8sFflKTCI2cE9TZa3R1WxkAsbPrXqZ5wULxF
         oxanuc3icVWvXcDAeat9maVTsR0kFi+R+96TOxEsgDCxibGMqkWWW2gwEEDSo5PeA5fW
         tKrg==
X-Gm-Message-State: AOJu0YyQf6mWVYXPqxZTXrLDU5fr0S/lGXdsU3D2hCbd9bnE3i94pGke
	kDfWZOgm3ni8gvQaVeLTiHs=
X-Google-Smtp-Source: AGHT+IFMLyxQRfE4Lh2sBIWkgyx/z9HAYhZsWrhIdoycRjFbf2RAZVozIBEGgTyqB+YvbXjgDEsf7g==
X-Received: by 2002:a17:902:ce84:b0:1c3:a4f2:7c99 with SMTP id f4-20020a170902ce8400b001c3a4f27c99mr25695159plg.4.1697083178669;
        Wed, 11 Oct 2023 20:59:38 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id r23-20020a170902be1700b001ba066c589dsm710144pls.137.2023.10.11.20.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 20:59:38 -0700 (PDT)
Date: Thu, 12 Oct 2023 12:59:37 +0900 (JST)
Message-Id: <20231012.125937.1346884503622296050.fujita.tomonori@gmail.com>
To: miguel.ojeda.sandonis@gmail.com
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch, greg@kroah.com,
 tmgross@umich.edu, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v3 1/3] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CANiq72nBSyQw+vFayPco5b_-DDAKNqmhE7xiXSVbg920_ttAeQ@mail.gmail.com>
References: <20231009013912.4048593-1-fujita.tomonori@gmail.com>
	<20231009013912.4048593-2-fujita.tomonori@gmail.com>
	<CANiq72nBSyQw+vFayPco5b_-DDAKNqmhE7xiXSVbg920_ttAeQ@mail.gmail.com>
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

T24gTW9uLCA5IE9jdCAyMDIzIDE0OjU5OjE5ICswMjAwDQpNaWd1ZWwgT2plZGEgPG1pZ3VlbC5v
amVkYS5zYW5kb25pc0BnbWFpbC5jb20+IHdyb3RlOg0KDQo+IEhpIFRvbW9ub3JpLA0KPiANCj4g
QSBmZXcgbml0cyBJIG5vdGljZWQuIFBsZWFzZSBub3RlIHRoYXQgdGhpcyBpcyBub3QgcmVhbGx5
IGEgZnVsbA0KPiByZXZpZXcsIGFuZCB0aGF0IEkgcmVjb21tZW5kIHRoYXQgb3RoZXIgcGVvcGxl
IGxpa2UgV2Vkc29uIHNob3VsZCB0YWtlDQo+IGEgbG9vayBhZ2FpbiBhbmQgT0sgdGhlc2UgYWJz
dHJhY3Rpb25zIGJlZm9yZSB0aGlzIGlzIG1lcmdlZC4NCj4gDQo+IE9uIE1vbiwgT2N0IDksIDIw
MjMgYXQgMzo0MeKAr0FNIEZVSklUQSBUb21vbm9yaQ0KPiA8ZnVqaXRhLnRvbW9ub3JpQGdtYWls
LmNvbT4gd3JvdGU6DQo+Pg0KPj4gK2NvbmZpZyBSVVNUX1BIWUxJQl9CSU5ESU5HUw0KPiANCj4g
VGhpcyBzaG91bGQgYmUgY2FsbGVkIEFCU1RSQUNUSU9OUy4gUGxlYXNlIHNlZToNCg0KRml4ZWQu
DQoNCj4gICAgIGh0dHBzOi8vZG9jcy5rZXJuZWwub3JnL3J1c3QvZ2VuZXJhbC1pbmZvcm1hdGlv
bi5odG1sI2Fic3RyYWN0aW9ucy12cy1iaW5kaW5ncw0KPiANCj4gQWxzbywgY291bGQgdGhpcyBz
eW1ib2wgZ28gZWxzZXdoZXJlPw0KDQpUaGlzIHN5bWJvbCBpcyB1c2VkIGJ5IHRoZSB0aGlyZCBw
YXRjaC4gV2hlcmUgZG8geW91IHdhbnQgdGhpcz8gDQoNCg0KPj4gKyAgICAgICAgYm9vbCAiUEhZ
TElCIGJpbmRpbmdzIHN1cHBvcnQiDQo+IA0KPiBEaXR0by4NCg0KVXBkYXRlZC4NCg0KDQo+PiAr
ICAgICAgICAgIGEgd3JhcHBlciBhcm91bmQgdGhlIEMgcGhsaWIgY29yZS4NCj4gDQo+IFR5cG8u
DQoNCk9vcHMsIHNvcnJ5Lg0KDQoNCj4+ICsjIVtmZWF0dXJlKGNvbnN0X21heWJlX3VuaW5pdF96
ZXJvZWQpXQ0KPiANCj4gVGhlIHBhdGNoIG1lc3NhZ2Ugc2hvdWxkIGp1c3RpZnkgdGhpcyBhZGRp
dGlvbiBhbmQgd2FybiBhYm91dCBpdC4NCg0KSSBhZGRlZCB0aGUgZm9sbG93aW5nIHRvIHRoZSBj
b21taXQgbG9nLg0KDQpUaGlzIHBhdGNoIGVuYWJsZXMgdW5zdGFibGUgY29uc3RfbWF5YmVfdW5p
bml0X3plcm9lZCBmZWF0dXJlIGZvcg0Ka2VybmVsIGNyYXRlIHRvIGVuYWJsZSB1bnNhZmUgY29k
ZSB0byBoYW5kbGUgYSBjb25zdGFudCB2YWx1ZSB3aXRoDQp1bmluaXRpYWxpemVkIGRhdGEuIFdp
dGggdGhlIGZlYXR1cmUsIHRoZSBhYnN0cmFjdGlvbnMgY2FuIGluaXRpYWxpemUNCmEgcGh5X2Ry
aXZlciBzdHJ1Y3R1cmUgd2l0aCB6ZXJvIGVhc2lseTsgaW5zdGVhZCBvZiBpbml0aWFsaXppbmcg
YWxsDQp0aGUgbWVtYmVycyBieSBoYW5kLg0KDQoNCj4+IGRpZmYgLS1naXQgYS9ydXN0L2tlcm5l
bC9uZXQvcGh5LnJzIGIvcnVzdC9rZXJuZWwvbmV0L3BoeS5ycw0KPj4gbmV3IGZpbGUgbW9kZSAx
MDA2NDQNCj4+IGluZGV4IDAwMDAwMDAwMDAwMC4uZjMxOTgzYmYwNDYwDQo+PiAtLS0gL2Rldi9u
dWxsDQo+PiArKysgYi9ydXN0L2tlcm5lbC9uZXQvcGh5LnJzDQo+PiBAQCAtMCwwICsxLDczMyBA
QA0KPj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+PiArLy8gQ29weXJp
Z2h0IChDKSAyMDIzIEZVSklUQSBUb21vbm9yaSA8ZnVqaXRhLnRvbW9ub3JpQGdtYWlsLmNvbT4N
Cj4gDQo+IE5ld2xpbmUgbWlzc2luZy4NCg0KQWRkZWQuDQoNCg0KPj4gKyAgICAvLy8gRnVsbC1k
dXBsZXggbW9kZQ0KPiANCj4gUGxlYXNlIHVzZSB0aGUgc3R5bGUgb2YgdGhlIHJlc3Qgb2YgdGhl
IFJ1c3QgY29tbWVudHMuDQoNCkknbSBub3Qgc3VyZSB3aGF0IHRoZSBzdHlsZSBzaG91bGQgYmUg
YnV0IHNvbWV0aGluZyBsaWtlIHRoZQ0KZm9sbG93aW5nPw0KDQovLy8gUmVwcmVzZW50cyBkdXBs
ZXggbW9kZS4NCnB1YiBlbnVtIER1cGxleE1vZGUgew0KICAgIC8vLyBQSFkgaXMgaW4gZnVsbC1k
dXBsZXggbW9kZS4NCiAgICBGdWxsLA0KDQo+PiArLy8vIEFuIGluc3RhbmNlIG9mIGEgUEhZIGRl
dmljZS4NCj4+ICsvLy8gV3JhcHMgdGhlIGtlcm5lbCdzIGBzdHJ1Y3QgcGh5X2RldmljZWAuDQo+
IA0KPiBUaGF0IHNob3VsZCBiZSBzZXBhcmF0ZWQuDQoNCkFkZGVkLg0KDQoNCj4+ICsgICAgLy8v
IEZvciB0aGUgZHVyYXRpb24gb2YgdGhlIGxpZmV0aW1lICdhLCB0aGUgcG9pbnRlciBtdXN0IGJl
IHZhbGlkIGZvciB3cml0aW5nIGFuZCBub2JvZHkgZWxzZQ0KPiANCj4gTWlzc2luZyBNYXJrZG93
biBhcm91bmQgdGhlIGxpZmV0aW1lLg0KDQpGaXhlZC4NCg0KDQo+PiArICAgICAgICAvLyBGSVhN
RTogZW51bS1jYXN0DQo+IA0KPiBQbGVhc2UgZXhwbGFpbiB3aGF0IG5lZWRzIHRvIGJlIGZpeGVk
Lg0KDQpBZGRlZC4NCg0KDQo+PiArICAgIC8vLyBFeGVjdXRlcyBzb2Z0d2FyZSByZXNldCB0aGUg
UEhZIHZpYSBCTUNSX1JFU0VUIGJpdC4NCj4gDQo+IE1hcmtkb3duIG1pc3NpbmcgKG11bHRpcGxl
IGluc3RhbmNlcykuDQoNCkNhbiB5b3UgZWxhYm9yYXRlPw0KDQoNCj4+ICsgICAgLy8vIFJlYWRz
IExpbmsgcGFydG5lciBhYmlsaXR5Lg0KPiANCj4gV2h5IGlzICJsaW5rIiBjYXBpdGFsaXplZCBo
ZXJlPw0KDQpGaXhlZC4NCg0KDQo+PiArLy8vIENyZWF0ZXMgdGhlIGtlcm5lbCdzIGBwaHlfZHJp
dmVyYCBpbnN0YW5jZS4NCj4+ICsvLy8NCj4+ICsvLy8gVGhpcyBpcyB1c2VkIGJ5IFtgbW9kdWxl
X3BoeV9kcml2ZXJgXSBtYWNybyB0byBjcmVhdGUgYSBzdGF0aWMgYXJyYXkgb2YgcGh5X2RyaXZl
cmAuDQo+IA0KPiBCcm9rZW4gZm9ybWF0dGluZz8gRG9lcyBgcnVzdGRvY2AgY29tcGxhaW4gYWJv
dXQgaXQ/DQoNClllcywgc29ycnkgYWJvdXQgdGhhdC4NCg0KDQo+PiArLy8vIFRoZSBgZHJpdmVy
c2AgcG9pbnRzIHRvIGFuIGFycmF5IG9mIGBzdHJ1Y3QgcGh5X2RyaXZlcmAsIHdoaWNoIGlzDQo+
PiArLy8vIHJlZ2lzdGVyZWQgdG8gdGhlIGtlcm5lbCB2aWEgYHBoeV9kcml2ZXJzX3JlZ2lzdGVy
YC4NCj4gDQo+IFBlcmhhcHMgIlRoZSBgZHJpdmVyc2AgZmllbGQiPw0KDQpJIHJlcGxhY2VkIHRo
aXMgd2l0aCB0aGUgZm9sbG93aW5nIGNvbW1lbnQgc3VnZ2VzdGVkIGJ5IEJlbm5vLg0KDQovLy8g
QWxsIGVsZW1lbnRzIG9mIHRoZSBgZHJpdmVyc2Agc2xpY2UgYXJlIHZhbGlkIGFuZCBjdXJyZW50
bHkgcmVnaXN0ZXJlZA0KLy8vIHRvIHRoZSBrZXJuZWwgdmlhIGBwaHlfZHJpdmVyc19yZWdpc3Rl
cmAuDQoNCg0KPj4gKyAgICAgICAgICAgIC8vIFNBRkVUWTogVGhlIHR5cGUgaW52YXJpYW50cyBn
dWFyYW50ZWUgdGhhdCBzZWxmLmRyaXZlcnMgaXMgdmFsaWQuDQo+IA0KPiBNYXJrZG93bi4NCg0K
Rml4ZWQuDQoNCg0KPj4gKy8vLyBSZXByZXNlbnRzIHRoZSBrZXJuZWwncyBgc3RydWN0IG1kaW9f
ZGV2aWNlX2lkYC4NCj4+ICtwdWIgc3RydWN0IERldmljZUlkIHsNCj4+ICsgICAgLy8vIENvcnJl
c3BvbmRzIHRvIGBwaHlfaWRgIGluIGBzdHJ1Y3QgbWRpb19kZXZpY2VfaWRgLg0KPj4gKyAgICBw
dWIgaWQ6IHUzMiwNCj4+ICsgICAgbWFzazogRGV2aWNlTWFzaywNCj4+ICt9DQo+IA0KPiBJdCB3
b3VsZCBiZSBuaWNlIHRvIGV4cGxhaW4gd2h5IHRoZSBmaWVsZCBpcyBgcHViYC4NCg0KQWRkZWQu
DQoNCg0KPj4gKyAgICAvLy8gR2V0IGEgbWFzayBhcyB1MzIuDQo+IA0KPiBNYXJrZG93bi4NCg0K
Rml4ZWQuDQoNCg0KPiBUaGlzIHBhdGNoIGNvdWxkIGJlIHNwbGl0IGEgYml0IHRvbywgYnV0IHRo
YXQgaXMgdXAgdG8gdGhlIG1haW50YWluZXJzLg0KDQpZZWFoLg0KDQoNCj4+ICsvLy8gRGVjbGFy
ZXMgYSBrZXJuZWwgbW9kdWxlIGZvciBQSFlzIGRyaXZlcnMuDQo+PiArLy8vDQo+PiArLy8vIFRo
aXMgY3JlYXRlcyBhIHN0YXRpYyBhcnJheSBvZiBgc3RydWN0IHBoeV9kcml2ZXJgIGFuZCByZWdp
c3RlcnMgaXQuDQo+IA0KPiAia2VybmVsJ3MiIG9yIHNpbWlsYXINCg0KQWRkZWQuDQoNCg0KPj4g
Ky8vLyBUaGlzIGFsc28gY29ycmVzcG9uZHMgdG8gdGhlIGtlcm5lbCdzIE1PRFVMRV9ERVZJQ0Vf
VEFCTEUgbWFjcm8sIHdoaWNoIGVtYmVkcyB0aGUgaW5mb3JtYXRpb24NCj4gDQo+IE1hcmtkb3du
Lg0KDQpGaXhlZC4NCg0KPj4gKy8vLyBmb3IgbW9kdWxlIGxvYWRpbmcgaW50byB0aGUgbW9kdWxl
IGJpbmFyeSBmaWxlLiBFdmVyeSBkcml2ZXIgbmVlZHMgYW4gZW50cnkgaW4gZGV2aWNlX3RhYmxl
Lg0KPiANCj4gTWFya2Rvd24uDQoNCkZpeGVkLg0KDQoNCj4+ICsvLy8gIyBFeGFtcGxlcw0KPj4g
Ky8vLw0KPj4gKy8vLyBgYGBpZ25vcmUNCj4+ICsvLy8NCj4+ICsvLy8gdXNlIGtlcm5lbDo6bmV0
OjpwaHk6OntzZWxmLCBEZXZpY2VJZCwgRHJpdmVyfTsNCj4+ICsvLy8gdXNlIGtlcm5lbDo6cHJl
bHVkZTo6KjsNCj4+ICsvLy8NCj4+ICsvLy8ga2VybmVsOjptb2R1bGVfcGh5X2RyaXZlciEgew0K
Pj4gKy8vLyAgICAgZHJpdmVyczogW1BoeUFYODg3NzJBLCBQaHlBWDg4NzcyQywgUGh5QVg4ODc5
NkJdLA0KPj4gKy8vLyAgICAgZGV2aWNlX3RhYmxlOiBbDQo+PiArLy8vICAgICAgICAgRGV2aWNl
SWQ6Om5ld193aXRoX2RyaXZlcjo6PFBoeUFYODg3NzJBPigpLA0KPj4gKy8vLyAgICAgICAgIERl
dmljZUlkOjpuZXdfd2l0aF9kcml2ZXI6OjxQaHlBWDg4NzcyQz4oKSwNCj4+ICsvLy8gICAgICAg
ICBEZXZpY2VJZDo6bmV3X3dpdGhfZHJpdmVyOjo8UGh5QVg4ODc5NkI+KCkNCj4+ICsvLy8gICAg
IF0sDQo+PiArLy8vICAgICBuYW1lOiAicnVzdF9hc2l4X3BoeSIsDQo+PiArLy8vICAgICBhdXRo
b3I6ICJSdXN0IGZvciBMaW51eCBDb250cmlidXRvcnMiLA0KPj4gKy8vLyAgICAgZGVzY3JpcHRp
b246ICJSdXN0IEFzaXggUEhZcyBkcml2ZXIiLA0KPj4gKy8vLyAgICAgbGljZW5zZTogIkdQTCIs
DQo+PiArLy8vIH0NCj4+ICsvLy8gYGBgDQo+IA0KPiBQbGVhc2UgYWRkIGFuIGV4YW1wbGUgYWJv
dmUgd2l0aCB0aGUgZXhwYW5zaW9uIG9mIHRoZSBtYWNybyBzbyB0aGF0IGl0DQo+IGlzIGVhc3kg
dG8gdW5kZXJzdGFuZCBhdCBhIGdsYW5jZSwgc2VlIGUuZy4gd2hhdCBCZW5ubyBkaWQgaW4NCj4g
YHBpbi1pbml0YCAoYHJ1c3QvaW5pdCpgKS4NCg0KQWRkZWQuDQoNClRoYW5rcyBhIGxvdCENCg==

