Return-Path: <netdev+bounces-204118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0D7AF8F2B
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 11:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 163631CA5818
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 09:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BDE28D840;
	Fri,  4 Jul 2025 09:51:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21BD2EE609
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 09:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751622719; cv=none; b=mNn9RZT9NSb9Q7sGh6nkabsmIv5syt55Irh6gxB9McZ4EiI8nEsUA7n3XWGvYhO3BGWiC9LagGoT6KrXO1VedumwQnYGBdFIeO79BaWWcESRNC+8RNeDzkvQ0P3pwKH6LKCBmndch7d4K1HX/4/wLEhQwCqwmPcyo9a99ZrUPcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751622719; c=relaxed/simple;
	bh=Uli26NSSXz1d0tJJrmrQyHB0ZS8niKLispS0MjfZ6XI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T8LKQRffAdZOjonbn9wJHs0Wf7yY6W8jnH9CHhS8slHFL3cBMsxUOhu9z+X3VSnJhBR4BS1LVHSp/m+FiPACrNmzk9EtpfMl9nCn77hqlMqeWreahTfiW8XsYfZXxq81Smn1iqw6n/Gp4onO2T0Aw4zBWDztiM8cKGd2MCt7Tko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: zesmtpsz1t1751622636t3566eb0e
X-QQ-Originating-IP: u8uHnB8GEUPM4X69E2LPBBm8Fd7b7Ld3XiZMLjv9Sjs=
Received: from localhost.localdomain ( [156.146.53.122])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 04 Jul 2025 17:50:29 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5128057157987759427
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
Subject: [PATCH net-next v3 08/12] net: txgbevf: add link update flow
Date: Fri,  4 Jul 2025 17:49:19 +0800
Message-Id: <20250704094923.652-9-mengyuanlou@net-swift.com>
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
X-QQ-XMAILINFO: NAYGvnC2H7P7FJd5hFPzr7oIkwX0Sz2kx3XJxbli/9ozWPSL1MAhiE14
	u2Jp1hzc2pnDRelwGjjxDnpRLXZo5U4wXOVCvumDU4bGcjVo52ToT6HVEv6/AmKwvaUCdoD
	hZI1uoLPEwyVN528Ju+BipBYEUG1bsT1aTnhTI5HUfEva6cyiKPjFAOsLRK25iMicQOTlrp
	SpveYBWZgqCDq9EVcCdhL7XH+HekB8VO/GsbjfPiKIH+JWrXZ7rc4Ox3j7pL39gegLu8V4S
	CXeiZS6w0foC1Cqryz+qdcrZtGyfPnD/vttkQZPtr8sMiIe3NM8HpeRmPLPEsHr/26NLCWd
	UtNJXsxpZgEF0AWvO1NC7REo5BYvJGETk1CwJ8TnOMlx6mwPMT7kW/F2zn9rPVYUgbo93P7
	pbSnmRKihYHAozD+XH0aGDx/AKEs7y3Fys3D12q+4IMRCnK9zQBsOs3gxhsvKRdyQpdl85b
	hrqd9IK77hwTS4P3xQ7AjKCE33hyJr1+21C6cVo/JDZQCnvB5mRsxXeELeXaQ+Kuyj4NLZw
	xc+F1MQOUSd1CZSUVfA0tsBAGmQvypQahpcD0qjU3PL2bPKmgTeDTMzLBbx5fQBauE0bHnR
	50KSAhb6GcEPzA9WoACb4C4zrwqDUqtf/HGFI4o1yLUC4dYxwjkWaIc7hFoNNoX0sJFG2Dv
	iw6VZFqWqtuC776mWQGbQo1Tl4hcNo0inXXouqU5TPNRjwUUBQ3KU5dgkyrW1/Eo6RMKdtt
	lUSMJj1FxsP+ueVwXuAhculOfZugutoGRwAmx2n8DOSN1QC9TqV3Sq3ChXeAblJTa2HPwwJ
	L0IJ/AvcyUC4pckpz8XtPCXJ/zaEv66dec1KpcuA3bq8TDsnyzcaUUclYApRu89coxe4Aw3
	3TgaacJZEYv18Lqu4xkhRU5IeApUt7fyhMNwgQU4Ix47ibFbKF3/I0jwl046kSN6t1iwZv3
	+oleeXRzTjj9z4v/i47hIvGsMuRZWtmwgLWTpynZWUyPTqn421EIijdgNOmA0EJmPyw4Jcm
	lmIVM/+69Kl33ywjpVAEJ/zNgOjWVgHJ3rD8Y8Lm++/hGnfHaT2CblEWPesLy4xKp4pcSL4
	03XZihNunadG4trPmPTdk7r8FOUP/S29g==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

Add link update flow to wangxun 10/25/40G virtual functions.
Get link status from pf in mbox, and if it is failed then
check the vx_status, because vx_status switching is too slow.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |   2 +
 drivers/net/ethernet/wangxun/libwx/wx_vf.c    | 126 ++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_vf.h    |  14 ++
 .../net/ethernet/wangxun/libwx/wx_vf_common.c |  91 +++++++++++++
 .../net/ethernet/wangxun/libwx/wx_vf_common.h |   2 +
 .../ethernet/wangxun/txgbevf/txgbevf_main.c   |   3 +
 6 files changed, 238 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 58e9988388a7..42b0e65fe983 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -1206,6 +1206,8 @@ enum wx_pf_flags {
 	WX_FLAG_PTP_PPS_ENABLED,
 	WX_FLAG_NEED_LINK_CONFIG,
 	WX_FLAG_NEED_SFP_RESET,
+	WX_FLAG_NEED_UPDATE_LINK,
+	WX_FLAG_NEED_DO_RESET,
 	WX_PF_FLAGS_NBITS               /* must be last */
 };
 
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf.c b/drivers/net/ethernet/wangxun/libwx/wx_vf.c
index 165b83e9098f..7567216a005f 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf.c
@@ -471,3 +471,129 @@ int wx_get_queues_vf(struct wx *wx, u32 *num_tcs, u32 *default_tc)
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
+static void wx_check_physical_link(struct wx *wx)
+{
+	u32 val, link_val;
+	int ret;
+
+	/* get link status from hw status reg
+	 * for SFP+ modules and DA cables, it can take up to 500usecs
+	 * before the link status is correct
+	 */
+	if (wx->mac.type == wx_mac_em)
+		ret = read_poll_timeout_atomic(rd32, val, val & GENMASK(4, 1),
+					       100, 500, false, wx, WX_VXSTATUS);
+	else
+		ret = read_poll_timeout_atomic(rd32, val, val & BIT(0), 100,
+					       500, false, wx, WX_VXSTATUS);
+	if (ret) {
+		wx->speed = SPEED_UNKNOWN;
+		wx->link = false;
+		return;
+	}
+
+	wx->link = true;
+	link_val = WX_VXSTATUS_SPEED(val);
+
+	if (link_val & BIT(0))
+		wx->speed = wx_speed_lookup_vf[wx->mac.type].bit0_f;
+	else if (link_val & BIT(1))
+		wx->speed = wx_speed_lookup_vf[wx->mac.type].bit1_f;
+	else if (link_val & BIT(2))
+		wx->speed = wx_speed_lookup_vf[wx->mac.type].bit2_f;
+	else if (link_val & BIT(3))
+		wx->speed = wx_speed_lookup_vf[wx->mac.type].bit3_f;
+	else
+		wx->speed = SPEED_UNKNOWN;
+}
+
+int wx_check_mac_link_vf(struct wx *wx)
+{
+	struct wx_mbx_info *mbx = &wx->mbx;
+	u32 msgbuf[2] = {0};
+	int ret = 0;
+
+	if (!mbx->timeout)
+		goto out;
+
+	wx_check_for_rst_vf(wx);
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
+	case 0:
+		if (msgbuf[0] & WX_VT_MSGTYPE_NACK) {
+			/* msg is NACK, we must have lost CTS status */
+			ret = -EBUSY;
+			goto out;
+		}
+		/* no message, check link status */
+		wx_check_physical_link(wx);
+		goto out;
+	default:
+		break;
+	}
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
index dc3ed0808e15..ade2bfe563aa 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
@@ -48,6 +48,7 @@ void wxvf_remove(struct pci_dev *pdev)
 	struct wx *wx = pci_get_drvdata(pdev);
 	struct net_device *netdev;
 
+	cancel_work_sync(&wx->service_task);
 	netdev = wx->netdev;
 	unregister_netdev(netdev);
 	kfree(wx->vfinfo);
@@ -64,6 +65,7 @@ static irqreturn_t wx_msix_misc_vf(int __always_unused irq, void *data)
 {
 	struct wx *wx = data;
 
+	set_bit(WX_FLAG_NEED_UPDATE_LINK, wx->flags);
 	/* Clear the interrupt */
 	if (netif_running(wx->netdev))
 		wr32(wx, WX_VXIMC, wx->eims_other);
@@ -243,6 +245,24 @@ int wx_set_mac_vf(struct net_device *netdev, void *p)
 }
 EXPORT_SYMBOL(wx_set_mac_vf);
 
+void wxvf_watchdog_update_link(struct wx *wx)
+{
+	int err;
+
+	if (!test_bit(WX_FLAG_NEED_UPDATE_LINK, wx->flags))
+		return;
+
+	spin_lock_bh(&wx->mbx.mbx_lock);
+	err = wx_check_mac_link_vf(wx);
+	spin_unlock_bh(&wx->mbx.mbx_lock);
+	if (err) {
+		wx->link = false;
+		set_bit(WX_FLAG_NEED_DO_RESET, wx->flags);
+	}
+	clear_bit(WX_FLAG_NEED_UPDATE_LINK, wx->flags);
+}
+EXPORT_SYMBOL(wxvf_watchdog_update_link);
+
 static void wxvf_irq_enable(struct wx *wx)
 {
 	wr32(wx, WX_VXIMC, wx->eims_enable_mask);
@@ -250,6 +270,11 @@ static void wxvf_irq_enable(struct wx *wx)
 
 static void wxvf_up_complete(struct wx *wx)
 {
+	/* Always set the carrier off */
+	netif_carrier_off(wx->netdev);
+	mod_timer(&wx->service_timer, jiffies + HZ);
+	set_bit(WX_FLAG_NEED_UPDATE_LINK, wx->flags);
+
 	wx_configure_msix_vf(wx);
 	smp_mb__before_atomic();
 	wx_napi_enable_all(wx);
@@ -301,8 +326,10 @@ static void wxvf_down(struct wx *wx)
 {
 	struct net_device *netdev = wx->netdev;
 
+	timer_delete_sync(&wx->service_timer);
 	netif_tx_stop_all_queues(netdev);
 	netif_tx_disable(netdev);
+	netif_carrier_off(netdev);
 	wx_napi_disable_all(wx);
 	wx_reset_vf(wx);
 
@@ -310,6 +337,34 @@ static void wxvf_down(struct wx *wx)
 	wx_clean_all_rx_rings(wx);
 }
 
+static void wxvf_reinit_locked(struct wx *wx)
+{
+	while (test_and_set_bit(WX_STATE_RESETTING, wx->state))
+		usleep_range(1000, 2000);
+	wxvf_down(wx);
+	wx_free_irq(wx);
+	wx_configure_vf(wx);
+	wx_request_msix_irqs_vf(wx);
+	wxvf_up_complete(wx);
+	clear_bit(WX_STATE_RESETTING, wx->state);
+}
+
+static void wxvf_reset_subtask(struct wx *wx)
+{
+	if (!test_bit(WX_FLAG_NEED_DO_RESET, wx->flags))
+		return;
+	clear_bit(WX_FLAG_NEED_DO_RESET, wx->flags);
+
+	rtnl_lock();
+	if (test_bit(WX_STATE_RESETTING, wx->state) ||
+	    !(netif_running(wx->netdev))) {
+		rtnl_unlock();
+		return;
+	}
+	wxvf_reinit_locked(wx);
+	rtnl_unlock();
+}
+
 int wxvf_close(struct net_device *netdev)
 {
 	struct wx *wx = netdev_priv(netdev);
@@ -321,3 +376,39 @@ int wxvf_close(struct net_device *netdev)
 	return 0;
 }
 EXPORT_SYMBOL(wxvf_close);
+
+static void wxvf_link_config_subtask(struct wx *wx)
+{
+	struct net_device *netdev = wx->netdev;
+
+	wxvf_watchdog_update_link(wx);
+	if (wx->link) {
+		if (netif_carrier_ok(netdev))
+			return;
+		netif_carrier_on(netdev);
+		netdev_info(netdev, "Link is Up - %s\n",
+			    phy_speed_to_str(wx->speed));
+	} else {
+		if (!netif_carrier_ok(netdev))
+			return;
+		netif_carrier_off(netdev);
+		netdev_info(netdev, "Link is Down\n");
+	}
+}
+
+static void wxvf_service_task(struct work_struct *work)
+{
+	struct wx *wx = container_of(work, struct wx, service_task);
+
+	wxvf_link_config_subtask(wx);
+	wxvf_reset_subtask(wx);
+	wx_service_event_complete(wx);
+}
+
+void wxvf_init_service(struct wx *wx)
+{
+	timer_setup(&wx->service_timer, wx_service_timer, 0);
+	INIT_WORK(&wx->service_task, wxvf_service_task);
+	clear_bit(WX_STATE_SERVICE_SCHED, wx->state);
+}
+EXPORT_SYMBOL(wxvf_init_service);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.h b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.h
index 272743a3c878..cbbb1b178cb2 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.h
@@ -14,7 +14,9 @@ void wx_reset_vf(struct wx *wx);
 void wx_set_rx_mode_vf(struct net_device *netdev);
 void wx_configure_vf(struct wx *wx);
 int wx_set_mac_vf(struct net_device *netdev, void *p);
+void wxvf_watchdog_update_link(struct wx *wx);
 int wxvf_open(struct net_device *netdev);
 int wxvf_close(struct net_device *netdev);
+void wxvf_init_service(struct wx *wx);
 
 #endif /* _WX_VF_COMMON_H_ */
diff --git a/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c b/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
index 57e67804b8b7..ebfce3cf753e 100644
--- a/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
+++ b/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
@@ -250,6 +250,7 @@ static int txgbevf_probe(struct pci_dev *pdev,
 	eth_hw_addr_set(netdev, wx->mac.perm_addr);
 	ether_addr_copy(netdev->perm_addr, wx->mac.addr);
 
+	wxvf_init_service(wx);
 	err = wx_init_interrupt_scheme(wx);
 	if (err)
 		goto err_free_sw_init;
@@ -266,6 +267,8 @@ static int txgbevf_probe(struct pci_dev *pdev,
 err_register:
 	wx_clear_interrupt_scheme(wx);
 err_free_sw_init:
+	timer_delete_sync(&wx->service_timer);
+	cancel_work_sync(&wx->service_task);
 	kfree(wx->vfinfo);
 	kfree(wx->rss_key);
 	kfree(wx->mac_table);
-- 
2.30.1


