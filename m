Return-Path: <netdev+bounces-91390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 885BB8B26FE
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 19:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 445FB285444
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 16:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB4914D6F1;
	Thu, 25 Apr 2024 16:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="l93QHUo0"
X-Original-To: netdev@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74520131746;
	Thu, 25 Apr 2024 16:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714064397; cv=none; b=okEOkV3g6JP6zRpQIpHyLjsILyoY5HwP2F8+bWs3Znpea9toCTpTrqlGkqlJsWNiv2cfGzc1TLjfluyX4ctHYrkv8Q7Obj4Evrk4pKJIdkWrNDupt2OsgT20wYDIAHCe7fXizP7R3dGfMbh4ZbkC9Hf1Neuq60e0mLiOFXgQVIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714064397; c=relaxed/simple;
	bh=tljCbHvoaAGa+RNcP5k2kx2RNznl7sh37CaasUR51Qg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HQ1O9wURPpmc7J90FHxF1l4asmuUNDghXLZJ44d0yAIp11NMmXaUt/y7R6Xl3/qjCjIcDiEH7N1IG2WGtVyXVy/dcVxLUOfyfI/ctomcylbOk49ygBWcZnszk/bM6OkdsBsoZ/XUNbyAFb3klEu9WnwPe21FcsPTXrUJ4C4mzzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=l93QHUo0; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714064392; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=tbL/Dt24rw8UqlcGmfYlc+JaGppN9NltZdWAzZ1Pu8k=;
	b=l93QHUo0y2GNZnGtXV26tocEp3Go/CcKXmdejJdjKHLebzAevT2p1PBKcXWCnj3flsIymJR2Tz39fA8nvFuG8yvcUkSYlW/lClo6N2DvC0dswDjcK4GwnUwOf8Cys50WUZwaI7VYgLLOEhkRi6gEBigI1eoE7RDiP8mFcxzXfa0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R351e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0W5G09nb_1714064388;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W5G09nb_1714064388)
          by smtp.aliyun-inc.com;
          Fri, 26 Apr 2024 00:59:50 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
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
	"justinstitt @ google . com" <justinstitt@google.com>
Subject: [PATCH net-next v10 0/4] ethtool: provide the dim profile fine-tuning channel
Date: Fri, 26 Apr 2024 00:59:44 +0800
Message-Id: <20240425165948.111269-1-hengqi@linux.alibaba.com>
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
  dim: add new interfaces for initialization and getting results
  virtio-net: support dim profile fine-tuning

 Documentation/netlink/specs/ethtool.yaml     |  23 ++
 Documentation/networking/ethtool-netlink.rst |   4 +
 drivers/net/virtio_net.c                     |  44 +++-
 include/linux/dim.h                          | 115 ++++++++
 include/linux/ethtool.h                      |   7 +-
 include/linux/netdevice.h                    |   5 +
 include/uapi/linux/ethtool_netlink.h         |  20 ++
 lib/dim/net_dim.c                            | 139 ++++++++++
 net/ethtool/coalesce.c                       | 264 ++++++++++++++++++-
 9 files changed, 612 insertions(+), 9 deletions(-)

-- 
2.32.0.3.g01195cf9f


