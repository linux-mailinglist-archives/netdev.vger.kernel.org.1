Return-Path: <netdev+bounces-138096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D267D9ABF53
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 08:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 011A51C21043
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 06:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B1014A4DE;
	Wed, 23 Oct 2024 06:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8SiSCNT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC3D6EB7C;
	Wed, 23 Oct 2024 06:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729666277; cv=none; b=NA60wFYmh56kU1F52CO2Pf0eMWnA5mwilYMgUe2sYl6CKrxuLVdjmYTxPO09f+z7CZndJgg0+sucXjquAh+37BpIfprMa5/gr2AQmuESJ/r2PWgaOy/aMG2fr9+mcqIDh726tz9LXhK0YDBClGN31GUQczHaap5htM1yMCocK6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729666277; c=relaxed/simple;
	bh=a5NPOHYXJWnn4NRrfvag4sML1n98wd6c6laDJ/tv1ds=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=aG4gnzJfx1rRn2rgEH4Qg9LlpHPnXPs1k+FyQG9oAqEPJmYBk8VhFywYO1dCitkff0ppQzc1X+LKHOMNDYMzeVGODpZRCaS7eDmXyoYqdndaDvdXg2zF7kem4aRNQ8syKWRujrKEXHJ44grZo9TgDcX29FjAzx7JG04sVH8LLV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8SiSCNT; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20cdb889222so62547485ad.3;
        Tue, 22 Oct 2024 23:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729666275; x=1730271075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a5NPOHYXJWnn4NRrfvag4sML1n98wd6c6laDJ/tv1ds=;
        b=H8SiSCNTq2n+63atx2aM8SpfB3O++vS1ilfRCNqK3ulpXeRKoZKv7JwNSrE+ISMNwR
         OyHCaYxjJ0uwpnnHMMtt5DA8bErsCfP5Em/E89nRC9/0nT03WUt8T7Fvc/8kxFmeJC9Y
         O3bclDMo8feHkwyG1nlFjT0wSFkt4bcwhdDFQHhREtn+DEWGOGFUiJoINX6Fhpq1QNbl
         KyDyEZP5AIAO6e3cVl5Qb/tyCT25yA4h2x/4zHaGmMvtQqa9moIpIUYo+6QtGrT4UfId
         BJgpkfUbaF3FeH49gPmbQ6u60mrd7D+7ogrlc2mX1xj8kpxfZRBQr+z4S5H2hj9PJnWt
         qWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729666275; x=1730271075;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a5NPOHYXJWnn4NRrfvag4sML1n98wd6c6laDJ/tv1ds=;
        b=cbWgypFeSHafvBIysDLqkQfSFcgNXOlT6Iag2/Sbql5rh6FpQDs8g5etCbpOGGrfXx
         C+Z56XlWOOBIpV9j31lKlW5YiYH/8xDd8vkrMDR96YYfgXwE5BMLIZb/pJ/aeOu/UDvo
         Fgsv24c7Ub4TMgukLTo9V7htvPqajU0daM7gVnA/qifQq37EaEBf7/L4lz7E2rtbnNkS
         Ir0N3CjHwMeepkDWmocwR2t1pFfmD1oQOqc2DEuHy0OsMBsxL4p1IQWo66niUE4eOWE+
         hH522KaHfwEI/FaoNp311Yep1af3XrqG4mdjfaAhcYhXQZ269tHwxbOZQUdi03bVCexx
         UnEg==
X-Forwarded-Encrypted: i=1; AJvYcCW6MPLYUY8W1pfLDMVjzDqeGjIaZFjTPhKDpcOJekS1/tE0j4kYtERNsIU8lHaitYn3wef3GspsozrHAtWVQ80=@vger.kernel.org, AJvYcCXFi+FmAbl/WNz+/4PUZUgqqpgIUKqBPOqFZwCZmp/1NIDM4cDQOM6fvGYyuuUD/sBaaPrJdKZ7@vger.kernel.org, AJvYcCXuGll21jknghFdG2ooJS8giI9tWpxD5wZmw+R/XinWGqTDeHDNOdEDTYwibHUZAEktjMxKAcCd4kCK+f8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSX4kS0g/zeGWF2b9rBHd34hlAviCFYD+jV+X1bmuyab4Xzvf2
	2oeihrwVTUTmlHgMTAA0FKLm+qwfGD49FMIM0Y38VWwu7sKGcJm7
X-Google-Smtp-Source: AGHT+IFywUDR2X3yJvl7EXEzEeCvbBZM7Dp8RUSWZ+uTOToAeYQD7QWdRCtUydyPo1THa4J0grigdA==
X-Received: by 2002:a17:902:f686:b0:20b:8ef3:67a with SMTP id d9443c01a7336-20fa9deb678mr21377715ad.7.1729666274824;
        Tue, 22 Oct 2024 23:51:14 -0700 (PDT)
Received: from localhost (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f109d17sm51738805ad.306.2024.10.22.23.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 23:51:14 -0700 (PDT)
Date: Wed, 23 Oct 2024 15:51:02 +0900 (JST)
Message-Id: <20241023.155102.880821493029416131.fujita.tomonori@gmail.com>
To: miguel.ojeda.sandonis@gmail.com
Cc: fujita.tomonori@gmail.com, boqun.feng@gmail.com,
 netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
 alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com,
 anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
 arnd@arndb.de, jstultz@google.com, sboyd@kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 4/8] rust: time: Implement addition of
 Ktime and Delta
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CANiq72mbWVVCA_EjV_7DtMYHH_RF9P9Br=sRdyLtPFkythST1w@mail.gmail.com>
References: <ZxAZ36EUKapnp-Fk@Boquns-Mac-mini.local>
	<20241017.183141.1257175603297746364.fujita.tomonori@gmail.com>
	<CANiq72mbWVVCA_EjV_7DtMYHH_RF9P9Br=sRdyLtPFkythST1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64

T24gVGh1LCAxNyBPY3QgMjAyNCAxODozMzoyMyArMDIwMA0KTWlndWVsIE9qZWRhIDxtaWd1ZWwu
b2plZGEuc2FuZG9uaXNAZ21haWwuY29tPiB3cm90ZToNCg0KPiBPbiBUaHUsIE9jdCAxNywgMjAy
NCBhdCAxMTozMeKAr0FNIEZVSklUQSBUb21vbm9yaQ0KPiA8ZnVqaXRhLnRvbW9ub3JpQGdtYWls
LmNvbT4gd3JvdGU6DQo+Pg0KPj4gV2UgY291bGQgYWRkIHRoZSBSdXN0IHZlcnNpb24gb2YgYWRk
X3NhZmUgbWV0aG9kLiBCdXQgbG9va3MgbGlrZQ0KPj4ga3RpbWVfYWRkX3NhZmUoKSBpcyB1c2Vk
IGJ5IG9ubHkgc29tZSBjb3JlIHN5c3RlbXMgc28gd2UgZG9uJ3QgbmVlZCB0bw0KPj4gYWRkIGl0
IG5vdz8NCj4gDQo+IFRoZXJlIHdhcyBzb21lIGRpc2N1c3Npb24gaW4gdGhlIHBhc3QgYWJvdXQg
dGhpcyAtLSBJIHdyb3RlIHRoZXJlIGENCj4gc3VtbWFyeSBvZiB0aGUgYGFkZGAgdmFyaWFudHM6
DQo+IA0KPiAgICAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcnVzdC1mb3ItbGludXgvQ0FOaXE3
MmthNFV2SnpiNGROMTJmcEExV2lyZ0RIWGN2UHVydmM3Qjl0K2lQVWZXbmV3QG1haWwuZ21haWwu
Y29tLw0KPiANCj4gSSB0aGluayB0aGlzIGlzIGEgY2FzZSB3aGVyZSBmb2xsb3dpbmcgdGhlIG5h
bWluZyBvZiB0aGUgQyBzaWRlIHdvdWxkDQo+IGJlIHdvcnNlLCBpLmUuIHdoZXJlIGl0IGlzIHdv
cnRoIG5vdCBhcHBseWluZyBvdXIgdXN1YWwgZ3VpZGVsaW5lLg0KPiBDYWxsaW5nIHNvbWV0aGlu
ZyBgX3NhZmVgL2BfdW5zYWZlYCBsaWtlIHRoZSBDIG1hY3JvcyB3b3VsZCBiZSBxdWl0ZQ0KPiBj
b25mdXNpbmcgZm9yIFJ1c3QuDQo+IA0KPiBQZXJzb25hbGx5LCBJIHdvdWxkIHByZWZlciB0aGF0
IHdlIHN0YXkgY29uc2lzdGVudCwgd2hpY2ggd2lsbCBoZWxwDQo+IHdoZW4gZGVhbGluZyB3aXRo
IG1vcmUgY29kZS4gVGhhdCBpcyAoZnJvbSB0aGUgbWVzc2FnZSBhYm92ZSk6DQo+IA0KPiAgIC0g
Tm8gc3VmZml4OiBub3Qgc3VwcG9zZWQgdG8gd3JhcC4gU28sIGluIFJ1c3QsIG1hcCBpdCB0byBv
cGVyYXRvcnMuDQo+ICAgLSBgX3Vuc2FmZSgpYDogd3JhcHMuIFNvLCBpbiBSdXN0LCBtYXAgaXQg
dG8gYHdyYXBwaW5nYCBtZXRob2RzLg0KPiAgIC0gYF9zYWZlKClgOiBzYXR1cmF0ZXMuIFNvLCBp
biBSdXN0LCBtYXAgaXQgdG8gYHNhdHVyYXRpbmdgIG1ldGhvZHMuDQoNCkNhbiB3ZSBhZGQgdGhl
IGFib3ZlIHRvIERvY3VtZW50YXRpb24vcnVzdC9jb2RpbmctZ3VpZGVsaW5lcy5yc3Q/DQoNCkkg
dGhpbmsgdGhhdCBpdCdzIGJldHRlciB0aGFuIGFkZGluZyB0aGUgc2ltaWxhciBjb21tZW50IHRv
IGV2ZXJ5DQpmdW5jdGlvbiB0aGF0IHBlcmZvcm1zIGFyaXRobWV0aWMuDQo=

