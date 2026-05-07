Return-Path: <netdev+bounces-285603-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDkyMTJd/WmLbgAAu9opvQ
	(envelope-from <netdev+bounces-285603-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 05:49:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E38F44F1434
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 05:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E480C3004DB8
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 03:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9342D738A;
	Fri,  8 May 2026 03:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y7TME5/o"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2EF256C6C;
	Fri,  8 May 2026 03:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778212141; cv=none; b=FV9oT51qNhxnkbeXt+OlKI5yP5JYaCnuqEGT6Wxc1HkMbuyBZIxyvWy1s5EcVRHswVkl11VExJoqeE389dZVGgUyRlV61VGqpmGmQJ7ZUBGtF3VdqBg5UU24lLLrXWZrSvOG43x/snvFN/h/+1RSLJQOYHEbEvRxq7wRJ+pnOyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778212141; c=relaxed/simple;
	bh=NEze/O911ldqimOh6WbrfXYQde70TWMivjIbXg4pGRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qyQCnvu4HUD5Qxnl7KD+3yejqo2ZAnX/rGKpUeCk52rlPWOtDo4Dtd5H1ExqHBIuqBkbrWU0i9jBiFLcsjrOhWNTbXbRS0DDQ2Vc4GxWIHrRI2p+Z9bb/rdsa7/BhMEJ4BpzxnATF8ci76tnKvlJkoJPgApE/Mo8XLQInvSHulI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y7TME5/o; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778212141; x=1809748141;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NEze/O911ldqimOh6WbrfXYQde70TWMivjIbXg4pGRg=;
  b=Y7TME5/oLV7E8prgRReK9D35coR8FT9pvy+n7RkCUho0Iep+LbsbOHtl
   +bLNt08bLIAz0YfmFTLP8r7oUA9GnhzQvEXMof5OyKupFRwGodA2GygaD
   UlfENghhIU+0emNpojA/p7ZHytsoXwEM2uEaQEzdzeefh/8uxtt3a3ZEK
   APpWU/crhs9sPFZo0oLPT7ZJVj4y0X13zr3+cZPO0b7l0d51ECvi12P+n
   8G1335B7naIsZRr8q9/3v48FEoK9lJzoin8UbmshL/9ateWbRr4TllL0w
   5lSLe21V7ACbU0dwYwgNTO8ot1kRn53Wlfok/a5KVytWITBiZWnZqE2FW
   g==;
X-CSE-ConnectionGUID: C7/OVAmHQImt5oZEeyzABQ==
X-CSE-MsgGUID: v+FsUucMTZySz4lJoRDQiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="90278907"
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="90278907"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 20:49:00 -0700
X-CSE-ConnectionGUID: tQz1KoGLSv6V5FnKrJZ9Kw==
X-CSE-MsgGUID: SJDb0zO8T0SRoBK3KiyUXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="236767321"
Received: from unknown (HELO localhost.png.intel.com) ([10.107.255.61])
  by orviesa009.jf.intel.com with ESMTP; 07 May 2026 20:48:56 -0700
From: KhaiWenTan <khai.wen.tan@linux.intel.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	faizal.abdul.rahim@intel.com,
	hong.aun.looi@intel.com,
	hector.blanco.alcaine@intel.com,
	khai.wen.tan@intel.com,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	Khai Wen Tan <khai.wen.tan@linux.intel.com>
Subject: [PATCH iwl-next v5 3/4] igc: replace goto out with direct returns in igc_config_fc_after_link_up()
Date: Fri,  8 May 2026 05:47:05 +0800
Message-ID: <20260507214706.309984-4-khai.wen.tan@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507214706.309984-1-khai.wen.tan@linux.intel.com>
References: <20260507214706.309984-1-khai.wen.tan@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E38F44F1434
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-285603-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[khai.wen.tan@linux.intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.intel.com:mid,intel.com:email,intel.com:dkim]
X-Rspamd-Action: no action

From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>

The out: label only returns ret_val with no cleanup. The kernel coding
style guide states: "If there is no cleanup needed then just return
directly." (Documentation/process/coding-style.rst, section 7).

This improves readability ahead of a subsequent patch that introduces a
new goto label in this function.

No functional change.

Reviewed-by: Looi Hong Aun <hong.aun.looi@intel.com>
Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Signed-off-by: Khai Wen Tan <khai.wen.tan@linux.intel.com>
---
 drivers/net/ethernet/intel/igc/igc_mac.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_mac.c b/drivers/net/ethernet/intel/igc/igc_mac.c
index 142beb9ae557..0a3d3f357505 100644
--- a/drivers/net/ethernet/intel/igc/igc_mac.c
+++ b/drivers/net/ethernet/intel/igc/igc_mac.c
@@ -458,15 +458,15 @@ s32 igc_config_fc_after_link_up(struct igc_hw *hw)
 	ret_val = hw->phy.ops.read_reg(hw, PHY_STATUS,
 				       &mii_status_reg);
 	if (ret_val)
-		goto out;
+		return ret_val;
 	ret_val = hw->phy.ops.read_reg(hw, PHY_STATUS,
 				       &mii_status_reg);
 	if (ret_val)
-		goto out;
+		return ret_val;
 
 	if (!(mii_status_reg & MII_SR_AUTONEG_COMPLETE)) {
 		hw_dbg("Copper PHY and Auto Neg has not completed.\n");
-		goto out;
+		return ret_val;
 	}
 
 	/* The AutoNeg process has completed, so we now need to
@@ -478,11 +478,11 @@ s32 igc_config_fc_after_link_up(struct igc_hw *hw)
 	ret_val = hw->phy.ops.read_reg(hw, PHY_AUTONEG_ADV,
 				       &mii_nway_adv_reg);
 	if (ret_val)
-		goto out;
+		return ret_val;
 	ret_val = hw->phy.ops.read_reg(hw, PHY_LP_ABILITY,
 				       &mii_nway_lp_ability_reg);
 	if (ret_val)
-		goto out;
+		return ret_val;
 	/* Two bits in the Auto Negotiation Advertisement Register
 	 * (Address 4) and two bits in the Auto Negotiation Base
 	 * Page Ability Register (Address 5) determine flow control
@@ -598,7 +598,7 @@ s32 igc_config_fc_after_link_up(struct igc_hw *hw)
 	ret_val = hw->mac.ops.get_speed_and_duplex(hw, &speed, &duplex);
 	if (ret_val) {
 		hw_dbg("Error getting link speed and duplex\n");
-		goto out;
+		return ret_val;
 	}
 
 	if (duplex == HALF_DUPLEX)
@@ -610,10 +610,9 @@ s32 igc_config_fc_after_link_up(struct igc_hw *hw)
 	ret_val = igc_force_mac_fc(hw);
 	if (ret_val) {
 		hw_dbg("Error forcing flow control settings\n");
-		goto out;
+		return ret_val;
 	}
 
-out:
 	return ret_val;
 }
 
-- 
2.43.0


