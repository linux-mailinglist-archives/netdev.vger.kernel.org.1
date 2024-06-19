Return-Path: <netdev+bounces-104785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 522E590E5B9
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 10:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CE911C209DD
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 08:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D663A6F308;
	Wed, 19 Jun 2024 08:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dgw9dv2L"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B6579945
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 08:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718786098; cv=none; b=SkO+o53YRuKCQaqsjmfECCTXFDjKQo6WZyBndgJ4PJFWR2ulWxjVTz4l5N2mS7tWFjhfL0t97akb4QIO2KblgZgBc8LGiPsqutI8ZS5kTbr57kxfDk+isnuREO3xKKOh7HZhCwFM0z7SYCM8yTOOiJv9ENLr2/QixuhIbBFG4vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718786098; c=relaxed/simple;
	bh=k77wwIYfk4GFZNw66tp4JkI39o9Zc0+HKnCadVtNoG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kSP1ewP94RRMdZJ/FXTMP5nLYY1a92WTO6cmlaGOlh9lPJlDdTD7PNUGx0CPB8MxPeZ4taa+KEclH11rFYvGbFFJ7wH+EoFjjGStbAQZa+y/uRrnv46/+4fSFnZiP7NkhFfmtxdg9XDUw+YxzqMLkvrshiFKVvXIhBOP1Q1Vn+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dgw9dv2L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718786096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7QorzhMTdYqM8xg9nGlxbgOsetEP7RIhSroBgawoQok=;
	b=dgw9dv2LzOXRvP99NzBvNh5KftRx48YFMgFpVuP+yHSCbm75j35L+kWzW+7yUt04lwp2FU
	Z1q1txmWS/uknL0YcutjEn6gQcb6AzZjR8Azy9stdoEPhWFP6Qte2shLJoSsH45EnL8WMK
	8CJIm+/H/l4IqUslKGhuZ+yGuL16Q1A=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-rfWdGJ4DN5mEta29JMyqYg-1; Wed, 19 Jun 2024 04:34:54 -0400
X-MC-Unique: rfWdGJ4DN5mEta29JMyqYg-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ec3d6c2cf1so5369591fa.1
        for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 01:34:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718786092; x=1719390892;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QorzhMTdYqM8xg9nGlxbgOsetEP7RIhSroBgawoQok=;
        b=r5scn4FPKZp/3r9xeU+S905XjdlB/9abxAqLxRDyc2X3PyTru/2iebBiushI/sBaFk
         0nVg09eyCYFU8iIsWYkaXMNRURH/73mnV6I0qPjUI9ZbO8use54G6VewbLaH36xfiMWW
         dDNnZP5beglSphq4TyYgn5Y9SFCF2KZfxgc+JLwacxmxTahtFbDAhmeVCJbxoYSow6rC
         dFphwsbJx7OSq/181KZEXgobWJuQMs5NStClU424ngAj4M+U5R09BcSdBEPPRqNK4ijH
         JB4b7F2K+VMUOK5wqJ4zOI6cOHF+uQopOGyCY1HOiDwZwvJdseE3djpxg4zlQIoBVmJy
         tGWA==
X-Forwarded-Encrypted: i=1; AJvYcCX2us6gACOiPVTe2J5XGNFuTKnkWaHOm25PdI+DD3zs4C35DYxY8g8RROLOUkrb2eIk6GUUALBmmo9rUHTJUT6w14cM4pkY
X-Gm-Message-State: AOJu0YzwfowFFDy+2nRLIyntodOjv07JtttDjMjp/ItkYt/SyoTzGwFz
	e1Ohs34DXMJ9X+QLmzE4Xzv6HseVfsjKPJ9XRefnz5OMOxUS9wzwrjlpZxp0+GlfQx+Q7+a9NCf
	SZRHBHjqlWxTNYl+JCwSc7GDnhZDvhffpci/J61Ugb8lHHIUIFN4iYw==
X-Received: by 2002:a2e:2c13:0:b0:2ea:e204:afc2 with SMTP id 38308e7fff4ca-2ec3ceb71ffmr13854591fa.12.1718786092662;
        Wed, 19 Jun 2024 01:34:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6dGM5Ja1VGAOzdN1hQxZfOXjSTyTvg4DIiNH2Kw0m4EIQmBe70gslkXkc0676k76zPfXPTA==
X-Received: by 2002:a2e:2c13:0:b0:2ea:e204:afc2 with SMTP id 38308e7fff4ca-2ec3ceb71ffmr13854371fa.12.1718786092175;
        Wed, 19 Jun 2024 01:34:52 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422870e9681sm259166805e9.28.2024.06.19.01.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 01:34:51 -0700 (PDT)
Date: Wed, 19 Jun 2024 04:34:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Li RongQing <lirongqing@baidu.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	hengqi@linux.alibaba.com, virtualization@lists.linux.dev,
	netdev@vger.kernel.org
Subject: Re: [PATCH] virtio_net: Use u64_stats_fetch_begin() for stats fetch
Message-ID: <20240619043442-mutt-send-email-mst@kernel.org>
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

Acked-by: Michael S. Tsirkin <mst@redhat.com>

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


