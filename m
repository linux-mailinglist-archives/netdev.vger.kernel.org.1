Return-Path: <netdev+bounces-131240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE8398D86C
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 16:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5157D1C22CF1
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 14:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6921D0DC0;
	Wed,  2 Oct 2024 13:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7Oh1SsK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6179E1D07B8;
	Wed,  2 Oct 2024 13:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877528; cv=none; b=q1/hE7l/NBZLFOPbEheggS6nR9p/4O0VlY1Yp0Uz00gsDa5lNn2iwpb2ByfWLPoRI3xdc+DHCzUZMPEMia8ZpZmXqCBGOkDo/+eM0wPEyi5JL42cTI/onUKzdilEt8T9NMndITmIpMIXmmuM7Rx7MO83JCn60y9UAjGeZh4s4k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877528; c=relaxed/simple;
	bh=PA6phir3Xc8NxWae90079kFO3rn9KZfk0qid5Ia4qzs=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hfnLm4UlmRzHvhCCnyGxwRl73WK/tHFHmzmxMLEyxSIngNqtfexvbw+kAfYzkGjVvrGLnu/RTCd2JZ1gkbti7fmkmQlqPSSnFm/LNQPt/9/XZq1btwLahgUbFntXcy4ypCwFJPayQ6x7X1bavclFZcrg5CaUpMIywN9qGdo1sz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A7Oh1SsK; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71b8d10e9b3so4046389b3a.3;
        Wed, 02 Oct 2024 06:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727877527; x=1728482327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PA6phir3Xc8NxWae90079kFO3rn9KZfk0qid5Ia4qzs=;
        b=A7Oh1SsKpYBh7FlAI2cz1/c1yJ6IsMieCcdtHEAtZWQbIi0e7olq4vkvKP5cu0uLYs
         TbvcIVStDV+ruIKwB35yqMyAkI6XkOWY0brcLEQmVT2WRDT/yugXopj0oIe6lrLCTOvO
         kUsJ4ZvBxJuknMc4jqqsY0zRyUPMi9moNaztQRXtdslIEd3+2RsifbBBAuZnechFIwW/
         6DuiKN3D2euwfst1NKy7Ev123eO+RptSXjH+xGHu9LIMxnq6s0d1lboRw5cRx+uVbuxN
         xAE3wAMh6IU9hcCOR+aFq4CmSlxactkSz5LKZDt/D0v3xIyuH67GX+NKILdi/Flhtaex
         yRPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727877527; x=1728482327;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PA6phir3Xc8NxWae90079kFO3rn9KZfk0qid5Ia4qzs=;
        b=sJwKVi7oyMGWCc7hSArFlhCrBRjtaWG8raAEoOCBlSjm34ovi/67bfMFVvP9uQrpaa
         ArQlzQYpXeVB8Gp0aNRHSsjpW4Ymf9ouYxX4Uny+LIuJWQpPfq9UOgD5GgWNbWRVjVbg
         GqknKMQLM75zt7KCkQRBjB79dGBOspzC/6acvyxFYetuGMa4V+fNhRbeqbgclD7pvtDh
         yH0ELfWVZWt/b9ASaEVBR+r9G1TuailSmKZV3iTkCclfl+P24mK5wEVp4kbvwdtOdJcI
         T2lrru/ySexOvW04mCkxRcCR1nd8nzLuXfTyPQjzxBXOzzUMrA3d6Fse+xp22ItthXDN
         BM1Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/1ikn1lub13a019iKVap14+o+NZuRFaZpENkZpEw3h0VvAKr849qfLP1cVXsgvAsxtlsWePez31M/5UVh6C0=@vger.kernel.org, AJvYcCXPPS3zbavPm3xrQvXSRgp3dci+f0I9svtbZp1jBuQGNFq7PGTx+n+cEByEDIx0bXpmh0yYiqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZv/GAFkvfXjXSisCsd3TTpIpnBFi3q+wXxP7QJ0ZDqTLIqGsk
	deCrNEAKqjZKz1l2k4e7UClAiEq1eHFBS25yHgXwaXv58R7eQeDm
X-Google-Smtp-Source: AGHT+IGYx9wJKUk9OGIB3RfWzPdQTdIQTGbwL64R2h9wiFCeEnDNx9d0F1HSIlLEaXQN/f+h35F0WQ==
X-Received: by 2002:a05:6a00:391b:b0:717:925a:299a with SMTP id d2e1a72fcca58-71dc5d543e6mr5075445b3a.19.1727877526564;
        Wed, 02 Oct 2024 06:58:46 -0700 (PDT)
Received: from localhost (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26515eeesm9778310b3a.130.2024.10.02.06.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 06:58:46 -0700 (PDT)
Date: Wed, 02 Oct 2024 13:58:32 +0000 (UTC)
Message-Id: <20241002.135832.841519218420629933.fujita.tomonori@gmail.com>
To: aliceryhl@google.com
Cc: andrew@lunn.ch, fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, hkallweit1@gmail.com, tmgross@umich.edu,
 ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com
Subject: Re: [PATCH net-next v1 1/2] rust: add delay abstraction
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CAH5fLgiB_3v6rVEWCNVVma=vPFAse-WvvCzHKrjHKTDBwjPz2Q@mail.gmail.com>
References: <20241002.113401.1308475311422708175.fujita.tomonori@gmail.com>
	<e048a4cc-b4e9-4780-83b2-a39ede65f978@lunn.ch>
	<CAH5fLgiB_3v6rVEWCNVVma=vPFAse-WvvCzHKrjHKTDBwjPz2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64

T24gV2VkLCAyIE9jdCAyMDI0IDE0OjM3OjU1ICswMjAwDQpBbGljZSBSeWhsIDxhbGljZXJ5aGxA
Z29vZ2xlLmNvbT4gd3JvdGU6DQoNCj4gT24gV2VkLCBPY3QgMiwgMjAyNCBhdCAyOjE54oCvUE0g
QW5kcmV3IEx1bm4gPGFuZHJld0BsdW5uLmNoPiB3cm90ZToNCj4+DQo+PiA+ID4gSSB3b3VsZCBh
bHNvIGRvY3VtZW50IHRoZSB1bml0cyBmb3IgdGhlIHBhcmFtZXRlci4gSXMgaXQgcGljb3NlY29u
ZHMNCj4+ID4gPiBvciBjZW50dXJpZXM/DQo+PiA+DQo+PiA+IFJ1c3QncyBEdXJhdGlvbiBpcyBj
cmVhdGVkIGZyb20gc2Vjb25kcyBhbmQgbmFub3NlY29uZHMuDQo+Pg0KPj4gSG93IHdlbGwga25v
dyBpcyB0aGF0PyBBbmQgaXMgdGhlcmUgYSBydXN0LWZvci1saW51eCB3aWRlIHByZWZlcmVuY2UN
Cj4+IHRvIHVzZSBEdXJhdGlvbiBmb3IgdGltZT8gQXJlIHdlIGdvaW5nIHRvIGdldCBpbnRvIGEg
c2l0dWF0aW9uIHRoYXQNCj4+IHNvbWUgYWJzdHJhY3Rpb25zIHVzZSBEdXJhdGlvbiwgb3RoZXJz
IHNlY29uZHMsIHNvbWUgbWlsbGlzZWNvbmRzLA0KPj4gZXRjLCBqdXN0IGxpa2UgQyBjb2RlPw0K
Pj4NCj4+IEFueXdheSwgaSB3b3VsZCBzdGlsbCBkb2N1bWVudCB0aGUgcGFyYW1ldGVyIGlzIGEg
RHVyYXRpb24sIHNpbmNlIGl0DQo+PiBpcyBkaWZmZXJlbnQgdG8gaG93IEMgZnNsZWVwKCkgd29y
a3MuDQo+IA0KPiBJJ20gbm90IG5lY2Vzc2FyaWx5IGNvbnZpbmNlZCB3ZSB3YW50IHRvIHVzZSB0
aGUgUnVzdCBEdXJhdGlvbiB0eXBlLg0KPiBTaW1pbGFyIHF1ZXN0aW9ucyBjYW1lIHVwIHdoZW4g
SSBhZGRlZCB0aGUgS3RpbWUgdHlwZS4gVGhlIFJ1c3QNCj4gRHVyYXRpb24gdHlwZSBpcyByYXRo
ZXIgbGFyZ2UuDQoNCmNvcmU6Om1lbTo6c2l6ZV9vZjo6PGNvcmU6OnRpbWU6OkR1cmF0aW9uPigp
IHNheXMgMTYgYnl0ZXMuDQoNCllvdSBwcmVmZXIgdG8gYWRkIGEgc2ltcGxlciBEdXJhdGlvbiBz
dHJ1Y3R1cmUgdG8ga2VybmVsL3RpbWUucnM/DQpTb21ldGhpbmcgbGlrZToNCg0Kc3RydWN0IER1
cmF0aW9uIHsNCiAgICBuYW5vczogdTY0LA0KfQ0KDQp1NjQgaW4gbmFub3NlY29uZHMgaXMgZW5v
dWdoIGZvciBkZWxheSBpbiB0aGUga2VybmVsLCBJIHRoaW5rLg0KDQoNCmJ0dywgY29yZTo6dGlt
ZTo6RHVyYXRpb246Om5ldygpIGNvdWxkIHBhbmljIGlmIGEgZHJpdmVyIGRvZXMNCnNvbWV0aGlu
ZyBzdHVwaWQ7IGZvciBleGFtcGxlLA0KDQpsZXQgZCA9IGNvcmU6OnRpbWU6OkR1cmF0aW9uOjpu
ZXcodTY0OjpNQVgsIDFfMDAwXzAwMF8wMDApOw0KDQpJcyB0aGlzIGFjY2VwdGFibGU/DQoNCg==

