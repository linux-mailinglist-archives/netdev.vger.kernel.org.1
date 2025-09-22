Return-Path: <netdev+bounces-225389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E97C7B9358B
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 23:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BDD33B305C
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 21:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF95D288C0E;
	Mon, 22 Sep 2025 21:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NGshFxHD"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010015.outbound.protection.outlook.com [52.101.193.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7AF261B78;
	Mon, 22 Sep 2025 21:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758575406; cv=fail; b=olzxeO/G5aexOKRZGnz1Y4Ax6uAZ5da2MZYhEzurkHYJqEQTsdtyEUtfdvDRUyCmyWN/6B80z+keq3gzmL5yG0stEcJLyFoXe/fjpfrvdZUVBc0kuaZnmoFl3KF1jZuXfjVp7PTUdGwv1loCjYaJwZ+iIdsDqzPDNe3vBrG3wbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758575406; c=relaxed/simple;
	bh=qjdzxqhEam/FL5nVEV36R3/DdWrllkTuCh5Ux56KORs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=gIUwLFrB00S4YHAamr1D7JrXWbb23EI5nRucJN5vepMTKcrgrlZv5WchvMoYldyf/bORuyl/NVxVxdwoOQt9i1uTGdYEbPYogypBwWqFLF8/k4Dj6AQ3UWOZGStyxOYLRWUSKvwpk9okEz6/LR4QP7Q60LSHCFwnzX6uB4OPvcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NGshFxHD; arc=fail smtp.client-ip=52.101.193.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cm+nq1J6MeXymfme3rzC1bX3Sl5PG9q6ZNDc2GVkv+d60zF5WaOVwYUNBI8ihGZaiWPw1kOG04uQNi6zWxOuT9dTqhBsERYj7uWpI9qQa5WawLK92sQ3FR+phuo4vc48NT1JmQbSJc9HEUD24D+azlanmcppBvoJFo/3nWLieC5/kA48IwKyY/p5GRqkECLUoE5TGEvlv20RBp1OZqjnGECyVUHmoajJpT4nynFMenBqOEIH2SH9jyvE8JzLg/j8QSP3j4C0EMSm1VAaLmYu0f1HA3vshKdY/WGtZd2bPm9XIMkEYY2hc6CcnJSZ+/G9QKzO84rAK/bn+2h6+37fwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DmeFJnqzXSnGHgmjkQKvfjEHM6rHuxS24rbfCKKZYkg=;
 b=Qx07OjqKPcIlYo4YjfO23G5DkykHoeWG4WIQIpCHxu/6FuEq+lvT/xwNqbUfDMOQPcPRHfQcht8NzhG7ihLCB5htUuG2VAI+IMyVtD+mmn2+CJzJoAdGZmBKHRxFJa0ESwA9/ZNEG0FUQISvgb/YIdnY5Sh6akbna9TrYm2r6Tz0MpQSoC0MSBJOqhp3vjULA5M4YMn2vbrGxZJdvxdYbpHtiQIAH84+LRku8trHhdoLlx096lJXHsOWEx1en2MPjf24La2nQ+hYDhDQHeHZHkAdeLsb0g/o3fZ6bILXzEaMYu+ehJPYv7x/jjyCWcqgSjopLGvzy1yqXXCOtgo2Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DmeFJnqzXSnGHgmjkQKvfjEHM6rHuxS24rbfCKKZYkg=;
 b=NGshFxHD6fIpIOOM3e55fZite5jR1F2jgwS1HnBJLbVFlw13H0NA2XLK0XDi05eT7LIr7sUKOueOCHi//ECL0gHDZClmd3QmDLisDOBGs24P6qKUk1zAiXF/VU/yAnQeRPbwx/RgbT+AwEmIXJxvdoRgLYNDLwi58dEeGDsF0kQ=
Received: from DM6PR08CA0006.namprd08.prod.outlook.com (2603:10b6:5:80::19) by
 DM4PR12MB6277.namprd12.prod.outlook.com (2603:10b6:8:a5::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.19; Mon, 22 Sep 2025 21:09:58 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:80:cafe::1f) by DM6PR08CA0006.outlook.office365.com
 (2603:10b6:5:80::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Mon,
 22 Sep 2025 21:09:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 22 Sep 2025 21:09:56 +0000
Received: from [172.31.131.67] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 22 Sep
 2025 14:09:54 -0700
Message-ID: <f1dad4ba-362c-4ea6-ae91-51b278256f04@amd.com>
Date: Mon, 22 Sep 2025 16:09:53 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v18 17/20] cxl: Avoid dax creation for accelerators
To: <alejandro.lucero-palau@amd.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Davidlohr Bueso <daves@stgolabs.net>,
	<linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
 <20250918091746.2034285-18-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20250918091746.2034285-18-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|DM4PR12MB6277:EE_
X-MS-Office365-Filtering-Correlation-Id: ad03c79d-e6c4-42dc-01ee-08ddfa1c61e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RER4S3ByY2hXTkYvRVpnZkR5R0pBT0duSmkzYlBEQjRKTVYrYUhaZlpSY1lK?=
 =?utf-8?B?dzJHRldMUURha2FWWnkrNitLTnVNbCtycU84RUxwelJoOGsxdU9PbnIrL2pH?=
 =?utf-8?B?SzFPTFlMVlFPUlJnZmdlVEhrV0NHRUlwQzJBSXM2RWxzdUZMMThVTVVpM1hh?=
 =?utf-8?B?RU9HbXNra3YvS21OaFB2NUtjM0pXK3ZTcHppYndmWWxDaUpmUVM5SS9RbzhF?=
 =?utf-8?B?MUdSUVROYUFHU3dvS1NFRk5HOGNXOUQzMVJ3TDlVTXJqNVNpM3JuYlhWNDZv?=
 =?utf-8?B?VkJPdkZYdjdIVTRwTGhpa0thaWpMWUVTTFpuSDBDaExvQUNSNlhhanB2eUVG?=
 =?utf-8?B?Zjc5TzluczI4R0VEaEZWS3ByUHI3YjE0N0x2QTZYZ1kyWUJaUGRrQXdBM3pQ?=
 =?utf-8?B?WXUxQU44NnRFTDBGbmdyck9FS1BtYVMzNThreFAvRjRmQkd5R29abFZvRzBD?=
 =?utf-8?B?dkVuQ0E0ZU5oRTNhZ21oRktsaWFUOHVvdXJPTzMySTNwbVVNM0NEbWtZVTNq?=
 =?utf-8?B?R0FvR1V5ODZWVGNDMVlzbWJXSTRPUnlYeHVQL1R3Q0t4MVduMmpYME16eVZv?=
 =?utf-8?B?aExXQ2dRU1FOQUJQQUtQS1A4NExlbHErK1hGaHl5amdrSXo0SzBtUTRqSDM5?=
 =?utf-8?B?VE8rUkIvWjVYYU5JYTRLRCttZ3ZnRHRZRDZUbFRTMVl2aXRYd2ZzbkdHZjA1?=
 =?utf-8?B?bk5yM0VDTWdUM1k4VWpuMEJHbTFTQ2FlMFlzaWFBNVdMNU9FUFlCeTkvREZn?=
 =?utf-8?B?Z3hXdXdRL1JMNXRhMlkySXVmRkVVSVgwT1JWTDZJVndWTk9HREI0eWhKOW9k?=
 =?utf-8?B?V0NIYVFacXE2RFExNTY2YWxzaUxRMkxFdDVUc3YyUWdkNWh1eDRudUJTc2lB?=
 =?utf-8?B?dXNzdkc1ZVFxVC9KVEVJczRwSHg5djc4dzVuMlhYQ1BEa2JqN0xMdWVZQVZo?=
 =?utf-8?B?R3YwZ201OHJ4RzliSjBjd29wZHROUjBYc29rYnErVWgxaXNjMnVqLzRidFA4?=
 =?utf-8?B?ZFRYYW5SMUlVSTRmRVZ1L3RNRXRBVytocldFRWppS29oVlk4bmJKRVZ5U2VS?=
 =?utf-8?B?dDBscVp4dHJoVURkYjZGckFHYnZrWTNiS1d0U3ZkNlBDRmRCOHlXZ01kSUNq?=
 =?utf-8?B?YU1vMjhlU2R5TWNYK2N4eldycjROTlJQcTBoZ1JwUXpFUzBhemFPeFM4UlF4?=
 =?utf-8?B?OWZyM3g0cTJMaGVPcjhjbitsalVTeUhnaU0wYWNhZVZ6TWhXVDhBbzBtS0hL?=
 =?utf-8?B?cGJVcTNJYzVQa2dlUU55dGNlWXh4UUoxd2ltUzgxQTJiT1pTRDU1cUd4WDJF?=
 =?utf-8?B?TzBmY3Ayb081ZVJLWmI2VnQ0MDFVeGlLT3hZcms5Z0N2QXprOEVzL2NrTEJ6?=
 =?utf-8?B?Q2hGWGlReHdGdjYwTGU1R3lFQlU3eGowaEs4bjI0ak53aDBORzdibFZJVkNM?=
 =?utf-8?B?dGM2TDR3S0hzZC9tSDdLWGdBc29ndTJFVGkwRThkTnlmUHd1MVp3QlNBa0VG?=
 =?utf-8?B?cGhjem0yU3lSV0Z6Yi8xUUY4TmR3Y1R4N0lsK3NOUmhUTFRTbVU4cVcxYWEz?=
 =?utf-8?B?RXdpNklkZEZ5dkh4bzJ1R0RPcSsrN0xsV2VWZkJBVHE1di9iaENxMXBUd3R0?=
 =?utf-8?B?Z0FYT3k4aTFUZFZQUzZaNFFaMFR0ZjNSZG5uNFZEbXg3em5ZejRsczNzRWR0?=
 =?utf-8?B?dXI1Qy9vVDJwOU1rQkVmVHlNYzU5eWNXSEoxNTlOcFVEMXpVN0g0UG1JS3hT?=
 =?utf-8?B?KzNFVUJXODNzelQxSzd4UEJvTHp4SWNMRDBKTWRtRTl2aWxCTGZpOFFQcGNr?=
 =?utf-8?B?Y1EvN00ycVdHSndJeTVSWi9FN0pRaFg5YUZoaVRJdzdWd1FKTHJTSDBtSG9Y?=
 =?utf-8?B?TE1LY1poZEtPckV6bG1NajF6cFpJNlBOd1NGN1MwN2FOaDVmblJCNkNmaHBi?=
 =?utf-8?B?bStkUkFkcWJxbkVPYW9pNEI5N2tPL0IzMzhsYkFraHFMUVlQdEUrUTNHa2xn?=
 =?utf-8?B?OG5hRVpoQVlreEZGc0poNkN2UXVTTmtwZDh3b0J2cE5SczR5b0kzVXRPTlhV?=
 =?utf-8?Q?dXO6Ej?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 21:09:56.3870
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad03c79d-e6c4-42dc-01ee-08ddfa1c61e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6277

On 9/18/2025 4:17 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> By definition a type2 cxl device will use the host managed memory for
> specific functionality, therefore it should not be available to other
> uses.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Davidlohr Bueso <daves@stgolabs.net>
> ---

Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

