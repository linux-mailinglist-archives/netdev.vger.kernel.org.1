Return-Path: <netdev+bounces-219615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5BDB4257F
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 17:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5660D7BFFA6
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 15:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3EC2475C2;
	Wed,  3 Sep 2025 15:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z6CmRzRa"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011030.outbound.protection.outlook.com [52.101.70.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658D52405F8;
	Wed,  3 Sep 2025 15:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756913489; cv=fail; b=fiuZgxGATFZULD7ShjLveDTXK9fAppKRobF0zWDELpTXqljFijqHHjhwIwXSsEtWupQH1DLaXzfndpMuq9KoUpJzp137Gr77mlAl2KUfjjcUr/ELfsBhlFKDQtEdXe9D1f1zN68x5ug8PCGJyODIBTTXvQEq0xInAPCkbXrNXzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756913489; c=relaxed/simple;
	bh=TcfcNWcZ4jTN45ilq7k8M/QEozrCJfo9CF84CThcaKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fTQYrqC3fZUazQfKZ1sxp6jv0szAQkJFwyZp985YEBLeVu4bYNpt8Le36cL+f7iGrxzkqpQcJ82w8AnKoO0epN8icmffxoBR6oIKJltNN7LOA9z4+05s9N2xZszMuVQhHM9whmwOpEpgXkgqEY9u56UYfuD632LD/lgRdocSynA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Z6CmRzRa; arc=fail smtp.client-ip=52.101.70.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MvekWoc6WR8UZnGwsN5Nz3nnbH9YBUljIV5VPKMKypQq0Ig7u0wnYYn4QTsXnBlMacTVRgB2D6Sf2aTHeB8rWmaVm4KQvBBAJkA4JsBZvgzgDDjbsLS8D5xINuLF765x+dbxMR7cACCF/NHR/PO127wg7idSZDxmQmSEOtczCwe+fEcVi1EkyB/2xxiXIO7SCtnuX418p5qav9PdmyABC3SNxoY5ZQoGNYOHvx7tRxr3m4K6pKybQgplyzwxRQct9BDnyOctPHGSvfVk38p1h8aHHzzJVi5b2VbdE7MOedHgnx8aKF36yLbjCenikocy0u7U+oD4TT/oZq6OSKzLDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kgXelX63jYL9QILO6v7DzmvMnEjFrRsJZbWaINLxoyY=;
 b=JEPtwO/dgcqPiN7CcMAp5RDi5w3Qv5jevz67HF87t61pISAX9MLL9EAW5T3hUNZaf0HLYll+uEANfCWn/1PXD79Sh92dvc6v447BObJ/tofDhzNNKbtrUWunLOvKt78V5OZDCkfl+DWAaCwWunLlzbLImP5Um9MhQJCUrwC4IaSQsmoYugHslVOE2UZK3ICbSYE9Wdg1DxBDqBL7wzpi3u015gwCpla/HZDUwfk70GDQrETAChy8cmCsF0Ew5coJMjeHpVGr5N9M9hu0HHYQMVJeGZcdm8+2mNGBXo0t0zvXknArQ38JUkPkdPiO2qbgOEulkANWU5pbgRPD7xMQUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kgXelX63jYL9QILO6v7DzmvMnEjFrRsJZbWaINLxoyY=;
 b=Z6CmRzRawTbrjmfRL8rjuF0WWpdqfsvSqwmC7LoAxdJf9N7OPnzIgIf8cOSDUG/2qj9xmuKzmpIXhniwgRTY3qHUvgfYVmK3CVmRSGaifwMiaWkACj+znpFwiYziqnDG/PpCAbqEo5LqxHB9VtW1zXz3ZcXMyRVJey/yuALSWt77HulR2h5UNCLTwVZy8njTGlYZIBGGA6u78OvVkiY5yLswD5XeC3vm1nGoXi1Aqpf7ftGEsCegDsyVGqF8X+eK4lmWoSJYndve/p8tYsM3NiOKTKBjHCt7beVuopOZ0Uxc37Z5ePcdc83jlu6Ch1W/mD7LLLVY6x+to2bUqk+ttA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI1PR04MB7054.eurprd04.prod.outlook.com (2603:10a6:800:12d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Wed, 3 Sep
 2025 15:31:24 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 15:31:23 +0000
Date: Wed, 3 Sep 2025 18:31:20 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net 1/2] net: phylink: add lock for serializing
 concurrent pl->phydev writes with resolver
Message-ID: <20250903153120.4oiwyz6bxfj3fuuv@skbuf>
References: <20250903152348.2998651-1-vladimir.oltean@nxp.com>
 <aLheK_1pYbirLe8R@shell.armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLheK_1pYbirLe8R@shell.armlinux.org.uk>
X-ClientProxiedBy: VI1PR07CA0242.eurprd07.prod.outlook.com
 (2603:10a6:802:58::45) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI1PR04MB7054:EE_
X-MS-Office365-Filtering-Correlation-Id: 61f6931e-4799-47bb-e5b5-08ddeafef0ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|19092799006|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1j/gwHRBi3mvikZhf6HI8OqcW2T2rj/syaRS02N3CldgY5Wg3msO/tNujsoj?=
 =?us-ascii?Q?lnnEUg7wAdK7HzJd2eOOUYx5ItCQwiqxbMpsnXFriK/IfT5Px5yraE0ckG3o?=
 =?us-ascii?Q?pDDqNBUNcJ0m/J3ZI0+EelbqB4sZfNhQRFTd+r8vu/mA+2tqSfwECIkH7M3Q?=
 =?us-ascii?Q?8FyKONAuVAcpZFnkvuJJouGmM5SVLzBdwdjb51zGl6KR3oP4UdttLIy7v7xC?=
 =?us-ascii?Q?DhW0bEA/WfuK1/Htt6BLKfecYD464K7Zt6cfFvp0FqAXTwfFqKhZkXaklmj9?=
 =?us-ascii?Q?V5EZ802lXjXFL0lhLaagXyjK/JLdnHcywHPF8MRuxx5t6V+3lvoY0Z3cagox?=
 =?us-ascii?Q?4/vIjkyc2OuogdPtSVl707NqkKofKfEqRbeCOPQVtpIZpL9qWnJPS9hGshf2?=
 =?us-ascii?Q?mN9+SiezAU/JWhfUKn4TVowkfg8cFkEx4ueDW20wlQ/ziAhpJF8o05BMIgX6?=
 =?us-ascii?Q?wUYWmPal4DAkFh/tlKOgD4Wzu3ynRJRDUPoKt+5EJSlfy1M4qUbEB+6e1qPl?=
 =?us-ascii?Q?PfsiOyH1kPFMcnQ3VEVnpdm5BNzEACcnG3gXUrHq29hdDn0cRkbrnk38r/ao?=
 =?us-ascii?Q?TDFy3HJOcLh++NF2zDwsXm2lxgDEY1hOohUXEGn34KbI4v4bIMXrtvbBL3fs?=
 =?us-ascii?Q?jTAKfn8yF3dSeylQBN7M6u0IXDl2alfNJnarHJCdw0G0yXS9WEhOyLTDTK0A?=
 =?us-ascii?Q?x53dQN63Djk1iXceqk9uaptBvYSkigx6HZAXH2Njniqi5asJN3Yte7DyYS8A?=
 =?us-ascii?Q?Eo19NqBJPiLFjld9S+4+3aThkquygTgU9Sw4RsAgfHLxyCzKCoWyfwaeEV2f?=
 =?us-ascii?Q?teEdsvEAarqxr33OkgH2dKcpYOzchJeUMNsQmREhbwV1VTQkLOWa+Yb79OW8?=
 =?us-ascii?Q?zIO3svUlwJQJGDPHDFzdVkokj7kp5mBIQlqxfczn5Q+v7Puft4GrirjppAGl?=
 =?us-ascii?Q?MTXk7FLZY54hTi+zAXc3BHSTHnTr2m4pXOdtdCH7M/JSeHZ0Dvw1wR2UZqkJ?=
 =?us-ascii?Q?A5ThK45J8F+de/924lzLwTfOfzwRK48AJqJYusCxOWgx/wHZvfplDceP4xV3?=
 =?us-ascii?Q?KIv6sHz56gpZuC1FXT0OgbE3iF1thTMBISQYb3fnPryqjkFx5QgLFwA4q40n?=
 =?us-ascii?Q?fFDIbXNAu2eTipL3MFEAfwqsf3KwGVUDcBR5e2gPLz+mW2GG2riFuXhNQHHl?=
 =?us-ascii?Q?kU3UJtb/6xW6mfyOEY826rYkK/bu/9v2vG2IOA9gIsx0jkyav3Me2h3F4VNu?=
 =?us-ascii?Q?1LzW7/utydl6E9xG0PBqF897/671Bn15DYvgM3i6FhliPSREPYBxPzHOxfgT?=
 =?us-ascii?Q?Fb9nX9P2ZiK4R+CqwdaINZQz2ODHAYkjyDIM9TRHIp4ur7iczAUIHclpaLhI?=
 =?us-ascii?Q?UkUt1CaoXjCZi+fcBWeqqGdMRpqmOipQyf9jBLBrxmLiMUoelo2ZnLjMBQch?=
 =?us-ascii?Q?buGfTH8wKgs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(19092799006)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YrlRpiyod22x8Pu0j66Ra/olTo60MknC0PQJq2e7pkuBSJ3+8yQvnG0PY7dY?=
 =?us-ascii?Q?H8BCVR07vjYTW+eeAPJaoXA+qMmX0yvvxbUT1zVbRAN9bSmWx+k8ObExR9uQ?=
 =?us-ascii?Q?LAHhhXyDvnrLZvUYLTf+10WvnKRpQ36rKs/xKFKtT2cCRyuf3Y2LJ+USPKb8?=
 =?us-ascii?Q?zpsOl1/w8KoMVTRxlO3+jsJ08n5ejQ03B6NI1y5lP6Qf4oUOylCfsO/qGvy/?=
 =?us-ascii?Q?UjEszt+yGIkLCvzD6MNuc3qY1AWqrIu2thdws7xiVyWzjZ2eaw/YH7QzkRO6?=
 =?us-ascii?Q?yyoioKDoCZb11XT2xHusejZjnY/vi4bMPhzMqj5dRibME2R5ZV53vvN9Ircu?=
 =?us-ascii?Q?aiTcfjIsjD/mQPYkSPLNZPIk+A3m1WoNfUsLK4XFuSsJQ4uo5R9F8UwIA6hy?=
 =?us-ascii?Q?G8d58+eQN8QR9l1qgx9OKNbiUiGNuIzex6CYVicJSNKLiVndvtk9T8yZyfxc?=
 =?us-ascii?Q?UMC1wmpHz3QQxzegYSBerGPs0Y0sQ1L0io5Q4JtUFC/tmNRVbkX9a3nxm03z?=
 =?us-ascii?Q?6Fbo9blWSlsFgJ5Fn8H446VS0hlgYVFrOY+eupCrOhd8NjJIGMa2PUjdKOCt?=
 =?us-ascii?Q?ffLgqHXaVJUKjBFMFYH27YDjnnEUmO9VrQWkWMIZ3EKihlb4wjCjnJGwOy8B?=
 =?us-ascii?Q?HCycwiNqmUU9ypWflA3LtEMrFhcIxiotUgVFUAHf44nspmB05HJ++Ajjm7hb?=
 =?us-ascii?Q?qD+18zjakyrXfGtkIm6ZDHn48DCGwxXkqWgFCaSGvnDZrEx2YM2r84rxMO8X?=
 =?us-ascii?Q?YGTUNbjd3dTRcG77YyYuxBhTf1xZl5sUeboVoydjnI7eGx7SSWpA0x9L2Z0E?=
 =?us-ascii?Q?MSwQ/p3SgiALMeBdbXzEkWpC9W+wN3a38wcL8HbkAUjEilb1oR49eE1UAt2w?=
 =?us-ascii?Q?Tw2aI73c1Ixr4G53WzN1YvgGL7YlmYI0esPJVkGl1cLfaMzGkUDtp/zm97kH?=
 =?us-ascii?Q?p5a0aCcQKvcszeK+g2Eg+WxeZ7fwXXPwBiEajPQrvebZynUDnsxK4Su1DHPj?=
 =?us-ascii?Q?pMreZVKderaM4oa3b1Oh46I7aKpYUUD6rcbWo7O8zy2vjlheAFg3g1DrGfoi?=
 =?us-ascii?Q?72Qc4wB/EG131QIoyQu9L+RF60XHLBX/6ytgAUqJZM2p/BpQ3GYxzXaPyAyQ?=
 =?us-ascii?Q?8tSHz07nLjwfkEkiaz7HkZLul0fl2spQADcFKepT+5ehD+NNDUxboIi/36QT?=
 =?us-ascii?Q?hDKdZtc/F0LQcES5HcUZab34j6YxLXwJtzdHQ6BqiqOTvQh9ZLXFPMZOHTvp?=
 =?us-ascii?Q?8hgtUKn3FasMLLL28jB81BGbVugU7WU9VqBThyiXJRqLn4q/DFwM+3naVlOt?=
 =?us-ascii?Q?cZaHoTVZU6j7u3oYryK2PRBq7XskfvMHnpuf9FcG2a61oUg8N1ErxtRpnNEu?=
 =?us-ascii?Q?kjfzPED3OR6bb3us/wNvyO0FSOTK3isQj07agfmqJf/oM7YSiB6rvFRRvTqG?=
 =?us-ascii?Q?Z+EBx3vsFwK5azlY+ct+tCfrimTcbZBNcGQF71tY7x1CV5loD6qw40I/wJJ1?=
 =?us-ascii?Q?j5P1p8EsAv7SCo86XuKe8y2CHSfgMQJepyVmq2zMoiBKHpzOvQpiabnmhqqh?=
 =?us-ascii?Q?HmkSgpMH6J9P4wVMl44DmvK0NmImUiVGzCiMdzPgBfo6AO1YCsPaF9yiPHPo?=
 =?us-ascii?Q?2HvUFDOQ7vU4NUNyne+OK5mtr2eZOsaTHOFVvMMPMRofJAv69ySRTGoT/Zue?=
 =?us-ascii?Q?28yNkg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61f6931e-4799-47bb-e5b5-08ddeafef0ae
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 15:31:23.8638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: esVwcUqU6v+Y9jqJNOkhEjXxV4rDw9+JTCNfRjB10yk7CyXPq29M1MpP2ILGsuiR42mlLDj/WgdbrSLf7dxYag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7054

On Wed, Sep 03, 2025 at 04:26:35PM +0100, Russell King (Oracle) wrote:
> On Wed, Sep 03, 2025 at 06:23:47PM +0300, Vladimir Oltean wrote:
> > @@ -2305,6 +2314,7 @@ void phylink_disconnect_phy(struct phylink *pl)
> >  
> >  	phy = pl->phydev;
> >  	if (phy) {
> > +		mutex_lock(&pl->phy_lock);
> 
> If we can, I think it would be better to place this a couple of lines
> above and move the unlock.

Sorry for potentially misunderstanding, do you mean like this?

	mutex_lock(&pl->phy_lock);
	phy = pl->phydev;
	if (phy) {
		mutex_lock(&phy->lock);
		mutex_lock(&pl->state_mutex);
		pl->phydev = NULL;
		pl->phy_enable_tx_lpi = false;
		pl->mac_tx_clk_stop = false;
		mutex_unlock(&pl->state_mutex);
		mutex_unlock(&phy->lock);
		mutex_unlock(&pl->phy_lock);
		flush_work(&pl->resolve);

		phy_disconnect(phy);
	} else {
		mutex_unlock(&pl->phy_lock);
	}

move the unlock where? because flush_work(&pl->resolve) needs to happen
unlocked, otherwise we'll deadlock with phylink_resolve().

Additionally, dereferincing pl->phydev under rtnl_lock() is already safe,
and doesn't need the secondary clock.

