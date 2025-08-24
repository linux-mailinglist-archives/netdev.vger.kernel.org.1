Return-Path: <netdev+bounces-216292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4FDB32E74
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 10:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25B92188BBEB
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 08:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE35525B2FF;
	Sun, 24 Aug 2025 08:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Atqzo1Xg"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7ED25B66A;
	Sun, 24 Aug 2025 08:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756025081; cv=fail; b=lg9ImWZOe/5oW3tKN4VYYZo5gjR3ilSssXVyEooZ9ARtbZMu2lTVWegw3Ms6dWBKyMaGexzEXWHJ+ZgEmWNUy7trMxHNpo6PaBn5LSRIwvx3EifSxw3Y779CZ9ZzR3VpKjQurABmLJ80h3WdyFDYWUliFxQy8qeSBggEYEyJRuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756025081; c=relaxed/simple;
	bh=QJogPt28XNiac0cz5XotOkTUu/r5POzee98tmFzdDTg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l9zi2hTTIQIkJH9um1uHhGYKAK7rfnpIudZHT3jEIxIJX/ksr0ldGqJ7x5t1LTNNVYF0O78sKdnyffF5eglOWzQV/S1RjommTEzPxWILcxFGd0tPnrWt45aYDYRTjDHLl7RD2xk1yjT5QXYcnk4a76P7dAyCTJu720j57Yv9Vc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Atqzo1Xg; arc=fail smtp.client-ip=40.107.236.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=amg4eoboRsZ6o4BVGmbf0RCyXd79uyOQ0HLUXWTbI/PPYmMzdBcvhaKHa3U0sZGm41yOcW9f0aWZP/8tgipjAEMxpN4RWhq8HwMQeAJ2UnBD28VcSnM3t4lNdXoFVEgTqrs8ezFvWa+NQ7ZcAfa+8lH8cL0NSZTaG/zghG8UDPGIASBHhNUzIUEz/sUXqhJDTepcBSNPU3An7nFMHdx/G0Zl3Pe/xsEd+0xmRUeEB6usWf5MGTfKvC81yF2d6Z9/fof0KDKegwramWTVvvtv9bNz9tO1r04JSSQ6xqUqTHetXxhvIUh0rwWFZJHotokT8K1zxL5QNO7Le0eR7/T9cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ghvVq6+64GyhIqo3kmoASpSz2wHNXDVQIBUNfgiYBNM=;
 b=rqisa+Jn5mpHfoMtet9IU4JyCusi3IokM2HzltcVUjQBJArVniZz+P9xCdBDDZLIt+nf0ls7kyb1Xqj2qw6Lg0B+7Nosrqp/D06ExZ/1BOBFLHMCJaKw49Ov4Bv334Z2j1QBjBuf5zlvPhvQlLjg2slRHQOOlOt1W0K4UXjdxYbOkTtXwrxTZ31t7a8g1O1ael5ThKqJRsjs3p6MqDv8VxxCzNbD575tmqPWbx9k5cYJYUkiCIdbvMk0jOYsGVFxq238gm7QP5rnsNJno7j4tf/C/87G4TYnkH/XrlX0aM0xbXgV8ust++lxEZ3sNLkSQwc+/0gAx2EEwaZgmWoYBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ghvVq6+64GyhIqo3kmoASpSz2wHNXDVQIBUNfgiYBNM=;
 b=Atqzo1XgBlwaCEjDSPyKK3uPd4zlRmemILAeHBCfqilqRxAXdrH3RUAfhDXqWe3HLx+jQDtjLVRiDUp95FTG3HC8N30+dHZdruSLSIy2f79GSG+HIRbsuaXopKOMToIFruYzOfh5dxydNpu0dCh3RpAZ/rXRtSj8NBPukzYbERHIbSo/VsA2qU6HrR5IfXm4lF7OED8wfcJ/MFIGu8oyZxFAYLz274QPqjlfOpqlgU+e3XwiTcp0W8BqAxcjMocjOJOfzRlKdx3lMKf0SVFILXq/B8/TRs+eiQFAOHkYEReLME5RgTGZCVMz4CTfbufygClOKPV3peghdCPNFpfoyw==
Received: from DS7PR03CA0332.namprd03.prod.outlook.com (2603:10b6:8:55::19) by
 SA0PR12MB4448.namprd12.prod.outlook.com (2603:10b6:806:94::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.20; Sun, 24 Aug 2025 08:44:34 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:8:55:cafe::20) by DS7PR03CA0332.outlook.office365.com
 (2603:10b6:8:55::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Sun,
 24 Aug 2025 08:44:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Sun, 24 Aug 2025 08:44:34 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 24 Aug
 2025 01:44:15 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 24 Aug
 2025 01:44:15 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 24
 Aug 2025 01:44:11 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"Saeed Mahameed" <saeedm@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Shahar Shitrit
	<shshitrit@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Jiri Pirko <jiri@resnulli.us>
Subject: [PATCH net-next V4 2/5] devlink: Move health reporter recovery abort logic to a separate function
Date: Sun, 24 Aug 2025 11:43:51 +0300
Message-ID: <20250824084354.533182-3-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250824084354.533182-1-mbloch@nvidia.com>
References: <20250824084354.533182-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|SA0PR12MB4448:EE_
X-MS-Office365-Filtering-Correlation-Id: 02cef42b-074c-4c66-3a5c-08dde2ea736f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8km3aoNGWSk9H/zPCLM9Z+PdaObC1xG6dRN/NEHB4Z8AnGH8XeYNgWQCw3Ty?=
 =?us-ascii?Q?4ESuEyrSq/5k1LaEOccmhVo9v/e7nvML2L6c2+NQ+vgdmkNwfO9yjW8KKn36?=
 =?us-ascii?Q?YdQjKc0QxEMb8GJEWoMGuQHKS0iUMqIm/Fi0V5EklFICHvrOVFvK9jnRxuhc?=
 =?us-ascii?Q?rFSBJjgWhCxW4TfqUH+I3V1ZkyJLfXWZcPkD0QDLVZrzXP5527C4e26if22o?=
 =?us-ascii?Q?OOw/I9siyK1EPgpKZ4BYIrLSR7DcA5vhmtGRKv/njb+HqrdY1Zub0XZF/4eR?=
 =?us-ascii?Q?4bAMG7PFHboXzsaHanfS8vTiaNusCsFHImTjVjIfbYInwa6fr3kXuIMtT0mZ?=
 =?us-ascii?Q?kF1FGTllInIb1GZAb4Z2qNAL/StwP3+7vcY9d3/o89tcNyF+w9iPwRexfTKU?=
 =?us-ascii?Q?acNLP+vpYGZAdXmmrPuVk6Vx3mrsrkdeoVv3gJ7HI3WTpCz1TaCWd5/sV3kb?=
 =?us-ascii?Q?tAsUgEy3IifqTpnqz1vvXuqafCTyg6y9fWiceMRB9mpEf8xnyTjjlgRZHUT+?=
 =?us-ascii?Q?TKsKjHXTg0BsonDxsSdB3JlXz8Av0hsVETE7xF9ujgJ2UUhw6kBP19HenR27?=
 =?us-ascii?Q?AF0fYCUazwh4Bj5GHPP7RtkhlzYmFQastHOeL/FGKldRy6QC98ms03TAIbJE?=
 =?us-ascii?Q?CAae3wximF+prEvaujuvhqiMWvGuUmHFQB+RrN6cld+YflROHFNHYGJbyyKr?=
 =?us-ascii?Q?VrYqCeojXNS159zrN5UNaYIUu1Xvtkhv3rX2DEdvzTntbmGpwHcmWknvjY4Y?=
 =?us-ascii?Q?TjapHkuw3Van2eHRJOQbcY6nzgVBvx8LSUysHADHDNf0CjTPgEeyjpE0xWUz?=
 =?us-ascii?Q?n7esSO8GCv44A7vXbp0x0DytQinz/bBstdpoI3NPR2SDWegkj37hnEZOxMk2?=
 =?us-ascii?Q?tM1CljrWeK00tXbaJGUmkzeXJ4nVKdGJv+dUuWhPaWZXUTRQP6J9nLrlH0pb?=
 =?us-ascii?Q?Rwl1Xft9C85RYojHYFuJ4E6S3afY9moRaLXkQPhBkBDzFmqdbdvTMzJI+AtA?=
 =?us-ascii?Q?SIy8veCfsVgrRWdYpTZMxHyg3DseG0DS7/zkCLAKkjUCaVmLSiJb6khrlqzx?=
 =?us-ascii?Q?XOneIu+ArxV+6NbMQu5ztJTq+zKyp8W3gQxuiJYYjK7PVx/3RDuaLKQBDUqq?=
 =?us-ascii?Q?Qd5vex2y2Dz+Z6yFHy14YdcNS64bN2UbA3ltvpB/A5xIxQsSjjYJVrkhpzfE?=
 =?us-ascii?Q?P2NaP/68cFsvYl/dJY3RgSD7oVtDMQS8MNBHY+pgA4amo3hq7VkzrwRxfmu2?=
 =?us-ascii?Q?wuyuInoLVAqLgo8LCCDlp2a2INg9y/8HRKf/HoBo3bsj9Ou1nTcqO3gL85cB?=
 =?us-ascii?Q?9l+LJ078ChLEh9QoMIqgR/n5CSOT7/VwD38FUv6EfFPUIxq4dH3NsDGYcaZh?=
 =?us-ascii?Q?01IVRuNItgRkeT0hGuCLr57/psYIOPKLEnJE+ZeXtx3k/Fvxg3Lg5EgEPfHk?=
 =?us-ascii?Q?1htC5ZWQXTnIZ9kmRYaWmwikssZoEGij2VXr9RC7fq/C9RCIoAx6fhmDwbdT?=
 =?us-ascii?Q?3P3OWWcszZCViCaQAj3k59q7t/s7jQm2C3Ly?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2025 08:44:34.2272
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02cef42b-074c-4c66-3a5c-08dde2ea736f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4448

From: Shahar Shitrit <shshitrit@nvidia.com>

Extract the health reporter recovery abort logic into a separate
function devlink_health_recover_abort().
The function encapsulates the conditions for aborting recovery:
- When auto-recovery is disabled
- When previous error wasn't recovered
- When within the grace period after last recovery

Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 net/devlink/health.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/net/devlink/health.c b/net/devlink/health.c
index ba144b7426fa..9d0d4a9face7 100644
--- a/net/devlink/health.c
+++ b/net/devlink/health.c
@@ -586,12 +586,33 @@ static int devlink_health_do_dump(struct devlink_health_reporter *reporter,
 	return err;
 }
 
+static bool
+devlink_health_recover_abort(struct devlink_health_reporter *reporter,
+			     enum devlink_health_reporter_state prev_state)
+{
+	unsigned long recover_ts_threshold;
+
+	if (!reporter->auto_recover)
+		return false;
+
+	/* abort if the previous error wasn't recovered */
+	if (prev_state != DEVLINK_HEALTH_REPORTER_STATE_HEALTHY)
+		return true;
+
+	recover_ts_threshold = reporter->last_recovery_ts +
+		msecs_to_jiffies(reporter->graceful_period);
+	if (reporter->last_recovery_ts && reporter->recovery_count &&
+	    time_is_after_jiffies(recover_ts_threshold))
+		return true;
+
+	return false;
+}
+
 int devlink_health_report(struct devlink_health_reporter *reporter,
 			  const char *msg, void *priv_ctx)
 {
 	enum devlink_health_reporter_state prev_health_state;
 	struct devlink *devlink = reporter->devlink;
-	unsigned long recover_ts_threshold;
 	int ret;
 
 	/* write a log message of the current error */
@@ -602,13 +623,7 @@ int devlink_health_report(struct devlink_health_reporter *reporter,
 	reporter->health_state = DEVLINK_HEALTH_REPORTER_STATE_ERROR;
 	devlink_recover_notify(reporter, DEVLINK_CMD_HEALTH_REPORTER_RECOVER);
 
-	/* abort if the previous error wasn't recovered */
-	recover_ts_threshold = reporter->last_recovery_ts +
-			       msecs_to_jiffies(reporter->graceful_period);
-	if (reporter->auto_recover &&
-	    (prev_health_state != DEVLINK_HEALTH_REPORTER_STATE_HEALTHY ||
-	     (reporter->last_recovery_ts && reporter->recovery_count &&
-	      time_is_after_jiffies(recover_ts_threshold)))) {
+	if (devlink_health_recover_abort(reporter, prev_health_state)) {
 		trace_devlink_health_recover_aborted(devlink,
 						     reporter->ops->name,
 						     reporter->health_state,
-- 
2.34.1


