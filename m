Return-Path: <netdev+bounces-254102-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KP3tCkukeWlMyQEAu9opvQ
	(envelope-from <netdev+bounces-254102-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 06:53:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFDD9D424
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 06:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DB45300F5F7
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 05:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E5D32E128;
	Wed, 28 Jan 2026 05:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="eYqf4f8O"
X-Original-To: netdev@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880412C11D3
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 05:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769579563; cv=none; b=C1Y/ADYcXUFReLRsGXekAXoSe0B3zyGYC7a+xsrLJ83B8M/8th3bb3zNm5iJ00ammaSdoT8eo+C9ck/1dlXiOf2UKbZSaBh1NsyF4f8TUNWQlsPI65XJifV9fIRSYgD1Ur53OXvxqxZJhUyGeGhd8WyblEQVuz826IsCEinuo0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769579563; c=relaxed/simple;
	bh=yMLGfisA/PlHf3ZgwCJS2ThWhdkP9x/Y/yAl0DkHW0U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hISOyinKbSZ0t0Z/qEcxpQO30+Tola5shx0ybjtUHQcIgGxHb2yoO5h/YFgQA4aymkrL1IPghbxBYPQVRUE7PWgQFW6D0x8PY/zV8W8Dl1UiZwsqRn1F8emmHbakmjRcNAwhZxAf7EcP5puQOJTrF1mmkfAPIPphLS1YD1/9XGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=eYqf4f8O; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769579553; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=b+Jm2RyAoPnY6e13OQxbGeaYzz+tQafQfRcD9DbIfJ8=;
	b=eYqf4f8Ofp1I6/UNXeLDO8ytw543c2jekc9oEbWD/Tm/fuEn9nxI1c2Zm2PQOn2CSgeWo20IqrWQZR11XjiOehSnmB/YmiEiZ1SRZoLQRGVBMhnsiJhWQn/aLsq+kybMxYQdN4UE04hzy+FvLZmWnV9hPYSgSErG/nSvlBowDZs=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Wy2MeZO_1769579552 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 28 Jan 2026 13:52:32 +0800
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
	Heiner Kallweit <hkallweit1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Dust Li <dust.li@linux.alibaba.com>
Subject: [PATCH net-next v23 0/6] eea: Add basic driver framework for Alibaba Elastic Ethernet Adaptor
Date: Wed, 28 Jan 2026 13:52:26 +0800
Message-Id: <20260128055232.8021-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: aef0f11e842e
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-254102-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuanzhuo@linux.alibaba.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linux.alibaba.com,linux.dev,mucse.com,gmail.com];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5FFDD9D424
X-Rspamd-Action: no action

Add a driver framework for EEA that will be available in the future.

This driver is currently quite minimal, implementing only fundamental
core functionalities. Key features include: I/O queue management via
adminq, basic PCI-layer operations, and essential RX/TX data
communication capabilities. It also supports the creation,
initialization, and management of network devices (netdev). Furthermore,
the ring structures for both I/O queues and adminq have been abstracted
into a simple, unified, and reusable library implementation,
facilitating future extension and maintenance.

v23:
    I have moved netif_set_real_num_queues() out of eea_start_rxtx(), so
    eea_start_rxtx() is now a void function. I believe enet_bind_new_q_and_cfg()
    is a more suitable place to include netif_set_real_num_queues(). In
    eea_active_ring_and_irq(), I first execute request_irq() before interacting
    with the hardware to create queues. Therefore, during the NIC setup process,
    all driver-internal operations (memory allocation, IRQ initialization, sysfs
    configuration, etc.) will be completed before the final notification to the
    hardware.

v22:
    1. Use the budget from the NAPI poll function as the parameter for
       napi_consume_skb.
    2. Stop the TX queue when the remaining ring slots cannot hold an SKB.

v21:
    Fix two issues from the previous version:
    1, a DMA unmap operation was missing.
    2, RCU APIs were not used in eea_stats. Although the standard practice when
        using RCU would require adding the __rcu annotation to both the rx and
        tx fields, in many cases these fields are read without needing RCU
        protection.  Therefore, I do not want to add the __rcu annotation.
        Instead, I use a spin lock to protect modifications to rx and tx.

v20:
    Fix the partially initialized structure passed to db. @Jakub
    http://lore.kernel.org/all/20260113172353.2ae6ef81@kernel.org

v19:
    fix the comments from @Simon Horman

v18:
    v17 with [PATCH] prefix.

v17:
    1. In `eea_adminq_dev_status`, uniformly use `enet->cfg.rx_ring_num`.
    2. Add a `struct eea_net_cfg *cfg` parameter to `eea_free_rx` and
        `eea_free_tx`. When called in the normal path, pass `enet->cfg` as
        the argument; when called during initialization, pass the temporary
        `cfg` instead.
    3. Move the `.ndo_get_stats64` callback into `eea_net.c`.
    4. In the `.ndo_get_stats64` callback, add a comment explaining how the TX
        and RX statistics are protected by RCU.

       /* This function is protected by RCU. Here uses enet->tx and enet->rx
        * to check whether the TX and RX structures are safe to access. In
        * eea_free_rxtx_q_mem, before freeing the TX and RX resources, enet->rx
        * and enet->tx are set to NULL, and synchronize_net is called.
        */


v16:
    1. follow the advices from @ALOK TIWARI
       http://lore.kernel.org/all/5ff95a71-69e5-4cb6-9b2a-5224c983bdc2@oracle.com

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


















Xuan Zhuo (6):
  eea: introduce PCI framework
  eea: introduce ring and descriptor structures
  eea: probe the netdevice and create adminq
  eea: create/destroy rx,tx queues for netdevice open and stop
  eea: introduce ethtool support
  eea: introduce callback for ndo_get_stats64

 MAINTAINERS                                   |   8 +
 drivers/net/ethernet/Kconfig                  |   1 +
 drivers/net/ethernet/Makefile                 |   1 +
 drivers/net/ethernet/alibaba/Kconfig          |  28 +
 drivers/net/ethernet/alibaba/Makefile         |   5 +
 drivers/net/ethernet/alibaba/eea/Makefile     |   9 +
 drivers/net/ethernet/alibaba/eea/eea_adminq.c | 421 ++++++++++
 drivers/net/ethernet/alibaba/eea/eea_adminq.h |  70 ++
 drivers/net/ethernet/alibaba/eea/eea_desc.h   | 156 ++++
 .../net/ethernet/alibaba/eea/eea_ethtool.c    | 236 ++++++
 .../net/ethernet/alibaba/eea/eea_ethtool.h    |  49 ++
 drivers/net/ethernet/alibaba/eea/eea_net.c    | 650 +++++++++++++++
 drivers/net/ethernet/alibaba/eea/eea_net.h    | 201 +++++
 drivers/net/ethernet/alibaba/eea/eea_pci.c    | 587 +++++++++++++
 drivers/net/ethernet/alibaba/eea/eea_pci.h    |  67 ++
 drivers/net/ethernet/alibaba/eea/eea_ring.c   | 266 ++++++
 drivers/net/ethernet/alibaba/eea/eea_ring.h   |  91 ++
 drivers/net/ethernet/alibaba/eea/eea_rx.c     | 787 ++++++++++++++++++
 drivers/net/ethernet/alibaba/eea/eea_tx.c     | 399 +++++++++
 19 files changed, 4032 insertions(+)
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


