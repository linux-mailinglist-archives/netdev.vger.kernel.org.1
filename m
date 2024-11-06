Return-Path: <netdev+bounces-142304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4439BE28B
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 10:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F2B02847FE
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 09:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA221D63D2;
	Wed,  6 Nov 2024 09:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CqOZLQON"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6182183CD6
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 09:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730885494; cv=none; b=a4zE4qEE9C1Uwnh0ATnrdweUfIx3lWvzefb9Pgibp++y/vEoZOVeUkpLZeUDUC7lHnKMdOSo3tVWzwlFk5AYWed7V3gSh4HFDauk7k+5PT156h53TqAN2l8ATH+4ygmYjhJvxxZW3duWgXUaS7YwWv48w7hz8yOMVWeGHJkp+yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730885494; c=relaxed/simple;
	bh=JiQ4UZeYNmZjPUCdRREOzBbUPxshCp9ydNEIQdTxnkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UyORb2cX2CYz9PsEL9hRkkgurZHbEzxd0ujesuHZkA6Z8mbRLUcE6OtIhtHtGI18hEIzhBlpUhPPiJx4/q+c+qvE5B/cYDT6GdY3YFT4SKffSy+sVbRZADX0x+59qrLwwr2YGzBuoB9qwqdeSVQKZWDK+edfAB/LscOaaSkXElI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CqOZLQON; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730885491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v58eFNnRCpQyAQvqQmmVaZ0uMDgtCEI/dBsjoJSUfhk=;
	b=CqOZLQONqfekpVpOFTT1iIwe5WIQIOjaTxFWlM2CxM70W+rizpfj+UyKbN55K99Di8TgMi
	76lFFzk0zaK/P1KKG5C3BKa0jT9Sr4yX3sIB4/y5pg1HsnjKEolhu/F6urhDo7TFUDkmgZ
	Da6XIhmCwE9v4PPKHavyjBEL3Pr6UaQ=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-KpvpdFf9NiaettBsyshI-Q-1; Wed, 06 Nov 2024 04:31:30 -0500
X-MC-Unique: KpvpdFf9NiaettBsyshI-Q-1
X-Mimecast-MFC-AGG-ID: KpvpdFf9NiaettBsyshI-Q
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-539e75025f9so3678905e87.3
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 01:31:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730885489; x=1731490289;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v58eFNnRCpQyAQvqQmmVaZ0uMDgtCEI/dBsjoJSUfhk=;
        b=DJDaALmkofRuj9M6wLGDhpSof1LM9d8ij3FjYjHvNcUc3ox6gGxV1n9qCLLWhikpwU
         AjMTEybOZv8WmftrSryXEYuy7A7g/fZd5TT1G+xl2LrNhPILsXtJo7NjXDUrWlEhMXsk
         XochHeZZ5XP1pJand4XFvhELSHHyEsycqvgIBI6/tUVOFAoemwSJQGhqdicz0bZxJlIw
         I+U7m0cGJVVJbypC1jBSHCMNb9z+nJ/pDRP09ropYP+/nTUoS0qDbaDJwkIrllKpBXOQ
         l9F+79ldzMD10vrHvVVIje4Sj/bh+6i2gQfNbnKoZrzEmUurKv41KzyW0GkdESHtAcx3
         g8Rw==
X-Gm-Message-State: AOJu0YwBPWcq0iDU1kvQd+9IyDBAFUCQFGhWa5PcT62C0ACrcCVyB5C/
	DXwJTtLEpDPOEnB6o6vHFoG6NZ0t8o5vzlWEfm+3DSxiXFMbKqNdysgvR+Kowf5abYAcyT0MaFB
	vL4wkwnUMrcv3oXnQntdQ5XT/HDWolRSxxL4HlPOzV1mS+KiTST8VnQ==
X-Received: by 2002:ac2:4e06:0:b0:52c:fd46:bf07 with SMTP id 2adb3069b0e04-53b34a2e4d0mr17637555e87.49.1730885488743;
        Wed, 06 Nov 2024 01:31:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGHSH1SBaQr5jBIsa52gGokkq9bGzxMCBLmYIc/MQMKZVJdyqq8Vzi2SdL9vrY12cUu256ODw==
X-Received: by 2002:ac2:4e06:0:b0:52c:fd46:bf07 with SMTP id 2adb3069b0e04-53b34a2e4d0mr17637538e87.49.1730885488282;
        Wed, 06 Nov 2024 01:31:28 -0800 (PST)
Received: from redhat.com ([2a02:14f:178:e74:5fcf:8a69:659d:f2b2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10eaafdsm18588441f8f.63.2024.11.06.01.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 01:31:27 -0800 (PST)
Date: Wed, 6 Nov 2024 04:31:24 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philo Lu <lulie@linux.alibaba.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	andrew@daynix.com, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/4] virtio_net: Make RSS interact properly with
 queue number
Message-ID: <20241106043106-mutt-send-email-mst@kernel.org>
References: <20241104085706.13872-1-lulie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104085706.13872-1-lulie@linux.alibaba.com>

On Mon, Nov 04, 2024 at 04:57:02PM +0800, Philo Lu wrote:
> With this patch set, RSS updates with queue_pairs changing:
> - When virtnet_probe, init default rss and commit
> - When queue_pairs changes _without_ user rss configuration, update rss
>   with the new queue number
> - When queue_pairs changes _with_ user rss configuration, keep rss as user
>   configured
> 
> Patch 1 and 2 fix possible out of bound errors for indir_table and key.
> Patch 3 and 4 add RSS update in probe() and set_queues().
> 
> Please review, thanks.

Looks reasonable.

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> Philo Lu (4):
>   virtio_net: Support dynamic rss indirection table size
>   virtio_net: Add hash_key_length check
>   virtio_net: Sync rss config to device when virtnet_probe
>   virtio_net: Update rss when set queue
> 
>  drivers/net/virtio_net.c | 119 ++++++++++++++++++++++++++++++++-------
>  1 file changed, 100 insertions(+), 19 deletions(-)
> 
> --
> 2.32.0.3.g01195cf9f


