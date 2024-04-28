Return-Path: <netdev+bounces-91958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F748B491E
	for <lists+netdev@lfdr.de>; Sun, 28 Apr 2024 03:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 379B628292C
	for <lists+netdev@lfdr.de>; Sun, 28 Apr 2024 01:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9558AA59;
	Sun, 28 Apr 2024 01:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uGBcETIj"
X-Original-To: netdev@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92821818
	for <netdev@vger.kernel.org>; Sun, 28 Apr 2024 01:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714267946; cv=none; b=A25HR34SoPJIGTNKXyzY75vvx689ZtIRtF6+46dViph9tWQA68TIGbHNvFpMoKV42p8Fq4L4hY3iLw6n+pSBjw4M8SswwoD8qoJJ5eQoNfHOM3BghsRYkcifIdbFA0QjxDl4nq/1W0fsdF86bLCKLNjcvAJ4AdCNCpgNz8rDLWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714267946; c=relaxed/simple;
	bh=U19vMMhqbvVELwquB6x/cQIG9Czs+9YUVs8Eff2CTis=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=P+XFYOEaD0gG+h+Gm1khUJ5LLQnVfeaQRJLjZ9UdXZWh7Hwim8o9lmzAocoVQxDXKpYWDSMPP2eHgwaqsaPvnWjGnM0TIc6UoS7XFsNxQlmVOg9PyrKHjTfGkYdDF+Lq0Wo0YlalvSoLS1Lif2EDccktO65/csGlZB667+e8eWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uGBcETIj; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714267935; h=Message-ID:Subject:Date:From:To;
	bh=yOacqscqgEf87pPtqNt5AgchD9fP++w5jWs2siOF8HU=;
	b=uGBcETIj/8ptaorU1h3JpcNq/2jacp/baPdmBcnyes6ghdxl8I8QdO7kD81VPj2Sjlvh/5K/SvgFry6ZSqnYEv102wzg7AKWGUccMGOs0NLgfGf+nFs7ff6Wx59e1DHNmYAOF1MBBJyt8MQlk7Og9y/yNlyHrDS35UQg57DGVJ8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W5MlU2l_1714267933;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W5MlU2l_1714267933)
          by smtp.aliyun-inc.com;
          Sun, 28 Apr 2024 09:32:14 +0800
Message-ID: <1714267129.6438966-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v3 0/4] virtio_net: rx enable premapped mode by default
Date: Sun, 28 Apr 2024 09:18:49 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org,
 virtualization@lists.linux.dev
References: <20240424081636.124029-1-xuanzhuo@linux.alibaba.com>
 <45002f120a57ec362459868a67af1627a22274d1.camel@redhat.com>
In-Reply-To: <45002f120a57ec362459868a67af1627a22274d1.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Fri, 26 Apr 2024 13:00:08 +0200, Paolo Abeni <pabeni@redhat.com> wrote:
> On Wed, 2024-04-24 at 16:16 +0800, Xuan Zhuo wrote:
> > Actually, for the virtio drivers, we can enable premapped mode whatever
> > the value of use_dma_api. Because we provide the virtio dma apis.
> > So the driver can enable premapped mode unconditionally.
> >
> > This patch set makes the big mode of virtio-net to support premapped mode.
> > And enable premapped mode for rx by default.
> >
> > Based on the following points, we do not use page pool to manage these
> >     pages:
> >
> >     1. virtio-net uses the DMA APIs wrapped by virtio core. Therefore,
> >        we can only prevent the page pool from performing DMA operations, and
> >        let the driver perform DMA operations on the allocated pages.
> >     2. But when the page pool releases the page, we have no chance to
> >        execute dma unmap.
> >     3. A solution to #2 is to execute dma unmap every time before putting
> >        the page back to the page pool. (This is actually a waste, we don't
> >        execute unmap so frequently.)
> >     4. But there is another problem, we still need to use page.dma_addr to
> >        save the dma address. Using page.dma_addr while using page pool is
> >        unsafe behavior.
> >     5. And we need space the chain the pages submitted once to virtio core.
> >
> >     More:
> >         https://lore.kernel.org/all/CACGkMEu=Aok9z2imB_c5qVuujSh=vjj1kx12fy9N7hqyi+M5Ow@mail.gmail.com/
> >
> > Why we do not use the page space to store the dma?
> >     http://lore.kernel.org/all/CACGkMEuyeJ9mMgYnnB42=hw6umNuo=agn7VBqBqYPd7GN=+39Q@mail.gmail.com
> >
> > Please review.
> >
> > v3:
> >     1. big mode still use the mode that virtio core does the dma map/unmap
> >
> > v2:
> >     1. make gcc happy in page_chain_get_dma()
> >         http://lore.kernel.org/all/202404221325.SX5ChRGP-lkp@intel.com
> >
> > v1:
> >     1. discussed for using page pool
> >     2. use dma sync to replace the unmap for the first page
>
> Judging by the subj prefix, this is targeting the vhost tree, right?
>
> There are a few patches landing on virtio_net on net-next, I guess
> there will be some conflict while pushing to Linux (but I haven't
> double check yet!)
>
> Perhaps you could provide a stable git branch so that both vhost and
> netdev could pull this set?

This patch set is related with the virio core, so I push this
to the vhost branch. And there is no new feature to the virtio-net.
Similar situation in the past, we pushed to the vhost branch.

I am ok to net-next or vhost. We can hear others

@Michael

Thanks.

>
> Thanks!
>
> Paolo
>

