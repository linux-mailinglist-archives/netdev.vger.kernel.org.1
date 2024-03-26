Return-Path: <netdev+bounces-82141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF8888C6A4
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 16:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAC8C1F2BDD1
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 15:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914D513C811;
	Tue, 26 Mar 2024 15:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VgjFC/Wt"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A000712B82
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 15:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711466288; cv=fail; b=bSM9mepa5UJDgHESTaVSeqrTgAknw3jo9tHnGahVMV/C5GxC+wKp5G31DvzJzVpyElV9vGbjWZWRLgFmRL6SDsJtM7TsMxzF1RIUsRvn9ahbAnmS2cFEcsLJxOv1onlI5g0YokE8Jlc8VZLOdqC1nXjIhLykeO3W0oLntIK2fks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711466288; c=relaxed/simple;
	bh=2Zt+CO8q26SY3Js32PcOJMUGCeGi1XuODinxsIfAdnw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VOzQLBbb+vLycxBynFRAc0RBcbsU8Gl4/qYTnvVNzKodW6ytB8R7IKkc9XuQD7UuErhnKzBBNahFkMa2VgXuT2GVbV3lq258x2BNz7bBgyY+udEu6v1ikNJbmSeylzGgv8wb9OsC2R1q2mLfgFOqUmm69UQPZufpegtDl9vINfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VgjFC/Wt; arc=fail smtp.client-ip=40.107.236.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEjf9EXYAmK318IKDQMCMAOEuR4SmnTUttqIlguFaUmmaPRrsB9GjdvTGgKlMD3Aht6KNnKSIqZVZOfKxxV1KbHOLlVGLczkX974QQktwAh1ipbOheVjX0wbVQC0foSqbGdFkoyJmoYWmtzaNThgm+ddBexdYJECFHm2GTaIV5mGU+ymBhM9W85zDjHn620Pq9OGGjl2CXxEbA82J9LCZ2DCJshqyX99KqlqtCW/5TxvxOvsEG1BqJ2m0LfsgXSeawsQHT79KdSywlOTL1GuK/R1Kkpc78+6aV0QpGLXDAQ8qm2+ZgoeT/43eTA9KhDeibhFndDpNcHcXo2qurHLDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Zt+CO8q26SY3Js32PcOJMUGCeGi1XuODinxsIfAdnw=;
 b=Ny2R31gUCO3p6VTr39Tmd88XtlcXy2J1+c0Md47o2XjtxWr15EJAVR1Kb4u3l8MsR8WHdzkeUTl8jFPFCGWvVY93uahPwrKUpzKMUEvw5vnkZ5C8EngeOa99/92XqYfIVZ0LuW2le2RmhN0Ff8RHOofAs3wufNhWNuzYaGMt6eF56/5LCs5QAJ/TOKrwg5nAGFw7u3vT/b5YU4ERzWNC2fiBXD40qYb+7z1P4o9NPKF7fjXLp9JXMlYxt4vQ7RfHdr2IO7lczaNo/aioPNWnUv4Sway5VG+a3yjHxoEOf9GzjXdG8ni/aHW01x/+nb1idxZ62v6kE6Jvd4v6ZtHlQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Zt+CO8q26SY3Js32PcOJMUGCeGi1XuODinxsIfAdnw=;
 b=VgjFC/Wt4dufLTrXDAz3HyJ9yztbRmnIXgyWxyLfItA1zjSmRQDhhiTyDkbZCNJGNYTaf4mnU+x3zYU9N4Q6SCKYo7FNepQgF+WdRkUZ8oQbYN9fyvQ38teR3wVbdJVf38GzL4Sq3WvhyjdhgqdLq/LfEz1ZL5Jy9H2Xrk6ymIcHs1Fk4dDQhXX88+8uLyBnj3PxzH3C62gnLLGheVZmso8fO/KEYk1Haq6P9Xzt3GqW95gg11Gbt4zeek1n0+rcp/PZzLAv5RakwfJyTyz/o451VSX9Ax1TGnrlHBrS4a0K7msP5HaP35QDuwaeSgep4tLzJKATrpcRc14fPXpedg==
Received: from CH0PR12MB8580.namprd12.prod.outlook.com (2603:10b6:610:192::6)
 by DS0PR12MB7631.namprd12.prod.outlook.com (2603:10b6:8:11e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 15:18:02 +0000
Received: from CH0PR12MB8580.namprd12.prod.outlook.com
 ([fe80::1393:fbb3:2410:ca37]) by CH0PR12MB8580.namprd12.prod.outlook.com
 ([fe80::1393:fbb3:2410:ca37%5]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 15:18:02 +0000
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
Subject: RE: [PATCH net-next 4/4] virtio_net: Remove rtnl lock protection of
 command buffers
Thread-Topic: [PATCH net-next 4/4] virtio_net: Remove rtnl lock protection of
 command buffers
Thread-Index: AQHafv5dTvMzUMc+JUiekGFnQ6Veq7FJuIsAgABjQSA=
Date: Tue, 26 Mar 2024 15:18:01 +0000
Message-ID:
 <CH0PR12MB8580B9701C9BD0B62FF04B77C9352@CH0PR12MB8580.namprd12.prod.outlook.com>
References: <20240325214912.323749-1-danielj@nvidia.com>
 <20240325214912.323749-5-danielj@nvidia.com>
 <11b6dac0-a18a-47ae-904d-cb9d29e1ca31@linux.alibaba.com>
In-Reply-To: <11b6dac0-a18a-47ae-904d-cb9d29e1ca31@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB8580:EE_|DS0PR12MB7631:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 EMipLaAVd4uQTuqw7ADpVhxpAnF2UbMk6ODsgrhwY0heIHffaVS5IjpF2KiXJn1+HC+GSHWURI81HqP2cPgOf0vwZDrP8L+xHl99EyXVVwZjBQ6D2E7fnfqVocQOvGkaw0F8w9qU2XxJHCiXxocHoryAHYaPagEx9t7MZd2txEzSrfp6Dgt2q779HnehYP22W8wbR7mmre1qsbRHF8rPUmusjLUS6liuFYtyQ48ZXrT4FN11dAuuc5wr/odZa8ChYmLCkgLH4iedhIfP9KrPfg+h1Vkrw5o+lFt6MdxJQ9bJTg+BW51QhlT8iyYXuLWBPiX82kwB7+6yBFWEbRgnPtV9FaN4RWBQPUePOLas47fdfocFD9LUcSZ3najlxFq0kZescbjkPOMyfLY3f8GDrL16LO5N3TFkT6P3Sa3JeCkFaCsNrsRD5nBqii4UA4PKZRT6lwNxS2sIWjtqFBWGZUQsU2Z0Jrn0NeXL8/Eoe6Kb5aPfDNdTvObPVwTwn/Ixa0D1fzAOBb3+qm+gBgxuid3zkLzXz+ntBDjj2NiWCF9UFZff00YY50OZxXLdxItMG4d3PTd7CCc+C66OoaL7DvBkLZIRw39YhFCIZgb5agJVLxclSIovfgKtC9wHx7Z26RsYye5BLQXS9yf4HCr+7Io5BdoT4Yo5wmyIpdCEv18=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB8580.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cVpSbGNmS1pseW9udGg3UmFOVmxxOC9pSTI3WTVnU2I1dGtHSTBjL2REMkZZ?=
 =?utf-8?B?NnpwdlF5UkJCTUNFSG5pcDJ3QlJjTmZ4Wm93Z0h6M3BJZGRsd1ZJQ1BYVmMx?=
 =?utf-8?B?eS9ObnMwbnJIVFY5NVZscDloeEEvZ1B0cVEyTDkxSnBnRmxCSGd3REx2a1h3?=
 =?utf-8?B?QlE0TDFJQ0x1RWxlcFl3MG5rRXl3bm01dzg1TEdzQkpTb1NBeHlyUmt4bW43?=
 =?utf-8?B?V1dGOGhPWUIzYVlWU1RONjBRUVlXNG9mOG1tK2l2d2VUTnVaUjJoSFMyMW5U?=
 =?utf-8?B?NUVrN3E0L213Ti8vWjFpckE1Z1VSMkE5cG5pbDRPcEtZcFBQYlV3bTd5dkNo?=
 =?utf-8?B?aThHWFdRdW1DcXBscmVTb21kdU52QktNdE5rbGhOajNiNit5STE1TFFBdEly?=
 =?utf-8?B?RFIvNEhkU09JNEVEOHhjYkFJaVk5THRqWDVuM3BlV0txaERvSmlPUzZTdHNH?=
 =?utf-8?B?cEVYVlZMR3Z6RTZrTXdkTHF4eFNNU05FcTFtbDNwUHhqeDlORGpNMWJYUUFy?=
 =?utf-8?B?VmZ0V0pkRFROeGk1NlMxaTZwaHhRNjdyQ05yQkRzUzVpaVErczRXaEVWa21q?=
 =?utf-8?B?blN2ZDQ5bHorSUNUN2hQem1mcHV6TGo2TmlJbzZmYTZBcnRUb3JONWVpU3RP?=
 =?utf-8?B?aGsxSGhBcFZOSXVvQW1lUVlXTmZJWW1WOWVXZzM3SktFWWo5emZTQXJZMGxE?=
 =?utf-8?B?emVJTEU4MkY1WnJ4b2hSZjQ5MS9ZTWsvSkpOQU9rZExyUUgvT1VJUXBMaXVG?=
 =?utf-8?B?Z1FQem5pM2t0VC96M21vdDBKWUdrbzR4OHJ4ZVdkMjVpdlBNY0ZVRU5TWVFi?=
 =?utf-8?B?UmFrMUdhOFJkcTdYL2RvVldxSUNtVTVFQ1p1V1c5cll6ZTk0TVZYZVh3THNI?=
 =?utf-8?B?U1RjNlUrTE5QaDYyaWtDSnFUTzcxaE90dGJhaDFvdDc3SzNyU0xjb0xwdG8y?=
 =?utf-8?B?SFVNMityeFZJMzlLUnNBSTBLalpMNVFVNkJCWm8rcGVMNHROMTJYYW9NNmpS?=
 =?utf-8?B?MGQxdm5FVWRocWVoeXRZb0pldjBTaFRlYUxqbHVMSWx2Ly9vYWE0OXVHQVYv?=
 =?utf-8?B?RTZPYkdCdytVT3FUNE9WUUhNVm9Ibk5nb2FMdFBEeGtlMFhIdDVIR3BDWkZM?=
 =?utf-8?B?YnV2dDBFaTNqaTFzTG9uQzlZd2lsN3pwK3dKNmxXVUhCS1dpRkNvK05oRnJF?=
 =?utf-8?B?WmgyanJQN1RnVW1EWno0ZGhrcmFVUTBSTktXRTFDc0M0Z0dRdmltcmtrWEVK?=
 =?utf-8?B?RnFzY3oxNmlzMFIzanFLa0dJRitOaVhaWll5b3NvOTJKbjRYRHYzR2xmV1hR?=
 =?utf-8?B?d1RWUmRubXE0aEJYK2U1eTFkaHBmSjdkSU9VNTBUT2RJblBEbjZ0OWxDeml4?=
 =?utf-8?B?UkJLbTZhUEJMcW5Vd1Vkek5mSDNuREVKUkkyY0VXK25ZanBjUCtJWEVTaElG?=
 =?utf-8?B?WkoxTlIyWmdqYXNxeVVuOVVnMXdzV0hGSUQwUDI4OTZ5NnhXUzRmbXZMK2t5?=
 =?utf-8?B?WXBkVWNVMVY5N3JjV2lZSVM1MnE2YWdEUVBsMjk4cDNOSHMvTXBvUldNSlZN?=
 =?utf-8?B?WkIvV1IzSXBLWTRyTGZJcDcxMTIrWnA0NVlwZnJKdjNvWTBZQ29NVk1EUlRr?=
 =?utf-8?B?NjFEWVFpaGc2M3VJT0lRYU11U2RoeWVSOWxSU1ZVV2JhVWJiNThiUHFYVExU?=
 =?utf-8?B?QSs4TkIyNHFIREVadE9WcDR3b3lHa2NERmFDOEE1Nld0R3NVS1BMalpzMGVq?=
 =?utf-8?B?Ukx0UHIycGxxYXZUNTNwVEx2czQxYUV0QzJSZlVNRGhwY0dJQlhxYWJJTCtD?=
 =?utf-8?B?eUw5OEtFVk5MM2JVMm8xMkxlNjBqMzFtdkE2Qko2Z1ZDa0ZQOGJiN0dUSG00?=
 =?utf-8?B?QzBBWm5nNUMvU3lUcVYyZGlobUVNTk0vNXYwcThHbVZMbjBhb1RoZGE2UjZE?=
 =?utf-8?B?bm1DdWM2czc2bGZBVVBPSVR5bC84RzNZdmwyYmdPd2RvSWpCM3dLVTRGdERt?=
 =?utf-8?B?aGtaR0t0K2Z0Umpza2NMNWdkQTBGN0xNczVmM3BhTStreXRzWXhpREJ4WFp5?=
 =?utf-8?B?Rktnem0zZThNcVByajZHNmVJY0NwYU9iRnVqeW8zN0l5MWZPN3JiNkRpQUhJ?=
 =?utf-8?Q?AEgw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b030202-22e2-47cd-2669-08dc4da7ed8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2024 15:18:01.9747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WcgIE2V+XxFXBflEnuPEKgDaxCcSWq3t6cYVsg+7C5nlzKQGBzWGvk8Ljqj3mAwM1hHWF9kY85KYPC/TVr8grA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7631

PiBGcm9tOiBIZW5nIFFpIDxoZW5ncWlAbGludXguYWxpYmFiYS5jb20+DQo+IFNlbnQ6IFR1ZXNk
YXksIE1hcmNoIDI2LCAyMDI0IDM6NTUgQU0NCj4gVG86IERhbiBKdXJnZW5zIDxkYW5pZWxqQG52
aWRpYS5jb20+OyBuZXRkZXZAdmdlci5rZXJuZWwub3JnDQo+IENjOiBtc3RAcmVkaGF0LmNvbTsg
amFzb3dhbmdAcmVkaGF0LmNvbTsgeHVhbnpodW9AbGludXguYWxpYmFiYS5jb207DQo+IHZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LmRldjsgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsNCj4gZWR1bWF6
ZXRAZ29vZ2xlLmNvbTsga3ViYUBrZXJuZWwub3JnOyBwYWJlbmlAcmVkaGF0LmNvbTsgSmlyaSBQ
aXJrbw0KPiA8amlyaUBudmlkaWEuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIG5ldC1uZXh0
IDQvNF0gdmlydGlvX25ldDogUmVtb3ZlIHJ0bmwgbG9jayBwcm90ZWN0aW9uIG9mDQo+IGNvbW1h
bmQgYnVmZmVycw0KPiANCj4gDQo+IA0KPiDlnKggMjAyNC8zLzI2IOS4iuWNiDU6NDksIERhbmll
bCBKdXJnZW5zIOWGmemBkzoNCj4gPiBUaGUgcnRubCBsb2NrIGlzIG5vIGxvbmdlciBuZWVkZWQg
dG8gcHJvdGVjdCB0aGUgY29udHJvbCBidWZmZXIgYW5kDQo+ID4gY29tbWFuZCBWUS4NCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IERhbmllbCBKdXJnZW5zIDxkYW5pZWxqQG52aWRpYS5jb20+DQo+
ID4gUmV2aWV3ZWQtYnk6IEppcmkgUGlya28gPGppcmlAbnZpZGlhLmNvbT4NCj4gPiAtLS0NCj4g
PiAgIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDI3ICsrKysrLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMjIgZGVsZXRpb25z
KC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJp
dmVycy9uZXQvdmlydGlvX25ldC5jIGluZGV4DQo+ID4gNDFmOGRjMTZmZjM4Li5kMDllYTIwYjE2
YmUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jDQo+ID4gKysrIGIv
ZHJpdmVycy9uZXQvdmlydGlvX25ldC5jDQo+ID4gQEAgLTI2MzksMTQgKzI2MzksMTIgQEAgc3Rh
dGljIHZvaWQgdmlydG5ldF9zdGF0cyhzdHJ1Y3QgbmV0X2RldmljZQ0KPiA+ICpkZXYsDQo+ID4N
Cj4gPiAgIHN0YXRpYyB2b2lkIHZpcnRuZXRfYWNrX2xpbmtfYW5ub3VuY2Uoc3RydWN0IHZpcnRu
ZXRfaW5mbyAqdmkpDQo+ID4gICB7DQo+ID4gLQlydG5sX2xvY2soKTsNCj4gPiAgIAlpZiAoIXZp
cnRuZXRfc2VuZF9jb21tYW5kKHZpLCBWSVJUSU9fTkVUX0NUUkxfQU5OT1VOQ0UsDQo+ID4gICAJ
CQkJICBWSVJUSU9fTkVUX0NUUkxfQU5OT1VOQ0VfQUNLLA0KPiBOVUxMKSkNCj4gPiAgIAkJZGV2
X3dhcm4oJnZpLT5kZXYtPmRldiwgIkZhaWxlZCB0byBhY2sgbGluayBhbm5vdW5jZS5cbiIpOw0K
PiA+IC0JcnRubF91bmxvY2soKTsNCj4gPiAgIH0NCj4gPg0KPiA+IC1zdGF0aWMgaW50IF92aXJ0
bmV0X3NldF9xdWV1ZXMoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmksIHUxNg0KPiA+IHF1ZXVlX3Bh
aXJzKQ0KPiA+ICtzdGF0aWMgaW50IHZpcnRuZXRfc2V0X3F1ZXVlcyhzdHJ1Y3QgdmlydG5ldF9p
bmZvICp2aSwgdTE2DQo+ID4gK3F1ZXVlX3BhaXJzKQ0KPiA+ICAgew0KPiA+ICAgCXN0cnVjdCB2
aXJ0aW9fbmV0X2N0cmxfbXEgKm1xIF9fZnJlZShrZnJlZSkgPSBOVUxMOw0KPiA+ICAgCXN0cnVj
dCBzY2F0dGVybGlzdCBzZzsNCj4gPiBAQCAtMjY3NywxNiArMjY3NSw2IEBAIHN0YXRpYyBpbnQg
X3ZpcnRuZXRfc2V0X3F1ZXVlcyhzdHJ1Y3QNCj4gdmlydG5ldF9pbmZvICp2aSwgdTE2IHF1ZXVl
X3BhaXJzKQ0KPiA+ICAgCXJldHVybiAwOw0KPiA+ICAgfQ0KPiA+DQo+ID4gLXN0YXRpYyBpbnQg
dmlydG5ldF9zZXRfcXVldWVzKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLCB1MTYNCj4gPiBxdWV1
ZV9wYWlycykgLXsNCj4gPiAtCWludCBlcnI7DQo+ID4gLQ0KPiA+IC0JcnRubF9sb2NrKCk7DQo+
ID4gLQllcnIgPSBfdmlydG5ldF9zZXRfcXVldWVzKHZpLCBxdWV1ZV9wYWlycyk7DQo+ID4gLQly
dG5sX3VubG9jaygpOw0KPiA+IC0JcmV0dXJuIGVycjsNCj4gPiAtfQ0KPiA+IC0NCj4gPiAgIHN0
YXRpYyBpbnQgdmlydG5ldF9jbG9zZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KQ0KPiA+ICAgew0K
PiA+ICAgCXN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpID0gbmV0ZGV2X3ByaXYoZGV2KTsgQEAgLTMy
NjgsNyArMzI1Niw3IEBADQo+ID4gc3RhdGljIGludCB2aXJ0bmV0X3NldF9jaGFubmVscyhzdHJ1
Y3QgbmV0X2RldmljZSAqZGV2LA0KPiA+ICAgCQlyZXR1cm4gLUVJTlZBTDsNCj4gPg0KPiA+ICAg
CWNwdXNfcmVhZF9sb2NrKCk7DQo+ID4gLQllcnIgPSBfdmlydG5ldF9zZXRfcXVldWVzKHZpLCBx
dWV1ZV9wYWlycyk7DQo+ID4gKwllcnIgPSB2aXJ0bmV0X3NldF9xdWV1ZXModmksIHF1ZXVlX3Bh
aXJzKTsNCj4gPiAgIAlpZiAoZXJyKSB7DQo+ID4gICAJCWNwdXNfcmVhZF91bmxvY2soKTsNCj4g
PiAgIAkJZ290byBlcnI7DQo+ID4gQEAgLTM1NTgsMTQgKzM1NDYsMTEgQEAgc3RhdGljIHZvaWQg
dmlydG5ldF9yeF9kaW1fd29yayhzdHJ1Y3QNCj4gd29ya19zdHJ1Y3QgKndvcmspDQo+ID4gICAJ
c3RydWN0IGRpbV9jcV9tb2RlciB1cGRhdGVfbW9kZXI7DQo+ID4gICAJaW50IGksIHFudW0sIGVy
cjsNCj4gPg0KPiA+IC0JaWYgKCFydG5sX3RyeWxvY2soKSkNCj4gPiAtCQlyZXR1cm47DQo+ID4g
LQ0KPiANCj4gRG9lcyB0aGlzIGd1YXJhbnRlZSB0aGF0IHRoZSBzeW5jaHJvbml6YXRpb24gaXMg
Y29tcGxldGVseSBjb3JyZWN0Pw0KPiANCj4gVGhlIHB1cnBvc2Ugb2YgdGhpcyBwYXRjaCBzZXQg
aXMgdG8gYWRkIGEgc2VwYXJhdGUgbG9jayBmb3IgY3RybHEgcmF0aGVyIHRoYW4NCj4gcmV1c2lu
ZyB0aGUgUlROTCBsb2NrLg0KPiBCdXQgZm9yIGRpbSB3b3JrZXJzLCBpdCBub3Qgb25seSBpbnZv
bHZlcyB0aGUgdXNlIG9mIGN0cmxxLCBidXQgYWxzbyBpbnZvbHZlcw0KPiByZWFkaW5nIHNoYXJl
ZCB2YXJpYWJsZXMgaW4gaW50ZXJmYWNlcyBzdWNoIGFzIC5zZXRfY29hbGVzY2UsIC5nZXRfY29h
bGVzY2UsDQo+IGV0Yy4NCg0KSXQgbG9va3MgbGlrZSB0aGVyZSBpcyBhIHJpc2sgb2YgYSBkaXJ0
eSByZWFkIGluIHRoZSBnZXQgKHVzZWNzIHVwZGF0ZWQsIGJ1dCBub3QgbWF4X3BhY2tldHMpLiBJ
biB0aGUgc2V0IGl0IHdpbGwgcmV0dXJuIC1FSU5WQUwgaWYgdHJ5aW5nIHRvIGFkanVzdCB0aGUg
c2V0dGluZ3MgYXNpZGUgZnJvbSBESU0gZW5hYmxlZC4gIEkgY2FuIGFkZCBhIGxvY2sgZm9yIHRo
aXMgaWYgeW91IHRoaW5rIGl0J3MgbmVlZGVkLCBidXQgaXQgZG9lc24ndCBzZWVtIGxpa2UgYSBt
YWpvciBwcm9ibGVtIGZvciBkZWJ1ZyBpbmZvLg0KDQoNCj4gDQo+IEluIGFkZGl0aW9uLCBhc3N1
bWluZyB0aGVyZSBhcmUgMTAgcXVldWVzLCBlYWNoIHF1ZXVlIGlzIHNjaGVkdWxlZCB3aXRoIGl0
cw0KPiBvd24gZGltIHdvcmtlciBhdCB0aGUgc2FtZSB0aW1lLCB0aGVuIHRoZXNlIDEwIHdvcmtl
cnMgbWF5IGlzc3VlDQo+IHBhcmFtZXRlcnMgdG8gcnhxMCAxMCB0aW1lcyBpbiBwYXJhbGxlbCwg
anVzdCBiZWNhdXNlIHRoZSBSVE5MIGxvY2sgaXMNCj4gcmVtb3ZlZCBoZXJlLg0KPiANCj4gVGhl
cmVmb3JlLCB3aGVuIHRoZSBSVE5MIGxvY2sgaXMgcmVtb3ZlZCwgYSAnZm9yIGxvb3AnIGlzIG5v
IGxvbmdlciBuZWVkZWQgaW4NCj4gdmlydG5ldF9yeF9kaW1fd29yaywgYW5kIHRoZSBkaW0gd29y
a2VyIG9mIGVhY2ggcXVldWUgb25seSBjb25maWd1cmVzIGl0cw0KPiBvd24gcGFyYW1ldGVycy4N
Cj4gDQoNCkdvb2QgcG9pbnQuIEknbGwgYWRkIGEgbmV3IHBhdGNoIHRvIHJlbW92ZSB0aGUgZm9y
IGxvb3AuDQoNCj4gQWx0ZXJuYXRpdmVseSwgcGxlYXNlIGtlZXAgUlROTCBsb2NrIGhlcmUuDQo+
IA0KPiBSZWdhcmRzLA0KPiBIZW5nDQo+IA0KPiA+ICAgCS8qIEVhY2ggcnhxJ3Mgd29yayBpcyBx
dWV1ZWQgYnkgIm5ldF9kaW0oKS0+c2NoZWR1bGVfd29yaygpIg0KPiA+ICAgCSAqIGluIHJlc3Bv
bnNlIHRvIE5BUEkgdHJhZmZpYyBjaGFuZ2VzLiBOb3RlIHRoYXQgZGltLT5wcm9maWxlX2l4DQo+
ID4gICAJICogZm9yIGVhY2ggcnhxIGlzIHVwZGF0ZWQgcHJpb3IgdG8gdGhlIHF1ZXVpbmcgYWN0
aW9uLg0KPiA+ICAgCSAqIFNvIHdlIG9ubHkgbmVlZCB0byB0cmF2ZXJzZSBhbmQgdXBkYXRlIHBy
b2ZpbGVzIGZvciBhbGwgcnhxcw0KPiA+IC0JICogaW4gdGhlIHdvcmsgd2hpY2ggaXMgaG9sZGlu
ZyBydG5sX2xvY2suDQo+ID4gKwkgKiBpbiB0aGUgd29yay4NCj4gPiAgIAkgKi8NCj4gPiAgIAlm
b3IgKGkgPSAwOyBpIDwgdmktPmN1cnJfcXVldWVfcGFpcnM7IGkrKykgew0KPiA+ICAgCQlycSA9
ICZ2aS0+cnFbaV07DQo+ID4gQEAgLTM1ODcsOCArMzU3Miw2IEBAIHN0YXRpYyB2b2lkIHZpcnRu
ZXRfcnhfZGltX3dvcmsoc3RydWN0DQo+IHdvcmtfc3RydWN0ICp3b3JrKQ0KPiA+ICAgCQkJZGlt
LT5zdGF0ZSA9IERJTV9TVEFSVF9NRUFTVVJFOw0KPiA+ICAgCQl9DQo+ID4gICAJfQ0KPiA+IC0N
Cj4gPiAtCXJ0bmxfdW5sb2NrKCk7DQo+ID4gICB9DQo+ID4NCj4gPiAgIHN0YXRpYyBpbnQgdmly
dG5ldF9jb2FsX3BhcmFtc19zdXBwb3J0ZWQoc3RydWN0IGV0aHRvb2xfY29hbGVzY2UNCj4gPiAq
ZWMpIEBAIC00MDM2LDcgKzQwMTksNyBAQCBzdGF0aWMgaW50IHZpcnRuZXRfeGRwX3NldChzdHJ1
Y3QgbmV0X2RldmljZQ0KPiAqZGV2LCBzdHJ1Y3QgYnBmX3Byb2cgKnByb2csDQo+ID4gICAJCXN5
bmNocm9uaXplX25ldCgpOw0KPiA+ICAgCX0NCj4gPg0KPiA+IC0JZXJyID0gX3ZpcnRuZXRfc2V0
X3F1ZXVlcyh2aSwgY3Vycl9xcCArIHhkcF9xcCk7DQo+ID4gKwllcnIgPSB2aXJ0bmV0X3NldF9x
dWV1ZXModmksIGN1cnJfcXAgKyB4ZHBfcXApOw0KPiA+ICAgCWlmIChlcnIpDQo+ID4gICAJCWdv
dG8gZXJyOw0KPiA+ICAgCW5ldGlmX3NldF9yZWFsX251bV9yeF9xdWV1ZXMoZGV2LCBjdXJyX3Fw
ICsgeGRwX3FwKTsgQEAgLQ0KPiA0ODUyLDcNCj4gPiArNDgzNSw3IEBAIHN0YXRpYyBpbnQgdmly
dG5ldF9wcm9iZShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikNCj4gPg0KPiA+ICAgCXZpcnRp
b19kZXZpY2VfcmVhZHkodmRldik7DQo+ID4NCj4gPiAtCV92aXJ0bmV0X3NldF9xdWV1ZXModmks
IHZpLT5jdXJyX3F1ZXVlX3BhaXJzKTsNCj4gPiArCXZpcnRuZXRfc2V0X3F1ZXVlcyh2aSwgdmkt
PmN1cnJfcXVldWVfcGFpcnMpOw0KPiA+DQo+ID4gICAJLyogYSByYW5kb20gTUFDIGFkZHJlc3Mg
aGFzIGJlZW4gYXNzaWduZWQsIG5vdGlmeSB0aGUgZGV2aWNlLg0KPiA+ICAgCSAqIFdlIGRvbid0
IGZhaWwgcHJvYmUgaWYgVklSVElPX05FVF9GX0NUUkxfTUFDX0FERFIgaXMgbm90DQo+IHRoZXJl
DQoNCg==

