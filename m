Return-Path: <netdev+bounces-216796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB291B35383
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 07:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF920242090
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 05:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A455A231845;
	Tue, 26 Aug 2025 05:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t+vJdaDu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E030329B0
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 05:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756187196; cv=none; b=JBCMgAfmBnrz4O22SMlAYqf/m3w7a8hgRYJQChRY1BTaz8h385V1g0v1mYzjisYvT9k428rVxbA+sJfWoA4R9ZzdWskRjc6Vnn48cs6GDegXin/llKtbDQZcb2WhN3Y6kqHtdEd/xvbW1KEOGpqh86IQp26fY3mo+HgVJsYllcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756187196; c=relaxed/simple;
	bh=5p0uteWQ7kjJ58vQ00trJdA0F1fuvl+aH9zIf8H+8Ds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gf5sVc50M5z1IuD98BZr5r2kk/inrP/t3+ZnFwgVxmXPkPGSvNwoK0XtTiKiNKeoCIBUYPY0ewRS4nlpGljvy7xClGKiSw7kcKtH/A7+nG4RR7RY4IAULGOMYreu/B3zDrCZ+wiAj50tCaagxPlStEI/iwuTIaCBKrCEWKxQCtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t+vJdaDu; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7e86faa158fso669810685a.1
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 22:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756187194; x=1756791994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DUmoU4al8eqs3sho9O/4dL8As5z6+mTQbKneg1eB9ZE=;
        b=t+vJdaDu9gacVc19VQWnqmwXErogHDUqPeOgGqvXuIkUz/kVJobtxPhj9ZOxasjISp
         H2i6qDBxNrjDQUq7/DU5U5nb52R+rUiEzAzFIRnY0y+Ams7XEvwHj8agYR9gzp7T3y4w
         wcxcyiGew04Lqi4Sh4tVPdhKno5HJqdXBIKvdUginylPCpCMlOoqMFpqO/DyeIT48PdH
         W1QZIgEHobG1ndoRfmZTtJw5AwcUCnskhU5M9AB8stfMuYXgZS7PhHEj2mTbXEIqZ7g8
         D61ld26xdlGv8Ldr6cEE8L2EiDWpkaDpXA+T8cm0StkcseFAZ6pGveNUKZDIG9QSzXyx
         XXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756187194; x=1756791994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DUmoU4al8eqs3sho9O/4dL8As5z6+mTQbKneg1eB9ZE=;
        b=SqZyVQdes5OFImOfZj7WWX6j0SuEEJOfwYKbEwNK3/X3vqWRVpXVmhjRyE4swaQsTV
         I1hqxQMIPH83oy82pJJWoEnVqEn7J/jf0dkyF3Jg5urQsZAJeqKiwmX8WrJhD760gAnA
         68ZbI7T0W16K+0xRsRCG6fvyAk2HUV5Jrfj0zOdwjQ787mK6w1ymZl3o2LFBWZ2ptyEq
         QEQemNId+J9Q7No96mNXy+hbydKA4XSYzu34Nimq08xsLW7cD7dX0ChtD4hJh0jdP4kL
         AlXd4Q5GeTtwNjWjY4ywrhdCc4CfAD99g1Dp8SmxqDsBpY5Nz7gdrN4/UI8dT+7Q0sht
         3BfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXp195F12flq/fvyqChSx8p4nzYvh+1xbRW6LhUv+ZeJCaHEx6bKzMMj1+naRzwKbcDLJSk9sM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO2/lVecDxGBCxYXL4BpttxcNO0egFqsv/3CKMIl7kyVRPZkqP
	KwJptbtyqBd3kdEJDvWBEGIawDHnqUbuvmL0DXqwq/3WJIfrteD7LTRq6wBpFrRr2bTrrxvjCLb
	XmVCmaOVSPtwUOl5SebMQFdBiPQ5jiZGsGrQW75aZ
X-Gm-Gg: ASbGncup0akGnDfkvdRev6WT/MYVet4rPvfzqkjGqiW2iOYz212rJF6r6TMBgDX7kbu
	b5tTfte89TB5NOGud7aiXOuqseWTg6WxkvGehsbYSpfepSgul1369uqV5LP5NQVd2oNJsCFN0xe
	pN1yC2yeFmotbH+ckdwiosyiXo1B5Nvb6xg4zuUdVzeqBkf8z117VfJFlbptKdupANG2iFsBvpe
	11pPsShvFQbVew=
X-Google-Smtp-Source: AGHT+IH1DRgasVlSdirTsDd58pwl9FHC1rUj84z6pLs+Bjn9t2bHlqwaoDS2SM1h4NUmdbEYo9BGHegYW9phc9JdK3E=
X-Received: by 2002:a05:620a:45a8:b0:7f1:3603:9a7f with SMTP id
 af79cd13be357-7f58d941f4emr18991885a.34.1756187193365; Mon, 25 Aug 2025
 22:46:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825195947.4073595-1-edumazet@google.com> <20250825195947.4073595-4-edumazet@google.com>
 <CAAVpQUCiSJnv9QMuAFbomEeF3D=0iJYSJSmMhpQpyCFxQUgK_A@mail.gmail.com>
In-Reply-To: <CAAVpQUCiSJnv9QMuAFbomEeF3D=0iJYSJSmMhpQpyCFxQUgK_A@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 25 Aug 2025 22:46:22 -0700
X-Gm-Features: Ac12FXyfCQmI0nFBFoTWKEx_kgS7TUNxmo-kNgot2c9aKwK3fbSd4U2mwLmje2g
Message-ID: <CANn89iLsA1N7NDz71GRaoMWn2xWmJvMP4oPs=yMCbLvE--R8kQ@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] net: add new sk->sk_drops1 field
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 1:19=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> On Mon, Aug 25, 2025 at 12:59=E2=80=AFPM Eric Dumazet <edumazet@google.co=
m> wrote:
> >
> > sk->sk_drops can be heavily contended when
> > changed from many cpus.
> >
> > Instead using too expensive per-cpu data structure,
> > add a second sk->sk_drops1 field and change
> > sk_drops_inc() to be NUMA aware.
> >
> > This patch adds 64 bytes per socket.
> >
> > For hosts having more than two memory nodes, sk_drops_inc()
> > might not be optimal and can be refined later.
> >
> > Tested with the following stress test, sending about 11 Mpps
> > to a dual socket AMD EPYC 7B13 64-Core.
> >
> > super_netperf 20 -t UDP_STREAM -H DUT -l10 -- -n -P,1000 -m 120
> > Note: due to socket lookup, only one UDP socket will receive
> > packets on DUT.
> >
> > Then measure receiver (DUT) behavior. We can see
> > consumer and BH handlers can process more packets per second.
> >
> > Before:
> >
> > nstat -n ; sleep 1 ; nstat | grep Udp
> > Udp6InDatagrams                 855592             0.0
> > Udp6InErrors                    5621467            0.0
> > Udp6RcvbufErrors                5621467            0.0
> >
> > After:
> > nstat -n ; sleep 1 ; nstat | grep Udp
> > Udp6InDatagrams                 914537             0.0
> > Udp6InErrors                    6888487            0.0
> > Udp6RcvbufErrors                6888487            0.0
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  include/net/sock.h                            | 20 +++++++++++++++++++
> >  .../selftests/bpf/progs/bpf_iter_netlink.c    |  3 ++-
> >  .../selftests/bpf/progs/bpf_iter_udp4.c       |  2 +-
> >  .../selftests/bpf/progs/bpf_iter_udp6.c       |  2 +-
> >  4 files changed, 24 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/net/sock.h b/include/net/sock.h
> > index f40e3c4883be32c8282694ab215bcf79eb87cbd7..318169eb1a3d40eefac5014=
7012551614abc6f7a 100644
> > --- a/include/net/sock.h
> > +++ b/include/net/sock.h
> > @@ -282,6 +282,7 @@ struct sk_filter;
> >    *    @sk_err_soft: errors that don't cause failure but are the cause=
 of a
> >    *                  persistent failure not just 'timed out'
> >    *    @sk_drops: raw/udp drops counter
> > +  *    @sk_drops1: second drops counter
> >    *    @sk_ack_backlog: current listen backlog
> >    *    @sk_max_ack_backlog: listen backlog set in listen()
> >    *    @sk_uid: user id of owner
> > @@ -571,6 +572,11 @@ struct sock {
> >         atomic_t                sk_drops ____cacheline_aligned_in_smp;
> >         struct rcu_head         sk_rcu;
> >         netns_tracker           ns_tracker;
> > +#if defined(CONFIG_NUMA)
> > +       atomic_t                sk_drops1 ____cacheline_aligned_in_smp;
> > +#else
> > +       atomic_t                sk_drops1;
>
> Is this #else to be friendly to bpf selftests ?

Sure !

What problem are you seeing exactly ?


>
>
> > +#endif
> >  };
> >
> >  struct sock_bh_locked {
> > @@ -2684,17 +2690,31 @@ struct sock_skb_cb {
> >
> >  static inline void sk_drops_inc(struct sock *sk)
> >  {
> > +#if defined(CONFIG_NUMA)
> > +       int n =3D numa_node_id() % 2;
> > +
> > +       if (n)
> > +               atomic_inc(&sk->sk_drops1);
> > +       else
> > +               atomic_inc(&sk->sk_drops);
> > +#else
> >         atomic_inc(&sk->sk_drops);
> > +#endif
> >  }
> >
> >  static inline int sk_drops_read(const struct sock *sk)
> >  {
> > +#if defined(CONFIG_NUMA)
> > +       return atomic_read(&sk->sk_drops) + atomic_read(&sk->sk_drops1)=
;
> > +#else
> >         return atomic_read(&sk->sk_drops);
> > +#endif
> >  }
> >
> >  static inline void sk_drops_reset(struct sock *sk)
> >  {
> >         atomic_set(&sk->sk_drops, 0);
> > +       atomic_set(&sk->sk_drops1, 0);
> >  }
> >
> >  static inline void
> > diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_netlink.c b/too=
ls/testing/selftests/bpf/progs/bpf_iter_netlink.c
> > index 00b2ceae81fb0914f2de3634eb342004e8bc3c5b..31ad9fcc6022d5d31b9c6a3=
5daacaad7c887a51f 100644
> > --- a/tools/testing/selftests/bpf/progs/bpf_iter_netlink.c
> > +++ b/tools/testing/selftests/bpf/progs/bpf_iter_netlink.c
> > @@ -57,7 +57,8 @@ int dump_netlink(struct bpf_iter__netlink *ctx)
> >                 inode =3D SOCK_INODE(sk);
> >                 bpf_probe_read_kernel(&ino, sizeof(ino), &inode->i_ino)=
;
> >         }
> > -       BPF_SEQ_PRINTF(seq, "%-8u %-8lu\n", s->sk_drops.counter, ino);
> > +       BPF_SEQ_PRINTF(seq, "%-8u %-8lu\n",
> > +                      s->sk_drops.counter + s->sk_drops1.counter, ino)=
;
> >
> >         return 0;
> >  }
> > diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_udp4.c b/tools/=
testing/selftests/bpf/progs/bpf_iter_udp4.c
> > index ffbd4b116d17ffbb9f14440c788e50490fb0f4e0..192ab5693a7131c1ec5879e=
539651c21f6f3c9ae 100644
> > --- a/tools/testing/selftests/bpf/progs/bpf_iter_udp4.c
> > +++ b/tools/testing/selftests/bpf/progs/bpf_iter_udp4.c
> > @@ -64,7 +64,7 @@ int dump_udp4(struct bpf_iter__udp *ctx)
> >                        0, 0L, 0, ctx->uid, 0,
> >                        sock_i_ino(&inet->sk),
> >                        inet->sk.sk_refcnt.refs.counter, udp_sk,
> > -                      inet->sk.sk_drops.counter);
> > +                      inet->sk.sk_drops.counter + inet->sk.sk_drops1.c=
ounter);
> >
> >         return 0;
> >  }
> > diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_udp6.c b/tools/=
testing/selftests/bpf/progs/bpf_iter_udp6.c
> > index 47ff7754f4fda4c9db92fbf1dc2e6a68f044174e..5170bdf458fa1b9a4eea924=
0fbaa5934182a7776 100644
> > --- a/tools/testing/selftests/bpf/progs/bpf_iter_udp6.c
> > +++ b/tools/testing/selftests/bpf/progs/bpf_iter_udp6.c
> > @@ -72,7 +72,7 @@ int dump_udp6(struct bpf_iter__udp *ctx)
> >                        0, 0L, 0, ctx->uid, 0,
> >                        sock_i_ino(&inet->sk),
> >                        inet->sk.sk_refcnt.refs.counter, udp_sk,
> > -                      inet->sk.sk_drops.counter);
> > +                      inet->sk.sk_drops.counter + inet->sk.sk_drops1.c=
ounter);
> >
> >         return 0;
> >  }
> > --
> > 2.51.0.261.g7ce5a0a67e-goog
> >

