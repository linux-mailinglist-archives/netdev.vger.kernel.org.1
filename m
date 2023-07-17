Return-Path: <netdev+bounces-18379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F2C756B1B
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 19:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 385AE1C20A8C
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 17:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1888BE6F;
	Mon, 17 Jul 2023 17:58:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D690DC133
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 17:58:19 +0000 (UTC)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15221BE
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 10:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689616698; x=1721152698;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Gi1zeN5Cnxv07MWAi1RwPBNdJqUqWBMY3+iSeyYBaSg=;
  b=krzrlOv8QIYnx6xCmFc/UItqqhoAGw2ICF9csYz5hDvfEEswfI3tk4xQ
   n4KbneG4k5rs8m7O/SvBtancHf3kXUMuQt3E8AoyalUR9YGtWEa6BqomC
   Ex1u/CaKdGGOJUvNjMfL0x3+NQhLCoVN5z7/NYBdl5MBHtQrrhsVaMNNm
   n6BejQBUOmnEecqe1LnPeE60A21VyS9EUUJoOYnkwYd8V6Fl9xr1C7r8x
   Kxo45HctRfvVh53tku7F5+5uSgo/OKnH32kdcLygXBl4SSrmTB3nPV5Fu
   J3v0MBrxx8B7/ns+UjRvekoCNx58LxdoMEJ/f30eL54DKlmrs4hXU4pQx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="432172688"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="432172688"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 10:58:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="723294576"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="723294576"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga002.jf.intel.com with ESMTP; 17 Jul 2023 10:58:00 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Marcin Szycik <marcin.szycik@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	ivecera@redhat.com,
	sassmann@kpanic.de,
	Mateusz Palczewski <mateusz.palczewski@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 6/8] Revert "iavf: Do not restart Tx queues after reset task failure"
Date: Mon, 17 Jul 2023 10:52:03 -0700
Message-Id: <20230717175205.3217774-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230717175205.3217774-1-anthony.l.nguyen@intel.com>
References: <20230717175205.3217774-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Marcin Szycik <marcin.szycik@linux.intel.com>

This reverts commit 08f1c147b7265245d67321585c68a27e990e0c4b.

Netdev is no longer being detached during reset, so this fix can be
reverted. We leave the removal of "hacky" IFF_UP flag update.

Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 957ad6e63f6f..0c12a752429c 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -3042,11 +3042,6 @@ static void iavf_reset_task(struct work_struct *work)
 		iavf_disable_vf(adapter);
 		mutex_unlock(&adapter->client_lock);
 		mutex_unlock(&adapter->crit_lock);
-		if (netif_running(netdev)) {
-			rtnl_lock();
-			dev_close(netdev);
-			rtnl_unlock();
-		}
 		return; /* Do not attempt to reinit. It's dead, Jim. */
 	}
 
@@ -3197,16 +3192,6 @@ static void iavf_reset_task(struct work_struct *work)
 
 	mutex_unlock(&adapter->client_lock);
 	mutex_unlock(&adapter->crit_lock);
-
-	if (netif_running(netdev)) {
-		/* Close device to ensure that Tx queues will not be started
-		 * during netif_device_attach() at the end of the reset task.
-		 */
-		rtnl_lock();
-		dev_close(netdev);
-		rtnl_unlock();
-	}
-
 	dev_err(&adapter->pdev->dev, "failed to allocate resources during reinit\n");
 }
 
-- 
2.38.1


