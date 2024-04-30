Return-Path: <netdev+bounces-92579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C116A8B7F73
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 20:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7512C285771
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 18:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC8F194C6B;
	Tue, 30 Apr 2024 18:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i7MH+gxd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D54518411A
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 18:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714500408; cv=none; b=KDZgmbQ/kvKrJPIFdW2NjxviUhHQ4vwNCzP6ju5JAzqeqJBvfQ0KeOd59UdL/pVsUDZt6jSB6FKOV28VKka/+psM+925+zDFVcpG3pCGKtWqJGheHzPb269Y8hW3m7Sl/VFIWq92vS3Yl0p2XOlNwCqZiEV0TJu7fppl3We7AMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714500408; c=relaxed/simple;
	bh=WnRtOkgb3swbIcEbBchCGCEb3VWsoRwKtyTpHsMSpOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KKFPssbwb/6xNGbUT088N/appl0rETebEpjLi7d/UoWUdMOGcVMdwS9WpS7J1vLpiRDPv30kfQZ8xp5s06QLTvp1t2xom2IdR+X87FFEq+6j9awicJqIzal3lk6w24I/HP/vWDWu8Xn+JfiKyuf5V94iGfytkEqaFYUngF1mE3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i7MH+gxd; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714500406; x=1746036406;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WnRtOkgb3swbIcEbBchCGCEb3VWsoRwKtyTpHsMSpOk=;
  b=i7MH+gxdvQQ2E+GRwGHluVLanWGbvefkjoMnUlaev52zjllgnQLSGNHe
   mH8dPgbsTevUA9GY7y2yJl/a6+hopYVsMtYe8ira3PqcXV7iFSUGpEksm
   T7fzNtVXgbuaiqjdbho8T9gcR38qThIDlZmSehT6KEDutFUoUOG0emiub
   r1KgKUzGptiPxKdLp8xK07+DtobiPYJtpKygZ5G+t5MzXICuy472nukWM
   WyzHLz/NjQixYHp9Pj7/IW3JM2UQszivT771khJQSS0awPr6T7qiC0D6F
   FyvhYUD6QrkSY7Q3uN8lx+ulqLLi3zkBpjpTJhzHub5KDNPDC+MlIDfRO
   w==;
X-CSE-ConnectionGUID: u9y44A1YQhum9dnVCwUfXg==
X-CSE-MsgGUID: XL0yFaGOSR+13eHBUnCZIg==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="20839425"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="20839425"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 11:06:44 -0700
X-CSE-ConnectionGUID: 1Qf5z8naQ1eSxPDkTeH0Hw==
X-CSE-MsgGUID: /GjbO+TORH+EbniFnrZ78Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="31147300"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 30 Apr 2024 11:06:44 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>,
	anthony.l.nguyen@intel.com,
	Michal Schmidt <mschmidt@redhat.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 3/7] i40e: Refactor argument of i40e_detect_recover_hung()
Date: Tue, 30 Apr 2024 11:06:33 -0700
Message-ID: <20240430180639.1938515-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240430180639.1938515-1-anthony.l.nguyen@intel.com>
References: <20240430180639.1938515-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ivan Vecera <ivecera@redhat.com>

Commit 07d44190a389 ("i40e/i40evf: Detect and recover hung queue
scenario") changes i40e_detect_recover_hung() argument type from
i40e_pf* to i40e_vsi* to be shareable by both i40e and i40evf.
Because the i40evf does not exist anymore and the function is
exclusively used by i40e we can revert this change.

Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c |  2 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 10 ++++++----
 drivers/net/ethernet/intel/i40e/i40e_txrx.h |  2 +-
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index aa874d6ff8c3..4291001d0053 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -11267,7 +11267,7 @@ static void i40e_service_task(struct work_struct *work)
 		return;
 
 	if (!test_bit(__I40E_RECOVERY_MODE, pf->state)) {
-		i40e_detect_recover_hung(pf->vsi[pf->lan_vsi]);
+		i40e_detect_recover_hung(pf);
 		i40e_sync_filters_subtask(pf);
 		i40e_reset_subtask(pf);
 		i40e_handle_mdd_event(pf);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index bc9e766d88cb..fa08b0297925 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -861,13 +861,15 @@ u32 i40e_get_tx_pending(struct i40e_ring *ring, bool in_sw)
 
 /**
  * i40e_detect_recover_hung - Function to detect and recover hung_queues
- * @vsi:  pointer to vsi struct with tx queues
+ * @pf: pointer to PF struct
  *
- * VSI has netdev and netdev has TX queues. This function is to check each of
- * those TX queues if they are hung, trigger recovery by issuing SW interrupt.
+ * LAN VSI has netdev and netdev has TX queues. This function is to check
+ * each of those TX queues if they are hung, trigger recovery by issuing
+ * SW interrupt.
  **/
-void i40e_detect_recover_hung(struct i40e_vsi *vsi)
+void i40e_detect_recover_hung(struct i40e_pf *pf)
 {
+	struct i40e_vsi *vsi = pf->vsi[pf->lan_vsi];
 	struct i40e_ring *tx_ring = NULL;
 	struct net_device *netdev;
 	unsigned int i;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
index 2cdc7de6301c..7c26c9a2bf65 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
@@ -470,7 +470,7 @@ void i40e_free_rx_resources(struct i40e_ring *rx_ring);
 int i40e_napi_poll(struct napi_struct *napi, int budget);
 void i40e_force_wb(struct i40e_vsi *vsi, struct i40e_q_vector *q_vector);
 u32 i40e_get_tx_pending(struct i40e_ring *ring, bool in_sw);
-void i40e_detect_recover_hung(struct i40e_vsi *vsi);
+void i40e_detect_recover_hung(struct i40e_pf *pf);
 int __i40e_maybe_stop_tx(struct i40e_ring *tx_ring, int size);
 bool __i40e_chk_linearize(struct sk_buff *skb);
 int i40e_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
-- 
2.41.0


