Return-Path: <netdev+bounces-251514-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GZzAKjub2m+UQAAu9opvQ
	(envelope-from <netdev+bounces-251514-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 22:07:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9174BF7A
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 22:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A368368D048
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 14:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2F344CF28;
	Tue, 20 Jan 2026 14:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="b89yRSvG"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C282444102E;
	Tue, 20 Jan 2026 14:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768919408; cv=none; b=JCO+mell51PBhRXx0AuKAV47gAYJFZjCdPDozF2Q/q6tvcmEiz7opR13rlcXoOaf535Hk8XXGy7R/V9r+RMDlzAy+YUlGpWjFLQSced2Qi2n7KhcgD7bvOL3poRXtKYMRm3NsT2CV8EEPJqdJZ8cqWdXjSgddg9DF0890/SLflA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768919408; c=relaxed/simple;
	bh=hJIiuCinADs+F2K0CXoXYmOInua1H1sOGul+Z4K2VSs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mikf/X4EMmkNRT67okSATzQFrR4sT8/k5N63PlbQQhQHwaZrLM/BK87F7b5Ij0jXrCpsHxE9HyGgUT0br+PDO0ZUCwfTSV0FA991lPPBronP+oL1XYOF+lU4HwBZYgv7FeP5cxMTbsgZRbk7ztOt2p1kgQovJE3COTs/gR2U+wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=b89yRSvG; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=A4OhSwwajnlbJjvs/Q79oC2Uvf5aCohLYBqTNgiZ5oo=;
	b=b89yRSvGMrh+gtH8+5gf0Iva+IGYO7lLRUGf6akpxjCx1TehG07XJ+9wV6OjFn4vTMDoGicq3
	MIxs/k06f3fLBHW/BxMYiTItmn2dvTNcNMV0XzYR1AkEWFLhU2QiC4wAQYllhG071pXWxP9ByYf
	exr88Uptb7sEkm+bX939kOg=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4dwV4s1QCmzmV6J;
	Tue, 20 Jan 2026 22:26:37 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 2511440565;
	Tue, 20 Jan 2026 22:30:01 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.188.120) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 20 Jan 2026 22:30:00 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Luo Yang <luoyang82@h-partners.com>
Subject: [PATCH net-next v01 2/5] hinic3: Fix code Style(remove empty lines between error handling)
Date: Tue, 20 Jan 2026 22:29:48 +0800
Message-ID: <2e3783a4d63c422447aab454dc26792f92bcd97b.1768915707.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1768915707.git.zhuyikai1@h-partners.com>
References: <cover.1768915707.git.zhuyikai1@h-partners.com>
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
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251514-lists,netdev=lfdr.de];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DMARC_POLICY_ALLOW(0.00)[huawei.com,quarantine];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gongfan1@huawei.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,huawei.com:email,huawei.com:dkim]
X-Rspamd-Queue-Id: CA9174BF7A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fix code style of removing empty lines between the actions on the
error handling path.

Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.c | 3 ---
 drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c  | 1 -
 drivers/net/ethernet/huawei/hinic3/hinic3_lld.c  | 5 -----
 drivers/net/ethernet/huawei/hinic3/hinic3_main.c | 4 ----
 drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c | 2 --
 drivers/net/ethernet/huawei/hinic3/hinic3_tx.c   | 1 -
 6 files changed, 16 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.c b/drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.c
index ef539d1b69a3..86720bb119e9 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.c
@@ -878,14 +878,11 @@ int hinic3_cmdqs_init(struct hinic3_hwdev *hwdev)
 	}
 
 	hinic3_free_db_addr(hwdev, cmdqs->cmdqs_db_base);
-
 err_destroy_cmdq_wq:
 	destroy_cmdq_wq(hwdev, cmdqs);
-
 err_free_cmdqs:
 	dma_pool_destroy(cmdqs->cmd_buf_pool);
 	kfree(cmdqs);
-
 err_out:
 	return err;
 }
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c b/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c
index 1ecc2aca1e35..a2c3962116d5 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c
@@ -686,7 +686,6 @@ int hinic3_aeqs_init(struct hinic3_hwdev *hwdev, u16 num_aeqs,
 	}
 
 	destroy_workqueue(aeqs->workq);
-
 err_free_aeqs:
 	kfree(aeqs);
 
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_lld.c b/drivers/net/ethernet/huawei/hinic3/hinic3_lld.c
index 2b77fea1e0b3..87413e192f10 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_lld.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_lld.c
@@ -230,7 +230,6 @@ static int hinic3_mapping_bar(struct pci_dev *pdev,
 		iounmap(pci_adapter->mgmt_reg_base);
 err_unmap_intr_reg_base:
 	iounmap(pci_adapter->intr_reg_base);
-
 err_unmap_cfg_reg_base:
 	iounmap(pci_adapter->cfg_reg_base);
 
@@ -285,10 +284,8 @@ static int hinic3_pci_init(struct pci_dev *pdev)
 err_release_regions:
 	pci_clear_master(pdev);
 	pci_release_regions(pdev);
-
 err_disable_device:
 	pci_disable_device(pdev);
-
 err_free_pci_adapter:
 	pci_set_drvdata(pdev, NULL);
 	mutex_destroy(&pci_adapter->pdev_mutex);
@@ -382,7 +379,6 @@ static int hinic3_probe_func(struct hinic3_pcidev *pci_adapter)
 	hinic3_func_uninit(pdev);
 err_unmap_bar:
 	hinic3_unmapping_bar(pci_adapter);
-
 err_out:
 	dev_err(&pdev->dev, "PCIe device probe function failed\n");
 
@@ -415,7 +411,6 @@ static int hinic3_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 err_uninit_pci:
 	hinic3_pci_uninit(pdev);
-
 err_out:
 	dev_err(&pdev->dev, "PCIe device probe failed\n");
 
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
index a33f86675954..6275d94dfefd 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
@@ -104,7 +104,6 @@ static int hinic3_alloc_txrxqs(struct net_device *netdev)
 
 err_free_rxqs:
 	hinic3_free_rxqs(netdev);
-
 err_free_txqs:
 	hinic3_free_txqs(netdev);
 
@@ -475,17 +474,14 @@ static int hinic3_nic_probe(struct auxiliary_device *adev,
 	disable_delayed_work_sync(&nic_dev->periodic_work);
 	hinic3_update_nic_feature(nic_dev, 0);
 	hinic3_set_nic_feature_to_hw(nic_dev);
-
 err_uninit_sw:
 	hinic3_sw_uninit(netdev);
-
 err_free_nic_io:
 	hinic3_free_nic_io(nic_dev);
 err_free_nic_dev:
 	hinic3_free_nic_dev(nic_dev);
 err_free_netdev:
 	free_netdev(netdev);
-
 err_unregister_adev_event:
 	hinic3_adev_event_unregister(adev);
 	dev_err(&pdev->dev, "NIC service probe failed\n");
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c b/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c
index 6eb441d6a590..c871fd0fb109 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c
@@ -446,10 +446,8 @@ int hinic3_init_mbox(struct hinic3_hwdev *hwdev)
 		hinic3_uninit_func_mbox_msg_channel(hwdev);
 err_uninit_mgmt_msg_ch:
 	uninit_mgmt_msg_channel(mbox);
-
 err_destroy_workqueue:
 	destroy_workqueue(mbox->workq);
-
 err_free_mbox:
 	kfree(mbox);
 
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
index ef32aed7d761..4e361c9bd043 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
@@ -609,7 +609,6 @@ static netdev_tx_t hinic3_send_one_skb(struct sk_buff *skb,
 
 err_drop_pkt:
 	dev_kfree_skb_any(skb);
-
 err_out:
 	return NETDEV_TX_OK;
 }
-- 
2.43.0


