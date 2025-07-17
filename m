Return-Path: <netdev+bounces-207764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A043B087CE
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 10:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65BDC3AA785
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 08:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F242797BE;
	Thu, 17 Jul 2025 08:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="V7WCq4rQ"
X-Original-To: netdev@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022082.outbound.protection.outlook.com [40.107.75.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E3E7262E;
	Thu, 17 Jul 2025 08:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752740502; cv=fail; b=Q60/MCHLTVglbQxghQ5+SSISFU2WKfeu0wULY9t1SnJHJi/Fzmt8WMRUiJ4d62rXONkQwsF5xwHLBOzC0o6GG1oOhk3WkuGaeJu8P5UYDg9ZNADELfiaNUowaXSG+aZDL4qm6+TZMvIDZrfxGCUOZFMBnCbFze3IS4AlpWTZrP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752740502; c=relaxed/simple;
	bh=gzVtyOosevYZaZK5cytYouEaPjqQ+o/8MMnvYE/lzds=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ajMlxT/0PSQonTKH2QS1WoP0qHpyZtmPzNHw52Mg0AfTzqJMsNqHN+4ff6eDz7tCPFrwNBBah86cDjKQq11byQBlHImqd53EqpDzn2T4MD78liR3VnWQ9+/p8DE7wIWixXBoawlWN+rfaSQQ17M7g5+XOo8M3mbcyPlIuHu8rGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=V7WCq4rQ; arc=fail smtp.client-ip=40.107.75.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iK1+W5LUuzgECvoAXJsYAHHcYO1OFCwp0jkI873nNv2yz9AMEghN3yz845313cxKd09egCxPpeiHzVx5LscuxS0xqF6hVRk0fDNFHnBNB1MwEngKs28JCOCsZjXVgEIkBN9H8tDdubGJukNJKTCNAxn1rvgqIidGN5nUUbXP22j26NZbUW3oG0RH35Q8K9wXZC1Jc32mWHshUcGQa3D7fpUD86/lWPgziuEUQEGnfrEXF7Le08/qzM8euYVtHrWLqEQ0zwDVDOOehzjqL2iuglzI9MkoyLi5eO6vW2Q1y1g456Nq41F20Izu9GB+lxuHEnyrK3shFnXx8iHLZ7+1Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gzVtyOosevYZaZK5cytYouEaPjqQ+o/8MMnvYE/lzds=;
 b=bzhomsbo8tp7V+9o2nbaruFcO4xtg+/GdwwQuDFIoA0t7wNdc9YzXVSP0bQt+LkNCes6CJNAkoF8Mdj0p6iUUXxAysp6KFOX032VET1bvfbZXvc7r08v2MKQCllTl3LV0oNlquqSaHUsD2Cfsr0YGvWyD45ulHlzW5dRLp0CwlD9U6WoPw0QrTZ0Aw8XKKIrMV99Pv4qtDBs3f73cyXTQjiOIW76YKmRJmo9RDXHROot4vNKa5nDyRs3ilfSjGtD8MMMO0mO/C3czK5pMWyVCT07fc6wUMl9AYSdw+crHPzZGB533q57okImVSkWP7o3KhyqEMvHSSm6Qlz11SljDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzVtyOosevYZaZK5cytYouEaPjqQ+o/8MMnvYE/lzds=;
 b=V7WCq4rQdxuSS5+ZnzNV33C5kmth7wejNIw3o0P1PTTwEN6yJTER6QKbkrYfE3biq/CmZwxRDS/RU5E5kWs0hUhDNOBXkUJbL0e3W6VP5aoZ1x7CcJrS8fwmQW2CvVvnbVu7m1HWkN2KJWsgnFoIRsCPIxPEWpDBTBPTVgwYS+3zPLlSI6QzEFLSBwiyN1IplOGnaOMY14YdG/cTHxEfw1KCoosRAMhTYpcfCB054FsTnuS9bXBL4Abxf4vWOZ7wDa/3wP7F67VueIQvxYdLqpPpI6DNquEWm295UdDjnrHnMbTh+E9ERnn36JO2xG0ahw6Erf88spiTJ1NsJTF8Ew==
Received: from SEZPR06MB5763.apcprd06.prod.outlook.com (2603:1096:101:ab::9)
 by SI6PR06MB7116.apcprd06.prod.outlook.com (2603:1096:4:244::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Thu, 17 Jul
 2025 08:21:33 +0000
Received: from SEZPR06MB5763.apcprd06.prod.outlook.com
 ([fe80::ba6c:3fc5:c2b5:ee71]) by SEZPR06MB5763.apcprd06.prod.outlook.com
 ([fe80::ba6c:3fc5:c2b5:ee71%4]) with mapi id 15.20.8901.033; Thu, 17 Jul 2025
 08:21:33 +0000
From: YH Chung <yh_chung@aspeedtech.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>, "matt@codeconstruct.com.au"
	<matt@codeconstruct.com.au>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, BMC-SW <BMC-SW@aspeedtech.com>
CC: Khang D Nguyen <khangng@amperemail.onmicrosoft.com>
Subject: RE: [PATCH] net: mctp: Add MCTP PCIe VDM transport driver
Thread-Topic: [PATCH] net: mctp: Add MCTP PCIe VDM transport driver
Thread-Index:
 AQHb9Igk7vn3xpIukEauwkU1/K0+nrQxUL6AgAACe7CAAQ2aAIAAWoUggAMVaICAAAU3gIAAGncAgAACR9A=
Date: Thu, 17 Jul 2025 08:21:33 +0000
Message-ID:
 <SEZPR06MB57634C3876BF0DF92174CDFA9051A@SEZPR06MB5763.apcprd06.prod.outlook.com>
References: <20250714062544.2612693-1-yh_chung@aspeedtech.com>
	 <a01f2ed55c69fc22dac9c8e5c2e84b557346aa4d.camel@codeconstruct.com.au>
	 <SEZPR06MB57635C8B59C4B0C6053BC1C99054A@SEZPR06MB5763.apcprd06.prod.outlook.com>
	 <27c18b26e7de5e184245e610b456a497e717365d.camel@codeconstruct.com.au>
	 <SEZPR06MB5763AD0FC90DD6AF334555DA9051A@SEZPR06MB5763.apcprd06.prod.outlook.com>
	 <7e8f741b24b1426ae71171dff253921315668bf1.camel@codeconstruct.com.au>
	 <SEZPR06MB5763125EBCAAA4F0C14C939E9051A@SEZPR06MB5763.apcprd06.prod.outlook.com>
 <2fbeb73a21dc9d9f7cffdb956c712ad28ecf1a7f.camel@codeconstruct.com.au>
In-Reply-To:
 <2fbeb73a21dc9d9f7cffdb956c712ad28ecf1a7f.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB5763:EE_|SI6PR06MB7116:EE_
x-ms-office365-filtering-correlation-id: 4beac4b5-5885-4063-8a0b-08ddc50af0b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|42112799006|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?M1v0qxPf4ey08D7Gjt9uvJIzorqCpsuZbiTjkubjxiI/X1ci1oyQr95DwvRY?=
 =?us-ascii?Q?f+d4NZzZ0Joj/l75A4zzpjYrRLLbRMF7vBN1zdSIY3Rn7N0sQ81z4aoUIUWf?=
 =?us-ascii?Q?IQHEzjHt6qfh/hFb/7y2cnJXGytwnR2iVCu4TAUzpgHPox2+vTNtZLoLHBHe?=
 =?us-ascii?Q?RlZYo7tJyvBz11Q2hQus44SxeAQU1/vCOdPkc5u8aE5+HL8ITuvx1KKLWbuw?=
 =?us-ascii?Q?yxs6A0XUhxvmJ/q+RHfOqRiaFxhqfoZMIa2qTg4ORo9jt2luSuHmBPbVNWVK?=
 =?us-ascii?Q?TZw1TSZJn0dXcSMP800vvsbOp3S+SEW2rDQ1GjB4DbtyavtWbmtDa9F7Q38u?=
 =?us-ascii?Q?5ltFGdatK8jabFxvtYX60qaYeqW68yB2xT5aK35Yy0J8DYyRgrYR4d6eQ3M3?=
 =?us-ascii?Q?oeHcQHPa+i5IIJTOyykJVlX11xxVMft6ezCygHYeaNsSZYRpmHiJSI+MfvtP?=
 =?us-ascii?Q?q+ABV3k1UBpqTVIIXy9RDkHsFZRXzJuC9zVkW+5oef2NNSBsT1Dse/3Iz1l+?=
 =?us-ascii?Q?91jQKquEtWIXQ/31FenWu+VFJ0cC0p4ZHl4CM+Qrc3+p/zWkZln+/2BPxESy?=
 =?us-ascii?Q?Sdc+FShmrwbOT2j7RxEb7iR6u+c3wG/XQ+0m93wVYQh8XSQ2wekPHe6JJX3E?=
 =?us-ascii?Q?HsrFoWEAFvh/VlzLNoWHR4qXZMewcyn+4nBadTXqZxsTbqYRZITISPKQatY0?=
 =?us-ascii?Q?UcdkcCDdElSEVDwgpOEtj40+vCTkqcdyNOHfX58R8brKIuTO0IepPd81z0qC?=
 =?us-ascii?Q?QwUTCMS++eGeBKtY23Sex2DDR3bU2o1Af/krOLg8tP+jUi9AClhMCGVGzEHL?=
 =?us-ascii?Q?H2/O8bTVjqHX3cdgV9Uxyyt5ggw6HSyHQ7husP/Bks0diQpD3xi5wezqa+H1?=
 =?us-ascii?Q?GCbd7F82FsTmJ6JhtsKCUq/POantZK81kBo1Bb4NL80YAO7uVxzZ+ustKWtK?=
 =?us-ascii?Q?bM4g+yYFc3pxAtvXEeo1I5DE/OdLDPiQEttbqOwtTbtejURGv3sGaca9ej7G?=
 =?us-ascii?Q?0o0k7fPxDwAz2ZFPeVnVIIIJwGGYekqtgrkqWs+VdU0siB/AtXejMGkHSMkj?=
 =?us-ascii?Q?/DVKhISbrrCmdztBFpfL4Yafcf9RYsnDBTINyWFSfVdWwp+ENi0TYJkF13eW?=
 =?us-ascii?Q?KDnpKjJPRUD+zU4M7TtGziqin05AR13W0uUQLYDlkv74sdPjxvBC5IImGGoz?=
 =?us-ascii?Q?5SIsjFSV8aCfnbomPG7zPe/okOzNZ4WmNm5RIkgO4bU7yY/PQ8ZqGOequgsV?=
 =?us-ascii?Q?z8+Fk4BR6HteJi2GH4WY1L/n2VposaCl4arBrU7twv/wHRb7HGQHoJ0c8YBk?=
 =?us-ascii?Q?zH9jyW7AOfx05Jf+G6UTJ5FAXL+MMldaOTv77GZ7XwxA8h3u8vDqhDnK+/3b?=
 =?us-ascii?Q?zX1sBs4Vdw/ZeUeuGv436v2McQ5oa3qoAwCEdzKHr6XLEqTv2iJlzzSv8j4I?=
 =?us-ascii?Q?w90WlnQmUoLsIjbwT0A2ZKDp4t5Pl8Se5SZYaX+rY48Qa+nxqZ49cCVG+7Vm?=
 =?us-ascii?Q?644pcEcDIaaw8DU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5763.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(42112799006)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8UU2PZcG4mlVYudk+114fMDsRCzK8AV4KiIqu4fJou3Pqw34ozyksEYzh//5?=
 =?us-ascii?Q?j/CslXg+yIyGAYH6f7EewqyYvSifCeWtLR6YPOa3DcYlB30lffBXzQzJyO92?=
 =?us-ascii?Q?t3qG6mByov8mZxMqR2Fn0seHjF+ShncAPhRHuEexonyYMe4DILufwOA5x3wP?=
 =?us-ascii?Q?rqxdYpOEBVGsilEihAz6bLc4tu+NFU2EHwKuCvtksyZvN+NHv8njoaKVn/5n?=
 =?us-ascii?Q?g9eQp2Xrf6jrTqKPItVOQfI0OnvmJSvHNA6ZGh5XffXYTLWlDlxyOUTO/SwX?=
 =?us-ascii?Q?eK3oeN0hGI2xD7w7D7FB3rVGAS2zN1OjCu8WJxdkbuKChNqsX+vqlMTJ0wVJ?=
 =?us-ascii?Q?HnFdFJU3SyAKEiyGk/NSyA8pvsPGWGPFb3dJNPNLw1sAw8m3aooXVOYEA/jU?=
 =?us-ascii?Q?Gh9/EQsocqa0JL3fKSfMFXE/b+bQogJsgwIluuirAGbY1W8Iblupeu3sN7lv?=
 =?us-ascii?Q?/c6nHHZjRH1RCzf2q65Ac//JHLvjoXK0l3DHsZ6datufoAatoYy8NsGSxNt0?=
 =?us-ascii?Q?3bw3qO4k+EYXSNXBvMEidE1Y8AzBv5CcDlMrgVJOO9YzKVRlbP88YxJLlkSz?=
 =?us-ascii?Q?4njrjuF7xjapVWxufVMiddsn6ZAarqDlgHjgRLVOPWetZN8cTPRCH1xO7pUX?=
 =?us-ascii?Q?swFyA7MqL1otJ85RLQqH9Nl0lUv6dImGZzLd5XJkpAOFbMq67OeVWz5H+UqG?=
 =?us-ascii?Q?aSqQF65lZsClRAtU9YNm75Ni6zyyQdkeAOdcFUJEEGQQrgwt9izvEG8cIp6r?=
 =?us-ascii?Q?gjagS8UGArK5VEFWmCgH1DA7tsahB2NsW+Ev04XM+qnv5ofhO9C0tS8eY3IB?=
 =?us-ascii?Q?tNsSckaUS74rLuzgMfr8NzBbS4N6O3fw4GrgHV61OgH5oPLSnckDzGTwQV68?=
 =?us-ascii?Q?RIRbrrgXYVvykeV7FC+OUmDKYGmyQm9fn+DEwa9TgNPrFRcEN3AhOO32z4Rt?=
 =?us-ascii?Q?THtqSkVVdLrt0rxzFRxsbLmQX80xvgTr7WptRvfTVgB//az3EWL+Jkhb0PPj?=
 =?us-ascii?Q?I0xySw0QOdUarO/+ITC6O84hfie5lC7ToYqvGO5pK0++C/hkGT8iJCXUt0Ug?=
 =?us-ascii?Q?9kVr31Y13Sw1+WW79IJWL3uLQFx0ypIxUFDzrPyIdOuk5yX14Kpk9JNlhaXP?=
 =?us-ascii?Q?SLZiIWcr6FnahB2xoNbC43OtScT54ZJOeGkuNGFCxqMGchxLkQKM5xNMpoQ4?=
 =?us-ascii?Q?83E7E/GPP5Da8ufCSYnF/LCOQXLt/lMkUZsi1umXgU+4WARnBUefURF2/UXK?=
 =?us-ascii?Q?J122Wm6esqHgu+U3xxV3Z4G6erFy0J0FOuj7H5BeqsTudL+foSigNf37FlKW?=
 =?us-ascii?Q?kiTdtxvO15RYxgIIBF8FZP1Z58KwozXBr0QkQDj4G2gKPSJZ0NyleJmhu+pX?=
 =?us-ascii?Q?kdY68ArS5shwH7i8KVUAHhBWp081kI0hfZemdyRnUHwWSMO0fKSTe40ulDLF?=
 =?us-ascii?Q?cIchkhdNoDnCHb63JKR1l/61UN0ApZsrJxpkHOGjE8dohc3+fuwGmhHnApo/?=
 =?us-ascii?Q?LOl97FO2cFxWT/aQbClwu+z6ggCrYW/TT80Y+E9bICA/Q0HxESby9pYC7QbK?=
 =?us-ascii?Q?ep59xwYJedx3EjAKm5CzVb7z/Vxw04WeF7ycwSr0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5763.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4beac4b5-5885-4063-8a0b-08ddc50af0b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 08:21:33.4731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZvhBz5xEfnDJWSAZFySNC2IXJpxdi8JXWE0qCAJLi4Vdj5XlVHeF4xwBDmX+wEWk68rx/y8AFOFg+dKxBLgb3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR06MB7116

Hi Jeremy,

>> From my perspective, the other MCTP transport drivers do make use of
>> abstraction layers that already exist in the kernel tree. For example,
>> mctp-i3c uses i3c_device_do_priv_xfers(), which ultimately invokes
>> operations registered by the underlying I3C driver. This is
>> effectively an abstraction layer handling the hardware-specific
>> details of TX packet transmission.
>>
>> In our case, there is no standard interface-like those for
>> I2C/I3C-that serves PCIe VDM.
>
>But that's not what you're proposing here - your abstraction layer serves =
one
>type of PCIe VDM messaging (MCTP), for only one PCIe VDM MCTP driver.
>
>If you were proposing adding a *generic* PCIe VDM interface, that is suita=
ble
>for all messaging types (not just MCTP), and all PCIe VDM hardware (not ju=
st
>ASPEED's) that would make more sense. But I think that would be a much lar=
ger
>task than what you're intending here.
>
Agreed. Our proposed interface is intended only for MCTP, and thus not gene=
ric for all VDM messages.

>Start small. If we have other use-cases for an abstraction layer, we can
>introduce it at that point - where we have real-world design inputs for it=
.
>
We're planning to split the MCTP controller driver into two separate driver=
s for AST2600 and AST2700, removing the AST2600-specific workarounds in the=
 process for improving long-term maintainability. And it's part of the reas=
on we want to decouple the binding protocol logic into its own layer.

Would it be preferable to create a directory such as net/mctp/aspeed/ to ho=
st the abstraction layer alongside the hardware-specific drivers?
We're considering this structure to help encapsulate the shared logic and k=
eep the MCTP PCIe VDM-related components organized.
Appreciate any guidance on whether this aligns with the expected upstream o=
rganization.

>Regardless, we have worked out that there is nothing to actually abstract
>*anyway*.
>
>> > The direct approach would definitely be preferable, if possible.
>> >
>> Got it. Then we'll remove the kernel thread and do TX directly.
>
>Super!
>
>> > Excellent question! I suspect we would want a four-byte
>> > representation,
>> > being:
>> >
>> > [0]: routing type (bits 0:2, others reserved)
>> > [1]: segment (or 0 for non-flit mode)
>> > [2]: bus
>> > [3]: device / function
>> >
>> > which assumes there is some value in combining formats between flit-
>> > and non-flit modes. I am happy to adjust if there are better ideas.
>> >
>> This looks good to me-thanks for sharing!
>
>No problem! We'll still want a bit of wider consensus on this, because we
>cannot change it once upstreamed.
>
>Cheers,
>
>
>Jeremy

