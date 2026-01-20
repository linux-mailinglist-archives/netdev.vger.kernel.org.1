Return-Path: <netdev+bounces-251513-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIvtAaWjb2kNDwAAu9opvQ
	(envelope-from <netdev+bounces-251513-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 16:47:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9655846A92
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 16:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3C0B868CE8C
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 14:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D7A44CAF5;
	Tue, 20 Jan 2026 14:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ZB9WbBvU"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37CA44102F;
	Tue, 20 Jan 2026 14:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768919408; cv=none; b=mJIeczB0WXy6QlCrOVGTJVLnpqdgUNKiIy/VUSsjFpealxpPYp8V8kA7LRwKiyQxcuNSSpmKUTR5G6aGnZ7wp3MSpLrJy0ojdqtlDC/nwHT9V8Jw3iF9ttNJjBfo9C+3wErCR9KMpzcNKGO3IdVu7F/6vIlLMKLg4X0OzPAdy3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768919408; c=relaxed/simple;
	bh=O1XFFyAoaxKuZ+CVZRzqRWtI1lDMsZQl8WUrynlEDFM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XRzhEkBi11wqNy/eBIWEz5IOe4sTzg7P7L8pGuUkDiSaB8sdQESaqkIWF9MxI6+wir8F6CPSlVlnx+tY4jKIY/+xfy8oLBXsoM8QOStGnTBe0u+zKBxPVY/yglGFEwNnXS4fNrCuaAT0lurxTcE8OEilsUPUJOVaWT7GRrih/KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ZB9WbBvU; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=bL4qp+lXFE2452QYi0P16NYT5Mi/5g2ecYZa0M3HDBY=;
	b=ZB9WbBvU0zbRBB/enag3mhxp6gwAwDOX6TK4VVqY60OBXVzijK62V3ReAGITKZJddL8ihYVDf
	36uX6834G1wIZA7lbY3S4JNkjbyt5/Tbt+SKw8+nZQhGJUkwcCDpECKb0B73X7zqfpfTUbw+1Iz
	QTnSNHNY9GMsXkeJhS0Oj/I=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4dwV4w1VpbzLlSN;
	Tue, 20 Jan 2026 22:26:40 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id D53DC402AB;
	Tue, 20 Jan 2026 22:30:02 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.188.120) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 20 Jan 2026 22:30:01 +0800
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
Subject: [PATCH net-next v01 3/5] hinic3: Remove redundant defensive code
Date: Tue, 20 Jan 2026 22:29:49 +0800
Message-ID: <b7183f234d4d6bd432d8386fee2ed3e7eb56d064.1768915707.git.zhuyikai1@h-partners.com>
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
	TAGGED_FROM(0.00)[bounces-251513-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,h-partners.com:email,h-partners.com:mid]
X-Rspamd-Queue-Id: 9655846A92
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

According to comment of patch 03, check codes that were merged and
remove redundant defensive codes.

Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 drivers/net/ethernet/huawei/hinic3/hinic3_tx.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
index 4e361c9bd043..6d3dc930ca97 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
@@ -44,16 +44,10 @@ static void hinic3_txq_stats_init(struct hinic3_txq *txq)
 int hinic3_alloc_txqs(struct net_device *netdev)
 {
 	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
-	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
 	u16 q_id, num_txqs = nic_dev->max_qps;
 	struct pci_dev *pdev = nic_dev->pdev;
 	struct hinic3_txq *txq;
 
-	if (!num_txqs) {
-		dev_err(hwdev->dev, "Cannot allocate zero size txqs\n");
-		return -EINVAL;
-	}
-
 	nic_dev->txqs = kcalloc(num_txqs, sizeof(*nic_dev->txqs),  GFP_KERNEL);
 	if (!nic_dev->txqs)
 		return -ENOMEM;
-- 
2.43.0


