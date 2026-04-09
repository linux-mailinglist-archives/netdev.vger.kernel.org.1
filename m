Return-Path: <netdev+bounces-276780-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gK2oFZoM12npKggAu9opvQ
	(envelope-from <netdev+bounces-276780-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 04:19:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C82EE3C57AB
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 04:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 86B90301724C
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 02:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F653191A5;
	Thu,  9 Apr 2026 02:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="aE88hRQZ"
X-Original-To: netdev@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazolkn19011009.outbound.protection.outlook.com [52.103.66.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44D91D5ADE;
	Thu,  9 Apr 2026 02:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775701142; cv=fail; b=IckRWcybHulyAq9tIfmmZ56LhnYlszeyg8gTkNUh9B3q6G0JIMtYJlYKIJVvG7dwKU9oGQdnfsjqBlRVgoc8EcVvuEgIFC6w00hem2r8PVsl9X7S2rMPrTD1pJdvNu1Les+5xCg+RK4p+hYFY2ekme+kVcz9MdTN0zYfYSqFRBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775701142; c=relaxed/simple;
	bh=W//1a/1llJIKNEwQLcA/r1sugdLEHTWZK/NJ9Riapyo=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JTTaVOT6sWl2HeOWZ03cmlmZjlDMjQ7gCiAZYpV/POcw6c7FVjeOdKdlFvObPB/A9EXVbm13DuDHu/Zoq4mh0mAqOPT7I9UUpHo1m9Vj5VrbTaE+AOOO78BSnqos6AXPh25d/w+pum2fzYnv+7gKxJeCvQQAUt2RiqP9KG1Hnqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=aE88hRQZ; arc=fail smtp.client-ip=52.103.66.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ekPCTwQxS+VkOcdg/V5r7QZPHx1/RFzebi2mRUqNZG+hhhG73wCs5NHS0s43vtbbMvv4P/OX99ZMKtar80NNYG2S94O1DC9Huic469gm39yJMxAPpqvSOX7EfJLQSwX5Vi2MrpIxBRaL8mb5lFlVIQh3+e1+qATbTx2pZj8KuKTQDMmDz8WNNAo8/U+s5Dss6yMGOWx4PPjKsedaNPeFMpNQwerndJ/gngQZgqrowtMJhqMX/t1cNq7oMlGi9O8veGiNX/TDaHpD1TguFlwRteLMgGtaIs6dFvZSvefFU8Uy1oGJnUPT7s5EVB/Q06SErrIuS6WMhxtVulo48eJ1+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5KgegYDAX0SF1FYuKyqfizHiLeuCOVRvW2KifGw+v4E=;
 b=Lo21r0SCJthF8cd14od7iVSw2Rta8UoX0nlwM9ZU5ye+QeRuv4dhKs3QxK5pYiBvfE2jT1/mxPhhgakCLAo1ojUXhIx2ifADeK6cjmj77MVSJw4nJ6klGCR8uyDqMsPeBWNrSpoId41RyDvURUzIhgDUxYOEkvjTmkP6ZmEDWBUR/W9yHZ4LEJMAKW9ZUgT39UjWo9QLgKaFHF+DZbEY2pKU3zugPFOwILddjnDwXDKX2KxF/PfBq/bx/DVj53DE5SYLWV07RXnivv5Z3gYp3/CcztfxuD6HggwMqhDBDiCCzlfJ1/m2XvuZJj02U7o9/Rzhw4P7n6xnXG14BeJFoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5KgegYDAX0SF1FYuKyqfizHiLeuCOVRvW2KifGw+v4E=;
 b=aE88hRQZcnC0jGNAWqhGq/NOGR6lP8EWioTIGUQbJSH7UL8JcxlZ+L+4vSGDcV63lP/RS7V+Z5ge5D4G1viwgjGl5iJTR2qhhGjbM3eTv2NtSLZceAfJM0ZUfIcJu0hAn03vLVgv2t6oiA/NXl/qVAKQF0dMRgEzjsUQS083RTPPha3In+63Stc6Zx2VU39D2ZnNBg1YaVIw9HM18RE50NncPvJ4eQzOEA1b8GghmNWK8tlLCg0w5nDkFqpzrhKfuLzdgvcoT/8J604x8ZoASJKcCF94qUI+oAlSkBJo6aPVTvdxo1gw/3eAeO2H7iyYPRZpabGvrlVUHnEXGpCLtw==
Received: from TYRPR01MB12666.jpnprd01.prod.outlook.com
 (2603:1096:405:1b4::11) by TY1PR01MB10705.jpnprd01.prod.outlook.com
 (2603:1096:400:326::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 02:18:53 +0000
Received: from TYRPR01MB12666.jpnprd01.prod.outlook.com
 ([fe80::6ded:56c7:8121:fa0e]) by TYRPR01MB12666.jpnprd01.prod.outlook.com
 ([fe80::6ded:56c7:8121:fa0e%5]) with mapi id 15.20.9769.017; Thu, 9 Apr 2026
 02:18:53 +0000
Message-ID:
 <TYRPR01MB12666C2C108C1D23202C5B79ACA582@TYRPR01MB12666.jpnprd01.prod.outlook.com>
Date: Thu, 9 Apr 2026 10:18:47 +0800
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
From: Xavier HSINYUAN <xavierhsinyuan@outlook.com>
Subject: Re: [RFC net-next 05/15] ipxlat: add IPv6 packet validation path
To: ralf@mandelbit.com
Cc: andrew+netdev@lunn.ch, antonio@mandelbit.com, davem@davemloft.net,
 dxld@darkboxed.org, edumazet@google.com, kuba@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com
References: <20260319151230.655687-6-ralf@mandelbit.com>
In-Reply-To: <20260319151230.655687-6-ralf@mandelbit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SEWP216CA0036.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b5::9) To TYRPR01MB12666.jpnprd01.prod.outlook.com
 (2603:1096:405:1b4::11)
X-Microsoft-Original-Message-ID:
 <ea6d4a89-0802-4ac5-95fc-c994ceefb13b@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB12666:EE_|TY1PR01MB10705:EE_
X-MS-Office365-Filtering-Correlation-Id: d024057a-7229-4a9e-ac56-08de95de5843
X-MS-Exchange-SLBlob-MailProps:
	Cq7lScuPrnr9cOglUl1urTSFBsjx1OD0/tnq1f8TyAacWoB7Apulkk7ZVOjqW8bRSLpZwsNh7ayM7rFmwFPTeU7v3GOjU9C+8F69ZuJfo8a5XLSNTISjMHUArtA00LNqtaz+bZLDyJKX/84aEkHcOfu0tLvo5RjuuUe6LOopgoNhJ9ScpFNAU4KKcfOMKTDgzBn6prh2xiOEjbwpB7wUsRJ2IV9bDQTRiFzRwUe28kPeIwHL+9lQPBDlmmMZfFZC8/VeZa1F3J5yspKbD4UhCCo1Uh/mf5z7ALIpYG7N1ukLTNSkwhPF6ywSC9sa8mR+F70MoFhWLKivRvP/m03j1945CuSW5pGISObX/BWCxAVh8Yk3MnFudZqMxFKdl/zuIbSDw8UwlajxmifhUTm1Ww5BOCwixYWbLz9Xfiu8DQ7T81WMYE/dVq8hijAo5qBaPorNTyHU+0Zvh/iMSpBkWBYZZomldCdvFKeH1m/bZahHyVcFfgLQgHeNL6zfKe0RE1S27HijNj1fv6weJWwsza8+o3/SbYlSrSlVoX9VPA2TMFlKqbdjH5DWDcrK+SYJTqcdEZ5L9O9x3FJAyTG6w+tzRMtfWa/5xydDGKiTrzG5cF12JQmCxk6CLp+6QGFnpew0f5FdUDUmG1twQyiDEniEaC9UTv2isq1cSgUQ2Uun4RYiY9sVPMrygJBfVFEMZNg/mxYYzCQmm3EpWqC5WpcZKn2SZlpj8t2jihvkGbFqfxzyTw6xVt28tvmEGYqYLZtnLP0mgPE=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|41001999006|19110799012|25031999004|51005399006|6090799003|461199028|15080799012|5072599009|8060799015|40105399003|3412199025|440099028|26121999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZzNaSzR4UHNqZmlkK3dUNDNWOWtvaXNEVjZaRE1tTDQxMUY2K0Fla2VDSmpM?=
 =?utf-8?B?eDJoK2svMlgrU0tvUTVRaU8wb1lyaTkyREhhWHQrSDU3bGtnV2hmeGlmaSs1?=
 =?utf-8?B?SVNZV0dFNEJYWllOK25DR0VjRTlDWk9Ib0pJNzNkR3A1TFBoMExFdDYzTWtP?=
 =?utf-8?B?S3RVL3Fnbm81Z0wvUC9WaThkeEpCMXYya2FGZkd0YmlqNnpvRm5zWW9GNDVV?=
 =?utf-8?B?TnlScWJYdXBXTk5LU3AvVGVqa0RYckx2S2d2SHRXWjY1UWNKdEUrR0trU3pE?=
 =?utf-8?B?YkxSVElYbkpYRXZjaUZ1ZWJmdy9RSVVqMDhvSzFCRHNWR3A3TlpsUCthY0pr?=
 =?utf-8?B?LzBWMEQwazhnVWJScEVIMk8wNERmUEczVnNvYmFJWWxnMUtaOVZPSnljQU5m?=
 =?utf-8?B?N2lPVmIwYzRxelYwbkdKVEpKWElRRzNoL3hpY0g3YmRqVkg2bXdENWxOWklJ?=
 =?utf-8?B?WWlWTHdhNENjc2NXUFBxZXJuRWt1eFJwOThiUEliUkp4ZW5zeTNPczFhYktN?=
 =?utf-8?B?cDZHT3ZRYk1IcVFpNk83c0hoZHUwVVdxUkdwaFp1VXgvR094WXJqT1lxQWF6?=
 =?utf-8?B?NDRmZmViSXpscDVvYmtJeU9UbFNmSlFlYk5tL2MwM1pTNUYwRlhpVytNZVJE?=
 =?utf-8?B?TWJrNGlkbjJVNnlFV0NOODRnMTdsN1Z4RmFWWGV2c2hIcnltN2ZyQndNR0lF?=
 =?utf-8?B?SHNRY1VOalhqSHhsVkRCNXNESlRlajhNMDk1bHFIWkY1MWEzekQ0dXdLOGJ4?=
 =?utf-8?B?YU9RQUVRYnE1NlNOZ3hEUGo2OU5lMXBIZFNwaXZZeGc0V3BaUWw5b0gwcTIy?=
 =?utf-8?B?eW9LakZGOWx3a29jZ0pZa3I5cVZwelUyaUFrUHRyNkZNZGlTZUplNC9jQ1c0?=
 =?utf-8?B?TjJWL3BvZ1gwMWpBbzFadzhhSEdjNkRCVEgyVGtsK2xvcUMrOWZCZVZOSzJt?=
 =?utf-8?B?d3htdjA2NmVMandITmQwMUZ6NWo2MU1YR3YzZFpNOEIwMWRFZEtWZ2Y4U2w4?=
 =?utf-8?B?VkdjRHpxa2h3VVhtcmhlTVBDY3dJVHJWSHJtQkRUcURUV0d5ZWF2cGdnYWlO?=
 =?utf-8?B?LzgxZVFzQ005NzNUdE5pd3RWdnBoUGpTVlcxcGkvR1NTZHhIa2hUbDIrc3FF?=
 =?utf-8?B?eWliV25CT0VyZ1N0WkRxdzUrdEM0cXBkdFkycDh6aG12N1NHaUQyLzlGOG5W?=
 =?utf-8?B?aityTUNKb29tSEJMNUwxSDFxMllFVmZZaXlHeWxnaEtRSEVpMTBkY1BNajhr?=
 =?utf-8?B?SzdNNm92TGZIUFIrSEViamZkNnp4dFFpckVyQThpeWdJb0JBaXFDOHpIbE84?=
 =?utf-8?B?dkNzeFFDSkpIaVZmNVJ1N0JHbC9qMmVCSFlqOGN3NStoQXdrOUxmZm80M1Zx?=
 =?utf-8?Q?mUs4nxI48U6kSAQZKb4BvBWDg7zGgGRM=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHk4d1VVS1E1N2VMQ0VLVFMrc2h1dkF4TFNkaG9GeTZqc0lKY0VQWEVGaDQ4?=
 =?utf-8?B?TGdDbGVMbDU2UGJRSUFVOHFVb0ordVlFY1hSZ0tSdVF2d0hPanFKMllwMys1?=
 =?utf-8?B?VUEvSURmQ3ltZGI3aTNqay9tQWh2YlA3ZUVVZ05rQmFxTHFVWUhKZGd3NzNB?=
 =?utf-8?B?Uzd0Nk1kL3Q4dkNvbTlJOFpxa3l3UXVEaG0xSDZxYkFGc0lhQjF1WTRKQVNp?=
 =?utf-8?B?eXh4ZzVDdWZvYTRMM1BwZFBjUkRING5JR0M0U05nRU5UbWxuMjV3VVEwaWt1?=
 =?utf-8?B?ZU5KL0pCV1FxcUozQXcyWkswWlhRa2tTZHZ6MDRydTdtdGhPZkRKNFRxWlJr?=
 =?utf-8?B?MnNibXNpQ2FqQXNVSW84anN5bHFYTjhTTFpQaHVFYTcxcGpyaTdWTko1YTha?=
 =?utf-8?B?TjM4Z1RWaDVMZ3ZjTTl3azk3MC9IalI0NkQyVEJwOGZuTWJSMDhqUzNVZlJy?=
 =?utf-8?B?dXFjOVZwNTh6VmVlRHI1S2tUSmlQODZOUlhPK1pNVUxwdkRadmtaWDRRZFRT?=
 =?utf-8?B?Ti92RU1oMlFwYXpKSzJORmV4a2FPcUlQUzRvOEw3dmZDT3hMZTBoTWhvejR4?=
 =?utf-8?B?a1hVcjNNbXZhZzFWbFpZQ0puOU9WUmp6ZjNjb2pDa1llVGVmbTdzbFFXaFdI?=
 =?utf-8?B?OWNpdkdtUFBkam4xVzMwTXhDT1F6K3pOVU9BTy8zcnlaOHhZNy95cmVXRENP?=
 =?utf-8?B?Yk8ySDk2dHFDaTVnWWo2NFFIK1Bidkh3SzRkVlgzcU5BdW1yM211WGNRMWI0?=
 =?utf-8?B?UVBabnJOajFtRktRcTNqQmJkOWxMb0VlWGI0ZXlwd2tDL2NReGJvMnZCVEYy?=
 =?utf-8?B?cWVpZUFjM0tKbWdCNS9lSSt2clk2U3E1OFM5TWFaV0NXV21PYXFaRXVHQjNG?=
 =?utf-8?B?SFNrVVlTY2RRSUh0OE9KeXBvZllaNHRNeEZ1VEtKdTFvYzR3VkNPUEhJWFRV?=
 =?utf-8?B?REh5czRBK3FuK1NXb0xTVG1XNVBlcWdtaHEwV041N1hXczIyT3loWlN4MS9u?=
 =?utf-8?B?OFQ4dXJnSmhyM1FSUjlCZ0x3RGlOYXlFUmJ1T1VCL1RWTW5FbGY0UVRoUk4y?=
 =?utf-8?B?bGdXdTdpdkZJR000L25lUUs0ZWFPSlVIcVduZG9KOUNuZHNyMWE1RW9jc1ha?=
 =?utf-8?B?Si9nZHhvSGFqcStUMER3aFRRZFJFbTF2OExhTTAza0tGeU95MFE0Z3k4WEZX?=
 =?utf-8?B?TzFyOSthV1U0WmZvcnRUSEZlMGhYQXFyMXdWMFhWSHY2VXUvSjBCaENYVitZ?=
 =?utf-8?B?c0ljNm5QWXBDL3B4bkx5cGYvck43enNrTklOdm80NnFGNTNHN2tUeWJlYmlM?=
 =?utf-8?B?YStOTTcxM1hSRjFIc0Q5eE84TkRBWk9wTjh5aG1YSTFUM1hKVjJoTEZyeU0v?=
 =?utf-8?B?TjRMTllFbGtsWGxzelpjckxqS1pvQXNVamN0MG13ZExkWnBYVkRqb25WQzZV?=
 =?utf-8?B?RXNwOHJFc3hVZVpuOVZJdnJNekQzeDZVbThWeGp2NWxheE52c0VnWnlhaTVW?=
 =?utf-8?B?V0pXV09PZy9jR1Rzd1d4ZUdCRU9FRldPTURCRlovc0o1VDFCdUhSaDhhVjUy?=
 =?utf-8?B?K3dmRWljT0FvTHcyY1B1NTkxeURQYTFuKzJwa2gvcElZVnFOQXltM2ZMKzBz?=
 =?utf-8?B?MG1pZk9KUkZYN3hUSEttU0NnRFNpeEl0SWxBTlRIYjY3RlNxVDdhdFRrVWpK?=
 =?utf-8?B?K2RMY054cUFkUFdxcXppd2E1eThUZzQzVExmWHpTQU1ZRFJFS1hQQXpGSWRZ?=
 =?utf-8?B?UUVoUWkwT3JjWjkxZmFId3BKTkZLY2Z2NmpqWTJTdHF5MDNGR2p1ZXNRUGNB?=
 =?utf-8?B?aFRLb1p1SWJFTkdXeVpUc2Jhd0ozdThsRHVUZGsya1dFOTNQVFcxcG4zU2ZT?=
 =?utf-8?B?MDJaOHNhd0ZyalZOSWJaZks0OVV6UHNKMkZ4WUU3K05MVzFEYXBlNXJhMjFy?=
 =?utf-8?B?Ylo3eXdraVFzTGlaMHB5bUdMNmdwckZJY01EVFNkZzY5ZWNIV3FLb0xvYTJF?=
 =?utf-8?B?bGtnU2Y1RUN3PT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d024057a-7229-4a9e-ac56-08de95de5843
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB12666.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 02:18:53.2377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10705
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276780-lists,netdev=lfdr.de];
	FORGED_MUA_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xavierhsinyuan@outlook.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,TYRPR01MB12666.jpnprd01.prod.outlook.com:mid,outlook.com:dkim]
X-Rspamd-Queue-Id: C82EE3C57AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Ralf,

>+static int ipxlat_v6_validate_icmp_csum(const struct sk_buff *skb)
>+{
>+	struct ipv6hdr *iph6;
>+	unsigned int len;
>+	__sum16 csum;
>+
>+	if (skb->ip_summed != CHECKSUM_NONE)
>+		return 0;
>+
>+	iph6 = ipv6_hdr(skb);
>+	len = ipxlat_skb_datagram_len(skb);
>+	csum = csum_ipv6_magic(&iph6->saddr, &iph6->daddr, len, NEXTHDR_ICMP,
>+			       skb_checksum(skb, skb_transport_offset(skb), len,
>+					    0));
>+
>+	return unlikely(csum) ? -EINVAL : 0;
>+}
We should include net/ip6_checksum.h to make x86_64 with KMSAN/KASAN and
other architectures with optional _HAVE_ARCH_IPV6_CSUM happy.

Best regards,
Xavier


