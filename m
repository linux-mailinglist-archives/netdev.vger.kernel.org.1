Return-Path: <netdev+bounces-131219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C5898D486
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 15:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4107E1F20FD6
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 13:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8411D041B;
	Wed,  2 Oct 2024 13:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9IS6bIH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E601D040E;
	Wed,  2 Oct 2024 13:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727875277; cv=none; b=b1X+UN1ZOfVj5pJOMJBxQDv11r6XE/oU+BagFZioU/CnR2uFQvo/jMjIoShGNbGOaLHV/ALbdN8OIFNm8cKLtLKjSAAKOt6oajsSbt3ip/to9ZDH7dFr27UIBzT44UJAbbY1Qqy8J9JaeDkPhVJBDTOmTzLrPw+Pu2sfYaORBXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727875277; c=relaxed/simple;
	bh=MfAys8jyEU3r7Li7ovZWjUcUP7XOHGAnLrtxuGcCJGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dRK4nPZ6/A9wOgGsRI8j7qjnKWHO9zUAGwugivGlM92hY0ijLOtQFtsNCEVf4pSd3bj19Xs0ET0IknKbcBBcU7pjNAihQ2cq0M89/HMc1B52elkUybaS2mQTFNYP2G2ZaDHH4bLsdbxmEu8Rx5jadNIwiXBSYt5kdHnIiTbY9hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9IS6bIH; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7191f1875d3so531796b3a.0;
        Wed, 02 Oct 2024 06:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727875275; x=1728480075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MfAys8jyEU3r7Li7ovZWjUcUP7XOHGAnLrtxuGcCJGg=;
        b=X9IS6bIHeuVLaDeTGbckepeIt/1hqmws30ZA94e9TKR8AkZ0rkLCMcIMPsQQhe5BFi
         WRiXd9K5SoGrLlH9gcdzSS5qyLikUnND4VOpgcmaEf3JlveVlWWKb1cd6oDIBkPTFmZx
         Hh4VG4wAjZKhbQZBmPv5i5+Xx+ULMwn2mpGh02X6hxDYTczUeXiSEBLJo3m0IxaaIGQ5
         2GSMhBQDw6PVnVea0hFC2l/oaDTB3h7GeAd1egeVoMYef8CcW1QfZpM2xMLNvjccksNx
         9ljYfvGH0R2pH9nXrXKGMaKe0Fxy9y5/N8PMAWFdtx4XpGWE+3rMi7IUkBr4RHuCt6kq
         7ixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727875275; x=1728480075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MfAys8jyEU3r7Li7ovZWjUcUP7XOHGAnLrtxuGcCJGg=;
        b=SVgMP3QE3XEARMJ40Umxp3dJ++ToGbVyZWxE/0ailuCPcYCaeH6X7nPJekV2oQvLPc
         7dSQ0XKb98nDhvOCtInUZzdSgVSqvaM9y/WvGOyaTW6cMaRTlkpWuars2pjBfiiY47Sb
         8PFjzohrmqmChXt+VnZEW6aAeYYqxajSL9UaJcXwRN/ZQNTduqzvtnY6N1u4bDVEm0sa
         reyTgwOYWe2XCBGLDQq6Sx3RTm4RqPulNF+c3TUTXD9LAgnld/vl12eGrCJJWQA+7Kcp
         JHMMOXCgPXZrHWLkIs/rx+NpDuPrfnZ6S/z4xSX9hQ2Maqn3STe9c0uJPJ7+/4SoQSOn
         rLdw==
X-Forwarded-Encrypted: i=1; AJvYcCUq9o/T/v1C75Pdz7P3AKyAiANUKcr2wttGenqOrCSeMEiyaqTi3y+WGdDe0GTdDWlDUGpiZaIOz6cHdpM42vU=@vger.kernel.org, AJvYcCXZlTIzaMwf3FQ6svAag8Mr5lV94G4u9n5PyquXKQ9kkPZJGyQGKYf11D1TiQa2+aM+dM40fTM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya6tSh+LbWRQQl3nUi86C6yMvgaDjA2CRwitPCKhjvdxvn24H0
	CnqjOQ7ZtnbOf0z9Q/NMo/7Fda6Mvha5gR6xD2Ovk+E+7XP7OrrL/RtvyNH9U4+9qGO2+ESkveu
	KygiTpHJhmuSfZGh0/z9AnXKT2gg=
X-Google-Smtp-Source: AGHT+IE4GbRCgixbV8NJCBdaE2P9ElsNwzCWD9lYPe91JxAyWowpvZ6NHqaC/7v8ja2kykuW8m+vDA6hiIa5RLDDiXM=
X-Received: by 2002:a05:6a00:1304:b0:70d:2c09:45ff with SMTP id
 d2e1a72fcca58-71dc5d7ff02mr2162822b3a.4.1727875275501; Wed, 02 Oct 2024
 06:21:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001112512.4861-1-fujita.tomonori@gmail.com>
 <20241001112512.4861-2-fujita.tomonori@gmail.com> <b47f8509-97c6-4513-8d22-fb4e43735213@lunn.ch>
 <20241002.113401.1308475311422708175.fujita.tomonori@gmail.com>
 <e048a4cc-b4e9-4780-83b2-a39ede65f978@lunn.ch> <CANiq72mX4nJNw2RbZd9U_FdbGmnNHav3wMPMJyLSRN=PULan8g@mail.gmail.com>
 <3fc44d62-586f-4ed0-88ee-a561bef1fdaf@lunn.ch>
In-Reply-To: <3fc44d62-586f-4ed0-88ee-a561bef1fdaf@lunn.ch>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 2 Oct 2024 15:21:02 +0200
Message-ID: <CANiq72nCeGVFY_eZMhp44dqZGY1UXuEZFaJx-3OLCTk-eG=xng@mail.gmail.com>
Subject: Re: [PATCH net-next v1 1/2] rust: add delay abstraction
To: Andrew Lunn <andrew@lunn.ch>
Cc: Thomas Gleixner <tglx@linutronix.de>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, hkallweit1@gmail.com, 
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com, 
	aliceryhl@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 2:51=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> Which is better, the Rust type system catching the error, or not
> making the error in the first place because you read the documentation
> and it pointed you in the right direction?

The former, because we don't want to duplicate documentation of every
type in every function that uses a type. It does not scale, and it
would be worse for the reader of the docs as soon as you become
familiar with a given type.

Of course, there may be exceptions, but just using a type normally
should not require explaining the type itself in every function.

Also note that in e.g. the rendered docs you can jump to another type
with a single click on top of the name. In some editors, you may be
able to e.g. hover it perhaps.

> Maybe this is my background as a C programmer, with its sloppy type
> system, but i prefer to have this very clear, maybe redundantly
> stating it in words in addition to the signature.

The second part of my message was about the signature point you made,
i.e. not about the units. So I am not sure if you are asking here to
re-state the types of parameters in every function's docs -- what do
you gain from that in common cases?

We also don't repeat every parameter in a bullet list inside the
documentation to explain each parameter, unless a parameter needs it
for a particular reason. In general, the stronger/stricter your
types/signatures are, and the better documented your types are, the
less "extra notes" in every function you need.

For instance, if you see `int` in a signature, then you very likely
need documentation to understand how the argument works because `int`
is way too general (e.g. it is likely it admits cases you are not
supposed to use). However, if you see `Duration`, then you already
know the answer to the units question.

Thus, in a way, we are factoring out documentation to a single place,
thus making them simpler/easier/lighter -- so you can see it as a way
to scale writing docs! :)

That is also why carrying as much information in the signature also
helps with docs, and not just with having the compiler catch mistakes
for us.

I hope this gives some context on why we are approaching it like this.

Cheers,
Miguel

