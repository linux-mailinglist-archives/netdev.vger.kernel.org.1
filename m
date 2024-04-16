Return-Path: <netdev+bounces-88320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4338A6AE9
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 14:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 366D22827C0
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 12:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133DD12AAE7;
	Tue, 16 Apr 2024 12:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cLlZabpm"
X-Original-To: netdev@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FBB12A174
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 12:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713270601; cv=none; b=b23ZbD5cMBvhEThR8WYXiBICT+y6kuku+MgtudK4dkEZTFDgPLr4q0Akfg4X56hQKDV/cTWk8mHJSNWGA4sHvKbpOPGs/s1h+JftwhdDQGti29Memwy8ZODGx/tcO85+r1R7isxI00NAPRdAaPeBjimLxpNrebfjN6cBZthHt9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713270601; c=relaxed/simple;
	bh=igMVutYknCm9HQn0kQlIsiRjq47Q6Vt14SrBusczgtY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kQsr5rSmbQJrgaGbJqtGaBIcTsNB4x110eGQUNWVnTp/oaa6B8h2xNy2y5dH15zR0wBqT9EWsLubIYKHb1Bi9D+RNGZ/xrt1Y7tRSKSBLSJyJ5Qlt0zdgaMBfoIQKhrAGNAFduBaIfqj9IVnUINEK5MbygVrImJovhEww+73bxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cLlZabpm; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713270592; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=6/M3uDkkyCQY7v9K+P8tk68/kNvr5ZetrTGnwrGJpZc=;
	b=cLlZabpmFwKTdGB9HF8oWA1bJ7k870iFdA/V9cJoBPddqPqEuDtczltPjhL4eS9zgia8+7fKMiC0XqcR3UyBJsswW1fiLITrB9pedv6DpDFa7vTW1LukRdxZCTL04EYvCHwTMM3ar/mtZny6LIaZToHdmwbr3uJRMnnNqEiWecY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W4i1swV_1713270590;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W4i1swV_1713270590)
          by smtp.aliyun-inc.com;
          Tue, 16 Apr 2024 20:29:51 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Brett Creeley <bcreeley@amd.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH net-next v8 0/4] ethtool: provide the dim profile fine-tuning channel
Date: Tue, 16 Apr 2024 20:29:46 +0800
Message-Id: <20240416122950.39046-1-hengqi@linux.alibaba.com>
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
v7->v8:
  - Use kmemdup() instead of kzalloc()/memcpy() in dev_dim_profile_init().

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
 net/core/dev.c                               |  79 ++++++++
 net/ethtool/coalesce.c                       | 201 ++++++++++++++++++-
 10 files changed, 426 insertions(+), 23 deletions(-)

-- 
2.32.0.3.g01195cf9f


