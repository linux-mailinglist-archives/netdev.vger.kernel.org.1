Return-Path: <netdev+bounces-176845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DB4A6C6E0
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 02:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ECF7189AE6E
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 01:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0341F5F6;
	Sat, 22 Mar 2025 01:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvb0h8dX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B271173;
	Sat, 22 Mar 2025 01:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742606700; cv=none; b=WAFI6KGi5XgoUxOU2YwxVGrlbCGM3wFrr7aIBko57T7vuKnEqUG4uh8ozA9ibgrcfCPkITQuuo3nYuQB+E9XlGOJ1rqmrjzwSegLX1gc5vbP7VZYfaNWIFMuw8JDspJMBKu0grpnCM8UA93kyosThHuIrb/EjWuS64uMPgoRKUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742606700; c=relaxed/simple;
	bh=bZI2WcaPPjMe4WlNfTFDih3vqy+KHHXblGdZAs/TyK0=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=W54pBCz+iYFq5N0oaQbsRu7CIrtl82uYjMNZZKVtkKA192aq+7lLqr3mrP03cL9vknkpWLPULljTmEaSa8DC7qLvNGmgRFOnjurCdEl1VTfARIQQQAUfnXeVdUof+guJbdU6Q5kR2kKfLeaoIBcSASxurOmSfAprYBZGws8D+18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mvb0h8dX; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22409077c06so34826845ad.1;
        Fri, 21 Mar 2025 18:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742606698; x=1743211498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bZI2WcaPPjMe4WlNfTFDih3vqy+KHHXblGdZAs/TyK0=;
        b=mvb0h8dX5nhLGxPpKeLPdb+vt9mBYIS0ZsPg07j8HnzeB10lMzVgU3myoekEt2Wth6
         JQPFAnnZN5nHtkcmXtsZcyx6euvv59E/sINWrxHOFFPedWz7J9/nP9/U6+fH6htufGCS
         4AeVWvwkFz6PtyjGVinPQPmBO4BILEbEG1o4avM9Qntz4z7w6Uv4yFgLjPBITrRW6n5S
         mMxYpHf97mc+g5IiOPOEiYqRKX16rX3JCuidaHN4vxSTskwngeg6ZZGH7PY7xKNyIr/n
         lhfHkmkPh+OrYRFGGWrjwv/NqRH/6fRS7+wcZLr3RF5tY3A9NKuz6CmwPG1ZxWLlQvzu
         oKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742606698; x=1743211498;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bZI2WcaPPjMe4WlNfTFDih3vqy+KHHXblGdZAs/TyK0=;
        b=YHjHyT55af7OFqggEy7ZxH6JkPKW+AxBhpAImzHlPRX/NeQeOPSSjJoIBRNX0GtmpA
         n5JmQWI5rSw6ydP1ARddNLf64rTivi6SK7fG+LhPquc+CPKy/IhTXvjoSZmw0eWVH/xK
         BF3GWURTvQYP0Lgq99G2Nf0G1MievJ3/kTFmXlcL5UCrFBu7qG2BWErOYKRkgXDrWv6b
         3n7iCSf8BODSrQpOr72aFYAXYXaIB7SAs3ibHjtlGQyzXrw9c/nOOas6a7a+IwvsLhDR
         8FUEvkgzAxn02yW3DY9+Cwpp3vViQNENp+maToqR23Rcn3v60Op4Zok01gWPDY84ovm4
         Hwwg==
X-Forwarded-Encrypted: i=1; AJvYcCV8PSPEkZyPZPe3jg3ohYocVo3AzpZfIq2zbxJ2XoFRNMjY8vamOyxtBCoE+Ja9cM9Bdpq7HTWd@vger.kernel.org, AJvYcCVYRx0ShYlFg4osDlvQu0O8NUwLrrNzDgvH0WqNFa7g168SBcCGRmn6C0kLJSB1zRX0pA//oWnJrOaR7N7LfIg=@vger.kernel.org, AJvYcCXmJIxDWFEVIRKfsxLZHH0Soms62ALbmBAjZ/RrZr2dbzPcAyTLhWrdF3cKlVAoJiXNVQ4gdqVUoqgV/8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9kgSQaNQaX67/nRMAT6whbuhx+dVZyVpx+xDjCtdgnWGYSelB
	pmmi3eawF+0Q8R2TP4SbIFdTaXQB1vbVIoBLoJA9Bu4EaXFhyhT2
X-Gm-Gg: ASbGncuGQXR+AUt3CbISumOYflboZhksOJHD/KRePGMwsyP2t7VmT+USXSPwtpiOXjv
	DQ+SRpci8Nn2qTnAzW1Nx14yNoUR/s567IdKRf5CoTS9XnwLMCbinEbeHl4keLkakMJ2QbnaRJB
	FD5P+pDb1pbgaI4TzLREBzQ0qVH+L5gDMcNFrZrXxbDvDetBBqyir2G5McPt881HrSRNJm3xZ/2
	THpcl8vGIEar+Mp+iQFKvUSKog2ZJyUxBiCNe29DJyHV/ESRGWWymEk93DRnyZQLzuXPzPiqGxg
	KGoEErr5uhFo+cwSeefU4aZEvBgcvWfJWEoRJkgv4LfVwg/1Mr4nQgd05eYY+P2AVireKaEYdyU
	2fCSHOXlgzxGSu7kB7WP+yEk2Pg0=
X-Google-Smtp-Source: AGHT+IG+KGbqcApHBMLseQN6Ms7E0RNkF5fm0apwIKTM6zyD46K6uqb2NA3RjCl67LPHQjaxn66Bqg==
X-Received: by 2002:a17:902:da8f:b0:224:1219:934b with SMTP id d9443c01a7336-22780e23677mr76423335ad.50.1742606697560;
        Fri, 21 Mar 2025 18:24:57 -0700 (PDT)
Received: from localhost (p4204131-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.160.176.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f3a2e0sm24866285ad.39.2025.03.21.18.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 18:24:57 -0700 (PDT)
Date: Sat, 22 Mar 2025 10:24:49 +0900 (JST)
Message-Id: <20250322.102449.895174336060649075.fujita.tomonori@gmail.com>
To: frederic@kernel.org
Cc: fujita.tomonori@gmail.com, linux-kernel@vger.kernel.org,
 daniel.almeida@collabora.com, gary@garyguo.net, aliceryhl@google.com,
 me@kloenk.dev, rust-for-linux@vger.kernel.org, netdev@vger.kernel.org,
 andrew@lunn.ch, hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
 alex.gaynor@gmail.com, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, anna-maria@linutronix.de, tglx@linutronix.de,
 arnd@arndb.de, jstultz@google.com, sboyd@kernel.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, tgunders@redhat.com,
 david.laight.linux@gmail.com
Subject: Re: [PATCH v11 5/8] rust: time: Add wrapper for fsleep() function
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <Z93io9rkpRMiXEKi@pavilion.home>
References: <20250220070611.214262-1-fujita.tomonori@gmail.com>
	<20250220070611.214262-6-fujita.tomonori@gmail.com>
	<Z93io9rkpRMiXEKi@pavilion.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64

T24gRnJpLCAyMSBNYXIgMjAyNSAyMzowNToyMyArMDEwMA0KRnJlZGVyaWMgV2Vpc2JlY2tlciA8
ZnJlZGVyaWNAa2VybmVsLm9yZz4gd3JvdGU6DQoNCj4gTGUgVGh1LCBGZWIgMjAsIDIwMjUgYXQg
MDQ6MDY6MDdQTSArMDkwMCwgRlVKSVRBIFRvbW9ub3JpIGEgw6ljcml0IDoNCj4+IEFkZCBhIHdy
YXBwZXIgZm9yIGZzbGVlcCgpLCBmbGV4aWJsZSBzbGVlcCBmdW5jdGlvbnMgaW4NCj4+IGluY2x1
ZGUvbGludXgvZGVsYXkuaCB3aGljaCB0eXBpY2FsbHkgZGVhbHMgd2l0aCBoYXJkd2FyZSBkZWxh
eXMuDQo+PiANCj4+IFRoZSBrZXJuZWwgc3VwcG9ydHMgc2V2ZXJhbCBzbGVlcCBmdW5jdGlvbnMg
dG8gaGFuZGxlIHZhcmlvdXMgbGVuZ3Rocw0KPj4gb2YgZGVsYXkuIFRoaXMgYWRkcyBmc2xlZXAo
KSwgYXV0b21hdGljYWxseSBjaG9vc2VzIHRoZSBiZXN0IHNsZWVwDQo+PiBtZXRob2QgYmFzZWQg
b24gYSBkdXJhdGlvbi4NCj4+IA0KPj4gc2xlZXAgZnVuY3Rpb25zIGluY2x1ZGluZyBmc2xlZXAo
KSBiZWxvbmdzIHRvIFRJTUVSUywgbm90DQo+PiBUSU1FS0VFUElORy4gVGhleSBhcmUgbWFpbnRh
aW5lZCBzZXBhcmF0ZWx5LiBydXN0L2tlcm5lbC90aW1lLnJzIGlzIGFuDQo+PiBhYnN0cmFjdGlv
biBmb3IgVElNRUtFRVBJTkcuIFRvIG1ha2UgUnVzdCBhYnN0cmFjdGlvbnMgbWF0Y2ggdGhlIEMN
Cj4+IHNpZGUsIGFkZCBydXN0L2tlcm5lbC90aW1lL2RlbGF5LnJzIGZvciB0aGlzIHdyYXBwZXIu
DQo+PiANCj4+IGZzbGVlcCgpIGNhbiBvbmx5IGJlIHVzZWQgaW4gYSBub25hdG9taWMgY29udGV4
dC4gVGhpcyByZXF1aXJlbWVudCBpcw0KPj4gbm90IGNoZWNrZWQgYnkgdGhlc2UgYWJzdHJhY3Rp
b25zLCBidXQgaXQgaXMgaW50ZW5kZWQgdGhhdCBrbGludCBbMV0NCj4+IG9yIGEgc2ltaWxhciB0
b29sIHdpbGwgYmUgdXNlZCB0byBjaGVjayBpdCBpbiB0aGUgZnV0dXJlLg0KPj4gDQo+PiBMaW5r
OiBodHRwczovL3J1c3QtZm9yLWxpbnV4LmNvbS9rbGludCBbMV0NCj4+IFRlc3RlZC1ieTogRGFu
aWVsIEFsbWVpZGEgPGRhbmllbC5hbG1laWRhQGNvbGxhYm9yYS5jb20+DQo+PiBSZXZpZXdlZC1i
eTogR2FyeSBHdW8gPGdhcnlAZ2FyeWd1by5uZXQ+DQo+PiBSZXZpZXdlZC1ieTogQWxpY2UgUnlo
bCA8YWxpY2VyeWhsQGdvb2dsZS5jb20+DQo+PiBSZXZpZXdlZC1ieTogRmlvbmEgQmVocmVucyA8
bWVAa2xvZW5rLmRldj4NCj4+IFNpZ25lZC1vZmYtYnk6IEZVSklUQSBUb21vbm9yaSA8ZnVqaXRh
LnRvbW9ub3JpQGdtYWlsLmNvbT4NCj4gDQo+IFNvcnJ5IHRvIG1ha2UgYSBsYXRlIHJldmlldy4g
SSBkb24ndCBtZWFuIHRvIGRlbGF5IHRoYXQgYW55IGZ1cnRoZXINCj4gYnV0Og0KDQpObyBwcm9i
bGVtIGF0IGFsbC4gVGhhbmtzIGZvciByZXZpZXdpbmchDQoNCg0KPj4gKy8vLyBgZGVsdGFgIG11
c3QgYmUgd2l0aGluIGBbMCwgaTMyOjpNQVhdYCBtaWNyb3NlY29uZHM7DQo+PiArLy8vIG90aGVy
d2lzZSwgaXQgaXMgZXJyb25lb3VzIGJlaGF2aW9yLiBUaGF0IGlzLCBpdCBpcyBjb25zaWRlcmVk
IGEgYnVnDQo+PiArLy8vIHRvIGNhbGwgdGhpcyBmdW5jdGlvbiB3aXRoIGFuIG91dC1vZi1yYW5n
ZSB2YWx1ZSwgaW4gd2hpY2ggY2FzZSB0aGUgZnVuY3Rpb24NCj4+ICsvLy8gd2lsbCBzbGVlcCBm
b3IgYXQgbGVhc3QgdGhlIG1heGltdW0gdmFsdWUgaW4gdGhlIHJhbmdlIGFuZCBtYXkgd2Fybg0K
Pj4gKy8vLyBpbiB0aGUgZnV0dXJlLg0KPj4gKy8vLw0KPj4gKy8vLyBUaGUgYmVoYXZpb3IgYWJv
dmUgZGlmZmVycyBmcm9tIHRoZSBDIHNpZGUgW2Bmc2xlZXAoKWBdIGZvciB3aGljaCBvdXQtb2Yt
cmFuZ2UNCj4+ICsvLy8gdmFsdWVzIG1lYW4gImluZmluaXRlIHRpbWVvdXQiIGluc3RlYWQuDQo+
IA0KPiBBbmQgdmVyeSBpbXBvcnRhbnQ6IHRoZSBiZWhhdmlvdXIgYWxzbyBkaWZmZXIgaW4gdGhh
dCB0aGUgQyBzaWRlIHRha2VzDQo+IHVzZWNzIHdoaWxlIHRoaXMgdGFrZXMgbnNlY3MuIFdlIHNo
b3VsZCByZWFsbHkgZGlzYW1iaWd1YXRlIHRoZSBzaXR1YXRpb24NCj4gYXMgdGhhdCBtaWdodCBj
cmVhdGUgY29uZnVzaW9uIG9yIG1pc3VzYWdlLg0KPiANCj4gRWl0aGVyIHRoaXMgc2hvdWxkIGJl
IHJlbmFtZWQgdG8gZnNsZWVwX25zKCkgb3IgZnNsZWVwX25zZWNzKCksIG9yIHRoaXMgc2hvdWxk
DQo+IHRha2UgbWljcm9zZWNvbmRzIGRpcmVjdGx5Lg0KDQpZb3UgbWVhbnQgdGhhdCBgRGVsdGFg
IHR5cGUgaW50ZXJuYWxseSB0cmFja3MgdGltZSBpbiBuYW5vc2Vjb25kcz8NCg0KSXQncyB0cnVl
IGJ1dCBEZWx0YSB0eXBlIGlzIGEgdW5pdC1hZ25vc3RpYyB0aW1lIGFic3RyYWN0aW9uLCBkZXNp
Z25lZA0KdG8gcmVwcmVzZW50IGR1cmF0aW9ucyBhY3Jvc3MgZGlmZmVyZW50IGdyYW51bGFyaXRp
ZXMg4oCUIHNlY29uZHMsDQptaWxsaXNlY29uZHMsIG1pY3Jvc2Vjb25kcywgbmFub3NlY29uZHMu
IFRoZSBSdXN0IGFic3RyYWN0aW9uIGFsd2F5cw0KdHJpZXMgdG8gdXMgRGVsdGEgdHlwZSB0byBy
ZXByZXNlbnQgZHVyYXRpb25zLg0KDQpSdXN0J3MgZnNsZWVwIHRha2VzIERlbHRhLCBpbnRlcm5h
bGx5IGNvbnZlcnRzIGl0IGluIHVzZWNzLCBhbmQgY2FsbHMNCkMncyBmc2xlZXAuDQoNClVzdWFs
bHksIGRyaXZlcnMgY29udmVydCBmcm9tIGEgY2VydGFpbiB0aW1lIHVuaXQgdG8gRGVsdGEgYmVm
b3JlDQpjYWxsaW5nIGZzbGVlcCBsaWtlIHRoZSBmb2xsb3dpbmcsIHNvIG1pc3VzZSBvciBjb25m
dXNpb24gaXMgdW5saWtlbHkNCnRvIG9jY3VyLCBJIHRoaW5rLg0KDQpmc2xlZXAoRGVsdGE6OmZy
b21fbWljcm9zKDUwKSk7DQoNCkhvd2V2ZXIsIGFzIHlvdSBwb2ludGVkIG91dCwgdGhlcmUgaXMg
YSBkaWZmZXJlbmNlOyBDJ3MgZnNsZWVwIHRha2VzDQp1c2VjcyB3aGlsZSBSdXN0J3MgZnNsZWVw
IHRha2VzIGEgdW5pdC1hZ25vc3RpYyB0aW1lIHR5cGUuIFRha2luZyB0aGlzDQpkaWZmZXJlbmNl
IGludG8gYWNjb3VudCwgaWYgd2Ugd2VyZSB0byByZW5hbWUgZnNsZWVwIGZvciBSdXN0LCBJIHRo
aW5rDQp0aGF0IGEgbmFtZSB0aGF0IGlzIGFnbm9zdGljIHRvIHRoZSB0aW1lIHVuaXQgd291bGQg
c2VlbSBtb3JlDQphcHByb3ByaWF0ZS4gU2ltcGx5IHNsZWVwKCksIHBlcmhhcHM/DQo=

