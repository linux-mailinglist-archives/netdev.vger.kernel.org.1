Return-Path: <netdev+bounces-206772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CE7B04568
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 18:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA0EF3A4C96
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 16:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA79025F790;
	Mon, 14 Jul 2025 16:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tElVESDD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290711DE3C8
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 16:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752510234; cv=none; b=Lp8pLeXOuCY0gt7exlyRZyx7IGahMK+NsBc5GAabkwRjcd8SPSzK7HjMgYHOr/1TbK8q9b57WzKaEkjT/qHc/N7cr8KVuZj3xv5eBfMZBS1tvkXUN3MvnCXiNtYdtVU1v/GnDOzvVMe1eY2QDAiGtI4BPsl5XFuhhVrA4mQPyzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752510234; c=relaxed/simple;
	bh=99KgSQThYEi+muPi3NbKqxLa98OPPNRwJiXJuLspEuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iMw6++vwujTm+g871wspm0Hm3wI/w+5U/9khfbq4MLcLVd4U9jYlX03BZntSunK5hMJMUssF0G7rrFmWqVp3S0Z0MbJ3N2xKL2b7u9779iy8t3I547XeVbCruocKRLTj7CB9v1wNPoRwuI3S4SPn8R6fvQhbohUM0MOoUglvWvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tElVESDD; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b3be5c0eb99so1292181a12.1
        for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 09:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752510232; x=1753115032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CtFi1sRNGmlQS4pE8nXz6NVOa+/bYBo/j5rKrMyjft4=;
        b=tElVESDDQHOPd0f2S/KiirbHEMtBfXbvf1IgLZm71PWQufELd1S1Sfng+tKLzUdjEj
         Amwata7FWJCPVOQvPz+4Umyr04M8rDonX0xB3Elpppx3K/zjkGBXasfbEkVfJ7DvE+4G
         dviJhSuQLCwaCngSJfnHAT6Zy0VpOlHLp7jprqUQEuL/1sjH56NejSeZmDLyJ4m0fFRc
         numvvvu6ZQXVPsuR9EmvSOMvlN5wDUsHphxss2R7uV+iUtrl63t8WpTilioYU/WXwccJ
         CzXusCrQ8yoB/KVTfPsEBZZ7sVUV9Q2PG3on7doybjEIRcpwQtLABNaM9xsWk68tvIXl
         YiSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752510232; x=1753115032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CtFi1sRNGmlQS4pE8nXz6NVOa+/bYBo/j5rKrMyjft4=;
        b=DPiOYcmsshvxlKoA1kisfH+ofMLeYxT3ZWfqWMro4vPAylh/RPg/VwU4xSVVgHiMyj
         tEQ3BG0eW49DEC3zznYlNHd+riHQFzaIorF48EUi8h+0k2nXVMwN6rJU79CwX76EuiX6
         pwFPJgFkCi+qZhZuRAFCkRp5ztF2va+y6PuXP9nvTbFDZOJbisvLg8fSimSP0g6Z3BVY
         284p7nEP52GZM6LfHw1egK+eZ31P27fxYk3hbsGKv2OntdfAun9enW3D89s0K8YusPTe
         r5/wXu5Q2Cikz8xciWlHSc6vNk/OjS+Kg95Ed7iHnhmv8Qpvq5xBvKvAs6QBJSibnIov
         p1uQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOUjiBnzSuSrlHXJRBH7F1zo249KUP4xgQ9AZv/gqI869Ymz8NtrML5nl3oRQvjZNXK1hxCBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyOSHoRZB5rbIUmnDTVytBlswgV5vgDt4CtqUNpfmM3u9lI9AD
	XEYhsRm7He9T2otJldgTRUGyjCd2jDX2E57xt8jCzkzjRlq0yogBaoYXn91FiwmXV0y9UHPDYln
	gtkC1gi4L/W212mKZCh6s1DJSBIWSNOkMLXz600BM
X-Gm-Gg: ASbGncsGcv+Y7KqjloqreRM5JfmdvPa97zJ6u23zcisUTgn5l4bgtOkhZz7Y5KQTxS2
	+mdmgajdSnaLXoEpUMq7uKpC0I3vJmL+iyPmanjljfs1N7eEohWIyreVTxtLKvac8foILQ/2YSh
	kZa7EMF6vNv+tNFugbI2zav3WyUqJ/opPFO5DBWQrKNlqMvNChKA7tt7k0Dfn8aQIWnQv1yQy8A
	VT4jelY1NJZww1LsnQqzhuKmxmc4AneImBmag==
X-Google-Smtp-Source: AGHT+IHqlWFWWNDjDX/Iogv1k6KaZniLPyiFXJh0sCPuaZ5V2ewUcGPV2Q8bNACpYvEK0fixjvOVjjDDM2nZ2gYCvLg=
X-Received: by 2002:a17:90b:2e4f:b0:313:271a:af56 with SMTP id
 98e67ed59e1d1-31c4cdad83emr20081422a91.30.1752510232008; Mon, 14 Jul 2025
 09:23:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711060808.2977529-1-kuniyu@google.com> <965af724-c3b4-4e47-97d6-8591ca9790db@linux.ibm.com>
In-Reply-To: <965af724-c3b4-4e47-97d6-8591ca9790db@linux.ibm.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 14 Jul 2025 09:23:40 -0700
X-Gm-Features: Ac12FXzhMnuOr2Yor8xWWkSSz6suRHysgvVNWOynlvLw1cpJlOlTesXvNOUzeSE
Message-ID: <CAAVpQUAQVVwPo5fi6rCcJQhH=jqQnkNaAMrBSJju85taEiTdkQ@mail.gmail.com>
Subject: Re: [PATCH v1 net] smc: Fix various oops due to inet_sock type confusion.
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, 
	Sidraya Jayagond <sidraya@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Mahanta Jambigi <mjambigi@linux.ibm.com>, Tony Lu <tonylu@linux.alibaba.com>, 
	Wen Gu <guwen@linux.alibaba.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-s390@vger.kernel.org, 
	syzbot+40bf00346c3fe40f90f2@syzkaller.appspotmail.com, 
	syzbot+f22031fad6cbe52c70e7@syzkaller.appspotmail.com, 
	syzbot+271fed3ed6f24600c364@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 12:42=E2=80=AFAM Alexandra Winter <wintera@linux.ib=
m.com> wrote:
> On 11.07.25 08:07, Kuniyuki Iwashima wrote:
> > syzbot reported weird splats [0][1] in cipso_v4_sock_setattr() while
> > freeing inet_sk(sk)->inet_opt.
> >
> > The address was freed multiple times even though it was read-only memor=
y.
> >
> > cipso_v4_sock_setattr() did nothing wrong, and the root cause was type
> > confusion.
> >
> > The cited commit made it possible to create smc_sock as an INET socket.
> >
> > The issue is that struct smc_sock does not have struct inet_sock as the
> > first member but hijacks AF_INET and AF_INET6 sk_family, which confuses
> > various places.
> >
> > In this case, inet_sock.inet_opt was actually smc_sock.clcsk_data_ready=
(),
> > which is an address of a function in the text segment.
> >
> >   $ pahole -C inet_sock vmlinux
> >   struct inet_sock {
> >   ...
> >           struct ip_options_rcu *    inet_opt;             /*   784    =
 8 */
> >
> >   $ pahole -C smc_sock vmlinux
> >   struct smc_sock {
> >   ...
> >           void                       (*clcsk_data_ready)(struct sock *)=
; /*   784     8 */
> >
> > The same issue for another field was reported before. [2][3]
> >
> > At that time, an ugly hack was suggested [4], but it makes both INET
> > and SMC code error-prone and hard to change.
> >
> > Also, yet another variant was fixed by a hacky commit 98d4435efcbf3
> > ("net/smc: prevent NULL pointer dereference in txopt_get").
> >
> > Instead of papering over the root cause by such hacks, we should not
> > allow non-INET socket to reuse the INET infra.
> >
> > Let's add inet_sock as the first member of smc_sock.
> >
> [...]
> >
> >  static struct lock_class_key smc_key;
> > diff --git a/net/smc/smc.h b/net/smc/smc.h
> > index 78ae10d06ed2e..2c90849637398 100644
> > --- a/net/smc/smc.h
> > +++ b/net/smc/smc.h
> > @@ -283,10 +283,10 @@ struct smc_connection {
> >  };
> >
> >  struct smc_sock {                            /* smc sock container */
> > -     struct sock             sk;
> > -#if IS_ENABLED(CONFIG_IPV6)
> > -     struct ipv6_pinfo       *pinet6;
> > -#endif
> > +     union {
> > +             struct sock             sk;
> > +             struct inet_sock        icsk_inet;
> > +     };
> >       struct socket           *clcsock;       /* internal tcp socket */
> >       void                    (*clcsk_state_change)(struct sock *sk);
> >                                               /* original stat_change f=
ct. */
>
> I would like to remind us of the discussions August 2024 around a patchse=
t
> called "net/smc: prevent NULL pointer dereference in txopt_get".
> That discussion eventually ended up in the reduced (?)
> commit 98d4435efcbf ("net/smc: prevent NULL pointer dereference in txopt_=
get")
> without a union.
>
> I still think this union looks dangerous, but don't understand the code w=
ell enough to
> propose an alternative.
>
> Maybe incorporate inet_sock in smc_sock? Like Paoplo suggested in
> https://lore.kernel.org/lkml/20240815043714.38772-1-aha310510@gmail.com/T=
/#maf6ee926f782736cb6accd2ba162dea0a34e02f9
>
> He also asked for at least some explanatory comments in the union. Which =
would help me as well.

I agree with Paolo that smc_sock should "eventually" have only
inet_sock as the first member, but I think this should/can be done
in net-next as follow-up.

The thread above shows such code churn was distracting enough
and the improper fix was introduced.

