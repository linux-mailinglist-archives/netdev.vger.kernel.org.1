Return-Path: <netdev+bounces-239343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 11515C66FFC
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 03:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B8A764E0680
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 02:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4603823ABA7;
	Tue, 18 Nov 2025 02:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Twlhso4F"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010016.outbound.protection.outlook.com [52.101.84.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C321DA55;
	Tue, 18 Nov 2025 02:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763432403; cv=fail; b=AN32gubJpq3mLHtRf2PTiGgP+y93tgIJzDbvRdOWbFlkBCEqxoQSI9fluY1Uid05elMjuboiaYUzYIL19MB/1LbvdU7+LUybjAMWfmvUUOgvNblX8noSRAdvMEPWQWKyvTcQOUQPoaNWAboR0v8x3rZAw6SNh5NyoW4Q97vt8Rs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763432403; c=relaxed/simple;
	bh=L2KtfR+Z5tk8Z9NSiuxilDTJcc9/vKsecLolrpo07Ug=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FAT+Iu711yB5S3gxzQbHoJhXAxwvuJA8g/isdeq2u3WrbrhFbIZAahNGo5Gh/c9ihaFooGu7AYTaX80T+ybolbHYHMXW9XC6sW76Qr6dLVPuYfFzDQi0O4ydKV9lnkqBRhSRhSO2RhPhJN5i7HcT9ZpnUl/uGWR3W8Z2MUyoFTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Twlhso4F; arc=fail smtp.client-ip=52.101.84.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yg30QnB8+Mv08/j+fc5LBvEWPVOfd1HMKJkrYfr+7XZ7+5FdqkA7mlL/HH4HHg1veo/IG/SO7au+K/cEUP+6Gm5Q0zuYT9SdCHfoH+Gzv0yMCJhhUzOmp/EolgJixhoibeqJwoZxPwp6nr2OW0ivcEy4qwK1BHZA4y6dOTOqdoJc2MGEXw+QA8Qveeg5ZQtFJcozRLnNf8eBiYfVQkJrNatcE9IAzBfZuAL4ExGEJNCnNudis5QjT+WoHFGqGM8yJkSrmMIt1VLq0I0D7+rPbIO7wSR/Q8E+Z+xQY4RA5dKXpBGmHA9+oqUVYnBsAYGNV7oBesTnb5r+iq/4uplzLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EfIT5AqhCue8X+1K7wFaT86wuHNUwffHXTNNKR+im6w=;
 b=fKJCByiwMS5l047v3AtmrLC+DzEz1Hli1LA7oX6sDha0vV27qOALVAcYhV9qIduV0lgAOoKmVH23ULv4sVlHke4MI3PN4f8eSmudMiQ3uJ/JMrIqq5MrQIHw+rHbohRhAnQbm/8rmaATjM7klZK2pDMI/2hY8gr2+9JAQ3dRARrbX6HJQEFBuP/onFMyYnfB8vXp/EUpzovFaYS9TRyIB/756YV0p50DovTD/sveBJ9DYAwwZcxVqAjqXHny1geECHyNTU/PowUiGEuNaHgdqlbULXfs74y2HvvwXbXZlb4OG4esipQBQBCoiKsOWnuEjSwB01dRw8TA0HBNX9+j+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EfIT5AqhCue8X+1K7wFaT86wuHNUwffHXTNNKR+im6w=;
 b=Twlhso4FDyjdXSYdCs+HObDAIQfEgvZOeO0c2C4gDlODDvhmgBwTaAbWk0XNf2TeAU2b1Bm0/TPzj4Z9e7U+Bg96mFMF28Xg1M+rIUpmgN4stcR9UpzXpWOZ46tlRoVFEmjz+0bdkN1/mGQxKr1Vl7qIt4LHD04QjY9tc/H4kVIclakyD8lpNrm+mT8DFKmYKem63mgqppa0owv++n1XtlTGN6osG/j+et98m4XH1gY0OvUFrdH9HJpJWSCCOIHYKzbj4kH1l56VAOljL7Hl6qtQPe6HKhsftzzj56lad3aWuYymWzUSIgbnOflOQGVipI0Cd6i3IN2AD354czmABQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI1PR04MB9786.eurprd04.prod.outlook.com (2603:10a6:800:1e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 02:19:56 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 02:19:56 +0000
From: Wei Fang <wei.fang@nxp.com>
To: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "kuba@kernel.org"
	<kuba@kernel.org>
CC: Aziz Sellami <aziz.sellami@nxp.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>, Claudiu
 Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>
Subject: RE: [PATCH v2 net-next 0/3] net: enetc: add port MDIO support for
 both i.MX94 and i.MX95
Thread-Topic: [PATCH v2 net-next 0/3] net: enetc: add port MDIO support for
 both i.MX94 and i.MX95
Thread-Index: AQHcThB8B/EmTKsCu0Wd8Fe2HUqMMrT3xtag
Date: Tue, 18 Nov 2025 02:19:56 +0000
Message-ID:
 <PAXPR04MB8510AC99EB983E7CF720C0A588D6A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20251105043344.677592-1-wei.fang@nxp.com>
In-Reply-To: <20251105043344.677592-1-wei.fang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|VI1PR04MB9786:EE_
x-ms-office365-filtering-correlation-id: d8dfde63-39a4-42a0-1b97-08de2648f777
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?V5I4tXFF3dxIpKSxsyuGFRPnHHxETW4vkRvrJ2cVk1wmGFAse7Sb+Tz6I7PT?=
 =?us-ascii?Q?sWBM2cmyZnnnzJUWXPLzsb78XKuB7aLCpHlazpkmmykJZeTajhX2uEZpc/xn?=
 =?us-ascii?Q?30EUvshtn0DJd83eNwoVET7Hm0i63MMO14kHKyPBB/TiSzFK84YbtA6pB6IY?=
 =?us-ascii?Q?qoI+BdkteQcEwldt0wg6fgsi0FA2Tktm7LP8zDjrBytqmRgQZAlHS2pusxU3?=
 =?us-ascii?Q?3OgrOOlp5SWB4MqEnnV2F1HsxZHTflIo91FEwkL1Iqrq25t5bUDNsyTYQUBT?=
 =?us-ascii?Q?lRBS/fdkJFZr70XW6KH6sNp3AYyJ9bFiWkODrUsmZDJyHX4y4M06d1i+AEip?=
 =?us-ascii?Q?P2SrT2uyzqhgofCEOjnK3od7DblmNJxmzZPt1UPF7vsFR7K8tx+C8XJA3Ii5?=
 =?us-ascii?Q?J4Omeig9EgNb+1teqzu1A93HwDYZxkls4RvD+dpBLoYgxSYTcbwd96/9noTg?=
 =?us-ascii?Q?312ncR8DiclLrNDnQM7RBJ1lV4FXfJnNxFqEZTmKXpTMdOD/p0iEbLEbIka5?=
 =?us-ascii?Q?H+kdDyEGc2ryuh1Dl9Qw6PVAAllqMbHg+/A/b+TRrqmElWwlkpSu7HMLwPYL?=
 =?us-ascii?Q?wqCRavaxFXb0XETUB3jIZ25xA6SeYoYF7JAROcpvUxDpBHl6HIv0JLPFa6mT?=
 =?us-ascii?Q?UXkCLwiVtFrRbjGEtEgvL5vLBUUXXpzzWZlXO1Rsin5PTOAUEGKdVOCPRS+V?=
 =?us-ascii?Q?Jt5N+uYDDnm08vwAqwi29Jn6bIpr60ZKU6Ic+AGQVsdxxBoUCmtWjf7twozP?=
 =?us-ascii?Q?DhNSbv/Zof2fqpsDO//Yhi2giBaV8wcpW2QiZrMXtCtkJKdKXT+wRxN5Dsuf?=
 =?us-ascii?Q?ONoO9W2lPygiTdb8AiWoRpwD0cZk6FW+Ffy46GMntNKhnbJVhIEtlAHyLJMI?=
 =?us-ascii?Q?tBN/boxgNV0kT2RbzwgkuSMesqjJaeSJlCYl4Bxsi26WSkUfM4Q1q/dXBmrq?=
 =?us-ascii?Q?wa6TZtfSAXTee288Nx3/AiU/CdnC0cqRCkx8j+fjpwIX/lrEEgvL7gfPmFz3?=
 =?us-ascii?Q?qECJeU9RVnQtLJ9YM13GFfPrnTHyDBNWg8b6vI0jt0pl49rPo4OgEaRv+R48?=
 =?us-ascii?Q?qE++v8uFGQXHmOe2rTqbx0eMOsLzuAiHH87lNyqNT/dE60Ud3A9hw4Mi/MV8?=
 =?us-ascii?Q?6SwVJm9Uf21FhcxVvAxsoNTCEhBSlweMmsV9TRWs7t2x6a965PB3GoO9i7P6?=
 =?us-ascii?Q?YJX7qVx6IlEJ7Cvoopz6wnPUK6emgjUaHUqoTu1ncSJIwXIlFVFeEUikB0Oj?=
 =?us-ascii?Q?i7qrmEJiMqzstyJz+YrpS2wECfkI8YwC7E7MLxX5cEm3VLBKvL8pteqaZAbu?=
 =?us-ascii?Q?D3stthxfcB0cn6JJzyIK/c7DdJEUS05oFw2E+FUKJxHLbFhugFDDM3lM7ZXZ?=
 =?us-ascii?Q?7YQS9bVy/eeFvrxAakC2RjeV4jTNY+gLbbdFECIgLo5pJ82bLLI+tSOKiR/4?=
 =?us-ascii?Q?G/yTwssYbrKJWZassGZRb6bbR+weHMIGhi8gOWva7elsV828QQ0JGTw6oUyt?=
 =?us-ascii?Q?Gev+8aVBIUcD7EWnlnYYgmVvypvrplzoiV5n?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?oA0Tk7rwEeBJF1csVVjLOZBKlV9TteEXMSgk8lZgm0z3b13+HjbXmEtT7yk4?=
 =?us-ascii?Q?O229Um1iCqsLa06TWRtzjlWB536myh+WHDe9eooLjdm+d7qgBaPJRFZfOVR4?=
 =?us-ascii?Q?GKwA9WXuBhXbjjQ95UYXGE3aURrq+hDkkop4W2oE6JpnBxjQrCLlO3C4Wps6?=
 =?us-ascii?Q?tg8uHNBV6cGHYbGwVC+qNySmS/rc9N7fXwvj09axa6wx+Yxp+c6daITWJKjD?=
 =?us-ascii?Q?shEP/DgGxdVzZ5F7HoHaVoMHVQhZIt81yS8uGVhRIAd3Lq0+rUg72+taONra?=
 =?us-ascii?Q?K52TmsyFwl8JAi7TlSwgvWGZDfncVQXqrB776KRzGUy4vS9Xc2wPNx6gbM8Z?=
 =?us-ascii?Q?4Uu0hqO2LFgLsEYGRqyP0uB7e4fpThzWOE7Zvg96AKIYzAg2VHMVh/fC0lY3?=
 =?us-ascii?Q?1aGT1itJ3UAuG/zCpdWW2niwxNytrP0Mm/O2d0S7yML/6gXdra9+NM8JM2IS?=
 =?us-ascii?Q?BXdIechKlhtr/wndW+wM9R02IhsfS2f37/zW1+kdhgEa6tPGQuqq2rbq3smn?=
 =?us-ascii?Q?EY/UaGSdhXxNFA89pippukNfp/0ltcse3MtC+o8KTZ13Zdqyvdv1W1fMU5U8?=
 =?us-ascii?Q?qwZUYvK9nq4JiFfse9RXH8gy4Qqol7/WpLL8ZddhAwwHdQvC55/VGKrik5uG?=
 =?us-ascii?Q?PKm2dUSO/NJcqDB6nod+QHbFPmunsxAwYTCSJGLxUcwQJOq9koegzA33xNGz?=
 =?us-ascii?Q?eFoSefQh/EM6cCwsGTAEb7g3ce9BPMoyc5VrnhR95NJj90JCLj7rYuOcqnvZ?=
 =?us-ascii?Q?HBkZdEKKb4s+3D4aHg8C7REeGDp7ZkQu0H/wuLiEmkFbeipBJNr3G4LqT0R/?=
 =?us-ascii?Q?SnyyfZHzVLZlnHnnIfP698u0FZ3IMT0AinFDp1ASfXDO4ecCxib3yvZ7mOgy?=
 =?us-ascii?Q?Lx5mCpvM9hjE4WkIfcX5QRuo8DF61KewIgZ3vcjMyxRmYKMD/B04ulBdPqTi?=
 =?us-ascii?Q?Tjq/3az8dSbRJDcZPgs+A2sKcLV7xGla+9PIwgL3Sf3qMjqLQ90aLoczs11u?=
 =?us-ascii?Q?ZZXbQj8tRZmhky1YlltgMV8F6XFdqdEWWhbO0ko4VLXdJ88H/+ToSerz+0PI?=
 =?us-ascii?Q?B1OeydfAsX2aoVwjEvWYMRqSVd4eLCPog+McDTVNm/+1AyXbe/YmGih5r6c1?=
 =?us-ascii?Q?oOcxwXfo9+QoAo855UWttl2qMkRM/AOOsR/TwtBHF64mp0/D96a8R0zyA00W?=
 =?us-ascii?Q?1GooyPcthYlBq5H3Qw5PPWG1C1CNoZemVxC0UQ11OUfsl0sNn/Ndy6clAcYv?=
 =?us-ascii?Q?joyjm0rU8+S/33i9et3k1Sl44YCV5jNrWWM5FoYGrH5WhBaJ9mE0gbqfsPvx?=
 =?us-ascii?Q?JMA0PPBiQxADyN4cwAwUy6p5oaPqkE3iq+4/siUlM7HattSMKbFevIYfmHSG?=
 =?us-ascii?Q?Af4qecKtDmrU/T+R8G5z5HNiQts6KMhqzryczOuvhjV3oklXqERrNKc9N3zx?=
 =?us-ascii?Q?9tnjYRy73Aadt8OvIRG7k5UHm/uXT67tb+tbOAKu1bQxavAbn8esUcmX5Fse?=
 =?us-ascii?Q?aiWc1HNN5OKLAopE2BTmgapgzS3OwRGhkYmkzSLYE7fJ+Y1vjQy2AsG+OGPu?=
 =?us-ascii?Q?WY3EasGjFdlXM0Sa4m8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d8dfde63-39a4-42a0-1b97-08de2648f777
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 02:19:56.3856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B7OwcMVmzV+Vxdl+PybqvCtntvsUgtV/YopwPniXgkEhPe2PnXHas9S5BSq6tx1y/1lThaunoSOVoRTgiyaG/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9786

Hi,

Could this series be applied? Or need further improvement/clarification?


> From the hardware perspective, NETC IP has only one external master MDIO
> interface (eMDIO) for managing external PHYs. The EMDIO function and the
> ENETC port MDIO are all virtual ports of the eMDIO.
>=20
> The difference is that EMDIO function is a 'global port', it can access
> all the PHYs on the eMDIO, so it provides a means for different software
> modules to share a single set of MDIO signals to access their PHYs.
>=20
> But for ENETC port MDIO, each ENETC can access its set of registers to
> initiate accesses on the MDIO and the eMDIO arbitrates between them,
> completing one access before proceeding with the next. It is required
> that each ENETC port MDIO has exclusive access and control of its PHY.
> Therefore, we need to set the external PHY address for ENETCs, so that
> its port MDIO can only access its own PHY. If the PHY address accessed
> by the port MDIO is different from the preset PHY address, the MDIO
> access will be invalid.
>=20
> Normally, all ENETCs use the interfaces provided by the EMDIO function
> to access their PHYs, provided that the ENETC and EMDIO are on the same
> OS. If an ENETC is assigned to a guest OS, it will not be able to use
> the interfaces provided by the EMDIO function, so it must uses its port
> MDIO to access and manage its PHY.
>=20
> In DTS, when the PHY node is a child node of EMDIO, ENETC will use EMDIO
> to access the PHY. If ENETC wants to use port MDIO, it only needs to add
> a mdio child node to the ENETC node.
>=20
> Different from the external MDIO interface, each ENETC has an internal
> MDIO interface for managing on-die PHY (PCS) if it has PCS layer. The
> internal MDIO interface is controlled by the internal MDIO registers of
> the ENETC port.
>=20
> ---
> v2 changes:
> Improve the commit message.
> v1 link:
> https://lore.kernel.org/imx/20251030091538.581541-1-wei.fang@nxp.com/
> ---
>=20
> Aziz Sellami (1):
>   net: enetc: set external MDIO PHY address for i.MX95 ENETC
>=20
> Wei Fang (2):
>   net: enetc: set external MDIO PHY address for i.MX94 ENETC
>   net: enetc: add port MDIO support for ENETC v4
>=20
>  .../net/ethernet/freescale/enetc/enetc4_hw.h  |   6 +
>  .../freescale/enetc/enetc_pf_common.c         |  14 ++-
>  .../ethernet/freescale/enetc/netc_blk_ctrl.c  | 111 +++++++++++++++++-
>  3 files changed, 128 insertions(+), 3 deletions(-)
>=20
> --
> 2.34.1


