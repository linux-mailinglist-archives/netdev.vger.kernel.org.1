Return-Path: <netdev+bounces-198782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7E3ADDCC8
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 21:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBDCD3BC16E
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 19:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E51237180;
	Tue, 17 Jun 2025 19:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="evJqARll"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB502E54A6
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 19:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750190320; cv=none; b=iS8wc78X1V/6AAuBgfUKHlGOy6C0Cq4VZKMx3aW1vyirFe90tSC1RxDnsRG8sA3tSOvqzRADSxICfvxuC/KJjHKP/6LF4dHw7MSTM7IeyMbBz+hwmKsbHl2m440Z4fAtAIBYQL1mEgA0q5QkVTDziXYpHT+EyezA53muY8qGOwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750190320; c=relaxed/simple;
	bh=uZUfz3jrl2uXoQwplKBikm0b0xQ8M1NaG+opaoMntTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uE2VFOCysMaXYFStcJndzQNRBqAgfGa1HbeqmxYPi2qtLgytiPLeu/CHySxeg24ygHU/g21ccZSDrr3loAYLnFSiCe7r3inXoSfiHnq666pqSFKwH8E9ylgfjYZ5vliu8rxJpUiMyyKmTbsbWpCT6annyjpKLAPrFXwj7w7CbFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=evJqARll; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750190316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6tYmS3Kt98GBXA/uVS2jBbFETQ+vSX2zgjgxH3FpR44=;
	b=evJqARllFVrQX/0WCbaEqcuSTD3aD4965UCLrKbSJSfbSn6zSPx8bZ4hEIlFAqlb9Jcv5W
	Sgo73CFFQEIyxSSl7CNLbuW24ZfZQqZuyEOnTkreozRZ/GAglBSqYKYsJx/RlQMZ/ajmI7
	mdbFvj9JNgYGD9g7dREEp/2JkCXZcmg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-iGy_U4TLOzyBg3I_VEhhZQ-1; Tue, 17 Jun 2025 15:58:34 -0400
X-MC-Unique: iGy_U4TLOzyBg3I_VEhhZQ-1
X-Mimecast-MFC-AGG-ID: iGy_U4TLOzyBg3I_VEhhZQ_1750190314
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4f6ba526eso3619651f8f.1
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 12:58:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750190313; x=1750795113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6tYmS3Kt98GBXA/uVS2jBbFETQ+vSX2zgjgxH3FpR44=;
        b=Y6Ctk+7GyLH9byjTqC2lTKwBdnwovLEL+UQAy3kTd/7AiqirXu8csj7I+skqkkLbPk
         tu5npdFb1/kmq3A1AuG7DLwQy/mA6QFLKdT4K/0aq2npNwJ5nob/j5n1Xq2jmFypyCxX
         BXch00SvsOXyxNoaEJ2yNd/yyehfcGXuBfy4HPuWL/c6OZyTnkWdmOjQs8mlM9bZdo5q
         M9URCnCgT6Bwcec/cd7pK5AmoN1ZTZqkZ+x4/aB4kQEp/eqDEUsLB765quyehO/vyEvo
         7Okj+qERRRPvGukKfIznIiqOcxPCFHzLdSLatZQ84tbkiyGFpwsKOR4TKwXvTxhxYFNJ
         pBSg==
X-Gm-Message-State: AOJu0YyT+zUDkmFeGcqB06YWOTUov65ynau1kTmkmEhf56AW6OcYuaF8
	QevGl2M95xWo7cHGoola0YzsB7whD1/9n0S9ZGq7Ql/zXG1CSOL4oUID2wjxNaXZE9IiqAktny6
	KZFqCfrkp4gCx0zRLVvPhFla3p+nHzzh1MAeH5Zt7/Qgja8i1h3VRyEoR6wQi531Klw==
X-Gm-Gg: ASbGncsdjGWsMnu9+g1Wk3USyTAR+5j8DtL+G91Z6PjElBIyn3m6NoucVdTm8qjcRns
	XdBSI59Xyzt6NKee2FMRq6Mm+zVawkXoXicH0+l2yLM1tBLodjOYRcaZPRKzReILqCaGc+k+UNp
	/nrQtTj9y3Pn5nX5YJysSUbEIHWSJSpZMMv8p4NQqjyMtb3iDGIyvMNBz1JVx+MUHoUAFJOeb4j
	8N9dIgESYMBKOVve2ABNGc2mlR71N4JgdfPu7acjT590UTY1Npa4IvdzTN5gwAmPClI12BAP3s3
	i77T5KCAdx6ImAzl
X-Received: by 2002:a5d:6f01:0:b0:3a4:d8f8:fba7 with SMTP id ffacd0b85a97d-3a572367c78mr14203227f8f.2.1750190310500;
        Tue, 17 Jun 2025 12:58:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHc0ztYLHYN6AkscYteX+7X3/m8xilAVdMmTuRpqfOloqqkrdYbVRet+aVcHE0JaWVOL0YGw==
X-Received: by 2002:a5d:6f01:0:b0:3a4:d8f8:fba7 with SMTP id ffacd0b85a97d-3a572367c78mr14203135f8f.2.1750190307371;
        Tue, 17 Jun 2025 12:58:27 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:4300:f7cc:3f8:48e8:2142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b403b4sm14539012f8f.80.2025.06.17.12.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 12:58:26 -0700 (PDT)
Date: Tue, 17 Jun 2025 15:58:24 -0400
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
	Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Re: [PATCH v4 net-next 0/8] virtio: introduce GSO over UDP tunnel
Message-ID: <20250617155742-mutt-send-email-mst@kernel.org>
References: <cover.1750176076.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1750176076.git.pabeni@redhat.com>

On Tue, Jun 17, 2025 at 06:12:07PM +0200, Paolo Abeni wrote:
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
> 


Hi!
I'm out sick. Hope to get to this next week. Sorry about the delay.


> ---
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
> Paolo Abeni (8):
>   virtio: introduce extended features
>   virtio_pci_modern: allow configuring extended features
>   vhost-net: allow configuring extended features
>   virtio_net: add supports for extended offloads
>   net: implement virtio helpers to handle UDP GSO tunneling.
>   virtio_net: enable gso over UDP tunnel support.
>   tun: enable gso over UDP tunnel support.
>   vhost/net: enable gso over UDP tunnel support.
> 
>  drivers/net/tun.c                      |  70 +++++++--
>  drivers/net/tun_vnet.h                 |  88 +++++++++--
>  drivers/net/virtio_net.c               | 109 +++++++++++---
>  drivers/vhost/net.c                    |  95 +++++++++---
>  drivers/vhost/vhost.c                  |   2 +-
>  drivers/vhost/vhost.h                  |   4 +-
>  drivers/virtio/virtio.c                |  43 +++---
>  drivers/virtio/virtio_debug.c          |  27 ++--
>  drivers/virtio/virtio_pci_modern.c     |  10 +-
>  drivers/virtio/virtio_pci_modern_dev.c |  69 +++++----
>  include/linux/virtio.h                 |   5 +-
>  include/linux/virtio_config.h          |  41 +++---
>  include/linux/virtio_features.h        |  88 +++++++++++
>  include/linux/virtio_net.h             | 196 ++++++++++++++++++++++++-
>  include/linux/virtio_pci_modern.h      |  43 +++++-
>  include/uapi/linux/if_tun.h            |   9 ++
>  include/uapi/linux/vhost.h             |   7 +
>  include/uapi/linux/vhost_types.h       |   5 +
>  include/uapi/linux/virtio_net.h        |  33 +++++
>  19 files changed, 780 insertions(+), 164 deletions(-)
>  create mode 100644 include/linux/virtio_features.h
> 
> -- 
> 2.49.0


