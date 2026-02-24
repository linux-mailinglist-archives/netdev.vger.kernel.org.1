Return-Path: <netdev+bounces-260530-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKvLK9WknWmZQwQAu9opvQ
	(envelope-from <netdev+bounces-260530-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 14:17:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC21187798
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 14:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8D3553002330
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 13:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABFB39E6FF;
	Tue, 24 Feb 2026 13:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="YfsRMraz"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D63539C634;
	Tue, 24 Feb 2026 13:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771938980; cv=none; b=nJ6dp0AaFYA10LcX0eQo8ZE1dspTCmADsi/NnfofDDHKPTcc6CGjQU1c0n4BXFVJEoO//pp0jEBSkWG93nV97UQEkWS2RFcm7I/A0P8j9LBYfqPxIBkFLtM19bo/4aqsH/E+SE89cWVeQfUHT4oL4iNAvP3acIQFTwIGnLuoXH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771938980; c=relaxed/simple;
	bh=d9dTAKwjA0riwui6UsdxBr8mN+j0DxeF5FO2RsgksLw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NotK7aQidEEIZurJ/3n5cQEG11qiXkXG8Nju83o8V/csqYDx1TnZI7CCOXN/E5a3IjHj/YtDrdv9mXjrgOi0rhWD6pgRr92iJAvdCzGOcnCLJ3og99MEiKzNWUtg0K+1fhvgfj7EMkdcAj2ry9+5uCI9gMV2hSoMXCrYX5hEZrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=YfsRMraz; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=1xJ2QJhWxIAVVvE8xZz70eCPxBajA67SOUZtgZWuWY4=;
	b=YfsRMraz2olsoXNFkV/NmH2iRFhg+3ed4Ni64RYbV7yDOA3aYeH3fMmFjlSIt8NygU39OB27Z
	puzRCAjv2tWztDnVVQTL0t/xgRNAiueN8q/cIces4i9ypbgsAPawdc4OViSx8zxtCEl+yPqqxTi
	2sXtgNt7xj0uZbqoRXghx1c=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4fKym433syz12LD7;
	Tue, 24 Feb 2026 21:11:32 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 6C91440570;
	Tue, 24 Feb 2026 21:16:13 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 24 Feb 2026 21:16:12 +0800
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
Subject: [PATCH net-next v01 06/15] hinic3: Add PF device support and function type validation
Date: Tue, 24 Feb 2026 21:15:43 +0800
Message-ID: <34c08860101ba62390782894a6d25d101dd5ad5a.1771916043.git.zhuyikai1@h-partners.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260530-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gongfan1@huawei.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,h-partners.com:mid,h-partners.com:email]
X-Rspamd-Queue-Id: 5BC21187798
X-Rspamd-Action: no action

Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 .../net/ethernet/huawei/hinic3/hinic3_hwdev.c |  6 ++++++
 .../net/ethernet/huawei/hinic3/hinic3_hwif.c  | 21 +++++++++++++++++--
 .../net/ethernet/huawei/hinic3/hinic3_lld.c   |  1 +
 .../net/ethernet/huawei/hinic3/hinic3_mbox.c  |  3 ++-
 .../huawei/hinic3/hinic3_pci_id_tbl.h         |  1 +
 5 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
index c02a0a4a5771..47433a81b570 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
@@ -423,6 +423,7 @@ static int init_cmdqs_channel(struct hinic3_hwdev *hwdev)
 	return 0;
 
 err_reset_wq_page_size:
+if (HINIC3_FUNC_TYPE(hwdev) != HINIC3_FUNC_TYPE_VF)
 	hinic3_set_wq_page_size(hwdev, hinic3_global_func_id(hwdev),
 				HINIC3_MIN_PAGE_SIZE);
 err_free_ceqs:
@@ -434,6 +435,11 @@ static int init_cmdqs_channel(struct hinic3_hwdev *hwdev)
 static void hinic3_free_cmdqs_channel(struct hinic3_hwdev *hwdev)
 {
 	hinic3_comm_cmdqs_free(hwdev);
+
+	if (HINIC3_FUNC_TYPE(hwdev) != HINIC3_FUNC_TYPE_VF)
+		hinic3_set_wq_page_size(hwdev, hinic3_global_func_id(hwdev),
+					HINIC3_MIN_PAGE_SIZE);
+
 	hinic3_ceqs_free(hwdev);
 }
 
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c
index e4dd4c717eec..518d4723d6c8 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c
@@ -70,11 +70,19 @@
 #define HINIC3_PPF_ELECTION_GET(val, member) \
 	FIELD_GET(HINIC3_PPF_ELECTION_##member##_MASK, val)
 
+#define HINIC3_GET_REG_FLAG(reg)  ((reg) & (~(HINIC3_REGS_FLAG_MASK)))
 #define HINIC3_GET_REG_ADDR(reg)  ((reg) & (HINIC3_REGS_FLAG_MASK))
 
 static void __iomem *hinic3_reg_addr(struct hinic3_hwif *hwif, u32 reg)
 {
-	return hwif->cfg_regs_base + HINIC3_GET_REG_ADDR(reg);
+	void __iomem *addr;
+
+	if (HINIC3_GET_REG_FLAG(reg) == HINIC3_MGMT_REGS_FLAG)
+		addr = hwif->mgmt_regs_base + HINIC3_GET_REG_ADDR(reg);
+	else
+		addr = hwif->cfg_regs_base + HINIC3_GET_REG_ADDR(reg);
+
+	return addr;
 }
 
 u32 hinic3_hwif_read_reg(struct hinic3_hwif *hwif, u32 reg)
@@ -139,6 +147,7 @@ static void set_hwif_attr(struct hinic3_func_attr *attr, u32 attr0, u32 attr1,
 static int init_hwif_attr(struct hinic3_hwdev *hwdev)
 {
 	u32 attr0, attr1, attr2, attr3, attr6;
+	struct hinic3_func_attr *attr;
 	struct hinic3_hwif *hwif;
 
 	hwif = hwdev->hwif;
@@ -162,7 +171,15 @@ static int init_hwif_attr(struct hinic3_hwdev *hwdev)
 	if (attr6 == HINIC3_PCIE_LINK_DOWN)
 		return -EFAULT;
 
-	set_hwif_attr(&hwif->attr, attr0, attr1, attr2, attr3, attr6);
+	attr = &hwif->attr;
+	set_hwif_attr(attr, attr0, attr1, attr2, attr3, attr6);
+
+	if (attr->func_type != HINIC3_FUNC_TYPE_VF &&
+	    attr->func_type != HINIC3_FUNC_TYPE_PF) {
+		dev_err(hwdev->dev, "unexpected func_type %u\n",
+			attr->func_type);
+		return -EINVAL;
+	}
 
 	if (!hwif->attr.num_ceqs) {
 		dev_err(hwdev->dev, "Ceq num cfg in fw is zero\n");
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_lld.c b/drivers/net/ethernet/huawei/hinic3/hinic3_lld.c
index 87413e192f10..1465c54e579e 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_lld.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_lld.c
@@ -426,6 +426,7 @@ static void hinic3_remove(struct pci_dev *pdev)
 }
 
 static const struct pci_device_id hinic3_pci_table[] = {
+	{PCI_VDEVICE(HUAWEI, PCI_DEV_ID_HINIC3_PF), 0},
 	{PCI_VDEVICE(HUAWEI, PCI_DEV_ID_HINIC3_VF), 0},
 	{0, 0}
 
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c b/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c
index 8554291f852d..2da18145befa 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c
@@ -462,7 +462,8 @@ void hinic3_free_mbox(struct hinic3_hwdev *hwdev)
 
 	destroy_workqueue(mbox->workq);
 	free_mbox_wb_status(mbox);
-	hinic3_uninit_func_mbox_msg_channel(hwdev);
+	if (HINIC3_IS_VF(hwdev))
+		hinic3_uninit_func_mbox_msg_channel(hwdev);
 	uninit_mgmt_msg_channel(mbox);
 	kfree(mbox);
 }
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_pci_id_tbl.h b/drivers/net/ethernet/huawei/hinic3/hinic3_pci_id_tbl.h
index 86c88d0bb4bd..02b2b0fbecc7 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_pci_id_tbl.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_pci_id_tbl.h
@@ -4,6 +4,7 @@
 #ifndef _HINIC3_PCI_ID_TBL_H_
 #define _HINIC3_PCI_ID_TBL_H_
 
+#define PCI_DEV_ID_HINIC3_PF    0x0222
 #define PCI_DEV_ID_HINIC3_VF    0x375F
 
 #endif
-- 
2.43.0


