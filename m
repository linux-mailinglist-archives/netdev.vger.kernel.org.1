Return-Path: <netdev+bounces-124838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C20C96B216
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 08:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E8F22894DF
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 06:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73632145B0B;
	Wed,  4 Sep 2024 06:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="WHUSG3RD"
X-Original-To: netdev@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626C8145A09;
	Wed,  4 Sep 2024 06:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725432385; cv=none; b=VsaMEJRBoYyyg4OIkUwbIU3eJXJJAGEdNSWiroQrVrjBgLnbHnSS8uekCF00PSgHlzrbqM/GfDj4KAcoo+plSnAgcukfu6TCH0seTNtV4ADL0wfZtfWixgS0wGX2G2mXFKoNJ9Mt7FTW9l3Qr4vi5CiHGVQYc7uuRtBaTP6c/lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725432385; c=relaxed/simple;
	bh=5f/PYhXt0RMma+L76lP1Tn8q8D2Khez0KEbRlwxSaFA=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=U4ozU6QO1HblHse1ckpoM1xi43WNrDFrpMUs//haYXPr/7RdqlTx3z9M82cUpmWcybxZHT0g7cIhZbyGGsHmxZ99Cs8I/RHCJ5uGwgtropdBWNNoNBkUcQPaOgHEytnrL0oaf3g5HadFajqtUeWQydLT/0RQ+H9iwvui9IxqLps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=WHUSG3RD; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725432373; h=Message-ID:Subject:Date:From:To;
	bh=Y22uid/xR/mynPf9pRoIZffXD1FEymenAoEvZ++51sg=;
	b=WHUSG3RD0J3fmM69H75As0Sa4Wbbb+Lza4m4Jtq2AIjx8wH/zAXvY1t845g/GD/bzk0zMCJl6CBHtywmCWtaAEZsuEuI5XnSY5qB+APozpRjSpUddok9xcifoTINx7vpwRujS27QYjpH/zfOQK8E7bzKE6ZT3/HIvWyP/3g/2ac=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WEGR9Ak_1725432372)
          by smtp.aliyun-inc.com;
          Wed, 04 Sep 2024 14:46:13 +0800
Message-ID: <1725432304.274084-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v2] virtio_net: Fix mismatched buf address when unmapping for small packets
Date: Wed, 4 Sep 2024 14:45:04 +0800
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
References: <20240904061009.90785-1-liwenbo.martin@bytedance.com>
In-Reply-To: <20240904061009.90785-1-liwenbo.martin@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Wed,  4 Sep 2024 14:10:09 +0800, Wenbo Li <liwenbo.martin@bytedance.com> wrote:
> Currently, the virtio-net driver will perform a pre-dma-mapping for
> small or mergeable RX buffer. But for small packets, a mismatched address
> without VIRTNET_RX_PAD and xdp_headroom is used for unmapping.

Will used virt_to_head_page(), so could you say more about it?

	struct page *page = virt_to_head_page(buf);

Thanks.

>
> That will result in unsynchronized buffers when SWIOTLB is enabled, for
> example, when running as a TDX guest.
>
> This patch handles small and mergeable packets separately and fixes
> the mismatched buffer address.
>
> Changes from v1: Use ctx to get xdp_headroom.
>
> Fixes: 295525e29a5b ("virtio_net: merge dma operations when filling mergeable buffers")
> Signed-off-by: Wenbo Li <liwenbo.martin@bytedance.com>
> Signed-off-by: Jiahui Cen <cenjiahui@bytedance.com>
> Signed-off-by: Ying Fang <fangying.tommy@bytedance.com>
> ---
>  drivers/net/virtio_net.c | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index c6af18948..cbc3c0ae4 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -891,6 +891,23 @@ static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void **ctx)
>  	return buf;
>  }
>
> +static void *virtnet_rq_get_buf_small(struct receive_queue *rq,
> +				      u32 *len,
> +				      void **ctx,
> +				      unsigned int header_offset)
> +{
> +	void *buf;
> +	unsigned int xdp_headroom;
> +
> +	buf = virtqueue_get_buf_ctx(rq->vq, len, ctx);
> +	if (buf) {
> +		xdp_headroom = (unsigned long)*ctx;
> +		virtnet_rq_unmap(rq, buf + VIRTNET_RX_PAD + xdp_headroom, *len);
> +	}
> +
> +	return buf;
> +}
> +
>  static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *buf, u32 len)
>  {
>  	struct virtnet_rq_dma *dma;
> @@ -2692,13 +2709,23 @@ static int virtnet_receive_packets(struct virtnet_info *vi,
>  	int packets = 0;
>  	void *buf;
>
> -	if (!vi->big_packets || vi->mergeable_rx_bufs) {
> +	if (vi->mergeable_rx_bufs) {
>  		void *ctx;
>  		while (packets < budget &&
>  		       (buf = virtnet_rq_get_buf(rq, &len, &ctx))) {
>  			receive_buf(vi, rq, buf, len, ctx, xdp_xmit, stats);
>  			packets++;
>  		}
> +	} else if (!vi->big_packets) {
> +		void *ctx;
> +		unsigned int xdp_headroom = virtnet_get_headroom(vi);
> +		unsigned int header_offset = VIRTNET_RX_PAD + xdp_headroom;
> +
> +		while (packets < budget &&
> +		       (buf = virtnet_rq_get_buf_small(rq, &len, &ctx, header_offset))) {
> +			receive_buf(vi, rq, buf, len, ctx, xdp_xmit, stats);
> +			packets++;
> +		}
>  	} else {
>  		while (packets < budget &&
>  		       (buf = virtqueue_get_buf(rq->vq, &len)) != NULL) {
> --
> 2.20.1
>

