Return-Path: <netdev+bounces-120040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8932B958015
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 09:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A7AF284504
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 07:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2291891D4;
	Tue, 20 Aug 2024 07:43:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB2C188CD6;
	Tue, 20 Aug 2024 07:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724139809; cv=none; b=ZdvnVEYaDSQRZx7tgnhSFPjdfEy2KN+5FHh8IZtyUNW0+Tb2MF6aeFazLgJ1D5RVUPMyNr3A1wXkPlASmDR+Z1XQR6pne8pY7ii1VzPFX6JiroIg5cfUK4Ofl6deu4U2HqyY0ZknN1a6Kq7cuBTc3julRn+MEWPEY095/4hzHZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724139809; c=relaxed/simple;
	bh=DD7t9Jzpn69rjGQAuYkyUIUSeMJEFzjdT/+EV50HyY4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dDUgxCpiqg5yjE+aJVwy8Z4Ez83NnDWu8kH9FqX6VUTrQTV5kzHDZ5E+dcBDb04b5EWUFO96nPIvbCHi9D08VreUa6uP3xAyjz0jC5lvzicztyezYC/xSwLkSO7ROmUFRknLeHMDIIGYrWEoJNmGw9Y6dmUy+j/HDlxs9jTlsZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wp1YK1sHQz20lsS;
	Tue, 20 Aug 2024 15:38:45 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id A7D0214035E;
	Tue, 20 Aug 2024 15:43:25 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 20 Aug
 2024 15:43:25 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <olteanv@gmail.com>, <andrew@lunn.ch>, <f.fainelli@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next] net: dsa: sja1105: Simplify with scoped for each OF child loop
Date: Tue, 20 Aug 2024 15:50:47 +0800
Message-ID: <20240820075047.681223-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Use scoped for_each_available_child_of_node_scoped() when iterating over
device nodes to make code a bit simpler.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/net/dsa/sja1105/sja1105_main.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index c7282ce3d11c..bc7e50dcb57c 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -1188,9 +1188,8 @@ static int sja1105_parse_ports_node(struct sja1105_private *priv,
 				    struct device_node *ports_node)
 {
 	struct device *dev = &priv->spidev->dev;
-	struct device_node *child;
 
-	for_each_available_child_of_node(ports_node, child) {
+	for_each_available_child_of_node_scoped(ports_node, child) {
 		struct device_node *phy_node;
 		phy_interface_t phy_mode;
 		u32 index;
@@ -1200,7 +1199,6 @@ static int sja1105_parse_ports_node(struct sja1105_private *priv,
 		if (of_property_read_u32(child, "reg", &index) < 0) {
 			dev_err(dev, "Port number not defined in device tree "
 				"(property \"reg\")\n");
-			of_node_put(child);
 			return -ENODEV;
 		}
 
@@ -1210,7 +1208,6 @@ static int sja1105_parse_ports_node(struct sja1105_private *priv,
 			dev_err(dev, "Failed to read phy-mode or "
 				"phy-interface-type property for port %d\n",
 				index);
-			of_node_put(child);
 			return -ENODEV;
 		}
 
@@ -1219,7 +1216,6 @@ static int sja1105_parse_ports_node(struct sja1105_private *priv,
 			if (!of_phy_is_fixed_link(child)) {
 				dev_err(dev, "phy-handle or fixed-link "
 					"properties missing!\n");
-				of_node_put(child);
 				return -ENODEV;
 			}
 			/* phy-handle is missing, but fixed-link isn't.
@@ -1233,10 +1229,8 @@ static int sja1105_parse_ports_node(struct sja1105_private *priv,
 		priv->phy_mode[index] = phy_mode;
 
 		err = sja1105_parse_rgmii_delays(priv, index, child);
-		if (err) {
-			of_node_put(child);
+		if (err)
 			return err;
-		}
 	}
 
 	return 0;
-- 
2.34.1


