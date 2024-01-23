Return-Path: <netdev+bounces-65271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CE1839D47
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 00:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC7821F2839A
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 23:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A0754BCE;
	Tue, 23 Jan 2024 23:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V9EY6PQ6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556725576B
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 23:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706052745; cv=none; b=kHt5E1hsP81VzDiH15vGuPevUA44DKwTqMAgD18jpdFT4tfN2IvY9JmC1HcdUv65+izMij9ZYjPUnoCA0H9wBLYu5zpXR42BIbbnV0NRSsDK/yloIQs0Odx6WfOBnAFUOjJi8cTZ/kxYQ8N/ufZ5eol0ghblA9ke/z9D36tElyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706052745; c=relaxed/simple;
	bh=q/5vsad5MYoN6BZtaPyi2TJltKyoqLDcM6qesTKrXf8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZPF3d8+rdxB4TpkggcMjCX5ITer2UDv/jBzC2vebBLmNyAcHVaHAz/zoqnuNmARkUWHza16Kn44Hjqb7svSdSGTr6XYplfh9WKnBUG9FsMzZ52L0xMIkVqCoBJdj5/33CGpYpTLQMWUfb4w0/xTqARH2J5o4vSgivPSC+Cfo5Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V9EY6PQ6; arc=none smtp.client-ip=192.55.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706052743; x=1737588743;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q/5vsad5MYoN6BZtaPyi2TJltKyoqLDcM6qesTKrXf8=;
  b=V9EY6PQ6HJbQ7EhO4xDQw+OihFDLVhB4gJLErpsme3l/XbEl5bopD26V
   DovoZuGylxONCLMxgOB5QV/TW12NBejK9iFX2dQb5AWzS1SIjPyaslK/Y
   9IxnuDLQOP/wOQXua2v/xvk2meKwUXrvkcsOQzMbv8ev8XuvxzzMfGD99
   HdArclu3GTX5CrNNgv1pWeogRf0rvJzTGzDJcz392YQv4Yvv46I65CW7G
   gmmJat6QyuZJqFtTBUEYDkDxCnrYc4TixwpViRH3V27/GC0oR3VYlOoBf
   XSVAN1gVTsmcN2Yak/rdyNAPE5UBYFYxEX6w9KdiFR42UWcte0ITN3uai
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="400552263"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="400552263"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 15:32:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="909469586"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="909469586"
Received: from gkon-mobl1.ger.corp.intel.com (HELO azaki-desk1.intel.com) ([10.252.41.99])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 15:32:06 -0800
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH iwl-net 2/2] iavf: allow an early reset event to be processed
Date: Tue, 23 Jan 2024 16:31:40 -0700
Message-Id: <20240123233140.309522-3-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123233140.309522-1-ahmed.zaki@intel.com>
References: <20240123233140.309522-1-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a reset event is received from the PF early in the init cycle, the
iavf state machine could hang for about 25 seconds. For example:

    # echo 1 > /sys/class/net/enp175s0np0/device/sriov_numvfs && \
      ip link set dev enp175s0np0 vf 0 mac <new_mac>

the log shows:

    [532.770534] ice 0000:af:00.0: Enabling 1 VFs
    [532.880439] iavf 0000:af:01.0: enabling device (0000 -> 0002)
    [532.880983] ice 0000:af:00.0: Enabling 1 VFs with 17 vectors and 16 queues per VF
    [532.916547] ice 0000:af:00.0 enp175s0np0: Setting MAC 00:60:2f:20:3f:28 on VF 0. VF driver will be reinitialized
    [553.464990] iavf 0000:af:01.0: Failed to communicate with PF; waiting before retry
    [558.903000] iavf 0000:af:01.0: Hardware came out of reset. Attempting reinit.
    [558.984816] iavf 0000:af:01.0: Multiqueue Enabled: Queue pair count = 16

This happens because reset events are ignored in the early states where
the misc irq vector is not initialized yet and communicating with the PF
is through polling the AQ buffer. Fix by scanning the received OP
codes for a reset event and scheduling the reset task if a reset event
is received.

Fixes: 5eae00c57f5e ("i40evf: main driver core")
Reviewed-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
---
 .../net/ethernet/intel/iavf/iavf_virtchnl.c    | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 22f2df7c460b..9d8a5d3adcee 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -76,6 +76,24 @@ iavf_poll_virtchnl_msg(struct iavf_hw *hw, struct iavf_arq_event_info *event,
 			return iavf_status_to_errno(status);
 		received_op =
 		    (enum virtchnl_ops)le32_to_cpu(event->desc.cookie_high);
+
+		if (received_op == VIRTCHNL_OP_EVENT) {
+			struct iavf_adapter *adapter = hw->back;
+			struct virtchnl_pf_event *vpe =
+				(struct virtchnl_pf_event *)event->msg_buf;
+
+			if (vpe->event != VIRTCHNL_EVENT_RESET_IMPENDING)
+				continue;
+
+			dev_info(&adapter->pdev->dev, "Reset indication received from the PF\n");
+			if (!(adapter->flags & IAVF_FLAG_RESET_PENDING)) {
+				dev_info(&adapter->pdev->dev, "Scheduling reset task\n");
+				iavf_schedule_reset(adapter,
+						    IAVF_FLAG_RESET_PENDING);
+			}
+			return -EIO;
+		}
+
 		if (op_to_poll == received_op)
 			break;
 	}
-- 
2.34.1


