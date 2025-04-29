Return-Path: <netdev+bounces-186892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDDEAA3CE3
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 01:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96D301BC4A04
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 23:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BEA231844;
	Tue, 29 Apr 2025 23:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cEzhRXke"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D62628032D
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 23:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970423; cv=none; b=g8wAYISbpuD6DT3AIkfJcpELxSOPfX+wmRkf4PCHS6AmYx7CMTBFGCydW76lknVGB27uMstetkzjnxcy8ghYrx4BGRsP5lhTNVb9hqM1E+aDkXEe2lgBwSymL8N4HHKjvH90mrvzwQk4H0dRtdp9++5KFBQRclPkwDc+ye/DHwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970423; c=relaxed/simple;
	bh=xIizxOk8nnJJvB9Pb72g48ewLTRJoFecjjMVY94my00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hu3j52csUUVyNb9fxPaBASEfiwGuCvrk1ZiDOH8QbOSCGXNri5B+KgqKhenS1EpiRPPzDmRGz4rzz9aqDPApjItY8Hn3uMn4ODSRV6sKZco6BpDuYgVhm4o2FxbBjwOOxajCztdXx4U2xBqjLbpIuoAxgzVJlwi/3XTKwBqPmDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cEzhRXke; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745970422; x=1777506422;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xIizxOk8nnJJvB9Pb72g48ewLTRJoFecjjMVY94my00=;
  b=cEzhRXkeTy37ZJTsUxQzAq9+Cel9MAMEVC2rrdIdAX6JH3zprwtZZcGs
   mShTcDZeJI7Vl0pDDaudR/JStsemcgpRna6DcZrKXq75uOzQcsd2BqWJE
   DshMh1SjmUC5zwyxbvKVpmQGDdzsxX+g4GmKkFysBO/esqomJCAOZPqsQ
   z+tHHwUD89gwpmUc+6jTFYmnSoriBJ/BHfO+LHI6Hx2KUCyVfn/BICgiY
   PulHDbWBLsxVWHWbxozh5ZAphLdV+xCZtgiJaHe/UL71kRGELnXx9idq5
   D+S73B4oAYZx9CPCkaHAilFrG9r8JLzsFhQLhTYmWEdaCxa7LzD7cocCw
   Q==;
X-CSE-ConnectionGUID: brwt8nC7Ti601ClHtsTeZg==
X-CSE-MsgGUID: 55EnOwcrTGicpBY2qNLSdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="58990065"
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="58990065"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 16:47:00 -0700
X-CSE-ConnectionGUID: HduSx5UIQQiZt5huFgxmxA==
X-CSE-MsgGUID: GlgG4+pGSMakgr7UH3qHVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="137979611"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 29 Apr 2025 16:46:59 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Kurt Kanzenbach <kurt@linutronix.de>,
	anthony.l.nguyen@intel.com,
	bigeasy@linutronix.de,
	gerhard@engleder-embedded.com,
	jdamato@fastly.com,
	Sweta Kumari <sweta.kumari@intel.com>
Subject: [PATCH net-next 02/13] igb: Link queues to NAPI instances
Date: Tue, 29 Apr 2025 16:46:37 -0700
Message-ID: <20250429234651.3982025-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250429234651.3982025-1-anthony.l.nguyen@intel.com>
References: <20250429234651.3982025-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kurt Kanzenbach <kurt@linutronix.de>

Link queues to NAPI instances via netdev-genl API. This is required to use
XDP/ZC busy polling. See commit 5ef44b3cb43b ("xsk: Bring back busy polling
support") for details.

This also allows users to query the info with netlink:

|$ ./tools/net/ynl/pyynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
|                               --dump queue-get --json='{"ifindex": 2}'
|[{'id': 0, 'ifindex': 2, 'napi-id': 8201, 'type': 'rx'},
| {'id': 1, 'ifindex': 2, 'napi-id': 8202, 'type': 'rx'},
| {'id': 2, 'ifindex': 2, 'napi-id': 8203, 'type': 'rx'},
| {'id': 3, 'ifindex': 2, 'napi-id': 8204, 'type': 'rx'},
| {'id': 0, 'ifindex': 2, 'napi-id': 8201, 'type': 'tx'},
| {'id': 1, 'ifindex': 2, 'napi-id': 8202, 'type': 'tx'},
| {'id': 2, 'ifindex': 2, 'napi-id': 8203, 'type': 'tx'},
| {'id': 3, 'ifindex': 2, 'napi-id': 8204, 'type': 'tx'}]

Add rtnl locking to PCI error handlers, because netif_queue_set_napi()
requires the lock held.

While at __igb_open() use RCT coding style.

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
Reviewed-by: Joe Damato <jdamato@fastly.com>
Tested-by: Sweta Kumari <sweta.kumari@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igb/igb.h      |  2 ++
 drivers/net/ethernet/intel/igb/igb_main.c | 43 ++++++++++++++++++++---
 2 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index 02f340280d20..79eca385a751 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -722,6 +722,8 @@ enum igb_boards {
 
 extern char igb_driver_name[];
 
+void igb_set_queue_napi(struct igb_adapter *adapter, int q_idx,
+			struct napi_struct *napi);
 int igb_xmit_xdp_ring(struct igb_adapter *adapter,
 		      struct igb_ring *ring,
 		      struct xdp_frame *xdpf);
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 401af6dce2a8..0535cc72b11b 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2099,6 +2099,22 @@ static void igb_check_swap_media(struct igb_adapter *adapter)
 	wr32(E1000_CTRL_EXT, ctrl_ext);
 }
 
+void igb_set_queue_napi(struct igb_adapter *adapter, int vector,
+			struct napi_struct *napi)
+{
+	struct igb_q_vector *q_vector = adapter->q_vector[vector];
+
+	if (q_vector->rx.ring)
+		netif_queue_set_napi(adapter->netdev,
+				     q_vector->rx.ring->queue_index,
+				     NETDEV_QUEUE_TYPE_RX, napi);
+
+	if (q_vector->tx.ring)
+		netif_queue_set_napi(adapter->netdev,
+				     q_vector->tx.ring->queue_index,
+				     NETDEV_QUEUE_TYPE_TX, napi);
+}
+
 /**
  *  igb_up - Open the interface and prepare it to handle traffic
  *  @adapter: board private structure
@@ -2106,6 +2122,7 @@ static void igb_check_swap_media(struct igb_adapter *adapter)
 int igb_up(struct igb_adapter *adapter)
 {
 	struct e1000_hw *hw = &adapter->hw;
+	struct napi_struct *napi;
 	int i;
 
 	/* hardware has been reset, we need to reload some things */
@@ -2113,8 +2130,11 @@ int igb_up(struct igb_adapter *adapter)
 
 	clear_bit(__IGB_DOWN, &adapter->state);
 
-	for (i = 0; i < adapter->num_q_vectors; i++)
-		napi_enable(&(adapter->q_vector[i]->napi));
+	for (i = 0; i < adapter->num_q_vectors; i++) {
+		napi = &adapter->q_vector[i]->napi;
+		napi_enable(napi);
+		igb_set_queue_napi(adapter, i, napi);
+	}
 
 	if (adapter->flags & IGB_FLAG_HAS_MSIX)
 		igb_configure_msix(adapter);
@@ -2184,6 +2204,7 @@ void igb_down(struct igb_adapter *adapter)
 	for (i = 0; i < adapter->num_q_vectors; i++) {
 		if (adapter->q_vector[i]) {
 			napi_synchronize(&adapter->q_vector[i]->napi);
+			igb_set_queue_napi(adapter, i, NULL);
 			napi_disable(&adapter->q_vector[i]->napi);
 		}
 	}
@@ -4116,8 +4137,9 @@ static int igb_sw_init(struct igb_adapter *adapter)
 static int __igb_open(struct net_device *netdev, bool resuming)
 {
 	struct igb_adapter *adapter = netdev_priv(netdev);
-	struct e1000_hw *hw = &adapter->hw;
 	struct pci_dev *pdev = adapter->pdev;
+	struct e1000_hw *hw = &adapter->hw;
+	struct napi_struct *napi;
 	int err;
 	int i;
 
@@ -4169,8 +4191,11 @@ static int __igb_open(struct net_device *netdev, bool resuming)
 	/* From here on the code is the same as igb_up() */
 	clear_bit(__IGB_DOWN, &adapter->state);
 
-	for (i = 0; i < adapter->num_q_vectors; i++)
-		napi_enable(&(adapter->q_vector[i]->napi));
+	for (i = 0; i < adapter->num_q_vectors; i++) {
+		napi = &adapter->q_vector[i]->napi;
+		napi_enable(napi);
+		igb_set_queue_napi(adapter, i, napi);
+	}
 
 	/* Clear any pending interrupts. */
 	rd32(E1000_TSICR);
@@ -9677,8 +9702,11 @@ static pci_ers_result_t igb_io_error_detected(struct pci_dev *pdev,
 	if (state == pci_channel_io_perm_failure)
 		return PCI_ERS_RESULT_DISCONNECT;
 
+	rtnl_lock();
 	if (netif_running(netdev))
 		igb_down(adapter);
+	rtnl_unlock();
+
 	pci_disable_device(pdev);
 
 	/* Request a slot reset. */
@@ -9737,16 +9765,21 @@ static void igb_io_resume(struct pci_dev *pdev)
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct igb_adapter *adapter = netdev_priv(netdev);
 
+	rtnl_lock();
 	if (netif_running(netdev)) {
 		if (!test_bit(__IGB_DOWN, &adapter->state)) {
 			dev_dbg(&pdev->dev, "Resuming from non-fatal error, do nothing.\n");
+			rtnl_unlock();
 			return;
 		}
+
 		if (igb_up(adapter)) {
 			dev_err(&pdev->dev, "igb_up failed after reset\n");
+			rtnl_unlock();
 			return;
 		}
 	}
+	rtnl_unlock();
 
 	netif_device_attach(netdev);
 
-- 
2.47.1


