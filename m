Return-Path: <netdev+bounces-137058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC819A4365
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 18:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A07F51F245A4
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 16:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9CB20262E;
	Fri, 18 Oct 2024 16:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brun.one header.i=@brun.one header.b="l0glYkvH"
X-Original-To: netdev@vger.kernel.org
Received: from mx.dolansoft.org (s2.dolansoft.org [212.51.146.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F6F1EE028;
	Fri, 18 Oct 2024 16:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.51.146.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729267988; cv=none; b=Xgl8h0+fdB4Zr+vr/39oE4gPxTMjkqtkZk39gYXCbCCLpVom8oZIcFDge7z/LQjdxNHzoqIrTJV3x/OevzmW+SUllu6XIWfpzJRgpF+xscnnxA4I08MPIwm83JUjEK25B1ALgMiMjMXC+nvWd+AzYHs/FV9gk11QYWicr+BCIog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729267988; c=relaxed/simple;
	bh=tgrolOZRF3Xz7aihHNv7ddDizvC6Hte+EsL3gSHHVoA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rMZpvg/6cZEOQwofT5084pWNC3r+lmREWgMY+QRWjy750jQ0WlZIdqWuifrGrDfZm/SoHbsWCDIloHObiUum3lDsoOJCadONbMlYTVbGdKFt6hgAqBykC56IIUW+J2ldNEeWQmM+r6fXr8R6e0MOkh2xB+4g3xvUvqOtIQ4WJG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brun.one; spf=pass smtp.mailfrom=brun.one; dkim=pass (2048-bit key) header.d=brun.one header.i=@brun.one header.b=l0glYkvH; arc=none smtp.client-ip=212.51.146.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brun.one
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brun.one
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=brun.one;
	s=s1; h=MIME-Version:Message-ID:Date:Subject:Cc:To:From:In-Reply-To:
	References:From:To:Subject:Date:Message-ID:Reply-To;
	bh=BldHjEe0xSwxZ1gWzCKpBt5uzsWzLY1/RbnicVPWEXE=; b=l0glYkvH8Zd9ErkwngxMpTE4Ok
	dpLhoSzfYD76HhLhUjpQyHbrneqqDtGjl6pDLqKe7ly/1hhGbxeM6WDohGOEf0SHksdXt8ahoWVfe
	QbDIohLY8XzM2KbENaJ6zOQMQDjTZ274R2fg/4O9DO/xKHjZm6+JwGLNzBD8j0lAP7ok55OEp96h/
	0ETlN7IfumjmhyUXy/gb7thXYQCrsLKy6krVHXXdUPLciIdcUDBttflvhWDUX7cBwD7rnJTUC+ZWm
	0M6Q8Zi3bYXWaW6Rumm7W4ZvT19GYMw4dYy4RrWIzssUsivwvLRljYzjlqmRlN7JipsjcSTOl98+Z
	amG9U1sQ==;
Received: from [212.51.153.89] (helo=localhost.localdomain)
	by mx.dolansoft.org with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98)
	(envelope-from <lorenz@dolansoft.org>)
	id 1t1pCb-00000000E9G-0wc5;
	Fri, 18 Oct 2024 15:47:45 +0000
From: Lorenz Brun <lorenz@brun.one>
To: Igor Russkikh <irusskikh@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] net: atlantic: support reading SFP module info
Date: Fri, 18 Oct 2024 17:47:38 +0200
Message-ID: <20241018154741.2565618-1-lorenz@brun.one>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: lorenz@dolansoft.org

Add support for reading SFP module info and digital diagnostic
monitoring data if supported by the module. The only Aquantia
controller without an integrated PHY is the AQC100 which belongs to
the B0 revision, that's why it's only implemented there.

The register information was extracted from a diagnostic tool made
publicly available by Dell, but all code was written from scratch by me.

This has been tested to work with a variety of both optical and direct
attach modules I had lying around and seems to work fine with all of
them, including the diagnostics if supported by an optical module.
All tests have been done with an AQC100 on an TL-NT521F card on firmware
version 3.1.121 (current at the time of this patch).

Signed-off-by: Lorenz Brun <lorenz@brun.one>
---
Changes since v2:
* Rebased on net-next
* Style nits
---
 .../ethernet/aquantia/atlantic/aq_ethtool.c   |  73 ++++++++++
 .../ethernet/aquantia/atlantic/aq_ethtool.h   |   8 ++
 .../net/ethernet/aquantia/atlantic/aq_hw.h    |   3 +
 .../aquantia/atlantic/hw_atl/hw_atl_b0.c      | 132 ++++++++++++++++++
 .../aquantia/atlantic/hw_atl/hw_atl_llh.c     |  43 ++++++
 .../aquantia/atlantic/hw_atl/hw_atl_llh.h     |  21 +++
 .../atlantic/hw_atl/hw_atl_llh_internal.h     |  32 +++++
 7 files changed, 312 insertions(+)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c b/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
index 440ff4616fec..6fef47ba0a59 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
@@ -15,6 +15,7 @@
 #include "aq_macsec.h"
 #include "aq_main.h"
 
+#include <linux/ethtool.h>
 #include <linux/linkmode.h>
 #include <linux/ptp_clock_kernel.h>
 
@@ -977,6 +978,76 @@ static int aq_ethtool_set_phy_tunable(struct net_device *ndev,
 	return err;
 }
 
+static int aq_ethtool_get_module_info(struct net_device *ndev,
+				      struct ethtool_modinfo *modinfo)
+{
+	struct aq_nic_s *aq_nic = netdev_priv(ndev);
+	u8 compliance_val, dom_type;
+	int err;
+
+	/* Module EEPROM is only supported for controllers with external PHY */
+	if (aq_nic->aq_nic_cfg.aq_hw_caps->media_type != AQ_HW_MEDIA_TYPE_FIBRE ||
+	    !aq_nic->aq_hw_ops->hw_read_module_eeprom)
+		return -EOPNOTSUPP;
+
+	err = aq_nic->aq_hw_ops->hw_read_module_eeprom(aq_nic->aq_hw,
+		SFF_8472_ID_ADDR, SFF_8472_COMP_ADDR, 1, &compliance_val);
+	if (err)
+		return err;
+
+	err = aq_nic->aq_hw_ops->hw_read_module_eeprom(aq_nic->aq_hw,
+		SFF_8472_ID_ADDR, SFF_8472_DOM_TYPE_ADDR, 1, &dom_type);
+	if (err)
+		return err;
+
+	if (dom_type & SFF_8472_ADDRESS_CHANGE_REQ_MASK || compliance_val == 0x00) {
+		modinfo->type = ETH_MODULE_SFF_8079;
+		modinfo->eeprom_len = ETH_MODULE_SFF_8079_LEN;
+	} else {
+		modinfo->type = ETH_MODULE_SFF_8472;
+		modinfo->eeprom_len = ETH_MODULE_SFF_8472_LEN;
+	}
+	return 0;
+}
+
+static int aq_ethtool_get_module_eeprom(struct net_device *ndev,
+					struct ethtool_eeprom *ee, unsigned char *data)
+{
+	struct aq_nic_s *aq_nic = netdev_priv(ndev);
+	unsigned int first, last, len;
+	int err;
+
+	if (!aq_nic->aq_hw_ops->hw_read_module_eeprom)
+		return -EOPNOTSUPP;
+
+	first = ee->offset;
+	last = ee->offset + ee->len;
+
+	if (first < ETH_MODULE_SFF_8079_LEN) {
+		len = min(last, ETH_MODULE_SFF_8079_LEN);
+		len -= first;
+
+		err = aq_nic->aq_hw_ops->hw_read_module_eeprom(aq_nic->aq_hw,
+			SFF_8472_ID_ADDR, first, len, data);
+		if (err)
+			return err;
+
+		first += len;
+		data += len;
+	}
+	if (first < ETH_MODULE_SFF_8472_LEN && last > ETH_MODULE_SFF_8079_LEN) {
+		len = min(last, ETH_MODULE_SFF_8472_LEN);
+		len -= first;
+		first -= ETH_MODULE_SFF_8079_LEN;
+
+		err = aq_nic->aq_hw_ops->hw_read_module_eeprom(aq_nic->aq_hw,
+			SFF_8472_DIAGNOSTICS_ADDR, first, len, data);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
 const struct ethtool_ops aq_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_MAX_FRAMES,
@@ -1014,4 +1085,6 @@ const struct ethtool_ops aq_ethtool_ops = {
 	.get_ts_info         = aq_ethtool_get_ts_info,
 	.get_phy_tunable     = aq_ethtool_get_phy_tunable,
 	.set_phy_tunable     = aq_ethtool_set_phy_tunable,
+	.get_module_info     = aq_ethtool_get_module_info,
+	.get_module_eeprom   = aq_ethtool_get_module_eeprom,
 };
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.h b/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.h
index 6d5be5ebeb13..f26fe1a75539 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.h
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.h
@@ -14,4 +14,12 @@
 extern const struct ethtool_ops aq_ethtool_ops;
 #define AQ_PRIV_FLAGS_MASK   (AQ_HW_LOOPBACK_MASK)
 
+#define SFF_8472_ID_ADDR 0x50
+#define SFF_8472_DIAGNOSTICS_ADDR 0x51
+
+#define SFF_8472_COMP_ADDR	0x5e
+#define SFF_8472_DOM_TYPE_ADDR	0x5c
+
+#define SFF_8472_ADDRESS_CHANGE_REQ_MASK 0x4
+
 #endif /* AQ_ETHTOOL_H */
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_hw.h b/drivers/net/ethernet/aquantia/atlantic/aq_hw.h
index f010bda61c96..42c0efc1b455 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_hw.h
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_hw.h
@@ -340,6 +340,9 @@ struct aq_hw_ops {
 	int (*hw_set_loopback)(struct aq_hw_s *self, u32 mode, bool enable);
 
 	int (*hw_get_mac_temp)(struct aq_hw_s *self, u32 *temp);
+
+	int (*hw_read_module_eeprom)(struct aq_hw_s *self, u8 dev_addr,
+				     u8 reg_start_addr, int len, u8 *data);
 };
 
 struct aq_fw_ops {
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
index 56c46266bb0a..493432d036b9 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
@@ -1654,6 +1654,137 @@ static int hw_atl_b0_get_mac_temp(struct aq_hw_s *self, u32 *temp)
 	return 0;
 }
 
+#define START_TRANSMIT 0x5001
+#define START_READ_TRANSMIT 0x5101
+#define STOP_TRANSMIT 0x3001
+#define REPEAT_TRANSMIT 0x1001
+#define REPEAT_NACK_TRANSMIT 0x1011
+
+static int hw_atl_b0_smb0_wait_result(struct aq_hw_s *self, bool expect_ack)
+{
+	int err;
+	u32 val;
+
+	err = readx_poll_timeout(hw_atl_smb0_byte_transfer_complete_get,
+				 self, val, val == 1, 100U, 10000U);
+	if (err)
+		return err;
+	if (hw_atl_smb0_receive_acknowledged_get(self) != expect_ack)
+		return -EIO;
+	return 0;
+}
+
+/* Starts an I2C/SMBUS write to a given address. addr is in 7-bit format,
+ * the read/write bit is not part of it.
+ */
+static int hw_atl_b0_smb0_start_write(struct aq_hw_s *self, u32 addr)
+{
+	hw_atl_smb0_tx_data_set(self, (addr << 1) | 0);
+	hw_atl_smb0_provisioning2_set(self, START_TRANSMIT);
+	return hw_atl_b0_smb0_wait_result(self, 0);
+}
+
+/* Writes a single byte as part of an ongoing write started by start_write. */
+static int hw_atl_b0_smb0_write_byte(struct aq_hw_s *self, u32 data)
+{
+	hw_atl_smb0_tx_data_set(self, data);
+	hw_atl_smb0_provisioning2_set(self, REPEAT_TRANSMIT);
+	return hw_atl_b0_smb0_wait_result(self, 0);
+}
+
+/* Starts an I2C/SMBUS read to a given address. addr is in 7-bit format,
+ * the read/write bit is not part of it.
+ */
+static int hw_atl_b0_smb0_start_read(struct aq_hw_s *self, u32 addr)
+{
+	int err;
+
+	hw_atl_smb0_tx_data_set(self, (addr << 1) | 1);
+	hw_atl_smb0_provisioning2_set(self, START_READ_TRANSMIT);
+	err = hw_atl_b0_smb0_wait_result(self, 0);
+	if (err)
+		return err;
+	if (hw_atl_smb0_repeated_start_detect_get(self) == 0)
+		return -EIO;
+	return 0;
+}
+
+/* Reads a single byte as part of an ongoing read started by start_read. */
+static int hw_atl_b0_smb0_read_byte(struct aq_hw_s *self)
+{
+	int err;
+
+	hw_atl_smb0_provisioning2_set(self, REPEAT_TRANSMIT);
+	err = hw_atl_b0_smb0_wait_result(self, 0);
+	if (err)
+		return err;
+	return hw_atl_smb0_rx_data_get(self);
+}
+
+/* Reads the last byte of an ongoing read. */
+static int hw_atl_b0_smb0_read_byte_nack(struct aq_hw_s *self)
+{
+	int err;
+
+	hw_atl_smb0_provisioning2_set(self, REPEAT_NACK_TRANSMIT);
+	err = hw_atl_b0_smb0_wait_result(self, 1);
+	if (err)
+		return err;
+	return hw_atl_smb0_rx_data_get(self);
+}
+
+/* Sends a stop condition and ends a transfer. */
+static void hw_atl_b0_smb0_stop(struct aq_hw_s *self)
+{
+	hw_atl_smb0_provisioning2_set(self, STOP_TRANSMIT);
+}
+
+static int hw_atl_b0_read_module_eeprom(struct aq_hw_s *self, u8 dev_addr,
+					u8 reg_start_addr, int len, u8 *data)
+{
+	int i, b;
+	int err;
+	u32 val;
+
+	/* Wait for SMBUS0 to be idle */
+	err = readx_poll_timeout(hw_atl_smb0_bus_busy_get, self,
+				 val, val == 0, 100U, 10000U);
+	if (err)
+		return err;
+
+	err = hw_atl_b0_smb0_start_write(self, dev_addr);
+	if (err)
+		goto out;
+
+	err = hw_atl_b0_smb0_write_byte(self, reg_start_addr);
+	if (err)
+		goto out;
+
+	err = hw_atl_b0_smb0_start_read(self, dev_addr);
+	if (err)
+		goto out;
+
+	for (i = 0; i < len - 1; i++) {
+		b = hw_atl_b0_smb0_read_byte(self);
+		if (b < 0) {
+			err = b;
+			goto out;
+		}
+		data[i] = (u8)b;
+	}
+
+	b = hw_atl_b0_smb0_read_byte_nack(self);
+	if (b < 0) {
+		err = b;
+		goto out;
+	}
+	data[i] = (u8)b;
+
+out:
+	hw_atl_b0_smb0_stop(self);
+	return err;
+}
+
 const struct aq_hw_ops hw_atl_ops_b0 = {
 	.hw_soft_reset        = hw_atl_utils_soft_reset,
 	.hw_prepare           = hw_atl_utils_initfw,
@@ -1712,4 +1843,5 @@ const struct aq_hw_ops hw_atl_ops_b0 = {
 	.hw_set_fc               = hw_atl_b0_set_fc,
 
 	.hw_get_mac_temp         = hw_atl_b0_get_mac_temp,
+	.hw_read_module_eeprom   = hw_atl_b0_read_module_eeprom,
 };
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_llh.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_llh.c
index 7b67bdd8a258..d07af1271d59 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_llh.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_llh.c
@@ -57,6 +57,49 @@ u32 hw_atl_ts_data_get(struct aq_hw_s *aq_hw)
 				  HW_ATL_TS_DATA_OUT_SHIFT);
 }
 
+u32 hw_atl_smb0_bus_busy_get(struct aq_hw_s *aq_hw)
+{
+	return aq_hw_read_reg_bit(aq_hw, HW_ATL_SMB0_BUS_BUSY_ADR,
+				HW_ATL_SMB0_BUS_BUSY_MSK,
+				HW_ATL_SMB0_BUS_BUSY_SHIFT);
+}
+
+u32 hw_atl_smb0_byte_transfer_complete_get(struct aq_hw_s *aq_hw)
+{
+	return aq_hw_read_reg_bit(aq_hw, HW_ATL_SMB0_BYTE_TRANSFER_COMPLETE_ADR,
+				HW_ATL_SMB0_BYTE_TRANSFER_COMPLETE_MSK,
+				HW_ATL_SMB0_BYTE_TRANSFER_COMPLETE_SHIFT);
+}
+
+u32 hw_atl_smb0_receive_acknowledged_get(struct aq_hw_s *aq_hw)
+{
+	return aq_hw_read_reg_bit(aq_hw, HW_ATL_SMB0_RX_ACKNOWLEDGED_ADR,
+				HW_ATL_SMB0_RX_ACKNOWLEDGED_MSK,
+				HW_ATL_SMB0_RX_ACKNOWLEDGED_SHIFT);
+}
+
+u32 hw_atl_smb0_repeated_start_detect_get(struct aq_hw_s *aq_hw)
+{
+	return aq_hw_read_reg_bit(aq_hw, HW_ATL_SMB0_REPEATED_START_DETECT_ADR,
+				HW_ATL_SMB0_REPEATED_START_DETECT_MSK,
+				HW_ATL_SMB0_REPEATED_START_DETECT_SHIFT);
+}
+
+u32 hw_atl_smb0_rx_data_get(struct aq_hw_s *aq_hw)
+{
+	return aq_hw_read_reg(aq_hw, HW_ATL_SMB0_RECEIVED_DATA_ADR);
+}
+
+void hw_atl_smb0_tx_data_set(struct aq_hw_s *aq_hw, u32 data)
+{
+	return aq_hw_write_reg(aq_hw, HW_ATL_SMB0_TRANSMITTED_DATA_ADR, data);
+}
+
+void hw_atl_smb0_provisioning2_set(struct aq_hw_s *aq_hw, u32 data)
+{
+	return aq_hw_write_reg(aq_hw, HW_ATL_SMB0_PROVISIONING2_ADR, data);
+}
+
 /* global */
 void hw_atl_reg_glb_cpu_sem_set(struct aq_hw_s *aq_hw, u32 glb_cpu_sem,
 				u32 semaphore)
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_llh.h b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_llh.h
index 58f5ee0a6214..5fd506acacb5 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_llh.h
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_llh.h
@@ -34,6 +34,27 @@ u32 hw_atl_ts_ready_latch_high_get(struct aq_hw_s *aq_hw);
 /* get temperature sense data */
 u32 hw_atl_ts_data_get(struct aq_hw_s *aq_hw);
 
+/* SMBUS0 bus busy */
+u32 hw_atl_smb0_bus_busy_get(struct aq_hw_s *aq_hw);
+
+/* SMBUS0 byte transfer complete */
+u32 hw_atl_smb0_byte_transfer_complete_get(struct aq_hw_s *aq_hw);
+
+/* SMBUS0 receive acknowledged */
+u32 hw_atl_smb0_receive_acknowledged_get(struct aq_hw_s *aq_hw);
+
+/* SMBUS0 set transmitted data (only leftmost byte of data valid) */
+void hw_atl_smb0_tx_data_set(struct aq_hw_s *aq_hw, u32 data);
+
+/* SMBUS0 provisioning2 command register */
+void hw_atl_smb0_provisioning2_set(struct aq_hw_s *aq_hw, u32 data);
+
+/* SMBUS0 repeated start detect */
+u32 hw_atl_smb0_repeated_start_detect_get(struct aq_hw_s *aq_hw);
+
+/* SMBUS0 received data register */
+u32 hw_atl_smb0_rx_data_get(struct aq_hw_s *aq_hw);
+
 /* global */
 
 /* set global microprocessor semaphore */
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_llh_internal.h b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_llh_internal.h
index 4a6467031b9e..fce30d90b6cb 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_llh_internal.h
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_llh_internal.h
@@ -42,6 +42,38 @@
 #define HW_ATL_TS_DATA_OUT_SHIFT 0
 #define HW_ATL_TS_DATA_OUT_WIDTH 12
 
+/* SMBUS0 Received Data register */
+#define HW_ATL_SMB0_RECEIVED_DATA_ADR 0x00000748
+/* SMBUS0 Transmitted Data register */
+#define HW_ATL_SMB0_TRANSMITTED_DATA_ADR 0x00000608
+
+/* SMBUS0 Global Provisioning 2 register */
+#define HW_ATL_SMB0_PROVISIONING2_ADR 0x00000604
+
+/* SMBUS0 Bus Busy Bitfield Definitions */
+#define HW_ATL_SMB0_BUS_BUSY_ADR 0x00000744
+#define HW_ATL_SMB0_BUS_BUSY_MSK 0x00000080
+#define HW_ATL_SMB0_BUS_BUSY_SHIFT 7
+#define HW_ATL_SMB0_BUS_BUSY_WIDTH 1
+
+/* SMBUS0 Byte Transfer Complete Bitfield Definitions */
+#define HW_ATL_SMB0_BYTE_TRANSFER_COMPLETE_ADR 0x00000744
+#define HW_ATL_SMB0_BYTE_TRANSFER_COMPLETE_MSK 0x00000002
+#define HW_ATL_SMB0_BYTE_TRANSFER_COMPLETE_SHIFT 1
+#define HW_ATL_SMB0_BYTE_TRANSFER_COMPLETE_WIDTH 1
+
+/* SMBUS0 Receive Acknowledge Bitfield Definitions */
+#define HW_ATL_SMB0_RX_ACKNOWLEDGED_ADR 0x00000744
+#define HW_ATL_SMB0_RX_ACKNOWLEDGED_MSK 0x00000100
+#define HW_ATL_SMB0_RX_ACKNOWLEDGED_SHIFT 8
+#define HW_ATL_SMB0_RX_ACKNOWLEDGED_WIDTH 1
+
+/* SMBUS0 Repeated Start Detect Bitfield Definitions */
+#define HW_ATL_SMB0_REPEATED_START_DETECT_ADR 0x00000744
+#define HW_ATL_SMB0_REPEATED_START_DETECT_MSK 0x00000004
+#define HW_ATL_SMB0_REPEATED_START_DETECT_SHIFT 2
+#define HW_ATL_SMB0_REPEATED_START_DETECT_WIDTH 1
+
 /* global microprocessor semaphore  definitions
  * base address: 0x000003a0
  * parameter: semaphore {s} | stride size 0x4 | range [0, 15]
-- 
2.44.1


