Return-Path: <netdev+bounces-240076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF75C70244
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 17:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B8AA83C4E80
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 16:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE0E354AF1;
	Wed, 19 Nov 2025 16:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="NY2x1+ca"
X-Original-To: netdev@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazolkn19010000.outbound.protection.outlook.com [52.103.43.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34C92036E9;
	Wed, 19 Nov 2025 16:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763569828; cv=fail; b=Zs8vuizdHe0gdipSNqx1nLgytSFU0432d3QGzyhnm4kePJQ+N/vKBdVzHIEoFZ9vGEfRa1PGQsZb2vVHQtfsKRgSBmvNmrZs77pSccuN7zckbmJYJAoL8ElczhjO4V514+eNbzyTA3SosS71IddxYfWXzoQjx9OFIootsgebiZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763569828; c=relaxed/simple;
	bh=7o1n5+QQXwoYjq0QWl6XjtH3G10idbF/pvACg86tSXU=;
	h=Content-Type:Message-ID:Date:To:From:Cc:Subject:MIME-Version; b=UpIKxe0jM/2RQIgfHIuiK1QiIrvHI7Ym2eVmEQ8+h9UirHpYONHxdoVMfnB6YxOggpfJW7kI2Y3M5eGoMItPsE7EKbX/JeKhmI5S+TJgVId8yyKMZqV8BS9lE8xJY5LQu4bszk2GGXe3Vw2BwU2YZzF09fcz5U4kBwDjmUeKOsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=NY2x1+ca; arc=fail smtp.client-ip=52.103.43.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iNaJHnSIEsE6EHa0JPrsG4LAokEe6Ka4PZ4f2SVUfamBoTU2N/ZGqDpvmXdjx2EQrrkHhMiHwD13we7oAOz5yoOA7N6grJivf2YP+SAh2s5Ky4mvvuE8PBulgQ8KOtzjW9dTXVWPhZSH8u2gPaEY7pCzBe7gRZ7Enu9L04rXUDBGk6/mdeBcs9oO1koONNQK3PcoQkBLA4YevPegXenLvS8dSJ5jSEpqEpNgrkAEFsxsrc9tW8yMPapDbYa7ODQ2aZLsv3SXhtEXmYI1D1ZVgsziRyALNUzTxUk5utvUB8FgmR05+64obiDg95dkxPhJe85N/YSyQJcrjenr97EJ1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7o1n5+QQXwoYjq0QWl6XjtH3G10idbF/pvACg86tSXU=;
 b=JvgeFAe6UqKTkmKsrw1DOvoJqAnBV5btwSad623mQcnKhcx6FFSYEhpdKr3/hSKFEz1VOJb1HPDpq/WblnhgMGlOWVWpldeVuZSAldQ1xEKwCHKlM7axLQNFsUegXoQLT+Hv7RRv+zV//mQu9a8qITMYskF8RPy3AGChl57YcIBP58Kwyly0nFJlXXZLnAuLXVud5lc81rBPzPXpDgw4yTMUbHiwvanUkpLapBS0hqJG6OKlzcWTiemJRsWU7CrDV/dKJ26pf32yUTEdVh3Rpz4fig1tQSILfCZc0AJfPVq/sUjGCElUSWDyBoVRurDxPNnXmdRySMzilajEN1h2qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7o1n5+QQXwoYjq0QWl6XjtH3G10idbF/pvACg86tSXU=;
 b=NY2x1+caF5gZLg+o/Y6DSimOsN8VvuMgD0lvJI09h2w0yVPtKJEBHPIXpkcpLbHZVesak3PfWtavP8RXms08TOhohyXe8UewcHm1DFsK5djQuFTuz2pETn4Bnhkesy/7J/LPNU4WbRhVqInxCm8hFkKsaLyLZbPyBvOHAe1HHlySyHi5fWbBnreTEl6VWYR/53RSlT0M2lYUvcX4koQ7otDaEjYFe5Ty6qjxbjugrZ5k7kbPtBxsU8XLKztaWcp7mPr6LVfpQnALTssFKfE8mQvUg6xhgJVfZyx5nHnzCUkdsVWTH/mCLbN9U5Lz4TIMu839WDEcZs2JREgoLWCm6w==
Received: from OS7PR01MB13832.jpnprd01.prod.outlook.com
 (2603:1096:604:368::14) by TYRPR01MB13688.jpnprd01.prod.outlook.com
 (2603:1096:405:18d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 16:30:23 +0000
Received: from OS7PR01MB13832.jpnprd01.prod.outlook.com
 ([fe80::b2a2:7807:bbbd:6021]) by OS7PR01MB13832.jpnprd01.prod.outlook.com
 ([fe80::b2a2:7807:bbbd:6021%3]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 16:30:23 +0000
Content-Type: multipart/mixed; boundary="------------a45N3gQJuVyRgbn7xlidSkF7"
Message-ID:
 <OS7PR01MB13832468BD527C1623093DDDA95D7A@OS7PR01MB13832.jpnprd01.prod.outlook.com>
Date: Thu, 20 Nov 2025 00:30:18 +0800
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: edumazet@google.com
From: "He.kai Zhang.zihan" <hk517j@hotmail.com>
Cc: ncardwell@google.com, kuniyu@google.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tcp:provide 2 options for MSS/TSO window size: half the
 window or full window.
X-ClientProxiedBy: TP0P295CA0036.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::15) To OS7PR01MB13832.jpnprd01.prod.outlook.com
 (2603:1096:604:368::14)
X-Microsoft-Original-Message-ID:
 <3ac5eefb-8ec7-4d4b-95c4-fa0d2b308e01@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS7PR01MB13832:EE_|TYRPR01MB13688:EE_
X-MS-Office365-Filtering-Correlation-Id: e0e7ab78-e802-4a35-2c0c-08de2788efff
X-MS-Exchange-SLBlob-MailProps:
	4VtScROZs23XvIi5DIzhfzL+3unNh/cClnG4TSfl6zASLxw8cDsMm3hMmjAIsPDUkdMSmOsbNOiejjP4ztZC1l1DQh3QUSnffq/BQbmGgViVX1tToYQEM9pZkjhjf9awmrKSY5jpwB+nhmhbHDzU+TXwRTkkRBBDpLeSemKcHrBm2PAeeyAk3uc2n/+fmNW3kdw4GILz6+X71aeCNqR9IVaolrbfay4ITXlAB/shL2Snu8a2cwZjmqbEl5yQHlCVnG8zOCLTOZe/X2xipn10TYM2Z+fPQJRAUr/Iwbnz8pkbXZn0RN+Ixg9gbrhHB8GTSlnEJLs+rn84F8AwGOV8MgL3ihl1Fw9FpsXx+ZFiR2Dm3S9YJp0DKwYRejk09DYA5KymT+m9/y5Gff2LmCQawwv953PKCQoQypt3nKVLUL1TufqhS05uxQG7+RT+FWUsdTO61nTSXtxPO7zzu4yw54LKOm8khHFJuFMeLkNBWi8b8w2QcvtNBHLw5UCBgfffPXLDS6b4y9rzrzp+5GEm8tYchPsW2TAMzoQ/e27QfaBw/wPPZ4JGgojZMYfrqMRONhiwXaLJo+vDAvIiKcRCo8PqmiNL2thjPRHynsknih0N/nOYOaVLd/1xqRVkexYMcb6Bep4BflWLAPkzGZfa4ENUpGpf8qZ+q1p3Nu+PkWUBdFb7ddONsw==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|19110799012|39105399006|12121999013|15080799012|23021999003|6092099016|440099028|3412199025|40105399003;
X-Microsoft-Antispam-Message-Info:
	3y2vpLJKa0EVMdFI61yDhwmTJDtH35aSajfXLnAUiCZVBx7eg7C0vut8G0+MfmUnvnbQEw/bYgnfT9RhacsgMNbEFf/xYz/j0BcfefoHe0EKcAb2g2ggh9nS6H6BqmSZ5pCtenCAxO8+uyNHug++65OqTpYerUuUVB8kJKZiv+ZnDIPhLKy1ctlXoxDEObf0gRv/ZTfdzSoq/6zR/X/ZjeDglnDfLXvIIjw4y8fyWIi9kp06V7EwNF71VaS29yUiSYmpsWCOv94ez2jBPnWK07mktGXQ/3moZcNvRRQFNAIHFn98d/a0FKL+b1zHhWqdBeZe8w9s0g+3j+xIvkOYEJoR0i6kHL2wpNPoYusEb/MBXGbiwqE1NyzXQVJ/7KWg43yELoCAA33/SeDW2gGW2Qhr2UV0yJxC0wBTxnhPrMa4+vkCCb9bAhyB58/ToyOp35WYC1AEoKtr4vUJ2/LjLJ4TnIO3uKdooqHIUjjTO228wme/ApcU+Wudua8yRraPmG45RO5zFa6QBu61YNMyeJRxn41A3p9BLtwlTq4EQlefdgeJA+eWahwZt4ChcZVKtIU+djGEW4H4Nzux8UHBak+Y2W2NvRet78dcNERv3O18A1VuimTJ7qlnF6Ze8VEQRjItFl+DqlvtV6SkGwrOuB9wO5Bgfz6vn6HUboOn/gUzfM0ud3IEGIWQrlGylnELyq6zaxOFKNpgN0hpHGzeMmwIzGW2XxhdV9uySQA8eZqVjxbvJhHwdRpQgwwHbLBMdyQlrLG2Wi8jJEZDuMdezO0+CFSTmHf+CgwLrOhuXISXCxVHHgjz9eYxQYnzaAWnskrvEIV1SyqedekUDGRkLuyeG2soxb04SfIaALsNKxEPRX50FviL9Qn8ddt8zUr/DzRrtqBXl5Y+rDKQtsX5MctGffa3t/LmTeNoFMA5nct8fG9Ses8KtwdLvU9DWE/b
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RkNWU3BmNk1ENG43ZEpzYTg3ZXZyd1VCTTZ4Mk15dll2TmhwQ3FmNktzdHBm?=
 =?utf-8?B?Wk5wcFVlelBRN2VFazdkQlUraGdDS3Jab0FNRjhKYXhWNm85L3JkS3N2ZGhC?=
 =?utf-8?B?bkJNb0d6RURVWVh4K2puVlRjNlNtbDJSY2ZRVWQzN0hjTnNHV0JOWS84Skta?=
 =?utf-8?B?VTlwWU9JdWtua1NncXlhdnBhNzBBaGdHNzI2aUF0emZZanFJUXVXZVdKN2dl?=
 =?utf-8?B?RTdiL0Y1aGNDK0VCUGlzaE1kcnlldEEvZjRLbExUM1d0aWxhRUZhV1lLclYx?=
 =?utf-8?B?T0x2MUdmczBSOW9yeEJwU1E0VkhmSElYd3g4dURRTEQ2QVhZQXZMZWszTXV2?=
 =?utf-8?B?VTJ1R2ZFNGpzMlFFQTh3eTU5UnY4MHNkSUVVTlBHYWNqcmZlR2J0NXl1d2tO?=
 =?utf-8?B?c1NiQWx0R1JmUGRYdlh1dGw1STdWd0ZLZ1JYejBXTlNCTHdiNllkbzJ1UW1w?=
 =?utf-8?B?aWI1Qm85UnhJalRSbnlJREpscitmNndkRHZYaTNtdzhvendaQk9rZ3dyM3pz?=
 =?utf-8?B?T2RjMnl3WUxSZXF2SGVQMkZBa2VjMm5zN3VJcnl6d3hQejV5Vk0rVHBKQmE3?=
 =?utf-8?B?V2FlRGZ1VVNQRXh2V2o1RVJpcUQ2b2NMZFFQcnpxemU0YUw5SE5TanE1YWtT?=
 =?utf-8?B?OFBxem9WaVYrU1dQdEVLQUpXeG43dUQ0R2hWS09rKzNDNDF3MnpueTdHSjV4?=
 =?utf-8?B?QVdwMkJHZlFIbDFZNnp5U0FIMWREYkdmUGtCUFF6M3BFU3E0Y1BJM2V0YjBv?=
 =?utf-8?B?UEF4dXlFZ0ljNUFhQmdDZHNuMlE1YkRVQWh0VEVrUjAvakJyZlZvdXEzek56?=
 =?utf-8?B?bkNhQkJMempxQjdvOVpqVFpITnZUWnIrcnRLTUpOSjFQSU1FTWhJWHMwQ1U2?=
 =?utf-8?B?NGRYQy93S0VUdEN4VHczbmp4d0RRazhaVll4K3BvbDdEdThEbnI3TFhKTXRH?=
 =?utf-8?B?M2Uvd2s4Y1dhT2dPRlEwa1pyVEFURm5KYkNtbE5BQk1mNlhkcHovNTU3T0hy?=
 =?utf-8?B?Qkg4LzY5VUowWk92V29PNytlM28wbnNuTEx3T1k1M2YzclJYOWdqRWtxbHBV?=
 =?utf-8?B?VFczTklYYlJxbzl1VGEvbUFWcTZRSFVwVXRGdXhqbVpqLzB6ajExTDU3bTI1?=
 =?utf-8?B?WEJ3NDZBbmt5YnNYMUcrdTFabWh5YktEdlhHZVJPT0ZxNDFXdWlkWWZFTTYz?=
 =?utf-8?B?bUpPVU1JemwvbnM2c21vbEk5c2EvNnVpS2NhZXlZTEtIQkYzUlQycjVKTWE1?=
 =?utf-8?B?aGxNdG9KTGZldWNJMC8rTnpDVGZ4YW5LcExTK2VuK1Bld2d1cHMrbGEzUjND?=
 =?utf-8?B?ay9pYlVjaFRFalhWeUQzaC9uRFlZYjdJcFF1YWpLN21rR2VtMDZ0elVCRVZW?=
 =?utf-8?B?bFp6c1B1Nk1RSUxET3JjdnFwSWRjOGQzODhWczkrdlc2Z3ZDcWVBQmVTT1JN?=
 =?utf-8?B?MnNrSU5hN3BsRk9qVjZIMUNJU1JLYlk4RGtET3VyY3dONGl0eDhBeDZaZlNX?=
 =?utf-8?B?UnN4dUQvMW1UdGY1eU9YSEZIUk0rd0oyVW1iOWs4MTJ6eWxtL0RCVkQzZXZX?=
 =?utf-8?B?RmlhZkRHems4bkJVbGNWL09mMmFXTVRvUXJpY0xUMVNETFRFQ2ZCWU5ZNm5I?=
 =?utf-8?Q?CBydTNQatRjEols8BQJSNKNL6rdMUXYQgJ33hsflOwic=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-9a502.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e0e7ab78-e802-4a35-2c0c-08de2788efff
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB13832.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 16:30:23.0505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13688

--------------a45N3gQJuVyRgbn7xlidSkF7
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


--------------a45N3gQJuVyRgbn7xlidSkF7
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-tcp-provide-2-options-for-MSS-TSO-window-size-half-t.patch"
Content-Disposition: attachment;
 filename*0="0001-tcp-provide-2-options-for-MSS-TSO-window-size-half-t.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBkNjVmMGI4OWMyY2I4Njg1YTFlYmZiNzI4ZGM0NTczNmJkYTAzOGVkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiAiSGUua2FpIFpoYW5nLnppaGFuIiA8aGs1MTdqQGhvdG1haWwu
Y29tPgpEYXRlOiBXZWQsIDE5IE5vdiAyMDI1IDIxOjExOjI2ICswODAwClN1YmplY3Q6IFtQQVRD
SF0gdGNwOnByb3ZpZGUgMiBvcHRpb25zIGZvciBNU1MvVFNPIHdpbmRvdyBzaXplOiBoYWxmIHRo
ZQogd2luZG93IG9yIGZ1bGwgd2luZG93LgoKSW4gaGlnaC1sYXRlbmN5IHNjZW5hcmlvcywgbGlt
aXRpbmcgTVNTL1RTTyB0byBoYWxmIHRoZSByZWNlaXZlCndpbmRvdyBzaXplIGlzIGFwcHJvcHJp
YXRlLkluIGxvdy1sYXRlbmN5IHNjZW5hcmlvcyx1dGlsaXppbmcKdGhlIGZ1bGwgd2luZG93IHNp
emUgaXMgb3B0aW9uYWwuIEZvciBleGFtcGxlLCBpbiBsb3ctbGF0ZW5jeQplbnZpcm9ubWVudHMs
IHdoZW4gYW4gZW1iZWRkZWQgZGV2aWNlIGhhcyBhIHJlY2VpdmUgd2luZG93IG9mCm9uZSBNU1Mg
c2l6ZSAoZS5nLiwgMTQ2MCBieXRlcyksTGludXggY2FuIHRyYW5zbWl0IGEgZnVsbCBNU1MKIHRv
IHRoZSBkZXZpY2UgaW4gYSBzaW5nbGUgc2VnbWVudCxyYXRoZXIgdGhhbiBzcGxpdHRpbmcgaXQg
aW50bwp0d28gc2VwYXJhdGUgdHJhbnNtaXNzaW9ucy4gSW4gZmFjdCwgTGludXggY2FuJ3QgYnV0
IFdpbjEwIGNhbi4KIFNvIHByb3ZpZGUgYSBjb25maWd1cmF0aW9uIG9wdGlvbnRvIGZpeCBpdC4K
ClNpZ25lZC1vZmYtYnk6IEhlLmthaSBaaGFuZy56aWhhbiA8aGs1MTdqQGhvdG1haWwuY29tPgot
LS0KIGluY2x1ZGUvbmV0L3RjcC5oICAgICB8IDMxICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysKIG5ldC9pcHY0L0tjb25maWcgICAgICB8ICA5ICsrKysrKysrKwogbmV0L2lwdjQvdGNw
LmMgICAgICAgIHwgIDIgKy0KIG5ldC9pcHY0L3RjcF9vdXRwdXQuYyB8ICAyICstCiA0IGZpbGVz
IGNoYW5nZWQsIDQyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9uZXQvdGNwLmggYi9pbmNsdWRlL25ldC90Y3AuaAppbmRleCA1MjZhMjZlN2EuLjlk
YTdmNTI4NyAxMDA2NDQKLS0tIGEvaW5jbHVkZS9uZXQvdGNwLmgKKysrIGIvaW5jbHVkZS9uZXQv
dGNwLmgKQEAgLTc3Nyw2ICs3NzcsMzcgQEAgc3RhdGljIGlubGluZSBpbnQgdGNwX2JvdW5kX3Rv
X2hhbGZfd25kKHN0cnVjdCB0Y3Bfc29jayAqdHAsIGludCBwa3RzaXplKQogCQlyZXR1cm4gcGt0
c2l6ZTsKIH0KIAorCisvKiBCb3VuZCBNU1MgLyBUU08gcGFja2V0IHNpemUgd2l0aCB0aGUgbWF4
IG9mIHRoZSB3aW5kb3cgKi8KK3N0YXRpYyBpbmxpbmUgaW50IHRjcF9ib3VuZF90b19tYXhfd25k
KHN0cnVjdCB0Y3Bfc29jayAqdHAsIGludCBwa3RzaXplKQoreworCWludCB0bXA7CisKKwl0bXAg
PSB0cC0+bWF4X3dpbmRvdzsKKworCWlmICh0bXAgJiYgcGt0c2l6ZSA+IHRtcCkKKwkJcmV0dXJu
IG1heF90KGludCwgdG1wLCA2OFUgLSB0cC0+dGNwX2hlYWRlcl9sZW4pOworCWVsc2UKKwkJcmV0
dXJuIHBrdHNpemU7Cit9CisKKworI2lmZGVmIENPTkZJR19UQ1BfQk9VTkRfSEFMRl9XSU5ET1cK
Kworc3RhdGljIGlubGluZSBpbnQgdGNwX2JvdW5kX3RvX3duZChzdHJ1Y3QgdGNwX3NvY2sgKnRw
LCBpbnQgcGt0c2l6ZSkKK3sKKwlyZXR1cm4gdGNwX2JvdW5kX3RvX2hhbGZfd25kKHRwLCBwa3Rz
aXplKTsKK30KKworI2Vsc2UKKworc3RhdGljIGlubGluZSBpbnQgdGNwX2JvdW5kX3RvX3duZChz
dHJ1Y3QgdGNwX3NvY2sgKnRwLCBpbnQgcGt0c2l6ZSkKK3sKKwlyZXR1cm4gdGNwX2JvdW5kX3Rv
X21heF93bmQodHAsIHBrdHNpemUpOworfQorCisjZW5kaWYKKwogLyogdGNwLmMgKi8KIHZvaWQg
dGNwX2dldF9pbmZvKHN0cnVjdCBzb2NrICosIHN0cnVjdCB0Y3BfaW5mbyAqKTsKIApkaWZmIC0t
Z2l0IGEvbmV0L2lwdjQvS2NvbmZpZyBiL25ldC9pcHY0L0tjb25maWcKaW5kZXggMTI4NTBhMjc3
Li40MzY1ZTMxZTggMTAwNjQ0Ci0tLSBhL25ldC9pcHY0L0tjb25maWcKKysrIGIvbmV0L2lwdjQv
S2NvbmZpZwpAQCAtNjc5LDYgKzY3OSwxNSBAQCBjb25maWcgVENQX0NPTkdfQkJSCiAJICBBUU0g
c2NoZW1lcyB0aGF0IGRvIG5vdCBwcm92aWRlIGEgZGVsYXkgc2lnbmFsLiBJdCByZXF1aXJlcyB0
aGUgZnEKIAkgICgiRmFpciBRdWV1ZSIpIHBhY2luZyBwYWNrZXQgc2NoZWR1bGVyLgogCitjb25m
aWcgVENQX0JPVU5EX0hBTEZfV0lORE9XCisJYm9vbCAiQm91bmQgTVNTIC8gVFNPIHBhY2tldCBz
aXplIHdpdGggdGhlIGhhbGYgb2YgdGhlIHdpbmRvdyIKKwlkZWZhdWx0IHkKKwloZWxwCisJICBV
c2UgdGhlIGRlZmF1bHQgaGFsZi13aW5kb3cgYm91bmRpbmcgZm9yIE1TUyAvIFRTTyBwYWNrZXQu
CisJICBJbiBoaWdoLWxhdGVuY3kgc2NlbmFyaW9zLCBsaW1pdGluZyBNU1MvVFNPIHRvIGhhbGYg
dGhlIHJlY2VpdmUKKwkgIHdpbmRvdyBzaXplIGlzIGFwcHJvcHJpYXRlLkluIGxvdy1sYXRlbmN5
IHNjZW5hcmlvcyx1dGlsaXppbmcKKwkgIHRoZSBmdWxsIHdpbmRvdyBzaXplIGlzIG9wdGlvbmFs
LgorCiBjaG9pY2UKIAlwcm9tcHQgIkRlZmF1bHQgVENQIGNvbmdlc3Rpb24gY29udHJvbCIKIAlk
ZWZhdWx0IERFRkFVTFRfQ1VCSUMKZGlmZiAtLWdpdCBhL25ldC9pcHY0L3RjcC5jIGIvbmV0L2lw
djQvdGNwLmMKaW5kZXggYmEzNmY1NThmLi5iZWM4NTAxYzQgMTAwNjQ0Ci0tLSBhL25ldC9pcHY0
L3RjcC5jCisrKyBiL25ldC9pcHY0L3RjcC5jCkBAIC05MjQsNyArOTI0LDcgQEAgc3RhdGljIHVu
c2lnbmVkIGludCB0Y3BfeG1pdF9zaXplX2dvYWwoc3RydWN0IHNvY2sgKnNrLCB1MzIgbXNzX25v
dywKIAkJcmV0dXJuIG1zc19ub3c7CiAKIAkvKiBOb3RlIDogdGNwX3Rzb19hdXRvc2l6ZSgpIHdp
bGwgZXZlbnR1YWxseSBzcGxpdCB0aGlzIGxhdGVyICovCi0JbmV3X3NpemVfZ29hbCA9IHRjcF9i
b3VuZF90b19oYWxmX3duZCh0cCwgc2stPnNrX2dzb19tYXhfc2l6ZSk7CisJbmV3X3NpemVfZ29h
bCA9IHRjcF9ib3VuZF90b193bmQodHAsIHNrLT5za19nc29fbWF4X3NpemUpOwogCiAJLyogV2Ug
dHJ5IGhhcmQgdG8gYXZvaWQgZGl2aWRlcyBoZXJlICovCiAJc2l6ZV9nb2FsID0gdHAtPmdzb19z
ZWdzICogbXNzX25vdzsKZGlmZiAtLWdpdCBhL25ldC9pcHY0L3RjcF9vdXRwdXQuYyBiL25ldC9p
cHY0L3RjcF9vdXRwdXQuYwppbmRleCAxNjI1MWQ4ZTEuLjE3NzMwNzViOSAxMDA2NDQKLS0tIGEv
bmV0L2lwdjQvdGNwX291dHB1dC5jCisrKyBiL25ldC9pcHY0L3RjcF9vdXRwdXQuYwpAQCAtMTg0
OSw3ICsxODQ5LDcgQEAgdW5zaWduZWQgaW50IHRjcF9zeW5jX21zcyhzdHJ1Y3Qgc29jayAqc2ss
IHUzMiBwbXR1KQogCQlpY3NrLT5pY3NrX210dXAuc2VhcmNoX2hpZ2ggPSBwbXR1OwogCiAJbXNz
X25vdyA9IHRjcF9tdHVfdG9fbXNzKHNrLCBwbXR1KTsKLQltc3Nfbm93ID0gdGNwX2JvdW5kX3Rv
X2hhbGZfd25kKHRwLCBtc3Nfbm93KTsKKwltc3Nfbm93ID0gdGNwX2JvdW5kX3RvX3duZCh0cCwg
bXNzX25vdyk7CiAKIAkvKiBBbmQgc3RvcmUgY2FjaGVkIHJlc3VsdHMgKi8KIAlpY3NrLT5pY3Nr
X3BtdHVfY29va2llID0gcG10dTsKLS0gCjIuMzQuMQoK

--------------a45N3gQJuVyRgbn7xlidSkF7--

