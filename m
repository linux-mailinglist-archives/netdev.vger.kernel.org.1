Return-Path: <netdev+bounces-192696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E498AC0D62
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 15:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4051B1610E9
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 13:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EC228C2B0;
	Thu, 22 May 2025 13:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nsSoKDNb"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2053.outbound.protection.outlook.com [40.107.21.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F5A146D65;
	Thu, 22 May 2025 13:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747922246; cv=fail; b=vBkhXgRxyxF73cG+GmrSwWUI40CZRwqNxD7jdRGuXIcTfdvWzV6ZeVXWtNvva67r6rPyxaOEJdCRhbFIvuiJrk7Q9DAw3IqW271LX/CXt/GWtKBgjAprEap8uoM3hj85jSJsSL28bcTTGPBAatVjdfI1iPc5MuJfA+KZx261J/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747922246; c=relaxed/simple;
	bh=xP9TRLgdQvt6FGu1ndF6G0BdUjUjBEA3j6f+kLPOnzE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FdOfFgc5s3nwEAhoX99Ahml20azKWNxwrUvrdN40fN5+LN5aM2gkHmeX+Ig58zliUBgB/+G1M4W7+g3DYzD8lNa6e4GAhmTQSPEits64OXsMhIo/S3qNsz8v15ezPPrB64c7G1jTG7fF6IyH7GHP7NLety6ZOgDcbrBxQiFW2s0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nsSoKDNb; arc=fail smtp.client-ip=40.107.21.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NTaDv4mXAGlVitjuXjpehLMQCqvPP6TtA9YMkXXHJK3MV2/Cd2P+uhuLXrw0wqA96r5b8Mbo0YfWEbCzniBBRDZMgQZwPnAel49FCLpN7EtYKxmdqsOSNn6vPGoNDWFhlL9aTYtZJbbopxCXpqkRIvAzD40AT6r9D4Av/IZx6YIPMIHSlih7A1gnPRsAoxMSGt/k5L1UxoB4lHBXziKan+nL7B95OrpEzmsq8oD9aDSVN2rVPM9/Kmz+5fjGJcpR7BO25qSWhKw3i44fBCxhaNZAkVjYBkS/5s/JP51zv6d+jAv9MJWxc0+qtQ17vLTBxwhFV5GN/BUJk6qVwW1e6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xP9TRLgdQvt6FGu1ndF6G0BdUjUjBEA3j6f+kLPOnzE=;
 b=Zncr0NMcW0at6p+7Fx93prmYqEFi3ZjZRRNpx/e+1jufomcGb2JOEGjpAoGS7zFbKr7d8PRcN7bx91yk8qON1GlVwAUsExqIj7GgwocriGNh899Xbod/r/TienCcwrbOSTmCEUhbrtnavyuSLlGJwlvWf+AnrRka3E4bjjmLHn3TtdOYhQADA9idLWmWS0IlnIk09DENx8vGJjR9PJTKCdbCQ+ftgL9+Hsng5ipdeTjD8mlI7qoMqsTrB/WU/LB7CRB8qpqXWg9Wj0EdXenIkRoPHegLQZQpH7KY9aHzSs6BMBA2xx2KcIm4nGLBPqBQEGC/j3Z8DwFyzFAvCHP5NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xP9TRLgdQvt6FGu1ndF6G0BdUjUjBEA3j6f+kLPOnzE=;
 b=nsSoKDNbKMXvk6dYp2um7VOudvO98y7g1tw2vtUBVbCWSqvgzZsrQqwG6vhh4GqlYDkaML2jlbVFMpNqZhR4OVxx8wHsqySrt5/m9yZPLWpMbxDqc68N4PdtQorsHlGC7qALsko4pP4JYBW3Nylt0hWRVV8qeKG4Hc/h6v4GJVwSyjD+6jUnsIwDWnhPcIlzRlqynZYj+PXXPRt7od6/PqlS8vBSrKz04LPmqrkcVpyjGHfDECU2v0o0bbzsx5CEERm5bxOWf90HGtwpObrCQqYzrUO3CUredrim3Hkcx2tlkYPllN5Al0RGdXk1jw8SlcP9WCSCAzbVxdfqqWyo4g==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA4PR04MB7551.eurprd04.prod.outlook.com (2603:10a6:102:e9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 22 May
 2025 13:57:20 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 13:57:20 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "hkallweit1@gmail.com" <hkallweit1@gmail.com>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>, "xiaolei.wang@windriver.com"
	<xiaolei.wang@windriver.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH net] net: phy: clear phydev->devlink when the link is
 deleted
Thread-Topic: [PATCH net] net: phy: clear phydev->devlink when the link is
 deleted
Thread-Index: AQHbyueBaVaVgIUl2EmIXGE3v7huZbPelaUAgAARSiA=
Date: Thu, 22 May 2025 13:57:20 +0000
Message-ID:
 <PAXPR04MB851054C5E1049B5361A46C108899A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250522064253.3653521-1-wei.fang@nxp.com>
 <f19659d4-444c-4f44-9bff-4c83a8c5a7e9@lunn.ch>
In-Reply-To: <f19659d4-444c-4f44-9bff-4c83a8c5a7e9@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PA4PR04MB7551:EE_
x-ms-office365-filtering-correlation-id: 98c79dc3-7417-4b61-91db-08dd993891f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?d3RrJYrqC74Mzvq80N0kCf6wVFGwmJa/XwOONp5t/86+7T60lxAIwk6wZ7H5?=
 =?us-ascii?Q?3ueHkUQf/RY97Ba56WJxbaiVwBdTiENsmOJYCOOYIZLgPHyXC0v1ncMD3geK?=
 =?us-ascii?Q?yahKOK8ec4+Uu/PLJAf4FqOdkrzRZiZjT3YyCJ2SHA1+LjiGn2F0Lk72eDbj?=
 =?us-ascii?Q?ly+12WwTL78iqcI6c7+5CNycHDaB2zVFPQi25ImZIg9JW7rc1gF0bUQLIWCx?=
 =?us-ascii?Q?LOKPIeT2oEcX/2BSOoCvCWFmPglfzdfYuONIOT1UjIcm8A87KAFzrSSsPdS6?=
 =?us-ascii?Q?purNb7qkoGdwJxKN3NOCvBfBjOzpFz+o5qxREbWN/Uh9Na5JDMZszCwxz4E2?=
 =?us-ascii?Q?1XRhBajXSmKeZ0bAPvCEN3OvJvkuZysh2CgOD5LaKdLZcLIQvE1qjR8/9hV9?=
 =?us-ascii?Q?BV++pGtobm5IHfPhGHkzH7xEhg85EXfpxgJRVoG/TjRYrvqPPu7IRmRqQ2Q0?=
 =?us-ascii?Q?DEPD9sqd+KvtRoOil7/fz1Q3zSVaXfzYqP+it//zXz2wS0+jI6bq1l3Yk6II?=
 =?us-ascii?Q?iHeZUpuvGaAeF14jxADgSwbnxYh5kzIZbuxA4q1D1gVsglCCeECK7qx6TNiQ?=
 =?us-ascii?Q?trMGOeH54y6uSlCZNNgrdlQ76smbQiM5XKke4G8hDqW9VOBMo4W3EpeW6amz?=
 =?us-ascii?Q?7cY/PcyzDI0vgHTF3AaI6Hoj+gWRAu5jxS2lEYs+Uai3ti1cN78h1u8YBqc8?=
 =?us-ascii?Q?jmK+yFIuBIbCAHZraX4hP9QBmzrbtHeVv8L8gOr3vDR+A/lc77c0V5MHYH6e?=
 =?us-ascii?Q?jVg4vovA90gHpRAu54J7j9aymH9JmGgqG+AH0uKn+ebR3rJ8V3IbH5qo3/Zt?=
 =?us-ascii?Q?kS2GPiPSBsh4oEjBysHZbjy+J55DoVCJTGKOXl0K+3i7yvaCby0hiHR/OlvL?=
 =?us-ascii?Q?MISMDmnuLvCL+bOtxAjFbbam1P3uhQC2M+7W8jgfILyi849akawPlibpVjzQ?=
 =?us-ascii?Q?EEsYd55bXXfsWUaDwSbdXdCfY8eu6SG2etDo47cvrF1N6js07xuXW5MBcr7q?=
 =?us-ascii?Q?BjlBKr5zegvreyvVpTZ+gzPZfp3HwmSWFOy4kFjOjawkH9HKmzwE2z7UShDG?=
 =?us-ascii?Q?6jPV+7GgCn8/JX3oBlrS7KhdPlMfgzNgMzaaq/1CBdi6JcTeOIHiUGbq6dJU?=
 =?us-ascii?Q?eWAM4VaAzCDkT7nm8wgZPDZ5FNC8SqtPQ2I1yIyL3oURmgDVI56OJqQjqPOt?=
 =?us-ascii?Q?hGY38ksWkes65c2Jj+KZTI45nySIv8Z9vovceWYGvmrPQxp4r5zDQL2WsOY1?=
 =?us-ascii?Q?cIrLEOqMtsjlg89mxEfUd2nONeeSKWrJ74vsS2gFNV6DKhmC+W2UuEZQA3xc?=
 =?us-ascii?Q?9DbiLdITCmb6rqn7gSJyU21wmIs5usncb5jagQxJgQotVs/QdK2fMNp2kKyW?=
 =?us-ascii?Q?gPf4riNw5ys5edF+p1PLJ/9oQDqZNt5pSyKa7S6M1qp95GRXU2icO6UORiqU?=
 =?us-ascii?Q?RJcbzl0l1/IKwOM6sA+Nax8KJLU5fmeq+tkhTsaW4DlNv22FyeT8Kg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BZjmXLHrpNpCEcsFHnLLmq+rG3tS1kPZo1BjiuPqE2Y7uF4N4q/LAWnOJWo8?=
 =?us-ascii?Q?sKq1r/CSuwtK1MNL4N4OROuzZ7NMjXuOqqCviPFVGhe72h6S5r3AcR7dZpjF?=
 =?us-ascii?Q?ID9evGRdu75iKMI5jdhzG+In41PliEoiUNylZy54vjMECqPOzXEwA4UuQJjF?=
 =?us-ascii?Q?1zGStHiSFRaN9H7R0a9UHWxjLIKZOHRLCnH3wJ35gTZKam8UyOBDV4H4lrO1?=
 =?us-ascii?Q?izrvJ4+SUvy0f+2WEnH9H/ckoZ6vViU+f12CukvIQ5O5bnwjXQAFBPk8rDdW?=
 =?us-ascii?Q?NJEcI77c9bakw+y82MsZ5LUnRakBikDi7A2/NdBmxX+7HBkiHPebBrgl/Yfp?=
 =?us-ascii?Q?mAiZ4NTNSmDbzUqTOL7w/tW8uQGZvEIMZsnccNbj/+wpo8tThMQfAOuByR0g?=
 =?us-ascii?Q?Tl3GPF+zKjD9PbVeEEwFq0u4q+RRhUroYMrzvPQNkmz0uCb6HT3WvGLga0bs?=
 =?us-ascii?Q?LCdeu6fKxMlOQfFVZKiN98txLhW+krt3M9roovDONKlFr7VDktwlnwXKSe6R?=
 =?us-ascii?Q?xfrDxGd55LfQ3K8Zq7xHLF02Q8TQjaxN6UlbDC/17SSiMrafTCg71U+CiIel?=
 =?us-ascii?Q?P2aRzhOmlFC8ICfHxbMs4jFxETSM1Xce53OGjTHq/ZGYwc9W7ffgYKrvo/TR?=
 =?us-ascii?Q?FqvYBavDl/9UkjBEHo4kI6ePxccABIiTYglceGs/HclFBNoDYDsFO6SMzr4T?=
 =?us-ascii?Q?m+jyKwZk3s/L1a7D13X+LMjxvpWBizLF5mJcuQg99D2Js9w+PKPM3C/vGZBg?=
 =?us-ascii?Q?kiCoXKGheiy55xzuEj5OqmmJ2nSkpiBdgG9XwcksL0SkWX27gO8TS466IDS3?=
 =?us-ascii?Q?pO49UQJCBHKT42oCwCjEnjYP/C9X0yd0XLrBZwBASPNQsT7omVDG5tBJ1IZB?=
 =?us-ascii?Q?Li+uAlQ0POwWtDBz1sEDtv/EfHUxT9jDIpoHpj4z2y4sFG6xe7LZyKtrW7Wf?=
 =?us-ascii?Q?vme71BL4qnbLmooXdIWMc+ZBYxoKgx4a0JGxXcEPLyskDdAG5F6rEc+bWZga?=
 =?us-ascii?Q?L5AYOd4ovmWzjxP/HhZ97NTpeUs3wc3lAJuWmODZXBU0WjgcgzQWLjO1uTxh?=
 =?us-ascii?Q?/Etor5HDRfpAPrGrxG66/pKNd30wzWlWsrLuIjlm5lrQI+ycWa27DlwzBYba?=
 =?us-ascii?Q?NArRR7gnO5jHCmH1R/4xWUTTyW/bKMDMH97X43NwuM9pmMafw3AAXC9/0rMV?=
 =?us-ascii?Q?joVnDSL/LiRXoNKWHmKAhY9/VX0UebcrjmGaPpeXMB0jxvnLFVUy+tpr1rrA?=
 =?us-ascii?Q?Zdebv+OPd4My8RIn8ir0l75V/YBphiEsKbPwcDl+SMWLEvkCnrmY//kwY7DC?=
 =?us-ascii?Q?PDm9XAVI1Ql8ovPfd8SVTZf0ugYj/ih9K/6HAMu1u839XuQ3ux24o8zWit9E?=
 =?us-ascii?Q?nX59upTMputqAp5dWF+NVay9qIVcwyhn/KlpfTBAoH9KUXV4Mnz/KhSUzYDO?=
 =?us-ascii?Q?qBn7yrxo7P3cpgfR6N6wvgwvguUZfgzPvGPf4v5GMXjpwkedV77cbJNRQxcN?=
 =?us-ascii?Q?p8JBD82j8SulRud+/JvBC+5a2tRF72Gcs3+iS6AM/TYJFbusL5IYTMV2E+dQ?=
 =?us-ascii?Q?GJnvPM6RCtdrrH1C7ak=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 98c79dc3-7417-4b61-91db-08dd993891f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2025 13:57:20.2099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EfByTSDAkTU2phBR5HluqWRhmFHuZgHBzsTPbLieGMyb9EAvWhKWw1tvylL+c+pyba+8fm2ue0lxBTBfNJVgGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7551

> On Thu, May 22, 2025 at 02:42:53PM +0800, Wei Fang wrote:
> > The phydev->devlink is not cleared when the link is deleted, so calling
> > phy_detach() again will cause a crash.
>=20
> I would say crashing is correct. You have done something you should
> not do, and the crash helped you find it. phy_attach() and
> phy_detach() should always be in pairs.
>=20

phy_attach() and phy_detach() are called in pairs in my case. When
re-enabling the network port, if an error occurs in the phy_attach_direct()=
,
For example, if phy_init_hw() returns an error, it will jump to the error
path and call phy_detach(). Because phy_detach() did not clear the
phydev->devlink pointer when the network port was disabled,
device_link_del() will access a NULL pointer and cause a crash. And this
crash may cause the CPU to hang. I don't think it is reasonable to cause
the CPU to hang.


