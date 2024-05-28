Return-Path: <netdev+bounces-98597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1C28D1D83
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 15:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19A931C22881
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 13:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C0817165F;
	Tue, 28 May 2024 13:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a43CY02t"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24792171653;
	Tue, 28 May 2024 13:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716904190; cv=none; b=fcia+m2HXh91ZezBmyrYNEruNkm0fVsj+EV15eC40QLCXTVuqYO9D19x/FGtwuK6k8GlLEEcg8zmn/7qMiUpXTSp/p0O1uMXD5h9BNYf/WSDIIeko9d+Xifz76HnXk2uVaEbxlfe23/dOTA9LbYIY5uDVnIvkgsOHbHMJkT5xiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716904190; c=relaxed/simple;
	bh=xUu4d084D1+ey2WxhYeVFQu2HZnxL+3lmr6vPuv2lKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QUeXvTp5+bDTYbk7FaEfB35jRv3/JQaNGCIe3VcvPKqcKyKbwxsYSI7paCh0Nh59zS2RaZHFBS1Qu2MZH6TWu533avQU3QK2Xxr1xumvuKfOl0WxwYAvD4tx99vJuZDTVuupn9NkjRmeGNuPD+UBbSO70L7I+SlGdv543JXBTpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a43CY02t; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716904189; x=1748440189;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xUu4d084D1+ey2WxhYeVFQu2HZnxL+3lmr6vPuv2lKU=;
  b=a43CY02tPkHeJqo8YYdzTwzKkAuDMlk1Xf5avehR6xiHVXBiu4EAB6aC
   HdfKoJfa1sb34Efxgc0VAvGUKGu6e/fBy9wknJNrBcKfflL4+Ab/Rwe/n
   jYdENgH6I0yT15jjrHrkxOkdqvjbqufMweo/gPBIbh8SwNdG0JooOsZNE
   N1lOcCbTJwIOauWoGXmtw0gGos8OlENZ6rsbwYY4v85yd8zF+omg9OBEX
   RY/BMDbVRsURRQ2y5AH3WFkz7Syyzaam+IWzFp6MrDqZOT5gH8rIKsNOI
   cKFhCND9SoqQaiQeHvOW2DQGPg+G9GaMMjt8EaIhePpIITbAVhGyRVrP3
   g==;
X-CSE-ConnectionGUID: ks3C1NqYTsmso/6yzW05Wg==
X-CSE-MsgGUID: g6BJD8vqSR+63d4y8OxeeQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13437054"
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="13437054"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 06:49:49 -0700
X-CSE-ConnectionGUID: /9pK1N1pQQiMsWs/1QBsfg==
X-CSE-MsgGUID: 04CY1BevRUus85VilomAqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="35577450"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa008.jf.intel.com with ESMTP; 28 May 2024 06:49:46 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mina Almasry <almasrymina@google.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next 09/12] idpf: remove legacy Page Pool Ethtool stats
Date: Tue, 28 May 2024 15:48:43 +0200
Message-ID: <20240528134846.148890-10-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240528134846.148890-1-aleksander.lobakin@intel.com>
References: <20240528134846.148890-1-aleksander.lobakin@intel.com>
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

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/idpf/Kconfig       |  1 -
 .../net/ethernet/intel/idpf/idpf_ethtool.c    | 29 +------------------
 2 files changed, 1 insertion(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/Kconfig b/drivers/net/ethernet/intel/idpf/Kconfig
index 638484c5723c..1f071143d992 100644
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
index e933fed16c7e..3806ddd3ce4a 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
@@ -565,8 +565,6 @@ static void idpf_get_stat_strings(struct net_device *netdev, u8 *data)
 	for (i = 0; i < vport_config->max_q.max_rxq; i++)
 		idpf_add_qstat_strings(&data, idpf_gstrings_rx_queue_stats,
 				       "rx", i);
-
-	page_pool_ethtool_stats_get_strings(data);
 }
 
 /**
@@ -600,7 +598,6 @@ static int idpf_get_sset_count(struct net_device *netdev, int sset)
 	struct idpf_netdev_priv *np = netdev_priv(netdev);
 	struct idpf_vport_config *vport_config;
 	u16 max_txq, max_rxq;
-	unsigned int size;
 
 	if (sset != ETH_SS_STATS)
 		return -EINVAL;
@@ -619,11 +616,8 @@ static int idpf_get_sset_count(struct net_device *netdev, int sset)
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
@@ -876,7 +870,6 @@ static void idpf_get_ethtool_stats(struct net_device *netdev,
 {
 	struct idpf_netdev_priv *np = netdev_priv(netdev);
 	struct idpf_vport_config *vport_config;
-	struct page_pool_stats pp_stats = { };
 	struct idpf_vport *vport;
 	unsigned int total = 0;
 	unsigned int i, j;
@@ -946,32 +939,12 @@ static void idpf_get_ethtool_stats(struct net_device *netdev,
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
2.45.1


