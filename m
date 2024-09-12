Return-Path: <netdev+bounces-127619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA07E975E25
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 02:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67894B2291D
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 00:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814E0370;
	Thu, 12 Sep 2024 00:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="F68JOGyt"
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-3.cisco.com (rcdn-iport-3.cisco.com [173.37.86.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6856414F6C
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 00:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726102314; cv=none; b=r7E+TNznwWawm02rAAL0qjrECJ2uJbKQ5gjUnPD62PSvHUmsFCMXb9NhcoAwdZp+2y8NSxQLqbgyvp6NNRYx4s7cRH6GwAkEfgN6e3QJUcoI2F6jwwfdJT7M2RL6D/jon/AS7XBNHHv7DtVpvkAte0GiMrUGICGBt+ftl56liKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726102314; c=relaxed/simple;
	bh=59JL4mkop0pR02mCM8ycJ9gu15ES1zkxFlzl0Ne0uxU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T7/ESHZ5CFhQh+VhS0ITTHcgfmzhG5hjqPiH0h7qxot6C987GAgskJlmnagkJJHHRj4RkYaKEEgwA12UbYNv13baZUtLoeogj8U2tsIp/h++cvkI6obQjEBR4t8ljLJKWQA/D/zvKdTDf5MZI81sLZKBG6gEgtglkdYg7NXNGxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=F68JOGyt; arc=none smtp.client-ip=173.37.86.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=3187; q=dns/txt; s=iport;
  t=1726102312; x=1727311912;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WPDi/s1DAV+YTSPt0WKf28tRBPYtZaJaqGaIsRTvtf8=;
  b=F68JOGyt/RI6+VbCJ2Ur1+FyiatJQQ5/Rc1sllf9eK0I4GHQo8/aHigH
   JoGKm760sxpvFNyCN20hdfEo4e1RdKDHPQsOo21BJA0GmBnHtYumFkz07
   UhwRgP582CEGkS49k2jf9JnayLFHL+tYLOCWqwVO1jnrx5hRgIBpGYqjO
   8=;
X-CSE-ConnectionGUID: m4rQhcLRRZuVgICTD7Qb6g==
X-CSE-MsgGUID: O3rjd+yMRoqVVB/dbc8qcQ==
X-IronPort-AV: E=Sophos;i="6.10,221,1719878400"; 
   d="scan'208";a="260022518"
Received: from rcdn-core-6.cisco.com ([173.37.93.157])
  by rcdn-iport-3.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 00:51:51 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by rcdn-core-6.cisco.com (8.15.2/8.15.2) with ESMTP id 48C0ppgL008222;
	Thu, 12 Sep 2024 00:51:51 GMT
Received: by cisco.com (Postfix, from userid 412739)
	id 0D63620F2003; Wed, 11 Sep 2024 17:51:51 -0700 (PDT)
From: Nelson Escobar <neescoba@cisco.com>
To: netdev@vger.kernel.org
Cc: satishkh@cisco.com, johndale@cisco.com,
        Nelson Escobar <neescoba@cisco.com>
Subject: [PATCH net-next v3 3/4] enic: Report per queue statistics in netdev qstats
Date: Wed, 11 Sep 2024 17:50:38 -0700
Message-Id: <20240912005039.10797-4-neescoba@cisco.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20240912005039.10797-1-neescoba@cisco.com>
References: <20240912005039.10797-1-neescoba@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: rcdn-core-6.cisco.com

Report per queue wq/rq statistics in netdev qstats.

Signed-off-by: Nelson Escobar <neescoba@cisco.com>
Signed-off-by: John Daley <johndale@cisco.com>
Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic_main.c | 56 +++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index 8f05ad3a4ccc..ffed14b63d41 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -46,6 +46,7 @@
 #include <linux/crash_dump.h>
 #include <net/busy_poll.h>
 #include <net/vxlan.h>
+#include <net/netdev_queues.h>
 
 #include "cq_enet_desc.h"
 #include "vnic_dev.h"
@@ -2571,6 +2572,54 @@ static void enic_clear_intr_mode(struct enic *enic)
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
+	txs->csum_none = wqstats->csum_none;
+	txs->needs_csum = wqstats->csum_partial + wqstats->encap_csum +
+			  wqstats->tso;
+	txs->hw_gso_packets = wqstats->tso;
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
+	txs->csum_none = 0;
+	txs->needs_csum = 0;
+	txs->hw_gso_packets = 0;
+	txs->stop = 0;
+	txs->wake = 0;
+}
+
 static const struct net_device_ops enic_netdev_dynamic_ops = {
 	.ndo_open		= enic_open,
 	.ndo_stop		= enic_stop,
@@ -2619,6 +2668,12 @@ static const struct net_device_ops enic_netdev_ops = {
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
@@ -2961,6 +3016,7 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		netdev->netdev_ops = &enic_netdev_dynamic_ops;
 	else
 		netdev->netdev_ops = &enic_netdev_ops;
+	netdev->stat_ops = &enic_netdev_stat_ops;
 
 	netdev->watchdog_timeo = 2 * HZ;
 	enic_set_ethtool_ops(netdev);
-- 
2.35.2


