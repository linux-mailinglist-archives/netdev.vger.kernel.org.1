Return-Path: <netdev+bounces-195681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 193DBAD1D0B
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 14:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC5991888478
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 12:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996A41E1E1C;
	Mon,  9 Jun 2025 12:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FKTTT6T3"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272C11C8604;
	Mon,  9 Jun 2025 12:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749471540; cv=fail; b=nF8s+1Z9c72lCO6P9s0BcB0hsWGdVaoYUDp3yh0av8HX2R4QkH8E570VaCVWkAv6X+Crnllf8IAA4cdVAyBqxo5oXrPOAuBRR7Ev7kzHfxVoey+Bb2sOyjfw507Qwpt5Kg1G9snATtKf7mPfAC67jT7rRik79vjva5u9ZfCGtbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749471540; c=relaxed/simple;
	bh=utnN54yYd4GERrO5J1Teq+Txq0ic0oXr2XF1C8IUDGc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q7qi0Risyh/8Gfnew9JvEgTwqHJCC+fzNg7kVjY8vW9xXRw4JdTrpx4FLp4ycRz0m/BO+rwP8cWGXApSydmdwoXz1o5XwOcW/42MbnqSDigsptzfBV9VloPDVwHB2nbSrlBtC3KjD5oTDlkBDPoV7rgqc+uXlWWrer2lyYQgRtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FKTTT6T3; arc=fail smtp.client-ip=40.107.244.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pbsB9LuWfOeFmXfxUDuCPMokaToAgizVNNb0InquIb1DYFjnygozt+Ep4DFA/bH5TiUF/4WrT1trbTKLbDWhT2dTpZllPSdNIJd0DgsvwlabhZQcS6gbRTyo9NzJE244tnQFauDW1Xe0L1jTNlp56sitGqxIRYunw3ovyQYoZ+if0yShGI8ficZpmEXxzg6gj+PqgBHE/LQHVz2hllD3jLGiee8qq8CcXIKclppQYwPOWIuNVHeu77wHACyANUe6XbIqwzMaB7hkAnQ+CC6ynAYiHSOZbnAWkYDpHLkesA1wnjp5t6wZiQOGKh9iIGljU+6UKR6n6f3F4o0CL3eo0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7vOVNtdwRoda1ixRjJ84BEzUzXiwACzEM1U2ph2UUKs=;
 b=D0VFWEC4r5g13gmoIueeh6AijLyhCcTo3rJF8aq0ZPMUJ4trEk9lsV52NDGnVLvv7PakRhGoh2dhzxobeBI69pL1gzQf4BLAFsGkS2YnrmmBf3PpnIqojeudVbsnQHXOp4XcwEKiSxt9aQ2CEymcHavNzcrv03UyKJWKrKezSJsqvtNgYjz/kA/MpC3s+xy8jTgGoCdyNHNs9mlLbH1t+8WTUzH3MTiLmlfcESfJnN4Hqg9XeVIHN6keLFJ64rWmZqwG0BPvldyhRGkm0uh0lT/azgE8GN3zoHgsSbEAzyhgDratKZksQ1drODvAlRTbWsV5L8CQiobicx3i79itaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vOVNtdwRoda1ixRjJ84BEzUzXiwACzEM1U2ph2UUKs=;
 b=FKTTT6T38S9f5KVA4ynr48z3u1Sq1K85WyVW6wBv7a+Rxv/Xtng0HsnDzuBvC8A5AFTvPKyojiqntnIrdGJQZ0nMukjhmRqwoMkm4KnklC4Jr3g5fWpqxaG40JthwV+5GtIdheumeCO4RFzLo/laxqQaohO7rQhxNY/Xb4GLzC1w7anI9YnKo4OCWs9sMcmlHM8gZAwicM34XuV1cf+uFgQUKj287MwicKeE8Sz9wXBEaw7vyDOjNN8MKFYnYTuvZc+2fH+ZHVa3pw+GfoAguXlEZ1zQjPv3CvYB7TnKHbHFS9wtAyRpHvdPH42RjB3new+OStHxgc02zTnhbATY/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by CYYPR12MB8872.namprd12.prod.outlook.com (2603:10b6:930:c8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.39; Mon, 9 Jun
 2025 12:18:56 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.8792.034; Mon, 9 Jun 2025
 12:18:56 +0000
Message-ID: <fd48f64f-dec2-489b-a9b9-dc1aa38ca61d@nvidia.com>
Date: Mon, 9 Jun 2025 15:18:49 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4] net: Add support for providing the PTP
 hardware source in tsinfo
To: patchwork-bot+netdevbpf@kernel.org,
 Kory Maincent <kory.maincent@bootlin.com>
Cc: andrew@lunn.ch, kuba@kernel.org, donald.hunter@gmail.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, willemdebruijn.kernel@gmail.com, kernelxing@tencent.com,
 richardcochran@gmail.com, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 maxime.chevallier@bootlin.com, linux@armlinux.org.uk
References: <20250519-feature_ptp_source-v4-1-5d10e19a0265@bootlin.com>
 <174792123749.2878676.12488958833707087703.git-patchwork-notify@kernel.org>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <174792123749.2878676.12488958833707087703.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0002.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::8)
 To CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|CYYPR12MB8872:EE_
X-MS-Office365-Filtering-Correlation-Id: b6e2deb4-5a39-47de-313a-08dda74fce30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ditaUU9Zakh2MnJTUUNQQlcwcFR2OU1HMWNNOFVsNi84UkV4cUhEc1BZcnN1?=
 =?utf-8?B?NXBqaUM1d1R1WkhycGpWVDlUNmhLRnJicEp2QzhMNGwxVnRvZnRNM2M3UkNB?=
 =?utf-8?B?ZGhwNVpYbVRhT3FyRGRwT09ZUGZsVlZuWVBuekNub2RqZ01YV0U1bmQ5M1Jp?=
 =?utf-8?B?RllWTkljb0s0Q3ovZTFsWDhUS3FLSzFqZHNyVUlPSXBUNmZkNzZzLzRaaGh3?=
 =?utf-8?B?VUcrTEdHWFlibkZ3WnUvZldtbVM1cmJQSnN0L3Eyd3lLVFF0K2pXRlZwd0xn?=
 =?utf-8?B?TFVtelV2b1d3MnNUVlJNTzZkNitsLzZiVEYzNEVTSExKMzlLU09iWVFiUU1q?=
 =?utf-8?B?M3I0VFVQNWMvSGgzVFhLTGFuMnk2Q01KWkM5OGF1K1UwcmRBQVFzcjJBYWIy?=
 =?utf-8?B?SUxjVlVUL3A2ay9ET0NOY1V4bzhjMkY2UXA3bWRZWnppN3JOY1Vjc0JaRkl4?=
 =?utf-8?B?UnFMVmg0b1Q1dWhzNWc0aUR4T2N3dDlMVTAxbzE1TTgvdEQ4TGhuYSs0dm85?=
 =?utf-8?B?N3U3T0hXbmNYT2s5cmZodFk5eFpFMHF3TXVqVGJla050ejY3VDZqT3c5MTRo?=
 =?utf-8?B?S3ljTnFRMUZLMXdtRVpBK01NeGdpaEdJOUF4UjFQT3cxN3Nia2hpNVl3OWh2?=
 =?utf-8?B?WDJnbk04clFSMXpxVkVOWklkSlczZjBkdHoyT0dwM3VvS2ZHUkVDajh5MDVt?=
 =?utf-8?B?V2RSMGl6c0I1cG1oYTNDbUhiN0QyNGN6dm85V2h0QVFEVitzRStac2RnVGZX?=
 =?utf-8?B?RWVOeDFaNi9GQWRRcW1FTm5jNk11RkhUOGNkQU5uU1lHYTc5UTJLL3lHVkJi?=
 =?utf-8?B?aWJvckFqNHJnQ0Y2Z0NDcUkyZHpEWTRzc1h5RFFnNnE4WnhDNEo5cXdIRzNV?=
 =?utf-8?B?RWZLWGdubVlsanNwVUk5bHF3TkxndTg0RWc5V256VWxTZGNDd2ZDSTdzTklP?=
 =?utf-8?B?TzIrU0RVR3NUd3U0UCtIaXpzNmNVRlNjOWQ1NGVLalZ0RXRPRW9HREsxUHFz?=
 =?utf-8?B?WGpsODg5cE5WbFQrZStwT3Z4azZWMmw1bFFiRkNEaGhMT0xyQzVqbE1qMk5W?=
 =?utf-8?B?b1NmMlV0ZGhTMUFRcUE1bWx1UGc4MzdzSDhYZkV0eUNnMXZlQmZXN2lBT1VI?=
 =?utf-8?B?c3NUVnVWd3Rpei9UZkxHcENtZStCWWZzMGpZRmJ4SVlmZEpXRzJlbWgxUEQ1?=
 =?utf-8?B?MGlXN3BqR244R3R6b2JONWFqSGEwZitXWTdSYnhSNURObW1IZzB3cHhmaFNu?=
 =?utf-8?B?cUlvNWZFUDd1R2U4YlY0U1RxWVBneTFOK0h3SUVqdnZmdjJiWTFUU3FJbnBH?=
 =?utf-8?B?Y1YwZERUZlNEUHJZQnpEa3B4VVYvNk9QaGZsblZFdExnT1gvUGs4cGV5V0ti?=
 =?utf-8?B?Y0lCanJZVjdYQ2lKVW5DdzdtRTNIRy9pemVKa3R3bWZKUVFxUCtkQ3VPdy9i?=
 =?utf-8?B?RS9jL0V1ZWJpMkI4RFJITGkyQldZNWR1YmJEWC91ZnhKaXA0RlZjK05PWVQ0?=
 =?utf-8?B?a3ZrdDZhNkZDbm9LTDUwM1JmeWdkLzhvYWc5SHpwaVEzSHFoSkpQWlh5UDlu?=
 =?utf-8?B?UEtKZzFKTm9GeWRLclZ4SlhkeGlQUjhCb3BpdzRjVXNiZUkxOU5JclBCaFRq?=
 =?utf-8?B?SEU2d2lwN3ZpSUtMMVkrNVVhYWhMelNrL0paY0txNHBzOEVhNTNlUWt3eWNU?=
 =?utf-8?B?RzhWcTNLdnRmZzZBdlFZelhlZ3JCZ0h0dzdkNzZnNWgyNk1pWnFXMGpnQ3ps?=
 =?utf-8?B?QTY2ZUp3STNhdnZZay82YmtQOGVMSjlnU0xvT1ZOd3FtNHBnQXl0eE9FMWZF?=
 =?utf-8?B?QmNCV2x1MmR2MEgrTFUrbjd6QVkzbkcydHFIcUdRTDYyNHN0b294UXVjb2xo?=
 =?utf-8?B?dUtxSXJKMDFhUW9GQjNScEdhY1JoSXh5Y2VxcFBWT2laWGhiWjVtcStIdGRa?=
 =?utf-8?Q?hxUe3zsSD4o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjIvYWNtNWNTRkx1R2EvUnFVTldGajhsTk5DbUpiczljVkpyTzNaK3BiSUFj?=
 =?utf-8?B?eVZML0ZzRDB6bVR6ZzVOWVZjL2NoTTlNbVNQek92WGFYY1k0WU1kYUk2Tzd3?=
 =?utf-8?B?MjUxam9LMGpKYzN1Y1NrbnBUaFR1MUZIb1JwdjNDTnFycmVScXZwZ0U2UEE2?=
 =?utf-8?B?VXpTdGdydVVDaDdmSHdsVGhZcFN0VklZN1FZUzBDRUZSckpDek5NQkE3N2lp?=
 =?utf-8?B?QURUQXNoaE4yejZLdWdjb1RDOXJyeTVnU1VweDZJbDJqNlJDSmJQRStzSHhV?=
 =?utf-8?B?OHNEeUFQSG9TODFLTzRaOHNvVVR6OUVwTTllR1Y1VlR0RUFOaEhZODNmWjhS?=
 =?utf-8?B?U2JvVTQyMm9PdkFPRGdRODg5U3VmY0dIbnIzTTJoVHkzcE53QnYvSzAxWUdl?=
 =?utf-8?B?TmlPajFhRGk2czVGSlFleUttc3FpV1VpK3BzL3M3bVNBU0hBSlF3S2l3VjVp?=
 =?utf-8?B?K2NwSXRhZS9yUmN0QWFIaVhzLytsdEp5UmtuQVQxYUpIQWN3dnJXRFF0TEdX?=
 =?utf-8?B?dlc4L2RJTHZ4SjM0NTd6eHlINmNiVkw3b3NYdlR2L0g5L2ZtY1Q1YUhBWHYv?=
 =?utf-8?B?OTd6OGticnVWckVmcHVVVzVsVnk2enJCd1M2TkdqZzNlNnI2Y0l0NDZGeHFi?=
 =?utf-8?B?WERMV1ZJNktCRTZxUTkrN0hLQklGS0NnOXZYREIwTk5QU2RSRC9hcGg2UDRB?=
 =?utf-8?B?bDRXN1JRS1g2eWlhU01JMXFmUnhObWFEdm5BaUN2SWlVR3JpUVNzemp6RHlu?=
 =?utf-8?B?aXpWK1N1Q2tGaG9yeEo1dEtUZWN2cy9qVlZKY3hNNVdGaXBFUkx2Zm5QTVp6?=
 =?utf-8?B?L2g5dG4ySk9LTVMvSHQ3NGhXNFVJSDdsM1piNmJSdkdac1V0a1laQlRYWGd4?=
 =?utf-8?B?MWVnLzM1b2R6bXlWdWNBQlhGaTRrajQvYnFXQStkRlFpQzBneTJ6M3ZuMDhn?=
 =?utf-8?B?eUpHZlhQOW4zZ2FFSWhMTkMvQVFkSURQZ0tHVGU1QitERU41a1dmS1VrcEJk?=
 =?utf-8?B?Y0VlNC9LQnlBaTNWS1hvdzZwZk9CYmxwWjZsbUxyT0I4OVFOeUxZR1NONWE5?=
 =?utf-8?B?cWUrU08rSnFDK2psY2VBL09QK1NRT29CRzUzU09JcGJsallaR1dKTzExQWMv?=
 =?utf-8?B?TnZSL3ZaSnhINnpMMjk4ZTEzYVVoZ0haWkhVZEVTMlg1M1BpL0dQb0JwcnFQ?=
 =?utf-8?B?clAyZ1BFYStiSFFha2U3UFVPNEpvUjNyOEkvZWg2OC9qQWhHWXhKWkU0U2hh?=
 =?utf-8?B?bW5idjNoaU40S0piaHhTeWxGWnpaajhIdWRsaU15TTVBY2U0eWJ0dVVaUmlV?=
 =?utf-8?B?UmVPTkJocEpBcEZWcldoMGpNQnA5Q3Y2RU9CUnRnUGo2N01TSGxxeDB1QVE5?=
 =?utf-8?B?eUxDK1djYXZKTzJVSmxTdW50N1JTNzJDNG05Zzllb3hjT05zTmd0WlFhalhK?=
 =?utf-8?B?Rno5MEJCS1VnaEJnRkk3OXk3UDFNcW0wRFVyZ2Q3bkY3YjZqdXY0K3FTbExB?=
 =?utf-8?B?c1BrdXRNWUMwcWUwQU0venNSUU1CYURudHpzMkUva0ZOZzV1S0p3Y0doK1Iz?=
 =?utf-8?B?SDdEenJZSXRmS1psdFR3Z2w0aGUzZEFMb3RMWUJNbVBSR1ppbEFnbnVtUE1j?=
 =?utf-8?B?RHNhbmN3SFJjc0lBWlQxR0kzYlRIZW5MNWpMRlR1YkgxaldNZ1BPNmc0a1JP?=
 =?utf-8?B?Y053WUtXS3psMm1MQWliYXpoeDZoTmI2Z1NwbG9jcWo3OXBXTzdtbjZJVWR6?=
 =?utf-8?B?TG5zUllMUjFQdkdVeEhuNUJCaEltOGgreUNiNEdIWnJ4MjNBOExSZTJQbEVx?=
 =?utf-8?B?RjFXSzZJbHcyaEQxU2Z1Mkd4cG5URkNkOUdnb2NWcFpFbVRrUDFnVXlCemhW?=
 =?utf-8?B?cHlNVWF2QmtXTmV0Nm4rUlkzbnFNb09udkNGT0xaejQ3Z2hIeFlKcE9rb3U4?=
 =?utf-8?B?RVlQSjlBT1poMTFtTVBwODh1MnBnNXEzUCtpczNlWUl6RmlpRERMS3JkKzd6?=
 =?utf-8?B?RHRBUmhOdS9remhnK2pKMk1HYUdqUVlDaWF6WmhVTFlqSGlFdW56aUl5eUFi?=
 =?utf-8?B?emRxZGhXd3N4UTFYZUt0elFWVUVDR1hDYlBySk03N3g0YkVTMThIaEFTT242?=
 =?utf-8?Q?YdMyXcmxG7M+IDNVRewf6RWgH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6e2deb4-5a39-47de-313a-08dda74fce30
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 12:18:56.3137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fCwezbWxNWymHs5VBK62d5qDIDWOXwpRGqUL5BUndUS0ScPyDK0396lAN7DCWAXS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8872

On 22/05/2025 16:40, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This patch was applied to netdev/net-next.git (main)
> by Paolo Abeni <pabeni@redhat.com>:
> 
> On Mon, 19 May 2025 10:45:05 +0200 you wrote:
>> Multi-PTP source support within a network topology has been merged,
>> but the hardware timestamp source is not yet exposed to users.
>> Currently, users only see the PTP index, which does not indicate
>> whether the timestamp comes from a PHY or a MAC.
>>
>> Add support for reporting the hwtstamp source using a
>> hwtstamp-source field, alongside hwtstamp-phyindex, to describe
>> the origin of the hardware timestamp.
>>
>> [...]
> 
> Here is the summary with links:
>   - [net-next,v4] net: Add support for providing the PTP hardware source in tsinfo
>     https://git.kernel.org/netdev/net-next/c/4ff4d86f6cce
> 
> You are awesome, thank you!

Netdev maintainers,

Was there a discussion about merging this without a selftest that covers
this uapi extension? Is this considered an exception?

Thanks

