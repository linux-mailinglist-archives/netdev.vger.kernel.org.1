Return-Path: <netdev+bounces-72457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE55885824F
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 17:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 463821F25540
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 16:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9436112F5B3;
	Fri, 16 Feb 2024 16:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ln1etkO5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0BF78B5C
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 16:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708100411; cv=none; b=AflBjA0AwYsNVYlpjFctyRdJonno+MYGz/NGW8ebDhbv7B2ySav8BvHKCfZ6Ry20jnJLUvIzns/ksOPRDH41TcV/cpiJOJGHebcIaeryQBkSxHO7WVsVrWXFjeKaLevrKS1T3xt+eUdhsiByDU82bCaE6n0hwTJcszhHaaj5ljM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708100411; c=relaxed/simple;
	bh=OPPKohFmYvYYNpZfmI/Q5kLfBn0xB4iSqmn8r0Vocag=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Cm+mr62JrZvioWD5RRwuZwt+KlkBOa+SXgLU5yBUl3E4QmcZi1xgzCn7f2OFN+5OgA7N4eS0Rvddr9Lvl/hiPnD7F6I1O4Cl5o3O4Wu1wufaDNPukimaqy5MLZQTbzKh68c07rQK2IrKlHVWOJ8bd76w9c6Q7Hn7RsPYRmHl4qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ln1etkO5; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60770007e52so12138707b3.1
        for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 08:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708100408; x=1708705208; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G1tiHfcfDXmR/fbvoVOZqIkrHnjLG5s8ETvQB/oMWgc=;
        b=Ln1etkO5ZZwznpb9ahMj0nVchjoXiD2QMJ5K49xKFLfZa5b8yQV1m+LzQ9IUCHen3u
         9I4CkC0qOEpsB5MXeRZNS40+DJgOxZJud7bVvmGaEypIqWS6UuXJVsDnlBMdOTduhy50
         40wpCTp+PShztsI7XHe8OpsYMaCVmtAH/CUT7QJOQYvmFtYOmgGhl2cYs0F0rRtw4KZU
         uN7TD9WLzUOe8UZwbkol+pRQ8YcyJgarm3KyNM2hJ4Bo44ZM1V1SBI+6Fok7qfp7l5jn
         FRSYkWLzl325w6qbYeBQnBd53Dfx+12WF5bRmGM8tM3Tc6DK9s7MSaoNkGlyT0qMv2CF
         iYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708100408; x=1708705208;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G1tiHfcfDXmR/fbvoVOZqIkrHnjLG5s8ETvQB/oMWgc=;
        b=CXu3iY99VOgFVLcRKSbysKvf/7upLfjgg969i96OdgOPFtwiVwSOhSZIJ/YqT4oWTo
         StOlXogULh7oIzJ8F1hOgbH1P1yRe4CM4zeSgO5x3Cl1zmAd0SygWAQXU/cs1pp4FMNj
         qduKuIPIVQfJY5va5Ygz0vp8IhV8qJ/BrvQVx/QXTdLT2lwnvekvK/FkMexVqr6jmBFq
         sVZ46ZOpc8k+CugtJRakkbaLfqEJe6fsWwrKTnaLNelZMUgeHxdv+bf4GnpSF6ocu8YQ
         Lmhb9j4PoLpG8scdXn9MVl/ghX4XghBSdcQewn/fTcOWyPzcOsQdoRKJvGPD7izMACtx
         11MQ==
X-Gm-Message-State: AOJu0YxBXDdXzbUh7/PuT5Y++y+r5aAggdS0KdGQD+L4Y3TSlu+00fZD
	Q11uTQ7+7nY1QAt+RQiexjaeERlXmN/p3+yiz9m4gND3GoXHRBhESFodOoDx2MrLIX0Va5B0kgf
	qHRZvloPXUA==
X-Google-Smtp-Source: AGHT+IFvLxj1UWUb5RM6rseh1IuOvcoVBewnhPjbKv7XTfXhGNOrPZsteFoYcDHsTmEwt5mA7t5/RSewOp+iQA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1008:b0:dbe:a0c2:df25 with SMTP
 id w8-20020a056902100800b00dbea0c2df25mr285388ybt.8.1708100408275; Fri, 16
 Feb 2024 08:20:08 -0800 (PST)
Date: Fri, 16 Feb 2024 16:20:06 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240216162006.2342759-1-edumazet@google.com>
Subject: [PATCH net-next] net: reorganize "struct sock" fields
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Neal Cardwell <ncardwell@google.com>, Naman Gulati <namangulati@google.com>, 
	Coco Li <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>, Jon Maloy <jmaloy@redhat.com>, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Last major reorg happened in commit 9115e8cd2a0c ("net: reorganize
struct sock for better data locality")

Since then, many changes have been done.

Before SO_PEEK_OFF support is added to TCP, we need
to move sk_peek_off to a better location.

It is time to make another pass, and add six groups,
without explicit alignment.

- sock_write_rx (following sk_refcnt) read-write fields in rx path.
- sock_read_rx read-mostly fields in rx path.
- sock_read_rxtx read-mostly fields in both rx and tx paths.
- sock_write_rxtx read-write fields in both rx and tx paths.
- sock_write_tx read-write fields in tx paths.
- sock_read_tx read-mostly fields in tx paths.

Results on TCP_RR benchmarks seem to show a gain (4 to 5 %).

It is possible UDP needs a change, because sk_peek_off
shares a cache line with sk_receive_queue.
If this the case, we can exchange roles of sk->sk_receive
and up->reader_queue queues.

After this change, we have the following layout:

struct sock {
	struct sock_common         __sk_common;          /*     0  0x88 */
	/* --- cacheline 2 boundary (128 bytes) was 8 bytes ago --- */
	__u8                       __cacheline_group_begin__sock_write_rx[0]; /*  0x88     0 */
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
	struct {
		atomic_t                   rmem_alloc;           /*     0   0x4 */
		int                        len;                  /*   0x4   0x4 */
		struct sk_buff *           head;                 /*   0x8   0x8 */
		struct sk_buff *           tail;                 /*  0x10   0x8 */

		/* size: 24, cachelines: 1, members: 4 */
		/* last cacheline: 24 bytes */
	};

	__u8                       __cacheline_group_end__sock_write_rx[0]; /*  0xd8     0 */
	__u8                       __cacheline_group_begin__sock_read_rx[0]; /*  0xd8     0 */
	rcu *                      sk_rx_dst;            /*  0xd8   0x8 */
	int                        sk_rx_dst_ifindex;    /*  0xe0   0x4 */
	u32                        sk_rx_dst_cookie;     /*  0xe4   0x4 */
	unsigned int               sk_ll_usec;           /*  0xe8   0x4 */
	unsigned int               sk_napi_id;           /*  0xec   0x4 */
	u16                        sk_busy_poll_budget;  /*  0xf0   0x2 */
	u8                         sk_prefer_busy_poll;  /*  0xf2   0x1 */
	u8                         sk_userlocks;         /*  0xf3   0x1 */
	int                        sk_rcvbuf;            /*  0xf4   0x4 */
	rcu *                      sk_filter;            /*  0xf8   0x8 */
	/* --- cacheline 4 boundary (256 bytes) --- */
	union {
		rcu *              sk_wq;                /* 0x100   0x8 */
		struct socket_wq * sk_wq_raw;            /* 0x100   0x8 */
	};                                               /* 0x100   0x8 */
	union {
		rcu *                      sk_wq;                /*     0   0x8 */
		struct socket_wq *         sk_wq_raw;            /*     0   0x8 */
	};

	void                       (*sk_data_ready)(struct sock *); /* 0x108   0x8 */
	long                       sk_rcvtimeo;          /* 0x110   0x8 */
	int                        sk_rcvlowat;          /* 0x118   0x4 */
	__u8                       __cacheline_group_end__sock_read_rx[0]; /* 0x11c     0 */
	__u8                       __cacheline_group_begin__sock_read_rxtx[0]; /* 0x11c     0 */
	int                        sk_err;               /* 0x11c   0x4 */
	struct socket *            sk_socket;            /* 0x120   0x8 */
	struct mem_cgroup *        sk_memcg;             /* 0x128   0x8 */
	rcu *                      sk_policy[2];         /* 0x130  0x10 */
	/* --- cacheline 5 boundary (320 bytes) --- */
	__u8                       __cacheline_group_end__sock_read_rxtx[0]; /* 0x140     0 */
	__u8                       __cacheline_group_begin__sock_write_rxtx[0]; /* 0x140     0 */
	socket_lock_t              sk_lock;              /* 0x140  0x20 */
	u32                        sk_reserved_mem;      /* 0x160   0x4 */
	int                        sk_forward_alloc;     /* 0x164   0x4 */
	u32                        sk_tsflags;           /* 0x168   0x4 */
	__u8                       __cacheline_group_end__sock_write_rxtx[0]; /* 0x16c     0 */
	__u8                       __cacheline_group_begin__sock_write_tx[0]; /* 0x16c     0 */
	int                        sk_write_pending;     /* 0x16c   0x4 */
	atomic_t                   sk_omem_alloc;        /* 0x170   0x4 */
	int                        sk_sndbuf;            /* 0x174   0x4 */
	int                        sk_wmem_queued;       /* 0x178   0x4 */
	refcount_t                 sk_wmem_alloc;        /* 0x17c   0x4 */
	/* --- cacheline 6 boundary (384 bytes) --- */
	unsigned long              sk_tsq_flags;         /* 0x180   0x8 */
	union {
		struct sk_buff *   sk_send_head;         /* 0x188   0x8 */
		struct rb_root     tcp_rtx_queue;        /* 0x188   0x8 */
	};                                               /* 0x188   0x8 */
	union {
		struct sk_buff *           sk_send_head;         /*     0   0x8 */
		struct rb_root             tcp_rtx_queue;        /*     0   0x8 */
	};

	struct sk_buff_head        sk_write_queue;       /* 0x190  0x18 */
	u32                        sk_dst_pending_confirm; /* 0x1a8   0x4 */
	u32                        sk_pacing_status;     /* 0x1ac   0x4 */
	struct page_frag           sk_frag;              /* 0x1b0  0x10 */
	/* --- cacheline 7 boundary (448 bytes) --- */
	struct timer_list          sk_timer;             /* 0x1c0  0x28 */

	/* XXX last struct has 4 bytes of padding */

	unsigned long              sk_pacing_rate;       /* 0x1e8   0x8 */
	atomic_t                   sk_zckey;             /* 0x1f0   0x4 */
	atomic_t                   sk_tskey;             /* 0x1f4   0x4 */
	__u8                       __cacheline_group_end__sock_write_tx[0]; /* 0x1f8     0 */
	__u8                       __cacheline_group_begin__sock_read_tx[0]; /* 0x1f8     0 */
	unsigned long              sk_max_pacing_rate;   /* 0x1f8   0x8 */
	/* --- cacheline 8 boundary (512 bytes) --- */
	long                       sk_sndtimeo;          /* 0x200   0x8 */
	u32                        sk_priority;          /* 0x208   0x4 */
	u32                        sk_mark;              /* 0x20c   0x4 */
	rcu *                      sk_dst_cache;         /* 0x210   0x8 */
	netdev_features_t          sk_route_caps;        /* 0x218   0x8 */
	u16                        sk_gso_type;          /* 0x220   0x2 */
	u16                        sk_gso_max_segs;      /* 0x222   0x2 */
	unsigned int               sk_gso_max_size;      /* 0x224   0x4 */
	gfp_t                      sk_allocation;        /* 0x228   0x4 */
	u32                        sk_txhash;            /* 0x22c   0x4 */
	u8                         sk_pacing_shift;      /* 0x230   0x1 */
	bool                       sk_use_task_frag;     /* 0x231   0x1 */
	__u8                       __cacheline_group_end__sock_read_tx[0]; /* 0x232     0 */
	u8                         sk_gso_disabled:1;    /* 0x232: 0 0x1 */
	u8                         sk_kern_sock:1;       /* 0x232:0x1 0x1 */
	u8                         sk_no_check_tx:1;     /* 0x232:0x2 0x1 */
	u8                         sk_no_check_rx:1;     /* 0x232:0x3 0x1 */

	/* XXX 4 bits hole, try to pack */

	u8                         sk_shutdown;          /* 0x233   0x1 */
	u16                        sk_type;              /* 0x234   0x2 */
	u16                        sk_protocol;          /* 0x236   0x2 */
	unsigned long              sk_lingertime;        /* 0x238   0x8 */
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
	u8                         sk_txtime_deadline_mode:1; /* 0x286: 0 0x1 */
	u8                         sk_txtime_report_errors:1; /* 0x286:0x1 0x1 */
	u8                         sk_txtime_unused:6;   /* 0x286:0x2 0x1 */

	/* XXX 1 byte hole, try to pack */

	void *                     sk_user_data;         /* 0x288   0x8 */
	void *                     sk_security;          /* 0x290   0x8 */
	struct sock_cgroup_data    sk_cgrp_data;         /* 0x298   0x8 */
	void                       (*sk_state_change)(struct sock *); /* 0x2a0   0x8 */
	void                       (*sk_write_space)(struct sock *); /* 0x2a8   0x8 */
	void                       (*sk_error_report)(struct sock *); /* 0x2b0   0x8 */
	int                        (*sk_backlog_rcv)(struct sock *, struct sk_buff *); /* 0x2b8   0x8 */
	/* --- cacheline 11 boundary (704 bytes) --- */
	void                       (*sk_destruct)(struct sock *); /* 0x2c0   0x8 */
	rcu *                      sk_reuseport_cb;      /* 0x2c8   0x8 */
	rcu *                      sk_bpf_storage;       /* 0x2d0   0x8 */
	struct callback_head       sk_rcu __attribute__((__aligned__(8))); /* 0x2d8  0x10 */
	netns_tracker              ns_tracker;           /* 0x2e8   0x8 */

	/* size: 752, cachelines: 12, members: 105 */
	/* sum members: 749, holes: 1, sum holes: 1 */
	/* sum bitfield members: 12 bits, bit holes: 1, sum bit holes: 4 bits */
	/* paddings: 1, sum paddings: 4 */
	/* forced alignments: 1 */
	/* last cacheline: 48 bytes */
};

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/sock.h | 108 +++++++++++++++++++++++++--------------------
 net/core/sock.c    |  62 ++++++++++++++++++++++++++
 2 files changed, 123 insertions(+), 47 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index a9d99a9c583fc8607601d5d501a82abefbf9bb1e..796a902cf4c19374ff2a44aa7fbce962e20a9e2e 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -378,14 +378,10 @@ struct sock {
 #define sk_flags		__sk_common.skc_flags
 #define sk_rxhash		__sk_common.skc_rxhash
 
-	/* early demux fields */
-	struct dst_entry __rcu	*sk_rx_dst;
-	int			sk_rx_dst_ifindex;
-	u32			sk_rx_dst_cookie;
+	__cacheline_group_begin(sock_write_rx);
 
-	socket_lock_t		sk_lock;
 	atomic_t		sk_drops;
-	int			sk_rcvlowat;
+	__s32			sk_peek_off;
 	struct sk_buff_head	sk_error_queue;
 	struct sk_buff_head	sk_receive_queue;
 	/*
@@ -402,18 +398,24 @@ struct sock {
 		struct sk_buff	*head;
 		struct sk_buff	*tail;
 	} sk_backlog;
-
 #define sk_rmem_alloc sk_backlog.rmem_alloc
 
-	int			sk_forward_alloc;
-	u32			sk_reserved_mem;
+	__cacheline_group_end(sock_write_rx);
+
+	__cacheline_group_begin(sock_read_rx);
+	/* early demux fields */
+	struct dst_entry __rcu	*sk_rx_dst;
+	int			sk_rx_dst_ifindex;
+	u32			sk_rx_dst_cookie;
+
 #ifdef CONFIG_NET_RX_BUSY_POLL
 	unsigned int		sk_ll_usec;
-	/* ===== mostly read cache line ===== */
 	unsigned int		sk_napi_id;
+	u16			sk_busy_poll_budget;
+	u8			sk_prefer_busy_poll;
 #endif
+	u8			sk_userlocks;
 	int			sk_rcvbuf;
-	int			sk_disconnects;
 
 	struct sk_filter __rcu	*sk_filter;
 	union {
@@ -422,15 +424,33 @@ struct sock {
 		struct socket_wq	*sk_wq_raw;
 		/* public: */
 	};
+
+	void			(*sk_data_ready)(struct sock *sk);
+	long			sk_rcvtimeo;
+	int			sk_rcvlowat;
+	__cacheline_group_end(sock_read_rx);
+
+	__cacheline_group_begin(sock_read_rxtx);
+	int			sk_err;
+	struct socket		*sk_socket;
+	struct mem_cgroup	*sk_memcg;
 #ifdef CONFIG_XFRM
 	struct xfrm_policy __rcu *sk_policy[2];
 #endif
+	__cacheline_group_end(sock_read_rxtx);
 
-	struct dst_entry __rcu	*sk_dst_cache;
+	__cacheline_group_begin(sock_write_rxtx);
+	socket_lock_t		sk_lock;
+	u32			sk_reserved_mem;
+	int			sk_forward_alloc;
+	u32			sk_tsflags;
+	__cacheline_group_end(sock_write_rxtx);
+
+	__cacheline_group_begin(sock_write_tx);
+	int			sk_write_pending;
 	atomic_t		sk_omem_alloc;
 	int			sk_sndbuf;
 
-	/* ===== cache line for TX ===== */
 	int			sk_wmem_queued;
 	refcount_t		sk_wmem_alloc;
 	unsigned long		sk_tsq_flags;
@@ -439,22 +459,36 @@ struct sock {
 		struct rb_root	tcp_rtx_queue;
 	};
 	struct sk_buff_head	sk_write_queue;
-	__s32			sk_peek_off;
-	int			sk_write_pending;
-	__u32			sk_dst_pending_confirm;
+	u32			sk_dst_pending_confirm;
 	u32			sk_pacing_status; /* see enum sk_pacing */
-	long			sk_sndtimeo;
+	struct page_frag	sk_frag;
 	struct timer_list	sk_timer;
-	__u32			sk_priority;
-	__u32			sk_mark;
+
 	unsigned long		sk_pacing_rate; /* bytes per second */
+	atomic_t		sk_zckey;
+	atomic_t		sk_tskey;
+	__cacheline_group_end(sock_write_tx);
+
+	__cacheline_group_begin(sock_read_tx);
 	unsigned long		sk_max_pacing_rate;
-	struct page_frag	sk_frag;
+	long			sk_sndtimeo;
+	u32			sk_priority;
+	u32			sk_mark;
+	struct dst_entry __rcu	*sk_dst_cache;
 	netdev_features_t	sk_route_caps;
-	int			sk_gso_type;
+#ifdef CONFIG_SOCK_VALIDATE_XMIT
+	struct sk_buff*		(*sk_validate_xmit_skb)(struct sock *sk,
+							struct net_device *dev,
+							struct sk_buff *skb);
+#endif
+	u16			sk_gso_type;
+	u16			sk_gso_max_segs;
 	unsigned int		sk_gso_max_size;
 	gfp_t			sk_allocation;
-	__u32			sk_txhash;
+	u32			sk_txhash;
+	u8			sk_pacing_shift;
+	bool			sk_use_task_frag;
+	__cacheline_group_end(sock_read_tx);
 
 	/*
 	 * Because of non atomicity rules, all
@@ -463,64 +497,44 @@ struct sock {
 	u8			sk_gso_disabled : 1,
 				sk_kern_sock : 1,
 				sk_no_check_tx : 1,
-				sk_no_check_rx : 1,
-				sk_userlocks : 4;
-	u8			sk_pacing_shift;
+				sk_no_check_rx : 1;
+	u8			sk_shutdown;
 	u16			sk_type;
 	u16			sk_protocol;
-	u16			sk_gso_max_segs;
 	unsigned long	        sk_lingertime;
 	struct proto		*sk_prot_creator;
 	rwlock_t		sk_callback_lock;
-	int			sk_err,
-				sk_err_soft;
+	int			sk_err_soft;
 	u32			sk_ack_backlog;
 	u32			sk_max_ack_backlog;
 	kuid_t			sk_uid;
-	u8			sk_txrehash;
-#ifdef CONFIG_NET_RX_BUSY_POLL
-	u8			sk_prefer_busy_poll;
-	u16			sk_busy_poll_budget;
-#endif
 	spinlock_t		sk_peer_lock;
 	int			sk_bind_phc;
 	struct pid		*sk_peer_pid;
 	const struct cred	*sk_peer_cred;
 
-	long			sk_rcvtimeo;
 	ktime_t			sk_stamp;
 #if BITS_PER_LONG==32
 	seqlock_t		sk_stamp_seq;
 #endif
-	atomic_t		sk_tskey;
-	atomic_t		sk_zckey;
-	u32			sk_tsflags;
-	u8			sk_shutdown;
+	int			sk_disconnects;
 
+	u8			sk_txrehash;
 	u8			sk_clockid;
 	u8			sk_txtime_deadline_mode : 1,
 				sk_txtime_report_errors : 1,
 				sk_txtime_unused : 6;
-	bool			sk_use_task_frag;
 
-	struct socket		*sk_socket;
 	void			*sk_user_data;
 #ifdef CONFIG_SECURITY
 	void			*sk_security;
 #endif
 	struct sock_cgroup_data	sk_cgrp_data;
-	struct mem_cgroup	*sk_memcg;
 	void			(*sk_state_change)(struct sock *sk);
-	void			(*sk_data_ready)(struct sock *sk);
 	void			(*sk_write_space)(struct sock *sk);
 	void			(*sk_error_report)(struct sock *sk);
 	int			(*sk_backlog_rcv)(struct sock *sk,
 						  struct sk_buff *skb);
-#ifdef CONFIG_SOCK_VALIDATE_XMIT
-	struct sk_buff*		(*sk_validate_xmit_skb)(struct sock *sk,
-							struct net_device *dev,
-							struct sk_buff *skb);
-#endif
 	void                    (*sk_destruct)(struct sock *sk);
 	struct sock_reuseport __rcu	*sk_reuseport_cb;
 #ifdef CONFIG_BPF_SYSCALL
diff --git a/net/core/sock.c b/net/core/sock.c
index 88bf810394a5521de83aaa7095543a208aa60573..3fef3407383e568827fc3164e55a04099e10b5a9 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -4234,3 +4234,65 @@ int sk_ioctl(struct sock *sk, unsigned int cmd, void __user *arg)
 	return sock_ioctl_out(sk, cmd, arg);
 }
 EXPORT_SYMBOL(sk_ioctl);
+
+static int __init sock_struct_check(void)
+{
+	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_rx, sk_drops);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_rx, sk_peek_off);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_rx, sk_error_queue);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_rx, sk_receive_queue);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_rx, sk_backlog);
+
+	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_rx, sk_rx_dst);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_rx, sk_rx_dst_ifindex);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_rx, sk_rx_dst_cookie);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_rx, sk_rcvbuf);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_rx, sk_filter);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_rx, sk_wq);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_rx, sk_data_ready);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_rx, sk_rcvtimeo);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_rx, sk_rcvlowat);
+
+	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_rxtx, sk_err);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_rxtx, sk_socket);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_rxtx, sk_memcg);
+
+	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_rxtx, sk_lock);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_rxtx, sk_reserved_mem);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_rxtx, sk_forward_alloc);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_rxtx, sk_tsflags);
+
+	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_tx, sk_omem_alloc);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_tx, sk_omem_alloc);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_tx, sk_sndbuf);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_tx, sk_wmem_queued);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_tx, sk_wmem_alloc);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_tx, sk_tsq_flags);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_tx, sk_send_head);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_tx, sk_write_queue);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_tx, sk_write_pending);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_tx, sk_dst_pending_confirm);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_tx, sk_pacing_status);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_tx, sk_frag);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_tx, sk_timer);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_tx, sk_pacing_rate);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_tx, sk_zckey);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_tx, sk_tskey);
+
+	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_tx, sk_max_pacing_rate);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_tx, sk_sndtimeo);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_tx, sk_priority);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_tx, sk_mark);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_tx, sk_dst_cache);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_tx, sk_route_caps);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_tx, sk_gso_type);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_tx, sk_gso_max_size);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_tx, sk_allocation);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_tx, sk_txhash);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_tx, sk_gso_max_segs);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_tx, sk_pacing_shift);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_tx, sk_use_task_frag);
+	return 0;
+}
+
+core_initcall(sock_struct_check);
-- 
2.44.0.rc0.258.g7320e95886-goog


