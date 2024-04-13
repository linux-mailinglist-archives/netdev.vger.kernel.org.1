Return-Path: <netdev+bounces-87582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3008A3A53
	for <lists+netdev@lfdr.de>; Sat, 13 Apr 2024 04:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 890C9B21B79
	for <lists+netdev@lfdr.de>; Sat, 13 Apr 2024 02:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C02101CA;
	Sat, 13 Apr 2024 02:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j0wGr9+6"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2058.outbound.protection.outlook.com [40.107.95.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593328827
	for <netdev@vger.kernel.org>; Sat, 13 Apr 2024 02:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712973690; cv=fail; b=uBLbuZMawfvMyXiqd/RrK2b7aGRp6eEvk2r6RHhspWsXfMpmoWA+UyIj9bqKkF7nprMP1s6F9xWDdHDFfkhGc/qX0sE87SmZHBiG4XWx4wCXDZID1kDmdIYkUyzALOdqJ4+GaSOlYTP3V8tezqt6vZ+CzaCPh8/td5GeLZlGHYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712973690; c=relaxed/simple;
	bh=yKMcRoYL5OzbZABwA+fn+QuCoNvgwrDEffFHXCvD+LI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WZhoc1KUo73eLUrfReB1Dl/8VJGFokcpxEorUP6lAKkhv0es/s/haSq2lQBmPIPUi4rOZu9X6sY9yVQ47pouM7BGXXocK7VZFRwoZgCEpn232Cst+ASRJrXm5N/FOmzGhd8Ik69wrI8cMgh9p2c68lSr4W/odOt9L5F0aDZR/6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j0wGr9+6; arc=fail smtp.client-ip=40.107.95.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIEGrTqAnzl0Eq4Dfnbazd6pTc/fZe8RUIxi8QouYzzDRvxziNBQuRoivw/tqkpYzNiWq9o1CQtez+90IyROVaa15ysl4Gm2MZX5iOk+/didMccZRd15qksxg+FdcYR42uYQVjK82YXFkG/JJU+azTNa4NaR8DCR8a6Xyxh1rPa5KGnlsRgS6h0+kkoDvrdBFjzhGMnemWj3w32bNn5ryl+HY2vW2dzsDW2V+sd65F/6xie/WD7Psf8s93fRn5H4QtNlBaeTHTspbzBaPcQLb3N8QLKRaZT49acXfcIaWcc+gKSW+5md7g1ucs1K0Ll9AkitQJZNo/vXVt50AI4ANg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yKMcRoYL5OzbZABwA+fn+QuCoNvgwrDEffFHXCvD+LI=;
 b=HYRaQc2CP3EiCaF0haUFvDNeKaCELlebv5So4aNDX73qJF0znoLOdobemR8O0bE+3RMO8WQBI/6bJwh1JCDQZxGv0l4D0Xmvu8M51x9fdbFidXASWMdbU7hHc0lnIDj972L1/u0bjv3ppkPVUlEHBJTuxwSzuzRZelF/aLsqMlnfK/BzJ2s5OgfRGjDalcf1WeNkY2OmAKh0izxHZMLMO8zgZyhG8bjuGbP1qSJ8V0KhpT0oDIPd3UNSrq2MuMUQL94IOrRpKYxNtr/tb9sSaFirNPLIKV6QCCk4vHWdLU3HRncAa2TTPgZLdSzL4xoqS4QnB4LcmCuskrJsET4mqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKMcRoYL5OzbZABwA+fn+QuCoNvgwrDEffFHXCvD+LI=;
 b=j0wGr9+6GACB6BpvrkG5IpJEQiDmAjzX1Hqy4Jz1TSC6jJKurclcayx27pKeGoEWeejXyFdd3xCdRUY/vFlxbVbCb7CBY4ZNnByrnB730fPXe5ZyP090fBOgFfDlVSrQqloVgz023GA9Lz6kJfcMO+SSl5A2kirr+H5DJxXpkqBMZ2HvigpkDLvu+qukk0F7e6jnDyzD1cXe/fAH5vBZGTz+GeFwUjoUyP0dcocKadgjIZ2nQdZhwYQF/mHq+Peyo4bl6ZNh8Iund5FRjh5uTBrbNjUXqDrZVbXzLASJI8hH6XXptuSq5uQEbHx8PuWK5qdLfIdclzv38jW5SscSHQ==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB8152.namprd12.prod.outlook.com (2603:10b6:510:292::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sat, 13 Apr
 2024 02:01:26 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::65d2:19a0:95b8:9490]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::65d2:19a0:95b8:9490%5]) with mapi id 15.20.7409.046; Sat, 13 Apr 2024
 02:01:26 +0000
From: Parav Pandit <parav@nvidia.com>
To: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, David Ahern
	<dsahern@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"stephen@networkplumber.org" <stephen@networkplumber.org>
CC: Jiri Pirko <jiri@nvidia.com>, Shay Drori <shayd@nvidia.com>, Michal
 Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: RE: [PATCH v2 0/2] devlink: Support setting max_io_eqs
Thread-Topic: [PATCH v2 0/2] devlink: Support setting max_io_eqs
Thread-Index:
 AQHaiz6PozPVAHS/rUiy5XxYWBlFb7FiJW0AgAAz45CAAVlCAIAAMvKAgAAT/9CAACHC8IABGK4AgABBCOA=
Date: Sat, 13 Apr 2024 02:01:25 +0000
Message-ID:
 <PH0PR12MB5481A4D48BCECC6712CEA3ACDC0B2@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20240410115808.12896-1-parav@nvidia.com>
 <a0c707e8-5075-43a2-9c29-00bc044b07b4@intel.com>
 <PH0PR12MB5481898C4B58CF660B1603DDDC052@PH0PR12MB5481.namprd12.prod.outlook.com>
 <dc7eb252-5223-4475-9607-9cf1fc81b486@intel.com>
 <68b0f6e2-6890-46f9-b824-2af5ba5f9fd4@kernel.org>
 <PH0PR12MB5481F29AC423C4723F57318BDC042@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB5481B04C5E22E7DECE8879B0DC042@PH0PR12MB5481.namprd12.prod.outlook.com>
 <717f47b1-d9c1-47d9-83ae-153ee11bb66d@intel.com>
In-Reply-To: <717f47b1-d9c1-47d9-83ae-153ee11bb66d@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH0PR12MB8152:EE_
x-ms-office365-filtering-correlation-id: 9cdc4246-90ef-4bab-391e-08dc5b5da051
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 l0PyfKcOi2R/eGrkC4KqQw1G+ux77c8z+7Zq6yvoIYGm0a8s+5ogRc+eqg8Yhv0uQUNtl6pmJk0YVouM4JmlAXhXFzoUaVmjoZXzlJYi8XV5QyXv5x3jImoP29SNAN61LGS9zV2ilShFV6dN2kGPQNLbDsxyl3/ew4Byj22RGlgL1Ln5RPSEwc0UCZeNoZEMEZrpws9PJNk7RbtaFV4TPUi9+JovzF1mkgdHN9qKF+dE+k3HX1pCw/AruXktt6rfVmEeXlkp/qmsrQzRc2Bjn3pCyoGRYeckyQ+3QH5yX9V6p1vfRm49E4jx4/hhOke7eL1EqTzhzfM5ioxhUaBE1ERGXyGhhx4sOVemi8OGjO3PzmF3ewTPH5WYLTBxhDada5nQrWdlohuQ06ztoxMU87j+QbTZnxlT+LYzeMz/AueJnCI4vyNToJtfGAbGaDDxv5dwUiiO9w/x3jTuISD3s392b+UrsBduS5X+DyAQ9EJPp32Augf6LMVt2x7ZV1sFidUZPNGsXQF1VbPKDDCg/jn7k5zJqrPdsfyKnFC/o6UfbXlcYO7cavxaZaBFtHrKIItqY/WBoPoeqcW+5oELw1Vnifdf0R9eFv1nQAIH9TWpJ0HJlfj8hbmaMjEes6MIANFEB88IVjfd5gLqpggVvw2rPjNhrPrdEopMl9PZcFat8NPGNjkXOcOQD9m51fPsJ12Df2KmOGwTHSU2AbPX1g==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VjJ6NmoxTzVuZW94dGhNY0psS0ovMW52VzJ1SDI0UW5ySjc5ajRGakVZeWNP?=
 =?utf-8?B?aFJyYWR4bkJDQ01MUkJQVjZBbVBCaXBPNWJ0VE95MndjUmdDc0lDRzI1bWVR?=
 =?utf-8?B?WjJaUjYvMDR0T1FVU1c4ejMxcUlRS0FmOWtOUkV1M0lwcmNLZFhwMWpXNnJs?=
 =?utf-8?B?YktiWWlIcW9SdVplMzZrc1RqbGd5ZHNndkh1N2pETlV2bWtxUm5rK2ZadTMv?=
 =?utf-8?B?SXdhYW5SN0NhSVhzeW96OUYyRVhFaUNUU1B5ZmNWQTIzNnJwdkxaek13R25R?=
 =?utf-8?B?ZUNxcUVIVzFFQnQ5ajNhZ0JXRjRRaUFzcEFsTWVYMjY2VUl1MHh2UEhJQU1C?=
 =?utf-8?B?dG40MW1QUitLcHBXREtKYVpGZ1NXcVhXSHVVVjN5bmJFME9kZXZPVU1XTm9T?=
 =?utf-8?B?K1lVMGtQcFBBcmM3dzZyUThtdGdoM1g0YnNnaW1wNmVTTTdueU1zcFdrRlpJ?=
 =?utf-8?B?dzYyOU96WWVjbVlHeTBkaUYrQStXNkg3bkpxbDFrdXl6NTNyeldIdDh1Sk4w?=
 =?utf-8?B?Vi9XclUyUXFlcWx1dGltc0Nqa0VTdmxIVTlhOFlUdEFkbTBZK3U1Q2d6N3NX?=
 =?utf-8?B?QnA1YWJZT1FGZGpDRU8rcXdUbkY2RGdUWmYrVDY2RnlKQW1wRWhXVjl6QVJm?=
 =?utf-8?B?QXFBT2JnUWZLOTdBTUdnTmxUQXQrdHl5Yk1odGs1bzYxeDh4dk9WUkRmTEMr?=
 =?utf-8?B?VjRPRkpuRnBMRVA2UjV4S0Ziek1STHZWeVEyTnBJcDJzL1hHMkZleUs0dlJH?=
 =?utf-8?B?MFZ3NitTOFBkNjI4cWdKSVNtVXZTYUdKdXM5TkxVSU8yalpCSkg0WWUxSnpn?=
 =?utf-8?B?N3FYdTV1RGFUcnErcFV5QzFKcS9KbjI2TUJhV0R4OHFuSk1JWmlKTTZnVUp1?=
 =?utf-8?B?SkdlazBIOWxkVE4ycWdOYVo2TVFWWFJrWmVhQlBVRG14N2gzckcxQUt5NEp3?=
 =?utf-8?B?YXozaSsrS3loNjd6VVQyMFNvR1FwSUt1cjI0K1NiMDVSQWJndCtOb1B3ZWdP?=
 =?utf-8?B?aVJqRkdOQURVTEttdHFHOGhNSDRjZnBZWGViOGdoREhBaDV4U3NFUWlWYkVj?=
 =?utf-8?B?VDl6OHcyZ0tscitxQVZrR0ZqdzhERUFRTnJDZVdFbnBLeUJGZjh4YnBHWGd0?=
 =?utf-8?B?WFRqKzdaVkxubGZycUJFQVFiLzhMS0o2MlNCZGV3aFhvZDBHWWVyMjJGUHho?=
 =?utf-8?B?dzl1ZVpBNUNxcTE3RFdBMDh6TDlTT2JBVlBwY2JNeGNwc29Vc2E4OS80bUg3?=
 =?utf-8?B?cDdIUUpZelRhR1dFK2pSQ3ZBNWZ1bCtTR0hXWld6Q0EvRlNsaFBBb2F1UDJw?=
 =?utf-8?B?SDdvRmR6U0hscmM3TzB4SEVENEJCWTRsc0kzdDRXUDdibHNKd1pVZEF3SHVL?=
 =?utf-8?B?d3NMeVFqd0o5NjVXUGQ2UFJQdEJLVlVwYngwaFJLcEp6Q2pQWEl6S1BLem5O?=
 =?utf-8?B?RTFrVEN5YnZNTitaSUNTVWFMT210NkFmUktwRUlnMzJ1REREWHFaMjAvWG9C?=
 =?utf-8?B?L3lGaFBRTFB0YWlyak5kRkhhZXRqalNHQ2JkNHpCLzhab3FqTlkxVU82Mi9T?=
 =?utf-8?B?b3gxL3FvZGZxUVRIUUV2UUJsblI3L3hTOFZneHB4ZjJTRGtNeEFuM09IeXFw?=
 =?utf-8?B?bkpKWEFnOFdpeUJzMGNrNmJ4VGJodENmbE81V2FybkI4NHlsbkQwWGo4L3pD?=
 =?utf-8?B?YUl3Ykk4a3pQSFBQTmNrSk9qK29ZSEt4a1JISzFYY0VIa213SS9qYnArMmhh?=
 =?utf-8?B?SDNwdEs1aTlYSmJlNXd1VWxyanphVkgxR0MvbWJxWGovOEVVbkUzR3BzY1do?=
 =?utf-8?B?QjRPN2ZyZzROTjZLc05xbHBVZWhYSDJkRUZwekR4TlFESnhGYlFOS2EwL1RR?=
 =?utf-8?B?cVJiK0xGQkZ5eFlFanFNRGZUMHNWODlKbUtuMzN5T1BTVmxYRjRja0V0Wm10?=
 =?utf-8?B?eWVjQlMxRjhmdVBITG84clJtT2RzdjlnNTZOT2pBaEg5NHJOamtCcWNuNURU?=
 =?utf-8?B?V1VQVU5xU0c1Wm1DRVAwUjBVakt1RkpqWjJhMGxHcDZ2OENJL29IV0ptVmwr?=
 =?utf-8?B?Z01MQ1RXOUxnRHRaTlJTRlZYYXdxL1drK3ZzWkpKT1V1cUxwNnhUSXJtMDFh?=
 =?utf-8?Q?U9mQ=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cdc4246-90ef-4bab-391e-08dc5b5da051
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2024 02:01:25.9023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bF6ztbdr5tObmeY/cgmwJawwTtXZNfuLEO1DNlf/UNbJyAn6hL7EspPK3CPqaCZnuLI5DiW8eCIcJjplffBFMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8152

DQoNCj4gRnJvbTogU2FtdWRyYWxhLCBTcmlkaGFyIDxzcmlkaGFyLnNhbXVkcmFsYUBpbnRlbC5j
b20+DQo+IFNlbnQ6IFNhdHVyZGF5LCBBcHJpbCAxMywgMjAyNCAzOjMzIEFNDQo+IA0KPiBPbiA0
LzEyLzIwMjQgMTI6MjIgQU0sIFBhcmF2IFBhbmRpdCB3cm90ZToNCj4gPg0KPiA+PiBGcm9tOiBQ
YXJhdiBQYW5kaXQgPHBhcmF2QG52aWRpYS5jb20+DQo+ID4+IFNlbnQ6IEZyaWRheSwgQXByaWwg
MTIsIDIwMjQgOTowMiBBTQ0KPiA+Pg0KPiA+PiBIaSBEYXZpZCwgU3JpZGhhciwNCj4gPj4NCj4g
Pj4+IEZyb206IERhdmlkIEFoZXJuIDxkc2FoZXJuQGtlcm5lbC5vcmc+DQo+ID4+PiBTZW50OiBG
cmlkYXksIEFwcmlsIDEyLCAyMDI0IDc6MzYgQU0NCj4gPj4+DQo+ID4+PiBPbiA0LzExLzI0IDU6
MDMgUE0sIFNhbXVkcmFsYSwgU3JpZGhhciB3cm90ZToNCj4gPj4+Pg0KPiA+Pj4+DQo+ID4+Pj4g
T24gNC8xMC8yMDI0IDk6MzIgUE0sIFBhcmF2IFBhbmRpdCB3cm90ZToNCj4gPj4+Pj4gSGkgU3Jp
ZGhhciwNCj4gPj4+Pj4NCj4gPj4+Pj4+IEZyb206IFNhbXVkcmFsYSwgU3JpZGhhciA8c3JpZGhh
ci5zYW11ZHJhbGFAaW50ZWwuY29tPg0KPiA+Pj4+Pj4gU2VudDogVGh1cnNkYXksIEFwcmlsIDEx
LCAyMDI0IDQ6NTMgQU0NCj4gPj4+Pj4+DQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gT24gNC8xMC8yMDI0
IDY6NTggQU0sIFBhcmF2IFBhbmRpdCB3cm90ZToNCj4gPj4+Pj4+PiBEZXZpY2VzIHNlbmQgZXZl
bnQgbm90aWZpY2F0aW9ucyBmb3IgdGhlIElPIHF1ZXVlcywgc3VjaCBhcyB0eA0KPiA+Pj4+Pj4+
IGFuZCByeCBxdWV1ZXMsIHRocm91Z2ggZXZlbnQgcXVldWVzLg0KPiA+Pj4+Pj4+DQo+ID4+Pj4+
Pj4gRW5hYmxlIGEgcHJpdmlsZWdlZCBvd25lciwgc3VjaCBhcyBhIGh5cGVydmlzb3IgUEYsIHRv
IHNldCB0aGUNCj4gPj4+Pj4+PiBudW1iZXIgb2YgSU8gZXZlbnQgcXVldWVzIGZvciB0aGUgVkYg
YW5kIFNGIGR1cmluZyB0aGUNCj4gPj4+Pj4+PiBwcm92aXNpb25pbmcNCj4gPj4+IHN0YWdlLg0K
PiA+Pj4+Pj4NCj4gPj4+Pj4+IEhvdyBkbyB5b3UgcHJvdmlzaW9uIHR4L3J4IHF1ZXVlcyBmb3Ig
VkZzICYgU0ZzPw0KPiA+Pj4+Pj4gRG9uJ3QgeW91IG5lZWQgc2ltaWxhciBtZWNoYW5pc20gdG8g
c2V0dXAgbWF4IHR4L3J4IHF1ZXVlcyB0b28/DQo+ID4+Pj4+DQo+ID4+Pj4+IEN1cnJlbnRseSB3
ZSBkb27igJl0LiBUaGV5IGFyZSBkZXJpdmVkIGZyb20gdGhlIElPIGV2ZW50IHF1ZXVlcy4NCj4g
Pj4+Pj4gQXMgeW91IGtub3csIHNvbWV0aW1lcyBtb3JlIHR4cXMgdGhhbiBJTyBldmVudCBxdWV1
ZXMgbmVlZGVkIGZvcg0KPiA+Pj4+PiBYRFAsIHRpbWVzdGFtcCwgbXVsdGlwbGUgVENzLg0KPiA+
Pj4+PiBJZiBuZWVkZWQsIHByb2JhYmx5IGFkZGl0aW9uYWwga25vYiBmb3IgdHhxLCByeHEgY2Fu
IGJlIGFkZGVkIHRvDQo+ID4+Pj4+IHJlc3RyaWN0IGRldmljZSByZXNvdXJjZXMuDQo+ID4+Pj4N
Cj4gPj4+PiBSYXRoZXIgdGhhbiBkZXJpdmluZyB0eCBhbmQgcnggcXVldWVzIGZyb20gSU8gZXZl
bnQgcXVldWVzLCBpc24ndA0KPiA+Pj4+IGl0IG1vcmUgdXNlciBmcmllbmRseSB0byBkbyB0aGUg
b3RoZXIgd2F5LiBMZXQgdGhlIGhvc3QgYWRtaW4gc2V0DQo+ID4+Pj4gdGhlIG1heCBudW1iZXIg
b2YgdHggYW5kIHJ4IHF1ZXVlcyBhbGxvd2VkIGFuZCB0aGUgZHJpdmVyIGRlcml2ZQ0KPiA+Pj4+
IHRoZSBudW1iZXIgb2YgaW9ldmVudCBxdWV1ZXMgYmFzZWQgb24gdGhvc2UgdmFsdWVzLiBUaGlz
IHdpbGwgYmUNCj4gPj4+PiBjb25zaXN0ZW50IHdpdGggd2hhdCBldGh0b29sIHJlcG9ydHMgYXMg
cHJlLXNldCBtYXhpbXVtIHZhbHVlcyBmb3INCj4gPj4+PiB0aGUgY29ycmVzcG9uZGluZw0KPiA+
Pj4gVkYvU0YuDQo+ID4+Pj4NCj4gPj4+DQo+ID4+PiBJIGFncmVlIHdpdGggdGhpcyBwb2ludDog
SU8gRVEgc2VlbXMgdG8gYmUgYSBtbHg1IHRoaW5nIChvciBtYXliZSBJDQo+ID4+PiBoYXZlIG5v
dCByZXZpZXdlZCBlbm91Z2ggb2YgdGhlIG90aGVyIGRyaXZlcnMpLg0KPiA+Pg0KPiA+PiBJTyBF
UXMgYXJlIHVzZWQgYnkgaG5zMywgbWFuYSwgbWx4NSwgbWx4c3csIGJlMm5ldC4gVGhleSBtaWdo
dCBub3QNCj4gPj4geWV0IGhhdmUgdGhlIG5lZWQgdG8gcHJvdmlzaW9uIHRoZW0uDQo+ID4+DQo+
ID4+PiBSeCBhbmQgVHggcXVldWVzIGFyZSBhbHJlYWR5IHBhcnQgb2YgdGhlIGV0aHRvb2wgQVBJ
LiBUaGlzIGRldmxpbmsNCj4gPj4+IGZlYXR1cmUgaXMgYWxsb3dpbmcgcmVzb3VyY2UgbGltaXRz
IHRvIGJlIGNvbmZpZ3VyZWQsIGFuZCBhDQo+ID4+PiBjb25zaXN0ZW50IEFQSSBhY3Jvc3MgdG9v
bHMgd291bGQgYmUgYmV0dGVyIGZvciB1c2Vycy4NCj4gPj4NCj4gPj4gSU8gRXFzIG9mIGEgZnVu
Y3Rpb24gYXJlIHV0aWxpemVkIGJ5IHRoZSBub24gbmV0ZGV2IHN0YWNrIGFzIHdlbGwgZm9yDQo+
ID4+IGEgbXVsdGktIGZ1bmN0aW9uYWxpdHkgZnVuY3Rpb24gbGlrZSByZG1hIGNvbXBsZXRpb24g
dmVjdG9ycy4NCj4gPj4gVHhxIGFuZCByeHEgYXJlIHlldCBhbm90aGVyIHNlcGFyYXRlIHJlc291
cmNlLCBzbyBpdCBpcyBub3QgbXV0dWFsbHkNCj4gPj4gZXhjbHVzaXZlIHdpdGggSU8gRVFzLg0K
PiA+Pg0KPiA+PiBJIGNhbiBhZGRpdGlvbmFsbHkgYWRkIHR4cSBhbmQgcnhxIHByb3Zpc2lvbmlu
ZyBrbm9iIHRvbyBpZiB0aGlzIGlzIHVzZWZ1bCwNCj4geWVzPw0KPiANCj4gWWVzLiBXZSBuZWVk
IGtub2JzIGZvciB0eHEgYW5kIHJ4cSB0b28uDQo+IElPIEVxIGxvb2tzIGxpa2UgYSBjb21wbGV0
aW9uIHF1ZXVlLiBXZSBkb24ndCBuZWVkIHRoZW0gZm9yIGljZSBkcml2ZXIgYXQNCj4gdGhpcyB0
aW1lLCBidXQgZm9yIG91ciBpZHBmIGJhc2VkIGNvbnRyb2wvc3dpdGNoZGV2IGRyaXZlciB3ZSBu
ZWVkIGEgd2F5IHRvDQo+IHNldHVwIG1heCBudW1iZXIgb2YgdHhxdWV1ZXMsIHJ4cXVldWVzLCBy
eGJ1ZmZlciBxdWV1ZXMgYW5kIHR4IGNvbXBsZXRpb24NCj4gcXVldWVzLg0KPg0KVW5kZXJzdG9v
ZC4gTWFrZSBzZW5zZS4NCiANCj4gPj4NCj4gPj4gU3JpZGhhciwNCj4gPj4gSSBkaWRu4oCZdCBs
YXRlbHkgY2hlY2sgb3RoZXIgZHJpdmVycyBob3cgdXNhYmxlIGlzIGl0LCB3aWxsIHlvdSBhbHNv
IGltcGxlbWVudA0KPiA+PiB0aGUgdHhxLCByeHEgY2FsbGJhY2tzPw0KPiA+PiBQbGVhc2UgbGV0
IG1lIGtub3cgSSBjYW4gc3RhcnQgdGhlIHdvcmsgbGF0ZXIgbmV4dCB3ZWVrIGZvciB0aG9zZQ0K
PiBhZGRpdGlvbmFsDQo+ID4+IGtub2JzLg0KPiANCj4gU3VyZS4gT3VyIHN1YmZ1bmN0aW9uIHN1
cHBvcnQgZm9yIGljZSBpcyBjdXJyZW50bHkgdW5kZXIgcmV2aWV3IGFuZCB3ZQ0KPiBhcmUgZGVm
YXVsdGluZyB0byAxIHJ4L3R4IHF1ZXVlIGZvciBub3cuIFRoZXNlIGtub2JzIHdvdWxkIGJlIHJl
cXVpcmVkDQo+IGFuZCB1c2VmdWwgd2hlbiB3ZSBlbmFibGUgbW9yZSB0aGFuIDEgcXVldWUgZm9y
IGVhY2ggU0YuDQo+IA0KR290IGl0Lg0KSSB3aWxsIHN0YXJ0IHRoZSBrZXJuZWwgc2lkZSBwYXRj
aGVzIGFuZCBDQyB5b3UgZm9yIHJldmlld3MgYWZ0ZXIgY29tcGxldGluZyB0aGlzIGlwcm91dGUy
IHBhdGNoLg0KSXQgd291bGQgYmUgZ29vZCBpZiB5b3UgY2FuIGhlbHAgdmVyaWZ5IG9uIHlvdXIg
ZGV2aWNlLg0KDQo+ID4NCj4gPiBJIGFsc28gZm9yZ290IHRvIGRlc2NyaWJlIGluIGFib3ZlIHJl
cGx5IHRoYXQgc29tZSBkcml2ZXIgbGlrZSBtbHg1IGNyZWF0ZXMNCj4gaW50ZXJuYWwgdHggYW5k
IHJ4cXMgbm90IGRpcmVjdGx5IHZpc2libGUgaW4gY2hhbm5lbHMsIGZvciB4ZHAsIHRpbWVzdGFt
cCwgZm9yDQo+IHRyYWZmaWMgY2xhc3NlcywgZHJvcHBpbmcgY2VydGFpbiBwYWNrZXRzIG9uIHJ4
LCBldGMuDQo+ID4gU28gZXhhY3QgZGVyaXZhdGlvbiBvZiBpbyBxdWV1ZXMgaXMgYWxzbyBoYXJk
IHRoZXJlID4NCj4gPiBSZWdhcmRsZXNzIHRvIG1lLCBib3RoIGtub2JzIGFyZSB1c2VmdWwsIGFu
ZCBkcml2ZXIgd2lsbCBjcmVhdGUgbWluKCkNCj4gcmVzb3VyY2UgYmFzZWQgb24gYm90aCB0aGUg
ZGV2aWNlIGxpbWl0cy4NCj4gPg0K

