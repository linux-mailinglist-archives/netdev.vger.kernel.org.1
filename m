Return-Path: <netdev+bounces-162603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B56A274F6
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 15:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E7C17A3A8D
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4442144CD;
	Tue,  4 Feb 2025 14:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rnCho/lt"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2054.outbound.protection.outlook.com [40.107.101.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF2A214205
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 14:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738681021; cv=fail; b=B9f3EUxmabiVekJ+E4EsryXollab0zIODpJ0hrnGNSotBCZfCPRRjsD4bPQ1mznGkttrBAS84Ayrc5a+MvFoSek951oy7ixsBTRf2Zitnbwcb6pQt0Um2RMLGXLVe47UkNlisNseNUMr1SHI/g2PoKY4JttxtzS33worpdHj9xA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738681021; c=relaxed/simple;
	bh=8kiyNfshBS5syPTy6zaxIPkoV95irIJCEKJGkRUt9Qg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MQGUQVLt0hApKX4w0rcTaU26lG+wIDc3fhd6cs5sdNIdRPNSnLrjhgbs3nriXap7f603tPM8uQ9c8rBt4iCNdkD3uZJeN5cWqU9IaoNnW1MM94X192phnhmipu80Upb+EWqSGSpeDN4YDLyuKcn0UysWqgV7+0VSp+D6ixmugaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rnCho/lt; arc=fail smtp.client-ip=40.107.101.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJ80eKuKZHCVZ8n7voafv2D7X1pGkQWMO+5t5eQy+iIw853eJaKZedxH1Z4TySD2/cDKmWUbq3/doAAOR4WqEpGs0lhp6vfl2eh50WbgcINQUncbSsKZcpGu9VBMi7vdU5dkvB2lihvwAcGa8ugs2SQUXxfwq7KIdJiasPoCpMDY/gig9wcfIo+Wi/G3cBOhs8a0u7APK3/Pi5jfHqYJ1ncmqGn320m1HxPHACTHuhJK1AjqYyjg6DCFxAY3FqgSAkzONVFhkvFqdlbeourwV0XAAMso4aGW2HCj/w9G93Z45qoxFZBostttE2M/yBwprNKzB/VQStotxUgICygFrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PNUP0iLIDfL5RH4Z2UGeZ069sKL11ggDEQMXbC2fz7E=;
 b=A8C2eAt8regAJj/soRHmd7EQ6dGaLLuslIrws9aP4kTc3J+abmH18WXkHH9oaRVroG8haMjpIzq4eOAh9quQclqq/Ns0ENkXj7hBXbqNSWrXjN4uLCpzvtriz6UzYrT1LZanU8EnYohoE2dWO1eQMOSpfbQeA7lctRKzGGXswq071NjuvX4B1Ox1gVdCYNaTwq0OnHPPXpQJjdaiCKh526wR8MRS8NbCqJGtYMk0Hu/A7OAqaWTctYTyGeJrfsDBKlHg7g/2hCa/PBasUw6Y1uXG+LaXSnAViXW+gI6uwCLlmEP8OfHp4YA+gY1LymFlDBg98l++0hLECAaZv6x+PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PNUP0iLIDfL5RH4Z2UGeZ069sKL11ggDEQMXbC2fz7E=;
 b=rnCho/ltOc8zYp3t8gBW7gxF3j9/llfiDEiuMdnugf1TlYR5vuePgyEprIMdJ1lVu/DVIZULYgj31mzt85YQnka7/3BkQAlqFJhZpWc1zBiu+DBO7cSmP7jpY/hifoTSsckI0keVkd5Li2ARMg3OBvye3zqrk5RvwsuTf0WxYD/T1Ar9uGWMCZvqMKPH7kJy5ZhsSh8oDqHFen5xYHGZ7U1o7zgcrVCaVEn3zwLta4fV32jypY2eAPrAW6onGS7pFrJLIR6KVrRkiL2HNCBAN7OQiQ6snDEJWLc3xtHHMbrv36vIR9a2fokteFjUnb4ak8MdzN5aGb7ddtYnQTqX1w==
Received: from DS7PR03CA0067.namprd03.prod.outlook.com (2603:10b6:5:3bb::12)
 by BN5PR12MB9509.namprd12.prod.outlook.com (2603:10b6:408:2a8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.26; Tue, 4 Feb
 2025 14:56:57 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:5:3bb:cafe::46) by DS7PR03CA0067.outlook.office365.com
 (2603:10b6:5:3bb::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Tue,
 4 Feb 2025 14:56:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Tue, 4 Feb 2025 14:56:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Feb 2025
 06:56:34 -0800
Received: from shredder.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 4 Feb
 2025 06:56:30 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<petrm@nvidia.com>, <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 6/8] vxlan: Age out FDB entries based on 'updated' time
Date: Tue, 4 Feb 2025 16:55:47 +0200
Message-ID: <20250204145549.1216254-7-idosch@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250204145549.1216254-1-idosch@nvidia.com>
References: <20250204145549.1216254-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|BN5PR12MB9509:EE_
X-MS-Office365-Filtering-Correlation-Id: bd8d652e-1c55-4c73-bc44-08dd452c2b8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d44MtlXRd9aH7asyvb1Ltn0xywLL3lXdRgSi4TkJUCMwzpPN9NbN3YSe1TUY?=
 =?us-ascii?Q?YB8u06kuFX8X+a0L/9azw77ZYyVwFSal0W5sq4hzVm0P6SeqLPyTXK4Kc7ml?=
 =?us-ascii?Q?1UTlfe9mytCycGCOtQhZPTEqDPz82DiB/X6ORj4kVEa5kL07yTKeO2vVDRHn?=
 =?us-ascii?Q?yluRD1BwMpdUlDNhNGHr5D6WMDS6i7jMVBknOpBNsqEmZCEM2qBjB6QpMOGf?=
 =?us-ascii?Q?NetWNyUtkXqUZfqLCqXAQSpdwwWDSEAreRggtEtJAvjGnCK264PgX0zmVyNA?=
 =?us-ascii?Q?/cdyXSlGMCxvLLPUv9SMq7TQ+KwZHqIWilJqzxw2c363wrrM1ft8qG1uSVa5?=
 =?us-ascii?Q?TmfDfT+i9T+YA5Qt6xgNjl2G06lD+UJGArFj297vCJB8Cbpzs5eMq2c+7rJH?=
 =?us-ascii?Q?0PMz22274RKr0wUZWy6g/L5/igmslSl/vh7ePZvBpZ/AFnv/HtaMX4sTmXW5?=
 =?us-ascii?Q?LDCxTkWam9c+uuU+qyI5v/gQ1qlCiHBORIBFqTBhHKLA4LW+84UBVwnFJX5v?=
 =?us-ascii?Q?2WewY55i/G2j3b8rc3Pa7+lBupeoMq4EHaJ9kOG6ZOCD7yaKpI+J9Ir26g3m?=
 =?us-ascii?Q?73/9elPhk8NRDIpmKK68ec8ficfCs264N2ILpn+xc8SrioJfDsq714jxhj3L?=
 =?us-ascii?Q?ugzyM7dCBi2n/7KNnmmnJCyxNrishEEpDOCecfOSdOPqCy7EM3ukRJLvKzTG?=
 =?us-ascii?Q?hLHeDhWUv3g4gPwcke55RmToeajA971aE/38g9UmAtQX1H6dGkzHNb6uFbxf?=
 =?us-ascii?Q?3xXuEeDOh+vT/ZRey55RORlJIULUKNETOB7jT0ug+wTF8qZDfnTsZoBFrWj/?=
 =?us-ascii?Q?q0Wr+X/QYvVe4sJQl8kUdsdiih0gIPcwRPuNFf9Ut2FgRO4n6NCrtAxJPZd4?=
 =?us-ascii?Q?KZf/GtFbMUsYGaansJPj/fTlUE+BpgSvxq3RfJxp3T+vpOdJKL+PA+Fys365?=
 =?us-ascii?Q?yjxNCrzXfSHxUgzBGC8gQ3qOfqTAoQDgQeUsf6m9Qzpb2mE+kEA+m2EopObB?=
 =?us-ascii?Q?9gcAsOZz67qu8IPT4B9Z5zUtJZwNpo6/R38kzEijHVPVfapCPWhf+OrefHVb?=
 =?us-ascii?Q?v5IqloUwAZI0OUOD/HPQcoJha3zxMF5MP7mjcUHVlUCclBAqJBR9SsEfVHnI?=
 =?us-ascii?Q?uCQ7tQsjKnz3Ls8yuDJMuMAYM53wMerMpROVLuYS+pCNoRIEqGDnrXdQzFFz?=
 =?us-ascii?Q?n0PSVTIqgvNmqTD72pRh8YlApZYYoeAqNkkRI3KyjL1ncPAC2YlbszSVwOvR?=
 =?us-ascii?Q?Vv7OIZTVa1P9d8d/i1jtUL7lKd9NJbdPKK7W1eoXsho38tbXsuXnS8n9c7SB?=
 =?us-ascii?Q?IMmm13xGFrscpCPM378rjeli8aArmJZHV/vcil3kbOGuCSzfFlywMQoQcoWv?=
 =?us-ascii?Q?KPBNPv8paPFp08N90teMCX07ngY3EDuc3Rbdo4XUP3FBmoITp3ZhONqmqVHs?=
 =?us-ascii?Q?bp9CP4lJ5+QnBocRLfM4hGLYtdmDMHS7wr5bu2hOqMOqTiKoJ3KTFQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 14:56:56.6905
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd8d652e-1c55-4c73-bc44-08dd452c2b8c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9509

Currently, the VXLAN driver ages out FDB entries based on their 'used'
time which is refreshed by both the Tx and Rx paths. This means that an
FDB entry will not age out if traffic is only forwarded to the target
host:

 # ip link add name vx1 up type vxlan id 10010 local 192.0.2.1 dstport 4789 learning ageing 10
 # bridge fdb add 00:11:22:33:44:55 dev vx1 self dynamic dst 198.51.100.1
 # bridge fdb get 00:11:22:33:44:55 br vx1 self
 00:11:22:33:44:55 dev vx1 dst 198.51.100.1 self
 # mausezahn vx1 -a own -b 00:11:22:33:44:55 -c 0 -p 100 -q &
 # sleep 20
 # bridge fdb get 00:11:22:33:44:55 br vx1 self
 00:11:22:33:44:55 dev vx1 dst 198.51.100.1 self

This is wrong as an FDB entry will remain present when we no longer have
an indication that the host is still behind the current remote. It is
also inconsistent with the bridge driver:

 # ip link add name br1 up type bridge ageing_time $((10 * 100))
 # ip link add name swp1 up master br1 type dummy
 # bridge fdb add 00:11:22:33:44:55 dev swp1 master dynamic
 # bridge fdb get 00:11:22:33:44:55 br br1
 00:11:22:33:44:55 dev swp1 master br1
 # mausezahn br1 -a own -b 00:11:22:33:44:55 -c 0 -p 100 -q &
 # sleep 20
 # bridge fdb get 00:11:22:33:44:55 br br1
 Error: Fdb entry not found.

Solve this by aging out entries based on their 'updated' time, which is
not refreshed by the Tx path:

 # ip link add name vx1 up type vxlan id 10010 local 192.0.2.1 dstport 4789 learning ageing 10
 # bridge fdb add 00:11:22:33:44:55 dev vx1 self dynamic dst 198.51.100.1
 # bridge fdb get 00:11:22:33:44:55 br vx1 self
 00:11:22:33:44:55 dev vx1 dst 198.51.100.1 self
 # mausezahn vx1 -a own -b 00:11:22:33:44:55 -c 0 -p 100 -q &
 # sleep 20
 # bridge fdb get 00:11:22:33:44:55 br vx1 self
 Error: Fdb entry not found.

But is refreshed by the Rx path:

 # ip address add 192.0.2.1/32 dev lo
 # ip link add name vx1 up type vxlan id 10010 local 192.0.2.1 dstport 4789 localbypass
 # ip link add name vx2 up type vxlan id 20010 local 192.0.2.1 dstport 4789 learning ageing 10
 # bridge fdb add 00:11:22:33:44:55 dev vx1 self static dst 127.0.0.1 vni 20010
 # mausezahn vx1 -a 00:aa:bb:cc:dd:ee -b 00:11:22:33:44:55 -c 0 -p 100 -q &
 # sleep 20
 # bridge fdb get 00:aa:bb:cc:dd:ee br vx2 self
 00:aa:bb:cc:dd:ee dev vx2 dst 127.0.0.1 self
 # pkill mausezahn
 # sleep 20
 # bridge fdb get 00:aa:bb:cc:dd:ee br vx2 self
 Error: Fdb entry not found.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vxlan/vxlan_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index c75fcb0679ac..01797becae09 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2860,7 +2860,7 @@ static void vxlan_cleanup(struct timer_list *t)
 			if (f->flags & NTF_EXT_LEARNED)
 				continue;
 
-			timeout = READ_ONCE(f->used) + vxlan->cfg.age_interval * HZ;
+			timeout = READ_ONCE(f->updated) + vxlan->cfg.age_interval * HZ;
 			if (time_before_eq(timeout, jiffies)) {
 				netdev_dbg(vxlan->dev,
 					   "garbage collect %pM\n",
-- 
2.48.1


