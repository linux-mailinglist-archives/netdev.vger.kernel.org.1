Return-Path: <netdev+bounces-142827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 037619C06CA
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 14:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD72C1F21766
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 13:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE08221730C;
	Thu,  7 Nov 2024 12:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s5givOdv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDEA20FAB9
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 12:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730984365; cv=none; b=UhsbQO/dnOXY1AmU7hmjiCc998mXp0oj8W2sXduhpTfOTemstHxxml2ORfiiQr8rJmE8R0nFzRpr8C8Uy3YeLrMVNn+prMlNknroPpzN7zW0rMBxkZ2hxjJCxSKhC7NMeuLBm5wISVR5+tVYwAN3Bau0Lmn5mmYas2nOdavTiGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730984365; c=relaxed/simple;
	bh=D9azaeqcGPZHNKK8UaHfFN4f10M/JxGS9M2ytkiQKrc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IrUN7zCuHJl8jRCWQ7LW6lXTB7o/IkoOpsGylTdQC11l40XQvAzsf+6qHgVOyEKPeZJAPIkNY0R/83WD3t4niuH2usdbyoxpygfA6hm+73Rzu599eIWZoltblH1lhETG4K70Tib/3YooTbUamktzfzeDSoz/RrNgtTAjlYoM8QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s5givOdv; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539e8607c2aso905291e87.3
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 04:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730984362; x=1731589162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D9azaeqcGPZHNKK8UaHfFN4f10M/JxGS9M2ytkiQKrc=;
        b=s5givOdvQ1NVeG/2bwAgKn2QtXNV6VS3/HJgUKx1pPBUwUQAj7ZNakd6+N7QJoRhD6
         /x2BN0+9Wi+96A5kVIjp2RTaGtWIbCAdkCuK2trIr+slpmkKcZTQjXcOak6oYbNkbd7x
         x3pozHvM2bSGXLEqyURyeVzdJpUjmi3rTJKVgtetpZobXH4rQN1/HwhK43Ti8GgYqf08
         c7JvP4hSPGRB/dNSb/ea/UedHc9qjS5Gn6/oDr9L0eXZ8u0dFOOEJf+ELn8Eh3ftPCha
         uH42VxxVjeUqzhXnb+Hz2HMsKUJput9kE0o9ivf2iFI9GTVDH7gsVuC7vn0brJJYMTsL
         8rOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730984362; x=1731589162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D9azaeqcGPZHNKK8UaHfFN4f10M/JxGS9M2ytkiQKrc=;
        b=hotrHGo8Vj8ZlpMKFFETTHh6aFwwckmCJz6d2MTxdl5ig/aAVnTC4m9BrTv4210g45
         M7IMcfvG/tiC5AZbehEP+RTbQ10UQ9wmUOTel1kvvFzcr3AghwfRgjQ00IaEUNJafpad
         9d+dSYu3pJFwnFsgYOQX2QYGcUxAhEhkIuubraJOMrKGhVjQ8cz9xH7ieTqv2sVFHSAw
         scNEpp7E07LjoC+6MZ7NcYinBueWi3pUUJZln402kL/EZmEtSq7HzTusOPILPuX4vtdN
         ZZqKtc0ImBCQZ3tlfG32yz9i+uuba+R4pFfeg1e7VXIwr1jCy+m3qsghrxjwZA5vkalj
         c9IA==
X-Forwarded-Encrypted: i=1; AJvYcCWeve3SwM+B8wO899LuL7vJDqQXCt2J9E9Lg1mMwjgU7fZqquCvSE/3W1Tih/6905BC5n8KFRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5Vngt2TSWdXFWuuFdVhf6iYV08yz93jvqW8IWjqbDEW4x0l6d
	XehyMHrClh+UjQOCcz9vfSZFKVuhMzGhvw37yCx/09HpvtRusuxxpW8bBMbo1h3+C5W/6JlBlSu
	NeHX1uh+0Yqk89zLSCxceem/Bx92NL420P3rk
X-Google-Smtp-Source: AGHT+IF5Fj/HlZvf9iHKBddOaAWOS502Ay8be6gRTzxp4WGZHvguqRclJasr0m2+ZZjbSW2JJ+eLGAepIXaDNWPmSCo=
X-Received: by 2002:a05:6512:10c7:b0:539:fd1b:baf5 with SMTP id
 2adb3069b0e04-53b348cb072mr23974907e87.16.1730984361703; Thu, 07 Nov 2024
 04:59:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101010121.69221-1-fujita.tomonori@gmail.com>
 <20241101010121.69221-7-fujita.tomonori@gmail.com> <874j4jgqcw.fsf@prevas.dk>
In-Reply-To: <874j4jgqcw.fsf@prevas.dk>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 7 Nov 2024 13:59:09 +0100
Message-ID: <CAH5fLgg3aOoFAA5YEXinMsLFpBV0Q86VDizdbTb8unMQgFKnZQ@mail.gmail.com>
Subject: Re: [PATCH v5 6/7] rust: Add read_poll_timeout functions
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, anna-maria@linutronix.de, 
	frederic@kernel.org, tglx@linutronix.de, jstultz@google.com, sboyd@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com, 
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com, 
	arnd@arndb.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 1:50=E2=80=AFPM Rasmus Villemoes <ravi@prevas.dk> wr=
ote:
>
> On Fri, Nov 01 2024, FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:
>
> > For the proper debug info, readx_poll_timeout() and __might_sleep()
> > are implemented as a macro. We could implement them as a normal
> > function if there is a clean way to get a null-terminated string
> > without allocation from core::panic::Location::file().
>
> Would it be too much to hope for either a compiler flag or simply
> default behaviour for having the backing, static store of the file!()
> &str being guaranteed to be followed by a nul character? (Of course that
> nul should not be counted in the slice's length). That would in general
> increase interop with C code.
>
> This is hardly the last place where Rust code would pass
> Location::file() into C, and having to pass that as a (ptr,len) pair
> always and updating the receiving C code to use %.*s seems like an
> uphill battle, especially when the C code passes the const char* pointer
> through a few layers before it is finally passed to a printf-like
> function.

This is actively being discussed at:
https://github.com/rust-lang/libs-team/issues/466

> And creating the nul-terminated strings with c_str! needlessly doubles
> the storage needed for the file names (unless the rust compiler is smart
> enough to then re-use the c_str result for the backing store of the
> file!() &str).

For the case of c_str!(file!()), the compiler should do the right
thing. Not via deduplication, but via removal of unused globals.

Alice

