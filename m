Return-Path: <netdev+bounces-265090-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALNyKgvKq2nggwEAu9opvQ
	(envelope-from <netdev+bounces-265090-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 07:47:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A7922A739
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 07:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A256F3091A94
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 06:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D2A3806B7;
	Sat,  7 Mar 2026 06:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="D6eEopar"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5537377541;
	Sat,  7 Mar 2026 06:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772865856; cv=none; b=pt6KboztN71HLbiR0ejod/Q49+nKusqqSczPPkp1Ho52m87oqao6sBZtSLlFU8rZntCNzhPbtlB5FsOkUKvo9Yu930VKxx6Ar4x1j6/nFXBAnuRv4Oo7wWfJcxfC9ZwCtvF2E4zuxMdrJ40gj3h3eCdBfnxxD4WHPbyAM7Ywe7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772865856; c=relaxed/simple;
	bh=mu7OOqmRUUvXUDSmyImBo4YtDTMKWA5OASMjhbJ5SJs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=erKTMWxNRFOma/q+tPJDI0R+Af0jmA3qEHbKxo6tQ8siFsZ8Qg9aQCYE4LXs9ffiE8ZwJ/oPFiS9F1QKvuTGvLzwldqstW47VNY62ZGzj2p46/mieOkyGQ+4L5y/2mMtoCji70ilaWZXDduBhHlo4NM28mKKhbV8sdV5c/bMjB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=D6eEopar; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=THRDJ+E48K6F9DD0lHqYIl3GAVa8B7RB0lSAfpLdo2Y=;
	b=D6eEoparZ5f0HySV3WCGMvMhnP3Ff/6hS6e4bI4b/2pb/Jyfxre5k2dC4BarFeR1nysixeLwS
	po+rJiQH7SEVjnzgZiMrjYRXgkxI+urIM3JfoEunZnLMDwoZ9En1tGjsMAQ5+m2CZn5wlnUkq+v
	0O/C/ZQzr8B6L/c6oH6CEkg=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4fSYX70CYQzpStv;
	Sat,  7 Mar 2026 14:39:03 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 7112E40363;
	Sat,  7 Mar 2026 14:44:07 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Sat, 7 Mar 2026 14:44:06 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Zheng Jiezhen <zhengjiezhen@h-partners.com>
Subject: [PATCH net-next v02 6/9] hinic3: Add PF device support and function type validation
Date: Sat, 7 Mar 2026 14:43:45 +0800
Message-ID: <1ed70b760ce6345c3a3d1332e62e6f5d93e931f3.1772697509.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1772697509.git.zhuyikai1@h-partners.com>
References: <cover.1772697509.git.zhuyikai1@h-partners.com>
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
X-Rspamd-Queue-Id: 20A7922A739
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265090-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gongfan1@huawei.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:dkim,huawei.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,h-partners.com:mid,h-partners.com:email]
X-Rspamd-Action: no action

  Add PF device ID to support for PF devices in driver and enhance
function type validation to ensure proper handling of both PF and
VF.

Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 .../net/ethernet/huawei/hinic3/hinic3_hwdev.c |  4 ++++
 .../net/ethernet/huawei/hinic3/hinic3_hwif.c  | 21 +++++++++++++++++--
 .../net/ethernet/huawei/hinic3/hinic3_lld.c   |  1 +
 .../net/ethernet/huawei/hinic3/hinic3_mbox.c  |  3 ++-
 .../huawei/hinic3/hinic3_pci_id_tbl.h         |  1 +
 5 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
index 04c0385b3344..f44b3064ab2e 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
@@ -434,6 +434,10 @@ static int init_cmdqs_channel(struct hinic3_hwdev *hwdev)
 static void hinic3_free_cmdqs_channel(struct hinic3_hwdev *hwdev)
 {
 	hinic3_comm_cmdqs_free(hwdev);
+
+	hinic3_set_wq_page_size(hwdev, hinic3_global_func_id(hwdev),
+				HINIC3_MIN_PAGE_SIZE);
+
 	hinic3_ceqs_free(hwdev);
 }
 
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c
index 70d70556dca6..90feaa225080 100644
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
@@ -137,6 +145,7 @@ static void set_hwif_attr(struct hinic3_func_attr *attr, u32 attr0, u32 attr1,
 static int init_hwif_attr(struct hinic3_hwdev *hwdev)
 {
 	u32 attr0, attr1, attr2, attr3, attr6;
+	struct hinic3_func_attr *attr;
 	struct hinic3_hwif *hwif;
 
 	hwif = hwdev->hwif;
@@ -160,7 +169,15 @@ static int init_hwif_attr(struct hinic3_hwdev *hwdev)
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
index a8b89eeed753..f83d5bd1041e 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_lld.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_lld.c
@@ -426,6 +426,7 @@ static void hinic3_remove(struct pci_dev *pdev)
 }
 
 static const struct pci_device_id hinic3_pci_table[] = {
+	{PCI_VDEVICE(HUAWEI, PCI_DEV_ID_HINIC3_PF), 0},
 	{PCI_VDEVICE(HUAWEI, PCI_DEV_ID_HINIC3_VF), 0},
 	{0, 0}
 
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c b/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c
index 51be726d9d2e..c1bc64a50dd3 100644
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


