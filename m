Return-Path: <netdev+bounces-139469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A76029B2BA3
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 10:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFF27B22B6C
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 09:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A247190679;
	Mon, 28 Oct 2024 09:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ksq1Igut"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3C21917F6;
	Mon, 28 Oct 2024 09:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730108245; cv=fail; b=QSoR8HtC4vkOd0wB3zScbCT5O+vOB6dpO9OEGHbiO0fYFlyCdBKTpnwywfmt2bdgEahPpDRXLT/tPWfgPW5xRBIki20RA7SxiTaii0JvFe5lxFyje/iU4W9Ug2CB+8AnfOe6kZLDSpro9/hvLDRcUwTozrRmmhqXsgNC4crXzGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730108245; c=relaxed/simple;
	bh=x7uh+wOhDXQatSyylDEw/aE/7l0bcQYn83P38Vkcl+4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZUztYbjBGD9s2iKwT+pU6PrmEXS7P7yvMcfLrqgeJl9xyzmwY5R280eIQ68Vi2+Q57pONb6tquJqgIU+K2Hc9U8lMXRB68/tludIH/qgcu13KiOmL5EiQcPWUB/fHdEa5mQSS+Uk5Pqn+CQICCJddHO2Cu64DLiQ0bhyruc1xsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ksq1Igut; arc=fail smtp.client-ip=40.107.244.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ki7v+DnmpznS9mMUY+JHbsRHzt+pZjSZctg39P6RXNunmr9w9dT9KGnhKZ5OCH4I2D0cgzb2cEZcIMawp5ilMp2dOBdZFJOVuyj3SM3l+9dh/ChP5jVubZCSbxk4K5ftwZc24vSetljlmUX3YIBEgm+F4aFskPzXxGtjkjWCZ0imCfIMc6FbjcGCeYxKZA4tDMpdbfcKqJM3fbOVGnY/dIMeFFc0YZMlfkRA7PKnhG7pRIpNtYhq3jjObvusTxCDA+FY5ZJnGtRh3pOQKbV5qObN7FHPt2usIejUnOGOp4UZrj/Kc7tpaUbQSj49nrvisKJ+06gl4HjoK5+wEEyVtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kdambczof7xvkIkaOJR77RTmvSAbpgZmXQuW36iFhSU=;
 b=xFoitvCYiQOKASwxUFlgRI48F0ueauEE+iLOjgKndl8ympiRKskfqcDEZeo+r2fXw72o0pSe3cKhHrt4t1DXb0c8FJqwaACYw94wsAlPB1nUHgtyBGSNnoLDKueD6oeVr4eWMSLRkZcW9stUIz+Ujh3q6TFK+EinI/ewQzgWlOhAqMNwfMOxOTxc7XZwLHmHn8BZGZnZJ7Sa5TcLr5g3zPbTODadxKs0XzmcO0JIyfBX92CjcZRDeGtRXEVkA7fJOesKPDsAS3lU+Y7y/MLST09fKMRUA9xwh5wXIs7hFAni0E2B/zg1ayWK4aCO5/kjLP0M4sLZLhE6OJX+l4sfPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdambczof7xvkIkaOJR77RTmvSAbpgZmXQuW36iFhSU=;
 b=ksq1Igut/o81JlS6rXu24zRD5pzFm/ew+eXsk09hzRcPre3yC+yBOPyUF2EVTjM8mgDWgyQwHKbTA/jD2K7SY2dlN6l+bfPatEgNIgKnd2FOyu8gEqEt5U4az3IhBaPg8rK/4yAyBDsn1TnmHl76a9llrZhnv/ycdNlWv/Ig1zA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH7PR12MB6787.namprd12.prod.outlook.com (2603:10b6:510:1ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 09:37:18 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 09:37:18 +0000
Message-ID: <7deb17e2-4257-1ddf-2279-32bf4f086f67@amd.com>
Date: Mon, 28 Oct 2024 09:37:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 01/26] cxl: add type2 device basic support
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
 <20241017165225.21206-2-alejandro.lucero-palau@amd.com>
 <20241025145012.00002d64@Huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20241025145012.00002d64@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0267.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::7) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH7PR12MB6787:EE_
X-MS-Office365-Filtering-Correlation-Id: 88ef1638-1a22-4c9a-b283-08dcf7341d5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ckdUaGlJbWNrdWh1K3RSWldlY1JlWklPdTJIOGZmall1a0ExVWRMUFFDS3Zk?=
 =?utf-8?B?QVFKblJnNU8yRFBnL244QUJxMzJCYjRyT2VzdERSTjBhaklrdWxEcEZ4andG?=
 =?utf-8?B?UWdhSmZCL25kcnREOWQxZVg3aWpoQm5BM1Z6SFlLWXpIcjBSODY3Q3BWcWxF?=
 =?utf-8?B?bm8vV25GV1ZMNWNWQXdMWnJ5MThORmNMQ0dHa01HYUoyVVZlZ3dwT3lOb2wx?=
 =?utf-8?B?dGM3dzdrN3V5WWJQVFZGcFVwOVFjUmJIVTlkeGlzcW5CZVBEcVFVVDJZRTJw?=
 =?utf-8?B?MkRSQldQSDE0RWFXTDBiQlRjZXgrcUhrVVN2emM5UGJDeFBlaVIzUFFwRTI1?=
 =?utf-8?B?M1IxSnlQQWdMSGxLMytmMXRzM2xkditkd3Q5Tlh3YklJRTREd1JXZTM3eThF?=
 =?utf-8?B?ZU9FQlRFMytRN0VCc2tmbzRiU2RMZDQ1b0licS9hOFBGN04xcVAwWlovcXE1?=
 =?utf-8?B?TWJZWFFKMldOejgzc2h4QVVsanJucTRyeVlzOFNSWHBwa0RrWDVPSG8rNHpo?=
 =?utf-8?B?eGRWdm9TVjMzWThWZ3ZIWDJIQVVSQjZHYnZVWnc4ZEFrK1BNemtsTCtDYWdX?=
 =?utf-8?B?cjJwS0EyZDRPT3RPb3dBMjJ2K2tUUTNid2llUTNkaWxxekhOTlRQdmc3aW5o?=
 =?utf-8?B?RVYvd2dYRWhCRGtqaGFDaXRrOHVqUW5zMkhOemJtQXo2TUJ5SGliQ3RLK2F0?=
 =?utf-8?B?VWU1aGNQbGdYeWZ0VE1sZUJrdmZqR3MzOCtHT1NHT3M2d28xVytsMGNEc292?=
 =?utf-8?B?QjdDQkVZUys1MUFab05kakRLMjU4OVJRdXRLd1c0ZDJucnJ4b2dWaERlTXNq?=
 =?utf-8?B?dlRtRCtsWlBrdU4rUmNNZGR6RUVERENPaXQ5ejhOaU5JVlp6aWU5c283akJr?=
 =?utf-8?B?ZkZ5dWk5Lzdmem0yYU9saVovblM1Rll6UExHVHdyZEJJem9YdHI3N3NrbVFn?=
 =?utf-8?B?aGdEZXp2T0dkYkt5R3hjZDArRHNaVkdXYVlGVGRreWJSdWlUUGJjcWNSZ05W?=
 =?utf-8?B?OEV4Qmp6b0M2QktZTU1wb2E5dkFUS3Q0Z2hGOTVOUXp0ZTdpNlJuVTA2L1Zk?=
 =?utf-8?B?VTZOL25WaFBrZ2xwTFRrc2hENUVXZnkzVTM5ajlUbktzY2J4WER3aVg1bDhC?=
 =?utf-8?B?d2tlTC9qQWZ1U2Npa1FaYVhBTTNCOW53VFMvY3FUcUdFNUd6WWpZb3R4VVVP?=
 =?utf-8?B?NnA0UDlnSVBKWDJtdVNqNitFMmUwWCtXOVB6cG5iSVFGQjFRcEwzZm5iVDU4?=
 =?utf-8?B?RVBHRXc0NUFpRkZXdVRuR1VyZkg1alEwWDJVK1JvdDFRalAzaGNkRTRyRi9k?=
 =?utf-8?B?dWRCTXpPNkIyNXdPb3RZQ3l2a0lNcGxHeUZoNzdSQ0dYdmNxQlo4emNBaWpM?=
 =?utf-8?B?M2Yya3ZsYUVkS1VNakZwbkZtQmtiM3hmTERseHNsT1NrdTgrTE9PWFdQSWpR?=
 =?utf-8?B?bHR2WkZrY3ZUVTVTcDVaTFczdEJZOElOaDE3UmRNc0NoWkNwa0Y5UnNXZGhS?=
 =?utf-8?B?Wm1jZ2pyK0FuMnhaTE1ycXEwVncyRGI1SVZvK0d0VTFKSlNqSklrZDR3dFN0?=
 =?utf-8?B?ajJ5Z3hBRFRHWmU2WW5VZ0t6bEJxdndoTGF4SW5xMmVtNGZlSHNyaTdIVkM3?=
 =?utf-8?B?bjVhYjlKYzdUYWFSczdJUUNIa3hlV3RxdTB2OXVXaW80TVZCRm5mTGFVMUR0?=
 =?utf-8?B?djNkUlBVeUhNaG1iSkN1US9QcDJxY25RazdsQ09hVk5xbCtGdUhjcW5DVnVQ?=
 =?utf-8?Q?Gkg7yAt0trOuowN17S/3KmLAm87F5Nw15YqSyHd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkZBMWljN00vSW1meEsyaVZOVTkyaWhPNE5qVVRNZDV0T3dyelpvb01UTXFp?=
 =?utf-8?B?RUNnc3pMRVlrTldHbmo5Zko2RHZ3N3FPNENZUmo4Sm1vUG9CYVI3MkY3NldH?=
 =?utf-8?B?S1RPSzJOTG9iV2U0RklvaVdVQnJxN0VvQXVIUW9ORFBGSHJmd2VRNlp4RENO?=
 =?utf-8?B?M3AvVW5hWE5ZOFJGU0lDcUZJQmp2bDFXbUpsUlJBZXZUckRoeERtVThFRi82?=
 =?utf-8?B?UjBUUldXYno4dE5NdTdDZEluZzUwY3FRczBVbUY5enM4Nkk5V1ZJOXZ0bXJF?=
 =?utf-8?B?VW13dzM3VmphR0tITXU0ajRUTjlra25Sa2NKRGtkMWhENHFDb0NtSWhoaHBv?=
 =?utf-8?B?bTZTeC9qcTdkcXJ3NHVJUWZSRFBRRlNrUWVxRUhnWGxvYkFGdVJ3UituTlUv?=
 =?utf-8?B?eHNlUDZRbHcyVFN5WHZHMExCUnhzanA2ck90bmVRVWk5MlB2allsVHVsZ3VH?=
 =?utf-8?B?NlRyTUFuREtqeURWY29iZVBLeitWQXJCWHRvU0lvRjMwdUVMcktFaUc5dGdJ?=
 =?utf-8?B?bnpSVElWNUxUN0xaT1FJNEhwVnVCakt5TkRqbXg3R1d3NGp4VEVhcUh0WXFt?=
 =?utf-8?B?NkNLamJSN0tnYS9Scm15SWFKRVhUL3dGVHNZNXdGVThFa3lYTVhvN0VyeEt5?=
 =?utf-8?B?aE9mdWd5NjJrL3A0VTNqYXJ3MExzSGMweU9KNklzOTZuSWVMSnZyN1o3STcr?=
 =?utf-8?B?QitpRnZySlpZWXZCTm1ublN5VWJnalovM2xGcEovVnBiSmM4Lzhxd3M5UWZq?=
 =?utf-8?B?WVpNM3AwQ0ZXT2FVcXdHT3RSanhGUU9iVXdzMjN3U29TUDZVOTJxR3R1YXln?=
 =?utf-8?B?Zk5vU2cycGNMakxkb0h1bDlmVktENElRWk5iTmxpK3N1ejZZZ3BlczNjbzls?=
 =?utf-8?B?YUNNQlpRSzdEZHl2Y2NVWm93SW94amMyUHNwY21hcTR5bUhOSkxCdXZpaG9Y?=
 =?utf-8?B?RFppblVwSnNtRXFPNlAvdkZWTTJxcnpwNHM1VjMxMHc3cmtJaWVDZTFSaytw?=
 =?utf-8?B?T29zcnZldXlMajZkc3J2N21Qbm0xWkoxV2lFS1ZLS1pnTnFlcTU3dEwvWmFv?=
 =?utf-8?B?bVV0eVBFWEJtYXNIbmxlbi9Qam9SbWpiUVhsN3hMbDJWMW83dTZtL2U0MVFX?=
 =?utf-8?B?ZEc1YWxWc0VDS0UyeDlRcy9CMHhxaGZ6TmhhTWhWdUhLSTUxRmhxMW5ZWGZq?=
 =?utf-8?B?R2NUUXB0WGdsS09DbEYzM3RJeVo3d3dxZXE2KzhMNW5mS1lIZ0JhU1JTMVdp?=
 =?utf-8?B?cUhvTkgvTVdYU3RMMEZYbzFDcmVMZlorSm9aWXdweFN3aU9OV0NSUWsvd05D?=
 =?utf-8?B?dGJxY2RPa1FPWTVzcVkwR25TZHE5eWY1Z3JhV3cxcnJ4NEw4QTZDWkp6Njk3?=
 =?utf-8?B?dUloVzgvT1Z4Qk5KeHljMEx5QVl5SnJRVmV1bW1oVmkyM3Z5VWRnMFhXNWRL?=
 =?utf-8?B?QjJ5dTRFT1BUTjVsRmNuVktTRnFmeXNGaWxBYWg1RndrT2ZFUmR4NFBuKzlq?=
 =?utf-8?B?NDVkN21vdldIUG1ZUlIvRlptQ3ZGQUxqejNUeElkVGt0Q2c2WWhsYnFuVERz?=
 =?utf-8?B?dGtZZVVsMUN1ZWNSR0huaDN0R1NxQ3VCMm96OTJnYTVXQVM1OTdUemFoZTkv?=
 =?utf-8?B?TnFpYVVlOGlrbFB2ZWhYR0dzWEFXTTlQYkN6bzdqV3pacXFXSnNRcVN2Q2dC?=
 =?utf-8?B?RHVTWlRlY0RsNXVHVmtuMWY4NDFTbXhaeGRHbk5KWDBtSHpGQnJUdkZ1M2lX?=
 =?utf-8?B?U0NVNHN2bkg2b0szNmFKeXVjNGJkbGYwdm00My85M2ZlR3NUY05RQmtORDJN?=
 =?utf-8?B?NWNtQ3U4Ly90VDRoamI0UVgyZXFLZmp1enRyc2ZObzR3ajVyMndMM3g0d0hN?=
 =?utf-8?B?ZVFrS09sZzFIRFYwejdPRXE5bkYzZHZrZHp5c2o1dnlTeFJYbk1ldUFlT2xi?=
 =?utf-8?B?Q0VOMEhYd2llV3o3QlBwVVlPcktRSTF6REdoRkR0V2Z1VUl1bC9rL0FDRnBo?=
 =?utf-8?B?YnQyRTEzdmhMMk9EeENzcGNCMkxCOUhhMDdaMmxERjhEWDBnbXVTN2Q5QTdG?=
 =?utf-8?B?dmRvWXN5QmxMb0loNU11N2F4T1MySkl4RXBraGVhcXZZbENnS0xsNklRZ1ht?=
 =?utf-8?Q?9Yb+2pmrUnG7WOcojkQaD2lSj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88ef1638-1a22-4c9a-b283-08dcf7341d5b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 09:37:18.5279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3GlnKfUhUQinbt7tYtWV48hSBGe9rBfV0sL8+sDSXfqMXTiImApbVXjgDMjqW921G7BrbRUYaNMhXOaxvoVf+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6787


On 10/25/24 14:50, Jonathan Cameron wrote:
> On Thu, 17 Oct 2024 17:52:00 +0100
> <alejandro.lucero-palau@amd.com> wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Differentiate Type3, aka memory expanders, from Type2, aka device
>> accelerators, with a new function for initializing cxl_dev_state.
>>
>> Create accessors to cxl_dev_state to be used by accel drivers.
>>
>> Based on previous work by Dan Williams [1]
>>
>> Link: [1] https://lore.kernel.org/linux-cxl/168592160379.1948938.12863272903570476312.stgit@dwillia2-xfh.jf.intel.com/
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Hi Alejandro,
>
> A couple of trivial comments inline on things that that would be good to tidy up.
>
>> ---
>>   drivers/cxl/core/memdev.c | 52 +++++++++++++++++++++++++++++++++++++++
>>   drivers/cxl/core/pci.c    |  1 +
>>   drivers/cxl/cxlpci.h      | 16 ------------
>>   drivers/cxl/pci.c         | 13 +++++++---
>>   include/linux/cxl/cxl.h   | 21 ++++++++++++++++
>>   include/linux/cxl/pci.h   | 23 +++++++++++++++++
>>   6 files changed, 106 insertions(+), 20 deletions(-)
>>   create mode 100644 include/linux/cxl/cxl.h
>>   create mode 100644 include/linux/cxl/pci.h
>>
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index 0277726afd04..94b8a7b53c92 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> +int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>> +		     enum cxl_resource type)
>> +{
>> +	switch (type) {
>> +	case CXL_RES_DPA:
>> +		cxlds->dpa_res = res;
>> +		return 0;
>> +	case CXL_RES_RAM:
>> +		cxlds->ram_res = res;
>> +		return 0;
>> +	case CXL_RES_PMEM:
>> +		cxlds->pmem_res = res;
>> +		return 0;
>> +	}
>> +
>> +	dev_err(cxlds->dev, "unknown resource type (%u)\n", type);
> Given it's an enum and only enum values are ever passed to it, we should never
> get here as they are all handled above.
>
> So maybe drop?  Then if an another type is added we will get a build
> warning.


OK. I'll do that.


>> +	return -EINVAL;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_set_resource, CXL);
>> +
>>   static int cxl_memdev_release_file(struct inode *inode, struct file *file)
>>   {
>>   	struct cxl_memdev *cxlmd =
>> diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
>> new file mode 100644
>> index 000000000000..c06ca750168f
>> --- /dev/null
>> +++ b/include/linux/cxl/cxl.h
>> @@ -0,0 +1,21 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright(c) 2024 Advanced Micro Devices, Inc. */
>> +
>> +#ifndef __CXL_H
>> +#define __CXL_H
>> +
>> +#include <linux/device.h>
> I'd avoid this if possible and use a forwards definition for
> struct device;
> Also needed for
> struct cxl_dev_state;
> And an include needed for linux/ioport.h for the struct
> resource.


Right. And I'm adding another include later on in this patchset that 
makes this one unnecessary.

I guess the problematic thing is to refer to that core device header 
directly which makes things suspicious.

I'll change it.

Thanks!


>
>> +
>> +enum cxl_resource {
>> +	CXL_RES_DPA,
>> +	CXL_RES_RAM,
>> +	CXL_RES_PMEM,
>> +};
>> +
>> +struct cxl_dev_state *cxl_accel_state_create(struct device *dev);
>> +
>> +void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);
>> +void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial);
>> +int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>> +		     enum cxl_resource);
>> +#endif

