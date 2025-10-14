Return-Path: <netdev+bounces-229069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9073FBD7E27
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 09:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1AF7D4E1509
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 07:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF0730E0D0;
	Tue, 14 Oct 2025 07:27:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E665730DEDA;
	Tue, 14 Oct 2025 07:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760426873; cv=none; b=lm+/nZmrfGIgw18veNIheG7wvxp2Rh+K8400880MFaCq8/kxuCg+pAL8DZMKgkz+uQDLQI07KARf0je4NiaHolZrmiD6EwYvkAhdEVQ4gPavBcPZIoRNfwptmDHvcoF5K9F26pVHLQXNDuh55vsuA64PVqJ5GxatYM0oZSRUo2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760426873; c=relaxed/simple;
	bh=Gw0kS6MfKMn5a9ABcytBo6kusWBX6HUjXXjCnSLOoM8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IJkoUYTI1ZOb5gHWOBKWZMmehPH4JlL0FiiOH7cf5GEOSs72SMV8baQyDom/K7N5ndpaClbZbG2V80xT9mrJsxgoLo3/MdrQ9T4Uto351cF/BxRa8mGl3tdTWLIxgf8nu98XH4VMyARI6fG3ORaXRF2NDViI57cV2PsXNKA93RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz2t1760426860t6f534f5b
X-QQ-Originating-IP: YMWdd08nqTJKzbxUXvjjF+DV3mo55BgnvU4rM74e7ds=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 14 Oct 2025 15:27:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9935090016473382452
EX-QQ-RecipientCnt: 13
From: Dong Yibo <dong100@mucse.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	andrew+netdev@lunn.ch,
	danishanwar@ti.com,
	vadim.fedorenko@linux.dev
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dong100@mucse.com
Subject: [PATCH net-next v14 4/5] net: rnpgbe: Add basic mbx_fw support
Date: Tue, 14 Oct 2025 15:27:10 +0800
Message-Id: <20251014072711.13448-5-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251014072711.13448-1-dong100@mucse.com>
References: <20251014072711.13448-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MeVue4XBoBLbiyiADvXC8nAzOzpb9IQNDFj20jJPdK5+c95sVRXI9Xx/
	aG2mS7ACCjgQVP2BIjAgXz+0BEEqzkBWAMe3i1hy9JpcoPa6VtDZSMyCXx97+YQKPMPif1b
	m3dBPvg+ifRLPHtJQnxZnRiycwDI8otC6KgobGu+y/SMVDKUmeE6TPmkATG8WwvOLtI108B
	fNVzkMe8TOSc06yeo++HG2sSeGksXHkOI4WLW77nfizKcWZJ+4D7YQbjlswUWXVym5d7J9g
	PJu6Ho+0mzT9cKTVqKuiO9z9i/+pUql+aNkFtLrDlT9uFOgWKd2RrG3U76AlGDeFuaKqymC
	7KWCUgqOsGHaLT7U0cNb1IVi7184zEtE8GQ0u1HDB07rlzwoitcPOWhJcKkB6zjq+8CLAdc
	vSxu1hT8eqYPZZSkGb3slEFq+rAeDcZkelEPgijTS5pxonsvyew2pyuPMqO29g2HIAaL5H4
	bnLZfZIePfv1JNEwdJ7MLhXDi8X9Vw5rmItI3pkkvgwZC6EWAsb09uplADxX1bS2SsoVaZM
	QH2dPc3fwV4qBlzV4NGjWP0MSAex0KVYNvoH7PzXLzqdSEDHN2bCZK935U1YxFfbf/oK1Zl
	wYHVhb35vrjqmircbSlv8aJ2qxRfr+YFVS1cDgMSVxGUraLV1zSatj4SoBVbullCPG6qtA8
	Ss/Xf48FAngXDxCdHIupJguSDJtAck2yoCBerNvP1KUjtSD9n/TRs7f/KsS9MKpnJKBrnuD
	ggckU+ojhyhe7J2rso2bHi53sbN/YghSKgz+LUT5M+iO71mLGVdFgT8649nCK/91ks8/Xvh
	0bz1pDxCqxMKsNJsrufcDMxxj+KAhrx71+f+4MDIoqT3jN+PcJaSdl3abGKJoZvt1619Im1
	e/O8EdeXxaEk+GmxzbHxkN6EFWsoJnlSP5RIOS25bj0RqZOml7a2H2CzVUzAb9RaB2etv7K
	uKBXN58shI0RQ4GWKEd9zMWHeIJxvkItv3z6vUihvmBhZCoZYwqg5ultKogUyrun7sPYgBV
	+dQPyMYchxD/MTQg8qog726IpUPgN+2U0B7/9h6g==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

Add fundamental firmware (FW) communication operations via PF-FW
mailbox, including:
- FW sync (via HW info query with retries)
- HW reset (post FW command to reset hardware)
- MAC address retrieval (request FW for port-specific MAC)
- Power management (powerup/powerdown notification to FW)

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/Makefile    |   3 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |   4 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    |   1 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c | 195 ++++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h | 121 +++++++++++
 5 files changed, 323 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h

diff --git a/drivers/net/ethernet/mucse/rnpgbe/Makefile b/drivers/net/ethernet/mucse/rnpgbe/Makefile
index 5fc878ada4b1..de8bcb7772ab 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/Makefile
+++ b/drivers/net/ethernet/mucse/rnpgbe/Makefile
@@ -7,4 +7,5 @@
 obj-$(CONFIG_MGBE) += rnpgbe.o
 rnpgbe-objs := rnpgbe_main.o\
 	       rnpgbe_chip.o\
-	       rnpgbe_mbx.o
+	       rnpgbe_mbx.o\
+	       rnpgbe_mbx_fw.o
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
index f4af04b3117e..794581471b22 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -5,6 +5,7 @@
 #define _RNPGBE_H
 
 #include <linux/types.h>
+#include <linux/mutex.h>
 
 enum rnpgbe_boards {
 	board_n500,
@@ -24,6 +25,8 @@ struct mucse_mbx_info {
 	u32 delay_us;
 	u16 fw_req;
 	u16 fw_ack;
+	/* lock for only one use mbx */
+	struct mutex lock;
 	/* fw <--> pf mbx */
 	u32 fwpf_shm_base;
 	u32 pf2fw_mbx_ctrl;
@@ -34,6 +37,7 @@ struct mucse_mbx_info {
 struct mucse_hw {
 	void __iomem *hw_addr;
 	struct mucse_mbx_info mbx;
+	u8 pfvfnum;
 };
 
 struct mucse {
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
index b7e3d5dbadad..9c0e62ed33d4 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
@@ -411,5 +411,6 @@ void mucse_init_mbx_params_pf(struct mucse_hw *hw)
 	mbx->stats.msgs_rx = 0;
 	mbx->stats.reqs = 0;
 	mbx->stats.acks = 0;
+	mutex_init(&mbx->lock);
 	mucse_mbx_reset(hw);
 }
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
new file mode 100644
index 000000000000..2eaf24aa117e
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
@@ -0,0 +1,195 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2020 - 2025 Mucse Corporation. */
+
+#include <linux/if_ether.h>
+#include <linux/bitfield.h>
+
+#include "rnpgbe.h"
+#include "rnpgbe_mbx.h"
+#include "rnpgbe_mbx_fw.h"
+
+/**
+ * mucse_fw_send_cmd_wait_resp - Send cmd req and wait for response
+ * @hw: pointer to the HW structure
+ * @req: pointer to the cmd req structure
+ * @reply: pointer to the fw reply structure
+ *
+ * mucse_fw_send_cmd_wait_resp sends req to pf-fw mailbox and wait
+ * reply from fw.
+ *
+ * Return: 0 on success, negative errno on failure
+ **/
+static int mucse_fw_send_cmd_wait_resp(struct mucse_hw *hw,
+				       struct mbx_fw_cmd_req *req,
+				       struct mbx_fw_cmd_reply *reply)
+{
+	int len = le16_to_cpu(req->datalen);
+	int retry_cnt = 3;
+	int err;
+
+	mutex_lock(&hw->mbx.lock);
+	err = mucse_write_and_wait_ack_mbx(hw, (u32 *)req, len);
+	if (err)
+		goto out;
+	do {
+		err = mucse_poll_and_read_mbx(hw, (u32 *)reply,
+					      sizeof(*reply));
+		if (err)
+			goto out;
+		/* mucse_write_and_wait_ack_mbx return 0 means fw has
+		 * received request, wait for the expect opcode
+		 * reply with 'retry_cnt' times.
+		 */
+	} while (--retry_cnt >= 0 && reply->opcode != req->opcode);
+out:
+	mutex_unlock(&hw->mbx.lock);
+	if (!err && retry_cnt < 0)
+		return -ETIMEDOUT;
+	if (!err && reply->error_code)
+		return -EIO;
+
+	return err;
+}
+
+/**
+ * mucse_mbx_get_info - Get hw info from fw
+ * @hw: pointer to the HW structure
+ *
+ * mucse_mbx_get_info tries to get hw info from hw.
+ *
+ * Return: 0 on success, negative errno on failure
+ **/
+static int mucse_mbx_get_info(struct mucse_hw *hw)
+{
+	struct mbx_fw_cmd_req req = {
+		.datalen = cpu_to_le16(MUCSE_MBX_REQ_HDR_LEN),
+		.opcode  = cpu_to_le16(GET_HW_INFO),
+	};
+	struct mbx_fw_cmd_reply reply = {};
+	struct mucse_hw_info info = {};
+	int err;
+
+	err = mucse_fw_send_cmd_wait_resp(hw, &req, &reply);
+	if (!err) {
+		memcpy(&info, &reply.hw_info, sizeof(struct mucse_hw_info));
+		mucse_hw_info_update_host_endian(&info);
+		hw->pfvfnum = FIELD_GET(GENMASK_U16(7, 0),
+					le16_to_cpu(info.pfnum));
+	}
+
+	return err;
+}
+
+/**
+ * mucse_mbx_sync_fw - Try to sync with fw
+ * @hw: pointer to the HW structure
+ *
+ * mucse_mbx_sync_fw tries to sync with fw. It is only called in
+ * probe. Nothing (register network) todo if failed.
+ * Try more times to do sync.
+ *
+ * Return: 0 on success, negative errno on failure
+ **/
+int mucse_mbx_sync_fw(struct mucse_hw *hw)
+{
+	int try_cnt = 3;
+	int err;
+
+	do {
+		err = mucse_mbx_get_info(hw);
+	} while (err == -ETIMEDOUT && try_cnt--);
+
+	return err;
+}
+
+/**
+ * mucse_mbx_powerup - Echo fw to powerup
+ * @hw: pointer to the HW structure
+ * @is_powerup: true for powerup, false for powerdown
+ *
+ * mucse_mbx_powerup echo fw to change working frequency
+ * to normal after received true, and reduce working frequency
+ * if false.
+ *
+ * Return: 0 on success, negative errno on failure
+ **/
+int mucse_mbx_powerup(struct mucse_hw *hw, bool is_powerup)
+{
+	struct mbx_fw_cmd_req req = {
+		.datalen = cpu_to_le16(sizeof(req.powerup) +
+				       MUCSE_MBX_REQ_HDR_LEN),
+		.opcode  = cpu_to_le16(POWER_UP),
+		.powerup = {
+			/* fw needs this to reply correct cmd */
+			.version = cpu_to_le32(GENMASK_U32(31, 0)),
+			.status  = cpu_to_le32(is_powerup ? 1 : 0),
+		},
+	};
+	int len, err;
+
+	len = le16_to_cpu(req.datalen);
+	mutex_lock(&hw->mbx.lock);
+	err = mucse_write_and_wait_ack_mbx(hw, (u32 *)&req, len);
+	mutex_unlock(&hw->mbx.lock);
+
+	return err;
+}
+
+/**
+ * mucse_mbx_reset_hw - Posts a mbx req to reset hw
+ * @hw: pointer to the HW structure
+ *
+ * mucse_mbx_reset_hw posts a mbx req to firmware to reset hw.
+ * We use mucse_fw_send_cmd_wait_resp to wait hw reset ok.
+ *
+ * Return: 0 on success, negative errno on failure
+ **/
+int mucse_mbx_reset_hw(struct mucse_hw *hw)
+{
+	struct mbx_fw_cmd_req req = {
+		.datalen = cpu_to_le16(MUCSE_MBX_REQ_HDR_LEN),
+		.opcode  = cpu_to_le16(RESET_HW),
+	};
+	struct mbx_fw_cmd_reply reply = {};
+
+	return mucse_fw_send_cmd_wait_resp(hw, &req, &reply);
+}
+
+/**
+ * mucse_mbx_get_macaddr - Posts a mbx req to request macaddr
+ * @hw: pointer to the HW structure
+ * @pfvfnum: index of pf/vf num
+ * @mac_addr: pointer to store mac_addr
+ * @port: port index
+ *
+ * mucse_mbx_get_macaddr posts a mbx req to firmware to get mac_addr.
+ *
+ * Return: 0 on success, negative errno on failure
+ **/
+int mucse_mbx_get_macaddr(struct mucse_hw *hw, int pfvfnum,
+			  u8 *mac_addr,
+			  int port)
+{
+	struct mbx_fw_cmd_req req = {
+		.datalen      = cpu_to_le16(sizeof(req.get_mac_addr) +
+					    MUCSE_MBX_REQ_HDR_LEN),
+		.opcode       = cpu_to_le16(GET_MAC_ADDRESS),
+		.get_mac_addr = {
+			.port_mask = cpu_to_le32(BIT(port)),
+			.pfvf_num  = cpu_to_le32(pfvfnum),
+		},
+	};
+	struct mbx_fw_cmd_reply reply = {};
+	int err;
+
+	err = mucse_fw_send_cmd_wait_resp(hw, &req, &reply);
+	if (err)
+		return err;
+
+	if (le32_to_cpu(reply.mac_addr.ports) & BIT(port))
+		memcpy(mac_addr, reply.mac_addr.addrs[port].mac, ETH_ALEN);
+	else
+		return -ENODATA;
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
new file mode 100644
index 000000000000..375b8b86303e
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
@@ -0,0 +1,121 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2020 - 2025 Mucse Corporation. */
+
+#ifndef _RNPGBE_MBX_FW_H
+#define _RNPGBE_MBX_FW_H
+
+#include <linux/types.h>
+
+#include "rnpgbe.h"
+
+#define MUCSE_MBX_REQ_HDR_LEN 24
+
+enum MUCSE_FW_CMD {
+	GET_HW_INFO     = 0x0601,
+	GET_MAC_ADDRESS = 0x0602,
+	RESET_HW        = 0x0603,
+	POWER_UP        = 0x0803,
+};
+
+struct mucse_hw_info {
+	u8 link_stat;
+	u8 port_mask;
+	__le32 speed;
+	__le16 phy_type;
+	__le16 nic_mode;
+	__le16 pfnum;
+	__le32 fw_version;
+	__le32 axi_mhz;
+	union {
+		u8 port_id[4];
+		__le32 port_ids;
+	};
+	__le32 bd_uid;
+	__le32 phy_id;
+	__le32 wol_status;
+	union {
+		__le32 ext_info;
+		struct {
+			u32 valid : 1;
+			u32 wol_en : 1;
+			u32 pci_preset_runtime_en : 1;
+			u32 smbus_en : 1;
+			u32 ncsi_en : 1;
+			u32 rpu_en : 1;
+			u32 v2 : 1;
+			u32 pxe_en : 1;
+			u32 mctp_en : 1;
+			u32 yt8614 : 1;
+			u32 pci_ext_reset : 1;
+			u32 rpu_availble : 1;
+			u32 fw_lldp_ability : 1;
+			u32 lldp_enabled : 1;
+			u32 only_1g : 1;
+			u32 force_down_en: 1;
+		} e_host;
+	};
+} __packed;
+
+/* FW stores extended information in 'ext_info' as a 32-bit
+ * little-endian value. To make these flags easily accessible in the
+ * kernel (via named 'bitfields' instead of raw bitmask operations),
+ * we use the union's 'e_host' struct, which provides named bits
+ * (e.g., 'wol_en', 'smbus_en')
+ */
+static inline void mucse_hw_info_update_host_endian(struct mucse_hw_info *info)
+{
+	u32 host_val = le32_to_cpu(info->ext_info);
+
+	memcpy(&info->e_host, &host_val, sizeof(info->e_host));
+}
+
+struct mbx_fw_cmd_req {
+	__le16 flags;
+	__le16 opcode;
+	__le16 datalen;
+	__le16 ret_value;
+	__le32 cookie_lo;
+	__le32 cookie_hi;
+	__le32 reply_lo;
+	__le32 reply_hi;
+	union {
+		u8 data[32];
+		struct {
+			__le32 version;
+			__le32 status;
+		} powerup;
+		struct {
+			__le32 port_mask;
+			__le32 pfvf_num;
+		} get_mac_addr;
+	};
+} __packed;
+
+struct mbx_fw_cmd_reply {
+	__le16 flags;
+	__le16 opcode;
+	__le16 error_code;
+	__le16 datalen;
+	__le32 cookie_lo;
+	__le32 cookie_hi;
+	union {
+		u8 data[40];
+		struct mac_addr {
+			__le32 ports;
+			struct _addr {
+				/* for macaddr:01:02:03:04:05:06
+				 * mac-hi=0x01020304 mac-lo=0x05060000
+				 */
+				u8 mac[8];
+			} addrs[4];
+		} mac_addr;
+		struct mucse_hw_info hw_info;
+	};
+} __packed;
+
+int mucse_mbx_sync_fw(struct mucse_hw *hw);
+int mucse_mbx_powerup(struct mucse_hw *hw, bool is_powerup);
+int mucse_mbx_reset_hw(struct mucse_hw *hw);
+int mucse_mbx_get_macaddr(struct mucse_hw *hw, int pfvfnum,
+			  u8 *mac_addr, int port);
+#endif /* _RNPGBE_MBX_FW_H */
-- 
2.25.1


