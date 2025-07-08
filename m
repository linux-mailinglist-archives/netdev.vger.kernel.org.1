Return-Path: <netdev+bounces-205029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92899AFCE7A
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 17:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A6FE7B0E45
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 15:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A183B2E06D2;
	Tue,  8 Jul 2025 15:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RprVePQt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D861D22127E
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 15:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751986904; cv=none; b=HrpzsOy2sKftQbpQprVph0fsRK1zM53hyJZDg4Psue1+wmhu4mkPqL1UBHKihKuaQnu1WZYJhI5dx5N7DkaT5K2FuxT0r/DsaeYLn7N1tM5ArCzyJeYQ3W9lPrcc6kZDbCWBwyT8GIu/fi58LgOGiDQCbnS1BOpB4j6JuL3pRng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751986904; c=relaxed/simple;
	bh=C6ZZomLbi/zOPxZHt0dlelhB1jqalIFhjULGiIqUaXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVYO9ucjsDSQqesyrkNEKSE9bbq9UbcP62eL74OeEt5VUjJ66Ug6KObto2grrbWPM0QWHkDh4mp1DixpriooNiNIzFL67voVwOS2m7lg23tEAzr0Mi1zi2EVQTcD95qMZ+IVpxQSzVHsAwyM9Q57QktX+pecbOGMDl3wasn+85I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RprVePQt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751986901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1rNCOAezgrJfdzw+4fMxXtTnmKKIBw8LaqwRGLVMi54=;
	b=RprVePQtPqf7bA136x8hmpT8ONGFeANQiLdEuc2fStBAVsvYQ/2+cWTi50Z/9Vr1jtmKml
	k5mIB/ZJXbQnFhqbSNc7x92MLFURRk9wY8O4sHq/xYbm3Lp4OLwPcFYBzoWGmZK+O+rU19
	vKtKyZPTAsruH8Rn+mW76Hyu1GOSA/Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-iQJ23OoHM965MgPQgGsLDg-1; Tue, 08 Jul 2025 11:01:38 -0400
X-MC-Unique: iQJ23OoHM965MgPQgGsLDg-1
X-Mimecast-MFC-AGG-ID: iQJ23OoHM965MgPQgGsLDg_1751986897
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-450d244bfabso34960425e9.0
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 08:01:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751986897; x=1752591697;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1rNCOAezgrJfdzw+4fMxXtTnmKKIBw8LaqwRGLVMi54=;
        b=sCS/1v7GS++K5CMYk/tZ0WVHtkD4uVR242/woqYa9QDWHLNrlUVTiLIiUn4dS8I+os
         VQ6jfQykpZPK1GH+eTAF++Ufs8NAf1bQlfTwNJ+hKImJEkOkSoTB43H+dhebwmoZtvLx
         /MacbcYGM5jZD96wcNrdi9iCiJ4d0HgUM9dCAG+hcGrxqDP+ONpIjFoBzSM6fvoFi+zk
         XbaT/Fo/c7pDwaM6ooTzs2W+ZvNYtwNTpoaOcXGUkrBIel1tEsmG777cpicVwQhQCxH5
         wGZnGpcwJ5KmBnn0ig2AqoDYF7svJ0Nw4u1baYZILP64SlggkvllctCjxbGDOCatT9lX
         VEMw==
X-Gm-Message-State: AOJu0YxYgV3/aqtEO4huhCYvAD+blebePVGF6o9LTQoM9ienydH/rrQ0
	SMuVbvE28JOgDqX4nyh9ekPNsugjBw/1879WHyxShigL2dAbSTJhh35LJ7E6G32BHMqqKq1QYzX
	kMysYQrHWuFq77l1pMHxEDblnTcJXYCUP5CK/FYGSQtzQLmI70mX86JiWjQ==
X-Gm-Gg: ASbGnctAO7Rq7emc9ZjbLg1ONtXot3t7a40n4vkaAldJqwyzKGTZ/9DKfNo/539eaks
	EH68iUp4kQ3vgWlREZUPLQxx1ejTUaGv8VV3H1Y9QddyzX4FmQNswxPCujNzGByBawAT2ImD95h
	pp2V26IFbiUeqf7IKZ0tPzraRXwpeoItsmfEqfZGDNFIBHkCmDAxT73GynqwgU/k8DDbtgvQiiZ
	Z5WSgmZyMijWLcXhryzlbY5DjAsJ6VBVVdpbQkrW0bfQSZEqE24nsOSCG+vnoBBe0foVMX7JvP1
	WJMsAwYvoUwxAec=
X-Received: by 2002:a05:600c:6383:b0:453:8ab5:17f3 with SMTP id 5b1f17b1804b1-454b4ead145mr122676225e9.22.1751986896182;
        Tue, 08 Jul 2025 08:01:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH11Di0CyvGlev4/a65feEHdNV/ENPEJm11VdcvI7y7M2fvSKYNq+cP94W4DlaA+5SIMpmc9A==
X-Received: by 2002:a05:600c:6383:b0:453:8ab5:17f3 with SMTP id 5b1f17b1804b1-454b4ead145mr122674135e9.22.1751986893844;
        Tue, 08 Jul 2025 08:01:33 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47030b9desm13389956f8f.19.2025.07.08.08.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 08:01:33 -0700 (PDT)
Date: Tue, 8 Jul 2025 11:01:30 -0400
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
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Akihiko Odaki <akihiko.odaki@daynix.com>,
	Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 net-next 0/9] virtio: introduce GSO over UDP tunnel
Message-ID: <20250708105816-mutt-send-email-mst@kernel.org>
References: <cover.1751874094.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1751874094.git.pabeni@redhat.com>

On Tue, Jul 08, 2025 at 09:08:56AM +0200, Paolo Abeni wrote:
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
> feature support to cope with up to 128 bits. The limit is set by
> a define and could be easily raised in future, as needed.
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
> New helpers are introduced to convert the UDP-tunneled skb metadata to
> an extended virtio net header and vice versa. Such helpers are used by
> the tun and virtio_net driver to cope with the newly supported offloads.
> 
> Tested with basic stream transfer with all the possible permutations of
> host kernel/qemu/guest kernel with/without GSO over UDP tunnel support.
> ---
> WRT the merge plan, this is also are available in the Git repository at
> [1]:
> 
> git@github.com:pabeni/linux-devel.git virtio_udp_tunnel_07_07_2025
> 
> The first 5 patches in this series, that is, the virtio features
> extension bits are also available at [2]:
> 
> git@github.com:pabeni/linux-devel.git virtio_features_extension_07_07_2025
> 
> Ideally the virtio features extension bit should go via the virtio tree
> and the virtio_net/tun patches via the net-next tree. The latter have
> a dependency in the first and will cause conflicts if merged via the
> virtio tree, both when applied and at merge window time - inside Linus
> tree.
> 
> To avoid such conflicts and duplicate commits I think the net-next
> could pull from [1], while the virtio tree could pull from [2].

Or I could just merge all of this in my tree, if that's ok
with others?

Willem/Jason ok with you?





> ---
> v6 -> v7:
>   - avoid warning in csky build
>   - rebased
> v6: https://lore.kernel.org/netdev/cover.1750753211.git.pabeni@redhat.com/
> 
> v5 -> v6:
>   - fix integer overflow in patch 4/9
> v5: https://lore.kernel.org/netdev/cover.1750436464.git.pabeni@redhat.com/
> 
> v4 -> v5:
>   - added new patch 1/9 to avoid kdoc issues
>   - encapsulate guest features guessing in new tap helper
>   - cleaned-up SET_FEATURES_ARRAY
>   - a few checkpatch fixes
> v4: https://lore.kernel.org/netdev/cover.1750176076.git.pabeni@redhat.com/
> 
> v3 -> v4:
>   - vnet sockopt cleanup
>   - fixed offset for UDP-tunnel related field
>   - use dev->features instead of flags
> v3: https://lore.kernel.org/netdev/cover.1749210083.git.pabeni@redhat.com/
> 
> v2 -> v3:
>   - uint128_t -> u64[2]
>   - dropped related ifdef
>   - define and use vnet_hdr with tunnel layouts
> v2: https://lore.kernel.org/netdev/cover.1748614223.git.pabeni@redhat.com/
> 
> v1 -> v2:
>   - fix build failures
>   - many comment clarification
>   - changed the vhost_net ioctl API
>   - fixed some hdr <> skb helper bugs
> v1: https://lore.kernel.org/netdev/cover.1747822866.git.pabeni@redhat.com/
> 
> Paolo Abeni (9):
>   scripts/kernel_doc.py: properly handle VIRTIO_DECLARE_FEATURES
>   virtio: introduce extended features
>   virtio_pci_modern: allow configuring extended features
>   vhost-net: allow configuring extended features
>   virtio_net: add supports for extended offloads
>   net: implement virtio helpers to handle UDP GSO tunneling.
>   virtio_net: enable gso over UDP tunnel support.
>   tun: enable gso over UDP tunnel support.
>   vhost/net: enable gso over UDP tunnel support.
> 
>  drivers/net/tun.c                      |  58 ++++++--
>  drivers/net/tun_vnet.h                 | 101 +++++++++++--
>  drivers/net/virtio_net.c               | 110 +++++++++++---
>  drivers/vhost/net.c                    |  95 +++++++++---
>  drivers/vhost/vhost.c                  |   2 +-
>  drivers/vhost/vhost.h                  |   4 +-
>  drivers/virtio/virtio.c                |  43 +++---
>  drivers/virtio/virtio_debug.c          |  27 ++--
>  drivers/virtio/virtio_pci_modern.c     |  10 +-
>  drivers/virtio/virtio_pci_modern_dev.c |  69 +++++----
>  include/linux/virtio.h                 |   9 +-
>  include/linux/virtio_config.h          |  43 +++---
>  include/linux/virtio_features.h        |  88 +++++++++++
>  include/linux/virtio_net.h             | 197 ++++++++++++++++++++++++-
>  include/linux/virtio_pci_modern.h      |  43 +++++-
>  include/uapi/linux/if_tun.h            |   9 ++
>  include/uapi/linux/vhost.h             |   7 +
>  include/uapi/linux/vhost_types.h       |   5 +
>  include/uapi/linux/virtio_net.h        |  33 +++++
>  scripts/lib/kdoc/kdoc_parser.py        |   1 +
>  20 files changed, 790 insertions(+), 164 deletions(-)
>  create mode 100644 include/linux/virtio_features.h
> 
> -- 
> 2.49.0


