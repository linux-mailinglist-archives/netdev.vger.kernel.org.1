Return-Path: <netdev+bounces-159546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76259A15BCC
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 08:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4FE61889FE5
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 07:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F02148FED;
	Sat, 18 Jan 2025 07:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FP3CWNqG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBF03234;
	Sat, 18 Jan 2025 07:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737187054; cv=none; b=P5V3rrCvcEgXuHhuxyTsL6BfXjjNS+1bg8UoI52Mm6av+htJue5fLTqGW67Bh1AEWATIHd+uFpPWzWG87jRrkzYYXkCeSV3a69EBKeoXAHIKLTSCUYKeXMGR9GP5/jXLjM/5K19Nxf6noEcfamujEF4+QQ6tqM5md0DUivk6vsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737187054; c=relaxed/simple;
	bh=9vD+0DhlNG09kWatBSTpiFwYf9VPCwuHSFikccgwJ0k=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=uIfYhUDvvR2M7qZk9z6DgVFJrfjNPNRjy0V0CM7FBj2LGLNlvtuGlRQJmTEcQ8FXf9cu+7Oyx91MZ0SOtfzqGRj7d3xwES8eD049RM7iiQblDdabznowxbFkBoHZX+Nh15YsmvDQEx2wAkxoLO7LeaQ1KgCp6BbY99t0Eo0vvWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FP3CWNqG; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-216426b0865so51705585ad.0;
        Fri, 17 Jan 2025 23:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737187052; x=1737791852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9vD+0DhlNG09kWatBSTpiFwYf9VPCwuHSFikccgwJ0k=;
        b=FP3CWNqGuBW7lcMAt36e2IuwECMYdQ8eLtVNexEfM6pQec35cuHWPyne2ikwb6FjM1
         YBWuEyjitYQGbr6g0vf6hS6aQ1oV506gi3Djfm5NSBEoXyBT+3i+QO/5iA22Q6fj677p
         hM/TBic/trMWiCStIcrt7B6oH2bgeKg/9k8VDzlxneKRDf0Xk11lz2kKlgYKsxnXq7Ev
         SPUfQUGM0Nr5Ck2rvIkNXW2kaoJz2Wuk0hf1VpoD3RRyQYAQde0aJ1K/3M495WDb2nGG
         HzFkU5wcAaEuf3WtyegPwvNXLMNwHPmVtN+n1j44zA0EwwcfEBLtfdR2FdQP7LNjzsMy
         y/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737187052; x=1737791852;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9vD+0DhlNG09kWatBSTpiFwYf9VPCwuHSFikccgwJ0k=;
        b=bH+Lz/P3Y1jcIpEsdgMuy1187bDPmOyrCEq83vRFaIUYHAbPMAC7tIgJLEb/lkHvvW
         YGmGWqGg2HRhVtPUanBGbVmVWYJ4ojCcLVnOEmfnKKtB1oEGuqhLymgDjnjVjxA4q3lM
         +O6+kwtl8VErziKmmQ8YXkzmE9azG6pYV9z9xQH9zP10wd+zqiLCAxNOoLJ3GQXCX5+X
         XFTnPqGtRMNpbV8fJdCN3weCFQ0mdx8TqtrL+yKaSh59tPdNfok9kCxtBpsqSsWN4zyB
         2GVb8GkJl6fUg/CwgvqnMo6Z6knXeuUILVaKWsWNTfcHn6tGmek6npGhPmKbsF2VWKHB
         CHsA==
X-Forwarded-Encrypted: i=1; AJvYcCU4T3N+hE9UuGGFOdRXRFVVXdehXVuuxYGBzft9qos8d3X/bcrjLUuYiwCHSR9FASvCEDmaL6xB@vger.kernel.org, AJvYcCX21OqBbfqV5K/o5aeXAdeKs/XIHj3HENMTHTQeMNTGmWK9wvQWePuq5arRYdrVOuxndLLkn0JacLH0Zfk=@vger.kernel.org, AJvYcCXZZ/tcAcdXeQLLrwEZd0vmD5sOuZvNxb3cWZdaN0YklIzcPg3uoVgTe5ewxmChHq5FGTfoARahNsb53aQVTX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsYe6ePH621TG7/ebbfiuVBmxkpQafvXgzcKEJCj2PZCxU8lud
	Z6ESat+KBTKEm1oN9FagnZ4XQkSQWPnES3y+4AnIgj+xH6uCQpYG
X-Gm-Gg: ASbGnctAue11NuG+/O+bLUJBw/Q6K2BMAGnG3QJ/kEZqGhTvxoO2dubu9C35get3w4l
	uaFMZqgewhiGw82fFE5yLO1oWslyu1T/Wvzy/6mRq5uQQ3NSEVfbSDOk5TokUYpzZCuvY/MU/M3
	TmQ/gblAtCrBkZqfTqu2y0jhN6TJP8cS+iUBBFwHq6RaidQhSfUq4+NBSzXr409uyo3KVLNEUgw
	DYSlWUNA4tWl3r/yyX7lh0zYG2WPmez9E8yWvwlcmv9A6AYHGEt59Yc3RvqfbRLsmOXMc52wJ56
	AaEhmGdNZ1vrvV4vOesC3gsrGJWtzcOLIfOaqaChfaAY/CiRrxk=
X-Google-Smtp-Source: AGHT+IG+VAOf4hpCJZhuaeLcZzKa13aSNnvZlfhOjh1UMJ0LG3uWPQoLh4t6IT2/c42KZlWoG16izA==
X-Received: by 2002:a17:903:1c7:b0:215:b75f:a18d with SMTP id d9443c01a7336-21c351bd440mr79314785ad.11.1737187051970;
        Fri, 17 Jan 2025 23:57:31 -0800 (PST)
Received: from localhost (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2cea1fe9sm27421665ad.2.2025.01.17.23.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 23:57:31 -0800 (PST)
Date: Sat, 18 Jan 2025 16:57:22 +0900 (JST)
Message-Id: <20250118.165722.1081146311228314129.fujita.tomonori@gmail.com>
To: aliceryhl@google.com
Cc: fujita.tomonori@gmail.com, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
 alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@samsung.com, anna-maria@linutronix.de,
 frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de,
 jstultz@google.com, sboyd@kernel.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com
Subject: Re: [PATCH v8 4/7] rust: time: Add wrapper for fsleep function
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CAH5fLgh7jpDyOGJPpasSK8E126YUUL+gj37_2RQr8m2fE9ifVw@mail.gmail.com>
References: <CAH5fLghqbY4UKQ2n1XVKPtvnLfJ4ceh+2aNpVmm9WxbUTu8-GQ@mail.gmail.com>
	<20250117.232015.1047782190952648538.fujita.tomonori@gmail.com>
	<CAH5fLgh7jpDyOGJPpasSK8E126YUUL+gj37_2RQr8m2fE9ifVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64

T24gRnJpLCAxNyBKYW4gMjAyNSAxNTozMTowNyArMDEwMA0KQWxpY2UgUnlobCA8YWxpY2VyeWhs
QGdvb2dsZS5jb20+IHdyb3RlOg0KDQo+IE9uIEZyaSwgSmFuIDE3LCAyMDI1IGF0IDM6MjDigK9Q
TSBGVUpJVEEgVG9tb25vcmkNCj4gPGZ1aml0YS50b21vbm9yaUBnbWFpbC5jb20+IHdyb3RlOg0K
Pj4NCj4+IE9uIEZyaSwgMTcgSmFuIDIwMjUgMTQ6MDU6NTIgKzAxMDANCj4+IEFsaWNlIFJ5aGwg
PGFsaWNlcnlobEBnb29nbGUuY29tPiB3cm90ZToNCj4+DQo+PiA+IE9uIEZyaSwgSmFuIDE3LCAy
MDI1IGF0IDEwOjU14oCvQU0gRlVKSVRBIFRvbW9ub3JpDQo+PiA+IDxmdWppdGEudG9tb25vcmlA
Z21haWwuY29tPiB3cm90ZToNCj4+ID4+DQo+PiA+PiBPbiBGcmksIDE3IEphbiAyMDI1IDEwOjEz
OjA4ICswMTAwDQo+PiA+PiBBbGljZSBSeWhsIDxhbGljZXJ5aGxAZ29vZ2xlLmNvbT4gd3JvdGU6
DQo+PiA+Pg0KPj4gPj4gPiBPbiBGcmksIEphbiAxNywgMjAyNSBhdCAxMDowMeKAr0FNIEZVSklU
QSBUb21vbm9yaQ0KPj4gPj4gPiA8ZnVqaXRhLnRvbW9ub3JpQGdtYWlsLmNvbT4gd3JvdGU6DQo+
PiA+PiA+Pg0KPj4gPj4gPj4gT24gRnJpLCAxNyBKYW4gMjAyNSAxNjo1MzoyNiArMDkwMCAoSlNU
KQ0KPj4gPj4gPj4gRlVKSVRBIFRvbW9ub3JpIDxmdWppdGEudG9tb25vcmlAZ21haWwuY29tPiB3
cm90ZToNCj4+ID4+ID4+DQo+PiA+PiA+PiA+IE9uIFRodSwgMTYgSmFuIDIwMjUgMTA6Mjc6MDIg
KzAxMDANCj4+ID4+ID4+ID4gQWxpY2UgUnlobCA8YWxpY2VyeWhsQGdvb2dsZS5jb20+IHdyb3Rl
Og0KPj4gPj4gPj4gPg0KPj4gPj4gPj4gPj4+ICsvLy8gVGhpcyBmdW5jdGlvbiBjYW4gb25seSBi
ZSB1c2VkIGluIGEgbm9uYXRvbWljIGNvbnRleHQuDQo+PiA+PiA+PiA+Pj4gK3B1YiBmbiBmc2xl
ZXAoZGVsdGE6IERlbHRhKSB7DQo+PiA+PiA+PiA+Pj4gKyAgICAvLyBUaGUgYXJndW1lbnQgb2Yg
ZnNsZWVwIGlzIGFuIHVuc2lnbmVkIGxvbmcsIDMyLWJpdCBvbiAzMi1iaXQgYXJjaGl0ZWN0dXJl
cy4NCj4+ID4+ID4+ID4+PiArICAgIC8vIENvbnNpZGVyaW5nIHRoYXQgZnNsZWVwIHJvdW5kcyB1
cCB0aGUgZHVyYXRpb24gdG8gdGhlIG5lYXJlc3QgbWlsbGlzZWNvbmQsDQo+PiA+PiA+PiA+Pj4g
KyAgICAvLyBzZXQgdGhlIG1heGltdW0gdmFsdWUgdG8gdTMyOjpNQVggLyAyIG1pY3Jvc2Vjb25k
cy4NCj4+ID4+ID4+ID4+PiArICAgIGNvbnN0IE1BWF9EVVJBVElPTjogRGVsdGEgPSBEZWx0YTo6
ZnJvbV9taWNyb3ModTMyOjpNQVggYXMgaTY0ID4+IDEpOw0KPj4gPj4gPj4gPj4NCj4+ID4+ID4+
ID4+IEhtbSwgaXMgdGhpcyB2YWx1ZSBjb3JyZWN0IG9uIDY0LWJpdCBwbGF0Zm9ybXM/DQo+PiA+
PiA+PiA+DQo+PiA+PiA+PiA+IFlvdSBtZWFudCB0aGF0IHRoZSBtYXhpbXVtIGNhbiBiZSBsb25n
ZXIgb24gNjQtYml0IHBsYXRmb3Jtcz8gMjE0NzQ4NA0KPj4gPj4gPj4gPiBtaWxsaXNlY29uZHMg
aXMgbG9uZyBlbm91Z2ggZm9yIGZzbGVlcCdzIGR1cmF0aW9uPw0KPj4gPj4gPj4gPg0KPj4gPj4g
Pj4gPiBJZiB5b3UgcHJlZmVyLCBJIHVzZSBkaWZmZXJlbnQgbWF4aW11bSBkdXJhdGlvbnMgZm9y
IDY0LWJpdCBhbmQgMzItYml0DQo+PiA+PiA+PiA+IHBsYXRmb3JtcywgcmVzcGVjdGl2ZWx5Lg0K
Pj4gPj4gPj4NCj4+ID4+ID4+IEhvdyBhYm91dCB0aGUgZm9sbG93aW5nPw0KPj4gPj4gPj4NCj4+
ID4+ID4+IGNvbnN0IE1BWF9EVVJBVElPTjogRGVsdGEgPSBEZWx0YTo6ZnJvbV9taWNyb3ModXNp
emU6Ok1BWCBhcyBpNjQgPj4gMSk7DQo+PiA+PiA+DQo+PiA+PiA+IFdoeSBpcyB0aGVyZSBhIG1h
eGltdW0gaW4gdGhlIGZpcnN0IHBsYWNlPyBBcmUgeW91IHdvcnJpZWQgYWJvdXQNCj4+ID4+ID4g
b3ZlcmZsb3cgb24gdGhlIEMgc2lkZT8NCj4+ID4+DQo+PiA+PiBZZWFoLCBCb3F1biBpcyBjb25j
ZXJuZWQgdGhhdCBhbiBpbmNvcnJlY3QgaW5wdXQgKGEgbmVnYXRpdmUgdmFsdWUgb3INCj4+ID4+
IGFuIG92ZXJmbG93IG9uIHRoZSBDIHNpZGUpIGxlYWRzIHRvIHVuaW50ZW50aW9uYWwgaW5maW5p
dGUgc2xlZXA6DQo+PiA+Pg0KPj4gPj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC9aeHdW
dWNlTk9SUkFJN0ZWQEJvcXVucy1NYWMtbWluaS5sb2NhbC8NCj4+ID4NCj4+ID4gT2theSwgY2Fu
IHlvdSBleHBsYWluIGluIHRoZSBjb21tZW50IHRoYXQgdGhpcyBtYXhpbXVtIHZhbHVlIHByZXZl
bnRzDQo+PiA+IGludGVnZXIgb3ZlcmZsb3cgaW5zaWRlIGZzbGVlcD8NCj4+DQo+PiBTdXJlbHks
IGhvdyBhYm91dCB0aGUgZm9sbG93aW5nPw0KPj4NCj4+IHB1YiBmbiBmc2xlZXAoZGVsdGE6IERl
bHRhKSB7DQo+PiAgICAgLy8gVGhlIGFyZ3VtZW50IG9mIGZzbGVlcCBpcyBhbiB1bnNpZ25lZCBs
b25nLCAzMi1iaXQgb24gMzItYml0IGFyY2hpdGVjdHVyZXMuDQo+PiAgICAgLy8gQ29uc2lkZXJp
bmcgdGhhdCBmc2xlZXAgcm91bmRzIHVwIHRoZSBkdXJhdGlvbiB0byB0aGUgbmVhcmVzdCBtaWxs
aXNlY29uZCwNCj4+ICAgICAvLyBzZXQgdGhlIG1heGltdW0gdmFsdWUgdG8gdTMyOjpNQVggLyAy
IG1pY3Jvc2Vjb25kcyB0byBwcmV2ZW50IGludGVnZXINCj4+ICAgICAvLyBvdmVyZmxvdyBpbnNp
ZGUgZnNsZWVwLCB3aGljaCBjb3VsZCBsZWFkIHRvIHVuaW50ZW50aW9uYWwgaW5maW5pdGUgc2xl
ZXAuDQo+PiAgICAgY29uc3QgTUFYX0RVUkFUSU9OOiBEZWx0YSA9IERlbHRhOjpmcm9tX21pY3Jv
cyh1MzI6Ok1BWCBhcyBpNjQgPj4gMSk7DQo+IA0KPiBIbW0gLi4uIHRoaXMgaXMgcGhyYXNlZCBh
cy1pZiB0aGUgcHJvYmxlbSBpcyBvbiAzMi1iaXQgbWFjaGluZXMsIGJ1dA0KPiB0aGUgcHJvYmxl
bSBpcyB0aGF0IGZzbGVlcCBjYXN0cyBhbiBgdW5zaWduZWQgbG9uZ2AgdG8gYHVuc2lnbmVkIGlu
dGANCj4gd2hpY2ggY2FuIG92ZXJmbG93IG9uIDY0LWJpdCBtYWNoaW5lcy4gSSB3b3VsZCBpbnN0
ZWFkIHNheSB0aGlzDQo+IHByZXZlbnRzIG92ZXJmbG93IG9uIDY0LWJpdCBtYWNoaW5lcyB3aGVu
IGNhc3RpbmcgdG8gYW4gaW50Lg0KDQpZZWFoLCBidXQgRElWX1JPVU5EX1VQIGluIGZzeW5jKCkg
Y291bGQgYWxzbyBjYXVzZSBvdmVyZmxvdyBiZWZvcmUNCmNhc3RpbmcgdWxvbmcgdG8gdWludCBm
b3IgY2FsbGluZyBtc2xlZXAoKSAoaXQgY291bGQgaGFwcGVuIG9uIGJvdGgNCjMyLWJpdCBhbmQg
NjQtYml0KS4NCg0KVGhlIGZvbGxvd2luZyBsb29rcyBvaz8NCg0KVGhlIG1heGltdW0gdmFsdWUg
aXMgc2V0IHRvIGB1MzI6Ok1BWCAvIDJgIG1pY3Jvc2Vjb25kcyB0byBwcmV2ZW50IGludGVnZXIN
Cm92ZXJmbG93IGluc2lkZSBmc2xlZXAsIHdoaWNoIGNvdWxkIGxlYWQgdG8gdW5pbnRlbnRpb25h
bCBpbmZpbml0ZSBzbGVlcC4NCg0KDQo+IEFsc28sIGl0IG1pZ2h0IGJlIGNsZWFuZXIgdG8ganVz
dCB1c2UgYGkzMjo6TUFYIGFzIGk2NGAgaW5zdGVhZCBvZiB1MzIuDQoNCllvdSBtZWFudCB0aGF0
IHVzaW5nIGkzMjo6TUFYIGluc3RlYWQgb2YgdTMyOjpNQVggLyAyIChhbmQgdTMyOjpNQVggPj4N
CjEpIG1pZ2h0IGJlIGNsZWFuZXI/IEkgbWlnaHQgdGhpbmsgc28gdG9vLg0KDQoNCg0K

