Return-Path: <netdev+bounces-132608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 235F499266E
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 09:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4993285C45
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 07:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE6318A95F;
	Mon,  7 Oct 2024 07:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="RjRLIYsF"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D570E184522;
	Mon,  7 Oct 2024 07:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728287501; cv=fail; b=Hbw/6gzOSP3t4Hfrpc71WnMTt6vCAEEJpnaSdBzIRtMmJKYKciujuLYO70BGWh8ZY+SKlgEQyvJNV47bBhbHiUWu2s2EsFZ8Omt0gbui6osGQ/lNJL1JgKiI/tO4h5bgjOmobEbeNo4QJsSb8YAmVLbJib4tZZffzbKDvEnk2SE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728287501; c=relaxed/simple;
	bh=Ng0B+IHyB/8UEW/iCURAFrXWPZefkMl+QGPQ6vUokS4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PoopcjTMCmCqY8m6KnjaDvWehNIvx92vJ/Nxkshp6dKstGR/IzEuJSBz4p/DH4i9SIdYNf2gFE2rNRHLvk5RkXStdkcXirF7rTJe2nJaoFXrbMYsQ7PSHgWkLiigolRJwjck0dYov59eN2P24XKJb9fCaWWaTDck2KS3/ToQo0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=RjRLIYsF; arc=fail smtp.client-ip=40.107.243.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p1xa5lX7Nb9NOb11a0wzzl+1a+lzcjhbVFuqfk5OGgHB5mN3N4dFllvibdVTAXjkpheHd5kSa7dQw61uTY1xnSiknvb1PI6msg9bzJPlL/CRxottcE5T7sWeeMzGgToFIY25PfKH7D6qz1lwT5Cz7yOw9R+anyII01Q26lD9MOMajfVb6dgecoZyJnLhHpvH+CUuGoCIYM+m9Ri8v9rsMIFNrpd21L93N+I8p+TgbPxTD8O97tfMM2wOr+6PzYmZymJF4hfwz6r7wMzbF6+YxD+1HWdlC9hxXolraJtqwLA0rCLyUeoDYcpMTWCxI/K5xgIyb4W2xm4TV7CTjId0tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ng0B+IHyB/8UEW/iCURAFrXWPZefkMl+QGPQ6vUokS4=;
 b=saGOx/X9DNZOFpLs3Jqf9iDrU1yalDU75/8zRyojT1swyTtkhzeMf9qlNL+dLGNDwg6R34yJeWwqwXhup0VOscqEdgyQguietXpIDqaqd3Q3rg2DmLdlFFhCshuZhWUqHZVtV8t9xUuUdsQcmv4vtVT6YGrQMQCqbrYEZ1HLRnOmYL4AoI1SJKe15jANBIO4gusjYGcjIemkvBXjqr+WVRlJousgjoKXwchp4+NwZOJxTztzpW3XQM1vRE4awIzovvT6JnbSZIqcw2Sl8Jht6mQfLQMFpG+SeoN25mXPyc9pffRGHLBwkB07IRf2PL7uxrJVQjkE3BTc9kcNNouYfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ng0B+IHyB/8UEW/iCURAFrXWPZefkMl+QGPQ6vUokS4=;
 b=RjRLIYsFbo2y4giR9gGE9MGuuZPbm1yaOjDEQb8xGGuuZgDp19neLJfPkUS7LlXMbDHnOe9HqYVoOFkOAelUgWufS6jOADwm0eGLXq+bcWzRz/8N7DglEQU/G6Ul0pf2uy0aTm44YfbOXHkYK25mnrXe3OwdMSgzDfTVTgK90Zq7iFwkoqc/JZJ9+uhdy+4kAsDc+O2Sc2glg1JpizGusITnSsbNwj+RJoEoXgalyL55BfdjkQBHWIw2CifJg3uk/XUXnFC6zEO0YrTnwQ2y7l1YVfbYScnnNx2+u+1uYJoeNHPSWkiOXwML+WM7dIxG/1mF9X6Xq71OKc5yo9wIWw==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by CO1PR11MB4788.namprd11.prod.outlook.com (2603:10b6:303:97::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 07:51:36 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%5]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 07:51:36 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <kuba@kernel.org>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<ramon.nordin.rodriguez@ferroamp.se>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
	<Thorsten.Kummermehr@microchip.com>
Subject: Re: [PATCH net-next v3 2/7] net: phy: microchip_t1s: update new
 initial settings for LAN865X Rev.B0
Thread-Topic: [PATCH net-next v3 2/7] net: phy: microchip_t1s: update new
 initial settings for LAN865X Rev.B0
Thread-Index: AQHbE/7chW5i04kMfUu/XdWzSyiXUrJ29HcAgAP/AwA=
Date: Mon, 7 Oct 2024 07:51:36 +0000
Message-ID: <2fb5dab7-f266-4304-a637-2b9eabb1184f@microchip.com>
References: <20241001123734.1667581-1-parthiban.veerasooran@microchip.com>
 <20241001123734.1667581-3-parthiban.veerasooran@microchip.com>
 <20241004115006.4876eed1@kernel.org>
In-Reply-To: <20241004115006.4876eed1@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|CO1PR11MB4788:EE_
x-ms-office365-filtering-correlation-id: ec21eb2f-e8fb-486f-52ab-08dce6a4deda
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZXlmdXFqVC9QWE9tZkszT2dYTFVBa2k3Vm92dk5mdG9PeHozYW5DOHlVbGdx?=
 =?utf-8?B?dFNhQVRqUVpXMC9BT3JQTnRILzRqTEJTWjlQUTYyVjBrd0h6aE03M2ZhNHkv?=
 =?utf-8?B?elZzQS92UUdRN0FqNStjVjJCaTAyZ1BhQTVxajlUU2N6SGhQUlhiOHVZOGI2?=
 =?utf-8?B?TlpIWE0xalV0VUhjT3Z6cDZRMmRDT082UFdpS0J0WGkweGVaV1NnY0tpUUtx?=
 =?utf-8?B?aldZYVlWNzRLamFwVGFPQzF4SDN2T2JBbFJQS3NFSlVQV21RdlRsY0hrS3ZI?=
 =?utf-8?B?WldIb1BPclZteEU2NmxXSjFnbWQ0ajduNTdYa2xHMk9tb3VSdytjTjU1ejNQ?=
 =?utf-8?B?MVNTVnNhYWw0QmxqQUZBbzFhYkdZZ0wwMjdhSzFtb2owbU9oc0FkS2poQmd2?=
 =?utf-8?B?S0xaNEV4aEppMUVrSnNQSS9PVnBsbjJiWGVRdEZuNk1HUHBYV2VOYUdXWTh5?=
 =?utf-8?B?d2VhRVBvVXI2Y2FYQWZEOUFQQzBVa05PTEx1cEpqVFRUTERncW9CNjFrNHBJ?=
 =?utf-8?B?eWdzNGNXdWxSaVpwRlgzMVQ0bVBtb1VXOU5SMWhCbXY1Y2tLVmJxU3RvTkRt?=
 =?utf-8?B?SzRkVy95RXhkZGVKYzJmakU3WnI3RDFTcXp0anExTWZmTlVLSmpiNnZscnN6?=
 =?utf-8?B?dVhXZHZZTDFha1l5a0s2bGdMSzJyUU9ReFM2blZuNGUzSHpvSjNGbWhvbGVu?=
 =?utf-8?B?RkE0cUlQTkJzbnNTcWhMK2o1SkV0Mjc2eldreS9DOUpPaFg4RVR3TC9MeGp1?=
 =?utf-8?B?RnJmNWhNTmcrZVVIblBsTS8rRjBRWGx1YURLMVk4Zmdrc1FaMmpJTThWTnFF?=
 =?utf-8?B?WnZmeEtXcytNU1psZk5YQmVRMUx5QUROdE94WnUvUmNVYTFSSjRnU05PTVg5?=
 =?utf-8?B?ZnB2TU5kSng0SlNPdW51blBqNTZCeTdFeG40Y3N5RGZGNjN6S2REZDFBckZ0?=
 =?utf-8?B?Tm1PL2lUcWZnTi9zbUtZYzBzbTRKVndTaThTYUgxbDN5cUsxbndBenp4RDZm?=
 =?utf-8?B?K3dwL3FDdkhvMUVmTW10cE5QZVd0U21VK1k4MFQ3a25yNW41THQ4dGZSbEx3?=
 =?utf-8?B?Slg3YVB2NGt5THFLODNJTXZtVEprek5pZ0N4TGcxZ0pKOVVOMThJOEUzK2ZD?=
 =?utf-8?B?Z0ZXaC9JYXovSGM3d2pnOVJ5YXAwVS9sVmc0L29jTXFWRzhnTHIzeDZNWGJh?=
 =?utf-8?B?NEE0c1pVQU9vaExyMG9oaFBIa2dxYlc5ME96dUorWkRmRzFCQW9uVkw3V1pu?=
 =?utf-8?B?YjNRY1JsRE4xSS9NMTRBWEF4Umx5a0E5aU9YSFUrL1NkNlJwa2xjWkdvbStu?=
 =?utf-8?B?ekxrN0JwTVp3czZMMDYvT2JjOXlUbHgxUTI0SVh5QUFwL3YrR1NaamU3NzNn?=
 =?utf-8?B?WFRsZFJscUs4VjFROXJlTlVuRjZHb2lJN1NIajZrWTlMdkZWbGNiSTNkWjhz?=
 =?utf-8?B?eDI1cCtXazgwZDFiOGZrRFdiUzZvVjBtaG9aODVNVXljdjgyYnhkM1JSV0x5?=
 =?utf-8?B?TVBRcHpGMXBETlhQTUUySjVNQjgwZW1pZWlDZHc2MkZRNm1leGFUS2tJYUpD?=
 =?utf-8?B?TXowLzFwSGI5SWdGazVHclhhRmtWMnFocGV4N25EMTRXNVFTTkdWWjMxVng4?=
 =?utf-8?B?Q1JPUG1xRGh4SlBITVh0WHk3STRwalFKdW90V043eFdSLzBYTTJSMEtueHRQ?=
 =?utf-8?B?VzIrM2t5YTZjWjB5TUdXVVpDY0ZHSlJ3bTM5MWRqdGhYK2FKZnNOdHUxaHlu?=
 =?utf-8?B?TnNlaVY4NGJvODFzMlFzellqTCsrTmlGclhtTHVLZ0pXYUZGazRMREtTU0Mr?=
 =?utf-8?B?V2NsQW16eUtPdys2MDROdz09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eDJ1bTVWWEZES25QWElUL3k0V1FqSDU3R1ZYZk80S3N2ZjgzZG9Db0Y1K2NG?=
 =?utf-8?B?WStPekxEZVg1NWtXeGl5cEN2VDNMYmVMQ3RUVmd3aGpHbXJIbXZKY2FJUkpu?=
 =?utf-8?B?R0ZzS1c4Z0xBRmQ2SGJUOTVUK092VzVTK3BBdTUwNzdXbi9rOG5iV2x1Z2lI?=
 =?utf-8?B?NytGTWVWMTNvVjRSYWtaUGMvWDV4Q2FXN2FOZ2VOWkhsV3p6M3FacmFLNUlj?=
 =?utf-8?B?dXJ0VGxFYWU0WkZYR2owNkJFWWQvQVV6ZFR2WnM2dlVCV2JkM0xBTjNIQ2Z4?=
 =?utf-8?B?WFRkWWNRdFFlTERHWXdwREZGY3c4cHdOeWRJM01BNWZRM2NDSld6cGNpeFRz?=
 =?utf-8?B?Z3JPOG90c08vRlBoejdCVjFhRnlNOHhqRFRGV3E1R3pIditxRFVyTDA3NXAy?=
 =?utf-8?B?L0NaYUo0Q1ZSOFhXbW9MaUNMT0Y5M0p3cndVNzFBZjQvSi9lRHM1bnlKaEVY?=
 =?utf-8?B?TjdkckR5T085UVlIV2I3Sk5Ea1pqZFUybkJuSjVJZlZ2QzhsaGg0V3VFcGdE?=
 =?utf-8?B?U2NISGdQVWFoWVQxOXByTWcvMmxTWmtNRDZpd1ZScnl2TWdMMEtIUFJBeGlk?=
 =?utf-8?B?VHYrQ2Jvd2FpZ3dmNWVpbkdvN3hSQWFhK0k0NXppbkg0eVRyK0JGZ3BERjcr?=
 =?utf-8?B?REw2NTBUSTN0R0JWNTlCM3BISkFpYm5VYWdJWnE1Rkp3ZFhiNW5xUEVFNmw0?=
 =?utf-8?B?K05TRGV1M1JXU0ExY2hxcHhFQURLT3d6Lzk5ZXR1M1IxaFZnK3JQTmhOZHBz?=
 =?utf-8?B?NTdQYU9aSE92cE5vVWpUWk9Zck1kS0NObk9HdlNqRW1UY1ljTWtWcnRQb3Uy?=
 =?utf-8?B?VE5uM2YvbnhwQ04rd1c3QUp3ditRMXF4UDlKUDVLT3c1K3Z2OHFtS2lFdnBR?=
 =?utf-8?B?UUlqVkNkTUdRT0ZLZSszOVowc2ZURlphOCtrd1crcXRCS3dQNmdRVThHaENM?=
 =?utf-8?B?V1AxQmh4R0hzU3VocFg2Z3JIV05BN0tRd1lYelRYV29CTHNmRi9lK2pwcVlV?=
 =?utf-8?B?MTVJanQxa0Irb2laTjZzNU9CbjFBbSttbFU2VUpCa053c2pob05NNkNLeUVr?=
 =?utf-8?B?cWRSZ29NSS83WDlncGx0L1BYWDk2MXhuclB5OGxnMWlMZ3I2di9rRWJCT3ND?=
 =?utf-8?B?djEyUXhXUmpqVFpvOEFlNFZQNk5ZTDcyUVdIdjBtZVluMXJzYjRjdVNpSVdm?=
 =?utf-8?B?NXlXUWovMGdodDdNSzJRdWorT2RFb1BNOE1ENVFRRDdkd1RPV0hmTndJWllJ?=
 =?utf-8?B?WUFteE9WNkx5QnFLS1pZVmZTai9GQVVPajB5QkRFUkpraG04Q094RGUxYVFB?=
 =?utf-8?B?T3RnQWtNQVVpenZHUzJ1UDJwU1ZLYWJmdldnU2R6SEVMeDBscGh1NFhNSWNn?=
 =?utf-8?B?dkZyQTRHNTNVL1MwS3ZEUmM2Q0JPdk85MEgwb3ZrV3NyNFlNK1FJeGlWV2pO?=
 =?utf-8?B?azkrWXpZQVJDcEpBT1lRYXVUc1NKaCtKNnMxeG95aTBCVXFtd0pzbjRlU2dX?=
 =?utf-8?B?R3pCeEE2eGxtY1NyTGhabnU2anFoMEV5SnY3NWI2RUNFQzRIQU9Jakc1eGlO?=
 =?utf-8?B?dlRpSW53OTNUbUE5WVhhSTB3cFBVTmVxU21LZ2hlVlM2ay9pdnpWZkJCUGxE?=
 =?utf-8?B?TGl4R0hxN3k5VGVXSHpVYVc2QXFlZCt3alRZZExqNTNsWkxLNUJ6UkhQSWt1?=
 =?utf-8?B?Nmd6N2RxUjlsNVQydk94aWlwRU96QTd3TXFvaXRpZ2E2RTZCeXJCUFFTdEVS?=
 =?utf-8?B?NGVpaDBpa0dqajdQMUNXMnhQU3JNNUhIWjNDRFdiMGUvRkUveXhsdFB6Y0FE?=
 =?utf-8?B?WUF4TnN4VmRRaTdlc2tUSXhUaVFMYjNyeXhILytWZ1hKQmVSZnprN3NPY2RD?=
 =?utf-8?B?QTZxa3czUzZjLzJid2d0d1o3Skc4K0RwallqdkVROERhZWlwL2pDd1FrVHhL?=
 =?utf-8?B?ZHFGOStGd1RzUCtHYzRSOTVvZktaa25pbUJhT3lDYjF4QVlMUDFkekxuL0x4?=
 =?utf-8?B?ZXZ5bm5ha2xSbDJRcFhwbkU2N0RsMk9IRUQ0WDdnV2lLdzA0YnBPSGF5Wkh3?=
 =?utf-8?B?dWIxdFBGbHdEdkZ6cy9TdFh4NGV3K2w4ZTZseVdNSnBXNmpsYmJFM25MQ3k4?=
 =?utf-8?B?Y1RGaVVZODJ3aUtMRHFQUHh1aURFTmI2NXdWN2xvUUthMGVOUWZxdXZhaXRE?=
 =?utf-8?B?ZGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A1F1FB909A517C47BFA936E5515E39BF@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ec21eb2f-e8fb-486f-52ab-08dce6a4deda
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2024 07:51:36.7284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jH3i8e4Ykdw9VHJX1zVCiCmwXqKTYPlZmlAlRZCPm2WHz44w0sltaFU6+cNjr2PlDJCHetdq51azfC4mOel7aAWL6BCXMpJJAyIG2SZ9c5DVqvGqqld7YUv3820VXCSH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4788

SGkgSmFrdWIsDQoNClRoYW5rcyBmb3IgeW91ciByZXZpZXcgY29tbWVudHMuDQoNCk9uIDA1LzEw
LzI0IDEyOjIwIGFtLCBKYWt1YiBLaWNpbnNraSB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERv
IG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUg
Y29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBUdWUsIDEgT2N0IDIwMjQgMTg6MDc6MjkgKzA1MzAg
UGFydGhpYmFuIFZlZXJhc29vcmFuIHdyb3RlOg0KPj4gKyAgICAgY2ZnX3Jlc3VsdHNbMF0gPSBG
SUVMRF9QUkVQKEdFTk1BU0soMTUsIDEwKSwgKDkgKyBvZmZzZXRzWzBdKSAmIDB4M0YpIHwNCj4+
ICsgICAgICAgICAgICAgICAgICAgICAgRklFTERfUFJFUChHRU5NQVNLKDE1LCA0KSwgKDE0ICsg
b2Zmc2V0c1swXSkgJiAweDNGKSB8DQo+PiArICAgICAgICAgICAgICAgICAgICAgIDB4MDM7DQo+
PiArICAgICBjZmdfcmVzdWx0c1sxXSA9IEZJRUxEX1BSRVAoR0VOTUFTSygxNSwgMTApLCAoNDAg
KyBvZmZzZXRzWzFdKSAmIDB4M0YpOw0KPiANCj4gSXQncyByZWFsbHkgc3RyYW5nZSB0byBPUiB0
b2dldGhlciBGSUVMRF9QUkVQKClzIHdpdGggb3ZlcmxhcHBpbmcNCj4gZmllbGRzLiBXaGF0J3Mg
Z29pbmcgb24gaGVyZT8gMTU6MTAgYW5kIDE1OjQgcmFuZ2VzIG92ZXJsYXAsIHRoZW4NCj4gdGhl
cmUgaXMgMHgzIGhhcmRjb2RlZCwgd2l0aCBubyBmaWVsZHMgc2l6ZSBkZWZpbml0aW9uLg0KVGhp
cyBjYWxjdWxhdGlvbiBoYXMgYmVlbiBpbXBsZW1lbnRlZCBiYXNlZCBvbiB0aGUgbG9naWMgcHJv
dmlkZWQgaW4gdGhlIA0KY29uZmlndXJhdGlvbiBhcHBsaWNhdGlvbiBub3RlIChBTjE3NjApIHJl
bGVhc2VkIHdpdGggdGhlIHByb2R1Y3QuIA0KUGxlYXNlIHJlZmVyIHRoZSBsaW5rIFsxXSBiZWxv
dyBmb3IgbW9yZSBpbmZvLg0KDQpBcyBtZW50aW9uZWQgaW4gdGhlIEFOMTc2MCBkb2N1bWVudCwg
Iml0IHByb3ZpZGVzIGd1aWRhbmNlIG9uIGhvdyB0byANCmNvbmZpZ3VyZSB0aGUgTEFOODY1MC8x
IGludGVybmFsIFBIWSBmb3Igb3B0aW1hbCBwZXJmb3JtYW5jZSBpbiANCjEwQkFTRS1UMVMgbmV0
d29ya3MuIiBVbmZvcnR1bmF0ZWx5IHdlIGRvbid0IGhhdmUgYW55IG90aGVyIGluZm9ybWF0aW9u
IA0Kb24gdGhvc2UgZWFjaCBhbmQgZXZlcnkgcGFyYW1ldGVycyBhbmQgY29uc3RhbnRzIHVzZWQg
Zm9yIHRoZSANCmNhbGN1bGF0aW9uLiBUaGV5IGFyZSBhbGwgZGVyaXZlZCBieSBkZXNpZ24gdGVh
bSB0byBicmluZyB1cCB0aGUgZGV2aWNlIA0KdG8gdGhlIG5vbWluYWwgc3RhdGUuDQoNCkl0IGlz
IGFsc28gbWVudGlvbmVkIGFzLCAiVGhlIGZvbGxvd2luZyBwYXJhbWV0ZXJzIG11c3QgYmUgY2Fs
Y3VsYXRlZCANCmZyb20gdGhlIGRldmljZSBjb25maWd1cmF0aW9uIHBhcmFtZXRlcnMgbWVudGlv
bmVkIGFib3ZlIHRvIHVzZSBmb3IgdGhlDQpjb25maWd1cmF0aW9uIG9mIHRoZSByZWdpc3RlcnMu
Ig0KDQp1aW50MTYgY2ZncGFyYW0xID0gKHVpbnQxNikgKCgoOSArIG9mZnNldDEpICYgMHgzRikg
PDwgMTApIHwgKHVpbnQxNikgDQooKCgxNCArIG9mZnNldDEpICYgMHgzRikgPDwgNCkgfCAweDAz
DQp1aW50MTYgY2ZncGFyYW0yID0gKHVpbnQxNikgKCgoNDAgKyBvZmZzZXQyKSAmIDB4M0YpIDw8
IDEwKQ0KDQpUaGlzIGlzIHRoZSByZWFzb24gd2h5IHRoZSBhYm92ZSBsb2dpYyBoYXMgYmVlbiBp
bXBsZW1lbnRlZC4NCg0KPiBDb3VsZCB5b3UgY2xhcmlmeSBhbmQgcHJlZmVyYWJseSBuYW1lIGFz
IG1hbnkgb2YgdGhlIGNvbnN0YW50cw0KPiBhcyBwb3NzaWJsZT8NCkkgd291bGQgbGlrZSB0byBk
byB0aGF0IGJ1dCBhcyBJIG1lbnRpb25lZCBhYm92ZSB0aGVyZSBpcyBubyBpbmZvIG9uIA0KdGhv
c2UgY29uc3RhbnRzIGluIHRoZSBhcHBsaWNhdGlvbiBub3RlLg0KPiANCj4gQWxzbyB3aHkgYXJl
IHlvdSBtYXNraW5nIHRoZSByZXN1bHQgb2YgdGhlIHN1bSB3aXRoIDB4M2Y/DQo+IENhbiB0aGUg
cmVzdWx0IG5vdCBmaXQ/IElzIHRoYXQgc2FmZSBvciBzaG91bGQgd2UgZXJyb3Igb3V0Pw0KSG9w
ZSB0aGUgYWJvdmUgaW5mbyBjbGFyaWZpZXMgdGhpcyBhcyB3ZWxsLg0KPiANCj4+ICsgICAgICAg
ICAgICAgcmV0ICY9IEdFTk1BU0soNCwgMCk7DQo+ID8gICAgICAgICAgICAgICBpZiAocmV0ICYg
QklUKDQpKQ0KPiANCj4gR0VOTUFTSygpIGlzIG5pY2UgYnV0IG5hbWluZyB0aGUgZmllbGRzIHdv
dWxkIGJlIGV2ZW4gbmljZXIuLg0KPiBXaGF0J3MgMzowLCB3aGF0J3MgNDo0ID8NCkFzIHBlciB0
aGUgaW5mb3JtYXRpb24gcHJvdmlkZWQgaW4gdGhlIGFwcGxpY2F0aW9uIG5vdGUsIHRoZSBvZmZz
ZXQgDQp2YWx1ZSBleHBlY3RlZCByYW5nZSBpcyBmcm9tIC01IHRvIDE1LiBPZmZzZXRzIGFyZSBz
dG9yZWQgYXMgc2lnbmVkIA0KNS1iaXQgdmFsdWVzIGluIHRoZSBhZGRyZXNzZXMgMHgwNCBhbmQg
MHgwOC4gU28gMHgxRiBpcyB1c2VkIHRvIG1hc2sgdGhlIA0KNS1iaXQgdmFsdWUgYW5kIGlmIHRo
ZSA0dGggYml0IGlzIHNldCB0aGVuIHRoZSB2YWx1ZSBmcm9tIDI3IHRvIDMxIHdpbGwgDQpiZSBj
b25zaWRlcmVkIGFzIC12ZSB2YWx1ZSBmcm9tIC01IHRvIC0xLg0KDQpJIHRoaW5rIGFkZGluZyB0
aGUgYWJvdmUgY29tbWVudCBpbiB0aGUgYWJvdmUgY29kZSBzbmlwcGV0IHdpbGwgY2xhcmlmeSAN
CnRoZSBuZWVkLiBXaGF0IGRvIHlvdSB0aGluaz8NCg0KTGluazoNClsxXTogDQpodHRwczovL3d3
MS5taWNyb2NoaXAuY29tL2Rvd25sb2Fkcy9hZW1Eb2N1bWVudHMvZG9jdW1lbnRzL0FJUy9BcHBs
aWNhdGlvbk5vdGVzL0FwcGxpY2F0aW9uTm90ZXMvTEFOODY1MC0xLUNvbmZpZ3VyYXRpb24tQXBw
bm90ZS02MDAwMTc2MC5wZGYNCg0KQmVzdCByZWdhcmRzLA0KUGFydGhpYmFuIFYNCj4gLS0NCj4g
cHctYm90OiBjcg0KDQo=

