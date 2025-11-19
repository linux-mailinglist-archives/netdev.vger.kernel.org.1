Return-Path: <netdev+bounces-240045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 400D4C6FA6F
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 16:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5CD784E580F
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 15:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22114364E96;
	Wed, 19 Nov 2025 15:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gY4jzztg"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011007.outbound.protection.outlook.com [40.107.130.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837DC363C54;
	Wed, 19 Nov 2025 15:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763565613; cv=fail; b=LIOQg3CceM+gKKo9p4TNoOGVB6/H2ZYNx0wwx8vSlB4bfKJgsZPDFObX2TMQiOrxy0jeUTsIIfSKqP4OJDV0GYaDltYjuAKs2l3d0i3XZyFaWIZJZuTgc43TFkVD5ka62uNBhQUurg3zShMwrNN/p0gma3jho+TIJWlB8GZVets=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763565613; c=relaxed/simple;
	bh=O0qwcshiDSIDBiM7DV7QlPEsmZyt88bTTQz5X/8AhDg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M6yQDHgOVgkY7c43WegNa3eWOUndD/b+oF1nl9Exofi1ehABLEhDpViFU42k4f5shnaaasimps0SN0Exsdxm9gscdf5XU5ouyswfiSutiavsGe2Kg1wU/BFBPh9xB9l2fcMETfNCpLoeChVlMKhm1X+sBjVvNLKbOKC4DibfxjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gY4jzztg; arc=fail smtp.client-ip=40.107.130.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jm7w6MHg9R4WzIyqe0Ehp4zTgz5xvgAZbG8vAQwoOQ8LRO4cJ2m3QEZwYG+p9nx+jWkDwlAUwvde0Qi6zRRNu5ZnM/U0WcefE2mpM3CevN13iDcb0A078w+akEDJkDUqdgYjhzOeaJgeiBHqEO/mLBrj7IfWKVZDycQwiPBmWvYXcImDzZT/Tw75y0RB1SZx69qONHwfddwDpez+kFMsWcPJvQ73znKbf/sD+0mpRNFhJlyYwUe0KQjd7iMCtKF8qnX1O35wSP+W+/FkNGt7gZJgZ5J2YccOzcu0gNNKDYfRIX+J2x/q5MiAH4v+t0fQyeMtHgHOrE1e1nJhAvn0IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O0qwcshiDSIDBiM7DV7QlPEsmZyt88bTTQz5X/8AhDg=;
 b=PgWNp3b19TqzWS/r1qcg765wf74xc5ibNWdf+T6urJkUbezv8dWN+t8oUyxH6z7cRUIsLrCLdBUKE/dPeHG9QBAl7m3B1wPTlT9Dg1thUsU9g97u+DLJPWdHy4TpsdyAzNvGIx0f3TJGGLT/hhH3xKr3UKAx4AgJrY9J3Bts69tn1xkuHAwGEU4/eqMn2rO32RZP946FXpeTiP5tyxfeUh0B+LJSeqgoCJBE+zurKxNGZsV/pzGsp8n6OyCwM9/5R5kjUhpfrz0BEYh2pJHoKRhJBYdIU29npU9ckOzNHLa7MwIIZtkjUvelIKUYQWAyMa2DHqf4JDsC6Vo68XPFyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0qwcshiDSIDBiM7DV7QlPEsmZyt88bTTQz5X/8AhDg=;
 b=gY4jzztg87bir2vioCHQu812uRkijdZtGLMCw0VK8pKDqoGM9sMI3wvltFqUVSuRoCNwbmqbJaOcD7d/ePkUqAz2ah/mjRBPLk4UeTTdpPAWDQwn7QU4ROeKmEQ7gVy/Xjtdpa1PADH4QynOOpIAmY8PZPo2zXbiFGcIvqF/iE78IsOEOymTaGBvheN1EyCXRVpNotFPRY6XOejdt0rPtlEJhFCxhyXSY1CPoxKga6zB/+oaQIrW/DFOQVSVwPkTyKHmQ0ltlaewpJr148EaQs7i973V9xR2b1ZJwqn4Ee0PcfUf2ppdcxsUZqZVX/JC2MeLBSpgINm6aVm5Fyii/g==
Received: from GV2PR04MB11740.eurprd04.prod.outlook.com
 (2603:10a6:150:2cd::13) by GVXPR04MB10971.eurprd04.prod.outlook.com
 (2603:10a6:150:21a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Wed, 19 Nov
 2025 15:20:07 +0000
Received: from GV2PR04MB11740.eurprd04.prod.outlook.com
 ([fe80::ca5f:7e1c:a67a:a490]) by GV2PR04MB11740.eurprd04.prod.outlook.com
 ([fe80::ca5f:7e1c:a67a:a490%5]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 15:20:07 +0000
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: Wei Fang <wei.fang@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: Aziz Sellami <aziz.sellami@nxp.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 net-next 1/3] net: enetc: set the external PHY address
 in IERB for port MDIO usage
Thread-Topic: [PATCH v3 net-next 1/3] net: enetc: set the external PHY address
 in IERB for port MDIO usage
Thread-Index: AQHcWUIbn7YUXOSGU0O+Wf0pyIDttrT6G9Ag
Date: Wed, 19 Nov 2025 15:20:06 +0000
Message-ID:
 <GV2PR04MB1174077D4C8E65E3C6D78CD9F96D7A@GV2PR04MB11740.eurprd04.prod.outlook.com>
References: <20251119102557.1041881-1-wei.fang@nxp.com>
 <20251119102557.1041881-2-wei.fang@nxp.com>
In-Reply-To: <20251119102557.1041881-2-wei.fang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11740:EE_|GVXPR04MB10971:EE_
x-ms-office365-filtering-correlation-id: 0c0b6f6b-791f-48fb-b2bc-08de277f1f14
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|19092799006|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?BWWR1lLzqJrYbylgTDPrb9Ox2J5IXgAaGgLpt9gvDF3gd8IypjvwTfwCqSfu?=
 =?us-ascii?Q?5oAm69N8QMWxWkU6r81vHb3Sr+M7TTmu50RJUqH+CPbVizG+ZGCZjbFwIdnn?=
 =?us-ascii?Q?5uK3BNNkXr8/to6h/D8fRzv/dg/uiDqTdQqM3ehvhjhXDOUS6h4z7BfS/7uq?=
 =?us-ascii?Q?UIBrbDc6iSvhtwRYzB6nQQHaqqYBSqFDpTPsn+sQZ9peoFhjcy88iOOC2U6F?=
 =?us-ascii?Q?ElRNcR210p7gxoSAdIM5pQPy/4HEQOKUxzBWv++L9BYitqB/cYLUjRigEkGW?=
 =?us-ascii?Q?4nvLHw2A1zxIwIUFjRpwf8cqA1B0jVdnJI0vpzlhqCN9iQTFVW2V6G6py88H?=
 =?us-ascii?Q?QBJic5lixyPDJl7rANoj4O0IxIeiwDrNTtllECnslPfAU/AkOWo0l34piZpD?=
 =?us-ascii?Q?f/NMV9v2B7rlRzSwe9WyriCNQzYfqRJvCVZVlaVKuHFZd44AwW25n56lai1U?=
 =?us-ascii?Q?1IHgPaxPWSmuzkD+/NbBi+Tk4bCSbotIBXFzXqRk+B5s0N5QZ6wzAr8s3a7w?=
 =?us-ascii?Q?Ya6f3Y0k02gDlUurVZ+WlmROR37W52YYRAJ5KdBqEvCQMf9u8OdIFbO9T1e1?=
 =?us-ascii?Q?Cq4qw4gn9/8folLscqaZXle3n2mQsGFbIY8a9d51Ywuz7IRS1BGGVZ4UltwK?=
 =?us-ascii?Q?MBX2wqlJ8WO3h+DUkEehnV79oTWMTzsYNH76NSY9tmSJaRkUzT9U34l66c1q?=
 =?us-ascii?Q?iwOe6IHxhUMyCM2h8SCcncVBACrkyjPxAghzs3T4PYzPDf3VrS6FtOWDCs7N?=
 =?us-ascii?Q?wIfpsZ15dqSescmhTUvQmk3B2nn1QzP2RJLd6SZGDoh2wfy6QftI58Zzo4GK?=
 =?us-ascii?Q?IbvKaWp2zZY3PKSFBJcoSUL9+Fzj9DK8x7eZlJDQ1kZYpkFSA4tsAN8FF9pj?=
 =?us-ascii?Q?DUYVHF7MaYO+OvgIwyO+MuG7C31Ns2Bnv8/roWeTZFMvK6cjWzfCTUN+8s8z?=
 =?us-ascii?Q?con/luQpTkQqDseszCmM2UM2ZHqdnpxyzfUHrYfLaPugAEE5+up4hEbA6i73?=
 =?us-ascii?Q?exSj3yhHiih3YiPdw+rUjm959X3BQgpbqV+qlhqh/HCUdaKIk2x+zNXgQmJj?=
 =?us-ascii?Q?BQY0BncJIukiu+MTkhMMArqzwKx10PLpGNwDEg/fHfqK0lSqWDV36cr9BhZX?=
 =?us-ascii?Q?h4hxf290mz4U+FXOb6cGm2gGmfeu2RnMdumdWvITh/NmYO/AsKrto1bLyDpx?=
 =?us-ascii?Q?OZ6E/Qi1d8UvYjdOHylF7SScs+o4Lz/WLCKHCg/S10XsnpLPO06B57fGSyGK?=
 =?us-ascii?Q?MrLlziQ+OyboJoguLUVm1RQnXRJ8Gq+YFCQHUb+kIunKLnpveDn5wgeqNc0+?=
 =?us-ascii?Q?phX6U9k05vIaC1qyuoNwT0urEZdPxvkEqaSV4NRzzObfUW/yy3Rj+K2cTbN/?=
 =?us-ascii?Q?nk4ElXL/Gt1b7e18wSZvv14SWx7HMz0YJDiTRzi5Z5yqInUrY/odA7vy52d3?=
 =?us-ascii?Q?j+WRoxzteFIh7y4UHfhWztWWm/mGPQ1XYLGSTaxwQVnJmUHhnhbH/z84uKvl?=
 =?us-ascii?Q?tOYzcWPBELWH7hpEiLKQzaHfV0jlT5EKwlVY?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(19092799006)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Td2i6v2SxQz/4zCzJBF3mkbxElevhLvrJYh06DpIH4eUTjKNc983/LeTJIEJ?=
 =?us-ascii?Q?xg3mX0pa9qkPfUM2NjguR1pGM4eS8trsAk8fnY+G6x7JfQG4HZI5s6iFdQGS?=
 =?us-ascii?Q?C2qukgk1yrPRObDCQDBKn37thpbHFEp8zoDQANVUa0jXQXsN7vT1MAlnWfia?=
 =?us-ascii?Q?UjvPtMTHeFtHcSbjZyrrcIkjFObXgXa/DrbH5yCreCZ1jg0JD42oBg9aTRZL?=
 =?us-ascii?Q?mU8Pv9lFtNL5Jf8845eW2wYiznZAnSUVEovx9xsa1wn57AX954jknS3VFoqU?=
 =?us-ascii?Q?hyOSaxn26s3hhu/BkI2kColjWu7l1nL88CVw4EFp6ge5krRRjfAnTHJSuc4x?=
 =?us-ascii?Q?3IQ670GLLFVTnM8fCF0ARfGQZNTj1BTiibtH8hWK32xEtL8S6orVB08kbIsa?=
 =?us-ascii?Q?TsTQv8y1UvtTeHZrUJVSU8YEukFNeASmURfJPaM15CSl+zJWX7uJeCj51YTI?=
 =?us-ascii?Q?FQkOxM1Oxt4AOfs+2ko+EBQjI2wP2qUJBPhGyfEOC7rqmAHKglfUpejJe5vr?=
 =?us-ascii?Q?6ZLY3exc8mDV4/glVYJSmXxDwU/PQk0uU/a9qENwuXdNCMVzRMzULmYK9zZv?=
 =?us-ascii?Q?1Qs8NaIuZ/McE/0P9StKpe7gSSDI6Avefe7mN0YFQ1g/Wb7zTkdbhD97nKZz?=
 =?us-ascii?Q?Pd7ht94UWboD7HUtpkux620sHG2jyAHIPXY7FR4Ocizw454heeoD/8DfXERC?=
 =?us-ascii?Q?iYFHC9ORkmAJDJT4liFgBERj7B5WC/0/COZxdY2WiqCa3+jWm6SQX2znOSMk?=
 =?us-ascii?Q?/t4OqQX1xpyk+x0ZlcAVFs6DT4z9AQJmlGGDpuCo96mXWoFd6p7JAZlJo/2e?=
 =?us-ascii?Q?NoG86RqmW8irngdcBFMkqZ9TaVWRLByVJz6aXk0g19drKcVRYS4TcWTVMQur?=
 =?us-ascii?Q?Bpxz1RLkH2tHtyrlITpCZK6h6uicM3MpsBvFIPi1Zpx751X6J7roiTbWsV31?=
 =?us-ascii?Q?UQSY3GaHeg6IsrgbfYBGsHANkYlhpfTAvw32WB+OaVzWjDWLMYG4zKuF3SKM?=
 =?us-ascii?Q?j1mrlDxH8vIR9q6hsquxDgRJl4k8SLMSMjsjfsPRE4qHFSqeyRwld3MGNLIe?=
 =?us-ascii?Q?felOCXeKaU6VSTe59HWa3LS7qoi3DTPlr848yKVDKOyljvMJOfmW7R1i2ESB?=
 =?us-ascii?Q?V2TbGLaeSu7WF8zmJEsxsfuQ01DUGbUJdf9/MS9Ffzg+4VoYU9BkgUuIXyDG?=
 =?us-ascii?Q?aKkeJ0YlvYog2bwFGWhQNmlY7xu6Ej/hSvtHLiW7ljoavmwz8Wl+8slhb7Uz?=
 =?us-ascii?Q?zpGYvZO6pFCzazFfqqYvmelwEiYqKK09NUAi2D/7Znyb+kZPhqiXBdm7CLvK?=
 =?us-ascii?Q?5lrU+zH4fsHAPdUSjaVyVtIBNcB7vvpEbAlZj8ltS4MZv69RpIcDNKPvA9iL?=
 =?us-ascii?Q?ZcpO/L+rcej2vGGlfpfk9SFhVjJvUzP7OUWmo6D8MIlnX+oKx9NmFqnnFA/Y?=
 =?us-ascii?Q?U69ZJ4M7a1833aU8PU2+VK6jxFFSDC7TAGTqqhcgbBjWCA4CaQSmr0jCw/9O?=
 =?us-ascii?Q?e1Giv7Bg/smCqu4BOSBaM0tI9ukxU/UeOqf1tA/6r/wm+bY3DlVkxTpJmMgH?=
 =?us-ascii?Q?3ACKad7dFvz+93UY3jlpELTSvu5RTQo5WrxbuZUG?=
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
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11740.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c0b6f6b-791f-48fb-b2bc-08de277f1f14
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 15:20:06.8753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9YghCxjTU+/cy8nxHmeMSqHN/xN6h8spH5t715BOKiBCxvvAk8UrtAIWGBbectmZBRu22zqrpo/6d81JzRNAnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10971

> -----Original Message-----
> From: Wei Fang <wei.fang@nxp.com>
> Sent: Wednesday, November 19, 2025 12:26 PM
[...]
> Subject: [PATCH v3 net-next 1/3] net: enetc: set the external PHY address=
 in
> IERB for port MDIO usage
>=20
> The ENETC supports managing its own external PHY through its port MDIO
> functionality. To use this function, the PHY address needs be set in the
> corresponding LaBCR register in the Integrated Endpoint Register Block
> (IERB), which is used for pre-boot initialization of NETC PCIe functions.
> The port MDIO can only work properly when the PHY address accessed by the
> port MDIO matches the corresponding LaBCR[MDIO_PHYAD_PRTAD] value.
>=20
> Because the ENETC driver only registers the MDIO bus (port MDIO bus) when
> it detects an MDIO child node in its node, similarly, the netc-blk-ctrl
> driver only resolves the PHY address and sets it in the corresponding
> LaBCR when it detects an MDIO child node in the ENETC node.
>=20
> Co-developed-by: Aziz Sellami <aziz.sellami@nxp.com>
> Signed-off-by: Aziz Sellami <aziz.sellami@nxp.com>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---

Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>

