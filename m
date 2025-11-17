Return-Path: <netdev+bounces-239068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B36CC636CE
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 11:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A0D704EEBA8
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 10:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F2A328618;
	Mon, 17 Nov 2025 10:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h1/Zi+0O";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="g1QOUBc3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA3D32860A
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 10:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763373787; cv=none; b=erir/AjPSOtP7MPVuVulEv5jZbUtC1DPRpYx1LvxZyxxof0O4Pu6bZtvN3KvQPQu5RpZ55/FaKQKbTtuL5U3R5bCFaLwv4Ou8Pvnfu0GtbtjyNZ6nwx5jp8/Vl5aiVnZ0FQP6ASe3f5qrWLg2ArNVyRxwfLDaW7QLvMtr3PkMTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763373787; c=relaxed/simple;
	bh=Jjg4Iyd/07DTsm5qkOr6BIQlspwf+2NqiRbHnRlshMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LyyA3qJLrET8de0oWyEwpyQvHoKtU3WRauxXhjkFlAaBziQl0Dckt1w6yPBK+Hp1QAY2xStIqfbRipZAhUQmr0zXFEkyBJFzrTt8k0LQjkfaGcXc0brKZXvxzUrYfdpgM7WB63APKgvdSsTXeBLwA7sSyeugZ4AqH/KzU3bUijc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h1/Zi+0O; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=g1QOUBc3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763373783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9OoW97iXrHDq8mXDdV4L+0O0Y0xQp8TMPGSKNutW8hk=;
	b=h1/Zi+0OTvSk40ZUokYkayI6cK20XupbHnTiTLWYbGnOqnTOI5UYk63Pf1Rpb/+6zwNegL
	w2plvM/M+/hOJWiY66a5MbXKKEf5w7yEBAXY4aax0gOG8bOl0WEmkwLPNz8P1gecuvlUlL
	Q/tY1CQ9qlD2gJ+TC6uHA/s5fx9V3kM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-6oE2parvOR2f5PtpAQ3k8Q-1; Mon, 17 Nov 2025 05:03:02 -0500
X-MC-Unique: 6oE2parvOR2f5PtpAQ3k8Q-1
X-Mimecast-MFC-AGG-ID: 6oE2parvOR2f5PtpAQ3k8Q_1763373781
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4779393221aso13853215e9.2
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 02:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763373781; x=1763978581; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9OoW97iXrHDq8mXDdV4L+0O0Y0xQp8TMPGSKNutW8hk=;
        b=g1QOUBc3V4moGJym0Gnut9FJ2IZqAwsxKd7fRZI0kcl8Oha0Bpii3wKoEWrlndiLt0
         LO2/X3ws/FFfeMAbc7lPW8vn2VzmnXp6KfrhwaQOrDBQaKKoaRJZESkCjTNgW1ItW/MS
         Q32F2OTziuZGmAU+TrnArni/w/SwI4m0IxXz4HCb4TlmD4Ua+nLzbofH8jIe3SZDVAwK
         XrOSkQ3iExlHK7y4hzZ16ay3AiFu3eDT6KyI0uqUBmn0GdDqGE+SjACvTAIAFt60ioR7
         TTVxtpHK7gLaYuD1qQHNcgICCkdkvTg5gNTnwHF4fcOWV77ws9v0qU5p8Enbw6zl4LIx
         j6RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763373781; x=1763978581;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9OoW97iXrHDq8mXDdV4L+0O0Y0xQp8TMPGSKNutW8hk=;
        b=uvljVT8xW29S6kWAqPJmaptaeF+Er+ztPt+mFaYwBLDQFbGk5b/XYxUZTZhHUIZSMO
         QY/yAti8hCHxx/KkKX8YkB5/KOrcaorMHw39vdahLZXy6QB33Jprj8CTzE/9a7/WRO0I
         6xnTm53+i9r2FtGxhyxawoOUpS7XB7xI+SbjIFP3AwnrAgI6raD9++zx/wd/fZcUs+Cf
         9WqNfcoNMiPKIXZpqPH4EUa/3xKYYaFtXNKcVm6XJnYPULvQB+3wUfNyV3E2BCgb2IPW
         G10W2ZbhW8aUt5k7ukuxFFlV7ZeGj+4TkmHE67OpRbfsJjo7HAK6Rx8fxUWsG8cgdzDP
         116g==
X-Gm-Message-State: AOJu0YxQuo2vM/Em2YEgjCvlqJlMZ1GBL3xqqnMb3+BzPSmyFtxEEDFc
	DtKyjMRKF1sNHl/LDYUbDLtVN3R1n+qpgPsUYeu2jDFKMTXtzqPCW5sLlc/GpDuHVtzuK7zMYls
	wVY/0IMxkxREK105DnYrfYXL0qyJxHmQKGMIrOscK19bvcetH5suoPRARuw==
X-Gm-Gg: ASbGncsoadrp7BHLTuAMYUBBf3B8GKc+wv79Hob0KP/xvAjBI1xpniz3GZaizW9x0Hw
	ur9PNxBp1r541Dg6gw2nzAeIs0vEiw/ANPHQm7dFY0hHyHkFgFF87mTrpDVITpJN1B2ra4NYKDI
	qcKmMM9lT6zIVjnjguB32QMuxBMzVsXuLj8wIN2FWPvNa1tqc301TlOfurxuK4cmZ93elL+gd+m
	syzn0L0jbcDNfEtLY19r1bVIpTDaDc5LechwhcvxBN1bbb8wJ44PVtDvPf88/H8edNTAXSu9FEO
	fHIHhpdXOocVO2gfYRwU+mvEBupo2RDLSf81fHXCtOUy5M6jTh5bL6BhsnYBZ2dfREE7kb8tLp+
	j7HiV8xFqt1xzdQ08agI=
X-Received: by 2002:a05:600c:3baa:b0:477:54b3:3484 with SMTP id 5b1f17b1804b1-4778febd2eamr102341645e9.37.1763373780646;
        Mon, 17 Nov 2025 02:03:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsCVRVH8yi3mxQpF+a3sceLn+huBmPLQphd4cPau/Xd1zOyTQvr9xQ1+/sl1GzpkLtclk+xQ==
X-Received: by 2002:a05:600c:3baa:b0:477:54b3:3484 with SMTP id 5b1f17b1804b1-4778febd2eamr102341085e9.37.1763373779845;
        Mon, 17 Nov 2025 02:02:59 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f0b8d6sm26300205f8f.28.2025.11.17.02.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 02:02:59 -0800 (PST)
Date: Mon, 17 Nov 2025 05:02:56 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com,
	jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v10 00/12] virtio_net: Add ethtool flow rules
 support
Message-ID: <20251117050228-mutt-send-email-mst@kernel.org>
References: <20251112193132.1909-1-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112193132.1909-1-danielj@nvidia.com>

On Wed, Nov 12, 2025 at 01:31:20PM -0600, Daniel Jurgens wrote:
> This series implements ethtool flow rules support for virtio_net using the
> virtio flow filter (FF) specification. The implementation allows users to
> configure packet filtering rules through ethtool commands, directing
> packets to specific receive queues, or dropping them based on various
> header fields.

Bad threading here Daniel, so tools that rely on threading break.


> The series starts with infrastructure changes to expose virtio PCI admin
> capabilities and object management APIs. It then creates the virtio_net
> directory structure and implements the flow filter functionality with support
> for:
> 
> - Layer 2 (Ethernet) flow rules
> - IPv4 and IPv6 flow rules  
> - TCP and UDP flow rules (both IPv4 and IPv6)
> - Rule querying and management operations
> 
> Setting, deleting and viewing flow filters, -1 action is drop, positive
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
> ---
> v2: https://lore.kernel.org/netdev/20250908164046.25051-1-danielj@nvidia.com/
>   - Fix sparse warnings
>   - Fix memory leak on subsequent failure to allocate
>   - Fix some Typos
> 
> v3: https://lore.kernel.org/netdev/20250923141920.283862-1-danielj@nvidia.com/
>   - Added admin_ops to virtio_device kdoc.
> 
> v4:
>   - Fixed double free bug inserting flows
>   - Fixed incorrect protocol field check parsing ip4 headers.
>   - (u8 *) changed to (void *)
>   - Added kdoc comments to UAPI changes.
>   - No longer split up virtio_net.c
>   - Added config op to execute admin commands.
>       - virtio_pci assigns vp_modern_admin_cmd_exec to this callback.
>   - Moved admin command API to new core file virtio_admin_commands.c
> 
> v5: 
>   - Fixed compile error
>   - Fixed static analysis warning on () after macro
>   - Added missing fields to kdoc comments
>   - Aligned parameter name between prototype and kdoc
> 
> v6:
>   - Fix sparse warning "array of flexible structures" Jakub K/Simon H
>   - Use new variable and validate ff_mask_size before set_cap. MST
> 
> v7:
>   - Change virtnet_ff_init to return a value. Allow -EOPNOTSUPP. Xuan
>   - Set ff->ff_{caps, mask, actions} NULL in error path. Paolo Abini
>   - Move for (int i removal hung back a patch. Paolo Abini
> 
> v8
>   - Removed unused num_classifiers. Jason Wang
>   - Use real_ff_mask_size when setting the selector caps. Jason Wang
> 
> v9:
>   - Set err to -ENOMEM after alloc failures in virtnet_ff_init. Simon H
> 
> v10:
>   - Return -EOPNOTSUPP in virnet_ff_init before allocing any memory.
>     Jason Wang/Paolo Abeni
> 
> 
> Daniel Jurgens (12):
>   virtio_pci: Remove supported_cap size build assert
>   virtio: Add config_op for admin commands
>   virtio: Expose generic device capability operations
>   virtio: Expose object create and destroy API
>   virtio_net: Query and set flow filter caps
>   virtio_net: Create a FF group for ethtool steering
>   virtio_net: Implement layer 2 ethtool flow rules
>   virtio_net: Use existing classifier if possible
>   virtio_net: Implement IPv4 ethtool flow rules
>   virtio_net: Add support for IPv6 ethtool steering
>   virtio_net: Add support for TCP and UDP ethtool rules
>   virtio_net: Add get ethtool flow rules ops
> 
>  drivers/net/virtio_net.c               | 1147 ++++++++++++++++++++++++
>  drivers/virtio/Makefile                |    2 +-
>  drivers/virtio/virtio_admin_commands.c |  165 ++++
>  drivers/virtio/virtio_pci_common.h     |    1 -
>  drivers/virtio/virtio_pci_modern.c     |   10 +-
>  include/linux/virtio_admin.h           |  125 +++
>  include/linux/virtio_config.h          |    6 +
>  include/uapi/linux/virtio_net_ff.h     |  156 ++++
>  include/uapi/linux/virtio_pci.h        |    7 +-
>  9 files changed, 1608 insertions(+), 11 deletions(-)
>  create mode 100644 drivers/virtio/virtio_admin_commands.c
>  create mode 100644 include/linux/virtio_admin.h
>  create mode 100644 include/uapi/linux/virtio_net_ff.h
> 
> -- 
> 2.50.1


