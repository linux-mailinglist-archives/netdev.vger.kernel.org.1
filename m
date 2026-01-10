Return-Path: <netdev+bounces-248686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFD2D0D486
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 11:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 599ED3017EDE
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 10:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BDE3033D8;
	Sat, 10 Jan 2026 10:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gL5xClzi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="G71BZGu4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378C130171A
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 10:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768040059; cv=none; b=KesI2K05yYSlEPBEo18n3MZ1GaZPOblNfJshiqnUzEWFoqmivIOs3d9ys4IHcB0/xpujvvKqndeW2zjiOg8DjEqJ876R6l9GS4U8bAbME/f4c0OytYB2N49m6EOEyL4Y+7YkCholC3xnCzLRlgP6HjOLcK/IxmlHCAiflJw6YOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768040059; c=relaxed/simple;
	bh=GR3k999HC/wBwuDdQiVyvY8an+sH4jRx08ZnxkTnhTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G3l3B1YgWUx8uvdZNAmlVlNneub5cve22iPh7xm3jlUBPry2CycafuMVtihL8e7OYVaCgxiw72OLO0SZBC93GYvZFVXybGBhHw0Ca3EPYoKhZWE0ueU7va94IzNP0lSCH8gojOoPasR2PiRB9KqzW+F6NDRYGzOvUnYlDgE4Tyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gL5xClzi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=G71BZGu4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768040057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dA+ZbEhpNNEZeZ/tio972zkgtuSqnUftWgoWPgE0LNo=;
	b=gL5xClziAG9lNksl1hWzHMS19QBdTivcmBH8YXIO4fxJCQgtm1GdvmGgBLNhYUuIlotsRQ
	Xtw4RJqznksZoagfVCuyQEyJo5TlOeDUVXvmsBW16iGLRokdtSIJdBpA8ybiy4ojqtsz5t
	5Kx2J6Ewd05Z6Wm+diuayROmXfTWuVM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-rVzDKd6-PmSmmJ9NDJXo3g-1; Sat, 10 Jan 2026 05:14:15 -0500
X-MC-Unique: rVzDKd6-PmSmmJ9NDJXo3g-1
X-Mimecast-MFC-AGG-ID: rVzDKd6-PmSmmJ9NDJXo3g_1768040055
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477771366cbso39204145e9.0
        for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 02:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768040054; x=1768644854; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dA+ZbEhpNNEZeZ/tio972zkgtuSqnUftWgoWPgE0LNo=;
        b=G71BZGu4owZ3Ue6J31vWpDgumNOP3djauKUn4sOFFt47FTTdInHZB8oSTTS2a/VhW/
         JQegkBxDST6sIF/8cvMKzxLUokmobVrmFWUqLM4UlQXuMlBVk/3q0eeC5A9AYtFN2ajo
         CSp+oArnlytsCUJCXjLruENqkrkSHBtNCnac49u7USRHt2dW9OYFzET+PyX0iWLvjxq/
         O2C2zHGsrYS60YGDGyKhEwyiob/u5qC8RDGuWQF2UgQ4f7WuOUPaKzJT6YhvQrW01gud
         ZH1B7jFiLJZLovTlSYptCr3bM6jWkxUoj1jhnO+/G41uzaBkmmFObDDiVZ2slBXAK9Ko
         basQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768040054; x=1768644854;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dA+ZbEhpNNEZeZ/tio972zkgtuSqnUftWgoWPgE0LNo=;
        b=iNoCZFpTXDAFxEJ/Yt2Uxd0a+fI5S5T1mm61NmLNnyglYnR6tArwiqLY9LtLVMQYtS
         TQWi6IAHcoiWsJwdgit5akbg1Q9PCcK7V1SiUJTpHfCO/ar1KZJzk4hdAPex4a0woQOX
         zUtprd3+TtGLm0qaeD1IxdtIKckJkNAh4HPPKN2Azu7D7JOvgETONCJZNNXr+3ylLSmI
         z8cKqeZht0PL+OJAB79uAshK2pX0u16xESYuuI7hJePtE7gIvoAc6pS+vkn0UjK+kiV+
         QPdWubLEpn3vNt+wtnNIytCr5G3Ha7gM/Fof4htV31QNoidWaZ3b55NvfxIp+eeHC2aM
         Ky4g==
X-Forwarded-Encrypted: i=1; AJvYcCX7oeXYYZGjaPQGDYPsX3ORrY7Ic+G+GPRqc1tvkmP11Hv/21B2JK3u9SzsQAjTMwIpSVW+BZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGVqnWnXy0XDYvDpN9lA2nVmFCC2PeG1NP8IMsJOA1ZqZ0y0U5
	veo+xsDftGY1D+jn72taFva7xj/hVkPmQl1rJfb+xGF7aXbJVtET+pAcVGDvfXcnozqCtc0P+qa
	ntoZD72iv5lUZ6muktaqqC9hmvcamd6sizrpQipINQ0q80qF3gv506SG9mQ==
X-Gm-Gg: AY/fxX6sG8aXmNmiHSTmlnf+Zuqt9kdpE53SnGfvH+eTvzOmGcTlh5wH2XQR4gxPPr2
	mQpbi+SxY4tmVydJ6vKgDMGb9FYgzvPf3Oue42krQUES327a+aouJxRamrO0q82RZhqFkim7nx6
	sYMxOydr3I2+Me6uO4vkLOw8zZXggT17nMUj4IUOI8FXw4sbO+6XD6sQLOOyU6aDyssbPRP+NNi
	abdVHiRPALqmcWxLynzu0qVUGeif6gxuwlGDDpnpTHSASAdjvyZWd6KiNgMCGQELvI6G4uKz4Id
	qPmyu2DEJear1uVvpxv2BcJsmwO9VgdNBGEFDu3hk0F7EaDOiIfv0n58TEx5kwKI7sG1nK3knha
	jmP5S
X-Received: by 2002:a05:600c:4fd4:b0:479:35e7:a0e3 with SMTP id 5b1f17b1804b1-47d84b3b687mr144672825e9.30.1768040054564;
        Sat, 10 Jan 2026 02:14:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsvcWZT602v6D3Jk4OZpQRCrttnIFGdd1e0R1U9h/xIHk0Xd/hakt57g7VJk+sGDBWCw9vRw==
X-Received: by 2002:a05:600c:4fd4:b0:479:35e7:a0e3 with SMTP id 5b1f17b1804b1-47d84b3b687mr144672455e9.30.1768040054093;
        Sat, 10 Jan 2026 02:14:14 -0800 (PST)
Received: from redhat.com ([2a06:c701:73f2:9400:32c:f78d:ab04:e7a0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d87167832sm86921535e9.7.2026.01.10.02.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 02:14:13 -0800 (PST)
Date: Sat, 10 Jan 2026 05:14:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Bui Quang Minh <minhquangbui99@gmail.com>, netdev@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v3 1/3] virtio-net: don't schedule delayed refill
 worker
Message-ID: <20260110051335-mutt-send-email-mst@kernel.org>
References: <20260106150438.7425-1-minhquangbui99@gmail.com>
 <20260106150438.7425-2-minhquangbui99@gmail.com>
 <20260109181239.1c272f88@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109181239.1c272f88@kernel.org>

On Fri, Jan 09, 2026 at 06:12:39PM -0800, Jakub Kicinski wrote:
> On Tue,  6 Jan 2026 22:04:36 +0700 Bui Quang Minh wrote:
> > When we fail to refill the receive buffers, we schedule a delayed worker
> > to retry later. However, this worker creates some concurrency issues.
> > For example, when the worker runs concurrently with virtnet_xdp_set,
> > both need to temporarily disable queue's NAPI before enabling again.
> > Without proper synchronization, a deadlock can happen when
> > napi_disable() is called on an already disabled NAPI. That
> > napi_disable() call will be stuck and so will the subsequent
> > napi_enable() call.
> > 
> > To simplify the logic and avoid further problems, we will instead retry
> > refilling in the next NAPI poll.
> 
> Happy to see this go FWIW. If it causes issues we should consider
> adding some retry logic in the core (NAPI) rather than locally in
> the driver..
> 
> > Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx")
> > Reported-by: Paolo Abeni <pabeni@redhat.com>
> > Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results/400961/3-xdp-py/stderr
> 
> The Closes should probably point to Paolo's report. We'll wipe these CI
> logs sooner or later but the lore archive will stick around.
> 
> > @@ -3230,9 +3230,10 @@ static int virtnet_open(struct net_device *dev)
> >  
> >  	for (i = 0; i < vi->max_queue_pairs; i++) {
> >  		if (i < vi->curr_queue_pairs)
> > -			/* Make sure we have some buffers: if oom use wq. */
> > -			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
> > -				schedule_delayed_work(&vi->refill, 0);
> > +			/* Pre-fill rq agressively, to make sure we are ready to
> > +			 * get packets immediately.
> > +			 */
> > +			try_fill_recv(vi, &vi->rq[i], GFP_KERNEL);
> 
> We should enforce _some_ minimal fill level at the time of open().
> If the ring is completely empty no traffic will ever flow, right?
> Perhaps I missed scheduling the NAPI somewhere..

Practically, single page allocations with GFP_KERNEL don't
really fail. So I think it's fine.

> >  		err = virtnet_enable_queue_pair(vi, i);
> >  		if (err < 0)
> > @@ -3472,16 +3473,15 @@ static void __virtnet_rx_resume(struct virtnet_info *vi,
> >  				struct receive_queue *rq,
> >  				bool refill)
> >  {
> > -	bool running = netif_running(vi->dev);
> > -	bool schedule_refill = false;
> > +	if (netif_running(vi->dev)) {
> > +		/* Pre-fill rq agressively, to make sure we are ready to get
> > +		 * packets immediately.
> > +		 */
> > +		if (refill)
> > +			try_fill_recv(vi, rq, GFP_KERNEL);
> 
> Similar thing here? Tho not sure we can fail here..
> 
> > -	if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
> > -		schedule_refill = true;
> > -	if (running)
> >  		virtnet_napi_enable(rq);
> > -
> > -	if (schedule_refill)
> > -		schedule_delayed_work(&vi->refill, 0);
> > +	}
> >  }
> >  
> >  static void virtnet_rx_resume_all(struct virtnet_info *vi)
> > @@ -3829,11 +3829,13 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
> >  	}
> >  succ:
> >  	vi->curr_queue_pairs = queue_pairs;
> > -	/* virtnet_open() will refill when device is going to up. */
> > -	spin_lock_bh(&vi->refill_lock);
> > -	if (dev->flags & IFF_UP && vi->refill_enabled)
> > -		schedule_delayed_work(&vi->refill, 0);
> > -	spin_unlock_bh(&vi->refill_lock);
> > +	if (dev->flags & IFF_UP) {
> > +		local_bh_disable();
> > +		for (int i = 0; i < vi->curr_queue_pairs; ++i)
> > +			virtqueue_napi_schedule(&vi->rq[i].napi, vi->rq[i].vq);
> > +
> 
> nit: spurious new line
> 
> > +		local_bh_enable();
> > +	}
> >  
> >  	return 0;
> >  }


