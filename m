Return-Path: <netdev+bounces-278907-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kECABGxI4GlpeQAAu9opvQ
	(envelope-from <netdev+bounces-278907-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 04:24:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0CE409B22
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 04:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8337C3032FC1
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 02:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443B325228D;
	Thu, 16 Apr 2026 02:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kK2WMhAR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD75723183F;
	Thu, 16 Apr 2026 02:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776305916; cv=none; b=QNi39XDCjugb5NB1LjM+7br/5bYMf0Bjv6Ieeg9p7k0RbX/Da7KaRg5GPm9v5zchoTY+NUMSDH/gs+dJ3CEKHzBSNFz1zwXWNPItkzLN18YYq9XF6qS/R/ITX5QwyCYPjtEkFWE4ldstff0bgCbk9E7141K22xJAgZbj0rDWnMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776305916; c=relaxed/simple;
	bh=c24xY4k2Ax9/vCwMkRqzVcK6y2+W/l1sJdoufcjIGA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EwRJ0a6yBHXUL69S5FiCr0ybtQW026EOb5sZPTId3WA1oOU0O2Aa5PpDUkFDuvRDqf022zR/y+7aKLVlKiQyLM4Gk28ILwNrcK7Z+hGy4HEjbyBqIrO/rvWF410+PVL9VA3tURwIz+bp+xPqDrWTndPletZ9kQc7t/5xlM0pAoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kK2WMhAR; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776305914; x=1807841914;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c24xY4k2Ax9/vCwMkRqzVcK6y2+W/l1sJdoufcjIGA0=;
  b=kK2WMhARRmYadQF0y2LNImc9g7Zy9W4l39d9Vy/OAD3dGKUsQS7s2Qjf
   0JLjf7JH6l3Ds4q2IDXyi9bKN8IeEb7dwSYPSf7W5VUXzWeq3Io6pAhsk
   LTrwyDfAmBtpDUekHB1kHPjhPu7bVeQubPBTxR5j36Wil2FjLVSUuATSw
   K6/Efoa3JIQphNL67zum+xlpQfor/u5xbGeaZ2M42Fg1tIJcW9XNWFwlK
   caakxdiSFRIpnZ2K7Irk13JDq0127qwWRpGMD1MHdgKZg/AFOVbsNCRQe
   u86mHHCUOw6nqdSrDXt5kAKNTG+eyjvZuUkqBpOZkx6tzckNfM9gwAOHf
   w==;
X-CSE-ConnectionGUID: N320CZomQ/GHYhfUEr5NsQ==
X-CSE-MsgGUID: V2dDqCfxRPGcdOIMAAMxxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="81168784"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="81168784"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 19:18:31 -0700
X-CSE-ConnectionGUID: ogkBqb77Tx6Yp4YuXiAr8g==
X-CSE-MsgGUID: I/l2S9ZVSOGuSTcdkfquig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="227442170"
Received: from unknown (HELO localhost.png.intel.com) ([10.107.255.61])
  by fmviesa007.fm.intel.com with ESMTP; 15 Apr 2026 19:18:27 -0700
From: KhaiWenTan <khai.wen.tan@linux.intel.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, faizal.abdul.rahim@intel.com,
	hong.aun.looi@intel.com, khai.wen.tan@intel.com,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	Looi@web.codeaurora.org, KhaiWenTan <khai.wen.tan@linux.intel.com>
Subject: [PATCH iwl-next v2 1/3] igc: remove unused autoneg_failed field
Date: Thu, 16 Apr 2026 09:55:18 +0800
Message-ID: <20260416015520.6090-2-khai.wen.tan@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260416015520.6090-1-khai.wen.tan@linux.intel.com>
References: <20260416015520.6090-1-khai.wen.tan@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [4.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	R_DKIM_REJECT(1.00)[intel.com:s=Intel];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[intel.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN_FAIL(0.00)[4.211.64.104.asn.rspamd.com:server fail];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-278907-lists,netdev=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_SPAM(0.00)[0.743];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:-];
	FROM_NEQ_ENVFROM(0.00)[khai.wen.tan@linux.intel.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.intel.com:mid,intel.com:email]
X-Rspamd-Queue-Id: 5A0CE409B22
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>

autoneg_failed in struct igc_mac_info is never set in the igc driver.
Remove the field and the dead code checking it in
igc_config_fc_after_link_up().

Reviewed-by: Looi, Hong Aun <hong.aun.looi@intel.com>
Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Signed-off-by: KhaiWenTan <khai.wen.tan@linux.intel.com>
---
 drivers/net/ethernet/intel/igc/igc_hw.h  |  1 -
 drivers/net/ethernet/intel/igc/igc_mac.c | 16 +---------------
 2 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_hw.h b/drivers/net/ethernet/intel/igc/igc_hw.h
index be8a49a86d09..86ab8f566f44 100644
--- a/drivers/net/ethernet/intel/igc/igc_hw.h
+++ b/drivers/net/ethernet/intel/igc/igc_hw.h
@@ -92,7 +92,6 @@ struct igc_mac_info {
 	bool asf_firmware_present;
 	bool arc_subsystem_valid;

-	bool autoneg_failed;
 	bool get_link_status;
 };

diff --git a/drivers/net/ethernet/intel/igc/igc_mac.c b/drivers/net/ethernet/intel/igc/igc_mac.c
index 7ac6637f8db7..142beb9ae557 100644
--- a/drivers/net/ethernet/intel/igc/igc_mac.c
+++ b/drivers/net/ethernet/intel/igc/igc_mac.c
@@ -438,28 +438,14 @@ void igc_config_collision_dist(struct igc_hw *hw)
  * Checks the status of auto-negotiation after link up to ensure that the
  * speed and duplex were not forced.  If the link needed to be forced, then
  * flow control needs to be forced also.  If auto-negotiation is enabled
- * and did not fail, then we configure flow control based on our link
- * partner.
+ * then we configure flow control based on our link partner.
  */
 s32 igc_config_fc_after_link_up(struct igc_hw *hw)
 {
 	u16 mii_status_reg, mii_nway_adv_reg, mii_nway_lp_ability_reg;
-	struct igc_mac_info *mac = &hw->mac;
 	u16 speed, duplex;
 	s32 ret_val = 0;

-	/* Check for the case where we have fiber media and auto-neg failed
-	 * so we had to force link.  In this case, we need to force the
-	 * configuration of the MAC to match the "fc" parameter.
-	 */
-	if (mac->autoneg_failed)
-		ret_val = igc_force_mac_fc(hw);
-
-	if (ret_val) {
-		hw_dbg("Error forcing flow control settings\n");
-		goto out;
-	}
-
 	/* In auto-neg, we need to check and see if Auto-Neg has completed,
 	 * and if so, how the PHY and link partner has flow control
 	 * configured.
--
2.43.0


