Return-Path: <netdev+bounces-136880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D51179A3771
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 09:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 569EF1F21A61
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 07:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25736189BAC;
	Fri, 18 Oct 2024 07:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gHNsVwtu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BEB18858C
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 07:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729237319; cv=none; b=jC0pDRCE+JiW3VMJpc/zwGz3L07ulqDed/LFvJUJxVSnrOwPdRhpk4T6lsKjB9PvDTSSMKUZIuUgPlrsvTpzfWZkvaUvH3ZGOzZQ7U8t9V/Iw6ED5Qk7NRVfFASPLpWztpbWufeqOwT9Urv9683nnNYn73fBW9jJZj0BfZ/RWfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729237319; c=relaxed/simple;
	bh=i1xZRJBWgrpcH0aJgf1ljaX4fd4iy2zjehzzIdw9nqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lyA1UXB88AqKqHPUEcETvdYxiW7uXr1S7O8sm2l7/CXCN+0h8C8STvdZxChnD4jLIzVmat7jP5TS5mEesbVMzpHg9LObfsPtdiGzmHR9PBXo+4XUrgtgdyUzSqLx1CJOQCvi2RvjII0DFmU0dP04WjEMtylQFvT6kdxG0/LCHBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gHNsVwtu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729237316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OgpoLb3anAR7m1dEnE3KC1LOh39cWkIASarOjrYla5E=;
	b=gHNsVwtuGC/5aiebpaspMviCHZFZAqlv/ivrABGsFoRF/Ubg59FzZQxQjRPygO4GY5TPrW
	8dQrBLo9z3ZkWrrk6PxA6C8zVNoG9rVpML8r2j1EfFQlGR4RrEREKhKb0O1+1UJLY7R/Pf
	3fsCFJg1lzk+VfFTiwSpeqALJpviOsU=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-wOPtga_rNBK0NGAT4ewAuQ-1; Fri, 18 Oct 2024 03:41:54 -0400
X-MC-Unique: wOPtga_rNBK0NGAT4ewAuQ-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-71e7858820eso2122822b3a.2
        for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 00:41:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729237313; x=1729842113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OgpoLb3anAR7m1dEnE3KC1LOh39cWkIASarOjrYla5E=;
        b=s4j+ITBSuKDL1s5JS7jWgiE+7fcBScNYs8HcitM2AnQNvlWFw6uzYm6zJWHXBZydMm
         E6DR5Rv8bltWdcqCyf+WBTGy5Cwh9vNmGfl2Y6txYFCHcyV4TN2Raa5twUGF57eoaV7F
         0LSP1cGVjC3cf6zwft0alWNpVwXwtuxQDitzIEuuSfjVJKNAlMV7+IcO6KK1pn6tnZ0k
         BuOZdN5A776KeZoqokFUACpXgMGFXehkkiB6argx2+6nuJdV+MuO+70N3FwEquGvb3tf
         +PqNtdTpCZtdXhbiKTOT4znNay156kpp7u4v5wGlHd+5P7CP5PK5Gjw3aQo+D5GaV/Qa
         71Mw==
X-Gm-Message-State: AOJu0YxfRxpEYbn42Fdy2VlP4xhxBvU5k/g1KCAMaB2HvBaBeDOfUuge
	u1lR60kIjsy/L3wlHcxu+X850b74DPiMXYxmIQbYHDyip7usV708dZOywiJbVW7F6Ss8tzfmCDi
	NfrHS7jMBJBWXcKD194xvh0Mi1mm9/WLNcGHN8tOKhosFfQHmGPQJzf6mIEqZoqGEFlWC2dKK7J
	gV8tJ7hD3fnP0tDOeffMAchBrrcFO8
X-Received: by 2002:a05:6a20:e617:b0:1d9:d0e:34a4 with SMTP id adf61e73a8af0-1d92c49b114mr2097908637.7.1729237313553;
        Fri, 18 Oct 2024 00:41:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2pcYYDzB9NJqpSY9ypJC2vuIgkUiPOmbEfkKe0zQbvgC/1Xv6oG624NMDoIMTA3kawRXeTZohst4+ygDUY34=
X-Received: by 2002:a05:6a20:e617:b0:1d9:d0e:34a4 with SMTP id
 adf61e73a8af0-1d92c49b114mr2097887637.7.1729237313086; Fri, 18 Oct 2024
 00:41:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014031234.7659-1-xuanzhuo@linux.alibaba.com> <20241014031234.7659-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20241014031234.7659-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 18 Oct 2024 15:41:41 +0800
Message-ID: <CACGkMEv-TYVqjP3GYx_4SmWRGMtYDFZY3s3QpV3nkgXNXhk7kQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] virtio-net: fix overflow inside virtnet_rq_alloc
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, virtualization@lists.linux.dev, 
	Si-Wei Liu <si-wei.liu@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 11:12=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
>
> When the frag just got a page, then may lead to regression on VM.
> Specially if the sysctl net.core.high_order_alloc_disable value is 1,
> then the frag always get a page when do refill.
>
> Which could see reliable crashes or scp failure (scp a file 100M in size
> to VM):
>
> The issue is that the virtnet_rq_dma takes up 16 bytes at the beginning
> of a new frag. When the frag size is larger than PAGE_SIZE,
> everything is fine. However, if the frag is only one page and the
> total size of the buffer and virtnet_rq_dma is larger than one page, an
> overflow may occur.
>
> Here, when the frag size is not enough, we reduce the buffer len to fix
> this problem.
>
> Fixes: f9dac92ba908 ("virtio_ring: enable premapped mode whatever use_dma=
_api")
> Reported-by: "Si-Wei Liu" <si-wei.liu@oracle.com>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Though this may fix the problem and we need it now, I would like to
have some tweaks in the future. Basically because of the security
implication for sharing driver metadata with the device (most IOMMU
can only do protection at the granule at the page). So we may end up
with device-triggerable behaviour. For safety, we should use driver
private memory for DMA metadata.

> ---
>  drivers/net/virtio_net.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index f8131f92a392..59a99bbaf852 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -926,9 +926,6 @@ static void *virtnet_rq_alloc(struct receive_queue *r=
q, u32 size, gfp_t gfp)
>         void *buf, *head;
>         dma_addr_t addr;
>
> -       if (unlikely(!skb_page_frag_refill(size, alloc_frag, gfp)))
> -               return NULL;
> -
>         head =3D page_address(alloc_frag->page);
>
>         if (rq->do_dma) {
> @@ -2423,6 +2420,9 @@ static int add_recvbuf_small(struct virtnet_info *v=
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
> @@ -2525,6 +2525,12 @@ static int add_recvbuf_mergeable(struct virtnet_in=
fo *vi,
>          */
>         len =3D get_mergeable_buf_len(rq, &rq->mrg_avg_pkt_len, room);
>
> +       if (unlikely(!skb_page_frag_refill(len + room, alloc_frag, gfp)))
> +               return -ENOMEM;

This makes me think of another question, how could we guarantee len +
room is less or equal to PAGE_SIZE. Especially considering we need
extra head and tailroom for XDP? If we can't it is a bug:

"""
/**
 * skb_page_frag_refill - check that a page_frag contains enough room
 * @sz: minimum size of the fragment we want to get
 * @pfrag: pointer to page_frag
 * @gfp: priority for memory allocation
 *
 * Note: While this allocator tries to use high order pages, there is
 * no guarantee that allocations succeed. Therefore, @sz MUST be
 * less or equal than PAGE_SIZE.
 */
"""

> +
> +       if (!alloc_frag->offset && len + room + sizeof(struct virtnet_rq_=
dma) > alloc_frag->size)
> +               len -=3D sizeof(struct virtnet_rq_dma);

Any reason we need to check alloc_frag->offset?

> +
>         buf =3D virtnet_rq_alloc(rq, len + room, gfp);

Btw, as pointed out in previous review, we should have a consistent API:

1) hide the alloc_frag like virtnet_rq_alloc()

or

2) pass the alloc_frag to virtnet_rq_alloc()

>         if (unlikely(!buf))
>                 return -ENOMEM;
> --
> 2.32.0.3.g01195cf9f
>

Thanks


