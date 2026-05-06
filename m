Return-Path: <netdev+bounces-284699-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPxvCUHF+mkzSgMAu9opvQ
	(envelope-from <netdev+bounces-284699-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 06:36:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B16BE4D6238
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 06:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AB58F30618B0
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 04:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73D32F39C7;
	Wed,  6 May 2026 04:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jy5WplDo"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012068.outbound.protection.outlook.com [40.107.209.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDDB239085
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 04:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778042149; cv=fail; b=OCfYtuE24sL7T1h0KzNCx9jPlZhDLq1Clt+t1iS67u4rPeawxtSo4IqiR6/ZIFBsUAeiGiy46yoxH4V8HmC9peLpzuPD//f9O8pnLN/hhpzcHVlanCflwXHfuyvgNQL8ySqPOKJJ16gpFntkqqM7m4SI14BsN8xVhXPHvERkkoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778042149; c=relaxed/simple;
	bh=el1Nb98mEZR/AGuK78MqZ193BgvJtTAFsmLJOZaQgaQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bFZ7ythn6HJMDanHHuVMOw4zHzPVcEQRLj7hwB1ZiqMKq+s+NAHALK49Z1HqjW+URgP6ztlKrfhoErjQTQLDXxaXxDATOKtLiCA6ic/odOsGntJxeULGHm2QIs3d2vjnRJe6yLuLo8J/daN6C/a6F2kpcqVxTogKahGCO/eQV7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jy5WplDo; arc=fail smtp.client-ip=40.107.209.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mY8oJRRScKcV8iQAVeeRF1QkRv2kmvIDmD3sv0iphCzIS4/HVF5NA7DQih21k5YQt35c8rPvgKtPCqzP+MWhV99o4OXj78EEY5pVepp9ET/3Z3BTZHwEapcriAeAo4em8tj1hHmiOPJpMloOYlR8TzezYZs2zYQbln6Dvx3zha2cgPMgP+BrNbZyxrjSOkoRgCKueZlhVUce/qPyoB6Ze0YxYBDa7wKl4tyzA6KeijXTZpG94qwNBRtvpNWz/MoXyW6neng7MMtpOJm+q9cnNHgPTFT9A7TNrdkJ8YNbKWxdfykTixi7qgkwasxFcv3WxEqDryrxn8x2y8PRGvz9Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ddg6/NnscaQlEqJobdleN23PSZ/lYDftUv/+quXcN1c=;
 b=cvhLF2e+n0/2A97QOT+loRwnEBPGrnq0mWhyOBp2mSmLNLaJ0KbbZ5p0oCtuxH4q7mu9qIa/EvkEt8to+wuwfybkU2wUl5khJ89Xq7gEgZcEZjep+KZcawwJfTgPHbIj5tOsw2pOx0yt90S4JcrsRE15Qh+2kuuuzWslSKXtvYRLlqMBNH/AdY8if7zdjfRzVVdPQpikRSTqzm+XClF9u66ZxhhDqJuFMtGBp/MGeCyZPI82oq+SZUTe2UiRlQ05u0VKA9RPmRIVAsEIA1WXrf6C4o9Nqp4C4vkoCBuCG7noCB90h5vv1S5ejN7VSGp2hbW06F2l+IhoyJQVAAoLOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddg6/NnscaQlEqJobdleN23PSZ/lYDftUv/+quXcN1c=;
 b=jy5WplDoTyVxgiAHcrKcsuUuCx17pUOnFHjYGDnr0xMV6nzrsyE2wP+Jvgd2Vj50wG8sxooc9CTfBuRkHEkO2gK6VgKIKZVcAw4/q2GDO617sjRlO3VwOgfPZh3BpMcry7cd+yCrn93pXRCr8RO1uq2f6zlQRUQiHk3EPUIKc1k=
Received: from SJ0PR03CA0029.namprd03.prod.outlook.com (2603:10b6:a03:33a::34)
 by IA1PR12MB7760.namprd12.prod.outlook.com (2603:10b6:208:418::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 04:35:43 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::ec) by SJ0PR03CA0029.outlook.office365.com
 (2603:10b6:a03:33a::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.15 via Frontend Transport; Wed,
 6 May 2026 04:35:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 04:35:43 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 23:35:41 -0500
From: Eric Joyner <eric.joyner@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Joyner <eric.joyner@amd.com>
Subject: [PATCH net-next v2 4/5] ionic: Report rx_bits_phy stat to ethtool
Date: Tue, 5 May 2026 21:35:24 -0700
Message-ID: <20260506043526.64301-5-eric.joyner@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260506043526.64301-1-eric.joyner@amd.com>
References: <20260506043526.64301-1-eric.joyner@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|IA1PR12MB7760:EE_
X-MS-Office365-Filtering-Correlation-Id: a4cb1aca-e6d7-4382-e3c8-08deab28ef24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	PvoYM94cTeZxd1cO0xu0+iwkt/2t+822P/aMraXt3rDMM7hYgL/8DTEVEWv+tSfhFO5QTgDBkhiANwNsjfQtDIer1pl6NPkf3k6e2h5/yo0c7U436nHd3d1Lq7K9Nt8bTOGvGdeMko+O4gE4cwrBxbsyA+gx0XIVEfWwRWfIL8vXVSgzMaAuefpBVIn1r0CFwbaD1g3nxEv5ILACxD187gJp20hifKJ0z6zZlePk1V+jx9YwN6+sMdu44Z9uKAtr1jgn8DdgY1mgzM0KEbn6o079B4Kk70gfCNZJo1IR9UHpS3Tc1PLDpsQG7icLqwwxdLOswUxy6e1iCtnUszfb480w6EJdRtKJNZIi8gpbyK1Ob9Gt2hox5zcXO77MR9oeeSGenm34vgACAiOn9lFnmJSzpN88tdkN8S/vihw1/E2K+CLzFANNlcfKLUO1zeRFadMIPGHTnWmMjwugFYLrvpD4KtAIHOtV28oXo5u4j8gAlXn1wdfCs4vVQxGfIVNSuppJJh1mg1HgS5yEW4EgZojxnEWDSERVYJZweu0/8WkQxsA0mytZMarhIuGUvw0VwoDXu9SVH2NIUgfIdCRU3fhJqsSEku6CMQDjOrDXfRXYHUKURKDH8vcwb4OKZdYp3iP82cz2Q1DC4oj96uD5Y5Vk0CP9CJpdfRiKBLwjTbEW7n0g6N2y7QOdEFnwcYsp1rc8DALZlu8Fc4kEHOBJSEUp8+reZ99EwyKvQD06WVM=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1dCbghI9nWkCI7u3iQoYEE5Hz16WEvkAO5BkssD2pybURVt4AA8XeQHXAdpnj/bZWjxOkn6tHWy2u+DgK9pUt54pOZC/9J8wNAEYuhQm2onGIzQYKEGCY6Zc6rKUqO8zgzxXy9M3eh6xd8xj0LaxuOKZxs+lk8snT4jo4aGxELS7Im54lkkO7rq3JyF+SVo4itwR7RMBhLgNL0Sj7Y5/r0B5Shb1FZsaNbkWMMIsxfGDP+qjvqAiRY7lZa/9amg/j5K4tiZImmKEilIuMapIrkz7fnyNdFBcbQ7WaizpzEggRo9/Ri5ICmsFLPyGAhaESW0XSDCfWUg3pt7DSHALDlkoXc1XaX6FflDAtyFdonhKAof4dHyUgwwqdDZ697hLl7T96Axrc2EndyM+2uSGj3LS1mcy2bH8Hx8aU5TG4ZMwqfDDXQfKXiacq9CSwoph
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 04:35:43.1061
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4cb1aca-e6d7-4382-e3c8-08deab28ef24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7760
X-Rspamd-Queue-Id: B16BE4D6238
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-284699-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:dkim,amd.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

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


