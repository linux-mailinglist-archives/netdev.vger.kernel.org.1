Return-Path: <netdev+bounces-212838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BF4B22398
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 11:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F91E3A7385
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 09:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C052EA151;
	Tue, 12 Aug 2025 09:41:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FBB2EAD1D;
	Tue, 12 Aug 2025 09:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754991691; cv=none; b=iryUFv/iav35icshWCCc9+lIPJhd5PyNazgzv5J0jTs7A+abEMstHKnX+PyFvZMyChU/k+7rUHhbuRCuKXjLfOpKjtoc9ItQHElBcNVDiGmi0JBKjzte94Z1O6bXc1mGKNr8ELLURkWbtSUKBDRojV1s8Q1gG1u4ck6nR9rL61s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754991691; c=relaxed/simple;
	bh=f41HlX/NLrKhLPQBLWCy51uycoJzPhrPiYj4arucKOw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sLDQJ0HS/Dys5WawPbsXSE4sCZo4/1MYlVQs4Vs0GCbJcqkRFOrSunVMR56LRt1FqTv2j8M+K6Mi2DtbhVZeILjaTFbI+Ug9mdV8qshCgGHtpCW64YaAED6upVtd9nQCalqXS2XfJymIPFo7CBZeRDTZztOz/VeesHJOC4yChQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz7t1754991613t993b4b1a
X-QQ-Originating-IP: EKBbLG8E6GL3Qzxg9e574gFtSVbl2QGtyKcpZ2SjsQI=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 12 Aug 2025 17:40:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10205774078129648115
EX-QQ-RecipientCnt: 23
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
	richardcochran@gmail.com
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dong100@mucse.com
Subject: [PATCH v3 4/5] net: rnpgbe: Add basic mbx_fw support
Date: Tue, 12 Aug 2025 17:39:36 +0800
Message-Id: <20250812093937.882045-5-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250812093937.882045-1-dong100@mucse.com>
References: <20250812093937.882045-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NSEFX6u+4l+Ke3pQr9bGqBIT6Z/vsRKJCY1ijxU7Q8ulL6mfWAENfq2r
	cnsHII2zmUJSFnNGZilVd0F9uoBPCBMZsY0S69M9JdYHnrXPyAbNLrSGVJXZVC9XyMqD7hh
	pKmIVSqr/3Z1nQ+ZNnFS7VT79eU4Q7KMvCnwryjeBmzAAZFqz7c0B1LfE9R5zOAnI6dXJU4
	F16xv+b4pAIlTqJbXbjHKO/taY13/s7bKPl3/Ok3nyDMxY6y7y2F+eF2rjm3nNbEgdqBb/F
	nZmq6lPfKNYYsPrEr3g0Ig3MQqQ8Cs4t9O2ivpHz6wg4dyyuAk9ohsK7gQ4ZXmKOMgBf7R6
	lPDdR9oO9uSn2btGZyQ2r42bKFEqfzx2BOixS0GE9KqXiQmuCriVbUsGPXST2ditJZ6TCRN
	/NpoQU6Mp1WvGAhf0woxTfQ6mSuXlwiyL2S2O7hOFbWqkWSRFpe8QxWpoGDE1jRvlzo8UmX
	m0f3ODtcUNsJMFiuwGXAgKdlmLdtL61wprwAI+EsaOlHuJsw4jXTQvHPm/7T756OjaYOkPx
	5fuBasQpXx7JSQ78YmX1rsuk5qdVzKk+Komsqk9y5//goCBPBTjdhs5K+SsBp8bbWKxzZhV
	QvUaiFDTEQMewZ1Xjs6TF/nhsC3ltDD1jNETtYxCH/q0+gHehuG++ibkEmXBUSnLwMAfDnF
	2qRWtT9ZAItlW9W+MvunyH0CIvwUg89Ppv9+/P/3FEt1TfjAJ3S2mXlEj5jRHIbj2crJF+H
	OpG13TSMDRQOBfs63KK7Oj9JD/1LmTsATRS6puoxK6eoQ4hbcJArMkYcUN0cF/yTLC+XHzB
	OXapHB+RbXk6kxXOKqHXDwHjBv1ptTZPl0EJf/JNIDc9KCSkZktD7dBu9Q4mOgsezopvKCk
	0tM9JoInxx7J5qEsvkGvYlewegTJcAzDcPtjSnsu7bsXxszmltqKLZnv0CckSRM/Xv3yJ7g
	Aw2GUIX5A96MeSAfzLb8va7nZ6L5K7ewUpQitN5A9KWoBgRGiCQ3MIVBA4FMdTEDdA9ZTT+
	FjzBwUzg==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

Initialize basic mbx_fw ops, such as get_capability, reset phy
and so on.

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/Makefile    |   3 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |   4 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c | 275 ++++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h | 201 +++++++++++++
 4 files changed, 482 insertions(+), 1 deletion(-)
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
index 05830bb73d3e..6cb14b79cbfe 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -88,9 +88,13 @@ struct mucse_mbx_info {
 
 struct mucse_hw {
 	void *back;
+	u8 pfvfnum;
 	void __iomem *hw_addr;
 	void __iomem *ring_msix_base;
 	struct pci_dev *pdev;
+	u32 fw_version;
+	u32 axi_mhz;
+	u32 bd_uid;
 	enum rnpgbe_hw_type hw_type;
 	struct mucse_dma_info dma;
 	struct mucse_eth_info eth;
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
new file mode 100644
index 000000000000..374eb9df1369
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
@@ -0,0 +1,275 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2020 - 2025 Mucse Corporation. */
+
+#include <linux/pci.h>
+
+#include "rnpgbe.h"
+#include "rnpgbe_hw.h"
+#include "rnpgbe_mbx.h"
+#include "rnpgbe_mbx_fw.h"
+
+/**
+ * mucse_fw_send_cmd_wait - Send cmd req and wait for response
+ * @hw: pointer to the HW structure
+ * @req: pointer to the cmd req structure
+ * @reply: pointer to the fw reply structure
+ *
+ * mucse_fw_send_cmd_wait sends req to pf-fw mailbox and wait
+ * reply from fw.
+ *
+ * @return: 0 on success, negative on failure
+ **/
+static int mucse_fw_send_cmd_wait(struct mucse_hw *hw,
+				  struct mbx_fw_cmd_req *req,
+				  struct mbx_fw_cmd_reply *reply)
+{
+	int len = le16_to_cpu(req->datalen) + MBX_REQ_HDR_LEN;
+	int retry_cnt = 3;
+	int err;
+
+	err = mutex_lock_interruptible(&hw->mbx.lock);
+	if (err)
+		return err;
+	err = hw->mbx.ops->write_posted(hw, (u32 *)req,
+					L_WD(len));
+	if (err) {
+		mutex_unlock(&hw->mbx.lock);
+		return err;
+	}
+	do {
+		err = hw->mbx.ops->read_posted(hw, (u32 *)reply,
+					       L_WD(sizeof(*reply)));
+		if (err) {
+			mutex_unlock(&hw->mbx.lock);
+			return err;
+		}
+	} while (--retry_cnt >= 0 && reply->opcode != req->opcode);
+	mutex_unlock(&hw->mbx.lock);
+	if (retry_cnt < 0 || reply->error_code)
+		return -EIO;
+	return 0;
+}
+
+/**
+ * mucse_fw_get_capability - Get hw abilities from fw
+ * @hw: pointer to the HW structure
+ * @abil: pointer to the hw_abilities structure
+ *
+ * mucse_fw_get_capability tries to get hw abilities from
+ * hw.
+ *
+ * @return: 0 on success, negative on failure
+ **/
+static int mucse_fw_get_capability(struct mucse_hw *hw,
+				   struct hw_abilities *abil)
+{
+	struct mbx_fw_cmd_reply reply;
+	struct mbx_fw_cmd_req req;
+	int err;
+
+	memset(&req, 0, sizeof(req));
+	memset(&reply, 0, sizeof(reply));
+	build_phy_abalities_req(&req, &req);
+	err = mucse_fw_send_cmd_wait(hw, &req, &reply);
+	if (!err)
+		memcpy(abil, &reply.hw_abilities, sizeof(*abil));
+	return err;
+}
+
+/**
+ * mucse_mbx_get_capability - Get hw abilities from fw
+ * @hw: pointer to the HW structure
+ *
+ * mucse_mbx_get_capability tries to some capabities from
+ * hw. Many retrys will do if it is failed.
+ *
+ * @return: 0 on success, negative on failure
+ **/
+int mucse_mbx_get_capability(struct mucse_hw *hw)
+{
+	struct hw_abilities ability;
+	int try_cnt = 3;
+	int err;
+
+	memset(&ability, 0, sizeof(ability));
+	while (try_cnt--) {
+		err = mucse_fw_get_capability(hw, &ability);
+		if (err)
+			continue;
+		hw->pfvfnum = le16_to_cpu(ability.pfnum);
+		hw->fw_version = le32_to_cpu(ability.fw_version);
+		hw->axi_mhz = le32_to_cpu(ability.axi_mhz);
+		hw->bd_uid = le32_to_cpu(ability.bd_uid);
+		return 0;
+	}
+	return err;
+}
+
+/**
+ * mbx_cookie_zalloc - Alloc a cookie structure
+ * @priv_len: private length for this cookie
+ *
+ * @return: cookie structure on success
+ **/
+static struct mbx_req_cookie *mbx_cookie_zalloc(int priv_len)
+{
+	struct mbx_req_cookie *cookie;
+
+	cookie = kzalloc(struct_size(cookie, priv, priv_len), GFP_KERNEL);
+	if (cookie) {
+		cookie->timeout_jiffes = 30 * HZ;
+		cookie->magic = COOKIE_MAGIC;
+		cookie->priv_len = priv_len;
+	}
+	return cookie;
+}
+
+/**
+ * mucse_mbx_fw_post_req - Posts a mbx req to firmware and wait reply
+ * @hw: pointer to the HW structure
+ * @req: pointer to the cmd req structure
+ * @cookie: pointer to the req cookie
+ *
+ * mucse_mbx_fw_post_req posts a mbx req to firmware and wait for the
+ * reply. cookie->wait will be set in irq handler.
+ *
+ * @return: 0 on success, negative on failure
+ **/
+static int mucse_mbx_fw_post_req(struct mucse_hw *hw,
+				 struct mbx_fw_cmd_req *req,
+				 struct mbx_req_cookie *cookie)
+{
+	int len = le16_to_cpu(req->datalen) + MBX_REQ_HDR_LEN;
+	int err;
+
+	cookie->errcode = 0;
+	cookie->done = 0;
+	init_waitqueue_head(&cookie->wait);
+	err = mutex_lock_interruptible(&hw->mbx.lock);
+	if (err)
+		return err;
+	err = mucse_write_mbx(hw, (u32 *)req,
+			      L_WD(len));
+	if (err) {
+		mutex_unlock(&hw->mbx.lock);
+		return err;
+	}
+	do {
+		err = wait_event_interruptible_timeout(cookie->wait,
+						       cookie->done == 1,
+						       cookie->timeout_jiffes);
+	} while (err == -ERESTARTSYS);
+
+	mutex_unlock(&hw->mbx.lock);
+	if (!err)
+		err = -ETIME;
+	else
+		err = 0;
+	if (!err && cookie->errcode)
+		err = cookie->errcode;
+
+	return err;
+}
+
+/**
+ * mucse_mbx_ifinsmod - Echo driver insmod status to hw
+ * @hw: pointer to the HW structure
+ * @status: true for insmod, false for rmmod
+ *
+ * @return: 0 on success, negative on failure
+ **/
+int mucse_mbx_ifinsmod(struct mucse_hw *hw, int status)
+{
+	struct mbx_fw_cmd_reply reply;
+	struct mbx_fw_cmd_req req;
+	int len;
+	int err;
+
+	memset(&req, 0, sizeof(req));
+	memset(&reply, 0, sizeof(reply));
+	build_ifinsmod(&req, hw->driver_version, status);
+	len = le16_to_cpu(req.datalen) + MBX_REQ_HDR_LEN;
+	err = mutex_lock_interruptible(&hw->mbx.lock);
+	if (err)
+		return err;
+
+	if (status) {
+		err = hw->mbx.ops->write_posted(hw, (u32 *)&req,
+						L_WD(len));
+	} else {
+		err = hw->mbx.ops->write(hw, (u32 *)&req,
+					 L_WD(len));
+	}
+
+	mutex_unlock(&hw->mbx.lock);
+	return err;
+}
+
+/**
+ * mucse_mbx_fw_reset_phy - Posts a mbx req to reset hw
+ * @hw: pointer to the HW structure
+ *
+ * mucse_mbx_fw_reset_phy posts a mbx req to firmware to reset hw.
+ * It uses mucse_fw_send_cmd_wait if no irq, and mucse_mbx_fw_post_req
+ * if other irq is registered.
+ *
+ * @return: 0 on success, negative on failure
+ **/
+int mucse_mbx_fw_reset_phy(struct mucse_hw *hw)
+{
+	struct mbx_fw_cmd_reply reply;
+	struct mbx_fw_cmd_req req;
+	int ret;
+
+	memset(&req, 0, sizeof(req));
+	memset(&reply, 0, sizeof(reply));
+	if (hw->mbx.irq_enabled) {
+		struct mbx_req_cookie *cookie = mbx_cookie_zalloc(0);
+
+		if (!cookie)
+			return -ENOMEM;
+
+		build_reset_phy_req(&req, cookie);
+		ret = mucse_mbx_fw_post_req(hw, &req, cookie);
+		kfree(cookie);
+		return ret;
+	}
+
+	build_reset_phy_req(&req, &req);
+	return mucse_fw_send_cmd_wait(hw, &req, &reply);
+}
+
+/**
+ * mucse_fw_get_macaddr - Posts a mbx req to request macaddr
+ * @hw: pointer to the HW structure
+ * @pfvfnum: index of pf/vf num
+ * @mac_addr: pointer to store mac_addr
+ * @lane: lane index
+ *
+ * mucse_fw_get_macaddr posts a mbx req to firmware to get mac_addr.
+ * It uses mucse_fw_send_cmd_wait if no irq, and mucse_mbx_fw_post_req
+ * if other irq is registered.
+ *
+ * @return: 0 on success, negative on failure
+ **/
+int mucse_fw_get_macaddr(struct mucse_hw *hw, int pfvfnum,
+			 u8 *mac_addr,
+			 int lane)
+{
+	struct mbx_fw_cmd_reply reply;
+	struct mbx_fw_cmd_req req;
+	int err;
+
+	memset(&req, 0, sizeof(req));
+	memset(&reply, 0, sizeof(reply));
+	build_get_macaddress_req(&req, 1 << lane, pfvfnum, &req);
+	err = mucse_fw_send_cmd_wait(hw, &req, &reply);
+	if (err)
+		return err;
+
+	if ((1 << lane) & le32_to_cpu(reply.mac_addr.lanes))
+		memcpy(mac_addr, reply.mac_addr.addrs[lane].mac, 6);
+	else
+		return -ENODATA;
+	return 0;
+}
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
new file mode 100644
index 000000000000..2e33073bfe9b
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
@@ -0,0 +1,201 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2020 - 2025 Mucse Corporation. */
+
+#ifndef _RNPGBE_MBX_FW_H
+#define _RNPGBE_MBX_FW_H
+
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/wait.h>
+
+#include "rnpgbe.h"
+
+#define MBX_REQ_HDR_LEN 24
+#define L_WD(x) ((x) / 4)
+#define M_DEFAULT_DUMY 0xa0000000
+#define M_DUMY_MASK 0x0f000f11
+#define EVT_LINK_UP 1
+
+struct mbx_fw_cmd_reply;
+typedef void (*cookie_cb)(struct mbx_fw_cmd_reply *reply, void *priv);
+
+struct mbx_req_cookie {
+	int magic;
+#define COOKIE_MAGIC 0xCE
+	cookie_cb cb;
+	int timeout_jiffes;
+	int errcode;
+	wait_queue_head_t wait;
+	int done;
+	int priv_len;
+	char priv[];
+};
+
+enum MUCSE_FW_CMD {
+	GET_PHY_ABALITY = 0x0601,
+	GET_MAC_ADDRES = 0x0602,
+	RESET_PHY = 0x0603,
+	DRIVER_INSMOD = 0x0803,
+};
+
+struct hw_abilities {
+	u8 link_stat;
+	u8 lane_mask;
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
+		__le32 ext_ability;
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
+static inline void ability_update_host_endian(struct hw_abilities *abi)
+{
+	u32 host_val = le32_to_cpu(abi->ext_ability);
+
+	abi->e_host = *(typeof(abi->e_host) *)&host_val;
+}
+
+#define FLAGS_DD BIT(0)
+#define FLAGS_ERR BIT(2)
+
+/* Request is in little-endian format. Big-endian systems should be considered */
+struct mbx_fw_cmd_req {
+	__le16 flags;
+	__le16 opcode;
+	__le16 datalen;
+	__le16 ret_value;
+	union {
+		struct {
+			__le32 cookie_lo;
+			__le32 cookie_hi;
+		};
+
+		void *cookie;
+	};
+	__le32 reply_lo;
+	__le32 reply_hi;
+	union {
+		u8 data[32];
+		struct {
+			__le32 lane;
+			__le32 status;
+		} ifinsmod;
+		struct {
+			__le32 lane_mask;
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
+	union {
+		struct {
+			__le32 cookie_lo;
+			__le32 cookie_hi;
+		};
+		void *cookie;
+	};
+	union {
+		u8 data[40];
+		struct mac_addr {
+			__le32 lanes;
+			struct _addr {
+				/* for macaddr:01:02:03:04:05:06
+				 * mac-hi=0x01020304 mac-lo=0x05060000
+				 */
+				u8 mac[8];
+			} addrs[4];
+		} mac_addr;
+		struct hw_abilities hw_abilities;
+	};
+} __packed;
+
+static inline void build_phy_abalities_req(struct mbx_fw_cmd_req *req,
+					   void *cookie)
+{
+	req->flags = 0;
+	req->opcode = cpu_to_le16(GET_PHY_ABALITY);
+	req->datalen = 0;
+	req->reply_lo = 0;
+	req->reply_hi = 0;
+	req->cookie = cookie;
+}
+
+static inline void build_ifinsmod(struct mbx_fw_cmd_req *req,
+				  unsigned int lane,
+				  int status)
+{
+	req->flags = 0;
+	req->opcode = cpu_to_le16(DRIVER_INSMOD);
+	req->datalen = cpu_to_le16(sizeof(req->ifinsmod));
+	req->cookie = NULL;
+	req->reply_lo = 0;
+	req->reply_hi = 0;
+	req->ifinsmod.lane = cpu_to_le32(lane);
+	req->ifinsmod.status = cpu_to_le32(status);
+}
+
+static inline void build_reset_phy_req(struct mbx_fw_cmd_req *req,
+				       void *cookie)
+{
+	req->flags = 0;
+	req->opcode = cpu_to_le16(RESET_PHY);
+	req->datalen = 0;
+	req->reply_lo = 0;
+	req->reply_hi = 0;
+	req->cookie = cookie;
+}
+
+static inline void build_get_macaddress_req(struct mbx_fw_cmd_req *req,
+					    int lane_mask, int pfvfnum,
+					    void *cookie)
+{
+	req->flags = 0;
+	req->opcode = cpu_to_le16(GET_MAC_ADDRES);
+	req->datalen = cpu_to_le16(sizeof(req->get_mac_addr));
+	req->cookie = cookie;
+	req->reply_lo = 0;
+	req->reply_hi = 0;
+	req->get_mac_addr.lane_mask = cpu_to_le32(lane_mask);
+	req->get_mac_addr.pfvf_num = cpu_to_le32(pfvfnum);
+}
+
+int mucse_mbx_get_capability(struct mucse_hw *hw);
+int mucse_mbx_ifinsmod(struct mucse_hw *hw, int status);
+int mucse_mbx_fw_reset_phy(struct mucse_hw *hw);
+int mucse_fw_get_macaddr(struct mucse_hw *hw, int pfvfnum,
+			 u8 *mac_addr, int lane);
+#endif /* _RNPGBE_MBX_FW_H */
-- 
2.25.1


