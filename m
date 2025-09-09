Return-Path: <netdev+bounces-221078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 628ABB4A273
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 08:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1871B445738
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 06:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333CC303A13;
	Tue,  9 Sep 2025 06:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="3z0gqWqt"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7374D2E0B48;
	Tue,  9 Sep 2025 06:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757399941; cv=fail; b=YEsjNfCQlrV1prjPxW72JxKsqaB4YnTaB2eng+wg519yXsiy7KiWUtXGtZ6z4LWFUdRViRlhUUlI/k+dYTzR+l1qTOqgk7k/ZgjTHTwA1vCoPrDdW5vOrPCruG3cmtIIPqwh3LPwXYFkKlen6EvwTEWiU0Q1WGDwuviDBJKbHBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757399941; c=relaxed/simple;
	bh=oAaaG936d1mat4I1yLx2MrGygeo1Z/284nFBT9bxDOo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k569FYWYZ+7PPbCdrGKjbjNW3/yaoC1ji3+oZXsnuiK/6J/fZl1xlyz9HZDLddZMXETwIZWeD89kS0pY077CQeZQBTwnXrjJtARtH3Y0xD39O4ia9PuCX+YXOpLQAC2Td0s53UWJ+r3w81gOu8F9KjzJTFYsHzEVo1RiMivXPC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=3z0gqWqt; arc=fail smtp.client-ip=40.107.94.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qgyy1p/W+3KS2z87xL4V90Wpa8gsXT4HEbzvBmFfNqxrvHvwYS5jLMEr6p9D8azbXh/VNLZlm1MUiFrsRtn468ucMSATsjP7Xf044wA/ZaDC0XfZbzWDL9OTrGuu91x/XlVPhF544AIMzZIMQH4MCnvAgkUha6zYh5XOiZ8LuvghjCYgat1XNyGD8PUBM8kL8x/9w6Jea1X7af5aHbgulbhUAbAQnJLcprdS4NgtqI2HcCuVzBoxy9LlaQsaS9TZaALTCaZBl/pJXZRLO9jp9WwkK0QXcM+OHwsb1pUS+ut0XsLmYtxOUIZTlfVcinQo1F+oiJusV2Q7GYkHtnNM9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oAaaG936d1mat4I1yLx2MrGygeo1Z/284nFBT9bxDOo=;
 b=bs0GSX6jW9QJXcX5i3799Hg/Fc6y/4P24BCEVHELMaB5GaVl1tYfCLS89W74Kxr4Be5mxFIIZznmJeiwefIKYiEEAQ0lUkBBeZyWxvQKPTZb+xCZnPdkY7cAKg1aLBvephq4KveaNCL1VE5MlSyUJ+7YGaonXIqQsm4lL+EXMkn2ZCBIGIFUw+ApU9wswhb7bbHZ10DIDzBewMSKcWl7hIL20z+zzdStU5aCqcHigiJTjUWWIOd1Uw14km4x3z5q06hn8CIiJ7rTLXdj9V7TOOUgDFOZSz7s/Lw3mAnB4tNO2CJGOi0VimsvZT6pLGCCtkntl/IWeYXqt4RxbgvJ7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oAaaG936d1mat4I1yLx2MrGygeo1Z/284nFBT9bxDOo=;
 b=3z0gqWqtbxx3lVSPiTyWjOE5cPz0aWPv1Fq+cvFMRU+MbZBV8vM1Bc7neIWRy9lvMvJ1g8psQiw4mL0J5ga409TRh4/Jbjex1d7P2EToqvXQOWm5bfjIVj+pGipG6lM8kc9H85Nhk8e4+2gEgVE2cDZeYXakXP0DJvwDsGud5ioopl01XtT0/dspaIYpxGq0/dwVKJdTR3l+tCDrwEbhrs1wJD8u7D1F7GEYovOXQIKEwOKSLBMSsWcKUHEIM6jvZE1jMaqWWwXbOBR2H8psJkPHFJjx0ClmYtnzmuxy5UtW7OhWextxZ0sEDVooLBNDQoCFToApOrerMHARJZjtuQ==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by CY8PR11MB6987.namprd11.prod.outlook.com (2603:10b6:930:55::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 06:38:56 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%5]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 06:38:56 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <danishanwar@ti.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>, <corbet@lwn.net>,
	<nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <andrew+netdev@lunn.ch>,
	<mengyuanlou@net-swift.com>, <quic_luoj@quicinc.com>, <gongfan1@huawei.com>,
	<quic_leiwei@quicinc.com>, <mpe@ellerman.id.au>, <lee@trager.us>,
	<lorenzo@kernel.org>, <geert+renesas@glider.be>, <lukas.bulwahn@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH net-next v3 4/7] net: rpmsg-eth: Add netdev ops
Thread-Topic: [PATCH net-next v3 4/7] net: rpmsg-eth: Add netdev ops
Thread-Index: AQHcIKApBK9kCbFYTkCCOXsVz6s5OLSKZ5QA
Date: Tue, 9 Sep 2025 06:38:56 +0000
Message-ID: <4a69e4f1-06b1-49a1-aab6-baef6c613f0b@microchip.com>
References: <20250908090746.862407-1-danishanwar@ti.com>
 <20250908090746.862407-5-danishanwar@ti.com>
In-Reply-To: <20250908090746.862407-5-danishanwar@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|CY8PR11MB6987:EE_
x-ms-office365-filtering-correlation-id: b2258fdc-62da-45a2-cad9-08ddef6b8d33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?R3M1LzB6Y2FCVGNPRUJnb1VhTHM2d1B5UXZaR1drZW92VzZBRENTK0FqWFJN?=
 =?utf-8?B?UmVuUml5Ly9tME9GOVhFVk91NzVYaEsrVEZDdUhKMmtPa1NmOVlpeTFkaC9k?=
 =?utf-8?B?QUJGWVhLZlVlODJzOTY1TG81R2VhZkdtd203SHZUWU11aDFRVE9xZ0hibzE4?=
 =?utf-8?B?akpsSFVqTXowTkkxZHN0VkNnY0pGZElpNThKZGdBSjRJbktWZmdNUkY5UzRv?=
 =?utf-8?B?UWZMZ2IzdDZxT29KcmN4b2xjWldaL2dmOEQ5bm1XT2psWEcxeXFERGRSR3Q2?=
 =?utf-8?B?QVNLZ2R1akd4Yk9SNUhNeTFIdkEvNGM1T09LYjdsQzBPdUlNS1dMSjF4cGRo?=
 =?utf-8?B?K3ErSnEvMjlEQUZRY256MHpBbXBWRjBzNVNwQXIzblc5anM1QmxxT2svOGVp?=
 =?utf-8?B?cCtCaGhocXl0ZGFZNjYvcGhobXh1T2trWVpYK1pEMVpQV3VTbFcvcHNYNmo5?=
 =?utf-8?B?bWlmbWhjNTc0b3VUR1ZDZzBBRm41Vkh1a25NRWl3dUZTc3FTay9JaER6MFBX?=
 =?utf-8?B?dGNFVExJRU1pbzg3SDlncG1ORWNiemlLdmNVSEMrR0RPd0wzcmpxY29qU010?=
 =?utf-8?B?ZS80bi9SajVDejI5STNxVGQ2eEV6bXhkQjRWUmlBbGFRNUU2TjN1UERhS2dn?=
 =?utf-8?B?OGkxTUFjbEVnQkdmN0I5TGxxYmhFWGR5bUlLeXFmZTJLR3ZTS0lLWFJzSkpB?=
 =?utf-8?B?MTJrZDZzTGhIdUw4bm1PVFpEKzhicit4cGk1dlVxT1VlWkxoekhzUGdMVWVH?=
 =?utf-8?B?MlEyZTFYL2g2bkFTNFY4bVorSllZVW5RdThyMXViOUE0MkxIZnpGazJ2bjE3?=
 =?utf-8?B?em5VenJJMHRpSEY0eUFINGtOUENYMGc2ZDU0UzBEc1JZVUkxVWZ3NFE0R2w5?=
 =?utf-8?B?SHFyM1Z0dFM1aDA1L2hPQlV2aVJydWVNWUNrVC9Wc0VDMG4wNFdRd2MzYnh5?=
 =?utf-8?B?UUlNeDQ1cTA1VzhLUXU3K09JVU9vRVZLSERkM2dqWmdQK0J0Y1RvUkN2bTZ3?=
 =?utf-8?B?ZFd1R2tuZEJXaXZWWXZ2Y0xoa2FYNkx1b0NEaTZnN0lwS0NUdWE1M242Q212?=
 =?utf-8?B?L3dLQ2diNW40dTAzOVJ4RkRpeUNjREhpQVlzdHJjdk81OHhQVjFKWHdod1Vs?=
 =?utf-8?B?Uk1TNVdLeTk2ZFdvNUZrQWFra2g0L3g1OE9CYmlOY3V3UXZ2bGpxMVlJMXdt?=
 =?utf-8?B?RDFUdjNPSENPb2d2NlROYytyOVF4eGtQL3NqdkgyZkdOclJCMy94R3Znc21I?=
 =?utf-8?B?SENhNGdqZ21HU2ZpSWtHeFlaRExUYmU4UDAzdHVtbVBEOHRsdVhmbjV4MnZS?=
 =?utf-8?B?Nlhjd1RONit2QWVIKzhreTRCQ2loU2p3bGdaL0J1WGU5NFVJUThWcklnNHNX?=
 =?utf-8?B?VnUwWE1QMkRDQVhNWkxsZDdLdDFUVmdNRkdMN3ZmeFlVaFRIeWg0MnFNd3dI?=
 =?utf-8?B?b3RRS3ZtUGJLMWVCalc5bHRmOWN2Vk9iR0QyamM0WEg3clpSL3dIejVOVHh2?=
 =?utf-8?B?dFBqUWFjM240ektzdUFMK1RMS3djdENzaFVlMjhmNWJxUldSeHNJWDZ0VG96?=
 =?utf-8?B?bFBWam4yenBTdCsvaG5sQmltb1hMMEVDK3lBNjFVUENBN05pTExlYXFyQzNC?=
 =?utf-8?B?WWx6a3hTeXlhYStFdkJYaEtMSVlyQjJiUWxYRjF3eHlyZjNVRThjZEgvM0NE?=
 =?utf-8?B?Z21oOVE2MDNuK05HdEJRamlBQ0hONzlmcnJLaE5nMzFOU2JkYlJabnFlU21L?=
 =?utf-8?B?NVR3SE9GZDhYdENHbVpPY3BjbFlJbnVVbk52UFJCMHBLcFlOR0VmWVhuZU9a?=
 =?utf-8?B?ZlBGNzJVcmFONXE3YjZMM2xENGYyWEpoQ1BNdGNVaTkyOU1ndGNBOXJPTW9l?=
 =?utf-8?B?S0xIcTJRdWF4a00xWnBEWWNNVnkrdjdrNHlHcUZLQkxRdlBtejViQlMrREFl?=
 =?utf-8?B?WGFpdlhIcG1BTEFHc3VzeGFtVGJKYVBacFg1UDNxUlM0MzZJZ0NTcXk5OTRr?=
 =?utf-8?Q?vtUEFI9Zmi06bFxziIijq5AHYkddF4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K1VBOXc2TkkzVDUxQkpXdS9NbHNtb3FncExCQUJydEZEZmtHUFlqM2ZLUjJo?=
 =?utf-8?B?Yk1TM2tldTFlMUJZdVkvc0hpcGd0R0FXU1oxbTk5NlFIVEFqZVBGLzFBTFNU?=
 =?utf-8?B?d0xjNnN0NnowN21aaWZ0MERsZUZOZHBBcXJ0bXdESmJDUjVabnQ0WGRqZEhC?=
 =?utf-8?B?elJBR2pXZFY3YS9sTTdpUmZSOWRpdjlHRXF4eEFSK2NKRVVBMUx0WmoxY0s4?=
 =?utf-8?B?QXJSNmJyUm1rdGJURXV2SGpqdHIrLzZBU3JoNDYvM2NNZzh6dnZtT3BSbGtC?=
 =?utf-8?B?aExJUHZ6SEpWZWQzcUNjTkcrTi9ROVJ3QkpXNDJzeWhhWmxKaFhZcGNYb05X?=
 =?utf-8?B?QVEvcFNUc211NWhUREk2TW5Vd25vZ0F1SVRIdHdmWVJzTUVBYUsvVE1wZWNF?=
 =?utf-8?B?SHBnc0tueE9ab0JhVllVVXVFTm82TEE4c1BVbm9CNG50Sk1YMnBldjQ4NDdr?=
 =?utf-8?B?eEtHeFZyaXlaNjNKYkRhc3NLTDlwMVprUEhGS2xFYU9iSTdQQzRMcXNSNlZF?=
 =?utf-8?B?NnZwcmNIajJMeUZxZ1ZGVHN3aHFjaTVrY3J4aWFDYzZYZlk0cVowekNrcUVv?=
 =?utf-8?B?N2ZQODhlL2Zkc3BaUHZqL2tyNGFTdDEzelppaVNvdjZReDBaZFJjWS85RzdB?=
 =?utf-8?B?WGZGOU5JdEc3NjRxaWx6Y0NicmhuU2g2N2puV1ZOV2E3UGVTN01vaVBObXI3?=
 =?utf-8?B?QWZHeEttVDNjZjU5Sk04TWhEN0QxRitVSW1JTkRsWlVlU2tDRWM5QTFPWHM5?=
 =?utf-8?B?SmdhVldIeGUvTUdNdk1hK1l2VU5kSGdZSjY4ek4zSjRMTWczZkdZakoxOWlR?=
 =?utf-8?B?UlJyNU96S1FzaEZwOTNhMkk2dDhXSU81RkoxQW4yY2NKV3pKam1idXFjZWFn?=
 =?utf-8?B?NytiN0djcVhBNm95VkQ1T29YMHR1T3JTV1lDVUlhVmM3bEp3cFpvMjVseEFQ?=
 =?utf-8?B?T1RQTFpUbWtIbTlTTUhPSEZPd0VvS0hhaGVUb3F0L0VGWE9DRVdtOVRxK3pU?=
 =?utf-8?B?QmJuTkMxUkw1dHZXaWpObTlITXBCYzFVcVZBbHhvSEx2b1hWRjl0eHVCeitL?=
 =?utf-8?B?ZWhPeDZBSCttOHd3Wk9tUEV1OE05S0RhRHhlM1hEYW9yMmZsa3EyTVpLYU40?=
 =?utf-8?B?WG52Qk5uMUFneVJzZmVDQXJWMUlQcmpNaFI4dWJ3cStXSFlHSUtOVFJLUUhZ?=
 =?utf-8?B?UTMzbU04UHp5QUZ2bUVYNEs4ZUZ1cVdBUnRER2lBSFRCbVhjRVVySDFKRitp?=
 =?utf-8?B?eGlLcEFYemVGcHhMZHdGQnQyNmdqbG1yTkY5R1NFMitFSzNnbFlxMmMvaEkr?=
 =?utf-8?B?SURYMXJJQ0FCOUlGWjE3RmhGMFJlL3JtbEh6V1p2bUZZTkk3enVmL3pKY3ZC?=
 =?utf-8?B?VXIwTkJ3VW1DeGdtYytId1pQcTIyTUk3UXVHeVJQM2JZdnV5eWZkdTd2NVBk?=
 =?utf-8?B?VXV3Mi8rdmZwdHZCbk1xTmhmV2ZOR1Z0VEVpanYwNlBRcmdwRVpWaWw5ekxM?=
 =?utf-8?B?T0src21YT1hXSmYxRWpwM2l2bkNoYWlRc08rUnZOdWM5OGtvcThySTRFa0Q1?=
 =?utf-8?B?cHZEVWNnSDB4cDJDaUlGQzJvSi9GQThzNTRkMksvNlVLdnpCaWNHVEZ3Nlg2?=
 =?utf-8?B?aGhEMk5NZ2oyQ01XZTR6WDlUKzNlRS9SczJ6bEtqd1JBUy9JcDM2enVDZWxu?=
 =?utf-8?B?SW1wMisvUUlhUEVYQ04wYzI4K1RjWUVHaG11T0J2bkZYcGtNWThyVW9sKzNF?=
 =?utf-8?B?OERRTllHNHJHNDVWYmtzZy8weTdxM3FxSmhZb1RZT01wWVMwbGUydWJNUnhp?=
 =?utf-8?B?SnZNWExObmlzcTBSelVqUFZYYUNjQ2dSenhYejc0QjFTWTAzS2t1dDZtZGhU?=
 =?utf-8?B?cmRLTUozU0FDcnNPVFJ6V1V1cmhrWGdVZG5lc281Zk1WMWw1M1ZLbWFZNENF?=
 =?utf-8?B?dWJVSGpESnpPRkxTTXRkTnJCSzFzeXFZdDB6WG9pNk0xNXhya1h3dGNucXQ1?=
 =?utf-8?B?eEREUXFRQ09mVWxONEh1clU2ZmhNU1phWngweWdadVVheHJ2WXlpUnJzMVBH?=
 =?utf-8?B?UTRiOVdNcEtERTJVNTBLajNBYnA5T2RoMzZzKzF3UFpwWDdpcWJXUjBhQ0tG?=
 =?utf-8?B?S0M2clloQXRYTW0xNHF0NVdnSjdBSm9KQnRhM254QzBULy9kSTlpZkVZOTNl?=
 =?utf-8?B?OXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9295D91D90416C4A9B609A6DE2B336E3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2258fdc-62da-45a2-cad9-08ddef6b8d33
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2025 06:38:56.5793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dbJDZZjjUHuYuYQcFcNFDfoSAqW3v0EYpCk47xtprSXIf77ZxCQ6RdggZ9yTXVrYfCjDO0saUiRjKRJhSKTzMzhmOdDih1m58Tu1nuSUaS5lrvSiZA5WvIisUn2LQRdg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6987

SGksDQoNCk9uIDA4LzA5LzI1IDI6MzcgcG0sIE1EIERhbmlzaCBBbndhciB3cm90ZToNCg0KPiAr
c3RhdGljIGludCBjcmVhdGVfcmVxdWVzdChzdHJ1Y3QgcnBtc2dfZXRoX2NvbW1vbiAqY29tbW9u
LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgIGVudW0gcnBtc2dfZXRoX3JwbXNnX3R5cGUg
cnBtc2dfdHlwZSkNCj4gK3sNCj4gKyAgICAgICBzdHJ1Y3QgbWVzc2FnZSAqbXNnID0gJmNvbW1v
bi0+c2VuZF9tc2c7DQo+ICsgICAgICAgaW50IHJldCA9IDA7DQo+ICsNCj4gKyAgICAgICBtc2ct
Pm1zZ19oZHIuc3JjX2lkID0gY29tbW9uLT5wb3J0LT5wb3J0X2lkOw0KPiArICAgICAgIG1zZy0+
cmVxX21zZy50eXBlID0gcnBtc2dfdHlwZTsNCj4gKw0KPiArICAgICAgIHN3aXRjaCAocnBtc2df
dHlwZSkgew0KPiArICAgICAgIGNhc2UgUlBNU0dfRVRIX1JFUV9TSE1fSU5GTzoNCj4gKyAgICAg
ICAgICAgICAgIG1zZy0+bXNnX2hkci5tc2dfdHlwZSA9IFJQTVNHX0VUSF9SRVFVRVNUX01TRzsN
Cj4gKyAgICAgICAgICAgICAgIGJyZWFrOw0KPiArICAgICAgIGNhc2UgUlBNU0dfRVRIX1JFUV9T
RVRfTUFDX0FERFI6DQo+ICsgICAgICAgICAgICAgICBtc2ctPm1zZ19oZHIubXNnX3R5cGUgPSBS
UE1TR19FVEhfUkVRVUVTVF9NU0c7DQo+ICsgICAgICAgICAgICAgICBldGhlcl9hZGRyX2NvcHko
bXNnLT5yZXFfbXNnLm1hY19hZGRyLmFkZHIsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgY29tbW9uLT5wb3J0LT5uZGV2LT5kZXZfYWRkcik7DQo+ICsgICAgICAgICAgICAgICBi
cmVhazsNCj4gKyAgICAgICBjYXNlIFJQTVNHX0VUSF9OT1RJRllfUE9SVF9VUDoNCj4gKyAgICAg
ICBjYXNlIFJQTVNHX0VUSF9OT1RJRllfUE9SVF9ET1dOOg0KPiArICAgICAgICAgICAgICAgbXNn
LT5tc2dfaGRyLm1zZ190eXBlID0gUlBNU0dfRVRIX05PVElGWV9NU0c7DQo+ICsgICAgICAgICAg
ICAgICBicmVhazsNCj4gKyAgICAgICBkZWZhdWx0Og0KPiArICAgICAgICAgICAgICAgcmV0ID0g
LUVJTlZBTDsNCj4gKyAgICAgICAgICAgICAgIGRldl9lcnIoY29tbW9uLT5kZXYsICJJbnZhbGlk
IFJQTVNHIHJlcXVlc3RcbiIpOw0KSSBkb24ndCB0aGluayB5b3UgbmVlZCAncmV0JyBoZXJlIGlu
c3RlYWQgZGlyZWN0bHkgcmV0dXJuIC1FSU5WQUwgYW5kIA0KYWJvdmUgJ3JldCcgZGVjbGFyYXRp
b24gY2FuIGJlIHJlbW92ZWQuDQo+ICsgICAgICAgfQ0KPiArICAgICAgIHJldHVybiByZXQ7DQpj
YW4gYmUgcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBpbnQgcnBtc2dfZXRoX2NyZWF0
ZV9zZW5kX3JlcXVlc3Qoc3RydWN0IHJwbXNnX2V0aF9jb21tb24gKmNvbW1vbiwNCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlbnVtIHJwbXNnX2V0aF9ycG1zZ190
eXBlIHJwbXNnX3R5cGUsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgYm9vbCB3YWl0KQ0KPiArew0KPiArICAgICAgIHVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+ICsg
ICAgICAgaW50IHJldCA9IDA7DQpObyBuZWVkIHRvIGluaXRpYWxpemUuDQo+ICsNCj4gKyAgICAg
ICBpZiAod2FpdCkNCj4gKyAgICAgICAgICAgICAgIHJlaW5pdF9jb21wbGV0aW9uKCZjb21tb24t
PnN5bmNfbXNnKTsNCj4gKw0KPiArICAgICAgIHNwaW5fbG9ja19pcnFzYXZlKCZjb21tb24tPnNl
bmRfbXNnX2xvY2ssIGZsYWdzKTsNCj4gKw0KPiArc3RhdGljIGludCBycG1zZ19ldGhfc2V0X21h
Y19hZGRyZXNzKHN0cnVjdCBuZXRfZGV2aWNlICpuZGV2LCB2b2lkICphZGRyKQ0KPiArew0KPiAr
ICAgICAgIHN0cnVjdCBycG1zZ19ldGhfY29tbW9uICpjb21tb24gPSBycG1zZ19ldGhfbmRldl90
b19jb21tb24obmRldik7DQo+ICsgICAgICAgaW50IHJldDsNCj4gKw0KPiArICAgICAgIHJldCA9
IGV0aF9tYWNfYWRkcihuZGV2LCBhZGRyKTsNCj4gKw0KPiArICAgICAgIGlmIChyZXQgPCAwKQ0K
PiArICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gKyAgICAgICByZXQgPSBycG1zZ19ldGhf
Y3JlYXRlX3NlbmRfcmVxdWVzdChjb21tb24sIFJQTVNHX0VUSF9SRVFfU0VUX01BQ19BRERSLCBm
YWxzZSk7DQpZb3UgY2FuIGRpcmVjdGx5IHJldHVybiBmcm9tIGhlcmUuDQo+ICsgICAgICAgcmV0
dXJuIHJldDsNCj4gK30NCj4gKw0KQmVzdCByZWdhcmRzLA0KUGFydGhpYmFuIFYNCg==

