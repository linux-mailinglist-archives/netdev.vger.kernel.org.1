Return-Path: <netdev+bounces-143409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A06B29C2504
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 19:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAFF81C203A5
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 18:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C141AA1D0;
	Fri,  8 Nov 2024 18:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zmGUJLZ+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810F51AA1C8
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 18:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731091523; cv=none; b=k4EH+qRTMOAA0lHIIxJraxsOKgo6eZjEv92NrMZdEFoli8YvPRTmSUNHAvdi+8DFO5w+pCk23BB7ApK9kkuQhyxuKYo4evR22gnb0CeyfpFyjY0LCTmVieasGkIFja0g47cShBgehx4jguRR4M8F8XTZE+3LSJq4XXfdyJbjRfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731091523; c=relaxed/simple;
	bh=lcqVxarSnIw0Wfqck48GyQe2gVWyEkUqvNLjJFQRkik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bcn2aChaMhGTqFMFD+3kGWxLkcQDJwu8LjPVOlqWfGbJYqQmlL6tSP8+CBs4mpm6Uo+7R7Wiv6DRDwSekgZMwHIF2mBDxnD0CokJQRJfKcHhNojzpI1zxjSyQarzaWKltjRAwejN4oWwgIDsFMIA7912gB2WgibranZ9TNR9Coo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zmGUJLZ+; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-460b295b9eeso16681cf.1
        for <netdev@vger.kernel.org>; Fri, 08 Nov 2024 10:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731091520; x=1731696320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQWXX3Y2NemA0Bkmo9oa5lzAWU2FAVxuxVlJNZmkK0g=;
        b=zmGUJLZ+pcVZAPYmE5NQNZ1QyU+AVEmoHit7jYqG/Te+gUl8cPqXR+OqeVAJjyXem2
         QS3vOswWcTAxLs2Ql/uZUJtNip1uB3dJLYOgT75dQJqgRAQutB2/8NQCctZQK8+ejFvM
         WVXE/LD0fN2dbzV4LbY4ra8VsD8WXBjG0BEhlxTHfiCD5o/ZXeOlm0fGMDSCSlqxh5rH
         h6/0Wu2e0n5q5M+it4GZUfqrh6nbsrGQG+Eje4VBy1Mj+pGK8ZkTi39aUBy236+DJTna
         47T1FQ7OBTSKZ3yLslb8K1CPY4YrchjGXwWZszR6633+G0UNDoKRBhZVqOcV2c31sJC5
         q80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731091520; x=1731696320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dQWXX3Y2NemA0Bkmo9oa5lzAWU2FAVxuxVlJNZmkK0g=;
        b=IPk47/yg6cm9xHm0GTM4o/xf3WBG4nVwQLTAj1xWVhSSiDGSDqIjEy+RCZopkyOOyc
         bqoXElLE91vmieCznzCvSi0S5nve2r1ZhlQk2uXpgHX1TtBjIdp9HzYBN9ZShY2K047K
         106p+HpOXFklEWFRvHHCuKlb4ZmXOt9V9jm3SPhx3EvCe39E/iwqGR74haV5uEjf0NGZ
         NHpHOdmYlLMTRhZX9J+FKf4puYcnBtpXRG8tGvDtTSmn0PyG+hd2ns4LGVOr4EfbxAAm
         2rYop9gsQ2TWkBHSNr0OLcwzez4SwybT95oz28RlMSnc0UcfZcyL4Zz9f2pI0rKIXztL
         1gLA==
X-Gm-Message-State: AOJu0YzT/Mr/FV0TadIOsFVOwiKdvdGrnjVCoz6F93q5Rv9d/bt1/HM8
	43akJfPMIEGdRnuqs8na87jym1MmSGX8OPYktGTXgLyo+UgOZxeZhl6M54PJteW2jzUDmJggD2i
	3H7uC1wMogTXWDl1BDqUrwhF/YxIUJmnZI20F
X-Gm-Gg: ASbGnctQgHCg4BhWjd+wVMgtlHZeHpnvdaunGgj6dEKFZAPEaK6UBe2z74HCfO2sLNY
	hhu3G8fvTzd/VzSvowFYXhSpPIhRh9lk=
X-Google-Smtp-Source: AGHT+IGvwPp9TjQSnwda6uC40OLtKbAEUpz4aO9CgT19b5ZFDtcU/z04H3hO5fbFjqfA/TFF1ZaKphANpOjVSAC2lfA=
X-Received: by 2002:a05:622a:548a:b0:462:c4fe:ec19 with SMTP id
 d75a77b69052e-462fa619d7dmr8710451cf.21.1731091520108; Fri, 08 Nov 2024
 10:45:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107210331.3044434-1-almasrymina@google.com>
 <20241107210331.3044434-2-almasrymina@google.com> <Zy1priZk_LjbJwVV@mini-arch>
 <CAHS8izOJSd2-hkOBkL0Cy40xt-=1k8YdvkKS98rp2yeys_eGzg@mail.gmail.com>
 <Zy1_IG9v1KK8u2X4@mini-arch> <CAHS8izP8UoGZXoFCEshYrL=o2+T6o4g-PDdgDG=Cfc0X=EXyVQ@mail.gmail.com>
 <Zy5Ta-M868VvBme2@mini-arch>
In-Reply-To: <Zy5Ta-M868VvBme2@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 8 Nov 2024 10:45:07 -0800
Message-ID: <CAHS8izNK6xJHDB+W80iCr2CEwbo=OecG-1UW5dB9X_0aowo8Bw@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] net: clarify SO_DEVMEM_DONTNEED behavior in documentation
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Willem de Bruijn <willemb@google.com>, 
	"David S. Miller" <davem@davemloft.net>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Yi Lai <yi1.lai@linux.intel.com>, 
	Stanislav Fomichev <sdf@fomichev.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 10:07=E2=80=AFAM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 11/08, Mina Almasry wrote:
> > On Thu, Nov 7, 2024 at 7:01=E2=80=AFPM Stanislav Fomichev <stfomichev@g=
mail.com> wrote:
> > >
> > > On 11/07, Mina Almasry wrote:
> > > > On Thu, Nov 7, 2024 at 5:30=E2=80=AFPM Stanislav Fomichev <stfomich=
ev@gmail.com> wrote:
> > > > >
> > > > > On 11/07, Mina Almasry wrote:
> > > > > > Document new behavior when the number of frags passed is too bi=
g.
> > > > > >
> > > > > > Signed-off-by: Mina Almasry <almasrymina@google.com>
> > > > > > ---
> > > > > >  Documentation/networking/devmem.rst | 9 +++++++++
> > > > > >  1 file changed, 9 insertions(+)
> > > > > >
> > > > > > diff --git a/Documentation/networking/devmem.rst b/Documentatio=
n/networking/devmem.rst
> > > > > > index a55bf21f671c..d95363645331 100644
> > > > > > --- a/Documentation/networking/devmem.rst
> > > > > > +++ b/Documentation/networking/devmem.rst
> > > > > > @@ -225,6 +225,15 @@ The user must ensure the tokens are return=
ed to the kernel in a timely manner.
> > > > > >  Failure to do so will exhaust the limited dmabuf that is bound=
 to the RX queue
> > > > > >  and will lead to packet drops.
> > > > > >
> > > > > > +The user must pass no more than 128 tokens, with no more than =
1024 total frags
> > > > > > +among the token->token_count across all the tokens. If the use=
r provides more
> > > > > > +than 1024 frags, the kernel will free up to 1024 frags and ret=
urn early.
> > > > > > +
> > > > > > +The kernel returns the number of actual frags freed. The numbe=
r of frags freed
> > > > > > +can be less than the tokens provided by the user in case of:
> > > > > > +
> > > > >
> > > > > [..]
> > > > >
> > > > > > +(a) an internal kernel leak bug.
> > > > >
> > > > > If you're gonna respin, might be worth mentioning that the dmesg
> > > > > will contain a warning in case of a leak?
> > > >
> > > > We will not actually warn in the likely cases of leak.
> > > >
> > > > We warn when we find an entry in the xarray that is not a net_iov, =
or
> > > > if napi_pp_put_page fails on that net_iov. Both are very unlikely t=
o
> > > > happen honestly.
> > > >
> > > > The likely 'leaks' are when we don't find the frag_id in the xarray=
.
> > > > We do not warn on that because the user can intentionally trigger t=
he
> > > > warning with invalid input. If the user is actually giving valid in=
put
> > > > and the warn still happens, likely a kernel bug like I mentioned in
> > > > another thread, but we still don't warn.
> > >
> > > In this case, maybe don't mention the leaks at all? If it's not
> > > actionable, not sure how it helps?
> >
> > It's good to explain what the return code of the setsockopt means, and
> > when it would be less than the number of passed in tokens.
> >
> > Also it's not really 'not actionable'. I expect serious users of
> > devmem tcp to log such leaks in metrics and try to root cause the
> > userspace or kernel bug causing them if they happen.
>
> Right now it reads like both (a) and (b) have a similar probability. Mayb=
e
> even (a) is more probable because you mention it first? In theory, any sy=
scall
> can have a bug in it where it returns something bogus, so maybe at least
> downplay the 'leak' part a bit? "In the extremely rare cases, kernel
> might free less frags than requested .... "
>
> Imagine a situation where the user inadvertently tries to free the same t=
oken
> twice or something and gets the unexpected return value. Why? Might be
> the kernel leak, right?
>
> From the POW of the kernel, the most probable cases where we return
> less tokens are:
> 1. user gave us more than 1024
> 2. user gave us incorrect tokens
> ...
> 99. kernel is full of bugs and we lost the frag

The current wording doesn't make any comment about probability. More
information is better than less. I don't see a strong reason to omit
information. I think the docs are better now and will be improved
further in the future. Lets not bike shed too much on docs wording.
It's painfully obvious invalid input is more likely not subtle kernel
bugs IMO without calling out.

--=20
Thanks,
Mina

