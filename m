Return-Path: <netdev+bounces-216849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C517CB35813
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 11:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E70F17C1354
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 09:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9BA3043D3;
	Tue, 26 Aug 2025 09:06:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6CD303C91;
	Tue, 26 Aug 2025 09:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756199193; cv=none; b=a5J94NP60NupDT2+hb/aIQpafkRWTkoYYU96lKdmx8do9NtfpzT5+VtfVyPtT/6y5pC9lZazsZHUA93Dvw86ZlbfFXa0Up7EUMnNvt+qzba1WtlpB1k0HWB3HS3Yn7tOufzCruNW4KyDON+j5CR43QvnUhWPB31wsXxdxBEVU5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756199193; c=relaxed/simple;
	bh=hHSfvGgoKCin84/T/IWQVt3Z5G8qxmC4d1mwNZ0Z9nw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uPDXntTUGThqyX/x5GsWOQVUd1YXAwD1ffFsBIKXwyzuqvKJzkOLD/5mBdFRe8Md4ypEq1qQlbKbqJ7QYEDkJYlK7YimhTGEAIuMDPkg4Uzd9OJkd5Zfc6bAdMYmhkQP6HFmK9n/CDUGlpQIVSPfksdTfgtX48oJkgYS9bP7WmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cB1rz1m4Tz13NNV;
	Tue, 26 Aug 2025 17:02:43 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id E9D681401E9;
	Tue, 26 Aug 2025 17:06:21 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.55) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 26 Aug 2025 17:06:20 +0800
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
Subject: [PATCH net-next v01 05/12] hinic3: Command Queue flush interfaces
Date: Tue, 26 Aug 2025 17:05:47 +0800
Message-ID: <3eac2e4a0f53bf514d14f195886badb96995ca9b.1756195078.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1756195078.git.zhuyikai1@h-partners.com>
References: <cover.1756195078.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf100013.china.huawei.com (7.202.181.12)

Add the data structures and functions for command queue flushing.

Co-developed-by: Xin Guo <guoxin09@huawei.com>
Signed-off-by: Xin Guo <guoxin09@huawei.com>
Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 .../ethernet/huawei/hinic3/hinic3_hw_comm.c   | 102 ++++++++++++++++++
 .../ethernet/huawei/hinic3/hinic3_hw_comm.h   |   1 +
 .../ethernet/huawei/hinic3/hinic3_hw_intf.h   |  12 +++
 .../net/ethernet/huawei/hinic3/hinic3_hwdev.c |   1 +
 .../net/ethernet/huawei/hinic3/hinic3_hwif.c  |  26 +++++
 .../net/ethernet/huawei/hinic3/hinic3_hwif.h  |   3 +
 6 files changed, 145 insertions(+)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
index b016806c7f67..c28df49e08c0 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
@@ -235,3 +235,105 @@ int hinic3_set_cmdq_depth(struct hinic3_hwdev *hwdev, u16 cmdq_depth)
 
 	return 0;
 }
+
+#define HINIC3_WAIT_CMDQ_IDLE_TIMEOUT    5000
+
+static enum hinic3_wait_return check_cmdq_stop_handler(void *priv_data)
+{
+	struct hinic3_hwdev *hwdev = priv_data;
+	enum hinic3_cmdq_type cmdq_type;
+	struct hinic3_cmdqs *cmdqs;
+
+	cmdqs = hwdev->cmdqs;
+	for (cmdq_type = 0; cmdq_type < cmdqs->cmdq_num; cmdq_type++) {
+		if (!hinic3_cmdq_idle(&cmdqs->cmdq[cmdq_type]))
+			return HINIC3_WAIT_PROCESS_WAITING;
+	}
+
+	return HINIC3_WAIT_PROCESS_CPL;
+}
+
+static int wait_cmdq_stop(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_cmdqs *cmdqs = hwdev->cmdqs;
+	enum hinic3_cmdq_type cmdq_type;
+	int err;
+
+	if (!(cmdqs->status & HINIC3_CMDQ_ENABLE))
+		return 0;
+
+	cmdqs->status &= ~HINIC3_CMDQ_ENABLE;
+	err = hinic3_wait_for_timeout(hwdev, check_cmdq_stop_handler,
+				      HINIC3_WAIT_CMDQ_IDLE_TIMEOUT,
+				      USEC_PER_MSEC);
+
+	if (err)
+		goto err_reenable_cmdq;
+
+	return 0;
+
+err_reenable_cmdq:
+	for (cmdq_type = 0; cmdq_type < cmdqs->cmdq_num; cmdq_type++) {
+		if (!hinic3_cmdq_idle(&cmdqs->cmdq[cmdq_type]))
+			dev_err(hwdev->dev, "Cmdq %d is busy\n", cmdq_type);
+	}
+	cmdqs->status |= HINIC3_CMDQ_ENABLE;
+
+	return err;
+}
+
+int hinic3_func_rx_tx_flush(struct hinic3_hwdev *hwdev)
+{
+	struct comm_cmd_clear_doorbell clear_db = {};
+	struct comm_cmd_clear_resource clr_res = {};
+	struct hinic3_hwif *hwif = hwdev->hwif;
+	struct mgmt_msg_params msg_params = {};
+	int ret = 0;
+	int err;
+
+	err = wait_cmdq_stop(hwdev);
+	if (err) {
+		dev_warn(hwdev->dev, "CMDQ is still working, CMDQ timeout value is unreasonable\n");
+		ret = err;
+	}
+
+	hinic3_disable_doorbell(hwif);
+
+	clear_db.func_id = hwif->attr.func_global_idx;
+	mgmt_msg_params_init_default(&msg_params, &clear_db, sizeof(clear_db));
+	err = hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_COMM,
+				       COMM_CMD_FLUSH_DOORBELL, &msg_params);
+	if (err || clear_db.head.status) {
+		dev_warn(hwdev->dev, "Failed to flush doorbell, err: %d, status: 0x%x\n",
+			 err, clear_db.head.status);
+		if (err)
+			ret = err;
+		else
+			ret = -EFAULT;
+	}
+
+	/* wait for chip to stop I/O */
+	msleep(100);
+
+	clr_res.func_id = hwif->attr.func_global_idx;
+	msg_params.buf_in = &clr_res;
+	msg_params.in_size = sizeof(clr_res);
+	err = hinic3_send_mbox_to_mgmt_no_ack(hwdev, MGMT_MOD_COMM,
+					      COMM_CMD_START_FLUSH,
+					      &msg_params);
+	if (err) {
+		dev_warn(hwdev->dev, "Failed to notice flush message, err: %d\n",
+			 err);
+		ret = err;
+	}
+
+	hinic3_enable_doorbell(hwif);
+
+	err = hinic3_reinit_cmdq_ctxts(hwdev);
+	if (err) {
+		dev_warn(hwdev->dev, "Failed to reinit cmdq\n");
+		ret = err;
+	}
+
+	return ret;
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h
index 478db3c13281..35b93e36e004 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h
@@ -39,5 +39,6 @@ int hinic3_set_dma_attr_tbl(struct hinic3_hwdev *hwdev, u8 entry_idx, u8 st,
 int hinic3_set_wq_page_size(struct hinic3_hwdev *hwdev, u16 func_idx,
 			    u32 page_size);
 int hinic3_set_cmdq_depth(struct hinic3_hwdev *hwdev, u16 cmdq_depth);
+int hinic3_func_rx_tx_flush(struct hinic3_hwdev *hwdev);
 
 #endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h
index 87b43a123edb..f5deddcbc29d 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h
@@ -245,6 +245,18 @@ struct comm_cmd_set_cmdq_ctxt {
 	struct comm_cmdq_ctxt_info ctxt;
 };
 
+struct comm_cmd_clear_doorbell {
+	struct mgmt_msg_head head;
+	u16                  func_id;
+	u16                  rsvd1[3];
+};
+
+struct comm_cmd_clear_resource {
+	struct mgmt_msg_head head;
+	u16                  func_id;
+	u16                  rsvd1[3];
+};
+
 /* Services supported by HW. HW uses these values when delivering events.
  * HW supports multiple services that are not yet supported by driver
  * (e.g. RoCE).
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
index 03d0ba683040..1c8eeec97629 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
@@ -534,6 +534,7 @@ void hinic3_free_hwdev(struct hinic3_hwdev *hwdev)
 	u64 drv_features[COMM_MAX_FEATURE_QWORD] = {};
 
 	hinic3_set_comm_features(hwdev, drv_features, COMM_MAX_FEATURE_QWORD);
+	hinic3_func_rx_tx_flush(hwdev);
 	hinic3_uninit_comm_ch(hwdev);
 	hinic3_free_cfg_mgmt(hwdev);
 	destroy_workqueue(hwdev->workq);
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c
index c9cccc805017..fd8aa76b4cda 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c
@@ -145,6 +145,32 @@ static enum hinic3_outbound_ctrl hinic3_get_outbound_ctrl_status(struct hinic3_h
 	return HINIC3_AF5_GET(attr5, OUTBOUND_CTRL);
 }
 
+void hinic3_enable_doorbell(struct hinic3_hwif *hwif)
+{
+	u32 addr, attr4;
+
+	addr = HINIC3_CSR_FUNC_ATTR4_ADDR;
+	attr4 = hinic3_hwif_read_reg(hwif, addr);
+
+	attr4 &= ~HINIC3_AF4_DOORBELL_CTRL_MASK;
+	attr4 |= HINIC3_AF4_SET(ENABLE_DOORBELL, DOORBELL_CTRL);
+
+	hinic3_hwif_write_reg(hwif, addr, attr4);
+}
+
+void hinic3_disable_doorbell(struct hinic3_hwif *hwif)
+{
+	u32 addr, attr4;
+
+	addr = HINIC3_CSR_FUNC_ATTR4_ADDR;
+	attr4 = hinic3_hwif_read_reg(hwif, addr);
+
+	attr4 &= ~HINIC3_AF4_DOORBELL_CTRL_MASK;
+	attr4 |= HINIC3_AF4_SET(DISABLE_DOORBELL, DOORBELL_CTRL);
+
+	hinic3_hwif_write_reg(hwif, addr, attr4);
+}
+
 static int init_hwif(struct hinic3_hwdev *hwdev, void __iomem *cfg_reg_base)
 {
 	struct hinic3_hwif *hwif;
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.h
index 48e43bfdbfbe..cc93a011c899 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.h
@@ -68,6 +68,9 @@ enum hinic3_msix_auto_mask {
 u32 hinic3_hwif_read_reg(struct hinic3_hwif *hwif, u32 reg);
 void hinic3_hwif_write_reg(struct hinic3_hwif *hwif, u32 reg, u32 val);
 
+void hinic3_disable_doorbell(struct hinic3_hwif *hwif);
+void hinic3_enable_doorbell(struct hinic3_hwif *hwif);
+
 int hinic3_alloc_db_addr(struct hinic3_hwdev *hwdev, void __iomem **db_base,
 			 void __iomem **dwqe_base);
 void hinic3_free_db_addr(struct hinic3_hwdev *hwdev, const u8 __iomem *db_base);
-- 
2.43.0


