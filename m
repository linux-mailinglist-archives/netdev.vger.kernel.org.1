Return-Path: <netdev+bounces-153095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAA49F6C5C
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 18:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D8017A385E
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 17:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2689A1F4284;
	Wed, 18 Dec 2024 17:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dLuqPV9/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF16E153BF7
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 17:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734543184; cv=fail; b=oKAVG6hfX8T4TYplfKWhI6DMQWoj5kGLw5LBF+/+wAt1hIbszXSQYNFE+LswPnhr93zv3hhHOI9PdWh9hbidlQvXyi9QiD/Pa9MWYdZtGLL34HZDGPzqgiUejWfTEgvLUEeQh5Ik7Ow2TiqW40iPbfaQZrtv4qSDIfWdCk1EXgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734543184; c=relaxed/simple;
	bh=q9a1tL7qXV+wKAY/1i+NAuZ/ZiGtk5l550TGU4OEAz4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QXN2YDj7iNJActppWTaI2QC4eb7q1shl+hSc5qKWaVS3V83tD73eqWx+hXjjC5sjoPE3f/UHLvgCyoZk9Hxsl4AvClJWoVncVYnK9iCdJaWOWE/H7r7+J1cu47fTfhbi2GA5Z+F00QtS9B/h+IUkjNGbTqTdV+iDxtpDKGCZo/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dLuqPV9/; arc=fail smtp.client-ip=40.107.92.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zm24bKqUGlsim1ILqvpCUnSU0veeu33yQt/HgOUrjWBaQZQPXEozIiZ0EyqWwJ6tq4Dp689IsCJwJc5iF/OJX0cpH4t2JtfnjffOQOgyQ1kHnZBIC4W/cg9ypAPHSK4O6axK/QHaLHOBPNWHtiVbetGW5+KvntuG+8mtJpNdwm0+3pqnyF3We93fYV8rhVPwHl/UNmm7EKxcpcrwAkJOFxqwUbMFf++NqF//t6dQEiK1oD8l7qPKOSYSeQ+PiIAZjLtfItfiLqH2lc88cZq5caMVqVRNZfNvh0+2Im4luhjnFH/EsgSG+Dy/mcO4THz7qpc80hySa+0nOP5h6L1Ygw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9a1tL7qXV+wKAY/1i+NAuZ/ZiGtk5l550TGU4OEAz4=;
 b=SX1C91aYkQO3aUCpSx9lkbkWB7RALbO49AcCIqH7QQFcyNMKe/NRX+jkiVowmTm//RntIRqd9HKoUE36vl+2z6emk8gTgImE5A9mUVYDVacGtlNNK+nbNNpuLTc1z8RyVUdii7NJvq22Od2Zh3i319PVu/2szWCdoBwltJEX4frFdwwjoBdAa8/GNfbEdQIwxoEDfMcDaUyStE1Ooa+/IweRMkVXwpPxI9NH3QIZ4divIauKvKHzyBNYrgKkxTiGrqhv6l+apted5oPisGq91zDUvuipTYgOz+OzICYLf8IsPIBvRNT4M1+oKGTMCoks1g7KCEA0pwEbPNVy29u1sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9a1tL7qXV+wKAY/1i+NAuZ/ZiGtk5l550TGU4OEAz4=;
 b=dLuqPV9//5AyQTI/lbUtwsxPJTjn1vbp2YT349/dDVLetHZIHCFnmVGZDTjpLbFmHTQIPlErutCgKM/IZGZgpHyy/xKl4WfcW+PwLWLpBOU/dPrCDbFY0bbebJRPxGy4YU+JxaW/TO9C12xEZ+7ZqKR7CWiEGlK7uQJ4qA5TKEFGv9KMFu8AVXPeZf6vcrEy+aDZAfvBABlbDsaWHul1lcyqJgJSDydjL/zudoMqB1nZkzC9iQ2mCg8qm187bAgGAUvilLWTZ3Olv/skeP08aMQp56kQsVD1BhHmNox06CP6roT6QybumaPpIu+T3cFzYTDSKWo5fhryy1LZTBBWzA==
Received: from CH2PR12MB4858.namprd12.prod.outlook.com (2603:10b6:610:67::7)
 by SJ1PR12MB6314.namprd12.prod.outlook.com (2603:10b6:a03:457::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.12; Wed, 18 Dec
 2024 17:32:58 +0000
Received: from CH2PR12MB4858.namprd12.prod.outlook.com
 ([fe80::615:9477:2990:face]) by CH2PR12MB4858.namprd12.prod.outlook.com
 ([fe80::615:9477:2990:face%6]) with mapi id 15.20.8272.013; Wed, 18 Dec 2024
 17:32:58 +0000
From: Yong Wang <yongwang@nvidia.com>
To: Nikolay Aleksandrov <razor@blackwall.org>, Roopa Prabhu
	<roopa@nvidia.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Andy Roulin <aroulin@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, Nithya
 Miyar <nmiyar@nvidia.com>
Subject: Re: [RFC v2 net-next 1/2] net: bridge: multicast: re-implement port
 multicast enable/disable functions
Thread-Topic: [RFC v2 net-next 1/2] net: bridge: multicast: re-implement port
 multicast enable/disable functions
Thread-Index: AQHbTRAdG4GdAD18u0y1UHyZZ5sEvbLsEW2A//+0F4A=
Date: Wed, 18 Dec 2024 17:32:57 +0000
Message-ID: <59D84867-D6A7-4695-9983-640980117264@nvidia.com>
References: <20241213033551.3706095-1-yongwang@nvidia.com>
 <20241213033551.3706095-2-yongwang@nvidia.com>
 <fb4027a7-48a7-4488-a008-584d3b69c025@blackwall.org>
In-Reply-To: <fb4027a7-48a7-4488-a008-584d3b69c025@blackwall.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4858:EE_|SJ1PR12MB6314:EE_
x-ms-office365-filtering-correlation-id: c9ee6248-5c0a-43ba-5d31-08dd1f8a037b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aXRLRkdpUGc1bTd1RjNLbzZjaEh4a3ZUTGY0eWhpQXpMNU5NNEpyZU5lNmtx?=
 =?utf-8?B?ekpQTWR0YUF6RW9kZ25CemFKbFZnOW1YTVd1YjFacStkTFBRT1U1YnJTOXcy?=
 =?utf-8?B?UjdFTlcwQTFxTzZXbmJVWlB0Ty9xTkJNSXBCSExrUWhReHlUd0pJYk5zWVpl?=
 =?utf-8?B?NkhtNmtWZXZKMHhDVGpwY09NOTVTTnVQVGJSV0R6eUF5Z1ZWRkVacG9XVjFo?=
 =?utf-8?B?UWt4ZkNrT3p1ek4zMm9MdW9hOElIZExyeEpWM3JjbENwTWVEdXRwSS9YWTQr?=
 =?utf-8?B?R2lTb09SWTZKdGhid3NCbU5UZUxvcmVVcldXK3h3dDRlaUlnUXlqdzZpQXlI?=
 =?utf-8?B?WEEvVWF0V25vQ01kL0NjU2lOYTk1K29IY2MwejFxaDBvZGd3WnNEWmVaVVQ3?=
 =?utf-8?B?VFVJNXBjN0lMZi9qVUNVMVlHOTJMNGxQdURwZTVEQlZ4RW4xb0IwSXhIbkRn?=
 =?utf-8?B?aDhJdGZ6Q3c0Z3BGQlpJU29JWlZMaXZTdWFBaEVBL3ZoWmxJUG9KTE9nQnQ3?=
 =?utf-8?B?WTA1M0ZhZUtTTjJkWFl1b1FUZGdVMzRsWlM0RFZKOUZiYlpBOWlNQWM3cElX?=
 =?utf-8?B?STNSTlJqSUVoeGhTbjlNaHN0RnZ1UjF1bkFKa1NJOG4wc3FnSXZ2RXRzbVVt?=
 =?utf-8?B?SjZuRVU2Y1FMNnppV2dqRkVodlR2VHVjYnY2bmlyWXF5VTVLdWVHOWxPUERa?=
 =?utf-8?B?a3FzY09VVmcrczdqR0Zsa2xvbmtjWk55MUJZbk9wVm14cTk0Vk1pYXVUODFJ?=
 =?utf-8?B?UDQrWTdJUDNOczBnRDdwVkJMMVNLckFsSVN3N1g4c0xuZktSb1pGVmtabG1k?=
 =?utf-8?B?cnJuTjBMZmJOSktsUjh2NDZDNkh4cURpODBVQkhHL2NBL285SjFyU2VtTCtD?=
 =?utf-8?B?SDFhdURycSs0ODIxSUY0THlNTWRGK3M1QjFEM0diQmJXR2EzWGVyZnRQcVUv?=
 =?utf-8?B?ejIrMmdIQjR4K2hUWDQ4UVlic0JUb1B0OGtXZTFhUmZpeGZSV0MxbCtlN29J?=
 =?utf-8?B?SHFOOExSQ1R4SnZLOTNrdGhaeWNHUVpJeWVOMWo2c1ZjRVROM1NPNVE1REQ4?=
 =?utf-8?B?MmFGMU5aSVZWSmVoaG5EWXU0UXlSc25FVnVLY2VHR1l6b2IrVitYalVhbUY0?=
 =?utf-8?B?NHpwSGhlZWNOQkNnNEsvME9DOGZjSWVtOWNvUVdheGlhaGVEdlZWR0JTclBi?=
 =?utf-8?B?TVNrU1pic0R5MG1CdFJERlJmcGZ3Uko1ank1ZWdxWjdsS0dVU1N2ajYrMkZZ?=
 =?utf-8?B?dXJXdnlJUnFZL2k1YXlzeUZqUmtiNWxZQmJhQ0txVzBwTEJjUWlDc09xbEdN?=
 =?utf-8?B?aXUvNFFxTkF5dUR0YXQ3Y0kyS3VlS25ERGh3UUlRWElTODVCSGFNdEtQM2dI?=
 =?utf-8?B?Qy91aVREVXdaNW9DbTVVV3ZhYk10djFadCtHb09yTVY4a25RWGwrYnJ0QUVC?=
 =?utf-8?B?a3YwYnVFcmdQNkE4bVRiTm0rZUlUdTFHRGxWZkNONnhKcDRzOWJRMGpTb0VK?=
 =?utf-8?B?dHU1djJQZGZwSi8rUERhZzZjMmlIaVI3SzFoR3FOQW1lUzFiYVdKUTRSR2wr?=
 =?utf-8?B?WTdQRGgrdmkxbEF3TUtoZVYwWXh1Zkl5cU8vOThIU2hqOUtJYUVCVmVLTVpm?=
 =?utf-8?B?NzhENk1SVm96Njd0M01pOWVmRktNdStSS1R0cWg4azJlR3RTVkRkYTVtQ1dh?=
 =?utf-8?B?R05XbFhqWm5wdmlHMktnajNxUXZxWlFUSjFiL2QzT2w4OGVQUEFtMGtMOUpu?=
 =?utf-8?B?ZHd1b04xcEd0NUludVZ3dk0yMVhvdG43a0lJWXZyT0NJcEcreVlvdmNoSjlr?=
 =?utf-8?B?blhOYWF0ZnpQVHJPRFN6V2tmNnhjdkhLSjVGcG5maU9LREJKVk5HWWZSbnh4?=
 =?utf-8?B?TUNDUE8yNXlIcWJZZUNocWUrQ2lKNTBJQlRhZXA1TDUycTYxR3NOTFZJZy84?=
 =?utf-8?Q?m4VuSFHbcOZv0ClHWtt1bAmMY/k2PPun?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4858.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OVBUT1A2R2c4ZzZEV08wZTdmNUkza1hvSzZFK2tZcWtwYnJWbG5yVFJjSStw?=
 =?utf-8?B?NVhFRjRqMGVDWGp6TDR5UGRsTU5UempZMkNESjk3NExuZTVnZmhGZHVVSExI?=
 =?utf-8?B?cEJMOXdnZ1JTelh2eVZvMFVyV2VVY0c5NTNkeXFqOGlhSlYwckpZL3A3cmVL?=
 =?utf-8?B?M3pCdStRcm5EcDhBY2NISWpxcVFTMDFvZTZzWk1QZW9OWkg1Qk01VnFrbWpC?=
 =?utf-8?B?cTJBU3IrVy9NREhVTi9UUWoyR25VZGQ1WHVZWVFrSm1sVGJ2SmZJRWtXUEJV?=
 =?utf-8?B?emRiNGVpQVB4R25qUTdXRWxseTZacjJLdk9SeEVvbUpkamduYTdoWkJqcDBO?=
 =?utf-8?B?dWdXT3cwR2x2SzM4NlUwQWgyR1EvcGNHMVJiTkJGaU16Qk9tVzVMeDVZUzVo?=
 =?utf-8?B?YWRMUVR3UCtYUFRIZTU3TVgyL1grMGZ6MEhiTkowQ3BlVGR4RG13OUtRL2o1?=
 =?utf-8?B?aXViSTBqazBVUmgwUVk3VU1EUUVWemZRWFFKY0taS0twKzdQQVp1NWdqaWV3?=
 =?utf-8?B?NlpZMjV5RjVuSHA1NUo3L1Q0bHR4RmtjaS8vZ0NKRDlHUWVwQ2NwR29JcXBx?=
 =?utf-8?B?VDVwOGtXeFlPT0ZjYXJ0VzZUbklrd01hVVZmM1VjdC8wbHVCcmQ1OU0xb202?=
 =?utf-8?B?RUFsd0treDVKR3Zid0ZtRW0rQWg1VEEzWHFaZHJjSlNnOXlyR1ZJbDRtSUlM?=
 =?utf-8?B?bTVrdWppRktycTJxZEd2a1ErYWNBckhsK3FZK014cHljQkNFM3pqcUl0WnJD?=
 =?utf-8?B?RmFxako5azMzWmliRjloQWliS21iV0RaUG42REVrTFc1blM1a3FuSnZkeVpO?=
 =?utf-8?B?dWV6eG4wU3BqQXdub2loaUVxZmVLRGoxL3dqMFpjbnRRUStKNnNyRUtoK1ZR?=
 =?utf-8?B?ZGRyMTByM3UxSnlkRHUyTTJ1SzRJbHNKZG1LYlRHSmprcm9xQkhyRHN5bUZh?=
 =?utf-8?B?RytPK1JlVmJaa3lhbzdLKzQvQzB2ZGJzdTNNb1hUT0NKalRYUkpocFNKY3hi?=
 =?utf-8?B?eUZzMEhsZHM4bm5iazd5NnVMN1B3M1Q0dXVXQkcvRVhFSnRUTkNldWM2MHBV?=
 =?utf-8?B?QzhMQjd6MVVQZXJWeGJCNnV0Qmt0L2NZL3RML0pkRitMRms1WUdET3RFQ0E2?=
 =?utf-8?B?ZjVwS1dNNW1yeU1jUTVIcE9yTUtQeFk1TW8wK1NqbW1TWGZCRUphMEMzV3Ja?=
 =?utf-8?B?VE9heWZoUHY3V0tueDR1RzFEZVBKQlRxRUJpU1Q0OXNoYjJRWCtlVG50dHRn?=
 =?utf-8?B?ZVFCMGNPQWhqRkRZUzA0Vzd2QUFhelBiVmVpUHJ3Tm0vaHpMdlBYUzBuZW5r?=
 =?utf-8?B?UTg0TERNUGhhK1ZwTnJDM2pGN1U1VWxBSXZhcDJRei82MTR2RHhiN1B0cmVt?=
 =?utf-8?B?K01JWDVCcUhqQVZPSUphWGFJMHNBcGV3R2E2K2RFRFRhWHhwVThHZ1BuWmtP?=
 =?utf-8?B?b3h6eERUMWRjaTRsOGpvSEtQUzc2aW9IVTdYaUVUZ2FCODhDRlBvbUlUVml0?=
 =?utf-8?B?ZWw5bWdhc2JLUVU2Z0NvOHdJMlJXQ3F4VjdNaTZVUHhad1JqUnQ1NjY3VExQ?=
 =?utf-8?B?WHVJV2Y3cmJkZ3JLUnE3ZWUxMDJmYzJqUlFDWmY2RlFuVVE0eTBSM090bmho?=
 =?utf-8?B?aTkrNlJMRVlEMjlGc0ZoRC96UmVjdURvdDQ4VGx3dndsMC93eEpCUXlqS0Rh?=
 =?utf-8?B?TjRNenhCYmlVSUpGY2ZNNWpmR29QREJwdmFxZ0RtSnpmRmJBTzlZS0g0bU1N?=
 =?utf-8?B?blJIUjQvNUsyVE9GYWFnMnhqdHJFYnM1aVhNVGJWZzZ5VUx3OFJSZ0d6TWlL?=
 =?utf-8?B?THNqMGFOVHJVdEk4SFAxUzFoT2pZbitaNHVMMW84NmZ6dzNFUXhuMkFKMmVt?=
 =?utf-8?B?Y0piS1Y1bUpTbW1KbFk5Znd4eXFXbHBKVExPVzdXWElndEE1Mmg5R1puc3F3?=
 =?utf-8?B?bmppQkpLQ3g5WWNOMUg2UFdzVkc1ckhtdHp2ODJTNVE4emtnc1IraHdMWmJ2?=
 =?utf-8?B?Vk5haHlmS0Ezc2tpTzd3bVprQ0JUaEhnN252RS9RZ1Q5NXVSUnJJazVrNldx?=
 =?utf-8?B?aGV4S2h6UVFhY0FudzJSb2dBYmFXVjhlTTZES0F5UVdjZ2JHUTBBUGc5UDRl?=
 =?utf-8?Q?TLFoFN8SVDnpJLbRFNJD82E4M?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EBAD28A602BDA94DAA4C8DE2924DD1FD@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4858.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ee6248-5c0a-43ba-5d31-08dd1f8a037b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2024 17:32:58.0242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TFdT2m5+fCj5iNVfUj86bBgaIXRRODOqJgK8E2ZvPZ6uSv7+s34W3x24H+CQ6eVEywbOIaqNzrPMzHSB/2xz9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6314

DQpPbiAxMi8xOC8yNCwgNjowNCBBTSwgIk5pa29sYXkgQWxla3NhbmRyb3YiIDxyYXpvckBibGFj
a3dhbGwub3JnIDxtYWlsdG86cmF6b3JAYmxhY2t3YWxsLm9yZz4+IHdyb3RlOg0KDQoNCj5PbiAx
My8xMi8yMDI0IDA1OjM1LCBZb25nIFdhbmcgd3JvdGU6DQo+PiBSZS1pbXBsZW1lbnQgYnJfbXVs
dGljYXN0X2VuYWJsZV9wb3J0KCkgLyBicl9tdWx0aWNhc3RfZGlzYWJsZV9wb3J0KCkgYnkNCj4+
IGFkZGluZyBicl9tdWx0aWNhc3RfdG9nZ2xlX3BvcnQoKSBoZWxwZXIgZnVuY3Rpb24gaW4gb3Jk
ZXIgdG8gc3VwcG9ydA0KPj4gcGVyIHZsYW4gbXVsdGljYXN0IGNvbnRleHQgZW5hYmxpbmcvZGlz
YWJsaW5nIGZvciBicmlkZ2UgcG9ydHMuIEFzIHRoZQ0KPj4gcG9ydCBzdGF0ZSBjb3VsZCBiZSBj
aGFuZ2VkIGJ5IFNUUCwgdGhhdCBpbXBhY3RzIG11bHRpY2FzdCBiZWhhdmlvcnMNCj4+IGxpa2Ug
aWdtcCBxdWVyeS4gVGhlIGNvcnJlc3BvbmRpbmcgY29udGV4dCBzaG91bGQgYmUgdXNlZCBlaXRo
ZXIgZm9yDQo+PiBwZXIgcG9ydCBjb250ZXh0IG9yIHBlciB2bGFuIGNvbnRleHQgYWNjb3JkaW5n
bHkuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogWW9uZyBXYW5nIDx5b25nd2FuZ0BudmlkaWEuY29t
IDxtYWlsdG86eW9uZ3dhbmdAbnZpZGlhLmNvbT4+DQo+PiBSZXZpZXdlZC1ieTogQW5keSBSb3Vs
aW4gPGFyb3VsaW5AbnZpZGlhLmNvbSA8bWFpbHRvOmFyb3VsaW5AbnZpZGlhLmNvbT4+DQo+PiAt
LS0NCj4+IG5ldC9icmlkZ2UvYnJfbXVsdGljYXN0LmMgfCA3MiArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrLS0tLS0NCj4+IDEgZmlsZSBjaGFuZ2VkLCA2NCBpbnNlcnRpb25zKCsp
LCA4IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9uZXQvYnJpZGdlL2JyX211bHRp
Y2FzdC5jIGIvbmV0L2JyaWRnZS9icl9tdWx0aWNhc3QuYw0KPj4gaW5kZXggYjJhZTBkMjQzNGQy
Li42NzQzOGE3NWJhYmQgMTAwNjQ0DQo+PiAtLS0gYS9uZXQvYnJpZGdlL2JyX211bHRpY2FzdC5j
DQo+PiArKysgYi9uZXQvYnJpZGdlL2JyX211bHRpY2FzdC5jDQo+PiBAQCAtMjEwNSwxMiArMjEw
NSwxNyBAQCBzdGF0aWMgdm9pZCBfX2JyX211bHRpY2FzdF9lbmFibGVfcG9ydF9jdHgoc3RydWN0
IG5ldF9icmlkZ2VfbWNhc3RfcG9ydCAqcG1jdHgpDQo+PiB9DQo+PiB9DQo+Pg0KPj4gLXZvaWQg
YnJfbXVsdGljYXN0X2VuYWJsZV9wb3J0KHN0cnVjdCBuZXRfYnJpZGdlX3BvcnQgKnBvcnQpDQo+
PiArc3RhdGljIHZvaWQgYnJfbXVsdGljYXN0X2VuYWJsZV9wb3J0X2N0eChzdHJ1Y3QgbmV0X2Jy
aWRnZV9tY2FzdF9wb3J0ICpwbWN0eCkNCj4+IHsNCj4+IC0gc3RydWN0IG5ldF9icmlkZ2UgKmJy
ID0gcG9ydC0+YnI7DQo+PiArIHN0cnVjdCBuZXRfYnJpZGdlICpiciA9IHBtY3R4LT5wb3J0LT5i
cjsNCj4+DQo+PiBzcGluX2xvY2tfYmgoJmJyLT5tdWx0aWNhc3RfbG9jayk7DQo+PiAtIF9fYnJf
bXVsdGljYXN0X2VuYWJsZV9wb3J0X2N0eCgmcG9ydC0+bXVsdGljYXN0X2N0eCk7DQo+PiArIGlm
IChicl9tdWx0aWNhc3RfcG9ydF9jdHhfaXNfdmxhbihwbWN0eCkgJiYNCj4+ICsgIShwbWN0eC0+
dmxhbi0+cHJpdl9mbGFncyAmIEJSX1ZMRkxBR19NQ0FTVF9FTkFCTEVEKSkgew0KPj4gKyBzcGlu
X3VubG9ja19iaCgmYnItPm11bHRpY2FzdF9sb2NrKTsNCj4+ICsgcmV0dXJuOw0KPj4gKyB9DQo+
PiArIF9fYnJfbXVsdGljYXN0X2VuYWJsZV9wb3J0X2N0eChwbWN0eCk7DQo+PiBzcGluX3VubG9j
a19iaCgmYnItPm11bHRpY2FzdF9sb2NrKTsNCj4+IH0NCj4+DQo+PiBAQCAtMjEzNywxMSArMjE0
Miw2MiBAQCBzdGF0aWMgdm9pZCBfX2JyX211bHRpY2FzdF9kaXNhYmxlX3BvcnRfY3R4KHN0cnVj
dCBuZXRfYnJpZGdlX21jYXN0X3BvcnQgKnBtY3R4KQ0KPj4gYnJfbXVsdGljYXN0X3Jwb3J0X2Rl
bF9ub3RpZnkocG1jdHgsIGRlbCk7DQo+PiB9DQo+Pg0KPj4gK3N0YXRpYyB2b2lkIGJyX211bHRp
Y2FzdF9kaXNhYmxlX3BvcnRfY3R4KHN0cnVjdCBuZXRfYnJpZGdlX21jYXN0X3BvcnQgKnBtY3R4
KQ0KPj4gK3sNCj4+ICsgc3RydWN0IG5ldF9icmlkZ2UgKmJyID0gcG1jdHgtPnBvcnQtPmJyOw0K
Pj4gKw0KPj4gKyBzcGluX2xvY2tfYmgoJmJyLT5tdWx0aWNhc3RfbG9jayk7DQo+PiArIGlmIChi
cl9tdWx0aWNhc3RfcG9ydF9jdHhfaXNfdmxhbihwbWN0eCkgJiYNCj4+ICsgIShwbWN0eC0+dmxh
bi0+cHJpdl9mbGFncyAmIEJSX1ZMRkxBR19NQ0FTVF9FTkFCTEVEKSkgew0KPj4gKyBzcGluX3Vu
bG9ja19iaCgmYnItPm11bHRpY2FzdF9sb2NrKTsNCj4+ICsgcmV0dXJuOw0KPj4gKyB9DQo+PiAr
DQo+PiArIF9fYnJfbXVsdGljYXN0X2Rpc2FibGVfcG9ydF9jdHgocG1jdHgpOw0KPj4gKyBzcGlu
X3VubG9ja19iaCgmYnItPm11bHRpY2FzdF9sb2NrKTsNCj4+ICt9DQo+PiArDQo+PiArc3RhdGlj
IHZvaWQgYnJfbXVsdGljYXN0X3RvZ2dsZV9wb3J0KHN0cnVjdCBuZXRfYnJpZGdlX3BvcnQgKnBv
cnQsIGJvb2wgb24pDQo+PiArew0KPj4gKyBzdHJ1Y3QgbmV0X2JyaWRnZSAqYnIgPSBwb3J0LT5i
cjsNCj4+ICsNCj4+ICsgaWYgKGJyX29wdF9nZXQoYnIsIEJST1BUX01DQVNUX1ZMQU5fU05PT1BJ
TkdfRU5BQkxFRCkpIHsNCj4+ICsgc3RydWN0IG5ldF9icmlkZ2Vfdmxhbl9ncm91cCAqdmc7DQo+
PiArIHN0cnVjdCBuZXRfYnJpZGdlX3ZsYW4gKnZsYW47DQo+PiArDQo+PiArIHJjdV9yZWFkX2xv
Y2soKTsNCj4+ICsgdmcgPSBuYnBfdmxhbl9ncm91cF9yY3UocG9ydCk7DQo+PiArIGlmICghdmcp
IHsNCj4+ICsgcmN1X3JlYWRfdW5sb2NrKCk7DQo+PiArIHJldHVybjsNCj4+ICsgfQ0KPj4gKw0K
Pj4gKyAvKiBpdGVyYXRlIGVhY2ggdmxhbiBvZiB0aGUgcG9ydCwgdG9nZ2xlIHBvcnRfbWNhc3Rf
Y3R4IHBlciB2bGFuICovDQo+PiArIGxpc3RfZm9yX2VhY2hfZW50cnkodmxhbiwgJnZnLT52bGFu
X2xpc3QsIHZsaXN0KSB7DQo+DQo+DQo+bGlzdF9mb3JfZWFjaF9lbnRyeV9yY3UoKQ0KPg0KDQpB
Q0ssIHRoYW5rIHlvdSBzbyBtdWNoIQ0KDQo+DQo+PiArIC8qIGVuYWJsZSBwb3J0X21jYXN0X2N0
eCB3aGVuIHZsYW4gaXMgTEVBUk5JTkcgb3IgRk9SV0FSRElORyAqLw0KPj4gKyBpZiAob24gJiYg
YnJfdmxhbl9zdGF0ZV9hbGxvd2VkKGJyX3ZsYW5fZ2V0X3N0YXRlKHZsYW4pLCB0cnVlKSkNCj4+
ICsgYnJfbXVsdGljYXN0X2VuYWJsZV9wb3J0X2N0eCgmdmxhbi0+cG9ydF9tY2FzdF9jdHgpOw0K
Pj4gKyBlbHNlDQo+PiArIGJyX211bHRpY2FzdF9kaXNhYmxlX3BvcnRfY3R4KCZ2bGFuLT5wb3J0
X21jYXN0X2N0eCk7DQo+PiArIH0NCj4+ICsgcmN1X3JlYWRfdW5sb2NrKCk7DQo+PiArIH0gZWxz
ZSB7DQo+PiArIC8qIHVzZSB0aGUgcG9ydCdzIG11bHRpY2FzdCBjb250ZXh0IHdoZW4gdmxhbiBz
bm9vcGluZyBpcyBkaXNhYmxlZCAqLw0KPj4gKyBpZiAob24pDQo+PiArIGJyX211bHRpY2FzdF9l
bmFibGVfcG9ydF9jdHgoJnBvcnQtPm11bHRpY2FzdF9jdHgpOw0KPj4gKyBlbHNlDQo+PiArIGJy
X211bHRpY2FzdF9kaXNhYmxlX3BvcnRfY3R4KCZwb3J0LT5tdWx0aWNhc3RfY3R4KTsNCj4+ICsg
fQ0KPj4gK30NCj4+ICsNCj4+ICt2b2lkIGJyX211bHRpY2FzdF9lbmFibGVfcG9ydChzdHJ1Y3Qg
bmV0X2JyaWRnZV9wb3J0ICpwb3J0KQ0KPj4gK3sNCj4+ICsgYnJfbXVsdGljYXN0X3RvZ2dsZV9w
b3J0KHBvcnQsIHRydWUpOw0KPj4gK30NCj4+ICsNCj4+IHZvaWQgYnJfbXVsdGljYXN0X2Rpc2Fi
bGVfcG9ydChzdHJ1Y3QgbmV0X2JyaWRnZV9wb3J0ICpwb3J0KQ0KPj4gew0KPj4gLSBzcGluX2xv
Y2tfYmgoJnBvcnQtPmJyLT5tdWx0aWNhc3RfbG9jayk7DQo+PiAtIF9fYnJfbXVsdGljYXN0X2Rp
c2FibGVfcG9ydF9jdHgoJnBvcnQtPm11bHRpY2FzdF9jdHgpOw0KPj4gLSBzcGluX3VubG9ja19i
aCgmcG9ydC0+YnItPm11bHRpY2FzdF9sb2NrKTsNCj4+ICsgYnJfbXVsdGljYXN0X3RvZ2dsZV9w
b3J0KHBvcnQsIGZhbHNlKTsNCj4+IH0NCj4+DQo+PiBzdGF0aWMgaW50IF9fZ3JwX3NyY19kZWxl
dGVfbWFya2VkKHN0cnVjdCBuZXRfYnJpZGdlX3BvcnRfZ3JvdXAgKnBnKQ0KPj4gQEAgLTQzMDQs
OSArNDM2MCw5IEBAIGludCBicl9tdWx0aWNhc3RfdG9nZ2xlX3ZsYW5fc25vb3Bpbmcoc3RydWN0
IG5ldF9icmlkZ2UgKmJyLCBib29sIG9uLA0KPj4gX19icl9tdWx0aWNhc3Rfb3BlbigmYnItPm11
bHRpY2FzdF9jdHgpOw0KPj4gbGlzdF9mb3JfZWFjaF9lbnRyeShwLCAmYnItPnBvcnRfbGlzdCwg
bGlzdCkgew0KPj4gaWYgKG9uKQ0KPj4gLSBicl9tdWx0aWNhc3RfZGlzYWJsZV9wb3J0KHApOw0K
Pj4gKyBicl9tdWx0aWNhc3RfZGlzYWJsZV9wb3J0X2N0eCgmcC0+bXVsdGljYXN0X2N0eCk7DQo+
PiBlbHNlDQo+PiAtIGJyX211bHRpY2FzdF9lbmFibGVfcG9ydChwKTsNCj4+ICsgYnJfbXVsdGlj
YXN0X2VuYWJsZV9wb3J0X2N0eCgmcC0+bXVsdGljYXN0X2N0eCk7DQo+PiB9DQo+Pg0KPj4gbGlz
dF9mb3JfZWFjaF9lbnRyeSh2bGFuLCAmdmctPnZsYW5fbGlzdCwgdmxpc3QpDQoNCg0KDQoNCg==

