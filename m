Return-Path: <netdev+bounces-96654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A668C6E7D
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 00:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAB7C1F229B8
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 22:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E7D15B569;
	Wed, 15 May 2024 22:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KmmB9soO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D012815B103
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 22:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715811446; cv=none; b=tdqFcG6hidIklIcWNZ5BQjnd9dGm5xFiga5FPODMxtf0ojVvtsmyo/AiAoiB9VHzl1145qAyYfRupG5kyXXgXBADJT5HgQZSGrGec3ClEZcFcg5dZgto5ph74iFDpgOjpp2rerC7mvcQ6m0+RsINP6VM86Ta0idGQIQmR20XqwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715811446; c=relaxed/simple;
	bh=5Lb04IOxAFHZl0H1mV+xBky+LXkYjevp1pkg8SVXj0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=diAglUvE2a4X3Z0P8cSf4ipHJ/AYwPDs2xxa+IgxsKws1PpZzqYMa+w/0MYZJrPDk+tF3uf/g3NCiFSqSO8gSJoa+NvrjtJkTm/EX9VAeZ6O44M6so3d5sYPK7uXJnekVfI/0O84C/YIfSTjSx4g46OHak3i+931N18r0xsyw20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KmmB9soO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715811442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EZN0wVmWs2EnG1RV9I+3ErWKTp5IW4jpo10Yojdq8Hs=;
	b=KmmB9soO/Z56jun/aXSGvmVANSmB8rQfp4nDkpOUiD1/mF/xhybM2uN5/IbUofO3kxEPZX
	snKKBG5cduWqNwuWZeLTbHqy41vRlIfu7Jxn5vRy6XWJiGLRy0pgo2o3U/CuE+IcoAVKOs
	c/xJKZH9mxBXyROmuO6mpPLX1Gt73e4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-eKfPhmfWPs2cuDg45qiL3g-1; Wed, 15 May 2024 18:17:21 -0400
X-MC-Unique: eKfPhmfWPs2cuDg45qiL3g-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42024ca94d0so6741825e9.1
        for <netdev@vger.kernel.org>; Wed, 15 May 2024 15:17:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715811440; x=1716416240;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EZN0wVmWs2EnG1RV9I+3ErWKTp5IW4jpo10Yojdq8Hs=;
        b=YwsE14pM8hpVRRXxrgKOgk+VihmKU9ydAs58oTR+mVYTVZoWi9YQ3a8GocEZkJClEE
         TF8XVpHBfG11Uie5NhfdxkSu5aORTSOfYKiVr6zeS/DahjAz2ELBi3sa+skdPAPcwsQm
         ZlR+tV9+Pkas8lrmTNf/+uxB64G/VtHWlKdIEJHBHPagAMsWQgEs5WWcYwjYdBqj0ESV
         rqAQY7olszg5e1jLzTNNEVnleQFIqq0X5oX+IvzZ4cAaD97Eo6t/L9GQleRboXizpU1W
         0VFXio87srA9lWUSgbikk2amnD87/tiVxELggipEIDKOuD5gBEAo+u6Qi5sNJwTXs5O0
         OarQ==
X-Gm-Message-State: AOJu0YxQmlKLXonzoS758ZrMC7Co+V8aifNCVXXym9GY6HGo3kO9jRQa
	mrKMO3LjLFF4bXssm1EImDJyRUn4ysD/DNA5EtESnrsCSylhluRx9SbTW0A9BTXzAGiIow+z7lt
	coqcl7vmXGu872V9CqZYfZhGt9PTpYzmnnBFs6mQZmeJu1UFBZPFtkg==
X-Received: by 2002:a05:600c:4705:b0:418:f5a9:b91c with SMTP id 5b1f17b1804b1-41fead65a1bmr116997885e9.33.1715811440045;
        Wed, 15 May 2024 15:17:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5P3/Oya1xRhWyAyXMJIMSfGyBGzEjtt1Hz1ue8IRQmpEkMwr+1aF7P3KXgLTzDOVE/m+eeA==
X-Received: by 2002:a05:600c:4705:b0:418:f5a9:b91c with SMTP id 5b1f17b1804b1-41fead65a1bmr116997725e9.33.1715811439493;
        Wed, 15 May 2024 15:17:19 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:443:357d:1f98:7ef8:1117:f7bb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fa9dbab53sm260530495e9.13.2024.05.15.15.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 15:17:19 -0700 (PDT)
Date: Wed, 15 May 2024 18:17:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	jiri@nvidia.com, Eric Dumazet <edumaset@google.com>
Subject: Re: [PATCH v3] virtio_net: Fix missed rtnl_unlock
Message-ID: <20240515181647-mutt-send-email-mst@kernel.org>
References: <20240515163125.569743-1-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515163125.569743-1-danielj@nvidia.com>

On Wed, May 15, 2024 at 11:31:25AM -0500, Daniel Jurgens wrote:
> The rtnl_lock would stay locked if allocating promisc_allmulti failed.
> Also changed the allocation to GFP_KERNEL.
> 
> Fixes: ff7c7d9f5261 ("virtio_net: Remove command data from control_buf")
> Reported-by: Eric Dumazet <edumaset@google.com>
> Link: https://lore.kernel.org/netdev/CANn89iLazVaUCvhPm6RPJJ0owra_oFnx7Fhc8d60gV-65ad3WQ@mail.gmail.com/
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

net tree I presume.

> ---
> v3:
> 	- Changed to promisc_allmulti alloc to GPF_KERNEL
> v2:
> 	- Added fixes tag.
> ---
>  drivers/net/virtio_net.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 19a9b50646c7..4e1a0fc0d555 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2902,14 +2902,14 @@ static void virtnet_rx_mode_work(struct work_struct *work)
>  	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_RX))
>  		return;
>  
> -	rtnl_lock();
> -
> -	promisc_allmulti = kzalloc(sizeof(*promisc_allmulti), GFP_ATOMIC);
> +	promisc_allmulti = kzalloc(sizeof(*promisc_allmulti), GFP_KERNEL);
>  	if (!promisc_allmulti) {
>  		dev_warn(&dev->dev, "Failed to set RX mode, no memory.\n");
>  		return;
>  	}
>  
> +	rtnl_lock();
> +
>  	*promisc_allmulti = !!(dev->flags & IFF_PROMISC);
>  	sg_init_one(sg, promisc_allmulti, sizeof(*promisc_allmulti));
>  
> -- 
> 2.45.0


