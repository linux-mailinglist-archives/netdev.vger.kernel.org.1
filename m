Return-Path: <netdev+bounces-106095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE96B9148C3
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 13:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 932D1287136
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 11:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F24713C691;
	Mon, 24 Jun 2024 11:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nn5F2T+d"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B7913D51D
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 11:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719228623; cv=none; b=MMYY85YRsboYB6aHNoc+T/TvzPUhFnIiRXIy0hGoDRW4E/dWikiA9Mv1b1nahq8ga/2DYXoO6WMAyDcqT8qj6E5sYUg+lE4lunrNs/m80fxgwdZq7ee2fh5jy98HvWGpoLd7iTurktBrF0AAkx4YC6XYOEb4O+YEtbsUCP0vnYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719228623; c=relaxed/simple;
	bh=M4Wcb7VpXYtsowNR1lzdR6lNDnCTDjkIManIV1BdopA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKHRjZt1rh5MJBzA2c9Vh4XewfnAwzqGzh5ELy58/hKxt9s7dTN7jCHux93zzpHmnb0fIP1jii0LDk1Epfm1NojfLs+s66uPhJi73+XdBhH40p+txFrxFVxT3rMGGj0OWwQEvJ3cdqXGCdiB14gLzOCrZ6W6ub9wc19Mi1fqraU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nn5F2T+d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719228620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XRL+v6NCWhw/RequsUIDzeSCPLfQtqDa+UUOilSFfdM=;
	b=Nn5F2T+dVODakxM0xhj/7ZYhJSzXRy1a2nOQ5DV7qu7yPrNtdnQYx4PI5W+nlKUweTpPRo
	mhk7UtJBPS9zARkXIvbz9WCekz42DbNh2gl58MfjRJKYN+jfcc5v7y74iZ+FRsGAuP91q8
	dcAPPb6NwjlbXOMNk3lrVYWrMsEVQOA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-dgkD3YfWNYaUTPfHFvxNhA-1; Mon, 24 Jun 2024 07:30:18 -0400
X-MC-Unique: dgkD3YfWNYaUTPfHFvxNhA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3625503233eso2592037f8f.0
        for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 04:30:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719228617; x=1719833417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XRL+v6NCWhw/RequsUIDzeSCPLfQtqDa+UUOilSFfdM=;
        b=C/g++flyTJS7LpPomLnJOQ55u5uEGg7bnvYCH8/VBebDGkh3poECSDGjaYjQlMQhuL
         Ne9VJ/jF2rckpYrKizE4r5LBgEf/2s0msRfJycJEf+kNhign4Ttkp4ZcmdakMl/F8eWT
         1VFhos2xAC5E2qAIALqPyD9rAymeC5gUuzZ8F7auuPqySoHNvgr8Q78XB1fWcWXdYp1h
         XV6h+DrVEoqm2TL1e5yfowCYEFT0i4TiiTvcpXOaLtpd+X7SxjdkWdiB8VwHxN0GJHKO
         sghOnkLEWSqj+OuG2IaRqgfliD5ClgrvpOt1IFeNeaT6OvIk4HupEGgIcNm4q9Tjp2fe
         DHEQ==
X-Gm-Message-State: AOJu0YwlFXn3TajM7MmvDiLzs+cPrRsbS2mOmBiYKAhdZJqTcN80mBpu
	Le/SyR/Yxd4QPLmoCowgb9EP5w92RDb+qfVxk5C+XkcUVY++DUNIU5uUcMQMGW7o/tBnZbbNZEf
	CSPazs00k/6Y1Cg4KziB6E71izfU7d6CdhdBAPWikvah0VFSgWFrx1g==
X-Received: by 2002:adf:9d89:0:b0:366:f976:598b with SMTP id ffacd0b85a97d-366f97659d1mr994692f8f.8.1719228617167;
        Mon, 24 Jun 2024 04:30:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhWMDHv2yrPbzqSTtV4Q2U5sqeXN1e4wLu15qFHYSwBt/LbXSBPkQLn+FYOqXtzR62lWULWg==
X-Received: by 2002:adf:9d89:0:b0:366:f976:598b with SMTP id ffacd0b85a97d-366f97659d1mr994658f8f.8.1719228616481;
        Mon, 24 Jun 2024 04:30:16 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a2f6bd2sm9737523f8f.66.2024.06.24.04.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 04:30:15 -0700 (PDT)
Date: Mon, 24 Jun 2024 07:30:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v4 2/5] virtio_net: enable irq for the control vq
Message-ID: <20240624072806-mutt-send-email-mst@kernel.org>
References: <20240619161908.82348-1-hengqi@linux.alibaba.com>
 <20240619161908.82348-3-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619161908.82348-3-hengqi@linux.alibaba.com>

On Thu, Jun 20, 2024 at 12:19:05AM +0800, Heng Qi wrote:
> If the device does not respond to a request for a long time,
> then control vq polling elevates CPU utilization, a problem that
> exacerbates with more command requests.
> 
> Enabling control vq's irq is advantageous for the guest, and
> this still doesn't support concurrent requests.
> 
> Suggested-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index b45f58a902e3..ed10084997d3 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -372,6 +372,8 @@ struct virtio_net_ctrl_rss {
>  struct control_buf {
>  	struct virtio_net_ctrl_hdr hdr;
>  	virtio_net_ctrl_ack status;
> +	/* Wait for the device to complete the cvq request. */
> +	struct completion completion;
>  };
>  
>  struct virtnet_info {
> @@ -664,6 +666,13 @@ static bool virtqueue_napi_complete(struct napi_struct *napi,
>  	return false;
>  }
>  
> +static void virtnet_cvq_done(struct virtqueue *cvq)
> +{
> +	struct virtnet_info *vi = cvq->vdev->priv;
> +
> +	complete(&vi->ctrl->completion);
> +}
> +
>  static void skb_xmit_done(struct virtqueue *vq)
>  {
>  	struct virtnet_info *vi = vq->vdev->priv;

> @@ -2724,14 +2733,8 @@ static bool virtnet_send_command_reply(struct virtnet_info *vi,
>  	if (unlikely(!virtqueue_kick(vi->cvq)))
>  		goto unlock;
>  
> -	/* Spin for a response, the kick causes an ioport write, trapping
> -	 * into the hypervisor, so the request should be handled immediately.
> -	 */
> -	while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> -	       !virtqueue_is_broken(vi->cvq)) {
> -		cond_resched();
> -		cpu_relax();
> -	}
> +	wait_for_completion(&ctrl->completion);
> +	virtqueue_get_buf(vi->cvq, &tmp);
>  
>  unlock:
>  	ok = ctrl->status == VIRTIO_NET_OK;

Hmm no this is not a good idea, code should be robust in case
of spurious interrupts.

Also suprise removal is now broken ...


> @@ -5312,7 +5315,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
>  
>  	/* Parameters for control virtqueue, if any */
>  	if (vi->has_cvq) {
> -		callbacks[total_vqs - 1] = NULL;
> +		callbacks[total_vqs - 1] = virtnet_cvq_done;
>  		names[total_vqs - 1] = "control";
>  	}
>  
> @@ -5832,6 +5835,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	if (vi->has_rss || vi->has_rss_hash_report)
>  		virtnet_init_default_rss(vi);
>  
> +	init_completion(&vi->ctrl->completion);
>  	enable_rx_mode_work(vi);
>  
>  	/* serialize netdev register + virtio_device_ready() with ndo_open() */
> -- 
> 2.32.0.3.g01195cf9f


