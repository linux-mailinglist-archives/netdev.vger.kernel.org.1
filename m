Return-Path: <netdev+bounces-175596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 778D9A66919
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 06:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD67B177569
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 05:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8C81CF5E2;
	Tue, 18 Mar 2025 05:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Efb0Qtuv"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2074.outbound.protection.outlook.com [40.107.105.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D731CB51F;
	Tue, 18 Mar 2025 05:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742274840; cv=fail; b=oZUqhEWLrrv63rYTCiU5yjWlIg/EoY/tPeDOHzkRnXDx23Q58bdBsE3td28+Aun0w25b5cXPQWQJXPfYPQdgnR9RiR34RTf5ZqVpEhhsBARlkObaZHSnzZkMJVGpQD5cCbKGF2ukFH2VwMwMwinvdEmbuxtzV5WB6yvCq+n9/os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742274840; c=relaxed/simple;
	bh=4klikhdIiH6JUhYUsOyl8Ejmap3Nkvlq6hBZzvgoQzo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hsSnT81+0OBUuKgSavUpUVayCbTrTs4tHTUmtRBeuVL4+Tod7ZT85e/u6kMFsmGGBAUrJwnmHWd8cdIEJ+PEca9EEt2JSzkPLv6cmbzDJOXYdWZ9MpqVDcdY1gRVV0K6+hq+AVaMi36qh87QgMlhlEdmYKNj7qB88kRJE+ZKLI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Efb0Qtuv; arc=fail smtp.client-ip=40.107.105.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w6MQBq/QhpsGMprzhcJFDoh9wECHqxFTLjuAU7TiMlbPtSZJK0GmBLnCzPDROeiGejagVbELVyn+Ya68Y8RLVn2EEuAyHn0FoHT15mS2y09YfWWR0T6TC5fbNODjT2Uc+UENYmml60ZXYcogL2uIsfjJFGwSYobPJHLpx/raVBtWV19YrihnpyUScespNEAufLu0OaWLZQBebpzOc5s0DgPB1xnM3ccMAC0ApCRK7f+eczj8jJ/LixwF5ltnShMcM8C4M8wY8vWJ6IknPbHXhXveqi23eyDOlbiJyrQpDNSCr8+KpNkcU3wycShJXoq5uKdvOZodQb9bac/OeYCSmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cp53SQnVynXG8am+PHBtJ6woUGYYm+cmWiRt/c9j/zQ=;
 b=YrzF2NrU75oZ7uEanc0S6ziFL2WI68pl9kMO+ujbomTSQUpzJuoMQwA62DCSOwq3gyP/R20mHr4bee2ipLzYWwj2zC8xoTidqrSl9N5fKqwkXkgBC0e7gENqBHpKjAp4kQXff+roAODS8cfvnJyjFMHJ5q8E0YnkYyJSAv02qro3gmmrA9rh/HTsPDgZa6L8C9T24g6FAZ0nKQDYxZqAG6cDM9l8XzPv4EuaBKqyb/sq3Nx8qOHRKmV/8F8d4KLbzfpNnkCe+I+BeWQtpt6hv+84FkWxQw05uh1zEBnRFm7Pz4S2161ET2zvlTI/rig0ajJgvLoNfeQCmIgJI8eLHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cp53SQnVynXG8am+PHBtJ6woUGYYm+cmWiRt/c9j/zQ=;
 b=Efb0QtuvCbvGNfByDWMf1Z11oS3SM1r0iich99nBFW11hOAWXk6ImEqWWC/8BkzRSKbG3ehuxD25J5Vg9DptkVFGfvmJiV4pCE3jXoyflHRBJ8Zw0+qj8H6KbHaaPM73nDhPPERR3b/lyxfl94Xu8fHGbtLRlQ8cJYgQT3ziCCivM3REMAdWf+KyF56S0Janw2htxjobVhY284up8ILkYf/CWIPUhzgkwKsSQEDM/PxYkm4/ut+eYg1u/XPMuuLxkxqgpQRHQcsLA8WmceAxXxYvUZuwCuB9qgZQjqaVys7wrxa/yzxtztpNy8LznWM+USUYVaynsYTRnkZhhjxMMA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GV1PR04MB10536.eurprd04.prod.outlook.com (2603:10a6:150:208::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 05:13:55 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 05:13:55 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "christophe.leroy@csgroup.eu"
	<christophe.leroy@csgroup.eu>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v4 net-next 14/14] MAINTAINERS: add new file ntmp.h to
 ENETC driver
Thread-Topic: [PATCH v4 net-next 14/14] MAINTAINERS: add new file ntmp.h to
 ENETC driver
Thread-Index: AQHbkkprOmd53ICERE2NXr4TOcsEp7N3mV0AgADK9zA=
Date: Tue, 18 Mar 2025 05:13:55 +0000
Message-ID:
 <PAXPR04MB85100C9846EF8AFC2622166288DE2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250311053830.1516523-1-wei.fang@nxp.com>
 <20250311053830.1516523-15-wei.fang@nxp.com>
 <20250317170650.4oux6kxh2ng4z725@skbuf>
In-Reply-To: <20250317170650.4oux6kxh2ng4z725@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|GV1PR04MB10536:EE_
x-ms-office365-filtering-correlation-id: 47330d64-2de0-4360-ba2b-08dd65dbaea3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?z8uAsNKfhe0r2555xTKG1H4gRc4PUB4LFis5ulsLr8kHLtB2/NcQRzeyaVwN?=
 =?us-ascii?Q?WN5qNYQw3dgcZRwz8+zDqG3dDOLgLrzzNsgC5u6zdS10Mo3FWTxYLddTnlun?=
 =?us-ascii?Q?dRQhfjWG9MlaNo1e4B8OujS1kbym1iAkizMqRJHxXDcY6KZNYuV33wCF2HnE?=
 =?us-ascii?Q?eERkH25WXDyKwtYgR8fdHCmruMdjs/8neuIg1kmKy+QD/0gkX6UrYl9qfneG?=
 =?us-ascii?Q?TQs0NSsMm/EoLxxPvk37mXuKG4OK3f1mqD5WI6s0obkWXw9z3HpGjfFmC5lg?=
 =?us-ascii?Q?81JIF0rdDr2iFu8PzxjBJ+VIV5dQN/HffVEjxnXU9bsUsHpVJN/JZF1eqzgD?=
 =?us-ascii?Q?Xzyg9Tdrr01RSXi52fmjieOCumN/rUwE2Fmq/KZbMzLDh0wHO5xDVlAgCGqo?=
 =?us-ascii?Q?UqvZuU41R5Na4MSt6ux5NiRKkhUYejcTDiAqxCXp75fhAb3sDboau8lcpL4u?=
 =?us-ascii?Q?Opolwjw1eZiQRKJ1rN/FycIC+mYZnjlvUi29cAw+pw32Ha/cHVpUvPt/iFkh?=
 =?us-ascii?Q?ZkpStBcSB73348f0p4KO5GaCh99PnbEChuYVl4DXpzfEIRuUqvQhrRr2uUR0?=
 =?us-ascii?Q?oGo2eUbwQPgnuu47r7L0ozTzJCwOMp1xrb8Ol8hCjYzghI7vLRCRl5rGgpu6?=
 =?us-ascii?Q?nOzQmJpFn0tHhGZAmGoubtaJ/FZVFrxqOkfIm/iC0tzWWlDKYQ0Tdi+4BvAq?=
 =?us-ascii?Q?E5QeS7AjRWTH+ge68huXj9fq3LcFQEL4UXiuw4g9FvT8lOVFWLVMhrmhK3Ug?=
 =?us-ascii?Q?i0x2YMcTI+bH6yNUiza1/WeYhZOKvjfmhWTm/DPJqVlCQqrvpBde5XyxSV0B?=
 =?us-ascii?Q?CYJDPneJPb+BUWU3ATl81EmAHePZE9FSouBtveVSOBYi73hTdKtlTZ1I/Wcv?=
 =?us-ascii?Q?AZJlF6SpQoWW2rKe2VvJhZSHtric6G3fZBNnfmEjJUvGDc+mybB5eAv8w+6+?=
 =?us-ascii?Q?oZ4Ldy7gMoV0pA1vPHYpZAJfQsOsmDc7TWzkiaWYYaHNji8CdrqlXpo7IbKq?=
 =?us-ascii?Q?7PC65cNpXoJ1R1lPWzAOqCyfH5ZboWCQmOnP9GzgnidvT3NU5uN6VPbj49zj?=
 =?us-ascii?Q?h479u2+RTfDKfbwRT6Wp/9aIZvUK5xNzC+VkRUov6BokKhzkO5DMQZ0n5qfa?=
 =?us-ascii?Q?ffwEDGbBqh0Nh7gfPq88NtITS8cQIlJfMk1KlduXdHcLy1Oy5UmJqqNhx38O?=
 =?us-ascii?Q?57b+4B60D0dP7MdYCM9dQpFrlLvzlAdrum4F1Myv/J6IbjgTDuJy/NJipcMo?=
 =?us-ascii?Q?g/r0VnPJfvZsI3+QyQaflQO68Shzwq7IvCBfM+eyPPRhV+fzeOykwabEQpK2?=
 =?us-ascii?Q?VuVYwAGxAFjFSUX9On+JePMsjOsiym8CFi5QJMGuiD3M+W6kZG3P3FcZciba?=
 =?us-ascii?Q?yP4+TmwUnzdoIHWlOtuMKy6gc7G2t4qGsujlcqMwcSyU5J6XSPwiYKLF9p4r?=
 =?us-ascii?Q?xokplljihkbd2W2ymR7CAx4BzW69gZ9Y?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ebAnp6GmWQCx6wI4m81Zn/f7x+iGGv5Aw0rEcqioe2x74Ut/CKWicJeoUh2i?=
 =?us-ascii?Q?IFiRA/0q9VvfHPOqzSC26MeXD1zv8tzYJL+GsZyNoHYS5iLll26UylCjwlA0?=
 =?us-ascii?Q?E0VIjbhPz40UseThv7y3PJKUfo98nPMXTcAAoVu7mqnnPduBZ3897ECSWgLl?=
 =?us-ascii?Q?p/adN1nhxQL2bc8OqdGQL0rhOzWGJZc7KeT/AO4IoZAIP/cJZrKeS0+rE/40?=
 =?us-ascii?Q?30gCn9OUuKyPsrWmP3GjJ0P7Id/QuH+nEe6CcP1IQQyvC314yBlIi1ZifAmo?=
 =?us-ascii?Q?d6R1uWrvaQPRH+/57P0d/wkMKYRo9uqqnIE339z/U+M/2lrZAGObYaKkdEwg?=
 =?us-ascii?Q?OVH2BrNkhDmPO1xPw0yO67EhhhdgXUJyYjw6vpAVbKGFTRLpvFzgT7qeMwg1?=
 =?us-ascii?Q?xCQOgTr7ET5VJSKCmk4wXUjcgSBGojT7viZTPJdqKAzheSLjtfu7Z3Uq9cfJ?=
 =?us-ascii?Q?Cg+ugyDzlkzTWGHyJK1P/VXBnxvlfHQWEP5zmc1TLm5lWb0ljKmlvuVtgWcQ?=
 =?us-ascii?Q?9Ry6OTOHpY8bdu1UAylM+V5iY1AnPtAxLTHxM4T7pQboHpNO5fqh7w7xoyQ1?=
 =?us-ascii?Q?87bOOO4L85eV+2gFDKezaRWeEun0FYx09+59cIh7JMiZrUKxB4+1j98kgClR?=
 =?us-ascii?Q?6QDGTZzJ/45/0dvRXHA84Cr5NoJHHnq9yt2V+eILPYc0uBSWyy3gupk3jwTY?=
 =?us-ascii?Q?wYhbsBBCV2OO9EmAcvBtGU13wjoNPI0XjTeQHLOcFL4EJKpIn949gshkCQgx?=
 =?us-ascii?Q?KYOCd/VRkJxe4wKd0PcuKBvLdsBzVat+iPBjJD6jUr8JaX9zMuunjr8R9Kz+?=
 =?us-ascii?Q?qFB1pwpFILYcV1spLzLS4iGDK9sAJ+Pep1sMcxL/LA/2fKc5H6UudG/9NwDG?=
 =?us-ascii?Q?V1TY8MoL+qJtVjroi9DldET0xO/kLnVphW1PjVaa7Pxj/usw1Q1ypvuvUA9X?=
 =?us-ascii?Q?O+dQ4IBkTmvw8VtO+3Tbei6nd1i27+GbzQEVy2t9WoGKdg6J/hzuAxJSyH8m?=
 =?us-ascii?Q?cexCBEYdukKZf+d22nFM4nbKMvDgJKz5RpEUHmQEUSJpKGTPpWyRRiA11hVR?=
 =?us-ascii?Q?gV7iI2LLSwzqgxzJUgZIiuOvCp06BVynC2GSuI0YrJ85EUXcTJvuf+W1G9RL?=
 =?us-ascii?Q?wGFLNoCN6KD1w65EvicsP4/gDdAR2pbSj5buTZpU2MOYygaDLeAY2na+mG2i?=
 =?us-ascii?Q?abldvtfCMPUNLuxYu1v+3pWgqMA0BI0V/8M5svwgZBhLF92itpYDu+kyOzQV?=
 =?us-ascii?Q?DGyV9yIHCOeFDkjIJ8+DW8A8NGHxpNLOg6o67kZawtx/otZRvXVz/joYaiqq?=
 =?us-ascii?Q?wAN3DzcA/pxH5/Jf/7uExNdIOLtKIDrhtnWw+5SALvDjvIQmn5izH1jEaJTj?=
 =?us-ascii?Q?3/VUQNaxzTkbrgvZtC8PLmqM4ZVC3WRvVl0SaszvA1OtuT4kCqXsXZJ8ERJd?=
 =?us-ascii?Q?Yvmc3GzG8qrW0JE8jR28k6D6X+/Bp3dQnpzf52AmRr3KTL+1gv5ZifeCbna6?=
 =?us-ascii?Q?3kxEqyeBQwAmlW08j9yPVCRan1CWtiyP6Sm3YDf94SRtIbl+6f4viC6rFMQB?=
 =?us-ascii?Q?nyRQWwdQT4QxIPRdkhU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 47330d64-2de0-4360-ba2b-08dd65dbaea3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 05:13:55.8156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UXNhQtYURjTxjmuiP9cVI3E6/fmTaeBvighk3GPgA8jut/O6o7MNqB7t4ao1SbY0C4Jp9/4XSJQnk+PUYLDm2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10536

> On Tue, Mar 11, 2025 at 01:38:30PM +0800, Wei Fang wrote:
> > Add new file ntmp.h. to ENETC driver.
> >
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS index
> > 7078199fcebf..e259b659eadb 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -9174,6 +9174,7 @@ F:
> 	Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml
> >  F:	drivers/net/ethernet/freescale/enetc/
> >  F:	include/linux/fsl/enetc_mdio.h
> >  F:	include/linux/fsl/netc_global.h
> > +F:	include/linux/fsl/ntmp.h
> >
> >  FREESCALE eTSEC ETHERNET DRIVER (GIANFAR)
> >  M:	Claudiu Manoil <claudiu.manoil@nxp.com>
> > --
> > 2.34.1
> >
>=20
> This should be squashed with the patch that adds the initial NTMP support=
.
> We don't split out patches to the MAINTAINERS file.

Okay, I will squashed it to the NTMP patch.


