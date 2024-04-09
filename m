Return-Path: <netdev+bounces-86303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B4389E5AA
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 00:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77881B21A5B
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 22:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BEE757F6;
	Tue,  9 Apr 2024 22:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UTLf6xH7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2131.outbound.protection.outlook.com [40.107.93.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707E41EB5C
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 22:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712702157; cv=fail; b=uFPn+nnqvX48MohBGJrOpKv+UDcGQNxbIU9EoRcWXAZ2y/1Jbl3KGWH+BJ4uV2VLWlRzCn1q5NJWHo4f0WB50EbL04imTmzqEDfDsUL8EwjvVaQIYLpR1gKnWGHl2cJQoLBZhRf5Ubq2pp59JCVzkNJopWZ+E6ivJojG6ZNN2XA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712702157; c=relaxed/simple;
	bh=N3e+JuBS9fRO2Yu5WLjHwTHGCyxxNPXj7sbXMk1NCxA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cMExcm7MlidJCI5Cast1zY1XbP99rPMDUnIIiaeG8oRn6VatrA65IS3kzniNtm7gHRZbCYmzKWNsyO/NR++Dq58NlM5WeYTK1WYZ06QDyslnan+m8US+wzgVq1kM7C8qUorN2YV+sNMuwRJLPKcGkTIEiTJ6J3dbEaiC3TbzKIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UTLf6xH7; arc=fail smtp.client-ip=40.107.93.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hff/zo7b/zIK6OwvKD0kv5Cei5BcwkounE1ZfMHFYCUpgWBuvPrUYACBGUWpJd2wETn9rVOJIh3XhvNTMHyFMNDLt5xlJ/vjfXHrWKITxa35/Ww83B3qDLhyp3JwD1enPcNnY0gxJ053G389HkMiYATPdgn01+H20xZJmjY+HvmqbMPt8iqwbj9K12sAyEjZwSHWKHHyhVRL3JAZAxkDTOqj22EEfLVGw4lnd+1L3frsiykpNPTzFbf3GbdsnoNyL1Ix86PbxkaE8Q4+wk7Q6lloivAHTLbUq2kz0G4vTEQTx0HPUTyGbdm6UXP6U+gtcGHNXU6VK3Ediy4cX3Yznw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3e+JuBS9fRO2Yu5WLjHwTHGCyxxNPXj7sbXMk1NCxA=;
 b=MvfiABkmNCjMxFJNvstvVOmAyf2+TH8M1fy108IrckzaxRjacDNMAbjLmQiQVeANjHZTZ9VlBu607Ao8Ev5Z7m83HZnvWVYWRZrcNOoJ4imf9ypQHzDCzz8s2edll48ITeh8l46aKWx8UckubiXrfxl8eoAUkP8iQnhjEgOEdLq5wxS/IJSF+idOILdok3buOzTwOOyfnyYbJN2epkYT+WnKXcsrykZDzkE4zukqJZ1XDuzwE4iuRjJr/gVA+0f2oefoTEYkNyx5BL2vPaDapEibIr5vM1/Z2V3/Nde9NH6cUDrQx5QxlBX+oj2eQ3aLUf5/Oc2EDeOyfctWirBBow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3e+JuBS9fRO2Yu5WLjHwTHGCyxxNPXj7sbXMk1NCxA=;
 b=UTLf6xH7JVuB+I6YzsAfbpwkpehCPiApF8yxX21Z4qj+UxJupC6pkBsYDioP2/l7fwZPUXA/nlzHhnYbjmfdbpv+5P4YjQpH3I64KzLibbSrtY9JxbbmdqeN0rXj44CY4uw9pxkGHEQrX5PlZfb3J6t/cMd9uP+olsY57+0gJaOk05aj/hhknBwJxIkbaCiggq8wAPlD+zy6HBCP7g2JWNmAtB++R0O7Y9NU35Uyv1eoeq/4t5p4m5YZynUQ9oWT7Jtr3oFyMm4Vj9RdUIgCuwGfZKVVN0qcUWeRRFvbmFAz0ht8K8vGxbUbyTknEbEkj6OMqkmq8+GvNGwDsb+uIQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CYYPR12MB8940.namprd12.prod.outlook.com (2603:10b6:930:bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 22:35:51 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7409.053; Tue, 9 Apr 2024
 22:35:51 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, Jakub Kicinski <kuba@kernel.org>,
	Aurelien Aptel <aaptel@nvidia.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "hch@lst.de" <hch@lst.de>,
	"kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "aurelien.aptel@gmail.com"
	<aurelien.aptel@gmail.com>, Shai Malin <smalin@nvidia.com>,
	"malin1024@gmail.com" <malin1024@gmail.com>, Or Gerlitz
	<ogerlitz@nvidia.com>, Yoray Zack <yorayz@nvidia.com>, Boris Pismenny
	<borisp@nvidia.com>, Gal Shalom <galshalom@nvidia.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>, "edumazet@google.com" <edumazet@google.com>
Subject: Re: [PATCH v24 00/20] nvme-tcp receive offloads
Thread-Topic: [PATCH v24 00/20] nvme-tcp receive offloads
Thread-Index: AQHahozcRysz+cWAHU2c3JO56kkidrFavgsAgAKovYCAAyitgA==
Date: Tue, 9 Apr 2024 22:35:51 +0000
Message-ID: <838605ca-3071-4158-b271-1073500cbbd7@nvidia.com>
References: <20240404123717.11857-1-aaptel@nvidia.com>
 <20240405224504.4cb620de@kernel.org>
 <1efd49da-5f4a-4602-85c0-fa957aa95565@grimberg.me>
In-Reply-To: <1efd49da-5f4a-4602-85c0-fa957aa95565@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CYYPR12MB8940:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 mc55dr4IY25JLehzh0K0JgMFLNYDbETR/Da1HyciKWSDaKaj2l1NsVzFoYmhU+CyGnwOVFRu0I9TJe4rD9plpPFCjx43avCMsGQJqRHhUzV+2RPYxTJ2+aTNnRMqeM9bV035zl4FieqyYmc2LJG9FuiKa6cO5jRuFjrFnNUmjDjjqARIKZVGy+wMfPsNZsybfhsoytlfUHAPSNiHX0g3l7+XLjxATPtCihNjSU+nZhlRkdcuBFpHFqTTZgIp0ccirfVRjIJygD14c9oUpNkCxlA8Y9DGSnQUoBSn5s+TksXCLrt7KvcUH4z0DoRkFXmb6GUqcXvYYKxDyzctpH/PjG7c3MqDE/7EDH0ElZMlvC3uXR7Fm2F76OoEebYRuNUFlgYerQ3obhR7eSxpfmekrQOnP/PWCPp3D0UA7yVlZmEEma/VLIZnBssikTGRv7REUycJWbYAf35AmrJXyg/g5k1JEFrSCmnC6BQFsn7vhTG074/CM+dwKAkI0x/Iym2VNJGso2npDUatibhSU0h5eFsYZRS9X0JXtuYjO8Mhq98WL9HzFBKvuGWkinzUDe32S0wRTh/4bVJ4H419J3/N/aZ4jpeTvO4vtUS4kzYOpU0hjd+sPQ8QsrpmLbQLQi93nO4nMcJClw+KcbcNvERP7I6icBHRx2VwjZ3Dvr0+Q2k=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y1ViUVM3WjE5N0tsLzl3OFFEUmVWRGlqZlgwNFA2T0RPSDJUakxKVlVqampX?=
 =?utf-8?B?RDgrL2RXeGpWQVZQMGdrS0I0Rk5qZ3EzaWpBZVhUK3Q2Rnh2dEIzUVJHajNq?=
 =?utf-8?B?S01NTzNkYTBxc2tsWlRhSDFnZ1pYM0VUVVV0NWVLNWxaZXQyN0pqUGJVb2Rq?=
 =?utf-8?B?Z2tnNmYrOXl2Zk1DYjd5R1U3bUV4RXJjbkxKZDVVZVBSTWxYKzdEZVFPay8w?=
 =?utf-8?B?cGo1anhuMlR6RUZOUnhvcWZSVmdyc28yRlN1cEtSTWVSemJwUHBVNmIreXlo?=
 =?utf-8?B?STdqV0dnVnk0QVNScjF6MGFEL0drTTlOVHE1cDVseCtyUHVJZG1pTnFoSUNR?=
 =?utf-8?B?RTVIUGgwMDZ2NC91YmZIY1VBZHVRTUdJUnFCdmZJc3NJUHorSG4zakN4M1Ri?=
 =?utf-8?B?OXNudFF3dDZNalFJbkJXREtFYU44TjJiU1h0cHk5QkNaRGlPNlF1YVYwd2ZR?=
 =?utf-8?B?Sm5TTGpoSUVxOGUxS0o1a3lzTWZIQlVxV05XTS95bVhQWEtUQUJQRG4rSDl1?=
 =?utf-8?B?Qk95bTFFL1FOTEwzOU5FQStsNGhHdFdSK3ZIWGMwb01kVEdHQ0R6elVReVN4?=
 =?utf-8?B?Y3Qwemk5UGQ3cE5MOVJhdkVkVDlVbmZINlVzY21jL1VlSHRPdEFudnFoRlhC?=
 =?utf-8?B?NEhNb0R1dUNWQWhGeDBJMEcrQmw0dnV0UmxNVXlQU0VBL1JBcHQ0ZktsUzQ4?=
 =?utf-8?B?UjZ4Q1RFWnF1ZW9zeU4zMmtJd2hKdWJRemd5ZU1ZTU1jUTJwNHdNaU5VL1By?=
 =?utf-8?B?bEpHRmVNYk0xMzMwb1E0MlVCVDNCclpzWlhnVDB5aU82cVp1YUdOOEhOS0Ex?=
 =?utf-8?B?UnBGM0hXN1NCTjhVOXd3aW1tNUZXcEFoNlpoY3k4ell1SEdoSmIyczNLNFlG?=
 =?utf-8?B?OUNPbWk0Wm5FNlJ6bFhBcUpZMm9yQ2QvTkVBRzREN3BwUVRmRnk5ZGhNYUxv?=
 =?utf-8?B?SnpsZFRvNFk4aFNVYmxTNGlnUDhlTERiRU0rZnkwTnZxeVFmd3NkK3VFSFhy?=
 =?utf-8?B?c3NYeUs1U1MweDJvNEREWG1lVlNEOE42bUYvL3ptUE9PQWl2NGhvRGZPQ2VL?=
 =?utf-8?B?WkRPK3Z5bkcyNC9Jd2VTNkM1L2JTa3JhTXZ2WklEUk9XaHJoVEFkQnROeEkr?=
 =?utf-8?B?M0xEWmp0WUUvVW9RbWZleW5BZUFjNzZxV295ZXl0aVlTS2FzZ2tUS1YrbDRM?=
 =?utf-8?B?WVA4aXNUTTZrRkZIQkU5dEdyTkgxL293dnk4U2NHU1N1T3dic0E2NXNNVGtB?=
 =?utf-8?B?Qmc1d0s5VVkxV1l0NFNrOWFZT0JZTlpCMVNmTldYRmVTVmZMWTFDeVJPL1Fz?=
 =?utf-8?B?RE1WNWJMTnRGWjVWTS9BV2RlTTgwQ1lESEgzWUJBdlNkZm5LM2JMZmxqVzBl?=
 =?utf-8?B?cmRaZWJ2b1o0S1pKL1Bhc2ViNEU2blh3dVVvZDdNMXF3SisyS0tLZmN2Rm1G?=
 =?utf-8?B?OU51QVdVWlh3SlJvTHFyY2NGMWNtTXE2UEJoVTBPZmFDeTNWV1F0elB1dHk2?=
 =?utf-8?B?NUJqanNLQ3BKK3NJSG5DeE0vRlZjUWRzTjZoTzhOT2Eydzl4UW9LTHAvOVNq?=
 =?utf-8?B?Y2JwVHRoWmlJVm1uY09USWI3VTMwK09uUWhHYnQ3WnFjVjRhdUxOdFg3VUdo?=
 =?utf-8?B?dFFKUTFUQjhIQ3JkRFNZdmFZZXE4SHkvLzFLQnRRckZOTWg5TVkvRHE5MVBJ?=
 =?utf-8?B?bDB4VWdBbnhJWFNCMWVhQVM2WVRxNk5laCsxSmh5aC9Uc1hESVhTbm5OTlhq?=
 =?utf-8?B?T1d4eFlXMytvWm5ZdWhOVDBFc1N6RitzMkNnK01rRXdieU82c1lpNENrdnlt?=
 =?utf-8?B?Z29LSnJBVElBcDFJcXR0OHhJd2pKRFVQRTMvTkxMZVlpVmpzZzVkOHhtdjkx?=
 =?utf-8?B?MS9IL0ZCUkw0OHhaeDZFWFU4SGJBajg1dGNiNXltNE52bnNneldLUFpYeHZ5?=
 =?utf-8?B?dXJOejRyNVJxQW5rN04zcVlUeEM1YmpscUgvd0JacTI5QUs3MkNobngzdkVs?=
 =?utf-8?B?azBjdGxadjVLR25DUTVYYnJ3dXg0RUpaSDdOd01pbndxelRLTWZ5N1N1ZStD?=
 =?utf-8?B?QmtYZzJmQWhpMEZ1T1Y5cWJYazlEWndEZ3ZvRTRQcGVGSmNWSCt0M0d4UjBH?=
 =?utf-8?B?cUY0cnowM1J1MHp2Y2FjaXIxWlBNMWxSN3F4aGpqTmpMWG00OWtVdjhUYlBh?=
 =?utf-8?Q?7DxPG2VmLz947pFFxfmAlw2n/Ply7bCzUyFw/pP6X9kK?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7E9B9C28D9C3CB4780218DFE18266880@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ebd5807-e25d-4fea-38ae-08dc58e56951
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2024 22:35:51.7353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xgHvvU7yv+o2bgpepDO+UEgd6lwzWGlJuOeTFL3rYcsfLn+aaFL0WbsvmhvN9XmYPtISw+g+wIAoQ0ct6rz7zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8940

T24gNC83LzIwMjQgMzoyMSBQTSwgU2FnaSBHcmltYmVyZyB3cm90ZToNCj4gDQo+IA0KPiBPbiAw
Ni8wNC8yMDI0IDg6NDUsIEpha3ViIEtpY2luc2tpIHdyb3RlOg0KPj4gRG9lc24ndCBhcHBseSwg
YWdhaW4sIHVuZm9ydHVuYXRlbHkuDQo+Pg0KPj4gT24gVGh1LMKgIDQgQXByIDIwMjQgMTI6MzY6
NTcgKzAwMDAgQXVyZWxpZW4gQXB0ZWwgd3JvdGU6DQo+Pj4gVGVzdGluZw0KPj4+ID09PT09PT0N
Cj4+PiBUaGlzIHNlcmllcyB3YXMgdGVzdGVkIG9uIENvbm5lY3RYLTcgSFcgdXNpbmcgdmFyaW91
cyBjb25maWd1cmF0aW9ucw0KPj4+IG9mIElPIHNpemVzLCBxdWV1ZSBkZXB0aHMsIE1UVXMsIGFu
ZCB3aXRoIGJvdGggdGhlIFNQREsgYW5kIGtlcm5lbCANCj4+PiBOVk1lLVRDUA0KPj4+IHRhcmdl
dHMuDQo+PiBBYm91dCB0ZXN0aW5nLCB3aGF0IGRvIHlvdSBoYXZlIGluIHRlcm1zIG9mIGEgdGVz
dGluZyBzZXR1cD8NCj4+IEFzIHlvdSBzYWlkIHRoaXMgaXMgc2ltaWxhciB0byB0aGUgVExTIG9m
ZmxvYWQ6DQo+Pg0KPj4+IE5vdGU6DQo+Pj4gVGhlc2Ugb2ZmbG9hZHMgYXJlIHNpbWlsYXIgaW4g
bmF0dXJlIHRvIHRoZSBwYWNrZXQtYmFzZWQgTklDIFRMUyANCj4+PiBvZmZsb2FkcywNCj4+PiB3
aGljaCBhcmUgYWxyZWFkeSB1cHN0cmVhbSAoc2VlIG5ldC90bHMvdGxzX2RldmljZS5jKS4NCj4+
PiBZb3UgY2FuIHJlYWQgbW9yZSBhYm91dCBUTFMgb2ZmbG9hZCBoZXJlOg0KPj4+IGh0dHBzOi8v
d3d3Lmtlcm5lbC5vcmcvZG9jL2h0bWwvbGF0ZXN0L25ldHdvcmtpbmcvdGxzLW9mZmxvYWQuaHRt
bA0KPj4gYW5kIG91ciBleHBlcmllbmNlIHRyeWluZyB0byBtYWludGFpbiBhbmQgZXh0ZW5kIHRo
ZSB2ZXJ5IG11Y2ggdXNlZCBTVw0KPj4ga2VybmVsIFRMUyBpbXBsZW1lbnRhdGlvbiBpbiBwcmVz
ZW5jZSBvZiB0aGUgZGV2aWNlIG9mZmxvYWQgaXMgbWl4ZWQgOigNCj4+IFdlIGNhbid0IHRlc3Qg
aXQsIHdlIGJyZWFrIGl0LCBnZXQgQ1ZFcyBmb3IgaXQgOiggSW4gYWxsIGZhaXJuZXNzDQo+IA0K
PiBFc3BlY2lhbGx5IHdoZW4gbnZtZS10Y3AgY2FuIGFsc28gcnVuIG9uIHRscywgYnV0IHRoYXQg
aXMgaW5jb21wYXRpYmxlIHdpdGgNCj4gdGhpcyBvZmZsb2FkIGF0IHRoZSBtb21lbnQgKEkndmUg
dG9sZCB0aGUgbnZpZGlhIGZvbGtzIHRoYXQgSSBkbyBub3QgZXhwZWN0DQo+IHRoaXMgaW5jb21w
YXRpYmlsaXR5IHRvIGJlIHBlcm1hbmVudCkuDQo+IA0KPj4gdGhlIGlubGluZSBvZmZsb2FkIGlz
IHByb2JhYmx5IG5vdCBhcyBiYWQgYXMgdGhlIGNyeXB0byBhY2NlbGVyYXRvcg0KPj4gcGF0aCwg
YnV0IHN0aWxsIGl0IGJyZWFrcy4gU28gYXNzdW1pbmcgdGhhdCB0aGlzIGdldHMgYWxsIHRoZSBu
ZWNlc3NhcnkNCj4+IGFja3MgY2FuIHdlIGV4cGVjdCB5b3UgdG8gcGx1ZyBzb21lIHRlc3Rpbmcg
aW50byB0aGUgbmV0ZGV2IENJIHNvIHRoYXQNCj4+IHdlIHNlZSB3aGV0aGVyIGFueSBpbmNvbWlu
ZyBjaGFuZ2UgaXMgYnJlYWtpbmcgdGhpcyBvZmZsb2FkPw0KPiANCj4gQWdyZWUsIGFsc28gZ2l2
ZW4gdGhhdCB0aGVyZSBpcyBhbiBlZmZvcnQgdG8gZXh0ZW5kIGJsa3Rlc3RzIHRvIHJ1biBvbg0K
PiByZWFsIGNvbnRyb2xsZXJzLCBwZXJoYXBzIHdlIHNob3VsZCBhZGQgYSBmZXcgdGVzdHMgdGhl
cmUgYXMgd2VsbD8NCg0KYmxrdGVzdHMgc2VlbXMgdG8gYmUgdGhlIHJpZ2h0IGZyYW1ld29yayB0
byBhZGQgYWxsIHRoZSB0ZXN0Y2FzZXMgdG8gDQpjb3ZlciB0aGUgdGFyZ2V0ZWQgc3Vic3lzdGVt
KHMpIGZvciB0aGlzIHBhdGNoc2V0LiBEYW5pZWwgZnJvbSBTdXNlIGhhcyANCmFscmVhZHkgcG9z
dGVkIGFuIFJGQyAoc2VlIFsxXSkgdG8gYWRkIHN1cHBvcnQgZm9yIGJsa3Rlc3RzIHNvIHdlIGNh
bsKgIA0KdXNlIHJlYWwgY29udHJvbGxlcnMgZm9yIGJldHRlciB0ZXN0IGNvdmVyYWdlLiBXZSB3
aWxsIGJlIGRpc2N1c3NpbmfCoCANCnRoYXQgYXQgTFNGTU0gc2Vzc2lvbiB0aGlzIHllYXIgaW4g
ZGV0YWlsLg0KDQpXaXRoIHRoaXMgc3VwcG9ydCBpbiB0aGUgYmxrdGVzdCBmcmFtZXdvcmssIHdl
IGNhbiBkZWZpbml0ZWx5IGdlbmVyYXRlwqAgDQpyaWdodCB0ZXN0LWNvdmVyYWdlIGZvciB0aGUg
dGNwLW9mZmxvYWQgdGhhdCBjYW4gYmUgcnVuIGJ5IGFueW9uZSB3aG/CoCANCmhhcyB0aGlzIEgv
Vy4gSnVzdCBsaWtlIEkgcnVuIE5WTWUgdGVzdHMgb24gdGhlIGNvZGUgZ29pbmcgZnJvbSBOVk1l
wqAgDQp0cmVlIHRvIGJsb2NrIHRyZWUgZm9yIGV2ZXJ5IHB1bGwgcmVxdWVzdCwgd2UgYXJlIHBs
YW5uaW5nIHRvIHJ1biBuZXfCoCANCm52bWUgdGNwIG9mZmxvYWQgc3BlY2lmaWMgdGVzdHMgcmVn
dWxhcmx5IG9uIE5WTWUgdHJlZS4gV2Ugd2lsbCBiZSBoYXBweSANCnRvIHByb3ZpZGUgdGhlIEgv
VyB0byBkaXN0cm9zwqB3aG8gYXJlIHN1cHBvcnRpbmcgdGhpcyBmZWF0dXJlIGluIG9yZGVyIA0K
dG8gbWFrZSB0ZXN0aW5nIGVhc2llciBmb3LCoG90aGVycyBhcyB3ZWxsLg0KDQpIb3BlIHRoaXMg
YW5zd2VycyBhbnkgcXVlc3Rpb25zIHJlZ3JhZGluZyBvbmdvaW5nIHRlc3Rpbmcgb24gdGhpcyAN
CnBhdGNoc2V0IHdoZW4gdGhpcyBjb2RlIGlzIG1lcmdlZC4NCg0KLWNrDQoNClsxXSBodHRwczov
L2xpc3RzLmluZnJhZGVhZC5vcmcvcGlwZXJtYWlsL2xpbnV4LW52bWUvMjAyNC1NYXJjaC8wNDYw
NTYuaHRtbA0KDQo=

