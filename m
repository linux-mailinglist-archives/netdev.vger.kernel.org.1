Return-Path: <netdev+bounces-117671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD3994EBA7
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 13:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41F821C21474
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 11:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4B7170A0F;
	Mon, 12 Aug 2024 11:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2V3vR1Dh"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2088.outbound.protection.outlook.com [40.107.95.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE64C43AA1;
	Mon, 12 Aug 2024 11:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723461394; cv=fail; b=AAYRd8VXwYCTwSs1Xo5lHR9DfhnyuNb1pm0LCa5ifkKSdkJyKwUQ2B2JlVZHJv8P9SH1dKh9Z40eXuOx04RKM9tWQPYG1b/r5G0sKANbqzM/M4UK/MBqfEGkyPDw5FR3ep0g9IF/O/8ahrvmDPokhEQmgGJOMgLmVPMqT3L+fy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723461394; c=relaxed/simple;
	bh=2f0Ik++UW/waBAR6etK4ES8bsi1AlnnIwM0AOkWzXjw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pmQcx/Xnp+dFAMjCJ4aUYFgn2tmpiPqHkOj9ZBoolbf4KB6Oz4YM9BmehOAlUhnvO/ypz/3tqwy4V1x5rNXsaS9HTHayzMWtUyiIDIdCgg1KtTt81o8m6OOT4s8ouSsgqPfSaqUmBj78T/CA63zAmu6yhQuQoGp0lWdaaDsYy7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2V3vR1Dh; arc=fail smtp.client-ip=40.107.95.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YraSKzuK1hhR8+Wl6eH+sjxtK9kIXU6+ZjeDnFcNpaR2Fx2YncXbJicp5OxbrDwdgThvOIPd+vZBoHEXwC8JguU1YHflpHRgHwLhzXXYuv2hKZmReFZtCLZ+s87Nzr/O7eyJatRDA3G/SMEn6Q2OmGGK36xWrzw2a3OKxh0KFYGC6XJQKjzNSggoVfl5lAHxYoCwrBsPRYPHfEfn7YM4pdJgFa/BpGsLu/a6ArGNmJWCMkftDJiyXTLOIC2IefyqN7mwXY1RPq+0X+xV1lZsTnZN7my4G5VHpQ71GDEZZhxbreDfwE3SE07xgg0Jwhpcoh6ioQ3jagLzPBAAoM28HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Csn3no3mtwSJKcqKvnufQIkSiOsPtUzRbjdkkni7zQw=;
 b=j4gri6I+tghD6aPb6YxfZUNUjnRi2s8P2e7liOl79bRrYHqHq7zSf+A1+1ymCs7ncuXCd4d2gCUhY3rRUOQ91pAh0JzRZd2hu5SpVqpB3DxXVwwMx9ExhNm8H9O0pJRENug/RfP4G2aglKvEFWHjfOvCzV5NKX3FYQ+Z7FofJmKL+RaaKm26qUohkEGqF9Fj9gsI3kNHEJzoz3Az7q3kBZ0idjVDrkIOIrQNJrxShzULqJQYt/F1neYFNlQrwU1fIAFuNotrIm1xZ0bVW4Q1BGihF6GMRRmobhBE7oGqce+f4hZgOr91VgBf8lcadLwqzttyGJ+ypU9UOVvlePMBeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Csn3no3mtwSJKcqKvnufQIkSiOsPtUzRbjdkkni7zQw=;
 b=2V3vR1DhzSDA8WCKOCcFEJ+yuqGhITzi88EUVA7q6/+MX44Bay7i6J0fUAwKcFNsmsICaq+8lF+slUQfvDUCtbRCe5jJM9uOSvqUKcTZmnCjWk+MeWMS0SJ8LlW2hBy0xcb4HCBT0zkuOrVBcXthgLgJ+ri1zLHAag/rOHpRjxk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CH3PR12MB7739.namprd12.prod.outlook.com (2603:10b6:610:151::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Mon, 12 Aug
 2024 11:16:23 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 11:16:23 +0000
Message-ID: <508e796c-64f1-f90a-3860-827eaab2c672@amd.com>
Date: Mon, 12 Aug 2024 12:16:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 01/15] cxl: add type2 device basic support
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, richard.hughes@amd.com
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
 <20240715172835.24757-2-alejandro.lucero-palau@amd.com>
 <20240804181045.000009dc@Huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240804181045.000009dc@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0165.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::6) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CH3PR12MB7739:EE_
X-MS-Office365-Filtering-Correlation-Id: f5bf934d-dd70-407f-e7be-08dcbac03300
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?alQ1cUNVenJZU3UvdGs3OGRCdkFqZFBFSFpsdWNlSkJvZVNLb3lWTFgvWkdO?=
 =?utf-8?B?Q2M4R2pJamRtNk9nVm5MMGxKT2Z3ZTQrN2hwazZmMmZiZmJwMFovQ0p4dUt5?=
 =?utf-8?B?YmZpUE45ZUhlcUJ3MW9Lem1sdmM5T2M3OVYzbGVDRFJxMVVjMFVWaDRHazc5?=
 =?utf-8?B?SXZHZ2dQdEJnK05nV0hUTkFSTWdLSnpEUlI0eHpCMEpNSUV6V2VxR0NhUHgy?=
 =?utf-8?B?UEZkWnVjeld0UlhKWWxwdzFNVmJNWmEwS0crTmh0em5Mdk42R0VZbU5oMnVm?=
 =?utf-8?B?akVzTDVIR0s5MkVOWk8wc25mWVVwYVVCQjlDVHJwdzVBTjN2d2RjemsvbmpG?=
 =?utf-8?B?ZWhuTDUxS1g0OHJpV2lwTExTUXR2Y1V6U3RWWHpaSUFHaGJZbnVSRFlIK1RF?=
 =?utf-8?B?VjArSjA3bTRmSGZwa1grcnlwL3hLZm9KOWRkMDFXcjZCdno4ZzBZUDMyRnhE?=
 =?utf-8?B?dE8vLzJBRWhXQjlUemMvajJjc0NBQnlyem5rY2M0S0VtYm9NcmRFSEx0cWdt?=
 =?utf-8?B?dGRZNGs3S204Ym4xak5XZDRjb3dUOEp4WmkzdXdTZ213S1JXalBxZEZwdkdH?=
 =?utf-8?B?Q2Q5Rk15QnI2cHFmdlFZWjE3Qll2WnJKOTlERkpaa0ZtVXRYZUZBNDNFZnNJ?=
 =?utf-8?B?WjJnME1IckVwbG5wOWdPUVMyajJPbk5NSHRoMzhmbGp3UERGZ1BEVGNaZW5H?=
 =?utf-8?B?a0dRaUVJcmg4VlI3UnQxQ3Z5VFJTL2hSUUoraXR3WmxTTzk3c2pBRHo3QlEz?=
 =?utf-8?B?d1djY25GWlYxc0R4N3phYnZkcDVNcEtPcmN5TFozYlRBMStncFI4cFpNWkwx?=
 =?utf-8?B?OWFDR0pHTCtPbE9LQ2MrK3ByNHArUG1SODVkSWJWeFczU2hWWWh0dEtueGdQ?=
 =?utf-8?B?QW44MERPZzVvdkx2a0RzMktZT3p3U2NVRnFzTkdLK2lpa3pXL2FCL0RaSVdl?=
 =?utf-8?B?RTUwYkcrS1RqeUVQdmw5WUdBT0hCd3A1R3QwZ3V3STQrckx1aUhkcUp0RXp1?=
 =?utf-8?B?NTlSclZ3L1BabnY3WHdUZnZoNk9jclY3c3pwREJxdW1BMm02bEsya3NQMXVs?=
 =?utf-8?B?QzBtZ3lCa2EvTkpJTFFTaEUwNklOMGllSjlPa2JIL3JWelFPb0FUSGt3Z092?=
 =?utf-8?B?ckF1Wk5hTVd5R296Q3JKdG1VbFdhdUo1WmhMdjRHT1BlaEhMc2VHM0l6SUhS?=
 =?utf-8?B?S1ZQa0JISmd5NWNvV3A1NE8rUEt2V0lnWlNNUVhBcGxDUEUzRXBYL0Rua0Qr?=
 =?utf-8?B?TVgrQWIwTWJJMWNVYnZZVytKU2JIVkFjWDBITW5kVVpib3FnTFQ2dCtncjhs?=
 =?utf-8?B?VW5hY1V2RFdkYm5ZM01OK0w5cTA4bEFobkk0c25TUUhCajhUYXN6dHVZQ0M2?=
 =?utf-8?B?dDRZcmZUaVZGVHJwOVNsZ0RKRWlidjQ1cGZQQUdTU0VWeG1uWThOakhXa21k?=
 =?utf-8?B?bDIrU0srR05aZnF5UWtDUlg3Z3czMmVaQU5HdFVNdi9vMWVWZC96MTJNYzNu?=
 =?utf-8?B?WVROWUN6TzVpMGZNcWFmZVd5ZER3UTk4Z1MzZitXeHpsKzF6ald6NStpQkw2?=
 =?utf-8?B?c082bG1FS1ZWYTlaWFMrd1RaVHRESTVGV3prVTBMbXliOHQxL3R0Qm1DVUI0?=
 =?utf-8?B?Tit2dlhDOHFzVnM0SWY3QlUzbENvTTg1ckRTQ3lncm9CMXdraCs3RlR6THZ5?=
 =?utf-8?B?clgyOU5aZ1pnU0xqajloWWtSaVZqQ3ZBck5SOW4zRmVNOWVyQzBGZVVlRTdX?=
 =?utf-8?Q?kmwF+aZpjdU9j0zXxs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEw5WHArWGdWeFJkeXNTWTI2V3dnRTVTbG1Pa09oajBzYUplVVAranFKdy84?=
 =?utf-8?B?UlNrSUFyRytqYWlMVU05Q1l4NmRDL0NCZUtiUVRhcEJLUWFCZDRLeVVjemxp?=
 =?utf-8?B?SHU1SndrYjVjZHE4NEJDUE1mWktSejZHUDFXVVhNVHFJaTl1ZWJ4bGFrcmdh?=
 =?utf-8?B?V3BTeXBxSnRJVTRGOWN4cFZZMmZUMk93V0FydmRMTjVuMnZRSXRVdnp1TnVT?=
 =?utf-8?B?U1pneGhaUnlVZ0RGc01wTWdXbDJlZDREeVc5Tmc2c0F6SEdkZUJYWFlIT3Bn?=
 =?utf-8?B?OU1uK1p3Y3dVY3JxRVMwWXcyWkR0bXZ2YWxUSUwzMW5SZnpFbXZSb1VmR3k1?=
 =?utf-8?B?b2ZSVUQ5bmdXa0w5M2pyL01SdEhIVm94cDI2T25LMDlqSSt1aG1sTjRsMkpR?=
 =?utf-8?B?M2NFMWliNWpGVkoxL0N5L1AxdUNEZkp5c2pkdU9aYmtVOGJ5RUNTM3VoVENX?=
 =?utf-8?B?Ui9EeHIvSlRjTTY5K20yQWdjZGgvV29RdDlUWk8zWUpHaENJTU00eDJ4N0Fh?=
 =?utf-8?B?MWdESWwzcmNUZjJDM24xbi9PVEQ0Mmg4dGNrazNFNmh3a3M3WEhaWUlZNGRi?=
 =?utf-8?B?NmZ4RnRGbkhoM1R4c0JHUHhrRk9oeVFqTTJFcmwxVDlPNVFPR01KQm1YbkZ6?=
 =?utf-8?B?M0pzdWx5WDFPMTlGVjUxVHd1aUlvdTB1RmxaSWRtdElFd2dFQ2VYcmhkbTl5?=
 =?utf-8?B?V2w1SU9XS1F0cFhWYTBwVy9ySHdJTWxVckxtNDcvQUZvTFlBTXMrNFFNSTV0?=
 =?utf-8?B?VS9EMmV4SG8wY2d2aEp2OWs4Sk5jYkRoanhobFpySHpuK0x1N3FwV3dhVTRU?=
 =?utf-8?B?SS9Kb0Q4WnVnZWNWb280YTFYZUVzVjZQYnZGaUswelBFZG9OWkV5bUZmbThy?=
 =?utf-8?B?R2JaZTRWOHRZb2JaTDVoMVo3ZTIvdW44Q1VKZWJYRllKNW05dWJrTG5UNEZX?=
 =?utf-8?B?eE51VzZOOGl5QkNqT21xWURValdQbWh0eEdEUzhYOW1vVWtIbHhERzdWUmd0?=
 =?utf-8?B?bHJCZkdLeDRTNVl0UEllUGIwQ2VMRkxxUnlrd09OZFgyQ3hBOUVBNVdHRFVr?=
 =?utf-8?B?ZjFFcHJ6WEh3bXQ0eVUzUUJJRjYwY3pBbkpNelluMXRuK3lJeC9heDJJQlhl?=
 =?utf-8?B?OXpIWVE5T2YvYWdjR0kxd3o5YWdncUtHWjRqWm54elpRVTRrOGpBc3lURjVW?=
 =?utf-8?B?LzBDN1MrT1FqY3Q1QU1qaFB3VWM4UUUwbkd6eTZuMzhDYWd5UFJoZDNnS0hY?=
 =?utf-8?B?Z3dNek41K0tBNWIzemorczFOTW16UlZXOGZuVytqeEtkU3IyRmVXMFdaNDI0?=
 =?utf-8?B?MEFXSGVCS1UrZWdTK25KOE93ZXB3Q29Xa1RKN1pXdDNqUUE1ZFJQYmlyWk9R?=
 =?utf-8?B?THJRN1ZsaFg5SjlqSDlmd2orSzVUeUN0bE8wUmR2eElGcEIrN3ZTeEEyQUIx?=
 =?utf-8?B?RlVLM082MHdDS1BxSlpzRnRhc3E5TEFqbnhTLzdycUpTcTFxcm9zNDFLeGtu?=
 =?utf-8?B?WEIreEI0VldnbXhXbGFKZHpJcUllN3ozM2lveHBRcThDeXN3TW1ObDhEYS84?=
 =?utf-8?B?bDZCZnViUUJWNzNNdlZZekFxYkJheWlsR0tYSUErbzB5MTg4WU03cEhOL2NU?=
 =?utf-8?B?dTU1MFg4S3U2WDJMN291elRYejBxblVFazZVdk93SFRTbmY3Y0NMMVBPaWpR?=
 =?utf-8?B?bGc4eVJmS1lTVWo0RytJNEpmVnlTWjN1Vmg2YjQzZUpHQUJsck0wRTVzNWhG?=
 =?utf-8?B?NEdEenZOS1hScncxSWtZOTBYaVFtdis3VnRGak9rcm03ZkpLUVhIVlhmU0ts?=
 =?utf-8?B?U3MxOEpwSnpiVjhmOVVuZEFFdEZLWmlpWkp1L2MwbG1YQUtoTU9hQTFwWUdY?=
 =?utf-8?B?SkVIOTU4OGc0ZVF3QUU3QXU1cDZUWlB2VUl5blJ2VzAyMjY4cGo4aTRRUzFy?=
 =?utf-8?B?eVlXdTZEYjFQcFliSHRpTi9qdjRhNGZTQ0s4RTVRSzc4clJsdkQ2aGY4WEdZ?=
 =?utf-8?B?Tmt6SUlqY3QrTTVvWE9zTDBvbDR5TGNMaER0c1Q0Tm9WREFiSndvY0R3cC9J?=
 =?utf-8?B?ZjdsZWdvb212b0JOanhMenhodW5zd3RRbUZGdlV1aG8wYXV3MDRveWt2aUJS?=
 =?utf-8?Q?m4zRLwasFTcv+HfKrC37pMnLI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5bf934d-dd70-407f-e7be-08dcbac03300
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 11:16:23.5797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 153HTUIc7N6qLfklQIL/Hz21z3iH7di7m77pqF1WyEnIMFu/MSNs0lBk/rSd5MaANd5ZXvsQQtvI69nBMaZCow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7739


On 8/4/24 18:10, Jonathan Cameron wrote:
> On Mon, 15 Jul 2024 18:28:21 +0100
> <alejandro.lucero-palau@amd.com> wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Differientiate Type3, aka memory expanders, from Type2, aka device
>> accelerators, with a new function for initializing cxl_dev_state.
>>
>> Create opaque struct to be used by accelerators relying on new access
>> functions in following patches.
>>
>> Add SFC ethernet network driver as the client.
>>
>> Based on https://lore.kernel.org/linux-cxl/168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com/T/#m52543f85d0e41ff7b3063fdb9caa7e845b446d0e
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
>

>> +
>> +void cxl_accel_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec)
>> +{
>> +	cxlds->cxl_dvsec = dvsec;
> Nothing to do with accel. If these make sense promote to cxl
> core and a linux/cxl/ header.  Also we may want the type3 driver to
> switch to them long term. If nothing else, making that handle the
> cxl_dev_state as more opaque will show up what is still directly
> accessed and may need to be wrapped up for a future accelerator driver
> to use.
>

I will change the function name then, but not sure I follow the comment 
about more opaque ...


>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_accel_set_dvsec, CXL);
>> +
>> +void cxl_accel_set_serial(struct cxl_dev_state *cxlds, u64 serial)
>> +{
>> +	cxlds->serial= serial;
> Run checkpatch over this series before v3 with --strict and fix the
> warnings. Probably would have spotted missing space before =
>
> Sure it's a series that is kind of RFC ish at the moment but clean
> code means you don't get nitpickers like me pointing this stuff out!
>

Sure. Thanks.

>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_accel_set_serial, CXL);
>> +
>> +void cxl_accel_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>> +			    enum accel_resource type)
>> +{
>> +	switch (type) {
>> +	case CXL_ACCEL_RES_DPA:
>> +		cxlds->dpa_res = res;
>> +		return;
>> +	case CXL_ACCEL_RES_RAM:
>> +		cxlds->ram_res = res;
>> +		return;
>> +	case CXL_ACCEL_RES_PMEM:
>> +		cxlds->pmem_res = res;
>> +		return;
>> +	default:
>> +		dev_err(cxlds->dev, "unkown resource type (%u)\n", type);
> typo. Plus I'd let this return an error as we may well have more types
> in future and not handle them all.
>

OK.


>>   	pci_dbg(efx->pci_dev, "shutdown successful\n");
>>   
>>   	efx_fini_devlink_and_unlock(efx);
>> @@ -1109,6 +1111,8 @@ static int efx_pci_probe(struct pci_dev *pci_dev,
>>   	if (rc)
>>   		goto fail2;
>>   
>> +	efx_cxl_init(efx);
>> +
> As below, have an error code. This is not something we want to fail
> and have the driver carry on.


As you have seen in another patch when CXL initialization is taken into 
account, the driver can keep going if this fails.

Those pci_warn/err inside CXL core should be enough.


>>   	rc = efx_pci_probe_post_io(efx);
>>   	if (rc) {
>>   		/* On failure, retry once immediately.
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> new file mode 100644
>> index 000000000000..4554dd7cca76
>> --- /dev/null
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -0,0 +1,53 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/****************************************************************************
>> + * Driver for AMD network controllers and boards
>> + * Copyright (C) 2024, Advanced Micro Devices, Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms of the GNU General Public License version 2 as published
>> + * by the Free Software Foundation, incorporated herein by reference.
>> + */
>> +
>> +
>> +#include <linux/pci.h>
>> +#include <linux/cxl_accel_mem.h>
>> +#include <linux/cxl_accel_pci.h>
>> +
>> +#include "net_driver.h"
>> +#include "efx_cxl.h"
>> +
>> +#define EFX_CTPIO_BUFFER_SIZE	(1024*1024*256)
>> +
>> +void efx_cxl_init(struct efx_nic *efx)
>> +{
>> +	struct pci_dev *pci_dev = efx->pci_dev;
>> +	struct efx_cxl *cxl = efx->cxl;
>> +	struct resource res;
>> +	u16 dvsec;
>> +
>> +	dvsec = pci_find_dvsec_capability(pci_dev, PCI_VENDOR_ID_CXL,
>> +					  CXL_DVSEC_PCIE_DEVICE);
>> +
>> +	if (!dvsec)
>> +		return;
>> +
>> +	pci_info(pci_dev, "CXL CXL_DVSEC_PCIE_DEVICE capability found");
> pci_dbg();


Right.


>
>> diff --git a/include/linux/cxl_accel_pci.h b/include/linux/cxl_accel_pci.h
>> new file mode 100644
>> index 000000000000..c337ae8797e6
>> --- /dev/null
>> +++ b/include/linux/cxl_accel_pci.h
>> @@ -0,0 +1,23 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright(c) 2024 Advanced Micro Devices, Inc. */
>> +
>> +#ifndef __CXL_ACCEL_PCI_H
>> +#define __CXL_ACCEL_PCI_H
>> +
>> +/* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
>> +#define CXL_DVSEC_PCIE_DEVICE					0
>> +#define   CXL_DVSEC_CAP_OFFSET		0xA
>> +#define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
>> +#define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
>> +#define   CXL_DVSEC_CTRL_OFFSET		0xC
>> +#define     CXL_DVSEC_MEM_ENABLE	BIT(2)
>> +#define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + (i * 0x10))
>> +#define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + (i * 0x10))
>> +#define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)
>> +#define     CXL_DVSEC_MEM_ACTIVE	BIT(1)
>> +#define     CXL_DVSEC_MEM_SIZE_LOW_MASK	GENMASK(31, 28)
>> +#define   CXL_DVSEC_RANGE_BASE_HIGH(i)	(0x20 + (i * 0x10))
>> +#define   CXL_DVSEC_RANGE_BASE_LOW(i)	(0x24 + (i * 0x10))
>> +#define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)
> As I think Dave suggested, pull any defs you need to linux/cxl/pci.h or whatever
> makes sense and make the exiting code look for them there.
>
> Ideally do that in a patch that does nothing else as simple
> moves are easier to review quickly than ones mixed with real changes.


I'll do.


Thanks


>
>
>> +
>> +#endif

