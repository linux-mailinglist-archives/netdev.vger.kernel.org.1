Return-Path: <netdev+bounces-166972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1334DA38361
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 13:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D64297A1A93
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 12:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8B321ADCE;
	Mon, 17 Feb 2025 12:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ptCWW42q"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10D12F5B;
	Mon, 17 Feb 2025 12:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739796591; cv=fail; b=HyyRjKsBsM5TtIL3JPgcOynLXtRwZER3LAChuyeeLE8eq6r24p7IPEs7zZN8/T0ze7Xbu3sorsV5Gdwfiiq1dvWluuY4cJmJTlNzl+3EUnL3ompfm2/OWp1dNiWYFDzeXS/4k0+5/62SRFtkRmTbGXXctrw1aqDmNdh+wHId6JQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739796591; c=relaxed/simple;
	bh=bJ4601kNKuCrks1I/MQVwoC30UHn7Ymc/byQysUxwNY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mGABDKapdgYBpwOWgr/2ohvm/Sfcvdcp9LzuYZksd6mZtI1JbbGvIFvakQrwhuoF0pe6nVsrFP+gjaSftoh/e9J9fpLt2oSuot6eJ/IUKPbnh2I1G5T1L4VpKT9tJ3DEXuJwwy9fWT+DRQJdQNHqjrQX12ax1L1lwa1iG4clgbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ptCWW42q; arc=fail smtp.client-ip=40.107.220.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XC1vmdl4+EBYl5TAThxzzdSjoiv1W7j7F4gx5Pj6Aes5CG2CzTLinjZSwWhAieejut1xQbP9xEIANs7UnrObv9LjXPv9DLfycfelxjebZcSM7W6+gJWpjyjleDoOORhU7V5dWELqvCpguFgytM3+glGq09CbpFLigqigaFL2X2rwKQJzoC/NBpXj4X5FM8AUKqpJXg0M6d9ILPIM/h7ipGvvMSwTHG3Y+W9weNPbnVUJEG+Qi90AlRyjvIF8G40x4luJE+c1xyoxK8zdPieVP7moDosXKqjs412oJf55qM3VqElu/6H7tZj80CuT1i5QIwNb5nTw++b723KpA+5nEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yoow0e2r8yM/kyyzmz5taKOuK8D9yA0nFVW1qCfekYg=;
 b=XRuCXlc41yewUC9S8D/Fi1EwJwYWQKeshyi2ydl4laX89HIX8AUvw+4AbGzqop9vhHi9XWjkuqEexI+IY4qLrvkr/Sn3reAOgPKcZCKJ293EY+qUkf9KM3JJOPyllHUkEwApyqHEk00ZGzel4TSMXAsufymRfWCJhqeQzEeNlL284680ONyzh4dAzAgw0fieqWANkQBMRWDflrV3rBOXBPsGt5s/qFvF/L7wfk++IpNBixPaJ/vGI+8x5dKJ5hfkYUb6yD9waP51o8I3/SpxnnhdEjvQHdayiknyBNFME5DZpRwJiKoFiDBGoa4wkTew7vzuN2xrGnM4/6ULNLBbmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yoow0e2r8yM/kyyzmz5taKOuK8D9yA0nFVW1qCfekYg=;
 b=ptCWW42qI7+Mjf97DJRcxOaBI8i+E79+BvDou/20dZMyqHA2KXMVuzCltGrmvcoUPYiRa1UOoTiNWkBI2zCASThSuCBD1Gno5yVB3Hmlz5UustJcWhkhxztqOpwzhJwuop9baDYCy7H2R/MKRFfFMr2XOlCumfCEgTTg984hTaE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SN7PR12MB7106.namprd12.prod.outlook.com (2603:10b6:806:2a1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 12:49:47 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 12:49:47 +0000
Message-ID: <e5971f28-8c94-44f7-a3ce-b3198a1591fb@amd.com>
Date: Mon, 17 Feb 2025 12:49:42 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 01/26] cxl: make memdev creation type agnostic
Content-Language: en-US
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20250205151950.25268-1-alucerop@amd.com>
 <20250205151950.25268-2-alucerop@amd.com>
 <Z61tsoz3_MGrjvjG@aschofie-mobl2.lan>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <Z61tsoz3_MGrjvjG@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0027.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::19) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SN7PR12MB7106:EE_
X-MS-Office365-Filtering-Correlation-Id: ab5f7f7f-bfae-4c20-d856-08dd4f518f52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZzhGTWZpcm8wK3lnRWVhcTNYQkVFZHNTQUF3L0hVYWZOay92ei9vWDZTSVZC?=
 =?utf-8?B?dmhYa2JTZVBXSy82NFBKeEg5Q2l1S0E2ODNlWjdHQTB3bzR0YUZVeGp4eWhX?=
 =?utf-8?B?NTdzMUFZeXNqb0N3SDQ1a1p5Z21FNUJGYnZOeGY3cjEwVFR0VUxQU1VQeUZV?=
 =?utf-8?B?eFZtWG4vaDNtbkdvaEJSeUZkZm1qc2RHbXRPNHBrZHorOUJIQitoVmdXU3Y2?=
 =?utf-8?B?V21UZWR0UlQ4V0E5R0VRMTYwRDlpUW0wZlR0NzI3Ujh3Z3hNYnhmSjUvSGcr?=
 =?utf-8?B?OGtPTUMva2VCRHliQmdTMVc5WHlqU1QvbjhsN1kvaDQvVFZNTGprbnp2MWkx?=
 =?utf-8?B?NHY1WGx4eVRaRmVXYjRhYk1Nck1xREtmeEtEZ0ZiWWlwMDdWOTI0OWszby9o?=
 =?utf-8?B?ME56VjdDekgvYk1vZ3Ztalo5RWZ2ZEF6QVRUNDN0S1M0THltc3FEYTlJZVR5?=
 =?utf-8?B?cThlR1hEQXExenNKQUFXOUlERDQ1RnlpU1ZCeGVrcXFSd2N5aWdDWEwycnp0?=
 =?utf-8?B?OGZ1SERmaU1uN0pUMWxJTHJRWEM1eE4wL3NmbjJGbEVTb3BUUFp5STRuKzd5?=
 =?utf-8?B?a09Fa0V4Vk1oLy83djhELzFjT2hVYWlrREMrT0wwaEhUdENzTlEyKy9oT25q?=
 =?utf-8?B?eGNmU2ZGQUNKRzY0N3AxdDVvYUNobG1iOVhNNTJXNVIxZi9LdjhPU0EwWGxS?=
 =?utf-8?B?RTZXNDFQWldVNXNDREdjaGtSZk1KVEF5RmpnMXB0RkYvVmp1blRVMUFIZU53?=
 =?utf-8?B?bUFPaUlzV2JwOU5PVVJuYXFGU3ZjcHplc2ZLVWxBMmtnQlg4QTRzbnEwRG5y?=
 =?utf-8?B?Ym5zR01GT1BibmNQNmhFVHlFcTBmR3ZuM1NKZ0M1SENXQzhFaWhsOE01SHBl?=
 =?utf-8?B?QUtsYldwQTd1cGFlemtaYkNDdnQ4QndNcWpOZk9semdwN3VabkhXMWYzV2ZN?=
 =?utf-8?B?RkErSjdQUjBXVCtkdmpMZHZ5ckVZajVlMjRlRmEvT0IzVS9tYmljV1RHZnBO?=
 =?utf-8?B?MkJQaXkxTkgrYXJhNFR4aythWVVCbEVKbXBpUjV1dUIzNy9DUnJ4N2kzVFA0?=
 =?utf-8?B?QmFWNW1jMmlEMWpxYjlTMElXSXJJTnFISTlJeThCSjJGV2Q4TjNvemlFakNw?=
 =?utf-8?B?QnFzYkNncUFWODVaalRvbmlqS0lVVGd4Rk9sdUd5cmZwalhmd1h1dWFLSkxw?=
 =?utf-8?B?T1lQVG9pMTRNVDVXU0ozTUo5NldaOGdnZFBvY1dYUzBFdE00dWViRDhRVXdW?=
 =?utf-8?B?VXlWOEZjL0Q5cGoxRTdRR2owK1VsUjNiR3VVVnBvMWNpYWc2MS94em0wT2l5?=
 =?utf-8?B?dk9nNzhzdHlUTXVqamhHYTZ6TksvL3dGcFBHUHpzVFBkVkpSWVRnZnhGcHZQ?=
 =?utf-8?B?dVJVZElFVDcvNFA3MWQrN2cwb2lud0FwMGw4NzBsTDZaSGJ6UWZ0bkRZbFdY?=
 =?utf-8?B?Zm1jazR3WEExUWpKNWpRd0RQNHBzNWtOYkp5WFRsTDdMbm1OTVR5anI4Sitj?=
 =?utf-8?B?VitxUTFhVW1ablhEWVkvelYrUVl6WTJuOWhlMkRSb0tsNDVWUzgyTzBWb0JQ?=
 =?utf-8?B?Z2xPT1d2NDFzaFlObmpPNkxxNWkwalJlUW03U1BUalpmVlgyS2JqLys3eG9X?=
 =?utf-8?B?TXVtNU90Qlo4QmtGS1NLdC9SQzZqNXFlQ1NIVDFQVVhVNmJmN1pOZU96Mzdm?=
 =?utf-8?B?RndaWFQ2WTIxTVhGTE1WdHdxVmNoWGNWMUdYV0oySkdmdHl4Q2FTRGtsMHQ5?=
 =?utf-8?B?c1JlcExvVU80TXNKRUxOVG00L2ZnMkZPaHVtYnNTU3Z1UVlNTDk5NzJzU1hW?=
 =?utf-8?B?NjBkN0dYT3dkSS9aanI5SzhicVBPWURWZzJlellQcVJIMlQ3aGVtVkRMeHZz?=
 =?utf-8?Q?5Ghi3rkVmVqrv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3R0SXFtbnY5TUpmcU1RT2Fua2luK0VJRVY1dnVnNzVsQkFFSEJDd0w3SXlK?=
 =?utf-8?B?MXkrLzBuc21NTkFHUVhzZnEvOGhDMk40dmxJQ0hRZ1JPNWJTSURVWUpFUlZz?=
 =?utf-8?B?OGpLQTVpWTNIZjFqZHRNblcwR25tMnpSNHp5M1ErNlhjTGNidFpWRjN0MHRQ?=
 =?utf-8?B?a0ZuUHd6WlhJVUxJdXJDMERmRWZpUTU3QXdFS2FlM1FNQmpjdy80VGN4RzRZ?=
 =?utf-8?B?dVhINys3U1pMWmxxQ1FOTVhNTk1vYmhKbG9VeXAzYVF4OEN4WE5JV1lGb3JL?=
 =?utf-8?B?cW1iRThuK09jcmdqbE5Obmw2dm10Sm42Qm85NVMrcFVWcTFNTnpjNTN6NHZZ?=
 =?utf-8?B?aldXUCsxS2JCdGxjNk5FUjhxeDUzS0orL3dHZ2twWXI4ZW1hYUVMZUNEWFJQ?=
 =?utf-8?B?T1MxaWh0bTF3OFpud3lseVJyOGgxK1dIQy9qeEZUQXpGR1cyKzlmSmtkTVpi?=
 =?utf-8?B?MkIwVHg4RGU5VEVhRkZkL1FkQ3E3cDgyZXNrWWtDSUlHcnpCZHEra2xzQVVJ?=
 =?utf-8?B?dW5yOXNnY3dkSnMxMFg3Q3JXWG9HcjYzUDAyMS9XMFVBMVlFcGVzQjVmbGZX?=
 =?utf-8?B?MTNuaEZ3c1FFa2UrK2I1L25acVA5VjBxajNkZ1gwNFptUFpMOCtrWDNaMTBH?=
 =?utf-8?B?cFhRYWpkYU9QUk9WYnBGdzVnNUQ1Z21rWXRpZUxoN0tZVGtlYlRDaHErTVRU?=
 =?utf-8?B?K3g4aC9vN05VSlhMNW1mbS9BbTRENVJHVThwbUZCYmRlNTVyZk8vT2M4RURV?=
 =?utf-8?B?Y2RrcFE4Y2RkMkcvbE5WZ01oT09UQlpwNCtuSU1XKzIwOVg2ZWY4UXliVFBR?=
 =?utf-8?B?Ylk0cTV3TjY3eGV2Y2U4UmtPd0lnakw2cTFvdTVRS2xZaGxOSlhPUERpRk9E?=
 =?utf-8?B?N0xJVm1ORXlMbm1RZWhzMkdDLzRnYlh1WUJFNWpIYUg4cXlveGhWWXdKRFdx?=
 =?utf-8?B?RjIwdk1BOEJpek1WLzlxK0RhdTE2cU5Ja0kxK3VaVk1BV3ZISUtlWUJXVy9C?=
 =?utf-8?B?UXp4T0NMYzI0SE5ESi9wd0x6bHYwdks5Tnd5RldrZTlmS1RMK29tOXIxZ2xt?=
 =?utf-8?B?OGlaWEZ4d1FVOEcxSzc1TlZmcjM0VFNPMFdrWVF6eDZ3Wk9jZmREYzZ6c3li?=
 =?utf-8?B?SUJQTlcyQ1h4dDdvamp4bUM1NDBuYkIrcGhOVUV6SDdYOGoySXg4RUlYZi9C?=
 =?utf-8?B?Um52SWl1dnRSSTJLOWhYUWxKRndaUTZWTDlrMkR0dnFxcGxQRmEyajBjL2pN?=
 =?utf-8?B?blYvNDJDM2F5Q3l1aFJmVnloN3NRSytBbDJIWnZ1WEQ3OXQ3b0t4c0xzbkI1?=
 =?utf-8?B?a3lMUVZiRWk0M2lFaVgzR0FiMWljbE9relc1dDJhR1NzTXlLa3BqSnJCb2Nh?=
 =?utf-8?B?blA3SCtCWDRHVlNyMGRkdGZlZkNTemhjYWZpSUVteSt3aGlQaTNtNm1qV1hM?=
 =?utf-8?B?RDJNc2luaHFnSHBIMlpSNlZQTitCdXNDS1BmU0hsLy9qMVBvTFlNazg3ajV3?=
 =?utf-8?B?VEEzQWFRbFpxd3h5ckZrVmloYks2VjY3WXF5NmJiYUhtVzFtU3FwQVBtUE42?=
 =?utf-8?B?Q3dENnNTaTE1bXY3UkVVNHljT0hPSy9aWFp6ZDdtV1craHhBS3kyNStjeVp6?=
 =?utf-8?B?UXhSRGNyZ3RxN0tNZllPSzB5TURyS2tBRVlEbnhrc1pVeVRZc1VkdlNUZWJF?=
 =?utf-8?B?bWkzWndRRnBxeWVmZXpsbzZCUmZNOGZJTy8wcW50K0pFa2JYdENSNkdjemZ5?=
 =?utf-8?B?QzJEQVJubHFPWTJLNjV5UFBHcHJNdk5MUThHS1F2WlFYeEZVR3gxQm4vcWZZ?=
 =?utf-8?B?TWs4bHlxVDhHa1g2aG9PQnlxdzRqaURRMDZVOEtUZm85V3prN1lWKzZ4OFBN?=
 =?utf-8?B?SHU4MXFZSFBscXI1YUVSY3owUGdUaEk1cG5Ed3JhSXhMOCtyZHZQVEd2NEZp?=
 =?utf-8?B?M3YxTSszSzZRcUZ0QUorcTJzUXhId0lDUkUvREM5TERUR2J2MTdnRVJHUUxM?=
 =?utf-8?B?c0R3VTZsaVlDZGJUc1VsM2lUZ3ZBRDJCREN1ZGRHQ2JobzlpVlJSQTIrQ3Iv?=
 =?utf-8?B?T2EvY3RpdHg4cVJyZzZSZWVnRDFqbGN1VG9GQ0lXS1liZ1pUZjhwYlB5Y21q?=
 =?utf-8?Q?6kmZVIn3IxzzkSrdU/m6cCDjR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab5f7f7f-bfae-4c20-d856-08dd4f518f52
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 12:49:47.4231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iKemsOljCy8+aIN9CbRgOyaVcQ0LsniPwk9F6rFEDYKFEhX+dKSAa2cp3miKX8iL8+Ns0BFsGIr5vvBvaesLiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7106


On 2/13/25 03:57, Alison Schofield wrote:
> On Wed, Feb 05, 2025 at 03:19:25PM +0000, alucerop@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> In preparation for Type2 support, change memdev creation making
>> type based on argument.
>>
>> Integrate initialization of dvsec and serial fields in the related
>> cxl_dev_state within same function creating the memdev.
>>
>> Move the code from mbox file to memdev file.
>>
>> Add new header files with type2 required definitions for memdev
>> state creation.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/mbox.c   | 20 --------------------
>>   drivers/cxl/core/memdev.c | 23 +++++++++++++++++++++++
>>   drivers/cxl/cxlmem.h      | 18 +++---------------
>>   drivers/cxl/cxlpci.h      | 17 +----------------
>>   drivers/cxl/pci.c         | 16 +++++++++-------
>>   include/cxl/cxl.h         | 26 ++++++++++++++++++++++++++
>>   include/cxl/pci.h         | 23 +++++++++++++++++++++++
>>   7 files changed, 85 insertions(+), 58 deletions(-)
>>   create mode 100644 include/cxl/cxl.h
>>   create mode 100644 include/cxl/pci.h
>>
>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>> index 4d22bb731177..96155b8af535 100644
>> --- a/drivers/cxl/core/mbox.c
>> +++ b/drivers/cxl/core/mbox.c
>> @@ -1435,26 +1435,6 @@ int cxl_mailbox_init(struct cxl_mailbox *cxl_mbox, struct device *host)
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_mailbox_init, "CXL");
>>   
>> -struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
>> -{
>> -	struct cxl_memdev_state *mds;
>> -
>> -	mds = devm_kzalloc(dev, sizeof(*mds), GFP_KERNEL);
>> -	if (!mds) {
>> -		dev_err(dev, "No memory available\n");
>> -		return ERR_PTR(-ENOMEM);
>> -	}
>> -
>> -	mutex_init(&mds->event.log_lock);
>> -	mds->cxlds.dev = dev;
>> -	mds->cxlds.reg_map.host = dev;
>> -	mds->cxlds.reg_map.resource = CXL_RESOURCE_NONE;
>> -	mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
>> -
>> -	return mds;
>> -}
>> -EXPORT_SYMBOL_NS_GPL(cxl_memdev_state_create, "CXL");
>> -
>>   void __init cxl_mbox_init(void)
>>   {
>>   	struct dentry *mbox_debugfs;
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index 63c6c681125d..456d505f1bc8 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> @@ -632,6 +632,29 @@ static void detach_memdev(struct work_struct *work)
>>   
>>   static struct lock_class_key cxl_memdev_key;
>>   
>> +struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
>> +						 u16 dvsec, enum cxl_devtype type)
>> +{
>> +	struct cxl_memdev_state *mds;
>> +
>> +	mds = devm_kzalloc(dev, sizeof(*mds), GFP_KERNEL);
>> +	if (!mds) {
>> +		dev_err(dev, "No memory available\n");
>> +		return ERR_PTR(-ENOMEM);
>> +	}
> I know you are only the 'mover' of the above code, but can
> you drop the dev_err message. OOM messages from the core are
> typically enough.
>
>

Sure. I'll do so.



