Return-Path: <netdev+bounces-259631-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIiDMrytl2nO5QIAu9opvQ
	(envelope-from <netdev+bounces-259631-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 01:41:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CD3163E88
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 01:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89C2C3010B8B
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 00:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC62620CCDC;
	Fri, 20 Feb 2026 00:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Itym/6ta"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A6120D4FC
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 00:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771548055; cv=none; b=fPrqdSn5LqC+AAefWL8ut/kizWuFQeWIjFBXvuFmVNFi2dh06BtIbGxOKyGDGRR9ClbuNCDZh2MAE81WUDYSJfm+DZ6ZN0S0PKf+nd+wuvwhubBOJZP72C6ZhASHFgmQZf+u4R+3zty85DFaAJd2M4BDMBT+l7+IksBaFXuqQXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771548055; c=relaxed/simple;
	bh=1KcvINjx2zyVslDHy0Ibpn02518YOwAK8XndWCYYeaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P5zoBdsPgCdA65aToISjHfQKXE/ApYx6y/47LhAbdV6xQ4x0AeGnlbCQohse/ajxbfvfEZ8lnLps4eHZU5Od0jFqywGXnt1CEpcF5Im3aGM/Ad1gUmb+pW1UzQ9J8b0Lbzkz+jn/dSTITmNiXhFwMOcQ74WlYOSTNY0O1LPuYOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Itym/6ta; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771548045; x=1803084045;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1KcvINjx2zyVslDHy0Ibpn02518YOwAK8XndWCYYeaY=;
  b=Itym/6ta1J8auOyLnC6RxJqXJaqvXKYrN4XxSW0Di79M3NCASOYELtFn
   7KHmo8E0zGf80iynijo/YyzJlXzUENnLsOiqZRiViK6SW60aLkVxmezyo
   ZSIgHOSUUOycO2hvOIxGv65woXZeOYEexq3vmbfU29/6GuGkdECuzT+lc
   N5Ik3OsAz36wZCB6/c/ENeVMp3UIKoIgCmjjNpXJWHmJfN0B52E3zkBr/
   ocLV9+5ZPuSfsNas97GvI8p5EyT9IMRdiQlbV2lHoHpVjZTRrcFBBpAUf
   Axq8CbQuEeMVP0pe0R371vV6fp7GBjs4m7XcMMdZ1EL0IlrXxBA6ud+LD
   w==;
X-CSE-ConnectionGUID: y5jepP3fR6y6wcbNDSmz6Q==
X-CSE-MsgGUID: /UKaLiFhSP2bqjHB25OO4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="76484245"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="76484245"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 16:40:35 -0800
X-CSE-ConnectionGUID: VrbPN76QTk+2DEXyKddzwA==
X-CSE-MsgGUID: t24dQ7dvT++Yve3DHhAQcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="218850498"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa003.jf.intel.com with ESMTP; 19 Feb 2026 16:40:34 -0800
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
Subject: [PATCH net 12/13] e1000e: clear DPG_EN after reset to avoid autonomous power-gating
Date: Thu, 19 Feb 2026 16:40:24 -0800
Message-ID: <20260220004027.729384-13-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260220004027.729384-1-anthony.l.nguyen@intel.com>
References: <20260220004027.729384-1-anthony.l.nguyen@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-259631-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mpg.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 64CD3163E88
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


