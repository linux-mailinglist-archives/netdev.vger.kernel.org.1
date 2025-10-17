Return-Path: <netdev+bounces-230371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D008BE72F4
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 10:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4BC75506199
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 08:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6D12D4B5A;
	Fri, 17 Oct 2025 08:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ryYv1j5o"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6332D0C9A;
	Fri, 17 Oct 2025 08:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760689878; cv=none; b=fHO4cBTjDcArFdBjx+pTB/nor9INYXK1HmWZFr+jnDNwCNbHcYPIZlK2XkGLaptMy12TQvqJzSEr8icd2dUfbmA1aJnrCOy9iCTRl8lAK/vnHK2XL2hlZ92T3MwrxXZ0Eq6Ega4gEJPwGSYI5mn8l+dXc5BJveLI0uBQWKQNblc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760689878; c=relaxed/simple;
	bh=8/44DH+VJi01EKMZ38B3GgU5w49APQy5yXO2lzF4NjA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c5Km0p0oataknx/spdAtZ5m2ZWtmz4E9afuE0CXliqSKODkqkLoNBxSqt3h/Ks7B/+oOs2gA5VoGRYGwWnsK8YROqCJKgV147BpVI86i64J6NmTQmUBqVeXEKgp6qA8Q1CIOYROmDllnu11cWnq+BYctG7GlUoN4BT4gWBQptDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ryYv1j5o; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=MnOutk47QvDoa3ir0hU1umYb1qFKDmXojwK8fjtF58s=;
	b=ryYv1j5ojTYpnLpFbZ1fh2BKJOTAsrXVJy8aAZR6YSO7J5sRuIMVhfUsNpe11aiNOYGSfLGCk
	aKmLjknoR3lR0zfgn6VJCF2FzgjQPUniKwgNGz+Qr02HKrOnmpTisn5pIfwnSAzd3zjZaXOy015
	ZbiqHym/XCvomzf2sITFegk=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4cnygS1zxFzcZyl;
	Fri, 17 Oct 2025 16:30:12 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 310BE180064;
	Fri, 17 Oct 2025 16:31:14 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.188.120) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 17 Oct 2025 16:31:12 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, <Markus.Elfring@web.de>, <pavan.chebbi@broadcom.com>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Shen Chenyang
	<shenchenyang1@hisilicon.com>, Zhou Shuai <zhoushuai28@huawei.com>, Wu Like
	<wulike1@huawei.com>, Shi Jing <shijing34@huawei.com>, Luo Yang
	<luoyang82@h-partners.com>, Meny Yossefi <meny.yossefi@huawei.com>, Gur Stavi
	<gur.stavi@huawei.com>
Subject: [PATCH net-next v02 6/6] hinic3: Fix netif_queue_set_napi queue_index parameter passing error
Date: Fri, 17 Oct 2025 16:30:51 +0800
Message-ID: <c4d3c2ef38ab788aeeb7a7a7988578eb2e70ee8a.1760685059.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1760685059.git.zhuyikai1@h-partners.com>
References: <cover.1760685059.git.zhuyikai1@h-partners.com>
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

Incorrectly transmitted interrupt number instead of queue number
when using netif_queue_set_napi. Besides, move this to appropriate
code location.

Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 .../net/ethernet/huawei/hinic3/hinic3_irq.c   | 21 ++++++++++---------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c b/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
index d793dff88109..057f7a2eaae0 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
@@ -46,21 +46,12 @@ static void qp_add_napi(struct hinic3_irq_cfg *irq_cfg)
 	struct hinic3_nic_dev *nic_dev = netdev_priv(irq_cfg->netdev);
 
 	netif_napi_add(nic_dev->netdev, &irq_cfg->napi, hinic3_poll);
-	netif_queue_set_napi(irq_cfg->netdev, irq_cfg->irq_id,
-			     NETDEV_QUEUE_TYPE_RX, &irq_cfg->napi);
-	netif_queue_set_napi(irq_cfg->netdev, irq_cfg->irq_id,
-			     NETDEV_QUEUE_TYPE_TX, &irq_cfg->napi);
 	napi_enable(&irq_cfg->napi);
 }
 
 static void qp_del_napi(struct hinic3_irq_cfg *irq_cfg)
 {
 	napi_disable(&irq_cfg->napi);
-	netif_queue_set_napi(irq_cfg->netdev, irq_cfg->irq_id,
-			     NETDEV_QUEUE_TYPE_RX, NULL);
-	netif_queue_set_napi(irq_cfg->netdev, irq_cfg->irq_id,
-			     NETDEV_QUEUE_TYPE_TX, NULL);
-	netif_stop_subqueue(irq_cfg->netdev, irq_cfg->irq_id);
 	netif_napi_del(&irq_cfg->napi);
 }
 
@@ -283,6 +274,11 @@ int hinic3_qps_irq_init(struct net_device *netdev)
 			goto err_release_irqs;
 		}
 
+		netif_queue_set_napi(irq_cfg->netdev, q_id,
+				     NETDEV_QUEUE_TYPE_RX, &irq_cfg->napi);
+		netif_queue_set_napi(irq_cfg->netdev, q_id,
+				     NETDEV_QUEUE_TYPE_TX, &irq_cfg->napi);
+
 		hinic3_set_msix_auto_mask_state(nic_dev->hwdev,
 						irq_cfg->msix_entry_idx,
 						HINIC3_SET_MSIX_AUTO_MASK);
@@ -319,12 +315,17 @@ void hinic3_qps_irq_uninit(struct net_device *netdev)
 
 	for (q_id = 0; q_id < nic_dev->q_params.num_qps; q_id++) {
 		irq_cfg = &nic_dev->q_params.irq_cfg[q_id];
-		qp_del_napi(irq_cfg);
 		hinic3_set_msix_state(nic_dev->hwdev, irq_cfg->msix_entry_idx,
 				      HINIC3_MSIX_DISABLE);
 		hinic3_set_msix_auto_mask_state(nic_dev->hwdev,
 						irq_cfg->msix_entry_idx,
 						HINIC3_CLR_MSIX_AUTO_MASK);
 		hinic3_release_irq(irq_cfg);
+		qp_del_napi(irq_cfg);
+
+		netif_queue_set_napi(irq_cfg->netdev, q_id,
+				     NETDEV_QUEUE_TYPE_RX, NULL);
+		netif_queue_set_napi(irq_cfg->netdev, q_id,
+				     NETDEV_QUEUE_TYPE_TX, NULL);
 	}
 }
-- 
2.43.0


