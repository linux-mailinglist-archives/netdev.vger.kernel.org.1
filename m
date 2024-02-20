Return-Path: <netdev+bounces-73378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8F185C33D
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 19:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81AA2285D53
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 18:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD5677652;
	Tue, 20 Feb 2024 18:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bXIOul41"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F8B76905
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 18:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708452172; cv=fail; b=H/p5Cmb1tPytaKcsMOGjHz35s6YTIxlYtqi2iMWeMueoZZGVDJ8W6LDxI5S5TKbBQhUf2VKRj2mk6R1xZiKNabVr50HqX8leXVv3eB+U8+Nyn5viyeRJtWK3f4eLqkh0f8Ub43Yvkp+LPpvGOcNeNmtj5RBxAWHY3s6TkV9+k1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708452172; c=relaxed/simple;
	bh=jaDq6A9Lu6xuEinlAjhicHDWdGrlS96tjMOsQnqnwnM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t1mDnqqdjW/q1vr9oVt0AbE3DB1eC2BsRvk40yOP02Kbop6HakZHA9bcpvE3T7bUjzlEZx7TSha5PyjhxvjtIG96w7BrtfWREACh4A0SabkDh+rKOAAOfIozyvpkoNkWJx7UXkOO+tA4d1itwD+A6kPKP9yV4FsobgUO7WtH0Ss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bXIOul41; arc=fail smtp.client-ip=40.107.92.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ahsBhOlfVz7k9WyytHMjmx/T4Vm3LpD4d3LTA5olkLv3zG4EKnxUm30Rfkaf27OCG+iK3jOoiuK/CyUmkGSkmekWTGVfMj2X6V5QqC2dY8hyge5FRnz1e8AxXY4PK/mCNMwvBTVwbYLKjYfm6scE39BdrfsoNj89ofkUWNKc8m7R84KDdNtnVTIFat1yxgXMSl7ZqGDyvjO4w3rlzExYGMsmuVeUwz72GP37DKIlW7BfjvMZqTojhAm9aNb3c6fYyMxd0zmHYeuXrom9zslqdAyux9XvcQaIhkc7VEWJKUkUrLPZZVFgMBhBIfd8/5oXPV24V79EBmylIbRpuc3+Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jaDq6A9Lu6xuEinlAjhicHDWdGrlS96tjMOsQnqnwnM=;
 b=Dx3SlO5+1aGKiQEzLot83qlwuJOv3aiBGFaFid8lH8OxAmMPaKBN0HkwuiVOecMZHoQRSoBUSHfon5/Y4mOsRDDScEQs/Q99hSOQKk291ynlqoAmfbv98GDyUc0YMMZInL7Sz8nT7xOJTUTHGTcwBA7wm5gxV+CafkpJnTcHqoBmV3S8bPVPUWREeJ/cluBVw+essZvYUa0hEQ9U0WLWTtvNjhLlSn5MLP59AbTwB0FcS39sj5/2A/fnCX7UZn6QlpiF4opdx3NN8EobdgMwkMn8RHQEL0psJZ4qcOXvvfIFDx5FGUvoHuNlN/bxeznxETmi4wEqlC57YEDnNi7d+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jaDq6A9Lu6xuEinlAjhicHDWdGrlS96tjMOsQnqnwnM=;
 b=bXIOul411i/SAsa+p1K2B5Z4l6vAcp+SCUzFE3QhTjzln8P4jnsmGteRqRlfje9w8bSXadb4+ULFO5swgLXC5x5uQdIIgQqH/vDMKvnM2wGo7HB5FL63nBK3ra93l5KrdamJiU2sq/CUr+uhvvnbWrfQUL2lCa0DpKzbzbvrSZoED6JvNT1bRlxogsg3216z3bAMm5kl5b6Gq6/H/f1RBfj169DHSWgOsABknjNx9aerFUYwzTSbFb8qz4D1ix9wl0xfeASczXWUekfBOCFaUD5LFVsLytpSBCHt+Jnj8b2Hdd5MuyGcaIR3UYI3f+DS7zywQ5RZz8mDFFyKI+R0mg==
Received: from CH0PR12MB8580.namprd12.prod.outlook.com (2603:10b6:610:192::6)
 by CY5PR12MB6108.namprd12.prod.outlook.com (2603:10b6:930:27::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Tue, 20 Feb
 2024 18:02:46 +0000
Received: from CH0PR12MB8580.namprd12.prod.outlook.com
 ([fe80::d465:d973:a339:dfe6]) by CH0PR12MB8580.namprd12.prod.outlook.com
 ([fe80::d465:d973:a339:dfe6%4]) with mapi id 15.20.7316.018; Tue, 20 Feb 2024
 18:02:46 +0000
From: Dan Jurgens <danielj@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Jason Wang <jasowang@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Jason
 Xing <kerneljasonxing@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"abeni@redhat.com" <abeni@redhat.com>, Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH net-next] virtio_net: Add TX stop and wake counters
Thread-Topic: [PATCH net-next] virtio_net: Add TX stop and wake counters
Thread-Index:
 AQHaU4g6jvRyzH1tPUCIs6q7Q9im2rDycmwAgAAGRTCAAAXXAIAAAcJwgAABlYCAABui0IAAnRGAgAM82ACAACpvgIAAmT0AgAIuegCAAL3LAIAFK2+AgAAL9ACAAAOK0IAURErw
Date: Tue, 20 Feb 2024 18:02:46 +0000
Message-ID:
 <CH0PR12MB85807A30B1F42A4E354516A1C9502@CH0PR12MB8580.namprd12.prod.outlook.com>
References:
 <CH0PR12MB8580CCF10308B9935810C21DC97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
 <20240130105246-mutt-send-email-mst@kernel.org>
 <CH0PR12MB858067B9DB6BCEE10519F957C97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
 <CAL+tcoCsT6UJ=2zxL-=0n7sQ2vPC5ybnQk9bGhF6PexZN=-29Q@mail.gmail.com>
 <20240201202106.25d6dc93@kernel.org>
 <CAL+tcoCs6x7=rBj50g2cMjwLjLOKs9xy1ZZBwSQs8bLfzm=B7Q@mail.gmail.com>
 <20240202080126.72598eef@kernel.org>
 <CACGkMEu0x9zr09DChJtnTP4R-Tot=5gAYb3Tx2V1EMbEk3oEGw@mail.gmail.com>
 <20240204070920-mutt-send-email-mst@kernel.org>
 <CH0PR12MB8580F1E450D06925BEB45D72C9452@CH0PR12MB8580.namprd12.prod.outlook.com>
 <20240207151748-mutt-send-email-mst@kernel.org>
 <CH0PR12MB8580846303702F68388E9713C9452@CH0PR12MB8580.namprd12.prod.outlook.com>
In-Reply-To:
 <CH0PR12MB8580846303702F68388E9713C9452@CH0PR12MB8580.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB8580:EE_|CY5PR12MB6108:EE_
x-ms-office365-filtering-correlation-id: 258a1679-a2f7-4256-29c2-08dc323e24ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 xSuwhBb9JhjMHDrxxptcLntc4mOc8D7KDAFikfhl5aelKfTxUHYc7oA3z7eF1VqrEwwVlgMvXBJFGhKlK6jEBfAei8CDeeWtIvOsvY9emAewaR36BPk4QCqoiHboVf/rQLr+qOkRANfsORMY1Ubypk6o2GU6yGyW/QPP/leOS/1JDHmMoxelt3lAd66xqtit51XTXHC1QGfxi4mC91nY+yblWTFK4kjocFFwgn+ygvS8bYrlBBLCW4rLBQwUspB8qnlBo0uWnU4Z1ZZOWEYlbI94QQzLTEDZPyk5Qkt75ze4T3bvKWkbfMnort6hzrzgMSY33mDkB9I1P9ojlyeusjIyaVS+Njjo+axnoHZDaQgt0g9PCI5FumGzusvP4n3MQVuLBonzl/lgl/5EjUs9gqO2KcIxMJVNwmbunYkkHO3UdLpBl5TE2G6LuAScIsMRh/iitaiB55LKwU1B5Ls7kt+IkEufj37X9QUYeHQZqJ/ISSes7RNXs5kwLjMM6Qyldtw0iwlivZYzlPZRhghsoPAWZ0Bp672kyZPYzPmXU6eK5oEGxBHCeOjilnNmPGbkd/Z/FWxwqxDdfsR+/07joQAbg8JT34q13Ai+WNU1J0IQI30Vaqe4ao3rn3WH+5nu/RVj5/tgnBS+cvrwUxPXdMvlU/NUh6cuzFGEIXaxviY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB8580.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M29ZekcvUW1LY2dOdlZEa2FwK2VoK1F0bXJGY2RXRndWMjcza3UxMHhrYWhW?=
 =?utf-8?B?VGljWkZHMjI5ZzFuYUlzYnpLcWpuOU1nVDZRbWxuNDdLUnVqLzdBN3RvL3Vx?=
 =?utf-8?B?OGtGcnQ2TXpuQWljeEtiUEsrKzRaV09BTFJOdWYrZW5ZVERRczhtSzZ3Y3hP?=
 =?utf-8?B?MVVoVDBaclBGVy9VZTJMbnV3N01VT3J5VTR2OEtrTk5BbUMycStRNG9sbDZH?=
 =?utf-8?B?eGZYWStBbHRwVjBqeTcvUFZsWFQ2MGVkUGtmdXd3d2ZMYXBleFJpN0ZnbjI3?=
 =?utf-8?B?VHZqTW5zdFlNQXg1eEpMRFZTdU1VUkl2VGtBYWhRa1AxT0dHbU1mbVU3V3Bo?=
 =?utf-8?B?UENHY3BXd3pEc09Yb3hiYkpmenlsYzBvbGhLOGwzci8yS09lMWNMRmd0aFBQ?=
 =?utf-8?B?bExhemh0c3hYNU0rcGlPNXhtNnV6ZTIxWWU3Q3E3WDd4QVVEckVtSDZOYkdV?=
 =?utf-8?B?cURCbjBrQWRIMG84d0M5NFFkaU1hUEdqS2FETlVqRmI3SW5CWkJwbEIvUjRv?=
 =?utf-8?B?RHFRczRhd3oyMWtRbm5tcEhVczJTbDJGTHo1SkR4ZGp3MnV1YnBIQXMraWtY?=
 =?utf-8?B?K2dwdW11MW93cjN4VGFzaWgrV1BBTVY2REFRUG1mQzh6SFBEUHFoSDJZZytV?=
 =?utf-8?B?dWE1VEIyN3FOVUxieEFZc0pyRWpuSW5HcWdHb3hUVG00YWdOVjVnWTMxaGFK?=
 =?utf-8?B?QzhBT0I5d0Q0aENJRFFxcXZYUDhhMklxV0ZqYlpUOE1sWVNvM29rdzc1RmRr?=
 =?utf-8?B?Zk9OSTRVc2l5N2o2cU5uV1RNNm1NTUFJTS9NZjVZZm9NTGd2eWhPS1hpMzNq?=
 =?utf-8?B?NVFwaUZSTmZmNExQb3NKVjJERHhiRVVuVWxTbGovTVZwSm45VXloOFhISXo1?=
 =?utf-8?B?dWs2SWw5V3JMaWhxa21EeFYyZGNQQzQycmFoRXNkb29TdVZsZVZSQXdSOFhs?=
 =?utf-8?B?SFg0c0VnbFQ0ZmpBV2VGU0VkR3RUbE56WENsNUN3VGNMS2lMMVNyNDl2RndZ?=
 =?utf-8?B?T3NuelZwZWU1TkpHVWFiaVppNjhKMHlMWHMzTTEzWHhha0VVaWpEd1JCblhs?=
 =?utf-8?B?SWl3amhnSytyM1NERm5kZnU0eFBLU1ovUTR6N09ySldhVFRkb092NjZuK0Za?=
 =?utf-8?B?RE1VR0JUNVFrSXJYUVl2YS9GV3pDTHoxSmVINERqMDJpQUVCV3M2V0tkNjc0?=
 =?utf-8?B?Y3NxUVFxYlpiQW43enRWT1dSTTlDZldscDVYYWk3Nk1taHllOExVMW5XZWdi?=
 =?utf-8?B?Qi9QRXE4WTNTRm1wLzJ0WDNJb2ttSUVGZ2NpTFBoMHRrQ0xOYm9KbWNBRUhz?=
 =?utf-8?B?VWhxYzFjOXlaV25Ha1IwcUZwcVZsVCtHWlh0enZUNFR6V2czOVNzRWNSOWww?=
 =?utf-8?B?RGdEMXZBVDZaNEFDZk1QN1Z6MXFLUzhEejVpdlkySm5zN3ZMWHp1WjhWRVha?=
 =?utf-8?B?NDBQKzR2VWJKS3ZHeEVrOURTWWFjc2R4bzFVUVRlR2VHVWczSW53QjJmNTVx?=
 =?utf-8?B?dkE5R3lpRlRPWVgvaGI5ZGp5YmdDL3J4NVhiV0ZNWE1HMHRkeTFiRy95cUpi?=
 =?utf-8?B?MTd0bDJQUEtPREk2SzNPNGZhVFpzejBtU2pvOVdSV1lZcXNEZWx2Vk92RUNY?=
 =?utf-8?B?MEozMHRzNjBMTENaY0tZUTFSdXp1b3U4WG1IMnNJeE01dVdlSkJKMXdpNUZW?=
 =?utf-8?B?OFFNSWtGczNWZFV3TzBrNzh3aGQyOVI5bytuK0d3bDNnZUJmVnZNTWN6WGQw?=
 =?utf-8?B?WlpFRW4xMnVON2tkWUV4ME1RNHl2R0R5MHE4dUg5amQ2Tms1L2ZTbi9uODBR?=
 =?utf-8?B?cWk3cTJuM3Y2TVRQUE0rd2hGbFdkOUVIcFNLTENqRXVIRFpheTJTZHJwSDVE?=
 =?utf-8?B?S0pPQXhZd2lUUDJzcDFRUHBYNW1za0dPeW91RG51MUYvdnZnalgwZXlBeFMv?=
 =?utf-8?B?UTVLbWdCRk9JVm02STJRN3NLVjYreDdHMHk3OFNtNG1Sb3RRV1J4K2o3Skgv?=
 =?utf-8?B?eGJFOE92alc0Q1k3SUdTNWREeHRIVmtGMmlvcHhpZUxlQko0ZEpHTDgvZUFo?=
 =?utf-8?B?Nk9CQ1Z1Q01Nb2hFZFFLRXJUZm9WTUF1QVVGR3IzSGg3MzA3MWplUFVJK3I3?=
 =?utf-8?Q?2OA0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 258a1679-a2f7-4256-29c2-08dc323e24ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2024 18:02:46.4072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UwS3d123kmdcr6kQjaa2XEP6FetmAzlqBdmDMYpedzhoQZP0sK7cet6tty1zTZPXJCsWJfuVKae8KUVeCF4YsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6108

PiBGcm9tOiBEYW5pZWwgSnVyZ2VucyA8ZGFuaWVsakBudmlkaWEuY29tPg0KPiBTZW50OiBXZWRu
ZXNkYXksIEZlYnJ1YXJ5IDcsIDIwMjQgMjo1OSBQTQ0KPiBUbzogTWljaGFlbCBTLiBUc2lya2lu
IDxtc3RAcmVkaGF0LmNvbT4NCj4gQ2M6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+
OyBKYWt1YiBLaWNpbnNraQ0KPiA8a3ViYUBrZXJuZWwub3JnPjsgSmFzb24gWGluZyA8a2VybmVs
amFzb254aW5nQGdtYWlsLmNvbT47DQo+IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IHh1YW56aHVv
QGxpbnV4LmFsaWJhYmEuY29tOw0KPiB2aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC5kZXY7IGRh
dmVtQGRhdmVtbG9mdC5uZXQ7DQo+IGVkdW1hemV0QGdvb2dsZS5jb207IGFiZW5pQHJlZGhhdC5j
b207IFBhcmF2IFBhbmRpdA0KPiA8cGFyYXZAbnZpZGlhLmNvbT4NCj4gU3ViamVjdDogUkU6IFtQ
QVRDSCBuZXQtbmV4dF0gdmlydGlvX25ldDogQWRkIFRYIHN0b3AgYW5kIHdha2UgY291bnRlcnMN
Cj4gDQo+IA0KPiA+IEZyb206IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+DQo+
ID4gU2VudDogV2VkbmVzZGF5LCBGZWJydWFyeSA3LCAyMDI0IDI6MTkgUE0NCj4gPiBUbzogRGFu
aWVsIEp1cmdlbnMgPGRhbmllbGpAbnZpZGlhLmNvbT4NCj4gPiBTdWJqZWN0OiBSZTogW1BBVENI
IG5ldC1uZXh0XSB2aXJ0aW9fbmV0OiBBZGQgVFggc3RvcCBhbmQgd2FrZQ0KPiA+IGNvdW50ZXJz
DQo+ID4NCj4gPiBPbiBXZWQsIEZlYiAwNywgMjAyNCBhdCAwNzozODoxNlBNICswMDAwLCBEYW5p
ZWwgSnVyZ2VucyB3cm90ZToNCj4gPiA+ID4gRnJvbTogTWljaGFlbCBTLiBUc2lya2luIDxtc3RA
cmVkaGF0LmNvbT4NCj4gPiA+ID4gU2VudDogU3VuZGF5LCBGZWJydWFyeSA0LCAyMDI0IDY6NDAg
QU0NCj4gPiA+ID4gVG86IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+ID4gPiA+
IENjOiBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPjsgSmFzb24gWGluZw0KPiA+ID4g
PiA8a2VybmVsamFzb254aW5nQGdtYWlsLmNvbT47IERhbmllbCBKdXJnZW5zIDxkYW5pZWxqQG52
aWRpYS5jb20+Ow0KPiA+ID4gPiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyB4dWFuemh1b0BsaW51
eC5hbGliYWJhLmNvbTsNCj4gPiA+ID4gdmlydHVhbGl6YXRpb25AbGlzdHMubGludXguZGV2OyBk
YXZlbUBkYXZlbWxvZnQubmV0Ow0KPiA+ID4gPiBlZHVtYXpldEBnb29nbGUuY29tOyBhYmVuaUBy
ZWRoYXQuY29tOyBQYXJhdiBQYW5kaXQNCj4gPiA+ID4gPHBhcmF2QG52aWRpYS5jb20+DQo+ID4g
PiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggbmV0LW5leHRdIHZpcnRpb19uZXQ6IEFkZCBUWCBzdG9w
IGFuZCB3YWtlDQo+ID4gPiA+IGNvdW50ZXJzDQo+ID4gPiA+DQo+ID4gPiA+IE9uIFN1biwgRmVi
IDA0LCAyMDI0IGF0IDA5OjIwOjE4QU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6DQo+ID4gPiA+
ID4gT24gU2F0LCBGZWIgMywgMjAyNCBhdCAxMjowMeKAr0FNIEpha3ViIEtpY2luc2tpIDxrdWJh
QGtlcm5lbC5vcmc+DQo+ID4gd3JvdGU6DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gT24gRnJp
LCAyIEZlYiAyMDI0IDE0OjUyOjU5ICswODAwIEphc29uIFhpbmcgd3JvdGU6DQo+ID4gPiA+ID4g
PiA+ID4gQ2FuIHlvdSBzYXkgbW9yZT8gSSdtIGN1cmlvdXMgd2hhdCdzIHlvdXIgdXNlIGNhc2Uu
DQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+IEknbSBub3Qgd29ya2luZyBhdCBOdmlkaWEs
IHNvIG15IHBvaW50IG9mIHZpZXcgbWF5IGRpZmZlcg0KPiA+ID4gPiA+ID4gPiBmcm9tDQo+ID4g
dGhlaXJzLg0KPiA+ID4gPiA+ID4gPiBGcm9tIHdoYXQgSSBjYW4gdGVsbCBpcyB0aGF0IHRob3Nl
IHR3byBjb3VudGVycyBoZWxwIG1lDQo+ID4gPiA+ID4gPiA+IG5hcnJvdyBkb3duIHRoZSByYW5n
ZSBpZiBJIGhhdmUgdG8gZGlhZ25vc2UvZGVidWcgc29tZSBpc3N1ZXMuDQo+ID4gPiA+ID4gPg0K
PiA+ID4gPiA+ID4gcmlnaHQsIGknbSBhc2tpbmcgdG8gY29sbGVjdCB1c2VmdWwgZGVidWdnaW5n
IHRyaWNrcywgbm90aGluZw0KPiA+ID4gPiA+ID4gYWdhaW5zdCB0aGUgcGF0Y2ggaXRzZWxmIDop
DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiAxKSBJIHNvbWV0aW1lcyBub3RpY2UgdGhhdCBp
ZiBzb21lIGlycSBpcyBoZWxkIHRvbyBsb25nDQo+ID4gPiA+ID4gPiA+IChzYXksIG9uZSBzaW1w
bGUgY2FzZTogb3V0cHV0IG9mIHByaW50ayBwcmludGVkIHRvIHRoZQ0KPiA+ID4gPiA+ID4gPiBj
b25zb2xlKSwgdGhvc2UgdHdvIGNvdW50ZXJzIGNhbiByZWZsZWN0IHRoZSBpc3N1ZS4NCj4gPiA+
ID4gPiA+ID4gMikgU2ltaWxhcmx5IGluIHZpcnRpbyBuZXQsIHJlY2VudGx5IEkgdHJhY2VkIHN1
Y2ggY291bnRlcnMNCj4gPiA+ID4gPiA+ID4gdGhlIGN1cnJlbnQga2VybmVsIGRvZXMgbm90IGhh
dmUgYW5kIGl0IHR1cm5lZCBvdXQgdGhhdCBvbmUNCj4gPiA+ID4gPiA+ID4gb2YgdGhlIG91dHB1
dCBxdWV1ZXMgaW4gdGhlIGJhY2tlbmQgYmVoYXZlcyBiYWRseS4NCj4gPiA+ID4gPiA+ID4gLi4u
DQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+IFN0b3Avd2FrZSBxdWV1ZSBjb3VudGVycyBt
YXkgbm90IHNob3cgZGlyZWN0bHkgdGhlIHJvb3QNCj4gPiA+ID4gPiA+ID4gY2F1c2Ugb2YgdGhl
IGlzc3VlLCBidXQgaGVscCB1cyAnZ3Vlc3MnIHRvIHNvbWUgZXh0ZW50Lg0KPiA+ID4gPiA+ID4N
Cj4gPiA+ID4gPiA+IEknbSBzdXJwcmlzZWQgeW91IHNheSB5b3UgY2FuIGRldGVjdCBzdGFsbC1y
ZWxhdGVkIGlzc3VlcyB3aXRoIHRoaXMuDQo+ID4gPiA+ID4gPiBJIGd1ZXNzIHZpcnRpbyBkb2Vz
bid0IGhhdmUgQlFMIHN1cHBvcnQsIHdoaWNoIG1ha2VzIGl0IHNwZWNpYWwuDQo+ID4gPiA+ID4N
Cj4gPiA+ID4gPiBZZXMsIHZpcnRpby1uZXQgaGFzIGEgbGVnYWN5IG9ycGhhbiBtb2RlLCB0aGlz
IGlzIHNvbWV0aGluZyB0aGF0DQo+ID4gPiA+ID4gbmVlZHMgdG8gYmUgZHJvcHBlZCBpbiB0aGUg
ZnV0dXJlLiBUaGlzIHdvdWxkIG1ha2UgQlFMIG11Y2ggbW9yZQ0KPiA+ID4gPiA+IGVhc2llciB0
byBiZSBpbXBsZW1lbnRlZC4NCj4gPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gSXQncyBub3QgdGhh
dCB3ZSBjYW4ndCBpbXBsZW1lbnQgQlFMLCBpdCdzIHRoYXQgaXQgZG9lcyBub3Qgc2VlbQ0KPiA+
ID4gPiB0byBiZSBiZW5lZml0aWFsIC0gaGFzIGJlZW4gZGlzY3Vzc2VkIG1hbnkgdGltZXMuDQo+
ID4gPiA+DQo+ID4gPiA+ID4gPiBOb3JtYWwgSFcgZHJpdmVycyB3aXRoIEJRTCBhbG1vc3QgbmV2
ZXIgc3RvcCB0aGUgcXVldWUgYnkNCj4gPiB0aGVtc2VsdmVzLg0KPiA+ID4gPiA+ID4gSSBtZWFu
IC0gaWYgdGhleSBkbywgYW5kIEJRTCBpcyBhY3RpdmUsIHRoZW4gdGhlIHN5c3RlbSBpcw0KPiA+
ID4gPiA+ID4gcHJvYmFibHkgbWlzY29uZmlndXJlZCAocXVldWUgaXMgdG9vIHNob3J0KS4gVGhp
cyBpcyB3aGF0IHdlDQo+ID4gPiA+ID4gPiB1c2UgYXQgTWV0YSB0byBkZXRlY3Qgc3RhbGxzIGlu
IGRyaXZlcnMgd2l0aCBCUUw6DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvYWxsLzIwMjQwMTMxMTAyMTUwLjcyODk2MC0zLWxlaXRhb0BkZWINCj4gPiA+
ID4gPiA+IGlhDQo+ID4gPiA+ID4gPiBuLm9yDQo+ID4gPiA+ID4gPiBnLw0KPiA+ID4gPiA+ID4N
Cj4gPiA+ID4gPiA+IERhbmllbCwgSSB0aGluayB0aGlzIG1heSBiZSBhIGdvb2QgZW5vdWdoIGV4
Y3VzZSB0byBhZGQNCj4gPiA+ID4gPiA+IHBlci1xdWV1ZSBzdGF0cyB0byB0aGUgbmV0ZGV2IGdl
bmwgZmFtaWx5LCBpZiB5b3UncmUgdXAgZm9yDQo+ID4gPiA+ID4gPiB0aGF0LiBMTUsgaWYgeW91
IHdhbnQgbW9yZSBpbmZvLCBvdGhlcndpc2UgSSBndWVzcyBldGh0b29sIC1TDQo+ID4gPiA+ID4g
PiBpcyBmaW5lDQo+ID4gZm9yIG5vdy4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4NCj4gPiA+ID4g
PiBUaGFua3MNCj4gPiA+DQo+ID4gPiBNaWNoYWVsLA0KPiA+ID4gCUFyZSB5b3UgT0sgd2l0aCB0
aGlzIHBhdGNoPyBVbmxlc3MgSSBtaXNzZWQgaXQgSSBkaWRuJ3Qgc2VlIGENCj4gPiA+IHJlc3Bv
bnNlDQo+ID4gZnJvbSB5b3UgaW4gb3VyIGNvbnZlcnNhdGlvbiB0aGUgZGF5IEkgc2VudCBpdC4N
Cj4gPiA+DQo+ID4NCj4gPiBJIHRob3VnaHQgd2hhdCBpcyBwcm9wb3NlZCBpcyBhZGRpbmcgc29t
ZSBzdXBwb3J0IGZvciB0aGVzZSBzdGF0cyB0byBjb3JlPw0KPiA+IERpZCBJIG1pc3VuZGVyc3Rv
b2Q/DQo+ID4NCj4gDQo+IFRoYXQncyBhIG11Y2ggYmlnZ2VyIGNoYW5nZSBhbmQgZ29pbmcgdGhh
dCByb3V0ZSBJIHRoaW5rIHN0aWxsIG5lZWQgdG8gY291bnQNCj4gdGhlbSBhdCB0aGUgZHJpdmVy
IGxldmVsLiBJIHNhaWQgSSBjb3VsZCBwb3RlbnRpYWxseSB0YWtlIHRoYXQgb24gYXMgYSBiYWNr
Z3JvdW5kDQo+IHByb2plY3QuIEJ1dCB3b3VsZCBwcmVmZXIgdG8gZ28gd2l0aCBldGh0b29sIC1T
IGZvciBub3cuDQoNCk1pY2hhZWwsIGFyZSB5b3UgYSBOQUNLIG9uIHRoaXM/IEpha3ViIHNlZW1l
ZCBPSyB3aXRoIGl0LCBKYXNvbiBhbHNvIHRoaW5rcyBpdCdzIHVzZWZ1bCwgYW5kIGl0J3MgbG93
IHJpc2suIA0KDQo+IA0KPiA+IC0tDQo+ID4gTVNUDQoNCg==

