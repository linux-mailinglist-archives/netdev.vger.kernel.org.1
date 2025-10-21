Return-Path: <netdev+bounces-231061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 10162BF4493
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 03:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2CD4E351842
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 01:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7AD1DA60F;
	Tue, 21 Oct 2025 01:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e0oEnRwt"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010045.outbound.protection.outlook.com [52.101.61.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB55319CC28
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 01:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761010870; cv=fail; b=NBsGHwiczeroR7kTqKkfI+ssODd5JJuWW30xRQqxqNWJhYgyqKwvINz0g84NQwtOcGemQGsDpUuyi1OgGAMFs9hOU2wtp8cylbAx2fH5cEQLIjUhTa7W19uvV0PCErd5C1CTIr/psS63ITqrJl+ufNZKfGw0b8f/t11XqRFi7/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761010870; c=relaxed/simple;
	bh=ut2wikGTKcO7V2MNhqK0yDsZBXS5c1ZnAdcP3a/XrhM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NDqqV+gnBqMQJpwNXaVTlZFLz4jXtGhAThcmjZfsDO94gthmMOd4SvM6wjR/IaKJXBchFifDt0mRGXiF2Zz3VMBKe2FhZp+3OK7J7Kzl0Hse7ZjoFoVFjrAFQf4fT5tLIObkQCYJjdPTEeWdER3lGsL8abl6DNNgajs6ogeWVVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e0oEnRwt; arc=fail smtp.client-ip=52.101.61.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GLdXzJumqQJznBbV8uoKF5bVwmHS5s1GUKs8UnLlW5dz6upTNG5xLPmlVVFRw3RR4wUmXwUidFyWDMYf8wwNG1OYHRexpydHiDLrZyq6Eq+c84qrGtf4W2+XhbWHzLUMqCeVGmM9DcjMkIIJ2HNcj+TPiFrdICeNjdNkJRgPTdM1/xqQUMCKm+i2C1POl4a+ceOhgmqF4GXhwgPaDxEiARA2msZC4fJ/6jjVGfRqWEC7NrPAiu3OAJTA1hTzk2mUeM4cIrWXJwqIdfQCdYSwV6utcPww/9VOuxFMABOIz11kI7fzbuiCIMPPGj6AA3aZJaneCIqfgTcwEpH7rriSgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lG1oSscxzQfgxWc3BM6mgGJbK5rGOroTj/1XIlTXk6A=;
 b=JAL8PTxuFY8uLttADm5MMM2TZTXxh7n7+GZaB4TVKuGbsnSiW9/dNmB2p3WE22SOjY5Q2f+77k3YhyUJPE280YgbYAFnvWvj6fjV3rZvboIPr3OrnqzbYI8OzgIK+LCiO8/x5F/4CL2fcxbN4tNB0KEStgn7d1CsXw8NaTWsVJP1RKdaF3cHue+/nh6J59c6XL1CAwwhS5Rt5h2Zl2rJxGajZXAM7oWDYZUWg5kZMNkixxtzcwmfdBldZldVK98QmIv320MTm9TuD0EQ0RCctZ0k+iG/PBy39P+MVBMxMlNWO9hktSXg1VK0eGfjNKRPjS3GC/KpNro/N6eHXlgmgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lG1oSscxzQfgxWc3BM6mgGJbK5rGOroTj/1XIlTXk6A=;
 b=e0oEnRwttjQ0V4rBFCvrZO3g7Qfl3L7/izNQgmRmtobiOVN7QTA0odokKQBgke05xFlG1B9+c/aZdFjXRymgpQ9gw+SVvwk6zmxFhFF3IQok/0+13Q83SbDzxkKr8DWXL+WJfAGD0xVRGsg4z2pakg+9gR1YExCZYFH+AuX3bXzUN/ct7RayFQsDFgcZZ49dz2KOPjyNeZzi7y000Z/DaxYxSSabX+UBxCKxq/GYJVqSeqe3oIljSQPPUGkkBHh4c3QCBQqlVsarM3H2TScwjwhX8csSUM6KDeSmoXYcJwqu7deKyHT51zxQUUeX+svKf7WB+6iUzY+FCfYM0xQP3A==
Received: from DM6PR12CA0003.namprd12.prod.outlook.com (2603:10b6:5:1c0::16)
 by IA0PR12MB7531.namprd12.prod.outlook.com (2603:10b6:208:43f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Tue, 21 Oct
 2025 01:41:04 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:5:1c0:cafe::fe) by DM6PR12CA0003.outlook.office365.com
 (2603:10b6:5:1c0::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.16 via Frontend Transport; Tue,
 21 Oct 2025 01:41:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.0 via Frontend Transport; Tue, 21 Oct 2025 01:41:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Mon, 20 Oct
 2025 18:40:48 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 20 Oct
 2025 18:40:47 -0700
Received: from mtl-vdi-603.wap.labs.mlnx (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 20 Oct 2025 18:40:46 -0700
From: Jianbo Liu <jianbol@nvidia.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<steffen.klassert@secunet.com>
CC: Jianbo Liu <jianbol@nvidia.com>
Subject: [PATCH net-next 0/2] xfrm: IPsec hardware offload performance improvements
Date: Tue, 21 Oct 2025 04:35:41 +0300
Message-ID: <20251021014016.4673-1-jianbol@nvidia.com>
X-Mailer: git-send-email 2.49.0
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|IA0PR12MB7531:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eef8835-59da-4d1e-a61e-08de1042e585
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ACihAIs3Wh46t4SXVxqB4NJTWM0wRySlGMbh8MMgqTJuJ1Mtrv1iFswRSeqw?=
 =?us-ascii?Q?oEMSiHNIp+rC0nvzgrguD4j2ZBZO+2Oyrj+AW5utqmmBCurCkpJdfQ021c4n?=
 =?us-ascii?Q?Mq3JP/qL0746/hHfeL3VeF/Woi982PElyPFEol75A3JmkPUbojCvqjs8zAw5?=
 =?us-ascii?Q?c9kQxH+IuiKNYi/Vc3ZByrbP55Ck30L0e6xqUD9P44Uli/tOzv1hpkGhoN8k?=
 =?us-ascii?Q?a8ULYwijGbSFjjDDPm9iQ6KUp3Po9JIeZIORtWAZyVv9d6AATGqBzSHbCpuY?=
 =?us-ascii?Q?kcMA0FLoa+NaJOiukYTacCmkiSysqrzDgsm/HDKdHobU72gwYdaYxUbV98+L?=
 =?us-ascii?Q?B/zKreKancyJ3M4hJOTfrSZuJDfkeVD7V+QUhVETAhRMguBWJcKymSd9J8sx?=
 =?us-ascii?Q?lThH2vUFBFPOWrjmnahjbzlmYjvprFmdnT4VGjPqXnO6p9fTMELL+plqHnHD?=
 =?us-ascii?Q?lich5ygyjS69oZ4SvtaN4WIXU6161v/CO7UL90mh5tTWj6C9WU/Pgq5TPAQQ?=
 =?us-ascii?Q?CBKsxmWecMy3mym/q7F25ffsCKmDwbvvbyaV61F+9QdB5r/MPY1vCDku5Hft?=
 =?us-ascii?Q?XHDyNzKvnsRwFQRY0HmKT2CCmIhSEreDllNVbcpncQdy8T3GK5NIUjNpuvNH?=
 =?us-ascii?Q?42cxja9wobLl7sZtvZV9bCI9EW/ZBRRFwAYvQKV0lxh8zJqdxpkugeUkkRGb?=
 =?us-ascii?Q?PwmfcpzuXol1bCtwskRC2MIivbfQ9i4D0FR0KvqAchxTbuqcVUVRNp0o0cpE?=
 =?us-ascii?Q?UJkX559UfwiWVnJH3OANEJ+5biR/PkljDgfuPW3Q1Y+UoZLwVAetips1U54h?=
 =?us-ascii?Q?Qv+inmJENKhLnMcnSL9GFS37397e6w5KpEcey+aF2OcYrmqzQQsYA+TSp4z6?=
 =?us-ascii?Q?Tf8D7M4LgqCtYrXecO7VfrTUpVFdPVbb869z2DHgYHVLuvvVrQA5nF5EbalJ?=
 =?us-ascii?Q?VuYNdBtjkwrwInP1qykD0lBifj2ld6P8J7JwI6HIsDRxjVR3ONqEWxc3IkKW?=
 =?us-ascii?Q?pNhvP7FY+4ai7ugrYYVteBgUBKAb3By34l3RdUCJ3KRCD6mvcDuTbnv8SP/1?=
 =?us-ascii?Q?96DVXlhTsAAHJVHqqCh+uCZqnHQInvl92DbCusgP0dCr91/fsSMxOGBpXuiN?=
 =?us-ascii?Q?P59nhLOheiqoAb6uptNJKdvGP/QT3XRMfgQNRjDm3oxHBa3vBeQixJq+cJ4T?=
 =?us-ascii?Q?B3pO4FFaVrMrB9+DhFlvIlPKXY/DueLTO/yNTyum4W9yhrgYa/RnpajQw8/G?=
 =?us-ascii?Q?k3FQmpR7WFIj0zyt+6PsgQQ2Va9MT2UrYujFANDrrdjgvYtuuUdgyajwU+Tl?=
 =?us-ascii?Q?3AhYl8ZbftZmAXWkUYpjrVES8+iB45cZuMo4v3/t+4QJbDeRmpH4brm4OSCw?=
 =?us-ascii?Q?oinEX9yPAKv1bMQc/VTWxf4Ojdn3yDtBSEqkJJdTEH7NBkvGwYLj08iT+TEP?=
 =?us-ascii?Q?eOsvr0JSJl8rY3J6hKoJzp6VXTnhDRGZCO7si2nheLYGp/7ruI9cutTuk4DE?=
 =?us-ascii?Q?TRmadSvPdZWLmz+GLt4AbPD/+okcH6YXa+csTYx95XGUuMfyftjkj8sxeDWZ?=
 =?us-ascii?Q?nasxj3DnHQ91u4pgsyA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 01:41:03.6304
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eef8835-59da-4d1e-a61e-08de1042e585
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7531

This patch series optimizes IPsec crypto offload performance by
addressing a lock contention bottleneck using RSS.

The first patch refactors the xfrm_input to avoid a costly
unlock/relock cycle.

The second patch builds on this by removing a redundant replay check,
which is unnecessary for the synchronous hardware path.

Jianbo Liu (2):
  xfrm: Refactor xfrm_input lock to reduce contention with RSS
  xfrm: Skip redundant replay recheck for the hardware offload path

 net/xfrm/xfrm_input.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

-- 
2.49.0


