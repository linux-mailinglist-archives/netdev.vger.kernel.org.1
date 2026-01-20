Return-Path: <netdev+bounces-251498-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIWAJiprcGkVXwAAu9opvQ
	(envelope-from <netdev+bounces-251498-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 06:59:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F00251CD3
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 06:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1381B3EC23B
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 14:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6DD43C058;
	Tue, 20 Jan 2026 14:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yulx5t57"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D07343901F
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 14:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768917751; cv=none; b=HEd+gF44uU0nMr40phYmPoBvJNQ9CZzmmMTPy8Ky8xEMprxsmwhZwURQCKUt8oSJ14hcJJFUKWcIKU2EcN+udbcIidZwJW8S8whvP9U18quGtJdRgLs1GY1hlwmu6FvF+YjtrToPz1JCJruIl+kx1jGqy+7p3heRPQWlNHxkbeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768917751; c=relaxed/simple;
	bh=u6BDPVmJnQcjyrbWwPYe11Nbl9F6UGAuH3XDGMTgEw8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ObTPZRNlHPeqXCd2dWo2eYJ/OiPO7EuZDQu0STvc2ITSkA9b9C2L1QNukC2QXY5OGQSrcEojpwBOxGqibBxFKXw3UB8jvvPySIMeDSGw0D2WV+FkZi8aoNMDXZdg59bhOAL/q4GhhqlhJxc0LtTuWUUHPJTGLSTaFg/EwY0TPPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yulx5t57; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768917749; x=1800453749;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u6BDPVmJnQcjyrbWwPYe11Nbl9F6UGAuH3XDGMTgEw8=;
  b=Yulx5t57yPHEMreS7YTHBR8lxsL6BGTn8DP2Ob7eVpr2T2JD4Rq9a/Ov
   vghpr+eL8Hkx15410HZBPXAgJ3RAezmzCz3sL9Q5sFOX4DmBJQVk2QfSL
   ui4ZDSuF15PDZxRHUysnldhZqPsy4KFDvs8OcjqJDom8q8VYj4FnljL82
   oqTZgLC9qOCThH5HXfUCvYU4OvLuDlEoi1euhkKInG8+cVP4YUD/Fexf1
   7tyfkZ8/8evvTkc96hSckLWr8zK44bqIToH/aDZN8kzdVuYEL4pRcX2V3
   3JPPqwojq1OcUUkZof7qRsP413Hg6SOBEH166fME/FKxdCjml59W9LJQ7
   g==;
X-CSE-ConnectionGUID: vyGcto6GQ5K8JqoKk42P9A==
X-CSE-MsgGUID: n3dX2MbxQTaj0MDNrC1rdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="72711757"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="72711757"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 06:02:29 -0800
X-CSE-ConnectionGUID: 0hmNlgYgSAyhvDQW1kbBtA==
X-CSE-MsgGUID: Oda85k0BS7S4WTnPxHeIkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="210978904"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by fmviesa004.fm.intel.com with ESMTP; 20 Jan 2026 06:02:27 -0800
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next v2 2/6] ixgbe: E610: use new version of 0x601 ACI command buffer
Date: Tue, 20 Jan 2026 14:44:30 +0100
Message-Id: <20260120134434.1931602-3-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260120134434.1931602-1-jedrzej.jagielski@intel.com>
References: <20260120134434.1931602-1-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251498-lists,netdev=lfdr.de];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 4F00251CD3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Since FW version 1.40, buffer size of the 0x601 cmd has been increased
by 2B - from 24 to 26B. Buffer has been extended with new field
which can be used to configure EEE entry delay.

Pre-1.40 FW versions still expect 24B buffer and throws error when
receipts 26B buffer. To keep compatibility, check whether EEE
device capability flag is set and basing on it use appropriate
size of the command buffer.

Additionally place Set PHY Config capabilities defines out of
structs definitions.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c   | 17 ++++++++++++++++-
 .../net/ethernet/intel/ixgbe/ixgbe_type_e610.h  | 15 +++++++++------
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index 9ae1e3620ee1..431c932f036b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -1096,11 +1096,16 @@ int ixgbe_aci_set_phy_cfg(struct ixgbe_hw *hw,
 {
 	struct ixgbe_aci_cmd_set_phy_cfg *cmd;
 	struct libie_aq_desc desc;
+	bool use_buff_eee_field;
+	u16 buf_size;
 	int err;
 
 	if (!cfg)
 		return -EINVAL;
 
+	/* If FW supports EEE, we have to use buffer with EEE field. */
+	use_buff_eee_field = hw->dev_caps.common_cap.eee_support;
+
 	cmd = libie_aq_raw(&desc);
 	/* Ensure that only valid bits of cfg->caps can be turned on. */
 	cfg->caps &= IXGBE_ACI_PHY_ENA_VALID_MASK;
@@ -1109,7 +1114,17 @@ int ixgbe_aci_set_phy_cfg(struct ixgbe_hw *hw,
 	cmd->lport_num = hw->bus.func;
 	desc.flags |= cpu_to_le16(LIBIE_AQ_FLAG_RD);
 
-	err = ixgbe_aci_send_cmd(hw, &desc, cfg, sizeof(*cfg));
+	if (use_buff_eee_field)
+		buf_size = sizeof(*cfg);
+	else
+		/* Buffer w/o eee_entry_delay field is 2B smaller. */
+		buf_size = sizeof(*cfg) - sizeof(u16);
+
+	err = ixgbe_aci_send_cmd(hw, &desc, cfg, buf_size);
+
+	/* 1.40 config format is compatible with pre-1.40, just extends
+	 * it at the end.
+	 */
 	if (!err)
 		hw->phy.curr_user_phy_cfg = *cfg;
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
index 11dc7fc71b71..db62281c9413 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
@@ -382,6 +382,15 @@ struct ixgbe_aci_cmd_set_phy_cfg_data {
 	__le64 phy_type_low; /* Use values from IXGBE_PHY_TYPE_LOW_* */
 	__le64 phy_type_high; /* Use values from IXGBE_PHY_TYPE_HIGH_* */
 	u8 caps;
+	u8 low_power_ctrl_an;
+	__le16 eee_cap; /* Value from ixgbe_aci_get_phy_caps */
+	__le16 eeer_value; /* Use defines from ixgbe_aci_get_phy_caps */
+	u8 link_fec_opt; /* Use defines from ixgbe_aci_get_phy_caps */
+	u8 module_compliance_enforcement;
+	__le16  eee_entry_delay;
+} __packed;
+
+/* Set PHY config capabilities (@caps) defines */
 #define IXGBE_ACI_PHY_ENA_VALID_MASK		0xef
 #define IXGBE_ACI_PHY_ENA_TX_PAUSE_ABILITY	BIT(0)
 #define IXGBE_ACI_PHY_ENA_RX_PAUSE_ABILITY	BIT(1)
@@ -390,12 +399,6 @@ struct ixgbe_aci_cmd_set_phy_cfg_data {
 #define IXGBE_ACI_PHY_ENA_AUTO_LINK_UPDT	BIT(5)
 #define IXGBE_ACI_PHY_ENA_LESM			BIT(6)
 #define IXGBE_ACI_PHY_ENA_AUTO_FEC		BIT(7)
-	u8 low_power_ctrl_an;
-	__le16 eee_cap; /* Value from ixgbe_aci_get_phy_caps */
-	__le16 eeer_value; /* Use defines from ixgbe_aci_get_phy_caps */
-	u8 link_fec_opt; /* Use defines from ixgbe_aci_get_phy_caps */
-	u8 module_compliance_enforcement;
-};
 
 /* Restart AN command data structure (direct 0x0605)
  * Also used for response, with only the lport_num field present.
-- 
2.31.1


