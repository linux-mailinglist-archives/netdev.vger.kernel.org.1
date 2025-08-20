Return-Path: <netdev+bounces-215189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 050BEB2D834
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 11:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D72DB16B24D
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 09:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0442E090C;
	Wed, 20 Aug 2025 09:22:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266F12DE6E8;
	Wed, 20 Aug 2025 09:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755681754; cv=none; b=su2QSewWdBlSyasS9ljA79mZ+08rCzu43s4ykfq8ljd898K8x8jh+12nQzZfq+R2mgjRaC/QotpBCRb/15eLUUhrJGsk/XkJVaREnwJAb6zaCLfi6Bzz7E0oetJUcgwFOPnXrI73SuN0LDxn44Po2MFK5zC4wM+KnxIWx3fMonc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755681754; c=relaxed/simple;
	bh=aE8ZXDwA4vX3XyiejcNZ/J6AvkzntnFoSt+PGsYh9jU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uYNCESOed3BtKMVObVmB78tCoePBiDeAIjAwDFZImEsBoNS9sfoRMM3bXJ45m8bR88xcF00i5SVu88VDmCwi/JWFy+i4W2KuOQEDHpC2kOiNeFVT9BzS9JeoadRtlsZOSiXpOTQi2YI8JQmrzZjwTkI4S3TBK/0use8PnP0wJTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpgz10t1755681742t6c6903a7
X-QQ-Originating-IP: UMWMu9ms/ikWG5Zm9eojT35L355AIUE1O4F9qSRVIpU=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 20 Aug 2025 17:22:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11997831441696821285
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
Subject: [PATCH net-next v6 3/5] net: rnpgbe: Add basic mbx ops support
Date: Wed, 20 Aug 2025 17:21:52 +0800
Message-Id: <20250820092154.1643120-4-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250820092154.1643120-1-dong100@mucse.com>
References: <20250820092154.1643120-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MtZUceor8KoRzHTE6/LeqD12RYujwNZA65GIOIijJ/e+dEfe5WOLQqDc
	Jz0eIYsvEMXoNbItgcFgHJPwpk+d2WSR58mh359+WNgbDTKaWWxgERqeP1e4iaJE+P4WWhe
	134iE7Z1FrmvXweFfHF8pZIED1tSEjZGLQVo0qajjdwie/46ICLkeFaZuZ1ILwZc0xejF2/
	NxyZH1pIRa0UIaUb+Xyy60ggF7mYZqbyfhevpfsKhQBqb1kf5eozaXQ8TBnTvDpFB1vwXRB
	/EyLrGXMI9iJJsTcc2gVu1vw+IFwqzyikE8kuTvm/NXgdZdQIUGWT1HIb2Qn2adeYEFGa3Z
	R3HnyoSl89eTtVDwIQEwcG9z6aHDRIaScnGTZrCPfaCChjfZGyA0jjovO8VBltQp+4yLr1Z
	G2Oti7SsNFjnAHmzsIGe1vpeEjdLrLi+iPDYYUiMowxP7ZVoQhOEa9B7fLoDV0Gc+VuRgYM
	/C5ra/6ZJPvEDISxZbXDEtACffEEdsECwGSIXzub/v8dDUDT9CaE+ew3lhhAKNAtfwUUpiz
	quiBenVs1bq7u0C4eDEVCAnsxSslyuO51HlbDXQS5R/yrozDiWAEoQzmpM9H5Zk66yW6gIn
	7D/61BYLK4oYPlCsoExYV7zP6q+7A9iTOqfe3/1VT4b5Mm5rowfjF3Y979srMOrn6RAefnD
	VYt3N1EAIS4fC26Vqnus6HWpqdi0tA3whu3gzeSketPI+CJJuZaPPhCuOOJl/wewZtacX9c
	scbjMhzDUMsu+acv0wkZXMHz4o4HBoshgya6oacmgYT46iiSwhWMTdwnRhulkPEQDK6D9lk
	H+QB3f0f61aeBq1QCtAGJak+QBxb4Uex7CdwW1QQ/lSTT7br4OKGtz5F7igmqOFjcnNaWFO
	9auYNDNaFsi2k7w2vz7C4ISV5m8S6wuRq+rOlA9WTh9QL5dGQBB7uXrU3rwt8WIrofGmm6T
	BQdfaFOg2vzD3vOoqilrpoyLaaYgoYwnOC+NuOqthGMa4+mPD+lk+wDsTkj1flurpcBY3MQ
	5h3s2FkWokcn7UAJ5nbWJVFsSucZKG1wdt/vHyIMxITWpa1Ldd5q6l4frw/c2CbSZzK7FHa
	RcSHVLiYrZqBXMr77Lr8oKtatDg39YPbA==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

Initialize basic mbx function.

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/Makefile    |   3 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  17 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |   3 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    | 479 ++++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |  31 ++
 5 files changed, 532 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h

diff --git a/drivers/net/ethernet/mucse/rnpgbe/Makefile b/drivers/net/ethernet/mucse/rnpgbe/Makefile
index 42c359f459d9..5fc878ada4b1 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/Makefile
+++ b/drivers/net/ethernet/mucse/rnpgbe/Makefile
@@ -6,4 +6,5 @@
 
 obj-$(CONFIG_MGBE) += rnpgbe.o
 rnpgbe-objs := rnpgbe_main.o\
-	       rnpgbe_chip.o
+	       rnpgbe_chip.o\
+	       rnpgbe_mbx.o
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
index 2ae310303a48..9f94b381c1d1 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -5,6 +5,7 @@
 #define _RNPGBE_H
 
 #include <linux/types.h>
+#include <linux/mutex.h>
 
 extern const struct rnpgbe_info rnpgbe_n500_info;
 extern const struct rnpgbe_info rnpgbe_n210_info;
@@ -23,7 +24,23 @@ enum rnpgbe_hw_type {
 	rnpgbe_hw_unknown
 };
 
+struct mucse_mbx_stats {
+	u32 msgs_tx;
+	u32 msgs_rx;
+	u32 acks;
+	u32 reqs;
+};
+
 struct mucse_mbx_info {
+	struct mucse_mbx_stats stats;
+	u32 timeout;
+	u32 usec_delay;
+	u16 size;
+	u16 fw_req;
+	u16 fw_ack;
+	/* lock for only one use mbx */
+	struct mutex lock;
+	bool irq_enabled;
 	/* fw <--> pf mbx */
 	u32 fw_pf_shm_base;
 	u32 pf2fw_mbox_ctrl;
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
index 3cb25670586e..7791af04c317 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
@@ -1,8 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2020 - 2025 Mucse Corporation. */
 
+#include <linux/string.h>
+
 #include "rnpgbe.h"
 #include "rnpgbe_hw.h"
+#include "rnpgbe_mbx.h"
 
 /**
  * rnpgbe_init_common - Setup common attribute
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
new file mode 100644
index 000000000000..c2f772f86ead
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
@@ -0,0 +1,479 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2022 - 2025 Mucse Corporation. */
+
+#include <linux/pci.h>
+#include <linux/errno.h>
+#include <linux/delay.h>
+#include <linux/iopoll.h>
+
+#include "rnpgbe.h"
+#include "rnpgbe_mbx.h"
+#include "rnpgbe_hw.h"
+
+/**
+ * mbx_data_rd32  - Reads reg with base mbx->fw_pf_shm_base
+ * @mbx: pointer to the MBX structure
+ * @reg: register offset
+ *
+ * @return: register value
+ **/
+static u32 mbx_data_rd32(struct mucse_mbx_info *mbx, u32 reg)
+{
+	struct mucse_hw *hw = container_of(mbx, struct mucse_hw, mbx);
+
+	return readl(hw->hw_addr + mbx->fw_pf_shm_base + reg);
+}
+
+/**
+ * mbx_data_wr32  - Writes value to reg with base mbx->fw_pf_shm_base
+ * @mbx: pointer to the MBX structure
+ * @reg: register offset
+ * @value: value to be written
+ *
+ **/
+static void mbx_data_wr32(struct mucse_mbx_info *mbx, u32 reg, u32 value)
+{
+	struct mucse_hw *hw = container_of(mbx, struct mucse_hw, mbx);
+
+	writel(value, hw->hw_addr + mbx->fw_pf_shm_base + reg);
+}
+
+/**
+ * mbx_ctrl_rd32  - Reads reg with base mbx->fw2pf_mbox_vec
+ * @mbx: pointer to the MBX structure
+ * @reg: register offset
+ *
+ * @return: register value
+ **/
+static u32 mbx_ctrl_rd32(struct mucse_mbx_info *mbx, u32 reg)
+{
+	struct mucse_hw *hw = container_of(mbx, struct mucse_hw, mbx);
+
+	return readl(hw->hw_addr + mbx->fw2pf_mbox_vec + reg);
+}
+
+/**
+ * mbx_ctrl_wr32  - Writes value to reg with base mbx->fw2pf_mbox_vec
+ * @mbx: pointer to the MBX structure
+ * @reg: register offset
+ * @value: value to be written
+ *
+ **/
+static void mbx_ctrl_wr32(struct mucse_mbx_info *mbx, u32 reg, u32 value)
+{
+	struct mucse_hw *hw = container_of(mbx, struct mucse_hw, mbx);
+
+	writel(value, hw->hw_addr + mbx->fw2pf_mbox_vec + reg);
+}
+
+/**
+ * mucse_mbx_get_req - Read req from reg
+ * @mbx: pointer to the mbx structure
+ * @reg: register to read
+ *
+ * @return: the req value
+ **/
+static u16 mucse_mbx_get_req(struct mucse_mbx_info *mbx, int reg)
+{
+	return mbx_data_rd32(mbx, reg) & GENMASK(15, 0);
+}
+
+/**
+ * mucse_mbx_get_ack - Read ack from reg
+ * @mbx: pointer to the MBX structure
+ * @reg: register to read
+ *
+ * @return: the ack value
+ **/
+static u16 mucse_mbx_get_ack(struct mucse_mbx_info *mbx, int reg)
+{
+	return (mbx_data_rd32(mbx, reg) >> 16);
+}
+
+/**
+ * mucse_mbx_inc_pf_req - Increase req
+ * @hw: pointer to the HW structure
+ *
+ * mucse_mbx_inc_pf_req read pf_req from hw, then write
+ * new value back after increase
+ **/
+static void mucse_mbx_inc_pf_req(struct mucse_hw *hw)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	u16 req;
+	u32 v;
+
+	v = mbx_data_rd32(mbx, MBX_PF2FW_COUNTER);
+	req = (v & GENMASK(15, 0));
+	req++;
+	v &= GENMASK(31, 16);
+	v |= req;
+	mbx_data_wr32(mbx, MBX_PF2FW_COUNTER, v);
+	hw->mbx.stats.msgs_tx++;
+}
+
+/**
+ * mucse_mbx_inc_pf_ack - Increase ack
+ * @hw: pointer to the HW structure
+ *
+ * mucse_mbx_inc_pf_ack read pf_ack from hw, then write
+ * new value back after increase
+ **/
+static void mucse_mbx_inc_pf_ack(struct mucse_hw *hw)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	u16 ack;
+	u32 v;
+
+	v = mbx_data_rd32(mbx, MBX_PF2FW_COUNTER);
+	ack = (v >> 16) & GENMASK(15, 0);
+	ack++;
+	v &= GENMASK(15, 0);
+	v |= (ack << 16);
+	mbx_data_wr32(mbx, MBX_PF2FW_COUNTER, v);
+	hw->mbx.stats.msgs_rx++;
+}
+
+/**
+ * mucse_check_for_msg_pf - Check to see if the fw has sent mail
+ * @hw: pointer to the HW structure
+ *
+ * @return: 0 if the fw has set the Status bit or else
+ * -EIO
+ **/
+static int mucse_check_for_msg_pf(struct mucse_hw *hw)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	u16 hw_req_count = 0;
+
+	hw_req_count = mucse_mbx_get_req(mbx, MBX_FW2PF_COUNTER);
+	/* chip's register is reset to 0 when rc send reset
+	 * mbx command. This causes 'hw_req_count != hw->mbx.fw_req'
+	 * be TRUE before fw really reply. Driver must wait fw reset
+	 * done reply before using chip, we must check no-zero.
+	 **/
+	if (hw_req_count != 0 && hw_req_count != hw->mbx.fw_req) {
+		hw->mbx.stats.reqs++;
+		return 0;
+	}
+
+	return -EIO;
+}
+
+/**
+ * mucse_poll_for_msg - Wait for message notification
+ * @hw: pointer to the HW structure
+ *
+ * @return: 0 on success, negative on failure
+ **/
+static int mucse_poll_for_msg(struct mucse_hw *hw)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	int countdown = mbx->timeout;
+	int val;
+
+	return read_poll_timeout(mucse_check_for_msg_pf,
+				 val, val == 0, mbx->usec_delay,
+				 countdown * mbx->usec_delay,
+				 false, hw);
+}
+
+/**
+ * mucse_check_for_ack_pf - Check to see if the VF has ACKed
+ * @hw: pointer to the HW structure
+ *
+ * @return: 0 if the fw has set the Status bit or else
+ * -EIO
+ **/
+static int mucse_check_for_ack_pf(struct mucse_hw *hw)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	u16 hw_fw_ack;
+
+	hw_fw_ack = mucse_mbx_get_ack(mbx, MBX_FW2PF_COUNTER);
+	/* chip's register is reset to 0 when rc send reset
+	 * mbx command. This causes 'hw_fw_ack != hw->mbx.fw_ack'
+	 * be TRUE before fw really reply. Driver must wait fw reset
+	 * done reply before using chip, we must check no-zero.
+	 **/
+	if (hw_fw_ack != 0 && hw_fw_ack != hw->mbx.fw_ack) {
+		hw->mbx.stats.acks++;
+		return 0;
+	}
+
+	return -EIO;
+}
+
+/**
+ * mucse_poll_for_ack - Wait for message acknowledgment
+ * @hw: pointer to the HW structure
+ *
+ * @return: 0 if it successfully received a message acknowledgment
+ **/
+static int mucse_poll_for_ack(struct mucse_hw *hw)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	int countdown = mbx->timeout;
+	int val;
+
+	return read_poll_timeout(mucse_check_for_ack_pf,
+				 val, val == 0, mbx->usec_delay,
+				 countdown * mbx->usec_delay,
+				 false, hw);
+}
+
+/**
+ * mucse_obtain_mbx_lock_pf - Obtain mailbox lock
+ * @hw: pointer to the HW structure
+ *
+ * This function maybe used in an irq handler.
+ *
+ * @return: 0 if we obtained the mailbox lock
+ **/
+static int mucse_obtain_mbx_lock_pf(struct mucse_hw *hw)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	int try_cnt = 5000;
+	u32 reg;
+
+	reg = PF2FW_MBOX_CTRL(mbx);
+	while (try_cnt-- > 0) {
+		mbx_ctrl_wr32(mbx, reg, MBOX_PF_HOLD);
+		/* force write back before check */
+		wmb();
+		if (mbx_ctrl_rd32(mbx, reg) & MBOX_PF_HOLD)
+			return 0;
+		udelay(100);
+	}
+	return -EIO;
+}
+
+/**
+ * mucse_read_mbx_pf - Read a message from the mailbox
+ * @hw: pointer to the HW structure
+ * @msg: the message buffer
+ * @size: length of buffer
+ *
+ * This function copies a message from the mailbox buffer to the caller's
+ * memory buffer. The presumption is that the caller knows that there was
+ * a message due to a fw request so no polling for message is needed.
+ *
+ * @return: 0 on success, negative on failure
+ **/
+static int mucse_read_mbx_pf(struct mucse_hw *hw, u32 *msg, u16 size)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	int size_inwords = size / 4;
+	u32 ctrl_reg;
+	int ret;
+	int i;
+
+	ctrl_reg = PF2FW_MBOX_CTRL(mbx);
+
+	ret = mucse_obtain_mbx_lock_pf(hw);
+	if (ret)
+		return ret;
+	for (i = 0; i < size_inwords; i++)
+		msg[i] = mbx_data_rd32(mbx, MBX_FW_PF_SHM_DATA + 4 * i);
+	/* Hw need write data_reg at last */
+	mbx_data_wr32(mbx, MBX_FW_PF_SHM_DATA, 0);
+	hw->mbx.fw_req = mucse_mbx_get_req(mbx, MBX_FW2PF_COUNTER);
+	mucse_mbx_inc_pf_ack(hw);
+	mbx_ctrl_wr32(mbx, ctrl_reg, 0);
+
+	return 0;
+}
+
+/**
+ * mucse_read_posted_mbx - Wait for message notification and receive message
+ * @hw: pointer to the HW structure
+ * @msg: the message buffer
+ * @size: length of buffer
+ *
+ * @return: 0 if it successfully received a message notification and
+ * copied it into the receive buffer.
+ **/
+int mucse_read_posted_mbx(struct mucse_hw *hw, u32 *msg, u16 size)
+{
+	int ret;
+
+	ret = mucse_poll_for_msg(hw);
+	if (ret)
+		return ret;
+
+	return mucse_read_mbx_pf(hw, msg, size);
+}
+
+/**
+ * mucse_mbx_reset - Reset mbx info, sync info from regs
+ * @hw: pointer to the HW structure
+ *
+ * This function reset all mbx variables to default.
+ **/
+static void mucse_mbx_reset(struct mucse_hw *hw)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	u32 v;
+
+	v = mbx_data_rd32(mbx, MBX_FW2PF_COUNTER);
+	hw->mbx.fw_req = v & GENMASK(15, 0);
+	hw->mbx.fw_ack = (v >> 16) & GENMASK(15, 0);
+	mbx_ctrl_wr32(mbx, PF2FW_MBOX_CTRL(mbx), 0);
+	mbx_ctrl_wr32(mbx, FW_PF_MBOX_MASK(mbx), GENMASK(31, 16));
+}
+
+/**
+ * mucse_mbx_configure_pf - Configure mbx to use nr_vec interrupt
+ * @hw: pointer to the HW structure
+ * @nr_vec: vector number for mbx
+ * @enable: TRUE for enable, FALSE for disable
+ *
+ * This function configure mbx to use interrupt nr_vec.
+ **/
+void mucse_mbx_configure_pf(struct mucse_hw *hw, int nr_vec,
+			    bool enable)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	u32 v;
+
+	if (enable) {
+		v = mbx_data_rd32(mbx, MBX_FW2PF_COUNTER);
+		hw->mbx.fw_req = v & GENMASK(15, 0);
+		hw->mbx.fw_ack = (v >> 16) & GENMASK(15, 0);
+		mbx_ctrl_wr32(mbx, PF2FW_MBOX_CTRL(mbx), 0);
+		mbx_ctrl_wr32(mbx, FW2PF_MBOX_VEC, nr_vec);
+		mbx_ctrl_wr32(mbx, FW_PF_MBOX_MASK(mbx), GENMASK(31, 16));
+	} else {
+		mbx_ctrl_wr32(mbx, FW_PF_MBOX_MASK(mbx), 0xfffffffe);
+		mbx_ctrl_wr32(mbx, PF2FW_MBOX_CTRL(mbx), 0);
+	}
+}
+
+/**
+ * mucse_init_mbx_params_pf - Set initial values for pf mailbox
+ * @hw: pointer to the HW structure
+ *
+ * Initializes the hw->mbx struct to correct values for pf mailbox
+ */
+void mucse_init_mbx_params_pf(struct mucse_hw *hw)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+
+	mbx->usec_delay = 100;
+	mbx->timeout = (4 * USEC_PER_SEC) / mbx->usec_delay;
+	mbx->stats.msgs_tx = 0;
+	mbx->stats.msgs_rx = 0;
+	mbx->stats.reqs = 0;
+	mbx->stats.acks = 0;
+	mbx->size = MUCSE_MAILBOX_BYTES;
+	mutex_init(&mbx->lock);
+	mucse_mbx_reset(hw);
+}
+
+/**
+ * mucse_read_mbx - Reads a message from the mailbox
+ * @hw: pointer to the HW structure
+ * @msg: the message buffer
+ * @size: length of buffer
+ *
+ * @return: 0 on success, negative on failure
+ **/
+int mucse_read_mbx(struct mucse_hw *hw, u32 *msg, u16 size)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	struct device *dev = &hw->pdev->dev;
+
+	if (size > mbx->size) {
+		dev_err(dev, "mbx read size too large\n");
+		return -EINVAL;
+	}
+	return mucse_read_mbx_pf(hw, msg, size);
+}
+
+/**
+ * mucse_write_mbx_pf - Place a message in the mailbox
+ * @hw: pointer to the HW structure
+ * @msg: the message buffer
+ * @size: length of buffer
+ *
+ * This function maybe used in an irq handler.
+ *
+ * @return: 0 if it successfully copied message into the buffer
+ **/
+int mucse_write_mbx_pf(struct mucse_hw *hw, u32 *msg, u16 size)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	int size_inwords = size / 4;
+	u32 ctrl_reg;
+	int ret;
+	int i;
+
+	ctrl_reg = PF2FW_MBOX_CTRL(mbx);
+	ret = mucse_obtain_mbx_lock_pf(hw);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < size_inwords; i++)
+		mbx_data_wr32(mbx, MBX_FW_PF_SHM_DATA + i * 4, msg[i]);
+
+	/* flush msg and acks as we are overwriting the message buffer */
+	hw->mbx.fw_ack = mucse_mbx_get_ack(mbx, MBX_FW2PF_COUNTER);
+	mucse_mbx_inc_pf_req(hw);
+	mbx_ctrl_wr32(mbx, ctrl_reg, MBOX_CTRL_REQ);
+
+	return 0;
+}
+
+/**
+ * mucse_write_mbx - Write a message to the mailbox
+ * @hw: pointer to the HW structure
+ * @msg: the message buffer
+ * @size: length of buffer
+ *
+ * @return: 0 on success, negative on failure
+ **/
+int mucse_write_mbx(struct mucse_hw *hw, u32 *msg, u16 size)
+{
+	return mucse_write_mbx_pf(hw, msg, size);
+}
+
+/**
+ * mucse_write_posted_mbx - Write a message to the mailbox, wait for ack
+ * @hw: pointer to the HW structure
+ * @msg: the message buffer
+ * @size: length of buffer
+ *
+ * @return: 0 if it successfully copied message into the buffer and
+ * received an ack to that message within delay * timeout period
+ **/
+int mucse_write_posted_mbx(struct mucse_hw *hw, u32 *msg, u16 size)
+{
+	int ret;
+
+	ret = mucse_write_mbx_pf(hw, msg, size);
+	if (ret)
+		return ret;
+	return mucse_poll_for_ack(hw);
+}
+
+/**
+ * mucse_check_for_msg - Check to see if fw sent us mail
+ * @hw: pointer to the HW structure
+ *
+ * @return: 0 on success, negative on failure
+ **/
+int mucse_check_for_msg(struct mucse_hw *hw)
+{
+	return mucse_check_for_msg_pf(hw);
+}
+
+/**
+ * mucse_check_for_ack - Check to see if fw sent us ACK
+ * @hw: pointer to the HW structure
+ *
+ * @return: 0 on success, negative on failure
+ **/
+int mucse_check_for_ack(struct mucse_hw *hw)
+{
+	return mucse_check_for_ack_pf(hw);
+}
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
new file mode 100644
index 000000000000..8fb3131d4221
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2020 - 2025 Mucse Corporation. */
+
+#ifndef _RNPGBE_MBX_H
+#define _RNPGBE_MBX_H
+
+#include "rnpgbe.h"
+
+#define MUCSE_MAILBOX_BYTES 56
+#define MBX_FW2PF_COUNTER 0
+#define MBX_PF2FW_COUNTER 4
+#define MBX_FW_PF_SHM_DATA 8
+#define FW2PF_MBOX_VEC 0
+#define PF2FW_MBOX_CTRL(mbx) ((mbx)->pf2fw_mbox_ctrl)
+#define FW_PF_MBOX_MASK(mbx) ((mbx)->fw_pf_mbox_mask)
+#define MBOX_CTRL_REQ BIT(0)
+#define MBOX_PF_HOLD BIT(3)
+#define MBOX_IRQ_EN 0
+#define MBOX_IRQ_DISABLE 1
+
+int mucse_read_mbx(struct mucse_hw *hw, u32 *msg, u16 size);
+int mucse_write_mbx_pf(struct mucse_hw *hw, u32 *msg, u16 size);
+int mucse_write_mbx(struct mucse_hw *hw, u32 *msg, u16 size);
+int mucse_write_posted_mbx(struct mucse_hw *hw, u32 *msg, u16 size);
+int mucse_check_for_msg(struct mucse_hw *hw);
+int mucse_check_for_ack(struct mucse_hw *hw);
+void mucse_init_mbx_params_pf(struct mucse_hw *hw);
+void mucse_mbx_configure_pf(struct mucse_hw *hw, int nr_vec,
+			    bool enable);
+int mucse_read_posted_mbx(struct mucse_hw *hw, u32 *msg, u16 size);
+#endif /* _RNPGBE_MBX_H */
-- 
2.25.1


