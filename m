Return-Path: <netdev+bounces-158858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C64B7A13951
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 12:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE36C168969
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 11:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD7C1DE3CA;
	Thu, 16 Jan 2025 11:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y7ppyAff"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5861E1E86E
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 11:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737027792; cv=none; b=CIGALR58WoTCvcxRZoSVcwvVsktpZe3c45AKDZu97ExprtsGD4mK8bUL72SLmKIf8oGrmmcB820RvFk8a998HbpgjCmVdSPHFxhOMWpdPgXjPkfiH4mOX8k33RUqvTXHitWiNRGbLHVDhVlVzkBj/oiii2CeVGQ3frIPbZvHyeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737027792; c=relaxed/simple;
	bh=/ZOkrmzJPzjEvO1p9wMx7ZOpN1MK6QtCsFlC20KTxu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UvfYJ31prtUVT83odKG8NQHJH4JINSTmqYIYNZSRnVcPsb9HsCP4sCGnMObMVR0w3qUYB8+Ex40m2T1fkQ0J8yljXcyPlaVWAIHKK+8ApEix1jqJXNpBRwjp5yL271eaAWmS1xzk79xrJWw2+j6J//0N/LacKlc5evn01jM0IjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y7ppyAff; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38a8b17d7a7so417615f8f.2
        for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 03:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737027789; x=1737632589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bn4lZsunIzxRfnnBOD/wSjWgozy9RANf06sOosGkdb8=;
        b=y7ppyAffCXvT+bt4FYkcYz5Zka0AQ7OjAfcXW12QSEwrMz+3Jk3h6scjQJI96X/91T
         wW5c7VF1q3jdmx/mVuIXTmN+T7e0/Lz8IlTCLnh4D5D6645NA9FkFWpV2a9jtkoqPnyl
         5/Ix0zASkwa9o8pLUE10tt/0pRs8OHhZFEJWNtM9VLKtJ8JnyrbSIqqTWBIsXSVIUIA8
         c4U1JPLw5g3bSjZtu+GNz/N5PSwamWreWiVbiXS5XV3IRRgp3Whn1XJIxj88V38Yoq6u
         BDrwj1h4S2fIsnU/niuakRjF64+Jfg1Rwv/5ip5M/Gr9KGa11V5yDNVKQP06aODyeu+b
         Gq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737027789; x=1737632589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bn4lZsunIzxRfnnBOD/wSjWgozy9RANf06sOosGkdb8=;
        b=Pas5Sre95WuA0XT0EjDBsjqywbkVguMURhesVE9uhaZ61DOv53w5gVVij7PIudJ0Fp
         xi9oYamztYiBbp/EdRX1jbTyswFoP/ImgWWhvDWHE3UPDpZAG2WGUrlLDBjIf3BbP6LE
         HhLfYokcbsOx26f4e084dd0hzfRbOLWivQJiE2uts08E9nsZuZKw49c69jkDjNGvI0q0
         4pA5DvGFH5OwbjlFZFt+0RNc2TRLROCnPnOtWVN8YIhh96rmSzja2uFEAO0CbKLa8NiQ
         j8N/wDEiuxov8t+o2EFfAck5BcPgiRpL/tMbPIiNpPMAQ/zYEBfdsHbKtur81glKKpQe
         Ddlg==
X-Forwarded-Encrypted: i=1; AJvYcCXD8TDnBVoVfZTfGSIkvgVXrr/Pb5IyqbGpLKhnpfYOrbpfn8eKEuI84zERAutJzODLXnHtDxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YycJkD9PrCcxbcmH1e8RIz1Oawuk80zVv0rhFIdSSw8gNXhcI1U
	z7OXVEUSW6+rG3/seG9MvPFRvqYpi7mr4ECGOt+lFI72m9yRv/K9fw+lOW2hnyQFrQxHHmcYOTe
	cTZsNQ4SeIhhNKs4mAU7xyJ3+G9Ct7Wne4j8t
X-Gm-Gg: ASbGncs1RLtyaInkqYEzfIT8HSNF52xJgC7x1EQza4gnUJ7EQw0t5GAfq8GAHR6KKHB
	MQmqeaIW1AhT4Hgu/ioUKhvu/OwDgfpPKe5tS+Z2YDC2c7YwQKQqEmg8KU8x4fSPgD3o=
X-Google-Smtp-Source: AGHT+IHDcN0YedaoyFvVSl8TgyMvYnEOVuMoAFM9lYaTPopQ/r4AiJCGaWAHy0cwaaehAImpzjeALrSTYUkp5n/q2G4=
X-Received: by 2002:a05:6000:4615:b0:385:e013:39ef with SMTP id
 ffacd0b85a97d-38a872f6993mr26719362f8f.6.1737027788587; Thu, 16 Jan 2025
 03:43:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116044100.80679-1-fujita.tomonori@gmail.com>
 <20250116044100.80679-7-fujita.tomonori@gmail.com> <CAH5fLgjoAzv1Q0w+ifgYZ-YttHMiJ9GV95aEumLw4LeFoHOcyg@mail.gmail.com>
 <20250116.203224.774687694231808904.fujita.tomonori@gmail.com>
In-Reply-To: <20250116.203224.774687694231808904.fujita.tomonori@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 16 Jan 2025 12:42:57 +0100
X-Gm-Features: AbW1kvY-aX7saWx3Ako7sLM3Mtdo2m7-IF4OQp8nxR7hF9Tggj5tOYZnNK6ndqc
Message-ID: <CAH5fLggF2oXV=p5iO7HvEOitd38XxNnKhZuinhk2A=OdmVfuFg@mail.gmail.com>
Subject: Re: [PATCH v8 6/7] rust: Add read_poll_timeout functions
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: linux-kernel@vger.kernel.org, boqun.feng@gmail.com, 
	rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, andrew@lunn.ch, 
	hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org, 
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, anna-maria@linutronix.de, 
	frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de, jstultz@google.com, 
	sboyd@kernel.org, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 12:32=E2=80=AFPM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> On Thu, 16 Jan 2025 10:45:00 +0100
> Alice Ryhl <aliceryhl@google.com> wrote:
>
> >> +void __might_sleep(const char *file, int line)
> >> +{
> >> +       long len =3D strlen(file);
> >> +
> >> +       __might_sleep_precision(file, len, line);
> >>  }
> >>  EXPORT_SYMBOL(__might_sleep);
> >
> > I think these strlen() calls could be pretty expensive. You run them
> > every time might_sleep() runs even if the check does not fail.
>
> Ah, yes.
>
> > How about changing __might_resched_precision() to accept a length of
> > -1 for nul-terminated strings, and having it compute the length with
> > strlen only *if* we know that we actually need the length?
> >
> > if (len < 0) len =3D strlen(file);
> > pr_err("BUG: sleeping function called from invalid context at %.*s:%d\n=
",
> >        len, file, line);
>
> Works for me.
>
> > Another option might be to compile the lengths at compile-time by
> > having the macros use sizeof on __FILE__, but that sounds more tricky
> > to get right.
>
> Yeah.
>
> By the way, from what I saw in the discussion about Location::file(),
> I got the impression that the feature for a null-terminated string
> seems likely to be supported in the near future. Am I correct?

There's a good chance, but it's also not guaranteed.

> If so, rather than adding a Rust-specific helper function to the C
> side, it would be better to solve the problem on the Rust side like
> the previous versions with c_str()! and file()! for now?

I would be okay with a scenario where older compilers just reference
the read_poll_timeout() function in the error message, and only newer
compilers reference the location of the caller. Of course, right now,
only older compilers exist. But if we don't get nul-terminated
location strings, then I do think we should make the change you're
currently making.

Alice

