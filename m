Return-Path: <netdev+bounces-219413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB28B4129E
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 04:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EECF1B286CA
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 02:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7A622DFB5;
	Wed,  3 Sep 2025 02:55:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1404F221F1F;
	Wed,  3 Sep 2025 02:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756868130; cv=none; b=iUo/NXzdBYgCHaQ4q+oXKekRk3acooMKoiiPI4ioLZSdS+UgQRx30nM4h+X5ZPdVn9AQ6QlqjrVEDYODi7+lSJqL3NSySU0MQ5aXrf8SjJDTDw19NTlyuIBaTIM0LXMNs2b9me/w2a6o+b972NG7QMQYgpel09uWXBNhtL5RF0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756868130; c=relaxed/simple;
	bh=5LGuZGxVKskEe5DqUywZbiWg1ADjSLJ7u/dqeIk1baI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LWrxOz1/6Gfr3M27P7jxz5xt8WVQQDWjNm7bOhs0CRpfPGaFxYHsXcHP8XLUsyg6CIdRx6MJ3gqsEQvTNipdFO+lM0/5No5VaLzpLfuwZK/wWp8+D1vZFi4R8POUpEsTvSL8LHwPRTXowxCrb+OldcTyvzP2jE6AMWBHGGU1xN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz11t1756868095t28bdc190
X-QQ-Originating-IP: IFGt7nmtSSzO71zw5zmQ/zGFc+QnLjsa6jv+M5GIkcs=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 03 Sep 2025 10:54:52 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6000544590696539859
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
Subject: [PATCH net-next v10 4/5] net: rnpgbe: Add basic mbx_fw support
Date: Wed,  3 Sep 2025 10:54:29 +0800
Message-Id: <20250903025430.864836-5-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250903025430.864836-1-dong100@mucse.com>
References: <20250903025430.864836-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NkLA2q2LD229wshJrtN9PYJ1yPuxDSKIY5UlCC7x0FD2JD1tE6KMfoYI
	8dAySSDX0jvkQPROMguPaTra7Fr4AbKIZtYI0ZTvSI5Hmo6gaJScU08AFWuHTzGkjBXBAgM
	As8E1hDz4lLiR8DJAIM/tCe87LUg6xwmtjQkK0rGWvqibD2HLqnInNXrJPRq5MlLG5wGcg6
	UoBKHE8SPtg3DQsz9kwf0pothRM1UZ4ZPHWrNkxLmjmTPUMA8px0iUAPKFprcCowH8fDQOz
	vRHZfsyJ/u4spFgqNQ0qwfDH8qjfg13q2xaES902p7z8ZlTLy+l+ahAuEr2Y++xITsHXOct
	5EZ1HYqdAo/CXj1alZefXSxD5V7EftYiKs5IRF76RS3sigypPfBcm5nVH+OMqh8/Y/vYNzv
	k/796Sv5sglxIjzO0MCq0b6kEjYPlVSaE22+E5kIMgAWD5b1V0DX4MPgeJ2dMVEu39gG41R
	UUs+15ms9j93aqw9znKNaqwBPNlBSmrCmiNf4u484GkwIvmfLHUOILua9HfruXLeZbJXJf3
	I0K3UusnwKD/irqxlvAeQL1tX0TZ5yqE8b0NixpKmkFP2TFqkCY1ReGhyXGZMg2VvhEtMiC
	qYA2DOh3YZUu92u0HeBvKpju5+w6M3sP72Gp83MI5DWLFaQqJ8Yb4FvBQPhQjucLwVff0Zt
	Cjk3+wodU+JUQrcaxeUR2a4sXxPVMgZQV0p7FjblJ1K8DwdWLm1agKsmcEKvVRYb8zN/Jwf
	r3l2t3x2bkCjPVABc3NaNNwoKp65/ZNgrkMc3wT4iaT8KWht3U4HGdqjTXVkCBuxOO1mCo0
	qmPOgSNAMLDT7r2I5lGOPUrg2J2eioR/zh/99vtOzXcDfL0NJBloT1bZuWJH2PvuAtK/9bd
	CfqFkxggnTDGGdc2hA47U57NmHAZ3GhnIhnyJCK5qOsR1hiIpFlUtnxD+XB8IgDYBfozz5A
	q1802uss/ZlTSa8cjx7dfhHKrfc4eAA8lmHSw2AVSt1CHzj3uRKHQppUudOukN4C4L33icI
	S+JNJoHxZ5A2cYaaUo
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

Initialize basic mbx_fw ops, such as get_capability, reset phy
and so on.

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/Makefile    |   3 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |   1 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c | 250 ++++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h | 126 +++++++++
 4 files changed, 379 insertions(+), 1 deletion(-)
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
index 7999bb99306b..4d2cca59fb23 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -51,6 +51,7 @@ struct mucse_hw {
 	void __iomem *hw_addr;
 	struct pci_dev *pdev;
 	enum rnpgbe_hw_type hw_type;
+	u8 pfvfnum;
 	struct mucse_mbx_info mbx;
 };
 
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
new file mode 100644
index 000000000000..30612c577c99
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
@@ -0,0 +1,250 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2020 - 2025 Mucse Corporation. */
+
+#include <linux/pci.h>
+#include <linux/if_ether.h>
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
+ * Return: 0 on success, negative errno on failure
+ **/
+static int mucse_fw_send_cmd_wait(struct mucse_hw *hw,
+				  struct mbx_fw_cmd_req *req,
+				  struct mbx_fw_cmd_reply *reply)
+{
+	int len = le16_to_cpu(req->datalen);
+	int retry_cnt = 3;
+	int err;
+
+	mutex_lock(&hw->mbx.lock);
+	err = mucse_write_posted_mbx(hw, (u32 *)req, len);
+	if (err)
+		goto out;
+	do {
+		err = mucse_read_posted_mbx(hw, (u32 *)reply,
+					    sizeof(*reply));
+		if (err)
+			goto out;
+		/* mucse_write_posted_mbx return 0 means fw has
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
+	req->datalen = cpu_to_le16(MBX_REQ_HDR_LEN);
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
+	struct hw_info info = {};
+	int err;
+
+	build_get_hw_info_req(&req);
+	err = mucse_fw_send_cmd_wait(hw, &req, &reply);
+	if (!err) {
+		memcpy(&info, &reply.hw_info, sizeof(struct hw_info));
+		hw->pfvfnum = le16_to_cpu(info.pfnum) & GENMASK_U16(7, 0);
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
+				   MBX_REQ_HDR_LEN);
+	req->reply_lo = 0;
+	req->reply_hi = 0;
+#define FIXED_VERSION 0xFFFFFFFF
+	req->powerup.version = cpu_to_le32(FIXED_VERSION);
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
+
+	if (is_powerup) {
+		err = mucse_write_posted_mbx(hw, (u32 *)&req,
+					     len);
+	} else {
+		err = mucse_write_mbx_pf(hw, (u32 *)&req,
+					 len);
+	}
+
+	mutex_unlock(&hw->mbx.lock);
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
+	req->datalen = cpu_to_le16(MBX_REQ_HDR_LEN);
+	req->reply_lo = 0;
+	req->reply_hi = 0;
+}
+
+/**
+ * mucse_mbx_reset_hw - Posts a mbx req to reset hw
+ * @hw: pointer to the HW structure
+ *
+ * mucse_mbx_reset_hw posts a mbx req to firmware to reset hw.
+ *
+ * Return: 0 on success, negative errno on failure
+ **/
+int mucse_mbx_reset_hw(struct mucse_hw *hw)
+{
+	struct mbx_fw_cmd_reply reply = {};
+	struct mbx_fw_cmd_req req = {};
+
+	build_reset_hw_req(&req);
+	return mucse_fw_send_cmd_wait(hw, &req, &reply);
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
+				   MBX_REQ_HDR_LEN);
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
+	err = mucse_fw_send_cmd_wait(hw, &req, &reply);
+	if (err)
+		return err;
+	if (le32_to_cpu(reply.mac_addr.ports) & BIT(port))
+		memcpy(mac_addr, reply.mac_addr.addrs[port].mac, ETH_ALEN);
+	else
+		return -ENODATA;
+	return 0;
+}
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
new file mode 100644
index 000000000000..d2dcad82f775
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
@@ -0,0 +1,126 @@
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
+
+enum MUCSE_FW_CMD {
+	GET_HW_INFO = 0x0601,
+	GET_MAC_ADDRESS = 0x0602,
+	RESET_HW = 0x0603,
+	POWER_UP = 0x0803,
+};
+
+struct hw_info {
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
+static inline void info_update_host_endian(struct hw_info *info)
+{
+	u32 host_val = le32_to_cpu(info->ext_info);
+
+	info->e_host = *(typeof(info->e_host) *)&host_val;
+}
+
+#define FLAGS_DD BIT(0)
+#define FLAGS_ERR BIT(2)
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
+		struct hw_info hw_info;
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


