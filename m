Return-Path: <netdev+bounces-76074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF06586C353
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 09:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A79A1F22F02
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 08:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5184DA0C;
	Thu, 29 Feb 2024 08:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b2G9eWwb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160974D9E8
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 08:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709194891; cv=none; b=I4OEehhOXxvrQ2hEhuEqRE8BNH2nzUf5c0LKaHNzG5WXENXNQqanda8MhqWOPKOVk2+FmWRb0HpPNN1rC8hq9BNzmN1rHpkmlK3of8lsQQFZI0A0i5/URBrtONN9hhVOkwzdb653fRSnyofTQeUo/bsTUYmOOoM26ci1I19QoCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709194891; c=relaxed/simple;
	bh=WU7ffeSphhs/r9s6sbUYBG4gjwSJ/QhbvB2NXAEgqLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XTzRO5dwb9Og2pLfwub2vMYIgt/5uogvYBSB8lR5oooTspgDieYM3EqHgR/P28EEHLPENMg2NmzWlwbYz2kZmtbUJTBq1rsHrD2FN9yLLVsVTF4j8G2VbGLyD9pBy+IkGwHt2vxSp8xYfWIP2i4k67vL+ErCbTDmxwUBez5r7hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b2G9eWwb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709194887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yYWjbn49/FOaKnxv8tY8E/wAWpBZLZbrgSR43I6LPzc=;
	b=b2G9eWwbOiaP+u+r7Y1X5I7GNP4K9WUvUhqAU0zunEL82nXmk7qIMh8N5A5/42poEC8vYI
	9wff97xzbf3y5DYqtPEBzLE2JPcVDnI5VkPqJ/WgbM4ZVmqc/CR+ES24G5FoudcWRuVKo2
	yW0GaAvb1BeqW4DTA2KjWUkTdLiuazA=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-H-fljDzeMNe0vqxMmpdGjg-1; Thu, 29 Feb 2024 03:21:26 -0500
X-MC-Unique: H-fljDzeMNe0vqxMmpdGjg-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2d2509eaa7fso4709471fa.0
        for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 00:21:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709194883; x=1709799683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yYWjbn49/FOaKnxv8tY8E/wAWpBZLZbrgSR43I6LPzc=;
        b=TPi+uIWWbcix0WaHvPxK/p8vQnxt8Tpzv2r+749TpVlQ5wFsHqsK/8jW17cjaBShgs
         10U3do8y/IGPvPJxXNnzQPSuD1/TjwUODSQD2rneBk/Ddll01Cdm6Alf0w/sUoe+xNUx
         K+jMWTaWetOhpiYRsbRbc6TNaJ+oh+2XKlYN5gln8Z1baVnI9aKZp6uIzk8D4tu2gCS/
         23uFe/bjSmS+ToPgGqgkBZtneoWpgUXM+Ppb997Nw///NHzWPcUfh2HD1Kd40IagF3fO
         +W0GMwjaHZFSDcj97yGCyPXzekDE98PNuio7lsz2MkT8Rgb92tVE5nB/wpBJBNV5I5Bo
         Sp0A==
X-Forwarded-Encrypted: i=1; AJvYcCXNRMUgFxnoyivrRUsINOTSmPdP9pRK/T2tPpXOUg/Hhj0W63nc4l4sqcus/XqGFObis7TnLAZjUI1iw1YSsINYpHKvCtq6
X-Gm-Message-State: AOJu0Yy+4MH8LL1Fy/2JXunvtsrPX7qEzy8XjojJfFU22G77ckSLTsSD
	ATPtR6hQtnsbQa9HjH5A2HoNGfqA/nq4EDLn5TDiEry0TthQqj+Uy76OIVJK/Fcb018DQ/iaCqU
	GqcaqShkHVPbrQAe9EGvqBRXkJwzKNtYXBXX7K+U6tmatg/Pn9flg8ASbgViqEA==
X-Received: by 2002:a05:6512:2388:b0:513:26e7:440c with SMTP id c8-20020a056512238800b0051326e7440cmr679740lfv.61.1709194883534;
        Thu, 29 Feb 2024 00:21:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHnM+zAIJHxVsYzJ0TLR9J0gKcOujhg4JzZrjGf+sjNfANqyY2DOR0YHjNv8O6HjvN3PHqhFQ==
X-Received: by 2002:a05:6512:2388:b0:513:26e7:440c with SMTP id c8-20020a056512238800b0051326e7440cmr679694lfv.61.1709194883093;
        Thu, 29 Feb 2024 00:21:23 -0800 (PST)
Received: from redhat.com ([2a02:14f:178:d6b0:a21c:61c4:2098:5db])
        by smtp.gmail.com with ESMTPSA id bt6-20020a056000080600b0033db9383e70sm1078294wrb.81.2024.02.29.00.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 00:21:22 -0800 (PST)
Date: Thu, 29 Feb 2024 03:21:14 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-um@lists.infradead.org, netdev@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org,
	kvm@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH vhost v3 00/19] virtio: drivers maintain dma info for
 premapped vq
Message-ID: <20240229031755-mutt-send-email-mst@kernel.org>
References: <20240229072044.77388-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229072044.77388-1-xuanzhuo@linux.alibaba.com>

On Thu, Feb 29, 2024 at 03:20:25PM +0800, Xuan Zhuo wrote:
> As discussed:
> http://lore.kernel.org/all/CACGkMEvq0No8QGC46U4mGsMtuD44fD_cfLcPaVmJ3rHYqRZxYg@mail.gmail.com
> 
> If the virtio is premapped mode, the driver should manage the dma info by self.
> So the virtio core should not store the dma info.
> So we can release the memory used to store the dma info.
> 
> But if the desc_extra has not dma info, we face a new question,
> it is hard to get the dma info of the desc with indirect flag.
> For split mode, that is easy from desc, but for the packed mode,
> it is hard to get the dma info from the desc. And for hardening
> the dma unmap is saft, we should store the dma info of indirect
> descs.
> 
> So I introduce the "structure the indirect desc table" to
> allocate space to store dma info with the desc table.
> 
> On the other side, we mix the descs with indirect flag
> with other descs together to share the unmap api. That
> is complex. I found if we we distinguish the descs with
> VRING_DESC_F_INDIRECT before unmap, thing will be clearer.
> 
> Because of the dma array is allocated in the find_vqs(),
> so I introduce a new parameter to find_vqs().
> 
> Note:
>     this is on the top of
>         [PATCH vhost v1] virtio: packed: fix unmap leak for indirect desc table
>         http://lore.kernel.org/all/20240223071833.26095-1-xuanzhuo@linux.alibaba.com
> 
> Please review.
> 
> Thanks
> 
> v3:
>     1. fix the conflict with the vp_modern_create_avq().

Okay but are you going to address huge memory waste all this is causing for
- people who never do zero copy
- systems where dma unmap is a nop

?

You should address all comments when you post a new version, not just
what was expedient, or alternatively tag patch as RFC and explain
in commit log that you plan to do it later.

> v2:
>     1. change the dma item of virtio-net, every item have MAX_SKB_FRAGS + 2
>         addr + len pairs.
>     2. introduce virtnet_sq_free_stats for __free_old_xmit
> 
> v1:
>     1. rename transport_vq_config to vq_transport_config
>     2. virtio-net set dma meta number to (ring-size + 1)(MAX_SKB_FRGAS +2)
>     3. introduce virtqueue_dma_map_sg_attrs
>     4. separate vring_create_virtqueue to an independent commit
> 
> 
> 
> Xuan Zhuo (19):
>   virtio_ring: introduce vring_need_unmap_buffer
>   virtio_ring: packed: remove double check of the unmap ops
>   virtio_ring: packed: structure the indirect desc table
>   virtio_ring: split: remove double check of the unmap ops
>   virtio_ring: split: structure the indirect desc table
>   virtio_ring: no store dma info when unmap is not needed
>   virtio: find_vqs: pass struct instead of multi parameters
>   virtio: vring_create_virtqueue: pass struct instead of multi
>     parameters
>   virtio: vring_new_virtqueue(): pass struct instead of multi parameters
>   virtio_ring: simplify the parameters of the funcs related to
>     vring_create/new_virtqueue()
>   virtio: find_vqs: add new parameter premapped
>   virtio_ring: export premapped to driver by struct virtqueue
>   virtio_net: set premapped mode by find_vqs()
>   virtio_ring: remove api of setting vq premapped
>   virtio_ring: introduce dma map api for page
>   virtio_ring: introduce virtqueue_dma_map_sg_attrs
>   virtio_net: unify the code for recycling the xmit ptr
>   virtio_net: rename free_old_xmit_skbs to free_old_xmit
>   virtio_net: sq support premapped mode
> 
>  arch/um/drivers/virtio_uml.c             |  31 +-
>  drivers/net/virtio_net.c                 | 283 ++++++---
>  drivers/platform/mellanox/mlxbf-tmfifo.c |  24 +-
>  drivers/remoteproc/remoteproc_virtio.c   |  31 +-
>  drivers/s390/virtio/virtio_ccw.c         |  33 +-
>  drivers/virtio/virtio_mmio.c             |  30 +-
>  drivers/virtio/virtio_pci_common.c       |  59 +-
>  drivers/virtio/virtio_pci_common.h       |   9 +-
>  drivers/virtio/virtio_pci_legacy.c       |  16 +-
>  drivers/virtio/virtio_pci_modern.c       |  38 +-
>  drivers/virtio/virtio_ring.c             | 698 ++++++++++++-----------
>  drivers/virtio/virtio_vdpa.c             |  45 +-
>  include/linux/virtio.h                   |  13 +-
>  include/linux/virtio_config.h            |  48 +-
>  include/linux/virtio_ring.h              |  82 +--
>  tools/virtio/virtio_test.c               |   4 +-
>  tools/virtio/vringh_test.c               |  28 +-
>  17 files changed, 847 insertions(+), 625 deletions(-)
> 
> --
> 2.32.0.3.g01195cf9f


