Return-Path: <netdev+bounces-229479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7791BBDCD60
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 09:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 358033E0185
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 07:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238C8311941;
	Wed, 15 Oct 2025 07:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="m7sBQsCH"
X-Original-To: netdev@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803782BDC34
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 07:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760512312; cv=none; b=NGA3tXki59GsDBuyt1qptLChFpvMeYqSaLaVUz+9WLvRmPVykdJQchCIXvgMTVnex6KqEuMtMGh44PJTNaE+KJ79ypDaWI+TcuLAJLWNlMw7yDXyW09WtVE5AqLbjw3SMgq1w0Lw4VyJaYbVqVVb4vXq5NesAleOAWMBZ5JU5Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760512312; c=relaxed/simple;
	bh=R7UG4RHzg6L4h/qHmm6RhK5ik2qcPCP/Wn9r1WyAbiY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Wq940KQ1NDfkwcQLJ0HrdRz3IqLQUTgR7FRI5f272TtF3hjOlE5kxtFHCw4HD1euZRRfxh6hhWw9H1P2sr74soSUyKVCs55JBFKHjQsaKaMQhl2KnlnLh9Yf/3oSSLlVROv5KqJ4BYv96x5EVDFxTdGuE+SXR5igR7c1zNlAka4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=m7sBQsCH; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760512307; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=wo7XeaFSgKrH6hdp3xAOmseboJ82BLVa7EKGjzi7W2g=;
	b=m7sBQsCHPXu0G4Fd94rEn854wwlES8HRlK0NAqVtOl93QM+M9+4oJ68nbITtckAlb0rBOjBPPg/B6q/YKOJzbCmkPYmMsjBhhOq+HLN4GDNpXhyIWScRsQwu+5Y5oDTLMhYiqhfazuVLS5Umv7x8fduduONo4wujBP6TiHDOgmA=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WqFOTns_1760512305 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 15 Oct 2025 15:11:45 +0800
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
Subject: [PATCH net-next v6 0/5] eea: Add basic driver framework for Alibaba Elastic Ethernet Adaptor
Date: Wed, 15 Oct 2025 15:11:40 +0800
Message-Id: <20251015071145.63774-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: a1c6aa4df11e
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
 drivers/net/ethernet/alibaba/eea/eea_adminq.c | 445 ++++++++++
 drivers/net/ethernet/alibaba/eea/eea_adminq.h |  70 ++
 drivers/net/ethernet/alibaba/eea/eea_desc.h   | 156 ++++
 .../net/ethernet/alibaba/eea/eea_ethtool.c    | 311 +++++++
 .../net/ethernet/alibaba/eea/eea_ethtool.h    |  51 ++
 drivers/net/ethernet/alibaba/eea/eea_net.c    | 575 +++++++++++++
 drivers/net/ethernet/alibaba/eea/eea_net.h    | 196 +++++
 drivers/net/ethernet/alibaba/eea/eea_pci.c    | 575 +++++++++++++
 drivers/net/ethernet/alibaba/eea/eea_pci.h    |  68 ++
 drivers/net/ethernet/alibaba/eea/eea_ring.c   | 260 ++++++
 drivers/net/ethernet/alibaba/eea/eea_ring.h   |  91 ++
 drivers/net/ethernet/alibaba/eea/eea_rx.c     | 782 ++++++++++++++++++
 drivers/net/ethernet/alibaba/eea/eea_tx.c     | 406 +++++++++
 19 files changed, 4039 insertions(+)
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


