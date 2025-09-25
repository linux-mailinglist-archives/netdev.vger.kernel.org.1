Return-Path: <netdev+bounces-226223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5566BB9E46E
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 11:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 634F81741BF
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 09:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284992E975A;
	Thu, 25 Sep 2025 09:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4a1t/k0N"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012042.outbound.protection.outlook.com [40.93.195.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF4D1552FD;
	Thu, 25 Sep 2025 09:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758792076; cv=fail; b=eacT2HTkdagmqNdkwa6Q9NPnJY+jUpWR3Nt1LvTq0VBWSzCn2fLfggouBCrr7ZQZPopvH9XcYbq5rH1jS0FBeyx8jlUVBApSXfkPCBzJSaI0hb7w7LemzJHHD9QRtc1tNwZn4BB0wi0KtUofToWUwXWbD0kX0sIj9DaIZdYDdDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758792076; c=relaxed/simple;
	bh=86X3AaJzXdQ2pP7qcrN5VJjTUoc4SbObYvq+OJferJY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aUwHlj62agNbpvJy49fe5xErB1EvwbTlLfHz/bohZeQcrMcqDMCMOZ1DYnqZCHT6X77uqnf3Td/dNtGFjj5DI3tck93LgqHOQnbuVWxkkvJIzqu2RSdhNUuQGIciTgvHksbiSR77piGEwAIrEl5U/NVTUcI4OYueX+ekx1HDpw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4a1t/k0N; arc=fail smtp.client-ip=40.93.195.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PjmO4yolSe2iAW5Z9Cck3uXrX+Fab84c9CfkREqtMsjHRiJI/EuK6lzvAG6LecVmfxEpmuZ6I+8X2pCuwOORDkDWeqJkbZVUGu+WwCFFOhIg+r0a8/ZnADg/3W3mifme0iAx8jvqqXjaf7EAtI3aMC0zlpCBPc96mDfMb9ttH5KZ5mDBHY/EPxgr0Jyx9zFDB2g1LIeJ9zr03bDvyef0RhGDYVdNfxds49vwNkapfVpXyxMA8I9jDMiD5H/U0Y08fRB3EnhgWJONzK8x9UfIWk2bXFzueSTmGBiSykPpK+Sad49ksYL5eDixwy0cWSfGuP4OhDRwYqRY7sPgajeDgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IKjdAEX3WEhpHNgwjtu1wiG1mnGRx/bMcpetGFOGIQM=;
 b=q9XxLmbE7vy5Y6kXbljb1xvL5+SS7GBlr2fcxL9TC/f6NHJDTRKgoGN5VViGUKZSOxGyUE3PRrBVduYSeo2IlpyIQZUR6bl8YzMGvQl84oi9wYTvP14uQtI5JZvVPMdRep+4cqj4lodAaAcoc5hwiKJHtW+0muZikW5eHj/SltMz/vhzqYBzVPNQry3YYdvkfHjU4KqOx+AI7tpOXdUv7MNsGIaJbyAcjKrH5hTQXt5doPy6vIArNSpckMPR7IFDwB8g72zv5WbvlgBqmA5FrJbdGUDdcs8dI2wdvxDxxpDqFdNHSXIq/zGckHsb/NF2wvx//AJyXtyf9l9i3moOlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKjdAEX3WEhpHNgwjtu1wiG1mnGRx/bMcpetGFOGIQM=;
 b=4a1t/k0NpukzlvpBvX/IOC4meDI2+TuUJZ2YUJaM2G3J+fWZgizsAMC9a4Z31R00fAYqj+S5rUkEMMpTa5kuRm4zCr6/nWvuZolQQNhIfh+58ayYDuJsCgXZplpRp62MRQWBEhre8GH46K80+cQlLOg5FKhc/557VxAaX6xGU4I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SJ0PR12MB6687.namprd12.prod.outlook.com (2603:10b6:a03:47a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 09:21:10 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9137.018; Thu, 25 Sep 2025
 09:21:10 +0000
Message-ID: <f3b81f01-8b82-4df7-88f3-a17ec846d21e@amd.com>
Date: Thu, 25 Sep 2025 10:21:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 11/20] cxl: Define a driver interface for DPA
 allocation
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
 <20250918091746.2034285-12-alejandro.lucero-palau@amd.com>
 <bd1d7584-b842-4a65-967d-578bdbdda5ca@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <bd1d7584-b842-4a65-967d-578bdbdda5ca@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2P250CA0028.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::33) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SJ0PR12MB6687:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e19ebad-217f-4d1f-826e-08ddfc14dd96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OCt1M2F0b25TTFlHWkdCUnpyMDF3T0I3UTI4MFdqTmdBWThzT2Q5aTBkQnJU?=
 =?utf-8?B?VjJ3b2pwMkp1T1NFUXJLcTZMMkNBQ0dibmZQNzZXZzVMSXY2aHVnSTlHSkEw?=
 =?utf-8?B?dTdCbHdjS0VzUytpaXRtYzk1YU9ua1ZEeDdaU2ZabDdDOTBGbnRzb0QybTFi?=
 =?utf-8?B?REZLejV2NytTcGZpdXR6UXBwWW9oOFpDU2hDK2J4UmZ2dDNTeXREWEZRSFRz?=
 =?utf-8?B?OUpvclVxR2tIZUpYTUROa3FuaElVWXliMm1JVE16Vm5nVzRIVXl5aFVYd2hT?=
 =?utf-8?B?VlE0ZmpPK0pGdE9yQnhaekllRnJ4OVppSmorYm80cE5RTVFxeFp3Q1oycjJq?=
 =?utf-8?B?TTF2b2RZMVJOeE93Q2dDVWdRR1o0eEZrMENxNU8rMTIxREExWDEvOXdvV1c2?=
 =?utf-8?B?Y013ZlM3RVVWUXBNTmRBbFZVYVBXMVhSS2ZCaVBhaHU0UjVBbFJ3dVFZZTBI?=
 =?utf-8?B?OW44WUl2UGZtUlVTamFFMW4xbjFJVHdxR2JaTUhFTnFrZTFQVkEzZitQOVdP?=
 =?utf-8?B?MjJ4WVE2dmsxREVyUCtDMWFENWx3OW8zWS9RSGpQWGZUS0Roa09rZ3ZWaHQr?=
 =?utf-8?B?REpaRFAyRE1GMlJEZUZtMUkyWk94a0ZBYzB4RDIrV1ZnOGpVSTZKL01pKzRO?=
 =?utf-8?B?VXp1eEVMQ1NOWmlTenowZWJxc2ZaSlcyZFREM3Z0VTd4anlLb0ZmdXhBZytL?=
 =?utf-8?B?b2ExS3NVNStmT2UvT3YrZE03TUhsRlo4M0VtRnk1U3NoMWJVWHRYV095OEhV?=
 =?utf-8?B?cGlYRit0bFRVTThVVzdJajNOK1Nqd3hOaEJlNGdKVkZ0L2ViRWU5eWNvZGNG?=
 =?utf-8?B?QjRGaVVtdHpiakI1a0pFWVdzU0pZM29lVklTRHVuLy9laE5vQjBtRENHUFZy?=
 =?utf-8?B?MlQrZHVhYjJjbko3NHI0d2JFL0EyUFFEVVdwUy9yUlF4ZlV2RTgwREVNbmpT?=
 =?utf-8?B?MTArY1ZrcjNaT2pZNTI3b0VZdDIwMGxHd2JTSG5Rekx6TFVuUVFNSm1aK1U4?=
 =?utf-8?B?aHRMVUg1SUQvSC9ZNWRXTGxEcnQyMEF6N3Y1RlBKczdOUmpsdUo3WFg5U1lt?=
 =?utf-8?B?UERBOFBITjBSYW1qRVByL1dqdDlKSmw5QXRKaGZMNTF1YjNIOFlKVENudzJW?=
 =?utf-8?B?ZUJZODdQMU1IdERRUXNnckJ2aWdJaVl4VTV1OXdYMFlhZ0VqQldMaWtGdE9U?=
 =?utf-8?B?NkhaTmN0MW1kLzVmRUJsSzF5UXE1NWIrMCtsVmV5VXlKTFlORDI3SkhXb0dW?=
 =?utf-8?B?a2xYS2ZUSW1jQ1ZCT1FJV2VkQWJESWdNQzkrQ2w2cXNoSXBEblpRSmI5OVBR?=
 =?utf-8?B?aTVjd29ZUysxdHozQytWN1dvK1F2SDhsVXhBYkdSYlRORysrSE5YYkQvYjFq?=
 =?utf-8?B?VU5qYUl3K2J6TXNoWDNxWm5INGUzYlJ5UXpCejV1eXpadlMzd3NuM2lVbHNu?=
 =?utf-8?B?SnJCZnNhZWo5Yjc2S2Exd0JiSk1TTjdjK29SRDYyRlRkQmRxZWFGVlJWOElZ?=
 =?utf-8?B?K3JYU0tMT1Z5cWVwdXZtejBtUGw2MG8zdTVUODlPcHdPS01qSXpYZUJpYVlw?=
 =?utf-8?B?VUthbERmNU1NY0llVXFLZ01tUE5tQmtNSzYzeEV2SDdXYWo1WTZ5NHRTRkI4?=
 =?utf-8?B?NHJFRWg3Wm9Yd2JMa0NlWkZKaVgxYjZ4OHludTBTcE4rSVRZcGt4bEpmL2xC?=
 =?utf-8?B?NFpWK0dvSWhtcHJJcDllRGRxZE9JemtPaXFwK21odG1udEVzVnh2NnFWUlFT?=
 =?utf-8?B?MFNQK2hUNWtMWEdpOEdTOXdCMjhmRFFyNlZtaTFCYVd5d0czQnNMeXdCVHNh?=
 =?utf-8?B?ZEtQTXhQMWY3TGNtSG5ubVNqYWlYYnplTlJmWWNGN1hrU05iaU4wb1ZLaC9P?=
 =?utf-8?B?eEZ4dmZPYzB6Q0NTb3J2V2JUSHRxeWxLSmoxVEpLS0dQTlRydUh4NlRXUWVF?=
 =?utf-8?B?K2JRWVh2U0Faek4vdnpXQmg4bXFic3MxUFBnL0JkZEw4blRNQi9GT1pCRW03?=
 =?utf-8?B?bDN5NnVSUklBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2lMWjYzNTR4ZnF2STZaMTlMNE9TUFNYMnFYUzRxZE0wcDA0M1J0aEg0WjFk?=
 =?utf-8?B?TmdYQkJMTEV0S2xMSHBmRHR0aE5nWXl3RGF4N0piakF2S3lMWUxhRnB4cVo1?=
 =?utf-8?B?cnlBaVVSREF6WVQ4cDZyTVhhdktnTGM3WVJTV2JrWEE1MUs0OGZSbUk1NmNZ?=
 =?utf-8?B?MFBVZmRPZGhJa2xpVG1xR1dOQVBUSGMxRlhMMUkwM0Q3R1JUcWNlRmMyRWVN?=
 =?utf-8?B?NVlPNjhIbmFQempvdTdwT25CcnIrV0phYlNhbndmU25RVkpnRzVMbEgwSUI2?=
 =?utf-8?B?S3FmR00ySGkyeUxEWDJZSlM5TzBGTkFCN2lQZFJXYU56SXZFWlZ3MldBTWlR?=
 =?utf-8?B?UGtYamIxREdnbHc1aEZsU25uOVhYazhuNk5XS0pyV1NWQy8zM0trdmVNM25H?=
 =?utf-8?B?S2RtNmlpaEFkeFZtQWd1eHk4U0dzL3FWMlY1b1hZT1kxS2RYa0xJN2hwUXJ0?=
 =?utf-8?B?WWViZVdJRDlMUW9sem8vQnp0b2FlY2Y3YU1GOXp4eU5uQTJqcVBzVWlkdWty?=
 =?utf-8?B?OHd4ZjR4YWpYMkZ5bWZ3bW5aVzc0TUsrZllXL1RGaTRmNTlDZll4cUU3VVg1?=
 =?utf-8?B?Yjc3V3EwWktnZG5tTVFWMDRleHYwZ3p0YTdmakJZWFE2SlJvaGVmZnRxVU8w?=
 =?utf-8?B?Z0M0ZnVaQUlTNGkrbU1RRElqZThCRG1lTzdsVUlKL0tOY09kYllZOFdhWGJQ?=
 =?utf-8?B?Y0VFd3NWNXZ2ZzlDM0lDamNQWFAxUWhpTDEzeEdyRkFuQ0hUWFdoTmtLRFFG?=
 =?utf-8?B?bFFmRmtPNk45S0kzYXRZT0t1TTVFSmpPWDFlRUVuSHduQmZ1QXVMZTQ3RTFv?=
 =?utf-8?B?S0FZRjhTcTRXQlhDRWY0YlRpWXo5M3R4akFMek42cVYxRWpKbUxNZDFUZVM4?=
 =?utf-8?B?bk5WdUJOTno0T0g0ZnQvRlg4YXRuUGtKR3NKZTI3UGlJaHhoVXhWWDIyYWpy?=
 =?utf-8?B?RDk5eGlUT0c0S2d2Nm9JdEhhaDhObVZnTHJOT2RyTncxdkVkRUVUQ1dPVGxr?=
 =?utf-8?B?VTh1M1lNNmx4U0w0QzdEZTl5a0ljcmQ1VE9wa3gwbUNnNmRiWlJzdHcrWDVM?=
 =?utf-8?B?eitqdG5rSTZCR1ZpVjJmbGNYbjhGWGNWVDJNNFBTdVdzZ3dTY0g1RUhWeWc0?=
 =?utf-8?B?dEJId0RGZTN2UTZ5dzZLRENOcXp4VDVoRGJjY3ZydUovMW90b3F5VHh5UzRw?=
 =?utf-8?B?bUQ4UHdmTVFubnpucExRYXAzQk5WaXphQ3Yvdld6anJjak9KK01LQjkwUG5X?=
 =?utf-8?B?VFpNZVlnSjZMQXVhMlA5UmxIeHlsejVhZFB5YTNRNHF0UEZoelpWY293K2hx?=
 =?utf-8?B?SXM1ZFpYRVF3bDM5U2pndWFudEs1bnlSMndDZ1cwdXhBRThJS1Q5dFZ5eTh5?=
 =?utf-8?B?UExUM054cVVJNVA2QUV4L2c5bXVGV0JZbDVPNUhvSkZjZ2RiVm9KUlpnbStm?=
 =?utf-8?B?dU9ESWRqV0xrd3djMU0vYkI4ZE02bG84VnN5TGdDQUNhT2lZU0hxZnNDZlZL?=
 =?utf-8?B?N1hnZDBLK3BSUHJUeEZMQ3dmdUdUYnNxSUlyS0lFd3owS2tlR0JsMU5JcG90?=
 =?utf-8?B?bXJsNzQwb1QydlNMSFd5SmNaWHlEb1F2MHFlTlN3MGNTVk5kSmNqcWNKblE0?=
 =?utf-8?B?c0VSUkQzVGZRN29BWUhBWWlTSzRqbmtaWEorMVljMGU3MnNkQkJIN3E2dElZ?=
 =?utf-8?B?L2pKenFvdXFqcGxpSHhHMHhjU1krazZkWDlUeDZWUkNqQjVGc3B5R1hpYXdu?=
 =?utf-8?B?Yzl5Y1U2b0JMZGFUM1BGblk1RUJQb1lzcFFXRHdiQzhyekRISTcvakJHeE40?=
 =?utf-8?B?VzEvRC9PWlFQUk9ScXZHeHJ0NEcxc1pTd25YVG9PeitOVHp5Rk9YSU84VDJ6?=
 =?utf-8?B?NzNvaXhReFFPd3FYZTE5T3VLQVZmSCtLenUwemphV3lNWkluWjVUOUhkRmcw?=
 =?utf-8?B?bDlCS3VxdVhyeFc0a2k3dmI1ak5FWndoeThFNmtsWW53NE5mNElGaFdDSms2?=
 =?utf-8?B?RGttbmJpK3BidWZUUlRCRWRsV01wbzFza2U0UnlFbVdDVTkvVGlRTGFTTVd6?=
 =?utf-8?B?aXhRbE1hVk43eGQrYlY5ZnpFNk0yOUJDSnhUbUw4YkoyYWlXZUFPSE8zckh6?=
 =?utf-8?Q?UfBZe7yIriUOLFqbgKIokpQcx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e19ebad-217f-4d1f-826e-08ddfc14dd96
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 09:21:10.5516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sB31fiWEEcNV6zncQOx0jD5uKOFuNH2FXbuTcdFeSRfpYF600JxZIC5BRUwznit65QzeKMtooJM6EvczrdjOsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6687


On 9/19/25 20:46, Dave Jiang wrote:
>
> On 9/18/25 2:17 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Region creation involves finding available DPA (device-physical-address)
>> capacity to map into HPA (host-physical-address) space.
>>
>> In order to support CXL Type2 devices, define an API, cxl_request_dpa(),
>> that tries to allocate the DPA memory the driver requires to operate.The
>> memory requested should not be bigger than the max available HPA obtained
>> previously with cxl_get_hpa_freespace().
>>
>> Based on https://lore.kernel.org/linux-cxl/168592158743.1948938.7622563891193802610.stgit@dwillia2-xfh.jf.intel.com/
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/hdm.c | 83 ++++++++++++++++++++++++++++++++++++++++++
>>   drivers/cxl/cxl.h      |  1 +
>>   include/cxl/cxl.h      |  5 +++
>>   3 files changed, 89 insertions(+)
>>
>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>> index e9e1d555cec6..d1b1d8ab348a 100644
>> --- a/drivers/cxl/core/hdm.c
>> +++ b/drivers/cxl/core/hdm.c
>> @@ -3,6 +3,7 @@
>>   #include <linux/seq_file.h>
>>   #include <linux/device.h>
>>   #include <linux/delay.h>
>> +#include <cxl/cxl.h>
>>   
>>   #include "cxlmem.h"
>>   #include "core.h"
>> @@ -556,6 +557,13 @@ bool cxl_resource_contains_addr(const struct resource *res, const resource_size_
>>   	return resource_contains(res, &_addr);
>>   }
>>   
>> +/**
>> + * cxl_dpa_free - release DPA (Device Physical Address)
>> + *
>> + * @cxled: endpoint decoder linked to the DPA
>> + *
>> + * Returns 0 or error.
>> + */
>>   int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
>>   {
>>   	struct cxl_port *port = cxled_to_port(cxled);
>> @@ -582,6 +590,7 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
>>   	devm_cxl_dpa_release(cxled);
>>   	return 0;
>>   }
>> +EXPORT_SYMBOL_NS_GPL(cxl_dpa_free, "CXL");
>>   
>>   int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
>>   		     enum cxl_partition_mode mode)
>> @@ -613,6 +622,80 @@ int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
>>   	return 0;
>>   }
>>   
>> +static int find_free_decoder(struct device *dev, const void *data)
>> +{
>> +	struct cxl_endpoint_decoder *cxled;
>> +	struct cxl_port *port;
>> +
>> +	if (!is_endpoint_decoder(dev))
>> +		return 0;
>> +
>> +	cxled = to_cxl_endpoint_decoder(dev);
>> +	port = cxled_to_port(cxled);
>> +
>> +	return cxled->cxld.id == (port->hdm_end + 1);
>> +}
>> +
>> +static struct cxl_endpoint_decoder *
>> +cxl_find_free_decoder(struct cxl_memdev *cxlmd)
>> +{
>> +	struct cxl_port *endpoint = cxlmd->endpoint;
>> +	struct device *dev;
>> +
>> +	guard(rwsem_read)(&cxl_rwsem.dpa);
>> +	dev = device_find_child(&endpoint->dev, NULL,
>> +				find_free_decoder);
>> +	if (dev)
>> +		return to_cxl_endpoint_decoder(dev);
>> +
>> +	return NULL;
>> +}
>> +
>> +/**
>> + * cxl_request_dpa - search and reserve DPA given input constraints
>> + * @cxlmd: memdev with an endpoint port with available decoders
>> + * @mode: DPA operation mode (ram vs pmem)
> s/DPA operation mode/CXL partition mode/
>
> I would just leave out ram vs pmem. When something new comes like DPA, you'll have to augment it if you had that.


OK.


>> + * @alloc: dpa size required
>> + *
>> + * Returns a pointer to a cxl_endpoint_decoder struct or an error
> Returns a pointer to a 'struct cxl_endpoint_decoder' on success or an errno encoded pointer on failure.


OK


>> + *
>> + * Given that a region needs to allocate from limited HPA capacity it
>> + * may be the case that a device has more mappable DPA capacity than
>> + * available HPA. The expectation is that @alloc is a driver known
>> + * value based on the device capacity but it could not be available
>> + * due to HPA constraints.
> I'm not understanding what you mean by "but it could not be available due to HPA constraints". Maybe the last sentence needs to be rephrased.


What about "... known avlue based on the device capacity but which could 
not be fully available to map due to current HPA constraints"


>> + *
>> + * Returns a pinned cxl_decoder with at least @alloc bytes of capacity
>> + * reserved, or an error pointer. The caller is also expected to own the
>> + * lifetime of the memdev registration associated with the endpoint to
>> + * pin the decoder registered as well.
>> + */
>> +struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
>> +					     enum cxl_partition_mode mode,
>> +					     resource_size_t alloc)
>> +{
>> +	struct cxl_endpoint_decoder *cxled __free(put_cxled) =
>> +					cxl_find_free_decoder(cxlmd);
> Move this down to right before cxled is checked. It's ok the declare variable right before using with cleanup macros.


I'll do so.


Thanks!


> DJ
>
>> +	int rc;
>> +
>> +	if (!IS_ALIGNED(alloc, SZ_256M))
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	if (!cxled)
>> +		return ERR_PTR(-ENODEV);
>> +
>> +	rc = cxl_dpa_set_part(cxled, mode);
>> +	if (rc)
>> +		return ERR_PTR(rc);
>> +
>> +	rc = cxl_dpa_alloc(cxled, alloc);
>> +	if (rc)
>> +		return ERR_PTR(rc);
>> +
>> +	return no_free_ptr(cxled);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_request_dpa, "CXL");
>> +
>>   static int __cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
>>   {
>>   	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index ab490b5a9457..0020d8e474a6 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -625,6 +625,7 @@ struct cxl_root *find_cxl_root(struct cxl_port *port);
>>   
>>   DEFINE_FREE(put_cxl_root, struct cxl_root *, if (_T) put_device(&_T->port.dev))
>>   DEFINE_FREE(put_cxl_port, struct cxl_port *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
>> +DEFINE_FREE(put_cxled, struct cxl_endpoint_decoder *, if (_T) put_device(&_T->cxld.dev))
>>   DEFINE_FREE(put_cxl_root_decoder, struct cxl_root_decoder *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->cxlsd.cxld.dev))
>>   DEFINE_FREE(put_cxl_region, struct cxl_region *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
>>   
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index 788700fb1eb2..0a607710340d 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -7,6 +7,7 @@
>>   
>>   #include <linux/node.h>
>>   #include <linux/ioport.h>
>> +#include <linux/range.h>
>>   #include <cxl/mailbox.h>
>>   
>>   /**
>> @@ -273,4 +274,8 @@ struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
>>   					       unsigned long flags,
>>   					       resource_size_t *max);
>>   void cxl_put_root_decoder(struct cxl_root_decoder *cxlrd);
>> +struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
>> +					     enum cxl_partition_mode mode,
>> +					     resource_size_t alloc);
>> +int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
>>   #endif /* __CXL_CXL_H__ */

