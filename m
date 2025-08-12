Return-Path: <netdev+bounces-212800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91632B22055
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 10:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AAA017D509
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 08:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7B32E0412;
	Tue, 12 Aug 2025 08:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CIlXNZRW"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CED2DFA46
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 08:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754985997; cv=fail; b=bRrwu5zj3jh5sJOEx/xitDa35K8CFPAt0Q+X6ScdReE6/cVtBjzPC3IdDgsWMtG31CzykFFWI3C3CXd+zX8vZdgLhtdx0uDD5/tRuoxr1t4lXFpI8zA9vA1uajegYcwt0yTvGd3Y4EXcFkXvCYd3n4PCu6waOG1Y1eT1fyDWYv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754985997; c=relaxed/simple;
	bh=IVJAUxjclfMb0B6CV0fLw8PsZV/slPQJeWqANS9e6To=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oGYsMSahrF8p2P4g8s+G5Lpmy/d/ocmS1cDSgGuJppCjvifYjOi9jHRbVgbUM0hnhmcF7sWlDZ8HWvehvh+YwYoMfonSlvBMCS14bsRWAqbWoKwNhWTUU9ho15KuYKJmGfa9TTpR8UWEZLPQ3zdAzFhSVzaCoBIRE+iJE6zZ/T0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CIlXNZRW; arc=fail smtp.client-ip=40.107.223.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X86TpBhZJoBFHZuHvtlUAW8pW+vz7YCiIKO5Cv38Zo9cDEIG1SXMskBcMHrzytGSJlSlbHu9HWk0ADp/UwOEYZasJTTWai3xt1NSSGqebjfmOv+IzCfZ2amRb6h1s3xNLK1pmKjI10LNpDnTNnvN2S2BXYplbnrWQLq28fiFdHwyMPM2Tn5Agj5TvG4Xl+m98DAlqzQ9xylbb1y8UQP9Yv0OX1DRfu8bAh4zuq4zJmq1KXVs2Nz8zCsuXKMyR7wDZFsvvzGzI2+w1tMRX/siYR/nhNBDJnFgSuKDjRlOcwHXyp1tRNXi6+T+15+d8ox/1CeJFf2jawBXPwTYx8YytA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zI1ALU/IMzRB/CdWWg2Xvg2m2EitL5MAI3ti/CR2cs4=;
 b=l3szh4nrSz1/pwKmm+iisS4Mwn6QW5KjKhSmXu2LKh/+X6Os0rAdBlTenhWQV5bH3zRSaE8SO5h99SXgUbOnG7Ci4TX2ujuZVgbx3xVXVt0qHFHlg/E4FDo+GteGl8Z1jGDWvSAyM+TBh65Od198MtkbpthCj1RyRMjX/FTfgpLEDRCofoS757ZNfUnKCdqHwfu8Awz3W60MaPaoc+upbh42r4O9DidAHxwrv5zixoI455fF5YJn+G+4KxKwGup/k8d+KsSfDT2squFmfAyjCNIhMBF9kzvymlN5f/Sn3jl+n/ll1ABaI3LphHBGcDPF0XHB3kltyD8ApHQ4miUeow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zI1ALU/IMzRB/CdWWg2Xvg2m2EitL5MAI3ti/CR2cs4=;
 b=CIlXNZRWT3Cgh6GnbEPnZwIAHWv9mLUEymsgVFfj9UMV4oswKleNktaNSHgblA1FzJPLFIDcmCVCW8hHLgeR/UoRALF4x8y3UayWcA8Q9OItVuWPZtNV2qYpDKFrrDz41H26v0l3H6yguo1xFTeXGClAPmFJIoxiIjZvw1/qOBZyroDkmv+vRuJ+5oaXuRLS2t/U6Qtk934CsTCv6xMYpUetyAij37w4YEVT7CFTfdVaF5lZ/yrlqpQXlat+nOrWC2u3RlE7GFodc2Pet6Yz8YEsl/jdYpw0tqA+fZY0+v5irnG937+1yeEhnKppoehNFFNsgavbb5WPz9RxH9gakA==
Received: from SA9PR13CA0031.namprd13.prod.outlook.com (2603:10b6:806:22::6)
 by PH7PR12MB8427.namprd12.prod.outlook.com (2603:10b6:510:242::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.17; Tue, 12 Aug
 2025 08:06:29 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:806:22:cafe::22) by SA9PR13CA0031.outlook.office365.com
 (2603:10b6:806:22::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.13 via Frontend Transport; Tue,
 12 Aug 2025 08:06:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Tue, 12 Aug 2025 08:06:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 12 Aug
 2025 01:06:11 -0700
Received: from shredder.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 12 Aug
 2025 01:06:07 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>, <bridge@lists.linux-foundation.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <razor@blackwall.org>, <petrm@nvidia.com>,
	<horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 1/2] bridge: Redirect to backup port when port is administratively down
Date: Tue, 12 Aug 2025 11:02:12 +0300
Message-ID: <20250812080213.325298-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812080213.325298-1-idosch@nvidia.com>
References: <20250812080213.325298-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|PH7PR12MB8427:EE_
X-MS-Office365-Filtering-Correlation-Id: 86fde9da-4e19-4bb3-b9e2-08ddd9772484
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zpPxv7d7VTn639EZQc/H/gIlJiTsMfWxeboA/T+/5KCFk0Sb8blhMCG6ipA1?=
 =?us-ascii?Q?0TywkpT/SPTPo5IFGE8bAjKN4eXdFrq/vczU7RQuvWxLh1Grtj/3rBSz+nSP?=
 =?us-ascii?Q?MjvvYB+ZEqXdr4KMTqQC7D5NBY3haZsCbygKT0xokruqImwB7R0/kOsqwh8p?=
 =?us-ascii?Q?R8kOky+xJfDPT58QLqpPZOdx1iVYQSKS2b1kCCeVogLOeWdpDcyhd4RsgER+?=
 =?us-ascii?Q?Uwx89VJc0qft7fNnZIsQr3Sf7uNsYIBYQGKII9rI3jQmJcQ+oe0zLZSlyCPm?=
 =?us-ascii?Q?Xz3E7i0NzH1vG8ZuVJo3UF+JtqIQCPvbpilXncFkE0fB13E0Yrc48O1VAUv+?=
 =?us-ascii?Q?8mp78zrKZu+TFimn+M7+6Re+0O5fDCZz31skfmddtUX0kumshfWa5KmyDrxq?=
 =?us-ascii?Q?AR/3njI5J4RdtswClYSvDHrla/vMxLX/z/Rg9PAj3jdgHRXFN7ougBzHLoDE?=
 =?us-ascii?Q?HtNEroFpkcX1DC2LTrL1kkLiszAB25PQcGEuLlH04DZ0QN6LJJn1P1vNkl/O?=
 =?us-ascii?Q?aYRP+j//uWHzH+CWPXpRn7YUY2cdEty9rRhUSKAKIVW1iXTSsTDPDLNMmuGv?=
 =?us-ascii?Q?AgcXYujlCM1cyrpxn5QkSjobNsvGqe06okVDS/1nakWYarYZbwfUKTbj+H8s?=
 =?us-ascii?Q?pMOLiDhAIkbwd1NxCfsQA363We0zFb51Q2T7xBV1y6Yavfca24DlLi+owrsB?=
 =?us-ascii?Q?qlwcILq79yC4YV5kFCsXdp16YmtSJc9/wutMc7AGgxg0X6G8F4uwAwylc93l?=
 =?us-ascii?Q?xXIIzbyJTgdJw3VIrNwllgvIR++u5Rd0s485/vCnlLGvQZ6a3n4snqgAIn92?=
 =?us-ascii?Q?yrv37okR+0XLYiIB3ockCBSWxTGaJ5o0kV0bYoAuxYWH4hCzMG6qiFcCQte8?=
 =?us-ascii?Q?qZCoCZ2NmRE7XwnkVNUY4vCdb6WgLTLMzIpLJ4x9M3EbWGAlIGYSsmFQVAhW?=
 =?us-ascii?Q?KeuaA/aRQKK1RSTLqCzKfUMhBZcnuNDoByw7L3PKhgKXKXwZr4zbg9HmaQ9a?=
 =?us-ascii?Q?6qF7tjA1C8uZur0aLI0qLuoa7xjrzj8uXoD6cXyiGN5pUQCwhLiaJbUWXhGf?=
 =?us-ascii?Q?H4BAX6/mJvh93q3f54pmkEtB99/FPCzlDxZqNCXAyckqi0C8T78h/XbqvdX4?=
 =?us-ascii?Q?OrOE/VhYeFGTRxbc2DIR8NjBAUFqqWPDciud3s8fF/GHH7/BOkBJZcdHS0jy?=
 =?us-ascii?Q?zmL3FbyqYneHI3B0kpOQC/LAGWvTxQKUQHWOavszg8qhX9THZW8LVV+ovqsm?=
 =?us-ascii?Q?5LFkcX9UBmszB8hLLTRErMDfaiEbpHHT/lqFdQDXVrNlqVdbbuZHIvczCM9R?=
 =?us-ascii?Q?fdzK3tLNM3evUBX+wdiLaN/j6W7+D3fTqMBkucEMeBQ3LUO8QOi5KtIL1YDA?=
 =?us-ascii?Q?bGU5Y2IcZkCZlJs7bndI3H6HA9HBzfmRujHwt4PuEkdP09NFW1uad41okA9L?=
 =?us-ascii?Q?YuShRakInTlVScs/PzsEdUMXxcrtmESHfEtCPEzDJCBAqfCgu3GCON8LlwuX?=
 =?us-ascii?Q?naYIfa6DKgUo7GLPYkL+ozF8wupGNZdKdXMH?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 08:06:29.2032
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86fde9da-4e19-4bb3-b9e2-08ddd9772484
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8427

If a backup port is configured for a bridge port, the bridge will
redirect known unicast traffic towards the backup port when the primary
port is administratively up but without a carrier. This is useful, for
example, in MLAG configurations where a system is connected to two
switches and there is a peer link between both switches. The peer link
serves as the backup port in case one of the switches loses its
connection to the multi-homed system.

In order to avoid flooding when the primary port loses its carrier, the
bridge does not flush dynamic FDB entries pointing to the port upon STP
disablement, if the port has a backup port.

The above means that known unicast traffic destined to the primary port
will be blackholed when the port is put administratively down, until the
FDB entries pointing to it are aged-out.

Given that the current behavior is quite weird and unlikely to be
depended on by anyone, amend the bridge to redirect to the backup port
also when the primary port is administratively down and not only when it
does not have a carrier.

The change is motivated by a report from a user who expected traffic to
be redirected to the backup port when the primary port was put
administratively down while debugging a network issue.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_forward.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index 29097e984b4f..870bdf2e082c 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -148,7 +148,8 @@ void br_forward(const struct net_bridge_port *to,
 		goto out;
 
 	/* redirect to backup link if the destination port is down */
-	if (rcu_access_pointer(to->backup_port) && !netif_carrier_ok(to->dev)) {
+	if (rcu_access_pointer(to->backup_port) &&
+	    (!netif_carrier_ok(to->dev) || !netif_running(to->dev))) {
 		struct net_bridge_port *backup_port;
 
 		backup_port = rcu_dereference(to->backup_port);
-- 
2.50.1


