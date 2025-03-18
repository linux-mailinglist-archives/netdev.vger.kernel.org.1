Return-Path: <netdev+bounces-175858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A8CA67C64
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 19:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B2DC19C61E7
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 18:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A241DDC34;
	Tue, 18 Mar 2025 18:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hEovC21U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA8C20F065
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 18:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742324148; cv=none; b=taJoIpPqAG0KfpHIxqF6WG4b6qLnJivVdzrMKwDinYxBderFNpSKFYoPOVPsyBS+Kw5wDx5G2c+MH43dqq9LCOWZjRTigAfQXyCD8aIuhvZigyk3SYOrYNpmXATW5gNg8PxlnyXMj7oEJJaEXWpAZmXcW3thmfkb1gify3tWMc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742324148; c=relaxed/simple;
	bh=En81vOHQ1vzJG8Q8xJibgImdzJiNjpB1ktpx76Isi/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kibmbJjhZdUF64T+CGuFIgWXn+7fz7bEm3jq1b3T/wI89FmnAsZMalcUBaae9BN1OnyGR580GqVKW5/ayCJs+N/Xm1HG8b52HS8vDcj8dL9ceHq8kvC6+TORkWOL4btWELZPnmvC97exwLwf1DzXKWXEQKedE/oegWkBwFRYOS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hEovC21U; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-47688ae873fso57927621cf.0
        for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 11:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742324144; x=1742928944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EkrBqvi+RNrDi2kSUG0zHgHqlHKLe+pZlicvrK34/RU=;
        b=hEovC21UiPZzvtvdDH498nOVfF0TGPqBM02NjCL1RYHoH8XbKH5u/894c2jjXb90nn
         3G+3aolLf8jxNzxfqrl9O2wKxloul1bJlCXIGV0OZjr300xLt0HR9kx4S0QhGOLMAMKI
         4Pbuen8p+hqi18kfL6QRJ/MuZr6u4qP+kxuDrcnWDpxpyuFQZmj7H8AdhLSfj/0xTmDa
         1sw4dq8JLrRUaH+t8hTVIDbbhwNG0pKNyAi6CuUjX6BdC0cJ8G8T0JgwOKMYm63P4fXd
         v5onzGQ2ssqJMMSCDVtLF9/qm14IH+CeMRckqmMB9LvAkBrh6CQyQ5j8KypQow3O3WI+
         t2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742324144; x=1742928944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EkrBqvi+RNrDi2kSUG0zHgHqlHKLe+pZlicvrK34/RU=;
        b=mmSpwfBUAWb4H/zK38JIUeiJ9rdRdi+OEA9tcJRc7cQIbOJtOw05nIuTPiZPUnB3Id
         lFObxl9ooPiSm3gdglRaGbGq7VH9n+MhdvSmXxW5fscpHYsFL4AsXmCLa1KIIA6tkKQ5
         kK7uOUogDCWZk0Eg8cVSN1DzN0xCUVTpDoVrWzkd4rG5Bs0w+i2SQBvb3Wjvs/8EwJmu
         L+TFP9wbFr3cyG9/gpqJ9RbkxCGWApzw0rJ7la/dzGKfPfmMeYdFMp26V/PU1HFjE6dE
         aUvVvES2e3va6HhZTRkV1e3AjmMuW/XHgrNGncH6Q8rLEsNhSbuCXdpcSHmjzKHZpf3/
         86yg==
X-Gm-Message-State: AOJu0YzjRxAQOVbpfsBifO/eIpPAzUv2bZYWAs163RwnPDT4k0QFXUv/
	plgLiGZULc2rwjiyXuB9xRoEmqy1O99AMaO/fV3G44fcIke/wMCG5wPqQz7cdGrEiqNfK57O0Yu
	hNdtINQZUdahpRiSi7VaTyYL3bg0/RqSzeZ+C
X-Gm-Gg: ASbGncuhGgo3V9jStrKWSycgKmzrpkyLCfuNVxsyKrtCJEYEoizvxLo2Q+pITrQzoA7
	AfJY6IXHGp3aQzeOVXoRaHXXYV9PruAE6IH/2VcbZT0IMiZYJFX2rcqQxi0uPwDsAbtNzm990Eg
	zNYs2SZgZmUEL8Br80FUM99jaOwiY=
X-Google-Smtp-Source: AGHT+IGTJGnBwQOqHBmfaSlBfAhuK+W5PXqIt3Wv4Prb+4i2npnSeb2H6ykpM/9aLswtvvoELvA0cAnN20NrMf1yOfE=
X-Received: by 2002:a05:622a:1c17:b0:476:fd83:eedd with SMTP id
 d75a77b69052e-477082f5cc0mr916841cf.21.1742324144147; Tue, 18 Mar 2025
 11:55:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2a1893e924bd34f4f5b6124b568d1cdfc15573d5.1742320185.git.pabeni@redhat.com>
In-Reply-To: <2a1893e924bd34f4f5b6124b568d1cdfc15573d5.1742320185.git.pabeni@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 18 Mar 2025 19:55:33 +0100
X-Gm-Features: AQ5f1JpRCuGGJEalUJqq1outC9oQo0iNgx_aRz7JE_ioRbKRd1cvq65ZteG2lAk
Message-ID: <CANn89iLst-RHUmidAqHxxQAPrH8bJYT+WiFxPU0THJyWWH0ngQ@mail.gmail.com>
Subject: Re: [PATCH v2] net: introduce per netns packet chains
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Sabrina Dubroca <sd@queasysnail.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 7:03=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> Currently network taps unbound to any interface are linked in the
> global ptype_all list, affecting the performance in all the network
> namespaces.
>
> Add per netns ptypes chains, so that in the mentioned case only
> the netns owning the packet socket(s) is affected.
>
> While at that drop the global ptype_all list: no in kernel user
> registers a tap on "any" type without specifying either the target
> device or the target namespace (and IMHO doing that would not make
> any sense).
>
> Note that this adds a conditional in the fast path (to check for
> per netns ptype_specific list) and increases the dataset size by
> a cacheline (owing the per netns lists).
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v1  -> v2:
>  - fix comment typo
>  - drop the doubtful RCU optimization
>
> rfc -> v1
>  - fix procfs dump
>  - fix dev->ptype_specific -> dev->ptype_all type in ptype_head()
>  - dev_net() -> dev_net_rcu
>  - add dev_nit_active_rcu  variant
>  - ptype specific netns deliver uses dev_net_rcu(skb->dev)) instead
>    of dev_net(orig_dev)
> ---
>  include/linux/netdevice.h   | 12 ++++++++-
>  include/net/hotdata.h       |  1 -
>  include/net/net_namespace.h |  3 +++
>  net/core/dev.c              | 52 +++++++++++++++++++++++++++----------
>  net/core/hotdata.c          |  1 -
>  net/core/net-procfs.c       | 28 +++++++++++++++-----
>  net/core/net_namespace.c    |  2 ++
>  7 files changed, 76 insertions(+), 23 deletions(-)
>
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 67527243459b3..c51a99f24800d 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -4276,7 +4276,17 @@ static __always_inline int ____dev_forward_skb(str=
uct net_device *dev,
>         return 0;
>  }
>
> -bool dev_nit_active(struct net_device *dev);
> +bool dev_nit_active_rcu(struct net_device *dev);
> +static inline bool dev_nit_active(struct net_device *dev)
> +{
> +       bool ret;
> +
> +       rcu_read_lock();
> +       ret =3D dev_nit_active_rcu(dev);
> +       rcu_read_unlock();
> +       return ret;
> +}
> +
>  void dev_queue_xmit_nit(struct sk_buff *skb, struct net_device *dev);
>
>  static inline void __dev_put(struct net_device *dev)
> diff --git a/include/net/hotdata.h b/include/net/hotdata.h
> index 30e9570beb2af..fda94b2647ffa 100644
> --- a/include/net/hotdata.h
> +++ b/include/net/hotdata.h
> @@ -23,7 +23,6 @@ struct net_hotdata {
>         struct net_offload      udpv6_offload;
>  #endif
>         struct list_head        offload_base;
> -       struct list_head        ptype_all;
>         struct kmem_cache       *skbuff_cache;
>         struct kmem_cache       *skbuff_fclone_cache;
>         struct kmem_cache       *skb_small_head_cache;
> diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
> index f467a66abc6b1..bd57d8fb54f14 100644
> --- a/include/net/net_namespace.h
> +++ b/include/net/net_namespace.h
> @@ -83,6 +83,9 @@ struct net {
>         struct llist_node       defer_free_list;
>         struct llist_node       cleanup_list;   /* namespaces on death ro=
w */
>
> +       struct list_head ptype_all;
> +       struct list_head ptype_specific;
> +
>  #ifdef CONFIG_KEYS
>         struct key_tag          *key_domain;    /* Key domain of operatio=
n tag */
>  #endif
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 6fa6ed5b57987..99ce4a3526e54 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -572,11 +572,19 @@ static inline void netdev_set_addr_lockdep_class(st=
ruct net_device *dev)
>
>  static inline struct list_head *ptype_head(const struct packet_type *pt)
>  {
> -       if (pt->type =3D=3D htons(ETH_P_ALL))
> -               return pt->dev ? &pt->dev->ptype_all : &net_hotdata.ptype=
_all;
> -       else
> -               return pt->dev ? &pt->dev->ptype_specific :
> -                                &ptype_base[ntohs(pt->type) & PTYPE_HASH=
_MASK];
> +       if (pt->type =3D=3D htons(ETH_P_ALL)) {
> +               if (!pt->af_packet_net && !pt->dev)
> +                       return NULL;
> +
> +               return pt->dev ? &pt->dev->ptype_all :
> +                                &pt->af_packet_net->ptype_all;
> +       }
> +
> +       if (pt->dev)
> +               return &pt->dev->ptype_specific;
> +
> +       return pt->af_packet_net ? &pt->af_packet_net->ptype_specific :
> +                                  &ptype_base[ntohs(pt->type) & PTYPE_HA=
SH_MASK];
>  }
>
>  /**
> @@ -596,6 +604,9 @@ void dev_add_pack(struct packet_type *pt)
>  {
>         struct list_head *head =3D ptype_head(pt);
>
> +       if (WARN_ON_ONCE(!head))
> +               return;
> +
>         spin_lock(&ptype_lock);
>         list_add_rcu(&pt->list, head);
>         spin_unlock(&ptype_lock);
> @@ -620,6 +631,9 @@ void __dev_remove_pack(struct packet_type *pt)
>         struct list_head *head =3D ptype_head(pt);
>         struct packet_type *pt1;
>
> +       if (!head)
> +               return;
> +
>         spin_lock(&ptype_lock);
>
>         list_for_each_entry(pt1, head, list) {
> @@ -2463,16 +2477,18 @@ static inline bool skb_loop_sk(struct packet_type=
 *ptype, struct sk_buff *skb)
>  }
>
>  /**
> - * dev_nit_active - return true if any network interface taps are in use
> + * dev_nit_active_rcu - return true if any network interface taps are in=
 use
> + *
> + * The caller must hold the RCU lock
>   *
>   * @dev: network device to check for the presence of taps
>   */
> -bool dev_nit_active(struct net_device *dev)
> +bool dev_nit_active_rcu(struct net_device *dev)
>  {
> -       return !list_empty(&net_hotdata.ptype_all) ||
> +       return !list_empty(&dev_net_rcu(dev)->ptype_all) ||
>                !list_empty(&dev->ptype_all);
>  }
> -EXPORT_SYMBOL_GPL(dev_nit_active);
> +EXPORT_SYMBOL_GPL(dev_nit_active_rcu);
>
>  /*
>   *     Support routine. Sends outgoing frames to any network
> @@ -2481,11 +2497,12 @@ EXPORT_SYMBOL_GPL(dev_nit_active);
>
>  void dev_queue_xmit_nit(struct sk_buff *skb, struct net_device *dev)
>  {
> -       struct list_head *ptype_list =3D &net_hotdata.ptype_all;
>         struct packet_type *ptype, *pt_prev =3D NULL;
> +       struct list_head *ptype_list;
>         struct sk_buff *skb2 =3D NULL;
>
>         rcu_read_lock();
> +       ptype_list =3D &dev_net_rcu(dev)->ptype_all;
>  again:
>         list_for_each_entry_rcu(ptype, ptype_list, list) {
>                 if (READ_ONCE(ptype->ignore_outgoing))
> @@ -2529,7 +2546,7 @@ void dev_queue_xmit_nit(struct sk_buff *skb, struct=
 net_device *dev)
>                 pt_prev =3D ptype;
>         }
>
> -       if (ptype_list =3D=3D &net_hotdata.ptype_all) {
> +       if (ptype_list =3D=3D &dev_net_rcu(dev)->ptype_all) {

Using the following should be faster, generated code will be shorter.

        if (ptype_list !=3D &dev->ptype_all)

>                 ptype_list =3D &dev->ptype_all;
>                 goto again;
>         }
> @@ -3774,7 +3791,7 @@ static int xmit_one(struct sk_buff *skb, struct net=
_device *dev,
>         unsigned int len;
>         int rc;
>
> -       if (dev_nit_active(dev))
> +       if (dev_nit_active_rcu(dev))
>                 dev_queue_xmit_nit(skb, dev);
>
>         len =3D skb->len;
> @@ -5718,7 +5735,8 @@ static int __netif_receive_skb_core(struct sk_buff =
**pskb, bool pfmemalloc,
>         if (pfmemalloc)
>                 goto skip_taps;
>
> -       list_for_each_entry_rcu(ptype, &net_hotdata.ptype_all, list) {
> +       list_for_each_entry_rcu(ptype, &dev_net_rcu(skb->dev)->ptype_all,
> +                               list) {
>                 if (pt_prev)
>                         ret =3D deliver_skb(skb, pt_prev, orig_dev);
>                 pt_prev =3D ptype;
> @@ -5830,6 +5848,14 @@ static int __netif_receive_skb_core(struct sk_buff=
 **pskb, bool pfmemalloc,
>                 deliver_ptype_list_skb(skb, &pt_prev, orig_dev, type,
>                                        &ptype_base[ntohs(type) &
>                                                    PTYPE_HASH_MASK]);
> +
> +               /* The only per net ptype user - packet socket - matches
> +                * the target netns vs dev_net(skb->dev); we need to
> +                * process only such netns even when orig_dev lays in a
> +                * different one.
> +                */
> +               deliver_ptype_list_skb(skb, &pt_prev, orig_dev, type,
> +                                      &dev_net_rcu(skb->dev)->ptype_spec=
ific);

I am banging my head here.  I probably need some sleep :)

