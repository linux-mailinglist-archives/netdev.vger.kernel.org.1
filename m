Return-Path: <netdev+bounces-150342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC509E9E91
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 19:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25D831678DC
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 18:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B3219F13B;
	Mon,  9 Dec 2024 18:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2+oGzzb4"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7E119F42C;
	Mon,  9 Dec 2024 18:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770499; cv=fail; b=cth/oUDZil+PKudT7R4YOBEhyCxZFHZO/MKyTb44NKtVRazA7QhbINeiakCU0ezkpg2TXtbxbBzXUAJxHOhKlkkRL9S4V7oqHpYAhnNNgR9sVM0UTtgE3wHPm77NL8DUqSGVLqol5Y/HppZDuLwSBK4jw7h4UmOOKxrWKzlD4OM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770499; c=relaxed/simple;
	bh=Qf0o92+gQaWtO4dM5dSppafrtPnARuDpGAAPJv9Vy1A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AJ37GN6FcoCGzd7tadU3xkBjNs1+EKn6AK4YjLT1kEIObeJzL1ZiKnLKheSQ5vrlg8wyTcXk3+tFL1a2TBJpQAeQsWJ7heEaO2V013QJ6DC422lMB3sLgTz4Wr1tn/gwdgGsDm2ofLwbIRLA9WdejD/I2BcRp+Y/DdEhYw7lvXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2+oGzzb4; arc=fail smtp.client-ip=40.107.223.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j1LOlVoI7Ig4aDdwv6BNoLZtbsbFMUk+pITe85Iftj2IlYE6mdFIAFyxrRFr/kijveW6S3ZKX/4n0rsdwBDRpR+B7YHHA1j/wfH1kCFXo8QaUqEvwSHwzfP43Ur8aHFC6jXwzD5YAOUlUa5xGIkzS28qHB3vHOmvnzCURyMsc1oFbkv8A03HakipM6tinzQzRc+7+GlsHRwfQbNMP4GPNrKlq/MAoIwYEyDgdMPjNXLHo2If4IuXifG9HXEeTDxp7LmNJTc7yhb5JB95DXMP3dM1QqeOKAHEdatJTBoM6h4uZGJuLGV/bfOZ6h6OTDkNjm/WHoIs25S8ukFXNVjkCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JcLqUbiTaEdHfIofMRm6VJy9xB1LJwnq48OqW5ix3Vw=;
 b=dzcTOCh1fDqIHm2iJ3Kt3hq+MQAYX9/i4x36G9r8nEz6oDK7KVk8GJ22gdyNWHlVPPBi3pZaawQGAOgjYd59wIUQTM8OFEl/vXaVAqCBj7MNEEmEQQKmbMV2Sr2JEgDsKsvdP+wHUd6v77ia0wRmzBnXHzCeYA33F0SCDW5pQNDclnz2Hw4AflId1BKx/z3Z6PLlNeLVBs+ALtlU1W8b5Ix71eCDEwpn36kNeCmHRR1p5945ZYoBOSc0TQGD9b862vqPfsxgSEjUHUy20ZSwX38VbZYGjOFgSW7tutm4MN122RTGk3pdcqRUVSs+fmwfG2CQfu2EFb2mJNWddYmnZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JcLqUbiTaEdHfIofMRm6VJy9xB1LJwnq48OqW5ix3Vw=;
 b=2+oGzzb4d2CWkqKzE11Qma0uEBZ84fjHlgulZYLTWomfTr65sv7aYqoKjPj8pWJYEE74Mrq5xhf0cOnng8NyhkIOSXO7HtJNhCIB5RrTq15fkl16fRBc7Ee4OVNeeTp7LlZ7BunquXXJeOcOhubJKr/6HeyliCNucLtkg2safTY=
Received: from MN2PR18CA0025.namprd18.prod.outlook.com (2603:10b6:208:23c::30)
 by SA3PR12MB9226.namprd12.prod.outlook.com (2603:10b6:806:396::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 18:54:53 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:208:23c:cafe::1a) by MN2PR18CA0025.outlook.office365.com
 (2603:10b6:208:23c::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.15 via Frontend Transport; Mon,
 9 Dec 2024 18:54:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 9 Dec 2024 18:54:53 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 12:54:53 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 12:54:52 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Dec 2024 12:54:51 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v7 10/28] resource: harden resource_contains
Date: Mon, 9 Dec 2024 18:54:11 +0000
Message-ID: <20241209185429.54054-11-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
References: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|SA3PR12MB9226:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eb22d07-e10f-4c05-92bb-08dd1882f79f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PMoiZC0CI6ghvSaNX2B9BZbzwhqjtk0dMN96tXvUGMt5uJC4KINj4EMGc1j7?=
 =?us-ascii?Q?0Bpoa7sdm7ZO07gQXTCqiHZc4ZtNFiOlUhh+sSnwL5s617NfBR99hiZyVyoN?=
 =?us-ascii?Q?yG/fGPgJy7qWbwe2XNtlOwg0MCaA3MuGo/M3wbzz2mSXRrBNpCIXLuCytyPY?=
 =?us-ascii?Q?oLAvzxpyKgzJn9vTE4iod1a7QPQ1Glf8MnufKvSVFgJ9aWPaTm1oSg43NlX4?=
 =?us-ascii?Q?CgxkUR2qx1tvG8oulwnAMSMVB5LcEckV2kvO6CNlIK25HeEQ5a7KqjgncAHs?=
 =?us-ascii?Q?hWwPKbnXadKfx1cM7z+dKdNYFQU3gBo05ZlS0QJ4+R00YGkK8X08tmSBFtS6?=
 =?us-ascii?Q?3WjZvWU0TJoFuJfC+KyPcOXGzVOrcye+YrrEcqld+mzY7CtXhN+FuB5wGT31?=
 =?us-ascii?Q?a1SyHCa2Wdq+yPqd20UesGf4tzsuV2jb0cGtDae3/0MkBwWWM2BE8WFLqYDv?=
 =?us-ascii?Q?vy9KN0erasrJSXM3aTMatKOykAZLqNjtWErq5TUvgCxUH08f2MvzqzTsPEH4?=
 =?us-ascii?Q?hb5BAfYE0ir9THsbH1owF5F2aBz9jf87TDih6ftml7RAaOTtbXouzKoy7Jg/?=
 =?us-ascii?Q?iOEIY7T9It6qGLiC3OkOBoUpwdbIp+utDKLAwC2/8nHF7dY2f+uZpR5Z3aha?=
 =?us-ascii?Q?TkJ97z3gbQ+s6706fbM5m56LKataej/xj9hyaDSGjcPDBjxbsevOcVHXjy+I?=
 =?us-ascii?Q?sr0ZwFBhksjxr9vQPp1DbkmlMFNKc7XjNY55KObmu1rnYbh/lJMZtDoeQ3XD?=
 =?us-ascii?Q?cuO7IR3ehKhWw+VgVyFfGCYAdn33CIra/xs9IFO+AJW4b2+bPLbCdsK7FLiv?=
 =?us-ascii?Q?GdMBuv5DeWaY3YtjZcomp/JBDV31oYQ+VL4IRsFk7NFGEzfsK8SUlg/WrlWS?=
 =?us-ascii?Q?p3vFi1Id7mqCzB/NhK0B56bCRrlVU5xBSVzou8lKFOVlvCyKLPjdYiXndPaL?=
 =?us-ascii?Q?+5wEsUfRLrlBgPQIitbXTmTk+UMqBA7B/qXhIKAzYu6wtHRCVWB+UZxJN2Fj?=
 =?us-ascii?Q?Gql5yNRI0rt/C0HxQH92/DNNPgN0aj2ownHoi0EM9Qm5BT3Lrc9v5dd+7vkg?=
 =?us-ascii?Q?zTcmpL74b0grmztBFe2/jAwc+A9ZAl+kEFl4Egp+jMicemZXndaLB80I7GLN?=
 =?us-ascii?Q?8/JEqr9ggNyE6j6idOHlFCDg//NHhCdn3/CXKEUdTPOiPnGX+IcOJyZyqo33?=
 =?us-ascii?Q?XPZ6olwqbBC8Pg+Rge9X/GeIA0hDKBsiZV5szNtEh6sfe1ekf05wQXvcAU5Y?=
 =?us-ascii?Q?bd4jEisPFr8swsj2NLPAx17s/OjUwhcTjPUDqwTFdnYPTvccWSEEtlkJ1J5b?=
 =?us-ascii?Q?mq93wdYf1tHovQ9HJ6A3/7EIpRQkAJ8AHw1yICyYYvQG9Kjum0wew9Nk2lMi?=
 =?us-ascii?Q?0aFrespqNhvEi2odUUUfSkNEO/PqWp78zDimHHbItOYeqN9HiPoa8vywavyh?=
 =?us-ascii?Q?0Z3YI6/vUcT9kXiS3wl3cWizWeRUDhaoih6MEQ4b2gW+R+2EGw0gGg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 18:54:53.5098
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eb22d07-e10f-4c05-92bb-08dd1882f79f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9226

From: Alejandro Lucero <alucerop@amd.com>

While resource_contains checks for IORESOURCE_UNSET flag for the
resources given, if r1 was initialized with 0 size, the function
returns a false positive. This is so because resource start and
end fields are unsigned with end initialised to size - 1 by current
resource macros.

Make the function to check for the resource size for both resources
since r2 with size 0 should not be considered as valid for the function
purpose.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Suggested-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/linux/ioport.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 5385349f0b8a..7ba31a222536 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -296,6 +296,8 @@ static inline unsigned long resource_ext_type(const struct resource *res)
 /* True iff r1 completely contains r2 */
 static inline bool resource_contains(const struct resource *r1, const struct resource *r2)
 {
+	if (!resource_size(r1) || !resource_size(r2))
+		return false;
 	if (resource_type(r1) != resource_type(r2))
 		return false;
 	if (r1->flags & IORESOURCE_UNSET || r2->flags & IORESOURCE_UNSET)
-- 
2.17.1


