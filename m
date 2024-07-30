Return-Path: <netdev+bounces-113867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE55B94032F
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 03:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B6121C212F0
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 01:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5D110E3;
	Tue, 30 Jul 2024 01:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XZeQI4Hg"
X-Original-To: netdev@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E7D8BF0
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 01:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722301896; cv=none; b=ba0Um2YzoINmIhKyTVucbkQegQSfbTKz/Lcp8M2s3yXUcUY+fdmxTUXahdgfsvXlAWMTfp14hQLllU9wsUbRtcD9WtzU9L9qCjxw8duCZ2bNW/9DODLx64zSOpJA+g6fnrFN0v3j/2Dr7sCNQOR/XJ8FPHBoE9jBZSxWwCqgcAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722301896; c=relaxed/simple;
	bh=mDbX44iHFAur30ptnsNO/rYztiZYmHy6rFTH9+fEUaE=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=H80ppI6YVqZQtiRTXBu3eqJh1p1eOlENWSgyJ97TxNomUeTRAee129/kbVOWI4NPsk5I4ljqFFJkhjnvwW0hSoWBy2eqGCKXK3kvyA+Bs8p0Fu2cR73MMV+eesKrR/pKAfjKeWn8FHAGTMhug3Q5/F6yWebdtorvKyJLeyM9ONI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XZeQI4Hg; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722301891; h=Message-ID:Subject:Date:From:To;
	bh=NurZJnjIPPIG2Wgu5pBlZBRDBNoK5/FjLiE+OAyWfI4=;
	b=XZeQI4HgX23wucBhti1sLrdrtu1Upbk0JUzv6+mYYZfpB5ypTqzreW8Upe/DaDG09HZ/GymaqEL2oPwSTwhldE+2/zdrYsme9izerjEOzV7Spxx9GegQYn3pbjVTMHoZbC6DksT/3TG2fz6BZN8HhObKF2HGWqkggQTMhqJhfHE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R491e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032019045;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0WBdYe0X_1722301889;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WBdYe0X_1722301889)
          by smtp.aliyun-inc.com;
          Tue, 30 Jul 2024 09:11:30 +0800
Message-ID: <1722301882.5491223-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net] virtio_net: Avoid sending unnecessary vq coalescing commands
Date: Tue, 30 Jul 2024 09:11:22 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: virtualization@lists.linux.dev,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>
References: <20240729124755.35719-1-hengqi@linux.alibaba.com>
In-Reply-To: <20240729124755.35719-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Mon, 29 Jul 2024 20:47:55 +0800, Heng Qi <hengqi@linux.alibaba.com> wrote:
> From the virtio spec:
>
> 	The driver MUST have negotiated the VIRTIO_NET_F_VQ_NOTF_COAL
> 	feature when issuing commands VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET
> 	and VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET.
>
> The driver must not send vq notification coalescing commands if
> VIRTIO_NET_F_VQ_NOTF_COAL is not negotiated. This limitation of course
> applies to vq resize.
>
> Fixes: f61fe5f081cf ("virtio-net: fix the vq coalescing setting for vq resize")
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

> ---
>  drivers/net/virtio_net.c | 29 +++++++++++++++++------------
>  1 file changed, 17 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 0383a3e136d6..eb115e807882 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3708,6 +3708,7 @@ static int virtnet_set_ringparam(struct net_device *dev,
>  	u32 rx_pending, tx_pending;
>  	struct receive_queue *rq;
>  	struct send_queue *sq;
> +	u32 pkts, usecs;
>  	int i, err;
>
>  	if (ring->rx_mini_pending || ring->rx_jumbo_pending)
> @@ -3740,11 +3741,13 @@ static int virtnet_set_ringparam(struct net_device *dev,
>  			 * through the VIRTIO_NET_CTRL_NOTF_COAL_TX_SET command, or, if the driver
>  			 * did not set any TX coalescing parameters, to 0.
>  			 */
> -			err = virtnet_send_tx_ctrl_coal_vq_cmd(vi, i,
> -							       vi->intr_coal_tx.max_usecs,
> -							       vi->intr_coal_tx.max_packets);
> -			if (err)
> -				return err;
> +			if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL)) {
> +				usecs = vi->intr_coal_tx.max_usecs;
> +				pkts = vi->intr_coal_tx.max_packets;
> +				err = virtnet_send_tx_ctrl_coal_vq_cmd(vi, i, usecs, pkts);
> +				if (err)
> +					return err;
> +			}
>  		}
>
>  		if (ring->rx_pending != rx_pending) {
> @@ -3753,13 +3756,15 @@ static int virtnet_set_ringparam(struct net_device *dev,
>  				return err;
>
>  			/* The reason is same as the transmit virtqueue reset */
> -			mutex_lock(&vi->rq[i].dim_lock);
> -			err = virtnet_send_rx_ctrl_coal_vq_cmd(vi, i,
> -							       vi->intr_coal_rx.max_usecs,
> -							       vi->intr_coal_rx.max_packets);
> -			mutex_unlock(&vi->rq[i].dim_lock);
> -			if (err)
> -				return err;
> +			if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL)) {
> +				usecs = vi->intr_coal_rx.max_usecs;
> +				pkts = vi->intr_coal_rx.max_packets;
> +				mutex_lock(&vi->rq[i].dim_lock);
> +				err = virtnet_send_rx_ctrl_coal_vq_cmd(vi, i, usecs, pkts);
> +				mutex_unlock(&vi->rq[i].dim_lock);
> +				if (err)
> +					return err;
> +			}
>  		}
>  	}
>
> --
> 2.32.0.3.g01195cf9f
>

