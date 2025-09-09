Return-Path: <netdev+bounces-221190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86720B4F403
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 14:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7D731C267BF
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 12:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662C2326D75;
	Tue,  9 Sep 2025 12:09:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8F73314AD;
	Tue,  9 Sep 2025 12:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757419793; cv=none; b=EKjLICuCMdmEEQHZDGqyAVUxx6gVztmZdV0JkIIlvO7RfuXoAVA2XIHFHjB+g6H3d8RPWssSSRlJsk1hCBKCl4kRjH8wEQ5hrHb9FS2qTU6YZOFskMWeQWPRwzH8ygf2p/j0iqrZGGIFCu7E83o7s3QLQKI8lvT6NqhE5H1ow1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757419793; c=relaxed/simple;
	bh=SgSyqU94C0k7BdLWiHwjnV9H0d0Rvz21Q7f4xBtFo2o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ecUgyBOvB0xOk9CodaDlCiOQYgEZq9cvf/s80Q/TiMUqU0ChF3+w2yrTjC87FiNUQBefhix7T0dCwbgHEYSSluePXDl8wVUnFuWxOj+URFYkkLa2QqsjrhwA9rtwRv8pX8oCHTUm3LIIj9aagAI34yCj/llZfEKwplaG0ewl6G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz6t1757419773t232d4610
X-QQ-Originating-IP: 9Ut5QpGFP+/JVLCJ+Wl/F/j1w2hkXli56wChWTtNqx8=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 09 Sep 2025 20:09:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12288802585582383249
EX-QQ-RecipientCnt: 28
From: Dong Yibo <dong100@mucse.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	gur.stavi@huawei.com,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	danishanwar@ti.com,
	lee@trager.us,
	gongfan1@huawei.com,
	lorenzo@kernel.org,
	geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com,
	lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com,
	richardcochran@gmail.com,
	kees@kernel.org,
	gustavoars@kernel.org,
	rdunlap@infradead.org,
	vadim.fedorenko@linux.dev
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	dong100@mucse.com
Subject: [PATCH net-next v11 4/5] net: rnpgbe: Add basic mbx_fw support
Date: Tue,  9 Sep 2025 20:09:05 +0800
Message-Id: <20250909120906.1781444-5-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250909120906.1781444-1-dong100@mucse.com>
References: <20250909120906.1781444-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MhAqc55qa+3vNKzzMPs22T6c3tSzCs3BZoCCLjnkACcXO+YnubHmbXl5
	xAXzr4xyBnRDFzv5ItdSXLyf/wfgA/KVUADrvLjnvqLbIYKSXmyVI9gm/6s3PTlEoq/Ml9r
	dXxkcsOIDwNZgpXwgs+CJkNf0UFXHS4Wx90u84Zxz6nK8VVr5TDgBhPtTOgdMqvCdOtGAL9
	ePNGd8VWIFNGtl2kQggrwAGMCqi9+QwqW7W4dPmkiPIF4rnL/KnsxKf8Lm+lkaz8f8qwPfl
	go2Jaju/fkjzLbShgL/nYycPNpZLjgJno2PVUbf0pbg4pVRFES07DcJx/ahhVsJ84jSAn2H
	oYlKjlEaYz2uR4g3/dH8mqee/0B75+qiNT9WY1j325dskVQ0q5uNaHm4w5xtce9FT03kWPZ
	Z1XRynjY0tzqNT3CsXXG+h3dkAJ01INfBtjGqPucH3ZyRQzy4wmem975ayPMm1kVOVZbVj7
	PaXR4HgUVXwH2MmCme6JTRDsPbwiQWOC3Cssn1Pd4QloDDC7WpbzCi5TXlYhcheK7XnsPmh
	lxOrzIMgRIhnfxQjVG9oyUJGrCXyMdTJr3LTBZju6/zpwMrSxehCGQo2fGgXr9ZICxboMbj
	T0lFNIkodO36n1xHROweL5WDXNCPrylBpj7/w3EOG85wUYIbR/B9jsvlaCcsaEajJibBB2/
	XFpHuFOlaX2a00797tO20LObmCYL+0Q03W5U0t3YvDxDwSb0uunXk6LzkqcctoFvQxr6HrA
	SR4qF3CeUFhEFVQI3tChe20rjjQqzHEUACnqOqufV4aW4BewPhKlwcEZH0QbmaDbmvc49zF
	kp6QCPcmCBGV3MWrDRP9Y2OT/teZBNytyvcA8xuRoNGwbfE0TS9PHqf8N65TVdeiDFQEUTh
	Dwz5rF4hHAdb9MbvqMM+k/oRKNo3n4Iaqea9gZFirUtAXNMMLMW6qbC3blIziqzGhv4myHU
	2b0zYuTa/rDSF6+xkg4H56+PE9Y67zeTEb5pA3VpuotLWUKtU37Qlss2M6QHH7di66l1npS
	XlfaejkXXxlcVWxOm37MAX9jGgM6Bc2lp5iXXKjg==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

Add fundamental firmware (FW) communication operations via PF-FW mailbox,
including:
- FW sync (via HW info query with retries)
- HW reset (post FW command to reset hardware)
- MAC address retrieval (request FW for port-specific MAC)
- Power management (powerup/powerdown notification to FW)

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/Makefile    |   3 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |   4 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    |   1 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c | 249 ++++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h | 121 +++++++++
 5 files changed, 377 insertions(+), 1 deletion(-)
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
index ac28502a8860..3a1ad82c24bd 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -5,6 +5,7 @@
 #define _RNPGBE_H
 
 #include <linux/types.h>
+#include <linux/mutex.h>
 
 enum rnpgbe_boards {
 	board_n500,
@@ -24,6 +25,8 @@ struct mucse_mbx_info {
 	u32 usec_delay;
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
index 9fcafda1bc5b..6ff3655033de 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
@@ -421,5 +421,6 @@ void mucse_init_mbx_params_pf(struct mucse_hw *hw)
 	mbx->stats.msgs_rx = 0;
 	mbx->stats.reqs = 0;
 	mbx->stats.acks = 0;
+	mutex_init(&mbx->lock);
 	mucse_mbx_reset(hw);
 }
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
new file mode 100644
index 000000000000..9b81ee679622
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
@@ -0,0 +1,249 @@
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
+ * build_get_hw_info_req - build req with GET_HW_INFO opcode
+ * @req: pointer to the cmd req structure
+ **/
+static void build_get_hw_info_req(struct mbx_fw_cmd_req *req)
+{
+	req->flags = 0;
+	req->opcode = cpu_to_le16(GET_HW_INFO);
+	req->datalen = cpu_to_le16(MUCSE_MBX_REQ_HDR_LEN);
+	req->reply_lo = 0;
+	req->reply_hi = 0;
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
+	struct mbx_fw_cmd_reply reply = {};
+	struct mbx_fw_cmd_req req = {};
+	struct mucse_hw_info info = {};
+	int err;
+
+	build_get_hw_info_req(&req);
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
+		if (err == -ETIMEDOUT)
+			continue;
+		break;
+	} while (try_cnt--);
+
+	return err;
+}
+
+/**
+ * build_powerup - build req with powerup opcode
+ * @req: pointer to the cmd req structure
+ * @is_powerup: true for powerup, false for powerdown
+ **/
+static void build_powerup(struct mbx_fw_cmd_req *req,
+			  bool is_powerup)
+{
+	req->flags = 0;
+	req->opcode = cpu_to_le16(POWER_UP);
+	req->datalen = cpu_to_le16(sizeof(req->powerup) +
+				   MUCSE_MBX_REQ_HDR_LEN);
+	req->reply_lo = 0;
+	req->reply_hi = 0;
+	/* fw needs this to reply correct cmd */
+	req->powerup.version = cpu_to_le32(GENMASK_U32(31, 0));
+	if (is_powerup)
+		req->powerup.status = cpu_to_le32(1);
+	else
+		req->powerup.status = cpu_to_le32(0);
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
+	struct mbx_fw_cmd_req req = {};
+	int len;
+	int err;
+
+	build_powerup(&req, is_powerup);
+	len = le16_to_cpu(req.datalen);
+	mutex_lock(&hw->mbx.lock);
+	err = mucse_write_and_wait_ack_mbx(hw, (u32 *)&req, len);
+	mutex_unlock(&hw->mbx.lock);
+
+	return err;
+}
+
+/**
+ * build_reset_hw_req - build req with RESET_HW opcode
+ * @req: pointer to the cmd req structure
+ **/
+static void build_reset_hw_req(struct mbx_fw_cmd_req *req)
+{
+	req->flags = 0;
+	req->opcode = cpu_to_le16(RESET_HW);
+	req->datalen = cpu_to_le16(MUCSE_MBX_REQ_HDR_LEN);
+	req->reply_lo = 0;
+	req->reply_hi = 0;
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
+	struct mbx_fw_cmd_reply reply = {};
+	struct mbx_fw_cmd_req req = {};
+
+	build_reset_hw_req(&req);
+
+	return mucse_fw_send_cmd_wait_resp(hw, &req, &reply);
+}
+
+/**
+ * build_get_macaddress_req - build req with get_mac opcode
+ * @req: pointer to the cmd req structure
+ * @port_mask: port valid for this cmd
+ * @pfvfnum: pfvfnum for this cmd
+ **/
+static void build_get_macaddress_req(struct mbx_fw_cmd_req *req,
+				     int port_mask, int pfvfnum)
+{
+	req->flags = 0;
+	req->opcode = cpu_to_le16(GET_MAC_ADDRESS);
+	req->datalen = cpu_to_le16(sizeof(req->get_mac_addr) +
+				   MUCSE_MBX_REQ_HDR_LEN);
+	req->reply_lo = 0;
+	req->reply_hi = 0;
+	req->get_mac_addr.port_mask = cpu_to_le32(port_mask);
+	req->get_mac_addr.pfvf_num = cpu_to_le32(pfvfnum);
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
+	struct mbx_fw_cmd_reply reply = {};
+	struct mbx_fw_cmd_req req = {};
+	int err;
+
+	build_get_macaddress_req(&req, BIT(port), pfvfnum);
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
index 000000000000..9dee6029e630
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
+	GET_HW_INFO = 0x0601,
+	GET_MAC_ADDRESS = 0x0602,
+	RESET_HW = 0x0603,
+	POWER_UP = 0x0803,
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


