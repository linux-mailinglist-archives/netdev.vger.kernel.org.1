Return-Path: <netdev+bounces-126344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBFC970C2E
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 05:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A589C1F2257A
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 03:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16771422A8;
	Mon,  9 Sep 2024 03:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XX5vFK6z"
X-Original-To: netdev@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157C23D76
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 03:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725851786; cv=none; b=e96J0xPzbB5u7qHUZkDCo70c0+JY8aDPGRE/nJlEmKfZKi5KZ7raCLK4YzVIQSbcXWwj1EXJi9Tl68OBlG6oy7viQqbScL/atrM0X2pukzbllOd8lfRCieBQO2UL+cQf6BETIGpHQekPF5O0dzvDevkTjoJGw3sRudir98/sfDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725851786; c=relaxed/simple;
	bh=mHEfWUcqpqEDcwGW9qMcOoPMFUvkd9gn6ybAjDCEpIk=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=AOtWItA0IxDVOD1Gibq2rBrmB4hXLeULCn5SFzyRxeUxI5X4Cu9a0mrvic4mWHS2r+VBlLOmPuSkDYD3j1M6K0/6U00qhPvhjALJRnR346RPVVIp2lQ6ddQoRHrqyQWayPJ9eQwsfM8RSWvjkJ1Kga4StqrfQe93JVbsnkdzxVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XX5vFK6z; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725851776; h=Message-ID:Subject:Date:From:To;
	bh=ZeSNuigf8WiZfgXybb5AzOBZyCSo9n96BaNzBxxe08E=;
	b=XX5vFK6zrhm68NortTcZr70ZfcFrmb4uOf1pO3NeDvXRcJULYQWCNv0W1SxEsnI+nyu121b6V0noloRE0qsKnRtc2qJQvveQNg+cDQsQJvN7sLjhtGn/lA5FpZ01nF1S1MQiYi18rOC4R8R9hYgLQ/e0AFd/rHwjAy7Cx03snow=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WEWEqx3_1725851775)
          by smtp.aliyun-inc.com;
          Mon, 09 Sep 2024 11:16:15 +0800
Message-ID: <1725851336.7999291-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net] virtio-net: fix overflow inside virtnet_rq_alloc
Date: Mon, 9 Sep 2024 11:08:56 +0800
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
 <20240908153930-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240908153930-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Sun, 8 Sep 2024 15:40:32 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
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
> BTW why isn't it needed if we revert f9dac92ba908?


This patch fixes the bug in premapped mode.

The revert operation just disables premapped mode.

So I think this patch is enough to fix the bug, and we can enable
premapped by default.

If you worry about the premapped mode, I advice you merge this patch and do
the revert[1]. Then the bug is fixed, and the premapped mode is
disabled by default, we can just enable it for af-xdp.

[1]: http://lore.kernel.org/all/20240906123137.108741-1-xuanzhuo@linux.alibaba.com

Thanks.


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

