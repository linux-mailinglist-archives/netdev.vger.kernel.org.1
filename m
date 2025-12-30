Return-Path: <netdev+bounces-246354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 309E9CE9880
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 12:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3ACFF3014DC8
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 11:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D2A2E093F;
	Tue, 30 Dec 2025 11:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ti49gbzS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69F528135D
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 11:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767094073; cv=none; b=lleKGa3L4v1XuRjm8JYA7WlkZcI5z//UriOhgf2xWiNCqhyn60d2LjlyQT1kL6nKRUWF+YQDojqvK7hLzofd838F1KW6RyIYEzayH1yAT683CCg4W/8pnQkJEi8/5IRkwC1/hC+4lQdoUCIgxSwoYJuG2DeOgVVmSN3cc1rVOdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767094073; c=relaxed/simple;
	bh=leJjdZs3pviKoCXS0m/3MT3MyFdHZGu1rGnoGL9HVgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vv2U7ZX/PNLwN81AezpM8NJFT9AVn5/PhNz7kGuPalDDc46BoTRmxcUfjocX31FAIZbT72trZ+TIGGya2Scn7LrJAb8xRGxbxFxOrJr4ImV3WqM8NpAFivTeMvZLOo8Fie/ohJk92yLNgmtQGfgytwZp2OMxFgMDFqzSsbUykTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ti49gbzS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80431C116C6
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 11:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767094073;
	bh=leJjdZs3pviKoCXS0m/3MT3MyFdHZGu1rGnoGL9HVgU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ti49gbzSK+3E1pOw/5IncIrVOsvkDHW2qBjnUsqNvaiKxesjNE0jylbzuEGsEXv11
	 6jgkCBlOReHf5h/PaK7Ids09+SY5Dcyu27oOF+XoR86c834zfKKF2AttUCIesEbhXg
	 6j/WUkVD2MMtifQ9xewwF4rtD4YAFbLXSuWutQVQJUzoRVAQKO9msdiHMW5526TKGx
	 5H+6J+CAQPvDKMqNam1KaR+dPiqZzrCMgBWgh0Uo7sa9CyGgNlzHs5xfMDC2zR6K3T
	 WmpHy/Khh5JNNKACEQ/icEuKC4I5U6uukDo2dd5NAhNgcJn6Y7hqaQm8NJpZfxH50y
	 +3t9TmBo2PkBA==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-37bac34346dso73651571fa.2
        for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 03:27:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXwGqfDjSZEGKtoSyjsVF7pd+kwuTwYMFAv/w5va/FSe+EwFeLblI6NH7wYqva3TrOKNJZtG8U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5p0HIR7R1hcEnMeeEGbVEu9OKWQeUJfFIGpwms4eKu14Pm0qg
	jn5RvHoqqIue+DdF+B2y4+6uKQQN88eHbH3mfekDQScVSo05pZ/r+u/f/ggf6Gm7URbVCK4511v
	8Z3pZfUnZpF+lnrQuWI08G85gH845Zv0=
X-Google-Smtp-Source: AGHT+IHPGzwFVfZohXUlwjkwrktoaQn/snnrlmsIiwWkSfWvcb7/V3Sk+I1nUkYo+gWEKKlylRQqCdNtOtziv7NNOJs=
X-Received: by 2002:a05:651c:3043:b0:37a:2c50:c437 with SMTP id
 38308e7fff4ca-3812158e42amr88523171fa.14.1767094072078; Tue, 30 Dec 2025
 03:27:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251222-cstr-net-v1-0-cd9e30a5467e@gmail.com>
 <20251222-cstr-net-v1-2-cd9e30a5467e@gmail.com> <44fd3760-5a01-43b4-ae68-31e6d3c18dc3@redhat.com>
In-Reply-To: <44fd3760-5a01-43b4-ae68-31e6d3c18dc3@redhat.com>
From: Tamir Duberstein <tamird@kernel.org>
Date: Tue, 30 Dec 2025 06:27:16 -0500
X-Gmail-Original-Message-ID: <CAJ-ks9kQj0bSAA0j0MRhbvSk7OkMqAaFuw+TsS9HMEgjqyW6Cw@mail.gmail.com>
X-Gm-Features: AQt7F2okjrDKa9fg1wVEDLsM3rjbX7E-R6aE5Wu4ax-TgUelKnLl6vfiY44CrNA
Message-ID: <CAJ-ks9kQj0bSAA0j0MRhbvSk7OkMqAaFuw+TsS9HMEgjqyW6Cw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drivers: net: replace `kernel::c_str!` with C-Strings
To: Paolo Abeni <pabeni@redhat.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, Trevor Gross <tmgross@umich.edu>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 5:40=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 12/22/25 1:32 PM, Tamir Duberstein wrote:
> > From: Tamir Duberstein <tamird@gmail.com>
> >
> > C-String literals were added in Rust 1.77. Replace instances of
> > `kernel::c_str!` with C-String literals where possible.
> >
> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > Reviewed-by: Benno Lossin <lossin@kernel.org>
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > ---
> >  drivers/net/phy/ax88796b_rust.rs | 7 +++----
> >  drivers/net/phy/qt2025.rs        | 5 ++---
> >  2 files changed, 5 insertions(+), 7 deletions(-)
>
> It's not clear to me if this is targeting the net-next tree. In such case=
:
>
> ## Form letter - net-next-closed
>
> The net-next tree is closed for new drivers, features, code refactoring
> and optimizations due to the merge window and the winter break. We are
> currently accepting bug fixes only.
>
> Please repost when net-next reopens after Jan 2nd.
>
> RFC patches sent for review only are obviously welcome at any time.

Yes, this is targeting net-next (unless you folks are OK with it going
through rust-next, which is also OK with me). Thank you for including
the date to resend.

