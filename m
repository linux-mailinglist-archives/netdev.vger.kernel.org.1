Return-Path: <netdev+bounces-282492-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBy3DExy8mmJrQEAu9opvQ
	(envelope-from <netdev+bounces-282492-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 23:04:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3471349A55F
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 23:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A76CE302F0ED
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 21:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AA23264FD;
	Wed, 29 Apr 2026 21:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sN4yY0Fn"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011026.outbound.protection.outlook.com [40.107.208.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0E5343D66
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 21:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777496494; cv=fail; b=JHvjDuT5GrD2K4yvK+PK+U0CM7yFybXg223VYT/nS5mEbQo28741T0N7n+IXN6XqxnsNf0u+IWGk69ykJr1/0LhdNR4ZNfdcW4MxoxyRr9v91RwnD7h5iJqVNaiWD5a2lYotaluQn+NYtYug2warsSEb/fYdKki4rCGzHPiBqcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777496494; c=relaxed/simple;
	bh=wsGvQC3FwsdzEPH+3nHwpkw4p/sfTR+K1GFCRpVbjyk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I81Nf8JZLUjkj5nrZpRIURvjbS7jK2me2cdtl0lQKHDcDdgWw5Isqpy1m4DD2tse40a+gB8QjF4Wh74tFKFpETtQIA/MDDp6xxLy0Mgi61i1845hP00AjxGzTU5qvOCmeRZJflf1vZKvlYTbxueagtwt4k3lhIDH0V5yublqaA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sN4yY0Fn; arc=fail smtp.client-ip=40.107.208.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KrcQsGnyytLUY11ggU+OJl1JQ17SYo2apCfGGBJCMu3XtbraCK3pnZrUkkUZ1rRieMsoO9OEPCKy89ApU4jvXzqrckO7anRR5t4FokrxiTk+wgK1q6NyOgLUQnfdZBaMZ78v+dq7//YISyhY+hsWTjZzDh0MMAYRzvspzMF8tXQUf+GZZPwlMYEwrtmEgCTCPTBY64t9IvjeiArZn1mk1m7f5XLkQq7jRaN36ifK0KjF+oFdIZpv/ioejD3eAmS1yd8elCscWGJJs/EDwBjNmdCpv0IYwKY8kKLC1PudkBPOx83JKyqs66o0QPmPPKqDMZTvhUlzwYIcQiehG9J+wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4v4oS1S1OIIHhe7Ca3Lse+Pt4YJcvoxRMNGFC/mLFM=;
 b=xScDAipMkF8ySRhTwYW5uBI0ZQvtgXU5R5QFfkGmgDwhwDpseFytsENu/0pppc3PAObEBQ9evGxS+bpQsJU4AxpBAlkdKL+rltxgpor1NvhsqKIf4vn0Cncfvs19y+G3ym3zsfLUtt4VDk88MNLzpjvOpYzlRbMif+FXBSqsK8kiG6BB4/r2MWzqArtrF6ffQ/CEB7BXwnrjHvyktJCjRO/2YHi58p4CSb0iB8Y7b9fJECZvVTbifTC8lrbkqJhEwJoT6z1wohymeKUI16D0QqW2JfpPcSbmqrsL9fIz3ZfGV4wc/p+cpQMFrSaDZWsTDi/SkexXUEmVwEX25EfG6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u4v4oS1S1OIIHhe7Ca3Lse+Pt4YJcvoxRMNGFC/mLFM=;
 b=sN4yY0Fn9PGQAHlI4Al2bUZHheOoL1fTR+BhS4eg+u05YlGnRj5FVFpTw8yxcWsnaIy7pTne+4cYOHShxRh4fVgyFFP5NuASdxxMxtRjkpuLgUxkiGzODKDGINfCWYQwpBTxTtw+cciRgAYf0UGVqwyeBMnI/uR2p20HDJ5Ts5o=
Received: from SJ0PR03CA0110.namprd03.prod.outlook.com (2603:10b6:a03:333::25)
 by DM4PR12MB6303.namprd12.prod.outlook.com (2603:10b6:8:a3::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.18; Wed, 29 Apr 2026 21:01:28 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:333:cafe::e6) by SJ0PR03CA0110.outlook.office365.com
 (2603:10b6:a03:333::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Wed,
 29 Apr 2026 21:01:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 21:01:27 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Apr
 2026 16:01:14 -0500
From: Eric Joyner <eric.joyner@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Joyner <eric.joyner@amd.com>
Subject: [PATCH net 5/7] ionic: fix adminq use-after-free on command timeout
Date: Wed, 29 Apr 2026 14:00:05 -0700
Message-ID: <20260429210007.40015-6-eric.joyner@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|DM4PR12MB6303:EE_
X-MS-Office365-Filtering-Correlation-Id: 21659c3a-e124-4742-e102-08dea6327b11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Y7gi6x7xMnsaMSD9HeJwTB7BCe+mvd7DfrP24FjTLGwa3/0J9ByQ3aMm8k0Wkimer1hXRzj9ImRbi3loXRpDPrTl8W6UDJ2jJAe0DSxGgjiVZkhgXIQDQfcFz7HOtT9isat2ID+HuUeOMwiBqo2bY2xklbGkU9TP4wCz/8TE2q9s1RnD0innZkbXcmstpMHDjYyJRPsUfoSRblK7AN5vxcr4LzrpXdFx8ct0omFss0zVc8mfmlyoO6tVVOroWiKUaDol/KIvI2kq5n3YjW0SbCwTBngvNETwcKUZhCGIzhfT1DLAb7LPnfvY/rpAMn92tRMnqbGoV54E084hIML12N2GXbRm9OReYn9tB6uSBdUOGNc61id0zTTveZ5yXJW+NyF7DCnfRjZ4rUAyuNFbdZmaIgG/+L3c2U5Bmep9MkyOe8Nz6Z0nDzWvF8q4fyJy2e+gAnLd52TZ9QFkSD2AApAwWndhYQhx2+N8COWZRJ57SpjS+CDgOhubadS9uN/smvg2aED0OONKGK52PS9aE35kSPjoZyIh2pZm1ab/uSvWy9nv0L1pq+cjQl7xiqKQZcS8zCbDXslJWELm0if9jl6/5vEdASd0UeXKRspzPIwKF8bUjBfI/CNb2ymIgg2qNkJbYWPk1r9jXcgB0gUvRH2oDCVKLlxc5m6qI1bkB96an3H6fQj32tyNnuV+8+HUL9OHsEs4Wbd3DlR5iymGEYukricSye62YF1hb8BIgu+XaqXilNkvbzSYYiHWrPP4w3MqoUSJwG93Hbh1Ea9U/A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dbpTFLOTKT1nj7Q3mJbXHp6cqPjweojcvZmhcijKC6YeYtikWEkMHovOYDuiIL1hUVLLCoqHy+veTrZmFSXzQ58GrN9YQOiGk1iMIhDWIN6rqjdjLvvxefv77lpDwnYzjLlQWgZxdheU73XPfEfngEFeod723qkdLv716DYS6aGpunK1PxyH47X6MwmmJOD6qsBivoqDxKqBImZ7Zp/j6tfiTB6PzElTCyePDgBeT2tSsACo338Z1tIJFI6NJeut+BTppv7w8b6j47Zli0MA0KICG2YHTooRb4GQNUIymfN1AUSFMMPqvnor0Wgm8kv1vLff92iyeSfu8Sa1NLGcoBzPFQ7Bye/gUm1fAxp/DyJmyJc/XiJe1TuMzXsSxsXHOZJswW1C9W7hDvpn3+SONjpC3ML/dZbdZzEJMIW2GRdewLwArPGa3KVv2bvBH1w3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 21:01:27.5741
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21659c3a-e124-4742-e102-08dea6327b11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6303
X-Rspamd-Queue-Id: 3471349A55F
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
	TAGGED_FROM(0.00)[bounces-282492-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:dkim,amd.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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

From: Brett Creeley <brett.creeley@amd.com>

When ionic_adminq_wait() times out or detects FW reset, it
returns an error to the caller, whose ionic_admin_ctx is typically
on the stack. However, desc_info->ctx in the adminq still points
to that ctx. If ionic_adminq_service() later runs in NAPI context,
it dereferences the stale pointer to copy the completion and call
complete_all(), causing a use-after-free.

The timeout path partially addressed this via ionic_adminq_flush()
in ionic_adminq_check_err(), which NULLs all pending desc_info->ctx
entries. But there is a race window between the timeout detection
and the flush where NAPI could fire and access the stale ctx. The
FW reset path had no protection at all and returned directly
without clearing desc_info->ctx.

Add ionic_adminq_cancel() which takes adminq_lock and NULLs
desc_info->ctx for the specific context being cancelled. This
coordinates with ionic_adminq_service() which also runs under the
same lock. Call it from both error paths in ionic_adminq_wait()
before returning.

Fixes: 938962d55229 ("ionic: Add adminq action")
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Eric Joyner <eric.joyner@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_main.c  | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_main.c b/drivers/net/ethernet/pensando/ionic/ionic_main.c
index 810cef0fec93..0971ca4d6650 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_main.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_main.c
@@ -190,6 +190,32 @@ static const char *ionic_opcode_to_str(enum ionic_cmd_opcode opcode)
 	}
 }
 
+static void ionic_adminq_cancel(struct ionic_lif *lif,
+				struct ionic_admin_ctx *ctx)
+{
+	struct ionic_admin_desc_info *desc_info;
+	unsigned long irqflags;
+	struct ionic_queue *q;
+	int i;
+
+	spin_lock_irqsave(&lif->adminq_lock, irqflags);
+	if (!lif->adminqcq) {
+		spin_unlock_irqrestore(&lif->adminq_lock, irqflags);
+		return;
+	}
+
+	q = &lif->adminqcq->q;
+
+	for (i = 0; i < q->num_descs; i++) {
+		desc_info = &q->admin_info[i];
+		if (desc_info->ctx == ctx) {
+			desc_info->ctx = NULL;
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&lif->adminq_lock, irqflags);
+}
+
 static void ionic_adminq_flush(struct ionic_lif *lif)
 {
 	struct ionic_admin_desc_info *desc_info;
@@ -448,6 +474,7 @@ int ionic_adminq_wait(struct ionic_lif *lif, struct ionic_admin_ctx *ctx,
 			if (do_msg)
 				netdev_warn(netdev, "%s (%d) interrupted, FW in reset\n",
 					    name, ctx->cmd.cmd.opcode);
+			ionic_adminq_cancel(lif, ctx);
 			ctx->comp.comp.status = IONIC_RC_ERROR;
 			return -ENXIO;
 		}
@@ -458,6 +485,9 @@ int ionic_adminq_wait(struct ionic_lif *lif, struct ionic_admin_ctx *ctx,
 	dev_dbg(lif->ionic->dev, "%s: elapsed %d msecs\n",
 		__func__, jiffies_to_msecs(time_done - time_start));
 
+	if (time_after_eq(time_done, time_limit))
+		ionic_adminq_cancel(lif, ctx);
+
 	return ionic_adminq_check_err(lif, ctx,
 				      time_after_eq(time_done, time_limit),
 				      do_msg);
-- 
2.17.1


