Return-Path: <netdev+bounces-184333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 604E1A94BD8
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 06:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14C1C18905AC
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 04:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC265191F7F;
	Mon, 21 Apr 2025 04:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="NDPMLJ8+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD13A933;
	Mon, 21 Apr 2025 04:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745209049; cv=fail; b=a0GtOylePEjJNKAGPlxxFTReCLZ7ZL0CApvAZHOF29s9aRGzlWXdHv0mphcyQF/wqjXQSzCk6QnQOOVDg5KEOJV3GRC41BPi5vknSAndn47KV4L/pwWBDuk30dF9rihIJjb42kJ5PMZp8FdgjDg3YSReBonsDeS2B8ThL4NcVRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745209049; c=relaxed/simple;
	bh=/kAfWKcq/LlITkm/wnJlXjY31O1GVFovBl4FmVQNZV8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sD9GsFihGmc7/S8aBw1PasNti1B5bzy7TWrlRTP6Tza/zDrWAkZ0Z6OIJ10kalB1JJFGdXXJNwNhjcFdlpd/GCrCcULH6Gb75+Mwr+M6MO1my0Ky5AWLqJmYslXNjpCc0o2S821jB7p7mTb97gmvFeZiSZyl7cneARBUvSq7vBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=NDPMLJ8+; arc=fail smtp.client-ip=40.107.223.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LdhswgahWVR0UV0t3vBSwP/D5D7bUQMxfETPHLdqYFdgVQDWUABJ3cfkHj6vQyMXYvNHsJoMmxpEYSGYlzr2WwvlAsacbBuObPiqswiw/UZz0/LqljEbaNYCUGC1rwwd96VfXB/OIbXi4ZLcFGy8zA5acGAhNQqgSqi9LV+OK/hEA6Cd3VR7u5AncPjO0JhTz/n+IzP/LZ0oSBFjKB+UQZgsEforFVDy1ZzIY6zpfvYQaS2tXbAANgtZ5qYb/YYdv6t3unPaegb9a1RfgTOexIkWC6MU112vvsSUYHXsOkKT/0PqA29jCGgyJGrJW6UZBzUujaph+4AkYBsBHR9STw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/kAfWKcq/LlITkm/wnJlXjY31O1GVFovBl4FmVQNZV8=;
 b=gzZ09ZwWtKQRrpzD9UHhNhyXjGmo12BXxJrZhrjFrBmDzNutjWRbyUpy63V5hadYiHA339yjFcGCwtd8BKmzBqRFb2TZrlzV84uoT9PMk0fDMZlcJnB0MCxuTjA+1fqRwN3hohj6OicTRXAfFTRyuwfROjKJgxqGnXyaDyjNGeNeMKTSZB55/JEJM4/DuQMxV3NFaHbtbxA2oUFK65qYALG8zzE6ZLgxb43Y1Jk1Tqa//yF57GT0ZdLC0tOgIbNHQFIaZz7lZsA7yJ3Mfw79OYit2qmHY595H98wpVT+XpzT8LvgKczu3qpmnc8zxy3EA8YWGVyglLCdDgu+fbkpKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kAfWKcq/LlITkm/wnJlXjY31O1GVFovBl4FmVQNZV8=;
 b=NDPMLJ8+cFTxqO4KqfszH3KVBaL0lHxkUnikSk9I/lvFqCK+y1W2XGPOblKBuidyLhIJ0wQSSDjQrSZW2bIt/O8rrUl4hfFiNSyvmPlgGAU5pF6IxMGNWK1HVUDpO9VkL5qk2OiH7eLDp+MoPu42yx6Ftxc24k5ol1rDpc2ID5TlfeQyY+42otwozq3WeUrFzgMbB/TGnhvFUSMstMFbkLmCTFyRWh3Gsu/rwFlEQrg9c3tmNbE1vr5InjzIcaTLi5Iy3W/tvFFGagIQX4ie2fP6g8MlHgm9KHgWkZR0my4ADs9uMMtNI6wMnbnKyB2NXVGSAP5B70n0shfhBzS6RA==
Received: from DM6PR11MB3209.namprd11.prod.outlook.com (2603:10b6:5:55::29) by
 PH7PR11MB6772.namprd11.prod.outlook.com (2603:10b6:510:1b6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Mon, 21 Apr
 2025 04:17:24 +0000
Received: from DM6PR11MB3209.namprd11.prod.outlook.com
 ([fe80::18d6:e93a:24e4:7924]) by DM6PR11MB3209.namprd11.prod.outlook.com
 ([fe80::18d6:e93a:24e4:7924%5]) with mapi id 15.20.8655.033; Mon, 21 Apr 2025
 04:17:23 +0000
From: <Thangaraj.S@microchip.com>
To: <andrew@lunn.ch>
CC: <andrew+netdev@lunn.ch>, <linux-usb@vger.kernel.org>,
	<davem@davemloft.net>, <Rengarajan.S@microchip.com>,
	<kernel-list@raspberrypi.com>, <fiona.klute@gmx.de>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net v2] net: phy: microchip: force IRQ polling mode for
 lan88xx
Thread-Topic: [PATCH net v2] net: phy: microchip: force IRQ polling mode for
 lan88xx
Thread-Index: AQHbrrnF1NHCR4iO/kqLmz8BohiEhbOnkk6AgABWFACAAEJPAIAFX2WA
Date: Mon, 21 Apr 2025 04:17:23 +0000
Message-ID: <151585637e9ada09bbc2bd2e3ab85c4d491bcc5e.camel@microchip.com>
References: <20250416102413.30654-1-fiona.klute@gmx.de>
	 <fcd60fa6-4bb5-47ec-89ab-cbc94f8a62ce@gmx.de>
	 <ebb1fe9a31abc4045b2f95072c6d3d94ee83239e.camel@microchip.com>
	 <3c6abdaf-b4e4-440f-9d75-745741287007@lunn.ch>
In-Reply-To: <3c6abdaf-b4e4-440f-9d75-745741287007@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3209:EE_|PH7PR11MB6772:EE_
x-ms-office365-filtering-correlation-id: ae0ddfd5-bc7f-4c65-0a21-08dd808b6aad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dkM3U1RBOC9Jc2ZGMFJYbVVPdFpFYTJUK2lFT1ZzdVYwZzl6aU9FclltVGhH?=
 =?utf-8?B?aEh2UHBIT0k3TzlpOGVDenp6dmZIT0hvUUREdTJaVEc3OWtQQUVkSEdrTHBk?=
 =?utf-8?B?N0VUYzZBRnZCOEt4OEs3V1Fmc0FIcUt4d1B2MHFkZU1rVkpjVGltS0t4djNN?=
 =?utf-8?B?Ui96M1dTUnRLN3pMdGwvUlNpWFVTZDRCR29DaWV0MHora2FNa3d3dWp0K2E4?=
 =?utf-8?B?dUg5aWUxQU1VVVZFZFh5MDVkc2E4WHk3Wlk2SmYyM0tNcTh4UGQyREdpYVZ6?=
 =?utf-8?B?RFZ5V2xTbW5QeEFkUmJ4WVJQT2V3a0lFQTgzQkVCQXcxTzlBcEhCQVNMR3E5?=
 =?utf-8?B?dzVtZ0FGVnRSbGwxOFRvN1BIRVQyZi9HcnZZSGJDSHFBZkd3Wi8xNTZXYkRo?=
 =?utf-8?B?d1ZkMHVzUmhENmllM1QxbHo2RHM0NXNrSkh6M1luWkpCTU1YVHhhbUpseFBZ?=
 =?utf-8?B?RmtvUy9QUkxWWTlaTXRIVnRPZG1OS09CVmdPNHFkTHFvNDRSTFNQVUt1MTAx?=
 =?utf-8?B?eW5hd1Jya1BiUStrbjllMmJEWitHSkJxNGg4bWlZd0swWDh2TjNXdi80YWlO?=
 =?utf-8?B?UlhYTmM5bVR1VnVkTERPUE0raWNoNHFaZ3YyenJ5QzI1TnVMS3BnQ3lLUEU5?=
 =?utf-8?B?YnpHNTNtanh3UXgzYWVDb0lpMk5yekpsMDNqc28yUVJ1bDBOd3pTendXN01Z?=
 =?utf-8?B?OHBReWJsWEV1RnFFaHVOeVJvV3YzMk5xOHhNM2dQTlRhQzFMcy9Xc0FnS25X?=
 =?utf-8?B?U01NcDVwd2pHeHNoUnA5YXU4dDl0ZHJCR0Jmcmx2YTk2d1Evd3BzRWdJNGNW?=
 =?utf-8?B?K0p1aHFHeDVIS3hRa3ZvN0tEUUFPMUM2ckp0Z0tsZkR6YzF4MkhlUERCSDRI?=
 =?utf-8?B?c1RMM2pyV3lkNUlzcUNRWkNPNGFoUDhLYzRpdE1PYS9zY3BaeUdONkhUQ253?=
 =?utf-8?B?cS85V0YwQmJRVVJyWnRMOHM4U2x1Z0xIdUp2K0M5YWNHRGtIRlZvbzNVMEQ4?=
 =?utf-8?B?bm1tNy8wSXFtMFZUL1llVXpKV29HTjhvWDRWb1dwTGVFUmdYVGRkbXlBMWt0?=
 =?utf-8?B?M3ppcmlzVnB6RHVtazZ0RHI5S0RKa2ZPbXVKVjhDdTdubXZQa2RuVTk2aVY1?=
 =?utf-8?B?S1lYeld4Mkl0Tk9OWWxoWU5NZEhadDI0eXJqRmxoZng4WFV5U2dmT0VJb29u?=
 =?utf-8?B?cHluZThxZWU5NXU2MHVrc3YxeTA4dXJuajVoa1pyV1RUd2YrWmQ0VUw5QWFL?=
 =?utf-8?B?VmVoQUloSk92Nlp1Z3hmeVR3bVhNeEl4WUpLQnpKcldsaDF6UDFhWlFweURq?=
 =?utf-8?B?emk5aFFvNzZNZWVHRzkrVjVNcEQ1d1I1WU5LdHBJNW5vNVlxU0NmWkNlZ1cr?=
 =?utf-8?B?ZzZNSmc0ZGxQNUJDNnFMakQ2TGh5ZGhRRmZ3QlNUdkpvRng1R1lpb255WlV6?=
 =?utf-8?B?N0xGeGVMaE1RMVZPN2w2dDFRd0JQNEw3N0ozRDVUK0VFY2ljQm9PQ0dtK1hD?=
 =?utf-8?B?Q0RqdlVLaUNERmJIYnhENytxdWtERnIwSUs0Wlczczg5NkZsRDBQazFSc3BH?=
 =?utf-8?B?aTJ3WWJNOU1EcUc5YnRYK2p5Y3FWUnNzWWZ0T2JzTENOWHNZb0VYVnhUa0Na?=
 =?utf-8?B?aW1rbzhkV0VPYkdCTGRBSVBYMzZYOUpRbTNxd2JxUjIydVprWC9Pcm9NM2Rk?=
 =?utf-8?B?VU1KUGo5d1pmZUZXclFhTUVObDZKdzU2QUZkSFhQWjAyVUlkS2R1TlArVWh2?=
 =?utf-8?B?dTdjNm5pSUxBN0xNM0pSc0hRaElXMXZ1bnhoTkdIbmphOU0vR0d5OGwrU1FE?=
 =?utf-8?B?M2F5T1BvRVZ0UUU1d0lqOGdGZWh1VWFocCtEcXNhWEUyUS9FcnVOUFhuMlQv?=
 =?utf-8?B?dFR1SzN5RkhJTkxnUkN1cURWTnVDdFJhTEgzQTJmN2FsQS9hUTN6OTdjVjEx?=
 =?utf-8?B?TUtwaGxrT0ZpVnR6enhaTUJpbER4MFRNanlhWUZtOWtGRjM0dXR1NGkyL29U?=
 =?utf-8?Q?KUNfS9Yccn38XgRygWqwDLW7oDt2qs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3209.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aXZwM2crTUhrRktlYmNHWWx3Unp5MkFJVWp6a053QThhb29RSFFtcldJSFpS?=
 =?utf-8?B?Q3Yyck9pVzdOT2N6YUJBQzFDTCtzQjJ4R3BiTEZqV1NKeGhNNVlYTVZKSDg5?=
 =?utf-8?B?T3JEWU8vV3N4TkRMQlZLVlRFT2xseVhiY0hjeTNObms3MG5IMHBLMHAxUEpj?=
 =?utf-8?B?c0t1RXM3RzYreVFVQlFXN25hcVVlV3o3Vnd0OU1EcEVkL3d2VzJYVWZRdmRS?=
 =?utf-8?B?MFlNL21EYURGK2NJd2tPOTdveDQ1REZ1bXcxZU1XdDZHMVNpVzlMaUdEdkJq?=
 =?utf-8?B?SjVGSjBwcWFLeDRuTjRuS05wcEY3Q05ubzdGOWxxZkFQS21wY0g4eWFqRXZu?=
 =?utf-8?B?QTVNaXRTR0tibGtVOHBYbTJSOE95eTNySTNwWHcwZlJSOUxVU3JMU1d3aDhH?=
 =?utf-8?B?THBkYmRFaUtDV2poaVlwM2hjOTRIQkJ3Q3lKS1JCOUIrdUowMm5HZm1sVENp?=
 =?utf-8?B?Q01mblZXQS95eGlpaFBVd0JYWEt4Y2pBVGkwd1ZjTHZMMkVlNHRucThWK1Ar?=
 =?utf-8?B?a3RRWUdrMjJiOGJKck05REtXWkhIZ0x6dzFtcmk1VTVnUlJNN0tEeW0yZ2Rn?=
 =?utf-8?B?bEdNY3BMTk5LRnFMcEhhVGROK2Z6MlZzT2FNY09mTlkyK3BRVmJsN29BbThH?=
 =?utf-8?B?N2hSQkFhNkk4SnVpMHpWaXZWMDU1d0xGcWxvS3JkMFU2djJVNTRlRVpqOURT?=
 =?utf-8?B?ai83RlFWdmF3MDgwNXk2UG5hZlRRVzJHbWRQckJXaFlaMmp6bW5Ccll4Qm1Z?=
 =?utf-8?B?UUI3aEZyejRFRnp2UDdUMkZnT09ZU0JTTXlUZDUxRU1hY1FuazE1ZlREQzhu?=
 =?utf-8?B?T2JLYnVkYU85WkFFS0V0czNGN0ltczlBbVpBRGZ1eEtoSERQR3lPL01Wbkto?=
 =?utf-8?B?ZFE0eitHNlhITDdnbVRJUWQ0NmRXNzBmMDlwODNwVWRacU1vRE1jeVVWUHhU?=
 =?utf-8?B?OFIxV2E5UytTQmdPaXlnbS9YUHhoMm9yYzJlcldWZkRkTXhnZ0V3aHhnd29L?=
 =?utf-8?B?bXV6UGlQVFJjdkpnTVBTREdsT3F4eW0xazBMTnR6NWZkUW9DVWR4M2VNYzVW?=
 =?utf-8?B?UVBBOHJkT0xmOEd1anA1WmY4ZEZWMmRiZTZhOWlZSnNhbENQVExOZnhPUkR6?=
 =?utf-8?B?blpVVTlQN0FrWmV4YVp0U05RMTQ0UGdlYXdiZ1dldzJRRE1MUG1SZkd4NnZX?=
 =?utf-8?B?empqNE4zODVGVlRBa3NOMmhDSGZ5ek03R2VWeGZRVndSNFY2MitVWDlFeUZ1?=
 =?utf-8?B?Y1J0cUVPVVp3OFFqdk9KWmtUYXJZd09TdFBYbjM3eFY0TzNubkZhSnhoZlJz?=
 =?utf-8?B?S1g5ZVpHQzZCdjFJSG1nRlZHczI3TC9zWnI1ZXdETDRLQ0VuamVuNmE0SHlr?=
 =?utf-8?B?eG1oKzEwTFR5enlsYWgvWHpuMUlPb09rTHhXZEx4bmJQcWdTQmtPM3QyN3pl?=
 =?utf-8?B?SW1EdUczaG1EdjFNZjZIajAyUldnd0V3UUM2dXo4eFdUeWo1d0pIVWl4ekxm?=
 =?utf-8?B?RDI3RjJVUFZaUnNnNWpUUVZhTnJRNDNYVmpURElxRG16ZmlQdzErZ3ZaTTBE?=
 =?utf-8?B?MytiTG93cWRRK0ticS9MUk5JYXVEUlZMWWNsalA3cVM0M3lSZWNwQk4yZUwy?=
 =?utf-8?B?Z3NoWFpObE9UajNISVVPZ3VqcnU3U0dLWVZFaUNoUm1EM1lPTndUSEdBK25K?=
 =?utf-8?B?VFJFdTZrd3BHRm1WY0lsMW9VL2luTEx5cVpMMHVuZGhveU1FNUQvL1gvbnow?=
 =?utf-8?B?dGVORXoraFpYOWIyUlE0NlAxRDNBVGtxOUV4Q1hZWksvQ0c3TzRTbnh5RWdD?=
 =?utf-8?B?cGRlbjJPeWdNeGJPak0zbU44L0lsNHh2VW1KcWhSM0dqa2t0Q1RZQWdWN0VV?=
 =?utf-8?B?Q0dhWXp0Zjhpemx3VTlMYmRsbDNtQmpkTURxREd4OVpjUmhWUjNCQTJzV2Ux?=
 =?utf-8?B?S2JTRHZuV0NxRDcrd3FndGF2QWdIQlF0d0RoSFFwbDYxYlpHT3lBSmdxOVdm?=
 =?utf-8?B?cnRvYTd4NkFTdStjNzRVWVlDd0NDbWpEdWZNSUFSSmVlUnk3ZDBRWDFMQkhH?=
 =?utf-8?B?VHlkQkcxVHZRdzNGV01PNUtSNmxzSXZVSHNGaDByRXBDSFVYbzI3QitqeEp6?=
 =?utf-8?B?OXNUQm5kWklKNE1FYnBEQ2V5eWRxL1V1blJ0WGs3WHIwUlJHVDRuSGhFRmFK?=
 =?utf-8?B?ZXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4BB330A1D773624393D3D17A81B2D6C9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3209.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae0ddfd5-bc7f-4c65-0a21-08dd808b6aad
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2025 04:17:23.4849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: buDEgRzN9/C6kbnicJRloVtUBn/R/7Gkawua+F5usncA54q15IqiX5Ov3hlKPgxa3SzxQaKjcJA1SZBk2qsnjRquMl07APQ0FsLfWqaYD3A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6772

T24gVGh1LCAyMDI1LTA0LTE3IGF0IDIwOjExICswMjAwLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBUaHUsIEFwciAx
NywgMjAyNSBhdCAwMjoxNzoyMFBNICswMDAwLCBUaGFuZ2FyYWouU0BtaWNyb2NoaXAuY29tDQo+
IHdyb3RlOg0KPiA+IEhpIEZsb25hLA0KPiA+IFdlIGhhdmVuJ3Qgb2JzZXJ2ZWQgdGhpcyBpc3N1
ZSB3aXRoIG91ciBMQU43ODAxICsgTEFOODh4eCBzZXR1cA0KPiA+IGR1cmluZw0KPiA+IHRlc3Rp
bmcgaW4gb3VyIHNldHVwcy4gSXNzdWUgcmVwb3J0ZWQgIHNwZWNpZmljYWxseSBpbiBSUEkgYW5k
DQo+ID4gTlZpZGVhDQo+ID4gd2l0aCB3aGljaCB3ZSBoYXZlIG5vdCB0ZXN0ZWQgcmVjZW50bHku
IEFkZGl0aW9uYWxseSwgY29tbXVuaXR5DQo+ID4gZGlzY3Vzc2lvbnMgc3VnZ2VzdCB0aGF0IHRo
aXMgaXNzdWUgbWF5IGhhdmUgYmVlbiBpbnRyb2R1Y2VkIGR1ZSB0bw0KPiA+IGRyaXZlciB1cGRh
dGVzIGluIHRoZSBMQU43OHh4LiBUaGVyZSdzIG5vIGhhcmR3YXJlIGVycmF0YQ0KPiA+IGluZGlj
YXRpbmcNCj4gPiBhbnkgcHJvYmxlbXMgd2l0aCB0aGUgaW50ZXJydXB0cyBpbiBMQU44OHh4Lg0K
PiA+IA0KPiA+IElmIHRoZSBpc3N1ZSBsaWVzIGluIHRoZSBpbnRlcnJ1cHQgaGFuZGxpbmcgd2l0
aGluIHRoZSBMQU43OHh4LA0KPiA+IGl0J3MNCj4gPiBsaWtlbHkgdGhhdCBzaW1pbGFyIHByb2Js
ZW1zIGNvdWxkIGFyaXNlIHdpdGggb3RoZXIgUEhZcyB0aGF0DQo+ID4gc3VwcG9ydA0KPiA+IGlu
dGVycnVwdCBoYW5kbGluZy4gVGhpcyBuZWVkIHRvIGJlIGRlYnVnZ2VkIGFuZCBhZGRyZXNzZWQg
ZnJvbQ0KPiA+IExBTjc4eHgNCj4gPiBkcml2ZXIgcmF0aGVyIHRoYW4gcmVtb3ZpbmcgaW50ZXJy
dXB0IHN1cHBvcnQgaW4gTEFOODh4eC4NCj4gDQo+IEhpIFRoYW5nYXJhag0KPiANCj4gSXQgaXMg
YW4gZWFzaWx5IGF2YWlsYWJsZSBwbGF0Zm9ybS4gTWF5YmUgeW91IGNhbiBnZXQgb25lIGFuZCB0
cnkgdG8NCj4gZGVidWcgaXQ/DQo+IA0KPiBUaGlzIGlzIGEgc2VsZiBjb250YWluZWQgc2ltcGxl
IGZpeC4gRnJvbSBhIHByYWdtYXRpYyBzdGFuZHBvaW50LCBpdA0KPiBzb2x2ZXMgYW4gaXNzdWUg
d2hpY2ggaXMgYm90aGVyaW5nIHBlb3BsZS4gSWYgeW91IGRvIGZpbmQgYW5kIGZpeCBhbg0KPiBp
c3N1ZSBpbiB0aGUgTEFONzh4eCB0aGlzIGNoYW5nZSBjYW4gYmUgZWFzaWx5IHJldmVydGVkLiBT
byBpJ20NCj4gbGVhcm5pbmcgdG93YXJkcyBtZXJnaW5nIGl0Lg0KPiANCj4gICAgICAgICBBbmRy
ZXcNCg0KSGkgQW5kcmV3LA0KU3VyZSwgSSB3aWxsIGRlYnVnIHRoaXMgaXNzdWUgZnJvbSBteSBl
bmQuIEFncmVlIHdlIGNhbiBtZXJnZSB0aGlzIGZpeA0KZm9yIG5vdywgYW5kIHJldmVydCBvbmNl
IHRoaXMgaXMgZml4ZWQgaW4gTEFONzh4eC4NCg0KVGhhbmtzLA0KVGhhbmdhcmFqIFNhbXluYXRo
YW4NCg==

