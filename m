Return-Path: <netdev+bounces-125843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDEA96EE9D
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 10:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9454A1C23802
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 08:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E4915852E;
	Fri,  6 Sep 2024 08:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="UBd4s/+N"
X-Original-To: netdev@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D6315530C
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 08:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725613004; cv=none; b=sgUMFSFm2iu9H7n04oVvCgGvjkuzU8lIOX8ueR7FasKzp7N6DczZZGGn0wjQwthPSirGhruIH4NzkEealO3kCikh3kVUpMor7HL5AiHnMoHGlJQLSt1kIm1V+ToFHXUSVa1lXGlYX9zlheIm9fR7wmn8WPbsPZElNUPF7bqNFI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725613004; c=relaxed/simple;
	bh=Q27lQxPdC/WcsxAPh55+HKMzilwHU8fEKObtbbd+QRU=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=IxMpzDUao7+U8/vx2GMInuUG2nVSXiirld9Aoc36yUdTX2PYv2Uws9YTLeK2c0RTfD0CwzE45qO5WZEaU0itgx5ICMpNaikxR7PSSRNfI+pUpMYZa4s3baOLzCHVFnKMvWpVeY5pJ5/sVjWELK0EytFfKoswTX0vWGU29+VfvH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=UBd4s/+N; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725612999; h=Message-ID:Subject:Date:From:To;
	bh=d068Bcc/6yhavMQodfkCRj5m48KjO6I7qhWlY8DlH7o=;
	b=UBd4s/+NaGJwEbZrwvJo8EzKG8HkgoGKfmyps2fNH12qRCXqYkpnYbTgq+yWmYWtgYBhZzu0DQk4v4/PVR/8lc1rqpsqA54Em6LgbyjPDKqH2/i6rEEVlHl2NdzJjRKegGzV6JcneCjsNGoBDirUUgbgz/07e38oUy51cSKlZow=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WEOvTc3_1725612998)
          by smtp.aliyun-inc.com;
          Fri, 06 Sep 2024 16:56:38 +0800
Message-ID: <1725612818.815039-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net] virtio-net: fix overflow inside virtnet_rq_alloc
Date: Fri, 6 Sep 2024 16:53:38 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org,
 Jason Wang <jasowang@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux.dev,
 "Si-Wei Liu" <si-wei.liu@oracle.com>,
 Darren Kenny <darren.kenny@oracle.com>
References: <20240820071913.68004-1-xuanzhuo@linux.alibaba.com>
 <20240906044143-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240906044143-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Fri, 6 Sep 2024 04:43:29 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Tue, Aug 20, 2024 at 03:19:13PM +0800, Xuan Zhuo wrote:
> > leads to regression on VM with the sysctl value of:
> >
> > - net.core.high_order_alloc_disable=1
> >
> > which could see reliable crashes or scp failure (scp a file 100M in size
> > to VM):
> >
> > The issue is that the virtnet_rq_dma takes up 16 bytes at the beginning
> > of a new frag. When the frag size is larger than PAGE_SIZE,
> > everything is fine. However, if the frag is only one page and the
> > total size of the buffer and virtnet_rq_dma is larger than one page, an
> > overflow may occur. In this case, if an overflow is possible, I adjust
> > the buffer size. If net.core.high_order_alloc_disable=1, the maximum
> > buffer size is 4096 - 16. If net.core.high_order_alloc_disable=0, only
> > the first buffer of the frag is affected.
> >
> > Fixes: f9dac92ba908 ("virtio_ring: enable premapped mode whatever use_dma_api")
> > Reported-by: "Si-Wei Liu" <si-wei.liu@oracle.com>
> > Closes: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>
>
> Guys where are we going with this? We have a crasher right now,
> if this is not fixed ASAP I'd have to revert a ton of
> work Xuan Zhuo just did.

I think this patch can fix it and I tested it.
But Darren said this patch did not work.
I need more info about the crash that Darren encountered.

Thanks.

>
>
> > ---
> >  drivers/net/virtio_net.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index c6af18948092..e5286a6da863 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -918,9 +918,6 @@ static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
> >  	void *buf, *head;
> >  	dma_addr_t addr;
> >
> > -	if (unlikely(!skb_page_frag_refill(size, alloc_frag, gfp)))
> > -		return NULL;
> > -
> >  	head = page_address(alloc_frag->page);
> >
> >  	dma = head;
> > @@ -2421,6 +2418,9 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
> >  	len = SKB_DATA_ALIGN(len) +
> >  	      SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> >
> > +	if (unlikely(!skb_page_frag_refill(len, &rq->alloc_frag, gfp)))
> > +		return -ENOMEM;
> > +
> >  	buf = virtnet_rq_alloc(rq, len, gfp);
> >  	if (unlikely(!buf))
> >  		return -ENOMEM;
> > @@ -2521,6 +2521,12 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
> >  	 */
> >  	len = get_mergeable_buf_len(rq, &rq->mrg_avg_pkt_len, room);
> >
> > +	if (unlikely(!skb_page_frag_refill(len + room, alloc_frag, gfp)))
> > +		return -ENOMEM;
> > +
> > +	if (!alloc_frag->offset && len + room + sizeof(struct virtnet_rq_dma) > alloc_frag->size)
> > +		len -= sizeof(struct virtnet_rq_dma);
> > +
> >  	buf = virtnet_rq_alloc(rq, len + room, gfp);
> >  	if (unlikely(!buf))
> >  		return -ENOMEM;
> > --
> > 2.32.0.3.g01195cf9f
>

