Return-Path: <netdev+bounces-72277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EB98576AF
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 08:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CBD91F22F3E
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 07:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C888214A8D;
	Fri, 16 Feb 2024 07:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="ZWDsJYnW"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2042.outbound.protection.outlook.com [40.107.8.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877BC14A90
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 07:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708067791; cv=fail; b=KMFhkEDAnWIJW7EXWCytduancckcJw2GHnbNo0SyvDaBMkwTmO54TSVIWdzPDqc/iLdn2VsbVHKRHBK+YgndndtHBQXcx6VVWYJIG/u0APhieC4zOEhmysZuP/HZVyhWgS9D8OP2G+cLBiQiy1C30DGWAY610f7MX4clQcO6Nho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708067791; c=relaxed/simple;
	bh=3AUjYYYepUdf0korgph6MJ4t0+CSFr0FMX3wTngfEr0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dGNnipTVkoXJyalhNo34HflcGm26FpXrhZpGcPHq6nlsRuBCptx8oCzfblNrR5TsKCdXXTACfc8X+LVZdpq/vgEW/zIii6ERdE4KeEbhjcZ2AWD3pt9I9gz08J9kfRUkJMpXR/ZziAe5VAzrOLCMANiAyH/iEIhW73P0NWOOVJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com; spf=pass smtp.mailfrom=ericsson.com; dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b=ZWDsJYnW; arc=fail smtp.client-ip=40.107.8.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ericsson.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZzpCsCC/PKTe6LdHmsz0bjqgUjgydrMIdkQm/M+ec0iaiYTGi0zfNoLCP7FDyvH5njdFVYPH7maTiutfV7APoK/yKSPAIJpG8IiL0X829pJjYQa3VEpEOwjd/Teje0+itM5OIoaNxHD/RBSa/mvW4Y5yC5YHBGWZGsv1k+3OqAeU8eZ+UgXrLdckB9l+uwXvNY7WoyjRRCHI02+J3NDrEpq/LUK+h8QiRdVtEgrkFIRO3fnTR9EpRJ76iftiAEhiDtzKPocT1uJXUR0VTvDzNIyZEemJDM9ihdsp5KNrMJG15AqXj5OiLqE3mPieveWiElwOnhcDFG+r6YA5Cra6Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3AUjYYYepUdf0korgph6MJ4t0+CSFr0FMX3wTngfEr0=;
 b=LcPEV5VFbA7l/RB3Ajtq/rI+4WyOVfZm3tkIJTUJ6AqBr1VwucK440HY2A4UIMNxKYxZfust+QgbeG8wOdyK9/6Z4VFy7oNx9eD+3TM6doVy1wxyBwXblqs1KWdWu6uy9pHNUskzqGJ9yS12yqkqdsJGTLR5slaXZ5v4XJIAcmepebOTY8PtAF/ZfaKCrOfxK31NLzu8dglmf6B8CkhvyaR4esj0VXLR74YYB3QCIDQKaKx2Q9uM9B09hk/yv++gkGrz0B3KGoC9Py4dg3Vme9AHG3y4YI95QNX37FsPRIoUtB1XS4VY7FpXwvafw9AvrHskDs4XD4pPjYclLwvyFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3AUjYYYepUdf0korgph6MJ4t0+CSFr0FMX3wTngfEr0=;
 b=ZWDsJYnW1Ql0CZDw0JJBRc1P/IY32LF6QdX+TvQeFfkRIKmDTPLfr8dVCz/833vl2o0JIztLfFJSDXsFqrwM7xPUh7sQiiRzbDMqqBMiElH23NgwlJdZatmo02k61CZNWe+iS2VSBcHXez79+YTbrEQLHS0Z+gC4k4VM8ZRU5FLPmv7yjgytUADEsd/k5iL7jGQWET242W41/QJVeO1/FMvKgh6Xr4hNwX3uoo/BHF6P0xTfqGfoNNusdW3ka8wJAnYdwB8NhDUiJWGp/GP2KM6feYT5Tl+a9iAB/nqSf8odJdVIGE78MbQSo8/JnT5Jx5cPUMFeg6LDpSy7ipgMww==
Received: from PAXPR07MB8676.eurprd07.prod.outlook.com (2603:10a6:102:243::17)
 by PR3PR07MB6619.eurprd07.prod.outlook.com (2603:10a6:102:6d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 16 Feb
 2024 07:16:26 +0000
Received: from PAXPR07MB8676.eurprd07.prod.outlook.com
 ([fe80::fe66:17df:590:aa35]) by PAXPR07MB8676.eurprd07.prod.outlook.com
 ([fe80::fe66:17df:590:aa35%7]) with mapi id 15.20.7292.026; Fri, 16 Feb 2024
 07:16:26 +0000
From: Ferenc Fejes <ferenc.fejes@ericsson.com>
To: "kurt@linutronix.de" <kurt@linutronix.de>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "vinicius.gomes@intel.com" <vinicius.gomes@intel.com>, "hawk@kernel.org"
	<hawk@kernel.org>
Subject: Re: igc: AF_PACKET and SO_TXTIME question
Thread-Topic: igc: AF_PACKET and SO_TXTIME question
Thread-Index: AQHaYKgN+curU3fRxEKnyZSnBcJMWA==
Date: Fri, 16 Feb 2024 07:16:26 +0000
Message-ID: <ea5f43e1c4c2403211f89ab014c88a7af4fe53ca.camel@ericsson.com>
References: <bc2f28999c815b4562f7ce1ba477e7a9dc3af87d.camel@inf.elte.hu>
	 <87y1bn3xq6.fsf@kurt.kurt.home>
	 <8b782e8de9e6ae9206a0aad6d7d0e2d3c91f3470.camel@ericsson.com>
In-Reply-To: <8b782e8de9e6ae9206a0aad6d7d0e2d3c91f3470.camel@ericsson.com>
Accept-Language: hu-HU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB8676:EE_|PR3PR07MB6619:EE_
x-ms-office365-filtering-correlation-id: f766bdc8-b64b-44da-dae9-08dc2ebf3066
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 zg7P5KcjnhGaWb9ZaAJ+IAYC4Fo4lgRZ6Z0qz8mJQQQrIw9BsYk3s9vcH1LkcRFAT2xzgyOwiG86EPKds0/jVcxjyxdtvgqcAh+M/vks6a84kTN6sOtPetoph1BTn0srCKmmoEnJJgNEqakkJA8MwK4xIEUfA9qFQ+0IN7lgWsYwr1ZTnat4LWh1CGB5XmrUeeHHY5wZvirtmmBz6RpGmb/v8VIKNOHFL/KaAo1Mh90mu33SvlfuGLHz9zXuHcGVK7J4hEC3lc2KRnT8tjQKR4QstvOZ7bkjkrHJyED+XN9QXqbvl2SFDQQ7SMAoLSfrQ9l6osMyXhh0V+4RilPNloqzldgfjY0BFuBPGNm0YOFNQsZm+e+2ejdaJN+MPO96a66IhiwkzGSQZm/mZpepT+rPDoIiUo0rn9BJthrISQdYM9oBsSvbNjAOKO2i9goWXihlYG68ZSaCcI6mAn0iNwJmYWj9GNSrHhfyxPIYkWdoiad95ullUHm4sfYuZ64B9rZ1G7gMhGVAMO9yQxuyJnLgCydsNVe4rfPuw8oGVV0caCve4aHc/KNnLuo0+D1ctZtyfZGNWG7cjSa8SqyeDvmB46QG6bR5UX8lm/T1xZnX9wdKluX8Xq6ebo4zvkJR
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB8676.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(366004)(136003)(376002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(6512007)(6506007)(6486002)(36756003)(54906003)(316002)(26005)(110136005)(2616005)(71200400001)(41300700001)(5660300002)(44832011)(2906002)(76116006)(66446008)(8936002)(66946007)(66556008)(4326008)(66476007)(8676002)(64756008)(38100700002)(38070700009)(82960400001)(122000001)(478600001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UVV2eitjM0Vob1pSeTVVcGxtM1lLUjdLNEx1clhnVnI1bmZqMUw1Qko2bS8r?=
 =?utf-8?B?dldqZFMwRVgweFhYdnpyQXdJbVBiSzlmTTNYVmV5YmEySFUzRUVjTUl5VTQr?=
 =?utf-8?B?VUxLS2I3Q01XUU91alVsaDFzTHNUZ0FrVWQ3R3dHMG9Kd1RMTmNLKzJ5NUZr?=
 =?utf-8?B?bVcxQWdrZWRFUjJTOEg3SWQ5SmlxRlluaVBmLzduS3JlR1ErK2JJbENsekto?=
 =?utf-8?B?VVJ0RXJ1UFFoazBWb25tcTQwZ2V6dVJ6S3BJd2w4ODRrOGp3ZmlwdlA1S2xL?=
 =?utf-8?B?aDBLTU5oR0M0cUNScy9CUFErYmJZcHBJbE80V1p6Sk12YXpOeENtMDFMajBF?=
 =?utf-8?B?bmR4azZOaUZjeEJkWS93UkR6WUNocC9oV1d0cnJnVG1hRnJ4MXBES0JldnVC?=
 =?utf-8?B?bnR2QjBXdkgxZmQvVlpoL1VwSUlBdzNSbU53T0gzU2s1MXVpWkdxRE9KVXVJ?=
 =?utf-8?B?WHhHNzRybC9TYmZId3p5b09FWXJTakJlUkNYR20yTHVSR1UrNFVLYW5pQ1lQ?=
 =?utf-8?B?UG9RK0V6eXJ6Qm43cHFpNlFOZlVRT29idXFzMXJVRUVBTXFzWXUyRG0xV0JT?=
 =?utf-8?B?VnllSkh6YnVyT0N6OHUzRDRLVGM4M0RySmhnaTg0VDkzMTllRTJRZHNUOEhJ?=
 =?utf-8?B?bzRiZ2RQOXIrWm9sUlo4VnJobjFBTVgxMXl5dXkvWEVIRGFiY0lKRGxSRDZV?=
 =?utf-8?B?SFp6NHdMQ0NHRzRXaDhFdlhyWEtDTzhEVFhSazk4blk2djNqb2hyZGJHSkY0?=
 =?utf-8?B?cTJzUS9iNGY0QUhZbzMvQkNLYmxIS2hzMUlRMmgzeVZRd2ordjg1UUNKMTN6?=
 =?utf-8?B?Nk82NFNqVXJweEx1b1NtUUdxVFFURnBCNTR1ZUxwcFMvdVJBMXVXNEorYXo2?=
 =?utf-8?B?a0JFSXhMWURTMzlMOU5yVEowTGJaLzV4ankrcC9VRENBQy9kWlBiN0Z3c08x?=
 =?utf-8?B?TE5QTjF3NU8rS2xSTm0xaEI3aERIcEFZVWp6OTZlWGUrSHY3aTZrWEYxVUJE?=
 =?utf-8?B?dm1kNjNkWlpqcFpueVp4dldPWnZMWm4zaitOMXRSR2JEOERrSGJpZm84UWFn?=
 =?utf-8?B?eGpsNFg4Rk93dEJ5Qm5WU1NXMERWd2FSQ3NaNzlrRjdmZkxySDQ2NTNpRzVD?=
 =?utf-8?B?bjEwRG4zMExSZm9oZTZaWFVubFdkL3RnekFscy9jZEVabmRhMkEzTTNVQk9l?=
 =?utf-8?B?MDA1TGxnL0VzTEpHc2Z6bWp2ZW03REVQc2J4WkVic1FPZDFneWVqS0pEMTVT?=
 =?utf-8?B?MGhmc2RlRXFibnlrTkVJcmg5bXY0Yk5nYlhORjlTa3NFQlNERHRPcnpTZlU2?=
 =?utf-8?B?ZWNrbEQ3aXJhVk9mNmI1OWMrQWMzZEVlbVFlaHhpcFczWTBDQ05uZzV4eHlV?=
 =?utf-8?B?aThYdXBReFJMbkJ6SDVvcVhQcnlicUtWQjVFZDcvUEI2c3NuM0ZtL3lYUnlt?=
 =?utf-8?B?MmI1ZWM1NWVNMHpEZmhFZ0Z0YzRWZlRJeGxqNVdQb2tzMnFhUzJUMXZtcU93?=
 =?utf-8?B?MWhRWlRhRGRpdUlxTVdqWlQ4clBOeitIaHdGY3JiUVY2YXRjcHd4QlN4V3po?=
 =?utf-8?B?WXY5dERrY3ZtNUdvRHRTaXc2Y0k0eVdsK2FINGF0bDlSQUt0WEZBMDhCeEpv?=
 =?utf-8?B?cEFZM0pYdURoRFZRK2t6a1lCcUI3QkhTNWV5eklXYS8vVmdwUjBvT3NOTGE3?=
 =?utf-8?B?OVFVSnM2QWYvcGNTSWtodVhmMktFS1hyd3hhRmttSDlsR1VmZ09hajdjQXkv?=
 =?utf-8?B?SHBFbm0weFp3MFJjRW5QOUg0OUtINFVpenptcVB2WUg1YW9iQU9XUG85VVBK?=
 =?utf-8?B?U3VqanNEUWVic2tFb2JBSy9SRThjM0JWY09jemhDV1M1alFXTWNGbEMrREds?=
 =?utf-8?B?cXIvaTFQMll5OVN1cEh2aEN3bDM3bmVlMk1GYVczSzBxUVpORDQvSE9nK3Vl?=
 =?utf-8?B?dXhibWYvWnhmQVBGYUhpWE90aGw2S0VRNmN6Y3JwUGpGOTdhWENtc0o4RFd0?=
 =?utf-8?B?QW02MnVwMzZZNmtaQkNpVXRDTWVCYUJUbzB1RlgraGpoY2lBSmp1ck9xNEli?=
 =?utf-8?B?Z0ZZM2kxVnNLaFcybzZOSFVCUjhjYzl1cVhkQ1R0SURMdFNlQS9WM3k4RGVE?=
 =?utf-8?B?dzBOSEU4dHpFaUxTZjB3TU9wSUk0OS9NelhiVG80UHkxM2ZkNkxaSWFKc3U0?=
 =?utf-8?B?Wmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CD721D6B3848FF4D8B7180116BE19946@eurprd07.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f766bdc8-b64b-44da-dae9-08dc2ebf3066
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2024 07:16:26.5271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jD8wrMhPYf6gCI/vwf6haqEGkr2ngFnSoG0+CDd9Uys/9RgZjivMOZ2eFhZCrPGDwhaGYT/GSghmM1DYS4bbXzctLb8TB5bK3Yr1HjJc3K0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB6619

SSB0aGluayBJJ20gZmlndXJlZCBvdXQgd2hhdCB3YXMgdGhlIGlzc3VlLCB0aGFua3MgZm9yIHRo
ZSBoZWxwIQ0KDQpTb2x1dGlvbiBpbmxpbmUuDQoNCk9uIFRodSwgMjAyNC0wMi0xNSBhdCAwOToz
OCArMDEwMCwgRmVqZXMgRmVyZW5jIHdyb3RlOg0KPiANCj4gPiANCj4gPiBTZWNvbmQgcG9pbnQg
dG8gbWFrZSBzdXJlIGlzIHRoYXQgdGhlIFR4IHF1ZXVlIHlvdXIgcGFja2V0IGlzIGJlaW5nDQo+
ID4gdHJhbnNtaXR0ZWQgdG8gaGFzIExhdW5jaCBUaW1lIGVuYWJsZWQuDQo+IA0KPiBHb29kIHBv
aW50ISBXZSBtaXNzZWQgdGhhdC4gSUlVQyB0aGUgVFggcXVldWUgc2VsZWN0ZWQgYnkgdGhlIHNr
Yi0NCj4gPiBxdWV1ZV9tYXBwaW5nIGFmdGVyIHRoZSBpZ2NfeG1pdF9mcmFtZSBwYXJ0LiBXZSBz
ZXQgdGhhdCBwYXJhbWV0ZXINCj4gPiBieQ0KPiBza2JlZGl0IHRjwqAgYWN0aW9uIGJ1dCB0aGF0
IGlzIG5vdCBleGVjdXRlZCBpbiB0aGUgYnlwYXNzIGNhc2UuIEZvcg0KPiB0aGF0IHJlYXNvbiwg
dGhlIHNrYi0+cXVldWVfbWFwcGluZyBtb3JlIG9yIGxlc3MgcmFuZG9tLg0KPiANCj4gSG93ZXZl
ciwgZm9yIGEgcXVpY2sgdGVzdCwgd2Ugc2V0IEVURiBvZmZsb2FkIGZvciBhbGwgNCBUWCBxdWV1
ZXMuIFNvDQo+IG5vIG1hdHRlciB3aGljaCBxdWV1ZSB0aGUgcGFja2V0IGVucXVldWVkIGl0IHNo
b3VsZCByZXNwZWN0IHRoZQ0KPiBsYXVuY2h0aW1lLiBCdXQgd2UgZG9udCByZWFsbHkgc2VlIHRo
aXMgYmVoYXZpb3IuLi4gTmV2ZXJ0aGVsZXNzIGl0cw0KPiBhDQo+IGdvb2QgY2F0Y2gsIEkgbWlz
c2VkIHRoaXMgYXNwZWN0IGNvbXBsZXRlbHkgYXQgdGhlIHRpbWUgb2YgbXkgZmlyc3QNCj4gZW1h
aWwuDQoNCi4uLg0KDQpXZSBzaW1wbHkgcGxhY2VkIHRoZSBFVEYgcWRpc2MgYXMgdGhlIHJvb3Qg
cWRpc2MgYW5kIGFzc3VtZWQgdGhhdCB0aGlzDQp3b3VsZCBlbmFibGUgb2ZmbG9hZCBvbiBhbGwg
VFggcXVldWVzLiBBcHBhcmVudGx5IHRoaXMgaXMgbm90IHRoZSBjYXNlLg0KQWNjb3JkaW5nIHRv
IHRoZSBjb2RlLCBpdCB3YXMgb25seSBlbmFibGVkIGZvciBxdWV1ZSAwLiBBbm90aGVyIG1pc3Rh
a2UNCndlIG1hZGUgaXMgd2UgdXNlZCBtdWx0aXEgcWRpc2Mgd2l0aCBza2JlZGl0IHF1ZXVlX21h
cHBpbmcgd2l0aG91dA0KYnlwYXNzIC0gd2hpY2ggd29ya3Mgc2luY2UgdGhlIHR4IGFjdGlvbiBp
cyBleGVjdXRlZC4NCkhvd2V2ZXIsIHdpdGggcWRpc2MgYmF5cGFzcywgdGhlIFRYIHF1ZXVlIHNl
bGVjdGlvbiBmb3IgdGhlIHBhY2tldHMNCnNlbnQgdG8gdGhlIEFGX1BBQ0tFVCBzb2NrZXQgbG9v
a3MgbGlrZSB0aGlzDQoNCnR4X3F1ZXVlID0gY3B1X2lkIG9mIHRhc2sgJSBudW1fdHhfcXVldWVz
Lg0KDQpXaXRoIHRhc2tzZXQsIHdlIHdlcmUgYWJsZSB0byBleHBsaWNpdGx5IHNlbmQgcGFja2V0
cyB0byBUWCBxdWV1ZSAwIGluDQp0aGUgYnlwYXNzIGNhc2UsIGFuZCB0aGF0IGVzc2VudGlhbGx5
IHNvbHZlZCB0aGUgcHJvYmxlbS4NCg0KU28gd2Ugc3dpdGNoZWQgdG8gbXFwcmlvIGFuZCBlbmFi
bGVkIG9mZmxvYWRpbmcgb24gYWxsIHF1ZXVlcyBhbmQgd2l0aA0KdGhhdCB3ZSBhbHdheXMgc2Vl
IHRoZSBkZWxheWVkIHBhY2tldCB0cmFuc21pc3Npb24gd2l0aCBsYXVuY2h0aW1lDQplbmFibGVk
Lg0KDQo+ID4gDQo+ID4gDQoNCi4uLg0KDQo+ID4gSXMgdGhhdCBhbHJlYWR5IHBvc3NpYmxlIHdp
dGggQUZfWERQPyBUaGVyZSB3ZXJlIHNvbWUgcGF0Y2hlcyBvbg0KPiA+IHhkcC1oaW50cywgYnV0
IGkgZG9uJ3QgdGhpbmsgaXQgaGFzIGJlZW4gbWVyZ2VkIHlldC4NCj4gDQo+IE5vdCB5ZXQuIFRo
ZXJlIHdhcyBhIHBhdGNoc2V0IHdpdGggdGhlIGluZnJhIGFuZCBzdG1tYWMgYXMgYW4gdXNlciwN
Cj4gcmlnaHQgbm93IEkgdGhpbmsgaXRzIHVuZGVyIHNvbWUgcmV3b3JrIGluY2x1ZGluZyBpZ2Mg
YXMgYW5vdGhlcg0KPiB1c2VyLsKgDQo+IEhvd2V2ZXIgaW4gcHJpbmNpcGxlLCB0aGUgY29kZXBh
dGggbWlnaHQgYmUgc2ltaWxhciB0byBBRl9QQUNLRVQsIHRoZQ0KPiBvbmx5IGRpZmZlcmVuY2Ug
aXMgdGhlIGx1bmNodGltZSBtZXRhZGF0YSBidW5kbGVkIHdpdGggdGhlIHhkcF9idWZmDQo+IGFu
ZA0KPiBub3Qgd2l0aCB0aGUgc2tiLg0KDQpBcyBhIHJlc3VsdHMgdGhlIEFGX1hEUCBoaW50cyBt
dXN0IGJlIHdvcmsgYXMgZXhwZWN0ZWQgd2hlbiBpdHMgZG9uZS4NCg0KPiANCj4gPiANCj4gPiBU
aGFua3MsDQo+ID4gS3VydA0KPiANCj4gQmVzdCwNCj4gRmVyZW5jDQo+IA0KDQpUaGFua3MsDQpG
ZXJlbmMNCg0K

