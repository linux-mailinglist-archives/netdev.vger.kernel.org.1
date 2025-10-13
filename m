Return-Path: <netdev+bounces-228815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EB5BD4354
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 17:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0BB6134F673
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 15:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF35309EFA;
	Mon, 13 Oct 2025 15:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rrb1flrm"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012029.outbound.protection.outlook.com [52.101.48.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F2426F2B6;
	Mon, 13 Oct 2025 15:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760368656; cv=fail; b=UxRz9H8wvLe/vlF+bcfhBA6KYHiMBu62X9/QLEEYNtMvPO0JqEybGIk8qoCQ9xh4Adu3qi6pJ4kUdJGW6g1jLKJrrzA8mHwFNiZiffQeZR5gBREvkTVw1/F5cQqC4QdcfkuINKSPmx3GC/M33vomUOsMzzFJ7LzvLoz152jhumY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760368656; c=relaxed/simple;
	bh=XxN/WaN73qhPYM67m41eirldG/mKUikYZ80T4ICH1D8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q7I1+QuoJNyXo6T5iTxkYklipzNQWpXGETNPNo7qwyAIpLnL9qksNPpEhM6ZyJigJjtU3WKYhKP4n1cO/jlY0SezveZrz5NMkavDqBICO6xYncq2zSZQHYW8yesYwVAKJb5t+dQyKlVjTc8fl0fvIUYZFvh/rcAWKtxFWk/OyX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rrb1flrm; arc=fail smtp.client-ip=52.101.48.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xXQkIH+sqsHQ59bCzpYBYsDdtiQdTCitYVXmGHeYMc+GydN3Dhro72+RAjrEeCR+9CklnwgVW/8iNW3jAaXuhNfMdcTyyhy212rG9Fis21CpwBF8Jz8um6ZliE6EHifDScI3p7UxWd9IcQJeaqS+wcM2z3lAcnPtwng9z2fOlmYGbOMCfKhz4rKpTgVsjkqlGZr2V52K/9rfxZJ1kx3fpFbkuCqZSFY23x9h+Hw1KjJSTs7gWWPRbb06CTrigv2iCXz0qe+mOx+qjfUKZ7SNXB1VSPAzRgdAz4qNtVHkV9wFcL8J0lONoqe4+Y2GDQhXzvzSkaLcWM6evfuhL8V8xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XxN/WaN73qhPYM67m41eirldG/mKUikYZ80T4ICH1D8=;
 b=b0ZzRtadp9D7Ld7gTy98qfXIV/dyaEjBlrx2Nusb13dSUQzaswjUzoES19Ag5AHrXq/dk97yG36hm1SDWExquooMMPbsW0Mcdl2dPh142tveKERmHiEL9N7DJEYMSGCv+1rDLYnLuoYDYAnqbeXk6oN3YS8h7QDFm283CW5ZxJrAUwESjryloYnwCmL3wrzpK8qnWaPmeAZiiFb6W4z6/NqcdUz9wHUyDN3SWlmDoVsI1SzGbeUcjUF+kasMdrrKCf/5RnBxAXOUoM7KA4VRhHQqiPQlcyA8Mr9m7qwkA7xNzbs+Ijy/GRJ6gIuP3hLg+rssEOs7b/PZW5DCLVfwgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XxN/WaN73qhPYM67m41eirldG/mKUikYZ80T4ICH1D8=;
 b=rrb1flrm1vIIgjljq8B/MTpgw3SJWvsGqyClBklvHaODOPV0FsynV2t7fa8wV1+zIGb0xij/J+W5rXj6mOi/M3p3jEn+tBXZZCURUgl5xkE/GZaLmw4qG2wdEzY/m5KY7hJqu0/47UDwC69zbU1pGpXRywGdDQtB9QdzL4faaiyilDX+OHPrJeqLtQgK5cbgDdRS/PTr5WyMPijcIRxQJ1vwUOBg93EhmnofyVkz5o9Eg1m5vWx42qolht00cy2bhKhapcrfDzdAJZqP+Y2ZOfYYHX/QA5uIGfmwH8KSLzifvBMvWN9hfuN3+OHeVMBl67iOlOpxhjA2kucalJ3AaQ==
Received: from MW4PR03CA0057.namprd03.prod.outlook.com (2603:10b6:303:8e::32)
 by CH3PR12MB7593.namprd12.prod.outlook.com (2603:10b6:610:141::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Mon, 13 Oct
 2025 15:17:30 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:303:8e:cafe::e0) by MW4PR03CA0057.outlook.office365.com
 (2603:10b6:303:8e::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.12 via Frontend Transport; Mon,
 13 Oct 2025 15:17:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 15:17:29 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 13 Oct
 2025 08:17:17 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 13 Oct 2025 08:17:17 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 13
 Oct 2025 08:17:15 -0700
From: Chris Babroski <cbabroski@nvidia.com>
To: <cbabroski@nvidia.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <davthompson@nvidia.com>,
	<edumazet@google.com>, <hkallweit1@gmail.com>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux@armlinux.org.uk>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1] mlxbf_gige: report unknown speed and duplex when link is down
Date: Mon, 13 Oct 2025 11:17:15 -0400
Message-ID: <20251013151715.40715-1-cbabroski@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826184559.89822-1-cbabroski@nvidia.com>
References: <20250826184559.89822-1-cbabroski@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|CH3PR12MB7593:EE_
X-MS-Office365-Filtering-Correlation-Id: f8bd6c01-ce4c-400c-11d1-08de0a6b9ff1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zrS5SpVYalI80d3k1rpuq0iNNTNC+YJ+uB28KuK8x5I1ZodMEJ6w6E0fw0C+?=
 =?us-ascii?Q?9hUXlbMUvqUxC0LL6NWjUXTC9iLeSBEpCHqEEvkhSuQgo4JblAnhS+jwgoBN?=
 =?us-ascii?Q?3RpI85bXzjhkE3TPIVddUzCm9YbMhssQE+GnXASz5+4a/XKuV3H6FGgOrJr5?=
 =?us-ascii?Q?mhoj6oK7q51DnLe6FQ9ENjtLDczMjEjJtwDFgV5VOh+b4rYoSaSTJk6PfLTe?=
 =?us-ascii?Q?jFSBwNW1L7Wbo7EAxU/2G8VrDy9XEqXD7kemZHybx0zGSvBPJAipK8+LMcVx?=
 =?us-ascii?Q?KO6+4Fj5XMFbo0UDFm5vEcPbff+Q0+m2QNJrXRJ2dfuvAQqFHZPhXXCuzs1d?=
 =?us-ascii?Q?VhYjVNnEnYTi+SoaQ642gsZms08e7sOY3R6PfIYf6fFV8NwN973ggRNxcify?=
 =?us-ascii?Q?Ez4urqGHdIEcPWii1mDuU7PCWWyPUfqRDzSin0R/KkHDGJp63Otc/IDcqBYs?=
 =?us-ascii?Q?bX+Yf/QoVEDJZq140Jjq8iMn9dN+tPIA+GuHAQSG6CAWVZ230GUMa0BRAlL9?=
 =?us-ascii?Q?+rwlJswz07ZisOZ28eRshRgq3sf+EERF7wjXZgJY8/aXB5QImWwhHzJr3G5y?=
 =?us-ascii?Q?yDSNjATA8+K9DvQz3pIGCM0Lz5MFcZuRUKLwOUSkZcNqhj1hJV4Kr85BzmMz?=
 =?us-ascii?Q?aMWzZdXuJBa2n6UeigL+2wVvjnalvq+WhwFFBMPindRyOow7ZvVH/P8ywQ3c?=
 =?us-ascii?Q?yWUxNSaFsQDLwSaQAVDD7LxbAHtF3Er9a542P9gXu14e/TkkXronnJZVnoWW?=
 =?us-ascii?Q?65UVCdIogp6axhTqUt4NMZGZugoRXbRt/9sBJ+U+xNxA1UuH+yijub0rF2Ng?=
 =?us-ascii?Q?z2Gz6vVkmCacoRfRdeaxG73ZCEQgHaRZQ0TDnLta3TaHe/EMG4rjUc/aOX0q?=
 =?us-ascii?Q?Pzie0Met6T3dT8YZvjJwZoXFLZLo798sjoZjXqNJJPUJjVjcl654QeoES0yQ?=
 =?us-ascii?Q?6i4MXRmxu9ahS0k5+7EjlJZ1O0c1iEkuC/gVubNqXgPcmIsDjaBzbp4qOG2C?=
 =?us-ascii?Q?OK6PM9YaDnFwUqHKB0C7kD1MPmtz3DfTsEdfcgfLn0m4JW4FXUP3oL4XbUKK?=
 =?us-ascii?Q?oC0zOgjN290xa7IZbcQhym6KIseTr0CgrkthhN7pBPCSNWmmKKnUqjcoS9y9?=
 =?us-ascii?Q?JfpI1cFBRm/XmQF1Ff8+9mjdEUfnSLCJvCTSdBw/0OnY+pUtwSejMM/KdOJj?=
 =?us-ascii?Q?RF1ojOwu2tPq5Vu+0j3NpX65bd+OFq6tP31AyzTPY3O25xAnI2fCbY/x80we?=
 =?us-ascii?Q?ILitPLO//+G6YtQmgzZD8oZVVNnv3es0eTRZVrE8GSC1nzWXcY8ryX7Xe/QC?=
 =?us-ascii?Q?XybJBIilsAeck7VkdfRiF71R2S/wnvs8KImtnVS9R3vB7XsD4MZbuWJ6+2Et?=
 =?us-ascii?Q?i1E/PS/DkhXNNnTCGFcULwScxwrl2Fuko+tF++0Dq0dnsLT07m8RrAB+wdRh?=
 =?us-ascii?Q?9lGCoV5slGLDlWqnk5JiDCY3ybqhz/bzTl21+G1Z3s34UWtvc275/3fKxljI?=
 =?us-ascii?Q?HUYXOSnXieZNXXSzA7dv2I9g7+4eHlYLgx7/JtWLQBUaZm3DVzYLPiCN6uZa?=
 =?us-ascii?Q?mBJy+KfE2ApV/GLvbuU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 15:17:29.4074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8bd6c01-ce4c-400c-11d1-08de0a6b9ff1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7593

Hi Jakub,

Following up on this patch.
Any further comments or concerns?

Thanks,
Chris

