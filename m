Return-Path: <netdev+bounces-152638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D55549F4F2F
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 16:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DBD018823F3
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 15:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92061F75AD;
	Tue, 17 Dec 2024 15:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="feOSULtC"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84DD1F709A
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 15:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734448502; cv=fail; b=JLpBQkwk3PZwZEi1bnS5cH8S8YIt2jgQoc+N7l1z9mmpAkAbSigcQA17O4Dyp+yRBdfAaH2W+ZHO+iR8ZQiMxeJaR9JVlVK7f4n0zojl1EngQKQMQoBTg0s8KxC62W9jV7wCL5R/VhtfP/AxEA0q9W4UDi0h+++OxI4TZr33peg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734448502; c=relaxed/simple;
	bh=OiVrbHHzD4q1mw0dkZhwS48QOtQG8CK5TDwgEWD+bFw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kjhg6NqpFxXnyAfwiisRDA54vQWGZVR1JgYCR3bikTUU2jgpGrPgqWJIVAGjrjvjgir+YI46siRadyzscwJriu+LB3DMOCjVF2KXr4BSVdSkDomOIFmhJq7qFPi63xAW/rPwcs5a4FqP904+YX9zVjQSzq5VFr9NscGbSKMP4Jw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=feOSULtC; arc=fail smtp.client-ip=40.107.243.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UkQAKlUamzhqia86KVhir7DtTMxwaiPi3j/nXKl/FZtph9hW9vIg5QfknJ9LQQg3Fh0W6A/ApkbT3MVxzWV98GpSCWbJvJM95/Ps5awgQi8hkEr3bCZQsMHr/hNg+2OcHjvHSTgmzZJQm45bNxj0WRuGo4q74bOviA2wUbaedarEzmY3IN2NdTp9YMVswaEEWuJMpt/IbUAKmT+U0XsdssIWtszelp3HsoLXC7fE0YOMv6n6DQNyGOZ+f+C5Bgjx0Gj6z7hoZwD7Ie0Cz5bH9W2Pw6TVHrZHaoWl5gJgEOVb3aE7c21jRskdXZLJVYtg/78YhQfkFCTEbUaSz9hOaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OiVrbHHzD4q1mw0dkZhwS48QOtQG8CK5TDwgEWD+bFw=;
 b=BvcDl49us2RE/AbogsM2vpKsIhMHlMMAMLml7h37AjrQCkpq674bGZMjfgJaM7tPMSV9W/KtOrPoMU+F8eWwdIPSQ96REjzzMeXa2Efn1kuPjDD4Fcy4sC4mEDEaNwKsZqLtm5RKRbT4qrGJ3U6gxTqFOOfQnZ5Dir4YptB8tCpHSHMF65m2DGynAq80tKbkmHH6z4Cg9ngSeuTsmFmIo5rrJdtHXV3IObu0Pf3wM3wFpl5TEggJmKHvZeCJZgr3jWrl2GKs9Is9cNe6ZM5l2PZA4k1I+w3+t3ngB83w4y4a88mvLSy2o/UU1ldtmp1e6+AysPrt5QrHgEp+CdPMeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OiVrbHHzD4q1mw0dkZhwS48QOtQG8CK5TDwgEWD+bFw=;
 b=feOSULtCU0S9dvP9420uLbW3ju5xLTsuF+iS3wsurR9PqpFKbaHpxvlpoIloKgJwF26XEk6UwbDAuGM9BALuwv3U8Rb8fZ1qIBh5xGyGMCJvyhfcMv0IP9m9m9qacc92zw0yeK4ZLcUhT4HyAp0bbBiDjl1xPD8Gau9z+1hWwwq3AEfnsMdwWiqAFIG0Tlt79VMupOEnFrcddO7gS4k9bRnR1OPPSxjKmyaQw74KIfFa9KRR+KwCmKzBafljXhXd3tgIyUdUTomkbzDiPe26ja8AXQbXLfqI8kTbYX2HAaEUNqF5l9C441ZN/byOYGKbVlf06/C44TdYM7UsGyenJw==
Received: from DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) by
 MN0PR12MB5954.namprd12.prod.outlook.com (2603:10b6:208:37d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Tue, 17 Dec
 2024 15:14:58 +0000
Received: from DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af]) by DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af%7]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 15:14:58 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "kuba@kernel.org" <kuba@kernel.org>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "ttoukan.linux@gmail.com"
	<ttoukan.linux@gmail.com>, Tariq Toukan <tariqt@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"jiri@resnulli.us" <jiri@resnulli.us>, Leon Romanovsky <leonro@nvidia.com>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next V5 00/11] net/mlx5: ConnectX-8 SW Steering + Rate
 management on traffic classes
Thread-Topic: [PATCH net-next V5 00/11] net/mlx5: ConnectX-8 SW Steering +
 Rate management on traffic classes
Thread-Index:
 AQHbRpmNrHzTfY3l9kW9Sl/INZi8E7LaDhaAgARGzICAACQugIACXauAgAEMU4CAAlmFAIAFw/oAgACfHYA=
Date: Tue, 17 Dec 2024 15:14:58 +0000
Message-ID: <14a4d5351081551d2e1266bf26c5b7384ed2b44f.camel@nvidia.com>
References: <20241204220931.254964-1-tariqt@nvidia.com>
	 <20241206181345.3eccfca4@kernel.org>
	 <d4890336-db2d-49f6-9502-6558cbaccefa@gmail.com>
	 <20241209134141.508bb5be@kernel.org>
	 <1593e9dd015dafcce967a9c328452ff963a69d68.camel@nvidia.com>
	 <20241211174949.2daa6046@kernel.org>
	 <73d7745697a9ab7507c5e4800b0dfc547823d475.camel@nvidia.com>
	 <20241216214528.42dc9a1b@kernel.org>
In-Reply-To: <20241216214528.42dc9a1b@kernel.org>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6560:EE_|MN0PR12MB5954:EE_
x-ms-office365-filtering-correlation-id: 549a9234-6d8d-4013-6545-08dd1ead91d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dGJuUnRaM3VEeGxBR0pDL2lZUCsrUm1WR2V2T0VkSzBOWloyVEQycXBGZUFG?=
 =?utf-8?B?T0RoejVMb3ZqcnZacklHUjQzUTViTkwvWENxTWN0RXR4dWZpNE1uVFVzQWdJ?=
 =?utf-8?B?QWtZM0kvVkZJcGRQMWxoUEY0bUpwTFJITFZodTdWbE9idFE4V3JrenZLOG5U?=
 =?utf-8?B?WjFqS050RjlkdEw4dU0yNFNLUFJ3azdNaWllVDZVNlhvWnVMRlZyUTBwMG5o?=
 =?utf-8?B?bnc4WGFZclBYZjZXRkFRRVpNMm9pRFh4R3NwTUpJSDgwem4rcVIxSnpDbjIz?=
 =?utf-8?B?dzFwQzNLVVFjN2d0Z2JPenNoR2xlUCs4RlBjbVA5bnovejBsbFdjZnBUS05L?=
 =?utf-8?B?QnFqd3VTTjBwaVk4Y0JVTTNmVkpMNW5YZEdzTEhFelU5OGZtVHdZZ3lBMWFV?=
 =?utf-8?B?K1BXUERucjJwTzVoV3lLUzdBU2l4VXZIazRxZnNpQ2wzY3JqaWNMeUx1bGNN?=
 =?utf-8?B?TE1qZENoekswWFNUSHRyYndiQlVGbVhyTkRXWmkxUTBlQ3Z6WjQybnZUNUw5?=
 =?utf-8?B?WDM2OWxKUWFpWmFuWktFSUJoYmxBT0xDeEFqcHlHVnM0NlVLMDJpL3ArbXhs?=
 =?utf-8?B?TkNvTms4TWM4WlRGVW9PUXdTQWdjbW8zMUFTWE03Sk1ZTWhjcHF0WkVwN0FP?=
 =?utf-8?B?bTYrK2hpYVhRUDZvb3JCMTFJSXl1dWFQOTQ4MDlBU1V1Ky9STGxxU2tNVjE1?=
 =?utf-8?B?bG1iODd2WnVCeldLaHhpK29HazFJRDVOUFdVUVNYN0hnMU1qUXlmNFZ3ZWJR?=
 =?utf-8?B?ZDVMcWlENUptNzdxZnQwajFHWW1yeEZuakc4Z0lNUE9BZEVpUmErZzJYYjVr?=
 =?utf-8?B?Mis3bTJmZitFeVc5WnZ6bU5aOXFwYzFxdTBHd3IwS2JDNlNwUW9ZazhGeGVr?=
 =?utf-8?B?TVp1Tmk5K25QRlZ6VXdGV0Fhc2loeHhEeEREL3ovcVkyV3lyTm5sZ0t0ajJs?=
 =?utf-8?B?bUoyOXNabHUxTlVRR3k3SmpVWWdYckFtU1RxQzBxd3MweTF0blNmTVJvcVpO?=
 =?utf-8?B?OUk4YlVPVmxIV3pQZys0SjFPckpLT2VvaFhaZkRZS25YSEtTYzBPSnhzZ0da?=
 =?utf-8?B?U2dOWTJxNW5YKzRSTHQ2eHhlMVg0Z3crV2ZxajBOREtKTms2N2RXM1ZLZ0hV?=
 =?utf-8?B?cXB3bjd4ekRlQmVFODFkVFJrcTNwaVNVMUNmSFp6TEdCbitCUGEydERnR05D?=
 =?utf-8?B?Y2IzSmxpYnF6WlNraERNTHdVTDhwNGg4c1lDWm9DcVdhL0Zlci9pMFBMK3Aw?=
 =?utf-8?B?UFl4b2ZNN1l5OTNnV0krS0lYTHRKbkVVRDBJelBOei9ldW5vS0QzUkxvVlpo?=
 =?utf-8?B?YlhoVlUxU21Xb0tqNnU3MnZiaHU4R09TY0NLVDV4dy9LcUY5OU5GdEZSdWpl?=
 =?utf-8?B?RzllR3R2TlpWSmNxWlAvWTByMW1EZnNrUVNwOVFtMTFuUVhhdThjYXJ5em01?=
 =?utf-8?B?ZEo1bjk1c0Fyd0x0OG9jRHRUTnZZMVl1Y055cS9JVlNVK0NHV1dMeVhUWlFl?=
 =?utf-8?B?UDJJSHd0NnhUUEFrZ2IxVkNyMkZNUjIyN3VrU0NVbU9SOGFId1UybzU0TTYr?=
 =?utf-8?B?R2JEN3FVNmVEMG1RbEM5U2Y3MWlVb2h0TXlDMmc1MEg4dmZ1UldRRmdnN1Qx?=
 =?utf-8?B?UnFHTHJjRWR5bnh2SHQ4UFlTU1hEdHRVOUVsakF2RGFvK01UeDY2bTN4VmJ3?=
 =?utf-8?B?NEtxVGtrd0o4eTRaNzg4cHgyTnBVeXh1TEE1OHNDMWVvdjVXL3VjMWxtWlB4?=
 =?utf-8?B?Rkd3K1FwdnlkTGRvZno1Uk5EbDNNcnhDQ1FHSTBzS0dGUVZyZmFabUxCSDkz?=
 =?utf-8?B?a2ZrTGpOZlhRSHRFTldyZzR4dGJhTVNCNzFlSk5KRnlwMzZDVkxOaGJiekxT?=
 =?utf-8?B?ZWw3V3BlV1hrOGROTmZvV0FnaTRZMStTdytGTklqaWpzZzcyZ0tzM2dWaERi?=
 =?utf-8?Q?cLyIOrU0zLNchdhSwpgHoetYarz3nrE7?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WE9yZk1ScWR1TUJUbEVmUGNkdnFMWmRxVm5LL3FGT2M5WkJENTlGWjEyWlZx?=
 =?utf-8?B?cjJVWXJaZWljL3pzNHBDZFE0UEt4SUJHNzNYUjFmdVFpRWw2aGxjVjRwS3M4?=
 =?utf-8?B?d1FFdmxwYWtqcjJJaEVtcG9xSTVQSnFJOWdZVEtVNmRSd21YQVlxWnArQm5I?=
 =?utf-8?B?YVRtdFcyeFlIem9IaDZteUpHYzZuVFUrNm9xeUJhK2R5ZU8rUDkyd0s0ZHQ5?=
 =?utf-8?B?N0NqQnlPK1NIeExwRG9iUjB1ckQrODEzVS9nN2NndCtad3hEb3VRc1lWUG5V?=
 =?utf-8?B?Ym5ENWRKNTJVMkdpWEdYL3NtRWhPVUh3Y2YyT0UyL0p2S2ZsN1ltNS9raCtR?=
 =?utf-8?B?VVZ3R0haQ09ESy92bUlISzhuTjZEUkdzVU9vdTkzd04ySndZRlFQS09IRDMy?=
 =?utf-8?B?aU8zQVFwSFQwUXFxU1pBcmZ4NWNxTm1hTis1bnNnbitsNVpNL1dOaXIrQUg2?=
 =?utf-8?B?WnFFNXpGTWRWOVRDTUcvOWwzNWgzUHlLQW9vLytHdC9hTHV5aWVERkd3WkM3?=
 =?utf-8?B?MnFJRnorSGNXWEdycHVqT0pZK1lHcmxRQ0M3YjhhYk1SZjZtVFhaNjhTMlFX?=
 =?utf-8?B?TWI2RXh3RFBQbzZNOElpZkM2LzRGcG9MWDMzZmc4VWVDbFZzcjh3SkJLYzZ3?=
 =?utf-8?B?TG9Wb1A3Tm9MaEdIVUVDSy82YVNKNTVyRDUzdnd5WEdzMTJzTzBIcXFDbS9B?=
 =?utf-8?B?Uk1jTXlsV1B1M3JoNUYydjloT1hFWXFOQWh1c2wyY2RVei91MEdmOFVBYTRK?=
 =?utf-8?B?dEk2TkVEeC9YRGtlekxSaURjZGsyTDF4RnR1THJ6OVhvMGc4c1JiOGpReFl2?=
 =?utf-8?B?MVJkSGNzRnhXTkloNG1NcFBVdDZKMHJSNEF6dER6anFPU1hSZVpsSmdzMS9F?=
 =?utf-8?B?emQ3WTBvNVM0WmdrRkl3K3QwZnVFaENwWitwc1NJYU0reENCSFlickxmMllO?=
 =?utf-8?B?dXJaZGxUZXhvRk5zMWp0TGhpaXZlaThpY3ZtVUw1WXNhd1d5RTc4dG9zZEpq?=
 =?utf-8?B?bkZ6Z21rTE85L01mYWFOYmg0WEFwN3J3WGl0UHNnVHNoRnluZ1lEOEdJQVBK?=
 =?utf-8?B?VzNudUYza3hDNkVpVUxHS09MUUFWMzkzWUhsdzFIYkZqTVM3b09DdTJBZXNn?=
 =?utf-8?B?T2hOZC8yK3VRNElGWjM2SzBYbGdQYndyTTRsa0tRTS9MbzZUTXlvSy9CRE43?=
 =?utf-8?B?SVJqVCtnZ3BCNGp6alBLeUplQ0o2K0k4QTA4MDRzTXUvSUhyZDJ3NDJWb3dN?=
 =?utf-8?B?dHhUV0NoWTlPRDBzQ0JMUVNnNzhCYndzb3dKZ0NjN3NEMkxHNkZoa3ZKajlk?=
 =?utf-8?B?Z21NL0psSTRSU3U1d3QxSnBMOGErMmpxbVJMVVNsTVFUSGRnUGE0ZXdSd3dp?=
 =?utf-8?B?USt0UlRZR0NrTHRNOC9WV28zMzk0cHVPTVhpOTJzb1EyWTJwc3d0VTZQWjlQ?=
 =?utf-8?B?eDMxcVhaOWR5NGtXS21XcFA1YXgycHAzbmdrdUlpLzBBUkZMZ0FBZGdSWWtx?=
 =?utf-8?B?R2VFSTZrK0RkVUtzRnQ1L3dKY1FkNzVZT2FRVXVJSHYxVlo2cjl0VC9Jb3BM?=
 =?utf-8?B?cmJvSWFIbjRwaUdlQ1l0eGlxdGkvOGFQVlZGZm1pMWsrdGJCNk5hWG5JK0xw?=
 =?utf-8?B?cGx1OW91Y3FkMGNwbUhaUXdRdzZmSUE5UnlOMFVsbVA2SDZybFhUTnR6Yzht?=
 =?utf-8?B?WmNYdjBSV0pqUCtOVGtoeU5EWWdmU291VEw0TElVZ0lyZlBVRWVSaTdlVVpV?=
 =?utf-8?B?eFV4cmlnVmVNRkNnOTVUQ25EaWRmYTN4VFhxS2hVdThGTmhaSTRwM0lsYUY3?=
 =?utf-8?B?azZvS3F3c21DZG9PUUIzM09lemJlWXJRUE1KNEQ3NU9UQ0hiTCtxNzRwQ0cx?=
 =?utf-8?B?L1FFdk9uS2V3anE0Uk94emkzS3Q1Q2hTdzZkOXBjQmI2OXhKNWJmL042ODdz?=
 =?utf-8?B?UnQvR0FQODJOVDV4OGdVUXlXL1hkaW1GZFFLd3c4VVFnOXZSbVJ1L3dPdkxo?=
 =?utf-8?B?K3psdUdNOXM3VHF0NHgvMW1FZ0VPUm9Ub25pbTFyQWVyRTRKdFhhWldaME42?=
 =?utf-8?B?bitaLzRmUmZnZjllc29Ob3RmVmt5SStTM3F6RHpxcUxCRHUvdFVJS0hxMGti?=
 =?utf-8?Q?JNLPtdErww2LhUiK5vPj9Yoj5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <203F6653936AC345AF9708CB55B5FE95@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 549a9234-6d8d-4013-6545-08dd1ead91d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2024 15:14:58.0618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T84iFxqZ/kgQeH9z74Ud1hI73VaGoTluJj7FHbdssTsZnDP7XfToAAUxWM3+hFn3iJEpKRJfXrTt7WydVipvOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5954

T24gTW9uLCAyMDI0LTEyLTE2IGF0IDIxOjQ1IC0wODAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gPiANCj4gPiBSaWdodCBub3cgVENzIGFyZSBub3QgbW9kZWxlZCBpbiBuZXQtc2hhcGVycyBh
dCBhbGwuIFRoYXQncyB3aHkgSSdtDQo+ID4gd2FpdGluZyBmb3IgUGFvbG8gdG8gY29tbWVudCwg
SSBoYXZlIG5vIGlkZWEgd2hhdCB0aG91Z2h0cyB3ZXJlIHB1dA0KPiA+IGludG8gbW9kZWxpbmcg
dHJhZmZpYyBjbGFzc2VzIGluIG5ldC1zaGFwZXJzLg0KPiANCj4gSSdtIG5vdCBzdXJlIGlmIFBh
b2xvIGlzIGZhbWlsaWFyIHdpdGggZGV0YWlscyBvZiBhbnkgZGV2aWNlIGNhcGFibGUNCj4gb2YN
Cj4gaW1wbGVtZW50aW5nIHNoYXBpbmcgYmFzZWQgb24gVEMuIFlvdSBhcmUsIEkgaG9wZSwgYXMg
eW91J3JlIHRyeWluZw0KPiB0byBhZGQgTGludXggdUFQSSBmb3IgaXQuDQoNCkkgZ3Vlc3Mgbm9i
b2R5IGhhcyBwZXJmZWN0IGV4cGVydGlzZSBpbiBib3RoIFRDIGFuZCBuZXQtc2hhcGVycy4gQnV0
DQpiZXR3ZWVuIGFsbCBvZiB1cywgd2UnbGwgZmluZCBhIHdheS4NCg0KPiA+ID4gDQo+ID4gVGhl
IGN1cnJlbnQgcGF0Y2hzZXQgZXh0ZW5kcyB0aGUgd2VsbC1lc3RhYmxpc2hlZCBkZXZsaW5rIHJh
dGUgQVBJDQo+ID4gd2l0aA0KPiA+IHRoZSBtaW5pbWFsIHNldCBvZiBmaWVsZHMgcmVxdWlyZWQg
dG8gbW9kZWwgdHJhZmZpYyBjbGFzc2VzIGFuZA0KPiA+IG9mZmVycw0KPiA+IGEgZnVsbCBpbXBs
ZW1lbnRhdGlvbiBvZiB0aGlzIG5ldyBmZWF0dXJlIGluIGEgZHJpdmVyLg0KPiANCj4gIkkganVz
dCBuZWVkIHRoZXNlIGZldyBleHRyYSBmaWVsZHMiIGlzIG5vdCBjb25kdWNpdmUgdG8gZ29vZA0K
PiBkZXNpZ25zIHdoaWNoIGNhbiBzdGFuZCB0aGUgdGVzdCBvZiB0aW1lLg0KDQpJIGhhZCBtZWFu
dCB0aGF0IGFzICJ0aGUgdUFQSSBuZWVkcyBhdCBsZWFzdCB0aGF0IHNldCBvZiBmaWVsZHMgdG8N
CmV4cHJlc3MgdGMgYmFuZHdpZHRoIHByb3BvcnRpb25zIGFueXdheSwgcmVnYXJkbGVzcyBvZiBk
aXNjdXNzaW9ucw0KYXJvdW5kIG5ldC1zaGFwZXJzIi4gSSBhbSBub3QgbWFraW5nIGFueSBjbGFp
bXMgYWJvdXQgdGhlIHF1YWxpdHkgb2YNCnRoZSBkZXNpZ24gYmVzaWRlcyBpdHMgbWluaW1hbGlz
dGljIG5hdHVyZS4NCg0KPiA+IEl0IHdhcyBkZXNpZ25lZCBhbmQgc3RhcnRlZCBiZWZvcmUgbmV0
LXNoYXBlcnMgd2FzIG1lcmdlZC4gDQo+ID4gV2UgZGlkIGNvbnNpZGVyIGludGVncmF0aW5nIHdp
dGggbmV0LXNoYXBlcnMsIGJ1dCBiZWNhdXNlIGl0IHdhc24ndA0KPiA+IHlldCBtZXJnZWQsIGl0
IGNvdWxkbid0IGRvIFRDcyBvciBtdWx0aS1kZXZpY2UgZ3JvdXBpbmcgKG5vciBpbnRlbmQNCj4g
PiB0byBkbyBtdWx0aS1kZXZpY2UpLCBpdCB3YXMgcmVqZWN0ZWQgYXMgdGhlIEFQSSBvZiBjaG9p
Y2UuDQo+IA0KPiBuZXQtc2hhcGVycyB0b29rIG1vbnRocyBvZiBtZWV0aW5ncyBhbmQgbWFueSwg
bWFueSByZXZpc2lvbnMuDQo+IFByb3ZpZGluZyBhbiBhYnN0cmFjdGlvbiBmb3IgYWxsIHNjaGVk
dWxpbmcgaGllcmFyY2hpZXMgd2FzDQo+IGFuIGV4cGxpY2l0IGdvYWwuIEFuZCBzb21lb25lIGZy
b20gblZpZGlhIHdhcyBhY3RpdmVseSByZXZpZXdpbmcuDQo+IE5vdyB5b3Ugc2F5IHRoYXQgaW4g
YW5vdGhlciBwYXJ0IG9mIG5WaWRpYSBhIGRlY2lzaW9uIHdhcyBtYWRlDQo+IHRvIGlnbm9yZSB3
aGF0IHRoZSBjb21tdW5pdHkgd2FzIHdvcmtpbmcgb24sIHNpdCBvdXQgZGlzY3Vzc2lvbnMgDQo+
IGFuZCB0aGVuIHRyeSB0byBnZXQgeW91ciBvd24gY29kZSBtZXJnZWQuIERpZCBJIGdldCB0aGF0
IHJpZ2h0Pw0KDQpZb3UgZ290IGl0IHdyb25nLiBOb2JvZHkgZGVjaWRlZCB0byAiaWdub3JlIHdo
YXQgdGhlIGNvbW11bml0eSB3YXMNCndvcmtpbmcgb24iIG9yICJnZXQgb3VyIG93biBjb2RlIG1l
cmdlZCIuDQoNCkJhY2sgaW4gSnVseSwgd2UgcmVhY2hlZCBvdXQgdG8gUGFvbG8gZXhwbGljaXRs
eSBhc2tpbmcgYWJvdXQgdGhpcyB1c2UNCmNhc2UuIEJhY2sgdGhlbiB0aGluZ3Mgd2VyZSBzdGls
bCBpbiBmbHV4IHdpdGggbmV0LXNoYXBlcnMgYnV0IHRoZQ0KZGlyZWN0aW9uIHdhcyBjbGVhciBm
b3IgaXQsIHRvIG1vZGVsIHNoYXBpbmcgYXQgbmV0ZGV2IGFuZCBiZWxvdw0KbGV2ZWxzLiBQYW9s
bydzIHJlY29tbWVuZGF0aW9uIHdhcyB0byAic3RpY2sgaXQgd2l0aCB0aGUgZGV2bGluay1yYXRl
DQpvYmplY3RzIi4gT3VyIG1pc3Rha2Ugd2FzIG5vdCBjYy1pbmcgdGhlIE1MIGluIHRoYXQgZGlz
Y3Vzc2lvbi4NCldoYXQgZm9sbG93ZWQgd2FzIG5vdCAiaWdub3Jpbmcgd2hhdCB0aGUgY29tbXVu
aXR5IHdhcyB3b3JraW5nIG9uIiwgYnV0DQoiZm9jdXNpbmcgb24gc29sdmluZyB0aGUgVEMgc2hh
cGluZyBhdCBWRiBhbmQgZ3JvdXAtb2YtVkZzIGxldmVsIiB3aXRoDQp0aGUgbW9yZSBzdWl0YWJs
ZSBBUEkgYXMgb3Bwb3NlZCB0byBpbnZlc3RpbmcgdGltZSBhbmQgZWZmb3J0IGludG8NCmluZmx1
ZW5jaW5nIG5ldC1zaGFwZXJzIHRvd2FyZHMgaGFuZGxpbmcgdXNlLWNhc2VzIGl0IGRpZG4ndCBp
bnRlbmQgdG8uDQoNCkknbSBhbHNvIG5vdCBzdXJlIHdobyBlbHNlIGZyb20gblZpZGlhIHdhcyBh
Y3RpdmVseSByZXZpZXdpbmcuIEkgYXNrZWQNCmEgcXVlc3Rpb24gYXQgc29tZSBwb2ludCwgSmly
aSB3YXMgYWxzbyBhY3RpdmUgKGJ1dCBtb3N0bHkgd2l0aCBoaXMNCm1haW50YWluZXIgaGF0LCBJ
IGd1ZXNzKS4NCg0KPiA+IENhbiB0aGUgbWlzc2luZyBsaW5rIGJldHdlZW4gVEMgbW9kZWxpbmcg
aW4gbmV0LXNoYXBlcnMgY2FuIGJlDQo+ID4gYWRkZWQNCj4gPiBpbiBhbm90aGVyIHNlcmllcyBv
bmNlIGl0IGlzIGJldHRlciB1bmRlcnN0b29kIGFuZCBkaXNjdXNzZWQgd2l0aA0KPiA+IFBhb2xv
Pw0KPiANCj4gQ2VydGFpbmx5IFBhb2xvJ3MgY29udHJpYnV0aW9ucyB3b3VsZCBiZSBhcHByZWNp
YXRlZC4gQnV0IEkgaG9wZSANCj4geW91IHJlYWxpemUgdGhhdCBoZSBpcyBhIG5ldHdvcmtpbmcg
bWFpbnRhaW5lciAobGlrZSBteXNlbGYpDQo+IGFuZCBtYXkgbm90IGhhdmUgdGhlIHRpbWUgdG8g
c29sdmUgeW91ciBwcm9ibGVtIGZvciB5b3UuDQoNCkknbSBub3Qgd2FpdGluZyBmb3IgaGltIHRv
IHNvbHZlIHRoZSBwcm9ibGVtIGZvciB1cywgYnV0IHRvIG9mZmVyIGhpcw0Kb3BpbmlvbiBhcyBz
b21lb25lIHdobyBzcGVudCB0aGUgbW9zdCB0aW1lIHRoaW5raW5nIGFib3V0IG5ldC1zaGFwZXJz
Lg0KSXQgd291bGQgYmUgYmFkIGZvcm0gZm9yIG1lIHRvIHN0YXJ0IGhhY2tpbmcgYXdheSBhdCB0
aGF0IEFQSSB3aXRob3V0DQphdCBsZWFzdCBoZWFyaW5nIGZyb20gdGhlIG9yaWdpbmFsIGF1dGhv
ci4NCg0KPiBJIHdhbnQgdG8gYmUgY2xlYXIgdGhhdCBJIGRvbid0IGV4cGVjdCB5b3UgdG8gbWln
cmF0ZSBkZXZsaW5rIHJhdGUNCj4gdG8gbmV0LXNoYXBlciBzdHlsZSBBUEkgYXQgdGhpcyBwb2lu
dC4gQnV0IHdlIGRvIG5lZWQgYXQgdGhlIHZlcnkNCj4gbGVhc3QgYSBjbGVhciB1bmRlcnN0YW5k
aW5nIG9mIGhvdyB0aGUgb2JqZWN0cyBhcmUgbWFwcGVkLCBhbmQNCj4gdGhlcmVmb3JlIGhvdyBU
QyBzdXBwb3J0IHdvdWxkIGZpdCBpbnRvIG5ldC1zaGFwZXJzLg0KPiBJZGVhbGx5LCBhbHNvLCBs
ZXNzIGRpc3JlZ2FyZCBmb3IgY29tbXVuaXR5IGVmZm9ydHMuDQoNCkFnYWluLCB0aGVyZSB3YXMg
bm8gImRpc3JlZ2FyZCBmb3IgY29tbXVuaXR5IGVmZm9ydHMiLiBUaGVyZSB3YXMgbWF5YmUNCmEg
bWlzc2VkIG9wcG9ydHVuaXR5IHRvIGluZmx1ZW5jZSB0aGUgZGVzaWduIG9mIG5ldC1zaGFwZXJz
IHRvd2FyZHMNCmhhbmRsaW5nIFRDcyBmcm9tIHRoZSBzdGFydCBiZWNhdXNlIHdlIGZvY3VzZWQg
b24gZGV2bGluay1yYXRlIGluc3RlYWQuDQpUaGF0IHdpbGwgbm93IGJlIGNvcnJlY3RlZC4NCg0K
U2VwYXJhdGVseSBmcm9tIHRoYXQsIEkgd2FzIHBsYW5uaW5nIHRvIGFkZCBzdXBwb3J0IGZvciBu
ZXQtc2hhcGVycyBvcHMNCmluIHRoZSBtbHg1IFFvUyBpbmZyYSwgc2ltaWxhciB3aXRoIGhvdyBp
dCB3YXMgZG9uZSBmb3IgdGhlIG90aGVyDQpkcml2ZXJzIHRoYXQgZG8gaHcgUW9TLg0KDQpDb3Nt
aW4uDQo=

