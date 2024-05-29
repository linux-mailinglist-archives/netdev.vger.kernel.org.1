Return-Path: <netdev+bounces-99182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E8F8D3F42
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 22:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54530B2252E
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 20:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF381667D5;
	Wed, 29 May 2024 20:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WM45bsUq"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1C818E06
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 20:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717012925; cv=fail; b=UTNJByXXnV2oI3uUVGSaLiQ35oLK8hS2UWWx/C64KK5rO5ag9d85arvNzLMJSwiuZixz3jpmBSAYMAavrHy1A+WHtDVJsFqIenXsh7RJAEKnVJsyyODSt3xLTyVszOPqlYQThjGxl9VhvUUu2GxylgEr7bvRSG/LrrQzi2fAjPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717012925; c=relaxed/simple;
	bh=QYIk4XuV4HIDkUDnhl9wS9IuIfQCqpuLkUWHRvOyPDw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VeRomcjmhABS26Y40bBErRY01xF4CpkSMiJQWebP5U1JWZGVfVU1PXOXhsasBDMY4zaCFIOP18/jn6DwCY//wZsny5dITo7Xvun8iSTTPNdD5Q/A2XAKpnE52PcQ2JSDWcBGDG8RXzlLwHz5CwoSbGrmV4Rn72kZ6G1QQoH0KvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WM45bsUq; arc=fail smtp.client-ip=40.107.244.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QzCkO/mRRzzaSCPgEEAAE8jB2wz0+RNas3v5KQZrC8uPQVn7YX42Nu8BUh5mtBWccKfadvji6srcrD9IY2LykqmmOVSNm9xjSdoulSngWAOJHiClwZe9Falwp1HwN8LE6+GwIrnVuatEmq1O3w4nBWje72G3GQo1icNA4c1Vim8nESJXaFK9Thj0wKzw3DasnH+j8XEchECZPjCEouHnYZ+aiu/2hFAhsM0s8O7dUWWzWAmb3IxYJIHwDe/6LzJCGjUT0Qkl9pJwSuX5tsSdBV+/qf4vtzOIpXVjlpHX28GBMO3qQblYDm0Koxm8fMq1DfPp1r0ILuXymzEPRbRi3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QYIk4XuV4HIDkUDnhl9wS9IuIfQCqpuLkUWHRvOyPDw=;
 b=hkhKfTyaCBVeoPkjaY9dRcj+TRc1Ek9o63KmIXiwU9qUewhqZ7mnNhNBq8No/ovEucfieAdl+TaGv7CjBdHQ0DlnyT9iyPjFsYVmAODqNhjb66lInctfUOcEpK5/fLUjVMa3X5YNGtrS/LE8i8d2edU6eRT676WX8zPGnCh4bvNPA9UC7ebhEdGSaK4zVW4lpZWkr1oBhQ5N3W/Ub3iTYgv+v/HL8Y+Rkoz1md5q96vF/o5+Wl0CvkCMvHpRZt6T5hXDEdYoc8DxoC2Fhw/SH0eGlf+0JM2rMmsB6wIu31aYNaojcIfPNF21eNb1K6bXLGmHWDcRRSazLmcP5BM6Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QYIk4XuV4HIDkUDnhl9wS9IuIfQCqpuLkUWHRvOyPDw=;
 b=WM45bsUql+dji9lIJhrZOM3UyaHf49roWI1DPPnZHjG0HFndE/mvvGNIETOVT0ZErn2+dHQm1KVP7DNnoRo5JVQjsNlVVTNMOAwc0wMLZvIA6OO7YFL728DwfR1PvqvDB4hBnwWk4z+TlTjlSGZ+4FA+mHQWiG3Aufgor2RPtzlLBY7xje0alFmYcXleNy6Ckf3lI/FT5CIxfaqSB6uZMNEwkIF2O0S2cBrTk9oTMQepUYyap28jGIf0Trme+zpeTT/0oNdgrZ6BtmbKAfpTjZv+7+PmmixAMWttMnFpwEVTtbsvBeAR31G+ENhz5l3nUYEpVOsjWOvoCNYZJCwhvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5286.namprd12.prod.outlook.com (2603:10b6:208:31d::6)
 by SJ2PR12MB9243.namprd12.prod.outlook.com (2603:10b6:a03:578::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Wed, 29 May
 2024 20:02:00 +0000
Received: from BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::35a:28cb:2534:6eb7]) by BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::35a:28cb:2534:6eb7%4]) with mapi id 15.20.7611.016; Wed, 29 May 2024
 20:01:57 +0000
Message-ID: <b65723e8-aeec-4c4d-83b9-6119d5297f8f@nvidia.com>
Date: Wed, 29 May 2024 22:01:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 00/15] add basic PSP encryption for TCP connections
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com,
 willemdebruijn.kernel@gmail.com, gal@nvidia.com, cratiu@nvidia.com,
 rrameshbabu@nvidia.com, steffen.klassert@secunet.com, tariqt@nvidia.com,
 jgg@nvidia.com
References: <20240510030435.120935-1-kuba@kernel.org>
 <3da2a55d-bb82-47ff-b798-ca28bafd7a7d@nvidia.com>
 <20240529115032.48d103eb@kernel.org>
Content-Language: en-US
From: Boris Pismenny <borisp@nvidia.com>
In-Reply-To: <20240529115032.48d103eb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0270.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::16) To BL1PR12MB5286.namprd12.prod.outlook.com
 (2603:10b6:208:31d::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5286:EE_|SJ2PR12MB9243:EE_
X-MS-Office365-Filtering-Correlation-Id: accdfa76-35a8-4492-5291-08dc801a31b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RElaVm9oUkRnVHQxYWpaTGwrdUw0RGNQV2JzbzFBQW1kdys3MFpBQmVVR3dq?=
 =?utf-8?B?RG1iVFZjcThJeDQ4L2FKZEZSci9MTTlsQm1qTnZiV1ZhRUJ5T0lRZStQZ25l?=
 =?utf-8?B?c2JpNXpwVUc1TzRIQWpqc3M4OXVZb0ZsMVlMbWRPdXlCWlZ0N0ZUYmp2QUhR?=
 =?utf-8?B?ekpnYUpCVWZUdkJLdzZvK2FuSTBIajZjK0F6d1JkOWpNV0cxZ09ya2xJOC9t?=
 =?utf-8?B?WWNMUUpaTEFhTmJtb2hvYlFZMDl3WUxVSkFuckFLMDdFTGM2VC9pU1BmMWdK?=
 =?utf-8?B?NCtwSVA5WGZOQkxMOHZKZWgvdmlXZyt1VmliU0paMGszOE4zck9kVm1NWk4y?=
 =?utf-8?B?a0pVOEhTdDNiWmNWTVpHNXVsd0NYMlB0MTk1bWQ1SERWdlpPb3E0cVFhdHpE?=
 =?utf-8?B?SXUwb2xGQXVFbTJOWkhDNHFtcEhvb3U1cmk5c2lRQnJnMUhwY29pV3ZtNkhl?=
 =?utf-8?B?SW9VVXlwR2lFcllTSjNFSDl1L0tzUGZ4N0JGZnFWQ0V4Zlhkc09oN3RUK0RU?=
 =?utf-8?B?ck95S2QwN2ZmczRRQVVWc3YwZWVXT0lhblExdW5aZkFMY28zUHVoc2xkVXRo?=
 =?utf-8?B?clVIWkxLYmc1NnZlaCt4L3NXK0hHbWE5RFZ3U044ZzdDeHp6dDR3RmRLVDJ0?=
 =?utf-8?B?cXlKNzJnTm1VTFpzcjdDSmRQMkFqei9hN0l5dHZJK2p6UWZ1ZmkwVndvNEFw?=
 =?utf-8?B?NkVHei92cGdlbWJqb3ZzaGkxM1BDSjNyNHQ2aVNTczlRdE5wamRUZTVvVXBX?=
 =?utf-8?B?a0xoUksvdnJSNVVnZW1UdTBiY1IrdEVDUjduSmhSeExMSTNGY1Q5ZHM4SUdU?=
 =?utf-8?B?ZUp2d1hRVEd5ZmdXSHlzM05iUkZQRHJ2OXZNc21Ka0RFVmhvanVoMEtRdWJ4?=
 =?utf-8?B?b3hhaDF2TSsyZTRValE2TGIvdzlHNmJBUjFjWm5pRXdtTUhWRHBrTWdLWE5H?=
 =?utf-8?B?a2tDa3ZhVURWcXpWNTNVQXBwSzBzZzI2TVhjdUdFRExRZGhnMlYrZUs5cTE2?=
 =?utf-8?B?V2c1WU16UWRWM0hQdDZvMHVOVzlPT2JERVRDcFA2NUM1RFNZbUFoU3VZUHZ3?=
 =?utf-8?B?UWFJL3J0a08rY0R1YzY5ZERjSTh6NlZkK3VhRUp0V1lxQ2RZZHBEdnl6bGha?=
 =?utf-8?B?VzlhNDZ5VXFuU1dMTnBJNDVXRVR2Njk4aHQyMFE3K0JDTmVCL1g5S2s2WDZw?=
 =?utf-8?B?czYyaS9pZzk3RkJvTVpUMmoyMmxDUE1TWTNEL2tSMXlCV1FIMEQ3RU1iYjJK?=
 =?utf-8?B?bk5hYWVHNXQxV2lLNVhxbnl4RXJHV3diQW8yNEJHNUlBUDNPRXZkUGEvY2E2?=
 =?utf-8?B?MERRdGpDK0JHSDZMN1I3d3dzTDI1aGp2WDBRU3pYN1dVMis1Zy9teDFRandW?=
 =?utf-8?B?V1NaSFI2cG5HTzc1U0FuKzJ5Z0FOMml3RmkzNkpkcEtYZ05LSHdPUlpSTXg4?=
 =?utf-8?B?L1pOMk1sMzh2a05FUzViOXkwZVR1dXZQbkErNGI4RC9jc3Q3Zm1pZU1HWDdU?=
 =?utf-8?B?a0NobC9qSEhrNXhSMWFWRm5reWYxamc5a1BpRE9aTVdDWlJENVQ0QnJHa2U0?=
 =?utf-8?B?eU1lbU5IMmttVDhCZ3hCNENlR21rd05QVWxobmU5YUJCTWp2THJnY0U3NkVT?=
 =?utf-8?B?Wm5iWTRibEszZ3Q3R0F0ZW5ySVFlQUJOOFVPSG43bmowZUY5Sks3ajNyNmtL?=
 =?utf-8?B?REUzY1MvekZzeko0enhHSmZGWTdDcS9Qa0dKc1ZDZW9oZ01MKzYxU2d3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVVVbENiZTNJeStQZFY1N1FxUU5JNU1qbVZBZGZGODhlNS9vK0lOWmtzajdu?=
 =?utf-8?B?dE9rT1pTSllJdThxcjNUREVscDg1SkhSL2d5aVIxcC8xbzU3dnI2Wm45bEo0?=
 =?utf-8?B?enV0NzNNcmFYbXIvcWR3WHFXVjZmclMwZ1B1QzA5MFVndm5wU1dKOXpGYmIr?=
 =?utf-8?B?YUtSNTBnb1YzOEVMZjFzRmFVbEoyN0VRbnZFVGg2T0RlQWpuNmlNa1JlSVI5?=
 =?utf-8?B?TDEyQ3hSakswVmw2bFRkSTVzaWd1OVZoS1NObFo5R0dQTncwWmJReURBdFNv?=
 =?utf-8?B?SWkzRHRBNGhBRmptQmJHMUtnWHNPNWFObWd1M3JhdW5taU11VTRTUm1PSk9o?=
 =?utf-8?B?SHcrTE5ldjNiK3BiV0hWSk1TczhIYzR2T2lDMm5SLzFldnZkMTNxUnVwSUhF?=
 =?utf-8?B?WGx1Y3pYZTJNUE9FdXdRUmpkaWVZeG9jK3p6QkpYVUs3b0NDSmkzby9MNTJw?=
 =?utf-8?B?UzZsaGE1b0N1TUFKbGJwMHdWM1dJR0l3R1VsNmVjejFNL1VyN2krOXV3SWFT?=
 =?utf-8?B?YVJGb3ZaaEkrR2tGNzJJc3N1c05YYlZzb3ZLa1ZQOHNFUy8xL2VaaTZ5cUt2?=
 =?utf-8?B?cHpwbXV4K3FTdmo3aW55aE1vTDNYc1Q1aGRnOEFyNmRFV2NQS0NKRGhVSlFs?=
 =?utf-8?B?UVVzUVpZR21KSmoydFFWenhjaFpsb1lJT3k4SXlsRm1jZVZHZzNTQ2xMb0VF?=
 =?utf-8?B?WEc4TFNmTDhVdTRjRDV2YWo0UFhhME1MMWY4aUlDNVlHVzVQRWhsWFZQcWor?=
 =?utf-8?B?dUdQTGhpbXdkQmJXbnhSMEoyYi9TR3pIVkV2K3d5L1lIT3FRSnI4UW9XOGJF?=
 =?utf-8?B?T0ExUFFEY1oxNC91NkJRdGkzTmQrWC90MXN3LzZmL3hIMzQyQ1lOMnhkVzBP?=
 =?utf-8?B?aCt4Tlg1eDVvOHRGdU50TzJlNDVOVzhEUGdyY2pvUklrNWpNYUQvbXJnMGRa?=
 =?utf-8?B?UzhkSWg0ZXZFeG4xZzFvS2RNajVsSldvU3d2emNvVXBNZ3MrekhnWWxZY3R5?=
 =?utf-8?B?L2ZhSE1NMzBjbHFzWTcwL0dOQ0paY1NWM2JwOW9QWWZ5ZitMOVVkb3p2dlFY?=
 =?utf-8?B?aVppWHpPektFOGUwcTRjMHQ4REZiRWQxaVJmVlVESE5lL2ZwL0pnNysrbGN2?=
 =?utf-8?B?ZTV5VXBaTlF3dkVEdHZHK2srWTl4bklyeml3ci9tL29yZ0tDa01NQVVoU1FB?=
 =?utf-8?B?ZnB0aTFHR2JybE9nejlqeFZFdlk2NlBtWVIvVDBTWkZ0NGNuRU0vbjhZMWxH?=
 =?utf-8?B?OGNQeCtWRE1TOVlnRmRBOHlGK3JLWTN6SG12ODNWcnNubXF3KzRneHdVM0d1?=
 =?utf-8?B?b0FWbHZqaWRESWk1OGxPUUtvVzhGTVhMaEsyV3RqdW1jYnN1SDZsZ09RKzY1?=
 =?utf-8?B?bTgxNVZWZnJDQ2htWTliOXVTOWdHRXNGY2o0RGRYSWVVSjdnYkQ0dExlMU8v?=
 =?utf-8?B?dVYxTWtaQ0d4V1ZKQzJrbHhMb1VuWlVyc0xwMmlZajY4dGZQZmRJL2ZvZ0Ft?=
 =?utf-8?B?RjUzR003Uy8vYmUxa3Z1dnRqUGVzKytBTWh3cTNIbGhCOGU0dUtkemhXQlRH?=
 =?utf-8?B?eWM5QSt2VVRPZm5KNktLclFqb0dTVG9sTGpNV0FDZDJuZURselUyMGpvUGlU?=
 =?utf-8?B?VFRZUG92SXI3dW9uM0FFdCsxUEN6NTZZaE04MkNJRnRDbXVPVGllN24vNVli?=
 =?utf-8?B?RGhLSEgvUldyaFJDVkpCN2JsNkdta3kvdDBOeFpyOGZJbXhTRkRXMVFJZmRL?=
 =?utf-8?B?ZDEzelNEMW5BYytsU1QxRVBJVk9vb3BLL0MyK3lmNTV6UCtVN0xnbnlFSG41?=
 =?utf-8?B?cDN0K2lKaEE5emRCSENOc2ZZdVRDeGM1UmZnKytJeDRSZGt5ODRsdHRVS0Zs?=
 =?utf-8?B?N2d4YWYrSlE1T0xDNWEwSXZiNzYzQWNaYmhPSVhqRXRBSFMyVm5Jd2h5dmJ1?=
 =?utf-8?B?OS9sb2FvMjdoSGVobXNaUjhHWDdEM0lsTnBoOUZpUFdCa2ZWejBGS0hzdjFO?=
 =?utf-8?B?MDhSODVLUDYwMmZRaHVOdFJDT0VzRTJubE9DL0x4Ykl1ejdrS3JXR2gvOEpz?=
 =?utf-8?B?czBoRXpIL042cVNnc1gwVnMvRUpTL2JiSS9sUm5QNVJ6bW11UmV6Ty8vWWpF?=
 =?utf-8?Q?pR4nCy0XgEUwkk1dDlOEaEWTD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: accdfa76-35a8-4492-5291-08dc801a31b2
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 20:01:57.3085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FqFF8D1ftaLiktwKTBHPe7mkkH2aCmSpWtx7uZaTaqubxhp1/yKeBs+gFAfb09NcEKYDLTa4yQ7vRTW0roJzow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9243

On 29.05.2024 20:50, Jakub Kicinski wrote:
> On Wed, 29 May 2024 11:16:12 +0200 Boris Pismenny wrote:
>> Thank you for doing this. I agree that TLS-like socket support
>> is a main use-case. I'd like to hear what you think on a few
>> other use-cases that I think should be considered as well
>> since it may be difficult to add them as an afterthought:
>> - Tunnel mode. What are your plans for tunnel mode? Clearly it
>> is different from the current approach in some aspects, for
>> example, no sockets will be involved.
> The drivers should only decap for known L4 protos, I think that's
> the only catch when we add tunnel support. Otherwise it should be
> fairly straightforward. Open a UDP socket in the kernel. Get a key
> + SPI using existing ops. Demux within the UDP socket using SPI.

IIUC, you refer to tunnel mode as if it offloads
encryption alone while keeping headers intact. But,
what I had in mind is a fully offloaded tunnel.
This is called packet offload mode in IPsec,
and with encryption such offloads rely on TC.

Note that the main use-case for PSP tunnel mode,
unlike transport mode, is carrying VM traffic as
indicated by the spec:
"The tunnel mode packet format is typically used in
virtualized environments.". With virtualization, encap/decap offload is an implicit assumption if not a performance necessity.
>> - RDMA. The ultra ethernet group has mentioned RDMA encryption
>> using PSP. Do you think that RDMA verbs will support PSP in
>> a similar manner to sockets? i.e., using netlink to pass
>> parameters to the device and linking QPs to PSP SAs?
>> - Virtualization. How does PSP work from a VM? is the key
>> shared with the hypervisor or is it private per-VM?
> Depends on the deployment and security model, really, but I'd
> expect the device key is shared, hypervisor is responsible for
> rotations, and mediates all key ops from the guests.

I can imagine how this will work, but there are a few issues:
- Guests may run out of Tx keys, but they can't initiate key
rotation without affecting others. This fate sharing between
VMs seems undesirable.
- Unclear what sort of mediation is the hypervisor expected
to provide: on the one hand, block a key rotation request and
the requesting guest is denied service, on the other hand,
allow key rotation and a guest may spam these requests to
the hypervisor, which will also spam other VMs with
notifications of key rotation.

>
>> and what about containers?
> I tried to apply some of the lessons learned from TLS offload and made
> the "PSP device" a separate object. This should make it easy to
> "forward" the offload to software/container netdevs.


