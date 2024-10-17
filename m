Return-Path: <netdev+bounces-136626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E55D9A2739
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 17:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B54DB2563C
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 15:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A09B1DED51;
	Thu, 17 Oct 2024 15:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="bsUR39Bx"
X-Original-To: netdev@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazolkn19010004.outbound.protection.outlook.com [52.103.43.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A80F7D3F4;
	Thu, 17 Oct 2024 15:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729179854; cv=fail; b=oVK7x942rQeongCY4PCTMgqxBkoAW71O4lviD07aFx74wkXMq+uGUBtOLSDsOB2gZ3JEx/AxgWLy8qBYz3ArzPNk4drTQQwmMZ2FGzSG5bouw/+ojlvlDz/r7eCKxxUPI9Hi/KlWhIROXv80Kucy9Y8rDobLATHKdjLsNKO7PzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729179854; c=relaxed/simple;
	bh=ZQz+IFG/vxAmCVo8HDl4CTE8ExKUyv9lNxGEkE9q4zk=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KuCbwoKZzwRgjTJyG+SWvcYMUT1F4uRm7EsyVXZdkETRnJVmmpHSsNeRp18oJVMkMA7Nw37aywRVJTuKX4pxbsOReDDfapJGohIZ1AcRG0ice+XzHH6U5U9s3CMCqPbIvjHIrzazpxaqhbpAR39hCj7RYUXtAL5TwMZ+I87Ybjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=bsUR39Bx; arc=fail smtp.client-ip=52.103.43.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OGiMzOmaO1pzd2pF2O5tY3gbhG5++tkAoW9fUBT8rPOLNV3alET/2IMp9prVrhh0EtN7O0Wv9ccR3E2a6nDh1/fYb9B1zD0cy2gdt9uo1AeHWJ/7+pBScFwdSFXh9pdGVNOwz3luLpCyiimWQkTYA9NXKYvKNT3bGR4Lqq73FqLBFk67bvEaNkjJFZV59XFiMMrh8v7LbtE01fhk63R6eQfQHZhMwon+LbLRBMSzocFfGUYewwHTr3OMG3aML0M5MAzjCiWJq0fb2AL3D9CJg8QATX2Ywu4KximFfeZA5PgcVG1if06kssmEwIkv4S+hxIq/Ur2d00+J4NsaXt6PhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h6H3UEX2LUSsAs5kO7e/qoLan6J2PQWTrOLRYfVoaVI=;
 b=YvXlrKj19E+nF1M4SSnvVij1uwz03qtc5mAV5D7uHD3lxoSpZ+DsortjPhUEbTjWs7Wnf4cFEeX4t/BL6vHkgwTPqG3JlPANltrQUKjgtP80pseITLXrqZmAk+jZr5+yeFJJFPSmej1w4lgYbewNx1mqA/EV+Y4BDhJE9Dv96iOnDjjeiJY8uqKRrVT95vQ1+tRWpBuElNL7HE/Ph/SAgp+1QLizI8VPvlpmolNjjAdsIdgNGphWI39Od70hD0SMeivkU3c2ACXBJLXLopAjl/AqNxamg8iAnHwcSfkryKhFNGAjn5sehJ4qahGxAVrvY8JzGqIUpceMTKm6555ulg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6H3UEX2LUSsAs5kO7e/qoLan6J2PQWTrOLRYfVoaVI=;
 b=bsUR39BxxwjgRBoez5RVFtOuGZBWdvoE7CQZsUXsdiM/kVeZAnMzyW5AR1j7N/4DhTqt7ZEJtxbVfIe+gbBqANKQEtbiNwWFVLtdssEWQJx6pcsxagef1BcA/BvCHygGoiWkF2lj3ZVZz8dV8ZZwJ7qTc9JJlV/Id4/EJhj5JVDvICfFyIV2tTzWuLAn4b8h9M76iZDBfSXKBZWPby0dem26wUxhMu/VSUWQpEx2kZVYO5c6klbpm7072rXK04NIG3CVegxJMCRt7VLG4vPp8fxSTxym6Si+VFhx6FBS+3HLWWgFeVhIuSygmfX4hpxeC1K5+Q87njMKn1uzgFTLTA==
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com (2603:1096:400:156::5)
 by OS7PR01MB12066.jpnprd01.prod.outlook.com (2603:1096:604:266::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Thu, 17 Oct
 2024 15:44:05 +0000
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f]) by TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f%6]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 15:44:05 +0000
Message-ID:
 <TYCPR01MB84376AAD26DFA91A1432556A98472@TYCPR01MB8437.jpnprd01.prod.outlook.com>
Date: Thu, 17 Oct 2024 23:44:00 +0800
User-Agent: Mozilla Thunderbird
Cc: wiagn233@outlook.com
Subject: Re: [PATCH v1 RESEND] net: sfp: change quirks for Alcatel Lucent
 G-010S-P
To: Paolo Abeni <pabeni@redhat.com>, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <TYCPR01MB84373677E45A7BFA5A28232C98792@TYCPR01MB8437.jpnprd01.prod.outlook.com>
 <53cd75e3-79c3-42ed-9fb5-4d7258d9bffb@redhat.com>
From: Shengyu Qu <wiagn233@outlook.com>
Content-Language: en-US
Autocrypt: addr=wiagn233@outlook.com; keydata=
 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
In-Reply-To: <53cd75e3-79c3-42ed-9fb5-4d7258d9bffb@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0074.apcprd02.prod.outlook.com
 (2603:1096:4:90::14) To TYCPR01MB8437.jpnprd01.prod.outlook.com
 (2603:1096:400:156::5)
X-Microsoft-Original-Message-ID:
 <dd825a0e-d8ab-4179-8348-cce24afaf0c2@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB8437:EE_|OS7PR01MB12066:EE_
X-MS-Office365-Filtering-Correlation-Id: 1593a90d-bc54-4f4f-2a92-08dceec287ed
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|461199028|7092599003|19110799003|15080799006|5072599009|6090799003|10035399004|440099028|3412199025|4302099013|1602099012|1710799026;
X-Microsoft-Antispam-Message-Info:
	S/2BvOJaCjTkv0+Kr+mzvbhcbifOyZ3+VoSeDn1wik+7OGHBZQuo+8ysoFNPEhesOC/WWBddg5Gun9l59B+CDEiQbYJg/+V9fUN0o11l/JWD30iNl2xqc+MogbIlIv9OeYnzR2qCEzcmeTWkWYT4BQ39OM6T+xbXOdLLr5txwjjP9EawM+lsbWSp48kbz/cZQMy+7jLDPt7e0p9qxeijcCOhZ6FhylPlbiX+kufx0gFtN1e+BC2jxY/BNLQAFqguURrG0G2Fp0cCSI5dmYPN186gtQ980845s6X1h6WsrKUxa4JKi2DjJFYR4Fe0jer+YSq9GFyJajq8onuk6q/btvz1lD6Spdg5NYiQlZRye76nROonK5/Js9NenpAgk7d1qbvOMGwyL1F2mbvAJ6pMBHjwv5/u9pHsgEPJCZeJKhpCm65OSDcwomYYDu6NwA7L9ANj4MdH3SHlKb2pBi+O7sWIPImrasEtTW3DmYroZ2jQGsVB7xzwxbGTYOBHaiNuuMqFa5rCyvEwbtmacnAvdcqNhPFROiFvPXYawzfekfJES/YpR5TdjsFwhvkTLOzWLdzsRw5TWtFQ08H2dh0zfzkjmyDGyxhukWoBPJASFDTdJiO2DHMnlx/VheOFvfHGvOrRcHXfwP+GyHHu5aAmlSL8HpyIga/MKQa6j4ik12nLHQSX423+11omKl6c5Um77qG5Xaq3NBO0kFTWiaUZcOzclt/2KsuqINfIweUYsU9pDK0l0OQiBUjBgvt3GXAlul3UHlJYOGtkNzrIAwqLSACSKNvE4gXvx/K3vTp0qf6gC7EIghI4BiS9m1T8Mx9fWT3r7e0iUbT8LUr2YKbz81b5QcB1U+dfQ1c+SeF2QbEkXFObyKu4KtXnXb9GcxhCliGaY84LEXGu4bI6IXRThUdhtgbtpUhW/0BLw7WChuw+IzTtMrnPW+qK75VVVxPI
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3U2cEUwTGZuTFVzemRDaEZUZkdPelRKZ2lqZUxuUFZhcGVjQkpVZGpvZFBJ?=
 =?utf-8?B?Tm05OHdkUmllREtWVFVSckFJdWNPZS9MSGQzdURJci9VTVUwTzV4YU9td3FT?=
 =?utf-8?B?REEyMmpQamsrc0NTbzcxdG85UlJWVHJLQW9rSjBFa1g4b2c2N2QvTVhHb09G?=
 =?utf-8?B?S1ZUTW9NUjZxQXZJb25NTUE3NjBqMFQwenN1T0x4WVlneFRMU1hNZ21QbExp?=
 =?utf-8?B?MTVNMHpXUCtZSmFETnlsTVFINkFva2tpQWRMQ1JDdG9DRE1lSjhqdnFNa0d2?=
 =?utf-8?B?eTEzZlpVNWJwdU1WU25HbkFzQTdkakMzYlB0bXR2NzZpaUhDckdhaTBJUnBS?=
 =?utf-8?B?VWhEUGNqemVzWDVKZlRMNFNqUmdxcFhNU2k4Rk80cVoxNEdhekxIVm5RMEs3?=
 =?utf-8?B?L0lJZVRualZValMybzFRTjRiY2RoZXpKSGZwamplVFVDbjZ5TEs4SmZKSGZC?=
 =?utf-8?B?Ly9nWG9KR2xCcllWaWQyQTVBRjJ4MjZaaG9mUFN3U0ttM3B0NWgyYUhKelVk?=
 =?utf-8?B?ZTVON0tWemFmeE5zTkwxeU9OS3Q2N1dabktNUlhtbkhJaGJ6RlQxSmFycUlF?=
 =?utf-8?B?cmFBUzZJRllJdVBBMWdrZkl6OG93MFlFY1pkOXE0VFhOSVVlSU9NdWhISmpm?=
 =?utf-8?B?VjBuNjg1NXAvZm5PZVRvVE4vK0VlT3U1c1BIOUZXKzIzcDVaWWY3SHB1bE4w?=
 =?utf-8?B?ZWxCUGZJemh4UFhGbENtVk5WcVlkK0FCZlBGZUFRKytxdzRQQWFoNGJKV0FW?=
 =?utf-8?B?aDJJSHNTL1YzMmZqNUswL3ZWdkpTT29taGFsRlNVaFM4RStDWmJaUUFXTDlz?=
 =?utf-8?B?QlVnQ1JKTVdtNzhkYzlQeFREa3JVNnFnOC94dm8vQXlOdUpRNEhKRW5xSG8y?=
 =?utf-8?B?OVdvMEdRSTlmTEwzK0RBeWdRK2V6Q1h2QWlvUXVMRUUrSit1aVQzRHpwZTJt?=
 =?utf-8?B?UXMzSGNZNUowVENtWUd1amNtV2duVzhqdTErUHJmVmFqNEU0THVKeDRSQXN2?=
 =?utf-8?B?RHFMVWgrTFBveFMvWnpnNEVvQ1AzVTUvdldpb0xqeXZkR1duUE1TTDV2Yzlv?=
 =?utf-8?B?N0RGN1cydHY3V3RBM3RuZzIvdUpzYzdtUEt3bUN2YlZ3amgyeGFZSmQ5RFZI?=
 =?utf-8?B?NnBvSHo4eGJzbmRTSWR0d3B2cXlFbjl5Tk1kcUorZFIwSm5TZ3UrR0FnNEFh?=
 =?utf-8?B?T0tseVFGUG9RMENPQVNrVEdibXRUN0k5eFZWSjluZm5ST04yMTlXeTdnTmlj?=
 =?utf-8?B?Ry9rUWJjVW1hYURhK2tQMHVpbC9vWkE1TFkraEkyU2lNUVhuc042dGZQbW5y?=
 =?utf-8?B?QkJrWndSbEZXWXA1YXdLTWRIOHQ3cW01UHhKOGk3akZzQmJrUnZaT3NuMTZE?=
 =?utf-8?B?OWRXWVU3MG5USmo2MDcxVzcyTUxwRCtWY3NUamtMK0pIMWNLZkh5MlgvN2pW?=
 =?utf-8?B?NlBIRzc2Z21POWhpd3NRdHUyMDdtQ3M0cG9GQjV1ditnWDZxei9UQjd2TUJX?=
 =?utf-8?B?aFpxdzNuRlFabHRzMHFXK2ZqbStIKzl3N21zSGJ0OVNiWndtNkQ2OEhUc2Y1?=
 =?utf-8?B?WlVwSXZLY3NvV1JDb3J2ODFFUDYyREg0OVpwNjlDaHJTNW1JaVgxWnlHcE81?=
 =?utf-8?Q?HjHngMVWPtX/iI3zSKW5MQQfgRLqtwntoJ5ss8C3LmVA=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1593a90d-bc54-4f4f-2a92-08dceec287ed
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8437.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 15:44:05.3647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB12066

Hello Paulo,

We already have some information that I think is enough for this:
https://hack-gpon.org/ont-nokia-g-010s-p/

Best regards,
Shengyu

在 2024/10/17 16:04, Paolo Abeni 写道:
> On 10/11/24 19:39, Shengyu Qu wrote:
>> Seems Alcatel Lucent G-010S-P also have the same problem that it uses
>> TX_FAULT pin for SOC uart. So apply sfp_fixup_ignore_tx_fault to it.
>>
>> Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
> It would be great if a 3rd party could actually test this.
> 
> Leaving the patch pending a little more for such goal.
> 
> Thanks,
> 
> Paolo
> 


