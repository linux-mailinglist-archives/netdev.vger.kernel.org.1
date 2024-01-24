Return-Path: <netdev+bounces-65661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2862C83B491
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 23:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E24F1C21F27
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 22:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1FC135411;
	Wed, 24 Jan 2024 22:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Zvv2qF0c"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFE21350DA
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 22:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706134706; cv=fail; b=tWrf2U7+UewL+w6UOcEF3CqAvImpm26R/NMQtvFlVuV2esjda28Si2zhP3JvKdePQwPmjPsgljrFhaIfP73/ptmj0wQwvdmQYNl4N2U0T7hZWdZI1DlQh6uZdnDurV/J5h8nj+L7CpKonzc0cERitDjkGZajqb9R4XmcV4r1n0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706134706; c=relaxed/simple;
	bh=aTDlrlzj7JUtFk+Oo9pIXQRA4pEBQ+XzWuWikCOXPrg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dyxCnM0YZBTN/qxp3VOS0TwXonDBCnw2UM3BgaMWbF7T5xL/pmpr21zEo0ByruyxRJwf44nMRRDg+7FmeyYs1QpFyDH7ze8agnXPNJgSKjki8C3vbZaAYPDW4l2sYSjNUvm28bwsYnwMGf079Fco85fPS6TChnnvPPZWr5PqXaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Zvv2qF0c; arc=fail smtp.client-ip=40.107.220.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lTewAIFwkWx3rFKeYAcaHb+weq+aT68iHRg9AL8yBBaMBp3uXGAs8mRsGx3NwjN/8jOBXGuJeopQGWn7vARWkH071SuW6ktrMc7ClcpN9QWUTo2n2BTM1Zb/GR0vLMP674+ftE/yQ0tTFQns2EMMOzhoI8kh7TiHUw7OFhJtoxoYZGJbMRnXsqDUpZVDQBjlgpVO1VkyO4SahanQs4KtacZ+p3nQWXs1VTKMczF+c6AscfATO3ORQesyCsMJYU4jxUd9cTf0F5Wl6LbDBK0O1bdi1INuEI1zIBnM2IBcIVXiLqlzMTWmOl+/jp49jmg2H/qhw67BkgkRjmJnyeqk3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aTDlrlzj7JUtFk+Oo9pIXQRA4pEBQ+XzWuWikCOXPrg=;
 b=ApbW4KSA7En05oarh5oiLZteE5xB4QVgGXQRR7je7RYmyl4yEm8nR6RjHxAn3oQVurOoos24cCErRnrh/ULdvIDN50LF8pJ5wO77/2r0boaXRaEEINGImDZHpnSpZpsDrMUJljWSoXbHEW64e14mw5ADeIdPPowbKJsD5WomKCduGe+K9kmAlkEWk/cXPiLmukic0A0nG/QCGd0LaSuXswcmdIpbL20K9wqsrSEiHRgYPprWXPo2mqRQ81baZIJ1oa9HGWwH+XToCw2Ndy34jr2mVFwFJV6MfdLVyd8gU9BaNM9IkjQbSOmwS3sjNslJyw4UEJKNqlVNDceeDQWB9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTDlrlzj7JUtFk+Oo9pIXQRA4pEBQ+XzWuWikCOXPrg=;
 b=Zvv2qF0cBW+ehEzrE3DHvMtp1k+ZUbQq9proYfPR9lfdwC3jghzDLEX8RBMKbC85i7WbVEdwD78TeA66ojAPtqXEeZrK/juPH78gAS67eVy4Vvr/C0r4EwQOaSVHrwTtdKntc0KKh+j+FHzLgBB/LmCujgSmOLla+RzJz4oiZSJ/ZhkbEnHraG42pbKCNQuyo13qehe0wryoON7iYVvC47YG0325jznte318s8XxZPJW7nWtYqiXQY80lsdsPG+vtDC8fEYAjQMFexuCnVAzDckGfaKNhMVkNMn75L4gq9RZbAydZd5K8sp1GdUQPlvSfG6Gg2x7R/lWhAlOF5JYKg==
Received: from PH7PR12MB7282.namprd12.prod.outlook.com (2603:10b6:510:209::7)
 by BN9PR12MB5353.namprd12.prod.outlook.com (2603:10b6:408:102::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24; Wed, 24 Jan
 2024 22:18:21 +0000
Received: from PH7PR12MB7282.namprd12.prod.outlook.com
 ([fe80::f245:9cfe:fe84:ae14]) by PH7PR12MB7282.namprd12.prod.outlook.com
 ([fe80::f245:9cfe:fe84:ae14%4]) with mapi id 15.20.7202.034; Wed, 24 Jan 2024
 22:18:20 +0000
From: Asmaa Mnebhi <asmaa@nvidia.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "Russell King (Oracle)" <linux@armlinux.org.uk>, "davem@davemloft.net"
	<davem@davemloft.net>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	David Thompson <davthompson@nvidia.com>
Subject: RE: [PATCH v1 1/1] net: phy: micrel: Add workaround for incomplete
 autonegotiation
Thread-Topic: [PATCH v1 1/1] net: phy: micrel: Add workaround for incomplete
 autonegotiation
Thread-Index:
 AQHaOAaE4SV+OFEcQEq30M+e72jYobDG55uAgABwPwCAGjhxMIAAH2YAgAAEHpCAACx6AIAAAv9QgAfSw3A=
Date: Wed, 24 Jan 2024 22:18:20 +0000
Message-ID:
 <PH7PR12MB7282E7132837B38AC6982B1DD77B2@PH7PR12MB7282.namprd12.prod.outlook.com>
References: <20231226141903.12040-1-asmaa@nvidia.com>
 <ZZRZvRKz6X61eUaH@shell.armlinux.org.uk>
 <99a49ad0-911b-4320-9222-198a12a1280e@lunn.ch>
 <PH7PR12MB7282DEEE85BE8A6F9E558339D7702@PH7PR12MB7282.namprd12.prod.outlook.com>
 <a6487dbc-8f86-447a-ba12-21652f3313e8@lunn.ch>
 <PH7PR12MB7282617140D3D2F2F84869DBD7702@PH7PR12MB7282.namprd12.prod.outlook.com>
 <f35fa6b9-ed6f-461b-a62d-326fa401bc88@lunn.ch>
 <PH7PR12MB7282CE51CB37C0D67EC6DA7DD7702@PH7PR12MB7282.namprd12.prod.outlook.com>
In-Reply-To:
 <PH7PR12MB7282CE51CB37C0D67EC6DA7DD7702@PH7PR12MB7282.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7282:EE_|BN9PR12MB5353:EE_
x-ms-office365-filtering-correlation-id: d9c5d797-f374-4448-66b7-08dc1d2a5f78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 WQnpV3uCJUuAcZfHftxQ14ibTmAbYvVFnMPHtR9OZpyckr1eBzvOn1h1eKraNUh33rAszCVe7L3+W6R/MECj+tq1BdSoZsdSnlsGS3Tn+A6c8LgWSTRoilCax07ueRIWiX1thzgvf7ylc7k2D2vQtWSKLIvYBBCl3f151wBG1YH1ODzynHn48tIFvBkCll1hVlfmcQssjYPZZso9ZxSHyUqVaiJ1SHVJZC+CYddnwX6WDukIc/MsuEKJ1biAtZ3TLwAPQQVNPtWE4Nr20YsWJ9w6gAfnr2lvt6IzeOgHcqxPnh8/vzAz2phi8MWtD8d00nkC0UamVsfl+tezBgx9yj+53DcMXRhyDWPtT8Tpa3Ds0CW6W/aA2IeXeH1PqOaarSop2ZdRFS0Yx4G8KZ2OK5OGkM6CeKVcoVkkFcwyoaVfS1ODut+Ic8MVLY6EzJAy+C/YvweezsxwV37CW4VBPcrgWNB9c/Qbcu4DxTtl7Il9hSdkuj2ZsMpRYXY3VzLc/J7ChCKtChoVpMxGBGCgYvr1e1lqJOoaL7ndz3KE10YTQvg0Ly1ZVauF1NwtALutqqalSQN0ga0OSTcSckyBKW80QXb+FcMnLA3swJCOPd+P6y81Yf/0ApNGKQq99FdEsPsenB3UW2QUHpmyYTFE4g==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7282.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(376002)(366004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(41300700001)(107886003)(55016003)(26005)(38100700002)(38070700009)(478600001)(83380400001)(6506007)(7696005)(9686003)(71200400001)(122000001)(5660300002)(66446008)(64756008)(66476007)(66556008)(2906002)(76116006)(66946007)(316002)(33656002)(54906003)(86362001)(6916009)(8936002)(8676002)(4326008)(52536014)(111480200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UXk2SU56bytHbkVwS1ExUUlSYWZTTW5sOFZZSGY4bjJLZUR4WlB1d0pFeEs3?=
 =?utf-8?B?dzBEQ1hjL21vMHhya2xCN0hyN3Mxd1psUmJ0ZWRvL05rd2IwanRJOFFyb1Rn?=
 =?utf-8?B?Sk9PKzZmMTJwQUlPN1Jsa1dWZ2VPZFY4WVNkUytGWTZwVE5LS0dwZDlqUC8y?=
 =?utf-8?B?L3QyWDIyZ0NaeFA4VU5KcVcwbUsxaXdFZHRUUElCazB3NDFXYkxJNThhN3pi?=
 =?utf-8?B?bURkNE52LzVwdzV3bk10Q0xIMjFNS1d3S2t0bWdlNU9MM1dCYk14WW9tNHo2?=
 =?utf-8?B?eXEzQnh1ZWsxOGg2UytkY3hTeHo4V1FJZWZwRXdYQnNMc1hQRHpkL2UwWWV5?=
 =?utf-8?B?biszM1picldzaXpHeFA5NWtmcmdWdUl4b2VicHZoKzlxNk5EL3dmQk1hL21C?=
 =?utf-8?B?RCt5VW5nOXcxdjV3dGJ0ZEt3OXIxUlk3b2Y5d2dvM2lBdk5tZWhyNld2NnM4?=
 =?utf-8?B?NzY4WWVOL0dHK1hIZDVDNGFnTWgvUFd3NGtGTHlkenZqZnJvQmczaUFJOENC?=
 =?utf-8?B?eXQ4VjkvNkV4c2crVnlZKzdWNHV0amtHUW9vd09tTStTMGJmbGZ1d3BMK2kw?=
 =?utf-8?B?dmJjeFFiNzBHdEY0VksxM2NqaFZabzR3SHdGenBaNVovSnNTMUVXMUszWUxV?=
 =?utf-8?B?L1FQOEIyTk1UMTJCa3BreS9aL0NMT05TOS80UDQ4SjByMjNoUjYyWGJ1RVAz?=
 =?utf-8?B?S1l0VnE0RHlXNllmYSszYndMV3gya0VUckloZUducm1RRTBvNXVJSWJrblFl?=
 =?utf-8?B?eURCUWhodjFSR09FeEJ1d3o0YXo2eW5sNFVoa05wLy9reGdkd0dKWS9UdFdK?=
 =?utf-8?B?VUhiREsrT1pUL0hKeU1EelVvS2NkSDkrWkh6V2FFSXJiMllEY25yT1RhRVhn?=
 =?utf-8?B?a0FVMzVrSlRjaFFsaTdNZVFQZDB2eDBJekF6UUc4bnlnVlFlZkVsL2J6OGY3?=
 =?utf-8?B?bXZ1aVpobHlhSDVVVGNmMkNBVm9sNDBZV1RLdTVVZFRRQ3NzbytDalcwRDcr?=
 =?utf-8?B?czI3bkROYUxoS2xHTzlBWTljWGh5dEVJSHZOQjJ3eldDZUZVQUMxS3RubW4y?=
 =?utf-8?B?ZkR4R3FPaTdnSEg3dC8xNDlzOXRQbzEyczl2eHhFMWhEMjVjWHFuQTVCM21G?=
 =?utf-8?B?M1hQL3BEWjZCejlGOTFqVWNnNHh3WkhvT2pYR0lqL2FaNzhhdUh3dStXVys0?=
 =?utf-8?B?Rk4vMXZrRERFQ2VMQzUrOW5INjVHOWhLM2dnbFNJakMxVzh3akxSTms1SXky?=
 =?utf-8?B?ZU5DbzFMWHd2TUNkQVRPNDdBNUJMRjJjbHZFVVJrcjFSR0pkdzYvZDRsa0g4?=
 =?utf-8?B?bGJhZXk3bE5NNXQvOEd6dlBNN0xsYUNxU1owMG8wREhlem00bkJuYW94aWs4?=
 =?utf-8?B?NXgwNXFKTVFXVkxNc3hQYlFwUG9lWXJnRDUvRlFWRHdDL3MvV3FjM0FpQWk0?=
 =?utf-8?B?WGpmeEFZYUdKcWVPYVRLSlVvT3A5L2dOTzZNLzJvMlkxb3hWc01OWk1GcUZZ?=
 =?utf-8?B?bmt5ZUkvL1B6dm9qR0JRSytXQ0Y1MSsrK1I1TFgvTGdRbkRRRGo0OVZ1OWxC?=
 =?utf-8?B?RDc1Y3d5cVR5M1hoNzBJY2VjYVlDcXpYb0hsMk9WS28wK0JYVWdCeGhpSHlE?=
 =?utf-8?B?dWFnV0dCUGdScVowNWs5Y1d6STkwZkVOMGRzWElLSXpXY0hmUVNwVWtrdnhC?=
 =?utf-8?B?Z2VwcHNEajQ1cXF6aWdhekd5NXFXOVY4TnNKdTkyUDlQdkxzZzNhQ3VoZmI2?=
 =?utf-8?B?aC81RnpmNHhIMXdxS0JteStQandjSTI0VU9jUGxkRzhubnlTbVplUUVyOFJ3?=
 =?utf-8?B?TmUrdEN4YVBmOEZGZDJBdnpzOWdQbWJtWWp5bmZOb1BJQkdZSCtMd3NKVm1S?=
 =?utf-8?B?ZTJwVXJ6enVuUEJLYmNtbzhSM2I4eEhlYW55ZXYySmM2S3VRUDQ3TDU0R2hs?=
 =?utf-8?B?eW9IZFU1TCtVWW9tWnh5ZWJhbU93R1dRbTVhOXRhY25oUVdOVytmTDJCNXBz?=
 =?utf-8?B?dmRBQllnemtzNWZuc20vY1krcktjWjNoT3RaS2JnbC9DY3ZBZ2MwYkIwNjBt?=
 =?utf-8?B?TmJabEdFWGxOSURWNUxVZExSSmROUEVGTUxQTzdzY2dNN0JadUpmaE5pRkIw?=
 =?utf-8?Q?hajE=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7282.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9c5d797-f374-4448-66b7-08dc1d2a5f78
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2024 22:18:20.7099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NK4L6gdKYCzq5SkjyrrlaLLuELF072lO9tf4sAx8A1J4f52Vxj15j1t0N1PJPHtz8gBErQ6NTG96BMVZfsK4Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5353

PiA+IFdoYXQgaXMgdGhlIGxpbmsgcGFydG5lcj8gRnJvbSB0aGUgZGF0YXNoZWV0DQo+ID4NCj4g
PiBNTUQgQWRkcmVzcyAxaCwgUmVnaXN0ZXIgNUFoIOKAkyAxMDAwQkFTRS1UIExpbmstVXAgVGlt
ZSBDb250cm9sDQo+ID4NCj4gPiBXaGVuIHRoZSBsaW5rIHBhcnRuZXIgaXMgYW5vdGhlciBLU1o5
MDMxIGRldmljZSwgdGhlIDEwMDBCQVNFLVQNCj4gPiBsaW5rLXVwIHRpbWUgY2FuIGJlIGxvbmcu
IFRoZXNlIHRocmVlIGJpdHMgcHJvdmlkZSBhbiBvcHRpb25hbCBzZXR0aW5nDQo+ID4gdG8gcmVk
dWNlIHRoZSAxMDAwQkFTRS1UIGxpbmstdXAgdGltZS4NCj4gPiAxMDAgPSBEZWZhdWx0IHBvd2Vy
LXVwIHNldHRpbmcNCj4gPiAwMTEgPSBPcHRpb25hbCBzZXR0aW5nIHRvIHJlZHVjZSBsaW5rLXVw
IHRpbWUgd2hlbiB0aGUgbGluayBwYXJ0bmVyIGlzDQo+ID4gYSBLU1o5MDMxIGRldmljZS4NCj4g
Pg0KPiA+IE1pZ2h0IGJlIHdvcnRoIHNldHRpbmcgaXQgYW5kIHNlZSB3aGF0IGhhcHBlbnMuDQo+
ID4NCj4gPiBIYXZlIHlvdSB0cmllZCBwbGF5aW5nIHdpdGggdGhlIHByZWZlciBtYXN0ZXIvcHJl
ZmVyIHNsYXZlIG9wdGlvbnM/IElmDQo+ID4geW91IGhhdmUgaWRlbnRpY2FsIFBIWXMgb24gZWFj
aCBlbmQsIGl0IGNvdWxkIGJlIHRoZXkgYXJlIGdlbmVyYXRpbmcgdGhlIHNhbWUNCj4gJ3JhbmRv
bScNCj4gPiBudW1iZXIgdXNlZCB0byBkZXRlcm1pbmUgd2hvIHNob3VsZCBiZSBtYXN0ZXIgYW5k
IHdobyBzaG91bGQgYmUgc2xhdmUuDQo+ID4gSWYgdGhleSBib3RoIHBpY2sgdGhlIHNhbWUgbnVt
YmVyLCB0aGV5IGFyZSBzdXBwb3NlZCB0byBwaWNrIGENCj4gPiBkaWZmZXJlbnQgcmFuZG9tIG51
bWJlciBhbmQgdHJ5IGFnYWluLiBUaGVyZSBoYXZlIGJlZW4gc29tZSBQSFlzIHdoaWNoDQo+ID4g
YXJlIGJyb2tlbiBpbiB0aGlzIHJlc3BlY3QuIHByZWZlciBtYXN0ZXIvcHJlZmVyIHNsYXZlIHNo
b3VsZA0KPiA+IGluZmx1ZW5jZSB0aGUgcmFuZG9tIG51bWJlciwgYmlhc2luZyBpdCBoaWdoZXIv
bG93ZXIuDQo+ID4NCj4gPiBhdXRvLW5lZyBzaG91bGQgdHlwaWNhbGx5IHRha2UgYSBsaXR0bGUg
b3ZlciAxIHNlY29uZC4gNSBzZWNvbmRzIGlzDQo+ID4gd2F5IHRvbyBsb25nLCBzb21ldGhpbmcg
aXMgbm90IGNvcnJlY3QuIFlvdSBtaWdodCB3YW50IHRvIHNuaWZmIHRoZQ0KPiA+IGZhc3QgbGlu
ayBwdWxzZXMsIHRyeSB0byBkZWNvZGUgdGhlIHZhbHVlcyBhbmQgc2VlIHdoYXQgaXMgZ29pbmcg
b24uDQo+ID4NCj4gPiBJIHdvdWxkIG5vdCBiZSBzdXJwcmlzZWQgaWYgeW91IGZpbmQgb3V0IHRo
aXMgNSBzZWNvbmQgY29tcGxldGUgdGltZQ0KPiA+IGlzIHNvbWVob3cgcmVsYXRlZCB0byBpdCBu
b3QgY29tcGxldGluZyBhdCBhbGwuDQo+ID4NCj4gDQo+IFRoZSBsaW5rIHBhcnRuZXIgaXMgYSBz
d2l0Y2ggKEtTWjk4OTNSKSBzbyBJIGFtIG5vdCBzdXJlIHNldHRpbmcgdGhlIDVBaCByZWdpc3Rl
cg0KPiB0byAwMTEgd291bGQgaGVscC4NCg0KSSBzZXQgdGhlIDVBaCByZWdpc3RlciB0byAwMTEg
YW5kIHRoYXQgZGlkbuKAmXQgaGVscC4gSSBhbHNvIGFtIGNvbnN1bHRpbmcgdGhlIHZlbmRvciBh
bmQgdGhlIGhhcmR3YXJlIHRlYW0gcmVnYXJkaW5nIHdoeSBhdXRvbmVnb3RpYXRpb24gdGFrZXMg
c28gbG9uZyB3aXRoIHRoZSBLU1o5MDMxLiBXaWxsIHJlcG9ydCBiYWNrIHdoZW4gdGhleSBnZXQg
YmFjayB0byBtZS4gDQo=

