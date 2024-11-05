Return-Path: <netdev+bounces-141786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C86DF9BC3D7
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 04:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED06B1C20DC4
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 03:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9AD185954;
	Tue,  5 Nov 2024 03:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gbJWNMzi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA41818454E
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 03:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730777049; cv=none; b=oi7/5alKyCZV4jUutzSxLtOMfOlHC3mkgnevEfTEG1Td+OF5h/UClLNcwtFkRY06+wi6DrpTvFke/vYk1gV1kCthiiMBr50nze7IeC5Sn2N/7mVWoXKkLFHW7BaEF7C+Y9GUO7UrfJ7nMajL6UA+Fn7eyuBfwewfqgc4Bwj9aWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730777049; c=relaxed/simple;
	bh=5QUHgNsVFQlVu3u6ggbOA3TAqcHXnvWxj+mlox2vBQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eDg56aX/lU4UhrR+W/ZGJ95dkPeo7wi6UgP4l1a9PfXzcaoZN52QzTzCtKGaePzDMXDT2r5G9gZaBTGX2zr9Upa07dltzCMgPv8jsPq4UlBR3KZ5HdrhpqgwRG8M9HBoTnOhOESTQb70M9pE9LkzsVDfFuARQ/fpx9zHYIrYCYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gbJWNMzi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730777046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g5n1SqOXBxh35CLZ/E76FYksVvJeG9eAJd+Pgox1e9A=;
	b=gbJWNMzind0czScYgworwnFQd0PDhUP/ar+OANv+n2WG2K+6Y0LkdUlXVB6e/V++mTfp6A
	rqKVGMD/UlZ26c9Ro0OMcecFQwX/fRdb0tlTEIkwyhY7zJkval9NmW433/UFQePMRFzNRq
	6DtWGGqt/ZAEOBKTKN6ZtjpQ+BzGW/E=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60--i2awCr3Pp6kLiXxmPPtvg-1; Mon, 04 Nov 2024 22:24:03 -0500
X-MC-Unique: -i2awCr3Pp6kLiXxmPPtvg-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-20c7ba2722fso49116075ad.1
        for <netdev@vger.kernel.org>; Mon, 04 Nov 2024 19:24:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730777042; x=1731381842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g5n1SqOXBxh35CLZ/E76FYksVvJeG9eAJd+Pgox1e9A=;
        b=pCDjttuX0ekiRfEqD9Oeuctgs5CPCYJ/JjMNbIc0go1ACaIdUCXv+Zz5Kxee5l6Y3s
         CzQCIh1wIxsod5btOxiFOkKRz9TE9AnXMO1u/7jntMxdMyJd/YIcwqJp7YR9M2DWM+jW
         b3E06Q0ohuvoEukuKsaWtFYHPv4gSPd/PP8OaAgs81hknvFx6i3wtKP6XOu9qkzNFd5b
         Ck+zA2fLnN28J3QYd0/c6WBE/E1/xF6GK60ELJsffP7JT/iMbo0iESAfgQl8R+30H+wr
         MJv+A7Bn1CcaeK7ZqQ6pifmgD8VzpPhpuHDi4us2MLYSEVP8sIHZh2KF+KWzmUsnTPkm
         tnkg==
X-Gm-Message-State: AOJu0YyHhtxxakxqGqZJmwFtOvmTKV8YjWhsuUXNxAZM9jd8lMMx7JKn
	XBEwNXfq9Sr4w9I8zNDW3gfQmHlDGQT0uh8NniYhuXs/T8vM12ta0Kgyw5IF/lKhiqv1KhdWl+y
	g6+CaOa+J8+i5uMyeubtbxNVcHO/l1CDLcVo5l9ivmd9WndYZdgGgbBzOg5BDzTcq6jFEB/vSNO
	lMrlB0tUKkkOZP0Nv3HPi1JbzUrASQ
X-Received: by 2002:a17:903:2b06:b0:20c:d5d9:95dc with SMTP id d9443c01a7336-210f76d67cfmr268475935ad.40.1730777042671;
        Mon, 04 Nov 2024 19:24:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEaIDVC9Qi5Y2fDkClwQoOViLbl1azvUa3CWlVG9p2ehPtLvN2mbt9WVC/NUU9tEoAThf431M26JAZ/sT5va9E=
X-Received: by 2002:a17:903:2b06:b0:20c:d5d9:95dc with SMTP id
 d9443c01a7336-210f76d67cfmr268475545ad.40.1730777042172; Mon, 04 Nov 2024
 19:24:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030082453.97310-1-xuanzhuo@linux.alibaba.com> <20241030082453.97310-7-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20241030082453.97310-7-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 5 Nov 2024 11:23:50 +0800
Message-ID: <CACGkMEviCSEo4thkFo8gYnv+FCm-v65umJ65fdOwtxbAF_F2Ag@mail.gmail.com>
Subject: Re: [PATCH net-next v2 06/13] virtio-net: rq submits premapped per-buffer
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 4:25=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> virtio-net rq submits premapped per-buffer by setting sg page to NULL;
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 792e9eadbfc3..09757fa408bd 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -542,6 +542,12 @@ static struct sk_buff *ptr_to_skb(void *ptr)
>         return (struct sk_buff *)((unsigned long)ptr & ~VIRTIO_ORPHAN_FLA=
G);
>  }
>
> +static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 len=
)
> +{
> +       sg->dma_address =3D addr;
> +       sg->length =3D len;

This may work but I think it's better to reuse existing dma sg helpers like=
:

sg_dma_address(sg) =3D addr;
sg_dma_length(sg) =3D len;

And we probably need to fix the virtio core which only uses
sg_dma_address() but not sg_dma_length().

This helps us to avoid future issues when CONFIG_NEED_SG_DMA_LENGTH is set.

Others look good.

Thanks

> +}
> +
>  static void __free_old_xmit(struct send_queue *sq, struct netdev_queue *=
txq,
>                             bool in_napi, struct virtnet_sq_free_stats *s=
tats)
>  {
> @@ -915,8 +921,7 @@ static void virtnet_rq_init_one_sg(struct receive_que=
ue *rq, void *buf, u32 len)
>         addr =3D dma->addr - sizeof(*dma) + offset;
>
>         sg_init_table(rq->sg, 1);
> -       rq->sg[0].dma_address =3D addr;
> -       rq->sg[0].length =3D len;
> +       sg_fill_dma(rq->sg, addr, len);
>  }
>
>  static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t =
gfp)
> @@ -1068,12 +1073,6 @@ static void check_sq_full_and_disable(struct virtn=
et_info *vi,
>         }
>  }
>
> -static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 len=
)
> -{
> -       sg->dma_address =3D addr;
> -       sg->length =3D len;
> -}
> -
>  static struct xdp_buff *buf_to_xdp(struct virtnet_info *vi,
>                                    struct receive_queue *rq, void *buf, u=
32 len)
>  {
> @@ -1354,7 +1353,8 @@ static int virtnet_add_recvbuf_xsk(struct virtnet_i=
nfo *vi, struct receive_queue
>                 sg_init_table(rq->sg, 1);
>                 sg_fill_dma(rq->sg, addr, len);
>
> -               err =3D virtqueue_add_inbuf(rq->vq, rq->sg, 1, xsk_buffs[=
i], gfp);
> +               err =3D virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1, =
xsk_buffs[i],
> +                                                   NULL, true, gfp);
>                 if (err)
>                         goto err;
>         }
> @@ -2431,7 +2431,8 @@ static int add_recvbuf_small(struct virtnet_info *v=
i, struct receive_queue *rq,
>
>         virtnet_rq_init_one_sg(rq, buf, vi->hdr_len + GOOD_PACKET_LEN);
>
> -       err =3D virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp)=
;
> +       err =3D virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1, buf, ctx=
,
> +                                           rq->do_dma, gfp);
>         if (err < 0) {
>                 if (rq->do_dma)
>                         virtnet_rq_unmap(rq, buf, 0);
> @@ -2546,7 +2547,8 @@ static int add_recvbuf_mergeable(struct virtnet_inf=
o *vi,
>         virtnet_rq_init_one_sg(rq, buf, len);
>
>         ctx =3D mergeable_len_to_ctx(len + room, headroom);
> -       err =3D virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp)=
;
> +       err =3D virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1, buf, ctx=
,
> +                                           rq->do_dma, gfp);
>         if (err < 0) {
>                 if (rq->do_dma)
>                         virtnet_rq_unmap(rq, buf, 0);
> --
> 2.32.0.3.g01195cf9f
>


