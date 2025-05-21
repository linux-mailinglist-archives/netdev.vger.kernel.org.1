Return-Path: <netdev+bounces-192422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12027ABFD28
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 21:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A19E1B68031
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 19:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2378728F52E;
	Wed, 21 May 2025 19:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pc/3Wx9i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9228016F288
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 19:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747854545; cv=none; b=Qtvz2pIuvnQd6bceFokOwRoW0sF8vMhM+NTi4ooT83RJBlzOS1djsEagGh/9FEXI2qd5SM5nC6Ck4CRAeUDePiD2M388avl480WfRx733gwdJM+Hgx9K8G+BWSb7vc+tiUo6ZE9w2OmLKwu7F5184k1r4bZ8E7zH7zegUe8lHEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747854545; c=relaxed/simple;
	bh=SJqs4V4Z4NrLdoa5NnRiq4ZO4scndXvarNLEsCzRCLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dzDTR6nvwcyw1ABlslt5PPO/QEoacVaglGIFlFkOierXpnCnOcf2ox2j/lZX8UwBI+DhmV6OougzAYA+Nt7AyVY9lNb8xa25ADQ8wnnpT7qI8T3XJZCYI0DEB9i2iy9siyklLDrGvMVaosmv89MOhmtE97G1NENImVsWhyknyB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pc/3Wx9i; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-231f37e114eso1084675ad.1
        for <netdev@vger.kernel.org>; Wed, 21 May 2025 12:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747854543; x=1748459343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rNrLNL//c/djngHHBKOCT2qv2jkA1BIgT8d0hjVFiq4=;
        b=pc/3Wx9iI1WFNA5zAipg6GqNp/CN26P5hRzmkbobNjblYRtKPyuV8kqChGvSpnGsqc
         Jw8P/MIhi3LybNjbkfvIhgiOSOlPwjfSpLFIQDzws9GEhGSSzS17zcPKl7/q/tEql5zp
         oC7LCD+FSSFRhbv3j4O5kQmdyqzxOmngnXVDEQoX5La9pjvVdzOALlxkxEGBIyEuxG/i
         UkJVyDxOCgxDcFhSmIzCeddnRTLrmDGNcYogw6h07eA0Mbv1LTDlUNOPI0Wr+TxZDewc
         g1Lx6EwRV5rTz0fnHFnXJnpkRxAJgM5VGohfWCPyz6w8omvoDm/ixWUiQNXKe38XvrHg
         AAMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747854543; x=1748459343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rNrLNL//c/djngHHBKOCT2qv2jkA1BIgT8d0hjVFiq4=;
        b=UJhzN1VuMR18Irb9wHl4+vZlHUSc0Li1Ybdvbfm1q2aFLOMsnwwdENse6n23U+JfM5
         5mYnGbMi0B4SuulRsbc5Gml3jSdHVNS31rs4jtpuXuL0JA1cHFQg2WgRLXQlTI+lhO1p
         JTcp0cLmCBk23kUSWp7CNwAmlt0HqBD2mTQM/fyV/lAYbZDkYIN59xWx8T4ii3mQa2d/
         SaQMKs6JqEiO1b2FYr3TyhhBomCJNjSf6yzB6a0+RETWQW4dD3+s2fI4frGE6pKutBVv
         FUQFYrMfl7vPCQuLsCSqzy4vkCuUbVmT/bSZZMru5HmqCUo3L4u38Aj6RpqzN2WWvr/1
         2abA==
X-Gm-Message-State: AOJu0YwG3lJSFydoEXfowoU7lBIV917oZ8I+9Wk2fOwgL2DqWnlxVPl4
	0eiCIiyF1rBB5wDLAXgAdsuP01IPKEOAkk5bJBvsJCd3mYgggoTnKuJT3ww3SQtb4enfYp+zyOo
	w4SPtgJrmhMYBvNqz5uZIusxmJuNaR+sH7F8VElVr
X-Gm-Gg: ASbGnctrdTEHyiOOQelDn/2Si6Gn7QiAkTjdXe9vIJLfrY5sLVRHK+i0dUG3j6x1ztK
	sVrFcoDbH9WSMTGC2gUOvLQtdjXWddI2Pvxi73uMHXjtRXV6hf0pDtfd+dqvG9bhuHem6KuK9BV
	9J7C5KhoejTmciWcI3VrE3AMX6747YxeGCvMLVdawEryFOF3Duk9FNW+hlcNCn5KMgApXfVBWI4
	A==
X-Google-Smtp-Source: AGHT+IHE9roNm/GU1ecC3oih87HtHR/ezayJ8NjLlKTqpuVjFpk3YUrcUNBMyu0ZPHDkuWuY9KPXnxBmD9oaZYRvboQ=
X-Received: by 2002:a17:903:182:b0:231:e321:1230 with SMTP id
 d9443c01a7336-231ffd35651mr12736555ad.16.1747854542525; Wed, 21 May 2025
 12:09:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520203044.2689904-1-stfomichev@gmail.com>
 <20250520203044.2689904-2-stfomichev@gmail.com> <CAHS8izNwpgf3ks1C6SCqDhUPnR=mbo-AdE2kQ3yk4HK-tFUUhg@mail.gmail.com>
 <aC4PtKAt5QF655uZ@mini-arch>
In-Reply-To: <aC4PtKAt5QF655uZ@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 21 May 2025 12:08:49 -0700
X-Gm-Features: AX0GCFvoyRF1S3GC8su89a3s63DdRZ_anIDgkI-bbwVWk8TOV23U5DQe7iZ1qvc
Message-ID: <CAHS8izMUuS95ksQSKUQgTwFU-i5xh4dyGwHRavNRON_rS=9FrA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] selftests: ncdevmem: make chunking optional
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, viro@zeniv.linux.org.uk, horms@kernel.org, 
	andrew+netdev@lunn.ch, shuah@kernel.org, sagi@grimberg.me, willemb@google.com, 
	asml.silence@gmail.com, jdamato@fastly.com, kaiyuanz@google.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 10:39=E2=80=AFAM Stanislav Fomichev
<stfomichev@gmail.com> wrote:
>
> On 05/21, Mina Almasry wrote:
> > On Tue, May 20, 2025 at 1:30=E2=80=AFPM Stanislav Fomichev <stfomichev@=
gmail.com> wrote:
> > >
> > > Add new -z argument to specify max IOV size. By default, use
> > > single large IOV.
> > >
> > > Signed-off-by: Stanislav Fomichev <stfomichev@gmail.com>
> > > ---
> > >  .../selftests/drivers/net/hw/ncdevmem.c       | 49 +++++++++++------=
--
> > >  1 file changed, 29 insertions(+), 20 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tool=
s/testing/selftests/drivers/net/hw/ncdevmem.c
> > > index ca723722a810..fc7ba7d71502 100644
> > > --- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> > > +++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> > > @@ -82,6 +82,9 @@
> > >  #define MSG_SOCK_DEVMEM 0x2000000
> > >  #endif
> > >
> > > +#define MAX_IOV 1024
> > > +
> > > +static size_t max_chunk;
> > >  static char *server_ip;
> > >  static char *client_ip;
> > >  static char *port;
> > > @@ -834,10 +837,10 @@ static int do_client(struct memory_buffer *mem)
> > >         struct sockaddr_in6 server_sin;
> > >         struct sockaddr_in6 client_sin;
> > >         struct ynl_sock *ys =3D NULL;
> > > +       struct iovec iov[MAX_IOV];
> > >         struct msghdr msg =3D {};
> > >         ssize_t line_size =3D 0;
> > >         struct cmsghdr *cmsg;
> > > -       struct iovec iov[2];
> > >         char *line =3D NULL;
> > >         unsigned long mid;
> > >         size_t len =3D 0;
> > > @@ -893,27 +896,29 @@ static int do_client(struct memory_buffer *mem)
> > >                 if (line_size < 0)
> > >                         break;
> > >
> > > -               mid =3D (line_size / 2) + 1;
> > > -
> > > -               iov[0].iov_base =3D (void *)1;
> > > -               iov[0].iov_len =3D mid;
> > > -               iov[1].iov_base =3D (void *)(mid + 2);
> > > -               iov[1].iov_len =3D line_size - mid;
> > > +               if (max_chunk) {
> > > +                       msg.msg_iovlen =3D
> > > +                               (line_size + max_chunk - 1) / max_chu=
nk;
> > > +                       if (msg.msg_iovlen > MAX_IOV)
> > > +                               error(1, 0,
> > > +                                     "can't partition %zd bytes into=
 maximum of %d chunks",
> > > +                                     line_size, MAX_IOV);
> > >
> > > -               provider->memcpy_to_device(mem, (size_t)iov[0].iov_ba=
se, line,
> > > -                                          iov[0].iov_len);
> > > -               provider->memcpy_to_device(mem, (size_t)iov[1].iov_ba=
se,
> > > -                                          line + iov[0].iov_len,
> > > -                                          iov[1].iov_len);
> > > +                       for (int i =3D 0; i < msg.msg_iovlen; i++) {
> > > +                               iov[i].iov_base =3D (void *)(i * max_=
chunk);
> > > +                               iov[i].iov_len =3D max_chunk;
> >
> > Isn't the last iov going to be truncated in the case where line_size
> > is not exactly divisible with max_chunk?
>
> I have this for the last iov entry:
>
>    iov[msg.msg_iovlen - 1].iov_len =3D
>            line_size - (msg.msg_iovlen - 1) * max_chunk;
>
> I think that should correctly adjust it to the remaining 1..max_chunk
> len?
>

Thanks, I missed that line.

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

