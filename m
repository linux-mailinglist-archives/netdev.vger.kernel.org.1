Return-Path: <netdev+bounces-105167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 460FB90FF0E
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 10:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E322E1F268AA
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 08:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7F71990C0;
	Thu, 20 Jun 2024 08:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FTu61AyA"
X-Original-To: netdev@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA583A1AC;
	Thu, 20 Jun 2024 08:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718872787; cv=none; b=GK+vTXsNAwnrKR4RFRlBUn/WhSzMLYJ9UGaODdJSQ8w24S98IT3a/IjAY2zUo0bNiEY5YM+y+SUrYJ6AMQIc2h85sHHvblmYrOZZl2deBs5AwCqBKqnml6KLMyu5PXPHkmjhaLV9rebq3UXS9VeSo1406K/R7u+DnMHz4jOC4oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718872787; c=relaxed/simple;
	bh=ZrwZHFV+13ewVv1PIPqaUmU6Uz5D5zivApM1jrH5YHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bi3Gn86qL4yrvqaDW9DRxOywTy8X9KEcaAzJOeH94Z9tYMRsFM2VeSlMp9LEmF5WvvIjxT9IdLJLZlx+liT9eOKCZqd3Ll0/xigWaTtCxtw5PieBVdbl/dqyD51Z5tQ+dk2eFth5LUbgcoUaoRlfuilAfju19Rdek0Gs7qQZh+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FTu61AyA; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718872781; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=hBHfXWhYwtiI+dnajvheMQQED9ly6NUkKrwTjHsfaKk=;
	b=FTu61AyA0kUYSK0o62iJ2o1Q+PNe38Bims6OfnBVi2uEI/TfA4W373USMWFAAGYPD38hi4f6bCwD/wmdb0ra3u09o7lu/Sqzaozh0FH65yYlmq89fzOyhvfvs9xx4+ejgArvaMMA9MCFL0/IHs3bkItRyEkm7E5kqJvza1emSWA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R341e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W8qghtv_1718872459;
Received: from 30.221.149.144(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W8qghtv_1718872459)
          by smtp.aliyun-inc.com;
          Thu, 20 Jun 2024 16:34:22 +0800
Message-ID: <36b94f6f-befb-45d5-b56a-9871b10c2b0f@linux.alibaba.com>
Date: Thu, 20 Jun 2024 16:34:18 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: virtio: unify code to init stats
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 Jiri Pirko <jiri@resnulli.us>, linux-kernel@vger.kernel.org
References: <fb91a4ec2224c36adda854314940304d708d59ef.1718869408.git.mst@redhat.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <fb91a4ec2224c36adda854314940304d708d59ef.1718869408.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2024/6/20 下午3:44, Michael S. Tsirkin 写道:
> Moving initialization of stats structure into
> __free_old_xmit reduces the code size slightly.
> It also makes it clearer that this function shouldn't
> be called multiple times on the same stats struct.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>
> Especially important now that Jiri's patch for BQL has been merged.
> Lightly tested.
>
>   drivers/net/virtio_net.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 283b34d50296..c2ce8de340f7 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -383,6 +383,8 @@ static void __free_old_xmit(struct send_queue *sq, bool in_napi,
>   	unsigned int len;
>   	void *ptr;
>   
> +	stats->bytes = stats->packets = 0;
> +
>   	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
>   		++stats->packets;
>   
> @@ -828,7 +830,7 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
>   
>   static void free_old_xmit(struct send_queue *sq, bool in_napi)
>   {
> -	struct virtnet_sq_free_stats stats = {0};
> +	struct virtnet_sq_free_stats stats;
>   
>   	__free_old_xmit(sq, in_napi, &stats);
>   
> @@ -979,7 +981,7 @@ static int virtnet_xdp_xmit(struct net_device *dev,
>   			    int n, struct xdp_frame **frames, u32 flags)
>   {
>   	struct virtnet_info *vi = netdev_priv(dev);
> -	struct virtnet_sq_free_stats stats = {0};
> +	struct virtnet_sq_free_stats stats;
>   	struct receive_queue *rq = vi->rq;
>   	struct bpf_prog *xdp_prog;
>   	struct send_queue *sq;

Reviewed-by: Heng Qi <hengqi@linux.alibaba.com>

Thanks.



