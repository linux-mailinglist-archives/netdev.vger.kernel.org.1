Return-Path: <netdev+bounces-137045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3937D9A41D4
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 16:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F9741F258DA
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 14:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A948718872C;
	Fri, 18 Oct 2024 14:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U6dJxwgC"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2074.outbound.protection.outlook.com [40.107.212.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAD71F429B;
	Fri, 18 Oct 2024 14:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729263532; cv=fail; b=TGTTK0IrPY3C6cJPx24AjIN+6igV32k3fYJPXjhCJMIHuMXE/hC/S1ESL3qt/SH0XoPgF8MC9LPTeqmSjuAOYo78qG8emjIxwEdMNcaaNTUzZBg2qhDpOCmHTaBMeC9Y4BfLBahSv/qJQgWba0lmuOnbPyrpSuI6w15c/uTqoic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729263532; c=relaxed/simple;
	bh=ZS645YiXVjDEVEpc50abrQhhOLeIIsaivJJQQ26Unlc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IYsZTVd2LWKwsOvfFFb4fOrU2hmaOcoNbw+ZrkS+l/nHiWBLRFExjmxXNNHW6iz3TOPySBUXseR2yLJnbS2P7t39Y+ScRw/GRb47jdtJPTlVY3Ii3rmgKHSScsjJl95KYT5swpOfdeo7HTDm9h9632xsAChhGq5gFhC8/17JJN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=U6dJxwgC; arc=fail smtp.client-ip=40.107.212.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=skrwYa/2liFWKxMuvE0rdGhaulRA1B3vKHNEg99MN0CCJYMaZwQg1tteA0+nCAhX+u/qDGLl8EbwC9NrWJjdf+o9DLCckAA3YT/PL3BzLdACQFjo3tr35kfVNbSCmQBBx2T0Tj4nUxTXzHnl7LuyDvhx5F5Ve8YMWQHuj0aZT1C4H2inkX+z/9nijOFLv0qXrsYycfoh+JMpJfatmJTeAI1O94HxrlmndhGqycNgjYNExfivHyqr3oTzlLj30hBJmdLjb9WzmWFqWz+9gDrWU3lVA2LJQUOvxpIbnCVxTIIECGnHGz+QM+orwm82Fa1ntX4tVzE4zU7YWwn0qs2BpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZM/o868b4sJeHKzWQubf0vaDi/iIYk3Z8+abBXuxi2U=;
 b=TeN9amFwYPjyrLDZl5YWqZj8uy1DRHd3VO2/q8fvv6SxrAYsDOxbRYRvp0NGIZSujZrrN3FJ0mcFX0CX+Z9fT0J8QB9G9xAUXn1DFeahHf7JpNAdvNIYS5+vpGgWnO9U9v9kPRbvWYwMcy8lL4l3w8ub5ORBIy/sys5qVYI+zsFGRWoUAL+jH80FLk5EBb/3OjfR6HhJHg+33brko8C88WEkDCRBcJ0BhDPw65//oxsjJNbZI7kRu97Nnted3J6qPy9MeAwJLv1q9m0LC/o53uCvrYMcLbbOlyS21fLjDWGNzzh0h9OCeBwqARXVgjCYdCyLMGgr5ggHB/dovGSbPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZM/o868b4sJeHKzWQubf0vaDi/iIYk3Z8+abBXuxi2U=;
 b=U6dJxwgC8T28ueEdbU2C5aGCrvf+LHU8UpdJYm0gSxWoGA0Y+hwvE4D13/X3zbJfqKuqatB6f7vhCG6e9gFnjGNRgduwV13gGpn5IbeEBii/ykMY6q3BMbT2aIXs84Dcctxsl+712dO7Dcy8oFJLDt674ctnBH1RPl4pQV+TWvo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CH2PR12MB4311.namprd12.prod.outlook.com (2603:10b6:610:a8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23; Fri, 18 Oct
 2024 14:58:47 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8069.024; Fri, 18 Oct 2024
 14:58:47 +0000
Message-ID: <13ea7d73-d34c-3368-2055-afd7a735f5dd@amd.com>
Date: Fri, 18 Oct 2024 15:58:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 08/26] cxl: add functions for resource request/release
 by a driver
Content-Language: en-US
To: Ben Cheatham <benjamin.cheatham@amd.com>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
 <20241017165225.21206-9-alejandro.lucero-palau@amd.com>
 <47168a34-f0f8-457d-8acd-88f0dd3ab914@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <47168a34-f0f8-457d-8acd-88f0dd3ab914@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0563.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::11) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CH2PR12MB4311:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b5c46af-4217-4951-7cb5-08dcef855e0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VjhoYUcvMS9ucjZHQ2lka014d1Qvd2wyNlNTMzdROHJmcW92ejJzWGZ5aWVi?=
 =?utf-8?B?UXExZm8xSndXTUk0Z25vT1VuSXBaTmVyWjdydHlFZVE0TWNTMFkxVXcxMFFr?=
 =?utf-8?B?N29RVlV2LzZuRGlNanM5R1NtVUhTM2ZraWY0UzhpUWt3MnZsRCtFd3IzU2N2?=
 =?utf-8?B?MGpBajJZczNPU3dzaXUzL3RGTCtTTTBRWjJDZXdYV1ZTY3V0cDV1RlZIYmk4?=
 =?utf-8?B?ZWVXb3IxSk5naGp4dmlySllDeGZTc2JBWjAwblFLNWNiN1JLZC9CanBsRk5m?=
 =?utf-8?B?OElOcGpVODNWS2taTnNTTFJKUUY1VUlwNmd6TkJSMldkUVZCQitKL1R2aWlM?=
 =?utf-8?B?ZDl4UTQ3RlhjOURmTmlvbUN3TTRGZHQzbWFDbXoyZjRxL1MvQ1dCRW9wNEE0?=
 =?utf-8?B?YUx2NFB3OXc1Q2VZczl6d1BzclNWTVovMGVESk8ySjUraGtOYnZyUkJiRnA4?=
 =?utf-8?B?Y25TZm5PTHkxV0NSUUYyY1VzcDhmSmV3OGVWTnd0L05SZ21IMU5Ya1JNRyth?=
 =?utf-8?B?TWFpWEJ0bElZdTlYMWNTL2NocmtVeHgveVA1TkZwbWpUc3JMNmIxYzJJOXpi?=
 =?utf-8?B?Zm9kNnFlbzdkVmsyMU1JRjhla1RtNWE1b0NOcmFkUTd2YnNaZUhNeElLcGhx?=
 =?utf-8?B?eGpYY0J5QlRiNi9yelh0R05YWlBYclNOODVDMVl4Tk1mVEtDV0l4QnM2VVBh?=
 =?utf-8?B?N1M1Q0RmUGFIb1lYZmtBSmFTdlJsaUZIRzZJSWVValBBUi9nRlA0QVpGU0to?=
 =?utf-8?B?YWxpUVkySm80cUJiMXJxUHhlaGlOZGFEL3hwakI2NWt4czhoYlVzbWJRcng5?=
 =?utf-8?B?cmpXUDgvV2xWN0JuaWthTGZsLytnZ3pDMGN0TjYrVzlzYWo2STJ5dFgxWktT?=
 =?utf-8?B?ZVFETXg3enNjT1BKL3N3U0l4blBkblY4a3V0LzZ0NnBHTHFDWmh3Zkx1S0xX?=
 =?utf-8?B?ZUlKdklWKzlVK1hpYUhPQlhIdUNsVkdQd2tsV2tCaXJUekp4bEk1MndhUjFh?=
 =?utf-8?B?cWJCeXZWWjZyZW91cmxXRkM4SzdLVFVLZFFaUUFmL3VaMGRETmkrSklQRmFY?=
 =?utf-8?B?Nmd4ME91c0FrT3R3anZxcGdTRytYVmtEOEtlYVVvbDJZTWo1VVY1TXZId2ds?=
 =?utf-8?B?bWJjZEduNk9VcG9Kdkx1ZjhxN2YwejRYb0JhN3RZRDhVVkg3RElCQUhNK2Nm?=
 =?utf-8?B?SDl4NFhGY1k2OXlFYXNNd1dpWHlDblFLNnpkMGNNekJjaysrdDhjZ0xLTkJX?=
 =?utf-8?B?R1R0STlLcWJWZm1VckpzYzdpS2d5M3paelFvTFhFTlpQb3gwbzM3MTZidEpi?=
 =?utf-8?B?T0owTDF3eWYzUnBlSzRYUTg2eXpiOFBwMG1lWU5NaEI5Ym1PdXd6b3JKNzZJ?=
 =?utf-8?B?Rm13L0lEMXk2YXZkTlgydnp4eGZDcjhwQlYzaG8rNTZTU3lUR2ZUbDAvSGNh?=
 =?utf-8?B?Y0p3cnZxMk13eVlmVDBiQytJNnVWcnpzSEltTDhteFA1NkxlY0tqNmFjaVlS?=
 =?utf-8?B?Z3FZRHIvZVN5OTdmVHV2Y3pOSVNSajUrTkhrWGdnbHQ3eklDcmRhSFRzZVZm?=
 =?utf-8?B?UGRWWXM1aC9VMlEra1hDaFcrcnR6K1dkaFpTajdYb3FmeHJSdzhUTThQQTFy?=
 =?utf-8?B?eFhPUk9RbDhRQXlSSDUxcS9oUE5kempsWXNzdkNZaHBHMVIxdGxUY1ZVMHp1?=
 =?utf-8?B?VkloN3lKK2Fob0w2cEpkY1FPYmRITy9SaEk5QUJJT3VhUUd0WWdKTGJhbTdR?=
 =?utf-8?Q?/L2+nH0tG6Ud6kBjqNIj3kDabXH74fFRc54ME2w?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUkvK0tQRlNjR2tYbXU3UjdMS2R5VWtZMDlHMDVKUmxkZFN5QzNsYVRLdTZ6?=
 =?utf-8?B?MmpXRjJQVHN2SUdBZzFmbHFJUlBuM2tyekMycFQzc3J1MlVjUUpGRFQ1RGsr?=
 =?utf-8?B?d1dTbFBYR2pKNlk0T3o1OUtJUXZ0ejVWOThNR3dZcEw1ZTFKbC9HdTRrRGpG?=
 =?utf-8?B?YnRGWEU4cU1xVEYyN0I4RTVqc1JBb25UNFpIK0RhUlhDcDliQkpNWXVwcFJG?=
 =?utf-8?B?SnVkd1ZTVVVsb3VtWmxuak5yVXpvVTdjUk5LZmQwOWVuK1lsMEpldm53b21O?=
 =?utf-8?B?Z1ZCVDRVQ0JYMVNJOVd1bnRWdE1rTWtpcEFsUHFOQUZLeEM2SXBYMDV0djVk?=
 =?utf-8?B?R1NTTzNUVUZVN1k2cG1IZDJXRkdDd3FOVUIycFI4MEtNbUE3SC9LajgrM24z?=
 =?utf-8?B?VGV3Uk9RSzVVeENDV2RLQmNyeDJodFBQY1kwdnpWNXNsc0wxc0w2RWZ1eFl2?=
 =?utf-8?B?RGlYYlNwbHJRaG9nWlhoTTI3a1JBTWx3SFJnbXo5WGJrYVJmTlRTejlRUEl4?=
 =?utf-8?B?SUsxTHJtQkxML2l3WFhmZ2REcHJjM0w2a1ZURlBka0NldTF4T05kUzFXa1dY?=
 =?utf-8?B?SVZiSE4vVVNCTnNFTFhDR2hmbU81Ung3a0Y5eklJSjlheUt3NXV1a2FQdHkv?=
 =?utf-8?B?dWQrNk5haWwrRHB4S1RZbndFT215TGZRTE5sMmtYMXUrTzlmNjRUT0NwMGJH?=
 =?utf-8?B?aGZBbFNiTXBGeFpDUmZJK0k4MWt4ekdHeUZSSitwMUJoa2NFMEFxSy9ISEdJ?=
 =?utf-8?B?MVIrNk5IYklIeElmT2tVUWdJemxKMTNDY3U4enQ3dk1uL3oxNWFkSmxra3RV?=
 =?utf-8?B?WEdrdHlHTE9hZHZTbUZtdTlhZTlWeitjY0syZHg2Q083Tk9sVXhlSWtaMEkr?=
 =?utf-8?B?ZjlYNkVnMU1lWXhFUnhLanhSSUN0YWZ4RUcraVNzTmtPTVRodHdtdktZT3FT?=
 =?utf-8?B?K0lqQjJsNE5CS1Btb1M2TWpkdEZhOTRjNjJPbEZ3eFhoYU5ndGtjSHFOcm1u?=
 =?utf-8?B?UWJFOHNiTUlCQ0NVMWdyekNsV0RFeGU4bFl1RCt0Rm8zNWxQNEVGaU5qcUFn?=
 =?utf-8?B?QXR0NS9YaStyT0NPTDg2aFJpUUJvaVhVWnVRRHVzK2ZhNjRBSThUWDlrL2pG?=
 =?utf-8?B?TzIxZ0E1REJmQ29seGxvS1I3U1hyWGZCSHBWK2hxQVNLVjJhNE0vNVpaeEFP?=
 =?utf-8?B?TFd4SkIyRWlYYmxCSXBkKzA4YjQzQ3VRek04SWtDaFhpaWlEby9JTXVxRUpw?=
 =?utf-8?B?a0lHLzJDYVhFdmg3QnlNczdpYlJGMDViMDNyZjUyT1oxaDExajlndzdGTmV1?=
 =?utf-8?B?NWpGRk04S3hoMzVmQmV0WjAxc2tHVW5tbU54Mk5PWnBOWm9xY3FwNy9EZFZX?=
 =?utf-8?B?RXhQbVFvNWhnT2tYeWhkRUllb2JuaklGMmRvV0JKbldtZ1UrRlFOY3NSRlpC?=
 =?utf-8?B?enVqY2cwMk5aQ1BvekpzQkN0NHoxVkZPU1dvMTE0WnBLbFV5Mm1zanNYQ09M?=
 =?utf-8?B?UWY2LzVvMWlMZTNweFBkb0tzSVpJMTVabTV6TUY4cmN2Wkw5VGtyRzIrNFJ5?=
 =?utf-8?B?dEFHOGJMUUtFUE8yVW1paE5UTUc3NVJEZTJGNXkveUdhMUpyb2U3MzA1ZnY4?=
 =?utf-8?B?VVBwQjVBZy9CYlJWZ2ZHYzFtSlRiY1JzaklQeE5SMHI4NW5xak1ZV09qSFMr?=
 =?utf-8?B?MzBObnhyUldzbERYWjk1Zm9EYVV0OXBZQUdkV2ExQ00wd1JOaVhMeWVJTWg0?=
 =?utf-8?B?cWNFL1N4Y2ZTd1JUcVRibEczV2hSQU51ZUxhUGN0U1NlK2p3S0lBMEZSWHdT?=
 =?utf-8?B?Z0hKNWo0Skpma0d2OXl4OXRLRklNejhFZVA2WmY2cFhXSmlJMW5LUDFLUHFk?=
 =?utf-8?B?VTEwTWVWdld3SkVzanlGZkdMMzlGcytMR2pRenNPcG53Z01oVm1mdlZUYjhr?=
 =?utf-8?B?ZHpXSFhDTWh4SUY0NTRheVpVS0F6emE3bTdOdTdjdVZpNk9NbFRzUXRMTTZQ?=
 =?utf-8?B?T05aUWN2U2Y0QU9jQXdGbXVTL1A3bWswZ3RuL21wbDN1QVhKVHRHOWw3T3cy?=
 =?utf-8?B?MmU1SHN2ZExGU3hxTzIrVytBZ3NnQXUyY0hvam9EWTQraFo4Q3k5dkl3c0R2?=
 =?utf-8?Q?L2Rsa9Rspw0d+DRkkZIdUYgnX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b5c46af-4217-4951-7cb5-08dcef855e0e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 14:58:46.9828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VUdqjMZBQQKj+IgWwwLGd3YQYGqvLR2RC35ot1n3wOtwRQ82RtK0o4fq1ghUIqAFT0B/sORHyv6dSEHYb2omSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4311


On 10/17/24 22:49, Ben Cheatham wrote:
> On 10/17/24 11:52 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Create accessors for an accel driver requesting and releasing a resource.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/memdev.c | 51 +++++++++++++++++++++++++++++++++++++++
>>   include/linux/cxl/cxl.h   |  2 ++
>>   2 files changed, 53 insertions(+)
>>
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index 94b8a7b53c92..4b2641f20128 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> @@ -744,6 +744,57 @@ int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_set_resource, CXL);
>>   
>> +int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource type)
>> +{
>> +	int rc;
>> +
>> +	switch (type) {
>> +	case CXL_RES_RAM:
>> +		if (!resource_size(&cxlds->ram_res)) {
>> +			dev_err(cxlds->dev,
>> +				"resource request for ram with size 0\n");
>> +			return -EINVAL;
>> +		}
>> +
>> +		rc = request_resource(&cxlds->dpa_res, &cxlds->ram_res);
>> +		break;
>> +	case CXL_RES_PMEM:
>> +		if (!resource_size(&cxlds->pmem_res)) {
>> +			dev_err(cxlds->dev,
>> +				"resource request for pmem with size 0\n");
>> +			return -EINVAL;
>> +		}
>> +		rc = request_resource(&cxlds->dpa_res, &cxlds->pmem_res);
>> +		break;
>> +	default:
>> +		dev_err(cxlds->dev, "unsupported resource type (%u)\n", type);
>> +		return -EINVAL;
>> +	}
>> +
>> +	return rc;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_request_resource, CXL);
> It looks like add_dpa_res() in cxl/core/mbox.c already does what you are doing here, minus the enum.
> Is there a way that could be reused, or a good reason not too? Even if you don't export the function
> outside of the cxl tree, you could reuse that function for the internals of this one.


Although they are obviously similar, I think it makes sense to keep 
both. The CXL accel API is being implemented for avoiding accel drivers 
to manipulate cxl structs but through the API calls. With add_dpa_res we 
would break that, and calling it from the new cxl_request_resource would 
need changes as inside add_dpa_res the resource is initialized what has 
already been done in this implementation. IMO, those changes would make 
the code uglier.


Moreover, your comment below about cxl_dpa_release is, I think, wrong, 
since inside that function other things are being done related to 
regions. BTW, I can not see other release_resource calls from the 
current code than those added by this patch.


So, , I'm not keen to change this now, but maybe a good follow-up work.


>> +
>> +int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type)
>> +{
>> +	int rc;
>> +
>> +	switch (type) {
>> +	case CXL_RES_RAM:
>> +		rc = release_resource(&cxlds->ram_res);
>> +		break;
>> +	case CXL_RES_PMEM:
>> +		rc = release_resource(&cxlds->pmem_res);
>> +		break;
>> +	default:
>> +		dev_err(cxlds->dev, "unknown resource type (%u)\n", type);
>> +		return -EINVAL;
>> +	}
>> +
>> +	return rc;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_release_resource, CXL);
>> +
> Same thing here, but with cxl_dpa_release() instead of add_dpa_res().
>
> Looking at it some more, it looks like there is also some stuff to do with locking for CXL DPA resources in
> that function that you would be skipping with your functions above. Will that be a problem later? I have no
> clue, but thought I should ask just in case.
>
>>   static int cxl_memdev_release_file(struct inode *inode, struct file *file)
>>   {
>>   	struct cxl_memdev *cxlmd =
>> diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
>> index 2f48ee591259..6c6d27721067 100644
>> --- a/include/linux/cxl/cxl.h
>> +++ b/include/linux/cxl/cxl.h
>> @@ -54,4 +54,6 @@ bool cxl_pci_check_caps(struct cxl_dev_state *cxlds,
>>   			unsigned long *expected_caps,
>>   			unsigned long *current_caps);
>>   int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
>> +int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
>> +int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
>>   #endif

