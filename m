Return-Path: <netdev+bounces-287119-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GH5yGmklA2oF1AEAu9opvQ
	(envelope-from <netdev+bounces-287119-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:04:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E543520A34
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABA87320BC7A
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A43A3911D3;
	Tue, 12 May 2026 12:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="cUVxgbHk"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DB4397334;
	Tue, 12 May 2026 12:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778589458; cv=none; b=htZrl12F6crw/fk1Pbe4CaPA7r9VlS4EkZI4bICqqspY0IPU/+s5Yu9S5vuxHVPYtOujru7Ws/t0om8x84AvZTO3PIZi83MMQjvxz6g/kyfs5WSxVNd86bgFXlIZTZdnJgpbU0obfDMWI47DkgpiUguajktbpsZJ7QGo6GjYw/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778589458; c=relaxed/simple;
	bh=FtHibDwf4diqOTLQfe/537XWA1YucT72UJL/lnnYIGc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IEyoy8LRROU0JqOd97PB22PquR7YG6mEwYa+k09XD9BieL3WhuiffwsLAhOkCMGyMHbpnpw/bvPtJ7m+1mA/8adAO55DncB0TUVNZo7VKdVI2zjiaryOC82SEQrRyedSXfju6EsVGIvUx3C1HBqDMEGkKSBPlM4B7KjVQCsxh7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=cUVxgbHk; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=erlvBGRu2nXaiUh13OE6LqIxT/cq/tW3w2iP08op2gY=;
	b=cUVxgbHkw1m8Z3DtSM8ObdSPwOXHlsearDaZ2dwlYTk+OdhFw/jsSYnE3dIIbI3Hkh2pkVub+
	6MA/Nsv1Cp32SEizDxMC9i8KGlaeQiQWVrWsxD6W1rOgEBLymTzXgPZrKzEVk0pevsSTWikUJ/7
	vy/nkqGibUOJspAx2RywUA8=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4gFGBl6jRLzcZxn;
	Tue, 12 May 2026 20:30:07 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id A64B44048F;
	Tue, 12 May 2026 20:37:27 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 12 May 2026 20:37:27 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <huangdonghua3@h-partners.com>,
	<yangshuaisong@h-partners.com>, <shiyongbang@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH net] net: hibmcge: fix incorrect packets in the RX path issue
Date: Tue, 12 May 2026 20:34:56 +0800
Message-ID: <20260512123456.3786635-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk100013.china.huawei.com (7.202.194.61)
X-Rspamd-Queue-Id: 1E543520A34
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287119-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shaojijie@huawei.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[huawei.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,huawei.com:mid,huawei.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The test found that when the SMMU is disabled,
the driver may receive the following error packet:
note: The memory is initialized to 0xfe,
and 0xbf is what we expect.

00000440: bf bf bf bf bf bf bf bf bf bf bf bf bf bf bf bf
00000450: bf bf bf bf bf bf bf bf bf bf bf bf bf bf bf bf
00000460: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
00000470: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
00000480: bf bf bf bf bf bf bf bf bf bf bf bf bf bf bf bf
00000490: bf bf bf bf bf bf bf bf bf bf bf bf bf bf bf bf

It seems that the packet is not completely written when the descriptor
indicates that the packet is valid. According to the chip document,
the chip writes packets first and then writes the descriptor.
However, the actual sequence in which the packets and descriptor are
written to the memory is incorrect.

Each packet and descriptor of the hibmcge are in the same page.
Therefore, when the Relaxed Ordering is enabled, the transactions for
writing packets and writing descriptors may not be strictly ordered.
As a result, the driver receives incorrect packets.

Therefore, this patch disables the Relaxed Ordering to ensure the
strict order of packets and descriptors.

Additionally, during the process of analyzing the issue,
it was discovered that the position of dma_rmb() was incorrect.
It should first execute dma_sync_single_for_cpu(), and then dma_rmb().
This patch has also made the corresponding modifications.

Fixes: f72e25594061 ("net: hibmcge: Implement rx_poll function to receive packets")
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c | 4 +++-
 drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c | 6 +++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
index 068da2fd1fea..5b91b596349c 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
@@ -420,6 +420,8 @@ static int hbg_pci_init(struct pci_dev *pdev)
 		return -ENOMEM;
 
 	pci_set_master(pdev);
+	pcie_capability_clear_word(pdev, PCI_EXP_DEVCTL,
+				   PCI_EXP_DEVCTL_RELAX_EN);
 	return 0;
 }
 
@@ -525,4 +527,4 @@ module_exit(hbg_module_exit);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Huawei Tech. Co., Ltd.");
 MODULE_DESCRIPTION("hibmcge driver");
-MODULE_VERSION("1.0");
+MODULE_VERSION("2.0");
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
index a4ea92c31c2f..0ae314994676 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
@@ -452,12 +452,12 @@ static bool hbg_sync_data_from_hw(struct hbg_priv *priv,
 {
 	struct hbg_rx_desc *rx_desc;
 
-	/* make sure HW write desc complete */
-	dma_rmb();
-
 	dma_sync_single_for_cpu(&priv->pdev->dev, buffer->page_dma,
 				buffer->page_size, DMA_FROM_DEVICE);
 
+	/* make sure HW write desc complete */
+	dma_rmb();
+
 	rx_desc = (struct hbg_rx_desc *)buffer->page_addr;
 	return FIELD_GET(HBG_RX_DESC_W2_PKT_LEN_M, rx_desc->word2) != 0;
 }
-- 
2.33.0


