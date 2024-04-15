Return-Path: <netdev+bounces-87984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF6C8A51D7
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 15:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F13EB1C21AC3
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 13:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE6174421;
	Mon, 15 Apr 2024 13:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rDm8k3tq"
X-Original-To: netdev@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3C37317C
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 13:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713188296; cv=none; b=gTNl1GesaL1s4fyJ12YgOUY+O6y8SuvDZTDJ8eoSLE6djvFM15aJPPjF2l3QNxJw+HxAcD07t0yID7JxNps0dY4lp0M84OHyBgZU8sOHL8T++EngeOtAEKj3IaVpJx3l0HJREHOCIDVUfMJMKV4sReNpAwJakLHd/fxy+9drJ9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713188296; c=relaxed/simple;
	bh=/d7SjLufAQYsTDwWiGfZ1o7V3HHcOo3FsxfQLwOlhTc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LyK6RYF1K7LUCqlNMdsmLk4XSK8Xv0Ey2cq+Pleefu8KRbmTsPkQcOGReB0MD5rNMkZGcHZs3nnBL2DGZrSBTejAHRXOTZagXqOWLzIDbOj+7Wg3OZ9xQxmgJbxkWw5iXJp8zBI0tSymz+s/bAMrxLGhkI/qHfteJiWLCsKo6cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rDm8k3tq; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713188288; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=UtZX1IVwmOAZ6ZRj7d+cgmeMsf+v3RERAAt01/sNS8A=;
	b=rDm8k3tqnejk8e2PtYEXA4xpjG6Y7+iBXKJPZ1xPSMRtKnYw//3RCuBcr2RYabQ++Vll4rTgoerLeNV7SKUJ3buVyqWoQoV8WzpaGusaaSU9WEepHMNO341vM9kUI+fwADyOypOajO8rvqeSzcYEN3f/SaE9UyGqgb9lDzWYxXs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W4diK3k_1713188287;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W4diK3k_1713188287)
          by smtp.aliyun-inc.com;
          Mon, 15 Apr 2024 21:38:08 +0800
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
Subject: [PATCH RESEND net-next v7 0/4] ethtool: provide the dim profile fine-tuning channel
Date: Mon, 15 Apr 2024 21:38:03 +0800
Message-Id: <20240415133807.116394-1-hengqi@linux.alibaba.com>
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
 net/ethtool/coalesce.c                       | 201 ++++++++++++++++++-
 10 files changed, 430 insertions(+), 23 deletions(-)

-- 
2.32.0.3.g01195cf9f


