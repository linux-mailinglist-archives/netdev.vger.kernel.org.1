Return-Path: <netdev+bounces-80940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DF5881C04
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 05:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 386721C2160F
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 04:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1AE2AF19;
	Thu, 21 Mar 2024 04:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PQ35jNR+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BC83A27E
	for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 04:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710996326; cv=none; b=qKyRbvSip7zFoPqTI2HnG3aKuTnp+glZiPiwyMQhjB0a2QWmdlfk/82lE6vm8xTBO6n26wbzPdlRsQMHCRq0dEHos5Ke3MD7xr+hpxf2bdfh1vnGNCHat7pO/lfda7vKQSSu4DiARwYGQiKY/JqQtaMwwWWhi7gF9K+DaculXRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710996326; c=relaxed/simple;
	bh=SxCsvT/GRyu/rn5q7M36vN+zwqDkQMsgVTcUheY6AxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O7yPCEduYyEgrwfcknpuCiMu+IvvGDJXQwlwjgCe+cDydT/lnqwhs/ChV0Oz3rqc9caGMtfJkNrbvNyk/HOmUjgbSR9dH4NRYYoN7sV7Kee4BtJtUGYg3f48dV6ishmnblvI16I/cObgn8BSS429ej8TklCqJIA5sFu1s/iaS/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PQ35jNR+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710996323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wH8/VeorvE4c7PulO3VQxftUYl5zGgQdm4ZFfmXkP9U=;
	b=PQ35jNR+IKZ5asu4lxDWlf+IfPIk6lbCEpMOLrEO/mvpZeu8EwOEvhdxMrw4BWptyt8CYo
	+CueMqQOujVlwgLcXAkRtn92qlYcC7Rhi/CKKypmGqirWY3VD2EXIUX8/vxFTyY6MtcgqI
	h4ieoPXL2A6ims21P8MnNTzcXJgGEXg=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-NZ5ukrXUNUWj6CkQo2b05A-1; Thu, 21 Mar 2024 00:45:20 -0400
X-MC-Unique: NZ5ukrXUNUWj6CkQo2b05A-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5cfda2f4716so308663a12.3
        for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 21:45:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710996319; x=1711601119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wH8/VeorvE4c7PulO3VQxftUYl5zGgQdm4ZFfmXkP9U=;
        b=nPTi9cyrLiHmVns+TRgNqyAHeFka/1v014ip9q7UCF6Jtqt1Cic4YTzBl+PU1TPZuS
         HG8AR3L3NTwfDc64S2n4O4Dviw4ebFUujH+aFtYsygreXPNsg6zgjTAwvYjo6+Iv57fF
         slmK23kQBmA2gmCvnZbSC59Ofl0V9hyE6+47fgQfzFx50AtgAQtmUCLw+nRh3HMH5h1m
         fQLikEFPGvDawTY8IP+2lHZYCIq5db7TAl5Mbd8e6bgN1kFCcV6/svXFnNgTwbWU7uKR
         K49vLcn9iz9TeUDfAZyhsdebZCWHba+c3K7Q0MtRsTfvbG94L3SLpKY4tCzBIYb0NE7R
         3sHg==
X-Forwarded-Encrypted: i=1; AJvYcCWu4dxjFjiHWh37ABCbEpx9ql7Ol5XBz2Y8qy+hm0vvugMtDRc0nHlFyhmrWKMdL2dJ73ckqDroPwBShOhn6dgN4+AosLYn
X-Gm-Message-State: AOJu0YwW8N0YB38zCZlf0BYcsxZRVF70SgXHKyyMj8j0gQSysmXTWxvP
	8vK3dOBC/9H/ITIkypeFSxaYeDz7TOH/j/KnMWDd6qxOHvaOI3A/1V5pJOvTAvhSDvXaaFfCZwC
	58dxRx6N8QJ+gVibCxKJR9mKpjnHrjSM/EMQxbTktVtxtnrU89rpaV6+pII6BCR/jsRQKj8FfBo
	BX5bAQbP4a0jouem9r5JaYYmNaxxto
X-Received: by 2002:a17:90a:aa81:b0:29d:f581:3c60 with SMTP id l1-20020a17090aaa8100b0029df5813c60mr1014613pjq.36.1710996319180;
        Wed, 20 Mar 2024 21:45:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRE9khlq2ZW2iQRjrQwZ1H4ruuk3IJR+sGr7WWqhgjUWdbekOfDA/isAkj6GJmvZWnqEcQolXyMdwaB+6uLjM=
X-Received: by 2002:a17:90a:aa81:b0:29d:f581:3c60 with SMTP id
 l1-20020a17090aaa8100b0029df5813c60mr1014600pjq.36.1710996318883; Wed, 20 Mar
 2024 21:45:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312033557.6351-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240312033557.6351-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 21 Mar 2024 12:45:08 +0800
Message-ID: <CACGkMEt0O1tjJu_paVWvxUQqnq_wMv+9YmOBzFGuGLy9_0-qVA@mail.gmail.com>
Subject: Re: [PATCH vhost v4 00/10] virtio: drivers maintain dma info for
 premapped vq
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 11:36=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
>
> As discussed:
>
> http://lore.kernel.org/all/CACGkMEvq0No8QGC46U4mGsMtuD44fD_cfLcPaVmJ3rHYq=
RZxYg@mail.gmail.com
>
> If the virtio is premapped mode, the driver should manage the dma info by=
 self.
> So the virtio core should not store the dma info. We can release the memo=
ry used
> to store the dma info.
>
> For virtio-net xmit queue, if the virtio-net maintains the dma info,
> the virtio-net must allocate too much memory(19 * queue_size for per-queu=
e), so
> we do not plan to make the virtio-net to maintain the dma info by default=
. The
> virtio-net xmit queue only maintain the dma info when premapped mode is e=
nable
> (such as AF_XDP is enable).
>
> So this patch set try to do:
>
> 1. make the virtio core to do not store the dma info

I think you mean "make the virtio core to do not store the dma info
when driver can do that"

>     - But if the desc_extra has not dma info, we face a new question,
>       it is hard to get the dma info of the desc with indirect flag.

I guess you want to avoid allocating desc_extra array, otherwise you
won't have this issue.

How about keeping that?

>       For split mode, that is easy from desc, but for the packed mode,
>       it is hard to get the dma info from the desc. And hardening
>       the dma unmap is safe, we should store the dma info of indirect
>       descs when the virtio core does not store the bufer dma info.
>
>       So I introduce the "structure the indirect desc table" to
>       allocate space to store dma info of the desc table.
>
>         +struct vring_split_desc_indir {
>         +       dma_addr_t addr;                /* Descriptor Array DMA a=
ddr. */
>         +       u32 len;                        /* Descriptor Array lengt=
h. */
>         +       u32 num;

We can probably just reuse vring_desc_extra here with a known flag
(read only for device).

>         +       struct vring_desc desc[];
>         +};
>
>       The follow patches to this:
>          * virtio_ring: packed: structure the indirect desc table
>          * virtio_ring: split: structure the indirect desc table
>
>     - On the other side, in the umap handle, we mix the indirect descs wi=
th
>       other descs. That make things too complex. I found if we we disting=
uish
>       the descs with VRING_DESC_F_INDIRECT before unmap, thing will be cl=
earer.
>
>       The follow patches do this.
>          * virtio_ring: packed: remove double check of the unmap ops
>          * virtio_ring: split: structure the indirect desc table
>
> 2. make the virtio core to enable premapped mode by find_vqs() params
>     - Because the find_vqs() will try to allocate memory for the dma info=
.
>       If we set the premapped mode after find_vqs() and release the
>       dma info, that is odd.

Thanks

>
>
> Please review.
>
> Thanks
>
> v4:
>     1. virtio-net xmit queue does not enable premapped mode by default
>
> v3:
>     1. fix the conflict with the vp_modern_create_avq().
>
> v2:
>     1. change the dma item of virtio-net, every item have MAX_SKB_FRAGS +=
 2 addr + len pairs.
>     2. introduce virtnet_sq_free_stats for __free_old_xmit
>
> v1:
>     1. rename transport_vq_config to vq_transport_config
>     2. virtio-net set dma meta number to (ring-size + 1)(MAX_SKB_FRGAS +2=
)
>     3. introduce virtqueue_dma_map_sg_attrs
>     4. separate vring_create_virtqueue to an independent commit
>
> Xuan Zhuo (10):
>   virtio_ring: introduce vring_need_unmap_buffer
>   virtio_ring: packed: remove double check of the unmap ops
>   virtio_ring: packed: structure the indirect desc table
>   virtio_ring: split: remove double check of the unmap ops
>   virtio_ring: split: structure the indirect desc table
>   virtio_ring: no store dma info when unmap is not needed
>   virtio: find_vqs: add new parameter premapped
>   virtio_ring: export premapped to driver by struct virtqueue
>   virtio_net: set premapped mode by find_vqs()
>   virtio_ring: virtqueue_set_dma_premapped support disable
>
>  drivers/net/virtio_net.c      |  57 +++--
>  drivers/virtio/virtio_ring.c  | 436 +++++++++++++++++++++-------------
>  include/linux/virtio.h        |   3 +-
>  include/linux/virtio_config.h |  17 +-
>  4 files changed, 307 insertions(+), 206 deletions(-)
>
> --
> 2.32.0.3.g01195cf9f
>


