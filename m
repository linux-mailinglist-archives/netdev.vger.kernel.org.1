Return-Path: <netdev+bounces-245957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F1DCDBF4C
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 11:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C98130358D2
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 10:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF41312835;
	Wed, 24 Dec 2025 10:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X3kpaFEQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="p8gIe8Fk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1AE3126D0
	for <netdev@vger.kernel.org>; Wed, 24 Dec 2025 10:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766571619; cv=none; b=duaaxUMdkl6vmAe1TjHh+C8thJsH5kT7co7bU+LqRjGIpfbpHNh83GImMWE20qwzgDiZYhhWRyrloU0XwU5KXWKp3ag2W08u9M2l7Nkhnv2umFY+JQY2fY9VY7NxVDf7Zh+ZzRxW1WxeNf5ASviYMW5IgXVcWoTEQxfU+f5Z/no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766571619; c=relaxed/simple;
	bh=oYrwPO86ZCxudCbsRZuqfzHLWeJAOAoyrphKxk8LHjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1njG1RXJxYvDKZgxoDJ/IUMyXAyOJVvrpTQyi/PDLFyMmVunU0vWexUsBGHq3SL9g03kMt55+jrZI3vi/yqeY7QBswhVAQyepM5QYDVD1z0CxpTHCpXpKT4YlLIybDlvouiZuk73wJE632oRJj7+h2V2n25NqVx52Rth438zQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X3kpaFEQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=p8gIe8Fk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766571616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6O2EtwV8zLDpt91a2UuKYvEZqcHN8Sgzg6sMdCfF3b8=;
	b=X3kpaFEQ9r8/LPJItKyaU7unz+v6wFYxphUFVvDn8u9ZdJZPQd/86Bz9g1D4hCD7Uo/81K
	EXBrwU79+/8FUSy/USanI8+g2OZeLE4AIj2S97pL5UjkVGyCz/3zK9ROVrNFIU3JUi5gWi
	NTRW9Lpju4IFIva00GXgp9lTJx5ANYs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-HxCQ6IyJNASI3qZd-Nqcjw-1; Wed, 24 Dec 2025 05:20:14 -0500
X-MC-Unique: HxCQ6IyJNASI3qZd-Nqcjw-1
X-Mimecast-MFC-AGG-ID: HxCQ6IyJNASI3qZd-Nqcjw_1766571613
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47d40e8a588so448785e9.3
        for <netdev@vger.kernel.org>; Wed, 24 Dec 2025 02:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766571613; x=1767176413; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6O2EtwV8zLDpt91a2UuKYvEZqcHN8Sgzg6sMdCfF3b8=;
        b=p8gIe8Fk542Na8IvMjt7FR9THEKInLYVKz7A2BKB+TLh0zlK3le6LT5nRblRxy3xYM
         NBGs8Gyz+3uGNYVeF6KN0SyZn1VpqTr1mNke9bvSopxGlOjlAotPEE7uCBz4PxSo+R9D
         uYFjrxGEpIbiqnqKTlIx+0HZ2AjI6lzTg9JaJZVtYxUQ7UEiq98yJi8Q/5U6PCYu0gwq
         n8k53XgfQmW5S2huII8+ZlesqsUc7BRZnUKv78Io1axlOw+xqsY1LgVQRhhpcqvC1RA8
         66emyeZpaIC8qQiDglkB4cssI6IcSRDSLvAHi/b9qFmK8HKdBNb2hT+U+0JsReh3v/cy
         zvwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766571613; x=1767176413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6O2EtwV8zLDpt91a2UuKYvEZqcHN8Sgzg6sMdCfF3b8=;
        b=vi3FYkAUV8n4OuP8hfckJiEAtOSsReIefD8dMlSZv9to7AmYnqa8icaoYL5ZyK4QNU
         t//Ac3LRFBudkV2Z2VON4akDlHNnJz9crfPwntYLWmjrM2x3TURV4RW09xtutydWsxtI
         pEM0zIN5coKOcMFfNJNSZBJWi09P1GC46LDycXoZrtWq3IvPfpmRFkh4Fb5sycZQvUSM
         aOV+AUMbFmzSkc29SExOFGSGg7z1loHymxWtVlZyHR0F85K0zEUF10fASkdLa+3I6+iC
         D7T2N8FSJ/EW3x9gnd1R6rJTVj+q8IdOd/IoFXpQe1kFYX0rIFUeRGtgxMgL3Mn1Ifxg
         ki4A==
X-Gm-Message-State: AOJu0YzLBNN4IS/xKmzRaL4GLZLRCCqiLKnXgMGN61zwatFpENv2pokQ
	D2WJADbDA2gPFThcZXLlZGMt8MdrqLyYalzutWtQm1hJCflkPNg/vRSlJ/A2JNEHBRQHKsq4xYQ
	4ylQ3Ybu9kvw3EvaVa/atKuyr4BMkBTxiykqIrrA0HJ8yr0ldWRvL0wzrLA==
X-Gm-Gg: AY/fxX4D+Ua8RnTMzHp3Xotg3546CGIGSmfG1WywwgsP5oOehp62f+ripNAEaBqOUSA
	+xVNRVKmRAqZs3LFj4niVd307Lu6YX5OI03RzzeHX44Go/jIXzDvWJm32y/Rc5306PfaVNxTsCW
	LozlnIeAENcA5zMM3C1UZ8/Iqzl/h/9fw0e9pSLeItBVBaU/KjNwOGb8rJ79RMmks4GvANgBbwc
	GESkP6dPjQ5rakN/xTVETdFD4/uDiuU32Fd2KdMf4axPzt8UiqwqeubR6bI5vHPEXxqlKqmo2nR
	sMbEtCjxJIX9GYXlpa2D5BuyO3KPaV6fF1Q6wujCtRX0iKdbW0GUAbza/fy23raEuPVr/XOJ8/z
	Z
X-Received: by 2002:a05:600c:350c:b0:477:7658:572a with SMTP id 5b1f17b1804b1-47d19584900mr150239425e9.20.1766571613416;
        Wed, 24 Dec 2025 02:20:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmKYK5ou+1W1Pze+hjbzHTs9SfZ3rn+HzocgNknKunmQm1zT8c7gWFoIrC37NzpjjUkVO+xA==
X-Received: by 2002:a05:600c:350c:b0:477:7658:572a with SMTP id 5b1f17b1804b1-47d19584900mr150239105e9.20.1766571612873;
        Wed, 24 Dec 2025 02:20:12 -0800 (PST)
Received: from redhat.com ([31.187.78.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be3a40a14sm146641555e9.2.2025.12.24.02.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 02:20:12 -0800 (PST)
Date: Wed, 24 Dec 2025 05:20:09 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net 2/3] virtio-net: ensure rx NAPI is enabled before
 enabling refill work
Message-ID: <20251224051936-mutt-send-email-mst@kernel.org>
References: <20251223152533.24364-1-minhquangbui99@gmail.com>
 <20251223152533.24364-3-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223152533.24364-3-minhquangbui99@gmail.com>

On Tue, Dec 23, 2025 at 10:25:32PM +0700, Bui Quang Minh wrote:
> Calling napi_disable() on an already disabled napi can cause the
> deadlock.

a deadlock?

> Because the delayed refill work will call napi_disable(), we
> must ensure that refill work is only enabled and scheduled after we have
> enabled the rx queue's NAPI.


a bugfix so needs a Fixes tag.

> 
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
>  drivers/net/virtio_net.c | 31 ++++++++++++++++++++++++-------
>  1 file changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 63126e490bda..8016d2b378cf 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3208,16 +3208,31 @@ static int virtnet_open(struct net_device *dev)
>  	int i, err;
>  
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
> +		bool schedule_refill = false;
> +
> +		/* - We must call try_fill_recv before enabling napi of the same
> +		 * receive queue so that it doesn't race with the call in
> +		 * virtnet_receive.
> +		 * - We must enable and schedule delayed refill work only when
> +		 * we have enabled all the receive queue's napi. Otherwise, in
> +		 * refill_work, we have a deadlock when calling napi_disable on
> +		 * an already disabled napi.
> +		 */
>  		if (i < vi->curr_queue_pairs) {
> -			enable_delayed_refill(&vi->rq[i]);
>  			/* Make sure we have some buffers: if oom use wq. */
>  			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
> -				schedule_delayed_work(&vi->rq[i].refill, 0);
> +				schedule_refill = true;
>  		}
>  
>  		err = virtnet_enable_queue_pair(vi, i);
>  		if (err < 0)
>  			goto err_enable_qp;
> +
> +		if (i < vi->curr_queue_pairs) {
> +			enable_delayed_refill(&vi->rq[i]);
> +			if (schedule_refill)
> +				schedule_delayed_work(&vi->rq[i].refill, 0);
> +		}
>  	}
>  
>  	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> @@ -3456,11 +3471,16 @@ static void __virtnet_rx_resume(struct virtnet_info *vi,
>  	bool running = netif_running(vi->dev);
>  	bool schedule_refill = false;
>  
> +	/* See the comment in virtnet_open for the ordering rule
> +	 * of try_fill_recv, receive queue napi_enable and delayed
> +	 * refill enable/schedule.
> +	 */
>  	if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
>  		schedule_refill = true;
>  	if (running)
>  		virtnet_napi_enable(rq);
>  
> +	enable_delayed_refill(rq);
>  	if (schedule_refill)
>  		schedule_delayed_work(&rq->refill, 0);
>  }
> @@ -3470,18 +3490,15 @@ static void virtnet_rx_resume_all(struct virtnet_info *vi)
>  	int i;
>  
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
> -		if (i < vi->curr_queue_pairs) {
> -			enable_delayed_refill(&vi->rq[i]);
> +		if (i < vi->curr_queue_pairs)
>  			__virtnet_rx_resume(vi, &vi->rq[i], true);
> -		} else {
> +		else
>  			__virtnet_rx_resume(vi, &vi->rq[i], false);
> -		}
>  	}
>  }
>  
>  static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_queue *rq)
>  {
> -	enable_delayed_refill(rq);
>  	__virtnet_rx_resume(vi, rq, true);
>  }
>  
> -- 
> 2.43.0


