Return-Path: <netdev+bounces-201198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D782AE86BF
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 16:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F594171A44
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 14:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97A5234973;
	Wed, 25 Jun 2025 14:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Er2DgFx5"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB4A267B90;
	Wed, 25 Jun 2025 14:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750862427; cv=fail; b=IEzItRvKFlU+/riPvJmliw+jWOHJA035o+umCTC30g0OrwC9OeZOhwFCi96PP1TG18AD3IZOOShwoN5cE68wdrH8qDH3T5T4rbCMtTqkMyiL3kkL27XXht29nDieuv635gVq67XaV/JjX7M0R0b3239Hmv11BpfHx2jjIKdogK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750862427; c=relaxed/simple;
	bh=uHJ5GCB3De+6xJFcYD6aYS1cvN1cG8+x9YmcL5o5k9M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dJvBm8CbfwjNZXLd5kTgCngiSvgrph5p6z/QosT29TapOFXOgl8QdbeqK833P6FYPaTdE5ebyvz1q5UghB0+OfHwgkgHmJz8NnuaWPl5cnzwcMsjwvY7ea+6exIHavEHqhguu7xS4oVRJE67WBlJAMl8ejrEo7w3thUeWgzXZwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Er2DgFx5; arc=fail smtp.client-ip=40.107.244.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g6PIOVJTadOZj1gaFjw4johpx+ITvMgwbpU0yTwD9Rb5eckxkvfyCOo0+JOxitRvnwzb+pb64nof4aL67d7bFyo4g/CaHMvEJwSiTkimuvNsAMi/IC2KGQuWxYtyQ5tMg9h+OxouwOjDm1s9b437GkOY1v9lvsiMQngIJaSiXoMfIs5fXYUj5K2Ldoaev04Mk2CkacvrtOuyS64OKxkMyCsXgfsHgQZ2+ILOjdQEgFUgiUykl856nqw1Rb2Qyf74JZzWPwt/WquKrvGR7WcLcfSZ1y9rLPxuMKYyAJ7bgHd8M9fZR466iBZiv7ZwgsHH2IwTXneZ4bVjsEMh+5ZR3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tcnUTIQHglgLKJxbfgC7MnCg1EmDI7XWvl85EGUolzg=;
 b=j29IEUl+xfwpQmUWg3osaQYCjkDWJcUK37nZhD6N1uvZbjxrHMhVZZUqthUjaG8Cl06NvJa7zCwvyHvsOvUleirhIGhPP0cTICIo/7Tb5GcrHQz1ExV7bm9j4w4JfMpaRqfpd8IOYc78NbhG7kbNUc9mvc5+21yYYJAWwt3UueyjCi0NuTaJYLV4blH1WPI50/RNHsv8fWD+eLIh7x93rjgtgftwPHB1Ws7FS5vj74lnTdtRQB62hSxqBu4xZMKc7YtgHA99hYnvDNmgehuo2ZSkQ4ugJiH0llgvYml+eZMDpRs8yVU0p0bMCVlCqvMW7Qz90wkdzAQ9Odt1wwqpPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcnUTIQHglgLKJxbfgC7MnCg1EmDI7XWvl85EGUolzg=;
 b=Er2DgFx5ZrG4dhh6Di7KLaJQYHRW0AFIBBbvFz2v+V3PP2C2mRG7T9HLirClTJOQo3u8s32RWcKZ71OycvM553WG4aM3APgs3ccHAVaxJdzr19lWLxaOSDbRIUp9yT1CkUPbRI2aIIwM2i4NJqCvOWoboLJkolqw+4zkjRFzg3K+e+g8GKOY7VFpWgmWsOyYlThr00IJopziO9iCDxcUWBevxsT6wCBJJeAfd2BMb7NS44HtNsI/WQ/apK0zkwYZa4g9ZCG0A9U84v9cetVDdyGxy8EpYi0hN0Bekh6kKLmYIaIKpYSzb5YPuDoJaxpJHhIq6imgStG0kpDvYb6F5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8773.namprd12.prod.outlook.com (2603:10b6:510:28d::18)
 by SN7PR12MB8792.namprd12.prod.outlook.com (2603:10b6:806:341::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 14:40:21 +0000
Received: from PH0PR12MB8773.namprd12.prod.outlook.com
 ([fe80::47a4:8efb:3dca:c296]) by PH0PR12MB8773.namprd12.prod.outlook.com
 ([fe80::47a4:8efb:3dca:c296%2]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 14:40:21 +0000
Message-ID: <11d63030-1395-420a-9079-fe3cb672f468@nvidia.com>
Date: Wed, 25 Jun 2025 15:40:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: stmmac: Fix PTP ref clock for Tegra234
To: Andrew Lunn <andrew@lunn.ch>
Cc: Subbaraya Sundeep <sbhatta@marvell.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-tegra@vger.kernel.org,
 Alexis Lothorrr <alexis.lothore@bootlin.com>
References: <20250612062032.293275-1-jonathanh@nvidia.com>
 <aEqyrWDPykceDM2x@a5393a930297>
 <85e27a26-b115-49aa-8e23-963bff11f3f6@lunn.ch>
 <e720596d-6fbb-40a4-9567-e8d05755cf6f@nvidia.com>
 <353f4fd1-5081-48f4-84fd-ff58f2ba1698@lunn.ch>
 <9544a718-1c1a-4c6b-96ae-d777400305a7@nvidia.com>
 <5a3e1026-740a-4829-bfd2-ce4c4525d2a0@lunn.ch>
 <f769098f-2268-491e-9c94-dbecf7a280a4@nvidia.com>
 <e87b4398-41de-4584-87fe-b9ad1df32dbe@lunn.ch>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <e87b4398-41de-4584-87fe-b9ad1df32dbe@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0196.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::6) To PH0PR12MB8773.namprd12.prod.outlook.com
 (2603:10b6:510:28d::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8773:EE_|SN7PR12MB8792:EE_
X-MS-Office365-Filtering-Correlation-Id: e8557966-7bf9-4107-1952-08ddb3f63628
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dHRPem5ibjI2NEl0MXJ0TEp5RXpWK1hBUyt3T29WS2hQU0NTdGVDRGIrb1ZU?=
 =?utf-8?B?UCtmSlgvb3FrNU9UdU9GVW9DT2dLNk01d09Yc2F2azZ6WktzeDNJY2pXa1Qz?=
 =?utf-8?B?NFk2UTFhQUdEMmpQTWpxMnZ5cUE3RW85bXlUTURxTHdNQXU1NFc0QStXeC8v?=
 =?utf-8?B?eGNLbU9HZ3pCOFZhd1pKc0pVSGo5bjZUa1ZYKytFWEVZaldFNVRjN1dKRXQx?=
 =?utf-8?B?Z1NYdjZlMFdoNW9TMm5aWGtOTGkvYnMya1diOXpsOTRnZmdGK0h5R1BTV1pI?=
 =?utf-8?B?bG5jVUxLVlVpYmdnOEFXMzZhallDS3ppZmJRZWdJTzBUMWpqUGFJLzlFY2l3?=
 =?utf-8?B?TU5ZYzU4VEptNmFXUFgxWUdRV202elYyWUI0UzNBdnJuSGZORjlFZnlNcWxO?=
 =?utf-8?B?NWkzL3BGaWovaTFKUVFxMkhIeGVUMmt5Z2VVVzNNdEJ4WGU5N2JZallTWTJG?=
 =?utf-8?B?VVpZWVhzbURTSUU3Z1RTY3RkTllDQkgvMVhRaE9iRklGN050SlBTT0w5MENN?=
 =?utf-8?B?c1phM2RUcDB0SkUyOEUwUTk1M1ZDUEx3dVpvRGcrWmpHdHJQMWtPR1ZnVXJL?=
 =?utf-8?B?SCtSWGswVGRpa0ZUOUhaSzR4TDFuNzA2L3dmaDNBaVdEczRUOGZ6SFY0WURn?=
 =?utf-8?B?UmtSdTBRaXVrT2NhTnhzUXhpKzVaNlJvVnY2SldURjJNdkpqd0hmN3dqUmpy?=
 =?utf-8?B?dTEyNEcvenJENWZKZm1GTFBJK2hTeHRKblpLRTJuN0hCQUQvcHVIckQ2dzVD?=
 =?utf-8?B?VnNUd1BoelJldW5qNytBWDJUZVVnZWRMdzU0bjh6Ukl6S1FMUFlvT0tIUjFU?=
 =?utf-8?B?MnRDNzVQdnpESVlmWmN0OE9pOS9lYUpuVFljSmF3cmxIU1VRYXZGUWFWcXZo?=
 =?utf-8?B?MlVIejg4RFVtbVhkdmFFVjFMbGdTS00wSyt2VGMyeGZKaUtjVHdmd3JJVEEr?=
 =?utf-8?B?UDF5emY4N3NobmRRa3l3Vk4raDZyRGtiMVpXdHlmOE5jdVkyTGw3K255SkVX?=
 =?utf-8?B?VDZaSHV6dkVIK2hYRno3anQ3MVFKdWQzL3FKVWdrZm85RjRWUXBkejdwK1lt?=
 =?utf-8?B?T2Irc1NOWjBtUU5UZmNOeDNDUVlaOGxoQ1dhRUprSDNkanVKYXllRFFsQnFS?=
 =?utf-8?B?SlZvYnQ4YjhwYmJMNWJYYmFqMTRia01VYkdzc1c3b3FzcWliMG1BU2k5ejMv?=
 =?utf-8?B?dFovelJYM2M2QzNLUGV2SnhCRHYvaEFRM212b2c3TjlNTTNnRlVncEN1NnVy?=
 =?utf-8?B?TXE1MTgrT3hEeDJYeEtEenVBeHdWdlB5eTdtc1h2czgvcjZPdjVJb1YwOXRn?=
 =?utf-8?B?L0ptNUd6VGZ3NTZPYk5nQ202alNJL1N6Sll0emVvZWZ5eU4vVVlvYlZ1U3dW?=
 =?utf-8?B?d0h4UTRoMWVEbkNOaWNUWmVXQ2RXdTNDcVJRY3FEM3RHK2g5MlVTaUZHT2lp?=
 =?utf-8?B?ek1nMFZVcVpnN2J0MFVicE5QcjVDa1NxVGRwSVBpMFo2MnozYnpGTkNrbWpy?=
 =?utf-8?B?S3dZbVRXQk1LaWZoYk9YTWZsVEMraW9OMzdrM1RjN1g3N0hYendESVhQZFhk?=
 =?utf-8?B?OHA5bCthaXNpUnc5NWZIcnk0Qm1QZDJYc1JzNmRWdXp3WVFna3l4TkJrWURK?=
 =?utf-8?B?Z2Ezc29zd3BUMzMwSUZvZkpFSml1NkxzQ0VNTXE0aG9EeWdTSGIxK1dyR3FD?=
 =?utf-8?B?amNhc2YxNEtaMisyMFZJTzdPbHRDVjAxeUxBNVl2Z0JwTGt3NGZwSFVuYklH?=
 =?utf-8?B?UDFPVjExcHZaMDRVaSttb040cTlzcCs2RnNFOFk1eDlGczVtZ1hoaWdZWmZH?=
 =?utf-8?B?WUFybVlzM0Y5UmZVdUNWcS9HMVk3NmlHL0V3S1FCQ1FoMk51MHRhSHN2bEda?=
 =?utf-8?B?UkJ4ci9lSnVCaUZZTFQ2TlBjNmwxS0hJUy83STR2WFZTelVQemRJVC9iRFFs?=
 =?utf-8?Q?hpyUhWy10UA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8773.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVNhVXIxVmVkQXlzemlrdG1OckVBUDJoUXFrUWdSTGxvYW9IK055TTBSSWdL?=
 =?utf-8?B?SnRML0FzbkFMVXZlWkxZd3hRc3lnUnQ1Z3c4ekh4OG1LaytWdDlJR0RzeFNt?=
 =?utf-8?B?VGxYb3htZEZPd0luV0pNZ3B1cnFpU3NzOEg1SW8vOCs1Y2dGOHUxRHIzdDJl?=
 =?utf-8?B?eHQ3UisvRVl1SjhUNmRsbWFhMHNjalJGNnVZYTRDL0lud1hWWTdjeitVdTJm?=
 =?utf-8?B?U3U0dG12ODRKa1dTNDNNTGpnOWtQY0lmeGxwendGekl4Q2taRHRzcTVpVXNo?=
 =?utf-8?B?UERNNnFKczlueVpYNkZ1ckU4bVcxMHVhaWlWODFSZzIwb0s1UkNQbUZyL0Qy?=
 =?utf-8?B?YzVPZ3FKaEtqNDF4ZWZkZUpFK3RvVnVHZDVRN3IvMnZwdXNuZE5mNVdReDR3?=
 =?utf-8?B?dkhNaGZBdUtXK2JEMTdQSVUzUXFpOFp5MUJRWjlFakRGRTFtQ3JDcksyRi9l?=
 =?utf-8?B?ckNrRjlJZlNNenZQZHFyVHlXTC90RkVTYkdRR1M4QmJpa0dJaTFTTUVvNTZt?=
 =?utf-8?B?RzJ5NHFxR25GQ1psR2l1M05wVHBlTm5QSytrcVBpTFozODQwUE9FTCtBQVpx?=
 =?utf-8?B?bWRuT0dhOHdlc01XT2hJSHV6aXBxb3BHb3FoaU1NOGd1ZjV0V25oZUZsUGdv?=
 =?utf-8?B?UkhIZStyRytSdEltbFk4Tm9sN25IK25zMnNwVk1jdkVoVkU1RDFaSFhvcFNE?=
 =?utf-8?B?VWF2eUhLeW5ucFc5d2dKNzFPRGlLc1l0MjgrdWtwOXQvK2NCcXUyRjI5RC93?=
 =?utf-8?B?TWpYYmVGdGNYTXpwUjBCcG0xemhBczFyVlhFaUYzS1VHbWpMeTdDODdPU3BL?=
 =?utf-8?B?TnZlVWZ2VXJxV1VYS2ZaUkVwNVZFNDVldTZUMkRPcWVlMFhUOFNtR3VQdEU5?=
 =?utf-8?B?cVNocWhTT1g1WnhoZVczSlBpd3kxcUJYYU91dlFjOG1Ec3Z1S3hjcURyZjJp?=
 =?utf-8?B?UXE4SVc2WWhiU1Jra0NOdCtnVHVacHlnL2M1WWh2a2F0Z2RhRmhoYUlNZUlE?=
 =?utf-8?B?ZUtDc2ZlR25DaVA0RjFCQkJTSXhYNXBEbnBqdXRFS3F5MUNra3hWZ29OZFR6?=
 =?utf-8?B?VG5nZXhFMklMVFd5TWdxUjlCaUh2UTdhTVdkeWFkKzJiVjN2WGp2TmxlTGRW?=
 =?utf-8?B?cUJORFJWaW9NdEppa01NM00rbVBHdm1kT21tNFhMOHJIb1lXd2RoL0l3YTJ1?=
 =?utf-8?B?YUJCVk9qak1qSEVWUzZmN3IwcktpWHBmcTNsNXVqVWdTOUs5RTJuM01sVWNa?=
 =?utf-8?B?T20wYjhnem90VGtDc0ZGcmdraDZWSXZ6ZU1NKzJwY3p3T0JBUHpodHBtUjBY?=
 =?utf-8?B?WU0xZlJCU2grdXBha1FUYllIdGtJMVU5KzRaYmhHaUR5M1dVMTl4bWtHS3J4?=
 =?utf-8?B?c2tCNnJRUUt2YnhhWk9jWGg4UnRqMDhTVFQ1VjhWYlFoVzc3TjlyaUVPa0p5?=
 =?utf-8?B?NEY5b1BTd21UbUFJQ2EzYTVtcUduRGxDdFJWZEMvcThDNDB3ZmIyWEdzRlQv?=
 =?utf-8?B?TlE2THpOZjhaT0hzdlJiTHQ2SUQzenpuVEUvVys5eS9yeW5QekZpc05rOGtD?=
 =?utf-8?B?RnNHdjVTOFZtTEZlVXg2RHFmNVdDakNwSlgxdC94YjVkbnR6djIzZ2VrUVhR?=
 =?utf-8?B?MC96RjJraytQQXpOSjZoN1NZdFNaTUppN2p1aXdXSFkxWkxTTDF1R2trbzd1?=
 =?utf-8?B?SDNhRHVNYkNPZ2xwMjQ0K2h3TmV4VVhFNmhZSkVtS0pCS0hYYk5vbnFIdU40?=
 =?utf-8?B?alBtMEwxejdUMjZpUkdIKzVuWEFpQXgxTjhBSmh1bGh3eEt1eHZISkRUOG9t?=
 =?utf-8?B?cjhlZElIVVlQOHJFTXVqNkFZWnZCU2ZXZExlTlNiTC9IVE1qbHhsNVRkYVA3?=
 =?utf-8?B?Ym1iSzJCaXRrY1E2SGhSUTNubzRNN3VoNllzb3RzNkphY1RWQ1NqWEdsL2ZT?=
 =?utf-8?B?RUhaK0NFc0V4Z2psZlNVUkl1Vm1jc3lyK09WUHh0NGN0SGlDeTMxbWJta1B2?=
 =?utf-8?B?SnhocXJwN2RJcWdtQ1RvaWZBWWlBTWVkQUxvUHlqOFN3NVFwNjdzdFpBd0Za?=
 =?utf-8?B?MUo3VU9zN1FsdmYyUGl0L3FqQ05vL2FTMmNPQ0Q4VDRzRzU3QWI3WjZkS3Nq?=
 =?utf-8?B?Sy9QQWhPUkZVZGNWeitGYURWbURrV0ZTc2Ntc1pOS05yY2hqTjZjbEJENndT?=
 =?utf-8?Q?hNVJII9McEY1eSlJEfkhTf8oBOgmuVbzOn3sdYafZQON?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8557966-7bf9-4107-1952-08ddb3f63628
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8773.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 14:40:21.1285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QuxbaCmW4abpv35wPSsy0ANECt7rT68Vbd8samz1H/boGSp4VdjOt3KNTx1KGFeIpUtcUYa8oRVJQ7NUOHRlmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8792


On 16/06/2025 14:06, Andrew Lunn wrote:
> On Mon, Jun 16, 2025 at 11:06:54AM +0100, Jon Hunter wrote:
>>
>> On 13/06/2025 14:22, Andrew Lunn wrote:
>>>>> So you can definitively say, PTP does actually work? You have ptp4l
>>>>> running with older kernels and DT blob, and it has sync to a grand
>>>>> master?
>>>>
>>>> So no I can't say that and I have not done any testing with PTP to be clear.
>>>> However, the problem I see, is that because the driver defines the name as
>>>> 'ptp-ref', if we were to update both the device-tree and the driver now to
>>>> use the expected name 'ptp_ref', then and older device-tree will no longer
>>>> work with the new driver regardless of the PTP because the
>>>> devm_clk_bulk_get() in tegra_mgbe_probe() will fail.
>>>>
>>>> I guess we could check to see if 'ptp-ref' or 'ptp_ref' is present during
>>>> the tegra_mgbe_probe() and then update the mgbe_clks array as necessary.
>>>
>>> Lets just consider for the moment, that it never worked.
>>
>> To be clear, by 'it never worked', you are referring to only PTP support?
>> Then yes that is most likely.
> 
> Yes, i'm just referring to PTP. I would be very surprised if
> sending/receiving Ethernet frames is broken, that gets lots of
> testing.
> 
>>> If we change the device tree to the expected 'ptp_ref', some devices
>>> actually start working. None regress, because none ever worked. We can
>>> also get the DT change added to stable, so older devices start
>>> working. We keep the code nice and clean, no special case.
>>
>> Although PTP may not work, basic ethernet support does and 'correcting' the
>> device-tree only, will break basic ethernet support for this device.
> 
> We clearly don't want to do that. But we should be able to come up
> with a fix which does not make things worse. The obvious one is that
> we have both ptp-ref and ptp_ref in tegra234.dtsi, so that both
> mgbe_clks in dwmac-tegra.c and stmmac_probe_config_dt is happy.

Yes that's a possibility. OK I will have a think about this some more.

Jon

-- 
nvpublic


