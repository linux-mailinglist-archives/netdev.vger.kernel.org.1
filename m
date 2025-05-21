Return-Path: <netdev+bounces-192223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5027DABEFEF
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 11:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20D744E1159
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 09:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54CA24167F;
	Wed, 21 May 2025 09:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uRKm31hS"
X-Original-To: netdev@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7E5238173;
	Wed, 21 May 2025 09:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747819996; cv=none; b=FtHMzP51q1U0o9HUzW8CGKOaO5yV5/lVNO7q49srXWq2aEoi7kd9lVtJErBju5auyaFul0I1pScZ/SXxyBN/PQW2d+7WF1NWExgDWf3Qd1ZD6lqLR4T5b3ur4oSVMKO6gtnkACnP73w4XXdc+uQEdlPvHE1Cw+lnR2J3es70Fik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747819996; c=relaxed/simple;
	bh=qzl+GCezGpStnRyOr52+ceiFfjWtiTGDmpqhsXl8tEc=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=aEU4CW5J39HC2U6pOlVb4LqsosBWjffAg9sD4SDnZMOsdpIBkDKlQIsG3w+LjzHMzmSjXw4p/sZPVnZa0GfYow/0FvPfrludi9JtzwLtnUWVr43JnxGeE/Df/BxVryR681gf0U+Q29HGNdfpDJwPIddyydbhBy7eQ1uwhs9tLPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uRKm31hS; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1747819984; h=Message-ID:Subject:Date:From:To;
	bh=LwrdmgjpSSjCk4xY0DYUL0GPY9RuDrSmgjjk2Np2zCg=;
	b=uRKm31hSVTjjaW0j5HLWxlU5Bz3Lzej22OfMlQcEsGtHoEMhzgVaIqLPD6b1h5QWqzjq0YOHcnrBa0nhVXGONCvI9zJAvKVo8B2eL+w4Lqo8u2ekByDzZcDSb3+9Uq1+UaeE0daQWGgE99sPTKtrxnErNtUjlMJWpn5+Lji3D5Q=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WbR961-_1747819984 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 21 May 2025 17:33:04 +0800
Message-ID: <1747819548.635838-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 1/2] virtio_ring: Fix error reporting in virtqueue_resize
Date: Wed, 21 May 2025 17:25:48 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Laurent Vivier <lvivier@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250520110526.635507-1-lvivier@redhat.com>
 <20250520110526.635507-2-lvivier@redhat.com>
In-Reply-To: <20250520110526.635507-2-lvivier@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>


We should provide feedback to the caller indicating the queue's current status
whether it is still valid and whether its size has been successfully
modified. Here I selected the first. The caller can know the second by
virtqueue_get_vring_size().

Thanks.


On Tue, 20 May 2025 13:05:25 +0200, Laurent Vivier <lvivier@redhat.com> wrote:
> The virtqueue_resize() function was not correctly propagating error codes
> from its internal resize helper functions, specifically
> virtqueue_resize_packet() and virtqueue_resize_split(). If these helpers
> returned an error, but the subsequent call to virtqueue_enable_after_reset()
> succeeded, the original error from the resize operation would be masked.
> Consequently, virtqueue_resize() could incorrectly report success to its
> caller despite an underlying resize failure.
>
> This change restores the original code behavior:
>
>        if (vdev->config->enable_vq_after_reset(_vq))
>                return -EBUSY;
>
>        return err;
>
> Fix: commit ad48d53b5b3f ("virtio_ring: separate the logic of reset/enable from virtqueue_resize")
> Cc: xuanzhuo@linux.alibaba.com
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index b784aab66867..4397392bfef0 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2797,7 +2797,7 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
>  		     void (*recycle_done)(struct virtqueue *vq))
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
> -	int err;
> +	int err, err_reset;
>
>  	if (num > vq->vq.num_max)
>  		return -E2BIG;
> @@ -2819,7 +2819,11 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
>  	else
>  		err = virtqueue_resize_split(_vq, num);
>
> -	return virtqueue_enable_after_reset(_vq);
> +	err_reset = virtqueue_enable_after_reset(_vq);
> +	if (err_reset)
> +		return err_reset;
> +
> +	return err;
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_resize);
>
> --
> 2.49.0
>

