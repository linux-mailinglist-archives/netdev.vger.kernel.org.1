Return-Path: <netdev+bounces-132597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F09D99252A
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 08:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87826B2246F
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 06:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F349113BC0E;
	Mon,  7 Oct 2024 06:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnvY/PK7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528CF15B130;
	Mon,  7 Oct 2024 06:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728284121; cv=none; b=GErHW6GzcSKa5wzwXVFwPROLuoUvJKtzoa1FohZBxP++yTWTPHhMYoCVe4rH5OaaBq/GCJ42qq0CLz3WO0MWaM3t30yj63wbcppXMraSiP1i+3QV1LyiJ9oDQn6cAx0vPaanIBGsyxePiTvE1qMZ6G03fxBell210QP5Gj0Rvk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728284121; c=relaxed/simple;
	bh=moY5HBUo3POj2kBdWLD11Oypzd+D8rfoKAY8UfMYQ40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VQKUpQe1Q7mXv3FkqwXBciPeppHkJqLhzI6K/MLVWHLZtHnLZ66UPmh3qU20GqF32HfsxAjYWqhBVIQ5yDEWKrxfBYPT+3xTpSgbKokE5X3SUA5RGwVA2aQFwNpG8YRNwKMfk86nVP01DBo0N76dqEA51jOOSFwI+V/PxmV/5EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnvY/PK7; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6e129c01b04so32020087b3.1;
        Sun, 06 Oct 2024 23:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728284119; x=1728888919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k8kmOX/v2lhcdpVmDjQej7c2sv/mbznwBbLYPHOJcEU=;
        b=LnvY/PK7mJeAblYGjTtTv+0+CvnVofKXASPbags1Swk1FH7si2r4Zngtn8qFML7CPv
         FFzT3J0niFx7TN8Rge1yeFqs4u4sHp8X35WIsKSLt8WR1SwrIxZ9nZ68fzLTflgG1utv
         3nPcs5o0MJPM/fSEXkhS8seFkDkpjs/NGYbgCvWllDc2m9zcvxYdXdLjUvzzryxgV3gx
         aqX1GRL777/GOfFa9aTWiRu33Tk7mcnaE40yO/qNbarpRvTUEWFHNntiRQ/ly6CcH3eg
         YeaBBABxQiMp/SZP6Wyr8EGDnoXc3CIxrUqRj2x7olHYVfjg4B+3hVQ55c+Zw8oBR8MR
         rkqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728284119; x=1728888919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k8kmOX/v2lhcdpVmDjQej7c2sv/mbznwBbLYPHOJcEU=;
        b=HqpBiH+xmzHZa1T5ZP/r9tUFaQVvNXNLpkJBd+CqTsIDI7z1VzDd3Qh2Ny0Z1GWET1
         tAaBcqrS7Dj20QylhwKVZ4pYXMDE7TFvjgNvkQEY6ylreghqS9RrglZpuUo0W/XGFIqi
         nm4uOiKSZXCWBl+gKQUIp4LSXv0+yPP76iaTz8ClWwuihF/SmGN+ZFvQWBN/uTPoJU/L
         anDHvfqeL7BQS62FYG5SNwjkatFDmrnvcArN1eavriicXUEY+CVWBN25DpPvn8Cp06Dd
         X8olZ/HfBFtmcy8IEdDi08cS/q1RlwP/uRjH9GgdfHgcFS0PycSEqWko57NLEC+5EcAE
         JOFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLboBdRzWYStREUthFjlI3b4nfmsE12e7PZVUMRoqFEzMGdAAZdb+LT1HijqHUcf66PGZ/IErKrQO9Mw==@vger.kernel.org, AJvYcCX4WaniLlp5gKKiHCrwHjS+E7DtHPJFr2FrZyN2dBcd4OIgMhU6UG/burunzm3tnXY0P3y4DOTf@vger.kernel.org, AJvYcCXLGpPnIVtruiplJ68uYwK844pQvnPiDAELQAQKJD7/vOiUFkLGNJ0s4BiMEro/L/zJUIFReW0aBdpQMRw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1ASu9IKhVWAj08t9kMybuc/etR412NJFMo686qIsGLhGhBJWE
	cbQ89XFT7H21A7SwmEJO/0So3owECaLdqZsEyK2pFNEtY0BVawqOm/ajhTVrlhYTabjt/hR7xkg
	QNDZedfl7M4NkNF9bs4aizetvBdw=
X-Google-Smtp-Source: AGHT+IEhUJZakcAb3Hn5TBmpX3W+QxvSOISc+LdAroBp99Wpi5KbVzTtnxsFCso2WAKUsEPZsRFlWTEB7oLAxNgw3VQ=
X-Received: by 2002:a05:690c:d84:b0:6e2:1742:590d with SMTP id
 00721157ae682-6e2c6ff1453mr79031707b3.3.1728284119226; Sun, 06 Oct 2024
 23:55:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241005045411.118720-1-danielyangkang@gmail.com> <CANn89iKk8TOvzD4cAanACtD0-x2pciEoSJbk9mF97wxNzxmUCg@mail.gmail.com>
In-Reply-To: <CANn89iKk8TOvzD4cAanACtD0-x2pciEoSJbk9mF97wxNzxmUCg@mail.gmail.com>
From: Daniel Yang <danielyangkang@gmail.com>
Date: Sun, 6 Oct 2024 23:54:43 -0700
Message-ID: <CAGiJo8RCXp8MqTPcPY4vyQAJCMhOStSApZzA5RcTq5BJgzXoeQ@mail.gmail.com>
Subject: Re: [PATCH v2] resolve gtp possible deadlock warning
To: Eric Dumazet <edumazet@google.com>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>, 
	"D. Wythe" <alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>, 
	Wen Gu <guwen@linux.alibaba.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-s390@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+e953a8f3071f5c0a28fd@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 5, 2024 at 12:25=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Sat, Oct 5, 2024 at 6:54=E2=80=AFAM Daniel Yang <danielyangkang@gmail.=
com> wrote:
> >
> > Fixes deadlock described in this bug:
> > https://syzkaller.appspot.com/bug?extid=3De953a8f3071f5c0a28fd.
> > Specific crash report here:
> > https://syzkaller.appspot.com/text?tag=3DCrashReport&x=3D14670e07980000=
.
> >
> > This bug is a false positive lockdep warning since gtp and smc use
> > completely different socket protocols.
> >
> > Lockdep thinks that lock_sock() in smc will deadlock with gtp's
> > lock_sock() acquisition. Adding a function that initializes lockdep
> > labels for smc socks resolved the false positives in lockdep upon
> > testing. Since smc uses AF_SMC and SOCKSTREAM, two labels are created t=
o
> > distinguish between proper smc socks and non smc socks incorrectly
> > input into the function.
> >
> > Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
> > Reported-by: syzbot+e953a8f3071f5c0a28fd@syzkaller.appspotmail.com
> > ---
> > v1->v2: Add lockdep annotations instead of changing locking order
> >  net/smc/af_smc.c | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >
> > diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> > index 0316217b7..4de70bfd5 100644
> > --- a/net/smc/af_smc.c
> > +++ b/net/smc/af_smc.c
> > @@ -16,6 +16,8 @@
> >   *              based on prototype from Frank Blaschka
> >   */
> >
> > +#include "linux/lockdep_types.h"
> > +#include "linux/socket.h"
> >  #define KMSG_COMPONENT "smc"
> >  #define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> >
> > @@ -2755,6 +2757,24 @@ int smc_getname(struct socket *sock, struct sock=
addr *addr,
> >         return smc->clcsock->ops->getname(smc->clcsock, addr, peer);
> >  }
> >
> > +static struct lock_class_key smc_slock_key[2];
> > +static struct lock_class_key smc_key[2];
> > +
> > +static inline void smc_sock_lock_init(struct sock *sk)
> > +{
> > +       bool is_smc =3D (sk->sk_family =3D=3D AF_SMC) && sk_is_tcp(sk);
> > +
> > +       sock_lock_init_class_and_name(sk,
> > +                                     is_smc ?
> > +                                     "smc_lock-AF_SMC_SOCKSTREAM" :
> > +                                     "smc_lock-INVALID",
> > +                                     &smc_slock_key[is_smc],
> > +                                     is_smc ?
> > +                                     "smc_sk_lock-AF_SMC_SOCKSTREAM" :
> > +                                     "smc_sk_lock-INVALID",
> > +                                     &smc_key[is_smc]);
> > +}
> > +
> >  int smc_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
> >  {
> >         struct sock *sk =3D sock->sk;
> > @@ -2762,6 +2782,7 @@ int smc_sendmsg(struct socket *sock, struct msghd=
r *msg, size_t len)
> >         int rc;
> >
> >         smc =3D smc_sk(sk);
> > +       smc_sock_lock_init(sk);
> >         lock_sock(sk);
> >
> >         /* SMC does not support connect with fastopen */
> > --
> > 2.39.2
> >
>
> sock_lock_init_class_and_name() is not meant to be repeatedly called,
> from sendmsg()
>
> Find a way to do this once, perhaps in smc_create_clcsk(), but I will
> let SMC experts chime in.

So I tried putting the lockdep annotations in smc_create_clcsk() as
well as smc_sock_alloc() and they both fail to remove the false
positive but putting the annotations in smc_sendmsg() gets rid of
them. I put some print statements in the functions to see the
addresses of the socks.

[   78.121827][ T8326] smc: smc_create_clcsk clcsk_addr: ffffc90007f0fd20
[   78.122436][ T8326] smc: sendmsg sk_addr: ffffc90007f0fa88
[   78.126907][ T8326] smc: __smc_create input_param clcsock: 0000000000000=
000
[   78.134395][ T8326] smc: smc_sock_alloc sk_addr: ffffc90007f0fd70
[   78.136679][ T8326] smc: smc_create_clcsk clcsk_clcsk: ffffc90007f0fd70

It appears that none of the smc allocation methods are called, so
where else exactly could the sock used in sendmsg be created?

