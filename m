Return-Path: <netdev+bounces-204109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41402AF8F22
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 11:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A82221CA4A12
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 09:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99412ECD0E;
	Fri,  4 Jul 2025 09:51:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC3128D840
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 09:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751622696; cv=none; b=jq9KWP10DUbhL4HUGaf6dJmmKTyQ51kq3mybcSpRe+IwfJL8nIGxPmAmayV2R+Untnfg51lyxjIUVvBTRdm1TpjHRKMnurossjicoPMjfvYPl2GxY/IbSgapD1tStN5jReic6n7Pc+S+8DOlKjT1VRuACZVsD+ZLHdwoqcVbcO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751622696; c=relaxed/simple;
	bh=HkX5vAhKO0vga2Y1gYBg9eGiMSZH2pbhOx9Hh5FAmfo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cGYdCvilgXUuFGcc3A2HAzZunzcYtyJQppA4rBEmZZVRYkUDvlF5OTxx5NZT6oqxpiVfTmmWjwJBg5ZwqWYJvQUwdX2dKIAfkiRjv7sYuMmr2H0bbLMd4dVQooq6G3BBnZnqMadMvD+jk1v3AHxbWV50Jeisildeyf4fqxKwVYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: zesmtpsz1t1751622585t86a10356
X-QQ-Originating-IP: /Dk+7C+kNKeRo1XfIYhD4t5rgz6t8bnFY5mC7TqC2NE=
Received: from localhost.localdomain ( [156.146.53.122])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 04 Jul 2025 17:49:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3345656786001519153
EX-QQ-RecipientCnt: 10
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: michal.swiatkowski@linux.intel.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	duanqiangwen@net-swift.com,
	linglingzhang@trustnetic.com,
	jiawenwu@trustnetic.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v3 01/12] net: libwx: add mailbox api for wangxun vf drivers
Date: Fri,  4 Jul 2025 17:49:12 +0800
Message-Id: <20250704094923.652-2-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20250704094923.652-1-mengyuanlou@net-swift.com>
References: <20250704094923.652-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: Mq6ny5wK3Q6gPJnnGKMQF0TbJgCWVM6YYOtR4QVz3/QNKT1JCgge8Qcx
	qXnUv0t/vt/IiHSXcCiYXW9NTwwVHGkbLBUzam4H2Gj8cVfID7RdR1oPH7zgrKIyIMi0ntQ
	QxecCBSxugHj7PrHTc4dlGNa/ps9qGXgBxlQej1DvGlEmGH8vWOZRRGJFxHH38WMHfgnJg+
	1UTOyHKHEs7qfC/Uq0Z7mEgE5ZJv84zaHgbIp6xENouFO+eN0NHqo4dPJyY1yH2Vj0W3RzO
	ByRayM6MKIo3bT23jQs9/0rZjgCegVL0VkrCZRpTNe9uEqyvwHQQq6Oq+MwQQlykBOSwJAz
	2tc6ggg3FLPkf2Y96dXGVJPjNN2dQ7kzi3IFj4QvNB3ZxgI6KuyfANRvz6PNygWNzJ+Rct9
	Gh+9sQ2MWOQHkRomqEub5WAcf4cH7u+H5DWAk8gYlFS4iK18mj0SBnVue5nnjdltEToAQzA
	fqGKHsGlad9jIWn7y7H9O0RmRpW1HYXHL//Pcqg6P9epafCKUcxFG2B8wZjeO5xGAwnFeWr
	q6vmljdZyiYUWjcSjPYc7AxAxJRvBiSk7icbJImoM2BWddfXc/qEsJksiWtm6g32oLcb16+
	KuNPD9ZhJxfHZVAzlMiTrfoHBeKScG8UGgLy02EKg/B7W0n70noGA0mnFUt+9VvkKs1MsaG
	rEYzva8FSWCy1pB9UkRfSNT0SXflAd2+u/r318lCuwfglo7Huc8cxWXI6SgdUHeG/tB9IVG
	+KqfFn96G016IW5Vlj1OYJGrPzmsiE2j4VBgZSUd7TliFE5dsPcgRGLAkeVVKwyUKaQ0a16
	cEkctq5g/EYAxomEnclj+qWhgEVZgBafdSGFt4QuNgySXwSZPJ2ewF1p+xLcHv3YwvRSoB/
	haDti1jsnbQrC2ORRNO4BDO6BRdWoifATnKp1ymHA7J/ylwz05hhYdTrCAiv54Hj4NqMM1b
	qr1PYirf43riBp81vAA2L++D7DevK27whOUBUu+kJmIWEv+CBOcbB6ejWrB+eBvNXYAh8Wy
	zUGqZzxo0oAJ9c+QRmNdTiJopX/qfC59dQkX0L1SB8SB+8HGdE+VsVCYjyTSV59hgmgGJEs
	0atnm7BxeHYgMSWcNifTIaCtuD/W82UHq7iLlj20hGD9Dh6xqaY0PuWZoPPbzWYsw==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

Implements the mailbox interfaces for Wangxun vf drivers which
will be used in txgbevf and ngbevf.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_mbx.c  | 243 +++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_mbx.h  |  22 ++
 drivers/net/ethernet/wangxun/libwx/wx_type.h |   3 +
 3 files changed, 268 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_mbx.c b/drivers/net/ethernet/wangxun/libwx/wx_mbx.c
index 73af5f11c3bd..2aa03eadf064 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_mbx.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_mbx.c
@@ -174,3 +174,246 @@ int wx_check_for_rst_pf(struct wx *wx, u16 vf)
 
 	return 0;
 }
+
+static u32 wx_read_v2p_mailbox(struct wx *wx)
+{
+	u32 mailbox = rd32(wx, WX_VXMAILBOX);
+
+	mailbox |= wx->mbx.mailbox;
+	wx->mbx.mailbox |= mailbox & WX_VXMAILBOX_R2C_BITS;
+
+	return mailbox;
+}
+
+static u32 wx_mailbox_get_lock_vf(struct wx *wx)
+{
+	wr32(wx, WX_VXMAILBOX, WX_VXMAILBOX_VFU);
+	return wx_read_v2p_mailbox(wx);
+}
+
+/**
+ *  wx_obtain_mbx_lock_vf - obtain mailbox lock
+ *  @wx: pointer to the HW structure
+ *
+ *  Return: return 0 on success and -EBUSY on failure
+ **/
+static int wx_obtain_mbx_lock_vf(struct wx *wx)
+{
+	int count = 5, ret;
+	u32 mailbox;
+
+	ret = readx_poll_timeout_atomic(wx_mailbox_get_lock_vf, wx, mailbox,
+					(mailbox & WX_VXMAILBOX_VFU),
+					1, count);
+	if (ret)
+		wx_err(wx, "Failed to obtain mailbox lock for VF.\n");
+
+	return ret;
+}
+
+static int wx_check_for_bit_vf(struct wx *wx, u32 mask)
+{
+	u32 mailbox = wx_read_v2p_mailbox(wx);
+
+	wx->mbx.mailbox &= ~mask;
+
+	return (mailbox & mask ? 0 : -EBUSY);
+}
+
+/**
+ *  wx_check_for_ack_vf - checks to see if the PF has ACK'd
+ *  @wx: pointer to the HW structure
+ *
+ *  Return: return 0 if the PF has set the status bit or else -EBUSY
+ **/
+static int wx_check_for_ack_vf(struct wx *wx)
+{
+	/* read clear the pf ack bit */
+	return wx_check_for_bit_vf(wx, WX_VXMAILBOX_PFACK);
+}
+
+/**
+ *  wx_check_for_msg_vf - checks to see if the PF has sent mail
+ *  @wx: pointer to the HW structure
+ *
+ *  Return: return 0 if the PF has got req bit or else -EBUSY
+ **/
+int wx_check_for_msg_vf(struct wx *wx)
+{
+	/* read clear the pf sts bit */
+	return wx_check_for_bit_vf(wx, WX_VXMAILBOX_PFSTS);
+}
+
+/**
+ *  wx_check_for_rst_vf - checks to see if the PF has reset
+ *  @wx: pointer to the HW structure
+ *
+ *  Return: return 0 if the PF has set the reset done and -EBUSY on failure
+ **/
+int wx_check_for_rst_vf(struct wx *wx)
+{
+	/* read clear the pf reset done bit */
+	return wx_check_for_bit_vf(wx,
+				   WX_VXMAILBOX_RSTD |
+				   WX_VXMAILBOX_RSTI);
+}
+
+/**
+ *  wx_poll_for_msg - Wait for message notification
+ *  @wx: pointer to the HW structure
+ *
+ *  Return: return 0 if the VF has successfully received a message notification
+ **/
+static int wx_poll_for_msg(struct wx *wx)
+{
+	struct wx_mbx_info *mbx = &wx->mbx;
+	u32 val;
+
+	return readx_poll_timeout_atomic(wx_check_for_msg_vf, wx, val,
+					 (val == 0), mbx->udelay, mbx->timeout);
+}
+
+/**
+ *  wx_poll_for_ack - Wait for message acknowledgment
+ *  @wx: pointer to the HW structure
+ *
+ *  Return: return 0 if the VF has successfully received a message ack
+ **/
+static int wx_poll_for_ack(struct wx *wx)
+{
+	struct wx_mbx_info *mbx = &wx->mbx;
+	u32 val;
+
+	return readx_poll_timeout_atomic(wx_check_for_ack_vf, wx, val,
+					 (val == 0), mbx->udelay, mbx->timeout);
+}
+
+/**
+ *  wx_read_posted_mbx - Wait for message notification and receive message
+ *  @wx: pointer to the HW structure
+ *  @msg: The message buffer
+ *  @size: Length of buffer
+ *
+ *  Return: returns 0 if it successfully received a message notification and
+ *  copied it into the receive buffer.
+ **/
+int wx_read_posted_mbx(struct wx *wx, u32 *msg, u16 size)
+{
+	int ret;
+
+	ret = wx_poll_for_msg(wx);
+	/* if ack received read message, otherwise we timed out */
+	if (ret)
+		return ret;
+
+	return wx_read_mbx_vf(wx, msg, size);
+}
+
+/**
+ *  wx_write_posted_mbx - Write a message to the mailbox, wait for ack
+ *  @wx: pointer to the HW structure
+ *  @msg: The message buffer
+ *  @size: Length of buffer
+ *
+ *  Return: returns 0 if it successfully copied message into the buffer and
+ *  received an ack to that message within delay * timeout period
+ **/
+int wx_write_posted_mbx(struct wx *wx, u32 *msg, u16 size)
+{
+	int ret;
+
+	/* send msg */
+	ret = wx_write_mbx_vf(wx, msg, size);
+	/* if msg sent wait until we receive an ack */
+	if (ret)
+		return ret;
+
+	return wx_poll_for_ack(wx);
+}
+
+/**
+ *  wx_write_mbx_vf - Write a message to the mailbox
+ *  @wx: pointer to the HW structure
+ *  @msg: The message buffer
+ *  @size: Length of buffer
+ *
+ *  Return: returns 0 if it successfully copied message into the buffer
+ **/
+int wx_write_mbx_vf(struct wx *wx, u32 *msg, u16 size)
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
+	ret = wx_obtain_mbx_lock_vf(wx);
+	if (ret)
+		return ret;
+
+	/* flush msg and acks as we are overwriting the message buffer */
+	wx_check_for_msg_vf(wx);
+	wx_check_for_ack_vf(wx);
+
+	/* copy the caller specified message to the mailbox memory buffer */
+	for (i = 0; i < size; i++)
+		wr32a(wx, WX_VXMBMEM, i, msg[i]);
+
+	/* Drop VFU and interrupt the PF to tell it a message has been sent */
+	wr32(wx, WX_VXMAILBOX, WX_VXMAILBOX_REQ);
+
+	return 0;
+}
+
+/**
+ *  wx_read_mbx_vf - Reads a message from the inbox intended for vf
+ *  @wx: pointer to the HW structure
+ *  @msg: The message buffer
+ *  @size: Length of buffer
+ *
+ *  Return: returns 0 if it successfully copied message into the buffer
+ **/
+int wx_read_mbx_vf(struct wx *wx, u32 *msg, u16 size)
+{
+	struct wx_mbx_info *mbx = &wx->mbx;
+	int ret, i;
+
+	/* limit read to size of mailbox and mbx->size is up to 15 */
+	if (size > mbx->size)
+		size = mbx->size;
+
+	/* lock the mailbox to prevent pf/vf race condition */
+	ret = wx_obtain_mbx_lock_vf(wx);
+	if (ret)
+		return ret;
+
+	/* copy the message from the mailbox memory buffer */
+	for (i = 0; i < size; i++)
+		msg[i] = rd32a(wx, WX_VXMBMEM, i);
+
+	/* Acknowledge receipt and release mailbox, then we're done */
+	wr32(wx, WX_VXMAILBOX, WX_VXMAILBOX_ACK);
+
+	return 0;
+}
+
+int wx_init_mbx_params_vf(struct wx *wx)
+{
+	wx->vfinfo = kzalloc(sizeof(struct vf_data_storage),
+			     GFP_KERNEL);
+	if (!wx->vfinfo)
+		return -ENOMEM;
+
+	/* Initialize mailbox parameters */
+	wx->mbx.size = WX_VXMAILBOX_SIZE;
+	wx->mbx.mailbox = WX_VXMAILBOX;
+	wx->mbx.udelay = 10;
+	wx->mbx.timeout = 1000;
+
+	return 0;
+}
+EXPORT_SYMBOL(wx_init_mbx_params_vf);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_mbx.h b/drivers/net/ethernet/wangxun/libwx/wx_mbx.h
index 05aae138dbc3..82df9218490a 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_mbx.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_mbx.h
@@ -11,6 +11,20 @@
 #define WX_PXMAILBOX_ACK     BIT(1) /* Ack message recv'd from VF */
 #define WX_PXMAILBOX_PFU     BIT(3) /* PF owns the mailbox buffer */
 
+/* VF Registers */
+#define WX_VXMAILBOX         0x600
+#define WX_VXMAILBOX_REQ     BIT(0) /* Request for PF Ready bit */
+#define WX_VXMAILBOX_ACK     BIT(1) /* Ack PF message received */
+#define WX_VXMAILBOX_VFU     BIT(2) /* VF owns the mailbox buffer */
+#define WX_VXMAILBOX_PFU     BIT(3) /* PF owns the mailbox buffer */
+#define WX_VXMAILBOX_PFSTS   BIT(4) /* PF wrote a message in the MB */
+#define WX_VXMAILBOX_PFACK   BIT(5) /* PF ack the previous VF msg */
+#define WX_VXMAILBOX_RSTI    BIT(6) /* PF has reset indication */
+#define WX_VXMAILBOX_RSTD    BIT(7) /* PF has indicated reset done */
+#define WX_VXMAILBOX_R2C_BITS (WX_VXMAILBOX_RSTD | \
+	    WX_VXMAILBOX_PFSTS | WX_VXMAILBOX_PFACK)
+
+#define WX_VXMBMEM           0x00C00 /* 16*4B */
 #define WX_PXMBMEM(i)        (0x5000 + (64 * (i))) /* i=[0,63] */
 
 #define WX_VFLRE(i)          (0x4A0 + (4 * (i))) /* i=[0,1] */
@@ -74,4 +88,12 @@ int wx_check_for_rst_pf(struct wx *wx, u16 mbx_id);
 int wx_check_for_msg_pf(struct wx *wx, u16 mbx_id);
 int wx_check_for_ack_pf(struct wx *wx, u16 mbx_id);
 
+int wx_read_posted_mbx(struct wx *wx, u32 *msg, u16 size);
+int wx_write_posted_mbx(struct wx *wx, u32 *msg, u16 size);
+int wx_check_for_rst_vf(struct wx *wx);
+int wx_check_for_msg_vf(struct wx *wx);
+int wx_read_mbx_vf(struct wx *wx, u32 *msg, u16 size);
+int wx_write_mbx_vf(struct wx *wx, u32 *msg, u16 size);
+int wx_init_mbx_params_vf(struct wx *wx);
+
 #endif /* _WX_MBX_H_ */
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index c363379126c0..3d4785865bb2 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -825,6 +825,9 @@ struct wx_bus_info {
 
 struct wx_mbx_info {
 	u16 size;
+	u32 mailbox;
+	u32 udelay;
+	u32 timeout;
 };
 
 struct wx_thermal_sensor_data {
-- 
2.30.1


