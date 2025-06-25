Return-Path: <netdev+bounces-201058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C73B1AE7F05
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 12:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 218263B7DC1
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 10:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7B429AB0F;
	Wed, 25 Jun 2025 10:22:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BEB29ACF3
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 10:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750846926; cv=none; b=rz5SNGTcjLOmQLgp8TRNluQFhgUhFRkysI4e7CZ2cS0TXTNdFiFqoGwIBXa6hoMVEaIKUbUF3QGha+fAhak2MTGd/xpDdKCaUjH8EtICopSTy6H+8dGP4dyQ22YctpRX3v+xS/hKItOHUlRcoP35r20sQ5/mEWr1s4vA9BKb9SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750846926; c=relaxed/simple;
	bh=eaTmAvkHhd5HYtlloVA17vbsgu+BUD2+MeX9qUrh1GU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K8SsB+l1pdIemldbtjnBILxEmN39Xo70/OKPuhRASQAHGZfdUngJHoJLWKsV1giND9GXez68dmJXE5HYaqx/ida0wkAaG+eQBziRgJzKl+PBTAVq0/syHM8krc69YCAHnQpi2v9LWWwBWtqs7z78akac2O+7GohpojfztNgyb2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: esmtpgz13t1750846867tdec73d43
X-QQ-Originating-IP: VNessEFQ/73APd5CihO3ICV7KZOe45jtrhSWmOJlHGA=
Received: from localhost.localdomain ( [60.186.80.242])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 25 Jun 2025 18:21:05 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 7169494911318332135
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
	jiawenwu@net-swift.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v2 02/12] net: libwx: add base vf api for vf drivers
Date: Wed, 25 Jun 2025 18:20:48 +0800
Message-Id: <20250625102058.19898-3-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20250625102058.19898-1-mengyuanlou@net-swift.com>
References: <20250625102058.19898-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NzmZMORfs0iDB8AcTl4e5ZRBzgekPwL+vsW1kE0LOXTpC5Oc+lh52hzQ
	WzThc1XEg9l/ZvecdiXfVAo/yBv16kM67vdbOHgfWRkhJL61o7jhU0IKGh07YH/XqEW0qeu
	u3mbWqT4NsvS4Hi+3OVTDlAaWB9UK2ol/svu5AwpanGoE1/j3kA9nopJW+Aeh6RyQWz1w9L
	kzxhfla4nDEU/TtzKc/3480GC5rNN4qeCF6/Bn6+R/MxnyWMxD39LKLI+kFh6kpqv/rBefB
	mqBH9uUOlQggdZT23VQmKQ7AxQajmT92vzfs3LAi2nkpNguolWmJkgo0hLa4huS3fuQ5XUz
	0eoF3aZhWJ+vDZWTsl7y7kWJyATJyHmJjjUSJMgTNlycHBXCfPbPBeEuHTLd2cJ7sVjiafE
	XAiXSmm8WDtsDXIFj41Sb0MZHz+eGznyqHGDeJO4sIutx+wuq/9Cd7sj6tRDuA5RME1b9Zm
	4x2YjCGCz+hPSGvkUo8hJfhOz7mAvB1dCtuZhchctXjPalBcuUX64wACBUpYSz5UIL0kdMz
	m4DI2Uf0ZAZLkBB0w55x2A7k461ZohjuRMe4CuGWtrhGYxOIpja6/rNLPoueBS44SoI0Qdr
	E7KWqKcT4WvXWmvfHc1crs+MO1j7l08YOyadVAn3DakKbmd1ATFZ+SfCB9Uz5qOGui9r28U
	GwtyRjQuKhA1elYWuqlaFhamMosSdjR5w7dObNeijIbHaYy2iXF+By270ZXacE71Zb3Hi+C
	dQsc0neEQqkcRX8VLAt4xs9ZS50hWkfifRb17w/D6Y4nW5SJUtycfRBwJjicNYjY6EsDrl5
	g7j4K6fxdE6DshyWiEThS/LfMG7/AQJemMHpfcbFSy/fN98wZlJ//5xTTogf0FIG9oDmdtZ
	io1EebNpVU3ZTlOD+CgUkqHsxrITAvD6uaXIx8QTt5TuZWQR18u/uMviI6fvpc5N8QYpMpp
	mZTraTiC/ubSuCWqFpYT9QFY4pRz/dQXWbN8KqE3uP4FbTiqj86vzo9jytbW88kLU12HuQY
	OFpmBPrX4Lh5eKmx3KJHbjrytAuxjjzVkkYPbEYal600ehFUp+yTKTwy2sn0QQyydiZMFv1
	Hrc9+cBRvigNnJ7UkO7xRGtWh/Tux5bu7Jx2O05UoUopeFYjF/kjMeNje7ML6mcHg==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

Implement mbox_write_and_read_ack functions which are
used to set basic functions like set_mac, get_link.etc
for vf.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 drivers/net/ethernet/wangxun/libwx/Makefile  |   1 +
 drivers/net/ethernet/wangxun/libwx/wx_hw.c   |   2 +-
 drivers/net/ethernet/wangxun/libwx/wx_hw.h   |   1 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h |   1 +
 drivers/net/ethernet/wangxun/libwx/wx_vf.c   | 473 +++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_vf.h   |  63 +++
 6 files changed, 540 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_vf.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_vf.h

diff --git a/drivers/net/ethernet/wangxun/libwx/Makefile b/drivers/net/ethernet/wangxun/libwx/Makefile
index 9b78b604a94e..ddf0bb921676 100644
--- a/drivers/net/ethernet/wangxun/libwx/Makefile
+++ b/drivers/net/ethernet/wangxun/libwx/Makefile
@@ -5,3 +5,4 @@
 obj-$(CONFIG_LIBWX) += libwx.o
 
 libwx-objs := wx_hw.o wx_lib.o wx_ethtool.o wx_ptp.o wx_mbx.o wx_sriov.o
+libwx-objs += wx_vf.o
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 0f4be72116b8..82dd76f0326e 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -1107,7 +1107,7 @@ static int wx_write_uc_addr_list(struct net_device *netdev, int pool)
  *  by the MO field of the MCSTCTRL. The MO field is set during initialization
  *  to mc_filter_type.
  **/
-static u32 wx_mta_vector(struct wx *wx, u8 *mc_addr)
+u32 wx_mta_vector(struct wx *wx, u8 *mc_addr)
 {
 	u32 vector = 0;
 
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.h b/drivers/net/ethernet/wangxun/libwx/wx_hw.h
index 26a56cba60b9..718015611da6 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.h
@@ -29,6 +29,7 @@ void wx_mac_set_default_filter(struct wx *wx, u8 *addr);
 int wx_add_mac_filter(struct wx *wx, u8 *addr, u16 pool);
 int wx_del_mac_filter(struct wx *wx, u8 *addr, u16 pool);
 void wx_flush_sw_mac_table(struct wx *wx);
+u32 wx_mta_vector(struct wx *wx, u8 *mc_addr);
 int wx_set_mac(struct net_device *netdev, void *p);
 void wx_disable_rx(struct wx *wx);
 int wx_set_vf_spoofchk(struct net_device *netdev, int vf, bool setting);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 3d4785865bb2..d14e46ac244a 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -1214,6 +1214,7 @@ struct wx {
 
 	void *priv;
 	u8 __iomem *hw_addr;
+	u8 __iomem *b4_addr; /* vf only */
 	struct pci_dev *pdev;
 	struct net_device *netdev;
 	struct wx_bus_info bus;
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf.c b/drivers/net/ethernet/wangxun/libwx/wx_vf.c
new file mode 100644
index 000000000000..46643176cc91
--- /dev/null
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf.c
@@ -0,0 +1,473 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2015 - 2025 Beijing WangXun Technology Co., Ltd. */
+
+#include <linux/etherdevice.h>
+#include <linux/pci.h>
+
+#include "wx_type.h"
+#include "wx_hw.h"
+#include "wx_mbx.h"
+#include "wx_vf.h"
+
+static void wx_virt_clr_reg(struct wx *wx)
+{
+	u32 vfsrrctl, i;
+
+	/* VRSRRCTL default values (BSIZEPACKET = 2048, BSIZEHEADER = 256) */
+	vfsrrctl = WX_VXRXDCTL_HDRSZ(wx_hdr_sz(WX_RX_HDR_SIZE));
+	vfsrrctl |= WX_VXRXDCTL_BUFSZ(wx_buf_sz(WX_RX_BUF_SIZE));
+
+	/* clear all rxd ctl */
+	for (i = 0; i < WX_VF_MAX_RING_NUMS; i++)
+		wr32m(wx, WX_VXRXDCTL(i),
+		      WX_VXRXDCTL_HDRSZ_MASK | WX_VXRXDCTL_BUFSZ_MASK,
+		      vfsrrctl);
+
+	rd32(wx, WX_VXSTATUS);
+}
+
+/**
+ *  wx_init_hw_vf - virtual function hardware initialization
+ *  @wx: pointer to hardware structure
+ *
+ *  Initialize the mac address
+ **/
+void wx_init_hw_vf(struct wx *wx)
+{
+	wx_get_mac_addr_vf(wx, wx->mac.addr);
+}
+EXPORT_SYMBOL(wx_init_hw_vf);
+
+static int wx_mbx_write_and_read_reply(struct wx *wx, u32 *req_buf,
+				       u32 *resp_buf, u16 size)
+{
+	int ret;
+
+	ret = wx_write_posted_mbx(wx, req_buf, size);
+	if (ret)
+		return ret;
+
+	return wx_read_posted_mbx(wx, resp_buf, size);
+}
+
+/**
+ *  wx_reset_hw_vf - Performs hardware reset
+ *  @wx: pointer to hardware structure
+ *
+ *  Resets the hardware by resetting the transmit and receive units, masks and
+ *  clears all interrupts.
+ *
+ *  Return: returns 0 on success, negative error code on failure
+ **/
+int wx_reset_hw_vf(struct wx *wx)
+{
+	struct wx_mbx_info *mbx = &wx->mbx;
+	u32 msgbuf[4] = {WX_VF_RESET};
+	u8 *addr = (u8 *)(&msgbuf[1]);
+	u32 b4_buf[16] = {0};
+	u32 timeout = 200;
+	int ret;
+	u32 i;
+
+	/* Call wx stop to disable tx/rx and clear interrupts */
+	wx_stop_adapter_vf(wx);
+
+	/* reset the api version */
+	wx->vfinfo->vf_api = wx_mbox_api_null;
+
+	/* backup msix vectors */
+	if (wx->b4_addr) {
+		for (i = 0; i < 16; i++)
+			b4_buf[i] = readl(wx->b4_addr + i * 4);
+	}
+
+	wr32m(wx, WX_VXCTRL, WX_VXCTRL_RST, WX_VXCTRL_RST);
+	rd32(wx, WX_VXSTATUS);
+
+	/* we cannot reset while the RSTI / RSTD bits are asserted */
+	while (!wx_check_for_rst_vf(wx) && timeout) {
+		timeout--;
+		udelay(5);
+	}
+
+	/* restore msix vectors */
+	if (wx->b4_addr) {
+		for (i = 0; i < 16; i++)
+			writel(b4_buf[i], wx->b4_addr + i * 4);
+	}
+
+	/* amlite: bme */
+	if (wx->mac.type == wx_mac_aml || wx->mac.type == wx_mac_aml40)
+		wr32(wx, WX_VX_PF_BME, WX_VF_BME_ENABLE);
+
+	if (!timeout)
+		return -EBUSY;
+
+	/* Reset VF registers to initial values */
+	wx_virt_clr_reg(wx);
+
+	/* mailbox timeout can now become active */
+	mbx->timeout = 2000;
+
+	ret = wx_mbx_write_and_read_reply(wx, msgbuf, msgbuf,
+					  ARRAY_SIZE(msgbuf));
+	if (ret)
+		return ret;
+
+	if (msgbuf[0] != (WX_VF_RESET | WX_VT_MSGTYPE_ACK) &&
+	    msgbuf[0] != (WX_VF_RESET | WX_VT_MSGTYPE_NACK))
+		return -EINVAL;
+
+	if (msgbuf[0] == (WX_VF_RESET | WX_VT_MSGTYPE_ACK))
+		ether_addr_copy(wx->mac.perm_addr, addr);
+
+	wx->mac.mc_filter_type = msgbuf[3];
+
+	return 0;
+}
+EXPORT_SYMBOL(wx_reset_hw_vf);
+
+/**
+ *  wx_stop_adapter_vf - Generic stop Tx/Rx units
+ *  @wx: pointer to hardware structure
+ *
+ *  Clears interrupts, disables transmit and receive units.
+ **/
+void wx_stop_adapter_vf(struct wx *wx)
+{
+	u32 reg_val;
+	u16 i;
+
+	/* Clear interrupt mask to stop from interrupts being generated */
+	wr32(wx, WX_VXIMS, WX_VF_IRQ_CLEAR_MASK);
+
+	/* Clear any pending interrupts, flush previous writes */
+	wr32(wx, WX_VXICR, U32_MAX);
+
+	/* Disable the transmit unit.  Each queue must be disabled. */
+	for (i = 0; i < wx->mac.max_tx_queues; i++)
+		wr32(wx, WX_VXTXDCTL(i), WX_VXTXDCTL_FLUSH);
+
+	/* Disable the receive unit by stopping each queue */
+	for (i = 0; i < wx->mac.max_rx_queues; i++) {
+		reg_val = rd32(wx, WX_VXRXDCTL(i));
+		reg_val &= ~WX_VXRXDCTL_ENABLE;
+		wr32(wx, WX_VXRXDCTL(i), reg_val);
+	}
+	/* Clear packet split and pool config */
+	wr32(wx, WX_VXMRQC, 0);
+
+	/* flush all queues disables */
+	rd32(wx, WX_VXSTATUS);
+}
+EXPORT_SYMBOL(wx_stop_adapter_vf);
+
+/**
+ *  wx_set_rar_vf - set device MAC address
+ *  @wx: pointer to hardware structure
+ *  @index: Receive address register to write
+ *  @addr: Address to put into receive address register
+ *  @enable_addr: set flag that address is active
+ *
+ *  Return: returns 0 on success, negative error code on failure
+ **/
+int wx_set_rar_vf(struct wx *wx, u32 index, u8 *addr, u32 enable_addr)
+{
+	u32 msgbuf[3] = {WX_VF_SET_MAC_ADDR};
+	u8 *msg_addr = (u8 *)(&msgbuf[1]);
+	int ret;
+
+	memcpy(msg_addr, addr, ETH_ALEN);
+
+	ret = wx_mbx_write_and_read_reply(wx, msgbuf, msgbuf,
+					  ARRAY_SIZE(msgbuf));
+	if (ret)
+		return ret;
+	msgbuf[0] &= ~WX_VT_MSGTYPE_CTS;
+
+	/* if nacked the address was rejected, use "perm_addr" */
+	if (msgbuf[0] == (WX_VF_SET_MAC_ADDR | WX_VT_MSGTYPE_NACK)) {
+		wx_get_mac_addr_vf(wx, wx->mac.addr);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(wx_set_rar_vf);
+
+/**
+ *  wx_update_mc_addr_list_vf - Update Multicast addresses
+ *  @wx: pointer to the HW structure
+ *  @netdev: pointer to the net device structure
+ *
+ *  Updates the Multicast Table Array.
+ *
+ *  Return: returns 0 on success, negative error code on failure
+ **/
+int wx_update_mc_addr_list_vf(struct wx *wx, struct net_device *netdev)
+{
+	u32 msgbuf[2] = {WX_VF_SET_MULTICAST};
+	u16 *vector_l = (u16 *)&msgbuf[1];
+	struct netdev_hw_addr *ha;
+	u32 cnt, i;
+
+	cnt = netdev_mc_count(netdev);
+	if (cnt > 30)
+		cnt = 30;
+	msgbuf[0] |= cnt << WX_VT_MSGINFO_SHIFT;
+
+	i = 0;
+	netdev_for_each_mc_addr(ha, netdev) {
+		if (i == cnt)
+			break;
+		if (is_link_local_ether_addr(ha->addr))
+			continue;
+
+		vector_l[i++] = wx_mta_vector(wx, ha->addr);
+	}
+
+	return wx_write_posted_mbx(wx, msgbuf, ARRAY_SIZE(msgbuf));
+}
+EXPORT_SYMBOL(wx_update_mc_addr_list_vf);
+
+/**
+ *  wx_update_xcast_mode_vf - Update Multicast mode
+ *  @wx: pointer to the HW structure
+ *  @xcast_mode: new multicast mode
+ *
+ *  Updates the Multicast Mode of VF.
+ *
+ *  Return: returns 0 on success, negative error code on failure
+ **/
+int wx_update_xcast_mode_vf(struct wx *wx, int xcast_mode)
+{
+	u32 msgbuf[2] = {WX_VF_UPDATE_XCAST_MODE, xcast_mode};
+	int ret = 0;
+
+	if (wx->vfinfo->vf_api < wx_mbox_api_13)
+		return -EINVAL;
+
+	ret = wx_mbx_write_and_read_reply(wx, msgbuf, msgbuf,
+					  ARRAY_SIZE(msgbuf));
+	if (ret)
+		return ret;
+
+	msgbuf[0] &= ~WX_VT_MSGTYPE_CTS;
+	if (msgbuf[0] == (WX_VF_UPDATE_XCAST_MODE | WX_VT_MSGTYPE_NACK))
+		return -EINVAL;
+
+	return 0;
+}
+EXPORT_SYMBOL(wx_update_xcast_mode_vf);
+
+/**
+ * wx_get_link_state_vf - Get VF link state from PF
+ * @wx: pointer to the HW structure
+ * @link_state: link state storage
+ *
+ * Return: return state of the operation error or success.
+ **/
+int wx_get_link_state_vf(struct wx *wx, u16 *link_state)
+{
+	u32 msgbuf[2] = {WX_VF_GET_LINK_STATE};
+	int ret;
+
+	ret = wx_mbx_write_and_read_reply(wx, msgbuf, msgbuf,
+					  ARRAY_SIZE(msgbuf));
+	if (ret)
+		return ret;
+
+	if (msgbuf[0] & WX_VT_MSGTYPE_NACK)
+		return -EINVAL;
+
+	*link_state = msgbuf[1];
+
+	return 0;
+}
+EXPORT_SYMBOL(wx_get_link_state_vf);
+
+/**
+ *  wx_set_vfta_vf - Set/Unset vlan filter table address
+ *  @wx: pointer to the HW structure
+ *  @vlan: 12 bit VLAN ID
+ *  @vind: unused by VF drivers
+ *  @vlan_on: if true then set bit, else clear bit
+ *  @vlvf_bypass: boolean flag indicating updating default pool is okay
+ *
+ *  Turn on/off specified VLAN in the VLAN filter table.
+ *
+ *  Return: returns 0 on success, negative error code on failure
+ **/
+int wx_set_vfta_vf(struct wx *wx, u32 vlan, u32 vind, bool vlan_on,
+		   bool vlvf_bypass)
+{
+	u32 msgbuf[2] = {WX_VF_SET_VLAN, vlan};
+	bool vlan_offload = false;
+	int ret;
+
+	/* Setting the 8 bit field MSG INFO to TRUE indicates "add" */
+	msgbuf[0] |= vlan_on << WX_VT_MSGINFO_SHIFT;
+	/* if vf vlan offload is disabled, allow to create vlan under pf port vlan */
+	msgbuf[0] |= BIT(vlan_offload);
+
+	ret = wx_mbx_write_and_read_reply(wx, msgbuf, msgbuf,
+					  ARRAY_SIZE(msgbuf));
+	if (ret)
+		return ret;
+
+	if (msgbuf[0] & WX_VT_MSGTYPE_ACK)
+		return 0;
+
+	return msgbuf[0] & WX_VT_MSGTYPE_NACK;
+}
+EXPORT_SYMBOL(wx_set_vfta_vf);
+
+void wx_get_mac_addr_vf(struct wx *wx, u8 *mac_addr)
+{
+	ether_addr_copy(mac_addr, wx->mac.perm_addr);
+}
+EXPORT_SYMBOL(wx_get_mac_addr_vf);
+
+int wx_get_fw_version_vf(struct wx *wx)
+{
+	u32 msgbuf[2] = {WX_VF_GET_FW_VERSION};
+	int ret;
+
+	ret = wx_mbx_write_and_read_reply(wx, msgbuf, msgbuf,
+					  ARRAY_SIZE(msgbuf));
+	if (ret)
+		return ret;
+
+	if (msgbuf[0] & WX_VT_MSGTYPE_NACK)
+		return -EINVAL;
+	snprintf(wx->eeprom_id, 32, "0x%08x", msgbuf[1]);
+
+	return 0;
+}
+EXPORT_SYMBOL(wx_get_fw_version_vf);
+
+int wx_set_uc_addr_vf(struct wx *wx, u32 index, u8 *addr)
+{
+	u32 msgbuf[3] = {WX_VF_SET_MACVLAN};
+	u8 *msg_addr = (u8 *)(&msgbuf[1]);
+	int ret;
+
+	/* If index is one then this is the start of a new list and needs
+	 * indication to the PF so it can do it's own list management.
+	 * If it is zero then that tells the PF to just clear all of
+	 * this VF's macvlans and there is no new list.
+	 */
+	msgbuf[0] |= index << WX_VT_MSGINFO_SHIFT;
+	if (addr)
+		memcpy(msg_addr, addr, 6);
+	ret = wx_mbx_write_and_read_reply(wx, msgbuf, msgbuf,
+					  ARRAY_SIZE(msgbuf));
+	if (ret)
+		return ret;
+
+	msgbuf[0] &= ~WX_VT_MSGTYPE_CTS;
+
+	if (msgbuf[0] == (WX_VF_SET_MACVLAN | WX_VT_MSGTYPE_NACK))
+		return -EINVAL;
+
+	return 0;
+}
+EXPORT_SYMBOL(wx_set_uc_addr_vf);
+
+/**
+ *  wx_rlpml_set_vf - Set the maximum receive packet length
+ *  @wx: pointer to the HW structure
+ *  @max_size: value to assign to max frame size
+ *
+ *  Return: returns 0 on success, negative error code on failure
+ **/
+int wx_rlpml_set_vf(struct wx *wx, u16 max_size)
+{
+	u32 msgbuf[2] = {WX_VF_SET_LPE, max_size};
+	int ret;
+
+	ret = wx_mbx_write_and_read_reply(wx, msgbuf, msgbuf,
+					  ARRAY_SIZE(msgbuf));
+	if (ret)
+		return ret;
+	if ((msgbuf[0] & WX_VF_SET_LPE) &&
+	    (msgbuf[0] & WX_VT_MSGTYPE_NACK))
+		return -EINVAL;
+
+	return 0;
+}
+EXPORT_SYMBOL(wx_rlpml_set_vf);
+
+/**
+ *  wx_negotiate_api_version - Negotiate supported API version
+ *  @wx: pointer to the HW structure
+ *  @api: integer containing requested API version
+ *
+ *  Return: returns 0 on success, negative error code on failure
+ **/
+int wx_negotiate_api_version(struct wx *wx, int api)
+{
+	u32 msgbuf[2] = {WX_VF_API_NEGOTIATE, api};
+	int ret;
+
+	ret = wx_mbx_write_and_read_reply(wx, msgbuf, msgbuf,
+					  ARRAY_SIZE(msgbuf));
+	if (ret)
+		return ret;
+
+	msgbuf[0] &= ~WX_VT_MSGTYPE_CTS;
+
+	/* Store value and return 0 on success */
+	if (msgbuf[0] == (WX_VF_API_NEGOTIATE | WX_VT_MSGTYPE_NACK))
+		return -EINVAL;
+	wx->vfinfo->vf_api = api;
+
+	return 0;
+}
+EXPORT_SYMBOL(wx_negotiate_api_version);
+
+int wx_get_queues_vf(struct wx *wx, u32 *num_tcs, u32 *default_tc)
+{
+	u32 msgbuf[5] = {WX_VF_GET_QUEUES};
+	int ret;
+
+	/* do nothing if API doesn't support wx_get_queues */
+	if (wx->vfinfo->vf_api < wx_mbox_api_13)
+		return -EINVAL;
+
+	/* Fetch queue configuration from the PF */
+	ret = wx_mbx_write_and_read_reply(wx, msgbuf, msgbuf,
+					  ARRAY_SIZE(msgbuf));
+	if (ret)
+		return ret;
+	msgbuf[0] &= ~WX_VT_MSGTYPE_CTS;
+
+	/* if we didn't get an ACK there must have been
+	 * some sort of mailbox error so we should treat it
+	 * as such
+	 */
+	if (msgbuf[0] != (WX_VF_GET_QUEUES | WX_VT_MSGTYPE_ACK))
+		return -EINVAL;
+	/* record and validate values from message */
+	wx->mac.max_tx_queues = msgbuf[WX_VF_TX_QUEUES];
+	if (wx->mac.max_tx_queues == 0 ||
+	    wx->mac.max_tx_queues > WX_VF_MAX_TX_QUEUES)
+		wx->mac.max_tx_queues = WX_VF_MAX_TX_QUEUES;
+
+	wx->mac.max_rx_queues = msgbuf[WX_VF_RX_QUEUES];
+	if (wx->mac.max_rx_queues == 0 ||
+	    wx->mac.max_rx_queues > WX_VF_MAX_RX_QUEUES)
+		wx->mac.max_rx_queues = WX_VF_MAX_RX_QUEUES;
+
+	*num_tcs = msgbuf[WX_VF_TRANS_VLAN];
+	/* in case of unknown state assume we cannot tag frames */
+	if (*num_tcs > wx->mac.max_rx_queues)
+		*num_tcs = 1;
+	*default_tc = msgbuf[WX_VF_DEF_QUEUE];
+	/* default to queue 0 on out-of-bounds queue number */
+	if (*default_tc >= wx->mac.max_tx_queues)
+		*default_tc = 0;
+
+	return 0;
+}
+EXPORT_SYMBOL(wx_get_queues_vf);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf.h b/drivers/net/ethernet/wangxun/libwx/wx_vf.h
new file mode 100644
index 000000000000..c523ef3e8502
--- /dev/null
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2015 - 2025 Beijing WangXun Technology Co., Ltd. */
+
+#ifndef _WX_VF_H_
+#define _WX_VF_H_
+
+#define WX_VF_MAX_RING_NUMS      8
+#define WX_VX_PF_BME             0x4B8
+#define WX_VF_BME_ENABLE         BIT(0)
+#define WX_VXSTATUS              0x4
+#define WX_VXCTRL                0x8
+#define WX_VXCTRL_RST            BIT(0)
+
+#define WX_VXMRQC                0x78
+#define WX_VXICR                 0x100
+#define WX_VXIMS                 0x108
+#define WX_VF_IRQ_CLEAR_MASK     7
+#define WX_VF_MAX_TX_QUEUES      4
+#define WX_VF_MAX_RX_QUEUES      4
+#define WX_VXTXDCTL(r)           (0x3010 + (0x40 * (r)))
+#define WX_VXRXDCTL(r)           (0x1010 + (0x40 * (r)))
+#define WX_VXRXDCTL_ENABLE       BIT(0)
+#define WX_VXTXDCTL_FLUSH        BIT(26)
+
+#define WX_VXRXDCTL_RSCMAX(f)    FIELD_PREP(GENMASK(24, 23), f)
+#define WX_VXRXDCTL_BUFLEN(f)    FIELD_PREP(GENMASK(6, 1), f)
+#define WX_VXRXDCTL_BUFSZ(f)     FIELD_PREP(GENMASK(11, 8), f)
+#define WX_VXRXDCTL_HDRSZ(f)     FIELD_PREP(GENMASK(15, 12), f)
+
+#define WX_VXRXDCTL_RSCMAX_MASK  GENMASK(24, 23)
+#define WX_VXRXDCTL_BUFLEN_MASK  GENMASK(6, 1)
+#define WX_VXRXDCTL_BUFSZ_MASK   GENMASK(11, 8)
+#define WX_VXRXDCTL_HDRSZ_MASK   GENMASK(15, 12)
+
+#define wx_conf_size(v, mwidth, uwidth) ({ \
+	typeof(v) _v = (v); \
+	(_v == 2 << (mwidth) ? 0 : _v >> (uwidth)); \
+})
+#define wx_buf_len(v)            wx_conf_size(v, 13, 7)
+#define wx_hdr_sz(v)             wx_conf_size(v, 10, 6)
+#define wx_buf_sz(v)             wx_conf_size(v, 14, 10)
+#define wx_pkt_thresh(v)         wx_conf_size(v, 4, 0)
+
+#define WX_RX_HDR_SIZE           256
+#define WX_RX_BUF_SIZE           2048
+
+void wx_init_hw_vf(struct wx *wx);
+int wx_reset_hw_vf(struct wx *wx);
+void wx_get_mac_addr_vf(struct wx *wx, u8 *mac_addr);
+void wx_stop_adapter_vf(struct wx *wx);
+int wx_get_fw_version_vf(struct wx *wx);
+int wx_set_rar_vf(struct wx *wx, u32 index, u8 *addr, u32 enable_addr);
+int wx_update_mc_addr_list_vf(struct wx *wx, struct net_device *netdev);
+int wx_set_uc_addr_vf(struct wx *wx, u32 index, u8 *addr);
+int wx_rlpml_set_vf(struct wx *wx, u16 max_size);
+int wx_negotiate_api_version(struct wx *wx, int api);
+int wx_get_queues_vf(struct wx *wx, u32 *num_tcs, u32 *default_tc);
+int wx_update_xcast_mode_vf(struct wx *wx, int xcast_mode);
+int wx_get_link_state_vf(struct wx *wx, u16 *link_state);
+int wx_set_vfta_vf(struct wx *wx, u32 vlan, u32 vind, bool vlan_on,
+		   bool vlvf_bypass);
+
+#endif /* _WX_VF_H_ */
-- 
2.30.1


