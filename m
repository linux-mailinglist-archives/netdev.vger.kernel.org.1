Return-Path: <netdev+bounces-216798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE38AB353A2
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 07:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEAED683D5C
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 05:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45672F3C00;
	Tue, 26 Aug 2025 05:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W8paAhKn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC18E2EF64A
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 05:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756187829; cv=none; b=BLlT57S7czQMsrJXuh9PJY7dnHmTXtsE3ck4PaxKdCyr9KqUgrCEik7BHJjga0pP74GUini6izQgbHX1W61acw50BpMEqQkDlqI22c1vVof77G5BYyDNCyc9ITcZS7pbdBsw518DfTpjd8RwMa8J5aNEy95woJsMUDXnsdt4hDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756187829; c=relaxed/simple;
	bh=CWNR4pYtCuYnSNovOXmow6EDXueugkkaxhIaiMS+Pow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hnLGuNDi0Z6ZmOeQxVnAcgGg9JAD4i9hZTlhkYIO2ZCBjFqCwAaO/gxHEkZH/MoemV6pVKCeoyS8wA4apyfxApBRNPVKC8qcJTkLFVqS9tTmyME6UbT8iWr3aDnUc2gO11DDkSptmO65WlQD+SlKRC3Yg2LEuaZ2w7gFgIbB95o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W8paAhKn; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2460757107bso47396935ad.2
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 22:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756187827; x=1756792627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rgbQAPgFawIL/zBvvVhjwDaQFO9CcGxN18S3VJouTLA=;
        b=W8paAhKn7NL+g2W+p9gSvj0jTTjs7e3WG7K2n4PCvxF859O541y0RYNnBlejabWA86
         uZq4+ivfIiqRBmfmpKN1nGqr1+S0jCo0VIxYXR138qMVEZ+rnBshAWhu1GgAJR4iXiIW
         6Ey+pF6Q7qgIajBSq5NiVMZTKGhTSDSh/VaUH924yTQdvU9NYsftI3VyMNBjnQDmTg1P
         7hX/H84eDHeY9l6dWFg1Sx4WSdLNcmY7TD+EXzJ/yBTtlUnDl2Luy10ogX4dnrQeuNDh
         uIEs5WYSlYUaEfTGOZ+1rmcc2AR9V+yHGgGcs2pb4XPWfyK4yOfVCx2slYBmxrJnpRou
         NZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756187827; x=1756792627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rgbQAPgFawIL/zBvvVhjwDaQFO9CcGxN18S3VJouTLA=;
        b=UV+p7hSyweCb3ZHeprIwPK2vCPg3jsc6M0qexTKEAGz1NMQMasGsTgAP50PPGwbVXm
         6wLhilj9wCSLkL10xas0Dn8sm+Hf7EedHXtJwrdictDKQ8ad1dsz/Fas/FgVtKN+bXOe
         1rHgBgsQnQ27brQHR0Go3bwwBwCxUGJcJGY8tPWRmfO0qeDfu1CVvHZ+AsT81754rJri
         q9TNzz3fuR212jdjp5EJE2kMzSq55ZVUanLkEEICwrb862lbyNImcmRSlz8aAmOuggjw
         Nw608asyh75/TUmQxB4DzqlyoX4zb1aQ9G1+l663KxIkIx0M5hPkfuSaFy7ZbLs00RP2
         b7DQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzjVuW2U10xoZBQnCHcW/2Q/d/lDiX8lQD6q9K6KxjiyxAzeF1/TvHkOgdjbpTofw00+BhCaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YylTgIvqfbc5l6PjWwd0pI8fL3TucEmdEdtjHOqtujKVMgD2oVU
	6SGhfQFZaAp/EkjtFQZTRJaOkoMmGBnjX24v3wrh2QuLW6VKx7iF1H9b7bfxeC3A8LoABLMXW3H
	LFZ7648TMXVesV5qwdcTIry/3YO3cZq79/G14ETKy
X-Gm-Gg: ASbGncsvWxQJVb4W0potDSRrI7RaJm3dmnt3lnTZN/UDtDYWKpmaAoZB1yaQm7QFhLd
	uxiw8QlJcp81vEbiKrZX6DvK0mmoBCZ36FGBnh1masfnxiHEwoHLSRL3uXiZFEegqBwP9G0cdVI
	HEjQpetI7fPUt02mz59DWiB3NWqu1crLu7B601Mki+EChvec/PV/Q61Evq9dY7tQ3PTMSsgSLDi
	kyO2zPztfsrk9H61YquJr61POKglw80P6tXqj4WgBtDtyYrRIfOTNYcUk0yGYiVSewzEhBD+QJS
	caMPWougzzQgfQ==
X-Google-Smtp-Source: AGHT+IEK4QY4XTpXjl2k6Hzn67giNNVzvE+bnIENMpk2dnpR63nxlEMp+0+O7Fp86ljMfvPxWrztDtR28s6hlusU09w=
X-Received: by 2002:a17:902:f54b:b0:246:f13b:1bb9 with SMTP id
 d9443c01a7336-246f13b2a8emr50300355ad.58.1756187826801; Mon, 25 Aug 2025
 22:57:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825195947.4073595-1-edumazet@google.com> <20250825195947.4073595-4-edumazet@google.com>
 <CAAVpQUCiSJnv9QMuAFbomEeF3D=0iJYSJSmMhpQpyCFxQUgK_A@mail.gmail.com> <CANn89iLsA1N7NDz71GRaoMWn2xWmJvMP4oPs=yMCbLvE--R8kQ@mail.gmail.com>
In-Reply-To: <CANn89iLsA1N7NDz71GRaoMWn2xWmJvMP4oPs=yMCbLvE--R8kQ@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 25 Aug 2025 22:56:55 -0700
X-Gm-Features: Ac12FXyuxmEDZJKZHoECdT3tLuccD7n-lNUAdxq_h5E80AZaO7chH8dpX2K4Kgg
Message-ID: <CAAVpQUDPUuntSi7Zxg+nKkRYzBPQxJF1FYFU3n7s=h_Qs-ZHgg@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] net: add new sk->sk_drops1 field
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 10:46=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Mon, Aug 25, 2025 at 1:19=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.=
com> wrote:
> >
> > On Mon, Aug 25, 2025 at 12:59=E2=80=AFPM Eric Dumazet <edumazet@google.=
com> wrote:
> > >
> > > sk->sk_drops can be heavily contended when
> > > changed from many cpus.
> > >
> > > Instead using too expensive per-cpu data structure,
> > > add a second sk->sk_drops1 field and change
> > > sk_drops_inc() to be NUMA aware.
> > >
> > > This patch adds 64 bytes per socket.
> > >
> > > For hosts having more than two memory nodes, sk_drops_inc()
> > > might not be optimal and can be refined later.
> > >
> > > Tested with the following stress test, sending about 11 Mpps
> > > to a dual socket AMD EPYC 7B13 64-Core.
> > >
> > > super_netperf 20 -t UDP_STREAM -H DUT -l10 -- -n -P,1000 -m 120
> > > Note: due to socket lookup, only one UDP socket will receive
> > > packets on DUT.
> > >
> > > Then measure receiver (DUT) behavior. We can see
> > > consumer and BH handlers can process more packets per second.
> > >
> > > Before:
> > >
> > > nstat -n ; sleep 1 ; nstat | grep Udp
> > > Udp6InDatagrams                 855592             0.0
> > > Udp6InErrors                    5621467            0.0
> > > Udp6RcvbufErrors                5621467            0.0
> > >
> > > After:
> > > nstat -n ; sleep 1 ; nstat | grep Udp
> > > Udp6InDatagrams                 914537             0.0
> > > Udp6InErrors                    6888487            0.0
> > > Udp6RcvbufErrors                6888487            0.0
> > >
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > ---
> > >  include/net/sock.h                            | 20 +++++++++++++++++=
++
> > >  .../selftests/bpf/progs/bpf_iter_netlink.c    |  3 ++-
> > >  .../selftests/bpf/progs/bpf_iter_udp4.c       |  2 +-
> > >  .../selftests/bpf/progs/bpf_iter_udp6.c       |  2 +-
> > >  4 files changed, 24 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/include/net/sock.h b/include/net/sock.h
> > > index f40e3c4883be32c8282694ab215bcf79eb87cbd7..318169eb1a3d40eefac50=
147012551614abc6f7a 100644
> > > --- a/include/net/sock.h
> > > +++ b/include/net/sock.h
> > > @@ -282,6 +282,7 @@ struct sk_filter;
> > >    *    @sk_err_soft: errors that don't cause failure but are the cau=
se of a
> > >    *                  persistent failure not just 'timed out'
> > >    *    @sk_drops: raw/udp drops counter
> > > +  *    @sk_drops1: second drops counter
> > >    *    @sk_ack_backlog: current listen backlog
> > >    *    @sk_max_ack_backlog: listen backlog set in listen()
> > >    *    @sk_uid: user id of owner
> > > @@ -571,6 +572,11 @@ struct sock {
> > >         atomic_t                sk_drops ____cacheline_aligned_in_smp=
;
> > >         struct rcu_head         sk_rcu;
> > >         netns_tracker           ns_tracker;
> > > +#if defined(CONFIG_NUMA)
> > > +       atomic_t                sk_drops1 ____cacheline_aligned_in_sm=
p;
> > > +#else
> > > +       atomic_t                sk_drops1;
> >
> > Is this #else to be friendly to bpf selftests ?
>
> Sure !
>
> What problem are you seeing exactly ?

No problem, sk_drops is aligned anyway, I was just curious :)

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thank you, Eric !

>
>
> >
> >
> > > +#endif
> > >  };
> > >
> > >  struct sock_bh_locked {
> > > @@ -2684,17 +2690,31 @@ struct sock_skb_cb {
> > >
> > >  static inline void sk_drops_inc(struct sock *sk)
> > >  {
> > > +#if defined(CONFIG_NUMA)
> > > +       int n =3D numa_node_id() % 2;
> > > +
> > > +       if (n)
> > > +               atomic_inc(&sk->sk_drops1);
> > > +       else
> > > +               atomic_inc(&sk->sk_drops);
> > > +#else
> > >         atomic_inc(&sk->sk_drops);
> > > +#endif
> > >  }
> > >
> > >  static inline int sk_drops_read(const struct sock *sk)
> > >  {
> > > +#if defined(CONFIG_NUMA)
> > > +       return atomic_read(&sk->sk_drops) + atomic_read(&sk->sk_drops=
1);
> > > +#else
> > >         return atomic_read(&sk->sk_drops);
> > > +#endif
> > >  }
> > >
> > >  static inline void sk_drops_reset(struct sock *sk)
> > >  {
> > >         atomic_set(&sk->sk_drops, 0);
> > > +       atomic_set(&sk->sk_drops1, 0);
> > >  }
> > >
> > >  static inline void
> > > diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_netlink.c b/t=
ools/testing/selftests/bpf/progs/bpf_iter_netlink.c
> > > index 00b2ceae81fb0914f2de3634eb342004e8bc3c5b..31ad9fcc6022d5d31b9c6=
a35daacaad7c887a51f 100644
> > > --- a/tools/testing/selftests/bpf/progs/bpf_iter_netlink.c
> > > +++ b/tools/testing/selftests/bpf/progs/bpf_iter_netlink.c
> > > @@ -57,7 +57,8 @@ int dump_netlink(struct bpf_iter__netlink *ctx)
> > >                 inode =3D SOCK_INODE(sk);
> > >                 bpf_probe_read_kernel(&ino, sizeof(ino), &inode->i_in=
o);
> > >         }
> > > -       BPF_SEQ_PRINTF(seq, "%-8u %-8lu\n", s->sk_drops.counter, ino)=
;
> > > +       BPF_SEQ_PRINTF(seq, "%-8u %-8lu\n",
> > > +                      s->sk_drops.counter + s->sk_drops1.counter, in=
o);
> > >
> > >         return 0;
> > >  }
> > > diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_udp4.c b/tool=
s/testing/selftests/bpf/progs/bpf_iter_udp4.c
> > > index ffbd4b116d17ffbb9f14440c788e50490fb0f4e0..192ab5693a7131c1ec587=
9e539651c21f6f3c9ae 100644
> > > --- a/tools/testing/selftests/bpf/progs/bpf_iter_udp4.c
> > > +++ b/tools/testing/selftests/bpf/progs/bpf_iter_udp4.c
> > > @@ -64,7 +64,7 @@ int dump_udp4(struct bpf_iter__udp *ctx)
> > >                        0, 0L, 0, ctx->uid, 0,
> > >                        sock_i_ino(&inet->sk),
> > >                        inet->sk.sk_refcnt.refs.counter, udp_sk,
> > > -                      inet->sk.sk_drops.counter);
> > > +                      inet->sk.sk_drops.counter + inet->sk.sk_drops1=
.counter);
> > >
> > >         return 0;
> > >  }
> > > diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_udp6.c b/tool=
s/testing/selftests/bpf/progs/bpf_iter_udp6.c
> > > index 47ff7754f4fda4c9db92fbf1dc2e6a68f044174e..5170bdf458fa1b9a4eea9=
240fbaa5934182a7776 100644
> > > --- a/tools/testing/selftests/bpf/progs/bpf_iter_udp6.c
> > > +++ b/tools/testing/selftests/bpf/progs/bpf_iter_udp6.c
> > > @@ -72,7 +72,7 @@ int dump_udp6(struct bpf_iter__udp *ctx)
> > >                        0, 0L, 0, ctx->uid, 0,
> > >                        sock_i_ino(&inet->sk),
> > >                        inet->sk.sk_refcnt.refs.counter, udp_sk,
> > > -                      inet->sk.sk_drops.counter);
> > > +                      inet->sk.sk_drops.counter + inet->sk.sk_drops1=
.counter);
> > >
> > >         return 0;
> > >  }
> > > --
> > > 2.51.0.261.g7ce5a0a67e-goog
> > >

