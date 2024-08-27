Return-Path: <netdev+bounces-122132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 586AB95FFE7
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 05:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B85622835FF
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 03:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA58F1F93E;
	Tue, 27 Aug 2024 03:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P5AOVVhH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30341AAD7
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 03:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724729946; cv=none; b=C+L0FjPu+W+KVxZHFR7bCwSqEKrQ0IEXkLlRKQjNvgb7rQb7p3v2HP4Y4gC2ieOHFiacXPoAaHyedIcxrWfvyjunKDNEzNvIUqKuEz+BzYCDWaz3Unmg1ShpkA3Xh0jDoZPD4g1NH2eLGbK3MdvNVWuc6SnpES3CNmM3lMlve1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724729946; c=relaxed/simple;
	bh=qPj8e6KZW3zeA36w4AxrE/xPrzHxWnvF2KWgrG8NvJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DXq9FkwMnWRNbK2xBSlKhJcFHC6bwgGSAtwTsPzlqL0o9DTTGjdRstO8KH7nz/yw7/5JYDw7s65d/FyZlAd5fZziWGWQVfaLXqijowhMRlxxrEjakc5oy7ZXwLieDf+QBCbDkjK4MWbjX/uhURscU2VljReMty2SJdIw270oD5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P5AOVVhH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724729942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1nwuiNsPkSnhT0tsh3FyfKFgKWrXEnm1+cpuDpPB7TA=;
	b=P5AOVVhHoPGYPdcoZ/AOxLSPUFGEFD1m8DDKlhNPlF+GmySvQHBxcDQlWnfSd0tOd+D3nX
	XAFelpo+PPtWLkgB1GPEY4LA/8XTeZ+8ColvhgL+ogEkQQZINx6NPiRZilp8RnxQpIy/uq
	X2ZPu7qMd7WTVA8m/DtHCvUWPWTYRtg=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-axmP8Rl_OJiQq5hLw3ZJMQ-1; Mon, 26 Aug 2024 23:39:00 -0400
X-MC-Unique: axmP8Rl_OJiQq5hLw3ZJMQ-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2d45800a8f3so4835934a91.1
        for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 20:38:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724729938; x=1725334738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1nwuiNsPkSnhT0tsh3FyfKFgKWrXEnm1+cpuDpPB7TA=;
        b=Q8VFG487FcPPvAc86r+blVQyrqS/2z64TLl4NaVUOBE6d8luQiLasjBs/Y7oHp0jfO
         vCm2YdcLPErJu2Mx6jETshdFutjD2o/s430iFBtg7hnt6+shxduKIsFvLLYudRa5nGf/
         hLekvKf38lvT5Z3ksqP8xZ9Uj3agY1Kmp656FVzgPGQcTozbVIpIcWpLsST+taInWycI
         1yHde4WriVjQykOF8NFNKFSqygggwK/P+G6Zif8rvz8bV3lDraOHwr0eWOeBgXhPaxYC
         i5KkzmyFB+1VY9alhImtmeiLPgQkxgggOR5U28i/sABCqjo5sIssyWAHqBfdiUHW0NKY
         /jWw==
X-Gm-Message-State: AOJu0YzVNtbbnrY78lkzATHETStXkB1LCzGsWx6eF98eMe0xiMwSslWO
	jQfvc+biFbK51PF7ALYMfHoimUtzpr50G7dMf9dL8m3wenjY8Lwoc99Wb5AmHMU5NOnrEunu/CE
	63/ca2BWlIoZPCkLXcDv5CpXp5BTDrjJLBHjrg0bc6zfiWtlUWBBu/rzw6LTEF+P/hg7VQDmTqb
	B3d+Z366Sf7+8VPQ6Pz6l7Q6inL2KRKo3LANvfZKKk9g==
X-Received: by 2002:a17:90a:4a11:b0:2c9:75fd:298a with SMTP id 98e67ed59e1d1-2d646d73335mr10836238a91.42.1724729938618;
        Mon, 26 Aug 2024 20:38:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3gpy8wEWdb9GgnKaHjzJAi3gjXq5w5NRmexeWNXsx4l2cNzihUWLogPuBTVomsVnEHLCJ8XI0yYkI1PqW/jI=
X-Received: by 2002:a17:90a:4a11:b0:2c9:75fd:298a with SMTP id
 98e67ed59e1d1-2d646d73335mr10836217a91.42.1724729938068; Mon, 26 Aug 2024
 20:38:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820071913.68004-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240820071913.68004-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 27 Aug 2024 11:38:45 +0800
Message-ID: <CACGkMEsJ2sckV5S1nGF+MrTgScVTTuwv6PHuLZARusJsFpf58g@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: fix overflow inside virtnet_rq_alloc
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, virtualization@lists.linux.dev, 
	Si-Wei Liu <si-wei.liu@oracle.com>, Darren Kenny <darren.kenny@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 3:19=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> leads to regression on VM with the sysctl value of:
>
> - net.core.high_order_alloc_disable=3D1
>
> which could see reliable crashes or scp failure (scp a file 100M in size
> to VM):
>
> The issue is that the virtnet_rq_dma takes up 16 bytes at the beginning
> of a new frag. When the frag size is larger than PAGE_SIZE,
> everything is fine. However, if the frag is only one page and the
> total size of the buffer and virtnet_rq_dma is larger than one page, an
> overflow may occur. In this case, if an overflow is possible, I adjust
> the buffer size. If net.core.high_order_alloc_disable=3D1, the maximum
> buffer size is 4096 - 16. If net.core.high_order_alloc_disable=3D0, only
> the first buffer of the frag is affected.

I wonder instead of trying to make use of headroom, would it be
simpler if we allocate dedicated arrays of virtnet_rq_dma=EF=BC=9F

Btw, I see it has a need_sync, I wonder if it can help for performance
or not? If not, any reason to keep that?

>
> Fixes: f9dac92ba908 ("virtio_ring: enable premapped mode whatever use_dma=
_api")
> Reported-by: "Si-Wei Liu" <si-wei.liu@oracle.com>
> Closes: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba164a540c0a@o=
racle.com
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index c6af18948092..e5286a6da863 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -918,9 +918,6 @@ static void *virtnet_rq_alloc(struct receive_queue *r=
q, u32 size, gfp_t gfp)
>         void *buf, *head;
>         dma_addr_t addr;
>
> -       if (unlikely(!skb_page_frag_refill(size, alloc_frag, gfp)))
> -               return NULL;
> -
>         head =3D page_address(alloc_frag->page);
>
>         dma =3D head;
> @@ -2421,6 +2418,9 @@ static int add_recvbuf_small(struct virtnet_info *v=
i, struct receive_queue *rq,
>         len =3D SKB_DATA_ALIGN(len) +
>               SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>
> +       if (unlikely(!skb_page_frag_refill(len, &rq->alloc_frag, gfp)))
> +               return -ENOMEM;
> +
>         buf =3D virtnet_rq_alloc(rq, len, gfp);
>         if (unlikely(!buf))
>                 return -ENOMEM;
> @@ -2521,6 +2521,12 @@ static int add_recvbuf_mergeable(struct virtnet_in=
fo *vi,
>          */
>         len =3D get_mergeable_buf_len(rq, &rq->mrg_avg_pkt_len, room);
>
> +       if (unlikely(!skb_page_frag_refill(len + room, alloc_frag, gfp)))
> +               return -ENOMEM;
> +
> +       if (!alloc_frag->offset && len + room + sizeof(struct virtnet_rq_=
dma) > alloc_frag->size)
> +               len -=3D sizeof(struct virtnet_rq_dma);
> +
>         buf =3D virtnet_rq_alloc(rq, len + room, gfp);
>         if (unlikely(!buf))
>                 return -ENOMEM;
> --
> 2.32.0.3.g01195cf9f

Thanks

>


