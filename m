Return-Path: <netdev+bounces-297308-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id C4RmIrqHKGpMFwMAu9opvQ
	(envelope-from <netdev+bounces-297308-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 23:38:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F34086644B7
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 23:38:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=gjxkfAMt;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297308-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297308-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9909B3083192
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 21:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95597481652;
	Tue,  9 Jun 2026 21:36:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4782248AE04
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 21:36:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781040983; cv=none; b=VKrYEbaVPBB6NsFoMHM781uSYJSca6EbK96YlnAdtQVEg2eZTvsa8Q+g4+aQB5TwFwK76cVVmJvfWYeqH24yDvU51z5kmohZmuKBntv6Mf1OlWjUQgjzfW5SSgHMModOHVYpII3RQOymVeXubvwUYwzVP7ArRFIixjXvcl+jv5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781040983; c=relaxed/simple;
	bh=CIAK89/RtZi1scyuSXxY1ewLcU63mb44L7YBQrzmwFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sVD/XoidBk3IoleUODCF+CMZm/Ve4T13gB4/FhCzU0ewz/SfJcWbyArjYZEgtzVskMIyQZLD4GF60nnDz0CZo9JGznuiaLKHPw9qYBbA+w1SlhBJKdCPUwjdle2IwsuV6jO4NIV6Ra/43kx6kGhR1m5FJTU6DRSzfydQcrb/srI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gjxkfAMt; arc=none smtp.client-ip=198.175.65.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781040982; x=1812576982;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CIAK89/RtZi1scyuSXxY1ewLcU63mb44L7YBQrzmwFY=;
  b=gjxkfAMtCNHazGhnNHqX6PPvkkvly1nBoxLeLi6P+VnAaeXafo/nOYyL
   FMZezy71pNMa8V0Eyoyg/zmPJXZE3+wEkAKou7ooTcMl2GHDKQ/E41x3D
   qVtz3goAWQ7ZVLJQNqFn2zsasMrvy66HRwQU5Gl61a9/i/QK/BRQy04ON
   yVKb31rtOgH2sYa5hCYbo2Ljo80FAfMm3YhO1d9YZKSKn7w+8he0Rz0Jy
   iUxmod4OzErMbqIO5kL+fwd9/gFZTtcln9MtpRZvPBko/jygS2dTBGAgT
   vFZEZu3w/3wrchice3GJYVub9CuMHkRBl4yXf/E9OjJHvpvHsuhUHzS3T
   w==;
X-CSE-ConnectionGUID: q4kz61fVRnK0vGQpQKlZ3A==
X-CSE-MsgGUID: 2mPNggFdQkqCGdz9nZBkuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81568613"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="81568613"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 14:36:10 -0700
X-CSE-ConnectionGUID: U6Nbj1rmQB6VvQIS5wH4sw==
X-CSE-MsgGUID: Df7KRK0OTTaG48GUveU4KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="245838610"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 09 Jun 2026 14:36:09 -0700
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
Subject: [PATCH net-next 14/15] igb: fix typos in comments
Date: Tue,  9 Jun 2026 14:35:55 -0700
Message-ID: <20260609213559.178657-15-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260609213559.178657-1-anthony.l.nguyen@intel.com>
References: <20260609213559.178657-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,intel.com,dama.to];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:maximilianpezzullo@gmail.com,m:anthony.l.nguyen@intel.com,m:aleksandr.loktionov@intel.com,m:joe@dama.to,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-297308-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F34086644B7

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


