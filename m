Return-Path: <netdev+bounces-137215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0629A4DC5
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 14:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93AC6286930
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 12:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAD81DFE2B;
	Sat, 19 Oct 2024 12:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BsHQ165N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8530A1E4A4;
	Sat, 19 Oct 2024 12:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729340520; cv=none; b=BP6w4EkFcX+KyTh6NYlfnxDKsSdvndBKtWJyIGXi5xFFMsOM9AHz2YrRChDQb9QMSj7BidyyJY2HJVWT3P/93O2SIr/cmKw9NvIjozO1EM5PQai8OGKpnXNaU/OXZkRqCEMiHfDaQoG1hbapfBBQ4WL+n88IHEiFsx6NNmvAAC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729340520; c=relaxed/simple;
	bh=g82XPKrPt2WZCw67QoEdhYkGQe9x2UxkBDSl2UO7qp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cNIGWJ2sr2UW85G0sd2WE6koDbx2YiNb/txI1/I5MfQ8CsGRQolZUWnW+b7oqFyiOVxfggPBxdKWt2aDcdSX47mGchvszs4cinIiPiI/iTO0XTjbl2mNxeb+ty8qtyF4K5gT8GXRcE8GVjkp5MldULTTjhY21Qeb4gWnIIzpAHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BsHQ165N; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e2d1b7bd57so385439a91.1;
        Sat, 19 Oct 2024 05:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729340518; x=1729945318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g82XPKrPt2WZCw67QoEdhYkGQe9x2UxkBDSl2UO7qp4=;
        b=BsHQ165NiGzafabYIHrpm2IWZ0P6iXkKxDmWFgljWrJNNSu4wqg3Wl+y2EESipP2F4
         OFMJkkc2Y/pqJbTR4UgWJIj9h2nC6c05MRfkKWvSpoP3djXgjMPArMtEH/ECgSup3WUh
         6Tgl8GEAhS5LAH1kvguD8rv8r7S93+iwMbskX26JR61vr0Tr1i5pZmqSZQU3x3Tt9srO
         0YvZx8d6WJc/u6WoJkM3fiOL3W/Lwrpnr9wjtnvKPIYiXwC5YrZahbu7NDE8gvDdrWLM
         fByHXPsz13lLuGQT00hoyQsuCTHWGqXApXy4KnMBJb79jps/7UwxU4TSdG2LA4as3SIe
         SBmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729340518; x=1729945318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g82XPKrPt2WZCw67QoEdhYkGQe9x2UxkBDSl2UO7qp4=;
        b=lLm78RGnKU10CFeAtgpxyI//LbUKWZ0Kw9efzDus1kTSXPPBwUvuHoS6Il50hFV3hP
         PxXoW7mNT8q1Q8ELCsBH0pyiCUYhv71jRv2KT5T8pcZ535Q+tN7A4ll5GpNJG+OE7dTa
         zCSJ9xrWqv+I+B6qztBFGK3CDNi187rz7Us7Rz8oSxWR4zK+rBuuLvLJ+sce5KXdM8NJ
         HAuTF4BnyFq10wzmgHWVYcW4izUB11Mq+jRxGnf0J8u18H0dZqeUuJjDJEi70A9vUAo+
         P45/7QQMD9gDIjHl63MCAOz9sprR1amzWlweykN64opPBdFMeeYIODV6tHTb8tgPhgyq
         Dy3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWHUnF+FLE1RzAHV3IxLRE0Af3X8PutXJ43pl3gkvr2t8TNu7EPqxqfqniyD7uVEt+ArHsSfT+g@vger.kernel.org, AJvYcCWcXB4SWqIoaFBbb3X7OrwqgxQHs9W1kfZ4D4cUYqWCW0BJhnmcrWULpT5QvlrvHAcBVfCXf9po45HDALE=@vger.kernel.org, AJvYcCWiAo2WZRH+mcKfAOGLkClylA234yJjoEGFpfgKfIyG+yizSV6mSa2kTiY5dOdFJwLAFU+Dq1D70BoCfoYZH/w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/w817nGwaOm+aw2waa+WVerGNAtAmATd0xXaX2dOwpj4cIyyw
	0JX9XIw6pi8swFytVouKi3mkF6rE78C4OywNT9y77rc9X+tG/lCYilrUP58DlocHkmuDAfXylro
	ZLh4AGKmZ/ldZGtZ83vZ8eH3NTX4dErAWyhM=
X-Google-Smtp-Source: AGHT+IFFqwJLcPci0kpV0Imx3Ln/B3dSXfPj/0iC5TweuZvhfmptPyQqgtA5en8HG1zvaJMlB9eo5nCaEmBFelgnT60=
X-Received: by 2002:a17:90b:3846:b0:2e0:9d55:3784 with SMTP id
 98e67ed59e1d1-2e56144249cmr2953182a91.0.1729340517661; Sat, 19 Oct 2024
 05:21:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016035214.2229-1-fujita.tomonori@gmail.com>
 <20241016035214.2229-3-fujita.tomonori@gmail.com> <6bc68839-a115-467f-b83e-21be708f78d7@lunn.ch>
 <CANiq72=_9cxkife3=b7acM7LbmwTLcXMX9LZpDP2JMvy=z3qkA@mail.gmail.com> <940d2002-650e-4e56-bc12-1aac2031e827@lunn.ch>
In-Reply-To: <940d2002-650e-4e56-bc12-1aac2031e827@lunn.ch>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 19 Oct 2024 14:21:45 +0200
Message-ID: <CANiq72nV2+9cWd1pjjpfr_oG_mQQuwkLaoya9p5uJ4qJ2wS_mw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/8] rust: time: Introduce Delta type
To: Andrew Lunn <andrew@lunn.ch>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, hkallweit1@gmail.com, tmgross@umich.edu, 
	ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com, 
	aliceryhl@google.com, anna-maria@linutronix.de, frederic@kernel.org, 
	tglx@linutronix.de, arnd@arndb.de, jstultz@google.com, sboyd@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 6:55=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> Did you see my other comment, about not actually using these helpers?
> I _guess_ it was not used because it does not in fact round up. So at
> least for this patchset, the helpers are useless. Should we be adding
> useless helpers? Or should we be adding useful helpers? Maybe these
> helpers need a different name, and do actually round up?

Yeah, I saw that -- if I understand you correctly, you were asking why
`as_nanos()` is used and not `as_secs()` directly (did you mean
`as_micros()`?) by adding rounding on `Delta`'s `as_*()` methods.

So my point here was that a method with a name like `as_*()` has
nothing to do with rounding, so I wouldn't add rounding here (it would
be misleading).

Now, we can of course have rounding methods in `Delta` for convenience
if that is something commonly needed by `Delta`'s consumers like
`fsleep()`, that is fine, but those would need to be called
differently, e.g. `to_micros_ceil`: `to_` since it is not "free"
(following e.g. `to_radians`) and + `_ceil` to follow `div_ceil` from
the `int_roundings` feature (and shorter than something like
`_rounded_up`).

In other words, I think you see these small `as_*()` functions as
"helpers" to do something else, and thus why you say we should provide
those that we need (only) and make them do what we need (the
rounding). That is fair.

However, another way of viewing these is as typical conversion methods
of `Delta`, i.e. the very basic interface for a type like this. Thus
Tomonori implemented the very basic interface, and since there was no
rounding, then he added it in `fsleep()`.

I agree having rounding methods here could be useful, but I am
ambivalent as to whether following the "no unused code" rule that far
as to remove very basic APIs for a type like this.

Cheers,
Miguel

