Return-Path: <netdev+bounces-174107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A948A5D817
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 09:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15CB23A5576
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 08:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28F3233D85;
	Wed, 12 Mar 2025 08:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hop83F8m"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013381E1A31;
	Wed, 12 Mar 2025 08:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741768002; cv=fail; b=D9UoDicW/y5tLYQ9mMQCMbxV2NBDawwBlnDAwwWfvO3l6NaHtNlWmTMtvCxESwUf88xv1Z7FEZ87yxACvi/kpVq/B1BjOm+pZzUNJemsgl9F10p2vv0wL3rc+h5KJhVOiHGIIBian/QLWRQ4fmEllwsW9sSAkzhe3/rMU9WHatg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741768002; c=relaxed/simple;
	bh=T2RYJEPDULJJ3jz5qHVECWo6rUDiF487jM0uVDz+als=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jCpexuz25kubOO70IrDZd0oDkwUiS9btNsKBz0Ew86zcX1k1Bdb7h+G7TMHxxCqiGJgFjIY+MOB5xsV1GMnySJMfgJvR40x5MgiRAHohxTdjrgIqKjcY/f4v+urpLMCZM0mNHeOdwludyZ/VHAEK2vFuoFWxDATHiiW1/moGa9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hop83F8m; arc=fail smtp.client-ip=40.107.223.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hKwzCQb6Q4z/JZ7P/M0Y8fjOTjGaBpXu2Qz49CUXZCmD8Dt09rOFWsupXbY1MknWaWzVWGF5U4bqBHSxDdUU12ltFWgW002gCRUyUWMYDqJAPdOw1JAr1m0rSyLsV+hQDS/3gwpI+JgdAlN0dmoAHvyr/J7sT9ejjWy6xjxYumRZYyQEfRI1gg3vzijnYyBdfnjxkbX9JfySaYhDuFWXHBKrMzxmg2RZXpJHFy904wryPY5dDBDoJqPeUMllPXdyu5Yp91+fraJIuq99E7pGWkauFvGyB8vlY3eNDKNfA8p8A1zIr9v52cuOdyLZEQ68eNMp/vTtd84ycS+2opORuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EE+HSQXMLV07wwirgLBUPRmGVqdt1UQqI0NA8ga3kNY=;
 b=r+Pexxib9jkNKSXJL6uk0nRY7NI8FASt2wYq1rpUS0bvjExvzHHEJErAcAsJarBNAPBjI95zfidPGGIWvEdb0J0J7iIEowdTYPE3+FDh3uduNpIIL49j72waChqAc9lYAOeSBVX0HOfNqyGv+taCe/8NWyuaR8Qg4Ly05MuKFtbE6t60Vk1eN8X2yKdkIUsg8dCTXiB0TFzjyXsDGC4V+7bNiv6x6fKA3aAtTi64/ZjrhMj4JeJJVn3/4JoRL7rvcI5pYit/o7aG9krFFQuADnjr8lSAJbW4eXwZkHiR5TVoz07Sh+fGowV7G1R02zYQvOHZSwvvCyZH3GarfFHF2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EE+HSQXMLV07wwirgLBUPRmGVqdt1UQqI0NA8ga3kNY=;
 b=hop83F8m4bbTU2hmA/ti2SeQC0BaixIWW/jdBGu+bGliLKWp8twB3CmpkeM3+RvcnJL4RvCvTItZ5zFRkNuegiDi6F742LMI/ELF4aqxTFS/t2dkR2lK0nxKdc7acyCtSPsaYwLp6u0+JWhhvJE0Ynihzp56XhHklYwk+9sJXwY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SJ0PR12MB5663.namprd12.prod.outlook.com (2603:10b6:a03:42a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 08:26:38 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 08:26:38 +0000
Message-ID: <98361e3f-e2f8-43c2-a032-f7e84d5414e0@amd.com>
Date: Wed, 12 Mar 2025 08:26:33 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 03/23] cxl: move pci generic code
Content-Language: en-US
To: Ben Cheatham <benjamin.cheatham@amd.com>, alejandro.lucero-palau@amd.com
Cc: Fan Ni <fan.ni@samsung.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20250310210340.3234884-1-alejandro.lucero-palau@amd.com>
 <20250310210340.3234884-4-alejandro.lucero-palau@amd.com>
 <ed05f435-e628-4d91-8584-cd8f120832c0@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <ed05f435-e628-4d91-8584-cd8f120832c0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0168.eurprd04.prod.outlook.com
 (2603:10a6:10:2b0::23) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SJ0PR12MB5663:EE_
X-MS-Office365-Filtering-Correlation-Id: 465a7f53-29f4-4540-117d-08dd613f9bc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c2hTQWtqZDdHV0pNbkdOcDE1ZHRmVDBhV0xWMnRpR0JhaXRpdUlWWjM0cXlz?=
 =?utf-8?B?Q3VJblZTb0VkRmx2YnZSZE5XUnZUc2VnTDR0OVpvaGNnSEFTZmltNS9BOHE4?=
 =?utf-8?B?dGFZeklXR2F2SVJDY0RwOTBNTFFtUWxFTldKOC8xYjFUbVZwMjB0T3B4RFZW?=
 =?utf-8?B?QUFyME9WQ0IzN2NWQm90OEx0YlRHR1gwRllVUEZrVVRuT29lM2c1R3FtMTNp?=
 =?utf-8?B?WVZENXRJM0lrbXQ1R0FYUFFFdGtPYmxvSEYzSTE1YlpaU3dQS3ZZVmRoZVlL?=
 =?utf-8?B?Qll2WGlxcEQ4bkpRck9RSzhJb1JORTdXTXdzVzl1ekNWeTB1UVA5RkxyaHJ1?=
 =?utf-8?B?Y0d1NkEwSnk5SVRrMi91bkVBMFJaL3pFQVdLRkNzMDdSN0pnVk45alBLNHgw?=
 =?utf-8?B?UVIvTzE3WUl1Q3VWWlF4MENzQkJXMkg1YjhqbHNFaXlTTlNjbDg0RkwvQkZS?=
 =?utf-8?B?dXZoR2lrTkVkaEFKNFI3b2t5cFVlL3JHcisrWCtTTkYrb1NxTjdSNm5nUnhp?=
 =?utf-8?B?dXBOOUNXZUk2SzlOa09BcHAzWUR3R3BCOTRLQS8rdE0wZkhOYUVuRzFhbGs3?=
 =?utf-8?B?TnlBaEovb09TQmJFR28rM0g0WG9PRDFpbE5OQlVxS2U5S2RzS2FmM1VHQ2sw?=
 =?utf-8?B?QkUvZHM5aE91U3JFWUkwdk9kdktzZFdaMkhFTStuN04xd3RhNFF2NnQ4c2Uz?=
 =?utf-8?B?MmtTMzVnMUJVZzJ6VGZiNDdKUkZ1clJhS1BOSE44SVFMemVlSmFaUDMxNmEr?=
 =?utf-8?B?OERndmpUVllQcll2eThDL2pyRzhJQWY4bTU2NzdtR2VKc2lIdmpGY1hmOGll?=
 =?utf-8?B?dHprazNzYXZsR3h6Y1VackhiU3o3VHNMQ2pQRnRtLytkZ2VQWnc4OXZLNzcv?=
 =?utf-8?B?djNKRjlrS3hCcmdWMkRmUytFNlR4QUNoQzllSlVZdWNrT2hPSXVZYmZCMUEx?=
 =?utf-8?B?VHZYN1dDVmZjbnVPdC9BWFNGSk1xeGdaaGJKeWZHdGdWSEpmd1diekczWEZq?=
 =?utf-8?B?S2w0cWlhSE9OOUVGWk80SWtrb1ZLeXIvZEJ2aFA1anhKTFF1OTJhQUZ6LzhV?=
 =?utf-8?B?OWZIQUVMbkdwNWFaVmt2b3plL0Y2TGc2cjJwK1ZmeDl1SUhRbzNJMm9BR0Yx?=
 =?utf-8?B?S3ZReFo0cGpWenNkY3lJZGoxSXdpRGVhRHFkaENOTHhyMGhsS0pSVTM1YzFL?=
 =?utf-8?B?M21SbGMvMHZyMnB0ditQWVBBR3hKcFFhU1pTYTRtV2dsbEJaSUo2ZDcxbVlV?=
 =?utf-8?B?cVNqS1V4ZzNRN041NXJaaElkSkVwazVwUXhDMmdXTjlIclVQcUhYMGRvQXBu?=
 =?utf-8?B?bnhBck1CWFM5RHFEMVZRNEo3TzVBNG1yZ3l3REpRM050akQrY0Q1Rk1RZzNV?=
 =?utf-8?B?MWRDeTJNV1BQNXdZNDcvYXJWaWw3ZS91WGdaNmdSZG5LK0xKeE5VM2xBRlhZ?=
 =?utf-8?B?S2VkaHQzdkpNTUJQdVY4STF4QytUMTdrRFlyVkxJN2NNMU1XOEorTE0xcjJy?=
 =?utf-8?B?Uk5QWTlYcU95OG16VTZ3dzZBcXQzVHRKSzRKVzhoalk0dDE0cHovdWFQbWh2?=
 =?utf-8?B?dTFaMWpqUm40bFlaK3ZuRkNLOWZEbXYxKzRRS3JvQTVYRlZ6VncvMXo5VHhm?=
 =?utf-8?B?SWMwdWFPcFBHQ09QQTFnZCtMWUQzTFdEcjdCRXdaUXAzWHp3WW5nbDYwTFNt?=
 =?utf-8?B?WHZWcjV3ekNEYmR0TG84U25mSzhhNzRRSDZyYlRRMWZMeGZreWpUdUdFYUtY?=
 =?utf-8?B?STVSOXdWY09FeVBVTVl0MWtiSFVYVlBvY2xvdjVIRzZyOWM3eGxRcnI1a1FO?=
 =?utf-8?B?d0RGeERUcXVzWHhxNzQrZnRVaVNFTjgzcFpEME1LbVBUSG5tbGF6L2pMWFRo?=
 =?utf-8?Q?Nrmj4iKradqQh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVBrbWdydXBGbnNISEpYNG9lN01ITFBVOVVHQVpnZjIvdlBMK2xlZmJOUDBp?=
 =?utf-8?B?VS82ajdNYlVMVmtpY243RlFGTDJ4VUNWLzhTOXBNQ3NRVnVzM1IzMjFFZFRQ?=
 =?utf-8?B?ZTJGRDJpVVhzWWIxNy9oempPODlHcDM4dmpCKzBqbFIvV2pKdlNIUkZ5ZFpU?=
 =?utf-8?B?dnFaUEo1OWJxVGV1R0oxYUw0WUkvRmJsYi91V3NhYmhwc1U2bUVydVhHc1dh?=
 =?utf-8?B?cGNaK3MxMXMvQTBON01ZTHVKeCs4MWlTRDFYQVF0ZW1Cb3FYWVhKZTBOdUtE?=
 =?utf-8?B?TnB5ZU5yenRpYTRIN21hb3htb0VKVVBkR0RpcnNKNWdvbVBRODBmN2FNRUlZ?=
 =?utf-8?B?cHVHYzVBVVkwRE9PVFpYYTJpeEx2ckpBSmpDQVVNMmpqRW80dTFvK1ZsbnRm?=
 =?utf-8?B?eloyWHRpWXkzWDFidXZHZzRId2MwekRucWZtK0lzSnhUREVtRXZZV09pR0xI?=
 =?utf-8?B?TGl0eW40WW9UOE1LS2JMUUZ1dTJJQVFMRE4wbUFZRmNQNWJVYnhTSENZMEJa?=
 =?utf-8?B?UjlmN01BdXQ5ZkxFK25RQ1R3SWx3bW9GNzFTZ09lUzdZNnhSMUZsQUFTR003?=
 =?utf-8?B?MHZZcUZmcWY2VTBYTjBnS2pnSThtNVJNRDJHdjF1ZmRpR1pFemVPaUEySFdO?=
 =?utf-8?B?ZUpGYjc1UEVBUXA2RkcvRUFFTDU4U25xYWdiZjFacElVSEJPaVJlb25ZVjE4?=
 =?utf-8?B?dUkyd093cGlhMjV3S1FKeWdUTGw5SXhoYzVDTmNaMTc3ZHVNNjV0NFlpSXoy?=
 =?utf-8?B?RE1wNm9NT1Z3Q3lSRUFFQTI4Q0ZWaFE5KzUvUXU2cU80RWpURnA4ajk4ajVW?=
 =?utf-8?B?Ykt5ZXNleW5mUFcrN0tmWDdyL2dvdmJQNzFDbHI2NVdITXFKSVpHR1BTOWtJ?=
 =?utf-8?B?TUVUd2d5ZHpEQlBkcStFWEg2R3RoZ1pndUlVU2YwVlZBaDhjTnZ0UE5nRzVV?=
 =?utf-8?B?aDZwUXpBNXVreWRwRHJ3UzN3VmRvdk82dTZiVWFMRzl3dGM0V0JnOVkvRWJk?=
 =?utf-8?B?N3R3QzBGY04yQklYNlYwWmVjZjZWMGtjMVBsRTcrMG1QVC82Z3ltR3hhLzBS?=
 =?utf-8?B?cDdpNVhxc2JYaFBSU0NValVtTWF3SFhlV2hvK3BIRi9HQURFejlOYkpMQ2xQ?=
 =?utf-8?B?Y3Z1WlBLamorTURhNktPM3pYckRndTZWejlYdzNKaGsrOE9ncE9iNXFDZmph?=
 =?utf-8?B?OCtlOWJwRVFaSmlzaS9KUVBQZHF0WGVEb0xibWFWMmdMWTl5anJDeXEvUTdh?=
 =?utf-8?B?TDI0cFNzd2tBZnAwRjJ4a0JraHUyVTV3NVRRVUs0enR0WVRxVHFOZEdvQXBO?=
 =?utf-8?B?dld2aXhKTnR3UE5VTlQ1KytjdXdzOUdqNXNTVnVSSU13SEw5dDRzNHoyL2F3?=
 =?utf-8?B?dURXU3MwNk5VZ0JlNys1K0xIemkzTW8zNTlBdmZjRWtUZi84c0I1enI5OXdC?=
 =?utf-8?B?azFHd1Z5aUVMc1BORTJob3ZaUWRHRDBteElHQWpLQWFrd244SkFJeXZHZDJB?=
 =?utf-8?B?SzFrcnVpOG5reGNyZkNmWEMrRGRZMk9WQUNFNGhySkY0dm1PRFUyU0F2Z2lD?=
 =?utf-8?B?TUV4T2ZRSllUWFpNTzE5SGNyTTFEYStLaTA0dHpHa2FHSFN4TWxYSFBmMXp4?=
 =?utf-8?B?K2RsU1NzVllqaWNGb0RmWkhzeDJDa2QrTVo3Z2xscjBtandtYTVPemMxWmJT?=
 =?utf-8?B?TTJhVzhJdGNFM1BNck9ZcWNSbkEzaUdNTTc1TElXRlR0d2psUDV5RFRLMkFt?=
 =?utf-8?B?QVhDTHNnNXlYNlgxRXBLOS9kcll0Rmd6WDhYenNuYzE5YzhzbHlDSTlOcXls?=
 =?utf-8?B?MG1GbVYvRXBjN0Q5NGFHWUtMNUZidzVIUExIVUdmbWh4TUk4NW9vK3MrL29l?=
 =?utf-8?B?Nk5NSHg0TE1BRFhTYVVJcWhBYklRQndxKzdHRVlqcU9UcE5kZXhkVGl0Njha?=
 =?utf-8?B?ZEZnamh6V3VxczRlRld5SG5yUDZEZlFwSTlXL0ZqR2FzN211WS9Fc0JIOXFD?=
 =?utf-8?B?aFFRUWV3Sk5ybkprNWg1SGVGYlBMd3lWMVNCUXhjb2tPalU3N2dma25wWjFW?=
 =?utf-8?B?aGxvRURsTGJNWnV0d2x3elllYmJxZFJaVlBoN3pkUGZNYXhTQ3g1dkdnNWZF?=
 =?utf-8?Q?JxaYz03y13FQXgubYzWVNxLyM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 465a7f53-29f4-4540-117d-08dd613f9bc0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 08:26:38.3539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RwNfN2g4CH0BM+J05LcuY1esxyhmB8ADpwDN2+5IDjVEjaVgvU5KMKOYBaM/l4xml72h5nbEQXqZnMCg6cIj3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5663


On 3/11/25 20:05, Ben Cheatham wrote:
> On 3/10/25 4:03 PM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Inside cxl/core/pci.c there are helpers for CXL PCIe initialization
>> meanwhile cxl/pci.c implements the functionality for a Type3 device
>> initialization.
>>
>> Move helper functions from cxl/pci.c to cxl/core/pci.c in order to be
>> exported and shared with CXL Type2 device initialization.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>> Reviewed-by: Fan Ni <fan.ni@samsung.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
> [snip]
>
>> diff --git a/include/cxl/pci.h b/include/cxl/pci.h
>> index ad63560caa2c..e6178aa341b2 100644
>> --- a/include/cxl/pci.h
>> +++ b/include/cxl/pci.h
>> @@ -1,8 +1,21 @@
>>   /* SPDX-License-Identifier: GPL-2.0-only */
>>   /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
>>   
>> -#ifndef __CXL_ACCEL_PCI_H
>> -#define __CXL_ACCEL_PCI_H
>> +#ifndef __LINUX_CXL_PCI_H
>> +#define __LINUX_CXL_PCI_H
> Should probably just change this to __LINUX_CXL_PCI_H in the last patch
> when creating the file.


Yes, this is biting me again.

I'll do so.

Thanks


> With that:
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>
>> +
>> +#include <linux/pci.h>
>> +
>> +/*
>> + * Assume that the caller has already validated that @pdev has CXL
>> + * capabilities, any RCIEp with CXL capabilities is treated as a
>> + * Restricted CXL Device (RCD) and finds upstream port and endpoint
>> + * registers in a Root Complex Register Block (RCRB).
>> + */
>> +static inline bool is_cxl_restricted(struct pci_dev *pdev)
>> +{
>> +	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
>> +}
>>   
>>   /* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
>>   #define CXL_DVSEC_PCIE_DEVICE					0
>> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
>> index ef10a896a384..f20df22bddd2 100644
>> --- a/tools/testing/cxl/Kbuild
>> +++ b/tools/testing/cxl/Kbuild
>> @@ -12,7 +12,6 @@ ldflags-y += --wrap=cxl_await_media_ready
>>   ldflags-y += --wrap=cxl_hdm_decode_init
>>   ldflags-y += --wrap=cxl_dvsec_rr_decode
>>   ldflags-y += --wrap=devm_cxl_add_rch_dport
>> -ldflags-y += --wrap=cxl_rcd_component_reg_phys
>>   ldflags-y += --wrap=cxl_endpoint_parse_cdat
>>   ldflags-y += --wrap=cxl_dport_init_ras_reporting
>>   
>> diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
>> index af2594e4f35d..3c6a071fbbe3 100644
>> --- a/tools/testing/cxl/test/mock.c
>> +++ b/tools/testing/cxl/test/mock.c
>> @@ -268,23 +268,6 @@ struct cxl_dport *__wrap_devm_cxl_add_rch_dport(struct cxl_port *port,
>>   }
>>   EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_add_rch_dport, "CXL");
>>   
>> -resource_size_t __wrap_cxl_rcd_component_reg_phys(struct device *dev,
>> -						  struct cxl_dport *dport)
>> -{
>> -	int index;
>> -	resource_size_t component_reg_phys;
>> -	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
>> -
>> -	if (ops && ops->is_mock_port(dev))
>> -		component_reg_phys = CXL_RESOURCE_NONE;
>> -	else
>> -		component_reg_phys = cxl_rcd_component_reg_phys(dev, dport);
>> -	put_cxl_mock_ops(index);
>> -
>> -	return component_reg_phys;
>> -}
>> -EXPORT_SYMBOL_NS_GPL(__wrap_cxl_rcd_component_reg_phys, "CXL");
>> -
>>   void __wrap_cxl_endpoint_parse_cdat(struct cxl_port *port)
>>   {
>>   	int index;

