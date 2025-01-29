Return-Path: <netdev+bounces-161440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B60A21711
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 05:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC2F71654C4
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 04:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453F218C34B;
	Wed, 29 Jan 2025 04:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fywsztGn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F77911713;
	Wed, 29 Jan 2025 04:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738125660; cv=none; b=LF7Zbwd/HnGeY7yJgpgc0F17NTtUpdJ0bE4UBDC2W/laZ5sNOWJCdPJBGZ1qJ4BJBLsvM9/TcLq383LO8t662A3L3p2klWE9kVo5ahkfdgePrYmnfBmM3ayEJOM3BFGge5uaWysbtBMr7X2EdTQk1laEyjJE3YW7W6bqpAtjp9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738125660; c=relaxed/simple;
	bh=9hTWDT5tZoN7IJSXd2veTIW6OeAiotyAwa+Dmp9KGB8=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=RZZrTclpFCjX9t9Uc/LpirVNqYBK78CjvIZUpsNAQnAL0HGAqO0pTjVwi+M4Ogj6gITRRTlHCfvw69z0OQ+Jop3MdYgLmjQzMjGbDszijFt0sEWMqk5CuHU+riWI9lcPyLN4w2vBy+qanIO/0HJj/gFhV5pNjW9QyAYEcaO8C80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fywsztGn; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2161eb94cceso77084685ad.2;
        Tue, 28 Jan 2025 20:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738125657; x=1738730457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9hTWDT5tZoN7IJSXd2veTIW6OeAiotyAwa+Dmp9KGB8=;
        b=fywsztGnm/5llirySM4ES65mFC5DFZqOgvtB+EUWzBpvRA5FCxP+xB3yvsuufaLuRx
         6Hjd0YXIttjghVB+9c1zTCJWHziO5uy332mSEk6UcJhT9q8EJF0XguYXpU0fzCd75FVy
         y2gsAvTNSgISMqJ8cEEtSYiXpqc5P4+/eKUjbVLzThNBoHHZle2Sl+6OIFQypD9by8Wp
         ollqIi8f5NlsINwn/15rFMNNmYbMvHscPpFVnCo2mBB0WskJXheKqlsXdfppsTRhrCCp
         eD9U17ksIuUCwosgW8tmO65ILkrNY8vGhaQ+PS5V3bruQBmhMVs5FQ9jxTc8wbT9OPX8
         kY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738125657; x=1738730457;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9hTWDT5tZoN7IJSXd2veTIW6OeAiotyAwa+Dmp9KGB8=;
        b=Di1F6jnLrE5Utj7jyDyDnx+qVOwFWaB0xlUsYyYy4+gUW9hwLILCbJINO69EEExCie
         8rPlARe/hVDzQic9qfOwoznuYGLSYpeeN8QaYaB7Ea2I2fKJl4aljkXd3pUj5ESOF4h3
         8vJJHNeQmMATH38XM5+RFqldojxte+fN9BlXKSKvIBb28AerXykC3rGunbSBzINpW8zI
         P8qTT5tzFIlWTXtwdYhIx8yOzSYlPwY7zJg8GCJGTynXA2T1YHerDwhtG14afMvx5AoO
         2uHWDM+GPhktzM0RKYOlMQaHhYelSChH1wFQ/QWJdGLw1U4QuEiGYGX8NtXGkH53oZc9
         l7Zg==
X-Forwarded-Encrypted: i=1; AJvYcCUp8bpVJ/GUuATbshSADLCpgIFKot9mSyvMhPCvulxa9LsIDzbCnII8swP7waZEiFbvjw4HDgoTl3HFDPUt5tI=@vger.kernel.org, AJvYcCW77q4Ocblx5x0neHyU8HURPruRS0vrjs+9Iopuf1xotqF9whaWfy6k8UgWm7jXN9Rt7E3ilWcQ@vger.kernel.org, AJvYcCX3po9F75y/4wMfgUYwogTOmYXQqA/8tYNunwdU/2D3W4ZwDljw0B5KDMuBxv9J5DgUUgI9SCmN7sZ/nik=@vger.kernel.org
X-Gm-Message-State: AOJu0YzljqStFUkIT935+brU4jPCSeUjdqE4cu0KnKdnIctrh+p9LplW
	GC3/R7ehkRpblhPkFHtbObgU3VIBq1hwVtKgRS+VRIDmNmdVdI8U
X-Gm-Gg: ASbGncvyPxpxhc04msBvJjML4FagP1P+vO7V34QHYXXGLtRJuEzJgOgf9/AVmDRxH/0
	+rYWaaVnECyTVf1t8lvRWHaXUL0b/Q5b+FvzjFL9St8qAmsbx4B06pSL6xExWe3zPKjV/geo2Zf
	vKJFqzRdgtmOqVnQ8QA4Hb0kkOeu4swHhkV9i6WC8mdtVHBjBM0gGJOI5ovzD2esD0jHbgAgcm/
	hCOsED54qDDfMSO5y8FFgT3N+1XOCOmB4ZkLcJuSN5wywiWk6AxUkSNZZRkPEI9JC0Y3xSx1K6w
	89pg3zNBatm+en+9B3hNnUGp6hAH+ae+YYJ5biA54+mtq5UpCr75Fgut9s8G8FEq/RyZPO2t
X-Google-Smtp-Source: AGHT+IFXnX9BcuFhpIKUpiigcWp3gCrFBdezgQCqcE9OlA+W+SpKCBufXESy8+jfPYKBU/e3ww0TEQ==
X-Received: by 2002:a17:903:41c6:b0:21a:8300:b9ce with SMTP id d9443c01a7336-21dd7e35fc3mr25280075ad.49.1738125657484;
        Tue, 28 Jan 2025 20:40:57 -0800 (PST)
Received: from localhost (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da414116asm90744045ad.129.2025.01.28.20.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 20:40:56 -0800 (PST)
Date: Wed, 29 Jan 2025 13:40:47 +0900 (JST)
Message-Id: <20250129.134047.2031182530235091102.fujita.tomonori@gmail.com>
To: me@kloenk.dev
Cc: fujita.tomonori@gmail.com, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
 alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com,
 anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
 arnd@arndb.de, jstultz@google.com, sboyd@kernel.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, tgunders@redhat.com
Subject: Re: [PATCH v9 7/8] rust: Add read_poll_timeout functions
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <C466653B-D8DA-4176-8059-7FD60F76040E@kloenk.dev>
References: <20250125101854.112261-1-fujita.tomonori@gmail.com>
	<20250125101854.112261-8-fujita.tomonori@gmail.com>
	<C466653B-D8DA-4176-8059-7FD60F76040E@kloenk.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64

T24gVHVlLCAyOCBKYW4gMjAyNSAxMTo1Mjo0MiArMDEwMA0KRmlvbmEgQmVocmVucyA8bWVAa2xv
ZW5rLmRldj4gd3JvdGU6DQoNCj4+IGRpZmYgLS1naXQgYS9ydXN0L2tlcm5lbC9pby9wb2xsLnJz
IGIvcnVzdC9rZXJuZWwvaW8vcG9sbC5ycw0KPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+IGlu
ZGV4IDAwMDAwMDAwMDAwMC4uN2E1MDNjZjY0M2ExDQo+PiAtLS0gL2Rldi9udWxsDQo+PiArKysg
Yi9ydXN0L2tlcm5lbC9pby9wb2xsLnJzDQo+PiBAQCAtMCwwICsxLDc5IEBADQo+PiArLy8gU1BE
WC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCj4+ICsNCj4+ICsvLyEgSU8gcG9sbGluZy4N
Cj4+ICsvLyENCj4+ICsvLyEgQyBoZWFkZXI6IFtgaW5jbHVkZS9saW51eC9pb3BvbGwuaGBdKHNy
Y3RyZWUvaW5jbHVkZS9saW51eC9pb3BvbGwuaCkuDQo+PiArDQo+PiArdXNlIGNyYXRlOjp7DQo+
PiArICAgIGNwdTo6Y3B1X3JlbGF4LA0KPj4gKyAgICBlcnJvcjo6e2NvZGU6OiosIFJlc3VsdH0s
DQo+PiArICAgIHRpbWU6OntkZWxheTo6ZnNsZWVwLCBEZWx0YSwgSW5zdGFudH0sDQo+PiArfTsN
Cj4+ICsNCj4+ICt1c2UgY29yZTo6cGFuaWM6OkxvY2F0aW9uOw0KPj4gKw0KPj4gKy8vLyBQb2xs
cyBwZXJpb2RpY2FsbHkgdW50aWwgYSBjb25kaXRpb24gaXMgbWV0IG9yIGEgdGltZW91dCBpcyBy
ZWFjaGVkLg0KPj4gKy8vLw0KPj4gKy8vLyBQdWJsaWMgYnV0IGhpZGRlbiBzaW5jZSBpdCBzaG91
bGQgb25seSBiZSB1c2VkIGZyb20gcHVibGljIG1hY3Jvcy4NCj4gDQo+IFRoaXMgc3RhdGVzIHRo
ZSBmdW5jdGlvbiBzaG91bGQgYmUgaGlkZGVuLCBidXQgSSBkb26idCBzZWUgYSBgI1tkb2MoaGlk
ZGVuKV1gIGluIGhlcmUgc28gYml0IGNvbmZ1c2VkIGJ5IHRoYXQgY29tbWVudCB3aGF0IHBhcnQg
bm93IGlzIGhpZGRlbi4NCg0KT29wcywgdGhpcyBjb21tZW50IGlzIHRoZSBvbGRlciBpbXBsZW1l
bnRhdGlvbjsgaXQgc2hvdWxkIGhhdmUgYmVlbg0KZGVsZXRlZC4gSSdsbCBmaXguDQoNCg0K

