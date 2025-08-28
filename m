Return-Path: <netdev+bounces-217773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39911B39CAD
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 14:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8A661C82595
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 12:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4FF31A547;
	Thu, 28 Aug 2025 12:11:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240DF30F935;
	Thu, 28 Aug 2025 12:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756383060; cv=none; b=tW7WoCaD1PczRX0TucFFjX/E0of8K2IeA3mqbTvAZYF9xmxi8lSAKCXd50kSdJRPE2jHgAFJoOXA+tT5muXA9cni04+DImCEi3rDzDupjb2hED1qzszluSd/79USejHavrNRaPQ1Im3V3PBs3oFKhU4Jkz4MZ6GOSlY5SMdq7r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756383060; c=relaxed/simple;
	bh=R2YSfqcQb+O0qpFWAb+L9UM3D481BCQvii247pEakTg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M2Yr0U5PMenRdbSzwUpFxZb3wfuJMbaM9gR3NUypmFW8ObXRDp8jpfC/jJWEyOI4lw9VE5qKHT8zOgsTgCOCqFTMu2a8LNsm94pO418sp7UzsX8Gibo3Q/NpcGROMI4DBBgROE75e23mQH5rd5kkruiMbMW0tSFSVJ8SiOmJvZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cCKx44kF0z14Mg5;
	Thu, 28 Aug 2025 20:10:48 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 1352C14011F;
	Thu, 28 Aug 2025 20:10:56 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.55) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 28 Aug 2025 20:10:54 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas
	<helgaas@kernel.org>, luosifu <luosifu@huawei.com>, Xin Guo
	<guoxin09@huawei.com>, Shen Chenyang <shenchenyang1@hisilicon.com>, Zhou
 Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Meny Yossefi <meny.yossefi@huawei.com>, Gur Stavi
	<gur.stavi@huawei.com>, Lee Trager <lee@trager.us>, Michael Ellerman
	<mpe@ellerman.id.au>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, Suman
 Ghosh <sumang@marvell.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Joe Damato <jdamato@fastly.com>, Christophe JAILLET
	<christophe.jaillet@wanadoo.fr>
Subject: [PATCH net-next v02 12/14] hinic3: Add port management
Date: Thu, 28 Aug 2025 20:10:18 +0800
Message-ID: <a01c0c68927ada325e342d7fd5997db2ecb69dfa.1756378721.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1756378721.git.zhuyikai1@h-partners.com>
References: <cover.1756378721.git.zhuyikai1@h-partners.com>
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

Add port management of enable/disable/query/flush function.

Co-developed-by: Xin Guo <guoxin09@huawei.com>
Signed-off-by: Xin Guo <guoxin09@huawei.com>
Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 .../huawei/hinic3/hinic3_mgmt_interface.h     | 29 ++++++++
 .../huawei/hinic3/hinic3_netdev_ops.c         | 57 ++++++++++++++++
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.c   | 68 +++++++++++++++++++
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.h   |  4 ++
 4 files changed, 158 insertions(+)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h
index 7012130bba1d..6cc0345c39e4 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h
@@ -69,12 +69,27 @@ struct l2nic_cmd_set_ci_attr {
 	u64                  ci_addr;
 };
 
+struct l2nic_cmd_clear_qp_resource {
+	struct mgmt_msg_head msg_head;
+	u16                  func_id;
+	u16                  rsvd1;
+};
+
 struct l2nic_cmd_force_pkt_drop {
 	struct mgmt_msg_head msg_head;
 	u8                   port;
 	u8                   rsvd1[3];
 };
 
+struct l2nic_cmd_set_vport_state {
+	struct mgmt_msg_head msg_head;
+	u16                  func_id;
+	u16                  rsvd1;
+	/* 0--disable, 1--enable */
+	u8                   state;
+	u8                   rsvd2[3];
+};
+
 struct l2nic_cmd_set_dcb_state {
 	struct mgmt_msg_head head;
 	u16                  func_id;
@@ -172,6 +187,20 @@ enum l2nic_ucode_cmd {
 	L2NIC_UCODE_CMD_SET_RSS_INDIR_TBL = 4,
 };
 
+/* hilink mac group command */
+enum mag_cmd {
+	MAG_CMD_GET_LINK_STATUS = 7,
+};
+
+/* firmware also use this cmd report link event to driver */
+struct mag_cmd_get_link_status {
+	struct mgmt_msg_head head;
+	u8                   port_id;
+	/* 0:link down  1:link up */
+	u8                   status;
+	u8                   rsvd0[2];
+};
+
 enum hinic3_nic_feature_cap {
 	HINIC3_NIC_F_CSUM           = BIT(0),
 	HINIC3_NIC_F_SCTP_CRC       = BIT(1),
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
index 2ba9f0936589..8e0d89c636b7 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
@@ -334,6 +334,55 @@ static void hinic3_close_channel(struct net_device *netdev)
 	hinic3_free_qp_ctxts(nic_dev);
 }
 
+static int hinic3_vport_up(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	bool link_status_up;
+	u16 glb_func_id;
+	int err;
+
+	glb_func_id = hinic3_global_func_id(nic_dev->hwdev);
+	err = hinic3_set_vport_enable(nic_dev->hwdev, glb_func_id, true);
+	if (err) {
+		netdev_err(netdev, "Failed to enable vport\n");
+		goto err_flush_qps_res;
+	}
+
+	netif_set_real_num_tx_queues(netdev, nic_dev->q_params.num_qps);
+	netif_set_real_num_rx_queues(netdev, nic_dev->q_params.num_qps);
+	netif_tx_start_all_queues(netdev);
+
+	err = hinic3_get_link_status(nic_dev->hwdev, &link_status_up);
+	if (!err && link_status_up)
+		netif_carrier_on(netdev);
+
+	return 0;
+
+err_flush_qps_res:
+	hinic3_flush_qps_res(nic_dev->hwdev);
+	/* wait to guarantee that no packets will be sent to host */
+	msleep(100);
+
+	return err;
+}
+
+static void hinic3_vport_down(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	u16 glb_func_id;
+
+	netif_carrier_off(netdev);
+	netif_tx_disable(netdev);
+
+	glb_func_id = hinic3_global_func_id(nic_dev->hwdev);
+	hinic3_set_vport_enable(nic_dev->hwdev, glb_func_id, false);
+
+	hinic3_flush_txqs(netdev);
+	/* wait to guarantee that no packets will be sent to host */
+	msleep(100);
+	hinic3_flush_qps_res(nic_dev->hwdev);
+}
+
 static int hinic3_open(struct net_device *netdev)
 {
 	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
@@ -363,8 +412,15 @@ static int hinic3_open(struct net_device *netdev)
 	if (err)
 		goto err_uninit_qps;
 
+	err = hinic3_vport_up(netdev);
+	if (err)
+		goto err_close_channel;
+
 	return 0;
 
+err_close_channel:
+	hinic3_close_channel(netdev);
+
 err_uninit_qps:
 	hinic3_uninit_qps(nic_dev, &qp_params);
 	hinic3_free_channel_resources(netdev, &qp_params, &nic_dev->q_params);
@@ -383,6 +439,7 @@ static int hinic3_close(struct net_device *netdev)
 	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
 	struct hinic3_dyna_qp_params qp_params;
 
+	hinic3_vport_down(netdev);
 	hinic3_close_channel(netdev);
 	hinic3_uninit_qps(nic_dev, &qp_params);
 	hinic3_free_channel_resources(netdev, &qp_params, &nic_dev->q_params);
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
index ed70750f5ae8..9349b8a314ae 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
@@ -267,6 +267,28 @@ int hinic3_set_ci_table(struct hinic3_hwdev *hwdev, struct hinic3_sq_attr *attr)
 	return 0;
 }
 
+int hinic3_flush_qps_res(struct hinic3_hwdev *hwdev)
+{
+	struct l2nic_cmd_clear_qp_resource sq_res = {};
+	struct mgmt_msg_params msg_params = {};
+	int err;
+
+	sq_res.func_id = hinic3_global_func_id(hwdev);
+
+	mgmt_msg_params_init_default(&msg_params, &sq_res, sizeof(sq_res));
+
+	err = hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_L2NIC,
+				       L2NIC_CMD_CLEAR_QP_RESOURCE,
+				       &msg_params);
+	if (err || sq_res.msg_head.status) {
+		dev_err(hwdev->dev, "Failed to clear sq resources, err: %d, status: 0x%x\n",
+			err, sq_res.msg_head.status);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 int hinic3_force_drop_tx_pkt(struct hinic3_hwdev *hwdev)
 {
 	struct l2nic_cmd_force_pkt_drop pkt_drop = {};
@@ -314,3 +336,49 @@ int hinic3_sync_dcb_state(struct hinic3_hwdev *hwdev, u8 op_code, u8 state)
 
 	return 0;
 }
+
+int hinic3_get_link_status(struct hinic3_hwdev *hwdev, bool *link_status_up)
+{
+	struct mag_cmd_get_link_status get_link = {};
+	struct mgmt_msg_params msg_params = {};
+	int err;
+
+	get_link.port_id = hinic3_physical_port_id(hwdev);
+
+	mgmt_msg_params_init_default(&msg_params, &get_link, sizeof(get_link));
+
+	err = hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_HILINK,
+				       MAG_CMD_GET_LINK_STATUS, &msg_params);
+	if (err || get_link.head.status) {
+		dev_err(hwdev->dev, "Failed to get link state, err: %d, status: 0x%x\n",
+			err, get_link.head.status);
+		return -EIO;
+	}
+
+	*link_status_up = !!get_link.status;
+
+	return 0;
+}
+
+int hinic3_set_vport_enable(struct hinic3_hwdev *hwdev, u16 func_id,
+			    bool enable)
+{
+	struct l2nic_cmd_set_vport_state en_state = {};
+	struct mgmt_msg_params msg_params = {};
+	int err;
+
+	en_state.func_id = func_id;
+	en_state.state = enable ? 1 : 0;
+
+	mgmt_msg_params_init_default(&msg_params, &en_state, sizeof(en_state));
+
+	err = hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_L2NIC,
+				       L2NIC_CMD_SET_VPORT_ENABLE, &msg_params);
+	if (err || en_state.msg_head.status) {
+		dev_err(hwdev->dev, "Failed to set vport state, err: %d, status: 0x%x\n",
+			err, en_state.msg_head.status);
+		return -EINVAL;
+	}
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
index 719b81e2bc2a..b83b567fa542 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
@@ -50,8 +50,12 @@ int hinic3_update_mac(struct hinic3_hwdev *hwdev, const u8 *old_mac,
 
 int hinic3_set_ci_table(struct hinic3_hwdev *hwdev,
 			struct hinic3_sq_attr *attr);
+int hinic3_flush_qps_res(struct hinic3_hwdev *hwdev);
 int hinic3_force_drop_tx_pkt(struct hinic3_hwdev *hwdev);
 
 int hinic3_sync_dcb_state(struct hinic3_hwdev *hwdev, u8 op_code, u8 state);
+int hinic3_get_link_status(struct hinic3_hwdev *hwdev, bool *link_status_up);
+int hinic3_set_vport_enable(struct hinic3_hwdev *hwdev, u16 func_id,
+			    bool enable);
 
 #endif
-- 
2.43.0


