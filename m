Return-Path: <netdev+bounces-251044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FCBD3A5AE
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 11:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 91EB1300F653
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 10:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFA03587CF;
	Mon, 19 Jan 2026 10:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhIQoHO1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586003587A3
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 10:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768819823; cv=none; b=EpJ4OlKcBjsPicoYc2cqXP9bANXrHHuizkQav44fC2I1zVCn7BActoQMvzAeUhICRCQrJJtbc+/60Lu6pjcjIx+qBA+QrFF8mAWpQknywY0Klh0+GnQ8xtB4H1aCMdRqG4j69oeRmpQYeKRw9HwnZaBCxrHoG/wgb/IM3upuS6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768819823; c=relaxed/simple;
	bh=1OdxoGGYasc9V4+/2xWHjGW4ZBzQQu01djJnm8nwOYc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oQ3cSY21OJUedRq3azH4FP7BL/WeN9IAIOpTmRRj/NClNlZ+DwW03sRjoMBDYGTTWgLUvYfnsKjfmBSsTnPCChm5qwEXJGwFcgY0idwLz0AM2lZO2nRgfgE87+ShjTguOsbLElxEP/Z29I1XCkQk1WVgfgVqhF8M00fGNaUIzAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZhIQoHO1; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42fb4eeb482so2233894f8f.0
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 02:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768819820; x=1769424620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EsYrqDgfDLls2j3U850tzatLT/AOiSnBFqwVPzknSNs=;
        b=ZhIQoHO1EOdVSYm3LjvlwSa1Ch9JlqpV/n04W2aqVHdG/xD9Ot2YL+0VP30kQ4YPeN
         LkDBwjtBY2fFgShgQdEXMKsqk4Ym5xIux5VOFfYRbiKgc1lGfEgkdHgXdBJAkwKdhyYv
         kUIu5304ROLnpj/0MWfDMAxn0mUeLpIdsUTFQZ0O1VC+uVkzZNAuwyQ5iJUx+spzmqGa
         gfh6DJ3G65wf4nO6FgjkQ46zB4lJ21xz93kwhYQ7Zy2teZKpsDVJOVoh3nZRkTqMYpd9
         J6t3iVaVcR5mD0Ehw529c5g/oN+tFVMRilkAxAaT7OShhjmB2FvSeYdFz3B4LeJQpnu7
         voxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768819820; x=1769424620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EsYrqDgfDLls2j3U850tzatLT/AOiSnBFqwVPzknSNs=;
        b=dlzgEnPiMg+TFULmRgcZuY060FocDla36tK2/7cLy+uW2cCVLVj0xqMubMjTvKHWAH
         RlAXAb9J/16A9219OcT66VUBfqnmNTcs0+Jg9rXX4ZtlKyqWOtUUh3JnumRb2tN6gR3o
         m+dc6EJb5OneEWC3sIQfX04tW3lEz5bg6p1O+TnmY4/QqzkZDifDYMeKD+CvSoetgBAg
         7wuOuVAxiR+I4rFaD/RpWtBrUUaXuipTMi5rRPBzQAg9qaO8FtwLqKnU63l4VsZuxmk2
         URC4YHgKMkS5nHgWMLHL03veTdL1mVVvP69p06eVID4+Hyv7H/O7aWQRs6n/uUbuTZ1L
         dHmw==
X-Forwarded-Encrypted: i=1; AJvYcCU9LVNYW5srx6DS9YrvJaQtVDAvMLt+b4kwqjBVpT58U4uLD6SpRS+bIBD/mWnUZaW4jfXeDnE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmvv1skEI+G3ivsst7z6foR6e7sqZmkc59EhXldCjuZ4a4wIWn
	h7oX+85X3jJ8zHLMwupsYFcxdJ+OQGlLyMIyirhnvbSxzO4IBwACfBP9
X-Gm-Gg: AZuq6aK1SnwcsUtnRzz6RfyJpIsg5btNMf1qvYHpR0MmLklAFpgOpgVeZxj/l5dKT/X
	tEn4DFVwKQ0sYh1V3/qQUHiFvusH/BtlG8HHnf1SKTuOzensIfd4m1TtM/i1opeevYj9UAj0N4w
	KTKzwDcn5O07Hi7GTcTScK1teqorlnrdSll+z/ID/50kkAxUXoqgeqbae6zGy0h//kzmVeBpYle
	I86WqfOL/1nsgrwIFGec3ejduEf0mLmmoM3ZtZ5Kbamw4xRme53Z4iDtORr19PkcKYTtBKzpUhQ
	3vTjO+mnnLxT+QT5KdTlCas5ImOuMVa2yXxo5PweiWg+X6xoEZOPgJyLsf12hQkAMICVYqwCAjr
	8Dzfhk6mHVE9s6skBOCd9Okq3wstGRFJoenGAU/lSQRGIUefUf5XpRyGiFnuUwbTPHKOmIgRY1O
	NgXzX6rEL4V7f7C07rBOxBnNemkuNXXQkUpZvp8oR2RbmJJY6gZx5P
X-Received: by 2002:a05:6000:4202:b0:432:a9fb:68f8 with SMTP id ffacd0b85a97d-4356a02643dmr11691111f8f.1.1768819819422;
        Mon, 19 Jan 2026 02:50:19 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569927007sm22062014f8f.16.2026.01.19.02.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 02:50:19 -0800 (PST)
Date: Mon, 19 Jan 2026 10:50:17 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel
 <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <eric.dumazet@gmail.com>, Paolo Abeni
 <pabeni@redhat.com>, Nicolas Pitre <npitre@baylibre.com>
Subject: Re: [PATCH] compiler_types: Introduce inline_for_performance
Message-ID: <20260119105017.262276b5@pumpkin>
In-Reply-To: <CANn89iJVQe=wedLheJmjZjOTJsWHijT0jZs=iRxKssJZbjAxHw@mail.gmail.com>
References: <20260118152448.2560414-1-edumazet@google.com>
	<20260118114724.cb7b7081109e88d4fa3c5836@linux-foundation.org>
	<20260118225802.5e658c2a@pumpkin>
	<20260118160125.82f645575f8327651be95070@linux-foundation.org>
	<20260119093339.024f8d57@pumpkin>
	<CANn89iJVQe=wedLheJmjZjOTJsWHijT0jZs=iRxKssJZbjAxHw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 19 Jan 2026 11:25:52 +0100
Eric Dumazet <edumazet@google.com> wrote:

> On Mon, Jan 19, 2026 at 10:33=E2=80=AFAM David Laight
> <david.laight.linux@gmail.com> wrote:
> >
> > On Sun, 18 Jan 2026 16:01:25 -0800
> > Andrew Morton <akpm@linux-foundation.org> wrote:
> > =20
> > > On Sun, 18 Jan 2026 22:58:02 +0000 David Laight <david.laight.linux@g=
mail.com> wrote:
> > > =20
> > > > > mm/ alone has 74 __always_inlines, none are documented, I don't k=
now
> > > > > why they're present, many are probably wrong.
> > > > >
> > > > > Shit, uninlining only __get_user_pages_locked does this:
> > > > >
> > > > >    text      data     bss     dec     hex filename
> > > > >  115703     14018      64  129785   1faf9 mm/gup.o
> > > > >  103866     13058      64  116988   1c8fc mm/gup.o-after =20
> > > >
> > > > The next questions are does anything actually run faster (either wa=
y),
> > > > and should anything at all be marked 'inline' rather than 'always_i=
nline'.
> > > >
> > > > After all, if you call a function twice (not in a loop) you may
> > > > want a real function in order to avoid I-cache misses. =20
> > >
> > > yup =20
> >
> > I had two adjacent strlen() calls in a bit of code, the first was an
> > array (in a structure) and gcc inlined the 'word at a time' code, the
> > second was a pointer and it called the library function.
> > That had to be sub-optimal...
> > =20
> > > > But I'm sure there is a lot of code that is 'inline_for_bloat' :-) =
=20
> > >
> > > ooh, can we please have that? =20
> >
> > Or 'inline_to_speed_up_benchmark' and the associated 'unroll this loop
> > because that must make it faster'.
> > =20
> > > I do think that every always_inline should be justified and commented,
> > > but I haven't been energetic about asking for that. =20
> >
> > Apart from the 4-line functions where it is clearly obvious.
> > Especially since the compiler can still decide to not-inline them
> > if they are only 'inline'.
> > =20
> > > A fun little project would be go through each one, figure out whether
> > > were good reasons and if not, just remove them and see if anyone
> > > explains why that was incorrect. =20
> >
> > It's not just always_inline, a lot of the inline are dubious.
> > Probably why the networking code doesn't like it. =20
>=20
> Many __always_inline came because of clang's reluctance to inline
> small things, even if the resulting code size is bigger and slower.
>=20
> It is a bit unclear, this seems to happen when callers are 'big
> enough'. noinstr (callers) functions are also a problem.
>=20
> Let's take the list_add() call from dev_gro_receive() : clang does not
> inline it, for some reason.
>=20
> After adding __always_inline to list_add() and __list_add() we have
> smaller and more efficient code,
> for real workloads, not only benchmarks.

That falls into the '4-line function' category.
Where s/inline/always_inline/ makes sense.

> list_add                                    2212       -   -2212

How many copies of list_add() is that... clearly a few.
Generating a real function for a 'static inline' in a header is stupid.
Pretty much the intent for those is to get them inlined.

I'm sure there was a suggestion to make inline mean 'always inline',
except there are places where it would just be bloat.

	David

