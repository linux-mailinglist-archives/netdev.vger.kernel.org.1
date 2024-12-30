Return-Path: <netdev+bounces-154579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E740C9FEB1D
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 22:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74671161C25
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 21:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA762199EA1;
	Mon, 30 Dec 2024 21:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1cvdGPFx"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC551AAE33;
	Mon, 30 Dec 2024 21:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735595119; cv=fail; b=VQSnX457YKaqfV9rvqr3EqNG6YzBlv2TfylVoqByvqmY4vXxwQm6vG+rdRq/8t0iVRC9HZsT9+qbC9EGzHkNVfrtGc1DJlSpf2XBxemnNpQ3bS2cQS/F121sd/t/38YJ8LKBl3CnyS9hIhIhKFZphDYTA9o7MOspuykguiKRM3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735595119; c=relaxed/simple;
	bh=VflIMhBNjJfydQ7ctZA8X9IGvN2rtNDbSPPQ2t1rmI8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GY4Ak14M6GghtO8lAnngcKTMQ6/PfSYU0J2FEWA+JJsSi9OyH+PITgsiAJUQElQFd7RJZPwubgFNKtEg1+jmp5QPjhjpZfIvmjSXwimRkQ+pqABrsTyt1Pb/FJibSdEKUf0zEMYO0aIXcgL4+c3uEPAyPCFjB4tKPbY5WtK8jXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1cvdGPFx; arc=fail smtp.client-ip=40.107.92.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uDbKKMXnnzQ7OyO2MiBiC6jDccVvaZm+849VvMb/5gmksvHfr2CQIj8SAvOsYwu1HZYSG+pD9CWg92XI7ijNR8UX/EG9MWzUdiaG08pjTyTCQ2KsXAueVmvghWWSw2xc7k+2JY4dTBXaTySVtjgR7piuf0hhnTOIN1sLMGgAYjExOAu2w9ceHZIZUyRp40fHsFkU7QJmDPz1dHqLsBT8UBKWcgAs1lrfLIQTsYeOGlNcX8qd+g4R4j99WByk6q1+qIEw3vGstQcacUY2/66KFLSp1gZ9fr9fvC61jQKgowbCJ9QrzJnh6VDb5ovMfiCVk7HDkuVuXSuVjv6+6gs6Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vyWV9DeroERT0AWVO4D0Di5QcnbzVFoNh8e1Tzg3/7E=;
 b=QVxKX//PotecbuBj3mxQ3xggv0XD3ZL1hOhc0D6AJQlyxRbrfWM8qhOl8KsY2+ooGipQ7Mjzj/dXA4+VCzmY3SwEOLBtfDVWLYKpt7nL6BJbQ4JIlKBQ0m9S1RmDoUz1gLwxqyaB5sDNSXT/8xnQPA8rmtyhlBv35dqRrlJe58+FsueWCmHDFXiiTU6K+soH3DENYvsgGHLKoiVLBPI8RUJJIUiKBcAqTG/djOThfiaawh6QtAzVw41+uaLgDluCLk5pcqZsUZSHBUx1yvSoRKrDs2ZbrzvDkAfOeXkgUbVES8wnWpW53DIeDT1Wdimlcc1KWh28mHDFXfp6wuZoqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vyWV9DeroERT0AWVO4D0Di5QcnbzVFoNh8e1Tzg3/7E=;
 b=1cvdGPFxyeDA3MkM5bQzDjQb8l2vw7/fVaVCPm0JlM6+/gTIyOFJBNHbVWVerFa2PeCmm6kKBYNskaWGeMQrWrOGvn6iYIqDeaUj8DhxbgljNcNK7Ig4nqAzYOa4me+mPQHV7uDdxfSst55V/KPrMyIsxmK21RTnsQGRm1YdpN8=
Received: from SA0PR11CA0111.namprd11.prod.outlook.com (2603:10b6:806:d1::26)
 by DM4PR12MB5938.namprd12.prod.outlook.com (2603:10b6:8:69::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8293.19; Mon, 30 Dec 2024 21:45:11 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:806:d1:cafe::38) by SA0PR11CA0111.outlook.office365.com
 (2603:10b6:806:d1::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.20 via Frontend Transport; Mon,
 30 Dec 2024 21:45:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8314.11 via Frontend Transport; Mon, 30 Dec 2024 21:45:10 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Dec
 2024 15:45:08 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Dec 2024 15:45:07 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v9 10/27] resource: harden resource_contains
Date: Mon, 30 Dec 2024 21:44:28 +0000
Message-ID: <20241230214445.27602-11-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|DM4PR12MB5938:EE_
X-MS-Office365-Filtering-Correlation-Id: a01f3997-a95b-4a34-6ea3-08dd291b3c4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ENGvfcsG7lY5IHg3MJj7Dt6tPik7eFDqwfSiqU/Z4g5nb0zuZ08itOsFK3V8?=
 =?us-ascii?Q?3LtERY79uKdZC6FH7bImRGOxu+KJ2Bx20wvhwrHfQhVquAYAk5zfD9/CeRxK?=
 =?us-ascii?Q?SLd3itVhmRtUCMIZCVSIj3Ezj5Z5KjYncdYQQ91Vchcl5Gd8w1IhcE5trdfv?=
 =?us-ascii?Q?ie50TGt0oLMxMkZ4PutVnEvATSsIHJCEBk0TbY+dyeRhL02zYNNmBYiUVFRj?=
 =?us-ascii?Q?ni1AHsw0Dk06N9OZtak16x4IG4qj4MQTqChFR7xzibJgIEJSXA9bjqL3p0JQ?=
 =?us-ascii?Q?cdlRtwqkdhV6QKyxw+7oWvCw3909LhlZnFZbpWqRyde4EizT9ZlmTYd5wTOL?=
 =?us-ascii?Q?p5NLZ1n2F2NdouncLAs3U/wQmyVKVifvjATXfJuF1KVaW6zYNqjriDnoY9gs?=
 =?us-ascii?Q?9OGPDGNVY+o8wqiEyM8PCkEi+89c46USolg4CNn53FCYL9ZPBxF0u60uT8gh?=
 =?us-ascii?Q?GfWuP6c5URp5kLnY0DUrDTK4/odBtyroAStJ+T6RFe30eVVVEycC4cuP/fVS?=
 =?us-ascii?Q?GRcKcve9eTrUM0o/WeALrvZ2BXX39MEzIrvASpe3zsQjQh2lSm4nTxFM7Gk4?=
 =?us-ascii?Q?AHM0Fpa25z6gM5hFXDWRsVagKnqzenf8ndA0po6Q741rNYuiki6UHBYH9+VN?=
 =?us-ascii?Q?I4H7mZWzxFNTwkU58q4dKywJyqfQ4cJSGtV/cpclMdBxscxXBl6Yk/QjJZLr?=
 =?us-ascii?Q?r7PL30vZRdwAC1+pq5271dLOmTJ/D0F6usubbaRcombrIN2brerdlVix+86X?=
 =?us-ascii?Q?2oPGJsl9S/zaFki7pV1Yf0sLMr611IcJEguK24zCfA5c8x/C2pCrn2XdMC7u?=
 =?us-ascii?Q?rjKLOujzC4PmgbkNc9QNvl0dZdksJw+c2Vf+E4PO/AIi4Y8qzrKizzVXLFfQ?=
 =?us-ascii?Q?Exe4Lvp0TlB+tW6Zt1eM4ueHiDY7FP7b01zIG7S+jFAldUdUrtWG9viBrQVA?=
 =?us-ascii?Q?WhIkVwUwcoqF1eMotno0wbdqhLwcBQh/vdbTqqvsNH9uDfNqTwRJjPJJ3/rD?=
 =?us-ascii?Q?SNpEIuq2didoxP9El36BxWTKKFrMyUdMnOUK9J1q+xE8lgAW2FE9IoWrPOhd?=
 =?us-ascii?Q?JkQGS8V+TfMzzylqiiqLExxzuKbzvXajmUroQccmkXHDBE5sa54vApPbhV1j?=
 =?us-ascii?Q?dZ5O0YKX/v8UweKp6E6u6KY0pD+lfS4vI0y7ALTsAsnLUeltDFPYsKdm2VGZ?=
 =?us-ascii?Q?Pt2GIfTf1H4WvumlTazykfVI/8eo3fu4u8i1NeiNxrrsFCK6Kq+gFo0bsgj8?=
 =?us-ascii?Q?Dhhu0LleDBihJqO9mgYjz1l9Pvv6GD1V4IsXU1FvUbTtZKC9YuIcGTjeasKR?=
 =?us-ascii?Q?5vlY3Z1QiIqRHQMSYpqvVV/oAxHWfoz0xGf/JLv5NBYU6DdhOBtdJN+PJeUl?=
 =?us-ascii?Q?aY8EXtSiGwbwZgztYblT7wyITDn38U1VoYFdzG1LgDUameMrnQkkuCs2hgjJ?=
 =?us-ascii?Q?h5ebv3zCeSG6Km7LbSppGXL5iNsbV8mr+SKznCtJ1x9I3F/N2Jc67jQ7ujwc?=
 =?us-ascii?Q?iUNSMRYhP0TbYU8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2024 21:45:10.8376
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a01f3997-a95b-4a34-6ea3-08dd291b3c4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5938

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
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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


