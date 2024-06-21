Return-Path: <netdev+bounces-105626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 865C691217E
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 12:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B62811C20D70
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 10:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC0317106C;
	Fri, 21 Jun 2024 10:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TczNLnvp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A4217085E
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 10:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718964342; cv=none; b=j0DdWfj84G3sLrl3qPdF/LLqOHWsyaviwruhoIEkAbZYYogVglfBxn8a5w7Ui3D9ZCW69P996QM7ZRKGM4D5a5gbTcA6rZc3JBhkG5E8dg4npf3/y22cv6P03VygRaNZY/dXPz3RIFGeLexQAf1kWM23Lmtj+VYmFpexQCbK5Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718964342; c=relaxed/simple;
	bh=z3gAn55zApKOXhbJtNNNEovU9DexZI97dZRk4B3iGfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CGYctNVid+eoMR+7MnK38+K+GGKf2nLPpGdmzASicZxLE6IBKUKvieIFsl6sudXVAFSNgkb7trpnC0+mHTIdneVdhoUJO+sTF/BBE3OYmV4Aea4xuWdl3QufuYV1O7upRtTKs9rKamd9MfeU3oj6fuVjeqYhtobvcjLSp27TWuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TczNLnvp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718964340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xnCJbcIUTM3zZqZ+aUiydsQ8j5UTgLqfcktZXJnD8lk=;
	b=TczNLnvpXezsldWdjM3SNMHwVv5roK9GGL6etmf0LV5gQI2zWJDVPxxtEqvPsgRTQZw0sn
	dsOhJPBx3qT7iduHVaGaO0pkRN6iidPuTbz2qruOcF26YIh9hTPF49OyzAkLBx0/Cd81f/
	rMO9mJa66wx13dKllJzfGbt65Z7ii5M=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-ZIef_vrOM5et5fH1lgWImg-1; Fri, 21 Jun 2024 06:05:38 -0400
X-MC-Unique: ZIef_vrOM5et5fH1lgWImg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a6f4af1c655so78374066b.3
        for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 03:05:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718964337; x=1719569137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xnCJbcIUTM3zZqZ+aUiydsQ8j5UTgLqfcktZXJnD8lk=;
        b=iSljOSNd4Z6d1FOdszuBrjF33BZOdGji8Lo4r9d2y3wGsHpiTuhej5oxS/RvWO8pDu
         hr6+K7zwVjUxhvMOvAZEvFJIOjXTIRtORpvYxy+5aZPWTh83WhjzceH6LNZl68W+DXV4
         zBepLn17HsmQv0mDuT76KrdWDjCOcsGuv/9jSPHSllqC3pcaTeRERVftz79qmGss+jC5
         z0t1h76KpniGWDS1uTffHVlV5M6KjXYqK+ZRbaIHlP1lP3SbrnlPKWPrvshET2uzNG+F
         DVb+Xql8GGuk639I2EzMl+7ryOSm6VNlPL7ODWmBL9B685O+ISNsqF7/kdofIIoOPwI6
         sxdw==
X-Forwarded-Encrypted: i=1; AJvYcCUewvxO4zcbe50OYiD3KufQFW02g+oQY1tT9f9TDeceKI99F48njCsKwmoyY8gQZ38KmnRzXkY1t62VWbmEQyZpefkezxsw
X-Gm-Message-State: AOJu0Yyjpn3O3KLmRAhFl/T010InPEVZd3l7Pd9MXuGMrqmfD2ZX7Y23
	BHnPO4uk2I7Pghx3SowYL1R/4PFXpuyQ7lqrQj72rE/EFRKHrA8p76pqItI5gztDwQpHp1De2Yd
	RPQ4Hu8VSVuwkpXnyXvy3UJP1SFmBVUy+y57m8SgXexiuURUtOoVsng==
X-Received: by 2002:a17:906:a18e:b0:a6f:10aa:9c3f with SMTP id a640c23a62f3a-a6fab775251mr461428566b.54.1718964337315;
        Fri, 21 Jun 2024 03:05:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEO5cXegLSptfUIvR3OJv9OpZDUQt7koZiNJsSmTOWfGjLZTf2IAb1PS5HCTKZXvuzaxXTsrQ==
X-Received: by 2002:a17:906:a18e:b0:a6f:10aa:9c3f with SMTP id a640c23a62f3a-a6fab775251mr461426666b.54.1718964336665;
        Fri, 21 Jun 2024 03:05:36 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf549212sm66653166b.139.2024.06.21.03.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 03:05:36 -0700 (PDT)
Date: Fri, 21 Jun 2024 06:05:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Li RongQing <lirongqing@baidu.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	hengqi@linux.alibaba.com, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, kuba@kernel.org
Subject: Re: [PATCH][net-next,v2] virtio_net: Remove
 u64_stats_update_begin()/end() for stats fetch
Message-ID: <20240621060504-mutt-send-email-mst@kernel.org>
References: <20240621094552.53469-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621094552.53469-1-lirongqing@baidu.com>

On Fri, Jun 21, 2024 at 05:45:52PM +0800, Li RongQing wrote:
> This place is fetching the stats, u64_stats_update_begin()/end()
> should not be used, and the fetcher of stats is in the same context
> as the updater of the stats, so don't need any protection
> 
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>


I like the added comment, makes things clearer.

Acked-by: Michael S. Tsirkin <mst@redhat.com>


> ---
>  drivers/net/virtio_net.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 61a57d1..6604339 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2336,12 +2336,12 @@ static void virtnet_rx_dim_update(struct virtnet_info *vi, struct receive_queue
>  	if (!rq->packets_in_napi)
>  		return;
>  
> -	u64_stats_update_begin(&rq->stats.syncp);
> +	/* Don't need protection when fetching stats, since fetcher and
> +	 * updater of the stats are in same context */
>  	dim_update_sample(rq->calls,
>  			  u64_stats_read(&rq->stats.packets),
>  			  u64_stats_read(&rq->stats.bytes),
>  			  &cur_sample);
> -	u64_stats_update_end(&rq->stats.syncp);
>  
>  	net_dim(&rq->dim, cur_sample);
>  	rq->packets_in_napi = 0;
> -- 
> 2.9.4


