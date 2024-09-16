Return-Path: <netdev+bounces-128570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D6F97A5E8
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 18:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D845C1F21F40
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 16:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2383B1311A7;
	Mon, 16 Sep 2024 16:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UJtkaTpF"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3290CA29;
	Mon, 16 Sep 2024 16:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726503859; cv=fail; b=FdzyCf8CDrWf0eemEbd8Mxiggf1hCZkY9ib5fVvq7YFYn/BMV/jelCNeW4smxmNsuF4yniKysfvDrq1OLMsZyYRh+o6QS/Q4Ctn3YbwTS8L9d9HElTExGj5lMp28+qieiN3oh/D5W1Lg/Zuj4hckWQ4I0acuc6326+/gE/Nizyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726503859; c=relaxed/simple;
	bh=kdbf4Rr4DYvHdwMvDQh8hPQMytR89gin7B7k1i/ReV8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WBYy75lObJnUet+UvvytLuQxdVJDCFGWLOwDadxSf68JWTlVtjeT0JSmv/vnHmF6GbQhe9K6WoJip1Df0VMNhTPh0D/CGDjmR05d1T/TQsGrU73A4srlX2J/9/Dbo5Kscs6Lp9TCYVZb4HpVpG9wXcBRBTVd7/lGqzi7ojvk5qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UJtkaTpF; arc=fail smtp.client-ip=40.107.236.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G+SqDvCWpcK7cJBraKvRdQeRKz3I+khZ45LVts8szG0gbmWnAGWEQSz9XBnOTB+Pad1GIA7D7BczRuq2Oe1nGznkN2O8U52kU5sbLstiDUGJZvaM9ufLw3UPqrentaWZ/PY+BpadUrpYHbGT+SdtX2AiSBagAT7iSz5L7HeLI5prwMoiMiwzecYoYyq1Gb26M8XdhV/4/9XjBFQrDMp80XaRpeFOPPo2hAZA4N1HvF58oHdAkBxvvQFfJeXZOiLfMEBs7Ukx3Et9Hc3+ZqT2z5dz2KOL3PZJJ2QPKgrn8du6KrLbcRFuNeuMemS8bXyt7LxwsBv1cS9J5bcDVEIpqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9sFe5N06uvyKPJez6Teg0JIjQpjpcAUypWSsnilhXug=;
 b=FwKZN48A+h9uFHw/q5VZXGapSznuxrNiXomt88WzXuQ30kIryPl37GbFu5GhDiJdkcpABpGoh/brIbK6ncROPyOZnxGMZ4ceLduj8aCf/g5U6mXdx9/oSDyaoEh+BaAIMKGBukoYL5yEBZVth3QJJv1mQWpPkDk+ngcuWJE0RlUnnYG9Xj4k0UAvXn4Z0+uXmB77vuuU9U4XY39sfe9CqkTH9hCvlaUEqZzWTuRhXAvy5gr3uj5eqwJYjI9tJ9X4J4uMpOjhN7tGpvTwQ6FFjJYfywplaVwsYQwPt8ey1cPGHlXvnkOusi/7zpmeyz9wo7XpG/gmU9yLbyTwK9q6WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sFe5N06uvyKPJez6Teg0JIjQpjpcAUypWSsnilhXug=;
 b=UJtkaTpF8g/Fp5okjVV+7qgzKNJ3pvndj5cVsLwPeighmO17hC9oHD5rumMd8LWgCod3tZbZklnM47uQ6eMPmwu/gKoTfEIRrmiIiPIKkvKkvE0lT3RTPGm7pJ5YLj38fSY8kwtyKeRZCti7efU5m4pEGgj/T21U3B2rSr5Wdno=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4205.namprd12.prod.outlook.com (2603:10b6:208:198::10)
 by CY8PR12MB7610.namprd12.prod.outlook.com (2603:10b6:930:9a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Mon, 16 Sep
 2024 16:24:11 +0000
Received: from MN2PR12MB4205.namprd12.prod.outlook.com
 ([fe80::cdcb:a990:3743:e0bf]) by MN2PR12MB4205.namprd12.prod.outlook.com
 ([fe80::cdcb:a990:3743:e0bf%2]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 16:24:11 +0000
Message-ID: <0e9bc3a6-a5aa-d698-edb8-6f591c765395@amd.com>
Date: Mon, 16 Sep 2024 17:23:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 20/20] efx: support pio mapping based on cxl
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
 <20240907081836.5801-21-alejandro.lucero-palau@amd.com>
 <87c61aa6-a315-4cf1-8933-4212a82111f5@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <87c61aa6-a315-4cf1-8933-4212a82111f5@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0616.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::16) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4205:EE_|CY8PR12MB7610:EE_
X-MS-Office365-Filtering-Correlation-Id: 56a34bef-9296-48c1-5c40-08dcd66bff03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bjBraXdueDRTYU80Qmh0MHo3ZkM4TFdrdGtiSU9hUGwxSVFJRENYdGJjd3RF?=
 =?utf-8?B?SzRmcFAyaTViTXUzVVd4NmFpcUVtU1RtSDlSeUFSNEUvNUU5OEVJNVo2MG9x?=
 =?utf-8?B?OFYxMm1KMzZBMTZYbjZNL0QrbjZLR3g0S29RY1cvMFVhSFBwOWlMcmdqOXVL?=
 =?utf-8?B?OER1UlprY3gvblNDUUtMVWllNW5aMVJNemErOHQyZjRQcGF3NVIrT0sycGxJ?=
 =?utf-8?B?L2VQeXJGdHUrYTZNWWFmeTBrMGd3Sk1Sd2VwQldacWluVnVqNWk2d2pPYnJ5?=
 =?utf-8?B?ZE1rZTMzdmUxRFp5cXJ4Zk1zM2xSd3BrZFlBYk1rNVZCd2lEQk4wWHBSaUxK?=
 =?utf-8?B?VDlyZEpBY3U1WUsvOHY1VVR0MENBRzJpYyt3TVhqMDVzY2VjYkg0Rmh2TVVz?=
 =?utf-8?B?VHdNRGp0ZDNpZXFpaHBjMzdmMk5tM3AxSVc4dCtTMHJJdWFOeGRuTFA3WU5P?=
 =?utf-8?B?SjVRZDBOWmxtS0EzTCsyeS9xSUtaQ1ZGNzgvT1g2cVl1Y0VaT1drOXZGR28w?=
 =?utf-8?B?d2VFK1dKTjhnWHFjNmJoUVRmT2xxaC8wa3FKbCtnMVYxTE4xSU9lVTc2MDNk?=
 =?utf-8?B?Y2M3Mm1UUjVMekc1TmZ3VjhJY1NnSm5wNXBBSEd3ZDJtVUdQbnBDL3VjQVRD?=
 =?utf-8?B?Z3dIQlkwOVdsdEZrRm5kYVdobWlta3pEWVBqZCtGSmdoWFRMWkxmcTdNUzlE?=
 =?utf-8?B?UlVJT3RjWjVCYUZKSTNWSmhLZWRYRWRKQWVXc0tLSkpJalFoUlVtazNsbWdx?=
 =?utf-8?B?RHBQcmozV0Zpci9zeVNoSDZHamtINnZiOVpmcTNQdDhEZm8xRkxRQkxqSFoz?=
 =?utf-8?B?bk1yNm93cHRxRUhZTVJzYlUwTFlpMUdGV0ZFalpodmF1Y3U0L29aejBRS0Fj?=
 =?utf-8?B?dWdZeGJYOVVJTjBwRnd3NWlGU0RhUDQxdE5UUFBUV0JHNEhMeXp4dGdhZitO?=
 =?utf-8?B?SzIyeUtIZW1jTFBJM1B1YXZYMTkxSDdObmhpRW5mYXF2VXRaWlU4TnNmRXk1?=
 =?utf-8?B?MFFadE9YRGtFTDNKUTR6dnRTWWZQajZqc1A1S3lpTENCcFgwVVQyVUdGK2Ez?=
 =?utf-8?B?bDQ1dVlacmRhOCt6OXgwaDF6RFlDNVhWTWNYYUlWYlh0ZzVYR0toVWpWYXFa?=
 =?utf-8?B?T0VPaTJISWpPVHp1c3dwNlBNN0c1K21wbzcrdXQ5QW11ZkFYSzMza0NkUHBQ?=
 =?utf-8?B?ZUQ0Ylc1TldzNGM2RG1icXlhc1NwVFgwYi9HdU1nUWV1enpiS1ZKdEVOQ1U3?=
 =?utf-8?B?ZDhpS1BxTDc2dU5qYUx3RjNyVXpoaTl0aTQybFFISXM2T0hLNjZuTW5tWWtm?=
 =?utf-8?B?VTdveXdBNmlid0x3UTZIUkVYRDNoQndFZWdad295NExhYitIWkZMa1Z0U0J1?=
 =?utf-8?B?bmZEeGZrUTBlVHVkUkdFK2FYeWxmeUxQaDFseTFlSHFVczZ0UWxXSmdualJI?=
 =?utf-8?B?UWZ3UXhVK2NLMklTYXgrTDMzeGtMQlFPbng5bDJWSHVTLy9BNFlxUmN4TU40?=
 =?utf-8?B?VEN2RWFLeTB0S1lnNkRPY0tsMkhtNjNueGl1WjNJRjZtQU5OTmRGQkV6aVF0?=
 =?utf-8?B?RUQvNjdUKytSV1RxK1FKOG9KRFNEM0J5YXJQVHVZQkRRcHA1OUErc1JSbVJ1?=
 =?utf-8?B?WGZzbDdlMFdDTzNGVzZCRUxiaVhxZFlRT09KTEd1S2lDRzc0K1ZjSm9hRUY1?=
 =?utf-8?B?Y2RLOXFGNis5cUd4ZHp5TGo4TzkzRjhNcUZERklMZmJVZ0hLbjU2Y0szTlYv?=
 =?utf-8?B?ZkQreWhUQVQvd1g4MXhoNjlweSt0T0V6TGxTWjdOeFhNbFczOGdlejJQM3lO?=
 =?utf-8?B?aEpYRW9lY3lHcWJSN2xBMVZkem96UVpXT2tweHhFaS9YTUk5cHRWd0krQWx4?=
 =?utf-8?Q?V8RYWpS9ze6P1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4205.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emN5Rml4TXZ1VGQ5SFI4TS85YVRmMW5zdndVUkE1Wm9kcGFSeGVIRkVOLzdk?=
 =?utf-8?B?TGhRMHU4bDhFaGZOOW1DY2tXR1hLMlVFTHpZUmFsV2dvWVlTNU4vbllaVDdM?=
 =?utf-8?B?Y1h1RmZFOGVTaC9GK0krNnEwdXBwTkpPZ2lyY3d3SW1EV1hockhvYjY3Q0Zt?=
 =?utf-8?B?V1FERHc2R01zb1VMdm5MVndMdkVDalhRWkFiblhzck1iVjlYSWxRR0FSeEpv?=
 =?utf-8?B?dVFkNVpOOXRWbzBxaDUzTWl1WkppWHZObHRlazVESGp6UEdZNzhpQlp6SDc3?=
 =?utf-8?B?L0UxNEM0RzBOd2p5Yk1hK3dXdU1BejNBZExBWmdhKzhhUk04S05zcEUyVFV0?=
 =?utf-8?B?dk5VVzJiakxVQmFKbENBSndodlpxZDBsK2VMVUlFVjNYN3pTRUd5Y2tWMHY4?=
 =?utf-8?B?Ums4czdQazg2dHBKQUIwcjFTOTlJYi9UeUtXYnJma01TeSt1eE5ieVFkVVlF?=
 =?utf-8?B?Y05ON3dEbCtZNHVHKzFkNktUb1kvL3NhMXhOK2NiQWtEejNaVFBCbmhMd1J6?=
 =?utf-8?B?Q1F3T2FDb0o3VW55cHhEeEpiZ2FWbG41TnZ2djVRc2FxWHpiajVtL2pTenNn?=
 =?utf-8?B?bEZFTyszc3hHMU9uV1ZBeUYwOG9sVXVkVmFRRnVabUF1VHJrRW0zU2pmQk83?=
 =?utf-8?B?YVBxRWxISXlkaS8vZXVKenNuM1V0SjJYdWNqZW5JTnNoci93NGFPZzFmdlhl?=
 =?utf-8?B?ZTlrSGh2THYwWjczVmNlZ0NDV0NHUjhFNlU3TUplcENpNSt3VE5iSTA1MmJi?=
 =?utf-8?B?cFBHMjBXNk1aVmgyVFEvZ2U1VEF3REM0SFRqTk9OU2IwY3hzb215Y0tnTDBW?=
 =?utf-8?B?NTUxbWZKZ1lLdDZRUCswaFd4cnNrWUhtYTAwQnFTeEo4N3ZXT2thMzlEcmli?=
 =?utf-8?B?S29CckRJWThVcVpocHVUc0JSR29JVkhlWnZoU1VFYkpSL0RuYldoRU5NQTNO?=
 =?utf-8?B?Qm9kRWQya3NMdkVQcFZUaDh4RktURGMrWFZFWTRhUE45MkZqRXBkZDZzVXFF?=
 =?utf-8?B?UEEzOERRWVp2QkYrZjZrRG0xb0doMTVyMzkvR3BLTXU1RmZaa2hYYmNvaGJv?=
 =?utf-8?B?eTFTdi9BMUVxRStHdUswcjg5R2N4WGFqZ2VCN0JLUGIzYkdCdzMwUTZrekY0?=
 =?utf-8?B?RTZRSk4wWmZyNysvZmhCN0h0NDFhZFhQaFliUmdPZnlVMDFDYWFsdUF2RDBN?=
 =?utf-8?B?QUlrazRpWW9oTHpzY2FCY20zSTVDZmhZa0ExcmowN0ZHcDNGMGtWTGhYSldP?=
 =?utf-8?B?M3pDOERxNVB3SFJIZDI5SFBHREI1cFAxZjY0TG5vNGphSlBmKzVCdzNtaGs0?=
 =?utf-8?B?U1p1WlUwTW5jcXRUazhWN2RocHNzd1VKai8yOVdIaTFybzhoUUo5Z2dONi9T?=
 =?utf-8?B?UHYvY3BjWkpCeURsczd4aHdiZFpQTXpyUFErbk96ejVmV3dFeGlZYlRrMTdB?=
 =?utf-8?B?Z3BJUXZPNVRaM05KUUZYNWVLQTZqekdob2xmMGlUTzlhcktmZ1dqdERlQ0ZW?=
 =?utf-8?B?cER4V1pYUHBNOUVHT25CUnFRZTVITTQ5SHFyUTQveDFKNG0yclN4YXBMOE5k?=
 =?utf-8?B?cFROcHV1dVNFandTZGNtUTZNSStLbmdOWmtCK1FBeGQwZ0ZVMEp6VkUxcU16?=
 =?utf-8?B?SmFCZTh3elJzWW1QR3M4aUpRcjk3WStJTDM5N1YrcTd5UWFFTnpjdlhPQVRp?=
 =?utf-8?B?bVp1Y2NHUlJVUjl3MlVCMVFya0xHTXpzeWl2SFRDUHR3ZG55V0dOQkFEVEdt?=
 =?utf-8?B?UWhXbkhic0sxekV4SWhiOHFmVUpGRGNScTRTT1h1M2tOQmpyM21wT1JzMjF1?=
 =?utf-8?B?RmdlWmdaQngydG9xbGVJbnpScm9kd3VHNVdXcThMYzJLSVZ2bW90ZXFRaUNr?=
 =?utf-8?B?WFk1UDRHZ004R2x1ZlRkdENsenF1SW8xRFM5MWVISUV4M1pzNnJsb1FvNUlV?=
 =?utf-8?B?VWg0TVViTyt5cFFMYUdzK3ByNEpwY29zRGlCUVF6YnEvbTgzMlY0MGN2RGVW?=
 =?utf-8?B?QUNMc3JZR0kwU1RqTHNSOHFwL3B3c1d5c3N1MjE3eFFpSW0yVXkxems4WGpO?=
 =?utf-8?B?azBUU2gycWpVWHA3eXJqVkowZlRqQ2UyNGxwM3psMDNyZVZRcFFNQmFXOGFL?=
 =?utf-8?Q?IKKQhOsb93x38sza2nNNP5Zdr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56a34bef-9296-48c1-5c40-08dcd66bff03
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 16:24:11.4994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EiCtXe49LYrWu077sDGiMN1gKQ8a2OohSNdvX8Qc3BlHVxE70Pm0E1TFNp1q6CEPLfDxi3xag+y37w7PWCGpeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7610


On 9/13/24 18:52, Dave Jiang wrote:
>
> On 9/7/24 1:18 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> With a device supporting CXL and successfully initialised, use the cxl
>> region to map the memory range and use this mapping for PIO buffers.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/net/ethernet/sfc/ef10.c       | 32 +++++++++++++++++++++------
>>   drivers/net/ethernet/sfc/efx_cxl.c    | 20 ++++++++++++++++-
>>   drivers/net/ethernet/sfc/mcdi_pcol.h  | 12 ++++++++++
>>   drivers/net/ethernet/sfc/net_driver.h |  2 ++
>>   drivers/net/ethernet/sfc/nic.h        |  2 ++
>>   5 files changed, 60 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
>> index 7d69302ffa0a..d4e64cd0f7a4 100644
>> --- a/drivers/net/ethernet/sfc/ef10.c
>> +++ b/drivers/net/ethernet/sfc/ef10.c
>> @@ -24,6 +24,7 @@
>>   #include <linux/wait.h>
>>   #include <linux/workqueue.h>
>>   #include <net/udp_tunnel.h>
>> +#include "efx_cxl.h"
>>   
>>   /* Hardware control for EF10 architecture including 'Huntington'. */
>>   
>> @@ -177,6 +178,12 @@ static int efx_ef10_init_datapath_caps(struct efx_nic *efx)
>>   			  efx->num_mac_stats);
>>   	}
>>   
>> +	if (outlen < MC_CMD_GET_CAPABILITIES_V7_OUT_LEN)
>> +		nic_data->datapath_caps3 = 0;
>> +	else
>> +		nic_data->datapath_caps3 = MCDI_DWORD(outbuf,
>> +						      GET_CAPABILITIES_V7_OUT_FLAGS3);
>> +
>>   	return 0;
>>   }
>>   
>> @@ -949,7 +956,7 @@ static void efx_ef10_remove(struct efx_nic *efx)
>>   
>>   	efx_mcdi_rx_free_indir_table(efx);
>>   
>> -	if (nic_data->wc_membase)
>> +	if (nic_data->wc_membase && !efx->efx_cxl_pio_in_use)
>>   		iounmap(nic_data->wc_membase);
>>   
>>   	rc = efx_mcdi_free_vis(efx);
>> @@ -1263,8 +1270,19 @@ static int efx_ef10_dimension_resources(struct efx_nic *efx)
>>   	iounmap(efx->membase);
>>   	efx->membase = membase;
>>   
>> -	/* Set up the WC mapping if needed */
>> -	if (wc_mem_map_size) {
>> +	if (!wc_mem_map_size)
>> +		return 0;
>> +
>> +	/* Using PIO through CXL mapping? */
>> +	if ((nic_data->datapath_caps3 &
>> +	    (1 << MC_CMD_GET_CAPABILITIES_V7_OUT_CXL_CONFIG_ENABLE_LBN)) &&
> Maybe a FIELD_GET() call would make this cleaner
>
> DJ


I agree.

Thanks


>
>> +	    efx->efx_cxl_pio_initialised) {
>> +		nic_data->pio_write_base = efx->cxl->ctpio_cxl +
>> +					   (pio_write_vi_base * efx->vi_stride +
>> +					    ER_DZ_TX_PIOBUF - uc_mem_map_size);
>> +		efx->efx_cxl_pio_in_use = true;
>> +	} else {
>> +		/* Using legacy PIO BAR mapping */
>>   		nic_data->wc_membase = ioremap_wc(efx->membase_phys +
>>   						  uc_mem_map_size,
>>   						  wc_mem_map_size);
>> @@ -1279,12 +1297,12 @@ static int efx_ef10_dimension_resources(struct efx_nic *efx)
>>   			nic_data->wc_membase +
>>   			(pio_write_vi_base * efx->vi_stride + ER_DZ_TX_PIOBUF -
>>   			 uc_mem_map_size);
>> -
>> -		rc = efx_ef10_link_piobufs(efx);
>> -		if (rc)
>> -			efx_ef10_free_piobufs(efx);
>>   	}
>>   
>> +	rc = efx_ef10_link_piobufs(efx);
>> +	if (rc)
>> +		efx_ef10_free_piobufs(efx);
>> +
>>   	netif_dbg(efx, probe, efx->net_dev,
>>   		  "memory BAR at %pa (virtual %p+%x UC, %p+%x WC)\n",
>>   		  &efx->membase_phys, efx->membase, uc_mem_map_size,
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index dd2dbfb8ba15..ef57f833b8a7 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -21,9 +21,9 @@
>>   int efx_cxl_init(struct efx_nic *efx)
>>   {
>>   	struct pci_dev *pci_dev = efx->pci_dev;
>> +	resource_size_t start, end, max = 0;
>>   	struct efx_cxl *cxl;
>>   	struct resource res;
>> -	resource_size_t max;
>>   	u16 dvsec;
>>   	int rc;
>>   
>> @@ -132,10 +132,27 @@ int efx_cxl_init(struct efx_nic *efx)
>>   		goto err_region;
>>   	}
>>   
>> +	rc = cxl_get_region_params(cxl->efx_region, &start, &end);
>> +	if (rc) {
>> +		pci_err(pci_dev, "CXL getting regions params failed");
>> +		goto err_map;
>> +	}
>> +
>> +	cxl->ctpio_cxl = ioremap(start, end - start);
>> +	if (!cxl->ctpio_cxl) {
>> +		pci_err(pci_dev, "CXL ioremap region failed");
>> +		rc = -EIO;
>> +		goto err_map;
>> +	}
>> +
>> +	efx->efx_cxl_pio_initialised = true;
>> +
>>   	cxl_release_endpoint(cxl->cxlmd, cxl->endpoint);
>>   
>>   	return 0;
>>   
>> +err_map:
>> +		cxl_region_detach(cxl->cxled);
>>   err_region:
>>   	cxl_dpa_free(efx->cxl->cxled);
>>   err_release:
>> @@ -151,6 +168,7 @@ int efx_cxl_init(struct efx_nic *efx)
>>   void efx_cxl_exit(struct efx_nic *efx)
>>   {
>>   	if (efx->cxl) {
>> +		iounmap(efx->cxl->ctpio_cxl);
>>   		cxl_region_detach(efx->cxl->cxled);
>>   		cxl_dpa_free(efx->cxl->cxled);
>>   		cxl_release_resource(efx->cxl->cxlds, CXL_ACCEL_RES_RAM);
>> diff --git a/drivers/net/ethernet/sfc/mcdi_pcol.h b/drivers/net/ethernet/sfc/mcdi_pcol.h
>> index cd297e19cddc..c158a1e8d01b 100644
>> --- a/drivers/net/ethernet/sfc/mcdi_pcol.h
>> +++ b/drivers/net/ethernet/sfc/mcdi_pcol.h
>> @@ -16799,6 +16799,9 @@
>>   #define        MC_CMD_GET_CAPABILITIES_V7_OUT_DYNAMIC_MPORT_JOURNAL_OFST 148
>>   #define        MC_CMD_GET_CAPABILITIES_V7_OUT_DYNAMIC_MPORT_JOURNAL_LBN 14
>>   #define        MC_CMD_GET_CAPABILITIES_V7_OUT_DYNAMIC_MPORT_JOURNAL_WIDTH 1
>> +#define        MC_CMD_GET_CAPABILITIES_V7_OUT_CXL_CONFIG_ENABLE_OFST 148
>> +#define        MC_CMD_GET_CAPABILITIES_V7_OUT_CXL_CONFIG_ENABLE_LBN 17
>> +#define        MC_CMD_GET_CAPABILITIES_V7_OUT_CXL_CONFIG_ENABLE_WIDTH 1
>>   
>>   /* MC_CMD_GET_CAPABILITIES_V8_OUT msgresponse */
>>   #define    MC_CMD_GET_CAPABILITIES_V8_OUT_LEN 160
>> @@ -17303,6 +17306,9 @@
>>   #define        MC_CMD_GET_CAPABILITIES_V8_OUT_DYNAMIC_MPORT_JOURNAL_OFST 148
>>   #define        MC_CMD_GET_CAPABILITIES_V8_OUT_DYNAMIC_MPORT_JOURNAL_LBN 14
>>   #define        MC_CMD_GET_CAPABILITIES_V8_OUT_DYNAMIC_MPORT_JOURNAL_WIDTH 1
>> +#define        MC_CMD_GET_CAPABILITIES_V8_OUT_CXL_CONFIG_ENABLE_OFST 148
>> +#define        MC_CMD_GET_CAPABILITIES_V8_OUT_CXL_CONFIG_ENABLE_LBN 17
>> +#define        MC_CMD_GET_CAPABILITIES_V8_OUT_CXL_CONFIG_ENABLE_WIDTH 1
>>   /* These bits are reserved for communicating test-specific capabilities to
>>    * host-side test software. All production drivers should treat this field as
>>    * opaque.
>> @@ -17821,6 +17827,9 @@
>>   #define        MC_CMD_GET_CAPABILITIES_V9_OUT_DYNAMIC_MPORT_JOURNAL_OFST 148
>>   #define        MC_CMD_GET_CAPABILITIES_V9_OUT_DYNAMIC_MPORT_JOURNAL_LBN 14
>>   #define        MC_CMD_GET_CAPABILITIES_V9_OUT_DYNAMIC_MPORT_JOURNAL_WIDTH 1
>> +#define        MC_CMD_GET_CAPABILITIES_V9_OUT_CXL_CONFIG_ENABLE_OFST 148
>> +#define        MC_CMD_GET_CAPABILITIES_V9_OUT_CXL_CONFIG_ENABLE_LBN 17
>> +#define        MC_CMD_GET_CAPABILITIES_V9_OUT_CXL_CONFIG_ENABLE_WIDTH 1
>>   /* These bits are reserved for communicating test-specific capabilities to
>>    * host-side test software. All production drivers should treat this field as
>>    * opaque.
>> @@ -18374,6 +18383,9 @@
>>   #define        MC_CMD_GET_CAPABILITIES_V10_OUT_DYNAMIC_MPORT_JOURNAL_OFST 148
>>   #define        MC_CMD_GET_CAPABILITIES_V10_OUT_DYNAMIC_MPORT_JOURNAL_LBN 14
>>   #define        MC_CMD_GET_CAPABILITIES_V10_OUT_DYNAMIC_MPORT_JOURNAL_WIDTH 1
>> +#define        MC_CMD_GET_CAPABILITIES_V10_OUT_CXL_CONFIG_ENABLE_OFST 148
>> +#define        MC_CMD_GET_CAPABILITIES_V10_OUT_CXL_CONFIG_ENABLE_LBN 17
>> +#define        MC_CMD_GET_CAPABILITIES_V10_OUT_CXL_CONFIG_ENABLE_WIDTH 1
>>   /* These bits are reserved for communicating test-specific capabilities to
>>    * host-side test software. All production drivers should treat this field as
>>    * opaque.
>> diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
>> index 77261de65e63..893e7841ffb4 100644
>> --- a/drivers/net/ethernet/sfc/net_driver.h
>> +++ b/drivers/net/ethernet/sfc/net_driver.h
>> @@ -967,6 +967,7 @@ struct efx_cxl;
>>    * @dl_port: devlink port associated with the PF
>>    * @cxl: details of related cxl objects
>>    * @efx_cxl_pio_initialised: clx initialization outcome.
>> + * @efx_cxl_pio_in_use: PIO using CXL mapping
>>    * @mem_bar: The BAR that is mapped into membase.
>>    * @reg_base: Offset from the start of the bar to the function control window.
>>    * @monitor_work: Hardware monitor workitem
>> @@ -1154,6 +1155,7 @@ struct efx_nic {
>>   	struct devlink_port *dl_port;
>>   	struct efx_cxl *cxl;
>>   	bool efx_cxl_pio_initialised;
>> +	bool efx_cxl_pio_in_use;
>>   	unsigned int mem_bar;
>>   	u32 reg_base;
>>   
>> diff --git a/drivers/net/ethernet/sfc/nic.h b/drivers/net/ethernet/sfc/nic.h
>> index 1db64fc6e909..b7148810acdb 100644
>> --- a/drivers/net/ethernet/sfc/nic.h
>> +++ b/drivers/net/ethernet/sfc/nic.h
>> @@ -151,6 +151,7 @@ enum {
>>    * @datapath_caps: Capabilities of datapath firmware (FLAGS1 field of
>>    *	%MC_CMD_GET_CAPABILITIES response)
>>    * @datapath_caps2: Further Capabilities of datapath firmware (FLAGS2 field of
>> + * @datapath_caps3: Further Capabilities of datapath firmware (FLAGS3 field of
>>    * %MC_CMD_GET_CAPABILITIES response)
>>    * @rx_dpcpu_fw_id: Firmware ID of the RxDPCPU
>>    * @tx_dpcpu_fw_id: Firmware ID of the TxDPCPU
>> @@ -186,6 +187,7 @@ struct efx_ef10_nic_data {
>>   	bool must_check_datapath_caps;
>>   	u32 datapath_caps;
>>   	u32 datapath_caps2;
>> +	u32 datapath_caps3;
>>   	unsigned int rx_dpcpu_fw_id;
>>   	unsigned int tx_dpcpu_fw_id;
>>   	bool must_probe_vswitching;

