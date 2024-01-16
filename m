Return-Path: <netdev+bounces-63749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB9E82F25E
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 17:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA7F0285BB6
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 16:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F93D1C6B6;
	Tue, 16 Jan 2024 16:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DpXHgey0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F6D1C6A8
	for <netdev@vger.kernel.org>; Tue, 16 Jan 2024 16:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705422516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=OF/f9SqDfQjcSElQnS0yY6s/dBYlZKzDcj9s0+Wh2f8=;
	b=DpXHgey0AfAHNExgYlU/kEGeY7tfz3NKmvSD7aVZMnrvVbuhsyuit4tEg1WmXyXXkLxcSh
	nqsSRDclrNKpyoelrIu4//1JIWMz/eEg1tXFQwID7Jqx2rT9lwGlpm3Pan5gLiVABaqCCQ
	k22zS10an4goLn3tcIr/2rbb6auA8bw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-0afhEgPsMUae5ke7QgHshg-1; Tue, 16 Jan 2024 11:28:33 -0500
X-MC-Unique: 0afhEgPsMUae5ke7QgHshg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40e863cb806so4132145e9.2
        for <netdev@vger.kernel.org>; Tue, 16 Jan 2024 08:28:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705422513; x=1706027313;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OF/f9SqDfQjcSElQnS0yY6s/dBYlZKzDcj9s0+Wh2f8=;
        b=chOq4nLobCYeOUL0C2/HBAVXKX28CT7RewaqyHrd9Cfuaz6uaUqW5N09g7Nd4Dk1gM
         Ia7K+/iml3mScmTWPbCn0aUXuh9ORaBf83dje8m2mlq7U4RNE5Rqp3x0ik9gHbWnbKVi
         9LSlUOOsUfY0AUrQd+LYqtF+Qc39R2G+n438tv1plmFo5nBdiWw7nfRXD9SD7G3Lv0DL
         2hHiIitxyAO6yzNtibuyGdkSBoUXKpM90ddUAtCBPGarx5CVVeNBIMLa4v2anrz3gWtf
         pxpy76i4YCEhsE2EUUfgXLfGdyhXsFDXVBWnfMpIhk6wqlueaBmeapCMuZIC+qF7TraR
         Occw==
X-Gm-Message-State: AOJu0YztN23dkNZaEJ99aIXdJcwYhsTBr+JpbEhc0zxR3h9d978bXOAS
	dlRVORV+tq3e5r/v5mn+OT7dUN43VpOPsB8p9wd21/b3PGvo9p8p+5hI7/XgJMu/EC0lvtjv0z7
	zqwIIIT/7PvSICaA52AsA3QrJ
X-Received: by 2002:a05:600c:257:b0:40e:7e40:10c6 with SMTP id 23-20020a05600c025700b0040e7e4010c6mr739597wmj.182.1705422512704;
        Tue, 16 Jan 2024 08:28:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4EwY4rnvc1dXkvUnzrtlQb0sW9f8GFlzYKtabODe5zsH9sA7U7cGUZRKyhXjVGQXqLCiWCQ==
X-Received: by 2002:a05:600c:257:b0:40e:7e40:10c6 with SMTP id 23-20020a05600c025700b0040e7e4010c6mr739594wmj.182.1705422512444;
        Tue, 16 Jan 2024 08:28:32 -0800 (PST)
Received: from redhat.com ([2.52.29.192])
        by smtp.gmail.com with ESMTPSA id bg42-20020a05600c3caa00b0040e3733a32bsm23560519wmb.41.2024.01.16.08.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 08:28:31 -0800 (PST)
Date: Tue, 16 Jan 2024 11:28:28 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	changyuanl@google.com, christophe.jaillet@wanadoo.fr,
	dtatulea@nvidia.com, eperezma@redhat.com, jasowang@redhat.com,
	michael.christie@oracle.com, mst@redhat.com,
	pasha.tatashin@soleen.com, rientjes@google.com,
	stevensd@chromium.org, tytso@mit.edu, xuanzhuo@linux.alibaba.com
Subject: [GIT PULL] virtio: features, fixes
Message-ID: <20240116112828-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent

The following changes since commit b8e0792449928943c15d1af9f63816911d139267:

  virtio_blk: fix snprintf truncation compiler warning (2023-12-04 09:43:53 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to f16d65124380ac6de8055c4a8e5373a1043bb09b:

  vdpa/mlx5: Add mkey leak detection (2024-01-10 13:01:38 -0500)

----------------------------------------------------------------
virtio: features, fixes

vdpa/mlx5: support for resumable vqs
virtio_scsi: mq_poll support
3virtio_pmem: support SHMEM_REGION
virtio_balloon: stay awake while adjusting balloon
virtio: support for no-reset virtio PCI PM

Fixes, cleanups.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Changyuan Lyu (1):
      virtio_pmem: support feature SHMEM_REGION

Christophe JAILLET (2):
      vdpa: Fix an error handling path in eni_vdpa_probe()
      vdpa: Remove usage of the deprecated ida_simple_xx() API

David Stevens (2):
      virtio: Add support for no-reset virtio PCI PM
      virtio_balloon: stay awake while adjusting balloon

Dragos Tatulea (10):
      vdpa: Track device suspended state
      vdpa: Block vq property changes in DRIVER_OK
      vdpa/mlx5: Expose resumable vq capability
      vdpa/mlx5: Allow modifying multiple vq fields in one modify command
      vdpa/mlx5: Introduce per vq and device resume
      vdpa/mlx5: Mark vq addrs for modification in hw vq
      vdpa/mlx5: Mark vq state for modification in hw vq
      vdpa/mlx5: Use vq suspend/resume during .set_map
      vdpa/mlx5: Introduce reference counting to mrs
      vdpa/mlx5: Add mkey leak detection

Mike Christie (1):
      scsi: virtio_scsi: Add mq_poll support

Pasha Tatashin (1):
      vhost-vdpa: account iommu allocations

Xuan Zhuo (1):
      virtio_net: fix missing dma unmap for resize

 drivers/net/virtio_net.c           |  60 +++++------
 drivers/nvdimm/virtio_pmem.c       |  36 ++++++-
 drivers/scsi/virtio_scsi.c         |  78 +++++++++++++-
 drivers/vdpa/alibaba/eni_vdpa.c    |   6 +-
 drivers/vdpa/mlx5/core/mlx5_vdpa.h |  10 +-
 drivers/vdpa/mlx5/core/mr.c        |  73 ++++++++++---
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 209 +++++++++++++++++++++++++++++++++----
 drivers/vdpa/vdpa.c                |   4 +-
 drivers/vhost/vdpa.c               |  26 ++++-
 drivers/virtio/virtio_balloon.c    |  57 ++++++++--
 drivers/virtio/virtio_pci_common.c |  34 +++++-
 include/linux/mlx5/mlx5_ifc.h      |   3 +-
 include/linux/mlx5/mlx5_ifc_vdpa.h |   4 +
 include/uapi/linux/virtio_pmem.h   |   7 ++
 14 files changed, 510 insertions(+), 97 deletions(-)


