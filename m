Return-Path: <netdev+bounces-249865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFB0D1FBD9
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 16:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 32F6E302ADA0
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 15:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBA939E169;
	Wed, 14 Jan 2026 15:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Zkmmj6Bz"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012009.outbound.protection.outlook.com [52.101.66.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52A0396B88;
	Wed, 14 Jan 2026 15:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768404133; cv=fail; b=MblOmMvGwwVlVuRDNQQIlrNWoRW/JzZRkC25KqLZAv26E4+7R4LjU80SsY5ApbqIN/LvwQC0N/S1CiFfXsFmTPEzR32vI3X4wHyy/4z8XiSb8hWytlEIpJe9t79LI+eLucZe+r2pTF9TskKZ7oIjEFbOVoQXdSATRrR/WrZW3CA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768404133; c=relaxed/simple;
	bh=nhY2KadRSak0XxzWVfmtEkYbZTwt0IBcxekVUNA7lYo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dJwAT+jehAdzAegY3Pnqvs+0PwkNYBr6CeuKwRXqdK3nw2g88zBW6AUpflKQdCNKQIN5N3XI6pHxQsOWkP4kS/jAHZ9yQMZgW0m6Nf2LXmxDFyNc0i74vzLbVwSxnB25n+bA6SWQ7ZiP4gbgfbDW+PEc+gGgE+uYibT1gi51YCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Zkmmj6Bz; arc=fail smtp.client-ip=52.101.66.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sNioUC+Ob25MJLl8IBmHpfDfkTUBjjZKD9s+r9bcTfn7T1BwIE7YMODNnsVepH78TBmKRSH5G50PcT4cC8uf5cuO2yVdGcce7nS8sSWNi2bEYgKfTU1a1P5fGyE/GB1rHSyzvYvXX/HkqmeVkkjR2uu0bZVNGMgFk2RU3emTX2lOPX1z6dCeXep7InVtxAYdEvkx5B5X2Rr59Jdp47ORE98VcgzqfQRvjHzIgnzV6y4exWS43ZVQJ5b0zqWapkMySc5BHszHoOFahFR86olmTje4WsEXpe4NF61qyvF8yxaDGiJ2yOiv9bBtfaZmD83eyk0o70Cv9dzH8CTPJ2EMCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0BJjviLAL+lVnrshzrTAdtyUxHVfIjqf2nT9AUdZ9Ow=;
 b=tkPu4RyKwO9XYkmNJ/IZQgmLq8CJjdMUh/rS7kyxo8gOCdXeL6HevPdqiUGLoU8nf2sR18kxPIHcCMXeVfh2RmlhyY7QYyigF5Xxm2C8v7rdrpcl6xc5JKBEB7lCzbgqL5ItjS+HP4CZmgusffsgC/fSaKI/E41wHFQngYhFhAPtY9ZOfEq3GuZhV8XR1SVGpq88HAY9Db33ym5ypYvw2nmO+iwW4Fs/ufFC7YAJ1AJx+atvzX8KUbLTgcuvrJ18CUA1XmgkukyhiBskqIDnv8KqJfVRtiscnrvkHaIxt5oIjQ2WUYHR5bN10We5zqdmFn+ga55wUTKwGHI/uULVzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BJjviLAL+lVnrshzrTAdtyUxHVfIjqf2nT9AUdZ9Ow=;
 b=Zkmmj6BzvjSbnNKWmCyT1W7CpMYGONZDZ9F05PxctfIPvkPAYv7zZF4tfNw/6AD7MnuIZ3MOe6rfTTgc3NIc4UZblkeu5Nk6x0YUU8Gry+NK1DmyTj3CjheKX7tM10xOwofJ9QZYj49UkuYOSimMyLZh+InUl3dQqDexo146FFdvmQAqamn9YysmSSysUBvPdT60Nb/MYUBewX2r6afVVzT+eOH8NCfmKZF/qAUV7pIe25bQceIT/9MC0Z0BZKu3EuYTEo/VXzT61iRcTtxrR7VuTB6m7QKOSKfQclhcU3othNYP1QktBx/xsFT1e2a+RRyTg7qmxJIv7KR45o9DyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DB8PR04MB7068.eurprd04.prod.outlook.com (2603:10a6:10:fe::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 15:21:29 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9520.003; Wed, 14 Jan 2026
 15:21:29 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: netdev@vger.kernel.org,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Josua Mayer <josua@solid-run.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH phy 8/8] phy: lynx-28g: implement phy_exit() operation
Date: Wed, 14 Jan 2026 17:21:11 +0200
Message-Id: <20260114152111.625350-9-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260114152111.625350-1-vladimir.oltean@nxp.com>
References: <20260114152111.625350-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0015.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::20) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DB8PR04MB7068:EE_
X-MS-Office365-Filtering-Correlation-Id: 0554b3bc-b252-4bf1-560c-08de5380972c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wWR1M1El9G3Ml0qNCbGd5SSx2ZFxQvDV/prEPMzNVqCFDavCcMUkmErE3AEo?=
 =?us-ascii?Q?HmqICt6ST88L5QN0cocWs7s3OVYxW3OxG7RhNG4t4x+pbe+h384/2GuqlKX5?=
 =?us-ascii?Q?QvBE/9liKexAPWU3g56gnArgCpZTinwTRvQI2MT6UJ/ZgkYBGi/VID7GWOMM?=
 =?us-ascii?Q?3jJQ4M0Nh4FIqcDDa4qa+GAhltOGIlrwVKG5sx2uzW+CR7yJ+6R4d2KgbQTU?=
 =?us-ascii?Q?tkKRrAM9aixJK6bfBE4PScgf5hwMjX8kzJYXoptnLKDLggyJ7aYDN4w8URmG?=
 =?us-ascii?Q?l0JAM04iJ8vAjLdesk7Nmiq6PvS1n04XqqULJ0eodfdzingmcfYwYRCHxb3A?=
 =?us-ascii?Q?cdi/HBrRV+X8hCSYYwPXqD6dA0raoXDQGq/z3kqa45LGOxDqR8YBEb3Y8lkE?=
 =?us-ascii?Q?8ezrVvnYHfbzrcMQF6zW5mWgYUZTzxpnMrTzqRWwoHUJ57jSyxNfsXkMgxKY?=
 =?us-ascii?Q?hxmwzjG0mQoza0R1cqm7y87e+bjJSRYMW3cytmCR5Vl8+kkeiGTyRxcmYASG?=
 =?us-ascii?Q?C8R8/lrGSuuTxEbx200GNHl3xZ+jffPJtOxpgMHS7vk64v9j4YDClx5Uw3BW?=
 =?us-ascii?Q?/40VeSsP2T3kMcdklBBQPKftilhcxD/ivcT+scsdPHexfKTbnTUeaRM4sfHv?=
 =?us-ascii?Q?Tr8NNjObvohM+zbsqNchYZxazvko8sRroOrJBRFr0hWh1xkeBvuckl0HkQrA?=
 =?us-ascii?Q?UM1gDSVcZVgUXAeMNfZ1gLuhcrfWH/L+VfC0NU+F1jHGgkgSjSLAHlQSExmA?=
 =?us-ascii?Q?2P61pxUmsJKgBoitu2odd9I6qrQGdSBIe3nMEpkpUkYOocyWYPuXwrGMnBYt?=
 =?us-ascii?Q?8XVVrV3qRL3RaFxjLWN6k49IjuWqG/HD4SrRJ5XVYls7Qbay5Ojili4yTFLT?=
 =?us-ascii?Q?QRqid0Fh+O+HXbBmn4dpaJsW/hj1iSjnlsE0x++ve/FN/CPf8wqx3RVOVyiM?=
 =?us-ascii?Q?TylmMz31UyZBp4bAUXxQ88lIBJi7n3qMFHPbvUL/iJXXnZ6h3LW+dxD1YIf5?=
 =?us-ascii?Q?+hQJaJsREZuXpB2D55Nw4IOuqVUAmCcZ89nsiBy8X0eO7mzWgvDsYfnBd59g?=
 =?us-ascii?Q?72b/+ML15zpK5UNc2c4a4CDc6312OoHgJXp5uS71/fnhlXudrw/3JXRw5cMz?=
 =?us-ascii?Q?8TrTyroxcF65Qo0xcSDzzP4cvJtct6EG3mk+PS+9Y2lRjHz1cswBCmnuKTQ7?=
 =?us-ascii?Q?/kmH5Ef9kvaWKewR45az+ocLjluw30j3lVz4hPC4CKRp3jBhx3Yo3uZWRQmB?=
 =?us-ascii?Q?a1tUneRTu0/0m4UMoBXnnmVkDR+hcRHxgFoMoFrAw7Kxv384bRet2X1+bz6s?=
 =?us-ascii?Q?EMbzEMJ2LYG3spH0UDgiZcw+rBIe+g8eybHgUMwC6rBfgpeErDcD8pwh2Ya7?=
 =?us-ascii?Q?KvvMj5uvk/qq2M8TOZN5gIXWhPCdubBOsx1Y51xXw3DmvrI81SMJZ8vmL9J4?=
 =?us-ascii?Q?6A50Jlw/Xnzq13YizV8iGWszYUXb9HKs7pqtntNfW7IvpdE5wfue8ehAQNme?=
 =?us-ascii?Q?ZtzCLhxtmcncRmVN1OUa9GkW3ALjfqXLSjepqGCGfDg47TX5MxzJ/8lynlZb?=
 =?us-ascii?Q?6umYmgx/rmeVpEEZ1z152Uz38bRoQbG6d8wOTltvQv9m+ou787fLbvjvOVEO?=
 =?us-ascii?Q?Q8QT4p0YJ5/mleCdhzaKdp0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?chiTZJKyZIUzpmu7IaupwjhBQOI/nKtAGX1bLzeAbCxxdqmi+kI7iEEzMQcm?=
 =?us-ascii?Q?14z3+tBQFLh+UUhVqQhyYNlxXO7yUJmX4SlxempZsa00oeRpzt8N8RaiioXa?=
 =?us-ascii?Q?Zq0fr1qnUcWkgcpalv1+ZfAHgSTBepfj5+xgkhzO0YCPubUW+bvcngpBmebp?=
 =?us-ascii?Q?LdWuYI2dZGilZtSzQEmR6MolfKtrlp4IFsK01B5MW7nHmHXwSELa8/aIMfhW?=
 =?us-ascii?Q?41NyMda/Qq+2/MB/aW99iCjH81FV2SBkFhfdAF/EjOZzFnegVCpUXCFWZwGs?=
 =?us-ascii?Q?ahUhHYXF+W78L337wXhZFvHSmja9bT+Dv0dULHvPN7xtu+L0AHMXqodpV/Y9?=
 =?us-ascii?Q?tNRaCo+6juKrEFHAswtA8bYPA9InZO8TiMF6eiNE76ULzmUjXhB/tIXzjpaH?=
 =?us-ascii?Q?DIx5gtd1cPPKoQ68SyK7jZIX0go04sKDrw2CuQ9D5Mqys/+hYrQmcnk678so?=
 =?us-ascii?Q?QtzJyBe3Hq5nu88Qvy7qeqAhJM6y+fk/u1YUc5yGRuKA5VrPCiHr7DM54DpW?=
 =?us-ascii?Q?pWCo7CGhr+AAPzqqdTvYUhHP2N3Rn7ROxeRVS2ySjKdJHXrjnDytmNm8UVX4?=
 =?us-ascii?Q?SaVjh/JDKDdnJ5Osa8yfjuHKV07kJfeKX3NC8IegDia1MNKA3TjiqljfpfKX?=
 =?us-ascii?Q?Hf4C0nmP2565YyaL8/GJnkGRvZsKfH/NxBWdJqYwZqz3GBFAatNDjtmPBcjr?=
 =?us-ascii?Q?Yus0NkqNgX16Rsei4pXGskSYE9XyI9ZxiPMLBuzzgC6xtJ51JN6Q1Om6apgI?=
 =?us-ascii?Q?ND6E+BM/HBxvtswj0ivmA07VuekiTfj9inxbWS2MLzHip27AurourfBWl82h?=
 =?us-ascii?Q?5MdpLlYI0KXe5Xf3zxL8nYeJwWtNqvfLFm5+0MhUmOp1Zqrx+wc1I0uONYdF?=
 =?us-ascii?Q?ksiqv2cJtdTG6xdjKNKS+qxW/QEySTXfBvcRe8GNR+jEAAZNYVedhO1k5D33?=
 =?us-ascii?Q?LNQS6wdtevgE4X7O9cIJQL6mKCT+n46vWhtm2C5leY327o45Q4+1UtFRDS/1?=
 =?us-ascii?Q?txAQiaMo3oe+DD2yQzEGqVPTYtDyOXdFXZqGVYgcOxAZYNuqBz6IhOHqj6/I?=
 =?us-ascii?Q?L94QM+4UCqj1Ot7GbVdi6TA1FFVMhh6CW2Dgj6raHi/5jeZhLdOo6j8bt/RM?=
 =?us-ascii?Q?OYHe+PIiC2uiYOQxEL1DtvsS1DGBw3FTH6Jj0yLcm1uUs7wj9vF3ewoMdHX6?=
 =?us-ascii?Q?WIbcxEiKio5YFO6ptQvBg76ur14cPtBiTkEyWgb59iy7eJMF30HkqwZIeOUx?=
 =?us-ascii?Q?dI2+qOZntroks0c9yZFCIDhSXFMfZ3XEDWU3DCQY/kHuYm0XzBRTOxkl6oW4?=
 =?us-ascii?Q?64pLVuDSXx1gSuXJQJseW0dtli8y0QBjL2rS9N2YrZlrAvEVU2Y5ewGb+75q?=
 =?us-ascii?Q?DmJUf4ZrjnIHJ63aBZwnOqj/+aPO0Z1pN75/VNTOKtkQaYoV9iPxFGKFiFZ/?=
 =?us-ascii?Q?0gZyugbkWEl9Q6PKN6kQj/mMtypFsqmm/pnCY65rWP0Zj0f3l1LXjc2xeXbo?=
 =?us-ascii?Q?Q8VkrTI0u03e6+KCJaypv8lXpnPG1w2m4b/1BmxDQF49eSaafukjgviaqrRk?=
 =?us-ascii?Q?IdQNqrWC0IYHFVs2f4jRXPw1nphC7jWSMf9TkJBrJfvQ0FFkXOE52a0C4Kzy?=
 =?us-ascii?Q?dMSRKsU78SLgMqNaMMZZaXeWyLW050M0V9dRXyqoBFmqcYUaHs6JlKJFRPwK?=
 =?us-ascii?Q?4w/WOaUefwGJ+edP5I0PZzO0+VyHRRlGHXWSbNOcGhhIUG+hBVjeNZSbCKLC?=
 =?us-ascii?Q?GeFj0xOsSJ4QI5DNm80Brrc8tOfIDtI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0554b3bc-b252-4bf1-560c-08de5380972c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 15:21:29.2419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q1aTupUINmyNRiX/sdAddnHGwZsbDh96hlyLArA3IwAJ6r9yHAHx3ODmB0azNyR3Z7IeqpfD7VcaCCKMnokhEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7068

Managed lanes are supposed to have power management through
phy_power_on() and phy_power_off().

Unmanaged lanes are supposed to be always powered on, because they might
have a consumer which doesn't use this SerDes driver, and we don't want
to break it.

A lane is initially unmanaged, and becomes managed when phy_init() is
called on it.

It is normal for consumer drivers to call both phy_init() and
phy_exit(), in a balanced way. This ensures the phy->init_count from the
phy core is brought back to zero, for example during -EPROBE_DEFER in
the consumer, the lane temporarily becomes unmanaged and then managed
again.

Given the above requirement for consumers, it also imposes a requirement
for the SerDes driver to implement the exit() operation. Otherwise, a
balanced set of phy_init() and phy_exit() calls from the consumer will
effectively result in multiple lynx_28g_init() calls as seen by the
SerDes and nothing else. That actually doesn't work - the driver can't
power down a SerDes lane which is actually powered down, so such a call
sequence would hang the kernel.

No consumer driver currently uses phy_exit(), so the above problem does
not yet trigger, but in preparation for its introduction without any
regressions, it is necessary to add lynx_28g_exit() as the mirror of
lynx_28g_init().

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
part 1 -> part 2: none

Patch last made its appearance in v3 from part 1:
https://lore.kernel.org/linux-phy/20250926180505.760089-18-vladimir.oltean@nxp.com/

(old) part 1 change log:

v2->v3: propagate the potential -ETIMEDOUT error code from
        lynx_28g_power_on() to the caller
v1->v2: slight commit message reword

 drivers/phy/freescale/phy-fsl-lynx-28g.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index 4c20d5d42983..f1d0e0f29fcf 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -1296,8 +1296,23 @@ static int lynx_28g_init(struct phy *phy)
 	return lynx_28g_power_off(phy);
 }
 
+static int lynx_28g_exit(struct phy *phy)
+{
+	struct lynx_28g_lane *lane = phy_get_drvdata(phy);
+
+	/* The lane returns to the state where it isn't managed by the
+	 * consumer, so we must treat is as if it isn't initialized, and always
+	 * powered on.
+	 */
+	lane->init = false;
+	lane->powered_up = false;
+
+	return lynx_28g_power_on(phy);
+}
+
 static const struct phy_ops lynx_28g_ops = {
 	.init		= lynx_28g_init,
+	.exit		= lynx_28g_exit,
 	.power_on	= lynx_28g_power_on,
 	.power_off	= lynx_28g_power_off,
 	.set_mode	= lynx_28g_set_mode,
-- 
2.34.1


