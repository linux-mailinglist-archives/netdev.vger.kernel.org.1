Return-Path: <netdev+bounces-216291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAF6B32E71
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 10:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60E52246479
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 08:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B4125B1DA;
	Sun, 24 Aug 2025 08:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KNNhUPCS"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5446E207A22;
	Sun, 24 Aug 2025 08:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756025057; cv=fail; b=pyl2/ktOTOSTEY+YFaYeAQstB61+NK182SsNfef34DAlustiAovDvEQu41L/uxYgvj01p/JnTzRIScXcQ3bTbxYU5nDc7l3c9wp41v11ieUIEhM11OX6+q+7UmFRP/IcYH24xP2jTUpLAMRK6jSAWuFS0PmBLNpjXsb3lWrgPNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756025057; c=relaxed/simple;
	bh=2u8gT9y8m/kp9ZBl4n0UutJ9zhVAodHVEGeqvqweSi4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pZ+sqgdbFD208/6aWxLsVxlVifqSPv15Y3NqGV+DF852fK8SC4PtMGIHn6NtBoE7ZEVHd6jAqFU5KRxPE9oSfRiHTMcHUONdb3C/w0jzeZbcGJunUVc6dg/wCTrkCUM2c8zXOGSq+vOvZrMrCvBZjvEd0fkWmni5A8rXUCC5Vxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KNNhUPCS; arc=fail smtp.client-ip=40.107.244.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YlRMP5xVWRQpZUbX7YS83BarXmIJhJzIZtPVEFpLnai3fF9BIdmSguVoO0OnSh51qtd+zWMkRFn3EWnFlYmgFQd6sksUTo1TTOv4msFFvUUmVdNf7DKsGpzvDhTyVE9jPZ2y28zVE/XRiZhWXLcbH+7YrjXYX3bkrG8LCkhzsSYt4u7MAOIXwjc27ZxgJKS4cUVWOOQ7aKIjz+Apq04SW6ZDem9+UXmMm7m+4sYARS7gCQYVIbGKbD/P8hWIDMQBGXtxm6eDvo0Ov+0jlqNz/9Pkdq62grJ9LnREYbDAEg32lXIoAqYBvAnStp2AnxO/E3AGW+Klt3DjBHP2vMYf7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8fRz3MeFofgK+fSDbv+LppRuCmpo9vsrHoEG/Kr1s2Q=;
 b=XntanroCoxJ1TXt60JWsvJE76h3vgGigpALZvi2r5bXwWv4HquzNXXoJBWOB4VO/MaxdKwCbyd44g/lcMxNxmWHYstdUW8CSI+WuU2JUrHhFIyGRW47clzP1jtTtSTNfJ0lVd5CgR44HjBQmaacwnBrp6ymxqzf9g33+cbHczlR8i4FHoQqWU2OLxxgHrkwe5ixgIKsDBARKzoY5L9mqd0Yvaa4gFJP9FP28K0/oX38ggXiDNlNYPvLLjDkji2hgfCqe4aFGOyUD0IovXn7J7k+uGT9ds4ec8rUWzzmgCxeWbYXNPH+na6b8/QkTDXRQ3y8aoYWU6qMVM4KNFbArvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8fRz3MeFofgK+fSDbv+LppRuCmpo9vsrHoEG/Kr1s2Q=;
 b=KNNhUPCS3KhhhdYxFBefnSxLxNuwxyNNUHXaca6409o41EUaTIDd++386ybadVG1YpLj+1yrB2tQgiNDV4F7pEUqnAyVwO3Zc8DUzoKFdS1jM/Dy175mClzaIRalUohGTeWQxeF5RSFsIcXCM4mV27F+tlbPVi1gTzMKajmvqb0T9oo7PMPvjDqSxBJ8YCw2Lu/uj/h4mafc14avPAOtR73lNVQfH5QcfdGuOcbpZlv8aJp5ApVJ2iswx0hiu3Ca8ay39iEd5ixNrFtxl+t4tKOAi+XAOk/NsRk3bJpOuaR4gXJZ2IbysDaWM88xAkYg/bto7Jt8Bedaf/IlnUYsNw==
Received: from SJ0PR03CA0267.namprd03.prod.outlook.com (2603:10b6:a03:3a0::32)
 by LV8PR12MB9182.namprd12.prod.outlook.com (2603:10b6:408:192::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Sun, 24 Aug
 2025 08:44:11 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::bc) by SJ0PR03CA0267.outlook.office365.com
 (2603:10b6:a03:3a0::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Sun,
 24 Aug 2025 08:44:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Sun, 24 Aug 2025 08:44:10 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 24 Aug
 2025 01:44:00 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 24 Aug
 2025 01:43:59 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 24
 Aug 2025 01:43:56 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"Saeed Mahameed" <saeedm@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>
Subject: [PATCH net-next V4 0/5] Expose burst period for devlink health reporter
Date: Sun, 24 Aug 2025 11:43:49 +0300
Message-ID: <20250824084354.533182-1-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|LV8PR12MB9182:EE_
X-MS-Office365-Filtering-Correlation-Id: 036b6a64-a004-4443-a4e3-08dde2ea6570
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NFprVnk5UTBCb3E5T3dhV01LdXlxZm9oVGd6dEtWbnJKM3NLdmQ4b2VZNnl1?=
 =?utf-8?B?MXpvRzN3aGRkdUhkRzlCR3N4WFpwRkdmalJCWlhuMWpxN0FBdU5yMW9ocC9U?=
 =?utf-8?B?OXNIaDBZanJBVWtwTFliZkcxU0d3SkdPMlNOVU5YQkNWQmZOZ2diUEZQQ3FS?=
 =?utf-8?B?ZEhiWE5zZll2Z1lKMjdCandROFlWOXJXeDVDS1Y1dVVWWmlPbXI1ZS9xemZi?=
 =?utf-8?B?T3VPTTVSVC90cWo5WFkyNWlZenM2UitOUWJCRmRYcysvWUQraEYzdG1YcGZs?=
 =?utf-8?B?NGJIcTVlTi9sNlV5NEdkZTB2QVJNc1JYdzRDWk40dE50UUtjY1dHUDFqcWpV?=
 =?utf-8?B?R0RFLzNwSldsVnJjb1l4RXN3QkltQ2N4U2pmand1eEp4emxQaHNmZ3c4ZGkw?=
 =?utf-8?B?Wm0yeHc1czJVNjBHYVFUdWE0RnFOSEcwOHNrQTdJK09zNmJtOUJLYzFWMU9a?=
 =?utf-8?B?R0RwbjBoejJKS1VSUTI1aVFyeE8xdlRDcW9uNW9OZFYrOHJFUDZQRk1pNXA4?=
 =?utf-8?B?WXZFUElGWWlXc091NHdjWXJ2QnZxeUxZeUFEWEdhMlpYRTl4bTdDQ05zbnIw?=
 =?utf-8?B?b3BtcnJ6RGw0OS9UbDVhVHBDc3krR0s3aUtLd2pnTllGcDloVjRDY0cyTi9y?=
 =?utf-8?B?YlhuZjR0c3Nwc0JvQmdxMHI4dXhISDRkNHNnVEtSaFo1cms1cFdrQ0xaNlJh?=
 =?utf-8?B?U042VkNob0VMc3UxZE9OTVBzbmxJenJ6ZERZMHNkcWQ4STAyeW5GMGVrdUNX?=
 =?utf-8?B?VFd5SkJaVjJxRU9Ia2dKbElReU4zZUp1NXFudUs1Q2JpNUtJNVhGMDd0Y2tT?=
 =?utf-8?B?L2JiT3RyZWoxOHh4cnJ6ZmZlZkFYOG0rR0IyNGd6RnhMVTVuQVRWV1ZWVE5F?=
 =?utf-8?B?dUx2Zm1FRGpqSzhLNldTVUdXTk40ZUJzZjVLZGRCVHJDaFNlY21NeHZ5U1Js?=
 =?utf-8?B?MHRFM1lXaERtTHZJa1BjVWlic28waEpsS2ROMWx5NFZIUEhkVTM0Z2gzSGRZ?=
 =?utf-8?B?cC9rUFN1c0QrU2N2OWhDbFUzZ0xZSkwrTUxXYVowdTN0dm8zNzVGa013bHdx?=
 =?utf-8?B?TVAreloxRjBqVHBVYmFLNkdvV2YyZG9KOTBGdlRDZ0dYT09MVTA5b2lac0Jz?=
 =?utf-8?B?THltMzN5d1M3bTl6U2hmT2c0bFByWktaUWZsMXRRTXBwcnZKUHF4TlBRRDRR?=
 =?utf-8?B?NkFiaUc1cU5YQ2MrajVMbW1CVXVvbkFkTXZSbGdzdjBTanNhcVBjVjBGUExx?=
 =?utf-8?B?bDIzMnl1TFNJS3d0bUpTSFA4V0tFK0ZZUVV2UDd0Q2xZOWo5dDlXcmFVUUdE?=
 =?utf-8?B?MHJRK1EyRnpZbXRRaHVhbk1DYTRWVUJSMXdEeEZGSnlxb25QeEFFdDdobnR6?=
 =?utf-8?B?cElKZk5EVjV1RnB5cTFEZFljNjFSN3hsTjhZNGVBUUczVTQvZHZBOUwvTGhU?=
 =?utf-8?B?UitmYk5leDd4YkdpdVc1QitxRGdEcUdFdTdiaWxIR01KUVpJRzBjU21LR0Nq?=
 =?utf-8?B?dG5iOXNkR0RMNUFQUXBsYXhHdXJBYnJsRHFIZ3gzakFCWC9WN0F0TU12OUp5?=
 =?utf-8?B?cXk1cEhPOU5IUm1xbVhaMUNEYnpZU0Z3QjI1YkRRM0I5ZzZQQnUwT1JZQjdi?=
 =?utf-8?B?K3ZkMkNtdTZNNkZOZ0ZibUFoNTdsSHlSQW03TlN2Q1k3Ty9QVmtQOTNNT3Rl?=
 =?utf-8?B?U3BsVlI0NkI0UnQ2U2NVVngyZUhpTE55VEJyRDJRakRzemxjUmdiaWlPenJE?=
 =?utf-8?B?VmdWMTFVQTVQRmVNdHVqaDl0NmREMjFUZEdPTG5uZXFGMjY5dm1Pem1RMXdp?=
 =?utf-8?B?Uy94WmFOLzZybHEySVlCOG9weWpTSng2bWR3bUNqUTNhdDBDdE5FQVBRY2ho?=
 =?utf-8?B?anczcjZiRThPcEsyblJobmlQenFsUlVMQjA4cjB2UlBFK09ueWdzQi9ZTU9T?=
 =?utf-8?B?bldoVFhiM0pIT3c0NWQ0V05Wc2x3ZzN0LzM2N2pXeVI0TWxrR2pwellnMDVy?=
 =?utf-8?B?MDBsOTNwNGJCNTRiUUYxMEdhck5XUVp6MnkxR3ZQMnFpc2hoUzUybzUzaGM2?=
 =?utf-8?B?WEo0R0R4SWFpRzZ1WEtvR0laaHhpdTcrdWgvZz09?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2025 08:44:10.7516
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 036b6a64-a004-4443-a4e3-08dde2ea6570
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9182

Hi,

This series by Shahar implements burst period in devlink health
reporter, and use it in mlx5e driver.

This is V4. Find previous versions here:
v3: https://lore.kernel.org/all/1755111349-416632-1-git-send-email-tariqt@nvidia.com/
v2: https://lore.kernel.org/all/1753390134-345154-1-git-send-email-tariqt@nvidia.com/
v1: https://lore.kernel.org/all/1752768442-264413-1-git-send-email-tariqt@nvidia.com/

Changelog:
v3->v4:
- Renamed error burst period to burst period throughout code and commit
  messages.
- Renamed devlink_health_reporter_burst_period_active() to
  devlink_health_reporter_in_burst().
- Added doc for health-reporter-burst-period attr in devlink.yaml.
– In __devlink_health_reporter_create(), split compound condition into
  two separate WARN_ON() checks for clarity and early return.
- Fixed indentations in devlink_health_reporter_ops doc.

v2->v3:
- Rebase.
- Rename feature: graceful period delay -> error burst period.

v1->v2:
- Rebase.
- Fix long attr name.
- Extend the cover letter.

Shahar writes:
--------------------------------------------------------------------------

Currently, the devlink health reporter initiates the grace period
immediately after recovering an error, which blocks further recovery
attempts until the grace period concludes. Since additional errors
are not generally expected during this short interval, any new error
reported during the grace period is not only rejected but also causes
the reporter to enter an error state that requires manual intervention.

This approach poses a problem in scenarios where a single root cause
triggers multiple related errors in quick succession - for example,
a PCI issue affecting multiple hardware queues. Because these errors
are closely related and occur rapidly, it is more effective to handle
them together rather than handling only the first one reported and
blocking any subsequent recovery attempts. Furthermore, setting the
reporter to an error state in this context can be misleading, as these
multiple errors are manifestations of a single underlying issue, making
it unlike the general case where additional errors are not expected
during the grace period.

To resolve this, introduce a configurable burst period attribute to the
devlink health reporter. This period starts when the first error
is recovered and lasts for a user-defined duration. Once this error
burst period expires, the grace period begins. After the grace period
ends, a new reported error will start the same flow again.

Timeline summary:

----|--------|------------------------------/----------------------/--
error is  error is      burst period             grace period
reported  recovered  (recoveries allowed)     (recoveries blocked)

With burst period, create a time window during which recovery attempts
are permitted, allowing all reported errors to be handled sequentially
before the grace period starts. Once the grace period begins, it
prevents any further error recoveries until it ends.

When burst period is set to 0, current behavior is preserved.

Design alternatives considered:

1. Recover all queues upon any error:
   A brute-force approach that recovers all queues on any error.
   While simple, it is overly aggressive and disrupts unaffected queues
   unnecessarily. Also, because this is handled entirely within the
   driver, it leads to a driver-specific implementation rather than a
   generic one.

2. Per-queue reporter:
   This design would isolate recovery handling per SQ or RQ, effectively
   removing interdependencies between queues. While conceptually clean,
   it introduces significant scalability challenges as the number of
   queues grows, as well as synchronization challenges across multiple
   reporters.

3. Error aggregation with delayed handling:
   Errors arriving during the grace period are saved and processed after
   it ends. While addressing the issue of related errors whose recovery
   is aborted as grace period started, this adds complexity due to
   synchronization needs and contradicts the assumption that no errors
   should occur during a healthy system’s grace period. Also, this
   breaks the important role of grace period in preventing an infinite
   loop of immediate error detection following recovery. In such cases
   we want to stop.

4. Allowing a fixed burst of errors before starting grace period:
   Allows a set number of recoveries before the grace period begins.
   However, it also requires limiting the error reporting window.
   To keep the design simple, the burst threshold becomes redundant.

The burst period design was chosen for its simplicity and precision in
addressing the problem at hand. It effectively captures the temporal
correlation of related errors and aligns with the original intent of
the grace period as a stabilization window where further errors are
unexpected, and if they do occur, they indicate an abnormal system
state.

Shahar Shitrit (5):
  devlink: Move graceful period parameter to reporter ops
  devlink: Move health reporter recovery abort logic to a separate function
  devlink: Introduce burst period for health reporter
  devlink: Make health reporter burst period configurable
  net/mlx5e: Set default burst period for TX and RX reporters

 Documentation/netlink/specs/devlink.yaml      |   7 ++
 .../networking/devlink/devlink-health.rst     |   2 +-
 drivers/net/ethernet/amd/pds_core/main.c      |   2 +-
 .../net/ethernet/broadcom/bnxt/bnxt_devlink.c |   2 +-
 .../net/ethernet/huawei/hinic/hinic_devlink.c |  10 +-
 .../net/ethernet/intel/ice/devlink/health.c   |   3 +-
 .../marvell/octeontx2/af/rvu_devlink.c        |  32 +++--
 .../mellanox/mlx5/core/diag/reporter_vnic.c   |   2 +-
 .../mellanox/mlx5/core/en/reporter_rx.c       |  12 +-
 .../mellanox/mlx5/core/en/reporter_tx.c       |  12 +-
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  |   2 +-
 .../net/ethernet/mellanox/mlx5/core/health.c  |  41 ++++---
 drivers/net/ethernet/mellanox/mlxsw/core.c    |   2 +-
 drivers/net/ethernet/qlogic/qed/qed_devlink.c |   9 +-
 drivers/net/netdevsim/health.c                |   4 +-
 include/net/devlink.h                         |  14 ++-
 include/uapi/linux/devlink.h                  |   2 +
 net/devlink/health.c                          | 109 +++++++++++++-----
 net/devlink/netlink_gen.c                     |   5 +-
 19 files changed, 187 insertions(+), 85 deletions(-)


base-commit: b1c92cdf5af3198e8fbc1345a80e2a1dff386c02
-- 
2.34.1


