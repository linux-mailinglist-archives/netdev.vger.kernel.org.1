Return-Path: <netdev+bounces-186416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 493ADA9F058
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 14:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 502BF3AC916
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 12:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B272686AD;
	Mon, 28 Apr 2025 12:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Lka9t3KI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699712686AA
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 12:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745842293; cv=fail; b=AenwWnSZG+X0UMRERW+Tshks5RlNTmZQuVNszd8ktLWA5bwAz/HtOhVMaT4ZA3Qf/RxSt+lNAjUdjTPdEhOucmvGrY6IrRTW30MvyTaRkAVUgWOgaWMIps+HL3DWQGzwFkxmDxI+GfPLVsXkEf67lLJD7Fj4JQnu8K7bQaL4KAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745842293; c=relaxed/simple;
	bh=PaKaEM/HFzqflODvMfru5gFsyVv65WWLcUnJfthIDzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Z4gi+7qgabmc8eHvafx8Hw2jFFxc1qTmrYMxxtfayS8ckLD6PA3g9oD3Upgfe9ieb+wzGRFQhXAEC49tA8UKxqerahKhGjq+XGge9Pd26ridRHToxq9oORZ6sFjxDHW5Z9CNtLaXOwtjWv44c9AZhX1hbocxll8mdMI7WaCkcA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Lka9t3KI; arc=fail smtp.client-ip=40.107.94.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fc76Fuf6N/5H9vuYbvEpcemhn7E874urLcdluQSfsTKjdLJh9kAOuhwrJju4+NC3tJi/ojNjwow3Z5QdysoySlykzBJ9eBMnPjzKEuppeKzaiezVT5hFgdqdCAqVEzXl/ANGLgBPauaSwtBDUHBIYxAsI8XNYkRMpYsLx+oFhQ+koOFp1ahJ/2+xAlKJELesSrkW86zrSpJ/b3y6+nMR0eTGc3XdQuNWBuBND0JuDaSyyORFLN0tBgaphQW8XkykoTiCn+QohxWstxotQ8IgY5CC9j9IV4j6B+1BN7t2WOyHEba3vFZTrlDMQI+34ZiCh5r19XXuGpg2FUkmPu6QXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UnUt25q6TJt3YgvaLeXR9oLKFAJ54SNmYxCvyUPaT8c=;
 b=KRueAvPww+4KopMzjc/+va8R/e/ItWCXqzRRBvj+O1GHfKVFGLwC90Wn/xXfVj/yzWgGfWEsI64K564Vcnv/y8JteEEllpMCNgHrktv14i39fxxEKDLeIEZ6ZSvsyCQm+0e5Gs6AHd+2uAe5FJQvKNczIEMVr30uGz0P76ovB57SJAsP3no+pZ1S5GhgHkBdnAQyJqDdWioVd8C7bxqHxxJfMmhK1QZCfyK2qMdjW++SGZqSutLqdme9SHfn4j8877e9SaeYldNOinrje7rwAcDVJondHoSSYDyCkOpo/oh8+QiRqU0A+fpGYeoCcKAe65cWTXw371LHU+yDGkutWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnUt25q6TJt3YgvaLeXR9oLKFAJ54SNmYxCvyUPaT8c=;
 b=Lka9t3KIg3od1vsgsKLAAKKCmKn9vuoC2F9Lr0vBZxyNlubkmkzq//P218QKQiy4ZXXPQrZPOPiVieJf6o0DUoANjRRLXe0a5SA9KOJxAVg+Y5jZKvwvk4UkKZwzQvj8gY1eMp7WPB22EXRJhxBsi175PUwh/LDfIIqYJVCqHKU4+NWaXv/VRufscu1ulx9pWNV4skE4Te1YKGJjpiq38syGEx3EkY137DTEaljqSTWyC4JGwhKR5TiFAma3kor7p9IGNrHIvvBglsvL/PxAKgKOA25A98vZZ4PwuN+vwYpg+Tex7F2vQUdjkeFZXwddoPYJM/Dhh0+3yRZbdKDMKA==
Received: from PH7P220CA0048.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::19)
 by CH3PR12MB9454.namprd12.prod.outlook.com (2603:10b6:610:1c7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 12:11:26 +0000
Received: from SJ1PEPF000026C3.namprd04.prod.outlook.com
 (2603:10b6:510:32b:cafe::34) by PH7P220CA0048.outlook.office365.com
 (2603:10b6:510:32b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.41 via Frontend Transport; Mon,
 28 Apr 2025 12:11:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000026C3.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 12:11:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 28 Apr
 2025 05:11:11 -0700
Received: from [172.27.33.64] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 28 Apr
 2025 05:11:07 -0700
Message-ID: <95888476-26e8-425b-b6ae-c2576125f484@nvidia.com>
Date: Mon, 28 Apr 2025 15:11:04 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 0/5] devlink: Add unique identifier to devlink port
 function
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko
	<jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>
References: <1745416242-1162653-1-git-send-email-moshe@nvidia.com>
 <20250424162425.1c0b46d1@kernel.org>
Content-Language: en-US
From: Moshe Shemesh <moshe@nvidia.com>
In-Reply-To: <20250424162425.1c0b46d1@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C3:EE_|CH3PR12MB9454:EE_
X-MS-Office365-Filtering-Correlation-Id: dad240b8-efbe-40c5-426d-08dd864dccbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YVRqVXRkTHROblh4MExFMGp1WXB6b2plcEpsUVIzbTdTdUY0b21Gb3UyVzNL?=
 =?utf-8?B?eUlwNmdOWmhVZ0UzaFRST1VEMnhiRHZGenhvRUFORkw5eTFuNTVHMmN2TXZB?=
 =?utf-8?B?dSsxUUNkczFuMXlGSHhRUE5Pdm5Xa21LQlNHdzVHSzF5OWtpRGJicm41My9C?=
 =?utf-8?B?TVR6T1NBOUVCTHhVUzZoMFFZTklCMVcxdVdxdzNlUGdDZ3RESkc1SUFhVFlW?=
 =?utf-8?B?MWp6U3pzNktoL3V5ckdydWlyZHJUVWFpVGQvTnV4T3RsbHRYQmpLdE9WOTZP?=
 =?utf-8?B?eWhkaW9nZ3VpVTd2dDBzaU9xSTYzVkJ1eHJtaUwwMGpIcmIrQ0VSWU50Q0Mz?=
 =?utf-8?B?NTF0TjZ3QkREcWFKVmJxeFhiVDh5SDRlbnkyZ1hibVFmdXdTclgyVU1JQm5k?=
 =?utf-8?B?UEhuVjhqVXpDWm44Ymt6MWpiNldLRjRVbmZKdHhvNWFQZVdqVmlEMW5FeUhh?=
 =?utf-8?B?WWwzaGxzSnRsMXp6RFdRcjIzRXU2NjFQTmxrZktmanhOWjcrZGt4WXhxQUdZ?=
 =?utf-8?B?amh5ZytUZXY5bU1TWkdsbFJCS2g0YTRFNng3bkd3RERJTEhNOCtGUmlydzNr?=
 =?utf-8?B?ZDRLL0VhbkpYUnhROFR4cmVlZi9GM0NTMUowVWxUMk83WThwblBiN05HVUQ5?=
 =?utf-8?B?akh2Ukg3c3IrS2xuN0FqL0Z4RXQvS1lwWWlnNk9ZRlV1dTF0Vys5bkhqTUZq?=
 =?utf-8?B?cFV4MUhOR3ZzSUlpWlNITGdkNzVoSzFJOTMwUjJKWjNTWHdEbVlWMmZmWm1K?=
 =?utf-8?B?N0ZFRWJDZVc5NThKL0JBTWhkRGZVNndydkhLRFE1TkJ5WnZYSmhoN1lEY0hh?=
 =?utf-8?B?MmlFZ005NTg1SUp6ZUdGN0VOekRoSWxuVkNEMW5nZGFGNHZ6bDBzUWN4WDFz?=
 =?utf-8?B?a2E0dkFycE5Gc3NZMkNya1QzZGNOc3l5dlVtcGhMZHBrcmhHYVVGRjZPcWFI?=
 =?utf-8?B?K1NsMVErbDlxUXRtaVhTSUxSMEtVTU1EYTVxdG1MMzh0cURLRWc5UDBOcnJJ?=
 =?utf-8?B?ZUVXbFRTWUMxTTZSam9vVHRkVXNXdVF4Tkl2MEJUOWYxa1pieTkyTzBkUk5M?=
 =?utf-8?B?OVFpNm5oQnliKzQvWmk0S2IyQnpoYnVucUxob0tURXBFK1NqMVhUQktLN3VK?=
 =?utf-8?B?QnNlckowWlJSaG1YdEdkc0tzQ0c4dEVLNTdPY0Exc3l3QkhndUR1anhJVCtl?=
 =?utf-8?B?aW1GbmtUdTVWODNPZ1BQQUVwV3B0cjZHVENPdjQ4Y2dveGNpK2QxaFl4clVk?=
 =?utf-8?B?SFFuQ3RjVVhReVVRUHNFL1VZd0NOYnM1azFLTS94c3l1ZnRtMGpMQlFCZjcr?=
 =?utf-8?B?Zk1UelI3YWR1L0tSMFdpRytCaHdkUWxzeno0SDUvQzJGM1d2RWNRSWJrcVN3?=
 =?utf-8?B?cXltZ1IyRXRYZk9MOStlQlFubC8wVmRKUEVJaEdrcnhTR1RncEp6Mlc0WVlV?=
 =?utf-8?B?ZEEwOTZpSjZTRjJxU2I5bExWeDRZWmpUeFFtYUJKMlRhbC83STIzUTU2VFky?=
 =?utf-8?B?YkVqS2FKbnNDQ0RuUWtQdzg3T1BwVzYxa1pPMmM4RGg5RS9LWFlZbVdTRzFj?=
 =?utf-8?B?czJhd3lvU3J5L2RVRXF6dGk3YzlINGJscXpTR3NnVmxjaDYwVkp5OFhXWXNK?=
 =?utf-8?B?REFaYWxHQVB2ZzdnaWNVczY2VWlteFU0YldvK0VOL05YMlo2b0xSUWlJTENj?=
 =?utf-8?B?T3Y1YW83ZzlZQnEwMi9oeXZMMUNFZmFPQlptSXRXQUx0VURsTHNYZk1adVRp?=
 =?utf-8?B?bTBEOXFOSkZWTThFcEZTd3BINVR1MVZUR1FvckdzVDlZU3FLejlob1VBbnNH?=
 =?utf-8?B?Y3gzVDRxdStSYnEzQzJsems3U1VqMGg1Sk5zd1o0cDVIT2w4UGJOU2FwdWFl?=
 =?utf-8?B?by8wUTBHc1h3cEllZkxiTXJQVnl6NXp1dmhYMnhOWi9wdmU1cnBJcWlST3RK?=
 =?utf-8?B?OWZ2WEVEZjFDWkJmMUNCR2VLODNGbkVtdUh1WkxDT2ZRS3B5RlFxcEs1aWlF?=
 =?utf-8?B?bEs5bjl2RkVvT1lYUlh6WjgyK3NXbjBQZm9nMXZBWXh5Z2NoYmpzand6bzAr?=
 =?utf-8?Q?Ye4GNN?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 12:11:26.1351
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dad240b8-efbe-40c5-426d-08dd864dccbc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9454



On 4/25/2025 2:24 AM, Jakub Kicinski wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Wed, 23 Apr 2025 16:50:37 +0300 Moshe Shemesh wrote:
>> A function unique identifier (UID) is a vendor defined string of
>> arbitrary length that universally identifies a function. The function
>> UID can be reported by device drivers via devlink dev info command.
>>
>> This patch set adds UID attribute to devlink port function that reports
>> the UID of the function that pertains to the devlink port. Code is also
>> added to mlx5 as the first user to implement this attribute.
>>
>> The main purpose of adding this attribute is to allow users to
>> unambiguously map between a function and the devlink port that manages
>> it, which might be on another host.
>>
>> For example, one can retrieve the UID of a function using the "devlink
>> dev info" command and then search for the same UID in the output of
>> "devlink port show" command.
>>
>> The "devlink dev info" support for UID of a function is added by a
>> separate patchset [1]. This patchset is submitted as an RFC to
>> illustrate the other side of the solution.
>>
>> Other existing identifiers such as serial_number or board.serial_number
>> are not good enough as they don't guarantee uniqueness per function. For
>> example, in a multi-host NIC all PFs report the same value.
> 
> Makes sense, tho, could you please use UUID?
> Let's use industry standards when possible, not "arbitrary strings".

UUID is limited, like it has to be 128 bits, while here it is variable 
length up to the vendor.
We would like to keep it flexible per vendor. If vendor wants to use 
UUID here, it will work too.


