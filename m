Return-Path: <netdev+bounces-64342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF60A832978
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 13:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FE78B23171
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 12:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C806D4F201;
	Fri, 19 Jan 2024 12:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FEkilApz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381BC4F1F7
	for <netdev@vger.kernel.org>; Fri, 19 Jan 2024 12:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705667307; cv=none; b=YxpYT8bpMQN5SLXesvsdg7aBH0y8WvwV5fjfM9iE01ZLdoafY+RM8D8vTubJoqfJf+NcRWMI957K4QiTS44R8i2vKtJLxdnJplwnGZFWN9NBeuhn5KEJSwGK8X8RWODbbzO4N5zXoWP7HUApb+UYnPmJ/K445CqwaTXl36kM/Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705667307; c=relaxed/simple;
	bh=1yd3vuegWAMTRKs3hhq9NTSKrABM16eTj4S5eR2+1EY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JWoiE05i3GldX87UmdcTcsSSjSVlV6d7InSq03DWNEcue06AZep2T0B0WGNdkvN+Ss18GDGXDISNn0mTpzqsd3OG97rs1HCbLe6k2NHVyKX5dWUJ9mE2yHitfwt3vj3AtRjkvafhTRf/2JRdlc67QyOXOComUoQUu9HJMIxtiok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FEkilApz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705667303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lu6PAuD3ioFybCYQzDmdkPHOFHjBT1D9Zj6epg1rV18=;
	b=FEkilApzaH6KbVRB5fef997zFKjT+0Hha1i8ez9X4N8rCqF3PscwnW8ygmohDh3P2UtY1d
	ThhjU9LLkht/Me3tzf/BV7EiNxzBqH9IjTmHbGVgOyAIOkOyxtYpXHcOnJn4n2SittwABV
	n0eMX+JtvnCD4C96+nxR+gtB0iCBqZA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-XZDHsGBgN6iJJGHhsVo7OQ-1; Fri, 19 Jan 2024 07:28:17 -0500
X-MC-Unique: XZDHsGBgN6iJJGHhsVo7OQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40e5317c7a5so4564665e9.0
        for <netdev@vger.kernel.org>; Fri, 19 Jan 2024 04:28:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705667296; x=1706272096;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lu6PAuD3ioFybCYQzDmdkPHOFHjBT1D9Zj6epg1rV18=;
        b=ld2JBpm4gEIxb5j9CIY8YH+oFDmQGLX7it7Rt17ZljPYTjwZgjRE6u29fw0hISpYYS
         VIEY2nEtOY6+kXVA2uOj4JN52CXgtdmkSAKarIajrXNHnaAhzgdePM1RxbrDsE6f3Mau
         uzAbaYQ/92LND4TGoXDZSo9snvBviV9I0snEo2nzKzDUQokQ3KTWef9EBsJHxGJQ/u3b
         WqBjoN7GgLuOkFL51PFZM0slB0drsu6XREAcJECwR6r9ijAP3o1zdjRsNYSjnPin30PK
         wvKv9e/qE+bY/x3k6fyCc+GzggVB+a/PC8/naCSkAqkQwCIvZb3ommxiztfuJ635bQJt
         GUVg==
X-Gm-Message-State: AOJu0YzIbVV5zdksh8Jkr49FW+t2J2Q/bgqj07CcLlpilk3hhiIYzjQ2
	doD/h7gPHxSngSwznrXLUXWVDohksxeo03ZHS3u5zbxX9izngjZMcGkyDBVA63GREN4D37ocFYP
	N5Xt3pQJsSY3uMCcPqfKm5u8vlvwRIOkDdsXBn0BpkdXxlLM6R9CE7A==
X-Received: by 2002:a7b:cb4e:0:b0:40e:5c0e:7dc0 with SMTP id v14-20020a7bcb4e000000b0040e5c0e7dc0mr1379244wmj.108.1705667296102;
        Fri, 19 Jan 2024 04:28:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRQ7q2eviABxb53dq9k0UI+qYO9BINyvJ+P81JZeeN70Ba5s+vjtIaNcbP8LhhKGkob4YTzg==
X-Received: by 2002:a7b:cb4e:0:b0:40e:5c0e:7dc0 with SMTP id v14-20020a7bcb4e000000b0040e5c0e7dc0mr1379237wmj.108.1705667295747;
        Fri, 19 Jan 2024 04:28:15 -0800 (PST)
Received: from redhat.com ([2a02:14f:175:4aad:e256:6d9f:7a0b:7f5b])
        by smtp.gmail.com with ESMTPSA id iw7-20020a05600c54c700b0040d604dea3bsm28406255wmb.4.2024.01.19.04.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 04:28:15 -0800 (PST)
Date: Fri, 19 Jan 2024 07:28:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next 0/3] virtio-net: a fix and some updates for
 virtio dim
Message-ID: <20240119072743-mutt-send-email-mst@kernel.org>
References: <1705410693-118895-1-git-send-email-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1705410693-118895-1-git-send-email-hengqi@linux.alibaba.com>

On Tue, Jan 16, 2024 at 09:11:30PM +0800, Heng Qi wrote:
> Patch 1 fixes an existing bug. Belongs to the net branch.
> Patch 2 requires updating the virtio spec.
> Patch 3 only attempts to modify the sending of dim cmd to an asynchronous way,
> and does not affect the synchronization way of ethtool cmd.


Given this doesn't build, please document how was each patch tested.
Thanks!

> Heng Qi (3):
>   virtio-net: fix possible dim status unrecoverable
>   virtio-net: batch dim request
>   virtio-net: reduce the CPU consumption of dim worker
> 
>  drivers/net/virtio_net.c        | 197 ++++++++++++++++++++++++++++++++++++----
>  include/uapi/linux/virtio_net.h |   1 +
>  2 files changed, 182 insertions(+), 16 deletions(-)
> 
> -- 
> 1.8.3.1


