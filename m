Return-Path: <netdev+bounces-203574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9B9AF6766
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 03:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31C497B5F8D
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 01:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C9D1D9694;
	Thu,  3 Jul 2025 01:51:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BA1372;
	Thu,  3 Jul 2025 01:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751507468; cv=none; b=iZSz3lY2y7gBLCjKZPXTcZBK5yqdZR8ngyL60AsUHE0+ZKPTga6MJ/Cj5f6NVUI/IaZKpHn5QQj2VfqZ5UovpV/UQuuyGV/JKAb6Rkcw3aRO4c3zzX9PEnYuKtBN8PV8cI+jepCpeatc/roD8+Rr3Vejp6wZHU5UuWeiJ6bZC/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751507468; c=relaxed/simple;
	bh=+FuXJwO2gVvDCxf9FsIgdSTN9qW1omMF2pI9Vn3CV+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=keepBLPjxjMx599tvQ+hmkPy83Ot3WK5QZh/piqxITjA4ivR6rp1ph4LM5wqibhPmQIQIVu/CyTPKJ97oLbV5X/INeRtbWvH+6jZA5bEXteEUaaZZcWHctyJnr5rHkX17YPrRXHajlonIaxL0tr6DCuXE6zFd1XRStP01y9zxtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz8t1751507375t4f3b0fbd
X-QQ-Originating-IP: 8BsPzddpkEccYH8mZsA/G+DyULy2beM/J8NvWAM62Zc=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 03 Jul 2025 09:49:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16203619772304485558
EX-QQ-RecipientCnt: 22
From: Dong Yibo <dong100@mucse.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	andrew+netdev@lunn.ch,
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
	alexanderduyck@fb.com
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dong100@mucse.com
Subject: [PATCH 04/15] net: rnpgbe: Add get_capability mbx_fw ops support
Date: Thu,  3 Jul 2025 09:48:48 +0800
Message-Id: <20250703014859.210110-5-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250703014859.210110-1-dong100@mucse.com>
References: <20250703014859.210110-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MHAMmLg4tmnVK7zscIPptvxXL+Xq9dN6j6UOs7k92mIwyxKcBFDy9DUz
	nOi/g2wudijUNA5u1dU2k6n9jlkSLPRDTaP3n+iARXWLGKumPtrMnGZDkNJy1FjwAtnnfrQ
	hjSaqQCt8CUxpdJwQYcy2uvVuPHFpA/LnvBa7BYoNVczp5HIVEea+3+pN2TnZub5HY/CHcN
	jZBKvTPCCIZF4axRoMndd/uKG9tY5lf+oEcPbwE1dhH9Nx878nfCMvD7+5L53FHe0gkVTX6
	xShw+8rJVdDqK7WA+vA3OyDwaxwZvs2TEkvKNSraWWKwijePsVOqXFCgMJBXzMYZJlxthpS
	+pb0Z/wsMA58HHNOe9YTfcFK/p99Oh8y3x466FHcr8SgtAv3OOY4gQ0MDm11WoSkviXTIiV
	wwhngzHuRPRE+jbwxYk+xB20lBZxMHfAqYNIB5JejPxMhlfyfZwuLW8gshvi/5VanZ9INUr
	GlRwJAtdZzihFOOHyHJNvAVHg9e4Ve6Sj7RVqOuDXK5Yv6dP1udhX4azir+YNDcs1fusNk5
	Furr1NkKeBq6/wwmw3BGYqgza5JjYg30CbymmoXSbwPPsf6XK9XvTQ4caJxE/qC28qqa881
	mx313Os3MV23THp/gxL3nwMYQXDb1Rk0gQ5yQCWtAaOvJVdfrTV9wYaYcOtkFOn4rOfswjB
	YcPcF1tPo119Tp7niBE9FwF3P3K8xTSWY+Nk8hbnVFTwkX86ch7Lalw8+azw2lusGJB+sLM
	FXsSIWecj/aqG/khuPCrVc1X4mr3OWf31ZpWTdPpQG+rk4kkvVS426HE0bV3iSGm1mNvO2t
	5fwxf6KfPGfgEl79AYush6zZr5kg8dAy5FlaOY4vD/C3H2LtNokk7Oa5ROtQ3EHPAtRbTGQ
	reYjfi3+kuWjBduG+vNowdnrJgzZDgX17lyDjbf79XXKxyMqlg3RS/NGawTtlTdZPQGB+VR
	G85IS3uk1dgY2UcKcS5Lynl+ZsVnKzpP+cv9v0EM/0PWp2wdtMhwyL9rC5maAMFXPy+2o+y
	ZFpPurccFn2d+mMe4PSZMMnpHuAIg=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

Initialize get hw capability from mbx_fw ops.

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/Makefile    |   3 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |   8 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |   8 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |   3 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c | 141 +++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h | 530 ++++++++++++++++++
 6 files changed, 691 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h

diff --git a/drivers/net/ethernet/mucse/rnpgbe/Makefile b/drivers/net/ethernet/mucse/rnpgbe/Makefile
index 41177103b50c..fd455cb111a9 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/Makefile
+++ b/drivers/net/ethernet/mucse/rnpgbe/Makefile
@@ -7,4 +7,5 @@
 obj-$(CONFIG_MGBE) += rnpgbe.o
 rnpgbe-objs := rnpgbe_main.o \
 	       rnpgbe_chip.o \
-	       rnpgbe_mbx.o
+	       rnpgbe_mbx.o \
+	       rnpgbe_mbx_fw.o
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
index 4cafab16f5bf..fd1610318c75 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -155,6 +155,14 @@ struct mucse_hw {
 	u16 vendor_id;
 	u16 subsystem_device_id;
 	u16 subsystem_vendor_id;
+	u32 wol;
+	u32 wol_en;
+	u32 fw_version;
+	u32 axi_mhz;
+	u32 bd_uid;
+	int ncsi_en;
+	int force_en;
+	int force_cap;
 	int max_vfs;
 	int max_vfs_noari;
 	enum rnpgbe_hw_type hw_type;
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
index e125b609ba09..b701b42b7c42 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
@@ -9,6 +9,7 @@
 #include <linux/etherdevice.h>
 
 #include "rnpgbe.h"
+#include "rnpgbe_mbx_fw.h"
 
 char rnpgbe_driver_name[] = "rnpgbe";
 static const char rnpgbe_driver_string[] =
@@ -137,6 +138,13 @@ static int rnpgbe_add_adpater(struct pci_dev *pdev,
 	ii->get_invariants(hw);
 	hw->mbx.ops.init_params(hw);
 
+	if (mucse_mbx_get_capability(hw)) {
+		dev_err(&pdev->dev,
+			"mucse_mbx_get_capability failed!\n");
+		err = -EIO;
+		goto err_free_net;
+	}
+
 	return 0;
 
 err_free_net:
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
index 05231c76718e..2040b86f4cad 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright(c) 2020 - 2025 Mucse Corporation. */
+/* Copyright(c) 2022 - 2025 Mucse Corporation. */
 
 #ifndef _RNPGBE_MBX_H
 #define _RNPGBE_MBX_H
@@ -36,6 +36,7 @@ static inline u32 PF_VF_SHM(struct mucse_mbx_info *mbx, int vf)
 #define MBOX_IRQ_DISABLE 1
 #define mbx_rd32(hw, reg) rnpgbe_rd_reg((hw)->hw_addr + (reg))
 #define mbx_wr32(hw, reg, val) rnpgbe_wr_reg((hw)->hw_addr + (reg), (val))
+#define hw_wr32(hw, reg, val) rnpgbe_wr_reg((hw)->hw_addr + (reg), (val))
 
 extern struct mucse_mbx_operations mucse_mbx_ops_generic;
 
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
new file mode 100644
index 000000000000..7fdfccdba80b
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2020 - 2025 Mucse Corporation. */
+
+#include <linux/pci.h>
+
+#include "rnpgbe_mbx_fw.h"
+
+/**
+ * mucse_fw_send_cmd_wait - Send cmd req and wait for response
+ * @hw: Pointer to the HW structure
+ * @req: Pointer to the cmd req structure
+ * @reply: Pointer to the fw reply structure
+ *
+ * mucse_fw_send_cmd_wait sends req to pf-cm3 mailbox and wait
+ * reply from fw.
+ *
+ * Returns 0 on success, negative on failure
+ **/
+static int mucse_fw_send_cmd_wait(struct mucse_hw *hw,
+				  struct mbx_fw_cmd_req *req,
+				  struct mbx_fw_cmd_reply *reply)
+{
+	int err;
+	int retry_cnt = 3;
+
+	if (!hw || !req || !reply || !hw->mbx.ops.read_posted)
+		return -EINVAL;
+
+	/* if pcie off, nothing todo */
+	if (pci_channel_offline(hw->pdev))
+		return -EIO;
+
+	if (mutex_lock_interruptible(&hw->mbx.lock))
+		return -EAGAIN;
+
+	err = hw->mbx.ops.write_posted(hw, (u32 *)req,
+				       L_WD(req->datalen + MBX_REQ_HDR_LEN),
+				       MBX_FW);
+	if (err) {
+		mutex_unlock(&hw->mbx.lock);
+		return err;
+	}
+
+retry:
+	retry_cnt--;
+	if (retry_cnt < 0)
+		return -EIO;
+
+	err = hw->mbx.ops.read_posted(hw, (u32 *)reply,
+				      L_WD(sizeof(*reply)),
+				      MBX_FW);
+	if (err) {
+		mutex_unlock(&hw->mbx.lock);
+		return err;
+	}
+
+	if (reply->opcode != req->opcode)
+		goto retry;
+
+	mutex_unlock(&hw->mbx.lock);
+
+	if (reply->error_code)
+		return -reply->error_code;
+
+	return 0;
+}
+
+/**
+ * mucse_fw_get_capablity - Get hw abilities from fw
+ * @hw: Pointer to the HW structure
+ * @abil: Pointer to the hw_abilities structure
+ *
+ * mucse_fw_get_capablity tries to get hw abilities from
+ * hw.
+ *
+ * Returns 0 on success, negative on failure
+ **/
+static int mucse_fw_get_capablity(struct mucse_hw *hw,
+				  struct hw_abilities *abil)
+{
+	int err = 0;
+	struct mbx_fw_cmd_req req;
+	struct mbx_fw_cmd_reply reply;
+
+	memset(&req, 0, sizeof(req));
+	memset(&reply, 0, sizeof(reply));
+	build_phy_abalities_req(&req, &req);
+	err = mucse_fw_send_cmd_wait(hw, &req, &reply);
+	if (err == 0)
+		memcpy(abil, &reply.hw_abilities, sizeof(*abil));
+
+	return err;
+}
+
+/**
+ * mucse_mbx_get_capability - Get hw abilities from fw
+ * @hw: Pointer to the HW structure
+ *
+ * mucse_mbx_get_capability tries to some capabities from
+ * hw. Many retrys will do if it is failed.
+ *
+ * Returns 0 on success, negative on failure
+ **/
+int mucse_mbx_get_capability(struct mucse_hw *hw)
+{
+	int err = 0;
+	struct hw_abilities ablity;
+	int try_cnt = 3;
+
+	memset(&ablity, 0, sizeof(ablity));
+
+	while (try_cnt--) {
+		err = mucse_fw_get_capablity(hw, &ablity);
+		if (err == 0) {
+			hw->ncsi_en = (ablity.nic_mode & 0x4) ? 1 : 0;
+			hw->pfvfnum = ablity.pfnum;
+			hw->fw_version = ablity.fw_version;
+			hw->axi_mhz = ablity.axi_mhz;
+			hw->bd_uid = ablity.bd_uid;
+
+			if (hw->fw_version >= 0x0001012C) {
+				/* this version can get wol_en from hw */
+				hw->wol = ablity.wol_status & 0xff;
+				hw->wol_en = ablity.wol_status & 0x100;
+			} else {
+				/* other version only pf0 or ncsi can wol */
+				hw->wol = ablity.wol_status & 0xff;
+				if (hw->ncsi_en || !ablity.pfnum)
+					hw->wol_en = 1;
+			}
+			/* 0.1.5.0 can get force status from fw */
+			if (hw->fw_version >= 0x00010500) {
+				hw->force_en = ablity.e.force_down_en;
+				hw->force_cap = 1;
+			}
+			return 0;
+		}
+	}
+
+	return -EIO;
+}
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
new file mode 100644
index 000000000000..c5f2c3ff4068
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
@@ -0,0 +1,530 @@
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
+	char priv[64];
+};
+
+enum MUCSE_FW_CMD {
+	GET_VERSION = 0x0001,
+	READ_REG = 0xFF03,
+	WRITE_REG = 0xFF04,
+	MODIFY_REG = 0xFF07,
+	IFUP_DOWN = 0x0800,
+	SEND_TO_PF = 0x0801,
+	SEND_TO_VF = 0x0802,
+	DRIVER_INSMOD = 0x0803,
+	SYSTEM_SUSPUSE = 0x0804,
+	SYSTEM_FORCE = 0x0805,
+	GET_PHY_ABALITY = 0x0601,
+	GET_MAC_ADDRES = 0x0602,
+	RESET_PHY = 0x0603,
+	LED_SET = 0x0604,
+	GET_LINK_STATUS = 0x0607,
+	LINK_STATUS_EVENT = 0x0608,
+	SET_LANE_FUN = 0x0609,
+	GET_LANE_STATUS = 0x0610,
+	SFP_SPEED_CHANGED_EVENT = 0x0611,
+	SET_EVENT_MASK = 0x0613,
+	SET_LOOPBACK_MODE = 0x0618,
+	SET_PHY_REG = 0x0628,
+	GET_PHY_REG = 0x0629,
+	PHY_LINK_SET = 0x0630,
+	GET_PHY_STATISTICS = 0x0631,
+	PHY_PAUSE_SET = 0x0632,
+	PHY_PAUSE_GET = 0x0633,
+	PHY_EEE_SET = 0x0636,
+	PHY_EEE_GET = 0x0637,
+	SFP_MODULE_READ = 0x0900,
+	SFP_MODULE_WRITE = 0x0901,
+	FW_UPDATE = 0x0700,
+	FW_MAINTAIN = 0x0701,
+	FW_UPDATE_GBE = 0x0702,
+	WOL_EN = 0x0910,
+	GET_DUMP = 0x0a00,
+	SET_DUMP = 0x0a10,
+	GET_TEMP = 0x0a11,
+	SET_WOL = 0x0a12,
+	SET_TEST_MODE = 0x0a13,
+	SHOW_TX_STAMP = 0x0a14,
+	LLDP_TX_CTRL = 0x0a15,
+};
+
+struct hw_abilities {
+	u8 link_stat;
+	u8 lane_mask;
+	int speed;
+	u16 phy_type;
+	u16 nic_mode;
+	u16 pfnum;
+	u32 fw_version;
+	u32 axi_mhz;
+	union {
+		u8 port_id[4];
+		u32 port_ids;
+	};
+	u32 bd_uid;
+	int phy_id;
+	int wol_status;
+	union {
+		int ext_ablity;
+		struct {
+			u32 valid : 1; /* 0 */
+			u32 wol_en : 1; /* 1 */
+			u32 pci_preset_runtime_en : 1; /* 2 */
+			u32 smbus_en : 1; /* 3 */
+			u32 ncsi_en : 1; /* 4 */
+			u32 rpu_en : 1; /* 5 */
+			u32 v2 : 1; /* 6 */
+			u32 pxe_en : 1; /* 7 */
+			u32 mctp_en : 1; /* 8 */
+			u32 yt8614 : 1; /* 9 */
+			u32 pci_ext_reset : 1; /* 10 */
+			u32 rpu_availble : 1; /* 11 */
+			u32 fw_lldp_ablity : 1; /* 12 */
+			u32 lldp_enabled : 1; /* 13 */
+			u32 only_1g : 1; /* 14 */
+			u32 force_down_en: 1;
+		} e;
+	};
+} __packed;
+
+struct phy_pause_data {
+	u32 pause_mode;
+};
+
+struct lane_stat_data {
+	u8 nr_lane;
+	u8 pci_gen : 4;
+	u8 pci_lanes : 4;
+	u8 pma_type;
+	u8 phy_type;
+	u16 linkup : 1;
+	u16 duplex : 1;
+	u16 autoneg : 1;
+	u16 fec : 1;
+	u16 an : 1;
+	u16 link_traing : 1;
+	u16 media_availble : 1;
+	u16 is_sgmii : 1;
+	u16 link_fault : 4;
+#define LINK_LINK_FAULT BIT(0)
+#define LINK_TX_FAULT BIT(1)
+#define LINK_RX_FAULT BIT(2)
+#define LINK_REMOTE_FAULT BIT(3)
+	u16 is_backplane : 1;
+	u16 tp_mdx : 2;
+	union {
+		u8 phy_addr;
+		struct {
+			u8 mod_abs : 1;
+			u8 fault : 1;
+			u8 tx_dis : 1;
+			u8 los : 1;
+		} sfp;
+	};
+	u8 sfp_connector;
+	u32 speed;
+	u32 si_main;
+	u32 si_pre;
+	u32 si_post;
+	u32 si_tx_boost;
+	u32 supported_link;
+	u32 phy_id;
+	u32 advertised_link;
+} __packed;
+
+struct yt_phy_statistics {
+	u32 pkg_ib_valid; /* rx crc good and length 64-1518 */
+	u32 pkg_ib_os_good; /* rx crc good and length >1518 */
+	u32 pkg_ib_us_good; /* rx crc good and length <64 */
+	u16 pkg_ib_err; /* rx crc wrong and length 64-1518 */
+	u16 pkg_ib_os_bad; /* rx crc wrong and length >1518 */
+	u16 pkg_ib_frag; /* rx crc wrong and length <64 */
+	u16 pkg_ib_nosfd; /* rx sfd missed */
+	u32 pkg_ob_valid; /* tx crc good and length 64-1518 */
+	u32 pkg_ob_os_good; /* tx crc good and length >1518 */
+	u32 pkg_ob_us_good; /* tx crc good and length <64 */
+	u16 pkg_ob_err; /* tx crc wrong and length 64-1518 */
+	u16 pkg_ob_os_bad; /* tx crc wrong and length >1518 */
+	u16 pkg_ob_frag; /* tx crc wrong and length <64 */
+	u16 pkg_ob_nosfd; /* tx sfd missed */
+} __packed;
+
+struct phy_statistics {
+	union {
+		struct yt_phy_statistics yt;
+	};
+} __packed;
+
+struct port_stat {
+	u8 phyid;
+	u8 duplex : 1;
+	u8 autoneg : 1;
+	u8 fec : 1;
+	u16 speed;
+	u16 pause : 4;
+	u16 local_eee : 3;
+	u16 partner_eee : 3;
+	u16 tp_mdx : 2;
+	u16 lldp_status : 1;
+	u16 revs : 3;
+} __packed;
+
+#define FLAGS_DD BIT(0) /* driver clear 0, FW must set 1 */
+/* driver clear 0, FW must set only if it reporting an error */
+#define FLAGS_ERR BIT(2)
+
+/* req is little endian. bigendian should be conserened */
+struct mbx_fw_cmd_req {
+	u16 flags; /* 0-1 */
+	u16 opcode; /* 2-3 enum GENERIC_CMD */
+	u16 datalen; /* 4-5 */
+	u16 ret_value; /* 6-7 */
+	union {
+		struct {
+			u32 cookie_lo; /* 8-11 */
+			u32 cookie_hi; /* 12-15 */
+		};
+
+		void *cookie;
+	};
+	u32 reply_lo; /* 16-19 5dw */
+	u32 reply_hi; /* 20-23 */
+	union {
+		u8 data[32];
+		struct {
+			u32 addr;
+			u32 bytes;
+		} r_reg;
+
+		struct {
+			u32 addr;
+			u32 bytes;
+			u32 data[4];
+		} w_reg;
+
+		struct {
+			u32 lanes;
+		} ptp;
+
+		struct {
+			u32 lane;
+			u32 up;
+		} ifup;
+
+		struct {
+			u32 sec;
+			u32 nanosec;
+
+		} tstamps;
+
+		struct {
+			u32 lane;
+			u32 status;
+		} ifinsmod;
+
+		struct {
+			u32 lane;
+			u32 status;
+		} ifforce;
+
+		struct {
+			u32 lane;
+			u32 status;
+		} ifsuspuse;
+
+		struct {
+			int nr_lane;
+		} get_lane_st;
+
+		struct {
+			int nr_lane;
+			u32 func;
+#define LANE_FUN_AN 0
+#define LANE_FUN_LINK_TRAING 1
+#define LANE_FUN_FEC 2
+#define LANE_FUN_SI 3
+#define LANE_FUN_SFP_TX_DISABLE 4
+#define LANE_FUN_PCI_LANE 5
+#define LANE_FUN_PRBS 6
+#define LANE_FUN_SPEED_CHANGE 7
+			u32 value0;
+			u32 value1;
+			u32 value2;
+			u32 value3;
+		} set_lane_fun;
+
+		struct {
+			u32 flag;
+			int nr_lane;
+		} set_dump;
+
+		struct {
+			u32 lane;
+			u32 enable;
+		} wol;
+
+		struct {
+			u32 lane;
+			u32 mode;
+		} gephy_test;
+
+		struct {
+			u32 lane;
+			u32 op;
+			u32 enable;
+			u32 inteval;
+		} lldp_tx;
+
+		struct {
+			u32 bytes;
+			int nr_lane;
+			u32 bin_offset;
+			u32 no_use;
+		} get_dump;
+
+		struct {
+			int nr_lane;
+			u32 value;
+#define LED_IDENTIFY_INACTIVE 0
+#define LED_IDENTIFY_ACTIVE 1
+#define LED_IDENTIFY_ON 2
+#define LED_IDENTIFY_OFF 3
+		} led_set;
+
+		struct {
+			u32 addr;
+			u32 data;
+			u32 mask;
+		} modify_reg;
+
+		struct {
+			u32 adv_speed_mask;
+			u32 autoneg;
+			u32 speed;
+			u32 duplex;
+			int nr_lane;
+			u32 tp_mdix_ctrl;
+		} phy_link_set;
+
+		struct {
+			u32 pause_mode;
+			int nr_lane;
+		} phy_pause_set;
+
+		struct {
+			u32 pause_mode;
+			int nr_lane;
+		} phy_pause_get;
+
+		struct {
+			u32 local_eee;
+			u32 tx_lpi_timer;
+			int nr_lane;
+		} phy_eee_set;
+
+		struct {
+			int nr_lane;
+			u32 sfp_adr; /* 0xa0 or 0xa2 */
+			u32 reg;
+			u32 cnt;
+		} sfp_read;
+
+		struct {
+			int nr_lane;
+			u32 sfp_adr; /* 0xa0 or 0xa2 */
+			u32 reg;
+			u32 val;
+		} sfp_write;
+
+		struct {
+			int nr_lane; /* 0-3 */
+		} get_linkstat;
+
+		struct {
+			u16 changed_lanes;
+			u16 lane_status;
+			u32 port_st_magic;
+#define SPEED_VALID_MAGIC 0xa4a6a8a9
+			struct port_stat st[4];
+		} link_stat; /* FW->RC */
+
+		struct {
+			u16 enable_stat;
+			u16 event_mask;
+		} stat_event_mask;
+
+		struct {
+			u32 cmd;
+			u32 arg0;
+			u32 req_bytes;
+			u32 reply_bytes;
+			u32 ddr_lo;
+			u32 ddr_hi;
+		} maintain;
+
+		struct { /* set phy register */
+			u8 phy_interface;
+			union {
+				u8 page_num;
+				u8 external_phy_addr;
+			};
+			u32 phy_reg_addr;
+			u32 phy_w_data;
+			u32 reg_addr;
+			u32 w_data;
+			/* 1 = ignore page_num, use last QSFP */
+			u8 recall_qsfp_page : 1;
+			/* page value */
+			/* 0 = use page_num for QSFP */
+			u8 nr_lane;
+		} set_phy_reg;
+
+		struct {
+			int lane_mask;
+			u32 pfvf_num;
+		} get_mac_addr;
+
+		struct {
+			u8 phy_interface;
+			union {
+				u8 page_num;
+				u8 external_phy_addr;
+			};
+			int phy_reg_addr;
+			u8 nr_lane;
+		} get_phy_reg;
+
+		struct {
+			int nr_lane;
+		} phy_statistics;
+
+		struct {
+			u8 paration;
+			u32 bytes;
+			u32 bin_phy_lo;
+			u32 bin_phy_hi;
+		} fw_update;
+	};
+} __packed;
+
+#define EEE_1000BT BIT(2)
+#define EEE_100BT BIT(1)
+
+struct rnpgbe_eee_cap {
+	u32 local_capability;
+	u32 local_eee;
+	u32 partner_eee;
+};
+
+/* firmware -> driver */
+struct mbx_fw_cmd_reply {
+	/* fw must set: DD, CMP, Error(if error), copy value */
+	u16 flags;
+	/* from command: LB,RD,VFC,BUF,SI,EI,FE */
+	u16 opcode; /* 2-3: copy from req */
+	u16 error_code; /* 4-5: 0 if no error */
+	u16 datalen; /* 6-7: */
+	union {
+		struct {
+			u32 cookie_lo; /* 8-11: */
+			u32 cookie_hi; /* 12-15: */
+		};
+		void *cookie;
+	};
+	/* ===== data ==== [16-64] */
+	union {
+		u8 data[40];
+
+		struct version {
+			u32 major;
+			u32 sub;
+			u32 modify;
+		} version;
+
+		struct {
+			u32 value[4];
+		} r_reg;
+
+		struct {
+			u32 new_value;
+		} modify_reg;
+
+		struct get_temp {
+			int temp;
+			int volatage;
+		} get_temp;
+
+		struct {
+#define MBX_SFP_READ_MAX_CNT 32
+			u8 value[MBX_SFP_READ_MAX_CNT];
+		} sfp_read;
+
+		struct mac_addr {
+			int lanes;
+			struct _addr {
+				/*
+				 * for macaddr:01:02:03:04:05:06
+				 * mac-hi=0x01020304 mac-lo=0x05060000
+				 */
+				u8 mac[8];
+			} addrs[4];
+		} mac_addr;
+
+		struct get_dump_reply {
+			u32 flags;
+			u32 version;
+			u32 bytes;
+			u32 data[4];
+		} get_dump;
+
+		struct get_lldp_reply {
+			u32 value;
+			u32 inteval;
+		} get_lldp;
+
+		struct rnpgbe_eee_cap phy_eee_abilities;
+		struct lane_stat_data lanestat;
+		struct hw_abilities hw_abilities;
+		struct phy_statistics phy_statistics;
+	};
+} __packed;
+
+static inline void build_phy_abalities_req(struct mbx_fw_cmd_req *req,
+					   void *cookie)
+{
+	req->flags = 0;
+	req->opcode = GET_PHY_ABALITY;
+	req->datalen = 0;
+	req->reply_lo = 0;
+	req->reply_hi = 0;
+	req->cookie = cookie;
+}
+
+int mucse_mbx_get_capability(struct mucse_hw *hw);
+
+#endif /* _RNPGBE_MBX_FW_H */
-- 
2.25.1


