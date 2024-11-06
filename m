Return-Path: <netdev+bounces-142242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8842D9BDF74
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 08:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6800B23128
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 07:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EB9193073;
	Wed,  6 Nov 2024 07:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bPCGUco4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D73145B14
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 07:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730878408; cv=none; b=c4tIAwYo8cgcGhokFi30mnS2y+4fE92sfknXeXETFWxr0RZuVv4+lEr5wZvSYMSo8NwXWScpcAMEHzVaqr/BlTa68uFUGc+ijJ/YmSvSfGPm6DYsdqjaWsQ9SI7esXQCJx3Ydbyf54F+Ds5v6mHYBiLYRUcRmnbZYF8WCh+JVmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730878408; c=relaxed/simple;
	bh=33aKOFG3TZuLLl1fcejK3AuJF9J2u973ZT6qcLpNFXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQccdTroxOQMKlNNyX1ZF0D44EhMIOc6seHQdyepppXfwkSZ4skhFyF6YIgyjFosSRcHk7nKyiZgTzauF52s/1SKkmzGgR3Ivs3nPib59quezeLv4gIK9AD24+cP+7OKk8IIWmE/2lIFqBIcw6qGbYJbfTZRzetDEhKCBwoPMbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bPCGUco4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730878406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tFJLAGQHtCF4YbMkyw4tzz7KxDHd+W5Q6WXk9sFF0eA=;
	b=bPCGUco44BVSeCfRQF6t1EIxV6P3SOkr/t8Oidsg1L1Mas/i7IFa1cv0Q1l+qLzaZ1nqWS
	oOu784iI+8nxpT2cSl6a9TcGyJc56l8GAdbuqQfCV8dkog4cJuc6RecC6nlub05dNgiOdC
	BTrmqO/psuDT6kDm74OBvdKle+Co37I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-0XHWnKhdNgqruPuZHu4nSQ-1; Wed, 06 Nov 2024 02:33:24 -0500
X-MC-Unique: 0XHWnKhdNgqruPuZHu4nSQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43157cff1d1so46692045e9.2
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 23:33:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730878403; x=1731483203;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tFJLAGQHtCF4YbMkyw4tzz7KxDHd+W5Q6WXk9sFF0eA=;
        b=VTSpqyZloG8qTQpOwZd0HYQ2Tl/fNucjGyb+ZnSrcv9AHMkX/WNJGJ+9QnUwV4Ue3i
         7Ig0BTZlHhmfcqbYbyIUF+yF6z46O8xI96sVXsGNdwAHtrThm5OPxXGfLEtjWgBCS5co
         UV65xPBJF9zywZV7zHKvMjbfoL0ftSMAX8IDLzgZMM+1du+5Tdab1hxgwEDN7GQl0yYf
         kxYRbAU86ptuv90IsdAE8AcIS8D6yVZdP/Ry/ldULD39xuTi3pShOfFw1+asyXuqop9q
         jNFfCqLnvwnjP7GlE0IMfWzYRgdpRix3fbo42J12OnpriOX2O35dvnYPYVyq1wT1gnLA
         3VRw==
X-Forwarded-Encrypted: i=1; AJvYcCVRt+1Gd9nE0yoTBHEfvNXb1mgMDjpnJvYj0FsZ8sSYp/9NzV0wwjl+VZM9UFZZJYO50uS2udg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNcyueySId7MQyXgojqn/4UTrnzzsH79WVNpIhLuHkcv6Az+86
	r22a2E9eT40wueoEbr8yV1RidsQ1GEHX64CD3Qlkh0icHXecHmjD4GVPFOGZsDGgSk46Ly5SCzH
	tBiQfFT2y2jVeHR5EDST+S3AwXlBenXbL+wFp7EZwILFcw4Ztd7aXIg==
X-Received: by 2002:a05:600c:1f91:b0:426:66a2:b200 with SMTP id 5b1f17b1804b1-4327b6c79f7mr206065255e9.0.1730878403597;
        Tue, 05 Nov 2024 23:33:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/ntsLATwJkkyCIm9/l8825ZGF3r9/sWcOfHZUV3jZ4XNMPDEncs1UxJK3Vl0G5wdr3PGgfQ==
X-Received: by 2002:a05:600c:1f91:b0:426:66a2:b200 with SMTP id 5b1f17b1804b1-4327b6c79f7mr206065085e9.0.1730878403275;
        Tue, 05 Nov 2024 23:33:23 -0800 (PST)
Received: from redhat.com ([2a02:14f:178:e74:5fcf:8a69:659d:f2b2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa52e658sm12280525e9.0.2024.11.05.23.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 23:33:22 -0800 (PST)
Date: Wed, 6 Nov 2024 02:33:19 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 7/9] vhost: Add new UAPI to support change to task mode
Message-ID: <20241106023302-mutt-send-email-mst@kernel.org>
References: <20241105072642.898710-1-lulu@redhat.com>
 <20241105072642.898710-8-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105072642.898710-8-lulu@redhat.com>

On Tue, Nov 05, 2024 at 03:25:26PM +0800, Cindy Lu wrote:
> index b95dd84eef2d..1e192038633d 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -235,4 +235,6 @@
>   */
>  #define VHOST_VDPA_GET_VRING_SIZE	_IOWR(VHOST_VIRTIO, 0x82,	\
>  					      struct vhost_vring_state)
> +
> +#define VHOST_SET_INHERIT_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, bool)


set with no get is also not great.

>  #endif
> -- 
> 2.45.0


