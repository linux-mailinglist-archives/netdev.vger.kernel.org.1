Return-Path: <netdev+bounces-279959-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHW2Ij7K5ml40wEAu9opvQ
	(envelope-from <netdev+bounces-279959-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 02:52:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CB24352B6
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 02:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 52A6030046B1
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 00:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF22E18FDDE;
	Tue, 21 Apr 2026 00:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gogD/Xi8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF101850A4
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 00:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776732727; cv=none; b=kNMgg54HC7IWd72q84h6vRBv+jsQ9UiCYQBmhNaL/C2HD+SQ7IiXuDrCpYWmQm4nJewh6VoVUPaN7CktmUc9jZzWTedwcfpMSLMNAovszYNtC0IWKJ5QMJp3XKIbW9tlH03HrAzk6Iz0yB6e4cmt3Ox6xmE+/5UR+FhYgOdrdaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776732727; c=relaxed/simple;
	bh=MkJXKTMqbuZ6q4jGzEi7hRlE6Y9ZszpyzeqyhYTwtAo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aOyTnIzEt2Ba6c9ZO5Rk/txDFPJxaqPxnmlEzgcRIU+RjmAvhLhsXR9rnQ/0eGARDnzJGITc2nkEveRKuaKImvy53eJr5i4GPCLKqmgR7Q+xEnBMO7m5FiKr5vf4rncKbX2Dctw/vNIv/t+buwWNVFnRchmV5eD0Th2uL9RCjxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gogD/Xi8; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776732725; x=1808268725;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=MkJXKTMqbuZ6q4jGzEi7hRlE6Y9ZszpyzeqyhYTwtAo=;
  b=gogD/Xi8z0BhdhrMY7P+M7gUZjoB6cPGrTHjsmvsdyQ3+8kC61yXp5g3
   I+Svms/1LobG6iKw4kwME+Kj+31YgLADV+RVNifSH1aUgvTor15O65xB9
   jN9PvXMqQeyJC0OfN5BIMqWdGX4kZVmQG2kYNpw32e52j3T5ewMsyjeou
   i1nKpBnt2ooS4s/7mkLLdnoxBShFM0V9ZjNNcEgf9IiRUboAtUlxtG8+T
   6G+GGyYShg6/K76kL+5hO/d8oNeY4Y8s+saKzNZjwFjzpxVZk1EDfpwPd
   k3d3aqv7yGC5x6/Z6qKRyZ0X8fHeFhyiPO3vUS/M9ZRUs6Zpynru/jxQZ
   w==;
X-CSE-ConnectionGUID: R9bkzavgSiWj4SeMI1GIEQ==
X-CSE-MsgGUID: v5ChtzYMRtubbwqLiIPhpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="77530396"
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="77530396"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 17:52:04 -0700
X-CSE-ConnectionGUID: EUTr1P2LTgKLagykuXx1iw==
X-CSE-MsgGUID: zFmkl4uCTqa+2e0CJ6T7Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="235886663"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 17:52:04 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 20 Apr 2026 17:51:25 -0700
Subject: [PATCH net 1/4] ice: fix timestamp interrupt configuration for
 E825C
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-jk-iwl-net-2026-04-20-ptp-e825c-phy-interrupt-fixes-v1-1-bc2240f42251@intel.com>
References: <20260420-jk-iwl-net-2026-04-20-ptp-e825c-phy-interrupt-fixes-v1-0-bc2240f42251@intel.com>
In-Reply-To: <20260420-jk-iwl-net-2026-04-20-ptp-e825c-phy-interrupt-fixes-v1-0-bc2240f42251@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Petr Oros <poros@redhat.com>, Sunitha Mekala <sunithax.d.mekala@intel.com>
X-Mailer: b4 0.16-dev-ea14f
X-Developer-Signature: v=1; a=openpgp-sha256; l=5595;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=f/72fmXUTGUBvRO8Pxozy0TmSLe/xIoCM96nSNyoatQ=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhsxnp4wbGeI4eO9oH7jxYLf+5lSjsGrOh0/k0iM/T80SK
 rTNX724o5SFQYyLQVZMkUXBIWTldeMJYVpvnOVg5rAygQxh4OIUgIlMusfwP3/rvSMdWdGXcue/
 E4/5pbE0wfcz96+qi9Oz5aZf+2X1bQLDP/P/uV6WOcFnOe1bFz1VOR4U1L3nyR7z7wEse0w3i2p
 ycwMA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279959-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A3CB24352B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Grzegorz Nitka <grzegorz.nitka@intel.com>

The E825C ice_phy_cfg_intr_eth56g() function is responsible for programming
the PHY interrupt for a given port. This function writes to the
PHY_REG_TS_INT_CONFIG register of the port. The register is responsible for
configuring whether the port interrupt logic is enabled, as well as
programming the threshold of waiting timestamps that will trigger an
interrupt from this port.

This threshold value must not be programmed to zero while the interrupt is
enabled. Doing so puts the port in a misconfigured state where the PHY
timestamp interrupt for the quad of connected ports will become stuck.

This occurs, because a threshold of zero results in the timestamp interrupt
status for the port becoming stuck high. The four ports in the connected
quad have their timestamp status indicators muxed together. A new interrupt
cannot be generated until the timestamp status indicators return low for
all four ports.

Normally, the timestamp status for a port will clear once there are fewer
timestamps in that ports timestamp memory bank than the threshold. A
threshold of zero makes this impossible, so the timestamp status for the
port does not clear.

The ice driver never intentionally programs the threshold to zero, indeed
the driver always programs it to a value of 1, intending to get an
interrupt immediately as soon as even a single packet is waiting for a
timestamp.

However, there is a subtle flaw in the programming logic in the
ice_phy_cfg_intr_eth56g() function. Due to the way that the hardware
handles enabling the PHY interrupt. If the threshold value is modified at
the same time as the interrupt is enabled, the HW PHY state machine might
enable the interrupt before the new threshold value is actually updated.
This leaves a potential race condition caused by the hardware logic where
a PHY timestamp interrupt might be triggered before the non-zero threshold
is written, resulting in the PHY timestamp logic becoming stuck.

Once the PHY timestamp status is stuck high, it will remain stuck even
after attempting to reprogram the PHY block by changing its threshold or
disabling the interrupt. Even a typical PF or CORE reset will not reset the
particular block of the PHY that becomes stuck. Even a warm power cycle is
not guaranteed to cause the PHY block to reset, and a cold power cycle is
required.

Prevent this by always writing the PHY_REG_TS_INT_CONFIG in two stages.
First write the threshold value with the interrupt disabled, and only write
the enable bit after the threshold has been programmed. When disabling the
interrupt, leave the threshold unchanged. Additionally, re-read the
register after writing it to guarantee that the write to the PHY has been
flushed upon exit of the function.

While we're modifying this function implementation, explicitly reject
programming a threshold of 0 when enabling the interrupt. No caller does
this today, but the consequences of doing so are significant. An explicit
rejection in the code makes this clear.

Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Petr Oros <poros@redhat.com>
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 36 +++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 5a5c511ccbb6..7f2f7440e705 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -1847,6 +1847,8 @@ static int ice_phy_cfg_mac_eth56g(struct ice_hw *hw, u8 port)
  * @ena: enable or disable interrupt
  * @threshold: interrupt threshold
  *
+ * The threshold cannot be 0 while the interrupt is enabled.
+ *
  * Configure TX timestamp interrupt for the specified port
  *
  * Return:
@@ -1858,19 +1860,45 @@ int ice_phy_cfg_intr_eth56g(struct ice_hw *hw, u8 port, bool ena, u8 threshold)
 	int err;
 	u32 val;
 
+	if (ena && !threshold)
+		return -EINVAL;
+
 	err = ice_read_ptp_reg_eth56g(hw, port, PHY_REG_TS_INT_CONFIG, &val);
 	if (err)
 		return err;
 
+	val &= ~PHY_TS_INT_CONFIG_ENA_M;
 	if (ena) {
-		val |= PHY_TS_INT_CONFIG_ENA_M;
 		val &= ~PHY_TS_INT_CONFIG_THRESHOLD_M;
 		val |= FIELD_PREP(PHY_TS_INT_CONFIG_THRESHOLD_M, threshold);
-	} else {
-		val &= ~PHY_TS_INT_CONFIG_ENA_M;
+		err = ice_write_ptp_reg_eth56g(hw, port, PHY_REG_TS_INT_CONFIG,
+					       val);
+		if (err) {
+			ice_debug(hw, ICE_DBG_PTP,
+				  "Failed to update 'threshold' PHY_REG_TS_INT_CONFIG port=%u ena=%u threshold=%u\n",
+				  port, !!ena, threshold);
+			return err;
+		}
+		val |= PHY_TS_INT_CONFIG_ENA_M;
 	}
 
-	return ice_write_ptp_reg_eth56g(hw, port, PHY_REG_TS_INT_CONFIG, val);
+	err = ice_write_ptp_reg_eth56g(hw, port, PHY_REG_TS_INT_CONFIG, val);
+	if (err) {
+		ice_debug(hw, ICE_DBG_PTP,
+			  "Failed to update 'ena' PHY_REG_TS_INT_CONFIG port=%u ena=%u threshold=%u\n",
+			  port, !!ena, threshold);
+		return err;
+	}
+
+	err = ice_read_ptp_reg_eth56g(hw, port, PHY_REG_TS_INT_CONFIG, &val);
+	if (err) {
+		ice_debug(hw, ICE_DBG_PTP,
+			  "Failed to read PHY_REG_TS_INT_CONFIG port=%u ena=%u threshold=%u\n",
+			  port, !!ena, threshold);
+		return err;
+	}
+
+	return 0;
 }
 
 /**

-- 
2.54.0.rc2.531.gaf818d63126a


