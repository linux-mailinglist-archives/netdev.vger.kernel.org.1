Return-Path: <netdev+bounces-226539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0855BA1853
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 23:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68F761C20D7C
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 21:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB98277818;
	Thu, 25 Sep 2025 21:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U74BqQrk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27812E6CBE
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 21:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758835164; cv=none; b=jQyr6jV5T17cFHXYJYhQm4WgdvDjBE9cs1vdIN+YerVF1Zmd1Pr/t2AwAn6UJlJYBelf9E99uQPkxo0NkTVcvAzt+ymAoUu4e2mJjuO636pMwznjoamqJuLx8whYSTTyzQMZ5zBZpdtrq2urcU68+GrdpZqCxYdAG5CBtIPEqV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758835164; c=relaxed/simple;
	bh=zjFx9117l39A4vOTTnDLIMm/8H5D3mIi8yTZGob+8C4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cukTTyyXu6NYO71SUokkfANYaOAZ0WXOS/xS63xAXZVZgQ6s76jBB+MuaCbzuagsuyi9GmvGTdNQPqr3AfNQffIbgDNO1JZgN+3I+wvoJmKk9fKgsVfkQtidpAyB5I+XxP5ktIMw7XNm2QJVehWUTvcN/O4YFLxgTkb2/ZEiyt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U74BqQrk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758835160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=spQeOOTFPyEeu2h1tbBdRDU1K8uKLDHL8VB189R02sk=;
	b=U74BqQrk7UQYj1WOFY2FwmXSkHDkEIssp1TSMe2lFilpHtD3+zNpHh0fsAHu5v/2erMaoJ
	A4wkUNN0q0uKb31MT13ezzhcFKsNxfk1VyvylhhFfy85v39mlswEzdiNDACU1MkNe1yLXU
	mBKfjwHiIYZBZJ6O/CbV/gE8ET7Zjrc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-lQFvP83XPOmez_pDm1QKhw-1; Thu, 25 Sep 2025 17:19:17 -0400
X-MC-Unique: lQFvP83XPOmez_pDm1QKhw-1
X-Mimecast-MFC-AGG-ID: lQFvP83XPOmez_pDm1QKhw_1758835156
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-41066f050a4so573537f8f.1
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 14:19:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758835156; x=1759439956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=spQeOOTFPyEeu2h1tbBdRDU1K8uKLDHL8VB189R02sk=;
        b=tYKsDyWS2S9U14cIhP1WJ65xE0bHh1Tnc0iKJPg9/V5f7t/oC7Jq7cdcbmU4yJY9ji
         WkVUi6BKO3djUEKBPCBMe1HPZfeaPhAlKoM8iN2jBrutZuDXuH5ZWXBlGxGKjy3tQd4d
         NFv7UVbX65mjqQnWu8e4diY0CTcEd1I//RiCyyhkPrFLi/gLLPnE+kh/4DuXZ3hVTVGW
         wHOwHJP0xelXlQRDaGqTEU1Gt3lo49+Ms7K1l6ZFcHRoWm10ezWAlcw1ucYrqGKw9FA1
         4ocW/qNpR6AYu9biMNC/S6vuQeSOFWQwQne5w6hdMTJ97t01E842EKTkyFyoaiPvTzll
         EMxg==
X-Gm-Message-State: AOJu0Yx92/vjc7Tm0CZMXEHUEi0DOCoG1CDaDnuHw/QZoveJMMF1Uh9t
	Zf5pRIJlXvp7W/9aT8UEWegKRHbr8x+2ATxlPPqUoRI3zVlBxTSeWMBuqz8NFdghkSfIgoCMoW1
	K2EFpLTLnHNCL5TsYsOgBPEKCRwwQPRYArUo/NX6DX8hile2saugcYNya/w==
X-Gm-Gg: ASbGncunVpXpfHKXMiKiOcAdj+9fXkDx9tOfL3/PTA3APMy95GUxYGvLFcCS9hx+pY9
	l5okegAk1w3PcmK0rjyQul6o7VWDqj2O+7GwTUSjiG7nfffnH/2JDsq6WNxuqBGu+MIw7TmbTJJ
	Ww9PWVpffyOrBLYf3f5YIXOR//bdemkdBuBJTgnefyWAdbJJARHLQa8CwYjLVsRUfHVOw0lZ0kL
	+ggOqzGYJAsJfZTpf5JMB01qP6wwTG/e5xOUeBiCikM0CB2LYmgA7ql+qzCitW/NuNoG+6j+sY/
	IGYlcbq2Lbg1Sja0FpPwcO7fFqC0AyO3sg==
X-Received: by 2002:a05:6000:2507:b0:40b:c42e:fe39 with SMTP id ffacd0b85a97d-40e4ece625cmr4906435f8f.40.1758835156128;
        Thu, 25 Sep 2025 14:19:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnj4SMuw4upcu484HaL+BNgTuNhf2ZatiJq97ndUq/IzG5WhKojug19ivgk+en20R8S6e0Kg==
X-Received: by 2002:a05:6000:2507:b0:40b:c42e:fe39 with SMTP id ffacd0b85a97d-40e4ece625cmr4906422f8f.40.1758835155727;
        Thu, 25 Sep 2025 14:19:15 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1538:2200:56d4:5975:4ce3:246f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33bede39sm50301295e9.18.2025.09.25.14.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 14:19:15 -0700 (PDT)
Date: Thu, 25 Sep 2025 17:19:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, alex.williamson@redhat.com,
	pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com,
	jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v3 00/11] virtio_net: Add ethtool flow rules
 support
Message-ID: <20250925171744-mutt-send-email-mst@kernel.org>
References: <20250923141920.283862-1-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923141920.283862-1-danielj@nvidia.com>

On Tue, Sep 23, 2025 at 09:19:09AM -0500, Daniel Jurgens wrote:
> This series implements ethtool flow rules support for virtio_net using the
> virtio flow filter (FF) specification. The implementation allows users to
> configure packet filtering rules through ethtool commands, directing
> packets to specific receive queues, or dropping them based on various
> header fields.
> 
> The series starts with infrastructure changes to expose virtio PCI admin
> capabilities and object management APIs. It then creates the virtio_net
> directory structure and implements the flow filter functionality with support
> for:



ok i took a quick look as you asked

main things:


	1. I am not sure device output is validated sufficiently
	and can not cause all kind of overflows
	can be an issues esp for coco


	2. avoid u8* just to do pointer math. void* is better for this.



	

> - Layer 2 (Ethernet) flow rules
> - IPv4 and IPv6 flow rules  
> - TCP and UDP flow rules (both IPv4 and IPv6)
> - Rule querying and management operations
> 
> Setting, deleting and viewing flow filters, -1 action is drop, postive
> integers steer to that RQ:
> 
> $ ethtool -u ens9
> 4 RX rings available
> Total 0 rules
> 
> $ ethtool -U ens9 flow-type ether src 1c:34:da:4a:33:dd action 0
> Added rule with ID 0
> $ ethtool -U ens9 flow-type udp4 dst-port 5001 action 3
> Added rule with ID 1
> $ ethtool -U ens9 flow-type tcp6 src-ip fc00::2 dst-port 5001 action 2
> Added rule with ID 2
> $ ethtool -U ens9 flow-type ip4 src-ip 192.168.51.101 action 1
> Added rule with ID 3
> $ ethtool -U ens9 flow-type ip6 dst-ip fc00::1 action -1
> Added rule with ID 4
> $ ethtool -U ens9 flow-type ip6 src-ip fc00::2 action -1
> Added rule with ID 5
> $ ethtool -U ens9 delete 4
> $ ethtool -u ens9
> 4 RX rings available
> Total 5 rules
> 
> Filter: 0
>         Flow Type: Raw Ethernet
>         Src MAC addr: 1C:34:DA:4A:33:DD mask: 00:00:00:00:00:00
>         Dest MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
>         Ethertype: 0x0 mask: 0xFFFF
>         Action: Direct to queue 0
> 
> Filter: 1
>         Rule Type: UDP over IPv4
>         Src IP addr: 0.0.0.0 mask: 255.255.255.255
>         Dest IP addr: 0.0.0.0 mask: 255.255.255.255
>         TOS: 0x0 mask: 0xff
>         Src port: 0 mask: 0xffff
>         Dest port: 5001 mask: 0x0
>         Action: Direct to queue 3
> 
> Filter: 2
>         Rule Type: TCP over IPv6
>         Src IP addr: fc00::2 mask: ::
>         Dest IP addr: :: mask: ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff
>         Traffic Class: 0x0 mask: 0xff
>         Src port: 0 mask: 0xffff
>         Dest port: 5001 mask: 0x0
>         Action: Direct to queue 2
> 
> Filter: 3
>         Rule Type: Raw IPv4
>         Src IP addr: 192.168.51.101 mask: 0.0.0.0
>         Dest IP addr: 0.0.0.0 mask: 255.255.255.255
>         TOS: 0x0 mask: 0xff
>         Protocol: 0 mask: 0xff
>         L4 bytes: 0x0 mask: 0xffffffff
>         Action: Direct to queue 1
> 
> Filter: 5
>         Rule Type: Raw IPv6
>         Src IP addr: fc00::2 mask: ::
>         Dest IP addr: :: mask: ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff
>         Traffic Class: 0x0 mask: 0xff
>         Protocol: 0 mask: 0xff
>         L4 bytes: 0x0 mask: 0xffffffff
>         Action: Drop
> 
> v2:
>   - Fix sparse warnings
>   - Fix memory leak on subsequent failure to allocate
>   - Fix some Typos
> 
> v3:
>   - Rebased
> 	- Added back get|set_rxnfc to virtio_net
>   - Added admin_ops to virtio_device kdoc.
> 
> Daniel Jurgens (11):
>   virtio-pci: Expose generic device capability operations
>   virtio-pci: Expose object create and destroy API
>   virtio_net: Create virtio_net directory
>   virtio_net: Query and set flow filter caps
>   virtio_net: Create a FF group for ethtool steering
>   virtio_net: Implement layer 2 ethtool flow rules
>   virtio_net: Use existing classifier if possible
>   virtio_net: Implement IPv4 ethtool flow rules
>   virtio_net: Add support for IPv6 ethtool steering
>   virtio_net: Add support for TCP and UDP ethtool rules
>   virtio_net: Add get ethtool flow rules ops
> 
>  MAINTAINERS                                   |    2 +-
>  drivers/net/Makefile                          |    2 +-
>  drivers/net/virtio_net/Makefile               |    8 +
>  drivers/net/virtio_net/virtio_net_ff.c        | 1029 +++++++++++++++++
>  drivers/net/virtio_net/virtio_net_ff.h        |   42 +
>  .../virtio_net_main.c}                        |   46 +
>  drivers/vfio/pci/virtio/migrate.c             |    8 +-
>  drivers/virtio/virtio.c                       |  141 +++
>  drivers/virtio/virtio_pci_common.h            |    1 -
>  drivers/virtio/virtio_pci_modern.c            |  320 ++---
>  include/linux/virtio.h                        |   22 +
>  include/linux/virtio_admin.h                  |  101 ++
>  include/linux/virtio_pci_admin.h              |    7 +-
>  include/uapi/linux/virtio_net_ff.h            |   82 ++
>  include/uapi/linux/virtio_pci.h               |    7 +-
>  15 files changed, 1677 insertions(+), 141 deletions(-)
>  create mode 100644 drivers/net/virtio_net/Makefile
>  create mode 100644 drivers/net/virtio_net/virtio_net_ff.c
>  create mode 100644 drivers/net/virtio_net/virtio_net_ff.h
>  rename drivers/net/{virtio_net.c => virtio_net/virtio_net_main.c} (99%)
>  create mode 100644 include/linux/virtio_admin.h
>  create mode 100644 include/uapi/linux/virtio_net_ff.h
> 
> -- 
> 2.45.0


