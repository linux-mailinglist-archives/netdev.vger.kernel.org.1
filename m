Return-Path: <netdev+bounces-261088-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFe3Iy1nn2lRagQAu9opvQ
	(envelope-from <netdev+bounces-261088-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 22:18:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 155AA19DC31
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 22:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6540F30DD9A6
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 21:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CCC30FF29;
	Wed, 25 Feb 2026 21:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AxFlNoLV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D488314D16
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 21:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772054161; cv=none; b=GvwTWNuDpOqvhMHC6JB1NxDD8iAMKiUDHlY0icxkwjZuHfSRpz3C1qvu2Xfcr5Obv8q4DexNfVhMNXIQbR7Wx9Mtm8lpGezC4FtOC4L1IsFgM8c9icvgG4XSXXPQhyWaa7gC4wr+p8VqMAR/X3C6p/QprNABqiKZ+kcxTr/kr2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772054161; c=relaxed/simple;
	bh=1KcvINjx2zyVslDHy0Ibpn02518YOwAK8XndWCYYeaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CUjDZwtC2gSTPnezyNoY2zzApsa5zLwkSAHU7xQ6G//R9sVS8q+5MFxbW09xXqmB5cA/JY8RMtOU4wLgHf8aTqNKnxGgsf/K6j0G85D2XSQ23kYTTGbbrbAxklSLpscv/jkKqmZ3zO3xCubMhdp1ow64cX1q5L06sZ1/fsGVufQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AxFlNoLV; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772054161; x=1803590161;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1KcvINjx2zyVslDHy0Ibpn02518YOwAK8XndWCYYeaY=;
  b=AxFlNoLVRyuZfISvkly8PrtRP73OFHnOvHjzp/ES+wafgFOFulAc434J
   9iSTA/j0H39COkaaMlTUV3+xzt0rc8izOl1umV5tsOfj3YunVLSX316lZ
   XJTr7khXYv4HAK8wdySz/gaKe5DnhmE5YeEL8k6lrfpz+TGXZdTvVaAVI
   664auOl4H4dSBb/uZ+vZHkPh4/VfCeNGB3O487KsGfWL8fnqLPFvdG9/g
   c0e1STW72L2G1JIuMqZQphMYwuRHLWwC6KeJnlNY1ec5GVv90wHPkaFiH
   V1jxfm8sAYV3oQgNqkT8oQi3lrL50eFGHHiRtX2kz+/O+Uh7iDaxUeNXB
   g==;
X-CSE-ConnectionGUID: jGcehJdMTgeM7QafIi9aOQ==
X-CSE-MsgGUID: mUbUJUVUTx6XTw64Tgs5Dw==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="73013838"
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="73013838"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 13:15:58 -0800
X-CSE-ConnectionGUID: /CqauMncSG+YIF2nlWDc/Q==
X-CSE-MsgGUID: whuDQDsBQRyDIg318YrG5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="239349715"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 25 Feb 2026 13:15:57 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Vitaly Lifshits <vitaly.lifshits@intel.com>,
	anthony.l.nguyen@intel.com,
	dima.ruinskiy@intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Avigail Dahan <avigailx.dahan@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH net v2 12/12] e1000e: clear DPG_EN after reset to avoid autonomous power-gating
Date: Wed, 25 Feb 2026 13:15:43 -0800
Message-ID: <20260225211546.1949260-13-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260225211546.1949260-1-anthony.l.nguyen@intel.com>
References: <20260225211546.1949260-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261088-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:email,mpg.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 155AA19DC31
X-Rspamd-Action: no action

From: Vitaly Lifshits <vitaly.lifshits@intel.com>

Panther Lake systems introduced an autonomous power gating feature for
the integrated Gigabit Ethernet in shutdown state (S5) state. As part of
it, the reset value of DPG_EN bit was changed to 1. Clear this bit after
performing hardware reset to avoid errors such as Tx/Rx hangs, or packet
loss/corruption.

Fixes: 0c9183ce61bc ("e1000e: Add support for the next LOM generation")
Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/e1000e/defines.h | 1 +
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000e/defines.h b/drivers/net/ethernet/intel/e1000e/defines.h
index ba331899d186..d4a1041e456d 100644
--- a/drivers/net/ethernet/intel/e1000e/defines.h
+++ b/drivers/net/ethernet/intel/e1000e/defines.h
@@ -33,6 +33,7 @@
 
 /* Extended Device Control */
 #define E1000_CTRL_EXT_LPCD  0x00000004     /* LCD Power Cycle Done */
+#define E1000_CTRL_EXT_DPG_EN	0x00000008 /* Dynamic Power Gating Enable */
 #define E1000_CTRL_EXT_SDP3_DATA 0x00000080 /* Value of SW Definable Pin 3 */
 #define E1000_CTRL_EXT_FORCE_SMBUS 0x00000800 /* Force SMBus mode */
 #define E1000_CTRL_EXT_EE_RST    0x00002000 /* Reinitialize from EEPROM */
diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index 23421a640097..dea208db1be5 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -4932,6 +4932,15 @@ static s32 e1000_reset_hw_ich8lan(struct e1000_hw *hw)
 	reg |= E1000_KABGTXD_BGSQLBIAS;
 	ew32(KABGTXD, reg);
 
+	/* The hardware reset value of the DPG_EN bit is 1.
+	 * Clear DPG_EN to prevent unexpected autonomous power gating.
+	 */
+	if (hw->mac.type >= e1000_pch_ptp) {
+		reg = er32(CTRL_EXT);
+		reg &= ~E1000_CTRL_EXT_DPG_EN;
+		ew32(CTRL_EXT, reg);
+	}
+
 	return 0;
 }
 
-- 
2.47.1


