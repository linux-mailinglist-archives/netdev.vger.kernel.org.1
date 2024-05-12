Return-Path: <netdev+bounces-95787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA968C3731
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 18:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 055A8281416
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 16:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050F640BE3;
	Sun, 12 May 2024 16:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iHbcPriN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5293D2E85E
	for <netdev@vger.kernel.org>; Sun, 12 May 2024 16:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715529728; cv=none; b=UQiTEtidksMErvJMXhpFBzLcL45PrqV2AujxJKwzVzo2y8sI8VIrtJXOOxJAv+R2jTCGkJ8I9u6gUo88Ceohq1wxoI9288vWf1uAZwTU4ndJEYF+ntNuNuu7nK8wSjgk3wksI5DQb5MeJKwHfxTZwTA/08mwqjKOK1Rnljn2v08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715529728; c=relaxed/simple;
	bh=RxSDTegW7CO/59WWa4N5BIOvsZNO4JGLYbZ0l9O8rwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DiQzWnejXqZG/b8I2NeaKeHG7GhYL93d2oqlYemuarzbCf7Nzh7O8eTBmPuxyujiQZgq5Di52DBT+/XqJNnBLF046nbn9YLC5u8Z22l823vrbtmDDI5aRCGwefITd1+o1BGfKGhN/rkRfnpUwqx75Xfp4WKNMWwAQqoFSEIZUxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iHbcPriN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715529726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AxLpy9sLIlZS5JyNf+AGoRDlBshQGmESMZNZDTclcZQ=;
	b=iHbcPriNanALp+OLxsD4SNNopdTs4ja5WfF1PZGv78NmeUC9g3g88yelbNJZ+6lGbINCeb
	bDf8RlTNjrmuz2pOZG/uC5b0ypDRtJO/+/SL7AmXq+lUO+iA5QNheQ8HWRu6/tC1OTSqLQ
	lBBSxpHpVA3me2ksvSRSToE8xdk6Nic=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-f3-ZAIStNbuO_HfRc-AVDw-1; Sun, 12 May 2024 12:02:04 -0400
X-MC-Unique: f3-ZAIStNbuO_HfRc-AVDw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a59a1fe7396so238290666b.3
        for <netdev@vger.kernel.org>; Sun, 12 May 2024 09:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715529723; x=1716134523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AxLpy9sLIlZS5JyNf+AGoRDlBshQGmESMZNZDTclcZQ=;
        b=IAxHrOyPFvUk1UUCLrfXEtIBRGu4kT+JgGgJlphxs7kyt8yqsSY5dMJgona6g/ybTk
         1xXBlwjrt8ej8/1i8tYTNiS7x5Cdg87ADcdGaWS46a5pV3uVgC27zygb3+pj8W2rXQD9
         PeefGZwPmB/pULNmkK/5REQE85F3fNG4H86pUzTZUDWNip97D6PG2oeAPKTn4+dEI/e+
         x/1JlJpwVouaZbst+Hv2zCwoAnv8mfM1paKtCPA3NHylO0IY9453cp7KTeze2mpXGDQs
         aHyJXR1PdTu71cX+GAVxgnpTNts4I3AiB1dFWo3bxzF4YPwICe5t2JJCr4oTQxN1v4xZ
         uJYA==
X-Forwarded-Encrypted: i=1; AJvYcCW6p1Vo7fvsLOoNVVhbF9Bxg12SlGUWgXDNvv+zbUyiiDFCsG0rLe2WxJAhImMEmo+SICpOC07p3ZbDHxHhAl1JLeL45jcK
X-Gm-Message-State: AOJu0YwO5yA1g72Om72Aq1pnJenItI2Ayr60iPt3KZJ6wuSFcgT2Bq39
	iG7rQy93ctXH0zfIwwICJwEOphL87zkPpvVaoF03XGDnOHuetm14+fZUdhL7X/qunSd6fmHHvvt
	nHLG+Vy/g8mns6nhDLXck21yvuIS2u5VWVHcyNESmsSE0BXB3x/uGdQ==
X-Received: by 2002:a17:906:c405:b0:a59:c319:f1e0 with SMTP id a640c23a62f3a-a5a2d681e12mr464655466b.75.1715529723151;
        Sun, 12 May 2024 09:02:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRCDOgxb5kjSSoH51C64l7LHObzt/SMo/s+DeV5DWeoHqnDcKMdPA3OGfhMkwQa5PjbfnFNQ==
X-Received: by 2002:a17:906:c405:b0:a59:c319:f1e0 with SMTP id a640c23a62f3a-a5a2d681e12mr464653366b.75.1715529722576;
        Sun, 12 May 2024 09:02:02 -0700 (PDT)
Received: from redhat.com ([31.187.78.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1b602b39sm455227466b.50.2024.05.12.09.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 09:02:01 -0700 (PDT)
Date: Sun, 12 May 2024 12:01:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next] virtio_net: Fix error code in
 __virtnet_get_hw_stats()
Message-ID: <20240512115645-mutt-send-email-mst@kernel.org>
References: <3762ac53-5911-4792-b277-1f1ead2e90a3@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3762ac53-5911-4792-b277-1f1ead2e90a3@moroto.mountain>

On Fri, May 10, 2024 at 03:50:45PM +0300, Dan Carpenter wrote:
> The virtnet_send_command_reply() function returns true on success or
> false on failure.  The "ok" variable is true/false depending on whether
> it succeeds or not.  It's up to the caller to translate the true/false
> into -EINVAL on failure or zero for success.
> 
> The bug is that __virtnet_get_hw_stats() returns false for both
> errors and success.  It's not a bug, but it is confusing that the caller
> virtnet_get_hw_stats() uses an "ok" variable to store negative error
> codes.

The bug is ... It's not a bug ....

I think what you are trying to say is that the error isn't
really handled anyway, except for printing a warning,
so it's not a big deal.

Right?

I don't know why can't get_ethtool_stats fail - we should
probably fix that.


> Fix the bug and clean things up so that it's clear that
> __virtnet_get_hw_stats() returns zero on success or negative error codes
> on failure.
> 
> Fixes: 941168f8b40e ("virtio_net: support device stats")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/net/virtio_net.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 218a446c4c27..4fc0fcdad259 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -4016,7 +4016,7 @@ static int __virtnet_get_hw_stats(struct virtnet_info *vi,
>  					&sgs_out, &sgs_in);
>  
>  	if (!ok)
> -		return ok;
> +		return -EINVAL;
>  
>  	for (p = reply; p - reply < res_size; p += le16_to_cpu(hdr->size)) {
>  		hdr = p;
> @@ -4053,7 +4053,7 @@ static int virtnet_get_hw_stats(struct virtnet_info *vi,
>  	struct virtio_net_ctrl_queue_stats *req;
>  	bool enable_cvq;
>  	void *reply;
> -	int ok;
> +	int err;
>  
>  	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_DEVICE_STATS))
>  		return 0;
> @@ -4100,12 +4100,12 @@ static int virtnet_get_hw_stats(struct virtnet_info *vi,
>  	if (enable_cvq)
>  		virtnet_make_stat_req(vi, ctx, req, vi->max_queue_pairs * 2, &j);
>  
> -	ok = __virtnet_get_hw_stats(vi, ctx, req, sizeof(*req) * j, reply, res_size);
> +	err = __virtnet_get_hw_stats(vi, ctx, req, sizeof(*req) * j, reply, res_size);
>  
>  	kfree(req);
>  	kfree(reply);
>  
> -	return ok;
> +	return err;
>  }
>  
>  static void virtnet_get_strings(struct net_device *dev, u32 stringset, u8 *data)


