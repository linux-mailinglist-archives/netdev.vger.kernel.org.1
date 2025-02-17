Return-Path: <netdev+bounces-167015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC46A3850B
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 14:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 606E23B3D67
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 13:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B3921D5A4;
	Mon, 17 Feb 2025 13:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jOXCBerB"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60AF21CC60
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 13:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739799741; cv=fail; b=ET2BtTmThz31Z3bC1IfZcUsILyEgjEM6aKXy8L5A46vLeNNKGf2DlJl7nyc6bzSWFD9mi9tosrHLrOYqnVM+GR76NHmazrYE0lsdtj66zjxOYJ+F++7xgDvxEW62iqn0cxdh/t+Ll9qESWpdSzRF6NOrBDAybWw9kosd67gXrHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739799741; c=relaxed/simple;
	bh=e3IiDkCxRzUsk95YAoQXyJgfi3nnPlGirNFHc9VtHZM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iIFTcrim0WBEuq+giRXzsjGc+QZbCbEz6Mg8IIl86eqfQ7tZllJh0gjaIVYOxmGe9644VvGsusdfvMciULD+n3yJJw9QhqJJQhHDc2nbpf0m/yyZOlzvFELCeug3i85Ani/iP/QRbP79np7a56CA39Fttqmi/v5KrkL8PzqtPmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jOXCBerB; arc=fail smtp.client-ip=40.107.220.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JVZyd+qveP9/IS62wrYP8Rj9kggbn7Vt++r5hWvWD6FrpvX8T153qfNwuT8HmMXUt0KvdaAgsa15WAmbQgsbFrJ+FQ5ksjd9ZkrngYhky+diKnkPCUwFkutAiXbcAR63K+HsZpeFSnF6cgjXgOQ64z+np72dnQLVxI28v7DjL3kAQyGckTMq/MXIhKHGr1Kkn8RrEiugbTDzSGLdzImW/UGdfe0fCp8HCdSzSMptrMuCsUuMlTl5MZSPeIay7M2+MexFdvNntce47hmee0+fmmlqVMJ2oEqt5bqzMvieFkCHSQF0XHHFEILIC4PjBuEXmOe8OOxSYz29GKEpl78zCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMfDmwUPMPruvLyvSRkz90XQITwMvQ4ri5SYPiaCwjQ=;
 b=vAZHXW4vyAt708ODOYR8Hk7G5ST9jfXi+2wW2lGaCtTZzyfD7WvDUgskvmNidCBa5Q8aWCSIgCOgXAZlIUgMkTf5i/lB5p7j6tOjya9mlI58Q5bisdAJUH4UzGtR6Ldg2yBOw5ExV/1tddoECeWOX+erDDxsJFweM6d42X04kJawPxOPckLSFFWmjXGqowgzAWoui9E45lWGFrZeJRYYhcdJgixNccIXMAyvOeyR9HiDSLfr35WQK1CNH9aaPs2kBLes6GgGdYEcuUJT2kCNGgmUaf+Je2qD1F0DCoYdJaLS9tyR5V5+luBI+V4O4YIYVG9pQVKiJufjDoWtj9sTUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMfDmwUPMPruvLyvSRkz90XQITwMvQ4ri5SYPiaCwjQ=;
 b=jOXCBerBaUmbhitMbNfpJKBMTFsswZpDI2uQOE/+X/KVx6BRa01T9DliYTOHBPWQVCFBv1fsErIPFQEmeV/ecceoS5soJFuE+KUdl2gDZy6Pet89+WHWuEKXNXPXunthx//0Ful/M+u37W4jhQmNcQhf5gXyabr+NVMyaglAoT8925qhg4RVYN1thZ5iSDw6Y6W2Hc85qFDG1jOekYfW8f6/iHilwhlD3VAl6epjTODvTlgktC+Y7NuFJ19QSkXp/qlUWnGU10nMsBrrYNPOikERY4uYoQ6WhLiIVvMzoRcVgVXlMMSMFdcln+d+mUUgbL4zCf72Zv58J+1GIqLyhw==
Received: from DS2PEPF00004555.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::50a) by MN2PR12MB4440.namprd12.prod.outlook.com
 (2603:10b6:208:26e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 13:42:16 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:2c:400:0:1007:0:7) by DS2PEPF00004555.outlook.office365.com
 (2603:10b6:f:fc00::50a) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.10 via Frontend Transport; Mon,
 17 Feb 2025 13:42:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Mon, 17 Feb 2025 13:42:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Feb
 2025 05:42:07 -0800
Received: from shredder.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 17 Feb
 2025 05:42:04 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <horms@kernel.org>, <donald.hunter@gmail.com>,
	<dsahern@kernel.org>, <petrm@nvidia.com>, <gnault@redhat.com>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next 6/8] netlink: specs: Add FIB rule port mask attributes
Date: Mon, 17 Feb 2025 15:41:07 +0200
Message-ID: <20250217134109.311176-7-idosch@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217134109.311176-1-idosch@nvidia.com>
References: <20250217134109.311176-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|MN2PR12MB4440:EE_
X-MS-Office365-Filtering-Correlation-Id: 351e7980-36cd-4684-f786-08dd4f58e449
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wZ7plwiAqp705NyAGZfztH1O84O3RMKBtJXwO/8G0ZW+U5srJ2UW5/FsCBXL?=
 =?us-ascii?Q?pU7mNMtR2lLJ0IcwsCFVPd9ZdxpsA6p+cQAAosDjwbANF14T38ybwoFbhdyx?=
 =?us-ascii?Q?0v5DwmIn+FdHiBcqLY06q0g9UnWGVdX3+1RY+4TYokX8S/JJ44VAL1DkDSK9?=
 =?us-ascii?Q?BZfUmNTQH4LrssH38YTvwCy3ccDaE5GqmqeuPIOx2tgM70ze5BMs4CT479ha?=
 =?us-ascii?Q?BfQJCcQJeeMvq4BjfH3zXZV3J6in/IWJJbs82YK3+rvReYe5LKlic3cQV2L3?=
 =?us-ascii?Q?L3F14gmKWpc9AadduoWvgtUy1HItuitljnpKqZO3dvp4D++nHoGLJS9wVYNN?=
 =?us-ascii?Q?MnSMB89PhtvZgRE976eg/OQAsTeLx1txVPH3X26T2UDCfhh1U4zO4GgsnD0R?=
 =?us-ascii?Q?k1ChUGlzQr5lYBURCRIN9w0gicvLv4cHCF4F2HZPCSDWB4cTJ1aifbSjTbiQ?=
 =?us-ascii?Q?4ifNYCZRQhWSl+d+dcNWpmkWkKF6SzMLfvsCijBsHfZLP4aa+fG72AIs/biP?=
 =?us-ascii?Q?EHLuSG1sXmBac0U9Fa8gY1Q4achm7pWe81JXLz+OT0o1UHovEltVmeZH2+4g?=
 =?us-ascii?Q?JuATI7sJB+1jNCvuP8ncJWuV1KEVqdBSqdoO/7ftCcK9PtDpBpRfxW8LogvB?=
 =?us-ascii?Q?3WJlQER4rzizznYlJ7KVaDrRiPZWO+NuqIheWlohbjVvfjSEqqvrDR7RK8dA?=
 =?us-ascii?Q?KyCY8NdkVtJ406GytIFfFyU2pWt9+OVuocWMjLAK2ZTZkMtow6Kdwxs+sv+K?=
 =?us-ascii?Q?UJPQQ9MpiQod+emv5v/3AzkoL9HZ7sbxTIbE2tbw0BdXF7dCM5inaquIgm7X?=
 =?us-ascii?Q?4ESAIh8B1AO7clLzRgMr3NDPq5ZgtW7tchXKnc1T8g/nNHPeM56OG28MfAn3?=
 =?us-ascii?Q?SVMufu0TsXAykRSl6qTpogYy6Suh1mYj/7a27qqj3ebvq5og3AZQSj2jxJgs?=
 =?us-ascii?Q?GtBoiQpnIxDVNJ15LWcOzwAe7Cd4+vZxu4O8seANrDLGFYSMmoJgDIqQ1QOX?=
 =?us-ascii?Q?F851SZUNxIxouxvbRPCEHH7km9IwacaFy9JSzGFJ3q+qTfsGxb7BOnFVvvvs?=
 =?us-ascii?Q?CDAw1UZnaeAbcZI6jlgk5eLhFKnOW7f28C0aNt3FiJIpiN/POFMsMGMUO4j4?=
 =?us-ascii?Q?IQNjsOZxf8FXK+UjPFooJOdwEoWskpGcHUiKP5yY+0BEy8gr6p9wQKBonb/z?=
 =?us-ascii?Q?As/l9NhJ83Hd2EBjNGCEMILEnMyOP/afp4QAjwODtRM7LBNcdPARlNuTFzDl?=
 =?us-ascii?Q?L1POgsJxTZYgRZLnlzlJ1ac+iTUcshrnwS37s2PXu34v4Z7XM4BVlWT5BpX3?=
 =?us-ascii?Q?ca9DIAzIfBkDVhpkzz1hHXprLkxYZ0ThdnEdcla85CpKsaWr1M882LwUzKJJ?=
 =?us-ascii?Q?2+fmxzIHHjufFkQ19kQAt2Aw2A3Db7ju28aRPwiA1o77lmZaXdO9ffbdNbmr?=
 =?us-ascii?Q?BTeoeIX2FGyjFOKS986fBn7nO7eC4TSGnwEVlCXeEtjm9UI92q+mNsxiKwcA?=
 =?us-ascii?Q?CN1ZgLdulwphWWU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 13:42:16.0841
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 351e7980-36cd-4684-f786-08dd4f58e449
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4440

Add new port mask attributes to the spec. Example:

 # ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/rt_rule.yaml \
	--do newrule \
	--json '{"family": 2, "sport-range": { "start": 12345, "end": 12345 }, "sport-mask": 65535, "action": 1, "table": 1}'
 None
 # ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/rt_rule.yaml \
	--do newrule \
	--json '{"family": 2, "dport-range": { "start": 54321, "end": 54321 }, "dport-mask": 65535, "action": 1, "table": 2}'
 None
 $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/rt_rule.yaml \
	--dump getrule --json '{"family": 2}' --output-json | jq '.[]'
 [...]
 {
   "table": 2,
   "suppress-prefixlen": "0xffffffff",
   "protocol": 0,
   "priority": 32764,
   "dport-range": {
     "start": 54321,
     "end": 54321
   },
   "dport-mask": "0xffff",
   "family": 2,
   "dst-len": 0,
   "src-len": 0,
   "tos": 0,
   "action": "to-tbl",
   "flags": 0
 }
 {
   "table": 1,
   "suppress-prefixlen": "0xffffffff",
   "protocol": 0,
   "priority": 32765,
   "sport-range": {
     "start": 12345,
     "end": 12345
   },
   "sport-mask": "0xffff",
   "family": 2,
   "dst-len": 0,
   "src-len": 0,
   "tos": 0,
   "action": "to-tbl",
   "flags": 0
 }
 [...]

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 Documentation/netlink/specs/rt_rule.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/netlink/specs/rt_rule.yaml b/Documentation/netlink/specs/rt_rule.yaml
index a9debac3058a..b30c924087fa 100644
--- a/Documentation/netlink/specs/rt_rule.yaml
+++ b/Documentation/netlink/specs/rt_rule.yaml
@@ -182,6 +182,14 @@ attribute-sets:
         type: u32
         byte-order: big-endian
         display-hint: hex
+      -
+        name: sport-mask
+        type: u16
+        display-hint: hex
+      -
+        name: dport-mask
+        type: u16
+        display-hint: hex
 
 operations:
   enum-model: directional
@@ -215,6 +223,8 @@ operations:
             - dscp
             - flowlabel
             - flowlabel-mask
+            - sport-mask
+            - dport-mask
     -
       name: newrule-ntf
       doc: Notify a rule creation
-- 
2.48.1


