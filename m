Return-Path: <netdev+bounces-96594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E43368C6945
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 17:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11AB61C21F0D
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 15:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9757215573D;
	Wed, 15 May 2024 15:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FZGx38Is"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122B915575E
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 15:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715785678; cv=none; b=uX4o9laNjkTzQpCPs+U8IozWkDl/YDct3yUFJLhb3ZdOxROnyw1NR5VroiRbqOW0V2eOMyv01asGRTZMCXEtvFv67K7KOYppnOuO78yQpMn+WCPIp/LqwH8oLDPHZrQIyITKdeB09pgqqpuMCLykXUc32NQ9gRB3esRa8cAO29c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715785678; c=relaxed/simple;
	bh=4kwqZOsHkHkC7vF55q95cqcIf9m/KCYHiCaiDGJADbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EnKvkopY0xDVsw7JBGTyjC56lBDd6xTiMOnOIU7C85GcCQINcfEGFhrJCipP6SFe5g4Rx4CYmLy7yggVatRKzhuoglyRAzFZC3wicbc9YCCJ+MwHMdceDVTMZnFYsMp+ZGx1rKgOEIe6M4LfgPxyRzwlH8mUTommQiUXGmdfGB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FZGx38Is; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715785676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1Y5LmjyinNpOK5AewP0EhrT5FIK8gwKzGrfp3dWcri4=;
	b=FZGx38IsAuIsNNMRZD5W8E93GQD3hpZlKMhiJw0R2hHF3lDzrSJtAC7pRkdFj07H95meBx
	tKrmq1xjGYgp6SRbastBW6ZXBxvZLjIi/lXT9MC7AJ6mo3+aWFy/bUnJqs6UTlHncEABpf
	PDpY8hzD3VujUZx+c4sSvN6pitImt30=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-cTVgBLOwP0-eHrvOJq03Og-1; Wed, 15 May 2024 11:07:44 -0400
X-MC-Unique: cTVgBLOwP0-eHrvOJq03Og-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42011360193so30778225e9.3
        for <netdev@vger.kernel.org>; Wed, 15 May 2024 08:07:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715785663; x=1716390463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Y5LmjyinNpOK5AewP0EhrT5FIK8gwKzGrfp3dWcri4=;
        b=bP8l2MLENTg9jap59dQU3vBgEw3scA6CqdtRwbjC0j/f5ffEEusOoE2YnZX2qOExsP
         9wlVt9iN32O/lyyhrSpvzr2yCKXFm33Vjqq8PPKIRxNbtrfj2yYiel8r8ZRaiEDKC9xM
         ZXHJn1d+DWM2xYfK25BJOkdVUDLXt6XGF5Ij0Yccn7WdSmsBtCl66bDVYlIX9b3VHCvJ
         jkaLGjsVG+x4M1OMIA14vCLNO0d4/IHMsz13H+Kre8k+JOcPo3v3XO5IRnYMAnARgNxM
         n33ZL5rctA89CCDuGRqgeVRbvUp0SqfIK9Vo1/He+KSJM6SPRPsD45MHcRkMu44apuDT
         ZQpg==
X-Gm-Message-State: AOJu0YwuElV15Ng+TJgE1M2wb7DuB70dIv1BiAxcmsS3styTHqlGt2da
	PPjXqjpR2tbollQdmlLSFxXBBpkCJCgNT11SS+v1KZX64FTSqP9sU03yPAXY4tPxZPPv1oi9vQc
	hMynDOMLOKuBguNG0ek3BZwl0vCPFf0J2Wju63euX95HH/LZXQt559Q==
X-Received: by 2002:a05:600c:4683:b0:41b:f6b6:46cf with SMTP id 5b1f17b1804b1-41feaa38ab0mr142390755e9.11.1715785663288;
        Wed, 15 May 2024 08:07:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0UKh1tOV/wBnFRQ5wDIRuqGtj+ZtTNaCx+aXjZOOMmuWMYgdOY/ov/oV5PZgaLTL+EaSOuA==
X-Received: by 2002:a05:600c:4683:b0:41b:f6b6:46cf with SMTP id 5b1f17b1804b1-41feaa38ab0mr142390415e9.11.1715785662677;
        Wed, 15 May 2024 08:07:42 -0700 (PDT)
Received: from redhat.com ([2a02:14f:175:c01e:6df5:7e14:ad03:85bd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b897e39sm16726473f8f.48.2024.05.15.08.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 08:07:42 -0700 (PDT)
Date: Wed, 15 May 2024 11:07:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	jiri@nvidia.com, Eric Dumazet <edumaset@google.com>
Subject: Re: [PATCH] virtio_net: Fix missed rtnl_unlock
Message-ID: <20240515110729-mutt-send-email-mst@kernel.org>
References: <20240515143120.563700-1-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515143120.563700-1-danielj@nvidia.com>

On Wed, May 15, 2024 at 09:31:20AM -0500, Daniel Jurgens wrote:
> The rtnl_lock would stay locked if allocating promisc_allmulti failed.
> 
> Reported-by: Eric Dumazet <edumaset@google.com>
> Link: https://lore.kernel.org/netdev/CANn89iLazVaUCvhPm6RPJJ0owra_oFnx7Fhc8d60gV-65ad3WQ@mail.gmail.com/
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>


Fixes: tag?

> ---
>  drivers/net/virtio_net.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 19a9b50646c7..e2b7488f375e 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2902,14 +2902,14 @@ static void virtnet_rx_mode_work(struct work_struct *work)
>  	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_RX))
>  		return;
>  
> -	rtnl_lock();
> -
>  	promisc_allmulti = kzalloc(sizeof(*promisc_allmulti), GFP_ATOMIC);
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


