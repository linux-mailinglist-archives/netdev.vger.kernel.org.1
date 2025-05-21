Return-Path: <netdev+bounces-192387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1814ABFAB7
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 18:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 750C91BA5B0D
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 16:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265B11EA7C2;
	Wed, 21 May 2025 15:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FkPI71Tj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA65202F7C
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 15:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747842741; cv=none; b=H01UnHpS3uPf4pE3tVsVSBdU0mxjWQF6B/IuHhJy/UTCmqVOC2nh1vmcAuHSIjkbGyy6drVgJINKhIisvLnnx4RTfoUv1BwYHtnDDhU1QQLUjTIvClH4SN52Y0/x6Z0r1sqAerHCViivi/Egj55rghnjbrThqVl7Dp0PfsgNs34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747842741; c=relaxed/simple;
	bh=KlGasrrfd/A34/av1ckJUHECAu6PJtOHLLeil9VsHKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W4EJzviTYykfJWiT8IhqmAcnjWt3C6Ir1jwBxef6zdgqlMXGiRR9Ib+hG5YkDJLz1ExNSLPpJrUpD7MmHWduDY3tN0bQH998fZG8K0qbpRcinYbY9GMXPsCIMkYV9kSnqzywRvyKfS7hv5HCbFD5IoQJS+Uk3ZbtZ+WSalXHR6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FkPI71Tj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747842736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=osM8CjkEWpsC/QW0iOeh7dIm/826OMA2mt8jWXZEcfg=;
	b=FkPI71TjOztnfSIk/FqttXErWThOeY1P2befA0exJqa4qwhv69beIqmboKP7SdzwfPEfuS
	5HlH/MVmHnPqf025cyyqJ0GxRRoEY+r2ILvj2BOWUqRPq2BM24c8Xzto79w7xsY+Fo1psn
	ICWqH7ofe6k0A70APr14EIiO07j19nA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-oiiUL4hhMSSBFh2YSWSjBg-1; Wed, 21 May 2025 11:52:15 -0400
X-MC-Unique: oiiUL4hhMSSBFh2YSWSjBg-1
X-Mimecast-MFC-AGG-ID: oiiUL4hhMSSBFh2YSWSjBg_1747842734
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43d0a037f97so41920535e9.2
        for <netdev@vger.kernel.org>; Wed, 21 May 2025 08:52:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747842734; x=1748447534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=osM8CjkEWpsC/QW0iOeh7dIm/826OMA2mt8jWXZEcfg=;
        b=SwQGPugLdienhjwfep23d0zXaiCsVSqELH/kMECqTxaXj4JA22ODImKmrsoDdpkouP
         oaAJkpirts7RDnm1c08S/bUXzEVPGqC+lKkJO8IEjxj43oA7Ya4j+9dnSMfp4x/1Wo7Z
         1QK2Fcl7YtNYddlu8AEH0C+mBVknOJTbbXmsptAhMdl+8w64chp0q6EDbhOzY3YvhEDS
         EmitfG2tFC4/fAUbars5f94GIl3/AMtxfE034DwSCxg7cVlrdKFjbDdXbF/bODEYZNHU
         GIrf/4jfm2qRPSiZdsoyPKt9vV1NM3KpTJAq+p0AosuGI/BBAJOpk/G5a3KvIpfOtOBX
         qEIA==
X-Gm-Message-State: AOJu0YyH03U7lS2m3XX62HTvSVN3KX3U4+rcZNk+aj91CIIKBRijCBXc
	O5Z6bITkQ2JZu33Nw9NlFq68HWxT2s7a0hQazEgtN5THpXP3VxlNO2nty5LLpIfFlRU8wiAfB/w
	U4QKjOy3R61bCiI0FSTLvXPyYUM5w8keO/U/cE/0Ndib0DCOibGqxtAvmmA==
X-Gm-Gg: ASbGncvDoI+kwHFglstVvXUMNmPvm9MHOnWSy4p1vpFjAuOlpRSnvZqAsm75qv2UkEx
	mA0kZBxbhnQQO0e2iGt+LyxD+FmnP+qerh19erHSsK7rofwlGHjkmPnk2En3J3WDz2eCVBzSnc+
	W03qcsfA75H4PZlmChe8IDJopI+blZ5nhIsjc4lHTVhNoZVdXbLwkh3Alin3E/godxQrNLJqCNM
	4QIQmciudFkQbSbSJIyj4NbwXrf/BlmeWsUWycuZ/KU2w/YZnJiUXvG/g22UVBQFRblAcHY/tz7
	eSWrlw==
X-Received: by 2002:a05:600c:a405:b0:43d:4e9:27ff with SMTP id 5b1f17b1804b1-442ffc60be5mr166863105e9.7.1747842733779;
        Wed, 21 May 2025 08:52:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEr8OyZyFInFy/ufLRJs3MMFU1ybD06u2rHw8qxtuEMOaZGWvDDOLploSK6B/z1ttZdRHJf1Q==
X-Received: by 2002:a05:600c:a405:b0:43d:4e9:27ff with SMTP id 5b1f17b1804b1-442ffc60be5mr166862845e9.7.1747842733386;
        Wed, 21 May 2025 08:52:13 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f3dd99absm72511415e9.37.2025.05.21.08.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 08:52:12 -0700 (PDT)
Date: Wed, 21 May 2025 11:52:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [PATCH net-next 0/8] virtio: introduce GSO over UDP tunnel
Message-ID: <20250521115146-mutt-send-email-mst@kernel.org>
References: <cover.1747822866.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1747822866.git.pabeni@redhat.com>

On Wed, May 21, 2025 at 12:32:34PM +0200, Paolo Abeni wrote:
> Some virtualized deployments use UDP tunnel pervasively and are impacted
> negatively by the lack of GSO support for such kind of traffic in the
> virtual NIC driver.
> 
> The virtio_net specification recently introduced support for GSO over
> UDP tunnel, this series updates the virtio implementation to support
> such a feature.
> 
> Currently the kernel virtio support limits the feature space to 64,
> while the virtio specification allows for a larger number of features.
> Specifically the GSO-over-UDP-tunnel-related virtio features use bits
> 65-69.
> 
> The first four patches in this series rework the virtio and vhost
> feature support to cope with up to 128 bits. The limit is arch-dependent:
> only arches with native 128 integer support allow for the wider feature
> space.
> 
> This implementation choice is aimed at keeping the code churn as
> limited as possible. For the same reason, only the virtio_net driver is
> reworked to leverage the extended feature space; all other
> virtio/vhost drivers are unaffected, but could be upgraded to support
> the extended features space in a later time.
> 
> The last four patches bring in the actual GSO over UDP tunnel support.
> As per specification, some additional fields are introduced into the
> virtio net header to support the new offload. The presence of such
> fields depends on the negotiated features.
> 
> A new pair of helpers is introduced to convert the UDP-tunneled skb
> metadata to an extended virtio net header and vice versa. Such helpers
> are used by the tun and virtio_net driver to cope with the newly
> supported offloads.
> 
> Tested with basic stream transfer with all the possible permutations of
> host kernel/qemu/guest kernel with/without GSO over UDP tunnel support.
> Sharing somewhat early to collect feedback, especially on the userland
> code.


I like the approach. Some small comments/questions.

> Paolo Abeni (8):
>   virtio: introduce virtio_features_t
>   virtio_pci_modern: allow setting configuring extended features
>   vhost-net: allow configuring extended features
>   virtio_net: add supports for extended offloads
>   net: implement virtio helpers to handle UDP GSO tunneling.
>   virtio_net: enable gso over UDP tunnel support.
>   tun: enable gso over UDP tunnel support.
>   vhost/net: enable gso over UDP tunnel support.
> 
>  drivers/net/tun.c                      |  77 +++++++++--
>  drivers/net/tun_vnet.h                 |  74 +++++++++--
>  drivers/net/virtio_net.c               |  99 ++++++++++++--
>  drivers/vhost/net.c                    |  32 ++++-
>  drivers/vhost/vhost.h                  |   2 +-
>  drivers/virtio/virtio.c                |  12 +-
>  drivers/virtio/virtio_mmio.c           |   4 +-
>  drivers/virtio/virtio_pci_legacy.c     |   2 +-
>  drivers/virtio/virtio_pci_modern.c     |   7 +-
>  drivers/virtio/virtio_pci_modern_dev.c |  44 +++---
>  drivers/virtio/virtio_vdpa.c           |   2 +-
>  include/linux/virtio.h                 |   5 +-
>  include/linux/virtio_config.h          |  22 +--
>  include/linux/virtio_features.h        |  23 ++++
>  include/linux/virtio_net.h             | 177 +++++++++++++++++++++++--
>  include/linux/virtio_pci_modern.h      |  11 +-
>  include/uapi/linux/if_tun.h            |   9 ++
>  include/uapi/linux/vhost.h             |   8 ++
>  include/uapi/linux/virtio_net.h        |  33 +++++
>  19 files changed, 551 insertions(+), 92 deletions(-)
>  create mode 100644 include/linux/virtio_features.h
> 
> -- 
> 2.49.0


