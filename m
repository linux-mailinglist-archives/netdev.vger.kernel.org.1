Return-Path: <netdev+bounces-74130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA01586022F
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 20:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F2DE1F2AA9C
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 19:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B326AF9C;
	Thu, 22 Feb 2024 19:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DQrt32/e"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E936AF8E
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 19:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708628710; cv=none; b=YX4XhIrMnZ3akzCIEtn8LM7djbXYDmuNoXRQukZbpk84XLMhDO+3vJWLiruAGZhU5xpKbu6/G6HpzuD8lFkZZQQW5M5gBLV8dU7AnrFgpes6mnXbmqEknchIUcW65fG7ainp06TJ3wosxRxs5vTzqUYpbknAPogxw/HBSDhd/qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708628710; c=relaxed/simple;
	bh=cWJeW5MHlMpqXjOeEjoOrbFkjvB0IZ2p+tB7LA0Zb9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KgGBAVJkwquQy4ON/ls8ZRT8GxtpjDwEiJNpANviwuko49hNJXYGr39r1tFjHz25uh/4nY4O3yFykqLxiDIs4a/p+S8H902Q++3m51RNr1SOc3JdR19HWQbeeiYZeOKgYdzRnej4qy3+ueGssEt5d9SDIO1dkvgNmTG4q9P7qWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DQrt32/e; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708628709; x=1740164709;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cWJeW5MHlMpqXjOeEjoOrbFkjvB0IZ2p+tB7LA0Zb9Q=;
  b=DQrt32/eivTLjE+s079C8hN1/YLXqi4QK75ZtG1bYeSJsBzzoL07E74c
   NK6C+WizKLySThLFO0Wo1ZxyD+vxv8WZoFdPmyMV/L/tMZ15SYbDSX5Ak
   cEi+A0Zwm7e0EpDpoOpvKRbpTurwleAPT4B63+apk6f1s3ViprdVsZbeZ
   jqOwGgSBqQQqeWx4jbDa6aKfj4PXHg1xi9dAW24Xw4Nryz6TQ16QNluaL
   kJyzfyXk8ExeGE0t71Gn8fVXbCOB0Qbkexb4V70Uat3+xt4nL6qau7W0U
   19XOeO21Qu35ZK7amJ8hl9Q97uiRefSEB/bMNSzgfcbqJQtgWwMlub31Y
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="13506396"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="13506396"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 11:05:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="10171393"
Received: from dev1-atbrady.jf.intel.com ([10.166.241.35])
  by fmviesa004.fm.intel.com with ESMTP; 22 Feb 2024 11:05:08 -0800
From: Alan Brady <alan.brady@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Alan Brady <alan.brady@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: [PATCH v6 09/11 iwl-next] idpf: prevent deinit uninitialized virtchnl core
Date: Thu, 22 Feb 2024 11:04:39 -0800
Message-ID: <20240222190441.2610930-10-alan.brady@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240222190441.2610930-1-alan.brady@intel.com>
References: <20240222190441.2610930-1-alan.brady@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In idpf_remove we need to tear down the virtchnl core with
idpf_vc_core_deinit so we can free up resources and leave things in a
good state. However, in the case where we failed to establish VC
communications we may not have ever actually successfully initialized
the virtchnl core.

This fixes it by setting a bit once we successfully init the virtchnl
core.  Then, in deinit, we'll check for it before going on further,
otherwise we just return. Also clear the bit at the end of deinit so we
know it's gone now.

Tested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Alan Brady <alan.brady@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h          |  2 ++
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 10 ++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 5ed08be1dbc0..e7a036538246 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -83,6 +83,7 @@ enum idpf_state {
  * @IDPF_HR_RESET_IN_PROG: Reset in progress
  * @IDPF_REMOVE_IN_PROG: Driver remove in progress
  * @IDPF_MB_INTR_MODE: Mailbox in interrupt mode
+ * @IDPF_VC_CORE_INIT: virtchnl core has been init
  * @IDPF_FLAGS_NBITS: Must be last
  */
 enum idpf_flags {
@@ -91,6 +92,7 @@ enum idpf_flags {
 	IDPF_HR_RESET_IN_PROG,
 	IDPF_REMOVE_IN_PROG,
 	IDPF_MB_INTR_MODE,
+	IDPF_VC_CORE_INIT,
 	IDPF_FLAGS_NBITS,
 };
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index e89e2bad460d..a602ff8d74e0 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -2990,7 +2990,9 @@ int idpf_vc_core_init(struct idpf_adapter *adapter)
 	queue_delayed_work(adapter->init_wq, &adapter->init_task,
 			   msecs_to_jiffies(5 * (adapter->pdev->devfn & 0x07)));
 
-	goto no_err;
+	set_bit(IDPF_VC_CORE_INIT, adapter->flags);
+
+	return 0;
 
 err_intr_req:
 	cancel_delayed_work_sync(&adapter->serv_task);
@@ -2999,7 +3001,6 @@ int idpf_vc_core_init(struct idpf_adapter *adapter)
 err_netdev_alloc:
 	kfree(adapter->vports);
 	adapter->vports = NULL;
-no_err:
 	return err;
 
 init_failed:
@@ -3034,6 +3035,9 @@ int idpf_vc_core_init(struct idpf_adapter *adapter)
  */
 void idpf_vc_core_deinit(struct idpf_adapter *adapter)
 {
+	if (!test_bit(IDPF_VC_CORE_INIT, adapter->flags))
+		return;
+
 	idpf_vc_xn_shutdown(adapter->vcxn_mngr);
 	idpf_deinit_task(adapter);
 	idpf_intr_rel(adapter);
@@ -3045,6 +3049,8 @@ void idpf_vc_core_deinit(struct idpf_adapter *adapter)
 
 	kfree(adapter->vports);
 	adapter->vports = NULL;
+
+	clear_bit(IDPF_VC_CORE_INIT, adapter->flags);
 }
 
 /**
-- 
2.43.0


