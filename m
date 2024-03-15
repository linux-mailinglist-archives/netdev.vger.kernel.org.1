Return-Path: <netdev+bounces-80160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D1A87D441
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 20:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D26071F226AF
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 19:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0E54F201;
	Fri, 15 Mar 2024 19:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="v0/BjO0R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB320446BA;
	Fri, 15 Mar 2024 19:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710529350; cv=none; b=Ezg7SB2ooQ5kWOj7RR4TNaQWgbS1OjY7kDAujnSy1VpyPG+LaOfj4quCsFj5MZGtb7XEqWDGivRx9/3octB6e1XADjBiUYEtbCuAaPz3+lND5O1uP++NzMLDW4O2yHwmbCRJsrhS8NNCRMF15dlHVAht+dcjgiABNZmeNu8tpaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710529350; c=relaxed/simple;
	bh=5PGXBzEHFJGJOXRel/3EDItT2T1GIGiKRVizKB2QB3E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rzOgTt5u4xKHjbjz8v2fOms+U4i6dnpZmwQInKMWnk2T1CM3TpmuHSE1X1xqVB48UGBXQpSzA3cotmZ5UUcoCgG2s/PJILbJSYavGr2mAnq+q3QAvC2QcLHLDEdt0OTEByqgzbgyO1VsnMBg4F9A+2uiPlBVbd7wnMuMUghBYuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=v0/BjO0R; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1710529349; x=1742065349;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5NH7aYqn0rTbqVMcOiaUMGbJ7Mz5FfvgrfzgNm4kwt4=;
  b=v0/BjO0Ru0aEQPjAnShkjV9UZ8IRsRxYGg3EAfI55fyFNJo75V+zZp+1
   8s38wMxqAZdfDNnQCtB+KDK/OtqEaEWBrcCvfSBdFeyOjkyrywbcApS9P
   DIhqpHKjIjS+qys86smgcmvdR+hcr/WKVbezB3ndwzdXXko7PkuPdEgs3
   A=;
X-IronPort-AV: E=Sophos;i="6.07,129,1708387200"; 
   d="scan'208";a="280431523"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 19:02:26 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:36358]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.78:2525] with esmtp (Farcaster)
 id 294719f3-0442-4e50-94a7-6c864bc14dd7; Fri, 15 Mar 2024 19:02:25 +0000 (UTC)
X-Farcaster-Flow-ID: 294719f3-0442-4e50-94a7-6c864bc14dd7
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 15 Mar 2024 19:02:24 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.41) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 15 Mar 2024 19:02:21 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<daniel@iogearbox.net>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<martin.lau@linux.dev>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v8 bpf-next 4/6] bpf: tcp: Handle BPF SYN Cookie in cookie_v[46]_check().
Date: Fri, 15 Mar 2024 12:02:12 -0700
Message-ID: <20240315190212.23517-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CANn89iKdN9c+C_2JAUbc+VY3DDQjAQukMtiBbormAmAk9CdvQA@mail.gmail.com>
References: <CANn89iKdN9c+C_2JAUbc+VY3DDQjAQukMtiBbormAmAk9CdvQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D043UWA004.ant.amazon.com (10.13.139.41) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Fri, 15 Mar 2024 14:37:57 +0100
> On Mon, Jan 15, 2024 at 9:57 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >
> > We will support arbitrary SYN Cookie with BPF in the following
> > patch.
> >
> > If BPF prog validates ACK and kfunc allocates a reqsk, it will
> > be carried to cookie_[46]_check() as skb->sk.  If skb->sk is not
> > NULL, we call cookie_bpf_check().
> >
> > Then, we clear skb->sk and skb->destructor, which are needed not
> > to hold refcnt for reqsk and the listener.  See the following patch
> > for details.
> >
> > After that, we finish initialisation for the remaining fields with
> > cookie_tcp_reqsk_init().
> >
> > Note that the server side WScale is set only for non-BPF SYN Cookie.
> 
> So the difference between BPF and non-BPF is using a req->syncookie
> which had a prior meaning ?

Yes, it was used only in tcp_conn_request(), so I reused the field
and added another meaning for syncookie ACK path.


> 
> This is very confusing, and needs documentation/comments.

Will add comment in request_sock.h and syncookies.c


> 
> 
> >
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> >  include/net/tcp.h     | 20 ++++++++++++++++++++
> >  net/ipv4/syncookies.c | 31 +++++++++++++++++++++++++++----
> >  net/ipv6/syncookies.c | 13 +++++++++----
> >  3 files changed, 56 insertions(+), 8 deletions(-)
> >
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index 114000e71a46..dfe99a084a71 100644
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> > @@ -599,6 +599,26 @@ static inline bool cookie_ecn_ok(const struct net *net, const struct dst_entry *
> >                 dst_feature(dst, RTAX_FEATURE_ECN);
> >  }
> >
> > +#if IS_ENABLED(CONFIG_BPF)
> > +static inline bool cookie_bpf_ok(struct sk_buff *skb)
> > +{
> > +       return skb->sk;
> > +}
> > +
> > +struct request_sock *cookie_bpf_check(struct sock *sk, struct sk_buff *skb);
> > +#else
> > +static inline bool cookie_bpf_ok(struct sk_buff *skb)
> > +{
> > +       return false;
> > +}
> > +
> > +static inline struct request_sock *cookie_bpf_check(struct net *net, struct sock *sk,
> > +                                                   struct sk_buff *skb)
> > +{
> > +       return NULL;
> > +}
> > +#endif
> > +
> >  /* From net/ipv6/syncookies.c */
> >  int __cookie_v6_check(const struct ipv6hdr *iph, const struct tcphdr *th);
> >  struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb);
> > diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> > index 981944c22820..be88bf586ff9 100644
> > --- a/net/ipv4/syncookies.c
> > +++ b/net/ipv4/syncookies.c
> > @@ -295,6 +295,24 @@ static int cookie_tcp_reqsk_init(struct sock *sk, struct sk_buff *skb,
> >         return 0;
> >  }
> >
> > +#if IS_ENABLED(CONFIG_BPF)
> > +struct request_sock *cookie_bpf_check(struct sock *sk, struct sk_buff *skb)
> > +{
> > +       struct request_sock *req = inet_reqsk(skb->sk);
> > +
> > +       skb->sk = NULL;
> > +       skb->destructor = NULL;
> > +
> > +       if (cookie_tcp_reqsk_init(sk, skb, req)) {
> > +               reqsk_free(req);
> > +               req = NULL;
> > +       }
> > +
> > +       return req;
> > +}
> > +EXPORT_SYMBOL_GPL(cookie_bpf_check);
> > +#endif
> > +
> >  struct request_sock *cookie_tcp_reqsk_alloc(const struct request_sock_ops *ops,
> >                                             struct sock *sk, struct sk_buff *skb,
> >                                             struct tcp_options_received *tcp_opt,
> > @@ -395,9 +413,13 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
> >             !th->ack || th->rst)
> >                 goto out;
> >
> > -       req = cookie_tcp_check(net, sk, skb);
> > -       if (IS_ERR(req))
> > -               goto out;
> > +       if (cookie_bpf_ok(skb)) {
> > +               req = cookie_bpf_check(sk, skb);
> > +       } else {
> > +               req = cookie_tcp_check(net, sk, skb);
> > +               if (IS_ERR(req))
> > +                       goto out;
> > +       }
> >         if (!req)
> >                 goto out_drop;
> >
> > @@ -445,7 +467,8 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
> >                                   ireq->wscale_ok, &rcv_wscale,
> >                                   dst_metric(&rt->dst, RTAX_INITRWND));
> >
> > -       ireq->rcv_wscale  = rcv_wscale;
> > +       if (!req->syncookie)
> > +               ireq->rcv_wscale = rcv_wscale;
> >         ireq->ecn_ok &= cookie_ecn_ok(net, &rt->dst);
> >
> >         ret = tcp_get_cookie_sock(sk, skb, req, &rt->dst);
> > diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
> > index c8d2ca27220c..6b9c69278819 100644
> > --- a/net/ipv6/syncookies.c
> > +++ b/net/ipv6/syncookies.c
> > @@ -182,9 +182,13 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
> >             !th->ack || th->rst)
> >                 goto out;
> >
> > -       req = cookie_tcp_check(net, sk, skb);
> > -       if (IS_ERR(req))
> > -               goto out;
> > +       if (cookie_bpf_ok(skb)) {
> > +               req = cookie_bpf_check(sk, skb);
> > +       } else {
> > +               req = cookie_tcp_check(net, sk, skb);
> > +               if (IS_ERR(req))
> > +                       goto out;
> > +       }
> >         if (!req)
> >                 goto out_drop;
> >
> > @@ -247,7 +251,8 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
> >                                   ireq->wscale_ok, &rcv_wscale,
> >                                   dst_metric(dst, RTAX_INITRWND));
> >
> > -       ireq->rcv_wscale = rcv_wscale;
> > +       if (!req->syncookie)
> > +               ireq->rcv_wscale = rcv_wscale;
> 
> I think a comment is deserved. I do not understand this.
> 
> cookie_v6_check() is dealing with syncookie, unless I am mistaken.

Exactly, in both cases, here we handle syncookie, but req->syncookie
can be true only for the BPF case.


> Also syzbot is not happy, req->syncookie might be uninitialized here.

I'll make sure we init the field during allocation.

Thank you!


> 
> BUG: KMSAN: uninit-value in cookie_v4_check+0x22b7/0x29e0
> net/ipv4/syncookies.c:477
> cookie_v4_check+0x22b7/0x29e0 net/ipv4/syncookies.c:477
> tcp_v4_cookie_check net/ipv4/tcp_ipv4.c:1855 [inline]
> tcp_v4_do_rcv+0xb17/0x10b0 net/ipv4/tcp_ipv4.c:1914
> tcp_v4_rcv+0x4ce4/0x5420 net/ipv4/tcp_ipv4.c:2322
> ip_protocol_deliver_rcu+0x2a3/0x13d0 net/ipv4/ip_input.c:205
> ip_local_deliver_finish+0x332/0x500 net/ipv4/ip_input.c:233
> NF_HOOK include/linux/netfilter.h:314 [inline]
> ip_local_deliver+0x21f/0x490 net/ipv4/ip_input.c:254
> dst_input include/net/dst.h:460 [inline]
> ip_rcv_finish+0x4a2/0x520 net/ipv4/ip_input.c:449
> NF_HOOK include/linux/netfilter.h:314 [inline]
> ip_rcv+0xcd/0x380 net/ipv4/ip_input.c:569
> __netif_receive_skb_one_core net/core/dev.c:5538 [inline]
> __netif_receive_skb+0x319/0x9e0 net/core/dev.c:5652
> process_backlog+0x480/0x8b0 net/core/dev.c:5981
> __napi_poll+0xe7/0x980 net/core/dev.c:6632
> napi_poll net/core/dev.c:6701 [inline]
> net_rx_action+0x89d/0x1820 net/core/dev.c:6813
> __do_softirq+0x1c0/0x7d7 kernel/softirq.c:554
> do_softirq+0x9a/0x100 kernel/softirq.c:455
> __local_bh_enable_ip+0x9f/0xb0 kernel/softirq.c:382
> local_bh_enable include/linux/bottom_half.h:33 [inline]
> rcu_read_unlock_bh include/linux/rcupdate.h:820 [inline]
> __dev_queue_xmit+0x2776/0x52c0 net/core/dev.c:4362
> dev_queue_xmit include/linux/netdevice.h:3091 [inline]
> neigh_hh_output include/net/neighbour.h:526 [inline]
> neigh_output include/net/neighbour.h:540 [inline]
> ip_finish_output2+0x187a/0x1b70 net/ipv4/ip_output.c:235
> __ip_finish_output+0x287/0x810
> ip_finish_output+0x4b/0x550 net/ipv4/ip_output.c:323
> NF_HOOK_COND include/linux/netfilter.h:303 [inline]
> ip_output+0x15f/0x3f0 net/ipv4/ip_output.c:433
> dst_output include/net/dst.h:450 [inline]
> ip_local_out net/ipv4/ip_output.c:129 [inline]
> __ip_queue_xmit+0x1e93/0x2030 net/ipv4/ip_output.c:535
> ip_queue_xmit+0x60/0x80 net/ipv4/ip_output.c:549
> __tcp_transmit_skb+0x3c70/0x4890 net/ipv4/tcp_output.c:1462
> tcp_transmit_skb net/ipv4/tcp_output.c:1480 [inline]
> tcp_write_xmit+0x3ee1/0x8900 net/ipv4/tcp_output.c:2792
> __tcp_push_pending_frames net/ipv4/tcp_output.c:2977 [inline]
> tcp_send_fin+0xa90/0x12e0 net/ipv4/tcp_output.c:3578
> tcp_shutdown+0x198/0x1f0 net/ipv4/tcp.c:2716
> inet_shutdown+0x33f/0x5b0 net/ipv4/af_inet.c:923
> __sys_shutdown_sock net/socket.c:2425 [inline]
> __sys_shutdown net/socket.c:2437 [inline]
> __do_sys_shutdown net/socket.c:2445 [inline]
> __se_sys_shutdown+0x2a4/0x440 net/socket.c:2443
> __x64_sys_shutdown+0x6c/0xa0 net/socket.c:2443
> do_syscall_64+0xd5/0x1f0
> entry_SYSCALL_64_after_hwframe+0x6d/0x75
> 
> Uninit was stored to memory at:
> reqsk_alloc include/net/request_sock.h:148 [inline]
> inet_reqsk_alloc+0x651/0x7a0 net/ipv4/tcp_input.c:6978
> cookie_tcp_reqsk_alloc+0xd4/0x900 net/ipv4/syncookies.c:328
> cookie_tcp_check net/ipv4/syncookies.c:388 [inline]
> cookie_v4_check+0x289f/0x29e0 net/ipv4/syncookies.c:420
> tcp_v4_cookie_check net/ipv4/tcp_ipv4.c:1855 [inline]
> tcp_v4_do_rcv+0xb17/0x10b0 net/ipv4/tcp_ipv4.c:1914
> tcp_v4_rcv+0x4ce4/0x5420 net/ipv4/tcp_ipv4.c:2322
> ip_protocol_deliver_rcu+0x2a3/0x13d0 net/ipv4/ip_input.c:205
> ip_local_deliver_finish+0x332/0x500 net/ipv4/ip_input.c:233
> NF_HOOK include/linux/netfilter.h:314 [inline]
> ip_local_deliver+0x21f/0x490 net/ipv4/ip_input.c:254
> dst_input include/net/dst.h:460 [inline]
> ip_rcv_finish+0x4a2/0x520 net/ipv4/ip_input.c:449
> NF_HOOK include/linux/netfilter.h:314 [inline]
> ip_rcv+0xcd/0x380 net/ipv4/ip_input.c:569
> __netif_receive_skb_one_core net/core/dev.c:5538 [inline]
> __netif_receive_skb+0x319/0x9e0 net/core/dev.c:5652
> process_backlog+0x480/0x8b0 net/core/dev.c:5981
> __napi_poll+0xe7/0x980 net/core/dev.c:6632
> napi_poll net/core/dev.c:6701 [inline]
> net_rx_action+0x89d/0x1820 net/core/dev.c:6813
> __do_softirq+0x1c0/0x7d7 kernel/softirq.c:554
> 
> Uninit was created at:
> __alloc_pages+0x9a7/0xe00 mm/page_alloc.c:4592
> __alloc_pages_node include/linux/gfp.h:238 [inline]
> alloc_pages_node include/linux/gfp.h:261 [inline]
> alloc_slab_page mm/slub.c:2175 [inline]
> allocate_slab mm/slub.c:2338 [inline]
> new_slab+0x2de/0x1400 mm/slub.c:2391
> ___slab_alloc+0x1184/0x33d0 mm/slub.c:3525
> __slab_alloc mm/slub.c:3610 [inline]
> __slab_alloc_node mm/slub.c:3663 [inline]
> slab_alloc_node mm/slub.c:3835 [inline]
> kmem_cache_alloc+0x6d3/0xbe0 mm/slub.c:3852
> reqsk_alloc include/net/request_sock.h:131 [inline]
> inet_reqsk_alloc+0x66/0x7a0 net/ipv4/tcp_input.c:6978
> tcp_conn_request+0x484/0x44e0 net/ipv4/tcp_input.c:7135
> tcp_v4_conn_request+0x16f/0x1d0 net/ipv4/tcp_ipv4.c:1716
> tcp_rcv_state_process+0x2e5/0x4bb0 net/ipv4/tcp_input.c:6655
> tcp_v4_do_rcv+0xbfd/0x10b0 net/ipv4/tcp_ipv4.c:1929
> tcp_v4_rcv+0x4ce4/0x5420 net/ipv4/tcp_ipv4.c:2322
> ip_protocol_deliver_rcu+0x2a3/0x13d0 net/ipv4/ip_input.c:205
> ip_local_deliver_finish+0x332/0x500 net/ipv4/ip_input.c:233
> NF_HOOK include/linux/netfilter.h:314 [inline]
> ip_local_deliver+0x21f/0x490 net/ipv4/ip_input.c:254
> dst_input include/net/dst.h:460 [inline]
> ip_sublist_rcv_finish net/ipv4/ip_input.c:580 [inline]
> ip_list_rcv_finish net/ipv4/ip_input.c:631 [inline]
> ip_sublist_rcv+0x15f3/0x17f0 net/ipv4/ip_input.c:639
> ip_list_rcv+0x9ef/0xa40 net/ipv4/ip_input.c:674
> __netif_receive_skb_list_ptype net/core/dev.c:5581 [inline]
> __netif_receive_skb_list_core+0x15c5/0x1670 net/core/dev.c:5629
> __netif_receive_skb_list net/core/dev.c:5681 [inline]
> netif_receive_skb_list_internal+0x106c/0x16f0 net/core/dev.c:5773
> gro_normal_list include/net/gro.h:438 [inline]
> napi_complete_done+0x425/0x880 net/core/dev.c:6113
> virtqueue_napi_complete drivers/net/virtio_net.c:465 [inline]
> virtnet_poll+0x149d/0x2240 drivers/net/virtio_net.c:2211
> __napi_poll+0xe7/0x980 net/core/dev.c:6632
> napi_poll net/core/dev.c:6701 [inline]
> net_rx_action+0x89d/0x1820 net/core/dev.c:6813
> __do_softirq+0x1c0/0x7d7 kernel/softirq.c:554
> 
> CPU: 0 PID: 16792 Comm: syz-executor.2 Not tainted
> 6.8.0-syzkaller-05562-g61387b8dcf1d #0
> Hardware name: Google Google Compute Engine/Google Compute Engine,
> BIOS Google 02/29/2024

