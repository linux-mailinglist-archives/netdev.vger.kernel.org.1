Return-Path: <netdev+bounces-79031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F008777C4
	for <lists+netdev@lfdr.de>; Sun, 10 Mar 2024 18:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BE8B1F21062
	for <lists+netdev@lfdr.de>; Sun, 10 Mar 2024 17:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3AD938384;
	Sun, 10 Mar 2024 17:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hX0AE28q"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CA428DDE
	for <netdev@vger.kernel.org>; Sun, 10 Mar 2024 17:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710091989; cv=fail; b=guvGyepkmYqTXERxG40dpEgWZF/ZGGfqg/OR82x87X7tYnQhnrvzuSWrLZVM7wurNEhFnEvTdIa65ikF1QMgTLx8PTZyKs3glMlA72KzUOV31m5PBMz+rQFWGIbc+rg61vZ0JVPk2thwTBd68qfb7R2/U7BgyG0t+FX3xlIhWq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710091989; c=relaxed/simple;
	bh=tn1PPT4CVMxb4gZPLffsJgiGro71LfIu3Nu+kl3sqSs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T1Nx2Og81n4KvdxyY9r9Ihnonnczf+sa2cahYtk+prxubfTe3KE64/TMcACGK84z+MOejFoCmEChEgro3/z0R7drRo8HgIoClek+ZdOnYIQBHoEB11UNiD/NJ+Ob1MTUDT3tu/qGo08YV8hIHWTS0PRVnCI49uZ2VRqV45b9qHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hX0AE28q; arc=fail smtp.client-ip=40.107.237.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCzZbVxepEEG9y+QUYavYwSrfxKPg5B2n8HhUaXlXsKk+x0VRGqArqYD+RD5p/ZsvtSGje/rGanOaFdQFoStLEg2h/KHFgFyNoOxgvJPbxRxqCWs1wquUM+xTfDU9Od18NCsuXJHBWuHSRwS9i44alOkFJBEO6zqj5/3QbDyFS94rRwH39PXB45aCUoecfeVInEtFh4ZEtHV6vRrcrS061gX567l3LuVUFoKYhH6qnckgfShSpfjbqFxD7lSxNqNwZ7RlXIrYc1UGx53LCQ3lrYpPzZKGnZbTCgc67h3qPh0tsZKQazqakwwM5HZUkjPEdspliBRd1h9+qgazZXS0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZQz98EkW7PdXPFCH/6WZYk+1Uvyd65G51KkKs7RHjc=;
 b=LeEv5eV3zzj3iCzCMJuT1cSTr1RWewt2ToaaPZWaCLyA+BkdOTmsZXphBUWAZaY9uwOOW61SH2jLQerEH84u7ELkdY9ZXV1MGuYCUjZ8PRL4+9zmUI4b2KCiGWlUeUicNHKQn7Mc3/QbHgaWF8YMhT8iIMgH3cn7stZQKZFIu+Wbukw0xGidj/1axUxHWm7CrFrtYGS+lAqkTxZDAB4dpYS9TVvBZZr2JhtI4N+vha1nF0nbol2PVTGL7F58rS2WjJR7zEPcUxD+J6MPXUSyA0vv6S2rz2ePUkSaoooyW+FQiYOUfJpGRsU/IZJAJox3QkCJRlaCJp/nbR9O83lP+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZQz98EkW7PdXPFCH/6WZYk+1Uvyd65G51KkKs7RHjc=;
 b=hX0AE28qO6kXk/4t3Nc0Wu7XbKXvH4nJGcwUQIXgHvC51KkT1HoCFAQ2Zl/Z/chqhwKGszAkokkTAA/Vi7CyunMJKJO6DsAJQJhDs7Gstmi7D6hByh0PeH5G5pdTq1S0hAqgjoG1w8KmNbVLGW23+JlmJfO0nxGQb0DSNIwLHKSQ63l+8ZQ1kA8He/bz/F0ggWsHysioMjuFmB2ry9oc5pPoQe7PTqo4uYzX4n7O3t36IDOzC4sGsIRt34gFNjf4pHujyBy31Kn5dn2IX2TZEPmbWGgjFdYjmMTXeF9NlSXkMhWOq5PD6TskG4+QFH0/2LPRRt9w2rGB58ryyScXUA==
Received: from CH0PR13CA0025.namprd13.prod.outlook.com (2603:10b6:610:b1::30)
 by DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Sun, 10 Mar
 2024 17:33:04 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::8a) by CH0PR13CA0025.outlook.office365.com
 (2603:10b6:610:b1::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.11 via Frontend
 Transport; Sun, 10 Mar 2024 17:33:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.12 via Frontend Transport; Sun, 10 Mar 2024 17:33:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 10 Mar
 2024 10:32:58 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Sun, 10 Mar 2024 10:32:55 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <petrm@nvidia.com>, <dsahern@kernel.org>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next 0/2] nexthop: Fix two nexthop group statistics issues
Date: Sun, 10 Mar 2024 19:32:13 +0200
Message-ID: <20240310173215.200791-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|DM6PR12MB4435:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f17943c-5e16-4124-8dcb-08dc41282490
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hPVZWP9EFJE4ZWLo7GgGNn38Ce9x6RUWVvRQsmeHu44L+N1cNYk2Hm5+g2nl/V+dxuRcOdkK41LwpDv58t/Fph5KFXQjC5aUVKa+ocDItYQSDsHnEOF5hD+Whllx1N/IaumCseKS9ugUk4m/LdCiCdXxSnsBUiP/WQzNCLgSfx3sXJuelRE7vSo3L7vTKCpPOC7/B7Tilq8ThpsKAoV55u5bhkKYTKqn0VtBMDR4y2saVqpVzctNrn/evLC67bsVPJKzvEG6qRYGMncidDxWMJXTdyfoE1pPXvU1aOKNbVpVk8EWBMjgI4+yxx0+ZhScHbY7ZoLcIpoOqf2uh9fmsLePb556Mstds6dmwORAd5oev1lURyeaq38rZ/tnP6S4O9DFlbRg2DCR8gaQGQoP4xJ65Mxm1fd9v9zGfnFKAmToZNuPiuIVeVicorkr1DXSR1K76rILJZW7oJovbuaP/4ALjW9vUpaYlqztJsgRTTgKiSNURQ4DCtxhsfDHDQjDbilB9n8ojQu1Ph3dIH1E8RCI+fkXBzoOz0PSsoQ5dmza5KbLN9viJEb+cAdF4GNZym71M172IXY3IUzrI2dfWJPAkLzgrN1FMtjAHSoHkJztdcntq9uxX8hIAIgTmmHv85Ft/FwBnbZPjJqOr0ByP6VFh2dDZ+QeEFVEqA1wpxx7QBZlcM94PTfxMCx69hrZEfJvB37U/kR7jkDD7NNO4mI7sfxOeHCeAkPYnJP2rkGHJODILHFHeDqjJnUcsQDh
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2024 17:33:04.6155
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f17943c-5e16-4124-8dcb-08dc41282490
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4435

Fix two issues that were introduced as part of the recent nexthop group
statistics submission. See the commit messages for more details.

Ido Schimmel (2):
  nexthop: Fix out-of-bounds access during attribute validation
  nexthop: Fix splat with CONFIG_DEBUG_PREEMPT=y

 net/ipv4/nexthop.c                          | 22 +++++++++++++--------
 tools/testing/selftests/net/fib_nexthops.sh |  6 ++++++
 2 files changed, 20 insertions(+), 8 deletions(-)

-- 
2.43.0


