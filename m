Return-Path: <netdev+bounces-188765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD20FAAE90E
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 20:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1768467746
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 18:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475B31E1C1A;
	Wed,  7 May 2025 18:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=palmerwirelessmedtechcom.onmicrosoft.com header.i=@palmerwirelessmedtechcom.onmicrosoft.com header.b="XknC6fsz"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2123.outbound.protection.outlook.com [40.107.96.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0477D153BD9
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 18:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746642568; cv=fail; b=PD4rVub5wIu/xacb5kra1k7nN2XCNw5bsigdHkm2DST3KocK/Nu1uPQM5gVl66FIjKmynv66SffH8W4hShzvQMutAIwdI4jynRpKMdQq7Xo1coBxaTFSRxmjKQfa8BTr7cty+e4R8obTavEV/Y2roAo4J8B0bd/Dgtn+Beb0IBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746642568; c=relaxed/simple;
	bh=P7SEtHHLIRo7nCMEK5ldrpksmtVHHjK6u36h4REQZt4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tyFNWg9vID5fV0geGbciKwi/JR6Ltz31BWWhC8eZNeYYg2NAHXsC2M44z+Vcp9x/L6pNh1jwwUZB8+Zpbev9X/jXG12qHQ3Duusg9apARnXPTFZ2H3DTYFNtdxIwsEEelT6DNvxvV3ywbPQY6Xcxlsc/sx21UnduLF+wsLd6dvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=palmerwirelessmedtech.com; spf=pass smtp.mailfrom=palmerwirelessmedtech.com; dkim=pass (1024-bit key) header.d=palmerwirelessmedtechcom.onmicrosoft.com header.i=@palmerwirelessmedtechcom.onmicrosoft.com header.b=XknC6fsz; arc=fail smtp.client-ip=40.107.96.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=palmerwirelessmedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=palmerwirelessmedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a17n2tvLFFjTaiiFbdcGqXHc7ikyo5UNKGbcOUMtcb69FyBeZh6ftJYWmyRJxcRPhXkg3W0jxvSYW1KEHIIkyugVA4RHj3nKN96zb3LJxUE0GQQl+kruBxOx5va0cB5fvScbgSWfVOERtf7Oao1Mua8qJNU7fPD/Kkhj9AE02jreQUaOqEJSUN0oN7xD43l6I2jG5jIoOkZMzt/NRi8Ld22AJSe1pSO9/Yg+xF/j+BTfOzX1+2wZIFejgqGL4ZXUKQkJBGLWuVxdvUYgMD6+mLioIwlR4aiCn/nf2Ao1VjOI8LkJZGFuhGrgwq5rYmLt88CP6V6mXW3SrvyED/jDAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xUBuaLjpbf8YLsH0qmgPzhn5GoyOoorNBafxAaN07tk=;
 b=b/hzCiUl1FX/HbMbPRS8IoNI+MvbmqjUMAZ/+s2JmH7isoppGu/OMwTcqg6laeJkNRJjUacIzkfn1QiGTPQYq43/kP9Sv2BDYG6oxKVsZtUIohSsaV7SbHji0bCgv+Brs92NkKGdseuE+JBI/Bw2xIxZsIHZ7USJJmyfXLz3SoczXvhJLhVGjfdW0oFulQGgAfChfLVzkh/WuJwiVvBcYuOGLNbK0bSbWJcfuAD0vUwDHNFh1MlNDGTCeLBZF6X/7x9aOSWv/EwQonG3GXv/VRt35hwxJ8hTh+QOQHjqOHvyCLeO/oCBWHA8bpN1T1qSzS0dD+Qnp5ht6rVIQnYYoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=palmerwirelessmedtech.com; dmarc=pass action=none
 header.from=palmerwirelessmedtech.com; dkim=pass
 header.d=palmerwirelessmedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=palmerwirelessmedtechcom.onmicrosoft.com;
 s=selector2-palmerwirelessmedtechcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUBuaLjpbf8YLsH0qmgPzhn5GoyOoorNBafxAaN07tk=;
 b=XknC6fsz5SjOomfz+lMOi6vbEgjzttKhdp1wOdoArP4Amylm8bLVFS6j3BIlGYXav1Rydq/2ZL09e5/afszatqWmOfTjht9in7TPx0EIDGcZvXa1n+5WeeJ8+dL2Kj4t2JtqwmE4OEaLnvH4pND0jyuyajLbMYWWUZ60y+iZGY8=
Received: from IA1PR15MB6008.namprd15.prod.outlook.com (2603:10b6:208:456::5)
 by BY1PR15MB6103.namprd15.prod.outlook.com (2603:10b6:a03:528::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Wed, 7 May
 2025 18:29:18 +0000
Received: from IA1PR15MB6008.namprd15.prod.outlook.com
 ([fe80::a280:9c40:1079:167e]) by IA1PR15MB6008.namprd15.prod.outlook.com
 ([fe80::a280:9c40:1079:167e%3]) with mapi id 15.20.8699.034; Wed, 7 May 2025
 18:29:18 +0000
From: Steve Broshar <steve@palmerwirelessmedtech.com>
To: Andrew Lunn <andrew@lunn.ch>, Edward J Palmer
	<ed@palmerwirelessmedtech.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: request for help using mv88e6xxx switch driver
Thread-Topic: request for help using mv88e6xxx switch driver
Thread-Index: AQHbv2Bc+TYavxBZNEG3KPwJ+KHfDbPHRtgAgAAyN4A=
Date: Wed, 7 May 2025 18:29:18 +0000
Message-ID:
 <IA1PR15MB60080519243E5CCD694FCBD4B588A@IA1PR15MB6008.namprd15.prod.outlook.com>
References: <20250507065116.353114-1-quic_wasimn@quicinc.com>
 <d87d203c-cd81-43c6-8731-00ff564bbf2f@lunn.ch>
 <IA1PR15MB6008DCCD2E42E0B17ACBC974B588A@IA1PR15MB6008.namprd15.prod.outlook.com>
 <0629bce6-f5eb-4c07-bff0-76003b383568@lunn.ch>
In-Reply-To: <0629bce6-f5eb-4c07-bff0-76003b383568@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=palmerwirelessmedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR15MB6008:EE_|BY1PR15MB6103:EE_
x-ms-office365-filtering-correlation-id: 6df0aa54-11e6-4f6e-0d14-08dd8d95140c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?uok4+kHy4Oe42TCJmkfLCNR9gQmTFNJMTM1gXdSbS5eRPuNI+lGnVgVC5MDC?=
 =?us-ascii?Q?gBml3tEMw3ksptlMQckmFoA5mDw7qdBELKyGGUlFCXa3bFAsKlF7077V6R5Y?=
 =?us-ascii?Q?1pjO9PTTPRsdgQOXlOVEMH2jgctn9gD6x2rSp4NT39bf7lNQeIIwp0OQvcbG?=
 =?us-ascii?Q?ZZbTx+kY47FX7g39Bq+trPnS4GnApsNa3+yi4ubrNJNRFnpFtnROKDDesS6Y?=
 =?us-ascii?Q?5HBuWutKrLlvmuaNfiC26tvYBNbKJcztnGa+mKnXO2rhhugqF/gu3rpy4rI0?=
 =?us-ascii?Q?06MXnuXDPZx3rFT0VTAw9p0xLhfEa+p2bidnHex+Vv9eumvzrXR80R+b56QB?=
 =?us-ascii?Q?apNLX8aGyc1hrd5+ZQckS5fieB3YqoOVJB19kb8vjQQZRgQFl4/xjuXpoRp2?=
 =?us-ascii?Q?mTiwjZ873imq0xepm10AxBu03Ws5nyqIrxQu2gZXXstp9sbLLGDfrdnD74ZB?=
 =?us-ascii?Q?q4VQbqPhqv71zgv5BrK7XP1dtvA1DRgscBZ6VMV138d1EXQrbb3s1MO4cpHE?=
 =?us-ascii?Q?IwsohLsWCHPedN9EGiOZ6NHJaAy4IODUpeCdhPbMPbRBkY9A/LgCKDi5g3OP?=
 =?us-ascii?Q?PhMLOKZttAiF06gWZR0A13ePPsemNWiE86KOpF29wLTqMIpLs00bKjXwyO+L?=
 =?us-ascii?Q?AXIDRI7AC41js4k24x49pBuxQMDTwAesNkQwyTP2iVf3flfxgzaWJ8hwSr4d?=
 =?us-ascii?Q?O11xSle3aaOo8JeBBUtmUDCJLWz9VAJ7jgiXz0HY3jJaLiIIowVpAndSAXK+?=
 =?us-ascii?Q?OVv1Ku9iofoszKr8iYRk/qv7ihvVm7WvmBhQwYbJk0fOURNERXr9e2ZCnkw6?=
 =?us-ascii?Q?HYFNUMj0ri75qQZdthOpcnmi6V/ToyQoLfbWYvu+Gq7NUPOXOrFLAi++7zYC?=
 =?us-ascii?Q?CtCDMXV/Hs4bm4T6uOww2/b7POxS7bPZyXuG3OSQD8MpvhQVVgLg1BdLnyaX?=
 =?us-ascii?Q?O0it4JN8OKTvmiCYwz2RMi0slL2QeSMalgHGwMuhvDDmIrx6IdAHM48Uv8dU?=
 =?us-ascii?Q?HVn/JDstfzrBZrwHEkIehdmDek8bieAkpMXMqtKzD4s0CYnRSyxXus4XG71U?=
 =?us-ascii?Q?VVpAgGbYaOdMTJjHnaxvy5DSejNkQ7JJzbBYyDOycHt2Py1Owd9C/QHKpHUo?=
 =?us-ascii?Q?kmXS1iidmWOsXHtQYQKkDCOnuPTdsU0oIPYM33pk7u4Xi9soGw1kOOOl6S6d?=
 =?us-ascii?Q?I2xNikLPa7ljRk/ot6fhyZkxQIMBmUv/S0UQBNRyz67+E5pbAZrtw4+0jDC/?=
 =?us-ascii?Q?Z5iMZYsdzxuBG9RmXRjT12EpIdvoxXxQVd0v1/cuUmCJl1Oge47HwFF711Us?=
 =?us-ascii?Q?XIBOzmhAT6t/fPcuaF9WkgTP2aoVtXqrwNX289wWcLXhjIuQ1YeTJAYcpyZK?=
 =?us-ascii?Q?GMaFobLb3Xo25Yd1/TB2UwoX59CY0Op8YjibFdRWOWk4IEyTMnDmnDgHtfhD?=
 =?us-ascii?Q?OO/s+oQB09oSfLDW3NSjYDRRzb/i7OIYRZgCDvU4HzfAtIZJ7vF8FQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR15MB6008.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kEWEz+zXZk1CuJl9qShEa2i5n8bQ5Rhpju8qzATWVOn11f9TUEPDGiS6QK5C?=
 =?us-ascii?Q?P0qXTfxhC6Wvw1y8uLt3d5u7egKFEn5+6WMlhApd7URdQxrbRTIMpPZ5p8A3?=
 =?us-ascii?Q?hMZl9MwXlrhTSpr1w1AwhdZDVuvATvKlF5MXFIs/Lx1VcktX/zlDU0Az2w6Y?=
 =?us-ascii?Q?EstFWjzSoAJ2XgG302IycddliJ07IQRRphjjjeRP2slY//pn9BpIvNou2gCh?=
 =?us-ascii?Q?7F9jl7EdvtD2Pltt06pyxqWqADN6nzQjGE8g2Vt4ckmKEvGklWl+De42Yz7V?=
 =?us-ascii?Q?57EgyeuuPeR8Ou3Y9CCS/jhF+uAfdJ9QbPGMe/thUlG/2pZQK/FFsBMII0aK?=
 =?us-ascii?Q?UwS7PdXbRbLk3EvCFxxx+t/9y55k3HsiKhypGnb1CKIrYfXCr0CKh1pK2Fto?=
 =?us-ascii?Q?Dt2cmVhOySRp/cI5x8wAiqBA0WUUMsQ0oKOYSWxSJ+azU4g6wyYnetdujJgT?=
 =?us-ascii?Q?148cOJm7fYDU3xX+g7ksC8eF+0KezaTGbxMRIah6H8xgZrLQcyerAq/Wy4EI?=
 =?us-ascii?Q?nXKHzDS7Bz0je5oXhI3a8DcfWAU+t9By1Z8bA27MMFYAXzSGAsqnGiF6rhKQ?=
 =?us-ascii?Q?JWJq/ie3w1H/8jDCO5Cs+lBCTvIYypaPPdNA0F87A0C9MVmUCkh/bQDkTHwG?=
 =?us-ascii?Q?EO6aDSGzZmx+uvlJUkdn2nSyHUXeP7o6JSkOtxNV9pbpyzYBccgtcFVmyEwx?=
 =?us-ascii?Q?nmOCncrfjq3/h+wBibNr6cPRd8qPbee5//ufGdUGwEzD/17F2hEyfiR0sffH?=
 =?us-ascii?Q?8sbL4vVWSDFzMjlhP11wbi78mYCML8mhh7VjxakAjd/z8ajOR7VCvCY/ueqb?=
 =?us-ascii?Q?6qSrqmJ0ACihiH01aCEXZxuuEA7AuFjXmZlmpTKSNVR8CycRn3uBqhhcUgHj?=
 =?us-ascii?Q?v6wVmTdIZvbebphhdLD6ANtwayN17UwDH/aoSQL8DsIN+Hdxr0iIJQll9Ejz?=
 =?us-ascii?Q?9wzSI63sGlVf2yQWmMvyBAXum8CEklO6B4Hbm8jUSuxi8rBTsO4So93Xx5B7?=
 =?us-ascii?Q?JBbecxq6Nw5wbHQeWjlgc9M6X8oRYS00t9Eyk0O1FB/esknglofHShOjt6Oj?=
 =?us-ascii?Q?aSug24n0I07WGgUUUfBR+EN3JuXobp3JMLkGjJ9+3j8V+Q+c5ArSWivOBgX8?=
 =?us-ascii?Q?2yYhWmX3MMJehk2wAcuqNgK0ZI1QxAvSDeeBBO61i3ZZnmJPumJaa7hroxuh?=
 =?us-ascii?Q?tUDsRGNTS3yjm+mPk86RRAGLlvXGFKWrXz/Kb5OAzbzcWrlgzqG/8RjfrdZ2?=
 =?us-ascii?Q?et4m9mUTpSsoNglN+i45JXfBf18E8wYtbbnRmmeKYTL9sLsPiwCpVEGLl4DO?=
 =?us-ascii?Q?5ezV3PxI85J0TIJep0uQSDYrDhSBpH/ghDdViUDV3eR8vlgHwTrNWbyftEbt?=
 =?us-ascii?Q?LQ4KH5EoAQKTrvsnZUET59yotJEtdmSSVV4doaOLP07AtPAPw3A7MXRKbPZ4?=
 =?us-ascii?Q?x6Gj+tRyD5dYuW4flTRcUQp6f3l4q6eDbZzgvvBWQAf6RetjYUBywX8Jxgvz?=
 =?us-ascii?Q?YWdFo2HguVkkVDFDb4L+OuCuKQpqeEJjt7yYYTCrNVXZKlu983Kut/Dpkvqt?=
 =?us-ascii?Q?kFv8MbFA+EmQepY4ldtw7KtUlScuB3KpoVLgYGwo7jBmlRIobD72doiJsnnE?=
 =?us-ascii?Q?cw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: palmerwirelessmedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR15MB6008.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df0aa54-11e6-4f6e-0d14-08dd8d95140c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2025 18:29:18.2296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 18187d5c-662c-4549-a9f0-3065d494b8dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q6H0azOW7ux2YbaYAHptIsrHz3v/ItzY5JrXoKmSOgHArOmvpfp3hPq+Cz0xk858C7wAzW/alPRPVccPICe+rs/sKH7gkl9jTPHm+gBdiik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR15MB6103

+Ed (hardware expert)

Ed, Do we have a direct MAC to MAC connection between the FEC and the Switc=
h?

Following is the DT configuration which has a fixed-length node in the host=
 port node. TBO some of these settings have been verified, but many are mys=
terious.

&fec1 {
	// [what is this? Does this tell the driver how to use the pins of pinctrl=
_fec1?]
	pinctrl-names =3D "default";

	// ethernet pins
	pinctrl-0 =3D <&pinctrl_fec1>;
=09
	// internal delay (id) required (in switch/phy not SOC MAC) [huh?]
	phy-mode =3D "rgmii-id";
	// tried for for Compton, but didn't help with ethernet setup
	//phy-mode =3D "rgmii";
=09
	// link to "phy" <=3D> cpu attached port of switch [huh?]
	// [is this needed? port 5 is linked to fec1. is this link also needed?]
	phy-handle =3D <&swp5>;

	// try this here; probably not needed as is covered with reset-gpios for s=
witch;
	// Seems like the wrong approach since get this msg at startup:
	// "Remove /soc@0/bus@30800000/ethernet@30be0000:phy-reset-gpios"
	//phy-reset-gpios =3D <&gpio2 10 GPIO_ACTIVE_LOW>;
=09
	// enable Wake-on-LAN (WoL); aka/via magic packets
	fsl,magic-packet;
=09
	// node enable
	status =3D "okay";
=09
	// MDIO (aka SMI) bus
	mdio1: mdio {
		#address-cells =3D <1>;
		#size-cells =3D <0>;

		// Marvell switch -- on Compton's base board
		// node doc: Documentation/devicetree/bindings/net/dsa/marvell.txt
		switch0: switch@0 {
			// used to find ID register, 6320 uses same position as 6085 [huh?]
			compatible =3D "marvell,mv88e6085";

			#address-cells =3D <1>;
			#size-cells =3D <0>;

			// device address (0..31);
			// any value addresses the device on the base board since it's configure=
d for single-chip mode;
			// and that is achieved by not connecting the ADDR[4:0] lines;
			// even though any value should work at the hardware level, the driver s=
eems to want value 0 for single chip mode
			reg =3D <0>;

			// reset line: GPIO2_IO10
			reset-gpios =3D <&gpio2 10 GPIO_ACTIVE_LOW>;

			// don't specify member since no cluster [huh?]
			// from dsa.yaml: "A switch not part of [a] cluster (single device hangi=
ng off a CPU port) must not specify this property"
			// dsa,member =3D <0 0>;

			// note: only list the ports that are physically connected; to be used
			// note: # for "port@#" and "reg=3D<#>" must match the physical port #
			// node doc: Documentation/devicetree/bindings/net/dsa/dsa.yaml
			// node doc: Documentation/devicetree/bindings/net/dsa/dsa-port.yaml
			ports {
				#address-cells =3D <1>;
				#size-cells =3D <0>;

				// primary external port (PHY)
				port@3 {
					reg =3D <3>;
					label =3D "lan3";
				};

				// secondary external port (PHY)
				port@4 {
					reg =3D <4>;
					label =3D "lan4";
				};

				// connection to the SoC
				// note: must be in RGMII mode (which requires pins [what pins?] to be =
high on switch reset)
				swp5: port@5 {
					reg =3D <5>;
				=09
					// driver uses label=3D"cpu" to identify the internal/SoC connection;
					// note: this label isn't visible in userland;
					// note: ifconfig reports a connection "eth0" which is the overall net=
work connection; not this port per se
					label =3D "cpu";
				=09
					// link back to parent ethernet driver [why?]
					ethernet =3D <&fec1>;
				=09
					// media interface mode;
					// internal delay (id) is specified [why?]
					// Note: early driver versions didn't set [support?] id
					phy-mode =3D "rgmii-id";
					// tried for for Compton, but didn't help with ethernet setup
					//phy-mode =3D "rgmii";

					// tried this; no "link is up" msg but otherwise the same result
					// managed =3D "in-band-status";
				=09
					// ensure a fixed link to the switch [huh?]
					fixed-link {
						speed =3D <1000>; // 1Gbps
						full-duplex;
					};
				};
			};
		};
	};
};

-----Original Message-----
From: Andrew Lunn <andrew@lunn.ch>=20
Sent: Wednesday, May 7, 2025 10:15 AM
To: Steve Broshar <steve@palmerwirelessmedtech.com>
Cc: netdev@vger.kernel.org
Subject: Re: request for help using mv88e6xxx switch driver

On Wed, May 07, 2025 at 02:57:32PM +0000, Steve Broshar wrote:
> Hi,
>=20
> We are struggling to get ethernet working on our newly designed, custom d=
evice with a imx8mn processor and a mv88e6230 switch ... using the mv88e6xx=
x driver. We have worked on it for weeks, but networking is not functional.=
 I don't know where to find community support or maybe this is the communit=
y. I'm used to more modern things like websites; not email lists.
>=20
> So that you understand the context at least a little: we have MDIO comms =
working, but the network interface won't come up. I get encouraging message=
s like:
>=20
> 	[    6.794063] mv88e6085 30be0000.ethernet-1:00: Link is Up - 1Gbps/Full=
 - flow control off
> 	[    6.841921] mv88e6085 30be0000.ethernet-1:00 lan3 (uninitialized): PH=
Y [mv88e6xxx-0:03] driver [Generic PHY] (irq=3DPOLL)
>=20
> But near the end of boot I get messages:
>=20
> 	[   11.889607] net eth0: phy NOT found
> 	[   11.889617] fec 30be0000.ethernet eth0: A Unable to connect to phy
> 	[   11.892275] mv88e6085 30be0000.ethernet-1:00 lan4: failed to open mas=
ter eth0

Do you have a direct MAC to MAC connection between the FEC and the Switch? =
If so, you need fixed-link. Look at imx7d-zii-rpu2.dts for an example.

	Andrew

