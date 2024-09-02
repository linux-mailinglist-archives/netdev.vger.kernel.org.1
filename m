Return-Path: <netdev+bounces-124099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8FC96807B
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 09:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9501D1F2637F
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 07:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CC2176ADF;
	Mon,  2 Sep 2024 07:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="QR6Owb61"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2059.outbound.protection.outlook.com [40.107.241.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD12153565;
	Mon,  2 Sep 2024 07:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725261771; cv=fail; b=uPEpik3tTX0ffH5pQ1/K1FGDYjjKK0SZ76IIOKump/+gO6h072bZnm/jLLojbr/b+pGUuta4wVjH4R2tL07c06S2at2eGmt1RACabVkwfCoIBKCE0m1jiSHOdjZi9/WNY9+zRwLDrjDvIBT8+ogNb6X//dTNF0+I1KxJwf+LyQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725261771; c=relaxed/simple;
	bh=TWMN8w3i2RCpGXky4bZzYa2kuHy/9IrNUAH2HTY5WNY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lMJfw7G59HQ9OFD1FOUqh6IcxqEH/DapC+mwNyLVhAsq+pHQVCYyown/QxjhHSDHWORlNiuPZNT+yhjuytIdERHftJHrKZbwkEujez2Fed9TWnaoHghmepE0HR8vyPW5IpyMD2jrujwXcp4v8LWnboIKZt5G5o0FtKhudCIMk4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=QR6Owb61; arc=fail smtp.client-ip=40.107.241.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qs1nElcrOkuxR12xBh2SK+Eo20ZPaHQP9LHZJyO/4R0qaaCHGrjeIukcUwWNwTIlmlNSjxcdSoQ1khjl45GlXCBgngQejkLF8y4egrR/v6DvAXwZ4iFlRs65Q3PCHg71pKYgx2umZ6ZskUHVNUspzDfMwwjiO8NI4tV0O7A/K6nfnEDamcz4eDicI5dbSakgI4+iOB2oekDc+/xRY95ZqEMwtuljOlyXrAW3oXQhHZl4DC3BQKG9oPxE2eqFStSgJBTWzCcDjSZ2p+7nuFXxLZ7MGxxSvUL6WfrAMQVay5VY55bBy/aWcS2BhuEThgnHeHRjQ/LO+wpVa1CmLj3vNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eHpymck1svNPqLQMWpwnHpBYceLhq7DzkL8Yf6KjV3w=;
 b=chNfRvLcPgWwGx3JbR+6q9X3C3q6dGNmfvetL6+vZellUnpbv7/pFJVgi6knWdc5afuDnjrjZo3Fskij26xVJD2atKzsMH1xEUwbqmNQ0Z30b22vwXIP0p1tpROn+wawHDdHj8fXUsido4y9sl3ui8aQXolev1r0kbaGrevnLlrPlq0ab3g8N9pltxYjk9PNYy1A+Adnb4cGwuUTZVvJXEEQLUnsSUS0KPj7MFK+dLdc85dgxxFY5vd2IQhODN4EouOVsF4yP3Vc0vT7XLcPpQPXzu46uZlWod259zzzX7oelhvQlIccOhOYCGEG5/zevR0XD3rvnFAUSlTa8dEFvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHpymck1svNPqLQMWpwnHpBYceLhq7DzkL8Yf6KjV3w=;
 b=QR6Owb61njx4x51mtEh+GDCy0BfWpoauD9uV09ZKiKcLJJ8tG0RxfTko0GPK/IGoQxoxgMqSYog4Wvp5kU5fywc7ouE4WPs//kW5hl0IoNdwBnO55Qm4PwfJKEgGMF2m7Yp3Ugonklre9SXSPoDPitxhvJd5msCjKO7gU9NQEOJAM85+Q8gdKosOEzGz0UJhXAUGz0ivEeAga0SzeYVSOAL4JOyXy9nqtrjfRo8cJ5gC8nC5t0MAGDwGsbU9avl5NqkX9LzQeCjLsTxlPkpV1BY7E8LODwEGmIHe6uj7ajivFrcHKN7yHpQL61CD4rosuOBKoeLJ/WBSOOyH2BND8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5207.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:283::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Mon, 2 Sep
 2024 07:22:46 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.7918.020; Mon, 2 Sep 2024
 07:22:45 +0000
Message-ID: <8cfcb7f7-1779-463a-9e77-e0e09234a35f@siemens.com>
Date: Mon, 2 Sep 2024 09:22:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 2/2] net: ti: icssg-prueth: Add support for PA
 Stats
To: MD Danish Anwar <danishanwar@ti.com>, Suman Anna <s-anna@ti.com>,
 Sai Krishna <saikrishnag@marvell.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Heiner Kallweit <hkallweit1@gmail.com>, Diogo Ivo <diogo.ivo@siemens.com>,
 Kory Maincent <kory.maincent@bootlin.com>, Andrew Lunn <andrew@lunn.ch>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 Roger Quadros <rogerq@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Santosh Shilimkar <ssantosh@kernel.org>, Nishanth Menon <nm@ti.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 srk@ti.com, Vignesh Raghavendra <vigneshr@ti.com>
References: <20240822122652.1071801-1-danishanwar@ti.com>
 <20240822122652.1071801-3-danishanwar@ti.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240822122652.1071801-3-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0068.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5207:EE_
X-MS-Office365-Filtering-Correlation-Id: 0141be1b-43a5-418b-e4c8-08dccb200a9d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TVRvbWdyKzlINXkwMmticFVoWTZudTlFQlBXK1g5TXprYzZyQlV5bi90Q20w?=
 =?utf-8?B?Ky83TE1jdGxEM0dwQXFxSUJKcXJBYUp3aEJEYXUyUDJKUEN1aFJmQnh5clpu?=
 =?utf-8?B?R09sRERFWnhTbCt1TDgreDd2Tk0vcEljSzl2MGdWdndyU0hXTnM3VmRIbVhh?=
 =?utf-8?B?ZThCMXFVTXA0ZEhpQXc1SHUxSS9uYi9oaVVPOGE2czljL1c4TmFqZGQ2aGNY?=
 =?utf-8?B?VGZoWjB0Rmo5OE1jbkIwY2FQMTBQdW5iZXcyeCtLanVibGF6QklMRUIzYzNK?=
 =?utf-8?B?MHRRTk5RWUNYTW53NU1lYm9PV1NGYjBrMk9qVXZ2blpQSjRrL1g0YS9rQ0JB?=
 =?utf-8?B?d2ljT0FBQjJhVC90TGpPRTgwWnBvZjdDcW42bDFaeW1IT29FdytlYkduMC9x?=
 =?utf-8?B?UE9FQUdOQ1RHZFg1OHlJWGdlbElrRW5vWmd5MHZoK2UyMlBFUFBJcGdBN2xj?=
 =?utf-8?B?emo2TC9VUmtMMVBPRVNLM0xwaWluUnI2K1FXRUl1a0JTY2tkcllmMWRlaVJL?=
 =?utf-8?B?ZFdPdDZmMHZ3WkJMbmVHRkJ2d0NMT3ZxcEd4NWpyRnU5MWR3NGV0NVQyYzZU?=
 =?utf-8?B?ODlnRXYxQ3Z3VFQxYkNhQUpQYzlud1FkNnlqS1ZsRkJxaFNYVis4MjJMK3Fh?=
 =?utf-8?B?blhhWFpxaktvc25aZVNVVzJOMHBJTVV6UUd3L2FDTGJ1T2R0Q3BaYldPSC9j?=
 =?utf-8?B?THlKeWkvZWkvY0puRXNqbGRraU5vVkF0TGJ6UVFpYXNyVnlSMkE5akQzTEtW?=
 =?utf-8?B?WlUrOWhzOFNzTzdrM2V0WG9QSmlYKzhEV1hGQ1Z4UWlBRVhWUExNeXA5bkc4?=
 =?utf-8?B?NnJjRms2WVB3cHp6eTQ0UUY1cDBVNUhMU3A1NmxRL3NqOVZtTWhJSlNnQ3NO?=
 =?utf-8?B?NllrcStxY0NxZjk3cTdTcTVLTlVvWkNRTVdvNzRzSXdGZ25uYVFqWFdWdWE3?=
 =?utf-8?B?SGFMWEg1bkJaemZOVjA2ZGREc1ZWd2VZVHZXRFFmVXlKRzQ2NlFUbldvRlRX?=
 =?utf-8?B?eEZhZVpDWmtjbkQyRHVCcG5HNWFxb3ZCQkRLeGxKcVlSSXZEVHRrY094dVJt?=
 =?utf-8?B?aFhoMkhsaGExd0NTaG0rUnlKV1IyckIwVUN5am4yOVljSE40b2IyYlhCVzE5?=
 =?utf-8?B?UUVnemtUSXd3dk9WSno2SnM0WmxzcS9sRVRJOHZ6bkRNcHh3STFSZ1M0cnFO?=
 =?utf-8?B?VVFObXpnbHgwYjVXM0Jwd0ZudUdudmp1cEJpTTdBelNkZlhPeml2VzE2Rmla?=
 =?utf-8?B?TGUzR3BtbmZhdjFkZUszS3U2d2g2bk03Wk9oVnhrNmlPaDZiYkJsekhxWWZL?=
 =?utf-8?B?d2dJZUpFWS9YbnlTQ0FEUE9pUWVkYVAvL3ZCQnZLeE9OSmlWQmgvcmZSeTB3?=
 =?utf-8?B?MUVITXJJNmg2bU93ZHgxQVI2YU56VHhPK3hwbEhjQXMzL1BUbGZ3RmNUSXpo?=
 =?utf-8?B?M2Z1bFZmVDJCaUpjYS9EVXlDb1UrNk5XZU9ITTlVamxSbFIxQzVlTGFMQVFl?=
 =?utf-8?B?WHVtMlJ2SFFodmtzQndML1MzQjhaNjN5ZG5XSHpJemsrR0NtWEtlbURnY3k2?=
 =?utf-8?B?cTkyTFVDUldNeFBrYmhUYzBBUzByTWxsY3lkNlg1dk5iaHE1RnRNS1AzajlX?=
 =?utf-8?B?eTJneTlsS2NrTFQvNzZxSzlTY3dLRlFyMDBNNEs1Y3hpRHY1TVB1ZWVhU0Zo?=
 =?utf-8?B?RUtmeC8zZ1pIY01SdVFCRVBtUmdsZ3RDajJMUDYzTGlCZldjQVBHamhsUDdS?=
 =?utf-8?B?eitTQkt4djJranhFTnNZYW1OUzczbjIvR0FWSy93dERkMFJtd0Z2N0pFeWVw?=
 =?utf-8?B?Z0lOYTdzSTRGck91SzRYU1hkY3gxbjV3QTZXNjBFOUNEUkFxQ2FIbGFsTzdj?=
 =?utf-8?Q?XoL7nUQEzBpur?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzU5M3RyV2lPTEhPUkdVeDdNZURwN3FjVko0eFBqaGNhY2RUaDRhbG51akNq?=
 =?utf-8?B?a0RIZUphQnNoQ1E2NmxGUWUzTU11VnRlV1F0aEtmc1lvaUt3Z2xHRGVHNTcz?=
 =?utf-8?B?VUdPM2RLVHZ6dm9qVEIrYVlkQmhwZ2d0eVhJVGhVTTV3MWo0RFQxQ2RlTFdt?=
 =?utf-8?B?YUQyL29IdUhZRzgrS0RzMjhNbFE5emRyNFk4Si9KbEhUcGpVVDVmV3Z2MVlY?=
 =?utf-8?B?TUpma2FGeDZjQmhBTGl3WTBLTUJJdndyN2JpNDloa1dBUU14dFR0QnpTMnM2?=
 =?utf-8?B?MC9XWU9hbUV3ZFJsU2J4bitCajU0WXhKbW92aXdDeUx0SCs5SlNnZXZRclpi?=
 =?utf-8?B?RGNJdXR5NTYxOU11cVYzYkpxZ0JzZ0FKd2N2dTk3ZzBMZzMvdzVZdVBmQWpU?=
 =?utf-8?B?L0d6d0ZkY1drOU1SempZa0lmaXF2bmhEMkp0d3ZmM1NVWEZHbVFJanpid24x?=
 =?utf-8?B?ZjRYczlNamFBeGdoSWRZbDRYK3c3TVpQbnlRUG5aZ3JDK25MajNqRmsvblEz?=
 =?utf-8?B?eDlDOHM4djhsNkRxbmRJbFp6YVFrZm42OEZ3ajJwVkFmZW1MVzFDb0VLeEZB?=
 =?utf-8?B?VnMzcDRDTmU3MzJ2dHJwTzNLQWxLOHg0a2RzWFE0YVZkb2V1OVg2dkd5Yldw?=
 =?utf-8?B?UzFqUjl4emg0UFU1TEswczdacjBVUDZBUmMyanliN3M0aHlGNGZrLzJMaGN5?=
 =?utf-8?B?eldoZVdvOFBNSS9qbVVXSjRvMk9vY1dHTnN2bmZaSUpyVldWZll5U3lmcWUv?=
 =?utf-8?B?dXRDM2FuNDZtQ0FhTTJXZlRjOUtKR2FDSXQyUnJ4a1poN21LUUVjWGZsN1Nr?=
 =?utf-8?B?dVF2M0Y5M0tkZWRtZnVPY1RYSWNPQkt3VEJod2hiVXN2YVB0WXBJVFg0cllh?=
 =?utf-8?B?NEN3dmc5ZGIzZ2gvaHJpZHZ6TFpxYnROOEhLMUtibzhxMUY4VG0wZ2VsZU1Z?=
 =?utf-8?B?a3lhbDRrVzFqcVd6SEhnUVFMSFNSQi91T2ZGTTJka2R6Vy9HOUpNVmZsVENj?=
 =?utf-8?B?Mi9TU0REajBPd2VWOEx4bUJ2UkZ2MlY0eEI4Z0RUc05EK0Jsa05pZlJhLzBi?=
 =?utf-8?B?a1hEamdGN2k4SWY0eFBDaSt2b0YyWmpSTWZGdDExYTNHNjVRTkt3enBiNUdn?=
 =?utf-8?B?clNLQ1ZLaGszdzJ4aXIxTVQyTFowcVFWTDJUVGVRQ1pvSGtrVXBZOUZDWkVY?=
 =?utf-8?B?ZEQ4MFlab1ZmWFBBVHV0REVJaG4xN3ViWmtFRXIwejcwdmxaWXR6dk1RWDN1?=
 =?utf-8?B?MlNQM0lUV0ZQWjJVS0RmTkx1MkVwTHdYdVpRQ2tVcjJjb29QNzdqN1pqMW9J?=
 =?utf-8?B?V2FYWHI3Q1lIRm9Ia2FPbWFqdnVhcnBpUGVyM2RZSGJ3bDJNZXkyZzRZTlVE?=
 =?utf-8?B?Wm9EZXVzN3JkeitGNDc2cHRvemR6VHJVdXU3Zk1SUXVTTEI4K0xuNlVEMDBP?=
 =?utf-8?B?MnkxMTBOSGVEcEJZTCs0bVhiOWVzSTlqdEkxdVVWbDVYSUEzbS9rMUhydHdn?=
 =?utf-8?B?QUhNd0diR2F4WmU0RlFiTzVaOUIyUE91clRQa1NnbGpQc3ZSNHVkMWQ0T1Nx?=
 =?utf-8?B?U2ZSQy8zV0tpOVNuWjA4M3R0YXJIcU02V2hGL1ArdGtQSXYwcTN6SlJrbFJp?=
 =?utf-8?B?aHJlT1BXZlJKUDJQQWJqdGJ2RWs5U0pobzMzWkVGMFV4ekF5ekQ4N1ZlTzF2?=
 =?utf-8?B?MzltbXNGZ3RJNGoxL1ZUblp4OUdLMDJhSTRESmFOU2RlaW43UzVmUUVBOGxY?=
 =?utf-8?B?K2c1dUpLNEkvbTRkVGhqdEtJUDRtTC9OSDdJWitCZFpMcUZmaVM1M2hzSnVI?=
 =?utf-8?B?ZDZiVVZneVNXc3ZHMlFOSDM3L053bEdBaFcwYjNJbjdEUXdsdFl4M2hXazI5?=
 =?utf-8?B?bk1kcGltbldpT3BDTHBraFZQd0VvYkhoL1JvWWxIdlozVVN2NDRVejN5eWlr?=
 =?utf-8?B?SmNqN3YvTlgwSnYweGxvU0ZPVm0zd2MyMVFtTmpLV2c5U0xGQzBSMTZ6ZTNu?=
 =?utf-8?B?dWlNSVdiL1AreE4vNnBsM2pSTGdOZ3NPOUl1S3JkRFV5M0lyWURlM3pmREda?=
 =?utf-8?B?RHdRRnhSdHc0VjNTbUI3MWJkRjZSRC9nSkFRNjdyU3ZYM1puUkxKdVFCcVZv?=
 =?utf-8?Q?Nf7K690+pkbqg47rQeSoy7tTD?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0141be1b-43a5-418b-e4c8-08dccb200a9d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 07:22:45.8741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0/KHYXL+sh/BUrUOoNCqyZKdw0bNDwKlBQLHtUNL8Xs8U8SFaCIIJL9Zt9naeQZmJViZfDY3bni+Cwh7zXygFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5207

On 22.08.24 14:26, MD Danish Anwar wrote:
> Add support for dumping PA stats registers via ethtool.
> Firmware maintained stats are stored at PA Stats registers.
> Also modify emac_get_strings() API to use ethtool_puts().
> 
> This commit also maintains consistency between miig_stats and pa_stats by
> - renaming the array icssg_all_stats to icssg_all_miig_stats
> - renaming the structure icssg_stats to icssg_miig_stats
> - renaming ICSSG_STATS() to ICSSG_MIIG_STATS()
> - changing order of stats related data structures and arrays so that data
>   structures of a certain stats type is clubbed together.
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  drivers/net/ethernet/ti/icssg/icssg_ethtool.c |  19 ++-
>  drivers/net/ethernet/ti/icssg/icssg_prueth.c  |   6 +
>  drivers/net/ethernet/ti/icssg/icssg_prueth.h  |   9 +-
>  drivers/net/ethernet/ti/icssg/icssg_stats.c   |  31 +++-
>  drivers/net/ethernet/ti/icssg/icssg_stats.h   | 158 +++++++++++-------
>  5 files changed, 140 insertions(+), 83 deletions(-)
> 

...

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> index 53a3e44b99a2..f623a0f603fc 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> @@ -1182,6 +1182,12 @@ static int prueth_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
>  
> +	prueth->pa_stats = syscon_regmap_lookup_by_phandle(np, "ti,pa-stats");
> +	if (IS_ERR(prueth->pa_stats)) {
> +		dev_err(dev, "couldn't get ti,pa-stats syscon regmap\n");
> +		return -ENODEV;

I was just beaten for potentially not being backward compatible, but
this is definitely not working with existing DTs, just ran into it.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


