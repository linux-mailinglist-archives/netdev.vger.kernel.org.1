Return-Path: <netdev+bounces-225278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D361EB919D2
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 16:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B7D77A46FE
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 14:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3C61A9F8F;
	Mon, 22 Sep 2025 14:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="upiqdRAx"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010071.outbound.protection.outlook.com [52.101.85.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497791482E8
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 14:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758550605; cv=fail; b=Wmb/cJTyMY4rRXZJaXExUxgVDApfybMhRVZZNcMYWT57DpGGSd/IbrQvyJHDUK5q+1jr4oeMqPjD+/HMkHjWNTkO/DgxbCez7wRxhuCdPf3yUtNGZTI055JC1T4HMW5PbaY8CEUJc06H0ltWDtTdYUWWCZrUBR5bO5EjFr01hjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758550605; c=relaxed/simple;
	bh=Gim7PN5yK1iwqQxRMIhgwo/neaXtq4CqNFyj45vLhGs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G+kcA2C4u6ObinU7GG2PvndgwZ/CxcswkN4ovpos69VRQLfwcb9ScQNZTWAVqeE2nW9VQKFKbaEog+qoP2nyrPUAarP24W+wLCfpFpQsRdhfrOrGmkCOr50c9I5KFHTxCZjsEMI/lHoM+qDEWLhodZsB6b3ro1XkFp4OizMAFfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=upiqdRAx; arc=fail smtp.client-ip=52.101.85.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PAzhw5rFdF3Oax4dwoMykGyeq6KTPghA1lg3x8Ua4S3ZznkmtBhIBsZ9y4O7+CxeXIClo095O8njY5ujZVraiuQHsd+EUHJo0nFFrR3Az9fMn6kElJUPlNcNOG6zTYr8hfxMFsXxE5qFsh7HjvqF13zwpOHhMnYhV5jv2OLz2AhJEyocb1J/CSbGMcguRNSNHz/u06RfmMFY+/I066zCvkbXc/9g/tSBkRQLKHpV+SdZ8YqXcEKktkqCwS/fcUA+aSjyrBe19bnsOI4iXWt4doox24Y1l16NztS7xC7gcIbGnnQkWDvOpJ6j+1VaTplziQVCLkHj7Rwpuw61uIxG0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LofBqMpfl18Q/HbCit14JoiP6OJQFguN8RYF1Fr0UjE=;
 b=hEo2xQtQV45aFIugI1vGqsvh+/O+o8FEwYyH/JTHTPzrQWgdsz5z3fhHArmbLJO4zlNldOkY9ijrbD8BuRDVrToGAbKD6nZtbaBd0WNzV9QwkuX/qVbjz0vDx4OP9dEyZaGTpnixtzq6htnCgyNInUA+RFvzrBqESn+9+BDJVnyR9V2eNAkr5rF9TtFa0+thDYWs/LdyBOkODDDRmpKB5t9Qg9hi8JOBu94UhPp10j2BFFJIjF+pdGpXUxgjipd6DUzQo01PWdqbmcTSwRvTTIewRTFlu+9kZMT1BCn+t8C1xYtmj08iKCEbJM7Uwy9qQ1sKIlVk4OJwi/buAheLYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LofBqMpfl18Q/HbCit14JoiP6OJQFguN8RYF1Fr0UjE=;
 b=upiqdRAxiNKAw84unQQVT0YkDDPz6oB0tYspkY2GhjBh5c447wUCR0eAGXYzavxPdwuXf8NGfyRZd0p+BMeG2gKr/CLSM9Jufu/Yl0FmYWmUzT/SjUZ1qQzlN2jC4JhYg9faxn82LzlXikFHxaOEZ+JkgrP4XjlreMLBxYjGxrKYmeKfVExGCtnZ/ylfrEP/Syvfg0X/CzAHGp3t/uht2Eh0ublAbmzXE7BAPeAgba9sjfvSbAIWA1MCEopGTaaMATF92LVCS30uA8PdBzcAHuEsrOh1dSUcmk0D9bpqlu2amYcSTc7bwJfNhrBhdYdIDXeEQbw+Ni+/mB2V9EHBEA==
Received: from BN9PR03CA0654.namprd03.prod.outlook.com (2603:10b6:408:13b::29)
 by MW4PR12MB7288.namprd12.prod.outlook.com (2603:10b6:303:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Mon, 22 Sep
 2025 14:16:38 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com
 (2603:10b6:408:13b:cafe::46) by BN9PR03CA0654.outlook.office365.com
 (2603:10b6:408:13b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Mon,
 22 Sep 2025 14:16:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00029927.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 22 Sep 2025 14:16:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Mon, 22 Sep
 2025 07:16:16 -0700
Received: from fedora.docsis.vodafone.cz (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.34; Mon, 22 Sep 2025 07:16:11 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov
	<razor@blackwall.org>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Petr Machata <petrm@nvidia.com>,
	<bridge@lists.linux-foundation.org>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 2/2] selftests: bridge_fdb_local_vlan_0: Test FDB vs. NET_ADDR_SET behavior
Date: Mon, 22 Sep 2025 16:14:49 +0200
Message-ID: <137cc25396f5a4f407267af895a14bc45552ba5f.1758550408.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <415202b2d1b9b0899479a502bbe2ba188678f192.1758550408.git.petrm@nvidia.com>
References: <415202b2d1b9b0899479a502bbe2ba188678f192.1758550408.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00029927:EE_|MW4PR12MB7288:EE_
X-MS-Office365-Filtering-Correlation-Id: 26cedb8b-a55f-4df9-7ca6-08ddf9e2a4ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yXmG8C4eeQVtvxxLcXwJ/nN3QMj6XBInjD4d/o8Bcan1/qcrIuLHq3wo2LAo?=
 =?us-ascii?Q?h3/8hWz9fZWjJkl2onlWsOBVnFnPsniLHKEHLMPUthKfuYf6QMRx3tj664pQ?=
 =?us-ascii?Q?sqBXZnjAkvn122Wencoz227ycdR8AppH+EreQZkwLZdMXG9bO2KUBXgHItjr?=
 =?us-ascii?Q?oXB34bLo1IOZTzgfjW6HXa9HTwSACGrSFuVaGLdPrwo9CsfiK0oedufgGNFb?=
 =?us-ascii?Q?T1fsc7yKKFiRRsG6CS39AoG6DsAzYIXvDPzcndzVxhc9EjQ1vAlt53Kk3V3i?=
 =?us-ascii?Q?MLPQu8KJLA7u4R8QaJyIRBZAom9Efpxeh8i4CpePpvNLk+nroMy3zI4Etpi0?=
 =?us-ascii?Q?PDJnMft9p9AwYHg0keNbWIcslNagw8tG7WnACsBttOT+jRkUE4gJxpsWSUUI?=
 =?us-ascii?Q?XDGrCPxwTEjYzQPPFMbRcj3g9Xu1XlSf2ul41ij23hLdkDATCC24x93R/9fE?=
 =?us-ascii?Q?a1SH3SK42SzM1OwZlKcQFS46Ac6dvScG+GrF6q9EstWeWfEs05ibUzDH4H1Y?=
 =?us-ascii?Q?01Y2oSiYiBfYcbYWlPZpXMdtuSqcRRLm8s2Qzq5mloxPOtctOmHsh+UZQv4b?=
 =?us-ascii?Q?dXvAxywq7bX5/G0QZSi6NPZV8d9rPfgWQdziW0Y6X6Dwfs46rkbfYi3/RFEj?=
 =?us-ascii?Q?lxbD91X7BrmhY1Yf40scOccIAZ0Qr4EmppYFrVDu9qvN6wQfTKL3vMRu0wey?=
 =?us-ascii?Q?rdXNIDgzlqcuaaRQeG4M1m0dnWeO6HXVoncLmc0Gsp26H22kIEUM3P1yx2Qy?=
 =?us-ascii?Q?RSX+c9+s9d+up2peQQkj5RkusA+CDNgzYzxZyvOZ2l2FJvKKGoP+1ioEkpeD?=
 =?us-ascii?Q?ZzPpTww6PT1LR7sUxP0ntuLZkSrICpCRjX7a0lABi41rajUXEr5tnj7CYvea?=
 =?us-ascii?Q?SMUvGIpjrGTralYOiQDpwqTejZddztwNW6R78SHBQEYUxNT4OasMo1hb1mJc?=
 =?us-ascii?Q?evj5bVqEUJ7ZZRlhp9ngjx2Dl9FNCUHm8b2SWiE7PDN5XObw5QuMH1QNhp30?=
 =?us-ascii?Q?xlcT36zLJLprdoF/16YgRDeXBRUa9BFso1bLmHK7tXurXmtqLDV5j8DgHvp/?=
 =?us-ascii?Q?KGJlEfjZzi+QIPgp253AR+NBjCksJnH56bbQKScF181KHFVr3t6yGeqTv+7m?=
 =?us-ascii?Q?+1vEBl+ms23IU7qlM38AesDa7nxLNBw4DygVhq+VD8SDsvt/y36kMC3T7MYY?=
 =?us-ascii?Q?sSHxoFQYXdL7oFeRAFUKxqEqrLFPN0rS9o9Pw//mj6KlJJ81rF8yoAkzPrfI?=
 =?us-ascii?Q?OKToOFMhDib0AOkGf6l209DkXG5tzuwl9pOWp7dMPW3RAZ946fdSApMcBH/C?=
 =?us-ascii?Q?JGl0XfnavVRgmiuwuldSyDsQAM/+czLpChps7EX4oH/fUQoKl5VEaKuwNeiU?=
 =?us-ascii?Q?Y1YAhhIqtUNO+zHVdkPpG+8WiNXOIjUl/hSKh3r5xz7+wAsYoXXgkGftCUL8?=
 =?us-ascii?Q?8wYVuOu8NmWxzlrMybRc0H/6f4xvcyui29O1XurQWpOlKqT/8aUc0+T6WIX8?=
 =?us-ascii?Q?Kaa4M5ASEOpRW31U/KmRW654VEeSsUQx2Mda?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 14:16:37.7556
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26cedb8b-a55f-4df9-7ca6-08ddf9e2a4ce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7288

The previous patch fixed an issue whereby no FDB entry would be created for
the bridge itself on VLAN 0 under some circumstances. This could break
forwarding. Add a test for the fix.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../net/forwarding/bridge_fdb_local_vlan_0.sh | 28 ++++++++++++++++---
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_fdb_local_vlan_0.sh b/tools/testing/selftests/net/forwarding/bridge_fdb_local_vlan_0.sh
index 5a0b43aff5aa..65f74c46c2f3 100755
--- a/tools/testing/selftests/net/forwarding/bridge_fdb_local_vlan_0.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_fdb_local_vlan_0.sh
@@ -27,6 +27,7 @@ ALL_TESTS="
 	test_d_sharing
 	test_q_no_sharing
 	test_q_sharing
+	test_addr_set
 "
 
 NUM_NETIFS=6
@@ -110,13 +111,10 @@ setup_prepare()
 	switch_create
 }
 
-adf_bridge_create()
+adf_bridge_configure()
 {
 	local dev
-	local mac
 
-	ip_link_add br up type bridge vlan_default_pvid 0 "$@"
-	mac=$(mac_get br)
 	ip_addr_add br 192.0.2.3/28
 	ip_addr_add br 2001:db8:1::3/64
 
@@ -130,7 +128,15 @@ adf_bridge_create()
 		bridge_vlan_add dev "$dev" vid 2
 		bridge_vlan_add dev "$dev" vid 3
 	done
+}
 
+adf_bridge_create()
+{
+	local mac
+
+	ip_link_add br up type bridge vlan_default_pvid 0 "$@"
+	mac=$(mac_get br)
+	adf_bridge_configure
 	ip_link_set_addr br "$mac"
 }
 
@@ -367,6 +373,20 @@ test_q_sharing()
 	do_test_sharing 1
 }
 
+adf_addr_set_bridge_create()
+{
+	ip_link_add br up type bridge vlan_filtering 0
+	ip_link_set_addr br "$(mac_get br)"
+	adf_bridge_configure
+}
+
+test_addr_set()
+{
+	adf_addr_set_bridge_create
+	setup_wait
+
+	do_end_to_end_test "$(mac_get br)" "NET_ADDR_SET: end to end, br MAC"
+}
 
 trap cleanup EXIT
 
-- 
2.49.0


