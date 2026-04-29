Return-Path: <netdev+bounces-282493-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCwKObhx8mmJrQEAu9opvQ
	(envelope-from <netdev+bounces-282493-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 23:01:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B0B49A511
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 23:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DB7D6300349A
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 21:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED74D377EDB;
	Wed, 29 Apr 2026 21:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CF5VrnJ+"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012049.outbound.protection.outlook.com [40.93.195.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A38343D66
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 21:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777496499; cv=fail; b=oNZcG/KMsGqBMOkzOnGwEqW/RPQvq1CsVX3hMWUMGLRFdW2A8HF8bCtC59GIjg/wIs1xtJ7HH33xKk21w7lR/sETyfcFkQX8DkLnScM7r8XSbsaWvsszpEfM6F6SM3EOPhxhVbYy/PuoW3djXstb/P+syocxwjTdkGKR/RHrf40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777496499; c=relaxed/simple;
	bh=2PowJRFIV7NW2Y7WfpLoTup5hxAOevo07h6RMwieaIM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HepMAFKjMHmiV87K9WdZEyVkJrdsOi7/XzbDRU5tiYRFFMKwQQprw/9s2QILZHD9FOiyNDJJiAj3xNC72JfqIu/8LG1JkJ7gQ767+onHFoRMnHpjf5vDcSvurCNrmD99VS2dOqa6wopBD8dhar2XfvuTjaQ+CfjSX75RWtH8UUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CF5VrnJ+; arc=fail smtp.client-ip=40.93.195.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EtIAksSVWx5DZb+mvdNH8nqxkgDiKI214cmO1W4SYtYTJQVF2mbi2grPD/iVW8I3w7+x/nsHKdlh+PBqLt7tL/srCKkno8sCir5CLBsv9fOiXBMBTQ4t8TH19dMinD7YVwH9Rk7U/7yXH2ahfDJE3bXPsogD124W0vmuzdJM22Ya7wzTd5oqPeIXvrgxyIp+a6qrUO0+4/dzOX4SPSrW22nGYXkQ5NYW2lzjEU7WSRU9zaz/wTPQRM+KPeN7+UexsQtwcPfFd/zkgvs8V3EuNzkqE2iDvn5OsAaAwNd49K6UnHgVrbSsBFgCykbRuajSTUD7iTlm+xBgufzhBcsw5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7YL25DHNK3JK91ec7rMU2IxPuJw8P5J9YmtadlrvjOw=;
 b=gdGk6HjfaNFJ8DI13f4thwn/4ia3cboL2nW3f2JJrBklhLIJ3Yl5pEof+lHAZ2kccPcJqRu5i50Z0b0ZQAxo2wn/oJxgYCuLsNJuRo4c06LfwRwtV2WHFodV9+Hofms2cC7wXTwgay6gK+Kt03ywxdq8lyeXfjhBKqGJyOh4K4Q6hgpYZ7cIxFQgeQeMBgCuoSdOWrnOkwlcBXRINrdyAKyfswM1PtnQj4ogIkhVm4QzHfgMqR1aI4rvWG4O+v99/ABbITefW8CKOJQBN6EWR/AO7DyR7L178XI711C12JuOC66ACeOYLfKn2N4oQIBU8DbZHZIaFMSUMay3nWbMRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7YL25DHNK3JK91ec7rMU2IxPuJw8P5J9YmtadlrvjOw=;
 b=CF5VrnJ+ajHByCvVlQuyoAdukzh4roR3jj1MiBKWTEQa3sP4a8cjgiumCpAqo3Yc7ayBr5FIpj1s9f+Gq32LMql2lIfpw7OZ7wpNyzdPx/3ZuAoYOLJg0spXBnxBaJXxh/2R60MSwLd5ScYwqO6wtQvLtLv0tOsWgn5LyDGK2Ec=
Received: from SJ0PR03CA0096.namprd03.prod.outlook.com (2603:10b6:a03:333::11)
 by SA1PR12MB8917.namprd12.prod.outlook.com (2603:10b6:806:386::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Wed, 29 Apr
 2026 21:01:29 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:333:cafe::2f) by SJ0PR03CA0096.outlook.office365.com
 (2603:10b6:a03:333::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.28 via Frontend Transport; Wed,
 29 Apr 2026 21:01:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 21:01:29 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Apr
 2026 16:01:27 -0500
From: Eric Joyner <eric.joyner@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Joyner <eric.joyner@amd.com>
Subject: [PATCH net 6/7] ionic: service adminq CQ before cancelling to avoid false timeouts
Date: Wed, 29 Apr 2026 14:00:06 -0700
Message-ID: <20260429210007.40015-7-eric.joyner@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|SA1PR12MB8917:EE_
X-MS-Office365-Filtering-Correlation-Id: bb9fbb7d-0790-4d9d-d6f7-08dea6327bfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	XBbIOGhj9Z/Z7KlUZmQ37Kfgi1WXW24A7UpEkN35Wy57SaCZcEbSTx4s2YrevTrTcI5gRMaX4CSUUou5KLDSV9rfeQR2Yh4980TyKJ4kzXzreVA82BMNCjXIIr7aLEmbEUx32iTpU6kPNZeUcIeQdUFhuaAWL7wAhDIrPcL6gXM5rMdEBydxyeIZCP5bc7It7TVexhhUfczAQUSkC+WTNVwEOn8FWQDSvwDguKq+87yFTlmq5QElUdicAErF/IlxdzySwjTi0OKYs+FqHnVqzgLRV0iiZ8bYLjqDqSiybl7+UqXFtBcU5uH1Oq3TJlUIpb/dcxl3z7J4nFOSBNbWoUZeI4B/B/F+0ur10rZq5d2+TI3ETzFVowHrCmMnw7nus5ySXQFptnFr5TIuqlDpyKOwzFVit0TZio5HDkqufCaakQsTFbI/GCrr6YhfDBDmyHJvn/vy108N6kajYWCh0Yx/CNhdBIFkPUu04xEnziJHRg5ekL3gL3/aezMWY1OQlGYB8M4LLhbI2ixylx8bPClkRBw0mxTvfq1uvCHl6ksKMnAwR2bxr1SJAIOZEivms284QXW5rlayx3JgQA34QSkvSIl1E678KNHy1R9BSjpAWy3ww//XnZAPIJyx0Kpki3EFhTWkuugbMbDLLdAzV95aAbCvwbz2PPukgTWtTOLqcxSK9G2J8WDJTwgJxzGceIL7T59CYKufYBtY2d40ogKmtl+YbBD1wM8ER9eGQ1IIk/rvbwZ49+9aHQmMaWlq9ixCCjJICFGPx79ZCy24zA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Mvbo/6pd06tPmWTfNAqFPgV9h6mq3c0yUlL7tiET5Rli9C5Bz/Pml4ihzkevrDClNh8eXgBFINyiDfiGoroSaMCojDKr+MOBQIjTY5IJoDSZVHyhixSqXipGUIrBiPDxjxrz+897kDIQYtIRAgqpqckJABhJmppcRbDq+1UWEjZfHSbsYEBclezBMq9OtZlOl0mfCBqg4qTuu1SKZwmfSJ6FkW0ULuY4WkuFpoB3KWY21OmFCvnQQrs5Yx9k5qrbUg3Za2IOTj0EqJjkwTDXm1juCCZY7CDZj9EeNn7wD727eXjC3Wbq3ttwkEyM1IVjYWT8jpscXQpVpxQDWCUasU76HLeySiwvI/NF48wKS6HJyV6tA595cbfXKpqsjEusxtJ8aebxyuxwkJ2m6/Q9oLVMg2Mpjv5XDUxqilG798My8WMCwbtjpGmd8Ov4Sszt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 21:01:29.0521
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb9fbb7d-0790-4d9d-d6f7-08dea6327bfb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8917
X-Rspamd-Queue-Id: D0B0B49A511
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282493-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:dkim,amd.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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

When ionic_adminq_wait() hits its timeout, it's possible the
firmware has already written the completion to the CQ but
ionic_adminq_service() was never scheduled via NAPI to process it.
In this case the command is falsely reported as timed out even
though it completed successfully.

Fix this by renaming ionic_adminq_cancel() to
ionic_adminq_service_or_cancel() and having it call
ionic_cq_service() under the adminq_lock before checking whether
the context needs to be cancelled.  ionic_cq_service() invokes
ionic_adminq_service() which will process any pending CQ entries,
copy the completion data, call complete_all(), and clear
desc_info->ctx for completed commands.

After servicing, check completion_done() on the ctx.  If the
completion was found and processed, return false (not cancelled)
so ionic_adminq_wait() can use the actual firmware result instead
of reporting a false timeout.  If the completion was not found,
fall through to the existing cancel path that NULLs desc_info->ctx
and return true (cancelled).

Fixes: 938962d55229 ("ionic: Add adminq action")
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Eric Joyner <eric.joyner@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_main.c  | 42 +++++++++++++++----
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_main.c b/drivers/net/ethernet/pensando/ionic/ionic_main.c
index 0971ca4d6650..708c7e4c578b 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_main.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_main.c
@@ -190,8 +190,8 @@ static const char *ionic_opcode_to_str(enum ionic_cmd_opcode opcode)
 	}
 }
 
-static void ionic_adminq_cancel(struct ionic_lif *lif,
-				struct ionic_admin_ctx *ctx)
+static bool ionic_adminq_service_or_cancel(struct ionic_lif *lif,
+					   struct ionic_admin_ctx *ctx)
 {
 	struct ionic_admin_desc_info *desc_info;
 	unsigned long irqflags;
@@ -201,9 +201,29 @@ static void ionic_adminq_cancel(struct ionic_lif *lif,
 	spin_lock_irqsave(&lif->adminq_lock, irqflags);
 	if (!lif->adminqcq) {
 		spin_unlock_irqrestore(&lif->adminq_lock, irqflags);
-		return;
+		return true;
+	}
+
+	/* Service the CQ to pick up any completions that the FW has
+	 * sent but NAPI hasn't processed yet.  This will call
+	 * complete_all() on any matching contexts, including ours.
+	 */
+	ionic_cq_service(&lif->adminqcq->cq, lif->adminqcq->cq.num_descs,
+			 ionic_adminq_service, NULL, NULL);
+
+	/* If the completion was serviced above, the ctx will have been
+	 * completed and its desc_info->ctx cleared by
+	 * ionic_adminq_service().  Check and return not-cancelled.
+	 */
+	if (completion_done(&ctx->work)) {
+		spin_unlock_irqrestore(&lif->adminq_lock, irqflags);
+		return false;
 	}
 
+	/* The command is still pending, cancel it by clearing
+	 * desc_info->ctx so ionic_adminq_service() won't touch
+	 * the caller's ctx after we return.
+	 */
 	q = &lif->adminqcq->q;
 
 	for (i = 0; i < q->num_descs; i++) {
@@ -214,6 +234,8 @@ static void ionic_adminq_cancel(struct ionic_lif *lif,
 		}
 	}
 	spin_unlock_irqrestore(&lif->adminq_lock, irqflags);
+
+	return true;
 }
 
 static void ionic_adminq_flush(struct ionic_lif *lif)
@@ -444,6 +466,7 @@ int ionic_adminq_wait(struct ionic_lif *lif, struct ionic_admin_ctx *ctx,
 	unsigned long time_start;
 	unsigned long time_done;
 	unsigned long remaining;
+	bool timed_out = false;
 	const char *name;
 
 	name = ionic_opcode_to_str(ctx->cmd.cmd.opcode);
@@ -474,7 +497,7 @@ int ionic_adminq_wait(struct ionic_lif *lif, struct ionic_admin_ctx *ctx,
 			if (do_msg)
 				netdev_warn(netdev, "%s (%d) interrupted, FW in reset\n",
 					    name, ctx->cmd.cmd.opcode);
-			ionic_adminq_cancel(lif, ctx);
+			ionic_adminq_service_or_cancel(lif, ctx);
 			ctx->comp.comp.status = IONIC_RC_ERROR;
 			return -ENXIO;
 		}
@@ -485,12 +508,15 @@ int ionic_adminq_wait(struct ionic_lif *lif, struct ionic_admin_ctx *ctx,
 	dev_dbg(lif->ionic->dev, "%s: elapsed %d msecs\n",
 		__func__, jiffies_to_msecs(time_done - time_start));
 
+	/* If the wait timed out, attempt to service the CQ and cancel
+	 * the ctx.  If ionic_adminq_service() completed the ctx between
+	 * timeout detection and taking the lock, cancel returns false
+	 * and we avoid a false timeout.
+	 */
 	if (time_after_eq(time_done, time_limit))
-		ionic_adminq_cancel(lif, ctx);
+		timed_out = ionic_adminq_service_or_cancel(lif, ctx);
 
-	return ionic_adminq_check_err(lif, ctx,
-				      time_after_eq(time_done, time_limit),
-				      do_msg);
+	return ionic_adminq_check_err(lif, ctx, timed_out, do_msg);
 }
 
 static int __ionic_adminq_post_wait(struct ionic_lif *lif,
-- 
2.17.1


