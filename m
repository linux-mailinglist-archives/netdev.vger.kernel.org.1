Return-Path: <netdev+bounces-160201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92346A18CCF
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 08:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EC47188C243
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 07:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE69A1BBBE0;
	Wed, 22 Jan 2025 07:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWLUZQUC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6331607AC;
	Wed, 22 Jan 2025 07:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737531460; cv=none; b=GBw2Y0fYRXYjd+PlCeYHw0TAnwXOLfJmeCBExQ6vIwNsXay1ZUocuxoCc8Q1oKpbmC1X9lfHhdCrRk0Hrp//MuG8w+7CkrlGolItc0CG5jPUYZVcy+RMK+/GAiNQxdH2eyv/6eb/d1XSQJLnh45JuzZU14TyIzfsfVSS2SKaF7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737531460; c=relaxed/simple;
	bh=uUtSTT1O6VLpwciIFAYtD1cSR08ke5ukddj+oGPp1og=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ZwKtlfQlVUo10PqAiHsMRkUkNRdSdujH6LZ5FUFDZJ/15h0Mi4aIsp3IrVTo56a8U2Bq5wIqYs94bpx/lqTHQ40q77LsiTLohREvgIeoCKvRAX/Cud4T5jbaSnBxjNfzqEMC9LbStkQpqkfcL7OdgVeRVi18yxjyzcJ3ADE2X8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWLUZQUC; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2162c0f6a39so10524445ad.0;
        Tue, 21 Jan 2025 23:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737531458; x=1738136258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uUtSTT1O6VLpwciIFAYtD1cSR08ke5ukddj+oGPp1og=;
        b=IWLUZQUCk5/JxG4lP8zNbSrDnP6D2XNnNLEaMFpJMAxf869HvOml0VX84jmcXl40fy
         1D9ZhNzWCNAprdSBGayJTWSHDkg0fV2tcadZAwamYSRyZzFHPNn8ZPuzsvzAMGbpP6Xb
         YWuBZ3/JHAfXHzFK4PdCg65L1zAHQXVkRzpxPtvKe+oGw2L1ru9HkSNQmjWNFJzrZ2Or
         EvLDctpowHn1qMbPqLTzlFBIbH7vVjPSTWo86lMcDN5cnccGrmhzCr3QWq4HiiHaeMSt
         QsP67ZlcpedcqllJyJunhRArXMlJb6mHkFhoiIx+SZvjXricTs7Mh0C+Dl6e/z/V+OZl
         Ny7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737531458; x=1738136258;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uUtSTT1O6VLpwciIFAYtD1cSR08ke5ukddj+oGPp1og=;
        b=vTYqbbsTmCRbWuQcu9DE0udvhXYM+nFtxy+g0FwzgPUhvAVah7BLsXbbN6sqv6DpU9
         J1eHGEr/orAb5UV8CCYSccDs6tjjLCs3XKMIsA+Ujw4c4MZ019yW+qiZ91nD8fe3JS9M
         NTpi4zqFQedF7dfNVE1w3fvZaYQ7OMv9iA984HhhzgHcYqHcacVD3NX7emhppAzx8IEt
         3Q1D8iile306Uukt+DHlX2IUTshhc90KpnRsKbIN9SDZQnRM+v5mAGhgje5IOG7FfYPn
         9tj0OIDUUaeF76ykhSpU1qGufEeukwyZj5bndJxXHf/cqi8nHdX7bJZi4B6lxo4g27Qw
         Y48w==
X-Forwarded-Encrypted: i=1; AJvYcCUAB6Buohv5h+gpoFQP10KrdPKcTOAgY4IW+luSZKisd4MFa6R66O7lG/Lusq4HweLeYMhtsMuoQo4Un5718BE=@vger.kernel.org, AJvYcCVJBAC59EizSumzUVPM2K+zlU/SKgWaDK0WR6h/LjWzyhnff0N6AIX5sq33/Ly7Tazna8loxR3o@vger.kernel.org, AJvYcCVeWv00C97OBB3vJ4FniF3x1W0k0UKOrXrDguOtD3RXqP0d8H/MsrtD1QgaNc19ew18PVRV9juZuwBrSMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YywKHqfZREs6YqTCKDiweD0YAxY2g5lOe7J6p5GBRN4rNYQMXqr
	CI1m9RauwpZuwUBdXaCB4py9Ms4NQ+nLgjJwbTfxh10/jcGAn6Si
X-Gm-Gg: ASbGncur27PKljgn7oEKihTjAPOb/CGcXiKLzFfNRlrbQYN2OSz5aAkAP3diiGxYokN
	SyhVPnZ/vyle8VLkmDn3qsL5M0ZdY3i7u6rTx2zZhBnpKMpouPSjcAJxgoOKBi7oba9qe9LhRfH
	FSlZ7A+9hodOvpc0WlR7DGUSU6uBgemI8ZXV5Isih7RxlXTRE7BUpnwvdX/qOTSsX/JUR7in05L
	I1C2+ofJu82K6M4tUwGREgAAhjlep03vXBTk+QmwEfICrRyUdsY9CdHEnasxg1cfv7nS/u34/kC
	601HhIV12rYRlLGHH/8lBjuWf6eNwjmBuxUZHJjNsFEplAhEFb0=
X-Google-Smtp-Source: AGHT+IEyRlyoh4SAvJhKVSEaPfl56J5inRqB/j9tgz2Sh8InIff21e8SzTfeEZHe9sNOWNwzcZhGqg==
X-Received: by 2002:a17:903:1ca:b0:216:14fb:d277 with SMTP id d9443c01a7336-21bf0ce1088mr403539165ad.22.1737531458247;
        Tue, 21 Jan 2025 23:37:38 -0800 (PST)
Received: from localhost (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d403e2fsm89217455ad.240.2025.01.21.23.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 23:37:37 -0800 (PST)
Date: Wed, 22 Jan 2025 16:37:28 +0900 (JST)
Message-Id: <20250122.163728.1738626154854951916.fujita.tomonori@gmail.com>
To: miguel.ojeda.sandonis@gmail.com
Cc: fujita.tomonori@gmail.com, linux-kernel@vger.kernel.org,
 andrew@lunn.ch, rust-for-linux@vger.kernel.org, netdev@vger.kernel.org,
 hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
 alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com,
 anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
 arnd@arndb.de, jstultz@google.com, sboyd@kernel.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com
Subject: Re: [PATCH v8 2/7] rust: time: Introduce Delta type
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CANiq72=kuZcLCgsSkKa6MrYCJY9UsWSV9VLvj2TcVOQEf0Cnmg@mail.gmail.com>
References: <20250116044100.80679-1-fujita.tomonori@gmail.com>
	<20250116044100.80679-3-fujita.tomonori@gmail.com>
	<CANiq72=kuZcLCgsSkKa6MrYCJY9UsWSV9VLvj2TcVOQEf0Cnmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64

T24gU2F0LCAxOCBKYW4gMjAyNSAxMzoxOToyMSArMDEwMA0KTWlndWVsIE9qZWRhIDxtaWd1ZWwu
b2plZGEuc2FuZG9uaXNAZ21haWwuY29tPiB3cm90ZToNCg0KPiBTaW5jZSB5b3Ugc3RhcnRlZCBn
ZXR0aW5nIFJldmlld2VkLWJ5cywgSSBkb24ndCB3YW50IHRvIGRlbGF5IHRoaXMNCj4gbW9yZSAo
cHVuIHVuaW50ZW5kZWQgOiksIGJ1dCBhIGNvdXBsZSBxdWljayBub3Rlcy4uLg0KPiANCj4gSSBj
YW4gY3JlYXRlICJnb29kIGZpcnN0IGlzc3VlcyIgZm9yIHRoZXNlIGluIG91ciB0cmFja2VyIGlm
IHlvdQ0KPiBwcmVmZXIsIHNpbmNlIHRoZXNlIHNob3VsZCBiZSBlYXN5IGFuZCBjYW4gYmUgZG9u
ZSBsYXRlciAoZXZlbiBpZiwgaW4NCj4gZ2VuZXJhbCwgSSB0aGluayB3ZSBzaG91bGQgcmVxdWly
ZSBleGFtcGxlcyBhbmQgZ29vZCBkb2NzIGZvciBuZXcNCj4gYWJzdHJhY3Rpb25zKS4NCg0KWWVz
LCBwbGVhc2UgY3JlYXRlIHN1Y2guIEknbGwgYWRkIG1vcmUgZG9jcyBidXQgSSdtIHN1cmUgdGhh
dCB0aGVyZQ0Kd2lsbCBiZSByb29tIGZvciBpbXByb3ZlbWVudC4NCg0KPiBPbiBUaHUsIEphbiAx
NiwgMjAyNSBhdCA1OjQy4oCvQU0gRlVKSVRBIFRvbW9ub3JpDQo+IDxmdWppdGEudG9tb25vcmlA
Z21haWwuY29tPiB3cm90ZToNCj4+DQo+PiBpNjQgaXMgdXNlZCBpbnN0ZWFkIG9mIGJpbmRpbmdz
OjprdGltZV90IGJlY2F1c2Ugd2hlbiB0aGUga3RpbWVfdA0KPj4gdHlwZSBpcyB1c2VkIGFzIHRp
bWVzdGFtcCwgaXQgcmVwcmVzZW50cyB2YWx1ZXMgZnJvbSAwIHRvDQo+PiBLVElNRV9NQVgsIHdo
aWNoIGRpZmZlcmVudCBmcm9tIERlbHRhLg0KPiANCj4gVHlwbzogImlzIGRpZmZlcmVudCAuLi4i
Pw0KDQpPb3BzLCB3aWxsIGZpeC4NCg0KPj4gRGVsdGE6OmZyb21fW21pbGxpc3xzZWNzXSBBUElz
IHRha2UgaTY0LiBXaGVuIGEgc3BhbiBvZiB0aW1lDQo+PiBvdmVyZmxvd3MsIGk2NDo6TUFYIGlz
IHVzZWQuDQo+DQo+IFRoaXMgYmVoYXZpb3Igc2hvdWxkIGJlIHBhcnQgb2YgdGhlIGRvY3Mgb2Yg
dGhlIG1ldGhvZHMgYmVsb3cuDQoNCllvdSB3YW50IHRvIGFkZCB0aGUgYWJvdmUgZXhwbGFuYXRp
b24gdG8gYWxsIHRoZQ0KRGVsdGE6OmZyb21fW21pbGxpc3xtaWNyb3xzZWNzXSwgcmlnaHQ/DQoN
Cj4+ICsvLy8gQSBzcGFuIG9mIHRpbWUuDQo+PiArI1tkZXJpdmUoQ29weSwgQ2xvbmUsIFBhcnRp
YWxFcSwgUGFydGlhbE9yZCwgRXEsIE9yZCwgRGVidWcpXQ0KPj4gK3B1YiBzdHJ1Y3QgRGVsdGEg
ew0KPj4gKyAgICBuYW5vczogaTY0LA0KPj4gK30NCj4gDQo+IFNvbWUgbW9yZSBkb2NzIGhlcmUg
aW4gYERlbHRhYCB3b3VsZCBiZSBnb29kLCBlLmcuIHNvbWUgcXVlc3Rpb25zDQo+IHJlYWRlcnMg
bWF5IGhhdmUgY291bGQgYmU6IFdoYXQgcmFuZ2Ugb2YgdmFsdWVzIGNhbiBpdCBob2xkPyBDYW4g
dGhleQ0KPiBiZSBuZWdhdGl2ZT8NCg0KT2theSwgSSdsbCBhZGQuDQoNCj4gQWxzbyBzb21lIG1v
ZHVsZS1sZXZlbCBkb2NzIHdvdWxkIGJlIG5pY2UgcmVsYXRpbmcgYWxsIHRoZSB0eXBlcyAoeW91
DQo+IG1lbnRpb24gc29tZSBvZiB0aGF0IGluIHRoZSBjb21taXQgbWVzc2FnZSBmb3IgYEluc3Rh
bnRgLCBidXQgaXQgd291bGQNCj4gYmUgbmljZSB0byBwdXQgaXQgYXMgZG9jcywgcmF0aGVyIHRo
YW4gaW4gdGhlIGNvbW1pdCBtZXNzYWdlKS4NCg0KSXMgdGhlcmUgYW55IGV4aXN0aW5nIHNvdXJj
ZSBjb2RlIEkgY2FuIHJlZmVyIHRvPyBJJ20gbm90IHN1cmUNCmhvdyAibW9kdWxlLWxldmVsIGRv
Y3MiIHNob3VsZCBiZSB3cml0dGVuLg0KDQo+PiArICAgIC8vLyBDcmVhdGUgYSBuZXcgYERlbHRh
YCBmcm9tIGEgbnVtYmVyIG9mIG1pY3Jvc2Vjb25kcy4NCj4+ICsgICAgI1tpbmxpbmVdDQo+PiAr
ICAgIHB1YiBjb25zdCBmbiBmcm9tX21pY3JvcyhtaWNyb3M6IGk2NCkgLT4gU2VsZiB7DQo+PiAr
ICAgICAgICBTZWxmIHsNCj4+ICsgICAgICAgICAgICBuYW5vczogbWljcm9zLnNhdHVyYXRpbmdf
bXVsKE5TRUNfUEVSX1VTRUMpLA0KPj4gKyAgICAgICAgfQ0KPj4gKyAgICB9DQo+IA0KPiBGb3Ig
ZWFjaCBvZiB0aGVzZSwgSSB3b3VsZCBtZW50aW9uIHRoYXQgdGhleSBzYXR1cmF0ZSBhbmQgSSB3
b3VsZA0KPiBtZW50aW9uIHRoZSByYW5nZSBvZiBpbnB1dCB2YWx1ZXMgdGhhdCB3b3VsZCBiZSBr
ZXB0IGFzLWlzIHdpdGhvdXQNCj4gbG9zcy4NCj4gDQo+IEFuZCBpdCB3b3VsZCBiZSBuaWNlIHRv
IGFkZCBzb21lIGV4YW1wbGVzLCB3aGljaCB5b3UgY2FuIHRha2UgdGhlDQo+IGNoYW5jZSB0byBz
aG93IGhvdyBpdCBzYXR1cmF0ZXMsIGFuZCB0aGV5IHdvdWxkIGRvdWJsZSBhcyB0ZXN0cywgdG9v
Lg0KDQpJJ2xsIHRyeSB0byBpbXByb3ZlLg0K

