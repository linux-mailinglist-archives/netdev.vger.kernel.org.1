Return-Path: <netdev+bounces-264750-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPo7K3q4qmlpVwEAu9opvQ
	(envelope-from <netdev+bounces-264750-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 12:20:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1736E21F932
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 12:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FDC43066BE4
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 11:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9236C3346BE;
	Fri,  6 Mar 2026 11:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rst00Bfr"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010006.outbound.protection.outlook.com [52.101.85.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4837731D759;
	Fri,  6 Mar 2026 11:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772795883; cv=fail; b=L7eM4o0yMrh2HtDPeuMaw157Yhpz5BdMAzASwU7i2rk1co75eg9lOKCOCNqRt6cOwTrGyzNZFMUebMXHHM5jAYLCGtzxdvii1B1Jz5OhlyUfbuO0bWyyq6L6YJECUyjgmlht6arqiN0+Yr7yTDjaN77MMkpmVv2s1zR3ZG03L0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772795883; c=relaxed/simple;
	bh=qSfUsDMo8JpCxKziltQAlWHhb7k7cGqxsMLZlh3lKJM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EW4z42mGa1XA68VjrCW0Qnu36JFkyh7fhJdxzHE9CVzrCE45YKyp3aPYFsQZ9gADpNDSRDYD3+vYdcg/asdiElxm/3ZQiC07v29ZJ+pLJxUL4tsKJes2ZfTXE8oYALYQHf8PKyPbvT3dbr9kgGQ1NIeqyzh5Z+GpYXfq2Pj7CVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rst00Bfr; arc=fail smtp.client-ip=52.101.85.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=btWzKDA6BjWv91s9anbdyh157yfsdMmeay7TOlYgLU0GNpb4FflFwz2MEkrJTkN4PX7d71rZk/8e9bytS/IKOst0AFu9scK5WBiya7DteVxCDKpycw+QuZ9oMA8p9cwfQ6zkhKyIbgeGAFHAuxg2ocuFu6Q6+r6fhD9bkPYvlRz4Bb0xJoy183zrphku5wUv5w4lYqZD14YOvXTyILDfEv7IXTBwucMAcwTc2adAPkuxavN7N1fUddwR/CLwwvWtdSSgt+F1EzWIWB+sBmM7dHzwz9LAqTTiQo7GZmmojbjdyqLckJ0gJlPEurySTsiSsg0cEXKnqvL0By75aWrDlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IqVujmplh7LsE2d+i8nz0F2SRcxC8SHCDhJ3a2wPUTE=;
 b=JZZTI2ZxO60+91PTjbpQ0LE0PY1kw+L6Xh+MYtdKu4M1nfm2+GKEJ0U2FaVi5udRLgkb3WDAm2yry77bV1C0oGaePJF0O0BoQjLh584QJl6aO1rKqbkgeiv5+mhEE6RMs5R39KV5xkqxGEdmn5hhyjfl8+7+gKiItEY+GExIzlcbElEAhfIje0ZwI0IMJUrYgrVx9z0+m+kx+zRYb0T+JYc/bQdD1z6ZrxiFuosU9++OhJtJD/bOsdoKfLuLvVHNSjVrrphd3e4807qPY1OIutvVw287CQ7IxXZSy1vRz2D5sU52ffZEsBGUxmGKzqIgX/z8NDRrfIypmcobjJk1sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IqVujmplh7LsE2d+i8nz0F2SRcxC8SHCDhJ3a2wPUTE=;
 b=rst00BfroAEFEXInJhjZ0MwG2P+o1plFvElPAuULfsGqWW0V3ojFHbzZYd+sRMr/1pp+leWy3pBT6euKUBGS0yIf51MMUjvKwPDm6DevEvrwUUx4xmhMjg6gPg+3Fxzz7IojSkQj5R28ITsMrO47EVcDW8ssHT2rPYGFpaZfGgg=
Received: from DS7PR05CA0031.namprd05.prod.outlook.com (2603:10b6:8:2f::6) by
 CH0PR12MB8549.namprd12.prod.outlook.com (2603:10b6:610:182::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 11:17:59 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:8:2f:cafe::e7) by DS7PR05CA0031.outlook.office365.com
 (2603:10b6:8:2f::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18 via Frontend Transport; Fri,
 6 Mar 2026 11:17:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 11:17:58 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 05:17:55 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<horms@kernel.org>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH v3 net 3/3] amd-xgbe: reset PHY settings before starting PHY
Date: Fri, 6 Mar 2026 16:46:29 +0530
Message-ID: <20260306111629.1515676-4-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260306111629.1515676-1-Raju.Rangoju@amd.com>
References: <20260306111629.1515676-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|CH0PR12MB8549:EE_
X-MS-Office365-Filtering-Correlation-Id: 64e3a649-588a-44aa-3bcc-08de7b7205d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016;
X-Microsoft-Antispam-Message-Info:
	oP7KBJieRz4FPawG6SCNH72f/fcXI1wPmqNkfOoDhj4rqZ+A8hJimms4DH2c+hy9I4TbPXev3Nep52EMu2nRKQBT+W5Z9iTBXQGu41XXcMtOfXsnBF5x7qDx6ykQ1x+gWExZ0xxSEOr3VBNeJeSXJQ0ndefQ4HjSDSQtU2rimVRH+jOOej9s0p2ZOM/UQcio+X0TTN+wzuEeBaGXUX3sGL6rujVGZFVS7xslyaIqiYdaHoMJhZk6tXuvBiOo0UiNypYtvZha0Dx14spDqUZb3cVZU74PP+NqcptzvNBkOu2qsVVBQZ0I+SPnUVzGQA3uHdvPhvC02cHBLylx/wzIaPHGWImon0DD1jJwdPyNpaSviGQn4XFqOMPCBHHAG0V3IBnxDsZ50X6XIxzMzyhZZt/NefrrcBtVxY9IWbHqj0BL/aai2R8S86yZQO44MQVzJ8En/cZmerakQXZqnclOiTPywaCWSKf4ACbrGUikIxoKVtR15TNpGODnXzqbPOeAPApS7Dtu8nU2XrfVYg0ws6IDK/hHsCdoTSwqReSEAgYIuf/qsDdQVNnUwBnwPAXyGnX2iBw6CuiiYKKhThnWGzX5Ne6XqlaoSLvwHR/1Lt3/9rBubosSsMZUKM3iqhCovVCoX+YB/JkRROfNKG+2zkoSl4vwFik734HW2VLqrn+hffkK79qyuGAoJf9hHf9fZKwikp/LY+CBeV9TOtqicYQjHqu+7qSjzeB40jfIwtSRw4l1Claa3s+GAIlbFIRYLkSgR8yukDJtm+AcyJlF5A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	me726gLVOxp+JN7bnOk+mTV7aOWotEb460gYbpVe5rDHrCJNBIHvAorHn7AIWiaEvFa3fO1CmZQFotygu85F/z2q7D2tG8IPx1CNJ5kEb+Rc/dvc03oVNWtL/uLxws+L4/PRcVchIOIehRxPJ6lUCtFeRhrJcfd7HLnD8YNwju97U1WPo7WSlLl9Sud0UKAiszXIcySEBZtCtfeTijqGVSXppVmC2BxrhqSk0azr8/2mrpMl0Vh3zUu9XEckyl526P8MtZhhVT/mZFWW366N1rbq5u7w/9XLWlFFBG8dum/KMwnWblKnmurY2wAepmeoKatedlIQ82IPbTUd9IWd+Bwd3ZbpVI1h5mPVfMkSKjNAcngU4zG9UGS9S7bnQSxmAypPAxClmiFNbop7MXPIz8b4QVja78dXMe+FE0myF/DPIWo4bQXC3afTeKy39Th3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 11:17:58.6619
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64e3a649-588a-44aa-3bcc-08de7b7205d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8549
X-Rspamd-Queue-Id: 1736E21F932
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264750-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:email,amd.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bootlin.com:email];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Raju.Rangoju@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

commit f93505f35745 ("amd-xgbe: let the MAC manage PHY PM") moved
xgbe_phy_reset() from xgbe_open() to xgbe_start(), placing it after
phy_start(). As a result, the PHY settings were being reset after the
PHY had already started.

Reorder the calls so that the PHY settings are reset before
phy_start() is invoked.

Fixes: f93505f35745 ("amd-xgbe: let the MAC manage PHY PM")
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
index 39da2f811858..23beea48ae26 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -1271,6 +1271,12 @@ static int xgbe_start(struct xgbe_prv_data *pdata)
 	if (ret)
 		goto err_napi;
 
+	/* Reset the phy settings */
+	ret = xgbe_phy_reset(pdata);
+	if (ret)
+		goto err_irqs;
+
+	/* Start the phy */
 	ret = phy_if->phy_start(pdata);
 	if (ret)
 		goto err_irqs;
@@ -1284,11 +1290,6 @@ static int xgbe_start(struct xgbe_prv_data *pdata)
 
 	udp_tunnel_nic_reset_ntf(netdev);
 
-	/* Reset the phy settings */
-	ret = xgbe_phy_reset(pdata);
-	if (ret)
-		goto err_txrx;
-
 	netif_tx_start_all_queues(netdev);
 
 	xgbe_start_timers(pdata);
@@ -1298,10 +1299,6 @@ static int xgbe_start(struct xgbe_prv_data *pdata)
 
 	return 0;
 
-err_txrx:
-	hw_if->disable_rx(pdata);
-	hw_if->disable_tx(pdata);
-
 err_irqs:
 	xgbe_free_irqs(pdata);
 
-- 
2.34.1


