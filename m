Return-Path: <netdev+bounces-139075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D749AFFD9
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 12:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C0A21F220F0
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 10:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4381D90DD;
	Fri, 25 Oct 2024 10:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tzCLzj4G"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4791622B672;
	Fri, 25 Oct 2024 10:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729851425; cv=fail; b=MTks578u6VZe4B38GYDf+HExTSdWUzb9eMonmcUkeD/i6SzwzbIExvIVeQsLs/eaf6Yh9U7749Kc59wVsoBEWRrpFWrVTgP3bWDTEEJyFsk0kuGGmswpdIYhSFftkB6ixllWvsHq0pKfvQo1FBqhx5po7RwhNoIfyWC7OkeYHVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729851425; c=relaxed/simple;
	bh=xe3bXwsWK8e5WEOVqTuTt6cDBvciygkTxdaLpavXqO0=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jwdc8Doo7cjciqV9WrgtoZWb/MV1ecO5y+nHkH7UbTKSDChepS64nRQhGklpnWBmxIMJ9IHaKfs5e2OBr8qSPZxjyYwNNh7HuTCPEwWfe49q8j+emcPnyDFtjSYLOIhmLf9CTq7kwczj+Y1R28xY0N01law29bTpcCCAFIpcMLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tzCLzj4G; arc=fail smtp.client-ip=40.107.243.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hxiiwoNFOkQPsTTTVasw2Lua4qc5DQ6cAp6rYZVouYX/8b3FLc4zZWr88lN4yWaJU6x+j3HazAhwvVZKotnjOu9GUHKCDpKFMsXwzIJI0ME9wgT+PDc9PN/oPtOGEO4mW5lRPPYzPYmFUYJrOv0Ss9aYPuy7VjkCC4WsAW2nYVKpPRj8mFVLRXjgVmzQZz3aF22kiXKlr7EaIHuqW9L6hVUqF6e3WaZylEQkBTamB6yITU2RyewnS09snQYUXagBKYu+sC94+rYUwyo3nx8rMGdwWO150QIdfibxfA9o93UVYXjKhfO1ccWTulybhXzpg8TbjtH82gnwb3CyzVxx9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0LYrgroElEkl+PSBV1ACyz00NJm4JyDbRyq6a08AOw=;
 b=TaIf3t9DTnTb+uqijJrpO3lmQt2EkDw1KdOKU/ZdL9Nv3pLym2ENK0yuWAdeYC3b0JjwZjNC68gZuy0O1QKzqtuczQRqjx3uVUXxASUroCnKB9Fn+qOXDYffXNwIHDGvcUlqJkyZs7RjDLRtZe0LsqLBcD4B1HLUvS55zl7UpwYsmstrjkjig8bmmY7vpPgWTmXq/P47xk3Bia7wC2+hdgg9n/ujb5NmrK8ZCdB6itxfznKFWIIwGCGasw/elDMsXicrxzqELsukZcZNc1hAg+2YxsYzgXeiBVji93dxlDOsu1aEgoH82TgPaDbWctdNe76K7f+fmWOm4mAnsFVMzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0LYrgroElEkl+PSBV1ACyz00NJm4JyDbRyq6a08AOw=;
 b=tzCLzj4GijDXoUgHDQAIvkYu8D/XoR613w3gFrYP4ylOA73kbpYn9cAL4MmLe/iSf+JpCLFGhxqjLZppbdhiegUSC7NJgMeDGNyd1zCS5Mc0pRuPNDM4iSXZq2SfuKMajy2KcwmniyNPRTP+Gw6P+9Rg9ov2buB2j/N+/I+ULsk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DM4PR12MB6662.namprd12.prod.outlook.com (2603:10b6:8:b5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.22; Fri, 25 Oct
 2024 10:17:00 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8093.021; Fri, 25 Oct 2024
 10:17:00 +0000
Message-ID: <9dba2210-5488-25d8-c065-f6a2c4fa2d82@amd.com>
Date: Fri, 25 Oct 2024 11:16:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 04/26] cxl/pci: add check for validating capabilities
Content-Language: en-US
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
References: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
 <20241017165225.21206-5-alejandro.lucero-palau@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20241017165225.21206-5-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0306.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::11) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DM4PR12MB6662:EE_
X-MS-Office365-Filtering-Correlation-Id: 808406b6-ef07-421d-eb09-08dcf4de29b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Sk5ScTU0Q2VwcEtLaW5SWnBsS00rWmdwVXRWZHRnclJxNWlGckxhTVRYUUE0?=
 =?utf-8?B?bDZtYXFWa2hiY2h4SlBQU1VXZ0VITmF6dHlrdldQdWVpMjFER2hWU1JRTG45?=
 =?utf-8?B?TWEyNXJ3bE9RQjNtUThJWFlldlgrTzFyNWdEWU5KTGJsUk1XSkpGb1U1MEto?=
 =?utf-8?B?TTk3ekt4SHpPZWh6ZDdhUkRDZ3BwTGRlYzFORitYaHk5NG5mQ0VTd2F2V0VV?=
 =?utf-8?B?UHdyNVdlaFVyNXB5U0dZN0Jkc0gzdHdjbTUrSVp1QjNLSWFPMThnOVdXTDhS?=
 =?utf-8?B?NGRLa2dqTUpZdVFsbEx2NzQ4ejdOckw2eXFJak9HM2tiVmJZUUNrNVZLMjl0?=
 =?utf-8?B?QUpoNUJMR084dVNwUVRNd2hDRHVYdDBjU1VEb2NaRGJVZGdzdWllZVlCNGg0?=
 =?utf-8?B?aEJlZEczUUsvWHh3L0NVeVFUM1ByNVZFcHR4MTl3VjdiZEdxWmpvL3pWSlAy?=
 =?utf-8?B?YUswOUt6c2pGVjduZzErTDU2dzA3R2tkd085T3g2UXUzWFJkWlRXV3g0Z0RE?=
 =?utf-8?B?bHgwam9obUFFQnNOcFNrc3RQNi95L0o0amIveGlndDJ0N21pTytnUlh3T1ky?=
 =?utf-8?B?Z3NYbnloUkcrSHZEMncvUExkMGJFOXRuWnpKZVJkb2IxVFVSK0F4RnJHRnVN?=
 =?utf-8?B?Z0JpNzJwTlZYdHRjK3dhcTFDbUNtbEQ2dnNnR1c0QThjaW0zK3ZDdTZxcVJJ?=
 =?utf-8?B?ajcrT2lEWklCbEJDVGNuRk41UDZLYXpYd3RtOVZ6S3VXdUZHS2dqU0lqMy9l?=
 =?utf-8?B?cWpoZnk1dTl5UytMUGYySFZtWlk4Q0lzcS9VUmh5aUVwb0ttcXloMlFhU0lX?=
 =?utf-8?B?L0tWSUJSZTVoV0ZlRnJQaDNzL2xyV2VGVDJIWVZLSVNvT29helN3a0luY29J?=
 =?utf-8?B?OXVNc1Y1VDE0YlZrNUVJNG9lWGJFYTJoSnUzMWJEdDFxcXpCMUFMNWhBNlpl?=
 =?utf-8?B?enpDQXBLbThRbXRmRFB4T21hL3ZRdHNXYlBoaUxGSTkyeGFweDlNbHRJVTlx?=
 =?utf-8?B?emowTUdnNWFHNjNjRk1uL21xSmVMSmJmZjBKY2hqek15TndJVkp6ZWVIU1dH?=
 =?utf-8?B?VDhVdVhveGlLTUcvdS9nakVnVjBqdUR4U2hHZWZIb0JUMUNKclcrNGZxUk1u?=
 =?utf-8?B?bTRjbXBOOWk0bU4rTXBLVFM0bWQvdU90Vld3SVpTU3JOQ2tzWHhoS1NTanVz?=
 =?utf-8?B?Ym1jb3NLbDlraFM4dmxEcHh1V2ZiUDIwVEMxa1Avd2x6T0NCV0w0NFc0ZEY1?=
 =?utf-8?B?SjZrMEEzYWlYWEJRM0tkbVptbXZjSUVkOFBGWDhObHpUNjJoZVg1Ri9JenBm?=
 =?utf-8?B?bTRaOUZFbDBOeS9xUVUzaCtCRUhzdit5U0FJcUM5QXczWlFINjdzU2ZwazB6?=
 =?utf-8?B?K29jKytlTWQvR1hlZ0pQTDRDQWJBQjYrbzB1T1QxMEwyY0pOK2NaNzBiaEla?=
 =?utf-8?B?bzAzby82eVJjeUxDV05RZDJsaVJxR2JOSi9nZjVBeTBXYXU1ZlhpY25FSkJL?=
 =?utf-8?B?dTM3cDdYUnl6UjZiakQvNEsyMi9ZVEJTODk0eGVCS1dGZVdsb0plT25qaWps?=
 =?utf-8?B?VVY5V1JSSExOSGlvZGJORG1mS3A0TXRGTGlHV0UyMS9RZWZxbmY4SU5FaVRv?=
 =?utf-8?B?Lyt6ZE5jSTRmWnZxTm01em1ROUlidFhlK2k1NVk0SEtNMzNybUhtNytaanBy?=
 =?utf-8?B?TkNkRjlkVTlRaDd2aldCQWRINUJ2cm1JWE50Q3BRejN3T2YyZG1FTzN3Z3lH?=
 =?utf-8?B?eWwzN3JRUFlFU3p4WC9DVHJtNWFaNmlYbFZ4bUZ0NERUR3ZBTlZ6czNxTFMz?=
 =?utf-8?Q?ZRfbqx8TSg5ljfSJMuM9s+jB2v/5Xc5R46SgI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YmxzWng3a21LRjliTjFxeHhYWXRLRjg1aUozOGNGUTY3QkNvSWdjcTdCbEk1?=
 =?utf-8?B?LzljSUdwdXVjL3RCaXVlemhyQlFZUzNyZ2VheVUvQTNyOGt1WHlYQ1BLK2o3?=
 =?utf-8?B?Z01XM1BiY3c0WTQ4QmhoVjdhdXNKZHB2TlY0aUpaSzFSSTlOVWw1bFpiR1o1?=
 =?utf-8?B?b29hYUl6cWJvNnJtWWl5MU1NVXdpOVYxekl6MVNYKzZHalIxaFNkeGVOdmVs?=
 =?utf-8?B?bXJkQndVU1cyekZ4WGlyL0Y5REZxQm05dUExeVpxcm1sNkV6Y3N2Q202dDB3?=
 =?utf-8?B?YUltNXBldDVlY240bXBTWDZPLzBrdHdZSlh2cGZDNjBuS0dqckVOUXh4ZVBn?=
 =?utf-8?B?U2FoVW9IMHdmbEsremc3M2RtaTdURnJVOVFibE1EakNMZlAyaGo5cGMrMzR5?=
 =?utf-8?B?dElOZmFpQXZnZVlHSVgzR0d4aGsxelFnZm5ZRnNHS3E4M05vTXdsUlBiNXp2?=
 =?utf-8?B?S29SL0hhL2JWZlZDY3ZrbEpRY3BGbEtSOUV0T3NqZUF2NFM2aUFYU2pQQmZk?=
 =?utf-8?B?MkZUekNDT0h5SzhBZytralZoeEJQM0tqSjlGMmk5UzRRSDhneFRzS0RSa1hp?=
 =?utf-8?B?Vk43d3VKclgwTldZanlFbUNYUmxiMHpjbjlsaEd3WTlaVUJCcWFzZCtsK3RJ?=
 =?utf-8?B?eTJ3bk5oczRSVEg2azhLb2VJaVQxOGZZMkJ4Q2o0UytFWk9ySnV3ZGVoOVNE?=
 =?utf-8?B?Ykc3MCtMNEVVQnRoU0VYZXNnNU9lR3hhV1l4amd2RDVmVVkwdFdSclNMcVYx?=
 =?utf-8?B?djNZbjNMaGRwSHFYa1Q3QndqTmpFTTJZa1BZZXRHdUUvendNQjlMWnJ5RzBp?=
 =?utf-8?B?YnNFWjRPSE9waSt6RVMvNlFmUE1QcWlCdGtmdjczcnpFWXBiTjZycGxCZlY0?=
 =?utf-8?B?SmNxSzd2dU1MYTV1NDZvU21ibDFFdnUrcE1KZHZrMFdiOTk5TWNlRGpKMlFs?=
 =?utf-8?B?K2RyYVoyWEtyYS9IcDZodlVSZXJHdVNDM0g2Nno2UXM1NE00c3FidlhvMlJN?=
 =?utf-8?B?Z05la0hRdFAwYWt2c1ZQcjF1TWE5djdqbmpONTFqTGlmUENzcnFobnl5dHJp?=
 =?utf-8?B?Tm5GUGJ6c2Y3QUtFeGt2VkkyVGJVS24rRThCdGRGLytLcDZ0eTVXOEZ3YUcy?=
 =?utf-8?B?d1VKZUs2R0lrbm5oRGlPcGI4UDJMdnV6akhrcGVJZk1qTGVnNisyNnZEZVBZ?=
 =?utf-8?B?eEdZTTA0WEJpTFprYURONjhSWWRQZlRYcjBiL1JZNUw2WTB4a3A3dDArMXZC?=
 =?utf-8?B?eW5UMlRjL0dybHdxblJFeWU5U0cwb0tDbyt3djBhTmZ2TXZmUlp3U0NleVVL?=
 =?utf-8?B?bnljbWtyK050U2poRjg0RGNybU5sdGZrNXJrTkpmcTNhbkJJam52N2Vlblhu?=
 =?utf-8?B?UEpLbmdPVHFOS1VzckJKSExFOUZOMGFtYUtXc3E5T0xvK1B0eGJzWFhvL3NJ?=
 =?utf-8?B?V3cxRzdIeW1tdUMvZzZDRG5LLzJ1aXo3UExqek1KNnJhRHFqT1E3QTFRZUt4?=
 =?utf-8?B?VkZEeTRYNlV5QUdJQlRtMWI5ZldKOUswSFlmSXM1d3lid0U4OTVlS3JZdjZM?=
 =?utf-8?B?djhXZytDM01CbTArTEEyOXBHVXJtaDFDZmtmWjFYaVcvYVp2czNyU0JrRXBH?=
 =?utf-8?B?dUZrMDg1cGNxdEpqZS9GelN1NG9ySUowZkd4YmR3Q0xMWkFjQUhiR0NmN1VH?=
 =?utf-8?B?MlRPNWQvYllLbk1BdGtVc2FTSDhPLzRCUTVXTFE4S3ZYc09nM2srQThKU1Rn?=
 =?utf-8?B?VTNHTjhtTDdaS3hSMk5Hc3piY3ZYUGp3S213dldKeHdwa05UeUg0UnJtaUJP?=
 =?utf-8?B?TkVQRG1ONzdYSmU1ZmFBV1Z3bkwza2hxL3M5YUU1SG0vRE9LMjZUVmNrcUI2?=
 =?utf-8?B?d3U1U204L1lSNStWQ24vRnpHZGVHdVVnVldkekJWL2NuVW9BazJhYWh4L0RZ?=
 =?utf-8?B?eGRxVDF6L0daM0RIMEl1U1Q2NTUwYklsTVRKOUVMc012TXhKV0NqUUxWMENt?=
 =?utf-8?B?SGFsTTRJMWFSZUNkNzBFK05pR2VGRXp6U1RWRENMODhDTzczM2tUVVYreTE3?=
 =?utf-8?B?NzVieFJBbU53VC9XZitSZ2JMcFRWbGtHekVMQk45b0V4RTZLRkZyMVRJbEFz?=
 =?utf-8?Q?BSsj8pMGGs8J1B1/Gsq31y0Xo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 808406b6-ef07-421d-eb09-08dcf4de29b2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 10:17:00.1700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zFzvtQrD/RIsqaoXOmAmX5B+uBvve4+pil5XtWmgt5A5NaT7MhZXippSkMqeK9ykRh4T02G+hAbYwmrLuj/EyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6662


On 10/17/24 17:52, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
>
> During CXL device initialization supported capabilities by the device
> are discovered. Type3 and Type2 devices have different mandatory
> capabilities and a Type2 expects a specific set including optional
> capabilities.
>
> Add a function for checking expected capabilities against those found
> during initialization.
>
> Rely on this function for validating capabilities instead of when CXL
> regs are probed.
>
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>   drivers/cxl/core/pci.c  | 14 ++++++++++++++
>   drivers/cxl/core/regs.c |  9 ---------
>   drivers/cxl/pci.c       | 17 +++++++++++++++++
>   include/linux/cxl/cxl.h |  3 +++
>   4 files changed, 34 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 3d6564dbda57..fa2a5e216dc3 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -8,6 +8,7 @@
>   #include <linux/pci-doe.h>
>   #include <linux/aer.h>
>   #include <linux/cxl/pci.h>
> +#include <linux/cxl/cxl.h>
>   #include <cxlpci.h>
>   #include <cxlmem.h>
>   #include <cxl.h>
> @@ -1077,3 +1078,16 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port)
>   				     __cxl_endpoint_decoder_reset_detected);
>   }
>   EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_reset_detected, CXL);
> +
> +bool cxl_pci_check_caps(struct cxl_dev_state *cxlds, unsigned long *expected_caps,
> +			unsigned long *current_caps)
> +{
> +	if (current_caps)
> +		bitmap_copy(current_caps, cxlds->capabilities, CXL_MAX_CAPS);
> +
> +	dev_dbg(cxlds->dev, "Checking cxlds caps 0x%08lx vs expected caps 0x%08lx\n",
> +		*cxlds->capabilities, *expected_caps);
> +
> +	return bitmap_equal(cxlds->capabilities, expected_caps, CXL_MAX_CAPS);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_pci_check_caps, CXL);
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 9d63a2adfd42..6fbc5c57149e 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -444,15 +444,6 @@ static int cxl_probe_regs(struct cxl_register_map *map, unsigned long *caps)
>   	case CXL_REGLOC_RBI_MEMDEV:
>   		dev_map = &map->device_map;
>   		cxl_probe_device_regs(host, base, dev_map, caps);
> -		if (!dev_map->status.valid || !dev_map->mbox.valid ||
> -		    !dev_map->memdev.valid) {
> -			dev_err(host, "registers not found: %s%s%s\n",
> -				!dev_map->status.valid ? "status " : "",
> -				!dev_map->mbox.valid ? "mbox " : "",
> -				!dev_map->memdev.valid ? "memdev " : "");
> -			return -ENXIO;
> -		}
> -
>   		dev_dbg(host, "Probing device registers...\n");
>   		break;
>   	default:
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 6cd7ab117f80..89c8ac1a61fd 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -792,6 +792,8 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
>   static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   {
>   	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
> +	DECLARE_BITMAP(expected, CXL_MAX_CAPS);
> +	DECLARE_BITMAP(found, CXL_MAX_CAPS);
>   	struct cxl_memdev_state *mds;
>   	struct cxl_dev_state *cxlds;
>   	struct cxl_register_map map;
> @@ -853,6 +855,21 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   	if (rc)
>   		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
>   
> +	bitmap_clear(expected, 0, BITS_PER_TYPE(unsigned long));
> +
> +	/* These are the mandatory capabilities for a Type3 device */
> +	bitmap_set(expected, CXL_DEV_CAP_HDM, 1);
> +	bitmap_set(expected, CXL_DEV_CAP_DEV_STATUS, 1);
> +	bitmap_set(expected, CXL_DEV_CAP_MAILBOX_PRIMARY, 1);
> +	bitmap_set(expected, CXL_DEV_CAP_DEV_STATUS, 1);
> +
> +	if (!cxl_pci_check_caps(cxlds, expected, found)) {
> +		dev_err(&pdev->dev,
> +			"Expected capabilities not matching with found capabilities: (%08lx - %08lx)\n",
> +			*expected, *found);
> +		return -ENXIO;
> +	}
> +


This is wrong since a Type3 could have more caps than the mandatory 
ones. I will change the check for at least the mandatory ones being 
there, and do not fail if they are.

I guess a dev_dbg showing always the found versus the expected ones 
would not harm, so adding that as well in v5.


>   	rc = cxl_await_media_ready(cxlds);
>   	if (rc == 0)
>   		cxlds->media_ready = true;
> diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
> index 4a4f75a86018..78653fa4daa0 100644
> --- a/include/linux/cxl/cxl.h
> +++ b/include/linux/cxl/cxl.h
> @@ -49,4 +49,7 @@ void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);
>   void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial);
>   int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>   		     enum cxl_resource);
> +bool cxl_pci_check_caps(struct cxl_dev_state *cxlds,
> +			unsigned long *expected_caps,
> +			unsigned long *current_caps);
>   #endif

