Return-Path: <netdev+bounces-110255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A9992B9CD
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 14:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB3CF2867DC
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 12:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B3615B0EC;
	Tue,  9 Jul 2024 12:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iVr7lW5h"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43BA15ADBB
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 12:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720529135; cv=none; b=WFTTtBln7tKjp8RMN2NYzYijUICYKI+RpR1WnrCJlmJIISmRLJIE0+FgnY+dER/YMKsC1ml/eBmj7tO3vkBEt2YTYtE847sBALB1sk/GROSAgTOSlmyW0zOnyRsRxZWzNX+Imq01195VrhgD4ZNCFvuEJufqw4ck+xw9VcCnOco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720529135; c=relaxed/simple;
	bh=qkDSpZl31i+/hBrfQgJpmqiStGg52BC4bBURCAoFLMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBYh0HJ+B+L1AynUlPU+y7NuAKa3w7z0Dlfyc2lsUIwMudRT+VaYuq894OPwVukAYfp1NDltJk04GQixP5OsWTZQhdCtgDP1NIWovvwFcKFt7YuE+l1fu2taAhIE+IbJ2whUjzcv414XK2n1JAlYpDW8cUNXs548xLlWX1H6IW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iVr7lW5h; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720529132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5CTLeRlDMVVXgOXwJHhEJME+SCXM+Wt3vrFV6ZQ+bKs=;
	b=iVr7lW5hqKMHE0cyMdSiLO1QjzLpwc+2al3NvUJuoT2eDp/gOzlWHaDq8EH8nb11psYkaw
	FE9UGeaeuKo7Nxp0kAYW2BqQH0kz+WPgHT6flsWcBJ69FjqH2DDlgYvZXkuc7adUXjBTA1
	zfcWekHtdBC34E0jP8yfxrUVhAvSj00=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-Zi-qBVooP_SfVZWOcQoRnw-1; Tue, 09 Jul 2024 08:45:30 -0400
X-MC-Unique: Zi-qBVooP_SfVZWOcQoRnw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-367987cff30so3465374f8f.1
        for <netdev@vger.kernel.org>; Tue, 09 Jul 2024 05:45:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720529129; x=1721133929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5CTLeRlDMVVXgOXwJHhEJME+SCXM+Wt3vrFV6ZQ+bKs=;
        b=DdEA7Y/t2RG8ODeRMHWBM7xN/IVd6GkU4b/KYDxW3LJ4kCMWl9ux3HL9RAxtDtsh8R
         WuVP+HWPJU4DJxANa1Que5jrtzlsJ7rmHKg65vOc6uSPARHBY3iLrHYeXzgCMCrjc4qx
         IIVMwi3z+U4MrZ666UTWQrDIFJAWxfL9j62Th2i+UUeQhTADQAIRheS839OUeUeREGgh
         I0snAkVMp2N0cAhWOux6uhKnsXPND6Kud2VIprYHGcW9toGgNKpxEG5VhIxXh9VBGNiB
         fqhIxgiobE3V71dVnT9YRsaSisnsCuqzHrmQhCG3cJ8FQNP5nPjA5AJNcjcQxwYUnMNU
         nmPg==
X-Forwarded-Encrypted: i=1; AJvYcCVOe4HHDyMxhmkOVAhKiXjP1XO6uPKtBMLq//Sn6/GqYI642I/MYFrTFIaIRtKpucnX7d0RYkdv/t2m1OS7ZP1v07YMg5Ct
X-Gm-Message-State: AOJu0YyVjQN5TqMvVkc9Q/WcylHuXZ6sR92jfbf1IDqJcvPY0qxGmC7A
	w1AarhGp6WMGdBdakgnQbLgBtFVAaqbQH5BqcgjKbO/Sk9laVOSnmCFQFHWvD+G9uTx5kJw8ru8
	Q5MCYWRb4bUvJUP3gpzXdIHGv5xoAe9hgyaUSmbe0em9RgCgnYbh17A==
X-Received: by 2002:adf:f583:0:b0:367:9037:d075 with SMTP id ffacd0b85a97d-367cea9630amr1798611f8f.37.1720529128909;
        Tue, 09 Jul 2024 05:45:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEI/62fYWAbov6M9yXYpN3yUDAfLjP7a0+LrXAwktHtFKQNHUlKIC+VwSXZ4cuHu7iJoLYIAA==
X-Received: by 2002:adf:f583:0:b0:367:9037:d075 with SMTP id ffacd0b85a97d-367cea9630amr1798594f8f.37.1720529128422;
        Tue, 09 Jul 2024 05:45:28 -0700 (PDT)
Received: from redhat.com ([2.52.29.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfa0689sm2450765f8f.85.2024.07.09.05.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 05:45:27 -0700 (PDT)
Date: Tue, 9 Jul 2024 08:45:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Li RongQing <lirongqing@baidu.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	hengqi@linux.alibaba.com, virtualization@lists.linux.dev,
	netdev@vger.kernel.org
Subject: Re: [PATCH] virtio_net: Use u64_stats_fetch_begin() for stats fetch
Message-ID: <20240709084312-mutt-send-email-mst@kernel.org>
References: <20240619025529.5264-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619025529.5264-1-lirongqing@baidu.com>

On Wed, Jun 19, 2024 at 10:55:29AM +0800, Li RongQing wrote:
> This place is fetching the stats, so u64_stats_fetch_begin
> and u64_stats_fetch_retry should be used
> 
> Fixes: 6208799553a8 ("virtio-net: support rx netdim")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

So I dropped this from my tree, if you think it's
still necessary, pls resubmit to net-next.

Thanks!

> ---
>  drivers/net/virtio_net.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 61a57d1..b669e73 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2332,16 +2332,18 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
>  static void virtnet_rx_dim_update(struct virtnet_info *vi, struct receive_queue *rq)
>  {
>  	struct dim_sample cur_sample = {};
> +	unsigned int start;
>  
>  	if (!rq->packets_in_napi)
>  		return;
>  
> -	u64_stats_update_begin(&rq->stats.syncp);
> -	dim_update_sample(rq->calls,
> -			  u64_stats_read(&rq->stats.packets),
> -			  u64_stats_read(&rq->stats.bytes),
> -			  &cur_sample);
> -	u64_stats_update_end(&rq->stats.syncp);
> +	do {
> +		start = u64_stats_fetch_begin(&rq->stats.syncp);
> +		dim_update_sample(rq->calls,
> +				u64_stats_read(&rq->stats.packets),
> +				u64_stats_read(&rq->stats.bytes),
> +				&cur_sample);
> +	} while (u64_stats_fetch_retry(&rq->stats.syncp, start));
>  
>  	net_dim(&rq->dim, cur_sample);
>  	rq->packets_in_napi = 0;
> -- 
> 2.9.4


