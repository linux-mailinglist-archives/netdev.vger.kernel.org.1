Return-Path: <netdev+bounces-67263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 805E1842843
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 16:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBCC91F21C0F
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 15:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC67B82D99;
	Tue, 30 Jan 2024 15:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZGW4sAAI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D9485C44
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 15:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706629434; cv=fail; b=FBF8QXqacjnt+3yOxrcq4mTF0mO5qxyoJbTw2lkTRvPrGtvDjqiON+ZRUjaLeQnNarDxF5yZthkgYkad6mTNomhVW8S8HCt3zbAAQtQfYi+3cht0+w57EVhGpPPSSPbII9VaNwVKOh7KdszemFSp+LRNjNQBTrRhjnBEhu0xVlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706629434; c=relaxed/simple;
	bh=NWS/NPQ5Avg57RuogQ1YEbYkTN6YVoLeA1Q1LWEc/UQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V39wijLogwkxyby7jupefDAFgNPUBporh6c1YOdLhlszH/ciakIFeGqmwdkCwbVzvAMxf7Ay0zVuEzPE03QDAMXGzm7xVJgRlrXYMnt5cnAYzJoVG1Wun9qARz+YljKP88sKUyZvtmgzHdXI4blOkdrRE5fDmOIlE2hask/esJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZGW4sAAI; arc=fail smtp.client-ip=40.107.93.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2s6ATGXodoB5sgdujAZ2k28EPWekvJE9UlwolI7oGjhaXurshGP6Zx6dEoRJ/UJOqYqUpooos0fkj7Qi5E4w6lq9wIrQSkWaWe8OVIZZ4wKWojjjd2vPAH3M7wbtU2FTaQuPBOsqLkeVz7eK1JkfI4zk9gn6SEIANX0Bwz6syHWs8Q9xGR10+dPe95J7PPQcwkGDWq7tJN1c1FzQYXIWWAuKcJ+/7nCZWqOA0ieIeo2HNzvxe1K/Ao9Z+YV5DYH8t/+OXqeeeXdq+vsqSytBa/lGpEvWmhQwEYXZQoCFDJaeBgi+N5Tf5BDdRc1WZhHcsr4cS2zlaLPeRdCLpfNkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWS/NPQ5Avg57RuogQ1YEbYkTN6YVoLeA1Q1LWEc/UQ=;
 b=FXqvcBWXyYtjcSRUMaHhaPBM0eIzMsx7u+8n0UXZaqxUcy451SKRPXsTyDCwS8xjmwkbEQQPT5MJlk2OOy9I0mq6Ncne8kgyWUBli1wmyrzhbigqp9SDI9JCP+DCTAW1jxFQg0d4nzZ9+6m80Idi5y21XjUByX4Ks63bVAcGeBZcYgDRslXSnm/UzrufGgdv9KAO91lD1TwuULjVS6gFLqQNj0Dr1xK4E+jcTdG+vYAjd6aEmTpLZvhzmJcP1Hys2OToPQg/O5Owyt6OWHWeoMe6d8zyUWqKlqLf2AAjFUgxSodco8sqLW6A6tg95ufCcnSnLna+/jz6CrEasQ98gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWS/NPQ5Avg57RuogQ1YEbYkTN6YVoLeA1Q1LWEc/UQ=;
 b=ZGW4sAAIUu/tUzAZ67b5NDokylWHMU9QTCZFL4BoeJZpNrj+dfgLdfrfs+ove6/prygIL4u1lnK7vkzb7iW8fL1OMI/4L2Q8tmaj+g7Cp9Aj4AfPWc386kxl7uamBdHBU5AMFcoLIULnXGSYec1whtLXxVqE/oZZelmrV46P2BE+TIVcHKsXjXPZmpiHZ1E9Z7M3zzw1CUslJB3o/D2csiQNYjkQ01jvpuKEX3ARwayyNqDeOp12r9L0HDsm7+ZHuWjD2SmhaQVC82PkxjRk+ireU7pCDw77zw4PYdJm6L8q7h/H6MF9CwGewD7zSc7WZRg6oadfuXYjRzlCsUgKOA==
Received: from CH0PR12MB8580.namprd12.prod.outlook.com (2603:10b6:610:192::6)
 by DS0PR12MB6558.namprd12.prod.outlook.com (2603:10b6:8:d2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Tue, 30 Jan
 2024 15:43:48 +0000
Received: from CH0PR12MB8580.namprd12.prod.outlook.com
 ([fe80::8825:1827:3273:bbbf]) by CH0PR12MB8580.namprd12.prod.outlook.com
 ([fe80::8825:1827:3273:bbbf%3]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 15:43:48 +0000
From: Daniel Jurgens <danielj@nvidia.com>
To: Heng Qi <hengqi@linux.alibaba.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "abeni@redhat.com" <abeni@redhat.com>,
	Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH net-next] virtio_net: Add TX stop and wake counters
Thread-Topic: [PATCH net-next] virtio_net: Add TX stop and wake counters
Thread-Index: AQHaU4g6jvRyzH1tPUCIs6q7Q9im2rDyd6yAgAAGjdA=
Date: Tue, 30 Jan 2024 15:43:48 +0000
Message-ID:
 <CH0PR12MB8580571225697B1ABDD55541C97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
References: <20240130142521.18593-1-danielj@nvidia.com>
 <081f6d4c-bc44-4afe-ba51-d7c14966a536@linux.alibaba.com>
In-Reply-To: <081f6d4c-bc44-4afe-ba51-d7c14966a536@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB8580:EE_|DS0PR12MB6558:EE_
x-ms-office365-filtering-correlation-id: 19b5699e-1993-45f6-6c7d-08dc21aa4066
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 kvY/AwgWrF64kDRkIm8MwN1fh9nbEaJmcXm3URxtvdv8d74y1SJu/sGV93gdN2cRYsl8/ThrCTswRTToI/VT2OBooa1gg1dvv8nGMHWbeE3FaAX+4+G/X4IrdUnSJSdElHXAV/NxLQrD/8kS4P7xHNvA05b7fW4BEYvbYTTDY92/1i7E8/iHIeFBomZ+OQ9qMMK3OifNPb/VBhUTgjXZkncdhdG80XWqSZ6yKnqjj1ZquRnfk8kW40NrrPEpGhy9a3wXa9pfbR8/oxs/Q/kSDV0p0qfRmfulu2Dx0YcNbDbJz68peEojf1OjOTDmFymcMZrJQ07p3efyb5DvI5qQZLuciQoGPHWZ/pJA7t4jXC0hzsd8af0h9LK5dGaDqBzlbLsMZAZPioGNNWxg/UMGAKpyItBbN49m/o4Mc7KZKZ6tiPeaIDnTFFVcl7kYMhAKv4uyqkxmd4NkBDJraf4OJ0kPxPiS8b+88HfeO+exIc5FkOTsQBSA7eu/6LAjWFicwCUmAKMVXEGCr+Lp/H+l40AWvBOwzPKt+HmOMZoENOifrk8xZA03V+RPtWvI9L11MJznITwErg9KFb5v1rnb5NAoAIgUUeSkg7AEio8TkjtVKbze9msnqvaYgJLJDE2A
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB8580.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(136003)(346002)(366004)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(52536014)(8676002)(4326008)(8936002)(7416002)(2906002)(33656002)(5660300002)(54906003)(110136005)(86362001)(76116006)(316002)(64756008)(66476007)(66946007)(66556008)(66446008)(38070700009)(38100700002)(122000001)(7696005)(6506007)(83380400001)(478600001)(9686003)(71200400001)(107886003)(41300700001)(26005)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MzNyQTJmN0k1Ukx5eVBMaTVKd1l0VWdPT3FFRjllVy9XRFhoelNyMzBIcVU0?=
 =?utf-8?B?bE45NTBGbnVLaGg1UFhpRmdvNllkdEw5WVJoUUFMQ1dLZi92b2dPYzBMQzR2?=
 =?utf-8?B?aktUUFpUYTZFWmFaeTEvNTBiMUZaQmRXNmFYLzVnWlJ3dHovRHdJK3NlL2FU?=
 =?utf-8?B?RitNVnVCZ3grV2VrQXM0a2pjdmRKZEdBZVNITEJUcDM0RUZiMG9xT0VJVTlL?=
 =?utf-8?B?RmNtRDNEMnpwTk9JTEFJMXIxam1nTnVTQ1J6ZDBMT1pHOUZCdE0zRG9TKytF?=
 =?utf-8?B?Y2o2SmhpYXpvY2duZStkbTBUSSsxdFFSc1dnZmtoR1I2T3hUL1J6VXQwMXZN?=
 =?utf-8?B?dUFOQU9nQ2UxUkpCNFNyZzFQVzRsbkhmc2tDd1o5RHNUTHZSU1BMOTJpWkM4?=
 =?utf-8?B?Q0FjVUErelUrano1UHF0VXUrWUJsaEFFWXhBcVVVWkoxTDRIMnN3UHlSY2lM?=
 =?utf-8?B?ek9RK2hLS3NhSU80R0NETTVaeFJlOGJIT1JGVEJUMTZkVEFleUNqSzhjeXJL?=
 =?utf-8?B?cmhISjdNbWQ2MExGd0tTNG5rS1dzNlZXQ0NueEp1YnB5S0pOSUYrdmRhYjVa?=
 =?utf-8?B?L1pHcGU2dTE0WVN0R1VHYXB5eFE3NFFUNGhpbGpOVFZPM3ltK3FITG5QcUt5?=
 =?utf-8?B?dkFXT1JkUVlyb09iMGVIS0ZZVWRBMVptRkNnSlYvbXBWK09ydHNIR0VlRmxN?=
 =?utf-8?B?RTdaWXhRUEtUSzRodlZSaFhBTG00dlhIRUNuMnp5NW04MUtIek16YlJxa0lU?=
 =?utf-8?B?czBjMVRYZUFoYVhrbi9ob2dPWGN1OG5CWXM2YjJMRklLKzB4OUVZU1EzWUVW?=
 =?utf-8?B?a0lYZ0F0TmdpaHBuSjZEMXFDZXF1L2ZpR0RwTWpOL243aUVMNFZpSFFRbGM1?=
 =?utf-8?B?ZjBadTcyM3NiWEtJbXVod2dRTkx2dS9aS3VzeVV1UW1US1FuY0hPU3V0V0Y1?=
 =?utf-8?B?d3hNZkJRSDdaUmNwYkt1Zm1XZDNtamxFSVROeHIra2ltUzlWZWJQeDBSR0Vl?=
 =?utf-8?B?TEtYUmRoaTNSMTR5Y3hnTy9FY2poVGpyUktxYTV6S01HT0lhM09VdkR4NVc2?=
 =?utf-8?B?ZTdYbitrN1RKTTUxU0tkNVhxVGo0QWxkNkwwSkF0SmFLTldEanlDQzd1Smlq?=
 =?utf-8?B?aVlIbEhEQjJBVCt5S1VPMzdaaWhoakx6ai9sY2VMZm1abWZyeHBiT0o4M3hO?=
 =?utf-8?B?NE03L1JhY2NCMlJFUkw0akxnZzgveGdiVUxsSkl2MUFSbU1KUnFjMmpKOXgy?=
 =?utf-8?B?MUVLd3BwUElmeXNSYk41eVhXd000OGFSVGtHRmxvTjhzdlgzUklMYkVxTFVV?=
 =?utf-8?B?S3VERXc5aE03dUNheW9ua2UwdXNSdDkwdFRzaDFBblM0bVVkY1ZYbTcwZ2JL?=
 =?utf-8?B?VWNIblpnLzJ0R3FLWHplYTVoT0s0R1VacjJ2RktWblFOWVlFOTllQnBLTmlW?=
 =?utf-8?B?aUNHSEpNeEh4M1MzQ0FycW43TzliRkg2TTl5Yi9MYUtlMmQyb3JHWWlpUTRa?=
 =?utf-8?B?VXhRREgyUWdjN0M1eWF6NFdEbFptbUtyVG1zTm91djRFZkpSSk5EcG45Tmo0?=
 =?utf-8?B?WTdvczJDcFQvUGpCTlUxQnRpd3FtaHRBY2pjRmVZZkFseE5vWU9DMW1tWHpO?=
 =?utf-8?B?M1JFUzV0bWhhdEJGd3FjVWVvZkpna253ajRRcDMwR0ZCbzI5SDhWditWc2Er?=
 =?utf-8?B?QytGbDBmVFZ3c2NDai9YNDJ6SVQ1a3hyWnFDZFZFTjJsY25mQlJ1Vmo1emxx?=
 =?utf-8?B?QzVXdkpUb2xOVjJXQmFGcFlRay95WWNIUy9PVFB0bnhTOFRRQnJWR3pRRmJi?=
 =?utf-8?B?aHNReHBWVEZLbm5pVmZiV01BN2huV21teWpLNmhkYW41UWxDbFNmTEk5ZS9F?=
 =?utf-8?B?a3RxUU45eWVVZ3dBYk5jekwvMnV3d3JnTzYrb3I5WXNHRzRCNTc3WHU2aXdi?=
 =?utf-8?B?aERQT2U4S0NFV0FMWFYzbktaQWxKekdpVHBnM2NvbWZWOGNGeUlTZk1KUnpr?=
 =?utf-8?B?L3hGWTNESmZqTDlteWlIR3A4Y1VMVkdUOStlTjMvdktGc2RMamwvYWJBUWZr?=
 =?utf-8?B?dDFZZUNjeklkaG0zYXVMc2ZuaEJ3RDg3Yk5STEx2UkdXK1VlZEQrdnBlSHdv?=
 =?utf-8?Q?rhYg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b5699e-1993-45f6-6c7d-08dc21aa4066
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 15:43:48.8291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FJrIfHFwSZDuCM91/vb/UP0s1MBRvqIbIykanYg1HziyzgsREg/BsMZBbvBeQKL2DJNJ5avkDuD0yIPYR6tZDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6558

PiBGcm9tOiBIZW5nIFFpIDxoZW5ncWlAbGludXguYWxpYmFiYS5jb20+DQo+IFNlbnQ6IFR1ZXNk
YXksIEphbnVhcnkgMzAsIDIwMjQgOToxNyBBTQ0KPiDlnKggMjAyNC8xLzMwIOS4i+WNiDEwOjI1
LCBEYW5pZWwgSnVyZ2VucyDlhpnpgZM6DQo+ID4gQWRkIGEgdHggcXVldWUgc3RvcCBhbmQgd2Fr
ZSBjb3VudGVycywgdGhleSBhcmUgdXNlZnVsIGZvciBkZWJ1Z2dpbmcuDQo+ID4NCj4gPiAJJCBl
dGh0b29sIC1TIGVuczVmMiB8IGdyZXAgJ3R4X3N0b3BcfHR4X3dha2UnDQo+ID4gCS4uLg0KPiA+
IAl0eF9xdWV1ZV8xX3R4X3N0b3A6IDE2NzI2DQo+ID4gCXR4X3F1ZXVlXzFfdHhfd2FrZTogMTY3
MjYNCj4gPiAJLi4uDQo+ID4gCXR4X3F1ZXVlXzhfdHhfc3RvcDogMTUwMDExMA0KPiA+IAl0eF9x
dWV1ZV84X3R4X3dha2U6IDE1MDAxMTANCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IERhbmllbCBK
dXJnZW5zIDxkYW5pZWxqQG52aWRpYS5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IFBhcmF2IFBhbmRp
dCA8cGFyYXZAbnZpZGlhLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvbmV0L3ZpcnRpb19u
ZXQuYyB8IDI2ICsrKysrKysrKysrKysrKysrKysrKysrKy0tDQo+ID4gICAxIGZpbGUgY2hhbmdl
ZCwgMjQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgaW5k
ZXgNCj4gPiAzY2I4YWExOTM4ODQuLjdlM2MzMWNlYWY3ZSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2
ZXJzL25ldC92aXJ0aW9fbmV0LmMNCj4gPiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMN
Cj4gPiBAQCAtODgsNiArODgsOCBAQCBzdHJ1Y3QgdmlydG5ldF9zcV9zdGF0cyB7DQo+ID4gICAJ
dTY0X3N0YXRzX3QgeGRwX3R4X2Ryb3BzOw0KPiA+ICAgCXU2NF9zdGF0c190IGtpY2tzOw0KPiA+
ICAgCXU2NF9zdGF0c190IHR4X3RpbWVvdXRzOw0KPiA+ICsJdTY0X3N0YXRzX3QgdHhfc3RvcDsN
Cj4gPiArCXU2NF9zdGF0c190IHR4X3dha2U7DQo+ID4gICB9Ow0KPiANCj4gSGkgRGFuaWVsIQ0K
PiANCj4gdHhfc3RvcC93YWtlIG9ubHkgY291bnRzIHRoZSBzdGF0dXMgaW4gdGhlIEkvTyBwYXRo
Lg0KPiBEbyB0aGUgc3RhdHVzIG9mIHZpcnRuZXRfY29uZmlnX2NoYW5nZWRfd29yayBhbmQgdmly
dG5ldF90eF9yZXNpemUgbmVlZCB0bw0KPiBiZSBjb3VudGVkPw0KPiANCg0KTXkgbW90aXZhdGlv
biBmb3IgdGhlIGNvdW50ZXIgaXMgZGV0ZWN0aW5nIGZ1bGwgVFggcXVldWVzLiBJIGRvbid0IHRo
aW5rIGNvdW50aW5nIHRoZW0gaW4gdGhlIGNvbnRyb2wgcGF0aCBpcyB1c2VmdWwsIGJ1dCBpdCBj
YW4gYmUgZG9uZSBpZiB5b3UgZGlzYWdyZWUuDQoNCj4gVGhhbmtzLA0KPiBIZW5nDQo+IA0KPiA+
DQo+ID4gICBzdHJ1Y3QgdmlydG5ldF9ycV9zdGF0cyB7DQo+ID4gQEAgLTExMiw2ICsxMTQsOCBA
QCBzdGF0aWMgY29uc3Qgc3RydWN0IHZpcnRuZXRfc3RhdF9kZXNjDQo+IHZpcnRuZXRfc3Ffc3Rh
dHNfZGVzY1tdID0gew0KPiA+ICAgCXsgInhkcF90eF9kcm9wcyIsCVZJUlRORVRfU1FfU1RBVCh4
ZHBfdHhfZHJvcHMpIH0sDQo+ID4gICAJeyAia2lja3MiLAkJVklSVE5FVF9TUV9TVEFUKGtpY2tz
KSB9LA0KPiA+ICAgCXsgInR4X3RpbWVvdXRzIiwJVklSVE5FVF9TUV9TVEFUKHR4X3RpbWVvdXRz
KSB9LA0KPiA+ICsJeyAidHhfc3RvcCIsCQlWSVJUTkVUX1NRX1NUQVQodHhfc3RvcCkgfSwNCj4g
PiArCXsgInR4X3dha2UiLAkJVklSVE5FVF9TUV9TVEFUKHR4X3dha2UpIH0sDQo+ID4gICB9Ow0K
PiA+DQo+ID4gICBzdGF0aWMgY29uc3Qgc3RydWN0IHZpcnRuZXRfc3RhdF9kZXNjIHZpcnRuZXRf
cnFfc3RhdHNfZGVzY1tdID0geyBAQA0KPiA+IC04NDMsNiArODQ3LDkgQEAgc3RhdGljIHZvaWQg
Y2hlY2tfc3FfZnVsbF9hbmRfZGlzYWJsZShzdHJ1Y3QgdmlydG5ldF9pbmZvDQo+ICp2aSwNCj4g
PiAgIAkgKi8NCj4gPiAgIAlpZiAoc3EtPnZxLT5udW1fZnJlZSA8IDIrTUFYX1NLQl9GUkFHUykg
ew0KPiA+ICAgCQluZXRpZl9zdG9wX3N1YnF1ZXVlKGRldiwgcW51bSk7DQo+ID4gKwkJdTY0X3N0
YXRzX3VwZGF0ZV9iZWdpbigmc3EtPnN0YXRzLnN5bmNwKTsNCj4gPiArCQl1NjRfc3RhdHNfaW5j
KCZzcS0+c3RhdHMudHhfc3RvcCk7DQo+ID4gKwkJdTY0X3N0YXRzX3VwZGF0ZV9lbmQoJnNxLT5z
dGF0cy5zeW5jcCk7DQo+ID4gICAJCWlmICh1c2VfbmFwaSkgew0KPiA+ICAgCQkJaWYgKHVubGlr
ZWx5KCF2aXJ0cXVldWVfZW5hYmxlX2NiX2RlbGF5ZWQoc3EtPnZxKSkpDQo+ID4gICAJCQkJdmly
dHF1ZXVlX25hcGlfc2NoZWR1bGUoJnNxLT5uYXBpLCBzcS0NCj4gPnZxKTsgQEAgLTg1MSw2ICs4
NTgsOSBAQA0KPiA+IHN0YXRpYyB2b2lkIGNoZWNrX3NxX2Z1bGxfYW5kX2Rpc2FibGUoc3RydWN0
IHZpcnRuZXRfaW5mbyAqdmksDQo+ID4gICAJCQlmcmVlX29sZF94bWl0X3NrYnMoc3EsIGZhbHNl
KTsNCj4gPiAgIAkJCWlmIChzcS0+dnEtPm51bV9mcmVlID49IDIrTUFYX1NLQl9GUkFHUykgew0K
PiA+ICAgCQkJCW5ldGlmX3N0YXJ0X3N1YnF1ZXVlKGRldiwgcW51bSk7DQo+ID4gKwkJCQl1NjRf
c3RhdHNfdXBkYXRlX2JlZ2luKCZzcS0+c3RhdHMuc3luY3ApOw0KPiA+ICsJCQkJdTY0X3N0YXRz
X2luYygmc3EtPnN0YXRzLnR4X3dha2UpOw0KPiA+ICsJCQkJdTY0X3N0YXRzX3VwZGF0ZV9lbmQo
JnNxLT5zdGF0cy5zeW5jcCk7DQo+ID4gICAJCQkJdmlydHF1ZXVlX2Rpc2FibGVfY2Ioc3EtPnZx
KTsNCj4gPiAgIAkJCX0NCj4gPiAgIAkJfQ0KPiA+IEBAIC0yMTYzLDggKzIxNzMsMTQgQEAgc3Rh
dGljIHZvaWQgdmlydG5ldF9wb2xsX2NsZWFudHgoc3RydWN0DQo+IHJlY2VpdmVfcXVldWUgKnJx
KQ0KPiA+ICAgCQkJZnJlZV9vbGRfeG1pdF9za2JzKHNxLCB0cnVlKTsNCj4gPiAgIAkJfSB3aGls
ZSAodW5saWtlbHkoIXZpcnRxdWV1ZV9lbmFibGVfY2JfZGVsYXllZChzcS0+dnEpKSk7DQo+ID4N
Cj4gPiAtCQlpZiAoc3EtPnZxLT5udW1fZnJlZSA+PSAyICsgTUFYX1NLQl9GUkFHUykNCj4gPiAr
CQlpZiAoc3EtPnZxLT5udW1fZnJlZSA+PSAyICsgTUFYX1NLQl9GUkFHUykgew0KPiA+ICsJCQlp
ZiAobmV0aWZfdHhfcXVldWVfc3RvcHBlZCh0eHEpKSB7DQo+ID4gKwkJCQl1NjRfc3RhdHNfdXBk
YXRlX2JlZ2luKCZzcS0+c3RhdHMuc3luY3ApOw0KPiA+ICsJCQkJdTY0X3N0YXRzX2luYygmc3Et
PnN0YXRzLnR4X3dha2UpOw0KPiA+ICsJCQkJdTY0X3N0YXRzX3VwZGF0ZV9lbmQoJnNxLT5zdGF0
cy5zeW5jcCk7DQo+ID4gKwkJCX0NCj4gPiAgIAkJCW5ldGlmX3R4X3dha2VfcXVldWUodHhxKTsN
Cj4gPiArCQl9DQo+ID4NCj4gPiAgIAkJX19uZXRpZl90eF91bmxvY2sodHhxKTsNCj4gPiAgIAl9
DQo+ID4gQEAgLTIzMTAsOCArMjMyNiwxNCBAQCBzdGF0aWMgaW50IHZpcnRuZXRfcG9sbF90eChz
dHJ1Y3QgbmFwaV9zdHJ1Y3QNCj4gKm5hcGksIGludCBidWRnZXQpDQo+ID4gICAJdmlydHF1ZXVl
X2Rpc2FibGVfY2Ioc3EtPnZxKTsNCj4gPiAgIAlmcmVlX29sZF94bWl0X3NrYnMoc3EsIHRydWUp
Ow0KPiA+DQo+ID4gLQlpZiAoc3EtPnZxLT5udW1fZnJlZSA+PSAyICsgTUFYX1NLQl9GUkFHUykN
Cj4gPiArCWlmIChzcS0+dnEtPm51bV9mcmVlID49IDIgKyBNQVhfU0tCX0ZSQUdTKSB7DQo+ID4g
KwkJaWYgKG5ldGlmX3R4X3F1ZXVlX3N0b3BwZWQodHhxKSkgew0KPiA+ICsJCQl1NjRfc3RhdHNf
dXBkYXRlX2JlZ2luKCZzcS0+c3RhdHMuc3luY3ApOw0KPiA+ICsJCQl1NjRfc3RhdHNfaW5jKCZz
cS0+c3RhdHMudHhfd2FrZSk7DQo+ID4gKwkJCXU2NF9zdGF0c191cGRhdGVfZW5kKCZzcS0+c3Rh
dHMuc3luY3ApOw0KPiA+ICsJCX0NCj4gPiAgIAkJbmV0aWZfdHhfd2FrZV9xdWV1ZSh0eHEpOw0K
PiA+ICsJfQ0KPiA+DQo+ID4gICAJb3BhcXVlID0gdmlydHF1ZXVlX2VuYWJsZV9jYl9wcmVwYXJl
KHNxLT52cSk7DQo+ID4NCg0K

