Return-Path: <netdev+bounces-208570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A51B0C314
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 13:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EBCC188ADBB
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 11:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC2B2BDC2C;
	Mon, 21 Jul 2025 11:34:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF7129E0F6;
	Mon, 21 Jul 2025 11:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753097648; cv=none; b=pBtpb/pFVrkXag8Ul3T2yHZck+HjauMFm+LM+++8GZp4JrI8c6Ovm5hMcHOjHsyTcgg5PFyzm15NK8EQUQOYv5GYk9xypzK54Nnzh0bx4iT2TvbtEi17xt2NNGcCzbq2dB0NPlhowlxCV5gyODllJmTQd/r+OgoT/rd8zMk081A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753097648; c=relaxed/simple;
	bh=SCP//Rm0JLeoCAlIOLQz4+G+wwzmlIPHfWtCfFmt7A4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XeCTYn6h998xxd6254VbrzTDVVf5o6bnJ5LzYoGMQzh29nZGqXxnFlH5Uu65KNazlT6OtUlyTLConr7tg64Tx5o6qfnOJq9UNLPAPkz7JWv6jBhse9SUMwh+RzmCys25QZy8NHJmSS09IMOgn9Qyx6X8kgo+r7TW0kvVGCS3bF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz18t1753097580tc73f08ec
X-QQ-Originating-IP: /8z6Hp0On905J8D0G+sDNB8Ef3Ye0eEfRoFz+PeHE/g=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 21 Jul 2025 19:32:57 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2044852615640205610
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
Subject: [PATCH v2 03/15] net: rnpgbe: Add basic mbx ops support
Date: Mon, 21 Jul 2025 19:32:26 +0800
Message-Id: <20250721113238.18615-4-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250721113238.18615-1-dong100@mucse.com>
References: <20250721113238.18615-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NU206xxuabmsUretmDyprvZ2FEP8cb9K1uDISnousBt5TIQ1ZOA26ck2
	W3QnbyXZSuSQhZgtLXvFbAy7eYCCJHuXfbFmNmUkueXrOV0F6cQo0HFzh/tyWABze+FQqiz
	jVdkQS55XqNACKR5DYTB3kUNiISBqNBTMg48Q4JeipLFKGk/NKZIwuyId1sZONdhiNQouS0
	CXu1o+jwJGurYtMplN7L672bUNGfFnmeFFSA2PYFJ6HWMnkn/LV61KMIXfqJATnxH/kCbEW
	xw4Evwt2wF6gquEI71iZFAoGG4JW4ri7lUdL52Z1Sjo6SWdvXXn6ZOcLUHxR8bhwPEia0Au
	UUSaLkkP0zYGyJ9lu/FvD+1kOOFsvpAoO9jmvpjkdQ/kTMA0QudXn42fzhypo19239lXRdZ
	h1uo+bscoDofNDaALrJJQ7KaXb8IhbOGFa/A2y8ZYsAKT0XUlzRJIAcaeYMfuvZKy+hRoIl
	IVpVGgvf22AvnBDZPkIsBTD/ye5Pi67pTfJZ5OKpY48tfvuywAoBC4LA721WAFSaIes0MX2
	NcvQK+Z399d8Oh4LdeJXRd0fk5+aQc3UHxmup5g8s9NgjNejb1eEAjCi/O4T74SCGPdw7AP
	SaR0McUsgx6rRuD7nY8lOur0v7c/g8oflXcztP40eDyJQKxF1o5RQIU38r7trs/MrBmjz0A
	2CmSzHdUgQOP/+DSjOygqE+BslHrFhmhbHz4Wt3unf54yGzaGpuRusQmlMgB7SZRpij53M9
	+F8YLDSlSjc0p5PJqxjYqnUwGZqnRGpZyZIs00hJ4Now+kTsNxcy2TpG0IDdIWAInSS3Z5i
	JprGFYzDhmeX67iKanOnHi4elvHDKrcBKTMsHwbamKGjZ5D2XO72r4Ede2iC6OlJsUk9cFR
	jfNqV+N54IDNlVJzu7ZDkk0M+vaFdDsY7wf5+t2+GYMDr0dWLPy7LtiJgg6ABp58roRObN3
	bYQFRrk4seZ2thOkhEWTNuLyVQDNmEOOE7NqDRTmyciclU+qCWQC+wP6JSS5oQkrw9/rvht
	sNop14vXMpLryKXOJ22YKlRsB4Kq7xAmbgSFggD5sE8WbCsmbn
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

Initialize basic mbx function.

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/Makefile    |   5 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  46 ++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |   5 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |   2 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |   1 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    | 623 ++++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |  48 ++
 7 files changed, 727 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h

diff --git a/drivers/net/ethernet/mucse/rnpgbe/Makefile b/drivers/net/ethernet/mucse/rnpgbe/Makefile
index 42c359f459d9..41177103b50c 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/Makefile
+++ b/drivers/net/ethernet/mucse/rnpgbe/Makefile
@@ -5,5 +5,6 @@
 #
 
 obj-$(CONFIG_MGBE) += rnpgbe.o
-rnpgbe-objs := rnpgbe_main.o\
-	       rnpgbe_chip.o
+rnpgbe-objs := rnpgbe_main.o \
+	       rnpgbe_chip.o \
+	       rnpgbe_mbx.o
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
index 2ae836fc8951..46e2bb2fe71e 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -63,9 +63,51 @@ struct mucse_mac_info {
 	int clk_csr;
 };
 
+struct mucse_hw;
+
+enum MBX_ID {
+	MBX_VF0 = 0,
+	MBX_VF1,
+	MBX_VF2,
+	MBX_VF3,
+	MBX_VF4,
+	MBX_VF5,
+	MBX_VF6,
+	MBX_VF7,
+	MBX_CM3CPU,
+	MBX_FW = MBX_CM3CPU,
+	MBX_VFCNT
+};
+
+struct mucse_mbx_operations {
+	void (*init_params)(struct mucse_hw *hw);
+	int (*read)(struct mucse_hw *hw, u32 *msg,
+		    u16 size, enum MBX_ID id);
+	int (*write)(struct mucse_hw *hw, u32 *msg,
+		     u16 size, enum MBX_ID id);
+	int (*read_posted)(struct mucse_hw *hw, u32 *msg,
+			   u16 size, enum MBX_ID id);
+	int (*write_posted)(struct mucse_hw *hw, u32 *msg,
+			    u16 size, enum MBX_ID id);
+	int (*check_for_msg)(struct mucse_hw *hw, enum MBX_ID id);
+	int (*check_for_ack)(struct mucse_hw *hw, enum MBX_ID id);
+	void (*configure)(struct mucse_hw *hw, int num_vec,
+			  bool enable);
+};
+
+struct mucse_mbx_stats {
+	u32 msgs_tx;
+	u32 msgs_rx;
+	u32 acks;
+	u32 reqs;
+	u32 rsts;
+};
+
 #define MAX_VF_NUM (8)
 
 struct mucse_mbx_info {
+	struct mucse_mbx_operations ops;
+	struct mucse_mbx_stats stats;
 	u32 timeout;
 	u32 usec_delay;
 	u32 v2p_mailbox;
@@ -99,6 +141,8 @@ struct mucse_mbx_info {
 	int share_size;
 };
 
+#include "rnpgbe_mbx.h"
+
 struct mucse_hw {
 	void *back;
 	u8 pfvfnum;
@@ -110,6 +154,8 @@ struct mucse_hw {
 	u16 vendor_id;
 	u16 subsystem_device_id;
 	u16 subsystem_vendor_id;
+	int max_vfs;
+	int max_vfs_noari;
 	enum rnpgbe_hw_type hw_type;
 	struct mucse_dma_info dma;
 	struct mucse_eth_info eth;
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
index 38c094965db9..b0e5fda632f3 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
@@ -6,6 +6,7 @@
 
 #include "rnpgbe.h"
 #include "rnpgbe_hw.h"
+#include "rnpgbe_mbx.h"
 
 /**
  * rnpgbe_get_invariants_n500 - setup for hw info
@@ -67,7 +68,7 @@ static void rnpgbe_get_invariants_n500(struct mucse_hw *hw)
 	mbx->fw_pf_mbox_mask = 0x2e200;
 	mbx->fw_vf_share_ram = 0x2b000;
 	mbx->share_size = 512;
-
+	memcpy(&hw->mbx.ops, &mucse_mbx_ops_generic, sizeof(hw->mbx.ops));
 	/* setup net feature here */
 	hw->feature_flags |= M_NET_FEATURE_SG |
 			     M_NET_FEATURE_TX_CHECKSUM |
@@ -83,6 +84,7 @@ static void rnpgbe_get_invariants_n500(struct mucse_hw *hw)
 			     M_NET_FEATURE_STAG_OFFLOAD;
 	/* start the default ahz, update later */
 	hw->usecstocount = 125;
+	hw->max_vfs = 7;
 }
 
 /**
@@ -117,6 +119,7 @@ static void rnpgbe_get_invariants_n210(struct mucse_hw *hw)
 	/* update hw feature */
 	hw->feature_flags |= M_HW_FEATURE_EEE;
 	hw->usecstocount = 62;
+	hw->max_vfs_noari = 7;
 }
 
 const struct rnpgbe_info rnpgbe_n500_info = {
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
index 2c7372a5e88d..ff7bd9b21550 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
@@ -14,6 +14,8 @@
 #define RNPGBE_RING_BASE (0x1000)
 #define RNPGBE_MAC_BASE (0x20000)
 #define RNPGBE_ETH_BASE (0x10000)
+
+#define RNPGBE_DMA_DUMY (0x000c)
 /* chip resourse */
 #define RNPGBE_MAX_QUEUES (8)
 /* multicast control table */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
index 08f773199e9b..1e8360cae560 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
@@ -114,6 +114,7 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
 	hw->hw_addr = hw_addr;
 	hw->dma.dma_version = dma_version;
 	ii->get_invariants(hw);
+	hw->mbx.ops.init_params(hw);
 
 	return 0;
 
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
new file mode 100644
index 000000000000..56ace3057fea
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
@@ -0,0 +1,623 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2022 - 2025 Mucse Corporation. */
+
+#include <linux/pci.h>
+#include <linux/errno.h>
+#include <linux/delay.h>
+#include <linux/iopoll.h>
+#include "rnpgbe.h"
+#include "rnpgbe_mbx.h"
+#include "rnpgbe_hw.h"
+
+/**
+ * mucse_read_mbx - Reads a message from the mailbox
+ * @hw: Pointer to the HW structure
+ * @msg: The message buffer
+ * @size: Length of buffer
+ * @mbx_id: Id of vf/fw to read
+ *
+ * @return: 0 on success, negative on failure
+ **/
+int mucse_read_mbx(struct mucse_hw *hw, u32 *msg, u16 size,
+		   enum MBX_ID mbx_id)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+
+	/* limit read to size of mailbox */
+	if (size > mbx->size)
+		size = mbx->size;
+
+	if (!mbx->ops.read)
+		return -EIO;
+
+	return mbx->ops.read(hw, msg, size, mbx_id);
+}
+
+/**
+ * mucse_write_mbx - Write a message to the mailbox
+ * @hw: Pointer to the HW structure
+ * @msg: The message buffer
+ * @size: Length of buffer
+ * @mbx_id: Id of vf/fw to write
+ *
+ * @return: 0 on success, negative on failure
+ **/
+int mucse_write_mbx(struct mucse_hw *hw, u32 *msg, u16 size,
+		    enum MBX_ID mbx_id)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+
+	if (size > mbx->size)
+		return -EINVAL;
+
+	if (!mbx->ops.write)
+		return -EIO;
+
+	return mbx->ops.write(hw, msg, size, mbx_id);
+}
+
+/**
+ * mucse_mbx_get_req - Read req from reg
+ * @hw: Pointer to the HW structure
+ * @reg: Register to read
+ *
+ * @return: the req value
+ **/
+static u16 mucse_mbx_get_req(struct mucse_hw *hw, int reg)
+{
+	/* force memory barrier */
+	mb();
+	return ioread32(hw->hw_addr + reg) & GENMASK(15, 0);
+}
+
+/**
+ * mucse_mbx_get_ack - Read ack from reg
+ * @hw: Pointer to the HW structure
+ * @reg: Register to read
+ *
+ * @return: the ack value
+ **/
+static u16 mucse_mbx_get_ack(struct mucse_hw *hw, int reg)
+{
+	/* force memory barrier */
+	mb();
+	return (mbx_rd32(hw, reg) >> 16);
+}
+
+/**
+ * mucse_mbx_inc_pf_req - Increase req
+ * @hw: Pointer to the HW structure
+ * @mbx_id: Id of vf/fw to read
+ *
+ * mucse_mbx_inc_pf_req read pf_req from hw, then write
+ * new value back after increase
+ **/
+static void mucse_mbx_inc_pf_req(struct mucse_hw *hw,
+				 enum MBX_ID mbx_id)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	u32 reg, v;
+	u16 req;
+
+	reg = (mbx_id == MBX_FW) ? PF2FW_COUNTER(mbx) :
+				   PF2VF_COUNTER(mbx, mbx_id);
+	v = mbx_rd32(hw, reg);
+	req = (v & GENMASK(15, 0));
+	req++;
+	v &= GENMASK(31, 16);
+	v |= req;
+	/* force before write to hw */
+	mb();
+	mbx_wr32(hw, reg, v);
+	/* update stats */
+	hw->mbx.stats.msgs_tx++;
+}
+
+/**
+ * mucse_mbx_inc_pf_ack - Increase ack
+ * @hw: Pointer to the HW structure
+ * @mbx_id: Id of vf/fw to read
+ *
+ * mucse_mbx_inc_pf_ack read pf_ack from hw, then write
+ * new value back after increase
+ **/
+static void mucse_mbx_inc_pf_ack(struct mucse_hw *hw,
+				 enum MBX_ID mbx_id)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	u32 reg, v;
+	u16 ack;
+
+	reg = (mbx_id == MBX_FW) ? PF2FW_COUNTER(mbx) :
+				   PF2VF_COUNTER(mbx, mbx_id);
+	v = mbx_rd32(hw, reg);
+	ack = (v >> 16) & GENMASK(15, 0);
+	ack++;
+	v &= GENMASK(15, 0);
+	v |= (ack << 16);
+	/* force before write to hw */
+	mb();
+	mbx_wr32(hw, reg, v);
+	/* update stats */
+	hw->mbx.stats.msgs_rx++;
+}
+
+/**
+ * mucse_check_for_msg - Checks to see if vf/fw sent us mail
+ * @hw: Pointer to the HW structure
+ * @mbx_id: Id of vf/fw to check
+ *
+ * @return: 0 on success, negative on failure
+ **/
+int mucse_check_for_msg(struct mucse_hw *hw, enum MBX_ID mbx_id)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+
+	if (!mbx->ops.check_for_msg)
+		return -EIO;
+
+	return mbx->ops.check_for_msg(hw, mbx_id);
+}
+
+/**
+ * mucse_check_for_ack - Checks to see if vf/fw sent us ACK
+ * @hw: Pointer to the HW structure
+ * @mbx_id: Id of vf/fw to check
+ *
+ * @return: 0 on success, negative on failure
+ **/
+int mucse_check_for_ack(struct mucse_hw *hw, enum MBX_ID mbx_id)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+
+	if (!mbx->ops.check_for_ack)
+		return -EIO;
+	return mbx->ops.check_for_ack(hw, mbx_id);
+}
+
+/**
+ * mucse_poll_for_msg - Wait for message notification
+ * @hw: Pointer to the HW structure
+ * @mbx_id: Id of vf/fw to poll
+ *
+ * @return: 0 on success, negative on failure
+ **/
+static int mucse_poll_for_msg(struct mucse_hw *hw, enum MBX_ID mbx_id)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	int countdown = mbx->timeout;
+	int val;
+
+	if (!countdown || !mbx->ops.check_for_msg)
+		return -EIO;
+
+	return read_poll_timeout(mbx->ops.check_for_msg,
+				 val, val == 0, mbx->usec_delay,
+				 countdown * mbx->usec_delay,
+				 false, hw, mbx_id);
+}
+
+/**
+ * mucse_poll_for_ack - Wait for message acknowledgment
+ * @hw: Pointer to the HW structure
+ * @mbx_id: Id of vf/fw to poll
+ *
+ * @return: 0 if it successfully received a message acknowledgment
+ **/
+static int mucse_poll_for_ack(struct mucse_hw *hw, enum MBX_ID mbx_id)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	int countdown = mbx->timeout;
+	int val;
+
+	if (!countdown || !mbx->ops.check_for_ack)
+		return -EIO;
+
+	return read_poll_timeout(mbx->ops.check_for_ack,
+				 val, val == 0, mbx->usec_delay,
+				 countdown * mbx->usec_delay,
+				 false, hw, mbx_id);
+}
+
+/**
+ * mucse_read_posted_mbx - Wait for message notification and receive message
+ * @hw: Pointer to the HW structure
+ * @msg: The message buffer
+ * @size: Length of buffer
+ * @mbx_id: Id of vf/fw to read
+ *
+ * @return: 0 if it successfully received a message notification and
+ * copied it into the receive buffer.
+ **/
+static int mucse_read_posted_mbx(struct mucse_hw *hw, u32 *msg, u16 size,
+				 enum MBX_ID mbx_id)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	int ret_val;
+
+	if (!mbx->ops.read)
+		return -EIO;
+
+	ret_val = mucse_poll_for_msg(hw, mbx_id);
+
+	/* if ack received read message, otherwise we timed out */
+	if (!ret_val)
+		ret_val = mbx->ops.read(hw, msg, size, mbx_id);
+
+	return ret_val;
+}
+
+/**
+ * mucse_write_posted_mbx - Write a message to the mailbox, wait for ack
+ * @hw: Pointer to the HW structure
+ * @msg: The message buffer
+ * @size: Length of buffer
+ * @mbx_id: Id of vf/fw to write
+ *
+ * @return: 0 if it successfully copied message into the buffer and
+ * received an ack to that message within delay * timeout period
+ **/
+static int mucse_write_posted_mbx(struct mucse_hw *hw, u32 *msg, u16 size,
+				  enum MBX_ID mbx_id)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	int ret_val;
+
+	/* exit if either we can't write or there isn't a defined timeout */
+	if (!mbx->ops.write || !mbx->timeout)
+		return -EIO;
+
+	/* send msg and hold buffer lock */
+	ret_val = mbx->ops.write(hw, msg, size, mbx_id);
+
+	/* if msg sent wait until we receive an ack */
+	if (!ret_val)
+		ret_val = mucse_poll_for_ack(hw, mbx_id);
+
+	return ret_val;
+}
+
+/**
+ * mucse_check_for_msg_pf - checks to see if the vf/fw has sent mail
+ * @hw: Pointer to the HW structure
+ * @mbx_id: Id of vf/fw to check
+ *
+ * @return: 0 if the vf/fw has set the Status bit or else
+ * -EIO
+ **/
+static int mucse_check_for_msg_pf(struct mucse_hw *hw,
+				  enum MBX_ID mbx_id)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	u16 hw_req_count = 0;
+	int ret_val = -EIO;
+
+	if (mbx_id == MBX_FW) {
+		hw_req_count = mucse_mbx_get_req(hw, FW2PF_COUNTER(mbx));
+		/* reg in hw should avoid 0 check */
+		if (mbx->mbx_feature & MBX_FEATURE_NO_ZERO) {
+			if (hw_req_count != 0 &&
+			    hw_req_count != hw->mbx.fw_req) {
+				ret_val = 0;
+				hw->mbx.stats.reqs++;
+			}
+		} else {
+			if (hw_req_count != hw->mbx.fw_req) {
+				ret_val = 0;
+				hw->mbx.stats.reqs++;
+			}
+		}
+	} else {
+		if (mucse_mbx_get_req(hw, VF2PF_COUNTER(mbx, mbx_id)) !=
+		    hw->mbx.vf_req[mbx_id]) {
+			ret_val = 0;
+			hw->mbx.stats.reqs++;
+		}
+	}
+
+	return ret_val;
+}
+
+/**
+ * mucse_check_for_ack_pf - checks to see if the VF has ACKed
+ * @hw: Pointer to the HW structure
+ * @mbx_id: Id of vf/fw to check
+ *
+ * @return: 0 if the vf/fw has set the Status bit or else
+ * -EIO
+ **/
+static int mucse_check_for_ack_pf(struct mucse_hw *hw, enum MBX_ID mbx_id)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	int ret_val = -EIO;
+	u16 hw_fw_ack;
+
+	if (mbx_id == MBX_FW) {
+		hw_fw_ack = mucse_mbx_get_ack(hw, FW2PF_COUNTER(mbx));
+		if (hw_fw_ack != 0 &&
+		    hw_fw_ack != hw->mbx.fw_ack) {
+			ret_val = 0;
+			hw->mbx.stats.acks++;
+		}
+	} else {
+		if (mucse_mbx_get_ack(hw, VF2PF_COUNTER(mbx, mbx_id)) !=
+		    hw->mbx.vf_ack[mbx_id]) {
+			ret_val = 0;
+			hw->mbx.stats.acks++;
+		}
+	}
+
+	return ret_val;
+}
+
+/**
+ * mucse_obtain_mbx_lock_pf - obtain mailbox lock
+ * @hw: pointer to the HW structure
+ * @mbx_id: Id of vf/fw to obtain
+ *
+ * This function maybe used in an irq handler.
+ *
+ * @return: 0 if we obtained the mailbox lock
+ **/
+static int mucse_obtain_mbx_lock_pf(struct mucse_hw *hw, enum MBX_ID mbx_id)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	int try_cnt = 5000, ret;
+	u32 reg;
+
+	reg = (mbx_id == MBX_FW) ? PF2FW_MBOX_CTRL(mbx) :
+				   PF2VF_MBOX_CTRL(mbx, mbx_id);
+	while (try_cnt-- > 0) {
+		/* Take ownership of the buffer */
+		mbx_wr32(hw, reg, MBOX_PF_HOLD);
+		/* force write back before check */
+		wmb();
+		if (mbx_rd32(hw, reg) & MBOX_PF_HOLD)
+			return 0;
+		udelay(100);
+	}
+	return ret;
+}
+
+/**
+ * mucse_write_mbx_pf - Places a message in the mailbox
+ * @hw: pointer to the HW structure
+ * @msg: The message buffer
+ * @size: Length of buffer
+ * @mbx_id: Id of vf/fw to write
+ *
+ * This function maybe used in an irq handler.
+ *
+ * @return: 0 if it successfully copied message into the buffer
+ **/
+static int mucse_write_mbx_pf(struct mucse_hw *hw, u32 *msg, u16 size,
+			      enum MBX_ID mbx_id)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	u32 data_reg, ctrl_reg;
+	int ret_val = 0;
+	u16 i;
+
+	data_reg = (mbx_id == MBX_FW) ? FW_PF_SHM_DATA(mbx) :
+					PF_VF_SHM_DATA(mbx, mbx_id);
+	ctrl_reg = (mbx_id == MBX_FW) ? PF2FW_MBOX_CTRL(mbx) :
+					PF2VF_MBOX_CTRL(mbx, mbx_id);
+	if (size > MUCSE_VFMAILBOX_SIZE)
+		return -EINVAL;
+
+	/* lock the mailbox to prevent pf/vf/fw race condition */
+	ret_val = mucse_obtain_mbx_lock_pf(hw, mbx_id);
+	if (ret_val)
+		goto out_no_write;
+
+	/* copy the caller specified message to the mailbox memory buffer */
+	for (i = 0; i < size; i++)
+		mbx_wr32(hw, data_reg + i * 4, msg[i]);
+
+	/* flush msg and acks as we are overwriting the message buffer */
+	if (mbx_id == MBX_FW) {
+		hw->mbx.fw_ack = mucse_mbx_get_ack(hw, FW2PF_COUNTER(mbx));
+	} else {
+		hw->mbx.vf_ack[mbx_id] =
+			mucse_mbx_get_ack(hw, VF2PF_COUNTER(mbx, mbx_id));
+	}
+	mucse_mbx_inc_pf_req(hw, mbx_id);
+
+	/* Interrupt VF/FW to tell it a message
+	 * has been sent and release buffer
+	 */
+	if (mbx->mbx_feature & MBX_FEATURE_WRITE_DELAY)
+		udelay(300);
+	mbx_wr32(hw, ctrl_reg, MBOX_CTRL_REQ);
+
+out_no_write:
+	return ret_val;
+}
+
+/**
+ * mucse_read_mbx_pf - Read a message from the mailbox
+ * @hw: pointer to the HW structure
+ * @msg: The message buffer
+ * @size: Length of buffer
+ * @mbx_id: Id of vf/fw to read
+ *
+ * This function copies a message from the mailbox buffer to the caller's
+ * memory buffer.  The presumption is that the caller knows that there was
+ * a message due to a vf/fw request so no polling for message is needed.
+ *
+ * @return: 0 on success, negative on failure
+ **/
+static int mucse_read_mbx_pf(struct mucse_hw *hw, u32 *msg, u16 size,
+			     enum MBX_ID mbx_id)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	u32 data_reg, ctrl_reg;
+	int ret_val;
+	u32 i;
+
+	data_reg = (mbx_id == MBX_FW) ? FW_PF_SHM_DATA(mbx) :
+					PF_VF_SHM_DATA(mbx, mbx_id);
+	ctrl_reg = (mbx_id == MBX_FW) ? PF2FW_MBOX_CTRL(mbx) :
+					PF2VF_MBOX_CTRL(mbx, mbx_id);
+
+	if (size > MUCSE_VFMAILBOX_SIZE)
+		return -EINVAL;
+	/* lock the mailbox to prevent pf/vf race condition */
+	ret_val = mucse_obtain_mbx_lock_pf(hw, mbx_id);
+	if (ret_val)
+		goto out_no_read;
+
+	/* we need this */
+	mb();
+	/* copy the message from the mailbox memory buffer */
+	for (i = 0; i < size; i++)
+		msg[i] = mbx_rd32(hw, data_reg + 4 * i);
+	mbx_wr32(hw, data_reg, 0);
+
+	/* update req */
+	if (mbx_id == MBX_FW) {
+		hw->mbx.fw_req = mucse_mbx_get_req(hw, FW2PF_COUNTER(mbx));
+	} else {
+		hw->mbx.vf_req[mbx_id] =
+			mucse_mbx_get_req(hw, VF2PF_COUNTER(mbx, mbx_id));
+	}
+	/* Acknowledge receipt and release mailbox, then we're done */
+	mucse_mbx_inc_pf_ack(hw, mbx_id);
+	/* free ownership of the buffer */
+	mbx_wr32(hw, ctrl_reg, 0);
+
+out_no_read:
+	return ret_val;
+}
+
+/**
+ * mucse_mbx_reset - reset mbx info, sync info from regs
+ * @hw: Pointer to the HW structure
+ *
+ * This function reset all mbx variables to default.
+ **/
+static void mucse_mbx_reset(struct mucse_hw *hw)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	int idx, v;
+
+	for (idx = 0; idx < hw->max_vfs; idx++) {
+		v = mbx_rd32(hw, VF2PF_COUNTER(mbx, idx));
+		hw->mbx.vf_req[idx] = v & GENMASK(15, 0);
+		hw->mbx.vf_ack[idx] = (v >> 16) & GENMASK(15, 0);
+		mbx_wr32(hw, PF2VF_MBOX_CTRL(mbx, idx), 0);
+	}
+	v = mbx_rd32(hw, FW2PF_COUNTER(mbx));
+	hw->mbx.fw_req = v & GENMASK(15, 0);
+	hw->mbx.fw_ack = (v >> 16) & GENMASK(15, 0);
+
+	mbx_wr32(hw, PF2FW_MBOX_CTRL(mbx), 0);
+
+	if (PF_VF_MBOX_MASK_LO(mbx))
+		mbx_wr32(hw, PF_VF_MBOX_MASK_LO(mbx), 0);
+	if (PF_VF_MBOX_MASK_HI(mbx))
+		mbx_wr32(hw, PF_VF_MBOX_MASK_HI(mbx), 0);
+
+	mbx_wr32(hw, FW_PF_MBOX_MASK(mbx), GENMASK(31, 16));
+}
+
+/**
+ * mucse_mbx_configure_pf - configure mbx to use nr_vec interrupt
+ * @hw: Pointer to the HW structure
+ * @nr_vec: Vector number for mbx
+ * @enable: TRUE for enable, FALSE for disable
+ *
+ * This function configure mbx to use interrupt nr_vec.
+ **/
+static void mucse_mbx_configure_pf(struct mucse_hw *hw, int nr_vec,
+				   bool enable)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	int idx = 0;
+	u32 v;
+
+	if (enable) {
+		for (idx = 0; idx < hw->max_vfs; idx++) {
+			v = mbx_rd32(hw, VF2PF_COUNTER(mbx, idx));
+			hw->mbx.vf_req[idx] = v & GENMASK(15, 0);
+			hw->mbx.vf_ack[idx] = (v >> 16) & GENMASK(15, 0);
+
+			mbx_wr32(hw, PF2VF_MBOX_CTRL(mbx, idx), 0);
+		}
+		v = mbx_rd32(hw, FW2PF_COUNTER(mbx));
+		hw->mbx.fw_req = v & GENMASK(15, 0);
+		hw->mbx.fw_ack = (v >> 16) & GENMASK(15, 0);
+		mbx_wr32(hw, PF2FW_MBOX_CTRL(mbx), 0);
+
+		for (idx = 0; idx < hw->max_vfs; idx++) {
+			/* vf to pf req interrupt */
+			mbx_wr32(hw, VF2PF_MBOX_VEC(mbx, idx),
+				 nr_vec);
+		}
+
+		if (PF_VF_MBOX_MASK_LO(mbx))
+			mbx_wr32(hw, PF_VF_MBOX_MASK_LO(mbx), 0);
+		/* allow vf to vectors */
+
+		if (PF_VF_MBOX_MASK_HI(mbx))
+			mbx_wr32(hw, PF_VF_MBOX_MASK_HI(mbx), 0);
+		/* enable irq */
+		/* bind fw mbx to irq */
+		mbx_wr32(hw, FW2PF_MBOX_VEC(mbx), nr_vec);
+		/* allow CM3FW to PF MBX IRQ */
+		mbx_wr32(hw, FW_PF_MBOX_MASK(mbx), GENMASK(31, 16));
+	} else {
+		if (PF_VF_MBOX_MASK_LO(mbx))
+			mbx_wr32(hw, PF_VF_MBOX_MASK_LO(mbx),
+				 GENMASK(31, 0));
+		/* disable irq */
+		if (PF_VF_MBOX_MASK_HI(mbx))
+			mbx_wr32(hw, PF_VF_MBOX_MASK_HI(mbx),
+				 GENMASK(31, 0));
+
+		/* disable CM3FW to PF MBX IRQ */
+		mbx_wr32(hw, FW_PF_MBOX_MASK(mbx), 0xfffffffe);
+
+		/* reset vf->pf status/ctrl */
+		for (idx = 0; idx < hw->max_vfs; idx++)
+			mbx_wr32(hw, PF2VF_MBOX_CTRL(mbx, idx), 0);
+		/* reset pf->cm3 ctrl */
+		mbx_wr32(hw, PF2FW_MBOX_CTRL(mbx), 0);
+		/* used to sync link status */
+		mbx_wr32(hw, RNPGBE_DMA_DUMY, 0);
+	}
+}
+
+/**
+ * mucse_init_mbx_params_pf - set initial values for pf mailbox
+ * @hw: pointer to the HW structure
+ *
+ * Initializes the hw->mbx struct to correct values for pf mailbox
+ */
+static void mucse_init_mbx_params_pf(struct mucse_hw *hw)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+
+	mbx->usec_delay = 100;
+	mbx->timeout = (4 * 1000 * 1000) / mbx->usec_delay;
+	mbx->stats.msgs_tx = 0;
+	mbx->stats.msgs_rx = 0;
+	mbx->stats.reqs = 0;
+	mbx->stats.acks = 0;
+	mbx->stats.rsts = 0;
+	mbx->size = MUCSE_VFMAILBOX_SIZE;
+
+	mutex_init(&mbx->lock);
+	mucse_mbx_reset(hw);
+}
+
+struct mucse_mbx_operations mucse_mbx_ops_generic = {
+	.init_params = mucse_init_mbx_params_pf,
+	.read = mucse_read_mbx_pf,
+	.write = mucse_write_mbx_pf,
+	.read_posted = mucse_read_posted_mbx,
+	.write_posted = mucse_write_posted_mbx,
+	.check_for_msg = mucse_check_for_msg_pf,
+	.check_for_ack = mucse_check_for_ack_pf,
+	.configure = mucse_mbx_configure_pf,
+};
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
new file mode 100644
index 000000000000..0b4183e53e61
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2020 - 2025 Mucse Corporation. */
+
+#ifndef _RNPGBE_MBX_H
+#define _RNPGBE_MBX_H
+
+#include "rnpgbe.h"
+
+/* 14 words */
+#define MUCSE_VFMAILBOX_SIZE 14
+/* ================ PF <--> VF mailbox ================ */
+#define SHARE_MEM_BYTES 64
+static inline u32 PF_VF_SHM(struct mucse_mbx_info *mbx, int vf)
+{
+	return mbx->pf_vf_shm_base + mbx->mbx_mem_size * vf;
+}
+
+#define PF2VF_COUNTER(mbx, vf) (PF_VF_SHM(mbx, vf) + 0)
+#define VF2PF_COUNTER(mbx, vf) (PF_VF_SHM(mbx, vf) + 4)
+#define PF_VF_SHM_DATA(mbx, vf) (PF_VF_SHM(mbx, vf) + 8)
+#define VF2PF_MBOX_VEC(mbx, vf) ((mbx)->vf2pf_mbox_vec_base + 4 * (vf))
+#define PF2VF_MBOX_CTRL(mbx, vf) ((mbx)->pf2vf_mbox_ctrl_base + 4 * (vf))
+#define PF_VF_MBOX_MASK_LO(mbx) ((mbx)->pf_vf_mbox_mask_lo)
+#define PF_VF_MBOX_MASK_HI(mbx) ((mbx)->pf_vf_mbox_mask_hi)
+/* ================ PF <--> FW mailbox ================ */
+#define FW_PF_SHM(mbx) ((mbx)->fw_pf_shm_base)
+#define FW2PF_COUNTER(mbx) (FW_PF_SHM(mbx) + 0)
+#define PF2FW_COUNTER(mbx) (FW_PF_SHM(mbx) + 4)
+#define FW_PF_SHM_DATA(mbx) (FW_PF_SHM(mbx) + 8)
+#define FW2PF_MBOX_VEC(mbx) ((mbx)->fw2pf_mbox_vec)
+#define PF2FW_MBOX_CTRL(mbx) ((mbx)->pf2fw_mbox_ctrl)
+#define FW_PF_MBOX_MASK(mbx) ((mbx)->fw_pf_mbox_mask)
+#define MBOX_CTRL_REQ BIT(0) /* WO */
+#define MBOX_PF_HOLD (BIT(3)) /* VF:RO, PF:WR */
+#define MBOX_IRQ_EN 0
+#define MBOX_IRQ_DISABLE 1
+#define mbx_rd32(hw, reg) m_rd_reg((hw)->hw_addr + (reg))
+#define mbx_wr32(hw, reg, val) m_wr_reg((hw)->hw_addr + (reg), (val))
+
+extern struct mucse_mbx_operations mucse_mbx_ops_generic;
+
+int mucse_read_mbx(struct mucse_hw *hw, u32 *msg, u16 size,
+		   enum MBX_ID mbx_id);
+int mucse_write_mbx(struct mucse_hw *hw, u32 *msg, u16 size,
+		    enum MBX_ID mbx_id);
+int mucse_check_for_msg(struct mucse_hw *hw, enum MBX_ID mbx_id);
+int mucse_check_for_ack(struct mucse_hw *hw, enum MBX_ID mbx_id);
+#endif /* _RNPGBE_MBX_H */
-- 
2.25.1


