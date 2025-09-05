Return-Path: <netdev+bounces-220268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F54B45190
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 10:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70D937B9754
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 08:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CA83164D9;
	Fri,  5 Sep 2025 08:29:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6417314A83;
	Fri,  5 Sep 2025 08:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757060971; cv=none; b=PtdZjtcfOoqQ4+wQ2dE9HQuSwQHsxp4AmfHOT7aGP2VNc7Z9a5T2+3Zdoauius/+PH+xi70mCK5Sh4vRlZu/ghU3RQNBhorgtduOmcVoM9XpzdNfQOZFR5nlkQMe3ug39LvzggD4I1nc7pv07D6KMdZ0NqlzGj0XpK/gFC5/KgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757060971; c=relaxed/simple;
	bh=s6eDdhRxwiAGwBQu1EeWsS2Kiz3ungjNpeZ+VY7CMBk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CfKwlMYJNxra7XN7pBAI8fvph/res07R6sl4Fvsw4E2J/1Ze5UaONO1KAE1Qy8nkrpxk2tr77EvIOaVeGApQbbVZcDoKbRA/EHeTUrmXb0m609lWONXZrbekMUByR5BIB7jDtAeD8WP6r54bLwBAcoWHevqHGB6lEcN+gvPYbok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4cJ8Xn2rCfz2Cg8K;
	Fri,  5 Sep 2025 16:24:57 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 4B7701A016C;
	Fri,  5 Sep 2025 16:29:27 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.55) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 5 Sep 2025 16:29:25 +0800
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
	<shijing34@huawei.com>, Luo Yang <luoyang82@h-partners.com>, Meny Yossefi
	<meny.yossefi@huawei.com>, Gur Stavi <gur.stavi@huawei.com>, Lee Trager
	<lee@trager.us>, Michael Ellerman <mpe@ellerman.id.au>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Suman Ghosh <sumang@marvell.com>, Przemek
 Kitszel <przemyslaw.kitszel@intel.com>, Joe Damato <jdamato@fastly.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH net-next v04 14/14] hinic3: Fix code style (Missing a blank line before return)
Date: Fri, 5 Sep 2025 16:28:48 +0800
Message-ID: <fa6fe42b9c6b1613241fe3017b080bd1bcdd649f.1757057860.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1757057860.git.zhuyikai1@h-partners.com>
References: <cover.1757057860.git.zhuyikai1@h-partners.com>
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

Fix code style of missing a blank line before return.

Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 drivers/net/ethernet/huawei/hinic3/hinic3_lld.c     | 5 +++++
 drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c | 1 +
 drivers/net/ethernet/huawei/hinic3/hinic3_tx.c      | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_lld.c b/drivers/net/ethernet/huawei/hinic3/hinic3_lld.c
index 10477fb9cc34..3db8241a3b0c 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_lld.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_lld.c
@@ -122,6 +122,7 @@ static int hinic3_attach_aux_devices(struct hinic3_hwdev *hwdev)
 			goto err_del_adevs;
 	}
 	mutex_unlock(&pci_adapter->pdev_mutex);
+
 	return 0;
 
 err_del_adevs:
@@ -133,6 +134,7 @@ static int hinic3_attach_aux_devices(struct hinic3_hwdev *hwdev)
 		}
 	}
 	mutex_unlock(&pci_adapter->pdev_mutex);
+
 	return -ENOMEM;
 }
 
@@ -154,6 +156,7 @@ struct hinic3_hwdev *hinic3_adev_get_hwdev(struct auxiliary_device *adev)
 	struct hinic3_adev *hadev;
 
 	hadev = container_of(adev, struct hinic3_adev, adev);
+
 	return hadev->hwdev;
 }
 
@@ -335,6 +338,7 @@ static int hinic3_probe_func(struct hinic3_pcidev *pci_adapter)
 
 err_out:
 	dev_err(&pdev->dev, "PCIe device probe function failed\n");
+
 	return err;
 }
 
@@ -367,6 +371,7 @@ static int hinic3_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 err_out:
 	dev_err(&pdev->dev, "PCIe device probe failed\n");
+
 	return err;
 }
 
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
index 9349b8a314ae..979f47ca77f9 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
@@ -112,6 +112,7 @@ int hinic3_set_port_mtu(struct net_device *netdev, u16 new_mtu)
 	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
 
 	func_tbl_cfg.mtu = new_mtu;
+
 	return hinic3_set_function_table(hwdev, BIT(L2NIC_FUNC_TBL_CFG_MTU),
 					 &func_tbl_cfg);
 }
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
index dea882260b11..92c43c05e3f2 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
@@ -116,6 +116,7 @@ static int hinic3_tx_map_skb(struct net_device *netdev, struct sk_buff *skb,
 	}
 	dma_unmap_single(&pdev->dev, dma_info[0].dma, dma_info[0].len,
 			 DMA_TO_DEVICE);
+
 	return err;
 }
 
@@ -601,6 +602,7 @@ netdev_tx_t hinic3_xmit_frame(struct sk_buff *skb, struct net_device *netdev)
 
 err_drop_pkt:
 	dev_kfree_skb_any(skb);
+
 	return NETDEV_TX_OK;
 }
 
-- 
2.43.0


