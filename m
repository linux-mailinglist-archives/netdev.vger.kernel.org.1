Return-Path: <netdev+bounces-157083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D59A08DF9
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 11:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A080168529
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 10:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA0E20C00B;
	Fri, 10 Jan 2025 10:27:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9124020B7E0
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 10:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736504864; cv=none; b=im5MAEFjyUyb/3Bmo/OtmNW6YnVxhsHuHEe9wrfWJe5tH/C7l4J7pMT2XJH0jwbyYCSy/GwvmnRT0hrybwKKC8aY/uCKvDUfcshln5FNqq+P+OaEKloZofQgVXE3Kpjyg8y2SyoaohrZ3dNhx40JiApwTFj4QdeqtbEzt/tRg7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736504864; c=relaxed/simple;
	bh=7sOV3lnntCq35pD+vkNB2D3N/L9STrmRAfnwKUfM+JM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LJpYO0aTtCjNafCzhO6bUpYnjh0IkMgJJZaJmWxvL9JPP/NgKXWC3rT2Ck2d5SB+fFNj7ZJ7VlYIMI88zoZOK2v2YThPeQHXvxi3emqbfUXVWfWmQBXoD3C48/Ke2U7l/DzuueGN2zCvCEZPRqLiPuMvoq4/Ui6/mTibgV6556w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtp84t1736504844tws292ao
X-QQ-Originating-IP: 9ZGRFvj+eWhSSG1TekVzPmH575u6+KvOsKVHLlsDtas=
Received: from localhost.localdomain ( [218.72.126.41])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 10 Jan 2025 18:27:20 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10741761054053061271
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: helgaas@kernel.org,
	jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v6 1/6] net: libwx: Add malibox api for wangxun pf drivers
Date: Fri, 10 Jan 2025 18:27:00 +0800
Message-Id: <20250110102705.21846-2-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20250110102705.21846-1-mengyuanlou@net-swift.com>
References: <20250110102705.21846-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: Ngk7ShESHkQuU8xl0dUVvij4oQPfj5ZRD5QGrbREq9FcvJr7q7oB02KN
	AE1s+89gWrVTw0+8km3Hv1Vaw/3VMhYiMBFTnaZ1/4+Cp1A7MTANIXDKpmQwVHFbeFrnHWm
	ccXiLLEOnEUXq+jqU2dBM814t5aqGYrEwbbPC9eranHuNXNmn+6uvAtkP6S3XqVyeNtfeAT
	O4+vvQ0Rn9YZLFTY7HLvl9OTvjrLUvlLqzcgmGFh5MQP0EXy7/lReAZjYB1omkT84WNtXH+
	+w+NHdoXsgHsHwqWD4xtwyBeXyXzFE6XgLMN/stsZRma2NoE1P5DQLSoMC2yoHtg6XaimuI
	OZhwtXnbyji2sV6mXlq2PnZ+zm4WYcq6UKuOlGVe/ySIkP9BFBkMS34gWNt7DbSfE+rn2vl
	CUO5uCwOnqL3s4iXVawsBCnlNsGUX0ptCG9REnlLdXFAeSGnzvyNRewaVCqYRE1rmLv3u6a
	+31r+lrLAPvRREUX01n86+OO7sFDGMmedh/xINDRQhpXu5Eev8IjoctXray7PlB9DlRxG5g
	LVoZ7cAuFgYIOMi586w7cyiP+Il8WEGInrX+UOHpdMsi3Foan2k8nJWB2Hp5thWFXhaUTxY
	E7F2r+SZ64igN7hRr25WlrjB7KUVYESl0LViTvoPvDmMA+PTMh3N5vf9x4v0o21bSV9Q0iJ
	K5c+brWEz3zh5b6dTSuzi6Zn1bi4E+GDiEi7OydfWnVEXdUCsPp+bA6EfLbfM9IEdjOcf9c
	fZ/cmFPj1u9H5DGSvaeHUmrayUmKA6jG3qjG4ng7iwjBBKX5JFcl/wYrHXVRUqk4SnkntAl
	vd1eem8HCktbvtZreUBc5r7EKZ1n15j2+3k3Hxeg3DMH3xSosJWihMwErjNUvsWBJRd4X/F
	n9yCZtVq2dNAhS/5xQz6Hpkf62VbWYPZ+22lxNnXMosqJ8dxdtP16QznM4YeuU9wXlc5Rah
	af+yLH7m/Jg5dWNezTpsDb+tnvyfDripB1OEyRcXqQhsWpl8TjIRZG+tkw2hZ1pEgl4tkVF
	LTQbguIDGLQuf1n0JnpfIAVir2myKz1lTPfu2pzhijxwXWhu/KXi+lEd+iJ+0=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

Implements the mailbox interfaces for wangxun pf drivers
ngbe and txgbe.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 drivers/net/ethernet/wangxun/libwx/Makefile  |   2 +-
 drivers/net/ethernet/wangxun/libwx/wx_mbx.c  | 176 +++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_mbx.h  |  32 ++++
 drivers/net/ethernet/wangxun/libwx/wx_type.h |   8 +
 4 files changed, 217 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_mbx.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_mbx.h

diff --git a/drivers/net/ethernet/wangxun/libwx/Makefile b/drivers/net/ethernet/wangxun/libwx/Makefile
index 42ccd6e4052e..913a978c9032 100644
--- a/drivers/net/ethernet/wangxun/libwx/Makefile
+++ b/drivers/net/ethernet/wangxun/libwx/Makefile
@@ -4,4 +4,4 @@
 
 obj-$(CONFIG_LIBWX) += libwx.o
 
-libwx-objs := wx_hw.o wx_lib.o wx_ethtool.o
+libwx-objs := wx_hw.o wx_lib.o wx_ethtool.o wx_mbx.o
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_mbx.c b/drivers/net/ethernet/wangxun/libwx/wx_mbx.c
new file mode 100644
index 000000000000..73af5f11c3bd
--- /dev/null
+++ b/drivers/net/ethernet/wangxun/libwx/wx_mbx.c
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2015 - 2025 Beijing WangXun Technology Co., Ltd. */
+
+#include <linux/pci.h>
+#include "wx_type.h"
+#include "wx_mbx.h"
+
+/**
+ *  wx_obtain_mbx_lock_pf - obtain mailbox lock
+ *  @wx: pointer to the HW structure
+ *  @vf: the VF index
+ *
+ *  Return: return 0 on success and -EBUSY on failure
+ **/
+static int wx_obtain_mbx_lock_pf(struct wx *wx, u16 vf)
+{
+	int count = 5;
+	u32 mailbox;
+
+	while (count--) {
+		/* Take ownership of the buffer */
+		wr32(wx, WX_PXMAILBOX(vf), WX_PXMAILBOX_PFU);
+
+		/* reserve mailbox for vf use */
+		mailbox = rd32(wx, WX_PXMAILBOX(vf));
+		if (mailbox & WX_PXMAILBOX_PFU)
+			return 0;
+		else if (count)
+			udelay(10);
+	}
+	wx_err(wx, "Failed to obtain mailbox lock for PF%d", vf);
+
+	return -EBUSY;
+}
+
+static int wx_check_for_bit_pf(struct wx *wx, u32 mask, int index)
+{
+	u32 mbvficr = rd32(wx, WX_MBVFICR(index));
+
+	if (!(mbvficr & mask))
+		return -EBUSY;
+	wr32(wx, WX_MBVFICR(index), mask);
+
+	return 0;
+}
+
+/**
+ *  wx_check_for_ack_pf - checks to see if the VF has acked
+ *  @wx: pointer to the HW structure
+ *  @vf: the VF index
+ *
+ *  Return: return 0 if the VF has set the status bit or else -EBUSY
+ **/
+int wx_check_for_ack_pf(struct wx *wx, u16 vf)
+{
+	u32 index = vf / 16, vf_bit = vf % 16;
+
+	return wx_check_for_bit_pf(wx,
+				   FIELD_PREP(WX_MBVFICR_VFACK_MASK,
+					      BIT(vf_bit)),
+				   index);
+}
+
+/**
+ *  wx_check_for_msg_pf - checks to see if the VF has sent mail
+ *  @wx: pointer to the HW structure
+ *  @vf: the VF index
+ *
+ *  Return: return 0 if the VF has got req bit or else -EBUSY
+ **/
+int wx_check_for_msg_pf(struct wx *wx, u16 vf)
+{
+	u32 index = vf / 16, vf_bit = vf % 16;
+
+	return wx_check_for_bit_pf(wx,
+				   FIELD_PREP(WX_MBVFICR_VFREQ_MASK,
+					      BIT(vf_bit)),
+				   index);
+}
+
+/**
+ *  wx_write_mbx_pf - Places a message in the mailbox
+ *  @wx: pointer to the HW structure
+ *  @msg: The message buffer
+ *  @size: Length of buffer
+ *  @vf: the VF index
+ *
+ *  Return: return 0 on success and -EINVAL/-EBUSY on failure
+ **/
+int wx_write_mbx_pf(struct wx *wx, u32 *msg, u16 size, u16 vf)
+{
+	struct wx_mbx_info *mbx = &wx->mbx;
+	int ret, i;
+
+	/* mbx->size is up to 15 */
+	if (size > mbx->size) {
+		wx_err(wx, "Invalid mailbox message size %d", size);
+		return -EINVAL;
+	}
+
+	/* lock the mailbox to prevent pf/vf race condition */
+	ret = wx_obtain_mbx_lock_pf(wx, vf);
+	if (ret)
+		return ret;
+
+	/* flush msg and acks as we are overwriting the message buffer */
+	wx_check_for_msg_pf(wx, vf);
+	wx_check_for_ack_pf(wx, vf);
+
+	/* copy the caller specified message to the mailbox memory buffer */
+	for (i = 0; i < size; i++)
+		wr32a(wx, WX_PXMBMEM(vf), i, msg[i]);
+
+	/* Interrupt VF to tell it a message has been sent and release buffer */
+	/* set mirrored mailbox flags */
+	wr32a(wx, WX_PXMBMEM(vf), WX_VXMAILBOX_SIZE, WX_PXMAILBOX_STS);
+	wr32(wx, WX_PXMAILBOX(vf), WX_PXMAILBOX_STS);
+
+	return 0;
+}
+
+/**
+ *  wx_read_mbx_pf - Read a message from the mailbox
+ *  @wx: pointer to the HW structure
+ *  @msg: The message buffer
+ *  @size: Length of buffer
+ *  @vf: the VF index
+ *
+ *  Return: return 0 on success and -EBUSY on failure
+ **/
+int wx_read_mbx_pf(struct wx *wx, u32 *msg, u16 size, u16 vf)
+{
+	struct wx_mbx_info *mbx = &wx->mbx;
+	int ret;
+	u16 i;
+
+	/* limit read to size of mailbox and mbx->size is up to 15 */
+	if (size > mbx->size)
+		size = mbx->size;
+
+	/* lock the mailbox to prevent pf/vf race condition */
+	ret = wx_obtain_mbx_lock_pf(wx, vf);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < size; i++)
+		msg[i] = rd32a(wx, WX_PXMBMEM(vf), i);
+
+	/* Acknowledge the message and release buffer */
+	/* set mirrored mailbox flags */
+	wr32a(wx, WX_PXMBMEM(vf), WX_VXMAILBOX_SIZE, WX_PXMAILBOX_ACK);
+	wr32(wx, WX_PXMAILBOX(vf), WX_PXMAILBOX_ACK);
+
+	return 0;
+}
+
+/**
+ *  wx_check_for_rst_pf - checks to see if the VF has reset
+ *  @wx: pointer to the HW structure
+ *  @vf: the VF index
+ *
+ *  Return: return 0 on success and -EBUSY on failure
+ **/
+int wx_check_for_rst_pf(struct wx *wx, u16 vf)
+{
+	u32 reg_offset = WX_VF_REG_OFFSET(vf);
+	u32 vf_shift = WX_VF_IND_SHIFT(vf);
+	u32 vflre = 0;
+
+	vflre = rd32(wx, WX_VFLRE(reg_offset));
+	if (!(vflre & BIT(vf_shift)))
+		return -EBUSY;
+	wr32(wx, WX_VFLREC(reg_offset), BIT(vf_shift));
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_mbx.h b/drivers/net/ethernet/wangxun/libwx/wx_mbx.h
new file mode 100644
index 000000000000..c09b25f3e43d
--- /dev/null
+++ b/drivers/net/ethernet/wangxun/libwx/wx_mbx.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2015 - 2025 Beijing WangXun Technology Co., Ltd. */
+#ifndef _WX_MBX_H_
+#define _WX_MBX_H_
+
+#define WX_VXMAILBOX_SIZE    15
+
+/* PF Registers */
+#define WX_PXMAILBOX(i)      (0x600 + (4 * (i))) /* i=[0,63] */
+#define WX_PXMAILBOX_STS     BIT(0) /* Initiate message send to VF */
+#define WX_PXMAILBOX_ACK     BIT(1) /* Ack message recv'd from VF */
+#define WX_PXMAILBOX_PFU     BIT(3) /* PF owns the mailbox buffer */
+
+#define WX_PXMBMEM(i)        (0x5000 + (64 * (i))) /* i=[0,63] */
+
+#define WX_VFLRE(i)          (0x4A0 + (4 * (i))) /* i=[0,1] */
+#define WX_VFLREC(i)         (0x4A8 + (4 * (i))) /* i=[0,1] */
+
+/* SR-IOV specific macros */
+#define WX_MBVFICR(i)         (0x480 + (4 * (i))) /* i=[0,3] */
+#define WX_MBVFICR_VFREQ_MASK GENMASK(15, 0)
+#define WX_MBVFICR_VFACK_MASK GENMASK(31, 16)
+
+#define WX_VT_MSGINFO_MASK    GENMASK(23, 16)
+
+int wx_write_mbx_pf(struct wx *wx, u32 *msg, u16 size, u16 vf);
+int wx_read_mbx_pf(struct wx *wx, u32 *msg, u16 size, u16 vf);
+int wx_check_for_rst_pf(struct wx *wx, u16 mbx_id);
+int wx_check_for_msg_pf(struct wx *wx, u16 mbx_id);
+int wx_check_for_ack_pf(struct wx *wx, u16 mbx_id);
+
+#endif /* _WX_MBX_H_ */
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index b54bffda027b..5dce136c98bd 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -20,6 +20,9 @@
 #define WX_PCI_LINK_STATUS                      0xB2
 
 /**************** Global Registers ****************************/
+#define WX_VF_REG_OFFSET(_v)         ((_v) >> 5)
+#define WX_VF_IND_SHIFT(_v)          ((_v) & 0x1f)
+
 /* chip control Registers */
 #define WX_MIS_PWR                   0x10000
 #define WX_MIS_RST                   0x1000C
@@ -707,6 +710,10 @@ struct wx_bus_info {
 	u16 device;
 };
 
+struct wx_mbx_info {
+	u16 size;
+};
+
 struct wx_thermal_sensor_data {
 	s16 temp;
 	s16 alarm_thresh;
@@ -1046,6 +1053,7 @@ struct wx {
 	struct pci_dev *pdev;
 	struct net_device *netdev;
 	struct wx_bus_info bus;
+	struct wx_mbx_info mbx;
 	struct wx_mac_info mac;
 	enum em_mac_type mac_type;
 	enum sp_media_type media_type;
-- 
2.30.1 (Apple Git-130)


