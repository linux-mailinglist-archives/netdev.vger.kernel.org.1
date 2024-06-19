Return-Path: <netdev+bounces-104780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E52890E55D
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 10:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1D61B22881
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 08:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BF17B3EB;
	Wed, 19 Jun 2024 08:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OjaxWaI7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14447A158
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 08:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718785070; cv=none; b=armsYEmH8s7WT1njiNZ1sKY6nZdXM4s88rfawkCKdAIaZwcITOEfb2jt64TERA3MOTT2/cPOakJHWIpSHvGIF9Lcgik5uWeY0BAqt/6Jy7LqYI3lBRvo4XYUddvHCmw99AAuxXCKi27yDTsvS7S+jV5Hd1oIEBa6cKWCqTYwZvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718785070; c=relaxed/simple;
	bh=l8+zgzbP18KtI89/4El6+cz4hyjRgL8181vGXCgW+40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQJQuKKMPpW2eMOtNJCTcLDyNtPtj8H1tx168B1MvrDSitkTlHGBfgHJYg6xPbOLjQCh3ryvlDwaYMbvhTWchX0ZRJXwj0gqr1P9c/Q9SWJWYL1XwnlNmyHrDmGVDuRkKyMiqroOKQlpOC22TO8IrXITVdDSEFVFFSujBrrYqek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OjaxWaI7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718785067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e2HochStbwK8oLLb/40dXva6vGhIzuUQPXwS/TDHqjQ=;
	b=OjaxWaI7/MvF0pUNjyJyEweLVv1XKddTzCQi5mgw6r+NnmHEjFOdDJ95L6+9bGSqPFCmUe
	ZqKAlRS/PB7s94Xf+PWkVOPZ37zyBnAMJ4E1SeA69aKrz98uoFTxGXSGEVMzO4oD9RNRdb
	dvg8/rTZ+Q7PkN3f0F/sRz/UP/sk00o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-ZSvhPN5yOJu_6idQVQW6Sw-1; Wed, 19 Jun 2024 04:17:44 -0400
X-MC-Unique: ZSvhPN5yOJu_6idQVQW6Sw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4212e2a3a1bso40820765e9.3
        for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 01:17:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718785064; x=1719389864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2HochStbwK8oLLb/40dXva6vGhIzuUQPXwS/TDHqjQ=;
        b=w857k3krgdtfG5+CzLFTBy+cazTP5StXjfEH2PBskfceTAPvbEsYSzcaijcuTA8gKL
         PEJJR7ZVWI5QCEEU8hqlyukjROWgXm6SCL8kJW4Mqos5UsCs4g4oAPEAruK9t7xCfp1l
         j7cCUhoV9szWzW4z/P+EtP3EiZz785UminAaqghrKSmuVYze9QBIrWGP8aCOH/YLcNmD
         jvNwXwe1xTxz0naN0oR51X2ia1zes+nIc5oMmFwiyVN8NnQo2oxHM9IZnK9vW0sNeQQw
         6X3NgDd5EZ3diJDZT7NeToHKXE1QKs99W1Ss6l70x6NoqcsefE0DoptCHBWA5+ElOLqJ
         8CXw==
X-Gm-Message-State: AOJu0YxX6UKYi5F1I2eVAAIYpGZj1HSAHX2FwQC0oDAaYUgct8mBZcns
	fLdtaoM/V8FauSBreLW1pnqMM8Bgpe94JyYsqyfQN29aK4uqzRarXUVU2eiBXGdAShLBEjiZkmZ
	OrHoweFBPTSBxwNCVvswWjtZ/vjuOB55GT4xIi6GQ5RcOGmlwLyt9xA==
X-Received: by 2002:a7b:c355:0:b0:421:8060:f772 with SMTP id 5b1f17b1804b1-42475018647mr12800405e9.0.1718785063672;
        Wed, 19 Jun 2024 01:17:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2pE9o2OD007AYdoJfEVPwiiMzWBpLUGF75xR/hP2NwCCtwbSsxDnzYCkBs6Ypv2Wjzil+aw==
X-Received: by 2002:a7b:c355:0:b0:421:8060:f772 with SMTP id 5b1f17b1804b1-42475018647mr12800265e9.0.1718785063216;
        Wed, 19 Jun 2024 01:17:43 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f6320c16sm219568585e9.38.2024.06.19.01.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 01:17:42 -0700 (PDT)
Date: Wed, 19 Jun 2024 04:17:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, dave.taht@gmail.com,
	kerneljasonxing@gmail.com, hengqi@linux.alibaba.com
Subject: Re: [PATCH net-next v3] virtio_net: add support for Byte Queue Limits
Message-ID: <20240619041211-mutt-send-email-mst@kernel.org>
References: <20240618144456.1688998-1-jiri@resnulli.us>
 <20240618140326-mutt-send-email-mst@kernel.org>
 <ZnJwbKmy923yye0t@nanopsycho.orion>
 <20240619014938-mutt-send-email-mst@kernel.org>
 <ZnKRVS6fDNIwQDEM@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnKRVS6fDNIwQDEM@nanopsycho.orion>

On Wed, Jun 19, 2024 at 10:05:41AM +0200, Jiri Pirko wrote:
> Wed, Jun 19, 2024 at 09:26:22AM CEST, mst@redhat.com wrote:
> >On Wed, Jun 19, 2024 at 07:45:16AM +0200, Jiri Pirko wrote:
> >> Tue, Jun 18, 2024 at 08:18:12PM CEST, mst@redhat.com wrote:
> >> >This looks like a sensible way to do this.
> >> >Yet something to improve:
> >> >
> >> >
> >> >On Tue, Jun 18, 2024 at 04:44:56PM +0200, Jiri Pirko wrote:
> >> >> From: Jiri Pirko <jiri@nvidia.com>
> >> >> 
> >> 
> >> [...]
> >> 
> >> 
> >> >> +static void __free_old_xmit(struct send_queue *sq, struct netdev_queue *txq,
> >> >> +			    bool in_napi, struct virtnet_sq_free_stats *stats)
> >> >>  {
> >> >>  	unsigned int len;
> >> >>  	void *ptr;
> >> >>  
> >> >>  	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
> >> >> -		++stats->packets;
> >> >> -
> >> >>  		if (!is_xdp_frame(ptr)) {
> >> >> -			struct sk_buff *skb = ptr;
> >> >> +			struct sk_buff *skb = ptr_to_skb(ptr);
> >> >>  
> >> >>  			pr_debug("Sent skb %p\n", skb);
> >> >>  
> >> >> -			stats->bytes += skb->len;
> >> >> +			if (is_orphan_skb(ptr)) {
> >> >> +				stats->packets++;
> >> >> +				stats->bytes += skb->len;
> >> >> +			} else {
> >> >> +				stats->napi_packets++;
> >> >> +				stats->napi_bytes += skb->len;
> >> >> +			}
> >> >>  			napi_consume_skb(skb, in_napi);
> >> >>  		} else {
> >> >>  			struct xdp_frame *frame = ptr_to_xdp(ptr);
> >> >>  
> >> >> +			stats->packets++;
> >> >>  			stats->bytes += xdp_get_frame_len(frame);
> >> >>  			xdp_return_frame(frame);
> >> >>  		}
> >> >>  	}
> >> >> +	netdev_tx_completed_queue(txq, stats->napi_packets, stats->napi_bytes);
> >> >
> >> >Are you sure it's right? You are completing larger and larger
> >> >number of bytes and packets each time.
> >> 
> >> Not sure I get you. __free_old_xmit() is always called with stats
> >> zeroed. So this is just sum-up of one queue completion run.
> >> I don't see how this could become "larger and larger number" as you
> >> describe.
> >
> >Oh. Right of course. Worth a comment maybe? Just to make sure
> >we remember not to call __free_old_xmit twice in a row
> >without reinitializing stats.
> >Or move the initialization into __free_old_xmit to make it
> >self-contained ..
> 
> Well, the initialization happens in the caller by {0}, Wouldn't
> memset in __free_old_xmit() add an extra overhead? IDK.
> Perhaps a small comment in __free_old_xmit() would do better.
> 
> One way or another, I think this is parallel to this patchset. Will
> handle it separatelly if you don't mind.


Okay.


Acked-by: Michael S. Tsirkin <mst@redhat.com>


> >WDYT?
> >
> >> 
> >> >
> >> >For example as won't this eventually trigger this inside dql_completed:
> >> >
> >> >        BUG_ON(count > num_queued - dql->num_completed);
> >> 
> >> Nope, I don't see how we can hit it. Do not complete anything else
> >> in addition to what was started in xmit(). Am I missing something?
> >> 
> >> 
> >> >
> >> >?
> >> >
> >> >
> >> >If I am right the perf testing has to be redone with this fixed ...
> >> >
> >> >
> >> >>  }
> >> >>  
> >> 
> >> [...]
> >


