Return-Path: <netdev+bounces-111051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5DF92F91C
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 12:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11CE71C220AD
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 10:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01476158A35;
	Fri, 12 Jul 2024 10:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FWkp/6dq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C6915444E
	for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 10:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720780904; cv=none; b=mwnSXCZV0aKlq4JUXh4iT4zCgslpxXuPkqqbpSWV539PVezlEkIogLv97m3wMEiwqeJOkm6/jO7LRF4We4SsDtiHTaPgQMqs28fEgNRESCAjDqLH+Wok4r1BS5w01UoPEJgc1Ui9ncO2iaxLO2gpRhlg+LCjNC3mdkOMMxUCb0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720780904; c=relaxed/simple;
	bh=YzBJLaP5b66CE8Z23dlgpk1BztCreho1AUoOB+MtsC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s8avvuHTC3/zB7CT/tcQi6D8ZdBvfCVn6zsb6SzF8pdhY4WfJGaVsdp97Fifk/Pg3ZzM5g/o5uBcjl4ZotzOFW0f2aYMGGMwrgRslP1je6rySqOiAflx5dNe40U+szKt2DXsFk7CAYRoQ0C2K4PIKOuhcUw9x2FV3JXModxgJ4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FWkp/6dq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720780902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E67/qwqrLYs0uApKpXhnQ+HOWLOkwVXqoDhKeoX4fEM=;
	b=FWkp/6dqOpZiWKVI6fOM5iEduJIGKgict5TXpbJbaepFgPmBpb9Fk0UAqiieTS/UhI+y47
	SybCAxq/gVuouSCFqvW9r3cSfhxRXO20i3Xyhr6KPoFVT9deMiPC+upn5Wns2gr2qVHcvd
	fTTCyK504RKMmgjfQMzRxPYeosmnQv0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-j9KNDetrMLmSiOkeOSJDpw-1; Fri, 12 Jul 2024 06:41:41 -0400
X-MC-Unique: j9KNDetrMLmSiOkeOSJDpw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-426654e244dso12247605e9.3
        for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 03:41:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720780900; x=1721385700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E67/qwqrLYs0uApKpXhnQ+HOWLOkwVXqoDhKeoX4fEM=;
        b=ObSzAV4xJgv2r7/gW2yFTrWCheXfszueBSKvCsBOtSuJOUVnurl9YiTuOPKxvY4zRi
         Pst0CerOcecXVQY+bI+xcY2F5KWIcmgJZYO/u79UUDS46uewwtSzyI1M/c+Mr7n3myNr
         mBv+7osY1fEP+UdjoTQjxhnkpS3hgYcFuZrShRygWSy0HlD86lv1710/9tTIn3wlvXdA
         UeJZ1SpeUREYJltOKvLdA9Lv7Xm+P4x1TWskhM5DOSTE7bXgphshQeA2T1dtdJLs0akN
         WDfQlxysFgoT59hTLcAi5C3pf18QhOXDsQg5WkQ08WbjnFcLLZJLz5+0kW3a7YxlcoWx
         QQdg==
X-Forwarded-Encrypted: i=1; AJvYcCX9yG0kLAlc/LUDuQY00o/gS/51QNm+161g/d/98/2eCYLRMpbCV2i7gy26mNOGR9R+ZRO11/WZdJN/6f9+IdgzcxGQaTb5
X-Gm-Message-State: AOJu0YzVQMFiowERZB+m/1CT90CmLSeql0chfxw/5KvLdAvFKxsGr4PC
	EzWaSlcgpDSOBc4eaW8AXCWFRrE9syNMBGOtvQ4pdTEZYQKMiGtB7VVUaTXfSCzcgWds0h/9ehv
	AysyJkPtd0DFhTSiyANWfTASrhwFBeIh5ylQespTBow54c/roXFTWrg==
X-Received: by 2002:a05:600c:5345:b0:426:602d:a243 with SMTP id 5b1f17b1804b1-426707d8a90mr79381295e9.16.1720780899989;
        Fri, 12 Jul 2024 03:41:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8OPh1JQThp8k62evdvZ2hO2J+txRXY+8A943RJMLhueJqiK6v1NIubwHMCk3qBpabQ+QOjA==
X-Received: by 2002:a05:600c:5345:b0:426:602d:a243 with SMTP id 5b1f17b1804b1-426707d8a90mr79381035e9.16.1720780899393;
        Fri, 12 Jul 2024 03:41:39 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:341:761e:f82:fc9a:623b:3fd1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde84912sm9902723f8f.40.2024.07.12.03.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 03:41:38 -0700 (PDT)
Date: Fri, 12 Jul 2024 06:41:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, Aishwarya TCV <aishwarya.tcv@arm.com>
Subject: Re: [PATCH net-next] net: virtio: fix virtnet_sq_free_stats
 initialization
Message-ID: <20240712064019-mutt-send-email-mst@kernel.org>
References: <20240712080329.197605-2-jean-philippe@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712080329.197605-2-jean-philippe@linaro.org>

On Fri, Jul 12, 2024 at 09:03:30AM +0100, Jean-Philippe Brucker wrote:
> Commit c8bd1f7f3e61 ("virtio_net: add support for Byte Queue Limits")
> added two new fields to struct virtnet_sq_free_stats, but commit
> 23c81a20b998 ("net: virtio: unify code to init stats") accidentally
> removed their initialization. In the worst case this can trigger the BUG
> at lib/dynamic_queue_limits.c:99 because dql_completed() receives a
> random value as count. Initialize the whole structure.
> 
> Fixes: 23c81a20b998 ("net: virtio: unify code to init stats")
> Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>


Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> Both these patches are still in next so it might be possible to fix it
> up directly.

I'd be fine with squashing but I don't think it's done in net-next.

> ---
>  drivers/net/virtio_net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 10d8674eec5d2..f014802522e0f 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -530,7 +530,7 @@ static void __free_old_xmit(struct send_queue *sq, struct netdev_queue *txq,
>  	unsigned int len;
>  	void *ptr;
>  
> -	stats->bytes = stats->packets = 0;
> +	memset(stats, 0, sizeof(*stats));
>  
>  	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
>  		if (!is_xdp_frame(ptr)) {
> 
> base-commit: 3fe121b622825ff8cc995a1e6b026181c48188db
> -- 
> 2.45.2


