Return-Path: <netdev+bounces-196513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E887AD5168
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 12:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22D9C3A73A3
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 10:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F29267389;
	Wed, 11 Jun 2025 10:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="iJv/4jh+"
X-Original-To: netdev@vger.kernel.org
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010015.outbound.protection.outlook.com [52.103.67.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E586D266B4D;
	Wed, 11 Jun 2025 10:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749636793; cv=fail; b=ANNVum1iqbF5bbWbSzbvbqYR4FjKc8S3pDcvu3Fipqdez/3p0WPAr6XM2FxzleiAuBtSsr69e314/Y3rZnmpYkJ6MdArkaWX7qDxz0WOHFyMyT6v8PjyRRsOHtwYBvU/3tdrVACsMPQsi6HEyib63y3yNDGuSpb4n21yYn0FK+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749636793; c=relaxed/simple;
	bh=BXBW2mmcZTUKDt48FBdpe6I7xW0+k/dFDcWUg4mxbP0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pZJuPJ1LgcEW8zUUcnTzNQDG0Tr99wN9q1V9tvbnzC4cWaVzGBfQEs9wWXMuSEiDeyw6SVZgzpDwP7nZHCVtK6mPR8KwaVuECrXTX9TwliM8co6MQONaJZefPspkWwcmfpSjlEJN7Z7Lo8oEji9J9bBsBJOWtvtxDuTU7m36Wfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=iJv/4jh+; arc=fail smtp.client-ip=52.103.67.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SEERgXS/iybr/trzFxn/yFOthaDTPdrs9U2tH+a2w8wCbLk13ZvIzKzao2aVXDIWyFQ7Sj8AS9h96TxRqdli4KhdyRT1RnoteAKtuSPf0XP07Iv38l4kaeq3iMdHC6kTt9NTQDUfj09q6eYg+c8RyYSequI/s5o9zhCk187ojeG0VYPYTdyNTNYSWJ5wQTZC4n5pE/Z6/q6vi/wjpanPYs+4jWAzpxQa4CttatOMXD6MQtK+KZkHThpeV7bAFkN/k7f5unhFN84MgKs9XHmRc1e1WzATmMJwNBrnTXQFR71zND7TN+46MZcAK13t1u8OUk5O1BL6snlemMAi4+1ttQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bc5GnLQvKshopR5BhyFce7Km7Niua8YcZnpMMU7naj4=;
 b=BMI3ca39DrNAjDeB3zlzP1TDwIrWcqkstfr1DQelex9VYFR00x3a821+ejhzjeiyDrkq9zQ+zS/w4bXcT1HF2JqiYYGPX4uvdQkyVMMUEHC/kPMDmwGZRSQPuhwTmouA3M92Rdblb+XFUc/W56s39cYHToe+HNAnf+uIawUpuWngfenwkTS2tP6pJhsxxqtk6O+y/6DAX4X9vk7uVwcGPlScKIiectfRKEECr1sUDn1H54Qd832q6IQJya7ixEwimBK3DP6sfTHymzcKYh9IwLLuHly44cCvvhHEdN0MhJKUVd+vTKZd9cQwNI0/A5s4SqaINbIpWgfeplpYuIug3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bc5GnLQvKshopR5BhyFce7Km7Niua8YcZnpMMU7naj4=;
 b=iJv/4jh+4VoLi1W/gC+m/8pa2woUtGqkO0SWx+NtYrfzSbEyKMOYRB8hVMcW6NKCjp8eUeQnIEZTznR1dAiev5X4hKnio+2oVJSC3d+N2ZOJP4bwBV1xmjGK50PVNE1EKJewcC2qC+21oF0XMkwR0gweJRC20NE6M8uAkLk5UN4EnoU+iztM1qE7kh5Vn232wUYzqnB7ddcjQREVcCtB8qJKLFcQrQz34MmcauR76UuA+VGKQMn0wFXZWn3u5SAhTiMvQOHH02Q4bLAmilGRrH2YtX3WsDdjQvocMZA+hL+0WxVDBCG3zEIUhHYmhs7wOjpRnHD8k03Bwmz4SqhzJw==
Received: from PN0P287MB2258.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1c0::8)
 by PN3P287MB0227.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:d4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.31; Wed, 11 Jun
 2025 10:13:01 +0000
Received: from PN0P287MB2258.INDP287.PROD.OUTLOOK.COM
 ([fe80::b63f:e256:4db1:2e9f]) by PN0P287MB2258.INDP287.PROD.OUTLOOK.COM
 ([fe80::b63f:e256:4db1:2e9f%6]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 10:13:01 +0000
Message-ID:
 <PN0P287MB225839D83F1A65D65D3EA6B9FE75A@PN0P287MB2258.INDP287.PROD.OUTLOOK.COM>
Date: Wed, 11 Jun 2025 18:12:54 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next RFC 0/3] riscv: dts: sophgo: Add ethernet support
 for cv18xx
To: Inochi Amaoto <inochiama@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Richard Cochran <richardcochran@gmail.com>,
 Alexander Sverdlin <alexander.sverdlin@gmail.com>,
 Yixun Lan <dlan@gentoo.org>,
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
 Ze Huang <huangze@whut.edu.cn>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 sophgo@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, Longbin Li <looong.bin@gmail.com>
References: <20250611080709.1182183-1-inochiama@gmail.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20250611080709.1182183-1-inochiama@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0003.apcprd06.prod.outlook.com
 (2603:1096:4:186::14) To PN0P287MB2258.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:1c0::8)
X-Microsoft-Original-Message-ID:
 <1f0798cc-84bb-4e40-a78b-bf2c12c0d29a@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0P287MB2258:EE_|PN3P287MB0227:EE_
X-MS-Office365-Filtering-Correlation-Id: 719a302a-0fea-41fe-55d5-08dda8d08c15
X-MS-Exchange-SLBlob-MailProps:
	iS5pQZgsAQCkRkOLrFZHmNZlYAGaqKxl89Ofu0p+FfuD2rIBIAZasrask3DPwC07pxo1elotNgvvCtlr7zWNf23SpIPgztfvtny2lT2hpyUt8lWCyoeTpNyqCHs9NxH7w5km2LMjHDMnguA78xElEtgElNpcFMDcMeWF30W64xdhIbIGu12jLKvecZ8PlyBf+2q1/GYC4PJxeErkWp8sKWKo5ft9QzNEVOtWjumSYA+2KVWBy6YAMY7hlHMvLYvipJrQEceycu6pUeg7ZF8bv3Gbwh6MZrdapC8oJNFIzXLoawaKjbd0kSVB1FOJ4fr+2CwTPTN0mPUmWQHwa9pQtwqtmfVkparM0lruockwyN1gqx7UmTOwaHgWuB8qPYCAuGhfm4QA/lxduIp4JgMEH1fgC51PDUh5lLtMmARIEWg8VmuvK8wKEabLtcYhwqkYJytP5wbQ7JVELwMuqK4sBG6aybq9Qq2/aUlqIRye5rNkQmvxkKcO2jU8S6x8FqBxAUwGo4rS1aww1wSjEIWE5mHzZ0aLQvU9CRyOH3AwByTOLgHtx9oi8KhtbKrU+VZl2Yjwba96cBL2b7RJ7G3Tvu1dp4zU+Zmb6C1Qv7K5wPB2tB+Ufbj5srOTYQ/evibGCN6ooq1GGpQemnf/mABaLaATpHuvnTOOFijmaihhR1vRY2nV10+36Qh38i1sWlkCLurRYtZSay5bYi5UvC902fXMm8MQJNGxT/GB5T1r9027CHN9zbpju/6Xjd8JhfKz6aUNlDQr1Yw+J9rtzO12XLtEqi/G/C9DtPc+bBhboyJF/mQSa9m1thTuZi8JWJJ1
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799009|19110799006|8060799009|5072599009|7092599006|461199028|6090799003|1602099012|440099028|3412199025|4302099013|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZEtMMVU3U2tXQnEyT2dpcGY3b011ZkdMTmI3SGxrMlZ4RnVPdHhJZFVLWUx4?=
 =?utf-8?B?MFFIQTlaM2tJNHJLOXdONksrYjJmaVQzNisyaW5aRDhSbXQ5SVNFTGFLKytT?=
 =?utf-8?B?WXhqQ2RQRi9HR3l3akorT1VWd2ZoUFVyQTFXcTNMekpmZ3J2MGZ2ekY4c2wv?=
 =?utf-8?B?cTd5TEdldjhFeW5abnN6K3g5YitQNi85MEVVSXZpQ2ZjWElyRS8zbWNwNVFO?=
 =?utf-8?B?QzBrd0FpNHFEbU1HTmIxckZzeE56ZDNlOGc0QmNJS1hrTWN1OUlkVEl3U0g4?=
 =?utf-8?B?a25NWHdtelEzMVZOWTdCOTZWMklHRWhITmZ4aWdzeS9qaHR0MHF5Uk9QMUJa?=
 =?utf-8?B?dGpMUkhoak5WNERFU2c4YW9UemExTnZGcFA1WTBkbU11VVRDTmtwVUk0ekpV?=
 =?utf-8?B?bW1jWWs1bkFpVVNpVzErTG9aNjc2bzZuMkYySWNyb3hMczE2ekFtajBzYWow?=
 =?utf-8?B?QTVZNDdTdFFYdmExS0dONE45clJFYkV2SDBwMmFIRUZmSWhMTmZ3WkJpbExL?=
 =?utf-8?B?R2N4N2ZtMk0yMnJZV2d4anl6YUU0ZTZwRkJPVWlwNHg1RkRSR2MvS0JBUjZM?=
 =?utf-8?B?dTNha2JEa1o3VlVKZlNpcS9nZ1FxWi9tNnQxK0hIZllWSE5GWk9KSHFPTWtr?=
 =?utf-8?B?aEdKWXpYTFpweWlYbHNHRjVRbmwreEZBdUxMeVdCcEN5ZmdGenFqbmlFY2NV?=
 =?utf-8?B?N094TEhnYjcvMXI1em94QnQ2WmhQdkpKUXcwa2JEQ1dQTldWcHp3V2J3MUZr?=
 =?utf-8?B?aFF4YW1HcWp3S1Bud05Cd1F0eUtMUUNVdzRXWXF4OVQycFVPdG4zaFhZUitP?=
 =?utf-8?B?SHJPNloyUGNaWFI1MVE4Y1lDcjlpUC9rbTJLdXk5YkNCRk5mQ2swRjVabmlW?=
 =?utf-8?B?YWxleVNoeFBlQ3htWUoyK2xGU0RPcEhPeHp2aDJCVTNWQzZXVy9UMEJXVmYr?=
 =?utf-8?B?WW5IUTNmVTM3ei9lVGhwQTlCSUxEN3RLT3RxcWxPUzUwQmw2aEYyTU9uUW5v?=
 =?utf-8?B?ZkllTXQxU0REZm5LNnh5TXB0QkV0Sm1RbTdHMnU4Q0RPL2IyOGV2NW0zN1JN?=
 =?utf-8?B?NEE3RUhaNm9DRk84UG5HaXdnY2pPQkhLSWVEMzF6K0x4N3lGeEZRZVNUZnQw?=
 =?utf-8?B?VHdUUGJrcjBVb1d0RUw5U0huTTQ5WUhlWjlJTXlnaG9XTWYxMlVrdEd5d2tV?=
 =?utf-8?B?dnJzN2h1NFlIaTFLcHk2OHhja2R6cGdyUXJLQUptazU2aGZnNWlBb3VyM3RC?=
 =?utf-8?B?YmNGRWxLb1dIOGZZTkMydm01a0FBTU9qNnNmdVRBdm5ZejE1MnNsS0VRaDI2?=
 =?utf-8?B?UHZURXZCWklsYUJTUUZ6NU5yVVdScWs5V1U3SXVzdThjaERRQlVpSjNCSklR?=
 =?utf-8?B?ZjJES1h0ZERWcnd5NUVpV1RrWERQQldvd3JHbW5pUCtzWGtwbmRZYXlpVTNE?=
 =?utf-8?B?R1N3Qmd2b0pjNkV5SmVpYzRFTzZaaWNUU3lYTGNtS2FDTE9NMi9IZ0NtN2pS?=
 =?utf-8?B?VG4vUnhBVnRHT3ZWWlE1RDJjTXlza3hqbVZNS1VhOU1haURuZkZjSDNCZ0Y4?=
 =?utf-8?B?QWRnZDFLbUtvcWlJVW9RNHJ4Ym5Na3VONzN6VHZnR1pnVmlDVEhLWmpUbWpX?=
 =?utf-8?B?WHVEVGw5TmxXbzJJU3JBTkNMdTNNTmZIVUVZMnAyV3VXMnUyc3hxQ3FQc3VH?=
 =?utf-8?B?ODVzcjA1N3k1ZUhjK2FkSmVMb3dHeVZvNEd6UFd5TndabXYvTGpQaTEzSUY1?=
 =?utf-8?Q?qJeOhJtYX5dWrY2TZcFo7/1bfszaX5YLsaUElL1?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmQzbUNnaFhFNU5FcjNNWGticzRIdDMzdG9GemFsTnlvc0tob0FRYmNHaklE?=
 =?utf-8?B?b3FNYmk1ZTJaMFY3TTdvbU5hMVZzaVNiRGRMOVNJelBNV1o5UXlMVjNIWVor?=
 =?utf-8?B?a2lzdzVjbnZ3eWRGS2Y0RklVekJpL3JKNU5VYTFHdG1LeTRrcHU3RFJwOWZq?=
 =?utf-8?B?MCsrbFFHV0VqSXRjVFNxbGxWM1p5eWxaZ1hSSzR2dTZ3c3JFOUJxK3hDM1RD?=
 =?utf-8?B?V0ROeXdzenFIeUNJV292NTQyMWxtd2U0alhmM0t2aEJDT0tFVWpTUFdCVDlV?=
 =?utf-8?B?ZGFPVGdDSjNmZHpyRXQzVlAvVE1NRDRUQ2d4ZU44d24rSTdkMWJkN0JhRW9F?=
 =?utf-8?B?STFKTTlYL1d1WFBFQytac3I5cnN0M0lmdGpVWGtPeE9VZWE4bEdnZXduK1JX?=
 =?utf-8?B?Zk1OZm5SS01HbnpWMSswT3FJRkZ4bWZFY3k1RSs0YzQrTEdvVG1abXl4VjFB?=
 =?utf-8?B?Y00vY3lzZmp4R3FXZlk1dzN0YWo5MUFPcXo4bjhFSkdLMm5tQzhXZUFqWDFQ?=
 =?utf-8?B?aUx0M05WN3R2ZTBOWE1acWVHMjhHSGtUQVdaWEx2OXZVNlRSVUc2bjJncEdK?=
 =?utf-8?B?bFFSb08rMEpKbVRJTFF3c2xOU0FIZVRldVhvMXkrMjBJdy9XZThMbVA2OWx5?=
 =?utf-8?B?RFJ1ZkpObWVzMDRkaUtYdlVqdnFJVjY5eGs4bytJVm9sYnNFcURpK3JoQVpI?=
 =?utf-8?B?aldoVnRldUVyK1JwVXNuNk0vL3hnQ3VJZVVrc0p0VWdHN1VTNnhDM1Fqa3BV?=
 =?utf-8?B?ZHluckpuTVIyaXhwNkFSTXd3RGdKU0tSWmNaUmFoTFhnNElrbnJNM29SbTZo?=
 =?utf-8?B?TVdkTDk3bDZGVG1sckRwbm5KckdjWStRSTBOaTFjTGFrZ3NtMFlRL2I4YUFh?=
 =?utf-8?B?YThEbFh0VVJoaHcyQVlPZUxZY1hPeEhsc2hFSkpSbkREajdkNVNoaUNRSXZW?=
 =?utf-8?B?cytIVU4yQjhpenpvdGhTdDNEK0RGRlpaUFpoYVJFb1YzZVpLcE9RWkdVdFVp?=
 =?utf-8?B?K2pKbTBnb0JSQSt3enJ4Q1k4NDBxQzErVnQ3c3dMWlVrRFIzMXk0V0l3N3ZB?=
 =?utf-8?B?dnUxMWxvNXFZRG1WcFhMZVhJUk1MTU52d2FIaUdqRml6Y2NLUUp3UThGaStE?=
 =?utf-8?B?T3JPWmxBUlI3RXpBZVVNbnIvL0JibmtrdzEwMzYxNzlCaXRBNnFocElVblAz?=
 =?utf-8?B?a0IrdUxobjN5VlJOWWZ5T29TVzNSc0NiWmJvNVUzSVByVmJTSnRuL0xBYWtS?=
 =?utf-8?B?NmZQVXl1cHQrdTFzMTFTNEZRdnZ4RWxpQWZwaVdubGdlZWo0ZUZzNm1SVnVv?=
 =?utf-8?B?Nzcvc2xjeEc5MjVqYXRtemZqYzZqTXNDMm1HOXQwczRUQmM1Y2UycmNBbUVE?=
 =?utf-8?B?dTk1RFBZNC8wS3RzZTZwN2d5ZlprUis3TmdJN2VpUnB4a2F3YjlSdGdFbS9u?=
 =?utf-8?B?M0pTRGsreHFNUHNIT0E1M1lMai9xRW5ZVTNtOWJQT2RMbGNQTzR6aSt4WTRR?=
 =?utf-8?B?RGxLc2wyNk1RZExjQjJSN3czVlhLeXgwZFJGK1VDcFB6MjFpa0I0Zi91ZUpp?=
 =?utf-8?B?UWk3dTFIekJGcTlMQ3Z6SUJBR3Bza2wrWTdPWHpjck5TaXlra1FvS1R1d2hv?=
 =?utf-8?B?aHV5SVhCb3NKV3hRMm1vZDBWQTQzcjNVSno1YitMcTVobUxsRFNrc0E4YzBp?=
 =?utf-8?B?ZDJRbW5pY1Z3UEJPbmdlVkQwNlhXdXQxcS85NlN2bXBMZW5LOXlmdzBXYVVT?=
 =?utf-8?Q?PMIgMICtQAoKhNXRhwrZ/gM7yPrfeEQ0Xge6lCf?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 719a302a-0fea-41fe-55d5-08dda8d08c15
X-MS-Exchange-CrossTenant-AuthSource: PN0P287MB2258.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 10:13:01.7326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB0227

Is it should be v2? I see an old one 
https://lore.kernel.org/linux-riscv/20241028011312.274938-1-inochiama@gmail.com/.


On 2025/6/11 16:07, Inochi Amaoto wrote:
> Add device binding and dts for CV18XX series SoC, this dts change series
> require both the mdio patch [1] and the reset patch [2].
>
> [1] https://lore.kernel.org/all/20250611080228.1166090-1-inochiama@gmail.com
> [2] https://lore.kernel.org/all/20250611075321.1160973-1-inochiama@gmail.com
>
> Inochi Amaoto (3):
>    dt-bindings: net: Add support for Sophgo CV1800 dwmac
>    riscv: dts: sophgo: Add ethernet device for cv18xx
>    riscv: dts: sophgo: Add mdio multiplexer device for cv18xx
>
>   .../bindings/net/sophgo,cv1800b-dwmac.yaml    | 113 ++++++++++++++++++
>   arch/riscv/boot/dts/sophgo/cv180x.dtsi        |  70 +++++++++++
>   2 files changed, 183 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/net/sophgo,cv1800b-dwmac.yaml
>
>
> base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
> prerequisite-patch-id: d5162144180458b11587ebd4ad24e5e3f62b0caf
> prerequisite-patch-id: 9e1992d2ec3c81fbcc463ff7397168fc2acbbf1b
> prerequisite-patch-id: ab3ca8c9cda888f429945fb0283145122975b734
> prerequisite-patch-id: bd94f8bd3d4ce4f3b153cbb36a3896c5dc143c17
> prerequisite-patch-id: 1b73196566058718471def62bc215d2f319513c3
> prerequisite-patch-id: 54157303203826ccf91e985458c4ae7bcdd9b2ba
> --
> 2.49.0
>

