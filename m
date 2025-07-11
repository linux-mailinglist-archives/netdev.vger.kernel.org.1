Return-Path: <netdev+bounces-206008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6E1B010CF
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 03:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BF594A5247
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 01:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494697E0E4;
	Fri, 11 Jul 2025 01:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="R3lkARQX"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013061.outbound.protection.outlook.com [40.107.162.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D87D2E40B;
	Fri, 11 Jul 2025 01:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752197322; cv=fail; b=rGjrAWQ6p9Xfz1A7Lm5ChjzoOiCj3RjYzDj7V8zkLuK/gEmgq+CEjl9nDGNuExzIMvo8B9+JrfL8Ctqq3Xelq2XiTgLKGqA1PJ9Hk//S2YDD1tGt0q4QdSbQMp4bA5wRqMYf1j9n2fVN8ammy51AyELx7IhP9w7VyqHfRPKsrmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752197322; c=relaxed/simple;
	bh=Sp9H51qd7Uw1bGoRthwVYJzdOAXf3FrHNVLTnzEP4PY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LuSoyFVDKMaEoMnU2knhwbmGkFDWa0WQOr0APqn9GbLg8noi3kFcQ6vHSg7vW3e5nQE2WgwV27INBEHErE6bvo3Fc1wY0mZBjZwEyUkR/JDmPUDuqUKSOSQ7p+Xsr7UhYjAgEZrNhBxTRJhkbE2n6HUjDehcLx+gAjQK1f3F5nI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=R3lkARQX; arc=fail smtp.client-ip=40.107.162.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K1S9aPfCP2l/hHrzCkIQagJoXiJewjr0rXQ7LdHc2ynxoJpgRFY25Hacu9BIO8k6VByygs4gmVa9sJ8yb2+w4Xgx3n6Zm92KjduDWS8hKFCjn3PdqgBToPeENC+F1X/ZcvpGm3sNsN6wYoFF9xTq/8D8tDLspuLbIyYx0SefVPd5rNKegtILkAK2ow9iZD1POcMb/uqsQYcDmE5kWJDE9W5UkqNDjNMrYP3urx29MFEhYS/TbCmaeTaVaOFBpAQgU7MfOYc1Mq84S8i5QdNZv6KKaQOOK6ebwjtAC2iXiIECPavYqAYC6+mZGS07Ra5g017HMBEl300WhQXzttg3uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDYdBf43mYUxRqHVjLVTl6C2u7X6Iqyk9wELvPHs3EM=;
 b=LBkYccB87+y9RY00nvYH0rS9odaCT/xBfCW/Cj1cEY7KJl14fCFFf9q9RZfjFlwWKf3BeX23c0ZwcLjmLoEVR4uh6CyUOBwg8eCaBdGR9i+Pn5Cuplot56tKA65WhFaATk6GoYtAHYAXpQYVTSwNQOuXN2ADzMmf2p9Pfmf7+RMLGQ5RkgAXMKbRfjNDfcpg8ijULbTGWMslakKAEbDj+lBCPrg0QvpD+VgO6yNbja43FKc6K4GaM4vVOwXZw4RIhG4pYyteRgl03k1DOkqvUfgvpOVq3KztXDfW7J1z/9v8NEdvRC8hgS2A47Dw6dVFBM4PDdXiNcZ4+B1oks9Aog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDYdBf43mYUxRqHVjLVTl6C2u7X6Iqyk9wELvPHs3EM=;
 b=R3lkARQXhGTi3kTx/HdGaYycp7N5TqFca3gCWOCZQlEemYOXZd+nKohCNfnyB9YkB3EsD+koWcfMt9lyzCYljN3sUe5/P4c9yIcdFAcBB222goy9rgcUHWwW26vnJBxiClY/5TNLrcjOsxN42wb8jBbvdTSgYN+wbxcBLin9v5lmvnm826McPrRn/fmWhoy7epQqfvJvxE0/w4VD7AWvtg9G9ZiJBNiTDJc5TgeUCG3a1vv8ewoa9QLhDjMutiQmd8fvw8hEIJPMCszN4BIYDx1urPkn6xequ5UB1P8BOZVgDZkNxCyj9GP/6PjIqmnvgrl6tKQEVArF6m/qDGnxDg==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by FRWPR04MB11103.eurprd04.prod.outlook.com (2603:10a6:d10:172::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Fri, 11 Jul
 2025 01:28:36 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 01:28:36 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>
CC: Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH net-next 3/3] net: fec: add fec_set_hw_mac_addr() helper
 function
Thread-Topic: [PATCH net-next 3/3] net: fec: add fec_set_hw_mac_addr() helper
 function
Thread-Index: AQHb8Xnxc+j2NvBYlky63M6AFIGtdbQrYjAAgAAOvACAALIc4A==
Date: Fri, 11 Jul 2025 01:28:36 +0000
Message-ID:
 <PAXPR04MB85103180D6EA605BCEB2735C884BA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250710090902.1171180-1-wei.fang@nxp.com>
 <20250710090902.1171180-4-wei.fang@nxp.com> <20250710155728.363bcfd6@fedora>
 <c7c297de-d19c-4861-af85-b43b15f43d1a@lunn.ch>
In-Reply-To: <c7c297de-d19c-4861-af85-b43b15f43d1a@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|FRWPR04MB11103:EE_
x-ms-office365-filtering-correlation-id: cc436588-802d-4b21-cd12-08ddc01a4213
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?a/UQY6Z2ILOYbkyTdtRaud+fj4gw/uCxOVNjiZqY3lkOlYD2GJwyXQ/vlQpl?=
 =?us-ascii?Q?F4LnXZjD/0+TBLkSJ0Y1FJz9KwaGuDa5KfzxZEUbhhpBlOp0ibOjUkjTMxyi?=
 =?us-ascii?Q?NHYW091pE2LOGK9JYZSi8rSPvLqDK1fo+HPkVxPsGt418YWCKOmxNsR8q2wp?=
 =?us-ascii?Q?FSEihjnckkrdUCGaPzyqZX8/ufXhd2U6RWgO6NP5GUH0gEHTf/KBaKjfFB1s?=
 =?us-ascii?Q?LcLoir5XacIT5jVsVQMMjUVfyaIjlzX6c4ki+TOvf+ouZ0+FsTHB/Sft7A2F?=
 =?us-ascii?Q?rD8BVnSzOjFNDJgBB/K4YDOUuMXdWXHDUy22e6uJ5hFzM2Y28c59hpdvzxqv?=
 =?us-ascii?Q?+T2KXP5dFXKCuHU76EtnjnJcKbSBPW4Zp5DcC8LJTCLHKhnnIjhPXWE5CR0N?=
 =?us-ascii?Q?6QZ+eXClwsE/LJe2yC/1GB98kIdJhwR/+yZj+KfDhS3NOyp3R2q15m1MgQoy?=
 =?us-ascii?Q?xXuh/Skh3wXrjwk33u0aKvhtLCTMGDYrrDXK99NFF872n4y8xXmouVOeq6YB?=
 =?us-ascii?Q?H84sefwxB9v1SZoILmasLQNuZRb/LeLH8i+3TcuohGopCQGpd1ahM5dEX8GY?=
 =?us-ascii?Q?D/Sp5XEN6MID1cS7UTgqlWIKFyx40JrmoxRqT77O6kZ8BmiOxuEjdZM9aqPg?=
 =?us-ascii?Q?3LY1ZuhwsuZ/FUS9bqyclply+mBP0jzt4XyIVHFvZcZQEY+bd2SmXXR1cdw/?=
 =?us-ascii?Q?eEd8G+RvirXryT6nuPjBvey7gOfJwlCDmNER1TI3LKZdcOW+Wa4koio+EFdE?=
 =?us-ascii?Q?70WOJPspZRe1592JPYmIKG0bki6QRgVVj6SKoJvSayVAUB3U00xEdkZD3b4H?=
 =?us-ascii?Q?KQi4HBpl1/mf5BEUiUApe3sfglw+JTJM4kaXRy3X06ZZeq+vptCJidahP1hS?=
 =?us-ascii?Q?S8vi3JUtr6cdSw/VYZS1us8742rqXTv9ALcKaUj8PlwBlIiPIrlvM3Xi7Ju1?=
 =?us-ascii?Q?gIFDwXQ7Pjs+SHMNraSoRrk5MPWx8U5Nz/DCJrpG265hYtGNgk3G56MxPYh4?=
 =?us-ascii?Q?MppSkll6oWWw3SVSGoH9c3Y0sT1PpPxgBe/S07XmlWNK0daa8SbHNyH9UqXP?=
 =?us-ascii?Q?n1fROy3/gTEEF2MpC07faIFKLd9nFSRrli09FXoYUAozZb4PL60CtMfa+lWX?=
 =?us-ascii?Q?MozoNGdGC3iOgCoQ3BvZo0XWepCJ0JDgQKbMyjPWY//9oOXIB5u4hLHwHZyw?=
 =?us-ascii?Q?m3xY6YTQBLTLNxMmHrkkDRuwybTcJE8OeVGAhCMmSIi0Nm0w/qrEkYYaAy7i?=
 =?us-ascii?Q?mqPD7MMpFpjiQZxLzIje/YkjBgz7jfwML8D6lTXtkBCaKLvu+rALunGsW0WN?=
 =?us-ascii?Q?12+G2zObzQfdD2XF4Qzhom/5ZpN1xLzDcwO7lLdvap06cyQQvlvrn4mtcvbF?=
 =?us-ascii?Q?pDQIkvJ5CQqGUJokeypB+5gxdHlbe8ZRiYopV/0Fnejc45CQtL+0Pk7P6WEC?=
 =?us-ascii?Q?B5TbdoyA3oBcgzIPV/jRpusXko1kNhzctBp7sYK+Yq3tN1SqNhMvDQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XE5hcHuHAF09wQeY8alAv/GUIjZkCU/a7FfG6KJFSUoRYXUEHdSNC6rtqdnU?=
 =?us-ascii?Q?BIzJy0473GaiM2DHfhKToElaHObZ2zHY4562rImG+5ndDbFj1flKk0oSKL2s?=
 =?us-ascii?Q?TjPC1uNurWDgPxE8tXEOqo1VQohnaGiaASpKN4ATad3BZMd5fJAiGcbAb+gK?=
 =?us-ascii?Q?VudTPWfwQMcqFtvkZJ9MYDDjl9dTpNPQ1bmDAyTTkSR4KXkYwJapdphQpu5x?=
 =?us-ascii?Q?muq+6ctOH/7pouuxYCaWoJwtzoB1rWehKsQUIMA0t7LFJ15FS/Swa+r30QJ7?=
 =?us-ascii?Q?xL6RMKoY5U6onMHtI8b2fR/H/27mEv/cBIonr0NMpY3UW4614Tpb/V/n6wRR?=
 =?us-ascii?Q?3YDdLdnlbxmwSCzDTo0L5yBvqDqkVC4f6CsbjgSv7OcXeQVPtI4alGQEs3HN?=
 =?us-ascii?Q?+lcGDyw96LcMSCT7a1g6hpv4TOVxs7/qx8il099lXtonwo49auzsBb+ak5vJ?=
 =?us-ascii?Q?R6AsFerkGOtigPI9dTjZ05pm3fPlHi9XwN/5y7j2vhUVQ4/ktpgfcDiKjMUt?=
 =?us-ascii?Q?NOOndPChq/rK3JnB27YOusmC3btDUw3dDPthTUx85zVSpsZ74m1xuhBHezUU?=
 =?us-ascii?Q?xIf2Rc9vbZ+PTqNRoG6Gp3jvP3qQWNonriULDBO9Pikjx3cEthFR66ukg8cr?=
 =?us-ascii?Q?fPm8nJxoKBOmQ9M/hB6xcNjHx7GlfixXCdAl3zSjQ1B/Jhkqb4TbxXdCbc0p?=
 =?us-ascii?Q?9T2npxJCYFlcvTRmJQFOd0m4bQbHqcEIpcOX5QhQK1szuM9gGm2+fy7pubn5?=
 =?us-ascii?Q?wZYdPPRpyV3q6JjRKJzegavd76Yzdu2emtR43kfPVS4uwHpxAfRSHNfWkcsY?=
 =?us-ascii?Q?0UMBbeJ0sEP/WNpjXQgDACmBQat6vDQKXzkAK9Y9rqMSnoFIMGVge3qwa6Qg?=
 =?us-ascii?Q?lJHEBapCDN6UdScJ9kZVF9zufhvYbekpAzFAK6X32gBdGILyZKp+3b1WbyqA?=
 =?us-ascii?Q?POS33++VNbqSTsMgp2He9KMtKwAi8Cx1WPs24N6/yVE3pWhrq2uNSIq2oy8t?=
 =?us-ascii?Q?BgNoDcY6Q5GItmEn0saWkIrBalyiBkSbp5r3wD0WT6aTUyKhKZJS/2ofEbg8?=
 =?us-ascii?Q?d1DIyZS3uAN+vkfDUoIrfTYPsHYMfy8lXkNzXLS3Rh+x69bLfgCoZQoKoueE?=
 =?us-ascii?Q?GeRig18CfquLLTJeLzYatXX9NWaV17RGHVYZ6ryId5lBDkQr/ejDpasEnfja?=
 =?us-ascii?Q?xVABVVH5CfOeiJaEnK2xnor6SXv0DNoBM6jxABFeevFwkzxDhnED3SyXav2u?=
 =?us-ascii?Q?McspWlj3ZgGb8CpTyz0Fv4adWlBKgiW7NwKutX+DefCiT2QI20Ob5H0bB4bl?=
 =?us-ascii?Q?E66d/EVaAYY1FCbUulklv7PUCpBwSJSh0c1qa6kF0rrPisrHNrz1RHLni9FJ?=
 =?us-ascii?Q?Gg0jVEmRKOoHtZy2NE0sVrricM4XpJ3JHpaR+B2VOY04FkmYHFmZWIuLQg1Y?=
 =?us-ascii?Q?PLrBhGexbA+9eBrFkLwrpnarAwMLPfhuHu2ZUMWzRDCnarDa2/E+GJz7sIhy?=
 =?us-ascii?Q?EWaHvQYWgukYBZpe7tjJWakZQHM3QXyWiPredjL5Zhepgcn7I1GddVqsc/A/?=
 =?us-ascii?Q?K4qcEMUfTH/WfjUJLwA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cc436588-802d-4b21-cd12-08ddc01a4213
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2025 01:28:36.6381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tb9g/MdNNjXgmAXESKaBtKdU9kOJn3kuMZHwJsqXNmLqW29LQFGtc/DNU9LNWAlYImdq2RVkc6tpnO21o++7fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11103

> > > -	writel(ndev->dev_addr[3] | (ndev->dev_addr[2] << 8) |
> > > -		(ndev->dev_addr[1] << 16) | (ndev->dev_addr[0] << 24),
> > > -		fep->hwp + FEC_ADDR_LOW);
> > > -	writel((ndev->dev_addr[5] << 16) | (ndev->dev_addr[4] << 24),
> > > -		fep->hwp + FEC_ADDR_HIGH);
> > > +	fec_set_hw_mac_addr(ndev);
> >
> > It's more of a personal preference, but I find this implementation to
> > be much more readable than the one based on
> >
> >   writel((__force u32)cpu_to_be32(temp_mac[...]), ...);
>=20
> It also avoids the __force, which is good.
>=20

Thanks, I will improve it.


