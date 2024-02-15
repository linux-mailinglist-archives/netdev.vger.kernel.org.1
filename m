Return-Path: <netdev+bounces-71975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0291855C9C
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 09:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CEAD1F2EE50
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 08:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2B112B8B;
	Thu, 15 Feb 2024 08:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="TB97zHE6"
X-Original-To: netdev@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2045.outbound.protection.outlook.com [40.107.13.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50317134AF
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 08:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707986326; cv=fail; b=BWoZVN5tlmfsMdrAzrcRoxuU0oZUXR4YAO3PVafvOaTLlt61yWbTQREiJKk0C4QvhRnl8LVStCtXEiPFBaUrD4ZxyHtzemvjiU6LAO+d0jVJIGzCKQscQaiVj5t+pYRrB+YxZx2cmNONCfA+4haxjokNjRlzknbedCBhB977Q3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707986326; c=relaxed/simple;
	bh=HB/zQOZ5TjurUkHnABWc2F2/3se+rlercbJMrzVgcqs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=keAyQO7P4qZNu7NKFj8fYxWrQgRH+M+rKnQC1yvi3paMzeQCmJzzSTCju/ppJE2ChpguMzxw7KvgQHwB8jescGbXAZo1Q3HrWrgnrlM5GcEovFF5Gzr/Ohv4hp+XpXxB+d0/dc5fbZlCPYHAJvOBl1Ehq0MqFbMldIIBB7XU1rg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com; spf=pass smtp.mailfrom=ericsson.com; dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b=TB97zHE6; arc=fail smtp.client-ip=40.107.13.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ericsson.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U6vX1r537cI0fi/j4n+/Hv1N1yi70p2gslLPi9JaddXaEL6H6iuri8LmfbxMd2pD1PduK64YDaI1UldGvGKApXvWjR7840EICZKU3KwHw8DMcMJxayuD8hfQdjGETax+T9s3Pph9MeEQjjtUcIvAxZAsz9M5Tk4JtSqdZC/bQb/mlBV5idu52Jo3tQXfhoQceyQoiEZ0hEhnU5iGO0mQ4fnMzy3tlXcu8IPsvoIsXAqVj2Wz2KfVipCjg2VLC6qx1IX1JHTdt/LKUoJUIGxOzDf2vhqzOPealSKyGIIchkjw1uFtq9H7d+/UPFmWQfdO8zAP+xOU3Ogg0QlKLMwt6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HB/zQOZ5TjurUkHnABWc2F2/3se+rlercbJMrzVgcqs=;
 b=heNV+p99uK8wWK1KFrDf/EWj5fJ7pex3dHxoASKIr3T2uT65NtzvDEmlhuGA+oBUwojrMkPYarfjatTMl/kwu0TtUKTDCGF2TuQ9DXnJHcloGzWSKpNO1FX9dzcUxDmgRFpb05vs6Z+duujR/woZUd0M+BHc2AlvdNJ48TcHeVzuRZK6lzk6GI+iF/osOdCGghHkA8saaV5lR9GfpuJSLg2fDqRVdzx1AES9iByZd/JiyjeAF0UCusz9KPQ4ha1uS/jEzQemGSJrM5aTVaeZlMLUJTjlWqZ80yuQTd1I3/KzR4RSOHSdhZzQfo5emuVqaoxqezedrVHDyDxJx3RtTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HB/zQOZ5TjurUkHnABWc2F2/3se+rlercbJMrzVgcqs=;
 b=TB97zHE6ZkxRSzNtzRV2wtODCpMkohaXgBx/QcQLB2G60RDV+H/4HpAsGWQRs1n+m4LM3uNH9mqIg+6oCpFF2Lf+lIF6+Pf4gDnKKLxTWRGSICMRkZMyIMdm37c1J+fJox2iULENiQ7MbSB20blSufZQuxk+nu0G01VZqcg1rzi/sBZtHhaPMpk8tyyBQOCcCbDBOrTkpB/tFzDTMFPaKB9m2X0NVx+Vk/pGUiYHMNUoibCMXfqTT7yuQjN9ovxQ2+CP/rSHYlgiaZw4OAr14dvvArVEEEALY94SPjwZcAgBeezGPKNE00/jnpA0gGZHkRz4oGqzo6IXeV/Zc1sCKw==
Received: from PAXPR07MB8676.eurprd07.prod.outlook.com (2603:10a6:102:243::17)
 by AM7PR07MB6913.eurprd07.prod.outlook.com (2603:10a6:20b:1c3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Thu, 15 Feb
 2024 08:38:41 +0000
Received: from PAXPR07MB8676.eurprd07.prod.outlook.com
 ([fe80::fe66:17df:590:aa35]) by PAXPR07MB8676.eurprd07.prod.outlook.com
 ([fe80::fe66:17df:590:aa35%7]) with mapi id 15.20.7292.026; Thu, 15 Feb 2024
 08:38:39 +0000
From: Ferenc Fejes <ferenc.fejes@ericsson.com>
To: "kurt@linutronix.de" <kurt@linutronix.de>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "vinicius.gomes@intel.com" <vinicius.gomes@intel.com>, "hawk@kernel.org"
	<hawk@kernel.org>
Subject: Re: igc: AF_PACKET and SO_TXTIME question
Thread-Topic: igc: AF_PACKET and SO_TXTIME question
Thread-Index: AQHaX+pf3CiJqKd3lk+AteGaOHOZ+g==
Date: Thu, 15 Feb 2024 08:38:39 +0000
Message-ID: <8b782e8de9e6ae9206a0aad6d7d0e2d3c91f3470.camel@ericsson.com>
References: <bc2f28999c815b4562f7ce1ba477e7a9dc3af87d.camel@inf.elte.hu>
	 <87y1bn3xq6.fsf@kurt.kurt.home>
In-Reply-To: <87y1bn3xq6.fsf@kurt.kurt.home>
Accept-Language: hu-HU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB8676:EE_|AM7PR07MB6913:EE_
x-ms-office365-filtering-correlation-id: 1d32f6b1-def4-44e7-e1e1-08dc2e01824f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Yeu0nj4olDNeTeY4ZeVHnVP0Lg+fZeBxnJ++ph1X5ZBIFAPvKA9hiEXmkjBwsqh8mGgRgSm/IgjzHzLSaikj1PIisWvYyRt5mPSNLBw5hvsdhLhpfEvCYzU9vjNHOmzZmREismnd7jt+Z7QtqNMeL0kpPb2NyWNleX6LFRa9+sn+jEAMWqL2fwxMy+v1TqbKnVAelUby0I+oawviC9gHrpQeCCNFvySVIMpddy0jLRblwpTV6j9dGQi9TSluHlmqINO6b0NV3BfL9N9puXt2S0dfJFH+8ndFGENWlyaVYjtJmhSQm8ebeV8z7Vcufdy30hdepvoQa8O4iQVyUYiy0HcxQQ65AEDFjff+l+wh+1f/k1vtemcy/3vqXRWUetC2TA24piTfxsC65gNqUVMEu1AwpE50IuH7hmdU7KYAIB/SJUJ5B2ldQbKvE4G85LVxvp8cywOtG7TqhV6LQ/JvIl7hSIq/FqRd7CdOBQRB06J28USjlP8CrTmvAeeutdSHGkG/pXW8QVUfyrGI0uGJqUJ/nVuYk66m+sac/87qbjlhVQ2lenAKHmf2ErutpccQsekHjBVRmNRPZHjRvnLcjHNWXSSupmG36eVheSmQZVNPockQGZztIBqV6a0Xe7/I
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB8676.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(366004)(136003)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(2906002)(5660300002)(8676002)(38070700009)(6486002)(6506007)(71200400001)(26005)(2616005)(36756003)(478600001)(82960400001)(38100700002)(122000001)(83380400001)(4326008)(86362001)(8936002)(6512007)(44832011)(66446008)(316002)(66556008)(66476007)(66946007)(64756008)(54906003)(76116006)(110136005)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bDFOeklHMGtKZWRPRzhiVTNPOHpHdlVSZXdDdytKLzJENmNVWm5BM0RiNGE1?=
 =?utf-8?B?cDBqQzNPc292N0x6NXZRbWdoVEUycHpNVk52R1dyQXgxWFVmcWRYZnp0b0hT?=
 =?utf-8?B?bGxORldqb2t5enBtdHpCODNvWHF1ZzRpN2hOTzJsalVJYmtKSHUwdmdUWjdR?=
 =?utf-8?B?MXVRRDZWb0FGeTQvSFQrN0w4RjVBMmNrMnZsNXR2a0Q3T0NWNm1RWDRsRTlU?=
 =?utf-8?B?RTdTdnVKTW1FNXlsUElwYkxYMFNqcCtSaE42NThKeG1EQSt2cjMrbWN1bmhL?=
 =?utf-8?B?QTdWQkl3dTlYVURrangxM0U1ZEgwQlJDTWdXMWFUcFRuS0gyOXg0ZGhwcVdy?=
 =?utf-8?B?UXc5ZUV2UkhwN1BBTHZGeVFoWnVKK1YzQ01VMXMxc0ExZ3BHRUp1VUw5bnZC?=
 =?utf-8?B?Q1FSdHhRTDJOYzEyaldmUXk3YXo2a3BwUFNqOG9LWVRzeGI5cXlWQXM3dTln?=
 =?utf-8?B?Y0FrKzl2ZjdHVkg3ZWJuNzA4NWFMdFA1VEtYdDc5ZkRkNVViZWJnSkIzQXNW?=
 =?utf-8?B?TmtVK2Vwc2VOYytHVVNvdEM2cjNaRnpBT3dXU3k4eGh2VXZXL2FJVExVRk9O?=
 =?utf-8?B?YkI0akh5R3UrKzc2aXRCNDZKWWVibEJaNjNWLzdSd05XYmlUcnMrbmczU3dL?=
 =?utf-8?B?OEVXR1VmSWNQelpPVDc5RDhDTGJUNGlSY09SZmJxdG5CeFRUYi82enRyQXVO?=
 =?utf-8?B?WGRtemxyUzhQQkhrNlVGdmF5Qk5GS0p3K2gybzlVdk9VMnovQ2xoNlM4Vnkr?=
 =?utf-8?B?bmthKzcxZFFrNkwwS2xVMG1GeXBtNnBRM0hGNUFYblVaa21DSzc0V0V4d0hx?=
 =?utf-8?B?RWlkV3RTUWVHNWQxRGRCRmdMSzlJUDlVdGVGU3c1dmVsclNzd0hHRjhhR2Vj?=
 =?utf-8?B?OTNyR0JLYVZyRGFJa0JrOVc1Rm1WL3h2aERTdGRUUU4rN2FHKzBKYW9IUVJP?=
 =?utf-8?B?a3Q1MXpSdTVaTEw2KzRBeDMzV095c1JGK1Nxb25qZ2NJeHFJdmN5Z25qNXE1?=
 =?utf-8?B?cXBjRkZBN0dYd09IRDhvMmVMQWJScW1iY3IxZDVQeGw2b0kzQlllUmF4cFVy?=
 =?utf-8?B?ejBnZTVpNEljVVlaWVIrdzAwZUdBRXQwdWFEMnhvMElYZzlSRnd5WEcrZ2tz?=
 =?utf-8?B?N2t6bUtvZmdEMVAremlvVHRGWnVYYmRLSjRnSE1CRDE5V0laVFJNK0JoVmkv?=
 =?utf-8?B?TEQ2V010Q2JxZmVMYnRPZmFQQXNrRTZwZ21sYUE1dFo3ZndOVjRQSFp2Vmcy?=
 =?utf-8?B?K1VqczB4ZTJpME9XZGRqdjJFRTRUTjdEZUNqRGlYQnJ3bm1DSFg1bTBOb3FD?=
 =?utf-8?B?WUFLQU9vZVcya0pFRURzb1NCOW02S0JJZk5zQURaQS96SWVXQkNaNFhxSG1p?=
 =?utf-8?B?MExkR3JMV0l5NWZKTURHTHoxMzQ1TGFVQ3pLbWpWK0l2TG5abEpTWVJjUEpI?=
 =?utf-8?B?VE5jbEFwWnErNTRnVkVQVzJRNnlxcmx2NFJGVEZqMStVUys3aDVKd0ZTeGxm?=
 =?utf-8?B?bkl2Ui9sM1JYRm1ibEYxdnlqWThKbTBKVVRDS2tZSko3bkpRQUZ4NzA4KzFu?=
 =?utf-8?B?R2wyRDBFbnFhRUVHSEl1VnhwbFFKQzF4aWJQdTdhbjBsQm9GcFA5NHhKVW96?=
 =?utf-8?B?ZzJXZjhFaHB4S3hIWGprV1FaUGZDNStCQ25lM1NSeWQ0TWw3ZkdsTllzSVcz?=
 =?utf-8?B?cTBUZXFGZ3gzMUhnMXd2bk8wME8wQ1BMSmY5ekJSYkdvdmJOR0UzU1ZRVVFx?=
 =?utf-8?B?RXFhMUROeFBIaWZJYVp1WFIvMFg2K3JTMWthcWE5cHltZUVZNnVyTGNLdzZY?=
 =?utf-8?B?RDFTeFRWdDhFMk1RSzBxNU9ManF1M3lwdDQ4MTRvRWpWWTllUkpzS3FvYTNX?=
 =?utf-8?B?UmtWa25tZTdBSDFheEVWaEpwZ3d6UTZEdVFReTFzVzV3RE5mNi93a3hTS3RD?=
 =?utf-8?B?QXlSMndXSnJYMzd2c1J5VXFWcFlua25rRnFtVllMWkUxZEJJbldKbkNQQXUy?=
 =?utf-8?B?THVNR3Z3eTJ2NTU1OEd0cHRXbkJmQ3lRdnpyQzZqVWY4b2IyZGNPSzdsaXgv?=
 =?utf-8?B?ZTR1YjU5S05VbEVmd1dUR0lVMjhIRHR0V3RUYlhJa2I1SVhqTFBGbHA3MzJn?=
 =?utf-8?B?VUJvV3NtYnNSUGh0WUZmczJnZVlXNXBqSk8xbkpGc28vYmpiNVVIQnlOMldV?=
 =?utf-8?B?aGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <22D8FDCCCDF802479D8D798BAF669F3D@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR07MB8676.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d32f6b1-def4-44e7-e1e1-08dc2e01824f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2024 08:38:39.5670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hlqcqdN46SEdm6RmVgcw295tYkdDzEiE3axTzlW93boNyX9vDsADr5YK4Cxj+4pJu8YJVhlS8yrBezxTpTpYDFt9Jc+MIb2DMww7V7XgFp8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6913

SGkgS3VydCwNCg0KT24gV2VkLCAyMDI0LTAyLTE0IGF0IDE1OjUxICswMTAwLCBLdXJ0IEthbnpl
bmJhY2ggd3JvdGU6DQo+IEhpIEZlcmVuYywNCj4gDQo+IE9uIFdlZCBGZWIgMTQgMjAyNCwgRmVy
ZW5jIEZlamVzIHdyb3RlOg0KPiA+IEhpLA0KPiA+IA0KPiA+IFdlIGFyZSBleHBlcmltZW50aW5n
IHdpdGggc2NoZWR1bGVkIHBhY2tldCB0cmFuc2ZlcnMgdXNpbmcgdGhlDQo+ID4gQUZfUEFDS0VU
IHNvY2tldC4gVGhlcmUgaXMgdGhlIEVURiBkaXNrLCB3aGljaCBpcyBncmVhdCBmb3IgbW9zdA0K
PiA+IGNhc2VzLg0KPiANCj4gRm9yIHdoYXQgdXNlIGNhc2VzIGRvZXMgaXQgbm90IHdvcms/IEFy
ZSB5b3UgcnVubmluZyBQUkVFTVBUX1JUPyBKdXN0DQo+IGFza2luZyBvdXQgb2YgY3VyaW9zaXR5
IDotKS4NCg0KRm9yIHNvbWUgZXhwZXJpbWVudCwgSSBuZWVkIGNvbnRyb2wgb3ZlciB3aGVuIHRo
ZSBwYWNrZXRzIGRyYWluZWQgZnJvbQ0KdGhlIEVURiBxdWV1ZSB0byB0aGUgTklDLiBSaWdodCBu
b3cgaWYgeW91IHNjaGVkdWxlIHNvbWUgcGFja2V0cyBsZXRzDQpzYXkgMC41IHNlYyBpbiB0aGUg
ZnV0dXJlLCB0aGV5IGFyZSBzaXR0aW5nIGluc2lkZSB0aGUgRVRGIHF1ZXVlIGZvciBhDQp3aGls
ZSwgdGhlbiB3aGVuIHRoZSB0eHRpbWUgaXMgbmVhciwgdGhleSBwdXNoZWQgdG8gdGhlIE5JQydz
IGJ1ZmZlci4gSQ0Kd2FudCB0byBza2lwIHRoZSBFVEYgcGFydCB0byBzZWUgaG93IHRoZSBOSUMg
YmVoYXZlIG9uIGl0cyBvd24uIEl0cyBhDQpibGFjayBib3ggcmlnaHQgbm93LCBidXQgd2Ugd2Fu
dCB0byBzZWUgc29tZSBlZGdlIGNhc2UgYmVoYXZpb3IsIHNpbmNlDQp3ZSB3aWxsIGhhdmUgbWl4
ZWQgaG9zdCBhbmQgQUZfUEFDS0VUL1hEUCB0cmFmZmljIGluIG91ciBleHBlcmltZW50LiANCg0K
PiANCj4gPiBXaGVuIHdlIGJ5cGFzc2VkIEVURiwgZXZlcnl0aGluZyBzZWVtZWQgb2sgcmVnYXJk
aW5nIHRoZSB0aW1pbmc6DQo+ID4gb3VyDQo+ID4gcGFja2V0IHJlY2VpdmVkIGFib3V0ICsvLTE1
bnMgb2Zmc2V0IGF0IHRoZSByZWNlaXZlciAobm93IGl0cyB0aGUNCj4gPiBzYW1lDQo+ID4gbWFj
aGluZSBqdXN0IHRvIG1ha2Ugc3VyZSB3aXRoIHRoZSB0aW1lc3luYykgY29tcGFyZWQgdG8gdGhl
DQo+ID4gdGltZXN0YW1wDQo+ID4gc2V0IHdpdGggU09fVFhUSU1FIENNU0cuDQo+ID4gDQo+ID4g
V2hhdCB3ZSB0cmllZCBub3cgaXMgdG8gYnlwYXNzIHRoZSBFVEYgcWRpc2MuIFdlIGVuYWJsZWQg
dGhlIEVURg0KPiA+IHFkaXNjDQo+ID4gd2l0aCBoYXJkd2FyZSBvZmZsb2FkIGFuZCBzZW50IHRo
ZSBleGFjdCBzYW1lIHBhY2tldHMsIGJ1dCB0aGlzDQo+ID4gdGltZQ0KPiA+IHdpdGggUEFDS0VU
X1FESVNDX0JBWVBBU1MgZW5hYmxlZCBvbiB0aGUgQUZfUEFDS0VUIHNvY2tldC4gVGhlDQo+ID4g
Y29kZXBhdGgNCj4gPiBsb29rcyBnb29kLCB0aGUgcWRpc2MgcGFydCBpcyBub3QgY2FsbGVkLCB0
aGUgcGFja2V0X3NuZCBjYWxscyB0aGUNCj4gPiBkZXZfZGlyZWN0X3htaXQgd2hpY2ggY2FsbHMg
dGhlIGlnY194bWl0X2ZyYW1lLiBIb3dldmVyLCBpbiB0aGlzDQo+ID4gY2FzZQ0KPiA+IHRoZSBw
YWNrZXQgd2FzIHNlbnQgbW9yZSBvciBsZXNzIGltbWVkaWF0ZWx5Lg0KPiANCj4gV2VsbCwgeWVh
aCB0aGUgY29kZSBwYXRoIGxvb2tzIGdvb2QgaW5kZWVkLiBwYWNrZXRfc25kKCkgY29waWVzIHRo
ZQ0KPiB0cmFuc21pdCB0aW1lIHdoaWNoIGlzIHByb3ZpZGVkIGJ5IHRoZSBDTVNHIGFuZCBjYWxs
cyBpbnRvDQo+IHBhY2tldF94bWl0KCksIGRldl9kaXJlY3RfeG1pdCgpLi4uDQo+IA0KPiA+IA0K
PiA+IEkgd29uZGVyIHdoeSB3ZSBkbyBub3Qgc2VlIHRoZSBkZWxheWVkIHNlbmRpbmcgaW4gdGhp
cyBjYXNlPyBXZQ0KPiA+IHRyaWVkDQo+ID4gd2l0aCBkaWZmZXJlbnQgb2Zmc2V0cyAoZS5nLiAw
LjEsIDAuMDEsIDAuMDAxIHNlYyBpbiB0aGUgZnV0dXJlKQ0KPiA+IGJ1dCB3ZQ0KPiA+IHJlY2Vp
dmVkIHRoZSBwYWNrZXQgYWZ0ZXIgMjAtMzB1c2VjIGV2ZXJ5IHRpbWUuIEkgY2FudCBzZWUgYW55
IGNvZGUNCj4gPiB0aGF0IHRvdWNoZXMgdGhlIHNrYiB0aW1lc3RhbXAgYWZ0ZXIgdGhlIHBhY2tl
dF9zbmQsIHNvIEkgc3VzcGVjdA0KPiA+IHRoYXQNCj4gPiB0aGUgaWdjX3htaXRfZnJhbWUgc2Vl
cyB0aGUgc2FtZSB0aW1lc3RhbXAgdGhhdCBpdCB3b3VsZCBzZWUgaW4gdGhlDQo+ID4gbm9uLWJh
eXBhc3MgY2FzZS4NCj4gDQo+IE1heWJlIGFkZCBzb21lIHRyYWNlX3ByaW50aygpcyB0byB0cmFj
ayB3aGF0IHRpbWVzdGFtcHMgYXJlIGFjdHVhbGx5DQo+IGNhbGN1bGF0ZWQgaW4gaWdjX3R4X2xh
dW5jaHRpbWUoKSBhbmQgaWYgaXQgbWFrZXMgc2Vuc2U/DQoNClRoYW5rcywgd2UgbG9va2VkIGlu
dG8gd2l0aCB0aGUgZm9sbG93aW5nIHNjcmlwdDoNCg0KYnBmdHJhY2UgLWUgJ2tmdW5jOmlnY194
bWl0X2ZyYW1le3ByaW50ZigiJWxkXG4iLCBhcmdzLT5za2ItPnRzdGFtcCk7fScNCg0KVGhlIHRp
bWVzdGFtcCBsb29rcyBjb3JyZWN0IGZvciBib3RoIGNhc2VzLiBXZSB3aWxsIGRvdWJsZSBjaGVj
ayB0aGF0LA0KYnV0IGFmdGVyIGEgcXVpY2sgdGVzdCB0aGUgdGltZXN0YW1wIGV4YWN0bHkgd2hh
dCB3ZSBzZXQgd2l0aCBTT19UWFRJTUUNCkNNU0cgYm90aCBxZGlzYyBhbmQgYnlwYXNzIGNhc2Vz
Lg0KDQo+IA0KPiBTZWNvbmQgcG9pbnQgdG8gbWFrZSBzdXJlIGlzIHRoYXQgdGhlIFR4IHF1ZXVl
IHlvdXIgcGFja2V0IGlzIGJlaW5nDQo+IHRyYW5zbWl0dGVkIHRvIGhhcyBMYXVuY2ggVGltZSBl
bmFibGVkLg0KDQpHb29kIHBvaW50ISBXZSBtaXNzZWQgdGhhdC4gSUlVQyB0aGUgVFggcXVldWUg
c2VsZWN0ZWQgYnkgdGhlIHNrYi0NCj5xdWV1ZV9tYXBwaW5nIGFmdGVyIHRoZSBpZ2NfeG1pdF9m
cmFtZSBwYXJ0LiBXZSBzZXQgdGhhdCBwYXJhbWV0ZXIgYnkNCnNrYmVkaXQgdGMgIGFjdGlvbiBi
dXQgdGhhdCBpcyBub3QgZXhlY3V0ZWQgaW4gdGhlIGJ5cGFzcyBjYXNlLiBGb3INCnRoYXQgcmVh
c29uLCB0aGUgc2tiLT5xdWV1ZV9tYXBwaW5nIG1vcmUgb3IgbGVzcyByYW5kb20uDQoNCkhvd2V2
ZXIsIGZvciBhIHF1aWNrIHRlc3QsIHdlIHNldCBFVEYgb2ZmbG9hZCBmb3IgYWxsIDQgVFggcXVl
dWVzLiBTbw0Kbm8gbWF0dGVyIHdoaWNoIHF1ZXVlIHRoZSBwYWNrZXQgZW5xdWV1ZWQgaXQgc2hv
dWxkIHJlc3BlY3QgdGhlDQpsYXVuY2h0aW1lLiBCdXQgd2UgZG9udCByZWFsbHkgc2VlIHRoaXMg
YmVoYXZpb3IuLi4gTmV2ZXJ0aGVsZXNzIGl0cyBhDQpnb29kIGNhdGNoLCBJIG1pc3NlZCB0aGlz
IGFzcGVjdCBjb21wbGV0ZWx5IGF0IHRoZSB0aW1lIG9mIG15IGZpcnN0DQplbWFpbC4NCg0KPiAN
Cj4gPiANCj4gPiBJIGhhcHBlbiB0byBoYXZlIHRoZSBpMjI1IHVzZXIgbWFudWFsLCBidXQgYWZ0
ZXIgc29tZSBncmVwIEkgY2Fubm90DQo+ID4gZmluZCBhbnkgZGVidWcgcmVnaXN0ZXJzIG9yIGNv
dW50ZXJzIHRvIG1vbml0b3IgdGhlIGJlaGF2aW9yIG9mIHRoZQ0KPiA+IHNjaGVkdWxlZCB0cmFu
c21pc3Npb24gKHNjaGVkdWxpbmcgZXJyb3JzIG9yIGJhZCB0aW1lc3RhbXBzLCBldGMuKS4NCj4g
PiBBcmUNCj4gPiB0aGVyZSBhbnk/DQo+IA0KPiBOb3QgdGhhdCBJJ20gYXdhcmUgb2YuDQo+IA0K
PiA+IA0KPiA+IEkgYW0gYWZyYWlkIHRoaXMgaXNzdWUgbWlnaHQgYWxzbyBiZSByZWxldmFudCBm
b3IgdGhlIEFGX1hEUCBjYXNlLA0KPiA+IHdoaWNoIGFsc28gaG9va3MgYWZ0ZXIgdGhlIHFkaXNj
IGxheWVyLCBzbyB0aGUgbGF1bmNodGltZSAob3INCj4gPiB3aGF0ZXZlcg0KPiA+IGl0IGlzIGNh
bGxlZCkgaXMgaGFuZGxlZCBkaXJlY3RseSBieSB0aGUgaWdjIGRyaXZlci4NCj4gDQo+IElzIHRo
YXQgYWxyZWFkeSBwb3NzaWJsZSB3aXRoIEFGX1hEUD8gVGhlcmUgd2VyZSBzb21lIHBhdGNoZXMg
b24NCj4geGRwLWhpbnRzLCBidXQgaSBkb24ndCB0aGluayBpdCBoYXMgYmVlbiBtZXJnZWQgeWV0
Lg0KDQpOb3QgeWV0LiBUaGVyZSB3YXMgYSBwYXRjaHNldCB3aXRoIHRoZSBpbmZyYSBhbmQgc3Rt
bWFjIGFzIGFuIHVzZXIsDQpyaWdodCBub3cgSSB0aGluayBpdHMgdW5kZXIgc29tZSByZXdvcmsg
aW5jbHVkaW5nIGlnYyBhcyBhbm90aGVyIHVzZXIuwqANCkhvd2V2ZXIgaW4gcHJpbmNpcGxlLCB0
aGUgY29kZXBhdGggbWlnaHQgYmUgc2ltaWxhciB0byBBRl9QQUNLRVQsIHRoZQ0Kb25seSBkaWZm
ZXJlbmNlIGlzIHRoZSBsdW5jaHRpbWUgbWV0YWRhdGEgYnVuZGxlZCB3aXRoIHRoZSB4ZHBfYnVm
ZiBhbmQNCm5vdCB3aXRoIHRoZSBza2IuDQoNCj4gDQo+IFRoYW5rcywNCj4gS3VydA0KDQpCZXN0
LA0KRmVyZW5jDQoNCg==

