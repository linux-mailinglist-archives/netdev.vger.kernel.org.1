Return-Path: <netdev+bounces-182747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A1BA89D3C
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 14:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 056F43BB478
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 12:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB2A2957A6;
	Tue, 15 Apr 2025 12:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L8n1wg2b"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2057.outbound.protection.outlook.com [40.107.212.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E251C2951B1
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 12:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744719141; cv=fail; b=piyrC5772V3JbnNPxvfAfuM3mi7CFFdHU1zI56v7G3bwR9uOUinnZ8KWVca8RZcmCdVREGVyKHilNLIRplTKtiYMXf7QNExEQ0hyMqh5fBt0OooH4LtR+YOt91OwznwpoSOOircx1/6QT1vZJ1uA8vanuS8RKLtRsflkjDPea2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744719141; c=relaxed/simple;
	bh=yHt6uFmMn8gU2z4MxX2uXSxJbr1EmDIYCaXk2j94Grw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Gt6aQoP7ERustmdyv/pSfZIxy7pz0Bqtu/Z+3dbleK4xzvN7shaJQkn3fjQs+a/CuRguR0m+kBItEx/pnpgYVXwHBzTXcxK/r5C3wtdsdjqFj8AasogJVfbdFgIF/KqJqL3x7dcBvadYvGkz8VNmH78b7eWZGSIo+E4reaZsWNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L8n1wg2b; arc=fail smtp.client-ip=40.107.212.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S5mv+t3P5ar8cWz2qjj/36VpppQCcsQiwBHhTx47PatRhcgQCxDktKU3/6bYCUMzD6EZpXKhCrMoLzDh60HhuE2wy/B/I8Cy8ZsPUw1fIXu7DbqC97d8mn0eltii7J3bYZmoUNtUcsTOT3eVrTnqvsp3F082JfkPVAdmIyyTIuEbuz8HllNDgMcGONS8NJLIaZcv6wkpZ6z9DyNgMv7ZVD+cLjwMiBRP4h6FkxDXUfLJ4ZD4wnY4LP3/Rh/u2CsqUaFJ6jnoBDzqrKJ2Y7Ip14Zp+F8TW3Gh1KWhyZA9HbhZETuMEAIWLiZU8ittBcBn7IWQ1GzNDOuS0L5oiQHTgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bw0izuuiRQ97i1EfCWDPVL+CMxOEfdJQ9uhSExYgu/c=;
 b=H0ctRGBwKXYwclVFaZ036GXy8T8V1ZDrHpH+zGUQnrQcMGjifhuNV5QKJ0o76YdlyOQGw4lrlndnvsk3uBCLPWd1YekFrkYCOv6FcDk62UljXresc+Fl2S9YNI+lHtPtnL8BIadow8QzfhaB0kQn47LVBKKRQoNKCCLHmTJh2UYp9xwMG8D+H51dr5wBp4UPMdEoT16keBk+NTpYqEQVqfGozEK+fTYUfyrQ01aa7dyEzzFcby3AimzdcSNnNv+oxxA0guaG9vzRlvmcrSY8QFODPo8EtFMYgVNlHGvMApSYcNSzVrdCJcS14lRRNqviLZIftA/wmUK11xvv2lmYmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bw0izuuiRQ97i1EfCWDPVL+CMxOEfdJQ9uhSExYgu/c=;
 b=L8n1wg2bFmmnJLum5D9KNe0i5D+wkcSuEMWA8u1DD0nCn1LYrtxQueyPTyq4fd/Na0SCeopLvrzbXe3VnfdbPgrvb1sQjEAaKkOT6hJQwQAlVaRHzZU39/qg1mrBdRZSw5Sptz7PZsHzq+3aSl1dYKh89u7GMW9b1uxOX11wBz0xSc1bT8YHLAXjCqUqvbJKg2PoWv4QHJycDt/WmvqN0qfFrUfSkQFbGfCwZqgYGrMVWZdd6PMCOXHhSWp9bJHuRTvC/URZqUSJToK74XFMpuXXsaWAhB9IsgSTsbPBdeiWJ4LhYaTxNV49VVbWEuuz2ltuSL5QzqJ5Ts6gYsYB8g==
Received: from BLAPR03CA0168.namprd03.prod.outlook.com (2603:10b6:208:32f::6)
 by BL1PR12MB5778.namprd12.prod.outlook.com (2603:10b6:208:391::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.30; Tue, 15 Apr
 2025 12:12:15 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:32f:cafe::ea) by BLAPR03CA0168.outlook.office365.com
 (2603:10b6:208:32f::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.36 via Frontend Transport; Tue,
 15 Apr 2025 12:12:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 12:12:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Apr
 2025 05:12:01 -0700
Received: from shredder.lan (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 15 Apr
 2025 05:11:58 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<petrm@nvidia.com>, <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 00/15] vxlan: Convert FDB table to rhashtable
Date: Tue, 15 Apr 2025 15:11:28 +0300
Message-ID: <20250415121143.345227-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|BL1PR12MB5778:EE_
X-MS-Office365-Filtering-Correlation-Id: 65a99263-3efd-44e0-bc1f-08dd7c16c2b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5oHLNvjGyE803pjYO0Y0SrFCipAeG4Pn/KFtGDgKG0TsZVAwKSbF/ldPqxTs?=
 =?us-ascii?Q?Qyv60tEjCmVqAIBzkm5g5TyR5BPppk/4U41K7IofzWj2OhwQ42Vrwzdof9p9?=
 =?us-ascii?Q?G/Q7t9P1aYjUv/WSfGNZAtmGsqjEgVD3xSIkStRMBKe7mwHXO3w1cNWEGaTY?=
 =?us-ascii?Q?hY9gB9fDjhAbbMQaNL/5PGCnVuzkptaiJ0CpElRACFxr8mI2PFPbIIucw7hS?=
 =?us-ascii?Q?U960ykVtSSJSowoKRGxibTkXC9FKWZ7yM3JSlMAzI5HVkwGOuYAyM74Pc2Qx?=
 =?us-ascii?Q?LXNX8XibQeMC1ky5tkOymZADgqRYyFsQ04Ldb/NOkN6HNeLxMzEGnfgByxot?=
 =?us-ascii?Q?99WNQYmE/8m/4PD0cI/0vKQBSfk+p7XEy4M/ijx6UdyGBZBpgqhoZeA9EULG?=
 =?us-ascii?Q?8aVoPHi8tjcJeAg5OsYausrFWHrQZlwRYmyj8cBfAEbetBfTl1fCVQruBpEN?=
 =?us-ascii?Q?fIAdVfysEEg9sTmIY5ArAu++xoitIdNDIqWclY1GE//XTY/YfYIS6DPCyBwy?=
 =?us-ascii?Q?DJZUZSz5KUjLMyOzpUC+zmaL0iQosPIPAAHR4xzeZItNin+yYkbiagrCvnL8?=
 =?us-ascii?Q?aiuzrC45zRYs2pvZ0fEd9wkKit1Ah3ivadb8/4QaGZAuL6HoIhqX7U8jMQPM?=
 =?us-ascii?Q?Xgd/iYiAqB5Hpocash+8tkFIQKbaRcPtb5TGHVvPMnHflNH+YOSUMSsEHCfv?=
 =?us-ascii?Q?HyYDnMbbZhAlT5b3VgVaVaQwe5+h67m2HxXyzJqcl0ZWWguWsr5K4x3uRI6e?=
 =?us-ascii?Q?S85RfqTP6Nh6llUs2cDTda54YXwGvV6O/CqqRlxkLDfNckZEQF7mYCXjKlG5?=
 =?us-ascii?Q?OOIUQ2kerzAs6Q9f2/ByPBhjAQaJRR6jMpec1L6bAbgW9pzjBktFU3hZp/Z2?=
 =?us-ascii?Q?zmAPj+5f3ZCCt1EpF2iFuWZp6ELOPw82Fy8Xe876yTbqSkoidXvGK59n5Ngj?=
 =?us-ascii?Q?Ekjw5/0Uuo3a2llx3XHjGzQUaeRQEwa1aY1eesuIVpl2m0XqcMtAXH1Arr6i?=
 =?us-ascii?Q?lVLFZRENMyMy9j9vWtE/vUqoi8okW6qjdMUM/KY1JaiKxKtgBJ0zBHl3/vUl?=
 =?us-ascii?Q?ZX0p2kJs9qxDIDpXeX6It6EKw6aCeGVYDnxO628DCSaWWAAcp8OHpJzcJc9X?=
 =?us-ascii?Q?Joiv8MZKZRMrGmbfEkyWWaAGNZUpO1ZOnQSSBLK/bIeATfEX3alYxT9znC1f?=
 =?us-ascii?Q?77eGcIIXMMP3lI43JEVDIn3adnkB7W9fZoRe+oh2ItJEg/hkU2+R2+6MTF2T?=
 =?us-ascii?Q?lGgZmu2018tnJBY5GHQag9kU2TdSmHEfT+nChaSExrTkkkClzdAjKNrChUN7?=
 =?us-ascii?Q?kC+0bYY4KodRYMkpNBomls5yTpWV9V2vKXuSoOz32+FV3L9OwaSvMge2enXL?=
 =?us-ascii?Q?ZlA5nQwmmRZf9+64ERwVIRNUG2tPnm7rPI+cTkfzjy4e8KFXq1BHJkpUggHM?=
 =?us-ascii?Q?eVVB7UiXjhIzAX1WQ/Cw82htSjtlVD96GNgfcRaatj7ipXArQh/CYNlWflHp?=
 =?us-ascii?Q?seaPnFKnwVLlA0V6UrPTHsVT00nGU93YCioK?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 12:12:15.2549
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65a99263-3efd-44e0-bc1f-08dd7c16c2b7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5778

The VXLAN driver currently stores FDB entries in a hash table with a
fixed number of buckets (256), resulting in reduced performance as the
number of entries grows. This patchset solves the issue by converting
the driver to use rhashtable which maintains a more or less constant
performance regardless of the number of entries.

Measured transmitted packets per second using a single pktgen thread
with varying number of entries when the transmitted packet always hits
the default entry (worst case):

Number of entries | Improvement
------------------|------------
1k                | +1.12%
4k                | +9.22%
16k               | +55%
64k               | +585%
256k              | +2460%

The first patches are preparations for the conversion in the last patch.
Specifically, the series is structured as follows:

Patch #1 adds RCU read-side critical sections in the Tx path when
accessing FDB entries. Targeting at net-next as I am not aware of any
issues due to this omission despite the code being structured that way
for a long time. Without it, traces will be generated when converting
FDB lookup to rhashtable_lookup().

Patch #2-#5 simplify the creation of the default FDB entry (all-zeroes).
Current code assumes that insertion into the hash table cannot fail,
which will no longer be true with rhashtable.

Patches #6-#10 add FDB entries to a linked list for entry traversal
instead of traversing over them using the fixed size hash table which is
removed in the last patch.

Patches #11-#12 add wrappers for FDB lookup that make it clear when each
should be used along with lockdep annotations. Needed as a preparation
for rhashtable_lookup() that must be called from an RCU read-side
critical section.

Patch #13 treats dst cache initialization errors as non-fatal. See more
info in the commit message. The current code happens to work because
insertion into the fixed size hash table is slow enough for the per-CPU
allocator to be able to create new chunks of per-CPU memory.

Patch #14 adds an FDB key structure that includes the MAC address and
source VNI. To be used as rhashtable key.

Patch #15 does the conversion to rhashtable.

Ido Schimmel (15):
  vxlan: Add RCU read-side critical sections in the Tx path
  vxlan: Simplify creation of default FDB entry
  vxlan: Insert FDB into hash table in vxlan_fdb_create()
  vxlan: Unsplit default FDB entry creation and notification
  vxlan: Relocate assignment of default remote device
  vxlan: Use a single lock to protect the FDB table
  vxlan: Add a linked list of FDB entries
  vxlan: Use linked list to traverse FDB entries
  vxlan: Convert FDB garbage collection to RCU
  vxlan: Convert FDB flushing to RCU
  vxlan: Rename FDB Tx lookup function
  vxlan: Create wrappers for FDB lookup
  vxlan: Do not treat dst cache initialization errors as fatal
  vxlan: Introduce FDB key structure
  vxlan: Convert FDB table to rhashtable

 drivers/net/vxlan/vxlan_core.c      | 542 ++++++++++++----------------
 drivers/net/vxlan/vxlan_private.h   |  11 +-
 drivers/net/vxlan/vxlan_vnifilter.c |   8 +-
 include/net/vxlan.h                 |   5 +-
 4 files changed, 248 insertions(+), 318 deletions(-)

-- 
2.49.0


