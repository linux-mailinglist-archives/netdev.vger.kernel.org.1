Return-Path: <netdev+bounces-80966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5582F8855BE
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 09:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9AE91F21191
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 08:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D741CD1C;
	Thu, 21 Mar 2024 08:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CrHW+3pu"
X-Original-To: netdev@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA12ADF41
	for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 08:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711009972; cv=none; b=UBUIjKTCZS7v2ldBNnuzgEdAs/YuwiWpMewqgUMZbGuqhe/+fp29mE3cZ3zJltJB30Wu9C+ajzhIdJPvKrmsM1NEBSm1TEu3ZbF5AeVnm5gn2LqA2ppREO1NlAYHZmq+BzJcIa2yhITDmEV3CXmA2sBQgj28Oz5SF7U9sRjS4Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711009972; c=relaxed/simple;
	bh=jjXZnyIwwnqHtpyXY9kprbHen6nKmOUvgl7EyNGh+2E=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=hrPBzehXESj91xbzv6Y73MxqThdHBk/DNV/rNxfFL/WS5rGPFvItmIEEVPnw5elQscghUlcSFs2Q+CG2z3J8b3N9jXbMoQyzWH4zBFWzqiLb2vr5GVBlNpTQmG+ZspWBY89vCw9pvWveB+Pi71gBRbT0703aVOlDhsp+mEWg8SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CrHW+3pu; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711009961; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=BLoHe15uKdp14O/oRqVBuqsIWpnD38/Sd4/X0Jt2YMY=;
	b=CrHW+3puIv3yfWo+Tn/BSP9ilbUaYIR4HnoJHLcN9EvT10UxhmhMbVJFpHxQHWyagwv9q3/NBNpVa8+NDaeOtwjBuw/LiWCzKmCycYlIXsIwF+EavtEI844X4xqQZS579R/1OVgv5th8m99BnuYfxQpi8azZ7w925sDHomYq/14=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R651e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W3-AsBW_1711009960;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W3-AsBW_1711009960)
          by smtp.aliyun-inc.com;
          Thu, 21 Mar 2024 16:32:40 +0800
Message-ID: <1711009827.9194505-5-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v4 00/10] virtio: drivers maintain dma info for premapped vq
Date: Thu, 21 Mar 2024 16:30:27 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux.dev,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <20240312033557.6351-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEt0O1tjJu_paVWvxUQqnq_wMv+9YmOBzFGuGLy9_0-qVA@mail.gmail.com>
In-Reply-To: <CACGkMEt0O1tjJu_paVWvxUQqnq_wMv+9YmOBzFGuGLy9_0-qVA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Thu, 21 Mar 2024 12:45:08 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Tue, Mar 12, 2024 at 11:36=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibab=
a.com> wrote:
> >
> > As discussed:
> >
> > http://lore.kernel.org/all/CACGkMEvq0No8QGC46U4mGsMtuD44fD_cfLcPaVmJ3rH=
YqRZxYg@mail.gmail.com
> >
> > If the virtio is premapped mode, the driver should manage the dma info =
by self.
> > So the virtio core should not store the dma info. We can release the me=
mory used
> > to store the dma info.
> >
> > For virtio-net xmit queue, if the virtio-net maintains the dma info,
> > the virtio-net must allocate too much memory(19 * queue_size for per-qu=
eue), so
> > we do not plan to make the virtio-net to maintain the dma info by defau=
lt. The
> > virtio-net xmit queue only maintain the dma info when premapped mode is=
 enable
> > (such as AF_XDP is enable).
> >
> > So this patch set try to do:
> >
> > 1. make the virtio core to do not store the dma info
>
> I think you mean "make the virtio core to do not store the dma info
> when driver can do that"

YES.


>
> >     - But if the desc_extra has not dma info, we face a new question,
> >       it is hard to get the dma info of the desc with indirect flag.
>
> I guess you want to avoid allocating desc_extra array, otherwise you
> won't have this issue.
>
> How about keeping that?

This is a way. But when we allocate the indirect desc, we alloc
more memory to save that, I think that is a good way.
And in the future, we can handen the unmap for the indirect buffer
with more memory allocated by once.

Thanks.


>
> >       For split mode, that is easy from desc, but for the packed mode,
> >       it is hard to get the dma info from the desc. And hardening
> >       the dma unmap is safe, we should store the dma info of indirect
> >       descs when the virtio core does not store the bufer dma info.
> >
> >       So I introduce the "structure the indirect desc table" to
> >       allocate space to store dma info of the desc table.
> >
> >         +struct vring_split_desc_indir {
> >         +       dma_addr_t addr;                /* Descriptor Array DMA=
 addr. */
> >         +       u32 len;                        /* Descriptor Array len=
gth. */
> >         +       u32 num;
>
> We can probably just reuse vring_desc_extra here with a known flag
> (read only for device).
>
> >         +       struct vring_desc desc[];
> >         +};
> >
> >       The follow patches to this:
> >          * virtio_ring: packed: structure the indirect desc table
> >          * virtio_ring: split: structure the indirect desc table
> >
> >     - On the other side, in the umap handle, we mix the indirect descs =
with
> >       other descs. That make things too complex. I found if we we disti=
nguish
> >       the descs with VRING_DESC_F_INDIRECT before unmap, thing will be =
clearer.
> >
> >       The follow patches do this.
> >          * virtio_ring: packed: remove double check of the unmap ops
> >          * virtio_ring: split: structure the indirect desc table
> >
> > 2. make the virtio core to enable premapped mode by find_vqs() params
> >     - Because the find_vqs() will try to allocate memory for the dma in=
fo.
> >       If we set the premapped mode after find_vqs() and release the
> >       dma info, that is odd.
>
> Thanks
>
> >
> >
> > Please review.
> >
> > Thanks
> >
> > v4:
> >     1. virtio-net xmit queue does not enable premapped mode by default
> >
> > v3:
> >     1. fix the conflict with the vp_modern_create_avq().
> >
> > v2:
> >     1. change the dma item of virtio-net, every item have MAX_SKB_FRAGS=
 + 2 addr + len pairs.
> >     2. introduce virtnet_sq_free_stats for __free_old_xmit
> >
> > v1:
> >     1. rename transport_vq_config to vq_transport_config
> >     2. virtio-net set dma meta number to (ring-size + 1)(MAX_SKB_FRGAS =
+2)
> >     3. introduce virtqueue_dma_map_sg_attrs
> >     4. separate vring_create_virtqueue to an independent commit
> >
> > Xuan Zhuo (10):
> >   virtio_ring: introduce vring_need_unmap_buffer
> >   virtio_ring: packed: remove double check of the unmap ops
> >   virtio_ring: packed: structure the indirect desc table
> >   virtio_ring: split: remove double check of the unmap ops
> >   virtio_ring: split: structure the indirect desc table
> >   virtio_ring: no store dma info when unmap is not needed
> >   virtio: find_vqs: add new parameter premapped
> >   virtio_ring: export premapped to driver by struct virtqueue
> >   virtio_net: set premapped mode by find_vqs()
> >   virtio_ring: virtqueue_set_dma_premapped support disable
> >
> >  drivers/net/virtio_net.c      |  57 +++--
> >  drivers/virtio/virtio_ring.c  | 436 +++++++++++++++++++++-------------
> >  include/linux/virtio.h        |   3 +-
> >  include/linux/virtio_config.h |  17 +-
> >  4 files changed, 307 insertions(+), 206 deletions(-)
> >
> > --
> > 2.32.0.3.g01195cf9f
> >
>

