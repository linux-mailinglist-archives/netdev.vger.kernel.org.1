Return-Path: <netdev+bounces-236824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5752CC40627
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 15:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 71F6E4F372C
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 14:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D422BDC02;
	Fri,  7 Nov 2025 14:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ht6NIbRK"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012026.outbound.protection.outlook.com [52.101.66.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6541713B7A3
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 14:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762525969; cv=fail; b=XbsAJ9QWfYAvimJwL7nLWjkB3n06avzz65XE3lEwLuug9m97FUrJox1EWGii39luEVzm5PNvDL6nttn4QmxkgNb1UL6XkPM2XjjcrOFC+P2S6AzvC6kTErMcg/RMOy6qx2CFPk+Eu43Kz64KEV1C0qzegMvGAPc1sGTO5SI+GuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762525969; c=relaxed/simple;
	bh=QtqCd+UZQQxu6MrT6bEvkSu68twtyAg9xp6qHMzuprY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AAcBiM/uWwpA/BiJWCKi66CAO9UTeovfUmEatBlyw4EoFbaUHghJy7nRgKdbBffsYznzTvrgJHhszvyU1fEAyBPWdd+ERkM/en6F8HgTIcDPGS7Gnw3ecNnlJfErF/qnQEiubttx6oWdeyomZj/vg8W8VrZyypLs0uKtVP2hxzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ht6NIbRK; arc=fail smtp.client-ip=52.101.66.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MXn2w8L6iiXl75hz/beaGbTFYThJNLRIWvs0zk4HjkP7rQNo9ptpg6DDZBeEd10cCHZ8B1V/H01SPrWss6+ciSKVXlzGwBAHLtjTm5LRm/iKKuD+enfSjxG9cgugRTP9s86eo3CJ/K/G+XUTRm5AFgXtv6cirQ7lujIcPjHYWIZ9n+v+8g0QRmlHBU7K420KD8zLa+iV4ulbAR9vKzcu+eGOcutGtyAkXX9q8wv8aDIUkkxvF90k4T0VcfljslYQCePLTlXuahfmkv7tZnWRJEe2S19jv/uOr1otIpLk42DUU770iVvi102T/E2rMSLu5vb7N8e/DgO4KYVXI+1RWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IujoO2WeUGogVy4x10p6HQV/kZlo3SSHym/Z2wmVu5A=;
 b=N4MUPQ+T0RKYbrF6qK4JXjlT1t+m+3D8WUg+lFhmUXKqO69MMH4tV3NdPoTaqavLuANBcyJvw9/6fkP5J3iyWoC5vsBJRJ6xHhqAnBgigEIH/wCT6z+fyDZIlNDZBbW6LGJ/1tlCWhtImNO4ZTvBqU5voiBWfScmbhXsI1ezt1cYM8Hx0y7ui2WnydYBOtM1i7pqh27S8frlKoHDot49ns9PQqeDZUvC2Zs663oTflAvTHFwWDWn/WXtfSu/Mup5F2Lx5pBL/YAf9TModk9ZGcU1UIQaL1MxNXGaANvgzKpjUY13h55CDsG0rbl7807ACC8xWyNqltBeagphPuxdTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IujoO2WeUGogVy4x10p6HQV/kZlo3SSHym/Z2wmVu5A=;
 b=Ht6NIbRKsTno7XIVxhCWGnaHX/0BdoVqHvdYLX7s114he0le5tDhEFTKRSnDsHPj6nkbIIj5Sg7l9yH8cylzstywKxjZVaN7RqgbXL74wSL0afCHTqsAirJP1VI8q3kDM4+kBMOAnKXWMi8V2HgVZUhhhoxVUX+RIGo/Fcf4Vf5TUTM/8rP/hmu1tnLODYL4ggNQjg1JhE4gDAfS5vM7QX6C6MnkQmEPPVw3aWxzwvr6vbq9/8HIRKwOS29eWiKYKsDiytGABgU8NeDpCeD3uCpl8S2lf/7RAIZ1AdWMKRpejfvJZgXtnf4UPVeEwPoMAf46jNiuisyasqrLkKW9pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM8PR04MB7201.eurprd04.prod.outlook.com (2603:10a6:20b:1d3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Fri, 7 Nov
 2025 14:32:43 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 14:32:43 +0000
Date: Fri, 7 Nov 2025 16:32:40 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek Vasut <marex@denx.de>, Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>
Subject: Re: [PATCH v2 net-next 6/6] net: phy: realtek: create
 rtl8211f_config_phy_eee() helper
Message-ID: <20251107143240.7azxhd3abehjktvu@skbuf>
References: <20251107110817.324389-1-vladimir.oltean@nxp.com>
 <20251107110817.324389-7-vladimir.oltean@nxp.com>
 <56b1deb7-2cc4-46fc-9890-bb7d984bed55@lunn.ch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56b1deb7-2cc4-46fc-9890-bb7d984bed55@lunn.ch>
X-ClientProxiedBy: VI1PR0102CA0054.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::31) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM8PR04MB7201:EE_
X-MS-Office365-Filtering-Correlation-Id: 3868d5dc-8cb7-406c-7b3b-08de1e0a833f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|19092799006|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AtE0VudcyIbFdFZb325Sgve+ZcAUPNOwVlIi9Ij4NKrKV0lXRbR3x5lMgDGp?=
 =?us-ascii?Q?gVteX3T4EjWytOiLeAV1eE/C0WATQgWJVVsWp7H13dKbgMm6Av5jCHMM0Qz/?=
 =?us-ascii?Q?XSUF08bbWBM/jUOFHT5C7nq8GBPzqk+vpUzkFpE1clizuazdXwKgvdnjEzf2?=
 =?us-ascii?Q?q1FqNY8vPzTqbHpJwb+0UAr5H1r8ymqzpeEa+dGax01Sc9HJNgs94MvCJy2j?=
 =?us-ascii?Q?pF/F6JTGiacW8Xv4yc0v74Qm8UifU32MUndTUJmbKgbj+/IB08bK/hbOw3Gi?=
 =?us-ascii?Q?+VGCbkc2MbzhLxBkGGiXWaBtxB2ANoCmIGz+OIf36GxYa4vAnHWr5SpHqZ1u?=
 =?us-ascii?Q?JC/1F3lrnQLjw4ghH6lUuuwkDKtuxbV5mSiafCGzRf6Gy7B3ahO1M6ayBPKE?=
 =?us-ascii?Q?46t0M4Dj1BkpjFNVVLYWX3yXJb3vT+ecEEjykU0lEMkvu6wZ6LEqgIAwMhjt?=
 =?us-ascii?Q?UhEQLkYDBvWrd3UOn57iHQLzqPmP0mSKkAP7vg8KK0t/SmfjkUYmQugMAdjH?=
 =?us-ascii?Q?Ho3nL7YeqUoHR5oqjrq0BOB1MwkgJBXEejsA6MJUDtFidDAE0O12MSzkVY1e?=
 =?us-ascii?Q?kJt+A6fWfWK5xnbQoECRwW/w6PhAuF85McqfFDPl+ljW9+/v7fXEj15i+ItE?=
 =?us-ascii?Q?QiHE0JZiGvcejVzWhKdSnxAveYwHgSsoR3gzM/59Wnpr+WMVZ2YGAnyW97fC?=
 =?us-ascii?Q?hCLcXYSkdbgrLSLGmfV1r6BlceTEUMFzvqyEh4RDIlinm97atnJG7uv8H1+P?=
 =?us-ascii?Q?RYEo1dLfiFBHn4Ew9TFFY16eM0UmS4fQc7atKzYa6vyTvqxdbkyhBO3rFA7+?=
 =?us-ascii?Q?ZltRx9qkEUfrChdfxWtDQyGpJr8/cTioyNycr5dv+j8oSR+IYtyX7h5bnBj/?=
 =?us-ascii?Q?tULz1sQ1pQt9cbtGt7vHNmIR0mz/NBk/MyeII/rfj5YPJ1iCFfGD7oO6vh6K?=
 =?us-ascii?Q?XqP+4eJmCvt7yZJDi/EeCTdtFmpboB7zrgA0pIgaKJ6trlpo0ysArgvhrWIP?=
 =?us-ascii?Q?EBxwy4WqaEsA5RgThYKRwbKCyXupkWOWGhoVSWkz/encvBIGC64XCFVDkyRJ?=
 =?us-ascii?Q?T/KQkE207uKLTPLiwvgh9FoTKUNO0BNN53bWakrcDlOBR1YxGpUaeUV7pnw9?=
 =?us-ascii?Q?PzLzVIbfwULv3U6ihC5Fw7nMkaXYUesHAHwTmxQfGDfmShGjK/hEaOo6wS3Y?=
 =?us-ascii?Q?qTxtlOKC/7txoCsPKLuGYIkK20FMcnCHquFwWFXf7Iu73MwkCEHLNY5DaGp0?=
 =?us-ascii?Q?qbX9OM2RXEcx5ulOZn0iaCNVnWq1N0fJdfzdxSzUwlWe42god8uji+XOFKKv?=
 =?us-ascii?Q?R0gjBVG1ncNGCb50ggidnLyCd/6KXLB66HrnnhzrAg0vziyhNTzrUII4mQZy?=
 =?us-ascii?Q?Q+APtyrmSdj/thwfc8ItiZfNrHNBST0OIyx/70R75p3IpSr3Ag=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bLO1S3xE8NEWoRPKdocHkE5fehp/6GswBI4Fc1Dr7ho1+92Yyx9jp205n+1/?=
 =?us-ascii?Q?pYN75vmUGk285CC7nLPFsNH8lhOqf02U1rwvzl7WMuwSpZjiBEt3w9ffrKDK?=
 =?us-ascii?Q?pNvTJbdj86ZeqAeHpt2xTC9WsqELeILgHBkP2dqQW82/2M6l0+kUkVPy3BFQ?=
 =?us-ascii?Q?2c2q1pZ1r7OKZ61b0gym9hrMGFGFZIFdP17Uk80mWbGCWWPDJ2MG/RKf3IL4?=
 =?us-ascii?Q?mboMGihQ/2zlpH2linlWlvita2BH/lorvAWBPqH0GHVlYdbUXxW225FUUPVr?=
 =?us-ascii?Q?ztbC+CULLyTUa7hauB/WJwJioOYn2iPoCMWpGAsIHZaOMzvjIvaAmC3XJ8ma?=
 =?us-ascii?Q?Iz7qosYcVMHBvv9NMQ6aqB7K0/iZsqgABaHoso6UmVLsuDwyH9EI5mSphOR6?=
 =?us-ascii?Q?y2l0jbFiNnKQ09F4Os8LJKLrKSaI6XxOnlxc+aKK81+CDpQNxlRUlwkfr0xU?=
 =?us-ascii?Q?pK6Ms0YwjMW1RC6QobKXSnfvapR8orkif7FJjoJuDszV7O0cbcQx94z+cSRG?=
 =?us-ascii?Q?VlfEJLWzwy34ClXmo6n/OfuNwOTWwOPEAa6XI0G8dT85oS71Uhh6NA7Y42RQ?=
 =?us-ascii?Q?oirZqLmHORAKf1pr9pErwlh6fzfM/THL/DR3CKzPccmy+/jfWv/H9oXCT2qg?=
 =?us-ascii?Q?o6ohIkkkYT2fX96TaWSmkgtH4/3KZ32gMCbQ57nPxO1JHEJg9Rij+eZDcDA5?=
 =?us-ascii?Q?sjdZdOIoD2bXSB9UUCoVlB/pMGS8rFCakrBBN3Qlmj/yvDihQkARXCBawWF3?=
 =?us-ascii?Q?IDKwPfID4sAM3yhYG8jow555k62HvKY8oa/QFUdxgPse0pgVOquZG7ksNoJD?=
 =?us-ascii?Q?oYLF0uFjANHw5EQ8B9KomcmdFzNVZ6L1MiBYRFZ3Oym1tJL5HlubjPLQ0ebv?=
 =?us-ascii?Q?kVTxykemV0T0hMNjD75AQaZkQSPZn79Gr3N2ExfqSteCMMmBJEqy6IDX/7xk?=
 =?us-ascii?Q?CBmmztHt4SduXj59vJWKMosW28bAi/Jpb+dbc9C6oTrc8JdBpJWXIDiQSfGS?=
 =?us-ascii?Q?niYKvtFhosZypHTsu3i1k3b5HVytqjXo9SFObscJt64z8YZ0mWEcUC6gj2rg?=
 =?us-ascii?Q?/nV94/Xt9vtQzi7NAFT1qqlT3ZBL5Ge6uo3+eJ7CrEI/4oy0I4jdDDVkA7IP?=
 =?us-ascii?Q?rQpmESyFA7RIiCrKS1upYdlvg6BVB2ecmhaReCLFR/sqFDO3lCccWXQddJAH?=
 =?us-ascii?Q?ZX3LZ9Wto2GletuNWnxHwz6P8oi3C+S51MTVBZcSHw5MnaLvkClKcTIKmWbv?=
 =?us-ascii?Q?T+jo+xtGs2P6xN3pNjnuaEPyRRqEu07p2KxkADYxoBsoi/oppQ5seBScpOT7?=
 =?us-ascii?Q?kn+qx1HQ4348BJEFqw+wxCQ5wL7EcvnBD6m/7GBbdJQWTAG0dGfkNSc3zrgc?=
 =?us-ascii?Q?BxocWsDO8XLFlQ4MvtEIwjbqNSy0PDOuV93HpQJbh8w0z7eJgcIVjropviZD?=
 =?us-ascii?Q?4m3+l8v29gTHeQqn2fkK6csZF1ev2koMYOidK3a8Ko/I54K5x0/+NcnpR7aJ?=
 =?us-ascii?Q?UwNZorNf9Pbtn2GBvSEsnHZqwfEeKf/11Qhi0RUA4gCzZgUJhz7+PyDIcDyF?=
 =?us-ascii?Q?H1ZMTlkZ51oVlZcUlvZ6ZxUdUUQJXnpTMhnZzxz8/PHhtz+BYBV/p8aDnx4I?=
 =?us-ascii?Q?ilKhNDeo9OakEL/vqbi6/5VUXRJ4uZA3eZwLw9hAgcEznqKD1tm2baXow7GE?=
 =?us-ascii?Q?kApJ6g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3868d5dc-8cb7-406c-7b3b-08de1e0a833f
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 14:32:43.7996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bNodK/SXe89w8iDKcOUwP00+FhH8WSH+L9KTIkoLS6lrT0kuaqmU6nw+MeU1dc1ll6d0hyRjoTzFbHjtXkHeYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7201

On Fri, Nov 07, 2025 at 02:34:54PM +0100, Andrew Lunn wrote:
> On Fri, Nov 07, 2025 at 01:08:17PM +0200, Vladimir Oltean wrote:
> > To simplify the rtl8211f_config_init() control flow and get rid of
> > "early" returns for PHYs where the PHYCR2 register is absent, move the
> > entire logic sub-block that deals with disabling PHY-mode EEE to a
> > separate function. There, it is much more obvious what the early
> > "return 0" skips, and it becomes more difficult to accidentally skip
> > unintended stuff.
> > 
> > Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> > ---
> > v1->v2: patch is new
> > 
> >  drivers/net/phy/realtek/realtek_main.c | 29 ++++++++++++++++----------
> >  1 file changed, 18 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
> > index 4501b8923aad..6e75e124f27a 100644
> > --- a/drivers/net/phy/realtek/realtek_main.c
> > +++ b/drivers/net/phy/realtek/realtek_main.c
> > @@ -684,6 +684,23 @@ static int rtl8211f_config_aldps(struct phy_device *phydev)
> >  				mask, mask);
> >  }
> >  
> > +static int rtl8211f_config_phy_eee(struct phy_device *phydev)
> > +{
> > +	int ret;
> > +
> > +	/* RTL8211FVD has no PHYCR2 register */
> > +	if (phydev->drv->phy_id == RTL_8211FVD_PHYID)
> > +		return 0;
> > +
> > +	/* Disable PHY-mode EEE so LPI is passed to the MAC */
> > +	ret = phy_modify_paged(phydev, RTL8211F_PHYCR_PAGE, RTL8211F_PHYCR2,
> > +			       RTL8211F_PHYCR2_PHY_EEE_ENABLE, 0);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return genphy_soft_reset(phydev);
> 
> Is this soft reset only required for EEE? None of the other
> configuration needs it?

It's good you point this out. Somehow, among all transformations, I lost
along the way the fact that the soft reset is necessary for disabling
clkout on RTL8211F, not for PHY-mode EEE :-/
https://elixir.bootlin.com/linux/v6.16.12/source/drivers/net/phy/realtek/realtek_main.c#L598

I checked the RTL8211F datasheet and it doesn't say that changes to the
"PHY-mode EEE Enable" field would need a write to 0.15 to take effect.
But it does say that about "CLKOUT Source".

Curiously, the RTL8211FVD datasheet doesn't suggest that modifying the
CLKOUT source needs a soft reset when providing the steps to do so.

Anyway, this code transformation from patch 6/6 is not buggy per se
(even if we change the CLKOUT on RTL8211F, we still get the
genphy_soft_reset() that we need), but very misleading and confusing.

pw-bot: cr

> For the Marvell PHYs, lots of registers need a soft reset to put
> changes into effect. I would not want to hide the soft reset inside a
> helper, because of the danger more calls to helps are added
> afterwards.

Ok, I get your point and I agree, but what to do?

static int rtl8211f_config_init(struct phy_device *phydev)
{
	struct device *dev = &phydev->mdio.dev;
	bool needs_reset;
	int ret;

	ret = rtl8211f_config_aldps(phydev);
	if (ret) {
		dev_err(dev, "aldps mode configuration failed: %pe\n",
			ERR_PTR(ret));
		return ret;
	}

	ret = rtl8211f_config_rgmii_delay(phydev);
	if (ret)
		return ret;

	ret = rtl8211f_config_clk_out(phydev, &needs_reset); // RTL8211F needs it, RTL8211FVD doesn't
	if (ret) {
		dev_err(dev, "clkout configuration failed: %pe\n",
			ERR_PTR(ret));
		return ret;
	}

	ret = rtl8211f_config_phy_eee(phydev);
	if (ret)
		return ret;

	if (needs_reset) {
		ret = genphy_soft_reset(phydev);
		if (ret)
			return ret;
	}

	return 0;
}

?

