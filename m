Return-Path: <netdev+bounces-258803-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJcdEVw8kmn2sAEAu9opvQ
	(envelope-from <netdev+bounces-258803-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 22:36:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B39C13FC84
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 22:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46DA13007AE7
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 21:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47A827BF7D;
	Sun, 15 Feb 2026 21:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thubble.ca header.i=thubble@thubble.ca header.b="jCkwgljg"
X-Original-To: netdev@vger.kernel.org
Received: from wilbur.contactoffice.com (wilbur.contactoffice.com [212.3.242.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E3B199FB0;
	Sun, 15 Feb 2026 21:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.3.242.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771191384; cv=none; b=uCHcYJ5RMxC2VpCDs7YTubry3U8sY+9p9fwDAZIpflvEUykRjSYYEtnrMV6OtSQMebD+J13E6t4ydqgc1lkIGTxIBDbSnOfMVCMu2omdnrCVkOulCHBiS9fIVleCwK0ZWy7LDC1ZyPmBq7AUDIRqT9WkBxC3KFd18jXszEIjT0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771191384; c=relaxed/simple;
	bh=hSV/toip1yfn/kJ3hZrR41f0oEB1CkLxApZbFsdg+3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ELXvPzdJLAanV+TWB0/v72GrBxN9YeqsYyPEFUQnJqx/OlwsJL+Q5joYWeWlwaLpfGhg1/3cMDl+fdDPUgniD+zWvtkIwjxcpKQseArjTf8jiChNQ80G3HCMeN3q4Gce6HhHxZF12M+tS5U9jwawUpvon/QQ2a0DC/5qtM//yrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thubble.ca; spf=pass smtp.mailfrom=thubble.ca; dkim=pass (2048-bit key) header.d=thubble.ca header.i=thubble@thubble.ca header.b=jCkwgljg; arc=none smtp.client-ip=212.3.242.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thubble.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thubble.ca
Received: from smtpauth1.co-bxl (smtpauth1.co-bxl [10.2.0.15])
	by wilbur.contactoffice.com (Postfix) with ESMTP id 0148C1793;
	Sun, 15 Feb 2026 22:30:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771191022;
	s=20201109-m0tc; d=thubble.ca; i=thubble@thubble.ca;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Transfer-Encoding;
	bh=9uMZa3sqlioreu1HAzSEGjpkd73LCyouTn9q6QPOLYc=;
	b=jCkwgljg382ElTrfP9FZU4NznLp0Myt32tbeYyOPbsY+3rso2sdyVOdWbegVp7mL
	KFy2mDT2uSefcyVYaZhWjz3I2caaLGhrX3qFexkAvLcyRbdpGXS4l3MUA7tdbIIoFuW
	ofLZrMVdQTacdLgGuGbi+m2TfEcgoff5DD27NBVE+fKXln6wveBz7xHN6HEO1jdHPDN
	j1/ZS0NQi+TK1VEk3awu8N5Q3Gccp5OMVvT+GhXHKJS1dTS8SAYIyJlWk03dZZ3xtS2
	G6au4uMCBrm5KxuQyuNE+F/WCQST20BiWpSIr1SLprsFso7enrnVo67jnyvOkQQEbXB
	z2AdfLu3dw==
Received: by smtp.mailfence.com with ESMTPSA ; Sun, 15 Feb 2026 22:30:19 +0100 (CET)
From: Tiernan Hubble <thubble@thubble.ca>
To: Igor Russkikh <irusskikh@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Tiernan Hubble <thubble@thubble.ca>,
	Lorenz Brun <lorenz@brun.one>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: atlantic: fix reading SFP module info on some AQC100 cards
Date: Sun, 15 Feb 2026 15:26:08 -0600
Message-ID: <20260215212609.193815-1-thubble@thubble.ca>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ContactOffice-Account: com:266715177
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[thubble.ca,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[thubble.ca:s=20201109-m0tc];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-258803-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thubble@thubble.ca,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[thubble.ca:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8B39C13FC84
X-Rspamd-Action: no action

Commit 853a2944aaf3 ("net: atlantic: support reading SFP module info")
added support for reading SFP module info on AQC100-based cards. However,
it only supports reading directly from the controller's hardware
registers, and this does not seem to be supported on certain cards,
including my TRENDnet TEG-10GECSFP V3. "ethtool -m" times out when reading
certain registers, even when I increase the read poll timeout values.

The DPDK "atlantic" driver reads module info via firmware calls instead of
directly reading the hardware registers, provided that the NIC's firmware
version supports it.

This change adapts the DPDK firmware call code to the kernel driver. It
preserves the old hardware-based module read code as a fallback when the
firmware does not support it, to avoid breaking cards that are currently
working.

Tested on 2 different TRENDnet TEG-10GECSFP V3 cards, both with firmware
version 3.1.121 (current at the time of this patch). Both cards correctly
reported module info for a passive DAC cable and 2 different 10G optical
transceivers.

Fixes: 853a2944aaf3 ("net: atlantic: support reading SFP module info")

Signed-off-by: Tiernan Hubble <thubble@thubble.ca>
---
 .../ethernet/aquantia/atlantic/aq_ethtool.c   | 42 ++++++++--
 .../net/ethernet/aquantia/atlantic/aq_hw.h    |  3 +
 .../aquantia/atlantic/hw_atl/hw_atl_utils.h   |  7 ++
 .../atlantic/hw_atl/hw_atl_utils_fw2x.c       | 82 +++++++++++++++++++
 4 files changed, 128 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c b/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
index a6e1826dd5d7..5be9e9ee7e9f 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
@@ -983,6 +983,36 @@ static int aq_ethtool_set_phy_tunable(struct net_device *ndev,
 	return err;
 }
 
+static bool aq_ethtool_can_read_module_eeprom(struct aq_nic_s *aq_nic)
+{
+	return aq_nic->aq_fw_ops->read_module_eeprom ||
+		aq_nic->aq_hw_ops->hw_read_module_eeprom;
+}
+
+static int aq_ethtool_read_module_eeprom(struct aq_nic_s *aq_nic, u8 dev_addr,
+					 u8 reg_start_addr, int len, u8 *data)
+{
+	int err = -EOPNOTSUPP;
+
+	if (aq_nic->aq_fw_ops->read_module_eeprom) {
+		err = aq_nic->aq_fw_ops->read_module_eeprom(aq_nic->aq_hw,
+			dev_addr, reg_start_addr, len, data);
+
+		/* If the only error is that the firmware version doesn't
+		 * support reading EEPROM, we can still attempt to read it
+		 * directly from the hardware if supported.
+		 */
+		if (err != -EOPNOTSUPP)
+			return err;
+	}
+
+	if (aq_nic->aq_hw_ops->hw_read_module_eeprom)
+		err = aq_nic->aq_hw_ops->hw_read_module_eeprom(aq_nic->aq_hw,
+			dev_addr, reg_start_addr, len, data);
+
+	return err;
+}
+
 static int aq_ethtool_get_module_info(struct net_device *ndev,
 				      struct ethtool_modinfo *modinfo)
 {
@@ -992,15 +1022,15 @@ static int aq_ethtool_get_module_info(struct net_device *ndev,
 
 	/* Module EEPROM is only supported for controllers with external PHY */
 	if (aq_nic->aq_nic_cfg.aq_hw_caps->media_type != AQ_HW_MEDIA_TYPE_FIBRE ||
-	    !aq_nic->aq_hw_ops->hw_read_module_eeprom)
+	    !aq_ethtool_can_read_module_eeprom(aq_nic))
 		return -EOPNOTSUPP;
 
-	err = aq_nic->aq_hw_ops->hw_read_module_eeprom(aq_nic->aq_hw,
+	err = aq_ethtool_read_module_eeprom(aq_nic,
 		SFF_8472_ID_ADDR, SFF_8472_COMP_ADDR, 1, &compliance_val);
 	if (err)
 		return err;
 
-	err = aq_nic->aq_hw_ops->hw_read_module_eeprom(aq_nic->aq_hw,
+	err = aq_ethtool_read_module_eeprom(aq_nic,
 		SFF_8472_ID_ADDR, SFF_8472_DOM_TYPE_ADDR, 1, &dom_type);
 	if (err)
 		return err;
@@ -1022,7 +1052,7 @@ static int aq_ethtool_get_module_eeprom(struct net_device *ndev,
 	unsigned int first, last, len;
 	int err;
 
-	if (!aq_nic->aq_hw_ops->hw_read_module_eeprom)
+	if (!aq_ethtool_can_read_module_eeprom(aq_nic))
 		return -EOPNOTSUPP;
 
 	first = ee->offset;
@@ -1032,7 +1062,7 @@ static int aq_ethtool_get_module_eeprom(struct net_device *ndev,
 		len = min(last, ETH_MODULE_SFF_8079_LEN);
 		len -= first;
 
-		err = aq_nic->aq_hw_ops->hw_read_module_eeprom(aq_nic->aq_hw,
+		err = aq_ethtool_read_module_eeprom(aq_nic,
 			SFF_8472_ID_ADDR, first, len, data);
 		if (err)
 			return err;
@@ -1045,7 +1075,7 @@ static int aq_ethtool_get_module_eeprom(struct net_device *ndev,
 		len -= first;
 		first -= ETH_MODULE_SFF_8079_LEN;
 
-		err = aq_nic->aq_hw_ops->hw_read_module_eeprom(aq_nic->aq_hw,
+		err = aq_ethtool_read_module_eeprom(aq_nic,
 			SFF_8472_DIAGNOSTICS_ADDR, first, len, data);
 		if (err)
 			return err;
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_hw.h b/drivers/net/ethernet/aquantia/atlantic/aq_hw.h
index 4e66fd9b2ab1..57ea59026a2c 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_hw.h
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_hw.h
@@ -404,6 +404,9 @@ struct aq_fw_ops {
 	int (*send_macsec_req)(struct aq_hw_s *self,
 			       struct macsec_msg_fw_request *msg,
 			       struct macsec_msg_fw_response *resp);
+
+	int (*read_module_eeprom)(struct aq_hw_s *self, u8 dev_addr,
+				  u8 reg_start_addr, int len, u8 *data);
 };
 
 #endif /* AQ_HW_H */
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.h b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.h
index f6b990b7f5b4..404c84adad4a 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.h
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.h
@@ -319,6 +319,13 @@ struct __packed hw_atl_utils_settings {
 	u32 media_detect;
 };
 
+struct __packed smbus_request {
+	u32 msg_id;
+	u32 device_id;
+	u32 address;
+	u32 length;
+};
+
 enum macsec_msg_type {
 	macsec_cfg_msg = 0,
 	macsec_add_rx_sc_msg,
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils_fw2x.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils_fw2x.c
index 4d4cfbc91e19..ab94d01e517c 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils_fw2x.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils_fw2x.c
@@ -58,6 +58,8 @@
 
 #define HW_ATL_FW2X_CAP_MACSEC           BIT(CAPS_LO_MACSEC)
 
+#define HW_ATL_FW2X_CAP_SMBUS_READ       BIT(CAPS_LO_SMBUS_READ)
+
 #define HAL_ATLANTIC_WOL_FILTERS_COUNT   8
 #define HAL_ATLANTIC_UTILS_FW2X_MSG_WOL  0x0E
 
@@ -703,6 +705,85 @@ static int aq_fw2x_send_macsec_req(struct aq_hw_s *hw,
 	return err;
 }
 
+static int aq_fw2x_read_module_eeprom(struct aq_hw_s *self, u8 dev_addr,
+				      u8 reg_start_addr, int len, u8 *data)
+{
+	u32 low_status, orig_low_status, low_req = 0;
+	u32 res_bytes_remain_cnt = len % sizeof(u32);
+	u32 res_dword_cnt = len / sizeof(u32);
+	struct smbus_request request = { 0 };
+	u32 req_dword_cnt;
+	u32 result = 0;
+	u32 caps_lo;
+	u32 offset;
+	int err;
+
+	caps_lo = aq_fw2x_get_link_capabilities(self);
+	if (!(caps_lo & BIT(CAPS_LO_SMBUS_READ)))
+		return -EOPNOTSUPP;
+
+	request.msg_id = 0;
+	request.device_id = dev_addr;
+	request.address = reg_start_addr;
+	request.length = len;
+
+	/* Write SMBUS request to cfg memory */
+	req_dword_cnt = (sizeof(request) + sizeof(u32) - 1) / sizeof(u32);
+	err = hw_atl_write_fwcfg_dwords(self, (void *)&request, req_dword_cnt);
+	if (err < 0)
+		return err;
+
+	/* Toggle 0x368.CAPS_LO_SMBUS_READ bit */
+	low_req = aq_hw_read_reg(self, HW_ATL_FW2X_MPI_CONTROL_ADDR);
+	orig_low_status = low_req & BIT(CAPS_LO_SMBUS_READ);
+	low_req ^= HW_ATL_FW2X_CAP_SMBUS_READ;
+	aq_hw_write_reg(self, HW_ATL_FW2X_MPI_CONTROL_ADDR, low_req);
+
+	/* Wait FW to report back */
+	err = readx_poll_timeout_atomic(aq_fw2x_state_get, self, low_status,
+					orig_low_status != (low_status &
+					BIT(CAPS_LO_SMBUS_READ)),
+					10U, 100000U);
+	if (err)
+		return -EIO;
+
+	/* Read status of read operation */
+	offset = self->rpc_addr + sizeof(u32);
+	err = hw_atl_utils_fw_downld_dwords(self, offset, &result,
+					    sizeof(result) / sizeof(u32));
+	if (err < 0)
+		return err;
+	if (result)
+		return -EIO;
+
+	/* Read response full DWORD data */
+	if (res_dword_cnt) {
+		offset = self->rpc_addr + sizeof(u32) * 2;
+		err = hw_atl_utils_fw_downld_dwords(self, offset, (u32 *)data,
+						    res_dword_cnt);
+		if (err < 0)
+			return err;
+	}
+
+	/* Read response trailing bytes data */
+	if (res_bytes_remain_cnt) {
+		u32 bytes_remain_val = 0;
+
+		offset = self->rpc_addr +
+			 (sizeof(u32) * 2) +
+			 (res_dword_cnt * sizeof(u32));
+		err = hw_atl_utils_fw_downld_dwords(self, offset,
+						    &bytes_remain_val, 1);
+		if (err < 0)
+			return err;
+
+		memcpy(data + len - res_bytes_remain_cnt,
+		       &bytes_remain_val, res_bytes_remain_cnt);
+	}
+
+	return 0;
+}
+
 const struct aq_fw_ops aq_fw_2x_ops = {
 	.init               = aq_fw2x_init,
 	.deinit             = aq_fw2x_deinit,
@@ -729,4 +810,5 @@ const struct aq_fw_ops aq_fw_2x_ops = {
 	.adjust_ptp         = aq_fw3x_adjust_ptp,
 	.get_link_capabilities = aq_fw2x_get_link_capabilities,
 	.send_macsec_req    = aq_fw2x_send_macsec_req,
+	.read_module_eeprom = aq_fw2x_read_module_eeprom,
 };
-- 
2.52.0


