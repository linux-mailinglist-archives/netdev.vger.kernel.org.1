Return-Path: <netdev+bounces-168039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7148A3D2CB
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 09:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C72D17A5BB
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 08:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4E7249F9;
	Thu, 20 Feb 2025 08:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m5NAemee"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2080.outbound.protection.outlook.com [40.107.102.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56351E9B12
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 08:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740038823; cv=fail; b=hALmmKq5V3jnrCgr8QsBYufZ2PnJTC/OnmWMA8yIqdjMh0V0p7mwdcIYLoMsHWh7BlO/NcSivza/nBnWRbRLglYn3rpuGW6xmFbBkUXWiAb/PqWsJANqWU2AoV9h4GyQ7nCjQGSf+VGZsgIlXKYnhhygsW6NP+hgqn8Q5ovKEew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740038823; c=relaxed/simple;
	bh=WdsgSzAdmTrvO307Z/V78Y8UMMxeKBhnyZbWyiUE3us=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RSr7wQ932EWHUvr5yYljJ6OWduF4OP4VwDAc9BbzHXa010ry962DpTJ3GJiwSlUOHKWwjwZ0APy//H2FZ1ent0PfuZdxshm0idzV7Es41TV17m1N6vwEo9eF4c5BKfCdq4YLPiaMKBfrALu0DxmMmOqwzYcpeGBF1zCY9btqfzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m5NAemee; arc=fail smtp.client-ip=40.107.102.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yHHyp1nqDHmoLPfbAPC8ko2IkyXUQFkgk6HL/NQNAaOHIYdkjx3EF8s+jKznFdEwl985v2CIR+oj/5XsAp1ESt6xfECoTPvcuzvAcY2NPGzVSkq336FveLi9yTuKFsqfp/rdKpYdCfh1a0WHaoaZysRKVVYvEbW5DO3sK+2MoX9/8sJf8oehEDn39WmqDAMAUq7EaVQAzl+2UPOlG3ldhowEfOBSKs1Hk8Qkn6lxRYuXS6y2zLsjV/UnSVcUwEZ6VQ8xIHsqAx2uMbYwIiQVZwVndDe52fCW9YE/M0DulP4CKJmuYu0jZByPzSVIQBvibll/OTZZBURC8GD0k7L87Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u14IjzMpcu/T7v8KurmYjTL7GimNqJd8/rKHaocg9Y0=;
 b=UVX2vkZ+O+9D7h2QSPKUbKz6q7r9MzE3wITwUa/zd5NLDR+KlK3nv6VplUcUiIEfMWN7LRAb+D+/kX8pbPmSjRGXtX8JHM9hWXL2fwAcSw7iETLT2rnHoX46VBBsTNbET/v0cljZ+iutrdsBboVTJZQ746Kmc87QMfrY3Z5yvFn1lYmuaJ8O3jYaU710ai+gb6kiZ545no6kO81J/TB/WNfRWpjq2aCkYA8dT6VettmllrXCaiIPrmNO0gsu5bRTXuziaPN+oIn8aeTzGdK5KeNk4fp+ISOwKv3dxEI3uRyDBDh8Aip1n09nCF6ilsga7njLJXrVdFdRByNMPsj7Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u14IjzMpcu/T7v8KurmYjTL7GimNqJd8/rKHaocg9Y0=;
 b=m5NAemeePzWpj+/JDNkf1ghpWRPDpLuOwlIoiJh8Opa1/cWe5ENm+B0662gZ3zoSw3VrZYlvibIpQx80cyrQIAOeoNWKR6e5brMVA1BXWI6Inv5RGVwfnN/JssiPjsqoOQB23kTWBHnEeNzJpCDiI9J3FydG41qdkbj+2Q6NfqemfFddV/u5neZR9/o828cQLH6cihkrjftam7keqhmDLi3TcHgvErmGRemYTON+64+jQFRCBiWefdVeAfjLbyHo781rQMR/FAR2xOTWGb5SeO+Ow57OCcnbzQW61VXpvcH16m/0zyOD5r1TNHO/9JbsgGPXf2tUXugh28E4Ik8HsA==
Received: from SN4PR0501CA0129.namprd05.prod.outlook.com
 (2603:10b6:803:42::46) by DM6PR12MB4266.namprd12.prod.outlook.com
 (2603:10b6:5:21a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 08:06:58 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:803:42:cafe::87) by SN4PR0501CA0129.outlook.office365.com
 (2603:10b6:803:42::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.12 via Frontend Transport; Thu,
 20 Feb 2025 08:06:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 08:06:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 20 Feb
 2025 00:06:44 -0800
Received: from shredder.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 20 Feb
 2025 00:06:41 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <horms@kernel.org>, <donald.hunter@gmail.com>,
	<dsahern@kernel.org>, <petrm@nvidia.com>, <gnault@redhat.com>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next 5/6] netlink: specs: Add FIB rule DSCP mask attribute
Date: Thu, 20 Feb 2025 10:05:24 +0200
Message-ID: <20250220080525.831924-6-idosch@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250220080525.831924-1-idosch@nvidia.com>
References: <20250220080525.831924-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|DM6PR12MB4266:EE_
X-MS-Office365-Filtering-Correlation-Id: 73506780-dd26-46e7-9e4c-08dd51858bff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6KGiE++bbTKFlNGx9bg49NsWM5GUnGrydkSRI5+xHHrSRB6JKLhGlGNans68?=
 =?us-ascii?Q?Lxo+osF02Ez7Rl8rJomltGZMvIxBFgKR0VL1F8/KhYd+4YNymQlnOJ2I36ks?=
 =?us-ascii?Q?ioc3rcuXnIZ7ewFi1lqXSVAqWfwREJKher7LIihVy4DmF0YjXz7vfZIPTj34?=
 =?us-ascii?Q?iOFnQFGrr9OGQl9Go6+ErvLxpvV/LUjsw5D/IPvoExvRParrxLbh8wd/Yn2b?=
 =?us-ascii?Q?prEPsIo6STQLEQek2PfJDkJ01WQY4Ahnv68WQPx5EgHpvNJ1o6EYBUo+xIPw?=
 =?us-ascii?Q?R0U6z5TI/3N0/Z2IvX7vqTLGzQ8OPx9ZfPVRTgUw6w0HHetU0JjiXDRevL0V?=
 =?us-ascii?Q?lVNKZGgybzFMxsuF3XOIE8N4VfOIR3YRAr0aAtAYH7MS9R2wEdaWckA2T4n1?=
 =?us-ascii?Q?FnZTWtbXIkz7ZwCaxtTNlTmz+NmsOEmJVmEb/yOZflOnesTaBbOcv43CohnY?=
 =?us-ascii?Q?H/zzuT2ra1EM9KPliKw7NGWdCwQgCGce1DujnfZURGeQaYmLz9Xedwyk6u6W?=
 =?us-ascii?Q?9eKaKartGuqbKnLFRrrKMl7W7XSxC6dAXCME6iLETZ9reNCrfSLfm7D6MdtO?=
 =?us-ascii?Q?EhJNlcZrl3g6/wlf7GVxABdgAiPlgn7LjdrGjmf+H2nH9xifGOiHiibXg3je?=
 =?us-ascii?Q?H9eaHOT1IlvSfUlm0MvNzCdELsNe+x5YyDQW760T8uPejU7QlXS5hU86QOwV?=
 =?us-ascii?Q?VCXAVZ9JK+F+4UZ/kB0ldLQZd3GWgwaz1Q4HZzWC2bzCWl+syO7tJNC5eB3v?=
 =?us-ascii?Q?MmshcQvougc1Eyg7brsZgJ1nqQvHK8JWNG8Np+ISjTUFcH8xO1DFCKd67ZlC?=
 =?us-ascii?Q?D5lLXpUjxk5sbglWDomj+65EZ+mOhSMMDqBlk3Hkg1qu9Dr1BgGK46JX3lLO?=
 =?us-ascii?Q?djRDDUyWUed2j9C0tFioPmAlzSKdHjs72fUQEb7GhnTe2X0LFP+15BDtNhZe?=
 =?us-ascii?Q?jabsHdKmeNoG9htcgoeeB0AQG7UBsZ1M+ij814sxbCXw4Y+cTO7jh+Y5gs4O?=
 =?us-ascii?Q?THUCfoW9En8/LvR35gMXgm2FeuTw9hrU7MovQJELSUJhEbfgD9G1wLHu6ouN?=
 =?us-ascii?Q?Hib0DwPRRx1XVIUzyUCUOaA6wuSsdJOfklAvSqxw+x77vDbhfEWAKJsljJpS?=
 =?us-ascii?Q?b6xCeRY8ngkDaN9H+N4a/kuCrGelZV7AQYJ5X5ALLiZpaCOJi6HLdGyi9d+b?=
 =?us-ascii?Q?xaHc5NLnH3GdT+NC/+msggmugtfIBYbLv/RHKaFaUHEyc/W4Z/awiRLXQJ9H?=
 =?us-ascii?Q?nq2oTqLMVod+hu+uE/zVR8TNJBPPgx6y24Dwf17006ZcgZ5p5ZDqSlgNCCj6?=
 =?us-ascii?Q?AaTewgyET6V3RIZW2qnMIUG+rpZ7zv1q8QkKP0q350PW+sYxtoQtAxYsmA21?=
 =?us-ascii?Q?UdK+oNk+Hd9/GoBZsEcGDjwGiRSDQBiDFN4XhMpMMnowjKZYXVjpqE3V511j?=
 =?us-ascii?Q?IUuRuUkCJ+QWFCOEhmdzmBhJG6Nwvc1StQ1zYmCeTZ+gbHGA2zLzB0QlQrDD?=
 =?us-ascii?Q?SY94jkmnqA0EWvg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 08:06:57.6670
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73506780-dd26-46e7-9e4c-08dd51858bff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4266

Add new DSCP mask attribute to the spec. Example:

 # ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/rt_rule.yaml \
	 --do newrule \
	 --json '{"family": 2, "dscp": 10, "dscp-mask": 63, "action": 1, "table": 1}'
 None
 $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/rt_rule.yaml \
	 --dump getrule --json '{"family": 2}' --output-json | jq '.[]'
 [...]
 {
   "table": 1,
   "suppress-prefixlen": "0xffffffff",
   "protocol": 0,
   "priority": 32765,
   "dscp": 10,
   "dscp-mask": "0x3f",
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
 Documentation/netlink/specs/rt_rule.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/netlink/specs/rt_rule.yaml b/Documentation/netlink/specs/rt_rule.yaml
index b30c924087fa..de0938d36541 100644
--- a/Documentation/netlink/specs/rt_rule.yaml
+++ b/Documentation/netlink/specs/rt_rule.yaml
@@ -190,6 +190,10 @@ attribute-sets:
         name: dport-mask
         type: u16
         display-hint: hex
+      -
+        name: dscp-mask
+        type: u8
+        display-hint: hex
 
 operations:
   enum-model: directional
@@ -225,6 +229,7 @@ operations:
             - flowlabel-mask
             - sport-mask
             - dport-mask
+            - dscp-mask
     -
       name: newrule-ntf
       doc: Notify a rule creation
-- 
2.48.1


