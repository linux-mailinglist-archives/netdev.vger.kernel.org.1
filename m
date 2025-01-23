Return-Path: <netdev+bounces-160447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A79BDA19C11
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 02:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E0231881688
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 01:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485CAAD2C;
	Thu, 23 Jan 2025 01:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qh1tv5tv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A381A28D;
	Thu, 23 Jan 2025 01:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737594263; cv=none; b=gc7iUYyQtVKTDw8DHBbHM6Rbt4A8Qrxklx9PUvs3/w6gquMcUqug8Lnmgvg1jdTMBsBAF6j7yDjFSGLnscgvCjZWHj5IOHWd8K5qt7GF4VJCrf8+ir2aLC/Qe4uRrczUhqKgqTfvvsugj+atKaUI2O0IP9ElrNwQAXMGk+8VyH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737594263; c=relaxed/simple;
	bh=/OYlylaUK/RZr8Em8bH96uxFv6KAO2ccmBlUbaHiAnM=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Dy5cborjrhldyS61EtfN9WG2b4DWvGiPeLWLLW44E5N6D9t7g/YVgU1sEHvpv56yto6fwF9j07uxyPEqeQvgot3dwUbFJXQdpA8KPlUhHyVVf53Gvt0XEa4iq4odZnpR9mV4yOSeQwgaop6fORnIWjjl6dz/balV+gzyoUX3guY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qh1tv5tv; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ee8aa26415so751951a91.1;
        Wed, 22 Jan 2025 17:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737594261; x=1738199061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/OYlylaUK/RZr8Em8bH96uxFv6KAO2ccmBlUbaHiAnM=;
        b=Qh1tv5tv/a2Y9BK6VS119GKLG01me2qSLDrW6a5L3a5Kuj8qg5n1PMQ4iSrWMF5/Fz
         I+Hd+OkUXmD6WJWYUiFSuD5OxgsJoaYvqHTX0S/CfacVoI5vZ7UOYqnhiCa1SudPjKcf
         GjF1bCOXt5uDvPHNyJGgwzBZcyPECiQnrDcSQeILhoB1XP0CY9Rsnodmss436y7AeBS9
         UQ4esLgyMM77zLDU5obqod9rki4lTck7IRhCFh2SguSyn0sZQa98bzP+9GymNnGmTr1K
         C0L8cvv5ye56WZA/5u5hDF6FPFJH6Vhg60Lv99bAAzFTi2oWM3WPGa2I+OIQRt2gseXj
         KsaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737594261; x=1738199061;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/OYlylaUK/RZr8Em8bH96uxFv6KAO2ccmBlUbaHiAnM=;
        b=f4DBMmylcH3JdsSA+PxnvRBXO3jsrR4w6qe2dPLZXgGTffS0Ziy7V1uLhAdZsGNe9R
         r3wy6fTIKTdvxT0+gleYMcbjBlblwkMgKlIiWPI00e5CEQerUJko4DvMRNTDHEX44mbA
         5Or8XZ0Qm64Qjr9UblvoegioRKhiwv+6Nc112lFV27U+4IqvioxkPormTeGofZinDJ6A
         PXtUnYkfMcx/5FbUwB3lsuLbMxOay09EYd3YGL744kO09sA2NPf4AgQK4x8ZrZiaqqar
         hfeHEULiaZ4aqzuTXuO12hi9EX7YZlnr+NlSVW8bNzzaTCfO/qJMZnbKIrDW7WV72bwG
         Nxbg==
X-Forwarded-Encrypted: i=1; AJvYcCUETqJVUodKiG5++BZe+Rpoyv32iPNXykaVjSaXunoDoLZWYHgaVmx1Gr+5udRHh/ZENjM6mBDa6rn4Heo=@vger.kernel.org, AJvYcCUWiu6UZYVdhQ5IHQzFGocT0+FBSEepovoFhqSKHCie7Zgm3mG1jJNuMEg3dekUKt8FqGlLi358@vger.kernel.org, AJvYcCVilqE5NhZaegmW8itg03y7TS3h9UIOZ3796PXeqEGd22/lOE5rD2HFeFtsZao2ij7UA4M4x7JvZDaAU36kGB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK4+QqleHRFXy8Za5oWedNShYiE+iTeU3Wgd5LeYOyTmgo973m
	8YdFaSjtIaELTTuQ6ksSfu3fYdVoO1l6IsCdVQngcv3ZUVqsi9Flu4wJ+G2M
X-Gm-Gg: ASbGncspjS4YaDvedHzfZwWvgRKEwa4iQ2YjR3sF6jdIc873aNW7lHjirn5AeU9RWcz
	plSN/kMuq4K+2nYMNQd4wL3IUjw+Fg/Ng1FrVcGEtMn85ECab3Sy1hYudRxMlgHOU/Wv3v5NjN/
	HSSRKlkcT+QjskAbQBoUZUzSBFcWbvLn8rB8xxaD0YPOsFizU+6nvtmNATGBHIVyc7r8lbYpa5Q
	Jab003jIt5ZSRY4QGudgPbd83zrrx/P142NiBPFMB3HFRyR381SoG0hLHGl/LR7paIi092wXUm/
	8oqUZrSpjWyzBedDYAFA/v/5KEHRUps/KnzQlNxzyQhXuXHAMzC/PTQZ72Qehg==
X-Google-Smtp-Source: AGHT+IHiDrHregsJ7T5LgEb+OVTEsKZqWD8raiOlQhcWlLYsLzMy3/7Npnhp71eZ0IRfBob2QLOBTQ==
X-Received: by 2002:a17:90b:2808:b0:2ee:d433:7c54 with SMTP id 98e67ed59e1d1-2f782cb61bemr33143312a91.19.1737594260849;
        Wed, 22 Jan 2025 17:04:20 -0800 (PST)
Received: from localhost (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7e6ad5baasm2662573a91.43.2025.01.22.17.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 17:04:20 -0800 (PST)
Date: Thu, 23 Jan 2025 10:04:11 +0900 (JST)
Message-Id: <20250123.100411.1402967329491755838.fujita.tomonori@gmail.com>
To: miguel.ojeda.sandonis@gmail.com
Cc: fujita.tomonori@gmail.com, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
 alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com,
 anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
 arnd@arndb.de, jstultz@google.com, sboyd@kernel.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com
Subject: Re: [PATCH v8 4/7] rust: time: Add wrapper for fsleep function
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CANiq72=xwhu21YJ+HEXhF1Uk_t1tuffphRgF4wAGiTc-JYcJVQ@mail.gmail.com>
References: <CANiq72kqu7U6CR30T5q=PvRam919eMTXNOfJHKXKJ0Z60U0=uw@mail.gmail.com>
	<20250122.155702.1385101290715452078.fujita.tomonori@gmail.com>
	<CANiq72=xwhu21YJ+HEXhF1Uk_t1tuffphRgF4wAGiTc-JYcJVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64

T24gV2VkLCAyMiBKYW4gMjAyNSAxMToyMTo1MSArMDEwMA0KTWlndWVsIE9qZWRhIDxtaWd1ZWwu
b2plZGEuc2FuZG9uaXNAZ21haWwuY29tPiB3cm90ZToNCg0KPiBOb3Qgc3VyZSBpZiB3ZSBzaG91
bGQgc2F5ICJFcXVpdmFsZW50IiBnaXZlbiBpdCBpcyBub3QgZXhhY3RseSB0aGUNCj4gc2FtZSwg
YnV0IEkgYW0gbm90IGEgbmF0aXZlIHNwZWFrZXI6IEkgdGhpbmsgaXQgZG9lcyBub3QgbmVjZXNz
YXJpbHkNCj4gbmVlZCB0byBiZSBleGFjdGx5IHRoZSBzYW1lIHRvIGJlICJlcXVpdmFsZW50Iiwg
YnV0IHBlcmhhcHMgIlNpbWlsYXINCj4gdG8iIG9yICJDb3VudGVycGFydCBvZiIgb3Igc29tZXRo
aW5nIGxpa2UgdGhhdCBpcyBiZXR0ZXIuDQoNCkknbSBub3QgYSBuYXRpdmUgc3BlYWtlciBlaXRo
ZXIsIGJ1dCBzZWVtcyB0aGF0ICJlcXVpdmFsZW50IiBjYW4gYmUNCnVzZWQgYXMgImZ1bmN0aW9u
YWxseSBlcXVpdmFsZW50Ii4gVGhlIG9mZmljaWFsIFJ1c3QgZG9jcyBhbHNvIHVzZQ0KImVxdWl2
YWxlbnQiIGluIHRoaXMgc2Vuc2UsICJFcXVpdmFsZW50IHRvIEOicyB1bnNpZ25lZCBjaGFyIHR5
cGUiDQoNCmh0dHBzOi8vZG9jLnJ1c3QtbGFuZy5vcmcvc3RkL29zL3Jhdy90eXBlLmNfdWNoYXIu
aHRtbA0KDQpUaGVyZSBhcmUgbWFueSBwbGFjZXMgd2hlcmUgImVxdWl2YWxlbnQiIGlzIHVzZWQg
aW4gdGhpcyBzZW5zZSBpbg0KcnVzdC9rZXJuZWwvLiBTZWVtcyB0aGF0IG9ubHkgcnVzdC9rZXJu
ZWwvYmxvY2svbXEucnMgdXNlcyBhIGRpZmZlcmVudA0Kd29yZCwgImNvdW50ZXJwYXJ0IiBpbiB0
aGlzIHNlbnNlLg0KDQpQb3NzaWJseSBhbm90aGVyICJnb29kIGZpcnN0IGlzc3VlIiB0byBtYWtl
IHRoaXMgZXhwcmVzc2lvbiBpbiB0aGUNCnRyZWUgY29uc2lzdGVudD8NCg0KPj4gQWgsIGl0IG1p
Z2h0IHdvcmsuIFRoZSBmb2xsb3dpbmcgZG9lc24ndCB3b3JrLiBTZWVtcyB0aGF0IHdlIG5lZWQg
dG8NCj4+IGFkZCBhbm90aGVyIGNvbnN0IGxpa2UgTUFYX0RFTFRBX05BTk9TIG9yIHNvbWV0aGlu
Zy4gTm8gc3Ryb25nDQo+PiBwcmVmZXJlbmNlIGJ1dCBJIGZlZWwgdGhlIGN1cnJlbnQgaXMgc2lt
cGxlci4NCj4+DQo+PiBsZXQgZGVsdGEgPSBtYXRjaCBkZWx0YS5hc19uYW5vcygpIHsNCj4+ICAg
ICAwLi49TUFYX0RFTFRBLmFzX25hbm9zKCkgYXMgaTMyID0+IGRlbHRhLA0KPj4gICAgIF8gPT4g
TUFYX0RFTFRBLA0KPj4gfTsNCj4gDQo+IFllYWgsIGRvbid0IHdvcnJ5IGFib3V0IGl0IHRvbyBt
dWNoIDopDQo+IA0KPiBbIFRoZSBsYW5ndWFnZSBtYXkgZ2V0IGBjb25zdCB7IC4uLiB9YCB0byB3
b3JrIHRoZXJlIChpdCBkb2VzIGluDQo+IG5pZ2h0bHkpIHRob3VnaCBpdCB3b3VsZG4ndCBsb29r
IGdvb2QgZWl0aGVyLiBJIHRoaW5rIHRoZSBgYXMgaTMyYA0KPiB3b3VsZCBub3QgYmUgbmVlZGVk
LiBdDQo+DQo+IEJ5IHRoZSB3YXksIHNwZWFraW5nIG9mIHNvbWV0aGluZyByZWxhdGVkLCBkbyB3
ZSB3YW50IHRvIG1ha2Ugc29tZSBvZg0KPiB0aGUgbWV0aG9kcyBgZm5gcyBiZSBgY29uc3RgPw0K
DQpZZWFoLiBBbGwgdGhlIGZyb21fKiBmdW5jdGlvbnMgYXJlIGFscmVhZHkgY29uc3QuIFNlZW1z
IHRoYXQgbWFraW5nDQphc18qIGZ1bmNhdGlvbnMgKGFzX25hbm9zLCBldGMpIGNvbnN0IHRvbyBt
YWtlIHNlbnNlLg0K

