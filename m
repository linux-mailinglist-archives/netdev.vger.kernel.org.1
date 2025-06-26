Return-Path: <netdev+bounces-201392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8AFAE940B
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 04:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2E9C7A4EF8
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 02:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1791DE892;
	Thu, 26 Jun 2025 02:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JLG1K6g+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC621494C2
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 02:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750905260; cv=none; b=gvTHZGpIe+vhObjq81Tx+0V65kXYLDgnUxcsmM7St6kxirTWHeZXoZ3ksUJpRbEGwJJukT6PFiET4xS+EiEEkMAbHuG45kDETqCmuzOmgV4uLZ/0hC+1BQ3qT06BIH/aez4sJ5rl3ClmNaeRG1Dvlm9TbLKRV0YUDdZqjlnz1jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750905260; c=relaxed/simple;
	bh=Ywnfk5CtunwDSKI5ePQke6zvKrlORy5MiO0skNTlXoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ilkzLu1FAO9XeMnHZvuBNciLSf+fUoR9NU2XniX+0SgIZdRwMb42sQ8WUzgYogYdcm5+xEi0qKZUUVzBt2QaLQx1urQ/5dKF/m1JuUmM6xqLzrd/ycBswGH3d3FXV4DjJb1TB9S1QPKRzebjWBnO0dRv0ax58uVBwLDnfd5eBXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JLG1K6g+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750905257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YT8CI7GYn/0UQ0nLPl5n5hA5UBnWvrLiTRc8GBQHDvw=;
	b=JLG1K6g+r2O3+iQYnyichwjSTXIAks7C8XSwkFUNBGQqNDurzHucsJ8cvTX6BHn4MkFblS
	WAmompLUz2b8jQFODZFRR2yFGJF88J+FRxQ5facSpZfUoyT6LsWyMVed5ozod9Q2UWc4/o
	vOYF5pfYiQdZQYRfYX+Fqhi2AbcTSfM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-c2GBU-6dNQ6tlmCZnZ-VIA-1; Wed, 25 Jun 2025 22:34:15 -0400
X-MC-Unique: c2GBU-6dNQ6tlmCZnZ-VIA-1
X-Mimecast-MFC-AGG-ID: c2GBU-6dNQ6tlmCZnZ-VIA_1750905255
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3138c50d2a0so704587a91.2
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 19:34:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750905254; x=1751510054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YT8CI7GYn/0UQ0nLPl5n5hA5UBnWvrLiTRc8GBQHDvw=;
        b=GAUZH63XMPSxvIwMbatmK3EdyolYkP/ZH3hkcIiBPhwwmwx2TNmRocVhxO2/zIjbCU
         FnijUVWdqbljfyDcZSCMhos0cPIWT23IDgd0qdJ2YM2Se3w1z9+JPhGpCq2LfFuyre7I
         rJzay78SOn/K3Ay7n+XNhjA/6gwP7Qk4sYjaN7RJnZrIaabZtdcF/NM06kCe124eWttk
         MU5+WKR+F86RfqZA2svFSNsjW44fm4ezffJDiA5esMVtTOu7Zo6b1fod3ddQeYkIQSg+
         eKKvsun7V26n9kY2YLWpiZnYTnVd2JamQEBu6Ws+jrSOp9SkGyibQR8KTrZ8jMyMZKe7
         AvZw==
X-Gm-Message-State: AOJu0Yww+PW1Fb5JXAxpHc9xE/JoOWwfkex2HD4Rc4wpnsVONL0ZtQft
	dzXE2/P9dwo3l77GUE3g9iCYDviieE4QvKSY5t3bFbd+0geNnTjf34ch5gLC97fydazeVrAta7M
	KxqHg7aUztFpibgcOhjxQYqc1yUGTF/bBM/y5hZF1/ESdjtcFLyj/zBC/apcuKXhxCxsH5cN6GW
	h3QwQPC6pDdps33RjziSeyEIodu7wj5LUu
X-Gm-Gg: ASbGncu0h09a1QeW2aVS5QT2qPM7DtfabD+AZeYCHAwAmo4VLnuk+2hJq6+zBQfkVfZ
	GoNRadxSy7PTiaya2Co3en+KjZKIwgX7vXdRnDakHUi4TZTg1br8Q9/WY4u5k7uYXbowfr0pohf
	RYaC7w
X-Received: by 2002:a17:90b:1d05:b0:311:9c1f:8516 with SMTP id 98e67ed59e1d1-315f26192efmr8661942a91.15.1750905254630;
        Wed, 25 Jun 2025 19:34:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmWZ20ylBufEuyD8a4snrfN5wLqjOc1AW3vCQs60y21v0vOw3rVlavg03klPFzZsn8v3UuQzPZyDKXt277yE0=
X-Received: by 2002:a17:90b:1d05:b0:311:9c1f:8516 with SMTP id
 98e67ed59e1d1-315f26192efmr8661917a91.15.1750905254221; Wed, 25 Jun 2025
 19:34:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625160849.61344-1-minhquangbui99@gmail.com> <20250625160849.61344-2-minhquangbui99@gmail.com>
In-Reply-To: <20250625160849.61344-2-minhquangbui99@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 26 Jun 2025 10:34:02 +0800
X-Gm-Features: Ac12FXyruohJ57b6kb7ijE0xoMHh_6UYned9b5xz_RKi13myHBKADRrN7NPxO3A
Message-ID: <CACGkMEvioXkt3_zB-KijwhoUx5NS5xa0Jvd=w2fhBZFf3un1Ww@mail.gmail.com>
Subject: Re: [PATCH net 1/4] virtio-net: ensure the received length does not
 exceed allocated size
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 12:10=E2=80=AFAM Bui Quang Minh
<minhquangbui99@gmail.com> wrote:
>
> In xdp_linearize_page, when reading the following buffers from the ring,
> we forget to check the received length with the true allocate size. This
> can lead to an out-of-bound read. This commit adds that missing check.
>
> Fixes: 4941d472bf95 ("virtio-net: do not reset during XDP set")

I think we should cc stable.

> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
>  drivers/net/virtio_net.c | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index e53ba600605a..2a130a3e50ac 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1797,7 +1797,8 @@ static unsigned int virtnet_get_headroom(struct vir=
tnet_info *vi)
>   * across multiple buffers (num_buf > 1), and we make sure buffers
>   * have enough headroom.
>   */
> -static struct page *xdp_linearize_page(struct receive_queue *rq,
> +static struct page *xdp_linearize_page(struct net_device *dev,
> +                                      struct receive_queue *rq,
>                                        int *num_buf,
>                                        struct page *p,
>                                        int offset,
> @@ -1818,17 +1819,33 @@ static struct page *xdp_linearize_page(struct rec=
eive_queue *rq,
>         page_off +=3D *len;
>
>         while (--*num_buf) {
> -               unsigned int buflen;
> +               unsigned int headroom, tailroom, room;
> +               unsigned int truesize, buflen;
>                 void *buf;
> +               void *ctx;
>                 int off;
>
> -               buf =3D virtnet_rq_get_buf(rq, &buflen, NULL);
> +               buf =3D virtnet_rq_get_buf(rq, &buflen, &ctx);
>                 if (unlikely(!buf))
>                         goto err_buf;
>
>                 p =3D virt_to_head_page(buf);
>                 off =3D buf - page_address(p);
>
> +               truesize =3D mergeable_ctx_to_truesize(ctx);

This won't work for receive_small_xdp().

> +               headroom =3D mergeable_ctx_to_headroom(ctx);
> +               tailroom =3D headroom ? sizeof(struct skb_shared_info) : =
0;
> +               room =3D SKB_DATA_ALIGN(headroom + tailroom);
> +
> +               if (unlikely(buflen > truesize - room)) {
> +                       put_page(p);
> +                       pr_debug("%s: rx error: len %u exceeds truesize %=
lu\n",
> +                                dev->name, buflen,
> +                                (unsigned long)(truesize - room));
> +                       DEV_STATS_INC(dev, rx_length_errors);
> +                       goto err_buf;
> +               }

I wonder if this issue only affect XDP should we check other places?

> +
>                 /* guard against a misconfigured or uncooperative backend=
 that
>                  * is sending packet larger than the MTU.
>                  */
> @@ -1917,7 +1934,7 @@ static struct sk_buff *receive_small_xdp(struct net=
_device *dev,
>                 headroom =3D vi->hdr_len + header_offset;
>                 buflen =3D SKB_DATA_ALIGN(GOOD_PACKET_LEN + headroom) +
>                         SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> -               xdp_page =3D xdp_linearize_page(rq, &num_buf, page,
> +               xdp_page =3D xdp_linearize_page(dev, rq, &num_buf, page,
>                                               offset, header_offset,
>                                               &tlen);
>                 if (!xdp_page)
> @@ -2252,7 +2269,7 @@ static void *mergeable_xdp_get_buf(struct virtnet_i=
nfo *vi,
>          */
>         if (!xdp_prog->aux->xdp_has_frags) {
>                 /* linearize data for XDP */
> -               xdp_page =3D xdp_linearize_page(rq, num_buf,
> +               xdp_page =3D xdp_linearize_page(vi->dev, rq, num_buf,
>                                               *page, offset,
>                                               XDP_PACKET_HEADROOM,
>                                               len);
> --
> 2.43.0
>


