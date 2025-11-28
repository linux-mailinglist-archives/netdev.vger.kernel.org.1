Return-Path: <netdev+bounces-242493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E009C90B1E
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 04:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBFEE3A9A85
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 03:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A1E279917;
	Fri, 28 Nov 2025 03:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZxYWz1vw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PNmNttyI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAAA26FA57
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 03:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764298942; cv=none; b=lFf6X4ayr4+hfALaFWMOg4nDGIVadluhCRdt4eg7Dt8rXNTaR8pB2D0PBeRgyXFrYyn+mBi8q1DUVlawiywPBdp0/dkHARW7hZF3SnND93QuaxvbAi09864huYF8Dzq5FuqvRW/QGTc6WvxdQbS1Vjc419v0jlepFQ0SIWcK95I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764298942; c=relaxed/simple;
	bh=dRqtZE1W2JnVrg3loh/r52YhX0ka0xKpniTFG22/y1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lylvnSWBX5OOWtDn07ByswGIO9vgajRJHpfYZRbjK1mo96QkH5V6wDnotd+SPY3EpocQh/wKuKCAgZwvpP+bW0HOuj4yRqoVmDQAyW6j7VL90+xbCF22KcPmQIbcHixd82aP9RpgIM8U27yv12k0gbf3CJx2Is65Ljx81u6O0SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZxYWz1vw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PNmNttyI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764298939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0+ddStysEuNpBbHzgItNVROsOVlJtz7kVHTtVmCFdRo=;
	b=ZxYWz1vwl7eCF/IT8d6uiQWEXV1SKHpNkxMvxrh/WHi0HXtIyY4JpVDZX2JhV+RpgWck3r
	+omNidCnef5+/i7e9ecPXBuhuLFtIzVhzo5tCmYXWgC3WB6mOxEQnY1ALMdskWRrnz3Tsf
	04Wbqz3XHFl6/fW89GPZ8fctCyT+/MI=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-JvZgDx5sNPaZ_N43SBQ2KA-1; Thu, 27 Nov 2025 22:02:17 -0500
X-MC-Unique: JvZgDx5sNPaZ_N43SBQ2KA-1
X-Mimecast-MFC-AGG-ID: JvZgDx5sNPaZ_N43SBQ2KA_1764298937
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-29557f43d56so15902555ad.3
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 19:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764298937; x=1764903737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+ddStysEuNpBbHzgItNVROsOVlJtz7kVHTtVmCFdRo=;
        b=PNmNttyIryeeL4v70hetGJzNeW7PuH0Me4HZOeQ6QHxHKhRK3bJ8ekXktljURCJD0W
         t76mlFaaQqooNDJkEXprtfEsd0IMTY4E3nDitpngJjcT7m/fCv8LWxX5GjZ2zQvYZbUV
         3uZcejbOPm4HOjMST4p1rYEsoQDOue19BBI5LMUhsyq7+MN6GtebGjU+FX78SBzhybNm
         kRIOugSNCAePX05LZz8t5wtfbIBGF+EkaCxHzVKs7tFIX4sY1JdNkWv40KAA0jH4utOG
         Mh/LDeP55pXbStzFZl95gmpHanfar+D0kA6k8cnOTzpVk94s4a2ve/BR6Fi8abfWyyvy
         FRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764298937; x=1764903737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0+ddStysEuNpBbHzgItNVROsOVlJtz7kVHTtVmCFdRo=;
        b=vb0elQo9VLZFi8HyaQ+G0ftkzVA4ylLhLWo3DsIhoxbYBRsmMzKh1tWSh5VD+/JDel
         /7htrIaAmqg9/jv7M8n/kfyAM9W5G7Q0zVg0TP96YSYD8jq4uERq+oc7VIdGBDQxtoHL
         KsGOb+yi3kyfabexHMvem7SnGDGtwZh0kZnUZr4mm9jiFN3zGU5JuskZWC3LUAayJieF
         1GNnFY8u3GOmaILRIvHxqLzkmpF2I24+S5qCB3Ki4RjOdJe9KPviIBcuuxuWDPRbSwss
         keQF4JvyD/NarOtY4kxrfUcOL7Rov1X4/KSzWbGP0figcsFNLZ3mNJuVYgPns39G2doc
         1GkA==
X-Gm-Message-State: AOJu0YxAbVsI3m6uDNM3YDjKPgVhPvp2XFU1QFpAVIOFzgxYLbo2ZLR9
	uvMzueZZABas6ZL+VUcQf9Rdbla0jb/8stpCuJ6Rd9AkCl0MDzk5zZmc/Wbwp4xGSjvI5FHI9Q1
	kiUR8PLcXaO+zthWW2JSXPdKPL/IXWCidqlRRwFh5eOmt81q9e7h1wOUpbN3z/YLOL9LmFw46SX
	Czo2Je7K+rMrqfoALWq6k/Zo/v3llZ95vJ
X-Gm-Gg: ASbGncuOCiolOWiE6Gl+kSgDcLSRd4zOHKBo/ib4N7DM/49WSKYUQ9QdO+g+J69Fxzg
	oZkugkHUTc3oyfYiwxGmRBi9m7GOuqFgdY7fpJFvENmZlfhHQ6a6rvYFWwKPEzoUhHCi7WYYNut
	ADIJOXPsWaIEq6EFE0u0to4b2Zo1G5PoX76A2MsQCKB2sxliFvyID/kzB4hDtAEIIk
X-Received: by 2002:a17:902:e88b:b0:298:8ec:9993 with SMTP id d9443c01a7336-29bab148965mr146593645ad.38.1764298936686;
        Thu, 27 Nov 2025 19:02:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHb/vno8tBL60EjWrJ0v3mEHZu6lI84RYKVvpcd7S9xmdup6uJ6jb7zQONK+XFQp9YOFydz+pix8DS6nLzyidI=
X-Received: by 2002:a17:902:e88b:b0:298:8ec:9993 with SMTP id
 d9443c01a7336-29bab148965mr146593295ad.38.1764298936199; Thu, 27 Nov 2025
 19:02:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125200041.1565663-1-jon@nutanix.com> <20251125200041.1565663-6-jon@nutanix.com>
In-Reply-To: <20251125200041.1565663-6-jon@nutanix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 28 Nov 2025 11:02:05 +0800
X-Gm-Features: AWmQ_bnD3FteqMoolfxSscqI3rlth8bjbR4RDzQCfkC6fXywE4Xhn0JdD8kvjT0
Message-ID: <CACGkMEsDCVKSzHSKACAPp3Wsd8LscUE0GO4Ko9GPGfTR0vapyg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 5/9] tun: use bulk NAPI cache allocation in tun_xdp_one
To: Jon Kohler <jon@nutanix.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, open list <linux-kernel@vger.kernel.org>, 
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 3:19=E2=80=AFAM Jon Kohler <jon@nutanix.com> wrote:
>
> Optimize TUN_MSG_PTR batch processing by allocating sk_buff structures
> in bulk from the per-CPU NAPI cache using napi_skb_cache_get_bulk.
> This reduces allocation overhead and improves efficiency, especially
> when IFF_NAPI is enabled and GRO is feeding entries back to the cache.

Does this mean we should only enable this when NAPI is used?

>
> If bulk allocation cannot fully satisfy the batch, gracefully drop only
> the uncovered portion, allowing the rest of the batch to proceed, which
> is what already happens in the previous case where build_skb() would
> fail and return -ENOMEM.
>
> Signed-off-by: Jon Kohler <jon@nutanix.com>

Do we have any benchmark result for this?

> ---
>  drivers/net/tun.c | 30 ++++++++++++++++++++++++------
>  1 file changed, 24 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 97f130bc5fed..64f944cce517 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -2420,13 +2420,13 @@ static void tun_put_page(struct tun_page *tpage)
>  static int tun_xdp_one(struct tun_struct *tun,
>                        struct tun_file *tfile,
>                        struct xdp_buff *xdp, int *flush,
> -                      struct tun_page *tpage)
> +                      struct tun_page *tpage,
> +                      struct sk_buff *skb)
>  {
>         unsigned int datasize =3D xdp->data_end - xdp->data;
>         struct virtio_net_hdr *gso =3D xdp->data_hard_start;
>         struct virtio_net_hdr_v1_hash_tunnel *tnl_hdr;
>         struct bpf_prog *xdp_prog;
> -       struct sk_buff *skb =3D NULL;
>         struct sk_buff_head *queue;
>         netdev_features_t features;
>         u32 rxhash =3D 0, act;
> @@ -2437,6 +2437,7 @@ static int tun_xdp_one(struct tun_struct *tun,
>         struct page *page;
>
>         if (unlikely(datasize < ETH_HLEN)) {
> +               kfree_skb_reason(skb, SKB_DROP_REASON_PKT_TOO_SMALL);
>                 dev_core_stats_rx_dropped_inc(tun->dev);
>                 return -EINVAL;
>         }
> @@ -2454,6 +2455,7 @@ static int tun_xdp_one(struct tun_struct *tun,
>                 ret =3D tun_xdp_act(tun, xdp_prog, xdp, act);
>                 if (ret < 0) {
>                         /* tun_xdp_act already handles drop statistics */
> +                       kfree_skb_reason(skb, SKB_DROP_REASON_XDP);

This should belong to previous patches?

>                         put_page(virt_to_head_page(xdp->data));
>                         return ret;
>                 }
> @@ -2463,6 +2465,7 @@ static int tun_xdp_one(struct tun_struct *tun,
>                         *flush =3D true;
>                         fallthrough;
>                 case XDP_TX:
> +                       napi_consume_skb(skb, 1);
>                         return 0;
>                 case XDP_PASS:
>                         break;
> @@ -2475,13 +2478,15 @@ static int tun_xdp_one(struct tun_struct *tun,
>                                 tpage->page =3D page;
>                                 tpage->count =3D 1;
>                         }
> +                       napi_consume_skb(skb, 1);

I wonder if this would have any side effects since tun_xdp_one() is
not called by a NAPI.

>                         return 0;
>                 }
>         }
>
>  build:
> -       skb =3D build_skb(xdp->data_hard_start, buflen);
> +       skb =3D build_skb_around(skb, xdp->data_hard_start, buflen);
>         if (!skb) {
> +               kfree_skb_reason(skb, SKB_DROP_REASON_NOMEM);
>                 dev_core_stats_rx_dropped_inc(tun->dev);
>                 return -ENOMEM;
>         }
> @@ -2566,9 +2571,11 @@ static int tun_sendmsg(struct socket *sock, struct=
 msghdr *m, size_t total_len)
>         if (m->msg_controllen =3D=3D sizeof(struct tun_msg_ctl) &&
>             ctl && ctl->type =3D=3D TUN_MSG_PTR) {
>                 struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
> +               int flush =3D 0, queued =3D 0, num_skbs =3D 0;
>                 struct tun_page tpage;
>                 int n =3D ctl->num;
> -               int flush =3D 0, queued =3D 0;
> +               /* Max size of VHOST_NET_BATCH */
> +               void *skbs[64];

I think we need some tweaks

1) TUN is decoupled from vhost, so it should have its own value (a
macro is better)
2) Provide a way to fail or handle the case when more than 64

>
>                 memset(&tpage, 0, sizeof(tpage));
>
> @@ -2576,13 +2583,24 @@ static int tun_sendmsg(struct socket *sock, struc=
t msghdr *m, size_t total_len)
>                 rcu_read_lock();
>                 bpf_net_ctx =3D bpf_net_ctx_set(&__bpf_net_ctx);
>
> -               for (i =3D 0; i < n; i++) {
> +               num_skbs =3D napi_skb_cache_get_bulk(skbs, n);

Its document said:

"""
 * Must be called *only* from the BH context.
"""

> +
> +               for (i =3D 0; i < num_skbs; i++) {
> +                       struct sk_buff *skb =3D skbs[i];
>                         xdp =3D &((struct xdp_buff *)ctl->ptr)[i];
> -                       ret =3D tun_xdp_one(tun, tfile, xdp, &flush, &tpa=
ge);
> +                       ret =3D tun_xdp_one(tun, tfile, xdp, &flush, &tpa=
ge,
> +                                         skb);
>                         if (ret > 0)
>                                 queued +=3D ret;
>                 }
>
> +               /* Handle remaining xdp_buff entries if num_skbs < ctl->n=
um */
> +               for (i =3D num_skbs; i < ctl->num; i++) {
> +                       xdp =3D &((struct xdp_buff *)ctl->ptr)[i];
> +                       dev_core_stats_rx_dropped_inc(tun->dev);

Could we do this in a batch?

> +                       put_page(virt_to_head_page(xdp->data));
> +               }
> +
>                 if (flush)
>                         xdp_do_flush();
>
> --
> 2.43.0
>

Thanks


