Return-Path: <netdev+bounces-56362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5C380E989
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 11:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25AEDB20765
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 10:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76865CD08;
	Tue, 12 Dec 2023 10:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PfK3nEiZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F070EAC;
	Tue, 12 Dec 2023 02:56:05 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5c6910e93e3so650524a12.1;
        Tue, 12 Dec 2023 02:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702378565; x=1702983365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=700xMZqlIGsZFZ403bkZhly1tz9NywHmtpL60RDOvh4=;
        b=PfK3nEiZhIpYK7SHnuUzEFvDL+lpHbFUbc1yHnbzE4zLZ2OyJYTEkJqRFLy2euovjG
         bN6OQmxEXbvr8JnuUNXlmIGxks27kjmZ2j8/EwIbDqWSd1oEoFS+Oe3BrQu+krvO4KA2
         EukS35xkXmelmxrn7Xpk/6NQEB4S1iGLnsPaBTykP6KvW4eaAYG1AW1MoNOYZg4mLLKu
         HbVTBwAC/3xZoXSasp1NEoeWybYodcvGBl/GcVP6NRdSivdTrJ6jnNSKtIC40Yhtx1JC
         KtBM5GaYW1tsAqYj3zmdcWu9bOc2v63FdnWo/P60Y5I2mnhEhI3zGpHQCE2bazbI6sjT
         atRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702378565; x=1702983365;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=700xMZqlIGsZFZ403bkZhly1tz9NywHmtpL60RDOvh4=;
        b=PAnubluVLYlOkpS85zn7rXFrMm5kJTTJnNf7RCAuoIPPQNXhebbMZKatXHqk1ozdsF
         hdpdgxleIlA2jpDbCV+8yKWaMpwNQcUSDhKoeBWjoqtq0C6LV1JoM5pXozf9FGYCEGmV
         q/oOcgmPJzqyM5HkeY3Do5D9v92xqcR3AINn+um3R69fjVOXjallJLWJqhEGU6/4G95u
         0YXL2YXi9csEUHRa9yNZoYty0Qr4qzZr1zCrrOFdUR4j2PsXmkY/z8MopUMV5/n4OBFq
         lbyqa6RXFJOlUz+mb1Cbbn7w438hTGH7KZ2aX2r+lDiLkewd8FCLxbpZZrZp9uTO9tXt
         rQiQ==
X-Gm-Message-State: AOJu0YzFspYiSE+3lpOIACgKS13ogjNX86Jp2DwjBfiepU+bNyYASYPJ
	I/GJWiYWI8+Yxb6Q6MBpSAaz+/018Ym7Px1F
X-Google-Smtp-Source: AGHT+IEWw02M1zoXyMS9LXFmu8thllBn7qrbe0aZarUs734JWXddbR+Imhj4zvErCsU3aTeXbGWVQA==
X-Received: by 2002:a05:6a00:4601:b0:6ce:72d7:1e74 with SMTP id ko1-20020a056a00460100b006ce72d71e74mr12454764pfb.2.1702378565392;
        Tue, 12 Dec 2023 02:56:05 -0800 (PST)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id fi29-20020a056a00399d00b006cbe1bb5e3asm7735072pfb.138.2023.12.12.02.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 02:56:05 -0800 (PST)
Date: Tue, 12 Dec 2023 19:56:04 +0900 (JST)
Message-Id: <20231212.195604.1948536398150230076.fujita.tomonori@gmail.com>
To: aliceryhl@google.com
Cc: fujita.tomonori@gmail.com, alice@ryhl.io, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu,
 miguel.ojeda.sandonis@gmail.com, benno.lossin@proton.me,
 wedsonaf@gmail.com, boqun.feng@gmail.com
Subject: Re: [PATCH net-next v10 1/4] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CAH5fLghyo3vdrQvQgRsMHp6Hh1=L5+PqHbfBXoF7t4E4URN_vw@mail.gmail.com>
References: <ccf2b9af-1c8c-44c4-bb93-51dd9ea1cccf@ryhl.io>
	<20231212.081505.1423250811446494582.fujita.tomonori@gmail.com>
	<CAH5fLghyo3vdrQvQgRsMHp6Hh1=L5+PqHbfBXoF7t4E4URN_vw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64

T24gVHVlLCAxMiBEZWMgMjAyMyAxMDoyMzozMCArMDEwMA0KQWxpY2UgUnlobCA8YWxpY2VyeWhs
QGdvb2dsZS5jb20+IHdyb3RlOg0KDQo+IE9uIFR1ZSwgRGVjIDEyLCAyMDIzIGF0IDEyOjE14oCv
QU0gRlVKSVRBIFRvbW9ub3JpDQo+IDxmdWppdGEudG9tb25vcmlAZ21haWwuY29tPiB3cm90ZToN
Cj4+DQo+PiBPbiBNb24sIDExIERlYyAyMDIzIDIyOjQ2OjAxICswMTAwDQo+PiBBbGljZSBSeWhs
IDxhbGljZUByeWhsLmlvPiB3cm90ZToNCj4+ID4+ICsgICAgLy8vIEdldHMgdGhlIHN0YXRlIG9m
IFBIWSBzdGF0ZSBtYWNoaW5lIHN0YXRlcy4NCj4+ID4+ICsgICAgcHViIGZuIHN0YXRlKCZzZWxm
KSAtPiBEZXZpY2VTdGF0ZSB7DQo+PiA+PiArICAgICAgICBsZXQgcGh5ZGV2ID0gc2VsZi4wLmdl
dCgpOw0KPj4gPj4gKyAgICAgICAgLy8gU0FGRVRZOiBUaGUgc3RydWN0IGludmFyaWFudCBlbnN1
cmVzIHRoYXQgd2UgbWF5IGFjY2Vzcw0KPj4gPj4gKyAgICAgICAgLy8gdGhpcyBmaWVsZCB3aXRo
b3V0IGFkZGl0aW9uYWwgc3luY2hyb25pemF0aW9uLg0KPj4gPj4gKyAgICAgICAgbGV0IHN0YXRl
ID0gdW5zYWZlIHsgKCpwaHlkZXYpLnN0YXRlIH07DQo+PiA+PiArIC8vIFRPRE86IHRoaXMgY29u
dmVyc2lvbiBjb2RlIHdpbGwgYmUgcmVwbGFjZWQgd2l0aCBhdXRvbWF0aWNhbGx5DQo+PiA+PiBn
ZW5lcmF0ZWQgY29kZSBieSBiaW5kZ2VuDQo+PiA+PiArICAgICAgICAvLyB3aGVuIGl0IGJlY29t
ZXMgcG9zc2libGUuDQo+PiA+PiArICAgICAgICAvLyBiZXR0ZXIgdG8gY2FsbCBXQVJOX09OQ0Uo
KSB3aGVuIHRoZSBzdGF0ZSBpcyBvdXQtb2YtcmFuZ2UuDQo+PiA+DQo+PiA+IERpZCB5b3UgbWl4
IHVwIHR3byBjb21tZW50cyBoZXJlPyBUaGlzIGRvZXNuJ3QgcGFyc2UgaW4gbXkgYnJhaW4uDQo+
Pg0KPj4gSSdsbCByZW1vdmUgdGhlIHNlY29uZCBjb21tZW50IGJlY2F1c2UgYWxsIHdlIGhhdmUg
dG8gZG8gaGVyZSBpcyB1c2luZw0KPj4gYmluZGdlbi4NCj4+DQo+Pg0KPj4gPj4gKyAgICAvLy8g
UmVhZHMgYSBnaXZlbiBDMjIgUEhZIHJlZ2lzdGVyLg0KPj4gPj4gKyAvLyBUaGlzIGZ1bmN0aW9u
IHJlYWRzIGEgaGFyZHdhcmUgcmVnaXN0ZXIgYW5kIHVwZGF0ZXMgdGhlIHN0YXRzIHNvDQo+PiA+
PiB0YWtlcyBgJm11dCBzZWxmYC4NCj4+ID4+ICsgICAgcHViIGZuIHJlYWQoJm11dCBzZWxmLCBy
ZWdudW06IHUxNikgLT4gUmVzdWx0PHUxNj4gew0KPj4gPj4gKyAgICAgICAgbGV0IHBoeWRldiA9
IHNlbGYuMC5nZXQoKTsNCj4+ID4+ICsgLy8gU0FGRVRZOiBgcGh5ZGV2YCBpcyBwb2ludGluZyB0
byBhIHZhbGlkIG9iamVjdCBieSB0aGUgdHlwZQ0KPj4gPj4gaW52YXJpYW50IG9mIGBTZWxmYC4N
Cj4+ID4+ICsgICAgICAgIC8vIFNvIGFuIEZGSSBjYWxsIHdpdGggYSB2YWxpZCBwb2ludGVyLg0K
Pj4gPg0KPj4gPiBUaGlzIHNlbnRlbmNlIGFsc28gZG9lc24ndCBwYXJzZSBpbiBteSBicmFpbi4g
UGVyaGFwcyAiU28gaXQncyBqdXN0IGFuDQo+PiA+IEZGSSBjYWxsIiBvciBzaW1pbGFyPw0KPj4N
Cj4+ICJTbyBpdCdzIGp1c3QgYW4gRkZJIGNhbGwiIGxvb2tzIGdvb2QuIEknbGwgZml4IGFsbCB0
aGUgcGxhY2VzIHRoYXQNCj4+IHVzZSB0aGUgc2FtZSBjb21tZW50Lg0KPiANCj4gSWYgeW91IG1h
a2UgdGhvc2UgdHdvIGNvbW1lbnQgY2hhbmdlcywgdGhlbiB5b3UgY2FuIGFkZA0KPiANCj4gUmV2
aWV3ZWQtYnk6IEFsaWNlIFJ5aGwgPGFsaWNlcnlobEBnb29nbGUuY29tPg0KDQpJIHdpbGwsIHRo
YW5rcyENCg==

