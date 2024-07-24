Return-Path: <netdev+bounces-112721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C9A93ACCC
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 08:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 789301F2322B
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 06:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901A349647;
	Wed, 24 Jul 2024 06:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="WtYKyIj/"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2092.outbound.protection.outlook.com [40.107.255.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CEE73440;
	Wed, 24 Jul 2024 06:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721803757; cv=fail; b=bnleOI4chgzV8Ytc5MFNQrkUAangLZ1wr0qlp0bP6Pd/miL1s4q3pPh5SE/5bPC6OybJ4yrZTPfVw6lpFF7W1FpRzFH/TWqcCVubDjOuXbFijxxvgogu4oqdnbYS3nfx6ydlJPwuivXmECmjRIIUraTRT/XjlpyBQ6C6ZZUnVO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721803757; c=relaxed/simple;
	bh=ZVArQbBlGM/AgvrBhmWigmstCC4gM0FZHD2jrxwqU38=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Pntx+0P0lSukceNArwdNfBE76Gl/m241D5HDfCE/33sZkF0CHnQATq88hdodRaDHVDXkLwNTRZZxLdu/8AOVi+INQHoBYIvs0NDaxyseZc6OcWCL+ghGIQ2M5BMcsdZnY6XOUqVykIj91Y6RVfff3Ni2Np7fD1yzQ0f4kaztpJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=WtYKyIj/; arc=fail smtp.client-ip=40.107.255.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jLhI5w1ROVstAnlkdKX4r9cGzN/Ll8YeWR69ncHM/3c7GyKcmENKzWPef3HaFaaJomr2xCJffnhxfbkR8NKrN3pdgfkImcd6VbZ7u/DY1RvsXPqa3VD2V40oF+FtpEWzRMBbgR1ml9Gy6uhFbcdBNIZWhbBA1dLaEMNqgEcwBmXEIB4MHsY2NTIhDl+yYFoZnAIPW0ePuqapjtaQ5X9hbkwPmn/PUkRaEtbGNvZRpa4ezx4/EF7j1XoKyhG0EI94urnhVw5HbMzAhzl3Gedf7yb1lZC74aIcDIx2furfp/n+or1CM2O3+lCrZK2W9V2gxEAtuvHr7uCxAraxuocisg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ev3to5hkrNTdPJ37dHTMTNXiJqRB8eeBIN6Jn4h9rEg=;
 b=jOkUnFzxa2XSqf1JnRsHLTF1JP+Wci7k2EiutrTgzLqZyGjsZ4Kpm585Lgb6Qg39OXZmNW8jdeF2lN0zFzcuylJMPZkrZ8JO8ZkxSSdAJlY4j6gE6KpnWJ8otbK5MaQKWVRHSkDroTx6J+ZptR4HMzEyRxlyW1TMw7NfVTgTBPkSMsNKUgiBIcB3SDRwyn48i7/BZW+IzXmHJ0yu3TN2ivV4GK9WWNkC48Qp+eS2KIpvUi1KQMUPR3FHnTpFH3ruNAEQkZ/w8X9XpG6HwRWQL+9sQqTBK01iUNzlQc4VL0Gfc5LRNEWr1VKtOKObwCyt8/P0l7zy6liTjqdh4+yuvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ev3to5hkrNTdPJ37dHTMTNXiJqRB8eeBIN6Jn4h9rEg=;
 b=WtYKyIj/2B8URGbb+/lNndLK90/PN1F70nFI05l5Ax1VbLp+7XQQ46ziQh9YnpB+DAp6Pc/ZU/fPmBA7irySLSPB2S2DO0aenOnTpvdHA1LQRP8FBsP+VsDZC7cnl4uSR47Uc22nlFgJ/c6gF8fp2hD472v9W25KJadA+t10XU90thbmUOF/7vi9iLubv9povSzY51+vYmCj0B1DfjAfFPmww/q4ias7Hs14bEXEQqjGaFGrIz+WZ+L5M9o276dgMJQtgH2cRSFqnnyFaD2kWm55fVOjZjRctCFyyKOJFadm7qctpU982cy/Zltbm2Xs+jmluEeax0koHssh30+rQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by TYZPR03MB8701.apcprd03.prod.outlook.com (2603:1096:405:b9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 24 Jul
 2024 06:49:12 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%5]) with mapi id 15.20.7784.016; Wed, 24 Jul 2024
 06:49:12 +0000
Message-ID: <ee98ce34-a08b-4aa1-aa16-d3539460c396@amlogic.com>
Date: Wed, 24 Jul 2024 14:48:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: net: bluetooth: Add support for
 Amlogic Bluetooth
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240718-btaml-v2-0-1392b2e21183@amlogic.com>
 <20240718-btaml-v2-1-1392b2e21183@amlogic.com>
 <18f1301f-6d93-4645-b6d9-e4ccd103ff5d@kernel.org>
 <30cf7665-ff35-4a1a-ba26-0bbe377512be@amlogic.com>
 <1582443b-c20a-4e3a-b633-2e7204daf7e0@kernel.org>
 <e8adc4a7-ee03-401d-8a3f-0fb415318ad3@amlogic.com>
 <bbe8d8ad-d78c-43fe-8beb-39453832b5bf@kernel.org>
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <bbe8d8ad-d78c-43fe-8beb-39453832b5bf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0090.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::19) To JH0PR03MB7468.apcprd03.prod.outlook.com
 (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|TYZPR03MB8701:EE_
X-MS-Office365-Filtering-Correlation-Id: dd55819a-a908-49d3-75d9-08dcabacba00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WjJkM0RNSndFRjZNYU5mcUd6Y2NsSzRZOCt0eUlEanN5dVJmMGNyTmhaUHBH?=
 =?utf-8?B?RUhLWk4rZkc1eWg5R1BJRHJYUjkwOFozME0rZEZqVmwyMXYrNjV1M2Z0bmJ6?=
 =?utf-8?B?U3VtYk9KNk5ZV0ozRFdPdkc3RmhMREJVYklmNHgyalIxMGhjemVoWjlicjdS?=
 =?utf-8?B?ZWdBSDNxbzByRmNDT1FGVnpTSU5XWi9uY1pqakp1cmdWL0NIWnpOelE3M0dJ?=
 =?utf-8?B?MXY3WDhGcUNvVi9EVk84TDBGNU1hYnJZUWR4cnBSQnU1d3gyWWJhQ1FBbjZV?=
 =?utf-8?B?WjMwdmUyY2FkRy9sd3dSc2hwdjh6cktUalZBZWEvQUJkdFV2UmhvNEl0NlFn?=
 =?utf-8?B?dDd6T0ttajBwd0NDSk93NXBjZjZ4Nmc3Sk5DY0hkYXd4OWtEWkRLdHdscXFL?=
 =?utf-8?B?Nk52Ujc3L2tBMjNUeHZzd0tSLzlNK3Rhd096QnBrY1kweTVkTE9jZXp1Q3ZX?=
 =?utf-8?B?eVdWYTNyV0VlRXBiY1pxT0xhWHVxeVM3K0M2Tkp0WHpsNEl4OU5tbFloaytZ?=
 =?utf-8?B?dmVjWUNBd1BHbWYwNmF0bis5YS9kUS9ERG10T096STY1TTY3clNlOWQwdUh1?=
 =?utf-8?B?T0U1YjJmK2IyVUxzZk51RDFiTmhhTmM0MVNUOGNZRmcxRWlTa2thUUdTdnJO?=
 =?utf-8?B?T0JKcWxFbGNDZWh0ZTlienQ2dUIxL2R1eXYxcHBraTIxUWdyTXJ0UjMwcVV1?=
 =?utf-8?B?RVFRMDB0aGhmSnUzbWkwWDIvYWdXbW5JTktWWEZycFM2NU11SUtlQVpReTA5?=
 =?utf-8?B?OHZ3VjFRbkpTdEFWWmUvOTBxV0c0MEp6ajBkZkhOR05iaE9YS09DR1AxemFt?=
 =?utf-8?B?WFhuR0p2OG90UHRHd0JrOHU1SUVvZWdVOGVCMm1Xbm1aWlFuOXRKY3JJZ0Q5?=
 =?utf-8?B?NXUyYitVeGZ1YTVlSk9PcWQzcVdQa1dmZ1ZiODNEU0d0cFZDR3hScktySDNq?=
 =?utf-8?B?NDMyZW4vV2k1UFZOQ0Nlc2RhUE13NzB6Q0NPNGVHZWhvdmwyRlpnMC9sYWhB?=
 =?utf-8?B?UE9jajlPUGpZRFJEQXZTTTFIRWFTaGtCeUtLVnpQVG5MblphWkY2bHgvamFw?=
 =?utf-8?B?QnZxWXBucWRNa2ZnUHQ3WHZiMElZeEg0S1N6OTgwdTByTTJ1bk51aUNTZUt2?=
 =?utf-8?B?dU9POUVCOU15Yk1QRjBITThyc1AwUkQzL29BYmZFcEpOS3hxdk83VjByWUxk?=
 =?utf-8?B?Sk1jZGRzVHNPY0k4a1o3ck4vZnoxSUU2bHN3Y05rRThGbW94TmtWS2dDSW40?=
 =?utf-8?B?czBRSXJvWTZGaFlkcHJZNktiUndxY2xyV1ZHQ1RUcDY2VGJrcDlZaXFESDVV?=
 =?utf-8?B?anMrbmRDcitMQ3c4Z253aEVSTCtVN3p6K3RuZXlHbGZ3V1Z3VCtTL05sNmw1?=
 =?utf-8?B?Ulp3VkpYL1B4dmN2RmVFZTQwd29uOGdVUXdhYlpyWWpmN3ZLS3VualZRVWkv?=
 =?utf-8?B?bnljRXFEeEJLT3dOL1pOSVV6ODlqSHU2Q3RTbE9WUnFwb1hiUFpOWk5Zd08r?=
 =?utf-8?B?ZlNDZHNCZGd2MmNJZ1ovcmR5Sit5Z1JlbkdROVdQd25kZTk4Q0dJY2NRWDdM?=
 =?utf-8?B?MmExZ3Zad20yUFBjcVAzTXNLa2JMRHViU013eEE5Sit4QTNoK1ZLcmIrNW1X?=
 =?utf-8?B?d2pYSHFhOFE3cGVUL3VYT3djUldJd3A5OC9nZzlzK3p4YmRQRE9rdnM1MDJF?=
 =?utf-8?B?U2gxd2hkcXB6a29JYno1cnRiRjBYemxWc2F3OXJydS80Ykx3SGZnYXRjZ0Ez?=
 =?utf-8?B?VFh0SnhmbmVtUzFoRkJCYzlUMWxBSTFvTEFnU0svVzAwZC9lRk1pQStKV3A5?=
 =?utf-8?B?SEVTRjhjbXI0M0cxc1F3YjVRN0JrTXBHb0ZVSmFqdlJqWDcrbjAxMVdlZnlp?=
 =?utf-8?Q?q9KOBpfrr2LQu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zk9tYVVwNUJDV1dtZ3JOM2w3R2gvNEs2QVNjalpIUjhPZFBGdmVsdDhILzJu?=
 =?utf-8?B?c0RDb0FUTUoxcVkzbDF6N1JsTTBtUVhJUzFtdFpFbXI3aUNmZFZ4YVpDcnAz?=
 =?utf-8?B?cjRKL1RNS01lb0Q2TDZUb216MUtIbGJtc3dWb1FNR2dHMFBBZG5RNlBiS2lH?=
 =?utf-8?B?c1JWZE84RzYvZHhNR1FETVJFN2Q3em5ObEFOK0xFVkdWMVRPemYva1FRZFJX?=
 =?utf-8?B?bTVyOEVIWWlPcS9Ea21QSW9UR1czUEFoZjRtaTd5Q0xqcU5IMVEyTGRZNWN1?=
 =?utf-8?B?VTY1eWIvYTFYK2IxeHEwZ0NXSlJFMkVIN013S1A0SW9wa3l2SFhqUUZyNE1O?=
 =?utf-8?B?cG1tOG9UZDYzTkVVSnIzWXNlNW5zbkEvY3NBdjVIL21PQnFIZmxNcGpTVTV4?=
 =?utf-8?B?OXFTMWo5NGVHWENZaW9ZOVZoNmFjVzdwVm9tbDVlK2VlNS83eTRVMlRuSmY0?=
 =?utf-8?B?OG5uVFdIUEVWd1FMclI1ZW9kaHVKcHBKTGZhQlF4NDBuSW80c0hEa0NzRWhp?=
 =?utf-8?B?VDRBVVRhdVlGRHRlRGJWc213RFBCbzVuMEJodHlMMlBvNlIxRGZTZWVzT3dt?=
 =?utf-8?B?Yi9FWkFzNWNkaHFVQ0NUN0pLa2h2RmFSUUVkcGp2WnIxd01wb1BzeDJSQ1dS?=
 =?utf-8?B?ekdPcTJWVVFoQWxDZWVwTUthSEM1M2l5VlRiMGtBQVZDMW9OakNScWE3VVA0?=
 =?utf-8?B?UG5KanJOak4rMGdkZVhuWlZ5TjF0end5V2g3N0RhNWFJT2tpUzkyLzlMcCs1?=
 =?utf-8?B?MU9WdERsVEROSktIZVNES1lDWmV4NUlyY1NOWDVJU2RtWUt3eG1tS1R2M0lE?=
 =?utf-8?B?SGhvUHlVRGRIZFUxOFRSbkI4Y09KZWo4eVZ0ZjhBSldrZmtUR0FuWVhpZjZw?=
 =?utf-8?B?S0JjWUk5TGVaV0tiMlpxNU5ISzZtTEl4WWtRbWR4VDA1emtCTzdzV2ZWZ3pC?=
 =?utf-8?B?YjV5VitsMW9wRGFKL1ZxTUdZbGVzUGFDV0R1emRjV2xnVHF1bkh6eVBGVlF4?=
 =?utf-8?B?YkdJcDh6VU5xQW56My9FT25sdm9kM2kzVmNGVXAybjF4amhsdExENEQ2b2pi?=
 =?utf-8?B?Rk1uY1crVFY0Vy9RTXZZUGx1ODkxM3NqQmMyZW10Vll6RVZJdUNpcTJLQTlW?=
 =?utf-8?B?OXB0dW1NUWdOaDlGelBVWi9ZVFY3RzRlcytBMHJ1MTNjWDBFQW1sZzNlTFI3?=
 =?utf-8?B?VkFXNzJSMTFVUkl6d3FoRUZ6Qk02SWlHQWloTGlGZm0rVUdmTW4yWUNFUzUz?=
 =?utf-8?B?eWJWWnl0dWxKOEhwUHpiZ3E4UTZ3ZzJROWt5Y1FhUFFBZVFSOG44WWtXQ0Rs?=
 =?utf-8?B?SGhycjR2QkhZeVZ0dWQ3Sm15ZWdtSVlXaDYzbkZVUklaWmIyeGVwV3NxeTRZ?=
 =?utf-8?B?cHJwekpsQzdDc1FSSkFaNEM3OE9jd094bmJPQW50U0xlT2dCTGtqaHREYzBw?=
 =?utf-8?B?SlJnQ09ZVmVlcDRKVTBMTGp2U3JJS0x6U0xvc0JKYTREenM0WjRUNVZNK2hK?=
 =?utf-8?B?T21JUWF0QkdwdkJSazlPYjhGRHpHdkhMbHpUZS9CKzRDL3R5TjJuUXdHcU5o?=
 =?utf-8?B?RFFpU0g5UTI4MXA2ZXNYeG00Nmx4QVF5YlBNZDlGamVaS2NZdEtFMjdGSUdS?=
 =?utf-8?B?ZHd6dUNIUWZncDBvNEcvQ1RER1hVbHNnSk9pV1J6eUZJcFBBbFpoSndzSHFS?=
 =?utf-8?B?NEszZ1YvTDI2b01jMjlsK0x2THl3WlVhREZxbkZrbUJWbmlMZ0R5YUN0RnNW?=
 =?utf-8?B?K3BwVHBKRHNiTGlSbjdsRHhwK3BRZVQzUUo1Y2oxRFF4RWp3QkxKQU5wYnI1?=
 =?utf-8?B?aHlac29Ua0lqNWRpMmRXYjBVaHczUVBmUnFxUk0wSmZXVFdWOG1WWHBNR1Ax?=
 =?utf-8?B?eVQ4dWc5aWRJNkhRb01OdXhXMTA5UGQ3RWRmRmZwa09Tekd1OUp5QTJseE9L?=
 =?utf-8?B?N0RiQUV6NVNMZ3huaVpCT2tvc3h2bXZ0ZnZpL3BFd1NZaHNKTkZUUkx0alls?=
 =?utf-8?B?MHZYZlJXQUNXK28vUzZDaHVWREd2T1hhMlI2MHlqS1lyaVdBc2E2Y1lSOEx3?=
 =?utf-8?B?NnNkU1ZTNUl0MkJFN3AwczNDV1V5eCtRbGxCYXNhQUpEUCs5RFZCYUV5N2hK?=
 =?utf-8?Q?Gx561u+IKu3BaUdq9LbGaPkmt?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd55819a-a908-49d3-75d9-08dcabacba00
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 06:49:12.4387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 34LlLGk52JoAuMg0fcsRj99RprJNTNGf4lO2zbrLCAM2ARAz1ncOcRDPWpM4UK727ibZZWP267uxDC+592qkYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8701


On 2024/7/22 15:58, Krzysztof Kozlowski wrote:
> On 22/07/2024 09:41, Yang Li wrote:
>>>>>> +    description: bluetooth chip 3.3V supply regulator handle
>>>>>> +
>>>>>> +  clocks:
>>>>>> +    maxItems: 1
>>>>>> +    description: clock provided to the controller (32.768KHz)
>>>>>> +
>>>>>> +  antenna-number:
>>>>>> +    default: 1
>>>>>> +    description: device supports up to two antennas
>>>>> Keep it consistent - either descriptions are the last property or
>>>>> somewhere else. Usually the last.
>>>>>
>>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>>> And what does it mean? What happens if BT uses antenna number 2, not 1?
>>>>> What is connected to the other antenna? It really feels useless to say
>>>>> which antenna is connected to hardware.
>>>> Sorry, the antenna description was incorrect, it should specify whether
>>>>
>>>> Bluetooth and WiFi coexist. I will change it as below:
>>>>
>>>>        aml,work-mode:
>>>>        type: boolean
>>>>        description: specifywhether Bluetooth and WiFi coexist.
>>> So one device can be used on different boards - some without WiFi
>>> antenna? But, why in the binding of bluetooth you describe whether there
>>> is WiFi antenna?
>> Yes, it can be used on dirfferent boards. The device can operate in both
> Please do not respond to only partial part of the comment. It is obvious
> device can work on different boards. You do not have to confirm it. The
> question was different - why do you need this property? I gave you
> possible answer, but you skipped this and answered with obvious statement.

I'm sorry. I didn't explain it clearly.

Board design should be optimized for specific use cases: use the 
standalone mode for high-speed, stable, and Bluetooth-only applications; 
opt for the coexistence mode in cost-sensitive scenarios with lower 
performance demands. Once the hardware is determined, the user needs to 
configure the working mode of the firmware.

>
>> standalone mode and coexistence mode. typically running standalone mode.
>>
>> Therefore, I would like to revise the description as follows:
>>
>> aml,coexisting:
>>       type: boolean
>>       description: Enable coexistence mode, allowing shared antenna usage
>> with Wi-Fi.
> Why this is not enabled always?

The board design determines whether to enable this property.

Well, I know I should clearly describe why this property is enabled 
here, so I modify it as follows:

aml,coexisting:
      type: boolean
      description: Enable co-existence mode on boards sharing antennas 
with Wi-Fi.

>
> Best regards,
> Krzysztof
>

