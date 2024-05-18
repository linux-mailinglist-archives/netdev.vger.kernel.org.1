Return-Path: <netdev+bounces-97093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E7D8C910E
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 14:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 930F9281D01
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 12:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BDF535D0;
	Sat, 18 May 2024 12:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EXKhI5PA"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BEC4E1B3;
	Sat, 18 May 2024 12:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716036273; cv=none; b=ibQ5MfKvZZ5WWPh51rUCWGsfi4sbUSnGaZkeZHmLOSgL6J5ePSsaVqCFykAl9bk7YgcpZvDC1z5yDHUpOIAi83Bp29UEQLkvuv7QyWvzuTGbz0AwtgUSt6CUwFdEj5k0sAD1xsPfRABgyuybr4p8gBjBHez4p/mm7JeB91a8KkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716036273; c=relaxed/simple;
	bh=rPAEvAm+p/u2nLjjrVskxSKkBnJOn5mvraIDQIwPdNk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mb8qtEL9m+WshATSzmNQKFkxZWUddEhXV1m3u9vA6JzpDkxSc9bAhb6S3ifHJsnzUkuvnAZc8bY7AKsiqvO8koE2+ncunppKCVaSzIg+JW1OM/tGW0F5AmjVEVNd2Zxx2QPgNLGqGkYHUkwdnN4nh858xvf8dKAmP1rXWdEotIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=EXKhI5PA; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44ICi6ud002848;
	Sat, 18 May 2024 07:44:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716036246;
	bh=MNJFVc6G40L2FZxmk2pnAhflXSN9ugTwXZFFV792Umg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=EXKhI5PA+wgkTcwJxwjHmG4ovXaf5ApqyP9176P/w5RARIJwVsQe01bT/n3jFStn+
	 Cq+Q4i12OdYKaJfH5ZX5cKS3OmvPTdiDUHEWsVqOQI9iNpPHVpMWF2qEBvnwKGMq+n
	 n7d8Fm4Bc/BII7njX22HcNmCAKZEiUgqdL2/+BPI=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44ICi6Jp051768
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 18 May 2024 07:44:06 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 18
 May 2024 07:44:06 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 18 May 2024 07:44:06 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44ICgY9Z041511;
	Sat, 18 May 2024 07:44:02 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <corbet@lwn.net>, <rogerq@kernel.org>,
        <danishanwar@ti.com>, <vladimir.oltean@nxp.com>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <vigneshr@ti.com>, <misael.lopez@ti.com>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [RFC PATCH net-next 19/28] net: ethernet: ti: cpsw-proxy-client: implement and register ndo_get_stats64
Date: Sat, 18 May 2024 18:12:25 +0530
Message-ID: <20240518124234.2671651-20-s-vadapalli@ti.com>
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

Add the function "vport_ndo_get_stats()" and register it as the driver's
.ndo_get_stats64 callback.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/net/ethernet/ti/cpsw-proxy-client.c | 35 +++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/net/ethernet/ti/cpsw-proxy-client.c b/drivers/net/ethernet/ti/cpsw-proxy-client.c
index 7cbe1d4b5112..6886557aa2a1 100644
--- a/drivers/net/ethernet/ti/cpsw-proxy-client.c
+++ b/drivers/net/ethernet/ti/cpsw-proxy-client.c
@@ -1562,10 +1562,45 @@ static netdev_tx_t vport_ndo_xmit(struct sk_buff *skb, struct net_device *ndev)
 	return NETDEV_TX_BUSY;
 }
 
+static void vport_ndo_get_stats(struct net_device *ndev,
+				struct rtnl_link_stats64 *stats)
+{
+	struct vport_netdev_priv *ndev_priv = netdev_priv(ndev);
+	unsigned int start;
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		struct vport_netdev_stats *cpu_stats;
+		u64 rx_packets;
+		u64 rx_bytes;
+		u64 tx_packets;
+		u64 tx_bytes;
+
+		cpu_stats = per_cpu_ptr(ndev_priv->stats, cpu);
+		do {
+			start = u64_stats_fetch_begin(&cpu_stats->syncp);
+			rx_packets = cpu_stats->rx_packets;
+			rx_bytes   = cpu_stats->rx_bytes;
+			tx_packets = cpu_stats->tx_packets;
+			tx_bytes   = cpu_stats->tx_bytes;
+		} while (u64_stats_fetch_retry(&cpu_stats->syncp, start));
+
+		stats->rx_packets += rx_packets;
+		stats->rx_bytes   += rx_bytes;
+		stats->tx_packets += tx_packets;
+		stats->tx_bytes   += tx_bytes;
+	}
+
+	stats->rx_errors	= ndev->stats.rx_errors;
+	stats->rx_dropped	= ndev->stats.rx_dropped;
+	stats->tx_dropped	= ndev->stats.tx_dropped;
+}
+
 static const struct net_device_ops cpsw_proxy_client_netdev_ops = {
 	.ndo_open		= vport_ndo_open,
 	.ndo_stop		= vport_ndo_stop,
 	.ndo_start_xmit		= vport_ndo_xmit,
+	.ndo_get_stats64	= vport_ndo_get_stats,
 };
 
 static int init_netdev(struct cpsw_proxy_priv *proxy_priv, struct virtual_port *vport)
-- 
2.40.1


