Return-Path: <netdev+bounces-104767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF7990E47D
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 09:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D9761F2564E
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 07:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0849A78276;
	Wed, 19 Jun 2024 07:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i9F9mTwX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A7B74BE0
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 07:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718781993; cv=none; b=d1z3SRXSCxhM8vbmzr6tYCDTwEWrsHX4FgtUKrllX+SGn80JvSp5jtOVhsGfem6XxcfxmGCpdyL3/nzvqtScOIubx8KjaawkWVzIX5C60+A+AYUvfa6jFSPHYkAvK7uuamaiVfTzb5oUQGSFg3pl8RJcBft4I6X0DQ4aUHrWkCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718781993; c=relaxed/simple;
	bh=4gdQjgz1DaGKapVycwD2csURuJEY5zmqSO9sCCv7ETA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/dyAC4j3AT82Tca8bpmE9xbK6VMUG3M67WkSGWyJjDgAN7Py3eRkXzVu6Vkm0uRSFbaa4sEfdUjwIeUh4UlzN37TFhFliUKzyRi3e2ujh/RQHRZ9jdpd8dDaJSS/2s794I0D57QaTi+o8PJ3JQ7olW0pMCFJ+qMLBNBG3d/QEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i9F9mTwX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718781991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FgbWbQVfihAnM12MewtnW5ZWjWRwpeKC35/dzxHgaNM=;
	b=i9F9mTwXuRcqTbXzcC/LQN/+uE3WtifZA4gzVCA3ledxIqPV+wB4Ab004YWQL+1Rlk2CCb
	pOd6CP9xseuIU7ZSoDTtaAKeZ4lP2OjylJjErTipinTXspRRWkWJ2VNO7O2fZT7DD1g+KL
	LcDymvwTi6B6MEn6SZnXYVnSKL6IgV4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-LE0l-pu2PyWasozjOjibQw-1; Wed, 19 Jun 2024 03:26:29 -0400
X-MC-Unique: LE0l-pu2PyWasozjOjibQw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42120e123beso55851545e9.0
        for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 00:26:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718781988; x=1719386788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FgbWbQVfihAnM12MewtnW5ZWjWRwpeKC35/dzxHgaNM=;
        b=Ij2+vhDP2/MLM5wyVrQfXm7xnYYTztrY5UqCCXXvIgGz6YQ++4O9zx/LH2prY21JW1
         jDPVqBI8fuAOS0mInKh6tm+2hq0UQ/kg5KRRiXfMw6ky/kVfDoTBpRlaQ9z1RJzm/IWG
         ym2UTxWSaQGrJYCQtBw7TyM5/pVQtK/4LbTiX60/y/yyDEPxAUaytO8rprU4u6Oa09Zw
         RmcMc8Jeiyy8XrSsYoEdYsLOabrL37hXQcKfJ14LASZkwq+Pme6CCXQplO3q7NSwX4wL
         C5K8Mc+YOODBSTKhcsV4uZb/OeypPrZdWamg7b4UaFELtPZOjbaf5vcgrrN9IBEZLXRd
         wFLw==
X-Gm-Message-State: AOJu0YxN58Ekq19B0dzQTZxhYPfWq4nTI1UjzL7YgDHc393wkNml2SAw
	WNzVpWiU31GOAZCqBg9BH/cIBGH4l5GLbEac0iD6qQslPL/76YLwfQgAj57/sxqkRr0mEP+19xH
	b9YT0hDcYd2HhK36l6OOy4s5SE0mIaQogbF0v86A94d9P1ZZJdSq/PA==
X-Received: by 2002:a05:600c:5107:b0:424:760d:75b8 with SMTP id 5b1f17b1804b1-424760d766bmr10331805e9.8.1718781988289;
        Wed, 19 Jun 2024 00:26:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG19bffvewKAsHvQ49KXnt1AnJ/r5s1KJCeOSQfTJk0Bf4Gs13z0uqyapeiyh3DeSyFNOhZFg==
X-Received: by 2002:a05:600c:5107:b0:424:760d:75b8 with SMTP id 5b1f17b1804b1-424760d766bmr10331455e9.8.1718781987725;
        Wed, 19 Jun 2024 00:26:27 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42286eef9ccsm251709785e9.5.2024.06.19.00.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 00:26:27 -0700 (PDT)
Date: Wed, 19 Jun 2024 03:26:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, dave.taht@gmail.com,
	kerneljasonxing@gmail.com, hengqi@linux.alibaba.com
Subject: Re: [PATCH net-next v3] virtio_net: add support for Byte Queue Limits
Message-ID: <20240619014938-mutt-send-email-mst@kernel.org>
References: <20240618144456.1688998-1-jiri@resnulli.us>
 <20240618140326-mutt-send-email-mst@kernel.org>
 <ZnJwbKmy923yye0t@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnJwbKmy923yye0t@nanopsycho.orion>

On Wed, Jun 19, 2024 at 07:45:16AM +0200, Jiri Pirko wrote:
> Tue, Jun 18, 2024 at 08:18:12PM CEST, mst@redhat.com wrote:
> >This looks like a sensible way to do this.
> >Yet something to improve:
> >
> >
> >On Tue, Jun 18, 2024 at 04:44:56PM +0200, Jiri Pirko wrote:
> >> From: Jiri Pirko <jiri@nvidia.com>
> >> 
> 
> [...]
> 
> 
> >> +static void __free_old_xmit(struct send_queue *sq, struct netdev_queue *txq,
> >> +			    bool in_napi, struct virtnet_sq_free_stats *stats)
> >>  {
> >>  	unsigned int len;
> >>  	void *ptr;
> >>  
> >>  	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
> >> -		++stats->packets;
> >> -
> >>  		if (!is_xdp_frame(ptr)) {
> >> -			struct sk_buff *skb = ptr;
> >> +			struct sk_buff *skb = ptr_to_skb(ptr);
> >>  
> >>  			pr_debug("Sent skb %p\n", skb);
> >>  
> >> -			stats->bytes += skb->len;
> >> +			if (is_orphan_skb(ptr)) {
> >> +				stats->packets++;
> >> +				stats->bytes += skb->len;
> >> +			} else {
> >> +				stats->napi_packets++;
> >> +				stats->napi_bytes += skb->len;
> >> +			}
> >>  			napi_consume_skb(skb, in_napi);
> >>  		} else {
> >>  			struct xdp_frame *frame = ptr_to_xdp(ptr);
> >>  
> >> +			stats->packets++;
> >>  			stats->bytes += xdp_get_frame_len(frame);
> >>  			xdp_return_frame(frame);
> >>  		}
> >>  	}
> >> +	netdev_tx_completed_queue(txq, stats->napi_packets, stats->napi_bytes);
> >
> >Are you sure it's right? You are completing larger and larger
> >number of bytes and packets each time.
> 
> Not sure I get you. __free_old_xmit() is always called with stats
> zeroed. So this is just sum-up of one queue completion run.
> I don't see how this could become "larger and larger number" as you
> describe.

Oh. Right of course. Worth a comment maybe? Just to make sure
we remember not to call __free_old_xmit twice in a row
without reinitializing stats.
Or move the initialization into __free_old_xmit to make it
self-contained ..
WDYT?

> 
> >
> >For example as won't this eventually trigger this inside dql_completed:
> >
> >        BUG_ON(count > num_queued - dql->num_completed);
> 
> Nope, I don't see how we can hit it. Do not complete anything else
> in addition to what was started in xmit(). Am I missing something?
> 
> 
> >
> >?
> >
> >
> >If I am right the perf testing has to be redone with this fixed ...
> >
> >
> >>  }
> >>  
> 
> [...]


