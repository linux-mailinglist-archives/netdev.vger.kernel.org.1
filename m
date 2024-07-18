Return-Path: <netdev+bounces-112125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA949935226
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 21:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 921E4282B41
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 19:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827F3145A12;
	Thu, 18 Jul 2024 19:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P67b5KLh"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1824B144D01
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 19:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721331119; cv=none; b=Te0bfD37ibWl4znJEEqI8B+awS30W9d3JH8AkVK1n+mCby+UvuqMkvZvDbvcaGzIqCI4DSTq/n33MOR9pcxUYrOBVPr6D53ryWhgTnBSJY7ziihkFTJYircCF5bb33WEOqx/cPCDWjjK4ygDwN4F7+xIPrcBWJBxoO8sfDQLiok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721331119; c=relaxed/simple;
	bh=uZCA4qWl5w8RE1AQt3ybcDlrqERFd/V5bKccyt9GLEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EgBFxEvJjIkKSJNGqqnaUfi/wYd3tSZEMcoRTcXN4A5H9k9MGvbmq/Wcwl0t3qTt4wkMCx8N9F6SoX4Ggzi7SPYB5gewDUsFfFuyhgsawKuFVLZ79dbktwwYa/2TGYmy+wQyQRfRTwdq21cv/579T9H93QjBXzIgo/dwfs7DwnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P67b5KLh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721331116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EZp2m/xDJYJsFDq2RFUIeo0v+z6YmWWhul+/X+TGVng=;
	b=P67b5KLhEP3bdJTxtmQA+8Gz4cc5ULVJAaZYejd7+w7Czu0oPdCfRV7XbbYQ5rD/nxGmUI
	E3rRReIW6IAIaQR2nnBsXpVaMqKUM9WUFj4NN125Xcrgcz9BB2B/pzOhgRzYdz240AZ4DF
	pxaKX+6cISzQqRP9lbgJ1RYoGy0Y4Ro=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-1Q0E4CqvP9Cw3AZps26laQ-1; Thu, 18 Jul 2024 15:31:54 -0400
X-MC-Unique: 1Q0E4CqvP9Cw3AZps26laQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-368255decf3so130571f8f.3
        for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 12:31:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721331113; x=1721935913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EZp2m/xDJYJsFDq2RFUIeo0v+z6YmWWhul+/X+TGVng=;
        b=NpIpyzRDaMJU9aspdFRsNbUZE6LnmTNnEePANqJYJ8cqEs+xiklwGVvjgRH/DRdCp4
         kSYcJ7/3XijWvpszwdrBn/y0b0gWfM9TbFlLZM96nFVjOaqFFxJZsWK+b7g2vbDbtNAD
         3OS5FBsRIHKwbNdQgIRGtrptap1VsqJSYyb6UVgBk/A1S5eZbADTyCkxFITSdbeMHiS/
         52o4JiyHtzxR6dsTCejLWYhzQYcQELGrYWmtf7UNQhRAxUDFokuddSdXf5huboba6UQs
         6jMjWpQLpAntwXIKBcmcF8QlVtnOb3gQRw1d4n3k1Jxt/2BhdNw1SeYIC8SiKOr4WxLU
         QCOA==
X-Forwarded-Encrypted: i=1; AJvYcCU3AnF/45qVMBnjAHqkoTHvJRZM8+x/Ub1aJj8PWFJ9PohudZQauRQYXLojT2u5v3a/Lyu29VgiEAflROH5AncY+MTYOX/0
X-Gm-Message-State: AOJu0YyL0UqoxQm9jXneQYSiobaqon8mBNY/cmouA+rbyDNrirpHf1to
	29MLweasxcD5F4ibyLZuGvigXSyWyuCc55uZ/9moS+vuX1WUqlYMF17dl27cLKs7Ig21gk94QZ8
	vM+1FIfXV1qj1fxbAZtsFG1Ug4EAVuog2o322ZbVM7kClxRaVBcLLLQ==
X-Received: by 2002:a05:6000:e0a:b0:368:6694:b4b9 with SMTP id ffacd0b85a97d-3686694b5fdmr1218458f8f.58.1721331113553;
        Thu, 18 Jul 2024 12:31:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDfDJBynCqhokZOBmyeRTxbg3wA1aLVhosXnR726bON6Q2Vzp0AmvGAfukdQTw4lX2ErdYGQ==
X-Received: by 2002:a05:6000:e0a:b0:368:6694:b4b9 with SMTP id ffacd0b85a97d-3686694b5fdmr1218452f8f.58.1721331112920;
        Thu, 18 Jul 2024 12:31:52 -0700 (PDT)
Received: from redhat.com (mob-5-90-112-15.net.vodafone.it. [5.90.112.15])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-368727c3585sm412611f8f.20.2024.07.18.12.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 12:31:52 -0700 (PDT)
Date: Thu, 18 Jul 2024 15:31:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	aha310510@gmail.com, arefev@swemel.ru, arseny.krasnov@kaspersky.com,
	davem@davemloft.net, dtatulea@nvidia.com, eperezma@redhat.com,
	glider@google.com, iii@linux.ibm.com, jasowang@redhat.com,
	jiri@nvidia.com, jiri@resnulli.us, kuba@kernel.org,
	lingshan.zhu@intel.com, ndabilpuram@marvell.com,
	pgootzen@nvidia.com, pizhenwei@bytedance.com,
	quic_jjohnson@quicinc.com, schalla@marvell.com, stefanha@redhat.com,
	sthotton@marvell.com,
	syzbot+6c21aeb59d0e82eb2782@syzkaller.appspotmail.com,
	vattunuru@marvell.com, will@kernel.org, xuanzhuo@linux.alibaba.com,
	yskelg@gmail.com
Subject: Re: [GIT PULL] virtio: features, fixes, cleanups
Message-ID: <20240718152945-mutt-send-email-mst@kernel.org>
References: <20240717053034-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717053034-mutt-send-email-mst@kernel.org>

On Wed, Jul 17, 2024 at 05:30:34AM -0400, Michael S. Tsirkin wrote:
> This is relatively small.
> I had to drop a buggy commit in the middle so some hashes
> changed from what was in linux-next.
> Deferred admin vq scalability fix to after rc2 as a minor issue was
> found with it recently, but the infrastructure for it
> is there now.

BTW I forgot to mention a merge conflict with char-misc
that is also adding an entry in MAINTAINERS.
It's trivial to resolve.


> The following changes since commit e9d22f7a6655941fc8b2b942ed354ec780936b3e:
> 
>   Merge tag 'linux_kselftest-fixes-6.10-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest (2024-07-02 13:53:24 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
> 
> for you to fetch changes up to 6c85d6b653caeba2ef982925703cbb4f2b3b3163:
> 
>   virtio: rename virtio_find_vqs_info() to virtio_find_vqs() (2024-07-17 05:20:58 -0400)
> 
> ----------------------------------------------------------------
> virtio: features, fixes, cleanups
> 
> Several new features here:
> 
> - Virtio find vqs API has been reworked
>   (required to fix the scalability issue we have with
>    adminq, which I hope to merge later in the cycle)
> 
> - vDPA driver for Marvell OCTEON
> 
> - virtio fs performance improvement
> 
> - mlx5 migration speedups
> 
> Fixes, cleanups all over the place.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> ----------------------------------------------------------------
> Denis Arefev (1):
>       net: missing check virtio
> 
> Dragos Tatulea (24):
>       vdpa/mlx5: Clarify meaning thorough function rename
>       vdpa/mlx5: Make setup/teardown_vq_resources() symmetrical
>       vdpa/mlx5: Drop redundant code
>       vdpa/mlx5: Drop redundant check in teardown_virtqueues()
>       vdpa/mlx5: Iterate over active VQs during suspend/resume
>       vdpa/mlx5: Remove duplicate suspend code
>       vdpa/mlx5: Initialize and reset device with one queue pair
>       vdpa/mlx5: Clear and reinitialize software VQ data on reset
>       vdpa/mlx5: Rename init_mvqs
>       vdpa/mlx5: Add support for modifying the virtio_version VQ field
>       vdpa/mlx5: Add support for modifying the VQ features field
>       vdpa/mlx5: Set an initial size on the VQ
>       vdpa/mlx5: Start off rqt_size with max VQPs
>       vdpa/mlx5: Set mkey modified flags on all VQs
>       vdpa/mlx5: Allow creation of blank VQs
>       vdpa/mlx5: Accept Init -> Ready VQ transition in resume_vq()
>       vdpa/mlx5: Add error code for suspend/resume VQ
>       vdpa/mlx5: Consolidate all VQ modify to Ready to use resume_vq()
>       vdpa/mlx5: Forward error in suspend/resume device
>       vdpa/mlx5: Use suspend/resume during VQP change
>       vdpa/mlx5: Pre-create hardware VQs at vdpa .dev_add time
>       vdpa/mlx5: Re-create HW VQs under certain conditions
>       vdpa/mlx5: Don't reset VQs more than necessary
>       vdpa/mlx5: Don't enable non-active VQs in .set_vq_ready()
> 
> Jeff Johnson (3):
>       vringh: add MODULE_DESCRIPTION()
>       virtio: add missing MODULE_DESCRIPTION() macros
>       vDPA: add missing MODULE_DESCRIPTION() macros
> 
> Jiri Pirko (19):
>       caif_virtio: use virtio_find_single_vq() for single virtqueue finding
>       virtio: make virtio_find_vqs() call virtio_find_vqs_ctx()
>       virtio: make virtio_find_single_vq() call virtio_find_vqs()
>       virtio: introduce virtio_queue_info struct and find_vqs_info() config op
>       virtio_pci: convert vp_*find_vqs() ops to find_vqs_info()
>       virtio: convert find_vqs() op implementations to find_vqs_info()
>       virtio: call virtio_find_vqs_info() from virtio_find_single_vq() directly
>       virtio: remove the original find_vqs() op
>       virtio: rename find_vqs_info() op to find_vqs()
>       virtio_blk: convert to use virtio_find_vqs_info()
>       virtio_console: convert to use virtio_find_vqs_info()
>       virtio_crypto: convert to use virtio_find_vqs_info()
>       virtio_net: convert to use virtio_find_vqs_info()
>       scsi: virtio_scsi: convert to use virtio_find_vqs_info()
>       virtiofs: convert to use virtio_find_vqs_info()
>       virtio_balloon: convert to use virtio_find_vqs_info()
>       virtio: convert the rest virtio_find_vqs() users to virtio_find_vqs_info()
>       virtio: remove unused virtio_find_vqs() and virtio_find_vqs_ctx() helpers
>       virtio: rename virtio_find_vqs_info() to virtio_find_vqs()
> 
> Michael S. Tsirkin (2):
>       vhost/vsock: always initialize seqpacket_allow
>       vhost: move smp_rmb() into vhost_get_avail_idx()
> 
> Peter-Jan Gootzen (2):
>       virtio-fs: let -ENOMEM bubble up or burst gently
>       virtio-fs: improved request latencies when Virtio queue is full
> 
> Srujana Challa (1):
>       virtio: vdpa: vDPA driver for Marvell OCTEON DPU devices
> 
> Xuan Zhuo (1):
>       virtio_ring: fix KMSAN error for premapped mode
> 
> Yunseong Kim (1):
>       tools/virtio: creating pipe assertion in vringh_test
> 
> Zhu Lingshan (1):
>       MAINTAINERS: Change lingshan's email to kernel.org
> 
> zhenwei pi (1):
>       virtio_balloon: separate vm events into a function
> 
>  MAINTAINERS                                   |   7 +-
>  arch/um/drivers/virt-pci.c                    |   8 +-
>  arch/um/drivers/virtio_uml.c                  |  12 +-
>  drivers/block/virtio_blk.c                    |  20 +-
>  drivers/bluetooth/virtio_bt.c                 |  13 +-
>  drivers/char/virtio_console.c                 |  43 +-
>  drivers/crypto/virtio/virtio_crypto_core.c    |  31 +-
>  drivers/firmware/arm_scmi/virtio.c            |  11 +-
>  drivers/gpio/gpio-virtio.c                    |  10 +-
>  drivers/gpu/drm/virtio/virtgpu_kms.c          |   9 +-
>  drivers/iommu/virtio-iommu.c                  |  11 +-
>  drivers/net/caif/caif_virtio.c                |   8 +-
>  drivers/net/virtio_net.c                      |  34 +-
>  drivers/net/wireless/virtual/mac80211_hwsim.c |  12 +-
>  drivers/platform/mellanox/mlxbf-tmfifo.c      |  10 +-
>  drivers/remoteproc/remoteproc_virtio.c        |  12 +-
>  drivers/rpmsg/virtio_rpmsg_bus.c              |   8 +-
>  drivers/s390/virtio/virtio_ccw.c              |  13 +-
>  drivers/scsi/virtio_scsi.c                    |  32 +-
>  drivers/vdpa/Kconfig                          |  11 +
>  drivers/vdpa/Makefile                         |   1 +
>  drivers/vdpa/ifcvf/ifcvf_main.c               |   1 +
>  drivers/vdpa/mlx5/net/mlx5_vnet.c             | 429 ++++++++-----
>  drivers/vdpa/mlx5/net/mlx5_vnet.h             |   1 +
>  drivers/vdpa/octeon_ep/Makefile               |   4 +
>  drivers/vdpa/octeon_ep/octep_vdpa.h           |  94 +++
>  drivers/vdpa/octeon_ep/octep_vdpa_hw.c        | 517 ++++++++++++++++
>  drivers/vdpa/octeon_ep/octep_vdpa_main.c      | 857 ++++++++++++++++++++++++++
>  drivers/vdpa/vdpa.c                           |   1 +
>  drivers/vhost/vhost.c                         | 105 ++--
>  drivers/vhost/vringh.c                        |   1 +
>  drivers/vhost/vsock.c                         |   4 +-
>  drivers/virtio/virtio.c                       |   1 +
>  drivers/virtio/virtio_balloon.c               |  75 ++-
>  drivers/virtio/virtio_input.c                 |   9 +-
>  drivers/virtio/virtio_mmio.c                  |  12 +-
>  drivers/virtio/virtio_pci_common.c            |  48 +-
>  drivers/virtio/virtio_pci_common.h            |   3 +-
>  drivers/virtio/virtio_pci_modern.c            |   5 +-
>  drivers/virtio/virtio_ring.c                  |   5 +-
>  drivers/virtio/virtio_vdpa.c                  |  13 +-
>  fs/fuse/virtio_fs.c                           |  62 +-
>  include/linux/mlx5/mlx5_ifc_vdpa.h            |   2 +
>  include/linux/virtio_config.h                 |  64 +-
>  include/linux/virtio_net.h                    |  11 +
>  net/vmw_vsock/virtio_transport.c              |  16 +-
>  sound/virtio/virtio_card.c                    |  23 +-
>  tools/virtio/vringh_test.c                    |   9 +-
>  48 files changed, 2145 insertions(+), 543 deletions(-)
>  create mode 100644 drivers/vdpa/octeon_ep/Makefile
>  create mode 100644 drivers/vdpa/octeon_ep/octep_vdpa.h
>  create mode 100644 drivers/vdpa/octeon_ep/octep_vdpa_hw.c
>  create mode 100644 drivers/vdpa/octeon_ep/octep_vdpa_main.c


