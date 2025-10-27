Return-Path: <netdev+bounces-233069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E316CC0BBFF
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 04:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9C3418A271C
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 03:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B811A2D6401;
	Mon, 27 Oct 2025 03:29:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBAC2D59E8;
	Mon, 27 Oct 2025 03:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761535794; cv=none; b=HVdUHcvJt5Xi1saJ58Veun7Le0RqzogffthgG+ErVpQ313N/O4thTvsmF1a8Vz7JBqMIsomPbRBVOngHgVwKP/LyPEwU8t7rWOa0hjVuFYOM1wZvpTTT0eoq1jRL4cyhe4DxuBjoQS6tux5q5hsun11W7ZqVN0VAZPMi+nBehVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761535794; c=relaxed/simple;
	bh=DxkIi3O7L9M5PwHXi2QZAhGKeDL+oVYnT3X5yRpdaQM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tjD01ydhQINnjDLVb5Zpsh4N44qtEUXC+fLGy4vUf+gXIn/HQgEIvpPmfsp0yUE62AhQjtIWsT/+y+9q6fhcsbYvSaAbAkfymXHmnXbuiQBeHPpvlaXX1cKgmk/iV4LhmE7lMcqwDM3tIWSImkO59gtuIe9Wo10Rd3HW2ucTbok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz2t1761535771td2324e4f
X-QQ-Originating-IP: Y0nKBloPmam3ZImnb3uMeNPve7ELbaX2xPMSOnM97fM=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 27 Oct 2025 11:29:29 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16894751778054469609
EX-QQ-RecipientCnt: 17
From: Dong Yibo <dong100@mucse.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	andrew+netdev@lunn.ch,
	danishanwar@ti.com,
	vadim.fedorenko@linux.dev,
	geert+renesas@glider.be,
	mpe@ellerman.id.au,
	lorenzo@kernel.org,
	lukas.bulwahn@redhat.com
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dong100@mucse.com
Subject: [PATCH net-next v16 4/5] net: rnpgbe: Add basic mbx_fw support
Date: Mon, 27 Oct 2025 11:29:04 +0800
Message-Id: <20251027032905.94147-5-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251027032905.94147-1-dong100@mucse.com>
References: <20251027032905.94147-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: MQPu5pFEJFN4Chn/tB2LVYTaAcsNzAKFVE7LVBLMJVrkVAZoSkSrF/C0
	V/LrAN0mTE7igmOes7R2ISH5fpl6umvKBTmc9AsHBoJCKzQmf9qdPB0xGwhPHayRI4C+xIG
	TRjHMJtu7pAHE8m8P+F/lpwC692GsFJFu5pjoBaFoYDTaTvytouTJlncE59Ovf1X6VB+JE/
	dhHx3hIQy3sMqTWclumFaBbabMKVlfRrzSUNLLUDkKHT+96ygm1VMOpoNCm0C+w6AMdAv45
	NenEEEZP5nVJIQlVuDRXlMf0435iz/0EYFhgxmx1KH8iWlv/qHRXYgOTjPzYeVkJeLRHrHY
	AatdzM9Y8QdOIAlmNlafvJselUQ6QS06S0ddFdl6cfJogZQ0SlbELGW/HsbIJKFpE39XaY5
	FZcqv9O6e0VV8HuxefmMH7beJeQBbEUaf3Y69LuXar9V6SvRYYMTQy408JExGTRGkVQ1LTN
	vGIRaP2ie0ujlgD8s8t0ZD558KXko6eAVYYhRBOqLre+rA6kHo07e/OOQJkqb1DsUAJR/ju
	dVzyXtkjTrTN3MAL4ZcaH3ecFPNqMJA90/YaZ4pwX2fwMUmTZJLTCzIfaDEIJhZ6SLtuS8J
	epk1reFBjHFCx6IEBljyhhJdKFa1i4R17dunfsvO2jC9dhfrfIQ7Zp7M7RqdBWD1psdfd/K
	yZKe2q4hFqIwR89P16usPNsvu4Thh+uSEIYo7mb80sO+kyE/0VOaeMEuvgQE7AXWrd92QkM
	SVQ5ck3VPvxhr6AopiDGHc+I05G5I2SW4pNm81cvxCA5LAKkZruxnNRJ/m9VKgxiArbg7UW
	A2qW/VCtkw2GL4wT9BxGH2qa2x1sWxAedXGEvjwUHPeQ91p7bNJajr/uGxzn6SAZHrns2Q5
	QIbxdyzIWAGaMx1Xb6W6u8qJPqDq6KjuQeZcHj/iARsQxdvrjz04xRj/j4Cco+jt2KdT7SQ
	s3XmbD0koSw2ar9be/c9qIbj2weyJn32zjvV7x8r7sHh5FtxDPEZfgpJ3ewNx5I88zcRFSs
	c4JvBHG4MgpCeoRRBY
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
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
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c | 191 ++++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h |  88 ++++++++
 5 files changed, 286 insertions(+), 1 deletion(-)
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
index 4c70b0cedd1f..37bd9278beaa 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -5,6 +5,7 @@
 #define _RNPGBE_H
 
 #include <linux/types.h>
+#include <linux/mutex.h>
 
 enum rnpgbe_boards {
 	board_n500,
@@ -16,6 +17,8 @@ struct mucse_mbx_info {
 	u32 delay_us;
 	u16 fw_req;
 	u16 fw_ack;
+	/* lock for only one use mbx */
+	struct mutex lock;
 	/* fw <--> pf mbx */
 	u32 fwpf_shm_base;
 	u32 pf2fw_mbx_ctrl;
@@ -26,6 +29,7 @@ struct mucse_mbx_info {
 struct mucse_hw {
 	void __iomem *hw_addr;
 	struct mucse_mbx_info mbx;
+	u8 pfvfnum;
 };
 
 struct mucse {
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
index 5de4b104455e..de5e29230b3c 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
@@ -401,5 +401,6 @@ void mucse_init_mbx_params_pf(struct mucse_hw *hw)
 
 	mbx->delay_us = 100;
 	mbx->timeout_us = 4 * USEC_PER_SEC;
+	mutex_init(&mbx->lock);
 	mucse_mbx_reset(hw);
 }
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
new file mode 100644
index 000000000000..8c8bd5e8e1db
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
@@ -0,0 +1,191 @@
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
+	int err;
+
+	err = mucse_fw_send_cmd_wait_resp(hw, &req, &reply);
+	if (!err)
+		hw->pfvfnum = FIELD_GET(GENMASK_U16(7, 0),
+					le16_to_cpu(reply.hw_info.pfnum));
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
index 000000000000..fb24fc12b613
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
@@ -0,0 +1,88 @@
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
+	__le32 ext_info;
+} __packed;
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


