Return-Path: <netdev+bounces-233811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2057C18D58
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 09:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57EDB3A5088
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 08:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D2A3112C9;
	Wed, 29 Oct 2025 08:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SRm2DzsK"
X-Original-To: netdev@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACEF17B425
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 08:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761724913; cv=none; b=RrOWnNi+Xxmssh8QjjHI/ammJU7bzrGFqciYu8xe8G/kXAAG1NefDNtsb34amKMCpK6KiRnxRy9LBiy1q/8U7lRKH+cWUzvobxVVDhTCO0wtugPABNO8rGU70oi+gvjFbyaNlOD31l3/efTbcLoCZh6dnDYzcvRzWpQy7+QynM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761724913; c=relaxed/simple;
	bh=XblybcRGIo+MaPiIPUFDsXB2l+NrAJUe0y9bGK4EbMI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LYvzWd4C/g5+woyuKHgw1VGBwxR7eZrXC2XiB+ckkE30WQObo117weeiiigfPqV7fwFJQVsmK7iqjDWQaLZ7uhb0rVpcHINn31KtYWPhMnhreEnq6ZNVOZ2L902ARQgDOfNxA+x6QetOzsYMbjY5KRoeAYq8lCDAjNOjpSv/y+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SRm2DzsK; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761724907; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=w1hOBYBW90TJHltUMB8LG0JU06v8v9HWLD6W9v9CSUc=;
	b=SRm2DzsKuHGhAlsBg79mvvxqll76stGAvYjSpX9HVzJEw3gvWNRrHCW3nhEaqynj5S9sG9Hp74vjrf2AXyKjnHdqtJ0MlBuE5aGm/uDQ9LrgpkMODIf8VR3E46IGGJ0DZ0K6cnBUWU/uAn+jeOPTCZZZu2K8aMAqI3vYd2shV94=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WrF3g1Z_1761724905 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 29 Oct 2025 16:01:46 +0800
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
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Dust Li <dust.li@linux.alibaba.com>
Subject: [PATCH net-next v9 0/5] eea: Add basic driver framework for Alibaba Elastic Ethernet Adaptor
Date: Wed, 29 Oct 2025 16:01:40 +0800
Message-Id: <20251029080145.18967-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 4becde0aa50f
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
 drivers/net/ethernet/alibaba/Kconfig          |  29 +
 drivers/net/ethernet/alibaba/Makefile         |   5 +
 drivers/net/ethernet/alibaba/eea/Makefile     |   9 +
 drivers/net/ethernet/alibaba/eea/eea_adminq.c | 421 ++++++++++
 drivers/net/ethernet/alibaba/eea/eea_adminq.h |  70 ++
 drivers/net/ethernet/alibaba/eea/eea_desc.h   | 156 ++++
 .../net/ethernet/alibaba/eea/eea_ethtool.c    | 276 ++++++
 .../net/ethernet/alibaba/eea/eea_ethtool.h    |  50 ++
 drivers/net/ethernet/alibaba/eea/eea_net.c    | 572 +++++++++++++
 drivers/net/ethernet/alibaba/eea/eea_net.h    | 196 +++++
 drivers/net/ethernet/alibaba/eea/eea_pci.c    | 587 +++++++++++++
 drivers/net/ethernet/alibaba/eea/eea_pci.h    |  67 ++
 drivers/net/ethernet/alibaba/eea/eea_ring.c   | 260 ++++++
 drivers/net/ethernet/alibaba/eea/eea_ring.h   |  91 ++
 drivers/net/ethernet/alibaba/eea/eea_rx.c     | 786 ++++++++++++++++++
 drivers/net/ethernet/alibaba/eea/eea_tx.c     | 402 +++++++++
 19 files changed, 3987 insertions(+)
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


