Return-Path: <netdev+bounces-137273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F403A9A5434
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 15:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C65F282D0B
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 13:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6625191F7E;
	Sun, 20 Oct 2024 13:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzedDcP+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08FCD299;
	Sun, 20 Oct 2024 13:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729429552; cv=none; b=qe34VKrtx9IftDnAE4u2Ln53mhMm+dmG2qL8mN3OSJYbIf9e355k5c3QElg6+PfG6JM6FySolCekuX0CiVxTGDJXPF0/72FvQtvx4RVMVQ1F/3NifmKGjH0Q6le7LvuxajbQiMbf7K9mxRGuPM21HzoTOa1PVGjphSGKqwY/808=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729429552; c=relaxed/simple;
	bh=cj4wCZfi9pHUGITp147bbLWoaPids+hjvKMuvLjjgPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S2mSB6VEm++UeZxT7go0NGScJQIqAT2qFlWPx8djQcVoxHrZ3CPue0mUE58+amiS7H6lDSPrFEnt71ktF+08qehllgsjj3fMHEA/2CrbNqL11kwZesiNwiHkla22FNn4/JWSABjiXAvDlDdNLHiHWMkg9NOI2ARCM3POVgisY5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NzedDcP+; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e2e31aacbbso522072a91.2;
        Sun, 20 Oct 2024 06:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729429550; x=1730034350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cj4wCZfi9pHUGITp147bbLWoaPids+hjvKMuvLjjgPk=;
        b=NzedDcP+w7fj2Yw6gOp4gpbrRa9mKZy+ytlaSfoOZCs8QgbXfQ+Hl4G1ykP2QGxi0y
         /3Fv8idxJyN4Nver7bXNGuKKzKnKELwfCbKQPS7Q++1rXBkRnlTWm6W7dqyLyOTs1ko+
         7TMdelM9mpFg/t0zYEc6C1+PyGhJFkz50OOmuRldek89mLxYneW6dSD//0GzcQHk35ib
         5Pv9ULSTKSny7DPy0oBs8d2j2x8mBT5hCW9GubFejteUcZjHKqr8BPW8vgBiOwtBjP7/
         GAtVXX+d1BHnghdrwtQOl5dJE/Ct6es4HAOvRBze+6tOMz+LQH2jkvlrftVxDBOzUwnh
         SBag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729429550; x=1730034350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cj4wCZfi9pHUGITp147bbLWoaPids+hjvKMuvLjjgPk=;
        b=GGjvT7H8FKVAq6c8d1WtSI5YENBr9bNyH2u8VLJRKHr7zVEeHtDbgvROfAGOl49kjb
         ddDmO64yBiPOaxbk0eSu3QtliOFzYbbkfzQfJ+K3LlFlljaYLMzpskx3NIIGaDPZWXgG
         wumUHOV70nA2XCBftZWxFfxY9RP2AwEZgxppoWwZaPw2bTUdh0paDU8RTNFlehZX6KYB
         Vkbzv5MtTyHgqq22sBdVsw5MgCui6qBvT62Q5OTRgoJcyWPIlXPUMOr7ZR94zVhfjXYR
         e0V6ctJR6a0r8cJSZkHhrpCvcG1MrG7hJiHqDBt6a0l1Nx4EioJQpBuyoLZfAAjymAjS
         +Kxg==
X-Forwarded-Encrypted: i=1; AJvYcCVkoSHPFm85YfKkZDIhc1o40TNL1QHhpZmtGnJFs0jJi9YYXtuEo0dmj66+XpD0S1UCIjUjexBDISpUXUS9veY=@vger.kernel.org, AJvYcCXL3ESfs8U1FLc5R7cPX1QanEzmITtkhyTq6f6oqp8gkTeReBeO8PkZnq8+pK73yBFRrCl0S6gS@vger.kernel.org, AJvYcCXjEI7bVzmsyDVg8ODQ0K8bveOntylgplfMrkjLSaRuNxav2D3/q5/ZK0HZqeDB+RHSocyWjF5/A2NYODQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9HOFMy3xsjbA2xhvdAygwhRFuINc141BYj1t5IOOsy2Qia0+i
	kqqtx1W2weLEOOeAQPONjI9GsYbVnPxdzLoGx/xpmy2fGfDuITPbyWIaENWQFKUf8WMOIciuOP8
	/VALS0ftyMXVxQJSvVC6za4JwuTs=
X-Google-Smtp-Source: AGHT+IHI5nrAb1fwyAgaJpxdX5zEivzTyqB6sYY5KC4U+kkCD8Fn6Z4uBiA9Vq/eo5l06KFgu+E4H9+/KUUR3JsdYkg=
X-Received: by 2002:a17:90a:f189:b0:2e2:a70a:f107 with SMTP id
 98e67ed59e1d1-2e5615d618emr4290516a91.1.1729429549807; Sun, 20 Oct 2024
 06:05:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016035214.2229-1-fujita.tomonori@gmail.com>
 <20241016035214.2229-3-fujita.tomonori@gmail.com> <6bc68839-a115-467f-b83e-21be708f78d7@lunn.ch>
 <CANiq72=_9cxkife3=b7acM7LbmwTLcXMX9LZpDP2JMvy=z3qkA@mail.gmail.com>
 <940d2002-650e-4e56-bc12-1aac2031e827@lunn.ch> <CANiq72nV2+9cWd1pjjpfr_oG_mQQuwkLaoya9p5uJ4qJ2wS_mw@mail.gmail.com>
 <fad19413-8d58-4cf5-82e6-8d4410fd7e50@lunn.ch>
In-Reply-To: <fad19413-8d58-4cf5-82e6-8d4410fd7e50@lunn.ch>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 20 Oct 2024 15:05:36 +0200
Message-ID: <CANiq72msOTdVLjX+7+Xx4Si2Sh=s1M=wrg_T+QkpFyBHSC9gwA@mail.gmail.com>
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

On Sat, Oct 19, 2024 at 8:41=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> So far, we only have one use case for this type, holding a duration to
> be passed to fsleep(). Rounding down what you pass to fsleep() is
> generally not what the user wants to do, and we should try to design
> the code to avoid this. The current helpers actually encourage such
> bugs, because they round down. Because of this they are currently
> unused. But they are a trap waiting for somebody to fall into. What
> the current users of this type really want is lossy helpers which
> round up. And by reviewing the one user against the API, it is clear
> the current API is wrong.

If you are talking about Rust's `fsleep()`, then "users" are not the
ones calling the rounding up operation (the implementation of
`fsleep()` is -- just like in the C side).

If you are talking about C's `fsleep()`, then users are not supposed
to use `bindings::`.

> So i say, throw away the round down helpers until somebody really
> needs them. That avoids a class of bugs, passing a too low value to
> sleep. Add the one helper which is actually needed right now.

Eventually this type will likely get other methods for one reason or
another, including the non-rounding ones. Thus we should be careful
about the names we pick, which is why I was saying a method like
`as_micros()` should not be rounding up. That would be confusing, and
thus potentially end creating bugs, even if it is the only method you
add today.

Again, if you want to throw away all the unused methods and only have
the rounding up one, then that is reasonable, but please let's not add
misleading methods that could add more bugs than the ones you are
trying to avoid. Please use `as_micros_ceil()` or similar.

> There is potentially a better option. Make the actual sleep operation
> part of the type. All the rounding up then becomes part of the core,
> and the developer gets core code which just works correctly, with an
> API which is hard to make do the wrong thing.

That is orthogonal: whether the sleeping function is in `Delta` or
not, users would not be the ones calling the rounding up operation
(please see above).

Anyway, by moving more things into a type, you are increasing its
complexity. And, depending how modules are organized, you could be
also giving visibility into the internals of that type, thus
increasing the possibility of "implementation-side bugs" compared to
the other way around (it does not really matter here, though).

If you want it as a method for user ergonomics though, that is a
different topic.

Cheers,
Miguel

