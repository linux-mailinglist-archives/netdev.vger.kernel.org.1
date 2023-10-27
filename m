Return-Path: <netdev+bounces-44819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3941B7D9F38
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 20:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E73082824E7
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 18:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3B63C09A;
	Fri, 27 Oct 2023 17:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TOkUlmcP"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A723B7A1
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 17:59:56 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE15F4
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 10:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698429595; x=1729965595;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=08yTqtBx+9lbglslfUC+cHQfpUb9R1dbrI2xNssThOE=;
  b=TOkUlmcP6JZTk2z3aev+vZjZYVmIa5Vsjj9RHh98EuXy6k3gfGcAFYg/
   4QfrFwdZiY+TTsows+InewdfAlT6TTasKLJwXvbduMLHW5GhAQEH+l1s9
   fazG55zBRGolAVZ4gny0JcNZcB2Ucgl6V6EpTXKDAmqG3Sq2i0rgE384n
   GSwxPituzYd6gmnsJsJCNaoUPWXQd4i0ySBo6W9MFFZB8tVEhomqvHb2+
   7xc0HE4NBPCJc/gTN3KTXyJJNq0mbdFeWBPJ47zQRFj4PovGxb4AoGGrQ
   KB5Ck7HM1aJeOLRA6lfGDx3RKTGYItBLPOvO6t77TApQ8HLpDC46a5BD6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="391695530"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="391695530"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 10:59:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="830064637"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="830064637"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 10:59:49 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Michal Schmidt <mschmidt@redhat.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next v2 7/8] iavf: add a common function for undoing the interrupt scheme
Date: Fri, 27 Oct 2023 10:59:40 -0700
Message-ID: <20231027175941.1340255-8-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231027175941.1340255-1-jacob.e.keller@intel.com>
References: <20231027175941.1340255-1-jacob.e.keller@intel.com>
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
No changes since v1.

 drivers/net/ethernet/intel/iavf/iavf_main.c | 26 ++++++++++++---------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 8a7edeb8f12c..8b63b81c5060 100644
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
@@ -5202,9 +5209,7 @@ static void iavf_remove(struct pci_dev *pdev)
 	iavf_free_all_tx_resources(adapter);
 	iavf_free_all_rx_resources(adapter);
 	iavf_free_misc_irq(adapter);
-
-	iavf_reset_interrupt_capability(adapter);
-	iavf_free_q_vectors(adapter);
+	iavf_free_interrupt_scheme(adapter);
 
 	iavf_free_rss(adapter);
 
@@ -5220,7 +5225,6 @@ static void iavf_remove(struct pci_dev *pdev)
 
 	iounmap(hw->hw_addr);
 	pci_release_regions(pdev);
-	iavf_free_queues(adapter);
 	kfree(adapter->vf_res);
 	spin_lock_bh(&adapter->mac_vlan_list_lock);
 	/* If we got removed before an up/down sequence, we've got a filter
-- 
2.41.0


