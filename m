Return-Path: <netdev+bounces-235967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B94C37846
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 20:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F1493B8BDA
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 19:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25573334C0C;
	Wed,  5 Nov 2025 19:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FEYXp7+4"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011016.outbound.protection.outlook.com [52.101.62.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D0525EF87
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 19:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762371569; cv=fail; b=Dwi6ghd3uh2gFOFkBdrqIV5nfvyXW/uIH42n8WDph6jzy5rm8TxGMssHk91hemC6rrHT/7+RMm3I1d40Hfeym+uMCNBdAwG50QB5Tp8+DID+ym6iILQ+whkP964gzHCgZX65ABhcZ/5shawsAiCTHbgECAyeOtC8N1EozkVf4zw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762371569; c=relaxed/simple;
	bh=phlgpKbbLtg9ulKV9prFRNypUp/4zGiZdLLur/9HFOU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uyZKBpeQkPgQItkvIG6aPa4dGYuNKb5gk1BQIiCdf6MsCoikz/NsX2UP+/2gn0ziooaOgM7d3bu5X6WzAIh/yVmA+lmSfyZNGRjPYOg2TcJVIJHB5GUZjO7XLfN9iR9MCAPWRfv0NgXAYensALbPFgJzEhW0TS6BKvBxqXLevLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FEYXp7+4; arc=fail smtp.client-ip=52.101.62.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bGBssHwSW+hpAb65Wy9CiHSB4umOxqXoeQEwN3zZRWk2fJgav2K6vBaU4urdJbK1838uI24lMVYCD+g+rQfgXBC6qhcnbpnm8uYzrpYv9uWKho92alEby6hcYixN4gnJIuRA26uKooE6ASb1cnJl5sJJcDMRzSWXxsoct3Sy02J+gU8A/Fg7V9bCrg2l/gTRvJzjx+e0B47MIGAKtMtxIMs4jqJ0Qf+ialfaVsKnQT4kaeKcIkE3pJhrS9fZx6kgfvy1UVLnx51HP30jsPbLDoHYCt/5ydtF4mgXBc1l0JwFXpvZkkHD+Qk09VSagZ3UOdT0VQZNTcmNGpr1regrwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZjiWeE/+0pnbcloSTKyTCud5FyJxyWBmpEOBGxr3LOY=;
 b=u0z8TI1NqIW5iehL+0bBsqjtc2YK3edDxZHhD3K1otq+S8tBKJ6WVEvWUAByzX1utm9y4VdrhGjLmE+dm3f2WTpSUBLvl/BgGeEJrDsP3WFTqepET1CNtWFs4cno9j4GRKWefZs5/FV8l9MXK4jhDGNe/bvPA6xx6AhkYqe48GGbG0/zv77qjL24X6nQ2o0e4gViCaV/E0NMJyWdEKImuRDantveQNvVFZ/6q3pJfk54qQAzuaQzBzc/bFlyw/vpNjLwi92L2n2Jj/P/KZSm71bVyyB/QH6+obKAcHMbCT5J8MYglg88/NXiQHaJvSDcFyEWW3oy0PcbV902zkLapg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZjiWeE/+0pnbcloSTKyTCud5FyJxyWBmpEOBGxr3LOY=;
 b=FEYXp7+4GES7JYYFIepz0eZ+55u+WU5nUJsoqPXpESa+Njrgi1iDgM7sdNdb5QH36jwpY7AdneaK1xD7Mt2bwnb2nbkKGNKWqqO/jOj0rMxSdGgiJHVyAbpS0t1zHMxt5u8IVMX9gKuLU03eVbv1+SdiGQyvGKsGyroZZfgN4RMOOmYIFWRdqVXz+u31BysnsdHfCGOu4vxG5WOXJ2vVye73ns8ZLLsxJzf6o41xp+eRvJgkzY56RG4mA5BuARL0MfYA/mNUioowuKZ3WaoRrvmFquCk0mJwnDhPb2Tu35h5G6do26La2QwAAK4+xRlFKgvWHNM7fmxTX2bdT3dZug==
Received: from LV3P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::26)
 by DM3PR12MB9287.namprd12.prod.outlook.com (2603:10b6:8:1ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 19:39:21 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:234:cafe::51) by LV3P220CA0005.outlook.office365.com
 (2603:10b6:408:234::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Wed, 5
 Nov 2025 19:39:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 19:39:20 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 11:39:05 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 5 Nov 2025 11:39:04 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 5 Nov 2025 11:39:02 -0800
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
	Gal Pressman <gal@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>
Subject: [PATCH net-next] netlink: specs: netdev: Add missing qstats counters to reply
Date: Wed, 5 Nov 2025 21:40:10 +0200
Message-ID: <20251105194010.688798-1-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|DM3PR12MB9287:EE_
X-MS-Office365-Filtering-Correlation-Id: 308c8e79-a4f7-4dcd-e5cf-08de1ca30432
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?omvNmeCi6naKP8yWbyLB6ZJ2oRfi8JnqNbuQ0sW/jcNemFNFeb4VFjG3n7Y4?=
 =?us-ascii?Q?qNmKOGaAqC88wJcWaikRUU2sbIkjqwktlUwFhy8YwFXUu+9IXIMkLhDiHRlh?=
 =?us-ascii?Q?ZtaX0ZAQC6tdkS9b+Pu1I5UNbTBfqDVIaHkTI/ihCNFqx84bqMB5nGO6gMOO?=
 =?us-ascii?Q?ljqxEN1bOI+NPI7YVaOD2dew69E14HFdsLtzQV7IXFcpJJlYEiRCElWXydKO?=
 =?us-ascii?Q?YNR4cx8jGXAE/cEMtTQ+4rpwPvhlRDw8PPk0RhM5aX7fCf7NsfhZVucNxpr+?=
 =?us-ascii?Q?AIyEBbLMUjTmvc1DRXx1ischa3mPw75Wa0o3zOOFQkQP/G2V0cW43+qQCtZR?=
 =?us-ascii?Q?JcJtvdis1Jw14vvrK5YvgG7H4HqaPiLuOAaysD5C60+dR1uHAgdYpuCrFCiP?=
 =?us-ascii?Q?pgOW1Da84eB/T+R6Afp/e2k+slQk90oGf2CM6TwbKGLmyMavMTnEQ7yCWTlR?=
 =?us-ascii?Q?rzMPhV6t6uhJF+zRKQWQZLaMUX+KQshg23iUzHdNlQzX1mKFcdQSHf3hRirD?=
 =?us-ascii?Q?AUvJVh4fc1lYcCpECN3dGD9Yq7OhC+J6YeBZnjV/pbYLY2KUpUqV9q8dpg3Y?=
 =?us-ascii?Q?MyYCm3Rij0xWuAzl3j6+5kEZ5LlHuNfMuQQaXndYyIEr0nW4742L1XZL37cc?=
 =?us-ascii?Q?9f+9Q3l8qqgRFjAdexzie+L61xJ1fc4V9BeRQlxTBTzAJOwIiS1+7UPc7Jw/?=
 =?us-ascii?Q?g0JQYIygfCvVXrBxhpgSFgp5x1v0vn6aTwSY9nQNJ6NqA6mnliaR10cxrrCs?=
 =?us-ascii?Q?p3zQNcjlzzc6/o+5c7/1LPp/haNUubVXqlMfHX5qu1e+ZKu6VL1yihB3JIYm?=
 =?us-ascii?Q?1WdW2qe9XkrhR2LB/4btqxHoUpXFMS3RFLy4aGGlYyO1gmzOYp3WPu2Mn71o?=
 =?us-ascii?Q?qKu8Y2aFXMrDcq3L6IBv8sZPYwoYtWaKSgBY+7K3NPizGnzOqVYmDwlYMbeA?=
 =?us-ascii?Q?UOHTOnbwW+KZBOyo+hJZa9LkoaJF3xDZNfjdGzaPVgmkjVSx2joMuSIgah+7?=
 =?us-ascii?Q?wGbt5jGn7wG0MSPoW4tFWQn7y8SBiqZZOv1fNzohaDaKWaxRHhkI0yRWKqDM?=
 =?us-ascii?Q?5Mt3SZNH+SwCikk7kU3N3B1egHnfBDAtVaQLVHeUsoMVwDwG89wvr9Na6+/B?=
 =?us-ascii?Q?TgXrvHM+1A/3yIUNwtBB2zAp/E1oN2eiR9Ia9BNk9eftdEp6xtweraWJcQ+B?=
 =?us-ascii?Q?riEtSAyJf6zpw8i0JVax8o5lhrqW85zdADZQbUMxyi9EoA8w/sBwctJM90VA?=
 =?us-ascii?Q?KQAPaVO9o6NBzEfqWlxAMR5ENJ8t1uedbvsx7JUgiC09UUgOd23ywm27Ic/q?=
 =?us-ascii?Q?+vCo23amN72XtoMbFKynbkietoytFKixxo5ISP9+stu24Y7wxGg4/VyCXByv?=
 =?us-ascii?Q?T5fz2YsTaSyr7YHcJSROiXyFMZKbNPPxUByNHn76Rr6S5DPcaFIJ7o+9sNlO?=
 =?us-ascii?Q?NWGU42rrK5VAXYH1pu+mgwm5Wh9zPOh9X7WXebdNhdPrKUXODwoug2XAC2+G?=
 =?us-ascii?Q?fm4kkTFoN18frS4m2sGmzrPnqR/HkhzYiO581/zRmd+Gz0jkOMQzQdH01M0M?=
 =?us-ascii?Q?U/nSYnDj42CdE2k1rXY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 19:39:20.7122
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 308c8e79-a4f7-4dcd-e5cf-08de1ca30432
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9287

Add all qstats counter attributes (HW-GRO, HW-GSO, checksum, drops,
etc.) to the qstats-get reply specification. The kernel already sends
these, but they were missing from the spec.

Fixes: 92f8b1f5ca0f ("netdev: add queue stat for alloc failures")
Fixes: 0cfe71f45f42 ("netdev: add queue stats")
Fixes: 13c7c941e729 ("netdev: add qstat for csum complete")
Fixes: b56035101e1c ("netdev: Add queue stats for TX stop and wake")
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 Documentation/netlink/specs/netdev.yaml | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index e00d3fa1c152..29b8290ebab5 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -732,6 +732,29 @@ operations:
             - rx-bytes
             - tx-packets
             - tx-bytes
+            - rx-alloc-fail
+            - rx-hw-drops
+            - rx-hw-drop-overruns
+            - rx-csum-complete
+            - rx-csum-unnecessary
+            - rx-csum-none
+            - rx-csum-bad
+            - rx-hw-gro-packets
+            - rx-hw-gro-bytes
+            - rx-hw-gro-wire-packets
+            - rx-hw-gro-wire-bytes
+            - rx-hw-drop-ratelimits
+            - tx-hw-drops
+            - tx-hw-drop-errors
+            - tx-csum-none
+            - tx-needs-csum
+            - tx-hw-gso-packets
+            - tx-hw-gso-bytes
+            - tx-hw-gso-wire-packets
+            - tx-hw-gso-wire-bytes
+            - tx-hw-drop-ratelimits
+            - tx-stop
+            - tx-wake
     -
       name: bind-rx
       doc: Bind dmabuf to netdev
-- 
2.40.1


