Return-Path: <netdev+bounces-144214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2639C6128
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 20:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A98A1F22C37
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 19:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29721218950;
	Tue, 12 Nov 2024 19:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QMLvhwSF"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2069.outbound.protection.outlook.com [40.107.104.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0A62185A9;
	Tue, 12 Nov 2024 19:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731439063; cv=fail; b=amgdllsh77+k0NGOX14lHl3ZVy1ZpQqoC9HKaT57CZO4MouELneehloVmwgL1BMOHEe7b1iRKDoI0At4Thj5uxDhJ2pTn8HIwFVjA7u9wRUNcH6/e/chjyox/UGgVrNPI6X2raPMDYw6gH8dLk40776PrnQXLEAs0oZ+U5p7rdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731439063; c=relaxed/simple;
	bh=eDK0YAYt2dkAC9CSkfdRvApjbVtIpx6nQaHIO0QhDZ4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BOlhzfzfxUI9t+W2QgEOmyC6Tcuq2ldcDhuNeJL09EWBPGvVR/0EMhtcPf9wRkP72GEcQSzVoLeOdzn11yHb2l2jIutCcGRaCFG5oLB515Qx3LNP1vFoFqzTjQceNYhYIPJVCYz3H6Vtn4AkjHvg0/60G9awI49A2SgOXFyjymQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QMLvhwSF; arc=fail smtp.client-ip=40.107.104.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WAq1oepYH1rk8r0SEW9oPRMsqb1MF3imZF9jqpNoJzdf3GshzQCYA7RYitFmQdGtqxXDMCNfSgagbVbHJ5bWX8WoIfeOrbgYSu3MYsnPg59g/a4a5i85t6qj2MsjunP5QQ27f6UPdVancATWNV7OxYyjeUYDKbYItGCuEzFEJgoSbBq4W3FkldMRpJkxcTebx0LTTsHcwJT289Kp18aRRZ+CDjv+Zs9ddKOlyikKCcef1UxpmpC2Ad38zki/Aw4Wyzh1Uy08Z32n/Bn+VTEo2A51vFwukweJsk8AU5MDDjfKCdGA2FBpfeVXULha74F8ZJpEYuBEwpFHdi214660DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDK0YAYt2dkAC9CSkfdRvApjbVtIpx6nQaHIO0QhDZ4=;
 b=x/nLUDdnovLzKr/YE/5Izwu5QLNi1hcMJAQSmsCUzXcWyYBwOSU+J+01b1NiAC2IOjA9BWMKWn00ESRxpbkYZqc3E63AbqADTZlIh5G34dvqhgVRXZ1n+sq5gW2iFWT1+WY16vfQcgvFkX6RP9+0SqnDl52PzBn1ID8hL2tH3I71s4V1ddKKl2xI9/IPe7eR4t15vUJm0nl+6pDcemxYxxF/GzTedwrs9o5YKrZm+blNKsEiLJP8dzHzY5Q5u42CZHycyk0cZj4ECzZ5QZczeoc7r70nvLVmO46qo07tpvQJCyMhpy6fcSheQl5RZyihQtevo692boLju09bXcDaCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDK0YAYt2dkAC9CSkfdRvApjbVtIpx6nQaHIO0QhDZ4=;
 b=QMLvhwSFrem+lhZMQ6rPIK/TYzqg0MiNxxQZB8bsvxtGEcf2fXTKz4/9V/Sbgt23G1mLV7wdLr62J0XljaDjl5ksxH7owDXwktfFCnioXefBWhUdfID7e5CRxMhz3XyKMQOBdNkqXJfrZpqVvH1e9kIE0DiYZWAXz8Yn++J85ezt/Er6dNouTVYB2l8GpNB5KALQB+2FnDJAVuew8wyobQ1HVMO2bXMZSQ25obs/bVSIAKOR5pIUfenkEvl7eTakkp4kg8OGmbZ5zHOip8gJCTXNLR1Aq4IngscEHIziRSghC2kNWOfE7DBkTUlj0KNEn4vdnILwGvYh4qieAWQUpQ==
Received: from AS8PR04MB8849.eurprd04.prod.outlook.com (2603:10a6:20b:42c::17)
 by AS4PR04MB9552.eurprd04.prod.outlook.com (2603:10a6:20b:4fb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 19:17:37 +0000
Received: from AS8PR04MB8849.eurprd04.prod.outlook.com
 ([fe80::d8e2:1fd7:2395:b684]) by AS8PR04MB8849.eurprd04.prod.outlook.com
 ([fe80::d8e2:1fd7:2395:b684%7]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 19:17:37 +0000
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
Subject: RE: [PATCH v3 net-next 3/5] net: enetc: update max chained Tx BD
 number for i.MX95 ENETC
Thread-Topic: [PATCH v3 net-next 3/5] net: enetc: update max chained Tx BD
 number for i.MX95 ENETC
Thread-Index: AQHbNOWEU9zQiZuHPUWGOr7yJdC/c7Kz/4aA
Date: Tue, 12 Nov 2024 19:17:37 +0000
Message-ID:
 <AS8PR04MB8849F0D0933B558FCB1A652896592@AS8PR04MB8849.eurprd04.prod.outlook.com>
References: <20241112091447.1850899-1-wei.fang@nxp.com>
 <20241112091447.1850899-4-wei.fang@nxp.com>
In-Reply-To: <20241112091447.1850899-4-wei.fang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8849:EE_|AS4PR04MB9552:EE_
x-ms-office365-filtering-correlation-id: 65fab341-8cd2-42c7-007b-08dd034eab5a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?j1Xo1KcklqJKa8VXie3j+grnWFqPSlKa4xn4rqCNomR4cJ+lD7qOPqv/mbgw?=
 =?us-ascii?Q?tpK70ue1HPjuFjGAc2DBqsrJF3spxrM5qFKwwrxrhCoIUnjRnJftRZ1+4FsI?=
 =?us-ascii?Q?to+LDhJqul9+9hfREoJecDmPcyEoBrp5NbsQVs3DDOWsnpcfXynrm1LKjfgJ?=
 =?us-ascii?Q?7TBifxKx8x9tUU+kzcRWLIWaFYwQd8HsDnBjOmezbwMPMvL0tFx3QqL9230P?=
 =?us-ascii?Q?bKHxjxFW9hV45pfCe1rOebMJ14nV2oEVrW6EeDPr+ee8IvZH2WwBq5xTw98b?=
 =?us-ascii?Q?33H4vZk5WTNMYx2+F/ng+UYBD4SvqziQmPZXkk2Gs3SnqG2Y42SGWszeGzRW?=
 =?us-ascii?Q?UHgsakmbTF54600Ci0I57UXVqVLiToJ1i5AlOEFPLz46o3B4+UZrgyBOiPnA?=
 =?us-ascii?Q?AD3yfOi5QQKyltgCpZLjAGX2wTaUUubctW5nw4KK8usW4xDrGwSIq+x/FKoI?=
 =?us-ascii?Q?0QatvK0MXVdd5vv3XCrkQSzdhAMgtj2Hos7Pkr5JKt4uaklMQStvFXAaQi0d?=
 =?us-ascii?Q?+hA559BfqmJYjYaawEhJliOBqza5lPq0jecagv53Nb7JOuaB+v7/JPp0QUs1?=
 =?us-ascii?Q?9kXxhHKnZDc2++0SVXF4c1Ly0L7Md/CZ/yxl4c1C11wnwEM4kDsoYnct1Jvd?=
 =?us-ascii?Q?n5ZxiVzRFX10eSvG9Aq3oYTFSTI/Acsmx/VPDArcGQXcYzAZAyapwndgvy+X?=
 =?us-ascii?Q?8xvsG19gKiuq3si1NGr3oAy7RWpfPs8SYx/AjLoONz+gdK4A3e3XLPqCK0oa?=
 =?us-ascii?Q?0JNDFsg5NcdYej+RLYdFRw+yye5FYoTnyRpTMe4GtYqjmSjAs42hFkNCaQkB?=
 =?us-ascii?Q?CDjkk1OahO2jXWPFLECkXRHA4AdEy476lwgtecDYvsMssd0OA56sA5aloKME?=
 =?us-ascii?Q?i/zVWI6942ExT/3YapgJA9ELcJzYLldcNgZ72q2PO0CTLxyQIMDKmZcHKgII?=
 =?us-ascii?Q?LI+VoaiEC0IMJGi9vLv3B9ZJ/Ay50m2MPyS0uK+9UzvL2a7HYLJb8G1T3Tqb?=
 =?us-ascii?Q?S46CGZHPaiEJauau0nxMl1MwG0Cy7Ixz5wuLMouhFgsgjd9wVS86cuHTR0K7?=
 =?us-ascii?Q?Bhk2ER9hcx88QL17PrkzNR4dp1bM+LpDSVp5nUn2M+DKq26ax0slGnpkTIHq?=
 =?us-ascii?Q?BgGL6/kCYpcucFeMRQyQC68elqPfxq1bXYKxCouGGNtxN/4xwej07RrXyTJ3?=
 =?us-ascii?Q?zNhfV3jlcgJViAOVsycD1CfUQcENTUaXG7mtdgw9Fx6U0PphjIa965c+Kuyi?=
 =?us-ascii?Q?xgc5UnF289zLS+B/RfEPacoEqmfdmhmivedrnlRcO7Anff/X8rJtnGBJYIEb?=
 =?us-ascii?Q?OSXhZer6rr/0n2v7ByqFlu7ZUcHrkzFyY5+www95bmTrGjc04e5NSnyX0q6S?=
 =?us-ascii?Q?Z5HFV64=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8849.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?SUskMM2qlRsN7gFkF/bCBQeK1f46/tMUnlx08P/ovv5k2jaX1n5o2cf/gNuK?=
 =?us-ascii?Q?MRJbz1ePzNE5CMqHOm/eK+RbAYyZuv6wtlP8TqPq4cGrGDEatGaBNoMuBUc5?=
 =?us-ascii?Q?+maoWGZiUwVKgLArQ98IyOfb06ukzoTevDYW5K4NQmGeg26lb2jM0YU9VDSX?=
 =?us-ascii?Q?3qs/7JobD7PHLKqO4+M8+Q4iCOou4MDcVT+olBzMxCtcKGWHPzjQ7olhb5bA?=
 =?us-ascii?Q?dgsnmu/LkQGzQFcijK3hvYvwwcjKMfXwgQ5MOuybIza3Rzut5EicFmSDrqFZ?=
 =?us-ascii?Q?jgvUK1mBInL1Iq1KPd2DK/qviqLZ4zbxnd7RH42zkq8/9on+LQ3PVTMMgmS1?=
 =?us-ascii?Q?OmzI+Rl36JHR8ZtVWWDAjzn80dTEANCiVewGYzeIVdnr55X7jEq+fqAiLUT+?=
 =?us-ascii?Q?IQ7ofu3xn18/5o9mZDt8pGiYW9anNljRJImwL9jsjF6Xg1eFLBk8NwWEaDTz?=
 =?us-ascii?Q?mcLywRTS8fzH/Ymo3BCo76vGMS0Z+Is0SkPhCkfa0nv8EPlLIZWxo3Fkc0/1?=
 =?us-ascii?Q?9MdwLDfUpxZalSCflE9VSNYuPPbvemda22bdqd4YwHYBIxsetZEnPF/Gj7z7?=
 =?us-ascii?Q?Wo4hicYSg+5L6DujWJHKryEUBZClrPPcXTx21C9ePvTeznv8cQqTPPqA+Kel?=
 =?us-ascii?Q?8a1oZx16A95W0mFrQnRElYiZxtWlpid+nrf4Uh8pBo8oflWdw+9w8D5PIU0k?=
 =?us-ascii?Q?oOO3o7IOCtwMcCJDHrQqg6F78fNpOOj+ePsnaJgJ+esGtQ7bS9x64DLCvplO?=
 =?us-ascii?Q?3zFeVlc1zmYiY1vvhRTlkDnfXyakCq982e/kP/tIw9A7WHmajrAJF0tjFfr7?=
 =?us-ascii?Q?FpHgjVLUMmetDvK0bN9FON6Jxaw58ep9+NtwzRxIZOfeQfL9yS922b3PG7BA?=
 =?us-ascii?Q?2zB/Z/xmz7+d7LdmwO/HLUP/syIaCGaK1BYDF7Ah9NjRxdXHnaSnYHCmzMLL?=
 =?us-ascii?Q?WFAarH77Tl/b9w3Y3aMggc9fR/2D7UAqlmROuv173ogVmHC4d9ds3O9uoG14?=
 =?us-ascii?Q?UkorCwdOUKNPj04+W+rTt5qrXBBQXyq4PvCPFfx650ys1cSQ4OlUzIg8zafQ?=
 =?us-ascii?Q?JxcwwvREcXwkggUvUSWdPputz/5NTWkOB1ClTZ0zbNIfcHKKQ50S3sSTY5jC?=
 =?us-ascii?Q?as3wLyFwR8h7aTjb14qPTFth1gLymb2u7/2+VVahI6tAWB6O2vbs+vNEdb8D?=
 =?us-ascii?Q?RjnREhrQRG9y2hPXQAe9bQ3NbrRptLs34B7AO9O9VLN1teSMIYc2kExOWFG4?=
 =?us-ascii?Q?TxAVdD75CjNs7IT36ZXmEQ8w1HQ3qbOQR7rzUJdocupUzXgz2R7Qv5rAFSV7?=
 =?us-ascii?Q?5wYdMYcMICHQNdKfSs3StxKGWnwD2YIzVcITkmyCdKYuED8JtYRw+QX4Lk1G?=
 =?us-ascii?Q?hQCSaVMRAEmZKyVn7ewjY5i/KtR5mJvc02jHV3Xydd/u+puT+a9cNPyYPmRH?=
 =?us-ascii?Q?XY1G6aeVrIPP4AdFk50Pia0iuyafQinM8K3eiyhjlcdXiA/8Pu66tV6fWQjV?=
 =?us-ascii?Q?cKLg4PkDyf8wLGvuU/Qxd4qCLsTHwTtkDYK1FbipsC9E/UyUhFidmooZe7CR?=
 =?us-ascii?Q?w3jcazlbKd3mQeR6fDkOjRflKFmqMxSFB64WQghI?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 65fab341-8cd2-42c7-007b-08dd034eab5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 19:17:37.3055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lCXQmsrit6r+UiYhk/H1sFfWtALFuNFGaedQ09boumlATcGnvQmx5+JiOrcrdmzsR0tZFJmkmCrkVU+KtB663w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9552

> -----Original Message-----
> From: Wei Fang <wei.fang@nxp.com>
> Sent: Tuesday, November 12, 2024 11:15 AM
[...]
> Subject: [PATCH v3 net-next 3/5] net: enetc: update max chained Tx BD
> number for i.MX95 ENETC
>=20
> The max chained Tx BDs of latest ENETC (i.MX95 ENETC, rev 4.1) has been
> increased to 63, but since the range of MAX_SKB_FRAGS is 17~45, so for
> i.MX95 ENETC and later revision, it is better to set ENETC4_MAX_SKB_FRAGS
> to MAX_SKB_FRAGS.
>=20
> In addition, add max_frags in struct enetc_drvdata to indicate the max
> chained BDs supported by device. Because the max number of chained BDs
> supported by LS1028A and i.MX95 ENETC is different.
>=20
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
> v2:
> 1. Refine the commit message
> 2. Add Reviewed-by tag
> v3: no changes
> ---

Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>

