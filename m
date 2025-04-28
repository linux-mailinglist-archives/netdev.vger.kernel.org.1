Return-Path: <netdev+bounces-186402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A6FA9EF0B
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 13:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B717018895A5
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 11:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAB5262FF9;
	Mon, 28 Apr 2025 11:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mSOLakf2"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013010.outbound.protection.outlook.com [40.107.162.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349F61FFC45;
	Mon, 28 Apr 2025 11:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745839608; cv=fail; b=WIq7ZpLHwaPNmrqVegTt2nNpoacwrsaGyLxa6kSqRr0056vCG62FU1IhASRr/KncxigRnpFSFQy7c0FJly0H+SxzFTN+aXYLKonHtBFqfi/AWNC2/xa4VDhFXZNts2XBpunukGBpXcqahGcNelDoT9WUa7yz6lwylc1wVNoc+jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745839608; c=relaxed/simple;
	bh=fNYtC69YVxrHp9Rc/ksTmWMMrHurnWztf7pG09sjCsQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d/PvaC6K3bszhjfmKJS6xstvBYlNKB3RU0BYd7DMABBZHNuqRcHbXNWt7hR6ojROr6n21TI5yGBBxByrhMRLuv17c46CDXxYBvXm9/Ual/TBWatPRrftJrVU5Is/7O8lSYTE9sVqtFbR2CqE1WSRBm0a9JI4bsJk9BCzX1GjVIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mSOLakf2; arc=fail smtp.client-ip=40.107.162.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mDCP3GJ7vqyR4Q9JVaVncxiZEd1E3MqOrsByqrpU3nJzea8VPcj7Y8pAFfxrqdoQoV9o3hsogTsPsn7b5Z0n67MZ6KablbGBwVoGh0lySpejimQLakn2Z7yrPmvjU2CAdpIj9BbCNY0WitD6Oz9R8EIfDLdlQeF3qgpLBrvMUqu9+hQkc/2ZuHxT/lyp2IUnrctHZCAMmXtjC7PYlTSn6oQVGDXtbaGhlKaEw0sfQccokEiEwYKXKrD1CHXYmkY+mfFcvdxrNqf19ujD3xfShXr0gmXu3WBzlx41idIWP5ld9v6Cm7a88TNwtS2GCwNFQb2rtWByI8SF+uZJH0u15w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E+/9sTRmW8QqIDEgsWdrVxIkRmWUzP7v5UX48LGWJek=;
 b=QHYqzHiWu4LcybU6C4VA8/SfiDN02BTHKigaZaBCOmVHev9qukuNKnQHQpM+WjI69Xhi0y70Fmw4R4itdrj20uN2cRu41lCGIB+20nhAr89BNMmlB5sN+ri+ofy2uL6jpvP4BTEwbCZ/sqKygfT0NCs1mhc/eEVmKFsR12fcDmcVQFH3pwX3nHhpcF0lsNmbqgndP3eKfjyPJfynsPMVYo8DJoq+JWbb/OWf2xBicZoFGYYBbGchQXCb62kLjnA3GzJt7YD7+DB5oDZxbDQoJJJ4FrLA4O8uZKrJGZRCDrSlpSkExOzaQ71GuQMN7YYyGreRFDK6fh4HP2K0RizKeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+/9sTRmW8QqIDEgsWdrVxIkRmWUzP7v5UX48LGWJek=;
 b=mSOLakf2g0rT50tm2HG13ySRyUJav06UwejuSjU1HzQnVkDxUUNXlLhDxZtnDV1kWijYTwxt9ODQIel6AvljfoWa/4BB5JouXrkAv3GXWhI1zOh0BMX6c7DPVwnu/RhPwyxsayby96Hlj9bX4kcrPRXqL8wDNhb0TIMZsEjtSIzF9MkJuXvOmcXThdCWWwj2vF5VesbLx7qPBixCLU2bE2rG8FGzPb48QWCqPck3G5bUR98M6ETNqSRaouc/5Ze091HGOCzZfI78cCNpBUDMNfNfE9iOmDKpTtfz+9NKLDysgMIjI0shObWMgVRDpHhzaLH42IPDRfuBj02jTPbfsQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GVXPR04MB9831.eurprd04.prod.outlook.com (2603:10a6:150:11c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Mon, 28 Apr
 2025 11:26:42 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.8678.025; Mon, 28 Apr 2025
 11:26:42 +0000
From: Wei Fang <wei.fang@nxp.com>
To: "mattiasbarthel@gmail.com" <mattiasbarthel@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mattias
 Barthel <mattias.barthel@atlascopco.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net] fec: Workaround for ERR007885 on
 fec_enet_txq_submit_skb()
Thread-Topic: [PATCH net] fec: Workaround for ERR007885 on
 fec_enet_txq_submit_skb()
Thread-Index: AQHbuC4luE/3sWfqf0Gwu5ESQD0x0LO47vEAgAABTiA=
Date: Mon, 28 Apr 2025 11:26:42 +0000
Message-ID:
 <PAXPR04MB85101DD9C5F45DC4BFB200A988812@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250428111018.3048176-1-mattiasbarthel@gmail.com>
 <PAXPR04MB8510E6D58457D057445BD66488812@PAXPR04MB8510.eurprd04.prod.outlook.com>
In-Reply-To:
 <PAXPR04MB8510E6D58457D057445BD66488812@PAXPR04MB8510.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|GVXPR04MB9831:EE_
x-ms-office365-filtering-correlation-id: c48f666a-e771-4138-4f5b-08dd86478d3a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?byRHREHoJOecTJMJC7VdCAF5yjYpsA8wZrZcvEId6Fge6blGK1E8h1q5TveV?=
 =?us-ascii?Q?rtnFUr2BDEo/tzqM0M31plG5lGyIv3mQuvmSb1R86eu8xU3QIgMPZLNLHr2g?=
 =?us-ascii?Q?jjCT2PnoQuR2/Qydb9WZ4zTVTbAsF4RtjVqxFuBI/rpmRMhslBpLFDar421c?=
 =?us-ascii?Q?JBsXUpVwU7HlOqcajKVscnzAgLoaKhVh0KV5oZMQ8Xr+ChJzVpbIy8iQv0t+?=
 =?us-ascii?Q?CzImom5/zyEZz5vPk5UWASanXObRgrBWOMzO7qhfDk9Y909pnlFS7WbWH4dD?=
 =?us-ascii?Q?h4b38RBrpuFyVH79KEHgcA+pwjaNtpluA/JOlJVn6M5cgRs3lUxEFf5DQFFq?=
 =?us-ascii?Q?Yfv5icihwVdjW7IhvyIrF5sUZfDnTCrAWtTq85clDnKxpw8FIzjQOieaU52i?=
 =?us-ascii?Q?iId1U8KgpGKL9q28WmDQaIMqTT8S/qcLsJ7zl1Pu4lGx3SP12qkMFiVFbyh+?=
 =?us-ascii?Q?eINb75Q4uqTaxtqpD7PHSVbiHlS/lUdqm6mLzY77O/2oPNYcIVNieJc6Qb+J?=
 =?us-ascii?Q?vSfGW6nuEQDo9ySGwjQ/fHfkKjcZ/9mFXm8WLKWZ5KhCIwpVClCMWQCMM8KR?=
 =?us-ascii?Q?wV1CbbHXBkTgGDgjim8pipnDwOKDMrXDHNGV5sTV/JQGxvJhKqwRBuXmYfKa?=
 =?us-ascii?Q?IdlZ4hLEYjaRPb26Pb4ituumrFdqiuZqfwxY/KZLCPiFj/E1802nI2psuFBd?=
 =?us-ascii?Q?CPNbwMFDtlEyFrGfERKaJDlZeijgekkwS9zJCtDGKYdxpDtQXgAn3dSblTNB?=
 =?us-ascii?Q?aQvZp/eIsNh5QDaTCbd2yb5Rb7um/FJEcumDbmalbfEykee1Hej2KfRnsZXC?=
 =?us-ascii?Q?Ov4Q3FpAH5DByXWi4ak2vZddKdwi9w6W0eK9JrT/lLsLRHor6s7Sa0b2BWvr?=
 =?us-ascii?Q?Kf1cb/uwGN5CHAEkciW9CTR2919el7yUdfyC8/PX07C+eEwO3EaQ64bmtKbI?=
 =?us-ascii?Q?2rnqMuZGufi327aYwuRGKcS+lU9EUk/r3RZ2u8RCsJ1vCllBrqbQayH4gsZS?=
 =?us-ascii?Q?AqBOn4wvy9C6vxVfCWM3skmY6Ay7bDn9uaoO5Y5Od6oHj0Jm0LAzEP3IJXXu?=
 =?us-ascii?Q?cfNah7jyIMzT+wdsTVwMHARxl0CJ+SLUBWha2mngrMxEoWt8e6hTsTDcfapI?=
 =?us-ascii?Q?MXsDzIwL6n4xkwvuhKY+69cYtJ640s4WluYlvZpIBhtPyZGkEmTaZX9LipAs?=
 =?us-ascii?Q?mvQUbJhPA0J8orW6J6yHde6y+cfOTKcJ1Vl0mRCXQTWLLQhHO178IRbptdOm?=
 =?us-ascii?Q?xw6FADle0HYN0RYNfRizE5UH436MQCj4dROHIxP68LeWwxhjtTyGmYSFKgAg?=
 =?us-ascii?Q?lYsiDqm6HP6CwkJVyNOLu0+MCccFBikAYstRmzSKebLWl9e91+pA8IojKzqj?=
 =?us-ascii?Q?Kkw6OyFBfDp/4+wyjttG06f2U0HnLOIsgM36acG+hOHoHy818S8mHXV0+PrD?=
 =?us-ascii?Q?AmWa6fiaLTP5o2/sfKPbfjIcRI2CENE1bx5L2qtvGoWZWNSHd3ZNDg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?SRiK796oMuyZQKK9T3wUBWZiLSkLlj+lrtDxNKt404Qsp2xbgnA+NOwdJrCA?=
 =?us-ascii?Q?K68+1Oh1+zxVBuQN5ky8d1G+CDOCfJDmKb4pcdFrdRHlLBROILCKbJoPlhYq?=
 =?us-ascii?Q?oeA2yuf4AgB9F7/SLoT3LIrDwkvMlpFb5LqioX3sqoxXwaUfyJi4bxDRv2ND?=
 =?us-ascii?Q?Yu2jkL+YliSu3Wx40jpzBwm7yJFo2b6/7WN0Q51nSvDISewVrzllHbz62xrg?=
 =?us-ascii?Q?pOBCzQE4Md+RK0TZFBJEh6Ns8JuY3I74Rut0qaiFH8IVgB8Hq5ZE/l4Zc8nM?=
 =?us-ascii?Q?lVsAyuEOoWPv5hW2/MUIqA02gXgoVGKBpcf7BSDdINRNzdzA6Ry7lpHbo1SI?=
 =?us-ascii?Q?7dUY2Iz8YK1+sERRrhYs+L4f2/7lY7ECr9HByRRc+8AhMa8mAifGyMpAIMMb?=
 =?us-ascii?Q?dPACZcqAja9lApRaatxptjIWzccG7djS4DUKS9SVI6Vs4OU/fWASC0pPxHi+?=
 =?us-ascii?Q?Ysgti2F0gwDQULn2gUlESmFn6AfoYyjkvKX/YQpHlDazbyoTDDPjjS9xdAbH?=
 =?us-ascii?Q?G2yf83Ij8tiDrs6ybIaqDVr9jbFrOy271ENqujT4OOmfHX6idsRdpSLO2qYa?=
 =?us-ascii?Q?Jw3D5W8n1g0FTCA8vzScPXZ9tAjinzkcC2UV7Tvt9fwP9ugioPYMMA110Uh8?=
 =?us-ascii?Q?j4LRzzjD+U3YmFUzggOCBZV5zBRZGJ0zhmcFDWCY8GWCIKUOwDdvFJZvL/4V?=
 =?us-ascii?Q?LN9MkI35B6RALMJKv58rKEtmt/Y+SQ4ylWmHqcbxui9uI7QH7jVLR4a6xFnl?=
 =?us-ascii?Q?450XbS+ytm9dpc9cVGuRSFhvZRzo/K3bjuJejuZfc1KZfHQPqwnc15OZ9njm?=
 =?us-ascii?Q?911f7HYJIjZrTnUzNE4wC5FZO5iXp5GEmceB4zI9Y+t4uWZ1ADzH7Qb7k0mw?=
 =?us-ascii?Q?bSfkV4F36SSxUdl5OW67yG7iMvK2ITHMNwYiCK6bIfUJz8SJ66IHrZoL5QPT?=
 =?us-ascii?Q?X/kshyQXu410o8xKfOSZtHT/BLAfKuvXx7AmetTZNXE35X2+GgZc+patBMT6?=
 =?us-ascii?Q?hORzaHfSlVp1pIPcO1OqO+NcLUMe6f57RQ0ei3F7EyWjY0tC/Jy8yR47U3UI?=
 =?us-ascii?Q?coiGk1+UD4BAPV/Zfvp7JGR9FKpyk2OYKX6tOzS7vVgu2Yi0Ge16Xlh/GQIr?=
 =?us-ascii?Q?c922fJDgcauwXbOmpW4V9SzQDK7lLliM1lMDW1nXhW1ssHLysPvsNy50iBQT?=
 =?us-ascii?Q?mgN4d7Kcl90Jt/Urp/6m0A6Akb0Jrj4LndVRC7WRq2/lGRtg1QtHa9j0jxRP?=
 =?us-ascii?Q?dCmZtwShbXaBdqxxbyQ1QDSS+1dkyni0uGJqYDW2f8Z8/Gs5ybDbCO5kbNWh?=
 =?us-ascii?Q?20KoefjqzG3akj7BaUI3ZuDwn1biHnl+hTc+tahCO4Ced7m0H+qq8k3RB9jJ?=
 =?us-ascii?Q?PQZ3cfRvwRLM9cplZ9Vazutgz0MdAl/gUDUw6CZUa8qdGhK40Sfo7AO+lkY1?=
 =?us-ascii?Q?EqmU7NU9yuiVsULBYLnYjWNeKfPcpxNte/kvilRtWG7/6MUsF0IvSvCNbQ3q?=
 =?us-ascii?Q?BD+TVf1mk9mwofUu5jvlK6dj3cjFKBkJld/gomqXQNucnwdkGeJBVgewjgyN?=
 =?us-ascii?Q?HKnR/scmtlBGVTJvRb8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c48f666a-e771-4138-4f5b-08dd86478d3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2025 11:26:42.6286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GMlX/EHNPxSWy36LTDh5pYVGeomBvXm26htbyg7R9vYaNcRwmzjFV3cQ20j5oBdhVxDU3Xa54IelkYXR5/9VUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9831

> > From: Mattias Barthel <mattias.barthel@atlascopco.com>
> >
> > Activate workaround also in fec_enet_txq_submit_skb() for when TSO is
> > not enbabled.
>=20
> Each line of the commit message should not exceed 75 characters
>=20
> >
> > Errata: ERR007885
> > Symptoms: NETDEV WATCHDOG: eth0 (fec): transmit queue 0 timed out
> >
> > reference commit 37d6017b84f7 ("net: fec: Workaround for imx6sx enet
> > tx hang when enable three queues"),
> >
>=20
> Please add a Fixes tag before Signed-off-by tag, I think the Fixes tag sh=
ould be:
>=20
> Fixes: 53bb20d1faba ("net: fec: add variable reg_desc_active to speed thi=
ngs up ")
                                                                  ^
Sorry, please remove this space when copying this line.

>=20
> > Signed-off-by: Mattias Barthel <mattias.barthel@atlascopco.com>
> > ---
> >  drivers/net/ethernet/freescale/fec_main.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/freescale/fec_main.c
> > b/drivers/net/ethernet/freescale/fec_main.c
> > index a86cfebedaa8..17e9bddb9ddd 100644
> > --- a/drivers/net/ethernet/freescale/fec_main.c
> > +++ b/drivers/net/ethernet/freescale/fec_main.c
> > @@ -714,7 +714,12 @@ static int fec_enet_txq_submit_skb(struct
> > fec_enet_priv_tx_q *txq,
> >         txq->bd.cur =3D bdp;
> >
> >         /* Trigger transmission start */
> > -       writel(0, txq->bd.reg_desc_active);
> > +       if (!(fep->quirks & FEC_QUIRK_ERR007885) ||
> > +           !readl(txq->bd.reg_desc_active) ||
> > +           !readl(txq->bd.reg_desc_active) ||
> > +           !readl(txq->bd.reg_desc_active) ||
> > +           !readl(txq->bd.reg_desc_active))
> > +               writel(0, txq->bd.reg_desc_active);
> >
> >         return 0;
> >  }
> > --
> > 2.43.0


