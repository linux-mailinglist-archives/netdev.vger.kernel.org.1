Return-Path: <netdev+bounces-120302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A38B958E1A
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 20:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A32C91F235DD
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 18:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B5214C5A9;
	Tue, 20 Aug 2024 18:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TK3N6xRj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E4214B96B;
	Tue, 20 Aug 2024 18:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724178825; cv=fail; b=tT4jZAyfbhU61uCdQAfpnJ0L/kTbAUI/TFRjTqFMdlwte0ExftiLyUb9OlyVSi3we2CrSX16Sm+Xi6IcIGWIbY9n4aD1SxOkH9wc0Kk2ZnVS17Ol9xZkopImjEEtfgD+9Ypw5qih5M68a1+CGtdcFOMyfXTxR3H75XD4YmCvuAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724178825; c=relaxed/simple;
	bh=rmgYxFDdF/CNbeFHMqHv/JXPwaximEa0FAUVKxty+yc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SsSju+Tq9SvyMzRepVYF1czkcOMo7J8syNG+sccvmOwEawPKxqeKT9jDanupVxpR4ln/N/wrbUNZr4BzBJftSLWuatK14zxTLIG/0g+kI4jhrUi5ZCPmoLWTbPg9Er4sVtVFVG5EgW3sCFS4SUYA8To6CZGPjoDjrZzHvlhEcMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TK3N6xRj; arc=fail smtp.client-ip=40.107.220.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HhQMKbC7484s+HbkyjKmhQ56Z3hLGOQNQCpbAo4UaZJcyHNh+ahT9pm9FEJtAgr7Mq1dCjhVLae0V+wrBG6qKnbgbU6eJJWyGzJl52fj/X7atxuy5Efhb8SSj69UKGk/wQPTuZnXU0NSl5hxx8E3SNVdmNEZXJVT8TR67RVn3Yd08L+KavvpUTiTv+SGr3Ett+Z9SKr/JsjOqe0CvG8RyPSWPCmnhetRhI/J08R/fXaA9hQg4hAwERA/9EnqMxtyKzqDuHxKalLrtjoHxSrS9BvFujvVvKc1z/d2sMZ06i30/Ltj4p8ZGF84rTnlaQuJx2SXEuMAYLrhsrRyXULN0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zy4yxIVyMZEUYvgJGq+FguE74jh/mEs7X3Ak7SDDjaQ=;
 b=cd3V5Xu68vfoPFK2VxxXt9fm1qMTzVofcFiMV6bNst+J3Yc17FW9VIv31egnTaCQl1tM9k6XklE/Gl7p/D+dJnM4M1RvKL1hu8L5PzIX7tcTk+WOM7IW1yozKHPt5npjSozmhi4utIA5quzRO5FFQwQxngyMmeSvnmvuei8VCQTlpmCXuQUdG8lSor9o9VYk78RZgBp6zVzsQYiawGceUBKV2uVDeu34ChPhyITN7TcKHlJM/KHXe3vr0PzQyDAHbR2PIZf9VGBXqga9yuNjQ6g+Rz1+QohRIqtrYF6AO9Rl/Fguy54Hu5rjuhNmx2g8vcyOR20trNOB4P6nkYrMew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zy4yxIVyMZEUYvgJGq+FguE74jh/mEs7X3Ak7SDDjaQ=;
 b=TK3N6xRjRXy309ZY15VfKlJ9tIZZi1t8MVkR0kOzPZFLZzMGjUfk9aZqFBhdKoWIiTBYr4fYaqq+JKNa9EomEK8OiNdxUt9xD3jPcrR9WiP2DhA6FYZ7oDxfKKZDiNeGLZq6dEAXej+xQ5lC4LuL0C1g15eC5pf309MABib61Zg=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by DM3PR12MB9351.namprd12.prod.outlook.com (2603:10b6:8:1ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Tue, 20 Aug
 2024 18:33:40 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c%5]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 18:33:40 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: Sean Anderson <sean.anderson@linux.dev>, Andrew Lunn <andrew@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "Simek, Michal" <michal.simek@amd.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, "David
 S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Simon Horman
	<horms@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH net-next v4 1/2] net: xilinx: axienet: Report RxRject as
 rx_dropped
Thread-Topic: [PATCH net-next v4 1/2] net: xilinx: axienet: Report RxRject as
 rx_dropped
Thread-Index: AQHa8yn5NFfuCd3NBU6w2UtqDOc2CLIweFMQ
Date: Tue, 20 Aug 2024 18:33:40 +0000
Message-ID:
 <MN0PR12MB5953E143D4B9D889E428998FB78D2@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <20240820175343.760389-1-sean.anderson@linux.dev>
 <20240820175343.760389-2-sean.anderson@linux.dev>
In-Reply-To: <20240820175343.760389-2-sean.anderson@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|DM3PR12MB9351:EE_
x-ms-office365-filtering-correlation-id: 2c409fa7-d55c-4609-a3c8-08dcc1469d0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?QkD3Nlmt3e3dOtdSmbdKmE1i40H+E6Kmv3QzUZn3hY/UbREy875EzZSQQwTQ?=
 =?us-ascii?Q?tlSyLvrwuqDCu8BXRwI6MQi6YUbdyUkhcZlnuqL+6XrR+iQ7inSqQGyJWJ6R?=
 =?us-ascii?Q?5jQtrvWv6NCfsKm60vh/tvZCzdELG9yUEb/5e7A4xyaJ6t7WckujoxHt8kIk?=
 =?us-ascii?Q?w3QXmqXggG9a7rSUCJlpy48R4ij03fv04iKfTfiR9TN0cMQYcwvWkEiNvSli?=
 =?us-ascii?Q?Dd1cNgWasQDZAepPDOPgwn23ju7yBdfZ16JFEvaKLe+cgn+zojaYv1hK2UoY?=
 =?us-ascii?Q?FD2PT0vGbJ1A+rprI+h2rclfCUAjT3gg65r7H224Psic8ORmlFkDc0kwWQIo?=
 =?us-ascii?Q?EtWKbdJRftCGGaMsU9fRCVzCjsyKyu7/YsRr2a+i8ZBV236d91uQKwyPWMHd?=
 =?us-ascii?Q?OoXEYmulZ+BnPLbc7wfAzp83QL2JPFqRNFXckmo05KbmG+Gaw82YcTFs2Qyg?=
 =?us-ascii?Q?N7Q0J15OLwoS7PPULZr/ZF+eK7k5WnnziCLoIkNkm2aO3fZFk1oMJJmQQ8Dy?=
 =?us-ascii?Q?0kLrIEWG/MA7K6FRlzdy2G6eZHwHdfN27EZAK8dSGL+gukDi+UIOEO35PiOY?=
 =?us-ascii?Q?bbFnfMTncTpr5unAvv0b1ubPT2T/NZWpEcMMktKIL4ntUr9/YLNFJOu73jp4?=
 =?us-ascii?Q?BDdClGlEzvJRznK1XZV7lQt6MHY/PM7i7hK0ArQHn8R19eTyrRhtuC0X8cmc?=
 =?us-ascii?Q?RUhuFmxZGh0dql8FjqPDtJuV8/2a6bwsRh71S4Jb2WIxFkSaaEzqN2OgjhCI?=
 =?us-ascii?Q?V5nBNStO0It1rVFu6hDNxiYyW89OFRaL6XLq1plFiuZtWEpe8wjucX2v/NNF?=
 =?us-ascii?Q?UmLq53REWf1WMlWk4V3XW+dycD0eowVwCn9jVYBCSVkH1OaNgw5lq9iopAdc?=
 =?us-ascii?Q?mDZvDeOL6GufgG8oiLyxvwZvRPCnvr+WZGNRH1YGB5JNvCTaQoN5Rjmh/cFy?=
 =?us-ascii?Q?xMhBbMikp1JEJxgE+0mAk0ML6JpjYTHTaBrJ7q4tdu2WW9q/YCG0Jn9pTBea?=
 =?us-ascii?Q?+AS3A22z8dVmE7vGkrZfFYAbgMTRLYLCyDI5ZYWqN81e/GXzD9JJ+co9NyCE?=
 =?us-ascii?Q?MfeZ8jgnuHvf2yx8c3Z5KpmqkVBERWS4SYm3lO2WjJfAy1qpMgGtq+uuyZan?=
 =?us-ascii?Q?cBZtrXv4EIppjJUbsDSDfCiATPqkg62XqgPjoATJM5lI6BvHvHWJvlJ0cZxP?=
 =?us-ascii?Q?WSeMr+sM+EgW0G+MisxdrowULDCeVSPayAPszwJRr6WKtmwvaKpEbkd0xRyo?=
 =?us-ascii?Q?1xhAF7aXPpKcuaI3TaJvzDw310RM+dtCAqb1DQtPzQFnDqbPjejjE7A7/UYZ?=
 =?us-ascii?Q?/CJWUP2OOSvF0x/s6/j1Oe5+Tolry4UbySZmv+rjc4+3+BaUeUWUAkWKCccS?=
 =?us-ascii?Q?dEvYhtNaZ3xdzH0qEUqdOMb6dJxx8wS1r388utNh6e01qgHThA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?JFx8yapYSN+hMQqRYo+qvg3tEOUSu498aztrnCkXclcjVOvvBi4ab9MsMWYo?=
 =?us-ascii?Q?Vz+BEaKk7sNPfqyxLILx92AAzcWlrwPWUy7VOgLt9VU/4ZMnanpIFLNBshL6?=
 =?us-ascii?Q?tDpoVlYWrs+xO2w7cD73uVBDwDV8cEq0CnGadO+tiLrvTgbPyVGMr2gFVXB3?=
 =?us-ascii?Q?hr1LNlpAi1lcjoVHIlPWh0rrEkOt0MyurlWmld6ebE3k4jE7HZs4IzY5DunU?=
 =?us-ascii?Q?hNrfKphCnuzf0l+YuEJc6xLYxSZ844g5awU4sLO2LcR35EJPeWcxnI6VY71I?=
 =?us-ascii?Q?eKji8Yvww8qjwmVSuuoLodS4vH1RtTi6MuhMXrSVv1EU06qWSzYnpd34mDZn?=
 =?us-ascii?Q?AoJ9voc3FfRDRGwnEOe0cF6tE3JLUijeyuGT1dqw13WfOfQ3fjqodSxwo0eP?=
 =?us-ascii?Q?w0zW9mf8Aze/LkuxWVzsqmYB/xWQPNqn1IKVAT0YB3zbhZY6RFDZXT/W5Gm7?=
 =?us-ascii?Q?1C89VIkAuSeii8OoTockXlrx+EC26HGD6v0fyfi717smxV6Qz55cScLwgArV?=
 =?us-ascii?Q?47OpPXmkkH22d/UtRsYld/kYeOKJccT6TzEwKy9mcyVwOMZgOUnhFkb1kIH0?=
 =?us-ascii?Q?gT8NEf0CfWgIrwLJcJNItSYt24zxU5gblmc2VyKdA0jS9g2yVGYma6MbBhZT?=
 =?us-ascii?Q?vrhwpiraGQKm95+S0c1oShLb+qhFZQ7oyn3U8tOi5LgBAKavytuHihw/rp/f?=
 =?us-ascii?Q?GN5e+Lsv/3B+/+g+yI5C3tZ/wUeBtwiWai/IHpkJJNp3JoLfsnH1tU/g8sWi?=
 =?us-ascii?Q?OPIWoVAWuOkCewMlygdJX1HyXEgTuDK24c0j+SjSAZAEFPZEzSLExvsY4/vy?=
 =?us-ascii?Q?87t4fcZffBEXK3VKV7/yZ6oGepPUFhK5iVrpTtds+EgWGc1qfDPs3cpUSYle?=
 =?us-ascii?Q?l6Wjq4GIxWSQPuz94ybiqkpoIQvUZScYlYlDZZv7ufcgFfPTkWeIjw8/+j/b?=
 =?us-ascii?Q?VK4LfKPgtDqobLJwjQRm62ofVrGt3MWiFK5WVk0Om7cOjIfr1u2sLU+1bpvK?=
 =?us-ascii?Q?jrQanWlaPQXFt4Yf1l/FCifcAgPN4tLj8jS9Hc3KGKEnTawMCBQQsoYE16mq?=
 =?us-ascii?Q?HHvzEoXD+i+6vi7tPoN2bwjdLJJbuKRCfnoQ9PQUHCIrLw3PJp6e3ahV1XAv?=
 =?us-ascii?Q?EkInOOpm8YMTnOO+SwdbRhlEvg//LrWuPcb3IVlssDCRoL96ueUwxDTIQvzJ?=
 =?us-ascii?Q?LYk+11C91ZimjDvIIJIgtF8U8BAmcK2PQivzZt9GRyHhD3BzwuPzZh+Htx8k?=
 =?us-ascii?Q?70aZKWMtoru7lqAhSITUO1yqcOWvD33l9UChrIdWhRDJgB0HI0YPRHJviqw2?=
 =?us-ascii?Q?0ofxFeErWSVMWaKPOgfSokT4UpX+0jVI2vntsIelxWe3DwUPQRGcCNZIn/BT?=
 =?us-ascii?Q?T4kAleQ0ep7bwyaqGDlaxVUh+n6t1k8YkWoegdbDf0pUoODFI9sB3ThBFboz?=
 =?us-ascii?Q?uoJoICoQIWvEVsN6m+97+V0cS53AgwO9EoTHcCRhdE9kMnBDLnJrGGbOqcSe?=
 =?us-ascii?Q?MfYlORjq/8p21jaiSPCS0QO+3DSj91LUyfv43r27ASNFR+uggmsPKbUsDY8g?=
 =?us-ascii?Q?E2E4OAdHqVMMFeKgPa8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c409fa7-d55c-4609-a3c8-08dcc1469d0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 18:33:40.5746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VEXWJeHQyXR83OCFx5PDJ3T8IMHqpGJeNrneGfvpqxddL9lWVG7eZicIgR47Hn29
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9351

> -----Original Message-----
> From: Sean Anderson <sean.anderson@linux.dev>
> Sent: Tuesday, August 20, 2024 11:24 PM
> To: Andrew Lunn <andrew@lunn.ch>; Pandey, Radhey Shyam
> <radhey.shyam.pandey@amd.com>; netdev@vger.kernel.org
> Cc: Simek, Michal <michal.simek@amd.com>; linux-kernel@vger.kernel.org;
> Russell King <linux@armlinux.org.uk>; David S . Miller
> <davem@davemloft.net>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Eric Dumazet <edumazet@google.com>; Simon
> Horman <horms@kernel.org>; linux-arm-kernel@lists.infradead.org; Sean
> Anderson <sean.anderson@linux.dev>
> Subject: [PATCH net-next v4 1/2] net: xilinx: axienet: Report RxRject as
> rx_dropped
>=20
> The Receive Frame Rejected interrupt is asserted whenever there was a
> receive error (bad FCS, bad length, etc.) or whenever the frame was
> dropped due to a mismatched address. So this is really a combination of
> rx_otherhost_dropped, rx_length_errors, rx_frame_errors, and
> rx_crc_errors. Mismatched addresses are common and aren't really errors
> at all (much like how fragments are normal on half-duplex links). To
> avoid confusion, report these events as rx_dropped. This better
> reflects what's going on: the packet was received by the MAC but dropped
> before being processed.
>=20
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>

> ---
>=20
> (no changes since v1)
>=20
>  drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index ca04c298daa2..b2d7c396e2e3 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -1296,7 +1296,7 @@ static irqreturn_t axienet_eth_irq(int irq, void
> *_ndev)
>  		ndev->stats.rx_missed_errors++;
>=20
>  	if (pending & XAE_INT_RXRJECT_MASK)
> -		ndev->stats.rx_frame_errors++;
> +		ndev->stats.rx_dropped++;
>=20
>  	axienet_iow(lp, XAE_IS_OFFSET, pending);
>  	return IRQ_HANDLED;
> --
> 2.35.1.1320.gc452695387.dirty


