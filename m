Return-Path: <netdev+bounces-192417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF75ABFCFA
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 20:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A82B57A775C
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 18:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0287728F504;
	Wed, 21 May 2025 18:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VcbGsXcS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779F42356B2
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 18:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747853071; cv=none; b=mwlylZiHmQNP8xxArtBQnQvpOwGCrR/m145vfrGi20WbPYfLWZo1nR3rmr5TAYCaDxwVXENHRRnft4QIbQUwic7z1d1HZ8VqhaQrOea6winb16pwddBPm3K64TwkaGy6D4jo5aUMhkOI7LoLkEoPuhxuwM0Sc46r4VCfic4ex0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747853071; c=relaxed/simple;
	bh=PLqqVYRvu9j0UKOWgjWi+5YgAEEpqzV1wFno5gm5Av0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rjXHpUX3TTCHYDWeKFEhGALtWf6tMnnS/z6uDfx/om9CGi/DF5MEQ/dZRkFin6mePQ5Ose0j7yhqxCxzL/VxEZo/fIabb3Xl9BtDsmeTlj8XJAHmiV4jpwbHiCc5SXdn8NYXU2WgMY5lqsHD9/xDAry7sAGwMjghy2WloLuNX4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VcbGsXcS; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-231f37e114eso1078435ad.1
        for <netdev@vger.kernel.org>; Wed, 21 May 2025 11:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747853069; x=1748457869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fmtb/X1TjI57UQfJNDD/ZVOXAdbzBipTI0IG+wPw1r0=;
        b=VcbGsXcS72vrxfTqAxvshNu2Agd7LXMVnNAMSqiNXD6EKUn23xb7jlyH4tLCVu79zH
         mGZ0fk3psqiPuq1QCoLzlwJt8Kuvi71sVwnerO7cNR+z/9m6mtcPu6XLsU2AsZyfBHAX
         1/JflIHFR1xWz2TGKEg0t+tMQYGIHV7eGf/x/uDk0w3K284mX5R6P2yQd67EsKGZcJQa
         5RcI5sK+rlsIxVxDN3Q9ZfS2ddR26H0Ams9Al1BGB5ohG7S3H3bncYdslTyu3BfYkJLe
         0K8iTbSv5dF++u1N+bSifDukKGI/K/0KasmMiS0q7x4wZV71/PWvxVKR+vbm82iSfga4
         HEMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747853069; x=1748457869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fmtb/X1TjI57UQfJNDD/ZVOXAdbzBipTI0IG+wPw1r0=;
        b=wWPdN/MMPGQygREgTyfeYfk+UAINRNHMueRhoDixnRysLZhs7MdbeMr3rfCnH2dmnS
         FuErgo1a9cXlIu/TDwqY1W+MBs3AA/8PCjVwV761t96A6NO95r3ErR3Bfv2GqJB1hHUJ
         j12trrmVz0wbUXLuriWWXGWwr9M/8urMPBZSZb6duGw0eCH5IYYraGD1HKKihAXnai+T
         ed2mfY46xD7RlGfFBz+wMng1AyibazoyJHtbOiuYcjH5jd9+VCmRJHqAJ69ehE1P8AkE
         2ov3Iasc+cS1uAZGpUsh0PPixDi71slG1Mq8m5vfJqyOe5RrV33B/5A7Q+vgoagEMvjj
         h+oQ==
X-Gm-Message-State: AOJu0YyL/KXhYeyGua7OAncj8RwEvVo5tMy0DsALofOwHQYEriuF5+kj
	RXhdVuiwvgIRY1CqaK7il35p6J2Qzk3l0KCmWTXgAC0iY0uD7vHHdO6iYweIM/SQUSieoDkfrYR
	GoTFeSMx+2Psp2Qd64Ms5frR1OV0hqgvJ9sAXolyv
X-Gm-Gg: ASbGncvxatx7gJ1+axze0tJVHwXnadA8xfpkUkBsDl/D0H2y3gazB3OwP6ROwscTlaf
	Z+vV30Ft2e3APu1LZT8nS54LYrEApTJiq7JFhi1ynsoZHMN40rLQanpKQtMB6yNTMnq+DCkUxF9
	1YYffzFHJJRCqynClPStn3TC/4cizmj4Ij0o17j+KzdzoYZIdbgeIDC7PJ5ZSFjGHL7XIzripEi
	tHcSfotYZYj
X-Google-Smtp-Source: AGHT+IEXiFi22m1AAuPknA7/mPQrtbieW/QpfJyBFNu2dBtKz+56sUuaE2f+PCmIYXDfcQ4AGifNPJkDf8Hj0nibFdU=
X-Received: by 2002:a17:903:17c6:b0:21f:2ded:bfc5 with SMTP id
 d9443c01a7336-231ffdde32emr11175455ad.28.1747853069239; Wed, 21 May 2025
 11:44:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520203044.2689904-1-stfomichev@gmail.com>
 <CAHS8izOTWF9PO9N6ZamJ0xSCTOojXV+LfYm+5B5b8Ad1MA0QpA@mail.gmail.com> <aC4OgpSHKf51wQS-@mini-arch>
In-Reply-To: <aC4OgpSHKf51wQS-@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 21 May 2025 11:44:16 -0700
X-Gm-Features: AX0GCFtFyK-Rzh-K3EDETVyBIHWoSb0XFsUtd60DFFl1a6amDAz9DWLctNHnqIw
Message-ID: <CAHS8izOEQHwFcQ6L7bPeonWNVgjuZ4yKWwi+3LBhnQnCG+VC-w@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] net: devmem: support single IOV with sendmsg
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, viro@zeniv.linux.org.uk, horms@kernel.org, 
	andrew+netdev@lunn.ch, shuah@kernel.org, sagi@grimberg.me, willemb@google.com, 
	asml.silence@gmail.com, jdamato@fastly.com, kaiyuanz@google.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 10:33=E2=80=AFAM Stanislav Fomichev
<stfomichev@gmail.com> wrote:
>
> On 05/21, Mina Almasry wrote:
> > On Tue, May 20, 2025 at 1:30=E2=80=AFPM Stanislav Fomichev <stfomichev@=
gmail.com> wrote:
> > >
> > > sendmsg() with a single iov becomes ITER_UBUF, sendmsg() with multipl=
e
> > > iovs becomes ITER_IOVEC. iter_iov_len does not return correct
> > > value for UBUF, so teach to treat UBUF differently.
> > >
> > > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > > Cc: Pavel Begunkov <asml.silence@gmail.com>
> > > Cc: Mina Almasry <almasrymina@google.com>
> > > Fixes: bd61848900bf ("net: devmem: Implement TX path")
> > > Signed-off-by: Stanislav Fomichev <stfomichev@gmail.com>
> > > ---
> > >  include/linux/uio.h | 8 +++++++-
> > >  net/core/datagram.c | 3 ++-
> > >  2 files changed, 9 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/include/linux/uio.h b/include/linux/uio.h
> > > index 49ece9e1888f..393d0622cc28 100644
> > > --- a/include/linux/uio.h
> > > +++ b/include/linux/uio.h
> > > @@ -99,7 +99,13 @@ static inline const struct iovec *iter_iov(const s=
truct iov_iter *iter)
> > >  }
> > >
> > >  #define iter_iov_addr(iter)    (iter_iov(iter)->iov_base + (iter)->i=
ov_offset)
> > > -#define iter_iov_len(iter)     (iter_iov(iter)->iov_len - (iter)->io=
v_offset)
> > > +
> > > +static inline size_t iter_iov_len(const struct iov_iter *i)
> > > +{
> > > +       if (i->iter_type =3D=3D ITER_UBUF)
> > > +               return i->count;
> > > +       return iter_iov(i)->iov_len - i->iov_offset;
> > > +}
> > >
> >
> > This change looks good to me from devmem perspective, but aren't you
> > potentially breaking all these existing callers to iter_iov_len?
> >
> > ackc -i iter_iov_len
> > fs/read_write.c
> > 846:                                            iter_iov_len(iter), ppo=
s);
> > 849:                                            iter_iov_len(iter), ppo=
s);
> > 858:            if (nr !=3D iter_iov_len(iter))
> >
> > mm/madvise.c
> > 1808:           size_t len_in =3D iter_iov_len(iter);
> > 1838:           iov_iter_advance(iter, iter_iov_len(iter));
> >
> > io_uring/rw.c
> > 710:                    len =3D iter_iov_len(iter);
> >
> > Or are you confident this change is compatible with these callers for
> > some reason?
>
> Pavel did go over all callers, see:
> https://lore.kernel.org/netdev/7f06216e-1e66-433e-a247-2445dac22498@gmail=
.com/
>

Thanks, I'm not confident enough in my understanding of the other call
sites of iter_iov_len to provide a reviewed-by, but this looks fine to
me for devmem TCP, so I think acked-by is appropriate.

Acked-by: Mina Almasry <almasrymina@google.com>

Thanks!

--=20
Thanks,
Mina

