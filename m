Return-Path: <netdev+bounces-99383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A92C8D4B0C
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 13:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54C091C22925
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 11:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD1D17836F;
	Thu, 30 May 2024 11:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ju7MmyE6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927C9176FA3
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 11:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717070007; cv=none; b=j/Z/AsVpQKBEwPBpYcQfcUNZx+mWOMWIDjHxZIEnp4rd/1sKE992XaxIj65KgyjtDhArCGAq6uYeh8OWNYkrIeZbykRaQtr10OFsOKN0L3fk1ZEc73Eiz+XAE1Gy8w2PDJ1l7NczqA9dvz/G40CxZuposHtwDN2HECUCGBnJZc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717070007; c=relaxed/simple;
	bh=a5RoNmw3LEtmCv84g3foK1aKa72JGF8L3MC+ZOG8Gz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TkhfBYteRKzlJPu0/slKXZjpNbv3jbVfaKjny2fE0QcFtnAEPvYU/hAYhs3vy/LuPgJWXueRsTPE/vTCt6R7Th9t7g46n108SlT7R2cndtkuEnDj954BpvO/XAJ7MV+Zqp6H3UuKnKKoOqgKiR5pU91vwXKniJHB9QaeQ7a060I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ju7MmyE6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717070004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QaJ08O7JdNI93KJGm73XMZhzelj+VajVlq/Gw0RkfEU=;
	b=Ju7MmyE6qG9/MOUH5DUqudiPA4RyUzZTYBSMXu2oM5w4IKirQEIrsFGdveekV+Ukrx3MCF
	DvVeJooWgUUsJjGGIOh7b/8V76El64LbqaWJhN5ATnqaUSZshFvslo25vJIYlvuSRCQxn9
	jmB91y1sb7micHRZ5K3KyguEv6FNpfA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-GNyQwRxiMKmwbRo4TNbxRw-1; Thu, 30 May 2024 07:53:23 -0400
X-MC-Unique: GNyQwRxiMKmwbRo4TNbxRw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4210cd005b3so5492045e9.2
        for <netdev@vger.kernel.org>; Thu, 30 May 2024 04:53:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717070002; x=1717674802;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QaJ08O7JdNI93KJGm73XMZhzelj+VajVlq/Gw0RkfEU=;
        b=BNtnaFnsG6IgERMY2+apnVpJGlp8b8MO+T4vrzOZOE2OxDi+dKD9p87vOmTLEVp8ao
         DHFZ8Ktw2rgiRjwmVlXci2/O/YSiRMiVHtm3+6jdqTfCAwcU+t0iht3BbTmiA1cHrH6B
         QU/N4jQ8QqMigWv0lTS1InKY/48nuSqTkTq7JOL9JlaTNcNTiuciI/zc8KMwZcQVp2qO
         b6E+eTYz9hzYV7hfZaC1/EGxWsC/QMjkDZp0QTZhIWcWYpGHL2Ajo7Jq3IVj7ku2qkxY
         sUaQ9DT6F6GAZFW4kuZB77UzIt2I/PkoyAtss2QhdADJAjrQ5INWCacYTvJTwWRwMRyN
         d+nA==
X-Gm-Message-State: AOJu0YzOmQvGfY9T2oIeebgkFuTzu1McWNSi8MLgBs3jiPR6F6mqXlNR
	C17U8uF/CmVe209vRBq9XIvh0Dkl71GB0YY0EvP+SDCpNZQ0sSJoH+dLv39PBCNzOOuI2pzfYkp
	8ozZpIJG8s9JPC77D7qBGn2+cy5Hj2NfmVPp9Qh+a3Z+c3zaNCnrgxw==
X-Received: by 2002:a05:600c:3c9e:b0:41f:eba9:ced4 with SMTP id 5b1f17b1804b1-42127817a46mr21345915e9.16.1717070002014;
        Thu, 30 May 2024 04:53:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEceci61giza+Mfylw+1jbKk7Vb1KMIlL8tVEyZVSFKJGK4nLI8VQ/9gqBvA2EqJRwnujJi8g==
X-Received: by 2002:a05:600c:3c9e:b0:41f:eba9:ced4 with SMTP id 5b1f17b1804b1-42127817a46mr21345615e9.16.1717070001403;
        Thu, 30 May 2024 04:53:21 -0700 (PDT)
Received: from redhat.com ([2a02:14f:179:fb20:c957:3427:ac94:f0a3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212706ea02sm23212155e9.30.2024.05.30.04.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 04:53:20 -0700 (PDT)
Date: Thu, 30 May 2024 07:53:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2 00/12] virtnet_net: prepare for af-xdp
Message-ID: <20240530075003-mutt-send-email-mst@kernel.org>
References: <20240530112406.94452-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530112406.94452-1-xuanzhuo@linux.alibaba.com>

On Thu, May 30, 2024 at 07:23:54PM +0800, Xuan Zhuo wrote:
> This patch set prepares for supporting af-xdp zerocopy.
> There is no feature change in this patch set.
> I just want to reduce the patch num of the final patch set,
> so I split the patch set.
> 
> Thanks.
> 
> v2:
>     1. Add five commits. That provides some helper for sq to support premapped
>        mode. And the last one refactors distinguishing xmit types.
> 
> v1:
>     1. resend for the new net-next merge window
> 


It's great that you are working on this but
I'd like to see the actual use of this first.

> 
> Xuan Zhuo (12):
>   virtio_net: independent directory
>   virtio_net: move core structures to virtio_net.h
>   virtio_net: add prefix virtnet to all struct inside virtio_net.h
>   virtio_net: separate virtnet_rx_resize()
>   virtio_net: separate virtnet_tx_resize()
>   virtio_net: separate receive_mergeable
>   virtio_net: separate receive_buf
>   virtio_ring: introduce vring_need_unmap_buffer
>   virtio_ring: introduce dma map api for page
>   virtio_ring: introduce virtqueue_dma_map_sg_attrs
>   virtio_ring: virtqueue_set_dma_premapped() support to disable
>   virtio_net: refactor the xmit type
> 
>  MAINTAINERS                                   |   2 +-
>  drivers/net/Kconfig                           |   9 +-
>  drivers/net/Makefile                          |   2 +-
>  drivers/net/virtio/Kconfig                    |  12 +
>  drivers/net/virtio/Makefile                   |   8 +
>  drivers/net/virtio/virtnet.h                  | 248 ++++++++
>  .../{virtio_net.c => virtio/virtnet_main.c}   | 596 +++++++-----------
>  drivers/virtio/virtio_ring.c                  | 118 +++-
>  include/linux/virtio.h                        |  12 +-
>  9 files changed, 606 insertions(+), 401 deletions(-)
>  create mode 100644 drivers/net/virtio/Kconfig
>  create mode 100644 drivers/net/virtio/Makefile
>  create mode 100644 drivers/net/virtio/virtnet.h
>  rename drivers/net/{virtio_net.c => virtio/virtnet_main.c} (93%)
> 
> --
> 2.32.0.3.g01195cf9f


