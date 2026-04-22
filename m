Return-Path: <netdev+bounces-280486-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uE5yO6z16Gl3SAIAu9opvQ
	(envelope-from <netdev+bounces-280486-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:22:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFD9448855
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4472B300680B
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 16:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5602737CD3C;
	Wed, 22 Apr 2026 16:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B7V3RDjR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66D8273D8D;
	Wed, 22 Apr 2026 16:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776874816; cv=none; b=aw4arng/a5ZjekTpq7e5UAe5jvz3g1qaelAYdzGaCCMDFA+wZ2ZryuVRUVlbyOImxYvC5jdjQ5vK3Jfhs3isKHze0oLZHNEOu0UZVXUASrvCLmczkVRtQXIhCNRU+oWfoZ9f/2MsQvgzSxT4l+GzxmffIbhNisoJ0SIrS4yHGg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776874816; c=relaxed/simple;
	bh=EfOOrxhNAc002gBQ2b94VR1M0iDD4MM8+CD2KGS9Miw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qtccRz4NPfEwnvFlw9rqFlOvjskhfeINVaG065FMQ0OQYewGBl15ix5TY97XgfewMxKDECfBLAn4UKZTMBH9ZsE/Aw4e2FtnutRTJp7tTs2M5qzCRGMlocpwe6ne1JIIub1AFTI5qcak6JUbRjDc2Id2Ow5PIk5xkXhPx2YTnoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B7V3RDjR; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776874815; x=1808410815;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EfOOrxhNAc002gBQ2b94VR1M0iDD4MM8+CD2KGS9Miw=;
  b=B7V3RDjRKV2edYDTsf6XW0f0Sptd7jKvr3xzcEsCFFZ1PWT6/1OnJdL6
   T+P4uh0QfsVFLL07CTCUvkRlujAGsD/1SNpvC3Y9JJI+X6oMtj0tX+C8v
   lqrQShjUD01Ub/WEmS9tCfLJyrq0f6p5TZ1Ex0f3hi/58AcmqDdXNJk7Q
   wj3N5iXiLKDpIyGMCdZgmIabh+Hi0Lvi5KjlW4FqhKCiPRCYUIv1XQID2
   W24425Qm2g+R3tELV6W+C4rI59yraN9enLu6RJF1LJCV44uz8W1ZJyzws
   PJ/uwoeiexul+qq5WqdBFZDAbPBZQYDH4cH0lJRrlBbvaAZVueADotXh+
   g==;
X-CSE-ConnectionGUID: WKyHHdlASkWOmwsR45asSw==
X-CSE-MsgGUID: YlsNx0uyRZiYKJY17C2LBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="88134471"
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="88134471"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 09:20:14 -0700
X-CSE-ConnectionGUID: IDh7d9TfQ/O9w1f1XGKR/Q==
X-CSE-MsgGUID: Xg1hl9e7TBusYlz7eQlmxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="228052438"
Received: from unknown (HELO localhost.png.intel.com) ([10.107.255.61])
  by fmviesa010.fm.intel.com with ESMTP; 22 Apr 2026 09:20:10 -0700
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
	Looi@web.codeaurora.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	KhaiWenTan <khai.wen.tan@linux.intel.com>
Subject: [PATCH iwl-next v3 1/3] igc: remove unused autoneg_failed field
Date: Wed, 22 Apr 2026 23:56:59 +0800
Message-ID: <20260422155701.7420-2-khai.wen.tan@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260422155701.7420-1-khai.wen.tan@linux.intel.com>
References: <20260422155701.7420-1-khai.wen.tan@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [4.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	R_DKIM_REJECT(1.00)[intel.com:s=Intel];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[intel.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-280486-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	GREYLIST(0.00)[pass,meta];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:-];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[khai.wen.tan@linux.intel.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.224];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ACFD9448855
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>

autoneg_failed in struct igc_mac_info is never set in the igc driver.
Remove the field and the dead code checking it in
igc_config_fc_after_link_up().

Reviewed-by: Looi, Hong Aun <hong.aun.looi@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
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


