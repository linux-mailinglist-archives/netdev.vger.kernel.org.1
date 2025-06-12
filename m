Return-Path: <netdev+bounces-196764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BE3AD64BD
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 02:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79FA01BC3A37
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 00:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A53F53365;
	Thu, 12 Jun 2025 00:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpQiVKQD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35EA8BE8;
	Thu, 12 Jun 2025 00:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749689300; cv=none; b=pC5a0mlBie33GeWbIf3lUctklDFJp2e5W/t1nAUdCkaoWbz97GkEQ2UIVCNeM3z5tQcv41BfcEM5V2EVZy4xJgyqPw7XLf8fWbZlf8zwHFQakGGw2p4EFcNiXYH3114DnUINQ0ATkQ4T0fhoHmmBXVLOTe9js+ZkZYZztoQAr1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749689300; c=relaxed/simple;
	bh=3d2nv4mQzWVieMmhZJFf9T1T8JQ4ZqqR9dLmZQor5y0=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=RC+X3HtzJN8WiKc5dPVWkJ0FPSuwUW3jYUoQdAJ8rNKYKfNJU4RRWaCyDeSsnj1OIkmXQAK5j+5vyTQVIxI9w7s/gGjwZmjtjedY6UI818o7Yj6N/gxdKHrsg2U9nZRm+OY9JphEQLqeSgngnhCTQKNg0LhyXs1M2KxyKR8knpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NpQiVKQD; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7fd35b301bdso361747a12.2;
        Wed, 11 Jun 2025 17:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749689298; x=1750294098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3d2nv4mQzWVieMmhZJFf9T1T8JQ4ZqqR9dLmZQor5y0=;
        b=NpQiVKQDyfy/PLdFrLtHe5NAn8PTX/AuOT8bF+v7SgPeDJv5KudlkXvKAiobQXa2sx
         jX41zYmce+v6/ZL8U1Oi9Gurozv+muxiseZdXgBNELAJ3+ILmGo3mpJ5AfCfgmvZLf6S
         k2mBc6Ae9Mzk6huho+eAZKy+P3B/hNzYgG+IKhHfy+W5r5WFXhGMNL+GRD5tO4WNMiMZ
         slpWR8/LMCe2WFo4W30CMaqoud7/OYeWCEpVw1t13+xw7NO3Sl7MrqjHXTe6Eme7dEt2
         orFCGcPpzLjwXIgofH4Wl017mm4+6esBWShnYiDxwZlSoIzbzz/udZxjclEVXJ1wi96U
         C7Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749689298; x=1750294098;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3d2nv4mQzWVieMmhZJFf9T1T8JQ4ZqqR9dLmZQor5y0=;
        b=OIBYK+eXGS+RKwDXbhqcS7kK5aLypNlv0dPXqHfwzg/0PNnf6FlgkKRpxnhdGsdpme
         4T9EaW/VCFmmhi8TDoEUA7+O6xS//fTx045ILPTFVie9LZngxP7imQdRR8julglwoqP+
         v5rkesCSgQoEH/2I+/lseEj/8M3JcU2YVftQsUAyAU6h9/VxYkmZZSQwzsqvQTAJBxI/
         vfOoJFYGF92uqKMQ/LbPbP8x6CecZ1irnzJeomkxhuciLGbJ0awQvPdWPUn4qbf5DK6S
         vjqnjYw6/u611UOHJjqySrLOCqgKgjFTAmXUdiRdf5fzvwsXM2ewzuiFKtfahSGKS8Lr
         IK9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUarx6cp+fSk4d0nOG8xKklxWWgcQ8/5yAsYfpds4Zc/upVjVoSAeFLlR8U2T1Taga3zieAMNVe@vger.kernel.org, AJvYcCUmRvp4zKTlRP/mJ3wnGjqLGpnkTm9U2nf2J+0gF5MYrZ7LSUOGS9AgofJn/St9+a1S4/pqDJmzcwhBd+4gjYU=@vger.kernel.org, AJvYcCVhB5KQ2ojX4f6vKt8PMx23Nk5Q68CCnqEc8LACcZwdOGIU5ybkiOxpR+6/TiB2OpG4NxlLRg88pSwm9X0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4xZ1e3gPWaPlEKhbJvpth3fWW7ECIKEKStfFsQGd5RA4ix7gW
	WTRkkmfkWjUf+f6FaFWRzVd/1RS0q1J1xny7C2Db8yV8dU1tCOkM+fIyHo/bKgnD
X-Gm-Gg: ASbGncvZei7MEAAbFq/9Ddb4pQQ61E2I2gXKDYZp/x5UcOatqALAnC0iPQTIqmHEf41
	7k/Ul+DrtJuiWn/OxpxmYGMwRV/eduMJc3gKHEvOyCbIl1PM9PBxVwPKY9QUxhoqviFQZbXu6hx
	1VPizAk90QWjVP9kGqfF9UZgjecXKxMg53QvGer2g9X3S0Tq8JZoW8ojR3TZnucQTOQm2xw6xRt
	TZdMuOYSbWL1oBin9jLFmXHpwX5dSvnOjgIDR4G4wW+5xeYQDtfO823eOlcG6L0TdNE0WWUIKCP
	ERhCTL2c7oOygekldGoXhhaqcKv9WWnIfv5qdD245Oi74TaZLrg3movp50Z1WXCN9pFRHWCFRqF
	WlK2XIJOMX08Lq9bSHTgXSMaNwqBePa21L7zJeSI4
X-Google-Smtp-Source: AGHT+IG48Dss+KMa32YKb1Yc3+atTL+EItxUQqwsQHXnKCXv/vuFdpbPbpSc9wX8C8WDQ4IsuVkX2w==
X-Received: by 2002:a17:902:d488:b0:234:d778:13fa with SMTP id d9443c01a7336-2364ca46910mr20702875ad.26.1749689297911;
        Wed, 11 Jun 2025 17:48:17 -0700 (PDT)
Received: from localhost (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2364e6f9878sm1911455ad.151.2025.06.11.17.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 17:48:17 -0700 (PDT)
Date: Thu, 12 Jun 2025 09:48:05 +0900 (JST)
Message-Id: <20250612.094805.256395171864740471.fujita.tomonori@gmail.com>
To: tamird@gmail.com
Cc: aliceryhl@google.com, fujita.tomonori@gmail.com, tmgross@umich.edu,
 ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, dakr@kernel.org, davem@davemloft.net,
 andrew@lunn.ch, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: cast to the proper type
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CAJ-ks9m837aTYsS9Qd8bC0_abE_GT9TZUDZbbPnpyOtgrF9Ehw@mail.gmail.com>
References: <20250611-correct-type-cast-v1-1-06c1cf970727@gmail.com>
	<CAH5fLghomO3znaj14ZSR9FeJSTAtJhLjR=fNdmSQ0MJdO+NfjQ@mail.gmail.com>
	<CAJ-ks9m837aTYsS9Qd8bC0_abE_GT9TZUDZbbPnpyOtgrF9Ehw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64

T24gV2VkLCAxMSBKdW4gMjAyNSAwOTozMDo0NiAtMDQwMA0KVGFtaXIgRHViZXJzdGVpbiA8dGFt
aXJkQGdtYWlsLmNvbT4gd3JvdGU6DQoNCj4gT24gV2VkLCBKdW4gMTEsIDIwMjUgYXQgNzo0MuKA
r0FNIEFsaWNlIFJ5aGwgPGFsaWNlcnlobEBnb29nbGUuY29tPiB3cm90ZToNCj4+DQo+PiBPbiBX
ZWQsIEp1biAxMSwgMjAyNSBhdCAxMjoyOOKAr1BNIFRhbWlyIER1YmVyc3RlaW4gPHRhbWlyZEBn
bWFpbC5jb20+IHdyb3RlOg0KPj4gPg0KPj4gPiBVc2UgdGhlIGZmaSB0eXBlIHJhdGhlciB0aGFu
IHRoZSByZXNvbHZlZCB1bmRlcmx5aW5nIHR5cGUuDQo+PiA+DQo+PiA+IEZpeGVzOiBmMjBmZDU0
NDlhZGEgKCJydXN0OiBjb3JlIGFic3RyYWN0aW9ucyBmb3IgbmV0d29yayBQSFkgZHJpdmVycyIp
DQo+Pg0KPj4gRG9lcyB0aGlzIG5lZWQgdG8gYmUgYmFja3BvcnRlZD8gSWYgbm90LCBJIHdvdWxk
bid0IGluY2x1ZGUgYSBGaXhlcyB0YWcuDQo+IA0KPiBJJ20gZmluZSB3aXRoIG9taXR0aW5nIGl0
LiBJIHdhbnRlZCB0byBsZWF2ZSBhIGJyZWFkY3J1bWIgdG8gdGhlDQo+IGNvbW1pdCB0aGF0IGlu
dHJvZHVjZWQgdGhlIGN1cnJlbnQgY29kZS4NCg0KSSBhbHNvIGRvbid0IHRoaW5rIHRoaXMgdGFn
IGlzIG5lY2Vzc2FyeSBiZWNhdXNlIHRoaXMgaXMgbm90IGEgYnVnDQpmaXguIEFuZCBzaW5jZSB0
aGlzIHRhZyBwb2ludHMgdG8gdGhlIGZpbGUncyBpbml0aWFsIGNvbW1pdCwgSSBkb24ndA0KdGhp
bmsgaXQncyBwYXJ0aWN1bGFybHkgdXNlZnVsLg0K

