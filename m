Return-Path: <netdev+bounces-239194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 797CAC6573B
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 18:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D6A974E29D1
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 17:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4ED830C612;
	Mon, 17 Nov 2025 17:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rj+T6bvq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C650D309F18
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 17:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763399532; cv=none; b=nfOLEbamGsr5t02HjoGHzJtcmnqRIP3Vpnw7mvgHr+jHYljxnN4zAEVrQsb/7aifpcoLpKjUO3AsovEl0eyp5iuKKr5CfVWdyxM6Rbp5xs8ECnHLd76GmdxffHtlDXkdlhy874G7lsWKeeubK+hB3MslTJ3ey6u9uw0p1Wc0qjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763399532; c=relaxed/simple;
	bh=zlUc4wrkb7uexfNnlaJ0X3CQbC6SS+1/TLUIDSJM034=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QT77ItMx6zDrh2XtdEDtclLNTH7Rh14sUi4vGEkhJp73dpanBu7lsg3Uqkj7CyTlRsah8B68urOAohTv6m7m1zm5IsCZqk54RNUiVs3dOlmwNL4S+4MjLSgPfkWq2IH+jKor9nvDrhOHYexAAApCHXEMt3b/knMKDGXJ+tXrgqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rj+T6bvq; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-376466f1280so49815251fa.0
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 09:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763399529; x=1764004329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RFsQ1+FNuisUabhvP8EGuIN9Ox5iFHJYhKLw4CzRep4=;
        b=Rj+T6bvqG6OHsjc41HGGOhKju5nGYsRg1YeE8BKybh1xcZHP0IfB9q0MOnwnfDUF5u
         LJWLGUJkJpOba/mIVvp//tz+npf/rqtu1P2DcphTWYnRsQOzjZzEIuWmytzq8ftUcdVV
         64wg53EHYAsFmunUnFU3CijJNaDWRcZvWXBpFCTTE1H6Agjx0WCy+JTE/u5mDcsnZyBh
         ikgDi03ytdChF+6V/a07p90f226NinYg62MWRludjco9gjWzAs+LAtAZk6tVGIGvsL0K
         xIKOODHOHgdE5FAbrSNWsFcy/5NkYZADe8T0Z31BffZbRs7D6LiEnIOU+k457y8zSeGw
         F9lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763399529; x=1764004329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RFsQ1+FNuisUabhvP8EGuIN9Ox5iFHJYhKLw4CzRep4=;
        b=xR37B9uYL6JNAdw0XgVYKedfYLtNamCgAtqWE2YTR0n42/MRbgiGos6+GYISy3pz1f
         z9OEdbYJ33zpEPjNA/hvU7eAbuZ8UVvYaic6vNYIjwlKcFlStqOIlew0RyTwqiTpK3ju
         2cEXjr5f+MCE9g5EfpI/b8lRyQi4vgk4ypqnA3znxifzme07bqbyNaiX+bkjebtJIsbx
         WnChAmjxshBHpanjYTD6H+rcbGtU+A9nOqZcAqxN2jK4fvp7zVmK3fQufDyCnkiIXw4U
         Uuxj0UDMZOHGk8iY3Ipm/PX0Jb8qF32ogWn06Plbvr+m2NcQRRAJX9JuS4Dae8l6/KyP
         1LJw==
X-Forwarded-Encrypted: i=1; AJvYcCU07FuuLdiJkhRd5PUgpF+JFjo7EdOyKkxEvpUHr7hY3BtQZQ2v1GifKxGgke1AqMJDKC+gNEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwTzOEkYP0v6AjXDBOciyyJAjzB41jl4vFgCaiEzurDlAF9QsU
	cQHmL52L6VoSQd1NfvA8TGsJw7RSRr8AC8DGhI9aavdf+w1O7RHUkaw1X/dtZTJ7cR9cJxJTVTo
	9omOLbUffbG+qhIKudL1DHNfAAPWJZ74=
X-Gm-Gg: ASbGncsEvU1sWu+z+PnUzlEMlDk1wXed+XjrjaMD5ftdHwbGLBns1cqf297njYT/aJn
	Vmopa/oPGnzZTmhESnGD80Ill1TW3/E60cjfKdG3T6ewqrmSOaf+4XW6z/aWoTLARgp9hcWQsRi
	eN5mRmmp+ig2xbl68lwxJCwun3TVQcw7NLimM2uUvdknHOBjIXChsXmmo4XIm6dpHPJZS6jy5PX
	kd7aupebMSH2wqcsWDP2wFOG/9RfRwsyfHRZA3PObpSylaFEygL2YFlgsZtSPRme3KJaPiONl64
	Ji0x6sp7nH4btfBEP9mQMt/VSAyDy+bmSAvUQqlTdU/M/8vxkdNfUA9YmWc0xUUlRdofKM+AkmB
	QKW/veg==
X-Google-Smtp-Source: AGHT+IFszS39w4gyBp/ehwuAxtCUH8C08PjzRvdcYZ7F1mfYB9spnDw3ySKrBPh6xcHzbycXp1H7Lxw5DqNHFEAdHik=
X-Received: by 2002:a2e:8a9c:0:b0:37b:b8c0:b5ec with SMTP id
 38308e7fff4ca-37bb8c0b6e2mr15580541fa.24.1763399528680; Mon, 17 Nov 2025
 09:12:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113-core-cstr-cstrings-v3-0-411b34002774@gmail.com>
 <20251113-core-cstr-cstrings-v3-4-411b34002774@gmail.com> <CANiq72mBfKwXEbyaw=pBAw37d7gCLVJqHcLcd6H7vNKey1UXfA@mail.gmail.com>
 <CANiq72nQhR2iToP8ZauwAjM2p1OWEK1G5cjsEXqs=91s7jOxMQ@mail.gmail.com> <aRs1-KshwnBjIIuQ@google.com>
In-Reply-To: <aRs1-KshwnBjIIuQ@google.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 17 Nov 2025 12:11:32 -0500
X-Gm-Features: AWmQ_bmRFAqmfhrzkLnE8yUQroFLwLVQEZRKlJSh6ngKy6V9tYibsuHi6Nvh8Js
Message-ID: <CAJ-ks9=whG4K2s0vhBetGAaCHtFBXcHETWqQjVh2DWciYK4Xdw@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] rust: sync: replace `kernel::c_str!` with C-Strings
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Russ Weight <russ.weight@linux.dev>, Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	netdev@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 9:49=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> On Mon, Nov 17, 2025 at 12:52:22AM +0100, Miguel Ojeda wrote:
> > On Mon, Nov 17, 2025 at 12:09=E2=80=AFAM Miguel Ojeda
> > <miguel.ojeda.sandonis@gmail.com> wrote:
> > >
> > > This requires the next commit plus it needs callers of `new_spinlock!=
`
> > > in Binder to be fixed at the same time.
> >
> > Actually, do we even want callers to have to specify `c`?
> >
> > For instance, in the `module!` macro we originally had `b`, and
> > removed it for simplicity of callers:
> >
> >     b13c9880f909 ("rust: macros: take string literals in `module!`")
>
> Yeah I think ideally the new_spinlock! macro invokes c_str! on the
> provided string literal to avoid users of the macro from needing the
> c prefix.
>
> Alice

Makes sense and done in v4 (which contains only a small portion of
this patch and no others).

