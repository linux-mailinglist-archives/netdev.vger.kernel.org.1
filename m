Return-Path: <netdev+bounces-152326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 269339F3725
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 18:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B530169308
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E73206285;
	Mon, 16 Dec 2024 17:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MahnpHaC"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2055.outbound.protection.outlook.com [40.107.212.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523A7206292
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 17:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734369199; cv=fail; b=D5NNSxK2euQMVqUCC1xBQdwv5t1Hz9GNswUIW1rAg6nGsAEpm2OmaGvsTtDnVLzEOVK0d7FotZukwOUHBWOpTG+EKU6QYmqyVDW281kAj/CVo7Ljr6H0plQ9C9SRVLwA1v6b9XuLQUaMXm2QFSqaoRP3CwUrg9iSaXho+N2Hu9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734369199; c=relaxed/simple;
	bh=oKZf3mppMcPmGvY7E/aGNW46O3dRqQOMscuPW2ukaKM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xlz298feRroBwflX5QCc96fIDyFrQTJp7lQNmhhorxdcB719hwSjuA/5YRHRysgtioQoU9J+vPL9B2cQZRVqLKA2i9IZtpR5lVBTyhhhY1dkZ+L2ITFq6lBP9p0Uj+toIBsemjKJyyf9ZS+TPp3bMZ+7rq1wvga9USk4QryU4wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MahnpHaC; arc=fail smtp.client-ip=40.107.212.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j/GbtnYqpqXDWUAp+XNIfPcCntSX+oqx4+M1xW+hsxY/b/WWwOer2QWA0IfUDNaW4ogdrNdC9uPWoGC21b1C0dXVVRpLoWDHBMT1kRQvCpc3gs7Eq1/rWcUAMuHkxC+8jYOITk5UHKdRDsVer7vlNmC1Bqf/CMVugVggWuTCu6YYqGmqShoVWCFytZ8QqCx+WQC/t7vL8ZOf5Tr9Y1TSi+2Co+wCkmIfmyWlfg6dPr3qn7giOgSK/UC720WLHLfYEdxQ1zhfEcCmVwk1YqztMOgO78FddMLJibN5Yqi3r6jEJJNNlgRlcHGkFKmY5JaIjbHroIUtAmiWnxYMyC/PLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AkXlPHeBrzKhmlh/02F4ylN/lxnTZ6gTHPZ/lGM7jNk=;
 b=UZjaiQYSo1LPuQRKyKyr9w1Teu9TMMxQcwC2Kk8GHVy3FEpHwT7/9FtPCbj+iYYAXhIXIoGA5o8jBB9OzSLM83JDKi16tRQ+rqDDI9kFqWjRsHKnYtI18RI8+Ea1MNSethAgH4mo7dDmKshJoqHbSnvf9DiWXPo161PNPu2tesIxuQFklYJzUfwQDDjY17WOTH79+t20Jnnys5S/9ik+XjmmI4w4Z2g3dneHHEbufNY7vbeMHd+0F3cSyZWG2QKy3QBxSn5TXhXQgpOsbNKlLoCBGAE5BXjLrHzxDRwZ1EiFB3Dzr2gGPIDbvewIzrMlptzWO8mZN3dtrgwwTWbftA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AkXlPHeBrzKhmlh/02F4ylN/lxnTZ6gTHPZ/lGM7jNk=;
 b=MahnpHaCq7qxkV7AmdLyOSLJuYfz/MSIG7K0iUllKWRkKlhdUDjhQ5yEX9nq2jCpD8LEJtP5dTAAiaUGppcdCy3EXtItnyO+77FNNTd3PekntJrSK40AL8Eb1bFy1wIK3b/pWSpYqPfMI6GV9Oo7E8gtV9V4iHtLKo8dC6TyLjwvje2X1x3EuHKWO3hzBi9p7T1XYgdhBisdqXW/od3jFZTZA+wd99QlMvUS8v6HtZrsn2LWqLunFolTH1W7yZPUWF9NZtLYPmLpOy2f/ypC1ELZVaziAL/44SBsEtLXFC+Y7CNJznFyWbpU3CyYuaD71t1D1e3mdCwkPEBZwzwudg==
Received: from SJ0PR13CA0127.namprd13.prod.outlook.com (2603:10b6:a03:2c6::12)
 by MN0PR12MB6174.namprd12.prod.outlook.com (2603:10b6:208:3c5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 17:13:13 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::7e) by SJ0PR13CA0127.outlook.office365.com
 (2603:10b6:a03:2c6::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.21 via Frontend Transport; Mon,
 16 Dec 2024 17:13:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8272.0 via Frontend Transport; Mon, 16 Dec 2024 17:13:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Dec
 2024 09:12:58 -0800
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Dec
 2024 09:12:54 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@kernel.org>, <donald.hunter@gmail.com>,
	<horms@kernel.org>, <gnault@redhat.com>, <rostedt@goodmis.org>,
	<mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>, <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 5/9] netlink: specs: Add FIB rule flow label attributes
Date: Mon, 16 Dec 2024 19:11:57 +0200
Message-ID: <20241216171201.274644-6-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|MN0PR12MB6174:EE_
X-MS-Office365-Filtering-Correlation-Id: c8e5be5e-0aab-4eb0-95c1-08dd1df4ec1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K0RmPT8asZsknbUxt5kKSawRMaMKRDaSn8DaGcwPRmyb6EckQxXUN6YjORfv?=
 =?us-ascii?Q?Spu/BBAokZCJVRpSlEIurbvREm4CtHQMCQR7rLKL0HrJKJFU5JG54NKBA0An?=
 =?us-ascii?Q?vqzgMNAF2Q/lT9K8JukhZ2g5SjOlN5ku1yJGs+sDXEFsTeuQVXsiCwybVqvs?=
 =?us-ascii?Q?GTDzr5weiaB4qS+AjA3InDTkayka5ovnXVmksIcaveHymZtg526XAMz3m0u+?=
 =?us-ascii?Q?Kd3KBk6iuaOZUm4KYDoljzQGHDzubuc+kQZGuCjQF2b4A0pdJ9uaTGijHzet?=
 =?us-ascii?Q?NO4Lu03fvfcDx7qyRKYyGBr4r+McKHrApx5DcbueYVuZBHAeve47ElgypM6v?=
 =?us-ascii?Q?6RFpKtDmp5aJforexRvSqVttLuPECwXxpuwgQ7du8/0ifhMGZw4EpYE8Az9F?=
 =?us-ascii?Q?v3p7hB67pQXwULqY78lacdVOW5F6OBjSJ7WJY1wc70BbZgAVdgNC1eOS4439?=
 =?us-ascii?Q?prODwcRur7WFYE5W5Z4SQsVPzcqikXQVRbIuL4ZwJ8h0yzpzq6xfhEdQSoni?=
 =?us-ascii?Q?nAMhZnPE3ubPWyXsWVXgrcuRC2aVLn8ynlyiXX49UlQIVgDSbhbkNK9aIEG0?=
 =?us-ascii?Q?ChdJxjhyJeXeopPf23NIGbkg0QEWUdG09DRsxKugBzWJWUO9h1AIQGhLVk0r?=
 =?us-ascii?Q?z0wvB3CAojCSOVn071PLhwS31yElCev1fYLKAh7bBLw2RKFBE4EQDcBsaxQS?=
 =?us-ascii?Q?48VLB8pd983Efrc9SLnxVyWOch0mQjHE3B1CtSs6TLsjYN2sErqXgSuxrFfl?=
 =?us-ascii?Q?5I1prtu5sLNt+2ydjCgMADtGUt4cURxKhMR29YSTEaskgo/YsLiiz3COjz5N?=
 =?us-ascii?Q?GyZMZX3knOB6BqHbXowiN0UIveGNTSl3lTR2ufOWtz5b5xvC745EseTGQ/Al?=
 =?us-ascii?Q?2eDf/R2ZNiJ2EwjDeysFncD5fbZeo8dDUihMBoRlEkoINY8WK9af29gel5vd?=
 =?us-ascii?Q?M9vy+NPwXSmLz+b9dtYKcaeh1hYSfgcBb3JKxhyRX1aoN1QcxVs0gNwAng3D?=
 =?us-ascii?Q?VPLyDkfW67Cdd4pRmbQSzRTRQmhtIVmoJg+GAk0WiF+DRHUNTDP/ZodA3E4Z?=
 =?us-ascii?Q?+vRn2tlW3UtoVjO2fsPBmCjmQeEeX5uYEdoOlIi7LIu7Duw2BZSxwEISYURA?=
 =?us-ascii?Q?asEj/lxESXGWhFPppv5dOu54u4VcQ3/a9gOCEvaRqrA2cDAEeXB+Gwt/tQYz?=
 =?us-ascii?Q?2dTySLMTHwPRgz6AabVPqIO0XGPC+NJaxqs551eBbX44grNsDKLZHWB16rrw?=
 =?us-ascii?Q?fsgUxA30T2cjPNZY5tsA4QLztkUUnpFwkmXKKpBeoU2raqlpCTCWsI55uQKG?=
 =?us-ascii?Q?HJFrOvSg37yqBoH53OzVFHeRDDsQg3/sZY//QMWR/Rk1hI/hIhX4t0/yVMNu?=
 =?us-ascii?Q?fohtn1UF9p9YhVQQM7EESjzb0/Src/gKE2CZp9fs37kggwPGoV3bM35ltYCP?=
 =?us-ascii?Q?y/AtuiNKFVV3E3R2o7m7MckJRMw4Kl6thCXoX7tjbQQWstfNSySuJ8drUof2?=
 =?us-ascii?Q?TEXn1BSBMLE7DRk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 17:13:12.6153
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8e5be5e-0aab-4eb0-95c1-08dd1df4ec1b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6174

Add the new flow label attributes to the spec. Example:

 # ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/rt_rule.yaml \
	--do newrule \
	--json '{"family": 10, "flowlabel": 1, "flowlabel-mask": 1, "action": 1, "table": 1}'
 None
 $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/rt_rule.yaml \
	--dump getrule --json '{"family": 10}' --output-json \
	| jq '.[] | select(.flowlabel == "0x1")'
 {
   "table": 1,
   "suppress-prefixlen": "0xffffffff",
   "protocol": 0,
   "priority": 32765,
   "flowlabel": "0x1",
   "flowlabel-mask": "0x1",
   "family": 10,
   "dst-len": 0,
   "src-len": 0,
   "tos": 0,
   "action": "to-tbl",
   "flags": 0
 }

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 Documentation/netlink/specs/rt_rule.yaml | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/netlink/specs/rt_rule.yaml b/Documentation/netlink/specs/rt_rule.yaml
index 03a8eef7952e..a9debac3058a 100644
--- a/Documentation/netlink/specs/rt_rule.yaml
+++ b/Documentation/netlink/specs/rt_rule.yaml
@@ -172,6 +172,16 @@ attribute-sets:
       -
         name: dscp
         type: u8
+      -
+        name: flowlabel
+        type: u32
+        byte-order: big-endian
+        display-hint: hex
+      -
+        name: flowlabel-mask
+        type: u32
+        byte-order: big-endian
+        display-hint: hex
 
 operations:
   enum-model: directional
@@ -203,6 +213,8 @@ operations:
             - sport-range
             - dport-range
             - dscp
+            - flowlabel
+            - flowlabel-mask
     -
       name: newrule-ntf
       doc: Notify a rule creation
-- 
2.47.1


