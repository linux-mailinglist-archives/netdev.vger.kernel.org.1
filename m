Return-Path: <netdev+bounces-19920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F97675CD26
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 18:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 809871C216C2
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 16:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03981F95D;
	Fri, 21 Jul 2023 16:06:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FC71F95A
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 16:06:40 +0000 (UTC)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F9C2D50
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 09:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689955598; x=1721491598;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M+oQ4D+33cBEy8mDpxzRmC9Tl6J5wnO4BnVGmmhPTug=;
  b=P5k8tdL33L43xhVTKXHJ8y/0kIBaKpr/6tvVg6Ad5jGcp6UHjxf+/pF7
   RJwQ1J4jyDUGsiyHcpzooOg83Y1SBRFJ/FDDzFKP46Fu1joigA/zj1Hr2
   xmb/X+Is/rLoGyNMyuFxgeAtGC436yBK83FpruVsbxtCcG058q2xC0X5P
   seJVrTunQXsBeOfyom2GH/huem/4K+0ZYzpTWRqzPR5ArTj0iajL3x3Ww
   oaGVFGfRxLks/Jn3y9gBcYUSYrVpUL34/kYvfXJlCNDbL42YFRTTs03xP
   T0Hqh+1NhkZKgcfeYhO9yVeNBObLiGsD2cDv+dRWYgtF4hTl8hyj3M+Wf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="357047112"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="357047112"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 09:04:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="868279416"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga001.fm.intel.com with ESMTP; 21 Jul 2023 09:04:15 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 3/3] iavf: check for removal state before IAVF_FLAG_PF_COMMS_FAILED
Date: Fri, 21 Jul 2023 08:58:12 -0700
Message-Id: <20230721155812.1292752-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230721155812.1292752-1-anthony.l.nguyen@intel.com>
References: <20230721155812.1292752-1-anthony.l.nguyen@intel.com>
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
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jacob Keller <jacob.e.keller@intel.com>

In iavf_adminq_task(), if the function can't acquire the
adapter->crit_lock, it checks if the driver is removing. If so, it simply
exits without re-enabling the interrupt. This is done to ensure that the
task stops processing as soon as possible once the driver is being removed.

However, if the IAVF_FLAG_PF_COMMS_FAILED is set, the function checks this
before attempting to acquire the lock. In this case, the function exits
early and re-enables the interrupt. This will happen even if the driver is
already removing.

Avoid this, by moving the check to after the adapter->crit_lock is
acquired. This way, if the driver is removing, we will not re-enable the
interrupt.

Fixes: fc2e6b3b132a ("iavf: Rework mutexes for better synchronisation")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 939c8126eb43..9610ca770349 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -3250,9 +3250,6 @@ static void iavf_adminq_task(struct work_struct *work)
 	u32 val, oldval;
 	u16 pending;
 
-	if (adapter->flags & IAVF_FLAG_PF_COMMS_FAILED)
-		goto out;
-
 	if (!mutex_trylock(&adapter->crit_lock)) {
 		if (adapter->state == __IAVF_REMOVE)
 			return;
@@ -3261,6 +3258,9 @@ static void iavf_adminq_task(struct work_struct *work)
 		goto out;
 	}
 
+	if (adapter->flags & IAVF_FLAG_PF_COMMS_FAILED)
+		goto unlock;
+
 	event.buf_len = IAVF_MAX_AQ_BUF_SIZE;
 	event.msg_buf = kzalloc(event.buf_len, GFP_KERNEL);
 	if (!event.msg_buf)
-- 
2.38.1


