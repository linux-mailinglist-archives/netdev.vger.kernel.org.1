Return-Path: <netdev+bounces-173321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8990DA58571
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 16:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72A2D7A5396
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 15:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDC11DE4F8;
	Sun,  9 Mar 2025 15:43:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3421DE4E6
	for <netdev@vger.kernel.org>; Sun,  9 Mar 2025 15:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741535034; cv=none; b=IFReCIPW9p/x7Q6puwBST1ekoos4Sp2C/xRGpe6rjk9CXFYwgbHwofaDEkqQk0vMoV01Qu7aZ4swIL1WEzqZ5p+hG/I7hJAqBKOkEfFlF8wvOj7DBGSPWX9hO3HptJouv/Jpr3PgSo1JqnemkF+TqS0bWqsGxMtIu7+HXux0wfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741535034; c=relaxed/simple;
	bh=HNbix4NGu7ZQOPjpvjcPivtPDhDBNYLcu3wNgiQU4s0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X54+K3oqywG/DQ4PNZM7K7deINDcoyEr14P826/428OQ9t8nHP8PE+iztzgoxaQjVR32/uTkfWa5qAEDl1jPQUrGyZO3hpvzlMy6+ivTmzDd61ESM+rCu+8JJCSzwOcdmaemc7Js1RG2jVRmEPfBKhTs6aPWqDzmOgzHf34Wbck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtpsz5t1741534994t0k7rix
X-QQ-Originating-IP: Jk+B7enUFHktIfVOR1LWVad33Y30+7EpifQRIqvfPOc=
Received: from localhost.localdomain ( [122.224.83.35])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 09 Mar 2025 23:43:09 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5037604368786541831
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v8 1/6] net: libwx: Add mailbox api for wangxun pf drivers
Date: Sun,  9 Mar 2025 23:42:47 +0800
Message-Id: <20250309154252.79234-2-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20250309154252.79234-1-mengyuanlou@net-swift.com>
References: <20250309154252.79234-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: No4GWyI4cWt6PGeyOVR+RdDzPj6+ennM4Q5jP7V/CtgQeDV/4MMcN7ap
	MLEmqoUu/v21EgH25DV73fLhvr4kSTBpfxiyZz5+hxRxCANu0qjxLdLv+VPlCVJzqdgvC4/
	VMq/6kWl0UxTx75mRDDzdH4ZHqK93CqhgjjjoQoXdzktreuojf3X3yJ2p+1K+uqJGAgi6Vw
	EjbsI+QPn+fFUzqEi4qvo9Tyg3xeq9wVG1bSUra4HibLBfQ8keySWTPzUlCvPCxAQgWatLu
	rv4yPliGbEroH3eC9hh1sWGUbBHp/dYnT6HJ2GoDFigCZmi87iY2RwBjaHIDWQk73ChZjKX
	IJ3EgjCpcEtaU9VGsemKBx9EIP+EC7A6mCRXKgHdeDBhyEZvRQMzVPUl1c3Sek4KE9nVNPl
	5g17yTEqbXr+HonNwVJrlF6vU+VnEDyvNGBPR+qc7i7P2B/XnZHhcrE4kvjcUk0W6DRXtZ3
	XLsI/WTjZcoccbsVL7I8X1Jx4gzBt7yF+ieXEhfsJwUO9NP3gqMzRyx3MNlrG/zvHzCxxqu
	MzRxhgascp7BW+ZWAzxVvPcd1/jrQNaeNCI5rGPfIcLOa1724seEaj0vEOMmVtgvsNEHBD4
	kjF8tuO3BcIFzje6XxbjxhqsheCgntSZWG9Oqs2LB5UcLmB4dBaTg9eiV9vOIEzSWhkW4MW
	vTkchDQKSYs4XcdDasGSvD/8HHRGGgJKXxEKbd1R94XjVMkqKZBKgSugXpS8aIhPffBoqmo
	fGdWhWqtmrg46k4DRgLHi2YDWtz2kju4SD/ZQNTX8xNQjkoVtJ0/20M69NYC9jx7bL8Dd1n
	FS3+81MB/1DekYbe3D8QiKmBNIg0doZm1NcPRPI4F4Uca/A2ENIb3SC0XMtMW8CZZRuQcjA
	njxW25bHUsg3Ff62FItMSw+ZTKp2Ynfy8EIFQq5zkSBzIuLG8oPjTSFPPmjP9TjDaeFQZ/v
	f9bj8iPZd0oHDCtrJ10ihBcqfhQBJujfZLXaHufM7Cysv6MuLBp2mamWsOdEAq2A2XNmZvI
	eik+iMrZ4c2vbfsK4O2UoyGPJ4s1SXgxjkpilYFg==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
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
index e9f0f1f2309b..cd1675ef3253 100644
--- a/drivers/net/ethernet/wangxun/libwx/Makefile
+++ b/drivers/net/ethernet/wangxun/libwx/Makefile
@@ -4,4 +4,4 @@
 
 obj-$(CONFIG_LIBWX) += libwx.o
 
-libwx-objs := wx_hw.o wx_lib.o wx_ethtool.o wx_ptp.o
+libwx-objs := wx_hw.o wx_lib.o wx_ethtool.o wx_ptp.o wx_mbx.o
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
index 5b230ecbbabb..18287b0ee040 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -22,6 +22,9 @@
 #define WX_PCI_LINK_STATUS                      0xB2
 
 /**************** Global Registers ****************************/
+#define WX_VF_REG_OFFSET(_v)         FIELD_GET(GENMASK(15, 5), (_v))
+#define WX_VF_IND_SHIFT(_v)          FIELD_GET(GENMASK(4, 0), (_v))
+
 /* chip control Registers */
 #define WX_MIS_PWR                   0x10000
 #define WX_MIS_RST                   0x1000C
@@ -779,6 +782,10 @@ struct wx_bus_info {
 	u16 device;
 };
 
+struct wx_mbx_info {
+	u16 size;
+};
+
 struct wx_thermal_sensor_data {
 	s16 temp;
 	s16 alarm_thresh;
@@ -1129,6 +1136,7 @@ struct wx {
 	struct pci_dev *pdev;
 	struct net_device *netdev;
 	struct wx_bus_info bus;
+	struct wx_mbx_info mbx;
 	struct wx_mac_info mac;
 	enum em_mac_type mac_type;
 	enum sp_media_type media_type;
-- 
2.30.1 (Apple Git-130)


