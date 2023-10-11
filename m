Return-Path: <netdev+bounces-40177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B167C60FF
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 01:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A527F282275
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 23:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BE123755;
	Wed, 11 Oct 2023 23:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gykYWkOS"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE3521A09;
	Wed, 11 Oct 2023 23:18:31 +0000 (UTC)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E8AA9;
	Wed, 11 Oct 2023 16:18:28 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c9ba72f6a1so781475ad.1;
        Wed, 11 Oct 2023 16:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697066308; x=1697671108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vtxOWZP+FH/F2zhaIO1LTs7w6wEmWDZirwNVhXFHmho=;
        b=gykYWkOSQ2+KM0juNllsuOa5tSBI3ejqsQ0JceUXHRDyyaUbkoDUaLTahZ2umVOLMD
         hDlG/bb+MX+KUVbrckyPPBsOHP1D6rNwk+6z6NGhWZv5VtaOMj0vIk5nWf9ukVhsJfKy
         oU2gO5i9vH13PYemDW8SGck5kyeomhVWV0CcHHO9UUXtsJBLVhB9Xrs1goRT7X1EG4x3
         fCetXDhtVHvU993CWJamukdyhEiyzwJXjbjhhvAVe9Q+cEQQ4/LuWE2jkLpNVZp0XhRp
         Bp6pJzYxvKNnc/rIUnqC6aeZE2ZdDlzOem6v+P2YEVLG/kWtHUB3QkM8hglWzEP1RPXb
         GCZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697066308; x=1697671108;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vtxOWZP+FH/F2zhaIO1LTs7w6wEmWDZirwNVhXFHmho=;
        b=YV9Qk3i7+N4T1aGQ9A975XkAr62GibTFeD4NijhLgvGT6nQAPtzabZLcwQ9SaCZoAn
         UKkYyF1FpS5hKqgI2HR4CzpHN7ZbPSKhk05+H1WErO5/EBqBkkj0y71tJWKEdxnc8lp/
         JP2X/BlV3BtxJBRMqTn1i23YsPPrHox8xBMeizVIYEeBtvlID4WhxmKb7Ogdr2Sj7zFA
         IUIFoDVbEmtZ5B+GtPkbD7CxIgBrAr5gh0y5r7lxq/GNKckdMn8IC8ZgiQXKOhrsJDa8
         mQNwrJ+AoVksbkzKbFtF059suaguH2dzp0b1vdD6eSNSp/V1aGwFDtSaXjB2Y48G3h4f
         rqNQ==
X-Gm-Message-State: AOJu0YyidhDsVXP3h04pxczZuqfD34Kt5Rrsvisf4Vh+KMEuI1QEHTT/
	GyXzNkpkrvkreky7fULCpow=
X-Google-Smtp-Source: AGHT+IFfMC+Iz/6wCzVY4B196nsqSXsc6kIahvb5lw06VFuDqCF5EkXgbX9yASQwPG4ugxm2zetA8g==
X-Received: by 2002:a17:902:f149:b0:1c9:d366:8ef5 with SMTP id d9-20020a170902f14900b001c9d3668ef5mr2462267plb.1.1697066307764;
        Wed, 11 Oct 2023 16:18:27 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id ji10-20020a170903324a00b001c444f185b4sm397352plb.237.2023.10.11.16.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 16:18:27 -0700 (PDT)
Date: Thu, 12 Oct 2023 08:18:26 +0900 (JST)
Message-Id: <20231012.081826.1846197263913130802.fujita.tomonori@gmail.com>
To: miguel.ojeda.sandonis@gmail.com
Cc: fujita.tomonori@gmail.com, gregkh@linuxfoundation.org,
 netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 tmgross@umich.edu, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v3 1/3] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CANiq72=GAiR-Mps_ZuLtxmma28dJd2xKdXWh6fu1icLBmmaYAw@mail.gmail.com>
References: <CANiq72nj_04U82Kb4DfMx72NPgHzDCd-xbosc83xgF19nCqSfQ@mail.gmail.com>
	<20231010.005008.2269883065591704918.fujita.tomonori@gmail.com>
	<CANiq72=GAiR-Mps_ZuLtxmma28dJd2xKdXWh6fu1icLBmmaYAw@mail.gmail.com>
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
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

T24gV2VkLCAxMSBPY3QgMjAyMyAxMTo1OTowMSArMDIwMA0KTWlndWVsIE9qZWRhIDxtaWd1ZWwu
b2plZGEuc2FuZG9uaXNAZ21haWwuY29tPiB3cm90ZToNCg0KPiBPbiBNb24sIE9jdCA5LCAyMDIz
IGF0IDU6NTDigK9QTSBGVUpJVEEgVG9tb25vcmkNCj4gPGZ1aml0YS50b21vbm9yaUBnbWFpbC5j
b20+IHdyb3RlOg0KPj4NCj4+IFdoYXQgZmVlZGJhY2s/IGVudW0gc3R1ZmY/IEkgdGhpbmsgdGhh
dCBpdCdzIGEgbG9uZy10ZXJtIGlzc3VlLg0KPiANCj4gTm90IGp1c3QgdGhhdC4gVGhlcmUgaGFz
IGJlZW4gb3RoZXIgZmVlZGJhY2ssIGFuZCBzaW5jZSB0aGlzIG1lc3NhZ2UsDQo+IHdlIGdvdCBu
ZXcgcmV2aWV3cyB0b28uDQo+IA0KPiBCdXQsIHllcywgdGhlIGAtLXJ1c3RpZmllZC1lbnVtYCBp
cyBvbmUgb2YgdGhvc2UuIEkgYW0gc3RpbGwNCj4gdW5jb21mb3J0YWJsZSB3aXRoIGl0LiBJdCBp
cyBub3QgYSBodWdlIGRlYWwgZm9yIGEgd2hpbGUsIGFuZCB0aGluZ3MNCj4gd2lsbCB3b3JrLCBh
bmQgdGhlIHJpc2sgb2YgVUIgaXMgbG93LiBCdXQgd2h5IGRvIHdlIHdhbnQgdG8gcmlzayBpdD8N
Cj4gVGhlIHBvaW50IG9mIHVzaW5nIFJ1c3QgaXMgcHJlY2lzZWx5IHRvIGF2b2lkIHRoaXMgc29y
dCBvZiB0aGluZy4NCj4NCj4gV2h5IGNhbm5vdCB3ZSB1c2Ugb25lIG9mIHRoZSBhbHRlcm5hdGl2
ZXM/IElmIHdlIHJlYWxseSB3YW50IHRvIGNhdGNoLA0KPiByaWdodCBub3csIHRoZSAiYWRkaXRp
b24gb2YgbmV3IHZhcmlhbnQgaW4gdGhlIEMgZW51bSIgY2FzZSwgY2Fubm90IHdlDQo+IGFkZCBh
IHRlbXBvcmFyeSBjaGVjayBmb3IgdGhhdD8gZS5nLiBpdCBvY2N1cnMgdG8gbWUgd2UgY291bGQg
bWFrZQ0KDQpJSVJDLCBBbmRyZXcgcHJlZmVycyB0byBhdm9pZCBjcmVhdGluZyBhIHRlbXBvcmFy
eSBydXN0IHZhcmlhbnQgKEdyZWcNCmRvZXMgdG9vLCBJIHVuZGVyc3RhbmQpLiBJIGd1ZXNzIHRo
YXQgb25seSBzb2x1c2lvbiB0aGF0IGJvdGggUnVzdCBhbmQNCkMgZGV2cyB3b3VsZCBiZSBoYXBw
eSB3aXRoIGlzIGdlbmVyYXRpbmcgc2FmZSBSdXN0IGNvZGUgZnJvbSBDLiBUaGUNCnNvbHV0aW9u
IGlzIHN0aWxsIGEgcHJvdG90eXBlIGFuZCBJIGRvbid0IGtub3cgd2hlbiBpdCB3aWxsIGJlDQph
dmFpbGFibGUgKHNvbWVvbmUga25vd3M/KS4NCg0KSSB0aGluayB0aGF0IHVubGlrZWx5IFBIWUxJ
QidzIHN0YXRlIG1hY2hpbmUgd291bGQgYmUgYnJva2VuLCBzbyBJDQpjaG9zZSB0aGF0IGFwcHJv
YWNoIHdpdGggdGhlIGNvZGUgY29tbWVudGVkLg0KDQoNCj4+IEknbSBub3Qgc3VyZSBhYm91dCBp
dC4gRm9yIGV4YW1wbGUsIHdlIHJldmlld2VkIHRoZSBsb2NraW5nIGlzc3VlDQo+PiB0aHJlZSB0
aW1lcy4gSXQgY2FuJ3QgYmUgcmV2aWV3ZWQgb25seSBvbiBSdXN0IHNpZGUuIEl0J3MgbWFpbmx5
IGFib3V0DQo+PiBob3cgdGhlIEMgc2lkZSB3b3Jrcy4NCj4gDQo+IFdlIGhhdmUgbmV2ZXIgc2Fp
ZCBpdCBoYXMgdG8gYmUgcmV2aWV3ZWQgb25seSBvbiB0aGUgUnVzdCBzaWRlLiBJbg0KPiBmYWN0
LCBvdXIgaW5zdHJ1Y3Rpb25zIGZvciBjb250cmlidXRpbmcgZXhwbGFpbiB2ZXJ5IGNsZWFybHkg
dGhlDQo+IG9wcG9zaXRlOg0KPiANCj4gICAgIGh0dHBzOi8vcnVzdC1mb3ItbGludXguY29tL2Nv
bnRyaWJ1dGluZyN0aGUtcnVzdC1zdWJzeXN0ZW0NCj4gDQo+IFRoZSBpbnN0cnVjdGlvbnMgYWxz
byBzYXkgdGhhdCB0aGUgY29kZSBtdXN0IGJlIHdhcm5pbmctZnJlZSBhbmQgc28NCj4gb24sIGFu
ZCB5ZXQgYWZ0ZXIgc2V2ZXJhbCBpdGVyYXRpb25zIGFuZCBwdXNoaW5nIGZvciBtZXJnaW5nIHNl
dmVyYWwNCj4gdGltZXMsIHRoZXJlIGFyZSBzdGlsbCAic3VyZmFjZS1sZXZlbCIgdGhpbmdzIGxp
a2UgbWlzc2luZyBgLy8gU0FGRVRZYA0KPiBjb21tZW50cyBhbmQgYGJpbmRpbmdzOjpgIGluIHB1
YmxpYyBBUElzOyB3aGljaCB3ZSBjb25zaWRlciB2ZXJ5DQo+IGltcG9ydGFudCAtLSB3ZSB3YW50
IHRvIGdldCB0aGVtIGVuZm9yY2VkIGJ5IHRoZSBjb21waWxlciBpbiB0aGUNCj4gZnV0dXJlLg0K
PiANCj4gTm90IG9ubHkgdGhhdCwgd2hlbiBJIHNhdyBXZWRzb24gbWVudGlvbmluZyB5ZXN0ZXJk
YXkgdGhlDQo+IGAjW211c3RfdXNlXWAgYml0LCBJIHdvbmRlcmVkIGhvdyB0aGlzIHdhcyBldmVu
IG5vdCBiZWluZyBub3RpY2VkIGJ5DQo+IHRoZSBjb21waWxlci4NCj4gDQo+IFNvIEkganVzdCB0
b29rIHRoZSB2MyBwYXRjaGVzIGFuZCBjb21waWxlZCB0aGVtIGFuZCwgaW5kZWVkLCBDbGlwcHkg
Z2l2ZXMgeW91Og0KDQpTb3JyeSwgdGhlcmUncyBubyBleGN1c2UuIEkgc2hvdWxkIGhhdmUgZG9u
ZSBiZXR0ZXIuIEknbGwgbWFrZSBzdXJlDQp0aGF0IHRoZSBjb2RlIGlzIHdhcm5pbmctZnJlZS4N
Cg==

