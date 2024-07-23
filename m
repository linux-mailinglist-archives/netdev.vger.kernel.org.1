Return-Path: <netdev+bounces-112631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D692393A415
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 18:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 043631C22304
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 16:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1743F153BF9;
	Tue, 23 Jul 2024 16:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuZEVW8t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D1D14EC61
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 16:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721750480; cv=none; b=MWIUrm5osPa+kprQOdAq27vbmf1A6nV/XhvWnoDEOXCIWCH/ER0IfHZ0A52SDkEM8Mfq0yezCZrhpHlmcTB9VXMgMfX9ub+/5DgC2oUAvAGGjNmgBjHtA/H1eiseuuFHqTWHqQ5muaK4qo05armyUKEuYu3G3qNNv1sTxTTglVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721750480; c=relaxed/simple;
	bh=yjqC8ocz0HccprPaHqrep+5Bst0yQwQ4PGORzfZHVZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GcQCh31Ypsvku1mXLZh8nunsxgDe5TKaXvSDcc84AwNbSXtCRJGN/8Av+WGGj0p7fVh27s3DRCrK30w3VWbsEeImFV+Jufope+/C/1Zqh5K9prHjuCUHelyJO1sG1vJrybfobNwhqN3m52BbznKR9SeG9BQ4Lt8y+t0pLhOIG14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iuZEVW8t; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ef27bfd15bso34723881fa.2
        for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 09:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721750476; x=1722355276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b3nRE89AnesQ3DegJteWh+BgTiNbdsW8AjcsQjZIQFo=;
        b=iuZEVW8tMW7fHSc9ymlJYImdfJCHPgd0MDHuqWmyUJAXAeYJ8wNDSJUqe5lS6q7Nm1
         RtB2UItkMof3uywwycsSvC28VIl/xU/uKLqT8Yg4+LZDxQYc0OpRfaHZqFFFNy+5MTPU
         f2hCBhPrW5zPAE0iDVXgkPw3/9Tp1B2UXRAyZH4VKvUwzVVgS9eCbAai4prLyOAJR7Dc
         LxDpn7FVQgNWfFINsZ9Tqj1K8F/Mkpj265lFshMQqS5/rxuuD7GFyoVrkpWH1b9r72IU
         Pwu0CNJyomD27k0uUIpS1dGzrjsYsdr+ZiZ11Nqb3WceSwqpyzZR/wzwgdNkg8/yes/V
         +hmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721750476; x=1722355276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b3nRE89AnesQ3DegJteWh+BgTiNbdsW8AjcsQjZIQFo=;
        b=t2UtD+20rmVxr1q64k5axwVXCs85nkbU3aDSP0nbp8xE4J8z0D5TOvqzrSbWoSvjgd
         S0UfX9Uf+zN/qAtgVWhYnptiudfmhNSfpiSBDfIXfsSN2BvDoOOL7HymOIFdjU7gb44N
         4hnhcnmsYZ6Yf0UtT+yhe9dMOeUQio37IlGJFww4a+jNAageEA2ozhrPDWM2gYOmXF2E
         BlMWEa3xLvRDwUCgNF+//Goe1nHEQYEGsUYvGMipfdT1pua6vr6cFVDab8zUmlrdDe4p
         rhjZlRcbKqwNwp2B3KkOGbi8BmaiihtKXJVzBv3XTHa6j8e3SyQ9O+BJkuK+/Wfu/uBu
         5KjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhc8EZM0sTOp0hyv9k0dQV2OmUh87hwF7wNNx3eAk81T7KQNg+1W6Idpy+QFkCyVh9NNyZZ7uYCnku1E6lu0xYPOZzGOXr
X-Gm-Message-State: AOJu0Yxd+r8dIO5aWyffrxdKU35BDfC/G3Idfszu6fyav8t6ScnRd5ip
	WoVM97LqVaLoublMfVhn48C7gVw4PJLbfUA+wVzuitARVnZSFHZ3uu6ujfB/Dm5dRYZ/VCvyqCC
	yNNZT2Qgj3q3zUYKAqetzn05KoZKv0+j9ZfU=
X-Google-Smtp-Source: AGHT+IFnDKlhfaR47qS3+LZmKBd/6f3d2MkLNbN/t18YgiUcywm5BwsV7i07+jR+YwLtZPImiOXYRRxznKA3RHWwXlA=
X-Received: by 2002:a05:651c:549:b0:2ef:32fb:6c4c with SMTP id
 38308e7fff4ca-2ef32fb6e8amr40696441fa.45.1721750475653; Tue, 23 Jul 2024
 09:01:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723135742.35102-1-kerneljasonxing@gmail.com>
 <CANn89i+dYsvrVwWCRX=B1ZyL3nZUjnNtaQ5rfizDOV5XhHV2dQ@mail.gmail.com>
 <CAL+tcoDZ2VDCd00ydv-RzMudq=d+jVukiDLgs7RpsJwvGqBp1Q@mail.gmail.com>
 <CAL+tcoCC2g1iHA__vr8bbUX-kba2bBi2NbQNZnxOAMTJOQQAWg@mail.gmail.com> <CANn89i+3c3fg1SYEpx02yCKHfBoZvYJt=wTqgZ77nCWzN0q-Wg@mail.gmail.com>
In-Reply-To: <CANn89i+3c3fg1SYEpx02yCKHfBoZvYJt=wTqgZ77nCWzN0q-Wg@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 24 Jul 2024 00:00:38 +0800
Message-ID: <CAL+tcoB3iwsTTt8Bpc62Zc-CoyOGRrAdAjo26XqUvFnBoqXpTw@mail.gmail.com>
Subject: Re: [RFC PATCH net-next] net: add an entry for CONFIG_NET_RX_BUSY_POLL
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 11:26=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Tue, Jul 23, 2024 at 5:13=E2=80=AFPM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > On Tue, Jul 23, 2024 at 11:09=E2=80=AFPM Jason Xing <kerneljasonxing@gm=
ail.com> wrote:
> > >
> > > On Tue, Jul 23, 2024 at 10:57=E2=80=AFPM Eric Dumazet <edumazet@googl=
e.com> wrote:
> > > >
> > > > On Tue, Jul 23, 2024 at 3:57=E2=80=AFPM Jason Xing <kerneljasonxing=
@gmail.com> wrote:
> > > > >
> > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > >
> > > > > When I was doing performance test on unix_poll(), I found out tha=
t
> > > > > accessing sk->sk_ll_usec when calling sock_poll()->sk_can_busy_lo=
op()
> > > > > occupies too much time, which causes around 16% degradation. So I
> > > > > decided to turn off this config, which cannot be done apparently
> > > > > before this patch.
> > > >
> > > > Too many CONFIG_ options, distros will enable it anyway.
> > > >
> > > > In my builds, offset of sk_ll_usec is 0xe8.
> > > >
> > > > Are you using some debug options or an old tree ?
> >
> > I forgot to say: I'm running the latest kernel which I pulled around
> > two hours ago. Whatever kind of configs with/without debug options I
> > use, I can still reproduce it.
>
> Ok, please post :
>
> pahole --hex -C sock vmlinux

1) Enable the config:
$ pahole --hex -C sock vmlinux
struct sock {
        struct sock_common         __sk_common;          /*     0  0x88 */
        /* --- cacheline 2 boundary (128 bytes) was 8 bytes ago --- */
        __u8
__cacheline_group_begin__sock_write_rx[0]; /*  0x88     0 */
        atomic_t                   sk_drops;             /*  0x88   0x4 */
        __s32                      sk_peek_off;          /*  0x8c   0x4 */
        struct sk_buff_head        sk_error_queue;       /*  0x90  0x18 */
        struct sk_buff_head        sk_receive_queue;     /*  0xa8  0x18 */
        /* --- cacheline 3 boundary (192 bytes) --- */
        struct {
                atomic_t           rmem_alloc;           /*  0xc0   0x4 */
                int                len;                  /*  0xc4   0x4 */
                struct sk_buff *   head;                 /*  0xc8   0x8 */
                struct sk_buff *   tail;                 /*  0xd0   0x8 */
        } sk_backlog;                                    /*  0xc0  0x18 */
        __u8
__cacheline_group_end__sock_write_rx[0]; /*  0xd8     0 */
        __u8
__cacheline_group_begin__sock_read_rx[0]; /*  0xd8     0 */
        struct dst_entry *         sk_rx_dst;            /*  0xd8   0x8 */
        int                        sk_rx_dst_ifindex;    /*  0xe0   0x4 */
        u32                        sk_rx_dst_cookie;     /*  0xe4   0x4 */
        unsigned int               sk_ll_usec;           /*  0xe8   0x4 */
        unsigned int               sk_napi_id;           /*  0xec   0x4 */
        u16                        sk_busy_poll_budget;  /*  0xf0   0x2 */
        u8                         sk_prefer_busy_poll;  /*  0xf2   0x1 */
        u8                         sk_userlocks;         /*  0xf3   0x1 */
        int                        sk_rcvbuf;            /*  0xf4   0x4 */
        struct sk_filter *         sk_filter;            /*  0xf8   0x8 */
        /* --- cacheline 4 boundary (256 bytes) --- */
        union {
                struct socket_wq * sk_wq;                /* 0x100   0x8 */
                struct socket_wq * sk_wq_raw;            /* 0x100   0x8 */
        };                                               /* 0x100   0x8 */
        void                       (*sk_data_ready)(struct sock *); /*
0x108   0x8 */
        long int                   sk_rcvtimeo;          /* 0x110   0x8 */
        int                        sk_rcvlowat;          /* 0x118   0x4 */
        __u8
__cacheline_group_end__sock_read_rx[0]; /* 0x11c     0 */
        __u8
__cacheline_group_begin__sock_read_rxtx[0]; /* 0x11c     0 */
        int                        sk_err;               /* 0x11c   0x4 */
        struct socket *            sk_socket;            /* 0x120   0x8 */
        struct mem_cgroup *        sk_memcg;             /* 0x128   0x8 */
        struct xfrm_policy *       sk_policy[2];         /* 0x130  0x10 */
        /* --- cacheline 5 boundary (320 bytes) --- */
        __u8
__cacheline_group_end__sock_read_rxtx[0]; /* 0x140     0 */
        __u8
__cacheline_group_begin__sock_write_rxtx[0]; /* 0x140     0 */
        socket_lock_t              sk_lock;              /* 0x140  0x20 */
        u32                        sk_reserved_mem;      /* 0x160   0x4 */
        int                        sk_forward_alloc;     /* 0x164   0x4 */
        u32                        sk_tsflags;           /* 0x168   0x4 */
        __u8
__cacheline_group_end__sock_write_rxtx[0]; /* 0x16c     0 */
        __u8
__cacheline_group_begin__sock_write_tx[0]; /* 0x16c     0 */
        int                        sk_write_pending;     /* 0x16c   0x4 */
        atomic_t                   sk_omem_alloc;        /* 0x170   0x4 */
        int                        sk_sndbuf;            /* 0x174   0x4 */
        int                        sk_wmem_queued;       /* 0x178   0x4 */
        refcount_t                 sk_wmem_alloc;        /* 0x17c   0x4 */
        /* --- cacheline 6 boundary (384 bytes) --- */
        long unsigned int          sk_tsq_flags;         /* 0x180   0x8 */
        union {
                struct sk_buff *   sk_send_head;         /* 0x188   0x8 */
                struct rb_root     tcp_rtx_queue;        /* 0x188   0x8 */
        };                                               /* 0x188   0x8 */
        struct sk_buff_head        sk_write_queue;       /* 0x190  0x18 */
        u32                        sk_dst_pending_confirm; /* 0x1a8   0x4 *=
/
        u32                        sk_pacing_status;     /* 0x1ac   0x4 */
        struct page_frag           sk_frag;              /* 0x1b0  0x10 */
        /* --- cacheline 7 boundary (448 bytes) --- */
        struct timer_list          sk_timer;             /* 0x1c0  0x28 */

        /* XXX last struct has 4 bytes of padding */

        long unsigned int          sk_pacing_rate;       /* 0x1e8   0x8 */
        atomic_t                   sk_zckey;             /* 0x1f0   0x4 */
        atomic_t                   sk_tskey;             /* 0x1f4   0x4 */
        __u8
__cacheline_group_end__sock_write_tx[0]; /* 0x1f8     0 */
        __u8
__cacheline_group_begin__sock_read_tx[0]; /* 0x1f8     0 */
        long unsigned int          sk_max_pacing_rate;   /* 0x1f8   0x8 */
        /* --- cacheline 8 boundary (512 bytes) --- */
        long int                   sk_sndtimeo;          /* 0x200   0x8 */
        u32                        sk_priority;          /* 0x208   0x4 */
        u32                        sk_mark;              /* 0x20c   0x4 */
        struct dst_entry *         sk_dst_cache;         /* 0x210   0x8 */
        netdev_features_t          sk_route_caps;        /* 0x218   0x8 */
        u16                        sk_gso_type;          /* 0x220   0x2 */
        u16                        sk_gso_max_segs;      /* 0x222   0x2 */
        unsigned int               sk_gso_max_size;      /* 0x224   0x4 */
        gfp_t                      sk_allocation;        /* 0x228   0x4 */
        u32                        sk_txhash;            /* 0x22c   0x4 */
        u8                         sk_pacing_shift;      /* 0x230   0x1 */
        bool                       sk_use_task_frag;     /* 0x231   0x1 */
        __u8
__cacheline_group_end__sock_read_tx[0]; /* 0x232     0 */
        u8                         sk_gso_disabled:1;    /* 0x232: 0 0x1 */
        u8                         sk_kern_sock:1;       /* 0x232:0x1 0x1 *=
/
        u8                         sk_no_check_tx:1;     /* 0x232:0x2 0x1 *=
/
        u8                         sk_no_check_rx:1;     /* 0x232:0x3 0x1 *=
/

        /* XXX 4 bits hole, try to pack */

        u8                         sk_shutdown;          /* 0x233   0x1 */
        u16                        sk_type;              /* 0x234   0x2 */
        u16                        sk_protocol;          /* 0x236   0x2 */
        long unsigned int          sk_lingertime;        /* 0x238   0x8 */
        /* --- cacheline 9 boundary (576 bytes) --- */
        struct proto *             sk_prot_creator;      /* 0x240   0x8 */
        rwlock_t                   sk_callback_lock;     /* 0x248   0x8 */
        int                        sk_err_soft;          /* 0x250   0x4 */
        u32                        sk_ack_backlog;       /* 0x254   0x4 */
        u32                        sk_max_ack_backlog;   /* 0x258   0x4 */
        kuid_t                     sk_uid;               /* 0x25c   0x4 */
        spinlock_t                 sk_peer_lock;         /* 0x260   0x4 */
        int                        sk_bind_phc;          /* 0x264   0x4 */
        struct pid *               sk_peer_pid;          /* 0x268   0x8 */
        const struct cred  *       sk_peer_cred;         /* 0x270   0x8 */
        ktime_t                    sk_stamp;             /* 0x278   0x8 */
        /* --- cacheline 10 boundary (640 bytes) --- */
        int                        sk_disconnects;       /* 0x280   0x4 */
        u8                         sk_txrehash;          /* 0x284   0x1 */
        u8                         sk_clockid;           /* 0x285   0x1 */
        u8                         sk_txtime_deadline_mode:1; /* 0x286: 0 0=
x1 */
        u8                         sk_txtime_report_errors:1; /*
0x286:0x1 0x1 */
        u8                         sk_txtime_unused:6;   /* 0x286:0x2 0x1 *=
/

        /* XXX 1 byte hole, try to pack */

        void *                     sk_user_data;         /* 0x288   0x8 */
        void *                     sk_security;          /* 0x290   0x8 */
        struct sock_cgroup_data    sk_cgrp_data;         /* 0x298  0x10 */

        /* XXX last struct has 2 bytes of padding */

        void                       (*sk_state_change)(struct sock *);
/* 0x2a8   0x8 */
        void                       (*sk_write_space)(struct sock *);
/* 0x2b0   0x8 */
        void                       (*sk_error_report)(struct sock *);
/* 0x2b8   0x8 */
        /* --- cacheline 11 boundary (704 bytes) --- */
        int                        (*sk_backlog_rcv)(struct sock *,
struct sk_buff *); /* 0x2c0   0x8 */
        void                       (*sk_destruct)(struct sock *); /*
0x2c8   0x8 */
        struct sock_reuseport *    sk_reuseport_cb;      /* 0x2d0   0x8 */
        struct bpf_local_storage * sk_bpf_storage;       /* 0x2d8   0x8 */
        struct callback_head       sk_rcu
__attribute__((__aligned__(8))); /* 0x2e0  0x10 */
        netns_tracker              ns_tracker;           /* 0x2f0     0 */

        /* size: 752, cachelines: 12, members: 105 */
        /* sum members: 749, holes: 1, sum holes: 1 */
        /* sum bitfield members: 12 bits, bit holes: 1, sum bit holes: 4 bi=
ts */
        /* paddings: 2, sum paddings: 6 */
        /* forced alignments: 1 */
        /* last cacheline: 48 bytes */
} __attribute__((__aligned__(8)));

2) Disable the config:
$ pahole --hex -C sock vmlinux
struct sock {
        struct sock_common         __sk_common;          /*     0  0x88 */
        /* --- cacheline 2 boundary (128 bytes) was 8 bytes ago --- */
        __u8
__cacheline_group_begin__sock_write_rx[0]; /*  0x88     0 */
        atomic_t                   sk_drops;             /*  0x88   0x4 */
        __s32                      sk_peek_off;          /*  0x8c   0x4 */
        struct sk_buff_head        sk_error_queue;       /*  0x90  0x18 */
        struct sk_buff_head        sk_receive_queue;     /*  0xa8  0x18 */
        /* --- cacheline 3 boundary (192 bytes) --- */
        struct {
                atomic_t           rmem_alloc;           /*  0xc0   0x4 */
                int                len;                  /*  0xc4   0x4 */
                struct sk_buff *   head;                 /*  0xc8   0x8 */
                struct sk_buff *   tail;                 /*  0xd0   0x8 */
        } sk_backlog;                                    /*  0xc0  0x18 */
        __u8
__cacheline_group_end__sock_write_rx[0]; /*  0xd8     0 */
        __u8
__cacheline_group_begin__sock_read_rx[0]; /*  0xd8     0 */
        struct dst_entry *         sk_rx_dst;            /*  0xd8   0x8 */
        int                        sk_rx_dst_ifindex;    /*  0xe0   0x4 */
        u32                        sk_rx_dst_cookie;     /*  0xe4   0x4 */
        u8                         sk_userlocks;         /*  0xe8   0x1 */

        /* XXX 3 bytes hole, try to pack */

        int                        sk_rcvbuf;            /*  0xec   0x4 */
        struct sk_filter *         sk_filter;            /*  0xf0   0x8 */
        union {
                struct socket_wq * sk_wq;                /*  0xf8   0x8 */
                struct socket_wq * sk_wq_raw;            /*  0xf8   0x8 */
        };                                               /*  0xf8   0x8 */
        /* --- cacheline 4 boundary (256 bytes) --- */
        void                       (*sk_data_ready)(struct sock *); /*
0x100   0x8 */
        long int                   sk_rcvtimeo;          /* 0x108   0x8 */
        int                        sk_rcvlowat;          /* 0x110   0x4 */
        __u8
__cacheline_group_end__sock_read_rx[0]; /* 0x114     0 */
        __u8
__cacheline_group_begin__sock_read_rxtx[0]; /* 0x114     0 */
        int                        sk_err;               /* 0x114   0x4 */
        struct socket *            sk_socket;            /* 0x118   0x8 */
        struct mem_cgroup *        sk_memcg;             /* 0x120   0x8 */
        struct xfrm_policy *       sk_policy[2];         /* 0x128  0x10 */
        __u8
__cacheline_group_end__sock_read_rxtx[0]; /* 0x138     0 */
        __u8
__cacheline_group_begin__sock_write_rxtx[0]; /* 0x138     0 */
        socket_lock_t              sk_lock;              /* 0x138  0x20 */
        /* --- cacheline 5 boundary (320 bytes) was 24 bytes ago --- */
        u32                        sk_reserved_mem;      /* 0x158   0x4 */
        int                        sk_forward_alloc;     /* 0x15c   0x4 */
        u32                        sk_tsflags;           /* 0x160   0x4 */
        __u8
__cacheline_group_end__sock_write_rxtx[0]; /* 0x164     0 */
        __u8
__cacheline_group_begin__sock_write_tx[0]; /* 0x164     0 */
        int                        sk_write_pending;     /* 0x164   0x4 */
        atomic_t                   sk_omem_alloc;        /* 0x168   0x4 */
        int                        sk_sndbuf;            /* 0x16c   0x4 */
        int                        sk_wmem_queued;       /* 0x170   0x4 */
        refcount_t                 sk_wmem_alloc;        /* 0x174   0x4 */
        long unsigned int          sk_tsq_flags;         /* 0x178   0x8 */
        /* --- cacheline 6 boundary (384 bytes) --- */
        union {
                struct sk_buff *   sk_send_head;         /* 0x180   0x8 */
                struct rb_root     tcp_rtx_queue;        /* 0x180   0x8 */
        };                                               /* 0x180   0x8 */
        struct sk_buff_head        sk_write_queue;       /* 0x188  0x18 */
        u32                        sk_dst_pending_confirm; /* 0x1a0   0x4 *=
/
        u32                        sk_pacing_status;     /* 0x1a4   0x4 */
        struct page_frag           sk_frag;              /* 0x1a8  0x10 */
        struct timer_list          sk_timer;             /* 0x1b8  0x28 */

        /* XXX last struct has 4 bytes of padding */

        /* --- cacheline 7 boundary (448 bytes) was 32 bytes ago --- */
        long unsigned int          sk_pacing_rate;       /* 0x1e0   0x8 */
        atomic_t                   sk_zckey;             /* 0x1e8   0x4 */
        atomic_t                   sk_tskey;             /* 0x1ec   0x4 */
        __u8
__cacheline_group_end__sock_write_tx[0]; /* 0x1f0     0 */
        __u8
__cacheline_group_begin__sock_read_tx[0]; /* 0x1f0     0 */
        long unsigned int          sk_max_pacing_rate;   /* 0x1f0   0x8 */
        long int                   sk_sndtimeo;          /* 0x1f8   0x8 */
        /* --- cacheline 8 boundary (512 bytes) --- */
        u32                        sk_priority;          /* 0x200   0x4 */
        u32                        sk_mark;              /* 0x204   0x4 */
        struct dst_entry *         sk_dst_cache;         /* 0x208   0x8 */
        netdev_features_t          sk_route_caps;        /* 0x210   0x8 */
        u16                        sk_gso_type;          /* 0x218   0x2 */
        u16                        sk_gso_max_segs;      /* 0x21a   0x2 */
        unsigned int               sk_gso_max_size;      /* 0x21c   0x4 */
        gfp_t                      sk_allocation;        /* 0x220   0x4 */
        u32                        sk_txhash;            /* 0x224   0x4 */
        u8                         sk_pacing_shift;      /* 0x228   0x1 */
        bool                       sk_use_task_frag;     /* 0x229   0x1 */
        __u8
__cacheline_group_end__sock_read_tx[0]; /* 0x22a     0 */
        u8                         sk_gso_disabled:1;    /* 0x22a: 0 0x1 */
        u8                         sk_kern_sock:1;       /* 0x22a:0x1 0x1 *=
/
        u8                         sk_no_check_tx:1;     /* 0x22a:0x2 0x1 *=
/
        u8                         sk_no_check_rx:1;     /* 0x22a:0x3 0x1 *=
/

        /* XXX 4 bits hole, try to pack */

        u8                         sk_shutdown;          /* 0x22b   0x1 */
        u16                        sk_type;              /* 0x22c   0x2 */
        u16                        sk_protocol;          /* 0x22e   0x2 */
        long unsigned int          sk_lingertime;        /* 0x230   0x8 */
        struct proto *             sk_prot_creator;      /* 0x238   0x8 */
        /* --- cacheline 9 boundary (576 bytes) --- */
        rwlock_t                   sk_callback_lock;     /* 0x240   0x8 */
        int                        sk_err_soft;          /* 0x248   0x4 */
        u32                        sk_ack_backlog;       /* 0x24c   0x4 */
        u32                        sk_max_ack_backlog;   /* 0x250   0x4 */
        kuid_t                     sk_uid;               /* 0x254   0x4 */
        spinlock_t                 sk_peer_lock;         /* 0x258   0x4 */
        int                        sk_bind_phc;          /* 0x25c   0x4 */
        struct pid *               sk_peer_pid;          /* 0x260   0x8 */
        const struct cred  *       sk_peer_cred;         /* 0x268   0x8 */
        ktime_t                    sk_stamp;             /* 0x270   0x8 */
        int                        sk_disconnects;       /* 0x278   0x4 */
        u8                         sk_txrehash;          /* 0x27c   0x1 */
        u8                         sk_clockid;           /* 0x27d   0x1 */
        u8                         sk_txtime_deadline_mode:1; /* 0x27e: 0 0=
x1 */
        u8                         sk_txtime_report_errors:1; /*
0x27e:0x1 0x1 */
        u8                         sk_txtime_unused:6;   /* 0x27e:0x2 0x1 *=
/

        /* XXX 1 byte hole, try to pack */

        /* --- cacheline 10 boundary (640 bytes) --- */
        void *                     sk_user_data;         /* 0x280   0x8 */
        void *                     sk_security;          /* 0x288   0x8 */
        struct sock_cgroup_data    sk_cgrp_data;         /* 0x290  0x10 */

        /* XXX last struct has 2 bytes of padding */

        void                       (*sk_state_change)(struct sock *);
/* 0x2a0   0x8 */
        void                       (*sk_write_space)(struct sock *);
/* 0x2a8   0x8 */
        void                       (*sk_error_report)(struct sock *);
/* 0x2b0   0x8 */
        int                        (*sk_backlog_rcv)(struct sock *,
struct sk_buff *); /* 0x2b8   0x8 */
        /* --- cacheline 11 boundary (704 bytes) --- */
        void                       (*sk_destruct)(struct sock *); /*
0x2c0   0x8 */
        struct sock_reuseport *    sk_reuseport_cb;      /* 0x2c8   0x8 */
        struct bpf_local_storage * sk_bpf_storage;       /* 0x2d0   0x8 */
        struct callback_head       sk_rcu
__attribute__((__aligned__(8))); /* 0x2d8  0x10 */
        netns_tracker              ns_tracker;           /* 0x2e8     0 */

        /* size: 744, cachelines: 12, members: 101 */
        /* sum members: 738, holes: 2, sum holes: 4 */
        /* sum bitfield members: 12 bits, bit holes: 1, sum bit holes: 4 bi=
ts */
        /* paddings: 2, sum paddings: 6 */
        /* forced alignments: 1 */
        /* last cacheline: 40 bytes */
} __attribute__((__aligned__(8)));

