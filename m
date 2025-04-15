Return-Path: <netdev+bounces-182689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 577EDA89B47
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 12:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A55F4189619F
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 10:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AAC27F724;
	Tue, 15 Apr 2025 10:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Foc0HTHH"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011063.outbound.protection.outlook.com [40.107.130.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA8A2260C;
	Tue, 15 Apr 2025 10:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744714672; cv=fail; b=Ej8IQ3Vsq8Gw/JQbE6wfDU1LMin3Tqj0yZBlPGefnN8yUYFPvRA9QhoaVanS1Sk/oegfYeI8T9SmDQ5VedOiY9L1PV76cibJMVntMW/WTuVC42bhV9F+X4tJFvlKOH6JMVU3E3BIguGnBGEYH1UEWWSTurVL1qc7GvM5vb2YRMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744714672; c=relaxed/simple;
	bh=AOsHRb5wnc1D9jb7RnJvosrvzfJ/FrMzvFfDBWKTyp8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jaydCr1DqkrkmmSq5x9gUf8EdG0Jmy76yqsNdgMCYsFLyuMxqgZiOW4nTuDzE0GInzPeR80/OP98SVk28tpN99QdAanYdR+4UoknBN6JaetnqHiwqjC4KtcwqGYpPkiy1EvF1CNX5IbkSfN4onWJjztCBMBh3TU2FY5xMX8UPu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Foc0HTHH; arc=fail smtp.client-ip=40.107.130.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CjZ6EYTyBn7gtauTL5rMyUzeK1FPdio3NJ2IUf3Cg3t8UUHkCwUdqMHfYcNmQh9uqjKQBcxgjX/7Iq9YDEdHJVZv80QdGN3IBh+djNvVXHcmGH+rGrOG75Y2M4USDVQ6ggjlLfUdCY2lTVQGPnNf5hFIjv+Tppu3cU5yzUOrp31JZtfKjF41T/R1OUQRFuoyN/Qp/ym9qoPzIYNdwBEQNZ1BdqIgFp+j/dA2Eev16PS6q8wirgsDa1EfO3g/L+ze49mHn0ROhXACZAQxKvyfo/Ry1satcre6pQ44hEAhMC2urawbUCPiKES/uYtHqmMWWm5ofiAnVoT81sjKpsKAJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nAqHlA0nzqudI8NH8dZq1bONyotQ1BzXjwcp+URDA7o=;
 b=Xi47iTRhg7KbLBu7GaIk9ThMVMshSdPxvZCyt4bnD4+jvbv4TtgEHseRZUYn5+pb077LSRk95pn4TeQOxVTcZs53+3c1zHNg833w6U4g4vF673a7SqRh/INN8j3HIWumrp2hSBPAZ1YbryGznGoJggF1K6vu5MFimY9iRQe7FSkZSM3mhkAQbnsQlVRKxEIe5ZA+92wCpi5wN5BRpsvr+CmYdyh5qaGUGtlH0LL89/alV6HctdpzrsanQzd5oXyaPAvTdAEiCf3hTW1sIkByFP5clgCYQJ2uiHtRlU8bAPjmlsl9PbDdy+bUzc8CeOkw5KqemDjJPKuo55zb4O43dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nAqHlA0nzqudI8NH8dZq1bONyotQ1BzXjwcp+URDA7o=;
 b=Foc0HTHHhuzpBtiRMmz0IPPsJonMAz21b8uHEl60TMb5hW7AhggB/YiWw3QbMwB6A+dX6ODC+Y1iuQPJIhyjY6gd0GfWOsac6jRs3cdcc8KQF5sqKmd14Xd0O177/k/jfXdpMUNb+2HUwDobP/p7wHWCY6pFebNVRmYNxNVWavHuqOuz9Wg3rutjuHsVkYRJNWJQ50koCflihD7FV1cbcqCYOFXQt4/pLak8ltkEgu7jhbK56ZUNwetscanR2Ij2a542NJuGyQoAy6LPdRlJ6DguUSpaV8rfxPwx6TUS1dsiLuV6msXRs4u/w7LqgtcDNcfZlaI/HfdlQnApCA2oyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS8PR04MB8216.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::22)
 by AM8PR04MB7956.eurprd04.prod.outlook.com (2603:10a6:20b:241::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Tue, 15 Apr
 2025 10:57:46 +0000
Received: from AS8PR04MB8216.eurprd04.prod.outlook.com
 ([fe80::f1:514e:3f1e:4e4a]) by AS8PR04MB8216.eurprd04.prod.outlook.com
 ([fe80::f1:514e:3f1e:4e4a%4]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 10:57:46 +0000
Message-ID: <c3d46e0b-0b09-42e0-8508-a672296adeb6@oss.nxp.com>
Date: Tue, 15 Apr 2025 13:56:21 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v7 3/6] net: phy: nxp-c45-tja11xx: simplify
 .match_phy_device OP
To: Christian Marangi <ansuelsmth@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>,
 Eric Woudstra <ericwouds@gmail.com>, Daniel Golle <daniel@makrotopia.org>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.or
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
References: <20250410095443.30848-1-ansuelsmth@gmail.com>
 <20250410095443.30848-4-ansuelsmth@gmail.com>
Content-Language: en-US
From: Andrei Botila <andrei.botila@oss.nxp.com>
In-Reply-To: <20250410095443.30848-4-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0019.eurprd03.prod.outlook.com
 (2603:10a6:208:14::32) To AS8PR04MB8216.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f2::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8216:EE_|AM8PR04MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: b0fda1e6-5f6f-4a1b-2f92-08dd7c0c5ac4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MTlMQnBQRTlxYlVJYm9adzA4c1YzQWlDRUl2a3VtZEZ2U1VGdzdPQUhGUHAv?=
 =?utf-8?B?T2R2blJ2NG1OSUIwU0NlUThWUzFGcGMwYUh4Y21KT01GRUFmWjBRcTV3VG9Y?=
 =?utf-8?B?YmJLc1lQZUUwcHZzMWRaZHZubnRpSkJDNkQ5dzhlWGxrblBhQk9RNlphTFN4?=
 =?utf-8?B?cW8vY3NRTk5UaXlubjMrWHFLajluSzVZYWdwd1ovYXU3N0xRMEVSQWp4YzdW?=
 =?utf-8?B?MXJiS01Mekd5Z3BUWER2ZGs4c0xQSllyMEo5UEJRVjQzUkFNdXIrWWFwVFJH?=
 =?utf-8?B?aEd3d0pBTTdueE5Pd2t5djJXRktUVXRXK3lVNzlJSEtBYVhmTHNzMGZ1bExJ?=
 =?utf-8?B?bVJSR1NsQUxRbUw0Slk5bGg2dEFuS2ZEdlhEMitTQ3VwYk1iWG1VQzhvUFNs?=
 =?utf-8?B?dHRQOTFVbU0rL3cvdWdvV1FuSTR6NFpLYXIwY1grNTVCeElWRFpuSy9Rd01y?=
 =?utf-8?B?Y0dCLzFRSlFaOWljd094LzRWbVVJWlNCcW8ybjFkbUhjWjF5blNVTXNnTUJT?=
 =?utf-8?B?RDhpNTZYaXBNUVRlb2FkWXRDL0xabGYrbUNHTitBc2hHMExzSkFabFVMKzhv?=
 =?utf-8?B?QmRqTDIzQWxSakFwUkxUMUY1MVJkejE4ekxjekxJVzhLcHpQOVV5M29Tb2o1?=
 =?utf-8?B?ZUI0MzdNbWNUSy9WR0UvUW9WVFlmRWJvbmF2c0ROTWd3ais3Z29uYlZ1OGZn?=
 =?utf-8?B?Lzd3YUYyaHQxbURMaDZidjd6VkFSL0t2cXNpc2ZYQ1FOUHE0V2o2cEZtTEFN?=
 =?utf-8?B?aXdzTXdzVGR5Zzd3MkVQMVd6dzJhNjNHVEFCaGNtb2NENXNZdXNYcU91MlNJ?=
 =?utf-8?B?S0U4SkhiTTNFbmp4Mk9qZktLRjR4YW5MR0R6VkR3ZUduTmF1R3d6SGtzUG1p?=
 =?utf-8?B?alpaMHRKQlhQeUExK0RUajF4MVl3MHJFd2ZQc1B1RkxmMWVFS1NoQWFRL3BG?=
 =?utf-8?B?SncvNTZaVG5mblZOV3dBSmlPaEZGdkZXMXY2Z1RLMmxjUktFaCsvUG5rNU5E?=
 =?utf-8?B?aURvcFNIUmRxbjgwczllcUFkcEdUTStlR0FQVmN1SDNVejZaR1NuYk05Uk5l?=
 =?utf-8?B?S1g1bUlZbVd4VTZwYUVmdUJYcjlTd2dHMUxOdjUvcEtVZDBOQzMwSDlXNjlM?=
 =?utf-8?B?NE9uK2VTWjlHWUVvQWFodExjRDgwRVEya0dPOU1BNjdJTi8xc2lURHJ6UmVx?=
 =?utf-8?B?SUZ0N2RhYzdEcHpXVlFkSjB0aVZPVzdxbWVyZSs2ajJ0b2dlOFY1WHA4WmJm?=
 =?utf-8?B?SXJ1cmR2d28xKzFRM1hzOXRndEE3OUpKNE9pbUkzQ1d2bXcxaGJjSmNrVy9E?=
 =?utf-8?B?eEcxVHRwdUM2NXdiMUpWT3BwTzZKU3BEVFdBWlUzajhqN3dBRWw0bEl6dnNF?=
 =?utf-8?B?Q0VoT3NPYnRlcHAwNy9DNHl5NjBoM3NTc0pOK0lPRldOckNWd21mVUE5WC9D?=
 =?utf-8?B?NlRqaTgxMDJwZEszSGdMbUYram84dXpuQmlOUEZ5S21pM0VDVFlmSWpaV1FM?=
 =?utf-8?B?VmR3cFF1T1lpR3lrWTNnSE41SVIxN2JSWHNuTURrQU5HYUV4cmVXUlkwY1NE?=
 =?utf-8?B?dHdlL2FDWWxkck1jdWFKeHYrT2pQYkVCV0lJckkyUDJvbkYwWlI1bGU2SVYz?=
 =?utf-8?B?eEc0S29lTHlyNEJEanRHM3RwcFUxUGU4QkhyYWNnWjRKbSs0Q0VxRHBKVHNO?=
 =?utf-8?B?L24xc1VLQUhieTV0dXF6ZXQ4UHJ0VkpjK3NPM1ZVY284bEJ3WHdwZFRwcURK?=
 =?utf-8?B?SXhaZjVIZ0NqVGh3dTZaMjlWUG11a29EdlR2WlJHZktLa0I0Y05vbGJJY3NV?=
 =?utf-8?B?WDFSanR2ODEzVzUvKzlyNzRyTVJoOVdlMnlQUEs2b0hEWnU4bi94Sm5wM2xX?=
 =?utf-8?B?WmQ2SFphUFBMY3hHK3VnT2oxZUgvMWxiWThMSzAxS05TY1JSNFk1NzJ6aGhM?=
 =?utf-8?B?QmZ0UnJCeEtMektGWER1aXphbGJGTkpLZ1NXS0QwcWcrSHpYSi9wNjJJR0pW?=
 =?utf-8?B?RWtpS2U2aVNnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2d5NFF6WjFraHBhR24vSk5QMEtwM0Z1MFphdmoxVUlrbm1tK2ZVRW9LNzdW?=
 =?utf-8?B?REYwUjZFUTNLUStYMEJDVzYxL3lWNWVwMnBtMVFWYkZmdkVDSHB4Q2pZT1lC?=
 =?utf-8?B?ekZRRGdYTUdxTzZXekZ3Ulp6TndtNnZRWFFmbE9aclp4Y1p4NkRKcENFRm5C?=
 =?utf-8?B?anF1M3hwVVluV3diem5qa0pGbEg3RkRqbUdWWDA1ODluSlRQUmV1bDNCaE1Y?=
 =?utf-8?B?RGZjL1RBTDNSSmYzdXVNQVhYR0dkeThBdE1KRHBvQXFGWDBZUlQ4cDEzbis3?=
 =?utf-8?B?TEhaelIxSFdBMy9aTTVFemN3Mkp2ZGtJYno2VnhPS3pDWTQvMTJ0TGp6Zlpz?=
 =?utf-8?B?alBRNU5UUXRaWWNqb1RmMkpRWGl5ZVgzZkRqV1gva1J2UzhDSytETDBUM3pO?=
 =?utf-8?B?UTdzUmdzTFlUY0packN4K0x6WFZEaG1FUlN5Sm9LdExKcUgwa1dqTkxuMHRQ?=
 =?utf-8?B?NnVvZ3drTjNWZlIxNnJGMzdaaHJvdTFKT0RyencyTVV1OGpqK2lzM2s2SEVk?=
 =?utf-8?B?ZUZidng0WFJtcWFGWHlZeDU4ZDYxeWp4Y29hZndvVVkrbzlYQlpweFBQTjRW?=
 =?utf-8?B?L282eDdTN2FYZVFBeFJ0d05BSVpiZXVhUmE2RWJ4NEYyZDhyVzdrNXV2YVpD?=
 =?utf-8?B?V1RnSXFRNElQMSswRncwUGx3ZExRSEhTdENzUEplN3lYVnpuWjRHSHZkdmtC?=
 =?utf-8?B?RUx0amlNWk9CVUJxNDFKaTZpcVZTUU55d3RJdEhjbWRHeVZSS21CYWQwWDZU?=
 =?utf-8?B?NXNCWU8xZit3MnM3UnV2TWMwOFlBMFh4Rzc2WllnTDNRN3g0MWtHOEVsdUVm?=
 =?utf-8?B?eFMzMjJ0ZXVHWlV1MmtvckdvdW5jckE4N2t4THRQbGNYRDBRVnFzL205TTlk?=
 =?utf-8?B?d2IzVDNDR3lEd2UzM0xzeUw1OW1rT0VzL21wcDBhak5UODRzckVDTnpWNGp4?=
 =?utf-8?B?M2dtNVBkNHNpRWpQQThaLzlMWTNxOEdyT3hEOFlaTWdBVXNMRi9YeDUweTJL?=
 =?utf-8?B?NStPZSs1MlIvNTRDWnpvVjY2NzZhZDlEdy9iTXhPRjdTQmtJN2FZdkdmU09N?=
 =?utf-8?B?OHRxbEhUd2JoL3dpaFVmR1o0Y3NNYXFXdFZoelRXeWswUTMxZ25zWVhFeW1Z?=
 =?utf-8?B?ZDJnbExmRjJYWStmektuMnU0UDdmMS9yQlJEQU9qVGsxbzZlNlhoamMxMzlV?=
 =?utf-8?B?VGpvVDVHVzlVT2hrYzZhemFadGdZcDFEd2tNYjl6T3U0NG05ZFgrcThtMTUr?=
 =?utf-8?B?UktzcWZSdUszbXlzd0lISGZnUEFNVllHeFpDZWdVbVZiS0hqbGNzd3ZmWGtx?=
 =?utf-8?B?U1pobklydXpDT2ZKSktXT3hEWHBOayt6MGRZaHRUS1VLcFRMbDRkVlJ6d0JS?=
 =?utf-8?B?ZGJHWEJqRGJ6a3UwQnhpV2pKeTFqTFdvMWdxMUhRTzZqRVJ0bHhBOUJUaDZD?=
 =?utf-8?B?Zy8zZVB6dEx0UkV5WXdmMEMwcXh5K201SmxKTCtQNFc1c3VvT1h3eFNaamNM?=
 =?utf-8?B?N0Rjd2FKTEpBVmo5a1U2ZTl4NW5ScHhldGg1YUkwZGJqekh4SWRnaTErSlpR?=
 =?utf-8?B?WTJlMmNwSDUxakNJb0hzTlEzMnkyVlJPY1RuWmlUSHFMaWloTnhIeUlSakdD?=
 =?utf-8?B?dTVrWExGdnBzc2Q4Q1hGaG5lNURLMDBWTFpIbXBwY1ZRRG9jazZ4dUF0dkRh?=
 =?utf-8?B?Q1RrSXAxTHB0Sk40M2RtbGQxZmpEY3p4MnRoYi9sNy9YaHVwMnpxNUxlUmRu?=
 =?utf-8?B?dUZ4TFVScHhBeHRtbFl6UHhYM3NPbXVWaStXQmRyTG9YNmo5eUU2WEhlT3lH?=
 =?utf-8?B?VFZMK2wvUkd3RUR6QkhkdWJUZWRzemFpZ3JvTC9VMmNNdnlwMDA5ZWd5a2dV?=
 =?utf-8?B?d2hyd2pjMTZIa2ZRQStpSWNiRDRSM0pEQW1yKzFhUFArRnFYRGt1QjBkWmZl?=
 =?utf-8?B?dUVweE41OG43Z1NTc2JJR212dkhXMm4vcjg4R2dFN2ZoWG95eWhzQnRuQkpm?=
 =?utf-8?B?VTZHWGszQklpVDhZS1ZPVjRNczNjYlZaL1h3eEtQNU5KUVlhbWJMd3g4VVdt?=
 =?utf-8?B?RG5wSUVlUEV1eWE2VDBxTkJBMWl1cnpkZkhaMzZIbnhJZVZuejRTam85dHBK?=
 =?utf-8?B?WWhGbEpBMThFT2lWMzFkNjVnZ3ZCbEJsMmxrU1ptdWJTY1NIdkpjcHBuSVVV?=
 =?utf-8?B?eGc9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0fda1e6-5f6f-4a1b-2f92-08dd7c0c5ac4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 10:57:46.4213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I2x1cIY9K5VhgaDbB3co+e0FufqIN2h3lfC033UKbuTlfnCeCIy2xpr6HQDC8mj0yslZmR6kK7lVfUSIZabqjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7956

On 4/10/2025 12:53 PM, Christian Marangi wrote:
> Simplify .match_phy_device OP by using a generic function and using the
> new phy_id PHY driver info instead of hardcoding the matching PHY ID
> with new variant for macsec and no_macsec PHYs.
> 
> Also make use of PHY_ID_MATCH_MODEL macro and drop PHY_ID_MASK define to
> introduce phy_id and phy_id_mask again in phy_driver struct.
> 
> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/net/phy/nxp-c45-tja11xx.c | 45 ++++++++++++++-----------------
>  1 file changed, 20 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
> index bc2b7cc0cebe..8880547c4bfa 100644
> --- a/drivers/net/phy/nxp-c45-tja11xx.c
> +++ b/drivers/net/phy/nxp-c45-tja11xx.c
> @@ -19,7 +19,6 @@
>  
>  #include "nxp-c45-tja11xx.h"
>  
> -#define PHY_ID_MASK			GENMASK(31, 4)
>  /* Same id: TJA1103, TJA1104 */
>  #define PHY_ID_TJA_1103			0x001BB010
>  /* Same id: TJA1120, TJA1121 */
> @@ -1971,32 +1970,24 @@ static int nxp_c45_macsec_ability(struct phy_device *phydev)
>  	return macsec_ability;
>  }
>  
> -static int tja1103_match_phy_device(struct phy_device *phydev,
> -				    const struct phy_driver *phydrv)
> +static int tja11xx_no_macsec_match_phy_device(struct phy_device *phydev,
> +					      const struct phy_driver *phydrv)
>  {
> -	return phy_id_compare(phydev->phy_id, PHY_ID_TJA_1103, PHY_ID_MASK) &&
> -	       !nxp_c45_macsec_ability(phydev);
> -}
> +	if (!phy_id_compare(phydev->phy_id, phydrv->phy_id,
> +			    phydrv->phy_id_mask))
> +		return 0;
>  
> -static int tja1104_match_phy_device(struct phy_device *phydev,
> -				    const struct phy_driver *phydrv)
> -{
> -	return phy_id_compare(phydev->phy_id, PHY_ID_TJA_1103, PHY_ID_MASK) &&
> -	       nxp_c45_macsec_ability(phydev);
> +	return !nxp_c45_macsec_ability(phydev);
>  }
>  
> -static int tja1120_match_phy_device(struct phy_device *phydev,
> -				    const struct phy_driver *phydrv)
> +static int tja11xx_macsec_match_phy_device(struct phy_device *phydev,
> +					   const struct phy_driver *phydrv)
>  {
> -	return phy_id_compare(phydev->phy_id, PHY_ID_TJA_1120, PHY_ID_MASK) &&
> -	       !nxp_c45_macsec_ability(phydev);
> -}
> +	if (!phy_id_compare(phydev->phy_id, phydrv->phy_id,
> +			    phydrv->phy_id_mask))
> +		return 0;
>  
> -static int tja1121_match_phy_device(struct phy_device *phydev,
> -				    const struct phy_driver *phydrv)
> -{
> -	return phy_id_compare(phydev->phy_id, PHY_ID_TJA_1120, PHY_ID_MASK) &&
> -	       nxp_c45_macsec_ability(phydev);
> +	return nxp_c45_macsec_ability(phydev);
>  }
>  
>  static const struct nxp_c45_regmap tja1120_regmap = {
> @@ -2069,6 +2060,7 @@ static const struct nxp_c45_phy_data tja1120_phy_data = {
>  
>  static struct phy_driver nxp_c45_driver[] = {
>  	{
> +		PHY_ID_MATCH_MODEL(PHY_ID_TJA_1103),
>  		.name			= "NXP C45 TJA1103",
>  		.get_features		= nxp_c45_get_features,
>  		.driver_data		= &tja1103_phy_data,
> @@ -2090,9 +2082,10 @@ static struct phy_driver nxp_c45_driver[] = {
>  		.get_sqi		= nxp_c45_get_sqi,
>  		.get_sqi_max		= nxp_c45_get_sqi_max,
>  		.remove			= nxp_c45_remove,
> -		.match_phy_device	= tja1103_match_phy_device,
> +		.match_phy_device	= tja11xx_no_macsec_match_phy_device,
>  	},
>  	{
> +		PHY_ID_MATCH_MODEL(PHY_ID_TJA_1103),
>  		.name			= "NXP C45 TJA1104",
>  		.get_features		= nxp_c45_get_features,
>  		.driver_data		= &tja1103_phy_data,
> @@ -2114,9 +2107,10 @@ static struct phy_driver nxp_c45_driver[] = {
>  		.get_sqi		= nxp_c45_get_sqi,
>  		.get_sqi_max		= nxp_c45_get_sqi_max,
>  		.remove			= nxp_c45_remove,
> -		.match_phy_device	= tja1104_match_phy_device,
> +		.match_phy_device	= tja11xx_macsec_match_phy_device,
>  	},
>  	{
> +		PHY_ID_MATCH_MODEL(PHY_ID_TJA_1120),
>  		.name			= "NXP C45 TJA1120",
>  		.get_features		= nxp_c45_get_features,
>  		.driver_data		= &tja1120_phy_data,
> @@ -2139,9 +2133,10 @@ static struct phy_driver nxp_c45_driver[] = {
>  		.get_sqi		= nxp_c45_get_sqi,
>  		.get_sqi_max		= nxp_c45_get_sqi_max,
>  		.remove			= nxp_c45_remove,
> -		.match_phy_device	= tja1120_match_phy_device,
> +		.match_phy_device	= tja11xx_no_macsec_match_phy_device,
>  	},
>  	{
> +		PHY_ID_MATCH_MODEL(PHY_ID_TJA_1120),
>  		.name			= "NXP C45 TJA1121",
>  		.get_features		= nxp_c45_get_features,
>  		.driver_data		= &tja1120_phy_data,
> @@ -2164,7 +2159,7 @@ static struct phy_driver nxp_c45_driver[] = {
>  		.get_sqi		= nxp_c45_get_sqi,
>  		.get_sqi_max		= nxp_c45_get_sqi_max,
>  		.remove			= nxp_c45_remove,
> -		.match_phy_device	= tja1121_match_phy_device,
> +		.match_phy_device	= tja11xx_macsec_match_phy_device,
>  	},
>  };
>  

Reviewed-by: Andrei Botila <andrei.botila@oss.nxp.com>
Tested-by: Andrei Botila <andrei.botila@oss.nxp.com>


