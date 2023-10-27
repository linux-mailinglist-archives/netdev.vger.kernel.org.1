Return-Path: <netdev+bounces-44818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 613597D9F37
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 20:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A01E2824F6
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 18:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DE93C091;
	Fri, 27 Oct 2023 17:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hDBSMvuN"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E873B78A
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 17:59:55 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB5A1A6
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 10:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698429594; x=1729965594;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E9BuDQ9BJvy7EQRkC0IbrVK+afYZUQObohW4d/VSvbw=;
  b=hDBSMvuN9YzaIB+y5FbPVjt7MOCh5sG/YV5hj9+IqRQVDQj8zYqEydd3
   uHiiMxoSnCsnZqgBxtmHYFZOyo2hlVF6UFf6iMcbKzfeXVgILlpPn7PPX
   t92y3EPyn7cfAK8ugG8nrlIiOJlnfOTJUslXPmsQ7awJcU3NlrpOJYoKH
   acIcAzZYOCvEH3jLAk3fuJpf09xN1SKTVgsXFfutZy7uq1n0aG0cbGFQj
   Z1JQC3i/QEuv00q298G+k/55/QU+a6ERRjtvn/RGOkNSCTMCGVD8XmfG/
   Oe9kpGv5QmFLSN02JDozal6RgKQxz0MYey/k/yDOsly34h9tOf+K8BD0U
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="391695523"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="391695523"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 10:59:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="830064630"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="830064630"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 10:59:48 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Michal Schmidt <mschmidt@redhat.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next v2 5/8] iavf: rely on netdev's own registered state
Date: Fri, 27 Oct 2023 10:59:38 -0700
Message-ID: <20231027175941.1340255-6-jacob.e.keller@intel.com>
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

The information whether a netdev has been registered is already present
in the netdev itself. There's no need for a driver flag with the same
meaning.

Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
No changes since v1.

 drivers/net/ethernet/intel/iavf/iavf.h      | 1 -
 drivers/net/ethernet/intel/iavf/iavf_main.c | 9 +++------
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index 44daf335e8c5..f026d0670338 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -377,7 +377,6 @@ struct iavf_adapter {
 	unsigned long crit_section;
 
 	struct delayed_work watchdog_task;
-	bool netdev_registered;
 	bool link_up;
 	enum virtchnl_link_speed link_speed;
 	/* This is only populated if the VIRTCHNL_VF_CAP_ADV_LINK_SPEED is set
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index e87213687027..b6fe42547cc3 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -2021,7 +2021,7 @@ static void iavf_finish_config(struct work_struct *work)
 	mutex_lock(&adapter->crit_lock);
 
 	if ((adapter->flags & IAVF_FLAG_SETUP_NETDEV_FEATURES) &&
-	    adapter->netdev_registered &&
+	    adapter->netdev->reg_state == NETREG_REGISTERED &&
 	    !test_bit(__IAVF_IN_REMOVE_TASK, &adapter->crit_section)) {
 		netdev_update_features(adapter->netdev);
 		adapter->flags &= ~IAVF_FLAG_SETUP_NETDEV_FEATURES;
@@ -2029,7 +2029,7 @@ static void iavf_finish_config(struct work_struct *work)
 
 	switch (adapter->state) {
 	case __IAVF_DOWN:
-		if (!adapter->netdev_registered) {
+		if (adapter->netdev->reg_state != NETREG_REGISTERED) {
 			err = register_netdevice(adapter->netdev);
 			if (err) {
 				dev_err(&adapter->pdev->dev, "Unable to register netdev (%d)\n",
@@ -2043,7 +2043,6 @@ static void iavf_finish_config(struct work_struct *work)
 						  __IAVF_INIT_CONFIG_ADAPTER);
 				goto out;
 			}
-			adapter->netdev_registered = true;
 		}
 
 		/* Set the real number of queues when reset occurs while
@@ -5169,10 +5168,8 @@ static void iavf_remove(struct pci_dev *pdev)
 	cancel_work_sync(&adapter->finish_config);
 
 	rtnl_lock();
-	if (adapter->netdev_registered) {
+	if (netdev->reg_state == NETREG_REGISTERED)
 		unregister_netdevice(netdev);
-		adapter->netdev_registered = false;
-	}
 	rtnl_unlock();
 
 	if (CLIENT_ALLOWED(adapter)) {
-- 
2.41.0


