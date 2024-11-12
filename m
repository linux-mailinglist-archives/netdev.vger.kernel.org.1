Return-Path: <netdev+bounces-144215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2746E9C618A
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 20:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A205B6194C
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 19:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419A0219CA4;
	Tue, 12 Nov 2024 19:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oQyntVs2"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2069.outbound.protection.outlook.com [40.107.104.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEEC218954;
	Tue, 12 Nov 2024 19:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731439065; cv=fail; b=gtSS03CzNcm8nDNwrSY8XykoR1hHp7xddxV4Sur09R5/3cCdcOno1uMtczKqG6slpqsRAAbZE1FGpmQqPmKxCuIKrYWsP3Yshpl78typyyLMPGHoG0kGc6Zu22pRnqkxl7mApCjAUlSKofI+X3mJIYv+Pn3rngAqvZrG4UJDaD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731439065; c=relaxed/simple;
	bh=Of5ECCx8uETf7aa2xQIhDxcmP+H1mn8yqT+im+LnxVE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=psq26PG4JiYt9vg0RlFZPsZjsN4dem1YvI30KIVBhdG9div7VDfpShoG6G+pMOltFp/eEXMb5Ja40wDvkfoCxH/y0xfnu3ou8vgv8Qrx5m4PJFiDFz0wI81FbrAtk6mAk6HQ1n4z7/bdPZad9UjIImFZMN3i/roKkDduRCtuKoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oQyntVs2; arc=fail smtp.client-ip=40.107.104.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pTXFduFmlMxRndVke8GbS6SEIK5cD5s28kI6c4Gp4hsIyoy+N6I+IHB24uCZQ812mzlO5elDqFyLiZ7tbThv6Xama5PfD8M4gRb8R/cw7kQRJb9kecBU3dgMPUS0aervTYb1A2P6iJaIoJPYgeIExsRaU7USEOs/2b5Uh4sIV8368yj1XW3J7f13/lpx7m/9djcFTjG0icq38WtEL2ngKS1xS6qp7lWQ1PaIsX3gcmeBPRGc+09QELk1P3XG6UY8brDQZA0b30KSSrUdsdPEs1Q77Vo4Pq02x+sr+Y3FkdICEue7ZDQo1SMwLVIHyP7hMb312c7IukUTgtrlAfuGpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9F9ppZ4fzhDnNEPE0Yq6qW+vcfPbsj3NFFj92E+ieXI=;
 b=lOZenbgcQpnoQuOfICYMKUVQliwVeuRl2Eqf4fqziC3EKulat/uu/NJGNAc3StQPL4Wa+vl+V/Tf17uEtunDhPgy+EMF8JBufEvn2oNHhk0hqiHt8F3J6uxwGaK29lh+UctFwkfo/KFXGmGGgqa3CzeXJ1P3YCe+SPrlHUvTYpp+KXmx4StY39tPTxTAm+c29I/MRAhqLSJSxUiiQ766FU5HPlKCe8rNBlMWfXDPN1yKn2O31YnKEmpZffCdDqtOM2/zlkqgPhibEpHj4n94vAs7U/ehpZM2eChQcgakXz4QmLiRGZPZ9jg0tePeOaaxZkJr/9d1hujem2M9e04qdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9F9ppZ4fzhDnNEPE0Yq6qW+vcfPbsj3NFFj92E+ieXI=;
 b=oQyntVs2zhpyAC8HXF+zQtojrmI0Lai0SW2K+sR9+sKympGvHP1taGnUsU14wQOGuc54IeggqmCsUxF0rV0q0R9kSToqoTjRYjs563FVXYV3qIZLGwO9YthJHT7WNcpxNZL5PhxTR1APtUahyWBh+shrq3UFQ/uxRN7qFe2u6G1QHWDe0wdEDZuR8QRrbTrtmk5zLqcI3nSV8DvFFKDokmWcUUFc1UONUI36W3Nm9z/D+Eu94V9FKvHaK15lpkXLhpokHH8B7gLePDuIYUH8yGHD0cgL7Moc+7L1ZKMsS+21Hs6+47CyZp+ya0hf40urSpflaWzyHNgUVucS9cDVag==
Received: from AS8PR04MB8849.eurprd04.prod.outlook.com (2603:10a6:20b:42c::17)
 by AS4PR04MB9552.eurprd04.prod.outlook.com (2603:10a6:20b:4fb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 19:17:41 +0000
Received: from AS8PR04MB8849.eurprd04.prod.outlook.com
 ([fe80::d8e2:1fd7:2395:b684]) by AS8PR04MB8849.eurprd04.prod.outlook.com
 ([fe80::d8e2:1fd7:2395:b684%7]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 19:17:41 +0000
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: Wei Fang <wei.fang@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, Frank Li
	<frank.li@nxp.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v3 net-next 4/5] net: enetc: add LSO support for i.MX95
 ENETC PF
Thread-Topic: [PATCH v3 net-next 4/5] net: enetc: add LSO support for i.MX95
 ENETC PF
Thread-Index: AQHbNOWHnBQjJzI0+k2wBXpchhMGsLK0BNYg
Date: Tue, 12 Nov 2024 19:17:41 +0000
Message-ID:
 <AS8PR04MB8849F52B531803878F0E155496592@AS8PR04MB8849.eurprd04.prod.outlook.com>
References: <20241112091447.1850899-1-wei.fang@nxp.com>
 <20241112091447.1850899-5-wei.fang@nxp.com>
In-Reply-To: <20241112091447.1850899-5-wei.fang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8849:EE_|AS4PR04MB9552:EE_
x-ms-office365-filtering-correlation-id: 458f37b4-708b-44a9-1ab7-08dd034eadec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?RZQKMrrNxKNplTPRkywX/RMlf0sXaWBoqcLviHVcQz222gpO+lDuRBcW6Qz+?=
 =?us-ascii?Q?TRlhVI6v/NrvYFeGzwHXgJxBzpSweTlcUnpGZrTEoTbV2JAietb16IP0aGX/?=
 =?us-ascii?Q?s4yk3WWYf0i6vax95NHeMqmYJaSZ7WBU9v4j/5bcVkd+V4n3z+jwkeH0Kidu?=
 =?us-ascii?Q?1vV1IdqqzITjW9Aa9eeVmOpG6VLSvdFQkt2egJ+zoUedCjuCnkd+Flh9uUvO?=
 =?us-ascii?Q?NE+TqZ5sRgkCPtuRFXbx6YagpgG3h5bDWgD6ZtbYBUPxFscH7YqzpoS/qqKq?=
 =?us-ascii?Q?gTvWXNNTkgXCYRvVyzY/3U0ib1DDyHLMGN7es+j5Rj1Bh1ztwbCN7PiL4s5I?=
 =?us-ascii?Q?+dCMdx6LCQhCsrSauvt++U1S84T3DIXFp4jWvAlrNE0NR2Jpl4tgDo75j7Qq?=
 =?us-ascii?Q?JG63g8eHpNFJwPuRVli0egRftzkAj03a4JcAE/NcgKT/KdMkExOR/zKEiYN8?=
 =?us-ascii?Q?zy0ASU5LWb0TdD/FpXPXvYgmtlov/kdT022EN3JhFdyiz0qiY95Gq9SB6R07?=
 =?us-ascii?Q?A+/60P7WDGrvDioRvuJLS/Yvv3MH5mQTImM81B61JoBJYuFtFcWyffnb8MEC?=
 =?us-ascii?Q?XCxHKB0lXtORKo+aFDobi1Oc+4LMfiENIrU03SkxBkWAWp2wm+Z1il3+e12E?=
 =?us-ascii?Q?XI5dJK7CCWiem2P7oNxKCFHNqisO0VR++C/4M0+qqJ42bUeAaAfvCJYIGRae?=
 =?us-ascii?Q?kVCP6xKck6fjvuJxs+TiOu309ITFM8nHQTzwZTbPnHWwyTyK9i95x8ZoM3PW?=
 =?us-ascii?Q?enZZ7HoJ7mUFVU4At2j/y7Gb41sVHT4AGGMDfOqfuP/NGSMdNkXfJSfBu/rp?=
 =?us-ascii?Q?zzUF+X6Y1QQtls7wqVM5OGXUIXguY9zmKZxCZ1BJcmj9Dlcb3xDFvBPAeppP?=
 =?us-ascii?Q?r3GXU3PLioLx3DbxCyC5MRoBjbqKckBEnkbmychxNtRLPLFmsqODjLg3dBjN?=
 =?us-ascii?Q?MpF/kxipgWhrhQyro/8UEeZ6bt6ZCM8KcWseZbtvA1AvsIfh1jcqXp0XPj5/?=
 =?us-ascii?Q?o128XTUEVgP2mRWqAfm3K60q1iKEfBXKJJ9+27MqLlxkKrmaj4NnVm9kWldU?=
 =?us-ascii?Q?vepEH15oU5h8goa/6CwmrYRZZmjC9FiZTyW+Wr1IYOZpvQm9RAN8u1O/cJK6?=
 =?us-ascii?Q?GhoiFjG6/MdZFw29PlaJv25Kejaw2AfPQFrslMF+KVQxM/Oz4bJMSPSOIICG?=
 =?us-ascii?Q?QfR8H+vP2mtJNalxy1NF+bXSSJcA1waSgwHj4BPJLdsMHEV/W6H1iFC2EtqI?=
 =?us-ascii?Q?cJrFe2lBxmx6/rTOII44FRLdhX/Ruj9h58ok2qK8x4XXIaLHfMYEyhs9F6HC?=
 =?us-ascii?Q?EtHWvMEPpj/iuGQTdvtdiF4SqHRcCf5EcXTYqTBONKr3kPMqTiGB9NZLcE/N?=
 =?us-ascii?Q?pScRXZA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8849.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NlsdEcKlqfgDS/mkxvIl4o7x9HvV8sdPr/zUWqwTqV5oAyQNk/dlQrLbTyOA?=
 =?us-ascii?Q?xw/xDkaidhkZ3ENKbIIeH4AuFonzQWUdYaRHJiFJpDq1/y3xHSVOVzDVGNCs?=
 =?us-ascii?Q?33rfwHBGWSmK6/j3VmwsNSQdtDGTnjzKjreEc3Bd+r338rg1oePcpBB0EbOH?=
 =?us-ascii?Q?KzqKS06spaZSgdbX2RlW6tJIuhkGSovir5XaNKWsH1l/XrC+zaYeR7yCdjLv?=
 =?us-ascii?Q?TQo/dYHjGSUHZ+9YlSjQAUimN06qxv5Lr85cs7AqCS8T1aVOuTRMIjPHfIbx?=
 =?us-ascii?Q?InQVXBBs5V8mTg4udzp/0kZOXpPC0aLMoGOyVGTyTunsPZtNfsGnX349+tiG?=
 =?us-ascii?Q?w501xUap/yngNlDlqjNGEdV99J9l6J+UgRk6BFWKj+swsXzZgnPY6enVbZVe?=
 =?us-ascii?Q?QdkN9B3wYaP8NLAOIMKG/A2tjoxw67+KbNSBKt+N6YEjgCbsEt4nMz14D5S9?=
 =?us-ascii?Q?xs62ETmrb2ueqFKGeQQM0aRfwjAynrLOWWFFTpZnM6E3b1nl+tO/w0x2Y8f+?=
 =?us-ascii?Q?gGABl9JX6GjfLyl8MBObf64ZTECavb6imK82EI4U0zedqCOHMaAiJkHSnQPz?=
 =?us-ascii?Q?/rwdMShHv/zmg5Jracxn+zzay0jbDH7gGC4zk/Ccfr8O+njyprsyfUWjfrv4?=
 =?us-ascii?Q?QwHp/nS01DvRVXcfcPhuNa+FtAh5JzcsmN86nkcMWL9C/535XP5USEv/3/8l?=
 =?us-ascii?Q?Qz/KO4W1/XXq/xKtWOuedMiVP4irYzKt80Ed1P5dO/kMWdLqI/E3VR7qegPR?=
 =?us-ascii?Q?4ZONbQSkK6ZMFokzIYAj1rCuIEWlbiovXVgFgCKzCkEk3IQJH7Wf3S9gIaBs?=
 =?us-ascii?Q?7Ik26lf1tIGgxp/Fzitned4IJImJhObUPjLRChOKRWNozvFpZuoYbJrd94Wd?=
 =?us-ascii?Q?473M5Q7US2b/SLGuagKWqhtLKaAUwYEAZj5v7YlfPs9lEoMnXtB5YNOfNBAn?=
 =?us-ascii?Q?afWw1uVddWP+vw41PCx7w92PWlfvVTa+uO9o7pDxo0tAzfIPfWNP75jCmfOG?=
 =?us-ascii?Q?cI9K0hWnDOOlS9q8uRo370U57iGaWN6O8UqOjM2ffejVjlrKyhxvxq8MwDw/?=
 =?us-ascii?Q?h70FB5LpD42Z504nziU3rqnZnpsCi/anXStqfPKifxS1fcPW7266GmPP+614?=
 =?us-ascii?Q?Ic3ZECSXsWydDe+AaElesf5ii7sSVjYGt9IJfg37KeSe0OOhV3z96QrZCrjH?=
 =?us-ascii?Q?P5YnmGMC6KbiqUgc7/6E1lVYPiawFH0M7Wcned7KjbJULQVRo216vC3jR6Z6?=
 =?us-ascii?Q?dFMojIsImX/ctjOBmJJwJLE4GnxD6LkSt4gRsH7wjM+BO8hxnsXXX3jzqUw2?=
 =?us-ascii?Q?EkaLXAQMvMPqcp9JASNH2OzQzhJwcCtPj1DCo1810qI00W3nh7NTaT1Xw2CP?=
 =?us-ascii?Q?i8S2wBU08+QKOWkD7xwWQs1qM+GYAt8b8avlWfTDcKEniMix83yy4mdh0U86?=
 =?us-ascii?Q?VarQNTKDRfTaQ6CxRYTJDItkTqBHaMZEc9MW/U+Op1TAeK62lEooyjEqMYAA?=
 =?us-ascii?Q?mqVtrZWeVHU30k9824cJUripnl3PCU3CjT+S3Vu9RC7OnSTzx6KP6j74+4YY?=
 =?us-ascii?Q?bgI0gDR4uHubf38tKK1GeKLTWWGqFLOYX4wmhfM3?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8849.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 458f37b4-708b-44a9-1ab7-08dd034eadec
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 19:17:41.6671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AVIQCYj6J3bkCEz1Uf3q75fJJKXgn3tWwKkImAHL7o1sk1LnC9As5sikc9UVsErUcVXTQUMKSid9lI5TYXekQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9552

> -----Original Message-----
> From: Wei Fang <wei.fang@nxp.com>
> Sent: Tuesday, November 12, 2024 11:15 AM
[...]
> Subject: [PATCH v3 net-next 4/5] net: enetc: add LSO support for i.MX95
> ENETC PF
>=20
> ENETC rev 4.1 supports large send offload (LSO), segmenting large TCP
> and UDP transmit units into multiple Ethernet frames. To support LSO,
> software needs to fill some auxiliary information in Tx BD, such as LSO
> header length, frame length, LSO maximum segment size, etc.
>=20
> At 1Gbps link rate, TCP segmentation was tested using iperf3, and the
> CPU performance before and after applying the patch was compared through
> the top command. It can be seen that LSO saves a significant amount of
> CPU cycles compared to software TSO.
>=20
> Before applying the patch:
> %Cpu(s):  0.1 us,  4.1 sy,  0.0 ni, 85.7 id,  0.0 wa,  0.5 hi,  9.7 si
>=20
> After applying the patch:
> %Cpu(s):  0.1 us,  2.3 sy,  0.0 ni, 94.5 id,  0.0 wa,  0.4 hi,  2.6 si
>=20
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
> v2: no changes
> v3: use enetc_skb_is_ipv6() helper fucntion which is added in patch 2
> ---

Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>

