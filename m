Return-Path: <netdev+bounces-198061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23636ADB1F1
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 15:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C194C3B975E
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 13:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B5E2877E3;
	Mon, 16 Jun 2025 13:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UKQqQVv5"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0412DBF4C
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 13:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750080387; cv=fail; b=iq7T7TG5iknbPpsi/TCRash1XHdLzldlC1bbO5Dx3Fi5XO/t4iFiEmT78XkUUWkPC/P7X8ZzDU5b+/ncGN2bkIyD2NfjZihkJJYFCJdcyBBfHyOq6Em4aPyN4GqnycH7IlSDJTfNSHpXffW27ilpIZSu4V+qwbmdp1sxxV6crSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750080387; c=relaxed/simple;
	bh=REGfHG84ZFMtJJae8eePuBsAxdNKUueEH9yGY5Kt2ks=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K0RrHP0WNKrkhbF+d0/CJ/ciS5tqTFVy3Rp8IB8ICk+uXPrLvoAQGmRTnIDpZP340Z5auCEAp7hqjt0j8ZQ184inCtrCuD+w4VLnVmIIvOkRH6HjxrhOOgmhAnRE0bC2POVdXLbaeu0+XGzW5Z+O4vyqswyDXPJRY/fd2//Dn+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UKQqQVv5; arc=fail smtp.client-ip=40.107.93.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OZlXdUZBzJOlxwI1uZJ4k38xOoWntAljmxLd0Ym/qchxnoAM1SkFP2ADd3PWJyiRNRD1epBK9IPQUypQfovWCU21YsjO63wD9Tow7W/kyyBHG4rQaPd0qg8eEN65rUwhUJZEvHXZXW5nzLBGbfMAaCQAUV15glk+WanpNQqgft6G1mEQwdvrWLbWkhF47qAcq81Pjd9mQnZ/MpD4nRSCR+qIuIZ+2luxry+UyOSjCGqVLKslSO0L0B1O6ZMtQWp0VelNjJ1uhjZqzchW6G3x9TrMpogD3qDBsCLZmiQvJkS9UE4ThtI2NFcHu1vQoajCkIWhWXeSzcF7OuYuxVGLFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=McGPAmtypePj0Qx3RdBo37zNbnoLbT4GqVDmn7DCCDw=;
 b=l3uO5PY2kQwdXUDFWO4egqUu5z8hELXvtv0/Bq0jkzAHulOv/G8NAwJoBHoz5eT3gS0MBYE3k2sdrBGTp9KT/WXvo5txStRYxN9faG7b86SsRm+8IyK1pqw/BlkCxxcwP/aH5/cVd1Agh9giPeRdJQUI0BXI16NDnqPqcbcfARM/XAOYrFtoAL/Qq7wpr9psxUg/B2frCoDdaQtbQFRqDtIy0WMJUpEUESYob5tWjBea8aBy/UNi5Txxvr2QQNlPokhxS2LapC/XJ6WwTQugVUkdUduejLIH3paEaTNhq7eUvV7qWeko/1hMskm4TsClVEoV+UJfEgo4UyWSdgvkPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=McGPAmtypePj0Qx3RdBo37zNbnoLbT4GqVDmn7DCCDw=;
 b=UKQqQVv5U8Pa4gWt+5PnHrAxMYHNvcsyeRMXi/zh68YeCGFrrjVIEmuBsY66Fw5XwBqRpIdswSZFU+Qt1buR9vAUNK8tLm/72J0veFAug27fFbANnLFiDQPDF3gq8BuXWJojVWQ4qrdheCYLnNqiuxEhKrLwDd7brwNQvvb+eVuEe3U93RkHqLbPei8/W/RSQW7T+sKXv4oGxtBPcuP//rjaKdvaDckBbupdJCXcqcRTNzvoT0kAat4kiJOeN2eP0FTBV6fm5bq4I/X20QcinzGRYtV7K4v5KuExwG+7Z6a/FOFXXYKUTAJaTV4tVQiT32EKFl+IiC6++EvVii+/UQ==
Received: from BN9PR03CA0206.namprd03.prod.outlook.com (2603:10b6:408:f9::31)
 by CH3PR12MB9316.namprd12.prod.outlook.com (2603:10b6:610:1ce::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 13:26:22 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:408:f9:cafe::e7) by BN9PR03CA0206.outlook.office365.com
 (2603:10b6:408:f9::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Mon,
 16 Jun 2025 13:26:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 13:26:21 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Jun
 2025 06:26:07 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 16 Jun
 2025 06:26:06 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 16
 Jun 2025 06:26:04 -0700
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Gal Pressman <gal@nvidia.com>, Alex Lazar <alazar@nvidia.com>, "Dragos
 Tatulea" <dtatulea@nvidia.com>
Subject: [PATCH net-next v2 3/3] net: vlan: Use IS_ENABLED() helper for CONFIG_VLAN_8021Q guard
Date: Mon, 16 Jun 2025 16:26:26 +0300
Message-ID: <20250616132626.1749331-4-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250616132626.1749331-1-gal@nvidia.com>
References: <20250616132626.1749331-1-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|CH3PR12MB9316:EE_
X-MS-Office365-Filtering-Correlation-Id: da468f8a-b77d-4431-12f0-08ddacd962b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aHZmMW9MRVo3VFJQcVVnSkFITkl5bXJOZWdrbVJLQi9jZjFNYWJETU5mVHZU?=
 =?utf-8?B?TlVDMVNYNklDSXJaTVZmYkYwZlVVMmVnS2t6cGhEdFByS2RPNU8xQS9zNWpt?=
 =?utf-8?B?bzd1dVdXQnVZY0E2Y0l1SHlUZ3BPei9hTEdabHNaWThGcU0wZVpHWGhjMEFQ?=
 =?utf-8?B?Mm4zUXJVbWR2YU43VDRPZXNtODVqN2NxMlVBOWY5aER2UlkvZW1RVXNIVTZa?=
 =?utf-8?B?L241U3pGcVNScVUzbVB6Vm5SUFAyUXQyekxPa0lkVDlHUXJBSTBCd2RoL1Vh?=
 =?utf-8?B?VXMwajNwc1ZCV1loMlVIMU5YNDNaVnp1VVRxRnRSOVdRcUhOdkN5T1krVi9m?=
 =?utf-8?B?d2h6R3AyMU11bVEwYUtyeTkrbk83WU1uNFFHa3NHVmcxVEVueVI3Y21MQ3Jy?=
 =?utf-8?B?d3pTUTVjT1JTdy9oY3JyRHRwNmM5VUs3T25JbVlDNUVDa1k0YTZKcEdENTdY?=
 =?utf-8?B?MktnT0gwRHp5ZUs4cy9FYUJJcFFkNXI0eDYzemVjYW1KeXZGNjZjYVNkZ0or?=
 =?utf-8?B?eU1jeUx6SnVHRjR2dkw5KzBxbDJrNFA5ZlVDN2xha3pKV0ZCTHRjYVBxRDRp?=
 =?utf-8?B?S3RTNHdlaU1sd0xlVldISHlaNzJodWVRaVlMZmd4T3BlYUJrQmk2TVgxYmxh?=
 =?utf-8?B?T1hMOGkxRldNRmcwaG45cklGSGtvZ1hPdm0xK1VYK1FkYjU4cmc4TGlpVmpm?=
 =?utf-8?B?dEMxdDA4Vk5pKzFQTXBCUjNKM0ltMHFpN1MvRll3eU96WjVsZW03VmxPbVpO?=
 =?utf-8?B?MFhyOUxCNzBGN0hNcEFROWM0TnA2YWtEM29qc1F6eXBuOG1jcmxqY3lwd2hN?=
 =?utf-8?B?dGx3RGYrNXYyT1JJOGNFcTdWSDhzNlQ3aUp5YnowNlRSTzZHMlJNV0E4M2wx?=
 =?utf-8?B?MjdSZ0ZUNVNzTHdCN1VHaFdrY3gzVUM2OE5SMit3T1RYUTdJVTl0ekJPS0M4?=
 =?utf-8?B?U2pOUC9VYU52eDVKYUNCNmp6aW11SUlwcXZROEd4WUswTnViM08zVk8yREJ1?=
 =?utf-8?B?dDNvaFF6OGFMd3JidnhIKzhOUDdRa2t4WGpsN0NnVHQ1NFlXTnc2RUNVMzdq?=
 =?utf-8?B?ODJaOEJDYlVTUlREeHFLQmZVcmZvenF6aFZqekprNFhudkErVm1uWUlIU0Vx?=
 =?utf-8?B?M3pWUm8zUGluZzIrUWRZZkhGZ1BpM0FGSTJGSm5rRW54MW1pMGpmS3pOTlhQ?=
 =?utf-8?B?UTMvK0EyWEppZEdjK3JqNWtVSHhwR3R3WU9pdTIxODgzWVU4eWhVTXc1MHhL?=
 =?utf-8?B?bXZza29mT0Q2anhBOWpldkRXdWwvUUNJWGFCbTkyUGtaNFBwamZSM2didC9X?=
 =?utf-8?B?NThyNUhlQm8vNTRUODZZNGkrSVpZNThGRWNQakhxOG9ldHM3bWFsTjJEcS9h?=
 =?utf-8?B?NjAweTVwOVJ0VURCV2lSWmZQY3AzLzV1aFRhaUtDZExtcDFxWFgzSHBwUnpr?=
 =?utf-8?B?djJUTWhhWnJKVFdPd2tsK3VuS1A4c0xVajJxWjhoeHJyMk5XQXRVa3VaU3dk?=
 =?utf-8?B?N2EyYnV0ZXFxYUNPaFAvK3FrSjFPbEg5U2Z2Yi96d2VTWGo1QWRkL21DWTFE?=
 =?utf-8?B?UFdVM011OGVUcEpNQktuNTBlTGRTeDN1UFhOYkJTdUpVdGZiTjExTGlNNG1M?=
 =?utf-8?B?cS9KYnJXT2Z2aElzVkQ2bTBCMXF1elR4OGtNV3hIZEhNcEtRS04wMHdwS2V5?=
 =?utf-8?B?OXlwQW1hRmZJM3d1eGx2bE1oREF2bVd5SEVNaWZ4Q3M1bXN0aGNnQnhoeDZZ?=
 =?utf-8?B?WWF3MGN3VHRWcGd2RTlPcnIwaXFRWVRCb3dQVVJ6QjA4UUNkQTZETzNJVmR0?=
 =?utf-8?B?WGd1YUFlQ2Fwc0Y4VXpaalpUMWljMU1haVJ3TWlxcExCeWkzOVB1amFIMmwv?=
 =?utf-8?B?MW5SRHQ3Ly9QeG0zTXZNcHJtQ0wvUzNrMS9JWTFCbEZmUzdPVkpnR0ZsV1BT?=
 =?utf-8?B?L1hBSytFZnZEL1JkMUVUZVJBRVYyak13ekRhUzh3dTVITjl5cWRHbzBKNFlm?=
 =?utf-8?B?Z1pFNHIrZzlPRDNQZ09hREd0MHVKQlc3emVTWjhiUEVGYnFaZFRzcm9TVUJk?=
 =?utf-8?Q?UJXNia?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 13:26:21.8491
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da468f8a-b77d-4431-12f0-08ddacd962b9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9316

The header currently tests the VLAN core with an explicit pair of 'if
defined' checks:
    #if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)

Instead, use IS_ENABLED() which is the kernel way to test whether an
option is configured as builtin/module.

This is purely cosmetic – no functional changes.

Reviewed-by: Alex Lazar <alazar@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 include/linux/if_vlan.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index b9f699799cf6..15e01935d3fa 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -131,7 +131,7 @@ struct vlan_pcpu_stats {
 	u32			tx_dropped;
 };
 
-#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
+#if IS_ENABLED(CONFIG_VLAN_8021Q)
 
 extern struct net_device *__vlan_find_dev_deep_rcu(struct net_device *real_dev,
 					       __be16 vlan_proto, u16 vlan_id);
-- 
2.40.1


