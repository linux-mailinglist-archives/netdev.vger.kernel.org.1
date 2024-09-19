Return-Path: <netdev+bounces-128881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3120497C4BD
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 09:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6392C1C22871
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 07:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1901922EA;
	Thu, 19 Sep 2024 07:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="v7ggCbi7"
X-Original-To: netdev@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CF820314;
	Thu, 19 Sep 2024 07:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726730229; cv=none; b=E+YtoQo9+puZzQ8e89X/fuizxi+0+p+CBmZRD4/EN8Y4pdXOB3msqSC1uc0yb53uOKy456LeJgVyjoQgra3xTrhZjK/8GignL2t1raUU9n/wGM0bOG2eDAEYSrDGFS/yarv5M5HPTfEDfjnbz+lJXEdVsM+7JFnwf1Fx97Lznxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726730229; c=relaxed/simple;
	bh=xcjpsMKI13u3WcKGB0N9zGs0tG0CLFvOvo1y6POEmoI=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=ln6gVQqo0wiWp40gcv8j3+NwTTPep/NecIUEkCSlcxZiy3Iq4UnROe4AzSlsFOhcKapHj0RfdBw5PUOxd9bHRW9RyDn6svMjIUByaUFxJFP5u+KKGq6/xKvrnNduRd+IpuiMMD/adLtL5qJIJd9LEsZ2py3Nu85yrcJS2LssPw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=v7ggCbi7; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726730224; h=Message-ID:Subject:Date:From:To;
	bh=ssL8UI9+cmR3eancWEz3OVmCqRIhQMFqE23fxOHlFWk=;
	b=v7ggCbi7ClIqsz8NhNfwwlBMpsJ6Zji4gWjGfVX4XI/rlIW5C5HUyLDnNIuudwNaLvVMOIbDl7RskQgYr1ZzHDDiu3qFxyRjXrUUSeGebPYBElZD5Mn3v0hS47Ys4xMaBqgQxg/07b7JUFJV7iJiJhF5yu9JqgENthVZhCMGo4c=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WFGjrnj_1726729904)
          by smtp.aliyun-inc.com;
          Thu, 19 Sep 2024 15:11:45 +0800
Message-ID: <1726729783.1689022-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [RESEND PATCH v3] virtio_net: Fix mismatched buf address when unmapping for small packets
Date: Thu, 19 Sep 2024 15:09:43 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Wenbo Li <liwenbo.martin@bytedance.com>
Cc: virtualization@lists.linux.dev,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Wenbo Li <liwenbo.martin@bytedance.com>,
 Jiahui Cen <cenjiahui@bytedance.com>,
 Ying Fang <fangying.tommy@bytedance.com>,
 mst@redhat.com,
 jasowang@redhat.com,
 eperezma@redhat.com,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com
References: <20240919035214.41805-1-liwenbo.martin@bytedance.com>
In-Reply-To: <20240919035214.41805-1-liwenbo.martin@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Thu, 19 Sep 2024 11:52:14 +0800, Wenbo Li <liwenbo.martin@bytedance.com> wrote:
> Currently, the virtio-net driver will perform a pre-dma-mapping for
> small or mergeable RX buffer. But for small packets, a mismatched address
> without VIRTNET_RX_PAD and xdp_headroom is used for unmapping.
>
> That will result in unsynchronized buffers when SWIOTLB is enabled, for
> example, when running as a TDX guest.
>
> This patch unifies the address passed to the virtio core into the address
> of the virtnet header and fixes the mismatched buffer address.
>
> Changes from v2: unify the buf that passed to the virtio core in small
> and merge mode.
> Changes from v1: Use ctx to get xdp_headroom.
>
> Fixes: 295525e29a5b ("virtio_net: merge dma operations when filling mergeable buffers")
> Signed-off-by: Wenbo Li <liwenbo.martin@bytedance.com>
> Signed-off-by: Jiahui Cen <cenjiahui@bytedance.com>
> Signed-off-by: Ying Fang <fangying.tommy@bytedance.com>
> ---
>  drivers/net/virtio_net.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 6f4781ec2b36..9446666c84aa 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1804,9 +1804,15 @@ static struct sk_buff *receive_small(struct net_device *dev,
>  				     struct virtnet_rq_stats *stats)
>  {
>  	unsigned int xdp_headroom = (unsigned long)ctx;
> -	struct page *page = virt_to_head_page(buf);
> +	struct page *page;

Because that here is head page, so you can keep the original code.

>  	struct sk_buff *skb;
>
> +	// We passed the address of virtnet header to virtio-core,
> +	// so truncate the padding.

Please check the kernel code style.

Thanks.

> +	buf -= VIRTNET_RX_PAD + xdp_headroom;
> +
> +	page = virt_to_head_page(buf);
> +
>  	len -= vi->hdr_len;
>  	u64_stats_add(&stats->bytes, len);
>
> @@ -2422,8 +2428,9 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
>  	if (unlikely(!buf))
>  		return -ENOMEM;
>
> -	virtnet_rq_init_one_sg(rq, buf + VIRTNET_RX_PAD + xdp_headroom,
> -			       vi->hdr_len + GOOD_PACKET_LEN);
> +	buf += VIRTNET_RX_PAD + xdp_headroom;
> +
> +	virtnet_rq_init_one_sg(rq, buf, vi->hdr_len + GOOD_PACKET_LEN);
>
>  	err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
>  	if (err < 0) {
> --
> 2.20.1
>

