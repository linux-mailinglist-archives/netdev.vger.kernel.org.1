Return-Path: <netdev+bounces-114528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2827D942D47
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 13:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C73AB1F212A8
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 11:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A42191F8C;
	Wed, 31 Jul 2024 11:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LRhbC/PL"
X-Original-To: netdev@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798358BFF
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 11:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722425481; cv=none; b=EzseIWk2IuO3o7rCdgtyKOywc9NGjAEaNuI9t760CJe20Eaw065RNTEYnRpAg4xwnne9fpA6qbsKtQIJE8A/fgepXB2QvWNlP4krgXGQPE5Zik3HNhBAT9itWaSh6+HKJx4XDqG84X+7ZlDKDQluiUlNdxjdpxnipM5cE+FeXFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722425481; c=relaxed/simple;
	bh=vwrjvpashV7Ts6cGhVvQN/od+tR6TyWff2zbZvPakr8=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=bTAKCGmfX9ZDYVzzEkqrYBoxmgoAYoHtp05tw1DQs4azA52GpWQ5S/65VJTtdCAAcv72+R7jX4r0B7TlTnWQp3UomyUx6kL4SZ2xPnX23+mSdt54csxGCUGcfxJSqmkYR36fQHc2LBCelwN3l+AiXhgURKlWx/GX/RVOM+xJf40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LRhbC/PL; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722425471; h=Message-ID:Subject:Date:From:To;
	bh=GhCYCnb3PTVULPeLefA/NMyDoPeg4ruRf4uoK4eeqJE=;
	b=LRhbC/PLnotNVAu7lNR6oQNkmppyA0yppN//FuS1dvI/UkX23TLWscbkoxZE7ih0CKQj8TiTD/ka5ft7faw7K3wKFwlGR1jE1r1p3SHfrzpQZen349mfhU0S4aIYi8jveBvhZIVwRxidBGbQ+8lE0GF97Drqx6VCFfI3EO9I7d8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0WBjLH2Y_1722425469;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0WBjLH2Y_1722425469)
          by smtp.aliyun-inc.com;
          Wed, 31 Jul 2024 19:31:10 +0800
Message-ID: <1722425431.2357254-1-hengqi@linux.alibaba.com>
Subject: Re: [PATCH net] virtio_net: Avoid sending unnecessary vq coalescing commands
Date: Wed, 31 Jul 2024 19:30:31 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 virtualization@lists.linux.dev,
 =?utf-8?q?EugenioP=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20240729124755.35719-1-hengqi@linux.alibaba.com>
 <20240730182020.75639070@kernel.org>
In-Reply-To: <20240730182020.75639070@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Tue, 30 Jul 2024 18:20:20 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> On Mon, 29 Jul 2024 20:47:55 +0800 Heng Qi wrote:
> > Subject: [PATCH net] virtio_net: Avoid sending unnecessary vq coalescing commands
> 
> subject currently reads like this is an optimization, could you
> rephrase?

Jason's rephrase will be used.

> 
> > From the virtio spec:
> > 
> > 	The driver MUST have negotiated the VIRTIO_NET_F_VQ_NOTF_COAL
> > 	feature when issuing commands VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET
> > 	and VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET.
> > 
> > The driver must not send vq notification coalescing commands if
> > VIRTIO_NET_F_VQ_NOTF_COAL is not negotiated. This limitation of course
> > applies to vq resize.
> > 
> > Fixes: f61fe5f081cf ("virtio-net: fix the vq coalescing setting for vq resize")
> > Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > ---
> >  drivers/net/virtio_net.c | 29 +++++++++++++++++------------
> >  1 file changed, 17 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 0383a3e136d6..eb115e807882 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -3708,6 +3708,7 @@ static int virtnet_set_ringparam(struct net_device *dev,
> >  	u32 rx_pending, tx_pending;
> >  	struct receive_queue *rq;
> >  	struct send_queue *sq;
> > +	u32 pkts, usecs;
> >  	int i, err;
> >  
> >  	if (ring->rx_mini_pending || ring->rx_jumbo_pending)
> > @@ -3740,11 +3741,13 @@ static int virtnet_set_ringparam(struct net_device *dev,
> >  			 * through the VIRTIO_NET_CTRL_NOTF_COAL_TX_SET command, or, if the driver
> >  			 * did not set any TX coalescing parameters, to 0.
> >  			 */
> > -			err = virtnet_send_tx_ctrl_coal_vq_cmd(vi, i,
> > -							       vi->intr_coal_tx.max_usecs,
> > -							       vi->intr_coal_tx.max_packets);
> > -			if (err)
> > -				return err;
> > +			if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL)) {
> > +				usecs = vi->intr_coal_tx.max_usecs;
> > +				pkts = vi->intr_coal_tx.max_packets;
> > +				err = virtnet_send_tx_ctrl_coal_vq_cmd(vi, i, usecs, pkts);
> > +				if (err)
> > +					return err;
> 
> Can you check the feature inside the
> virtnet_send_.x_ctrl_coal_vq_cmd() helpers?
> 5 levels of indentation is a bit much

Makes sense. Will update in the next version.

Thanks.

> -- 
> pw-bot: cr

