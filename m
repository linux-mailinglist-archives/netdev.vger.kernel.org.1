Return-Path: <netdev+bounces-119974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AF7957BD0
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 05:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D96FA1F23629
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 03:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D343A1BA;
	Tue, 20 Aug 2024 03:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="OMKhzEnB"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC4F1C6A1;
	Tue, 20 Aug 2024 03:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724123455; cv=fail; b=r9+UIIxJKbDlu4bVR5bSCGgbuENkZegFBvAPHEreExvx4jMhyL7gR5V0m7IG5Cy3jIK/lwtnzmtDHpNqvyqZbGYedleJFZTIiqoeq46mr5J86F0pCeQzmbTATF1ygij9yE6DuLmz0v8oxS8RKSNv9y1B73/tf8RlPB/A8dc+PcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724123455; c=relaxed/simple;
	bh=37fdLWg5c9V7LiE8J40a1G1QBQ/2KJBk4sEvztFBQTg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OyyS1dI3HMgR5sVCl2/0RYu2vFNOWhaqv63oYOFxweZetgUqrzksrfICeJCPNOpEZn77iS3Mq0t3wPXJMpKnfAQp8vWZ5+K/n3cKksP2L+6to2aEjfc/SGW2F/aZRm6yRkbbIdo6edBr/DNOSdoemUnjC/qSYoedkSHuwiodIDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=OMKhzEnB; arc=fail smtp.client-ip=40.107.237.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Received: from MW3PR11MB4555.namprd11.prod.outlook.com (2603:10b6:303:2e::24)
 by SJ0PR11MB8272.namprd11.prod.outlook.com (2603:10b6:a03:47d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 21:17:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t1ZwjreM4BWzifhMk7A+kan2BeXN+UJv6McRbOR5yyOHFoQxtqrvFt5RxJCivs2d6AnYWYZM3rcAUSjxpD4wn41/1We+7iTxtb7NauMqA6IypwSozy1Cc/IFjPGhbF4UjXl7x1xbw8EvTNSsno7d2xQiO/n9+z6SYvWfNogPxXAHswgBlmi8basyobeKqYvoTpr2dz1WKu/Qes+cSvzmK1/f9cS5BRQmXZhmmMz/xE5nBUIOTr0cCEn/lRv95n2m8sis8CtTKAfjg3WAWgW5waqpR+tefuJO17x45lYa04UP5GXCfyoNMfh7qSdsHiyJhZSRylUMUnYJLh2y8aw1+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37fdLWg5c9V7LiE8J40a1G1QBQ/2KJBk4sEvztFBQTg=;
 b=wzAK4YSxEENivPuD5tbIk7p10M5eAi3abaO9/63InGd4mR/cR8Ph4IeLovmaeP+Q1hElIRnzcvzy5L9G5UhVDgVolYi8MWdr2XlneZtETyVYZmsFg0uaJLTx0ohMkc60nY+M9s6Y4kiXk8t9bWHiVsLSeaDrPS4a9zWKbgtaFPw2Oz/8doiwvXTyQGoOF7tUpUHgQnLZznU90MNI6R7U3DVHxDeRzck4dD3h3xQ+4NV2H1N1o9yz8Is1HKZSsaTNgu6g5ofOIsHvap7q7IGrmr4OuFOqo3kxnBnXsk9a8E6z6tALRAWoiwRx+ZxqptfqJGlrkwG6v7sYo7sf0UKSdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37fdLWg5c9V7LiE8J40a1G1QBQ/2KJBk4sEvztFBQTg=;
 b=OMKhzEnBE9fMQS7irYGjcLqs9bADVU/86U7zUgb9kVuEpM+Mj/Pyz24klXngUQzBZtNpWM1GswkxldGNhI1jQUJEApZHVtiM9PL2HeyF7SWcWBK0mSbyuO4ctBVmmyEqgZLabrinTkpt0AFtW/5Py4AHn3u7F+eG/51gwostR0YFf7FMM0x/bE1N4+n+uorSpiv5zkcb2YBTDyQb47WY3/sYlYkR15vtGTsFv6bob+QFA9y8eLe80Svhx+uIhXltRJQJauIT5EFGrJ0texsul6ecx2zSLOHTATCNONVjFLYZJrRUNSSPtEsYk9VIweHqNzBWLPY6uVQQRM8DC5109w==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by MW3PR11MB4555.namprd11.prod.outlook.com (2603:10b6:303:2e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 10:11:36 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%5]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 10:11:35 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<horms@kernel.org>, <saeedm@nvidia.com>, <anthony.l.nguyen@intel.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <andrew@lunn.ch>,
	<corbet@lwn.net>, <linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <Horatiu.Vultur@microchip.com>,
	<ruanjinjie@huawei.com>, <Steen.Hegelund@microchip.com>,
	<vladimir.oltean@nxp.com>, <masahiroy@kernel.org>, <alexanderduyck@fb.com>,
	<krzk+dt@kernel.org>, <robh@kernel.org>, <rdunlap@infradead.org>,
	<hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>,
	<Pier.Beruto@onsemi.com>, <Selvamani.Rajagopal@onsemi.com>,
	<Nicolas.Ferre@microchip.com>, <benjamin.bigler@bernformulastudent.ch>,
	<linux@bigler.io>, <markku.vorne@kempower.com>
Subject: Re: [PATCH net-next v6 09/14] net: ethernet: oa_tc6: implement
 transmit path to transfer tx ethernet frames
Thread-Topic: [PATCH net-next v6 09/14] net: ethernet: oa_tc6: implement
 transmit path to transfer tx ethernet frames
Thread-Index: AQHa7KJ4uhAXvYdhmUixK/W+8ctrr7IqIOGAgARGMYA=
Date: Mon, 19 Aug 2024 10:11:35 +0000
Message-ID: <b935d954-88ff-4c32-9798-792acb5b0ea9@microchip.com>
References: <20240812102611.489550-1-Parthiban.Veerasooran@microchip.com>
 <20240812102611.489550-10-Parthiban.Veerasooran@microchip.com>
 <20240816095519.57b470b8@kernel.org>
In-Reply-To: <20240816095519.57b470b8@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic:
 SA1PR11MB8278:EE_|MW3PR11MB4555:EE_|SJ0PR11MB8272:EE_
x-ms-office365-filtering-correlation-id: 306c010a-99ae-42d9-f7d7-08dcc0374ee6
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?amo2eUpYOEpLazY3MEpldW8rdzJBNzNpWVhEZE9wbjZ1akFWcFp1Vml5ZDI0?=
 =?utf-8?B?UTFCT2hzUmVzRHJFeVhoczRiYkpqR1pXZ0thWHpReVN2YUlzZ1R5K3Q5V3lJ?=
 =?utf-8?B?bjdXSjhvNElYT1RnTXhVZERjWThTUVpWMVJUK0R4U0FwZUdtM1hKWndYWTdB?=
 =?utf-8?B?UlhNNlpJclgydnd2N2lPdU81ZUV3MzFLeG5RbHhWMzFLUTJzZzh5bXVERWdo?=
 =?utf-8?B?elAvNXQwYUMrbk90bS9oSzZUdTVVdWNjN3B6Mk1rK2N0ajZZWXVHY2tBR1c3?=
 =?utf-8?B?aU9WOFFCWE1zSGFaTXVaRGFRSGZpVUZrbjFrSThiazFDbzQxRmF0L3NRbXhu?=
 =?utf-8?B?ZEE1SGNyZllUb3U2dUpnVzgxV1ZsR1dNSGcwclpjZXVMRmFUNVVZWTJodmsw?=
 =?utf-8?B?bXNPY0Q3SW5VMkpmeEpYd1hMY1JFdFNkTVJBL0tiWEhmQkZWMzBOa0hRTTIx?=
 =?utf-8?B?bHZrZURYR0ZxSVAyWm9HamlkcThNMmtDRE9iY1dmdjdWMlp3OHFDV0lPU0V4?=
 =?utf-8?B?N2tEWkpVUjIvbXE4ZjcvampVZjNFeHNjdzN0NkVaMjJhWUN3UzFUM3hCcHp3?=
 =?utf-8?B?d0p3VFp2MlVCUC9Ea25ES1BldlB4RzdHOGQwMVRnRUJ6V054TlR1WThlNjZ0?=
 =?utf-8?B?QkZJSnBaWVg0OVp5eFU3N0NZV21vdTU5eFNSNDd0QjYyQzNTZ2xCdmRVNmx1?=
 =?utf-8?B?S1ZrL0tteE5id29SR0tQYktmQVJUaFFFTzM1Zm91cjBDQUNvNmV5K2hkZnJx?=
 =?utf-8?B?YXFZQWt3T1pwM1Y0Z3pmVStYeXVJTVJUQlBzY0RNYm03UXdCOU9VRW1zU3pE?=
 =?utf-8?B?UWpuLy9vV0xXVmsrTzBKSE93ZndQVzFrOUM0NjdzeGUvcjVrK2MwQ1dBUjJ1?=
 =?utf-8?B?cGxDS1JrSUtubkZkVS91NllSc29Yc1lzRlBWR2FvRmFTUzN2aVI3SVNYemZv?=
 =?utf-8?B?TE9RZCtmcWV5V3dFTGVpWXpHbkpkSUpnUFBDTDRYbjA0amUwNER5Vjg4MUhE?=
 =?utf-8?B?N0xYMGlvZXMxK0hjSnJhQzIxcDJtVU9ZVWFIZGFiUVFpVyt4WVVCR0p0WVhm?=
 =?utf-8?B?QmFsVko4SkZseC9HWUgwUTZpeTZKdHUwbzcyd3M4ZGIrWUxLMjlTKzZlUkpH?=
 =?utf-8?B?UWptd2hmTlpsN1djdUI0NkdrWUtadzFPcnl4Vks1QnI1Z0VzUE9GSXFydEt1?=
 =?utf-8?B?Umc3MEZlMHBwWXVrTHdwVXBrRkI4T1RIMm52bmV2SlduZ0toVmFROHUxRjZG?=
 =?utf-8?B?SkJaM3BuanFINGJ4TDVWNXdmOTFVNDVEcG5tLzVxelhpeHUzUktTRUxuUW9y?=
 =?utf-8?B?Wm5SVWsyaEc1dlhia3JjZlp6QnB2Q2tJbHJOUHAwdllXMWcwVVZ3R3BjS1px?=
 =?utf-8?B?QzVLUlB0NFY1a2tQZjFWeE94RDMwWjNmR3BEandNMXluNkxhajJGSTVvcWFU?=
 =?utf-8?B?dkl5S0gzQnoxUHhrR1BVanRSV3pqZXE4R1FVUE5qSjAzT3IrdWRQUTZFWDZ6?=
 =?utf-8?B?RGZPMTNZUnVlSHRGdDhrT29zSjRldGdsMURTQTNIZmlRRWhVUnI2RklEMW9Q?=
 =?utf-8?B?bmVUY2FJWmxQOVdnV2J1a3VxRjFWVk12SjlncTNIMm1wT0xBN2RGR0Z0VFZw?=
 =?utf-8?B?TG45MUpSVUd3ZWhVbC9IT0ZYZG1mZ0UrbUJBdkNOL3VWaEtGV0dGSXpvUjZv?=
 =?utf-8?B?a0szTFdWN2tqMHJFZXAvU2srK1NNcjJVbnZZUzYwekt1L2htRGJUZlZ3SFpW?=
 =?utf-8?B?dnRjczBwMkZXSkJoMHdpWklvZGlDU2E4cHZ5THJvc1ZscnMrSFp0M1R6S0lL?=
 =?utf-8?B?STRWQUkvK3AwRm8vTmNNVVNNUGw5c2orTzBLUXUraUtFM0h4Smw5LysvOWw3?=
 =?utf-8?B?T2RyclUrbi91OXF0alBmVmd4VFFvYUVjdzhhb3R5M245Vnc9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OHkwcml3YlExRTMyMHI0NDZ2ZkxUL25MRXBWT2lUdFprRG9mYUU5SGdTeDVL?=
 =?utf-8?B?YWJubUtkaTJ1MjNHcHZ4QXR5MGxlb2wrOUp2NzFSQlJVSndQWWo3eThMNktG?=
 =?utf-8?B?Wkp0Q0ZMdUxsMWZTWW1lR1Y0QlEwV1NMcFBmZ29ESTd3RFJVaUpBdUZuUjVH?=
 =?utf-8?B?ME9sa20vRUZmUk9kd0loeGJRdWR4YnRGeHhnWEowZktrRFY0V3ZvdUlJdFV5?=
 =?utf-8?B?SHZ0c09MU29lb2FRZ3pnVFhDSmFGeHB5cTR3ZEFyTDFaRC9lak9IS25ZYTJu?=
 =?utf-8?B?MHIyR2x2aFo3ajFrWUx1UWtJdzJIc1lubWcvQ1AyUkxDcHF3VGRDM2JrbnMx?=
 =?utf-8?B?VFdRZzVZM0RkdENUbzNpYTZXdVBLNlJ5TzR4ajdGeHpjMi83aVNUdkRSTDFM?=
 =?utf-8?B?eDhKWThsK0dsWVlmYmFBamF6cWtQQWJWd0JTYzhNWHdoSXJUUzcwM1JBc21x?=
 =?utf-8?B?RVY3eDVzSUllRzVORXBGc0Y0bnExQ2M4N09wMkpWYWxEQW9aSTh1SWlOTnlB?=
 =?utf-8?B?TXBEbW9sa3ZJWG95ZmNBVzIxNkw3T293RVY2RDlBQ0Y4MEZodVRpTGVqNGJX?=
 =?utf-8?B?ODF3dWp6RXRsTElTNjVTZkdsQmZMQ3NucjM1WVJzMnJydjZ3ZklGRVAxdUh2?=
 =?utf-8?B?RmkrNGJCcUc2S1RNR0FIbkRUYmRVT3p6MjE0eU9Ua250WHZja25hdENDMmpm?=
 =?utf-8?B?eXRPNWxHRmhxNUhIUmhuVEFNOTBhYklhOGN4Qm9iYVZ3SUt2aWZQdUFxWmxk?=
 =?utf-8?B?L3JkRkpHa0krWXlNQXpWQStjVUhoVlBlS25ha1NOQTBlaFhNaEZlM0ZCd1hU?=
 =?utf-8?B?dmJJWnFrazRIeGdLcEhQN1htNmprTUkrN082YW5zOHNZVStaSS9Ieml0SWZp?=
 =?utf-8?B?aENIS2VZYnhlYWNkUDJ4MzExUm5wZmNpSlZweFN0VitNb2tidUhYbDlCTHNP?=
 =?utf-8?B?WkppMGg4cFBCN2YzZlJ5eERHMTZoak5mRUVaaGhsUHVISjdIM3FmOHRUSUlI?=
 =?utf-8?B?aG1XMmdNV3A0MUdrUEhaOGFSZ2hiYXFZMHlZOTVYR25RSElSQk11d0lMZlZh?=
 =?utf-8?B?azhLMXJKaDc5TlVzTmI0dXhnSDJnL3hJb1BXWmdxR2NQVkc5RHg5cVRXWFFn?=
 =?utf-8?B?OTN1SGZaWmdwd09mdTBCWlZtajhGNXU3WHgwMUJpb1IrWE5hczRwOXlva2dT?=
 =?utf-8?B?akRaY3RKQU9wT1hhMHpOYjk3Uk5rUW1lbzlKZS9COUdnSUZqdFFpVW91WnhR?=
 =?utf-8?B?WS9tWWpLaGR6L29RVVhUNjNMdTBUclhFcjF1dUpzWCtBQ2x3ek0xeUxjZ3NF?=
 =?utf-8?B?TEVDdEVGN2tDZ3ZDbUUzU0R2MFkwVml5Z2ZjNW1hVDlIWkIyRy8wVGJnOG9x?=
 =?utf-8?B?LzRGS3VBaVIyYmozWi9iS1pzMHAxUmlEbEFFNVN1bUMvcGs5dXgrL2Y5U09N?=
 =?utf-8?B?Y21JcGdtNVYwNVVQaThQUTJPZWN3ZURkWDBSamxyY3gxRDJReTk4eUZtTFc2?=
 =?utf-8?B?WFlNQm5NeElCTVRFTkoxVDdHaDNuYW5Mc3k0V1ViL0VQQThJUTVHNExzYURI?=
 =?utf-8?B?VGZJNHBIeXRNNzJSZkM4U1VmMWZMRXkrV0g0RHQwVVMzWmd5aWZrbnArZ0Nl?=
 =?utf-8?B?MGJPZVhwVEowRXE5a0x3TzI0WG1rYTNrbnB2amxMZFUzMWdYazVzMkp5TnM2?=
 =?utf-8?B?RW5HcVhSSVJPcUVMMUNwekJjTjVRNlVOY09odTNOaGExb0hYbUkyVkszZFVx?=
 =?utf-8?B?eDNMcUlvL0M4V016UG1xKzFqUlIyazFWWUJqbS8zTkxBOVJhVDlMNks3bXBU?=
 =?utf-8?B?cHZWemNPbHNjTXE0bWVRS3g4WjlORExLd1UwY2dXVE5Nc0NrL2lzY0hvN01V?=
 =?utf-8?B?T3pwcHJrbDlyYkE1bGl6VDdNc1JZU3h4cWVJWjRCZHIvb2dMRE1aU25wQ1NJ?=
 =?utf-8?B?WlFicUk2NE5EQk9QQkxxb1lzSkxsYWh3WkVtU0UrNEdCczNoUnpzR3BHZnJ5?=
 =?utf-8?B?bnJtRm5ybUFWczJtUVNRdUVlL2JQTVdmLzRWQmhjcTBOTlNWcnBMSkdFbllJ?=
 =?utf-8?B?RDAvMk5pa3FMeWFBNFRjc2k0M3ZjdGpZSkpXdE4rRFFyUVoxMjQ2bkFrdjhp?=
 =?utf-8?B?dDJ3K0Rpa204bEF4bHV3M2NwSzhRU2dBZ3hQM3I2cUVuNSttcXFFRlQ2R283?=
 =?utf-8?B?ZGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B017D9F6436AB947BBB3C7004DEF829D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 306c010a-99ae-42d9-f7d7-08dcc0374ee6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 10:11:35.9043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LbWq3Rf2ygoyW/rCPcKoF1A8+ApnH6gJwmnAf3wAm5ha6hZ+yb48WVPCzXj2gNKTyLTB0dyufKZoiyuioz1yg8rFeH/qeRYj+npWr2dzmtx0pivi9las0Un1d7CZ6Qkl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4555
X-OriginatorOrg: microchip.com

SGkgSmFrdWIsDQoNCk9uIDE2LzA4LzI0IDEwOjI1IHBtLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBNb24sIDEyIEF1
ZyAyMDI0IDE1OjU2OjA2ICswNTMwIFBhcnRoaWJhbiBWZWVyYXNvb3JhbiB3cm90ZToNCj4+ICsg
ICAgICAgICAgICAgaWYgKHNrYl9xdWV1ZV9sZW4oJnRjNi0+dHhfc2tiX3EpIDwgT0FfVEM2X1RY
X1NLQl9RVUVVRV9TSVpFICYmDQo+PiArICAgICAgICAgICAgICAgICBuZXRpZl9xdWV1ZV9zdG9w
cGVkKHRjNi0+bmV0ZGV2KSkNCj4+ICsgICAgICAgICAgICAgICAgICAgICBuZXRpZl93YWtlX3F1
ZXVlKHRjNi0+bmV0ZGV2KTsNCj4gDQo+IEZXSVcgSSdtIG5vdCBzdXJlIHlvdSBhY3R1YWxseSBu
ZWVkIGEgcXVldWUgaW4gdGhlIGRyaXZlci4NCj4gIkEgcXVldWUgb2YgMSIgbWF5IGJlIGVub3Vn
aCwgSUlVQyBjYWxsaW5nIG5ldGlmX3dha2VfcXVldWUoKQ0KQWggb2suIEFjdHVhbGx5ICJBIHF1
ZXVlIG9mIDEiIGlzIGVub3VnaCBidXQgZm9yIGhvbGRpbmcgb25lIHR4IHNrYiwgYSANCnF1ZXVl
IGlzIHRvbyBtdWNoLiBTbyBpZiBJIHVuZGVyc3RhbmQgY29ycmVjdGx5LCBJIGNhbiByZXBsYWNl
LA0KDQpzdHJ1Y3Qgc2tfYnVmZl9oZWFkIHR4X3NrYl9xIC0tLT4gc3RydWN0IHNrX2J1ZmYgKndh
aXRpbmdfdHhfc2tiDQoNCndoaWNoIGhvbGRzIG9uZSB0eCBza2Igd2FpdGluZyBhbmQNCg0Kc3Ry
dWN0IHNrX2J1ZmYgKnR4X3NrYiAtLS0+IHN0cnVjdCBza19idWZmICpvbmdvaW5nX3R4X3NrYg0K
DQp3aGljaCBob2xkcyBvbmUgb24gZ29pbmcgdHggc2tiLg0KDQpTbyB0aGF0IEkgY2FuIHJlbW92
ZSB0aGUgcXVldWUgaGFuZGxpbmcuIEkgZGlkIGEgcXVpY2sgdGVzdCBieSBkb2luZyB0aGUgDQph
Ym92ZSBjaGFuZ2VzIGFuZCBpdCB3b3JrcyBhcyBleHBlY3RlZC4gVGhhbmtzIGZvciB0aGUgaW5m
by4gSSB3aWxsIA0KdXBkYXRlIHRoaXMgaW4gdGhlIG5leHQgdmVyc2lvbi4NCg0KPiB3aWxsIGNh
dXNlIHNvbWV0aGluZyBsaWtlIGFuIGludGVycnVwdCB0byBmaXJlIGltbWVkaWF0ZWx5LA0KPiBh
bmQgc3RhcnRfeG1pdCBmb3IgdGhlIG5leHQgZnJhbWUgc2hvdWxkIGdldCBjYWxsZWQgYmVmb3Jl
DQo+IG5ldGlmX3dha2VfcXVldWUoKSByZXR1cm5zLiBJIGNvdWxkIGJlIHdyb25nIDopDQpJIHRo
aW5rLCBpdCBpcyBvayBhcyB0aGUgd2hpbGUgd2lsbCBiZSBleGVjdXRlZCBpbW1lZGlhdGVseSBv
bmNlIA0KcmV0dXJuaW5nIGZyb20gbmV0aWZfd2FrZV9xdWV1ZSgpIHdoaWNoIGlzIHRoZSBleHBl
Y3RlZCBiZWhhdmlvci4NCg0KQmVzdCByZWdhcmRzLA0KUGFydGhpYmFuIFYNCj4NCg==

