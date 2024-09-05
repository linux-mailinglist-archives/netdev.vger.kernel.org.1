Return-Path: <netdev+bounces-125336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CE696CC17
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 03:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C844DB2396E
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 01:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D44F79F5;
	Thu,  5 Sep 2024 01:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="ld2jYdUl"
X-Original-To: netdev@vger.kernel.org
Received: from bgl-iport-4.cisco.com (bgl-iport-4.cisco.com [72.163.197.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37039450
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 01:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.163.197.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725498699; cv=none; b=qgAxy1hTE1soVbQB9j0zsLkqyFQaGD8FYInYjECOqBIHEv2N+EtgcYubf/HqrY+gCiZxbxnqvaEdnPYLqxhmJ+0LVRG5jW0UxzrWBc++SVh2sIq8h7Y5aeKAWbnOAMZx/4qAA6v8LfE1cvqRHD8NOaNDDCl1NBBhZ5cb6gAnrRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725498699; c=relaxed/simple;
	bh=XBV9yMdxzq1FNtUa24u9usTujlNjccouJFgFHu+cyPk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TQQlSVch9Hl3GyZfLKX7hPRVuSSXbkFE6IUpFvwNRXA9SnxroPOTBNYYT1jFXnZGGarc4BE0CvX9lBgip+pXbs8hiTBr6BxgR67EtxEYPS9Kb9QP+UrAYn34WKQxZcywvc+iOwVsic1NBUIniusuuqNYYveYXISstixngJuGxqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=ld2jYdUl; arc=none smtp.client-ip=72.163.197.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2949; q=dns/txt; s=iport;
  t=1725498697; x=1726708297;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HAW77mzGZAL5cerXHf0DUJSX5sfmLvHxLBTmyBKjLcE=;
  b=ld2jYdUlO8s0p5rlXuv4j+vt/lZ1h4mxZgcOdi4LNSvZNV1lF7sOAvuI
   dFSD6MHoj52v0mq6XgfH4DXJeTXEIxbIhRvuYRex2VfX0fla6SSOchm4X
   PrjHIMSQZhj/04Q0ccTBFl9XvbWtZR/YVfWBD942RT7JyPR/bcG0K7wP9
   Q=;
X-CSE-ConnectionGUID: 4NT7LRWKQaGyRd0RiuIRHA==
X-CSE-MsgGUID: 0NjFfoSjQi6DgJiLLpAtQg==
X-IronPort-AV: E=Sophos;i="6.10,203,1719878400"; 
   d="scan'208";a="39217421"
Received: from vla196-nat.cisco.com (HELO bgl-core-1.cisco.com) ([72.163.197.24])
  by bgl-iport-4.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 01:10:25 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by bgl-core-1.cisco.com (8.15.2/8.15.2) with ESMTP id 4851AOGl008504;
	Thu, 5 Sep 2024 01:10:25 GMT
Received: by cisco.com (Postfix, from userid 412739)
	id 6409720F2003; Wed,  4 Sep 2024 18:10:24 -0700 (PDT)
From: Nelson Escobar <neescoba@cisco.com>
To: netdev@vger.kernel.org
Cc: satishkh@cisco.com, johndale@cisco.com,
        Nelson Escobar <neescoba@cisco.com>
Subject: [PATCH net-next v2 4/4] enic: Report per queue statistics in netdev qstats
Date: Wed,  4 Sep 2024 18:09:00 -0700
Message-Id: <20240905010900.24152-5-neescoba@cisco.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20240905010900.24152-1-neescoba@cisco.com>
References: <20240905010900.24152-1-neescoba@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: bgl-core-1.cisco.com

Report per queue wq/rq statistics in netdev qstats.

Signed-off-by: Nelson Escobar <neescoba@cisco.com>
Signed-off-by: John Daley <johndale@cisco.com>
Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic_main.c | 49 +++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index 7d4b44f1abb2..6d86cb5ad6d8 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -46,6 +46,7 @@
 #include <linux/crash_dump.h>
 #include <net/busy_poll.h>
 #include <net/vxlan.h>
+#include <net/netdev_queues.h>
 
 #include "cq_enet_desc.h"
 #include "vnic_dev.h"
@@ -2570,6 +2571,47 @@ static void enic_clear_intr_mode(struct enic *enic)
 	vnic_dev_set_intr_mode(enic->vdev, VNIC_DEV_INTR_MODE_UNKNOWN);
 }
 
+static void enic_get_queue_stats_rx(struct net_device *dev, int idx,
+				    struct netdev_queue_stats_rx *rxs)
+{
+	struct enic *enic = netdev_priv(dev);
+	struct enic_rq_stats *rqstats = &enic->rq_stats[idx];
+
+	rxs->bytes = rqstats->bytes;
+	rxs->packets = rqstats->packets;
+	rxs->hw_drops = rqstats->bad_fcs + rqstats->pkt_truncated;
+	rxs->hw_drop_overruns = rqstats->pkt_truncated;
+	rxs->csum_unnecessary = rqstats->csum_unnecessary +
+				rqstats->csum_unnecessary_encap;
+}
+
+static void enic_get_queue_stats_tx(struct net_device *dev, int idx,
+				    struct netdev_queue_stats_tx *txs)
+{
+	struct enic *enic = netdev_priv(dev);
+	struct enic_wq_stats *wqstats = &enic->wq_stats[idx];
+
+	txs->bytes = wqstats->bytes;
+	txs->packets = wqstats->packets;
+	txs->stop = wqstats->stopped;
+	txs->wake = wqstats->wake;
+}
+
+static void enic_get_base_stats(struct net_device *dev,
+				struct netdev_queue_stats_rx *rxs,
+				struct netdev_queue_stats_tx *txs)
+{
+	rxs->bytes = 0;
+	rxs->packets = 0;
+	rxs->hw_drops = 0;
+	rxs->hw_drop_overruns = 0;
+	rxs->csum_unnecessary = 0;
+	txs->bytes = 0;
+	txs->packets = 0;
+	txs->stop = 0;
+	txs->wake = 0;
+}
+
 static const struct net_device_ops enic_netdev_dynamic_ops = {
 	.ndo_open		= enic_open,
 	.ndo_stop		= enic_stop,
@@ -2618,6 +2660,12 @@ static const struct net_device_ops enic_netdev_ops = {
 	.ndo_features_check	= enic_features_check,
 };
 
+static const struct netdev_stat_ops enic_netdev_stat_ops = {
+	.get_queue_stats_rx	= enic_get_queue_stats_rx,
+	.get_queue_stats_tx	= enic_get_queue_stats_tx,
+	.get_base_stats		= enic_get_base_stats,
+};
+
 static void enic_dev_deinit(struct enic *enic)
 {
 	unsigned int i;
@@ -2960,6 +3008,7 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		netdev->netdev_ops = &enic_netdev_dynamic_ops;
 	else
 		netdev->netdev_ops = &enic_netdev_ops;
+	netdev->stat_ops = &enic_netdev_stat_ops;
 
 	netdev->watchdog_timeo = 2 * HZ;
 	enic_set_ethtool_ops(netdev);
-- 
2.35.2


