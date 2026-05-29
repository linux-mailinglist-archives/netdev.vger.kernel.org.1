Return-Path: <netdev+bounces-293082-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gG/cFUxuGWqEwggAu9opvQ
	(envelope-from <netdev+bounces-293082-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 12:45:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A816660108A
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 12:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 836A231B94A4
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 10:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409F93D3318;
	Fri, 29 May 2026 10:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vEdJrDbU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0766E3CC31A;
	Fri, 29 May 2026 10:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780050709; cv=none; b=grSVEIR0xvEQbCUwz18zTNj9bMysApisoMWyVOTfU+k2Wgs5AdS0QtqevHk5HYpvoYHMgjo59rkuMrvbCzcOEOtc69DNscQMqANY+MupUpaxjQDU2vGib0TU3Tl1Tu/c8rIPEeN65W9RgCH1ODWuXhy132Q4VJ2tXk/EV8XMRng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780050709; c=relaxed/simple;
	bh=covDkBg2nI9cOkowzpYYEqilFoMydB4X7zDMhCa/wPk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QylHv8QZX8L9jYxOuTaWVYpAe4YJkqUPLZJ56Gu1ziCisa+mVpaEo6OKhVKJRhIlXWZPyoiIqvgc+kXi3l6NZbyB61D6H/Bs2mdb6ALhEoX+UqamKEs7F2Xg35/dHgNN5oaBiVqzdDqdY/Y5QuS1bR7bV5WZdTE9CUEZ7r6Kd3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vEdJrDbU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B7CC2C2BCF4;
	Fri, 29 May 2026 10:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780050708;
	bh=covDkBg2nI9cOkowzpYYEqilFoMydB4X7zDMhCa/wPk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=vEdJrDbU6yDU8BE2MvXXbdKYsj35E/NLYEOxtyY0eO8kl1Aldu+AEZCof0c0pprye
	 U15J4LNG88uV7xXfuSTRfeZ5nlma+nwDCc9/K3vo2lzNKe1aNww0q4z+NCuXGCEWCZ
	 T53VATzoRmQ+A5IpfQVivI9+maTORisPSFKOhTPJX+jlUUM93jTB18t+x16q1LiR82
	 NkV8B4Jqb3uDKXprbo88aPWH5PMx+xbqPvfSl308409eCcLjXNkKGptdEQOp6S4OfO
	 fuuf75fxBGhkqhL88nYf4t1x0IWa/+FO5aNyRDNOTcnZwJLtJhad1DB2uC5C9CCK2v
	 UrPNMeTkX4oiA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BC5CD6E43;
	Fri, 29 May 2026 10:31:48 +0000 (UTC)
From: Jack Wu via B4 Relay <devnull+jackbb_wu.compal.com@kernel.org>
Date: Fri, 29 May 2026 18:31:49 +0800
Subject: [PATCH 10/11] net: wwan: t9xx: Add power management support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-t9xx_driver_v1-v1-10-bdbfe2c01e57@compal.com>
References: <20260529-t9xx_driver_v1-v1-0-bdbfe2c01e57@compal.com>
In-Reply-To: <20260529-t9xx_driver_v1-v1-0-bdbfe2c01e57@compal.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>, 
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jack Wu <jackbb_wu@compal.com>, Wen-Zhi Huang <wen-zhi.huang@mediatek.com>, 
 Shi-Wei Yeh <shi-wei.yeh@mediatek.com>, 
 Minano Tseng <Minano.tseng@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-doc@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780050705; l=10360;
 i=jackbb_wu@compal.com; s=20260526; h=from:subject:message-id;
 bh=oxy53zFq580oeEjL4U9JeBfxFpvxUooy4zoOd7IIEQk=;
 b=VhMB0H5ZNWUhc0CPzJL67eqE4knVI+CxK6ZS0/DkmHP3gf3tmDJ7vHgV0var2J8s+b5UVjkBM
 pZeVpPqhCpzCMTGV4Hb4ZwWF9G4kdMZDcLMgJ9wjW62TeQzFlhV15wl
X-Developer-Key: i=jackbb_wu@compal.com; a=ed25519;
 pk=VH1prTWixNl8OEUPPSfII3p46MzJpQN8J3+ecE1tZXg=
X-Endpoint-Received: by B4 Relay for jackbb_wu@compal.com/20260526 with
 auth_id=793
X-Original-From: Jack Wu <jackbb_wu@compal.com>
Reply-To: jackbb_wu@compal.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293082-lists,netdev=lfdr.de,jackbb_wu.compal.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,compal.com,mediatek.com,collabora.com,lwn.net,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[jackbb_wu@compal.com]
X-Rspamd-Queue-Id: A816660108A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jack Wu <jackbb_wu@compal.com>

Add s2idle (S0ix) power management support for the t9xx WWAN driver.

In s2idle the modem remains powered. The driver must quiesce host-side
DMA engines and service threads before the platform enters low-power
state, then restore them on resume.

- Suspend: park TRB service threads, stop CLDMA TX/RX queues,
  disable DPMAIF data path, mask MHCCIF and MSIX interrupts,
  save PCIe state
- Resume: restore PCIe state, re-initialize ATR, unmask MHCCIF,
  resume CLDMA queues, re-enable DPMAIF data path, unpark TRB
  service threads

Signed-off-by: Jack Wu <jackbb_wu@compal.com>
---
 drivers/net/wwan/t9xx/pcie/mtk_cldma.c  | 94 +++++++++++++++++++++++++++++++++
 drivers/net/wwan/t9xx/pcie/mtk_cldma.h  |  3 ++
 drivers/net/wwan/t9xx/pcie/mtk_dpmaif.c | 35 +++++++++++-
 drivers/net/wwan/t9xx/pcie/mtk_dpmaif.h |  2 +
 drivers/net/wwan/t9xx/pcie/mtk_pci.c    | 85 ++++++++++++++++++++++++++++-
 5 files changed, 216 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wwan/t9xx/pcie/mtk_cldma.c b/drivers/net/wwan/t9xx/pcie/mtk_cldma.c
index aacb4177d914..a5227eb546f4 100644
--- a/drivers/net/wwan/t9xx/pcie/mtk_cldma.c
+++ b/drivers/net/wwan/t9xx/pcie/mtk_cldma.c
@@ -1113,6 +1113,100 @@ int mtk_cldma_exit(struct mtk_ctrl_trans *trans)
 	return 0;
 }
 
+void mtk_cldma_pm_suspend(struct mtk_md_dev *mdev)
+{
+	struct mtk_ctrl_trans *trans = ((struct mtk_ctrl_blk *)mdev->ctrl_blk)->ctrl_hw_priv;
+	struct cldma_dev *cd = trans->dev;
+	struct cldma_drv_info *drv_info;
+	struct cldma_drv_ops *drv_ops;
+	struct rxq *rxq;
+	struct txq *txq;
+	int i, q;
+
+	for (i = 0; i < NR_CLDMA; i++) {
+		drv_info = cd->cldma_drv_info[i];
+		if (!drv_info)
+			continue;
+
+		drv_ops = drv_info->drv_ops;
+
+		/* Stop TX queues and flush pending tx_done_work (suspend phase) */
+		drv_ops->cldma_stop_queue(drv_info, DIR_TX, ALLQ);
+		for (q = 0; q < HW_QUEUE_NUM; q++) {
+			txq = drv_info->txq[q];
+			if (txq)
+				flush_work(&txq->tx_done_work);
+		}
+
+		for (q = 0; q < HW_QUEUE_NUM; q++) {
+			rxq = drv_info->rxq[q];
+			if (!rxq)
+				continue;
+			atomic_set(&rxq->need_exit, 1);
+			drv_ops->cldma_stop_queue(drv_info, DIR_RX, q);
+			flush_work(&rxq->rx_done_work);
+		}
+		mtk_pci_mask_irq(mdev, drv_info->pci_ext_irq_id);
+	}
+}
+
+void mtk_cldma_pm_resume_early(struct mtk_md_dev *mdev)
+{
+	struct mtk_ctrl_trans *trans = ((struct mtk_ctrl_blk *)mdev->ctrl_blk)->ctrl_hw_priv;
+	struct cldma_dev *cd = trans->dev;
+	struct cldma_drv_info *drv_info;
+	struct cldma_drv_ops *drv_ops;
+	struct rxq *rxq;
+	int i, q;
+
+	for (i = 0; i < NR_CLDMA; i++) {
+		drv_info = cd->cldma_drv_info[i];
+		if (!drv_info)
+			continue;
+
+		drv_ops = drv_info->drv_ops;
+
+		/* Resume RX queues from current HW ring position (no addr reset) */
+		for (q = 0; q < HW_QUEUE_NUM; q++) {
+			rxq = drv_info->rxq[q];
+			if (!rxq)
+				continue;
+			atomic_set(&rxq->need_exit, 0);
+			drv_ops->cldma_resume_queue(drv_info, DIR_RX, q);
+		}
+
+		/* Unmask CLDMA L1 interrupt */
+		mtk_pci_unmask_irq(mdev, drv_info->pci_ext_irq_id);
+	}
+}
+
+void mtk_cldma_pm_resume(struct mtk_md_dev *mdev)
+{
+	struct mtk_ctrl_trans *trans = ((struct mtk_ctrl_blk *)mdev->ctrl_blk)->ctrl_hw_priv;
+	struct cldma_dev *cd = trans->dev;
+	struct cldma_drv_info *drv_info;
+	struct cldma_drv_ops *drv_ops;
+	struct txq *txq;
+	int i, q;
+
+	for (i = 0; i < NR_CLDMA; i++) {
+		drv_info = cd->cldma_drv_info[i];
+		if (!drv_info)
+			continue;
+
+		drv_ops = drv_info->drv_ops;
+
+		/* Restart TX queues that have pending descriptors */
+		for (q = 0; q < HW_QUEUE_NUM; q++) {
+			txq = drv_info->txq[q];
+			if (!txq)
+				continue;
+			if (atomic_read(&txq->req_budget) < txq->nr_gpds)
+				mtk_cldma_start_xfer(drv_info, q);
+		}
+	}
+}
+
 static int mtk_cldma_open(struct cldma_dev *cd, struct sk_buff *skb)
 {
 	struct trb_open_priv *trb_open_priv = (struct trb_open_priv *)skb->data;
diff --git a/drivers/net/wwan/t9xx/pcie/mtk_cldma.h b/drivers/net/wwan/t9xx/pcie/mtk_cldma.h
index 04f83ff0e37d..fd39985f75e7 100644
--- a/drivers/net/wwan/t9xx/pcie/mtk_cldma.h
+++ b/drivers/net/wwan/t9xx/pcie/mtk_cldma.h
@@ -163,6 +163,9 @@ int mtk_cldma_get_tx_budget(void *dev, enum mtk_hif_id hif_id, u32 qno);
 int mtk_cldma_trb_process(void *dev, struct sk_buff *skb);
 void mtk_cldma_fsm_state_listener(struct mtk_fsm_param *param, struct mtk_ctrl_trans *trans);
 int mtk_cldma_check_ch_cfg(void *dev, struct queue_info *que);
+void mtk_cldma_pm_suspend(struct mtk_md_dev *mdev);
+void mtk_cldma_pm_resume_early(struct mtk_md_dev *mdev);
+void mtk_cldma_pm_resume(struct mtk_md_dev *mdev);
 
 #define drv_ops_name(NAME) cldma_drv_ops_##NAME
 #define cldma_regs_name(NAME) mtk_cldma_regs_##NAME
diff --git a/drivers/net/wwan/t9xx/pcie/mtk_dpmaif.c b/drivers/net/wwan/t9xx/pcie/mtk_dpmaif.c
index 43803587bfc3..63273a85e532 100644
--- a/drivers/net/wwan/t9xx/pcie/mtk_dpmaif.c
+++ b/drivers/net/wwan/t9xx/pcie/mtk_dpmaif.c
@@ -205,6 +205,7 @@ struct mtk_dpmaif_ctlb {
 	struct dpmaif_irq_param *irq_params;
 
 	bool dpmaif_sw_reset;
+	bool trans_enabled;
 	unsigned char rxq_cnt;
 	unsigned char txq_cnt;
 };
@@ -1687,10 +1688,16 @@ static void mtk_dpmaif_trans_disable(struct mtk_dpmaif_ctlb *dcb)
 static void mtk_dpmaif_trans_ctl(struct mtk_dpmaif_ctlb *dcb, bool enable)
 {
 	if (enable) {
-		if (dcb->dpmaif_state == DPMAIF_STATE_PWRON)
+		if (!dcb->trans_enabled &&
+		    dcb->dpmaif_state == DPMAIF_STATE_PWRON) {
+			dcb->trans_enabled = true;
 			mtk_dpmaif_trans_enable(dcb);
+		}
 	} else {
-		mtk_dpmaif_trans_disable(dcb);
+		if (dcb->trans_enabled) {
+			dcb->trans_enabled = false;
+			mtk_dpmaif_trans_disable(dcb);
+		}
 	}
 }
 
@@ -2060,6 +2067,30 @@ static int mtk_dpmaif_stop(struct mtk_md_dev *mdev)
 	return 0;
 }
 
+void mtk_dpmaif_pm_suspend(struct mtk_md_dev *mdev)
+{
+	struct mtk_dpmaif_ctlb *dcb = ((struct mtk_data_blk *)(mdev->data_blk))->dcb;
+
+	if (!dcb)
+		return;
+
+	mutex_lock(&dcb->trans_ctl_lock);
+	mtk_dpmaif_trans_ctl(dcb, false);
+	mutex_unlock(&dcb->trans_ctl_lock);
+}
+
+void mtk_dpmaif_pm_resume(struct mtk_md_dev *mdev)
+{
+	struct mtk_dpmaif_ctlb *dcb = ((struct mtk_data_blk *)(mdev->data_blk))->dcb;
+
+	if (!dcb)
+		return;
+
+	mutex_lock(&dcb->trans_ctl_lock);
+	mtk_dpmaif_trans_ctl(dcb, true);
+	mutex_unlock(&dcb->trans_ctl_lock);
+}
+
 static void mtk_dpmaif_clear(struct mtk_md_dev *mdev)
 {
 	struct mtk_dpmaif_ctlb *dcb = ((struct mtk_data_blk *)(mdev->data_blk))->dcb;
diff --git a/drivers/net/wwan/t9xx/pcie/mtk_dpmaif.h b/drivers/net/wwan/t9xx/pcie/mtk_dpmaif.h
index e7e2f333141c..20fd53fd44b5 100644
--- a/drivers/net/wwan/t9xx/pcie/mtk_dpmaif.h
+++ b/drivers/net/wwan/t9xx/pcie/mtk_dpmaif.h
@@ -10,5 +10,7 @@
 
 int mtk_pcie_data_init(struct mtk_md_dev *mdev);
 int mtk_pcie_data_exit(struct mtk_md_dev *mdev);
+void mtk_dpmaif_pm_suspend(struct mtk_md_dev *mdev);
+void mtk_dpmaif_pm_resume(struct mtk_md_dev *mdev);
 
 #endif /* __MTK_DPMAIF_H__ */
diff --git a/drivers/net/wwan/t9xx/pcie/mtk_pci.c b/drivers/net/wwan/t9xx/pcie/mtk_pci.c
index baac3692f1e3..f659c9a7aa96 100644
--- a/drivers/net/wwan/t9xx/pcie/mtk_pci.c
+++ b/drivers/net/wwan/t9xx/pcie/mtk_pci.c
@@ -11,8 +11,10 @@
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
 #include <linux/kernel.h>
+#include <linux/kthread.h>
 #include <linux/module.h>
 
+#include "mtk_cldma.h"
 #include "mtk_dev.h"
 #include "mtk_dpmaif.h"
 #include "mtk_trans_ctrl.h"
@@ -199,7 +201,6 @@ int mtk_pci_register_irq(struct mtk_md_dev *mdev, int irq_id,
 	}
 	priv->irq_cb_list[irq_id] = irq_cb;
 	priv->irq_cb_data[irq_id] = data;
-
 	return 0;
 }
 
@@ -970,11 +971,93 @@ static const struct pci_error_handlers mtk_pci_err_handler = {
 	.error_detected = mtk_pci_error_detected,
 };
 
+static void mtk_pci_pm_trb_park(struct mtk_md_dev *mdev)
+{
+	struct mtk_ctrl_trans *trans = ((struct mtk_ctrl_blk *)mdev->ctrl_blk)->ctrl_hw_priv;
+	int i;
+
+	for (i = 0; i < trans->trb_srv_num; i++)
+		kthread_park(trans->trb_srv[i]->trb_thread);
+}
+
+static void mtk_pci_pm_trb_unpark(struct mtk_md_dev *mdev)
+{
+	struct mtk_ctrl_trans *trans = ((struct mtk_ctrl_blk *)mdev->ctrl_blk)->ctrl_hw_priv;
+	int i;
+
+	for (i = 0; i < trans->trb_srv_num; i++)
+		kthread_unpark(trans->trb_srv[i]->trb_thread);
+}
+
+static int __maybe_unused mtk_pci_pm_suspend(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct mtk_md_dev *mdev = pci_get_drvdata(pdev);
+	struct mtk_pci_priv *priv = mdev->hw_priv;
+
+	mtk_pci_pm_trb_park(mdev);
+
+	mtk_cldma_pm_suspend(mdev);
+
+	mtk_dpmaif_pm_suspend(mdev);
+
+	/* Mask MHCCIF interrupt */
+	mtk_pci_mask_irq(mdev, priv->mhccif_irq_id);
+
+	/* Mask all MSI-X interrupts at the device level */
+	mtk_pci_mac_write32(priv, REG_IMASK_HOST_MSIX_CLR_GRP0_0, U32_MAX);
+
+	/* Save PCI configuration space */
+	pci_save_state(pdev);
+
+	return 0;
+}
+
+static int __maybe_unused mtk_pci_pm_resume(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct mtk_md_dev *mdev = pci_get_drvdata(pdev);
+	struct mtk_pci_priv *priv = mdev->hw_priv;
+	int ret;
+
+	/* Restore PCIe configuration space (including MSI-X enable bits) */
+	pci_restore_state(pdev);
+
+	/* Re-enable bus mastering for DMA */
+	pci_set_master(pdev);
+
+	/* Restore ATR (address translation registers in MMIO BAR space) */
+	ret = priv->cfg->atr_init(mdev);
+	if (ret) {
+		dev_err(mdev->dev, "PM: failed to re-init ATR on resume\n");
+		return ret;
+	}
+
+	/* Unmask MHCCIF interrupt */
+	mtk_pci_unmask_irq(mdev, priv->mhccif_irq_id);
+
+	mtk_cldma_pm_resume_early(mdev);
+
+	/* Restart CLDMA TX queues that have pending descriptors */
+	mtk_cldma_pm_resume(mdev);
+
+	mtk_dpmaif_pm_resume(mdev);
+
+	mtk_pci_pm_trb_unpark(mdev);
+
+	return 0;
+}
+
+static const struct dev_pm_ops mtk_pci_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(mtk_pci_pm_suspend, mtk_pci_pm_resume)
+};
+
 static struct pci_driver mtk_pci_drv = {
 	.name = "mtk_pci_drv",
 	.id_table = t9xx_pci_table,
 	.probe = mtk_pci_probe,
 	.remove = mtk_pci_remove,
+	.driver.pm = &mtk_pci_pm_ops,
 	.err_handler = &mtk_pci_err_handler
 };
 

-- 
2.34.1



