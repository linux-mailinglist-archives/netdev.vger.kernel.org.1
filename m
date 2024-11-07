Return-Path: <netdev+bounces-142828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C699C06CD
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 14:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E54A1F2124A
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 13:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66B321732E;
	Thu,  7 Nov 2024 12:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzlypA08"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE43212179;
	Thu,  7 Nov 2024 12:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730984393; cv=none; b=XImVXK3CzBkjHQIJBaOEHPb5TZBXuU7BrxS/RZzC50aay3i8zfSCwhZbu+1PPTAU3DSDghTd9EWhIAXvYrifWFlabTxs8Id8CpW5UPbuE54k+Yu8/QYjUbK+Mi/eTGh5d96kcMvVrmpSXRDS+zeQRyCnuliU7DPfz5opbXO/kx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730984393; c=relaxed/simple;
	bh=QxPChqjdcJEWMbrtVvHw6owuNtm8v++Q72liDEtCXcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JjHKSO0UGYnGBtWkg9RKkhMaMmxWSjNm23NTwwZVHE03xGZQD+2pqf+0dn/6JOfPQdCeO5l+tPWwGKw0Lw8wmJKKbqpXQQbSdKd6nXwPuqA1eIQPHjmEB3MJ0FgHKleaXLyEpvLCJoVzTsqzARerN7FiFgLTlbf4zRLvfB/4JM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mzlypA08; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e9a5ee0384so31307a91.3;
        Thu, 07 Nov 2024 04:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730984391; x=1731589191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZYOVVplfIl011xpO1BxLjMYC7SEtM+knBwgfgXmvRME=;
        b=mzlypA08lAvsIUB7aNPvbNwH4taVtGVrPrwIUuny0aqN669Us6HA8oEZWRd9Az0noW
         nFvsYwZ1Wsrg4ZJ7YG2yAwu5dC3s5dVsDpgqLDXrD/cyq6k0dQEWv62vGm5pmqguQWXd
         iyg3A9EhyQ9Q6CSn25I92zSZTPMiArT99V6ypSwc1TDdZM9P6+UYpyy+c7EweZl7I2YW
         YN1PBwCmmfYxF/n8pbV5iLvPSjh9Lc9ioUh8rffX5lQA3kBl5L5yqBddsGItcow8JSOb
         M16bYs2GSQ5TItHJa+yhMfASLXYbpvsQTuoVt0V86caA1whrIvY3/BDetBV5zEkchXCc
         V32A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730984391; x=1731589191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZYOVVplfIl011xpO1BxLjMYC7SEtM+knBwgfgXmvRME=;
        b=heBqnNORyH0XTIkvZELJDnkV5RQ1TS7X3W+vIDj6KcsEUNwybazyx+UIst3g49+NfN
         HucTHFaee7c5x9JUn3MR/uUEstT6VsRVzqZ/QcJ2U/DWZ5STYgQYIbo6IvJE27Wxh/6D
         s1mqINz519uSTqVVsHGOZlFElGOt44g8/MRk1lLSIF/rXgSsFHj+ZOojnxxubW3F8DY2
         xFm3bITcQmHTLRNYfkZm7mZ40g0zjuuOwOrbeAeAtoMx1kENnyfNsjDBvossUSCNZOaZ
         nFF3fXDG27K+6FXZBQOBiTMeToNdKBFA85Ily8IMb/IVEVQHAwhgoM99eTJCthw9HDEO
         ipFw==
X-Forwarded-Encrypted: i=1; AJvYcCURRBUvwXBNlpKLSyRxufJv7Dxmhk8blP/0b54asColtvMMf2xVia0BklizOpjgf/9FpMiYaEwj0RwnudI=@vger.kernel.org, AJvYcCWGNdLJJqeRuhhJ5WwBD22V63E+jKqhR0osdI/p/d50fFH33ZbpMp7+Oz1jDjEJtnT8QgE5F3zL@vger.kernel.org, AJvYcCXAlpvYOxMpPwAISd1UmgnKHDub9V0NnjRjT8mShsp2Dyl9SKunaF8DwKWComcFWIHGk9IT0HniPWYEzt3XYjg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw41+GbfbwNkB9WtQUw0cnAiOyxon1cGNKy5yFTyAcUTGdMYVNB
	B0Ez+5sBI4pj+GXQPCe2e8RpsYX8P9fZZ6aYH3+AvhtnGJvR3tjnOl1a0iLnTYzObunn6afSRQF
	6RwZy8etoFf7oAMW96mH3ArB904k=
X-Google-Smtp-Source: AGHT+IFh5MN0OijT4FCFBKHJaqYfdN0+sLi54lYZzps/2xAwCH52vejN9uQjQZJyom12OQxa8UNsXklKue+bujQtJl0=
X-Received: by 2002:a17:90b:3911:b0:2e2:c423:8e16 with SMTP id
 98e67ed59e1d1-2e9aafcdf82mr563777a91.1.1730984390595; Thu, 07 Nov 2024
 04:59:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101010121.69221-1-fujita.tomonori@gmail.com>
 <20241101010121.69221-7-fujita.tomonori@gmail.com> <874j4jgqcw.fsf@prevas.dk>
In-Reply-To: <874j4jgqcw.fsf@prevas.dk>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 7 Nov 2024 13:59:38 +0100
Message-ID: <CANiq72nEwr52e1O-+jGFdrNnVRN8imq=mt1Nyow9mwRaxSocSg@mail.gmail.com>
Subject: Re: [PATCH v5 6/7] rust: Add read_poll_timeout functions
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, anna-maria@linutronix.de, 
	frederic@kernel.org, tglx@linutronix.de, jstultz@google.com, sboyd@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com, 
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com, 
	aliceryhl@google.com, arnd@arndb.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 1:50=E2=80=AFPM Rasmus Villemoes <ravi@prevas.dk> wr=
ote:
>
> Would it be too much to hope for either a compiler flag or simply
> default behaviour for having the backing, static store of the file!()
> &str being guaranteed to be followed by a nul character? (Of course that
> nul should not be counted in the slice's length). That would in general
> increase interop with C code.

Definitely -- please see the "`c_stringify!`, `c_concat!`, `c_file!`
macros" item in:

    https://github.com/Rust-for-Linux/linux/issues/514

Relatedly, for `Location`, there is "C string equivalents
(nul-terminated) for `core::panic::Location`.", with this ACP:

    https://github.com/rust-lang/libs-team/issues/466

Cheers,
Miguel

