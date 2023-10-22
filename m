Return-Path: <netdev+bounces-43276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 521347D2266
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 11:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6487FB20D46
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 09:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69261C3A;
	Sun, 22 Oct 2023 09:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQ/BfiAN"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B70515B0;
	Sun, 22 Oct 2023 09:47:05 +0000 (UTC)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647A2112;
	Sun, 22 Oct 2023 02:47:04 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6bf20d466cdso478216b3a.1;
        Sun, 22 Oct 2023 02:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697968024; x=1698572824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WSf1P8x6waV39pWhY+7q0DWkZtMI9mXMRQzObdm/cx4=;
        b=NQ/BfiAN0zhd0PwZyNrrJtVqgyKaseAhvF0dYMsmXo8Lm1QTWpV12qhire3AuKQhuz
         8s/qDno29fx06/wlsKlflPDTWl3oJYJg9H2CpN/nKf32Omv0YYRPoO2HxuFky8Wyo60n
         hpoKviF9lo2oOODmDvKK+JWGzvkl6HKhEEHIp7IutSJuHgaISFNIOv1F1jR/jerUvsO2
         qJdVHYasGkko+Bsxb3c/xm/etFcdm/KS7GIAlzf5sj3K7pRPVhwj6sJWYee0ZNFZFWeU
         FfJ3Jfc6tmOCPTDgQj6hBioGSFqNggflBbLHyYfxBbLuSoyWv/8QvO8+l4acmCf+zbAu
         E1ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697968024; x=1698572824;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WSf1P8x6waV39pWhY+7q0DWkZtMI9mXMRQzObdm/cx4=;
        b=vbjDW9Xf2KjgwGmsZadoYj/B4Oyy4HET6AyWeZ7zr5aUGhruN99eWxO6dxgSuHU0mZ
         Cn9fA+4Aw9eDHjF335lvdfxqRoBo14t6WndfjoTcRf3Zcm28n3k7cnlGcGSOc+gfW6Ys
         d6PDX0rKz+S8KOf7O6X5daqmByYId7W4KKeYujed0JEssT1sGJtWExJRhq0Ig9kRYApY
         V2HcLYti6iom19ymYQrATMGZjT+obSfdJr8PZzERLJYnyS0vLkUO40zFdj54sxIyDPK4
         jS7n3Kvrme3u9B3J9LlQMNozCPuodFJFfBtsmFTn9/1E8/FjhZhQGiXObOSksrX6BQzt
         8U2g==
X-Gm-Message-State: AOJu0YxwOneCXPbDrnFfqanmjsZFRCWN2RU8TctWXuiQvW+l1gbbp68f
	NyOTAl+199x8i3CMevrqgBs=
X-Google-Smtp-Source: AGHT+IFVH/MEml8TL55eOO3lPuYnol0fy7RYDkYUWwzUzcyy1G5qUxJKh/loze3gyyN+1mouJf8TBA==
X-Received: by 2002:a05:6a20:4420:b0:163:f945:42c4 with SMTP id ce32-20020a056a20442000b00163f94542c4mr9314307pzb.1.1697968023783;
        Sun, 22 Oct 2023 02:47:03 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id z64-20020a633343000000b005898a3619c7sm4036358pgz.48.2023.10.22.02.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 02:47:03 -0700 (PDT)
Date: Sun, 22 Oct 2023 18:47:02 +0900 (JST)
Message-Id: <20231022.184702.1777825182430453165.fujita.tomonori@gmail.com>
To: miguel.ojeda.sandonis@gmail.com
Cc: andrew@lunn.ch, benno.lossin@proton.me, fujita.tomonori@gmail.com,
 netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, tmgross@umich.edu,
 boqun.feng@gmail.com, wedsonaf@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v5 1/5] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CANiq72nOCv-TfE3ODgVyQoOxNc80BtH+5cV2XFBFZ=ztTgVhaw@mail.gmail.com>
References: <e361ef91-607d-400b-a721-f846c21e2400@proton.me>
	<4935f458-4719-4472-b937-0da8b16ebbaa@lunn.ch>
	<CANiq72nOCv-TfE3ODgVyQoOxNc80BtH+5cV2XFBFZ=ztTgVhaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64

T24gU2F0LCAyMSBPY3QgMjAyMyAxNDo0NzowNCArMDIwMA0KTWlndWVsIE9qZWRhIDxtaWd1ZWwu
b2plZGEuc2FuZG9uaXNAZ21haWwuY29tPiB3cm90ZToNCg0KPiBPbiBGcmksIE9jdCAyMCwgMjAy
MyBhdCA4OjQy4oCvUE0gQW5kcmV3IEx1bm4gPGFuZHJld0BsdW5uLmNoPiB3cm90ZToNCj4+DQo+
PiBXZSBkb24ndCB3YW50IHRvIGhpZGUgcGh5X2RldmljZSB0b28gbXVjaCwgc2luY2UgYXQgdGhl
IG1vbWVudCwgdGhlDQo+PiBhYnN0cmFjdGlvbiBpcyB2ZXJ5IG1pbmltYWwuIEFueWJvZHkgd3Jp
dGluZyBhIGRyaXZlciBpcyBnb2luZyB0byBuZWVkDQo+PiBhIGdvb2QgdW5kZXJzdGFuZGluZyBv
ZiB0aGUgQyBjb2RlIGluIG9yZGVyIHRvIGZpbmQgdGhlIGhlbHBlcnMgdGhleQ0KPj4gbmVlZCwg
YW5kIHRoZW4gYWRkIHRoZW0gdG8gdGhlIGFic3RyYWN0aW9uLiBTbyBpIHdvdWxkIHNheSB3ZSBu
ZWVkIHRvDQo+PiBleHBsYWluIHRoZSByZWxhdGlvbnNoaXAgYmV0d2VlbiB0aGUgQyBzdHJ1Y3R1
cmUgYW5kIHRoZSBSdXN0DQo+PiBzdHJ1Y3R1cmUsIHRvIGFpZCBkZXZlbG9wZXJzLg0KPiANCj4g
SSBkb24ndCBzZWUgaG93IGV4cG9zaW5nIGBwaHlfZGV2aWNlYCBpbiB0aGUgZG9jdW1lbnRhdGlv
biAobm90ZTogbm90DQo+IHRoZSBpbXBsZW1lbnRhdGlvbikgaGVscHMgd2l0aCB0aGF0LiBJZiBz
b21lb25lIGhhcyB0byBhZGQgdGhpbmdzIHRvDQo+IHRoZSBhYnN0cmFjdGlvbiwgdGhlbiBhdCB0
aGF0IHBvaW50IHRoZXkgbmVlZCB0byBiZSByZWFkaW5nIHRoZQ0KPiBpbXBsZW1lbnRhdGlvbiBv
ZiB0aGUgYWJzdHJhY3Rpb24sIGFuZCB0aHVzIHRoZXkgc2hvdWxkIHJlYWQgdGhlDQo+IGNvbW1l
bnRzLg0KPiANCj4gVGhhdCBpcyB3aHkgdGhlIGhlbHBlcnMgc2hvdWxkIGluIGdlbmVyYWwgbm90
IGJlIG1lbnRpb25lZCBpbiB0aGUNCj4gZG9jdW1lbnRhdGlvbiwgaS5lLiBhIFJ1c3QgQVBJIHVz
ZXIgc2hvdWxkIG5vdCBjYXJlIC8gbmVlZCB0byBrbm93DQo+IGFib3V0IHRoZW0uDQo+IA0KPiBJ
ZiB3ZSBtaXggdGhpbmdzIHVwIGluIHRoZSBkb2NzLCB0aGVuIGl0IGFjdHVhbGx5IGJlY29tZXMg
aGFyZGVyIGxhdGVyDQo+IG9uIHRvIHByb3Blcmx5IHNwbGl0IGl0OyBhbmQgaW4gdGhlIFJ1c3Qg
c2lkZSB3ZSB3YW50IHRvIG1haW50YWluIHRoaXMNCj4gICJBUEkgZG9jdW1lbnRhdGlvbiIgdnMu
ICJpbXBsZW1lbnRhdGlvbiBjb21tZW50cyIgc3BsaXQuIFRodXMgaXQgaXMNCj4gaW1wb3J0YW50
IHRvIGRvIGl0IHJpZ2h0IGluIHRoZSBmaXJzdCBleGFtcGxlcyB3ZSB3aWxsIGhhdmUgaW4tdHJl
ZS4NCj4gDQo+IEFuZCBpZiBhbiBBUEkgaXMgbm90IGFic3RyYWN0ZWQgeWV0LCBpdCBzaG91bGQg
bm90IGJlIGRvY3VtZW50ZWQuIEFQSXMNCj4gYW5kIHRoZWlyIGRvY3Mgc2hvdWxkIGJlIGFkZGVk
IHRvZ2V0aGVyLCBpbiB0aGUgc2FtZSBwYXRjaCwgd2hlcmV2ZXINCj4gcG9zc2libGUuIE9mIGNv
dXJzZSwgaW1wbGVtZW50YXRpb24gY29tbWVudHMgYXJlIGRpZmZlcmVudCwgYW5kDQo+IHBvc3Np
Ymx5IGEgZGVzaWduZXIgb2YgYW4gYWJzdHJhY3Rpb24gbWF5IGVzdGFibGlzaCBzb21lIHJ1bGVz
IG9yDQo+IGd1aWRlbGluZXMgZm9yIGZ1dHVyZSBBUElzIGFkZGVkIC0tIHRoYXQgaXMgZmluZSwg
YnV0IGlmIHRoZSB1c2VyIGRvZXMNCj4gbm90IG5lZWQgdG8ga25vdywgaXQgc2hvdWxkIG5vdCBi
ZSBpbiB0aGUgZG9jcywgZXZlbiBpZiBpdCBpcyBhZGRlZA0KPiBlYXJseS4NCj4gDQo+IFJlZ2Fy
ZGluZyB0aGlzLCBwYXJ0IG9mIHRoZSBgcGh5YCBtb2R1bGUgZG9jdW1lbnRhdGlvbiAoaS5lLiB0
aGUgdGhyZWUNCj4gcGFyYWdyYXBocykgaW4gdGhpcyBwYXRjaCBjdXJyZW50bHkgc291bmRzIG1v
cmUgbGlrZSBhbiBpbXBsZW1lbnRhdGlvbg0KPiBjb21tZW50IHRvIG1lLiBJdCBzaG91bGQgcHJv
YmFibHkgYmUgcmV3cml0dGVuL3NwbGl0IHByb3Blcmx5IGluIGRvY3MNCj4gdnMuIGNvbW1lbnRz
Lg0KDQpBZ3JlZWQgdGhhdCB0aGUgZmlyc3QgdGhyZWUgcGFyYWdyYXBocyBhdCB0aGUgdG9wIG9m
IHRoZSBmaWxlIGFyZQ0KaW1wbGVtZW50YXRpb24gY29tbWVudHMuIEFyZSB0aGVyZSBhbnkgb3Ro
ZXIgY29tbWVudHMgaW4gdGhlIGZpbGUsDQp3aGljaCBsb29rIGltcGxlbWVudGF0aW9uIGNvbW1l
bnRzIHRvIHlvdT8gVG8gbWUsIHRoZSByZXN0IGxvb2sgdGhlDQpkb2NzIGZvciBSdXN0IEFQSSB1
c2Vycy4NCg0KSSdtIG5vdCBzdXJlIHRoYXQgYSBjb21tZW50IG9uIHRoZSByZWxhdGlvbnNoaXAg
YmV0d2VlbiBDIGFuZCBSdXN0DQpzdHJ1Y3R1cmVzIGxpa2UgIldyYXBzIHRoZSBrZXJuZWwncyBg
c3RydWN0IHBoeV9kcml2ZXJgIiBpcyBBUEkgZG9jcw0KYnV0IHRoZSBpbi10cmVlIGZpbGVzIGxp
a2UgbXV0ZXgucnMgaGF2ZSB0aGUgc2ltaWxhciBzbyBJIGFzc3VtZSBpdCdzDQpmaW5lLg0KDQpX
aGVyZSB0aGUgaW1wbGVtZW50YXRpb24gY29tbWVudHMgYXJlIHN1cHBvc2VkIHRvIGJlIHBsYWNl
ZD8NCkRvY3VtZW50YXRpb24vbmV0d29ya2luZz8NCg==

