Return-Path: <netdev+bounces-43674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA117D4312
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 01:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A343B20FD4
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 23:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCFB24A15;
	Mon, 23 Oct 2023 23:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Aex+H9Xg"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424D124217
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 23:08:36 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5283D7A
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 16:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698102515; x=1729638515;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P28q3QbVY526Tunt5+xFmjSvvrdebjnXGMgb7261zrY=;
  b=Aex+H9XgIO2AybZAis3zgeyC4k1xYJbjxbUtEe/1e7AzugfRgoCNNXt8
   S/1gKy+eoAAvMhkehkFFNqgJ02J+4kFwj2EMDUyq6WirAHNGZpqwvSX6Y
   Pw+kdc9hmpQTx5L78PLVlFE40cGM40iJ7aCxJ17Dprg7h69+Vkc3YB9La
   83K4RZQENOLJMfdjZ2st16ikA25mvxgTVHuoO+alakzlA31VTrKSLU9CM
   93GBgqmq/3zkaOWFfLNhpl1dbyx8ySRJbfKQKzdoyyiJcJEoHBnjnkw5a
   lLTQHzq9Q13ZjNGdfE2mnFZpH7ufkYOSfjrOekCAyGyPu/PesMaG6mHbC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="5573719"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="5573719"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 16:08:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="793288335"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="793288335"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 16:08:31 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Michal Schmidt <mschmidt@redhat.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next 6/9] iavf: rely on netdev's own registered state
Date: Mon, 23 Oct 2023 16:08:23 -0700
Message-ID: <20231023230826.531858-8-jacob.e.keller@intel.com>
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

The information whether a netdev has been registered is already present
in the netdev itself. There's no need for a driver flag with the same
meaning.

Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
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
index 36d72f30ffce..6e93e73385b3 100644
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
@@ -5168,10 +5167,8 @@ static void iavf_remove(struct pci_dev *pdev)
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


