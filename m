Return-Path: <netdev+bounces-272401-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEAqF3YyxmlbHgUAu9opvQ
	(envelope-from <netdev+bounces-272401-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 08:32:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC843340741
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 08:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA2D630D5715
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 07:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078703C9437;
	Fri, 27 Mar 2026 07:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cxg4lLGQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BD82DB79E
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 07:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774596224; cv=none; b=u8A042auJUFSYiibrZqiOFW5Iaxl42h4M03UD6dnYvusa02g+TOLdQ3/r+aRIGZGw41CSrna5whK030iBUH/yXvBRaMO4yF0oMKI4R9jl+R1iQkG/DZVlTdt90iBe3FtDoFY4ctqSyS0o2Oize65Lco26zcJ54YzEkKUooZe8iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774596224; c=relaxed/simple;
	bh=+FmYWfOtYLDqvPwMlsKA5+9rkYFC7p/MdLIOyUR/QUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RoEqRU5gjqyDYsr3vP1Sdv9e1Z7OfgqWpnOUuDDD5lLC5geU9MORY6qrptv1mbYD6pPsthwySn0EhGa9dwM/MrzQYFlJjazw4qYKOTx3JZmbBGQaAgP/jGwcTAnzW742qsPOO/ZgbHJG0p6IRVUog8cb7yatmlwazNxjcLxfbsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cxg4lLGQ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774596218; x=1806132218;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+FmYWfOtYLDqvPwMlsKA5+9rkYFC7p/MdLIOyUR/QUs=;
  b=cxg4lLGQkzn2YM+XX4Xzd08hYxBuJpK5xoRTMONTGEtrB4HOAjkfKntn
   wmdtpSnkBRr+uvQbBk1DmRmfOssX6il2pDSOzzQgG1tZ9s0Ex+qhpCgxi
   DkjAEFkNueTiSU/OaPiPt5ftL8jDYdM0VBvWDOvq9hwe3B2EutAN15CAO
   MgMw3mZplISLwjX+pjC59N4qHKRlfnry2A7ShkN16T8/4+8UBds5iugd0
   LSX+LvS5Zqofhc/HaKF/wMQL6+AlaqfmXcQK365/CCX2V4JXo+2Z3rvs0
   sdzDsUFHkGBHG89XiYiq/9u3y4+PSizWl1XEZkisafj1d4IhWYg6zhTpc
   g==;
X-CSE-ConnectionGUID: 0Px8xGByT6OGkgNcnMFehw==
X-CSE-MsgGUID: 8fQvRmaYTnOYO557H6n7TQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75733964"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="75733964"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 00:23:37 -0700
X-CSE-ConnectionGUID: cjU8uxqrTNeqQpG2ePj2qw==
X-CSE-MsgGUID: GGk17MhwRLCO9K21fSn5aA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="255739086"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa002.jf.intel.com with ESMTP; 27 Mar 2026 00:23:35 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net] ice: fix locking around wait_event_interruptible_locked_irq
Date: Fri, 27 Mar 2026 08:23:25 +0100
Message-ID: <20260327072332.130320-2-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260327072332.130320-1-aleksandr.loktionov@intel.com>
References: <20260327072332.130320-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272401-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: CC843340741
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jacob Keller <jacob.e.keller@intel.com>

Commit 50327223a8bb ("ice: add lock to protect low latency interface")
introduced a wait queue used to protect the low latency timer interface.
The queue is used with the wait_event_interruptible_locked_irq macro, which
unlocks the wait queue lock while sleeping. The irq variant uses
spin_lock_irq and spin_unlock_irq to manage this. The wait queue lock was
previously locked using spin_lock_irqsave. This difference in lock variants
could lead to issues, since wait_event would unlock the wait queue and
restore interrupts while sleeping.

The ice_read_phy_tstamp_ll_e810() function is ultimately called through
ice_read_phy_tstamp, which is called from ice_ptp_process_tx_tstamp or
ice_ptp_clear_unexpected_tx_ready. The former is called through the
miscellaneous IRQ thread function, while the latter is called from the
service task work queue thread. Neither of these functions has interrupts
disabled, so use spin_lock_irq instead of spin_lock_irqsave.

Fixes: 50327223a8bb ("ice: add lock to protect low latency interface")
Cc: stable@vger.kernel.org
Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://lore.kernel.org/netdev/20250109181823.77f44c69@kernel.org/
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---

 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 61c0a0d..1f73d72 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -4323,18 +4323,17 @@ static int
 ice_read_phy_tstamp_ll_e810(struct ice_hw *hw, u8 idx, u8 *hi, u32 *lo)
 {
 	struct ice_e810_params *params = &hw->ptp.phy.e810;
-	unsigned long flags;
 	u32 val;
 	int err;
 
-	spin_lock_irqsave(&params->atqbal_wq.lock, flags);
+	spin_lock_irq(&params->atqbal_wq.lock);
 
 	/* Wait for any pending in-progress low latency interrupt */
 	err = wait_event_interruptible_locked_irq(params->atqbal_wq,
 						  !(params->atqbal_flags &
 						    ATQBAL_FLAGS_INTR_IN_PROGRESS));
 	if (err) {
-		spin_unlock_irqrestore(&params->atqbal_wq.lock, flags);
+		spin_unlock_irq(&params->atqbal_wq.lock);
 		return err;
 	}
 
@@ -4349,7 +4348,7 @@ ice_read_phy_tstamp_ll_e810(struct ice_hw *hw, u8 idx, u8 *hi, u32 *lo)
 				       REG_LL_PROXY_H);
 	if (err) {
 		ice_debug(hw, ICE_DBG_PTP, "Failed to read PTP timestamp using low latency read\n");
-		spin_unlock_irqrestore(&params->atqbal_wq.lock, flags);
+		spin_unlock_irq(&params->atqbal_wq.lock);
 		return err;
 	}
 
@@ -4359,7 +4358,7 @@ ice_read_phy_tstamp_ll_e810(struct ice_hw *hw, u8 idx, u8 *hi, u32 *lo)
 	/* Read the low 32 bit value and set the TS valid bit */
 	*lo = rd32(hw, REG_LL_PROXY_L) | TS_VALID;
 
-	spin_unlock_irqrestore(&params->atqbal_wq.lock, flags);
+	spin_unlock_irq(&params->atqbal_wq.lock);
 
 	return 0;
 }
-- 
2.52.0


