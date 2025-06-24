Return-Path: <netdev+bounces-200532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFEAAE5E94
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 10:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83C33189DC76
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 08:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D574E253F03;
	Tue, 24 Jun 2025 08:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="plunWAZt"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010045.outbound.protection.outlook.com [52.101.69.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EB623C50A
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 07:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750752001; cv=fail; b=ar1bGs+WEMAjAKDS/TiFfuwTkh09hdAwvBppgDtpFPMmhKtotzexJSbMLxUEZ++xneRYsFBkg8zrNUXbAMTCY3joiVk2vCvbw8hASlawWkydfib43WYF3GWHjYkNXIH8xusGUBs/sLSTKZZiRmhx/vFH336IL1jPN9xeZ4NKnWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750752001; c=relaxed/simple;
	bh=67pxg1NrYSto68a4Sx51/kyghIeWsMTUd+DkA9l8vAE=;
	h=Message-ID:Date:Subject:To:References:From:Cc:In-Reply-To:
	 Content-Type:MIME-Version; b=DgHcUY86OwpokK/l0DsGL/SSjl746tkNU9tYk6B61NQ4HAprfjv+KJMtrFrOJMyMvCwpRI/u71glH8yIbWv71XJqvdXq49VnpwZNTl0rVMFKZC7D7Rz6acewhAz7FhiSS8xGY1FqoytUwh5B9lMxPcQSw5Kudvenxrvhrl5cmRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=plunWAZt; arc=fail smtp.client-ip=52.101.69.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jqNMzpBSjm2LNKQK71U/Qx3/I8CDw+x6BFPyXzSsofsDnvOpezHaoac4WovRk5TgGbq71MD1FvYNZShSSsLLvCPeqp8+w/weaIsyfJqlw+a4DE8+QbTBXazSLZ9bB1D+ldER0FFPwQyJvEL0Q4oAembDaUgpjVCRrDHyY3y4J3U/eTuPWl+CzvoJ1Oj7g4WoYaXDMCTdNymA/f1gUcytJgdrYerVBvISmtiwBOcj5JsrlNF0+AHfQCzgijlwzKjS2MoycP2EY+Bf//KZ4aCalb64hI/agi3wMCyz65pRAeaUBkuH/UxjGRVvWF4vUabUVQcA56u3mywaXUHvm3zaLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bjQl0+IHt4PZpkS/8FkaxGD0472skfpg9ZxC19jm+W0=;
 b=T1aeB/wqGqj8jinOVd8Dw0Jmuy0Tms5pkEWnAfFXULvJ+FZeVS/4WPleRPanl4MPRpzu3mnwM46AB5+iFzvHeO4OZZ88GsnMMhkeoBh/7570lBNYEbfpTrpdsXAa1Hm9WTXMyTDlCdBpgHwemeeSaYTxbN5K9Zva7/trJPr9772uARoXMDkp4ZqQtCOkXp6RGduH4YnOXG3zqdfs9sf3N2AUYalO5DDI5093k4iUTLpGS6OVzUuSQXrNpyvFUqQiC6tTdD1kMUoWm+BE6CK8rCsJRhi6Fr+4kp2KYknForFhGB9OcMhSQavHt+GDW0ywgeMtjdrpEHPBo8rtTtt7Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=2n.com; dmarc=pass action=none header.from=axis.com; dkim=pass
 header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjQl0+IHt4PZpkS/8FkaxGD0472skfpg9ZxC19jm+W0=;
 b=plunWAZtemKDLhiDQksnp3zRUC7dZb/u6ITCFeLnux+JG1v+yYC7kuMTaRy7F8fe0mGdm2UNpWTs+Lgx38CSJg+G4AIzV26BxoTwjXnM+aZw4d/+WPbKrW72ZaDFSdI+EE2nAjET3gldJ6C07zNJpsoZPrFfHK2RuwGYe2Ft/uE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from DB5PR02MB10093.eurprd02.prod.outlook.com (2603:10a6:10:488::13)
 by DU4PR02MB11480.eurprd02.prod.outlook.com (2603:10a6:10:5ed::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Tue, 24 Jun
 2025 07:59:56 +0000
Received: from DB5PR02MB10093.eurprd02.prod.outlook.com
 ([fe80::2a25:783c:e73a:a81d]) by DB5PR02MB10093.eurprd02.prod.outlook.com
 ([fe80::2a25:783c:e73a:a81d%3]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 07:59:55 +0000
Message-ID: <56cc7658-0b57-4925-89c7-595d76f77064@axis.com>
Date: Tue, 24 Jun 2025 09:59:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/3] net: phy: bcm5481x: Implement MII-Lite
 mode
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
References: <20250623151048.2391730-1-kamilh@axis.com>
 <20250623151048.2391730-2-kamilh@axis.com>
 <20250623175135.5ddee2ea@2a02-8440-d115-be0d-cec0-a2a1-bc3c-622e.rev.sfr.net>
Content-Language: en-US
From: =?UTF-8?B?S2FtaWwgSG9yw6FrICgyTik=?= <kamilh@axis.com>
Cc: netdev <netdev@vger.kernel.org>
In-Reply-To: <20250623175135.5ddee2ea@2a02-8440-d115-be0d-cec0-a2a1-bc3c-622e.rev.sfr.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P190CA0018.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::31) To DB5PR02MB10093.eurprd02.prod.outlook.com
 (2603:10a6:10:488::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PR02MB10093:EE_|DU4PR02MB11480:EE_
X-MS-Office365-Filtering-Correlation-Id: ebdbfd81-40e4-4af2-be79-08ddb2f51bac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N1pJa2RTNjEvbXhUQ0tPYmNEY255M3hyMDhzUlNPcFR4ZnB5MFd5UTBLZER4?=
 =?utf-8?B?OEwxdHdnMndrY3NEamlmVm93U3lxR1ZPcnlGV3AxMEE5ZWRnTGxmdzZMVFJ6?=
 =?utf-8?B?MGhuOGxJd0tsSlVUb1hzR2k0R2lMOVVJTmUrUWxxUVV6KzV5YWdzSUQ4bEJm?=
 =?utf-8?B?dmRuODdTc3d6SWprdjJJZWlvTVoxSStTZndzNy9QVDBSbFBNVUtOemU2WFZj?=
 =?utf-8?B?cjZXRnRyNVZjMC9UZGdUS0ZpMVhmdEY4R1E3SUJUYVpRN3JzcUdLWVpnTG8r?=
 =?utf-8?B?b1UzejNCcDdpdXNmZmYwZU9VbnZGY2VKSFlUQUxuM1hkckNSNDhJT3VNQ3R6?=
 =?utf-8?B?ODNHdUh5TzVudG5aa0w1MEwvRUk5bW9JSXp0a2NCWmNnUThMN3lWL29OaVln?=
 =?utf-8?B?SEM1U1cwS2dTUnJkdkZpbW10eUMwcmZCTzk0bCtNWVpoL05mdWpzTUU3S2NK?=
 =?utf-8?B?eUxKU21iMmg0ODNKTy9LSk56MmF3UXVSRlRKa085eEFVV2ZuQzlaaXpEL25V?=
 =?utf-8?B?WFpwMnNLTnZuaUFzVE01Q1BhYWc5NHJHVWJ2TllPdyt6R0EzZjNlOUcxZGhQ?=
 =?utf-8?B?MGNFOFVTWTZ2MEx5OHMvS295cmhvaEtpM3R0UW1yYXBzZFlSSDlxd3lnVEhU?=
 =?utf-8?B?bEVvWHNWZUVEeFBYWGkwN20xQVhZWkY1ajNMa05MSW9sSlR0Ly9Ycml0Ullp?=
 =?utf-8?B?SjJVTmZWQ1g1MndpVDdUQzZob3cxWG9sMVh2YWI5dDNMZFNya2d5Skw3OGdB?=
 =?utf-8?B?NEM0SCs0OVhXdUwyUjBMMlZYR3pHZ3NxcW5CelR1UjVzTFNBNUpFOWdKdEtx?=
 =?utf-8?B?QlhvRGh0RzB1Z2FFZUJGcnU5dTJYZDd5ODB0ZDJmTUNvVnNvaG4ySnBCKzZK?=
 =?utf-8?B?YmF4bzZaUjltckplc1hWbWpYemlsWm84ckdJcGlFd29SeUtWbTNyNDRYelEr?=
 =?utf-8?B?OE93S2hqZG0vK0NFbTBPQXcraEtIakpuMXhTSGF5ZDF3ME9SVXlLd0FQaWpj?=
 =?utf-8?B?Skhaa293enlXaURrRW0zZHB4WXlDeHBsMXJOdkpCNk00SlFrNCt0Uy85YnNI?=
 =?utf-8?B?SDY1bU4veXE0cFlyQzBPUWlzWnJKejg2UFpJRmQrOXZ3cTdQcjN1eFc3T1A2?=
 =?utf-8?B?dTByeHg2MUltRk9hWUUrTHFITkxSbXJ4NGl6c3BGSXJPZU1CRDEzSXdXZ1Bx?=
 =?utf-8?B?NjRHcUFpMDVYM1FYdFR4OExkUFgzZkRtTVdnbi9yTkY4SUZJOXhrcjhUWkln?=
 =?utf-8?B?ckJOMStpeE5LRGY5VHlJRkJlTEQySE9lTE5WSXdmdnhLR21IaHowaU1FZjVS?=
 =?utf-8?B?MEYzYkpWSnkzNXRBam9DSGJKbUR3OUl2VEhKTDdreEFyNk1Kamg1c0ZJZi9Y?=
 =?utf-8?B?RHFkdTlBOFRKMVN5T1BsWm1VeVJidk5uZ0FGcTFyajlwM3BTRjZFVGJWTTd3?=
 =?utf-8?B?LzdhZnJsY3Y3R1dxNlYxY3MrTHJwWW5QamdFNnNvMnJ0UlRYUWtrSzRONXFP?=
 =?utf-8?B?M1BqcG4rL0l1VlV4U1pFQ1VGREROQzBiWFJCTHVib3BzVmNaQTRtSEIva2V6?=
 =?utf-8?B?MHI0QWo3Q2JsOThBZlFKZDJ3NjF4dThFdzExWFI5VloveDhNeGkxeWZMbDRJ?=
 =?utf-8?B?MHlIdktSbmtOeXh3ZS9yTXgwQkxVSTN1Sm1BNElod3FiNnZtZ3lrZ0tPVWdr?=
 =?utf-8?B?TXFIZXBkZW9ZVUlwVDJnTlJaR3pNK05wdkVYYW5ZRVk4Nndpam1yNkJRbjlm?=
 =?utf-8?B?UktwWDBBK3VzQnhabTkzaUphRGRoalpUdUQ3Y0lQYUVpY2VrMVhyZ0lOL3h1?=
 =?utf-8?Q?wss05v56LQJUAaxd2KGsSFCIZJGZocpdbDT+c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10093.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d052STFQZElWdGlEbFcrMzJhL21vS21qc2dGZzY3ajVFYU02cnErVG16UFU1?=
 =?utf-8?B?WmpxaWx2RTVvSUpRaHZ6VSt0YkFRcDVDL1l0Wk12bTdMaFc2bXJSRGdQY2hl?=
 =?utf-8?B?TVk4dGx5am1RTjI2UEJwTUtWTkJyKzNvTlZHWlUrTmhPeHd1UnFjM0FodzUy?=
 =?utf-8?B?cFU1WUN6dWo3VnVOcGNGN3lwZjExOUZ6dWxjN2YvWTFZYWhOSlhsYTczalF0?=
 =?utf-8?B?TnMyMzhwYWhmbHNRNG03SXVpdS8xN1g2Si8rREd5T2tpeUcvaHA2VHIwZUpj?=
 =?utf-8?B?a1ZvZmtPYXYybEZTSzVOdWhWdGlScnd6RHhoMkxIaFhoYXAxSFM4bVBkVmdp?=
 =?utf-8?B?TXo4dm1lWTNORyt0UlJhdENCNW55ZnVZK3IwNzg3RFlxakV2TldVMTJxMVVX?=
 =?utf-8?B?d3dMSURZVXdnWk1tRlphWUxMMDBBeGNob2E3aVR2QWJEYzhUdXk4WXlFUVhF?=
 =?utf-8?B?MHdXTE9wQUxFREtubEp6TXB5ZTFIUmFiQmlGNE5iZVNaeGp6anlIaSs2aEpX?=
 =?utf-8?B?OWxZZ3p2TTBCOHJJK2ZWcG5zOFg5aGVCN2lDTHdYQmZjTmZrWlZRclBnZHI5?=
 =?utf-8?B?Vk5tOWJsbTlDQTM2T2lzWVJNRzJYdVZXOC9QYTVXQjJRWHZSMFZyVFZ2L2xZ?=
 =?utf-8?B?SzUxMnFuTHJaN1hrZ0J5K000V1NTSEtuZFhlcjBSN0xrb1RYcVJwVFg1UWFP?=
 =?utf-8?B?OHFVclVlZDduV2l3YXJNWXlMSSt1WktpZDcrRjc0VTFSMm5LUmhTMjlnRVhy?=
 =?utf-8?B?cnJFWVZSNSt3ei8vNGY3K0MxVldzNTRpRmh6VXU1cXNkQXBzSUR2N0hIaFEv?=
 =?utf-8?B?QkVJQzBqTTdmeHdaZ25VenFVS3A2K2I5b2UxTnFYRFNkeTJqQUxoZlJKQVpN?=
 =?utf-8?B?MjcvTVVKc1o1NmtyazFxWjFMNUpwZFlDaGdvOWdrTnRTcUxZTU55VmtJSHZY?=
 =?utf-8?B?SEJSRVNhS1BGYzV3aEQ4TUJSVnpKUXowcXVHWHVzU29KNUkyOUdHcTJWN0s2?=
 =?utf-8?B?eTR3UmNKcTAzbzJGdU9rMkQwQ2hObHdqdTRXZEJhK053VjNTbTNvdDI5STVI?=
 =?utf-8?B?MThPa1B0RjlrVGNvRnJpWDFWcDc3bGZnc1N0S0srMHVMdnpHYXh1MnFHR29M?=
 =?utf-8?B?MkdUVVVZMm0xUFNObFpiVXdLRGVOSW5haElTWG0vVG4wZWJDYnFyREJoOFFV?=
 =?utf-8?B?TGVpVVN1N25BMUpNRm1sbWpNL0pXRGNXYXBmVU9UVlZCVlNmTVJJRXBITERp?=
 =?utf-8?B?d1h6c1RMZW4zeGtTZVgzRWhJL0FxYXkzemJPWWZmSmNqVzEzamNMcGJDYXp4?=
 =?utf-8?B?SDllOEo5bFNTNThha1ZUZjdYQXZNeC9XOUI3K1RVbnNJUXJqc3NPSmtSNms0?=
 =?utf-8?B?WkR3clZVQnNDSld4OHVkeUhVbURUYnMvTzNuOUZHMEhZMkVDT2J3WlQvSmZy?=
 =?utf-8?B?UkxQd3phd240MGJYSVd1M2QwbHlLSFhBMHMvTTVwTWFiNC9JcExkeXZEVWdl?=
 =?utf-8?B?Y3N5cUxUQnQ3bkZDZDBYT0oxdE0ramRYMnN2bndmeFFOUHc2S0JSaHdVQVFH?=
 =?utf-8?B?RVpkMWNKQmZwY3htUHQyOHpPNFpHakVtN25GLytrR01lNmtXVjhYOE56OVFo?=
 =?utf-8?B?Y1paNlJUOXlQeG1rMnlyTkI0ZGhWR0dlNGx6aXUvY2JHeW9mcjRVc3lOZ0ZR?=
 =?utf-8?B?Qk1SZ3prU2FIeHVmemxBd09VWE5UenBFaVd1ZFQvOHFBbTVENjFHNVBRQ2c3?=
 =?utf-8?B?dXI3d0xpOUk4ZTFwVGhhNWp4ajdhd25XRllaa25HdmFIOHNTdkRMUDFtbmlx?=
 =?utf-8?B?OFNteHl4cFlTTjQ1UE52L29oS1NEUFAweFZ0aWNScWdKODdqK1o3WWNiRVcw?=
 =?utf-8?B?Mi9Ta0FUc2hYREFNZWpDNHZqbFRCNGdxVlVBVTVNczhaWnA4aHRWb2dGbVZj?=
 =?utf-8?B?WUJCb2JDVHVKcGkwWTZnMThZL2R4d3YzaHpZUlhWV2FyMllKWFdUeXFvS0pX?=
 =?utf-8?B?YTJDSXU0RUtucWVPeHhNeW52QlkwRmJDYkxNVm5KcE5BSGZEc1NPYU1rM00x?=
 =?utf-8?B?NXZDazlDNlV1Y09jd2NDNmVYQS82UUhVWHFqSWtYeS9yWDJua2l4T0J2bWVY?=
 =?utf-8?Q?iwncTFr3V3qIqrDrmh/t0YVMu?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebdbfd81-40e4-4af2-be79-08ddb2f51bac
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10093.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 07:59:55.9239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lpx4g4PZAW53S3UpotryM3WFzjX8IEj4j3KFwggcwhmry053j1YpWm+gf2TwELlr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR02MB11480



On 6/23/25 17:51, Maxime Chevallier wrote:
> Hi Kamil,
> 
> On Mon, 23 Jun 2025 17:10:46 +0200
> Kamil Horák - 2N <kamilh@axis.com> wrote:
> 
>> From: Kamil Horák (2N) <kamilh@axis.com>
>>
>> The Broadcom bcm54810 and bcm54811 PHYs are capable to operate in
>> simplified MII mode, without TXER, RXER, CRS and COL signals as defined
>> for the MII. While the PHY can be strapped for MII mode, the selection
>> between MII and MII-Lite must be done by software.
>> The MII-Lite mode can be used with some Ethernet controllers, usually
>> those used in automotive applications. The absence of COL signal
>> makes half-duplex link modes impossible but does not interfere with
>> BroadR-Reach link modes on Broadcom PHYs, because they are full-duplex
>> only. The MII-Lite mode can be also used on an Ethernet controller with
>> full MII interface by just leaving the input signals (RXER, CRS, COL)
>> inactive.
> 
> I'm following-up to Andrew's suggestion of making it a dedicated
> phy-mode. You say that this requires only phy-side configuration,
> however you also say that with MII-lite, you can't do half-duplex.
> 
OK let's go this way. I was not fully aware about the fact that MII-Lite 
were actually Broadcom's specialty, only found in its two-wire Ethernet 
PHYs.

> Looking at the way we configure the MAC to PHY link, how can the MAC
> driver know that HD isn't available if this is a phy-only property ?
It is a very special case, because the Broadcom two-wire PHY would never 
go half-duplex in BroadR-Reach mode. However, it is capable of "normal" 
(IEEE) modes as well and in such case, half-duplex modes must be avoided 
with MII-Lite. I doubt anyone would create a hardware capable of both 
IEEE and BRR modes - it would be difficult to do, perhaps only using 
kind of hardware plugin interface modules.

The MAC driver should handle the situation properly (and the imx6ul SoC 
in our case does so), considering the unconnected MII signals are 
inactive. These signals even do not need to be put on external pads and 
pulled up or down.

> 
> Relying on the fact that the PHYs that use MII-Lite will only ever
> setup a full-duplex link with the partner seems a bit fragile, when we
> could indicate that this new MII-Lite mode only supports 10FD/100FD,
> through this mapping code here :
> 
> https://elixir.bootlin.com/linux/v6.16-rc2/source/drivers/net/phy/phy_caps.c#L282
> 
> Besides that, given that this is a physically different MAC to PHY
> interface (missing signals compared to MII), one could also argue that
> this warrants a dedicated phy-mode.
So I'll change it so that there will be separate MII-Lite PHY mode, only 
usable with Broadcom PHYs. It would be possible to wire other PHYs the 
same way, at least there seems to be some support in Marvell, Microchip 
and Texas Instruments ones.

> 
> Maxime


Kamil

