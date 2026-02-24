Return-Path: <netdev+bounces-260527-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCOKJduknWmZQwQAu9opvQ
	(envelope-from <netdev+bounces-260527-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 14:17:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 185C71877A6
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 14:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D7C6230B9CB5
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 13:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F2939E19F;
	Tue, 24 Feb 2026 13:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="jkna6yPe"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7021239E176;
	Tue, 24 Feb 2026 13:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771938977; cv=none; b=AxqISl3joJ3+A/QMLih64kg3YXQPlE+uUA4XaPydmtQGjh79LtCL0HH6XUYHQlBwKevoQ/XjpfRTAJzVTxD/tBa0Zl6vqdKhxd/ry47ZHq1ynfozSL4ltSGnl9F3eNS3deF0ta2ELGQs1+VxBM72W5vQfevoKDc6OfAF86iucbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771938977; c=relaxed/simple;
	bh=SHthbn4VGlu/Beddc2xoszPZllY3FA992BSmvBZLKRw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cm0jdXP3F1E7qKlzA4r7kPOVj05ldZBoyKO3UMGeZi83B3613BusYVdCmzZKrDtMxXAx20Ke2skn/BiEn8j6i/ky0OKp9y7d2Pe0GLqUnC7xDoTFTQROrhVIcWRyKDo/nYJyAcEF0OpEaHT0r7lTtbM8opI4k1cXhE0zMz5qO5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=jkna6yPe; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=3MSe58sTIpT/PsMEP/t7EW6U1is858It/nNQbziFH44=;
	b=jkna6yPelo26c4CY2fV6Vd3s0yGoBTgw0bKXeXPK1Ect4DJIYljrUvwKE9x6jtRGW8+jcXmsE
	KfNT8eigzaMDw6/C3pv87fqM4/iGSYS4qyjKGffm6/WIvP5a1RtSlpfHD7mF7BMcWIy3ieZvTN/
	4D07gUotaRyRID8AYxqRf+E=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4fKylv1g0NzRhvY;
	Tue, 24 Feb 2026 21:11:23 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id DA075201EB;
	Tue, 24 Feb 2026 21:16:08 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 24 Feb 2026 21:16:07 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>
Subject: [PATCH net-next v01 03/15] hinic3: Add chip_present_flag checks to prevent errors when card is absent
Date: Tue, 24 Feb 2026 21:15:40 +0800
Message-ID: <2ac16da010b80f4a5286b23a62bc90eeddca528e.1771916043.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1771916043.git.zhuyikai1@h-partners.com>
References: <cover.1771916043.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf100013.china.huawei.com (7.202.181.12)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260527-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gongfan1@huawei.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[h-partners.com:mid,h-partners.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 185C71877A6
X-Rspamd-Action: no action

Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.c | 10 +++++++++-
 .../net/ethernet/huawei/hinic3/hinic3_common.h   |  1 +
 .../net/ethernet/huawei/hinic3/hinic3_hw_comm.c  |  7 +++++++
 .../net/ethernet/huawei/hinic3/hinic3_hwdev.c    |  5 +++++
 .../net/ethernet/huawei/hinic3/hinic3_hwdev.h    |  1 +
 drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c | 10 +++++++---
 drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c | 12 ++++++++++++
 .../ethernet/huawei/hinic3/hinic3_netdev_ops.c   | 16 ++++++++++------
 8 files changed, 52 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.c b/drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.c
index 928bcd857751..a1189751e2a8 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.c
@@ -353,7 +353,8 @@ static int wait_cmdqs_enable(struct hinic3_cmdqs *cmdqs)
 		if (cmdqs->status & HINIC3_CMDQ_ENABLE)
 			return 0;
 		usleep_range(1000, 2000);
-	} while (time_before(jiffies, end) && !cmdqs->disable_flag);
+	} while (time_before(jiffies, end) && !cmdqs->disable_flag &&
+		 cmdqs->hwdev->chip_present_flag);
 
 	cmdqs->disable_flag = 1;
 
@@ -733,6 +734,10 @@ int hinic3_cmdq_direct_resp(struct hinic3_hwdev *hwdev, u8 mod, u8 cmd,
 {
 	struct hinic3_cmdqs *cmdqs;
 	int err;
+
+	if (!hwdev->chip_present_flag)
+		return -ETIMEDOUT;
+
 	err = cmdq_params_valid(hwdev, buf_in);
 	if (err) {
 		dev_err(hwdev->dev, "Invalid CMDQ parameters\n");
@@ -762,6 +767,9 @@ int hinic3_cmdq_detail_resp(struct hinic3_hwdev *hwdev, u8 mod, u8 cmd,
 	struct hinic3_cmdqs *cmdqs;
 	int err;
 
+	if (!hwdev->chip_present_flag)
+		return -ETIMEDOUT;
+
 	err = cmdq_params_valid(hwdev, buf_in);
 	if (err)
 		goto err_out;
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_common.h b/drivers/net/ethernet/huawei/hinic3/hinic3_common.h
index a8fabfae90fb..c892439fa3cd 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_common.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_common.h
@@ -21,6 +21,7 @@ struct hinic3_dma_addr_align {
 enum hinic3_wait_return {
 	HINIC3_WAIT_PROCESS_CPL     = 0,
 	HINIC3_WAIT_PROCESS_WAITING = 1,
+	HINIC3_WAIT_PROCESS_ERR     = 2,
 };
 
 struct hinic3_sge {
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
index ecfe6265954e..dc2f236a88b8 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
@@ -300,6 +300,10 @@ static enum hinic3_wait_return check_cmdq_stop_handler(void *priv_data)
 	enum hinic3_cmdq_type cmdq_type;
 	struct hinic3_cmdqs *cmdqs;
 
+	/* Stop waiting when card unpresent */
+	if (!hwdev->chip_present_flag)
+		return HINIC3_WAIT_PROCESS_CPL;
+
 	cmdqs = hwdev->cmdqs;
 	for (cmdq_type = 0; cmdq_type < cmdqs->cmdq_num; cmdq_type++) {
 		if (!hinic3_cmdq_idle(&cmdqs->cmdq[cmdq_type]))
@@ -347,6 +351,9 @@ int hinic3_func_rx_tx_flush(struct hinic3_hwdev *hwdev)
 	int ret = 0;
 	int err;
 
+	if (!hwdev->chip_present_flag)
+		return 0;
+
 	err = wait_cmdq_stop(hwdev);
 	if (err) {
 		dev_warn(hwdev->dev, "CMDQ is still working, CMDQ timeout value is unreasonable\n");
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
index 7906d4057cf2..c02a0a4a5771 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
@@ -32,6 +32,9 @@
 #define HINIC3_PCIE_PH_DISABLE       0
 #define HINIC3_PCIE_MSIX_ATTR_ENTRY  0
 
+#define HINIC3_CHIP_PRESENT          1
+#define HINIC3_CHIP_ABSENT           0
+
 #define HINIC3_DEFAULT_EQ_MSIX_PENDING_LIMIT      0
 #define HINIC3_DEFAULT_EQ_MSIX_COALESC_TIMER_CFG  0xFF
 #define HINIC3_DEFAULT_EQ_MSIX_RESEND_TIMER_CFG   7
@@ -545,6 +548,7 @@ int hinic3_init_hwdev(struct pci_dev *pdev)
 		dev_err(hwdev->dev, "Failed to init hwif\n");
 		goto err_free_hwdev;
 	}
+	hwdev->chip_present_flag = HINIC3_CHIP_PRESENT;
 
 	hwdev->workq = alloc_workqueue(HINIC3_HWDEV_WQ_NAME, WQ_MEM_RECLAIM | WQ_PERCPU,
 				       HINIC3_WQ_MAX_REQ);
@@ -621,6 +625,7 @@ void hinic3_set_api_stop(struct hinic3_hwdev *hwdev)
 	struct hinic3_recv_msg *recv_resp_msg;
 	struct hinic3_mbox *mbox;
 
+	hwdev->chip_present_flag = HINIC3_CHIP_ABSENT;
 	spin_lock_bh(&hwdev->channel_lock);
 	if (HINIC3_IS_PF(hwdev) &&
 	    test_bit(HINIC3_HWDEV_MGMT_INITED, &hwdev->func_state)) {
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.h
index 9686c2600b46..4276ac136464 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.h
@@ -76,6 +76,7 @@ struct hinic3_hwdev {
 	u32                         wq_page_size;
 	u8                          max_cmdq;
 	ulong                       func_state;
+	int                         chip_present_flag;
 };
 
 struct hinic3_event_info {
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c
index 801f48e241f8..e4dd4c717eec 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c
@@ -94,12 +94,16 @@ void hinic3_hwif_write_reg(struct hinic3_hwif *hwif, u32 reg, u32 val)
 static enum hinic3_wait_return check_hwif_ready_handler(void *priv_data)
 {
 	struct hinic3_hwdev *hwdev = priv_data;
-	u32 attr1;
+	u32 attr1, status;
 
 	attr1 = hinic3_hwif_read_reg(hwdev->hwif, HINIC3_CSR_FUNC_ATTR1_ADDR);
+	status = !HINIC3_AF1_GET(attr1, MGMT_INIT_STATUS);
+	if (status == HINIC3_PCIE_LINK_DOWN)
+		return HINIC3_WAIT_PROCESS_ERR;
+	else if (!status)
+		return HINIC3_WAIT_PROCESS_CPL;
 
-	return HINIC3_AF1_GET(attr1, MGMT_INIT_STATUS) ?
-	       HINIC3_WAIT_PROCESS_CPL : HINIC3_WAIT_PROCESS_WAITING;
+	return HINIC3_WAIT_PROCESS_WAITING;
 }
 
 static int wait_hwif_ready(struct hinic3_hwdev *hwdev)
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c b/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c
index 1bfaff9ba253..63cc70bce8b0 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c
@@ -646,6 +646,9 @@ static enum hinic3_wait_return check_mbox_wb_status(void *priv_data)
 	struct hinic3_mbox *mbox = priv_data;
 	u16 wb_status;
 
+	if (!mbox->hwdev->chip_present_flag)
+		return HINIC3_WAIT_PROCESS_ERR;
+
 	wb_status = get_mbox_status(&mbox->send_mbox);
 
 	return MBOX_STATUS_FINISHED(wb_status) ?
@@ -788,6 +791,9 @@ static enum hinic3_wait_return check_mbox_msg_finish(void *priv_data)
 {
 	struct hinic3_mbox *mbox = priv_data;
 
+	if (!mbox->hwdev->chip_present_flag)
+		return HINIC3_WAIT_PROCESS_ERR;
+
 	return (mbox->event_flag == MBOX_EVENT_SUCCESS) ?
 		HINIC3_WAIT_PROCESS_CPL : HINIC3_WAIT_PROCESS_WAITING;
 }
@@ -819,6 +825,9 @@ int hinic3_send_mbox_to_mgmt(struct hinic3_hwdev *hwdev, u8 mod, u16 cmd,
 	u32 msg_len;
 	int err;
 
+	if (!hwdev->chip_present_flag)
+		return -EPERM;
+
 	/* expect response message */
 	msg_desc = get_mbox_msg_desc(mbox, MBOX_MSG_RESP, MBOX_MGMT_FUNC_ID);
 	mutex_lock(&mbox->mbox_send_lock);
@@ -897,6 +906,9 @@ int hinic3_send_mbox_to_mgmt_no_ack(struct hinic3_hwdev *hwdev, u8 mod, u16 cmd,
 	struct mbox_msg_info msg_info = {};
 	int err;
 
+	if (!hwdev->chip_present_flag)
+		return -EPERM;
+
 	mutex_lock(&mbox->mbox_send_lock);
 	err = send_mbox_msg(mbox, mod, cmd, msg_params->buf_in,
 			    msg_params->in_size, MBOX_MGMT_FUNC_ID,
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
index 75adfe897e81..75b6abdf1024 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
@@ -417,13 +417,17 @@ static void hinic3_vport_down(struct net_device *netdev)
 	netif_carrier_off(netdev);
 	netif_tx_disable(netdev);
 
-	glb_func_id = hinic3_global_func_id(nic_dev->hwdev);
-	hinic3_set_vport_enable(nic_dev->hwdev, glb_func_id, false);
+	if (nic_dev->hwdev->chip_present_flag) {
+		hinic3_maybe_set_port_state(netdev, false);
 
-	hinic3_flush_txqs(netdev);
-	/* wait to guarantee that no packets will be sent to host */
-	msleep(100);
-	hinic3_flush_qps_res(nic_dev->hwdev);
+		glb_func_id = hinic3_global_func_id(nic_dev->hwdev);
+		hinic3_set_vport_enable(nic_dev->hwdev, glb_func_id, false);
+
+		hinic3_flush_txqs(netdev);
+		/* wait to guarantee that no packets will be sent to host */
+		msleep(100);
+		hinic3_flush_qps_res(nic_dev->hwdev);
+	}
 }
 
 static int hinic3_open(struct net_device *netdev)
-- 
2.43.0


