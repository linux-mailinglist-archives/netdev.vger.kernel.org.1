Return-Path: <netdev+bounces-250288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C21CD27EF1
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 20:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B824A3029BAA
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 18:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6843D1CCF;
	Thu, 15 Jan 2026 18:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="P39iiy5K"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011001.outbound.protection.outlook.com [52.101.70.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E9A3D1CC2;
	Thu, 15 Jan 2026 18:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768503491; cv=fail; b=PQTXbefXXpwtjouUpAp/vcnLoNBzurb37Vzo2i2M9cuO6Y5bLGJnxQ5D5qVbORsPt3osRzjK9Rkpvami6n/RIlAnThW6qB1fFtaB9I5SlFD7PdptMQkk5h7tHkowjLioO0FSev1CW6p3cT8XZNefZbwoUnPmhkCEKySjjJCd4cI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768503491; c=relaxed/simple;
	bh=cOfGBMEqw57KlPvDTSKD62ASWamNynqUADjYHfJbXDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kNMH9tNDz9swfZsQemlqEOBVuojXSPHkRYXKC6H5GT0W9MwWHjKtyQejbJinyUFeNAnh3/dOrpyDKXLu7jX7SUe38ES/+y0S+NVQ/WuO4WtIm9MIYErvc/4VOZKUQAgj4EIytC/k/tQnma2NznoiOXnYFtOK4DS1vkzi9gCW7Qo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=P39iiy5K; arc=fail smtp.client-ip=52.101.70.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T/13l4LnvgltLRC+6+kdBp39EidaSzAYZzwBz1HFYW4Zg/qg3Bdrqz5QFjqxpbcBpXWBKCbBkaok6EqiOkPB9CNir5jiX0IzB3Y6CcNvbDMIXj3S9cN8px410LYEZ3kWkoow68xdWpDCT+LAQMDNGbt/C6Co+Eh1RPa8HnAcbznSYpg8CcYZKd2ruWgFQBTL+sTy+mBxk28KRirsnGJ+JWXc5yGDtLPp7VNgWTdz3Inin/VRB6LtCBzoIkJDBd94hLghFOEN9tddSdLyG9BRHaAk0gYbN3NjqLDIw+Lf9kNatiUfduuQFVoy5e4l5UrOgLCVMTJZxw0BXun1b+efDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6WezNi0+G9E1yxwh9/y2am84qgESn9NGGmL84WhHJG4=;
 b=HCu8bP7NP0Tz63gjWnVwHfzE31SILUXyiK3cVdnlpCW4Enis9aj9Ln7bqlRs5n5mgLYizR+SPrG+m5FTP0RCD5H2QnVbOklNCPG7uLfyzouTkzORWsq/LYfV8dBSlJJBmsmf9BEvwA9GnQpxbNQGKlBFcXA69dabeS1nVcHX7GvezmzpNsCJuNMONutnyNuMBIOQoxGoRh4/o4P0OUIbPwaWF0O1uCs9BQh06mTZEx+tVMbb0DU25zG1X0WktoEZORkE0iL0+taJRmoV8+3FOTF2d1tWykImlrABAggNBQWtY0jxZ7FWO2p6m/KufapNwrgKUQrm2PBRAVG3j8BOsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WezNi0+G9E1yxwh9/y2am84qgESn9NGGmL84WhHJG4=;
 b=P39iiy5KX/onjCzVx1x60f3o7itC1Ghp+iJVC5FZ8P+kH4y8Lq678fSd3VetaZha7HLcuYn08YZhpvpBJ9N/55LhpIuHxS6IMy9lyEfkTtxmrvxoE4LOL1cqM3z4hsdiy6tim8bcbg0UH02D7CIH5JBaCfZmagXVxO24ZHidx8LOWtaKhkG+4brZo6VPK/ZmHMRlRqdNRL+nMP/GMSlZai2HPjxt2vKvvvqaocCI3hWsFwJTS/5+9cJgppSS9OBXnK0AQbzMlVoqlGILcE7I6lMe+BYE81xgi4jx7AJceBGSXi82/DYIpUQsMZ/iWaxiG/OmximFbb/j1NLc49bOVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DBBPR04MB7660.eurprd04.prod.outlook.com (2603:10a6:10:20f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 18:58:02 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9520.003; Thu, 15 Jan 2026
 18:58:02 +0000
Date: Thu, 15 Jan 2026 20:57:59 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Lee Jones <lee@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 07/15] mfd: core: add ability for cells to probe
 on a custom parent OF node
Message-ID: <20260115185759.femufww2b6ar27lz@skbuf>
References: <20251121120646.GB1117685@google.com>
 <20251121170308.tntvl2mcp2qwx6qz@skbuf>
 <20251215155028.GF9275@google.com>
 <20251216002955.bgjy52s4stn2eo4r@skbuf>
 <20251216091831.GG9275@google.com>
 <20251216162447.erl5cuxlj7yd3ktv@skbuf>
 <20260109103105.GE1118061@google.com>
 <20260109121432.lu2o22iijd4i57qq@skbuf>
 <20260115161407.GI2842980@google.com>
 <20260115161407.GI2842980@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115161407.GI2842980@google.com>
 <20260115161407.GI2842980@google.com>
X-ClientProxiedBy: VI1PR06CA0222.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::43) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DBBPR04MB7660:EE_
X-MS-Office365-Filtering-Correlation-Id: a3fd8165-cc2e-4557-c78d-08de546801fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|1800799024|376014|10070799003|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+1iXCFiottJgw/z3livjMuIHno4Z4C8bTIgmDEHWnm+TvWsbVCbSWtc8/3Tu?=
 =?us-ascii?Q?G0tttWjgPwVbTAollFtgUd1obYpaN+he9md8SsKyPLRjDb1MTWlX0pLfXsso?=
 =?us-ascii?Q?6+BMFh2/MDQ6sggjdrrecllzAZKvRoX8sOeaCmXvBLAvjDqcRS3apHWUhoKL?=
 =?us-ascii?Q?+uxXYvNQ09rRpwX5B8o5GdBwlbmmGN9GFpw3WsXB3gQz5SuIMvGD3hEmOm9K?=
 =?us-ascii?Q?Nxovo8ZAM3IEONC6tCQ4VLTg5z7MKzxqoa029k0xWIfh8SnEZRqJUT4kuN1d?=
 =?us-ascii?Q?mLZwAYp1CH2wKUqZgHlRZe0wNBxtAZ+zjT2fcCaSNYODWPP5bKxBqdS2fWLu?=
 =?us-ascii?Q?SnzkqaDikIXjvXNhoKR5KmZaPLSQy9o6Ut7NStRh8CA55tb9xhIT7M9taQTN?=
 =?us-ascii?Q?08/iqSRsi+FMtNx+Y42ImLIXqAgxi8S1ywmWAGqaMed/w7/E2Jcow7JFXIuz?=
 =?us-ascii?Q?VpEEvFFbaooYJrsLtR+sOiawcTGDXpRqKbjXfmqVAENslIOEecXUwo+HrGNH?=
 =?us-ascii?Q?iNSnx5XtWLQgiOGuXE4wgcfOtH6mOazKw9M4cDpqm/3HmVTk4u0HjzacPeCN?=
 =?us-ascii?Q?AKIAhNpGNwG7vb4bgRZAt84GFxUnrDYDtCu+9fde9bskJFri3x6/mgVTGvAo?=
 =?us-ascii?Q?3i0txAzmG1CYR5JdbUM/fsu6P/WDS5uNSNan6fbrx0YcuAunufSOtf8BZ11y?=
 =?us-ascii?Q?gzGxXmcaAKIpOwNUMMxkdetmQCjmKiCROhwSFAjjOXqrX6E8xvNXmI48oxMi?=
 =?us-ascii?Q?FFc9J4oEUr6E0v1ZG+1UHpR6LCNRI0nA/edjmETH8MoJhmEZiieajD23T5Bs?=
 =?us-ascii?Q?7iUqqqgD4oIdB2aBXL7P2m3nk1wu2Js9DWsUZA45DbiFACcI+CFs366NyfX5?=
 =?us-ascii?Q?nk9DxNNX+t8IINtYvcrqQsPKIOO072rSo1s6X6yH/OT2e7cpvHG6p6tq1AsM?=
 =?us-ascii?Q?h+pI3cPhVOcEr/wV4Tw+q6HaaPVEP1zAFXG7mJrURW8sgDMRAjvJ2hT5AJUU?=
 =?us-ascii?Q?gr6FF3+UbTKpyhwc8xmBUctOtVf/4K1VghgXvn/q8yCOsLQXhweG/lYSqqJq?=
 =?us-ascii?Q?muJNvqdB981R5UJD1KCdjPcX5OgRGCKA4kdfUTKSIxOZHQ1G7h0vgHknLwk0?=
 =?us-ascii?Q?ZAIA0jaSCstS4SGlOlb+Pl18sDX8y7UjKAAFKfE4SD4qEZ/jUVSfhaMPkqKe?=
 =?us-ascii?Q?1PTzJhdg9/nyXN+TaURJ1OC/2H+um4u4ppbXJhrWzRxBm4EIGMLKvlHcb5Yc?=
 =?us-ascii?Q?KqI3fEyGMY4L5RHSXJoLzDsQAtf073Sa98G8IMscJVRFZ7fNSema21TXLZsG?=
 =?us-ascii?Q?XZmbbMY2hkCbOX+E8ZrnUDJfF3H07Ha2G7l7imAvKBRjcHGiHVGb0s5uOGLA?=
 =?us-ascii?Q?oi2Ga/FxBmuf0tOiYThoVkSZaW+EvW0vL8kV2/ivivn6RwjGND7AnllWJGSf?=
 =?us-ascii?Q?sMQZWnVPZi9TduvPQrY/4Zvn3Qbm6ZdbGFoz7wZCDQyXBYxjm+tsble0hZFs?=
 =?us-ascii?Q?qnaTFPQaR8LWSZ5vgUd8UaiSMO/xpEYVmSRNK2uNQ9CK88Enr6QDftAFOs/V?=
 =?us-ascii?Q?q0IpdP2V5209pelJ4/0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(10070799003)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RCF56rgvnZBqiKqdeCqFc+9qpW1UYYUGqyIgUh7iZMxDNCNEFyBdh8tC2ZJT?=
 =?us-ascii?Q?B1M6AW8nuLnmCG/b6Od5Q3cPSIwODGSFcvzs0+v3xMFnBybIl2OnN3AtLdoE?=
 =?us-ascii?Q?5ry4UDhJ03RwzK/SM8Dkt1z+nlLbIupLBn979T1UPFsIhDeNToKGJMRPSBvA?=
 =?us-ascii?Q?qw/9ZHA/OCX50HPJyOf16/6AP0uyw5AiQxtSLUSoTzKsLLEtj8Go38ZJ6rLr?=
 =?us-ascii?Q?2WQGtd69eZR6Xjkpt9P55xhJyYiR0RYySZXWts9MNehULWb+2LuFTb0QSa3I?=
 =?us-ascii?Q?xCmUCFJO9GDZHEzbAF3R20KNG02R8EffJjxu+Dpqa6/rmQ9jweQ8wJ7m7oAv?=
 =?us-ascii?Q?I3ylI7hZfikiSm5E5SJ6pTvdzKXDd0ARt9wFd2IFM86edvWGwrRAjbin29Gd?=
 =?us-ascii?Q?fTCVTDDRR6Nv5jNse2mf1FIBggcEO9mc+rZSkDfF9RiRKtgVBFEYeT5SzDol?=
 =?us-ascii?Q?2fZItYxris98NAnaKojwRUtMMy+5FnQgpFy6HaRzShzyett4wcLYI5sOG2fc?=
 =?us-ascii?Q?d9l4UER0KcNz5VGyVkPrL5AesTzRHQYmPGZY2xD4HbXRLg7UJlff2wf6CBDd?=
 =?us-ascii?Q?bWMjS0f5gA01HL0mExzXrIDnum2c6Vd44lHIu0t7aSWacsYcHkHHypeMNIK+?=
 =?us-ascii?Q?W2YcHjKWeMeo7pwOXLGPs5n7q+zey6cV2c/97TfZz62/6d7QzysQGYDxNZN4?=
 =?us-ascii?Q?GFYw9Yb7fwtdCuW68OFBwHF5m4gtDotT3We6jMYJmkJmBfcN8wav3C4cg4lN?=
 =?us-ascii?Q?KJm+g3uSeBwXN49NRsCfR47JxIdEnqJ7kSRmnjVh4A1pn6/kbXz5ZL+4miXa?=
 =?us-ascii?Q?fSSSyYvuLz6Hvd5sY/rQeAtPZA0N9moINH6OooX9oS4tD02saJV6Om/d/bWY?=
 =?us-ascii?Q?AevTyZt/BOefKC95dPX8xBy5EYzVv/zABpi1m12GpqhDf4MVoqB8ZUk1rAnJ?=
 =?us-ascii?Q?jWIj0/Ezb4uNzd/vHtxnCt6BW1lqyqTd9UJaJezUNZOS8ENDElzPUe9Vrcxi?=
 =?us-ascii?Q?aNEyhT7Ew9cshuM8Iq/QQ/oUjKXeDB7Bgk9Y9M7Ktaf0gf5CpG3/8OqrKDO4?=
 =?us-ascii?Q?6uxuQ6hNYl+OfWw2oQeAaJvl19xrt/sA5FyLwMwtzQoyuG3JcJT937B4GzN2?=
 =?us-ascii?Q?gcZXDQ/bcnX/0+EbTK09PnVj179H9/xCY/J9dIVqcG7vpHukEKGjn5/k0giF?=
 =?us-ascii?Q?nDMoQNdfgLf1Yj930mBRao12jbD0NF7hEdrF4QtetoNkaWNsqKnvw1CLcvje?=
 =?us-ascii?Q?+QnkJNrqPZUrXmnujX11nr1H1op55BwIHlqU5UlbknUdngYd1rJL+Fmg9qFg?=
 =?us-ascii?Q?uHYr6uDdMaU7+4qYifi7FQvNArxPK/dgBgb7WBErfAZrlx257P+PKNlrmPG2?=
 =?us-ascii?Q?AjLAnOA5fUXGWw5RU+7DjxKIBrm42XV3yJW2+S6tKj+efv6fPi5fDiP3PDvL?=
 =?us-ascii?Q?QgV74IOxB4FmMrQ+kBfl0XMEXLiYDjAxES5W+WFi+1LkHr+vLUG58/O3m+P8?=
 =?us-ascii?Q?4qnTT4SdZKMOJ90wecKWWIndatT2OR92bMxGcV+sEZ/uzo49j4kMpSCREIG1?=
 =?us-ascii?Q?MzlJKVFreBNeEc5hy4vyCfuud1rKCrInnJcx80l2pdFO9gKZ9x/DHGfvwjFZ?=
 =?us-ascii?Q?mnqs+WOchkctfeMZn5hkuyk6TyL/qg+GAvLr7X2LmwMdcFi6snNl6bwXxI3k?=
 =?us-ascii?Q?1rS15jkHh0pnf8zNpH1+TpnUpQorw/2olkqfJh2yYxhloWOGRCIVMkGxTe/Z?=
 =?us-ascii?Q?Mh+ps9EMRBmPS3BdeetWcxuiwC2vJa4H3w2PRGuRBkjhafezfK60Uo80gCjL?=
X-MS-Exchange-AntiSpam-MessageData-1: iaWrI4RdoLwhtw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3fd8165-cc2e-4557-c78d-08de546801fc
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 18:58:02.2551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nOsuEmQ+6oouf44PEMlgHNJZx9ofzcLzZQll2JbVbTVF83u8o5x6FctqjCzKPmEMBvmuW/BaW4ocjrzYW93/0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7660

On Thu, Jan 15, 2026 at 04:14:07PM +0000, Lee Jones wrote:
> > > My plan, when and if I manage to find a few spare cycles, is to remove
> > > MFD use from outside drivers/mfd.  That's been my rule since forever.
> > > Having this in place ensures that the other rules are kept and (mild)
> > > chaos doesn't ensue.  The MFD API is trivial to abuse.  You wouldn't
> > > believe some of things I've seen over the years.  Each value I have is
> > > there for a historical reason.
> > 
> > If you're also of the opinion that MFD is a Linux-specific
> > implementation detail and a figment of our imagination as developers,
> > then I certainly don't understand why Documentation/devicetree/bindings/mfd/
> > exists for this separate device class that is MFD, and why you don't
> > liberalize access to mfd_add_devices() instead.
> 
> The first point is a good one.  It mostly exists for historical
> reasons and for want of a better place to locate the documentation.
> 
> I've explained why liberalising the mfd_*() API is a bad idea.  "Clever"
> developers like to do some pretty crazy stuff involving the use of
> multiple device registration APIs simultaneously.  I've also seen some
> bonkers methods of dynamically populating MFD cells [*ahem* Patch 8
> =;-)] and various other things.  Keeping the API in-house allows me to
> keep things simple, easily readable and maintainable.

The only thing that's crazy to me is how the MFD documentation (+ my
intuition as engineer to fill in the gaps where the documentation was
lacking, aka in a lot of places) could be so far off from what you lay
out as your maintainer expectations here.

> > > I had to go and remind myself of your DT:
> > > 
> > >         ethernet-switch@0 {
> > >                 compatible = "nxp,sja1110a";
> > > 
> > >                 mdios {
> > >                         mdio@0 {
> > >                                 compatible = "nxp,sja1110-base-t1-mdio";
> > >                         };
> > > 
> > >                         mdio@1 {
> > >                                 compatible = "nxp,sja1110-base-tx-mdio";
> > >                         };
> > >                 };
> > >         };
> > > 
> > > To my untrained eye, this looks like two instances of a MDIO device.
> > > 
> > > Are they truly different enough to be classified for "Multi"?
> > 
> > Careful about terms, these are MDIO "buses" and not MDIO "devices"
> > (children of those buses).
> 
> Noted.  But then isn't it odd to see the bus mentioned in the compatible
> string.  Don't we usually only see this in the controller's compatibles?

???
bus == controller.
The "nxp,sja1110-base-t1-mdio" and "nxp,sja1110-base-tx-mdio" are MDIO
buses/controllers following the Documentation/devicetree/bindings/net/mdio.yaml
schema.
There are plenty of other devices which have "$ref: mdio.yaml#" and
which have "mdio" in their compatible string: "ti,davinci_mdio",
"qcom,ipq8064-mdio"... This is the same thing.

The "MDIO bus" / "MDIO device" terminology distinction is no different
than "SPI bus" / "SPI device", if that helps you better understand why I
said "buses, not devices".

> > Let me reframe what I think you are saying.
> > 
> > If the aesthetics of the dt-bindings of my SPI device were like this (1):
> > 
> > (...)
> > 
> > then you wouldn't have had any issue about this not being MFD, correct?
> 
> Right.  This is more in-line with what I would expect to see.
> 
> > I think this is an important base fact to establish.
> > It looks fairly similar to Colin Foster's bindings for VSC7512, save for
> > the fact that the sub-devices are slightly more varied (which is inconsequential,
> > as Andrew seems to agree).
> > 
> > However, the same physical reality is being described in these _actual_
> > dt-bindings (2):
> > 
> > (...)
> > 
> > Your issue is that, when looking at these real dt-bindings,
> > superficially the MDIO buses don't "look" like MFD.
> > 
> > To which, yes, I have no objection, they don't look like MFD because
> > they were written as additions on top of the DSA schema structure, not
> > according to the MFD schema.
> > 
> > In reality it doesn't matter much where the MDIO bus nodes are (they
> > could have been under "regs" as well, or under "mfd@0"), because DSA
> > ports get references to their children using phandles. It's just that
> > they are _already_ where they are, and moving them would be an avoidable
> > breaking change.
> 
> Right.  I think this is highly related to one of my previous comments.
> 
> I can't find it right now, but it was to the tune of; if a single driver
> provides lots of functionality that _could_ be split-up, spread across
> multiple different subsystems which all enumerate as completely
> separate device-drivers, but isn't, then it still shouldn't meet the
> criteria.

Any arbitrary set of distinct functions can be grouped into a new
monolithic driver. Are you saying that grouping them together is fine,
but never split them back up, at least not using MFD? What's the logic?

> > Exactly. DSA drivers get more developed with new each new hardware
> > generation, and you wouldn't want to see an MFD driver + its bindings
> > "just in case" new sub-devices will appear, when currently the DSA
> > switch is the only component supported by Linux (and maybe its internal
> > MDIO bus).
> 
> If only one device is currently supported, then again, it doesn't meet
> the criteria.  I've had a bunch of developers attempt to upstream
> support for a single device and insist that more sub-devices are coming
> which would make it an MFD, but that's not how it works.  Devices must
> meet the criteria _now_.  So I usually ask them go take the time to get
> at least one more device ready before attempting to upstream.

sja1105 is a multi-generational DSA driver. Gen 1 SJA1105E/T has 0
sub-devices, Gen 2 SJA1105R/S have 1 sub-device (XPCS) and Gen3 SJA1110
have 5+ sub-devices.

The driver was written for Gen 1, then was expanded for the later
generations as the silicon was released (multiple years in between these
events).

You are effectively saying:
- MAX77540 wouldn't have been accepted as MFD on its own, it was
  effectively carried in by MAX77541 support.
- A driver that doesn't have sufficiently varied subfunctions doesn't
  qualify as MFD.
- A monolithic driver whose subfunctions can be split up doesn't meet
  the MFD criteria.

So in your rule system, a multi-generational driver which evolves into
having multiple sub-devices has no chance of ever using MFD, unless it
is written after the evolution has stopped, and the old generations
become obsolete.

Unless you're of the opinion that it's my fault for not predicting the
future and waiting until the SJA1110 came out in order to write an MFD
driver, I suggest you could reconsider your rules so that they're less
focused on your comfort as maintainer, at the expense of fairness and
coherency for other developers.

> Is there any reason not to put mdio_cbt and mdio_cbt1 resources into the
> device tree

That ship has sailed and there are device trees in circulation with
existing mdio_cbtx/mdio_cbt1 bindings.

> or make them available somewhere else (e.g. driver.of_match_table.data)
> and use of_platform_populate() instead of mfd_add_devices() (I can't
> remember if we've suggested that before or not).

I never got of_platform_populate() to work for a pretty fundamental
reason, so I don't have enough information to know what you're on about
with making the mdio_cbtx/mdio_cbt1 resources available to it.

> Right, I think we've discussed this enough.  I've made a decision.
> 
> If the of_platform_populate() solution doesn't work for you for some
> reason (although I think it should),

Quote from the discussion on patch 8:

I did already explore of_platform_populate() on this thread which asked
for advice (to which you were also copied):
https://lore.kernel.org/lkml/20221222134844.lbzyx5hz7z5n763n@skbuf/

    It looks like of_platform_populate() would be an alternative option for
    this task, but that doesn't live up to the task either. It will assume
    that the addresses of the SoC children are in the CPU's address space
    (IORESOURCE_MEM), and attempt to translate them. It simply doesn't have
    the concept of IORESOURCE_REG. The MFD drivers which call
    of_platform_populate() (simple-mfd-i2c.c) simply don't have unit
    addresses for their children, and this is why address translation isn't
    a problem for them.

    In fact, this seems to be a rather large limitation of include/linux/of_address.h.
    Even something as simple as of_address_count() will end up trying to
    translate the address into the CPU memory space, so not even open-coding
    the resource creation in the SoC driver is as simple as it appears.

    Is there a better way than completely open-coding the parsing of the OF
    addresses when turning them into IORESOURCE_REG resources (or open-coding
    mfd_cells for each child)? Would there be a desire in creating a generic
    set of helpers which create platform devices with IORESOURCE_REG resources,
    based solely on OF addresses of children? What would be the correct
    scope for these helpers?

> given the points you've put forward, I would be content for you to
> house the child device registration (via mfd_add_devices) in
> drivers/mfd if you so wish.

Thanks! But I don't know how this helps me :)

Since your offer involves changing dt-bindings in order to separate the
MFD parent from the DSA switch (currently the DSA driver probes on the
spi_device, clashing with the MFD parent which wants the same thing), I
will have to pass.

Not because I insist on being difficult, but because I know that when I
change dt-bindings, the old ones don't just disappear and will continue
to have to be supported, likely through a separate code path that would
also increase code complexity.

> Although I still don't think modifying the core to ignore bespoke empty
> "container" nodes is acceptable.  It looks like this was merged without
> a proper DT review.  I'm surprised that this was accepted.

There was a debate when this was accepted, but we didn't come up with
anything better to fulfill the following constraints:
- As per mdio.yaml, the $nodename has to follow the pattern:
  '^mdio(-(bus|external))?(@.+|-([0-9]+))?$'
- There are two MDIO buses. So we have to choose the variant with a
  unit-address (both MDIO buses are for internal PHYs, so we can't call
  one "mdio" and the other "mdio-external").
- Nodes with a unit address can't be hierarchical neighbours with nodes
  with no unit address (concretely: "ethernet-ports" from
  Documentation/devicetree/bindings/net/ethernet-switch.yaml, the main
  schema that the DSA switch conforms to). This is because their parent
  either has #address-cells = <0>, or #address-cells = <1>. It can't
  simultaneously have two values.

Simply put, there is no good place to attach child nodes with unit
addresses to a DT node following the DSA (or the more general
ethernet-switch) schema. The "mdios" container node serves exactly that
adaptation purpose.

I am genuinely curious how you would have handled this better, so that I
also know better next time when I'm in a similar situation.

Especially since "mdios" is not the only container node with this issue.
The "regs" node proposed in patch 14 serves exactly the same purpose
(#address-cells adaptation), and needs the exact same ".parent_of_node = regs_node"
workaround in the mfd_cell.

