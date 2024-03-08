Return-Path: <netdev+bounces-78873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F38876D28
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 23:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A39391F216BD
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 22:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04441CD04;
	Fri,  8 Mar 2024 22:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="INw+VA+D"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D272717C8B
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 22:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709937130; cv=fail; b=lQ1JV5KseHnyXM3/jL5c3MqzQ84iHM9xR4/Qky/QPUeR8hk9zE7RHfF4govZVhkj0Ci8vTtlQg0KHGEaz4pibRvlqhk+NBM0MYSwNVnRgg8smeBC6rOFZExKhzKzuOcSlxo2kGl/UXAaHuzINIntgv9cfEz8LMjpKZYxtTD51qI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709937130; c=relaxed/simple;
	bh=Z9uk9O2tFDg7Y4zWFGMRL87dCnjCMTvUMK65pFu8Eco=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qkwZiOcngEMSp/9PLgtbOl9R6iKtHWTIakQ7SlDUshDu2L7gYXonnBpMlbzQMwmg4D8bOu+zmt07739bCABuStToQWURQ/mHZ1qNF/U9wtgExisou7q6HS3/54pE4U1HwMIGF7uYLTfg4tDs7vlNGxH7kpLbk6jp7tmI58eUgs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=INw+VA+D; arc=fail smtp.client-ip=40.107.244.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0QFVKqqEsvRa4mSmRWY62k8r73waS0bVz+CrrIQJSrt80RGPmVyogIPbyP0lFBQqRwT37jw6RepVpW8UgZ5Bjd4SQGrFZoV1UeO1/ZezLdVlhawr59HszfvruU0zDiZ+geMV7a5kYFpP6bOW7PNbf4O2psXKOd09odOlEdNrVzUe3Vur1OIBjjJxkCjFPwGA3dduV5sv/awHdbd+qEsnHLF3PAb4SdoPbFIU780OCxu7Q2urMaxcqOo0+boEPuHaFrxRGRRFOmARvBeeNlFb9J9u50nsCA79zgRdRduGVnt5rC91Yplk8xKncX0FDEPgDVsNdCd040zxuEkUSWDdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ldj6yuXukJoNqfN7SxeZD4+2+Ju2VkuLTlWtzV13eas=;
 b=Z6CfVrrAyqViwjDuWESg81fPs8k/FrkQnd3jEnot/q4GvQN9mCkGJF4w0Ir8sLbvi7zB+Qcg+dNRLf/TlUntqNgeh7WPqLxxRL16NG4mT1I74xR5zyRGl1vYoBOqsW8w75uoZ3Xj1cuJ7JgpodyQAz/pa2cjpwKYTgkDVHlMlb4uFn5+dUlBOLG6jc21M9w8ZVNSkT29Ui76K9f7FcAEfeFfJgYzGCLcK1X4+XyWChxnMRnPHj0YPG6aRD77CxDPWI5dksuo8zXuu5079PS4e5KA0HzRNsHlhb17KQRDlzMvVqmCVqNcP7OxO8EX5G4yl+1/cJxkHqYEe/IpKCQIzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldj6yuXukJoNqfN7SxeZD4+2+Ju2VkuLTlWtzV13eas=;
 b=INw+VA+D7fBS2ObXAXL9vhvbN8VuO9lFT5aTUZFrK3DraIEirDF2PmDiJHVUUVSSA/CtRCuXFytJ8d1w77GNWQeOCoJGwEXB0qDJ56xnMgZ2bFsS+tXB6ne25gwudt3tk0Jb3ypGI9JUq6hpe0TaUenn83irBrR8NJ344vxqtvbjCyap48U3ZV+/wsB9IHHPYxt1ybbDaq80NifMEWPBWZnGGS1cc2seirxCb281sqlQYXmMB+qrwnVV1PC/pk4PxqKhO0QpBQ8e++SMYHrTRI+4U1f8QWFQs6CrqLMWfxCO4Nmkh3U+1WRUBk4NiTN5bnqcpu2aL//cbAPa//Zw0g==
Received: from SJ0PR13CA0076.namprd13.prod.outlook.com (2603:10b6:a03:2c4::21)
 by MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.31; Fri, 8 Mar
 2024 22:32:06 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::35) by SJ0PR13CA0076.outlook.office365.com
 (2603:10b6:a03:2c4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.12 via Frontend
 Transport; Fri, 8 Mar 2024 22:32:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Fri, 8 Mar 2024 22:32:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 8 Mar 2024
 14:31:54 -0800
Received: from yaviefel.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 8 Mar
 2024 14:31:51 -0800
From: Petr Machata <petrm@nvidia.com>
To: David Ahern <dsahern@kernel.org>, Stephen Hemminger
	<stephen@networkplumber.org>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH iproute2-next 4/4] ip: ipnexthop: Allow toggling collection of nexthop group HW statistics
Date: Fri, 8 Mar 2024 23:29:09 +0100
Message-ID: <1bc19123247e0ffb7e08083244846407966e972c.1709934897.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1709934897.git.petrm@nvidia.com>
References: <cover.1709934897.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|MN0PR12MB5953:EE_
X-MS-Office365-Filtering-Correlation-Id: a32698a3-8466-4e6b-cd70-08dc3fbf952f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VXykeO6Kif+7gv+kRazb1yXx6w/AWtxr63fFAiiBQHd/W0yeIepNc2E2oT2A7MwcnHOGHxeeCUVhMBgrBh4BFUcksO9F7lW2wIGXIz4XhVkw1EaHJAjDMIQmCZWKxOYSVRqABiW7HSu/IrUzBLV2tNsSNrjqwHcVQ2dTB0sAwm1Cb4o9MYBDI01kI9jdDLucHIdvzQBNyLwbDqD+dI9HAarJr1pJEUNEpyIcDb75B4t7utLhy7aOOCQ1Eq0tL6qB8PjhvevvZ3u4POrokZrNwOzam3EykkyIyGB4GggPyT3IdbB4WVx7unKIx9l6QG0Yk9jXpAlm+lTxC6vPDkcaRmJyGDi6aQApGY9gZ7o/Tr/4eJIf8gwWvgB+HHJd2DG8G3FiYmRCwkbql0C808o2be+HG1cHJ7LdRWQ0n6zupOksCf9bOmXJ1YKVhybd8gX4mxRKd4sjTYfoT7YXBKzqgQkpfUAFuL+EyJKUzPDmdwHrjV2kQBZPbBqo4Igm0Wm8UrJEDi1xRJAsOMeXptNDJSLsnrBgnjKYhg8vVcX+0yEm09BilMfe4IqzrdEuN6gagvWiwqVm0TQZOw3Ng3/mBJ3oNP6FfgJaxffO0zVLylqzQqqJTsrER3LCiRJXcnxyyo/pGpFx4cKd9cEgIcFpK6eQ5YKij3G4FhL2VdBAnSSao/k7VzaNEcvnYeApiLr9HDskARHT09MdiJtTyBAKT3Y7GP1MfnjsAK0olPJeQUH2NXYOLnxP+viFLB6T7tID
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 22:32:05.3852
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a32698a3-8466-4e6b-cd70-08dc3fbf952f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5953

Besides SW datapath stats, the kernel also support collecting statistics
from HW datapath, for nexthop groups offloaded to HW. Since collection of
these statistics may consume HW resources, there is an interface to request
that the HW stats be recorded. Add this toggle to "ip nexthop".

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 ip/ipnexthop.c        | 12 ++++++++++++
 man/man8/ip-nexthop.8 |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/ip/ipnexthop.c b/ip/ipnexthop.c
index 573f1abb..74685c49 100644
--- a/ip/ipnexthop.c
+++ b/ip/ipnexthop.c
@@ -56,6 +56,7 @@ static void usage(void)
 		"        [ encap ENCAPTYPE ENCAPHDR ] |\n"
 		"        group GROUP [ fdb ] [ type TYPE [ TYPE_ARGS ] ] }\n"
 		"GROUP := [ <id[,weight]>/<id[,weight]>/... ]\n"
+		"         [ hw_stats {off|on} ]\n"
 		"TYPE := { mpath | resilient }\n"
 		"TYPE_ARGS := [ RESILIENT_ARGS ]\n"
 		"RESILIENT_ARGS := [ buckets BUCKETS ] [ idle_timer IDLE ]\n"
@@ -1100,6 +1101,17 @@ static int ipnh_modify(int cmd, unsigned int flags, int argc, char **argv)
 			if (rtnl_rtprot_a2n(&prot, *argv))
 				invarg("\"protocol\" value is invalid\n", *argv);
 			req.nhm.nh_protocol = prot;
+		} else if (!strcmp(*argv, "hw_stats")) {
+			bool hw_stats;
+			int ret;
+
+			NEXT_ARG();
+			hw_stats = parse_on_off("hw_stats", *argv, &ret);
+			if (ret)
+				return ret;
+
+			addattr32(&req.n, sizeof(req), NHA_HW_STATS_ENABLE,
+				  hw_stats);
 		} else if (strcmp(*argv, "help") == 0) {
 			usage();
 		} else {
diff --git a/man/man8/ip-nexthop.8 b/man/man8/ip-nexthop.8
index f81a5910..aad68696 100644
--- a/man/man8/ip-nexthop.8
+++ b/man/man8/ip-nexthop.8
@@ -68,6 +68,8 @@ ip-nexthop \- nexthop object management
 .BR fdb " ] | "
 .B  group
 .IR GROUP " [ "
+.BR hw_stats " { "
+.BR on " | " off " }  ] [ "
 .BR fdb " ] [ "
 .B type
 .IR TYPE " [ " TYPE_ARGS " ] ] }"
-- 
2.43.0


