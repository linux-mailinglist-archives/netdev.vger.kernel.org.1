Return-Path: <netdev+bounces-87820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA08D8A4B96
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 11:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06CFD1C21A63
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 09:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BE53FE55;
	Mon, 15 Apr 2024 09:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="i6GjpG+o"
X-Original-To: netdev@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1F81DFEA
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 09:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713173806; cv=none; b=tKLPQNt0Js4CEamEsTNuTrZihS8Ak+hcuLudPfRYhPR4UjqWvIpGfWs2gS4fIKG4NA4cD0TqVq+7S7ZQZhDp8HM4YuYV/CJmlFApKtXoEdyvP3Vssc/hiIRhkfr3axsK9y+irRjwXb7QKn+Qgvg/tqquINxcTyFeu3Kgb+NR8zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713173806; c=relaxed/simple;
	bh=5Yzv3qGllVzU8xSm4lQxrtCfJYSGysQYYI1td38Ioxo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SUal0EbPidI3W++lbH3vSWQCCUSRK0EcYYkdusll1EvKJacssbXlPeOcTCOJA+lMTP6AahEbjmNrrKRwG7RkLdZRbJZOopusxj0ztZOdaYF+WqMC5vGnTXHVAI1E14jAV3dZdA7z5b4QNXfD4gZRghGowa+Zapjtb0mn25Bn1bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=i6GjpG+o; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713173800; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=bEPYWn7iwonfHnMr95kZIKmNFgZ/gqLh7TCiNeJY2Mg=;
	b=i6GjpG+ouf39EI4Ts+YjWTPo+wCQPGMqk/nvLG8mYaBtrN3cclAmghnCGDnxxjLuv9Xm57d61Q/YOSqQ0eBGM9DyQ3bSswvpV49Ggv9HsBLVnQI0LDQWJNTKGdASueJp7wGiq03MyW6xnW+2jlXqJ++l7HcTuDlPktSX1fIepNY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W4Zb5Q4_1713173799;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W4Zb5Q4_1713173799)
          by smtp.aliyun-inc.com;
          Mon, 15 Apr 2024 17:36:40 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Brett Creeley <bcreeley@amd.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH net-next v7 0/4] ethtool: provide the dim profile fine-tuning channel
Date: Mon, 15 Apr 2024 17:36:34 +0800
Message-Id: <20240415093638.123962-1-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The NetDIM library provides excellent acceleration for many modern
network cards. However, the default profiles of DIM limits its maximum
capabilities for different NICs, so providing a way which the NIC can
be custom configured is necessary.

Currently, interaction with the driver is still based on the commonly
used "ethtool -C".

Since the profile now exists in netdevice, adding a function similar
to net_dim_get_rx_moderation_dev() with netdevice as argument is
nice, but this would be better along with cleaning up the rest of
the drivers, which we can get to very soon after this set.

Please review, thank you very much!

Changelog
=====
v6->v7:
  - A new wrapper struct pointer is used in struct net_device.
  - Add IS_ENABLED(CONFIG_DIMLIB) to avoid compiler warnings.
  - Profile fields changed from u16 to u32.

v5->v6:
  - Place the profile in netdevice to bypass the driver.
    The interaction code of ethtool <-> kernel has not changed at all,
    only the interaction part of kernel <-> driver has changed.

v4->v5:
  - Update some snippets from Kuba, Thanks.

v3->v4:
  - Some tiny updates and patch 1 only add a new comment.

v2->v3:
  - Break up the attributes to avoid the use of raw c structs.
  - Use per-device profile instead of global profile in the driver.

v1->v2:
  - Use ethtool tool instead of net-sysfs

Heng Qi (4):
  linux/dim: move useful macros to .h file
  ethtool: provide customized dim profile management
  virtio-net: refactor dim initialization/destruction
  virtio-net: support dim profile fine-tuning

 Documentation/netlink/specs/ethtool.yaml     |  33 +++
 Documentation/networking/ethtool-netlink.rst |   8 +
 drivers/net/virtio_net.c                     |  46 +++--
 include/linux/dim.h                          |  13 ++
 include/linux/ethtool.h                      |  11 +-
 include/linux/netdevice.h                    |  24 +++
 include/uapi/linux/ethtool_netlink.h         |  24 +++
 lib/dim/net_dim.c                            |  10 +-
 net/core/dev.c                               |  83 ++++++++
 net/ethtool/coalesce.c                       | 199 ++++++++++++++++++-
 10 files changed, 428 insertions(+), 23 deletions(-)

-- 
2.32.0.3.g01195cf9f


