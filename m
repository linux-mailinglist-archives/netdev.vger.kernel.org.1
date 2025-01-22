Return-Path: <netdev+bounces-160298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFBCA192DF
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 14:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A1023ACA6E
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 13:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8641E21322C;
	Wed, 22 Jan 2025 13:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfyUHoG/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E17212F98;
	Wed, 22 Jan 2025 13:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737553607; cv=none; b=SUc4zxXt/c9GNmnFc8ZwMFQyy2ohL0+R+a41IH2ufbpoa8xcNxF/QD9rCG0jY1WvAzggfiEmWki5TN1Z8M7/mL6bvj6ff4VNZTkg584FLGoM4T4wW8rehoW4m5te3GNm1nLrOah7wrOn0GyPo5WRY6Vs7ujt0N+ztH7x/ULXFXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737553607; c=relaxed/simple;
	bh=1BW1e45kiLlnm2nJRhGoE/QpLBlikGScXvdTACXGzJA=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=nZ5bRXMVNPh9F59TrLF7r5fhGxGJ+7PHZn88KtFo5WOJikcV6iPwAPvWivnXmlZ5X9uCjpdHm4N66NJy/m6i4l4dBmTwcqsv0ayfqUlEJQ9o6g+mTbOkfkKyhK45FG3uK5kAV/SrSUaDHqEwmmdi8QQnYsISdEIokrQI+y792cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NfyUHoG/; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2161eb94cceso87127435ad.2;
        Wed, 22 Jan 2025 05:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737553605; x=1738158405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1BW1e45kiLlnm2nJRhGoE/QpLBlikGScXvdTACXGzJA=;
        b=NfyUHoG/2Pt8Bv0YNcxV1+j9BtWnDxUHHlK0FcZEaxS3NAQwE7m9o54DoJHbH+l0WI
         hisZ/1Qu31WY/3PhQevH8DWE30j5j6uAEANCnEtwMfWizDegvThYtCSoZsIqH5yia9uQ
         uoEp2P9PyZlXfeGt3vUqFJQXwCbsNVoBsNwq0QMwDFd+35xgR80UZ6ckwQC1s39xra6+
         snF1b7GiohGS43J0JOjunAyj282SWNJpVsXJSeF2R5VUc9PXJXnGUvVt7hM8NHpzvbJM
         9YIYKx563CQto6Mz0NII3Feph5jsvWkFAux1VTwlXh3dk094S2dLZVKUDxdzvGUc21ES
         kSHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737553605; x=1738158405;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1BW1e45kiLlnm2nJRhGoE/QpLBlikGScXvdTACXGzJA=;
        b=aawyyM3K+N0DUQqa18kEUHtLeHuX8I5jNtFdbanqVXMYxPVS8E4mW1X6pce/HbnWR5
         3a1zcyCVvyTTxo4Wjeg9LIiZQrh4xRHvCV0dWuCjdWX2zyp8bOoko/r6IPdx8OzOMbUA
         ZpKUxgkSNXZwtSAgNBEaRRnn/eKSAxY3tkxW/NEqrRV5TShxhwmDL+T7n+JpWxPZBytE
         i3caxbsy+5zHalEwZl5xJ0wWCikztcTnCdneyvrTz5FerjyCmjj0poJSwgsCYAoUDgjm
         qTeeR3mXaC6LQrbh4xies2fYmIn7SOcQhmT5GS0siMS+YeyrYV3i74g8fowP6/GgGgzj
         5KFQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5ZUL6g/6zoor+D2chrJmEnr+JJ8HrK61i9cHP+MDMWGxRB8L85RrQk81bCkn1Ygylr+rwFpn6@vger.kernel.org, AJvYcCUeAIS9j+X3/YvT9uH+Ja51YgmExd2d/BNYsUNbKYep7ZT+LIftaKDpxNDbdy0MU5IfGAjJWoLQhy3oWP/EL24=@vger.kernel.org, AJvYcCWu0BDEw0IFOQ9axZmW2ydqujnz2+prCCf/3rx42SY0oT0DQxMx2qiRSQi3/En+BCP7Xoz//y8ErJ8y4ms=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFnIvALu3ED8CmsYu7dS48zRaQ62icwqEhTdIslaP8GR2s8RK9
	HNd+Z8ercbGONdyI/FTzNX9YwCexsabjwxW3ASh7k7zZ+r8dYfFx
X-Gm-Gg: ASbGncuD9Dp7Jd7ICk7aFi/sw9ZKPPJ6XVcQ4AoxELElxbBlpSuG8mRmVb2fdDuD42U
	oKq6sgx92RFZxQwS8C/w+WajCYsVPNxgWtisPv+/hLaNL5sdRU3BNhkrWo56T4yfYmlR47I/IKJ
	7KYD/8r3uKy/v5dHNJpbVHSDIlotWO3C2RtRMiuYqBgFI5hZhGE88/m38Ijvsif8bTz09ckbYFI
	xkvIPTET7B/67K61IZxR4s7ljC87fy6rqRdZNi82XUwc/E+gxPvBNdhVDbRIFdc6EgMFS/Sb6MQ
	ZguNZm3wUcd8JGLvVIXhFmoFeTuQvXzcPJaiVzY/eCRw5WnZHhU=
X-Google-Smtp-Source: AGHT+IE1Hp+cf17IzNMDkWb5vJslmSRT2LDfaddC9tY/dYlXywwF10hkgf4XwTnX58Tk/K2UUra2AA==
X-Received: by 2002:a17:902:d583:b0:215:4d90:4caf with SMTP id d9443c01a7336-21c353e700fmr353047635ad.14.1737553605134;
        Wed, 22 Jan 2025 05:46:45 -0800 (PST)
Received: from localhost (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2cebaebcsm96177155ad.99.2025.01.22.05.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 05:46:44 -0800 (PST)
Date: Wed, 22 Jan 2025 22:46:35 +0900 (JST)
Message-Id: <20250122.224635.1710391280729820874.fujita.tomonori@gmail.com>
To: aliceryhl@google.com
Cc: fujita.tomonori@gmail.com, linux-kernel@vger.kernel.org,
 boqun.feng@gmail.com, rust-for-linux@vger.kernel.org,
 netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, anna-maria@linutronix.de, frederic@kernel.org,
 tglx@linutronix.de, arnd@arndb.de, jstultz@google.com, sboyd@kernel.org,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com
Subject: Re: [PATCH v8 3/7] rust: time: Introduce Instant type
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CAH5fLgipKcAk55r-KCYTh4JTooGhAv42kUU_L46=g-tUSo5n+A@mail.gmail.com>
References: <20250116.210644.2053799984954195907.fujita.tomonori@gmail.com>
	<20250122.214920.2057812400114439393.fujita.tomonori@gmail.com>
	<CAH5fLgipKcAk55r-KCYTh4JTooGhAv42kUU_L46=g-tUSo5n+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64

T24gV2VkLCAyMiBKYW4gMjAyNSAxMzo1MToyMSArMDEwMA0KQWxpY2UgUnlobCA8YWxpY2VyeWhs
QGdvb2dsZS5jb20+IHdyb3RlOg0KDQo+IE9uIFdlZCwgSmFuIDIyLCAyMDI1IGF0IDE6NDnigK9Q
TSBGVUpJVEEgVG9tb25vcmkNCj4gPGZ1aml0YS50b21vbm9yaUBnbWFpbC5jb20+IHdyb3RlOg0K
Pj4NCj4+IE9uIFRodSwgMTYgSmFuIDIwMjUgMjE6MDY6NDQgKzA5MDAgKEpTVCkNCj4+IEZVSklU
QSBUb21vbm9yaSA8ZnVqaXRhLnRvbW9ub3JpQGdtYWlsLmNvbT4gd3JvdGU6DQo+Pg0KPj4gPiBP
biBUaHUsIDE2IEphbiAyMDI1IDEwOjMyOjQ1ICswMTAwDQo+PiA+IEFsaWNlIFJ5aGwgPGFsaWNl
cnlobEBnb29nbGUuY29tPiB3cm90ZToNCj4+ID4NCj4+ID4+PiAtaW1wbCBLdGltZSB7DQo+PiA+
Pj4gLSAgICAvLy8gQ3JlYXRlIGEgYEt0aW1lYCBmcm9tIGEgcmF3IGBrdGltZV90YC4NCj4+ID4+
PiAraW1wbCBJbnN0YW50IHsNCj4+ID4+PiArICAgIC8vLyBDcmVhdGUgYSBgSW5zdGFudGAgZnJv
bSBhIHJhdyBga3RpbWVfdGAuDQo+PiA+Pj4gICAgICAjW2lubGluZV0NCj4+ID4+PiAtICAgIHB1
YiBmbiBmcm9tX3Jhdyhpbm5lcjogYmluZGluZ3M6Omt0aW1lX3QpIC0+IFNlbGYgew0KPj4gPj4+
ICsgICAgZm4gZnJvbV9yYXcoaW5uZXI6IGJpbmRpbmdzOjprdGltZV90KSAtPiBTZWxmIHsNCj4+
ID4+PiAgICAgICAgICBTZWxmIHsgaW5uZXIgfQ0KPj4gPj4+ICAgICAgfQ0KPj4gPj4NCj4+ID4+
IFBsZWFzZSBrZWVwIHRoaXMgZnVuY3Rpb24gcHVibGljLg0KPj4gPg0KPj4gPiBTdXJlbHksIHlv
dXIgZHJpdmVyIHVzZXMgZnJvbV9yYXcoKT8NCj4+DQo+PiBJIGNoZWNrZWQgb3V0IHRoZSBDIHZl
cnNpb24gb2YgQmluZGVyIGRyaXZlciBhbmQgaXQgZG9lc24ndCBzZWVtIGxpa2UNCj4+IHRoZSBk
cml2ZXIgbmVlZHMgZnJvbV9yYXcgZnVuY3Rpb24uIFRoZSBSdXN0IHZlcnNpb24gWzFdIGFsc28g
ZG9lc24ndA0KPj4gc2VlbSB0byBuZWVkIHRoZSBmdW5jdGlvbi4gRG8geW91IGhhdmUgYSBkaWZm
ZXJlbnQgdXNlIGNhc2U/DQo+IA0KPiBOb3QgZm9yIHRoaXMgcGFydGljdWxhciBmdW5jdGlvbiwg
YnV0IEkndmUgY2hhbmdlZCBmdW5jdGlvbnMgY2FsbGVkDQo+IGZyb21fcmF3IGFuZCBzaW1pbGFy
IGZyb20gcHJpdmF0ZSB0byBwdWJsaWMgc28gbWFueSB0aW1lcyBhdCB0aGlzDQo+IHBvaW50IHRo
YXQgSSB0aGluayBpdCBzaG91bGQgYmUgdGhlIGRlZmF1bHQuDQoNClRoZW4gY2FuIHdlIHJlbW92
ZSBmcm9tX3JhdygpPw0KDQpXZSBkb24ndCB1c2UgSW5zdGFudCB0byByZXByZXNlbnQgYm90aCBh
IHNwZWNpZmljIHBvaW50IGluIHRpbWUgYW5kIGENCnNwYW4gb2YgdGltZSAod2UgYWRkIERlbHRh
KSBzbyBhIGRldmljZSBkcml2ZXIgZG9uJ3QgbmVlZCB0byBjcmVhdGUgYW4NCkluc3RhbnQgZnJv
bSBhbiBhcmJpdHJhcnkgdmFsdWUsIEkgdGhpbmsuDQoNCklmIHdlIGFsbG93IGEgZGV2aWNlIGRy
aXZlciB0byBjcmVhdGUgSW5zdGFudCB2aWEgZnJvbV9yYXcoKSwgd2UgbmVlZA0KdG8gdmFsaWRh
dGUgYSB2YWx1ZSBmcm9tIHRoZSBkcml2ZXIuIElmIHdlIGNyZWF0ZSBrdGltZV90IG9ubHkgdmlh
DQprdGltZV9nZXQoKSwgd2UgZG9uJ3QgbmVlZCB0aGUgZGV0YWlscyBvZiBrdGltZSBsaWtlIGEg
dmFsaWQgcmFuZ2Ugb2YNCmt0aW1lX3QuDQo=

