Return-Path: <netdev+bounces-129509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5847398432E
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 12:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1271928661D
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 10:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76206175D29;
	Tue, 24 Sep 2024 10:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P1s14OWc"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8ED335A5;
	Tue, 24 Sep 2024 10:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727172521; cv=fail; b=JIV8UpP9ryu/kYfMLIlDmHbBQPe899tAWx1JnAD+xyMN7tbwo/r+k5A8A8jnmydcNewGf24ANjBMZNx+lcWsFYf/ad8doA0OwStlbCi8m3M+dMYFjoW8JHuyP5p75KdMDJDaqEJ8f6YPToW1IVXmYf+TxoaAnZlD8E06YWS3aEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727172521; c=relaxed/simple;
	bh=FhXf7Z1ZwtxHRBGfZkOYic8oGjbxMrj2uVtR2RESSu0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YVdl6h9kjHUIsFEM/CSX4XZoJiJo8NJrocHRojU1C0ve+XJevt8cLAjqPsQRx20Tqhl/ErCcdvwTLi70g67yAR25tYFC8sckkP/nvVHfV8RzQiI2Kv4njgEW/S1XL4T6yONgikDrVN7TMHAnOrrtnyzkf/OrLqyx64MRUIRUu4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P1s14OWc; arc=fail smtp.client-ip=40.107.243.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iqpvbDrOQrFUtV0+hvfm2cZu312/EPo24Ps69IlFSIp+0vqXRnNqM58u9bswrwo2c1QS/UStjMUo/vZ5WqK47hjsV2VsOTs34X7w/OHvjDsN/Ug4Y5cZa75tcXK24g65/nAnh9m9QFtu7uOPObuQMY5R6fOII2e4h6D9rmhiY2dDHE7JhDFJvqur5eEAXH0qos8JnYvltH4FB2mcqa2gU0mD18K2bEoIVkre8zdgdscIylfm3atq+RpsNXiddyCHOhutBe0JlzmFkKj7IZljAvzeAff9iRdxJmP/8LfOyZ2zDV6O3rc4A6EnRCAPUBEb05mTy4nVSreJmTsApmb5Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/CxFmaWmyyOVe/lyYjvsjeFgQ8SndZpxSmTVWVbuzg=;
 b=BrrptvXyI7gMRKOh5vAdGesTbfiTfcBSdMs7CtF90S27Ab2b6ACQhwKDlJiXhYaJJ/f3acRksH8zQfqoMZKNIvzlBeHXL16cPSCfkURNfsyCaYf6Fo2pOmQGc1Y6s4E3WP1LRAxrYJzAwQQrCqH33rOSNRrQGM01bqAXUPzg1vZv2q41dDey5yOW5LfdQSQxQoa+/5Ueaw9I2F50TBbhTKUAmulWPrCUB7w1fwVwcpu+Yqd4Hl/GVPRV8wAtVXYYVn/HTmho1kGlVHMsH2EUvZ88703l19BpapCANdjV4Ulh9Y3UB0hIopAfCZz+e7C2JzgITL4MsgTmMU84zag0Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/CxFmaWmyyOVe/lyYjvsjeFgQ8SndZpxSmTVWVbuzg=;
 b=P1s14OWcKTrqHJszB7tz1HBWlRF29L1RCJuFpIqX74R9hZoh/3qWz2k3ko3AWOWB7rWk7Olz6nbQPisDJbha4hwJknEEH+HXOrmiiUDl7waJ3TNQMRAfgQbS2KQYDvnaKMiMJRBsg4K5aTu0Q85AoEwh1nZ8FPaSnicHGeZDqY02szucYJ5t4UNqd1lDILL2jCOKBTZGtPCRCrk5OTvOyjC3hxwfhtbxQjdwxQ7mVH5ifjTp1sMZzimIaZQ+5E7Q16RIJF4eUsN70g1schpOkyyfnj71Rqj8tsTJyYJDWKEVtysxgdO/XLEt7sIOCBHoTDEhnTmtUpbek4HwCtbraQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM8PR12MB5447.namprd12.prod.outlook.com (2603:10b6:8:36::7) by
 CYYPR12MB8923.namprd12.prod.outlook.com (2603:10b6:930:bc::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.27; Tue, 24 Sep 2024 10:08:37 +0000
Received: from DM8PR12MB5447.namprd12.prod.outlook.com
 ([fe80::5f8:82ee:7da9:219b]) by DM8PR12MB5447.namprd12.prod.outlook.com
 ([fe80::5f8:82ee:7da9:219b%4]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 10:08:36 +0000
Message-ID: <fb04a8c0-371d-43a8-b345-44a226d57eb4@nvidia.com>
Date: Tue, 24 Sep 2024 11:08:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: stmmac: dwmac-tegra: Fix link bring-up sequence
To: Paritosh Dixit <paritoshd@nvidia.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: Bhadram Varka <vbhadram@nvidia.com>,
 Revanth Kumar Uppala <ruppala@nvidia.com>, netdev@vger.kernel.org,
 linux-tegra@vger.kernel.org
References: <20240923134410.2111640-1-paritoshd@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20240923134410.2111640-1-paritoshd@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0035.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::11) To DM8PR12MB5447.namprd12.prod.outlook.com
 (2603:10b6:8:36::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5447:EE_|CYYPR12MB8923:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a5ae1c0-d49e-4416-0f0c-08dcdc80daf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K3BCYVRJcU4yNW1VRWN6M3pmaHlOcDJYZE0xK1g1a2ErM2k3T2d2WXg1eEdC?=
 =?utf-8?B?SktPbDEzVzhBSHVWWWVlQythTUVEY1g4WkNHeWEyRU9zK1RrQXIxeWMxRG1i?=
 =?utf-8?B?dFFGNUJlMy9QS0UwUzNnUWltcnprc2NpZnEzQ2V5YkszWStYTjdLNG9CaWR0?=
 =?utf-8?B?N2JHY2dEaGxtanU5dGd0VnpRRmpOZmo5MUF0R0VaWEVrVGRBRWhCcnZhSGti?=
 =?utf-8?B?ZTZ0R1hWWEpxV0U5d0dHb01uS0hpNmhpMzVCUW9Pbi80d1pxSGpQckhLWktx?=
 =?utf-8?B?OE00aTdSVXIvaGxMeEUwc2ZDS1pDUC83alBGR1ZSSjdlNjRTUC9yQ1BFWUs2?=
 =?utf-8?B?b0xIRnA2MEdRYXFEZXRGWkRwMEZMMTJScy9aYjJzS1FVVlRSaUdzTlBRdFdX?=
 =?utf-8?B?WDlnN2YxZ01iRlVJN2N1MjVtQXllNWVGYTJPaHpmVktJcmVGdVY5RmFhcWhm?=
 =?utf-8?B?eU8wVFV6SU9xUXFreXBrR1BoTTFwSFdvYll0ME10aHdRdVRoSjdHdzE3ZjhX?=
 =?utf-8?B?am92bnc4a3ZGczJ6TDdQQVZITUlGNFZ3YVhQS28rL2VFVDhVWlNMY0puY0Fa?=
 =?utf-8?B?R0NGR3R6MEw2WUJOS29tenkwNXAyMERtZHpkTFYxWHlrQzcxTUc0N2N4K0Nk?=
 =?utf-8?B?M2ZTMTJGS2dQUVkwcnE4bk5TaFAyNnBsZDQ5cHE1MUl5eFVabW5OaTNSQzVt?=
 =?utf-8?B?WFRVVWIrMjdBUnhRWjNLYytobE9zSWtlZjhqZjZSQlE3aG4yMTBidXYvUDdN?=
 =?utf-8?B?NHZXbWRyNnJvbEFWUW4reHhNR1pvMEpBemFQM0wyelQxSThJVVhFREI3TEJn?=
 =?utf-8?B?d2dkWjdCRnJ4ZHZibHN1VE1Pa0p2UDBXZ25PSTFBOGNVZzBlWWtaTVZxblhu?=
 =?utf-8?B?R1NZZXFSYUtoRzlJMGV1MXd1cXR2U1NhYXB4ZjBZcmdHVS9oem5IM1l1KytL?=
 =?utf-8?B?amFQdGxTby9wcUgwdXNENWxzN1FRd25IL2NZTHlrc1FCRlRMV2duc3VkOXBp?=
 =?utf-8?B?TzRiOU11RXZqUlRGUmkyUW1IL1VlTUFadFJweDVKb1IyNFd6OGp3WGNWOFhu?=
 =?utf-8?B?VGlTaUJYOWdnWm1aS2JycGk4eDNXRXNJMS8rb1ZDRzJCYUkrMit1ZFdjd3hQ?=
 =?utf-8?B?YTZwWEdacTViMVdORzJ3NlFuUWxEVHVTRXR1RGVHTVpFQUZJenNFNWYvNHdB?=
 =?utf-8?B?a0lYaWoxUE15dVJ1S3JkYXZoWXdKUVpkZlUwQ3U1TXV0WUFtVzBLQ2lnVDJz?=
 =?utf-8?B?NVhoNnBrTW1wN1REVmRBUmVUR2JOc0V6TzkzNzFHeWwxcUpGTGRkd05wSkJ0?=
 =?utf-8?B?MTR5dFRMU3dzaWNPSWVhUk1CVXVSVWZlMTQxeHY2S3hWSDV0aDdpUUNXZHZl?=
 =?utf-8?B?VEMvQlNFYXdmY3IzbGZVS25JdXB2disxUFFWUHYza1BrNzkzNWJQSkEwblZw?=
 =?utf-8?B?TGE2RHZDYWRUMzdXNXNIeGVvS0NuYVZrUXR6US9IZE9EZ2M4M0c1MElRM0I5?=
 =?utf-8?B?cWhGSjJqTm1vWnhBbUxtZDRjbUNLUnR3dzZSUmI1MS9TSkptZDkrUkllaTZQ?=
 =?utf-8?B?M0tHOVpsTVdXT2FtOW44UDByVDZvMjZ0NHdxLzE5OXdaZG53TGZiaFJWNXU3?=
 =?utf-8?B?REdMbkNhb1pIWHZ3OWY3NC9yNHIyM1pseGsxMEd2V2lDdm9SQmFieEhBcllP?=
 =?utf-8?B?T05vREhFeWk1STd1UVZlRGtQT2QvNGZkdFliUDR5WTd2YVE1Mzg3N2lBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5447.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUdMWi9ncHBrQlUvaFo4UVM0RjFwc2hEME5WK2JIRzJwWS8wdE1JRUFjZEpX?=
 =?utf-8?B?MmtmTTJ0SzdITlNZWEl6MGlOenc3dzl4cGpMdUppK1NBMzNUMDByNkRpZW5r?=
 =?utf-8?B?N2c5ZXZlSk9xVklOZWNaWGVlcks1UTEyd1pjK28zZXh0eHFOSE1IL2ZBVjRx?=
 =?utf-8?B?UmlOdmdSTXpYcFRuUkwwQWdESk1XVzBpZ0ZKU0hObHZZM2I4Uk1MNTh1bk0x?=
 =?utf-8?B?RlRvRWdKSHRHZS85amVTNWNnSGVwMGJlREUzVVpWNGNWajlLN0ltcjFpb1Nq?=
 =?utf-8?B?R2h1S05VdEhyYS9NdExaR2Q1R1pKNUxrc0ZabkswcUltME9GZm5Md0hMdmlm?=
 =?utf-8?B?dGRDUGQxWFNKbjVmUkcvZ1I4cXMrQ2xiQ1pwcmlXWVNPYWlRb2ZiazI4dDZt?=
 =?utf-8?B?TFgrS1h6bVFZdVF3TGwwSlQvNU1kNjNyRitIaG1FSEQ0WDdDUmY3WDUzNE1Q?=
 =?utf-8?B?S0p3M1JscjJ2emN5bEZWNzV1bG1oTHRyOUFmOUtLRnFEc05xZWtoTUdZeTJN?=
 =?utf-8?B?QjFmR254a055MjlnRGVWY2FBNTAwa05scTBGMENnY1FldC80b1pCUEJvWjZn?=
 =?utf-8?B?ZmdrWitPUVA2UGJUSldIaWRINkVUM0EvZHRyNms2K2JuL0g2WGNkS1hPMkpU?=
 =?utf-8?B?QXFYdUVRRTlpYWpoSTU3eCtVYit5QWVlUWZac01VVjdGZk5mNjJYdWpPbExJ?=
 =?utf-8?B?Ly9QT05XOTVFdTlBUUU2ZHMvNkUrMnF0TDJSWXE1c1JWZ1A4eEc3R1NUVGRU?=
 =?utf-8?B?azVUekRiRTB3NEY0QitRcjBkaFhLN2Ewci9BcCt2RGhTeDd3N3c1Y1pWeE96?=
 =?utf-8?B?SCtiSS9IYldWNk9VUWZBMnlieDd0WXVBemNYVzNMR0NyK3FxclBzMmswZjBB?=
 =?utf-8?B?ZVk5YUJrR203d01ibFZqOXhYRTlBSEsyN1UrSE9walBzWlE4Sks3dzMrbnVB?=
 =?utf-8?B?dTNVUTRrdlFHbDhyVHUzR0VEK2hOQ0Q1R253RFk5cHpyaEhJRHk0ckkzcC9D?=
 =?utf-8?B?TU1EZ09GOHZvaGRvaVRRV0dLWnVFMXZuRUNGWVg0SXN5NFlGY1lTWVRsZDlG?=
 =?utf-8?B?cVlya1NJNjlMZFBQRzJtRUlRaVdoM0xhd1YzMzJxanh1QkRhUFBmMjNTRmY2?=
 =?utf-8?B?b1lNWmowa2NVUDBtOEljZ2FiNExwNDZMN21uTlNiVGh5cjJtZXdxNGJpS1JQ?=
 =?utf-8?B?ZTIzZTVIVUpzckNWUTNPZ1FtdDJkaXk1YTdEZHFxWU9ISW5HR3I1MDloOGEw?=
 =?utf-8?B?NzJ5UzUyZGNka1RtenYvU3ArZ3h1V1p3S0NFREdoeDhicStBbnhma3hWMnZB?=
 =?utf-8?B?V3FsSkR5NlVYamhLUzhJUjRTek5hUDJvMW1vWGE4RVIxblZPV2pZbHpiVmIy?=
 =?utf-8?B?OVJYVDVLRDB5MkhyUUVpMEpwdm91RFRIVnRJbTNuOENDZWRoYm52QjQzeTJQ?=
 =?utf-8?B?WWZPTEt5aC96SFVUTEVLNmtMaHdwTzQzTWRBSnJQakhwTFVrT2VPZlZ3TDdL?=
 =?utf-8?B?dUxJWHNnYWxmVWZHYVMxeDhxTUh1NG1SV2V6SzJkRTQ1dWRlTCtjclRWN2JL?=
 =?utf-8?B?R05JeEgzckRKc3M5L1FXa3ZnTzJCbFl5QUp1dFEyRVNUN0xoSllmVW5Da2NU?=
 =?utf-8?B?NnFaT0luNUFWdGVIRXh4N1lUMUg4S3hkZjZYYzRBS0hFbThzNjQ2YXQ5dDBB?=
 =?utf-8?B?YjI2V2Z1ckdVVk41dWExREJjRlVVd3h3KytGMHZoOUFCZklmbzREeDR6aVRx?=
 =?utf-8?B?SHhtaFBSeUlScEg3dmVmNUc0RmMybUUwOHBYUTY5ZnVvNmZndzhSQTF2WnRo?=
 =?utf-8?B?ZWpGc21GOEJZelZNZytQa3J4K2dsMGk4bTc5QWNEeUFpR2VLcFRPMDdEaHgz?=
 =?utf-8?B?SFVqUkswSlJHak9mckNBLzN6SkVhWDhNOXRrOWFib2NJNVZsakM1bjFCZTNm?=
 =?utf-8?B?NVovdEZhYk0wUnBmMnl5Q21DSlRPWEx2U0RlSGVYVEVHTEowRFF3VUs4UWN3?=
 =?utf-8?B?VU1XTjc0L05VbGVMcDNvSE1NNEZKbEI5V3o0NWZDMG5NaXFTWk9OK29ZTFBQ?=
 =?utf-8?B?R1BEbzlQaXBrMXFLcWpHYjNMclJveFJvc3RwZjQ5cDRONjNPQlk5ZVU3U1BU?=
 =?utf-8?Q?69t1v1gsBvayf+Xl2sbN4bZMr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a5ae1c0-d49e-4416-0f0c-08dcdc80daf4
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5447.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 10:08:36.9216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6fNyh3xOI9faUAQtAZwTOEN4i503DekRWH7p84DK5SUnZe3UFEFd433/dGjIowY4xqlGc66/PDcsuxbjtJ8j/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8923


On 23/09/2024 14:44, Paritosh Dixit wrote:
> The Tegra MGBE driver sometimes fails to initialize, reporting the
> following error, and as a result, it is unable to acquire an IP
> address with DHCP:
> 
>   tegra-mgbe 6800000.ethernet: timeout waiting for link to become ready
> 
> As per the recommendation from the Tegra hardware design team, fix this
> issue by:
> - clearing the PHY_RDY bit before setting the CDR_RESET bit and then
> setting PHY_RDY bit before clearing CDR_RESET bit. This ensures valid
> data is present at UPHY RX inputs before starting the CDR lock.
> - adding the required delays when bringing up the UPHY lane. Note we
> need to use delays here because there is no alternative, such as
> polling, for these cases.
> 
> Without this change we would see link failures on boot sometimes as
> often as 1 in 5 boots. With this fix we have not observed any failures
> in over 1000 boots.
> 
> Fixes: d8ca113724e7 ("net: stmmac: tegra: Add MGBE support")
> Signed-off-by: Paritosh Dixit <paritoshd@nvidia.com>
> ---
>   drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
> index 362f85136c3e..c81ae5f8fef4 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
> @@ -127,10 +127,12 @@ static int mgbe_uphy_lane_bringup_serdes_up(struct net_device *ndev, void *mgbe_
>   	value &= ~XPCS_WRAP_UPHY_RX_CONTROL_AUX_RX_IDDQ;
>   	writel(value, mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
>   
> +	ndelay(50);  // 50ns min delay needed as per HW design
>   	value = readl(mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
>   	value &= ~XPCS_WRAP_UPHY_RX_CONTROL_RX_SLEEP;
>   	writel(value, mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
>   
> +	ndelay(500);  // 500ns min delay needed as per HW design
>   	value = readl(mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
>   	value |= XPCS_WRAP_UPHY_RX_CONTROL_RX_CAL_EN;
>   	writel(value, mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
> @@ -143,22 +145,30 @@ static int mgbe_uphy_lane_bringup_serdes_up(struct net_device *ndev, void *mgbe_
>   		return err;
>   	}
>   
> +	ndelay(50);  // 50ns min delay needed as per HW design
>   	value = readl(mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
>   	value |= XPCS_WRAP_UPHY_RX_CONTROL_RX_DATA_EN;
>   	writel(value, mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
>   
>   	value = readl(mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
> -	value |= XPCS_WRAP_UPHY_RX_CONTROL_RX_CDR_RESET;
> +	value &= ~XPCS_WRAP_UPHY_RX_CONTROL_RX_PCS_PHY_RDY;
>   	writel(value, mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
>   
> +	ndelay(50);  // 50ns min delay needed as per HW design
>   	value = readl(mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
> -	value &= ~XPCS_WRAP_UPHY_RX_CONTROL_RX_CDR_RESET;
> +	value |= XPCS_WRAP_UPHY_RX_CONTROL_RX_CDR_RESET;
>   	writel(value, mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
>   
> +	ndelay(50);  // 50ns min delay needed as per HW design
>   	value = readl(mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
>   	value |= XPCS_WRAP_UPHY_RX_CONTROL_RX_PCS_PHY_RDY;
>   	writel(value, mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
>   
> +	msleep(30);  // 30ms delay needed as per HW design
> +	value = readl(mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
> +	value &= ~XPCS_WRAP_UPHY_RX_CONTROL_RX_CDR_RESET;
> +	writel(value, mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
> +
>   	err = readl_poll_timeout(mgbe->xpcs + XPCS_WRAP_IRQ_STATUS, value,
>   				 value & XPCS_WRAP_IRQ_STATUS_PCS_LINK_STS,
>   				 500, 500 * 2000);


Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon

-- 
nvpublic

