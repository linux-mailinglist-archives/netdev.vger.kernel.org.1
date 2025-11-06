Return-Path: <netdev+bounces-236389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 35614C3B930
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 15:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8D86A34E3A4
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 14:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970A733A01A;
	Thu,  6 Nov 2025 14:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="dI/fvh56"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010035.outbound.protection.outlook.com [52.101.85.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC21339B20;
	Thu,  6 Nov 2025 14:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762438074; cv=fail; b=MW6OAqlIH/mcm+qXWjzawoDpnqoWZ7MJ6STUS0c/8yH1hBhdc4mJQ8Q9SPFG7cmXD4KaOqFnyPQGiqQaIzQi7CUbLuOqoZhFCJF/UsEbIiJEfVxSMij88CzGeCSqcuExbb4Xw/GF68hJX4hY3ZuLsF+4BvSZPaXxrph7OwZ2PFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762438074; c=relaxed/simple;
	bh=x8ChqIFBtNtGBkPsj5Ezm1fqVaaA9vk3D6FSUYk9+F4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dYI1tZdxSPoTiv6btxXmqBwJ1gsHrxTudYAX4c5VcoYtqHU9D14SlhpVrIv+S6va3TOqZKkRoHBGjn+3TJBwALDKNjvVL8xU3bG5feYLEnZ04qQ3iIktmxvd+84S3JL+I6slca93KNOxqb7m9x+c1izlPrLrhqksgkPk8KZhQTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=dI/fvh56; arc=fail smtp.client-ip=52.101.85.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jYT8VyymX+908on7omvV3o9lQJw4OFM50oZwLz4n3lm0v1dYfBP62UW2eAqoaM/xKdE+4EzV8sGNm23nR5XRPOSPKJ7z8zciaOrD9Sii91Ang2rHSvrogpGzkwvT2ePgDgWGH6M+MWlfQPzInq83+k4MJ1CHPedOp9AGeUJyF4O8VPwtROGZXfvUP5aGjKgNH+SEzmEOxkJt3Wfn3zac41CJTCt3erjwvPb2C2G8MifbH9rkVkjpkJQnghVOvJ1awvcmbGSh4Es65spSeYUhXjLzUl/uG3bPrfwvnEiMvvLLQbHDAHzeYu5rjT1njwFpPPpRof6oZgT2hyLaA175tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4EbhKCiWxuD5zYdGwwRvzVhNkdpoX6nvdzcVFONdsQ=;
 b=RWnxZ9FBs07GB1Accj8qfALC2/ILaWR4SrVUJSZYJ5UqnPd8f7o8SEuEOF4tMB30oEfvt22cmgmg+dlvhj6j8lGjnc1QQn5CmYvGKb0C0Sgna/jkJYHfG0TTACbdjd9lXro6Jv/vhxpx6NOX1JXmIiWBvQRIH7t4mROUA2QR6pKj3INHriJUR4Hln0GFynIfyOMYjNp6H2q1ABiD7SQKpdzFi2dDiJVr9O5CsR0rpA0nzgcnwBViqRfFm3cMTxa6V9tvL+/To1v9Fbks+qqe54aSWDwOYThswuT4cgn9PxxsKzhC05ZNXu07vrbyqtRocxMvd25c79DUhF3WtYtOdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u4EbhKCiWxuD5zYdGwwRvzVhNkdpoX6nvdzcVFONdsQ=;
 b=dI/fvh56euI78xySEH4flrkFR3VBjcYHqfEKseun8yxI2TcI7ZSSm6twLZWu6R9wN3Cak6FDqvE84SO/3B7k39l6/hivPXjtbIWJSRSAq+Q7Yf80nkbRR0942JSmL/M5aYEohDmC6DTlMEyttoag2qneXpj58TrAfxvpkgl9JEJ2oWRKQ51TuE7Lg/rus/Ii61h0pIhLZpPyqsif64nno+9Hy+hunN5Jh7XnH6VZNSPTEWxZS7n8fBN2vwODCGxUGC+AtzGjGK2F8hVLQCWXTHhu42sWvTjS1F+6Mo4x94xrQbI3DuWFerTFU3e33K1iDSFznqapusZo5aEGw0W3ZQ==
Received: from DS7PR11MB6102.namprd11.prod.outlook.com (2603:10b6:8:85::18) by
 SN7PR11MB6750.namprd11.prod.outlook.com (2603:10b6:806:266::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 14:07:49 +0000
Received: from DS7PR11MB6102.namprd11.prod.outlook.com
 ([fe80::5cb3:77bf:ac73:f559]) by DS7PR11MB6102.namprd11.prod.outlook.com
 ([fe80::5cb3:77bf:ac73:f559%4]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 14:07:48 +0000
From: <Divya.Koppera@microchip.com>
To: <Horatiu.Vultur@microchip.com>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Horatiu.Vultur@microchip.com>
Subject: RE: [PATCH net] net: phy: micrel: lan8814 fix reset of the QSGMII
 interface
Thread-Topic: [PATCH net] net: phy: micrel: lan8814 fix reset of the QSGMII
 interface
Thread-Index: AQHcTvzsV5ZWzyHBhkikJvRFurJrobTlryIA
Date: Thu, 6 Nov 2025 14:07:47 +0000
Message-ID:
 <DS7PR11MB61021B86D4A1146873712160E2C2A@DS7PR11MB6102.namprd11.prod.outlook.com>
References: <20251106090637.2030625-1-horatiu.vultur@microchip.com>
In-Reply-To: <20251106090637.2030625-1-horatiu.vultur@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR11MB6102:EE_|SN7PR11MB6750:EE_
x-ms-office365-filtering-correlation-id: 531fa8c2-044b-464e-3ccd-08de1d3ddd43
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?OlxWXHBKs1ZylGLncPmiOUTW6rMKuPvJCU85QLEvZCvvYy56BX3Oy5QDukOH?=
 =?us-ascii?Q?u4cFbWVXkgae4b2MNn2pI4lIeIfC+IyichOJSQz1rvKW7SPoaFxXvaJjKLkl?=
 =?us-ascii?Q?E0r3AwgLE/kzVZ/Td4G9j0s86OTZmd+xMVwcSnuKyywVtGA23hs9VDz0qRA4?=
 =?us-ascii?Q?MVHRSxpHaIFdGJZafNtUYa5kZQepj7XulPnstUeW1jVHf4YiDpskzJ1RbB2w?=
 =?us-ascii?Q?O3GuSUsTU6t4VZ83n3iK7rAgc2x+uCuQt5xMu1Q9jjNLoSFhuJ4sNyZ4x/uN?=
 =?us-ascii?Q?2bx2x8GA24dR13LFgGl6Ho9Tnhjbyl6MRKKN0PrQ+OKOLGqlYQNPkS8cy+yM?=
 =?us-ascii?Q?FB5BQ5zRFlyLd+NKhRs+JsEZ7WIQBLZHZv3R8TkZTtyUox6DmOd9eZ134oR6?=
 =?us-ascii?Q?zB7S/cAl40mkFwVrnmR1xiRQ3cLSTLV1SzKXo85Z7BofbaFaKiSryDiwoiMX?=
 =?us-ascii?Q?8d4sczzU7BqoL0D7dHawMWY3ir3D/bVdDmnJ6CJd4L4xP9tXVsXzOHcJPHNx?=
 =?us-ascii?Q?OZcqabRSHyvOqewhqrHS2oMPxtqVbgTrnMiCRXcdJWrnw0neMN0FInUfiwtL?=
 =?us-ascii?Q?F41OPlrDXscCYY9LibcjyV/81BN9N7XccWBDimmGC5AgQHJAFK+uJ0aqRpym?=
 =?us-ascii?Q?TFxGRtKZwbThuaugoC/H3QvkltgqMU36ZEUBOlR/HSEsw9yWgrEDcH8U24mw?=
 =?us-ascii?Q?+H5L9ZfqFzkBJKPeJu/MFuqksGpO7qjzW04cHCDDjXPgjtNJk9JmHL8SWSZc?=
 =?us-ascii?Q?6n6AyTNmmMXwMmpa7rDwRp8sH/ueFV2dDwG2TdESjcDs1Fzsc5BIKQjZnv4U?=
 =?us-ascii?Q?zpfoQPmKeCVe6J8+ywjqEDrZsk1bHRx6fJr3GUpiZKc3TIoyrC2UPhFx8bij?=
 =?us-ascii?Q?7lkFPrWJu666qeqdjg7gcguJAUsq4aN8WVd6hY3hkc45J+j5taOkPeW9oSkB?=
 =?us-ascii?Q?bFinsDS+taODLRwk+lIo425Uv4F2pPaYnk7BDS1e20PcgKlhVCGJDpKG49dI?=
 =?us-ascii?Q?p6XHNqDDvA1+bLxxzymEOAUsi0cLBZFrfCtPrNryzEBVeNcJFCkAfTT6UA1e?=
 =?us-ascii?Q?PBbLUtoT/2r/UDq/b9r2aQN52Ft/GLCX/szRKSdi3pWHkPD2bIw/4gaA3JF2?=
 =?us-ascii?Q?LBtKwZC7YCNXJ13V/gw2gWOCN98iUljrtFeiA2O2kRY2aiCu4SFiFW27h3eC?=
 =?us-ascii?Q?9Oljo2nUBO5swcaetBlY+saX1/W4E8B+pSEF97pKpfcbcp2zvvJg6ITRuqKb?=
 =?us-ascii?Q?dZp7aIQWZXKO7WkyASI8tz+9TrTWhiGdsBJ9z4hcr8ZeXhnVL8PF147jTN+Y?=
 =?us-ascii?Q?DxA4piiANcYpGuofe1lGmWsOmHnsk+d/AoO7Nyrv8O97Uv5nDNeCLcV3sqp8?=
 =?us-ascii?Q?nURlMxz5o3lJ+zOhQOFb+T+J92Q3rNfiqom+mD1crQHuy+IEJluG0ymuwS/8?=
 =?us-ascii?Q?R/L0rshGrjoRg9xpiyIwwkzBnMFKeqxtTCoahUY2oZke5/JDSSrm9EYzAFMp?=
 =?us-ascii?Q?SUYgOdg7q88rwZN7qyUVdUuyahZcvB9Qgoa0?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?t4Aaokz/HOPNYNLQmcCVkfOrARi7gHZLpkPhtMMqniBvEz2IeRGib5kraT/V?=
 =?us-ascii?Q?3yjYULFEJsALJ8S5CBMnYVn8gxDs19wxHTiFWtCB8HXFCx07NeNEHIEF9udf?=
 =?us-ascii?Q?e7Fwpi9dUchIWjbf1pws5W8b9kwCO10Fn9m0jistUNSfdp4c5AB7ALnIBHjN?=
 =?us-ascii?Q?5Vo7y71eDPnX/bwGoCPonhQJOIHO7KpQ/4n4qEDQWIfh7WyIU8LZBrrqQS+z?=
 =?us-ascii?Q?ceCEgRLgk2JsjS7j980Qd9oCBzFFJxhIxKJmAVEqE7Fv6PZOioi3QSzs6cGw?=
 =?us-ascii?Q?pJwCwMX4KvnrFcAzt0Xs3fFcqhyM2sBrvVXuC0VP2wF0+6DwdvS/+aCZ9uJ0?=
 =?us-ascii?Q?VkhWdGavL/ubj7V1P4JVt70grIRHXTTIWvO2UFjUgt/k/sYv9/hjPDez6d6e?=
 =?us-ascii?Q?NKHWEP3aOyxwsJIXHra659TqKLlgMn953zyXiD6QXeXV6ti4okdT5K0DktK8?=
 =?us-ascii?Q?SRbjLEcCj9tkleXGNoaOfL6umItlap5DRW3B+l7l15eqzFFQZJnpM/tOZmEj?=
 =?us-ascii?Q?OjZBMX5b7QqxdYsurfl9VPnGfukkOsn6+hl2ntfjC2rmxeIbQ5X+KDUUZOtw?=
 =?us-ascii?Q?fEYGQ8ixhN6n0yqruJKN1krqcODWNXaaclnAFa9ZF1x3bWH/38Og5564OcXs?=
 =?us-ascii?Q?edOW3B/KomjD7IJOK3RqYedhbKUML9EOEbPwS6/jZm1RzVP2a8dkVYg7dltv?=
 =?us-ascii?Q?6quidI7AANs3yhbbP6ysm+pVScXhgMiU/VexkLQ7KkLP099ePaEi2Di4hHkq?=
 =?us-ascii?Q?cWRvNMRi/nruOdGj+3/8qR14N+WnQN23N9ofgnFmNko4tzdYG04OR0f9HUxK?=
 =?us-ascii?Q?K44YE6qytiByE7/4NW5vrbJey/pf9Y0jwBYtPxfE/SjDkU4C4LvJkvjJPISn?=
 =?us-ascii?Q?EE1ZBkbcAtMoHht9NN0jzppLO5oEaKsF8nJ5pYfnQz9DLxgMzsXqq03wFaUs?=
 =?us-ascii?Q?CzL3sesKjbDLwNw8iQq/Uvh9HUwhv5oknlxDN2efyNA6QOD+Lbe0ZXJckfWZ?=
 =?us-ascii?Q?ygmQCiyu44GTN8yq8c/1R8DH5iUVi30PxjNuNisuieOh/OZmYdSzRaRWAZ9I?=
 =?us-ascii?Q?LWKf5z92kPZ2D4TD5btGTmTw5LSIkox7ncWY+mqGWBYSCt2iByCr8ijL0ODW?=
 =?us-ascii?Q?txG+lmWUXTOMrh0cZC0Ktbu1Ss1Aza4pOYKWtG997Lk+xbJVZKr08lHZFwYR?=
 =?us-ascii?Q?PNUjEc8eqp0XpwqyRRWj9S5Nn4gDl+AEiNPy5IauYkcLciUleL4whZHg+3Wy?=
 =?us-ascii?Q?XH/YGRB1tzMDjg1dh392aiHfXjqBDYLuuRUW6wtTvJFnXHqJXbkbRjyOaYu1?=
 =?us-ascii?Q?F4DgVtbHawHeSQMN/avD+Esb/JfdhwNZXdNWAm7ZJXBeGyyPpctvlwDfaySJ?=
 =?us-ascii?Q?ygjjivXFSID+Mdni357BNTITKfD7TqDbyB9cX20jCoczu1D8Q1rvkBBIBpnS?=
 =?us-ascii?Q?CPKPg++aUMRvb9tWHijEjHyrefUXcWEZaHNBNVfLIDwHj+syqX2IkrgHbXZC?=
 =?us-ascii?Q?I77LbpjH1lTuaWd6BIsdXBmX4O/SXctqBYmiUPkpFo4Y/02mdg0N/pZhx6yn?=
 =?us-ascii?Q?eHNQXryEU/KTYMr6XfpoGXfmCjv5p7s7ueR3rn4V?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 531fa8c2-044b-464e-3ccd-08de1d3ddd43
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2025 14:07:47.3979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CL5CVisTbRgaM4t5GIHwDncBftyhLEgFGIXXJgCfWSrvLdIKTuFhM4xu8cD5A4NcvIU76P6Pj+H9PKcjV1GdUBnE/RuEQAU6AEsl3lxAfl4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6750



> -----Original Message-----
> From: Horatiu Vultur <horatiu.vultur@microchip.com>
> Sent: Thursday, November 6, 2025 2:37 PM
> To: andrew@lunn.ch; hkallweit1@gmail.com; linux@armlinux.org.uk;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; Divya Koppera - I30481
> <Divya.Koppera@microchip.com>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Horatiu Vultur =
-
> M31836 <Horatiu.Vultur@microchip.com>
> Subject: [PATCH net] net: phy: micrel: lan8814 fix reset of the QSGMII
> interface
>=20
> The lan8814 is a quad-phy and it is using QSGMII towards the MAC.
> The problem is that everytime when one of the ports is configured then th=
e
> PCS is reseted for all the PHYs. Meaning that the other ports can loose t=
raffic
> until the link is establish again.
> To fix this, do the reset one time for the entire PHY package.
>=20
> Fixes: ece19502834d ("net: phy: micrel: 1588 support for LAN8814 phy")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  drivers/net/phy/micrel.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c index
> 6a1a424e3b30f..01c87c9b77020 100644
> --- a/drivers/net/phy/micrel.c
> +++ b/drivers/net/phy/micrel.c
> @@ -4380,12 +4380,6 @@ static int lan8814_config_init(struct phy_device
> *phydev)  {
>  	struct kszphy_priv *lan8814 =3D phydev->priv;
>=20
> -	/* Reset the PHY */
> -	lanphy_modify_page_reg(phydev, LAN8814_PAGE_COMMON_REGS,
> -			       LAN8814_QSGMII_SOFT_RESET,
> -			       LAN8814_QSGMII_SOFT_RESET_BIT,
> -			       LAN8814_QSGMII_SOFT_RESET_BIT);
> -
>  	/* Disable ANEG with QSGMII PCS Host side */
>  	lanphy_modify_page_reg(phydev, LAN8814_PAGE_PORT_REGS,
>  			       LAN8814_QSGMII_PCS1G_ANEG_CONFIG, @@ -
> 4471,6 +4465,12 @@ static int lan8814_probe(struct phy_device *phydev)
>  			      addr, sizeof(struct lan8814_shared_priv));
>=20
>  	if (phy_package_init_once(phydev)) {
> +		/* Reset the PHY */
> +		lanphy_modify_page_reg(phydev,
> LAN8814_PAGE_COMMON_REGS,
> +				       LAN8814_QSGMII_SOFT_RESET,
> +				       LAN8814_QSGMII_SOFT_RESET_BIT,
> +				       LAN8814_QSGMII_SOFT_RESET_BIT);
> +
>  		err =3D lan8814_release_coma_mode(phydev);
>  		if (err)
>  			return err;
> --
> 2.34.1
Reviewed-by: Divya Koppera <Divya.Koppera@microchip.com >


