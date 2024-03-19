Return-Path: <netdev+bounces-80518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 322D187F887
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 08:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55A301C21988
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 07:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF5B537E0;
	Tue, 19 Mar 2024 07:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gUpEDfKx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1A45380F
	for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 07:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710834113; cv=none; b=uLnE/XY5/oL46X501ztJlrp8+KS9MKLMPM9r4+egQ2pf33LoswDwpvkvrNZAwln5+UovzDTX+mtmcGLexb8gf9s6+M1TzHR1DrtHpSyUM4CItjB+ksjdNoH7bRV2huWWZfyPFoLJXRtg38yUvSCNdLajvk5vaiobcZd1boxo1EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710834113; c=relaxed/simple;
	bh=2crLoEVLnwiq99cE6HQUHEb+ylseepzZNYcoRSHN6zw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=H88r/mfAnHdwKXSpWB4+bNzn4JGbswsumQ4lgLhpGpNYSQswXA5TGXYa6IpalqpfWrywbawzUdXYebx6FbuQnTksbBLvqXTTo9DCVkVsyVNko70E5D2T6AEVI8lS6d/YsMyLA0PbSnNCy/vAoTJIYE5CgLJltvFPTngQ3khVZYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gUpEDfKx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710834111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=sTsSPri+D6Wdelir2mIVSESP1KmjuvB/LjDkRovj8pE=;
	b=gUpEDfKx2cA7200XkIVh3Xb/TR6xcVWTaNRi7kAaxtu1VM8XxKqfaQ4ozngpKQnjAdk8pQ
	Wvxfi/e4XwyB0eXHByS9Wj7P5BGumz7Kn9dGpKA1x6xSQC7U9KHJJ5kY7pyKo++USiijXY
	QH7M5PF2iBcuHEsWbMri2D8SWMju5ao=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-spoacZ1eNrml_vk8OiVDMA-1; Tue, 19 Mar 2024 03:41:49 -0400
X-MC-Unique: spoacZ1eNrml_vk8OiVDMA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33ec604d3b3so3586700f8f.1
        for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 00:41:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710834109; x=1711438909;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sTsSPri+D6Wdelir2mIVSESP1KmjuvB/LjDkRovj8pE=;
        b=v+j0+LGjyD7kkKp3Ej5FPdswRqgBoUcn6VDXAqfUZMPDfm+gfobHEPOXtaTJMgXAaK
         YH54CKzc9PTj3Ma/zxSie+BKJE36MEZxe+ZX61v7xDsXUq9yvqamupEbBhhSyhGN/mZG
         gAY+oYKSiSrQlOI5mxei73JQIn4vhWl5YpVlwFkIP4MIi0w51oGEHxeyj9HRjsSk/NgV
         q8qroqrdfT7oMZuwG0OPRUVTuWTHEpsqEEvvPDZVolS6skvpnUE3MY+IAUboKqbz571s
         UW+vG+T5qBCiuxga+VMp/jcLlCmoS6l+8blqIp1gI5rePfV7muQMjK54dFzJhy5Orq+P
         lqjg==
X-Forwarded-Encrypted: i=1; AJvYcCXnyYSWmob37fXNQ9lyT4gDIG/wqhHZG86K9vK2X7hV7TKxG4oy1caQKlcJgu8n0TvnI4Ldxi6ClZNMYqNWVwZ8aim9TvvJ
X-Gm-Message-State: AOJu0Yw07dFBTJBcaeyoLuwi2S/EwfRqOcebS/uTjZ8En86k1h2kpdNs
	AZ1oLApo8DxRsJ9e7vFjjMIUi1yrMs0P8Vqr4gjM/rjkYHTSK+cSZgRojlC7QEuAn9fOtOSJV2b
	jqjffM6pKTMcJDWxDHHtxJsJ6WKyvN54J4oGDZ1l+6Q63u4DtMvpPng==
X-Received: by 2002:a5d:4e11:0:b0:33e:7adc:516c with SMTP id p17-20020a5d4e11000000b0033e7adc516cmr10534541wrt.57.1710834108693;
        Tue, 19 Mar 2024 00:41:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAK2WGJat4vmdPSy7ECLAOOCSKt1cm0uCh7BMlmPoT49BMQqI0q9+XAAprgAMQmNyXP8ysuQ==
X-Received: by 2002:a5d:4e11:0:b0:33e:7adc:516c with SMTP id p17-20020a5d4e11000000b0033e7adc516cmr10534503wrt.57.1710834108096;
        Tue, 19 Mar 2024 00:41:48 -0700 (PDT)
Received: from redhat.com ([2.52.6.254])
        by smtp.gmail.com with ESMTPSA id t18-20020a5d42d2000000b0033e456f6e7csm11781382wrr.1.2024.03.19.00.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 00:41:47 -0700 (PDT)
Date: Tue, 19 Mar 2024 03:41:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	alex.williamson@redhat.com, andrew@daynix.com, david@redhat.com,
	dtatulea@nvidia.com, eperezma@redhat.com, feliu@nvidia.com,
	gregkh@linuxfoundation.org, jasowang@redhat.com,
	jean-philippe@linaro.org, jonah.palmer@oracle.com,
	leiyang@redhat.com, lingshan.zhu@intel.com,
	maxime.coquelin@redhat.com, mst@redhat.com, ricardo@marliere.net,
	shannon.nelson@amd.com, stable@kernel.org,
	steven.sistare@oracle.com, suzuki.poulose@arm.com,
	xuanzhuo@linux.alibaba.com, yishaih@nvidia.com
Subject: [GIT PULL] virtio: features, fixes
Message-ID: <20240319034143-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent

The following changes since commit e8f897f4afef0031fe618a8e94127a0934896aba:

  Linux 6.8 (2024-03-10 13:38:09 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 5da7137de79ca6ffae3ace77050588cdf5263d33:

  virtio_net: rename free_old_xmit_skbs to free_old_xmit (2024-03-19 03:19:22 -0400)

----------------------------------------------------------------
virtio: features, fixes

Per vq sizes in vdpa.
Info query for block devices support in vdpa.
DMA sync callbacks in vduse.

Fixes, cleanups.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Andrew Melnychenko (1):
      vhost: Added pad cleanup if vnet_hdr is not present.

David Hildenbrand (1):
      virtio: reenable config if freezing device failed

Jason Wang (2):
      virtio-net: convert rx mode setting to use workqueue
      virtio-net: add cond_resched() to the command waiting loop

Jonah Palmer (1):
      vdpa/mlx5: Allow CVQ size changes

Maxime Coquelin (1):
      vduse: implement DMA sync callbacks

Ricardo B. Marliere (2):
      vdpa: make vdpa_bus const
      virtio: make virtio_bus const

Shannon Nelson (1):
      vdpa/pds: fixes for VF vdpa flr-aer handling

Steve Sistare (2):
      vdpa_sim: reset must not run
      vdpa: skip suspend/resume ops if not DRIVER_OK

Suzuki K Poulose (1):
      virtio: uapi: Drop __packed attribute in linux/virtio_pci.h

Xuan Zhuo (3):
      virtio: packed: fix unmap leak for indirect desc table
      virtio_net: unify the code for recycling the xmit ptr
      virtio_net: rename free_old_xmit_skbs to free_old_xmit

Zhu Lingshan (20):
      vhost-vdpa: uapi to support reporting per vq size
      vDPA: introduce get_vq_size to vdpa_config_ops
      vDPA/ifcvf: implement vdpa_config_ops.get_vq_size
      vp_vdpa: implement vdpa_config_ops.get_vq_size
      eni_vdpa: implement vdpa_config_ops.get_vq_size
      vdpa_sim: implement vdpa_config_ops.get_vq_size for vDPA simulator
      vduse: implement vdpa_config_ops.get_vq_size for vduse
      virtio_vdpa: create vqs with the actual size
      vDPA/ifcvf: get_max_vq_size to return max size
      vDPA/ifcvf: implement vdpa_config_ops.get_vq_num_min
      vDPA: report virtio-block capacity to user space
      vDPA: report virtio-block max segment size to user space
      vDPA: report virtio-block block-size to user space
      vDPA: report virtio-block max segments in a request to user space
      vDPA: report virtio-block MQ info to user space
      vDPA: report virtio-block topology info to user space
      vDPA: report virtio-block discarding configuration to user space
      vDPA: report virtio-block write zeroes configuration to user space
      vDPA: report virtio-block read-only info to user space
      vDPA: report virtio-blk flush info to user space

 drivers/net/virtio_net.c             | 151 +++++++++++++++---------
 drivers/vdpa/alibaba/eni_vdpa.c      |   8 ++
 drivers/vdpa/ifcvf/ifcvf_base.c      |  11 +-
 drivers/vdpa/ifcvf/ifcvf_base.h      |   2 +
 drivers/vdpa/ifcvf/ifcvf_main.c      |  15 +++
 drivers/vdpa/mlx5/net/mlx5_vnet.c    |  13 ++-
 drivers/vdpa/pds/aux_drv.c           |   2 +-
 drivers/vdpa/pds/vdpa_dev.c          |  20 +++-
 drivers/vdpa/pds/vdpa_dev.h          |   1 +
 drivers/vdpa/vdpa.c                  | 214 ++++++++++++++++++++++++++++++++++-
 drivers/vdpa/vdpa_sim/vdpa_sim.c     |  15 ++-
 drivers/vdpa/vdpa_user/iova_domain.c |  27 ++++-
 drivers/vdpa/vdpa_user/iova_domain.h |   8 ++
 drivers/vdpa/vdpa_user/vduse_dev.c   |  34 ++++++
 drivers/vdpa/virtio_pci/vp_vdpa.c    |   8 ++
 drivers/vhost/net.c                  |   3 +
 drivers/vhost/vdpa.c                 |  14 +++
 drivers/virtio/virtio.c              |   6 +-
 drivers/virtio/virtio_ring.c         |   6 +-
 drivers/virtio/virtio_vdpa.c         |   5 +-
 include/linux/vdpa.h                 |   6 +
 include/uapi/linux/vdpa.h            |  17 +++
 include/uapi/linux/vhost.h           |   7 ++
 include/uapi/linux/virtio_pci.h      |  10 +-
 24 files changed, 521 insertions(+), 82 deletions(-)


