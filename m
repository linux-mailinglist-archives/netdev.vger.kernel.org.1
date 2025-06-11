Return-Path: <netdev+bounces-196580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9585AD5769
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 15:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEF503A3789
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 13:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC2928A1D9;
	Wed, 11 Jun 2025 13:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qb0ENliX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620C228313D;
	Wed, 11 Jun 2025 13:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749649309; cv=none; b=OVwERmcRRuRwrEEWGv/8nYkb+tv7E5dAmfop+8OOl1lOIRkL0t1Kr5k+zO1mJxggC8EyHnFJEHMxTrjhl0LY9HaoKL7h5XLYEC20TzbJTEdmO54i8AM8II/gvTikbNsDSHXrn2kFniYbiYWpDbIcJQCY1TO4ap4Kdj6JLE/i72E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749649309; c=relaxed/simple;
	bh=5CPIta//OIfi7E2RQgeAtFIUjj8BnZCSHKeRNJshDxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i2dsHx2bmun4jdNP92T32D0lWtDm81s8AawMp/+CZWAjOcjr+DiDmLOuDM+6HyJBvhYJAAlAPW4TTijNC+2bUqyqwIgoloPwXKnVhiZW/Z+RZ8FGG/JXh0s3RwmBVRl1xQqmt1vd8x04htStOyLGrIvNXmznugcZDqzGDwByXlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qb0ENliX; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-32ac42bb4e4so56677701fa.0;
        Wed, 11 Jun 2025 06:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749649305; x=1750254105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Ir2YHhI5icEEUJqFEqEjRdjWeihU0t9X/FXt8UGUXs=;
        b=Qb0ENliXo36+vI60AwTFyLRYfAfhxtuwJFXIGmcFLVvJOWhbs8lyT6ZYRPh4893YWW
         CeqT7nZMZ7jGmJboh5IwPxKtJUs9hxVYUApSC6uNgdjVFb7esmtssblCiP/A8CL1PxXq
         Jr7TrmV9ikESd3drzenorkYtVeRMNCRqf3BghOTlFPDEyKBbG1twFgHxpWq2Fzqq/Ylh
         +pJDX4jEwnOTMWn0BrOkXFDceohrCAO1C0aDwzpNyjbNZozGBTMlcz28R9Ot93pz+/P5
         5vPvJGeLvJsk7u3JdcTuxGdT8M56Kuu3lKE9epCyVHhYrCUS+0f3yl8A/lnD6+Irewfz
         xqdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749649305; x=1750254105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Ir2YHhI5icEEUJqFEqEjRdjWeihU0t9X/FXt8UGUXs=;
        b=Jt38IXiZJditU/oeMHWe4C0JZr9UX3Du6HnGvxykPFQV4KZtpI70VMuwmcqVBQ90OH
         J4Kyo8hA8tSjN6ChKKvCW4IkVh/TTgfn4ygpXMhn3y4q7T5RmZv+RbX2m+8uYaA1NYTf
         XYVXPk3NtIq9y2ZO4jijrHTBtKvh0d8Cp3I4JFsQvnq/l5CUVEZa0+ZGfD/jwS3OyS9/
         xQUBjqnKdin4kNto1YdqgJD6v7l0oDz7Suawyr/IkVY3f3T4ZpCfpppGU2o/VS75Y3Ff
         7Tc6BMFuSvAjdq7q8kpZiD7VXxMymky164y/OYkl8zpO/qF35byI09UUSsEnMqEh5Lsb
         5tsg==
X-Forwarded-Encrypted: i=1; AJvYcCWpQ/UiW2KM19UWXsUqEsB+BRFxXdGzxYTi0nff9jDaVRdTNcWuMhlwnTrjlZ0WB8sKmZ8jzKB1@vger.kernel.org, AJvYcCWvx6Fe0up1TifdgzmkBcbjo74PctsNi7lNbkhPD+9Aq3WfdEQyGbnKwi+aT2Gl1znUGu8Ip9SAtsJo6QA=@vger.kernel.org, AJvYcCXQv1FPfl3KyNhIYmzVJlLxh3dRweidss+QEanEIjQJuLOs5YzqZGjljdrCJ+GYVeXos9WBwwvdRLIaizdRfhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP3ZWLmrYAmeUP9zgOuw2NuKxU1zcG2hVNPIKxMQYsbyC1Dxcp
	jsqdLMKz6iO77dwhutLB/K5H6vfQY0A6BtXDUg2SDpQwyEa6O9fsq59kGZEqhzO61hq6n6a5zWv
	qP3SSw+gfH4aI5uPK0uairS9ZwMTIKx4=
X-Gm-Gg: ASbGncuCl5RIOkvjHESjExje0i5S/pZRzDhpZLws8OmBuvA8I2VHWuCluJzs8VyWSna
	/AaZ+pXq8xSxfLtGRjB5/RHb3ktvkNOm91PZZX0js3Cb2Jc2ZuBaTFSv6J+Q/SA3idiFouX8wCh
	OMuptmQcwih2S3m0crqY2N9IXeBWqt2OvT5PJ2jFYgukQYoiteaM4k2033REk=
X-Google-Smtp-Source: AGHT+IH4voYTlvScEcvM38QDI51s/Z6ehlRPqNx5tA+HVkb8hgrbjjGhiFyoSkHhaGtW8D4JkSMgqcOYL5I5SMWDJOc=
X-Received: by 2002:a2e:6e0b:0:b0:32a:6e20:7cd0 with SMTP id
 38308e7fff4ca-32b21d5ba79mr6934421fa.17.1749649305306; Wed, 11 Jun 2025
 06:41:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611-correct-type-cast-v1-1-06c1cf970727@gmail.com>
 <CAH5fLghomO3znaj14ZSR9FeJSTAtJhLjR=fNdmSQ0MJdO+NfjQ@mail.gmail.com> <CAJ-ks9m837aTYsS9Qd8bC0_abE_GT9TZUDZbbPnpyOtgrF9Ehw@mail.gmail.com>
In-Reply-To: <CAJ-ks9m837aTYsS9Qd8bC0_abE_GT9TZUDZbbPnpyOtgrF9Ehw@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 11 Jun 2025 09:41:08 -0400
X-Gm-Features: AX0GCFuEQfv3tdhKCmauxf0FnkQeICkCfWltHEObS8fPan6shTasxe1ab7BvVAs
Message-ID: <CAJ-ks9kZZEWXSHX95=QrNXaQvEc-T1cTPTaB3mCjT2coGzpwUg@mail.gmail.com>
Subject: Re: [PATCH] rust: cast to the proper type
To: Alice Ryhl <aliceryhl@google.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, Trevor Gross <tmgross@umich.edu>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>, 
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 9:30=E2=80=AFAM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> On Wed, Jun 11, 2025 at 7:42=E2=80=AFAM Alice Ryhl <aliceryhl@google.com>=
 wrote:
> >
> > On Wed, Jun 11, 2025 at 12:28=E2=80=AFPM Tamir Duberstein <tamird@gmail=
.com> wrote:
> > >
> > > Use the ffi type rather than the resolved underlying type.
> > >
> > > Fixes: f20fd5449ada ("rust: core abstractions for network PHY drivers=
")
> >
> > Does this need to be backported? If not, I wouldn't include a Fixes tag=
.
>
> I'm fine with omitting it. I wanted to leave a breadcrumb to the
> commit that introduced the current code.
>
> >
> > > +            DuplexMode::Full =3D> bindings::DUPLEX_FULL,
> > > +            DuplexMode::Half =3D> bindings::DUPLEX_HALF,
> > > +            DuplexMode::Unknown =3D> bindings::DUPLEX_UNKNOWN,
> > > +        } as crate::ffi::c_int;
> >
> > This file imports the prelude, so this can just be c_int without the
> > crate::ffI:: path.
>
> This has come up a few times now; should we consider denying
> unused_qualifications?
>
> https://doc.rust-lang.org/stable/nightly-rustc/rustc_lint/builtin/static.=
UNUSED_QUALIFICATIONS.html

I should point out also that every reference to crate::ffi::c_int in
this file is fully qualified, so I think this should be a separate
change.

