Return-Path: <netdev+bounces-248885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DEAD10996
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 05:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 41EDD3009D72
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 04:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F9430BBB8;
	Mon, 12 Jan 2026 04:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Di97A6SF"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013008.outbound.protection.outlook.com [40.107.201.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847382882CE;
	Mon, 12 Jan 2026 04:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768193546; cv=fail; b=Xdwe/lD67HAKArqAFGz0SGQ0/ebzERCxGgeBW3ujxlqEZOoK+tx9KPFZRtRyCbQAW3/k1boT7tU/kggXp6ZJNXOovARIq2cBohBJRKZzRjkEE3a4DKbuJ3LgU2EH8s1QZ5QkNGDDoCZbqDn24thTuuEazrtgQiT1XxOi4ecintM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768193546; c=relaxed/simple;
	bh=1eOeiojrU2Z+IDAYqAksgNMwi1kzutErgdVyVCoCUUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FfeorMrUNCpnRbxbzZG9QNAooCpbBTdvLO91KwCGIIboodhzJqRNqdalpRqOV6ugOvSmJ1uAdBLFTRF4tubppINCrOAd+VkGL6b+KJL+JCSHlI2mS70lJcIs1E3SdZT3YUY2EgiV05Virx4SpSmG1Z9sOZPIq7q1+/kUETsbN5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Di97A6SF; arc=fail smtp.client-ip=40.107.201.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KiNCjcHwtGqGupa87x3exqZHQUywEl4fNKxJv82JP/xvT+M6AEai19WyjNrKvQ8hEakH80iy2NEbN1x0/ONgHGzUL3tER4qy73yiL+b6RCYPH3Iz7ZxUYbUa3BRr+xzKni3njjPTwh6SmePcEYVNnhdV0+M1dyRHf1D/Kw3PfYA3XFtbDtrAZAsi0iLMq2gC72mqsA7XMdaZLTht8y+O/Oe8vuODA65GIMnlBh7X5X829djU7zLQ/H3bOgTfoHpxXgf49vwvncj8ist4kpqge07ixPNAfqaYF4xnxGR2rhRgBxfamNb5I0te1GQz7STdrK4xPSDLL2Louus+cg9f+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6QfaU7Euf9RD71DmVROWqCFWvxca0RuHsDAEHvEs8mI=;
 b=tjTbt+R6S6yyqrBi9KlZdAZqSKfhHyUmTwiWHbfPzpHprFRAJhuZZ2lzFZKW5HxDc54YAuzs1z6qYaRmPg1fD94EJh4blZHfo+HSbpxZnRywMV9IiHNlU+5xZnpWJ8BMVIfiW/U3MNK00DFD92yMhOvg0hLjqjiUhbyFmU5P13A2MZtiHXCIHCCnnm56+ODmGCuVIEeGaBiS9jfSM2QABEfRYsDZnabtv+RJVS5KPK/q6pRNWdnV76N/uyHIMUPGdApTAcN1I8J6ja6YrlHA7mTcHhfFwPR6CsYiDdK7HliUBKYpiWGhfTBHiniNCBObxs+KiiWOZgnqU5v/6i/2GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QfaU7Euf9RD71DmVROWqCFWvxca0RuHsDAEHvEs8mI=;
 b=Di97A6SFAWmTyHw9+TMtvGssUHm2wHCvuQ9gwRDaqBlzatR+YAuxQmGKmDU9ueaXaFpUqS1odvT9GYL9Nz6NDccHBYKw3/kGN5yvK10/S71eAvq4CfbmIrWoo/NuZvBI3NSGhvph8cOgQw9SJ7lW8EINbA1ktaUOyrwC73gNgeM=
Received: from DS7PR05CA0004.namprd05.prod.outlook.com (2603:10b6:5:3b9::9) by
 PH7PR10MB6274.namprd10.prod.outlook.com (2603:10b6:510:212::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Mon, 12 Jan
 2026 04:52:22 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:5:3b9:cafe::b6) by DS7PR05CA0004.outlook.office365.com
 (2603:10b6:5:3b9::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Mon,
 12 Jan 2026 04:52:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 04:52:20 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 22:48:29 -0600
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 22:48:29 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 11 Jan 2026 22:48:29 -0600
Received: from [10.24.69.13] (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60C4mNEW3950605;
	Sun, 11 Jan 2026 22:48:24 -0600
Message-ID: <dc81553b-3240-4414-8bb4-ad3aa806fa1d@ti.com>
Date: Mon, 12 Jan 2026 10:18:22 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH net-next 1/2] net: ti: icssg-prueth: Add
 Frame Preemption MAC Merge support
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, <horms@kernel.org>,
	<jacob.e.keller@intel.com>, <afd@ti.com>, <pmohan@couthit.com>,
	<basharath@couthit.com>, <vladimir.oltean@nxp.com>, <rogerq@kernel.org>,
	<danishanwar@ti.com>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <srk@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>
References: <20260107125111.2372254-1-m-malladi@ti.com>
 <20260107125111.2372254-2-m-malladi@ti.com>
 <ac64856a-d283-4f06-b334-f0bb5013a865@linux.dev>
Content-Language: en-US
From: Meghana Malladi <m-malladi@ti.com>
In-Reply-To: <ac64856a-d283-4f06-b334-f0bb5013a865@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|PH7PR10MB6274:EE_
X-MS-Office365-Filtering-Correlation-Id: 40980574-c45f-4f74-1b0e-08de51965e9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|34020700016|36860700013|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cnd4ZzhZZ3NlU0VTa0o1Rllwd3AvTFJ4VGtLT1N2Q2UxZ0Q1M1MwOXF0WnZM?=
 =?utf-8?B?SjU1eFh6WVpxZy9hSituNjF3akc1YU9udzBXY3ZTVEs1aXBlL0Z5TXlGNUZS?=
 =?utf-8?B?dFBnUEhmQUxLL2hXZk90ZlhYcVpFS2FGTnZ6L3ZFTVFVdCtFcTNscHV2MzRv?=
 =?utf-8?B?eXpjdjYvTXpCNFJrYklxZW1XTUJvQ2NXTFBscnNrZGtMMHlIenpyTURBVzdy?=
 =?utf-8?B?TXk2RElic285MWFNd09sZWhWNmMrWEJHQ1JnNW1yQ3FyclVYNW0xTGdESHUy?=
 =?utf-8?B?YVBlMEVDcHVlMEhXUmJXTVVudVJWOFhpQnp3UHlxRmhaWUtLSjN0UXh2RTNV?=
 =?utf-8?B?TDlaampzZDlMd1IxZFB1SWhtYmxIaHpWSG14WlJkQ2Vnd3JPSnBsUTY3V2h4?=
 =?utf-8?B?M2lNbXFLT1dHU2hWTVRaZldGT3FZVGtNWnRzQ3FlaXhiM0o1WWM2VzZqQkx0?=
 =?utf-8?B?QkJWVnhkRVJPellhUXBwTTdEMStJZHo1K0hZTFVoV1krNHFuSlQzQTU5U1cz?=
 =?utf-8?B?aXJtWFVacUxyNmVwUUxhZ2l2TU10SThmT2F5VG9taUlRT2g1bUYzaHpOK0VV?=
 =?utf-8?B?WmRmZWVPZHpXUHAvTlBUbW9PUmk1UUZ1WnRSQlBSK01EelR3R3g1dFhVMk50?=
 =?utf-8?B?WVlOVFcxNkMrakE3OTBXVWhRbU8zYU5Gd1V4YmZTMjdJWEdoWER4MjMrNmY5?=
 =?utf-8?B?RFRmWFhVWUFQdDFlOUQ1M2toNVpUdEtYV0R5eldQcVBLT2pMMEtFZVhUandu?=
 =?utf-8?B?NWtlTitTT3o3NkRHYzdKRU12VzlRSFRuWnVseVZjNHRad2FBa1hDUnE5OW90?=
 =?utf-8?B?S3VaUTdRRlZiMXFWZFNwenV1Q0xCNm9sZ3RGMHZQbnVMZ1FhZ3g1aXpmTmxt?=
 =?utf-8?B?T2ZEWVc4REFIbDBLd1EwVVJWMTdoTmQvQXNHYytrMG5GRmpXTFhrSllyV1dv?=
 =?utf-8?B?ZnRIeG10eEt6Z0NXVDZoWm9OanU5alZneHJ6eStvYmQyZmlDc1p2WTZFbC9N?=
 =?utf-8?B?UUhBS0lXemJVdG1Ha1Q2eHZIMHovU0s1NUtGZ3IrSExiTW1zdEV4cFlZYWFy?=
 =?utf-8?B?YU1WdHByNUc1WHM1dFdJejl3aVNZUWpoYjQya29hZThKRTB2a2lhOFZwd1Ba?=
 =?utf-8?B?aWtoSUFWV3c2aXgzbG5DUUZFNWVQUEVXalZXa3lDaFc3Vkc5YittNnFCRlkw?=
 =?utf-8?B?bVdOYWpwVkVURTR0NVhvQXFrbEpaUWtQL1YyNm9NQVdGSkxFNi9GdVZDY0pW?=
 =?utf-8?B?aGVtRExoVzZuZnROQmZDd2lFNVMreUNWWXkzWDBSRXhzUlJuUmVvbDFEdHg2?=
 =?utf-8?B?dmhzZTRkdEozNitCN29rYjlOL3RkWHlzTzNJNk9lQnlBQmdjcmV1YkNURmVj?=
 =?utf-8?B?U0ZtcW9Hb1BNL2dnN2N3aCt6cis3Q3BzVzVOSFVaSVVkYWtxR00yR2JFUXdV?=
 =?utf-8?B?a3docWJQcFM4VGVGZVk4NzA0ZG9rM3g4aVoxaHJJam56blFRYUxyQlJvUU1X?=
 =?utf-8?B?T3lkVzVadFd2WTYyUmlxTWtIeHdLa2pyOGdhZW1tTHpTSnpsMmdUSEI1VXV4?=
 =?utf-8?B?d05Fb0tXOURIUTlvSXl6bHloY1B1c3kxOUQzOTk5R1VNWXI0SVRUdUloaVF5?=
 =?utf-8?B?aWRvUEJDQUxadXJ1RjQ2QUhJZ3BLZkNZVk0wVENQTW5uTCt0RDVQYmhUbXlH?=
 =?utf-8?B?RXgrRmhIbXlOcGIrcjFGQ2pXV2tvMDA2bFRmV253T1dvcHp2Q3B6c0ZoNUxY?=
 =?utf-8?B?bGsvVVZFSGFDUmNHbCtUcWZJeVJFQ2M3cVZleHgvRXJUODVEU3I2TXQ3cUZM?=
 =?utf-8?B?c0JCT2hmbmVvTEZGamFEWE9sV3pWNzBpdG1JRzRFK1RPV2ZjWVg4NXN5STBT?=
 =?utf-8?B?SUp0UFRlNXV0ZFJ2WFgrbW1WTFl3eGxEeWs5VnZJU3JpWlJCV0VXOGVaaUZ0?=
 =?utf-8?B?alFqclNpMjJCeThKOXFPNHlOZDNkZm5na3JsT1Y2TTFrM1U3bjlLZjJhbGNT?=
 =?utf-8?B?MHViQ3hTSHlIMlRMcXFEcjNsUlZaQjZXcUN4N04zWFNndnc3NE5taVhYekk2?=
 =?utf-8?B?N2NjMktkQTZRNmNJRXFvWVBLVk5YYUZZR24vVXFpdWpDUko3aThxMVVXanZQ?=
 =?utf-8?Q?jAolzZN5DisOmVJzL/ieCC6U8?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(34020700016)(36860700013)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 04:52:20.5996
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40980574-c45f-4f74-1b0e-08de51965e9e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6274

Hi Vadim,

On 1/7/26 22:02, Vadim Fedorenko wrote:
> On 07/01/2026 12: 51, Meghana Malladi wrote: > This patch adds utility 
> functions to configure firmware to enable > IET FPE. The highest 
> priority queue is marked as Express queue and > lower priority queues as 
> pre-emptable, as the default
> ZjQcmQRYFpfptBannerStart
> This message was sent from outside of Texas Instruments.
> Do not click links or open attachments unless you recognize the source 
> of this email and know the content is safe.
> Report Suspicious
> <https://us-phishalarm-ewt.proofpoint.com/EWT/v1/G3vK! 
> urdgN3dP92274CXOvJKDvwNZ1ZfDoJYHZ2okAgDbtjDN3kmhmKUq71GAYLnzoFwx2mpfBIORw9Qoq3FoueFsPK2L6imycg$>
> ZjQcmQRYFpfptBannerEnd
> 
> On 07/01/2026 12:51, Meghana Malladi wrote:
>> This patch adds utility functions to configure firmware to enable
>> IET FPE. The highest priority queue is marked as Express queue and
>> lower priority queues as pre-emptable, as the default configuration
>> which will be overwritten by the mqprio tc mask passed by tc qdisc.
>> Driver optionally allow configure the Verify state machine in the
>> firmware to check remote peer capability. If remote fails to respond
>> to Verify command, then FPE is disabled by firmware and TX FPE active
>> status is disabled.
>> 
>> This also adds the necessary hooks to enable IET/FPE feature in ICSSG
>> driver. IET/FPE gets configured when Link is up and gets disabled when link
>> goes down or device is stopped.
>> 
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> Signed-off-by: Meghana Malladi <m-malladi@ti.com>
>> ---
>>   drivers/net/ethernet/ti/Makefile             |   2 +-
>>   drivers/net/ethernet/ti/icssg/icssg_prueth.c |   9 +
>>   drivers/net/ethernet/ti/icssg/icssg_prueth.h |   2 +
>>   drivers/net/ethernet/ti/icssg/icssg_qos.c    | 319 +++++++++++++++++++
>>   drivers/net/ethernet/ti/icssg/icssg_qos.h    |  48 +++
>>   5 files changed, 379 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.c
>>   create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.h
>> 
>> diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
>> index 93c0a4d0e33a..2f588663fdf0 100644
>> --- a/drivers/net/ethernet/ti/Makefile
>> +++ b/drivers/net/ethernet/ti/Makefile
>> @@ -35,7 +35,7 @@ ti-am65-cpsw-nuss-$(CONFIG_TI_K3_AM65_CPSW_SWITCHDEV) += am65-cpsw-switchdev.o
>>   obj-$(CONFIG_TI_K3_AM65_CPTS) += am65-cpts.o
>>   
>>   obj-$(CONFIG_TI_ICSSG_PRUETH) += icssg-prueth.o icssg.o
>> -icssg-prueth-y := icssg/icssg_prueth.o icssg/icssg_switchdev.o
>> +icssg-prueth-y := icssg/icssg_prueth.o icssg/icssg_switchdev.o icssg/icssg_qos.o
>>   
>>   obj-$(CONFIG_TI_ICSSG_PRUETH_SR1) += icssg-prueth-sr1.o icssg.o
>>   icssg-prueth-sr1-y := icssg/icssg_prueth_sr1.o
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> index f65041662173..668177eba3f8 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> @@ -378,6 +378,12 @@ static void emac_adjust_link(struct net_device *ndev)
>>   		} else {
>>   			icssg_set_port_state(emac, ICSSG_EMAC_PORT_DISABLE);
>>   		}
>> +
>> +		if (emac->link) {
>> +			icssg_qos_link_up(ndev);
>> +		} else {
>> +			icssg_qos_link_down(ndev);
>> +		}
> 
> I believe this chunk can be incorporated into if-statement right above
> 

Yeah sure. Will update this as part of v2. Thanks.

>>   	}
>>   
>>   	if (emac->link) {
> 
> [...]
> 


