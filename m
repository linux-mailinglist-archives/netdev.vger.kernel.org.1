Return-Path: <netdev+bounces-163115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB85FA29578
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D04911690F9
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 15:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6036197A68;
	Wed,  5 Feb 2025 15:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S1XmZKou"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC011DC98B
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 15:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738770954; cv=fail; b=UUPFyHmtpyL4/6WLSZNVo3OH+FdSNFmjJfEuSnbCeVJOIc7bMb8kREwIs0J5d7eL+MO0i+XSQOSOM248aqIHE2GMyhDP6AFw+eKMkNoPRjCqu6HN0gvmeB8QryfRkuwwaqwX/EpPPPG+n9NfMSxvryjG10dX0lrqadK/ihqdmjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738770954; c=relaxed/simple;
	bh=vsRo+Z1XitNlYDclhx+v75Vz03TetQjnchs5IY8Svb8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fGNmsOG/jFFJSY/T1UTVGXaul6Yup7ROt64kZGGR0crYfgQgDB9fb/1c90hdFnSq415p6Xl8S/QR4i4wuHOuUGL6h8Acidi8vSfzkA3kPzyyEV6NAPaYjkVoYTff/dFOs6X5CB5AHEBemFF3GSV3qBZUBj2XqCNT9T4WZODjEsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S1XmZKou; arc=fail smtp.client-ip=40.107.93.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JivOqxQGzF8mpfY9xfDgwH3CTX9YK/xieWDH2hmiKaxJEUiSnnpBek+8q/XsPYksO4X0eVmYTDntI+2GQD3i/PYsY/NNVmkuvuAC6vkZGchclkU+MzOKcoBVrXeuwALkghjMl2ZsO2YHM74ME7NgTEOC9NqBv0A4eUabvZUvXtJo6Rekc7PwS107bsZS5S3C9Somj9oDYeg7OI4LU0g+V0paaxtMiAnQGCP30ehPBNmmTyUit83rf0iLH34HE+xUSoGkGDQhAgEYZld6SXc+ByODlxtW7xym3+vQFJQGmiG+yNfgjJYanZmg67oCfZLKhg+4j79HLZ9G4F/G2A3Cvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qk9ZBXs6e1APGRRmxpRsTHmUYslKDWpIIp1+TKR/WoQ=;
 b=iRjDrwgeSu3DwemhSaILeaT94n6H6pdkHG+b9EfmjOfcTW42O1o+3TjUc+HJ11bcF2CEsO2hTx2grYdOg40hldyBoZF/a7q7STEBAon3Mf/7+HV4pBVDxc84VQvBVfzWU/YjzIww1tB8CRInwmYhlrxMdCGstpuqjIuX/R0aE09zQf9ADmIx8ZDmRtVFXQIRKRynibjZwRZ0t35ggH2QaCEa4R7aQ+qqkJjSeoWBi84rsc/ykVBKdRMmgxX6w+QEBSvpuEnfNT2u4kT8nBHab7ad9snsRbsCfL/qXBCQADG7zQuiSHa9pRaY9mXLGp8XHYFglL2MNwoRJltAYe/6gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qk9ZBXs6e1APGRRmxpRsTHmUYslKDWpIIp1+TKR/WoQ=;
 b=S1XmZKouC3hIwb+OrHudMfISYKNnDLhDQKMKYeB85me0z5mtcRNhWEEi+lIVn/eZWp/2IXcLvp0WixMx98gGPneNU4QeFHhLnPSMwrS7KN49tSUfO0kPs60wmRe/JpowA12Q/0bspYkVS95vB4MwFOjB7SUGctED3cyALV+juLDJzxj6pt3IduO76hpUNjHuLUgBW9HDxXDZKrxIqBtaDUJ9NFsyCd4blAroorycCFfOoxCevyGLf2w6XqxooCPPgPFpn0gaeLyQSv5NA332UU8yM/x4DFcthb5TDTqKqD5mb2BiHSKfnF8+Lh1jl+4GP4mpVnaSzFXkrbvyvYKEpw==
Received: from BL6PEPF00013E09.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:6) by CYYPR12MB8964.namprd12.prod.outlook.com
 (2603:10b6:930:bc::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 15:55:50 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2a01:111:f403:c803::8) by BL6PEPF00013E09.outlook.office365.com
 (2603:1036:903:4::4) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.26 via Frontend Transport; Wed,
 5 Feb 2025 15:55:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.0 via Frontend Transport; Wed, 5 Feb 2025 15:55:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 5 Feb 2025
 07:55:28 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 5 Feb 2025 07:55:26 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next v4 14/16] ethtool: Enable JSON output support for SFF8079 and SFF8472 modules
Date: Wed, 5 Feb 2025 17:54:34 +0200
Message-ID: <20250205155436.1276904-15-danieller@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250205155436.1276904-1-danieller@nvidia.com>
References: <20250205155436.1276904-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|CYYPR12MB8964:EE_
X-MS-Office365-Filtering-Correlation-Id: 61dba0f0-4eb6-44fc-b568-08dd45fd9051
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q9OsaqAV1JVHKqrD6d0Xp+GvEETaQsX+5hdXpCIaJG7jsLFSKdXqVfF858Cy?=
 =?us-ascii?Q?xJKzPup6Fvw1PERswtT++guW2HHSDof66VxnQGBD3PRKVgZH8tvnL2v1XHN2?=
 =?us-ascii?Q?LfDQkN3TTGm3B4dp1Zff3r2huP6eq8auc50OY6cOA/yChFKVfsurGX+Zsva1?=
 =?us-ascii?Q?P74mdL6NexWzsCAxr60fccLPOf620wfJBWGJwMQQtF3JtPjClYnOgJAEJA9u?=
 =?us-ascii?Q?fejwz6KaRjLEM2qjE5+pGpa0ohlKUXPtFqBnsdJromdtJtwDXRlt2nGxW4v2?=
 =?us-ascii?Q?b719mqeAUCLV1mUpvWBPeQVAgfhFhO1DV1vRarp4qhRG6/iyjzSYvPy59kxC?=
 =?us-ascii?Q?dPaFH/tMIZ4b8HvCcjgHrAXmMdvFjnK1CTAlBZA5R9Vhxx2ff4OvUChsZAJW?=
 =?us-ascii?Q?+wglk465GLuzUWthydwNcjhVnuaFChpzwRkAo8aOAsOt6lAKtNN07XPY+xbc?=
 =?us-ascii?Q?E6MSpWB9qyr1gdM4oIyc/da8FZkvPc0tki3Q/D+ZYXuhHrjGlkJAkHW36Dnx?=
 =?us-ascii?Q?e/foI4frv16KdYcFui8YvJTwkKwDDN4lG5c93zu8+l1A47U02nFLZWvRkFcY?=
 =?us-ascii?Q?8S9OuB7vJD6Quu6fG8oQMJmNXMvEeF4JwiGBElfei4/g8kKshsRBUlwqJ0Ih?=
 =?us-ascii?Q?6fgcFmlWzqan41AWiQe4VEzZMbDQx8+B4rZ5X1JqxhVu5jidGx9bJb/xv8X+?=
 =?us-ascii?Q?t+13PEbVTQ/YCr15zrl20PvRTNbHeg6umUBgC1ohLvdv1zTv/HKNQvoWQl1P?=
 =?us-ascii?Q?x3oZ720f6IbLc+kF/pT1XrOJTZp7FovV9MY/1Nv1Orkg9x1PGhLZ5XaSqhZe?=
 =?us-ascii?Q?8HyWDLztFhyQV/1h3uBoWgSAW7681AkrSohbZhyYiRFfjVRVhLIpKy+OFTF5?=
 =?us-ascii?Q?88hoAH+o7OC1iyO2YmJxhtvpe+fFDC+SgKAfCZEh33sARGJ/40TyLvT6BDl+?=
 =?us-ascii?Q?F+eAAePEQEIIBPdEFBYfICX9ofCwHZ6TnSEX8PcKfnahbXB5u9J66/uvpUP4?=
 =?us-ascii?Q?wnP7AXHAa4aZg+eQ5+f1dC1i7T9lFzaL9SXZhnhHWe3BSBG2AMBO8ffUnsHA?=
 =?us-ascii?Q?wckHKTHXA8TgfekzK3e7Zj7nnvvLXWmMCzWNdHpu29hogiPbxNnfM5FbSYlV?=
 =?us-ascii?Q?EIQQv6DduHQIcuQLidOeWhotgAYqAcD8l0Ffq2f/uUSRNpBQ/lYGvZWZ9CWW?=
 =?us-ascii?Q?Q2ew2a+WuiRkM1TG9AZuE+8oJnrCJcr5UY7zrbn3Bd8/osAg64EKWL+5uE/2?=
 =?us-ascii?Q?sgEbsRSm7TgIk9tcnqh7JJt/1WA/oltEJ3AOvls9UsVu6qTaX2VYlxbNG9WN?=
 =?us-ascii?Q?QqC05bpsYwo36D8BW5+JZda7/OE5DIHSUfgHKR7bDVsnzpD+le8EKjVw+K/Q?=
 =?us-ascii?Q?+yDrDe5xWZACw5QyqWcRunGjimKF9QGT039TT4rE2ir/1U3delpqb5Vl9owm?=
 =?us-ascii?Q?xPs+yqHzGMWewhr2NPnN7t/MwXeuKFOsP2rNPXdOxNKcbIPs3QL6493fyhx/?=
 =?us-ascii?Q?XjZMBE40pd53mmY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 15:55:50.4763
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61dba0f0-4eb6-44fc-b568-08dd45fd9051
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8964

 A sample output:

$ ethtool --json -m swp1
[ {
        "identifier": 3,
        "identifier_description": "SFP",
        "extended_identifier": 4,
        "extended_identifier_description": "GBIC/SFP defined by 2-wire
interface ID",
        "connector": 33,
        "connector_description": "Copper pigtail",
        "transceiver_codes": [ 1,0,0,4,0,4,128,213,0 ],
        "transceiver_type": "FC: 100 MBytes/sec",
        "encoding": 0,
        "encoding_description": "unspecified",
        "br_nominal": 10300,
        "rate_identifier": 0,
        "rate_identifier_description": "unspecified",
        "length_(smf)": 0,
        "length_(om2)": 0,
        "length_(om1)": 0,
        "length_(copper_or_active_cable)": 2,
        "length_(om3)": 0,
        "passive_cu_cmplnce.": 1,
        "passive_cu_cmplnce._description": "SFF-8431 appendix E
[SFF-8472 rev10.4 only]",
        "vendor_name": "Mellanox",
        "vendor_oui": [ 0,2,201 ],
        "vendor_pn": "MC2309130-002",
        "vendor_rev": "A2",
        "option_values": [ 0,0 ],
        "br_margin_max": 0,
        "br_margin_min": 0,
        "vendor_sn": "MT1146VS00060",
        "date_code": "111110"
} ]

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
---

Notes:
    v3:
    	* Enable JSON output support for SFF8079.
    	* Reword commit message.

 ethtool.c | 4 ++++
 sfpid.c   | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/ethtool.c b/ethtool.c
index 0b876e8..8a81001 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -5007,6 +5007,8 @@ static int do_getmodule(struct cmd_context *ctx)
 		    (eeprom->len != modinfo.eeprom_len)) {
 			geeprom_dump_hex = 1;
 		} else if (!geeprom_dump_hex) {
+			new_json_obj(ctx->json);
+			open_json_object(NULL);
 			switch (modinfo.type) {
 #ifdef ETHTOOL_ENABLE_PRETTY_DUMP
 			case ETH_MODULE_SFF_8079:
@@ -5026,6 +5028,8 @@ static int do_getmodule(struct cmd_context *ctx)
 				geeprom_dump_hex = 1;
 				break;
 			}
+			close_json_object();
+			delete_json_obj();
 		}
 		if (geeprom_dump_hex)
 			dump_hex(stdout, eeprom->data,
diff --git a/sfpid.c b/sfpid.c
index 0ccf9ad..62acb4f 100644
--- a/sfpid.c
+++ b/sfpid.c
@@ -517,7 +517,11 @@ int sff8079_show_all_nl(struct cmd_context *ctx)
 	if (ret)
 		goto out;
 
+	new_json_obj(ctx->json);
+	open_json_object(NULL);
 	sff8079_show_all_common(buf);
+	close_json_object();
+	delete_json_obj();
 
 	/* Finish if A2h page is not present */
 	if (!(buf[92] & (1 << 6)))
-- 
2.47.0


