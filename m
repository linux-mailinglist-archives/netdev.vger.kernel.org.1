Return-Path: <netdev+bounces-215976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF0DB312DD
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 11:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D7801D0004B
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 09:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7552D7DD8;
	Fri, 22 Aug 2025 09:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OgMaOtRq"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013001.outbound.protection.outlook.com [40.107.162.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E3B25F7A7;
	Fri, 22 Aug 2025 09:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755854612; cv=fail; b=AOyd6UT1jzch4kgkF+RgnL5FLi9y/fYt4veWObyl3rNgpU4y3Oc+sdl7zyyKRCO8VBD+QU3/x0VUTWbtf9iC8FTpVz4PvdY0nX91c8UpkXcX5UQCatXp9lVOAeKLWMiPa8tfcu/F8phxaY5UeejvcuEvzmTh49nX4vskmenDaLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755854612; c=relaxed/simple;
	bh=JMloaz9LFGup2aSQQg4quqDA0Py306ll0kgzqvG1MCQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G+iFy8f8oC6GDQUkX4YPnVTvOOr7D9IiDh5GALjGo9nNzgRrBScmnrExcsRv1EeuwEVHEqzRdf1nJkBnp5UtHWs36pGZt9oseNo2N3YDmZCjzHqTtN7PRGPCitlVWv5EuVnxiFsU1SPy+kA2NB41UakTfG2GYmEuE01CwvTqXQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OgMaOtRq; arc=fail smtp.client-ip=40.107.162.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FwW9BesOEACHb9bLGMYhwM1kSODIpYlUHpK4MxaokG8+nJ9QfFLJTpOpInKAsgfVuguOv6NPKsDBuml+lnJXsyv9nxNCYi3SptqEuhonExQ2mpmjqLysHjtXp3GuwsFwE99fSWYO3LeL19O4fzD2+2lhGHHr1XXNCtsXpa2OQrBjeOR2WQqPhudpSDx7IEJnbGhzN3xrbUsJvrriccbTzMtHap1DDodnQhbXDMi9znE8GBRGDQKss9bXE3ZYqrfjTAxHt7DcQm7F0UCUcwKDzuaVt4SYqcuzYu4M5g+GyfwhtXZab3Fi/bxcg8UXYQDhAoxcnxPbtznIxtiUkzn0sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQavmtQHxNlgn+NciVg7HEy4CpYqafXz39ZH2IjYSYU=;
 b=dS9o16J52KQLiJmlM+z0jN0Epv8qQfRuZO+gibokJd3X46XsfcrqaLb1PezSuPwoA+QdNCpqUxv+RIpn7QfP4NUbNb2Tm47UGRF2BXpTwdGXZlXu2V4A9861P3hggExCmRb6lYAFNri3ACLet5vDpuz5qAe5JRwkQYvT90yfzV1cTW9tl0j4l1pLJjRC8TIqBHX8amM6ofc4lvC1fujctSeXthERxqIOjT+QF+W9BUqggs33oLhznPgo85mH1yQbuDeXp+OXSQ8vC7M4FkGNedGR96BsE2gVCHlTxNfjBlc2lKtcETo5eULizhRTb1y58q0RobGwin1ptm5Re80K7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQavmtQHxNlgn+NciVg7HEy4CpYqafXz39ZH2IjYSYU=;
 b=OgMaOtRqD8Eif97RhBCSeT79Td+eMMJvhVXABZjdLXdwKF8xVhCGV71lEecOuxUCtjDe4bG6Z2eT3FuLs+VlTmxJVLEqATtlRKZI0QbLP9H13F22HTyL5mTdO1TUQ+jMTgpr8qLJaseQM+gyPkwFO9hhSybC1mk9xwnd7ikK2JPB73puFz/ZqFOeYswT3JeHRcmLJvlfIGYfaEpdxqWMJSTO15yTv7UOOLhhy0EVwnqERnIy+k4WESWS/vaAv3/4wlc+/X8s5QXnLkW4ZYDaz3otqwXI2MjLNt84wFe4gHyu7LMdQ/fTBPdn8wuLrOCY6w4Fpk30OoTIR8iFZRVj/g==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB9189.eurprd04.prod.outlook.com (2603:10a6:20b:44c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Fri, 22 Aug
 2025 09:23:27 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Fri, 22 Aug 2025
 09:23:27 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Shenwei Wang <shenwei.wang@nxp.com>
CC: Clark Wang <xiaoning.wang@nxp.com>, Stanislav Fomichev <sdf@fomichev.me>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>
Subject: RE: [PATCH v2 net-next 5/5] net: fec: enable the Jumbo frame support
 for i.MX8QM
Thread-Topic: [PATCH v2 net-next 5/5] net: fec: enable the Jumbo frame support
 for i.MX8QM
Thread-Index: AQHcEso42bVXeF4k0kGuXjVHs0wLubRuXu2A
Date: Fri, 22 Aug 2025 09:23:27 +0000
Message-ID:
 <PAXPR04MB8510185162C97023C953C96F883DA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250821183336.1063783-1-shenwei.wang@nxp.com>
 <20250821183336.1063783-6-shenwei.wang@nxp.com>
In-Reply-To: <20250821183336.1063783-6-shenwei.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AS8PR04MB9189:EE_
x-ms-office365-filtering-correlation-id: 14d7b151-17ee-4fd8-65c3-08dde15d8d34
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|19092799006|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?RQW2g2YyEDCSVgYqaajQ0THBgu504TIUWSbfOBGbyrLA6/SJcgCVzIPnq7fz?=
 =?us-ascii?Q?Blr7E3gq7PABV9oqW8m33PxGvd7fnCHVpu9FNFGCz7TAjfYhKExeehNixjZK?=
 =?us-ascii?Q?5eHi745zV/UIZoKzTnlYwoaeu59Dfuls2Maum7Z3p8m4TU3b/uDayGvv98q2?=
 =?us-ascii?Q?6PDShhMn0u5rqjqyOW0E0TTC6mp7J8Lk/Aw73df3/7RHGcvIUirnG3i1+ni4?=
 =?us-ascii?Q?LWro3WZDNdqXeGkW6uyCmfYO0G97IV4AZaDO7oc0/9ky9+Jy88ykRCVxOoP7?=
 =?us-ascii?Q?iwOaSu3r2QqHpxX+gK0sj3De5sxY2Abogy7xwMdztj4pk9wvrB4a16DsiPsu?=
 =?us-ascii?Q?d0UnT7GYG7WnMS3Y7Hn70Q5lYN3ETJdFf4evVK9rvrTXhTyA8/32qM8fO9v8?=
 =?us-ascii?Q?HxOW7G+GU7+GtdMzXDWRGjR4Duu3dm1v4SB8ThZLbVm4gqh6Ym+p9T13j1/h?=
 =?us-ascii?Q?nFMM+5IfQJpb0XdXK3qJ4dr4MogJEwyblid/x5p0pzQxBD/QTDL69td35CjT?=
 =?us-ascii?Q?GDlt5N/eBWbOQ+toYqvgCG7p/Ja+4pOnqpYCTLPEjQrAo9Ncd8FH2gJ/C6oO?=
 =?us-ascii?Q?BcxmEvGCYva1muctHnqg0niATgU7TSKUgk5gaD2GBR52jU6khtBWKMX8rVOI?=
 =?us-ascii?Q?ZqPNp8sAP7Vv440Wob/tWgu0gzA9njKFAhOtbG0/ik398AZtkSGc8y1nG97O?=
 =?us-ascii?Q?Aid7XvRVduuBI4+plQ+z8XlOWbGb2zJylosDtv3MLuLK1lJcbm71pZJ+Tsmw?=
 =?us-ascii?Q?9Hf41Q7K/DZLt23YYKB29i2gkupbEEJBXQ8VDoN55PF1eWXOmf7cvy1IE/io?=
 =?us-ascii?Q?1At7HKGS9Uoc+OrZ8RknOJqCGsjG9BzIruwUDrnOBwzsyccFozZylLTWTs9u?=
 =?us-ascii?Q?l8I4nRvPpeQKDTNAkSm8ijC4tRz3QddCvsrAxdm4PzTU48FECbqj81KJQUkD?=
 =?us-ascii?Q?gxy/CGTMfuRu6pNVusmtJaY0XZkNK3/gIgoFKBBpcRtj83zBwb+EythGuJzN?=
 =?us-ascii?Q?a6Xhsm+1do77PjlPCbp5T1rCMsNnjeVY/SVemyTg3mNtQt/LKe2lJ6cVCyT4?=
 =?us-ascii?Q?/xUH3NwGCetDLYN3m9uLeW8+82aIjrrjkak73m9JqDoqrDkgP8NuwWXCE1JS?=
 =?us-ascii?Q?pBVDzqIUavzqwC1f1kEVKJk70oOSMnCM7xz0Am+vvijjbcQ8c8Lh/uf1VdV0?=
 =?us-ascii?Q?61WdmDCjBC7liEqEjnrioizrbymvpoukGb3z8DcfqC5HhUCfVTH34rk/4Pig?=
 =?us-ascii?Q?JspbE+EsZbm7Dwo4wiaKEKyljfwGdvStB7MAzaj15EWZ7KCwLFVdh/UFx3k7?=
 =?us-ascii?Q?NlynvQ8lfegt1rY7G+U4RqJxVnXgmM9Fq1PYIkNuaau7hc0mBwvmD08dtiGE?=
 =?us-ascii?Q?TuIORzYSjDnlSpCKIIZcj+uTK5Mp7BidMx9ShJH93UQdEht8eF/nrzJpeIyr?=
 =?us-ascii?Q?MsnBxQXPhkmawCKfMvIzJrAEa3Br/WgUbnplfasWaLP6yDeawUKtTQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(19092799006)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9ULkJmLIeg7nxaVZrTOfvKfPTH/4jZ6I3s4U0zEHr6ynw1hJit1gn3Wij30i?=
 =?us-ascii?Q?U76Q3+aqraMwylkd8AtA3JMZxpM4xfe4XBV39yhgBH8c4VZE6A11+/vZD0Hz?=
 =?us-ascii?Q?lvKJ6ilyaUC9GlnQ6l9AdNbCdwK0PbcDxZTgTbwUx09x4nE9p9ifkUKrXEyw?=
 =?us-ascii?Q?XNY1GbWlo4bb2JHS8u0yZAVwyFc0aISPac+lfBJsedQjhdAJL2dPtDmVRrv6?=
 =?us-ascii?Q?2BAzv6JQmNn7hJ1VM+snpMyCHS/Oy8adZ27rzGSAUjWk865lDWm60tRww67e?=
 =?us-ascii?Q?20tSnPY+C0IKxo5nIUY91DU0nAYzCAW2O79UH6uKFQxxzLzYT014lxZfhnSs?=
 =?us-ascii?Q?bQ3T/T1HCYlgoeeOrix9GB12FUrLTlDEfHWNcKymdUMf3fOGmq6NeORObl5o?=
 =?us-ascii?Q?RGWp72ltCkqzqjZtw1YIgzEdplNmuEgDn4GREcj95gWHjQdBKjlVbVAl5S+0?=
 =?us-ascii?Q?E+HdHgT1okYGr0lfwH0Po9ijxXhcbMkNYy9JqdJT5pMzUL70B3klm1ABL1Wo?=
 =?us-ascii?Q?B1MrtVdiTXDd6CysJ8dmFQPtXE6QmakLjsQs97RV76uwHj7Adqzx8psPu/Ak?=
 =?us-ascii?Q?RUX3hHJshgDwZNVzlm+VOnpH48yKG72y8/joHF2nuHhq9qgwFzsLngesCB3t?=
 =?us-ascii?Q?3YH11Cm+pDvpvjEoCE7o1aBIIVgC0OBSvHbI1H7vpdMlXxVQeSx03ry8aPy8?=
 =?us-ascii?Q?JT6Bk+lM6KM/K8AcIgRyw+BObNQx6MtgwwjQE02PeqWJwjz6gkOuEnloABTP?=
 =?us-ascii?Q?MVsWF9PrClq5p1CY1uX12GyE6EYbsgclGWLNsz8j6PHhmq8fTw9ZKdDYG09h?=
 =?us-ascii?Q?2uNRcfbMbvwsilHHWJ4tg4kqkgX2RYl01NmiC+ge6+Jxjs4AJeK4pM4dRVCQ?=
 =?us-ascii?Q?p9LyRxbfCvK8GNziZmw/15I/wJro7fKuoW6rW4EnGma8O72tFcyk63gM9cpI?=
 =?us-ascii?Q?I+uNNP0NSzuKZvXNn5u0CBxv6lqPL3tc8iZdIxm0zmDft545Q3EYZzsM+QWf?=
 =?us-ascii?Q?TuLFyiPZqz+aWcO/RMgMU1xHzVqoH+lJuFc0dyhMMVywxLbPmcYpmQqrGR41?=
 =?us-ascii?Q?GNv2DR/9OHxO2ib58SJrGLE/AEnYlWwNcjKJ8LGa0O0XkBSrW9giLqjM3zPN?=
 =?us-ascii?Q?+oghTvS/fWwTOTxTeCeZjbuFHKTvl1VEPrmCT8afqDIhXmZ76Y/K2gA3Eodn?=
 =?us-ascii?Q?55tnm9c0eYbFxnYpl+PX9nV0iv8sZBTieqZKf9+Wk8Ct7GS5Bv/+l88bZ88K?=
 =?us-ascii?Q?jeYZ5lVHNsS/odXEkYsCg+r3AHHuRFwhfqUDfJcGaxh5G678Gj7vIhsQ7l08?=
 =?us-ascii?Q?61Lb+wM0MxcNNG9B3REcOCxHbPSgUhJDPk4HooweSFsdARq+KccoPAtb+bMm?=
 =?us-ascii?Q?agbmzYPGAi65wiDFQzQDx+1XZPHZ7Etoo9WzX8ApWXMrdqYCir8LnPELZqk/?=
 =?us-ascii?Q?WkXsnKOxMeBkBCNoU8L5i46hOq0wT3+GxNY4XoOyVc7o0rVP5OWQW7+03oNJ?=
 =?us-ascii?Q?qgDMbbrNGsgCjBBLz3FtLq1ltqCdYR2Rw46+/OBwQEjpJUeg2AMCipurDe3c?=
 =?us-ascii?Q?wMpjrnIlNNgKGiyXPIw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 14d7b151-17ee-4fd8-65c3-08dde15d8d34
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 09:23:27.3575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a8JGJefyrtIw/zoehQ17EQAJpTq+UlnJcWET1Ze1ltPTeqn7rtrbVzYvyL/LxCp0hBxdReqJW/mbz0StAopyUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9189

> @@ -481,6 +483,11 @@ fec_enet_create_page_pool(struct fec_enet_private
> *fep,
>  	};
>  	int err;
>=20
> +	if (fep->pagepool_order !=3D 0) {
> +		pp_params.order =3D fep->pagepool_order;
> +		pp_params.max_len =3D fep->rx_frame_size;
> +	}
> +

We can move this logic to the initialization of pp_params, just as follows.

struct page_pool_params pp_params =3D {
		.order =3D fep->pagepool_order,
		[...]
		.max_len =3D fep->rx_frame_size,
};

A question: shouldn't this change be in the 4th patch ("net: fec: add chang=
e
mtu to support dynamic buffer allocation") ?


