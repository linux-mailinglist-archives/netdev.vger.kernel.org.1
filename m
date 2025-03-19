Return-Path: <netdev+bounces-176012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3390A685E2
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 08:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 024F87AAB3F
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 07:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62EE2500BC;
	Wed, 19 Mar 2025 07:38:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE7524EF86
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 07:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742369918; cv=none; b=nNL94HFSbOjVY21YUs8gpVY2muZHC7vJ/P9EWwv98ZdE7/I0bqvrKbGIvyg3v02P3nBNXPjK7AtT2OfoRkAxBdJr03FXJ0ol4rhwsCi8E9pRQqe2bCLSW3OlmmT9k7E2cBD2KNWFoWLVIWl/2KVQnuNQarhrllojtqVPqZN4Ql8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742369918; c=relaxed/simple;
	bh=vonyUNNLTOX2+ULHcPkFzCbjVig7weYuDDOsbKrIKFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R3Vz5I+1mFDZThpVWkOJQf4eIGJ+1jAVE6dweKWSPwLz0wZ9svC0Yg04XZMYIbS56Tt9kJ8JY778j+9ZrC9ZQ1VIjzSc1ji4Zxk4BP9DznW3myje9PrXloc4gkK/pByHOLBS3hfJ0TKg4sL4htuNCIHUgoL3AxypHo5ZrK7P++A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtp88t1742369879t5f3sdku
X-QQ-Originating-IP: A3417B1M3bJ2dfBmV9YUvP9eDTr83a5OvT73tnkGgQE=
Received: from localhost.localdomain ( [60.186.240.18])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 19 Mar 2025 15:37:55 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4020864661333984318
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	horms@kernel.org,
	jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v9 1/6] net: libwx: Add mailbox api for wangxun pf drivers
Date: Wed, 19 Mar 2025 15:33:51 +0800
Message-ID: <A4E84627FBC9C9D3+20250319073356.55085-2-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250319073356.55085-1-mengyuanlou@net-swift.com>
References: <20250319073356.55085-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NRfl6k/eYe7Aq4LxxGmw1LxcmvUgNNTtumT3nYPWMEqycDy9Kqv6NDwj
	n3snyRGyn2mxXY8Yudks/ac6mLvi39ZggXTNxRzZ5Fzscj7j3jDi2OXjLyxLER+jCVbg5iN
	y9U+N4ZL65bNRiWkTTLtK3r99jHccBWRz90q4bCntG176AWp8YqSFMZ3k5hjF+1hO6LCfFx
	aCz3ymVccEzFxAJQkc2QvmZ09FGaUBK2IJBPzA79ZbOGKL8RrtrTvgnZ4ZOi3e9pR7UqO+4
	gxR5ktCXKcreMAeK7tI7xFwnb0pItyT5vg+2iJeD8JME92HBgG7RUS/DoXgknE939R3kNIv
	oHLZJl5dxQXOYQ7hHfq13QpqRwj+0N9Kpk0lJ8Ai3NcKCrgBnHutAju5A6IcWWq1h9GxkSn
	waYVX/sS2Xh6Oe5n5M5xirChSeDHqNbX/BGPGxaJO+SAEBA6y54l9twvZeSJsxIoHRWLjBD
	5jRXs3/RKphDHpzhZaGYs9tSfLgmrALRNC/f8FKps97W/wgq5zVRn4qJFvX0nPdsU3k9Z5r
	uGALD8Yb/iaTKBvV7GBY1dfwqp/7egdG6ww0gHFUOxIYL/1bHeevWg3lR9mOrCcS9QyioOj
	aG2r9LDUYaiHe4i5HEN1DBeMbeJ1Hs/jl9hlTCiivGi3s90nkTiX+YrsWGvM+1QDcJhI8nC
	jMaRBw+MYVQ4+gk73Cxe9L54JjsUZQ945syx9EnI3z0cleLboAU5kCliovP9owzDAKADOde
	tUIt6Waf1KtQt8wfqtLRg4MuvgzKEMt+kRckncQl/oTO6TweHVR4u3YDYLZpibsLtbqMxMw
	qCnRlS3LOhcvArzEqVV8AaNSWTWcnlgqqBNsfKjv0quAZP0PzgbDQFEW/dSyLtp/aEM95HF
	MA0i8Ob7SsyyobeoFi23jT2mg9z0/wPp6nWiIy4Jt2esc9+VvAZ+CYyMQj45P+pJAhwQwmO
	SECee+b0ImuoW7Wp0d3hAJD5eFt7kIPszNzqeLNE4ffLz/ZqMRizpDA9WgKH0y4O3XOFR2O
	qhZ3xEQBs6xvhaCGsh
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
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
2.48.1



