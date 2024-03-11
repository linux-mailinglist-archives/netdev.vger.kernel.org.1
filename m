Return-Path: <netdev+bounces-79226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA90587856D
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 17:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 707F128201D
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 16:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEF450A8F;
	Mon, 11 Mar 2024 16:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MEat6ItC"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0F950260
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 16:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710174258; cv=fail; b=Be0BWvSH4CVjAFAGuCjxesGCisaSwawDAoG0pzNsOIHtebH0np4gHILgLnSfVCEDHEqyTJuJQjm8HSyI0h+yWHMMYab/x0GRQYGTkFZuLXIxe/DduAezjnlgCpFJQFOVK12l9mctdVlQyMHVn6G0hJmRWDom2YzMypnPkvD3h+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710174258; c=relaxed/simple;
	bh=UDHYmcXrwVQMCluQo+HhjbFoz2sxqx/XZ8zZHGc2Ma0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PM+VulbQcOqAXVmuZ45dboXL1QBDT5b64/VG/1VPdXSICFRMZM+g6GuhiPd1VPCD5z6CVyqwx4M/j2pFYAbMpEoNmQ502+dcUF6LDgI9HaW1+FsHQIG5Ntz7OJ8P9GDJvU9nHAaWQ6r70eySQYXAGBAa5Fvz+rOoF/ulWbPilHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MEat6ItC; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SHCubFM6M09agoRjwKZZBAt/z0HAeXNQt2kDb89sHeeP1pUXaXYAT2c3WiF8F3mWX8dmCrOFGpXn4LH3PYFDdcO1E1m6GcXCinahS7lPaSG8R6C3Co0gVytCGNn3pmGoSXgLIxiXlyytbU2/EfYirjOrTjCpGzUxIj6cnmXyOeb7TKlklBXR809ZVafQxa1tfYE1FF3Qu6TBaAyQotbiu2Z+FJxWp8sq0yK1mpFsSQzZAYr1YS6Y71xvnfMtf3FROWREb5OncmetEFKbJ7CuTkYfFEp4rT1sgpIrPe1gkCYlmt+X0ZZEIHL03MyPU0zgTDyTwa3gIcZxlzkCCzoKJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uS+jnc+C95sSzfHEX6NZV/2zqlFfnHVwK0HMeRMdYV0=;
 b=cRUfokcWYQGy7QDcc077e9redJuERyKsTKXtgpsQn7u6auJ1/9Rf0uL7kzubo2z/1QESRXyI9bc5eSKtJuEReqfbnzwJmUjaNekSy9HGOfe2+ubJUmPL8tfsKBPrGesuL03Uva1yRHlBnXxOY+WZLFr4bE/RxN+ZXLFaqBAMOq7p7/HOVehhU0NRzrBJYx9mcBbssOOM6v40boAAfQ87/JEyWY1/duOCnG4MGWNoIXYH+NA+QEwEaXc3pnsW5OwXJwJ5Enncy+MsJ3Xh72CHa8qFSAQAy56sT1pxu5vDwiUbTz7mPV+s2cFVlQ4cbUy/jMn33ALvkr6LYy8L8kx+9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uS+jnc+C95sSzfHEX6NZV/2zqlFfnHVwK0HMeRMdYV0=;
 b=MEat6ItCizHapVMRzkc98kAvu4I1OLcPzLxtsRtw3wBt1PlSpd2J+o119IZ6135ehLZHS9h1FLY2b+fNu1zlHxfaTigQytYbP80B5zpj6MRYul+L2DOP1Cr1wJ/A+YABbdsT4HwLSdEvqDldDetYySWaNt+T8BB9dBZN+P+KrHw2Rhljs0sM0uojxLtE0j3Kf6cRKMyiPsm/jD2MorbYJpQhbQKr1nxNOAUy37ZAUPq9v0+M3WTRfNeTUoUbjd1omZuPcm/pdH6mFwkWIUdY5vqI0zQTnhrtaui/NZFaOvP3k6ydRjS98C5yowwY0EZUdNzjxlUJRk8oLKXOo30Dzg==
Received: from BLAPR05CA0020.namprd05.prod.outlook.com (2603:10b6:208:36e::23)
 by DM4PR12MB7693.namprd12.prod.outlook.com (2603:10b6:8:103::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.34; Mon, 11 Mar
 2024 16:24:12 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::da) by BLAPR05CA0020.outlook.office365.com
 (2603:10b6:208:36e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.17 via Frontend
 Transport; Mon, 11 Mar 2024 16:24:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.12 via Frontend Transport; Mon, 11 Mar 2024 16:24:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 11 Mar
 2024 09:23:45 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 11 Mar 2024 09:23:42 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <petrm@nvidia.com>, <dsahern@kernel.org>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next v2 0/4] nexthop: Fix two nexthop group statistics issues
Date: Mon, 11 Mar 2024 18:23:03 +0200
Message-ID: <20240311162307.545385-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|DM4PR12MB7693:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d4fc7a6-2c60-4c5a-cd42-08dc41e7afb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	D6zZSB1KmZbo21u0dri/JbVBclmu257xNiSMEUsamoIDPD4hjs97RSYJzJGYb09wV6hFafbS6sprACAlQON6dcvMfWboFfy59ZkJ91UB7XQjC3TXuPGo2Wd4Ma7OMcaWcFKNHsGS1jQBRUMkp4GWcQ7ykLI0PT19jGJXOwPC+ghvM94VCrEfb7k+sW0ND1VrpFiKZLZtEN3ykIyuGUhdxE3XvTcc8sOrqMEJ3jOXgvhv1iUtItR10XffiyxXGZZ1qTZCc7UvwiWDNTUP8r9vL2xNF5WQHKUrnlNAmBGc9k9a4e4Dni1wLhLPHO2XkmE8edRjaXMvcltiGlm5C6laMQndKEThVREOM9bq24pVADDQrgOzD+v2BUf3zWGy23S0Mb2v8ka0pG/daHwHcpwANEMBnOoCo9RKknY437Hcnoz1h/wx5MlOyO+FqtBLlzcpGaWBw+9jP0DGD3s/Q30GaGziiGBI/yMPZ6ORwTQgxFdzNmjXU5lNG9uPn30y4IL0E14epDcYjVydgHH7W3HQ7iHU/deha+4MVOn3+CbRG+kO4wYh72RZE5TbWv4+26PKxetpqcv1suKdI0jMuwT+Fr/h7DjSzKxJNbs4qD5xgsb00PE4j91JK5qQ7LFHGOQcXqA5sMl5RR2Moec1jGsPjeYHS/n8xynf5cZzFZOmEqSKvamL2/qEuQjFTfVFEweCAt8mv2r7YCs1hTMtd18/DTA91IE9dxPOA1YXiyoQHGQTsa2CtSI6Ge3jcCCD/012
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 16:24:11.8783
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d4fc7a6-2c60-4c5a-cd42-08dc41e7afb3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7693

Fix two issues that were introduced as part of the recent nexthop group
statistics submission. See the commit messages for more details.

v2:
* Only parse NHA_OP_FLAGS for messages that require it (patches #1-#2
  are new)
* Resize 'tb' using ARRAY_SIZE (new change in patch #3)

Ido Schimmel (4):
  nexthop: Only parse NHA_OP_FLAGS for get messages that require it
  nexthop: Only parse NHA_OP_FLAGS for dump messages that require it
  nexthop: Fix out-of-bounds access during attribute validation
  nexthop: Fix splat with CONFIG_DEBUG_PREEMPT=y

 net/ipv4/nexthop.c                          | 58 ++++++++++++---------
 tools/testing/selftests/net/fib_nexthops.sh |  6 +++
 2 files changed, 38 insertions(+), 26 deletions(-)

-- 
2.43.0


