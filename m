Return-Path: <netdev+bounces-196461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79902AD4E8A
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 10:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 458C717DFF5
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 08:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A26623F43C;
	Wed, 11 Jun 2025 08:37:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.155.80.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C827E23C504
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 08:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.155.80.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749631032; cv=none; b=n+knsl+q1WGIUIXfgoT6BoNKh8Blm7K8cI7esKoAhF3Pcgi/YWRDl6iYc+04A38qN/N+sB688nlaM0ghVha15HkI7bOavlD4hgPbkfxQJSsRwAxEUetvDBcSJ2Pg1oMWgMgBy7tlt40RCiYVOBpxE75JgyvRAC8N4FEqohxolWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749631032; c=relaxed/simple;
	bh=epCtdFXlZP6HeWtqP4Pxt+HuuaB+LwSJ8qPgLGwNYQg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uopl9OttRN4vGRSDfdjcXlaoZmSrpw4DemYXwmzxJGZuHCfvAv2W2UgdofG2E9Lv9gb47SBUVHJB405GkQGSXVgvzwJ4A7ABSdQHVr1p9GGL++QahnBrGjpovWkAGtbQ9B0f8uHE6Vmo3/0vtwZ0tDJhxhoujlBp8BuJ09rG2ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=43.155.80.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: zesmtpgz1t1749630967t4c7e22b0
X-QQ-Originating-IP: XlCxk5g3+V0Kp4eTmnbYPrV95oblPYzN73GEjkdxqbA=
Received: from localhost.localdomain ( [36.20.60.58])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 11 Jun 2025 16:36:06 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15965632055893411661
EX-QQ-RecipientCnt: 9
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	duanqiangwen@net-swift.com,
	linglingzhang@trustnetic.com,
	jiawenwu@net-swift.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next 01/12] net: libwx: add mailbox api for wangxun vf drivers
Date: Wed, 11 Jun 2025 16:35:48 +0800
Message-Id: <20250611083559.14175-2-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20250611083559.14175-1-mengyuanlou@net-swift.com>
References: <20250611083559.14175-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NChuY+V9daHbt/RuvFHa4sdhxXzYOo5aPaPJgNfwGD1aTngDGjmYsL9y
	jYQUJjMZHbEHGq47JnL63b+QiVjSM5Ghj0pjCMDixkFh8UZ9MUX5otEw0jwn644gF317MFY
	zjNQFtSFCZZSKrTm3rh+ck34u8QV0nyxCsOQ50HQMC7t+e47viy4Brf52CD9RY8+TjaDcXG
	hLPt0N88t7cbH74c/uSEXT74vWhZ5NGdR6FBOFUnJ6M1GKExxyFwSj+1LMgUIu+EsItDL9Y
	0Fxr0ATEaOBI0UlwE2jDd/WV02VG1/ceuh4azhCO3fApdgcA8pM/sVf0n/vPJeAufNiEY/e
	m8agwP3TrP29SIFb7MNBJur3kAES9CWXuKt2viK9HTq2U7ljf0lAkDJfLpptxCS5aysEuw+
	hJgLQq3MKZR8j8SciPjnz7SAm7pYPngkxf5HFYxKp9tkDyO/LYaoh6oVNadPUOu4GwU3NVc
	PUf69oj9GSu8KAiP3Dh4ChvmWM5Muk6guOtrYKrMnJbJ5CzaMWAiubVMJq5G88dRWvgNzI4
	cDsvNbG+qFoYiro7p4R5UYKQ53bP4dqFrZHuFfYNAwgYtqo1k7usUgr3OiDuqcxm2eLQbSo
	bcLKILc6OkrVIrBdy95y/sUsl1qrDmq2n1rWy4f93Zgj1+ElIzI3CqeSp7E0pHKLBQfPGc4
	GSgvzy5Fr24NIYvCA9+OuoVqpRX3FlW/jZWV++Nd2LZiomIlOY6Nai9M01ceFB3artD35um
	CBh0f0k24qz+7tUWs0aRMzK31W6MqWV61XrhPCuWq8OoElQmfGcsyzs7zv1d3Mk6/tZNNsc
	zkNGz+WQrnTIEDXJ8Pi0EKuQ1nOid55+uEDE11YqIRLSiJBBEUS/aC4IkQrs8NGsrmZ/aEW
	9Q/WmGbrJ9I+0jsa546qYz/7J86oqiWsntcxOstaJ0jsq1pTWJeYamkp4zG2Z02XkKDBFDX
	7AFJyoV3iJST0oEoFDsspb4o7j8Lp0U1EbbFYDxaWhf4Afy7klCINh1QQ96OwkxviZOCnBB
	CdvbIrd02V13/fNS0ned5M7tvqeRfK0EaI1gOFNFGglqYVWtmPBwVuUywllsttEJbjIZ0Dw
	JnBH1vAi9JB
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

Implements the mailbox interfaces for Wangxun vf drivers which
will be used in txgbevf and ngbevf.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_mbx.c  | 256 +++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_mbx.h  |  22 ++
 drivers/net/ethernet/wangxun/libwx/wx_type.h |   3 +
 3 files changed, 281 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_mbx.c b/drivers/net/ethernet/wangxun/libwx/wx_mbx.c
index 73af5f11c3bd..ebfa07d50bd2 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_mbx.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_mbx.c
@@ -174,3 +174,259 @@ int wx_check_for_rst_pf(struct wx *wx, u16 vf)
 
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
+/**
+ *  wx_obtain_mbx_lock_vf - obtain mailbox lock
+ *  @wx: pointer to the HW structure
+ *
+ *  Return: return 0 on success and -EBUSY on failure
+ **/
+static int wx_obtain_mbx_lock_vf(struct wx *wx)
+{
+	int count = 5;
+	u32 mailbox;
+
+	while (count--) {
+		/* Take ownership of the buffer */
+		wr32(wx, WX_VXMAILBOX, WX_VXMAILBOX_VFU);
+
+		/* reserve mailbox for vf use */
+		mailbox = wx_read_v2p_mailbox(wx);
+		if (mailbox & WX_VXMAILBOX_VFU)
+			return 0;
+	}
+
+	wx_err(wx, "Failed to obtain mailbox lock for VF.\n");
+
+	return -EBUSY;
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
+	int countdown = mbx->timeout;
+
+	while (countdown && wx_check_for_msg_vf(wx)) {
+		countdown--;
+		if (!countdown)
+			break;
+		udelay(mbx->udelay);
+	}
+
+	return countdown ? 0 : -EBUSY;
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
+	int countdown = mbx->timeout;
+
+	while (countdown && wx_check_for_ack_vf(wx)) {
+		countdown--;
+		if (!countdown)
+			break;
+		udelay(mbx->udelay);
+	}
+
+	return countdown ? 0 : -EBUSY;
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
+	if (!ret)
+		ret = wx_read_mbx_vf(wx, msg, size);
+
+	return ret;
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
+	if (!ret)
+		ret = wx_poll_for_ack(wx);
+
+	return ret;
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
+	int ret;
+	u16 i;
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
+	wx->vfinfo = kcalloc(1, sizeof(struct vf_data_storage),
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
index 7730c9fc3e02..f2061c893358 100644
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


