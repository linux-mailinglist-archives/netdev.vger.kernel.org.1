Return-Path: <netdev+bounces-216795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EC2B35375
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 07:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 54C6E4E3D9D
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 05:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CF12EFD89;
	Tue, 26 Aug 2025 05:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BGnJFZTx"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012008.outbound.protection.outlook.com [52.101.66.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFD22EFD9B;
	Tue, 26 Aug 2025 05:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756186833; cv=fail; b=E/TNzWh3awiWHBTMJMTosMttVYvFI3syWevIyHu7rRe2PAuh0ZWt1f7ddKlMBIkJm6mcpsUW52wvDf3dWO9AfbCZA4QbIFR3ZCHf+rYSPSHv+XIaU9oreI1FFBaRkviLvYgnZ13c8G8t9A+VfZ+ABfSNjnBgNjnloRnzp797ncs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756186833; c=relaxed/simple;
	bh=no4VtWwFLjzIA20NEBdFZOvWIjIrl8Z10//7QMR2cpQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YHPapXRKy2pP0Y4SNICVrzZ2a7MHVUDh+wogLtEJ6f9gF4zFIjEZ2WTvnGcyehNpNnWSlYnM+V6IrmGgZ3kakMHaJDBH0GviXsh0ziuZ7RaQmlCEbPQle8QFSVjfwB/u+qktm0cYUD09lGocWm93E4vlBxgftWBvdrsHxYZg2UM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BGnJFZTx; arc=fail smtp.client-ip=52.101.66.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Epq9ZpwCrQGGVT9DO9RlY3SomZKOFg6h3exmM52WcfOI9PIqaQQyLKh0mn/hii+SEIG9FYmu0yFz6kJbzvtPW4dXTcXnLOJm/nwRMZKF3q0txdAx4n9rHg46W7AplJtGl/RfKIoGUtk6a0QA/mSzMtxB3fTGYUFpaHzxDZKN/+nfmNruVWCoI6hQIQ4Wrmqmwg+nf9iyuea4CYUdNaDjsVlsDnQPtw+8NkoXtgQB49rI5jmRnveo4/ahwEeL4Aurt/KEU9c+NGS8hZ8kZDBQLrwpleb7NwNvCl9ZQ1SMdio6gdSkTSbCG2INzasI50scxaCrhvUUiXiUWORC7KFBIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=no4VtWwFLjzIA20NEBdFZOvWIjIrl8Z10//7QMR2cpQ=;
 b=Njc/RA6MI8+/AOur/Gp/NF5w/y4v1zlPiWnpVrejejCn1GuROdM6OCmdXhtkRJSe3qkEVtelMIC6/8wFFGT8aX1WeGC9dmz0vlLgRt2db3KqLf78acgcXtlmVb1fmKukxSVP/asfBIqzTxYnuYuYQqkouloIKvTA3DhH+5x9xdsTsQOgjHsOcVgKkZ3msboE4fENVPvndSkx2dGVDpHVb04gkeTHQmHaWwxRhSAw3Vs0vjFX94S7byTNv9GxpOPvY/VNIoJQZJBlEsZALxYWdOGdJusEpbBdQvEX8Z6TwO24/HgDCGmumlGUxBCvjn3y8zwLT8EMr6rNQzyi857ASA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=no4VtWwFLjzIA20NEBdFZOvWIjIrl8Z10//7QMR2cpQ=;
 b=BGnJFZTxy5Ul3rD7ZxRJnQWbRu99n4Gm0M8spCuN0hmlAMmfIkEF23nL4jS0eIoaWD42CkwvtXti2CDDbhIG6Tn54ZxqF/7AOyMW8MC6vOdi8SQEdUd8Q+/iPvjHPqk/e70lc6LBQJImmAt30/2Eanku2BAQEAkSd3vnsQ3ajuuNdyQdRrD6dCk+4hGyIkhfjx1EyVcfaqOz13PSpNp4wRpvjHZtxQEgQ1IjEEdfMPmCoz6+Mgo9PDC9OH1kt3pdmRF4y7h9DSeayjGNhEkw2r21o3zgATU0YIKZeULexlQTYUpZWgayYkGO3VmCpfHg0NbVnXO6tOUudCFtNVOaGw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Tue, 26 Aug
 2025 05:40:26 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9073.010; Tue, 26 Aug 2025
 05:40:26 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, Claudiu
 Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, Frank Li
	<frank.li@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "F.S. Peng" <fushi.peng@nxp.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>
Subject: RE: [PATCH v5 net-next 08/15] ptp: netc: add debugfs support to loop
 back pulse signal
Thread-Topic: [PATCH v5 net-next 08/15] ptp: netc: add debugfs support to loop
 back pulse signal
Thread-Index: AQHcFXnupsutikaYzkuyKhdvIsZEv7RzTtCAgADcFdCAAAqSgIAAEvxg
Date: Tue, 26 Aug 2025 05:40:26 +0000
Message-ID:
 <PAXPR04MB85100D1DF289DE8BCCC8D2A18839A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250825041532.1067315-1-wei.fang@nxp.com>
 <20250825041532.1067315-9-wei.fang@nxp.com>
 <13c4fe5a-878c-4a08-87df-f5bb96f0b589@lunn.ch>
 <AM9PR04MB85057F4330081C86176805E78839A@AM9PR04MB8505.eurprd04.prod.outlook.com>
 <bb07efd0-d429-4fe0-bb55-b50b77e1cf88@lunn.ch>
In-Reply-To: <bb07efd0-d429-4fe0-bb55-b50b77e1cf88@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|VE1PR04MB7216:EE_
x-ms-office365-filtering-correlation-id: f5b83642-1077-40c9-b101-08dde4630f40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?f4l4JJIcmNwN/SyDIAMnIkZD5TvgkUCxp8EaiJqkAJMsjE/GES+5kX1EyVYM?=
 =?us-ascii?Q?7C0pVC9nbCibL4PDwpWaCjjwTYmOe7II499yAaw6/cx6PT8YaOWU8aJKmoSN?=
 =?us-ascii?Q?cZEhbuk5sHAtZd6N1wGUVKoAPpwziqpulIVy5hm38bcNrXW1vYX5aH85B8/C?=
 =?us-ascii?Q?BZm4NPHnixPehRc+qJmo8s6VciY068753IfrABL4RK9cHWATlr4OI7i1RHu8?=
 =?us-ascii?Q?3qisJUQ4DIxxLWtrKZA5COrPfemB2TKwFIKRCAv+S2x8qD/IgUOsmRMLFuud?=
 =?us-ascii?Q?QzMcEu6PYj6OSyWzG1HN3jLMwkBzgQP6FM9PuMaq1mvzGx7vRTSPTZgMDmzd?=
 =?us-ascii?Q?EAJqys7Txq5XWyRs3Z2hKkH07j5dJ6gLfaYYlVfB3qdkxxCvbyd7+bOGbM5i?=
 =?us-ascii?Q?C8yyrv1N9jnCEMAeSHf/wcEkHoZQYc28vMSZV6bXB1h8iVoIBq0rZiFUWkQx?=
 =?us-ascii?Q?7BD4EjZz2BNlI2o5kVNPGTvb7s9CR2ehSKq0gTeZPfSF7kTdi/Y7Up5VID6y?=
 =?us-ascii?Q?E776iVnUoQUip/U5az/0Me4qnzxPRs+Z9YjagN/VBTnRhF+qA0iD4apO8gNd?=
 =?us-ascii?Q?8MfYRhA/hzukrJ2xnzCynRwa8ZWkYVCUmX0+RhQrgCbxW2V5fqmPhgVaEwAt?=
 =?us-ascii?Q?fkUkj5T/+sJCV9pwnqy/WfkpTx6Yscs5Rw7voVw4plYtDFT5wQQZCruyGAO9?=
 =?us-ascii?Q?o7jrJljZD+SEPf8EYNuT8WltRHr2BF7D7Etyk9RuYLhB2FIyle7JRP+LiWCe?=
 =?us-ascii?Q?Qdq+gNtGz82/w/ZHijpQvhFuyk4RxC3IRgswrzUSHPYXF091o1ZYDX3uO+Ue?=
 =?us-ascii?Q?Am7kcadizpfO3R/kYYOhFa+FRj/Xh5x5wxlY0SWm41oApn6oP88HT/+IyUWv?=
 =?us-ascii?Q?s/WE41SgX0pqbUFaqD9SqHtziBLpPgTtVFm/KoWYSyiCVMl5wfP79Wf2n8G5?=
 =?us-ascii?Q?0ZF9HY63ha2tAow+Qb2BXhy+zEs00WWttbwFBWR0M6bj9cmw5SO+fA8Kq3D1?=
 =?us-ascii?Q?OurQYtTpIkXOZm8NqMfI4oLHiYFK74ukU8fbl8HxLChCQGV1VbJixET4V8sL?=
 =?us-ascii?Q?nFslyQ+S+sOvTuALKz76e4dJ7sX27qTnzOpaww3j42f4XcSiYlneJpg//u4X?=
 =?us-ascii?Q?vnNuNsMp7PX0/Vjse4mK6PU4UA571egATQm0QLWgH9bf+loYla7qoj2mfw1/?=
 =?us-ascii?Q?wiJF2lvwyv7gF3d1IQzNVFJLkecseZGVffHuRU2N+hcx7OKVJEpPv8mJSn65?=
 =?us-ascii?Q?+H+a5o+rY31vJ8OvhYduKdny2LMZBz3fh/Nmx+DYD/Q5gI34jjxK/530Ejey?=
 =?us-ascii?Q?4qyGKsCFj0uamQCLbd2MxSbrqw2aWAlC9x2VNfGGi+E7cVPSgYufhApyYBXo?=
 =?us-ascii?Q?6rpToOgWHfsdxQ7d5jXhSsg8dFwv61aHCDjrnjTqdc5QXeTbE4SS9kZ93YaJ?=
 =?us-ascii?Q?wdg4LUl/fSvzc8lOt+QQmHdHd24nVzQbKwwm30Pao8chmz2xA3ATXg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Qzh7GK6KasDRsEGOJ9yRMnFESNPYBErOd7/KyCJrEfUdqNkYG2oexAXdsL/3?=
 =?us-ascii?Q?rPiDNJspwZTJqTTI7v9HFZijdCi8VY3C67pPmlxd8roDs6mluJstujo7JfI4?=
 =?us-ascii?Q?YVuCLCno6HpnalJPnzB5NsnBmn4kkuZ0NtSs7XEfqlIqzr/LS5qR5IuRYhqO?=
 =?us-ascii?Q?4PM7iI/ejcFsNq3Kp9gLNWTRKKNcGO5wttHE2KJ+SNgbAqgvQpQsjnZbwqRu?=
 =?us-ascii?Q?Rsi29KPiKAwHAdtIe89wrBRYHmToaNlxRXi1FxHr8buB3TyCEgzh75fmymU3?=
 =?us-ascii?Q?hEgkLGBDJZsBiHdTOIBE3uWG/2ijJ3hBy/Ykq1HXbp3endbkP8HPhfNW6I61?=
 =?us-ascii?Q?KX/OPyhKQ0oUlkTl7GFfpG33yTXc6CBlAcBfO6vJ3OKaBevZ+Q1t6c2ZooQ9?=
 =?us-ascii?Q?IJaO4Yphmk15+PwO0Banff8+UcEdcNHzdenItk9MHaEUiCjoADpPklIJJZWp?=
 =?us-ascii?Q?zp3oUZxEXaWFFGrDknIKCA2vB/tIYpBe/DUjY30hynTCdbAzjcuv0fS4NQhu?=
 =?us-ascii?Q?+86ksuM44TgUNABZ8NxXR4/4vo/1Fjv49s7qg6zHe/z129BOtCcMZDcXt24X?=
 =?us-ascii?Q?Qp6o/RsGFYOMg3c/a6w/yx367EeZ9vPlUUGPGizaf8cB6+KQsMeb56QGK0xH?=
 =?us-ascii?Q?JghBaA610Bvt2ZLWvsfYip5dHtod5QVTzjiZQu+ts7QUINso/6/+V7qie1Ua?=
 =?us-ascii?Q?pdcnndU/okuHXL3ZGA47XyPb4WCMcA+pJcVKN5IZUueUSdJvLA2IRjP/6Yra?=
 =?us-ascii?Q?PRAw8pSn/4lL8vp8JjB9HIM3eDSkEiKCOTcOaV7cmyHw9hUxkVOSDJFRDa6N?=
 =?us-ascii?Q?Ia6X3fpUn2YOTIsNpC41MnMD77F6kYKkVBz4P48YsjB70zGp8ObN/4WU6KGX?=
 =?us-ascii?Q?uQCMv7q9Hg/sUpknL2B1w5IXShKb8idzm1Ruo3jse2QAVRFJlFcfW9Zg+SYK?=
 =?us-ascii?Q?iTZl0q1VHvJr4sWU7k3vE2qcb4q0VoO/aasJ8Z10hxan2kX5axaD8YZgyyxJ?=
 =?us-ascii?Q?iqPRzp+cPxg5mHzKk85azX6Jaz90rAdJIW+ZKTHQ2c7eMl2gtRNn51xh6vT1?=
 =?us-ascii?Q?BDGm0DbZv/sMjgsvDL1o2rTmyW0mRNq0WxebYTZ/bdZDMwsLpmv09K4VK4Ge?=
 =?us-ascii?Q?VrwgrZ5yc0o8DnVqddNFzbZM+avltRf/yW2sBdX9GY/gbEPaQGAtF1Q6Sno8?=
 =?us-ascii?Q?XJ1Qyh+aDM5QE6b1BxV1kj/08rBFMT+1gJL0lQzCqQmGy804se62w5UFOXQx?=
 =?us-ascii?Q?iY+p7ZdWq3fN8XFpTnhoJipdfjppbPLJuo6SGhhAZBcflR8a6ubNxkjQiCKR?=
 =?us-ascii?Q?GGb1PMSHcCxchRvwJGamG1dt4sCY2+gGCbjSLqBiYemT8XgTGNBQ36Aovh9n?=
 =?us-ascii?Q?AozXPdzvgnq3PQvnctjmoBUsBfxvCM72XHGS9e6QYhMQgINPGIip3DGVEKqT?=
 =?us-ascii?Q?3omsTnOGtX4/a2kiiR6kENARqBWtHpL4HftYvic6NfxC1o3Bh2OAdgdcaGmF?=
 =?us-ascii?Q?tF4hb9fq/JZUfE7h3KeBqZgviaz5EVd5sRdLP35KBR5FyzyTiPxAAhoJLQhO?=
 =?us-ascii?Q?I2TIyevD9UwwXgu9Rfc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f5b83642-1077-40c9-b101-08dde4630f40
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2025 05:40:26.4781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HDZNR39hE5siczORQoDTx1JFu5Upr/+GlnVzJQGecNhO58ayQ9saTO0qhYLkbDZKFzOJfedN/2HUXHoxejnpCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7216

> On Tue, Aug 26, 2025 at 01:50:06AM +0000, Wei Fang wrote:
> > > On Mon, Aug 25, 2025 at 12:15:25PM +0800, Wei Fang wrote:
> > > > The NETC Timer supports to loop back the output pulse signal of Fip=
er-n
> > > > into Trigger-n input, so that we can leverage this feature to valid=
ate
> > > > some other features without external hardware support.
> > >
> > > This seems like it should be a common feature which more PTP clocks
> > > will support? Did you search around and see if there are other device=
s
> > > with this?
> >
> > Actually, the NETC v4 Timer is the same IP used in the QorIQ platforms,
> > but it is a different version, and the ptp_qoriq driver is not compatib=
le
> > with NETC v4 Timer, I have stated in the patch ("ptp: netc: add NETC V4
> > Timer PTP driver support").
>=20
> That does not answer my question. Does Marvell have this loopback
> concept? Intel? Freescale? Microchip? Is there anything which prevents
> other vendors implementing it?
>=20

It's hard for me to answer the question, I don't have the RM of other vendo=
rs,
and I also searched the drivers, I did not find the similar implementations=
. As
far as I know, the NXP TJA11xx PHYs also support the loop back the PPS sign=
al,
but this feature is not yet implemented in the driver.

This feature should be easy to implement for most vendors, but it is only u=
sed
for debugging. I could add a generic API to support this, perhaps through a=
n
interface to sysfs-ptp.


