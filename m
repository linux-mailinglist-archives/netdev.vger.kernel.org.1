Return-Path: <netdev+bounces-143132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6349C13A5
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 02:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58D5FB20F24
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 01:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E9B9454;
	Fri,  8 Nov 2024 01:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="H74r5Ya+"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011028.outbound.protection.outlook.com [52.101.70.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2740629;
	Fri,  8 Nov 2024 01:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731029539; cv=fail; b=a2EfTGVu88jq9Y7UUsvdYPEckn/IbmOEhfUafHVDAyrLUR1KEHAI2sZsVV7Tory0ljAe8WuQsAzYhtuZBl4oqzaqmaESBHsonLFLteN5C64T651u6FZQidB5TkgYgfA0GIeDjwGG7OJWSzP7DeooSYgUD09iEcbS/zqrdXrbFaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731029539; c=relaxed/simple;
	bh=iHCmdnR+8VLU56CVt7sbxLQSNBHS0s84DGRcRL/SFgQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dLpf90XoY0vKaIc0qsLac0Lvffc5z1GTZcqSAF/bc61aU9YIMFz7HSgR+0Ujmq+huHlpfvOiJjZO6pwADKR09Hr+y+dz1OvfWLomKx2Xh7akfopEF+VWP3SH7iNoC2Vhp0DUDpB+Bm7UxRwjE+LmmfhTQZIUc3ZjfzogKyXKH1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=H74r5Ya+; arc=fail smtp.client-ip=52.101.70.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UH8Gf3KDHBrwVQWYKWX5LWVyGQhzTuZMjxflufw8WwFqPfg8+lyy7U1ir2P9Qo/ydICd6W/HAgZIR06wNAOQdDjApNku1n+4t/LQ8DkWfqSYu1NYRdl5txN/aDXgODUAOg1bLy8bSkQqfZEDR48010IgjbVj48PyWI8X+MNeZOnlWQIY636ndQJ3BcjViw+z0T4x9IVvDLieaPKsJcI+FLyRJvfDhmk4HqOU6ZcZ7rXPqBj/LmWC+2SBgcbCOlQpO5kRrApFcd46DAZxhnmLwIgEwtFAynh6jbUa9ifF05ia7EBbm6VHIe+ESnASzmPX+DGwH9dMEKAyb+BZKN0kzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oo6ixDvruXxLs0njJX3UyDD1xjcuAey9uprHe6L2uRk=;
 b=JABIT+wU1qswMwp2nt0Rr4eihagx3ZmCabvXXmVcD/9vi9W9xEMk1um+1tkYfmw1LiqWyKA6NbcOo+D8/YGvjokCiLJ3HfSFKGZi10viVHI/3gbJ4J2c6qOkcvFLiLcBj0Tje6+cXBzT8E9Cw3hVoZm3rPebsuBf+jYbupOdaeppKV9WuGrnn3s61Kq4IaIKk4DwKrdy/gctqmQL1k6goUYJ6VNayZibyrOJ4a3hzmJ+XZZD+MsniXqfQLF8gBufUvhS1xvcMuxgsPuNPvZOUnladHSu7x1U/+buBdijW0S8/RbBaQRX3X0lARMP9TZzJm7QuqVW5lcG0lZ3BQJqvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oo6ixDvruXxLs0njJX3UyDD1xjcuAey9uprHe6L2uRk=;
 b=H74r5Ya+8GiutigxNtlufWD/vA/YT8Wlc4z+Kk4z6sIFqiPykdsnTC1rLbAmGthSSNn0nyKKWKq+afegTHHv7YCEQ+61i79XDPrcQRyolzF86dhxyIzqhkMf9CN1uXsh8Ergs94CecagEBZ+l9V4e1i0Pb9qMDpP1/8GIO6ixmxQz9DRc9XLZWzBrkb1Vj0cG3TJb7JEChOMitCawHX7toHheN29ow/YbIT/gajEKCeVY9PBF8pZ8c1z4mrzMAWQUpT+G1YhyQ1VCvJ36KLijPb+oG9sNNI5brsNwWDCvw3RFZviu/ao8V3nidKiU75NVn3NvYp8EjIIIFdvbyPQSA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GVXPR04MB9949.eurprd04.prod.outlook.com (2603:10a6:150:112::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Fri, 8 Nov
 2024 01:32:13 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8137.019; Fri, 8 Nov 2024
 01:32:12 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH net-next 2/5] net: enetc: add Tx checksum offload for
 i.MX95 ENETC
Thread-Topic: [PATCH net-next 2/5] net: enetc: add Tx checksum offload for
 i.MX95 ENETC
Thread-Index: AQHbMMitXdpNN9Aj50S2d7KPJkWYBLKsAt6AgACV2FA=
Date: Fri, 8 Nov 2024 01:32:12 +0000
Message-ID:
 <PAXPR04MB85105409DFD9E82A8EE1528B885D2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241107033817.1654163-1-wei.fang@nxp.com>
 <20241107033817.1654163-3-wei.fang@nxp.com>
 <Zyzq6RskMsXer6PV@lizhi-Precision-Tower-5810>
In-Reply-To: <Zyzq6RskMsXer6PV@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|GVXPR04MB9949:EE_
x-ms-office365-filtering-correlation-id: 10282496-26c1-46df-e3af-08dcff952bbb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?pIalNYr+egXfmlsa45r7lzitNTBTJld1Oo6AnUHGenW9I3icO6oENJZwFc4h?=
 =?us-ascii?Q?GNenAXIJb9mLgtXYvNc5z1yIa7YTNiHW4Hg6H1m1B5DREF3p58ZB3Z7M20rz?=
 =?us-ascii?Q?kpyoQNNN/EAon/u/Jvoz8NGLd41XNp2QoB7LSr69J4uAaK/D7R6GzwmgRHw/?=
 =?us-ascii?Q?Rij5CvfSQL0EA9tA7UuKGMMPe1OJrT5xuiP+cw41qUjDdCiKwUU4W0axgnaV?=
 =?us-ascii?Q?bDU0YWO04FOLtaFXywA2YUzn68KAcVuwsUxH25ELCC9MsGOWnDsLotOxsGOs?=
 =?us-ascii?Q?G5ixxLHZG5MGFJyQmVcw9qrrJaXBKkFm+9V/i4ju0/JZmEQSryUP+DJs/nN+?=
 =?us-ascii?Q?cwJZ4yjK/Wn9KCuZ85rgiWRqMyRHGoWozSluu+Xov5kGw5LeNDuS3DDgJz97?=
 =?us-ascii?Q?P2kI2lvdzjByC18utehnvnoxg22Orf5bo8u9o4UmVhLSMX7z2zLCcJHoOwEw?=
 =?us-ascii?Q?XiNp7LGRa4gJl4lbDgfRM+O0GCW2US8DH5qz/vrjR7VLFCVca6Px4rQBWRa7?=
 =?us-ascii?Q?+MIT6AFDDtP4byH+vj3K1rCq3WOUC150N2Mn21dMnmSW+HFHDdpAtWRgofWu?=
 =?us-ascii?Q?ZM93FTAjEd8KfpI9C9fnzDMKOeXOequR+fLDBlCMaCv8jLuON3lYFzT8aIN6?=
 =?us-ascii?Q?dz38iyxZFRvyXVVDE+3F03EV62C+rwFfcEnv6MF6tbcLnJzfYTkkCbjECK7E?=
 =?us-ascii?Q?5ihJ2BKJEDox3XWDIbs/iLytMCrpXV5lyXOTuVzW97PC5vuYKsOofGH1A2xD?=
 =?us-ascii?Q?AEg91awYnrDm/AtuV4Z36EAZREnFuB37tZMMOe95C3IFTYTcXVuAWQsgtfYI?=
 =?us-ascii?Q?GlHlJvpOAS0FxyK6QJDWSfmhcV7TvrKvw7wfNrmXSc1TM0+4ltnYLo7TjCC+?=
 =?us-ascii?Q?r+G6smQzhuNHS1RqBFPy9l6M9ClyLYHRHosv2n0NbtFXmXgp9ASCBNef7IJf?=
 =?us-ascii?Q?gVaWiJoxa2cj+GXvf9ONenCQr5ljclXtlX5kqbtdJBRej9nXZZiHLzPEmks4?=
 =?us-ascii?Q?yPybRDzVWpCt2xakey6nFFvPgVmLVwq3S4P/UGL36hsqKTD6gBbjQkXa1Txj?=
 =?us-ascii?Q?gZgwt5gIJXnjQZUgiuS0hbf2xcyNILTYRqDXDn7ayllEsWKislL2B96GN6uA?=
 =?us-ascii?Q?KZ6tpKZv2ieHz5QEvk0oc+bfWhBJVoBLG8o/Y+KTEBDXOq1+Q8xKHt8/7DWW?=
 =?us-ascii?Q?j5N6ikv6OVOvDi0Ub21CwTtaAvSqK7oduMivjFw7ohvQ/Ocv4Bg2rX4LVT4w?=
 =?us-ascii?Q?/e3jDnE+e5FDcu/iXKR2zK96Ggm0rSmBYH6CD4OIkPcbhaIMHrXqwR5GL2Qb?=
 =?us-ascii?Q?9xpGNHuRoc8B+6SF1uiE9ecsX7VBa6xOPNVFeeaTZKaD54fLLJmW9W/ykFeQ?=
 =?us-ascii?Q?N+sNXGk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cqq4kQZ6ZozbPLAkJVZntlbjSxWtqGp/r28XOsuK9GKlP/vQ7ocJJjpFB4kt?=
 =?us-ascii?Q?RYajkNMDsm2wF2lljgJAFYWgarZEEjFhfFfz8wD4/dCPk2bQfmQMYFaBc2QK?=
 =?us-ascii?Q?1MQ+L6x0tyBRfATTmYRA1p6rduZy9kwb3YrGjEbFoIDBf3h3BFBOcOkz8CFP?=
 =?us-ascii?Q?NPeMuT+uKgiQK08yjc0lTDSoUcTo+8m/Zde+0EToXbmXcCpSjA2EjwoqWsu1?=
 =?us-ascii?Q?LIB8hSXHcO9isHRsJmJBv4kuA70WmfCTtI4TiiBAetbi1hs06cQNBYaD9t5n?=
 =?us-ascii?Q?32AkLFU+0i9LhCA+EGS394AK0kw2ZHbYYlNwftrYuGr6Fl8+Q8+KoC+tg8Sc?=
 =?us-ascii?Q?0vEQdyVzpxwvvdKcQMwtB+OEttMK80Z58zvlZeOGCRZc18C8i4Jm4kZpuocA?=
 =?us-ascii?Q?XRiwFT5yIAILvO3LW0SDmpOQE3dGsR4r4tLu9Vv9eIkI5IpdXD0tVhl7PljM?=
 =?us-ascii?Q?VzxT2XMOjRrd+Xpcw+07z9vbgAt0x7fqrAmPxbdD5o1OfXcMJZXXroYkAzJp?=
 =?us-ascii?Q?6lWEi159L6wWcB5Zix26zb2FL4SV8j3sPwbXI04LNyGUtvTWIC+U203fAQXS?=
 =?us-ascii?Q?PIzIVu5ldgtCiur7Dmc3pPq4w/E3WkgDrhD1ISN+bzSO4hqoxDmDbXop8zwk?=
 =?us-ascii?Q?FHDOB8wwi7Fb5eEApbC3VAxI6TTjhuzCtBLMjvdzoTvvaahrvub6/nUy0NAJ?=
 =?us-ascii?Q?87HPGzvYLO6GtKu80IpW4ihww8Awcl88C4/MiByu48jIP88Mg4BDkSO+L80i?=
 =?us-ascii?Q?QS6bdC/CKz2oXLNSvo7n453BXWj+zdAQ6+wDDNSVYi1J5pcRSPVnPnco2haV?=
 =?us-ascii?Q?N9mrDs7buXPXiyHLGc1n8hSqBiae1l2MFDmlvHzBixBLVXEqMxuEriVHegQP?=
 =?us-ascii?Q?myWzau3AdPvARhQJ19Fz3eaBGocvxtKeaUAkjsOVtT6dPzkapYIcbm2toIeO?=
 =?us-ascii?Q?oyW5/aqWuBKJjS8BbsY/M+N1/w5XCMXjX44nGUjbiSbeWfbgcyNltaC9bXJC?=
 =?us-ascii?Q?vSdQ4HjV9gUYWB7AipE2C+r7zaIWQ2acS610ioONnN0TDDVWJeLLSlEC8Vy4?=
 =?us-ascii?Q?Nr/0X5hHAqnNjizwDCQqBwKyD/MKXaEeUElLF1v4Lp1aJh0kLRtu5gzLiBUG?=
 =?us-ascii?Q?J/uGs2RIge80pW/zOPtcmVFbr69oq9c6hEZB0VdYyQ4IgpHsmsw6BwHFIqKn?=
 =?us-ascii?Q?jAZlxmZc/PlyQEgdAqsmkSwO9RA2PxGj40TUrZtnl+jhdQ6sg1Wy6+jaGb3E?=
 =?us-ascii?Q?G7m2VyRGLETx7Hp9gEc/FDSxBoCRXkGvIKASfqhlfccWWQnxl7OAFEH0XuC6?=
 =?us-ascii?Q?vJYGn4TzqOSZbeoH58Eij8uTNTjpFeT9K/g1lZKFAvzZYU2Bt8Znyl2uVf41?=
 =?us-ascii?Q?byeY0A91Cu/Y0yJ7dT7mpe48N5IKFVhgzbajNA81C+776a6u9fJf+1IH0340?=
 =?us-ascii?Q?s5KHdCT8tMsti3vFebf1hOWLTHkkNB8e1nAy3kqemSAQta5p7CgO5NBpInDo?=
 =?us-ascii?Q?eYioNWK9Ayda0u7DREBpBW8qCGncJrxDrSmHyKfVR/6wJVSXqczMDLGE2Jey?=
 =?us-ascii?Q?sKDE2aoKJGB1moriknw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 10282496-26c1-46df-e3af-08dcff952bbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2024 01:32:12.8515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jSLfRY2CeohiS9hmBBXJRK1GBYsOAqODpEM8j5lamIsttC0xV+Zqn+6OaYU5iVuufnklbVDgaDrd/mo5UBcicQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9949

>=20
> On Thu, Nov 07, 2024 at 11:38:14AM +0800, Wei Fang wrote:
> > In addition to supporting Rx checksum offload, i.MX95 ENETC also
> > supports Tx checksum offload. The transmit checksum offload is
> > implemented through the Tx BD. To support Tx checksum offload,
> > software needs to fill some auxiliary information in Tx BD, such as IP
> > version, IP header offset and size, whether L4 is UDP or TCP, etc.
>=20
> Add empty line here
>=20
> > Same as Rx checksum offload, Tx checksum offload capability isn't
> > defined in register, so tx_csum bit is added to struct enetc_drvdata
> > to indicate whether the device supports Tx checksum offload.
> >
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > ---
> >  drivers/net/ethernet/freescale/enetc/enetc.c  | 52
> > ++++++++++++++++---  drivers/net/ethernet/freescale/enetc/enetc.h  |  2
> +
> >  .../net/ethernet/freescale/enetc/enetc_hw.h   | 14 +++--
> >  .../freescale/enetc/enetc_pf_common.c         |  3 ++
> >  4 files changed, 61 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c
> > b/drivers/net/ethernet/freescale/enetc/enetc.c
> > index 3137b6ee62d3..f98d14841838 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> > @@ -143,6 +143,26 @@ static int enetc_ptp_parse(struct sk_buff *skb, u8
> *udp,
> >  	return 0;
> >  }
> >
> > +static bool enetc_tx_csum_offload_check(struct sk_buff *skb) {
> > +	if (ip_hdr(skb)->version =3D=3D 4)
> > +		return ip_hdr(skb)->protocol =3D=3D IPPROTO_TCP ||
> > +		       ip_hdr(skb)->protocol =3D=3D IPPROTO_UDP;
> > +	else if (ip_hdr(skb)->version =3D=3D 6)
>=20
> needn't else
>=20
> > +		return ipv6_hdr(skb)->nexthdr =3D=3D NEXTHDR_TCP ||
> > +		       ipv6_hdr(skb)->nexthdr =3D=3D NEXTHDR_UDP;
> > +	else
>=20
> needn't else, I remember some compiler check will report warning.
>=20

I'm not sure whether other compilers complain warning, but I can
refine this helper function.

> > +		return false;
> > +}
> > +
> > +static bool enetc_skb_is_tcp(struct sk_buff *skb) {
> > +	if (ip_hdr(skb)->version =3D=3D 4)
> > +		return ip_hdr(skb)->protocol =3D=3D IPPROTO_TCP;
> > +	else
> > +		return ipv6_hdr(skb)->nexthdr =3D=3D NEXTHDR_TCP; }
> > +
> >  static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct
> > sk_buff *skb)  {
> >  	bool do_vlan, do_onestep_tstamp =3D false, do_twostep_tstamp =3D fals=
e;
> > @@ -160,6 +180,29 @@ static int enetc_map_tx_buffs(struct enetc_bdr
> *tx_ring, struct sk_buff *skb)
> >  	dma_addr_t dma;
> >  	u8 flags =3D 0;
> >
> > +	enetc_clear_tx_bd(&temp_bd);
> > +	if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
> > +		/* Can not support TSD and checksum offload at the same time */
> > +		if (priv->active_offloads & ENETC_F_TXCSUM &&
> > +		    enetc_tx_csum_offload_check(skb) && !tx_ring->tsd_enable) {
> > +			bool is_ipv6 =3D ip_hdr(skb)->version =3D=3D 6;
> > +			bool is_tcp =3D enetc_skb_is_tcp(skb);
> > +
> > +			temp_bd.l3_start =3D skb_network_offset(skb);
> > +			temp_bd.ipcs =3D is_ipv6 ? 0 : 1;
> > +			temp_bd.l3_hdr_size =3D skb_network_header_len(skb) / 4;
> > +			temp_bd.l3t =3D is_ipv6 ? 1 : 0;
> > +			temp_bd.l4t =3D is_tcp ? ENETC_TXBD_L4T_TCP :
> ENETC_TXBD_L4T_UDP;
> > +			flags |=3D ENETC_TXBD_FLAGS_CSUM_LSO |
> ENETC_TXBD_FLAGS_L4CS;
> > +		} else {
> > +			if (skb_checksum_help(skb)) {
> > +				dev_err(tx_ring->dev, "skb_checksum_help() error\n");
> > +
> > +				return 0;
> > +			}
> > +		}
> > +	}
> > +
> >  	i =3D tx_ring->next_to_use;
> >  	txbd =3D ENETC_TXBD(*tx_ring, i);
> >  	prefetchw(txbd);
> > @@ -170,7 +213,6 @@ static int enetc_map_tx_buffs(struct enetc_bdr
> > *tx_ring, struct sk_buff *skb)
> >
> >  	temp_bd.addr =3D cpu_to_le64(dma);
> >  	temp_bd.buf_len =3D cpu_to_le16(len);
> > -	temp_bd.lstatus =3D 0;
>=20
> not sure why remove clean lstatus here.
>=20

Below is the snippet of Tx BD format, set lstatus to 0 will clear
the auxiliary information for LSO, due to we have cleared the
entire Tx BD at the beginning (enetc_clear_tx_bd(&temp_bd)).
So it is safe to remove lstatus.

union {
	struct {
		u8 l3_start:7;
		u8 ipcs:1;
		u8 l3_hdr_size:7;
		u8 l3t:1;
		u8 resv:5;
		u8 l4t:3;
		u8 flags;
	}; /* default layout */
	__le32 txstart;
	__le32 lstatus;
};


