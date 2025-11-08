Return-Path: <netdev+bounces-236962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5E4C4286B
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 07:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B1CEC4E1028
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 06:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E6C2DFF13;
	Sat,  8 Nov 2025 06:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="i06CmaIi"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EFE2DE71C;
	Sat,  8 Nov 2025 06:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762584119; cv=none; b=sLlx2Jvpv1w6hT15Y94V5+Mi174zoYRZBigYyG6ugGpokGuQhE+9vzgRbsKtIMdMHhU/lJLyXkBhve3P4GWenfKzUWyJzUYp1M5OhqsfdJVZngskAmfjrWjY2yiqfP6Bk3DCkwXOvMk/qhZzmIV2zgPqo72PKWB+1aFzenIVLqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762584119; c=relaxed/simple;
	bh=FHHuqy9WjZLKOLUB5exgCufasDt+9y26PVhubOifZXE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qlcBYb94ZXZDykH88uGHfAOmtjHlsdDTATf40655WPJHQRig369OEIyXqPHPEegYL2IKk1kevoTGU9El5V0Ra0LFtr8SbtLxO1wfyezfyo8a7X9ja8s4hCjTOYEeWCY+X1n7hqISBOpydex+vgugUDcar86nfYauNm8KicytQ5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=i06CmaIi; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=wLylq4B6qHYRe7TDeTV7c0qQI3/ooCCgh2F5y9Q1TOQ=;
	b=i06CmaIizXiGepZxSgb1t/mCPGi3+f3KsJcVFlwNwtFesQUKy/nbzPCH6zdHSL28z9bcqhWBY
	2hBSeJSAsy1DfhWjvlOUhOCkf0SH/UdC+kCV+Iwgw6JYLuJxroYkJBM7Z6HTIkhYSH9lGZ28kXW
	jaGG25HOTOUibhoohnUAqxA=
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4d3RBR6NPzz1prKK;
	Sat,  8 Nov 2025 14:40:15 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 71D6118048E;
	Sat,  8 Nov 2025 14:41:53 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.188.120) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 8 Nov 2025 14:41:52 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Markus Elfring <Markus.Elfring@web.de>, Pavan Chebbi
	<pavan.chebbi@broadcom.com>, ALOK TIWARI <alok.a.tiwari@oracle.com>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Shen Chenyang
	<shenchenyang1@hisilicon.com>, Zhou Shuai <zhoushuai28@huawei.com>, Wu Like
	<wulike1@huawei.com>, Shi Jing <shijing34@huawei.com>, Luo Yang
	<luoyang82@h-partners.com>, Meny Yossefi <meny.yossefi@huawei.com>, Gur Stavi
	<gur.stavi@huawei.com>
Subject: [PATCH net-next v06 2/5] hinic3: Add PF management interfaces
Date: Sat, 8 Nov 2025 14:41:37 +0800
Message-ID: <c344db0c471b6b1321994958727df1c005a65daa.1762581665.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1762581665.git.zhuyikai1@h-partners.com>
References: <cover.1762581665.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf100013.china.huawei.com (7.202.181.12)

Add management and communication pathways between PF and HW.

Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 .../ethernet/huawei/hinic3/hinic3_hw_intf.h   |   2 +
 .../net/ethernet/huawei/hinic3/hinic3_hwdev.c |  51 ++-
 .../net/ethernet/huawei/hinic3/hinic3_hwdev.h |   1 +
 .../net/ethernet/huawei/hinic3/hinic3_main.c  |   2 +
 .../net/ethernet/huawei/hinic3/hinic3_mbox.c  |  13 +
 .../net/ethernet/huawei/hinic3/hinic3_mbox.h  |   2 +
 .../net/ethernet/huawei/hinic3/hinic3_mgmt.c  | 311 +++++++++++++++++-
 .../net/ethernet/huawei/hinic3/hinic3_mgmt.h  |  53 +++
 .../huawei/hinic3/hinic3_mgmt_interface.h     |   1 +
 .../huawei/hinic3/hinic3_netdev_ops.c         |  35 ++
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.c   |  28 ++
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.h   |  18 +
 .../ethernet/huawei/hinic3/hinic3_nic_dev.h   |   2 +
 13 files changed, 517 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h
index a0422ec0500f..329a9c464ff9 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h
@@ -39,6 +39,8 @@ enum mgmt_mod_type {
 	/* Configuration module */
 	MGMT_MOD_CFGM   = 7,
 	MGMT_MOD_HILINK = 14,
+	/* hardware max module id */
+	MGMT_MOD_HW_MAX = 20,
 };
 
 static inline void mgmt_msg_params_init_default(struct mgmt_msg_params *msg_params,
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
index 2b1f1036620e..25e375b20174 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
@@ -211,6 +211,36 @@ static int init_ceqs_msix_attr(struct hinic3_hwdev *hwdev)
 	return 0;
 }
 
+static int hinic3_comm_pf_to_mgmt_init(struct hinic3_hwdev *hwdev)
+{
+	int err;
+
+	if (HINIC3_IS_VF(hwdev))
+		return 0;
+
+	err = hinic3_pf_to_mgmt_init(hwdev);
+	if (err)
+		return err;
+
+	set_bit(HINIC3_HWDEV_MGMT_INITED, &hwdev->func_state);
+
+	return 0;
+}
+
+static void hinic3_comm_pf_to_mgmt_free(struct hinic3_hwdev *hwdev)
+{
+	if (HINIC3_IS_VF(hwdev))
+		return;
+
+	spin_lock_bh(&hwdev->channel_lock);
+	clear_bit(HINIC3_HWDEV_MGMT_INITED, &hwdev->func_state);
+	spin_unlock_bh(&hwdev->channel_lock);
+
+	hinic3_aeq_unregister_cb(hwdev, HINIC3_MSG_FROM_FW);
+
+	hinic3_pf_to_mgmt_free(hwdev);
+}
+
 static int init_basic_mgmt_channel(struct hinic3_hwdev *hwdev)
 {
 	int err;
@@ -412,10 +442,14 @@ static int hinic3_init_comm_ch(struct hinic3_hwdev *hwdev)
 	if (err)
 		return err;
 
-	err = init_basic_attributes(hwdev);
+	err = hinic3_comm_pf_to_mgmt_init(hwdev);
 	if (err)
 		goto err_free_basic_mgmt_ch;
 
+	err = init_basic_attributes(hwdev);
+	if (err)
+		goto err_free_comm_pf_to_mgmt;
+
 	err = init_cmdqs_channel(hwdev);
 	if (err) {
 		dev_err(hwdev->dev, "Failed to init cmdq channel\n");
@@ -428,6 +462,8 @@ static int hinic3_init_comm_ch(struct hinic3_hwdev *hwdev)
 
 err_clear_func_svc_used_state:
 	hinic3_set_func_svc_used_state(hwdev, COMM_FUNC_SVC_T_COMM, 0);
+err_free_comm_pf_to_mgmt:
+	hinic3_comm_pf_to_mgmt_free(hwdev);
 err_free_basic_mgmt_ch:
 	free_base_mgmt_channel(hwdev);
 
@@ -439,6 +475,7 @@ static void hinic3_uninit_comm_ch(struct hinic3_hwdev *hwdev)
 	hinic3_set_pf_status(hwdev->hwif, HINIC3_PF_STATUS_INIT);
 	hinic3_free_cmdqs_channel(hwdev);
 	hinic3_set_func_svc_used_state(hwdev, COMM_FUNC_SVC_T_COMM, 0);
+	hinic3_comm_pf_to_mgmt_free(hwdev);
 	free_base_mgmt_channel(hwdev);
 }
 
@@ -581,9 +618,21 @@ void hinic3_free_hwdev(struct hinic3_hwdev *hwdev)
 
 void hinic3_set_api_stop(struct hinic3_hwdev *hwdev)
 {
+	struct hinic3_recv_msg *recv_resp_msg;
 	struct hinic3_mbox *mbox;
 
 	spin_lock_bh(&hwdev->channel_lock);
+	if (HINIC3_IS_PF(hwdev) &&
+	    test_bit(HINIC3_HWDEV_MGMT_INITED, &hwdev->func_state)) {
+		recv_resp_msg = &hwdev->pf_to_mgmt->recv_resp_msg_from_mgmt;
+		spin_lock_bh(&hwdev->pf_to_mgmt->sync_event_lock);
+		if (hwdev->pf_to_mgmt->event_flag == COMM_SEND_EVENT_START) {
+			complete(&recv_resp_msg->recv_done);
+			hwdev->pf_to_mgmt->event_flag = COMM_SEND_EVENT_TIMEOUT;
+		}
+		spin_unlock_bh(&hwdev->pf_to_mgmt->sync_event_lock);
+	}
+
 	if (test_bit(HINIC3_HWDEV_MBOX_INITED, &hwdev->func_state)) {
 		mbox = hwdev->mbox;
 		spin_lock(&mbox->mbox_lock);
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.h
index 78cface6ddd7..3c15f22973fe 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.h
@@ -51,6 +51,7 @@ struct hinic3_hwdev {
 	struct hinic3_cmdqs         *cmdqs;
 	struct delayed_work         sync_time_task;
 	struct workqueue_struct     *workq;
+	struct hinic3_msg_pf_to_mgmt *pf_to_mgmt;
 	/* protect channel init and uninit */
 	spinlock_t                  channel_lock;
 	u64                         features[COMM_MAX_FEATURE_QWORD];
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
index 9249dd588feb..5570a3e6b6ad 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
@@ -133,6 +133,8 @@ static int hinic3_sw_init(struct net_device *netdev)
 	u8 mac_addr[ETH_ALEN];
 	int err;
 
+	sema_init(&nic_dev->port_state_sem, 1);
+
 	nic_dev->q_params.sq_depth = HINIC3_SQ_DEPTH;
 	nic_dev->q_params.rq_depth = HINIC3_RQ_DEPTH;
 
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c b/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c
index 1cb0d88911a2..90e704107e7e 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c
@@ -858,6 +858,19 @@ int hinic3_send_mbox_to_mgmt(struct hinic3_hwdev *hwdev, u8 mod, u16 cmd,
 	return err;
 }
 
+void hinic3_response_mbox_to_mgmt(struct hinic3_hwdev *hwdev, u8 mod, u16 cmd,
+				  const void *buf_in, u32 in_size, u16 msg_id)
+{
+	struct mbox_msg_info msg_info;
+
+	msg_info.msg_id = (u8)msg_id;
+	msg_info.status = 0;
+
+	send_mbox_msg(hwdev->mbox, mod, cmd, buf_in, in_size,
+		      MBOX_MGMT_FUNC_ID, MBOX_MSG_RESP,
+		      MBOX_MSG_NO_ACK, &msg_info);
+}
+
 int hinic3_send_mbox_to_mgmt_no_ack(struct hinic3_hwdev *hwdev, u8 mod, u16 cmd,
 				    const struct mgmt_msg_params *msg_params)
 {
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.h b/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.h
index e71629e95086..e26f22d1d564 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.h
@@ -135,6 +135,8 @@ void hinic3_free_mbox(struct hinic3_hwdev *hwdev);
 
 int hinic3_send_mbox_to_mgmt(struct hinic3_hwdev *hwdev, u8 mod, u16 cmd,
 			     const struct mgmt_msg_params *msg_params);
+void hinic3_response_mbox_to_mgmt(struct hinic3_hwdev *hwdev, u8 mod, u16 cmd,
+				  const void *buf_in, u32 in_size, u16 msg_id);
 int hinic3_send_mbox_to_mgmt_no_ack(struct hinic3_hwdev *hwdev, u8 mod, u16 cmd,
 				    const struct mgmt_msg_params *msg_params);
 
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt.c b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt.c
index c38d10cd7fac..e1d2a4444663 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt.c
@@ -3,19 +3,328 @@
 
 #include "hinic3_eqs.h"
 #include "hinic3_hwdev.h"
+#include "hinic3_hwif.h"
 #include "hinic3_mbox.h"
 #include "hinic3_mgmt.h"
 
+#define HINIC3_MSG_TO_MGMT_MAX_LEN  2016
+
+#define MGMT_MAX_PF_BUF_SIZE        2048UL
+#define MGMT_SEG_LEN_MAX            48
+#define MGMT_ASYNC_MSG_FLAG         0x8
+
+#define HINIC3_MGMT_WQ_NAME         "hinic3_mgmt"
+
+/* Bogus sequence ID to prevent accidental match following partial message */
+#define MGMT_BOGUS_SEQ_ID  \
+	(MGMT_MAX_PF_BUF_SIZE / MGMT_SEG_LEN_MAX + 1)
+
+static void
+hinic3_mgmt_resp_msg_handler(struct hinic3_msg_pf_to_mgmt *pf_to_mgmt,
+			     struct hinic3_recv_msg *recv_msg)
+{
+	struct device *dev = pf_to_mgmt->hwdev->dev;
+
+	/* Ignore async msg */
+	if (recv_msg->msg_id & MGMT_ASYNC_MSG_FLAG)
+		return;
+
+	spin_lock(&pf_to_mgmt->sync_event_lock);
+	if (recv_msg->msg_id != pf_to_mgmt->sync_msg_id) {
+		dev_err(dev, "msg id mismatch, send msg id: 0x%x, recv msg id: 0x%x, event state: %d\n",
+			pf_to_mgmt->sync_msg_id, recv_msg->msg_id,
+			pf_to_mgmt->event_flag);
+	} else if (pf_to_mgmt->event_flag == COMM_SEND_EVENT_START) {
+		pf_to_mgmt->event_flag = COMM_SEND_EVENT_SUCCESS;
+		complete(&recv_msg->recv_done);
+	} else {
+		dev_err(dev, "Wait timeout, send msg id: 0x%x, recv msg id: 0x%x, event state: %d\n",
+			pf_to_mgmt->sync_msg_id, recv_msg->msg_id,
+			pf_to_mgmt->event_flag);
+	}
+	spin_unlock(&pf_to_mgmt->sync_event_lock);
+}
+
+static void hinic3_recv_mgmt_msg_work_handler(struct work_struct *work)
+{
+	struct hinic3_msg_pf_to_mgmt *pf_to_mgmt;
+	struct mgmt_msg_handle_work *mgmt_work;
+	struct mgmt_msg_head *ack_cmd;
+
+	mgmt_work = container_of(work, struct mgmt_msg_handle_work, work);
+
+	/* At the moment, we do not expect any meaningful messages but if the
+	 * sender expects an ACK we still need to provide one with "unsupported"
+	 * status.
+	 */
+	if (mgmt_work->async_mgmt_to_pf)
+		goto out;
+
+	pf_to_mgmt = mgmt_work->pf_to_mgmt;
+	ack_cmd = pf_to_mgmt->mgmt_ack_buf;
+	memset(ack_cmd, 0, sizeof(*ack_cmd));
+	ack_cmd->status = MGMT_STATUS_CMD_UNSUPPORTED;
+
+	hinic3_response_mbox_to_mgmt(pf_to_mgmt->hwdev, mgmt_work->mod,
+				     mgmt_work->cmd, ack_cmd, sizeof(*ack_cmd),
+				     mgmt_work->msg_id);
+
+out:
+	kfree(mgmt_work->msg);
+	kfree(mgmt_work);
+}
+
+static int hinic3_recv_msg_add_seg(struct hinic3_recv_msg *recv_msg,
+				   __le64 msg_header, const void *seg_data,
+				   bool *is_complete)
+{
+	u8 seq_id, msg_id, seg_len, is_last;
+	char *msg_buff;
+	u32 offset;
+
+	seg_len = MBOX_MSG_HEADER_GET(msg_header, SEG_LEN);
+	is_last = MBOX_MSG_HEADER_GET(msg_header, LAST);
+	seq_id  = MBOX_MSG_HEADER_GET(msg_header, SEQID);
+	msg_id = MBOX_MSG_HEADER_GET(msg_header, MSG_ID);
+
+	if (seg_len > MGMT_SEG_LEN_MAX)
+		return -EINVAL;
+
+	/* All segments but last must be of maximal size */
+	if (seg_len != MGMT_SEG_LEN_MAX && !is_last)
+		return -EINVAL;
+
+	if (seq_id == 0) {
+		recv_msg->seq_id = seq_id;
+		recv_msg->msg_id = msg_id;
+	} else if (seq_id != recv_msg->seq_id + 1 ||
+		   msg_id != recv_msg->msg_id) {
+		return -EINVAL;
+	}
+
+	offset = seq_id * MGMT_SEG_LEN_MAX;
+	if (offset + seg_len > MGMT_MAX_PF_BUF_SIZE)
+		return -EINVAL;
+
+	msg_buff = recv_msg->msg;
+	memcpy(msg_buff + offset, seg_data, seg_len);
+	recv_msg->msg_len = offset + seg_len;
+	recv_msg->seq_id = seq_id;
+	*is_complete = !!is_last;
+
+	return 0;
+}
+
+static void hinic3_init_mgmt_msg_work(struct hinic3_msg_pf_to_mgmt *pf_to_mgmt,
+				      struct hinic3_recv_msg *recv_msg)
+{
+	struct mgmt_msg_handle_work *mgmt_work;
+
+	mgmt_work = kmalloc(sizeof(*mgmt_work), GFP_KERNEL);
+	if (!mgmt_work)
+		return;
+
+	if (recv_msg->msg_len) {
+		mgmt_work->msg = kmalloc(recv_msg->msg_len, GFP_KERNEL);
+		if (!mgmt_work->msg) {
+			kfree(mgmt_work);
+			return;
+		}
+	}
+
+	mgmt_work->pf_to_mgmt = pf_to_mgmt;
+	mgmt_work->msg_len = recv_msg->msg_len;
+	memcpy(mgmt_work->msg, recv_msg->msg, recv_msg->msg_len);
+	mgmt_work->msg_id = recv_msg->msg_id;
+	mgmt_work->mod = recv_msg->mod;
+	mgmt_work->cmd = recv_msg->cmd;
+	mgmt_work->async_mgmt_to_pf = recv_msg->async_mgmt_to_pf;
+
+	INIT_WORK(&mgmt_work->work, hinic3_recv_mgmt_msg_work_handler);
+	queue_work(pf_to_mgmt->workq, &mgmt_work->work);
+}
+
+static void
+hinic3_recv_mgmt_msg_handler(struct hinic3_msg_pf_to_mgmt *pf_to_mgmt,
+			     const u8 *header,
+			     struct hinic3_recv_msg *recv_msg)
+{
+	struct hinic3_hwdev *hwdev = pf_to_mgmt->hwdev;
+	const void *seg_data;
+	__le64 msg_header;
+	bool is_complete;
+	u8 dir, msg_id;
+	int err;
+
+	msg_header = *(__force __le64 *)header;
+	dir = MBOX_MSG_HEADER_GET(msg_header, DIRECTION);
+	msg_id = MBOX_MSG_HEADER_GET(msg_header, MSG_ID);
+	/* Don't need to get anything from hw when cmd is async */
+	if (dir == MBOX_MSG_RESP && (msg_id & MGMT_ASYNC_MSG_FLAG))
+		return;
+
+	seg_data = header + sizeof(msg_header);
+	err = hinic3_recv_msg_add_seg(recv_msg, msg_header,
+				      seg_data, &is_complete);
+	if (err) {
+		dev_err(hwdev->dev, "invalid receive segment\n");
+		/* set seq_id to invalid seq_id */
+		recv_msg->seq_id = MGMT_BOGUS_SEQ_ID;
+
+		return;
+	}
+
+	if (!is_complete)
+		return;
+
+	recv_msg->cmd = MBOX_MSG_HEADER_GET(msg_header, CMD);
+	recv_msg->mod = MBOX_MSG_HEADER_GET(msg_header, MODULE);
+	recv_msg->async_mgmt_to_pf = MBOX_MSG_HEADER_GET(msg_header, NO_ACK);
+	recv_msg->seq_id = MGMT_BOGUS_SEQ_ID;
+
+	if (dir == MBOX_MSG_RESP)
+		hinic3_mgmt_resp_msg_handler(pf_to_mgmt, recv_msg);
+	else
+		hinic3_init_mgmt_msg_work(pf_to_mgmt, recv_msg);
+}
+
+static int alloc_recv_msg(struct hinic3_recv_msg *recv_msg)
+{
+	recv_msg->seq_id = MGMT_BOGUS_SEQ_ID;
+
+	recv_msg->msg = kzalloc(MGMT_MAX_PF_BUF_SIZE, GFP_KERNEL);
+	if (!recv_msg->msg)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void free_recv_msg(struct hinic3_recv_msg *recv_msg)
+{
+	kfree(recv_msg->msg);
+}
+
+static int alloc_msg_buf(struct hinic3_msg_pf_to_mgmt *pf_to_mgmt)
+{
+	struct device *dev = pf_to_mgmt->hwdev->dev;
+	int err;
+
+	err = alloc_recv_msg(&pf_to_mgmt->recv_msg_from_mgmt);
+	if (err) {
+		dev_err(dev, "Failed to allocate recv msg\n");
+		return err;
+	}
+
+	err = alloc_recv_msg(&pf_to_mgmt->recv_resp_msg_from_mgmt);
+	if (err) {
+		dev_err(dev, "Failed to allocate resp recv msg\n");
+		goto err_free_msg_from_mgmt;
+	}
+
+	pf_to_mgmt->mgmt_ack_buf = kzalloc(MGMT_MAX_PF_BUF_SIZE, GFP_KERNEL);
+	if (!pf_to_mgmt->mgmt_ack_buf) {
+		err = -ENOMEM;
+		goto err_free_resp_msg_from_mgmt;
+	}
+
+	return 0;
+
+err_free_resp_msg_from_mgmt:
+	free_recv_msg(&pf_to_mgmt->recv_resp_msg_from_mgmt);
+err_free_msg_from_mgmt:
+	free_recv_msg(&pf_to_mgmt->recv_msg_from_mgmt);
+
+	return err;
+}
+
+static void free_msg_buf(struct hinic3_msg_pf_to_mgmt *pf_to_mgmt)
+{
+	kfree(pf_to_mgmt->mgmt_ack_buf);
+
+	free_recv_msg(&pf_to_mgmt->recv_resp_msg_from_mgmt);
+	free_recv_msg(&pf_to_mgmt->recv_msg_from_mgmt);
+}
+
+int hinic3_pf_to_mgmt_init(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_msg_pf_to_mgmt *pf_to_mgmt;
+	int err;
+
+	pf_to_mgmt = kzalloc(sizeof(*pf_to_mgmt), GFP_KERNEL);
+	if (!pf_to_mgmt)
+		return -ENOMEM;
+
+	hwdev->pf_to_mgmt = pf_to_mgmt;
+	pf_to_mgmt->hwdev = hwdev;
+	spin_lock_init(&pf_to_mgmt->sync_event_lock);
+	pf_to_mgmt->workq = create_singlethread_workqueue(HINIC3_MGMT_WQ_NAME);
+	if (!pf_to_mgmt->workq) {
+		dev_err(hwdev->dev, "Failed to initialize MGMT workqueue\n");
+		err = -ENOMEM;
+		goto err_free_pf_to_mgmt;
+	}
+
+	err = alloc_msg_buf(pf_to_mgmt);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to allocate msg buffers\n");
+		goto err_destroy_workqueue;
+	}
+
+	return 0;
+
+err_destroy_workqueue:
+	destroy_workqueue(pf_to_mgmt->workq);
+err_free_pf_to_mgmt:
+	kfree(pf_to_mgmt);
+
+	return err;
+}
+
+void hinic3_pf_to_mgmt_free(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_msg_pf_to_mgmt *pf_to_mgmt = hwdev->pf_to_mgmt;
+
+	/* destroy workqueue before free related pf_to_mgmt resources in case of
+	 * illegal resource access
+	 */
+	destroy_workqueue(pf_to_mgmt->workq);
+
+	free_msg_buf(pf_to_mgmt);
+	kfree(pf_to_mgmt);
+}
+
 void hinic3_flush_mgmt_workq(struct hinic3_hwdev *hwdev)
 {
 	if (hwdev->aeqs)
 		flush_workqueue(hwdev->aeqs->workq);
+
+	if (HINIC3_IS_PF(hwdev) && hwdev->pf_to_mgmt)
+		flush_workqueue(hwdev->pf_to_mgmt->workq);
 }
 
 void hinic3_mgmt_msg_aeqe_handler(struct hinic3_hwdev *hwdev, u8 *header,
 				  u8 size)
 {
+	struct hinic3_msg_pf_to_mgmt *pf_to_mgmt;
+	struct hinic3_recv_msg *recv_msg;
+	__le64 msg_header;
+	bool is_send_dir;
+
 	if (MBOX_MSG_HEADER_GET(*(__force __le64 *)header, SOURCE) ==
-				MBOX_MSG_FROM_MBOX)
+	    MBOX_MSG_FROM_MBOX) {
 		hinic3_mbox_func_aeqe_handler(hwdev, header, size);
+
+		return;
+	}
+
+	pf_to_mgmt = hwdev->pf_to_mgmt;
+	msg_header = *(__force __le64 *)header;
+
+	is_send_dir = (MBOX_MSG_HEADER_GET(msg_header, DIRECTION) ==
+		       MBOX_MSG_SEND) ? true : false;
+
+	recv_msg = is_send_dir ? &pf_to_mgmt->recv_msg_from_mgmt :
+		   &pf_to_mgmt->recv_resp_msg_from_mgmt;
+
+	hinic3_recv_mgmt_msg_handler(pf_to_mgmt, header, recv_msg);
 }
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt.h b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt.h
index bbef3b32a6ec..56f48d5442bc 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt.h
@@ -6,8 +6,61 @@
 
 #include <linux/types.h>
 
+#include "hinic3_mbox.h"
+#include "hinic3_hw_intf.h"
+
 struct hinic3_hwdev;
 
+struct hinic3_recv_msg {
+	/* Preallocated buffer of size MAX_PF_MGMT_BUF_SIZE that accumulates
+	 * receive message, segment-by-segment.
+	 */
+	void                 *msg;
+	/* Message id for which segments are accumulated. */
+	u8                   msg_id;
+	/* Sequence id of last received segment of current message. */
+	u8                   seq_id;
+	u16                  msg_len;
+	int                  async_mgmt_to_pf;
+	enum mgmt_mod_type   mod;
+	u16                  cmd;
+	struct completion    recv_done;
+};
+
+enum comm_pf_to_mgmt_event_state {
+	COMM_SEND_EVENT_UNINIT,
+	COMM_SEND_EVENT_START,
+	COMM_SEND_EVENT_SUCCESS,
+	COMM_SEND_EVENT_TIMEOUT,
+};
+
+struct hinic3_msg_pf_to_mgmt {
+	struct hinic3_hwdev              *hwdev;
+	struct workqueue_struct          *workq;
+	void                             *mgmt_ack_buf;
+	struct hinic3_recv_msg           recv_msg_from_mgmt;
+	struct hinic3_recv_msg           recv_resp_msg_from_mgmt;
+	u16                              async_msg_id;
+	u16                              sync_msg_id;
+	void                             *async_msg_cb_data[MGMT_MOD_HW_MAX];
+	/* synchronizes message send with message receives via event queue */
+	spinlock_t                       sync_event_lock;
+	enum comm_pf_to_mgmt_event_state event_flag;
+};
+
+struct mgmt_msg_handle_work {
+	struct work_struct           work;
+	struct hinic3_msg_pf_to_mgmt *pf_to_mgmt;
+	void                         *msg;
+	u16                          msg_len;
+	enum mgmt_mod_type           mod;
+	u16                          cmd;
+	u16                          msg_id;
+	int                          async_mgmt_to_pf;
+};
+
+int hinic3_pf_to_mgmt_init(struct hinic3_hwdev *hwdev);
+void hinic3_pf_to_mgmt_free(struct hinic3_hwdev *hwdev);
 void hinic3_flush_mgmt_workq(struct hinic3_hwdev *hwdev);
 void hinic3_mgmt_msg_aeqe_handler(struct hinic3_hwdev *hwdev,
 				  u8 *header, u8 size);
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h
index f9a3222b1b46..3a6d3ee534d0 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h
@@ -190,6 +190,7 @@ enum l2nic_ucode_cmd {
 
 /* hilink mac group command */
 enum mag_cmd {
+	MAG_CMD_SET_PORT_ENABLE = 6,
 	MAG_CMD_GET_LINK_STATUS = 7,
 };
 
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
index 0fa3c7900225..bf199f4ce847 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
@@ -327,6 +327,31 @@ static void hinic3_close_channel(struct net_device *netdev)
 	hinic3_free_qp_ctxts(nic_dev);
 }
 
+static int hinic3_maybe_set_port_state(struct net_device *netdev, bool enable)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	int err;
+
+	down(&nic_dev->port_state_sem);
+	err = hinic3_set_port_enable(nic_dev->hwdev, enable);
+	up(&nic_dev->port_state_sem);
+
+	return err;
+}
+
+static void hinic3_print_link_message(struct net_device *netdev,
+				      bool link_status_up)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+
+	if (nic_dev->link_status_up == link_status_up)
+		return;
+
+	nic_dev->link_status_up = link_status_up;
+
+	netdev_dbg(netdev, "Link is %s\n", str_up_down(link_status_up));
+}
+
 static int hinic3_vport_up(struct net_device *netdev)
 {
 	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
@@ -341,6 +366,12 @@ static int hinic3_vport_up(struct net_device *netdev)
 		goto err_flush_qps_res;
 	}
 
+	err = hinic3_maybe_set_port_state(netdev, true);
+	if (err) {
+		netdev_err(netdev, "Failed to enable port\n");
+		goto err_disable_vport;
+	}
+
 	err = netif_set_real_num_queues(netdev, nic_dev->q_params.num_qps,
 					nic_dev->q_params.num_qps);
 	if (err) {
@@ -353,8 +384,12 @@ static int hinic3_vport_up(struct net_device *netdev)
 	if (!err && link_status_up)
 		netif_carrier_on(netdev);
 
+	hinic3_print_link_message(netdev, link_status_up);
+
 	return 0;
 
+err_disable_vport:
+	hinic3_set_vport_enable(nic_dev->hwdev, glb_func_id, false);
 err_flush_qps_res:
 	hinic3_flush_qps_res(nic_dev->hwdev);
 	/* wait to guarantee that no packets will be sent to host */
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
index e784f1b04a41..7fec13bbe60e 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
@@ -366,6 +366,34 @@ int hinic3_force_drop_tx_pkt(struct hinic3_hwdev *hwdev)
 	return pkt_drop.msg_head.status;
 }
 
+int hinic3_set_port_enable(struct hinic3_hwdev *hwdev, bool enable)
+{
+	struct mag_cmd_set_port_enable en_state = {};
+	struct mgmt_msg_params msg_params = {};
+	int err;
+
+	if (HINIC3_IS_VF(hwdev))
+		return 0;
+
+	en_state.function_id = hinic3_global_func_id(hwdev);
+	en_state.state = enable ? MAG_CMD_TX_ENABLE | MAG_CMD_RX_ENABLE :
+				MAG_CMD_PORT_DISABLE;
+
+	mgmt_msg_params_init_default(&msg_params, &en_state,
+				     sizeof(en_state));
+
+	err = hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_HILINK,
+				       MAG_CMD_SET_PORT_ENABLE, &msg_params);
+
+	if (err || en_state.head.status) {
+		dev_err(hwdev->dev, "Failed to set port state, err: %d, status: 0x%x\n",
+			err, en_state.head.status);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
 int hinic3_sync_dcb_state(struct hinic3_hwdev *hwdev, u8 op_code, u8 state)
 {
 	struct l2nic_cmd_set_dcb_state dcb_state = {};
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
index 08bf14679bf8..d4326937db48 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
@@ -34,6 +34,23 @@ struct hinic3_sq_attr {
 	u64 ci_dma_base;
 };
 
+#define MAG_CMD_PORT_DISABLE    0x0
+#define MAG_CMD_TX_ENABLE       0x1
+#define MAG_CMD_RX_ENABLE       0x2
+/* the physical port is disabled only when all pf of the port are set to down,
+ * if any pf is enabled, the port is enabled
+ */
+struct mag_cmd_set_port_enable {
+	struct mgmt_msg_head head;
+
+	u16                  function_id;
+	u16                  rsvd0;
+
+	/* bitmap bit0:tx_en bit1:rx_en */
+	u8                   state;
+	u8                   rsvd1[3];
+};
+
 int hinic3_get_nic_feature_from_hw(struct hinic3_nic_dev *nic_dev);
 int hinic3_set_nic_feature_to_hw(struct hinic3_nic_dev *nic_dev);
 bool hinic3_test_support(struct hinic3_nic_dev *nic_dev,
@@ -57,6 +74,7 @@ int hinic3_flush_qps_res(struct hinic3_hwdev *hwdev);
 int hinic3_force_drop_tx_pkt(struct hinic3_hwdev *hwdev);
 
 int hinic3_sync_dcb_state(struct hinic3_hwdev *hwdev, u8 op_code, u8 state);
+int hinic3_set_port_enable(struct hinic3_hwdev *hwdev, bool enable);
 int hinic3_get_link_status(struct hinic3_hwdev *hwdev, bool *link_status_up);
 int hinic3_set_vport_enable(struct hinic3_hwdev *hwdev, u16 func_id,
 			    bool enable);
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
index 5ba83261616c..3a9f3ccdb684 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
@@ -83,6 +83,8 @@ struct hinic3_nic_dev {
 
 	struct hinic3_intr_coal_info    *intr_coalesce;
 
+	struct semaphore                port_state_sem;
+
 	bool                            link_status_up;
 };
 
-- 
2.43.0


