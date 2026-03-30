Return-Path: <netdev+bounces-273373-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6C1vFqgBy2k2CgYAu9opvQ
	(envelope-from <netdev+bounces-273373-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 01:05:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C25F63623D2
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 01:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E40B63031F38
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 23:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A687D3E5573;
	Mon, 30 Mar 2026 23:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e6UYyvHg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314633D6493
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 23:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774911781; cv=none; b=Yfq3us6+rtqWtAR6+nffkqiZ6rvNwqDgP4Z9WxtnKBXtc0MQ0/HNM5wIgrIGkF4ifUHYNkZvJGtudMbRFzUI5ELiXlKXg8QYKBcT7FixKS9RN0qn2dC5IZ0LmBti1r9pZjwjpZvVYy0Kp/VbhwUrr3wEhsXmZvz/73GQnLQ6Rko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774911781; c=relaxed/simple;
	bh=CIAK89/RtZi1scyuSXxY1ewLcU63mb44L7YBQrzmwFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XkE7A6ROT0Z32ENzaDVwPSmQVltZE5bigfknslV6VzAyjaa1/qHdGB0t8hOtQM0UsQOqzlSgnK0tgedW9y1A85bjCrVkkkS5hVlHG4G1hY7JpY+D5tXcs8MlA/nO4Qx+eaTVhIZ81DF1k0mkzD5yKV7CtOC8TmncnE7BbTCzlBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e6UYyvHg; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774911780; x=1806447780;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CIAK89/RtZi1scyuSXxY1ewLcU63mb44L7YBQrzmwFY=;
  b=e6UYyvHgfEforJD1jsZbLWbYtL1qVbcIU72Ot75FIMt0HKOmjwSIpQZH
   /zSfbXqRV0V6Us/mZbdo1N3mveJgSWcF945GrCaVk4Dlzf0MMvl6cYnoS
   XdVXgcdtdVKFfXX+quUSWFALW4oQ8U5eh6Nw2tVqSBOgxLpN6fthF6nGL
   0dqUliEDZw22dAFzcDpZ1gdfOr+kb2OaNMFZxXaYmfBSAwV1VFanzz5Dx
   6P1R0VcLbRQFl6su3Uuo9Fy1qT5qMaMWBAVmFkxk/SWnNakOd+SL0Ezbh
   /MdW8N3j3nwHexLWXxOIsE5uEAZpyl61cBLLslK34FYddmcSE+cgoS4Te
   w==;
X-CSE-ConnectionGUID: cityTkX8QMeqffXXFN/yPA==
X-CSE-MsgGUID: kcidgOoHR/q/6S+ZQFqHPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="93297627"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="93297627"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 16:02:54 -0700
X-CSE-ConnectionGUID: rfnCGec2TN+2FsWu9KLUNg==
X-CSE-MsgGUID: rDRP620BRi25b6oBh7NwRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="256687736"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa002.jf.intel.com with ESMTP; 30 Mar 2026 16:02:54 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Maximilian Pezzullo <maximilianpezzullo@gmail.com>,
	anthony.l.nguyen@intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Joe Damato <joe@dama.to>
Subject: [PATCH net-next 11/15] igb: fix typos in comments
Date: Mon, 30 Mar 2026 16:02:40 -0700
Message-ID: <20260330230248.646900-12-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260330230248.646900-1-anthony.l.nguyen@intel.com>
References: <20260330230248.646900-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273373-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,intel.com,dama.to];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C25F63623D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Maximilian Pezzullo <maximilianpezzullo@gmail.com>

Fix spelling errors in code comments:
 - e1000_nvm.c: 'likley' -> 'likely'
 - e1000_mac.c: 'auto-negotitation' -> 'auto-negotiation'
 - e1000_mbx.h: 'exra' -> 'extra'
 - e1000_defines.h: 'Aserted' -> 'Asserted'

Signed-off-by: Maximilian Pezzullo <maximilianpezzullo@gmail.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Joe Damato <joe@dama.to>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igb/e1000_defines.h | 2 +-
 drivers/net/ethernet/intel/igb/e1000_mac.c     | 2 +-
 drivers/net/ethernet/intel/igb/e1000_mbx.h     | 2 +-
 drivers/net/ethernet/intel/igb/e1000_nvm.c     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/e1000_defines.h b/drivers/net/ethernet/intel/igb/e1000_defines.h
index fa028928482f..7e6f9aa2d57b 100644
--- a/drivers/net/ethernet/intel/igb/e1000_defines.h
+++ b/drivers/net/ethernet/intel/igb/e1000_defines.h
@@ -442,7 +442,7 @@
 /* Interrupt Cause Set */
 #define E1000_ICS_LSC       E1000_ICR_LSC       /* Link Status Change */
 #define E1000_ICS_RXDMT0    E1000_ICR_RXDMT0    /* rx desc min. threshold */
-#define E1000_ICS_DRSTA     E1000_ICR_DRSTA     /* Device Reset Aserted */
+#define E1000_ICS_DRSTA     E1000_ICR_DRSTA     /* Device Reset Asserted */
 
 /* Extended Interrupt Cause Set */
 /* E1000_EITR_CNT_IGNR is only for 82576 and newer */
diff --git a/drivers/net/ethernet/intel/igb/e1000_mac.c b/drivers/net/ethernet/intel/igb/e1000_mac.c
index fa3dfafd2bb1..2bcce6eef0c7 100644
--- a/drivers/net/ethernet/intel/igb/e1000_mac.c
+++ b/drivers/net/ethernet/intel/igb/e1000_mac.c
@@ -1581,7 +1581,7 @@ s32 igb_disable_pcie_master(struct e1000_hw *hw)
  *  igb_validate_mdi_setting - Verify MDI/MDIx settings
  *  @hw: pointer to the HW structure
  *
- *  Verify that when not using auto-negotitation that MDI/MDIx is correctly
+ *  Verify that when not using auto-negotiation that MDI/MDIx is correctly
  *  set, which is forced to MDI mode only.
  **/
 s32 igb_validate_mdi_setting(struct e1000_hw *hw)
diff --git a/drivers/net/ethernet/intel/igb/e1000_mbx.h b/drivers/net/ethernet/intel/igb/e1000_mbx.h
index 178e60ec71d4..9e44527f5eea 100644
--- a/drivers/net/ethernet/intel/igb/e1000_mbx.h
+++ b/drivers/net/ethernet/intel/igb/e1000_mbx.h
@@ -30,7 +30,7 @@
 /* Indicates that VF is still clear to send requests */
 #define E1000_VT_MSGTYPE_CTS	0x20000000
 #define E1000_VT_MSGINFO_SHIFT	16
-/* bits 23:16 are used for exra info for certain messages */
+/* bits 23:16 are used for extra info for certain messages */
 #define E1000_VT_MSGINFO_MASK	(0xFF << E1000_VT_MSGINFO_SHIFT)
 
 #define E1000_VF_RESET		0x01 /* VF requests reset */
diff --git a/drivers/net/ethernet/intel/igb/e1000_nvm.c b/drivers/net/ethernet/intel/igb/e1000_nvm.c
index c8638502c2be..cf4e5d0e9417 100644
--- a/drivers/net/ethernet/intel/igb/e1000_nvm.c
+++ b/drivers/net/ethernet/intel/igb/e1000_nvm.c
@@ -405,7 +405,7 @@ s32 igb_read_nvm_eerd(struct e1000_hw *hw, u16 offset, u16 words, u16 *data)
  *  Writes data to EEPROM at offset using SPI interface.
  *
  *  If e1000_update_nvm_checksum is not called after this function , the
- *  EEPROM will most likley contain an invalid checksum.
+ *  EEPROM will most likely contain an invalid checksum.
  **/
 s32 igb_write_nvm_spi(struct e1000_hw *hw, u16 offset, u16 words, u16 *data)
 {
-- 
2.47.1


