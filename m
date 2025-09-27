Return-Path: <netdev+bounces-226828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B49BA5788
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 03:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5C5516D0D6
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 01:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7881F1E51F6;
	Sat, 27 Sep 2025 01:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTN08AtJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2021494D9
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 01:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758935408; cv=none; b=rjF96ZzB9gFagfhmQb8wdb8C4TBEOm7qpn+Xf+e5XkuXqEl/0M3N1CP5Isgobqpv8ILyVMkDQSECyM/T3oOWwSotvRN1abASzN3Ztkopjd8ZSf+M69qQCqLTg5lcBlwug5bOt/Dltjx2CeLPuKPTZXt2KoAf7x2wIsYbcL/SYhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758935408; c=relaxed/simple;
	bh=HIqMhAWYoRaiCHMhP1iWZqTzEu1dE4oj+BfRNptDUgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rWi8mcuhUHXiUDPbnhFbsoM9yS9Fb8naavd1OxVrEZdEo8r6ABwq6SNGstvLAJP7dnqkSgJdohzVyl8Qhq02RC7jHZPYvzxxg54va+GxV6SRHOdX+96/aA4VAxxx0qdEpFIMFWBDExWXVYgqtVu6Ym9NePSd9by5N9m0rmDB0KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DTN08AtJ; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-8d593793af1so111619939f.0
        for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 18:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758935406; x=1759540206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4cE/wiw38W515KvbSUHuF05rWrOnxxJMb0/M9FJ+mqw=;
        b=DTN08AtJwsxEkDFvoWUbepIOE33YJ01uNjTM7GeJSQz65JFpYxFKlhiW5rLs1u8TEC
         xoJEAgEBEL7uTB1XOzvGuvkL/4wsk0BXfmvHcntSTr5lEjQxHGVQSGE+XEaQOPskD/i9
         okx2bg8Iu1clTZzC0cURXsjOZ7zFJh5CQjtb2DdfQ2RYkyqqQRLYr/+C0ioQYE3ldhI4
         YW4QqJGp0BXEqaPN22z/JKmPurqD8yRSsMNNVTnY3/5cjPViAoPFzNLxM4OqU2R7ikOE
         QFGSmkeTqF1HEhEhSTptoc5H5gKwDlQmPKnd7BmEzoGrkClNW+8c8CinxVPduErcJgF1
         nqXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758935406; x=1759540206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4cE/wiw38W515KvbSUHuF05rWrOnxxJMb0/M9FJ+mqw=;
        b=NOclJxVCFAnJdcckO5CWU4RNUSK92MBl8xGoFSaNn39KDMPQ71TU7lM6s2sIhhQDDl
         aRv22cOC68hYr8YSBXJ5RSHesgcIhiVRM+V3zB/jZ16kLt2cCAWfD3p2XfXNqzG7aL65
         OElZftc4yRGnf10NKoWFvjs2/USiKd67tyfDqLPJ/KpCsULwyXzAUiotUHZvQQ6ty4wO
         ZqDC95mrJcB28jN01+wxgi0a5JDl3lk8mezSmN2pmeR7FPD5GvCtw0RSornsWtxwraDR
         Goo2Hp7xe0K2s8okTdctJgOQNGU0/Pn8eptfJ2yF4d+z+mvsD4ousahDCBSjJcdNhgs4
         VxCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlOeD8lL+dN74VkGxgV28nkPW13bxzqRXetGRmlir7nxO1Hc4z6XLEjNvhqU7ZAP4XIOYpJpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyEwJz3reELxWpFKwwl3DiX4YaSzoIS3b3a9HMfIaMNwqIkeAS
	r8guTSZrUbcJChoQg1LTYrpUmuzTtdFCKn1qpD3SmRu+DOdk82WQKatHvowdHP/WxFKTEPMx9tO
	+oppCd0mHy+bzjKJqiJJd85aNWj0rUf0=
X-Gm-Gg: ASbGncv4xERV05fxyInmv55B7gN0rtu3Dw/xPyrW0Ffd4HxiUTaOd8hMQStOfKt7N/2
	hKPbH1fkLLmCMeHKCGtFjTT9rYLE3vhKpLbp0v03bDoIqAFvVEX1J5ZI5XishieGMW2Wj+JanjB
	P3dhjhhB1bYvhteLe3tVJb0QAWI/6Op8meFen0E9bC5fKlSqOHYQgpegnrUfbbJ7do8fBwxfxba
	wC9P1I=
X-Google-Smtp-Source: AGHT+IEZ5IRGpPzMINwslrP6GxAxmBFz99NhUFEK7zOKqpezCEEBiR3Gik8C5ZoRvJCCnWdwOXC/qEOPglvyMeeIuQI=
X-Received: by 2002:a05:6e02:194d:b0:428:1858:801d with SMTP id
 e9e14a558f8ab-42818588185mr38839555ab.2.1758935405666; Fri, 26 Sep 2025
 18:10:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926151304.1897276-1-edumazet@google.com> <20250926151304.1897276-3-edumazet@google.com>
In-Reply-To: <20250926151304.1897276-3-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 27 Sep 2025 09:09:29 +0800
X-Gm-Features: AS18NWAFPD2Z4HyU4FWE-pnyVVGWc94BMR63u3sdKEC3dnc-JqZwKX-iW0UizME
Message-ID: <CAL+tcoCL8DmRv70NSbJPPkPd-ksD=FMo+HPMi8i-HvAS=x2rxA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] net: use llist for sd->defer_list
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 11:13=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> Get rid of sd->defer_lock and adopt llist operations.
>
> We optimize skb_attempt_defer_free() for the common case,
> where the packet is queued. Otherwise sd->defer_count
> is increasing, until skb_defer_free_flush() clears it.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Quite interesting optimization! I like the no lock version. Thanks!

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

> ---
>  include/linux/netdevice.h |  8 ++++----
>  net/core/dev.c            | 18 ++++++------------
>  net/core/skbuff.c         | 15 +++++++--------
>  3 files changed, 17 insertions(+), 24 deletions(-)
>
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 27e3fa69253f694b98d32b6138cf491da5a8b824..5c9aa16933d197f70746d64e5=
f44cae052d9971c 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -3537,10 +3537,10 @@ struct softnet_data {
>         struct numa_drop_counters drop_counters;
>
>         /* Another possibly contended cache line */
> -       spinlock_t              defer_lock ____cacheline_aligned_in_smp;
> -       atomic_t                defer_count;
> -       int                     defer_ipi_scheduled;
> -       struct sk_buff          *defer_list;
> +       struct llist_head       defer_list ____cacheline_aligned_in_smp;
> +       atomic_long_t           defer_count;
> +
> +       int                     defer_ipi_scheduled ____cacheline_aligned=
_in_smp;
>         call_single_data_t      defer_csd;
>  };
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 8566678d83444e8aacbfea4842878279cf28516f..fb67372774de10b0b112ca71c=
7c7a13819c2325b 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -6717,22 +6717,16 @@ EXPORT_SYMBOL(napi_complete_done);
>
>  static void skb_defer_free_flush(struct softnet_data *sd)
>  {
> +       struct llist_node *free_list;
>         struct sk_buff *skb, *next;
>
> -       /* Paired with WRITE_ONCE() in skb_attempt_defer_free() */
> -       if (!READ_ONCE(sd->defer_list))
> +       if (llist_empty(&sd->defer_list))
>                 return;
> +       atomic_long_set(&sd->defer_count, 0);
> +       free_list =3D llist_del_all(&sd->defer_list);
>
> -       spin_lock(&sd->defer_lock);
> -       skb =3D sd->defer_list;
> -       sd->defer_list =3D NULL;
> -       atomic_set(&sd->defer_count, 0);
> -       spin_unlock(&sd->defer_lock);
> -
> -       while (skb !=3D NULL) {
> -               next =3D skb->next;
> +       llist_for_each_entry_safe(skb, next, free_list, ll_node) {

nit: no need to keep brackets

>                 napi_consume_skb(skb, 1);
> -               skb =3D next;
>         }
>  }
>
> @@ -12995,7 +12989,7 @@ static int __init net_dev_init(void)
>                 sd->cpu =3D i;
>  #endif
>                 INIT_CSD(&sd->defer_csd, trigger_rx_softirq, sd);
> -               spin_lock_init(&sd->defer_lock);
> +               init_llist_head(&sd->defer_list);
>
>                 gro_init(&sd->backlog.gro);
>                 sd->backlog.poll =3D process_backlog;
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index f91571f51c69ecf8c2fffed5f3a3cd33fd95828b..22d9dba0e433cf67243a5b7dd=
a77e61d146baf50 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -7184,6 +7184,7 @@ static void kfree_skb_napi_cache(struct sk_buff *sk=
b)
>   */
>  void skb_attempt_defer_free(struct sk_buff *skb)
>  {
> +       unsigned long defer_count;
>         int cpu =3D skb->alloc_cpu;
>         struct softnet_data *sd;
>         unsigned int defer_max;
> @@ -7201,17 +7202,15 @@ nodefer:        kfree_skb_napi_cache(skb);
>
>         sd =3D &per_cpu(softnet_data, cpu);
>         defer_max =3D READ_ONCE(net_hotdata.sysctl_skb_defer_max);
> -       if (atomic_read(&sd->defer_count) >=3D defer_max)
> +       defer_count =3D atomic_long_inc_return(&sd->defer_count);
> +
> +       if (defer_count >=3D defer_max)
>                 goto nodefer;
>
> -       spin_lock_bh(&sd->defer_lock);
> -       /* Send an IPI every time queue reaches half capacity. */
> -       kick =3D (atomic_inc_return(&sd->defer_count) - 1) =3D=3D (defer_=
max >> 1);
> +       llist_add(&skb->ll_node, &sd->defer_list);
>
> -       skb->next =3D sd->defer_list;
> -       /* Paired with READ_ONCE() in skb_defer_free_flush() */
> -       WRITE_ONCE(sd->defer_list, skb);
> -       spin_unlock_bh(&sd->defer_lock);
> +       /* Send an IPI every time queue reaches half capacity. */
> +       kick =3D (defer_count - 1) =3D=3D (defer_max >> 1);
>
>         /* Make sure to trigger NET_RX_SOFTIRQ on the remote CPU
>          * if we are unlucky enough (this seems very unlikely).
> --
> 2.51.0.536.g15c5d4f767-goog
>
>

