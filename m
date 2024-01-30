Return-Path: <netdev+bounces-67261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D60084283D
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 16:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5219B1C271A8
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 15:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0345482D74;
	Tue, 30 Jan 2024 15:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HhyXLRFa"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAE982D76
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 15:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706629305; cv=none; b=EyEaHGvfEGLwsApZhHTUQsH+eiECgwWXYXkWw6NLcxVwfJz6pqbj6OveCkM0VbApLxg1RjAPUd/N+yJNHhTrATn876Xf2ArpO0uyTIvU0Nv/mBKXxTy3GrDk6vP0UBU0fiqbccO+0Cj1xXhYVkIUdycDeNunMjcY7tMPvNiNSC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706629305; c=relaxed/simple;
	bh=jAe2WtQ+cegbB7VcCpdqIKiLHX6BZlkrX5XSB+btaNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DAQTLujDvxq6xE9DWqCaetAXs3sMZRbT3UnCgxf5HADbIiQkfTXvrU6x9YLlfhjCwTkG0iVdlKnQN29brdlEWhPuDeSTofxOMGjjn+38NdRr4lgavbFrUWFNsRzjUNQY9IIKwlL40CtxgfdD5UvRskSZeaENyUSEZlZASim4CKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HhyXLRFa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706629303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NkWGdJ4jGC/nwOvAkqMbwgzwbi4dHc9Yx1Y4UXeKBAg=;
	b=HhyXLRFa9YirE6pDcN+vXKpdppAbJjkcfx+5L9rOl6d0NyYT1dwjYLjKeK25PvtprhfFD3
	Kq3dvCMn6lTnPKxWr/5B5WUoc/PWQESRCDc6wMa606TV/yurV9ErpZxk74XOs/L4Vn2PMw
	crBN+FJq4QV5CBJUWBxwWyuAiuZBPRo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-UlqBgZXzNFy-HzukQOws2Q-1; Tue, 30 Jan 2024 10:41:40 -0500
X-MC-Unique: UlqBgZXzNFy-HzukQOws2Q-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a3260df549dso146378066b.2
        for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 07:41:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706629299; x=1707234099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NkWGdJ4jGC/nwOvAkqMbwgzwbi4dHc9Yx1Y4UXeKBAg=;
        b=JufPcSjQ7LCgOoMzDt4MwU7dO0PpuzWfORXkyE9+hmDETyGDtMcWV9UK5B/KNwyHqK
         rOHusas5mIbRJn4jE2ZP5XKl1JCSER1+VCa898sNOp9NBVUOL5ajE8Q/ACYQZB26UY5W
         5QJV10u6Lt9ZTjMuyXamVidSGNdyyqem4+/CVaQSG2v0buMpR/jXQ4/wCZi8KxQpZW44
         Pm2lWDkmqcToYEbeIN2WxUC9gxTfjll2ysvl5VFxpquuOVcWDKKJtgBwPG1ZIJWYYlcM
         OoEzH+vrZVEGEZe7Lalmxko2hb+UMqYxDuQ5Yf5kTy/sh7YArfrakk6EXQWYslI6IZdp
         6P4w==
X-Gm-Message-State: AOJu0YxCtD9gLhZAWu/t45WISuCOGl17ptHsRITrsw1PlZVI5sUtwK0f
	0/Kq5lPl1Wu9EL8xQl+8qplZ2Dcc5EKJTWz8W/trg1GfK3vNrtmdKrpYllU7t16PT5NG6Te13C5
	BTonyCqXT9jUwTru0+gMIASe6MRYWf17Q+sE6owvJFCd4yUAoszuHQw==
X-Received: by 2002:a17:906:1912:b0:a35:a71d:81fe with SMTP id a18-20020a170906191200b00a35a71d81femr4396712eje.43.1706629299432;
        Tue, 30 Jan 2024 07:41:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdS4FuNlGUJYSwFcS1QoUwdhQ4Cu1IHc1U8Nt4Q0AKhDRcHcyuvPz/VMfNIXhwU+fEr92qBA==
X-Received: by 2002:a17:906:1912:b0:a35:a71d:81fe with SMTP id a18-20020a170906191200b00a35a71d81femr4396705eje.43.1706629299117;
        Tue, 30 Jan 2024 07:41:39 -0800 (PST)
Received: from redhat.com ([2.52.129.159])
        by smtp.gmail.com with ESMTPSA id ck5-20020a170906c44500b00a31930ffa7esm5194423ejb.153.2024.01.30.07.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 07:41:37 -0800 (PST)
Date: Tue, 30 Jan 2024 10:41:32 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"abeni@redhat.com" <abeni@redhat.com>,
	Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH net-next] virtio_net: Add TX stop and wake counters
Message-ID: <20240130104107-mutt-send-email-mst@kernel.org>
References: <20240130142521.18593-1-danielj@nvidia.com>
 <20240130095645-mutt-send-email-mst@kernel.org>
 <CH0PR12MB85809CB7678CADCC892B2259C97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH0PR12MB85809CB7678CADCC892B2259C97D2@CH0PR12MB8580.namprd12.prod.outlook.com>

On Tue, Jan 30, 2024 at 03:40:21PM +0000, Daniel Jurgens wrote:
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Tuesday, January 30, 2024 8:58 AM
> > 
> > On Tue, Jan 30, 2024 at 08:25:21AM -0600, Daniel Jurgens wrote:
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
> > 
> > Hmm isn't one always same as the other, except when queue is stopped?
> > And when it is stopped you can see that in the status?
> > So how is having two useful?
> 
> At idle the counters will be the same, unless a tx_timeout occurs. But under load they can be monitored to see which queues are stopped and get an idea of how long they are stopped.

how does it give you the idea of how long they are stopped?

> Other net drivers (not all), also have the wake counter.

Examples?

> In my opinion it makes the stop counter more useful, at little cost.
> 
> > 
> > 
> > > ---
> > >  drivers/net/virtio_net.c | 26 ++++++++++++++++++++++++--
> > >  1 file changed, 24 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c index
> > > 3cb8aa193884..7e3c31ceaf7e 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -88,6 +88,8 @@ struct virtnet_sq_stats {
> > >  	u64_stats_t xdp_tx_drops;
> > >  	u64_stats_t kicks;
> > >  	u64_stats_t tx_timeouts;
> > > +	u64_stats_t tx_stop;
> > > +	u64_stats_t tx_wake;
> > >  };
> > >
> > >  struct virtnet_rq_stats {
> > > @@ -112,6 +114,8 @@ static const struct virtnet_stat_desc
> > virtnet_sq_stats_desc[] = {
> > >  	{ "xdp_tx_drops",	VIRTNET_SQ_STAT(xdp_tx_drops) },
> > >  	{ "kicks",		VIRTNET_SQ_STAT(kicks) },
> > >  	{ "tx_timeouts",	VIRTNET_SQ_STAT(tx_timeouts) },
> > > +	{ "tx_stop",		VIRTNET_SQ_STAT(tx_stop) },
> > > +	{ "tx_wake",		VIRTNET_SQ_STAT(tx_wake) },
> > >  };
> > >
> > >  static const struct virtnet_stat_desc virtnet_rq_stats_desc[] = { @@
> > > -843,6 +847,9 @@ static void check_sq_full_and_disable(struct virtnet_info
> > *vi,
> > >  	 */
> > >  	if (sq->vq->num_free < 2+MAX_SKB_FRAGS) {
> > >  		netif_stop_subqueue(dev, qnum);
> > > +		u64_stats_update_begin(&sq->stats.syncp);
> > > +		u64_stats_inc(&sq->stats.tx_stop);
> > > +		u64_stats_update_end(&sq->stats.syncp);
> > >  		if (use_napi) {
> > >  			if (unlikely(!virtqueue_enable_cb_delayed(sq->vq)))
> > >  				virtqueue_napi_schedule(&sq->napi, sq-
> > >vq); @@ -851,6 +858,9 @@
> > > static void check_sq_full_and_disable(struct virtnet_info *vi,
> > >  			free_old_xmit_skbs(sq, false);
> > >  			if (sq->vq->num_free >= 2+MAX_SKB_FRAGS) {
> > >  				netif_start_subqueue(dev, qnum);
> > > +				u64_stats_update_begin(&sq->stats.syncp);
> > > +				u64_stats_inc(&sq->stats.tx_wake);
> > > +				u64_stats_update_end(&sq->stats.syncp);
> > >  				virtqueue_disable_cb(sq->vq);
> > >  			}
> > >  		}
> > > @@ -2163,8 +2173,14 @@ static void virtnet_poll_cleantx(struct
> > receive_queue *rq)
> > >  			free_old_xmit_skbs(sq, true);
> > >  		} while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
> > >
> > > -		if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
> > > +		if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS) {
> > > +			if (netif_tx_queue_stopped(txq)) {
> > > +				u64_stats_update_begin(&sq->stats.syncp);
> > > +				u64_stats_inc(&sq->stats.tx_wake);
> > > +				u64_stats_update_end(&sq->stats.syncp);
> > > +			}
> > >  			netif_tx_wake_queue(txq);
> > > +		}
> > >
> > >  		__netif_tx_unlock(txq);
> > >  	}
> > > @@ -2310,8 +2326,14 @@ static int virtnet_poll_tx(struct napi_struct
> > *napi, int budget)
> > >  	virtqueue_disable_cb(sq->vq);
> > >  	free_old_xmit_skbs(sq, true);
> > >
> > > -	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
> > > +	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS) {
> > > +		if (netif_tx_queue_stopped(txq)) {
> > > +			u64_stats_update_begin(&sq->stats.syncp);
> > > +			u64_stats_inc(&sq->stats.tx_wake);
> > > +			u64_stats_update_end(&sq->stats.syncp);
> > > +		}
> > >  		netif_tx_wake_queue(txq);
> > > +	}
> > >
> > >  	opaque = virtqueue_enable_cb_prepare(sq->vq);
> > >
> > > --
> > > 2.42.0


