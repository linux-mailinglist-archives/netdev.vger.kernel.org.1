Return-Path: <netdev+bounces-192226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EACDFABEFFD
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 11:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 124797AA259
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 09:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719032475E3;
	Wed, 21 May 2025 09:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Y9MbHTJL"
X-Original-To: netdev@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E4823C505;
	Wed, 21 May 2025 09:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747820060; cv=none; b=Z3h16NiuAHOe6mZ5VLbFL2R8pdRb5LyDZSBhGFupO5ufSRhndT0WBb7gbRdIIl/MYqcl1VV0CgN6sMe27a0JNMW3yEggdoxcca4lUOvkEeQl9Xju7368af5LhO73OepR3ijtF5/bbba4QiWEGVuA3YezHi/ZxTuVU6W8/0P+8AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747820060; c=relaxed/simple;
	bh=hMK6oGrTkZibku5CYpSqz7qna9Y+Jn1piiIv79urESk=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=t4EEEIKk8If0kZ6UZ/8Lbp/Dw+EuQTjeWRC+ZUGrWnR6hZdf4d0MvzHYyU2IjN8oD40bs/Xgwo4/MTu/e7vndg7PoF2C+atMODamgWpqf2kqPTlvPonbsWe3hUld+vQuUbn9NNca9pS0FbfwBv49603ez52ka9AJlioXE49AegE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Y9MbHTJL; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1747820055; h=Message-ID:Subject:Date:From:To;
	bh=6aoUvVd5gpjDt2TqSa/A0a/gJ8BZD0DlDqhcgfp4UUM=;
	b=Y9MbHTJLVOjOYUSEPklCOx5VbaUJRBCzEJLLm/Ibj/41vCWVA1C+uZSkSv6VaBH1ToUGg+CXz693m9h3jLmnlPhSHfy9XoaxoCL2R9ZMOIP4j3shfiRcFVx09Os/0iAauMg7GUsvVi8Yqij2Q+NOA1XJJaOt3g9/P6LF1wJRJug=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WbRFQ9t_1747820054 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 21 May 2025 17:34:15 +0800
Message-ID: <1747820047.4914944-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v2 3/3] virtio_net: Enforce minimum TX ring size for reliability
Date: Wed, 21 May 2025 17:34:07 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Laurent Vivier <lvivier@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org,
 Jason Wang <jasowang@redhat.com>,
 linux-kernel@vger.kernel.org
References: <20250521092236.661410-1-lvivier@redhat.com>
 <20250521092236.661410-4-lvivier@redhat.com>
In-Reply-To: <20250521092236.661410-4-lvivier@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Wed, 21 May 2025 11:22:36 +0200, Laurent Vivier <lvivier@redhat.com> wrote:
> The `tx_may_stop()` logic stops TX queues if free descriptors
> (`sq->vq->num_free`) fall below the threshold of (`MAX_SKB_FRAGS` + 2).
> If the total ring size (`ring_num`) is not strictly greater than this
> value, queues can become persistently stopped or stop after minimal
> use, severely degrading performance.
>
> A single sk_buff transmission typically requires descriptors for:
> - The virtio_net_hdr (1 descriptor)
> - The sk_buff's linear data (head) (1 descriptor)
> - Paged fragments (up to MAX_SKB_FRAGS descriptors)
>
> This patch enforces that the TX ring size ('ring_num') must be strictly
> greater than (MAX_SKB_FRAGS + 2). This ensures that the ring is
> always large enough to hold at least one maximally-fragmented packet
> plus at least one additional slot.
>
> Reported-by: Lei Yang <leiyang@redhat.com>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

> ---
>  drivers/net/virtio_net.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index ff4160243538..50b851834ae2 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3481,6 +3481,12 @@ static int virtnet_tx_resize(struct virtnet_info *vi, struct send_queue *sq,
>  {
>  	int qindex, err;
>
> +	if (ring_num <= MAX_SKB_FRAGS + 2) {
> +		netdev_err(vi->dev, "tx size (%d) cannot be smaller than %d\n",
> +			   ring_num, MAX_SKB_FRAGS + 2);
> +		return -EINVAL;
> +	}
> +
>  	qindex = sq - vi->sq;
>
>  	virtnet_tx_pause(vi, sq);
> --
> 2.49.0
>

