Return-Path: <netdev+bounces-122710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7218962496
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 12:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAD141C23A5B
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 10:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4B115FCE5;
	Wed, 28 Aug 2024 10:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1fSgMzNO"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA4A15535B;
	Wed, 28 Aug 2024 10:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724840304; cv=fail; b=haC62o84wjK66bjb/larWNkjcmMYKz4ak78HMCoHDOkv+vemYe4NHEiSayOKwyua4lCYQj08BSyuQHT3ktfDMnDgOFz9udXIJoEPtpI+oAcS0VQjRK7ZONCOw8MQ5rGPjS+WEU4V0fO6L9uKZdHN9NURFbW3yN1qyixWSPsK8Jc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724840304; c=relaxed/simple;
	bh=B+MpLnABdrm+ZYbjjWKNCSBHeDPoxJe1QT4YMSMVf3k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZeBFDN46PoNZwriCS+xyaSQAZSHda24mxyY8HYAaiY7JIHFZflpFItqyqbMwzszZ+gOCahVTYlTfTpMaholR0k7vJGvCaxvrJF2EYsM8NL5ay154ZJbMK4ML/No+DNiMN7u9tfbZ8BaR2RF1jNZ2KpaBmuUAQ9nAb8KHM8hgu8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1fSgMzNO; arc=fail smtp.client-ip=40.107.237.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XUcTe0ir1raxRxXM9bd/J8YMxH9ZR/991MNbHCl6mFBpZIgEw1fGBfFj/r17KJpYoDo/j+Jv7xqfOR7lNUXrrr5mJBrqhlrGkoRpA435ZJKSAo47hF01p7WVHc8GShSsfYGNAU29UQrb8HuKFNvCCrsSQ07uLfdJDjCTyiD97+qJO88jqV96zZAreJdESH97qdhUfEPF/s0HkLrbeU5vQv6Exeldg1q3xpg7rcPiWZXJVNheak+lwxlaZ4Qn3w1mGven0d4Za1dZKrc0wh8emhEwTFBBtETMrvFZemhQ3plTU6ui3l63MnwIeDRWoEN0xdM4wVYvTWtCUkgOgeZs4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JAAMXfh2Vps7uPgDvutZAyCSke9JybSRzvphLjLvv7U=;
 b=HNvuEdX/Qp8T95Fj+MHHAyk3MabhfwmGmi5fA+yr0k+zNweamzz36m6PpIaxas/CrBcIgRXe8dugmRLJHW66cY71hnf1luzhnUutcvU+FRq3Dn+4JP3Hb/ohwoIVoeJE906rGIVozYt6yfeHhachgVcwwavRJ/W35FMVZx+Q9E7SydoklMqa/a0IyZWK0VwvtS7wy2/fOSPKGOOaHrEw+qfADsWTJh+A6GEoBkltlg+fkKLH/0HU9AnCQyhfq1JU5KdNmuhYaqlIru0Fk4ceJDG5zy6lpLw2E7OfXqrSq85d+9LJwwbXflcj3477cNg76nqoDesn2TQ65zh8PVit+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JAAMXfh2Vps7uPgDvutZAyCSke9JybSRzvphLjLvv7U=;
 b=1fSgMzNO3ku0uYobaKW826ZkAT3zG1xw5O3T92FaKyV9YXPLuEZD/i9mTWjb+n6gByxKitg8nO2AsPS+ZccmBMDspf8fV5eJQcmcIxUp3aK1V/KNRrfrVZmBpw7Yjvh9cEDnFTvUlGyrYjZv7GlKoH/qHTotPjvfy0M3v3Mne9k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH7PR12MB7987.namprd12.prod.outlook.com (2603:10b6:510:27c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Wed, 28 Aug
 2024 10:18:19 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 10:18:19 +0000
Message-ID: <a6751e81-7a14-a8c9-b6b6-038e50b1b588@amd.com>
Date: Wed, 28 Aug 2024 11:18:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 09/15] cxl: define a driver interface for HPA free
 space enumaration
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, richard.hughes@amd.com
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
 <20240715172835.24757-10-alejandro.lucero-palau@amd.com>
 <20240804185756.000046c5@Huawei.com>
Content-Language: en-US
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240804185756.000046c5@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU2PR04CA0243.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::8) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH7PR12MB7987:EE_
X-MS-Office365-Filtering-Correlation-Id: 40c31773-3fdf-4217-e1fd-08dcc74abd04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K20zb29rSGhrNG1Xc1NNOEdZSGhkd2Q5RWgxZjAyK2RnbDRXK3RsYTJQS3Rp?=
 =?utf-8?B?eGpjVjZYRHZXQXU5M0ZsYzlEZ3N4WklMbEs3Z1BrZlYwY1p4WXlDRE5xcU1Y?=
 =?utf-8?B?alZZOVlERGlOL1ErN2RSK2pTNzhJSXN2d2FZRWdqQlB5cy9lUUt5dDUzdGRs?=
 =?utf-8?B?VlB5dURPRlpWTnkzQ3J2NjE1Mm9oRWFFcC9lQlM5bDhENTU4M0VuczNKbWhK?=
 =?utf-8?B?V1BmcWZWYStrYTZsWUs5ZjYybkJLNndqTCtUeUNSME1KaVcvZ0ZoRkxNRTI0?=
 =?utf-8?B?YkczM3JLeFhuV2d5bGlySTM0MmJKSjFXZ015cTNSc0dwaFlEbnZpaHhyenJ4?=
 =?utf-8?B?dGRDY1RzcXpvanNLZzgwd2FzVnA0T1VuQzJ5OFRGVlZ6aTFhMHMwejV0YlJa?=
 =?utf-8?B?QVh3T2xLWTFpcm5nSlp2TEtSV1FXRjRkd0dTcWsybGx1ditvYUtIL0pvaCt3?=
 =?utf-8?B?NU5zQ01LRlM3NTNOVjNtaDFKQ2VLWkNFVGhVWGRTYUxRMlhSSUFOUDl1ellW?=
 =?utf-8?B?bmZhaGN2MXZoQ3N3TldYd2Vrb3ViclNRNGllSGlvN0ZwNzFUVFdQY1pmOXc5?=
 =?utf-8?B?aE1La09WUWtMSm43SVBKR2gyWEg5ZEQrWElqUW5JUjllMkR1WXJoeWg2dk94?=
 =?utf-8?B?MXFJVFpka2wxTzJNbjdsWkNFMytiaTErZ3U0TzE0dklQZGNLbnV1OFEvMHlT?=
 =?utf-8?B?Z3Fxbk44NzcwQ0VRN1Q5QXdWckVXbkdFQk5JM3dwemNLTmFwbXRoYzhJYjlO?=
 =?utf-8?B?QTUxT3ltOG1tZlJ4OUNCd2NJQXFybzJhN3RhRnNwV3JCU0RvVEEwZVZFS0Vh?=
 =?utf-8?B?Q3BscGFhSDgyR1BOM09DNGNyMS9PVmFaazNCNGszRFpyWlVQUVh4dXhiR3Ji?=
 =?utf-8?B?b1lnbTRmaTVkNktIZzlnMnE5MTRQQm5UM1hyZGxweVZZaWNPL1R1anBCQTV0?=
 =?utf-8?B?ZmdzSnF3di9ZK2lsQnZpM1NWb0c5VitxNmI1dXdTZTN2N1dxRUhIelRUZ1l3?=
 =?utf-8?B?UW9WdmhYdnZYQU1lMTVidFBIT1NGcUhXZ0tZRFNaOEVPV0l5OTNtVXRScG9N?=
 =?utf-8?B?OWtjdkRtL2xWblJCaXVibDN6R0phcFk2dmwyZ3JNaExleVVXaFl3N2dXTFY5?=
 =?utf-8?B?R0NFRDRMR2VjRUE1dmt5NDFUMC9iOFVRTUd0MVJkRmZjZ2UreUJOdG1tY05q?=
 =?utf-8?B?UkFKb0E5SEd2OVJiYzRCallHWUZRWlROV2xGM1QyN0JmREJCU0ZkUnNXL2Rq?=
 =?utf-8?B?OU91VDIxa0xPcFRnWVUzb3ZubDVUS2J6aWhkeDR1dWI2R0xyZFBxVFdkd3Nz?=
 =?utf-8?B?a3VmdVg0cnBnQTRlQm54SlF5S1pZd3Zkc0tkTFVtRlZZOWozd2o0NlRtMGJE?=
 =?utf-8?B?cnhqRWpCWC9TQ1VhaTVWMmhsdlRRaytScjVBN01oeWlIVG16NjBmNlQxUE1l?=
 =?utf-8?B?RHB2S3NkNTRTYTkzWXBKNksxQU5vMUhvU1ZzTGpCeUV6aTZpYlV4ZW5MWXFV?=
 =?utf-8?B?dm15VW4vbnFJWUN5b1U1ZWJQNU1VYWp0Z093SXgyQ3V1RUNLUzZLWHA1eTdi?=
 =?utf-8?B?RlA5aW9TK04wdmVHdCs0NmVMU0NFcVk5RysrU25WUC9BTEtiVVNnSjhSMG40?=
 =?utf-8?B?TzRCTkdzRHpEOVJFaE5hVFQwdXl0Z0pqcWx5SEFyS3VqSzNSdGtab1FzV1hS?=
 =?utf-8?B?Q3hKMk9xNjJHR0x1MmUyZVltYVl1YXFNUGw1Zi8ydUFkWElCOTZiVENjcnRC?=
 =?utf-8?Q?RYF4USTGpBBAVlsxw4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVVLNXprazdkT01MKzhoUFZuUmU3Q2N4dGZhTDMrdVN5MjFyQUtmV1pnV1lp?=
 =?utf-8?B?SFlxemU4eXlWbjNLc21jSnJ5SjlER3kveG5kWFR3eS9WRitBQm5rR0QvQldJ?=
 =?utf-8?B?M0pNRWlhMUkwMjhKd0ZjY0dLaVRFRVd0ZmFkcXc0Ylk0VUs5SmM2TC9zWUFJ?=
 =?utf-8?B?dEowNmFXYnE2NGFYZ3hCeStRVUhCYmVMcTlvS1hockEySEI0YUppT1lkK0hY?=
 =?utf-8?B?OWF6TXNVb0tPRkNkSUJLMTlLWEFJemdkV2hZSTUxUXh4MDhrU1k0SVJEVnNH?=
 =?utf-8?B?NFJnZDV5OVdiSVN1YjJ6d2NRanl5dFRQTmRIZkVNTVMvSGtKTHVzSXM5ajMy?=
 =?utf-8?B?Q09mZWxlR0tSVDR3M0JlNUF2RzBtNHBlVjdDTERuSVdRdElQUFpiakRVcU1m?=
 =?utf-8?B?QzRjTm1VMm05cGM5VTd0OFgrd2x0Zjc0anJGQzZSUG03cTlnaFVqbUNweUJC?=
 =?utf-8?B?NU5wMlVLL0tyTFZVYnFFeFNsQ0x5RTVFWkpuNXErWTkwMkVJR0dNOWRmVGhD?=
 =?utf-8?B?NGFWZkFsdThRVGR6VW5JK3dzWU5RZWNaeHBmdzh3dUJwSmJBWlp4cE1ISFJ5?=
 =?utf-8?B?cEFhZjhqemkvK2FVTWkzNzhkS3k4blI0anZVNHVhU3Jja0RFOTlDRGhiTHc2?=
 =?utf-8?B?ajc1WjI5cVdudEMzbjBJZmZ2dHdSZXhCM1RraFprV0hGeC9RRmZqNHZlMmNw?=
 =?utf-8?B?WEZEZjc4cmpwN3IwUUsySEMraG1WWFI0QkNRMGwzbDJwYjhUbEtrRmVTYmVu?=
 =?utf-8?B?SWV0MkpYMVVOMkM1T2pTbmRPSUVjMENlUjBnVXd6N01XRklrL1A1WmRXK1BL?=
 =?utf-8?B?d2hmTjA2QkQvV3hkWndLYVhkU3VkY25zaXd5N2FEZVRhOWNISUZ4QlVTNUFk?=
 =?utf-8?B?WklxSUhIY2llcE5lZWdkQ05RMG1Sd0szc21MbWZzdTRUUmRjZVViOFJ0ZGNi?=
 =?utf-8?B?OHVIbGplRFlDWlNMUHRmSnByVndyY0pOcktKUXVuei90Vmc1VHlpcHpNcExT?=
 =?utf-8?B?aStobmNhNHZncEpTYzl6VGRZMm9jUklsa1l3WmYxemRJRzczbk9Uelk0U3Iv?=
 =?utf-8?B?amwva3FDY1FoY2I2cDFmbGdQYmJ2amd1RWRFbVBiUWRqaVBHc3BucXJkajhL?=
 =?utf-8?B?bzBRSXZSRnBoYmxZNmZKTEtsYVpqNUlPQUZVelNxd3lheXgvZUVMS3EwSUUy?=
 =?utf-8?B?WjltOURxaFJDc0tlcFhiU2Z6azBtdDRodmgyU1plL3JRbkpWRUlXTzZYWWRw?=
 =?utf-8?B?Q2kxeUFvVWxLcU5BV1lKUWx1cXh0dE5nZS9sMkd0NEZNandTa2tnS2dRZTlk?=
 =?utf-8?B?UHlPVXljaU5UTUc4dVhpWkpKSTkvVnJlMlptenRENVdQeGUyNDNiQThtSTZP?=
 =?utf-8?B?MXFXT3pGK21FLzlVOFYwc0s5MDl5Z01NdFhROTBUM3VVV0ZiQ3YxTjNZcGN5?=
 =?utf-8?B?UjFiRGpCKzFpK1BVeTh3Sm5QMlFLSnE3TTcvODltcFpTSE02T25Db2V6NHBG?=
 =?utf-8?B?ZWF6elJ2emVTZjNIak1WNVExY0ZkUDdoQkpDYUZzVTAzcDM4YklFR1prYjhX?=
 =?utf-8?B?bGU1K2xMdGVaS0ZCc0ZXN0ZEK0pyc1IzV0tzcXNkaU5xSldRZjZTTjNJY212?=
 =?utf-8?B?UXV4cDAxZE5TdGYrVjNuNG1waDVZMWpQS1NvN2NpN2JyTlhpYXJ6azN5MHRy?=
 =?utf-8?B?T1YvZy9oQXJML2RjN2JqdnVCSktIelQranRlam9RSkFUczRXYlRicFJvQUlC?=
 =?utf-8?B?M1RvbVBXdGd1WlBGOHNNRml4Y1NkdzVDUEpqRFpycVYzd2NRUUJ2OGcrVnFv?=
 =?utf-8?B?azM3Tnc4QXNVaVI2SEF6Nm0zcjIrOHltS21JWGtYY1NkWXdrUXRGRDkzYmdK?=
 =?utf-8?B?SjFKU1NDcmdhV3BUMFhTOFpQNUhmb3VDdVZUZDY4dWtObm15ZkpjQnpSZGZ5?=
 =?utf-8?B?ODlRWHVMME5jNGZOTm9GQ1ZkVkFaeHNQdmdkSGN0NEliKzBwUkRUQnR4Mnl4?=
 =?utf-8?B?Ylo2SVQ0cWRIMHJDK2YwbDJ6S25CcVNlZGFGanFEc25rTDNmUVgxcTZmZXdW?=
 =?utf-8?B?cFRkaWcyUVNmNnZ0Q1hHeWFjTDZmcFRRRmFXK2l2L1BIYXlteFlLS2psd3ox?=
 =?utf-8?Q?JRQhxyPoSHIJi9DGr1/cPuOKT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c31773-3fdf-4217-e1fd-08dcc74abd04
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 10:18:19.4464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q/sZM9Cv7AJPz8B2J7+Lws9FG/FOf7djKNqyPFjqzv4Fgt8PeN8xm++0esw/SQoA2Ycmkwk8tn4ODhsv9jrQ9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7987


On 8/4/24 18:57, Jonathan Cameron wrote:
> On Mon, 15 Jul 2024 18:28:29 +0100
> alejandro.lucero-palau@amd.com wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> CXL region creation involves allocating capacity from device DPA
>> (device-physical-address space) and assigning it to decode a given HPA
>> (host-physical-address space). Before determining how much DPA to
>> allocate the amount of available HPA must be determined. Also, not all
>> HPA is create equal, some specifically targets RAM, some target PMEM,
>> some is prepared for device-memory flows like HDM-D and HDM-DB, and some
>> is host-only (HDM-H).
>>
>> Wrap all of those concerns into an API that retrieves a root decoder
>> (platform CXL window) that fits the specified constraints and the
>> capacity available for a new region.
>>
>> Based on https://lore.kernel.org/linux-cxl/168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com/T/#m6fbe775541da3cd477d65fa95c8acdc347345b4f
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Hi.
>
> This seems a lot more complex than an accelerator would need.
> If plan is to use this in the type3 driver as well, I'd like to
> see that done as a precursor to the main series.
> If it only matters to accelerator drivers (as in type 3 I think
> we make this a userspace problem), then limit the code to handle
> interleave ways == 1 only.  Maybe we will care about higher interleave
> in the long run, but do you have a multihead accelerator today?
>
> Jonathan
>
>> ---
>>   drivers/cxl/core/region.c          | 161 +++++++++++++++++++++++++++++
>>   drivers/cxl/cxl.h                  |   3 +
>>   drivers/cxl/cxlmem.h               |   5 +
>>   drivers/net/ethernet/sfc/efx_cxl.c |  14 +++
>>   include/linux/cxl_accel_mem.h      |   9 ++
>>   5 files changed, 192 insertions(+)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 538ebd5a64fd..ca464bfef77b 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -702,6 +702,167 @@ static int free_hpa(struct cxl_region *cxlr)
>>   	return 0;
>>   }
>>   
>> +
>> +struct cxlrd_max_context {
>> +	struct device * const *host_bridges;
>> +	int interleave_ways;
>> +	unsigned long flags;
>> +	resource_size_t max_hpa;
>> +	struct cxl_root_decoder *cxlrd;
>> +};
>> +
>> +static int find_max_hpa(struct device *dev, void *data)
>> +{
>> +	struct cxlrd_max_context *ctx = data;
>> +	struct cxl_switch_decoder *cxlsd;
>> +	struct cxl_root_decoder *cxlrd;
>> +	struct resource *res, *prev;
>> +	struct cxl_decoder *cxld;
>> +	resource_size_t max;
>> +	int found;
>> +
>> +	if (!is_root_decoder(dev))
>> +		return 0;
>> +
>> +	cxlrd = to_cxl_root_decoder(dev);
>> +	cxld = &cxlrd->cxlsd.cxld;
>> +	if ((cxld->flags & ctx->flags) != ctx->flags) {
>> +		dev_dbg(dev, "find_max_hpa, flags not matching: %08lx vs %08lx\n",
>> +			      cxld->flags, ctx->flags);
>> +		return 0;
>> +	}
>> +
>> +	/* A Host bridge could have more interleave ways than an
>> +	 * endpoint, couldn´t it?
> EP interleave ways is about working out how the full HPA address (it's
> all sent over the wire) is modified to get to the DPA.  So it needs
> to know what the overall interleave is.  Host bridge can't interleave
> and then have the EP not know about it.  If there are switch HDM decoders
> in the path, the host bridge interleave may be less than that the EP needs
> to deal with.
>
> Does an accelerator actually cope with interleave? Is aim here to ensure
> that IW is never anything other than 1?  Or is this meant to have
> more general use? I guess it is meant to. In which case, I'd like to
> see this used in the type3 driver as well.


I guess an accelerator could cope with interleave ways > 1, but not ours.

And it does not make sense to me an accelerator being an EP for an 
interleaved HPA because the memory does not make sense out of the 
accelerator.

So if the CFMW and the Host Bridge have an interleave way of 2, implying 
accesses to the HPA through different wires, I assume an accelerator 
should not be allowed.


>> +	 *
>> +	 * What does interleave ways mean here in terms of the requestor?
>> +	 * Why the FFMWS has 0 interleave ways but root port has 1?
> FFMWS?


I meant CFMW, and I think this comment is because I found out the CFMW 
is parsed with interleave ways = 0 then the root port having 1, what is 
confusing.


>
>> +	 */
>> +	if (cxld->interleave_ways != ctx->interleave_ways) {
>> +		dev_dbg(dev, "find_max_hpa, interleave_ways  not matching\n");
>> +		return 0;
>> +	}
>> +
>> +	cxlsd = &cxlrd->cxlsd;
>> +
>> +	guard(rwsem_read)(&cxl_region_rwsem);
>> +	found = 0;
>> +	for (int i = 0; i < ctx->interleave_ways; i++)
>> +		for (int j = 0; j < ctx->interleave_ways; j++)
>> +			if (ctx->host_bridges[i] ==
>> +					cxlsd->target[j]->dport_dev) {
>> +				found++;
>> +				break;
>> +			}
>> +
>> +	if (found != ctx->interleave_ways) {
>> +		dev_dbg(dev, "find_max_hpa, no interleave_ways found\n");
>> +		return 0;
>> +	}
>> +
>> +	/*
>> +	 * Walk the root decoder resource range relying on cxl_region_rwsem to
>> +	 * preclude sibling arrival/departure and find the largest free space
>> +	 * gap.
>> +	 */
>> +	lockdep_assert_held_read(&cxl_region_rwsem);
>> +	max = 0;
>> +	res = cxlrd->res->child;
>> +	if (!res)
>> +		max = resource_size(cxlrd->res);
>> +	else
>> +		max = 0;
>> +
>> +	for (prev = NULL; res; prev = res, res = res->sibling) {
>> +		struct resource *next = res->sibling;
>> +		resource_size_t free = 0;
>> +
>> +		if (!prev && res->start > cxlrd->res->start) {
>> +			free = res->start - cxlrd->res->start;
>> +			max = max(free, max);
>> +		}
>> +		if (prev && res->start > prev->end + 1) {
>> +			free = res->start - prev->end + 1;
>> +			max = max(free, max);
>> +		}
>> +		if (next && res->end + 1 < next->start) {
>> +			free = next->start - res->end + 1;
>> +			max = max(free, max);
>> +		}
>> +		if (!next && res->end + 1 < cxlrd->res->end + 1) {
>> +			free = cxlrd->res->end + 1 - res->end + 1;
>> +			max = max(free, max);
>> +		}
>> +	}
>> +
>> +	if (max > ctx->max_hpa) {
>> +		if (ctx->cxlrd)
>> +			put_device(CXLRD_DEV(ctx->cxlrd));
>> +		get_device(CXLRD_DEV(cxlrd));
>> +		ctx->cxlrd = cxlrd;
>> +		ctx->max_hpa = max;
>> +		dev_info(CXLRD_DEV(cxlrd), "found %pa bytes of free space\n", &max);
> dev_dbg()
>
>> +	}
>> +	return 0;
>> +}
>> +
>> +/**
>> + * cxl_get_hpa_freespace - find a root decoder with free capacity per constraints
>> + * @endpoint: an endpoint that is mapped by the returned decoder
>> + * @interleave_ways: number of entries in @host_bridges
>> + * @flags: CXL_DECODER_F flags for selecting RAM vs PMEM, and HDM-H vs HDM-D[B]
>> + * @max: output parameter of bytes available in the returned decoder
> @available_size
> or something along those lines. I'd expect max to be the end address of the available
> region
>
>> + *
>> + * The return tuple of a 'struct cxl_root_decoder' and 'bytes available (@max)'
>> + * is a point in time snapshot. If by the time the caller goes to use this root
>> + * decoder's capacity the capacity is reduced then caller needs to loop and
>> + * retry.
>> + *
>> + * The returned root decoder has an elevated reference count that needs to be
>> + * put with put_device(cxlrd_dev(cxlrd)). Locking context is with
>> + * cxl_{acquire,release}_endpoint(), that ensures removal of the root decoder
>> + * does not race.
>> + */
>> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_port *endpoint,
>> +					       int interleave_ways,
>> +					       unsigned long flags,
>> +					       resource_size_t *max)
>> +{
>> +
>> +	struct cxlrd_max_context ctx = {
>> +		.host_bridges = &endpoint->host_bridge,
>> +		.interleave_ways = interleave_ways,
>> +		.flags = flags,
>> +	};
>> +	struct cxl_port *root_port;
>> +	struct cxl_root *root;
>> +
>> +	if (!is_cxl_endpoint(endpoint)) {
>> +		dev_dbg(&endpoint->dev, "hpa requestor is not an endpoint\n");
>> +		return ERR_PTR(-EINVAL);
>> +	}
>> +
>> +	root = find_cxl_root(endpoint);
>> +	if (!root) {
>> +		dev_dbg(&endpoint->dev, "endpoint can not be related to a root port\n");
>> +		return ERR_PTR(-ENXIO);
>> +	}
>> +
>> +	root_port = &root->port;
>> +	down_read(&cxl_region_rwsem);
>> +	device_for_each_child(&root_port->dev, &ctx, find_max_hpa);
>> +	up_read(&cxl_region_rwsem);
>> +	put_device(&root_port->dev);
>> +
>> +	if (!ctx.cxlrd)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	*max = ctx.max_hpa;
> Rename max_hpa to available_hpa.
>
>> +	return ctx.cxlrd;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_get_hpa_freespace, CXL);
>> +
>> +

