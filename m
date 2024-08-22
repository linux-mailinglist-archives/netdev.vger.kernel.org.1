Return-Path: <netdev+bounces-121192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE41E95C188
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 01:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9685628414B
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 23:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B9A17E46E;
	Thu, 22 Aug 2024 23:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="sFeXP0Kw"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D840A1304B0;
	Thu, 22 Aug 2024 23:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724369631; cv=fail; b=nPLXR9foGMTBj/TWUhBmNSoMegGSLSnwHkdQrQSVIfqo5whQ3T/ueLdESFkXA/TpwmoXYB4cfHdRmCYHwtUQUTTaR8gYLfrWKrsn9aVP5SBwAIKUowOfBClNMszx27HM16XLuBITfe3BnttONEOKtFhIXX923JASzjhrlbGbHbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724369631; c=relaxed/simple;
	bh=TeFke1XqGE2OnpqFd94l3OkbIIGVvvOyFW7J4vPS5Hc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kblho+OqkqpvOwo9Xteyav3QmxirMhVcD3tYG2hCEv8d/4vSMCDkZp8wUOf9WRI61uMt27J7s/L8Y1wjZ9/853SM1MTT1m2Vn8Z0JaGbF5iNNBG+hXmvznf1NmD2llHLgIMFEy2eoQPjGsBFOHOsmheyogCKAZwGaOga/NRNafM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=sFeXP0Kw; arc=fail smtp.client-ip=40.107.220.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XkQPrMG1RrQhUyeY2jLu48YpTRRL3prqwmQBSmEPyAsYKh9BmG+wo+ML00JSafVkixSb/LjF7V48urfH2eXLpI+eAV58euocT9NLkxo4He4CaSPkPFsD6DNq8viypnZe87GvPc/wdNcY8u+driCv0W2H1ZO7bsy2IRzdvD2aK/A6bufGbEZkVPFBjqPq4YNsDrAIRXgYV29S2aYlIh2mQQe1BjV4QFNJho9NyGn2iENkOqUOZjF9IfCcTZ2wiN7tzQCGfVsCLDVMW5QiwVN5SftgUcmk/BKDqQjsg3s5at07KgQrR0KQ800LqYZ7skvsqKUgD/YPw5XmauoCqfDrRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TeFke1XqGE2OnpqFd94l3OkbIIGVvvOyFW7J4vPS5Hc=;
 b=sP9RvHY57+RjzBkpaZ6+R227I1yblwikaTN0ft/RTVf5pDZb1u+LUjfi3/u++ZP2U8X+xb+i05I3+94R8SMSFtWr/HY43fpI1KSgmpQgzyKApXwhe/hUTJJK4Tmte5SctuAZyYuq8ol3LeuZ6Bcvt510SLUdDn03iGxDQUbgQM7Qv60oFnyke+rg3pq+LOcEObueZWtl+y4vy+rv43gfg+J3rsFn0CMq2geGbJvzoyZ64AK8bsYssjfF6662L6c0O0fO3+4E15yUZOnohj/Gn25JQ0xjVmWK0qnY1N8ZV5z9fswls0EJdN93RrujalITqdwg3B8NzgLIWdu0twDprA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TeFke1XqGE2OnpqFd94l3OkbIIGVvvOyFW7J4vPS5Hc=;
 b=sFeXP0KwdhQSjd4y2dUPjLJz3Qvsjm32MHyrloC0MiYKIrxx/weB8hWcsVCW0Z8Qn5PO9Tk2TYqZHFN8ZOkubFh8vWqXWxlro/FeYkLttzqkQv7gnF3F8Xgg7mT9uxaeJQHMV8xNYksTp7BxoysVvKiZfmRGHpK3ZNVpdGl1sf9UkbV9/ROTCSB1ExsKtu9UYXmMzFcsm3U8dk0ezR6i+TzYlY+6NSdKgEtOFgfphxi0n6xGrAFz40+W6YuOgvtkzNnFEGTpd4xTTikZhSkHLcM3w1DEk95nDvvNwmb+Ur6YfdPgAlPDN2APE1RVsHkVxfgOAQJFGqAstZvT8xQmxQ==
Received: from BYAPR11MB3558.namprd11.prod.outlook.com (2603:10b6:a03:b3::11)
 by PH7PR11MB8124.namprd11.prod.outlook.com (2603:10b6:510:237::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 23:33:46 +0000
Received: from BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::c03a:b12:f801:d3f6]) by BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::c03a:b12:f801:d3f6%7]) with mapi id 15.20.7875.023; Thu, 22 Aug 2024
 23:33:46 +0000
From: <Tristram.Ha@microchip.com>
To: <pabeni@redhat.com>
CC: <o.rempel@pengutronix.de>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <Woojung.Huh@microchip.com>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <marex@denx.de>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
	<devicetree@vger.kernel.org>, <andrew@lunn.ch>, <f.fainelli@gmail.com>,
	<olteanv@gmail.com>, <robh@kernel.org>
Subject: RE: [PATCH net-next v4 2/2] net: dsa: microchip: Add KSZ8895/KSZ8864
 switch support
Thread-Topic: [PATCH net-next v4 2/2] net: dsa: microchip: Add KSZ8895/KSZ8864
 switch support
Thread-Index: AQHa7rnc/3sa+M6QMUWSGIxDEI+x1rIv9DoAgAACCACABANzgA==
Date: Thu, 22 Aug 2024 23:33:45 +0000
Message-ID:
 <BYAPR11MB355886892ED33138F4B8C8F1EC8F2@BYAPR11MB3558.namprd11.prod.outlook.com>
References: <20240815022014.55275-1-Tristram.Ha@microchip.com>
 <20240815022014.55275-3-Tristram.Ha@microchip.com>
 <9bd573ff-af83-4f93-a591-aab541d9faac@redhat.com>
 <584ce622-2acf-4b6f-94e0-17ed38a491b6@redhat.com>
In-Reply-To: <584ce622-2acf-4b6f-94e0-17ed38a491b6@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3558:EE_|PH7PR11MB8124:EE_
x-ms-office365-filtering-correlation-id: a6c799db-8e2c-46ba-5b73-08dcc302dde8
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3558.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RXhlWHQwVk9jUmd4eGVPUXByU2tzNFVsR3RyeHVjaERaOW9ZU2FUTzBVcS93?=
 =?utf-8?B?TWtxblhpQTRmZStqSURHc25iVkNCb0JaVGVhd2MvS0k4ZjBaalFQQVdTMjJh?=
 =?utf-8?B?cnZsWks5UzVjWFRXS1NPa2x1dW1jUTRQSnhEdVdhT2s5TDE0OE0xUzFEVFNw?=
 =?utf-8?B?eTJ5MzdaSEpidSt0SDY0ZWwyb1FVVkI4MitIRm1kZUduTWNBYmlIdGtYdldP?=
 =?utf-8?B?aVBrT1lCRWptdXhjSERWTFBMcmorRHg3ZS9CSUdHWHhmb2llVmx6R0ludVli?=
 =?utf-8?B?dzBEeURIaE9hSThVOGNiSG01QmIwSnNtSFJjL3NpcVlqTWJFZTRaNjJhZEk5?=
 =?utf-8?B?UVdsc2RUa2Nmdk1oVHNVZXkxcXozeHhBam1IU1h5cnlOQjVyZWtuUVAxMUVr?=
 =?utf-8?B?QWcxVFRjTFRKSEFmSHpQYWlkNyt0VzJHY1RFdThWM0pSbWNxYW9qTU9NdE10?=
 =?utf-8?B?ejNzSWtVeEpQdk92dDNSV2thV2ZuU3hGWEFBR2M2Z3NEZkE1L2ZyTWxoa2Jt?=
 =?utf-8?B?c1FEQXV3L0NaRVAwYmQzeGQveE4zajY5RVo4Ly9rdlcyN1JMNHdkQitUaHA4?=
 =?utf-8?B?eUZyRHYzRjBHQU8yczlFOERzd0dYQXJWSTBjL1Bvbk1za05zL00wenBlang2?=
 =?utf-8?B?YnlsaUJsdVhXY25DdUMwWUhYOVpxWmEzRzNMcjNMWGFzNWN2ZTdNV3NKNmNo?=
 =?utf-8?B?dXZqWDhnZ1NSNEx2djNZWEZKc0gybnJIZkc0RmZRUkRVK2I4blpaNUhiZE5n?=
 =?utf-8?B?ZG5HKytuWk84YzdOTE9DeGRTYWcxNzU5bU5CUWpTQ2VySEM3Wjg4bEtKU2gy?=
 =?utf-8?B?OGFwODRZNGNGcmhWQmVPZVhHcE9scDF0NFIxMVNzeDRGdkVZYlBPUXRjYm8z?=
 =?utf-8?B?b3I0UHhtS1VMek4yMExWaEFUdyt3TjZaNHJOZkxtQ0QwRUxYblRiZnUxNFhp?=
 =?utf-8?B?Yk13RkhFTEtMZ2tRWjBDcTUxdGFpVkhldU9uSDRDYkI2TXNYOW8vSHBlZ05l?=
 =?utf-8?B?dnJrMGNrR2tOUU80dWFINWdZMnBjcWNuTFlXalBhYVBLdXFtaDQ2SGVkTEpB?=
 =?utf-8?B?Lzd0TFRxYmJZSEx2TUpvdG9QY0ZKeFhJRmp0Y0dMMDl4cnZXWG9NZmt5S2Vr?=
 =?utf-8?B?SW5IaFBmbnYxMnd6aTBhM2pSSjgxY3U2UjhpYXNKaVlybUY0UVZQMFhzSTZz?=
 =?utf-8?B?ekpKVEh0amQ4RDVoRkxIN0dkb1hlL3gvSVRmdWdKdTNmRHU3Mk1uNFd3N01n?=
 =?utf-8?B?NG96ZVFXMDQ5c2xSSHdZZzB5Q1ljMExIL1d0Q2lOYzBqMXpUU0hPYjAzS294?=
 =?utf-8?B?Nm02bHRjZlFueFRRd3lIM2pUeFRkQTFSYjM4K1JlR0VJRlV3L0I0RktxTXlm?=
 =?utf-8?B?SDFKSUtpMzZ6WjN4K2NVekJXUGVKNkkwWXFxU1JNeHVzRnR2Q2VMdElvYlVz?=
 =?utf-8?B?Uzl4SGd2NGs2QVNzeDBiaFNuYVpZRmZkNEtiNHdFOCtXV1k3M29lUHFxUUNx?=
 =?utf-8?B?WW1sSlNVZHVxcS8vMnJjZjlJZnhDRDJiZjVubGs4MjliQUZmOFd4elc3OWg0?=
 =?utf-8?B?c2srbTRvNFNOSzlCTnpPbWNaMFNpOGdSQms4VWJkc1JzNW8yK3NxcDVJS2Zj?=
 =?utf-8?B?NTVpTTVCZzA3L2YvVkhic1l1Qm0vditJbHVoWWJ6MXlDSllXbEx5a0piaVdD?=
 =?utf-8?B?Nk00NGZnNW5OU3pkK2dON0Nybm5BOE9JMmFuWWlDT29rSEN1MmlMUGVzSTF1?=
 =?utf-8?B?WU54VHNETjV3ZkxRL3EydWYybi9FZ0xlaDNjakVGNzJPR1NyeUxTV09OQTBZ?=
 =?utf-8?B?LzdmdFFwdU92a2RXbkhWUEpSRHNVMm5xbVdUOWMyejRMZVBLcFFyNGhXTDJC?=
 =?utf-8?B?WVd5Yit5dXRzeHQ3SnVBUUFYbm9xM2gyKzRydFlRSytaQkE9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SjA0dzZUUGxPdVhFWTNLL1FXelovODR3VkxtbnY3eUpLUjJnZVRGREtSZjlX?=
 =?utf-8?B?dFZqVDFGTEtXZnBDUVlWUzEzMXR1TUwrcXRuNU0vYzJFT1VZMW91a0gzWnNm?=
 =?utf-8?B?RDRIemJ4ZE9hcTQ0azV0VEtYcGxydHRCMi9SWXRXbUgzcHZwY2tlMEpMSTB5?=
 =?utf-8?B?WXo1d1llOE9JNk9oOFBUdHBuQnpJalRYeklyVEFoM2ZHMURUelBzN3p5MC92?=
 =?utf-8?B?bU1sMXhaNnVwQjByU2hnMkVXckhQU1piVm9sdmpjRHhQU1VmbUIvYTNGQW1r?=
 =?utf-8?B?TWsra3NFRjBtZEI2WHpsYkY3UTdsU25EY0pWajRZd3dOeDgvYTFLRUhqdWpX?=
 =?utf-8?B?dlJ2MzIvUzJOR2VzaDlHcHFiZXJhMHVmaUVLeXJzQ0RXakVLWkd3VkQ4VXNN?=
 =?utf-8?B?aStBbDVxRklyejkwNkZoY0YrSVBxNG9pcndpVm9YYm9mYmRKTzZDc3FaVmd0?=
 =?utf-8?B?cmhxWWVKWW5Xbk9vcHFsZVlnS3ZOY0R5TTcvVlRyeElRUnlXbmhzK3BwV2dW?=
 =?utf-8?B?aUt2cVhBTXhQd2hRd1F6a2NTTWNGNHhMOVlHbDNQUklzOGFSbXBkZFp3Wm9j?=
 =?utf-8?B?MFJEeDNieDk4eEVycEtXb1F3QWpPZWhua2w1eWRvcGV5SW9Vcko3MVpWdUdK?=
 =?utf-8?B?SGFGM0p2eWRDN0tBNkh1QjZyRVpTeThRaE14c2pLeEVtQmVXQ1VBN1RJYmF5?=
 =?utf-8?B?UTlJa0ROZlhTRXVvQk1SRUhQQXFISitiQmsyM1htdDNpdWx4MWNCQnQwOEUy?=
 =?utf-8?B?R0hIVm54Z21YdEM0cnkxK2dibXhzMDdZWEtscTZaWHcvT3JtckQ1eGlqdHJP?=
 =?utf-8?B?V0dnQjdZSWs0ODVBUW1qUUNLbmFSeWxNaVhwdUxoaStmbGhieDE3cWJ6OE9Y?=
 =?utf-8?B?Y3RES0VSaEpPcC9YbkdlcjhxVzlOOUZ4b1dZZDNSQkMwR24wRU15ZTJ5MHJq?=
 =?utf-8?B?WlV4eXRJTjFOc29DZXJWRklzbWNVc2NRc3pDTCtQb2tKNm9nalVSM01BNGdy?=
 =?utf-8?B?ZE9FbkUxeXpIZkpuWTdpWXpWTWNvQUFFdmo1ZTdUOTJGWjlGZFVxQ2F3cWxG?=
 =?utf-8?B?VXZvUXJQZldJbyt3NlAwaWFFVlRobG52SmE4ejlWaitudVdYYWtNREtwZ29V?=
 =?utf-8?B?SDROZTNvQ0dBYmVvTG53M2ZnMFFmTHdYcGt3SEV1dUhPeVN1V3RRTkVuNFoy?=
 =?utf-8?B?eUNLVFNXVGJ0bnhxekJvWFNTM2RkNjYxNDRxOCtvS3Y5Rm9WTHM5T0tKSUxM?=
 =?utf-8?B?YlVsdkMvRUZEdFE2Tkd1ckxDZkU2S1NSY2YzRWRNZ2Q5S05WWjYrL2sxZnRn?=
 =?utf-8?B?VWVvaWhvWWJtQVA3YVpyTDJmQkFOZHZKemsvekpxdzdMQXBxMG1jMU8zaUdq?=
 =?utf-8?B?bGtuYzdjTVF1NVZTdkRzM0tnb0ZRSU5RVVk3T1hFYVNtSGFJdkZSNFFWRG92?=
 =?utf-8?B?MUlyd0VBSW1reGFNTzN4clBtZjROVHpxaE1sR2VhdWJZQ0dPS3hyaGZNY0hS?=
 =?utf-8?B?V0s0clhSckhFekVlVWRySHBZNEFjUC8rTWpwZy9qSU14ZWRBV21FM0xhMU1y?=
 =?utf-8?B?azdscm9NeExjODNCSnF0N1hDODJpaFQwWkVaMnNBdzdUb1F6RVZidS8vZ2Vt?=
 =?utf-8?B?VHljcXY3cFlUYmFwRW1ZcXVLRjI3bFlTdlVSVW04RjROQUpBNGdGTGg5ZmdT?=
 =?utf-8?B?OFNYNUdqSW9vdWViT0h0UFpBZkMwNk9ubTN0cVpCa0IxM0Rrem1mZVhyQ3dp?=
 =?utf-8?B?NGtSRTlmSGJha3hBd0dyZXFUN1lHV29OUDFYR1hRd1B1L3RxL3FDeWFDek9s?=
 =?utf-8?B?VDc0OFdNZkhack4yOHZ3UUMwUGFCWG5KaUhJKzFSamxEajI4a0FQbEJBcjJj?=
 =?utf-8?B?cXNjb2pJam1iUkxsdmJQWDFzRTg5RVJiOUc4TFVxNWp0VnJZVzJrV0xUVUR2?=
 =?utf-8?B?QldhSk9tU1hQald0VFRSOU9Tem92U2FPWVkxYmkvOEJyMGVRMjJwTzAzenJC?=
 =?utf-8?B?ZmFYNVczcGtCQ01EQnp4VVV4UENRWnlZV2RibGdROENwaUFNQU5mNUpkOVFN?=
 =?utf-8?B?S3pFNndOV3FLMnVJRVlhV0xKODdmR2R4OFVZNWd3Ukh0NFNkVUsvQzlFRGZE?=
 =?utf-8?Q?NOOaKBKRcFgnr5+KTbYg1qKrA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3558.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6c799db-8e2c-46ba-5b73-08dcc302dde8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2024 23:33:45.9660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RBRj3iTeEq720+VJ9/ukCmGlsf844mdmZzHl2S8SbU03R/ZpI7pPuHkNGrnsQ0uvzo8WKaGMYme6onoVipZL+bHsm/ITk1gONqPvFidj038=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8124

PiBTdWJqZWN0OiBSZTogW1BBVENIIG5ldC1uZXh0IHY0IDIvMl0gbmV0OiBkc2E6IG1pY3JvY2hp
cDogQWRkIEtTWjg4OTUvS1NaODg2NA0KPiBzd2l0Y2ggc3VwcG9ydA0KPiANCj4gRVhURVJOQUwg
RU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Ug
a25vdyB0aGUgY29udGVudA0KPiBpcyBzYWZlDQo+IA0KPiBPbiA4LzIwLzI0IDEyOjA4LCBQYW9s
byBBYmVuaSB3cm90ZToNCj4gPiBPbiA4LzE1LzI0IDA0OjIwLCBUcmlzdHJhbS5IYUBtaWNyb2No
aXAuY29tIHdyb3RlOg0KPiA+PiBGcm9tOiBUcmlzdHJhbSBIYSA8dHJpc3RyYW0uaGFAbWljcm9j
aGlwLmNvbT4NCj4gPj4NCj4gPj4gS1NaODg5NS9LU1o4ODY0IGlzIGEgc3dpdGNoIGZhbWlseSBi
ZXR3ZWVuIEtTWjg4NjMvNzMgYW5kIEtTWjg3OTUsIHNvIGl0DQo+ID4+IHNoYXJlcyBzb21lIHJl
Z2lzdGVycyBhbmQgZnVuY3Rpb25zIGluIHRob3NlIHN3aXRjaGVzIGFscmVhZHkNCj4gPj4gaW1w
bGVtZW50ZWQgaW4gdGhlIEtTWiBEU0EgZHJpdmVyLg0KPiA+Pg0KPiA+PiBTaWduZWQtb2ZmLWJ5
OiBUcmlzdHJhbSBIYSA8dHJpc3RyYW0uaGFAbWljcm9jaGlwLmNvbT4NCj4gPg0KPiA+IEkgdXN1
YWxseSB3YWl0IGZvciBhbiBleHBsaWNpdCBhY2sgZnJvbSB0aGUgRFNBIGNyZXcgb24gdGhpcyBr
aW5kIG9mDQo+ID4gcGF0Y2hlcywgYnV0IHRoaXMgb25lIGFuZCBpdCByZWFsbHkgbG9va3MgcmVh
bGx5IHVubGlrZWx5IHRvIGluZHJvZHVjZQ0KPiA+IGFueSByZWdyZXNzaW9uIGZvciB0aGUgYWxy
ZWFkeSBzdXBwb3J0ZWQgY2hpcHMgYW5kIGl0J3MgbGluZ2VyaW5nIHNpbmNlDQo+ID4gYSBiaXQs
IHNvIEknbSBhcHBseWluZyBpdCBub3cuDQo+IA0KPiBVbmZvcnR1bmF0ZWxseSBkb2VzIG5vdCBh
cHBseSBjbGVhbmx5IGFueW1vcmUgc2luY2UgY29tbWl0DQo+IGZkMjUwZmVkMWY4ODU2YzM3Y2Fh
N2I5YTVlNjAxNWFkNmY1MDExZTUuDQo+IA0KPiBQbGVhc2UgcmViYXNlIGFuZCByZS1zZW5kLg0K
DQpXaWxsIHVwZGF0ZSBhbmQgcmUtc3VibWl0IHBhdGNoZXMgYWZ0ZXIgdGVzdGluZyB3aXRoIG5l
dyBjb2RlLg0KDQo=

