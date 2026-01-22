Return-Path: <netdev+bounces-252317-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHyGFLklcmlJdwAAu9opvQ
	(envelope-from <netdev+bounces-252317-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 14:27:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D15046741A
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 14:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 39C9C6C5C67
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 12:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B753D3489;
	Thu, 22 Jan 2026 12:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FbSM1M2b"
X-Original-To: netdev@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA34E2BF019
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 12:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769083514; cv=none; b=LhQE7a5RkZtwx21s2YIo5phTJaMR/prl149Xp+VCMwACe6zbdMj8V3K6dT9i6zt9FVVawt2d8b/K9waj40v1e75bbJcHshxLX19lQUha6RjT0VOGH5gMteMn00zgP2RRiDL6J+gSGFCiwocOYXGCrLUd09s50drWXdMZ06/MwBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769083514; c=relaxed/simple;
	bh=/aEuucQsWK0tO0m2Cttj9d2HCJS0Bfim4D3Ntn6QjFo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CISu0h0j8gRHh0F9Q2xtauD7c0S3zY3HmXVqmCQUYZMh1vK5lLd85+lfVC8FRqoEU+h4yHAzjxhA+OEGpCsKMeXbZuA0dCKXn5K3toXHCETLWhU5jb88xjk689NdUO2+1szQgP+5JFWxen7tJdvbgnBQ9HEF2/FrFXnKFQugJvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FbSM1M2b; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769083509; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=e6QLMTcHHVY9DgFdnqAtAyynlt1LM8zSRx4RRBsulJo=;
	b=FbSM1M2bb1f739JQmubXPiVtGN+dgQfoLtlINC1DOMkM1pfqEz2NxGAUvTUvfGwW0zFOQG/Wk5+y3p3WLBOeSvZ0yHtru3SqjRKP0xt6h0yBFj80CK+GKZxO1gJB7Fchdrqq92XlwHjEoPd7m8YiAWsYZn5AOCM0cuv4kkyIBrc=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WxcIP6n_1769083508 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 22 Jan 2026 20:05:08 +0800
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
Subject: [PATCH net-next v22 0/6] eea: Add basic driver framework for Alibaba Elastic Ethernet Adaptor
Date: Thu, 22 Jan 2026 20:05:02 +0800
Message-Id: <20260122120508.17452-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: f8898de39b6a
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-5.96 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252317-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linux.alibaba.com,linux.dev,mucse.com,gmail.com];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuanzhuo@linux.alibaba.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[linux.alibaba.com,none];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D15046741A
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
 drivers/net/ethernet/alibaba/eea/eea_net.c    | 644 ++++++++++++++
 drivers/net/ethernet/alibaba/eea/eea_net.h    | 201 +++++
 drivers/net/ethernet/alibaba/eea/eea_pci.c    | 587 +++++++++++++
 drivers/net/ethernet/alibaba/eea/eea_pci.h    |  67 ++
 drivers/net/ethernet/alibaba/eea/eea_ring.c   | 266 ++++++
 drivers/net/ethernet/alibaba/eea/eea_ring.h   |  91 ++
 drivers/net/ethernet/alibaba/eea/eea_rx.c     | 789 ++++++++++++++++++
 drivers/net/ethernet/alibaba/eea/eea_tx.c     | 399 +++++++++
 19 files changed, 4028 insertions(+)
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


