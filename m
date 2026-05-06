Return-Path: <netdev+bounces-284687-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yD7OBz28+mknSQMAu9opvQ
	(envelope-from <netdev+bounces-284687-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 05:57:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE144D6060
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 05:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2245630208FF
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 03:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A1C2E1EE7;
	Wed,  6 May 2026 03:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ImwQ+knZ"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012052.outbound.protection.outlook.com [52.101.53.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F912EC0B0
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 03:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778039867; cv=fail; b=KnGiKR9EZ4xsk4bTDd83xswieUJdyFQwlTKWuOeEd/luH+/33258pWAwLck72YFSaquHaUhtRFsWVHkRUuf7Mpij515Ub9lsHIpuclk6Qi+CeV1WC8hcWRu5CL1sdL8Hu5nWOU1tK5k24tY+S0olOFD0nvx+GnfIslcgR21wrJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778039867; c=relaxed/simple;
	bh=40M5f+pYvdyVnpHFmmVc1bTijoEqcSuITTzlLi3oz7c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W9izmK6W6aMo/6R8fwPRP1jOrXcBzEXhhCx3KCTkr6CySdNEUW1SNwh/+UJV+wVag2957OIAOsxhIGSChhNV2FQEfF46si2STpyUQtiPAFmiyVE+kG7uyGoRLSeJJP5iSAIWXGrWSvRdFOBRuFZwvjkH7frFgaQTwb/qHWjAW/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ImwQ+knZ; arc=fail smtp.client-ip=52.101.53.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cPWB+A7QbT2/U1WwOeTXVnpVKYl4xqI3QhLu5MtTxknBm4khUY/DpYccY+2gS8sojpRB6I066I9NDuhLRRTbjdNjZbYtNYnUf4nJqu/UvwJWDCeyXPCZbJLXfhdlukwkw1lz9vwcwvHMEacRqhD+VSeDYw/x+qnbsiBkyJU11hL0cdrcPDGoGxbHSl8lpNghVUtxqMtrQzneGTbgqk8BCsjXJVi1+dovP380RrZ3mByzIE7rqFqxXUYJOSDm3jWpsPxHO9vGlitqtyt5/5lDUqWg7OF5YmcUvHfuZvPfWcPGqW5bVY5DxO0YsgYSY7Jq+GknDfWtFLBT7KDOCHnzKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mn5/XHmx90NyvvBmLk4io2ev3sCT3Q6F1tyq735g0iA=;
 b=nY1EmS5Ox7etv5sat1r7YveQieaB0iQUfRDiGO7u4gVCc0gloPaizPcetuAMm/f7SEnstalVDb96YXwdqsHIRlQy2O6s6vummLACO9kGSETu+Vfzi7nXAbKp0RvXzoKmdS5lrxwqRgw9a0yNBkm6ey76fOQ//c6Ue41qwNWObsKJidysSbPAV/cbfLSZojhuZBK04DXMt6Fw5szSsdghewtCXfJZj5NODILA9Fus91s7kIoWxL5m22Shz1+4Fa25uTZ01TzZZxxjxPiO5wGfKbudhxOOXGNgSwLsqjICFxRnquI+kZ9WSdw2pDAflP+pAozWAOcfkKhGqI47vRdBsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mn5/XHmx90NyvvBmLk4io2ev3sCT3Q6F1tyq735g0iA=;
 b=ImwQ+knZOBqJmXIH9E/gtlBzbDBOjJ/nRKOnQJOwYj9NUPvXg5zqv7TFODM1a7I7xa7/rUm7SHNOhYJW0BsVyafa0eG4l5LXSuMO4wxvFu+wcEALsWUGb3sp9wl8OfaYH4Q8Ae29Rn/whLEzgYHAB8Z7RdTJBR7TQ1gcJl6dO90=
Received: from CH2PR19CA0023.namprd19.prod.outlook.com (2603:10b6:610:4d::33)
 by CY8PR12MB7588.namprd12.prod.outlook.com (2603:10b6:930:9b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Wed, 6 May
 2026 03:57:39 +0000
Received: from DS3PEPF0000C380.namprd04.prod.outlook.com
 (2603:10b6:610:4d:cafe::b) by CH2PR19CA0023.outlook.office365.com
 (2603:10b6:610:4d::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.27 via Frontend Transport; Wed,
 6 May 2026 03:57:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C380.mail.protection.outlook.com (10.167.23.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 03:57:39 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 22:57:30 -0500
From: Eric Joyner <eric.joyner@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Joyner <eric.joyner@amd.com>, Prabu Thayalan
	<prabu.ponrajthayalan@amd.com>
Subject: [PATCH net v2 5/5] ionic: fix completion descriptor access with 2x desc size
Date: Tue, 5 May 2026 20:57:06 -0700
Message-ID: <20260506035706.12373-6-eric.joyner@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260506035706.12373-1-eric.joyner@amd.com>
References: <20260506035706.12373-1-eric.joyner@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C380:EE_|CY8PR12MB7588:EE_
X-MS-Office365-Filtering-Correlation-Id: f55a81d2-0459-4f3a-a82a-08deab239e0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	tcWGS838nsmigIcaUvOWc5BvZg9Rrwu9rfqrSmA1ep0kJTqHHzAOgSFMRT2dx36uwERwAQ65ltyZkddoMAtJmQFNBLOD8mYtX3gB0CFpVsyqpRgpv8wFHdUziSra71jc9rM8jX9kA9d+nYRzBcODwF6tne6JyveDRC4fLdXrUum2jI/hEBpJITdShoYZc2KYk6omRbhcQ6fcr1ZXs67R/LbeNkOD7UNv5X1KBOaU/86fnLZ4J5lMmQmQBNl24rYNuove0R8yDbdY1QM/TeluKMLgBH67kAWsMFHKPOMp7dNLJUypdB/XPB7iDnrNEzReShNz0FYUfhpNzu1zLuFKrQKn5SxifLeux6owqJr6mVTheCAhJaW0Ut3iXowmH9aKI5zHtpK5NvSzE2e1YuUAzMQgQAUSDvMz+l9MKsJQxprLXD6C/sYgqv3w/W1kqAEM7fMl7yGZYTkf7nblh35AyIFPWoBjaEcLBXDiQziHLY6LEGoHWLWb99/Hnttk9zi5tahnkKQ7KqVDrjZCIeq1z0QGo0l8+KRWUDoq1gqTXydNB7CH2HcfH6HrboJp89BT+B25KxGdCxIrwOpmKovvR4dvK8KBRNiZeDWgrJEEIugtSWRyPbIcd+79uGV5S3uDkHA/tRTaHLHTPgQiWFrSu43Spai2AalJv8D374lRKYT2XnqeQtjv7aqJQ0CZoYOH4/bs7R/WO93LpXNB58xEaSqR8jh4wKLsFh+XYJ+/y+0=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LVS6Cw4YKaA3tdgCyE9pvg4qi9/kOFa06N3C5uW5TgCNIeZt/bAJHN2Am3VUCkG3RKrSsIbzWrhy1u7FIHOosf/QwMc2SxR3ZsoR6wq9yQVIbKBdv89gOe2zYbw6HJLlA7DkKCD4OEXYD3mPnlXxmD9D7iUN7Jc+l5hn4WS4Xphypp0z1/RUSm4wJi6TfgHPubNwBusMkZx61U8apHB1Z7S/UZwJr8mpZ2yxHiBboe1wqQEqu5LLUaYhbjFTZ7ko2MV9gUlhxbgYixamxGUi+9M2J4H7dk4Yy36k0McuSuC0S4O18nRqbGC3fh668+JjshuM978Bhkd2TP+4BUK9NnZxY1yQqRAslGnxDw/Nn8NDhhLPZO+a2HwqLaFZb9OpsTwQzBD1H16E8tJ1whYXAnEQTS8bCiTTJVRDdlgesZNbMptwB0kyO3vdTqlobIoN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 03:57:39.6149
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f55a81d2-0459-4f3a-a82a-08deab239e0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C380.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7588
X-Rspamd-Queue-Id: DFE144D6060
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284687-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:email,amd.com:dkim,amd.com:mid];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-0.998];
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


