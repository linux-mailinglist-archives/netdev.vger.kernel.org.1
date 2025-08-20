Return-Path: <netdev+bounces-215211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48953B2DA69
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 12:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03EBD726B31
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 10:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0334E2E22A9;
	Wed, 20 Aug 2025 10:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H8AHZ0qu"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FE219F464
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 10:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755687556; cv=fail; b=WJz2E+qhecTVLS4pnfJB6FUzkqQw/DCSTH4Luif1wnx1Nhtt1PZXCLmbuEj0u6cr5ZODuTLIYPbm2aBqbX07SLViM24u9X0LWIZes71XIFi/NyWy96xIOrAEFFYSu/Ayk/2slOfqtk6HLv9fJB2NGHi2KNQG7z5qDkY7EtA6kDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755687556; c=relaxed/simple;
	bh=KstH4QSJBA8RCFV2b1UvC55qpN/ec4v9Ta7s7rkD0SM=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=WOgtp+PDtcm6UMSVrpz6R5Y5XCVYhLU/H4rRVSS/J0DxDT0Wh5CqXJKsC4hK2ZIt0riHtCrr1cbCBHH21scYrxTRtoWOccsBJvwx8MyVGBMdiXz7bLEH5PTrKDSAqD+/HSkBkBHgOkbrR1516PNh3dtrG4X+oZgBLaaNYv+pce4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H8AHZ0qu; arc=fail smtp.client-ip=40.107.243.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OQRqz3Rhzn/PTU3BSJcnu/vET1QeGr66gSFqRNtU6B+bYD1Iwt3dkHf7JG2XDaj/GLhDhkjOebrQz23NlKgQ3idXBwqplx50VQLeR7Chufj1bIAgFn2NHGjI+1Oz5y1oAF5wfkWtDfT+J7MEniW5+6++hrNnDMISi50kQlIds9dDq5k7OEXsC1TaZiqqVX587MIPXTeSc9KrYhm73t3NMuj9EiuMaF8wqG0STp1DH5IglCJ0Yyz4AYNIhjRDddPwnP/sLMZPZKgi631MFcf6JKm3oh+OCkk44Mx5WRxeRkIYQyGqhnSCmF/Z/BC+2LssZ/N9Qgep76jd7JflMQcXyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KstH4QSJBA8RCFV2b1UvC55qpN/ec4v9Ta7s7rkD0SM=;
 b=HBjIAwMrLyXmNKtfIs042MJNmXGJQdeYtZV8vCLTmPaxAd6hwpBpnZ3fwRYlQw+TzxhfpGjXMY+xUOCNdeZpbY/AP/U1czmaadgD4tLPB0JJ01WqhKjSCa9JrCOP2PF39tRHMXZhTutmxcVN87kKCjd81wNDFK1YA+vGVk9i00dPiUeyzudxDln2hFgiom9mdHLJ3Qkp4NL0alq4hKAmm0mFntAMOHUGDuvCXpbVOJUKphyIyhQQNVvQ3BI9kEo1gOjsxYqDbGKkcVATfSprLOB7ArMqNefp9vs+GjUY6HoNMz5JDasTrIZi5RWIbVzhVW1zmfq0ONEOs8+rqq7wTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KstH4QSJBA8RCFV2b1UvC55qpN/ec4v9Ta7s7rkD0SM=;
 b=H8AHZ0qu8yDFUmTUt9ppJZL4AOZWa3EFG6BISNV3pLOgMpxd8wLEhxj6pODyrm+1MHuH5Nf0E42tLn8wqfhgLeMGmun4gT1vC3zxdM07bknjw/lPM95P9y8qY74si2Na7xzj3XaaG1TrqT4Y/RhOceI5zeNEP/iEJq+12FcyUVBxsA3ge4vhpUHL+wW2FWfZ46qgrV0Nv10EianGGWz9+GP9Ei69A5sMwzJ1PabziwOc5/cuE6yzSNDX7KVa1ej09vXablUPhSWq8lPKGSAofGOo76VHMCKWTuyClpMStzfDvhXrfCrnA5uSdvKpfHAcRLUcPTX5oSn3TchKtUctRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by SA0PR12MB4448.namprd12.prod.outlook.com (2603:10b6:806:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 10:59:12 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%6]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 10:59:12 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 20 Aug 2025 10:58:58 +0000
Message-Id: <DC77AGGJCR39.101EZIIV7OH5B@nvidia.com>
Subject: Re: [PATCH net-next 01/15] net: page_pool: add page_pool_get()
From: "Dragos Tatulea" <dtatulea@nvidia.com>
To: "Jakub Kicinski" <kuba@kernel.org>, <davem@davemloft.net>
Cc: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
 <andrew+netdev@lunn.ch>, <horms@kernel.org>, <almasrymina@google.com>,
 <michael.chan@broadcom.com>, <tariqt@nvidia.com>, <hawk@kernel.org>,
 <ilias.apalodimas@linaro.org>, <alexanderduyck@fb.com>, <sdf@fomichev.me>
X-Mailer: aerc 0.20.1
References: <20250820025704.166248-1-kuba@kernel.org>
 <20250820025704.166248-2-kuba@kernel.org>
In-Reply-To: <20250820025704.166248-2-kuba@kernel.org>
X-ClientProxiedBy: TL2P290CA0029.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::19) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|SA0PR12MB4448:EE_
X-MS-Office365-Filtering-Correlation-Id: 727fe017-0c73-41d0-c5c4-08dddfd89880
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VmY1ZnU3UDU2TTlOTnlpak92MlIrdUNVYW45T1F2MVdmTGJETUZ2b2t4S20y?=
 =?utf-8?B?NzBlMEovOHBLSWJnbnBUKzVHZ0cvWEN1d1BZY3NoYzEzdFN0b1lKcW9GZWpB?=
 =?utf-8?B?QTQrRW9IUjNBWCszQ0xGcmVZODhqQWk5YVA2MzNUY1g0YWp5YVI3OTVtTlM5?=
 =?utf-8?B?eEZqYW1oVkxNQmFoTnVVKzNQbDM2eXVqbnJEN1VnZlhyUUJXMTdURDhxNGJC?=
 =?utf-8?B?Umh3MlAwcThBbzVNTDhzbXp5engzZEdNcTNkc2JNVDZLeG52TkI1R1YzaXJL?=
 =?utf-8?B?TXNkOTFqS21LY2FVZkVlejFEVWo3QTVQdGlpODBDNVE4YkF0QXFtc2lrMUZx?=
 =?utf-8?B?cU5CbzNqMnFEcWtBdVNCR2NuWnlTcE95RlgzanRmVXVWSWhMWkVRN0V4ZWFo?=
 =?utf-8?B?ZGpFT3F5WU0rTVFobk91NW85eC81a1djZ3ptMGxHaHlXRFNqMzhURng4aUxM?=
 =?utf-8?B?cExYNnkwQitQRTl6NlFSQjlidm1KL1JvMXRQdFhEL040amJJYzdsTlJJZ0k0?=
 =?utf-8?B?RjFaa3J1UUl5YzhwTUJ2cWYvMkxOOEthaS9yMGRldFlJcFpsbGVsUnI3TEU0?=
 =?utf-8?B?SU14NE14YjJlelluRURQUkpncGZET2tiTG4rY2NLZmI0ZHY2cksvQThHR3ZR?=
 =?utf-8?B?NUtpeUpMcUVCSEN5czdteXYrZkFrRWhIM1h0TUZRUGFHQTNQTXY3UjRFbkZ0?=
 =?utf-8?B?Q0plS29reGoyYzJpWDVSYTR4dEoxSVdhQmxsWW90cmpQUk1kb2Z4QjVUekJy?=
 =?utf-8?B?czZGdVZqS21mVk5wYVhMWUhmUDVHaUZWZERuSE55SUUycWlkNFM0dEgrVnpK?=
 =?utf-8?B?d242YXRlRklGVVJvTlJGcG1yYlVvY0orLzVGNmF2UjNGais0YUoxcG1ZaEpp?=
 =?utf-8?B?M3podVNWOCtDaGtuRk9rQUI4ZHBaQTIxNmprZ0ZROGx2S3hXKzEzVmxGVHZl?=
 =?utf-8?B?Z1JJK2E5cXlHYW1NV1lBSERXaHkrVWJadUt5MVVXTzR0QXRxd2phM2lySXBV?=
 =?utf-8?B?Q21tbmdyUWlLU3JlbG1oSW01TFd0TXNEN3E4aU9YQmw1UlUxN0pKNHpHQmYz?=
 =?utf-8?B?QldSTytaN0RTNjVvVzBFS1hyWlI0N2hRYTNVTmNhM2FnZ3RYVDNXYWdiMWRE?=
 =?utf-8?B?Rm1xY3VFYjBOZ0c2aXNNY0EvbmdyZkQ1REFpc0ZveU1GSWU1UzVhVGJVcUlO?=
 =?utf-8?B?YVhqQUlzbndpMVhRYngxZkdTaFlIbUJVOVBybXpnUkRWOFBSajlUb2djRDNx?=
 =?utf-8?B?djQ1NHVXanFFQ2ZkaGxUdUFURGJlWWVTNjZFMlBYZFVQeC9DU282Qld6ZnQx?=
 =?utf-8?B?RkkxeXllUmJiQ3F0V2NrWUxyRktjUHlKMFA3SDNjYkdFREYzUFk2S2ZCemhG?=
 =?utf-8?B?eDR4czlCOFJnWCtaeVJHTkFSRnpRY1BvZXRnUlNJSWQvcE9sbm9CakZRNndu?=
 =?utf-8?B?TmY1ZzhCV0RlK285NVBGZW5tL0tOUVVrN2gzUDJZaVhKR3NkM3MwOXo5MUVl?=
 =?utf-8?B?QlpkUjFxOVRtUjcreXMxR3MrNk0zcE1UM21BN29XM2dGSHozcEorcFd6NmY3?=
 =?utf-8?B?aDl4SVFkSDJiVjczalBXZm0vZlRmTkk1VWxISW9sNmp6OGdsYW1PbitoVkpl?=
 =?utf-8?B?YS94Yi9Ya2dRelFHclpXQ3BydnNHRWtsRElHc3hibE1HWEcwMTdmcnV1Wm5z?=
 =?utf-8?B?dmVHcFdubTJSb1M5dml4OUQ5dmV5Mjl3UXY5cjFUZGY2bVNVYjlUbDIzT0NJ?=
 =?utf-8?B?cjlCenpjY1JUZ2pySlRoUEh6WFNDYm9LUjNjMW5QRW1MbDNGMkYrOFptRnBm?=
 =?utf-8?B?TTJTR28wODZpTFVCZFVUOWxzQmZqS3h3d0ZNMmU2eDJ5OVdQZCs4bjNuNlQr?=
 =?utf-8?B?akoyMUM4ZC9neEIwVzZGUjVVK0U1akZscTA1NFhLVDJRc1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWM0dkJKell5VmFvWnhqVjZxbVRhMlV4ZHhjV1VZTEkxbGYyeXBoeXFCSFFK?=
 =?utf-8?B?TlZ5M0NzdGZpTUtxblVNWGxKemc0RUxaUXhMMGpwZUNsWEcwQnFwcWlHZnps?=
 =?utf-8?B?bTYweDJqYmpwZ2NEUVZaVkpZQ284UFFXMTcxUUhuSWRDV09LUUZ3dHZwZXBZ?=
 =?utf-8?B?M20vdTBnOEEzd0FMS1hMekdFQmR0RFJpWXBGelBPSWpFazFITFNoYXpQYndj?=
 =?utf-8?B?TmR1M2JyaTlJUFZybExXVVYxdlRrTnFaVlY3Q1lyV1o2TUJ3ekV6eHBMVHVo?=
 =?utf-8?B?b1BIVHVQUmtYUEdpaHQrU2FFTFFzOXNsejh1S2ZLc3krUkRySHFObmZOOHpa?=
 =?utf-8?B?ckFoK0VoMmh3c2VQcWJQMUN3UnpULzFVVGk0TElXMCs1MEtRc3lNVE9YMzF5?=
 =?utf-8?B?RGtRdTF4M1FWNWFnMnJmQXZTenhyZ20wckltZFV5bHNzaWZ0ZzRORkRTOCs1?=
 =?utf-8?B?Q0hRSGVycnpoRVpqNXArUmVwUm9HWlh1Q0Q1R1FKd29sYmJ5b2tUVXBvUFNp?=
 =?utf-8?B?UmFnSTBRSkptZzlUS3poZWVkbXFkSEUzZTVuNmNLYVdxY1hObW1DNU1PTTF1?=
 =?utf-8?B?TXNrdWc0WDNMSHh4cDE0UnoyWWZnbGVIQng0QUtYVTNFR3JPL1pMaHpteThF?=
 =?utf-8?B?VXZPYWl5MzgxeHpuR1kveGg0OG9CME1tTGl2OXVsdjNleGFKUEM0OUFPTFps?=
 =?utf-8?B?aXhiSUF5Q3lIRVFhVnBsV0ZpQk1vZC8wdkpJVk9UYVBVcllRYzExSnJyOU1B?=
 =?utf-8?B?ei8rT2hEQUY2Wk1Dd1BCZEdNM053cTdlRFh3YTdtK0QzbHRoNzh6QXJHRTJ1?=
 =?utf-8?B?UHRBaDNrOW5RQXE2R3FvbkNkSmtLZXJkWmNDWC81Tm5WYjRhTXhQMk1BeHp3?=
 =?utf-8?B?bEx6YXFxRU1YbnBOaG9qdkZnOGV6cW56eHRZQUxKRFl3NTd3RXZHbWl3TnRV?=
 =?utf-8?B?QVRaTm0xZ1lqQWQwNGNxM2Vpa1Z5cW9IUjlRVjVJaVM2YVJCS3E2LzlodWlz?=
 =?utf-8?B?NDA2V2t6NkQrZU05cGQzYkd0ektlenE2VmN4VVJFMWI2OHhldzBEdDF3K09q?=
 =?utf-8?B?YUs3YXMzMDcyTVNobTIxL0VONXFTczJHL2dqSFF0dGxRTHExNjlBQnFwYzRB?=
 =?utf-8?B?K0lkcEpFem1mNWV4N1Z3aWVqWis4RWlLa1UvV1A4V25jcVc5V3pKU1VvdU1z?=
 =?utf-8?B?Q0R0UGNNUEFkMlZjUFZQUGpkQVVyQUI1RGQzSVBQR3Z0Q0w2eDNQZ0ZXL0Qz?=
 =?utf-8?B?NHJnZFZkeXBkQTlxZjZaK3diRTYwNWpmVm5PeHN0S3dqcENEVVFId2dYL00x?=
 =?utf-8?B?Q1BGaG5NakwzS0FhamVOTXhvTEUvS2dUWWRIZWxmM3BWQm5JQWxQY2p1YU9E?=
 =?utf-8?B?dzBIajVjU1dEUWpILzh2VVY1VE92cDRWSXFRV2J2TFJ0QXFOUnJrTFU3THlD?=
 =?utf-8?B?eVpqYkYzUFZFeUVhVjJJWXN0UzR4b1hqWHRVUlpaTXlGajMwYkRRUjg0K1Nl?=
 =?utf-8?B?N0dYaUtPSkJQZ3hjTnNHZ21UdStZYjg1M3ZoZWJ3QWhVSjZBUGNDUm5hdEJm?=
 =?utf-8?B?WVJadVpCaXAwVWVteVF5MXVMNXhIOUVwOHBHcE9mUFdHSmNGQ1VpVnp5cFRn?=
 =?utf-8?B?aXJuTGtWQ3lqRGlIcW5hdzlpTEQvOFc5aGwxYUxMcDRncUQzS3lFVyszMFlR?=
 =?utf-8?B?Y1BIN05MV1JRQ2tiWjU1cFFvMWdQcWxzNGNuTUJHblNXYVd3S2o0MDlSeE5t?=
 =?utf-8?B?TWQ1QmRLaFhYeVhtT21hRTFhcVRtSnpXb0FYcmxqOUlqVktDTXo0dXpIV0dO?=
 =?utf-8?B?c3VnZ00wN0oweW9KNE5CaUZnYzB5NWIwcFJaZ3R2WDd5dXNvSmV4ck5aZDdo?=
 =?utf-8?B?ME1KV1V5Vk94SWFjVURlRFNKM2x5ZVBGZlp0TnRCVEdTS3l6QVFMaEl1TVdZ?=
 =?utf-8?B?VjV1YTJpRHFmMm0zNWZqamZsblErMk1MTVpQNE5kRllQa203UUJWbUdVOGRn?=
 =?utf-8?B?aE0yaXVJejJ1QUYvNjI5QmVKRWQrNUJUeTlhNnJRQngwU2dramtkQTdySHFI?=
 =?utf-8?B?eTFjaFk2Y3B4dTl5ZmJ0K2JicE1TcVFBbHVIRkhpTWRyMFdRKzhrbHFBdW5B?=
 =?utf-8?Q?BfeKltFIhET1x0Z3Ipx7xUgLH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 727fe017-0c73-41d0-c5c4-08dddfd89880
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 10:59:12.2874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d9Hu2p/TGGjJq+7atWeXe7bK5piJKLa+eK2fjPmwL+b47l3xL6JVY5flV75Y0Qnfu4lpv+Up8nl1HvMEuQhMvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4448

On Wed Aug 20, 2025 at 2:56 AM UTC, Jakub Kicinski wrote:
> There is a page_pool_put() function but no get equivalent.
> Having multiple references to a page pool is quite useful.
> It avoids branching in create / destroy paths in drivers
> which support memory providers.
>
> Use the new helper in bnxt.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Nice! Will take a note to use it in mlx5 as well once it
becomes available.

FWIW:
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>

