Return-Path: <netdev+bounces-136888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D43DC9A380F
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 10:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 057861C23D1F
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 08:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1D418BC19;
	Fri, 18 Oct 2024 08:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkH9dKdI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD23113C816;
	Fri, 18 Oct 2024 08:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729239045; cv=none; b=FjbQz5Rjn+QaMC/yCHrRRD63CUUAr0xPbgKOkAaLbE8siZA4DJH0WTMMov20dZyJKdHZSSL+UqcMcYqFMY9IoW74i2sHxDQqUJmSFMB1GMZtnyLSAs2ykQvkv1tkoPKkBvjsy8BVSlmXvoKFQ+s6TORclHSV/ftJa8X4vYV/O98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729239045; c=relaxed/simple;
	bh=jFx+4sXbfKLfEf5jUr6CTrNp/WjeF8W4rkXKB4Fgn9k=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=uTjQfcaSNfb0JbNMH5dERHWR9yw/eVDgDqjf/gF1cdvoOtImO4EuAVDYUfGLdir88RkFq7TuyDx6iHtqcT9Q0SiIny+KWdn3rSb1OYwf/yvPA9F7kGYS6XFMWfoMOdd1u5RHqsUSXn9bcfONUi/d8XON3mgo/83eB96DEftCPtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QkH9dKdI; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7e6cbf6cd1dso1259507a12.3;
        Fri, 18 Oct 2024 01:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729239043; x=1729843843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jFx+4sXbfKLfEf5jUr6CTrNp/WjeF8W4rkXKB4Fgn9k=;
        b=QkH9dKdIuXYNID59WwMOm45SOVpsHFogRY3LWpG3jmbdHs0P4PV/SSTBfSRyem8251
         R0/OlIQwtWmiDzhr/sJLr2A8DyKVGPe7G7etMjWkKSyHKLeDe4royR4XOTBW/T+h2wN0
         xq5TYHsjSVGh/WLYOKEEsPq6cF2PQ//BWIoE62wYQR47rHhS+FoCrRDfYDQzcIxWPDAV
         AXUkGqd8Xv4TPSvlryXsMpTNnG2w4pYTKb+iOkNKpO9RYlGMrfrEy25JQleSXcGFRS5Q
         6WsqL0p18MxdZM3gnCG2cBkKw4hersHKL8j5Cdf08b/Rg7pcvRZkQMv2RYqOdcVZOOQR
         K7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729239043; x=1729843843;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jFx+4sXbfKLfEf5jUr6CTrNp/WjeF8W4rkXKB4Fgn9k=;
        b=Btnp9tr/ksSVlyEUcN1yB4UUVcs26GGfRQ5MTUFjJzJnAUZQLUbTLVmce8ZlysPF/F
         6Psb7qXahIroORJ2w+lRuzFBJQ59wWQyPBafeQgI+WOaQjT6gsmPLEH76jBcQ1SLfgv0
         lpPGYi1sqcx4SmdGH3a/KAtcF9Xp/+TRKsxaExZs66tSsONEuLNR9/1L4ywIrNSNVUGV
         z1jSr6Egb7Tuv1s/RlxXhK7+TICzNxJbcrM/AnZjGmMJblG77iy9POnnZ6lepC52tGYY
         CIFPqMdEYaFP+CzO84dn512tzhTBfTtBvzOlXWMyVg0fP5TnO+WzwEddNLC1BSmI7uKx
         qsOA==
X-Forwarded-Encrypted: i=1; AJvYcCVU8r94IG9H3mlYL1pLg8u/inXooKEVZxKg3Aw9To9oJqo/HNTmGUadhIuURpy2Rmdxthj8RL87rEMmKJmbWfs=@vger.kernel.org, AJvYcCVUBnhNnP8fbMF9224HnCdd4XKzDMVztYp4vPlroSnRBD00CKEek4oBa5QTSuADFBx+tpgO9pMK/1DXVTk=@vger.kernel.org, AJvYcCVd/2vHf/cJa/GHIB1/J+XwqVA9AfkxmJuO8N7WRgFXm6fq5in7XYK34arpFIF/GBKcEk4xqpFd@vger.kernel.org
X-Gm-Message-State: AOJu0YyCSj3hCZBTAe26BLx7jgXB6JtVkKAhpm8ak/XftJYA/o4Y/i72
	fp9uq3CeUOVljwbQfpALU/q3pR+8IDqAcUKyxQIan6NLcM4KYJH/
X-Google-Smtp-Source: AGHT+IH7xoRms+6Tltqg2iX0ul7+ix1lcywauF5CQ6oD+OyxG8ms7RT16MNRAqegQ26LiB590c0uKQ==
X-Received: by 2002:a05:6a21:710a:b0:1d8:b0f5:d887 with SMTP id adf61e73a8af0-1d92c4bac46mr2131330637.2.1729239043042;
        Fri, 18 Oct 2024 01:10:43 -0700 (PDT)
Received: from localhost (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ea333be59sm895472b3a.61.2024.10.18.01.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 01:10:42 -0700 (PDT)
Date: Fri, 18 Oct 2024 17:10:26 +0900 (JST)
Message-Id: <20241018.171026.271950414623402396.fujita.tomonori@gmail.com>
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
In-Reply-To: <CAH5fLgi0dN+hkTb0a29XWaGO1xsmyyJMAQyFJDH+geWZwsfAHw@mail.gmail.com>
References: <20241016035214.2229-8-fujita.tomonori@gmail.com>
	<CAH5fLgjk5koTwMOcdsnQjTVWQehjCDPoD2M3KboGZsxigKdMfA@mail.gmail.com>
	<CAH5fLgi0dN+hkTb0a29XWaGO1xsmyyJMAQyFJDH+geWZwsfAHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64

T24gV2VkLCAxNiBPY3QgMjAyNCAxMDo1MjoxNyArMDIwMA0KQWxpY2UgUnlobCA8YWxpY2VyeWhs
QGdvb2dsZS5jb20+IHdyb3RlOg0KDQo+IE9uIFdlZCwgT2N0IDE2LCAyMDI0IGF0IDEwOjQ14oCv
QU0gQWxpY2UgUnlobCA8YWxpY2VyeWhsQGdvb2dsZS5jb20+IHdyb3RlOg0KPj4NCj4+IE9uIFdl
ZCwgT2N0IDE2LCAyMDI0IGF0IDU6NTTigK9BTSBGVUpJVEEgVG9tb25vcmkNCj4+IDxmdWppdGEu
dG9tb25vcmlAZ21haWwuY29tPiB3cm90ZToNCj4+ID4gKy8vLyBQb2xscyBwZXJpb2RpY2FsbHkg
dW50aWwgYSBjb25kaXRpb24gaXMgbWV0IG9yIGEgdGltZW91dCBpcyByZWFjaGVkLg0KPj4gPiAr
Ly8vDQo+PiA+ICsvLy8gYG9wYCBpcyBjYWxsZWQgcmVwZWF0ZWRseSB1bnRpbCBgY29uZGAgcmV0
dXJucyBgdHJ1ZWAgb3IgdGhlIHRpbWVvdXQgaXMNCj4+ID4gKy8vLyAgcmVhY2hlZC4gVGhlIHJl
dHVybiB2YWx1ZSBvZiBgb3BgIGlzIHBhc3NlZCB0byBgY29uZGAuDQo+PiA+ICsvLy8NCj4+ID4g
Ky8vLyBgc2xlZXBfZGVsdGFgIGlzIHRoZSBkdXJhdGlvbiB0byBzbGVlcCBiZXR3ZWVuIGNhbGxz
IHRvIGBvcGAuDQo+PiA+ICsvLy8gSWYgYHNsZWVwX2RlbHRhYCBpcyBsZXNzIHRoYW4gb25lIG1p
Y3Jvc2Vjb25kLCB0aGUgZnVuY3Rpb24gd2lsbCBidXN5LXdhaXQuDQo+PiA+ICsvLy8NCj4+ID4g
Ky8vLyBgdGltZW91dF9kZWx0YWAgaXMgdGhlIG1heGltdW0gdGltZSB0byB3YWl0IGZvciBgY29u
ZGAgdG8gcmV0dXJuIGB0cnVlYC4NCj4+ID4gKy8vLw0KPj4gPiArLy8vIFRoaXMgbWFjcm8gY2Fu
IG9ubHkgYmUgdXNlZCBpbiBhIG5vbmF0b21pYyBjb250ZXh0Lg0KPj4gPiArI1ttYWNyb19leHBv
cnRdDQo+PiA+ICttYWNyb19ydWxlcyEgcmVhZHhfcG9sbF90aW1lb3V0IHsNCj4+ID4gKyAgICAo
JG9wOmV4cHIsICRjb25kOmV4cHIsICRzbGVlcF9kZWx0YTpleHByLCAkdGltZW91dF9kZWx0YTpl
eHByKSA9PiB7ew0KPj4gPiArICAgICAgICAjW2NmZyhDT05GSUdfREVCVUdfQVRPTUlDX1NMRUVQ
KV0NCj4+ID4gKyAgICAgICAgaWYgISRzbGVlcF9kZWx0YS5pc196ZXJvKCkgew0KPj4gPiArICAg
ICAgICAgICAgLy8gU0FGRVRZOiBGRkkgY2FsbC4NCj4+ID4gKyAgICAgICAgICAgIHVuc2FmZSB7
DQo+PiA+ICsgICAgICAgICAgICAgICAgJGNyYXRlOjpiaW5kaW5nczo6X19taWdodF9zbGVlcCgN
Cj4+ID4gKyAgICAgICAgICAgICAgICAgICAgOjpjb3JlOjpmaWxlISgpLmFzX3B0cigpIGFzICpj
b25zdCBpOCwNCj4+ID4gKyAgICAgICAgICAgICAgICAgICAgOjpjb3JlOjpsaW5lISgpIGFzIGkz
MiwNCj4+ID4gKyAgICAgICAgICAgICAgICApDQo+PiA+ICsgICAgICAgICAgICB9DQo+PiA+ICsg
ICAgICAgIH0NCj4+DQo+PiBJIHdvbmRlciBpZiB3ZSBjYW4gdXNlICNbdHJhY2tfY2FsbGVyXSBh
bmQNCj4+IGNvcmU6OnBhbmljOjpMb2NhdGlvbjo6Y2FsbGVyIFsxXSB0byBkbyB0aGlzIHdpdGhv
dXQgaGF2aW5nIHRvIHVzZSBhDQo+PiBtYWNybz8gSSBkb24ndCBrbm93IHdoZXRoZXIgaXQgd291
bGQgd29yaywgYnV0IGlmIGl0IGRvZXMsIHRoYXQgd291bGQNCj4+IGJlIHN1cGVyIGNvb2wuDQoN
ClNlZW1zIGl0IHdvcmtzLCBubyBuZWVkIHRvIHVzZSBtYWNyby4gVGhhbmtzIGEgbG90IQ0KDQo+
PiAjW3RyYWNrX2NhbGxlcl0NCj4+IGZuIG1pZ2h0X3NsZWVwKCkgew0KPj4gICAgIGxldCBsb2Nh
dGlvbiA9IGNvcmU6OnBhbmljOjpMb2NhdGlvbjo6Y2FsbGVyKCk7DQo+PiAgICAgLy8gU0FGRVRZ
OiBGRkkgY2FsbC4NCj4+ICAgICB1bnNhZmUgew0KPj4gICAgICAgICAkY3JhdGU6OmJpbmRpbmdz
OjpfX21pZ2h0X3NsZWVwKA0KPj4gICAgICAgICAgICAgbG9jYXRpb24uZmlsZSgpLmFzX2NoYXJf
cHRyKCksDQo+PiAgICAgICAgICAgICBsb2NhdGlvbi5saW5lKCkgYXMgaTMyLA0KPj4gICAgICAg
ICApDQo+PiAgICAgfQ0KPj4gfQ0KPiANCj4gQWN0dWFsbHksIHRoaXMgcmFpc2VzIGEgcHJvYmxl
bSAuLi4gY29yZTo6cGFuaWM6OkxvY2F0aW9uIGRvZXNuJ3QgZ2l2ZQ0KPiB1cyBhIG51bC10ZXJt
aW5hdGVkIHN0cmluZywgc28gd2UgcHJvYmFibHkgY2FuJ3QgcGFzcyBpdCB0bw0KPiBgX19taWdo
dF9zbGVlcGAuIFRoZSB0aGluZyBpcywgYDo6Y29yZTo6ZmlsZSEoKWAgZG9lc24ndCBnaXZlIHVz
IGENCj4gbnVsLXRlcm1pbmF0ZWQgc3RyaW5nIGVpdGhlciwgc28gdGhpcyBjb2RlIGlzIHByb2Jh
Ymx5IGluY29ycmVjdA0KPiBhcy1pcy4NCg0KQWgsIHdoYXQncyB0aGUgcmVjb21tZW5kZWQgd2F5
IHRvIGdldCBhIG51bGwtdGVybWluYXRlZCBzdHJpbmcgZnJvbQ0KJnN0cj8NCg==

