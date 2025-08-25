Return-Path: <netdev+bounces-216644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CCCB34B9D
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 22:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3941024296E
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 20:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1291622128B;
	Mon, 25 Aug 2025 20:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bU+JU4lh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F821993B9
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 20:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756153169; cv=none; b=ao6rF4QhVmtyUPb8uylDamckqxFuoCp3PbLLO2W+aFoMcCSMAauGuGXypoAWLfNzojOBPI0dUQRNlFhLXpmx490gJ6L47Y+6IG8mkX1aOSeGcODfy1oy3FSE3fk1R9XAvPHWXwpR0TZbFpfTEGVujqaQ4+8c6i3+SmzyVH2dLIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756153169; c=relaxed/simple;
	bh=UYnw3m4a5mRv4DjebkOw4i6o3o+4bzpviJwdT44nMiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SvG2xfJM+91b01FKNt0LUD31zd2ydbW9DpOWHyAPz2KMHOo5AkFQpSN/Gp5Frb+t8DTiJ/KlcoJBu7zIhgfyCnL9Jg+xdaghgTdOLKIZUVNVC1I9ar3kByo9spacoRvs+qkioPXCL2QYpG4DKGNCFuNIqYBnsQdrbQi138ToPZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bU+JU4lh; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-244582738b5so43005565ad.3
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 13:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756153167; x=1756757967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0yPbgsG+EYmt7A1gXiJUDeqivWp0S+wb7yvLg7vOsVM=;
        b=bU+JU4lh6s3c242w36r0NTspTKqRKrcJ4WHYgXE1Zl2WBV4QrP73janhAdvI+FsjSX
         YtllRwn8vsxCh1QJobDwrBTJFcQlaKlYmbC/BwHvnKQCjrTiSh+VCdU2xYw/OJDkGVk9
         oAH5qi2HqkrCb8HcLW7lZIY/WDmO1QQJYetTHYm+v/vHlCcQTjBCiUMZdtF6HnbUi6PR
         viHNYQVaRHcKWPVWjakBnITjHq/v2qnbuJKUS+Ag1mMKOvITqs9b7yfhWv4AAsZXQ2D1
         aSfP9Tko8X0ljDlouyHnB+B7SzQLNz8+GkiVKOlEjwf75MltK4dn4DXbjCpCgoE9b3JZ
         gL4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756153167; x=1756757967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0yPbgsG+EYmt7A1gXiJUDeqivWp0S+wb7yvLg7vOsVM=;
        b=Lm83vMzp3oVQtymyl+6Guic4JiCnOUhzLhpBRDc6sMbZIMFLFTG9S2xC1WXfhLo4vG
         3aRl8nR7VFZ3ZKkLviUO1rGIWhlCnbLTVZ6K5OkvQIyk6MRjd5F5ANtUJzR8lwHyrLUu
         jGH4IwycBtbDXE9QdSIrz7+eynwwwiOCdF9q4iyQz4oz/m+R1J+pty7ERXUvuKoos+I2
         wPVNGZGk1lJPSkB/4WFkHOiOAYZoI4pi0wfs7FKHaykyb1wakjk62aO9tpJ+vkpcnIzx
         wqu1wMaXQgrZ8wsMlBdCnZktnKzTW36qW562BsTmJihKFK/bI2lPixfpZSYNXfuw0xOO
         c01w==
X-Forwarded-Encrypted: i=1; AJvYcCXcyf6xYsZPFvEggdGq1Fl8DQndJadsgEs+4yQu3mNwFeaZ7z4jOoNcZCC2jhjBP5xcVigodCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkTP7rDbPzGPtt+BF/rCBLuWtjVrdAo2EBqFnLh+dPKp+HQoUh
	/vV63lglTi4lf3LL5Md8r4WIEr0klPOhoJzaWMnxhn8jXbRbNA2XPFuryHezx2xvoUFw7pAOyjW
	ykUl4Kold/oF6diX7UiFihZxkknICn89um53F9ofm
X-Gm-Gg: ASbGncswjYBK9f3BilJkyFISNpl8X+1kbMxGUKl/lynBNJu+cRL5D3C9lcDAU5TNel+
	rMsJDW+Jo95cM7uGDjhUoBJvCQaPHePD+6RFIqta0z3cvNj0HMNK8NQ2awejN0gTDk88+Z5OlDj
	W+yLmcHA8QyIC7n/x1Ho11dO/11rt7yQOl9g/alitLT3Kmomfum6ezTvXQWVUrEahJGFzukorLj
	9tBZfKG94ot79OJrvbPIlxNAuao9+XX6BMhFNPr4bHf/a/uMQTVLnfKSQJBTlcPl1bRKWmzCZc6
	/2DtFf571Q==
X-Google-Smtp-Source: AGHT+IF3ErWmZWQnn7M8ci4PHOpQv8dpPiDP94ZEfyYPW9IGAtz7HcKqWdt0bHKe7Ebe1i2QwMoNSIQCoRtlmC/7ct0=
X-Received: by 2002:a17:902:d504:b0:246:dadc:c576 with SMTP id
 d9443c01a7336-246dadcc9c1mr62555785ad.58.1756153166414; Mon, 25 Aug 2025
 13:19:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825195947.4073595-1-edumazet@google.com> <20250825195947.4073595-4-edumazet@google.com>
In-Reply-To: <20250825195947.4073595-4-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 25 Aug 2025 13:19:14 -0700
X-Gm-Features: Ac12FXxz-E_KJi071MZ_OB9CYx1euVgTX6pmBdPNmZbS6mDxphdWmZvjGoBdWfA
Message-ID: <CAAVpQUCiSJnv9QMuAFbomEeF3D=0iJYSJSmMhpQpyCFxQUgK_A@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] net: add new sk->sk_drops1 field
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 12:59=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> sk->sk_drops can be heavily contended when
> changed from many cpus.
>
> Instead using too expensive per-cpu data structure,
> add a second sk->sk_drops1 field and change
> sk_drops_inc() to be NUMA aware.
>
> This patch adds 64 bytes per socket.
>
> For hosts having more than two memory nodes, sk_drops_inc()
> might not be optimal and can be refined later.
>
> Tested with the following stress test, sending about 11 Mpps
> to a dual socket AMD EPYC 7B13 64-Core.
>
> super_netperf 20 -t UDP_STREAM -H DUT -l10 -- -n -P,1000 -m 120
> Note: due to socket lookup, only one UDP socket will receive
> packets on DUT.
>
> Then measure receiver (DUT) behavior. We can see
> consumer and BH handlers can process more packets per second.
>
> Before:
>
> nstat -n ; sleep 1 ; nstat | grep Udp
> Udp6InDatagrams                 855592             0.0
> Udp6InErrors                    5621467            0.0
> Udp6RcvbufErrors                5621467            0.0
>
> After:
> nstat -n ; sleep 1 ; nstat | grep Udp
> Udp6InDatagrams                 914537             0.0
> Udp6InErrors                    6888487            0.0
> Udp6RcvbufErrors                6888487            0.0
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/net/sock.h                            | 20 +++++++++++++++++++
>  .../selftests/bpf/progs/bpf_iter_netlink.c    |  3 ++-
>  .../selftests/bpf/progs/bpf_iter_udp4.c       |  2 +-
>  .../selftests/bpf/progs/bpf_iter_udp6.c       |  2 +-
>  4 files changed, 24 insertions(+), 3 deletions(-)
>
> diff --git a/include/net/sock.h b/include/net/sock.h
> index f40e3c4883be32c8282694ab215bcf79eb87cbd7..318169eb1a3d40eefac501470=
12551614abc6f7a 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -282,6 +282,7 @@ struct sk_filter;
>    *    @sk_err_soft: errors that don't cause failure but are the cause o=
f a
>    *                  persistent failure not just 'timed out'
>    *    @sk_drops: raw/udp drops counter
> +  *    @sk_drops1: second drops counter
>    *    @sk_ack_backlog: current listen backlog
>    *    @sk_max_ack_backlog: listen backlog set in listen()
>    *    @sk_uid: user id of owner
> @@ -571,6 +572,11 @@ struct sock {
>         atomic_t                sk_drops ____cacheline_aligned_in_smp;
>         struct rcu_head         sk_rcu;
>         netns_tracker           ns_tracker;
> +#if defined(CONFIG_NUMA)
> +       atomic_t                sk_drops1 ____cacheline_aligned_in_smp;
> +#else
> +       atomic_t                sk_drops1;

Is this #else to be friendly to bpf selftests ?


> +#endif
>  };
>
>  struct sock_bh_locked {
> @@ -2684,17 +2690,31 @@ struct sock_skb_cb {
>
>  static inline void sk_drops_inc(struct sock *sk)
>  {
> +#if defined(CONFIG_NUMA)
> +       int n =3D numa_node_id() % 2;
> +
> +       if (n)
> +               atomic_inc(&sk->sk_drops1);
> +       else
> +               atomic_inc(&sk->sk_drops);
> +#else
>         atomic_inc(&sk->sk_drops);
> +#endif
>  }
>
>  static inline int sk_drops_read(const struct sock *sk)
>  {
> +#if defined(CONFIG_NUMA)
> +       return atomic_read(&sk->sk_drops) + atomic_read(&sk->sk_drops1);
> +#else
>         return atomic_read(&sk->sk_drops);
> +#endif
>  }
>
>  static inline void sk_drops_reset(struct sock *sk)
>  {
>         atomic_set(&sk->sk_drops, 0);
> +       atomic_set(&sk->sk_drops1, 0);
>  }
>
>  static inline void
> diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_netlink.c b/tools=
/testing/selftests/bpf/progs/bpf_iter_netlink.c
> index 00b2ceae81fb0914f2de3634eb342004e8bc3c5b..31ad9fcc6022d5d31b9c6a35d=
aacaad7c887a51f 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_iter_netlink.c
> +++ b/tools/testing/selftests/bpf/progs/bpf_iter_netlink.c
> @@ -57,7 +57,8 @@ int dump_netlink(struct bpf_iter__netlink *ctx)
>                 inode =3D SOCK_INODE(sk);
>                 bpf_probe_read_kernel(&ino, sizeof(ino), &inode->i_ino);
>         }
> -       BPF_SEQ_PRINTF(seq, "%-8u %-8lu\n", s->sk_drops.counter, ino);
> +       BPF_SEQ_PRINTF(seq, "%-8u %-8lu\n",
> +                      s->sk_drops.counter + s->sk_drops1.counter, ino);
>
>         return 0;
>  }
> diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_udp4.c b/tools/te=
sting/selftests/bpf/progs/bpf_iter_udp4.c
> index ffbd4b116d17ffbb9f14440c788e50490fb0f4e0..192ab5693a7131c1ec5879e53=
9651c21f6f3c9ae 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_iter_udp4.c
> +++ b/tools/testing/selftests/bpf/progs/bpf_iter_udp4.c
> @@ -64,7 +64,7 @@ int dump_udp4(struct bpf_iter__udp *ctx)
>                        0, 0L, 0, ctx->uid, 0,
>                        sock_i_ino(&inet->sk),
>                        inet->sk.sk_refcnt.refs.counter, udp_sk,
> -                      inet->sk.sk_drops.counter);
> +                      inet->sk.sk_drops.counter + inet->sk.sk_drops1.cou=
nter);
>
>         return 0;
>  }
> diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_udp6.c b/tools/te=
sting/selftests/bpf/progs/bpf_iter_udp6.c
> index 47ff7754f4fda4c9db92fbf1dc2e6a68f044174e..5170bdf458fa1b9a4eea9240f=
baa5934182a7776 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_iter_udp6.c
> +++ b/tools/testing/selftests/bpf/progs/bpf_iter_udp6.c
> @@ -72,7 +72,7 @@ int dump_udp6(struct bpf_iter__udp *ctx)
>                        0, 0L, 0, ctx->uid, 0,
>                        sock_i_ino(&inet->sk),
>                        inet->sk.sk_refcnt.refs.counter, udp_sk,
> -                      inet->sk.sk_drops.counter);
> +                      inet->sk.sk_drops.counter + inet->sk.sk_drops1.cou=
nter);
>
>         return 0;
>  }
> --
> 2.51.0.261.g7ce5a0a67e-goog
>

