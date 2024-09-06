Return-Path: <netdev+bounces-125840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC9C96EE71
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 10:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B0801F2332D
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 08:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F8615854D;
	Fri,  6 Sep 2024 08:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b9dPKSJe"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C7F15278E
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 08:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725612229; cv=none; b=mnnu2M56E93sSmPW6Ukp84jsjD+FK+kgEDr32HHdvGms63ao2yDG3Ls6upf4Qi2Ay0zYLuM2X2SycruHJUVWNvn+XhzLpTVgs/1egmM+Kp+iNky+U+CWVk6ByCA5SjMlDgSfZvherRTLL10hw/Np4V2MLEtL4Vcyokl7b1tte8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725612229; c=relaxed/simple;
	bh=sYAOHM0OcG0NaZIXeSEYiH/+ryFpU5Tt0KGgp831Ug8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OLhamxShSvMSn9n5wvv1vN3yfHa752bNpItaRiVmcNJOxIwT3YQa8bO4jMDI60T1jbVRtit5hA3A2TTH6oFRWHzfxXPxsM8XyRUZn/PcFzkggHYuDzP0GLbf4SgMo93AXvahakfzXRwmKSBwzxOkQ8+PPOd26eAYi1F4pADiKcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b9dPKSJe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725612226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IO25rrrQNWDfL7Bn6AqoZkvugHO7UKf+pbprMwvZuwI=;
	b=b9dPKSJegRQ7tV+YHCxyhm5l3mQgfR7+FZFr/xVHbhQSkyQlwhJRhVu1VZ2qAEvvsmv91y
	fyP0Vx9hxZatSqlKSOaetLaM8aKmIvwbOlvkuWSxmzUxTmw1CfB8RMBI56+3BN9yE6rcFr
	REIcefifV+Z0w0zXcudN2L4BrDCWuyY=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-fK3Ot58hNV-MsD9B3qvaXg-1; Fri, 06 Sep 2024 04:43:45 -0400
X-MC-Unique: fK3Ot58hNV-MsD9B3qvaXg-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2f7564eda12so1082081fa.3
        for <netdev@vger.kernel.org>; Fri, 06 Sep 2024 01:43:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725612224; x=1726217024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IO25rrrQNWDfL7Bn6AqoZkvugHO7UKf+pbprMwvZuwI=;
        b=ShzeaT9KfULmvkhncBzrZw0dRsQRkeAPS5Nkr3v2WF3JhuRnurqyKTJ7xXlJbg5vzN
         TrCui5dUEKlxb/i2Mgejchv+Ii79Mwwnotj6Ik9ygqqHcRE7NRSjsJ2YjPm++QLqMNH4
         uwHUH1P7lzpKHocIdRWbcnIjCq4uCLq7hFfnvI2GKSSjbYlcsmimJkCZefxAYhASxZwv
         7Lu/DOiPkHRH1vhxDalAs5pei7nN5yAXxTPUFCcXpRq5xbTJRmH6n9HdN2Zjz2+CJ2Cj
         QykXUi5eJnNFAN9LjvIVEUmA9qmjENkmBdjbMPwNeg/zGSbYDOFK2ORVUxlIq98YtuQl
         IjNw==
X-Gm-Message-State: AOJu0Yyf1062Pk6UT6Lvlsnw0kPpTpb16pQMAadILN++7FzNS8B1hPKD
	mbc2nbXFJQsGNf5GbIFJBEk0syI7dfeZ8em/gSKPrwDDCgdK0iijqs+5SiEtA/8MneKKMezARJf
	o+8MGRtl2i+1HR7Wm7jToAlqa/ADtp/dQ86q7Cr8/q2p8+6xu4h+C2w==
X-Received: by 2002:a05:651c:1991:b0:2ec:568e:336e with SMTP id 38308e7fff4ca-2f751eaee1bmr12706901fa.1.1725612223734;
        Fri, 06 Sep 2024 01:43:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGT+z1w/z6YN28OpYeQ2dCulE2Kp/kot3f3CSP7P9f6Mz64pmj479twCfW6YqxPhHrxWVHjkg==
X-Received: by 2002:a05:651c:1991:b0:2ec:568e:336e with SMTP id 38308e7fff4ca-2f751eaee1bmr12706321fa.1.1725612222476;
        Fri, 06 Sep 2024 01:43:42 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f8:6afa:d56e:f70d:1d1b:3f10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca05c6340sm13175775e9.4.2024.09.06.01.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 01:43:41 -0700 (PDT)
Date: Fri, 6 Sep 2024 04:43:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev, Si-Wei Liu <si-wei.liu@oracle.com>,
	Darren Kenny <darren.kenny@oracle.com>
Subject: Re: [PATCH net] virtio-net: fix overflow inside virtnet_rq_alloc
Message-ID: <20240906044143-mutt-send-email-mst@kernel.org>
References: <20240820071913.68004-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820071913.68004-1-xuanzhuo@linux.alibaba.com>

On Tue, Aug 20, 2024 at 03:19:13PM +0800, Xuan Zhuo wrote:
> leads to regression on VM with the sysctl value of:
> 
> - net.core.high_order_alloc_disable=1
> 
> which could see reliable crashes or scp failure (scp a file 100M in size
> to VM):
> 
> The issue is that the virtnet_rq_dma takes up 16 bytes at the beginning
> of a new frag. When the frag size is larger than PAGE_SIZE,
> everything is fine. However, if the frag is only one page and the
> total size of the buffer and virtnet_rq_dma is larger than one page, an
> overflow may occur. In this case, if an overflow is possible, I adjust
> the buffer size. If net.core.high_order_alloc_disable=1, the maximum
> buffer size is 4096 - 16. If net.core.high_order_alloc_disable=0, only
> the first buffer of the frag is affected.
> 
> Fixes: f9dac92ba908 ("virtio_ring: enable premapped mode whatever use_dma_api")
> Reported-by: "Si-Wei Liu" <si-wei.liu@oracle.com>
> Closes: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>


Guys where are we going with this? We have a crasher right now,
if this is not fixed ASAP I'd have to revert a ton of
work Xuan Zhuo just did.


> ---
>  drivers/net/virtio_net.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index c6af18948092..e5286a6da863 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -918,9 +918,6 @@ static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
>  	void *buf, *head;
>  	dma_addr_t addr;
>  
> -	if (unlikely(!skb_page_frag_refill(size, alloc_frag, gfp)))
> -		return NULL;
> -
>  	head = page_address(alloc_frag->page);
>  
>  	dma = head;
> @@ -2421,6 +2418,9 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
>  	len = SKB_DATA_ALIGN(len) +
>  	      SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>  
> +	if (unlikely(!skb_page_frag_refill(len, &rq->alloc_frag, gfp)))
> +		return -ENOMEM;
> +
>  	buf = virtnet_rq_alloc(rq, len, gfp);
>  	if (unlikely(!buf))
>  		return -ENOMEM;
> @@ -2521,6 +2521,12 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
>  	 */
>  	len = get_mergeable_buf_len(rq, &rq->mrg_avg_pkt_len, room);
>  
> +	if (unlikely(!skb_page_frag_refill(len + room, alloc_frag, gfp)))
> +		return -ENOMEM;
> +
> +	if (!alloc_frag->offset && len + room + sizeof(struct virtnet_rq_dma) > alloc_frag->size)
> +		len -= sizeof(struct virtnet_rq_dma);
> +
>  	buf = virtnet_rq_alloc(rq, len + room, gfp);
>  	if (unlikely(!buf))
>  		return -ENOMEM;
> -- 
> 2.32.0.3.g01195cf9f


