Return-Path: <netdev+bounces-154913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0A1A004DC
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 08:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBB523A1730
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 07:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41971C3BF6;
	Fri,  3 Jan 2025 07:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Pyf1bkSn"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F45F2563;
	Fri,  3 Jan 2025 07:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735888861; cv=fail; b=Tc1+aZzhmX7Dj//siqLF15GR22PDpMdR4I9FPjlLjo+PX+yaBbmAT4fA6oLNQCU3c4vRnrTFpMpRH8VhP2Cu5YhuZg7lc81s7oNXkBj3BpPBwoZEPSIlxKpP/JNDoBR+3gskSHOCNUn9CtNOmTf0oVpXzYo49Orf0dK+XsbV/g8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735888861; c=relaxed/simple;
	bh=QUMb771iW8nDU83LBmop4hPsKF86KCTQIuwOR16N0Hc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BxzpRUNujnRFFL03yOKDXbb5sqQWKmPqEn9eCcDsQcXFyLUB8NfHGcqrxiIZtNSicRLztwnaUPF00n1CcimnDxNUhC/pfkACfSHHj2AcHyhW18TqVnBOnxEnglgFvlC5kiWK2Ry0CUvytMrHnRUtyCey1W40vdWEkVq8GqTuQzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Pyf1bkSn; arc=fail smtp.client-ip=40.107.94.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iEWfLVAwFPW0YP3i1y05gc2XGxgooSWoS+iYABLpK2xEH74lOH5cvKsS6Q73DE3OmnmmrTbBTybdbFXfmRxJ81xlpMD3ngyO3T7yyKxchxtgVQHpBI8I6qMxm2kFI7fopmx/6UWkpxpj3Vz6LCm+p3u7s/LzYdnUmmTJzqOEzQsxx9LEcUW5QnEAOL/4mHL5YeVwDz/hEVatJI4Mit516hreCxqAbubSavUJpltxhi+C2HzUDg2UmoLECRLuKZ8uP3cWJ45RhUE1m71Rfk5sJs7+m8ZgDQL6BKyJXCeaF6liCxrXIEae2wKEtLgFvobZXPc3l/mtx1A97e8V4x0koA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JNFnDNo/EU1xPEVIDaq1Qpc+BJdrpGYSDchV9MllaDA=;
 b=mFqUWN+7vfgrKpSVXWN5FMtMFpTATDR5rJK+TQ9Tga53cbinjS198trPramqiGi38cBnprx+biTq6Qbq0z+X7EOVxv0JA2IyDsRA0Lkep1+Af5nlg0l4JSKLTjzkUryWIQ3eGrV/rensXnloRmw2RUX3BWnJGpHaCCvAPJuqe4HpAW60xCR8zbm5mD9rzTbneVo5awLp+JlTjvozFEAOSdpgFRvjZjXCDCXVtVpo6Brt8g/+DcQQ0wMvWkWbmwQPy1WbVealeIvjvwyGNf0IsS7JdwZUOiyIOiPkqRITaSRlJM/qcATEQA+sAoi0Ff8vAYytq39wLsYC1OX36PjACw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JNFnDNo/EU1xPEVIDaq1Qpc+BJdrpGYSDchV9MllaDA=;
 b=Pyf1bkSne1wCTJKWcoOUeCeiMGgsb0GSrQ/lUCbNaHcZZNVj4i94UpYR3XL7laCxoahn2w5w1DnAdE8j1m8G5jng7r8eInP+Vzp4EFgI9OrBICpl0I369oYXNH9kMRE2EFyH9PxVeoxtXUY7U3r2BakiT+L9+zOb9fDXlIrMTVw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MN2PR12MB4333.namprd12.prod.outlook.com (2603:10b6:208:1d3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.14; Fri, 3 Jan
 2025 07:20:53 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.8314.013; Fri, 3 Jan 2025
 07:20:53 +0000
Message-ID: <ffbca9f2-80fa-530a-9ec1-9f811ee61e38@amd.com>
Date: Fri, 3 Jan 2025 07:20:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v9 03/27] cxl: add capabilities field to cxl_dev_state and
 cxl_port
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
 <20241230214445.27602-4-alejandro.lucero-palau@amd.com>
 <20250102143656.000061c9@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250102143656.000061c9@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CWLP265CA0279.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:5c::27) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MN2PR12MB4333:EE_
X-MS-Office365-Filtering-Correlation-Id: e943472c-5ebf-4f07-024d-08dd2bc72857
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZFhuR1Y1K1JxSE40bG5wSDNXSWwyQWlBVVhjblVHVWJGREZXWkhVYW96MDhH?=
 =?utf-8?B?TVdTcnRiWTRZSTRtd1hSeWJLMmNFWGpldnNMQW9VOHVISGs2OHdyLy9HdkJZ?=
 =?utf-8?B?MXRXK25YZHR0ZlE5ckFJam1IOUcwR3k1ajVCMkZQQTdLbDFpaklyZHdseVlz?=
 =?utf-8?B?MkFhUEZVU3Z3eXBtQlJyYzdMR3I2NUs3UmMyWEg3RUIrMmtaOHY5eGJtYlVV?=
 =?utf-8?B?VkJwN3g1clJ0N3dNdUN1QzRkVU0zYThZNzNyY0RDRUNoOTdLR2s5ZUV2SFhz?=
 =?utf-8?B?UFpyK0N0dnlmQ3kvWkQ4R09hUDhBRWJwdnZFUnRRa2xWWGYxZENucFR1K0ky?=
 =?utf-8?B?c2RTYVI2OWRFMXRDb1h3aGV2em9BdWh4VjJzTHdoaDJZK2FxZmxCWFlaTkhG?=
 =?utf-8?B?YzFkOXlSL09mTnNvY01zamNoem03V29pZE1xTHRRQjZoVS9OMlBKNVpQVXRK?=
 =?utf-8?B?NVJoeldZeVJsZDhUQ2lRTUtNcEJFbGpBWm5zK0d0NUp3WnF0VHlSeS80WXFR?=
 =?utf-8?B?dkpackNoUHRSUk5KM2I1b3VGM0JMZ09vN3pYS0hub3B0R1VFcnc1NlVVOWFW?=
 =?utf-8?B?a3ZaWjY0ZkZ1K2luWncrOFh6MTBHV3pQOThUUkJmV0oyQnNjZkZRTTg2UHVM?=
 =?utf-8?B?dC9Ja0JTc092OGpmRjBMQnFybm1sd1VqQk1Pa2MxVVZHVkJFWENLTml6WFh2?=
 =?utf-8?B?SjRKYmhiWlhZeVRlT0xNVW5EZFV3VWthaHBNQURMME5COUhFRkxrV09yalhJ?=
 =?utf-8?B?YVkzSUtXckYrSTdoUUJNWFNaR090dFBuc3dXVS84c3diRU85MlZOeGVrc3A3?=
 =?utf-8?B?ZW1GeXlaZG82am80K1dMV2wvUEJ3NTB1ZTJPVHI3cG9RcmpSUzd6U2tiZzhz?=
 =?utf-8?B?RCtzcmt1QTFNTE03MExKcmV4R3QrUVVRcXk2OFZ6Sm5LSjNtRWxrOXBtM2xL?=
 =?utf-8?B?M2p5VCthcW1VYVBLcEVvZE13em4wVFdMdlFXVUhHZzBVZlY0N3dHazNNYnV6?=
 =?utf-8?B?dlJOcmVQMlYyV09VbjJxRm82bFg0c2wzaS9KWmRSZUEwdnV4eW5rL3hnRFFz?=
 =?utf-8?B?VWVncXNLK2J5ams5YmhPSWhRMnorVWlEcDA4MmRKRWQ3cWcyTitHV1V1d2Nk?=
 =?utf-8?B?QjR5d0V1UmVOVlFqYjF1WjJ3MkYyREtUYmxybHpaOU5WRURsRnE0Tmk4bm1Q?=
 =?utf-8?B?TkxWZUQ4VFgzTXhtTkI4UXVIVkppSmlYcFdNMWtXVWZKOUk1MjBKQWZvZXBM?=
 =?utf-8?B?WTRvRW1TSWwyUHo3SWk5Q25yb3d0TithdmZXcERqcFJDaFREQWMrY095WHo5?=
 =?utf-8?B?QVNncWFCR0NQTm1hdG91bnhtcmxxZGpvVS9PR2tqU1VhNU9wa2gvc2E3Z1J2?=
 =?utf-8?B?UjQrVVRTSjYwTFFCZG9EUjNWdUdQQVJqQXRuTmhSZGtZbTQ4MkhQWGdwN2U5?=
 =?utf-8?B?V0Y5Q240UVpCSm1JeURJQjRCWGI3aWVYamN4QzMxQTlPR21GREo4azgxRTA3?=
 =?utf-8?B?Z0Z3RmE0KzJsbHkza1NoM2RjWG1IY1VHN3kyOERyVUVIb3Fha0REcDFVQVV6?=
 =?utf-8?B?TnJSN1daeWhSY2pyaDlBWExZL0paR1BnWXoxOWFxdHNscktVdDJJTFlaLzdr?=
 =?utf-8?B?aG04TjE3RWJZa2V4N0o2M2lweDlUMitibGJsQnNKTm1ORTZuQmFYZ3dEWjVC?=
 =?utf-8?B?Znp6cDBERWxvUHduYjF2c3pLejFXRmMxeENiZFdGM0VxL2xFTVErTVVtbitI?=
 =?utf-8?B?a011TGFKSjBuVk9idTRSbEY0TEVHTnFTOXhsWU1XUHVuYzd6YWFlc1l3amFw?=
 =?utf-8?B?QnB6Tm1Cd3hNd1k1N3lDUGltdGZQL0VoWVAzSGdNV1NBNWlsdU0zVnlOZ0hi?=
 =?utf-8?Q?AmH+zx8HgX0Xi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UkpIZVVqSzdkZUxqZ1lnelZUdmIreEpJcWxQKzYxTFZPUkg5OEVyaVhIUGhM?=
 =?utf-8?B?Mm0xRHZrVnYyMVN2UVVoOXZNblNaUks3ZkgyRGpUSE9EY0R2QWxnT2xtaVJ3?=
 =?utf-8?B?V3ZTTHUwZnJ4dWd1YUZodGxIZ3E0cW54czdpTHdWejlJcU04aE1LM1NKK2xF?=
 =?utf-8?B?UFBtVGJqdGxuV29KK0gyUzlqR2liTGE0aVkwbHg1T1o3NkVuRjJabnIydTlq?=
 =?utf-8?B?U3hockorblI5RkFlQjlIODg2T1NwRkNMSjRFSnhkRFRjTklFSURhRThNOHV5?=
 =?utf-8?B?d09Qdm9LWXVPcHFELzR2dFV5VW45TjZpS3JGTk5US3RzWmxmRG5Wei9WaWZI?=
 =?utf-8?B?V0wrWDN1Q2g4L3lnWXFqdFB4dDZGbWVGWGdNNXI5SmtXK0dZVkt0di80Yy9F?=
 =?utf-8?B?Q0tIWFlrWmdVaEhna25Tc1JoV25Eb0ppdFMxQnh2YXhxRTlMTFJ6Nk5DQ21F?=
 =?utf-8?B?NGd1c2VmSmpob0RLWldzZ0YzWTdDMXpOdTZsZHY3M2JJUDBJZllFeUVtNzAv?=
 =?utf-8?B?K2dnamUvT3NtVGNScjV1T2JvYlBuaEJaeGtDakNsUEFiOVRLUVFwMGY4NStK?=
 =?utf-8?B?Nk9sRFBlbUg2YTk1UVJ2c3QvQk1Uamk4RmpVVUlqSDk0aWdUZGJ0Z0EyQ1Iz?=
 =?utf-8?B?eFRBRmpnWjY1Zk9NcDRpcHpiSnpaMzE1cFVpY0tFbHpIVWFRL0dPcVVTbURn?=
 =?utf-8?B?ZmlncjhWRlhzeVM1aWFnQ003aFVtOThxK2FhcFU4NUF4cXhaUjdMc1JqR2o5?=
 =?utf-8?B?SHdZNjYzYzA4Ym1mRElYTTV6K3ZqWTlpR1hzWlpnc0Rpek51NHdodDNZYmh4?=
 =?utf-8?B?NXZ0ZHNVOUhUbnhOTTRvTUY0Y0xFUmY4OG9EZm1XUlE5aFBXSGFwOVpnWDJS?=
 =?utf-8?B?YkFPekJEbFdOSWhnbnBlb0xmQWp4MFZhZ2FCRXVOU0lUcmE5RU1jc0ZHNlVF?=
 =?utf-8?B?aWdCQkdEV0RqOVV0MmdPcnk5RUpRdjZuaVBjdVFWMUlrT253VEJxWVZXakli?=
 =?utf-8?B?VGVxN0NZWlVtTGs1a0R2QTY2Rlg4M3U4ZjdJZGNMcVRxdmVxeVVacU5aeXJi?=
 =?utf-8?B?MlIwM1Rlbjk4VGJTbFhMU055L1RlbmhHOHYzN2tWNU5UcFhKVHozdS9YMDNJ?=
 =?utf-8?B?WGFWNFgzMktVV0NGRWROSVphTGVNR095SFVOS1I0aGFMdmtkMWZZWHdzYWFQ?=
 =?utf-8?B?Yk55aTkxanJETTJPdW5rWEl6NEt0SjhOUGd3RWZkOFRvVGRmWmtCUFhiQ05C?=
 =?utf-8?B?M2h5aTZkbEQ2c0krN29JKzF4M1hxQVZPOS9VQlphNjRONjZ1ZjdhbUtVSmp1?=
 =?utf-8?B?eENac0RDVGgyOW51UEJ6VUxacmJEa3dmdnpXNkQ5WVc4QmRIL25BYXRsSkR6?=
 =?utf-8?B?VHVNL2hWcVNvMmRwNlNMRmY5eHhMTWlHb0VWQURBQ1R1dXNudTNHRE01Smhn?=
 =?utf-8?B?TjMzTFo4THN4YUNXRHJOdFZTWlZXRitER1hCWElWcWhQT1RldEZhNklYWWYx?=
 =?utf-8?B?Q3ZXMURneWo3RUU0YW5xK05EUy80U3Y1dHJqa2w4N1lldnJNd052cnZwSXhn?=
 =?utf-8?B?L0dtRHdhWitoYlU4NzFCSnh5NUpuYkE2dVV4MFpqRHFkNmQwS2lZVWpLOEhm?=
 =?utf-8?B?U2xWS1lVMWVjTU9xMEZDQ1JyVVo4NEIxVHdDZHpFUXNHdnZOb3M1a3VaYUlE?=
 =?utf-8?B?dXJWT1R5VHBoNUtNc21EcFZ4RUFTYk9LNUxiR3Vzc2VjRmNpL0pac0pkUnVD?=
 =?utf-8?B?Y3ZOTFZPQjdxSWxWRFlZTGQvek9XdEpyRy9iaW5pbi90Q01rSEYrSnlSSlll?=
 =?utf-8?B?UUpMekJpUURhdmVzQU9oZ1NrbFhrcGtQMzdXZS8yZ3kyR1dacEJGMXl0VmJa?=
 =?utf-8?B?WHFiZXZNVjhDb1ZNRWdzc0Q0Y1Q0aGxjdnYyTkt3WDI0N2xoamxwaGZXSUZ0?=
 =?utf-8?B?a1RGbUVDc1puK2VJZEdReml1VDZaMGc2RDZ4YjdBbC9oOGoyWFpRMTlRL01o?=
 =?utf-8?B?UE82WU9aVDFOVi96Tms4cnNtclVTVU5mWmZNNjZrUi9mOEZNckVLeWVwQXVE?=
 =?utf-8?B?SXl0WGFBeG4ramRoMC80TVhxV3ExUDJXclZ2OHExSHFpeXF3TVhmb0QrWjZ3?=
 =?utf-8?Q?VDzYjKNLzTmzmJo/R2V7GcfjC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e943472c-5ebf-4f07-024d-08dd2bc72857
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 07:20:53.3973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iEAhNo7GRs1QGKPJt6aEjwbOUpcn1GWWF1TOkAQoDnCjPk1y4fS3wd6rr9cchJ0JOhi3T1CdSKgIIAAoDgkqzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4333


On 1/2/25 14:36, Jonathan Cameron wrote:
> On Mon, 30 Dec 2024 21:44:21 +0000
> <alejandro.lucero-palau@amd.com> wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Type2 devices have some Type3 functionalities as optional like an mbox
>> or an hdm decoder, and CXL core needs a way to know what an CXL accelerator
>> implements.
>>
>> Add a new field to cxl_dev_state for keeping device capabilities as
>> discovered during initialization. Add same field to cxl_port as registers
>> discovery is also used during port initialization.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Comment in thread on v8.  I don't see a reason to have any specific
> bitmap length - just use a final entry in the enum without a value set
> to let us know how long it actually is.


I could do this but it implies to clear/zeroing the bitmaps with the 
final entry value and to mask bitmaps with that when comparing them.

I tried to avoid the masking, and it led to that use of sizeof and then 
CXL_MAX_CAPS=64.


> Using the bit / bitmap functions should work fine without constraining
> that to any particular value - also allowing for greater than 64 entries
> with no need to fix up call sites etc.
>
>
>> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
>> index 59cb35b40c7e..144ae9eb6253 100644
>> --- a/drivers/cxl/core/regs.c
>> +++ b/drivers/cxl/core/regs.c
>> @@ -4,6 +4,7 @@
>> +enum cxl_dev_cap {
>> +	/* capabilities from Component Registers */
>> +	CXL_DEV_CAP_RAS,
>> +	CXL_DEV_CAP_HDM,
>> +	/* capabilities from Device Registers */
>> +	CXL_DEV_CAP_DEV_STATUS,
>> +	CXL_DEV_CAP_MAILBOX_PRIMARY,
>> +	CXL_DEV_CAP_MEMDEV,
>> +	CXL_MAX_CAPS = 64
> As in v8. I'm not seeing any reason for this.  If you need
> a bitmap to be a particular number of unsigned longs, then that
> code should be fixed. (only exception being compile time constant
> bitmaps where this is tricky to do!)
>
> Obviously I replied with that to v8 after you posted this
> so time machines aside no way you could have acted on it yet.
>
>
> Jonathan
>
>> +};
>> +
>>   struct cxl_dev_state;
>>   struct device;
>>   

