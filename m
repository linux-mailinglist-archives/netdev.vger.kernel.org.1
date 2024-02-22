Return-Path: <netdev+bounces-74143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4003E8603A7
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 21:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDF6A1F2560A
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 20:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066366E5FA;
	Thu, 22 Feb 2024 20:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GnNp+y7l"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5386C548E9
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 20:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708633763; cv=none; b=jjz10yQE/8tu6rqyR1Ah3BULzigaZrQaS8r+9J2rz1d6ziQ4OWFF4ZVKS2swQFX8TzGsFEzfppujBilTPdnEihSkb1kswf6Y8vIkfJ3wYfI/tqAi4M3M6kEdsNswMFGeeDj3cNOIZLyuq/kEYzC3AMo/3fn1y4R+eMJsN6CTUP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708633763; c=relaxed/simple;
	bh=EIRl5JmeNnsCCCvrzAJOkSjYNmO/xKRIFAlKwErah0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VkM/v7AkQ52JDViSj/RZb88gY3oJ/fConKOVNobwShU+G0645XcrM2xG3Yq/RA7iWWE7LHmyn9ijJmktO0U5gOsHpqAAuCrMJrAs494jxh6gtWHQyElIWScaoknwMrQF6XW+ttb36Fk//i7JzvlkLqhNnPW++K6Isrq51VAWgkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GnNp+y7l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708633761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g9U/SuU7EoZOYs84Oq+NGNW63wWSqGFV+44C2eP5B4o=;
	b=GnNp+y7lj4fd3KSHBNXjRXfvxWZpSAun8XEqx+eF+sThOLU74VNzJq0Sc6z93c3hMKNkMb
	q/Ib3fWMAE79AAIoHFoHm+L2298umJz3f1dVUPaAe17A4EWyf+UHaYB8p2pu9ZADKuWzVw
	WUctRIWIYT2sV9jlJLxsg/MKxwjAblM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-IbDdLb84M9Kc23JJGtQ-Cg-1; Thu, 22 Feb 2024 15:29:20 -0500
X-MC-Unique: IbDdLb84M9Kc23JJGtQ-Cg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33d308b0c76so599227f8f.0
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 12:29:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708633759; x=1709238559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g9U/SuU7EoZOYs84Oq+NGNW63wWSqGFV+44C2eP5B4o=;
        b=RP/zAbzoA406sD1H5zbp5i9qQHap3TykPV2JiLvckymLNoECUsG6iP4lmhD5NGaq4+
         OyW1IjAninX00jG9s++3nMNEQ27gMLh939TaCCHFXEVCe6DQUkhSL73Mx1a5tY+o3xoh
         wJY2erw/9Hrc7+qE48RLdQg8Knnc5hN0Z/orV7hcDpLrBEqCxOoT+RGc7eVysGDudHzi
         VkuK3QEVYDZoQf4PxLWW7cL3xDVSpmI94GeQDr51bIT85VPTuj/6LEsKU4FeDslKMsbQ
         lE82qAkppvccfG3aESrPq3mKT+fAIQC6kdQ9fIMC2I+QUWih6HJ3CT+3NkoCjt1BVGM5
         r1ig==
X-Forwarded-Encrypted: i=1; AJvYcCXADojTccHJVH+wAd2HYhDpxwnd9YVjZ9+xYXmnBkg9hw4E4dgeeZfnJRbgMXZFxky3Cq4xqRP3jLdIMXjGHMZwxplDn5MK
X-Gm-Message-State: AOJu0YzeSvm73YsvWI5NaKVd/cCQXG21eGhDgpC4ZJBJ4xYM04XDTlQZ
	FcLBmPTSdBg2n1hg0WcObD1Ay99Fk9zTkpSl1Gc83GhBVhF45i+IcJyNUYQqoMbOmTwZ3NSt+IJ
	Us4mOz7uCJk9vGnIWPxaUUzFAIAqE0J6CG9E1xrXey/sFp9pb4E20yg==
X-Received: by 2002:a5d:490b:0:b0:33d:513a:9248 with SMTP id x11-20020a5d490b000000b0033d513a9248mr3036121wrq.15.1708633758959;
        Thu, 22 Feb 2024 12:29:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmu72LYTYj8EKBymqMoqhVGv0sg4c6wtoeXMyJjoPERBEKhLX3cOJNp9rtBUbNB6tc0W/0bg==
X-Received: by 2002:a5d:490b:0:b0:33d:513a:9248 with SMTP id x11-20020a5d490b000000b0033d513a9248mr3036108wrq.15.1708633758639;
        Thu, 22 Feb 2024 12:29:18 -0800 (PST)
Received: from redhat.com ([172.93.237.99])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600004cf00b0033b1c321070sm142852wri.31.2024.02.22.12.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 12:29:18 -0800 (PST)
Date: Thu, 22 Feb 2024 15:29:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, xieyongji@bytedance.com,
	axboe@kernel.dk, gregkh@linuxfoundation.org, brauner@kernel.org,
	lstoakes@gmail.com, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	david.marchand@redhat.com
Subject: Re: [PATCH] vduse: implement DMA sync callbacks
Message-ID: <20240222152541-mutt-send-email-mst@kernel.org>
References: <20240219170606.587290-1-maxime.coquelin@redhat.com>
 <ZdRqcIRmDD-70ap3@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdRqcIRmDD-70ap3@infradead.org>

On Tue, Feb 20, 2024 at 01:01:36AM -0800, Christoph Hellwig wrote:
> On Mon, Feb 19, 2024 at 06:06:06PM +0100, Maxime Coquelin wrote:
> > Since commit 295525e29a5b ("virtio_net: merge dma
> > operations when filling mergeable buffers"), VDUSE device
> > require support for DMA's .sync_single_for_cpu() operation
> > as the memory is non-coherent between the device and CPU
> > because of the use of a bounce buffer.
> > 
> > This patch implements both .sync_single_for_cpu() and
> > sync_single_for_device() callbacks, and also skip bounce
> > buffer copies during DMA map and unmap operations if the
> > DMA_ATTR_SKIP_CPU_SYNC attribute is set to avoid extra
> > copies of the same buffer.
> 
> vduse really needs to get out of implementing fake DMA operations for
> something that is not DMA.

In a sense ... but on the other hand, the "fake DMA" metaphor seems to
work surprisingly well, like in this instance - internal bounce buffer
looks a bit like non-coherent DMA.  A way to make this all prettier
would I guess be to actually wrap all of DMA with virtio wrappers which
would all go if () dma_... else vduse_...; or something to this end.  A
lot of work for sure, and is it really worth it? if the only crazy
driver is vduse I'd maybe rather keep the crazy hacks local there ...

-- 
MST


