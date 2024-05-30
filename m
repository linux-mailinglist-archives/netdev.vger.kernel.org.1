Return-Path: <netdev+bounces-99329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D268D4839
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 11:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D48A91F22E53
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 09:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628446F2F6;
	Thu, 30 May 2024 09:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eD6caFar"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FD0183990
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 09:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717060647; cv=none; b=Sd0m2M23Ln75DiKwcGbbWEnu9jcWrpmUtVFANAEtgmiAmVqmBHFUUeNt5XM/y2/wxbN7S4iU3YdHT4KuLXcu9M/GzPusZJhODVCY7mfqWFtIsC2dR68elFGz9rAnS0obZO1XCHYC00gosCnr7+6ZiEGOobVKnmsRDxIb6/Y4Jxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717060647; c=relaxed/simple;
	bh=eCjZ8iPR0gePB3DWkGaXrIHfnAGJITyGfXj0aAhawR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DWYvpzW82t/WNWfIt1uot4iPQs93GMIHb2lv2V/oc/8HnLuXeVV+P8qX44scHrYcWKQuV3qFueJVX3KsARe+c0YWtG+Hz9W7weN2ga/SJ72Z6s5G0kVZIV1zgLe7gldTisATLsPG8hE2uS9yjgIXJjoUg0tC+ORfHLNWpGRD9oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eD6caFar; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717060644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OrOhFD1O2QLtQkci+Xy+Xp8cmUEIquXNNePUgb7FIXg=;
	b=eD6caFarGJu7I4lS1BP1kp0MQlY+bpw9KwrfK+mKPxMqcXfE0unSRAoICJDPDzuKu6wlRX
	8uouy+RCke0d3GdJnkwOp4mueZ+XkI33bARloZgbGrulPRNAmu72TWna24We8sYssRXbBT
	LfN6OVmT4fXFJm7D1TYMaBCUlLyi7pA=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-7Me7-w7lPtGlQmrPKX12QA-1; Thu, 30 May 2024 05:17:23 -0400
X-MC-Unique: 7Me7-w7lPtGlQmrPKX12QA-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-52960af5d0fso401070e87.2
        for <netdev@vger.kernel.org>; Thu, 30 May 2024 02:17:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717060639; x=1717665439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OrOhFD1O2QLtQkci+Xy+Xp8cmUEIquXNNePUgb7FIXg=;
        b=fHEsWlXKS/6tnMCNpLHKM5SNBYzrYTJQo6LHZnstiXz2FdWqaggprhdtjsgroh4Tpj
         lh7hXjwLcGZCcHTnVI1iqeHcFqycYI/IK2rUc2n38Bwiwyqd80sFdrWH3ijH9vl7/63I
         HB31c0d7fMNArDmW4wrUF+s9i9E8yEddmhaYn+LjB6wiiv3lfF4806Yx+aqk7iESFzHW
         DRjtS9zZqeo1mwilX9AR5I8q+dj3qQ5S2mmr1knOakkiBeUm42zRpt77n8zIv/zj5Inq
         jkY7Vyw7pN0gZlINIlKQJY+FgXkn1vNgjmOnt6HvfqTVxGDKEQPxaI/i7d40eANzWsd+
         xqHg==
X-Gm-Message-State: AOJu0Yw6hn4kVIPJ9a4PS3vqp3UFKXyhB9VLwK6FHLgd4BdmrtoHapfZ
	R59eVa8k4DP1/k14aLBz5b3wJHj/tJxVZqpq6PAJruYdVGEKqyib4I6nV4v0Y46JC0ha9eXLibb
	t4jN9Rglqad7t3DZBnLTwuAyr4oE3INDD4m/B5RmxWdF0XVofjlStog==
X-Received: by 2002:ac2:43d3:0:b0:523:91d1:12b2 with SMTP id 2adb3069b0e04-52b7d417fa5mr936469e87.6.1717060639274;
        Thu, 30 May 2024 02:17:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjFauER2nKzlXi7PQA0lj1JP6X1POmUioG5dsP6556DuIVQ6ua4CC0ROYuYqAI0GinJHxrhg==
X-Received: by 2002:ac2:43d3:0:b0:523:91d1:12b2 with SMTP id 2adb3069b0e04-52b7d417fa5mr936433e87.6.1717060638625;
        Thu, 30 May 2024 02:17:18 -0700 (PDT)
Received: from redhat.com ([2a02:14f:179:fb20:c957:3427:ac94:f0a3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421270aeb18sm18992555e9.48.2024.05.30.02.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 02:17:18 -0700 (PDT)
Date: Thu, 30 May 2024 05:17:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Daniel Jurgens <danielj@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net v3 1/2] virtio_net: fix possible dim status
 unrecoverable
Message-ID: <20240530051705-mutt-send-email-mst@kernel.org>
References: <20240528134116.117426-1-hengqi@linux.alibaba.com>
 <20240528134116.117426-2-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528134116.117426-2-hengqi@linux.alibaba.com>

On Tue, May 28, 2024 at 09:41:15PM +0800, Heng Qi wrote:
> When the dim worker is scheduled, if it no longer needs to issue
> commands, dim may not be able to return to the working state later.
> 
> For example, the following single queue scenario:
>   1. The dim worker of rxq0 is scheduled, and the dim status is
>      changed to DIM_APPLY_NEW_PROFILE;
>   2. dim is disabled or parameters have not been modified;
>   3. virtnet_rx_dim_work exits directly;
> 
> Then, even if net_dim is invoked again, it cannot work because the
> state is not restored to DIM_START_MEASURE.
> 
> Fixes: 6208799553a8 ("virtio-net: support rx netdim")
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>


Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/net/virtio_net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 4a802c0ea2cb..4f828a9e5889 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -4417,9 +4417,9 @@ static void virtnet_rx_dim_work(struct work_struct *work)
>  		if (err)
>  			pr_debug("%s: Failed to send dim parameters on rxq%d\n",
>  				 dev->name, qnum);
> -		dim->state = DIM_START_MEASURE;
>  	}
>  out:
> +	dim->state = DIM_START_MEASURE;
>  	mutex_unlock(&rq->dim_lock);
>  }
>  
> -- 
> 2.32.0.3.g01195cf9f


