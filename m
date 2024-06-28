Return-Path: <netdev+bounces-107522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6766E91B501
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 04:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 178D21F22A5B
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 02:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1669918C31;
	Fri, 28 Jun 2024 02:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SbsS0Mod"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5931103
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 02:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719541196; cv=none; b=kscu41HzhFmKh048EH1wPa4Fm/tFsUYP2L72IjDvdxwypb2aALdxR7t2kcfEJvXApMIItCHgzZ6OEij/ErEbdEsp2r28v8D1nLH3pfTQTpOj2UvxTo9QrwUxww3cUtWmpzgB1Rbc413GIL096G6nf5ZtUV6nnKsS2DvTT3j3vqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719541196; c=relaxed/simple;
	bh=0pl5IDO84YuTZzRBLOi54dqVTmqUceO1ojj7jTBbAEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T9h4uNxL0B3jPhgu5MGpbibic0SLbuwLwhlECzCErgIt5mEmtx84ULe1ZVtMa55UnHb51dXWBN9AVJSDoPREyqm3zJ8JEsSFwUeu3EzT7fAQSRX/UWVp+RcXEfAIpHrKYuDYDOBG0od3vfpYWl31m387cPrMWyzQgDTyksDNpO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SbsS0Mod; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719541193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/nd9rJ/TDcLIKdWBumem351Ij8O7si91I+/ZDY+8chw=;
	b=SbsS0ModtgsKGQm4wyI0f/MDRCNT2a8vg7672iCRDpy7oTngVkVHxIBHSqKqe7Sk+4UcZC
	3TDYlURdYBf2EMACGjX7aZWQa1gaOmMdRXy7Y2z+fSAjcNahWkgvqJzeHoqyqWCGD71nFX
	9SgLqXPxpaWGyq03D2XDFAAGUf6+LzI=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-CgdzBEt6Ovqh0kiTERhkQA-1; Thu, 27 Jun 2024 22:19:52 -0400
X-MC-Unique: CgdzBEt6Ovqh0kiTERhkQA-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3d5658b50e1so247617b6e.0
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 19:19:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719541191; x=1720145991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/nd9rJ/TDcLIKdWBumem351Ij8O7si91I+/ZDY+8chw=;
        b=F5rDtEr6KVjwO5bb38SyLf42xkUhxL8h+5Trq2NAOeQyYZFv3q9l/ejFZhDcQa+8Ti
         bFJ4A+eGoWiYAbqSXLbQAU6Oae48wY3p0ECCo2c1+4I2A9ofNZDYNU4KMRjkWSvyY+YL
         t9c6wRGg0IMB9HGU6PqQSW1pTy3RHA3aeh3GjHyZOs0T91TV3Vcpio8qdwC2+5eFvYJr
         9UqLfMLMvQjz3d5utwAnX3+B1Yp2tadGGc7spZIb5/dy09Ejt2NjRYVSVh7qgpbnZvfh
         I9DxM8mJJfxz8NSqK4gxgrGctJtaLy30AKB1Q458NpXyMBo/qI6vyss5qAlIvcei+M5U
         VyHg==
X-Gm-Message-State: AOJu0YyZMP7Gcz+Uku5yPiFpfOswwNMaorxkpH3W8kM1aJOmq0I3fZHP
	qsIXW8lQw/iQlp5ofR/SqncqfsD2w4zlygosVndQ7uQYwuVVyNcKvG3nCo7IUGYi85Zfyisj8yF
	hWsKv7VenS8Gl+Aahd9e2Y57+nXWrQFEOeiYyklvtarhuT1qKuulSyVXMVVBk0FJuEPs8A8EFLS
	N1EwMjF6mXVSnnJFw4UnO4keirUti7
X-Received: by 2002:a05:6808:15a6:b0:3d5:64be:890f with SMTP id 5614622812f47-3d564be8c87mr6974064b6e.49.1719541191259;
        Thu, 27 Jun 2024 19:19:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwwofqbOpDvkSmww0NDTJydZp0AN9afbKh2t1W7XoMUGKRy4SuVLpPH3aktVMj0GBaaPOqCpDTYZtjp/p+Mrw=
X-Received: by 2002:a05:6808:15a6:b0:3d5:64be:890f with SMTP id
 5614622812f47-3d564be8c87mr6974036b6e.49.1719541190592; Thu, 27 Jun 2024
 19:19:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618075643.24867-1-xuanzhuo@linux.alibaba.com> <20240618075643.24867-8-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240618075643.24867-8-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 28 Jun 2024 10:19:37 +0800
Message-ID: <CACGkMEta9o97cqUy+wV=1Xpu8MBoFt4CEtWS35dhTMs0Dm4AKg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 07/10] virtio_net: xsk: rx: support fill with
 xsk buffer
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 3:57=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> Implement the logic of filling rq with XSK buffers.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 68 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 66 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 2bbc715f22c6..2ac5668a94ce 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -355,6 +355,8 @@ struct receive_queue {
>
>                 /* xdp rxq used by xsk */
>                 struct xdp_rxq_info xdp_rxq;
> +
> +               struct xdp_buff **xsk_buffs;
>         } xsk;
>  };
>
> @@ -1032,6 +1034,53 @@ static void check_sq_full_and_disable(struct virtn=
et_info *vi,
>         }
>  }
>
> +static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 len=
)
> +{
> +       sg->dma_address =3D addr;
> +       sg->length =3D len;
> +}
> +
> +static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct recei=
ve_queue *rq,
> +                                  struct xsk_buff_pool *pool, gfp_t gfp)
> +{
> +       struct xdp_buff **xsk_buffs;
> +       dma_addr_t addr;
> +       u32 len, i;
> +       int err =3D 0;
> +       int num;
> +
> +       xsk_buffs =3D rq->xsk.xsk_buffs;
> +
> +       num =3D xsk_buff_alloc_batch(pool, xsk_buffs, rq->vq->num_free);
> +       if (!num)
> +               return -ENOMEM;
> +
> +       len =3D xsk_pool_get_rx_frame_size(pool) + vi->hdr_len;
> +
> +       for (i =3D 0; i < num; ++i) {
> +               /* use the part of XDP_PACKET_HEADROOM as the virtnet hdr=
 space */
> +               addr =3D xsk_buff_xdp_get_dma(xsk_buffs[i]) - vi->hdr_len=
;

We had VIRTIO_XDP_HEADROOM, can we reuse it? Or if it's redundant
let's send a patch to switch to XDP_PACKET_HEADROOM.

Btw, the code assumes vi->hdr_len < xsk_pool_get_headroom(). It's
better to fail if it's not true when enabling xsk.

Thanks


