Return-Path: <netdev+bounces-174010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F50A5D05D
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 21:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC6BB167473
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 20:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E8422F169;
	Tue, 11 Mar 2025 20:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HZhJ+DCS"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077421E833F;
	Tue, 11 Mar 2025 20:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741723562; cv=fail; b=axsOkLiB7WqF0H5e9+ZJoaEKmx5iSM1g7WFGrDrzcUgueJv+YQ3g2jrz6+YS7q8EZKqKFbu+YH3h4QYOKRjgvpG1qAYKwXPT63cEGrOBIuLD/k9jik1YJbGN0O+cQoOlbLpk+hy/OfSk3fOxK8gHT5bCb0hx31CYqfTCRJ1bczc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741723562; c=relaxed/simple;
	bh=uNiJLs2e2WhleQmz341CCVv5ZWxI35zb92cXsupnEho=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=N89W1vIb8ONqonOfrF9Zdj3aLDn5hvdtl8wn6b5RCz5swBmBaXjupxa7uP++4bMGkstNb0F58INZvVEH2KA3Ysh/djPI6ZbX3Sm+/cMp7N8uUcJatcoOZqX31M2MaQwJzyyO+CXXeAxNVdGOouFsRAHJPh67mIrWRiVLte13VuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HZhJ+DCS; arc=fail smtp.client-ip=40.107.94.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BG1SnJoRer5FSLT4YH4GpdaraIWB22SSqoEZGIuqn+WcwjpkUmaQ0yIcsYMaW9EDK5uq6Iax45l8Iz5mjToPrvZaO4uABIjFhY4MJqSKHJ4wM4BZYHK1w13diaT+FVbOd/za48qLJvZL9KThXq7gQrQfCMEEPxaVVfvmxXNi+WuxhqToc7oPG4GGg6pdJx6cdkGimn6ajE1ZCSUsQCNY0aZJRxY9G+9FqZfwT6eCDEisec+i4mb4F7go4ab9nWkbfP8eQIEbROwmeyUlWPeiFzEdW7XAqybcK8ATBJcMiHNYrKUW+MOvzEzGMeqwN7yBJ3CenHnNiZ8TjoS3zaeyKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZipSNl+ceJMalbvj7jvcB0Cs0vfItjnFNM6BLHen1k=;
 b=kzkUUBjnimhMOxdhH02RkcHNRyYZI4+Nr0hHPpIpKd6HvJhZZW1EyvGId4oJQsDFcfGaWBHzQulEMOMB+WCX9YOCbyV0LGqfLaodSYkda5DtIueGiiuZ7Cs0Aoa/MF6meTfS3TrpuUIVpcDo6xOCygUfiKgDkj4CvIun0Y6CqLIdAFNAxNgshd1lplXwzgPFYt97UYimT3YnMAAUfMz2QQnIgOx6uxF3U8hZgfw4wX+LKpbAo3c96takwUZWN+heVK30jFGp2DYROzmuv9Q4Q5Xy9mLIJ9ql/DHk2MnqqubgT/yF+CyLQ0lxyxti+iwaxMY+laO24GvxoZf/CydwHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZipSNl+ceJMalbvj7jvcB0Cs0vfItjnFNM6BLHen1k=;
 b=HZhJ+DCSX144/PX17TAdQdqdtm+oNxz/OIEhKYq2128lHKahS4w5UZb46c78ncexHSIFFDaDewg+Xu2tWDCcr2qeolhO6FaxWQmFzG6x/9LOOXwyLpgyZSQwaQDRvDIZsCrJ5bfAt3Llan890KGbMjY3TgAe9nD72g1ckaYepaE=
Received: from MN0P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::12)
 by IA0PR12MB9045.namprd12.prod.outlook.com (2603:10b6:208:406::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 20:05:56 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:52e:cafe::f4) by MN0P220CA0022.outlook.office365.com
 (2603:10b6:208:52e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.21 via Frontend Transport; Tue,
 11 Mar 2025 20:05:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 20:05:56 +0000
Received: from [10.236.184.9] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Mar
 2025 15:05:53 -0500
Message-ID: <9a0901ce-8583-47d9-bdc6-a471d2e9be71@amd.com>
Date: Tue, 11 Mar 2025 15:05:47 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ben Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v11 07/23] cxl: support dpa initialization without a
 mailbox
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, <benjamin.cheatham@amd.com>
References: <20250310210340.3234884-1-alejandro.lucero-palau@amd.com>
 <20250310210340.3234884-8-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20250310210340.3234884-8-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|IA0PR12MB9045:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ff11780-5024-4d63-bf58-08dd60d8229f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TEFOckpHRlp2UVhMYWtnNjJ4bldtQ1oxd3Q2Z1J4R1dpRUNXOStrUnQ3Yk9o?=
 =?utf-8?B?OVJpZlp1dThtVHJDK0hLU1RSd1hHdWVuVkx5RHdORFc2WUdpTEZ3aUhTYXNJ?=
 =?utf-8?B?N2prOEZxckladG0zOVN2K3JxVkl3dG1vQjB1Wjc0TzI5ZVhLSGVmOWF4Q3Rv?=
 =?utf-8?B?ZjIvNFppa2JvZnBaVVdLRkxvMksrbjE5TXh3N1JSM0JZUVVaVHRtVFVqNzY4?=
 =?utf-8?B?NmZiWUhOYW1Bb093TzYwRWlIdE9mYkF0Yi9EV1dHVzJUOTAxeFVHSFRjQmM4?=
 =?utf-8?B?ZlI4QzVjL2VKM2RZRkFocklIbk8rRHBoVXdETXJ3YXl4OENVZlZqdDFtRHRo?=
 =?utf-8?B?elU5QjFsa2EyQk1ld2d3NzBQekZ5Nnpxc2tudGsrZ2didit0RjJZUjcybHd1?=
 =?utf-8?B?enN2R0FFU2Y4bXQ3T242bWxnc0VWU2d3QVNPc045NWFqYWc3YlVxaXNjdS9G?=
 =?utf-8?B?MUJoRXBWWkc5RzYzQ3NmNWJPR3JucERHaFpUUzY3M2p5OE1tYS9wbEwxMlJt?=
 =?utf-8?B?b3NidldHOXZBWGx3OU9tVno0YXRiNEtxbDM0K05vcmZwbzQxbFh5bWlCS2lG?=
 =?utf-8?B?WG5nWW5td0NsekREOWwrVjcvNXI5djBYRnRld1llVkkzVTdGRm50b2xlMWNn?=
 =?utf-8?B?ZVRnK2MzeUJIL3N2cDdiN0tWOHdRZ1dlQ3FFQmE3VjRmSmFPL0dsR0k3anpx?=
 =?utf-8?B?MStJU1dicnpCbUUwMGdnS1YyRWxWVGxhZmNxdUQvcTlGRndDVkVNaFJJaHEw?=
 =?utf-8?B?b2U0NS93VVc2aHh4V0VVOHVVVStCM1pIallqN2lPNGxHRHJXUE9SYSsxQzVu?=
 =?utf-8?B?cFJLSW82N1V0SjdaSCtSRTgzRk04SzFYRjVDQWpUYlRzbC9xYzh5UDNUODA4?=
 =?utf-8?B?dlBkZkJkRzN2R2RXc0poNVVJSEVrSFdJay9Ib1B4N3ZpRkdkSFpGRFZRdFpV?=
 =?utf-8?B?M0d5elNPd1RKMWVzK3U3OURlczZheGhkYitVcDVTSjA4Zlo5VmQ1YS8xbjhs?=
 =?utf-8?B?QXlHRlA1azE0WTNqMzV6WWtQRWRiWGhDRWp0cFBTaFJ6QUhocC82aVhzOTk4?=
 =?utf-8?B?OHh1TmdKYmZvcHJQMWc1SnVjWXZ3R2JlYng0cU9od0JibnpTRklWOCtqMVlv?=
 =?utf-8?B?eFR3alBzSjJia2ZPRFE1SHNFZHpqV1F1bjJZZklBa3RUc3RDWFVqUGhNUGZ1?=
 =?utf-8?B?S0kvMG9WQmVvMkZ5dTRCSE5SQ3pqZHJRQWR3OHdLWnFjRTZCdkRpK081UDVr?=
 =?utf-8?B?OVFaQ3NwQXhwQ0d6bXlKNDVRcXhpelV2L3pZZGovOWx2RWV6alRJWVpPU2VZ?=
 =?utf-8?B?bFl2ZmxvTE9iQ0psUVBwL01BTjVNRmxwcW15VWFKaVF3OVZKRGl6TTBCV1Az?=
 =?utf-8?B?NUQ5VElid2hxVjB4NVV3QUUvdkRqZkdZalZVMm1PamRZQ0EzNVBWL2QvcnFx?=
 =?utf-8?B?RHpreHNkenM1aHR1MnhRaEFhY2w3MmFySThsakFRV05qYTU1cmE5ZkhRelFE?=
 =?utf-8?B?OWlOYjlXUm96cHFKWWhteWRWM2lGYktVQ0NnOTFxYk14SlV4dS94b1l4V3gy?=
 =?utf-8?B?azB1SGVIdW0za25Ra3FrZzd2THBINzJqRHFYVVd1c2VQRWxaaTgyb1J5NG96?=
 =?utf-8?B?enlIMWtkMmdHUktIK2E4aU9KVVpGeFZMK2F6R2FLL3NqZ2JWK0d0OTRpZXpU?=
 =?utf-8?B?NHNVbEMwN29tN0JYMGJ4UGprVm15KzA4MEFTRWk3eVBwS3Jnc2RPTGNHN3Jz?=
 =?utf-8?B?b0V3ZEM5MGphT01xZHlueXBxY2dLbkt0ZE1KeS94cXVIZTNVd2N4UmdWSXNB?=
 =?utf-8?B?ZUxIZk9CTGdUUTBHWVUwSGx0WG1uMUpWaDVQRFN5cDVZd3lzNkcrSTF4czU2?=
 =?utf-8?B?dGI1TDZxdTBYWkZLMmxiRXFQeTl6RFRCQktjVmRRZnd1cGg1dTc5anljR2Z5?=
 =?utf-8?B?M1Bhakp1SXIvM0ZEbDBnUVNaWnNyb01KRDFmQTZTWVFoeFkyd2dEK2JVMmNT?=
 =?utf-8?Q?2DHCjn6XJ8J5RLT5VPHR6y8pg1bCK4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 20:05:56.6106
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff11780-5024-4d63-bf58-08dd60d8229f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9045

On 3/10/25 4:03 PM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Type3 relies on mailbox CXL_MBOX_OP_IDENTIFY command for initializing
> memdev state params which end up being used for dma initialization.
> 
> Allow a Type2 driver to initialize dpa simply by giving the size of its
> volatile and/or non-volatile hardware partitions.
> 
> Export cxl_dpa_setup as well for initializing those added dpa partitions
> with the proper resources.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---

Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

