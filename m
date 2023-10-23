Return-Path: <netdev+bounces-43676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E70297D4313
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 01:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E16751C20B3C
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 23:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45704250F1;
	Mon, 23 Oct 2023 23:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FkvmDCcf"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AC3249EF
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 23:08:36 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F4FD7E
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 16:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698102516; x=1729638516;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Km+I8XmrSwLBQny/aoCpsEq7zm/AqZZtJ2xTyWIc7mg=;
  b=FkvmDCcft4zB5gEPc+P4G/OJ+9gxXdHNJmfn199sJc7e4HPQYgjZJ4vV
   +VgZ5SQqlpI/pGs1D8QJFErXUwUy0NVRuQbbC6BaZ5uH7H2ICQAc/OODb
   y7YvtC8rwHYjZFSDi3UljD3KpQTMI7B/4e1giEFc2fLcWz3RtDkMkRsR5
   /YDEGbO8x/bK5/+uJjuIQKFahnaFp8ungC5S1qJJSRK0LOnOrLbsW6sI+
   RnfNVdufaHysJB3FX5a1mKxOOfTUyBevFPCQL9BMVUP9L1J7AlFhDv9Tn
   CtNVOlAKsGahGAbvIkIP/sGtb1r3lktd48SRwhZpvJL67946u/8eDUYCY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="5573727"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="5573727"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 16:08:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="793288341"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="793288341"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 16:08:31 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Michal Schmidt <mschmidt@redhat.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next 8/9] iavf: add a common function for undoing the interrupt scheme
Date: Mon, 23 Oct 2023 16:08:25 -0700
Message-ID: <20231023230826.531858-10-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231023230826.531858-1-jacob.e.keller@intel.com>
References: <20231023230826.531858-1-jacob.e.keller@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Schmidt <mschmidt@redhat.com>

Add a new function iavf_free_interrupt_scheme that does the inverse of
iavf_init_interrupt_scheme. Symmetry is nice. And there will be three
callers already.

Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 26 ++++++++++++---------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 85252b9dce50..49a764ca5e36 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1954,6 +1954,17 @@ static int iavf_init_interrupt_scheme(struct iavf_adapter *adapter)
 	return err;
 }
 
+/**
+ * iavf_free_interrupt_scheme - Undo what iavf_init_interrupt_scheme does
+ * @adapter: board private structure
+ **/
+static void iavf_free_interrupt_scheme(struct iavf_adapter *adapter)
+{
+	iavf_free_q_vectors(adapter);
+	iavf_reset_interrupt_capability(adapter);
+	iavf_free_queues(adapter);
+}
+
 /**
  * iavf_free_rss - Free memory used by RSS structs
  * @adapter: board private structure
@@ -1982,11 +1993,9 @@ static int iavf_reinit_interrupt_scheme(struct iavf_adapter *adapter, bool runni
 	if (running)
 		iavf_free_traffic_irqs(adapter);
 	iavf_free_misc_irq(adapter);
-	iavf_reset_interrupt_capability(adapter);
-	iavf_free_q_vectors(adapter);
-	iavf_free_queues(adapter);
+	iavf_free_interrupt_scheme(adapter);
 
-	err =  iavf_init_interrupt_scheme(adapter);
+	err = iavf_init_interrupt_scheme(adapter);
 	if (err)
 		goto err;
 
@@ -2968,9 +2977,7 @@ static void iavf_disable_vf(struct iavf_adapter *adapter)
 	spin_unlock_bh(&adapter->cloud_filter_list_lock);
 
 	iavf_free_misc_irq(adapter);
-	iavf_reset_interrupt_capability(adapter);
-	iavf_free_q_vectors(adapter);
-	iavf_free_queues(adapter);
+	iavf_free_interrupt_scheme(adapter);
 	memset(adapter->vf_res, 0, IAVF_VIRTCHNL_VF_RESOURCE_SIZE);
 	iavf_shutdown_adminq(&adapter->hw);
 	adapter->flags &= ~IAVF_FLAG_RESET_PENDING;
@@ -5201,9 +5208,7 @@ static void iavf_remove(struct pci_dev *pdev)
 	iavf_free_all_tx_resources(adapter);
 	iavf_free_all_rx_resources(adapter);
 	iavf_free_misc_irq(adapter);
-
-	iavf_reset_interrupt_capability(adapter);
-	iavf_free_q_vectors(adapter);
+	iavf_free_interrupt_scheme(adapter);
 
 	iavf_free_rss(adapter);
 
@@ -5219,7 +5224,6 @@ static void iavf_remove(struct pci_dev *pdev)
 
 	iounmap(hw->hw_addr);
 	pci_release_regions(pdev);
-	iavf_free_queues(adapter);
 	kfree(adapter->vf_res);
 	spin_lock_bh(&adapter->mac_vlan_list_lock);
 	/* If we got removed before an up/down sequence, we've got a filter
-- 
2.41.0


