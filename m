Return-Path: <netdev+bounces-80962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E09885599
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 09:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71661B2161E
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 08:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEBD5820A;
	Thu, 21 Mar 2024 08:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rBhbftjs"
X-Original-To: netdev@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9432F6D39
	for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 08:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711009353; cv=none; b=oRlQwl1VTJwsrHcri/Y/GftL+NcAz4LX4QgBq81huLu5ZWyWD83Fhlmw/MH8lbzQghZSfqJEsysftHaQGk1XqM/I+56PQndiIztoqGod2W0XFO0DpgG4ojlH6gi0sOTdOYblv/RVbG/qrBZse4GNrb1QZf6lFX2oDjOaIZDbkos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711009353; c=relaxed/simple;
	bh=e12HnyWjBaTr9DzPamqCsANaAJXVEywEnMVV83kDec0=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=MvExN1JiMZQ5VXGmTrybsWXqPrCDgEbp/Qs31bX1vLxjz4koDMMWBCEoiNVr+8ROGBsQTFMreYEV1ky346DfvPZQkAp4zBqQp5Hm1RsFhsbu0Ep05mxvFc6N5MFeT7g5m8xHqR0oHkZPXnWsNpdJXmkNZPcL2o7IjIq5JbU2H2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rBhbftjs; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711009347; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=dDhoKpuI8nb2mGpiRpMNmoSIq8PuIOk7GyjzURD6lpY=;
	b=rBhbftjspVMR2a1kY3tglCbBropHqmX3Ab3YMMtswopTJI18bQasLiKE9v9BQ6QHFbtBJ96DFcRsdl9w6R9KDLfSBWtxigpB6Ch6S8umFZ8qHS3ClTbVxo35WfjDUgl4FzdkmUEMM1FCxsaWN6zbD6d5uuJ4QPXL2XGYq5oKKcI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W3-BxKl_1711009346;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W3-BxKl_1711009346)
          by smtp.aliyun-inc.com;
          Thu, 21 Mar 2024 16:22:26 +0800
Message-ID: <1711009281.7778504-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v4 10/10] virtio_ring: virtqueue_set_dma_premapped support disable
Date: Thu, 21 Mar 2024 16:21:21 +0800
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
 <20240312033557.6351-11-xuanzhuo@linux.alibaba.com>
 <CACGkMEuM35+jDY3kQXtKNBFJi32+hVSnqDuOc2GVqX6L2hcafw@mail.gmail.com>
In-Reply-To: <CACGkMEuM35+jDY3kQXtKNBFJi32+hVSnqDuOc2GVqX6L2hcafw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Thu, 21 Mar 2024 14:02:14 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Tue, Mar 12, 2024 at 11:36=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibab=
a.com> wrote:
> >
> > Now, the API virtqueue_set_dma_premapped just support to
> > enable premapped mode.
> >
> > If we allow enabling the premapped dynamically, we should
> > make this API to support disable the premapped mode.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 34 ++++++++++++++++++++++++++--------
> >  include/linux/virtio.h       |  2 +-
> >  2 files changed, 27 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 34f4b2c0c31e..3bf69cae4965 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -2801,6 +2801,7 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
> >  /**
> >   * virtqueue_set_dma_premapped - set the vring premapped mode
> >   * @_vq: the struct virtqueue we're talking about.
> > + * @premapped: enable/disable the premapped mode.
> >   *
> >   * Enable the premapped mode of the vq.
> >   *
> > @@ -2819,9 +2820,10 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
> >   * 0: success.
> >   * -EINVAL: vring does not use the dma api, so we can not enable prema=
pped mode.
> >   */
> > -int virtqueue_set_dma_premapped(struct virtqueue *_vq)
> > +int virtqueue_set_dma_premapped(struct virtqueue *_vq, bool premapped)
>
> I think we need to document the requirement for calling this.
>
> Looking at the code, it seems it requires to stop the datapath and
> detach all the used buffers?


YES. The complete document is:

/**
 * virtqueue_set_dma_premapped - set the vring premapped mode
 * @_vq: the struct virtqueue we're talking about.
 *
 * Enable the premapped mode of the vq.
 *
 * The vring in premapped mode does not do dma internally, so the driver mu=
st
 * do dma mapping in advance. The driver must pass the dma_address through
 * dma_address of scatterlist. When the driver got a used buffer from
 * the vring, it has to unmap the dma address.
 *
 * This function must be called immediately after creating the vq, or after=
 vq
 * reset, and before adding any buffers to it.
 *
 * Caller must ensure we don't call this with other virtqueue operations
 * at the same time (except where noted).
 *
 * Returns zero or a negative error.
 * 0: success.
 * -EINVAL: vring does not use the dma api, so we can not enable premapped =
mode.
 */

Thanks


>
> Thanks
>

