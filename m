Return-Path: <netdev+bounces-98677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 312F68D20B6
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 17:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D98BE1F23CEB
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 15:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A4317107F;
	Tue, 28 May 2024 15:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NuzrzrYR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7BC16F828
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 15:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716911200; cv=none; b=aOQ8Eu2zoOuXBkwi+/aS1x0JSNQ3c9SmjeCL6zeSMQULwI3KugtX8Bc800ywhXOv/CKV9jU/Glz4Cd+8BQDqnIxIyFKyMVNS19xqTBWqJNKmPoFPMsfdiwwJkOUA9j2J6TCgXu8CLaA5UoI/t3kM2bqmXNxrvEIOJpLXNen3WAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716911200; c=relaxed/simple;
	bh=BBfWRtPKds2pzdydFqFBEcxuE06/q5m+4KF1Ene+vTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RNCV02243TWzG+oDH15ViFgElJEO4T6o2/wPXvaGcqHedwONEySjJItfK8dpntAf3Jws4y20kaiYv3XzKenPngMfj7L5e9+xYR2naR4Tp4iIuzAoTJpdZl8JoSRfNHuZgz5kahenfyoyh85wUy7OQ7ZZzHBi0ZU8zjOCYR9zlgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NuzrzrYR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716911197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tD89fcMVEPyzDouOycEHqVw3lxLpSHxt2pMLaCqM9uY=;
	b=NuzrzrYRMWCSPV7BTSHX4TILph6YZ7RQfpxH4rW8NQ3OLCP4yf8nxTHags+sLGjsB5FVcD
	MU2+wa5sS/rAy1PfjB1WKmb7TWC3CAMLhFQo8Qd0PpkkNsKtGW7dHfb1XTudE2j8DVe5yh
	trtHpYwpMP+NFsVN9Vv0BP5gVl/GslQ=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-MCMNxm-KMSeqZnG8KQxxRQ-1; Tue, 28 May 2024 11:46:36 -0400
X-MC-Unique: MCMNxm-KMSeqZnG8KQxxRQ-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2e734caac3bso6979531fa.3
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 08:46:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716911194; x=1717515994;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tD89fcMVEPyzDouOycEHqVw3lxLpSHxt2pMLaCqM9uY=;
        b=IpdM0N9RU79MAGfvwQBHtm7JbYf7OU/fQJ9JjwM9e7DXeWq6otbsDizpefBD+NaiFt
         jtw2km/AjEe3HZg954TLYCqlsr48+Pilh+kah/s3RwO7xX8VEsoFr0wOjV4GtnGbm9vq
         uEjVAkWiOgMzqj/1rQEBt5tX0UtUpGKvAjWD5EoaWX9NxEEgnB+a0xK0eBnLEZ7M3CAI
         D0Oh09AvL+82FDJHZWKCSB7i+9S/ecsarRRKUDvH6qwEV9Dec4vrGwEJm0dgjZrMen8x
         ZIoDfoN5ABX2RPwEdfjjMPUTuiE7u7rZYuVTh5/U6vQe9RkwL8hFOW20E06MqzwrU1gj
         hrUw==
X-Gm-Message-State: AOJu0YyzixZTpqq8EbMQU6+/1MrbroF796OJYTfEILhLQHaRsYC5lyfd
	+G2KBbBPznKr2wVafVXQNYnlX/cM1glK+2SJA2sK+N1OAymEBa4/lmra8L3LUM21H4Lb6SRcU3+
	rt4aPiEWFQPx/aT1TWGrNP35Hv95nyNnoDASipTIB2RsJQgFYhqEuuA==
X-Received: by 2002:a2e:7d07:0:b0:2e1:ebec:1ded with SMTP id 38308e7fff4ca-2e95b0c0445mr70685141fa.25.1716911194258;
        Tue, 28 May 2024 08:46:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHoLO75bzkTh8Lpq4uxRpD+x0FYLdIBHOsi1XfbjLF0lJVBM82jLbAW9IQ1SZ2hkA2UP3z5g==
X-Received: by 2002:a2e:7d07:0:b0:2e1:ebec:1ded with SMTP id 38308e7fff4ca-2e95b0c0445mr70684151fa.25.1716911193571;
        Tue, 28 May 2024 08:46:33 -0700 (PDT)
Received: from redhat.com ([2.55.190.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100fad6ccsm179659745e9.32.2024.05.28.08.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 08:46:32 -0700 (PDT)
Date: Tue, 28 May 2024 11:46:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Daniel Jurgens <danielj@nvidia.com>
Subject: Re: [PATCH net 2/2] virtio_net: fix missing lock protection on
 control_buf access
Message-ID: <20240528114547-mutt-send-email-mst@kernel.org>
References: <20240528075226.94255-1-hengqi@linux.alibaba.com>
 <20240528075226.94255-3-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528075226.94255-3-hengqi@linux.alibaba.com>

On Tue, May 28, 2024 at 03:52:26PM +0800, Heng Qi wrote:
> Refactored the handling of control_buf to be within the cvq_lock
> critical section, mitigating race conditions between reading device
> responses and new command submissions.
> 
> Fixes: 6f45ab3e0409 ("virtio_net: Add a lock for the command VQ.")
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>


I don't get what does this change. status can change immediately
after you drop the mutex, can it not? what exactly is the
race conditions you are worried about?

> ---
>  drivers/net/virtio_net.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 6b0512a628e0..3d8407d9e3d2 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2686,6 +2686,7 @@ static bool virtnet_send_command_reply(struct virtnet_info *vi, u8 class, u8 cmd
>  {
>  	struct scatterlist *sgs[5], hdr, stat;
>  	u32 out_num = 0, tmp, in_num = 0;
> +	bool ret;
>  	int err;
>  
>  	/* Caller should know better */
> @@ -2731,8 +2732,9 @@ static bool virtnet_send_command_reply(struct virtnet_info *vi, u8 class, u8 cmd
>  	}
>  
>  unlock:
> +	ret = vi->ctrl->status == VIRTIO_NET_OK;
>  	mutex_unlock(&vi->cvq_lock);
> -	return vi->ctrl->status == VIRTIO_NET_OK;
> +	return ret;
>  }
>  
>  static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
> -- 
> 2.32.0.3.g01195cf9f


