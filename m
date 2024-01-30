Return-Path: <netdev+bounces-67267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DA6842870
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 16:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EFAC1C24A61
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 15:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA24B85C61;
	Tue, 30 Jan 2024 15:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XGxi8YEr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2677285C56
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 15:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706629957; cv=none; b=MevutJBAyFdk4MNfFc1XLyiU+oWCdcsWaaCv/zy97rnxY0/XU1S51pA/HudghBVrH30hZaQyMyN+Q/hKbVQFRGa9vjyjJDxwtpzqBoid0jedaZ+Bs5zydLxtA3uWzLbuDilJLXeOAsRVL8/xbE39f5JDE4HDmlW7lr7B7uHqkUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706629957; c=relaxed/simple;
	bh=b3xCECl7daa75S5e/tVE28JymMLYdLRiBfoE00efHJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HuUu/50MeL4xs/AaPUFOwvluFP+YF55erY5aeIM75F/T9NOp2WjznKBsY2AVQaEvhgqiE1h4llMkxYrZtJw6K+/oi/acWR0joSh2oew9mnMu/hxsCH+RgzXUUuWE55tZY8wDWwpdA0SWxAE7EKzLz0lIomiw3D/9WhLPaN4Ucug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XGxi8YEr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706629955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6LnSnMipv5LKpnY+ROHJ4HynxucA3AedN0f+qbjLs4o=;
	b=XGxi8YErxRDTsbtAGnlyMKQmb63KIpexHqNtqrFyNuqEScPP/Qif0uTqM6Nq0m+BiLzvk0
	3xFAqGbCFHNogz3CZaDOURuWMbs1E9PucocMc9IxIrNAq6dxWsehsbu0XMDo4K33wXezLg
	zTNhNprDccUojLr6mv+pH012k+7Q9XY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-0sHWdgKJN3qzpTKg4yQnsA-1; Tue, 30 Jan 2024 10:52:32 -0500
X-MC-Unique: 0sHWdgKJN3qzpTKg4yQnsA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40efd8d7ed1so6024075e9.0
        for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 07:52:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706629951; x=1707234751;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6LnSnMipv5LKpnY+ROHJ4HynxucA3AedN0f+qbjLs4o=;
        b=MJ89HExSwJsjv7KrY9XmEQKmw0Q5KiuTKMygdMPNu3B5IBoDzmVZwx+E9H0GOXgBY2
         O0CVLNQQn04L65ZipW5EGbWz15hkp5IIYFW6vbAQ1c2hN3utINzHlHuUDYEEalr7kN2U
         sCBJ1UftMJraq+n2nh8D2Np4eBVm7V8JzRIbYDaBtSFhGLgIJYwNcDoi3HjWn8K7yA7J
         sVpVE6rr0hLqN+NeSBf6GpNlSbPQBH71mwD6iyhMk4tbK6yvoUFCA1zRDKzNtg1xGBvA
         lrc+fWS+nsgxYbyWVfkybb/fWEpOmluFqqN+0yBzoV6KTcABXDPJf0qzK9d0w2xDDFxC
         nOjQ==
X-Gm-Message-State: AOJu0Ywcu84Ury2O7vpwyLovthTUuaf8bhNrAXJfdNg+HBHY7xfnWxDY
	DwoAaZt4i439MpR6wo+a+AeHSHJYpkDswXitGPdVjac0jdDM+2S5EgyBGll03hDb3RSj5yE1O/y
	XnCcWBuiZKpzvpzji1STh+sL4Gk1a3OjwuOOihJ3CVqFXNj8cNnsNWw==
X-Received: by 2002:a05:600c:4f54:b0:40f:b011:d2fd with SMTP id m20-20020a05600c4f5400b0040fb011d2fdmr428149wmq.35.1706629951581;
        Tue, 30 Jan 2024 07:52:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvvmdJvyjFjXE3L12/Z80n7VBws0Lbv1/oky6pfwXSb35n+EroP6uZfv3GndVl7PiEfzgQPg==
X-Received: by 2002:a05:600c:4f54:b0:40f:b011:d2fd with SMTP id m20-20020a05600c4f5400b0040fb011d2fdmr428131wmq.35.1706629951253;
        Tue, 30 Jan 2024 07:52:31 -0800 (PST)
Received: from redhat.com ([2.52.129.159])
        by smtp.gmail.com with ESMTPSA id az29-20020a05600c601d00b0040ee6ff86f6sm12305875wmb.0.2024.01.30.07.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 07:52:30 -0800 (PST)
Date: Tue, 30 Jan 2024 10:52:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"abeni@redhat.com" <abeni@redhat.com>,
	Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH net-next] virtio_net: Add TX stop and wake counters
Message-ID: <20240130104523-mutt-send-email-mst@kernel.org>
References: <20240130142521.18593-1-danielj@nvidia.com>
 <081f6d4c-bc44-4afe-ba51-d7c14966a536@linux.alibaba.com>
 <CH0PR12MB8580571225697B1ABDD55541C97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CH0PR12MB8580571225697B1ABDD55541C97D2@CH0PR12MB8580.namprd12.prod.outlook.com>

On Tue, Jan 30, 2024 at 03:43:48PM +0000, Daniel Jurgens wrote:
> > From: Heng Qi <hengqi@linux.alibaba.com>
> > Sent: Tuesday, January 30, 2024 9:17 AM
> > 在 2024/1/30 下午10:25, Daniel Jurgens 写道:
> > > Add a tx queue stop and wake counters, they are useful for debugging.
> > >
> > > 	$ ethtool -S ens5f2 | grep 'tx_stop\|tx_wake'
> > > 	...
> > > 	tx_queue_1_tx_stop: 16726
> > > 	tx_queue_1_tx_wake: 16726
> > > 	...
> > > 	tx_queue_8_tx_stop: 1500110
> > > 	tx_queue_8_tx_wake: 1500110
> > >
> > > Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> > > Reviewed-by: Parav Pandit <parav@nvidia.com>
> > > ---
> > >   drivers/net/virtio_net.c | 26 ++++++++++++++++++++++++--
> > >   1 file changed, 24 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c index
> > > 3cb8aa193884..7e3c31ceaf7e 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -88,6 +88,8 @@ struct virtnet_sq_stats {
> > >   	u64_stats_t xdp_tx_drops;
> > >   	u64_stats_t kicks;
> > >   	u64_stats_t tx_timeouts;
> > > +	u64_stats_t tx_stop;
> > > +	u64_stats_t tx_wake;
> > >   };
> > 
> > Hi Daniel!
> > 
> > tx_stop/wake only counts the status in the I/O path.
> > Do the status of virtnet_config_changed_work and virtnet_tx_resize need to
> > be counted?
> > 
> 
> My motivation for the counter is detecting full TX queues. I don't think counting them in the control path is useful, but it can be done if you disagree.

Do we then just want "tx full" counter?

> > Thanks,
> > Heng
> > 
> > >
> > >   struct virtnet_rq_stats {
> > > @@ -112,6 +114,8 @@ static const struct virtnet_stat_desc
> > virtnet_sq_stats_desc[] = {
> > >   	{ "xdp_tx_drops",	VIRTNET_SQ_STAT(xdp_tx_drops) },
> > >   	{ "kicks",		VIRTNET_SQ_STAT(kicks) },
> > >   	{ "tx_timeouts",	VIRTNET_SQ_STAT(tx_timeouts) },
> > > +	{ "tx_stop",		VIRTNET_SQ_STAT(tx_stop) },
> > > +	{ "tx_wake",		VIRTNET_SQ_STAT(tx_wake) },
> > >   };
> > >
> > >   static const struct virtnet_stat_desc virtnet_rq_stats_desc[] = { @@
> > > -843,6 +847,9 @@ static void check_sq_full_and_disable(struct virtnet_info
> > *vi,
> > >   	 */
> > >   	if (sq->vq->num_free < 2+MAX_SKB_FRAGS) {
> > >   		netif_stop_subqueue(dev, qnum);
> > > +		u64_stats_update_begin(&sq->stats.syncp);
> > > +		u64_stats_inc(&sq->stats.tx_stop);
> > > +		u64_stats_update_end(&sq->stats.syncp);
> > >   		if (use_napi) {
> > >   			if (unlikely(!virtqueue_enable_cb_delayed(sq->vq)))
> > >   				virtqueue_napi_schedule(&sq->napi, sq-
> > >vq); @@ -851,6 +858,9 @@
> > > static void check_sq_full_and_disable(struct virtnet_info *vi,
> > >   			free_old_xmit_skbs(sq, false);
> > >   			if (sq->vq->num_free >= 2+MAX_SKB_FRAGS) {
> > >   				netif_start_subqueue(dev, qnum);
> > > +				u64_stats_update_begin(&sq->stats.syncp);
> > > +				u64_stats_inc(&sq->stats.tx_wake);
> > > +				u64_stats_update_end(&sq->stats.syncp);
> > >   				virtqueue_disable_cb(sq->vq);
> > >   			}
> > >   		}
> > > @@ -2163,8 +2173,14 @@ static void virtnet_poll_cleantx(struct
> > receive_queue *rq)
> > >   			free_old_xmit_skbs(sq, true);
> > >   		} while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
> > >
> > > -		if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
> > > +		if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS) {
> > > +			if (netif_tx_queue_stopped(txq)) {
> > > +				u64_stats_update_begin(&sq->stats.syncp);
> > > +				u64_stats_inc(&sq->stats.tx_wake);
> > > +				u64_stats_update_end(&sq->stats.syncp);
> > > +			}
> > >   			netif_tx_wake_queue(txq);
> > > +		}
> > >
> > >   		__netif_tx_unlock(txq);
> > >   	}
> > > @@ -2310,8 +2326,14 @@ static int virtnet_poll_tx(struct napi_struct
> > *napi, int budget)
> > >   	virtqueue_disable_cb(sq->vq);
> > >   	free_old_xmit_skbs(sq, true);
> > >
> > > -	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
> > > +	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS) {
> > > +		if (netif_tx_queue_stopped(txq)) {
> > > +			u64_stats_update_begin(&sq->stats.syncp);
> > > +			u64_stats_inc(&sq->stats.tx_wake);
> > > +			u64_stats_update_end(&sq->stats.syncp);
> > > +		}
> > >   		netif_tx_wake_queue(txq);
> > > +	}
> > >
> > >   	opaque = virtqueue_enable_cb_prepare(sq->vq);
> > >
> 


