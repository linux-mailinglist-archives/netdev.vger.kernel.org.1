Return-Path: <netdev+bounces-229504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C389BDCE4B
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 09:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1903E3C3F0C
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 07:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6AE3164BE;
	Wed, 15 Oct 2025 07:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Ue+4WAlp"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BFD313272;
	Wed, 15 Oct 2025 07:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760512567; cv=none; b=PNgZzDslXALNIdu910KvqA5YqTOTw1MiLWVQhFUhE9DJaZdz/E9gF1kLQht3g5rpoChOkCCQo6riCXSmiuJDT8pYP4A6opaUdSVfXhcGDB28oyeUDJsTfz8rFQwve0MGc0K3V46+5lQZbU12yyhfHzhCQXvkR4fxUcSI0D2/jmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760512567; c=relaxed/simple;
	bh=gyz1kEkhRe3BRCL9LM36AhOcJOWr8U51WY0lNDuaXMM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KJh3oa5IuBXBbmd0ngGFtZDcdmSyYf/AICFh8Cj/YomyOW9fh1Bkk6IwTdInATDSXaTKtpJt1jwMvNB68pfKxLaoNsXhjAzyA4+L97MXbxUmqnsmG8ipA8zKBz8hxSzyPpWJxLAFJrJLmuPXb94ShHbNK3xvjN7a+avcEbKZQ0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Ue+4WAlp; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=WZx369gXVXgRP6zbFHLvGOLP780avbJS1vGbN1ZwrJc=;
	b=Ue+4WAlp+iq2NCnke6OGdP5mhbA9cdLwxUa4Kcrr1fU2nbueg35O2O9KUSr/3eNfOxDPDq+xg
	dmDIK14uH37Oy50oBGPQIL+XT9bXkKZEfHUMgAaMXw0DhRyzMWg2Xw/5kZTrN+7xdSAO93R2hs1
	OFzrA/RJzV0QxNwyOIWh7DY=
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4cmj5w0XWgz12LFQ;
	Wed, 15 Oct 2025 15:15:16 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 3E1FE140203;
	Wed, 15 Oct 2025 15:16:01 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.188.120) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 15 Oct 2025 15:15:59 +0800
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
Subject: [PATCH net-next v01 6/9] hinic3: Fix netif_queue_set_napi queue_index parameter passing error
Date: Wed, 15 Oct 2025 15:15:32 +0800
Message-ID: <c01f9ce033ecb5734357cc6de60e9d1952bd70b8.1760502478.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1760502478.git.zhuyikai1@h-partners.com>
References: <cover.1760502478.git.zhuyikai1@h-partners.com>
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
index 6898aa34b4e1..d2c131f2c43a 100644
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
 
@@ -281,6 +272,11 @@ int hinic3_qps_irq_init(struct net_device *netdev)
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
@@ -317,12 +313,17 @@ void hinic3_qps_irq_uninit(struct net_device *netdev)
 
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


