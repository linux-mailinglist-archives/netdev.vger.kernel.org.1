Return-Path: <netdev+bounces-89287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B39E28A9EA2
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 17:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B46CB2494E
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 15:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9773416D333;
	Thu, 18 Apr 2024 15:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RPaRgpVo"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02C416C84E
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 15:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713454708; cv=fail; b=WRB14iOxaj3MoMWrsDq/5N+kXfHwUiMZQrl9bN4cAgLM2KJgFZRTQ6NPsuXq8zhigbk3JlhSSDBXfnhItuJTF4xdCuy4FpiOuY5vGAdirHuIx/McEvcXjKuXdXFG++dKIqGH9vvsv3dfdWw/6JfNSQuLXwgyV2TH+SFIOopWkQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713454708; c=relaxed/simple;
	bh=vrLsFePRsDWV+Fda1gMN7KPF5VKhiRqn4kRnKVZh3Ng=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=enPotYk0iKmkp+BjE/jWZLTSEiwIG6MTXBuR91a5Wg8SEiEHPltf3C07OF6jCAp8VfinRmnYRAJ0VwmSUCm1jHVJWeHkExpQARvFIB3nF0T5qBr9W0PNIjWZbVDWLbLPki3wuum7sdDUuIQWJGgkq4L+/jERtJbzqjdSpgaIJhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RPaRgpVo; arc=fail smtp.client-ip=40.107.94.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xd+2kyZmxNivG99QivI2Qr8hGgsJMZTkCQoWXejsZ/bRpbq8J+DBEJ5BzozYPRd5Zrnq6jCCE4fLf9YcmNeDmIqqofxprboMe6jUJ+f+7EsYeazj6BNewdTyC8vQNVFEla65l3BMVTF2QxEI+ftn4moNiHq5nUrZqqwemIGjlqOsnf9QE9EXzYsEAqSA2uRs26E8pP79iwMlYlSIDIIn0NKrc8FG42SkF4mgTmgRkm54sPVgKlztpgyrgKoqO+Yal71LVxAhlmJtT/olm3/vtHxiGJn8pDEFCzJJNaym1qw+9U0ZE+W0yCNv1KzYL1/zRtzCriL1IfL2QwHkDsLVwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vrLsFePRsDWV+Fda1gMN7KPF5VKhiRqn4kRnKVZh3Ng=;
 b=oRJRIagapd+3gD/7J/rkqorbKVxKaOHIKEV/URp3N2t9xYYwi/dzgwspqLgPHbYEuMI+cuAndZ0M3ym9eYBd1MLUAJxD9YgU0dhIk9p5eOmTTcsww1hWQiUdL7yIjZBE09XdPOoEybWd06uh5KUnrLG0tulepVpZbnxDcRnAbwQq/DExfXic9ZrIr20771ap7b2oPeBlhuMjmgTfKc9s0a/FEmPsw8k4usxtK1VbFXiufqJi+oFgpxsBB7JYU/RxH7Nku/flphbgQ8KPV71ziAvRuMxrHBfWDoLYDEGGxxrVCibDPNdX0CI8hHCiVmJmeZ9aGmIov1IKSL+vpV1vKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrLsFePRsDWV+Fda1gMN7KPF5VKhiRqn4kRnKVZh3Ng=;
 b=RPaRgpVol/5TdJav49T2p/g2Vj7vb1tPssTeHyy0rY+6ZWKayPqrW2/1qf0wsV2rgn8IefTwo4EOii5681fHlSAEkqgG2xEtAieuNElzlxfxjNKMPpZucHoGgPdZKxy92QwOzFTOwV7jHCUw+HJ2bxL05FMl4J7ksFftnRT9Q3yrbnCR+/OD6ikXTBy7599cmPM6roMy3mFh4KlmA8jSm+PG0Qvmdq2kTvInyiaClhlgKEZv9e/jQaqu8hmv2+acimNyAuhT57oni/sd9uUP43p6/ZCgb2l3wVwQl6eLVnwUHExxHuxd4zpeghqpq406X4Zo7K4QW2thVIpwKAr8rw==
Received: from CH0PR12MB8580.namprd12.prod.outlook.com (2603:10b6:610:192::6)
 by SA3PR12MB8045.namprd12.prod.outlook.com (2603:10b6:806:31d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 15:38:23 +0000
Received: from CH0PR12MB8580.namprd12.prod.outlook.com
 ([fe80::ff67:b47c:7721:3cd4]) by CH0PR12MB8580.namprd12.prod.outlook.com
 ([fe80::ff67:b47c:7721:3cd4%4]) with mapi id 15.20.7452.049; Thu, 18 Apr 2024
 15:38:23 +0000
From: Dan Jurgens <danielj@nvidia.com>
To: Paolo Abeni <pabeni@redhat.com>, Heng Qi <hengqi@linux.alibaba.com>, Jason
 Wang <jasowang@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "mst@redhat.com"
	<mst@redhat.com>, "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>, Jiri Pirko
	<jiri@nvidia.com>
Subject: RE: [PATCH net-next v4 3/6] virtio_net: Add a lock for the command
 VQ.
Thread-Topic: [PATCH net-next v4 3/6] virtio_net: Add a lock for the command
 VQ.
Thread-Index: AQHakDSr30Pqjk9RIk+mJMM1+iyO57Ftlr6AgAAPLwCAADfggIAAKk2A
Date: Thu, 18 Apr 2024 15:38:23 +0000
Message-ID:
 <CH0PR12MB85802CBD3808B483876F8C77C90E2@CH0PR12MB8580.namprd12.prod.outlook.com>
References: <20240416193039.272997-1-danielj@nvidia.com>
	 <20240416193039.272997-4-danielj@nvidia.com>
	 <CACGkMEsCm3=7FtnsTRx5QJo3ZM0Ko1OEvssWew_tfxm5V=MXvQ@mail.gmail.com>
	 <28e45768-5091-484d-b09e-4a63bc72a549@linux.alibaba.com>
 <ad9f7b83e48cfd7f1463d8c728061c30a4509076.camel@redhat.com>
In-Reply-To: <ad9f7b83e48cfd7f1463d8c728061c30a4509076.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB8580:EE_|SA3PR12MB8045:EE_
x-ms-office365-filtering-correlation-id: ab9be940-06b7-49db-c500-08dc5fbd952f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 HTTFyDwudR+jtIUV4B7yIpMjdthTiQZbJk6yTKFmkr4cvvlKOnVdcyhlaeV2ba0QyMJ4dS4988JBJTTMWshpQnSjK5y3c40Pq1+o2Ely1LMdM0svc8uxj5WEPMktszAVKmm3Hk1Q+ORgORiW8HlSlKeFNQDKOIR6wJYZu6mwmzJhMY/hlHL3vGhJuusof2KBWqhV7CKZAXE6nK+PwEGwYE2ToyHwQ3fQ2TlkB9KSPfF7smeW8M9aYjxIhfsTUiXjepTUHJJb3MtvgFo2FbIBffKgVBBZ6TOCgtUY0qJuSJl66SvRVS9in2/zP8pL8bHlxSAi/Yeh9AdEFkyxsCraOyrvCgm9xmqVH/O65970pPFlZFdogdwedDEWqHl7eAsl63HZQpq10zu2OR70F+RvOAQa24cQ+IMvtiV0DkiXZ23tba8b4cZMGyRaP2Ye7/TJqaCIjXEck/+LEdPFSsCRQIn6hi1x85nXNTRwSIP1Cqq/GfPuHtAljiuE/Y1hXWHA/iBXPAWFUOUqxwOpTVMy/YZCiDcMR54n6+1fE/KQ21mZck93Vml3jb+zFJYFRYF7hC8yLZSrGQxEPKfi0WzUZgchsz2PcmH7YIilALlPHGBoVw6+ZhrdiYF0iPAbxtxzMaEuO+CiYv71SY7H3W40FNfz140rNP1LRp0QVHMkwqz+6GvOzj0k0Xhcbtxvo/Ekf8ayyjQSHNPER6kfNU3VzQjaNPJPhF9qv/WyC0iF5JI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB8580.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Ym1FVGtpbVdLRnVaaVVVRVNFRFJkUGN4K240bHg3STZKUWpweU1hdmdYV1Fu?=
 =?utf-8?B?cldEMVBaWmM5ZGk1M0pTS0RnUks4Q0NoNjNBVHp0WW5mU1BnRFU0Lzl2UjdK?=
 =?utf-8?B?K2RRWHVxMlFsS0dPL2hHb3Z4OUFVSXI0cmg2c0xPNnkyaTFKeFF5cnQzSnVE?=
 =?utf-8?B?My84VFdtWHdZeVlpeTkyY2g4d0l0Mys0KzIxUzk5bFJOZDJOVU1naDVtOWxj?=
 =?utf-8?B?OUtSNnB5N3llSW9KNkhhbVFINFRkaFF1Snl3RXBPd1VpYVBjc0l5TC9oaGho?=
 =?utf-8?B?U25XUEdlUzdNcytyMlNDMGhHM2ZaVHlEbTJnTVhRTE1JQ2FpNURxeEpmMTBI?=
 =?utf-8?B?ak1GSm1qcUgzT3kzUjR5MGE1ZnBDMWtWeXdna203MG01ZHZ3Slp4eU1oaHRw?=
 =?utf-8?B?RTRCS0hoSDhZVkZrbUgvSWV1aTNmZVFKdHoxN3dYeEowTThIdHBkVkV4M2g4?=
 =?utf-8?B?MTRpMEc4NmJudFVrY0N3MFVUZ0NaZUZlYlhzVC8wTGVKYXpUR3ZmeHMzU3Bp?=
 =?utf-8?B?c3UxRUo0b1kza3R4UkE5bHYvKzZBbTk0QWNpS1FQZ1dVaVQ4djlFMmpOR1JN?=
 =?utf-8?B?aXh6MXhLY2E0VnhUTmhhelBQUHVHTGpaRFpTWUg3MUlVOXhWRm4ycnlyK1pQ?=
 =?utf-8?B?dGtIYmtCdFZHU0wveW4zcnltNTdsSlhmMmdQamtiSjNwMm9PZjJMWDY1MlVX?=
 =?utf-8?B?SmVwTUdZZTJHSHZlRytpMXM1Z1VVcHp2VnhrdDRpUmY1SWhVajNqak9rWmJ4?=
 =?utf-8?B?TU5FSnJCVDE3VFF6R05lVURNU3hUSGczRVJ1QkFtdis1ZHplTnV6Rm5VQWFr?=
 =?utf-8?B?YkNNUGNISkowYlp3M2FKNitiLy95TVVZbkhzeUEvM0t5ZjdoV3ZrLzJrMUNp?=
 =?utf-8?B?Kyt0YnkrQWNSdmFQYlBiaGVMTEcrTFR3cnF6cWpLOEwvNXlFRkt5b21YdlZn?=
 =?utf-8?B?Z1ZLb0NWaVpMSmNPeUZkckxHUTFZd2NFZnBRRDB2VUYvaFlRVElERmo2YlNw?=
 =?utf-8?B?b3dHMXFrZ2FiREdXamZzbTd6UVNwMnNWQmViK0lMZnR2cUUwMzBuOEN1UWY0?=
 =?utf-8?B?RUlnZFRMQkdacmhpNUZZN2poRVdzTWRrZFpOTXRNYWwzbDYwZjdsNHBNTitt?=
 =?utf-8?B?YnBYWkRzZ1dXc1VUQVY0SFdpZjVzNDg1THUrckhPdDY4UzB3azc3dmFRM1Bk?=
 =?utf-8?B?YXJMdE5DVU5RNHVrbkdBK3Rob2FTTFYxZnd0ZkpvREZ6dXdUcWZlbm9HNXE0?=
 =?utf-8?B?ODBERG5ua2ZYbENLdytsRXhmK1I0TWNNOUN1amtVZTlVZ3Z5WHV0OSs3SVpu?=
 =?utf-8?B?dUhhR2gzRjlnL2pCZzBiandXZG9jZ3B4NmtmMk9OREhjYW54TnFJMlNaVFlo?=
 =?utf-8?B?RnRMaW1MVGdoM0ZZZnZOQS80M0NhNURGeGJuM082T0FybVdEelh2d2c1cUh1?=
 =?utf-8?B?elUrSlpMUW1vbWo5ZlROcjNDbWZHY016WFFic2tmZ3U1UTUyRlk1TjRyM3ZV?=
 =?utf-8?B?L0FsblIrUVZ6Y3R1Y2gwZ3JUMVUzYVd3ZWxoZGRjZnlxb3FLRHJCV0NENURK?=
 =?utf-8?B?UGVid3hKZ2RvVllIUkc3OHhZejZyV3BhM0YreDdaY3JRYnFnZGl5T1BtZE0x?=
 =?utf-8?B?QnFFZjczZ1c0cHJPQ2FscktWRE1mRjdnNDFNdEhWUitvaStlZXJPMHk0ZjBu?=
 =?utf-8?B?eloyMGRmajk4cm40ekszVmV2eS9xSHF3YlIyaVIrSlFCV3Uwa0ZBUzRkMy8x?=
 =?utf-8?B?U0RWMnduWkNFRW5rWmxCZzVmNnhGVHVIZ1pjeFZQMmoyd04xNzlSSHB4dkZV?=
 =?utf-8?B?ZDRDZW82NjQxUDFlMHBQdkg4WktSYUdac1ZDSFFWd0REZmtHZU9xeGdjUkt4?=
 =?utf-8?B?di94SHBtb1cvV2tnT2xjYUpLcWtuRUJvQkltd1RRbk11cXdxTTRSZEtGZlA3?=
 =?utf-8?B?MjI3VnJkM0xHNUU2WldGWGZHYmdpNW42alV5Q3AvVjJYanQvVFJZamYvcGxi?=
 =?utf-8?B?L2FMT2hsQlNNK2MrM3d5S3dMaUhNVkxaYVVDWGpPSDRVYWVxVE5Nc2xZT3Fv?=
 =?utf-8?B?OFdjZnlhWEVodDRRZmUyd0dnUWc5VmM3TUY2dE03OXRWTE1URFk2dnlXLy96?=
 =?utf-8?Q?Zqls=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ab9be940-06b7-49db-c500-08dc5fbd952f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2024 15:38:23.5916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6DHIzhJBeSlDDHrR6IcxzKftd/5V39ffpy9uSpXS+Gg9rEWu3f/dFj9xxiI8UOxutLdieKcU7ONaKe1IwitZAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8045

PiBGcm9tOiBQYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5
LCBBcHJpbCAxOCwgMjAyNCA1OjU3IEFNDQo+IE9uIFRodSwgMjAyNC0wNC0xOCBhdCAxNTozNiAr
MDgwMCwgSGVuZyBRaSB3cm90ZToNCj4gPg0KPiA+IOWcqCAyMDI0LzQvMTgg5LiL5Y2IMjo0Miwg
SmFzb24gV2FuZyDlhpnpgZM6DQo+ID4gPiBPbiBXZWQsIEFwciAxNywgMjAyNCBhdCAzOjMx4oCv
QU0gRGFuaWVsIEp1cmdlbnMgPGRhbmllbGpAbnZpZGlhLmNvbT4NCj4gd3JvdGU6DQo+ID4gPiA+
IFRoZSBjb21tYW5kIFZRIHdpbGwgbm8gbG9uZ2VyIGJlIHByb3RlY3RlZCBieSB0aGUgUlROTCBs
b2NrLiBVc2UgYQ0KPiA+ID4gPiBzcGlubG9jayB0byBwcm90ZWN0IHRoZSBjb250cm9sIGJ1ZmZl
ciBoZWFkZXIgYW5kIHRoZSBWUS4NCj4gPiA+ID4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogRGFu
aWVsIEp1cmdlbnMgPGRhbmllbGpAbnZpZGlhLmNvbT4NCj4gPiA+ID4gUmV2aWV3ZWQtYnk6IEpp
cmkgUGlya28gPGppcmlAbnZpZGlhLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICAgZHJpdmVy
cy9uZXQvdmlydGlvX25ldC5jIHwgNiArKysrKy0NCj4gPiA+ID4gICAxIGZpbGUgY2hhbmdlZCwg
NSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gPiA+DQo+ID4gPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMN
Cj4gPiA+ID4gaW5kZXggMGVlMTkyYjQ1ZTFlLi5kMDJmODNhOTE5YTcgMTAwNjQ0DQo+ID4gPiA+
IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYw0KPiA+ID4gPiArKysgYi9kcml2ZXJzL25l
dC92aXJ0aW9fbmV0LmMNCj4gPiA+ID4gQEAgLTI4Miw2ICsyODIsNyBAQCBzdHJ1Y3QgdmlydG5l
dF9pbmZvIHsNCj4gPiA+ID4NCj4gPiA+ID4gICAgICAgICAgLyogSGFzIGNvbnRyb2wgdmlydHF1
ZXVlICovDQo+ID4gPiA+ICAgICAgICAgIGJvb2wgaGFzX2N2cTsNCj4gPiA+ID4gKyAgICAgICBz
cGlubG9ja190IGN2cV9sb2NrOw0KPiA+ID4gU3BpbmxvY2sgaXMgaW5zdGVhZCBvZiBtdXRleCB3
aGljaCBpcyBwcm9ibGVtYXRpYyBhcyB0aGVyZSdzIG5vDQo+ID4gPiBndWFyYW50ZWUgb24gd2hl
biB0aGUgZHJpdmVyIHdpbGwgZ2V0IGEgcmVwbHkuIEFuZCBpdCBiZWNhbWUgZXZlbg0KPiA+ID4g
bW9yZSBzZXJpb3VzIGFmdGVyIDBkMTk3YTE0NzE2NCAoInZpcnRpby1uZXQ6IGFkZCBjb25kX3Jl
c2NoZWQoKSB0bw0KPiA+ID4gdGhlIGNvbW1hbmQgd2FpdGluZyBsb29wIikuDQo+ID4gPg0KPiA+
ID4gQW55IHJlYXNvbiB3ZSBjYW4ndCB1c2UgbXV0ZXg/DQo+ID4NCj4gPiBIaSBKYXNvbiwNCj4g
Pg0KPiA+IEkgbWFkZSBhIHBhdGNoIHNldCB0byBlbmFibGUgY3RybHEncyBpcnEgb24gdG9wIG9m
IHRoaXMgcGF0Y2ggc2V0LA0KPiA+IHdoaWNoIHJlbW92ZXMgY29uZF9yZXNjaGVkKCkuDQo+ID4N
Cj4gPiBCdXQgSSBuZWVkIGEgbGl0dGxlIHRpbWUgdG8gdGVzdCwgdGhpcyBpcyBjbG9zZSB0byBm
YXN0LiBTbyBjb3VsZCB0aGUNCj4gPiB0b3BpYyBhYm91dCBjb25kX3Jlc2NoZWQgKyBzcGluIGxv
Y2sgb3IgbXV0ZXggbG9jayBiZSB3YWl0Pw0KPiANCj4gVGhlIGJpZyBwcm9ibGVtIGlzIHRoYXQg
dW50aWwgdGhlIGNvbmRfcmVzY2hlZCgpIGlzIHRoZXJlLCByZXBsYWNpbmcgdGhlDQo+IG11dGV4
IHdpdGggYSBzcGlubG9jayBjYW4vd2lsbCBsZWFkIHRvIHNjaGVkdWxpbmcgd2hpbGUgYXRvbWlj
IHNwbGF0cy4gV2UNCj4gY2FuJ3QgaW50ZW50aW9uYWxseSBpbnRyb2R1Y2Ugc3VjaCBzY2VuYXJp
by4NCg0KV2hlbiBJIGNyZWF0ZWQgdGhlIHNlcmllcyBzZXRfcnhfbW9kZSB3YXNuJ3QgbW92ZWQg
dG8gYSB3b3JrIHF1ZXVlLCBhbmQgdGhlIGNvbmRfcmVzY2hlZCB3YXNuJ3QgdGhlcmUuIE11dGV4
IHdhc24ndCBwb3NzaWJsZSwgdGhlbi4gSWYgdGhlIENWUSBpcyBtYWRlIHRvIGJlIGV2ZW50IGRy
aXZlbiwgdGhlbiB0aGUgbG9jayBjYW4gYmUgcmVsZWFzZWQgcmlnaHQgYWZ0ZXIgcG9zdGluZyB0
aGUgd29yayB0byB0aGUgVlEuDQoNCj4gDQo+IFNpZGUgbm90ZTogdGhlIGNvbXBpbGVyIGFwcGFy
ZW50bHkgZG9lcyBub3QgbGlrZSBndWFyZCgpIGNvbnN0cnVjdCwgbGVhZGluZyB0bw0KPiBuZXcg
d2FybmluZywgaGVyZSBhbmQgaW4gbGF0ZXIgcGF0Y2hlcy4gSSdtIHVuc3VyZSBpZiB0aGUgY29k
ZSBzaW1wbGlmaWNhdGlvbg0KPiBpcyB3b3J0aHkuDQoNCkkgZGlkbid0IHNlZSBhbnkgd2Fybmlu
Z3Mgd2l0aCBHQ0Mgb3IgY2xhbmcuIFRoaXMgaXMgdXNlZCBvdGhlciBwbGFjZXMgaW4gdGhlIGtl
cm5lbCBhcyB3ZWxsLg0KZ2NjIHZlcnNpb24gMTMuMi4xIDIwMjMwOTE4IChSZWQgSGF0IDEzLjIu
MS0zKSAoR0NDKQ0KY2xhbmcgdmVyc2lvbiAxNy4wLjYgKEZlZG9yYSAxNy4wLjYtMi5mYzM5KQ0K
PiANCj4gQ2hlZXJzLA0KPiANCj4gUGFvbG8NCg0K

