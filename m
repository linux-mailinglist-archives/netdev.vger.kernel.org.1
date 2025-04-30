Return-Path: <netdev+bounces-186932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CF4AA41B5
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 06:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD4721BC825A
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 04:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D85D1465B4;
	Wed, 30 Apr 2025 04:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DIjhfQ1T"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88CA29CE6
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 04:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745986577; cv=none; b=I37+wbbO+JObEzEAXb3eO+CPGzeXgrcMbnG+tDSCZ/uigBkNCq8zziC1J9eSKUooxB3KfoL8rxCjEicJHLH/VnEJsX7Z2DEgg5XQwmiX05NibQLJkPJIF76AihNNLw7CaB2iQGjJ6eksIZ7s6ptG2imUT/0iGwUTD9p/Mwg062s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745986577; c=relaxed/simple;
	bh=zgDHxZHHrf4WGJgqJqT62WLPzI28iR81A8ZXmn05rSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fWH5+8f6fu+Yts+lYXUAXSb5zsDb782Y83EmldCiT+m6Dk9lIeQxWAkW2UBZzoN9Sy6f09LfC2ek+bkHr51wRr4+djzg5cWAQCtwb+QVRjo6nowIGvsjD4WWmjvQNcj/v+3/6LinEK09bQamcOz5jq/+9gY+nXMmFKQtwHIPL/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DIjhfQ1T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745986573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ygUsX5Aj+sOuYKbO8rsoFiUIMipny1zZHHgpVhDkmo4=;
	b=DIjhfQ1TdxOWl1l6CAxguM1bv8iTbX6xcobnDiI/KgxkKzTKMIdgAPevBdnmUtVahIvq9c
	2LqX6wF5XYlaJrpatdFjUbmqHmu5jyMCgf38fzhUKVSns33KimtDFDjQgtSThODs7oKQCu
	ALWxiSHFGAcw4YAYnG61Yfc62sF7xE4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-STTG5_38NfetRLoz-UaYQA-1; Wed, 30 Apr 2025 00:16:12 -0400
X-MC-Unique: STTG5_38NfetRLoz-UaYQA-1
X-Mimecast-MFC-AGG-ID: STTG5_38NfetRLoz-UaYQA_1745986569
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-39134c762ebso2082039f8f.0
        for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 21:16:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745986569; x=1746591369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygUsX5Aj+sOuYKbO8rsoFiUIMipny1zZHHgpVhDkmo4=;
        b=pqmGGiSjObVT8gnL6ovEK3oS7gq+0Qypc5IvMtvTWSylT0vUPE48ZGqJ96hmJNBEvw
         A9QHHZZ9BiwDQrVE7k9RG8sam+5U/2j1CYg4jKOmIJ1Wgyw72vMTo5FV/fETaP26izqL
         ZZLmfrhi5J+EXf6Rw+aBgiz27NQCBauGAk/bgDXaVhYZTuJbkbdJ3W1aiq2loPN24Kcs
         9lpQ/R09LXMV+AYXTouN2oefIha3uFXQqKeyJ9XGpMwEvoSAaH1owbsPYSmUywvkmXPj
         YmJiPwkwNmwvNq6izkIc6tYxRY2haGRw0YO6+dZpFnEpJZJ0988xJTcHGk5yOA6TtmOL
         OmEw==
X-Forwarded-Encrypted: i=1; AJvYcCW5prEbEa6fkeHajSdywIi+fI+7A4N/SVf/L9gTEBQG10cB/8boytzm/d4f643rt6lb5Oh3snc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwhQNW64HrGPTs32onrX5IP5qsn9U2YyZjx3EeRIXjVDkMIaxt
	pI5HkkR/OoKvihsuCmiilDnUHEREfB2ev99+3d7ZSLVIM4VXEj+qwRAWbcr61/e5QMrBO5QWI5z
	boRVYBLjCYpqibuWTTW9qyazl3upQvaAx7A7HGlr7nBThK25bBlBFFw==
X-Gm-Gg: ASbGncvTHUHjMf7yG9/rQZgjI49kxsLxO8Z12l0qEiFbS0BugRIazeAQvPBiTKvMvzg
	tycvZ/b/QWrSUFLAXoddCuAJb+mNQCOZzMFm2DTWaDbdgCuFB0jNOQ0cP7m86GKEUdDC+dGcUAZ
	hmQreimx7xq49CTheAx8ntO9AUWim6kP5ZQQtH0WXdfGEciwRWd4a/s7IuAbYFD+pDVD4BFBxL1
	kpRio+AtkZzpSnrNv6+tfUCtnx0mZ1MSFk4sv9nonSq+eKBXMxTB/lgDGDBNUYYzSerq+k4KBB7
	uNyPkg==
X-Received: by 2002:a05:6000:3107:b0:39e:cbd2:986e with SMTP id ffacd0b85a97d-3a08f7549d1mr1353162f8f.5.1745986569040;
        Tue, 29 Apr 2025 21:16:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+lHolfiev/9wzrSLD/goStrUPIkJvBTYC7L3ZO/UV3vmik+9LstEAjZayv9Op1hJoC/Zxjg==
X-Received: by 2002:a05:6000:3107:b0:39e:cbd2:986e with SMTP id ffacd0b85a97d-3a08f7549d1mr1353146f8f.5.1745986568705;
        Tue, 29 Apr 2025 21:16:08 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b391c42bsm3531975e9.39.2025.04.29.21.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 21:16:07 -0700 (PDT)
Date: Wed, 30 Apr 2025 00:16:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, minhquangbui99@gmail.com, romieu@fr.zoreil.com,
	kuniyu@amazon.com, virtualization@lists.linux.dev
Subject: Re: [PATCH net] virtio-net: don't re-enable refill work too early
 when NAPI is disabled
Message-ID: <20250430001555-mutt-send-email-mst@kernel.org>
References: <20250429143104.2576553-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429143104.2576553-1-kuba@kernel.org>

On Tue, Apr 29, 2025 at 07:31:04AM -0700, Jakub Kicinski wrote:
> Commit 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx")
> fixed a deadlock between reconfig paths and refill work trying to disable
> the same NAPI instance. The refill work can't run in parallel with reconfig
> because trying to double-disable a NAPI instance causes a stall under the
> instance lock, which the reconfig path needs to re-enable the NAPI and
> therefore unblock the stalled thread.
> 
> There are two cases where we re-enable refill too early. One is in the
> virtnet_set_queues() handler. We call it when installing XDP:
> 
>    virtnet_rx_pause_all(vi);
>    ...
>    virtnet_napi_tx_disable(..);
>    ...
>    virtnet_set_queues(..);
>    ...
>    virtnet_rx_resume_all(..);
> 
> We want the work to be disabled until we call virtnet_rx_resume_all(),
> but virtnet_set_queues() kicks it before NAPIs were re-enabled.
> 
> The other case is a more trivial case of mis-ordering in
> __virtnet_rx_resume() found by code inspection.
> 
> Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx")
> Fixes: 413f0271f396 ("net: protect NAPI enablement with netdev_lock()")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>


Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> CC: mst@redhat.com
> CC: jasowang@redhat.com
> CC: xuanzhuo@linux.alibaba.com
> CC: eperezma@redhat.com
> CC: minhquangbui99@gmail.com
> CC: romieu@fr.zoreil.com
> CC: kuniyu@amazon.com
> CC: virtualization@lists.linux.dev
> ---
>  drivers/net/virtio_net.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 848fab51dfa1..4c904e176495 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3383,12 +3383,15 @@ static void __virtnet_rx_resume(struct virtnet_info *vi,
>  				bool refill)
>  {
>  	bool running = netif_running(vi->dev);
> +	bool schedule_refill = false;
>  
>  	if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
> -		schedule_delayed_work(&vi->refill, 0);
> -
> +		schedule_refill = true;
>  	if (running)
>  		virtnet_napi_enable(rq);
> +
> +	if (schedule_refill)
> +		schedule_delayed_work(&vi->refill, 0);
>  }
>  
>  static void virtnet_rx_resume_all(struct virtnet_info *vi)
> @@ -3728,7 +3731,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>  succ:
>  	vi->curr_queue_pairs = queue_pairs;
>  	/* virtnet_open() will refill when device is going to up. */
> -	if (dev->flags & IFF_UP)
> +	if (dev->flags & IFF_UP && vi->refill_enabled)
>  		schedule_delayed_work(&vi->refill, 0);
>  
>  	return 0;
> -- 
> 2.49.0


