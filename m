Return-Path: <netdev+bounces-93413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1A18BB99C
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 08:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 269D11C21326
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 06:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C46AD23;
	Sat,  4 May 2024 06:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mhqOTB8X"
X-Original-To: netdev@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330123224;
	Sat,  4 May 2024 06:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714805101; cv=none; b=JyQs31EmpOFwR+3RHPQZyIzpsjZ3wk6JhRmqN2i7KGDVT/Bm1pcUtjgzlyc9ZHM/kOzvtsEv97+wQSl6LmCvy7RbicqiHkZM86xxX46Y650BZv5Zkr5JSZk7ezJNZFs5Kga0jI5ZkSB7YoXzuIkHfe6nYf5FUul30MAnn+Ip/HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714805101; c=relaxed/simple;
	bh=XK/LzD9QGd0d/XpFhsj67Zn7IxSCSyuGiEKILq+bIKo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AEAqYz8luNhGOWzcl9hsXsJGEt8E+7RFHeKLCwfRW/xI0XdSz7YdSilp04a9qTTq+3TnkPinhkvq5ikUOCkYK3dNA+wKYy0K7d5Q7I7IHAi5GqDX5+pAFqX2txndrPmXYJHW2jyWiqmo+WstotIinh0YlRoKllCfwvvW/65CvAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mhqOTB8X; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714805090; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=1lKeS9KT2ksAHAheLFS39PvMyyk8+1ivNXI8uQdU1IE=;
	b=mhqOTB8X2lWleNcITPOE+wBnKnYEmvSsgVyll0m6Ad8nKwcC0zk8UsSie8h7BOU6nviq7cerHe+HViwaJcMq9xL0VTPeLRdmEzOLilQWnUFIqHvSac6CcANGZ6IDueWm7bAm2PmVgtO0+6fccP9AxDvjhxfkdPn9RwNrsWSeMJ0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0W5luwrS_1714805087;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W5luwrS_1714805087)
          by smtp.aliyun-inc.com;
          Sat, 04 May 2024 14:44:48 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Brett Creeley <bcreeley@amd.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Tal Gilboa <talgi@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	justinstitt@google.com,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v12 0/4] ethtool: provide the dim profile fine-tuning channel
Date: Sat,  4 May 2024 14:44:43 +0800
Message-Id: <20240504064447.129622-1-hengqi@linux.alibaba.com>
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

Currently, the way is based on the commonly used "ethtool -C".

Please review, thank you very much!

Changelog
=====
v11->v12:
  - Remove the use of IS_ENABLED(DIMLIB).
  - Update Simon's htmldoc hint.

v10->v11:
  - Fix and clean up some issues from Kuba, thanks.
  - Rebase net-next/main

v9->v10:
  - Collect dim related flags/mode/work into one place.
  - Use rx_profile + tx_profile instead of four profiles.
  - Add several helps.
  - Update commit logs.

v8->v9:
  - Fix the compilation error of conflicting names of rx_profile in
    dim.h and ice driver: in dim.h, rx_profile is replaced with
    dim_rx_profile. So does tx_profile.

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
  - Update some snippets from Kuba.

v3->v4:
  - Some tiny updates and patch 1 only add a new comment.

v2->v3:
  - Break up the attributes to avoid the use of raw c structs.
  - Use per-device profile instead of global profile in the driver.

v1->v2:
  - Use ethtool tool instead of net-sysfs.

Heng Qi (4):
  linux/dim: move useful macros to .h file
  ethtool: provide customized dim profile management
  dim: add new interfaces for initialization and getting results
  virtio-net: support dim profile fine-tuning

 Documentation/netlink/specs/ethtool.yaml     |  31 +++
 Documentation/networking/ethtool-netlink.rst |   4 +
 drivers/net/virtio_net.c                     |  47 +++-
 include/linux/dim.h                          | 114 ++++++++
 include/linux/ethtool.h                      |   4 +-
 include/linux/netdevice.h                    |   3 +
 include/uapi/linux/ethtool_netlink.h         |  22 ++
 lib/dim/net_dim.c                            | 145 ++++++++++-
 net/ethtool/coalesce.c                       | 259 ++++++++++++++++++-
 9 files changed, 613 insertions(+), 16 deletions(-)

-- 
2.32.0.3.g01195cf9f


