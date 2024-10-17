Return-Path: <netdev+bounces-136644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 903C49A28E8
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 18:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 258F228184E
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 16:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBDD1DF248;
	Thu, 17 Oct 2024 16:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGNoaW4D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32311DDC19;
	Thu, 17 Oct 2024 16:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729182818; cv=none; b=KTVs9QcL80/Iaw9LE5sSmMKsHpbgVZhr74N0U6UXxVBMlSuuLMYFBpv8OKyjUF0Mj+6oKXY8lzdur/M1OaWotSSA8VAomuE5qYNuDGHmCuiE0jsU2qpbFr1nqcYqwR8m57BQKN+R7jT+pKqnyicd1QabjHnkIXaHGqvYk4bIk6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729182818; c=relaxed/simple;
	bh=Y/Fv8WlA4kBpJ6T8HDyPceRLrCK+OaV2GxBkjIvdiHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GQGNSbBfmpQCTYEaN/14w5Du6u2EpSFAao0WyytQ2rrZ3HW7q2dT2DRl8HScyJVt7Y9P/Zc6wQ+FpXVHah1MV7H0vrcNVtRIoHI2Rob0k6WOwBOIeMHLFKXchja2Pa3Uoa8fmBhfHL1wTuVr5hTKZSXZShNkZVsIqXJkhCw7AEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGNoaW4D; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e2b720a0bbso197800a91.1;
        Thu, 17 Oct 2024 09:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729182816; x=1729787616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YaO0cP4NNuM6HOzNpmw/6nQp9mlOm8VZSS1Wo8VK2sY=;
        b=RGNoaW4DCl97U0RiyDjPfbxPs+DGbn+75ZwnnFkyMFk0BvaQusW/YiiNryjEXT2iWD
         uUwZm45ZjQMcMqS2akjfpX5V/bvY9wHtj26+gTmkKO26kmSGdxx+P7tiTSmjzs0RH3JO
         BFQA+UsqaWp3043xhitUdE9RnPTEG9MM4KHa0uqdDxVNm584/pZfPBu358U9yDoZueUZ
         IKI4favCI9C8dtON+ZREl1/K34CQKWVloQyjlP7SIvyEbw8InIl/c+9JXZeTjeE77zs+
         uUHl2QrmZ9beuzc7I2t9MO9diIk2MDGzSprcxufnWvvc8CzG9kA41VrY0kXnPh1eKEyt
         YHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729182816; x=1729787616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YaO0cP4NNuM6HOzNpmw/6nQp9mlOm8VZSS1Wo8VK2sY=;
        b=W37/PKRUcFx39z9H+en3fHCCma74Y3zomaVcqauWEdUOYBChSVwiZ2LJkFjswI1z4r
         dRdjpIZpVmYuknZ6OyR8tDUvhQNTWltL4oS4YnCYuKHhnieZVFSUTbDz3bQlZsfbf9VK
         v5Pfw1kNFpmKJy9f/LLYda4Ymj7ptkrL/tyLsmieMVBCrzvW/gC/6WBvnaGZbSQ9xUlD
         MW5NPut+rEL8NdOoMAvF8dJMmXQWdP8xlgqTYRaiM/Bdtv8pp4qG44E2zpnAVt8cFuE7
         xg1VgXoGWFMeHhuUGkNqG5ecI0DhF2DTr7H1ZqCyg7nlsgrHZx77zcFx4NYVZZS8ID4r
         LTGw==
X-Forwarded-Encrypted: i=1; AJvYcCUWbFy4HiHkUbW4SnBEs86JTwoOU2uRNc61AlGLkjCB4rytXckR0ODQ4J8sJcjgwwD8wKxtppZr6IvP957brtM=@vger.kernel.org, AJvYcCUoQbhETEj2jYQt6Kzg3TwE5PXujiHZ48QlKo00KlNByd4IyHf1DGDDrkOYyxcHbXBA+sBo1/i9@vger.kernel.org, AJvYcCVkXYy+72yn0RsPBgJ8N+KAtjS8ZqhNy3NBCn6rAEiqh7WnDn/8hFkfwM7xTYUd3/RkumvLFoGu/kji0Bw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz+dE9KEiqG7OaBls/0p6MMec6yfj7ZsH4MjL63lH30+R+yvJk
	XN2v6i0QaxQGfVcQ+8KUSHKGd0O9m0C5Z3qeRN4SXctg1rEHu0y4gtqmsCBWxnO8mzAxe/eCGGp
	engddTp8pFtkcMjFkRYKcF0262f0=
X-Google-Smtp-Source: AGHT+IHJKxeOrtNqTcX1XgH+p7hu4iQFC1L+T4mPbVoZniSNaE6kir8xO20MLig7ziMlkP+/BD9Cso2YCazbfJQRLFk=
X-Received: by 2002:a17:90a:77c5:b0:2e2:ebce:c412 with SMTP id
 98e67ed59e1d1-2e55dc34795mr2014a91.2.1729182816007; Thu, 17 Oct 2024 09:33:36
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016035214.2229-1-fujita.tomonori@gmail.com>
 <20241016035214.2229-5-fujita.tomonori@gmail.com> <ZxAZ36EUKapnp-Fk@Boquns-Mac-mini.local>
 <20241017.183141.1257175603297746364.fujita.tomonori@gmail.com>
In-Reply-To: <20241017.183141.1257175603297746364.fujita.tomonori@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 17 Oct 2024 18:33:23 +0200
Message-ID: <CANiq72mbWVVCA_EjV_7DtMYHH_RF9P9Br=sRdyLtPFkythST1w@mail.gmail.com>
Subject: Re: [PATCH net-next v3 4/8] rust: time: Implement addition of Ktime
 and Delta
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: boqun.feng@gmail.com, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com, 
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com, 
	aliceryhl@google.com, anna-maria@linutronix.de, frederic@kernel.org, 
	tglx@linutronix.de, arnd@arndb.de, jstultz@google.com, sboyd@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 11:31=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> We could add the Rust version of add_safe method. But looks like
> ktime_add_safe() is used by only some core systems so we don't need to
> add it now?

There was some discussion in the past about this -- I wrote there a
summary of the `add` variants:

    https://lore.kernel.org/rust-for-linux/CANiq72ka4UvJzb4dN12fpA1WirgDHXc=
vPurvc7B9t+iPUfWnew@mail.gmail.com/

I think this is a case where following the naming of the C side would
be worse, i.e. where it is worth not applying our usual guideline.
Calling something `_safe`/`_unsafe` like the C macros would be quite
confusing for Rust.

Personally, I would prefer that we stay consistent, which will help
when dealing with more code. That is (from the message above):

  - No suffix: not supposed to wrap. So, in Rust, map it to operators.
  - `_unsafe()`: wraps. So, in Rust, map it to `wrapping` methods.
  - `_safe()`: saturates. So, in Rust, map it to `saturating` methods.

(assuming I read the C code correctly back then.)

And if there are any others that are Rust-unsafe, then map it to
`unchecked` methods, of course.

Cheers,
Miguel

