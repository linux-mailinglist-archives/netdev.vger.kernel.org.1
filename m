Return-Path: <netdev+bounces-282494-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNzhN3By8mnVrQEAu9opvQ
	(envelope-from <netdev+bounces-282494-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 23:04:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 498E349A5BE
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 23:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C71830BBE30
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 21:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDF737648D;
	Wed, 29 Apr 2026 21:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lmJyjUAz"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013040.outbound.protection.outlook.com [40.107.201.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5967388E46
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 21:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777496505; cv=fail; b=Zq6ZRu3X7luZotB8ned7aD4cdyXebuAQSj2dBLTVvKYOVfZe8G28T046Ts6qge292EpB4SUJG2xc8ZfRJ+Mm2sbyruh5k3VJGg+wj4yylEJvRbRBwncppTPeHdIJh20ykZyZAtO4SliviuBZG70K8biXAaEBEXUvCaA5KXJjTTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777496505; c=relaxed/simple;
	bh=40M5f+pYvdyVnpHFmmVc1bTijoEqcSuITTzlLi3oz7c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VaPN+L7TCP1T/F+OY6+nrHpUb6QYQIH3w+tty6+To/AdD+DfNRNs0hew6jLV0zynbzXOUib+TZcWacJ4oBT9NJf4DZvfEIXpsX4aGVezimUQJ4J4MG0DRTXsjCFsUy8HpEX+GMK4jgboEIcgtwqlUPrQnI+FeqKnbAqFqO2I9JM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lmJyjUAz; arc=fail smtp.client-ip=40.107.201.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XK5kqjvBCNirF4imCL1D5LCj4PBBD51+SfNQqm+lrESk7fpgyTa/qTXhTCWBYCRle4ESmg1XbDS5sxFwyythCdDMqZXZjrAvUb20EDVRr01/VKT0t4SFt31KWJMa4fFLzfsahKrU8/RPnG55iYMpucvBCChZ+vY6UvbfZHj1Gr2bgIOQZvEV0553ZK8N5T1doNOlPKZUvHPx3RCqwExxx7/sTFhXJ0gdgWd7YaE/UYtUxxQajy9nQcixPIM7HqLHbWl1/3stJzRubQ6ZxgaOZr6R7woMiNC/JgtU1vl7kSOK9MfsBDUqlie7iKVJRboECruWP2QdQowZOI9lXo5gyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mn5/XHmx90NyvvBmLk4io2ev3sCT3Q6F1tyq735g0iA=;
 b=b7Q7GH9S5Aw8eAhxTiE4GuanTdRbI+qL5doUi6vsO365cMgWnAcNcfTZH37Ui7/H0VUT7MFgR5m85MjMOsU4NAu7zHuvv5rFpMPrCDxsftt4Tr1gE31ZZJaTXc7xcpLZV0TEVFSqhm4+n4THUVBoNgdit1gsBexaim1rhPBoUfMMANKqHERGyydaotsGhx9jFNxFQHq+Cj7dccS5GZ2ZELspr2yu393d5xjOWwK5eLu0YFjMPAJ0yNMg3ifc1SMLt+BYzCITUyzY8wY06mMKvwconodm9HWPCqWSxtX0eWOuHPfAkAT97uqCJWB7wnMrr3e7+16OFTmEN+tUGWprgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mn5/XHmx90NyvvBmLk4io2ev3sCT3Q6F1tyq735g0iA=;
 b=lmJyjUAzGfqC3rWvNgn6bfm7CmaEzHO2QE1LHDB/X0w/jDValvgCEUOcdkYrtusKEftPYOQl55bUek7jR7CmWtMaXqxKyK8JPyhkU93fnj90OhhOPvyfL+Oh+6usDroD/y0XnPI9gvjClCgspg8GySLBgeVYz+oaIeo3W37//bk=
Received: from BYAPR02CA0052.namprd02.prod.outlook.com (2603:10b6:a03:54::29)
 by CYYPR12MB8963.namprd12.prod.outlook.com (2603:10b6:930:c3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Wed, 29 Apr
 2026 21:01:36 +0000
Received: from SJ1PEPF00002317.namprd03.prod.outlook.com
 (2603:10b6:a03:54:cafe::af) by BYAPR02CA0052.outlook.office365.com
 (2603:10b6:a03:54::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Wed,
 29 Apr 2026 21:01:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002317.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 21:01:35 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Apr
 2026 16:01:34 -0500
From: Eric Joyner <eric.joyner@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Joyner <eric.joyner@amd.com>, Prabu Thayalan
	<prabu.ponrajthayalan@amd.com>
Subject: [PATCH net 7/7] ionic: fix completion descriptor access with 2x desc size
Date: Wed, 29 Apr 2026 14:00:07 -0700
Message-ID: <20260429210007.40015-8-eric.joyner@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260429210007.40015-1-eric.joyner@amd.com>
References: <20260429210007.40015-1-eric.joyner@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002317:EE_|CYYPR12MB8963:EE_
X-MS-Office365-Filtering-Correlation-Id: 972bcf58-d270-4021-3aea-08dea6327fcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	sSsHlhz5VKdzm7C5wjKUz71ZXY9tuiDwpz6OcJNOKW/aGf/AKiZSwg9ihlzAWlfAUxif2DlIG0TuKqwvCTLpvZhPtHKOAwXB0PPZoAcI+9JKjWdGxLz+2cVS/axErywyCDLwyEcCD/EUb8j0JWRfwwSgeFGJPBvIVe108k0IpzV7d/NhQzdtsSUN+o37zEYFIJxSqWCHZcFc91wdaKQ6mYwN4pab7NiLnH4KTj7F3TJ9h2nyq9hcLCSi5MY2TOuOjjTc0DDN6iIVkMPS8TF/JymLeRcvFtm0jXsyVNXGAh+IWsOMPI0fJxDymgMy8BN9OUfxi0C7eD10CILcgPqP5j3kiMM+K35rj7VLvdTEdGClYq2d/yjqsAyf4GK4fxL1tsmgPFB4NkYq5yNK4+IMdhSOeAYzjnhhHAmHZC0G/7bNQ5YhW6KFV3mKm6iuIWZiQaD5oy/cjfYTU7rbbNBftTuUJl3hdghnLjLvgM0d5LE7LT7diSSpMhHZdjbYJeTJqaYn+Wdjd8V/LHbeBVuBpDRas45RLb7QBjSf+Qc8GYE5ie8pnCyXcsL+OW8k3I/E4/XRsGhK3W3+uJq93IvWI1iI48Nxoy/iW7ZHz3yJIdK4B0rX9gWfOdY/clcUaDOX6NwmYtOBYS55c4MYH7bOE1X2WfJ+Zv9ySHQbnRPrl+l86Yx2ZKRFe82Vfu3Uc9FXaZtgPHafRFGlPzJJ/GqbQ/MayqVPArik1pkgPagngKVi8qkD8OmWwcXtOF6E2sPTxGhYoaVD2zerpWFjMldi4Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iV+4MDtu3jJiYLsTIEjfN92NaqIo9PzgcFn8Rwr8DIVCqEjeJSmP6RYWzdRem4BEAGW6tmUxyyX/PIeIwSwbsgxQc4A8dKI8iz2G7ZkxlABzqiyJFAqVeSksAjMA513Td+Ursy2wCtBBv0KCf+ogzG0BQSXrm7J/53PKx+KsLxQY3dXFOhMsPfsAcGt68N69AX0Xzg3qh0rCDpSqEm66FAyg7XW/yFt5QdMhj4aoTBrg/ElvgVILQlNd6OwGn1jiOmQdcHLPTjwFneMJXaRIANhzlsSRKFPhDCAEcqubLYzzHMk2O/ez5cPVSEf5gHX2hLGie3kggQGqqVj5FMdx/oJKc71qMb+juZvIs0Uz/zyLeAjX0361OgoR3+78hObZyp67SCAUZX6IhVOlDQU42JnHeI6pzIs19tXLgIPQF0y2L/LSkE5OWXaxoqovoP4Y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 21:01:35.4837
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 972bcf58-d270-4021-3aea-08dea6327fcd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002317.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8963
X-Rspamd-Queue-Id: 498E349A5BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282494-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,amd.com:dkim,amd.com:mid];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

From: Prabu Thayalan <prabu.ponrajthayalan@amd.com>

The old ionic_rx_service() and ionic_tx_service() used array
indexing to access completion descriptors:

    comp = &((struct ionic_rxq_comp *)cq->base)[cq->tail_idx];

This assumes the stride is sizeof(struct ionic_rxq_comp) = 16 bytes.
However, when the IONIC_Q_F_2X_CQ_DESC flag is set, the actual
completion descriptor size is 32 bytes (2 * sizeof(comp)), and the
completion itself is located at the end of that 32-byte slot. Array
indexing with a 16-byte stride would access the wrong offset.

Use pointer arithmetic that accounts for the actual descriptor size
from cq->desc_size:

    comp = cq->base +
           cq->desc_size * cq->tail_idx +
           cq->desc_size - sizeof(*comp);

This correctly calculates the completion location regardless of
descriptor size. For the common case where desc_size equals
sizeof(*comp), use array indexing in a likely() fast path to avoid
performance regression.

Fixes: 0ec9f6669a7d ("ionic: add handling of larger descriptors")
Signed-off-by: Prabu Thayalan <prabu.ponrajthayalan@amd.com>
Signed-off-by: Eric Joyner <eric.joyner@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_txrx.c  | 27 ++++++++++---------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index 301ebee2fdc5..27a113d63d28 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -701,11 +701,7 @@ static void ionic_rx_clean(struct ionic_queue *q,
 		__le64 *cq_desc_hwstamp;
 		u64 hwstamp;
 
-		cq_desc_hwstamp =
-			(void *)comp +
-			qcq->cq.desc_size -
-			sizeof(struct ionic_rxq_comp) -
-			IONIC_HWSTAMP_CQ_NEGOFFSET;
+		cq_desc_hwstamp = (void *)comp - IONIC_HWSTAMP_CQ_NEGOFFSET;
 
 		hwstamp = le64_to_cpu(*cq_desc_hwstamp);
 
@@ -729,7 +725,12 @@ static bool __ionic_rx_service(struct ionic_cq *cq, struct bpf_prog *xdp_prog)
 	struct ionic_queue *q = cq->bound_q;
 	struct ionic_rxq_comp *comp;
 
-	comp = &((struct ionic_rxq_comp *)cq->base)[cq->tail_idx];
+	if (likely(cq->desc_size == sizeof(*comp)))
+		comp = &((struct ionic_rxq_comp *)cq->base)[cq->tail_idx];
+	else
+		comp = cq->base +
+		       cq->desc_size * cq->tail_idx +
+		       cq->desc_size - sizeof(*comp);
 
 	if (!color_match(comp->pkt_type_color, cq->done_color))
 		return false;
@@ -1180,7 +1181,6 @@ static void ionic_tx_clean(struct ionic_queue *q,
 			   bool in_napi)
 {
 	struct ionic_tx_stats *stats = q_to_tx_stats(q);
-	struct ionic_qcq *qcq = q_to_qcq(q);
 	struct sk_buff *skb;
 
 	if (desc_info->xdpf) {
@@ -1205,11 +1205,7 @@ static void ionic_tx_clean(struct ionic_queue *q,
 			__le64 *cq_desc_hwstamp;
 			u64 hwstamp;
 
-			cq_desc_hwstamp =
-				(void *)comp +
-				qcq->cq.desc_size -
-				sizeof(struct ionic_txq_comp) -
-				IONIC_HWSTAMP_CQ_NEGOFFSET;
+			cq_desc_hwstamp = (void *)comp - IONIC_HWSTAMP_CQ_NEGOFFSET;
 
 			hwstamp = le64_to_cpu(*cq_desc_hwstamp);
 
@@ -1244,7 +1240,12 @@ static bool ionic_tx_service(struct ionic_cq *cq,
 	unsigned int pkts = 0;
 	u16 index;
 
-	comp = &((struct ionic_txq_comp *)cq->base)[cq->tail_idx];
+	if (likely(cq->desc_size == sizeof(*comp)))
+		comp = &((struct ionic_txq_comp *)cq->base)[cq->tail_idx];
+	else
+		comp = cq->base +
+		       cq->desc_size * cq->tail_idx +
+		       cq->desc_size - sizeof(*comp);
 
 	if (!color_match(comp->color, cq->done_color))
 		return false;
-- 
2.17.1


