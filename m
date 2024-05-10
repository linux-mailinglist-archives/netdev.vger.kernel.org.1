Return-Path: <netdev+bounces-95519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 655158C27CE
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 17:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 970961C21E49
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 15:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7696A17965E;
	Fri, 10 May 2024 15:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hzxtyjRN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD00172BDA;
	Fri, 10 May 2024 15:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715354897; cv=none; b=DmVRavYaf/hUGfUpfudOhAlqsstbtXBHEy+9kHvAhiD3vZX7+yAi6j0VO88KDCXdXjrwAMoif68xIQvDT34RTOpTpi2HX1ls6qm6hUor6uAhhfj9/CH1FXgQ1o2WB5Q37dzC7GyKwzXdeuL1no9ECvuUKfGeCfXpKOVuN2NiNcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715354897; c=relaxed/simple;
	bh=pJ2zNa4jO3CdB90KBwujeCTuJvbcVryhT3VX6SDhewU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HTzaenYAnJuEeMmtZBcZGAtBv8Ve3mJYaVoNmvzhiwf67Q2fCiAvvaeWaA347ShKWjCbErCBItq8DPBTGZYIE5xzMwwH9+YKuPGkxrn+wvKFVmZqnMY9+H8fP+/lecXi/e4J2LXseb1YnkWDWg44QDJZ5zL2Lr4np+x+Y4otRMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hzxtyjRN; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715354880; x=1746890880;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pJ2zNa4jO3CdB90KBwujeCTuJvbcVryhT3VX6SDhewU=;
  b=hzxtyjRNHxnOCwFerNHjXpoXv1zRTIr5CY9EaIrgmpfn1qxRmS8HrV1H
   qMPraoll9l9mvBIcmF7wKx/FCb7EGd5Qei+j0k7hK7JHbDHhHPxwAKO02
   yG3F7Bj6n5ZpqC2pS2Wyt2G1cWhz9dpYqcakmTq050T6MCe8CXDNw+OEz
   /p5LXwZ6HY204/XQly1NC7yo8PKyy49WN0Q4Galssu6Axa4QpREUIRiBY
   DetJMFEKvPK0LS4a0DpOS3O+I86HFdb/IwU2T4/jKqDS7VR72ao0/uMAq
   C9jEJP7ElL361qg7tS4qAcAvMTnrew2QDV5bVZt5VFI5lZ/NYumRE/dkV
   g==;
X-CSE-ConnectionGUID: 3tjAqeuWQ965Z9UrroNEaQ==
X-CSE-MsgGUID: bu8DSl53R9yTmCRThBoUsA==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="15152646"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="15152646"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 08:27:47 -0700
X-CSE-ConnectionGUID: f+FMRAZcRAeZJkN3glaBLw==
X-CSE-MsgGUID: nlXqQaOCRFuwfTAtv+pa2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="30208300"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa008.jf.intel.com with ESMTP; 10 May 2024 08:27:44 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC iwl-next 09/12] idpf: remove legacy Page Pool Ethtool stats
Date: Fri, 10 May 2024 17:26:17 +0200
Message-ID: <20240510152620.2227312-10-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240510152620.2227312-1-aleksander.lobakin@intel.com>
References: <20240510152620.2227312-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Page Pool Ethtool stats are deprecated since the Netlink Page Pool
interface introduction.
idpf receives big changes in Rx buffer management, including &page_pool
layout, so keeping these deprecated stats does only harm, not speaking
of that CONFIG_IDPF selects CONFIG_PAGE_POOL_STATS unconditionally,
while the latter is often turned off for better performance.
Remove all the references to PP stats from the Ethtool code. The stats
are still available in their full via the generic Netlink interface.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/idpf/Kconfig       |  1 -
 .../net/ethernet/intel/idpf/idpf_ethtool.c    | 29 +------------------
 2 files changed, 1 insertion(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/Kconfig b/drivers/net/ethernet/intel/idpf/Kconfig
index bd96ab923b07..af6126eeb61e 100644
--- a/drivers/net/ethernet/intel/idpf/Kconfig
+++ b/drivers/net/ethernet/intel/idpf/Kconfig
@@ -7,7 +7,6 @@ config IDPF
 	select DIMLIB
 	select LIBETH
 	select PAGE_POOL
-	select PAGE_POOL_STATS
 	help
 	  This driver supports Intel(R) Infrastructure Data Path Function
 	  devices.
diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
index 83447c3d026c..f66f866ec4fb 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
@@ -573,8 +573,6 @@ static void idpf_get_stat_strings(struct net_device *netdev, u8 *data)
 	for (i = 0; i < vport_config->max_q.max_rxq; i++)
 		idpf_add_qstat_strings(&data, idpf_gstrings_rx_queue_stats,
 				       "rx", i);
-
-	page_pool_ethtool_stats_get_strings(data);
 }
 
 /**
@@ -608,7 +606,6 @@ static int idpf_get_sset_count(struct net_device *netdev, int sset)
 	struct idpf_netdev_priv *np = netdev_priv(netdev);
 	struct idpf_vport_config *vport_config;
 	u16 max_txq, max_rxq;
-	unsigned int size;
 
 	if (sset != ETH_SS_STATS)
 		return -EINVAL;
@@ -627,11 +624,8 @@ static int idpf_get_sset_count(struct net_device *netdev, int sset)
 	max_txq = vport_config->max_q.max_txq;
 	max_rxq = vport_config->max_q.max_rxq;
 
-	size = IDPF_PORT_STATS_LEN + (IDPF_TX_QUEUE_STATS_LEN * max_txq) +
+	return IDPF_PORT_STATS_LEN + (IDPF_TX_QUEUE_STATS_LEN * max_txq) +
 	       (IDPF_RX_QUEUE_STATS_LEN * max_rxq);
-	size += page_pool_ethtool_stats_get_count();
-
-	return size;
 }
 
 /**
@@ -884,7 +878,6 @@ static void idpf_get_ethtool_stats(struct net_device *netdev,
 {
 	struct idpf_netdev_priv *np = netdev_priv(netdev);
 	struct idpf_vport_config *vport_config;
-	struct page_pool_stats pp_stats = { };
 	struct idpf_vport *vport;
 	unsigned int total = 0;
 	unsigned int i, j;
@@ -954,32 +947,12 @@ static void idpf_get_ethtool_stats(struct net_device *netdev,
 				idpf_add_empty_queue_stats(&data, qtype);
 			else
 				idpf_add_queue_stats(&data, rxq, qtype);
-
-			/* In splitq mode, don't get page pool stats here since
-			 * the pools are attached to the buffer queues
-			 */
-			if (is_splitq)
-				continue;
-
-			if (rxq)
-				page_pool_get_stats(rxq->pp, &pp_stats);
-		}
-	}
-
-	for (i = 0; i < vport->num_rxq_grp; i++) {
-		for (j = 0; j < vport->num_bufqs_per_qgrp; j++) {
-			struct idpf_buf_queue *rxbufq =
-				&vport->rxq_grps[i].splitq.bufq_sets[j].bufq;
-
-			page_pool_get_stats(rxbufq->pp, &pp_stats);
 		}
 	}
 
 	for (; total < vport_config->max_q.max_rxq; total++)
 		idpf_add_empty_queue_stats(&data, VIRTCHNL2_QUEUE_TYPE_RX);
 
-	page_pool_ethtool_stats_get(data, &pp_stats);
-
 	rcu_read_unlock();
 
 	idpf_vport_ctrl_unlock(netdev);
-- 
2.45.0


