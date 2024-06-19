Return-Path: <netdev+bounces-104776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0574790E52E
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 10:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A433284E47
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 08:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83547868B;
	Wed, 19 Jun 2024 08:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="otRwIKxv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB1D77F12
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 08:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718784349; cv=none; b=IPfLtvMg/kstpBFb+bYjVkQ0aXpnmSzCoCVVBqEyOhH/JIBx87zKn8uPRckbsRfKUJDpfw5XELaPJCCwX5K2n7i9cNdBymGY9pRi9m8ooyiixmlJBhPoBhI16y9gOCNY/XH2gEqpwNOQqZnmk7P4SZ6EKJWTIsbNuwpmPCW8xdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718784349; c=relaxed/simple;
	bh=rEYX9TMT+WexG+9ndxYWFHFfhUupKb3tjubpg2QCDuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bztbOcGSOFH9busvnNEShbpXB+9EBqL6Vu8CInHAU7BgvuIP+/7FSr0nynly/3sO8K+bR28SpTNRxiO5qs4So4UjnZgkyHoyutNQ7PO6mtV89YQwoBvBxk5Gjun22JcY1dfP8oTF1eb+Fqbs0RH1UYfvmm0UY5wH6FNhnGejn/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=otRwIKxv; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-36226e98370so871473f8f.3
        for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 01:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1718784346; x=1719389146; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yJSugbnXw2ae2W7TK3VccrDrLGEAOnFb3uGQf7gF5Kg=;
        b=otRwIKxvvRaovVxXZdE+le/r9gflw2ENAA4RpDei9Yuwyg2X041ZWL3JjlpCrzt9pV
         54UcmZgmZQsSM2VMUBpwNdaPa6FsEaSM7zlMBsu6JMtQYx9vMohD+RrlEQCwwLDVr7JA
         UGAI0ZyjNkZAw624F1g+6ZlSuCnh2vtFSlx9ah4SoGti0dHzEo2myHviCSiSW9v/B9VH
         Pmhvsw+Oz5YjVhpoVdJ75wV0fitiwHcQ/yLx9DLoQ2uVWXY4pU5oAVLtG5Kk1SfsJ4ix
         xqltB1b8NnjFV2DJrm3/fNw1gkwBCYCKQ6hiwkldB6EKubHDIkEy6Fvei19ZpEMi9uTU
         gm8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718784346; x=1719389146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJSugbnXw2ae2W7TK3VccrDrLGEAOnFb3uGQf7gF5Kg=;
        b=TZfSgz9GMVn8Ro3HF/OcRTy+lC0cnG+dWZ3Tni9IIDqOsIuL7wo19YbRqyA3EiotFX
         up8mRR+iolMlPGe5NLeZG8WKioF1gFkaSYyFM+CMpNBTJFKUoiwWCShoAopCH/YSylVB
         C8w/VRvdBluFuPfpSGBog284091J13qS8soe4VJ7ZuFWD84jf+++XoLFfeoycTN+80S0
         3kY7knCX8I1pgRPryedMO5VN6wta4Try6x4fIOv81JFz/2QudOFn9yZsDu3OPlHEdKX1
         2AUbN0NPTMkrWHgNTqSqFtG4QbMdyvtkS/d4p8VIac5Oe8LpgdgRnSQGdlNO277onlnC
         nPGQ==
X-Gm-Message-State: AOJu0Yy2Z0jCJqLuE6py+rHQT6c/8b79by76sXgGADwp4t/g/CfLNOMk
	+Ta8UeWwkVOcSi5xMt4eTsNx4juuIpJ2HCojgAxE0+KejCJE62vDpBof3uAlkzY=
X-Google-Smtp-Source: AGHT+IEtlrQVa8H1EwEqrf+pukQotff3H5/HsmOUag1nfUWerbRk7FDhBXuM1cDwadPm5DKeBxZklw==
X-Received: by 2002:adf:f98c:0:b0:35f:20da:e1a2 with SMTP id ffacd0b85a97d-36317b7d57dmr1238251f8f.30.1718784345820;
        Wed, 19 Jun 2024 01:05:45 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607510315csm16341455f8f.90.2024.06.19.01.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 01:05:45 -0700 (PDT)
Date: Wed, 19 Jun 2024 10:05:41 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, dave.taht@gmail.com,
	kerneljasonxing@gmail.com, hengqi@linux.alibaba.com
Subject: Re: [PATCH net-next v3] virtio_net: add support for Byte Queue Limits
Message-ID: <ZnKRVS6fDNIwQDEM@nanopsycho.orion>
References: <20240618144456.1688998-1-jiri@resnulli.us>
 <20240618140326-mutt-send-email-mst@kernel.org>
 <ZnJwbKmy923yye0t@nanopsycho.orion>
 <20240619014938-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619014938-mutt-send-email-mst@kernel.org>

Wed, Jun 19, 2024 at 09:26:22AM CEST, mst@redhat.com wrote:
>On Wed, Jun 19, 2024 at 07:45:16AM +0200, Jiri Pirko wrote:
>> Tue, Jun 18, 2024 at 08:18:12PM CEST, mst@redhat.com wrote:
>> >This looks like a sensible way to do this.
>> >Yet something to improve:
>> >
>> >
>> >On Tue, Jun 18, 2024 at 04:44:56PM +0200, Jiri Pirko wrote:
>> >> From: Jiri Pirko <jiri@nvidia.com>
>> >> 
>> 
>> [...]
>> 
>> 
>> >> +static void __free_old_xmit(struct send_queue *sq, struct netdev_queue *txq,
>> >> +			    bool in_napi, struct virtnet_sq_free_stats *stats)
>> >>  {
>> >>  	unsigned int len;
>> >>  	void *ptr;
>> >>  
>> >>  	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
>> >> -		++stats->packets;
>> >> -
>> >>  		if (!is_xdp_frame(ptr)) {
>> >> -			struct sk_buff *skb = ptr;
>> >> +			struct sk_buff *skb = ptr_to_skb(ptr);
>> >>  
>> >>  			pr_debug("Sent skb %p\n", skb);
>> >>  
>> >> -			stats->bytes += skb->len;
>> >> +			if (is_orphan_skb(ptr)) {
>> >> +				stats->packets++;
>> >> +				stats->bytes += skb->len;
>> >> +			} else {
>> >> +				stats->napi_packets++;
>> >> +				stats->napi_bytes += skb->len;
>> >> +			}
>> >>  			napi_consume_skb(skb, in_napi);
>> >>  		} else {
>> >>  			struct xdp_frame *frame = ptr_to_xdp(ptr);
>> >>  
>> >> +			stats->packets++;
>> >>  			stats->bytes += xdp_get_frame_len(frame);
>> >>  			xdp_return_frame(frame);
>> >>  		}
>> >>  	}
>> >> +	netdev_tx_completed_queue(txq, stats->napi_packets, stats->napi_bytes);
>> >
>> >Are you sure it's right? You are completing larger and larger
>> >number of bytes and packets each time.
>> 
>> Not sure I get you. __free_old_xmit() is always called with stats
>> zeroed. So this is just sum-up of one queue completion run.
>> I don't see how this could become "larger and larger number" as you
>> describe.
>
>Oh. Right of course. Worth a comment maybe? Just to make sure
>we remember not to call __free_old_xmit twice in a row
>without reinitializing stats.
>Or move the initialization into __free_old_xmit to make it
>self-contained ..

Well, the initialization happens in the caller by {0}, Wouldn't
memset in __free_old_xmit() add an extra overhead? IDK.
Perhaps a small comment in __free_old_xmit() would do better.

One way or another, I think this is parallel to this patchset. Will
handle it separatelly if you don't mind.

>WDYT?
>
>> 
>> >
>> >For example as won't this eventually trigger this inside dql_completed:
>> >
>> >        BUG_ON(count > num_queued - dql->num_completed);
>> 
>> Nope, I don't see how we can hit it. Do not complete anything else
>> in addition to what was started in xmit(). Am I missing something?
>> 
>> 
>> >
>> >?
>> >
>> >
>> >If I am right the perf testing has to be redone with this fixed ...
>> >
>> >
>> >>  }
>> >>  
>> 
>> [...]
>

