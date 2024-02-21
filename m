Return-Path: <netdev+bounces-73565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4889985D21A
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 09:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1EE1B263D2
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 08:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE0D3B1B7;
	Wed, 21 Feb 2024 08:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YxAbZNKU"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494523A269
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 08:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708502766; cv=fail; b=GgV2hcOBnqvz0wKYYj7tkjSNWoWHod5/Hqqux5sNOcISFjDkDULo6lMwR3ZHGOrS0RXY20q4wj9zoDV5VxIxUhGvO+xeMZuH4RMi1Rbae2LDrvDHaXr8OynGaCv03fdB3yJcZBF63cvyVtx6yweeA9R8IOtEd7e8YltznPiHd00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708502766; c=relaxed/simple;
	bh=cPHniJNuu/N1TbV776bDT/qKqLgUeCp5l86TAxysWWk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nw0m2secILQqZS1zbK6s9MH6fx7PHXNdZQIeM8cw4MchUY2eVuY+dxHFRnGqPeutGOeHAaZWWWjuNAEXtSlAHZPa0ZKhviEEm734BUByNLD9Y3OQuA2klP/GZUlD1cVG+ERbPeNx39NjBxiLhYrTJZboXvT6E2UZNUZU419IGWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YxAbZNKU; arc=fail smtp.client-ip=40.107.93.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HEwJhvA4zyW0rrO6fGy767k0Fh3ldSUnvDNQH+aqUFvNEzUF/fxPljOFlbS103PIih+1V7m666dQ0Fwa9BWX+Edj518cSYqnG6/R28RtCVOPpb/aSQePW1m4cGiKZ5UJ5eQGh81Q1/Rq11DnUgXLNev4aLAlWofTswkZ4b6D2vW6uyTIR+CWUKmZGfqVW5TKey6NmnTZLm+1VZhJ/+25NyZdufpfa2xVai5Dy+NPlGYnlaTpoitySN/3OYvuSn1jP3n30yZV0PfpyqoZgy83z/M3/Usw/5sPmCGclJm6iCQ/Hk9xoeLMy8IJhDgXk3LCb5NokXEcGrJTwC8w3AZBSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cPHniJNuu/N1TbV776bDT/qKqLgUeCp5l86TAxysWWk=;
 b=cPCp21tbmT734HT/CgFRbHB4jLRpf8DUW7kt6VMYxK+ZC87nmOmaVTQXubPvjYcZq5Q5d2fGRucbATo+LIdWST1WW/G9ahIUah+CruJfKL9MqQ8gUryf21jWTeIOImE5Mi9r1ubvLDLMcUT4Uhj+RePPUt4DVgnoyZvlBuSVIgA3laj9yG2Ay1EcFhx46fOpYsDvuCBug5NQLWW6XjQOqXhzx2XWcVNRA3UX0d3wQADpeVQJrT8lnAqwsJRD/WgpmbpQazNpse/xc0mzTF0wDHcBcqR5AxD7s8rP9JjcotyaRWP5r0GhDdCrvcmhByxW8jCz9Zj1gqx4ALUnOMoYWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPHniJNuu/N1TbV776bDT/qKqLgUeCp5l86TAxysWWk=;
 b=YxAbZNKUR1735CGBvvvQsjoh/Vi3/7vP16A0fumIoxqHPLmTKR7ig69AA5IApmgvU5iVHMaaAUb4mHsXO7L27Gb1KNKB6pQeS9WOCY8GlCZJBhXjx6z/RmfV+pDMM/spAwKatxzwmsqJsY+SfQdRyuQDIlhC4j1z+02b6VYXmfZWUNir3JCRXsSE9A9TC5gCUxEPFA4kkaiMXj9wrCokGvusYIbNS60+YKdHBAj1J1Pi3EpRKlFIzYrw/WS6fkpGigxiZIaGNvAlYMDoht5cF/Wd/k3AF3R3wB4Sm2cwAx/Ulm7a2+IXDf+POeg6il7IMhl9ags2Hu09kaYbRXVeQA==
Received: from IA1PR12MB6235.namprd12.prod.outlook.com (2603:10b6:208:3e5::15)
 by CH2PR12MB4277.namprd12.prod.outlook.com (2603:10b6:610:ae::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Wed, 21 Feb
 2024 08:06:02 +0000
Received: from IA1PR12MB6235.namprd12.prod.outlook.com
 ([fe80::28c:5598:4f74:aeb6]) by IA1PR12MB6235.namprd12.prod.outlook.com
 ([fe80::28c:5598:4f74:aeb6%5]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 08:06:02 +0000
From: Jianbo Liu <jianbol@nvidia.com>
To: "jhs@mojatatu.com" <jhs@mojatatu.com>, "jiri@resnulli.us"
	<jiri@resnulli.us>
CC: "davem@davemloft.net" <davem@davemloft.net>, Gal Pressman
	<gal@nvidia.com>, Paul Blakey <paulb@nvidia.com>, "marcelo.leitner@gmail.com"
	<marcelo.leitner@gmail.com>, "xiyou.wangcong@gmail.com"
	<xiyou.wangcong@gmail.com>, "pabeni@redhat.com" <pabeni@redhat.com>, Cosmin
 Ratiu <cratiu@nvidia.com>, "edumazet@google.com" <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "horms@kernel.org"
	<horms@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>
Subject: Re: [PATCH net] net/sched: flower: Add lock protection when remove
 filter handle
Thread-Topic: [PATCH net] net/sched: flower: Add lock protection when remove
 filter handle
Thread-Index: AQHaY9s4JHkKiuKRVU6a5Dyx4+PsiLES84YAgABd2ICAASA6gA==
Date: Wed, 21 Feb 2024 08:06:02 +0000
Message-ID: <6192a85213d3d7e176d66564c324d71543ae6737.camel@nvidia.com>
References: <20240220085928.9161-1-jianbol@nvidia.com>
	 <ZdRuJuUKALW1Xe9Q@nanopsycho>
	 <CAM0EoMkYFtP4UTTQOwhz=mfzVbVuwo0Ra1zSv6bqG8M4tzVzSg@mail.gmail.com>
In-Reply-To:
 <CAM0EoMkYFtP4UTTQOwhz=mfzVbVuwo0Ra1zSv6bqG8M4tzVzSg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.40.0-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB6235:EE_|CH2PR12MB4277:EE_
x-ms-office365-filtering-correlation-id: c7bb12ba-fd8e-4940-09e3-08dc32b3f21b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 6opXvqG8So3h9vD1Gsp9Jt4Ls9hB6g6AedkgCUooRu3o0zv06VXgm7ZJaCWkrWoGGDaMhaG7PvfIrMjo63ZHRiPLpvGo/CfKqv1mFmtTd9vkjmmibGttRXpve8HRmodjZXOn5KpuWAlkSIlBrQMBrJI8KiMSACRz3adxDbQiG5YDBFYEg22MMGkgnLDfiqUwG4Wau8JcqB8/uTODk6Mb+v9Id4KqwFFkwg6qSkcRSTtsMmDZnXjbO4fPtcJaG8jabn5JrdWSmoQFN9uwFTbohZRYqhdadI18UKUGhR+bg8l3REnznK3y9UxKdTv45buBynlNEUFF4i0JIdigV9wx9JFYDay5f3I5UvBAgf2LyKVc4ldd0iRHChxY3KxfNLmNuXtkVdbgRBmjCQF5dDClypqyo0fJFnffLZlk6tdVDv1t5o41yeroE5LRG1Hrx99Ru6uvI/WeCxRbygztl4nNtYXJgw0oZDpuEY0qotQMvgQnLHpDm8jewwdj0A4PpKcKvMtBs44rQIPCJ4y+ffsLS6tjuhq4xcTw2bQ8rqy0mQ86kk0SSn7AFkOn+8op8ENJPrcNX2WCeJnRA6Vfjv4kW9aBq0RD6C257cgHy3E49dj6OKLb9d/zx4RmgnurOXHG
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6235.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Sk01UkxDZHRuOCs1dEEyRE8ycUsvcGhPZWlHWUt1RHQxNUNPZVRMaDZpcE5Q?=
 =?utf-8?B?VUpRRzQwSGljbkxNQVFOWGFZUE9IRVNtNDc2bHh5OXBuRzNNRlg3YlZieDkr?=
 =?utf-8?B?bjdRd0xvVDhDZEY4Y3hZcU9YZ2x6NzBoOWR0Q3g5MHo3QVFpeFBvUXVEUWNR?=
 =?utf-8?B?MlV3VE5RTGxtS1RsSGYyVCswZUs0UG9CcnR6dVFuaDhZOXZFaS9KQ3lFVjNv?=
 =?utf-8?B?cjE5RXBtTS9RVkFsRXpwd05TYkluZjhpK1ZqWFhJRUwrNUwzZFJ5dzYwK09s?=
 =?utf-8?B?T0Qrb0VtcjE1OVJMbnVCRzArZklZb2l6K2lEdk4ycVNBSmExalhzNmdOcks1?=
 =?utf-8?B?UE1UNXY3cTlTWExsbWFneUFWS0h0Zkc5SnZ0S3kxYnlxei9DQ3NOTEY3eWV2?=
 =?utf-8?B?TVZXbXJ6aTdLbDYvdHQ0S24rcFV2MXVNTGNBcDlEN0o3Vnc2clJkSjhRQW5B?=
 =?utf-8?B?cXlaejArd055blBJeTlKNWIzRndxS0tjSzlVOE9hdXp6UzNNbk1mNVJBOExC?=
 =?utf-8?B?bW5RTWwwdklRWDh4cjAvTVA2TmFmSUg3SFpDWUpvM1R0ejZoUWZGMTQvWGFQ?=
 =?utf-8?B?OGI2TlQ1MFh6eHRHRmRRT044ckdRdkMxb045V2FZVldzRG9vRi9hTG9ZbUha?=
 =?utf-8?B?dG1kT2U5eHBFSjArSXdtZE4ydDR1MU1pT1VYRllWamhaVFZTK3NhMVc1UlNQ?=
 =?utf-8?B?MlN1VUdBSm94SUZwQlp3RUNLc2F0WDFPalVXaElsWWJoc3dyR3dEM0c3TFJr?=
 =?utf-8?B?ZGVTaUJtVFM2UzhNdUdlRlRCZENaOXo5SDZUTGsvN2FGbFJIVE9aMGNWZUhm?=
 =?utf-8?B?TU5LaTh4QXBBb1FSRzk4OUplbnA1MEI1a2RjSGxZVUZxdFozMGNYRGdseGJU?=
 =?utf-8?B?U0V5VEJGa1JHYVJCZis3aVBTV1dOTkx0bnN6Yit4WFAwOUZKZnFlaXVGbFBM?=
 =?utf-8?B?dXlsSGJBNlNSNVBWbVZiTWs2OEpkWllKdXpBTW5SYUtRMjF0UlZQY0JnTGdV?=
 =?utf-8?B?RDZpNFlIbEkybXIrQ0Y2bmpNcjJCLzlUS3VBbWg5T3Evd3dKSWY5UjBScm1I?=
 =?utf-8?B?dXlYWHd6djYyVlNDSy85cDRHUU9sdDYycGkyblQrSjZKNS9xZWlNZGdsNFNK?=
 =?utf-8?B?WHZRMXhBeGtJejhLNG9CVXFsa0xQcDZvd3Y3T29yMjZBaC9Cajg1S1pEYXNN?=
 =?utf-8?B?ZzNNc3dUMTVJV09MNGFPdVg1NzJSSGJkK09oU00vVGxoU3kzcExDeG90ZURs?=
 =?utf-8?B?U05LR1dLYTZKVzE3cDI5dEhXVFJQTktxejlOTHg1WitOcmN5SE9qN2NPazVP?=
 =?utf-8?B?ampMcm11MWFkZ3d0VzhKNUxZR200TklYczc2YWVBKzNuME1SUUo0QUdaa2Q4?=
 =?utf-8?B?Wmx3aFZreHZYaTF6M2R2ZGd4anJ4bExGbU8wNVRHTjA4RlNHWmE2Ty9YcGhB?=
 =?utf-8?B?MkNaVmlkTVFrbVZzWXRKN0xDMHFoNEhVOWdkZWJwZDg0WFF0M2JaNC92K1lT?=
 =?utf-8?B?SkFNUkp4clpkV0VBQ2QwUEhEYjVISGw4bVM1MThGc080K0FMbGh0MzBPbm9Q?=
 =?utf-8?B?OHl1MysvclF3cE92MHJpWWNPNXA4M0RHUmdrbVBNcjgrU1hGbkRLY0ltQitv?=
 =?utf-8?B?VDZRdVpmZ1h6UTNPcCtPSlFlKzVQK05TQzhuNCs3di9OTXdEblRUbmRPTFZR?=
 =?utf-8?B?REF0TWNMa2dhZ0w4WGt1VlNxekdSVnlQenZKZDdLOHpiSExkVXZnT3FvOHlS?=
 =?utf-8?B?UzBtU3VRakViM0l5M2lneUFFZEdwNlZkd05JWVNOREFTMVVuZzNsTEVrVEdW?=
 =?utf-8?B?MU1YQW9BRWNQYUN4L2d1eldDcm5SY1hwMzUxQ0MyN0NwMHVIazIvTURTWUpY?=
 =?utf-8?B?UDZSeGlIS1FFRysxak45d2dwNWJmUDVhMXJsb3ZtSHkrMndEVytZa3NmZHVo?=
 =?utf-8?B?R01OOGpoQmdPK0lyOEN2enMvTEpNQnR2c2lMT21BK050SlM1QmlnWVVKcmZP?=
 =?utf-8?B?OVdDRzZSTEpiMktzcmlZamJLaWh5VHNhK1NQTVQ5YW84Y3d4NHhCVWZmV2FH?=
 =?utf-8?B?R2FZNEd3MFZiekF2L1B5ZzFrOXJ6NXlDTmRmT3l4QUZ1YW1NWU5GTHA1SGZJ?=
 =?utf-8?Q?Hy4DKtpWjFQuyECY0e1DpFEkH?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <178480036E1B8743AC2D176A68104C66@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6235.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7bb12ba-fd8e-4940-09e3-08dc32b3f21b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 08:06:02.1730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dbiQeExNNR2m5X2WUCGnrKAFk3mYPetL+b/I5QVV8U20Hr6sLR3b3KolLzDLRfF9yhtRRMtTiwuWO19RF1gZ7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4277

T24gVHVlLCAyMDI0LTAyLTIwIGF0IDA5OjUzIC0wNTAwLCBKYW1hbCBIYWRpIFNhbGltIHdyb3Rl
Og0KPiBPbiBUdWUsIEZlYiAyMCwgMjAyNCBhdCA0OjE34oCvQU0gSmlyaSBQaXJrbyA8amlyaUBy
ZXNudWxsaS51cz4gd3JvdGU6DQo+ID4gDQo+ID4gVHVlLCBGZWIgMjAsIDIwMjQgYXQgMDk6NTk6
MjhBTSBDRVQsIGppYW5ib2xAbnZpZGlhLmNvbcKgd3JvdGU6DQo+ID4gPiBBcyBJRFIgY2FuJ3Qg
cHJvdGVjdCBpdHNlbGYgZnJvbSB0aGUgY29uY3VycmVudCBtb2RpZmljYXRpb24sDQo+ID4gPiBw
bGFjZQ0KPiA+ID4gaWRyX3JlbW92ZSgpIHVuZGVyIHRoZSBwcm90ZWN0aW9uIG9mIHRwLT5sb2Nr
Lg0KPiA+ID4gDQo+ID4gPiBGaXhlczogMDhhMDA2M2RmM2FlICgibmV0L3NjaGVkOiBmbG93ZXI6
IE1vdmUgZmlsdGVyIGhhbmRsZQ0KPiA+ID4gaW5pdGlhbGl6YXRpb24gZWFybGllciIpDQo+ID4g
PiBTaWduZWQtb2ZmLWJ5OiBKaWFuYm8gTGl1IDxqaWFuYm9sQG52aWRpYS5jb20+DQo+ID4gPiBS
ZXZpZXdlZC1ieTogQ29zbWluIFJhdGl1IDxjcmF0aXVAbnZpZGlhLmNvbT4NCj4gPiA+IFJldmll
d2VkLWJ5OiBHYWwgUHJlc3NtYW4gPGdhbEBudmlkaWEuY29tPg0KPiA+IA0KPiA+IFJldmlld2Vk
LWJ5OiBKaXJpIFBpcmtvIDxqaXJpQG52aWRpYS5jb20+DQo+IA0KPiBBY2tlZC1ieTogSmFtYWwg
SGFkaSBTYWxpbSA8amhzQG1vamF0YXR1LmNvbT4NCj4gDQo+IEppYW5ibyzCoCBkbyB5b3UgaGF2
ZSBhIG5ldyB0ZXN0IGNhc2UgdGhhdCBjYXVnaHQgdGhpcyB0aGF0IHdlIGNhbg0KPiB1c2U/DQo+
IEp1c3QgY3VyaW91cyB3aHkgaXQgaGFzbnQgYmVlbiBjYXVnaHQgZWFybGllciAoaXQncyBiZWVu
IHRoZXJlIGZvcg0KPiBhYm91dCBhIHllYXIpLg0KDQpJIGRvbid0IGhhdmUgdGhlIHRlc3QgY2Fz
ZSwgc29ycnkuDQpUaGUgaXNzdWUgd2FzIGNhdWdodCB3aGVuIHdlIHN0cmVzc2VkIHBlcmZvcm1h
bmNlIG9uIEJsdWVGaWVsZC0zLg0KDQpUaGFua3MhDQpKaWFuYm8NCg0KPiANCj4gY2hlZXJzLA0K
PiBqYW1hbA0KDQo=

