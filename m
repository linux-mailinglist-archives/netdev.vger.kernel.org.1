Return-Path: <netdev+bounces-201063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7038AE7F0B
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 12:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F9763B44F0
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 10:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855D527FD74;
	Wed, 25 Jun 2025 10:22:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6464529AAF7
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 10:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750846939; cv=none; b=oopZdSog08PYvkw8dTWd+4GTbR52eF0H05RlzZ4KrZwZemykldo9KidqeABazpXvWI7Rdo44esmd9hIbJWEaxsf+qc0TAzkCswpI7fEMhTYa54jpFfdb32m6JthbtH1IMsqV6UwhCoaTdown2YITY0PHmS9rCpYMa9yPwkQ2j4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750846939; c=relaxed/simple;
	bh=ozOMQPaUjaMn9GC8dJ97zHeDZPsnqAtETxoHQ+lXVIE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AKAcAys1pxQmaUz0an0xJ38IHvHYH7Jp+qMS08XQleORVOkEBchIFMVU7RZq1Pt2fzVScSQh5rn9YBwPXeI7Xw6zcvZKskkagFBbYgRMETq3ixuUQCmLqNCpNF7/R6z9oU+bdeKK2cQlhTf7lFcH6gvC/PW2q/g1lx8wJFjxca8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: esmtpgz13t1750846880tb761630a
X-QQ-Originating-IP: rd2Lq+dbt0JVjDJHiAEwLo69uHjZgQc2wDdpQqXHvK8=
Received: from localhost.localdomain ( [60.186.80.242])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 25 Jun 2025 18:21:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5839400628751742594
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
Subject: [PATCH net-next v2 08/12] net: txgbevf: add phylink check flow
Date: Wed, 25 Jun 2025 18:20:54 +0800
Message-Id: <20250625102058.19898-9-mengyuanlou@net-swift.com>
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
X-QQ-XMAILINFO: OfnaCxb5OFkngwfNHo0c1mHt/OEGzoy1XtQ0Hhcwj5cf6akYyOuSt+ua
	T+FxhvocWwFfyqjzwvTAcbP6wEiimsJ2A4/CJLlRX0y1eMY/muywDgul7KrAm5L3wI0VOue
	U2sKPrs4awEcym602ccNMXz+AEkh5ImbyP5MzRNZLmNDbNoyHPtKMfRl0olo6bBLDoRkRba
	J31HNKu7k16PO3GbJE5QkvjZxTVlv3OyBn24oTC5DLtuimyVu8BiyReV378QPelBUGsq1P/
	4o2LKY5MpsX1U4UYUuKGh3HAs702cCgBD92THbPxQSJxMopihZ9rbb6hKevSs6JvOvOG6Y/
	yFHB4tPzOsJY9hVhovsd7lGFUSHOTiKE+kB75JjcsJVVtAWpmwO4IYINx/0aRZCFPPqfJ3c
	jKSHJ6Spp3XLIPrERGZnzHsgfTzH2xVhJFheHYonmdlH+SU2+CDRelksJvXbaOaNA96wVfy
	lcEOlC0eXz3oP8589Wu3FRLPlzs7awusju/3SFyFRlD3F0buWAM0xvnFMl04g+Q2bJ5qQxh
	kqX0Y3WSzoM88LZAg5p5b68akIeL7q3GB3EV/1lMY8/Z0TDO2WZLYAT49Y6qL804vJeT+UD
	jm2egxabOiH6NCRQFqMb1TVrRcI0BlrCq6Ebjk7//yCiBVZZ8s3b2RD2Rl4Zu2YWQEJ7fhm
	pI6rvQWGPEzf/LpBkJotzgsoMXpdyXXlmhAgBv6mu6mBkaIBaAEn45MHxK3LsH8gyE+56Bk
	hZcqx1ikryxCrSYF2ONRTyWVUAPXrXCBx49HTS1h4GyimPn4tVYEATuwFeSZvRWPkRF41HO
	0CN1kS7wN2VU4nP6kS7s1bzf/IRekhsW4cLK64jzJC792WDbAQY9N0aYuvZXOHVYCUhLzNE
	sBuVqWDerrB/kx22IDq7wVFa3AKBcGmpFhNthfrG6/77fnPnraRZ56U6sND96JiZySB4a5x
	q8UQ7ceUy0hiYXRUtHWL1XZndO/uK/FqRF+KgqYfj2dfu2VsLvGH6f9YmwovduWrUExsOV2
	+gd88tOk33VYvy0zYmOK3Mxt2PhxNBVqAbcVtgLf4oo2ys8l2w1bk2Y3d8bc+QySrW0tQUS
	RcVrq87gTFN1Jqw72VAYTsGd3ON71BzmqptwDCw35/h
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

Add phylink support to wangxun 10/25/40G virtual functions.
Get link status from pf in mbox, and if it is failed then
check the vx_status, because vx_status switching is too slow.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_vf.c    | 121 ++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_vf.h    |  14 ++
 .../net/ethernet/wangxun/libwx/wx_vf_common.c |  43 +++++++
 .../net/ethernet/wangxun/libwx/wx_vf_common.h |   9 ++
 .../ethernet/wangxun/txgbevf/txgbevf_main.c   |  88 +++++++++++++
 5 files changed, 275 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf.c b/drivers/net/ethernet/wangxun/libwx/wx_vf.c
index 46643176cc91..c91c690547d3 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf.c
@@ -471,3 +471,124 @@ int wx_get_queues_vf(struct wx *wx, u32 *num_tcs, u32 *default_tc)
 	return 0;
 }
 EXPORT_SYMBOL(wx_get_queues_vf);
+
+static int wx_get_link_status_from_pf(struct wx *wx, u32 *msgbuf)
+{
+	u32 links_reg = msgbuf[1];
+
+	if (msgbuf[1] & WX_PF_NOFITY_VF_NET_NOT_RUNNING)
+		wx->notify_down = true;
+	else
+		wx->notify_down = false;
+
+	if (wx->notify_down) {
+		wx->link = false;
+		wx->speed = SPEED_UNKNOWN;
+		return 0;
+	}
+
+	wx->link = WX_PFLINK_STATUS(links_reg);
+	wx->speed = WX_PFLINK_SPEED(links_reg);
+
+	return 0;
+}
+
+static int wx_pf_ping_vf(struct wx *wx, u32 *msgbuf)
+{
+	if (!(msgbuf[0] & WX_VT_MSGTYPE_CTS))
+		/* msg is not CTS, we need to do reset */
+		return -EINVAL;
+
+	return 0;
+}
+
+static struct wx_link_reg_fields wx_speed_lookup_vf[] = {
+	{wx_mac_unknown},
+	{wx_mac_sp, SPEED_10000, SPEED_1000, SPEED_100, SPEED_UNKNOWN, SPEED_UNKNOWN},
+	{wx_mac_em, SPEED_1000,  SPEED_100, SPEED_10, SPEED_UNKNOWN, SPEED_UNKNOWN},
+	{wx_mac_aml, SPEED_40000, SPEED_25000, SPEED_10000, SPEED_1000, SPEED_UNKNOWN},
+	{wx_mac_aml40, SPEED_40000, SPEED_25000, SPEED_10000, SPEED_1000, SPEED_UNKNOWN},
+};
+
+static void wx_check_physical_link(struct wx *wx, u32 link_val)
+{
+	wx->link = true;
+
+	switch (WX_VXSTATUS_SPEED(link_val)) {
+	case BIT(0):
+		wx->speed = wx_speed_lookup_vf[wx->mac.type].bit0_f;
+		break;
+	case BIT(1):
+		wx->speed = wx_speed_lookup_vf[wx->mac.type].bit1_f;
+		break;
+	case BIT(2):
+		wx->speed = wx_speed_lookup_vf[wx->mac.type].bit2_f;
+		break;
+	case BIT(3):
+		wx->speed = wx_speed_lookup_vf[wx->mac.type].bit3_f;
+		break;
+	case BIT(4):
+	default:
+		wx->speed = SPEED_UNKNOWN;
+		break;
+	}
+
+	if (wx->speed == SPEED_UNKNOWN)
+		wx->link = false;
+}
+
+int wx_check_mac_link_vf(struct wx *wx)
+{
+	struct wx_mbx_info *mbx = &wx->mbx;
+	u32 val, msgbuf[2] = {0};
+	int ret = 0;
+
+	/* If we were hit with a reset drop the link */
+	if (!wx_check_for_rst_vf(wx) || !mbx->timeout)
+		goto out;
+
+	if (!wx_check_for_msg_vf(wx))
+		ret = wx_read_mbx_vf(wx, msgbuf, 2);
+	if (ret)
+		goto out;
+
+	switch (msgbuf[0] & GENMASK(8, 0)) {
+	case WX_PF_NOFITY_VF_LINK_STATUS | WX_PF_CONTROL_MSG:
+		ret = wx_get_link_status_from_pf(wx, msgbuf);
+		goto out;
+	case WX_PF_CONTROL_MSG:
+		ret = wx_pf_ping_vf(wx, msgbuf);
+		goto out;
+	default:
+		break;
+	}
+
+	/* get link status from hw status reg */
+	/* for SFP+ modules and DA cables, it can take up to 500usecs
+	 * before the link status is correct
+	 */
+	ret = read_poll_timeout_atomic(rd32, val, val & BIT(0), 100,
+				       500, false, wx, WX_VXSTATUS);
+	if (ret)
+		goto out;
+
+	/* check link status */
+	wx_check_physical_link(wx, val);
+
+	if (!(msgbuf[0] & WX_VT_MSGTYPE_CTS)) {
+		/* msg is not CTS and is NACK we must have lost CTS status */
+		if (msgbuf[0] & WX_VT_MSGTYPE_NACK)
+			ret = -EBUSY;
+		goto out;
+	}
+
+	/* the pf is talking, if we timed out in the past we reinit */
+	if (!mbx->timeout) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+out:
+	return ret;
+}
+EXPORT_SYMBOL(wx_check_mac_link_vf);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf.h b/drivers/net/ethernet/wangxun/libwx/wx_vf.h
index e863a74c291d..fec1126703e3 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf.h
@@ -94,6 +94,19 @@
 #define WX_VXMRQC_RSS_EN             BIT(8)
 #define WX_VXMRQC_RSS_HASH(f)    FIELD_PREP(GENMASK(15, 13), f)
 
+#define WX_PFLINK_STATUS(g)      FIELD_GET(BIT(0), g)
+#define WX_PFLINK_SPEED(g)       FIELD_GET(GENMASK(31, 1), g)
+#define WX_VXSTATUS_SPEED(g)      FIELD_GET(GENMASK(4, 1), g)
+
+struct wx_link_reg_fields {
+	u32 mac_type;
+	u32 bit0_f;
+	u32 bit1_f;
+	u32 bit2_f;
+	u32 bit3_f;
+	u32 bit4_f;
+};
+
 void wx_init_hw_vf(struct wx *wx);
 int wx_reset_hw_vf(struct wx *wx);
 void wx_get_mac_addr_vf(struct wx *wx, u8 *mac_addr);
@@ -109,5 +122,6 @@ int wx_update_xcast_mode_vf(struct wx *wx, int xcast_mode);
 int wx_get_link_state_vf(struct wx *wx, u16 *link_state);
 int wx_set_vfta_vf(struct wx *wx, u32 vlan, u32 vind, bool vlan_on,
 		   bool vlvf_bypass);
+int wx_check_mac_link_vf(struct wx *wx);
 
 #endif /* _WX_VF_H_ */
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
index 60c9e1463efc..8fd49478c980 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
@@ -53,6 +53,7 @@ void wxvf_remove(struct pci_dev *pdev)
 	kfree(wx->vfinfo);
 	kfree(wx->rss_key);
 	kfree(wx->mac_table);
+	phylink_destroy(wx->phylink);
 	wx_clear_interrupt_scheme(wx);
 	pci_release_selected_regions(pdev,
 				     pci_select_bars(pdev, IORESOURCE_MEM));
@@ -64,6 +65,7 @@ static irqreturn_t wx_msix_misc_vf(int __always_unused irq, void *data)
 {
 	struct wx *wx = data;
 
+	phylink_mac_change(wx->phylink, wx->link);
 	/* Clear the interrupt */
 	if (netif_running(wx->netdev))
 		wr32(wx, WX_VXIMC, wx->eims_other);
@@ -243,6 +245,23 @@ int wx_set_mac_vf(struct net_device *netdev, void *p)
 }
 EXPORT_SYMBOL(wx_set_mac_vf);
 
+void wx_get_mac_link_vf(struct phylink_config *config,
+			struct phylink_link_state *state)
+{
+	struct wx *wx = phylink_to_wx(config);
+	int err;
+
+	spin_lock_bh(&wx->mbx.mbx_lock);
+	err = wx_check_mac_link_vf(wx);
+	spin_unlock_bh(&wx->mbx.mbx_lock);
+	if (err)
+		return;
+
+	state->link = wx->link;
+	state->speed = wx->speed;
+}
+EXPORT_SYMBOL(wx_get_mac_link_vf);
+
 static void wxvf_irq_enable(struct wx *wx)
 {
 	wr32(wx, WX_VXIMC, wx->eims_enable_mask);
@@ -259,6 +278,7 @@ static void wxvf_up_complete(struct wx *wx)
 	wxvf_irq_enable(wx);
 	/* enable transmits */
 	netif_tx_start_all_queues(wx->netdev);
+	phylink_start(wx->phylink);
 }
 
 int wxvf_open(struct net_device *netdev)
@@ -301,6 +321,7 @@ static void wxvf_down(struct wx *wx)
 {
 	struct net_device *netdev = wx->netdev;
 
+	phylink_stop(wx->phylink);
 	netif_tx_stop_all_queues(netdev);
 	netif_tx_disable(netdev);
 	wx_napi_disable_all(wx);
@@ -321,3 +342,25 @@ int wxvf_close(struct net_device *netdev)
 	return 0;
 }
 EXPORT_SYMBOL(wxvf_close);
+
+void wxvf_mac_config(struct phylink_config *config, unsigned int mode,
+		     const struct phylink_link_state *state)
+{
+}
+EXPORT_SYMBOL(wxvf_mac_config);
+
+void wxvf_mac_link_down(struct phylink_config *config,
+			unsigned int mode, phy_interface_t interface)
+{
+	struct wx *wx = phylink_to_wx(config);
+
+	wx->speed = SPEED_UNKNOWN;
+}
+EXPORT_SYMBOL(wxvf_mac_link_down);
+
+void wxvf_mac_link_up(struct phylink_config *config, struct phy_device *phy,
+		      unsigned int mode, phy_interface_t interface,
+		      int speed, int duplex, bool tx_pause, bool rx_pause)
+{
+}
+EXPORT_SYMBOL(wxvf_mac_link_up);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.h b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.h
index 272743a3c878..946a61bd4c3e 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.h
@@ -14,7 +14,16 @@ void wx_reset_vf(struct wx *wx);
 void wx_set_rx_mode_vf(struct net_device *netdev);
 void wx_configure_vf(struct wx *wx);
 int wx_set_mac_vf(struct net_device *netdev, void *p);
+void wx_get_mac_link_vf(struct phylink_config *config,
+			struct phylink_link_state *state);
 int wxvf_open(struct net_device *netdev);
 int wxvf_close(struct net_device *netdev);
+void wxvf_mac_config(struct phylink_config *config, unsigned int mode,
+		     const struct phylink_link_state *state);
+void wxvf_mac_link_down(struct phylink_config *config, unsigned int mode,
+			phy_interface_t interface);
+void wxvf_mac_link_up(struct phylink_config *config, struct phy_device *phy,
+		      unsigned int mode, phy_interface_t interface,
+		      int speed, int duplex, bool tx_pause, bool rx_pause);
 
 #endif /* _WX_VF_COMMON_H_ */
diff --git a/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c b/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
index 57e67804b8b7..b2faf5ecf2b2 100644
--- a/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
+++ b/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
@@ -37,6 +37,88 @@ static const struct pci_device_id txgbevf_pci_tbl[] = {
 	{ .device = 0 }
 };
 
+static const struct phylink_mac_ops txgbevf_mac_ops = {
+	.mac_config = wxvf_mac_config,
+	.mac_link_down = wxvf_mac_link_down,
+	.mac_link_up = wxvf_mac_link_up,
+};
+
+static int txgbevf_interface_max_speed(phy_interface_t interface)
+{
+	switch (interface) {
+	case PHY_INTERFACE_MODE_10GBASER:
+		return SPEED_10000;
+	case PHY_INTERFACE_MODE_25GBASER:
+		return SPEED_25000;
+	case PHY_INTERFACE_MODE_XLGMII:
+		return SPEED_40000;
+	default:
+		/* No idea! Garbage in, unknown out */
+		return SPEED_UNKNOWN;
+	}
+
+	return SPEED_UNKNOWN;
+}
+
+static int txgbevf_phylink_init(struct wx *wx)
+{
+	struct phylink_link_state link_state;
+	struct phylink_config *phy_config;
+	phy_interface_t phy_mode;
+	struct phylink *phylink;
+	int err;
+
+	phy_config = &wx->phylink_config;
+	phy_config->dev = &wx->netdev->dev;
+	phy_config->type = PHYLINK_NETDEV;
+	phy_config->mac_capabilities = MAC_40000FD | MAC_25000FD | MAC_10000FD |
+				       MAC_1000FD | MAC_100FD | MAC_10FD;
+	phy_config->get_fixed_state = wx_get_mac_link_vf;
+
+	if (wx->mac.type == wx_mac_aml40) {
+		phy_mode = PHY_INTERFACE_MODE_XLGMII;
+		__set_bit(PHY_INTERFACE_MODE_XLGMII,
+			  phy_config->supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_10GBASER,
+			  phy_config->supported_interfaces);
+	} else if (wx->mac.type == wx_mac_aml) {
+		phy_mode = PHY_INTERFACE_MODE_25GBASER;
+		__set_bit(PHY_INTERFACE_MODE_25GBASER,
+			  phy_config->supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_10GBASER,
+			  phy_config->supported_interfaces);
+	} else if (wx->mac.type == wx_mac_sp) {
+		phy_mode = PHY_INTERFACE_MODE_10GBASER;
+		__set_bit(PHY_INTERFACE_MODE_10GBASER,
+			  phy_config->supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_1000BASEX,
+			  phy_config->supported_interfaces);
+	} else {
+		wx_err(wx, "Unsupported MAC type for VF\n");
+		return -EINVAL;
+	}
+
+	/* Initialize the phylink */
+	phylink = phylink_create(phy_config, NULL,
+				 phy_mode, &txgbevf_mac_ops);
+	if (IS_ERR(phylink)) {
+		wx_err(wx, "Failed to create phylink\n");
+		return PTR_ERR(phylink);
+	}
+
+	link_state.speed = txgbevf_interface_max_speed(phy_mode);
+	link_state.duplex = DUPLEX_FULL;
+	err = phylink_set_fixed_link(phylink, &link_state);
+	if (err) {
+		wx_err(wx, "Failed to set fixed link\n");
+		return err;
+	}
+
+	wx->phylink = phylink;
+
+	return 0;
+}
+
 static const struct net_device_ops txgbevf_netdev_ops = {
 	.ndo_open               = wxvf_open,
 	.ndo_stop               = wxvf_close,
@@ -254,6 +336,10 @@ static int txgbevf_probe(struct pci_dev *pdev,
 	if (err)
 		goto err_free_sw_init;
 
+	err = txgbevf_phylink_init(wx);
+	if (err)
+		goto err_clear_interrupt_scheme;
+
 	err = register_netdev(netdev);
 	if (err)
 		goto err_register;
@@ -264,6 +350,8 @@ static int txgbevf_probe(struct pci_dev *pdev,
 	return 0;
 
 err_register:
+	phylink_destroy(wx->phylink);
+err_clear_interrupt_scheme:
 	wx_clear_interrupt_scheme(wx);
 err_free_sw_init:
 	kfree(wx->vfinfo);
-- 
2.30.1


