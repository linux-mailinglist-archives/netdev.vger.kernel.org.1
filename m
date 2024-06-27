Return-Path: <netdev+bounces-107483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A6891B2A3
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 01:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 937EF1F213A2
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 23:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C511A2C27;
	Thu, 27 Jun 2024 23:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="d5QPwjWI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B961A2C32
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 23:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719530415; cv=fail; b=jPZ3toegcUbPgPhBU6kVPFdY6hL3d/hdR5VdF6fjGOy8AF1qavG7R8UP0WT0zW9mBMlwPd1Zlo3AVtCiAoAfNHP2MszdQOkvlrqjc33/+cpOKonP06VNIN4n6CYod1VBHU4V1hZZK2W6ZhImGq3ojz37Jxqld7CfXQ9Ko6ZXnhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719530415; c=relaxed/simple;
	bh=zgLHFZxHltGzvQIgAU/ZDcU9HGT1Pmi0UAdv2Wd0TgI=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OGjrKztZDNmBMKaaLgzs77DLMXBONwECUE7KR/pB9hmt/PL8BXmOx5V+Cu1bv2M8sAb4TYu/Bw7TDHI/Wx9vVpsCr5v5LanFNTvJt44FZvphwkrRoQBy15dmJ2/B55MFb41Mf3zczD/A/f0TQFkPCPj2ZolzYDQwgvUNpJYkfk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=d5QPwjWI; arc=fail smtp.client-ip=40.107.220.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJ+76nxy5ydf/fUJSIYr7prm/YZvbc4QcZpGKLPqx7FEd1O1yunY0RsnEqIJOiupFVbex5jx6PhTWKTZ5oKeWLE6N7Me+pE5z+niIO3Ew6fnMl43aZ430Os1VYONWjKr2RTHWKsJ+jX/YvGZVM/6HK522KpNX8vSQaFOk06OYZJ6Jyb02B4jnhSQluPaNBfrmTpiJQg/70Y65c3C4wzekO46Q/YH3lNqyjv+OycE4sxHaro3PiuTPPqztlyHikK2oLJnf0lhDIHrR5V06xDYexVxdhUWrWLHKoCkp6JHi/dFNk4q6lpx0V4j9P4N89Ag79oHfCy31P0nlrwzGMbD0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cefu7b3x7F2jEZak987JP7U0v9v+A19AZVGypPF8+L0=;
 b=bJ+nLGBSX5VuiVViJE7TRWdycOPdmeRzgrgCc3QU19ndA6I0RUlSPv0jElC1GxGx1/wStfucmLBB2x7B7Rq0F8RQmreTyAE6s0DQmIgWHiFvTG6FJtgphxGL/XHBswgo1irLwav3Ummd28A+W2RliMmlM40UKJr+TTsCXoisi1GXswi8Lt6H02aff2AkHF2ztuhVoWc1qAn88QfrtSDm7SoZCI5hjHcK08O7ipgYBK7GvXg7m4kIAK9am2jALUKxNxsUAmDIvA7V86ishM51j388VPlehqjagqOXKWrV+BFzUh0HRGkCFRJOV8x6XJB5f6Pt8oD38uA5VzveH06UJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cefu7b3x7F2jEZak987JP7U0v9v+A19AZVGypPF8+L0=;
 b=d5QPwjWI+qCjjVRMaFSS2KkWg+wkPcGmIEP5ROZDEGvbtXU4ADKDl/HWT92Rg4EcH+EnJylgkT9hM5bd+P04PUtKEklHGZBeGFxrrhNwBnJTZQI2z06UwYy0Gu7sg9KxlowMs5JBXXJ6eAsOjeb57/CHP6Cmib7CkE1YAC6uAxQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 DM6PR12MB4252.namprd12.prod.outlook.com (2603:10b6:5:211::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.24; Thu, 27 Jun 2024 23:20:11 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%4]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 23:20:11 +0000
Message-ID: <2c2f2c2a-1d61-49a3-b975-22471fbf259a@amd.com>
Date: Thu, 27 Jun 2024 16:20:09 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: mlnx5_core xdp redirect errors
Content-Language: en-US
To: =?UTF-8?B?0J3QuNC60L7Qu9Cw0Lkg0KDRi9Cx0LDQu9C+0LI=?=
 <dairinin@gmail.com>, netdev@vger.kernel.org
References: <CADa=ObraXt4uEckHAGuhpvBa3ReUgcQkFMQweSBrGU9zpoOwnA@mail.gmail.com>
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <CADa=ObraXt4uEckHAGuhpvBa3ReUgcQkFMQweSBrGU9zpoOwnA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0180.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::35) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|DM6PR12MB4252:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d3d17a3-e76a-4a1d-0907-08dc96ffb12d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R3BrK2xzN1JCUXJCUVFmZGEyWTZjQmtOT0FpT0RWV09tNEhSRStFbm51MW9v?=
 =?utf-8?B?NlRSRmVzbjZWNHhIeU5ROHE0TEtOUko5bHJvZ2pRSER1TDlRRVVkTFJEdXJR?=
 =?utf-8?B?SFZCN1RRYWhadVkyeFJZY2tqUk9aeTRpU3ZoeVZ0aXJTaW94dHl6QXBpV3dp?=
 =?utf-8?B?K2FUZGJhaFphQTVNLy9sSWpqOFJTYXd6a3pEemQzcVdSTkNmbStlYVcrcnkx?=
 =?utf-8?B?MVBmMTVueXdkM2w2TU0zRGk5d3FtZTd0a3Y0ZXNnR3B3bUs2Njh5OUgzR3Bq?=
 =?utf-8?B?aFFqQ1FLNUszSnJOT0R5MVZBRWxrQlNxWmZDVzFLZkdONER5aWFxWkVUK0wx?=
 =?utf-8?B?TTBCOHo5ZUJXM00rZW9keUQ4U1NvSmF0ajNDaDB0VnFVVlZUbkV2Mml3QU85?=
 =?utf-8?B?cmlyQmVibVp6L3VkejF3Z3hvb2lEd0NENU54Y3hPNDhSaWxQRmVBcHh5YXpx?=
 =?utf-8?B?YVJLZ0g2UWpJa01BODJrZ0JvZ2s0QnZKOGNSeTVwekRTbnE2T1orSVpRZkZL?=
 =?utf-8?B?ZXdxcTZwR0NTdGJCVVRpYjZld2FybzlFRytJNkZCWVJyc3hUV2pTS3dXbCti?=
 =?utf-8?B?NWQvSmgvdmpLYVU3UUpMbnIvelliMTk0QnlkYms4c2hrc2toZ3NxeEVHdmhV?=
 =?utf-8?B?K1RrTXNmd1VTZU9LZ3ZMaHRhMnh0QjNUd01zcG4zYlpoQUFORzRDazJqZ1pz?=
 =?utf-8?B?K2RXOE9jOW55M2xWMFpsRlpoeGU5OG1iMFlLdkRXT3BUOVJaU2dBUnh6U0w1?=
 =?utf-8?B?a0ZnZjZqY1c3Y0pZTldtZzNzRnQybVhZYXRSM0c5MXZuT2pYQlFkRFhjR1FC?=
 =?utf-8?B?NTh1K0hPbHMrWk1pZjIwQUgzVlpQTnhvS2FDZXIwRU1nd1BmclVoVmFYL1Zo?=
 =?utf-8?B?RGl4THBreGRaU2VNdjdFbHVjaU5UQTE4RzNTWXBNMWxteURSb3R1dVJKelE0?=
 =?utf-8?B?RUdIdEJ5ZVRwcHZnbEMvenA3UWQvd2JQQm1IaE1HYzNiTjhRc0dZeWZpMkd0?=
 =?utf-8?B?VitSN3JQT01qQkRDdFQvU3FwUDBRR1RUd2RLTzgwVVliZjIxSmNuZVJpV3JK?=
 =?utf-8?B?bFgzVHYxQ2lrd01HUW9wU3dTcS90blVjR1Y0R0RhelA4ZDJsYitxTVVqZWgz?=
 =?utf-8?B?c3htclJaU0pZVG9OQjNtdWVNMWoyTW1uSHpRYTRKL2FtcmRHL2RPVG03ZGpw?=
 =?utf-8?B?a3lXNTJXWjNkSW5MWlpEMFBVZ3pRaDVPQ0owRlVaSjRpSVg2U3E4VFdFeXMw?=
 =?utf-8?B?Ty9PcGJURGY4OVBXeHBScFRCdGJZSTR2YmdaT3V0MVcxMGNQazJNRTlxK1U2?=
 =?utf-8?B?d29vTkNRb2wra0Q1R3B6N0N1YXNpM3czUXdJS3lqRnlLN213eWhUOVBpaVN6?=
 =?utf-8?B?eWMrVUF3S3JEeTE3NUZMNUFDZUNjUG9RZHhpaytUNVErTVdhT2hXajdOL1hk?=
 =?utf-8?B?NTl1eHNyM0lUazVNcjFvTWxsbDBnMm1qdXN3a0JJSDdtcG5wNmtGWEMyMzUv?=
 =?utf-8?B?aDZtSk5KWjhQQ0JKbGc1MjR0UEkrZUZObm5nRG4zaTJSRG1qRCtUbGpreU4r?=
 =?utf-8?B?VHlzZThVTEluNDFHV2pYeUJWbmdXL1pPU2EzS0Q5Z0N6SlJOQmFnSUIwcUg4?=
 =?utf-8?B?Mnh2anF4SzlLNDkxVVVRdkhCQlpzSUZLN1JEaDZhQVNQc0k4VWpRQzVUSlg5?=
 =?utf-8?B?NWVzZmtnbm9NNGt0cWhEbEw4WnpLRFZKNzY0bmZ2TXdKVDErNmtmcE0xYlVu?=
 =?utf-8?B?ZVExckVnckpDeEZsbjAyaWdIOURlc1doUkVzMXhnMFZ0a2hkcGJlZ0cxK3Ew?=
 =?utf-8?B?Q3BCUnl4VkRaOEdTakVTQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTY5UURnblFJTWRjdHBmQWhZSHFGVzkvdXRaSHI0RzQwN09keXgvbVhWd3FG?=
 =?utf-8?B?aitkNzNlV1JaN0Y3ZlR4ZXRSYWJ0b1QrMTdoNXQrT0Y1TWZ5T09mdjBPalFH?=
 =?utf-8?B?MjRIWTZyNmJ5Q2V0MldSUDhJbHN2TWp4dFIrTldJajV6QkkrTG95SFU1Snkw?=
 =?utf-8?B?UnZsUW9pcWE5Q0RBTWIyS2JuK0wyK055UUo4T2ZaS2tIVXM2NzF6NUNlbGpW?=
 =?utf-8?B?bm1sakYvV3FzR05mRW9NbythMWFHZlRaN2Q3T093bWZOVHpoaEg5SU8vbVR3?=
 =?utf-8?B?Qk9GdkZKMjMvWDJ4L0RpVWRDNzg0VHRnYTQ2RDQydEpGQUliLytVYit4TE1J?=
 =?utf-8?B?QmI0UFBsSkpTUzdNVXB2YkFDTW5rWFlTaHI4Skd3MEp1Q05Fd1c4eG5NRmNV?=
 =?utf-8?B?Qy81c1dLNFNUS1YybEpyYjNpQXhQZ29sWlh6aGFHSXV0UGtuOGxmODRkNzJr?=
 =?utf-8?B?Snh0VmdMeDJRbGoxNUUxeTBSbzM2OGVpQ080YnVacGpJdGsxN1M0Z2JCRUhw?=
 =?utf-8?B?WnlXdWNOUVdCMC91MEV6VWtRQVBGeUU3WVU1clEwajR0RVVRem1hMi96aWJl?=
 =?utf-8?B?VFRaUHI0SHVwb1lRb04wN0QyWFp1ZTJuZHo3bC9naU85cGM0MWZZUU1HN21v?=
 =?utf-8?B?RFpHaVo3OVp4L0Fpa0R5T1c0am9ya3dWUE9kTkoyS2F4QVJaQUxTLzY5alhV?=
 =?utf-8?B?YlVENWFxaWhraHR5SkpsN2VJNmRKQWU4RE13SnNwaVdKWmMrOVdMVFc0cnJM?=
 =?utf-8?B?Z2hjTzk3TUFtZmFvandlRXBtOTZpeFV1VzNCaDg4aVdSYkpYQlFrQVlwWDNV?=
 =?utf-8?B?bnl4bHMrYm1oYmZCZDBRMmFDSGlrY01mU1dtbGNDUkdxZ1FhQ2NVRDBpTyta?=
 =?utf-8?B?UnRpMEo0WEJib3dVSy9US0tmbENWOXVsOHlHV1E5YmpCT2ZUMk84WEt4b1dL?=
 =?utf-8?B?SFljamlvc1dLZEJydlF4QjRpTjRzUXFjR3E3SDhzU2dhVWtVYkRVTjFOQ2k5?=
 =?utf-8?B?U2l6SDVFaWZOZW5XRkIzdU8vb0gxdlFRMkJEM29aUFVnVU1VZSt2MExXRXoz?=
 =?utf-8?B?Y0poQWcwait2ZFMvNTdJL0pXazJ4VUI0MU1Bb0hOODlBNlo2VXZyeGR3cXBn?=
 =?utf-8?B?THM2eExnODYrODJ6UmNnYmVLYnBJVjVObFFKT2plYWlnL0wzMStSUkNtZ1Az?=
 =?utf-8?B?QmNZUTJ6bDc4QXpGSUF1eUdEOGhySkQySTVwdVFRM01oU2tKUzBWM3dMdTg1?=
 =?utf-8?B?VE9NVnp6bHFkSWoxNWhkK0pxMFhOMUJwZVBhVkJaeERiRnVuc1ZENWl5QlRT?=
 =?utf-8?B?aVJiM1dVSHFveG02MHk3TVFXMGtiYk9zekwyR1F1NURDTTVzT2dnWnUxQS9S?=
 =?utf-8?B?WXBnNjArTU4zZ1pWbWt1ZXZxM2VqRkJVYlI5MGM3QXYwU3VTOHNBbjhMREVZ?=
 =?utf-8?B?ek5PejBwZUpvTnVNVHJkZ0R1STlpTU9pdGZNZGNWa2t3enFhaTU3NjVxR2dJ?=
 =?utf-8?B?L3RKL3BSUmlWbG5NZndSR1RsV1VVS2U1TmhwNlJiU0hSL1hWR3FaQ0JrM1hq?=
 =?utf-8?B?R3dBSE5yYzVHUXVndGZvUjQ2RlZWZnZsYWIyWHZVeEcrNmU5bUhyanRMTEtB?=
 =?utf-8?B?N0RzZ1ppb2xzK0o4bnV3cDRickZQOFNZdUxrdjJiSzdqaHlwUXk3K2ZmQkgw?=
 =?utf-8?B?RUFGS01SU1E1M2pUcG43VUJFakNHSm4rTGpvdkF1WUhnYzJ3U3hYYWt0NGd6?=
 =?utf-8?B?UTVGNXptR3hPUzNIdEErR2VFNXFnZXFpS3dDcnEzV0FDVW5ZaUpkcndPMCto?=
 =?utf-8?B?Y0ZDeHE4RkM5czdjem93RHFUOURoRDROQVlnMEMzRHhXenFoS1JqbjVHZzZK?=
 =?utf-8?B?OHVTdlA4WTNyaThsbmF6ZndpdTlxMHFKenpCSGFvaTJEYkg4ZHAyNVpoTG1T?=
 =?utf-8?B?dW1hZ2dDa0g2SlRhQXlvMFA0Wlo1cEZZRkJqTm1uNU81ZGVMbDN3RXdTZFFW?=
 =?utf-8?B?R1c2djh1UlQzRDJUbXhuRzFqekp6QXJSblI0d2c5K1kvYStQVHZQcWkrb1d6?=
 =?utf-8?B?STQ5QTlHTUJNeHpVdFB0RmxZVDRraE1PNEdHQ0J1dkJ3VjFJUjFMQWdsaUJ6?=
 =?utf-8?Q?rv/cZxnPXvSfn1fA5ZMsK0uj4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d3d17a3-e76a-4a1d-0907-08dc96ffb12d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 23:20:11.4457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GGbp/4uW/+J0XjbLEVjPMLyyfYxg5XsbtzQ2RU4W+x+TgRYE5z41Kq0/sqYDTfZ8eeyxmB+cZ+u57XwmnZRIqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4252

On 6/27/2024 2:07 AM, Николай Рыбалов wrote:
>
> Hello,
> 
> I have a setup with 32 cpus and two mlnx5 nics, both running XDP
> programs, one of which does redirect via devmap to another. This works
> fine until the following happens:
> 
> 1. Limit number of queues on both nics to 4 (< number of cpus)
> 2. Place incoming interrupt on a CPU >4 via irq_affinity
> 3. See redirect errors in trace:
>            <idle>-0       [001] ..s1.  2010.232028: xdp_redirect:
> prog_id=58 action=REDIRECT ifindex=5 to_ifindex=4 err=0 map_id=44
> map_index=0
>            <idle>-0       [001] ..s1.  2010.232033: xdp_devmap_xmit:
> ndo_xdp_xmit from_ifindex=5 to_ifindex=4 action=REDIRECT sent=1
> drops=0 err=0
>            <idle>-0       [005] ..s1.  2010.232253: xdp_redirect:
> prog_id=56 action=REDIRECT ifindex=4 to_ifindex=5 err=0 map_id=44
> map_index=1
>            <idle>-0       [005] ..s1.  2010.232257: xdp_devmap_xmit:
> ndo_xdp_xmit from_ifindex=4 to_ifindex=5 action=REDIRECT sent=0
> drops=1 err=-6
> 
> This narrows down to the code in mlx5_xdp_xmit that selects output
> queue by smp cpu id, fails on cpu 5 and succeeds on cpu 1
> The scenario is not very exotic to me, at least there is a need of not
> running nic interrupts on all the cpus in the system, and not to be
> bounded to first N of them.
> Can this issue be solved in the driver, or I should start looking for
> a workaround on the userland side?
> 
> Best regards
> 

This is one of the weaknesses in the XDP_REDIRECT model – how to get a 
packet sent from one interface to another within a safe context. 
Assuming a queue is tied to a specific interrupt and an interrupt is 
tied to a cpu, and both interfaces have the same queue/interrupt/cpu 
mapping, the originating napi context can assume it is safe to drop the 
packet into the target interface’s queue without worrying about added 
time-consuming locking.  This is the model that many of the drivers are 
following, and if the queues/interrupts/cpus don’t match then the packet 
gets dropped.  There are other drivers that try to do some locking and 
queue mapping / modulus operations / whatever to try to accept the 
packet into a non-matching queue id, to varying degrees of success.

The best case scenario seems to be to make sure both interfaces are on 
the same CPU/PCI complex, have the same number of queues, those queues 
are mapped to the same interrupts/cpus, and irqbalance is told to leave 
them alone.

I’m hoping there are others with more experience configuring these that 
will have better answers, but this is what I’ve encountered in my short 
history playing with XDP.

Cheers,
sln


