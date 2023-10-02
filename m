Return-Path: <netdev+bounces-37501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE057B5B0A
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 21:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 6A8432830C2
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 19:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B75B1F928;
	Mon,  2 Oct 2023 19:16:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A591F5E1
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 19:16:01 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB635AC
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 12:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696274159; x=1727810159;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3IMw7hY48juzKYwXAmSDO1uVjENICRzO+phMs3frzyU=;
  b=YWM01TcukvY0r/JeSWaU9py4pFCAIOUsn38TJT9jnuWth3Wgn+bDnYcb
   0b4s4sJrTyvM5clYM6969X8PBTMm2JrSIfWePHh8KC7PXPRS6TF6HQXJT
   LJEuuBolqKjCiorXShtLSeJvsG3vI5xdJlSiyGGkWfN8C9FvAxe9xiPWB
   L0dC5M43YnEldiA5Lj26n2e0Xz7vJYBuK/G/OOLG+5u08FfU0bEm1SVMI
   c85J6QCGrPZ11k3m8M65QwJBVxCtJ+DzbkovNkN/puYnAsNlDZKtXCfSP
   mEEPpucgE3smDlHoEBVPVmIhKPeYN6oND5fCnZNIIB+rwh+e5lmSIoWyN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="373055036"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="373055036"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 11:51:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="780011942"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="780011942"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga008.jf.intel.com with ESMTP; 02 Oct 2023 11:51:29 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next 3/3] iavf: Avoid a memory allocation in iavf_print_link_message()
Date: Mon,  2 Oct 2023 11:50:34 -0700
Message-Id: <20231002185034.1575127-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231002185034.1575127-1-anthony.l.nguyen@intel.com>
References: <20231002185034.1575127-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

IAVF_MAX_SPEED_STRLEN is only 13 and 'speed' is allocated and freed within
iavf_print_link_message().

'speed' is only used with some snprintf() and netdev_info() calls.

So there is no real use to kzalloc()/free() it. Use the stack instead.
This saves a memory allocation.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 8ce6389b5815..980dc69d7fbe 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -1389,18 +1389,14 @@ void iavf_disable_vlan_insertion_v2(struct iavf_adapter *adapter, u16 tpid)
 static void iavf_print_link_message(struct iavf_adapter *adapter)
 {
 	struct net_device *netdev = adapter->netdev;
+	char speed[IAVF_MAX_SPEED_STRLEN];
 	int link_speed_mbps;
-	char *speed;
 
 	if (!adapter->link_up) {
 		netdev_info(netdev, "NIC Link is Down\n");
 		return;
 	}
 
-	speed = kzalloc(IAVF_MAX_SPEED_STRLEN, GFP_KERNEL);
-	if (!speed)
-		return;
-
 	if (ADV_LINK_SUPPORT(adapter)) {
 		link_speed_mbps = adapter->link_speed_mbps;
 		goto print_link_msg;
@@ -1452,7 +1448,6 @@ static void iavf_print_link_message(struct iavf_adapter *adapter)
 	}
 
 	netdev_info(netdev, "NIC Link is Up Speed is %s Full Duplex\n", speed);
-	kfree(speed);
 }
 
 /**
-- 
2.38.1


