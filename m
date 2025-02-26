Return-Path: <netdev+bounces-170021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E361A46E4A
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 23:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 107871886039
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 22:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE0526FA77;
	Wed, 26 Feb 2025 22:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="InkERG0B"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13B726F471
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 22:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740608008; cv=none; b=Pades+AcR2SL4/X5K53UU3hCCNW5gRQRAfQlEVlLna50TPnxHpX4p9x6V2p8HZHFsgXhex0SVDnKf7lIG4f4L6aV0ymOXFglIoXLFMXE9tmhDLj4KUJirurRtsV+6DBSAlOPyBp4SzniGjxW1TO8BeBhvCqYmkMN368gngyupHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740608008; c=relaxed/simple;
	bh=+AGXsd3l0/ZAahpV30MW18ZWS7qqDgJIIVxUnI5sp+M=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKi8q41oKSqOe9KYg/2rBL8qOGunsKT4tYKw9uZJCz3n09CDpeP+i9tLCUYqX7t/b5dMOcq8e+D5JowgtPX5jdKFwWIHiM3Wi8FHmlorqxZFvAocwWmfch8CkdseS048KKuAWlML3UJEbs0oCf7aGfE1rf3iLP32X+NUtlU+2go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=InkERG0B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740608004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xoC6B7ot7I9gFHLsIIDATRwO00Yvhc2uVgVPoqjJGYQ=;
	b=InkERG0BT0jdHMLgYq3GZPoKhlcW1Zd4psxbtlAHGzp1WfACqZHBMCQ0s+wtyUkr2dPmjA
	BUKN47FI5sMQIX/cC0gFdJ5sARg8elfXa1aYeVNIq7BZlRWeNFxnWjCq73XTDVTKCh4HQP
	EVGXHRgBsqEEwDjWsQIGgCiA5Nvy10Y=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-m1DMD_wANgS6AVtbfJt1kQ-1; Wed, 26 Feb 2025 17:13:22 -0500
X-MC-Unique: m1DMD_wANgS6AVtbfJt1kQ-1
X-Mimecast-MFC-AGG-ID: m1DMD_wANgS6AVtbfJt1kQ_1740608000
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38f4e47d0b2so88169f8f.2
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 14:13:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740608000; x=1741212800;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xoC6B7ot7I9gFHLsIIDATRwO00Yvhc2uVgVPoqjJGYQ=;
        b=hhDmiDiZ8HPews7DNeKhShv3JJoqelADTyEi+IJgMj03UeVFtB+y9WWQ+ckUJOTGQU
         0b9oqO6rRCNk7shDEekV12AX3atw2peQ3ars7nbWHPvIA8aQtRZLqQeJ/ZpK6fkIeSZo
         RuHdwYi8t7en4tppmduSBgDz07+pZzpXp6P6fQuVSQ+etFlFULYNT1R1S9yfJezdb0T2
         qR+tGbw8RFVC9oSr+qjyZAUeWRTIFsLzp1y467I3zewBbTClyWAr5F9KatvI4mr4nScI
         kC7Mt5dNawcw+hU5fPFmrmV76137BCRLVUKVSlhseCZMLZy+FyvRu9lrNiRRgB8sED3y
         7V7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUSvs8BtHMzawwOtjAvOwG+xiGgg7OVvoaSFO7gKSNe7wlv+rKtXuHY8qPjpQE9kXRa/cjYzTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpvgForscEec9EDIbosfb3NPJiJ3rZBSpzHcpssF/011x10+X8
	aW12AX8I3pyJKyO2gwiQfbiloQVFGfP99GCYjEvOZOxpphZRUKVS2OBpyuR+qCLacgH6e2VmTNw
	nHFtwAy2BoyCr/JQV9I1TvhtvFi5CyK6pu9mWGTiQ4IyYtD7vpE7dzg==
X-Gm-Gg: ASbGncuzPyopxxmBK6GGnPsfJ6X29p3KB8Ti34IswuIoAF8KqXluOdtYa6tqhussd3u
	tM5Gqpd3fqFRI+ZXXWHAd8y3KW3SQVSq/sGWFjEX3ys5wLApaIJlyhA6G06WYyE3vTemEjxZ6SU
	a1n47fkf0wkzhpcEqL06OBTsHjHNoMvqKFbQgtPQZok3EJ0g5VAfjkeuu/KI2zfaC3kGjWeOs8h
	CHIVT53aWGSE7c7dVzv38ecCPioGalV5SD9sM3ghw/4sMgdTwpN7y8uNRQp/Ul0wmmF6KwBWbRI
	jWo9k1/UeA==
X-Received: by 2002:a05:6000:1f88:b0:38f:286c:9acc with SMTP id ffacd0b85a97d-390d4f429dfmr3953215f8f.32.1740608000164;
        Wed, 26 Feb 2025 14:13:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6UZscpycCohbgKUm67MTCc3ms1w0NUKbtY3TjrWejb4s65WjUp3KhFLNFf62YjJo396h7PQ==
X-Received: by 2002:a05:6000:1f88:b0:38f:286c:9acc with SMTP id ffacd0b85a97d-390d4f429dfmr3953196f8f.32.1740607999757;
        Wed, 26 Feb 2025 14:13:19 -0800 (PST)
Received: from redhat.com ([2a02:14f:1eb:e270:8595:184c:7546:3597])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b7a28bd85sm2488945e9.36.2025.02.26.14.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 14:13:18 -0800 (PST)
Date: Wed, 26 Feb 2025 17:13:13 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Joe Damato <jdamato@fastly.com>, Jason Wang <jasowang@redhat.com>,
	netdev@vger.kernel.org, mkarsten@uwaterloo.ca,
	gerhard@engleder-embedded.com, xuanzhuo@linux.alibaba.com,
	kuba@kernel.org,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4 3/4] virtio-net: Map NAPIs to queues
Message-ID: <20250226171252-mutt-send-email-mst@kernel.org>
References: <20250225020455.212895-1-jdamato@fastly.com>
 <20250225020455.212895-4-jdamato@fastly.com>
 <CACGkMEv6y+TkZnWWLPG4UE59iyREhkiaby8kj==cnp=6chmu+w@mail.gmail.com>
 <Z79XXQjp9Dz7OYYQ@LQ3V64L9R2>
 <Z79YseiGrzYxoyvr@LQ3V64L9R2>
 <Z795Pt_RnfnvC-1N@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z795Pt_RnfnvC-1N@LQ3V64L9R2>

On Wed, Feb 26, 2025 at 03:27:42PM -0500, Joe Damato wrote:
> On Wed, Feb 26, 2025 at 01:08:49PM -0500, Joe Damato wrote:
> > On Wed, Feb 26, 2025 at 01:03:09PM -0500, Joe Damato wrote:
> > > On Wed, Feb 26, 2025 at 01:48:50PM +0800, Jason Wang wrote:
> > > > On Tue, Feb 25, 2025 at 10:05 AM Joe Damato <jdamato@fastly.com> wrote:
> > > > >
> > > > > Use netif_queue_set_napi to map NAPIs to queue IDs so that the mapping
> > > > > can be accessed by user apps, taking care to hold RTNL as needed.
> > > > 
> > > > I may miss something but I wonder whether letting the caller hold the
> > > > lock is better.
> > > 
> > > Hmm...
> > > 
> > > Double checking all the paths over again, here's what I see:
> > >   - refill_work, delayed work that needs RTNL so this change seems
> > >     right?
> > > 
> > >   - virtnet_disable_queue_pair, called from virtnet_open and
> > >     virtnet_close. When called via NDO these are safe and hold RTNL,
> > >     but they can be called from power management and need RTNL.
> > > 
> > >   - virtnet_enable_queue_pair called from virtnet_open, safe when
> > >     used via NDO but needs RTNL when used via power management.
> > > 
> > >   - virtnet_rx_pause called in both paths as you mentioned, one
> > >     which needs RTNL and one which doesn't.
> > 
> > Sorry, I missed more paths:
> > 
> >     - virtnet_rx_resume
> >     - virtnet_tx_pause and virtnet_tx_resume
> > 
> > which are similar to path you mentioned (virtnet_rx_pause) and need
> > rtnl in one of two different paths.
> > 
> > Let me know if I missed any paths and what your preferred way to fix
> > this would be?
> > 
> > I think both options below are possible and I have no strong
> > preference.
> 
> OK, my apologies. I read your message and the code wrong. Sorry for
> the back-to-back emails from me.
> 
> Please ignore my message above... I think after re-reading the code,
> here's where I've arrived:
> 
>   - refill_work needs to hold RTNL (as in the existing patch)
> 
>   - virtnet_rx_pause, virtnet_rx_resume, virtnet_tx_pause,
>     virtnet_tx_resume -- all do NOT need to hold RTNL because it is
>     already held in the ethtool resize path and the XSK path, as you
>     explained, but I mis-read (sorry).
> 
>   - virtnet_disable_queue_pair and virtnet_enable_queue_pair both
>     need to hold RTNL only when called via power management, but not
>     when called via ndo_open or ndo_close
> 
> Is my understanding correct and does it match your understanding?
> 
> If so, that means there are two issues:
> 
>   1. Fixing the hardcoded bools in rx_pause, rx_resume, tx_pause,
>      tx_resume (all should be false, RTNL is not needed).
> 
>   2. Handling the power management case which calls virtnet_open and
>      virtnet_close.
> 
> I made a small diff included below as an example of a possible
> solution:
> 
>   1. Modify virtnet_disable_queue_pair and virtnet_enable_queue_pair
>      to take a "bool need_rtnl" and pass it through to the helpers
>      they call.
> 
>   2. Create two helpers, virtnet_do_open and virt_do_close both of
>      which take struct net_device *dev, bool need_rtnl. virtnet_open
>      and virtnet_close are modified to call the helpers and pass
>      false for need_rtnl. The power management paths call the
>      helpers and pass true for need_rtnl. (fixes issue 2 above)
> 
>   3. Fix the bools for rx_pause, rx_resume, tx_pause, tx_resume to
>      pass false since all paths that I could find that lead to these
>      functions hold RTNL. (fixes issue 1 above)
> 
> See the diff below (which can be applied on top of patch 3) to see
> what it looks like.
> 
> If you are OK with this approach, I will send a v5 where patch 3
> includes the changes shown in this diff.
> 
> Please let me know what you think:



Looks ok I think.

> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 13bb4a563073..76ecb8f3ce9a 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3098,14 +3098,16 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
>  	return received;
>  }
>  
> -static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_index)
> +static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_index,
> +				       bool need_rtnl)
>  {
> -	virtnet_napi_tx_disable(&vi->sq[qp_index], false);
> -	virtnet_napi_disable(&vi->rq[qp_index], false);
> +	virtnet_napi_tx_disable(&vi->sq[qp_index], need_rtnl);
> +	virtnet_napi_disable(&vi->rq[qp_index], need_rtnl);
>  	xdp_rxq_info_unreg(&vi->rq[qp_index].xdp_rxq);
>  }
>  
> -static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
> +static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index,
> +				     bool need_rtnl)
>  {
>  	struct net_device *dev = vi->dev;
>  	int err;
> @@ -3120,8 +3122,8 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
>  	if (err < 0)
>  		goto err_xdp_reg_mem_model;
>  
> -	virtnet_napi_enable(&vi->rq[qp_index], false);
> -	virtnet_napi_tx_enable(&vi->sq[qp_index], false);
> +	virtnet_napi_enable(&vi->rq[qp_index], need_rtnl);
> +	virtnet_napi_tx_enable(&vi->sq[qp_index], need_rtnl);
>  
>  	return 0;
>  
> @@ -3156,7 +3158,7 @@ static void virtnet_update_settings(struct virtnet_info *vi)
>  		vi->duplex = duplex;
>  }
>  
> -static int virtnet_open(struct net_device *dev)
> +static int virtnet_do_open(struct net_device *dev, bool need_rtnl)
>  {
>  	struct virtnet_info *vi = netdev_priv(dev);
>  	int i, err;
> @@ -3169,7 +3171,7 @@ static int virtnet_open(struct net_device *dev)
>  			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
>  				schedule_delayed_work(&vi->refill, 0);
>  
> -		err = virtnet_enable_queue_pair(vi, i);
> +		err = virtnet_enable_queue_pair(vi, i, need_rtnl);
>  		if (err < 0)
>  			goto err_enable_qp;
>  	}
> @@ -3190,13 +3192,18 @@ static int virtnet_open(struct net_device *dev)
>  	cancel_delayed_work_sync(&vi->refill);
>  
>  	for (i--; i >= 0; i--) {
> -		virtnet_disable_queue_pair(vi, i);
> +		virtnet_disable_queue_pair(vi, i, need_rtnl);
>  		virtnet_cancel_dim(vi, &vi->rq[i].dim);
>  	}
>  
>  	return err;
>  }
>  
> +static int virtnet_open(struct net_device *dev)
> +{
> +	return virtnet_do_open(dev, false);
> +}
> +
>  static int virtnet_poll_tx(struct napi_struct *napi, int budget)
>  {
>  	struct send_queue *sq = container_of(napi, struct send_queue, napi);
> @@ -3373,7 +3380,7 @@ static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
>  	bool running = netif_running(vi->dev);
>  
>  	if (running) {
> -		virtnet_napi_disable(rq, true);
> +		virtnet_napi_disable(rq, false);
>  		virtnet_cancel_dim(vi, &rq->dim);
>  	}
>  }
> @@ -3386,7 +3393,7 @@ static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_queue *rq)
>  		schedule_delayed_work(&vi->refill, 0);
>  
>  	if (running)
> -		virtnet_napi_enable(rq, true);
> +		virtnet_napi_enable(rq, false);
>  }
>  
>  static int virtnet_rx_resize(struct virtnet_info *vi,
> @@ -3415,7 +3422,7 @@ static void virtnet_tx_pause(struct virtnet_info *vi, struct send_queue *sq)
>  	qindex = sq - vi->sq;
>  
>  	if (running)
> -		virtnet_napi_tx_disable(sq, true);
> +		virtnet_napi_tx_disable(sq, false);
>  
>  	txq = netdev_get_tx_queue(vi->dev, qindex);
>  
> @@ -3449,7 +3456,7 @@ static void virtnet_tx_resume(struct virtnet_info *vi, struct send_queue *sq)
>  	__netif_tx_unlock_bh(txq);
>  
>  	if (running)
> -		virtnet_napi_tx_enable(sq, true);
> +		virtnet_napi_tx_enable(sq, false);
>  }
>  
>  static int virtnet_tx_resize(struct virtnet_info *vi, struct send_queue *sq,
> @@ -3708,7 +3715,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>  	return 0;
>  }
>  
> -static int virtnet_close(struct net_device *dev)
> +static int virtnet_do_close(struct net_device *dev, bool need_rtnl)
>  {
>  	struct virtnet_info *vi = netdev_priv(dev);
>  	int i;
> @@ -3727,7 +3734,7 @@ static int virtnet_close(struct net_device *dev)
>  	cancel_work_sync(&vi->config_work);
>  
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
> -		virtnet_disable_queue_pair(vi, i);
> +		virtnet_disable_queue_pair(vi, i, need_rtnl);
>  		virtnet_cancel_dim(vi, &vi->rq[i].dim);
>  	}
>  
> @@ -3736,6 +3743,11 @@ static int virtnet_close(struct net_device *dev)
>  	return 0;
>  }
>  
> +static int virtnet_close(struct net_device *dev)
> +{
> +	return virtnet_do_close(dev, false);
> +}
> +
>  static void virtnet_rx_mode_work(struct work_struct *work)
>  {
>  	struct virtnet_info *vi =
> @@ -5682,7 +5694,7 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
>  	netif_device_detach(vi->dev);
>  	netif_tx_unlock_bh(vi->dev);
>  	if (netif_running(vi->dev))
> -		virtnet_close(vi->dev);
> +		virtnet_do_close(vi->dev, true);
>  }
>  
>  static int init_vqs(struct virtnet_info *vi);
> @@ -5702,7 +5714,7 @@ static int virtnet_restore_up(struct virtio_device *vdev)
>  	enable_rx_mode_work(vi);
>  
>  	if (netif_running(vi->dev)) {
> -		err = virtnet_open(vi->dev);
> +		err = virtnet_do_open(vi->dev, false);
>  		if (err)
>  			return err;
>  	}


