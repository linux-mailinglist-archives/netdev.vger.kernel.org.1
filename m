Return-Path: <netdev+bounces-128899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 895E197C5F8
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 10:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45F31284776
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 08:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC3D1990AE;
	Thu, 19 Sep 2024 08:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FhSHKF6B"
X-Original-To: netdev@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48DF198E96;
	Thu, 19 Sep 2024 08:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726734787; cv=none; b=Gi8ToADpqaY+gVn1IYWrBIfhVgCR53x51H+qisP0pnOS+FQSXwMvXnnsZ3No9vh7DQlMWEPzxYfBzGQbsuUVv0k5rxHUOwvWSmgxHDKX4ZlcJL5sxKzV9WXnk69iE3xQ/VpmFXqAeByDbLQtReWeTWr1EtF/gY/RiZbxBov/XcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726734787; c=relaxed/simple;
	bh=684nzEOeQMnyIneBwjMfQpgfVimC305CN7a+TL7f4Jo=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=Y7u7TgA+QRuN/CxsqYrmEvUioqBBRunu1nXVq+ReGIrgqHHfH06mSZHBtqit32cuyNjRVAOND+nm5179hYorAYpCzBXFLPJXyMVqgtVEvjeDCyZowP7OA7Ee4MvtsnJLqz3rs7SWsyUpvEyaKbhy+LbzFAKQl287umN7A2lyD+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FhSHKF6B; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726734776; h=Message-ID:Subject:Date:From:To;
	bh=v6dcoxxixSCFBQE1vxJtx+id0e1znHBvpVtykw+ieWs=;
	b=FhSHKF6BzgwxpK/Ozee8acF+tZ6wnlaU6dU8/4ELBx88/5Y81WBRIOCKrssglIwsqmxZrSmuvdLBi6NLsrMIwwc6tg2AryNR24LGZ87Oq7q013qyVjkmxyS/9CGRNGr2MezlN8bbWbeZf8d1mz8WRgMHIG9RdMOl4dJaJgQ5vps=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WFGzBtI_1726734774)
          by smtp.aliyun-inc.com;
          Thu, 19 Sep 2024 16:32:55 +0800
Message-ID: <1726734765.9623058-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [RESEND PATCH v3] virtio_net: Fix mismatched buf address when unmapping for small packets
Date: Thu, 19 Sep 2024 16:32:45 +0800
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
References: <20240919081351.51772-1-liwenbo.martin@bytedance.com>
In-Reply-To: <20240919081351.51772-1-liwenbo.martin@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Thu, 19 Sep 2024 16:13:51 +0800, Wenbo Li <liwenbo.martin@bytedance.com> wrote:
> Currently, the virtio-net driver will perform a pre-dma-mapping for
> small or mergeable RX buffer. But for small packets, a mismatched address
> without VIRTNET_RX_PAD and xdp_headroom is used for unmapping.
>
> That will result in unsynchronized buffers when SWIOTLB is enabled, for
> example, when running as a TDX guest.
>
> This patch unifies the address passed to the virtio core as the address of
> the virtnet header and fixes the mismatched buffer address.
>
> Changes from v2: unify the buf that passed to the virtio core in small
> and merge mode.
> Changes from v1: Use ctx to get xdp_headroom.
>
> Fixes: 295525e29a5b ("virtio_net: merge dma operations when filling mergeable buffers")
> Signed-off-by: Wenbo Li <liwenbo.martin@bytedance.com>
> Signed-off-by: Jiahui Cen <cenjiahui@bytedance.com>
> Signed-off-by: Ying Fang <fangying.tommy@bytedance.com>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Thanks.

> ---
>  drivers/net/virtio_net.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 6f4781ec2b36..f8131f92a392 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1807,6 +1807,11 @@ static struct sk_buff *receive_small(struct net_device *dev,
>  	struct page *page = virt_to_head_page(buf);
>  	struct sk_buff *skb;
>
> +	/* We passed the address of virtnet header to virtio-core,
> +	 * so truncate the padding.
> +	 */
> +	buf -= VIRTNET_RX_PAD + xdp_headroom;
> +
>  	len -= vi->hdr_len;
>  	u64_stats_add(&stats->bytes, len);
>
> @@ -2422,8 +2427,9 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
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

