Return-Path: <netdev+bounces-146507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBD99D3CBD
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 14:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C0D32824FD
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 13:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833181A4F02;
	Wed, 20 Nov 2024 13:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wIqKmwvs"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B664E1A2C19;
	Wed, 20 Nov 2024 13:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732110713; cv=fail; b=Fgh0zAJ83RB0Oh19s0w0Nw3zbMWmPMyEtRTgH+0sdpRbf7Bor3CeSp6SXlrRLXWFrDdvZc4c0n5AwQpC+7KAbtmON3wVbdDfqqE1TYGFLMVyEon9qN/zCnFfxX8KKsPHx+h8IDBXQesIcYzzaLo5XRZBMPR8uBe+kqKekFWmfus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732110713; c=relaxed/simple;
	bh=dbrK/ldyRO99a3OomRQDDHrMB5v/BU5EVkOlUzd/Dgk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n0DA4E/WDDjBgM9dFN+8TnUB4vs04SSpKJH0mTL2fbWS7BC8Z82J/NqDb4GerLzQCyOj9pjdgvIUNiZ3sZ9O94icC/ZOVJlWFSD60BuqbdQiD3jmXhNKj2RVpNgQ9RHVsk558kWvTt8Wc89O/uHOui/GkNxPs0FJFRK8HAVToTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wIqKmwvs; arc=fail smtp.client-ip=40.107.243.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M+kDmUjEOoJD21hmduyESv4zIPtBlBgH10jQc69uXWrx86905LV7lFlsjpQI5K71Mki4UIJn0a6hmVmvEDbBmVkDamXzK7jKaUAjdmQ+h9giT91/80ZVxqMLH3D8xQWT3MaNoAEFJsZFR6eECngdQ4k03a7bnlbDXqRT5m3z1We+btCYsBf2GC+iC0p7d1dVnZRa2FC62HuAH77Gfon6pSy7PSrTMX9BqUGjKtxGN4o9Wms8/qCnf82Z7g5rtlj3WTjKZ7Ww9dCl4D7rcdx+buBCcLJTNcoPbLENNiqtjUE/JrYiR0F61i1/BXH2JlZ2KfJ3o+G3YOKYiNqh9lWFfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bG3BAs38EvOAP7XaacTYfZHuKGr9gzki9Lx/LI764ow=;
 b=ncdebB72Lj8uMsTSGw+7vMJbZBd2pFKOprDfUVOO+bTnTGkXG3txBofnPwlA5H4zkRirfx6+QwmHQ1HDOpxVw3fAL0/dXJotwEraG/7dp8BIU2S08LO62VWstUc/FMP+QMsgQUx3SpA004HrbUHafS2+TymxKdHrrS6lHVvNfAK/lzQlZ4OhCd2/0o0dSkJkv3SCzjJHH7Y6PEwc3c+tPRgxGzTEI/r+7fnxxq7IZilmObc8Vivm5LQH3MFcRbHAwUBva/8XGhiW8y73EpHEmIf5mWAU7uKgvHadmGvQHd/G602Z8DBYnQqTKc8N9E8+3DKs2vNMl5vutdvsDN86xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bG3BAs38EvOAP7XaacTYfZHuKGr9gzki9Lx/LI764ow=;
 b=wIqKmwvslJBa3xcbULpOpkOKemkxtsaaHuwmOWAOk7fAsd7IycGOGy6y8X3CYaOItUwKN32OdZqO6xs/3eWJ6+wdTuOV8FqtTxD6NlwIxggEZi1uqap9Y4CWd3EWxWGPAAXZOyDL3vuX5Ry0XQS+G2eHJbeD5aZzpAjB8SawWx0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by BL1PR12MB5755.namprd12.prod.outlook.com (2603:10b6:208:392::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Wed, 20 Nov
 2024 13:51:45 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 13:51:45 +0000
Message-ID: <904b31b1-ee0a-542c-a99a-8a5ca38bec77@amd.com>
Date: Wed, 20 Nov 2024 13:51:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 22/27] cxl: allow region creation by type2 drivers
Content-Language: en-US
To: Zhi Wang <zhiw@nvidia.com>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
 <20241118164434.7551-23-alejandro.lucero-palau@amd.com>
 <20241119223705.00001c1d@nvidia.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20241119223705.00001c1d@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PAZP264CA0232.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:238::8) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|BL1PR12MB5755:EE_
X-MS-Office365-Filtering-Correlation-Id: f695f903-9395-4b1d-2f70-08dd096a7862
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eGpENTdQUE8wck9reHA1UXlnNEtXaHZqUjUrMXA1eDB0bUxXY1J3VXRua2pN?=
 =?utf-8?B?Tjg3M1BLY3MraWZqNFR0R0RYYytYd0ZMMzFBUWtMdHJRYmRBcU1KbEJnTmJX?=
 =?utf-8?B?bzc0WkdlTTJ6djFEZW5CSVdtTzV1RlBYL0h3dWFDMmg3TlN0SzZIWFlwR2hq?=
 =?utf-8?B?TDBUNjB1UjM1YjYybCtvcWFlandZY0Q2MXBaNjhxdGZKa0RkUmRwaE56SjNR?=
 =?utf-8?B?bjVlOGdSL3lGbnZrckRTMG5CYlJtNGptZjA1Nk1jdGFZVjIzT0FkcU8vU1I4?=
 =?utf-8?B?NFBFeTFuck5naDJoRklLVTdEdTN5ZEhVQ1dWUUxWNnIrbWFKYmx0dHpDdXQr?=
 =?utf-8?B?dVBxRzJWVW8xbTROWmEwRmpzWkE3ZFZINzYyUHE0RTZJMVRHdFZYWEx3cnho?=
 =?utf-8?B?NGhSMlVjdkdzZVg1SklPM1l2c3R3QnJVaTZuS05XMElxNDFnQnBOTVNEOG8v?=
 =?utf-8?B?b2ZUcmt5ZUtWVDF0UkhDZnEwMmpVbVJSVnljZlE1N1ZOZ0hKRTJHMWVzZnNI?=
 =?utf-8?B?RGloN3V4ODZDYnJTUmowWnNpMGxRS2IrWHhhMTZFdjNEL2RwM1cwU3JOOFIy?=
 =?utf-8?B?T2VHWXFLVDd0elN0YzhEeG80YzlsVTlXSTVMeGRQNmp6UDQ3YmVjTVNTd2xF?=
 =?utf-8?B?cGl2TmlQQlIvbStrcmZyaWtDOUtHckxITmM4SjBwYjFMdWhNN29qdnowOWNT?=
 =?utf-8?B?b3h3bHI3eTN2eUNNNnhoQ2Y2NjRKTmIvYktzdFl1OHNCT2ZSTVR6R0lRRUpq?=
 =?utf-8?B?bnFIVkdNdU15c240cTZEajk5SEJaZWVUQUFtemhFZ0dYTi9KbTk4V3IrcmV6?=
 =?utf-8?B?bVR0Qkljd0hGcUlramJUdHJMdGpJLzlGTFl2KzYrRDcwR2FvS1pnZEJ6cFJv?=
 =?utf-8?B?anJFTjM1L2cwTENSTGsybU45aGNwYzZ4WXF1b25sRkN3Ukp1NTVrNnRRc0lh?=
 =?utf-8?B?RjVBY21GMXBObW0vOVZycG91Q1FvdG0zM2xDTUl3UUpaRVo1cERqUzBSNEtM?=
 =?utf-8?B?dnN2L3lJaG12dmw2bW1zb3ZTVW9RUmJYYWUybndJKytuNk8zdDZ6djQrYVNn?=
 =?utf-8?B?Sk4zUWlGOStzSVc3cmtGc052emdhVnBSMGIrbFdtN0dTQmlyVStzYjNaVUlR?=
 =?utf-8?B?UTdoSHFMSFNkZmROSjk2emNyYjBUaklzSUxad2ZoVW1kNlJSZ3lZcWZkdmNJ?=
 =?utf-8?B?Y3M2VHNvQkcxc1FMeGo5eFBzS1NGdE5vSS8rV0xXM2YvTmJhRXVGNlphUHoy?=
 =?utf-8?B?UzE1YjIxd0k2c0V5WXZTb08rQzU0MkJHTzhvSHJtN2d4a0Q1SWswekcxR1RM?=
 =?utf-8?B?Q2ZNb1Z1eDNvRFBqZ1hEYW5JUVhWOWlMR1NKRnVKWURnNTF0SS9MOEhVaEFn?=
 =?utf-8?B?dk5yZ1lPbmNpYnE4aitjY2RxZzFoYk9ycXZqN21zdEJZVzV2SVhrbmJmQ2Yx?=
 =?utf-8?B?R3FTTjlCYThHRTFlYkcySldCK2lqT2NGT1B4YVd2c1NqcktFV3lFSTFTZnRK?=
 =?utf-8?B?ZnZqK2Qzd1JzOEtzVXlEdFBJc0RodFlBWG1sZWVCY2FPdnNkaG5LVzVZbDhD?=
 =?utf-8?B?RnRJNXJ3RXdOcWlOWHNobk9ITVBnbzJIMjRuUDJiaUhNd1RZTVdMZi9Sby8z?=
 =?utf-8?B?ZWJHckR0T0g2R1l4Yy9kR3gwNHgrYjVIUmlERWVNblU3VWNEcSs2alJMZERS?=
 =?utf-8?B?N2E1YzNYaXRoREhOY0xnWFJ2WHJicW1sNkNzRmtFaEdXT2U1SjJReW9NeWZR?=
 =?utf-8?Q?K8tfqYOK8Bf6xjtVf0riThtRCI7G2f6RHGbDOOZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGFyNTN2Z3dwUEw0a3dzM1FxUGh2U1REN3RhQjNnM3JnY242Q2hQUkZNL0lP?=
 =?utf-8?B?eWY2RllwSGU1SU1aYWhzTFp5aVplamJKb0JMcys3SHErWVhnYy8rbjF4dEIv?=
 =?utf-8?B?SXdxTUdsMTFrQ28ycU0zN2NzWU5xRzNmQ0xQODkzN1RLd1N6b1FZcnp5cTJQ?=
 =?utf-8?B?YmJEVXo0N1prNXpPV2l5MTRFMllKWXlqRzRJbzRwRFZ4d1lCbjRpVXAzMFlu?=
 =?utf-8?B?ZEdUREwwUS9RWlpxalhsR0xyczU3RDFXZHlXNjlMNnBiZStNa2xjMk05d0JW?=
 =?utf-8?B?dDBBRE9QLzBpODRHZ0xPRVE5Y29LOFNZKzhoSFFmSHhyYnN2REZ0c3RCdVk4?=
 =?utf-8?B?YTNVNFlwd2pudmgybXdDTXNtVE5zcXc2b0RYNVVDRW9yRVNtTGdOeDF1eEFy?=
 =?utf-8?B?SitRNjVRQ0NXNlV1ZU9zd0t4RFRQY2JBSFh4cDJBeWpUWEwzTkRTaFNET1pQ?=
 =?utf-8?B?UHorQ3ByNkpZdysyWk5ybDVUZ3dHQ21OWGVzd2xYOWxzOHZiL1U5b2xNSkJB?=
 =?utf-8?B?U0xMcXhuR1pHc2Q3dVF3WTl3R0NXMlg4NW13a09TYjkrS0tKcnZEeUQ2SllZ?=
 =?utf-8?B?UG8vV0lMSmhIcG01VW9FRHdqNE81TzZSZVgzTkdkUDRCdnVTRlRvd3BVYWhU?=
 =?utf-8?B?aElmMEE3N3VvZS9LRHpzNWNGcitMZUtESkJJYzlscEdLZEFoMy9vN2NmMGY0?=
 =?utf-8?B?SE1pSDJiUHZvajV5VjlEWWQwTm5UV2grTHVXbUxNZ294RDU1cVhmVkRkdlg1?=
 =?utf-8?B?aDRHZjU3bmJXL2RPTklCbzhuMUFSNFBmanIyZFV2WnorL25UWU94eFdiRmo2?=
 =?utf-8?B?M09xbUVFeUQ5ZTcrSmxoRElXOVhTMkZWcjlSRjBJVGd1U2UyVFFOWndZTjY2?=
 =?utf-8?B?bHlVaFZDVlVVa1JvbnF5L2c0MDhXWkhyRFlmRzIxMEM1bys2VkJEQnpoQVEv?=
 =?utf-8?B?WC8vbU5mY2IxRktsT0Q0SnNIQVZyWFJQMTJYQ2w1aldZTXhoS3N5MkxGZnBl?=
 =?utf-8?B?aHN5enhTaTdqOW84SXdvTWF1NVM4TnlHV2RrMDF3cUR1Ty8yVE1xWm50ZVpN?=
 =?utf-8?B?N1p3WldBeFZCTVNBV2Jsbkd5UVpsTHJmN3o5Q1JNc3JsTGhxQU9KaTlqWFBw?=
 =?utf-8?B?bDBORTJuNUZYNU5LamtqeSs0N2hGQ29BTDY3RjJucmxXTG40enRiL1Z3MjBa?=
 =?utf-8?B?elIwTmFVV0RwVm5yQW9UaVdRREtKRHNsYTlCYUhGZ2NWVlFTMmxYa3RBbWhK?=
 =?utf-8?B?SG9TdEVDNnZzMWNMTGdsNm5ZZ2s3REpLVzNyV3k5NjZ2Z2xEblo4V2J4V1lE?=
 =?utf-8?B?NWFmV0VUT0FhODdzR0ExdHNYbEoxc1MwM24rekFRK1Y5KzBRSXFTSVFJNGNF?=
 =?utf-8?B?Ujl6UThQUlVTbUZLRE5FVHExOFZPMFFlb213QTF2RFhJVVZrNVNTNkErUGdF?=
 =?utf-8?B?YmNxeVhuQzdiQnJGVEFzd1hNVVRTWHBlc2x5d2dZOWNjSk9MdG1uekxrYzFY?=
 =?utf-8?B?SS9GUjlJM3lZVkxBVmF6MFZ5S2R3dnA3NG1tVXlabGlhQ0lCeHY4TFVZdjVY?=
 =?utf-8?B?cHN2WEE3MkFFT0xoTkdPR1UwRXdMbDR4SGNHS1FWeGRhVnB6QWFGejZXYkFt?=
 =?utf-8?B?ckZCS0xHWlRSR2VSZjBRVHh3MXNudWNBaWdlNUMzcGN6b1oxTjRCdDZIZUtJ?=
 =?utf-8?B?R0ZKVnA1aWNSWTZOUUNIcDBFMFFjYTFLTDdTRUVaWDhyYk5rK2lCSE0wMjhw?=
 =?utf-8?B?SFdZZXQraEt1ZWZmUWFySVRMdUhuVmNPMHg5Njh3eGNYRXhTRlB3RVV5SEdJ?=
 =?utf-8?B?bDl5QUpFMVF4R0hjSlNqazVJbVRXWHlsZW1aRFBMeGVFLzZhR2N4YTllNmc3?=
 =?utf-8?B?M3h3Z0pXeFZpSGVoZ1h1QjFkSDkwdzRnNzlJUUJBUnUrUHJGcmptZmdxUUpO?=
 =?utf-8?B?NGI1V1VFRzVNM2NTengxMkNuL251MXAxSlhTa0tDUkUzbk9wZ2k5MjJON0Fv?=
 =?utf-8?B?T0V5N1lCdkg0RnFMYzRHeGRKRm5jTHlOU09heGN0Tmx3M3RIU3RUZXlkVHNB?=
 =?utf-8?B?enVkbjlQci9ESGwyVFIvdnhDdDYwZ3liZG10c0hZWENXYk5xaS9lemNvSGpo?=
 =?utf-8?Q?De4T1eRbshbR+wfo28YRP6zP7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f695f903-9395-4b1d-2f70-08dd096a7862
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 13:51:44.9521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v0EUX+TMz84bSHH/c3vfWDAgrm6rrZF3B1UWaz0I2gRxex9sFxazIbxfxMM+lgGluy8+rfPq+fSNqnhP5XGaug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5755


On 11/19/24 20:37, Zhi Wang wrote:
> On Mon, 18 Nov 2024 16:44:29 +0000
> <alejandro.lucero-palau@amd.com> wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
<snip>
>>   
>> -/* Establish an empty region covering the given HPA range */
>> -static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>> -					   struct cxl_endpoint_decoder *cxled)
>> +static void construct_region_end(void)
>> +{
>> +	up_write(&cxl_region_rwsem);
>> +}
>> +
>> +static struct cxl_region *construct_region_begin(struct cxl_root_decoder *cxlrd,
>> +						 struct cxl_endpoint_decoder *cxled)
>>   {
>>   	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>> -	struct cxl_port *port = cxlrd_to_port(cxlrd);
>> -	struct range *hpa = &cxled->cxld.hpa_range;
>>   	struct cxl_region_params *p;
>>   	struct cxl_region *cxlr;
>> -	struct resource *res;
>> -	int rc;
>> +	int err;
> maybe let's keep the original name "rc".


Note this is a new function. It comes straight from original Dan's 
patch, and I think he changed that as there is another function doing 
the "return call" which invokes this one as part of the call.


>>   
>>   	do {
>>   		cxlr = __create_region(cxlrd, cxled->mode,
>> @@ -3395,8 +3416,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>>   	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
>>   
>>   	if (IS_ERR(cxlr)) {
>> -		dev_err(cxlmd->dev.parent,
>> -			"%s:%s: %s failed assign region: %ld\n",
>> +		dev_err(cxlmd->dev.parent, "%s:%s: %s failed assign region: %ld\n",
>>   			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
>>   			__func__, PTR_ERR(cxlr));
>>   		return cxlr;
>> @@ -3406,13 +3426,33 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>>   	p = &cxlr->params;
>>   	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
>>   		dev_err(cxlmd->dev.parent,
>> -			"%s:%s: %s autodiscovery interrupted\n",
>> +			"%s:%s: %s region setup interrupted\n",
>>   			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
>>   			__func__);
>> -		rc = -EBUSY;
>> -		goto err;
>> +		err = -EBUSY;
>> +		construct_region_end();
>> +		drop_region(cxlr);
>> +		return ERR_PTR(err);
>>   	}
>>   
>> +	return cxlr;
>> +}
>> +
>> +/* Establish an empty region covering the given HPA range */
>> +static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>> +					   struct cxl_endpoint_decoder *cxled)
>> +{
>> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>> +	struct range *hpa = &cxled->cxld.hpa_range;
>> +	struct cxl_region_params *p;
>> +	struct cxl_region *cxlr;
>> +	struct resource *res;
>> +	int rc;
>> +
>> +	cxlr = construct_region_begin(cxlrd, cxled);
>> +	if (IS_ERR(cxlr))
>> +		return cxlr;
>> +
>>   	set_bit(CXL_REGION_F_AUTO, &cxlr->flags);
>>   
>>   	res = kmalloc(sizeof(*res), GFP_KERNEL);
>> @@ -3435,6 +3475,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>>   			 __func__, dev_name(&cxlr->dev));
>>   	}
>>   
>> +	p = &cxlr->params;
>>   	p->res = res;
>>   	p->interleave_ways = cxled->cxld.interleave_ways;
>>   	p->interleave_granularity = cxled->cxld.interleave_granularity;
>> @@ -3452,15 +3493,91 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>>   	/* ...to match put_device() in cxl_add_to_region() */
>>   	get_device(&cxlr->dev);
>>   	up_write(&cxl_region_rwsem);
>> -
>> +	construct_region_end();
> cxl_region_rwsem seems got up_write() two times. Guess you should remove
> it like below since it is now done in construct_region_end().



You are right. I think I messed up that with the code below for handling 
a potential error.

I'll fix it.

Good catch!


>>   	return cxlr;
>>   
>>   err:
>> -	up_write(&cxl_region_rwsem);
>> -	devm_release_action(port->uport_dev, unregister_region, cxlr);
>> +	construct_region_end();
>> +	drop_region(cxlr);
>> +	return ERR_PTR(rc);
>> +}
>> +

