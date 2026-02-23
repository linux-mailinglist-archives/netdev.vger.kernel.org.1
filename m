Return-Path: <netdev+bounces-259917-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKC2Iryim2kV4AMAu9opvQ
	(envelope-from <netdev+bounces-259917-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 01:43:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 22951170FC7
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 01:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 558053012204
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 00:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43661DB95E;
	Mon, 23 Feb 2026 00:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thubble.ca header.i=thubble@thubble.ca header.b="CDVS7/5Y"
X-Original-To: netdev@vger.kernel.org
Received: from wilbur.contactoffice.com (wilbur.contactoffice.com [212.3.242.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4002EB0F;
	Mon, 23 Feb 2026 00:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.3.242.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771807416; cv=none; b=B1rouZ9JYWyIdCxB24ASxmk0F/Vdb/LeP7jj7K6aZlSNrG1gv3wT3y7SN8ZmtpshbTHAA+cmAyKh86zIR1Ffw1Wg4MpMjoax30i5HEDtCxbVSMoYqPqV3aa6WaLVBXf6P2KJrwzWN9PdhXj9rF65QTJYdRkiF304hDEWg4aA3IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771807416; c=relaxed/simple;
	bh=qFEZpCjsLRG6Dw3zZ5ZayFyWBG0N35shV3P7mTZLQ2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZpxUhN6iIGZ3A+rQO+cyfWtRP2HgLKgp+L1hDUwQfRXWOEgv9dOBeCuiKmV8Sk67zy3pHMpus/QQDh52Ugw5aeAUCB9JDH5JSbNTSi1umxh/zJhvloGWGZDSdxWzBdQGmg9WucgaLF8GfX4mmsPsv7pL/lJ5ii/pS04nf59Med0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thubble.ca; spf=pass smtp.mailfrom=thubble.ca; dkim=pass (2048-bit key) header.d=thubble.ca header.i=thubble@thubble.ca header.b=CDVS7/5Y; arc=none smtp.client-ip=212.3.242.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thubble.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thubble.ca
Received: from smtpauth1.co-bxl (smtpauth1.co-bxl [10.2.0.15])
	by wilbur.contactoffice.com (Postfix) with ESMTP id 4971C2270;
	Mon, 23 Feb 2026 01:43:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771807406;
	s=20201109-m0tc; d=thubble.ca; i=thubble@thubble.ca;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Transfer-Encoding;
	bh=CJp5yUNmuRAtg8/wIWCl99pzK8mzYmMSvmfy0h8hZBw=;
	b=CDVS7/5YG0+4Gv5mbg7KFM39tU8eVNDjF1NTo/5E2vLq3rQMaCjtI60L7krT8heK
	YK9FF+cWH59dJN7Ak+NNPndmf372E/EsXB8teyLb2ZcWYLIdoDLr6USHEWt1Tn3TOvm
	ug+FFdCMZ1XLIeTj3Ialr2WQGrOSbEeq8zX1wkhUu8PpaOqVY3veY76gVMZ2kB5nTXx
	vwLz4ZKIhXt35Ohgr79ZI8vCOxzqo/RovI55CRM2T72fyZF0eZ+fYSktA+xYj8/7bIB
	OMWZUAvF1FPWinDzx5KFcbidup/0Y10UKH9nV0nF3PBFGNQzw2tlzhZeBI3cC+tVjNk
	qZWMLOi/CA==
Received: by smtp.mailfence.com with ESMTPSA ; Mon, 23 Feb 2026 01:43:23 +0100 (CET)
From: Tiernan Hubble <thubble@thubble.ca>
To: Igor Russkikh <irusskikh@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Tiernan Hubble <thubble@thubble.ca>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3] net: atlantic: fix reading SFP module info on some AQC100 cards
Date: Sun, 22 Feb 2026 18:41:38 -0600
Message-ID: <20260223004139.1444811-1-thubble@thubble.ca>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[thubble.ca,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[thubble.ca:s=20201109-m0tc];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[thubble@thubble.ca,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259917-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[thubble.ca:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,thubble.ca:mid,thubble.ca:dkim,thubble.ca:email]
X-Rspamd-Queue-Id: 22951170FC7
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

Signed-off-by: Tiernan Hubble <thubble@thubble.ca>
---
v3:
  - Submitting to net-next instead of net, and remove fixes tag
  - Cleanups as suggested in review
v2: https://lore.kernel.org/all/20260216224913.419470-1-thubble@thubble.ca/
  - Do not overwrite error code
  - Remove blank line between fixes and signed-off-by
v1: https://lore.kernel.org/all/20260215212609.193815-1-thubble@thubble.ca/
---
 .../ethernet/aquantia/atlantic/aq_ethtool.c   | 44 ++++++++--
 .../net/ethernet/aquantia/atlantic/aq_hw.h    |  3 +
 .../aquantia/atlantic/hw_atl/hw_atl_utils.h   |  7 ++
 .../atlantic/hw_atl/hw_atl_utils_fw2x.c       | 80 +++++++++++++++++++
 4 files changed, 128 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c b/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
index a6e1826dd5d7..43e0dbf93616 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
@@ -983,6 +983,38 @@ static int aq_ethtool_set_phy_tunable(struct net_device *ndev,
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
+	const struct aq_fw_ops *fw_ops = aq_nic->aq_fw_ops;
+	const struct aq_hw_ops *hw_ops = aq_nic->aq_hw_ops;
+	int err = -EOPNOTSUPP;
+
+	if (fw_ops->read_module_eeprom) {
+		err = fw_ops->read_module_eeprom(aq_nic->aq_hw, dev_addr,
+						 reg_start_addr, len, data);
+
+		/* If the only error is that the firmware version doesn't
+		 * support reading EEPROM, we can still attempt to read it
+		 * directly from the hardware if supported.
+		 */
+		if (err != -EOPNOTSUPP)
+			return err;
+	}
+
+	if (hw_ops->hw_read_module_eeprom)
+		err = hw_ops->hw_read_module_eeprom(aq_nic->aq_hw, dev_addr,
+						    reg_start_addr, len, data);
+
+	return err;
+}
+
 static int aq_ethtool_get_module_info(struct net_device *ndev,
 				      struct ethtool_modinfo *modinfo)
 {
@@ -992,15 +1024,15 @@ static int aq_ethtool_get_module_info(struct net_device *ndev,
 
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
@@ -1022,7 +1054,7 @@ static int aq_ethtool_get_module_eeprom(struct net_device *ndev,
 	unsigned int first, last, len;
 	int err;
 
-	if (!aq_nic->aq_hw_ops->hw_read_module_eeprom)
+	if (!aq_ethtool_can_read_module_eeprom(aq_nic))
 		return -EOPNOTSUPP;
 
 	first = ee->offset;
@@ -1032,7 +1064,7 @@ static int aq_ethtool_get_module_eeprom(struct net_device *ndev,
 		len = min(last, ETH_MODULE_SFF_8079_LEN);
 		len -= first;
 
-		err = aq_nic->aq_hw_ops->hw_read_module_eeprom(aq_nic->aq_hw,
+		err = aq_ethtool_read_module_eeprom(aq_nic,
 			SFF_8472_ID_ADDR, first, len, data);
 		if (err)
 			return err;
@@ -1045,7 +1077,7 @@ static int aq_ethtool_get_module_eeprom(struct net_device *ndev,
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
index 4d4cfbc91e19..2cac0d9670bf 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils_fw2x.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils_fw2x.c
@@ -703,6 +703,85 @@ static int aq_fw2x_send_macsec_req(struct aq_hw_s *hw,
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
+	req_dword_cnt = DIV_ROUND_UP(sizeof(request), sizeof(u32));
+	err = hw_atl_write_fwcfg_dwords(self, (void *)&request, req_dword_cnt);
+	if (err < 0)
+		return err;
+
+	/* Toggle 0x368.CAPS_LO_SMBUS_READ bit */
+	low_req = aq_hw_read_reg(self, HW_ATL_FW2X_MPI_CONTROL_ADDR);
+	orig_low_status = low_req & BIT(CAPS_LO_SMBUS_READ);
+	low_req ^= BIT(CAPS_LO_SMBUS_READ);
+	aq_hw_write_reg(self, HW_ATL_FW2X_MPI_CONTROL_ADDR, low_req);
+
+	/* Wait FW to report back */
+	err = readx_poll_timeout_atomic(aq_fw2x_state_get, self, low_status,
+					orig_low_status != (low_status &
+					BIT(CAPS_LO_SMBUS_READ)),
+					10U, 100000U);
+	if (err)
+		return err;
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
@@ -729,4 +808,5 @@ const struct aq_fw_ops aq_fw_2x_ops = {
 	.adjust_ptp         = aq_fw3x_adjust_ptp,
 	.get_link_capabilities = aq_fw2x_get_link_capabilities,
 	.send_macsec_req    = aq_fw2x_send_macsec_req,
+	.read_module_eeprom = aq_fw2x_read_module_eeprom,
 };
-- 
2.52.0


