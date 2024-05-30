Return-Path: <netdev+bounces-99282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 151098D4462
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 05:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7727285647
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 03:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7F5142E73;
	Thu, 30 May 2024 03:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mJL20TPn"
X-Original-To: netdev@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD56142E6F
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 03:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717041482; cv=none; b=tjka4hrASoqAzJO7979TWVEHUk5GeqUVFNoBV5OTzNYVHkDdfLsXIGCT3yihWDM3iIv9ftcM4srWrdnTJ8Wtoj7+pkW+aN9ow3yIl3UTgPlq0JCWppQLzetLbr103ec/GVJC3dIAkwjb8BlV9zWRLgvMMjvHXijAekbNpgeiJxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717041482; c=relaxed/simple;
	bh=uUv6AhNvMx6WlFeofx7ehtpINtZ6aM5IJs0Q+yQFSwc=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=tezqVFFky9bds9whtT3JLYNRZxHmurtIjktnuv7kI8VpQmX5g/BpzubzQUVRvr/ogJ2v1Y6wkBXNByPBrPxO+KOBVpT9rXVXU6LOYcqHpX8plymhSRF9ZlTQ2/l5kLI/tLGimaD9PrqvIAylFGyYgB+EaxxBKOzay2qwIX6adDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mJL20TPn; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717041477; h=Message-ID:Subject:Date:From:To;
	bh=ZbZ4Z21lz7ppnxwsjw/Iag0omCFAmUVoOusD/Ck66a0=;
	b=mJL20TPnMHrcvPqDFCrZEHgPkJ9lfQstVNn3aLypJOHo4XdHYGUX7SHuBS2m9tZBIj8dTpzYyWEfjlrP14FygH4nqlYFaLBx8pj9otcZDnxeCXuBzCgV5iGR1hCBjq/A6rCB4lnLULFvHTSu+/BZF2v82DE2tNcrbgK6VD6GUOM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W7VeU0._1717041476;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W7VeU0._1717041476)
          by smtp.aliyun-inc.com;
          Thu, 30 May 2024 11:57:57 +0800
Message-ID: <1717041469.8007479-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net v2] virtio_net: fix missing lock protection on control_buf access
Date: Thu, 30 May 2024 11:57:49 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Daniel Jurgens <danielj@nvidia.com>,
 Hariprasad Kelam <hkelam@marvell.com>,
 netdev@vger.kernel.org,
 virtualization@lists.linux.dev
References: <20240530034143.19579-1-hengqi@linux.alibaba.com>
In-Reply-To: <20240530034143.19579-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Thu, 30 May 2024 11:41:43 +0800, Heng Qi <hengqi@linux.alibaba.com> wrote:
> Refactored the handling of control_buf to be within the cvq_lock
> critical section, mitigating race conditions between reading device
> responses and new command submissions.
>
> Fixes: 6f45ab3e0409 ("virtio_net: Add a lock for the command VQ.")
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> Reviewed-by: Hariprasad Kelam <hkelam@marvell.com>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

> ---
> v1->v2:
>   - Use the ok instead of ret.
>
>  drivers/net/virtio_net.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 4a802c0ea2cb..1ea8e6a24286 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2686,6 +2686,7 @@ static bool virtnet_send_command_reply(struct virtnet_info *vi, u8 class, u8 cmd
>  {
>  	struct scatterlist *sgs[5], hdr, stat;
>  	u32 out_num = 0, tmp, in_num = 0;
> +	bool ok;
>  	int ret;
>
>  	/* Caller should know better */
> @@ -2731,8 +2732,9 @@ static bool virtnet_send_command_reply(struct virtnet_info *vi, u8 class, u8 cmd
>  	}
>
>  unlock:
> +	ok = vi->ctrl->status == VIRTIO_NET_OK;
>  	mutex_unlock(&vi->cvq_lock);
> -	return vi->ctrl->status == VIRTIO_NET_OK;
> +	return ok;
>  }
>
>  static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
> --
> 2.32.0.3.g01195cf9f
>

