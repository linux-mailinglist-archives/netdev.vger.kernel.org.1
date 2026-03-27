Return-Path: <netdev+bounces-272397-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOrsLFIwxmnzHQUAu9opvQ
	(envelope-from <netdev+bounces-272397-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 08:22:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 48046340517
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 08:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAB3A30107FF
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 07:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BA43C73E5;
	Fri, 27 Mar 2026 07:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A2WsBk6g"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D0214D29B
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 07:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774596167; cv=none; b=Tr7wpBLOK8J6UufG32SplC0ibuh+yaA6YAq6PXrJ8fXTKA4lcipqFsP1GVV/mkMAJuDjlKobItrI+CDB9apbkAz5BHApSCb7r/RmDRCBUFF2AATSLfaRoixDt5bf38Kjo/ZLbCtSur+/BFckTAg6uSUl3lqV49RHXJFUxbSH6hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774596167; c=relaxed/simple;
	bh=UG0TXdzOm7/f9TplyZuK66CItEUmN3gfFSEbWaZGIk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mk63XiMv38OWPmPgmhL7IEEB1ihmZqAyY/IH3QIFuVXcG/x6eM2qIp6Tc5RvX1dJgBnT3frjwZw1y8fH0SdGbUCU1Dj5PQSEW+iaFZr+z2jiTSlbWdQdLkZg7JsN4VSveKa1h5YaMEpzZkYSi+KD0hfwXjKd4KH0R5nH5BEjvrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A2WsBk6g; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774596162; x=1806132162;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UG0TXdzOm7/f9TplyZuK66CItEUmN3gfFSEbWaZGIk4=;
  b=A2WsBk6gNcrhGl1rhNhIM/kFAUdUXU6Wsmxz2L8dPtOAlfQZDatAxvdK
   HF2VgtURj4RFR8tQWqqzW/Tt2K3wIU3VfUzulShD/OAuB3mgAFOQkwooe
   +I44Vgjq447ag4n+WBtYRuYqAVrfm2pQrq68gsdDldqzVbBuuR9kNEmiI
   cVkCVx8aU8si9C4Y6nsR7SiUszZjQpa7z+bhW6ybj79vs0bgt/Y69ojRS
   DUvMGlMbBsolyAJ+ZiifTQTWk2uGFyqabp3jznS8ghDDlrNAorCZsvkOC
   68XfR+MFsWOFfuQC6//rF+70cO/ezEkUDhaCATt0wulLzZiPDcuaHxEYF
   g==;
X-CSE-ConnectionGUID: aZfFMrYiQfiSPpkApLlvwA==
X-CSE-MsgGUID: 7jJ/uLhhSnG45Fe/W889dA==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="74848617"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="74848617"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 00:22:41 -0700
X-CSE-ConnectionGUID: 53a4fqgwSO+6KlqFPtqoqQ==
X-CSE-MsgGUID: pm6Mj2bZQZ+vkoomyH63yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="222359496"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa008.fm.intel.com with ESMTP; 27 Mar 2026 00:22:40 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next] ice: check cross-timestamp timeout bits
Date: Fri, 27 Mar 2026 08:22:34 +0100
Message-ID: <20260327072236.129802-3-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260327072236.129802-1-aleksandr.loktionov@intel.com>
References: <20260327072236.129802-1-aleksandr.loktionov@intel.com>
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
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272397-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 48046340517
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Karol Kolacinski <karol.kolacinski@intel.com>

Polling for cross-timestamp active bit depends on HW scheduling and
actual timeout may happen before the driver finishes polling.

Check cross-timestamp timeout bits to ensure that the driver finishes
the operation earlier when HW indicates timeout.

Fixes: 92456e795ac6 ("ice: Add unified ice_capture_crosststamp")
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---

 drivers/net/ethernet/intel/ice/ice_hw_autogen.h |  3 +++
 drivers/net/ethernet/intel/ice/ice_ptp.c        | 12 ++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_hw_autogen.h b/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
index 082ad33..8b4884e 100644
--- a/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
+++ b/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
@@ -499,6 +499,8 @@
 #define PRTRPB_RDPC				0x000AC260
 #define GLHH_ART_CTL				0x000A41D4
 #define GLHH_ART_CTL_ACTIVE_M			BIT(0)
+#define GLHH_ART_CTL_TIME_OUT1_M		BIT(1)
+#define GLHH_ART_CTL_TIME_OUT2_M		BIT(2)
 #define GLHH_ART_TIME_H				0x000A41D8
 #define GLHH_ART_TIME_L				0x000A41DC
 #define GLTSYN_AUX_IN_0(_i)			(0x000889D8 + ((_i) * 4))
@@ -564,6 +566,7 @@
 #define E830_PRTTSYN_TXTIME_L(_i)		(0x001E5000 + ((_i) * 32))
 #define E830_GLPTM_ART_CTL			0x00088B50
 #define E830_GLPTM_ART_CTL_ACTIVE_M		BIT(0)
+#define E830_GLPTM_ART_CTL_TIME_OUT_M		BIT(1)
 #define E830_GLPTM_ART_TIME_H			0x00088B54
 #define E830_GLPTM_ART_TIME_L			0x00088B58
 #define E830_GLTSYN_PTMTIME_H(_i)		(0x00088B48 + ((_i) * 4))
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 6848b1c..8b0530b 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2011,6 +2011,7 @@ static int ice_ptp_adjtime(struct ptp_clock_info *info, s64 delta)
  * @lock_busy: Bit in the semaphore lock indicating the lock is busy
  * @ctl_reg: The hardware register to request cross timestamp
  * @ctl_active: Bit in the control register to request cross timestamp
+ * @ctl_timeout: Bits in the control register to indicate HW timeout
  * @art_time_l: Lower 32-bits of ART system time
  * @art_time_h: Upper 32-bits of ART system time
  * @dev_time_l: Lower 32-bits of device time (per timer index)
@@ -2024,6 +2025,7 @@ struct ice_crosststamp_cfg {
 	/* Capture control register */
 	u32 ctl_reg;
 	u32 ctl_active;
+	u32 ctl_timeout;
 
 	/* Time storage */
 	u32 art_time_l;
@@ -2037,6 +2039,7 @@ static const struct ice_crosststamp_cfg ice_crosststamp_cfg_e82x = {
 	.lock_busy = PFHH_SEM_BUSY_M,
 	.ctl_reg = GLHH_ART_CTL,
 	.ctl_active = GLHH_ART_CTL_ACTIVE_M,
+	.ctl_timeout = GLHH_ART_CTL_TIME_OUT1_M | GLHH_ART_CTL_TIME_OUT2_M,
 	.art_time_l = GLHH_ART_TIME_L,
 	.art_time_h = GLHH_ART_TIME_H,
 	.dev_time_l[0] = GLTSYN_HHTIME_L(0),
@@ -2051,6 +2054,7 @@ static const struct ice_crosststamp_cfg ice_crosststamp_cfg_e830 = {
 	.lock_busy = E830_PFPTM_SEM_BUSY_M,
 	.ctl_reg = E830_GLPTM_ART_CTL,
 	.ctl_active = E830_GLPTM_ART_CTL_ACTIVE_M,
+	.ctl_timeout = E830_GLPTM_ART_CTL_TIME_OUT_M,
 	.art_time_l = E830_GLPTM_ART_TIME_L,
 	.art_time_h = E830_GLPTM_ART_TIME_H,
 	.dev_time_l[0] = E830_GLTSYN_PTMTIME_L(0),
@@ -2123,9 +2127,13 @@ static int ice_capture_crosststamp(ktime_t *device,
 	ctl |= cfg->ctl_active;
 	wr32(hw, cfg->ctl_reg, ctl);
 
-	/* Poll until hardware completes the capture */
-	err = rd32_poll_timeout(hw, cfg->ctl_reg, ctl, !(ctl & cfg->ctl_active),
+	/* Poll until hardware completes the capture or timeout occurs */
+	err = rd32_poll_timeout(hw, cfg->ctl_reg, ctl,
+				!(ctl & cfg->ctl_active) ||
+				(ctl & cfg->ctl_timeout),
 				5, 20 * USEC_PER_MSEC);
+	if (ctl & cfg->ctl_timeout)
+		err = -ETIMEDOUT;
 	if (err)
 		goto err_timeout;
 
-- 
2.52.0


