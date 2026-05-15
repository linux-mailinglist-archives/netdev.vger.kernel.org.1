Return-Path: <netdev+bounces-288195-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iC9rHn2/BmqMnQIAu9opvQ
	(envelope-from <netdev+bounces-288195-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 08:38:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1C554A0EA
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 08:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC6843013703
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 06:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFD0377EAB;
	Fri, 15 May 2026 06:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V8HxCxcC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982163803E0
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 06:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778827120; cv=none; b=OuZ2hTg4d+HbJjcipm7eKzGxJtUSwUIk+jPzPlUQoE4o7UZhGfTnMxO2HOblQiWirswbS57Y7gnaIqjVmb/v7nBFM+X3K6oya1iJa6eHA813z/T3jakY0nKZ5NHV7La1TDcitP+KIrTRNrEvPMLaTMdk6WD4mcxQy8LT9CBlpKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778827120; c=relaxed/simple;
	bh=JKYVh2slMKWfZx1z40HWA1wTlerYTQUEo0TT717YH0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uwIZkpCI2WHe9Np34dL/nBNoGHwDSeUwD6uWKRHWz7escwJWYZBEtGkq2l/BYHDu2S7xj2w3mmZmlboUBXPKc7AVcUjm1qqg6uMXwErwRFuIfCPt1t3zalcPFbT49kL8Rf6p4RxGcFJYFwk1bzdAhaxRr9S6OFNshDGaDEd0z3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V8HxCxcC; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778827120; x=1810363120;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JKYVh2slMKWfZx1z40HWA1wTlerYTQUEo0TT717YH0k=;
  b=V8HxCxcCxY1Uq69N/UeIXKlA4BSzIRLWJjB0mLL2GotKBniCIeTR3usa
   f24HLnW0cciNCf4Z9ABau3LFJb1nApz0pHSjCIcFgLHvs43OMkdW7Ya+V
   dTL3UKLsZB4srFd7Z0+QZSZB/ew0RN7M3LIaaqAiinHmYxena+ITyQRwH
   mfvRB97c/0VBn9FnUX6TsOg9gJJK+DCyLSrf7gabSTxpCYDI9BuU298oZ
   9qUAjxY+EBUHXTJOfjlOcxPfttDHGAc8tCWEP6kSedh8K2XHrQ9gNWA0+
   NgRYsRcm/n+rPVeeYFODBJkvqiKve99LTl41Oz7UDfJ0odANZwgWmWFEt
   A==;
X-CSE-ConnectionGUID: vqH/dG4rRQmoxiLlO/qeEA==
X-CSE-MsgGUID: ZNM9WUqCSDyBJ0GBYxowvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="79739208"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="79739208"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 23:38:40 -0700
X-CSE-ConnectionGUID: BCaaXBjpSv+vlqQA5jAoqw==
X-CSE-MsgGUID: InN7nmB0TDmXGB2PF3FIuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="237622616"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa006.jf.intel.com with ESMTP; 14 May 2026 23:38:38 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH iwl-next] iavf: convert crit_section to DECLARE_BITMAP
Date: Fri, 15 May 2026 08:38:36 +0200
Message-ID: <20260515063836.3300442-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EB1C554A0EA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288195-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Action: no action

struct iavf_adapter::crit_section is a bit-lock container indexed
by values from enum iavf_critical_section_t (__IAVF_IN_REMOVE_TASK).
It is manipulated exclusively through the kernel atomic bitops API:
set_bit(), clear_bit(), test_bit(), test_and_set_bit().

It is declared as a bare 'unsigned long' and every call site passes
'&adapter->crit_section'. That is functionally correct -- the bit
index is a compile-time enum value well below BITS_PER_LONG so
BIT_WORD(nr) is always 0 and only the singleton word is ever
touched -- but it relies on layout coincidence rather than on the
documented contract of the bitops API, which is defined in terms of
'unsigned long *' arrays.

Static analyzers that model the same contract flag every such call
site with ARRAY_VS_SINGLETON because the address of a scalar is
passed where an array pointer is expected.

Convert the field to a proper bitmap using DECLARE_BITMAP() sized by
a new sentinel __IAVF_CRIT_SECTION_NBITS at the end of the enum. The
underlying storage is unchanged (a single unsigned long word on every
architecture Linux supports), so there is no functional or ABI change;
the type simply becomes 'unsigned long[1]' which matches what the
bitops API expects and silences the analyzer warnings permanently.

Drop the leading '&' at every call site, since arrays decay to
pointers.

No functional change intended.

Suggested-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf.h      |  3 ++-
 drivers/net/ethernet/intel/iavf/iavf_main.c | 16 ++++++++--------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index 050f824..ba9ad63 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -213,6 +213,7 @@ enum iavf_state_t {
 
 enum iavf_critical_section_t {
 	__IAVF_IN_REMOVE_TASK,	/* device being removed */
+	__IAVF_CRIT_SECTION_NBITS	/* must be last */
 };
 
 #define IAVF_CLOUD_FIELD_OMAC		0x01
@@ -389,7 +390,7 @@ struct iavf_adapter {
 
 	enum iavf_state_t state;
 	enum iavf_state_t last_state;
-	unsigned long crit_section;
+	DECLARE_BITMAP(crit_section, __IAVF_CRIT_SECTION_NBITS);
 
 	struct delayed_work watchdog_task;
 	bool link_up;
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index d2914c5..b3332ca 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -264,7 +264,7 @@ void iavf_free_virt_mem(struct iavf_hw *hw, struct iavf_virt_mem *mem)
  **/
 void iavf_schedule_reset(struct iavf_adapter *adapter, u64 flags)
 {
-	if (!test_bit(__IAVF_IN_REMOVE_TASK, &adapter->crit_section) &&
+	if (!test_bit(__IAVF_IN_REMOVE_TASK, adapter->crit_section) &&
 	    !(adapter->flags &
 	    (IAVF_FLAG_RESET_PENDING | IAVF_FLAG_RESET_NEEDED))) {
 		adapter->flags |= flags;
@@ -1355,7 +1355,7 @@ void iavf_down(struct iavf_adapter *adapter)
 	if (adapter->flags & IAVF_FLAG_PF_COMMS_FAILED)
 		return;
 
-	if (!test_bit(__IAVF_IN_REMOVE_TASK, &adapter->crit_section)) {
+	if (!test_bit(__IAVF_IN_REMOVE_TASK, adapter->crit_section)) {
 		/* cancel any current operation */
 		adapter->current_op = VIRTCHNL_OP_UNKNOWN;
 		/* Schedule operations to close down the HW. Don't wait
@@ -1960,7 +1960,7 @@ static void iavf_finish_config(struct work_struct *work)
 
 	if ((adapter->flags & IAVF_FLAG_SETUP_NETDEV_FEATURES) &&
 	    adapter->netdev->reg_state == NETREG_REGISTERED &&
-	    !test_bit(__IAVF_IN_REMOVE_TASK, &adapter->crit_section)) {
+	    !test_bit(__IAVF_IN_REMOVE_TASK, adapter->crit_section)) {
 		netdev_update_features(adapter->netdev);
 		adapter->flags &= ~IAVF_FLAG_SETUP_NETDEV_FEATURES;
 	}
@@ -2016,7 +2016,7 @@ static void iavf_finish_config(struct work_struct *work)
  **/
 void iavf_schedule_finish_config(struct iavf_adapter *adapter)
 {
-	if (!test_bit(__IAVF_IN_REMOVE_TASK, &adapter->crit_section))
+	if (!test_bit(__IAVF_IN_REMOVE_TASK, adapter->crit_section))
 		queue_work(adapter->wq, &adapter->finish_config);
 }
 
@@ -2870,7 +2870,7 @@ static int iavf_watchdog_step(struct iavf_adapter *adapter)
 		return 1;
 	case __IAVF_INIT_FAILED:
 		if (test_bit(__IAVF_IN_REMOVE_TASK,
-			     &adapter->crit_section)) {
+			     adapter->crit_section)) {
 			/* Do not update the state and do not reschedule
 			 * watchdog task, iavf_remove should handle this state
 			 * as it can loop forever
@@ -2889,7 +2889,7 @@ static int iavf_watchdog_step(struct iavf_adapter *adapter)
 		return 1000;
 	case __IAVF_COMM_FAILED:
 		if (test_bit(__IAVF_IN_REMOVE_TASK,
-			     &adapter->crit_section)) {
+			     adapter->crit_section)) {
 			/* Set state to __IAVF_INIT_FAILED and perform remove
 			 * steps. Remove IAVF_FLAG_PF_COMMS_FAILED so the task
 			 * doesn't bring the state back to __IAVF_COMM_FAILED.
@@ -3771,7 +3771,7 @@ static int __iavf_setup_tc(struct net_device *netdev, void *type_data)
 		}
 	}
 exit:
-	if (test_bit(__IAVF_IN_REMOVE_TASK, &adapter->crit_section))
+	if (test_bit(__IAVF_IN_REMOVE_TASK, adapter->crit_section))
 		return 0;
 
 	netif_set_real_num_rx_queues(netdev, total_qps);
@@ -5513,7 +5513,7 @@ static void iavf_remove(struct pci_dev *pdev)
 	adapter = iavf_pdev_to_adapter(pdev);
 	hw = &adapter->hw;
 
-	if (test_and_set_bit(__IAVF_IN_REMOVE_TASK, &adapter->crit_section))
+	if (test_and_set_bit(__IAVF_IN_REMOVE_TASK, adapter->crit_section))
 		return;
 
 	/* Wait until port initialization is complete.
-- 
2.52.0


