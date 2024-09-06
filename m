Return-Path: <netdev+bounces-125858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8F096F02D
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 11:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6957B1C20A84
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 09:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C8115749A;
	Fri,  6 Sep 2024 09:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hXZ2fG0X"
X-Original-To: netdev@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E6713E898
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 09:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725616263; cv=none; b=kEaPY0vlRP8gF5wGhZTwyLvWVZsLvWqyF0dfgA58UBj/8uzF+8Zim+6C4qrFlsmhTi08UAD32mOzhzYGJ5RTInA0kxTHtHifu/tjRGiadvMwZag3Vh0mcm2jmvFVpfG14SXeyA4kJTpbv31BByauJ1pkiysZAt0jRYpcB3PFp9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725616263; c=relaxed/simple;
	bh=FulP6xQGnA2yuJrDsPgYML3ekBEdYsAZxuSldhcZgoU=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=LB+XplUJLwjeI0s8LK6CDfYjfWiN92sFbYHoWI5PYCBEFBO90N6Pxu7XlTLUCZYt2lVf9a/LkaOe2h/HFrmHNetboApAwAYJckrwMAtADSYGsDQ86j7SNz7fmFCJdXcs18wGSAVzY4fS34+a5+Cg+Q8g8AylwK7AiOt+Hr+MPw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hXZ2fG0X; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725616258; h=Message-ID:Subject:Date:From:To;
	bh=Wrf0ajPKHbxSWvGmqCQ5XulJYN1amTY2pB+zltMpugE=;
	b=hXZ2fG0X01zj0uEwg8x4KQ+fn3Y+caH57PsUbvEMYomiflMUPTCv4xmTcOqzoSyKl2vkCP5F9ObznEdHFrAosFOyFKgDtaIvNb35t3uZeDeUPzjbN4Sky1pIryOMUPopxSsHh+Td+1kYXTd1tnqEihPhBOVdy3+bpfkyEDSHek8=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WEP91UP_1725616257)
          by smtp.aliyun-inc.com;
          Fri, 06 Sep 2024 17:50:58 +0800
Message-ID: <1725615962.9178205-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net] virtio-net: fix overflow inside virtnet_rq_alloc
Date: Fri, 6 Sep 2024 17:46:02 +0800
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
 <1725612818.815039-1-xuanzhuo@linux.alibaba.com>
 <20240906045904-mutt-send-email-mst@kernel.org>
 <1725614736.9464588-1-xuanzhuo@linux.alibaba.com>
 <20240906053922-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240906053922-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Fri, 6 Sep 2024 05:44:27 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Fri, Sep 06, 2024 at 05:25:36PM +0800, Xuan Zhuo wrote:
> > On Fri, 6 Sep 2024 05:08:56 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > On Fri, Sep 06, 2024 at 04:53:38PM +0800, Xuan Zhuo wrote:
> > > > On Fri, 6 Sep 2024 04:43:29 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > > On Tue, Aug 20, 2024 at 03:19:13PM +0800, Xuan Zhuo wrote:
> > > > > > leads to regression on VM with the sysctl value of:
> > > > > >
> > > > > > - net.core.high_order_alloc_disable=1
> > > > > >
> > > > > > which could see reliable crashes or scp failure (scp a file 100M in size
> > > > > > to VM):
> > > > > >
> > > > > > The issue is that the virtnet_rq_dma takes up 16 bytes at the beginning
> > > > > > of a new frag. When the frag size is larger than PAGE_SIZE,
> > > > > > everything is fine. However, if the frag is only one page and the
> > > > > > total size of the buffer and virtnet_rq_dma is larger than one page, an
> > > > > > overflow may occur. In this case, if an overflow is possible, I adjust
> > > > > > the buffer size. If net.core.high_order_alloc_disable=1, the maximum
> > > > > > buffer size is 4096 - 16. If net.core.high_order_alloc_disable=0, only
> > > > > > the first buffer of the frag is affected.
> > > > > >
> > > > > > Fixes: f9dac92ba908 ("virtio_ring: enable premapped mode whatever use_dma_api")
> > > > > > Reported-by: "Si-Wei Liu" <si-wei.liu@oracle.com>
> > > > > > Closes: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com
> > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > >
> > > > >
> > > > > Guys where are we going with this? We have a crasher right now,
> > > > > if this is not fixed ASAP I'd have to revert a ton of
> > > > > work Xuan Zhuo just did.
> > > >
> > > > I think this patch can fix it and I tested it.
> > > > But Darren said this patch did not work.
> > > > I need more info about the crash that Darren encountered.
> > > >
> > > > Thanks.
> > >
> > > So what are we doing? Revert the whole pile for now?
> > > Seems to be a bit of a pity, but maybe that's the best we can do
> > > for this release.
> >
> > @Jason Could you review this?
> >
> > I think this problem is clear, though I do not know why it did not work
> > for Darren.
> >
> > Thanks.
> >
>
> No regressions is a hard rule. If we can't figure out the regression
> now, we should revert and you can try again for the next release.

I see. I think I fixed it.

Hope Darren can reply before you post the revert patches.

Thanks.


>
>
> > >
> > >
> > > > >
> > > > >
> > > > > > ---
> > > > > >  drivers/net/virtio_net.c | 12 +++++++++---
> > > > > >  1 file changed, 9 insertions(+), 3 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > > index c6af18948092..e5286a6da863 100644
> > > > > > --- a/drivers/net/virtio_net.c
> > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > @@ -918,9 +918,6 @@ static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
> > > > > >  	void *buf, *head;
> > > > > >  	dma_addr_t addr;
> > > > > >
> > > > > > -	if (unlikely(!skb_page_frag_refill(size, alloc_frag, gfp)))
> > > > > > -		return NULL;
> > > > > > -
> > > > > >  	head = page_address(alloc_frag->page);
> > > > > >
> > > > > >  	dma = head;
> > > > > > @@ -2421,6 +2418,9 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
> > > > > >  	len = SKB_DATA_ALIGN(len) +
> > > > > >  	      SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> > > > > >
> > > > > > +	if (unlikely(!skb_page_frag_refill(len, &rq->alloc_frag, gfp)))
> > > > > > +		return -ENOMEM;
> > > > > > +
> > > > > >  	buf = virtnet_rq_alloc(rq, len, gfp);
> > > > > >  	if (unlikely(!buf))
> > > > > >  		return -ENOMEM;
> > > > > > @@ -2521,6 +2521,12 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
> > > > > >  	 */
> > > > > >  	len = get_mergeable_buf_len(rq, &rq->mrg_avg_pkt_len, room);
> > > > > >
> > > > > > +	if (unlikely(!skb_page_frag_refill(len + room, alloc_frag, gfp)))
> > > > > > +		return -ENOMEM;
> > > > > > +
> > > > > > +	if (!alloc_frag->offset && len + room + sizeof(struct virtnet_rq_dma) > alloc_frag->size)
> > > > > > +		len -= sizeof(struct virtnet_rq_dma);
> > > > > > +
> > > > > >  	buf = virtnet_rq_alloc(rq, len + room, gfp);
> > > > > >  	if (unlikely(!buf))
> > > > > >  		return -ENOMEM;
> > > > > > --
> > > > > > 2.32.0.3.g01195cf9f
> > > > >
> > >
>

