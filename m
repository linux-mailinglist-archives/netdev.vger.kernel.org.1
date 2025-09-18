Return-Path: <netdev+bounces-213906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE5DB27477
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 03:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 075945E420F
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 01:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D020C1D5146;
	Fri, 15 Aug 2025 01:02:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B470D1C8629;
	Fri, 15 Aug 2025 01:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755219746; cv=none; b=B32ccwf2IDFtOTjrmTwsbHIm57CVVs4+zLlPGMCHrkZiZ/EWiKNTY6xHnhWjQIpwHFP2Xelv322sGS0cXtF+lNkVRJqjAUHrBlS5N7XNdboWH9v+4b6dfQTSEc2n208DNNhoqb5Tbv8s0M9ssZkMVD+gYK5yuDOLS8d/H5ag//U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755219746; c=relaxed/simple;
	bh=BRdyHpOg12Na5pCEvdBSmOWwrjxyLXfUWtiZuoH6MHE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cXSRfMguytHwARiTxoTplL2z1tIsGKX81pa9poZa44uxnkzFFs6UcN0sY9nTgpqjzvbUkjH/DYf0mIhGpxBuPc+QtnvXM9ggltJxPry8s+HYBOlCWk0Yt5l7LgfnHElLmfvp4gJeOibEoRnHjinHDTmeHWcoQrHoMIm6EH4VKU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4c33cp1wLsz2CgB1;
	Fri, 15 Aug 2025 08:58:02 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 97C9F14011F;
	Fri, 15 Aug 2025 09:02:22 +0800 (CST)
Received: from DESKTOP-F6Q6J7K.china.huawei.com (10.174.175.220) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 15 Aug 2025 09:02:20 +0800
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
	<shijing34@huawei.com>, Fu Guiming <fuguiming@h-partners.com>, Meny Yossefi
	<meny.yossefi@huawei.com>, Gur Stavi <gur.stavi@huawei.com>, Lee Trager
	<lee@trager.us>, Michael Ellerman <mpe@ellerman.id.au>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Suman Ghosh <sumang@marvell.com>, Przemek
 Kitszel <przemyslaw.kitszel@intel.com>, Joe Damato <jdamato@fastly.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH net-next v13 5/8] hinic3: TX & RX Queue coalesce interfaces
Date: Fri, 15 Aug 2025 09:02:01 +0800
Message-ID: <b9874815d637161e93c9d418b8edf232129e1ea1.1755176101.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <cover.1755176101.git.zhuyikai1@h-partners.com>
References: <cover.1755176101.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf100013.china.huawei.com (7.202.181.12)

Add TX RX queue coalesce interfaces initialization.
It configures the parameters of tx & tx msix coalesce.

Co-developed-by: Xin Guo <guoxin09@huawei.com>
Signed-off-by: Xin Guo <guoxin09@huawei.com>
Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 .../net/ethernet/huawei/hinic3/hinic3_main.c  | 61 +++++++++++++++++--
 .../ethernet/huawei/hinic3/hinic3_nic_dev.h   | 10 +++
 2 files changed, 66 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
index 497f2a36f35d..a0b04fb07c76 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
@@ -17,12 +17,53 @@
 
 #define HINIC3_NIC_DRV_DESC  "Intelligent Network Interface Card Driver"
 
-#define HINIC3_RX_BUF_LEN            2048
-#define HINIC3_LRO_REPLENISH_THLD    256
-#define HINIC3_NIC_DEV_WQ_NAME       "hinic3_nic_dev_wq"
+#define HINIC3_RX_BUF_LEN          2048
+#define HINIC3_LRO_REPLENISH_THLD  256
+#define HINIC3_NIC_DEV_WQ_NAME     "hinic3_nic_dev_wq"
 
-#define HINIC3_SQ_DEPTH              1024
-#define HINIC3_RQ_DEPTH              1024
+#define HINIC3_SQ_DEPTH            1024
+#define HINIC3_RQ_DEPTH            1024
+
+#define HINIC3_DEFAULT_TXRX_MSIX_PENDING_LIMIT      2
+#define HINIC3_DEFAULT_TXRX_MSIX_COALESC_TIMER_CFG  25
+#define HINIC3_DEFAULT_TXRX_MSIX_RESEND_TIMER_CFG   7
+
+static void init_intr_coal_param(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_intr_coal_info *info;
+	u16 i;
+
+	for (i = 0; i < nic_dev->max_qps; i++) {
+		info = &nic_dev->intr_coalesce[i];
+		info->pending_limit = HINIC3_DEFAULT_TXRX_MSIX_PENDING_LIMIT;
+		info->coalesce_timer_cfg = HINIC3_DEFAULT_TXRX_MSIX_COALESC_TIMER_CFG;
+		info->resend_timer_cfg = HINIC3_DEFAULT_TXRX_MSIX_RESEND_TIMER_CFG;
+	}
+}
+
+static int hinic3_init_intr_coalesce(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+
+	nic_dev->intr_coalesce = kcalloc(nic_dev->max_qps,
+					 sizeof(*nic_dev->intr_coalesce),
+					 GFP_KERNEL);
+
+	if (!nic_dev->intr_coalesce)
+		return -ENOMEM;
+
+	init_intr_coal_param(netdev);
+
+	return 0;
+}
+
+static void hinic3_free_intr_coalesce(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+
+	kfree(nic_dev->intr_coalesce);
+}
 
 static int hinic3_alloc_txrxqs(struct net_device *netdev)
 {
@@ -42,8 +83,17 @@ static int hinic3_alloc_txrxqs(struct net_device *netdev)
 		goto err_free_txqs;
 	}
 
+	err = hinic3_init_intr_coalesce(netdev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to init_intr_coalesce\n");
+		goto err_free_rxqs;
+	}
+
 	return 0;
 
+err_free_rxqs:
+	hinic3_free_rxqs(netdev);
+
 err_free_txqs:
 	hinic3_free_txqs(netdev);
 
@@ -52,6 +102,7 @@ static int hinic3_alloc_txrxqs(struct net_device *netdev)
 
 static void hinic3_free_txrxqs(struct net_device *netdev)
 {
+	hinic3_free_intr_coalesce(netdev);
 	hinic3_free_rxqs(netdev);
 	hinic3_free_txqs(netdev);
 }
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
index c994fc9b6ee0..9577cc673257 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
@@ -51,6 +51,12 @@ struct hinic3_dyna_txrxq_params {
 	struct hinic3_irq_cfg      *irq_cfg;
 };
 
+struct hinic3_intr_coal_info {
+	u8 pending_limit;
+	u8 coalesce_timer_cfg;
+	u8 resend_timer_cfg;
+};
+
 struct hinic3_nic_dev {
 	struct pci_dev                  *pdev;
 	struct net_device               *netdev;
@@ -70,10 +76,14 @@ struct hinic3_nic_dev {
 	u16                             num_qp_irq;
 	struct msix_entry               *qps_msix_entries;
 
+	struct hinic3_intr_coal_info    *intr_coalesce;
+
 	bool                            link_status_up;
 };
 
 void hinic3_set_netdev_ops(struct net_device *netdev);
+int hinic3_qps_irq_init(struct net_device *netdev);
+void hinic3_qps_irq_uninit(struct net_device *netdev);
 
 /* Temporary prototypes. Functions become static in later submission. */
 void qp_add_napi(struct hinic3_irq_cfg *irq_cfg);
-- 
2.43.0


