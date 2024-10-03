Return-Path: <netdev+bounces-131554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF73C98ED52
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 12:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BDFB282187
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 10:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC0B14F9CF;
	Thu,  3 Oct 2024 10:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="c+kJZHot"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2044.outbound.protection.outlook.com [40.107.95.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A5C80BFF;
	Thu,  3 Oct 2024 10:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727952602; cv=fail; b=Njg72f5Z0XpqadFsw2HOMpEItgHgFgU18lDjN6UiKgi6uXfUMn9PYY88SG7eV/UqS/APk6BKxwcD6ZlqaBDx3sNQRJ+yo4aFI4nQKK3jQBeB3jxE4D96OMUFvG6Rovr5piNQO6FWJ+cuwQLOM6Wy3uhGG+5b2/1Ym4/1YGtuFnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727952602; c=relaxed/simple;
	bh=Yvdwo+duwyc47bmfGjY7Lq0zCAHMhCBtMpj63PoeGIM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rRWmOK/3beg3WC+qb6NM4xAWN5HS1cBdCABF9DPCtcDNS2nqIAU0BYf3V2LErhKaXDcpMgs6UOxaJ0QxWZvOykS394Sqk6GoEhuoJB6v7pbXwYWpeCn1R7PXaSwZ1vcK2980jMTx6wkWtyXbwGM3i7HjqCVO2Umtlew44wEK4K4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=c+kJZHot; arc=fail smtp.client-ip=40.107.95.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JUGoP4ufkPCrnnGs10PTruOl/mrokHJqHqZvZ/padIKycocKtsUrwCOi0ohfdvhXbEHH1izhKMZJVXNn9nhdRadbiNeCmxwhzxMlx5BBDWzg9G1fV9IhtyoS9zaq1lipDlMtyXQajQBnG54yzfOpillo2ebQbAm73MCW627m2T6WhDHCNk1ydELXPSnAN2SQrvVPFRx/R4Ffe9NAiUKxXzb3MIGxIYtzGnxxY9S9kv6XWGspc3q70VlbZ5h3UWeaY3vBnjrAdvCNhLON4vJQ4TRq3e5QhxhP5WrZLfqioqRlIdnIClM1oA9PRettpYqa8oRveTW8HrdvjD/E6TAJ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qhaAXeeUX3RDS6tAn2/5YemMmU6bw3XNDKVF+AfNig=;
 b=Nvy1ir3x29HO04yjqEzqBVqcuqjLRBNJ+1+bnWBpz4aVDzW5zozPbPVHnvrsLBXsE9/2ArUcfg/g+7UcUqocu+j16fHiqeOo1SU/I9FECiYqdBUl8EF/5p5fUyoDwkNWSmJy7imGBzZYPIGTnfw2bAxYgxs6fN8ISpCPylbTXKWvP0ww6cCR9cfyoT+Dqkrh5pxIVPxgMrS98MDV905EZhJYuOJPj0BWnLBC6gyoRhtqErIVRaKdo4Xy2Ca7IXQwEWi3BeQKOuIA+TXCR2OEiTBi7O/tWyXghg7Iq3fJhDnGMC8yInlt1q/DSFpvLrNd/xfFAJQN5NFkhj4De0c1PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qhaAXeeUX3RDS6tAn2/5YemMmU6bw3XNDKVF+AfNig=;
 b=c+kJZHotk6La2Lx4KNnImRm+1rTPHa1/qvk7JsBw/yhReOGRuXTyx8/A44mGIplVsuXGx1Rt1UqNeshDhLIP/3AnEIv5FKS+Ymo8mT1Aqh1XiKP884jIPJGR3hZDZddhVCeDGo7zx6a82T5sFbGI7wgnnusfsAY+9RWpYzb7v3PgvTcidpvdde/Lp4lfpBFM/YMvu4AKRcuraj2r3q5Ex7/5CSGu0rNFdnDsoBzf9t82yP5g+Rso6ZsOB7+w0jPNmbY2D7ALGksXz0f4pBvd2qrYpvu+fhkrJGsaxDz3bzi7dETosmHD9hgjXhWG3RON8xe6b67Aps/Nccv1+WXhbQ==
Received: from CO1PR11MB4771.namprd11.prod.outlook.com (2603:10b6:303:9f::9)
 by MW5PR11MB5884.namprd11.prod.outlook.com (2603:10b6:303:1a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Thu, 3 Oct
 2024 10:49:56 +0000
Received: from CO1PR11MB4771.namprd11.prod.outlook.com
 ([fe80::bfb9:8346:56a5:e708]) by CO1PR11MB4771.namprd11.prod.outlook.com
 ([fe80::bfb9:8346:56a5:e708%2]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 10:49:56 +0000
From: <Divya.Koppera@microchip.com>
To: <o.rempel@pengutronix.de>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <f.fainelli@gmail.com>
CC: <kernel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux@armlinux.org.uk>,
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH net-next v4 1/2] dt-bindings: net: ethernet-phy: Add
 timing-role role property for ethernet PHYs
Thread-Topic: [PATCH net-next v4 1/2] dt-bindings: net: ethernet-phy: Add
 timing-role role property for ethernet PHYs
Thread-Index: AQHbE9TyYWLsMIAgF0+sugT8VqPdlrJ027Ow
Date: Thu, 3 Oct 2024 10:49:56 +0000
Message-ID:
 <CO1PR11MB47715E80B4261E5BDF86153BE2712@CO1PR11MB4771.namprd11.prod.outlook.com>
References: <20241001073704.1389952-1-o.rempel@pengutronix.de>
 <20241001073704.1389952-2-o.rempel@pengutronix.de>
In-Reply-To: <20241001073704.1389952-2-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4771:EE_|MW5PR11MB5884:EE_
x-ms-office365-filtering-correlation-id: 19c7123f-1966-41a8-3a7c-08dce3991ea8
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Izsp7snF0eId1FJQxrX1Fhz2MaSN9u6xmTOpa07+S3cmwv3q4Mm/ZdprQoSn?=
 =?us-ascii?Q?JYxWlb8yn4Xftg3HBfAP6R5njBkamxzI7nMx8AsG8CySlbVsaCDR15gXJgKs?=
 =?us-ascii?Q?dLhxK+/lK8fVQZTB2JruJZ5yMo3J8zdensBFe1++QJi6i83GMzvqxW11mZP1?=
 =?us-ascii?Q?bN+Xs0kbltUxNmlZde6t0aDrtOgZXclPXCWBwSaQI8MF1wcqxQupqHK676tI?=
 =?us-ascii?Q?/v3QlYydvYi8A9CHTxB21SoGzUGc4PyUmHZYK4nbQ9sTd6UgRaTfqAkC+2uk?=
 =?us-ascii?Q?fB2Usip+BUMdvScomFRnksxBLCLEpBX/BEESVqHLhUBnvA4XpBxl+Ge/kSul?=
 =?us-ascii?Q?Pze421JxnxpkKfAmUsn+7wpoNbK/Cx6wd4N1lnDqnAdGH8hJidX+LQGW/dX0?=
 =?us-ascii?Q?aTi7BpWmLwsnhcmofGx02n7LZuMJKSCr/MdqkZjrJIv1E9ukbkfYNuxDV4Oe?=
 =?us-ascii?Q?3ai489xSpJcYKQW0IVdJ4vPwPyld59zojqH9jGJ3bGTDs+1Hk5GeR3ldDkuU?=
 =?us-ascii?Q?bcSIFRZy3dM85CBm2ir/pcUYoeYtwSgIAmhKFC9DJCE0ZHDkbRC95YE1G+Qr?=
 =?us-ascii?Q?bDavPpW6+QZxpTD68RrdFRhtyTXG4IlR3rFvXU4LkhdvAh+b6UugJjwhCE4D?=
 =?us-ascii?Q?r3NHuR6sTSZioDyuAhwRPaZVuni+/dj0oW0HA3NOsO6zLb1+V8ivceEvT5Oe?=
 =?us-ascii?Q?OlRWYcP7X+/tgamtArNw75jUzf50CbftZJrOu39eY5lB/sUtg99SdTTqIs13?=
 =?us-ascii?Q?/ryDdRaQBpAdnwyGtX0aYmaziU61wdpkg7V4+jPAULPyDmX6qR9TqdReDcRQ?=
 =?us-ascii?Q?RTNyh3H9Se3jwuEXzRtm7VPO83+oFh72J/BZ4c89rC9hqYJYVAcEu4+0Q48y?=
 =?us-ascii?Q?dynhbqba2nK64CfhpTaAo79MW3GRy+LJuG+FycBHdQsmK76NZ3hn+7/fD2p2?=
 =?us-ascii?Q?02OivEiJtPMC9LopqsydZHjAG+sgTuHJGwHA4V7B672KC+jShVaBpoQtMpQX?=
 =?us-ascii?Q?K+6Or5rV5lv/n3F4vQ3wvPak5nLDDP01+l+/Qo8rYcSckgy1rNH+gh1J7uRH?=
 =?us-ascii?Q?TNqUGB0p36gm9TXjEvyyXLMvwFmSZSS8UqPuJg9Dzv1sdRa0vs+CKwTxsGVn?=
 =?us-ascii?Q?ABhVh+YQ9jVCub+j8qkyCMo/mDOtccMdakGglOwGubMLfgDCXe524bf1EM5/?=
 =?us-ascii?Q?shGukoU2baRUvXflZ0Z7KUF5ukKt6nk3JDlyhHTapBFbgwt/79Ipiht5+bFg?=
 =?us-ascii?Q?FpaCistvUpB0fpdNdGV4q9qcl5Hn0N4pM6Pu0zoQdirfx64ClJVh9YwZ1Eod?=
 =?us-ascii?Q?8+U1JUlpFxxQ0/pzsPKfq1zBLfbrBDhr7mOPheQFOoXY15P66dJm4iyAfqOE?=
 =?us-ascii?Q?+cQUS/M=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?636SXHFYgyF1W4FvaA59oplWom7mJ8jo5EhekFafYW63hMO4VNMkxKupO+mh?=
 =?us-ascii?Q?PJ0VIBQq7zGBf9wVzFuj+qzXpvAWRvvSAtP792WLiQleIGWPdML9rZ9vECos?=
 =?us-ascii?Q?P4s5c0ABJVP8PLxBxMrwLBtzDZ/PERlErugPFx7sHwVOFt1q8l4f6NQFelYb?=
 =?us-ascii?Q?8WGTETjmAlwadI64PuLMDGajj15nDoAL+U0KdduRLn2BVTn6jJzt7r3XGDO4?=
 =?us-ascii?Q?cMAQ+D/SY2vQ4HGJ3xxPrjNXcBh2xWPuf1Tn/Oz4hQXSjjyulBOpFGNDcQ+V?=
 =?us-ascii?Q?lG6CUINkVsPPaXt9Zxh+ozPta2fwyEmG012WUs2w9qKNZBXKCHycYY1MfuIq?=
 =?us-ascii?Q?RBv8MSSjQyYGIvHZBROMbQ0v0HnZcZYVUKSyp9ZtXznJVD7+PiPMefjnpyZ/?=
 =?us-ascii?Q?QBuHUXYTss6zCPUn8lAVRSlP1p+NewvJrKZaKwmKdSbSTwKbxclBop/KCUEb?=
 =?us-ascii?Q?am1eEWswk6f0wmZ5x789PQVOZ96aI+/6lznDPye1liLsflAQUEUDZd09lu1t?=
 =?us-ascii?Q?1e2JqEXHeLdHmUXK+J7G6usm9zg19OrjacjN5H3jMHOQjsdPxQ6lw4ltciSR?=
 =?us-ascii?Q?uu7BHBMjvQFd6XWQWbxfipQJSJBM6h+ERHxPks6QVoLnea7E5swmfmwVhuHK?=
 =?us-ascii?Q?dSpxKYjrxL+yvfNZPBl9/6E4XlewBkEHdo6TL49oXrLbOSfpxL+O86xDbVxe?=
 =?us-ascii?Q?F7tyg/MFKoYT2fy63RzwK1VLfkJta1ivxqorCNrqAl6+EUSbx7pXPASr4x3l?=
 =?us-ascii?Q?BJ5/n/2sVvbrB0HbphafDmcPe8d+Gkn0N/CCwa/1+PuHxvcAfoHZxObiBVg7?=
 =?us-ascii?Q?L9jk0oe0eiqOqlaxsMpa0SSf3Z7jyemXUtwStB8SCJ9thOQG+XpZnVwLU8nh?=
 =?us-ascii?Q?6hv6dfjXIGmZvWorRPyKVgrEWqlnTC2Oh7mxqYQLk5kFyFGzycB74iwBfzZ9?=
 =?us-ascii?Q?b8T2yB9Ap8/HN7hiMghLMbnvQ5vcyV1Zi5hHoC/aA0GxKxAPByLch2bQr/Zw?=
 =?us-ascii?Q?zczU/jQEejY6xhaaQFqjTpSM4fRYqnRwlbuP5RcjQlVF0ch2RDSzspgqvzQ5?=
 =?us-ascii?Q?Dwazdq4xQzK4b/5LmT8gvfwoTfXNTiCUjtCbDRwWCJ5yyL0acTlP3mOQPgmJ?=
 =?us-ascii?Q?X25sZC4BNDhokSSOaH1QVh8pQMMdIIdqqSdSf1G7l2B5xQqQgstxcH+GDKUJ?=
 =?us-ascii?Q?+AS3c8/lmPfmbPkGNPjkGj5SBTqAJYmuWt44Rwarx4adOwaBFmHpUaHydvIy?=
 =?us-ascii?Q?ziI0BRvCmjgxKtuHoDHnih/8l4Isq8gVJmhGlsXqeOMzOzUrE0n1e6qUREPD?=
 =?us-ascii?Q?W1ulEqV02hqQXFW+sLeIAkS0zsg97tKXLyK0jPpPc5h78GsM1MzpSL3KIl5j?=
 =?us-ascii?Q?pJOtnOHPc3HyKy5x1sIzTKWz3ftqJgrh8z6x03BgXXh3xWCCrJAhXdBN5vy3?=
 =?us-ascii?Q?u9YuRDr9PUuoJ535GKMfy6ibNG9InS7zXT7MzWJGCLbRrsIXsopU8OfH7fKW?=
 =?us-ascii?Q?+Koii9Qenlzeg7PGMuk5ppUwnAtyu0cqeGFuhz+4wTUfdeXfzQdrdNY1xAXf?=
 =?us-ascii?Q?8DHhmKDKaik6dvNP+dD35Nb5FtDcqHQqGtUQFbPxoVgpJKA/1g1AZ+BnqE7a?=
 =?us-ascii?Q?9Q=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c7123f-1966-41a8-3a7c-08dce3991ea8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2024 10:49:56.3240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BjgPhtuI1Cd253Qbby9pWfy9bWDc3N7ArZuUmp/q4BJTM67upfLZHQsTVCDfdnMzhAhLkx0c9Zp8l9SV5tNaHGk7dH1iim5qxwbHcbNEhFs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5884



> -----Original Message-----
> From: Oleksij Rempel <o.rempel@pengutronix.de>
> Sent: Tuesday, October 1, 2024 1:07 PM
> To: Andrew Lunn <andrew@lunn.ch>; Heiner Kallweit
> <hkallweit1@gmail.com>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Rob Herring <robh@kernel.org>; Krzysztof
> Kozlowski <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>;
> Florian Fainelli <f.fainelli@gmail.com>
> Cc: Oleksij Rempel <o.rempel@pengutronix.de>; kernel@pengutronix.de;
> linux-kernel@vger.kernel.org; netdev@vger.kernel.org; Russell King
> <linux@armlinux.org.uk>; devicetree@vger.kernel.org
> Subject: [PATCH net-next v4 1/2] dt-bindings: net: ethernet-phy: Add timi=
ng-
> role role property for ethernet PHYs
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> This patch introduces a new `timing-role` property in the device tree bin=
dings
> for configuring the master/slave role of PHYs. This is essential for scen=
arios
> where hardware strap pins are unavailable or incorrectly configured.
>=20
> The `timing-role` property supports the following values:
> - `force-master`: Forces the PHY to operate as a master (clock source).
> - `force-slave`: Forces the PHY to operate as a slave (clock receiver).
> - `prefer-master`: Prefers the PHY to be master but allows negotiation.
> - `prefer-slave`: Prefers the PHY to be slave but allows negotiation.
>=20
> The terms "master" and "slave" are retained in this context to align with=
 the
> IEEE 802.3 standards, where they are used to describe the roles of PHY
> devices in managing clock signals for data transmission. In particular, t=
he
> terms are used in specifications for 1000Base-T and MultiGBASE-T PHYs,
> among others. Although there is an effort to adopt more inclusive
> terminology, replacing these terms could create discrepancies between the
> Linux kernel and the established standards, documentation, and existing
> hardware interfaces.
>=20
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> ---
> changes v4:
> - add "Reviewed-by: Rob Herring (Arm) <robh@kernel.org>"
> changes v3:
> - rename "master-slave" to "timing-role"
> changes v2:
> - use string property instead of multiple flags
> ---
>  .../devicetree/bindings/net/ethernet-phy.yaml | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> index d9b62741a2259..da9eaa811d70f 100644
> --- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> +++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> @@ -158,6 +158,27 @@ properties:
>        Mark the corresponding energy efficient ethernet mode as
>        broken and request the ethernet to stop advertising it.
>=20
> +  timing-role:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum:
> +      - force-master
> +      - force-slave
> +      - prefer-master
> +      - prefer-slave
> +    description: |
> +      Specifies the timing role of the PHY in the network link. This pro=
perty is
> +      required for setups where the role must be explicitly assigned via=
 the
> +      device tree due to limitations in hardware strapping or incorrect =
strap
> +      configurations.
> +      It is applicable to Single Pair Ethernet (1000/100/10Base-T1) and =
other
> +      PHY types, including 1000Base-T, where it controls whether the PHY
> should
> +      be a master (clock source) or a slave (clock receiver).
> +
> +      - 'force-master': The PHY is forced to operate as a master.
> +      - 'force-slave': The PHY is forced to operate as a slave.
> +      - 'prefer-master': Prefer the PHY to be master but allow negotiati=
on.
> +      - 'prefer-slave': Prefer the PHY to be slave but allow negotiation=
.
> +

I would suggest to use "preferred" instead of "prefer" to be in sync with e=
xisting phy library macros.

>    pses:
>      $ref: /schemas/types.yaml#/definitions/phandle-array
>      maxItems: 1
> --
> 2.39.5
>=20

Reviewed-by: Divya Koppera <divya.koppera@microchip.com>


