Return-Path: <netdev+bounces-217138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD024B378BB
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 05:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C61177B0AFC
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 03:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A9D26E6FB;
	Wed, 27 Aug 2025 03:45:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFED28BE8;
	Wed, 27 Aug 2025 03:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756266347; cv=none; b=P3aOIOkQKQ5Pm/+Us2ObQc0RgeVziEjIwcSLFqjTJHeUD1ke6bDFlVoe1tj3S5KEWuC7GxSG2dAvSFS9WTjwxa9vtQM+kU+uWdZ8HYH507MaZCkTiXcbEOPczb2THwVMT4fnUUswl1GPDzh6LPUyDv5bJ4J3rxxZ1YkO38WwpEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756266347; c=relaxed/simple;
	bh=rsyyM33cMvBx3U4gMI5OOWjvSlpVqWRkSajMSpRF+P8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LzYYn7DROV24jeUbPZiKzPRW8z9MgFi5Ich0a8tMozrVaeWVuCh23gQz8gMZ4xkyiSF0K5QTLwZ1erreKiXZXlyiO/xG9sk6IEHcaTNwnFUBWApAz1KeO/ExWQ0a+verFU0LZ/csREMoVEFkkAJj1leLeE+fZ1sb7zkWvLbiHRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz7t1756266336tf47e2391
X-QQ-Originating-IP: Nw25xMzaI/e0y6s6j2gR0pjeh+aWmWW4c8ttWvgxqyQ=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 27 Aug 2025 11:45:33 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4493685137344332223
EX-QQ-RecipientCnt: 26
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
	gustavoars@kernel.org
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	dong100@mucse.com
Subject: [PATCH net-next v8 4/5] net: rnpgbe: Add basic mbx_fw support
Date: Wed, 27 Aug 2025 11:45:08 +0800
Message-Id: <20250827034509.501980-5-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250827034509.501980-1-dong100@mucse.com>
References: <20250827034509.501980-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OGZed1HcnW95SEq5e1VcIpmFZSx6+28l1BC6c2J2xSWYx293zDpWnp9W
	Y08RHvH4ikb9M/glg3NY9s6+rp9k6z2zObRRFrZU38YrZbVpPqoYlfdhVaUQwd1NkIGlygo
	QPlsGNtvwyI9+ZH7DKIeiZeOl6riu4WlsdRJzm7VajdFixTfZrcHBl0olqPWj7zKIVPKK/A
	y6OyixV2lTvmR8acDhKBCyeQ6tVDLeobZuRWglHuDq+LqWRCGNrKHo1Sb2CV+0V6+MJRaGd
	Ru2u8k13ajpz/6FVFyF45HbIiO0ihUc2XIIUsKqNcysTVxuAejGwW3suSWsIwbr6+LPlXOX
	RgTA78lmgFiZZA9YFQvATslH7SqiBnganIvKAjudN/t8F7LaAf/4M/tNkBMLCBj5MTZk5nM
	Ke5TYDg+/wwBKsWRWQm0qWurc1fyQIcTe0BxbfkAM1Np3Swf3O3Q3mFqML00qNg97wLhcJr
	uk6iWY2e+pnyJnc+sb4/YI6e0Il055jUGgSjoRadZrRQe3TXPav0CGounoMKXNIW2z9UcG5
	9ly7lWBZZRLXg8I53b2+BtH2SWdEfQaPeO3lvLWJgo1hwxekOksYMqqPGNM3/dxTsf/o5pS
	KdteQvJ9A83IztPsNDsknxnQY1R69zVhJ3+dob0ve+ZBHwGk08HsFAu4SYva0Vy4q4tBZD6
	c+YokoJ6kbnZWBD5GLuhG97rcZ9LuGXOqHNBRxMAND8/Bqv05nrEhixcI1QOB1xAQ5UJ2XQ
	TZA/qfPfA2hlxeczr+XBYfJu8MMdvnEDy9n8lvD0x0aO861ZRkdK806pdIi/TZDAQu4ZOcX
	yp8fpDNH9Bqz3D6bnFuKb5/ry7e92OBf6Bv+3EWaSTmdfUlbikZxTw4kswXJQLmUWCt//i0
	YvXDSIDzbpJ0T3H33eSTgLs+kkGq9OFQoss0KvcFBzrTK4BnhpcHiGDO7dGeNkbODgLJlLe
	fYH3bn4xm5o7uZigvTwLTeFQPbfHCYEJOs5fcBYnE2g9OvblHOxDE+ReHaFxHDTXJHbFf+M
	LqtrayqwioeXP/6SM89tKp/p3TesUtxHS2/vCC8AdOoYv26kGqpmuNv7PsvI4w0m2v52hxs
	j8OAzn4epNePx2owoxVyfDgasBNZG/Zug==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

Initialize basic mbx_fw ops, such as get_capability, reset phy
and so on.

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/Makefile    |   3 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |   1 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c | 253 ++++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h | 126 +++++++++
 4 files changed, 382 insertions(+), 1 deletion(-)
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
index 000000000000..d3b323760708
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
@@ -0,0 +1,253 @@
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
+ * @return: 0 on success, negative on failure
+ **/
+static int mucse_fw_send_cmd_wait(struct mucse_hw *hw,
+				  struct mbx_fw_cmd_req *req,
+				  struct mbx_fw_cmd_reply *reply)
+{
+	int len = le16_to_cpu(req->datalen);
+	int retry_cnt = 3;
+	int err;
+
+	err = mutex_lock_interruptible(&hw->mbx.lock);
+	if (err)
+		return err;
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
+	return err;
+}
+
+/**
+ * build_phy_abilities_req - build req with get_phy_ability opcode
+ * @req: pointer to the cmd req structure
+ **/
+static void build_phy_abilities_req(struct mbx_fw_cmd_req *req)
+{
+	req->flags = 0;
+	req->opcode = cpu_to_le16(GET_PHY_ABILITY);
+	req->datalen = cpu_to_le16(MBX_REQ_HDR_LEN);
+	req->reply_lo = 0;
+	req->reply_hi = 0;
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
+	struct mbx_fw_cmd_reply reply = {};
+	struct mbx_fw_cmd_req req = {};
+	int err;
+
+	build_phy_abilities_req(&req);
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
+ * mucse_mbx_get_capability tries to get capabities from
+ * hw. Many retrys will do if it is failed.
+ *
+ * @return: 0 on success, negative on failure
+ **/
+int mucse_mbx_get_capability(struct mucse_hw *hw)
+{
+	struct hw_abilities ability = {};
+	int try_cnt = 3;
+	int err;
+	/* It is called once in probe, if failed nothing
+	 * (register network) todo. Try more times to get driver
+	 * and firmware in sync.
+	 */
+	do {
+		err = mucse_fw_get_capability(hw, &ability);
+		if (err)
+			continue;
+		break;
+	} while (try_cnt--);
+
+	if (!err)
+		hw->pfvfnum = le16_to_cpu(ability.pfnum) & GENMASK_U16(7, 0);
+	return err;
+}
+
+/**
+ * build_ifinsmod - build req with insmod opcode
+ * @req: pointer to the cmd req structure
+ * @is_insmod: true for insmod, false for rmmod
+ **/
+static void build_ifinsmod(struct mbx_fw_cmd_req *req,
+			   bool is_insmod)
+{
+	req->flags = 0;
+	req->opcode = cpu_to_le16(DRIVER_INSMOD);
+	req->datalen = cpu_to_le16(sizeof(req->ifinsmod) +
+				   MBX_REQ_HDR_LEN);
+	req->reply_lo = 0;
+	req->reply_hi = 0;
+#define FIXED_VERSION 0xFFFFFFFF
+	req->ifinsmod.version = cpu_to_le32(FIXED_VERSION);
+	if (is_insmod)
+		req->ifinsmod.status = cpu_to_le32(1);
+	else
+		req->ifinsmod.status = cpu_to_le32(0);
+}
+
+/**
+ * mucse_mbx_ifinsmod - Echo driver insmod status to hw
+ * @hw: pointer to the HW structure
+ * @is_insmod: true for insmod, false for rmmod
+ *
+ * @return: 0 on success, negative on failure
+ **/
+int mucse_mbx_ifinsmod(struct mucse_hw *hw, bool is_insmod)
+{
+	struct mbx_fw_cmd_req req = {};
+	int len;
+	int err;
+
+	build_ifinsmod(&req, is_insmod);
+	len = le16_to_cpu(req.datalen);
+	err = mutex_lock_interruptible(&hw->mbx.lock);
+	if (err)
+		return err;
+
+	if (is_insmod) {
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
+ * build_reset_phy_req - build req with reset_phy opcode
+ * @req: pointer to the cmd req structure
+ **/
+static void build_reset_phy_req(struct mbx_fw_cmd_req *req)
+{
+	req->flags = 0;
+	req->opcode = cpu_to_le16(RESET_PHY);
+	req->datalen = cpu_to_le16(MBX_REQ_HDR_LEN);
+	req->reply_lo = 0;
+	req->reply_hi = 0;
+}
+
+/**
+ * mucse_mbx_fw_reset_phy - Posts a mbx req to reset hw
+ * @hw: pointer to the HW structure
+ *
+ * mucse_mbx_fw_reset_phy posts a mbx req to firmware to reset hw.
+ *
+ * @return: 0 on success, negative on failure
+ **/
+int mucse_mbx_fw_reset_phy(struct mucse_hw *hw)
+{
+	struct mbx_fw_cmd_reply reply = {};
+	struct mbx_fw_cmd_req req = {};
+
+	build_reset_phy_req(&req);
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
+	req->opcode = cpu_to_le16(GET_MAC_ADDRES);
+	req->datalen = cpu_to_le16(sizeof(req->get_mac_addr) +
+				   MBX_REQ_HDR_LEN);
+	req->reply_lo = 0;
+	req->reply_hi = 0;
+	req->get_mac_addr.port_mask = cpu_to_le32(port_mask);
+	req->get_mac_addr.pfvf_num = cpu_to_le32(pfvfnum);
+}
+
+/**
+ * mucse_fw_get_macaddr - Posts a mbx req to request macaddr
+ * @hw: pointer to the HW structure
+ * @pfvfnum: index of pf/vf num
+ * @mac_addr: pointer to store mac_addr
+ * @port: port index
+ *
+ * mucse_fw_get_macaddr posts a mbx req to firmware to get mac_addr.
+ *
+ * @return: 0 on success, negative on failure
+ **/
+int mucse_fw_get_macaddr(struct mucse_hw *hw, int pfvfnum,
+			 u8 *mac_addr,
+			 int port)
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
index 000000000000..3efd23ba1aa0
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
+	GET_PHY_ABILITY = 0x0601,
+	GET_MAC_ADDRES = 0x0602,
+	RESET_PHY = 0x0603,
+	DRIVER_INSMOD = 0x0803,
+};
+
+struct hw_abilities {
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
+/* FW stores extended ability information in 'ext_ability' as a 32-bit
+ * little-endian value. To make these flags easily accessible in the
+ * kernel (via named 'bitfields' instead of raw bitmask operations),
+ * we use the union's 'e_host' struct, which provides named bits
+ * (e.g., 'wol_en', 'smbus_en')
+ */
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
+		} ifinsmod;
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
+		struct hw_abilities hw_abilities;
+	};
+} __packed;
+
+int mucse_mbx_get_capability(struct mucse_hw *hw);
+int mucse_mbx_ifinsmod(struct mucse_hw *hw, bool status);
+int mucse_mbx_fw_reset_phy(struct mucse_hw *hw);
+int mucse_fw_get_macaddr(struct mucse_hw *hw, int pfvfnum,
+			 u8 *mac_addr, int port);
+#endif /* _RNPGBE_MBX_FW_H */
-- 
2.25.1


