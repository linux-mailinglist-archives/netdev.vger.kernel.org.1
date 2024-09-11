Return-Path: <netdev+bounces-127175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5326F974776
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 02:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E0A31F26948
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 00:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAFBBA34;
	Wed, 11 Sep 2024 00:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wkjJt8Ay"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2C5C144
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 00:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726015300; cv=fail; b=SjJTx7WqkTMHPiRut7hEDx2BNFWKj0lh2l8OKPdknV2Wos4VUmu9RQGr7bkRQwA/g7gRbM9px9lZ72HQYOM762W1Ff6o00mj8u2ioz0R+daY3vRuC8iS4MmmaiBHYV4662zjo1Xu7AN38DdPkObkumNE7PrS4n2ODv7y2JxXFBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726015300; c=relaxed/simple;
	bh=8KbxmgjAkUBR3PlFN5eMGshAPWPR7zy+r6Goy58w1Us=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e7fuWVqf8iOfNCPNR5ZDRKL2BmC6CMlZqESxkEgBFAWHNIIEEMY3kB+bgsF5e66R7EEjoXqKzVZ4dnKdzRCNlCOJ9Agnm2bxEMdmm/gbCjhuXOjScVSWL++ony3llMmm8LFsnN7K6stwa0HU/ycKkcWrZifcOkhf4BjDV2Z2IMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wkjJt8Ay; arc=fail smtp.client-ip=40.107.220.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MRBFm+8QafNOI0it/L5gC8whI8ehyOPnx3fjq9jr8LgQwi7dAAHXmQ2XBbm3JTUT4bXTONJvb1PufffGCqey88afqAdKEri7F1eTGfLjIgZL6kDz9UCxKxPzoyJnGrKkas0PvS+8lYE1PKoXpxb8BkIBKDS1hTS4r5jg9KCeek3yu/AwGdqi+YMDDdeUx1KqBOgRxYBmP/CowWust0lyrVeA73AcmEy1Z7uzMFxk6gzAQ/YciIaB9N6PTdXKrSA92P33uTEQvnm7us+PlmdBgmuvcEhIzDwJQuCPT2SPBbO0FqCKzL9BwKfJxFw5wvs0K1Q8Gvojjt0DUbDPGsG/Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MUXcT/0W8QwK+jHxRymYINbNBOB8Ig1CdYYamzG4/6s=;
 b=K1AydAwVglGsFxGUfpBAdXfpZ2TRtEKXtclxC1EscM4S7C2L69cCp6YQgM55VveT5qaAT/uYeAgOU00xOtZZuxD4TEWSV0zarNDpM3EOSe0JRY+CsAIOf7MO8qj2BhdLQc98vXk3OnnnG1Y90Ikf8zk924DcT0KZY2541IVu1910p6sZbq40GxXtofsOyFrw0Ie3w3azAC4tjNCo5GzjxHjtTftL9JZMl9A9y+SyjnaI/PotIXyYLxy3qRdNpjwFgA513QWOfneOJvLyReR6/hs6jbIOj+3RNy2C3C8F+dEsWeigCOmJYTp/yvb5Hv6ZZFwkCQBvYpvnEd/4bUYazA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUXcT/0W8QwK+jHxRymYINbNBOB8Ig1CdYYamzG4/6s=;
 b=wkjJt8AyZ0bmAv5NfAjDnpLbndfyzeE/9xd06lCtkA02Iuz9DBB55Q4W+L5VFZlhrvr2FKLR6bze1WYaZ67dqb57AWfA9n9Dn/GpPHszh2Pj7Q+mQVeyVeiARxYQTK6xSMLcJXESVjfxT7hcGB6RDUSbUUvmTAUvfFFcBwhAmGs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 PH0PR12MB8173.namprd12.prod.outlook.com (2603:10b6:510:296::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 11 Sep
 2024 00:41:35 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%6]) with mapi id 15.20.7939.022; Wed, 11 Sep 2024
 00:41:34 +0000
Message-ID: <814c34c9-a7e3-425a-8322-32986e0b77f7@amd.com>
Date: Tue, 10 Sep 2024 17:41:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] gve: adopt page pool for DQ RDA mode
To: Praveen Kaligineedi <pkaligineedi@google.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, willemb@google.com, jeroendb@google.com,
 shailend@google.com, hramamurthy@google.com, ziweixiao@google.com
References: <20240910175315.1334256-1-pkaligineedi@google.com>
 <20240910175315.1334256-3-pkaligineedi@google.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20240910175315.1334256-3-pkaligineedi@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0064.namprd03.prod.outlook.com
 (2603:10b6:5:3bb::9) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|PH0PR12MB8173:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e6da99d-66d1-47fc-7062-08dcd1fa7cc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T3VMUUUya1BkeUJmcGUzRDlaRjdyUGNuMno3SkJrNDAyVmpSVVhITlpvQlVh?=
 =?utf-8?B?TGF3b04wcDM3NUlSVFduLy9WU2taNUdub0dvNDhHelBxQVVHZlQ2RlhtWmdE?=
 =?utf-8?B?aFZ2b2kzUklZb0U5bFlERzZUS1pVVmFOdmhCYjUxZzdMUTBmaWVzeVlGbjV4?=
 =?utf-8?B?a3gyeW1rRkl4eTRYQXo0cU5iSkxCNHRFbCtlMXlJRmU1WmpBQk9kRWxKditF?=
 =?utf-8?B?bkdBODJNbjNPbjdrN2VnWWxSVzFMeWFRalpjbkNEMHA3N0o1ZnIya1ZWNUto?=
 =?utf-8?B?RU02YjJZMG1aUWVUK2FZV0ozbGwrTXpOOWFOWVNSMllnd0JvVGxQWFJadWd3?=
 =?utf-8?B?SGdRdXk4YWVNQUhXVUllcEswL0IyVk1QN1ZNdHN0MUdnNUlvaEtwalFEeGFw?=
 =?utf-8?B?dUhJd2pwb3IrVGlxZEhGMW03ZEpNNERzQ2JjYVp3MGc4RFJQbTlWVzhWVlRr?=
 =?utf-8?B?Rytsell4MFdMTW5sU0RVWlA2TkxGWmIxT1F6NGozSEZkUmRzVEJtU2xhbCtL?=
 =?utf-8?B?MFZrRkVhT3IyWlpZdm90dStuVEN1R3FuVzZ5TWMyTEF0Q1NMOHl4ZWxvb21q?=
 =?utf-8?B?blh2Y1pJcG5HVDRzL3NJMjdkY0trbGh0NndtdUd5RjVjTEkyYno3d0ZDT3cw?=
 =?utf-8?B?bmFuZFJDMjdiaittWEQ1dkJHbjZwY0JGeW0wRFFhSnl4Yzc3bzNKOTZXUDJX?=
 =?utf-8?B?Y0ZLckVyS1g5dVNobE1UMkgyWW1XTVZwRDIwT2MwNDhXQVo4MUwyalFsalJ6?=
 =?utf-8?B?bVpYdFpRRG5YV3ZuQjBleWZXZzRCRGJRRzlVOVMrcnk2Mjk2ZHVkTENSdTIv?=
 =?utf-8?B?SmdDcVVaUXU2eTZkczFjQTIvdWVqZmcyaWVjNDdHMDNsQTRHT0h6dEFPN1FL?=
 =?utf-8?B?a29Td0F0aVBBR2hxenB1YVEvZnRpYittRjlwUnNPWE94ckpNWFRyR1Byb2pZ?=
 =?utf-8?B?SnV4ZnFtVGhIaTVaZDRZR2h6VnFSUVUvTUpoMEt4Q3B1QkY5ci9raFdEQ3dE?=
 =?utf-8?B?NUZRZUE4cU9LYXdJeTBIakRIZWdXdWZFVjU2SUZ5eGQ0Mk4wSlVBTUt5cVYw?=
 =?utf-8?B?Y1ZEak5mT1ZlTklRd0ZoSlVHcUxsbzBtQjUxdUtxc1l4ZExqeDJ1RWFsU2Zi?=
 =?utf-8?B?c1VpVC9ad2NMeVFvekZHaWhhRnF6VnB2WmU0dExDRFpZNjJWRy96YXFLVmZS?=
 =?utf-8?B?Y2NZVFJ0YkM0VHh4Um50OWRyUHR6bTY5aUt3eUs3WS9UZ0VIaTNMekYxV01y?=
 =?utf-8?B?TjFMdmhWbllCUm1qUjVHektiVjFpVHpjN2g2SmR4aGxwM2hrVDlJcHkzRnZj?=
 =?utf-8?B?c0JkYVUwMEVTOUp1SU1pZGZ4cXpwMmlBYm92MmVIRVN5alJVMEQ1dzg0TGNu?=
 =?utf-8?B?bE5tK0t4VUhYbkZOdG1VZlJxNlcySTJCK3FqbVgxUXpFUUV3bmRQVHk0aTR4?=
 =?utf-8?B?cDh5bGhGemllUnFTV2J5aUVzTE5SWlFYRjdnMkVaa2JCbzF0VzFoMktuVllS?=
 =?utf-8?B?ZWUwOHZ6SXJEYlhrWG54UWRnKzZnbTJObG4xMGlBalYydzFqM2RVUGdhWFQx?=
 =?utf-8?B?Uk1wY1dkQytvc2JPVytQaHcyWVZoOXMxc0tUenFEUlBHQThoK1NTeDk4dWdX?=
 =?utf-8?B?Wm1oakgxT1p4cHl4VjUvb09tK253UENOeFI4ZUx6dnBJa3R4SUNYdURoRnBs?=
 =?utf-8?B?dkw0a2o1NktuTjFrRERlU3ROcy81U2ZKM1l3K3pqN1VyV3RpM3BYc0ZlVk04?=
 =?utf-8?B?ejM4OU1hUHlVdHZ2MGs0RmdCTW94TG9aQXV0UDBpRjNFZ1Fsb3VsandBaVVr?=
 =?utf-8?B?WGFxVWlLRVB0djEveGEwdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVBVOUYwVG5id3BFN1RIOUxnd3UrWVRwZVFOK0VHVnMzcFU2VlVzSnc4NndS?=
 =?utf-8?B?S0FFWm9jQVlJNkc0YUl3VXVMVEpvYm1CblRCWUx3ZnI0VDlSeTU2cHFqTFhG?=
 =?utf-8?B?ek9LWHYxb1Z2NHpWVENNK0tjMDFQQmY2cCtNQ002NFliOGhsTll5UkNJVG5z?=
 =?utf-8?B?RWt0NlVaQVRLWDlWVGZkNU1GVDZJc2Q2WjErYVl0WHlaNExvZm5JNGpaY0Zh?=
 =?utf-8?B?TlRnRmt5OERkY3plZm9kcXRiVitwSmlxamlOUXlhWDNGNjhwVDh6YzA0Q3Zr?=
 =?utf-8?B?c0NlaW9vcHg3YmVRS1M4QWFMbnJVa0NCeXB5cFR1cjB5YjRYUG5YblZVa0Zj?=
 =?utf-8?B?RHdFK1hxSm85bVQrUWZlNnM3ZnBnZGpFU2xzU0kxR1JZbE0zWVpHUURSMlJx?=
 =?utf-8?B?R2RHR3k2MjRhQWlEL0V3REI3N0xPM1NrM3R1a2Y4YnY3VkhPd0N6cStsNjZB?=
 =?utf-8?B?NFVYRjRZR3pNeWVWV3hGVStYY3NFaW1hTTczUlo3VmhVNzIyYXF3YTRMNWNh?=
 =?utf-8?B?bXl5SFZxZy9kRStSQmt6VnpwTE9uOXNudWovUnRXWG42UEpFaE9WZ0hYaHE0?=
 =?utf-8?B?YVBISHFPMFlJR3E5d2l3NVU1a1c4cnVuVW9odWs4Q1hjNjg0b2V4Q1VZeUlo?=
 =?utf-8?B?azBQVUpINEdoS3REcEZiSzdKT3NJYUlzdDYvOU9TMzlFbTZRTldXUHI3RFFP?=
 =?utf-8?B?QTBySm9XSWR5L3lKNDc2ZzVvaVZDd2tXYmFLTHRIWlpkU29GdjdGVWNTUjVC?=
 =?utf-8?B?Z3BZUkVpYjBzOERqcEZsV1lDQTJaZGtENFNWMmNFTGozZ1IyNCtza1BRNFhX?=
 =?utf-8?B?cE4yNFQ2WkdjTlQzcXdYVEpYRU1EdHc5NjlQalhuTzlXR2Y3REpPbkRBK0lE?=
 =?utf-8?B?QmxWaWdyNlRpMVFUb21rTWZaNkU5U1VzSXZERXFjK3YrbmZkZ0Fhb0UvaVFx?=
 =?utf-8?B?Q3NMeDVwRGRhR1JnNHlIb1BoNVNZdUNZbHFyT0U1NVhiYjM4WnZIVDYxbVZ3?=
 =?utf-8?B?bE9IT2d0SjdDVFgrS0x5RVVEMVBIV1h3L0xkY0VwQUpMSHBPSnMzMWxncldS?=
 =?utf-8?B?QXFGZ1d5anYyMWk5NTVyNU5kTnlTZnM0M3RpdjJzdHZjR3RhaWpVNHFyZCtO?=
 =?utf-8?B?VmdyRHJIVkFIallMR2xjUHg5T0UwZVEyMXIzM2NJTGNieU5TY29VOWk0cHk3?=
 =?utf-8?B?d21aUWRvSnB3SXBNMkg3OS9mZ2paUEdjWHlxeXRqU1V5TjdnbVV6dW9acGdj?=
 =?utf-8?B?SGxVMXp3ZTB3QTlteVozMnJGSk5ERjF4UFdDVHFEVGU1NGI4U2NMcHJDM0hs?=
 =?utf-8?B?Ly9rZ3FzUnkxMVFvdW1GUnFUbm04cWxyUElUREJIMnhYSllsL0RYTXNuN3d5?=
 =?utf-8?B?V0JCUXRUNkNneExXQTRwTGRuVlpXY2pFOWxEWUxUanF2SlYxZUNjbjVVejFl?=
 =?utf-8?B?V3pxN1JpOHlYOWk2OVhlNFAwVllvS1NMc0t5NmFVcm1xZEJTMUg2aXpxMXFo?=
 =?utf-8?B?N014RW1OSHFCRHNWNDl5WGNONWhNUFNmdmNmMDJKZGw0cjJoMmhtL0s3QXh4?=
 =?utf-8?B?OUFwSC9zWGFsR1NPQUhqeXVVVUNzVUg4bWw0dXVhejJqYkZ4Mit5T2hHTkFa?=
 =?utf-8?B?TTI5ZzFnYmQ5RE5BZE13MHc3aUFrMzk2SmorM2czU2J6QlVPVk5vamVoUnhi?=
 =?utf-8?B?WG9UKzF3Rjl0Qk5aTC9Ra2FZbFhmdkFQL2lEMDNTYjBkL1hoRjB6VE9Ba0l2?=
 =?utf-8?B?L0F2S3hYSE93Qk5nOU1BQkh4ZFVvT1BPNXF0ZE5wb2VpMTZyVnpTY2ZLUUFG?=
 =?utf-8?B?eU9NRTZpZmtxOTNTdkNydGNYSnFaem5Ob041MS95eWIzZHVCWEI3OXlyZXht?=
 =?utf-8?B?enljbDd1ZlJRaklENTFhQ3ZQOWxTSXdqRGZxcXJzdExlSDJSdGNmMFNjcHBi?=
 =?utf-8?B?SWtFM25WK2h4aWZpMzVwV0xXdFh2QVJ0V0xWQzR3ODZXdDR1bXhVQVkvUzA1?=
 =?utf-8?B?U0R4eTN0QWJYT3dhWmhJOVpEMXlqQTV0ZEdaOXBNQUdsYUd5SkVLNWZkOXA0?=
 =?utf-8?B?YWdRMzVkSnc3aHIyam01Uzl2VTZEMm1KR1NBUFV3Q3JQb3RjWjFwbGlQODEz?=
 =?utf-8?Q?uhzw2v4bYTOaQaumAjEVsmLPy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e6da99d-66d1-47fc-7062-08dcd1fa7cc1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 00:41:34.6834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7XDE+UUzdgq6c8Kg2b7WzxUrXb5pfX0mo1PqKTNzb+UcWK+rS8QZIxzHNQX9M/ASzsvJAJbbSpgh9o1dG0QOYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8173

On 9/10/2024 10:53 AM, Praveen Kaligineedi wrote:
> 
> From: Harshitha Ramamurthy <hramamurthy@google.com>

Hi Harshita!

> 
> For DQ queue format in raw DMA addressing(RDA) mode,
> implement page pool recycling of buffers by leveraging
> a few helper functions.
> 
> DQ QPL mode will continue to use the exisiting recycling

s/exisiting/existing/

> logic. This is because in QPL mode, the pages come from a
> constant set of pages that the driver pre-allocates and
> registers with the device.

I didn't look too deeply into this, but it looks like the call to 
xdp_rxq_info_reg_mem_model() didn't change from using 
MEM_TYPE_PAGE_SHARED to MEM_TYPE_PAGE_POOL.  Was this intentional?  Or 
did I miss it somewhere?  I suspect you'll want the machinery that goes 
with MEM_TYPE_PAGE_POOL.

Also, it seems this is always calling page_pool_put_page() with 
allow_direct set to true: this implies no locking is needed - e.g. 
you're in the napi softirq context.  Is this always true in the calling 
sequences?

Cheers,
sln

> 
> Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
> Reviewed-by: Shailend Chand <shailend@google.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> ---
>   drivers/net/ethernet/google/Kconfig           |   1 +
>   drivers/net/ethernet/google/gve/gve.h         |  15 +-
>   .../ethernet/google/gve/gve_buffer_mgmt_dqo.c | 166 +++++++++++++-----
>   drivers/net/ethernet/google/gve/gve_rx_dqo.c  |  88 +++++-----
>   4 files changed, 180 insertions(+), 90 deletions(-)
> 
> diff --git a/drivers/net/ethernet/google/Kconfig b/drivers/net/ethernet/google/Kconfig
> index 8641a00f8e63..564862a57124 100644
> --- a/drivers/net/ethernet/google/Kconfig
> +++ b/drivers/net/ethernet/google/Kconfig
> @@ -18,6 +18,7 @@ if NET_VENDOR_GOOGLE
>   config GVE
>          tristate "Google Virtual NIC (gVNIC) support"
>          depends on (PCI_MSI && (X86 || CPU_LITTLE_ENDIAN))
> +       select PAGE_POOL
>          help
>            This driver supports Google Virtual NIC (gVNIC)"
> 
> diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
> index 387fd26ebc43..5012ed6fbdb4 100644
> --- a/drivers/net/ethernet/google/gve/gve.h
> +++ b/drivers/net/ethernet/google/gve/gve.h
> @@ -13,6 +13,7 @@
>   #include <linux/netdevice.h>
>   #include <linux/pci.h>
>   #include <linux/u64_stats_sync.h>
> +#include <net/page_pool/helpers.h>
>   #include <net/xdp.h>
> 
>   #include "gve_desc.h"
> @@ -60,6 +61,8 @@
> 
>   #define GVE_DEFAULT_RX_BUFFER_OFFSET 2048
> 
> +#define GVE_PAGE_POOL_SIZE_MULTIPLIER 4
> +
>   #define GVE_FLOW_RULES_CACHE_SIZE \
>          (GVE_ADMINQ_BUFFER_SIZE / sizeof(struct gve_adminq_queried_flow_rule))
>   #define GVE_FLOW_RULE_IDS_CACHE_SIZE \
> @@ -102,6 +105,7 @@ struct gve_rx_slot_page_info {
>          struct page *page;
>          void *page_address;
>          u32 page_offset; /* offset to write to in page */
> +       unsigned int buf_size;
>          int pagecnt_bias; /* expected pagecnt if only the driver has a ref */
>          u16 pad; /* adjustment for rx padding */
>          u8 can_flip; /* tracks if the networking stack is using the page */
> @@ -273,6 +277,8 @@ struct gve_rx_ring {
> 
>                          /* Address info of the buffers for header-split */
>                          struct gve_header_buf hdr_bufs;
> +
> +                       struct page_pool *page_pool;
>                  } dqo;
>          };
> 
> @@ -1173,9 +1179,16 @@ struct gve_rx_buf_state_dqo *gve_dequeue_buf_state(struct gve_rx_ring *rx,
>   void gve_enqueue_buf_state(struct gve_rx_ring *rx, struct gve_index_list *list,
>                             struct gve_rx_buf_state_dqo *buf_state);
>   struct gve_rx_buf_state_dqo *gve_get_recycled_buf_state(struct gve_rx_ring *rx);
> -int gve_alloc_page_dqo(struct gve_rx_ring *rx, struct gve_rx_buf_state_dqo *buf_state);
>   void gve_try_recycle_buf(struct gve_priv *priv, struct gve_rx_ring *rx,
>                           struct gve_rx_buf_state_dqo *buf_state);
> +void gve_free_to_page_pool(struct gve_rx_ring *rx, struct gve_rx_buf_state_dqo *buf_state);
> +int gve_alloc_qpl_page_dqo(struct gve_rx_ring *rx, struct gve_rx_buf_state_dqo *buf_state);
> +void gve_free_qpl_page_dqo(struct gve_rx_buf_state_dqo *buf_state);
> +void gve_reuse_buffer(struct gve_rx_ring *rx, struct gve_rx_buf_state_dqo *buf_state);
> +void gve_free_buffer(struct gve_rx_ring *rx, struct gve_rx_buf_state_dqo *buf_state);
> +int gve_alloc_buffer(struct gve_rx_ring *rx, struct gve_rx_desc_dqo *desc);
> +struct page_pool *gve_rx_create_page_pool(struct gve_priv *priv, struct gve_rx_ring *rx);
> +
>   /* Reset */
>   void gve_schedule_reset(struct gve_priv *priv);
>   int gve_reset(struct gve_priv *priv, bool attempt_teardown);
> diff --git a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
> index a8ea23b407ed..c26461cb7cf4 100644
> --- a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
> +++ b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
> @@ -12,15 +12,6 @@ int gve_buf_ref_cnt(struct gve_rx_buf_state_dqo *bs)
>          return page_count(bs->page_info.page) - bs->page_info.pagecnt_bias;
>   }
> 
> -void gve_free_page_dqo(struct gve_priv *priv, struct gve_rx_buf_state_dqo *bs, bool free_page)
> -{
> -       page_ref_sub(bs->page_info.page, bs->page_info.pagecnt_bias - 1);
> -       if (free_page)
> -               gve_free_page(&priv->pdev->dev, bs->page_info.page, bs->addr,
> -                             DMA_FROM_DEVICE);
> -       bs->page_info.page = NULL;
> -}
> -
>   struct gve_rx_buf_state_dqo *gve_alloc_buf_state(struct gve_rx_ring *rx)
>   {
>          struct gve_rx_buf_state_dqo *buf_state;
> @@ -125,55 +116,27 @@ struct gve_rx_buf_state_dqo *gve_get_recycled_buf_state(struct gve_rx_ring *rx)
>                  gve_enqueue_buf_state(rx, &rx->dqo.used_buf_states, buf_state);
>          }
> 
> -       /* For QPL, we cannot allocate any new buffers and must
> -        * wait for the existing ones to be available.
> -        */
> -       if (rx->dqo.qpl)
> -               return NULL;
> -
> -       /* If there are no free buf states discard an entry from
> -        * `used_buf_states` so it can be used.
> -        */
> -       if (unlikely(rx->dqo.free_buf_states == -1)) {
> -               buf_state = gve_dequeue_buf_state(rx, &rx->dqo.used_buf_states);
> -               if (gve_buf_ref_cnt(buf_state) == 0)
> -                       return buf_state;
> -
> -               gve_free_page_dqo(rx->gve, buf_state, true);
> -               gve_free_buf_state(rx, buf_state);
> -       }
> -
>          return NULL;
>   }
> 
> -int gve_alloc_page_dqo(struct gve_rx_ring *rx, struct gve_rx_buf_state_dqo *buf_state)
> +int gve_alloc_qpl_page_dqo(struct gve_rx_ring *rx, struct gve_rx_buf_state_dqo *buf_state)
>   {
>          struct gve_priv *priv = rx->gve;
>          u32 idx;
> 
> -       if (!rx->dqo.qpl) {
> -               int err;
> -
> -               err = gve_alloc_page(priv, &priv->pdev->dev,
> -                                    &buf_state->page_info.page,
> -                                    &buf_state->addr,
> -                                    DMA_FROM_DEVICE, GFP_ATOMIC);
> -               if (err)
> -                       return err;
> -       } else {
> -               idx = rx->dqo.next_qpl_page_idx;
> -               if (idx >= gve_get_rx_pages_per_qpl_dqo(priv->rx_desc_cnt)) {
> -                       net_err_ratelimited("%s: Out of QPL pages\n",
> -                                           priv->dev->name);
> -                       return -ENOMEM;
> -               }
> -               buf_state->page_info.page = rx->dqo.qpl->pages[idx];
> -               buf_state->addr = rx->dqo.qpl->page_buses[idx];
> -               rx->dqo.next_qpl_page_idx++;
> +       idx = rx->dqo.next_qpl_page_idx;
> +       if (idx >= gve_get_rx_pages_per_qpl_dqo(priv->rx_desc_cnt)) {
> +               net_err_ratelimited("%s: Out of QPL pages\n",
> +                                   priv->dev->name);
> +               return -ENOMEM;
>          }
> +       buf_state->page_info.page = rx->dqo.qpl->pages[idx];
> +       buf_state->addr = rx->dqo.qpl->page_buses[idx];
> +       rx->dqo.next_qpl_page_idx++;
>          buf_state->page_info.page_offset = 0;
>          buf_state->page_info.page_address =
>                  page_address(buf_state->page_info.page);
> +       buf_state->page_info.buf_size = priv->data_buffer_size_dqo;
>          buf_state->last_single_ref_offset = 0;
> 
>          /* The page already has 1 ref. */
> @@ -183,6 +146,15 @@ int gve_alloc_page_dqo(struct gve_rx_ring *rx, struct gve_rx_buf_state_dqo *buf_
>          return 0;
>   }
> 
> +void gve_free_qpl_page_dqo(struct gve_rx_buf_state_dqo *buf_state)
> +{
> +       if (!buf_state->page_info.page)
> +               return;
> +
> +       page_ref_sub(buf_state->page_info.page, buf_state->page_info.pagecnt_bias - 1);
> +       buf_state->page_info.page = NULL;
> +}
> +
>   void gve_try_recycle_buf(struct gve_priv *priv, struct gve_rx_ring *rx,
>                           struct gve_rx_buf_state_dqo *buf_state)
>   {
> @@ -224,3 +196,103 @@ void gve_try_recycle_buf(struct gve_priv *priv, struct gve_rx_ring *rx,
>          gve_enqueue_buf_state(rx, &rx->dqo.used_buf_states, buf_state);
>          rx->dqo.used_buf_states_cnt++;
>   }
> +
> +void gve_free_to_page_pool(struct gve_rx_ring *rx, struct gve_rx_buf_state_dqo *buf_state)
> +{
> +       struct page *page = buf_state->page_info.page;
> +
> +       if (!page)
> +               return;
> +
> +       page_pool_put_page(page->pp, page, buf_state->page_info.buf_size, true);
> +       buf_state->page_info.page = NULL;
> +}
> +
> +static int gve_alloc_from_page_pool(struct gve_rx_ring *rx, struct gve_rx_buf_state_dqo *buf_state)
> +{
> +       struct gve_priv *priv = rx->gve;
> +       struct page *page;
> +
> +       buf_state->page_info.buf_size = priv->data_buffer_size_dqo;
> +       page = page_pool_alloc(rx->dqo.page_pool, &buf_state->page_info.page_offset,
> +                              &buf_state->page_info.buf_size, GFP_ATOMIC);
> +
> +       if (!page) {
> +               priv->page_alloc_fail++;
> +               return -ENOMEM;
> +       }
> +
> +       buf_state->page_info.page = page;
> +       buf_state->page_info.page_address = page_address(page);
> +       buf_state->addr = page_pool_get_dma_addr(page);
> +
> +       return 0;
> +}
> +
> +struct page_pool *gve_rx_create_page_pool(struct gve_priv *priv, struct gve_rx_ring *rx)
> +{
> +       struct page_pool_params pp = {
> +               .flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
> +               .order = 0,
> +               .pool_size = GVE_PAGE_POOL_SIZE_MULTIPLIER * priv->rx_desc_cnt,
> +               .dev = &priv->pdev->dev,
> +               .netdev = priv->dev,
> +               .max_len = PAGE_SIZE,
> +               .dma_dir = DMA_FROM_DEVICE,
> +       };
> +
> +       return page_pool_create(&pp);
> +}
> +
> +void gve_free_buffer(struct gve_rx_ring *rx, struct gve_rx_buf_state_dqo *buf_state)
> +{
> +       if (rx->dqo.page_pool) {
> +               gve_free_to_page_pool(rx, buf_state);
> +               gve_free_buf_state(rx, buf_state);
> +       } else {
> +               gve_enqueue_buf_state(rx, &rx->dqo.recycled_buf_states, buf_state);
> +       }
> +}
> +
> +void gve_reuse_buffer(struct gve_rx_ring *rx, struct gve_rx_buf_state_dqo *buf_state)
> +{
> +       if (rx->dqo.page_pool) {
> +               buf_state->page_info.page = NULL;
> +               gve_free_buf_state(rx, buf_state);
> +       } else {
> +               gve_dec_pagecnt_bias(&buf_state->page_info);
> +               gve_try_recycle_buf(rx->gve, rx, buf_state);
> +       }
> +}
> +
> +int gve_alloc_buffer(struct gve_rx_ring *rx, struct gve_rx_desc_dqo *desc)
> +{
> +       struct gve_rx_buf_state_dqo *buf_state;
> +
> +       if (rx->dqo.page_pool) {
> +               buf_state = gve_alloc_buf_state(rx);
> +               if (WARN_ON_ONCE(!buf_state))
> +                       return -ENOMEM;
> +
> +               if (gve_alloc_from_page_pool(rx, buf_state))
> +                       goto free_buf_state;
> +       } else {
> +               buf_state = gve_get_recycled_buf_state(rx);
> +               if (unlikely(!buf_state)) {
> +                       buf_state = gve_alloc_buf_state(rx);
> +                       if (unlikely(!buf_state))
> +                               return -ENOMEM;
> +
> +                       if (unlikely(gve_alloc_qpl_page_dqo(rx, buf_state)))
> +                               goto free_buf_state;
> +               }
> +       }
> +       desc->buf_id = cpu_to_le16(buf_state - rx->dqo.buf_states);
> +       desc->buf_addr = cpu_to_le64(buf_state->addr + buf_state->page_info.page_offset);
> +
> +       return 0;
> +
> +free_buf_state:
> +       gve_free_buf_state(rx, buf_state);
> +       return -ENOMEM;
> +}
> diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> index b343be2fb118..250c0302664c 100644
> --- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> +++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> @@ -95,8 +95,10 @@ static void gve_rx_reset_ring_dqo(struct gve_priv *priv, int idx)
>                  for (i = 0; i < rx->dqo.num_buf_states; i++) {
>                          struct gve_rx_buf_state_dqo *bs = &rx->dqo.buf_states[i];
> 
> -                       if (bs->page_info.page)
> -                               gve_free_page_dqo(priv, bs, !rx->dqo.qpl);
> +                       if (rx->dqo.page_pool)
> +                               gve_free_to_page_pool(rx, bs);
> +                       else
> +                               gve_free_qpl_page_dqo(bs);
>                  }
>          }
> 
> @@ -138,9 +140,11 @@ void gve_rx_free_ring_dqo(struct gve_priv *priv, struct gve_rx_ring *rx,
> 
>          for (i = 0; i < rx->dqo.num_buf_states; i++) {
>                  struct gve_rx_buf_state_dqo *bs = &rx->dqo.buf_states[i];
> -               /* Only free page for RDA. QPL pages are freed in gve_main. */
> -               if (bs->page_info.page)
> -                       gve_free_page_dqo(priv, bs, !rx->dqo.qpl);
> +
> +               if (rx->dqo.page_pool)
> +                       gve_free_to_page_pool(rx, bs);
> +               else
> +                       gve_free_qpl_page_dqo(bs);
>          }
> 
>          if (rx->dqo.qpl) {
> @@ -167,6 +171,11 @@ void gve_rx_free_ring_dqo(struct gve_priv *priv, struct gve_rx_ring *rx,
>          kvfree(rx->dqo.buf_states);
>          rx->dqo.buf_states = NULL;
> 
> +       if (rx->dqo.page_pool) {
> +               page_pool_destroy(rx->dqo.page_pool);
> +               rx->dqo.page_pool = NULL;
> +       }
> +
>          gve_rx_free_hdr_bufs(priv, rx);
> 
>          netif_dbg(priv, drv, priv->dev, "freed rx ring %d\n", idx);
> @@ -199,6 +208,7 @@ int gve_rx_alloc_ring_dqo(struct gve_priv *priv,
>                            int idx)
>   {
>          struct device *hdev = &priv->pdev->dev;
> +       struct page_pool *pool;
>          int qpl_page_cnt;
>          size_t size;
>          u32 qpl_id;
> @@ -212,8 +222,7 @@ int gve_rx_alloc_ring_dqo(struct gve_priv *priv,
>          rx->gve = priv;
>          rx->q_num = idx;
> 
> -       rx->dqo.num_buf_states = cfg->raw_addressing ?
> -               min_t(s16, S16_MAX, buffer_queue_slots * 4) :
> +       rx->dqo.num_buf_states = cfg->raw_addressing ? buffer_queue_slots :
>                  gve_get_rx_pages_per_qpl_dqo(cfg->ring_size);
>          rx->dqo.buf_states = kvcalloc(rx->dqo.num_buf_states,
>                                        sizeof(rx->dqo.buf_states[0]),
> @@ -241,7 +250,13 @@ int gve_rx_alloc_ring_dqo(struct gve_priv *priv,
>          if (!rx->dqo.bufq.desc_ring)
>                  goto err;
> 
> -       if (!cfg->raw_addressing) {
> +       if (cfg->raw_addressing) {
> +               pool = gve_rx_create_page_pool(priv, rx);
> +               if (IS_ERR(pool))
> +                       goto err;
> +
> +               rx->dqo.page_pool = pool;
> +       } else {
>                  qpl_id = gve_get_rx_qpl_id(cfg->qcfg_tx, rx->q_num);
>                  qpl_page_cnt = gve_get_rx_pages_per_qpl_dqo(cfg->ring_size);
> 
> @@ -338,26 +353,14 @@ void gve_rx_post_buffers_dqo(struct gve_rx_ring *rx)
>          num_avail_slots = min_t(u32, num_avail_slots, complq->num_free_slots);
>          while (num_posted < num_avail_slots) {
>                  struct gve_rx_desc_dqo *desc = &bufq->desc_ring[bufq->tail];
> -               struct gve_rx_buf_state_dqo *buf_state;
> -
> -               buf_state = gve_get_recycled_buf_state(rx);
> -               if (unlikely(!buf_state)) {
> -                       buf_state = gve_alloc_buf_state(rx);
> -                       if (unlikely(!buf_state))
> -                               break;
> -
> -                       if (unlikely(gve_alloc_page_dqo(rx, buf_state))) {
> -                               u64_stats_update_begin(&rx->statss);
> -                               rx->rx_buf_alloc_fail++;
> -                               u64_stats_update_end(&rx->statss);
> -                               gve_free_buf_state(rx, buf_state);
> -                               break;
> -                       }
> +
> +               if (unlikely(gve_alloc_buffer(rx, desc))) {
> +                       u64_stats_update_begin(&rx->statss);
> +                       rx->rx_buf_alloc_fail++;
> +                       u64_stats_update_end(&rx->statss);
> +                       break;
>                  }
> 
> -               desc->buf_id = cpu_to_le16(buf_state - rx->dqo.buf_states);
> -               desc->buf_addr = cpu_to_le64(buf_state->addr +
> -                                            buf_state->page_info.page_offset);
>                  if (rx->dqo.hdr_bufs.data)
>                          desc->header_buf_addr =
>                                  cpu_to_le64(rx->dqo.hdr_bufs.addr +
> @@ -488,6 +491,9 @@ static int gve_rx_append_frags(struct napi_struct *napi,
>                  if (!skb)
>                          return -1;
> 
> +               if (rx->dqo.page_pool)
> +                       skb_mark_for_recycle(skb);
> +
>                  if (rx->ctx.skb_tail == rx->ctx.skb_head)
>                          skb_shinfo(rx->ctx.skb_head)->frag_list = skb;
>                  else
> @@ -498,7 +504,7 @@ static int gve_rx_append_frags(struct napi_struct *napi,
>          if (rx->ctx.skb_tail != rx->ctx.skb_head) {
>                  rx->ctx.skb_head->len += buf_len;
>                  rx->ctx.skb_head->data_len += buf_len;
> -               rx->ctx.skb_head->truesize += priv->data_buffer_size_dqo;
> +               rx->ctx.skb_head->truesize += buf_state->page_info.buf_size;
>          }
> 
>          /* Trigger ondemand page allocation if we are running low on buffers */
> @@ -508,13 +514,9 @@ static int gve_rx_append_frags(struct napi_struct *napi,
>          skb_add_rx_frag(rx->ctx.skb_tail, num_frags,
>                          buf_state->page_info.page,
>                          buf_state->page_info.page_offset,
> -                       buf_len, priv->data_buffer_size_dqo);
> -       gve_dec_pagecnt_bias(&buf_state->page_info);
> +                       buf_len, buf_state->page_info.buf_size);
> 
> -       /* Advances buffer page-offset if page is partially used.
> -        * Marks buffer as used if page is full.
> -        */
> -       gve_try_recycle_buf(priv, rx, buf_state);
> +       gve_reuse_buffer(rx, buf_state);
>          return 0;
>   }
> 
> @@ -548,8 +550,7 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
>          }
> 
>          if (unlikely(compl_desc->rx_error)) {
> -               gve_enqueue_buf_state(rx, &rx->dqo.recycled_buf_states,
> -                                     buf_state);
> +               gve_free_buffer(rx, buf_state);
>                  return -EINVAL;
>          }
> 
> @@ -573,6 +574,9 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
>                          if (unlikely(!rx->ctx.skb_head))
>                                  goto error;
>                          rx->ctx.skb_tail = rx->ctx.skb_head;
> +
> +                       if (rx->dqo.page_pool)
> +                               skb_mark_for_recycle(rx->ctx.skb_head);
>                  } else {
>                          unsplit = 1;
>                  }
> @@ -609,8 +613,7 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
>                  rx->rx_copybreak_pkt++;
>                  u64_stats_update_end(&rx->statss);
> 
> -               gve_enqueue_buf_state(rx, &rx->dqo.recycled_buf_states,
> -                                     buf_state);
> +               gve_free_buffer(rx, buf_state);
>                  return 0;
>          }
> 
> @@ -625,16 +628,17 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
>                  return 0;
>          }
> 
> +       if (rx->dqo.page_pool)
> +               skb_mark_for_recycle(rx->ctx.skb_head);
> +
>          skb_add_rx_frag(rx->ctx.skb_head, 0, buf_state->page_info.page,
>                          buf_state->page_info.page_offset, buf_len,
> -                       priv->data_buffer_size_dqo);
> -       gve_dec_pagecnt_bias(&buf_state->page_info);
> -
> -       gve_try_recycle_buf(priv, rx, buf_state);
> +                       buf_state->page_info.buf_size);
> +       gve_reuse_buffer(rx, buf_state);
>          return 0;
> 
>   error:
> -       gve_enqueue_buf_state(rx, &rx->dqo.recycled_buf_states, buf_state);
> +       gve_free_buffer(rx, buf_state);
>          return -ENOMEM;
>   }
> 
> --
> 2.46.0.598.g6f2099f65c-goog
> 
> 

