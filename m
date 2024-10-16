Return-Path: <netdev+bounces-136137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1299A0806
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 13:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FB38282DA3
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 11:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C5A2076C3;
	Wed, 16 Oct 2024 11:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nh+MQJlX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C459207A0F;
	Wed, 16 Oct 2024 11:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729076767; cv=none; b=FU4BHJtpDhIXy915ODO8uEcOYmak36HhKsZA3HaaDtPewOJQFBpaa8OCagbokMtTEJQiAIUsDfr/NUhN5reYj6yKazndl9nKOmP0/ZNHhNhV0CqD0h9B5gJM7nvmXnBMJmGDMmFTT2iULjpNYixvk4CTXkelRzj5AtlaIuu3nD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729076767; c=relaxed/simple;
	bh=FvJ0KCORjMo4bMaUmvvL6SpJ2bvMPPdd0gf8DMO03YU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MBdenWFubmhpovoNUEi8gkhZEB8Bbu0/qpR/tONbctSSOX33QcKuwf+uDSgVTcko0v5E/SWeWvPQ+3kFwk0qLfq2cxLGi7p5jdvBkYWo6s98n+brF7rBFISGMl2Hntnz2sfDg/4nD4GYKUbUmXMsDOzfKQcCCAYuLzSQJuDq9ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nh+MQJlX; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e2a96b242cso1163380a91.3;
        Wed, 16 Oct 2024 04:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729076765; x=1729681565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RbzBg/4LaoQCVNdwb8k0QQS7sblqJEBt4IfVZPZZdS0=;
        b=nh+MQJlXWT+RYRWpUmpaIesDAOzQmY9lOouJSQtoVThxUwGIDyc6ihCjKdDaUqLoPW
         e74+e2s8rOFQfWwik30NiehqowiaNZ+jiqdsdlomF+NDPW9lyOXEAaITKci8NfoZbewN
         B7JW6pbVnnH6lWbX3fkAi6wNmgdI9RKUdlxbzYMza3/fvdlT8JAlLZS5YiEjmuv0Al9y
         xh34bmUXdg7qvyJT/eI4LB+c+Vq0cGNTz2atkO+XLtpBoiZP5x1p35+SkL+9iJ9V7p4I
         klyHCxVAF4rM1Q1CusjiXUFa9E3kT5yWk0FF/b0HdayCo+w58ClvfGt4VnJUvInml7zk
         8x/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729076765; x=1729681565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RbzBg/4LaoQCVNdwb8k0QQS7sblqJEBt4IfVZPZZdS0=;
        b=GEV8ONx8isjUcB9w2VnKKKMB8HG7ALNjMnfnxkZc8yeyZwL0lU5ilH9QD/xvyVudst
         0AjSSVuyKkSFJKaMBzQA7UhWD79kDZE8DD8Mnf9XcWUkys0Hie6L8frQtgtGFZezRux3
         kON1E7QVQenMPkH1qbOB1E23iQM4+WCEBNW8hdJKA16TGaGfUYOe0x9dSZozAlcvvBd+
         haGPE6FcsOaHh5U5scnDRXJ+tNigeT6WS8pjNObfthCNVDsrx8S5a8NvbnLa+tBs3xoI
         eU7vu8uJPJN9JuVuriA3ZGLGo1rFke2Nx96ogKlVmLVa4ATohu5hpPF0+90si8RlPJI/
         1gLA==
X-Forwarded-Encrypted: i=1; AJvYcCWavZG/24iSrKOpU2ChtyvP1neY/oIKm4bJCvPQAvox/N5+tav6zlWXdQftGsK5fSKyfKoQvq5D8V2stQDauZg=@vger.kernel.org, AJvYcCWhH3BDMak7R4+RkLYb7VsT0BntfLSQkEfbHAXg681CCRAsBP/lToLvFRkY2hCmClTT3ugbQYz/lXjjAKk=@vger.kernel.org, AJvYcCXbg2XYwguZIKVsoJ5obeely+8V+g58+7E49+Cnm7MJqQfD/vtNmrlmn+gTNWttLukcjZLWPXe+@vger.kernel.org
X-Gm-Message-State: AOJu0YzOLTHSR1CcEF1rcHipmRHPTNELVNDrxH2mWz07Wv5JhyIlEI2K
	5VzruNOK+++aFl8abDJxp7VPXaydL8z18tyTv/EORhJaO5f+mggREhLH/Ne+eeoJxzFEi+JSOU0
	TiUnbHxnCzUgQFsjOqXpiRohtq/0=
X-Google-Smtp-Source: AGHT+IFszkUiehlmWYxXSKv1Saa+5hh0eHkvxXw6lsFmsoPrSxsOwY4GpE/gkmO7BvoPiJY8ctVN2scrplutqnZuhbc=
X-Received: by 2002:a17:90b:3013:b0:2db:60b:eee with SMTP id
 98e67ed59e1d1-2e2f0dd9e6amr9073466a91.9.1729076765548; Wed, 16 Oct 2024
 04:06:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016035214.2229-1-fujita.tomonori@gmail.com>
 <20241016035214.2229-8-fujita.tomonori@gmail.com> <CAH5fLgjk5koTwMOcdsnQjTVWQehjCDPoD2M3KboGZsxigKdMfA@mail.gmail.com>
 <CAH5fLgi0dN+hkTb0a29XWaGO1xsmyyJMAQyFJDH+geWZwsfAHw@mail.gmail.com>
In-Reply-To: <CAH5fLgi0dN+hkTb0a29XWaGO1xsmyyJMAQyFJDH+geWZwsfAHw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 16 Oct 2024 13:05:52 +0200
Message-ID: <CANiq72kmE7FHvRbNbSjJxrtyt+vTm6dCDPxLQ=JmZtBd4ZKgjg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 7/8] rust: Add read_poll_timeout functions
To: Alice Ryhl <aliceryhl@google.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com, 
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com, 
	anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de, 
	arnd@arndb.de, jstultz@google.com, sboyd@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 10:52=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> `__might_sleep`. The thing is, `::core::file!()` doesn't give us a
> nul-terminated string either, so this code is probably incorrect
> as-is.

Yeah, elsewhere we use `c_str!`. It would be nice to get
`core::c_file!` too, though that one is less critical since we can do
it ourselves. Perhaps we should also consider using Clippy's
`disallowed_macros` too if we don't expect people to often need the
normal one. Added to our list:

    https://github.com/Rust-for-Linux/linux/issues/514

Cheers,
Miguel

