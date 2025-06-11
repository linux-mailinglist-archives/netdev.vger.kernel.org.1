Return-Path: <netdev+bounces-196456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1A1AD4E88
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 10:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C21933A6B6F
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 08:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5AD23ED69;
	Wed, 11 Jun 2025 08:36:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21CB22F75D
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 08:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749631018; cv=none; b=hAyRwR59YzyxtKHDYkLDNgLhYs2vjtIKWDUaxedNwcP9FqyVqzeunUjh510CaKWpET8JKmW05nqLywsdcuN6jW9w2U77YH3cqmU/7OKaNNXAV/wcScKzcxTSN04JhtWF08pLf1qKlNxiXN39WzsE8ojuFMMz0P2W9HrPp9jbPnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749631018; c=relaxed/simple;
	bh=cbsnBsM2CO9WyRpcRDNW3KuVj4MnYgXj4BSULKxGYsE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=POH1kqJzI0zp6Di99mxbn+Mr0shHL9iqw4uRE/jJwC3mTy/tAyId5Bi6UgPkZeepd21GAV+IWKx7T4RiGKAqibsNrTAzXMN7h2A1idv0TPOjVdJ4odyQoL0Gca6I/V7Al+xpeIDFJnlkZklhzYmD73S6hjxjVbqBemzKfcAGTDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: zesmtpgz1t1749630983te966aac6
X-QQ-Originating-IP: Sk7tpus1mn04WRIzF+IjtbqlOOXTOAjF6+AC/Cw1r1s=
Received: from localhost.localdomain ( [36.20.60.58])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 11 Jun 2025 16:36:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6893949515969875678
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
Subject: [PATCH net-next 08/12] net: txgbevf: add phylink check flow
Date: Wed, 11 Jun 2025 16:35:55 +0800
Message-Id: <20250611083559.14175-9-mengyuanlou@net-swift.com>
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
X-QQ-XMAILINFO: NX3nY7OJg9VpDI/wbc2ix38ufQhWy3Kk1W4iQ5/SGo3Zy7dsf2JYkhTs
	+X6dxqX6JEMWrcMCT0rB0P9yBoqt9tz5yqyR7H0ToHyModPpH7Z1PR0Eg1iCtvaseW7fNiw
	b0FoErdqzIE73AiAKsCGEAajhvn+SF2hHghDwfgP4MIxJW7R69J1L4IIRp07LRgQVA8ikwt
	D+MwRzX1SBNxEXngOZspW7oF9FF5JUpA3IW312vYwefQLeTKnvQSloqMu7DZbFLkfxk1mx/
	jYIOdGPuBvNqJh/qx+k7/I+hnBbgQE5xUqMsBZty98AcynOdtA9JqrKGNPe3FBQNkaZjBZq
	/3fYMS3JHayQb1mxlHf/zPg+3SxV7TeKda0fIEruVN7MUKXPbddA+0Q25tb2QDloqHemvBC
	pjuqlf/TtrnF77fuQRcc0dTd718v/vJyCzg67t6+QJOp/sAo3fzwIauKMFGG62y36x1Vkwa
	kfYe7MUiV8HhjHYDZrCMquA1F29hDsccFf+NMTiYaP+mk+YCJ6vh0zyUn9/1LY7IN+xhZja
	FjIYOFxZkFrUr6iIVCZxczR1dm61euNkcM4/aY5uAduJam1avDDkVKbyz89uIx90iCVHXdu
	rZGY3z8G1C3bSORcIpne3ILNcN/yHmUzq96FQtI8eKPHXvqcaPdZ8SN0R6J9PT4goWKPjfJ
	cvzVB/+yS9pTso+72ZIaut1KRoiqHcB1/dmXXJQ/yYj7PcJvG1cQqb5+qYUjr2JQHRY8/sW
	OPvVr9E7iYlKz6psXfPC8rK7LzarbFKA787Sf53JYkeyQ9oEQ1N1mf2MCN1drfsoiDPsFeE
	e/R1EMbtbZi7OpIOGrdpFsIp6vpiEWiud7CKYiD397n0pcoKpV+w11Hr4x4ujQV58aegwNa
	SPfoe/rEwk134yIqLk/7ZpQxh88vxOiCMWIflCXDBxUqEJ3Wps5t9n87nJIV9c5BEZ9WNTX
	2Ly+mBteGWHL6a5ImPMTZRSZ+7FTWpZcVGIlS+v4Fv93oFK13aIy13zrDb+YdSCJLSetC0l
	Z9r+HUNYerhYRBMpizUyIx0NaKe5ZKDk5DWvuqCBS5fZ/YyG0yMQCITWVNZmlF3WFgOkTn3
	dQpZ9UfXSRICS63wIZ2kOM=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
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
index a211329fd71a..cba6641a4c7b 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf.c
@@ -519,3 +519,124 @@ int wx_get_queues_vf(struct wx *wx, u32 *num_tcs, u32 *default_tc)
 	return ret;
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
index 3bb70421622a..59bb4aa1ec93 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf.h
@@ -90,6 +90,19 @@
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
 void wx_start_hw_vf(struct wx *wx);
 void wx_init_hw_vf(struct wx *wx);
 int wx_reset_hw_vf(struct wx *wx);
@@ -106,5 +119,6 @@ int wx_update_xcast_mode_vf(struct wx *wx, int xcast_mode);
 int wx_get_link_state_vf(struct wx *wx, u16 *link_state);
 int wx_set_vfta_vf(struct wx *wx, u32 vlan, u32 vind, bool vlan_on,
 		   bool vlvf_bypass);
+int wx_check_mac_link_vf(struct wx *wx);
 
 #endif /* _WX_VF_H_ */
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
index 51c93364aaf1..c14d8fbcf990 100644
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
@@ -242,6 +244,23 @@ int wx_set_mac_vf(struct net_device *netdev, void *p)
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
@@ -258,6 +277,7 @@ static void wxvf_up_complete(struct wx *wx)
 	wxvf_irq_enable(wx);
 	/* enable transmits */
 	netif_tx_start_all_queues(wx->netdev);
+	phylink_start(wx->phylink);
 }
 
 int wxvf_open(struct net_device *netdev)
@@ -300,6 +320,7 @@ static void wxvf_down(struct wx *wx)
 {
 	struct net_device *netdev = wx->netdev;
 
+	phylink_stop(wx->phylink);
 	netif_tx_stop_all_queues(netdev);
 	netif_tx_disable(netdev);
 	wx_napi_disable_all(wx);
@@ -320,3 +341,25 @@ int wxvf_close(struct net_device *netdev)
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
index 448513cf882c..5a8eb8856a87 100644
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
@@ -257,6 +339,10 @@ static int txgbevf_probe(struct pci_dev *pdev,
 	if (err)
 		goto err_free_sw_init;
 
+	err = txgbevf_phylink_init(wx);
+	if (err)
+		goto err_clear_interrupt_scheme;
+
 	err = register_netdev(netdev);
 	if (err)
 		goto err_register;
@@ -267,6 +353,8 @@ static int txgbevf_probe(struct pci_dev *pdev,
 	return 0;
 
 err_register:
+	phylink_destroy(wx->phylink);
+err_clear_interrupt_scheme:
 	wx_clear_interrupt_scheme(wx);
 err_free_sw_init:
 	kfree(wx->vfinfo);
-- 
2.30.1


