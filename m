Return-Path: <netdev+bounces-218688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C481AB3DEBB
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 11:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42F0E175149
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 09:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922D630DEB1;
	Mon,  1 Sep 2025 09:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WjUgTQs1"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013007.outbound.protection.outlook.com [40.107.159.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B6A3093D5
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 09:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756719607; cv=fail; b=K37tGU1GGL5GbjeIf9fOnQBo1fBH1yGoEAiA5r3rlaIEFd4+3g7rAh845wy5zVcz1x8z1sA2IIJAx4lp/uswdvSFD2GVTJt/9xB/CIBx5Ft0fhaPiYmb+rcSj343dmvgu/N/7NRVFDVVyXkmTDd6qQDlc2uTD3O8S38JX1/u+D0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756719607; c=relaxed/simple;
	bh=jH+0L4qV0kerEg5hXmxPcUIx0j4GCUkqa23lswIY2WQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cKaCm5dBeTxrhcZwffW6tCWi+YUrewZcK3nyPBeCNrDVS8UFmZhbvMRu1RoUPbZvPBWttxajm6Z2Oo4TXIMU6Zi9454Ik3OY1O1dGud8D8fBJG74oQUUDwFu9iU7Zzn/4VwFZzjBTTNOKB/raHj42gNJtVvQQwMbBYQ63TktPMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WjUgTQs1; arc=fail smtp.client-ip=40.107.159.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r8Z9A5CwZXK6fTyO/rLXlty1QjZ/qJv+Lvpx7CahKsG/6mRu8M00ozOHUBhkr9e1DTI+PUDrC9ZEhOs8YiQ1mP6xFpkUCYf1+Lhyp4ZZK/GiTjeYbSA3UlEzNpTqNFdet+0e37OygsTYKWgJXkry9RxrDddMmkkD0iAo7UKtf6Xau6gtbBJDPzkcAe7oTDOqF48MxGowX+ecm8uGUakkH70F3eW9+WTZ9SUTmFWCan5S/SNNzWYm5LoOkw4bOWzcrciq+7mscgfQym6CBD+ngzhxGTLTxibnFexWgBvfpqS60l5HdCptpFPxdQ3wJvQeO5NTx8+tR5TJhkc1Hr2YPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dwffvnyyoEX1n6F6E7RKktf+MtyEpjKSbeipeAVGwyM=;
 b=JcZzMajt0TBejIwBIhslzwhVJP6SXDg7X84QXIprkp+ENj3Ajosw25ha/h40KNJLV1q8zAL3eNAwtKoqDeqvM7OaWzJtkXGpPjsxeIfjM+XOJ3RFrhJ3aOwkq9iY+u/yzlltQ+JaTp27XAeNxfGobe0g4c77NFlI9b/fT5t9L3FBZOIB6FF6ljnZ7Bqnr56L3MIhxMxMlgDirOPV2id8Pl4tnSrjKLCD5+LKG0XPVR2SXRPGYCoGaw2evCFaKf47b/ICaHedFHf2CF28HpxSaFQk3awBSxaE2IRAleZ4+w4jOmNZ3pHwzIpzrBUQqKwO7Tsq2QIymKcOvAqcav3Cng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwffvnyyoEX1n6F6E7RKktf+MtyEpjKSbeipeAVGwyM=;
 b=WjUgTQs1i+hKOOWGYyyXCuTEsUFPPyqQ5SkOPaH/ufIvnuLh9Y73WBNELRt5wflL6bG9a0CbJzQriEfZfA6AqDAE0t33JfApcpUeeHOGHF009HX8mFLIl47RPxw4TgzvSDHFK7HgC63+eeP6WcFVaMSd/ftYM5PvfanrKMwmqdwldMkty0QdQKCOgxgAnjkwgO12XTVUDWRh7Hx4Zt9aJOd6EIIxVcjqkxnA/TtAYYnM7NUzniLXLzVuOnFEac/BFkrn7LbE1YPy4VhIGhdE17fI1f1mEfvhYfzU+6g/+LuwW6nHPvEIHS4kpPf8Mt+Ckm7CqI7ix/+ko1Fj9JdTTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.14; Mon, 1 Sep
 2025 09:40:00 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9094.011; Mon, 1 Sep 2025
 09:40:00 +0000
Date: Mon, 1 Sep 2025 12:39:57 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: phy: fix phy_uses_state_machine()
Message-ID: <20250901093957.qfqnpqme7fms2tbv@skbuf>
References: <E1usl4F-00000001M0g-1rHO@rmk-PC.armlinux.org.uk>
 <aLVosUZtXftPC-OY@shell.armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLVosUZtXftPC-OY@shell.armlinux.org.uk>
X-ClientProxiedBy: VI1PR06CA0121.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::14) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM7PR04MB6821:EE_
X-MS-Office365-Filtering-Correlation-Id: 7722e390-65bd-4229-4209-08dde93b852a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|19092799006|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SNKcneL2NbXwTWl1QCOZ/2DviaknvZZoCIN4IqWxltjH2lnmwtnKQtyp/tAM?=
 =?us-ascii?Q?LZcQte3Us9/Cl317L9kjfpn98Xohiuwsmh97JE9qYT+pBYUI7fdgaV0z6+/N?=
 =?us-ascii?Q?FaX7TGlBU96Dd2Fd7H9huIG9vHYWbmgE60c+tywDmJ3UN2VIjY4Jlfbhz0bA?=
 =?us-ascii?Q?8dUGgyPuAIld7QR905Q9S1joWveAryGaihz5N+UJGy8vu4LDgRjeY5IkTAC+?=
 =?us-ascii?Q?6w/RRqcoh/Rd/N1phZw+OY9QSU5iwhR06ZIfoWw1vw0AmKBC1n2ozX6RNUx1?=
 =?us-ascii?Q?3+MD0jRIMsucjuUO0QW7af0hYyY1O5VHljjM/pl9j5zNVZUkemjjmLne0t4m?=
 =?us-ascii?Q?DiV4cU/vDjxRasOjpztWx7yq5bd8PC/ocnBFrWMDKpzbluW5v5tjph+eVnzs?=
 =?us-ascii?Q?a81yUAwq5vUCOCIXof+KKP85VnlWavnAd2tUq/DMgeLG979Mq5sefr3SDN75?=
 =?us-ascii?Q?0znQAHIJyTWoigc475z4HJLe4vDaKVCv6IUm8hGpSqxGoYRJvnHsLi7kf65w?=
 =?us-ascii?Q?BuNqTFA/RPnKoM6k/6aXJHgJ/cv3UD8Z5UNHo4F2jz88E8s6Sq6giOh4+L84?=
 =?us-ascii?Q?HZGS1cq8H8vDvmgM/XufBsVxW5PrFAHrV0mTdguWG2+fZKkn5Xcj9fkr0giE?=
 =?us-ascii?Q?K/bFmtO3sOrYF3w2MhaMbq/qIkrTwVCX+cAiRSki1SDpQ1f8gOKw9A16MpBw?=
 =?us-ascii?Q?Vw5JRj6iTlJlQsIqkqFnefafxeX8PG0X2wfCQ45RcP6hmGfhwYtLRI7GbMan?=
 =?us-ascii?Q?8dBSJLyz+M7i9jNYWppmPyKJ+RonFeqPli7HED4kI4RTg0m6TM+5I6rd9oUD?=
 =?us-ascii?Q?4gW6GDUvWW3LRi7vxDpNTH26VIe76V5em4WbHvB3x/D26HqXkC4M00wk80hl?=
 =?us-ascii?Q?xuLCQW6aeWreFI89AzlqA3rPEjgMZ46asN9dB8GGsE6c5uou9Ec0et5mD+QE?=
 =?us-ascii?Q?eNujiLWyCawEr6waBK9YYH1oLJsnhMuGugSXC//vbZsr9yojJyWwE5zeAKa6?=
 =?us-ascii?Q?mmJD8yVl8Vg2sVrKx0MSN2iQdIfk7EV/aACGskx3IjB7b/8cm8ordzMM08sw?=
 =?us-ascii?Q?KLRqpL3ScsePkQxM/0nvdn5qWz9elmxsN7aJ6fUMny+JWHNVWcYQAaxytcNf?=
 =?us-ascii?Q?zjGS76UqJVZ0ZVE5RI8ObGZE3uHyrTE0SELGMkXyoQBrop12Z4LGaGXPNmwy?=
 =?us-ascii?Q?s7gklOeKbfjyGC2iH0NHuMkDOxtjgW1IhXQaRD7u567KDtiYUBrZe1aWj2Ci?=
 =?us-ascii?Q?rmPAc6mHyK1fmEewoSePA6/P7aNRuSThUT6B/Q4F6bt+AaiA4E/uXKgkrlUU?=
 =?us-ascii?Q?14GtAHVjCjG57VawgPtzjmwthmHpo9yBH79P8pERuQsE0cUeHBm5mBXfteau?=
 =?us-ascii?Q?iq8VEc4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(19092799006)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1O6O0eev2rL3PGxKfemNPMLDamANS4ZGhJryUbGweFmcI6qxu/7tBwyV/vHH?=
 =?us-ascii?Q?mAIlrmmqoOxDpShrBNN0TniTbY9b31I3VaYrhlLgXkS+UwEQoWHqGToWkT4m?=
 =?us-ascii?Q?GbW58FjpMae0OStXRMlVmHF21aCLlgCLR7RMmuJd2zo5yOgJuJ44XK58FyP7?=
 =?us-ascii?Q?SDGEJmTQ3mkxsM4x3/Gsz408zImq0VACcuOoESVZ+4D/tUas/VLP2ASjbkq7?=
 =?us-ascii?Q?mXYlJmYsLVuDx56hfnRWfJbu2POQKxSV3hRSRNZOYQKo//JECrOuGuYLS1/f?=
 =?us-ascii?Q?Yv1t+mrQJFWHWgNn2AQmb3yw7VixLo2AJKYRtr69DlWYr3DmnpufjGeYtqt2?=
 =?us-ascii?Q?rXW0gVjs1MVaMBD2VmgY+6hHGrVBfYBv97I01sdiZTEnIRB/GJh0KxLeXmd4?=
 =?us-ascii?Q?er0E+uJ7OtrFlGtAPnBEILrs1+sryvJeBUrXHSQjK5AUtSQQU16fIZt48+uz?=
 =?us-ascii?Q?udErvN8PYfmHTwIGvdBjihZW94f1n2sDlnkbN7mUn4qdEWvd3SvTuwgGfysI?=
 =?us-ascii?Q?KKh30QoWI0+40+mlPY/oI5iOjkJqqLIIzg/icMf6uAO/RsE54nrTxolLThm4?=
 =?us-ascii?Q?CfmPEQSltWWYVoJZg7FgfRNIGMKCK9/sRqAjOqC3XniVbqEd/b0ymR4S78qI?=
 =?us-ascii?Q?GLTVeqo+o12/PWdL9bDZpnC9bx5VWSUsRSFpNBSPdjexF35aF4QUqaRbuKtn?=
 =?us-ascii?Q?GaslReMd3OUQ02h9EojpqiKRLlFf//0MuSTvdEqnLqvHdILVt7l61WwCuuIB?=
 =?us-ascii?Q?6MjBtEZBEaBtl2d3eKLSMMrmh2ERBI83H/t87s13X2+xeR1F3uPpxvLzOTHO?=
 =?us-ascii?Q?as8UDbmd7IvWwMoKkK+CmZxBCfvNEo0Ooo+3eV0xOmLBsmCnloPjd7kmELbv?=
 =?us-ascii?Q?suwx3yTPwquSWbLvLpeNGV289RMTtiVQDf5dikjZaaqYVvjXRsEW/iX774rU?=
 =?us-ascii?Q?jhu8FmTSI1q2LV4iC6C7RcqZkz8bQKCiDzrv52bciTVHRUxhHlFB58PW6w86?=
 =?us-ascii?Q?qKPxnXR4DdrJQyzN96969HLNhAboTA/Qceg62LuXXNPM3aSWWJcHH+QIDTqY?=
 =?us-ascii?Q?3hf1b1WQaRTofyMJYJzAzT7atpXiZgscW/MyjXtU+TrYftdFwVhIRGY7H5Fc?=
 =?us-ascii?Q?0dpqg1nxsnQAdqHFqvvYSqQO1Sp/LCCImT1cGMq0eruGBzsCG4E+KLmV+xig?=
 =?us-ascii?Q?7BbhV9Xo6Utv2MJi8gmQ0wfw5DxcAs2pb29vYxBjjDPM8Qvgdsl+t16R78va?=
 =?us-ascii?Q?Fzf7hq/HJGPdfC1GCS168CrN3IKVfw2MjTc+jztAwT3r4XnuxEW1QABc87x9?=
 =?us-ascii?Q?GB5kek2sSkvpNDJwmka+2JHjUD77GJD44hmr2D5p2cvA+sDSQdPbnXMH9/DW?=
 =?us-ascii?Q?SNvCIejWY64k76kbtxC+G67dB1tIKiVYKKuz8c2HfGmEsRP/SCmxAajZDwxt?=
 =?us-ascii?Q?krgXZMvAZ+i4WnQBKTEMhFsJHdz7DIAio2DT/3ioJ+07znbfIVNE7MoIWOBS?=
 =?us-ascii?Q?PDbSI9q52FBKKszt9vBO8SmM1rFB7+eLU16WOOYQzZ6DbJWbapQyX1tYsiQB?=
 =?us-ascii?Q?jXEMc6Eq82rDmOiv/ATY07TBbpiakr9KSwVpNM21ZBBtZF4bC4Qn+4PBaahe?=
 =?us-ascii?Q?Qw9QyAAEUCtZHYLRQIH2lpQNbf8DYo4/p4ZQy8YIUvjtOYiCxLxWIq6b78lg?=
 =?us-ascii?Q?nUOnow=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7722e390-65bd-4229-4209-08dde93b852a
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 09:40:00.4568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qw2ICeycd+9s0QPvoSMukO8oExnaF867J7YrdVd4FuhZ+obnFX6WOjDE9K148l+b6GcjUeiSmMi1G2+eZuatRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6821

On Mon, Sep 01, 2025 at 10:34:41AM +0100, Russell King (Oracle) wrote:
> On Sun, Aug 31, 2025 at 05:38:11PM +0100, Russell King (Oracle) wrote:
> > phy_uses_state_machine() is called from the resume path (see
> > mdio_bus_phy_resume()) which will be called for all devices whether
> > they are connected to a network device or not.
> > 
> > phydev->phy_link_change is initialised by phy_attach_direct(), and
> > overridden by phylink. This means that a never-connected PHY will
> > have phydev->phy_link_change set to NULL, which causes
> > phy_uses_state_machine() to return true. This is incorrect.
> > 
> > Fix the case where phydev->phy_link_change is NULL.
> > 
> > Reported-by: Xu Yang <xu.yang_2@nxp.com>
> > Link: https://lore.kernel.org/r/20250806082931.3289134-1-xu.yang_2@nxp.com
> > Fixes: fc75ea20ffb4 ("net: phy: allow MDIO bus PM ops to start/stop state machine for phylink-controlled PHY")
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > ---
> > The provided Link: rather than Closes: is because there were two issues
> > identified in that thread, and this patch only addresses one of them.
> > Therefore, it is not correct to mark that issue closed.
> > 
> > Xu Yang reported this fixed the problem for him, and it is an oversight
> > in the phy_uses_state_machine() test.
> 
> While looking at this after Vladimir's comments, I've realised that
> phy_uses_state_machine() will also return true when a PHY has been
> attached and detached by phylink - phydev->phy_link_change remains
> set to phylink_phy_change after it has been detached. So, there will
> definitely be a v2 for this.
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

Good point. Do you plan to modify phy_disconnect() to set
phydev->phy_link_change = NULL?

