Return-Path: <netdev+bounces-87049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35ECC8A16D7
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 16:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9B6F1F21176
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 14:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8447C14F10B;
	Thu, 11 Apr 2024 14:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RkWCBXnF"
X-Original-To: netdev@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DC714EC4A
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 14:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712844763; cv=none; b=lP5/Id0EaIpOiFQfmd9Hjw0m3NR70FmgRXtGHe2LkA1kuvF6popuek09vV271lDq/iYeuMhc+1mHKTIP2MV7GZIWXOAFhbqRyEVM18YWTBQ4fJlq17BlVyyabH51/yFtOJCZpu/dbor5S4lmkhiPEp7s1cM8ofkAP/mOVNrhy8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712844763; c=relaxed/simple;
	bh=gTVApN1Qfdpss3RHztY0NATJigY2s5M/5K8I5UU1onw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Ty06nnroK0aMgN2sPrH9RKTDrTfpnQFFEa4gy4zAoyioDD2x2TlII7gn8BBnXgPI/Q9gHOBw1L62/S4mN6yuKJHBzeDVtOUkiRofkASjS/vJAWfT5FdUSMXe5f3FrU+YA4sqG7LlaAM7Xl9PKcHl7YcMy4slbOQ8ETZsZOktzgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RkWCBXnF; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712844753; h=From:To:Subject:Date:Message-Id;
	bh=p1eu6Dh2dhG2C9YSG0A3GrQUPqlg4q55WJ+XLJP6+GA=;
	b=RkWCBXnFcFQYphGz/fwQB7+WimvgH+L73WH8K3+xzb/ZcR3d+JpCQRXcJXDShGzkfBp77elkNu7wJd8Atp4nVhbLNQHw1barKmOkpXoGszW65+sQppSFWmVqIWUGlOGCht26v0Ia6kOzzn24u8T939wX5ECtqQiq4/7huGEoNvs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W4LV1H2_1712844751;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W4LV1H2_1712844751)
          by smtp.aliyun-inc.com;
          Thu, 11 Apr 2024 22:12:32 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH net-next v6 0/4] ethtool: provide the dim profile fine-tuning channel
Date: Thu, 11 Apr 2024 22:12:27 +0800
Message-Id: <1712844751-53514-1-git-send-email-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

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

V1 link:
https://lore.kernel.org/all/1710421773-61277-1-git-send-email-hengqi@linux.alibaba.com/#r

Heng Qi (4):
  linux/dim: move useful macros to .h file
  ethtool: provide customized dim profile management
  virtio-net: refactor dim initialization/destruction
  virtio-net: support dim profile fine-tuning

 Documentation/netlink/specs/ethtool.yaml     |  33 +++++
 Documentation/networking/ethtool-netlink.rst |   8 ++
 drivers/net/virtio_net.c                     |  45 +++++--
 include/linux/dim.h                          |  13 ++
 include/linux/ethtool.h                      |  12 +-
 include/linux/netdevice.h                    |  15 +++
 include/uapi/linux/ethtool_netlink.h         |  24 ++++
 lib/dim/net_dim.c                            |  10 +-
 net/core/dev.c                               |  63 +++++++++
 net/ethtool/coalesce.c                       | 184 ++++++++++++++++++++++++++-
 10 files changed, 383 insertions(+), 24 deletions(-)

-- 
1.8.3.1


