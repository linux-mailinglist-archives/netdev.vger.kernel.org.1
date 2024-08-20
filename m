Return-Path: <netdev+bounces-120012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B934E957DFC
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 08:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 019631C22282
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 06:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D763C16A95F;
	Tue, 20 Aug 2024 06:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ehgnlcSh"
X-Original-To: netdev@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC6F2A1B2
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 06:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724134866; cv=none; b=M7SEmoeuAmNi2sBR47R/9BxZy86JX69XMf6qCWgXF3ExozYu0WCJKLfKqsBfEpyLQiWBeVTcQ8h56mc+gVoZNNeQEV9Y9DGXKZAs0T/CA4/vr63DuDT7o3XplWh0OV5dF044WJE3IhDIv77ejFGDHdpNoYfso3spgHVh+1VmVqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724134866; c=relaxed/simple;
	bh=HN/gqSUG72SvYiIjtM1v/nfEHRMWbyqMna1vKY9LjqM=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=CQj9bcYv9jRGIkNQy0ff1bkh1i4NLfb1jrfVXYUr8yDafmldw/hzRxIzp13fRz7AvncxTiWq05fB4geXnFnaGwZfs1phlXKopQAl01cQRJiklGfgxmX8si4f1jdGCiRF4reFQ+labSsJbxOwbhchRoRbVLwRGpPVkP5XPU++6pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ehgnlcSh; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724134855; h=Message-ID:Subject:Date:From:To;
	bh=14Pe3SLqdbqr5ua24G1iMx9ClrRaNFm8prbboqDtRjI=;
	b=ehgnlcShJ8bHEBy/XPfda85q+g2skdRyOLu3dzneKbuImd4AHHlIlEfq9/RbrcgPIcEulw9AQ8OdU+HEL5G55HllBt9KZgWxyRY9zR4zUKk7ZImPml+Mnk5Hw4KVGXrn3yaQgtakGgwxbuMajPIqS+kgSFRX1y6y1CZSP7J9qAY=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WDHX2Kv_1724134854)
          by smtp.aliyun-inc.com;
          Tue, 20 Aug 2024 14:20:54 +0800
Message-ID: <1724134768.1456072-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v5 1/4] virtio_ring: enable premapped mode whatever use_dma_api
Date: Tue, 20 Aug 2024 14:19:28 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Si-Wei Liu" <si-wei.liu@oracle.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux.dev,
 Darren Kenny <darren.kenny@oracle.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 netdev@vger.kernel.org,
 Jason Wang <jasowang@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20240511031404.30903-1-xuanzhuo@linux.alibaba.com>
 <20240511031404.30903-2-xuanzhuo@linux.alibaba.com>
 <8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com>
 <1723900832.273505-1-xuanzhuo@linux.alibaba.com>
 <b4b3df48-d0c9-df99-5c47-7b193a5f70fd@oracle.com>
In-Reply-To: <b4b3df48-d0c9-df99-5c47-7b193a5f70fd@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Mon, 19 Aug 2024 18:06:07 -0700, "Si-Wei Liu" <si-wei.liu@oracle.com> wrote:
> Hi,
>
> May I know if this is really an intended fix to post officially, or just
> a workaround/probe to make the offset in page_frag happy when
> net_high_order_alloc_disable is true? In case it's the former, even
> though this could fix the issue, I would assume clamping to a smaller
> page_frag than a regular page size for every buffer may have certain
> performance regression for the merge-able buffer case? Can you justify
> the performance impact with some benchmark runs with larger MTU and
> merge-able rx buffers to prove the regression is negligible? You would
> need to compare against where you don't have the inadvertent
> virtnet_rq_dma cost on any page i.e. getting all 4 patches of this
> series reverted. Both tests with net_high_order_alloc_disable set to on
> and off are needed.


I will post a PATCH, let we discuss under that.

Thanks.

>
> Thanks,
> -Siwei
>
> On 8/17/2024 6:20 AM, Xuan Zhuo wrote:
> > Hi, guys, I have a fix patch for this.
> > Could anybody test it?
> >
> > Thanks.
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index af474cc191d0..426d68c2d01d 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -2492,13 +2492,15 @@ static unsigned int get_mergeable_buf_len(struct receive_queue *rq,
> >   {
> >          struct virtnet_info *vi = rq->vq->vdev->priv;
> >          const size_t hdr_len = vi->hdr_len;
> > -       unsigned int len;
> > +       unsigned int len, max_len;
> > +
> > +       max_len = PAGE_SIZE - ALIGN(sizeof(struct virtnet_rq_dma), L1_CACHE_BYTES);
> >
> >          if (room)
> > -               return PAGE_SIZE - room;
> > +               return max_len - room;
> >
> >          len = hdr_len + clamp_t(unsigned int, ewma_pkt_len_read(avg_pkt_len),
> > -                               rq->min_buf_len, PAGE_SIZE - hdr_len);
> > +                               rq->min_buf_len, max_len - hdr_len);
> >
> >          return ALIGN(len, L1_CACHE_BYTES);
> >   }
>

