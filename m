Return-Path: <netdev+bounces-69997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FEB84D35B
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 21:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5124E286D7C
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 20:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949E3127B7F;
	Wed,  7 Feb 2024 20:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P/chRm6E"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FA18615A
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 20:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707339549; cv=fail; b=punev/uxPZ4667xgcrJp0xb8R/hpfCQkeeLIdrQismN7dFVyWH9lAdUPcTPvGAeO0565NDtgC5ymPPXiXgoSSOeyCIbjmXQ9zYOtqkDBRcz6O67jP9fl/uIqwYnTbUmziSPqrs9jYr3BLtRbW7nH6mDNufoMVbOnOqTiBc2wYrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707339549; c=relaxed/simple;
	bh=FTD0JMcCWNwb1NYQee9gzegD2SmcaD4mn49Y4EY4ywU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UcHMZg5/TMqLL2jqET2umDMhGXncvZlePRohYpmwYP5sqYRaC+44b9raHtRo7sxpA/IzCm+JBbSfJtdP+wvvk5HbeL8oBkFYW/6RYc0CluI4GdCvwW9OTXdhC8NoCxeyCWyuF/GghpRnXqmj2GKZyVm2XWmP0c6xtsG8Z9eI5U0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P/chRm6E; arc=fail smtp.client-ip=40.107.93.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=laekaEDEuS2rhpW0cLJvwQWuKjJVrv/WKkghAc4YDcgFEW6dOSP2gGTf9mSYQHrMZce/lW2BXgywzkiy/uze3ye+FRfbimF5T1tpZweCFQreAOOog2MlrH6pfpiKFvcmnjzZ+P7u++1uQx0s+sHq75J8u3rVRw4QhV92PAh8W61ATbu5bYPsyrgr5QRpduiKakIO/MCAyaC4TjQ4ENQzoyVkNv8P75QyDikV39CO5ZmCXHfW/obB+idKiwFkknPw9JZdWhiroA5+6QyuawqyEn/jLlxl4yB7mNFlWNlt6ONJxrcPyxwtI3m/yNWW/+YU9f+VDeB6kDqGS1sxSL586g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FTD0JMcCWNwb1NYQee9gzegD2SmcaD4mn49Y4EY4ywU=;
 b=Afz8BfRLrPTOwAkxM185BCbWYmw5Jf0R6Gjs3M5Pm17RAovgvS83T0fCmtu+YfUwvapvZCnVtNgs0OoyNx23Skl0sjpG9tCtIklDJq+nafmQsmc6oCKBk7FzwrBmvEqliYhP9jILXWrgDjcW2usO0D2DlZmPiixLUKJmX5dHJgNj95Tc8d0Kj3+9G6y3ah+alSuYxoXjy48dWPkESUgTIddbae5O+RoR2ZJXmWwTzyFW0LZwi6L5b+oglm4rybug3+cWQL0TdHuZjrWiptLhE8quIv0YfaVN8tJOqv5KPIecnsLBYITNp6O2wNyj+XOfkrlZ4uTPwR+XGmC/GvR+4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTD0JMcCWNwb1NYQee9gzegD2SmcaD4mn49Y4EY4ywU=;
 b=P/chRm6E/g4cbZSQiDoEyAaMpLhFn7QMVJMpReHYmsPqKUn0ZQA45H/NTu4SRlhzYlm3MVuCYilQB/FYyhr3AG22cEcWAWjyLlEbD8SoC9cKfLc4rhVNS0CffoDjQK0vwBq3yuAgJ9e6zoU+5IZnjjsHxjPuE58nQfATXC+GRzT5PWx5IaEhpRh8Y7J0rALKNQ5PVN/RN5qJFZ9B10soF+CN/h0C2bEpwNwa5sBh8y3fhhFFx2ilCI9iu0a+vZOO16NX6Vmfmlxk9tTZyl3vuq7ugkwM4NG6poaQSGegIsEJVptalqUMiCvMPOmeaPKY+BBAKmgsf7mn+r5Zvlqvcw==
Received: from CH0PR12MB8580.namprd12.prod.outlook.com (2603:10b6:610:192::6)
 by BL1PR12MB5288.namprd12.prod.outlook.com (2603:10b6:208:314::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.15; Wed, 7 Feb
 2024 20:59:05 +0000
Received: from CH0PR12MB8580.namprd12.prod.outlook.com
 ([fe80::8825:1827:3273:bbbf]) by CH0PR12MB8580.namprd12.prod.outlook.com
 ([fe80::8825:1827:3273:bbbf%3]) with mapi id 15.20.7270.016; Wed, 7 Feb 2024
 20:59:05 +0000
From: Daniel Jurgens <danielj@nvidia.com>
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
 AQHaU4g6jvRyzH1tPUCIs6q7Q9im2rDycmwAgAAGRTCAAAXXAIAAAcJwgAABlYCAABui0IAAnRGAgAM82ACAACpvgIAAmT0AgAIuegCAAL3LAIAFK2+AgAAL9ACAAAOK0A==
Date: Wed, 7 Feb 2024 20:59:04 +0000
Message-ID:
 <CH0PR12MB8580846303702F68388E9713C9452@CH0PR12MB8580.namprd12.prod.outlook.com>
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
In-Reply-To: <20240207151748-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB8580:EE_|BL1PR12MB5288:EE_
x-ms-office365-filtering-correlation-id: 6866bb9e-0c14-44b7-cc75-08dc281f9e9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 CwVPwwOeihX65SnwVQ0TKmaIByqRKQ1IZlgLBHvuNJ6D4faWgPKCk783Ij6W+5X8/ieiXHQdQhJdRTernfx2rd7FZuQ2EIbukqIaATWt1/1qRjlV5mgtS7bd8Mt3hcIjcaXHtCH05rtw9JgdtU7QS424+SLF648QcJ/r0g/q6rV98tsb4MtFg8eR5MHKJmAuFAyfGndwG7dEBLxSHwndZ56P64hVz3IlRqnPn3a2XvWifjYwSNRPwkm0orAtXitEVfp+ssRinXcOvccZbhCIIlbzn6R2n7Hc6sE5nhV9Z0mbWrY72Nh0E+30iyu0UsAfjr7KxzD7ww2skX9FLE9zOOHHT4p8UV0tEESNyTojrvDmvIcIiXfDbgXa805Rk14f4k25UVjjkbNNgqsGJ2ulFhCbISFNgIgId5j2NtUykzBkvDqXCB3b2nzo37LB9oaHrttw4XTeTbclubL2pfu6qIHapmhesdqAbZ4F/ymQR8Hr2nm9oM2/2jNRK7LsKJSic8mUgsSLYDbtREMltiYbTgsrmIXn3KGa0eI5vCwBVZOMBYed9bsigmXqX4THTQfuJ2GvAGT+fAVB7Cw6hVKSHkviKpkxitKrpfpOBFjMR/IZlCBTJVg+m2rAv3yowWoKLVZ2GRxlWgW39FEkaNGsFBT0emKr5m7BNJAO4CRCxfU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB8580.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(396003)(346002)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(122000001)(33656002)(26005)(83380400001)(478600001)(966005)(7696005)(6506007)(53546011)(9686003)(38070700009)(55016003)(86362001)(107886003)(66446008)(66556008)(66946007)(66476007)(316002)(6916009)(4326008)(54906003)(64756008)(8676002)(8936002)(38100700002)(71200400001)(76116006)(52536014)(41300700001)(5660300002)(2906002)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YmJodjBKZVNwOE9WVldDc1hpVWE5WFp4QnJPdk1xa2V3Unh3dktJMjlHaFR4?=
 =?utf-8?B?azdPMHg1ODNaa3Y3SFZWdC9oeXo4QWNjUWd3MHh5MlhVMzBFVGJ0ZmFZd0Q4?=
 =?utf-8?B?NndMcVlLU3h1YTAzWklGaHpsaW9DYjlVYkZ3U1pWQWkwclBRWGRpck94SVFw?=
 =?utf-8?B?OUYzK0hYb3pJTmYyeUEzZ2ovc2FpRW92V01kOHlVNk5WdnlnVTRzdjVzTng0?=
 =?utf-8?B?ZWZDRW16MmdTV1J1TDM2ZW5uNjlzTVV2Skt4aGEwUStua3FYRCtGRzVGaDJE?=
 =?utf-8?B?cDJadFBDR0Y4ZEozK2k1aWpIU2Fma3VtUlFjSW9qM1hQWFYyZ1ZFTWNVMEd2?=
 =?utf-8?B?WE4zWGRjQTAvdXA0K280ZURRMkVnNk9XNnNjaWZGNzhWeFhDUFBWZ0FpRHYw?=
 =?utf-8?B?Z0xBd0VHeGpOektYWjYwQTR5cElCYVFyYnZNVnQ3WkpZMjNjYW14MTNVWFlY?=
 =?utf-8?B?anplcVExN21YWkJkYWxjZ0pvZ2VxNHZhV0dmeGVhdkl2MmpYaXVaK2drV2FE?=
 =?utf-8?B?VExsVGNsQmZvaFBrdUtmQmtpTFJvbDcwTzlDRnFXemRsVVE4S0VjT1J0QXYx?=
 =?utf-8?B?cTV6TXoySHFUZDZ3K0hTVkRMQW1na254cFFYNUx4OS9HVnRTczBjSTFxekc0?=
 =?utf-8?B?cXI5YUhXQWc3dWpEQ0ZJZDQrSkhmLzc4QmxiMjFPeFFjYlowRTk4QUNQaVRq?=
 =?utf-8?B?b0kxcHYxRlhCMGRXNDgwRTNKdE56NDlQbkQvM1c0OXZ1bmE5d3lwSXl6UG15?=
 =?utf-8?B?bkpwVEE2N2h1dmdGV1c3MDc5Wk1uWkJGYWxRY2V2MjdpYUg1YUtMSWlVK0Fk?=
 =?utf-8?B?elp4Q1Q3ZUZPZG5rOWg3dndtdFNKeFN4aXJEanN3ZWRERDRpaThIS3JMWCtW?=
 =?utf-8?B?UTRVY3dqSThROXlFSS95OFVWM01sYzQxemhkVlREK2FUZ2lVRjlJM0dBMG95?=
 =?utf-8?B?c3JvaWZqVzdoOW81ZHVYS0NadkJzZDM4WFNzMnBCVzQxQUV3L0dUQ1NrUVFL?=
 =?utf-8?B?SWovb21lTTZQMjdJRFhndDlUa3dxUmVhaVZJOEJJUG9TQlpIeHptdkY4SVZv?=
 =?utf-8?B?MXRTY2dPRXUwd2JCcFQxZ0VSUytRZWFzNFR3bWJQczZNM1N3S3dWVXVWOWpy?=
 =?utf-8?B?NElTaHM1VWJ6VC8wQ3JFQVV3eUJmMkpwd3NSekNNc3REbE9EcGEzeWFWd01W?=
 =?utf-8?B?ODVlVHJON1JDUnFmOXcrMzRUZlY2Y05kRlpJUlFnUTlEODhUT0hJWXJEcExn?=
 =?utf-8?B?Q25TOTRqZTJsdFB5VmJaTVZMQnlMcTZmWDRvdEg2YWZvbVV4SzJYdlBFdDlx?=
 =?utf-8?B?RmRoRFducFZlRS9XK0lnbWp5MWFiV0wyUXoraU1VcnNndy9FSmxUaGNsc0dQ?=
 =?utf-8?B?VDQwVVc0NnA5SDUzSmNiUytQUDN5L0I0TFBQZ3JWV3BERDVFZkVLd0tLbUQ4?=
 =?utf-8?B?SDJLQjYzeU1WRXhGWUFqNnZaOXA3SCtxbnUyTzNIRGlUVG1kQzFtWDBoL2Y4?=
 =?utf-8?B?LzVNZmdMMk1qQ3lBdVhmbFJzTGJmWDZ6SDBJelhJQ3QzdUJ5YU83SXJLL3Ew?=
 =?utf-8?B?eU5HRDU2c0U0THZEcS9CYmlWMlErRzNxVFFteW5TTFcxR0s4S2hCVVlMOG1Z?=
 =?utf-8?B?VE5mTWRjeTZnOURhbS90QnVJNG9LOW40NUFEbFJUc1Q5azZ5VnpPVlZBdERm?=
 =?utf-8?B?U3BLZjRuTGhPU3F2VG54YVVzOGhRUTIxcm0rL3V1Nkh6WTNhaHgzSWwwZW4v?=
 =?utf-8?B?UUdGYkw0WnU5Nkw2K2pveXdCTUZwWlV5bm1kbEMrbXQvNXpscFNrdzB0d0ND?=
 =?utf-8?B?WUMrN1c1Qkl1cmZsTlpUdjVJSXoxWUcrTER4UUVRMTNmeUl6RVpXMG54SXYr?=
 =?utf-8?B?WEdqS1BrNzFWOHVsMEdkYmF6aHNxUk9zYjdBRWZZcVJ2RkYwdkV2TDJKSGN2?=
 =?utf-8?B?RVZoR0hGMXZRY2sxbVJYK0lWUzlJQTV3ck9KU1VCN3dtVW9PeWhleGNNRHZU?=
 =?utf-8?B?NmY5NXJDV0xlTGhXODhSYmNqKzFjemdZRi84K3RWdm5hcmU3MVBueDZLUHlm?=
 =?utf-8?B?dkdUWk53R2ZsZGhTOFkwMmVlRFRjRm5HcjQ3UHhCYkMvSG9KQUlzcFpFSVF0?=
 =?utf-8?Q?EIuQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6866bb9e-0c14-44b7-cc75-08dc281f9e9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2024 20:59:04.9565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aGUVYBe6Q4UTL5r1Imn+9Qb7fjHDuPy3Qxsvg8fjZiHzk6HDML3kEIrlZG8yFuYTTGwuivDCTq0i1RoKHD3QKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5288

DQo+IEZyb206IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+DQo+IFNlbnQ6IFdl
ZG5lc2RheSwgRmVicnVhcnkgNywgMjAyNCAyOjE5IFBNDQo+IFRvOiBEYW5pZWwgSnVyZ2VucyA8
ZGFuaWVsakBudmlkaWEuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIG5ldC1uZXh0XSB2aXJ0
aW9fbmV0OiBBZGQgVFggc3RvcCBhbmQgd2FrZSBjb3VudGVycw0KPiANCj4gT24gV2VkLCBGZWIg
MDcsIDIwMjQgYXQgMDc6Mzg6MTZQTSArMDAwMCwgRGFuaWVsIEp1cmdlbnMgd3JvdGU6DQo+ID4g
PiBGcm9tOiBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPg0KPiA+ID4gU2VudDog
U3VuZGF5LCBGZWJydWFyeSA0LCAyMDI0IDY6NDAgQU0NCj4gPiA+IFRvOiBKYXNvbiBXYW5nIDxq
YXNvd2FuZ0ByZWRoYXQuY29tPg0KPiA+ID4gQ2M6IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5l
bC5vcmc+OyBKYXNvbiBYaW5nDQo+ID4gPiA8a2VybmVsamFzb254aW5nQGdtYWlsLmNvbT47IERh
bmllbCBKdXJnZW5zIDxkYW5pZWxqQG52aWRpYS5jb20+Ow0KPiA+ID4gbmV0ZGV2QHZnZXIua2Vy
bmVsLm9yZzsgeHVhbnpodW9AbGludXguYWxpYmFiYS5jb207DQo+ID4gPiB2aXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC5kZXY7IGRhdmVtQGRhdmVtbG9mdC5uZXQ7DQo+ID4gPiBlZHVtYXpldEBn
b29nbGUuY29tOyBhYmVuaUByZWRoYXQuY29tOyBQYXJhdiBQYW5kaXQNCj4gPiA+IDxwYXJhdkBu
dmlkaWEuY29tPg0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCBuZXQtbmV4dF0gdmlydGlvX25l
dDogQWRkIFRYIHN0b3AgYW5kIHdha2UNCj4gPiA+IGNvdW50ZXJzDQo+ID4gPg0KPiA+ID4gT24g
U3VuLCBGZWIgMDQsIDIwMjQgYXQgMDk6MjA6MThBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToN
Cj4gPiA+ID4gT24gU2F0LCBGZWIgMywgMjAyNCBhdCAxMjowMeKAr0FNIEpha3ViIEtpY2luc2tp
IDxrdWJhQGtlcm5lbC5vcmc+DQo+IHdyb3RlOg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gT24gRnJp
LCAyIEZlYiAyMDI0IDE0OjUyOjU5ICswODAwIEphc29uIFhpbmcgd3JvdGU6DQo+ID4gPiA+ID4g
PiA+IENhbiB5b3Ugc2F5IG1vcmU/IEknbSBjdXJpb3VzIHdoYXQncyB5b3VyIHVzZSBjYXNlLg0K
PiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IEknbSBub3Qgd29ya2luZyBhdCBOdmlkaWEsIHNvIG15
IHBvaW50IG9mIHZpZXcgbWF5IGRpZmZlciBmcm9tDQo+IHRoZWlycy4NCj4gPiA+ID4gPiA+IEZy
b20gd2hhdCBJIGNhbiB0ZWxsIGlzIHRoYXQgdGhvc2UgdHdvIGNvdW50ZXJzIGhlbHAgbWUgbmFy
cm93DQo+ID4gPiA+ID4gPiBkb3duIHRoZSByYW5nZSBpZiBJIGhhdmUgdG8gZGlhZ25vc2UvZGVi
dWcgc29tZSBpc3N1ZXMuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiByaWdodCwgaSdtIGFza2luZyB0
byBjb2xsZWN0IHVzZWZ1bCBkZWJ1Z2dpbmcgdHJpY2tzLCBub3RoaW5nDQo+ID4gPiA+ID4gYWdh
aW5zdCB0aGUgcGF0Y2ggaXRzZWxmIDopDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IDEpIEkgc29t
ZXRpbWVzIG5vdGljZSB0aGF0IGlmIHNvbWUgaXJxIGlzIGhlbGQgdG9vIGxvbmcgKHNheSwNCj4g
PiA+ID4gPiA+IG9uZSBzaW1wbGUgY2FzZTogb3V0cHV0IG9mIHByaW50ayBwcmludGVkIHRvIHRo
ZSBjb25zb2xlKSwNCj4gPiA+ID4gPiA+IHRob3NlIHR3byBjb3VudGVycyBjYW4gcmVmbGVjdCB0
aGUgaXNzdWUuDQo+ID4gPiA+ID4gPiAyKSBTaW1pbGFybHkgaW4gdmlydGlvIG5ldCwgcmVjZW50
bHkgSSB0cmFjZWQgc3VjaCBjb3VudGVycw0KPiA+ID4gPiA+ID4gdGhlIGN1cnJlbnQga2VybmVs
IGRvZXMgbm90IGhhdmUgYW5kIGl0IHR1cm5lZCBvdXQgdGhhdCBvbmUgb2YNCj4gPiA+ID4gPiA+
IHRoZSBvdXRwdXQgcXVldWVzIGluIHRoZSBiYWNrZW5kIGJlaGF2ZXMgYmFkbHkuDQo+ID4gPiA+
ID4gPiAuLi4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBTdG9wL3dha2UgcXVldWUgY291bnRl
cnMgbWF5IG5vdCBzaG93IGRpcmVjdGx5IHRoZSByb290IGNhdXNlDQo+ID4gPiA+ID4gPiBvZiB0
aGUgaXNzdWUsIGJ1dCBoZWxwIHVzICdndWVzcycgdG8gc29tZSBleHRlbnQuDQo+ID4gPiA+ID4N
Cj4gPiA+ID4gPiBJJ20gc3VycHJpc2VkIHlvdSBzYXkgeW91IGNhbiBkZXRlY3Qgc3RhbGwtcmVs
YXRlZCBpc3N1ZXMgd2l0aCB0aGlzLg0KPiA+ID4gPiA+IEkgZ3Vlc3MgdmlydGlvIGRvZXNuJ3Qg
aGF2ZSBCUUwgc3VwcG9ydCwgd2hpY2ggbWFrZXMgaXQgc3BlY2lhbC4NCj4gPiA+ID4NCj4gPiA+
ID4gWWVzLCB2aXJ0aW8tbmV0IGhhcyBhIGxlZ2FjeSBvcnBoYW4gbW9kZSwgdGhpcyBpcyBzb21l
dGhpbmcgdGhhdA0KPiA+ID4gPiBuZWVkcyB0byBiZSBkcm9wcGVkIGluIHRoZSBmdXR1cmUuIFRo
aXMgd291bGQgbWFrZSBCUUwgbXVjaCBtb3JlDQo+ID4gPiA+IGVhc2llciB0byBiZSBpbXBsZW1l
bnRlZC4NCj4gPiA+DQo+ID4gPg0KPiA+ID4gSXQncyBub3QgdGhhdCB3ZSBjYW4ndCBpbXBsZW1l
bnQgQlFMLCBpdCdzIHRoYXQgaXQgZG9lcyBub3Qgc2VlbSB0bw0KPiA+ID4gYmUgYmVuZWZpdGlh
bCAtIGhhcyBiZWVuIGRpc2N1c3NlZCBtYW55IHRpbWVzLg0KPiA+ID4NCj4gPiA+ID4gPiBOb3Jt
YWwgSFcgZHJpdmVycyB3aXRoIEJRTCBhbG1vc3QgbmV2ZXIgc3RvcCB0aGUgcXVldWUgYnkNCj4g
dGhlbXNlbHZlcy4NCj4gPiA+ID4gPiBJIG1lYW4gLSBpZiB0aGV5IGRvLCBhbmQgQlFMIGlzIGFj
dGl2ZSwgdGhlbiB0aGUgc3lzdGVtIGlzDQo+ID4gPiA+ID4gcHJvYmFibHkgbWlzY29uZmlndXJl
ZCAocXVldWUgaXMgdG9vIHNob3J0KS4gVGhpcyBpcyB3aGF0IHdlIHVzZQ0KPiA+ID4gPiA+IGF0
IE1ldGEgdG8gZGV0ZWN0IHN0YWxscyBpbiBkcml2ZXJzIHdpdGggQlFMOg0KPiA+ID4gPiA+DQo+
ID4gPiA+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjQwMTMxMTAyMTUwLjcyODk2
MC0zLWxlaXRhb0BkZWJpYQ0KPiA+ID4gPiA+IG4ub3INCj4gPiA+ID4gPiBnLw0KPiA+ID4gPiA+
DQo+ID4gPiA+ID4gRGFuaWVsLCBJIHRoaW5rIHRoaXMgbWF5IGJlIGEgZ29vZCBlbm91Z2ggZXhj
dXNlIHRvIGFkZA0KPiA+ID4gPiA+IHBlci1xdWV1ZSBzdGF0cyB0byB0aGUgbmV0ZGV2IGdlbmwg
ZmFtaWx5LCBpZiB5b3UncmUgdXAgZm9yDQo+ID4gPiA+ID4gdGhhdC4gTE1LIGlmIHlvdSB3YW50
IG1vcmUgaW5mbywgb3RoZXJ3aXNlIEkgZ3Vlc3MgZXRodG9vbCAtUyBpcyBmaW5lDQo+IGZvciBu
b3cuDQo+ID4gPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gVGhhbmtzDQo+ID4NCj4gPiBNaWNoYWVs
LA0KPiA+IAlBcmUgeW91IE9LIHdpdGggdGhpcyBwYXRjaD8gVW5sZXNzIEkgbWlzc2VkIGl0IEkg
ZGlkbid0IHNlZSBhIHJlc3BvbnNlDQo+IGZyb20geW91IGluIG91ciBjb252ZXJzYXRpb24gdGhl
IGRheSBJIHNlbnQgaXQuDQo+ID4NCj4gDQo+IEkgdGhvdWdodCB3aGF0IGlzIHByb3Bvc2VkIGlz
IGFkZGluZyBzb21lIHN1cHBvcnQgZm9yIHRoZXNlIHN0YXRzIHRvIGNvcmU/DQo+IERpZCBJIG1p
c3VuZGVyc3Rvb2Q/DQo+IA0KDQpUaGF0J3MgYSBtdWNoIGJpZ2dlciBjaGFuZ2UgYW5kIGdvaW5n
IHRoYXQgcm91dGUgSSB0aGluayBzdGlsbCBuZWVkIHRvIGNvdW50IHRoZW0gYXQgdGhlIGRyaXZl
ciBsZXZlbC4gSSBzYWlkIEkgY291bGQgcG90ZW50aWFsbHkgdGFrZSB0aGF0IG9uIGFzIGEgYmFj
a2dyb3VuZCBwcm9qZWN0LiBCdXQgd291bGQgcHJlZmVyIHRvIGdvIHdpdGggZXRodG9vbCAtUyBm
b3Igbm93Lg0KDQo+IC0tDQo+IE1TVA0KDQo=

