Return-Path: <netdev+bounces-178958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBA8A79A4C
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 05:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E836171BA8
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 03:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F79F2AE9A;
	Thu,  3 Apr 2025 03:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbSQJC8h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22971854;
	Thu,  3 Apr 2025 03:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743649343; cv=none; b=dCQvZJV2yGcjdevYqcQuPYH7mhB6Q+62zg09jn6ZQarSlon0yUirVwZsSuT6tW6fQJsh44xdxsOu/u3XM2SjGEnOcvArOy5+wquSVtIokByoUk+NxXUdKjg25/FuKx9IUYaywTy+MOjFKou+SFWEtcKmL9v6NUElaYoVZAhLe5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743649343; c=relaxed/simple;
	bh=zILCpXRlDPYQxTs40NDTFltG0eod5vNnKzxwVDYfyxI=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=iVFSIcZOPD0K44VcT2WXjyTo3AChMmPO8ml6NOM3+rNH0u/SaNx8l2jlJ2Ip2P6ELMxiSBEum8K75rM3UCSJ7DbPfOjNGNtNhgqXxkTNEMNksxasaPDpXyyP9cNlLKfPx2miF7G4jG0B9tGsWxLZhArZqb5/SarD2E1EuhDX9DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hbSQJC8h; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ff6a98c638so499365a91.0;
        Wed, 02 Apr 2025 20:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743649336; x=1744254136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zILCpXRlDPYQxTs40NDTFltG0eod5vNnKzxwVDYfyxI=;
        b=hbSQJC8h61rQ1HP//RlrWYF+UWQ3/pT32oBDKmsnU2WgoGb9m18PcrzgMUsXKm3DM4
         AO+6KCZ10+iw8GjOaUCciYNDNiUjP2ErG83dKgORYXg9NACMHh5RHEZEocdgHr2n5YE6
         UpsfZJ19Pvxk3fNYkKAHRwnvc68dhVxxSaiRUErQuCFGaaO9iprlPgR/XTKml0i5PkjG
         aGc6HsnzGbQaXf8Z5qo83QnA2zpLjJw2qdim+UbX4pVbgiXEeiquTn69lAk3Sv78YkFm
         9vBMYGHrMVBLykm2thR4TV3KQFWZb3+3z/RM4kdobGmBH1CYYoiUwyc3ycuJBh6SrjLZ
         LQaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743649336; x=1744254136;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zILCpXRlDPYQxTs40NDTFltG0eod5vNnKzxwVDYfyxI=;
        b=IdoGT2/+zmYorczAyGc/Q/qhPeiXmar1j95C6fZnJ8MfOBnhOeE/ErW+VFLpAcD2kg
         ntSBIUFMG6bLv52wqWVneET41oBtmsLI2eNsSFvVvYLGBX/TcqTEcBgVIlfv5xLPr4Qq
         gCoo4IDX2dGCeRdaRQDEI2XYYKqejs6vO0+Jh6CmINfLA02KoZTmH0Di+3Pib0Eq9+Cw
         KuQlETF6OZg/x+ED8XcRvVzS7RVDOXWWzUZE6MIaaqs8DIIXBhb59TlCHBSdHYu9AKvU
         KrGCjMJWFeZWLMQci7gnfFHE2nr2hFTlioZQfC0GQoq82crSNbtjM6Qax6RUxz/E/qK9
         waTQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0gHGnjwekpfw5OJu6y/4AxSoatVVv84RzDqp7JMe1s7G1koXxN7y1BQijwKGEQivYT5QTECzm3smOZmg=@vger.kernel.org, AJvYcCUaENi7hTR91ZX67t9cz/I14IMNS1ZoD5gCjj4aqVrVtk4xk1tT9k+YykAtOqGvb/wj0iFDbvmQ@vger.kernel.org, AJvYcCX72OlxdTNDjJ5JqI/TMqLoU7ywMwvwBaWZDJUGNcXpf5+9yItDHBuvrLx1VVsljdDylVT3BxpuJ9B3FhZLXK8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm+GYLAV/EdwkilG7q4ogX44jcX6ug6S+KMNWPV1hFPbmylMgU
	hsVwzua5G10PJgWDdGteitCBNzL2jFDlbeT3klof8sdurckPs94e
X-Gm-Gg: ASbGncuR/wA3gD+HC+QNiP5OMA2miAEbdOl7i4Sq/8vv4j2FfJgP4qXQWK9yKPG8QsV
	1OVlIS2bFZFN/v/7C5O1SLeAj1ZZmtmb2DtIbwV5Bvari2aPrrP5FmCPEEnm6UsXc+7sIUCU8y/
	+6rgmEo72KOIfAwou5EkFV1dZAZ0J850A1Br0+hsL5c/zOdA+f5s1xH8MsI8YODjlYhxBoXRYvn
	uts/moAf9EDP7ugesCBCIxu4opYpbDmB04YFx0Lq7gQ6TuLcomYql4V6bucW74mHR+qUcb9e7HQ
	/5O83Evgo60mwldRO8T5OiwlrjMTUS7AG7DUAw4rJ9+39+/4yYLneMRG52JaingMuEb6VfVfKtG
	dSqYTWg66pewh7xAr47P5ExSE3gqbmcaHRk73YA==
X-Google-Smtp-Source: AGHT+IG/HM91gbF6Wvjl0nl9i1oxhE6UPJmUUlhTAMmRAyVHrzl3LIXw5FH2LjD03wY4SYeOLYUamA==
X-Received: by 2002:a17:90b:534d:b0:2ee:df70:1ff3 with SMTP id 98e67ed59e1d1-3057c9da782mr2007175a91.0.1743649336064;
        Wed, 02 Apr 2025 20:02:16 -0700 (PDT)
Received: from localhost (p4204131-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.160.176.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3057ca8768fsm465466a91.27.2025.04.02.20.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 20:02:15 -0700 (PDT)
Date: Thu, 03 Apr 2025 12:02:00 +0900 (JST)
Message-Id: <20250403.120200.1300877147444853564.fujita.tomonori@gmail.com>
To: boqun.feng@gmail.com
Cc: fujita.tomonori@gmail.com, a.hindborg@kernel.org, tglx@linutronix.de,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, aliceryhl@google.com, anna-maria@linutronix.de,
 frederic@kernel.org, arnd@arndb.de, jstultz@google.com, sboyd@kernel.org,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 tgunders@redhat.com, me@kloenk.dev, david.laight.linux@gmail.com
Subject: Re: [PATCH v11 6/8] MAINTAINERS: rust: Add new sections for
 DELAY/SLEEP and TIMEKEEPING API
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <Z-3bnUucR5EX8XVu@Mac.home>
References: <Z-1l3mgsOi4y4N_c@boqun-archlinux>
	<20250403.080334.1462587538453396496.fujita.tomonori@gmail.com>
	<Z-3bnUucR5EX8XVu@Mac.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64

T24gV2VkLCAyIEFwciAyMDI1IDE3OjUxOjQxIC0wNzAwDQpCb3F1biBGZW5nIDxib3F1bi5mZW5n
QGdtYWlsLmNvbT4gd3JvdGU6DQoNCj4gT24gVGh1LCBBcHIgMDMsIDIwMjUgYXQgMDg6MDM6MzRB
TSArMDkwMCwgRlVKSVRBIFRvbW9ub3JpIHdyb3RlOg0KPj4gT24gV2VkLCAyIEFwciAyMDI1IDA5
OjI5OjE4IC0wNzAwDQo+PiBCb3F1biBGZW5nIDxib3F1bi5mZW5nQGdtYWlsLmNvbT4gd3JvdGU6
DQo+PiANCj4+ID4gT24gV2VkLCBBcHIgMDIsIDIwMjUgYXQgMTE6MTY6MjdQTSArMDkwMCwgRlVK
SVRBIFRvbW9ub3JpIHdyb3RlOg0KPj4gPj4gT24gTW9uLCAzMSBNYXIgMjAyNSAwNzowMzoxNSAt
MDcwMA0KPj4gPj4gQm9xdW4gRmVuZyA8Ym9xdW4uZmVuZ0BnbWFpbC5jb20+IHdyb3RlOg0KPj4g
Pj4gDQo+PiA+PiA+PiBNeSByZWNvbW1lbmRhdGlvbiB3b3VsZCBiZSB0byB0YWtlIGFsbCBvZiBg
cnVzdC9rZXJuZWwvdGltZWAgdW5kZXIgb25lDQo+PiA+PiA+PiBlbnRyeSBmb3Igbm93LiBJIHN1
Z2dlc3QgdGhlIGZvbGxvd2luZywgZm9sZGluZyBpbiB0aGUgaHJ0aW1lciBlbnRyeSBhcw0KPj4g
Pj4gPj4gd2VsbDoNCj4+ID4+ID4+IA0KPj4gPj4gPj4gREVMQVksIFNMRUVQLCBUSU1FS0VFUElO
RywgVElNRVJTIFtSVVNUXQ0KPj4gPj4gPj4gTToJQW5kcmVhcyBIaW5kYm9yZyA8YS5oaW5kYm9y
Z0BrZXJuZWwub3JnPg0KPj4gPj4gPiANCj4+ID4+ID4gR2l2ZW4geW91J3JlIHRoZSBvbmUgd2hv
IHdvdWxkIGhhbmRsZSB0aGUgcGF0Y2hlcywgSSB0aGluayB0aGlzIG1ha2UNCj4+ID4+ID4gbW9y
ZSBzZW5zZS4NCj4+ID4+ID4gDQo+PiA+PiA+PiBSOglCb3F1biBGZW5nIDxib3F1bi5mZW5nQGdt
YWlsLmNvbT4NCj4+ID4+ID4+IFI6CUZVSklUQSBUb21vbm9yaSA8ZnVqaXRhLnRvbW9ub3JpQGdt
YWlsLmNvbT4NCj4+ID4+ID4gDQo+PiA+PiA+IFRvbW8sIGRvZXMgdGhpcyBsb29rIGdvb2QgdG8g
eW91Pw0KPj4gPj4gDQo+PiA+PiBGaW5lIGJ5IG1lLg0KPj4gPj4gDQo+PiA+PiBTbyBhIHNpbmds
ZSBlbnRyeSBmb3IgYWxsIHRoZSBSdXN0IHRpbWUgc3R1ZmYsIHdoaWNoIGlzbid0IGFsaWduZWQN
Cj4+ID4+IHdpdGggQydzIE1BSU5UQUlORVJTIGVudHJpZXMuIEl0J3MganVzdCBmb3Igbm93Pw0K
Pj4gPj4gDQo+PiA+IA0KPj4gPiBHaXZlbiBBbmRyZWFzIGlzIHRoZSBvbmUgd2hvJ3MgZ29pbmcg
dG8gaGFuZGxlIHRoZSBQUnMsIGFuZCBoZSB3aWxsIHB1dA0KPj4gPiBhbGwgdGhlIHRoaW5ncyBp
biBvbmUgYnJhbmNoLiBJIHRoaW5rIGl0J3MgZmluZSBldmVuIGZvciBsb25nIHRlcm0sIGFuZA0K
Pj4gPiB3ZSBnb3QgYWxsIHJlbGV2YW50IHJldmlld2VycyBjb3ZlcmVkLiBJZiB0aGUgUnVzdCB0
aW1la2VlcGluZyArIGhydGltZXINCj4+ID4gY29tbXVuaXR5IGV4cGFuZHMgaW4gdGhlIGZ1dHVy
ZSwgd2UgY2FuIGFsc28gYWRkIG1vcmUgZW50cmllcy4gV2UgZG9uJ3QNCj4+ID4gbmVjZXNzYXJp
bHkgbmVlZCB0byBjb3B5IGFsbCBtYWludGFpbmVyIHN0cnVjdHVyZXMgZnJvbSBDIDstKQ0KPj4g
DQo+PiBJdCBzZWVtcyBJIHdhcyBtaXN0YWtlbi4gSSBoYWQgdGhvdWdodCB0aGF0IHRoZSBpZGVh
bCBnb2FsIHdhcyBmb3IgdGhlDQo+PiBzYW1lIHRlYW0gdG8gbWFpbnRhaW4gYm90aCB0aGUgQyBj
b2RlIGFuZCB0aGUgY29ycmVzcG9uZGluZyBSdXN0IGNvZGUuDQo+PiANCj4gDQo+IFllYWgsIHRo
YXQgd2FzIHRoZSBpZGVhbCBnb2FsLCBidXQgRnJlZGVyaWMgc2FpZCBpbiB0aGUgaHJ0aW1lciBz
ZXJpZXM6DQo+IA0KPiAJaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcnVzdC1mb3ItbGludXgvWjhp
TEl5b2Z5NktHT3NxNUBsb2NhbGhvc3QubG9jYWxkb21haW4vDQo+IA0KPiAsIHRvIG1lIGl0J3Mg
Y2xlYXIgdGhhdCBocnRpbWVyIG1haW50YWluZXJzIHdhbnQgaHJ0aW1lciBSdXN0IHBhdGNoZXMg
dG8NCj4gZ28gdG8gcnVzdCB0cmVlIHZpYSBBbmRyZWFzLCBhbmQgZ2l2ZW4gdGltZWtlZXBpbmcg
bWFpbnRhaW5lcnMgYXJlDQo+IGJhc2ljYWxseSB0aGUgc2FtZSBncm91cCBvZiBwZW9wbGUsIGFu
ZCBUaG9tYXMgZXhwbGljaXRseSBhc2tlZCB0byBiZQ0KPiBhZGRlZCBhcyByZXZpZXdlcnM6DQo+
IA0KPiAJaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcnVzdC1mb3ItbGludXgvODdvNnh1MTVtMS5m
ZnNAdGdseC8NCj4gDQo+IEl0J3MgYSBjbGVhciBzaWduYWwgdGhhdCB0aW1la2VlcGluZyBhbmQg
aHJ0aW1lciBSdXN0IHBhdGNoZXMgYXJlDQo+IHByZWZlcnJlZCB0byBnbyB0byBydXN0IHRyZWUs
IGFuZCBBbmRyZWFzIGhhZCBuaWNlbHkgYWNjZXB0ZWQgdG8gaGFuZGxlDQo+IHRpbWVrZWVwaW5n
IGFuZCBzbGVlcC9kZWxheSBwYXRjaGVzLCBzbyBpdCBtYWtlcyBzZW5zZSB0byB1c2Ugb25lIGVu
dHJ5DQo+IGlmIGhlIHByZWZlcnMuIEhvcGUgdGhpcyBjbGFyaWZpZXMgdGhpbmdzLg0KDQpZZWFo
LCBJIHNlZSB5b3VyIHBvaW50Lg0KDQo+PiA+PiA+PiBJIGFzc3VtZSBwYXRjaCAxIHdpbGwgZ28g
dGhyb3VnaCB0aGUgc2NoZWQvY29yZSB0cmVlLCBhbmQgdGhlbiBNaWd1ZWwNCj4+ID4+ID4+IGNh
biBwaWNrIDcuDQo+PiA+PiA+PiANCj4+ID4+ID4gDQo+PiA+PiA+IFBhdGNoIDEgJiA3IHByb2Jh
Ymx5IHNob3VsZCBnbyB0b2dldGhlciwgYnV0IHdlIGNhbiBkZWNpZGUgaXQgbGF0ZXIuDQo+PiA+
PiANCj4+ID4+IFNpbmNlIG5vdGhpbmcgaGFzIG1vdmVkIGZvcndhcmQgZm9yIHF1aXRlIGEgd2hp
bGUsIG1heWJlIGl0J3MgdGltZSB0bw0KPj4gPj4gZHJvcCBwYXRjaCAxLg0KPj4gPiANCj4+ID4g
Tm8sIEkgdGhpbmsgd2Ugc2hvdWxkIGtlZXAgaXQuIEJlY2F1c2Ugb3RoZXJ3aXNlIHdlIHdpbGwg
dXNlIGEgbWFjcm8NCj4+IA0KPj4gWWVhaCwgSSBrbm93LiB0aGUgZmlyc3QgdmVyc2lvbiBvZiB0
aGlzIHVzZXMgYSBtYWNyby4NCj4+IA0KPj4gDQo+PiA+IHZlcnNpb24gb2YgcmVhZF9wb2xsX3Rp
bWVvdXQoKSwgd2hpY2ggaXMgc3RyaWN0bHkgd29yc2UuIEknbSBoYXBweSB0bw0KPj4gPiBjb2xs
ZWN0IHBhdGNoICMxIGFuZCB0aGUgY3B1X3JlbGF4KCkgcGF0Y2ggb2YgcGF0Y2ggIzcsIGFuZCBz
ZW5kIGFuIFBSDQo+PiA+IHRvIHRpcC4gQ291bGQgeW91IHNwbGl0IHRoZW0gYSBiaXQ6DQo+PiA+
IA0KPj4gPiAqIE1vdmUgdGhlIFJ1c3QgbWlnaHRfc2xlZXAoKSBpbiBwYXRjaCAjNyB0byBwYXRj
aCAjMSBhbmQgcHV0IGl0IGF0DQo+PiA+ICAga2VybmVsOjp0YXNrLCBhbHNvIGlmIHdlIEVYUE9S
VF9TWU1CT0woX19taWdodF9zbGVlcF9wcmVjaXNpb24pLCB3ZQ0KPj4gPiAgIGRvbid0IG5lZWQg
dGhlIHJ1c3RfaGVscGVyIGZvciBpdC4NCj4+ID4gDQo+PiA+ICogSGF2ZSBhIHNlcGFyYXRlIGNv
bnRhaW5pbmcgdGhlIGNwdV9yZWxheCgpIGJpdC4NCj4+ID4gDQo+PiA+ICogQWxzbyB5b3UgbWF5
IHdhbnQgdG8gcHV0ICNbaW5saW5lXSBhdCBjcHVfcmVsYXgoKSBhbmQgbWlnaHRfcmVzY2hlZCgp
Lg0KPj4gPiANCj4+ID4gYW5kIHdlIGNhbiBzdGFydCBmcm9tIHRoZXJlLiBTb3VuZHMgZ29vZD8N
Cj4+IA0KPj4gSSBjYW4gZG8gd2hhdGV2ZXIgYnV0IEkgZG9uJ3QgdGhpbmsgdGhlc2UgbWF0dGVy
cy4gVGhlIHByb2JsZW0gaXMgdGhhdA0KPiANCj4gQ29uZnVzZWQuIEkgc2FpZCBJIHdvdWxkIGRv
IGEgUFIsIHRoYXQgbWVhbnMgaWYgbm8gb2JqZWN0aW9uLCB0aGUNCj4gcGF0Y2hlcyB3aWxsIGdl
dCBtZXJnZWQuIElzbid0IHRoaXMgYSB3YXkgdG8gbW92ZSBmb3J3YXJkPyBPciB5b3UncmUNCj4g
YWdhaW5zdCB0aGF0IEknbSBkb2luZyBhIFBSPw0KDQpJIGRvbid0IG9iamVjdCB0byB5b3UgZG9p
bmcgYSBQUi4NCg0KSSBtZWFudCB0aGF0IGl0J3MgdW5jbGVhciB3aGV0aGVyIHdlIGNhbiBtb3Zl
IGZvcndhcmQgd2l0aCB0aGUNCmFwcHJvYWNoLCBhcyB3ZSBoYXZlbid0IHJlY2VpdmVkIG11Y2gg
cmVzcG9uc2UgZnJvbSB0aGUgbWFpbnRhaW5lcnMNCmFuZCB3ZSBkb24ndCBrbm93IHdoYXQgdGhl
IGJsb2NrZXJzIGFyZS4NCg0KPj4gd2UgaGF2ZW4ndCByZWNlaXZlZCBhIHJlc3BvbnNlIGZyb20g
dGhlIHNjaGVkdWxlciBtYWludGFpbmVycyBmb3IgYQ0KPj4gbG9uZyB0aW1lLiBXZSBkb24ndCBl
dmVuIGtub3cgaWYgdGhlIGltcGxlbWVudGF0aW9uIGlzIGFjdHVhbGx5IGFuDQo+PiBpc3N1ZS4N
Cj4+IA0KPiANCj4gSWYgdGhlcmUncyBhbiBpc3N1ZSwgSSBjYW4gZml4IGl0LiBBZnRlciBhbGws
IHByaW50ayBjb25maXJtZWQgdGhhdA0KPiAiLipzIiBmb3JtYXQgd29ya3MgZm9yIHRoaXMgY2Fz
ZToNCj4gDQo+IAlodHRwczovL2xvcmUua2VybmVsLm9yZy9ydXN0LWZvci1saW51eC9aeXlBc2pz
ejA1QWxrT0JkQHBhdGh3YXkuc3VzZS5jei8NCj4gDQo+IGFuZCBQZXRlciBzb3J0IG9mIGNvbmZp
cm1lZCBoZSdzIG5vdCBhZ2FpbnN0IHRoZSBpZGVhOg0KPiANCj4gCWh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL3J1c3QtZm9yLWxpbnV4LzIwMjUwMjAxMTIxNjEzLkdDODI1NkBub2lzeS5wcm9ncmFt
bWluZy5raWNrcy1hc3MubmV0Lw0KPiANCj4gSSBkb24ndCBzZWUgYW55IG1ham9yIGlzc3VlIGJs
b2NraW5nIHRoaXMuIEJ1dCBvZiBjb3Vyc2UsIEknbSBoYXBweSB0bw0KPiByZXNvbHZlIGlmIHRo
ZXJlIGlzIG9uZS4NCg0KSSBrbm93IGJ1dCB0aGlzIHBhdGNoIGFkZHMgYSB3b3JrYXJvdW5kIHRv
IHRoZSBDIGNvZGUgZm9yIFJ1c3SicyBzYWtlLA0KSSB3b3VsZCB1bmRlcnN0YW5kIGlmIHRoZSBt
YWludGFpbmVycyByZWplY3QgaXQgYW5kIHByZWZlciBoYXZpbmcgUnVzdA0Kd29yayBhcm91bmQg
dGhlIGlzc3VlIGluc3RlYWQuDQoNCkFueXdheSwgbGV0J3MgdHJ5IG9uZSBtb3JlIHRpbWUuIEkn
bGwgbW9kaWZ5IHRoZSBwYXRjaCAjMSBhcyB5b3UNCnN1Z2dlc3RlZCBhbmQgc2VuZCBhIG5ldyBw
YXRjaHNldC4NCg0KDQpUaGFua3MhDQo=

