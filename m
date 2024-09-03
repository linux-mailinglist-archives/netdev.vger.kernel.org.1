Return-Path: <netdev+bounces-124348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A3296915D
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 04:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4EA9281AD2
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 02:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE881A3050;
	Tue,  3 Sep 2024 02:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="V0DxRINF"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010016.outbound.protection.outlook.com [52.101.69.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCB02AEFB;
	Tue,  3 Sep 2024 02:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725329829; cv=fail; b=Llj1C1NPCvq7ICNeJ5xNjtGPGGV0w4xy4D9kAokZv0okFqNmyZbNR5lAmpsjVgL+ejhsqKc3QWgSMhVvB1q+XZpV23SwvkX4m2ULLovgroDtBsijCmxGAALSmE3sT1VNsSuyVidjFtaHNywWXgErYVKUBLrwDumBVRI49ekKHZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725329829; c=relaxed/simple;
	bh=JoqomAEXBPK/wgcqDwZ9VtoQB9cnSOBFjm9Kn9umk6M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VwkURIs6aZ6DUddTiHdtSTIcqWSWNqRvUn2oPVfsKpLU3lpbeHQ6OPJ/ouwTncW00VJ5YTX838tlI7Df+yTrFqJ9qHWAu9nwxM9FUMvnpkG+B7upB+JEAACOM9JpTHObCytb26jaMcSzYUwS+R1gKx0l09HHLaT2DG+0ZY7Cxm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=V0DxRINF; arc=fail smtp.client-ip=52.101.69.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ms2Z1P9z5CIzVHMs73URsqMRJ0gcGdtBHJOpdIXjWJLlZGJbSw454LIVmImjkmcBhY0IndnX0xopyooigg2aUJiHqxEuzn7jHuOk6+EKXzezPmb5IU0E6CwrXzX6B74htOujjWNMSMYmqIUGoXYpnsUhweL90dk2YokO2omqfplzALKRScGxviR7hXo7bJpyMymIhIX8E7fr/AxaMPs/dAK4di6KWOTfn+ZBpVUGYo4Yzo1dwEK/+o7RljB9jzJSj9rshwyxMRX0au3sgbkjpBU/PnhYtixcyDlpBrKu1HpeX1zNEPj1DW1IsOnxOrgs5ssjTPnVtzbZbw9WYB1uhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3577EClysHg76L4LpzXs7nLK/leK8UhOsFnD1edc778=;
 b=SEJHPX9Kuw/0S8TNKzC3rkTjddr1HeNwP+QsFySGXeLhJEYXsdQZTP7DSD9MY3B7tetKu6GnPIFg3mClTOk8JPsRKJM5QJkmNLXek7l4UFakIktThoE7rqSWcYm2ruRmLFL5Uf4C6/4KshulpMCW65tJsOypIxRHmmdS4OGA4ZY1Eva5sWj6wSxiqVp6HlZSKTRNtk9XCzSgp3j6WwlNaAvvnmxbJdLoyD6dXWHmuJdDdsET9PxDbdICo6bCQfEj0lwe7N4nYccvnBYGXTfTiA5upEEDOYvZJlh8aH71sCYhLgpJiQ9favLSMFgAAN9ktb6QCf/hHdaFEH+0z43Jkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3577EClysHg76L4LpzXs7nLK/leK8UhOsFnD1edc778=;
 b=V0DxRINFGhu8wMPSLk6P4Pal3Csuqu42K4OiDsXgdsgL6Gbjkm68R6gP55KNJ1mVENo/kMmeLmXX+kBIIP4uWejHmk7KbkwaNKUEMy+6C3PIVCZrs/bdrNaYvk58KAZIwgSi53OdTIFL8F3d20rdUV0Va8LBBBk+U9rE9wWWKmPov00e8saiOrWrSjfx2AgASZP0NdCkm0yxGEAxmke1hW/CVoq4mfg4FJkVEhfA1rAsYCTqFyrMWHZfMsLLdIHMcdZLsw/5FhMCcsfvtpPTG7tj7n7vOZ37z+f+LznnPVaS6SCTs91bkmzfI4k+09msTGd2NvJ1utbHBJVnZOZMkA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM8PR04MB7346.eurprd04.prod.outlook.com (2603:10a6:20b:1d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Tue, 3 Sep
 2024 02:17:04 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 02:17:04 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "davem@davemloft.net" <davem@davemloft.net>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH net] dt-bindings: net: tja11xx: fix the broken binding
Thread-Topic: [PATCH net] dt-bindings: net: tja11xx: fix the broken binding
Thread-Index: AQHa/QQeMkPALeROtkyb2f+TdmVf0rJErgKAgACb3sA=
Date: Tue, 3 Sep 2024 02:17:04 +0000
Message-ID:
 <PAXPR04MB85100D0AEC1F73214B2087CB88932@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20240902063352.400251-1-wei.fang@nxp.com>
 <8bd356c9-1cf4-4e79-81ba-582c270982e8@lunn.ch>
In-Reply-To: <8bd356c9-1cf4-4e79-81ba-582c270982e8@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM8PR04MB7346:EE_
x-ms-office365-filtering-correlation-id: a1735bd8-1d12-42cd-9e77-08dccbbe80fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?bieqeO9KejkHRGZJtjDOI2jw/Fj/B61TqLuogFw7/AgO8+cahTOEuZSIc2sk?=
 =?us-ascii?Q?Tod6fVmUOsQB8UAjwU75pQ+Y8RzDvUxQUZ50Vsxua71RchTcN7ilZefSgUib?=
 =?us-ascii?Q?f+bIr+dWRaGeY1E1kvn1NYT1OT3LITx0SvpOQtAu+oyZRMoffMHsPiAHuqYo?=
 =?us-ascii?Q?QoevJ0gCU19RuM3c79NBquLA9veXsERqAPTA6dnT3udbStxZlVoyyfiT7EvS?=
 =?us-ascii?Q?ZhsIZ6lSy6bNCcoelPP1jreswjbjQJKb9TOANQupI/xrTteECOTeN7zr7cIE?=
 =?us-ascii?Q?SOH6HjI0KAYqYRaey2dyPGmP88e2tXzlkk5cgzVKj2iYLaBZoZ4p5BjkH7IS?=
 =?us-ascii?Q?MaO7qjMhbDCHxuMMUaT8xtw6v+gIEOqUNSHStPpuTsRhhxODjON22FT2wPUu?=
 =?us-ascii?Q?X2CJRWaTVXpe5fJsFd8D+1LmgAeUDyiSID+oGBsLmhvKYT4NCUtuSQpElKjz?=
 =?us-ascii?Q?bhkXMFauOiv+/TNrMoFUiJjex7NdIzq2J7Qv3dIn1Ivsa6RC3icjLSlxigPk?=
 =?us-ascii?Q?BNSey+9nUaPWiawO27sG6/5wOH9znzHIZa8j5x6IOtPMhj3haqKXMuCuGEIQ?=
 =?us-ascii?Q?MzWd69Z9sH2/FH2eVz3bAwwzRKv7WYI7XTXxwoDyWWz//JBHP4ULihv5/qoI?=
 =?us-ascii?Q?Sr0SR8G0xG8GFaojJzkDcAg8kSbq3d0VZi1a75csfhKEKENidnEWrV3wjXCJ?=
 =?us-ascii?Q?CAy6PuA8Gqc6DYUZNHGj8f9Rz93KWd8q1EKzNbFkZzszJvqtxvkOc18PAHPH?=
 =?us-ascii?Q?n3dOPsk+xDIC0O8v6LaSLdiw5X1GJTbhjO8+UCnN7JTtkSVDBVp9wkUv//Gw?=
 =?us-ascii?Q?a1qoEqJs+oxpgVfyMD1w6kNkCLXrqkdWJnPnbY3k8mA1GMRwEDj/tNNad4s3?=
 =?us-ascii?Q?u1nRsbT364z3OZ8vKDyn7xRpwYNSxtl6l80PZNls0FMbPRanY85raeqPktAU?=
 =?us-ascii?Q?3k8yeA8tjDj6SxeSXwak7LklPpsIevwJ5WYE7VeHqgRygkUZxw0zz0z8Y9Cv?=
 =?us-ascii?Q?wFPGm8X6m+20xLiqNF8qtdb+GsY4vqEiabO7VCV+tJJfc+HN1DRI8yOeLXmF?=
 =?us-ascii?Q?4RQfcszmtFoykJo6pOk0CEHPu/e1ZoESeguHDhb4VkAlG8kmK4k2YbGDQfN6?=
 =?us-ascii?Q?qdOatV3bJBf3sYNFVhhSkGL665McGUB8E3kwrFxWUKM2V9MAkDdeYVL/SO6Y?=
 =?us-ascii?Q?3WafuCV2V/+n37v68PG5UschpO+lzCgKQbOMzTEEyXWNyCoGUkOYPUcBIunl?=
 =?us-ascii?Q?9g8/4avBq17Oj2F1nnqNUQYcAN/2RNnIy93dv53V1tzGJUNp21HdYfjZYTo9?=
 =?us-ascii?Q?Q+UncwGf9+9AhRat0nEgZqmvkUQThr0w4ObV6AlQX+zHzC7cNOxzrsEYnyho?=
 =?us-ascii?Q?30Q4yOUZJwoBEZrzsrXkyf/2nmec5JadkELQnmlvsF3WBPj49w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mrrQXZBoQstCJCtjfuqTMHTtf32FomRPA/iIlKzPKZzICktEsYubZ9avP3fM?=
 =?us-ascii?Q?0cC/PvMuMZRMn+fwuK2QiHzyAWRTzdckeTHS5JrfcYzmktXf1CD+37hXAucW?=
 =?us-ascii?Q?/LcKy3XJAhAq2K/VvSiqpijNhlnOczG7VQ2w0XwtjyN5xSx3kBMxEhUWzioC?=
 =?us-ascii?Q?4cE6SqP0BRCGr1/vR+Q3t8cft+zm+GA0lvxzevdvFn7WWXAmZte5CuktESMz?=
 =?us-ascii?Q?5+X+uatV3RZXxEnuvahnuNvske7XMZqCT9IawtRZjS/nsKwxEgFLgU4oiZiP?=
 =?us-ascii?Q?F70ayXtDrN1OUs1+4hI/57+M6mL3WpvLAsxirqKDBrzlDRayZxfHRQ8wZpXr?=
 =?us-ascii?Q?s0t3YZagY4CMvm/tCEl736XXsGO8cuegiX5jJ3GDrz1p+Xr1xSn8jjqFA5IM?=
 =?us-ascii?Q?1m8lw9jQpMGXyHPGo3f8NdnP3kMUsKju26Fd5E6scE6p19oTIJszPG7PrVxL?=
 =?us-ascii?Q?KAputHyS+N5YtilV1UqU8/cUdoYPQKunauzC0OY3vdBiZG8sXXn6P0T/0uI/?=
 =?us-ascii?Q?Kdj26kUNwngLt2AumE7LHlafIBUg72WW1lh4P5eILbX75cwLF80A6byN8g7x?=
 =?us-ascii?Q?YBrQpt/uaB9Sovi3FCMLpHLoFNYnoaQtUpQlesP/rCPiImV4CauDrrXyOQUV?=
 =?us-ascii?Q?MgkwCox3FIM7mlQmxuzI1mLfTO+PefmkB0qihFIseuKdZCoLv5jNXy+2RHpP?=
 =?us-ascii?Q?WquTFGcl24aXxbBD3mGxlkbxWfaLuMaKucB4v42QYnU2HZ04iWRVejFNk1/k?=
 =?us-ascii?Q?7yktIA8TrgHR6J517mXgqk3pFE44PLWXmembl3lmcKQq0G3IIt87GES2XW6Q?=
 =?us-ascii?Q?QQWL0GmfI5LO1UV1SKSIFafmrpnqwMFc7hik30HQraw/5qoxi2Ap5eptOJ7A?=
 =?us-ascii?Q?yIUttgDSjea1Vq9WV8cDbUF35YdA0n/YCPVQxISzSMlqlw8u1B0sIQ/3Y0lO?=
 =?us-ascii?Q?RlCceKJ9NsKiaq1l3PbqTzrjHLVjtcG8kIKeJqYTKNiMnTa1e1H3mDgrbvfw?=
 =?us-ascii?Q?m2QeMsdfiTtQfvtAHkbHi+9xpj8rbHZloaILFF5hBDPrFaIdVadIDvKl74Gh?=
 =?us-ascii?Q?/vxCvcetB5xHBvZO9TQ0K0D7QJVoMEzhVvoPIjYHDmhR9N1Ko0kPSL8+FObo?=
 =?us-ascii?Q?ZI+IF/CMxrO+cGU9IhKcng/2SZ2megqe/tZGxUEtzDzP1ERnHc8ZRXn/2jsK?=
 =?us-ascii?Q?3OX3Q0APTTALEFkdZKJMAUdPvlZT1EejKSFS0yTTVUtK3v/pQC0DDr1lVcVS?=
 =?us-ascii?Q?Mv0m1KL585yRu47+x8jD5UnM1sF5BablT7utMsFyV3Rv0XxaIYk2n1LMWO1R?=
 =?us-ascii?Q?00ZLE6d4qu12obbxhw6o2geU+88usRWJl2tzMlKJaXldLNbrvyvdSnuWAco0?=
 =?us-ascii?Q?0zXuTravZs3WJBv14VlcDYfE5LzwJAqjgZ3QWAOrqDhuO7tRuGgjCWGTPxE+?=
 =?us-ascii?Q?LBZ0ijFJ15lC4waMNTIGdrBCp/ypCoifkLQVInTUHBMzAr7H756RI/fQpt1K?=
 =?us-ascii?Q?tcjwFzSciZy+zlKeN2NfUEWvI2qwVIE9XWcfm+qy+IxmpGw7qPDmCYOtW6KE?=
 =?us-ascii?Q?ibKitypmQAyw6IzZtMg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1735bd8-1d12-42cd-9e77-08dccbbe80fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2024 02:17:04.7526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h6dfwYkq1GYG30NstEigSeBP0qvpQUuR1IqJ0FmkQ1J1teHOcqYg8oJogCWHtSjTstaU18kDQZHI+z++xELigg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7346

> > +properties:
> > +  compatible:
> > +    enum:
> > +      - ethernet-phy-id0180.dc40
> > +      - ethernet-phy-id0180.dd00
> > +      - ethernet-phy-id0180.dc80
> > +      - ethernet-phy-id001b.b010
> > +      - ethernet-phy-id001b.b031
>=20
> This shows the issues with using a compatible. The driver has:
>=20
> #define PHY_ID_TJA_1120                 0x001BB031
>=20
>                 PHY_ID_MATCH_MODEL(PHY_ID_TJA_1120),
>=20
> which means the lowest nibble is ignored. The driver will quite happy als=
o probe
> for hardware using 001b.b030, 001b.b032, 001b.b033, ... 001b.b03f
>=20
> Given you are inside NXP, do any of these exist? Was 001b.b030 too broken=
 it
> never left the QA lab? Are there any hardware issues which might result i=
n a
> new silicon stepping?

Yes, some of the revisions do exist, but the driver should be compatible wi=
th
these different revisions.

For 001b.b030, I don't think it is broken, based on the latest data sheet o=
f
TJA1120 (Rev 0.6 26 January 2023), the PHY ID is 001b.b030. I don't know
why it is defined as 001b.b031 in the driver, it may be a typo.
>=20
> Does ethernet-phy-id0180.dc41 exist? etc.
I think other TJA PHYs should also have different revisions.

Because the driver ignores the lowest nibble of the PHY ID, I think it is f=
ine to
define the lowest nibble of the PHY ID in these compatible strings as 0, an=
d
there is no need to list all revisions. And I don't know which revisions ex=
ist,
because I haven't found or have no permission to download some PHY data
sheets. I think what I can do is to modify "ethernet-phy-id001b.b031" to
"ethernet-phy-id001b.b030".

