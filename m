Return-Path: <netdev+bounces-82725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6907988F704
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 06:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C491A2933D9
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 05:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3789A3FBA9;
	Thu, 28 Mar 2024 05:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IipO+fiD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4751F2E62C
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 05:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711602786; cv=fail; b=XB4xqtEDKyg1cHJ2sFWF3D6fZhIfuf5vu56Q1uoVzUjPiDynu7n3G1MWe5oxWBgEHBkCy0bXUXJCUzDV9ubUEYoGVm+PTZmbym34dnKv9efGqEoi8FHU9aJ6dBtPPKlbFlIzaW8oRqkMQWGCZi9LoDVIQ8JYtL2OaxEcXoFzfmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711602786; c=relaxed/simple;
	bh=AaJ7lNmSS4TzJO6yJ7Bevav6zo7xrLH7Fbj82A0oLkA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O02BfFoktcG2VK0gBAlcBzNQuecbrTj+XmVX+LPmRgthehalCeYEsBJeS/tmOannrmoMXWX0vgmAttIh1J1hp1/4qYaSGeVHOaPD/ofLJ3oQokc2X+Iuj9svItcNzkc/rLLbR9hwBKKAG7MJ0KLLkmeHUxPez+ur2FB+eefE1Ro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IipO+fiD; arc=fail smtp.client-ip=40.107.220.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LM45AFdCzvKgETZqEL7DQs6MK3DSYXeY3Zin78Ezg93Dvk0mIE+LfBaJ8s8woRjw/yanxMB/Kopftb+6s8nAo0mtjC/V/fbDYktUmP9k2Lr6WJfOz2NhlxYE5PLp6jSOVsm09f6hwGhQvSf14LRQJHI5O1JrTBLaSbC7tzI6R6nGYAntdqNwA4gYAkEzVoKelFHuG9NI5mlgTlkFurXkBjFkY+jBMQlqxmgZnTLKJM/wX4AD68UlKN7ZtmqzI0c0/q5YRAybT51aBFKb4YdhrDPaz8dzfcR6b+jkRej6WHOscoG+XCJXchQPE+q4IqdMPxXOVZSCdg8AZISNdKe4LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AaJ7lNmSS4TzJO6yJ7Bevav6zo7xrLH7Fbj82A0oLkA=;
 b=b00Z16rBKhRyh8YXrcqrMASX1xbacaymN6rXrMSyX3DYdkXLgWbrG1odv2mlsGs5bo0VaS9ZuBfBZ8iRvPBSGoMXmfNlAtmBuNpt8LzQ1koOCHebZGUn1G+rW4RyLvque5sh6ps45tWS4eW45lQ14sdWqbfHOAUAbWTs4isCdm3jqUZas0uCf6RLyr+6YS1AyjbVHRydl40GqZxapKpQWps6nAq8z/TJWzGm/1HiA9/g9vO00o05gSuW7S6S1twnuPwV4+FwlnYPxQLxGZ3AsTS13RXRlcRbfn5/lUCOMP1rbqkOZ85hI/gnZLDhVazuRrla2ePe2/aWKCM6Lwf8xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AaJ7lNmSS4TzJO6yJ7Bevav6zo7xrLH7Fbj82A0oLkA=;
 b=IipO+fiD1Mj/1+yx1ycJfgGCb5LST0BFgjrbBbialY74wcZI/W7pyVnhJ8VCQ5qa1zjf9bnPeGa39oQPXgw/1zNNtxn7R/tH/nZ8WPyTgmE6CBn1b5UdmxeZtAoj6xpbk74bdqCoIPCZoeGVSB5Epz7v78wjkIDNTv2WMX5sHjUbteG8sDpaqm0LQlitLQc2ZMoOQjfEtxNckf1pa/hq58kynvyMQytGit0ls3kLK1ljkaCBd3Jgv7BMPiy2LGxPDBAvMSuhMUxnpNSzowC5HuLDgbCQ3ffgYpA4Ie1BXcTnRe5hZqOglveyeQd61/v5vqOX1ZQBnSNztkBSRoJQIQ==
Received: from CH0PR12MB8580.namprd12.prod.outlook.com (2603:10b6:610:192::6)
 by DM4PR12MB6304.namprd12.prod.outlook.com (2603:10b6:8:a2::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.33; Thu, 28 Mar 2024 05:12:59 +0000
Received: from CH0PR12MB8580.namprd12.prod.outlook.com
 ([fe80::1393:fbb3:2410:ca37]) by CH0PR12MB8580.namprd12.prod.outlook.com
 ([fe80::1393:fbb3:2410:ca37%5]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 05:12:52 +0000
From: Dan Jurgens <danielj@nvidia.com>
To: Heng Qi <hengqi@linux.alibaba.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	Jiri Pirko <jiri@nvidia.com>
Subject: RE: [PATCH net-next v2 4/6] virtio_net: Do DIM update for specified
 queue only
Thread-Topic: [PATCH net-next v2 4/6] virtio_net: Do DIM update for specified
 queue only
Thread-Index: AQHagMsSWzEyEBWJGUW6eMgs79kbsLFMlzyAgAADSEA=
Date: Thu, 28 Mar 2024 05:12:52 +0000
Message-ID:
 <CH0PR12MB858032B26D31740701D8FDD4C93B2@CH0PR12MB8580.namprd12.prod.outlook.com>
References: <20240328044715.266641-1-danielj@nvidia.com>
 <20240328044715.266641-5-danielj@nvidia.com>
 <c8afda58-95ce-4d85-aa4a-5f4ed7c6ce9f@linux.alibaba.com>
In-Reply-To: <c8afda58-95ce-4d85-aa4a-5f4ed7c6ce9f@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB8580:EE_|DM4PR12MB6304:EE_
x-ms-office365-filtering-correlation-id: 56f606df-a4bd-4b89-f44f-08dc4ee5b828
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 4VEsRiVVc/txZo73+0vkYpuZxkhEPeWxsag05N0YfvhHAQH+XBm0+4tgQk1Hr2yeYpmuRC1YLt44EPReQpv+efwmgWk2NatZqAKJaGSuKItE759AQl144OdQ1YQiwsQRfQlH/mIqecCkLRnHvHIvYPSNRlbjLXdTMyfX0eC/K6llI2ri7I44lepvlChOeWfElaiWGdPS4TdQGu4ToD37HBeNGXJZI7LkYgIF611eZgN7lnEw31CbqBhM1d2tno9wY4L6FEbm/e9tJ0IK4YnQt9DEEJbMdg5nBW8UIptTQR+LKmMnMck8Nkcb67wJzQlT6YWM1sNBUNkcBu8ltkeuKdJ1fdX8Z/lWYHjo/rwTXcJ1rCEl225FhUD4L79jkm18Pww0jWsB+PNvTB1jFdKqJ3YBhW0fFXfwpkGw1+z3jq0ioi/EI6sjZmX9/ZycVwEXiMZVeEna2mODJN6hwuzruAWPLCyB4zenXvkl0gLOqUcaKnQPZsYDUcM2kdXNJgWOKgwUR3OXMUfoGEi7lUpk8ndXHgL0/GfmpbQ5Af9BOy5LJs87iqawlxnSd0XtySMRRezFxDIEm2NMG8LhsWbHPiYjDaGGaaABvuqMgMpqJoupXIpfnXxUX2lu0hvOx5s/G8X/00RqtKQOS+Tpkg8nj2NLATkJQ7s+uK8yG8hFfE9qMBNnDpEXDjq2ESDilVaHtbD3ByqDchU4P2lQxWy/bNzy9fNn7aDoZwHheAR9VDY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB8580.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TTJId1JMWnpFaHlPc3lxVEdQTlJSRUJyS0FsVVpyMFJnVXB4QTJLNEFEcGcz?=
 =?utf-8?B?UVZoU2J3dUFIWjk3ZVRzTzZ1V0V5YUtBVFVoa01aOGNsYk10SkJmNGtxYlJh?=
 =?utf-8?B?ZFlheXF0amFXUG1qdzF6cWkxUzJySSticng0SC9oYzVtRmZmbDFtbFFEdGs1?=
 =?utf-8?B?VlltdW9QQXZHOUprOW1mNTFSS2lIbzlQYUZwZzl5WUNOaG9BbzQ0RUxNWGV5?=
 =?utf-8?B?NnZMSEorcC9leXJ6b3VZWUw3MGFaVG81Y1pPV2JTdStyb21vK2pZZlVpbzZH?=
 =?utf-8?B?d2R1ZVdxN1FLKzA3WFVvSGtjM1Vwd29TSFVBbG1ONU55dXQ3eTdZd21KNlo2?=
 =?utf-8?B?ZVNrQStyZEdpV0p2SGpxSzNDMkpvUlcvODlPTUJPRUh1cXh6S0FvZm41VmNq?=
 =?utf-8?B?TzFDVElHSGRJVTNxV08vT0VaeFc5SmFsVC93ZTBwQ0JTSnBqNVVSS3lFbmpR?=
 =?utf-8?B?Z3U1NTVIczBMb2ZpMFg2Slk1cmxDT24ycGNFREVSQXlVcGJPQzgzWGM4Y0R1?=
 =?utf-8?B?OC9MT1RmaWxYcXJueGpEeEI2WG5tYkQzdThWSWM1bDNGdk14eXU1ak9KZ1Vl?=
 =?utf-8?B?ckZXdk44dmNhOUVkOTZqWHRLWHNSVVFoRSt4UlNVVVkraDEyL3VaK0pVU1Ri?=
 =?utf-8?B?c295UzNvMVdjQ0lEeFJ4TlR6SGlEY0RqVmRMRjRnRHJpaWdHSEFUcWVESjYz?=
 =?utf-8?B?ekhFRTBOMHhYM1ZEOVpQQkg2ak5qY2hSbVNGRHE2MXZEbzdmN2k5TDhYa0JU?=
 =?utf-8?B?V1BKdTNMQy92ZzBUMjFXTFpTTmVDcEJqbXdtNHg5TG0zS0VJUDZDNTdXL0lB?=
 =?utf-8?B?c0ZWR0x4azlmTkJVdjNPQ0x5Tzk5N3V0Vy9KQ1ZmTkdUZHhUL2tTNUdBaGVK?=
 =?utf-8?B?VTdOS1ZiOS9ZVWRaUVFWSzl0bkthbVBFaEcvZGFBYWNKMC9ialdNdWtQRVZO?=
 =?utf-8?B?TXlSNXdkQ25kaUVSQk9NWTFUVWdIQWdQc0tBRjVKWGwrNmFxdFluSXFlYWtV?=
 =?utf-8?B?cThFNnY3MWZGeDVOaldoeFFaSnhGZFlqemdVNkhBQkNibW8vekZsenF6U0JF?=
 =?utf-8?B?S0ZpMUVHQjR6Nll1UEtzSi9nd2swMlRySzREUnpwL2dPbUtYcEhDUk9XblVw?=
 =?utf-8?B?NW8wdHlCNjJvN3hmOThUREFDV0VsOGQxcUN2UUlJL05MUWk3WXY5dHVkWEU3?=
 =?utf-8?B?UEdEa3lQQ284aHhZOXZhQTQ3YmlVNlhkYWlmdE5xMEEwa254ZURBdHNPMzNO?=
 =?utf-8?B?TlVWTUtYYlNxVDZ0T0h3QXBaZTFEdnRJeTE5cXNXN3MyZjJNenM1dFhjYUhp?=
 =?utf-8?B?Rk9RWm5SZEREYlNjNEluSTNyQUpCcWJ2eTZJQWhYZThqdTRKbDRLS0EzYVFS?=
 =?utf-8?B?WmRtSXcxL1E5d0JMWjh4ZU9QUk5XVGNmN2RwUkUxNGxmN2UzQzhSN2hBRVVP?=
 =?utf-8?B?YmRudjRjQTNrYXNwR1dmdUZZWmtpQStHNnZubW1mc0FqVm42bER6Tmx1M3lT?=
 =?utf-8?B?TkxFa0xtaCtaYjBNN0NLYkg5V3Z3U242UjFsbUZxTHduN2Y0eGZHWDNvaXI4?=
 =?utf-8?B?Qkg3QjE1dTNIcmFudWFKUTlScWtnTzBLaEtIVkNRQWg5MUZDMEhia2ZTWW0v?=
 =?utf-8?B?eHd5Tlk0KzNobVhmRGhxNDYzS2UwekpqRE9Lb1c4MVBDYWdJdStnYXBzL3ZN?=
 =?utf-8?B?L1FTdW1YUWVNTktYVjZ1TTlPREluQlpKNERiM3J1OWh1cExmTS9qMWIvUEFu?=
 =?utf-8?B?VVlwaWxmZ3Y2NStHcnNtdlR1N0ZFVGJtVEw1d0Y3Rm12OWZrZ1lDRlNTcnBk?=
 =?utf-8?B?WURJRGpHcWZpSDdxWGxuSyt6SUpRU0hZc3drWVZOTmlxR1VtSXg4YlBld0Ex?=
 =?utf-8?B?bnk3a3I1dEhjNjRlaUhZR0p1WG1LN0dyQkpaSUVzTThUUlpxMVR1bUVGSmp0?=
 =?utf-8?B?dkNBb1FmZzNzaEJQSWwwVzJVY1UrSkpwdzRDVVBXSGdORnVBWktLMWVUTGVD?=
 =?utf-8?B?Si90SzA2UmduMGpFQ1BVTzdvTnFPZVY0R0wxWi8wZTNOVzNoYmU1UXJUOEtw?=
 =?utf-8?B?enJxMnM4MjBtR2dzTTBPVXN6dWU3TVYyM2JqcVd6a0YyNE1KdGtITVNpMWdY?=
 =?utf-8?Q?Y22s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB8580.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f606df-a4bd-4b89-f44f-08dc4ee5b828
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 05:12:52.3464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SH2WeeMfnOUp6X6tar5Os1H1pGKPW0w2C17CpicwGyEpbVZz3o5aY1io0eQuQmzXMDyvlWOQ+0c1sy4SsZtp+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6304

PiBGcm9tOiBIZW5nIFFpIDxoZW5ncWlAbGludXguYWxpYmFiYS5jb20+DQo+IFNlbnQ6IFdlZG5l
c2RheSwgTWFyY2ggMjcsIDIwMjQgMTE6NTcgUE0NCj4gVG86IERhbiBKdXJnZW5zIDxkYW5pZWxq
QG52aWRpYS5jb20+OyBuZXRkZXZAdmdlci5rZXJuZWwub3JnDQo+IENjOiBtc3RAcmVkaGF0LmNv
bTsgamFzb3dhbmdAcmVkaGF0LmNvbTsgeHVhbnpodW9AbGludXguYWxpYmFiYS5jb207DQo+IHZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LmRldjsgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsNCj4gZWR1
bWF6ZXRAZ29vZ2xlLmNvbTsga3ViYUBrZXJuZWwub3JnOyBwYWJlbmlAcmVkaGF0LmNvbTsgSmly
aSBQaXJrbw0KPiA8amlyaUBudmlkaWEuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIG5ldC1u
ZXh0IHYyIDQvNl0gdmlydGlvX25ldDogRG8gRElNIHVwZGF0ZSBmb3Igc3BlY2lmaWVkDQo+IHF1
ZXVlIG9ubHkNCj4gDQo+IA0KPiANCj4g5ZyoIDIwMjQvMy8yOCDkuIvljYgxMjo0NywgRGFuaWVs
IEp1cmdlbnMg5YaZ6YGTOg0KPiA+IFNpbmNlIHdlIG5vIGxvbmdlciBoYXZlIHRvIGhvbGQgdGhl
IFJUTkwgbG9jayBoZXJlIGp1c3QgZG8gdXBkYXRlcyBmb3INCj4gPiB0aGUgc3BlY2lmaWVkIHF1
ZXVlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogRGFuaWVsIEp1cmdlbnMgPGRhbmllbGpAbnZp
ZGlhLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDM4ICsr
KysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gICAxIGZpbGUgY2hhbmdl
ZCwgMTQgaW5zZXJ0aW9ucygrKSwgMjQgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGlu
ZGV4DQo+ID4gYjkyOTg1NDRiMWI1Li45YzRiZmIxZWIxNWMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJp
dmVycy9uZXQvdmlydGlvX25ldC5jDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5j
DQo+ID4gQEAgLTM1OTYsMzYgKzM1OTYsMjYgQEAgc3RhdGljIHZvaWQgdmlydG5ldF9yeF9kaW1f
d29yayhzdHJ1Y3QNCj4gd29ya19zdHJ1Y3QgKndvcmspDQo+ID4gICAJc3RydWN0IHZpcnRuZXRf
aW5mbyAqdmkgPSBycS0+dnEtPnZkZXYtPnByaXY7DQo+ID4gICAJc3RydWN0IG5ldF9kZXZpY2Ug
KmRldiA9IHZpLT5kZXY7DQo+ID4gICAJc3RydWN0IGRpbV9jcV9tb2RlciB1cGRhdGVfbW9kZXI7
DQo+ID4gLQlpbnQgaSwgcW51bSwgZXJyOw0KPiA+ICsJaW50IHFudW0sIGVycjsNCj4gPg0KPiA+
ICAgCWlmICghcnRubF90cnlsb2NrKCkpDQo+ID4gICAJCXJldHVybjsNCj4gPg0KPiA+IC0JLyog
RWFjaCByeHEncyB3b3JrIGlzIHF1ZXVlZCBieSAibmV0X2RpbSgpLT5zY2hlZHVsZV93b3JrKCki
DQo+ID4gLQkgKiBpbiByZXNwb25zZSB0byBOQVBJIHRyYWZmaWMgY2hhbmdlcy4gTm90ZSB0aGF0
IGRpbS0+cHJvZmlsZV9peA0KPiA+IC0JICogZm9yIGVhY2ggcnhxIGlzIHVwZGF0ZWQgcHJpb3Ig
dG8gdGhlIHF1ZXVpbmcgYWN0aW9uLg0KPiA+IC0JICogU28gd2Ugb25seSBuZWVkIHRvIHRyYXZl
cnNlIGFuZCB1cGRhdGUgcHJvZmlsZXMgZm9yIGFsbCByeHFzDQo+ID4gLQkgKiBpbiB0aGUgd29y
ayB3aGljaCBpcyBob2xkaW5nIHJ0bmxfbG9jay4NCj4gPiAtCSAqLw0KPiA+IC0JZm9yIChpID0g
MDsgaSA8IHZpLT5jdXJyX3F1ZXVlX3BhaXJzOyBpKyspIHsNCj4gPiAtCQlycSA9ICZ2aS0+cnFb
aV07DQo+ID4gLQkJZGltID0gJnJxLT5kaW07DQo+ID4gLQkJcW51bSA9IHJxIC0gdmktPnJxOw0K
PiA+ICsJcW51bSA9IHJxIC0gdmktPnJxOw0KPiA+DQo+ID4gLQkJaWYgKCFycS0+ZGltX2VuYWJs
ZWQpDQo+ID4gLQkJCWNvbnRpbnVlOw0KPiA+ICsJaWYgKCFycS0+ZGltX2VuYWJsZWQpDQo+ID4g
KwkJY29udGludWU7DQo+IA0KPiA/DQo+IA0KPiBjb250aW51ZSB3aGF0Pw0KPiANCg0KU29ycnks
IG1lc3NlZCB0aGlzIHVwIHdoZW4gSSB3YXMgdGVzdGluZyB0aGUgcGF0Y2hlcyBhbmQgcHV0IHRo
ZSBmaXggZm9yIHRoZSBjb250aW51ZSBpbiB0aGUgbG9jayBwYXRjaC4NCg0KPiBGb3IgdGhlIGxv
Y2sgY29kZSwgcGxlYXNlIHBhc3MgdGhlIHRlc3QuIEl0J3MgaW1wb3J0YW50Lg0KDQpJIGRpZCBz
b21lIGJlbmNoIHRlc3RpbmcuIEknbGwgZG8gbW9yZSBhbmQgc2VuZCBhIG5ldyBzZXQgZWFybHkg
bmV4dCB3ZWVrLg0KDQo+IA0KPiBSZWdhcmRzLA0KPiBIZW5nDQo+IA0KPiA+DQo+ID4gLQkJdXBk
YXRlX21vZGVyID0gbmV0X2RpbV9nZXRfcnhfbW9kZXJhdGlvbihkaW0tPm1vZGUsDQo+IGRpbS0+
cHJvZmlsZV9peCk7DQo+ID4gLQkJaWYgKHVwZGF0ZV9tb2Rlci51c2VjICE9IHJxLT5pbnRyX2Nv
YWwubWF4X3VzZWNzIHx8DQo+ID4gLQkJICAgIHVwZGF0ZV9tb2Rlci5wa3RzICE9IHJxLT5pbnRy
X2NvYWwubWF4X3BhY2tldHMpIHsNCj4gPiAtCQkJZXJyID0gdmlydG5ldF9zZW5kX3J4X2N0cmxf
Y29hbF92cV9jbWQodmksIHFudW0sDQo+ID4gLQ0KPiB1cGRhdGVfbW9kZXIudXNlYywNCj4gPiAt
DQo+IHVwZGF0ZV9tb2Rlci5wa3RzKTsNCj4gPiAtCQkJaWYgKGVycikNCj4gPiAtCQkJCXByX2Rl
YnVnKCIlczogRmFpbGVkIHRvIHNlbmQgZGltDQo+IHBhcmFtZXRlcnMgb24gcnhxJWRcbiIsDQo+
ID4gLQkJCQkJIGRldi0+bmFtZSwgcW51bSk7DQo+ID4gLQkJCWRpbS0+c3RhdGUgPSBESU1fU1RB
UlRfTUVBU1VSRTsNCj4gPiAtCQl9DQo+ID4gKwl1cGRhdGVfbW9kZXIgPSBuZXRfZGltX2dldF9y
eF9tb2RlcmF0aW9uKGRpbS0+bW9kZSwgZGltLQ0KPiA+cHJvZmlsZV9peCk7DQo+ID4gKwlpZiAo
dXBkYXRlX21vZGVyLnVzZWMgIT0gcnEtPmludHJfY29hbC5tYXhfdXNlY3MgfHwNCj4gPiArCSAg
ICB1cGRhdGVfbW9kZXIucGt0cyAhPSBycS0+aW50cl9jb2FsLm1heF9wYWNrZXRzKSB7DQo+ID4g
KwkJZXJyID0gdmlydG5ldF9zZW5kX3J4X2N0cmxfY29hbF92cV9jbWQodmksIHFudW0sDQo+ID4g
KwkJCQkJCSAgICAgICB1cGRhdGVfbW9kZXIudXNlYywNCj4gPiArCQkJCQkJICAgICAgIHVwZGF0
ZV9tb2Rlci5wa3RzKTsNCj4gPiArCQlpZiAoZXJyKQ0KPiA+ICsJCQlwcl9kZWJ1ZygiJXM6IEZh
aWxlZCB0byBzZW5kIGRpbSBwYXJhbWV0ZXJzIG9uDQo+IHJ4cSVkXG4iLA0KPiA+ICsJCQkJIGRl
di0+bmFtZSwgcW51bSk7DQo+ID4gKwkJZGltLT5zdGF0ZSA9IERJTV9TVEFSVF9NRUFTVVJFOw0K
PiA+ICAgCX0NCj4gPg0KPiA+ICAgCXJ0bmxfdW5sb2NrKCk7DQoNCg==

