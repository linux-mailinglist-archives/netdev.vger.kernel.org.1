Return-Path: <netdev+bounces-74423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3604C8613E7
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 15:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E7802857D1
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 14:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BA57F7D0;
	Fri, 23 Feb 2024 14:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qnap.com header.i=@qnap.com header.b="VIi5Rl9P"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2124.outbound.protection.outlook.com [40.107.255.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A788003E
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 14:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708698207; cv=fail; b=ogA0t3OY/22ghgEciIImUIJcV4BUcRHuNR9YTJzQN7NUV9LPNp39EJr1pNRR5NGb6ivATRf+iHClpteDxIWUZ4fMsude/sGsYPEHHOPM+/X88Aa12fc8xSHhhNd946ph0RHpodhMvbUtkzR2RLvO1TCEMlGiy8RuHGiEB6lIe1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708698207; c=relaxed/simple;
	bh=opg+mP0sM6xyeCeV+fK5iPZhkawRfRiphxkB1fwbHAc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FUfNjEKpb/0thnry9cyz1cT0lko8V7iiT3vVigEnRhVTqgfA8cQ0xRjEplt1+wbGBhjYUTmmP7AhgKsx0Fm09eqEnpUy4AlK4O77+vbsBSTU7SRuLb7ERx/GJSrXmHcgae1CK7Qo499hiE0MU91QTlsiqjLx98nBC2daLlgjav0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qnap.com; spf=pass smtp.mailfrom=qnap.com; dkim=pass (2048-bit key) header.d=qnap.com header.i=@qnap.com header.b=VIi5Rl9P; arc=fail smtp.client-ip=40.107.255.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qnap.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qnap.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qvu4FgHFavmDWN+4XixiksSNvBwmuYeiBmXmVjgNDpi7Ns2lhDGzRLFiUpzXnfT8Bvm1Xt6utf9H1a2yj9EQkHYHUC+By91jXIk0vnYbZgePoOkeu2UGoXgIgnv46hp8QI+by1UQngSpNgRjuijyqkzevZwjb8vDGqGYtriPhl3HQlZfycWJYeH8tjtRQuixv1pDjLFnC67FGrf6R0ZzCWhDOoHDfXpEbFl7waZWNpzGOZVvkWZm2sysvppR7EXyRRGWL8CRgfJYCySAOExU4kr9riiaN5KjKDkcbeuOMu2MmjduPpEoECLwuNTpIMjKuIH1soslyC8id2MK2m3tHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=opg+mP0sM6xyeCeV+fK5iPZhkawRfRiphxkB1fwbHAc=;
 b=mD7hYvBLaTRaljZoZdGXOqQMaPCPwgba0H7C22TWX/Otz0NMYg6K2HzLtLfiYssf99TSw8m08qovdBaXczA63RsXQQta9KVLepuUFd8h5UyxxBmTyImbqBISRZy2UjhC+QifCzycy3hm7HkoTdUWWB+WI+HizeqDJ33UMzFCsi3wILAM/LOe/IpeBD8lxIMDjxnELQcs0fnMg1mtoKlkLkdou25f96ZETkE4NLbUIbD7suqA2Ta8Y/lYkeM+MBF2HHFZHfo71wD69sBxP/bRUW9i17r3R486KxncC2GDnhRI71WEGOtQtXahmCQ8o8P8QGNOxzeoUq46w24LBvkIGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qnap.com; dmarc=pass action=none header.from=qnap.com;
 dkim=pass header.d=qnap.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opg+mP0sM6xyeCeV+fK5iPZhkawRfRiphxkB1fwbHAc=;
 b=VIi5Rl9PcHDrA6TCONVUoRdo/QP99aH6ISRFldjLb/A3xQ9MMO2FQ+WwsQ7FKXejejjHIlnfLLdZUDJuZ/GgLoXT86RCrT8coF0r39Waf+roAdqkaEconDxy4ENAd7FfechTSCkTyeZXBGVHLFZg+T1wWnM7VrCWf7oK4iO8LOKqCEZgvQ5ouO8V5HO1cZSetZ7nWj3sFVyAsEr6Yg9IgbWvtk0pcL9SXPfXBFesHJA0Rl8y/S9VKalJ9aanFJD5i1j9el/tHtDl/lzOzxrtwcW5/0GgmE3g0FpLz0orHq7rN8woaiuW2w3vYTKIBpcg15j0u2Z0sOU5f2okCuElNA==
Received: from SI2PR04MB5097.apcprd04.prod.outlook.com (2603:1096:4:14d::9) by
 OSQPR04MB7780.apcprd04.prod.outlook.com (2603:1096:604:27a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 14:23:20 +0000
Received: from SI2PR04MB5097.apcprd04.prod.outlook.com
 ([fe80::2f40:e11f:9d69:5bf5]) by SI2PR04MB5097.apcprd04.prod.outlook.com
 ([fe80::2f40:e11f:9d69:5bf5%7]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 14:23:19 +0000
From: =?iso-2022-jp?B?Sm9uZXMgU3l1ZSAbJEJpLVhnPSEbKEI=?= <jonessyue@qnap.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: Jakub Kicinski <kuba@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] bonding: 802.3ad replace MAC_ADDRESS_EQUAL with
 __agg_has_partner
Thread-Topic: [PATCH net-next] bonding: 802.3ad replace MAC_ADDRESS_EQUAL with
 __agg_has_partner
Thread-Index: AQHaZj4vjIKr6Tmx20OgcP2p7p8aeLEX+lK1
Date: Fri, 23 Feb 2024 14:23:19 +0000
Message-ID:
 <SI2PR04MB509715D67E0C71663DB92303DC552@SI2PR04MB5097.apcprd04.prod.outlook.com>
References:
 <SI2PR04MB50977DA9BB51D9C8FAF6928ADC562@SI2PR04MB5097.apcprd04.prod.outlook.com>
 <20240222192752.32bb4bf3@kernel.org>
 <SI2PR04MB509756F6E1DB746FA0283407DC552@SI2PR04MB5097.apcprd04.prod.outlook.com>
 <ZdhrIJMB983Hz6nH@nanopsycho>
In-Reply-To: <ZdhrIJMB983Hz6nH@nanopsycho>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=qnap.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR04MB5097:EE_|OSQPR04MB7780:EE_
x-ms-office365-filtering-correlation-id: e5da0647-b393-48a7-fb22-08dc347afc04
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Q2DeMylbUON443PoMqu0Lrka5bXtZfrMLYy4VbX0RIJ4CAHGU7gxICSP6vrHALb+sT6znZmiYaj1TiSwJCKVXgjH6TmjSiUYeh+nszgSEr4sGe1W+mdB+QoKZ/G9xTHMxl6YS2yQKwuITOQX1MyUsCBbERhcWUMgS6IPuYPcqc03DH7t14b/sITRe1LL2zV+RhX7OnHRlt68YXR0MUBreyVHuGh/lgl3mjmAuF+CjdvLISHi6y9uM0K4lxb2N4/RTET7yaYd0nQkkUp6IpLC4swwhjyS+SVeL9e8Gmptcex8yNGklgyZejVsKf4tZAGmkjAKjE/jN+OYTaN07LiqAby2GpiAIVcgWpRDjeSW/tVaf25e6GyonEs6OBPIG3GUeaAmWOXvsLkpADKvDKTuEKMvGMtb0vF23hRpL9s130o4qGyKuaiOUMWF4NhLyi6g0asyik79SgDcU4rEEwgcNjGDfR3Wp5gVbERPdrL8WxkoH1f3+Zh9Kh5xBWXvGxhfuZ/ggU7p1nDQ5QJYn9IvOL0WMnhIrBKYkoETmkktNwocC6ZVAsQipDmzb2EJCTIXnaNtNANeMv+FkYMKwlaJYI/VwApxVccirq16aoI3kGA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR04MB5097.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?Q25wcUwzL2JOTVFBc1RCOGNQZ1NsQ2s2cE4vUmlhQzRuWHVMVTh5ZExJ?=
 =?iso-2022-jp?B?K0pUN05VWHpWbFBTSjROQkRJQ0NGOXNXU2VXWnM3cUJyY2tISUNWZ1pl?=
 =?iso-2022-jp?B?NGlCMWFIK0o5c2F0Vms3VW8xR2xOTnhXVFpiWXNXVkcyTFZ3cXgvclhB?=
 =?iso-2022-jp?B?SnJtQWdoTVJDd0RPQklidno4Y21HMGFZWTJPaFp2NFRZMHpBU1NaeVN5?=
 =?iso-2022-jp?B?UTdOeFNuN0pSTWRYcjF3Mm9zNWNUT0JRSW5ZZ2E3SHZEQXZWWm1KSDM2?=
 =?iso-2022-jp?B?eldGd1FmaFNnVE5Ja0NwZDZzTnpDOTJFaFllOUE0M1lwU2dJelplRmFt?=
 =?iso-2022-jp?B?bDByaml0ZDhmaWhiTkJlaXhmd3JJU1VGdnNvTjVYNlYrVW14QjhHREM3?=
 =?iso-2022-jp?B?RUFwcCsrb2h2UWladjZ2T2FUYWJkY0pFUDROdE9IbXVPOHlRSnRJSmpV?=
 =?iso-2022-jp?B?RTBTN3pOZnNNVlNHU1ZCTmxJWndYaEtyMXRkb1crR0tPYjNDYVgxTTVY?=
 =?iso-2022-jp?B?eHdYdDVMREt5WU5iRVJRQllOQ3hNR1NFU1V0dzZkWEtXdU4rMXNzdWE1?=
 =?iso-2022-jp?B?UkdKVzg4VlRHN3Vrb1p3NlhEc0ZYbWlvNnJxVWhQdllQQkZrUWtvMWFC?=
 =?iso-2022-jp?B?dTk0aVhKeXE1d0h0VXJPM2daaklERFZsY2hHbmdxOWRIZTJmYnZWNlhP?=
 =?iso-2022-jp?B?dVZNWWlLdHlhMFhTOGVHQlJ3Z2c0bVJ4SDlwb0J5QUlXUTNQVEQxWTQ0?=
 =?iso-2022-jp?B?OVpGVndMWG51N0pUVnVwQkJodGVXRkprczNubVprYnpwQlJnRnZZRUor?=
 =?iso-2022-jp?B?ZUc1dlo1S0ZlWmxZYktqU0pRbnROS0tTMGFMQ0N1ZVYzWm1XTEV3RTNT?=
 =?iso-2022-jp?B?STk0dGtLK3ZnK2d5L29wOXYyeHNSL0xOYlZ2cUpLNGVkTCthSzRyZkM1?=
 =?iso-2022-jp?B?QmxtUUNkOUR0aUhxN2FRcERXakpCeTRhdWFwVXVKRTROeUlSTUZuRUFP?=
 =?iso-2022-jp?B?amZsaExQaFRJcWNsOGF4R0dJQzhId1ZrNmVaQmhneXFnZTNGWjBUSHBV?=
 =?iso-2022-jp?B?b04ySTVJZENnZzEwUnNKMTc0ci9qVWt0Mjd0ZUtCL3BiWVRDL0VjRzdX?=
 =?iso-2022-jp?B?dVM2NHVtV2c2Zlk0ckwzcVpOM3gyU1BIcWpXemlQRFdseXBYcEVpejYx?=
 =?iso-2022-jp?B?azdWRFA4NXBpRHNiYnd6bElvZ0g4SEtPT3FxL3FJQndvZUZPeStvSjFV?=
 =?iso-2022-jp?B?UHdhaE1zblQvMGhWbUg3dDUrbUpITnY5WFAyMHM1RkZudkllUFQ1dTRG?=
 =?iso-2022-jp?B?QU5QU2dDRjhJSCtjaVZ0SWhJbCtWTFRFZGx2bm9jT1NadlpIa1pycWdw?=
 =?iso-2022-jp?B?ZkFRb2pYRmVWdGRBbEVXazMzYW83aHVvRHNkUnMxMUg1QU1KNkx6REJr?=
 =?iso-2022-jp?B?MWFZc0VKOGl1Rnp6dGQ5VWh1RWoySE1oNC9Gc2RDVUh6dVNZNFZJRklk?=
 =?iso-2022-jp?B?TkpvTWNyQWhXS3NRbFFKMEM2Q0dDbWVFODFzVkZhVytKVTVjWGNpcmUz?=
 =?iso-2022-jp?B?WDVEWFBqWUtiSjNrMnRqTVRGQ1ZwVjBBRCtZQkVHaU5BN1Uyd2pRL3Za?=
 =?iso-2022-jp?B?cXlrRlpUeUY1U25Hd2JxQjFqTkt5SGQ3ZHVRaHozRjlTeGhlS1ZnSXg3?=
 =?iso-2022-jp?B?TytZQVpKdkRyaUt6VzRPYXNLc2VhM2lMM1hpbzNqbldnTWw2c1NvUEdJ?=
 =?iso-2022-jp?B?bzlqZ2hxTUM1aWI4N2prdXh4Y0xtekREL1BjYnpKbWtRM0hsLzJ1dDFR?=
 =?iso-2022-jp?B?RzNtRHVHUkFCVW9zbnRUOERPUCtyRXhTeWpsSk1mUTJKZVM1R1lwRDNG?=
 =?iso-2022-jp?B?NGZhYWNXRVdWUnY4aWZIR3RIK2Y2aGROZkQvY200QlZPN2cyYlJ3M09Y?=
 =?iso-2022-jp?B?YytSaGJtekR5Z3FXcDBiUHJQK3FLamlWMUZDTUhEWFpUOG0zMWFuVGxW?=
 =?iso-2022-jp?B?RnAvT01CRlVGdEpObWJLc0pURVk1M0FlRllXMnNRVmEwRTZwR29scGkz?=
 =?iso-2022-jp?B?VHdpRjNPeGR5b3VnSG5JZ2gvSlR3NnhLU2dKNktrK0FZR0U1R1pqTUJa?=
 =?iso-2022-jp?B?bFI4dTRFMVlqbXJnNjgwb0V6VTFrL3ZXK1c1c2poejJmcGpaQXdaaGw0?=
 =?iso-2022-jp?B?WU5pOTArSFBZb1J2bHYxbVcxSXNiU21OKzRiYkVyU1ZOaDllWGljcVJ1?=
 =?iso-2022-jp?B?M2ZIVFBaaVNYY2pKWVBaeVJtM3QvRG54dz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: qnap.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR04MB5097.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5da0647-b393-48a7-fb22-08dc347afc04
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2024 14:23:19.8522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6eba8807-6ef0-4e31-890c-a6ecfbb98568
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vHBVwB3tmYMRzUR6pVdFAstC5N6Sk5lruma5W72GixtS+iM3zNYf7v9+ieBkcOOHwyw55l+sW0N5aFEhLN+tqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR04MB7780

> While you are sending next v, please re-phrase the patch desctiption=0A=
> using imperative mood:=0A=
> https://www.kernel.org/doc/html/v6.6/process/submitting-patches.html#desc=
ribe-your-changes=0A=
=0A=
Thank you for kindly feedback! Sure will do in next v :)=0A=
=0A=
--=0A=
=0A=
Regards,=0A=
Jones Syue | =1B$Bi-Xg=3D!=1B(B=0A=
QNAP Systems, Inc.=

