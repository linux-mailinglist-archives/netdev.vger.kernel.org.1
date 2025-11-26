Return-Path: <netdev+bounces-241849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C412C895D6
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 11:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8395F341268
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 10:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED45B31D387;
	Wed, 26 Nov 2025 10:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hitachienergy.com header.i=@hitachienergy.com header.b="p3vUZYr1"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010007.outbound.protection.outlook.com [52.101.69.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E410430170B;
	Wed, 26 Nov 2025 10:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764153937; cv=fail; b=ZmSky/WxjjbgZfICpANzEtK2hfwP7CCW40dM5s2904iZ6muEJ720qE5S+M3EBxyOueapE9Uli9qk9p61vM6/so56SxXmTclohs4e4m0LWBWbY8VTUliTGUu4we49oPzWF6XykP4Im8abePb0FQeQ3Qs84JS/n+QLidgckZXeGV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764153937; c=relaxed/simple;
	bh=92HdaufFl8F3RK7rM2axvFJEYq8xTITEC2fvVG4X+7Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QT3wTpaS8IE69jYCnvnMSaBLf5UsIHTKdgM1lwWNd+zCTppbkLQVFcOyyRPG+8cMFU6tD/9bFgKBLspy2266PV5MVs1UehbiV9VWFEu2NAxMfH0U1Lm0UtuRnZ4bg9xJZL1a6La2oixT8SMxF3F2DD/1YOY0O4BDwnCvQvYnYd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com; spf=pass smtp.mailfrom=hitachienergy.com; dkim=pass (2048-bit key) header.d=hitachienergy.com header.i=@hitachienergy.com header.b=p3vUZYr1; arc=fail smtp.client-ip=52.101.69.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hitachienergy.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yeIa0B9vgPbefo6YSXxaY44n2DHORveofC+DfItTQK0AIS5ZPxykCVNB3TIghzydExdACchtN9DWIeJyxETda54iQQCSpsiYaBziSs3TG98mSPcaZwlX52Z/XJ7/owQMF9tQHMLIDwWN2qgLk16kxDKuwekvu9NSwKWT5FBmQ7cEWmhRYOihIaFVri81elqPyhritpGDuzRrFQimpM5Tc6mLqJaQ+pWbW3agF6FOrsASnWfa4FGmr4IUdBrDbJwnUUBO6pegX3scikKdOZC6bmA3683g9fHzS0DL3DSHuPRl5IEQ4b8Kl4YDd/Kk19KjZhk+Ej80im4pAeVea/Ypyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfEVPr1H4oEuD246IlNjg9OXFNg/g9tpvvf1em+f+jU=;
 b=RyjjLmffswA0i+kzLtCE5uIxDX24QoQgXtEsYOETOWreHP2MCG2euOjoPcF6mWCqYXj5R5FJUVMy7zvbjE6tWhpsKzyZ/rKI6m5vB4BEzKsz1iKAAtzti4Vg97s7mx+h+USFL4Ic4z5Jtc5N3cmaabEj5urm4Jn2vjtSubqGMFA16/7U+JHD1X6DxlYcLSSWzP9VKxZkxX5RN7ufVwWi0Yz0CTGimdf3moo6LWVXViiObZGR3hG60/8kQjDVzTT3I9YgeD+kVyHs+VKTBrkr8NenP2eANzo+RVkRLTifBpJ+gNgGssSriJpwqI3NWF54/ru902N+rD1sJnoRidgy6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hitachienergy.com; dmarc=pass action=none
 header.from=hitachienergy.com; dkim=pass header.d=hitachienergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hitachienergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfEVPr1H4oEuD246IlNjg9OXFNg/g9tpvvf1em+f+jU=;
 b=p3vUZYr1M/XHokmlKSFiTTnM8IIDSO3/Iq/zXsPYm5cXt8VqO3WcoOVP76psTkN2apI842T0IQkyDXZfS6I0Vu95H9p9ypf0tAiE3VUhObZgg7EaNLcMCMOxBjuE4PlrswCIS+6IkxpQoortPzF9itkZTSPy6aUFeiOfrEtmdd9v9ILhbAJJnRZB/moWHd2D3Mkx/PrQGJUqfywaFV1Rf+mo05xUUZdAQ6v2sF2hWHq4RU5M3P4r8XLZS007URg95FrlFsgcrBKUZhYs+zYZJj6U7WfFyXpTHOblZ2uVscj+O+J3B28drZoYCYStIT4tFewK3OG3XQG9fwY7dDovbw==
Received: from AM0PR06MB10396.eurprd06.prod.outlook.com (2603:10a6:20b:6fd::9)
 by AS4PR06MB8518.eurprd06.prod.outlook.com (2603:10a6:20b:4e5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.18; Wed, 26 Nov
 2025 10:45:31 +0000
Received: from AM0PR06MB10396.eurprd06.prod.outlook.com
 ([fe80::f64e:6a20:6d85:183f]) by AM0PR06MB10396.eurprd06.prod.outlook.com
 ([fe80::f64e:6a20:6d85:183f%6]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 10:45:31 +0000
From: Holger Brunck <holger.brunck@hitachienergy.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Andrew Lunn <andrew@lunn.ch>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-phy@lists.infradead.org"
	<linux-phy@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, Daniel Golle <daniel@makrotopia.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>, Heiner Kallweit
	<hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
	<kishon@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Eric
 Woudstra <ericwouds@gmail.com>,
	=?iso-2022-jp?B?TWFyZWsgQmVoGyRCImUiaRsoQm4=?= <kabel@kernel.org>, Lee Jones
	<lee@kernel.org>, Patrice Chotard <patrice.chotard@foss.st.com>, Maxime
 Chevallier <maxime.chevallier@bootlin.com>
Subject: RE: [PATCH net-next 1/9] dt-bindings: phy: rename
 transmit-amplitude.yaml to phy-common-props.yaml
Thread-Topic: [PATCH net-next 1/9] dt-bindings: phy: rename
 transmit-amplitude.yaml to phy-common-props.yaml
Thread-Index: AQHcXqYGtlM98xQGlkSgPr5ML7/KzbUEqGywgAAalgCAAADHsA==
Date: Wed, 26 Nov 2025 10:45:31 +0000
Message-ID:
 <AM0PR06MB10396E5D3A14C7B32BFAEB264F7DEA@AM0PR06MB10396.eurprd06.prod.outlook.com>
References: <20251122193341.332324-1-vladimir.oltean@nxp.com>
 <20251122193341.332324-2-vladimir.oltean@nxp.com>
 <0faccdb7-0934-4543-9b7f-a655a632fa86@lunn.ch>
 <20251125214450.qeljlyt3d27zclfr@skbuf>
 <b4597333-e485-426d-975e-3082895e09f6@lunn.ch>
 <20251126072638.wqwbhhab3afxvm7x@skbuf>
 <AM0PR06MB10396D06E6F06F6B8AB3CFCBEF7DEA@AM0PR06MB10396.eurprd06.prod.outlook.com>
 <20251126103350.el6mzde47sg5v6od@skbuf>
In-Reply-To: <20251126103350.el6mzde47sg5v6od@skbuf>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hitachienergy.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR06MB10396:EE_|AS4PR06MB8518:EE_
x-ms-office365-filtering-correlation-id: aa7f3d95-3f27-43c8-4f44-08de2cd8ebf4
x-he-o365-outbound: HEO365Out
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?RWZsUUFFWU9RcHRYem9OVnpEUFBlQ0dmalBCWFNPanNXVFc5YW9KdGhV?=
 =?iso-2022-jp?B?bGN6UWJReGxmTmFyaWFkVWRWZnFVWnk1Q2NiZDJCQ1Y3VGR0ek43L1li?=
 =?iso-2022-jp?B?WUw3b29UU0M0eEx1Z2Q1ci8wVjR6QTVMZWZiNXlWenphaFNER0xMK3px?=
 =?iso-2022-jp?B?UzRyeFcyU3lDVzYyVXNFdGlWWHN2WmUzN0NWVVFKdDlLbkpFM0ZmTkEv?=
 =?iso-2022-jp?B?OW1vbTB2WjdxYm0waW1hd3ZJcGM4OVVmeWdkRU5INC9YV1AxMGJwVmdG?=
 =?iso-2022-jp?B?ai8wT1IvQ25ieDBMVEF5RDFSaUNQY3A0NXRHa1VVd2lVVWJsaUtteS9n?=
 =?iso-2022-jp?B?QkR1c091VDRJR3liMkdzcWF6Q2Z4eXY1bGVEU0xvZUlxd0VERkIvUmti?=
 =?iso-2022-jp?B?Y3VtUHlUR2ozOWg0dVArWmdGb3FiY002VjdpNVpIblZ3WGFudzFVOG5R?=
 =?iso-2022-jp?B?T0VPblVldVV2aDRJTFlSZmZPSjdPbXZoQ1dTM21MemZaNW9mdVA1aWJS?=
 =?iso-2022-jp?B?cjNSZzVhWGJJODRzR2xLVDJCengzU0lKVnp1UkxQdkx6YWF4elNzTCtS?=
 =?iso-2022-jp?B?VGp1ZlU2TjA4bnFiQWhLRTIvNlFMOUhSSEQvVWdOajFMTHN4eVowZldT?=
 =?iso-2022-jp?B?aVVvVGQwdWdzSEZ1VEtsZ3N1aGdTekh2RmRNdERVN2UrMncya0JtM09Q?=
 =?iso-2022-jp?B?dDNZTVhqMFVHUm9zM3lPSzNpb1FPZ0dVZHhQcEszQ1AwbkpyNE4xRHBX?=
 =?iso-2022-jp?B?ejFwOUhrblVDR2x5bUhVZVJiRGtnM0dNRUlpSytxQ0dTd1M1Q1QvKzEz?=
 =?iso-2022-jp?B?KzZXaFBzN1h3bWoyQ0ZpcEQ0d09sbHBWcjVUdWtjK0tudkVzbytYTk5j?=
 =?iso-2022-jp?B?YWQ0bkkyZXFhb0VUQ2Z6UDdJbGdoWmtIekFTNEtTYS94WUE5WHk5enNi?=
 =?iso-2022-jp?B?MlNpVHF2QVV4N0FUWm4ySjRNM2o5OWJmR0dNNEJ0Y25WZUZNQ2F2MUs4?=
 =?iso-2022-jp?B?TUNsQ2kyQ1ZYa25lVE9kRHVOMFFsS3BMSlBMRVlleXdkQ2RCdytZbFB3?=
 =?iso-2022-jp?B?bmFOKzdKaHdWWGNPK0l5bUVHOUpwN3lmZHBMR240b0xmbE5UVjBPOXZV?=
 =?iso-2022-jp?B?TGRUaVFpV3BnMzdaWmIxMEJXTm9YWWlqdlNveXU0K3VudVZ0SmNZNFVx?=
 =?iso-2022-jp?B?RzJHclR5THJRZUZGQkxRODIrcnFVdnhNYklITXJrQldBVU41a1dGd1pQ?=
 =?iso-2022-jp?B?Y1FnNEpaWDRoVE5pWHM2Q3gyK1BXY1hOZkF1SC90c1lab0hRazVJL2lW?=
 =?iso-2022-jp?B?MHltY1R1T2tTbi9IYWlKRUJ5K3owTHJ6QkNYVHJ2TEVyWjJjaEQ5UEFw?=
 =?iso-2022-jp?B?V29aN09oa1RGclpmNTRLR2VCV0NnMUZPNjVtYU51STY1V2FxbDExazVG?=
 =?iso-2022-jp?B?MWlIUE1ocnYwaFY5RmZtczhCVWFiM0NTVmhNTE5qblZSb2V6MWxGV1Jt?=
 =?iso-2022-jp?B?VkozTzVBSk9kV1M5OWNxNXA2elFlbkhuM1crbmJyT3kxd041SGZaYjZ6?=
 =?iso-2022-jp?B?Yi9BYzBuTk1OTFhNeDRmNVFGa25TUmZKdGI4VDVIYWtJc1BiNlBaaGpI?=
 =?iso-2022-jp?B?OXhCTWk2VWZ2bzhQNXBITXYrc2Jtd3Ryc0YxMWM1bGlpU3RuN2oxa2Mx?=
 =?iso-2022-jp?B?eHBXU01uYTR3RkFKMmlYK1AwOHlmLzN3RzVLVU5LTmVMYmo3MnB0aFhM?=
 =?iso-2022-jp?B?QW9oYW5BRjl0VXpzaE1nZWhiV1FoeVA2VW01OWpCSHk3V0k2TVBsZG9j?=
 =?iso-2022-jp?B?Y1JlSjY5UW44QVdTMVZRWEhQM0Y2aVJPNlc2cVYwVTFhNnQrT0pWM04z?=
 =?iso-2022-jp?B?UUZrczBYb3lwRmNrS2lteTlmcjdFSjJ0RHYrTU82emdCaS8reURTdGdG?=
 =?iso-2022-jp?B?RHFqaXFkcmtVYjY0bzgrektoME5saFN4M3NPNXkxQmJIVHpkMTFFMzNG?=
 =?iso-2022-jp?B?aDlCTE5DSHA4cjgzNFIwRlZBQ3NhM2U4V0VoLzliTjNxTUJpSDhPcUVn?=
 =?iso-2022-jp?B?UE1kZEtUR3B3U2NUM0FhUXFkZjg5S0xqeTRpYitXYzJ1UGtWZU1lbTVt?=
 =?iso-2022-jp?B?MVJYQmxjVGc5WUpIaVlUYmI3bFNFdktQbU1icGlKNm9VV0tHZXRuSGVC?=
 =?iso-2022-jp?B?R1o0QXNhUjRqb21UbEpNT0NkYUZCTUhz?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR06MB10396.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?QjIySkRlRUVXVjIzL2cvOWFlUnIrU0FGSkRGSGJ6ZHJYbWVENFdvQUhC?=
 =?iso-2022-jp?B?Ly9aTDBkY1FJM3IxLzZTeU5saVZveVQyaEN3QmcxRGN0ai9VaTRacXdj?=
 =?iso-2022-jp?B?YVFTeVBSdWUzTUpnT2NWRUFtYkNWbEt0bXprYnJicjNlQVdPay9vWDlR?=
 =?iso-2022-jp?B?ZWJXYmZlVG05SVBvZWltR2FqYUhYSzBBUXJkVjJQdGtBemc0RjQ0UzR3?=
 =?iso-2022-jp?B?dkQ1S0xoejNwQlFVVm8wd3htTlM4V1RyQjJtZE93aUlFOFdyQy84YnJL?=
 =?iso-2022-jp?B?dGV6M3kvNWpiL0dFWlZVdWw2NkNFamZ1TFFjRFByMlg0NkdMei9MM0Ez?=
 =?iso-2022-jp?B?K00yNE4ycnFnVEp4RmZGUlZLRkpFYi9UcGxRSmkzeGxZdnFyNjdpNHFS?=
 =?iso-2022-jp?B?ZFl1VzNwNzJFZ3QxTldmRVJZOEFVREI4UUVHMGw1djZYc2p1Q0wzdzdw?=
 =?iso-2022-jp?B?SHF1S0ZLbHd2Zlg1YnBBM0U0R2M1emV4TXdDUGRPb1FITjJaMkhJaUZU?=
 =?iso-2022-jp?B?OUh4STVWRUw0ZHVsOUVpZDJ5dWJtc1AxY01BWXRuUEFnZDh5cVJTbElE?=
 =?iso-2022-jp?B?Z3NodHhOQ3NscHVmNURDUUFjV1RHSWtGaWtIYUwrN2o2K3Jhd3plQjdB?=
 =?iso-2022-jp?B?MzR5VmlZMzNncGFjakRBd0NxZ0ZYOWJBQmFiNElINVpjYmF3UUp0QUIy?=
 =?iso-2022-jp?B?aHlKVUlNN091eFY1MVNpOU9BQzhZZnhia0YrczluanFhWDRjK3BOWkMr?=
 =?iso-2022-jp?B?SXlNRUVROW9jQXZiVlE4R29vSFUya3BibGo2KzY1aVdoQzFMNGozbnMx?=
 =?iso-2022-jp?B?Q0RvcjZTejJuclBQTWFQZ3djRmlFWm1HYStTMm94anVIMTUyOXV1SlVu?=
 =?iso-2022-jp?B?c0RzMzVhR3FyK3JjRnZHVXY2aVdoSzlvci9YTExaNE1aVHFTQVgrd21Z?=
 =?iso-2022-jp?B?OXE2Sjc2ektQYVU3b3lYczl3UHRTME9RS0dEakEwd2J2NXZ2akhaTkRF?=
 =?iso-2022-jp?B?NUsxZVl1ZHNtQ2h0dU5ORkRQRkRMMmt2WkRTOGpYZmpJbnY1ZDJHNFh4?=
 =?iso-2022-jp?B?TkFnV05LR0FjekpVY3ZPMnBqNXhac0pQbjJTNkN6VGdtSTV4Rjh1c3FR?=
 =?iso-2022-jp?B?Q0xraFZLSEdXSHNPQVpXQmZtUk1SdUxsVkQ4QTBQYmVoYUpsQkhnelVm?=
 =?iso-2022-jp?B?Q2FSa1FQWVJaM3dXV2NXbEoySVo0MSt1dmgvQkJhTWt1OUlHQ3NjYzZi?=
 =?iso-2022-jp?B?M1BBQndIVVVGZER5V2dYMnN6MmRjUUtscHBUUnZqUHdSMGYvSWc0K0gz?=
 =?iso-2022-jp?B?U0wvckRNY2tzR3FCRlI1ZUJ4bjhpSGptK1V6RytzeHZleXA4NHluTGZK?=
 =?iso-2022-jp?B?ZTRTVEQ5WXZ1SGtNbWpzZ0tpSmVwZ2kybEpsRFlkdVkvT3h6ZTBOUTho?=
 =?iso-2022-jp?B?M2lxcDd4dXkyQXFzLy9pOVplWTJkRi93VTNnZ0dKK0RsLzlHTWJkRWo2?=
 =?iso-2022-jp?B?a2p2ZG10bnNROGl1bnBnOXZvemQ2TDVsd3B3TXZScVFRYnF4RHpEeXlq?=
 =?iso-2022-jp?B?aUk0MVQ5RkNicmJXTWh5WllscDJoMTJlVDNBdkE2N1ptWjdkODJkUldC?=
 =?iso-2022-jp?B?TnE2RmdTQmVFY1ZCOWRVN1dhOEU2QWUzUjM1NWs0UlBPdjNTdTBZc2I4?=
 =?iso-2022-jp?B?UU5TY3ZMdTJTNWFyZElhTmdlTVdIakNINWhabVZFL1ZHQTZmY2JteWRP?=
 =?iso-2022-jp?B?NTdreGxqbTNKaW9jc1Zoc1FkU2VVM0liMUo0ZzAwdGxsUHBYeVpmODYx?=
 =?iso-2022-jp?B?ZzhGZkVGM2lES09MSDRQUVE5c2lNU1p1SGUrUHBtVFRWL1M2WDJoRE45?=
 =?iso-2022-jp?B?Q0tzaFV0UWRxTytDZVZjdDdmZlFrejZKM1BtZ0dPdk1iT0hobTMxSTQr?=
 =?iso-2022-jp?B?OWQ5eW5pWjVXc2F5UjhyQ3RQaERFcURuUVN1bVNQKzhEMWZVMzZ0S1Nn?=
 =?iso-2022-jp?B?NkxrV21tVERxQXh5V2YwWTMxRGhYalc1enhoWFNsN1VoSk1zaDhnZkpI?=
 =?iso-2022-jp?B?NWlMZDFVY2RGeHRiMkVJY2U3bDBNNjVXK0RiUU1mdkpJUDJURVgwbGth?=
 =?iso-2022-jp?B?UHJ1NmViaXUzYVpydmR2SWRua0JmZWNLYitKZlVBYk5hUlg4Zm4vQW9l?=
 =?iso-2022-jp?B?MHBFd2F5U0sybWEzYTdKb2NkYU1NNjJpVTgvdDlBKzJJbGV3VVJnVVhC?=
 =?iso-2022-jp?B?d3NWbFM3RnBQVUhlYTRyQ1k3MDdjNUdyWGlDMXIzUkcwRXZRcWJaellN?=
 =?iso-2022-jp?B?SlQ4RlMyTUJRcVp3aHhMais2OHdtcHQvQVE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hitachienergy.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR06MB10396.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa7f3d95-3f27-43c8-4f44-08de2cd8ebf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2025 10:45:31.6036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7831e6d9-dc6c-4cd1-9ec6-1dc2b4133195
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wniMB5ciojiORDr315/Wx4mKgslqD3lqchjs8y+IDSgjrVwP+sDkQlljMZm0HqXNb7rSSpdr0ezQgDRCRTTKGKKW/T2Tubc1Hc3nUFp/v+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR06MB8518



> On Wed, Nov 26, 2025 at 09:32:30AM +0000, Holger Brunck wrote:
> > Hi Vladimir,
> >
> > > On Tue, Nov 25, 2025 at 11:33:09PM +0100, Andrew Lunn wrote:
> > > > > Yeah, although as things currently stand, I'd say that is the
> > > > > lesser of problems. The only user (mv88e6xxx) does something
> > > > > strange: it says it wants to configure the TX amplitude of
> > > > > SerDes ports, but instead follows the phy-handle and applies the
> > > > > amplitude specified in that
> > > node.
> > > > >
> > > > > I tried to mentally follow how things would work in 2 cases:
> > > > > 1. PHY referenced by phy-handle is internal, then by definition i=
t's not
> > > > >    a SerDes port.
> > > > > 2. PHY referenced by phy-handle is external, then the mv88e6xxx d=
river
> > > > >    looks at what is essentially a device tree description of the =
PHY's
> > > > >    TX, and applies that as a mirror image to the local SerDes' TX=
.
> > > > >
> > > > > I think the logic is used in mv88e6xxx through case #2, i.e. we
> > > > > externalize the mv88e6xxx SerDes electrical properties to an
> > > > > unrelated OF node, the connected Ethernet PHY.
> > > >
> > > > My understanding of the code is the same, #2. Although i would
> > > > probably not say it is an unrelated node. I expect the PHY is on
> > > > the other end of the SERDES link which is having the TX amplitudes =
set.
> > > > This clearly will not work if there is an SFP cage on the other
> > > > end, but it does for an SGMII PHY.
> > >
> > > It is unrelated in the sense that the SGMII PHY is a different
> > > kernel object, and the mv88e6xxx is polluting its OF node with
> > > properties which it then interprets as its own, when the PHY driver
> > > may have wanted to configure its SGMII TX amplitude too, via those sa=
me
> generic properties.
> > >
> > > > I guess this code is from before the time Russell converted the
> > > > mv88e6xxx SERDES code into PCS drivers. The register being set is
> > > > within the PCS register set.  The mv88e6xxx also does not make use
> > > > of generic phys to represent the SERDES part of the PCS. So there
> > > > is no phys phandle to follow since there is no phy.
> > >
> > > In my view, the phy-common-props.yaml are supposed to be applicable
> > > to
> > > either:
> > > (1) a network PHY with SerDes host-side connection (I suppose the med=
ia
> > >     side electrical properties would be covered by Maxime's phy_port
> > >     work - Maxime, please confirm).
> > > (2) a phylink_pcs with SerDes registers within the same register set
> > > (3) a generic PHY
> > >
> > > My patch 8/9 (net: phy: air_en8811h: deprecate "airoha,pnswap-rx"
> > > and
> > > "airoha,pnswap-tx") is an example of case (1) for polarities. Also,
> > > for example, at least Aquantia Gen3 PHYs (AQR111, AQR112) have a
> > > (not very well
> > > documented) "SerDes Lane 0 Amplitude" field in the PHY XS Receive
> > > (XAUI TX) Reserved Vendor Provisioning 4 register (address 4.E413).
> > >
> > > My patch 7/9 (net: pcs: xpcs: allow lane polarity inversion) is an
> > > example of case (2).
> > >
> > > I haven't submitted an example of case (3) yet, but the Lynx PCS and
> > > Lynx SerDes would fall into that category. The PCS would be free of
> > > describing electrical properties, and those would go to the generic P=
HY
> (SerDes).
> > >
> > > All I'm trying to say is that we're missing an OF node to describe
> > > mv88e6xxx PCS electrical properties, because otherwise, it collides
> > > with case (1). My note regarding "phys" was just a guess that the "ph=
y-
> handle"
> > > may have been mistaken for the port's SerDes PHY. Although there is
> > > a chance Holger knew what he was doing. In any case, I think we need
> > > to sort this one way or another, leaving the phy-handle logic a disco=
uraged
> fallback path.
> > >
> >
> > I was checking our use case, and it is a bit special. We have the port
> > in question directly connected to a FPGA which has also have a SerDes
> > interface. We are then configuring a fixed link to the FPGA without a
> > phy in between so there is also no phy handle in our case. But in
> > general, the board in question is now in maintenance and there will be
> > no kernel update anymore in the future. Therefore, it is fine with me i=
f you
> remove or rework the code in question completely. Hope that helps.
> >
> > Best regards
> > Holger
>=20
> Thanks for the response. So given this clarification, how was commit
> 926eae604403 ("dsa: mv88e6xxx: make serdes SGMII/Fiber tx amplitude
> configurable") useful for you?

the Kirkwood based board in question was OOT. Due to the patch we were
able to use the mainline driver without patching it to configure the value =
we
wanted.

The DTS node looked like this:

&mdio {
        status =3D "okay";

        switch@10 {
                compatible =3D "marvell,mv88e6085";
                #address-cells =3D <1>;
                #size-cells =3D <0>;
                reg =3D <0x10>;
                ports {
                        #address-cells =3D <1>;
                        #size-cells =3D <0>;
                        port@4 {
                                reg =3D <4>;
                                label =3D "port4";
                                phy-connection-type =3D "sgmii";
                                tx-p2p-microvolt =3D <604000>;
                                fixed-link {
                                        speed =3D <1000>;
                                        full-duplex;
                                };
                        };
	};
};



