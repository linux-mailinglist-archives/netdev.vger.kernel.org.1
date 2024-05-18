Return-Path: <netdev+bounces-97097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D89108C911B
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 14:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14FCB1C2144A
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 12:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9A477F10;
	Sat, 18 May 2024 12:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="c/XjHcJS"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0DE77108;
	Sat, 18 May 2024 12:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716036283; cv=none; b=kLL0KfiGviBrMQomZYu71+hR+ylflYPxvd+xcF6OVqkoC0yI1UWPiajYA+gZKVsdVqeHpbD4x8uzHxNYUNCHzB+1IWKyONqNN/YRfLn6/tjbvJ1sS3DbJtiOR6KzN9KE8pK/nJrhtUuqYalp471Nv8UniQgRtraqqeXhy6RvPsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716036283; c=relaxed/simple;
	bh=VLC56HNR23jTHjwxpkGsykAqr5GIFETK1IINEPmsABY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GtAYjjd8otQc9/Y/wX4JJdZCoGp1xBlwO1OP5Q4WEOKsjHNK2zOTw2nRtrfnT/qN00ntunfNXEQ5/pfOUCNSZgD/EUdh3hvpwDRPdFUi43diT64fG2/631z6fhjjmLTm8HHZM2CRD5/uxHQ/zYVarO1a9AdNZ/hNCHwbgMTV32Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=c/XjHcJS; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44IChvhJ055020;
	Sat, 18 May 2024 07:43:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716036237;
	bh=hJFQNo2lpYUFCMV7UOYccAwKmzAIdF5qSN5A6Wrlods=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=c/XjHcJS0R5fwjSfuZHMpxmVko6CwH0yaiOQOvIlB5oxLKvbh+xtXN4WqQH/t4nmJ
	 h2uuy+Mo4jnUr9zXseNAGmV6Ht4yyrr2Ou+XcJfYvZUz037SkC45rm4GlYv/W8tmTG
	 BZue67Zu2k4UYZkCFe9icMzUpm471OviKO32HdI8=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44IChviD051598
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 18 May 2024 07:43:57 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 18
 May 2024 07:43:57 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 18 May 2024 07:43:57 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44ICgY9X041511;
	Sat, 18 May 2024 07:43:53 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <corbet@lwn.net>, <rogerq@kernel.org>,
        <danishanwar@ti.com>, <vladimir.oltean@nxp.com>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <vigneshr@ti.com>, <misael.lopez@ti.com>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [RFC PATCH net-next 17/28] net: ethernet: ti: cpsw-proxy-client: implement and register ndo_stop
Date: Sat, 18 May 2024 18:12:23 +0530
Message-ID: <20240518124234.2671651-18-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240518124234.2671651-1-s-vadapalli@ti.com>
References: <20240518124234.2671651-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add the function "vport_ndo_stop()" and register it as the driver's
.ndo_stop callback.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/net/ethernet/ti/cpsw-proxy-client.c | 23 +++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/net/ethernet/ti/cpsw-proxy-client.c b/drivers/net/ethernet/ti/cpsw-proxy-client.c
index e643ffb9455a..646eab90832c 100644
--- a/drivers/net/ethernet/ti/cpsw-proxy-client.c
+++ b/drivers/net/ethernet/ti/cpsw-proxy-client.c
@@ -1354,6 +1354,28 @@ static int vport_open(struct virtual_port *vport, netdev_features_t features)
 	return 0;
 }
 
+static int vport_ndo_stop(struct net_device *ndev)
+{
+	struct virtual_port *vport = vport_ndev_to_vport(ndev);
+	struct cpsw_proxy_priv *proxy_priv = vport->proxy_priv;
+	int ret;
+
+	netif_tx_stop_all_queues(ndev);
+	netif_carrier_off(ndev);
+
+	ret = deregister_mac(vport);
+	if (ret)
+		netdev_err(ndev, "failed to deregister MAC for port %u\n",
+			   vport->port_id);
+
+	vport_stop(vport);
+
+	dev_info(proxy_priv->dev, "stopped port %u on interface %s\n",
+		 vport->port_id, ndev->name);
+
+	return 0;
+}
+
 static int vport_ndo_open(struct net_device *ndev)
 {
 	struct virtual_port *vport = vport_ndev_to_vport(ndev);
@@ -1391,6 +1413,7 @@ static int vport_ndo_open(struct net_device *ndev)
 
 static const struct net_device_ops cpsw_proxy_client_netdev_ops = {
 	.ndo_open		= vport_ndo_open,
+	.ndo_stop		= vport_ndo_stop,
 };
 
 static int init_netdev(struct cpsw_proxy_priv *proxy_priv, struct virtual_port *vport)
-- 
2.40.1


