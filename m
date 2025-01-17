Return-Path: <netdev+bounces-159325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F130BA1519E
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 15:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E39A7A25B8
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 14:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEC838DD1;
	Fri, 17 Jan 2025 14:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrHBz7PS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D52C12DD8A;
	Fri, 17 Jan 2025 14:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737123627; cv=none; b=DHx/fuJcyy/Dy8Lfjwf6LsRPQkI1B9fS52QywWH/q9qfA+OIeC0+YDkuRNumXWIz3/p2mRDFCXGTMZBhoXTJ3yjkEcz00lBnA5pOmYcoDHmwWmUneKYGS/x6lLY4l2UJKXkuqmOiHFBo2yUBCdnVPRkDYukENLeaNQHNv20RSks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737123627; c=relaxed/simple;
	bh=xUz2dV2j2Y+aP48cgfhHoYZfRcg0bA3KkgkSpCybzPo=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=JMeJ1+iNGwXLM+ZMBgal9yLystaLbhC6NKKQC2DH99D293HBOnIUSS0TQFxpWp51Zjvl5JPNMbxOElixIE7326B5rqn4/4TnfuW7qzz7GVRhBqVGdgTwVjF0aOVwfdu2ryOHvhq2hTtTBlzs+Ab5b3OotGQXvsFZi0goWeZHfm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HrHBz7PS; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ef28f07dbaso3075733a91.2;
        Fri, 17 Jan 2025 06:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737123626; x=1737728426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xUz2dV2j2Y+aP48cgfhHoYZfRcg0bA3KkgkSpCybzPo=;
        b=HrHBz7PSudTyjE7lLCAJCOZOkPvGG9e0kSZctXkaauxkfK8StqoGEGPha/1QnSnJ6O
         1YD+w5TwqAfQoW5GTyfoG39wV3QTlFMmasNuEyIWm4MeTHxD7N8/niy84YhbmiEFnxsx
         y/wagWRbmZtD2MN9L70zXUG9Pm5VnY6uMiekIDPMkI35F74VQflDw/TbpkuZgZxVqoGY
         EQhczBeBTPD2nqu4wEBqy2T3OEJXL17sIo7+5iu4Nfr4ooqYX1ZRzpXM6nhqNDz8VpG0
         +m3tHm9V0Dude0okxj3/chetehb4kmtIPkP+5in2jOg8BRmDF3I/JbaRUUi6mFbvtqYD
         UJkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737123626; x=1737728426;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xUz2dV2j2Y+aP48cgfhHoYZfRcg0bA3KkgkSpCybzPo=;
        b=I1a8DqxhfPvXTAo0t1DpdrVcpe83Y3c99jup4dOB1tbre7w9vDKRovu8NksXHxFEFA
         kRsQvcKH2pP2JeSqj4YIdXkazF4Koc0hUSpcQRKYX0RLKYhwaF+sBkZuCRHLvXOB6wnM
         jgIHlADUCa3seXxeAAlNhIrNw6reO8bpRf4hJljog6dEzF4SX7ht5S8vE/P8/FHHucus
         tJOAr+nm86geUl4lgUNpy5+pS6/lKsBUFCCdGPsfgTnTR5R5MP0Ja3TmmIcrljmHHSFC
         vth28i9xDKGtedh1hyzN9aMQxcdvSFNo4GdR0wkFKLU8Vh43Hh7XMgcTzGbHDarsZVci
         aldA==
X-Forwarded-Encrypted: i=1; AJvYcCVxyqAB+NokPXOX7BtaenPCziu+zXUf43vEsZ6v1AbkPy0buCzSCgh+FGajQ80JctDbnRniKPW60htau+U=@vger.kernel.org, AJvYcCWL50EDnzaryx0DOWBsOLi1c/RovsK7k27tRFSEuwNZeheA52y8bm7IU7nWlX5lCX0kJ86XrzyK@vger.kernel.org, AJvYcCWp2p/LnIXp9Bua3rm0tAotVzd24EWsGyMgM1pl62bFRks6WuOAsL/6jhPxhq3dcvX4nnoENDdXHGuJ+AWp0eE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyae08MPQqPlKhZsCKcqA2lajviWQYpPsenfPZVPIwnRK3fDtlW
	g+zKFB8A9tl4okRDsnO+3VlS+ceVg9cEhAWTgZpm0NDjYyENGrPN
X-Gm-Gg: ASbGncvuCF02JEmv4/Uc0Z1SNddjWZ5Z8Xy9U6TkKA1vjRL5F4031FGHpagHZUtL0b7
	2KPrS8f+QCtctg0xr1srIhpicHGNwnnoCR8w49jjEYczb8DJNAStanYCWkTlEb/ygvdo4OO4sly
	kw4fV6qmBK/Wr4TcevNNVFQBXXk5AcgcgeTOthc0TEL8LBeXWdee7WAAr1fxViWwlR4MmGHXUrF
	aI72mP7tDTQCCXy4IEm1Z8pahIHx9/lyOWFNsDxYCXHGWccEGyGAQNwthA4bfuI2jJkgZUXs6yI
	Cm0Z4n/7hGKCywRrqMQVRGFoUQf9JXsELtEj+g==
X-Google-Smtp-Source: AGHT+IEO7yqo/zB0OgPavbLMcJN/J5cu+Ei4lyiJ5IXS6JinchGmbl6hiYae5rsp22/3IY0U0hBDaw==
X-Received: by 2002:a17:90b:2808:b0:2ee:bbe0:98cd with SMTP id 98e67ed59e1d1-2f782c62915mr4428238a91.7.1737123625506;
        Fri, 17 Jan 2025 06:20:25 -0800 (PST)
Received: from localhost (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d4027fcsm16442585ad.214.2025.01.17.06.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 06:20:25 -0800 (PST)
Date: Fri, 17 Jan 2025 23:20:15 +0900 (JST)
Message-Id: <20250117.232015.1047782190952648538.fujita.tomonori@gmail.com>
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
In-Reply-To: <CAH5fLghqbY4UKQ2n1XVKPtvnLfJ4ceh+2aNpVmm9WxbUTu8-GQ@mail.gmail.com>
References: <CAH5fLggUGT83saC++M-kd57bGvWj5dwAgbWZ95r+PHz_B67NLQ@mail.gmail.com>
	<20250117.185501.1171065234025373111.fujita.tomonori@gmail.com>
	<CAH5fLghqbY4UKQ2n1XVKPtvnLfJ4ceh+2aNpVmm9WxbUTu8-GQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64

T24gRnJpLCAxNyBKYW4gMjAyNSAxNDowNTo1MiArMDEwMA0KQWxpY2UgUnlobCA8YWxpY2VyeWhs
QGdvb2dsZS5jb20+IHdyb3RlOg0KDQo+IE9uIEZyaSwgSmFuIDE3LCAyMDI1IGF0IDEwOjU14oCv
QU0gRlVKSVRBIFRvbW9ub3JpDQo+IDxmdWppdGEudG9tb25vcmlAZ21haWwuY29tPiB3cm90ZToN
Cj4+DQo+PiBPbiBGcmksIDE3IEphbiAyMDI1IDEwOjEzOjA4ICswMTAwDQo+PiBBbGljZSBSeWhs
IDxhbGljZXJ5aGxAZ29vZ2xlLmNvbT4gd3JvdGU6DQo+Pg0KPj4gPiBPbiBGcmksIEphbiAxNywg
MjAyNSBhdCAxMDowMeKAr0FNIEZVSklUQSBUb21vbm9yaQ0KPj4gPiA8ZnVqaXRhLnRvbW9ub3Jp
QGdtYWlsLmNvbT4gd3JvdGU6DQo+PiA+Pg0KPj4gPj4gT24gRnJpLCAxNyBKYW4gMjAyNSAxNjo1
MzoyNiArMDkwMCAoSlNUKQ0KPj4gPj4gRlVKSVRBIFRvbW9ub3JpIDxmdWppdGEudG9tb25vcmlA
Z21haWwuY29tPiB3cm90ZToNCj4+ID4+DQo+PiA+PiA+IE9uIFRodSwgMTYgSmFuIDIwMjUgMTA6
Mjc6MDIgKzAxMDANCj4+ID4+ID4gQWxpY2UgUnlobCA8YWxpY2VyeWhsQGdvb2dsZS5jb20+IHdy
b3RlOg0KPj4gPj4gPg0KPj4gPj4gPj4+ICsvLy8gVGhpcyBmdW5jdGlvbiBjYW4gb25seSBiZSB1
c2VkIGluIGEgbm9uYXRvbWljIGNvbnRleHQuDQo+PiA+PiA+Pj4gK3B1YiBmbiBmc2xlZXAoZGVs
dGE6IERlbHRhKSB7DQo+PiA+PiA+Pj4gKyAgICAvLyBUaGUgYXJndW1lbnQgb2YgZnNsZWVwIGlz
IGFuIHVuc2lnbmVkIGxvbmcsIDMyLWJpdCBvbiAzMi1iaXQgYXJjaGl0ZWN0dXJlcy4NCj4+ID4+
ID4+PiArICAgIC8vIENvbnNpZGVyaW5nIHRoYXQgZnNsZWVwIHJvdW5kcyB1cCB0aGUgZHVyYXRp
b24gdG8gdGhlIG5lYXJlc3QgbWlsbGlzZWNvbmQsDQo+PiA+PiA+Pj4gKyAgICAvLyBzZXQgdGhl
IG1heGltdW0gdmFsdWUgdG8gdTMyOjpNQVggLyAyIG1pY3Jvc2Vjb25kcy4NCj4+ID4+ID4+PiAr
ICAgIGNvbnN0IE1BWF9EVVJBVElPTjogRGVsdGEgPSBEZWx0YTo6ZnJvbV9taWNyb3ModTMyOjpN
QVggYXMgaTY0ID4+IDEpOw0KPj4gPj4gPj4NCj4+ID4+ID4+IEhtbSwgaXMgdGhpcyB2YWx1ZSBj
b3JyZWN0IG9uIDY0LWJpdCBwbGF0Zm9ybXM/DQo+PiA+PiA+DQo+PiA+PiA+IFlvdSBtZWFudCB0
aGF0IHRoZSBtYXhpbXVtIGNhbiBiZSBsb25nZXIgb24gNjQtYml0IHBsYXRmb3Jtcz8gMjE0NzQ4
NA0KPj4gPj4gPiBtaWxsaXNlY29uZHMgaXMgbG9uZyBlbm91Z2ggZm9yIGZzbGVlcCdzIGR1cmF0
aW9uPw0KPj4gPj4gPg0KPj4gPj4gPiBJZiB5b3UgcHJlZmVyLCBJIHVzZSBkaWZmZXJlbnQgbWF4
aW11bSBkdXJhdGlvbnMgZm9yIDY0LWJpdCBhbmQgMzItYml0DQo+PiA+PiA+IHBsYXRmb3Jtcywg
cmVzcGVjdGl2ZWx5Lg0KPj4gPj4NCj4+ID4+IEhvdyBhYm91dCB0aGUgZm9sbG93aW5nPw0KPj4g
Pj4NCj4+ID4+IGNvbnN0IE1BWF9EVVJBVElPTjogRGVsdGEgPSBEZWx0YTo6ZnJvbV9taWNyb3Mo
dXNpemU6Ok1BWCBhcyBpNjQgPj4gMSk7DQo+PiA+DQo+PiA+IFdoeSBpcyB0aGVyZSBhIG1heGlt
dW0gaW4gdGhlIGZpcnN0IHBsYWNlPyBBcmUgeW91IHdvcnJpZWQgYWJvdXQNCj4+ID4gb3ZlcmZs
b3cgb24gdGhlIEMgc2lkZT8NCj4+DQo+PiBZZWFoLCBCb3F1biBpcyBjb25jZXJuZWQgdGhhdCBh
biBpbmNvcnJlY3QgaW5wdXQgKGEgbmVnYXRpdmUgdmFsdWUgb3INCj4+IGFuIG92ZXJmbG93IG9u
IHRoZSBDIHNpZGUpIGxlYWRzIHRvIHVuaW50ZW50aW9uYWwgaW5maW5pdGUgc2xlZXA6DQo+Pg0K
Pj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC9aeHdWdWNlTk9SUkFJN0ZWQEJvcXVucy1N
YWMtbWluaS5sb2NhbC8NCj4gDQo+IE9rYXksIGNhbiB5b3UgZXhwbGFpbiBpbiB0aGUgY29tbWVu
dCB0aGF0IHRoaXMgbWF4aW11bSB2YWx1ZSBwcmV2ZW50cw0KPiBpbnRlZ2VyIG92ZXJmbG93IGlu
c2lkZSBmc2xlZXA/DQoNClN1cmVseSwgaG93IGFib3V0IHRoZSBmb2xsb3dpbmc/DQoNCnB1YiBm
biBmc2xlZXAoZGVsdGE6IERlbHRhKSB7DQogICAgLy8gVGhlIGFyZ3VtZW50IG9mIGZzbGVlcCBp
cyBhbiB1bnNpZ25lZCBsb25nLCAzMi1iaXQgb24gMzItYml0IGFyY2hpdGVjdHVyZXMuDQogICAg
Ly8gQ29uc2lkZXJpbmcgdGhhdCBmc2xlZXAgcm91bmRzIHVwIHRoZSBkdXJhdGlvbiB0byB0aGUg
bmVhcmVzdCBtaWxsaXNlY29uZCwNCiAgICAvLyBzZXQgdGhlIG1heGltdW0gdmFsdWUgdG8gdTMy
OjpNQVggLyAyIG1pY3Jvc2Vjb25kcyB0byBwcmV2ZW50IGludGVnZXINCiAgICAvLyBvdmVyZmxv
dyBpbnNpZGUgZnNsZWVwLCB3aGljaCBjb3VsZCBsZWFkIHRvIHVuaW50ZW50aW9uYWwgaW5maW5p
dGUgc2xlZXAuDQogICAgY29uc3QgTUFYX0RVUkFUSU9OOiBEZWx0YSA9IERlbHRhOjpmcm9tX21p
Y3Jvcyh1MzI6Ok1BWCBhcyBpNjQgPj4gMSk7DQo=

