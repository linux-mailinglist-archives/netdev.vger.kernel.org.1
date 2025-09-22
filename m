Return-Path: <netdev+bounces-225181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2020B8FC5A
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 11:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8AA77ACFDE
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 09:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0E5279794;
	Mon, 22 Sep 2025 09:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KtMPDBIG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F9B179A3
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 09:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758533696; cv=none; b=gz+g61G4w6hn+g/Fz/nCUFng8/rqWnyY1jX1OHp/rVIzPO5KTdVRwn4KGjs0uUzKQs/mOA6Z0zf0MXvkfa3/qMdfoSPSn6qoB6vt52Dwpz4hX6KxclSA8KS6dzPv/Tuv3rsjhHN0jVs1tk2wMUH5W+AdSueZni5VoMWxpfvAmL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758533696; c=relaxed/simple;
	bh=NL7pJVVFJdCc2hAJ4lVyDK5uFmhduHbXpmumEp+0qaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d9bE0h3aMWrC2j+FUdpsHfomo+OTA5PZkoosB2LmKQyB5duQGOD4Bsy94q8bCJn/Fx6hZW3koCk0j8XgsHFdfU9EmH1xyN/0JRMEE/S48r6xLnSDI4ppGRabMWwmB/nYmxPGcL4C1umbHaLHP3fOZojU+2ZNzwg7Cy3Pp7jlU80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KtMPDBIG; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b548745253so71239891cf.0
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 02:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758533694; x=1759138494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKMs/Q9ACt2IexQr1IDyp0hdv5MyfFAILRIq/XKi3CQ=;
        b=KtMPDBIGFKkmxHZf30UCOJ2EJOp5P/h4wxbv/Ak/MM2Z2Gpbf89V8Liimcut6cvmHV
         S23ETin3iwv4jDP1u7ZYZaRhuO40z3dZHBsQAxX+pST2dLnlsMlmrE9bV17fwl40cW8F
         Ba72ODWFhg5SnUAVeky+EdpSXmDeUdgzijKlUA3WxX+MkE/eBIuhOcKyVzcRYuJzBD8p
         KWIwbZtyBm0SHRdCpE/xqfAD8w5iLNtYsM7ndtn4x07eD/bWRvNHquSXyf5IA03F8ReK
         Qn7nT1ImtrFBAFxe1sAnvrlnKZKeVjlYZlSs5P5/CW+Hy9C+CiIf4VOQO9/PKAsVoYXa
         iKMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758533694; x=1759138494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MKMs/Q9ACt2IexQr1IDyp0hdv5MyfFAILRIq/XKi3CQ=;
        b=MF2AfH7dQeHJii/BrHm0kk9CrKfrhvv1hpCtmCxWry/E2Ez4jO5zDM+IQ5wORpLwGY
         88/a7LB6/c3lC2FxpUM9aQLVsI1QNXxQtAz3OiMWNIgtSCj4MK4M+uTgtH5bJkbqGOqe
         f4plbaas7/WoZ+6alKJf6cHeddpssE+pvAogMem1WCoV8uKDTatJTdaIxY3vHyjGxIpu
         LTgtBggm6Eb9UQDU0qo0lh3jkud8nVNtscEZSIdC47kdgpoKf9oAIguFi2wHY7lLCR25
         b5yQFijxD7BnYgQ0ahj16xvN6+KZ1xhodAlUWRcffcUbRLBxfTpgADkhj6g3LBNslmM5
         ZIIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnsxWKJSKhwv6uO6emsEVOCpnpnwf0pcJrnwJWDnDISgEN0WkMfSJ7eWvXLjv5hz6xSlLEMD0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8fcqZ7YPyJQQiEDwjEu/mxP0EXEp7quPU/9q8810mINGE5EQR
	ho4bvKGwRfNNmb9p6WEcp3DvQMY6JTOr+xDtnBU9+EKUZMV//G4eEIXcq+afjChY3fDoLT5f+ZR
	cGpB/dvhDHuvSo7rx/+z9UcsXewBha717xhLRIMEw
X-Gm-Gg: ASbGncuUk3K9Qtv+4prufo7zg0BnyFGm2BNsCytjsxgCdMIaOfGzUpJcD+42dByv+fB
	Yz/vNMqKS2dFiMUBrBh3WxwgB9N8m1psvAXE8L4nRJf14BbrFMddjhsU/2or33XpURDbRQYTWUQ
	77X4Ugp434FkHB34Vyb0o5pw1Hwz4rORkVfFdkm32F/SH4x4F1ycBvM2WY+mQETOKPMgho81EOZ
	eAqcqg=
X-Google-Smtp-Source: AGHT+IEnZHwJ3plWMx8U3QPpy0Z8w5CH/MpPdrVFHKQUdGzQo4bfS22sN++LnG6K+6iO8WnIIvLXc4xbVXhMNUrwyWk=
X-Received: by 2002:a05:622a:5589:b0:4cb:57b4:4d6e with SMTP id
 d75a77b69052e-4cb57b45322mr37847461cf.56.1758533693366; Mon, 22 Sep 2025
 02:34:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250921095802.875191-1-edumazet@google.com> <3fbe9533-72e9-4667-9cf4-57dd2acf375c@redhat.com>
 <CANn89i+RbuL9oknRn8uACRF-MMam=LvO6pVoR7BOUk=f5S6iVA@mail.gmail.com>
In-Reply-To: <CANn89i+RbuL9oknRn8uACRF-MMam=LvO6pVoR7BOUk=f5S6iVA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 22 Sep 2025 02:34:41 -0700
X-Gm-Features: AS18NWBPopiA0xYTnxOCMe65KEKSaHsOvHtyS6xjgAH2vF8m_kdTRXA6rVvF7YE
Message-ID: <CANn89iKcye6Zsij4=jQ2V9ofbCwRB45HPJUdn7YbFQU1TmQVbw@mail.gmail.com>
Subject: Re: [PATCH v3 net-next] udp: remove busylock and add per NUMA queues
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 1:47=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, Sep 22, 2025 at 1:37=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> w=
rote:
> >
> > Hi,
> >
> > On 9/21/25 11:58 AM, Eric Dumazet wrote:
> > > @@ -1718,14 +1699,23 @@ static int udp_rmem_schedule(struct sock *sk,=
 int size)
> > >  int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
> > >  {
> > >       struct sk_buff_head *list =3D &sk->sk_receive_queue;
> > > +     struct udp_prod_queue *udp_prod_queue;
> > > +     struct sk_buff *next, *to_drop =3D NULL;
> > > +     struct llist_node *ll_list;
> > >       unsigned int rmem, rcvbuf;
> > > -     spinlock_t *busy =3D NULL;
> > >       int size, err =3D -ENOMEM;
> > > +     int total_size =3D 0;
> > > +     int q_size =3D 0;
> > > +     int nb =3D 0;
> > >
> > >       rmem =3D atomic_read(&sk->sk_rmem_alloc);
> > >       rcvbuf =3D READ_ONCE(sk->sk_rcvbuf);
> > >       size =3D skb->truesize;
> > >
> > > +     udp_prod_queue =3D &udp_sk(sk)->udp_prod_queue[numa_node_id()];
> > > +
> > > +     rmem +=3D atomic_read(&udp_prod_queue->rmem_alloc);
> > > +
> > >       /* Immediately drop when the receive queue is full.
> > >        * Cast to unsigned int performs the boundary check for INT_MAX=
.
> > >        */
> >
> > Double checking I'm reading the code correctly... AFAICS the rcvbuf siz=
e
> > check is now only per NUMA node, that means that each node can now add
> > at most sk_rcvbuf bytes to the socket receive queue simultaneously, am =
I
> > correct?
>
> This is a transient condition. In my tests with 6 NUMA nodes pushing
> packets very hard,
> I was not able to see a  significant bump of sk_rmem_alloc (over sk_rcvbu=
f)
>
>
>
> >
> > What if the user-space process never reads the packets (or is very
> > slow)? I'm under the impression the max rcvbuf occupation will be
> > limited only by the memory accounting?!? (and not by sk_rcvbuf)
>
> Well, as soon as sk->sk_rmem_alloc is bigger than sk_rcvbuf, all
> further incoming packets are dropped.
>
> As you said, memory accounting is there.
>
> This could matter if we had thousands of UDP sockets under flood at
> the same time,
> but that would require thousands of cpus and/or NIC rx queues.
>
>
>
> >
> > Side note: I'm wondering if we could avoid the numa queue for connected
> > sockets? With early demux, and no nft/bridge in between the path from
> > NIC to socket should be pretty fast and possibly the additional queuing
> > visible?
>
> I tried this last week and got no difference in performance on my test ma=
chines.
>
> I can retry this and give you precise numbers before sending V4.

I did my experiment again.

Very little difference (1 or 2 %, but would need many runs to have a
confirmation)

Also loopback traffic would be unprotected (Only RSS on a physical NIC
would properly use a single cpu for all packets)

Looking at the performance profile of the cpus

Always using the per-numa queue

    16.06%  [kernel]                                 [k] skb_release_data
    10.59%  [kernel]                                 [k] dev_gro_receive
     9.50%  [kernel]                                 [k]
idpf_rx_process_skb_fields
     5.37%  [kernel]                                 [k]
__udp_enqueue_schedule_skb
     3.93%  [kernel]                                 [k] net_rx_action
     2.93%  [kernel]                                 [k] ip6t_do_table
     2.84%  [kernel]                                 [k] napi_alloc_skb
     2.41%  [kernel]                                 [k]
queued_spin_lock_slowpath
     2.01%  [kernel]                                 [k]
__netif_receive_skb_core
     1.95%  [kernel]                                 [k]
idpf_vport_splitq_napi_poll
     1.90%  [kernel]                                 [k] __memcpy
     1.88%  [kernel]                                 [k] napi_gro_receive
     1.86%  [kernel]                                 [k]
kmem_cache_alloc_bulk_noprof
     1.50%  [kernel]                                 [k] napi_consume_skb
     1.28%  [kernel]                                 [k] sock_def_readable
     1.00%  [kernel]                                 [k] llist_add_batch
     0.93%  [kernel]                                 [k] ip6_rcv_core
     0.91%  [kernel]                                 [k]
call_function_single_prep_ipi
     0.82%  [kernel]                                 [k] ipv6_gro_receive
     0.81%  [kernel]                                 [k]
ip6_protocol_deliver_rcu
     0.81%  [kernel]                                 [k] fib6_node_lookup
     0.79%  [kernel]                                 [k] ip6_route_input
     0.78%  [kernel]                                 [k] eth_type_trans
     0.75%  [kernel]                                 [k] ip6_sublist_rcv
     0.75%  [kernel]                                 [k] __try_to_wake_up
     0.73%  [kernel]                                 [k] udp6_csum_init
     0.70%  [kernel]                                 [k] _raw_spin_lock
     0.70%  [kernel]                                 [k] __wake_up_common_l=
ock
     0.69%  [kernel]                                 [k] read_tsc
     0.62%  [kernel]                                 [k] ttwu_queue_wakelis=
t
     0.58%  [kernel]                                 [k] udp6_gro_receive
     0.57%  [kernel]                                 [k]
netif_receive_skb_list_internal
     0.55%  [kernel]                                 [k] llist_reverse_orde=
r
     0.53%  [kernel]                                 [k] available_idle_cpu
     0.52%  [kernel]                                 [k] sched_clock_noinst=
r
     0.51%  [kernel]                                 [k]
__sk_mem_raise_allocated


Avoiding it for connected sockets:

    14.75%  [kernel]                                 [k] skb_release_data
    10.76%  [kernel]                                 [k] dev_gro_receive
     9.48%  [kernel]                                 [k]
idpf_rx_process_skb_fields
     4.29%  [kernel]                                 [k]
__udp_enqueue_schedule_skb
     4.02%  [kernel]                                 [k] net_rx_action
     3.17%  [kernel]                                 [k] ip6t_do_table
     2.55%  [kernel]                                 [k] napi_alloc_skb
     2.20%  [kernel]                                 [k] __memcpy
     2.04%  [kernel]                                 [k]
queued_spin_lock_slowpath
     1.99%  [kernel]                                 [k]
__netif_receive_skb_core
     1.98%  [kernel]                                 [k]
kmem_cache_alloc_bulk_noprof
     1.76%  [kernel]                                 [k] napi_gro_receive
     1.74%  [kernel]                                 [k]
idpf_vport_splitq_napi_poll
     1.55%  [kernel]                                 [k] napi_consume_skb
     1.36%  [kernel]                                 [k] sock_def_readable
     1.18%  [kernel]                                 [k] llist_add_batch
     1.04%  [kernel]                                 [k] udp6_csum_init
     0.92%  [kernel]                                 [k] fib6_node_lookup
     0.92%  [kernel]                                 [k] _raw_spin_lock
     0.91%  [kernel]                                 [k]
call_function_single_prep_ipi
     0.88%  [kernel]                                 [k] ip6_rcv_core
     0.86%  [kernel]                                 [k]
ip6_protocol_deliver_rcu
     0.84%  [kernel]                                 [k] __try_to_wake_up
     0.81%  [kernel]                                 [k] ip6_route_input
     0.80%  [kernel]                                 [k] ipv6_gro_receive
     0.75%  [kernel]                                 [k] __skb_flow_dissect
     0.70%  [kernel]                                 [k] read_tsc
     0.70%  [kernel]                                 [k] ttwu_queue_wakelis=
t
     0.69%  [kernel]                                 [k] eth_type_trans
     0.69%  [kernel]                                 [k] __wake_up_common_l=
ock
     0.64%  [kernel]                                 [k] sched_clock_noinst=
r

I guess we have bigger fish to fry ;)

