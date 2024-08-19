Return-Path: <netdev+bounces-119513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D08956085
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 02:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A3F61C203DD
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 00:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC902D531;
	Mon, 19 Aug 2024 00:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlLW40F1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AFDF4E2;
	Mon, 19 Aug 2024 00:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724026941; cv=none; b=P2G6yXG5oj+n00Z91n3pzGTpUuf4BvxRdOPyd6MNUZgRtjGKp83VFyuJZnRM4Mk9b9BNXl7kl8qbGIq/OP04MSusLPDLUH/ycOrsuB2H+SYCf1fciivlaXUsNEZSgCIfAOcLwqTug7bZh0pAQPvgsIEUf7ihgef16uO3v7CCX0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724026941; c=relaxed/simple;
	bh=hUlasCGs8bJ/CqR9HffjtbBB4lngk1f4AcPUhJq0AcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TQW2J97C+3PfJ7nW/kRnp+8ZIP+AigNSUTOMK1rqwMvMdeoPxyrY9tuMfGcdteVXYckG2WL7kKdWkS5PI8rJhF65qJ5frsoxsQ/PHT8u3YngKe/12oTTQa36V50jNBawfy2OoQmxwH/iJR6Cw3kZQIB6XrwF1/6bU/VTabRk/rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OlLW40F1; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70eaf5874ddso2752789b3a.3;
        Sun, 18 Aug 2024 17:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724026940; x=1724631740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYZfJCDZHiEEDuTx7TQepweKjjgoFmH0zVv9FmE6Nt4=;
        b=OlLW40F1sgrvK7baYujl96VOaNfHJJ06rpkLjOtEmm1qPlOQ8o+g2rGu7jLtkcus8o
         CQfWTlsSBo/bZDAuQeLOfYTP6hwIv7hctPS+90rDoAKaqYKUClr9ZVpRldJCWI4KNzKg
         rq06OTfpAHsB+b7jt9/Ex5XAmx8x7Dnqt28EwGmTINsP0CkSwvRAFsv8VBaSFkP2b4h5
         gQIp9A8ErydmpQEvsfw49cgXPCytG8VpIEavkStMipu5ntBPOltI3HpHF5ZffL8TV4p9
         s/Rdf165t7YXpqTPv1lr0YM5xNu3Rm1QQ1LD+WZO1OJ7/ASjQv/QuM1Skvlfn0zSlC3g
         28NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724026940; x=1724631740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RYZfJCDZHiEEDuTx7TQepweKjjgoFmH0zVv9FmE6Nt4=;
        b=RbeADj9+RSr/Y9PRLXP79z7tILqpuCUo6xnOAXGF1mLZYV8F086LMyqhvqQ7RFI0pa
         iA5ia63GNJUxURSyV/p18G36Hp8TmXotqrSg7uOiE1S8PNhaP5xU3hxDCc0tz3sHvaE3
         gVMrfHa6rH9GWex8ZqKCwhP2Q4foxk3vC2VhCJvp5ww7Bb6EJkXKl+gI/XG4z8r+8DrI
         GRgweXou6ExBGZp86N9xMFoWiKBKfTLAJDtnBHExvjoG0EadENc0KG38iXJN96B0I4Za
         w3AorbvfPdb2MM8nogv3XMUHOHLGapGTj7rwwfsEr9wN9CJSXtk3OIky+FaeUV/GZHMo
         r5mQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEWUQ9PQII4iJhJcYxb5PQaxGS8PRg8KI9J22iBFRxxAWNucNxHEAlexCbiLhAUCt1oBYotV1yEv7+bympKaNVYc4qP4kYNgjKK1+2JkDOGj6/HDfHq7wOgJWw5haTCJNanDKYhuY=
X-Gm-Message-State: AOJu0Yy9v+CEL9dtNguP7ZnpG9PSioI6k5wyMj6rXRvYnP/LiNR1yWZ/
	2udYa/KVBnS5gIXPc7GE4OxpMfiCO+eEmNPMcU/ComwppUSnGYoNbuYxgFQzzykPLyPZqxTHG2r
	90KiInSP9tINXTCP6adBmbqG5I6A=
X-Google-Smtp-Source: AGHT+IEGKxijvM5mqkst0BgtqjvHPalpw5q93+BJyczPe2AiwKeMQbFced36aht9WX6/LWN2Dm8QtTLHyCRUk2OA61g=
X-Received: by 2002:a05:6a00:66d9:b0:70d:37f4:2c73 with SMTP id
 d2e1a72fcca58-713c4ddc3abmr9471115b3a.10.1724026939632; Sun, 18 Aug 2024
 17:22:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240817051939.77735-1-fujita.tomonori@gmail.com>
 <20240817051939.77735-7-fujita.tomonori@gmail.com> <9a7c687a-29a9-4a1a-ad69-39ce7edad371@lunn.ch>
 <7f835fe8-e641-4b84-a080-13f4841fb64a@proton.me> <1a717f2d-8512-47bd-a5b3-c5ceb9b44f03@lunn.ch>
 <0797f8e8-ea3c-413d-b782-84dd97919ea9@proton.me> <bdfdac7c-edb0-4b78-b616-76be287c7597@lunn.ch>
In-Reply-To: <bdfdac7c-edb0-4b78-b616-76be287c7597@lunn.ch>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 19 Aug 2024 02:22:07 +0200
Message-ID: <CANiq72=Ga7usdPgACL6znOJ_=SQXy8ESbft4x0XewGL-Xf-M-g@mail.gmail.com>
Subject: Re: [PATCH net-next v4 6/6] net: phy: add Applied Micro QT2025 PHY driver
To: Andrew Lunn <andrew@lunn.ch>
Cc: Benno Lossin <benno.lossin@proton.me>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, tmgross@umich.edu, 
	aliceryhl@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 18, 2024 at 7:39=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> O.K, so the compiler tells you, which is great. The C compiler would
> not, which is why i tend to think of these things.

For the unused result, there is `__must_check` of course, though it
does not seem to apply to types in GCC like it is applied to `Result`
in Rust (Clang is OK with it).

C23 brings `[[nodiscard]]`, which can be. GCC >=3D 11 and Clang >=3D 17
support it, so one can do things like:

    typedef struct [[nodiscard]] Result {
        ...
    } Result;

    Result g(void);

    Result f(void)
    {
        g(); // will warn.
        return g();
    }

https://godbolt.org/z/PqK36rjWY

And have a `Result`-like type (or, rather, like our alias in the
kernel, given the generics).

So if one is happy using new types, that is great.

It would be nice to be able to do something like:

    #define Result __must_check int

...but that faces trouble when using it for e.g. local variables.

Cheers,
Miguel

