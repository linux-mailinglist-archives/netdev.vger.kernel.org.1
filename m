Return-Path: <netdev+bounces-282293-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGAOCOjB8WkbkQEAu9opvQ
	(envelope-from <netdev+bounces-282293-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 10:31:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D3E491341
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 10:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 705B5306C7C4
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 08:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83B13B38A0;
	Wed, 29 Apr 2026 08:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="w8bLYPAZ"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010021.outbound.protection.outlook.com [52.101.46.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2BB3B2FF7;
	Wed, 29 Apr 2026 08:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777451316; cv=fail; b=VpaJJXkmfM9YV2faECrCdC4JjBb5QAAxRZyCUeKiBiI2OrTMPjLu2MGaEmhgOvp84hp63G6sSGg0QowbBw8rwPAt7Aq1UkkqT+104DGD6EGvYW1FbjnRlEeOkHm00iCStQFijM6RgjbRF49EPIlGlEV0dSw42W+mQLZF1fLTvRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777451316; c=relaxed/simple;
	bh=lvjSDfcb2Y1ztc9VPo6EKI1IXVIKeLA2H29VctK8gMg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=cPjq8YpfCrdxa+17U7w1YtEQTue4BEJJniQJ5J8L5QNC0QtY0XmwN+0oB0zI0crf1BGiWHhlQhs9ZbY8tW6kfAfxJKHOK1jiwTulNDLA81R3IJXGN1ABKUjoEeEUwxzI/sX6b0o3+VmlnrR7vjUzzhvtqxCNc05+qfzw6cVqoFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=w8bLYPAZ; arc=fail smtp.client-ip=52.101.46.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X0rH00UpjvY9ObJe5OCt4lpLv2SI25BR0gRRELhwOtUrZSAppigfMwfgmapN+jl7CvUf/4Hgj8gktqlC+JQ+Ce/cHR2SmsjLZGgfYZ1FIpFcUyU1/VrxoUuVkM2/aIY/on/X8soInqvZ9BBqfEUA09eKaW8kSaKzQuwonjTi0lGGUuDIlF/NO6+tOJ/qBhCZ05v0hYfu9QhIc/lqDNH18fAT+WIxDM1CUUBWpZi234FOIP4W4GvKkTsUnQaRsvw/JesZLMldHusyXNh8WvxOonzzHcJKOH1/shP28n0X4UnzG0m188/P4HvgtGKpK2DlO9LQ12PNTrgRU+Gb0AuwHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kA50v06f2ifm3RKkLEsxz198BeVK6Y+WcbsqFDaU3FA=;
 b=jQWH3j+bAzVk/LtggjK5Gblzw+TDTUPlr8Td3hJCIYL3y8IxJ1Lpm6P686elV2rHQTaF2StBjskXdh1K0ShrmR1+bKmqQoPhIKJeYXRtihyC1WI68aQdmO20Wa1dukuIvMOQJuh93V1SQV8NLfCnaRSqpLXFkhBEp4wDv7RnN0B5P9rHz7lDUEk4C2//9E/qal7aZnlmSYMFSu8MiV3ugD5sAU8wsDcN+x7ZCkXPfjTmRWxJG0D73C1F0xEm4Rw6u+2V4ASaSNED/TKiwPV0YZ3ga/Ex/bD0EZ3lX0CTmcs3MhxNVRTeYrCH7ZBAl+9HZKlltJ6YL3YHgJfNztPGGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kA50v06f2ifm3RKkLEsxz198BeVK6Y+WcbsqFDaU3FA=;
 b=w8bLYPAZMD5UFzh5fuiJSDn8NMx5V1C3ad4HVB/8KSIbqPTdWZaHptaGByi5j2mK2moJjtj/R+aPjNv2b2/R93xcSsguoERbM8Nt5pl6qye5BvRhV2Ht0o5FH93N1zd4ZoELl3kePPx6f/ktCI+tG9oKEsK0cHQO5Qgz7Z0s7cY=
Received: from MN0P221CA0014.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::34)
 by PH8PR12MB6747.namprd12.prod.outlook.com (2603:10b6:510:1c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Wed, 29 Apr
 2026 08:28:28 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:52a:cafe::3d) by MN0P221CA0014.outlook.office365.com
 (2603:10b6:208:52a::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Wed,
 29 Apr 2026 08:28:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 08:28:28 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Apr
 2026 03:28:26 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
Date: Wed, 29 Apr 2026 08:28:17 +0000
Subject: [PATCH net-next 1/6] pds_core: add support for quiet devcmd
 failures
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260429-b4-pldm-b4-v1-1-394fafba526f@amd.com>
References: <20260429-b4-pldm-b4-v1-0-394fafba526f@amd.com>
In-Reply-To: <20260429-b4-pldm-b4-v1-0-394fafba526f@amd.com>
To: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva"
	<gustavoars@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>, "Nikhil P. Rao" <nikhil.rao@amd.com>,
	<eric.joyner@amd.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|PH8PR12MB6747:EE_
X-MS-Office365-Filtering-Correlation-Id: e9fe5a5e-4684-4c3c-e28c-08dea5c94a47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|7416014|82310400026|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	i+HXB3oOQ/3s8pux5M2HtI6ryxrj2lbZDV/QUZ2ynzgikoSgxXZh6y5jZQ8tCcdnJi/dhFwobLODM/kGifBjQIBkA4pFh77rXfgKjpOZIq5kQ9MlMEwiAevbvyq9AwS80/DghVUcIGJM+9v2Tux+0LDiadL0f8oXRRJROQRMXiDx4Dmo4Pq+UciQ7O56/bwuI0ZxQxjbNI0KRD1uL45LCIjp5hwwqppp13Q5STNlRiMAq457zzi+aDNJRvArFDc6vW4Gfe5xN7FwbgjUH/wuzxtJP1jwjnSe+LloSXxiy1/JqnIKlnrUO9T26Xxxs1cxt/YkrT1Z3lw+36ni8T5zptMFjmI0CmDQ5HAbHrwRz80zcZxzJYcV0IyIHn4SGi3RICVib8mZnc5V1hgAIpE+oDtFrEc6WvdN2qMB2DP93Q3iXkbsBr3WaGkYo4t0+ioZNmeXzwA/fcojcv83UNPOWgNzw3gdhGiwjChcDssg1++mGT9FAdaYeZRkupaegVheOHpjWCEBQ6FUBZtLOYi3O3hD+Xi9bWwbbgH0uQolhKuCQC57I8tyO+0/qtWRepEN+0Gkl2k0ztGuuHHgMdDO/I6WBguCDJvtsHdafizuNy2dE27C7iZeO4yan0pVQGq0Qo/QsqT0gaHWzd1eHFFzfohFPCFGEX8hEI/VT+zQtFwwdHLt5Xja9EQkLBo9x3yDbZWaJvVEkJzzZfYZWZ8u8nb7pnzcj9C2NpFlktfG6eIxp2IKKZQsrzm8GCu/5b9tFKiZLkK+A8K0NBtatGEHBg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(7416014)(82310400026)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GEkkrlJU5RNB5KGh2UPWvxzsKHh8xNT0okbDdQ4FHY1y2eKhw3c0WPhLyrtfkJ+y16+a133fvDdTFAgzdcPVZ1Xg5cE5pXl+mgTNZk2a7aWfqZ5E/vxddsqvAqOl26J9eIo8Rx+iIqtioAB/G5Sgpye74g01U4xIe4OMBjVavYyQa0AqG13kAwnk3Dcq6cBaR6UywDZ6EV0nY/jVKP+hB1M6IhY0D/PaHuA1DIoEDhPKWt1HSfhEHhIvg4a8trxO5VGmiFx/ockOhJ6KroE0NYTf6j4vPnfVH+3yDKwhOU7iNTV65+jb55ssuidbIcAlqoZOrCatoMg0IWBEXjnfEQbGhU4v5aBKFNGhvpiwFNonLWA0/jfjGP63X4OqyAGbGkh0jsnmuWPa27yxNACC9Ph/Jfn5MenXvmt6nJjOA9yFPh+9wJdHgsRdWAPVK6w5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 08:28:28.5981
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9fe5a5e-4684-4c3c-e28c-08dea5c94a47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6747
X-Rspamd-Queue-Id: 63D3E491341
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-282293-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,amd.com:dkim,amd.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

From: Brett Creeley <brett.creeley@amd.com>

Currently there aren't any use-cases that require special handling
on whether or not to print devcmd failures. Specifically
non-generic failures, i.e. not supported failures. Add support to
allow these messages to be suppressed. This will be used when
adding support to negotiate PDS_CORE_IDENTITY_VERSION_2.

Signed-off-by: Brett Creeley <brett.creeley@amd.com>
---
 drivers/net/ethernet/amd/pds_core/dev.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/dev.c b/drivers/net/ethernet/amd/pds_core/dev.c
index 2e1d0d01d03a..5b86d6cd0ac3 100644
--- a/drivers/net/ethernet/amd/pds_core/dev.c
+++ b/drivers/net/ethernet/amd/pds_core/dev.c
@@ -126,7 +126,8 @@ static const char *pdsc_devcmd_str(int opcode)
 	}
 }
 
-static int pdsc_devcmd_wait(struct pdsc *pdsc, u8 opcode, int max_seconds)
+static int __pdsc_devcmd_wait(struct pdsc *pdsc, u8 opcode, int max_seconds,
+			      const bool do_msg)
 {
 	struct device *dev = pdsc->dev;
 	unsigned long start_time;
@@ -172,7 +173,7 @@ static int pdsc_devcmd_wait(struct pdsc *pdsc, u8 opcode, int max_seconds)
 
 	status = pdsc_devcmd_status(pdsc);
 	err = pdsc_err_to_errno(status);
-	if (err && err != -EAGAIN)
+	if (do_msg && err && err != -EAGAIN)
 		dev_err(dev, "DEVCMD %d %s failed, status=%d err %d %pe\n",
 			opcode, pdsc_devcmd_str(opcode), status, err,
 			ERR_PTR(err));
@@ -180,8 +181,9 @@ static int pdsc_devcmd_wait(struct pdsc *pdsc, u8 opcode, int max_seconds)
 	return err;
 }
 
-int pdsc_devcmd_locked(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
-		       union pds_core_dev_comp *comp, int max_seconds)
+static int __pdsc_devcmd_locked(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
+				union pds_core_dev_comp *comp, int max_seconds,
+				const bool do_msg)
 {
 	int err;
 
@@ -190,7 +192,7 @@ int pdsc_devcmd_locked(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
 
 	memcpy_toio(&pdsc->cmd_regs->cmd, cmd, sizeof(*cmd));
 	pdsc_devcmd_dbell(pdsc);
-	err = pdsc_devcmd_wait(pdsc, cmd->opcode, max_seconds);
+	err = __pdsc_devcmd_wait(pdsc, cmd->opcode, max_seconds, do_msg);
 
 	if ((err == -ENXIO || err == -ETIMEDOUT) && pdsc->wq)
 		queue_work(pdsc->wq, &pdsc->health_work);
@@ -200,6 +202,12 @@ int pdsc_devcmd_locked(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
 	return err;
 }
 
+int pdsc_devcmd_locked(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
+		       union pds_core_dev_comp *comp, int max_seconds)
+{
+	return __pdsc_devcmd_locked(pdsc, cmd, comp, max_seconds, true);
+}
+
 int pdsc_devcmd(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
 		union pds_core_dev_comp *comp, int max_seconds)
 {

-- 
2.43.0


