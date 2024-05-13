Return-Path: <netdev+bounces-95842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC828C3A25
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 04:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 555582810F0
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 02:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D157812F368;
	Mon, 13 May 2024 02:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hSYrJAIc"
X-Original-To: netdev@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B736F7483;
	Mon, 13 May 2024 02:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715566797; cv=none; b=LnKfAwimnOV0WS/MmEdiKAyXQ5o+3577zVuJqGARDZs44tSo1yfNdEKLzoZd8nbX3qTmkjc6FlC65VBXGvKaI0A8dDSakN/ClOOj0LR9417aUepshGRYblrBlMVb/s2G4LxoZFM1sciImdifH/JyqZjt1WbUgIajj4eVlBcPRAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715566797; c=relaxed/simple;
	bh=nLF3UxM7MjtqZfnysVw+O3InSkNqMGsxV6LviZSaZnY=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=hy1MxmZEeb1Vk8yuwYK6PPkq8TiljBCJPdscXZzypw7edqONTBleeBDSxYsTj60HQyGLPhe+tuJxu/VyO3TgPe9cy8qRXBnt4W4sQw2gLQo//LjitADE9IQZz9SRDlSGmzuQ84KDTfNAqlcFx8DAMfi8YsW7ujYH7YWo/f9Wfxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hSYrJAIc; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715566786; h=Message-ID:Subject:Date:From:To;
	bh=+Ibcgk1wyvyT1sLlBJMhxYkwNZUy81Vb4Yk6knvBeK0=;
	b=hSYrJAIch7ALWRr6LJwU9cKteYSF4qkbwNW4QOfTU/jmKS1wlcmAGQUuWzJwdtKTrlCrBe3XPB+VckXTmNOVPtkre9/MBwej6CMjO6iN6ezVS2Hao820MTDwHjLE7rscF/kYDQR5SRCPYNs8T2lR6XHUwdLH672RyzVc7vc+hQ0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W6Gqhnu_1715566783;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W6Gqhnu_1715566783)
          by smtp.aliyun-inc.com;
          Mon, 13 May 2024 10:19:45 +0800
Message-ID: <1715566739.6868987-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next] virtio_net: Fix error code in __virtnet_get_hw_stats()
Date: Mon, 13 May 2024 10:18:59 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux.dev,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <3762ac53-5911-4792-b277-1f1ead2e90a3@moroto.mountain>
In-Reply-To: <3762ac53-5911-4792-b277-1f1ead2e90a3@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Fri, 10 May 2024 15:50:45 +0300, Dan Carpenter <dan.carpenter@linaro.org> wrote:
> The virtnet_send_command_reply() function returns true on success or
> false on failure.  The "ok" variable is true/false depending on whether
> it succeeds or not.  It's up to the caller to translate the true/false
> into -EINVAL on failure or zero for success.
>
> The bug is that __virtnet_get_hw_stats() returns false for both
> errors and success.  It's not a bug, but it is confusing that the caller
> virtnet_get_hw_stats() uses an "ok" variable to store negative error
> codes.
>
> Fix the bug and clean things up so that it's clear that
> __virtnet_get_hw_stats() returns zero on success or negative error codes
> on failure.
>
> Fixes: 941168f8b40e ("virtio_net: support device stats")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

That confused me too.

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Thanks.


> ---
>  drivers/net/virtio_net.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 218a446c4c27..4fc0fcdad259 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -4016,7 +4016,7 @@ static int __virtnet_get_hw_stats(struct virtnet_info *vi,
>  					&sgs_out, &sgs_in);
>
>  	if (!ok)
> -		return ok;
> +		return -EINVAL;
>
>  	for (p = reply; p - reply < res_size; p += le16_to_cpu(hdr->size)) {
>  		hdr = p;
> @@ -4053,7 +4053,7 @@ static int virtnet_get_hw_stats(struct virtnet_info *vi,
>  	struct virtio_net_ctrl_queue_stats *req;
>  	bool enable_cvq;
>  	void *reply;
> -	int ok;
> +	int err;
>
>  	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_DEVICE_STATS))
>  		return 0;
> @@ -4100,12 +4100,12 @@ static int virtnet_get_hw_stats(struct virtnet_info *vi,
>  	if (enable_cvq)
>  		virtnet_make_stat_req(vi, ctx, req, vi->max_queue_pairs * 2, &j);
>
> -	ok = __virtnet_get_hw_stats(vi, ctx, req, sizeof(*req) * j, reply, res_size);
> +	err = __virtnet_get_hw_stats(vi, ctx, req, sizeof(*req) * j, reply, res_size);
>
>  	kfree(req);
>  	kfree(reply);
>
> -	return ok;
> +	return err;
>  }
>
>  static void virtnet_get_strings(struct net_device *dev, u32 stringset, u8 *data)
>

