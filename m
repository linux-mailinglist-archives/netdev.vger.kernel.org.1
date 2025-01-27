Return-Path: <netdev+bounces-161132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9244FA1D8BE
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 15:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E20D016410C
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 14:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557F0126C03;
	Mon, 27 Jan 2025 14:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aZZhpZHm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710575B211
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 14:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737989507; cv=none; b=h+LRsYq2k0PWqqklderUGYuq7cmVnQQ6BHDnrn1pqiZwq8Jm5TdSCXrM7HEgdf4TkoWu8qNvzugc+jmgycPOztAIEL+q21NY6USNwgrnAx6g7a8avqqudZhT1lL723ArltfiMxLiKy6OW/1NRevHLxUYpqMLvqOf3EUa5E2CoV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737989507; c=relaxed/simple;
	bh=82o5UCZGVSA9UZesK2R8teTwT07ErbjUj7U5zfSimqY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gLmSROSog5HfIDLzNq2Xq18qZtf9mWG7nuRf1v7gs5VbWzHgiwOG18+zn4ojYn9A53KDJR+TdA1r8CKA0ejhxAatZsSBuutGN7HGvfDnCWDHyWxFq5o+pR/ifShYqSvLgZmUWKy35c7qDciV7Qn0DUPYlDlCfBAo8NqnDBZVms4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aZZhpZHm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737989504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=iau4JPbloeWL667asjULg/fQ3/zjcPRlyMvVrpALuFo=;
	b=aZZhpZHmoSLOm1bWCLhp02AnyGk70G5DpfAHmZokFRGHmHpi8wyRHFGCP5/4WRm7T1D14+
	2XJZB+Nv3EcYDCNe1UTyaG8MYM7MsiJa0x2Iv0VECn9Chw3BP6ig1jCbR9cycW8qVPwEFc
	2IhQi0t9I9dG7+bqiAw3jeaxM5K8+xU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-xjOqP_TvPv-yMjT5ufFSiw-1; Mon, 27 Jan 2025 09:51:43 -0500
X-MC-Unique: xjOqP_TvPv-yMjT5ufFSiw-1
X-Mimecast-MFC-AGG-ID: xjOqP_TvPv-yMjT5ufFSiw
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4362b9c15d8so22069655e9.3
        for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 06:51:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737989502; x=1738594302;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iau4JPbloeWL667asjULg/fQ3/zjcPRlyMvVrpALuFo=;
        b=CtKWcwnsDNxhZ83keHM+GwnmVoQXdB8+0NS5XGPBXScfcv38wvpk2KP5u5U+p2nVcR
         XHt2x0ycLCfJA+XToguGu381dpMbkBodwx/TAu0yOiXdl4SOb2e+ol5HKTo+bSuJnmnf
         As0xKrbtV+bnpptVqCT9KSK41EIFqin7TBFI7LHp8GzYfYW+3xZRFpx1w9O7z3N8MaCR
         VaSBnVl7z3mIx2xINNsBOJIeXeiMxtjWQ2bOGvM79B85zQJ9pZ1yqyl+3SzgTTQBpUnK
         fFj57340EJrZ8hapuG2YvyGFteUNqUiAfIPxacGEvvcXaqktoy8GTIZzMELQt45OhCWf
         PEjw==
X-Forwarded-Encrypted: i=1; AJvYcCXM7EnMlicWJHFAf4JGFaYV10g4WIEQ/58DmaSWUOKi77RivDgkopCiJ1CJKkxtgZSdSA+8KFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyODhyjsnTm8ENMXd+tU7hjL4dVWjSBW7/CpEOxuUMlI3JWAKMh
	k83ZU/kPRj9Rx6j4qO3VchYg/OQUYqyrBLnD6mhMkgvMn4b4kIdmvNBU9gtz6IElquMTSiB5r69
	2WcUJgztp+EASVshsXMdIfaTlzoCUg+OI3sbkITm6Vm1KLtKgkBkhLA==
X-Gm-Gg: ASbGncsJsKhe2qoGcv/mmeNeMRH8VnSF08lSjIMfwCtAZ1MzfDFyfQd8xioy9A5bd8P
	XRFFKluUC6FY7d81nZQh8AkCYZ1+yNJJEbjMx+Tp4UApUTxV09/dUpCXE7f+IE5taFau/KMXlKE
	syFAYbuRKQ29rZhof7oFDbhKidIlEKn8OqUtbA2trDkeYHeW/6Ge1fRdUM2JadtW2iK9T5cUj9o
	s4GjEzvhR4GkIXScmRbfiqTeSu1k1/Ew2DQ3SElcFdsCNGHzvgO3KWm/ZUVVauQwkJCrmr8fYuz
	gQ==
X-Received: by 2002:a05:600c:8719:b0:434:9499:9e87 with SMTP id 5b1f17b1804b1-43891437217mr333777575e9.25.1737989501762;
        Mon, 27 Jan 2025 06:51:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHuV4H4eM+0+8cCmZ4gGN82WCYmpRuJq01+bj07H2U3xuDnsFknD44BEnMwIVHwLR+uIAWc4g==
X-Received: by 2002:a05:600c:8719:b0:434:9499:9e87 with SMTP id 5b1f17b1804b1-43891437217mr333777455e9.25.1737989501407;
        Mon, 27 Jan 2025 06:51:41 -0800 (PST)
Received: from redhat.com ([2a06:c701:740d:3500:7f3a:4e66:9c0d:1416])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b171e68bsm158813595e9.0.2025.01.27.06.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 06:51:40 -0800 (PST)
Date: Mon, 27 Jan 2025 09:51:38 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	akihiko.odaki@daynix.com, akpm@linux-foundation.org, bhe@redhat.com,
	david@redhat.com, israelr@nvidia.com, jasowang@redhat.com,
	mst@redhat.com, pstanner@redhat.com, sgarzare@redhat.com,
	skoteshwar@marvell.com, sthotton@marvell.com,
	xieyongji@bytedance.com, yuxue.liu@jaguarmicro.com,
	zhangjiao2@cmss.chinamobile.com
Subject: [GIT PULL] virtio: features, fixes, cleanups
Message-ID: <20250127095138-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent

There are still some known issues that I hope to address by rc2.
Giving them more time to get tested for now - none of them are
regressions.

The following changes since commit 9d89551994a430b50c4fffcb1e617a057fa76e20:

  Linux 6.13-rc6 (2025-01-05 14:13:40 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 5820a3b08987951e3e4a89fca8ab6e1448f672e1:

  virtio_blk: Add support for transport error recovery (2025-01-27 09:39:26 -0500)

----------------------------------------------------------------
virtio: features, fixes, cleanups

A small number of improvements all over the place:

vdpa/octeon gained support for multiple interrupts
virtio-pci gained support for error recovery
vp_vdpa gained support for notification with data
vhost/net has been fixed to set num_buffers for spec compliance
virtio-mem now works with kdump on s390

Small cleanups all over the place.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Akihiko Odaki (1):
      vhost/net: Set num_buffers for virtio 1.0

David Hildenbrand (12):
      fs/proc/vmcore: convert vmcore_cb_lock into vmcore_mutex
      fs/proc/vmcore: replace vmcoredd_mutex by vmcore_mutex
      fs/proc/vmcore: disallow vmcore modifications while the vmcore is open
      fs/proc/vmcore: prefix all pr_* with "vmcore:"
      fs/proc/vmcore: move vmcore definitions out of kcore.h
      fs/proc/vmcore: factor out allocating a vmcore range and adding it to a list
      fs/proc/vmcore: factor out freeing a list of vmcore ranges
      fs/proc/vmcore: introduce PROC_VMCORE_DEVICE_RAM to detect device RAM ranges in 2nd kernel
      virtio-mem: mark device ready before registering callbacks in kdump mode
      virtio-mem: remember usable region size
      virtio-mem: support CONFIG_PROC_VMCORE_DEVICE_RAM
      s390/kdump: virtio-mem kdump support (CONFIG_PROC_VMCORE_DEVICE_RAM)

Israel Rukshin (2):
      virtio_pci: Add support for PCIe Function Level Reset
      virtio_blk: Add support for transport error recovery

Philipp Stanner (1):
      vdpa: solidrun: Replace deprecated PCI functions

Satha Rao (1):
      vdpa/octeon_ep: handle device config change events

Shijith Thotton (3):
      vdpa/octeon_ep: enable support for multiple interrupts per device
      virtio-pci: define type and header for PCI vendor data
      vdpa/octeon_ep: read vendor-specific PCI capability

Yongji Xie (1):
      vduse: relicense under GPL-2.0 OR BSD-3-Clause

Yuxue Liu (1):
      vdpa/vp_vdpa: implement kick_vq_with_data callback

zhang jiao (1):
      virtio_balloon: Use outer variable 'page'

 arch/s390/Kconfig                        |   1 +
 arch/s390/kernel/crash_dump.c            |  39 ++++-
 drivers/block/virtio_blk.c               |  28 ++-
 drivers/vdpa/octeon_ep/octep_vdpa.h      |  32 +++-
 drivers/vdpa/octeon_ep/octep_vdpa_hw.c   |  38 ++++-
 drivers/vdpa/octeon_ep/octep_vdpa_main.c |  99 +++++++----
 drivers/vdpa/solidrun/snet_main.c        |  57 +++----
 drivers/vdpa/virtio_pci/vp_vdpa.c        |   9 +
 drivers/vhost/net.c                      |   5 +-
 drivers/virtio/virtio.c                  |  94 +++++++---
 drivers/virtio/virtio_balloon.c          |   2 +-
 drivers/virtio/virtio_mem.c              | 103 ++++++++++-
 drivers/virtio/virtio_pci_common.c       |  41 +++++
 fs/proc/Kconfig                          |  19 +++
 fs/proc/vmcore.c                         | 283 ++++++++++++++++++++++++-------
 include/linux/crash_dump.h               |  41 +++++
 include/linux/kcore.h                    |  13 --
 include/linux/virtio.h                   |   8 +
 include/uapi/linux/vduse.h               |   2 +-
 include/uapi/linux/virtio_pci.h          |  14 ++
 20 files changed, 735 insertions(+), 193 deletions(-)


