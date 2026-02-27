Return-Path: <netdev+bounces-261665-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QN/fFK/5oGlXogQAu9opvQ
	(envelope-from <netdev+bounces-261665-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 02:55:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F024E1B1AB8
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 02:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2CAA43013DED
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 01:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126E529E11D;
	Fri, 27 Feb 2026 01:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="edFmXFgI"
X-Original-To: netdev@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB0928C5B1
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 01:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772157357; cv=none; b=Xok4PYCryYhsD207YlbCT+gl994vkNafwAw9prvtp+ebHg03MiGf5Ec7jdOs3WALolrCLDswa5fB8cvBj/Dq/LaR3PAaLppVt08vzVG0ctlO/KGBO3sGM4O2fUqEx3LAsrvQEbkSLSQ3CBJrAq3fRF5YoFP4fFpiZPZwbaHZg54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772157357; c=relaxed/simple;
	bh=6G3j8VfsC/3jEey6Fcnqj8Z3kyqcjwrrIPxYRuWr38M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sN/j46mhjcsgLwe/hTmop0/jilt7zZnwTj3mM+bRI/IbhyCUjuT/LoPKrFEcP9awKoCpLa2UHf3Qwmcro4lztMto3q8beHnMifT13sRt+6YHnWKYZjvzE2ENUsNzNjuTsdhq98Nab7HSRa8GGUANY1CUZvc41F7tiDLNCaKtMfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=edFmXFgI; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772157347; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=52kwK5oEtBDrg1Uq2GxWXC6EYFe76LD9WbMigGEa1+U=;
	b=edFmXFgIop9lG2JZR5PCXXz0eADegysBi40nB8qpGeFZAAH2BLs/GI40F+ICtiYU9c1AaeFFcWtjFJJnZTwPRi0+Ca2UM8HtzirMSvqf9vJhyqfSVXAS3cHIZiQ7zK2bij7Y+y6R80/5SVz0P0XARA5l9mEuI523oYw7/Zm1fO0=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WzsXoO9_1772157346 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 27 Feb 2026 09:55:46 +0800
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
Subject: [PATCH net-next v27 0/8] eea: Add basic driver framework for Alibaba Elastic Ethernet Adaptor
Date: Fri, 27 Feb 2026 09:55:38 +0800
Message-Id: <20260227015546.47336-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: f713bd6bad2c
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261665-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linux.alibaba.com,linux.dev,mucse.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuanzhuo@linux.alibaba.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.985];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.alibaba.com:mid,linux.alibaba.com:dkim]
X-Rspamd-Queue-Id: F024E1B1AB8
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

v27:
    Address AI-generated review suggestions from the previous version.

v26:
    Adopting suggestions from the previous AI review, another significant
    change is the introduction of an IRQ block to implement IRQ proxying. With
    this design, when an IRQ occurs, we no longer invoke the RX data structure
    directly -- instead, the IRQ block serves as an intermediary proxy. This
    approach offers several advantages: IRQ resources no longer need to be
    reallocated during reset operations, and IRQs are decoupled from RX
    structures. Consequently, when certain errors occur, we can fall back and
    safely reuse the original memory resources.

v25:
    I have adopted most of the suggestions from the AI's feedback. However, I
    believe some of the feedback is incorrect. I have already replied in the
    previous thread. http://lore.kernel.org/all/1770002612.3297296-2-xuanzhuo@linux.alibaba.com

v24:
    1. Add null checks for enet->rx and enet->tx in eea_get_ethtool_stat to
       prevent errors when reading rx = enet->rx[i] in case enet->rx is null.
       tx is similar. With rtnl protection in place, this check is sufficient.
    2. Use 'received' as the return value in eea_poll.

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






















Xuan Zhuo (8):
  eea: introduce PCI framework
  eea: introduce ring and descriptor structures
  eea: probe the netdevice and create adminq
  eea: create/destroy rx,tx queues for netdevice open and stop
  eea: implement packet receive logic
  eea: implement packet transmit logic
  eea: introduce ethtool support
  eea: introduce callback for ndo_get_stats64

 MAINTAINERS                                   |   8 +
 drivers/net/ethernet/Kconfig                  |   1 +
 drivers/net/ethernet/Makefile                 |   1 +
 drivers/net/ethernet/alibaba/Kconfig          |  28 +
 drivers/net/ethernet/alibaba/Makefile         |   5 +
 drivers/net/ethernet/alibaba/eea/Makefile     |   9 +
 drivers/net/ethernet/alibaba/eea/eea_adminq.c | 442 ++++++++++
 drivers/net/ethernet/alibaba/eea/eea_adminq.h |  75 ++
 drivers/net/ethernet/alibaba/eea/eea_desc.h   | 134 +++
 .../net/ethernet/alibaba/eea/eea_ethtool.c    | 243 ++++++
 .../net/ethernet/alibaba/eea/eea_ethtool.h    |  49 ++
 drivers/net/ethernet/alibaba/eea/eea_net.c    | 784 ++++++++++++++++++
 drivers/net/ethernet/alibaba/eea/eea_net.h    | 194 +++++
 drivers/net/ethernet/alibaba/eea/eea_pci.c    | 590 +++++++++++++
 drivers/net/ethernet/alibaba/eea/eea_pci.h    |  66 ++
 drivers/net/ethernet/alibaba/eea/eea_ring.c   | 271 ++++++
 drivers/net/ethernet/alibaba/eea/eea_ring.h   |  89 ++
 drivers/net/ethernet/alibaba/eea/eea_rx.c     | 748 +++++++++++++++++
 drivers/net/ethernet/alibaba/eea/eea_tx.c     | 391 +++++++++
 19 files changed, 4128 insertions(+)
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


