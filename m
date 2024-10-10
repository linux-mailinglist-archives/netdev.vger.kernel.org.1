Return-Path: <netdev+bounces-134339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B706E998D9D
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 18:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F28461F2481C
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 16:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB5D197512;
	Thu, 10 Oct 2024 16:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="a8U1fTO0"
X-Original-To: netdev@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazolkn19010004.outbound.protection.outlook.com [52.103.43.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71F2192B9E;
	Thu, 10 Oct 2024 16:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728578388; cv=fail; b=NsjldrkNKXMNc8uEkooC7zhLWqGAn91nxZjKRJ/nDWjoJsjU+w/oGrwWCSagwjo6Sv7/2AwV1wrY/xuBVPhrpqLuyhpIIvNxfCGIFgewvRkRRGf9xm23XZ70c6q3N9cgVVZwWsr/pVNHDOPLSkMWOBgAFNz00VVZjM6tALHcZLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728578388; c=relaxed/simple;
	bh=Pr4aKHf947ekQATbTwrdS8FFbCkLA/uRAE6i5hGrkO8=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h+uTTippR03pV4s7HzoA2OSKkFltFg4w6446HRHUWASjeif3byaWfwPhPrEkuybkhUi1b/ZVsn7SqPfCFFBl7lNBBaj6CAI1A0eXVlvkSjE0B9KoukRfLzj5HfvBF5x8VK9rrwoLmuptG4N9BIyBgCQGseDIhbr0vboK2arYPTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=a8U1fTO0; arc=fail smtp.client-ip=52.103.43.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G1ovb9J+fwCP5lZ+GAWUraNIysHlQIhh1Ixuph/zsOFEYhQ7vkVtmDFRlycfgQ943kyYCs4pfTXbRXYucuAqlPlt+25TGgpwmWRm5NvayFQgu7tYgRqQ5tMiOfMbFYHYyAtefR+K5dATrOli/znq3NMzWpRZBbeITecJFvCBTeVtRtnFvn2+z//4Q2hKqNggKphDHyNHz3MdjN7cqZCub+XNlOaM/jWa6LkcW+whlAkJmBmcEBdCMKSxdRqzcPsbxFx1w2PVaM/1+CUcMCT04KGtUNhqgUUxHy1QIk+zWCklOKlvNevu3H1VH7Zq3O1grUm2QrzOzjhbok1aAf6BXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QCVLp4aTaNfS1qAEnIvDloZENq51ViWFksfUwtyqRTc=;
 b=QtxaNMnk+pdhT03KYpCWY6MmNOpIZTj5J96JwkkKGEAx1O/7IWB4NOBV2qCfGUoD4FWFTFw/+m5lVwZV5BPMnq13Z13jQ+oULms3Vv2o5zWFDzvSDrahn+7juVDM3Hvyt5eD0LbrQOb5VrSxaaHcSfcBVbYS3GIFjK6k51+bH+jTwjhWBb4Mc2bfXGz7nMPe84UAXvedii7qItyWcP63oeXSKHxp3A8WGT08TYUmFo4R8Z1/RYfxb3eh+3jolSq68e8+60V0qjrBKvEz0IYEaoGObc5H9eVPlVUYVZ1LuggTRjhPXJ+sYO3mWBzogUchS7A1/z8UCzquPF83OPQmOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCVLp4aTaNfS1qAEnIvDloZENq51ViWFksfUwtyqRTc=;
 b=a8U1fTO0hyhDpxjtyGgWAPBjm1MHSIaq0FPw/zk+MC5ARsl7XzJGcIuYvxvxhaKo1EhA7jMqUKJyBqtKx7CO8yYkaWBTDLWkqIkYnuW0E/pUt6Q/iWOX17gxCrGl4CRdj4WxXvZr1/98XLhcmZ+wB3TM4oG3YNDRv6FkasATdQqfCl7MbpvkgQTNKDcx8hoZ6g1HbGzCj236eRxEy6+WE7vupADiT6Sn6i5zJ5rpGOFzeyXxIJfWpHYitVLLkf5c4CE3ph4PDJrAJgLon5HZ+E/GrcNCH8S2KDd1s7TLAceQ3jgBaWvz876bicn5NmIh5tgAf73xJYqJad9qB/ve3A==
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com (2603:1096:400:156::5)
 by TYWPR01MB9388.jpnprd01.prod.outlook.com (2603:1096:400:1a5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 16:39:42 +0000
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f]) by TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f%6]) with mapi id 15.20.8026.020; Thu, 10 Oct 2024
 16:39:42 +0000
Message-ID:
 <TYCPR01MB8437648E5B722461FC13D8C598782@TYCPR01MB8437.jpnprd01.prod.outlook.com>
Date: Fri, 11 Oct 2024 00:39:38 +0800
User-Agent: Mozilla Thunderbird
Cc: wiagn233@outlook.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] net: sfp: change quirks for Alcatel Lucent G-010S-P
To: Jakub Kicinski <kuba@kernel.org>
References: <TYCPR01MB843714CF627B46DFA06E471B98732@TYCPR01MB8437.jpnprd01.prod.outlook.com>
 <20241009174044.73e1fce0@kernel.org>
From: Shengyu Qu <wiagn233@outlook.com>
Content-Language: en-US
Autocrypt: addr=wiagn233@outlook.com; keydata=
 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
In-Reply-To: <20241009174044.73e1fce0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0091.apcprd02.prod.outlook.com
 (2603:1096:4:90::31) To TYCPR01MB8437.jpnprd01.prod.outlook.com
 (2603:1096:400:156::5)
X-Microsoft-Original-Message-ID:
 <7bc13447-c512-4095-b13a-e29892c2fe29@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB8437:EE_|TYWPR01MB9388:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ee13d50-7eab-43c9-a3d0-08dce94a2426
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|8060799006|461199028|15080799006|5072599009|6090799003|7092599003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	pNhxWSNYDsTNuG1FdsPunBVHxQSdTfhuBWaoQw4bGJDcUSkt3GlwZl/iEgacuSZfMCkm9PDZnhMMG3gOI3M0lNpnagBLjh9ykVDN3WYXCnGy2QMYPN22b/0+xrnbKLmUmzsv4RYfhW5JxsLuNZpNyvSEifAyA606IUzvBbNttKqWdNtHRY4RuXJugQxPw39KkuGHOc234cDSc+Biegq6nRs69ji6ksoPAuQF9S4HchEFEnFmKNFLpJK1qokkunj8sAsNLNxT7HrTdvGN3O8FtCPUaN+rgZImVkiBt5K4FPi9uUbDUCvBUeWhZu9kVVUmyJkPf/G0CMhOF/P50fOvSuke5w4sa57++3c2y0xnq78QNRaFnJ7/Ft+uSRcl9lVju1+jNo2YPtbtR7lKMukqzQumori8atEzGup2foR32DIXMniNu3slaDrJI5diGb8W4SNQM9GiZpYJikxDJFRH44E518VoZBsaTPqoqUCBY6kixY90mQixiw5e8LGjeaH7YxZ4yDPRZBIOExjW+hQQkgo2I8k7I5cSZ5gyZoiCYObyCRrF/ZL2wR4XXdbA5cYYWRA95prjSWtwj4D3qvkSO0J7/pRq5ld6kYFhiLCgzKw6pAwKg/R0ZAm/F5MeboBc1Kz11RwtTgshENNmhFifZ+A2F1JTxW66EmNxYZUMTo2MlVWT03VjlLLge2m1W3/6v0MUJTrOLmi3jwNYDcMn90AhMAoVEGOw94f+g0J/3xRq6Pl0sJbEgkIPNkBa1l8JilOKMZR8U7atTAlV6R90O13y/ngv8iDwbnnmu9fQCiA=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0JrbUYxRkhWeWh4R004ajlaQUVOakRORWZjMmRCRlMvU2ZxazBpRlpqNjhj?=
 =?utf-8?B?RGxOaVA2c0lYZHVacndDSVpaNHlBbjBsR1JWRWp2OGRVK085WUN5UmR2Y2U4?=
 =?utf-8?B?eHRxdmlwQ1JIZGFMdkhjWmkxbW5jc2c0OUh1YUE5aUJrcDM2cmFOYmJaUVg4?=
 =?utf-8?B?bGlmdGtza2V0TUxtNlR3WmZuWktiVGFSU2JFckpTV2pkZnhWVU16NG9WaFI4?=
 =?utf-8?B?N0FqWUlrTC9SdTJLc255bnVtSktFd3JraGhidWVsVkJmYm01ektMTWdBYzBO?=
 =?utf-8?B?anhOdWsyaDdNcFkxNEdxNU1rSHNxYU9PUHNKeHJxT0h2K0dmM1ZhVExwSGow?=
 =?utf-8?B?MzdaWnFuSFhYYlRpbjRzWmcxbUk4RloxU0pJYVZHUTJiY294bGdIWGtPTlph?=
 =?utf-8?B?bm5SUVV6U2Z6Z2t6c09Bcnkxdms1eDVXWUdycVdqYXIvVFYrczludTJ3cFJG?=
 =?utf-8?B?NjV6M0dIYWJyYytTL0hXVTQ1TTFoR2lqMWwrbStHYjdzNHhyZ1FicGRpcncv?=
 =?utf-8?B?WnFhZlZ4RG5BNVJ4V3dkMFJ0R0RaWStlN2RldVkwTXZ1V3FYaW1RNWdBZ3hk?=
 =?utf-8?B?Rm5rNVY0cWVwYUFRckxCN0syb1NFNUFJYnFtdkpTSG1od3cwWkRaRUt3UWJ1?=
 =?utf-8?B?aE41cUxDY2s3RTBFN0dHelVMUm5nRE9qem1YdHFiRXdGZWJ0cnh5b1NHMnI4?=
 =?utf-8?B?MFU4RnZwVHc5d2VxTjhGdG51TFNhQ29QNjl5TitBWG1CWVZYY3h3d0R2NlZM?=
 =?utf-8?B?YWlYNjNwa3JsQ2RhWm9SZ29jdmdCaXRtNVJiMlJVRi81NEFVdHYrT3NVNTU5?=
 =?utf-8?B?VlNMVURmMGl5a0g4bDJPUHJ6KzVmcDI5MTFZMWIwc3FyeUdqekI3QmdqZkJ0?=
 =?utf-8?B?V05rNXpCOWhyZW5XRmJ6akxxNzhORSswRExLcnE1djQ3OTQwYm8wcWE2d1Zs?=
 =?utf-8?B?NHdzWGZhQlhsMjB5cDNiZjRGdXJhT25MNHh1RFEvdG10SjRBYXA4SWh1RWhZ?=
 =?utf-8?B?dHErTlBKRDN0M3ovL2RFY3NPcWhkdXM4UHM2K2dYSHVncjZNREtmMXFCQ25O?=
 =?utf-8?B?MzA1dXY0NElOVEp2c2lkZjNWUXF3NHNIS2xIZG04THFtS2J3ZVNJbjBHc2VX?=
 =?utf-8?B?cC9PZWF6UFVxOFl4N0VRZng2L3JIMkpxZE9XR2xQT3JiejRFNE9GaXd0MFRn?=
 =?utf-8?B?eFlGbU9YYXQwMklLdFkxM0x1cWxPTDNWVTBHd3BSTjVYNjFWaHI2c1daRWVX?=
 =?utf-8?B?aVpVMERnMDh5OW5KTCthNEVSWCtaRTBnOTN5Nlg1ODZkNVNGcVhUZHFjeVZI?=
 =?utf-8?B?dUFiOTZrZ0tEcU9yZm01bDR4TWZwYkxlRjR4dHNVMkNnVk5wQ3lVdUppTVhw?=
 =?utf-8?B?VFJlSUJjNmtTVDNicS9tSW9sOW1QcXZ5djlzbERpYmFya0NYcWxzMEphbXFw?=
 =?utf-8?B?bjlwTVF2eEZLbjkzeGFrcHEyWmhRcWt2bnU2YmVoNkVZQU5CUTZZZjVERUYv?=
 =?utf-8?B?cTdnNVFQMk81ZUtrTzQrQzMxZGhFZEI5VWhnbjJvRm5zZnVKZ3FjZFNtMDkv?=
 =?utf-8?B?RFJtMzdyTUpNOWl6blVLQmtrMkFDbTdjK05IZC8zTjZyYjJwZktzSWlHb0xh?=
 =?utf-8?Q?2gONNMZb/Df8rJpMlhcGMgoEkFrcx7evbY/jObuo5Bho=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee13d50-7eab-43c9-a3d0-08dce94a2426
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8437.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 16:39:42.5671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9388

Hello Jakub,

Sorry, I can't. Outlook has just disabled using password to log into
smtp server and Oauth2 is the only choice. And I don't know how to
configure git send-email to use it. So I copied the text in patch file
and send it using thunderbird.

Best regards,
Shengyu

在 2024/10/10 8:40, Jakub Kicinski 写道:
> On Sun, 6 Oct 2024 00:04:29 +0800 Shengyu Qu wrote:
>> Seems Alcatel Lucent G-010S-P also have the same problem that it uses
>> TX_FAULT pin for SOC uart. So apply sfp_fixup_ignore_tx_fault to it.
> 
> Looks like your email client (or server) has corrupted the patch.
> Please try resending using git send-email?


