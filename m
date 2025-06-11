Return-Path: <netdev+bounces-196503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9ABAD509D
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 11:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4436F3A7BC6
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 09:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A7C2AD2C;
	Wed, 11 Jun 2025 09:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="F43anofT"
X-Original-To: netdev@vger.kernel.org
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010008.outbound.protection.outlook.com [52.103.68.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45602609C6;
	Wed, 11 Jun 2025 09:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749635650; cv=fail; b=fRMIN5e56u1bFBSEUbJ6RI/HxyT3hFy8LT3tMniGT5cgcyyNkJRUeTdPrLLqWjNbUpnUSn972F9K4TUPxb2aLj0zWHUGw+cq1iBXbEyjpItCaMLQ39Ocur64ytd0zslBO7bGe3rLHjdbVHV94vvao5z0pSMdl8Hrwna8lpOgB0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749635650; c=relaxed/simple;
	bh=KiBUrs1/VCxq8ZNGp5OIt53fyKePPpWJWdwuRvvu8EU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QKbt4tECygydBzxkf0n2QQjkXAEUjWq93zEhvh5RJ9Xgy4XsmqMXnISkg0tWZSX55nmuMutLG/ZSGDQ/M//hfSxoOFgUvJjyJIbFvEuw3kYqT2Aom8Jnx6OlFeW27zWWf0Mw1to3aqW9VJyiSdT2ecld5brDGlCkXPEcmfovEVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=F43anofT; arc=fail smtp.client-ip=52.103.68.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lTGxgZYzwH1neMM2YB+0BAMcmleZX8OTZyrmHHeJJUMQw1kIqx/absS/8w4MNnVjnQ7Q8b+VR7eejXY9/1zoLIEb64kkrPAtcrXgzNbEMg7vttcj1i64NuUJ1AaW4rVmu8APbqvc0ee8HALRUESWHwEhUn/QiLGRJdrplMLd2aMb2VGzL9dvHUaM/9I10qf/C92ujmUAGADQc9kzBTuFS2YerwgyAt9E6iq7FgOYvg5PqL0+IjMfqq49OKLGzYtBOqH7RZx8ce+0OVnuFHPfqgnp3lx21guyaGrAIU7EYFwQaBUxcSy9vrr7OqP8abfrfokNMpSmUSK6mpQ6ifYj/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySZYBIjpGAQdtRc2xZ4ebPQMnX2efCp8IBjwigWG5mY=;
 b=NxWZeCek/CwCjHIkLUZtqOxRF6xbswsFkxbl3mjis7nd3O0+wsY7K46yEU1wuB2MXcfSBpAHpzHotg6gTW458MJd9ZgTus5DECcfG4PH3ErNHTY/jTc8PomQ+L4+LGFlcuj9424roxzLCm6tY27cOR85fxS3liVgaB+sNCX9U0omccp60clXLegEuTPelvVz7nzNdyss4rA4LdyaWMhP6sVCPaj2ef9pVWhaKfkwaErc69i4jUipydnW69aWR0QoFQfSjWnm8Evb7rF+zSha5ArCEA8JlMvUBZaxo4fMK89SvaIH6LYDsObxPCjFcfZbcgI99raKpfS3C6EQbWLGtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySZYBIjpGAQdtRc2xZ4ebPQMnX2efCp8IBjwigWG5mY=;
 b=F43anofThBmwjIuSXM4z+HC2Ycbs4YOmgblnuglaV/jXGiA25WA3OY3aZsRGkp8YySYf6P1dNiIkGhWh02dV8zI13bPe0pb5vYhAa532XwUXTlMRUy/NDCfsqntyOMnLfPckY8Bs6d0H25OXxn0mPdu3tjitkTp+UiTO5AtVrgxa20PDFuopnEXGfl/k/Rque/LN8nsIr+GSl+qFiSfWpDDj8oBEARJV1VAaX7FT4+cyu0YKslCdKhjdsWiadhKgpLETj0ZnZRPcCIvVOeMgrhrQ1V088VAKvqmSVmEH5ve6Eda0yXPZsZ3DXK5qKlPK2D5X+pB7Kee9SItvcamAcQ==
Received: from PN0P287MB2258.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1c0::8)
 by PNYP287MB4069.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:287::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Wed, 11 Jun
 2025 09:54:01 +0000
Received: from PN0P287MB2258.INDP287.PROD.OUTLOOK.COM
 ([fe80::b63f:e256:4db1:2e9f]) by PN0P287MB2258.INDP287.PROD.OUTLOOK.COM
 ([fe80::b63f:e256:4db1:2e9f%6]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 09:54:00 +0000
Message-ID:
 <PN0P287MB2258F2BB409F70955D6EE248FE75A@PN0P287MB2258.INDP287.PROD.OUTLOOK.COM>
Date: Wed, 11 Jun 2025 17:53:54 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] riscv: dts: sophgo: add pwm controller for SG2044
To: Inochi Amaoto <inochiama@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Richard Cochran <richardcochran@gmail.com>,
 Longbin Li <looong.bin@gmail.com>
Cc: Han Gao <rabenda.cn@gmail.com>, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org, sophgo@lists.linux.dev,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Yixun Lan <dlan@gentoo.org>
References: <20250608232836.784737-1-inochiama@gmail.com>
 <20250608232836.784737-12-inochiama@gmail.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20250608232836.784737-12-inochiama@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0184.apcprd04.prod.outlook.com
 (2603:1096:4:14::22) To PN0P287MB2258.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:1c0::8)
X-Microsoft-Original-Message-ID:
 <39096efa-a3e2-4d31-a7e4-43a13484a137@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0P287MB2258:EE_|PNYP287MB4069:EE_
X-MS-Office365-Filtering-Correlation-Id: c013136d-04c7-4a3d-c819-08dda8cde40d
X-MS-Exchange-SLBlob-MailProps:
	Cq7lScuPrnqTDjd4Fy0PN0HVJKAgc5hFtHC/ptq2/B1XzN9fSXJqzO+4xixLBbK9OujE8EFb88Bb4VOczjSF+kYkcsSLkGe36HzeiV3AWkpPj4nMOHLtze9lG8BndpEkKRWGc9pASS++baLHOpG+Q0mN3w0d6XC+cN8c2beruMelrnngkEMdsui77lzpYBNUT2WGeBqyEIKke6rrLQTM9BatnAKg0AFhDhP17Wpzwpn1gZBlym7KSEd0t+xx+2mj56sZBrZWfBAMj9FlkYkym5rBSOcIyk7fobt+5FNyZBYympPnbzl3KDxhoRrJswpiHcdoitOqwALFl9Aa/xvhcJNlsAoEisJbnmzFBHEzEWGHbhYaQYRvkcBDwHXeAdTHCsbdA1YKsjUmBhN7iMKm0aZS4mPI+6vK8/tKZJ4Z1D75GgPRTIAVm+zwE2dQu3RatxQO8YLS0Qf2bWdvIF9mDCT1RF6brzAJCD4eQdmt7HWjfG6/RrnJI2HE39bIYEsL5teFo5r+WF4ef37kOA+FzfB4vypDueiCY1hfUMZMQu+dd5Lox8xsarvSzCDp0w54X3EumUmse25Lrsd+XIFIshIjlgZ8fbzkUiYeCwfmTxa+oDvNqLoip87dkKcy4SRfXAjE8IwlHEeEjJjn51Ym1aT0qhMF9IYNo0Mh59CNLaRy6EqF3GIWykdR829645uX5n8x4QABGymZRNEidvgsu2gLaUfJYCro1+iamw+fuglQhpZNhJZEn3Srnu9DJvHTlz/7P2i7/j0=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|461199028|19110799006|7092599006|8060799009|5072599009|15080799009|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NE0vVE5KMzVHZTQyZWMvV0tkemp0alE1SW9jRFNjcnlVSlUzWGFBZkQ3RDJr?=
 =?utf-8?B?NjhkNEkvMHZudE5IaHZERjVzMUZjQ0JhZCtHajF4QlBTclRvRG9FSnZHWEpU?=
 =?utf-8?B?S01SQ2hmRHRUQUpycmd2b0JwWFFsdU1aQ2ViNndnS0pOMm91ZGd1MnU1dzhP?=
 =?utf-8?B?MW43S1pnMXdKS2IvTE5ldTlYdTc5VGR4aWluVzhuWmxCSGJreTJBZzBrTTBP?=
 =?utf-8?B?VVYyMzdBc1lDbk9EQ0EvdllxaGFpakI2bjJ0ZlNscndxZFhraXZSVnNVK0pj?=
 =?utf-8?B?TW80VlRWeEJUYjlmY3FSb1JoOU1XWUlpZFE4a05SZjBzcXR4bFRaZ3VPRG1E?=
 =?utf-8?B?TS9JOC92VFlkOXdQQ2ZXSkhseXZFZk8ybUhoeEJlM0svRDAvYko2bDg1aHlx?=
 =?utf-8?B?SHd0eHlKSmUrUEFmTmgyeEFoMUJIMzJ4L2U4MFRCZ3N5VTFNbnBQdHBsSnhr?=
 =?utf-8?B?azczWnlXVFd0VkhBMEZqeTdPV3IwemxIa1AyMGlwbWdnSHlaWnJYLzlKRmFz?=
 =?utf-8?B?WGhFakNWdms0VE45cDJ2eDJyOTM1bDNtbzNWMU5nRFNZSVorVlJZdkxTNTRm?=
 =?utf-8?B?V3crWXdNeWM2Z01kM1lrYXI5Q2Q4MDJST3ZaV0o4UHVhd3A5Qkk4K2c4WDE2?=
 =?utf-8?B?TmVSN0gyZ3NoNUdad0YvdFI1R0d5VkhNdGV4VTZyd1ZPMkc1RW9NZW9vM1or?=
 =?utf-8?B?NWE5Qmd3bWZEbERkVzBLcWRXeTdQaW5zNWNEZHdqa1VjTUZWV041emVoTGZT?=
 =?utf-8?B?dXpsNFR6Zk5Rcjl6TkxsZzFQdWZLajU0WncxK0JkdDA3SzdzaW5TbFdyZ3pT?=
 =?utf-8?B?Z3d2VnVEOXMxSGZhemIyQ3N1SGtJdmxlLy9paEM5dWJ2WFBpbVgxYjEwMTZU?=
 =?utf-8?B?QVhReUtKd2pZRTZKK1VYOXMrblNsWmsyR3psRGRmNWlQbHBCU05mRTBpc1lx?=
 =?utf-8?B?NmZWRE9tSW9rOURNUVpYMGhnUHFyd0YwblFCMDZUbzR4WjRxNmVlVGpOa21B?=
 =?utf-8?B?bWhwS292NGhiNTdaUW41L2RrVzZ1QjVzQlltUVk1bDFjK2NPajduS0hCQUQr?=
 =?utf-8?B?a0N3S1VnejNadFFjaklPOU5idldpL1BSR0dncWQzeGYxcGVaZGFrR1dUNkZx?=
 =?utf-8?B?a0RYTlZ3dHNUZnNHWWx2bXZnbFVpVTJDK3FuZS91akpzWUo0WlNKeFpLaDB2?=
 =?utf-8?B?enlrUDRYYVV3ckZOdG8rVWJ2cjMvM2tZMS9ZZVBuV0MwTkU4d2tBdi85NTNM?=
 =?utf-8?B?MnV3K0JYMXl1YlRXeEpYWnJWbGlGM3B2a3E4RUlyTElYbFVGQWJFTU1IRkJQ?=
 =?utf-8?B?SW1TbkhWaUhyYUtwN0RWWnJnKzRTcnY2eWo4NnhZVmc1V016Wms0T2wrU0Fp?=
 =?utf-8?B?b0pGTHRkRGZrNDlaMXpGNkxPL3JVRnVJY1lBcTRMZmZOZlRleHJTaVlzanVT?=
 =?utf-8?B?bDU0VmhLbVlib1REaXdtcGlQalNaeXF0UFZmRWRvdzZIMFZob3RjOHRXMFBv?=
 =?utf-8?B?eUxDeStuV2hrTEtXYU5nbEFWbjBadjl2WnFFYUVpUytITXNEbnR6RUM3YWZq?=
 =?utf-8?B?ODlhZz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L1MzdjBSQTh2SStFRzVQRmxrNmlQZ29lRi91bUdpNFRjb1FmbFpienhsUUV5?=
 =?utf-8?B?WS9iSHJsYlQ4ajllRXkrc1YwOCs4dXpYMmxmNlBxN1ZzM0Q5bVRoeVU2OC9L?=
 =?utf-8?B?RW5QcGpFUFI5N21xem9ieUgrbnVZUXgrWmtJazVNM05wVHFydFVPSTVjM215?=
 =?utf-8?B?UmhHVFFnYlMyNVlLMGxLNDdmc1pYTUcrQ0t1V3YveHhwbk5sWFJOTXEzTFU2?=
 =?utf-8?B?eGErMllVZG54WWc3cmw3WlVna1Z0MTRFUlh6dVNoQWx1YTBzK0d1cmRTT0xY?=
 =?utf-8?B?TW9pUDh3RC9wbDJFMmdkYmxRdm5sbHZ1WStUNURwSUpoNG9aS2VMRHd4NWJC?=
 =?utf-8?B?cnkzaUs4QTlxc2JRcEhPcmxHUFB2WFp5djMxdHBYTk92ci9TZ2RwRmRmZjkr?=
 =?utf-8?B?SWdlZ0piWWNKZ1BqZ2tXMm0zUUVnWllkRmR3anFIclhSNkl1SHVpVE45NjlX?=
 =?utf-8?B?a1hwM3pFK2pUUVY1MkZxQy8zYTJjV1dyS05lZVpETXMvTnFLVUpIcHZpVG1I?=
 =?utf-8?B?cWZDdWZjbHRDWHBYNVoxUUxBMWFGU2FrTE1mSnNFTjFMM1ByYjFDeFlxVVpu?=
 =?utf-8?B?OUJ5Z1d1VG1oWm1TaEdnVk9wa1h6cTVhemNQbjBSRnM2TmREQ3pJZzZLY0pn?=
 =?utf-8?B?bWI2RmFnOGNQZkowMCtFQjJaNXhaQmtIaXgxQWxYWFk5a3o1MllVYUNCd09P?=
 =?utf-8?B?VWtjMGZ0QVkwd3JGbWdpcVpBYndhZXNqZmpKMTMybEtZVkh4SStCM0RueS9n?=
 =?utf-8?B?Z1ZDWGExSlQxb3FIZi9QSlRlSTBOTDE0bDZrb2hxWGR6RzcvUEd2RFNhZXln?=
 =?utf-8?B?SE9BRXA0MHNIWjBmV1l3MTNVVTRnSWhSVnY1L21iMHZtTi93TDNNQzI1ZEJx?=
 =?utf-8?B?ZDBJdk0rOG0reEJPS3VKQjJSTDBmYUlqcm5zcmo5eFFmQjREQTBzZVR1WlBU?=
 =?utf-8?B?MWFhZzJsc1NJYy9PdjJPdGtsY0V6T3B4VStnbVZjQXdoR3JRb1lLQ2pYWC9y?=
 =?utf-8?B?SWk3eXU1M1RZeFVnQVR0WTJjek1iZFJkSXA1dzRqelc1bEczcE5qQTZmM1Nj?=
 =?utf-8?B?V2pHa0YxL0NDbG9SbDFEZkdjZVVIMis2eEVka0ZSL21TSFhoVjdHZ1MvQjRn?=
 =?utf-8?B?QmtuSXBHbEFHc0lPS2krVU9zdHE1TEg2a25qNFIxdWFnN2JZa3prOFZodFF5?=
 =?utf-8?B?cGJnZ2c5OUhiVVQ0L1FJdGlYTUNTQ1FISXFPVkJlUm5OMjVoQ0s0RDNwRHZk?=
 =?utf-8?B?Ly9mQndsQkNJZVlaWmtlM201ZVRJY29kaXlITElGYS9OZVd4MU5JQ1lyOWJE?=
 =?utf-8?B?aHpjWjkxK1VOV2dnMG1QaHkyai9DcWN0VmhTbjdEMW45RkR2TGNQQmhnL2l1?=
 =?utf-8?B?VmxERGx3MGc5VFVRenY2WGc3TmJTQnBMdzZRVi92OFg1ejVNcDZ5TWlkQXp3?=
 =?utf-8?B?NWVNYzNHbFZCN3JGZDRJeTYvdmhWRU9DcVNaRnBrQ2lPOFRDWnVzd2FwTVlj?=
 =?utf-8?B?VUNZM2FTN0lNdFVVL1ZUK2g2YjVyVmpNYXlCQnBrU0NHaWovUWEzWFRiOWRu?=
 =?utf-8?B?RGVSZmFiaDhBS3N3a0tjbnRvVE82K2pMV1p1NGZJNit3VjhtZFZ5OTFGa2pZ?=
 =?utf-8?B?WTdleEVZYlUrQUdtRlV4bFRHM0VMejh1b3l2ZDg5R2JRQzV4YjFZaHhxQkRI?=
 =?utf-8?B?Z21TeVB0U0w4TkhMekNqdjliZ0JHWVdDOEEzZGJoYnR2K0NFK2RsSjE3VHpR?=
 =?utf-8?Q?RSE8uBFSHhOzCmIzPF4Etpk7L6njiZqwLXvU13S?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c013136d-04c7-4a3d-c819-08dda8cde40d
X-MS-Exchange-CrossTenant-AuthSource: PN0P287MB2258.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 09:54:00.7195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNYP287MB4069

"sophgo,sg2044-pwm" should have not been in 6.16, submit this after that?

Others. LGTM.

Reviewed-by: Chen Wang <unicorn_wang@outlook.com>

Thanks

On 2025/6/9 7:28, Inochi Amaoto wrote:
> From: Longbin Li <looong.bin@gmail.com>
>
> Add pwm device node for SG2044.
>
> Signed-off-by: Longbin Li <looong.bin@gmail.com>
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
>   arch/riscv/boot/dts/sophgo/sg2044-sophgo-srd3-10.dts |  4 ++++
>   arch/riscv/boot/dts/sophgo/sg2044.dtsi               | 10 ++++++++++
>   2 files changed, 14 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/sophgo/sg2044-sophgo-srd3-10.dts b/arch/riscv/boot/dts/sophgo/sg2044-sophgo-srd3-10.dts
> index 01340f21848f..b50c3a872d8b 100644
> --- a/arch/riscv/boot/dts/sophgo/sg2044-sophgo-srd3-10.dts
> +++ b/arch/riscv/boot/dts/sophgo/sg2044-sophgo-srd3-10.dts
> @@ -63,6 +63,10 @@ mcu: syscon@17 {
>   	};
>   };
>   
> +&pwm {
> +	status = "okay";
> +};
> +
>   &sd {
>   	bus-width = <4>;
>   	no-sdio;
> diff --git a/arch/riscv/boot/dts/sophgo/sg2044.dtsi b/arch/riscv/boot/dts/sophgo/sg2044.dtsi
> index b65e491deb8f..f88cabe75790 100644
> --- a/arch/riscv/boot/dts/sophgo/sg2044.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/sg2044.dtsi
> @@ -347,6 +347,16 @@ portc: gpio-controller@0 {
>   			};
>   		};
>   
> +		pwm: pwm@704000c000 {
> +			compatible = "sophgo,sg2044-pwm";
> +			reg = <0x70 0x4000c000 0x0 0x1000>;
> +			#pwm-cells = <3>;
> +			clocks = <&clk CLK_GATE_APB_PWM>;
> +			clock-names = "apb";
> +			resets = <&rst RST_PWM>;
> +			status = "disabled";
> +		};
> +
>   		syscon: syscon@7050000000 {
>   			compatible = "sophgo,sg2044-top-syscon", "syscon";
>   			reg = <0x70 0x50000000 0x0 0x1000>;

