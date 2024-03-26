Return-Path: <netdev+bounces-81923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1244088BB46
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 08:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 366651C307B5
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 07:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435F81311A9;
	Tue, 26 Mar 2024 07:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DvgMX8rZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DFBA954
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 07:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711438375; cv=none; b=OxTa+leWi9MDATeK5UnwVi6awn94kP0KZ1XtmUNdkgwTVi0EnrtssefUGk14BTrCaqfRYtwsC2poDp8LhJ3ftVsr6JjLy8EskBjLqCnia33+6mLjdy7peMwY60Eh+V0QPUAZ3/fDh6eIuWx21zsJHLyMyrZv8y/0Ad/R9SThWgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711438375; c=relaxed/simple;
	bh=QZY1zpBKJTgKeMl7yHZrKr0DI88L9kHK0I41SbbfbiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pjd1wEcPDEQ6181Emc4bQo81gLfI3W7QF2bHZ6EYrRgiPWzhlBy/5CHjAnKKmsbusFSqEEVGkX5ePPmAwG2iSEGp7tjOsDKHGojsdD/rybuQNcWbjEStr3Yhi0g4DWQW9OmqAg/9j2/8nZdW8mu679esHfK04ihsysI8sfOIq5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DvgMX8rZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711438372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ngtvy3dvqyLM6AWq5NHSfQeWKdAHG67CLuN1yByvAj8=;
	b=DvgMX8rZ6CZC/yXFm5OIZMpXpkp4VdrhcV0zrx2vxTvV5K966aylqcErFg4m7fSJ8kCP9T
	AQUXwPQj+BmxBX/0GTDodVGYS9ZCnxFaRF/qv40zGGl0hFavVCVCvAcYmLPllke62HeGoH
	t40oBtAXYpBjTAJvYWvgogwGJgUIK0g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-TkPieXK9P8GrR1V4ve_lHg-1; Tue, 26 Mar 2024 03:32:49 -0400
X-MC-Unique: TkPieXK9P8GrR1V4ve_lHg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4140e6bbc87so28758535e9.2
        for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 00:32:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711438368; x=1712043168;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ngtvy3dvqyLM6AWq5NHSfQeWKdAHG67CLuN1yByvAj8=;
        b=S1YTj7ZGNcIMyeibeYDv367Joq8UIMdvL/fOT1gXGIZWFCWzSEqs9++VWS0IxUALfW
         /a2yS5WLOBk8hmO8eI50A/KKJdpSjQPUilOiv98e0WJFUBBvpkqyJyhANcaB+WAJPk8c
         fnv/5sxu4/3kjpwo1jFiA+tmuAU+N/c9VdYB/QJdVL4Gg5sxU4IWyVcNAJlSLmPcNSMQ
         l1H1cdzt68S+lKlPmjeVKWSXkx/cW+UjCBCK5iWkz9v4fa7ce/cKYJvyk+ZcBj8Gf5MZ
         7Jouq47XkYfrgLtJcnsGUPOVFQ29P3u/TtFYB53WXNFTeULtp3ZW9gaQdQGrLRPiFpw6
         YMQQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0KdGxjDGR0BiX0lh+v2zYN+HiyHzOvss4IhdiJ6GeNgis3hV3WNoTiVOH5AFNnqvFOnZNwJqy1EKdBlx7eSQOocRWRlmV
X-Gm-Message-State: AOJu0YyRuIbOIDbbs9yzn/HzZ4J3uFt6xq0bBhsHTZ4Ue8BDMeB8fXDm
	w14woKEshE7YAPSkiHARPle26hQ/7jDlUjUZgrKuXtD4pY1ceS/Bi7KITs3+oTkiUxPSM5yqpgZ
	1bv7d+r+SvkfomO4nWEP8IO5Z3RA3tMS+QZ9iHSqTKTznknxCgu72FQ==
X-Received: by 2002:a05:600c:5249:b0:414:1fc:1081 with SMTP id fc9-20020a05600c524900b0041401fc1081mr1134400wmb.36.1711438368180;
        Tue, 26 Mar 2024 00:32:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEH6ByjBb9paVWMRwHR22n3GwKEgtxE156r/yuCSuhMyYRp7iX79OKWNQm74inTE0skT9WrGg==
X-Received: by 2002:a05:600c:5249:b0:414:1fc:1081 with SMTP id fc9-20020a05600c524900b0041401fc1081mr1134381wmb.36.1711438367536;
        Tue, 26 Mar 2024 00:32:47 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73e8:4f00:4a9d:49ee:c7ac:ea36])
        by smtp.gmail.com with ESMTPSA id cl1-20020a5d5f01000000b00341b9737fc5sm10439980wrb.96.2024.03.26.00.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 00:32:46 -0700 (PDT)
Date: Tue, 26 Mar 2024 03:32:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Jason Wang <jasowang@redhat.com>, virtualization@lists.linux.dev,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH vhost v4 02/10] virtio_ring: packed: remove double check
 of the unmap ops
Message-ID: <20240326033031-mutt-send-email-mst@kernel.org>
References: <20240312033557.6351-1-xuanzhuo@linux.alibaba.com>
 <20240312033557.6351-3-xuanzhuo@linux.alibaba.com>
 <CACGkMEtd1L=Cm0DWLZbfSazxxHr+iPP77B1kM=PmjdqeYoAz4w@mail.gmail.com>
 <1711009209.0488706-2-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1711009209.0488706-2-xuanzhuo@linux.alibaba.com>

On Thu, Mar 21, 2024 at 04:20:09PM +0800, Xuan Zhuo wrote:
> On Thu, 21 Mar 2024 13:57:06 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > On Tue, Mar 12, 2024 at 11:36 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > >
> > > In the functions vring_unmap_extra_packed and vring_unmap_desc_packed,
> > > multiple checks are made whether unmap is performed and whether it is
> > > INDIRECT.
> > >
> > > These two functions are usually called in a loop, and we should put the
> > > check outside the loop.
> > >
> > > And we unmap the descs with VRING_DESC_F_INDIRECT on the same path with
> > > other descs, that make the thing more complex. If we distinguish the
> > > descs with VRING_DESC_F_INDIRECT before unmap, thing will be clearer.
> > >
> > > 1. only one desc of the desc table is used, we do not need the loop
> > > 2. the called unmap api is difference from the other desc
> > > 3. the vq->premapped is not needed to check
> > > 4. the vq->indirect is not needed to check
> > > 5. the state->indir_desc must not be null
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/virtio/virtio_ring.c | 78 ++++++++++++++++++------------------
> > >  1 file changed, 40 insertions(+), 38 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > index c2779e34aac7..0dfbd17e5a87 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -1214,6 +1214,7 @@ static u16 packed_last_used(u16 last_used_idx)
> > >         return last_used_idx & ~(-(1 << VRING_PACKED_EVENT_F_WRAP_CTR));
> > >  }
> > >
> > > +/* caller must check vring_need_unmap_buffer() */
> > >  static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
> > >                                      const struct vring_desc_extra *extra)
> > >  {
> > > @@ -1221,33 +1222,18 @@ static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
> > >
> > >         flags = extra->flags;
> > >
> > > -       if (flags & VRING_DESC_F_INDIRECT) {
> > > -               if (!vq->use_dma_api)
> > > -                       return;
> > > -
> > > -               dma_unmap_single(vring_dma_dev(vq),
> > > -                                extra->addr, extra->len,
> > > -                                (flags & VRING_DESC_F_WRITE) ?
> > > -                                DMA_FROM_DEVICE : DMA_TO_DEVICE);
> > > -       } else {
> > > -               if (!vring_need_unmap_buffer(vq))
> > > -                       return;
> > > -
> > > -               dma_unmap_page(vring_dma_dev(vq),
> > > -                              extra->addr, extra->len,
> > > -                              (flags & VRING_DESC_F_WRITE) ?
> > > -                              DMA_FROM_DEVICE : DMA_TO_DEVICE);
> > > -       }
> > > +       dma_unmap_page(vring_dma_dev(vq),
> > > +                      extra->addr, extra->len,
> > > +                      (flags & VRING_DESC_F_WRITE) ?
> > > +                      DMA_FROM_DEVICE : DMA_TO_DEVICE);
> > >  }
> > >
> > > +/* caller must check vring_need_unmap_buffer() */
> > >  static void vring_unmap_desc_packed(const struct vring_virtqueue *vq,
> > >                                     const struct vring_packed_desc *desc)
> > >  {
> > >         u16 flags;
> > >
> > > -       if (!vring_need_unmap_buffer(vq))
> > > -               return;
> > > -
> > >         flags = le16_to_cpu(desc->flags);
> > >
> > >         dma_unmap_page(vring_dma_dev(vq),
> > > @@ -1323,7 +1309,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
> > >                         total_sg * sizeof(struct vring_packed_desc),
> > >                         DMA_TO_DEVICE);
> > >         if (vring_mapping_error(vq, addr)) {
> > > -               if (vq->premapped)
> > > +               if (!vring_need_unmap_buffer(vq))
> > >                         goto free_desc;
> > >
> > >                 goto unmap_release;
> > > @@ -1338,10 +1324,11 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
> > >                 vq->packed.desc_extra[id].addr = addr;
> > >                 vq->packed.desc_extra[id].len = total_sg *
> > >                                 sizeof(struct vring_packed_desc);
> > > -               vq->packed.desc_extra[id].flags = VRING_DESC_F_INDIRECT |
> > > -                                                 vq->packed.avail_used_flags;
> > >         }
> > >
> > > +       vq->packed.desc_extra[id].flags = VRING_DESC_F_INDIRECT |
> > > +               vq->packed.avail_used_flags;
> > > +
> > >         /*
> > >          * A driver MUST NOT make the first descriptor in the list
> > >          * available before all subsequent descriptors comprising
> > > @@ -1382,6 +1369,8 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
> > >  unmap_release:
> > >         err_idx = i;
> > >
> > > +       WARN_ON(!vring_need_unmap_buffer(vq));
> > > +
> > >         for (i = 0; i < err_idx; i++)
> > >                 vring_unmap_desc_packed(vq, &desc[i]);
> > >
> > > @@ -1475,12 +1464,13 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
> > >                         desc[i].len = cpu_to_le32(sg->length);
> > >                         desc[i].id = cpu_to_le16(id);
> > >
> > > -                       if (unlikely(vq->use_dma_api)) {
> > > +                       if (vring_need_unmap_buffer(vq)) {
> > >                                 vq->packed.desc_extra[curr].addr = addr;
> > >                                 vq->packed.desc_extra[curr].len = sg->length;
> > > -                               vq->packed.desc_extra[curr].flags =
> > > -                                       le16_to_cpu(flags);
> > >                         }
> > > +
> > > +                       vq->packed.desc_extra[curr].flags = le16_to_cpu(flags);
> > > +
> > >                         prev = curr;
> > >                         curr = vq->packed.desc_extra[curr].next;
> > >
> > > @@ -1530,6 +1520,8 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
> > >
> > >         vq->packed.avail_used_flags = avail_used_flags;
> > >
> > > +       WARN_ON(!vring_need_unmap_buffer(vq));
> > > +
> > >         for (n = 0; n < total_sg; n++) {
> > >                 if (i == err_idx)
> > >                         break;
> > > @@ -1599,7 +1591,9 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
> > >         struct vring_desc_state_packed *state = NULL;
> > >         struct vring_packed_desc *desc;
> > >         unsigned int i, curr;
> > > +       u16 flags;
> > >
> > > +       flags = vq->packed.desc_extra[id].flags;
> > >         state = &vq->packed.desc_state[id];
> > >
> > >         /* Clear data ptr. */
> > > @@ -1609,22 +1603,32 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
> > >         vq->free_head = id;
> > >         vq->vq.num_free += state->num;
> > >
> > > -       if (unlikely(vq->use_dma_api)) {
> > > -               curr = id;
> > > -               for (i = 0; i < state->num; i++) {
> > > -                       vring_unmap_extra_packed(vq,
> > > -                                                &vq->packed.desc_extra[curr]);
> > > -                       curr = vq->packed.desc_extra[curr].next;
> > > +       if (!(flags & VRING_DESC_F_INDIRECT)) {
> > > +               if (vring_need_unmap_buffer(vq)) {
> > > +                       curr = id;
> > > +                       for (i = 0; i < state->num; i++) {
> > > +                               vring_unmap_extra_packed(vq,
> > > +                                                        &vq->packed.desc_extra[curr]);
> > > +                               curr = vq->packed.desc_extra[curr].next;
> > > +                       }
> > >                 }
> > > -       }
> > >
> > > -       if (vq->indirect) {
> > > +               if (ctx)
> > > +                       *ctx = state->indir_desc;
> > > +       } else {
> > > +               const struct vring_desc_extra *extra;
> > >                 u32 len;
> > >
> > > +               if (vq->use_dma_api) {
> > > +                       extra = &vq->packed.desc_extra[id];
> > > +                       dma_unmap_single(vring_dma_dev(vq),
> > > +                                        extra->addr, extra->len,
> > > +                                        (flags & VRING_DESC_F_WRITE) ?
> > > +                                        DMA_FROM_DEVICE : DMA_TO_DEVICE);
> > > +               }
> >
> > Theoretically, indirect descriptors could be chained. It is supported
> > without this patch but not here.
> 
> 
> YES. But now, that is not supported by "add", so I think we
> do not need to think about it.
> 
> Thanks.


the "add" you are referring to is virtio drivers in the linux guest?
That's not the only guest and there's no way to be sure
no one does it. We can make some unusual operations go somewhat
slower but breaking them outright is not a good idea.

> >
> > Thanks
> >
> > > +
> > >                 /* Free the indirect table, if any, now that it's unmapped. */
> > >                 desc = state->indir_desc;
> > > -               if (!desc)
> > > -                       return;
> > >
> > >                 if (vring_need_unmap_buffer(vq)) {
> > >                         len = vq->packed.desc_extra[id].len;
> > > @@ -1634,8 +1638,6 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
> > >                 }
> > >                 kfree(desc);
> > >                 state->indir_desc = NULL;
> > > -       } else if (ctx) {
> > > -               *ctx = state->indir_desc;
> > >         }
> > >  }
> > >
> > > --
> > > 2.32.0.3.g01195cf9f
> > >
> >


