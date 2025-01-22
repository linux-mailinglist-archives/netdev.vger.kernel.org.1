Return-Path: <netdev+bounces-160247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA18CA18F99
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 11:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD75C3A769F
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 10:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E587720F970;
	Wed, 22 Jan 2025 10:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPlwwa9f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E998145FE0;
	Wed, 22 Jan 2025 10:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737541325; cv=none; b=er2Q8yFCHSZs4Q6U+vmurE96lA+LO+WFigWnhKcf6z2nPM0Rgzc9/FzdKDWHXkztoP/T73TvUfYHOiEtfZXxXnKgH+nlvkiTMj0GhWxajxQtxNoDXPQAKDin/5CKfySW4bEh96Jypiz1IXX5sWlny0LeDKRRo4/4kR8Dnlyu3/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737541325; c=relaxed/simple;
	bh=8WRgsVZn6YDQoweCWaTyk5dOaQoi1J3EUul3UOhkscw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sJJ45z0vJLWTr5iKyFTklZlIGKOTgPZk1QW44vnkezrLlnhBtgNyfRPAPp+39ZXdYJ5dzEBltJiL2rQ3MzS9Sw1bEXndtoAfJLj7WFOhzo0lXrEYUHK0KSxxh3VEc5uorrprT6hQYER7Ro/j8RJ9R2c6URloYycOZ1ZXim6Wyoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPlwwa9f; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2f2f5e91393so1443274a91.0;
        Wed, 22 Jan 2025 02:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737541324; x=1738146124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UTV4Wm4e6K9JxtAYNKZcc5xcEw6GFtqEWLoBb2B+6fU=;
        b=TPlwwa9frDbfWnD0vgBgnP5cp9VkhNCIyT5A2eV2BjG6j9c9iajvUiaSvJJOp+FSFV
         K85x/NHOZ9oXU+L0xM+OrzksYeQqNAKZ7QFuz1LZ+fjuotAjXRRHwzCB1ztedBN63ezI
         J7NHEq9BEVbsTq+Y2A15bvdjIS3CFTM9F6RkZg0dcrM9TfdC8ebCXQdkrkHd75Zq64VK
         OZ9TTK2d1jQGJRTLcfO284OXkfLCbnjoHt7rXA6onSVUEWUhWb7cZkS7zkVDxbeq61uw
         fQVj69GBB1xzdTQ0nyL4buYQ1ds9QmMq2O3xFIB6rgmUTjkP+o6SKmUPR0wHEYkEkl7t
         qRCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737541324; x=1738146124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UTV4Wm4e6K9JxtAYNKZcc5xcEw6GFtqEWLoBb2B+6fU=;
        b=Z4lTjcEkoxR3aCEEtHuMSF2CnBrEZ/v/JE9pOVpKRrjHTtejFmZy340M4kSqZmqY9W
         7ZWk28UAQUkMVzhIjX5255nGI6BPT6xQuzAnyEaYLIYh+ihy46esdnz5B7s3nKMZnBkP
         hEgtR0fp0Fngr1H7RR6NdnS/ByrVjhiFSE8wGXbZ9hmyjmsvCXAM6cx8sXdVufYzE0b+
         JbIw3cr5fCbNIA2okwWcuasY61Fpw5DPCGt0qqEG+N/mUnXNmDy5dCSzUSkST2wiNosS
         wMqd73P4uC5SiCcs8R2MAoNVtDe8hu+Jm/njaBNj7ot7JfjmXRGJ46txtHangwYvNY9i
         gdtw==
X-Forwarded-Encrypted: i=1; AJvYcCUk/rclIDdG+7pQepc80YuhL+smfclFhjaiFDp9DIdSGATIjobvmWCJgDF+rwOI7l9k076I9Ww=@vger.kernel.org, AJvYcCWuWrz2hpemOMXCSvnRObIKX2vRZZDuc+e7/0FqioexFoodvOi60gsqpq19r2Rdm6WpjVC3Puh+N3s5vhqxnkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHZgMN9fouoO6uldevWZeUmhfMljWNkE7VxXRDyd/ZTz/my17z
	A4wtlqBpXH3LkMMkACbU01utDPBTZq5vspZfsbi9UVcACS5ocW4KRRZfHqKPiVMQVB8eqP1aFZ9
	vQFmzXNOak23JbWLdSAPNVinG4ss=
X-Gm-Gg: ASbGnctljrJs8gbEZ/7yj6RjhbzgsF+F/IrEwuZZl6YZMyY0mvMaQjq3Z6nF8hKBRh2
	cGHpaJa152K3HDulQ9RjA/6CzeiYaIyKiWnE0xwuSR4TCbJzLYNQ=
X-Google-Smtp-Source: AGHT+IHvp+JfGT24gLHUG8TiwUPSRFuqnrD6G+YLWHFY6TrywtNHhVsl5Lb82x5DTO4a3uC4K6TcXns13ds6lJ7BcIY=
X-Received: by 2002:a17:90a:da86:b0:2ee:ab27:f28b with SMTP id
 98e67ed59e1d1-2f783295929mr10773071a91.7.1737541323593; Wed, 22 Jan 2025
 02:22:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72nNsmuQz1mEx2ov8SXj_UAEURDZFtLotf4qP2pf+r97eQ@mail.gmail.com>
 <20250118.170224.1577745251770787347.fujita.tomonori@gmail.com>
 <CANiq72kqu7U6CR30T5q=PvRam919eMTXNOfJHKXKJ0Z60U0=uw@mail.gmail.com> <20250122.155702.1385101290715452078.fujita.tomonori@gmail.com>
In-Reply-To: <20250122.155702.1385101290715452078.fujita.tomonori@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 22 Jan 2025 11:21:51 +0100
X-Gm-Features: AbW1kvZtr-GpB0BuJvOVkB_nIn9G6ofj7pyHWwEpCX8sJW0HL4pAPgVqzfiVwFI
Message-ID: <CANiq72=xwhu21YJ+HEXhF1Uk_t1tuffphRgF4wAGiTc-JYcJVQ@mail.gmail.com>
Subject: Re: [PATCH v8 4/7] rust: time: Add wrapper for fsleep function
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com, 
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com, 
	aliceryhl@google.com, anna-maria@linutronix.de, frederic@kernel.org, 
	tglx@linutronix.de, arnd@arndb.de, jstultz@google.com, sboyd@kernel.org, 
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025 at 7:57=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> Agreed that "the C side" is better and updated the comment. I copied
> that expression from the existing code; there are many "kernel's" in
> rust/kernel/. "good first issues" for them?

Yeah, will do.

> You prefer "[`fsleep()`]" rather than "[`fsleep`]"? I can't find any
> precedent for the C side functions.

There is no preference yet. It would be nice to be consistent, though.
The option of removing the `()` in all cases may be easier to check
for than the other, though the `()` give a bit of (possibly redundant)
information to the reader.

> Yeah, simpler is better. After applying the above changes, it ended up
> as follows.

Looks good, thanks!

Not sure if we should say "Equivalent" given it is not exactly the
same, but I am not a native speaker: I think it does not necessarily
need to be exactly the same to be "equivalent", but perhaps "Similar
to" or "Counterpart of" or something like that is better.

> Ah, it might work. The following doesn't work. Seems that we need to
> add another const like MAX_DELTA_NANOS or something. No strong
> preference but I feel the current is simpler.
>
> let delta =3D match delta.as_nanos() {
>     0..=3DMAX_DELTA.as_nanos() as i32 =3D> delta,
>     _ =3D> MAX_DELTA,
> };

Yeah, don't worry about it too much :)

[ The language may get `const { ... }` to work there (it does in
nightly) though it wouldn't look good either. I think the `as i32`
would not be needed. ]

By the way, speaking of something related, do we want to make some of
the methods `fn`s be `const`?

Cheers,
Miguel

