Return-Path: <netdev+bounces-226538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4814BA180E
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 23:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07B79563E2B
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 21:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544572E7193;
	Thu, 25 Sep 2025 21:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QKU5CpTJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65DC275AE2
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 21:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758835066; cv=none; b=jZ0Yexv/wheqgFxct8730pUwO0r//P8rLuFahqOTqs9GxIJR/oJj8x873eKCsLCll5pH9WGbwHgllPKOnqtdWQJNZFIq3NW5sGiuMElqGJpghqOrTItitaZw2Ui4yO3UYFBtPweP60VRvge/UJuiG2cmOcSH22n+e0n5d/b+XOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758835066; c=relaxed/simple;
	bh=uMYvDDi76m0SjYLL/+X5HrviapVaV9pGIvPYvBnmmfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2/xhqmqC490ftBUmgFHbjD9cOJSUeSa3dxzfH3otvEzZui+3R9oX5PNjqE13PV67Z6uSz+omDkUguAeI4lx/Z2ikmmfHnr5YsOlaVUy+xWZLsUh4l8iuxn2SP+TQ0kb3a0bKmvhnMX9ouhOf1lAE++lOKvorU/mmm65eD8FUjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QKU5CpTJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758835063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=InMs270U7tNzmYsR7wyJORKxbY23YzNflcIxA8PlZo4=;
	b=QKU5CpTJ4wqjm55CvGh6qx20CKHzwBjGZk422pAC4Ewe1luxSU1gSFi0ymGgr2XAN/FXyE
	WA4dMRa9CJ9ODUFD00GQT8aeUPptQM56xSauB6YIgCTkz4llz7gasWbnncHn860/QjJITD
	pdY+/xc4F2sHeQxCoPH9I5tSgQIvQQA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-kGN4bGOqPl-YipPe_rx_-g-1; Thu, 25 Sep 2025 17:17:41 -0400
X-MC-Unique: kGN4bGOqPl-YipPe_rx_-g-1
X-Mimecast-MFC-AGG-ID: kGN4bGOqPl-YipPe_rx_-g_1758835059
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3f42b54d159so1044714f8f.2
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 14:17:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758835059; x=1759439859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=InMs270U7tNzmYsR7wyJORKxbY23YzNflcIxA8PlZo4=;
        b=bp+dSmXWU00l19Wme1NXP0Ad+HC92Bwznqbi/cBF+xoCXuQoRV2Sb9sgvktVmdo4CX
         ew+PMk9lr49SZlNbJkbJDhc/WMYe7j3iTYJR6wAQH8EGuywoifcg0E7TxKsP5q+8YeRD
         KnZerqrPxLtkwm7BapUrQWimATpAmbSbmG16y9huWyv3WhVuGVth6rUgIQ+JWhLC4Wiw
         03A0fT7gPumA5TEgzZ1/iD3dMdvrpoLGY0ZxoZwfqf9xJELbDOh8BnwYALi4Tmdr7c0l
         eqQgxfSTH4CPJLOpWKWciLvKfusnUI6inH9ICDuI+9fJyODdQ3jS+Iuy096qFRw3GpWL
         1rrg==
X-Gm-Message-State: AOJu0Yxc9uviecU2y1BpFz08k7eKLG9uHSvjyspGP+CUDgDIb5uTvieI
	HGbnqVmxYvh1jFO4r6iFmgIGihn1D35dx8S5IElUcgVjrFGJN/Tdv7fI8w/LYuFR4VbhiJ2LPD+
	NnFHH6j56oO06ejyMfpzE5kNwV9d0j0+coYcpXVwC843tPI5NZ4TmV/KA7g==
X-Gm-Gg: ASbGncvxQ8Gvx80C8wk56xwW+g5f4q+d4mxqA2rAm6eOnoNM8vd84+FELaIfripuruW
	l5TvKvCcTBhls5SvaXoygP6/0Z1LCGHrV7hLqnTqPtUdHDuO7fwhGI3u1TrCnPb0znrBFCdKXwh
	tV/O+/fZ3H+iE0PFj8Bl+UGluqou0SR9/msJkZM+SSiurTHztFP50CKw2RyEZdes8zF8VerTX/r
	TYsXt0AZOrsorC6gD6sWDysSoUFz9CRlJmLbc1qMY2xrt2N3S6UcZJxt4CKYsz0auhUqBCKOh61
	KBXVBiOmbtQQraGkYpUGD7QqIfZtRvVwFw==
X-Received: by 2002:a05:6000:2901:b0:3eb:60a6:3167 with SMTP id ffacd0b85a97d-40e4bb2f6c4mr4971946f8f.32.1758835059165;
        Thu, 25 Sep 2025 14:17:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyfQdBXXom1LNY4hzsZo9rtJMz+NF0dmBeIX72tlfFZXC2O/zmQ4r9tU2in2I61YuZlQYweQ==
X-Received: by 2002:a05:6000:2901:b0:3eb:60a6:3167 with SMTP id ffacd0b85a97d-40e4bb2f6c4mr4971932f8f.32.1758835058759;
        Thu, 25 Sep 2025 14:17:38 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1538:2200:56d4:5975:4ce3:246f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb72fbb27sm4235081f8f.4.2025.09.25.14.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 14:17:38 -0700 (PDT)
Date: Thu, 25 Sep 2025 17:17:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, alex.williamson@redhat.com,
	pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com,
	jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v3 03/11] virtio_net: Create virtio_net directory
Message-ID: <20250925171724-mutt-send-email-mst@kernel.org>
References: <20250923141920.283862-1-danielj@nvidia.com>
 <20250923141920.283862-4-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923141920.283862-4-danielj@nvidia.com>

On Tue, Sep 23, 2025 at 09:19:12AM -0500, Daniel Jurgens wrote:
> The flow filter implementaion 

implementation

>requires minimal changes to the
> existing virtio_net implementation. It's cleaner to separate it into
> another file. In order to do so, move virtio_net.c into the new
> virtio_net directory, and create a makefile for it. Note the name is
> changed to virtio_net_main.c, so the module can retain the name
> virtio_net.
> 
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
> ---
>  MAINTAINERS                                               | 2 +-
>  drivers/net/Makefile                                      | 2 +-
>  drivers/net/virtio_net/Makefile                           | 8 ++++++++
>  .../net/{virtio_net.c => virtio_net/virtio_net_main.c}    | 0
>  4 files changed, 10 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/net/virtio_net/Makefile
>  rename drivers/net/{virtio_net.c => virtio_net/virtio_net_main.c} (100%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a8a770714101..09d26c4225a9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -26685,7 +26685,7 @@ F:	Documentation/devicetree/bindings/virtio/
>  F:	Documentation/driver-api/virtio/
>  F:	drivers/block/virtio_blk.c
>  F:	drivers/crypto/virtio/
> -F:	drivers/net/virtio_net.c
> +F:	drivers/net/virtio_net/
>  F:	drivers/vdpa/
>  F:	drivers/virtio/
>  F:	include/linux/vdpa.h
> diff --git a/drivers/net/Makefile b/drivers/net/Makefile
> index 73bc63ecd65f..cf28992658a6 100644
> --- a/drivers/net/Makefile
> +++ b/drivers/net/Makefile
> @@ -33,7 +33,7 @@ obj-$(CONFIG_NET_TEAM) += team/
>  obj-$(CONFIG_TUN) += tun.o
>  obj-$(CONFIG_TAP) += tap.o
>  obj-$(CONFIG_VETH) += veth.o
> -obj-$(CONFIG_VIRTIO_NET) += virtio_net.o
> +obj-$(CONFIG_VIRTIO_NET) += virtio_net/
>  obj-$(CONFIG_VXLAN) += vxlan/
>  obj-$(CONFIG_GENEVE) += geneve.o
>  obj-$(CONFIG_BAREUDP) += bareudp.o
> diff --git a/drivers/net/virtio_net/Makefile b/drivers/net/virtio_net/Makefile
> new file mode 100644
> index 000000000000..c0a4725ddd69
> --- /dev/null
> +++ b/drivers/net/virtio_net/Makefile
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Makefile for the VirtIO Net driver
> +#
> +
> +obj-$(CONFIG_VIRTIO_NET) += virtio_net.o
> +
> +virtio_net-objs := virtio_net_main.o
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net/virtio_net_main.c
> similarity index 100%
> rename from drivers/net/virtio_net.c
> rename to drivers/net/virtio_net/virtio_net_main.c
> -- 
> 2.45.0


