Return-Path: <netdev+bounces-72797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC70B859AB2
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 03:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AEC5B20A95
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 02:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6811C3E;
	Mon, 19 Feb 2024 02:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="W3+U0Fa8"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2087.outbound.protection.outlook.com [40.107.21.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95082EDD
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 02:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708309525; cv=fail; b=Td9GWb2D8Jr/pKky2EKxxnWf5FylkNz1ejElzjpSVJ4brZKfgbOLCPF/jfJJPydA/2QaA/eQ3tHd3bmPJ0qagNd2JUsWZW2fY7ah15/8oyETwf2rslDQkBxpRAQwkvA/4LlDuno+fyM6kd+abyrGVwj+q75j6rBqDZBREs/4ofQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708309525; c=relaxed/simple;
	bh=q0icyNfHZYrAS7LZ8To9ef18pc/YqVyQUWtbWKlaS7Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G8e9VIs6cPELzo9PwPlyeX/oaQkGth4I3VEmrAJT/bZndfSETPoa/7cJrwDA4Uz5NZa8WU24tPg9bXV9f5khtMIIFxATqAXMbBFLo0u1OdShEuX+6rF53oAoTiA5vaJki8SyRrHEVztItFXuJJBnH0fFBW7frLOEHvVbO7fShV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=W3+U0Fa8; arc=fail smtp.client-ip=40.107.21.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mSTNVU3V8P2/6NDIl0fTj9pvP1YmGcgjmKota0yNusJA4E6gJh7Fq7GDHoP6RYX+m/3NGMTay+AFKvJox2r2Lclreu2MijiUwhb4clDLpZ1G3D1cNKwp7sa955yzP5TPN1frFPc+Ddtg0lhUbTBfo5yMcUnw3pNCo/r5mflfybJ7ex+3mMo+mzWsrikj43fV7aKNYiVHLw6qE+QVeIzOxf/m5pNlw2J0tO+8APfpN28AmubJ6oC5ydm+PkaWoTjRxiH+bTv8UBWG+n4vU41cHKXj3EAX/LOa/X3cCIYYq4ciMJmU46ISvvZTyQH3SeJJtxOyspxOzPUjmXA1PcYZMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0icyNfHZYrAS7LZ8To9ef18pc/YqVyQUWtbWKlaS7Y=;
 b=DkhbOlppcE72ChNrQFkOqeRtCVcaoYk16bJ/B8RSminhY433OmShswO1WXa69TxBVjp1q0NyP+gr76Sb/8LkEjX7Mv5kcU+/5DyIoVFvmBLzD9JV2xDdw/K1CNKwOmVdvl8h0stZFaYenqp6/QwZMz+by7VHfTd4NpA/dCdSNgpJEhXmW/a/sBMCwzGhFWdcngfR5XU34U78kjKwbOG/q7Yb6z8QmK3ew7ecOCsBIhLq/v6mqg7B9udMeK8GiXd8N/acnHhCS6a7JZy60eez7oVPQUauu5AHJZNdMOMm0y4vzl9HsQ42ylYwtSAC6AoHgdGxHlWMBKHEMDvFiX/OWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0icyNfHZYrAS7LZ8To9ef18pc/YqVyQUWtbWKlaS7Y=;
 b=W3+U0Fa8KeFdoOp8+cDZCnSRDDo3wq62DuX29iBrfREDXBph28JyiKyAzTRocAtOrClfYg14T7sMIbDPIRZfe9T0hh8BpOQg1KcI8C8asNthQDLUJxNoHCPKVQeQ7C4vk1g0lNG6Gfr8nyyLcNy2eRKRpsrjIsvNCA3z9Qya2zE=
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by PR3PR04MB7371.eurprd04.prod.outlook.com (2603:10a6:102:87::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Mon, 19 Feb
 2024 02:25:19 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::fd19:496c:4927:ac32]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::fd19:496c:4927:ac32%7]) with mapi id 15.20.7292.033; Mon, 19 Feb 2024
 02:25:19 +0000
From: Wei Fang <wei.fang@nxp.com>
To: John Ernberg <john.ernberg@actia.se>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Jonas Blixt <jonas.blixt@actia.se>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, Andrew Lunn <andrew@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>
Subject: RE: Broken networking on iMX8QXP after suspend after upgrading from
 5.10 to 6.1
Thread-Topic: Broken networking on iMX8QXP after suspend after upgrading from
 5.10 to 6.1
Thread-Index: AQHaWpEPpeShfAur10u61GX5crs7mbEQD9jA
Date: Mon, 19 Feb 2024 02:25:19 +0000
Message-ID:
 <AM5PR04MB3139C082E02B9C1B2049083F88512@AM5PR04MB3139.eurprd04.prod.outlook.com>
References: <1f45bdbe-eab1-4e59-8f24-add177590d27@actia.se>
In-Reply-To: <1f45bdbe-eab1-4e59-8f24-add177590d27@actia.se>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM5PR04MB3139:EE_|PR3PR04MB7371:EE_
x-ms-office365-filtering-correlation-id: df711442-be13-4f1b-42ae-08dc30f204a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 cPd0Gw1GYe+aftgG8xI/byckZ0FVMLNHkmunKjR14jWqJvMk4Ok43nial72tbJpdIyknHvh+bTGqkodiip7ErOoVA3qcs8BkOj5upCLFvtf8DXW9XyqxnzR+jgD/OqT0CJMQAQldTZdJomEBqCYcVt7Y7amKTokP8IFmq/712Z3wcGjPFPQG2HigHViI+N/mknBkVzIFTsgyeOlIMMMnLSLYUSSK+TG+HWQz+1IgISqmyxzbE3mZ3sTCziP6ukKwvfzHgg/MUXJ0VaQcuUAwJRfsmD1sWbqUWjUBU4vrV5UUsVysC0x1C+bIrvHsRV6r2SDlE2bN5AYX2vwPpEzIZGysFp529v1iIYdklHzC2XCizGBuFCHcGR4mBOBsXVogIiB0rS/VISyokCIrHmuSxhKoVPZdBwTbL5F7eb4FOG86aMn8XwD6kYXM4gzDFo6wnUzhJRyBg5zvdpMcDkr9V5cwfcVxb3/axtLl1Ss1mHkdshx9J3Ok0QSoka5DOdP82rDNF4q2+FxmJlzx3amRPAtH8UE8XWIeFrfx81S7FQ/u3ZzjoZ1DvGNTPVH6sjL21z8QL5MI9fFwgxflRaoJA3a/kl1qX7FqKB7H5KScHtDwBU0iMUJwXDg0Xl88Ab5/
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(376002)(39860400002)(396003)(230922051799003)(230273577357003)(451199024)(1800799012)(64100799003)(186009)(44832011)(15650500001)(2906002)(5660300002)(4326008)(38070700009)(41300700001)(26005)(478600001)(38100700002)(122000001)(83380400001)(33656002)(86362001)(8936002)(8676002)(76116006)(52536014)(66556008)(66476007)(66446008)(64756008)(66946007)(7696005)(9686003)(53546011)(6506007)(71200400001)(316002)(110136005)(54906003)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z1Q2VWNOUndTb1lDQWFZdy8ydkxZNm90dFNrYnpXODNuTXBsT1lyb1lYNnZZ?=
 =?utf-8?B?a1ZOeG0ydk5BUXBmdjdpYUNEVnA5L3VFZG1MN0l5RVlnSnRrNWxRSnd1K0Vm?=
 =?utf-8?B?T0JXVkNqcFAxRVdCV1lxTTNxRkY5R0tSNmxlV3VuQnRqNmtxQ1dvQ2k0a1NB?=
 =?utf-8?B?U296WkFIcFJabC82RkhtbzRFY2dNbnVVa3lVbnEvTzllTlNydGFhYTdsbEU1?=
 =?utf-8?B?SG9EYnpJdmMrU3E2cEVwcnA0NHVZdW90NkovVFhTRVBHQThaaVBaMWNQaVJn?=
 =?utf-8?B?RGZPOEw3blNORXllVTllMWFXQWV3UU00WFFocnFkRlpBVjZMMUtwbzNqeUZl?=
 =?utf-8?B?M3cxUGo4RU9LUkJzeGIyTVR0QjE1dWpBNFV4cTZmQUNzaThTNWtuQitBb1FC?=
 =?utf-8?B?STdhSDNpNnJGYjhDWmdudnhSSVVPc3NpQmh2cE94YTFMRThzQ010Mi9XbVRv?=
 =?utf-8?B?bFpqay9JeEF1MTg3Wm1CMDM5cS9WS0NOY2xpYU8zRjVkcGJaTG4xVDNmNDc4?=
 =?utf-8?B?NkhFMCttU3BHcmxqUDFFWnB0WHRUTjNmVFFSNmxVWHRxUTFSM0NzQUxNSDJX?=
 =?utf-8?B?NVh0M2lkZUFaWHp6eGtOREd6TzNiVGFxY1dvckwyc2J1VU8wWDhPR3E0dkhF?=
 =?utf-8?B?cmhrQkRFdVd1SzNCMHc3Y0xaZlZhOGNGNDV6RkZYa1JqOHBrWnV5V0dGQk9i?=
 =?utf-8?B?TFRWYkV1QktJR1JlN3lSa1V4WnNZWGtickhhS2N2c3RuVnZNbXRIRnZVaTJB?=
 =?utf-8?B?UEJtZTlZQk5xc2VxYytrYldDdEFNM0lPM21WS2hmVHo1Z0l1ZmlrMkN4enVV?=
 =?utf-8?B?QUN2UWhzOC9LL1hjYks0cDNCVTN5eENYZTFNTmxRazM2QnIyenFvMDd1b0pL?=
 =?utf-8?B?WFdnQUcxZHgxdjhOWVNJeWFFMjcxOFFZUVZTK3FxbStrdEEvTmNhZHpDeDBC?=
 =?utf-8?B?TGs1U2hTSjhhMVNwdFJaNStuNWpmK3lSaElna0pNekhzSU8yVm5TNmZLenhG?=
 =?utf-8?B?ei91WVJ0b2tBdmVaY1NVZFJnUHp3WThpNHIvcEdRZlEycjBMU2xSOWhtR3cz?=
 =?utf-8?B?VDloUEhUYmxWWkZGWTNabWVlWlkvRndZdjlIZXI4VkE2bGF5WXFGZWNGYWUz?=
 =?utf-8?B?eEJNeUc2eEVwWWlVUGZ4OFFaWGY4eUM0dUl6cU41c2lWRlQwVVdMbFVyNEVy?=
 =?utf-8?B?elB2b3luazJocTdSbHFKYUdwWWFjTVVqd1ZmakcyZlptTGd4ZGd6UUROSTFE?=
 =?utf-8?B?RFVJYWx0YTdNSUtTTGJ3cHFWWDR6WHROczVXcFlkRXc1MWF1alN4OXZpNXdX?=
 =?utf-8?B?Q0IxUEpxUjIxc2JOTU9adEFoMzdneHl3WUpnVi9sTVJMNGMwMFZEbW8va056?=
 =?utf-8?B?d3dWUmlsajRVbGVUMTlKMElOSGhSTUtGNXIzSTBzRDh1eWh0cGNmaUtsUnRj?=
 =?utf-8?B?MFNPZExrUFY4WmlZU0NxNTZMSUhnaUx1TGp3NkJRbTFtSGdyM3czOUNxTEpj?=
 =?utf-8?B?eENITkhTbTF3ckEyc2VaaHRpUGhHK2JvSGh5M1hLaGJnbk5LWVkxVXZUQjVn?=
 =?utf-8?B?Rmg4VU1LNnlhRHlQMUtLWGJSVllQcCtDTzNJbTY3Y2oyQ21RZ1N1K0V4ckNY?=
 =?utf-8?B?blc2WUplQzRQdThjblVRSkdQYzluTWtYT3B5WkVEU1dRTmszNDhHTmZZMW5l?=
 =?utf-8?B?amd3QVJuOVk3b2hnZlVXek9qRS9neXVocWtFZk9PTlBWamdhRC9GdUlmY2pI?=
 =?utf-8?B?R2RVTUIySXMyUEVQVHRSWDBEemNBUE1RU0lGY3ZDcFBEYjRUMW10QlZZbzBx?=
 =?utf-8?B?K1dYbC9nWW9rYmV0aHJudExGOGF5c0p2dXBMTm5HeDZDcEdFUDlBVXlCRFhJ?=
 =?utf-8?B?aFRHbjdIa1E2VFZCTmFPSFJieGtuNmN4b1dFWHR5R216L2hGNjZJYUdEU1BE?=
 =?utf-8?B?ZThGMkZaa0RuVG1uSHlXSndsTGNqTmFKMWVCRC9DeGVJVExyUU02bWU3Yk9B?=
 =?utf-8?B?bzZZOHQyRDRaQkh6UmhjWXRSVVgzZ0dmYXhNM0Z2SiszUTFaOEx4UUJUNDVS?=
 =?utf-8?B?c29sbG40YWp4T3JPL0R0UDVXK0dIUy9aVjNwQ0NUNk1kUjVMUDNTQjVEUlhR?=
 =?utf-8?Q?HJTQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3139.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df711442-be13-4f1b-42ae-08dc30f204a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2024 02:25:19.7295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XEvDxvsssKc6bwT9QTMQ9CsIMuikGVrw2jenYDd47qOKrsR/zr55aPkSrc1vBjtpm2TIgLTsMueE0eqyL9oQbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7371

SGkgSm9obiwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb2huIEVy
bmJlcmcgPGpvaG4uZXJuYmVyZ0BhY3RpYS5zZT4NCj4gU2VudDogMjAyNOW5tDLmnIg45pelIDIx
OjE3DQo+IFRvOiBuZXRkZXZAdmdlci5rZXJuZWwub3JnDQo+IENjOiBKb25hcyBCbGl4dCA8am9u
YXMuYmxpeHRAYWN0aWEuc2U+OyBXZWkgRmFuZyA8d2VpLmZhbmdAbnhwLmNvbT47DQo+IFNoZW53
ZWkgV2FuZyA8c2hlbndlaS53YW5nQG54cC5jb20+OyBDbGFyayBXYW5nDQo+IDx4aWFvbmluZy53
YW5nQG54cC5jb20+OyBBbmRyZXcgTHVubiA8YW5kcmV3QGx1bm4uY2g+OyBIZWluZXINCj4gS2Fs
bHdlaXQgPGhrYWxsd2VpdDFAZ21haWwuY29tPjsgUnVzc2VsbCBLaW5nIDxsaW51eEBhcm1saW51
eC5vcmcudWs+DQo+IFN1YmplY3Q6IEJyb2tlbiBuZXR3b3JraW5nIG9uIGlNWDhRWFAgYWZ0ZXIg
c3VzcGVuZCBhZnRlciB1cGdyYWRpbmcgZnJvbQ0KPiA1LjEwIHRvIDYuMQ0KPiANCj4gSGksDQo+
IA0KPiBXZSBqdXN0IHVwZ3JhZGVkIHZlbmRvciBrZXJuZWwgZnJvbSA1LjEwIHRvIDYuMSBhbmQg
ZW5kZWQgdXAgd2l0aCBicm9rZW4NCj4gbmV0d29ya2luZyBvbiBvdXIgYm9hcmQgIHVubGVzcyB3
ZSBicmluZyB0aGUgUEhZIHVwIGJlZm9yZSB0aGUgZmlyc3QNCj4gc3VzcGVuZCBvZiB0aGUgc3lz
dGVtLg0KPiANCj4gVGhlIGxpbmsgaXMgYnJvdWdodCB1cCB2aWEgZXh0ZXJuYWwgc2lnbmFsLCBz
byBpdCBpcyBub3QgZ3VhcmFudGVlZCB0byBoYXZlIGJlZW4NCj4gVVAgYmVmb3JlIHRoZSBmaXJz
dCBzeXN0ZW0gc3VzcGVuZC4NCj4gDQo+IFdlJ2QgbGlrZSB0byBydW4gdGhlIG1haW5saW5lIGtl
cm5lbCBidXQgd2UncmUgbm90IGluIGEgcG9zaXRpb24gdG8gZG8gc28geWV0Lg0KPiBCdXQgd2Ug
aG9wZSB3ZSBjYW4gZ2V0IHNvbWUgYWR2aWNlIG9uIHRoaXMgcHJvYmxlbSBhbnl3YXkuDQo+IA0K
PiBXZSBoYXZlIGEgcGVybWFuZW50bHkgcG93ZXJlZCBNaWNyb2NoaXAgTEFOODcwMFIgKG1pY3Jv
Y2hpcF90MS5jKQ0KPiBjb25uZWN0ZWQgdG8gYW4gaU1YOFFYUCAoZmVjKSwgdG8gYmUgYWJsZSB0
byB3YWtlIHRoZSBzeXN0ZW0gdmlhIG5ldHdvcmsgaWYNCj4gdGhlIGxpbmsgaXMgdXAuDQo+IA0K
PiBUaGlzIHNldHVwIHdhcyB3b3JraW5nIGZpbmUgaW4gNS4xMC4NCj4gDQo+IFRoZSBvZmZlbmRp
bmcgY29tbWl0IGFzIGZhciBhcyB3ZSBjb3VsZCBiaXNlY3QgaXQgaXM6DQo+IDU1N2Q1ZGM4M2Y2
OCAoIm5ldDogZmVjOiB1c2UgbWFjLW1hbmFnZWQgUEhZIFBNIikgQW5kIHNvbWV3aGF0Og0KPiBm
YmE4NjNiODE2MDQgKCJuZXQ6IHBoeTogbWFrZSBQSFkgUE0gb3BzIGEgbm8tb3AgaWYgTUFDIGRy
aXZlciBtYW5hZ2VzDQo+IFBIWSBQTSIpDQo+IA0KPiBJZiB0aGUgaW50ZXJmYWNlIGhhcyBub3Qg
YmVlbiBicm91Z2h0IFVQIGJlZm9yZSB0aGUgc3lzdGVtIHN1c3BlbmRzIHdlIGNhbg0KPiBzZWUg
dGhpcyBpbiBkbWVzZzoNCj4gDQo+ICAgICAgZmVjIDViMDQwMDAwLmV0aGVybmV0IGV0aDA6IE1E
SU8gcmVhZCB0aW1lb3V0DQo+ICAgICAgTWljcm9jaGlwIExBTjg3eHggVDEgNWIwNDAwMDAuZXRo
ZXJuZXQtMTowNDogUE06DQo+IGRwbV9ydW5fY2FsbGJhY2soKTogbWRpb19idXNfcGh5X3Jlc3Vt
ZSsweDAvMHhjOCByZXR1cm5zIC0xMTANCj4gICAgICBNaWNyb2NoaXAgTEFOODd4eCBUMSA1YjA0
MDAwMC5ldGhlcm5ldC0xOjA0OiBQTTogZmFpbGVkIHRvIHJlc3VtZToNCj4gZXJyb3IgLTExMA0K
PiANCj4gSW4gdGhpcyBzdGF0ZSBpdCBpcyBpbXBvc3NpYmxlIHRvIGJyaW5nIHRoZSBsaW5rIHVw
IGJlZm9yZSByZW1vdmluZyBhbGwgcG93ZXINCj4gZnJvbSB0aGUgYm9hcmQgYW5kIHRoZW4gcGx1
Z2dpbmcgaXQgaW4gYWdhaW4sIHNpbmNlIHRoZSBQSFkgaXMgcGVybWFuZW50bHkNCj4gcG93ZXJl
ZC4NCj4gDQo+IE15IHVuZGVyc3RhbmRpbmcgaGVyZSBpcyB0aGF0IHNpbmNlIHRoZSBsaW5rIGhh
cyBuZXZlciBiZWVuIFVQLA0KPiBmZWNfZW5ldF9vcGVuKCkgaGFzIG5ldmVyIGV4ZWN1dGVkLCB0
aGVyZWZvciBtYWNfbWFuYWdlZF9wbSBpcyBub3QgdHJ1ZS4NCj4gVGhpcyBpbiB0dXJuIG1ha2Vz
IHVzIHRha2UgdGhlIG5vcm1hbCBQTSBmbG93Lg0KPiBMaWtld2lzZSBpbiBmZWNfcmVzdW1lKCkg
aWYgdGhlIGludGVyZmFjZSBpcyBub3QgcnVubmluZywgdGhlIE1BQyBpc24ndCBlbmFibGVkDQo+
IGJlY2F1c2Ugb24gdGhlIGlNWDhRWFAgdGhlIEZFQyBpcyBwb3dlcmVkIGRvd24gaW4gdGhlIHN1
c3BlbmQgcGF0aCBidXQNCj4gbmV2ZXIgcmUtaW5pdGlhbGl6ZWQgYW5kIGVuYWJsZWQgaW4gdGhl
IHJlc3VtZSBwYXRoLCBzbyB0aGUgTUFDIGlzIHBvd2VyZWQNCj4gYmFjayB1cCwgYnV0IHN0aWxs
IGRpc2FibGVkLg0KPiANCj4gQWRkaW5nIHRoZSBmb2xsb3dpbmcgc2VlbXMgdG8gZml4IHRoZSBp
c3N1ZSwgYnV0IEkgcGVyc29uYWxseSBkb24ndCBsaWtlIHRoaXMsDQo+IGJlY2F1c2Ugd2UganVz
dCBhbGxvdyB0aGUgbm9uLW1hY19tYW5hZ2VkX3BtIGZsb3cgdG8gcnVuIGxvbmdlciBieQ0KPiBl
bmFibGluZyB0aGUgTUFDIGFnYWluIHJhdGhlciB0aGFuIGxldHRpbmcgdGhlIE1BQyBkbyB0aGUg
UE0gYXMgY29uZmlndXJlZA0KPiBpbiBmZWNfZW5ldF9vcGVuKCkuDQo+IFdoYXQgd291bGQgYmUg
dGhlIGNvcnJlY3QgdGhpbmcgdG8gZG8gaGVyZT8NCg0KU29ycnkgZm9yIHRoZSBkZWxheWVkIHJl
c3BvbnNlLg0KSGF2ZSB5b3UgdHJpZWQgc2V0dGluZyBtYWNfbWFuYWdlbWVudF9wbSB0byB0cnVl
IGFmdGVyIG1kaW9idXMgcmVnaXN0cmF0aW9uPw0KSnVzdCBsaWtlIGJlbG93Og0KDQpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZlY19tYWluLmMgYi9kcml2ZXJz
L25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZmVjX21haW4uYw0KaW5kZXggNDc2OTNiYTU4ZWE0Li40
NDlmNTZlZWEyZTcgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUv
ZmVjX21haW4uYw0KKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZlY19tYWlu
LmMNCkBAIC0yNDAxLDggKzI0MDEsNiBAQCBzdGF0aWMgaW50IGZlY19lbmV0X21paV9wcm9iZShz
dHJ1Y3QgbmV0X2RldmljZSAqbmRldikNCiAgICAgICAgZmVwLT5saW5rID0gMDsNCiAgICAgICAg
ZmVwLT5mdWxsX2R1cGxleCA9IDA7DQoNCi0gICAgICAgcGh5X2Rldi0+bWFjX21hbmFnZWRfcG0g
PSB0cnVlOw0KLQ0KICAgICAgICBwaHlfYXR0YWNoZWRfaW5mbyhwaHlfZGV2KTsNCg0KICAgICAg
ICByZXR1cm4gMDsNCkBAIC0yNDE1LDEwICsyNDEzLDEyIEBAIHN0YXRpYyBpbnQgZmVjX2VuZXRf
bWlpX2luaXQoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAgICAgICAgc3RydWN0IG5l
dF9kZXZpY2UgKm5kZXYgPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShwZGV2KTsNCiAgICAgICAgc3Ry
dWN0IGZlY19lbmV0X3ByaXZhdGUgKmZlcCA9IG5ldGRldl9wcml2KG5kZXYpOw0KICAgICAgICBi
b29sIHN1cHByZXNzX3ByZWFtYmxlID0gZmFsc2U7DQorICAgICAgIHN0cnVjdCBwaHlfZGV2aWNl
ICpwaHlkZXY7DQogICAgICAgIHN0cnVjdCBkZXZpY2Vfbm9kZSAqbm9kZTsNCiAgICAgICAgaW50
IGVyciA9IC1FTlhJTzsNCiAgICAgICAgdTMyIG1paV9zcGVlZCwgaG9sZHRpbWU7DQogICAgICAg
IHUzMiBidXNfZnJlcTsNCisgICAgICAgaW50IGFkZHI7DQoNCiAgICAgICAgLyoNCiAgICAgICAg
ICogVGhlIGkuTVgyOCBkdWFsIGZlYyBpbnRlcmZhY2VzIGFyZSBub3QgZXF1YWwuDQpAQCAtMjUz
Myw2ICsyNTMzLDEzIEBAIHN0YXRpYyBpbnQgZmVjX2VuZXRfbWlpX2luaXQoc3RydWN0IHBsYXRm
b3JtX2RldmljZSAqcGRldikNCiAgICAgICAgICAgICAgICBnb3RvIGVycl9vdXRfZnJlZV9tZGlv
YnVzOw0KICAgICAgICBvZl9ub2RlX3B1dChub2RlKTsNCg0KKyAgICAgICAvKiBmaW5kIGFsbCB0
aGUgUEhZIGRldmljZXMgb24gdGhlIGJ1cyBhbmQgc2V0IG1hY19tYW5hZ2VkX3BtIHRvIHRydWUq
Lw0KKyAgICAgICBmb3IgKGFkZHIgPSAwOyBhZGRyIDwgUEhZX01BWF9BRERSOyBhZGRyKyspIHsN
CisgICAgICAgICAgICAgICBwaHlkZXYgPSBtZGlvYnVzX2dldF9waHkoZmVwLT5taWlfYnVzLCBh
ZGRyKTsNCisgICAgICAgICAgICAgICBpZiAocGh5ZGV2KQ0KKyAgICAgICAgICAgICAgICAgICAg
ICAgcGh5ZGV2LT5tYWNfbWFuYWdlZF9wbSA9IHRydWU7DQorICAgICAgIH0NCisNCiAgICAgICAg
bWlpX2NudCsrOw0KDQo+IA0KPiAtLS0tLS0tLS0gPjggLS0tLS0tDQo+ICAgZHJpdmVycy9uZXQv
ZXRoZXJuZXQvZnJlZXNjYWxlL2ZlY19tYWluLmMgfCAyICsrDQo+ICAgMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0
L2ZyZWVzY2FsZS9mZWNfbWFpbi5jDQo+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxl
L2ZlY19tYWluLmMNCj4gaW5kZXggYTliNjFmY2Y5YjVjLi42YmU1ZjM4ODM1ODIgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWNfbWFpbi5jDQo+ICsrKyBi
L2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWNfbWFpbi5jDQo+IEBAIC00NjkwLDYg
KzQ2OTAsOCBAQCBzdGF0aWMgaW50IF9fbWF5YmVfdW51c2VkIGZlY19yZXN1bWUoc3RydWN0DQo+
IGRldmljZQ0KPiAqZGV2KQ0KPiAgICAgICAgICAgICAgICAgIHJldCA9IGZlY19yZXN0b3JlX21p
aV9idXMobmRldik7DQo+ICAgICAgICAgICAgICAgICAgaWYgKHJldCA8IDApDQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiArICAgICAgIH0gZWxzZSB7DQo+ICsgICAg
ICAgICAgICAgICBmZWNfcmVzdGFydChuZGV2KTsNCj4gICAgICAgICAgfQ0KPiAgICAgICAgICBy
dG5sX3VubG9jaygpOw0KPiANCj4gLS0NCj4gDQo+IFRoYW5rcyEgLy8gSm9obiBFcm5iZXJnDQo=

