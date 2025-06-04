Return-Path: <netdev+bounces-195074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE22AACDC92
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 13:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 323041896091
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 11:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE6528BABD;
	Wed,  4 Jun 2025 11:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=technica-engineering.de header.i=@technica-engineering.de header.b="K6nhfckI"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023100.outbound.protection.outlook.com [52.101.72.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE022B9BC;
	Wed,  4 Jun 2025 11:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749036742; cv=fail; b=SaDvMDi6Uqo6feTQtfOHJAHfyVjrNKSWbUVcG2Qf5p4m8FYmTCP07HOgYIDI76t0il/7YN/qBLVNl9vntS87yeKmYp8O/xyyH7EMvwQFYQ6tSWnuG5L4MB001hYI7rq38ey4df5wXIsBb4BAtsbpzbxGy+CXrEKjahy1hTeyRWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749036742; c=relaxed/simple;
	bh=bg15VbVKtuzjICnx+yZvTg3dZWLkW3lAxmTaai7wm2k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YyIz5Z5trzZXkr5d22FkoYZyL1HNKjvxZawqlAjhvLiVoztoMuyXAzmQNDOg/mlUWt/w9J0zS/8XgcD1FV2C8rG88jTn3s0cmavxd0Xo4GUhBO2tsIrzDD1bAEo5G7e1s/EfHNg+yXIJmMyhuIzKZoEntHRngdhij+l6exsLYuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=technica-engineering.de; spf=pass smtp.mailfrom=technica-engineering.de; dkim=pass (1024-bit key) header.d=technica-engineering.de header.i=@technica-engineering.de header.b=K6nhfckI; arc=fail smtp.client-ip=52.101.72.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=technica-engineering.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=technica-engineering.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vg04+uX+RlktiGD+CGVRd1QqzteN4MxGNcRLBKFn8r6fqeU5nlAzZmNMzBsiuFlo42LkQYTVvaopBQxYwX1h9mJWh1qc6H+beRKEDqWOU2FG6BPGePJIldjaxNc0kkO+KOV01QfhqOkhA+4BMGr0tyfJ7hlX3RjRtdsiMLVkrF83PiSmelgsYcUi5d/Zi+1MmicvXqfyKqBHwNfDPIDIdJLlbdJVwFlg9jaySYGqrWTY95y7u6ueHd+TpyaXdJg56pWTYMMiGHFsvr/m5bHl0rnNrPkgQvmzwpbw1B4Bdr61XEdUAxyjxNEALFYrFu1qAS9SyFPtxFLTWH+XTojHpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xw/ZrDam5/WptiSh5/ySaIjudcnbebypODmVzipU+e8=;
 b=nVFxeLBsyXCdft7AbQeLi/0NyvuLLTisgdMy7PM+IjspRq/9UQMrLGNyO8iWXtbql64CkUwCv3h0YXqui3XukmXp2FJ84N8TAWPdPiPRSpWuBwSHSW8E/p0lZM6U0TWujm+JqCnjF2hbKUYl1lEUBWjWM2HqpIIYrFp+9Dg7WfoOo8FJ5dGvl59LWDqgWVjGAzMJ3AMefShP5GmMS7WMhKs+0gw9XURkoeBreLvIFtudc7wYZ9CaIvy7xNAqHsxYT7KXTQ18FtXxCRP/HZAvXrPc+fGPPgHT7kZbVeethpXLyVl/2dpBWR0ZdtuKQMZGyAeAOtg9BLLMxcawnV8NvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 2.136.200.136) smtp.rcpttodomain=davemloft.net
 smtp.mailfrom=technica-engineering.de; dmarc=fail (p=reject sp=reject
 pct=100) action=oreject header.from=technica-engineering.de; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=technica-engineering.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xw/ZrDam5/WptiSh5/ySaIjudcnbebypODmVzipU+e8=;
 b=K6nhfckIi5vIjWCFk6ow3Q6JrChI2oG1FDFiddpMDVGWJmeiMDYc8TuAnSaaXzntKQPvjUOQkRl1KC8Mq9t65UmnucUWenVby4Ugro7+/y27za4qpsQNNINBw5i6GwiyVVpadUJJaIbaSia8e7NMS+/yzo+D4l8wtUfg3Zu3LM8=
Received: from AS9P250CA0018.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:532::21)
 by AS8PR08MB10142.eurprd08.prod.outlook.com (2603:10a6:20b:633::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Wed, 4 Jun
 2025 11:32:16 +0000
Received: from DU2PEPF00028CFE.eurprd03.prod.outlook.com
 (2603:10a6:20b:532:cafe::49) by AS9P250CA0018.outlook.office365.com
 (2603:10a6:20b:532::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.32 via Frontend Transport; Wed,
 4 Jun 2025 11:32:16 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 2.136.200.136)
 smtp.mailfrom=technica-engineering.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=technica-engineering.de;
Received-SPF: Fail (protection.outlook.com: domain of technica-engineering.de
 does not designate 2.136.200.136 as permitted sender)
 receiver=protection.outlook.com; client-ip=2.136.200.136;
 helo=jump.ad.technica-electronics.es;
Received: from jump.ad.technica-electronics.es (2.136.200.136) by
 DU2PEPF00028CFE.mail.protection.outlook.com (10.167.242.182) with Microsoft
 SMTP Server id 15.20.8792.29 via Frontend Transport; Wed, 4 Jun 2025 11:32:15
 +0000
Received: from dalek.ad.technica-electronics.es (unknown [10.10.2.101])
	by jump.ad.technica-electronics.es (Postfix) with ESMTP id 55201402BC;
	Wed,  4 Jun 2025 13:32:15 +0200 (CEST)
From: carlos.fernandez@technica-engineering.de
To: andreu.montiel@technica-engineering.de
Cc: carlos.fernandez@technica-engineering.de,
	Andreu Montiel <Andreu.Montiel@technica-engineering.de>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Hannes Frederic Sowa <hannes@stressinduktion.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] macsec: MACsec SCI assignment for ES = 0
Date: Wed,  4 Jun 2025 13:31:54 +0200
Message-ID: <20250604113213.2595524-1-carlos.fernandez@technica-engineering.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028CFE:EE_|AS8PR08MB10142:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3c8f30d5-c72f-4964-9526-08dda35b7528
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RIT+85CA8oH7LJlUC3PuNNMvHOmxf7t5dS2jjMfn7sM++/hJAAMuR/L70DxI?=
 =?us-ascii?Q?RRcGxCT1SAVaihm9xLeN3mlxiFoln2JvPJR7rOmRkSTJNN+n4HevwghbLl1z?=
 =?us-ascii?Q?WSpRvI4psq0pd6mFLZnhxKhGcwd2e6ncOvTwxX3JS85ll2iQKPQTiWMqfFOB?=
 =?us-ascii?Q?MZEGBmkfF9RMm/JCH4bJAH4JBt+G10VXa1P9bJsIcFBB+NL/MTOy+hEOYMEg?=
 =?us-ascii?Q?CcnVh+tSqiDyKt6qs1SXYqYuBhJWdOyZbJBHeySTGkd2VTDRGqUXf4CSZTjx?=
 =?us-ascii?Q?UBfS+49Sw/NLa0z+Js9A7cy+QIMWM36sIsQS1xO7FlTW4H8wvj4oh/hGpGcl?=
 =?us-ascii?Q?hScAQOYYDKjticYIcRWw2BuLF/XvfcLN1B1H8Ca8aR6lx6pNrf6l9F3h4wuG?=
 =?us-ascii?Q?/2yNIRF0BfFFTxlNPJh/HmI8I4jIV0IzXUpCW+5jMH+LTP2ASoGiOZRaF5/+?=
 =?us-ascii?Q?MUT7lw1J9fsr35k7a7tWZiR69mzIAiek+x3s6gG7sruf0XulU6xHa0Lc5Q8q?=
 =?us-ascii?Q?iv1YyCeXGJRVDob0m2gCWK1wubpcgm70ihZJFt1rflRzX+rWfNgPbCVElgaZ?=
 =?us-ascii?Q?s5Rio36S3tRaoke3P+62zYgMVfDjOx29CQ+wJa+tNWM50GDXfdvMfYSdUH03?=
 =?us-ascii?Q?UVU4G/TVwgfDBfMfD8ldjLV6vI+U0u3iTVG0BO+zdmdVu4y6oXoEHGxOOY1d?=
 =?us-ascii?Q?vCyf3eWW50hmY+iRoh/cUGAvqs2GxywAMGk0IfIUSxuuTUxISFPHS3oGhMBU?=
 =?us-ascii?Q?629irfnrCk27tgI5Or+0wTJASKBcWMwq/l9l+J9p6FED+ftMU7Z64VqT4u+2?=
 =?us-ascii?Q?847PXUHLdt6IyYvJaPDti6EqPq+V1mlQRDD/drYGg9CoBYNN5wix0KuW58IX?=
 =?us-ascii?Q?APlrY4nDCyeWqtxJSG3LRQsorDkVZSNYB/oXnK8CFkw6EAmdrL186wJ8TQY7?=
 =?us-ascii?Q?yFXvETwD2cApdCCwJs8w/ix40cNivrnLXWHehwiEcWIzlJehOD6haOPPi8Qs?=
 =?us-ascii?Q?iIn8+vNxIUDelivOjmlLqFzDiLnB1Wq6nvMrDbf5cpM4fNWdHlT2pS81tqAj?=
 =?us-ascii?Q?Smc8g4Iww/DR5A+BHakOWO5+vG6e0SKPuiuZm1hVCK1qG/c1ePN4Zjtc8Lmn?=
 =?us-ascii?Q?lt9lnZ+gR46SYROgNh+1tyBV02bWlvvsma/zuo0q2WYqJksJgXhNCtIb6X6L?=
 =?us-ascii?Q?1tFszqI9XLKsKRYTRef3Xzbv760M/qWU9ejRh1soSRvbFYsM46y4CFgtyfGV?=
 =?us-ascii?Q?8+TjkPYlre9YqyWfNJfPY/ov6LDQfFO7JBhCmrvGOP/HzIe8kieWbsp9GNYu?=
 =?us-ascii?Q?ghE/1iAHWaaa3kl15vN0doUBoOCbFEB+W5C4Tq7CT2fMUyfVEV3ms4IlbmeR?=
 =?us-ascii?Q?JERbiE48poqQk9uyNRGyzzpOpDHwYcVkkU2p9YB/zjLIiHew74Ap+Bi0kWmA?=
 =?us-ascii?Q?MDJsayGz7isEJOwKdA/xix6VJ1TxDohmtpflWzkBH99atSWg0eB99rFN+8SM?=
 =?us-ascii?Q?GoYZwCeKmNbd1ZXJYYEzWlCuBu0etvZbXiH8OP5Wsk2g3rHR1Xx6NI12CQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:2.136.200.136;CTRY:ES;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:jump.ad.technica-electronics.es;PTR:136.red-2-136-200.staticip.rima-tde.net;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: technica-engineering.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 11:32:15.8124
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c8f30d5-c72f-4964-9526-08dda35b7528
X-MS-Exchange-CrossTenant-Id: 1f04372a-6892-44e3-8f58-03845e1a70c1
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1f04372a-6892-44e3-8f58-03845e1a70c1;Ip=[2.136.200.136];Helo=[jump.ad.technica-electronics.es]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028CFE.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10142

From: Carlos Fernandez <carlos.fernandez@technica-engineering.de>

According to 802.1AE standard, when ES and SC flags in TCI are zero,
used SCI should be the current active SC_RX. Current code uses the
header MAC address. Without this patch, when ES flag is 0 (using a
bridge or switch), header MAC will not fit the SCI and MACSec frames
will be discarted.

Fixes: c09440f7dcb3 ("macsec: introduce IEEE 802.1AE driver")

Co-developed-by: Andreu Montiel <Andreu.Montiel@technica-engineering.de>
Signed-off-by: Andreu Montiel <Andreu.Montiel@technica-engineering.de>
Signed-off-by: Carlos Fernandez <carlos.fernandez@technica-engineering.de>
---
v2: 
* Active sci lookup logic in a separate helper.
* Unnecessary loops avoided. 
* Check RXSC is exactly one for lower device.
* Drops frame in case of error.

v1: https://patchwork.kernel.org/project/netdevbpf/patch/20250529124455.2761783-1-carlos.fernandez@technica-engineering.de/#26409053

 drivers/net/macsec.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 3d315e30ee47..976927e715fd 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -247,15 +247,38 @@ static sci_t make_sci(const u8 *addr, __be16 port)
 	return sci;
 }
 
-static sci_t macsec_frame_sci(struct macsec_eth_header *hdr, bool sci_present)
+static sci_t macsec_active_sci(struct macsec_secy *secy)
 {
-	sci_t sci;
+	struct macsec_rx_sc *rx_sc = rcu_dereference_bh(secy->rx_sc);
+
+	/* Case single RX SC */
+	if (rx_sc && !rcu_dereference_bh(rx_sc->next))
+		return (rx_sc->active) ? rx_sc->sci : 0;
+	/* Case no RX SC or multiple */
+	else
+		return 0;
+}
+
+static sci_t macsec_frame_sci(struct macsec_eth_header *hdr, bool sci_present,
+			      struct macsec_rxh_data *rxd)
+{
+	struct macsec_dev *macsec;
+	sci_t sci = 0;
 
-	if (sci_present)
+	/* SC = 1 */
+	if (sci_present) {
 		memcpy(&sci, hdr->secure_channel_id,
 		       sizeof(hdr->secure_channel_id));
-	else
+	/* SC = 0; ES = 0 */
+	} else if ((!(hdr->tci_an & (MACSEC_TCI_ES | MACSEC_TCI_SC))) &&
+		   (list_is_singular(&rxd->secys))) {
+		/* Only one SECY should exist on this scenario */
+		macsec = list_first_or_null_rcu(&rxd->secys, struct macsec_dev, secys);
+		if (macsec)
+			return macsec_active_sci(&macsec->secy);
+	} else {
 		sci = make_sci(hdr->eth.h_source, MACSEC_PORT_ES);
+	}
 
 	return sci;
 }
@@ -1156,11 +1179,14 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 
 	macsec_skb_cb(skb)->has_sci = !!(hdr->tci_an & MACSEC_TCI_SC);
 	macsec_skb_cb(skb)->assoc_num = hdr->tci_an & MACSEC_AN_MASK;
-	sci = macsec_frame_sci(hdr, macsec_skb_cb(skb)->has_sci);
 
 	rcu_read_lock();
 	rxd = macsec_data_rcu(skb->dev);
 
+	sci = macsec_frame_sci(hdr, macsec_skb_cb(skb)->has_sci, rxd);
+	if (!sci)
+		goto drop;
+
 	list_for_each_entry_rcu(macsec, &rxd->secys, secys) {
 		struct macsec_rx_sc *sc = find_rx_sc(&macsec->secy, sci);
 
-- 
2.43.0


