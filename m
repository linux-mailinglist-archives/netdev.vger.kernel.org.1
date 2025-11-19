Return-Path: <netdev+bounces-239819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6360FC6CA2C
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 04:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 6CD662AA95
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 03:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DC42D7DEB;
	Wed, 19 Nov 2025 03:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LYxG36TT"
X-Original-To: netdev@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E706A1369B4
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 03:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763523631; cv=none; b=XuLJKB+dt5I8NNMu9T/oGjzCxiOjBNmqhFe41PaFRMo3Jg50M6rUGoONl526euqODed5H2wgaw4Y3exuRDHkk+LD2zKsSFNFPIXWWYlLgK4Zrvvyc8KO0otOWR1546XqrEnmRcJX1rTB1XN/kqNA2/J1n6EPGQsRYcgKSojjLTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763523631; c=relaxed/simple;
	bh=CNDXFIp6125F3LTAUJjNo51J7ewJDBRhevrvY1uSXv8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F19sbP2iClkuIjo+R9OAFKZ7+RJBR+N4g90nuEV9rOjb7oTgbNGNs0kUds7QBoygZ3Q7xyWkmte3Y/lOCKE6NFyykVNkNtPMnRy01HzyqltJc3WhHserdBQEO6isIcBlIaCzhTVuU0kOzz00FSdKknhW1Hc8/B5bWqTDrbFYt2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LYxG36TT; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763523620; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=5MZcM/3+8izv1m4P+QsBU8F55b3nV9HHpe34RiHGPMU=;
	b=LYxG36TTYZO80jKysMCfNipgHNW6yn4mlXhMztbRd1XAkga8hsQ8WrCuHnFARXyWkJgEO/sYqOw58rrPx0IrBQ8mMw5kxvmFD2Ix9pfWjivWP5oMeHKfbDO7HqMWXcU5vvgrT9j78hLeriZD8uKn6P2CmzkQEtxCRCr02En7iGo=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Wsmfoqx_1763523618 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 19 Nov 2025 11:40:19 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Philo Lu <lulie@linux.alibaba.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Dong Yibo <dong100@mucse.com>,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	MD Danish Anwar <danishanwar@ti.com>,
	Dust Li <dust.li@linux.alibaba.com>
Subject: [PATCH net-next v15 0/5] eea: Add basic driver framework for Alibaba Elastic Ethernet Adaptor
Date: Wed, 19 Nov 2025 11:40:13 +0800
Message-Id: <20251119034018.44673-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 905f312d8164
Content-Transfer-Encoding: 8bit

Add a driver framework for EEA that will be available in the future.

This driver is currently quite minimal, implementing only fundamental
core functionalities. Key features include: I/O queue management via
adminq, basic PCI-layer operations, and essential RX/TX data
communication capabilities. It also supports the creation,
initialization, and management of network devices (netdev). Furthermore,
the ring structures for both I/O queues and adminq have been abstracted
into a simple, unified, and reusable library implementation,
facilitating future extension and maintenance.

v15:
    1. remove 'default m' from eea kconfig
    2. free the resources when open failed.

v14:
    1. some tiny fixes

v13:
    1. fix some tiny fixes @Simon

v12:
    I encountered some issues with sending the v11 patches, as they were quite
    messy. Therefore, I'm resending them as v12.

v11:
    1. remove auto clean __free(kfree)
    2. some tiny fixes

v10:
    1. name the jump labels after the target @Jakub
    2. rm __GFP_ZERO from dma_alloc_coherent @Jakub
v9:
    1. some fixes for ethtool from http://lore.kernel.org/all/20251027183754.52fe2a2c@kernel.org

v8: 1. rename eea_net_tmp to eea_net_init_ctx
    2. rm code that allocs memory to destroy queues
    3. some other minor changes

v7: 1. remove the irrelative code from ethtool commit
    2. build every commits with W12

v6: Split the big one commit to five commits
v5: Thanks for the comments from Kalesh Anakkur Purayil, ALOK TIWARI
v4: Thanks for the comments from Troy Mitchell, Przemek Kitszel, Andrew Lunn, Kalesh Anakkur Purayil
v3: Thanks for the comments from Paolo Abenchi
v2: Thanks for the comments from Simon Horman and Andrew Lunn
v1: Thanks for the comments from Simon Horman and Andrew Lunn










Xuan Zhuo (5):
  eea: introduce PCI framework
  eea: introduce ring and descriptor structures
  eea: probe the netdevice and create adminq
  eea: create/destroy rx,tx queues for netdevice open and stop
  eea: introduce ethtool support

 MAINTAINERS                                   |   8 +
 drivers/net/ethernet/Kconfig                  |   1 +
 drivers/net/ethernet/Makefile                 |   1 +
 drivers/net/ethernet/alibaba/Kconfig          |  28 +
 drivers/net/ethernet/alibaba/Makefile         |   5 +
 drivers/net/ethernet/alibaba/eea/Makefile     |   9 +
 drivers/net/ethernet/alibaba/eea/eea_adminq.c | 421 ++++++++++
 drivers/net/ethernet/alibaba/eea/eea_adminq.h |  70 ++
 drivers/net/ethernet/alibaba/eea/eea_desc.h   | 156 ++++
 .../net/ethernet/alibaba/eea/eea_ethtool.c    | 276 ++++++
 .../net/ethernet/alibaba/eea/eea_ethtool.h    |  50 ++
 drivers/net/ethernet/alibaba/eea/eea_net.c    | 589 +++++++++++++
 drivers/net/ethernet/alibaba/eea/eea_net.h    | 196 +++++
 drivers/net/ethernet/alibaba/eea/eea_pci.c    | 585 +++++++++++++
 drivers/net/ethernet/alibaba/eea/eea_pci.h    |  67 ++
 drivers/net/ethernet/alibaba/eea/eea_ring.c   | 260 ++++++
 drivers/net/ethernet/alibaba/eea/eea_ring.h   |  91 ++
 drivers/net/ethernet/alibaba/eea/eea_rx.c     | 787 ++++++++++++++++++
 drivers/net/ethernet/alibaba/eea/eea_tx.c     | 402 +++++++++
 19 files changed, 4002 insertions(+)
 create mode 100644 drivers/net/ethernet/alibaba/Kconfig
 create mode 100644 drivers/net/ethernet/alibaba/Makefile
 create mode 100644 drivers/net/ethernet/alibaba/eea/Makefile
 create mode 100644 drivers/net/ethernet/alibaba/eea/eea_adminq.c
 create mode 100644 drivers/net/ethernet/alibaba/eea/eea_adminq.h
 create mode 100644 drivers/net/ethernet/alibaba/eea/eea_desc.h
 create mode 100644 drivers/net/ethernet/alibaba/eea/eea_ethtool.c
 create mode 100644 drivers/net/ethernet/alibaba/eea/eea_ethtool.h
 create mode 100644 drivers/net/ethernet/alibaba/eea/eea_net.c
 create mode 100644 drivers/net/ethernet/alibaba/eea/eea_net.h
 create mode 100644 drivers/net/ethernet/alibaba/eea/eea_pci.c
 create mode 100644 drivers/net/ethernet/alibaba/eea/eea_pci.h
 create mode 100644 drivers/net/ethernet/alibaba/eea/eea_ring.c
 create mode 100644 drivers/net/ethernet/alibaba/eea/eea_ring.h
 create mode 100644 drivers/net/ethernet/alibaba/eea/eea_rx.c
 create mode 100644 drivers/net/ethernet/alibaba/eea/eea_tx.c

--
2.32.0.3.g01195cf9f


