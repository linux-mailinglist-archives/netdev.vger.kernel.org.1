Return-Path: <netdev+bounces-69971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B38F84D248
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 20:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E72E32894DF
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 19:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C5C8595E;
	Wed,  7 Feb 2024 19:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VX71GmUp"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2055.outbound.protection.outlook.com [40.107.102.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC1185954
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 19:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707334702; cv=fail; b=RMncSsvdu3FwafOTJS32CZdDVy3WRDH98tPx9PAw4qd2VXBU/Xf1Rp1mqgKDnrW4xwVHHFyaLdXwMWu39m+vtrB8sg8Yc0uaFbjLFZ7n3Jw9f8a9mkjBF55ai7iZPSpDBnbrkdt0yCj3+3vT25PR0kr9B2u3oR9LRk79AFDfXM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707334702; c=relaxed/simple;
	bh=wlNReghFSTZlPRjji+v/2eu+2LeUkoAWGI1ODDVO1zU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fKLbQCKamaKVBLb4KpERLmKFEZZyDxdzQJ+Rs8Qt78KeKhV7MuN/EXKvOCAzERMtnJLzx8FeSf9f4FZrycSgH5f5SjL7x69Zbg+cwuq3qe2VzZbyr5vP1ks6nOd5ngABIaPZVBkvZaGoa0g5f1Jqv/OF2SP197CvWla1/+zi19E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VX71GmUp; arc=fail smtp.client-ip=40.107.102.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LdfrOnOgiREmDu73UUCJA0xrJ+Y4S301g+F8bbfYf7E3wCyf17NtLSlmjDoY1WuFPd0/ZHfH2wq35K8GyhwdD/DVbGFWZVB+fYQpjN7zGu82QYPq6PAvw1itSvMDGpO5jyCY8LGav7qwOGIOv2NvQAjlGYdCUyqBwWGcJ53tznOKBk3NQrmTY9lSZTw8w5AlC0vvb37rsO04CJCfwTNmgJCfd0rBA2cudbjrmYawkl+UbOEB0E25MVAHiwKuLUkq5Kkhdlrb5nkpnyrMT01Vf8UQwnA3hwkYzY3YxPb/F8fSuNtWxA6x13SHQBGMvlDYesAT/SlyK0LwWupNHEvPsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wlNReghFSTZlPRjji+v/2eu+2LeUkoAWGI1ODDVO1zU=;
 b=RYY7WjjX+x+l5zDMlVJpiG/yHJUqMrf2LmhJUS2POExhjHsIeNaN0f8qSvKZ6OhQy3vTw1zZaNTr1m11BqRyuuI1PCgs22lOKt/pvHM8+PeX51qoNGD+w3/GKXxQxTnlyBgnf9q5JtyWg/EQdprGqulVIzEZCTwbdEQhkxjajNNQCkwUotD8DDfWG2B81fKOc9i/pvaJSuunvKamRCJSxP/2q7FYenNN2B4eL+U76snmvOIIh4xn1k5792YlnOkZSxWVEEXQ2i3VzAUH9oEN38/Cn7g4tn3N9jQwM7x4Fs6nKlbySNSqy9xP6ESylMps902amq6qrSevkxnGVMlmuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wlNReghFSTZlPRjji+v/2eu+2LeUkoAWGI1ODDVO1zU=;
 b=VX71GmUp7H4CKrk0YqynIiVMI4075cp4bXh1g0FhdM6q+r/t/HvGjKHhDJ9c/M7Azb4QN+aBn5uMhURIkWvYPbW37q85Gs1FlC+MwDwACYDAOoRrxGGjyFoLuk+TozvCyUZVFpaGvjyjmxeG7Ktbv3d4On1kwZ/iD11Hwg30l1KwRs/OhbQqYtKPAJsRKj8o/4+Jh5ICJDs2ikT1ZaSc/WpSPcGHl1FXrWUZj9DTb/CEW6XVkg8DSboDvUOvbAshYZm9C9pXsy798+u8JIfkOy0+tdOFeHs2fPczwtP9mckvS3sPVg80bDtJXC2SYGCNIB1WV5DdIksUYbEM9101LA==
Received: from CH0PR12MB8580.namprd12.prod.outlook.com (2603:10b6:610:192::6)
 by SN7PR12MB7227.namprd12.prod.outlook.com (2603:10b6:806:2aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Wed, 7 Feb
 2024 19:38:16 +0000
Received: from CH0PR12MB8580.namprd12.prod.outlook.com
 ([fe80::8825:1827:3273:bbbf]) by CH0PR12MB8580.namprd12.prod.outlook.com
 ([fe80::8825:1827:3273:bbbf%3]) with mapi id 15.20.7270.016; Wed, 7 Feb 2024
 19:38:16 +0000
From: Daniel Jurgens <danielj@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
CC: Jakub Kicinski <kuba@kernel.org>, Jason Xing <kerneljasonxing@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "abeni@redhat.com" <abeni@redhat.com>, Parav Pandit
	<parav@nvidia.com>
Subject: RE: [PATCH net-next] virtio_net: Add TX stop and wake counters
Thread-Topic: [PATCH net-next] virtio_net: Add TX stop and wake counters
Thread-Index:
 AQHaU4g6jvRyzH1tPUCIs6q7Q9im2rDycmwAgAAGRTCAAAXXAIAAAcJwgAABlYCAABui0IAAnRGAgAM82ACAACpvgIAAmT0AgAIuegCAAL3LAIAFK2+A
Date: Wed, 7 Feb 2024 19:38:16 +0000
Message-ID:
 <CH0PR12MB8580F1E450D06925BEB45D72C9452@CH0PR12MB8580.namprd12.prod.outlook.com>
References:
 <CH0PR12MB85809CB7678CADCC892B2259C97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
 <20240130104107-mutt-send-email-mst@kernel.org>
 <CH0PR12MB8580CCF10308B9935810C21DC97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
 <20240130105246-mutt-send-email-mst@kernel.org>
 <CH0PR12MB858067B9DB6BCEE10519F957C97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
 <CAL+tcoCsT6UJ=2zxL-=0n7sQ2vPC5ybnQk9bGhF6PexZN=-29Q@mail.gmail.com>
 <20240201202106.25d6dc93@kernel.org>
 <CAL+tcoCs6x7=rBj50g2cMjwLjLOKs9xy1ZZBwSQs8bLfzm=B7Q@mail.gmail.com>
 <20240202080126.72598eef@kernel.org>
 <CACGkMEu0x9zr09DChJtnTP4R-Tot=5gAYb3Tx2V1EMbEk3oEGw@mail.gmail.com>
 <20240204070920-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240204070920-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB8580:EE_|SN7PR12MB7227:EE_
x-ms-office365-filtering-correlation-id: d39f74db-a629-460d-5ae0-08dc281454c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 yWzo3FYI1wksbaT3MXwohlThCWhUwimkAKf3E3HdhUSPiAK1WtzxPTUK64JWPrgVo1/5aDuDDQrt25vTBwh1R3KNKat1Q/V1+FBcY3yfsKkXrrrCSOBeSaWEikFm3MLcNV+oO1EyzT4ldMzZr5/dbVEJSWeFPM7ylCvxA9EkJO37uPitToyb++McBcIue8WaxGuveYssBU6Ydvu0h8OCTlWE1woSGhPfvHEfM8RYhAXisi193vHWu+d4eEpruHzQaydbus55fagFqyeXg5FTb1q/zpvie7jy+C/hZ6O4466mJAv7xxJyhWZeoy9K+LbzIYKLSkwDIWTMOq7hwrMwQNRvIbO2GN3IY93wov6c9M+zE0r8HdRd20NZ6CtAZn6rL5k/9DADppIqSz6nsodDmVd5hB2MY9mzneNScoYDF8c0JZ+jf9hcVePzDFuVvsaOuyJFmfrk1YfuusnbN/WlbMB+oP/EOcIArlN5fi9B1KSil52oxAfUSTLr74i3GnJn9or6rSf1Xj/nghmuY2n+ubAcEmM1UeNVBqHAmJ264u7YZHzYCDrwCWTTylqGbUwQ7I6icd86cunT5eD7mxdV9CJ87KOCfXjgVIZjN7T2AyzLLIB62pCMu8hr9sFurnAoTkrDIKSG/8oJGR4hqvmOj3afroZQeRs/Rb0iUDNrSQA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB8580.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(39860400002)(366004)(376002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(478600001)(71200400001)(26005)(38070700009)(122000001)(41300700001)(33656002)(83380400001)(86362001)(53546011)(9686003)(6506007)(38100700002)(107886003)(7696005)(5660300002)(52536014)(55016003)(8936002)(4326008)(8676002)(966005)(2906002)(7416002)(76116006)(66476007)(66446008)(54906003)(64756008)(66946007)(316002)(110136005)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QmNsNEJpdDlqU0tURVArb01laVZ5WGNFYktQb05ucEppbDRGRVd4NjE1RFFT?=
 =?utf-8?B?blZZYUU2TG9Ed2h0Nnkwbnd1M3NvbERydzB3d3NMcDhFbTRwQUR5dlFWWG5n?=
 =?utf-8?B?MDdIVVR4SkhVWHMrQ24ySlJ3cHdITC9NSi94Ui81VllyWTN3dTdSRmZ1ejVI?=
 =?utf-8?B?SVZQZjg5WU1LZ044MkNXQkJVZXdlaWx0K2VZQlNvb0JXbXUzam5ZMno0NW85?=
 =?utf-8?B?MW8yZmRMMTJaLy9maU9QdTBhT0p2eXo0RTZoUHZTN05Da0E4YmcrVTZ1TWJF?=
 =?utf-8?B?c3VBZG5rdWtrQitXT3FVTkJ6QnhueVBCV1VkSnBjZDNSOHU5TXl2RTBUZ2pa?=
 =?utf-8?B?Um1hVldyd1E1Q0ZBLzRqM3hpOXZ6M0IwbWptZG02TGRDTjhoWXJvSzNSSGJD?=
 =?utf-8?B?aDFaZ2kzRDQ3V2NVcSt4Kys0dTMyNXN6MDBhMzUraUxNZ1RGMFdPeCtDdm4r?=
 =?utf-8?B?disxSWNjTTd0RDZEK3dhS256ak1JeW9rQTRSNXVndldrdEVzMVFSd3dJb1FP?=
 =?utf-8?B?WEJ2R0M1elUxSmF1V29CUTQvejBZemU5Z05ub0w4U0ZTSWRUbis1bzJMVkJt?=
 =?utf-8?B?U08wWTMyQ28zQ3p5ZFRkd1N1WlVtMnBCVE52V2luZDVMVVgyRzRTRW10SzQw?=
 =?utf-8?B?QjZUcm1SQVQvckREUFloTFVLdG8ra0tmekF3eGZ2OW84czgydTd2elVvQkFR?=
 =?utf-8?B?N0FXbUVxZFdmKysrcW80NFNHRmkwSUVMczhBL1JoOUFKeEZneHpsMkNRbDdM?=
 =?utf-8?B?WTRGU1VVeUFEM085UWx5bkhhR0NoeHFiTzlPV2Z5SHh2SzlFSnhCU0p5bStO?=
 =?utf-8?B?Vld3c1dzaFdkRGFyY0c3eGZVT1VBbFV4OW0vMHMxeDVuYWROaE90SnZURGU1?=
 =?utf-8?B?b3lxaHliaWNvTXRyMWZKcm1HT2MyN1laZGd0N1ZrOHJ4NnErOWdtQ3RSQkZm?=
 =?utf-8?B?SnBVNXEzK3hneEN3Rk13eUdKVjNlZWFPS0xYMThxek9Dd2kzdXgvT3pZRkdt?=
 =?utf-8?B?NnNUbWVDWERCSHZxMXFNYUloN3o4N0NuRFhodTQzTEY3Q1hmbzBJVnF3alVh?=
 =?utf-8?B?WWRBQVNKdTdpbzhwZ21ab2I0Zkh1WDFjQUE3cFQ2WENYT01LWmZjZGhSeWs5?=
 =?utf-8?B?R3M3WkZoQkdZdWxvSE0wKzdJT012L2lDK2p3VDJ2cVc5SXJKNmsyaUYycVdI?=
 =?utf-8?B?enZDemlFQnZVTEh1MXVMNTU2V2tqMjVha1FxaFY1WlVMNXo0N3hCTUR2R0tz?=
 =?utf-8?B?WlJMN3lNbXhFSjNFR1BDaHBvZUdUeGE0czdzMisxOVpSLytRZytXZy84Qnh5?=
 =?utf-8?B?aS9vd2pGQ0dlMlhoNWRmQkh1M05NSWhJQjNGS3VSaXc4MForYTZiM3lTNnhj?=
 =?utf-8?B?WDkvK2tROWFqUWxuNlpiUUhmdStwMkhjeUtjRGlrRDQ3bmlvTjZvMzlkTVFW?=
 =?utf-8?B?Uk1yYVBlOGlvd0VoQ3JsWWwxdEhmQUlKRnRBd2hJMHZaN0NXeXNyUE1qV21K?=
 =?utf-8?B?ZTFDSjhzVTE1b2JIZXpxNVJYSDEwb09SdHNoNHdZMWh0bGk3bjVOVkRMbTJN?=
 =?utf-8?B?QnlBQkVkcGRZamlLTHNHS1BlVnNMLzloWGZVZnNJbHJMOFBnYU1mZzNOanRp?=
 =?utf-8?B?UnVCek4ycllDa3dWeFdFRkhkR3V2ekFuNkpmckxXZktQaUhwNkRLWTJqbTZ4?=
 =?utf-8?B?K1N2UXZ5WC93aExYSHJ1cUV4WVZpa2xzM3BzdVppVDJVWDI3QlQ3bmYvT2Ru?=
 =?utf-8?B?RzMzTTgxQ013c2N4SmdMcWt0K0MweFgwZ3BIZlpIR3NIbGZEc01HMHQvTUxF?=
 =?utf-8?B?Q0lqMjNNcC9scUF1c0I4aHdZMWJvSDkwK0ZJckdLZzRPSVp0WkFOTE9XamNV?=
 =?utf-8?B?alJJc2l1bVU5eUNyTTJ5RXZBelRZbWFjam41SHM0dmQ5b0Q3dVQzOUVOL3py?=
 =?utf-8?B?aEVNL1ExSGRoc2ZRbXdzbktHOXdmcHRtUmN2UHFTUlZOTUR0WnQ1dENsaGhw?=
 =?utf-8?B?aGVxOUorWHJaKy9Ud0s3bmxaNlB1SVg1ZTdyem5sUmF4UXJEQWJpcEUyUDVk?=
 =?utf-8?B?UXV4bmZjMHZSbitQeXN0M2JkaFZRTE5ubHlrVEZYR1U2Tk9JUTM3Mjl1dnJQ?=
 =?utf-8?Q?WMCM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d39f74db-a629-460d-5ae0-08dc281454c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2024 19:38:16.6115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nLH6ztwUBXFnVxYIvFO5HOPx5g4bNsRQGZD9DrAAuRnSG+RU0PvHjWYTS1bJixSigAbidjYpByRhjaXkPO2mEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7227

PiBGcm9tOiBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPg0KPiBTZW50OiBTdW5k
YXksIEZlYnJ1YXJ5IDQsIDIwMjQgNjo0MCBBTQ0KPiBUbzogSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4NCj4gQ2M6IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+OyBKYXNv
biBYaW5nDQo+IDxrZXJuZWxqYXNvbnhpbmdAZ21haWwuY29tPjsgRGFuaWVsIEp1cmdlbnMgPGRh
bmllbGpAbnZpZGlhLmNvbT47DQo+IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IHh1YW56aHVvQGxp
bnV4LmFsaWJhYmEuY29tOw0KPiB2aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC5kZXY7IGRhdmVt
QGRhdmVtbG9mdC5uZXQ7DQo+IGVkdW1hemV0QGdvb2dsZS5jb207IGFiZW5pQHJlZGhhdC5jb207
IFBhcmF2IFBhbmRpdA0KPiA8cGFyYXZAbnZpZGlhLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRD
SCBuZXQtbmV4dF0gdmlydGlvX25ldDogQWRkIFRYIHN0b3AgYW5kIHdha2UgY291bnRlcnMNCj4g
DQo+IE9uIFN1biwgRmViIDA0LCAyMDI0IGF0IDA5OjIwOjE4QU0gKzA4MDAsIEphc29uIFdhbmcg
d3JvdGU6DQo+ID4gT24gU2F0LCBGZWIgMywgMjAyNCBhdCAxMjowMeKAr0FNIEpha3ViIEtpY2lu
c2tpIDxrdWJhQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiA+ID4NCj4gPiA+IE9uIEZyaSwgMiBGZWIg
MjAyNCAxNDo1Mjo1OSArMDgwMCBKYXNvbiBYaW5nIHdyb3RlOg0KPiA+ID4gPiA+IENhbiB5b3Ug
c2F5IG1vcmU/IEknbSBjdXJpb3VzIHdoYXQncyB5b3VyIHVzZSBjYXNlLg0KPiA+ID4gPg0KPiA+
ID4gPiBJJ20gbm90IHdvcmtpbmcgYXQgTnZpZGlhLCBzbyBteSBwb2ludCBvZiB2aWV3IG1heSBk
aWZmZXIgZnJvbSB0aGVpcnMuDQo+ID4gPiA+IEZyb20gd2hhdCBJIGNhbiB0ZWxsIGlzIHRoYXQg
dGhvc2UgdHdvIGNvdW50ZXJzIGhlbHAgbWUgbmFycm93DQo+ID4gPiA+IGRvd24gdGhlIHJhbmdl
IGlmIEkgaGF2ZSB0byBkaWFnbm9zZS9kZWJ1ZyBzb21lIGlzc3Vlcy4NCj4gPiA+DQo+ID4gPiBy
aWdodCwgaSdtIGFza2luZyB0byBjb2xsZWN0IHVzZWZ1bCBkZWJ1Z2dpbmcgdHJpY2tzLCBub3Ro
aW5nDQo+ID4gPiBhZ2FpbnN0IHRoZSBwYXRjaCBpdHNlbGYgOikNCj4gPiA+DQo+ID4gPiA+IDEp
IEkgc29tZXRpbWVzIG5vdGljZSB0aGF0IGlmIHNvbWUgaXJxIGlzIGhlbGQgdG9vIGxvbmcgKHNh
eSwgb25lDQo+ID4gPiA+IHNpbXBsZSBjYXNlOiBvdXRwdXQgb2YgcHJpbnRrIHByaW50ZWQgdG8g
dGhlIGNvbnNvbGUpLCB0aG9zZSB0d28NCj4gPiA+ID4gY291bnRlcnMgY2FuIHJlZmxlY3QgdGhl
IGlzc3VlLg0KPiA+ID4gPiAyKSBTaW1pbGFybHkgaW4gdmlydGlvIG5ldCwgcmVjZW50bHkgSSB0
cmFjZWQgc3VjaCBjb3VudGVycyB0aGUNCj4gPiA+ID4gY3VycmVudCBrZXJuZWwgZG9lcyBub3Qg
aGF2ZSBhbmQgaXQgdHVybmVkIG91dCB0aGF0IG9uZSBvZiB0aGUNCj4gPiA+ID4gb3V0cHV0IHF1
ZXVlcyBpbiB0aGUgYmFja2VuZCBiZWhhdmVzIGJhZGx5Lg0KPiA+ID4gPiAuLi4NCj4gPiA+ID4N
Cj4gPiA+ID4gU3RvcC93YWtlIHF1ZXVlIGNvdW50ZXJzIG1heSBub3Qgc2hvdyBkaXJlY3RseSB0
aGUgcm9vdCBjYXVzZSBvZg0KPiA+ID4gPiB0aGUgaXNzdWUsIGJ1dCBoZWxwIHVzICdndWVzcycg
dG8gc29tZSBleHRlbnQuDQo+ID4gPg0KPiA+ID4gSSdtIHN1cnByaXNlZCB5b3Ugc2F5IHlvdSBj
YW4gZGV0ZWN0IHN0YWxsLXJlbGF0ZWQgaXNzdWVzIHdpdGggdGhpcy4NCj4gPiA+IEkgZ3Vlc3Mg
dmlydGlvIGRvZXNuJ3QgaGF2ZSBCUUwgc3VwcG9ydCwgd2hpY2ggbWFrZXMgaXQgc3BlY2lhbC4N
Cj4gPg0KPiA+IFllcywgdmlydGlvLW5ldCBoYXMgYSBsZWdhY3kgb3JwaGFuIG1vZGUsIHRoaXMg
aXMgc29tZXRoaW5nIHRoYXQgbmVlZHMNCj4gPiB0byBiZSBkcm9wcGVkIGluIHRoZSBmdXR1cmUu
IFRoaXMgd291bGQgbWFrZSBCUUwgbXVjaCBtb3JlIGVhc2llciB0bw0KPiA+IGJlIGltcGxlbWVu
dGVkLg0KPiANCj4gDQo+IEl0J3Mgbm90IHRoYXQgd2UgY2FuJ3QgaW1wbGVtZW50IEJRTCwgaXQn
cyB0aGF0IGl0IGRvZXMgbm90IHNlZW0gdG8gYmUNCj4gYmVuZWZpdGlhbCAtIGhhcyBiZWVuIGRp
c2N1c3NlZCBtYW55IHRpbWVzLg0KPiANCj4gPiA+IE5vcm1hbCBIVyBkcml2ZXJzIHdpdGggQlFM
IGFsbW9zdCBuZXZlciBzdG9wIHRoZSBxdWV1ZSBieSB0aGVtc2VsdmVzLg0KPiA+ID4gSSBtZWFu
IC0gaWYgdGhleSBkbywgYW5kIEJRTCBpcyBhY3RpdmUsIHRoZW4gdGhlIHN5c3RlbSBpcyBwcm9i
YWJseQ0KPiA+ID4gbWlzY29uZmlndXJlZCAocXVldWUgaXMgdG9vIHNob3J0KS4gVGhpcyBpcyB3
aGF0IHdlIHVzZSBhdCBNZXRhIHRvDQo+ID4gPiBkZXRlY3Qgc3RhbGxzIGluIGRyaXZlcnMgd2l0
aCBCUUw6DQo+ID4gPg0KPiA+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjQwMTMx
MTAyMTUwLjcyODk2MC0zLWxlaXRhb0BkZWJpYW4ub3INCj4gPiA+IGcvDQo+ID4gPg0KPiA+ID4g
RGFuaWVsLCBJIHRoaW5rIHRoaXMgbWF5IGJlIGEgZ29vZCBlbm91Z2ggZXhjdXNlIHRvIGFkZCBw
ZXItcXVldWUNCj4gPiA+IHN0YXRzIHRvIHRoZSBuZXRkZXYgZ2VubCBmYW1pbHksIGlmIHlvdSdy
ZSB1cCBmb3IgdGhhdC4gTE1LIGlmIHlvdQ0KPiA+ID4gd2FudCBtb3JlIGluZm8sIG90aGVyd2lz
ZSBJIGd1ZXNzIGV0aHRvb2wgLVMgaXMgZmluZSBmb3Igbm93Lg0KPiA+ID4NCj4gPg0KPiA+IFRo
YW5rcw0KDQpNaWNoYWVsLA0KCUFyZSB5b3UgT0sgd2l0aCB0aGlzIHBhdGNoPyBVbmxlc3MgSSBt
aXNzZWQgaXQgSSBkaWRuJ3Qgc2VlIGEgcmVzcG9uc2UgZnJvbSB5b3UgaW4gb3VyIGNvbnZlcnNh
dGlvbiB0aGUgZGF5IEkgc2VudCBpdC4NCg0K

