Return-Path: <netdev+bounces-213421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A674B24ED5
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 18:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0D849A1D2F
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 15:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73307284B5B;
	Wed, 13 Aug 2025 15:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kontron.de header.i=@kontron.de header.b="QPNY0Bcj"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020090.outbound.protection.outlook.com [52.101.84.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D70328314E;
	Wed, 13 Aug 2025 15:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755100632; cv=fail; b=uLupKL8Dc/ph2wljx1Bz4hDs5lnWKG1w6MuZYAlDVmXyO2H0KLn0DNBr5+oSN6BisnUK9+zyumnjezud8w2GtQTxzJM/7cL6pqhmVGhjMY6u2s+1RxRbMI3AIxhygzNszcvlVnHza3FTgt2tp6G2HdyF/fei3bpqwIP62C3Rz9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755100632; c=relaxed/simple;
	bh=Y4PuC0QvkUKfZ//UvdafS6gZOXGCEIc6/PV9wAyOg2A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LvQpeXwZAQAwJGix2N0ze687riEmcCwmpEO+g6WyteAQAf870NnK9VR1TDSbOYg7o7TbF1pTmh6OBSBxlhIkPpRlBLWK/vtoJjF/cZBfOhzJ2VX3kyC6sTkal3Qdbm7UoOmkH14XW+eWCfhLmFOC1UoXwlk53n11i/w4SWOvLA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (2048-bit key) header.d=kontron.de header.i=@kontron.de header.b=QPNY0Bcj; arc=fail smtp.client-ip=52.101.84.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nMcJ3v/K9yqyj4657Ky4IfbJadCorUZKNaH46DNAXmZpK0xsQurVsRbO7NdlWZ3r1bIz1OdISeDu4oyYp7pkmizEe4lJyzq1IbDHZq9KYDpKaS+7tv8Y0m+gqxrExcxdq7jcgLivziY1CyqPcUbyjH/+A7BzXNd22Y+1RAvB9P219PiMi6RPFCxpjXkT8OESs/tNgofpwuXJuS7BwAf7VAxg4MmuABtjSEXxc0AF0IlnP2VctC0hyea0GYDOKmv4R7ZhcN6kXWpIxLVD8YPsH7Upuxjl3wUjjxmIFz+0RPtFzgLfRqDz57UKtahJSY9KxHV0EBV7wWHdQ12diJW/CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fVnyaYYbBSrO7s//1kYFzrswjB1Z1IGstEMXy+QhXAk=;
 b=g1CcvU/youWdxNH/MDRbWO/r8efQ9ka2W838/I9tT+PU+ZMQhXqugZ8XpBe6zMBhwbeK3csU97F/kQw90afAZOOt6uB44ZfeCmt6QVj/nhXKSPzcVXedg7NSGqykWy9klIp4MXn6S09lF86Wvg0B0ecUM5lWCPHT3bQK0CK5eUI4+eLKmBG59oaI5VRN5ERZ3uv1LimTK/aVUvW3TeLh3nWSZ3VW9GLqNaFlG/mG0piHx3zDPRLd+9kIkO3Wn3jWjhv4UWFf8ClQfHmFjjigkdY9WbIgCpBJsGkkV9iIgF0SCmAiKsp6r/r+ZRWoknlE9nFTBTLDW9nZo91TrmvhWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVnyaYYbBSrO7s//1kYFzrswjB1Z1IGstEMXy+QhXAk=;
 b=QPNY0BcjzjK+yZCGf7VHopEOaUMQx2dh0DQLGeQSeC+vYd8baQLGs/rB/0ZZ8DQlQWV6ArRL7H2DYhkfPncY4jV31+kSklJSZ2lx9XELP6b0Ycj14+YNO0fbdaa7vcGcFuq9srXOHFx2Q/6VlzXEuqDpRTwf+cGW+z5A4PuC37oy5ml2QzVqmf8KHsH/KiT9GTM4SOMgloRc1fei42uFIIxXxElhwilpy9bz2BdMCUWEjocHlwWM6f3cXqD3z6idOxOTNUhnanaS39xRaGp+sBgusRJQkML+qraWbVCLlSYDld+79q34ZmKWgFmLi1jGB7XO8UTW1cvSJWgAMwM2fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by AM7PR10MB3638.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:13b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 15:57:05 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.9009.013; Wed, 13 Aug 2025
 15:57:04 +0000
Message-ID: <a838b848-8633-4312-b246-17af9175535c@kontron.de>
Date: Wed, 13 Aug 2025 17:57:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] net: dsa: microchip: Prevent overriding of HSR port
 forwarding
To: =?UTF-8?Q?=C5=81ukasz_Majewski?= <lukma@nabladev.com>,
 Frieder Schrempf <frieder@fris.de>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
 Vladimir Oltean <olteanv@gmail.com>, Woojung Huh
 <woojung.huh@microchip.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Jesse Van Gavere <jesseevg@gmail.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Pieter Van Trappen <pieter.van.trappen@cern.ch>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Simon Horman <horms@kernel.org>, Tristram Ha <tristram.ha@microchip.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
References: <20250813152615.856532-1-frieder@fris.de>
 <20250813174553.5c2cdeb3@wsk>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20250813174553.5c2cdeb3@wsk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0076.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::6) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|AM7PR10MB3638:EE_
X-MS-Office365-Filtering-Correlation-Id: 395332bc-afa8-48ff-b659-08ddda820c59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RnArbExBa0R2ZVdwK1g3TXdTajdZSlNBcFIzTlVvSkQvYWdnTEFtK29OSHc0?=
 =?utf-8?B?NFNTQnF1K2ZSY3kxa0ZxY2VvL1dYWmNSZUt0WFJVblEvQkZBaWxmVGlUVlpu?=
 =?utf-8?B?OTlPNkVUQWpBc2pIc2dXK29tM2ZleHJzOVRWck9CSGsvdTFoeXQweHZrT0lo?=
 =?utf-8?B?RFJtS2NldzdraWxqY3BRMnhOVW9NY1g3WUYzQkh2NDFqZ0hobzBUN0h4QXhJ?=
 =?utf-8?B?VmNiTUhObFVleHg2RTFsVFQ0aFZENEx1V1hKaGZtbUhhRWRJN0VpNUxrdmhL?=
 =?utf-8?B?SC8wVzVEajZvaUlpN3ZBMHlDOE92MTJNTG12Ykl4ekovZVZZUGJuWkxFbzZ3?=
 =?utf-8?B?bm85QzE1QU1UZEZsTWxYdUJKS1VBM05Vc0xiU1NXdFFRRE1SQjlMYlErSkJW?=
 =?utf-8?B?cGprRHhPeTk2SFRyY3VvbERtU3pldDZ2OHBGb2JHcDNucFMzWFpYcTlMd3Za?=
 =?utf-8?B?ZDZYVFVhcnR5R3dMNXAvVUVRUllVU3B4eGIrcVRLb0hVZUJ3czJCenRxZUFI?=
 =?utf-8?B?UEQ4T3B6cjNZYnI2elRic3BBaFRKbjBja3FGN0F6QjJtSCs1bkdHajYzOXYz?=
 =?utf-8?B?QzYwWmI5d1FVdEk5cldhR1Y1ekpRVk4xcDJVanZSYm1JN1hhSHRLSFN5QTI0?=
 =?utf-8?B?M1N3b2dqY3FmZ3FVSHNOeUhBbU1hNVVJTjNtS2crNGZSS0FrSU9Fb0RFdktI?=
 =?utf-8?B?L2MzanlzeVRYdTErbDEzY1NXakJ1VjZKc0gwSEVIT3Fob21jbkJlQ2hPWmwx?=
 =?utf-8?B?STU3enY4WFJnNjZsL0hQZzVocnlUdUhWRW8xOUZ1NkhWdzZQS3pvT05zMzZk?=
 =?utf-8?B?RU9xM292NjVSYkJvQXh0M3JaVDVEQ0djdno1K3VLd3owZkdoc2kvbjI3Z3lJ?=
 =?utf-8?B?OWRYVTN1UHl5Q2xzWmlsK3ptOTF4TzFHQk04RjNqdE5TOEN3N0N1SjZERkxP?=
 =?utf-8?B?Q0JmRWFOVytiQzhBV1BPb21SVVB3V0J6Q0VSUzlmZURFNGd1MWZreTR2M3Uz?=
 =?utf-8?B?SlpkM3JsY2RSNGJ5ZWpZd2t5c2NWK1BRUWFOZFByVHVWSmxIbnVPUmlyTCts?=
 =?utf-8?B?eUJLR1pmc20rZTk0OVV3bVRUZng4RlNiTlVYbmNSOGNabjRkZUlCRFVsd3hh?=
 =?utf-8?B?dmVBTGpxTUVzZUNoTHhNLzV1SUZPWUovVkFCNGpISnRoOEdyL0s2dUZlcTFS?=
 =?utf-8?B?MjlIRXlGODZ1blpwSXp0VEdnaHZvdkxuMmtDYmNhM3BldnVCREVmN25PWFBO?=
 =?utf-8?B?S0hteDZiaVhDcjlYQnZlS3c2ZjhQWFhkbXZwdVo5UWhQOVZ2UXlwK1NTb3F5?=
 =?utf-8?B?djhrbzBGdXlCbmZpZHlBSkJqTWJ2SkJPK0R6MDRMaCtUUmo1eU4vVUpOYW5r?=
 =?utf-8?B?Z2YyWGp6aXFnck12ZmVyeEE3RnlVZzNoU0g3Y1IyVWtvRHcxWVpVWTUxMWE2?=
 =?utf-8?B?cCs0VUFtanBxdHJJY3lFZXduRktEYng4WFZmTy9uaEIxdE5yamhsMXUreFdU?=
 =?utf-8?B?dENNdnArRmpuRmxTTTdOK2kyVTBKek1IYk5YQ2FQM21NRlZSSTdQZWJheVBZ?=
 =?utf-8?B?U2dxeXg2c21ZemhKNkp4ZFYrN08yNVJIZ2xMNUlHZ1lEM3pteFRma0c5dkp0?=
 =?utf-8?B?WWxYdlE5SDVCUlFveTVUVkZOQjZuRTdIQityTGdhTEs2VjMrdGxCRTRIbzRr?=
 =?utf-8?B?akRhU3V0WUQvZG42RER1M0lnaWxhSEJOT0Eyc2c2MnJqMlFVcFZBUk00ZDFk?=
 =?utf-8?B?Vjl3c1FXTTdTU3QzZTVsc1A3dzMwaFphVW5FcFJZL2xJdFNGSklSSEIvSDVv?=
 =?utf-8?B?NDRINVhSc0oxdC8wTFpFUzNLdjJRNjNNUEpuaFhnbExjU29WdThkOVQwQ2l4?=
 =?utf-8?B?byszVHEwVXp6ek1qUTdHcG1Jc3JReVpvVGsyQU5EVzkzUkpMUlpwRTRCeW9X?=
 =?utf-8?Q?6Y8zbJpS9Yo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z1BZN1NlUnc4V0ZTNDUzRHVlWENoaFZOazk1dHpwQ1QxS2dLN0NYYjFGeGtk?=
 =?utf-8?B?QUlTTGJPZFNSRHh6MTNxc0l0MEFhYW5QeXg5Vm4yaWl5b1VrNFZGQUJCZzBX?=
 =?utf-8?B?S0lkd2taQm1IU3pkRGFyblJlOUV3ZFJXVS9qejlkYjRsNlVNZDF6K0FxaTNr?=
 =?utf-8?B?alZTS1dGdCtYZVNmWGZnbXhDdmdabzB3ekZPZFM3Y01XR2VrRTVLNDNqdHJt?=
 =?utf-8?B?bFVJRzg5c3NqckVOWnVRZzcxUVNEdzF0WCt3SXJZVy91YVQ2dzFqdVlaUTNS?=
 =?utf-8?B?dmVpd2NMWUR5aHEvVitkckk3bU1acE9XcFlLVm11cXlnZnBPU0xvQ1hzaFJU?=
 =?utf-8?B?aGhBK3pwTGVhZlZWMGpNbHhSVUJYdThpRHg1dU5tOEZqdXpucDhaRDdpdWxX?=
 =?utf-8?B?TDkxbE55ZWxlMG9ZWTkxbnI0ME9CdEQrN3d3Z2RZTUpXVU1aeXlHRkE3QkpX?=
 =?utf-8?B?QTBkeTJkR2hENmJZU2NMYkFWR1VoUzhlUWtXNWVPVzZMSldJZklnWVdwN0Y3?=
 =?utf-8?B?dWZ2THQvUWFmNE0rbkY2UW91Z3FqTWpJY0pqNDI3bkVWTUw4VVd1NXlpaTVq?=
 =?utf-8?B?TlAvYjR5WjhnWWtNWG9laFp2b3VLREJUNityU1p0QXdUdyt1VTVjOElEcTc5?=
 =?utf-8?B?NkhZRC9hbkRLVnV2UEJ5b0lHN1k0YXo2S0VsWHlwWUhZeGh6Mlo4S2ZyVDBF?=
 =?utf-8?B?QzEzNkRlUlZXejNaTllFeXRkbDVKSE90TXZucGRBZHJLdzNSVjhRSVczUDNL?=
 =?utf-8?B?dmp1NU9xd0RmNW41R28rZWh0RlgxbmR6T0JKZ0dsUTVhOUJyZFY1Vk40Yi9D?=
 =?utf-8?B?cXVHOWRiQmJ5MTNPQWhKZU0zdEVsaDF2NWtPZEl5elp2ZnpJd0hUZXdzQWx4?=
 =?utf-8?B?WlpnbWNxMUtrcXYyQURXNVdsY2hwU0NXeE5NTExCdlJPZmE2M0VwQXlmRVYr?=
 =?utf-8?B?bXByTDN4VVVldnJGMEwzTThBM3NaV1lqK2pKKzg3Ujc3V2lOOThQdHNLR3pJ?=
 =?utf-8?B?ajJTbFFkMy9uaUZuTWNLN21paEowZEtacE1WWmpNM29QdzFxOU0vZVBydzZj?=
 =?utf-8?B?ckVKeSs1cFFxa1dSRWlmVThCSFVLMWJkMUtqaC90dzhOczF1alJDZDh2L2Vm?=
 =?utf-8?B?ZlVqckkrVFFhQklJUENhWnRPWmhuN1VVS1hjQ0R1d09LenVRZjJOSEI0Slht?=
 =?utf-8?B?MFVLVTdqbTFZMzhud3FsV213RWV1OXp1YzRhRTRMd3g4NGdHS05FSEQwNjI2?=
 =?utf-8?B?ZzQvOVhzVnhoeElONElMSHR4M29zc2NPTmdKU3QycS9hT1RsTU52ZzNvSVFj?=
 =?utf-8?B?QzdsZ1VUV28vNXl3d1oydGlVS2xtQkIvM0NjK1lBQTh0VFBqY1RhbnVoNExJ?=
 =?utf-8?B?TlJKVjVjZm1UOEtrMHk5MkhVRXBMZlh3SXM1TUZ4anYyNG9UOGVIZitWYjBJ?=
 =?utf-8?B?Q25NRHdwOVBmcFI0QWlJV2dyTlhnYkJ6bGRTYVpya3IrNmsydkpDdVNReUZJ?=
 =?utf-8?B?UGcwcW1YZTBUbEZGalU3Sk52UkNuUTFRL3BrRm1jajNxRFpqNldRa0k1TFM3?=
 =?utf-8?B?TVJHZjZDeXo2K20yZXBuYlR6ajRFYnM3ZWJTNWhhcks5MWFJb1FiOEE2YzlS?=
 =?utf-8?B?ZC9hemJaZmpEdC9EYlNFdGdLNFR1S1JyNzRDQk82OS9NZHlkVG1EMnhZNVl4?=
 =?utf-8?B?cWpPeXUvNkZrSWhsTkVOQ2s2VUo5bXdGaHc5bzlTV3J6b3o3RnRURVVSMkhZ?=
 =?utf-8?B?SklHa3NrVjJuN2Rnb01mS0xlcEJtY1dsWllKcDVRMlRrMkhyaHowa1dQWGUx?=
 =?utf-8?B?MXIxaFZ6QXJ5RzdTV1l1UU1ROEdsNUp5RUg1ZE5hM2hjZG41ZVduYUgybUM4?=
 =?utf-8?B?TE9TTUJESVJDa3hmWThpMEtmVTEyd3NKdXZQTmtocmxNRXhReEpkVVBRUExV?=
 =?utf-8?B?YlBjREJIZkpuUU45YlZJTVNuaWFZYkRtMUdhSzlrcU9wMGFNck5vOXk2azN3?=
 =?utf-8?B?K0Y4cmlkU1pkUTdHZWQrNnNMRlMrVEJjeVdSdktqNzViM1RzOVg0ZzhjdHJ2?=
 =?utf-8?B?dmFvMEx1SDVzWWxmRnpNMjBOakREbEZLb20rc0dFUm9zQkF1aWFLbXlQeXNX?=
 =?utf-8?B?QU9TOVliNnB2ZmF1QmhxdzVqUkRJU1FJcUpkbXV3Rm82RXE1dU92WCtrVVl4?=
 =?utf-8?B?SlE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 395332bc-afa8-48ff-b659-08ddda820c59
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 15:57:04.5138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QiyVVFy7+pZ/yNULQSmrtzQqLu0/MVAEarrCp7AskpjF0z6xxkl4NQ7Sr+0dL6cSwpsg+i8ST3KjlBnRn/HpwcsSEWN71PFg87y0nTiOZsU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3638

Am 13.08.25 um 17:45 schrieb Łukasz Majewski:
> [Sie erhalten nicht h?ufig E-Mails von lukma@nabladev.com. Weitere Informationen, warum dies wichtig ist, finden Sie unter https://aka.ms/LearnAboutSenderIdentification ]
> 
> Hi Frieder,
> 
>> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>>
>> The KSZ9477 supports NETIF_F_HW_HSR_FWD to forward packets between
>> HSR ports. This is set up when creating the HSR interface via
>> ksz9477_hsr_join() and ksz9477_cfg_port_member().
>>
>> At the same time ksz_update_port_member() is called on every
>> state change of a port and reconfiguring the forwarding to the
>> default state which means packets get only forwarded to the CPU
>> port.
>>
>> If the ports are brought up before setting up the HSR interface
>> and then the port state is not changed afterwards, everything works
>> as intended:
>>
>>   ip link set lan1 up
>>   ip link set lan2 up
>>   ip link add name hsr type hsr slave1 lan1 slave2 lan2 supervision
>> 45 version 1 ip addr add dev hsr 10.0.0.10/24
>>   ip link set hsr up
>>
>> If the port state is changed after creating the HSR interface, this
>> results in a non-working HSR setup:
>>
>>   ip link add name hsr type hsr slave1 lan1 slave2 lan2 supervision
>> 45 version 1 ip addr add dev hsr 10.0.0.10/24
>>   ip link set lan1 up
>>   ip link set lan2 up
>>   ip link set hsr up
>>
>> In this state, packets will not get forwarded between the HSR ports
>> and communication between HSR nodes that are not direct neighbours in
>> the topology fails.
>>
>> To avoid this, we prevent all forwarding reconfiguration requests for
>> ports that are part of a HSR setup with NETIF_F_HW_HSR_FWD enabled.
>>
>> Fixes: 2d61298fdd7b ("net: dsa: microchip: Enable HSR offloading for
>> KSZ9477") Signed-off-by: Frieder Schrempf
>> <frieder.schrempf@kontron.de> ---
>> I'm posting this as RFC as my knowledge of the driver and the stack in
>> general is very limited. Please review thoroughly and provide
>> feedback. Thanks!
> 
> I don't have the HW at hand at the moment (temporary).
> 
> Could you check if this patch works when you create two hsr interfaces
> - i.e. hsr1 would use HW offloading from KSZ9744 and hsr2 is just the
>   one supporting HSR in software.

My hardware only has three user ports. So that might get a bit difficult
to test. I will try to configure one unconnected port to set up two HSR
links, but I won't be able to fully test this due to the lack of the
fourth physical link.


