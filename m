Return-Path: <netdev+bounces-152328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A98799F3726
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 18:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9DC216A72D
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908B82063FE;
	Mon, 16 Dec 2024 17:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D7N32GH7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7F52063FA
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 17:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734369206; cv=fail; b=qF+qhCCWrkTlrEcIEi9FuYLkOlrbsW0ou/qkWpZXO0dOhA5dF8Q5HQr4AKEBRYtwsl2GE/7Ioc4h5x7IF5688juF+yq4L16RpdPN4RSI5e+nzeX7HRV1jhi869VEQMYHQ7ALSIQ1RJaIe9ztXwH5e28i2C02wYjv/7M5AcZnhhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734369206; c=relaxed/simple;
	bh=PkHp6h6QCETwfm4iX1knZV4yCndI2eATHLI/tu1Vo1k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xc22SUNSN9kcXif00XB0cXk/RUOYCg3rAAqkJOmHSpl5NbxM7sNuBIyKi1Pjdi2owa0wWazsQcX2m/c136+AXGuEz3s4tBx/7aMC17IOlhSecVGz7CQlwz0MhwcnMXJqArJCjNAikb97LrisfKT+8OqYQVxylugo/N/w/9rBU6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D7N32GH7; arc=fail smtp.client-ip=40.107.223.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xwEmP+02mqzt/Pvu9Vxueya1UI6l5g3zBGEnAzRtaOaMot4mo8uFQ7Irv2ocwTHiW28zfq+8v1N4mHjYeLPJq70gjbt/DBakEQZ/dw6MrUejiMxJ5NEgYA3pe/bUVp0ksr29RueIysX3S02a0VxWre1mxriWm2AOvsvFqRL+5VR7kMH5x3eSzKKRtTN7GhYm1Ww0/pCgXe/9gWL79Ga0ldZBPB6oCkuou0BETSspe+SH2C7XUhVKI6+MUSBg03OcR4/ZatpNlWCUzghBXjmhOgmwxlttOjQ+74mscRVTJ2DREfslylG0G5O0LxJc2oCYhpthkMEzBzbXyFehork0rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hDFl5DQCb7WIs+QxTm6JoFCeG9SQan1ECPyI/2pwCpM=;
 b=XFQGd9DDL4KNxYbouveekdGvJcQZVminelvFopbsCBNcBmWYG/eRgzaG2y/gkYpXdhy/FWQhLvGBhkLaPW1dAAe9XXUJPifBpF4VEADvqYUVN+eKbtFGOMFxTdG6Kk3HGy7rgfl7GhzR6I6GjQ0Y7JKZqFAfezmNigdUZVXbO31xXHMS4ZjDGlPuF4eE9Va7IdRwbC/+vG6RIxXOMa4TmLvCa8jM2aYAE+DJXNos9rc1R72vINo2+CnwywxHAeY5WXP5Vj4EPi5IPw5Jhf2M1GmgbZOkxvp8gsGx6rACwETh1QiWcDmmXRryBNz9v6YvhiubBuZbOWOGcae44/HQwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hDFl5DQCb7WIs+QxTm6JoFCeG9SQan1ECPyI/2pwCpM=;
 b=D7N32GH7YWekUszXMyj/DjbFDrRIy7bievYvMHvyzASm9qUneWZSDXMESGQC+ldjYsD7ZFYeAa6qQZRCfH+1kZBq17kqvUKx/JUM/hgczJ6Mub0kH+85ys39zL6qUlbU9Z21bTCqHKHgnQE3Mk4C55yut+XGUEoo6QMf3osUUkuKC/CFrpC1zcAMWElc6h0/6CsjGEPFxazLQD3vfEkbYkUzYWoVKiO7bUf7nb4AvrXo7IBJWzXhQwLztgH447mnNVoCqDHnqUNX3eV8GnUyxzBfOOJwZ8SCuoG75AOpMgLxdKpD4zdlrETqQ0nzBBIau9NThiZ7eak3IdZF1XBZMQ==
Received: from SJ0PR13CA0131.namprd13.prod.outlook.com (2603:10b6:a03:2c6::16)
 by DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.20; Mon, 16 Dec 2024 17:13:21 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::23) by SJ0PR13CA0131.outlook.office365.com
 (2603:10b6:a03:2c6::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.19 via Frontend Transport; Mon,
 16 Dec 2024 17:13:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8272.0 via Frontend Transport; Mon, 16 Dec 2024 17:13:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Dec
 2024 09:13:05 -0800
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Dec
 2024 09:13:02 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@kernel.org>, <donald.hunter@gmail.com>,
	<horms@kernel.org>, <gnault@redhat.com>, <rostedt@goodmis.org>,
	<mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>, <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 7/9] netlink: specs: Add route flow label attribute
Date: Mon, 16 Dec 2024 19:11:59 +0200
Message-ID: <20241216171201.274644-8-idosch@nvidia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241216171201.274644-1-idosch@nvidia.com>
References: <20241216171201.274644-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|DM4PR12MB6351:EE_
X-MS-Office365-Filtering-Correlation-Id: 532bc602-342c-4557-35d1-08dd1df4f0ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+WknqNQ1O91yrgszBnyDKyIwEmTYBpUTpnmkQjEMib1KsN3R2uEadSnGcLMa?=
 =?us-ascii?Q?9MYZbnDWW77LpeVYXSbtIN/dx5xNzqpT3sFBLcLYRMkUZ8WA3LMmi76+VZLl?=
 =?us-ascii?Q?EcKf+z67dbkJ4rgEvoQe+Sgm7Vcn+aicshiyi4TexQZ7/E08jSukCuRcDQMo?=
 =?us-ascii?Q?uqJDr/uQajUU07izNUZctCsGF6au/lN0WGKI9HleVNbvBOnxAbwl1pLiFfVp?=
 =?us-ascii?Q?NgUzz2eHqNDad6x2F83qSjmC6Rp76ksE66edx/Kh0IcPl5orUy78fTdXxlfr?=
 =?us-ascii?Q?8axqQgbGz42Dj+Q6rqq9npQ1OxFpvfTZG0KrHEt7xyfq3eF+L8rlQMvX/QS8?=
 =?us-ascii?Q?0t3A5mQ51WmYP+In434u0JsnVKxvTyvyBySWHISeXxAltt9tUoof/xzmPw9Z?=
 =?us-ascii?Q?eS8mH/NbK+UPx2DfTztWHZ4nKDMW6Lf8i6kV+1tA/LLXqDUhNyZySBMIIg25?=
 =?us-ascii?Q?Lt98w4eSZRqsMFIC/kdCNwNE/n2W9A5qgcslxG6kZZELeKfM3dIlK+DDZ2Ld?=
 =?us-ascii?Q?Sgqije3++/5PeOipT9irMXVFxN4z9ps7Gazq5XoBl0su3bBXLjEDsZjAcnxS?=
 =?us-ascii?Q?plSwb2VevoXbFqClzMXVsuBCHYIYWl8leYZg0TyznkDTdceWL2oyrwOzTaTl?=
 =?us-ascii?Q?L/fVRBHjxgWl4iTFGHj8SSQuu2+CBUy+SC06r+aciuSBd6uxVRSAQie/AGbX?=
 =?us-ascii?Q?3EzMyiDijSPle2eJPxcGdoODdL7W9AlgIA1AfeV63GTpA8U8idT26P+zSyDi?=
 =?us-ascii?Q?DngOdSBGs71VqEi6ln2ViMbci0A6SUMlhTj5NZBTkhrnr5Uh8yqTtSLct6qu?=
 =?us-ascii?Q?kKCTjUZP331Jz3YDMZbNzPYkf36XSYrmIKLqvb8ERBuZBhCejln99R6q3uam?=
 =?us-ascii?Q?NWmsLYgUiu+qP6ucowdFLqwaG2bTpxg/cc5KMxDGmdIFuByWG7F1pHtONEO6?=
 =?us-ascii?Q?95pRPudlQlOtP+w7vDRgKDxhpEO+kYg9/4/KIXwEI1sDDQjKSi73Nc8sU+2b?=
 =?us-ascii?Q?+ABgX436blmRGJST+GMU+P8eCE0P8SDU71Fcm6jo4QRpICDMwXR9dopJwMP0?=
 =?us-ascii?Q?JcgjYMjhQ5kEQnWzDy5xTgKu61+zGwtgyWoCHG+N2RkyOruav86DscBAl0H5?=
 =?us-ascii?Q?NRuhGdOiQoaCaYD1nwxQL5rxXqxcfxu6b/D7U2cM1KhiI07zTvotAxTiqLgX?=
 =?us-ascii?Q?3Mr5DGPJFF8ByNnZRsebFZFr5fjrkzk8CFgNFRT1o9GuNQ/U3CNHZpzrDfSw?=
 =?us-ascii?Q?rguROZBrzIIOGUjc2xniA6naL3dLILOQmM+MysTTm+/qeNHf4qOIxePADMm5?=
 =?us-ascii?Q?c381N566X66WdKn40gfBxoHQwVpAB8j0Qn6FY+I9kIVsR/h4dBi/VqVgZo98?=
 =?us-ascii?Q?fuBg9VVVI1LQbQanmHcY1UUEKw1z2UuFKlqWppbVW2mO0BoAk2fke3DsPz4G?=
 =?us-ascii?Q?lqIV5boBu4aJoV9YM4eW1yCzhAjJyg/mCkgfbo5x/PhJKN5WV+g0WTLmyFYl?=
 =?us-ascii?Q?eY3Mb1iSXB/rBGI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 17:13:20.6622
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 532bc602-342c-4557-35d1-08dd1df4f0ec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6351

Add the new flow label attribute to the spec. Example:

 # ip link add name dummy1 up type dummy
 # ip -6 route add default table 254 dev dummy1
 # ip -6 route add default table 10 dev dummy1
 # ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/rt_rule.yaml \
	--do newrule \
	--json '{"family": 10, "priority": 1, "flowlabel": 10, "flowlabel-mask": 255, "action": 1, "table": 10}'
 None
 $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/rt_route.yaml \
	--do getroute \
	--json '{"rtm-family": 10, "rta-flowlabel": 1}' --output-json \
	| jq '.["rta-table"]'
 254
 $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/rt_route.yaml \
	--do getroute \
	--json '{"rtm-family": 10, "rta-flowlabel": 10}' --output-json \
	| jq '.["rta-table"]'
 10

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 Documentation/netlink/specs/rt_route.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/netlink/specs/rt_route.yaml b/Documentation/netlink/specs/rt_route.yaml
index f4368be0caed..a674103e5bc4 100644
--- a/Documentation/netlink/specs/rt_route.yaml
+++ b/Documentation/netlink/specs/rt_route.yaml
@@ -177,6 +177,11 @@ attribute-sets:
       -
         name: rta-nh-id
         type: u32
+      -
+        name: rta-flowlabel
+        type: u32
+        byte-order: big-endian
+        display-hint: hex
   -
     name: rta-metrics
     attributes:
@@ -260,6 +265,7 @@ operations:
             - rta-dport
             - rta-mark
             - rta-uid
+            - rta-flowlabel
         reply:
           value: 24
           attributes: &all-route-attrs
@@ -299,6 +305,7 @@ operations:
             - rta-sport
             - rta-dport
             - rta-nh-id
+            - rta-flowlabel
       dump:
         request:
           value: 26
-- 
2.47.1


