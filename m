Return-Path: <netdev+bounces-158828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3245CA136B9
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 10:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 585041886005
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 09:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4AB41DBB19;
	Thu, 16 Jan 2025 09:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T6CS2MHk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F2B1D86FB
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 09:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737020184; cv=none; b=OMr0YM62fdDwQJRO9EA137PXzmhp9mGaW1MzmkYBTCdOnAKUqAzg14pM8fNdA1551H0Aeg4qzmhc3sx39z1X5C/260sGksn+4P6f66kAcE9COj2R8CSnw5lPuzdCiUG/TwzsoqKWZo5djAzaPDORgBCSuGR3aB8xC0rY++It2VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737020184; c=relaxed/simple;
	bh=x/mDAob75h28oX6ccAJKmni+dnVWhR84tnTbvU+U1vY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m5OlogYYznPu1jXxKX4++xxMPhrH7DKF5cPP0/L9JuabEhcktdBJKASiZBOjAfHS3Mv7Sp3GGPRi4qznVKHdUGKnK31Hf7y6yIJd5WibCdwkV70RRNjfoBNGikfuQjs3X/opKBM0PaLjzVrPVMmTVPL546X+PWty083GpBNHi90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T6CS2MHk; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43625c4a50dso3886395e9.0
        for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 01:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737020180; x=1737624980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dbx4Gz+1RqxxtjhSs2rAX1eej4evyNrfejfv4dzq+ns=;
        b=T6CS2MHk+KYttP/1ctqErQWp1igQoN6uy6WoNlSn4+e8kUxmxDqhzkxIE+1/O+CwC/
         6Tlg4aF42G0pEMmUxvB/1BOP9vaMXOEUns3nRAji0kUfzmrKbluC+esD+7qaHJXiJT6v
         MflV21Mm+q0MG0mgpd5Yy5OeF/39HMFN0+wc2LBVXOBc1JL4R9XMbzecuDw8qJquoBwW
         R+Hq0xGkmHk4lFup0yD+iB2YCG+PFRHJChNs0F0RKUQwNRvZJLvraaYCW7SyukjWj7GF
         90GNcGEbx1HEw1BrGANLAU9LErD9AxqmZBLuttKoKMr/gAjqfNP98eoP88utR9EeET+5
         Ub7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737020180; x=1737624980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dbx4Gz+1RqxxtjhSs2rAX1eej4evyNrfejfv4dzq+ns=;
        b=NRe1Hj5jj3mDdIQCtzltNj8QQws7Pl6fEUcFf8xgI+bxkRoIg72uxfn15YKICc8jM4
         3Pmo7yrNu2el0+lFFn3+vwchoQe+msGuFyBSOXgOJkZyMygwfdBoh9ykXLsFCLRUaN1O
         57/X5y9/YcoBKa7WemTO8PNN1slDsdvRLl0T4yeVouXV89kOwDqbZtwvGlmutbSz323p
         LHljeubBSRELSkXfOQk7PMCw7GrfiTlL8ITGFxAN0ppElLAx1XW6rz3mhsSUexUfneUq
         DNe0bja3EFqIcuNI18SEAmVjtSRJRauFzluQ+AWPulowGnbQLYuG7hPutEFr1Djq3k2M
         P+qg==
X-Forwarded-Encrypted: i=1; AJvYcCVDGigMTRhrrdovBIH5B/XonywlTYbOJN1k13Czrj5aetUn/FVBEchPlBir7wZs58BN/2ta4ok=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT2ON82hS4jwkiaNpQFXJyoEHwzeqIUKs3e6TfEwWEP8Iq0MKI
	AZO93M2i9WP+8eT/DetIlpQaczYFo2rx0Y4+Mxh5ktybKspgkrpphWBq68J9QCn3C5dJBqBPIQt
	MV9rpMw1a8nGWAh+vVceNTao1tm8ejNjHrUKz
X-Gm-Gg: ASbGnctbJL8H3ESVQKecL8OrUcoSQv/99PFihUbt0aEQb51QTIjFp6/TWymRHEkBrB5
	U0diNJqcnamVOOTQlRe4bOcODzH73iUQVx4J9zJdDI6Y47MlTEwMLykD8m/EqFsdw9B0=
X-Google-Smtp-Source: AGHT+IHzfSiPAGevk8eOGlqQbe+ZpnfT+o2XolTqPMDZydhRpoQ5A88b3a9IDfBFqVdVzssZFiTdG6CwrZDbCaRCLYk=
X-Received: by 2002:a05:600c:1c8b:b0:434:f5c0:32b1 with SMTP id
 5b1f17b1804b1-436e26a7578mr311927325e9.15.1737020179104; Thu, 16 Jan 2025
 01:36:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116044100.80679-1-fujita.tomonori@gmail.com> <20250116044100.80679-3-fujita.tomonori@gmail.com>
In-Reply-To: <20250116044100.80679-3-fujita.tomonori@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 16 Jan 2025 10:36:07 +0100
X-Gm-Features: AbW1kvaXJCb1m1shYmY-XBFLwJar9iXu8ps3uKY_yBt8I-PolyqVbWMrSVJpWtw
Message-ID: <CAH5fLghAfovcm0ZJBByswXRSM4dRQY4ht7N7YGscWOaT+fN9OA@mail.gmail.com>
Subject: Re: [PATCH v8 2/7] rust: time: Introduce Delta type
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, hkallweit1@gmail.com, 
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com, 
	anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de, 
	arnd@arndb.de, jstultz@google.com, sboyd@kernel.org, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 5:42=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> Introduce a type representing a span of time. Define our own type
> because `core::time::Duration` is large and could panic during
> creation.
>
> time::Ktime could be also used for time duration but timestamp and
> timedelta are different so better to use a new type.
>
> i64 is used instead of u64 to represent a span of time; some C drivers
> uses negative Deltas and i64 is more compatible with Ktime using i64
> too (e.g., ktime_[us|ms]_delta() APIs return i64 so we create Delta
> object without type conversion.
>
> i64 is used instead of bindings::ktime_t because when the ktime_t
> type is used as timestamp, it represents values from 0 to
> KTIME_MAX, which different from Delta.
>
> Delta::from_[millis|secs] APIs take i64. When a span of time
> overflows, i64::MAX is used.
>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

One nit below, otherwise LGTM

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

> +    /// Return the number of nanoseconds in the `Delta`.
> +    #[inline]
> +    pub fn as_nanos(self) -> i64 {
> +        self.nanos
> +    }

I added the ktime_ms_delta() function because I was going to use it.
Can you add an `as_millis()` function too? That way I can use
start_time.elapsed().as_millis() for my use-case.

Alice

