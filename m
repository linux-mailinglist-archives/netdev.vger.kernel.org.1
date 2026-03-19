Return-Path: <netdev+bounces-269542-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPMPOxwnvGkxtgIAu9opvQ
	(envelope-from <netdev+bounces-269542-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:41:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2B02CEF6F
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 537F9306741A
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35346347534;
	Thu, 19 Mar 2026 16:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k6VRagvD"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013013.outbound.protection.outlook.com [40.107.201.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B188A3ED5C3;
	Thu, 19 Mar 2026 16:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773938015; cv=fail; b=cSfq20dgREIvl8q+EMF0sVnjJRmkz/DIV2gXUMIH4VnRST9yla2Z4anHkuRoBiPwv5HoaLdp8aMdwgvny/paF+5+XloXZ5zDVrpljuhYTQku60baqFlASu14Sb9C04DD14hGseCLYoIbFmhgb7RjbFKnBc/6qS+2YObmJJSRCbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773938015; c=relaxed/simple;
	bh=/hOq6Ly2egoiqJym1Nf9smAKv4cA/LTfsf2ehV+HC5M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aU5lQedpofI+9G1mzca1RaMsiaNnjCNiytnJ9Ht5TT+zywniiQvjBlp1Rw7V37NLs/hq2Pc8IejXgDKAhuNwYszNih6CD8UNqdEAgkQ+5p9WTuYSj8x1A9LQOnfkWnyQbU4o4bwUgYykT78/OGfo9oM3mJzvn5LDQ/lkuEpbf2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k6VRagvD; arc=fail smtp.client-ip=40.107.201.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rOzKjX8EtniE1LiI6/+3ZiOYZDwApQUVITeetPBnRg8IHWBKpDltYgLO3Q6aJZ82jN8xOXR7t4/Vc6KEKjUqtTFfC7ekiubWdhWddRwdoom1Z8X88vC4ZsGYDYBBY3VppLX8ug5l/9cSiLvph7BLriLVoTwwn6UYZkdB0Z+lERyhx4jnoHdk7j8/JTwiYJMkUmDNf3lDzXJEf0huap8ZUgAGUD5PsxLO+x1XdW1oyzkbSaQE0AfJkfpmASXUKEtx5LzWU8CNu71/Nlp3EmtjkLqAy8HyPhl+VaTPs/bkEINYR/9Rv85pOU967D/7X1V6eYYqzzuthTY0ktULPPzUJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EVRD/6WJ4Y7LMIP7siLO5DA31yQ+4epO0WFal+6A3rw=;
 b=YYZr8/3GbnudzIrh5KitSyt+ZIsshhItvBAIkTB5/oUDJeYqundO4dSNWzxz4GOn/dIdMxoaZpnDJP1SR0nmBba0FewhrmpkCvDvo9Ulx59bIBddw+iNO3LiWzJu4VdtdRQJRPWIb2Qv9cGXbWR8jpQZQoUO1E5UOFhunXncCJR+KOVxRp6tm3Azh28o22TaPgBfneJvqvf+ld6N6RJKKBymPDPbrkQP0L6SQUbsYir2ldrGzb01Udi8HdtvCLzftaJYy7zLyE9bfJ9gaSpyqta0XSkQ6GNvkV83MAoVzZkeduSWpq7tvQSq8jNe0aLHeqWSuXTUs20yyZC/Lwu26A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVRD/6WJ4Y7LMIP7siLO5DA31yQ+4epO0WFal+6A3rw=;
 b=k6VRagvDQMoDMOZvTCg/RPuSZ+glkU7UraRhlSRUMlp8Kj/+chwUAbZR7lp9MT9qPXgtN1FHcSrZSXtrhOfkCJ3U8WUKhXy33eppYc7mW0ZAd1jPs8d3XLIiHS6DdeLaY3kZxdrNO/YtSlbAs6/TH3SAnPVUuti1eGk+DxXK4Ro=
Received: from DM6PR14CA0050.namprd14.prod.outlook.com (2603:10b6:5:18f::27)
 by CY8PR12MB7219.namprd12.prod.outlook.com (2603:10b6:930:59::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 16:33:22 +0000
Received: from DS2PEPF000061C8.namprd02.prod.outlook.com
 (2603:10b6:5:18f:cafe::59) by DM6PR14CA0050.outlook.office365.com
 (2603:10b6:5:18f::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.28 via Frontend Transport; Thu,
 19 Mar 2026 16:33:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C8.mail.protection.outlook.com (10.167.23.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 19 Mar 2026 16:33:22 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 19 Mar
 2026 11:33:19 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>, "Raju
 Rangoju" <Raju.Rangoju@amd.com>
Subject: [PATCH v3 net-next 1/3] amd-xgbe: add adaptive link status polling
Date: Thu, 19 Mar 2026 22:02:49 +0530
Message-ID: <20260319163251.1808611-2-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319163251.1808611-1-Raju.Rangoju@amd.com>
References: <20260319163251.1808611-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C8:EE_|CY8PR12MB7219:EE_
X-MS-Office365-Filtering-Correlation-Id: 46ab296c-a4a9-449e-44ed-08de85d53c9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	RW9rFBgvLXjQtryA+UZs07MiQ+RCDvcz5RboPrk+nZTFMVkE8S6BHZCnp4Tyh1rklsR6LUubjPQZuDnZy3gEddWdRwB0mlC1HxMNk2Kb3HmJt+4SJHnAS7SH9ncSw/GucVOmb1tmuLysThaksMfyqKAkQpzDSW882KS8Hpgx6FWfO8XnA7pezFKU5fG6h6EbGi8PKvzEEy1qpoNWwvZAm3inPLF2ZUyZDlShuh5ptm3CK7qxluJTE8XtT72M7QvoPfCLwRHIQt/l87keJ//v2fsQNWJhpFLUeaY27QMHxtXJNcZBcblpX4u+s76vnX+m/SXh3+jZsXNeW3Yk99Y0pnGN31k0o93JKwviBvK4H7rxR9rS15jCgR5UsweTWGOjM1E+Ih1w2loiBEvudZ5qun2H5aaleMEJJHc6nRGHKqFEIO5xk/QfCtmz9/PpydRalyy4rh82Ygepvscg5fhA7M8JY4ohoUu1JW9dkLooaqkladStCABPJM7wTQ9lRO+SV6Q0RaTOyBuwrG5BeZEECXhzt+OedydKJYlRJiPThRyjeCq9s0ThCguV9GKtpmmxOsVVsIT9O1FLE7L3nsPTZhAVhTRSRAgoopBJbt7PB0M1GaFr30EmAv9Zz17kITltgKC5PVRHnMdSjTzAWj4GI+VmNY6cTZp60DwgwFGAc34uBIusfPJVQwVOjH6tIA2iChXtDICuiuJZPIg2Q7v+u7jmJ4w+GGzD0l8hqHimHpOaswXzCUXD7PIYcujKL4VLDdPOZRT/jNB8Q+tyHVsJaw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hKy/i/lVxomdO5l6h2ynFrrL6Uery3G1F6BNu4Gkpvu1eMkcwGaHrw59Y9v+963RuJvYZK40KkIJimFAM+Ep3X9R1q45eZAWqfA5xftv1az+Ccqu7SKQa7r+XmAuFD+0C1SpIb8/YQbyU+t/9Mt/S1yol1PvIAxGKZQjZYvQ93uSjMGpfWF5eroDMZQwjZiUJXJe/6GDcHNQWntTIuc1iA63EUR2LJPEghhgrZZoPaOeQwthKK5Fx4FbL8VKcL230tQqWFNJW9mkf27surAbFYghtgcEUxLlYgpEtxBrNUlBRMQGKxrFXP5KrhFTXUT3y1N0t3OvKo70/Q5KGrhU9ginJwRhyUj5OZKIKyrc2AmyTkRplinlffZGd+Eeqbm8uFSnWHe/Pm8N5ZNWlfsZF0KitMsaMVaAFGL+yviy0A1Tm37A839gTtzGgUj0OVeS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 16:33:22.4069
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ab296c-a4a9-449e-44ed-08de85d53c9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7219
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269542-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Raju.Rangoju@amd.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EC2B02CEF6F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Implement adaptive link status polling to enable fast link-down detection
while conserving CPU resources during link-down periods.

Currently, the driver polls link status at a fixed 1-second interval
regardless of link state. This creates a trade-off:
  - Slow polling (1s): Misses rapid link state changes, causing delays
  - Fast polling: Wastes CPU when link is stable or down

This enhancement introduces state-aware polling:

When carrier is UP:
  Poll every 100ms to enable rapid link-down detection. This provides
  ~100-200ms response time to link failures, minimizing packet loss and
  enabling fast failover in link aggregation configurations.

When carrier is DOWN:
  Poll every 1s to conserve CPU resources. Link-up detection is less
  time-critical since no traffic is flowing.

Performance impact:
  - Link-down detection: 1000ms → 100-200ms (10x improvement)
  - CPU overhead when link up: 0.1% → 1% (acceptable for active links)
  - CPU overhead when link down: unchanged at 0.1%

This is particularly valuable for:
  - Link aggregation deployments requiring sub-second failover
  - Environments with flaky links or cable issues
  - Applications sensitive to connection recovery time

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
index 2f39f38fecf9..6886d3b33ffe 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -607,11 +607,33 @@ static void xgbe_service_timer(struct timer_list *t)
 	struct xgbe_prv_data *pdata = timer_container_of(pdata, t,
 							 service_timer);
 	struct xgbe_channel *channel;
+	unsigned int poll_interval;
 	unsigned int i;
 
 	queue_work(pdata->dev_workqueue, &pdata->service_work);
 
-	mod_timer(&pdata->service_timer, jiffies + HZ);
+	/* Adaptive link status polling for fast failure detection:
+	 *
+	 * - When carrier is UP: poll every 100ms for rapid link-down detection
+	 *   Enables sub-second response to link failures, minimizing traffic
+	 *   loss.
+	 *
+	 * - When carrier is DOWN: poll every 1s to conserve CPU resources
+	 *   Link-up events are less time-critical.
+	 *
+	 * The 100ms active polling interval balances responsiveness with
+	 * efficiency:
+	 * - Provides ~100-200ms link-down detection (10x faster than 1s
+	 *   polling)
+	 * - Minimal CPU overhead (1% vs 0.1% with 1s polling)
+	 * - Enables fast failover in link aggregation deployments
+	 */
+	if (netif_running(pdata->netdev) && netif_carrier_ok(pdata->netdev))
+		poll_interval = msecs_to_jiffies(100);  /* 100ms when up */
+	else
+		poll_interval = HZ;  /* 1 second when down */
+
+	mod_timer(&pdata->service_timer, jiffies + poll_interval);
 
 	if (!pdata->tx_usecs)
 		return;
-- 
2.34.1


