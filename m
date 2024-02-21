Return-Path: <netdev+bounces-73499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDCF85CD12
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 01:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBF1F28694D
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 00:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A184428;
	Wed, 21 Feb 2024 00:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NQ8y2mSE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273823C0B
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 00:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708476658; cv=none; b=oxvK6PrQXf6Rb+ZkzwyNV7rphxyhuOhrpFaW8K4Dn6QTOU5+bkN6ISxsOqqr23fAHFX/OV+TRAQ93tTgYP9IVe4E5Uh8MMeBaJ5s0QlBtQEtoc0MZYzWKbZiy8hebnfntmUQbiyreNzlBaQsFVKUV/5uM/EWqk7CyN9UC+L+5/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708476658; c=relaxed/simple;
	bh=hBpUOSh4+s0kOReiJq6Xs52C1TE4iVUGScm186yeSps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qLEzHhM1r+sYAvEPhdDBvreg3IQ21OYhz7V6guxi9CKc+tyXPpmhiO5PhM5we/K1uOIlFGt7cjZt5E/0Ot94IFNiqmsqAkzTAYpuUnXlZllfPkhhPyrnKB0Q/kLs4SxCdpGmQoRFVx27HYb4foZ4q3IbJL/gtAYdyZrKYcK0Zh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NQ8y2mSE; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708476657; x=1740012657;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hBpUOSh4+s0kOReiJq6Xs52C1TE4iVUGScm186yeSps=;
  b=NQ8y2mSEAFSZfoTZr979y5kVjKmWL8Sqn6FJZkpQF/2aL4H96TgAcmYo
   iQ/lST8Zd48RsAbcyoauTRMyexpd5gelAzDk4gvvRBVVRdZgNPLo1XMsf
   tbR9N9vcghKXvq1xjSS52ZQEqWxByY1O9XJ+itaSsIAs3SPntwFbUsr7w
   rZVjsEA33QV/vd1ypFoCUCGYmlr/lODB9ejQgI2Rr8aDWxo0eep6U3cps
   xfBq4ht0AVT4zLFO5M+F3LWyei9biaAKRz1kJd/xKY9OuM6MiMFW5/x0k
   wD/sIVvckuP3HHmiavD71UIqVHTzVGikiz1zrdSNb0F9rJlNvyk0qgjSH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2500801"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="2500801"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 16:50:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="9550996"
Received: from dev1-atbrady.jf.intel.com ([10.166.241.35])
  by fmviesa004.fm.intel.com with ESMTP; 20 Feb 2024 16:50:56 -0800
From: Alan Brady <alan.brady@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Alan Brady <alan.brady@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: [PATCH v5 08/10 iwl-next] idpf: prevent deinit uninitialized virtchnl core
Date: Tue, 20 Feb 2024 16:49:47 -0800
Message-ID: <20240221004949.2561972-9-alan.brady@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240221004949.2561972-1-alan.brady@intel.com>
References: <20240221004949.2561972-1-alan.brady@intel.com>
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
index 0793173bb36d..e7a2fbf9e6cd 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -88,6 +88,7 @@ enum idpf_state {
  * @IDPF_HR_RESET_IN_PROG: Reset in progress
  * @IDPF_REMOVE_IN_PROG: Driver remove in progress
  * @IDPF_MB_INTR_MODE: Mailbox in interrupt mode
+ * @IDPF_VC_CORE_INIT: virtchnl core has been init
  * @IDPF_FLAGS_NBITS: Must be last
  */
 enum idpf_flags {
@@ -96,6 +97,7 @@ enum idpf_flags {
 	IDPF_HR_RESET_IN_PROG,
 	IDPF_REMOVE_IN_PROG,
 	IDPF_MB_INTR_MODE,
+	IDPF_VC_CORE_INIT,
 	IDPF_FLAGS_NBITS,
 };
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index f74f074ee359..dade4dd84952 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -2886,7 +2886,9 @@ int idpf_vc_core_init(struct idpf_adapter *adapter)
 	queue_delayed_work(adapter->init_wq, &adapter->init_task,
 			   msecs_to_jiffies(5 * (adapter->pdev->devfn & 0x07)));
 
-	goto no_err;
+	set_bit(IDPF_VC_CORE_INIT, adapter->flags);
+
+	return 0;
 
 err_intr_req:
 	cancel_delayed_work_sync(&adapter->serv_task);
@@ -2895,7 +2897,6 @@ int idpf_vc_core_init(struct idpf_adapter *adapter)
 err_netdev_alloc:
 	kfree(adapter->vports);
 	adapter->vports = NULL;
-no_err:
 	return err;
 
 init_failed:
@@ -2929,6 +2930,9 @@ int idpf_vc_core_init(struct idpf_adapter *adapter)
  */
 void idpf_vc_core_deinit(struct idpf_adapter *adapter)
 {
+	if (!test_bit(IDPF_VC_CORE_INIT, adapter->flags))
+		return;
+
 	idpf_vc_xn_shutdown(&adapter->vcxn_mngr);
 	idpf_deinit_task(adapter);
 	idpf_intr_rel(adapter);
@@ -2940,6 +2944,8 @@ void idpf_vc_core_deinit(struct idpf_adapter *adapter)
 
 	kfree(adapter->vports);
 	adapter->vports = NULL;
+
+	clear_bit(IDPF_VC_CORE_INIT, adapter->flags);
 }
 
 /**
-- 
2.43.0


