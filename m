Return-Path: <netdev+bounces-97689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D888CCBF1
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 08:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59638B21967
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 06:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260EF7D412;
	Thu, 23 May 2024 06:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zs0oTxV7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7103C224DC
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 06:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716444033; cv=none; b=LCtfQxDUkfU31LMEZVIqGyKXb8I5D6LEVsWSGCHdCQ6waOOXNYnlbqeoNiOASaSGedXShzeIi0uD9LLHJJhy4FghlKGyWI/bB78Vwt41LJyF3ROQOSsBaU8o22cCJpFyM0sPMLvD21dcDi0qisW81pDak5sU0x9ymwGKvii0rkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716444033; c=relaxed/simple;
	bh=Se4JJHuUK1YAcPMwJrWNIBI9Ci1nNIC9TTJtr6ON0KA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ACn9jCwEIHHgp0z2NVPH/ADa6/wgqKYSRMQiRD/epDw6sZjBSYccFIXe/93sQ4Me4J+4kZ1KllWVVlGgB6QaN7lrpSzZVLMRebJsidrVMTub0+zldaD+X5c+NaQZfBj1RStoaqNNKwKgARpAc39bSICq1OwKcgbJ841CBQtM4So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zs0oTxV7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716444030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yeUwdxW+9athxBr6SBuU13bYsy0ba7pdIdq8UligVLc=;
	b=Zs0oTxV7bubH2th+wnI60u/EmpeEi4OV3/NtTgAnjhHwA9/1A6dYsnYjFsOXUcbo7yInfs
	XowGqAf1hE2Jq2BuGctvHDHIKcS8cIj1jr1Zt6rgQbh9e1Wgu5B6tqt7s5bjDNUU2DXB3g
	oFR3nNb8D3sq7FptGHYw2qgFOyEvd9s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-4tX6IPhMPv-kEOTE0zMyBg-1; Thu, 23 May 2024 02:00:27 -0400
X-MC-Unique: 4tX6IPhMPv-kEOTE0zMyBg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-351c67dbc8dso6863605f8f.2
        for <netdev@vger.kernel.org>; Wed, 22 May 2024 23:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716444026; x=1717048826;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yeUwdxW+9athxBr6SBuU13bYsy0ba7pdIdq8UligVLc=;
        b=KGSS29SPq35s9WxlBRbMmdwJ3ERD1M4DDXUHvj/1sv/5I47BO/8izGSq4x5uoTVINa
         QbocvekOn/SWWkqvQoGvHZP3ZF7rIXA9+feFfZvIiZOw1VgcWB/WMsDI8mn26Tyf5TNn
         sqc9WwHTsUYOgFBzJC/tOe5yySfCiYNwHEJwHPowBaqzHOgrS6F7u5rjXWmIKpR8826c
         ML61JZp3pOKswBS8OIoTyVJet0q3mzYPYYOoXMtva2HfRDnYjqarukHcD6qzt2QJVj2Q
         oSnl2bww3hUAysiB1dfD6uLbftwHwFc3+GNe323wS72Va9QeVXTZIjgbueC5Xy4l7e2c
         0fwQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+iQ4bB4PJ8yW8Ro/+lKrqUQKLIDkGl6dwMsxd3mcYA76ZYRQhrCJtmTeuv8Jy7DDh2iGq04siX3S3x/qJf5iHCPNDIg82
X-Gm-Message-State: AOJu0Yy0c39/9U4EWPCO1bA49GuhudgdsH7jSciiNMp7lEPR7njE4z1F
	6kMVyr65nGlJF7TkIFqlCHRJIT8okZlUV+m97tlhpS/lybAszyOGaEpWQ2/NPjJJqDY03Evxmfj
	O/yJDSCozI8/AIVLOHoP/DYznXl6l547FKhPw/sm5iwaHWYAu1W+KTQ==
X-Received: by 2002:a5d:4104:0:b0:354:f2a7:97dc with SMTP id ffacd0b85a97d-354f2a79916mr2112163f8f.2.1716444025788;
        Wed, 22 May 2024 23:00:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHggXEqAc5WDd25UhTKUSbGqVNdQxbTGJOXdMfMSLslbIWkT+TDNK7KDuOftvOQ4EXBOWM/fg==
X-Received: by 2002:a5d:4104:0:b0:354:f2a7:97dc with SMTP id ffacd0b85a97d-354f2a79916mr2112094f8f.2.1716444024784;
        Wed, 22 May 2024 23:00:24 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f8:1442:5e01:de24:22c0:6071])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b896a34sm35664458f8f.35.2024.05.22.23.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 23:00:23 -0700 (PDT)
Date: Thu, 23 May 2024 02:00:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	anton.yakovlev@opensynergy.com, bartosz.golaszewski@linaro.org,
	christophe.jaillet@wanadoo.fr, dave.jiang@intel.com,
	david@redhat.com, eperezma@redhat.com, herbert@gondor.apana.org.au,
	jasowang@redhat.com, jiri@nvidia.com, jiri@resnulli.us,
	johannes@sipsolutions.net, krzysztof.kozlowski@linaro.org,
	lingshan.zhu@intel.com, linus.walleij@linaro.org,
	lizhijian@fujitsu.com, martin.petersen@oracle.com,
	maxime.coquelin@redhat.com, michael.christie@oracle.com,
	mst@redhat.com, sgarzare@redhat.com, stevensd@chromium.org,
	sudeep.holla@arm.com,
	syzbot+98edc2df894917b3431f@syzkaller.appspotmail.com,
	u.kleine-koenig@pengutronix.de, viresh.kumar@linaro.org,
	xuanzhuo@linux.alibaba.com, yuxue.liu@jaguarmicro.com,
	zhanglikernel@gmail.com, Srujana Challa <schalla@marvell.com>
Subject: [GIT PULL v2] virtio: features, fixes, cleanups
Message-ID: <Zk7bX3XlEWtaPbxZ@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit


Things to note here:
- dropped a couple of patches at the last moment. Did a bunch
  of testing in the last day to make sure that's not causing
  any fallout, it's a revert and no other changes in the same area
  so I feel rather safe doing that.
- the new Marvell OCTEON DPU driver is not here: latest v4 keeps causing
  build failures on mips. I kept deferring the pull hoping to get it in
  and I might try to merge a new version post rc1 (supposed to be ok for
  new drivers as they can't cause regressions), but we'll see.
- there are also a couple bugfixes under review, to be merged after rc1
- there is a trivial conflict in the header file. Shouldn't be any
  trouble to resolve, but fyi the resolution by Stephen is here
        diff --cc drivers/virtio/virtio_mem.c
        index e8355f55a8f7,6d4dfbc53a66..000000000000
        --- a/drivers/virtio/virtio_mem.c
        +++ b/drivers/virtio/virtio_mem.c
        @@@ -21,7 -21,7 +21,8 @@@
          #include <linux/bitmap.h>
          #include <linux/lockdep.h>
          #include <linux/log2.h>
         +#include <linux/vmalloc.h>
        + #include <linux/suspend.h>
  Also see it here:
  https://lore.kernel.org/all/20240423145947.142171f6@canb.auug.org.au/


The following changes since commit 18daea77cca626f590fb140fc11e3a43c5d41354:

  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm (2024-04-30 12:40:41 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to c8fae27d141a32a1624d0d0d5419d94252824498:

  virtio-pci: Check if is_avq is NULL (2024-05-22 08:39:41 -0400)

----------------------------------------------------------------
virtio: features, fixes, cleanups

Several new features here:

- virtio-net is finally supported in vduse.

- Virtio (balloon and mem) interaction with suspend is improved

- vhost-scsi now handles signals better/faster.

Fixes, cleanups all over the place.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Christophe JAILLET (1):
      vhost-vdpa: Remove usage of the deprecated ida_simple_xx() API

David Hildenbrand (1):
      virtio-mem: support suspend+resume

David Stevens (2):
      virtio_balloon: Give the balloon its own wakeup source
      virtio_balloon: Treat stats requests as wakeup events

Eugenio Pérez (1):
      MAINTAINERS: add Eugenio Pérez as reviewer

Jiri Pirko (1):
      virtio: delete vq in vp_find_vqs_msix() when request_irq() fails

Krzysztof Kozlowski (24):
      virtio: balloon: drop owner assignment
      virtio: input: drop owner assignment
      virtio: mem: drop owner assignment
      um: virt-pci: drop owner assignment
      virtio_blk: drop owner assignment
      bluetooth: virtio: drop owner assignment
      hwrng: virtio: drop owner assignment
      virtio_console: drop owner assignment
      crypto: virtio - drop owner assignment
      firmware: arm_scmi: virtio: drop owner assignment
      gpio: virtio: drop owner assignment
      drm/virtio: drop owner assignment
      iommu: virtio: drop owner assignment
      misc: nsm: drop owner assignment
      net: caif: virtio: drop owner assignment
      net: virtio: drop owner assignment
      net: 9p: virtio: drop owner assignment
      vsock/virtio: drop owner assignment
      wifi: mac80211_hwsim: drop owner assignment
      nvdimm: virtio_pmem: drop owner assignment
      rpmsg: virtio: drop owner assignment
      scsi: virtio: drop owner assignment
      fuse: virtio: drop owner assignment
      sound: virtio: drop owner assignment

Li Zhang (1):
      virtio-pci: Check if is_avq is NULL

Li Zhijian (1):
      vdpa: Convert sprintf/snprintf to sysfs_emit

Maxime Coquelin (3):
      vduse: validate block features only with block devices
      vduse: Temporarily fail if control queue feature requested
      vduse: enable Virtio-net device type

Michael S. Tsirkin (1):
      Merge tag 'stable/vduse-virtio-net' into vhost

Mike Christie (9):
      vhost-scsi: Handle vhost_vq_work_queue failures for events
      vhost-scsi: Handle vhost_vq_work_queue failures for cmds
      vhost-scsi: Use system wq to flush dev for TMFs
      vhost: Remove vhost_vq_flush
      vhost_scsi: Handle vhost_vq_work_queue failures for TMFs
      vhost: Use virtqueue mutex for swapping worker
      vhost: Release worker mutex during flushes
      vhost_task: Handle SIGKILL by flushing work and exiting
      kernel: Remove signal hacks for vhost_tasks

Uwe Kleine-König (1):
      virtio-mmio: Convert to platform remove callback returning void

Yuxue Liu (2):
      vp_vdpa: Fix return value check vp_vdpa_request_irq
      vp_vdpa: don't allocate unused msix vectors

Zhu Lingshan (1):
      MAINTAINERS: apply maintainer role of Intel vDPA driver

 MAINTAINERS                                   |  10 +-
 arch/um/drivers/virt-pci.c                    |   1 -
 drivers/block/virtio_blk.c                    |   1 -
 drivers/bluetooth/virtio_bt.c                 |   1 -
 drivers/char/hw_random/virtio-rng.c           |   1 -
 drivers/char/virtio_console.c                 |   2 -
 drivers/crypto/virtio/virtio_crypto_core.c    |   1 -
 drivers/firmware/arm_scmi/virtio.c            |   1 -
 drivers/gpio/gpio-virtio.c                    |   1 -
 drivers/gpu/drm/virtio/virtgpu_drv.c          |   1 -
 drivers/iommu/virtio-iommu.c                  |   1 -
 drivers/misc/nsm.c                            |   1 -
 drivers/net/caif/caif_virtio.c                |   1 -
 drivers/net/virtio_net.c                      |   1 -
 drivers/net/wireless/virtual/mac80211_hwsim.c |   1 -
 drivers/nvdimm/virtio_pmem.c                  |   1 -
 drivers/rpmsg/virtio_rpmsg_bus.c              |   1 -
 drivers/scsi/virtio_scsi.c                    |   1 -
 drivers/vdpa/vdpa.c                           |   2 +-
 drivers/vdpa/vdpa_user/vduse_dev.c            |  24 ++++-
 drivers/vdpa/virtio_pci/vp_vdpa.c             |  27 ++++--
 drivers/vhost/scsi.c                          |  70 ++++++++------
 drivers/vhost/vdpa.c                          |   6 +-
 drivers/vhost/vhost.c                         | 130 ++++++++++++++++++--------
 drivers/vhost/vhost.h                         |   3 +-
 drivers/virtio/virtio_balloon.c               |  85 +++++++++++------
 drivers/virtio/virtio_input.c                 |   1 -
 drivers/virtio/virtio_mem.c                   |  69 ++++++++++++--
 drivers/virtio/virtio_mmio.c                  |   6 +-
 drivers/virtio/virtio_pci_common.c            |   6 +-
 fs/coredump.c                                 |   4 +-
 fs/fuse/virtio_fs.c                           |   1 -
 include/linux/sched/vhost_task.h              |   3 +-
 include/uapi/linux/virtio_mem.h               |   2 +
 kernel/exit.c                                 |   5 +-
 kernel/signal.c                               |   4 +-
 kernel/vhost_task.c                           |  53 +++++++----
 net/9p/trans_virtio.c                         |   1 -
 net/vmw_vsock/virtio_transport.c              |   1 -
 sound/virtio/virtio_card.c                    |   1 -
 40 files changed, 355 insertions(+), 177 deletions(-)


