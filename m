Return-Path: <netdev+bounces-297550-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gdoeJXwoKWrlRgMAu9opvQ
	(envelope-from <netdev+bounces-297550-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 11:03:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F0366797F
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 11:03:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=renesas.com header.s=selector1 header.b=YW0zGLiA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297550-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297550-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=renesas.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4EFC233A695C
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316973B83E8;
	Wed, 10 Jun 2026 08:53:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011016.outbound.protection.outlook.com [40.107.74.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099163D88F5;
	Wed, 10 Jun 2026 08:52:58 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781081581; cv=fail; b=UKuAPeo6DIcaByexqBsryLm5mbajEcjm8hAOpr25QvuxlGS0Hpuu+lnT2pY635VWeQMiR0oiDHosKB/OXZPGKMM+LBtJ2T66sPA9+HfJtnfhB6UoBYUdL8YkrnTL1jsSSSPpklPUe95zb4PlzCjlhxzm6pODahT8U9QvhkzBkZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781081581; c=relaxed/simple;
	bh=GdfcgpcPNYQiJG73aAe4+cVne284kKIT6OezV2CFqh4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fqFOt7Gk+UV6KZrZ3tSoh3Xe3VDEdSNamQwoIUw+iJaHPpQvVSA20KkwjgiFsUKvvuyR8Aa25X4YrVTtp72kR6eQ0yDSOUSpPyy3OOnQS3MikNdcm64s3zCdn/FxZ0BXazm7PwSvXansVQq18TVlmMjijYyfaOum8qXyVSLVQ+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=YW0zGLiA; arc=fail smtp.client-ip=40.107.74.16
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SdK5EBqcv1278CvLfzi/ut0GnBGaoAnkF7lDoQwm7NJNVe9vlA1eGchgiKrMT4weeZz5aTvPwLe78Ng4pQkd+BRgNkv4dqxhlS+uPRwZXQHcmKhB2P0CsUiPMTGBOIKF7myDWQIkXU/MXPk9w7bjeXdctR72lZoqT+5gF1Bwxdx+uczHyK1bY2R0t4hyPxStnUuGiKNQk1aH25hP+lRsVGGRZk1EY6KH37fRGD2CYzBuTzF9SlO07oIbKC/JGBu0eH+3Ziue1PJ7MCYZSfIMbipfmS+iODVCQvMhGDAYLHK3Xxo5mDzLNTQWSmBtUZdl+R5NcqvPMbmyF6uNSx74RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DP7auBkOw3pQU1KiPsBJD8YJIe7KMUBYc4w1ZpoI/jI=;
 b=qXMdmsE60FHUMoxIie2N2xMxEtmlAVkRrzXy0qEawCJVvf/zkBbKsChJfxM20ZcFp0aNRXIFyq8IrjJSk+mFDakf4HYKb/ndCY17G8VFBDpo9gil5oDUI1ygEkSuSXZaH/AcqZoPZguAVRBHlW3FJLGE27zGHl1RICCZ/NHVVi1oYA3Dc3EfObllmJtLheFb0yI/HYpSNpBUziDRrktIYqdun+UFfX0broqBnQUCD8ifbmyrrIyFGyendc0RUhfWUK3xL+qts3UuOs97i1a1Gpwot9XM3wDgYnIMqjwcgINitkNXmILLNLJZY8TQH+bM9NJ7opItKrY2LwzDVX3VsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=broadcom.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DP7auBkOw3pQU1KiPsBJD8YJIe7KMUBYc4w1ZpoI/jI=;
 b=YW0zGLiACAdPvVx37BccmLOqwYKnCLqXviDg0wxIEg+s0DpDzLSWi7MvcosfMNv0Nn624W6+zKsiXW1fvHLus11DDir/XOFZ47Ns/hq2vp1Or7yncZTB5FEzc2MPBAILEZkaiWyovZmUuRF9/+4Uw5NR2ZwLaKlY578u2JqbnkI=
Received: from TY4PR01CA0077.jpnprd01.prod.outlook.com (2603:1096:405:36c::6)
 by TY7PR01MB17051.jpnprd01.prod.outlook.com (2603:1096:405:327::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 08:52:55 +0000
Received: from TYO1EPF00005022.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36c:cafe::1a) by TY4PR01CA0077.outlook.office365.com
 (2603:1096:405:36c::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Wed,
 10 Jun 2026 08:52:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005022.mail.protection.outlook.com (10.167.240.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.7
 via Frontend Transport; Wed, 10 Jun 2026 08:52:55 +0000
Received: from vm01.adwin.renesas.com (DEU-5CG20946WF.adwin.renesas.com [10.226.92.207])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 93FDA300EECF;
	Wed, 10 Jun 2026 17:52:51 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: opendmb@gmail.com,
	florian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Subject: [PATCH net] net: bcmgenet: Use weighted round-robin TX DMA arbitration
Date: Wed, 10 Jun 2026 08:52:38 +0000
Message-ID: <20260610085238.56300-1-ovidiu.panait.rb@renesas.com>
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
X-MS-TrafficTypeDiagnostic: TYO1EPF00005022:EE_|TY7PR01MB17051:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2afeffa3-7a13-4e75-76e7-08dec6cda9b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|36860700016|82310400026|7416014|376014|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	MR3yjT44B/Hs03P9wQIGlBi+0jXCRi49GXuJ1raxAeuijvHk4TAGBlGL0721iwFwOLvGyR+9bZea2EhV1DBpXDEpgh+so2SKDSLxOoUrCXM2768+ezDcey27HkFCboZQehV3BOI2bZlFz46UoXTgMGBlxEDYKz/TWhnAvjT+k75MJ+hffwHu7tro+F+UUrFU8zYt1msRZpOeNfvE/9oEzhnyLKMbDoaSmG9gQW8NCQisKGvkudd4TaRp7dLlB+FbSmTzXY2r77f4StFaFFw/XheWzWV1Z1z22eEuLVLUYko2fKHBmxpJ/ODgJN57GuQoDR/gZwsHKb4FP2jEo8BpV8E023qV/t4JvxQYqNa4i2mcFgigxMc8d2+TkM14RSw8nuwVC26/U4y8wWiMpo/k5SeXR68bN048YM0Pv8l2ETl3RWIPk7H8HIy6dEO1QTrH9txOby0op3N7jCbe3j9VoIsixB8JDCQIJXdXb/7eg0tMXvml1Lffuu3zvOff94VBVBap+PgM4xuoOPnZp0uvlCiOsNCY29Jc+IDeRR4gpw1ccwUWoBV0EVaSBMBQ5XrejVwzR1hmN2NBwGnVEwbFPyvRUJqKd0V/NaxFbKFy3keGxslFArbSshHLSSeTTDHFSI8SQjmoRT3A9v67UvRzEwyg39SxRZZNPELVQoeZ68tKsDL2QChWK609GiycJwEu7qdaVNcEBW8CXDgQS0uxQFef5FqCz5Nf1BNbgNCBEfw=
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(36860700016)(82310400026)(7416014)(376014)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	G+mUqyxlcZM/rmO9QXDFVpN7+3gw7DJXuTp8wKRfLZmD6mb2uCy2LHq6IJYbMQOiWXZOWdBDMvm+DpjF0FxmNXHQ8HfSOH4K9kZG/EZo3kAPwekAlHE0NYImOojf5ubJc5pZtN+A0d39L6RpfJOYt++9PAhr42dJ71eUpah7R6FVr56lVXmGMLkb1iRr/w7sM5mth/Psl+EVPYYYCrdVGXXAs3rD4b11yBffis3ZM5yyAzjW9BZ3A8iK5TAPvWFDCaUJRUMSFk5ye6Z/KTJv4VpPUdABp+cJer/fbBcqOuo78iRniGN5v2R40dwyLxO0JE1ot4g/c+Phg9vEMeeacYMfcTo+TdvjVWegfQ0gsEQP6ZBMJitvUHXi/otNBk15iUveubIaJHECJ0AQ7Hn24f1qvKcTWLyDFxBBfpIh7eFldQ8kbNu5CLQsUPedc/Vu
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 08:52:55.0193
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2afeffa3-7a13-4e75-76e7-08dec6cda9b0
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005022.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB17051
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[renesas.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[ovidiu.panait.rb@renesas.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-297550-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:opendmb@gmail.com,m:florian.fainelli@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ovidiu.panait.rb@renesas.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ovidiu.panait.rb@renesas.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[renesas.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E3F0366797F

Under heavy network traffic, we observed sporadic TX queue timeouts on the
Raspberry Pi 4. The timeouts can be reproduced by stress testing the TX
path with multiple concurrent iperf UDP streams:

    iperf3 -c <ip> -u -b0 -P16 -t60
    NETDEV WATCHDOG: CPU: 0: transmit queue 0 timed out 2044 ms
    NETDEV WATCHDOG: CPU: 3: transmit queue 0 timed out 2004 ms

Investigation showed that the timeouts are caused by the priority-based
arbiter. Under heavy load the highest priority queue starves the lower
priority ones, causing timeouts. The TX strict priority arbiter is not
suitable for the default use case where all the traffic gets spread
across all the TX queues.

Therefore, to fix this, switch the TX DMA arbiter to Weighted Round-Robin,
which services all queues, so they do not stall. The weights were chosen
to follow the existing priority scheme: q0 gets the smallest weight, while
q1-4 get the bulk of the TX bandwidth.

Fixes: 1c1008c793fa ("net: bcmgenet: add main driver file")
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 .../net/ethernet/broadcom/genet/bcmgenet.c    | 23 +++++++------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 7c11cf916762..ad08c67269be 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -40,9 +40,8 @@
 
 #include "bcmgenet.h"
 
-/* Default highest priority queue for multi queue support */
-#define GENET_Q1_PRIORITY	0
-#define GENET_Q0_PRIORITY	1
+#define GENET_Q0_WEIGHT		1
+#define GENET_Q1_WEIGHT		4
 
 #define GENET_Q0_RX_BD_CNT	\
 	(TOTAL_DESC - priv->hw_params->rx_queues * priv->hw_params->rx_bds_per_q)
@@ -2129,13 +2128,6 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
 	int i;
 
 	index = skb_get_queue_mapping(skb);
-	/* Mapping strategy:
-	 * queue_mapping = 0, unclassified, packet xmited through ring 0
-	 * queue_mapping = 1, goes to ring 1. (highest priority queue)
-	 * queue_mapping = 2, goes to ring 2.
-	 * queue_mapping = 3, goes to ring 3.
-	 * queue_mapping = 4, goes to ring 4.
-	 */
 	ring = &priv->tx_rings[index];
 	txq = netdev_get_tx_queue(dev, index);
 
@@ -2881,8 +2873,9 @@ static int bcmgenet_rdma_disable(struct bcmgenet_priv *priv)
 
 /* Initialize Tx queues
  *
- * Queues 1-4 are priority-based, each one has 32 descriptors,
- * with queue 1 being the highest priority queue.
+ * Queues 1-4 are the priority queues, each one has 32 descriptors.
+ * The weighted round-robin arbiter gives them a larger share of TX
+ * bandwidth than the default queue 0.
  *
  * Queue 0 is the default Tx queue with
  * GENET_Q0_TX_BD_CNT = 256 - 4 * 32 = 128 descriptors.
@@ -2900,8 +2893,8 @@ static void bcmgenet_init_tx_queues(struct net_device *dev)
 	unsigned int start = 0, end = GENET_Q0_TX_BD_CNT;
 	u32 i, ring_mask, dma_priority[3] = {0, 0, 0};
 
-	/* Enable strict priority arbiter mode */
-	bcmgenet_tdma_writel(priv, DMA_ARBITER_SP, DMA_ARB_CTRL);
+	/* Enable Weighted Round-Robin arbiter mode */
+	bcmgenet_tdma_writel(priv, DMA_ARBITER_WRR, DMA_ARB_CTRL);
 
 	/* Initialize Tx priority queues */
 	for (i = 0; i <= priv->hw_params->tx_queues; i++) {
@@ -2909,7 +2902,7 @@ static void bcmgenet_init_tx_queues(struct net_device *dev)
 		start = end;
 		end += priv->hw_params->tx_bds_per_q;
 		dma_priority[DMA_PRIO_REG_INDEX(i)] |=
-			(i ? GENET_Q1_PRIORITY : GENET_Q0_PRIORITY)
+			(i ? GENET_Q1_WEIGHT : GENET_Q0_WEIGHT)
 			<< DMA_PRIO_REG_SHIFT(i);
 	}
 
-- 
2.34.1


