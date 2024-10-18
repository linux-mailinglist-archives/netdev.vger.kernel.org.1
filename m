Return-Path: <netdev+bounces-137030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA749A40E8
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 16:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40E83286CB6
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 14:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920E113C809;
	Fri, 18 Oct 2024 14:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggyHeKDJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949A020E30F;
	Fri, 18 Oct 2024 14:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729261025; cv=none; b=B2HslmaqUI2MAziwGJ+QFPIU0ZzLLnbUX2Q90XXLqhSHz8/EQxp/JBA5CbZE4KuspB+DTx5X/JI06Vv6iw/BV5nFOQOQRjlHSigcZSmJ96iu9CRX1+X63K9CEnoVD6ZvuSsxz11RJYEp2lV8Uw3Rt6ztE6JeIdbGOZqMlvRLL80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729261025; c=relaxed/simple;
	bh=oR9xmTxkylEPHCC9MbLjB0t38Ve7R17MGjSZ1Re/k6g=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rMH5Hn5OsU+CSlF/xxce5YdJyYlifQ2MUTch8LloFBymmjqEqbsM2S+vtEQ2OVCQkQRm20o/rwunMCC2oSm7FxGOtC47voF8pj5LeZy2s+esIYVuOfYeVYu08cV5geYGhCokTeUkA9wG5hhitKmIWkV87UhZmx9MpC77uIq8ZT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggyHeKDJ; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7db637d1e4eso2206972a12.2;
        Fri, 18 Oct 2024 07:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729261023; x=1729865823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oR9xmTxkylEPHCC9MbLjB0t38Ve7R17MGjSZ1Re/k6g=;
        b=ggyHeKDJlNJx4tvKUl3R4Xn2+wjzOTuMFV3DW7y8KpEUw0FwmZFfVsMNUGbLFx3qXP
         uUe4YZAWjNmVaX96ycleG3b1jvs3360rp1nSOljCGI10k5rkZxbDuSHmOePKmELyYhXv
         ETQmEE/5CC6OFuxP2MW5xbjNkFzQQN2xOLp/gqOg9MRXfHQaYrEwXiSnevs+UWAB45Nv
         S1d8ql9GRt8Owa57jAtI0ez8E2PZPMWtrqrgqcaGD8littze73KdZrY7R3hQJaqH0dWI
         zDDuvVASO1CNF45icBT/JarJelkD/Lm9jNnpQpZb4C45o0AJ0b8JCRjYjKDVAZNpb3sg
         r/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729261023; x=1729865823;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oR9xmTxkylEPHCC9MbLjB0t38Ve7R17MGjSZ1Re/k6g=;
        b=LJBnAwFmL9uiwKf5gM/NGV52WqSGH2h6KzC0EApZSrkzCB4Tw19Ng3H8mTp2cwSo9E
         PZKOxToZwKpoPsEEFckUP3YbfASlwTjbzZ0I6estm15xjoeH6yu96lqJfmaS0ffVtXev
         /ut+gC0orOn/dwAW+QaPSnj7/5aIlrzPvteTJK6w8q52h9xvpeaqWeVXMOl2HbDIfd7F
         Y0HH9e5GNypQAiapqB+QWUUcwJOAq5mBzEz/oikPklEZCgmdpNvsrwAdssiGUL6Yz0Dd
         9pv9aMfDtOvojZxZKJ46412EUcIU588ctyef9fKUwipT3yOPytm6Mw9Fuz0VoSPACGLi
         SU3g==
X-Forwarded-Encrypted: i=1; AJvYcCUBhZQzmnv3Qgf5XkbJmKolJcpYYe66aw6FCqV0/dDKqV+siS+k1wkC9nOPChWY96EbSKIURMAS@vger.kernel.org, AJvYcCXPujwf08g4ZrkZIdMEW3jJVYP2EvVPoHgwFczn9HliRn7riB7Cd92+uEZQQTQwHBv03rYu09lKjHVuCkJjVKU=@vger.kernel.org, AJvYcCXeR2dPveke5ERk4y8IVpqTQBkJRDYkgYj5vbfNMIiSrwGi5F79WmPAsWLSjXG+zZ9+iQsPus7ESarVDbI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb1p8lQqoeJoIRDew8ouCEtwEKNCZJL1619rbnHQH9BAOXRyUe
	dXlYLO0214zL7iSoI1+TU2tlqZA4lFMIaLtdH3EudSeMLtel2HXL
X-Google-Smtp-Source: AGHT+IHZUJLJWRob6mm6vfRcNrn6hBt9fdST09H7B6mFBIxhNjXdN3sZyfxWDpLbVPCCBOqr0uGeUA==
X-Received: by 2002:a05:6a21:4a4c:b0:1d8:d302:16a7 with SMTP id adf61e73a8af0-1d92c4baabfmr3699600637.3.1729261022542;
        Fri, 18 Oct 2024 07:17:02 -0700 (PDT)
Received: from localhost (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eacc29c87esm1379567a12.85.2024.10.18.07.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 07:17:02 -0700 (PDT)
Date: Fri, 18 Oct 2024 23:16:46 +0900 (JST)
Message-Id: <20241018.231646.1467186841447300225.fujita.tomonori@gmail.com>
To: aliceryhl@google.com
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, anna-maria@linutronix.de, frederic@kernel.org,
 tglx@linutronix.de, arnd@arndb.de, jstultz@google.com, sboyd@kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 7/8] rust: Add read_poll_timeout functions
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CAH5fLgg1G4++B+AoXrDc-QxiNL8T4zRV3ChbwN1LsG=urcMJmw@mail.gmail.com>
References: <20241016035214.2229-1-fujita.tomonori@gmail.com>
	<20241016035214.2229-8-fujita.tomonori@gmail.com>
	<CAH5fLgg1G4++B+AoXrDc-QxiNL8T4zRV3ChbwN1LsG=urcMJmw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64

T24gV2VkLCAxNiBPY3QgMjAyNCAxMDozNzo0NiArMDIwMA0KQWxpY2UgUnlobCA8YWxpY2VyeWhs
QGdvb2dsZS5jb20+IHdyb3RlOg0KDQo+IE9uIFdlZCwgT2N0IDE2LCAyMDI0IGF0IDU6NTTigK9B
TSBGVUpJVEEgVG9tb25vcmkNCj4gPGZ1aml0YS50b21vbm9yaUBnbWFpbC5jb20+IHdyb3RlOg0K
Pj4NCj4+IEFkZCByZWFkX3BvbGxfdGltZW91dCBmdW5jdGlvbnMgd2hpY2ggcG9sbCBwZXJpb2Rp
Y2FsbHkgdW50aWwgYQ0KPj4gY29uZGl0aW9uIGlzIG1ldCBvciBhIHRpbWVvdXQgaXMgcmVhY2hl
ZC4NCj4+DQo+PiBDJ3MgcmVhZF9wb2xsX3RpbWVvdXQgKGluY2x1ZGUvbGludXgvaW9wb2xsLmgp
IGlzIGEgY29tcGxpY2F0ZWQgbWFjcm8NCj4+IGFuZCBhIHNpbXBsZSB3cmFwcGVyIGZvciBSdXN0
IGRvZXNuJ3Qgd29yay4gU28gdGhpcyBpbXBsZW1lbnRzIHRoZQ0KPj4gc2FtZSBmdW5jdGlvbmFs
aXR5IGluIFJ1c3QuDQo+Pg0KPj4gVGhlIEMgdmVyc2lvbiB1c2VzIHVzbGVlcF9yYW5nZSgpIHdo
aWxlIHRoZSBSdXN0IHZlcnNpb24gdXNlcw0KPj4gZnNsZWVwKCksIHdoaWNoIHVzZXMgdGhlIGJl
c3Qgc2xlZXAgbWV0aG9kIHNvIGl0IHdvcmtzIHdpdGggc3BhbnMgdGhhdA0KPj4gdXNsZWVwX3Jh
bmdlKCkgZG9lc24ndCB3b3JrIG5pY2VseSB3aXRoLg0KPj4NCj4+IFVubGlrZSB0aGUgQyB2ZXJz
aW9uLCBfX21pZ2h0X3NsZWVwKCkgaXMgdXNlZCBpbnN0ZWFkIG9mIG1pZ2h0X3NsZWVwKCkNCj4+
IHRvIHNob3cgcHJvcGVyIGRlYnVnIGluZm87IHRoZSBmaWxlIG5hbWUgYW5kIGxpbmUNCj4+IG51
bWJlci4gbWlnaHRfcmVzY2hlZCgpIGNvdWxkIGJlIGFkZGVkIHRvIG1hdGNoIHdoYXQgdGhlIEMg
dmVyc2lvbg0KPj4gZG9lcyBidXQgdGhpcyBmdW5jdGlvbiB3b3JrcyB3aXRob3V0IGl0Lg0KPj4N
Cj4+IEZvciB0aGUgcHJvcGVyIGRlYnVnIGluZm8sIHJlYWR4X3BvbGxfdGltZW91dCgpIGlzIGlt
cGxlbWVudGVkIGFzIGENCj4+IG1hY3JvLg0KPj4NCj4+IHJlYWR4X3BvbGxfdGltZW91dCgpIGNh
biBvbmx5IGJlIHVzZWQgaW4gYSBub25hdG9taWMgY29udGV4dC4gVGhpcw0KPj4gcmVxdWlyZW1l
bnQgaXMgbm90IGNoZWNrZWQgYnkgdGhlc2UgYWJzdHJhY3Rpb25zLCBidXQgaXQgaXMNCj4+IGlu
dGVuZGVkIHRoYXQga2xpbnQgWzFdIG9yIGEgc2ltaWxhciB0b29sIHdpbGwgYmUgdXNlZCB0byBj
aGVjayBpdA0KPj4gaW4gdGhlIGZ1dHVyZS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBGVUpJVEEg
VG9tb25vcmkgPGZ1aml0YS50b21vbm9yaUBnbWFpbC5jb20+DQo+PiBMaW5rOiBodHRwczovL3J1
c3QtZm9yLWxpbnV4LmNvbS9rbGludCBbMV0NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBGVUpJVEEg
VG9tb25vcmkgPGZ1aml0YS50b21vbm9yaUBnbWFpbC5jb20+DQo+IA0KPiBEdXBsaWNhdGVkIFNP
Qj8gVGhpcyBzaG91bGQganVzdCBiZToNCj4gDQo+IExpbms6IGh0dHBzOi8vcnVzdC1mb3ItbGlu
dXguY29tL2tsaW50IFsxXQ0KPiBTaWduZWQtb2ZmLWJ5OiBGVUpJVEEgVG9tb25vcmkgPGZ1aml0
YS50b21vbm9yaUBnbWFpbC5jb20+DQoNCk9vcHMsIEknbGwgZml4Lg0KDQo+PiArLy8vIFBvbGxz
IHBlcmlvZGljYWxseSB1bnRpbCBhIGNvbmRpdGlvbiBpcyBtZXQgb3IgYSB0aW1lb3V0IGlzIHJl
YWNoZWQuDQo+PiArLy8vDQo+PiArLy8vIFB1YmxpYyBidXQgaGlkZGVuIHNpbmNlIGl0IHNob3Vs
ZCBvbmx5IGJlIHVzZWQgZnJvbSBwdWJsaWMgbWFjcm9zLg0KPj4gKyNbZG9jKGhpZGRlbildDQo+
PiArcHViIGZuIHJlYWRfcG9sbF90aW1lb3V0PE9wLCBDb25kLCBUOiBDb3B5PigNCj4+ICsgICAg
bXV0IG9wOiBPcCwNCj4+ICsgICAgY29uZDogQ29uZCwNCj4+ICsgICAgc2xlZXBfZGVsdGE6IERl
bHRhLA0KPj4gKyAgICB0aW1lb3V0X2RlbHRhOiBEZWx0YSwNCj4+ICsgICAgc2xlZXBfYmVmb3Jl
X3JlYWQ6IGJvb2wsDQo+PiArKSAtPiBSZXN1bHQ8VD4NCj4+ICt3aGVyZQ0KPj4gKyAgICBPcDog
Rm5NdXQoKSAtPiBSZXN1bHQ8VD4sDQo+PiArICAgIENvbmQ6IEZuKFQpIC0+IGJvb2wsDQo+PiAr
ew0KPj4gKyAgICBsZXQgdGltZW91dCA9IEt0aW1lOjprdGltZV9nZXQoKSArIHRpbWVvdXRfZGVs
dGE7DQo+PiArICAgIGxldCBzbGVlcCA9ICFzbGVlcF9kZWx0YS5pc196ZXJvKCk7DQo+PiArDQo+
PiArICAgIGlmIHNsZWVwX2JlZm9yZV9yZWFkICYmIHNsZWVwIHsNCj4+ICsgICAgICAgIGZzbGVl
cChzbGVlcF9kZWx0YSk7DQo+PiArICAgIH0NCj4gDQo+IFlvdSBhbHdheXMgcGFzcyBgZmFsc2Vg
IGZvciBgc2xlZXBfYmVmb3JlX3JlYWRgIHNvIHBlcmhhcHMganVzdCByZW1vdmUNCj4gdGhpcyBh
bmQgdGhlIGFyZ3VtZW50IGVudGlyZWx5Pw0KDQpNb3N0IG9mIHVzZXJzIG9mIEMncyB0aGlzIGZ1
bmN0aW9uIHVzZSBmYWxzZSBidWYgc29tZSB1c2UgdHJ1ZS4gSXQNCndvdWxkIGJlIGJldHRlciB0
byBwcm92aWRlIHRoaXMgb3B0aW9uPw0KDQpXb3VsZCBiZSBiZXR0ZXIgdG8gcHJvdmlkZSBvbmx5
IHJlYWRfcG9sbF90aW1lb3V0KCkgd2hpY2ggdGFrZXMgdGhlDQpzbGVlcF9iZWZvcmVfcmVhZCBh
cmd1bWVudD87IE5vIHJlYWR4X3BvbGxfdGltZW91dCB3cmFwcGVyLg0KDQo+PiArICAgICAgICBp
ZiBjb25kKHZhbCkgew0KPj4gKyAgICAgICAgICAgIGJyZWFrIHZhbDsNCj4+ICsgICAgICAgIH0N
Cj4gDQo+IFRoaXMgYnJlYWtzIG91dCB0byBhbm90aGVyIGNvbmQodmFsKSBjaGVjayBiZWxvdy4g
UGVyaGFwcyBqdXN0IGByZXR1cm4NCj4gT2sodmFsKWAgaGVyZSB0byBhdm9pZCB0aGUgZG91Ymxl
IGNvbmRpdGlvbiBjaGVjaz8NCg0KSSB0aGluayB0aGF0IHRoYXQncyBob3cgdGhlIEMgdmVyc2lv
biB3b3Jrcy4gQnV0IGByZXR1cm4gT2sodmFsKWAgaGVyZQ0KaXMgZmluZSwgSSBndWVzcy4NCg0K
Pj4gKyAgICAgICAgaWYgIXRpbWVvdXRfZGVsdGEuaXNfemVybygpICYmIEt0aW1lOjprdGltZV9n
ZXQoKSA+IHRpbWVvdXQgew0KPj4gKyAgICAgICAgICAgIGJyZWFrIG9wKCk/Ow0KPj4gKyAgICAg
ICAgfQ0KPiANCj4gU2hvdWxkbid0IHlvdSBqdXN0IHJldHVybiBgRXJyKEVUSU1FRE9VVClgIGhl
cmU/IEkgZG9uJ3QgdGhpbmsgeW91J3JlDQo+IHN1cHBvc2VkIHRvIGNhbGwgYG9wYCB0d2ljZSB3
aXRob3V0IGEgc2xlZXAgaW4gYmV0d2Vlbi4NCg0KSSB0aGluayB0aGF0IGl0J3MgaG93IHRoZSBD
IHZlcnNpb24gd29ya3MuDQoNCj4+ICsgICAgICAgIGlmIHNsZWVwIHsNCj4+ICsgICAgICAgICAg
ICBmc2xlZXAoc2xlZXBfZGVsdGEpOw0KPj4gKyAgICAgICAgfQ0KPj4gKyAgICAgICAgLy8gU0FG
RVRZOiBGRkkgY2FsbC4NCj4+ICsgICAgICAgIHVuc2FmZSB7IGJpbmRpbmdzOjpjcHVfcmVsYXgo
KSB9DQo+IA0KPiBTaG91bGQgY3B1X3JlbGF4KCkgYmUgaW4gYW4gZWxzZSBicmFuY2g/DQoNCkkg
dGhpbmsgdGhhdCB3ZSBjb3VsZC4gSSdsbCByZW1vdmUgaWYgeW91IHByZWZlci4gVGhlIEMgdmVy
c2lvbiBhbHdheXMNCmNhbGxzIGNwdV9yZWxheCgpLiBJIHRoaW5rIHRoYXQgdGhlIGZvbGxvd2lu
ZyBjb21taXQgZXhwbGFpbnMgd2h5Og0KDQpjb21taXQgYjQwNzQ2MGVlOTkwMzM1MDM5OTNhYzc0
MzdkNTkzNDUxZmNkZmU0NA0KQXV0aG9yOiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0K3JlbmVz
YXNAZ2xpZGVyLmJlPg0KRGF0ZTogICBGcmkgSnVuIDIgMTA6NTA6MzYgMjAyMyArMDIwMA0KDQog
ICAgaW9wb2xsOiBDYWxsIGNwdV9yZWxheCgpIGluIGJ1c3kgbG9vcHMNCg0KDQo+IEFsc28sIHBs
ZWFzZSBhZGQgYSBzYWZlIHdyYXBwZXIgZnVuY3Rpb24gYXJvdW5kIGNwdV9yZWxheC4NCg0KU3Vy
ZSwgd2hpY2ggZmlsZSBkbyB5b3UgdGhpbmsgaXMgYmVzdCB0byBhZGQgdGhlIHdyYXBwZXIgdG8/
DQoNCnJ1c3Qva2VybmVsL3Byb2Nlc3Nvci5ycw0KDQo/DQoNCj4+ICttYWNyb19ydWxlcyEgcmVh
ZHhfcG9sbF90aW1lb3V0IHsNCj4+ICsgICAgKCRvcDpleHByLCAkY29uZDpleHByLCAkc2xlZXBf
ZGVsdGE6ZXhwciwgJHRpbWVvdXRfZGVsdGE6ZXhwcikgPT4ge3sNCj4+ICsgICAgICAgICNbY2Zn
KENPTkZJR19ERUJVR19BVE9NSUNfU0xFRVApXQ0KPj4gKyAgICAgICAgaWYgISRzbGVlcF9kZWx0
YS5pc196ZXJvKCkgew0KPj4gKyAgICAgICAgICAgIC8vIFNBRkVUWTogRkZJIGNhbGwuDQo+PiAr
ICAgICAgICAgICAgdW5zYWZlIHsNCj4+ICsgICAgICAgICAgICAgICAgJGNyYXRlOjpiaW5kaW5n
czo6X19taWdodF9zbGVlcCgNCj4+ICsgICAgICAgICAgICAgICAgICAgIDo6Y29yZTo6ZmlsZSEo
KS5hc19wdHIoKSBhcyAqY29uc3QgaTgsDQo+PiArICAgICAgICAgICAgICAgICAgICA6OmNvcmU6
OmxpbmUhKCkgYXMgaTMyLA0KPj4gKyAgICAgICAgICAgICAgICApDQo+PiArICAgICAgICAgICAg
fQ0KPj4gKyAgICAgICAgfQ0KPiANCj4gSXQgY291bGQgYmUgbmljZSB0byBpbnRyb2R1Y2UgYSBt
aWdodF9zbGVlcCBtYWNybyB0aGF0IGRvZXMgdGhpcw0KPiBpbnRlcm5hbGx5PyBUaGVuIHdlIGNh
biByZXVzZSB0aGlzIGxvZ2ljIGluIG90aGVyIHBsYWNlcy4NCg0KSSB0aGluayB0aGF0IHdpdGgg
I1t0cmFja19jYWxsZXJdLCB3ZSBjYW4gdXNlIGEgbm9ybWFsIGZ1bmN0aW9uDQppbnN0ZWFkIG9m
IGEgbWFjcm8uDQoNClVzaW5nIG1pZ2h0X3NsZWVwIG5hbWUgZm9yIGEgd3JhcHBlciBvZiBfX21p
Z2h0X3NsZWVwIGlzIGNvbmZ1c2luZw0Kc2luY2UgdGhlIEMgc2lkZSBoYXMgYWxzbyBtaWdodF9z
bGVlcC4gX19mb28gZnVuY3Rpb24gbmFtZSBpcw0KYWNjZXB0YWJsZT8NCg==

