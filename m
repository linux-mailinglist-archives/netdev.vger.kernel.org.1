Return-Path: <netdev+bounces-242645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 774FBC9361B
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 02:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A42D4E0556
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 01:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C761891A9;
	Sat, 29 Nov 2025 01:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="K5EnFw59"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011032.outbound.protection.outlook.com [52.101.52.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9803D994
	for <netdev@vger.kernel.org>; Sat, 29 Nov 2025 01:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764380064; cv=fail; b=OIIAO3zVGGAF26Ejh/XHKC0sbH2sFxk4iGHjKRmU8oMA5f3vwYnpriupkSikg8Su0gpDIe8gULVqfuVl/uHYf3+XxAcwUv5QqneysIvCUUshuxxXL7pmLUxFodzOyfvJ8fYvaFg7H7dc4nR6GhiUY5p8w38pYFmys432LTcGyi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764380064; c=relaxed/simple;
	bh=Gr6B9d1P7eMsld+hfKni1UhuGqQJOe7FFUwUiYiCJEk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nAsaiW3tX1cdiA7xfCFHPENn3Zsrn+eemyYd5qyhrtAnPvbxjFxI4ZOdftqED9GHnQSvNHdisCdsMXzZbR8EoiERSpa6tolYblNbup55519c5VQ0uYGlMalS0M0IruYv/+AND9iM2B94CHGXfkDWm42vF9EkNi4e2YE/VRuHI34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=K5EnFw59; arc=fail smtp.client-ip=52.101.52.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pEmym8v1PUX5abSC4KpCKgB9rn6AVqMHj87dLPDOvZ0N/SSQcYwe3HoFs11P2N2p/zzdOX3huSRuPh7jmxj7dql0vZ/oha8SvtgQc6GFTt7WeweUug2P4xRTmz9KdqjI/rlzgGcDwKzLnTnWtmbv9LkHG+48U3fkR3FO8jkGfvAyQuzJFuvYNO6Bwkxzuo1s8GI6ETPArXeAN04eQ3s3wZRnUI4isjb0fQyITMbRShUIRl2X3TdNEO7HUtTnStruEQp5l/NvppYiFWvDBvruvgWTa1rnf5qYIHhzq9PRYYvUCccvzn0FDMPt545vihjfdimTWJ6373uPFBM4II5ZMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YJbBbeRDyxcM4F4Ixl8QLel95sVuCbcCdx+EFm7Zcmo=;
 b=h/JzyniXFRg57t3lR312V6Bmtzl88Ec5Au7IIyWBJ8DxXdVe3gNATRZxoYs/T/OwlPsigvyoEhThp/vOGBY+QS8K0DnSZp+89KRffCqDQiHMEHDfhP2UYjP1ochGHAwm8/jzBY8TGta2PLvI4aQppJgEGm0oog/N3a9zLeGQ9FuQqtJF6YdkCR+Lpm3mDBL2h2e/CbWLfVKZPS8jPsVuIJQzdV2FjL7eNWKm+KtsUiC1IF5yxvMjxOK7nHpEU0H55S9IW0lExFUIFZrDrkGvkfJEduGpnuBVJmRHFlZ7J1nTw7L1YTsYYgTku1merRUAzDkg+Ixb/HZ/VBPcRlXWRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJbBbeRDyxcM4F4Ixl8QLel95sVuCbcCdx+EFm7Zcmo=;
 b=K5EnFw59QwynswQSHiAwVAYoZYLAf8WacI5NDn+X0AgzDCo87uhT5m5LM+7Kypgxr1VCb+idfwsdweVwUl1VtUYQRFdYJlt4wGsUZKr8iFPT3vWL/wC+0yPsALwkuQGk4B6JkZRlbalQVOLd7623JTaUgF2uElIYDG/fAqcsLUM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14)
 by MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Sat, 29 Nov
 2025 01:34:19 +0000
Received: from PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421]) by PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421%5]) with mapi id 15.20.9366.009; Sat, 29 Nov 2025
 01:34:18 +0000
Message-ID: <b37d8fa8-04ba-409a-b79b-ebe3b3a76229@amd.com>
Date: Sat, 29 Nov 2025 07:04:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] amd-xgbe: schedule NAPI on Rx Buffer Unavailable
 to prevent RX stalls
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch, Shyam-sundar.S-k@amd.com
References: <20251124101111.1268731-1-Raju.Rangoju@amd.com>
 <20251126191342.6728250d@kernel.org>
 <f288dbe8-d897-4c12-a866-fd70f259ebe4@amd.com>
 <20251128103853.3e6f7996@kernel.org>
Content-Language: en-US
From: "Rangoju, Raju" <raju.rangoju@amd.com>
In-Reply-To: <20251128103853.3e6f7996@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0169.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::24) To PH7PR12MB6395.namprd12.prod.outlook.com
 (2603:10b6:510:1fd::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6395:EE_|MN0PR12MB5762:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ac97489-e6ac-4e07-4761-08de2ee76995
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?emRtTE1NVE1zQVlMdWRjUmtZWE0zUUtZZ1JBczVqbWVQWnZ6MHRlbXdTazRh?=
 =?utf-8?B?bXVoOVdjaFFqV2FaeFBhb3pxSjBEZWYwcnlDK0xZR3AzMEEwRWVwWkgwY054?=
 =?utf-8?B?SE04VUZ3d0VoNjJEOTVpdWFXV0FlRnp6cC9DNTBMTHk2KzBwMGZxWVlSK1hr?=
 =?utf-8?B?ajR1SVhrU1VzVW80dXh4M1BIR0l3bzF2dTVocDE3TnJFa3YyTDR6UG1uU1VX?=
 =?utf-8?B?ZXlKUWVkWWYvNWF6cUM2YjErN0VMNlZ6MlREWWJud0Z4UVBwajEvTlluWjI5?=
 =?utf-8?B?YmxyTTU3Y3ZjWWl5blZQeUdvTERqVFF5TWk3R2s4all4eVJXSExNYUZlMGhU?=
 =?utf-8?B?QW84UmVYZE8rZmx2WWpnUzFBaWIzM29Gb1V1aUxHZE0xWUZVMXY1cnZCalkv?=
 =?utf-8?B?aVN4RDBCbksrc0hYYnRYaytpazc1Y25ZdnVQdWhHVnQ4U1JiNkZhbFcrSi9R?=
 =?utf-8?B?aHZhQ3dLZXBaNk9JN0daN2xvTnpkZ2l4ck5XbExVL2hFMUxBSkV0MzNsSmdo?=
 =?utf-8?B?Q1g5alNEajRRb2toeVR4eW9zNDhlcHJ4OWhTOEtGTFFjK0VCVjZ2WXFQVGZa?=
 =?utf-8?B?TzhoT21uLzVHZHY1eTRVT21yWkZDaHBjNERKUGg2cW04WGNXNlEzandMeTJm?=
 =?utf-8?B?WlFQZStlYytVSlRsUDcva1VCaXdGamY2aXFpMWdlaWdHWWM5RVFPcFNRS0w3?=
 =?utf-8?B?ZXU0akx6d3pPMGlZaVlBRkMreFI5K1M5K09WTkZrSDF5QUt2ZTZWbVFYTjhv?=
 =?utf-8?B?bi9vdTdBVy92dmhrS1JpMzl5eHBXRXV2aGgvWnA2UzlrRkxtY1EyV2wzRkta?=
 =?utf-8?B?QXpRaXJlUENhN3JpcDdaL3FVSXVTL3VxWlI1OEZMR0dtVXVvQmhWaW9xUFZV?=
 =?utf-8?B?ZHREaG9FQlBmclhrZ2NYdndpNTJBa1ZTRnFHZzRTMUhKT2F3UXlINWZKTXZO?=
 =?utf-8?B?VXJsU3lZWEkrdW4rcjJhVW54TU9TeWVsUndqK1RYSTRITm4vS2c5Z3p0VVdo?=
 =?utf-8?B?MmdicUNiR3BQM0FyZktsOEhvZWlxT3dMQ0lPSnRJNGlEYVRzQjE4MSt3YU5y?=
 =?utf-8?B?dEZ1cWllS0NEeUJwTFc4b29UOUQ4R2d1M21VdGxndlJOa2liV2ZTeFU1S0tH?=
 =?utf-8?B?RjJ1UVlyL1dUOEh5SjJ1U0Mxd01QNEZKZTgzLzhqb25FeXBqQUZMUEhzK3Fy?=
 =?utf-8?B?TzRlRTVHVnFsV3BpNC91bWViOWUrcEk2QkxSOWtKSFdrcDZFeUhlQXBYN3p5?=
 =?utf-8?B?SzJJMTNKcjYrVGYzbTJsM08yVFBpLzlrNXUzVGNORVVRcVVZcTl3OWdSdm16?=
 =?utf-8?B?WC90VitDMTZCcVorYm9HTlovV2NXRzdEak11V1VCeDBydTJEdCtVMUNZYy9l?=
 =?utf-8?B?K241N3hCRmtIblBnbzY5Y051RlFjSjVvbmRMVVY3NytyRnlmMGVmZ1NDY25V?=
 =?utf-8?B?TytjNWxSNG5FN1ZQbXY1Q25jZml3aVVTcU5Od0ZDZ09hM2UvQ3VBNFFYNmJk?=
 =?utf-8?B?WTg4cmhlM2VhY0JEeXBRd0E0RWRldlRObFp5LzI3N3FIeGRGYUNyNTExYy9L?=
 =?utf-8?B?SzZRcnBjQ2oxWEF0LzkvSm1xdkJicjMxazRxZHBSenRFdlluVUlUTTJsR05N?=
 =?utf-8?B?QTMzSXdjV00wRmt6OFJ0RFpCbmdRaWY3ak55TUN0azB1N1d6YkdOR0RRZUxY?=
 =?utf-8?B?TmJ0S3loS21JOWxNQ2hKZVJRNmlrLzdEL25xZklScjlta3JQWm5wUXA1cWxU?=
 =?utf-8?B?eHltWDRxQkE2Wm84SUplU3N5SlFacHJSSU5BTjBCOWVtRUx6OVNMYUU3TjJH?=
 =?utf-8?B?RjEvQndFTWNabUl4cklQZVRSbElhK0xqKzZrbHI1YzRSMTE3R3hiVmZPeVdm?=
 =?utf-8?B?YmdiMURCL1ZyUGYzS3V0NXFZTmhIQTVUOFNVbDcxeTc5bFJwZEVVbEhMR00r?=
 =?utf-8?Q?t3O7h9IubDzX06jZiYQ8u97Qlye6htbw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6395.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aDlaenpKcEZsN1JOVjBCak5aYjR1WDBOVEVQOU9wNUhhREgwY1NNT1dNaXky?=
 =?utf-8?B?SW1UREFsdG1EUi9HbCs3KzYxUG1DdHFpM29zdVd2MkpFQWt1RXpSRTNWczJK?=
 =?utf-8?B?YzArSkhDUW1MVEk3enVSNElIcnpTNENiZEJHY1lQOGc1dkp1cnliMVVJcTA3?=
 =?utf-8?B?QzRaZ09mT3dSMUpNNTB3QkR5MllEemZYZkExQmc5V003T0FjQjhQVVc1N2xq?=
 =?utf-8?B?eVpCQkhZdmFYcVE3YmtMWGY2NDR1TWJTeUVwSWNqSXdNZ1dEOEQ4cS9lU3hX?=
 =?utf-8?B?Q2I2b3ZrK1F0NGM0Y2I4MjJLQTdTSnVMU3dMWHphd0JoK1hGUjdDeTFJMWZr?=
 =?utf-8?B?OE14cnhUWXM4WGpPRVpXdW9nZDZOY0VMakVWS0xwdWl0clVTamhhdS94OVNK?=
 =?utf-8?B?bXlES3BKZjB2L3UyaUxnS2EwaEJyWmVRUkpLV0JxY0k0cWVIMGNETmhheXVu?=
 =?utf-8?B?dlpieXQ1WmZHRzVzeVV3ck4zSjF2NGVVUXN5bnBVY3B6bWVlLzRZM3RFemhP?=
 =?utf-8?B?Ty9QSWtvZDNDQ0Y2ZFhnVEdabHFNK1c1U2FqQThiRzFhak1SWFloODM5V2cz?=
 =?utf-8?B?bittUE1YZGx1ZlkvSWx1UGF4OUptV0ZhQnRHaVU3cXFmOGFFcktIOG40bFJo?=
 =?utf-8?B?ZE1iYkgrc2pVa3pJQlkrTVQ1bXVTNys5WUVTZGErNklPS0Raa3RSZU40V0JN?=
 =?utf-8?B?T3hYUk5hM1RaVW1MT3FCUzZaUWwzSFVLei9QSHJNblJ6bmdhOGZHVlhrT3Ez?=
 =?utf-8?B?ejlDaGRsUXFQZUpKQW9yd0tBZWNTc0xOZktrSFhucExZclY0NVlVMGR1TEtN?=
 =?utf-8?B?OGhFSTBqN2tjL2xsU1FGcHRuMitNcko0UDFVNUVFMFJuT3J0WXV6TmNTcE9q?=
 =?utf-8?B?OGNjSTNEMzhwWVN2RktIMDdydDhEQTlvR3JKbllFMndPTGgybEx5SEhaTGND?=
 =?utf-8?B?MU1YZmowczU1UG9JeGxMVktMUDVaWFNpcGp2VlM0T1JmcUFTSVlucXdHUXA4?=
 =?utf-8?B?M3dROGNEa2ZiN1hocmFEOElIc0FQV3AyRUM0ZEwxSzU4YkpmMk51OFpkQ0dM?=
 =?utf-8?B?V2NYbmxJb1I4K0J2UGZ6R1lJaHNrR2VuS1NDcFJad1VnNUM5LzJsNjlPZEsr?=
 =?utf-8?B?UDZnTi94aFg5Z2FoQVBtbk54bFFjQXcrNFd6eWc4TVM4VDZ5RXFnK1hSV01V?=
 =?utf-8?B?c2plUm8yYS9GMWlybXQ4WFVBTXY2L2h6UHYvQkFRVHNGSExtUjBFbTIzbEEz?=
 =?utf-8?B?bWY0dlU1aFZSOEN5d1lFTllWWHhraU1zVm93U1Y3QkQ1SEw3MWZHc3BKQ0Rp?=
 =?utf-8?B?SUw1RHJpcjZXQmp4d0JzYk1VK1doeEtwaUNobEozMzAxMDhPZ09qOW81a1Rp?=
 =?utf-8?B?ZjhOdE9rQ0t3QTRLT3lSb1lRVmxjbHlIcFdzMHlpVWFVSkhVVGRUdzU5THlT?=
 =?utf-8?B?TFJnRkhiZlV4MHpaaHVPcU5HQVplN1hCUG43THN3SUxZa3pCMXlYWFBkNzZD?=
 =?utf-8?B?cUhxb0k5Z1VEOVcxQkJsSFdDYUhocTMrZWFOY2xDS0NyODgwcWoxTFZiODBr?=
 =?utf-8?B?V0VSWmN4Q2kxUVIvQlAxejk4U2dUZ3ZIQ1pUVG10Q0FqU3pEMWVoeTQrTUZ1?=
 =?utf-8?B?UkEyMU1Fc2U0Zll5ZUVTTWRFUnEzanJEMVdLTVl5WUF1b21lMzllaUhKWVZP?=
 =?utf-8?B?NGZ4d2czcTFoYTRQS0NTUk5DM0p4d2ZQNy94cDdzcXdVVjlwczgrbFNNNEV4?=
 =?utf-8?B?b21SQTNoVUVYb0o1eUFZVG90Q1VyS1A1NlBaUW1nb1FiSTU4LzVwY0lqMC9i?=
 =?utf-8?B?WlhSd2pjN1ZKVWQyUDh4T1YrNGdzSTg0OEx6T255N2NUQ0hxT3JCRTdBa0Fa?=
 =?utf-8?B?TVlsQ3BiNlhMTi9HL0FSVXdWYXFQVlBsQ0h2bnVPaUw0TjZwbHZBSkVud0ZS?=
 =?utf-8?B?SHZ3c2dUYit5UVNiUm5HZ3NRZFo3dWZtS2xCbW1JN2MzY202TEZOeDM0eXpL?=
 =?utf-8?B?ZlgxOFZ6UG9BMWl0VEVHZ2lmUTJ3eXB0a01taWpLZnlzdWtvejNtK3d2Ym9Z?=
 =?utf-8?B?cVRObTU2NjVWaGMvRitEU2Z4eC9zYjBlKy8xWUkvNVMxbVR5Q2g2Y3ZvRUpr?=
 =?utf-8?Q?d5OKTqxmyhhsYrxYPN0lRv2nY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac97489-e6ac-4e07-4761-08de2ee76995
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2025 01:34:18.1591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NhjwRW3fepbYw2iRrgxa0P9tVdrTO8Wq/KsOk9g3X9KVNXlnKMt6l2I6HyTCo3t63IFDY2JWaoCMCek7nsvE3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5762



On 11/29/2025 12:08 AM, Jakub Kicinski wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Fri, 28 Nov 2025 11:20:09 +0530 Rangoju, Raju wrote:
>>> On Mon, 24 Nov 2025 15:41:11 +0530 Raju Rangoju wrote:
>>>> When Rx Buffer Unavailable (RBU) interrupt is asserted, the device can
>>>> stall under load and suffer prolonged receive starvation if polling is
>>>> not initiated. Treat RBU as a wakeup source and schedule the appropriate
>>>> NAPI instance (per-channel or global) to promptly recover from buffer
>>>> shortages and refill descriptors.
>>>
>>> You need to say more.. Under heavy load network devices will routinely
>>> run out of Rx buffers, it's expected if Rx processing is slower than
>>> the network. What hw condition and scenario exactly are you describing
>>> here?
>>
>> During the bi-directional traffic device is running out of RX buffers,
>> it could be because of slower rx processing. HW notifies this via Rx
>> Buffer Unavailable (RBU) interrupt. What is being described above is
>> that, driver should treat RBU interrupt as source to trigger the NAPI
>> poll immediately, rather than waiting for regular rx interrupts to
>> process the rx buffers.
> 
> Ack, all I'm saying is that the commit message seems to be overselling
> the impact of this change. Patch is very very unlikely to make anything
> more "prompt". 99% of the time if Rx buffers are not refilled we are
> either in OOM or Rx overload, so either we won't be able to alloc the
> buffers, or NAPI is already scheduled. But of course trying to schedule
> the NAPI does seem like the more correct reaction, in case we missed an
> IRQ or such. Maybe rephrase a little.. unless there's some magic here
> im not aware of

There's no magic as such. The patch is all about trying to schedule the 
NAPI when an RBU interrupt is received. I'll rephrase the message. Thx.


