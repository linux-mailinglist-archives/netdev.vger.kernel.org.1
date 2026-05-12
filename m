Return-Path: <netdev+bounces-287340-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHP/G0WuA2rT8wEAu9opvQ
	(envelope-from <netdev+bounces-287340-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 00:48:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C9D52B188
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 00:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF0C33103530
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 22:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422F93A7588;
	Tue, 12 May 2026 22:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Q9ylNQXb"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010036.outbound.protection.outlook.com [52.101.61.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90CB3A7585
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 22:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778625889; cv=fail; b=uNS5/u6FHijRnxddFq/w4DybgyQPQwEJLjfBatbD4OixJukVm3BKfEqYvG/sDy9C67CuA10oETBmWf5IiH7ZQhr+IrDyGdCQ8o72zFgpzld2TZi3ZM4+rpVEBTlnbRrFIYcSAQoBEYlPIsjYEZB/7qpbf9HKVLtxneMmRf5Ky88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778625889; c=relaxed/simple;
	bh=el1Nb98mEZR/AGuK78MqZ193BgvJtTAFsmLJOZaQgaQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V6e9nHe9d6/n1S9ibuybrdfPIdD1prGqmoEnoGNarH6IZEFr4B7TUNSukbbDESUZrVo+s3J9ohWcXGjgL9GR098GKcWk4PIgsW5ijhOXqCyoc2hFM0TBVGj/DsJtwjPncVgE6s9in13lQzjJWESt+1JfDbL5oR/qQo4P0HMkfYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Q9ylNQXb; arc=fail smtp.client-ip=52.101.61.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yqvlC6g/UxkJmEMR8cMeUcuD/qqLpgHTlNiWLTau23yzbPZQfCYGXNQW75tf102l23WYEEwp3MyAj6gQTpWN3Rlgamwt5FkwhA2exvbV9N5H7eJezxOVE18C/jgbHj6PNLQfn6Ly58ac9FiMkA8N9CY+NFGZljUvMDZreDbRLpPY8NSwJakBK150JkaD/jYooYLLNbW73CJ94T7oYItBG2HDyl5CriJ0XbZ6dU7A5w/Gk/KLW13cw04t9Hrn3IGbMsTrtWe2OA11xvJpcvTe1J4MxM6dHuHVAVPwrzYfiBG+W8t4GbuT0Lb/TasyjNPuz6a8ojUnWdRXVVB6YdWNSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ddg6/NnscaQlEqJobdleN23PSZ/lYDftUv/+quXcN1c=;
 b=xsaYwm7dC7zSp4qXqkJFEUL/YPXZ6AFsh7qAr5QB3jvJOaJWuI8jWqOmjn7YUq0lg5Gks6EihmkyFvgS6Fv33WHniUbrzyiZnu3W1qNzw279OuFODiJwh87Q76qy+mZBnIazX7voKPyhMoRerYT6J9uYpoHCOgpyJCFbU/iWNUDju7ozIDfdXTwiuW4VXFuZxzd9zTgLzKUS60ZfbOXOfXy1p7p9QN9jIJYW5wNCmeAKtfDoSBpYyObko3JmTrdhHDWnvXKgZyXGKYaLJDiiVbOh8ExclnChnVD5DAcdDMi5FP68wpodp/9EKyETn5r2Mz730sOMhny19EtniG/rHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddg6/NnscaQlEqJobdleN23PSZ/lYDftUv/+quXcN1c=;
 b=Q9ylNQXbQGfWaoIRYUpTP6rPg9OrMeeB1YpFJOZWtobRZXQIQbRXjXSYWvpLeyxcL56gmaQ52gURM3Jcor7sUoHEBZVEsGBUVjjn/Hzzxu1s4Bgu9dA6cv3OqG4doaeB8hkihsZrdQWRRRn73mm4BbZckb++UE2gQK41QyFfRek=
Received: from CH0PR03CA0294.namprd03.prod.outlook.com (2603:10b6:610:e6::29)
 by CH3PR12MB9077.namprd12.prod.outlook.com (2603:10b6:610:1a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 22:44:42 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:610:e6:cafe::70) by CH0PR03CA0294.outlook.office365.com
 (2603:10b6:610:e6::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.11 via Frontend Transport; Tue,
 12 May 2026 22:44:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Tue, 12 May 2026 22:44:42 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 12 May
 2026 17:44:41 -0500
From: Eric Joyner <eric.joyner@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Joyner <eric.joyner@amd.com>
Subject: [PATCH net-next v3 4/5] ionic: Report rx_bits_phy stat to ethtool
Date: Tue, 12 May 2026 15:44:20 -0700
Message-ID: <20260512224421.25236-5-eric.joyner@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260512224421.25236-1-eric.joyner@amd.com>
References: <20260512224421.25236-1-eric.joyner@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|CH3PR12MB9077:EE_
X-MS-Office365-Filtering-Correlation-Id: d2b9e87e-df89-4a61-6f4f-08deb0780f14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|56012099003|18002099003|22082099003|3023799003|11063799003;
X-Microsoft-Antispam-Message-Info:
	QEN45tZGl3uFq3cW9X5kb7Zcg3KRfcUvJHWOLwgRgGXZtu2n7p+q14cnRt1GQwREE9VIsq5nOuLPGQLh/uilz6RUMqTsvNgid9WlGkslHKWt5Penhf8np5h96c7qr7bjaegDbC0oQXbJkyVsgYCAJGKa51obc6ivmPqs6h0XQhOhfec7HWkdHIROcsw7XiqlZHxPb/I7D151g432NUO62Wwf7cEQx6U5lfS+8bDyOtqNGywpg5C72HqTqp6nAPJY0oOTtn+UosHs298N297McQDDyQqJmTgYub4Lsn00rRf6p28jRtSVtNKXIEH5OLxBxolVpcRCjB1YDSbV68mCoAxdujuNR8l6Q1D0qo9/0v3Ef8Ls9G+TKayh+VUas5s/qxkD7jpR6XM4rvfIwTqyALWvibYjcuHMcBmpIYRWUN57UPSfQn8R+1GrKVuewgeZveIdt5HrPImls7uUC/t2/nymYSGQKFYL/D0FE4dS+shTmfOzhYaAWJKnMk+lCACCVMYDSVWh/3zW/rx8YQJyMa7aya/pZP2zYwMNR8nnjzbcTWrwabxWTqGfSH2p72UYMCdqD3SPaxtU6E4Yqi3CnQJKrVG7ANUq1skAPftN+Bds/uDcTgTBsY49l+lDbxT7+6HoF04saj6+RgKpNO/8sM42utnCTIfjHlBEOQTwNHMCfA5MXCvioQfbKsQPJMj47MpNLu68onV9xNO4BPpoJQREQOVeRFu0n1nG+JACNi0=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(56012099003)(18002099003)(22082099003)(3023799003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	N3+NB1p0oGbDJfgJW6H6AaJddXGlwhaMR5sGr3Jq7g/rD+mFgxgeuG4YGV2VOdBhJTNRviTZ+AUE/nMdUSy3ZLxivf0m3NZTpk9caLg8h0KjyL33UE1fXfmp6KpusVHU8FilKf3ziQNdAYRe90T1ZWzT1rkY8nmKpKSTAaH9RuAcyj+cwDnXtAaacQk5Bn9hgZZL49zH7CIwWPbyrskOnF+A38siJW40+Bb+J2ExyC9zB05HneJcZhT/P6BXgW5WJO3ZQSbMeUZ6MS4wqEHacax5/Uaf1mLWVgEuSL8Y3uvLIsXc9If9SxMExzYSXs41SjC7UYYGK57I4amAQ4Sx8zOBmVjrNWyBGWxdQRtVaxJNZyitmEYHniwf4FipEJtnq5Dlh3TX8kt7r+7k1c91Eu3k1lxaA0zq+5/MdIksD1xoqzTbZOupRc38agUoKIkO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 22:44:42.8207
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2b9e87e-df89-4a61-6f4f-08deb0780f14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9077
X-Rspamd-Queue-Id: F3C9D52B188
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287340-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:email,amd.com:mid,amd.com:dkim];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

This stat contains the number of total bits that the PHY has received;
it's useful for BER calculations. Add it to the ethtool stats output.

Signed-off-by: Eric Joyner <eric.joyner@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_stats.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_stats.c b/drivers/net/ethernet/pensando/ionic/ionic_stats.c
index 0107599a9dd4..c45ed0db0582 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_stats.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_stats.c
@@ -167,6 +167,7 @@ static const struct ionic_stat_desc ionic_rx_stats_desc[] = {
 #define IONIC_NUM_PORT_STATS ARRAY_SIZE(ionic_port_stats_desc)
 #define IONIC_NUM_TX_STATS ARRAY_SIZE(ionic_tx_stats_desc)
 #define IONIC_NUM_RX_STATS ARRAY_SIZE(ionic_rx_stats_desc)
+#define IONIC_NUM_EXTRA_PORT_STATS	1
 
 #define MAX_Q(lif)   ((lif)->netdev->real_num_tx_queues)
 
@@ -243,7 +244,7 @@ static u64 ionic_sw_stats_get_count(struct ionic_lif *lif)
 		rx_queues += 1;
 
 	total += IONIC_NUM_LIF_STATS;
-	total += IONIC_NUM_PORT_STATS;
+	total += IONIC_NUM_PORT_STATS + IONIC_NUM_EXTRA_PORT_STATS;
 
 	total += tx_queues * IONIC_NUM_TX_STATS;
 	total += rx_queues * IONIC_NUM_RX_STATS;
@@ -280,6 +281,8 @@ static void ionic_sw_stats_get_strings(struct ionic_lif *lif, u8 **buf)
 
 	for (i = 0; i < IONIC_NUM_PORT_STATS; i++)
 		ethtool_puts(buf, ionic_port_stats_desc[i].name);
+	/* extra port stats */
+	ethtool_puts(buf, "rx_bits_phy");
 
 	for (q_num = 0; q_num < MAX_Q(lif); q_num++)
 		ionic_sw_stats_get_tx_strings(lif, buf, q_num);
@@ -322,6 +325,15 @@ static void ionic_sw_stats_get_rxq_values(struct ionic_lif *lif, u64 **buf,
 	}
 }
 
+static void ionic_extra_port_stats_get_values(struct ionic_lif *lif, u64 **buf)
+{
+	struct ionic_port_info *port_info = lif->ionic->idev.port_info;
+
+	/* The # of stats added here == IONIC_NUM_EXTRA_PORT_STATS */
+	**buf = le64_to_cpu(port_info->extra_stats.rx_bits_phy);
+	(*buf)++;
+}
+
 static void ionic_sw_stats_get_values(struct ionic_lif *lif, u64 **buf)
 {
 	struct ionic_port_stats *port_stats;
@@ -341,6 +353,7 @@ static void ionic_sw_stats_get_values(struct ionic_lif *lif, u64 **buf)
 					     &ionic_port_stats_desc[i]);
 		(*buf)++;
 	}
+	ionic_extra_port_stats_get_values(lif, buf);
 
 	for (q_num = 0; q_num < MAX_Q(lif); q_num++)
 		ionic_sw_stats_get_txq_values(lif, buf, q_num);
-- 
2.17.1


