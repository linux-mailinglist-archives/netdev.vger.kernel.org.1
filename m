Return-Path: <netdev+bounces-136599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D52A9A2471
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 16:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 426A82863EB
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 14:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3872B1DDC11;
	Thu, 17 Oct 2024 14:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fo+eB0Hv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C8639FE5
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 14:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729173724; cv=none; b=NUdFrpojRshj6OsPOKTf6c+Wbb5fY3wQavj0K+UONEZMOH51/ZLdm88R4Lys07Pxfms8NdZnmymoxeFD9Vw24fFTdUluddBfdFliM+YZssu/XQWbTIicG1FhvTEAN7lIXtpquVXT4YDgGY9qHsqyntiRkFcOG3zLZ4j/10HoeTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729173724; c=relaxed/simple;
	bh=pLt4qtrvN+Wt60ikm10Xa1vqgY/lQUmiZwndPnYxBeo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pCMEQYdZhF01bU+eqNZ3/3k7aZjZXcYToc6eHALuAcBbb+7FoVtv+cXqf72hSpxoe4TULUyGaSnQdtq21ma1oxXRFquCQrLZVC2r4ROzmboJsTWwOTR+wkmgrDbSfqX0X5j9QatXgX+91Qrx180bo+/ZK693y0TUTQMzG6/X5GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fo+eB0Hv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A260C4CEC3;
	Thu, 17 Oct 2024 14:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729173723;
	bh=pLt4qtrvN+Wt60ikm10Xa1vqgY/lQUmiZwndPnYxBeo=;
	h=From:Date:Subject:To:Cc:From;
	b=Fo+eB0Hv88wp/+U3UCLqtvYrXW+UX4BcvoIgFm+If1ksawMPOXxeKkkMw3bjQmdrD
	 RsbybO+udVFCkvTo3PJDMSmPyzsTFGOcbQQbynI9fVjqgobIeregdV4HGYJYpS9ZHr
	 06VRQfetPT/Aw/pK/n3XQlgiTZ6MSMgIVyi7LKmNWwEXSsGC7qHpqE6Kj59tZn313c
	 mEb4ZwzbeSBa37fdfa01kNeTHnjzdHI4T8frf8DvIQTaXEUBDSsUtgW+AApgqcct6c
	 NnR/IlAnFC9dX6TxrDzoa45IyJ0aMCsaTFcReHagYxotKHPA1PT13+qgV9EcdV/P/1
	 nl67WMN4/w/rg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 17 Oct 2024 16:01:41 +0200
Subject: [PATCH net-next] net: airoha: Reset BQL stopping the netdevice
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-airoha-en7581-reset-bql-v1-1-08c0c9888de5@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMQYEWcC/x3MQQrCMBBG4auUWXcgExIqXkVcJM2vHZBUJ6UIp
 Xc3uPwW7x3UYIpG1+Egw65N19oh40DzkuoTrKWbvPNBnEyc1NYlMeoUL8KGho3z58UhIuQSZ++
 KUK/fhod+/+fb/Tx/kguGa2kAAAA=
X-Change-ID: 20241017-airoha-en7581-reset-bql-45e4bd5c20d1
To: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
 Mark Lee <Mark-MC.Lee@mediatek.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Run airoha_qdma_cleanup_tx_queue() in ndo_stop callback in order to
unmap pending skbs. Moreover, reset BQL txq state stopping the netdevice,

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/airoha_eth.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
index 836a957aad77bec972c536567a4ee7d304ac7b52..23905f54f991fc8062542b890fbf002154676612 100644
--- a/drivers/net/ethernet/mediatek/airoha_eth.c
+++ b/drivers/net/ethernet/mediatek/airoha_eth.c
@@ -2341,7 +2341,7 @@ static int airoha_dev_stop(struct net_device *dev)
 {
 	struct airoha_gdm_port *port = netdev_priv(dev);
 	struct airoha_qdma *qdma = port->qdma;
-	int err;
+	int i, err;
 
 	netif_tx_disable(dev);
 	err = airoha_set_gdm_ports(qdma->eth, false);
@@ -2352,6 +2352,14 @@ static int airoha_dev_stop(struct net_device *dev)
 			  GLOBAL_CFG_TX_DMA_EN_MASK |
 			  GLOBAL_CFG_RX_DMA_EN_MASK);
 
+	for (i = 0; i < ARRAY_SIZE(qdma->q_tx); i++) {
+		if (!qdma->q_tx[i].ndesc)
+			continue;
+
+		airoha_qdma_cleanup_tx_queue(&qdma->q_tx[i]);
+		netdev_tx_reset_subqueue(dev, i);
+	}
+
 	return 0;
 }
 

---
base-commit: e60fa8ebc2af54c2f62cc4ed63b85894dabf9101
change-id: 20241017-airoha-en7581-reset-bql-45e4bd5c20d1

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


