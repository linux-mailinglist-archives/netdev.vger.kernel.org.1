Return-Path: <netdev+bounces-245375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B50CCC7FE
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 16:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7208C308B350
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 15:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5063325483;
	Thu, 18 Dec 2025 15:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TPDlriVI"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010028.outbound.protection.outlook.com [40.93.198.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DAF32E699;
	Thu, 18 Dec 2025 15:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766071660; cv=fail; b=E0X/1dlNKiwH9f5S9bw9CeWr0ZiZ4nH7MtmWmp2T3PW+fP2s3k6NIZnAviO+dOVas3ur8w19i2ELLeHsD/jlf9xId/S0Xisk4/+mhM47SS8c0tSiw/uVjMUjiK3GvWsd0WXh/rz3ziOuK68S/Vb9Fx1F0QKQDmA4llm+/mu/d4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766071660; c=relaxed/simple;
	bh=8VIFnRomPbr+6GvjqsNDInHs3WB4+aT/7HArB23h+cU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Qvc9dAmy+GnTu6rVFJep+P1rslLwKST1++p2U6A5sPKeaxGLOygEflKZzK65WFtCOgYyiMMLiuSivOgy46UKvtL23veDOcFf4Q+HGOzT5VjCLg7v3HafnxHIcry26KqcE5nto1rERqFqxbrs//DX2IM92HE2N232KuUec7I4/uM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TPDlriVI; arc=fail smtp.client-ip=40.93.198.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cs62ydxA279y1d++a37wtaxO0Eq8iYga3MVF+gRJLiSkghar+k2wtd42OIKt9kMsHzWlUsgp7SWIW8fdHayX/wgD++U4J3jtlHqFjaiJjVGBIThc6OttfrQ38uuYSaSI6XGSvLdFWnk5RTnC2Tt8tbqYEvF4d1T2ZVdHmMU3TN9v6gfhyX9o7rlYwUL+7H2QSQXH+IqitW100YhoUPFxGecw9uCosxBLAwOwNByzV/Rxe+ujb2401ZrIXzZ4ZdFKk/FwLFM8DPrMeSSGuJjjMHMZzwohOOuivUTTw4SFnGRHmpMBISnbof9EY5XJxWeapVAzsQQ5FzY60CgTIx/Nzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F2AWUba5bvXdY0oi55E6M+w8yJwDuHJSUA0YBX6UA/g=;
 b=aGnRKWz2swDCFWSRjTo3oxUqvCwgsOfVbPD4Ysc8unpbfmgDfAVEylBQgiMaIiIQTTTjooIDDWSMuIRpzgiBKDvrylHUIe1JIj/OX8x2qO7rIrO32bf+1usP7GyOPb2m9FB4v9UCkKsCG2hT7Hbb/3VHaDlVSMrhel9LJse11VLvlTCXUR8RulFT+Aep7BRvXsMoW1gB7IiwUJ1rwBX46E+ftF/F1QyMDBSRljstuDm/XCu+Z9A0yBXo7w+Xo2ZSqx0hvOXzwmC5e+kV8b89WRMDIQlCHN9Z/g2smP9AxTTgygOa7sVqwb51Gxxx9yfReaWmdQd+hULuB7lUGl0eVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2AWUba5bvXdY0oi55E6M+w8yJwDuHJSUA0YBX6UA/g=;
 b=TPDlriVIfi622tn9JnXivKjKG3mm2SabC138S/iutjDojkpcZADaKlRYaRsGNpoHsTCCtqZkLDOcfH4m+1OIGO5i4qtkxdm8nT0TIbvk392R7QUCmMLhOeH8JIxboWmjeN0h8SoaypIhYdqLwQR0JRK7HgNRX37DOZx6Iz9zlT0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH0PR12MB8098.namprd12.prod.outlook.com (2603:10b6:510:29a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 15:27:33 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 15:27:33 +0000
Message-ID: <1e98adcc-feeb-41cb-b1fe-618597cb0be4@amd.com>
Date: Thu, 18 Dec 2025 15:27:29 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v22 11/25] cxl/hdm: Add support for getting region from
 committed decoder
Content-Language: en-US
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20251205115248.772945-1-alejandro.lucero-palau@amd.com>
 <20251205115248.772945-12-alejandro.lucero-palau@amd.com>
 <20251215135047.000018f7@huawei.com>
 <f56f7a6b-7931-4264-8d42-50603ce81cba@amd.com>
 <20251218150309.00006837@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20251218150309.00006837@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0261.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::14) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH0PR12MB8098:EE_
X-MS-Office365-Filtering-Correlation-Id: ede855a4-30b1-4aea-ce37-08de3e49f73e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L3JyM0MzdnRuTkQ0Ri9CejVmdmNOdDkzdnB5MnVJZ25ZWGZtVXZpK2w1RUVs?=
 =?utf-8?B?NXZCQUEwdGxKMVJ5N2lJUWJ2RGp6K0pPYi9jSW4yMTc3cDNONm0zblFhUk0z?=
 =?utf-8?B?MTcrMG9HdU1xdEdMSUNmYk1odjgyZnN6emZFL1BkYU5VS0hxK2VHbUpGaCtI?=
 =?utf-8?B?NnZuZVIvTFBhL253RXN1d0NYRHpDQXNyTFR0WC80WU14eVd4R1dhV3NsUmhW?=
 =?utf-8?B?WHhFU0ZrWG9HeTI1QnFrMU5sMkxRUmRxRnFCUWF6ZTVhTFlvTklVRk9tN0ZC?=
 =?utf-8?B?QkJEL3YwN08rcnZ0Nnp5VitCRjZnNVdFdERzc1JCNFRMUGIrK05JVXUremlP?=
 =?utf-8?B?K0U3bG1rMENHdmFqb01odHBmOThGTUp6OVRDZGdoRG1kbERqcXJwZEV4UEJw?=
 =?utf-8?B?dE9TRVVJWW1yOU00Y1JpcFZFUU9hV3VUTkp1MFNYWEFUVHdDK0xmQjdmUmhw?=
 =?utf-8?B?dWRON0dCU1FSQjJ2SGkvQmhHZFZDZDBJNDNnK0JqV1Q1MmNEclpzRXI4bi9U?=
 =?utf-8?B?NmNlK2FBUnR3SktnMnVRZ3ZDWnpxM3JuVHpZV2RpbHBVMGFsMk5qQ0pGN3lD?=
 =?utf-8?B?Z1FxOHZXc0FJc01wQUVzL1NabXA5SjBwUXRWUDdBcm1DZFIyK3FiWjNJVWhJ?=
 =?utf-8?B?ck1TT0xTSmpqNEZCZFNTNXlEQWpGU0hWV0txeGVwaGhzN2MrYzhXbmtEQUJn?=
 =?utf-8?B?M2hTNVdSTjNuM1g0U3hlUGMvWUdvQ3B5cFlsc0JsYlFqL2pRNGhDL1Z6dmdN?=
 =?utf-8?B?a3NJQlh3U2ZiSWtVTGliOEpWTkJaOGRMRkJxbzMyV21iWVRwa2YzVTJwVStV?=
 =?utf-8?B?VlVrbGxqbWp5SGxWYzh4ZDdzNGFrK0lVVUpSVkJrOENqUEtWMS9FbStoTXEz?=
 =?utf-8?B?d2cvNjNleEhaZjVSSm9pSE9qZDZvbVFVVXNvVFVQcGZuS3pqOXdGRWc1em90?=
 =?utf-8?B?QUtXN1F1bjM5VGJTZmgzWlJVb2M3MEVLUVNGV2FLd3YrVXZrVWlmQU45bjda?=
 =?utf-8?B?WjhDUTBtejNTaEJvUUZ5aEorR09CNG9GRWxqRktZR3BmTG02UFBMbEg2ZHVP?=
 =?utf-8?B?TDlnZ3pqNk1QbnRkdDJNQ29VVDdlOS9DdDZZb3kzUDhDYUp1MWo2QXExandF?=
 =?utf-8?B?UzJva3Nhc0NaYzVLSXNnZmJrd0ZxMGJzSEZmTWlqVjg5UFl5SHJQcHlKSWY3?=
 =?utf-8?B?VElzUkhBcmk4NHJZWXZKdjZ1ZGpUUm56STF6RjdwakZLeUtubjlPU2xSS2Ny?=
 =?utf-8?B?RElNWStDT3NFbXNLZzV5ajdKNWdYWlU5MjBjY0lVa0ZVLzJJanZPb0J1UFJv?=
 =?utf-8?B?ZHVIeENFdCtBdUx6V0dCRHg4QXVUZVZwZUE5M3p0ak1XT3QzWWRqOGNFZWkw?=
 =?utf-8?B?YUZ4QTFjZDRZOEg3WlkreHNwaEIrekx0TkpmL3lLZ2tTZUJhOVdReUFoRmhn?=
 =?utf-8?B?dGJHRlRGd0gwdnVOQXN2UnVzQWhDQmwvR0F3UGxVaVJyYkN5L0ZYa2g3UVZP?=
 =?utf-8?B?Uzd1eFBkVWlRNUo1dXlPV1lGYUFUZXk1ZGlvOVZDUVFvd2VaK0syYTA4NGtt?=
 =?utf-8?B?VXViWUkzYjZFU010b0d2Sjh4cTJTN1o5djJ4U2NzTVhGNlhOdEJRSTIxWTFO?=
 =?utf-8?B?TmRaUGQ3NnE2SEVaTmkzQklaNUJNOTZlaFRaaDNudk9GQm5xZE9rQnYxS1JH?=
 =?utf-8?B?WlhESEVUY1NQTCtlQ3EwamE0RUhmS3NzVnNFUFMrWTR0anZXTmF6eUpVNUJ0?=
 =?utf-8?B?WHpvNXFTb3IvM01sSmQ3QVEyemJCSkhNT3FzT09MSW5mSmF4RHRQWkxSVGtU?=
 =?utf-8?B?OUh5b1pPYVdtdDRpeXNIVDB3ODBWM2Rxc0JhNXBFMXJrWXdzaW9Xc3RnSGd4?=
 =?utf-8?B?YUFLQUg5UVBmWERnaVhDQlBSSzhyQlZpTUZabWcwZHJVdzVnYmUwNnRsK1ZT?=
 =?utf-8?Q?GWuP9+yvpi2Iv4+ev9odZ6nSEI19SwbX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1NKOWp5ZnZHOHFwaGRMLzJuUzM1RjNIcFhyaGxGaGVPeFVmMU1qVVc5OXE2?=
 =?utf-8?B?empvcTRaREh0VXp4dUpBV0Rxc2JrZE1QVzM5TC9WNUEzNGZwbnMrS0M4ZW5K?=
 =?utf-8?B?aTJIcFdCQ1p0eFFpR1IxM0FjeUtMUkw1UEtjOVNTdldOTUV6MithbW8rTTcv?=
 =?utf-8?B?ZXRGSDZ6VUsxOUQxa3NYamsvbjgvSTJhbzREbXMydnJ5a0N6VllHS1JTSUhL?=
 =?utf-8?B?Vm9xL0NLSlFkUkcyaDhlYklrSk9yYi9tWGRtUmlVQTJWZ1V5cE45SC9PVStQ?=
 =?utf-8?B?OVZPZDU2M2hhUUdBTE8zTWRTcktGdm9ONDlXWmowb2V2WU84SGw5eTNkZG50?=
 =?utf-8?B?QUVBanVkWm82K0t5L0dpdUpjMyt6bkZUS0FKaXZEdER1SDhDdzFvSjFFVXVn?=
 =?utf-8?B?QmpXbWMwaitDQ1NRd0lPM09hS0hGZCs0M25FTjB5YytWc29HSzBpSnoxN0Zv?=
 =?utf-8?B?NXhGWEorYU5iSlVvMDhlOWxISmpjS0pLbm1CYWpXWGtCWGNpR2h4N1FpOVpU?=
 =?utf-8?B?NTQ1NStDU3phVnV1Q2pZZlp1cFhhZXhZa0tJUHlrN1c5VDQ1S3ZZNVhXRnNv?=
 =?utf-8?B?N1k2U21tQWUwWGorU21yc0hXNzVVN1RwenpRbnJDblEydS90TTZBdW04amNh?=
 =?utf-8?B?eVArd2RDblE1V3FWTkhndTlRb0Z1UkxlUi9lWTBLMEJNSVhBU0xndXJSNEZY?=
 =?utf-8?B?T0x1bjNFZ3hOZkdaRmFRL2FZVEJtMGxhdUhjS3YyTDNqR2ZKVzZ6TTROY1B5?=
 =?utf-8?B?TVduZVQxWXRHcThSU2ttWU8zTW5CUnJrUnBpU1JGYytLQzdqZUplYWZTQVhX?=
 =?utf-8?B?NzRVL09EZ3hiQ2FiM2JkZzhkRG9qdmtLQzBVSUxtamtZZnFBRW83U2lNTmh0?=
 =?utf-8?B?OFhENk1mRWxKZmhieS9pQVRqWFRTbnJZcjFMa0ZNbVA5RXl0RFlmWjVnWVpN?=
 =?utf-8?B?MFF0djc2aGJvQnRmMVNRenBzVDhlb1IxNEtQNEZCMWJ0YzhiV2lwRkxPakVj?=
 =?utf-8?B?YlJadytHOXRUNFZNNHl5N2svS2JnRms3MU11V2xQQVZOVmZodVhnNGpXVDQx?=
 =?utf-8?B?WjRvRXVnZi9TMWZnbjVDWWJYNmlKbkV6ZUo3SUYvSDRNRjNVWXhvQ0lJM0J4?=
 =?utf-8?B?am5yaS9iQm9mdWR6andzek1ING5YQzdZMldFSUkzdHFIWHd2aHViaCtNNktC?=
 =?utf-8?B?d1pabnFJR3FlTVBjNG9TRFgvTmpwU2w3QUZhL1ZmeVE2anNidDcyVHhCZm1W?=
 =?utf-8?B?WW02cUVuV3U5dGtnSGxVSmp6QVh3OHRSV1RoaDdGMllHOExLTkozdDY4bHlG?=
 =?utf-8?B?dENMUktnY0VZVzliMUt2MHNUWUVuWkQwaG5WNThtRmVwZWFnVXA2angxVDg3?=
 =?utf-8?B?TUZPSjIva1BnaUlncVoxSWQrN0pnU0xWbVcwRGJlQzBSWllWOUpNOWRZNjJB?=
 =?utf-8?B?SzJNQmw2RHNaQzlvcFo1Z0M4RHVLNUFlR0NlOVNaaEZ6QWFwckhNMkF5czIr?=
 =?utf-8?B?L3A5MjlEQ25nUHl2N3ZGSzBlUXFuL0JIMlk4TTlyYlJJY2MzakMxYzRGWlFB?=
 =?utf-8?B?NnJjejduSFBNMFpiMHljM0dLVDZKNE5mK3pEM3F5QlNqamxsTzVydktIUnBX?=
 =?utf-8?B?R1NpYTFBLzc0M0FaTXB1SEI4NFA5WjBiK1c0VElhVk5HMmp5ejBSQWJGS3FN?=
 =?utf-8?B?YVBON1NSTmRIeXB5cWhMTnRZcWxva0poalIxak0rako2a2ZacGtFNTJHVFJ3?=
 =?utf-8?B?a0dSYzczRVdHSnU3bkFsNVRFUWllMzhUemlvVGpzb3VPTDlwWmVSM1lqNVdY?=
 =?utf-8?B?WlFQUDRDVkUrcW9ZV1VCR0pCYW9zNVpuUnp2THZCSHArcFdoSS9CZU14OHVv?=
 =?utf-8?B?QW12aHFjWEduUGlacDRVb2VpS05KQlk0UXRqcTNMV1dYVHJYdTJsSmRLRUFL?=
 =?utf-8?B?WlJ6eG8zdWN6ODNBSHZZWXQ2cTl4SjZaWUU3QWlNczJ0czI4elExaGEzWXl5?=
 =?utf-8?B?Y2JxTitIaXhUbnF0cFcwNjEzMFFjNmxQRDJzZElOS0wvOUxuS0J1TFhEeWlt?=
 =?utf-8?B?TmVkMUF2anBpcWJPOVg0aGh3MFpUcDdwOXRFZFhwYXp5VUFJWks3OWQ0MG9Z?=
 =?utf-8?Q?XeWO/uUWutaKBUJsIgPY+H7FO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ede855a4-30b1-4aea-ce37-08de3e49f73e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 15:27:33.6344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BjKvfUUluPkAqZa6USZ6IQXSUEq0/mt5LypVOTx/R850foOmnmkMfUJ3YuI2O9xPFs1kv5JKCEXwHQR2d4nY3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8098


On 12/18/25 15:03, Jonathan Cameron wrote:
> On Thu, 18 Dec 2025 11:52:58 +0000
> Alejandro Lucero Palau <alucerop@amd.com> wrote:
>
>> Hi Jonathan,
>>
>>
>> On 12/15/25 13:50, Jonathan Cameron wrote:
>>> On Fri, 5 Dec 2025 11:52:34 +0000
>>> <alejandro.lucero-palau@amd.com> wrote:
>>>   
>>>> From: Alejandro Lucero <alucerop@amd.com>
>>>>
>>>> A Type2 device configured by the BIOS can already have its HDM
>>>> committed. Add a cxl_get_committed_decoder() function for cheking
>>> checking if this is so after memdev creation.
>>>   
>>>> so after memdev creation. A CXL region should have been created
>>>> during memdev initialization, therefore a Type2 driver can ask for
>>>> such a region for working with the HPA. If the HDM is not committed,
>>>> a Type2 driver will create the region after obtaining proper HPA
>>>> and DPA space.
>>>>
>>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>> Hi Alejandro,
>>>
>>> I'm in two minds about this.  In general there are devices that have
>>> been configured by the BIOS because they are already in use. I'm not sure
>>> the driver you are working with here is necessarily set up to survive
>>> that sort of live setup without interrupting data flows.
>>
>> This is not mainly about my driver/device but something PJ and Dan agree
>> on support along this type2 patchset.
>>
>> You can see the v21 discussions, but basically PJ can not have his
>> driver using the committed decoders from BIOS. So this change addresses
>> that situation which my driver/device can also benefit from as current
>> BIOS available is committing decoders regardless of UEFI flags like
>> EFI_RESERVED_TYPE.
>>
>>
>> Neither in my case nor in PJ case the device will be in use before
>> kernel is executing, although PJ should confirm this.
> There was some discussion in that thread of whether the decoders are locked.
> If they aren't (and if the device is not in use, or some other hard constraint
> isn't requiring it, in my view they definitely shouldn't be!) I'd at least
> like to consider the option of a 'cleanup pass' to tear them down and give
> the driver a clean slate to build on. Kind of similar to what we do in
> making PCI reeumerate in the kernel if we really don't like what the bios did.


I do not mind to support that option, but could we do it as a follow-up?


> Might not be possible if there is another higher numbered decoder in use
> though :(
>
>>
>>> If it is fair enough to support this, otherwise my inclination is tear
>>> down whatever the bios did and start again (unless locked - in which
>>> case go grumble at your BIOS folk). Reasoning being that we then only
>>> have to handle the equivalent of the hotplug flow in both cases rather
>>> than having to handle 2.
>>
>> Well, the automatic discovery region used for Type3 can be reused for
>> Type2 in this scenario, so we do not need to tear down what the BIOS
>> did. However, the argument is what we should do when the driver exits
>> which the current functionality added with the patchset being tearing
>> down the device and CXL bridge decoders. Dan seems to be keen on not
>> doing this tear down even if the HDMs are not locked.
> That's the question that makes this interesting.  What is reasoning for
> leaving bios stuff around in type 2 cases? I'd definitely like 'a way'
> to blow it away even if another option keeps it in place.
> A bios configures for what it can see at boot not necessarily what shows
> up later.  Similar cases exist in PCI such as resizeable BARs.
> The OS knows a lot more about the workload than the bios ever does and
> may choose to reconfigure because of hotplugged devices.


The main reason seems to be an assumption from BIOSes that only 
advertise CFMWS is there exists a CXL.mem enabled ... with the CXL Host 
Bridge CFMWS being equal to the total CXL.mem advertises by those 
devices discovered. This is something I have been talking about in 
discord and internally because I think that creates problems with 
hotplugging and future FAM support, or maybe current DCD.


One case, theoretical but I think quite possible, is a device requiring 
the CXL.mem not using the full capacity in all modes, likely because 
that device memory used for other purposes and kept hidden from the 
host. So the one knowing what to do should be the driver and dependent 
on the device and likely some other data maybe even configurable from 
user space.


So yes, I agree with you that the kernel should be able to do things far 
better than the BIOS ...



>>
>> What I can say is I have tested this patchset with an AMD system and
>> with the BIOS committing the HDM decoders for my device, and the first
>> time the driver loads it gets the region from the automatic discovery
>> while creating memdev, and the driver does tear down the HDMs when
>> exiting. Subsequent driver loads do the HDM configuration as this
>> patchset had been doing from day one. So all works as expected.
>>
>>
>> I'm inclined to leave the functionality as it is now, and your
>> suggestion or Dan's one for keeping the HDMs, as they were configured by
>> the BIOS, when driver exits should require, IMO, a good reason behind it.
> I'd definitely not make the assumption that BIOS' always do things for
> good reasons. They do things because someone once thought there was
> a good reason - or some other OS relied on them doing some part of setup.
>

100% agreement again.

>>
>>> There are also the TSP / encrypted link cases where we need to be careful.
>>> I have no idea if that applies here.
>>
>> I would say, let's wait until this support is completed, but as far as I
>> know, this is not a requirement for current Type2 clients (sfc and jump
>> trading).
> Dealing with this later works for me.  As long as it fails cleanly all good.


Great.

Thanks!


> Jonathan
>

