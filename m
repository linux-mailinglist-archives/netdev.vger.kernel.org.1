Return-Path: <netdev+bounces-90272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B0F8AD62A
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 22:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0F22B2112F
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 20:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0751BC53;
	Mon, 22 Apr 2024 20:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YqgVx54B"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E36418654
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 20:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713819314; cv=none; b=Oa/Zc/WkPf3nP4QLBFaU4VPmibOyp5lSdRGN29KArv6Ph3Yf55AYphMYdGiye2v0UMjuocQQ3ALuygbD6bvfNuEC5of4xuOZYzYf76Kw0tZhSz5gD0xvv1EvC/KAYSiFAoKAlLC/yrcqTBcWbmv+vdny1HhZssHQ47/PRp2s/WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713819314; c=relaxed/simple;
	bh=7NPx0m69QGK/K52N5RPTJZOB/2IxrbETFrl7bRUu6hI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPlrd9XptRUIXC4KFrkWCJ2K37OYdhe1c4+qLVJ8Z4tCtBMvmV5IHLA1xKI4U+XyNhoT76O8Lj+LTpi/EVDmcaTLx30VuE0he5VVPanhhqEXZvUflFkNbNZJC9OldBzUKc7kGLAp1QrkBT3KPJX+LCdaZ6geeYfwOOFVRUyIq5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YqgVx54B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713819312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NIMZzutzj5URGu2VjD1bhrmGI/gglErZUqfLIOoWVfY=;
	b=YqgVx54BdBPyYLjv8XFR/tlXmR3Dz9FIhVDLB8qXxRVVDkQ1pkCprlVt0TOFf/KTD8ivLs
	GuGpv2DZBU4NIGqvyldhyeK01Tja/bXbplFCAesRVpCFDzqYpqE4Y8YBbMz0NnSkpY9Qna
	2yPRSAK8h5pUctUS0xDgw6cvWx/Fl+8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-BIeMeAmmPs6m_xxXDAPJsw-1; Mon, 22 Apr 2024 16:55:10 -0400
X-MC-Unique: BIeMeAmmPs6m_xxXDAPJsw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-41a1eb33994so6162965e9.1
        for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 13:55:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713819309; x=1714424109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NIMZzutzj5URGu2VjD1bhrmGI/gglErZUqfLIOoWVfY=;
        b=kD0vBMNYul6QB+/8jxC48dgRbFz5ARv6dY/ShQG55uv8VHQ+tG/yvN8UFv32VPm1VH
         RIY5mrA/kWpwhTdZRrloFP3wnbnxlUe9X2QVi3wFJX5tFpCCyaaaoSLDqVQIXnh+bccj
         oCZdWeDOG/xqLKhFlOnR7nIqqwEumX3Lv6wXeZRm4XqjUtxWhsuu13Ejusn9HOeZIjaE
         yLNYlekz2+LuQ4MkXGcI+qZEnvFGnNRz7MxnxkpINDWKSr7UCPgYj6XA4lqjgAnHxSO6
         /NMX8Uc/V6ubd/22R7JiaHGF6Hb9X3qKPGmrDzCnhTd+MqCxUPkwrJTUQMU3sunV5cYg
         567w==
X-Gm-Message-State: AOJu0YzabGZmeN2X6QS/8p1N+WTkanM+1CmprSxr8r63Q93XzKdv2BDk
	h/L323BMZ7TqTO1tz1UbVn4/xr1SC1ZwJ7DcTxtEzjyudkyfu70WdRQgM6+8YcUftYdbpibQcsW
	8DDV0e376VEGrQaB8pWsgXmfc0++nt/jdcwB6xDmW+QY5X9o2kQakZw==
X-Received: by 2002:a05:600c:1c1c:b0:419:ea21:2d83 with SMTP id j28-20020a05600c1c1c00b00419ea212d83mr7428168wms.0.1713819308937;
        Mon, 22 Apr 2024 13:55:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpNSfsyjNS+1cIbZ2IqGyPSbY18hXu6dedSNGqEbkI9BXf4Gw8EwTjzkQX4Y3Oxp7OeMckzg==
X-Received: by 2002:a05:600c:1c1c:b0:419:ea21:2d83 with SMTP id j28-20020a05600c1c1c00b00419ea212d83mr7428147wms.0.1713819308421;
        Mon, 22 Apr 2024 13:55:08 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7429:3c00:dc4a:cd5:7b1c:f7c2])
        by smtp.gmail.com with ESMTPSA id n33-20020a05600c502100b0041a652a501fsm3976008wmr.13.2024.04.22.13.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 13:55:07 -0700 (PDT)
Date: Mon, 22 Apr 2024 16:55:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>, Brett Creeley <bcreeley@amd.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH RESEND net-next v7 0/4] ethtool: provide the dim profile
 fine-tuning channel
Message-ID: <20240422165456-mutt-send-email-mst@kernel.org>
References: <20240415133807.116394-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415133807.116394-1-hengqi@linux.alibaba.com>

On Mon, Apr 15, 2024 at 09:38:03PM +0800, Heng Qi wrote:
> The NetDIM library provides excellent acceleration for many modern
> network cards. However, the default profiles of DIM limits its maximum
> capabilities for different NICs, so providing a way which the NIC can
> be custom configured is necessary.
> 
> Currently, interaction with the driver is still based on the commonly
> used "ethtool -C".
> 
> Since the profile now exists in netdevice, adding a function similar
> to net_dim_get_rx_moderation_dev() with netdevice as argument is
> nice, but this would be better along with cleaning up the rest of
> the drivers, which we can get to very soon after this set.
> 
> Please review, thank you very much!


Acked-by: Michael S. Tsirkin <mst@redhat.com>

> Changelog
> =====
> v6->v7:
>   - A new wrapper struct pointer is used in struct net_device.
>   - Add IS_ENABLED(CONFIG_DIMLIB) to avoid compiler warnings.
>   - Profile fields changed from u16 to u32.
> 
> v5->v6:
>   - Place the profile in netdevice to bypass the driver.
>     The interaction code of ethtool <-> kernel has not changed at all,
>     only the interaction part of kernel <-> driver has changed.
> 
> v4->v5:
>   - Update some snippets from Kuba, Thanks.
> 
> v3->v4:
>   - Some tiny updates and patch 1 only add a new comment.
> 
> v2->v3:
>   - Break up the attributes to avoid the use of raw c structs.
>   - Use per-device profile instead of global profile in the driver.
> 
> v1->v2:
>   - Use ethtool tool instead of net-sysfs
> 
> Heng Qi (4):
>   linux/dim: move useful macros to .h file
>   ethtool: provide customized dim profile management
>   virtio-net: refactor dim initialization/destruction
>   virtio-net: support dim profile fine-tuning
> 
> Heng Qi (4):
>   linux/dim: move useful macros to .h file
>   ethtool: provide customized dim profile management
>   virtio-net: refactor dim initialization/destruction
>   virtio-net: support dim profile fine-tuning
> 
>  Documentation/netlink/specs/ethtool.yaml     |  33 +++
>  Documentation/networking/ethtool-netlink.rst |   8 +
>  drivers/net/virtio_net.c                     |  46 +++--
>  include/linux/dim.h                          |  13 ++
>  include/linux/ethtool.h                      |  11 +-
>  include/linux/netdevice.h                    |  24 +++
>  include/uapi/linux/ethtool_netlink.h         |  24 +++
>  lib/dim/net_dim.c                            |  10 +-
>  net/core/dev.c                               |  83 ++++++++
>  net/ethtool/coalesce.c                       | 201 ++++++++++++++++++-
>  10 files changed, 430 insertions(+), 23 deletions(-)
> 
> -- 
> 2.32.0.3.g01195cf9f


