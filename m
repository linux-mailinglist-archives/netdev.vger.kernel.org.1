Return-Path: <netdev+bounces-158538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94011A12686
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 15:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EC5F162726
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 14:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A903886320;
	Wed, 15 Jan 2025 14:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hukgbFuB"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013022.outbound.protection.outlook.com [40.107.159.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CAB24A7EB;
	Wed, 15 Jan 2025 14:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736952713; cv=fail; b=kP1EypZmeYlyfBJurgu6/PNSd/6ODVjeqDxO/46zcPvNLsJ3vHJchmjtafcFD7rJ/urn5ihJC8SzQIG4utn+YlLymcYykXxDPqYRFQYIFpVOh4yPO+jzN4tzNyRfbkVRamancnPHZ1GXdeGKH8d3dLvqRzCrM5BmQQ9XIPEz0oE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736952713; c=relaxed/simple;
	bh=kkcbf66UihYjGvX4qDjQbwk9kMJ46WB7PKCiZTwzr3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=twHDGs0muDzCcZq4AkjqGDVE8lF1BlFMw0RJELIuu9MZWqv/whM+hjTER1faiqDWoSqHtGdUyq1Mu/yKaQDNgCJe8g3L7VTKlMO6UPmOQlVTnZYH9Y5rQp/uwn1vQRjhZ53ey/qOW8g3I3Js1seeD9b9pDjmGX8+nF7ny8eo/Ew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hukgbFuB; arc=fail smtp.client-ip=40.107.159.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pPD2KntsC+n9J5xcV7lxyqnrACMdo5K/kO7xeoVdZsib3dX+LLiMW3V2mhpuYLkPIGP9aIFWD2PLYQREw8rekDS9GTZRwBC2Hf+CRI0A9J5yBjPbdsj0Xe2OGfn6cBL3gjv5m0aCUI2+PMxXRdtjbhO/0k7LL7WRVi9CdgTgU7X58f+lrWInqLRbz0MTAMdBwIgD81u1m82GMvIdAbMORgZkqKcw9jwFVgxnxX6sXEpbJ5foiXzAxvgCxeK58rtl9ezX5SNHcj9MPoBjP8JXKXr2Xsj1kGFJeeK6/fapFrUQ1EOn0YN2gp8AgDt+9SR33AQnoOYrtKdRw0iXC4qD/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QVL7Ht1g6Ds0U5T7YAPiTpNfU/dwLhuMXJ7IRMGc15c=;
 b=brS53miV5cz8g+VkxFgqzOEEI5eS/ni1B268s+1hw0fZsHjq9mIwGqvOg1lSe16S35RFSQPIIPxuYXKAYEkOWkLDteJgsmB5QIsqaYENqo4OAKBiJ8u1fN12liLAUKBAQU1ud09+84oKEaVe07bpN0u9lBW0O7W1zKYFA+D0p9C0dfm75ZFhSdhUpJtZPELYkT6WoaU0dj1OQQAqbXN5FbBgLc+HKe9Wwgkbsdvt1NtVPr59S2jkbcevWnqri5tOcf14BEQr9sDGJct1ejUltTO4ZWBjyq62t+doyU82EsVIazv1N+qIxKg7BwFymr7oHVYzmLTvrrl7o/YrUAEU8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVL7Ht1g6Ds0U5T7YAPiTpNfU/dwLhuMXJ7IRMGc15c=;
 b=hukgbFuBFLZq3hxVvQ3qjT7lXuQPsYy2RnZK/uTcDwY6ZFjuHxnH7dugypg2/T6q1w3S4JXNTk7Y2jxuaAti9K/wawKGCTFImCSiiMp/HZD6nr4bVAblg/pQ8xva7T3pxqMW7y41q8lEPHjfwh75cbc/Ir0Jm4Nla9soA0NzInRy45qx/nefVyvVZPMfBw/GGCMMT84WT971MWOMHvgnN9QnbnFFqyNcNxKgBnCmleemb8/bnR8T1yNkXxg54LxiAJgmHOI+uJ+kOBRLEkFq88YLwbUUxVYB0YxWheauGE4/HAxzwSAW8afBUD6T44n2pI6W/LPYdVFOrece4Urozg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS8PR04MB8008.eurprd04.prod.outlook.com (2603:10a6:20b:2a7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 14:51:48 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8356.010; Wed, 15 Jan 2025
 14:51:48 +0000
Date: Wed, 15 Jan 2025 16:51:45 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, Jose Abreu <Jose.Abreu@synopsys.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Voon Weifeng <weifeng.voon@intel.com>,
	Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: pcs: xpcs: actively unset
 DW_VR_MII_DIG_CTRL1_2G5_EN for 1G SGMII
Message-ID: <20250115145145.4jdajfaksyfkx5zh@skbuf>
References: <20250114164721.2879380-1-vladimir.oltean@nxp.com>
 <20250114164721.2879380-2-vladimir.oltean@nxp.com>
 <Z4fJ5FIuotHMZ8fN@shell.armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4fJ5FIuotHMZ8fN@shell.armlinux.org.uk>
X-ClientProxiedBy: VI1PR02CA0067.eurprd02.prod.outlook.com
 (2603:10a6:802:14::38) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS8PR04MB8008:EE_
X-MS-Office365-Filtering-Correlation-Id: 9957625a-2a75-4a12-eb6a-08dd3574234e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pnj3NF1c2fW7SLdxxQeJOFNqDL60MdvopBsE8z80hBTcFbWJGgjy7g5BVoLV?=
 =?us-ascii?Q?evhBb0NHM59xT2gvWZ5S8Fozy9d9FYI8cZbso9HCr8D6hrqtMj+Wxg/fnVee?=
 =?us-ascii?Q?qRkPNcSdh7fzrKsqDBkfbnnGP1eS1hEahDIlnEexAu+VbC4H4rcZjAtCP6Os?=
 =?us-ascii?Q?L9HtxHUiqFmgdbKfuF4dLYVfhy+YTX0e/78FAWwYtb5/lKeuIZgj8Yj0TAbm?=
 =?us-ascii?Q?o28LslceQMGWqCATtJrq8WVhwthjQHoF9FZTzqz70i4vE+QggmRIDRTC4h8l?=
 =?us-ascii?Q?+R4dPPnSx5bdIGDdqL07NPwbLQjtWMWWUSy4Ddu0S2JtojYqrWpY4jVkBUNG?=
 =?us-ascii?Q?9EuryatLVM00npi0904JGhqiHHCMWJ/bWzQWP8Uiom37dRxLd9+ATR3I1ViX?=
 =?us-ascii?Q?Y/imFvhmwf7Mf7gcnJeEUqfPt+wgvofHRfGJuP8Q9dba7jnJG4mN4vH/M4Ms?=
 =?us-ascii?Q?NQr7c51yVvN6yYx8/9aT3xqcq7HCJdXtRZW18+KUwdP4eDh/p6RQ0ZToo9ph?=
 =?us-ascii?Q?H+ZMRPdjNrkB7Ey7qY0AU1sfJHu+73/qb8Elk1iY+ISTzfpbdYBSONTsjIQU?=
 =?us-ascii?Q?uqlimyuY4VtAT7piYIdNIkonkgXwPY9c+x/cBaV/4/OI+nqMCY1g0t0eS7Ar?=
 =?us-ascii?Q?Dew/Cs3znCk4PuNBlVCfRNtJzJcGnX/HEqLc8mI0eEh49GWBAdnms5F9goQm?=
 =?us-ascii?Q?zagXIEacVklftFa1Y9SZeu+eiUjC81MoKjlFiEyx2HfjrDf2+aLqCoiKOkyg?=
 =?us-ascii?Q?xMgsbgfWcy2hCqo14/R2WNTfMXrOyu2ZBKpMjzivhrq41MPWDcY31tMaH2lY?=
 =?us-ascii?Q?cB+4+aHAaV6xZSsMLbQU0WGfohRkpqruDZGL4MJYX4Ky9rCJRF3GMjEz8Cgm?=
 =?us-ascii?Q?iceclRy3B1Cv/fDUT8teba/DrBCBZkXHHzwtZD37rfobDduh/YKTYHTyj3zy?=
 =?us-ascii?Q?VOmBa1sB0yFlAmobprdB4tjIk/oWHtPIgtqjyC7lyWJz0Y+/uY1EzKM4Sg+a?=
 =?us-ascii?Q?SG7pXaTBUavjcMxrmsC2J4cXzbpd9P3nyvc6hcY5/hhKMpYLloHMXwpVNrEn?=
 =?us-ascii?Q?9g2MGmsgEEdkC1ponzoWeQFDK5KHK2/TyAJqd5lFp9nJZ7mA3F3gpsT4wbbU?=
 =?us-ascii?Q?Pj1qlzCv26A7cMFI0cBQqIbXfncGdiv5BsGj7+2KCdxy4zx+FzgFIVcCud9o?=
 =?us-ascii?Q?yYxBbMv/+W7O7e99Xn1l3VsBpUdhHxiNPGZFE6QIgE3BRErRtGFfrAFMZIpR?=
 =?us-ascii?Q?isk6l0ZIuuWPGWVZZLwt2Lwaet7+OsUuuJBAWTjj4+EiVCNxw2x82JOV5hW9?=
 =?us-ascii?Q?RNIjaHW5MiThbHjhckuUDvN04c6blG0yfEhEDNEXmysUq6LNl6vkDbmdEi6/?=
 =?us-ascii?Q?v2trJVuZd7fdBpHZa71BNdJMn7rG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZVx4c7ef61IxalQFQugbMJOkZrbxwRiZbjGzC/eUjqT5sxN1ap37t2RXuCwc?=
 =?us-ascii?Q?DtKTvEGPoMYCNMSLbFk0ebwduvAbagmgPburpViecYjppLVNXFUzPXC+6htd?=
 =?us-ascii?Q?ysZqI0njU3WApa7PMKcQ0TEfo4jeVt4MykjdnRfjmdWhX9vkI054Pr3pWpBg?=
 =?us-ascii?Q?jZ+YJi3b9HOB/foMO+ObOKewkKex7s3IgQW0rpUbj+XpHZKQqS6abxK+SdO3?=
 =?us-ascii?Q?/SWb3X3lHGHp6yW2VJBajsQf5Xj+bGumXp/eSg/KQ+53us3dWNTO5tRWS2Yo?=
 =?us-ascii?Q?MODa1kY1ppa+0zpPWYq4zVJa/62Jg7h+KBUnXJ+fRg0d3LS8GH6jEsWAPxbZ?=
 =?us-ascii?Q?YNy+8eUb2cXN3axzjtGSs3j1VKbcaoXl7XJjco7uva8jEKQt8Lov6VLW93pC?=
 =?us-ascii?Q?PcT8FLnvy7Ehvj9GdXDYBappOw1uHcE9+eKxwW9HIpjkIi3WUxtdwexBJvhJ?=
 =?us-ascii?Q?RKFi9dwm0psQFpjxpufLkc8Z6g+lvDWwf5kkqo1NeG/ok5OdyspQZ2qPgFvt?=
 =?us-ascii?Q?z0krngGcV/BoML/QDi5GXLkFLADJBEaTkkAT2CSQUWA6sUWur/W8HF/gDn4i?=
 =?us-ascii?Q?bQht10osFm+aai1Muiyaty34iiZR6OI1TcjiyLZiNFbsY0HP2KNg7YzYEJ9d?=
 =?us-ascii?Q?SgzkjJ/nm57w7ykY96iWW3ZBqpkYoQUD9qsYNIpp0n8iKAvl2GyfoUSHzlTh?=
 =?us-ascii?Q?7edguD/zeQa5ZeE4wup0dpkvqXZZCzkX9eGT/viCRRaRCuyP9qOntarUfCAb?=
 =?us-ascii?Q?4cN2Je/r2R68nO5UxtE1dyCX8tYgjevmnLisiuIHcJPHFKed8moZn4R+SnsR?=
 =?us-ascii?Q?GZZRnjB+OO0EdlKmtI2Y8XwS0ORkFZ2HkAOl7Bdkf1RUacRlnCdZaeqzkd7n?=
 =?us-ascii?Q?kSwh4c2pzeyxwDUFwWsjSpcW/WWJe7ZXW/MfufuE13e9sNgz4S6HwI3evvXy?=
 =?us-ascii?Q?9JUlybw6FkZ4LA2HMEJYhoytfeF9uVvGW7ajjmkFbrfuMlqDpKNDO/3UMY2X?=
 =?us-ascii?Q?IrmXAPySfUu9g5rekV2bkVgnvQ5LI6fLR7QAeRFAn/jJ74e8Mj2rBQlxh/qG?=
 =?us-ascii?Q?SGZXmrrOYxwjyb7Ok3sCXExQueu1hFzcfISgR1/Wnj4a2CRw3IvL8Hz2l6ku?=
 =?us-ascii?Q?/CC4OurgB6yjUHqMHgps1CQVqBzEnfSidTOJ1kEpoaYd1RjeDYskutfHt6D1?=
 =?us-ascii?Q?P3uvZtUA5cD8Rf3dXjxze3EOXO+ihUWFL5tcfpXStfhcQxUcp2tTmY6HiUGJ?=
 =?us-ascii?Q?9LtQ1IJhOkxYzG3MtTdXROFSv8rFaYOx5u3QgWZGGgMYg25wL4mOeld3rV0l?=
 =?us-ascii?Q?nxOKsARBvlnqFA7Snd76oDevLD+tH6aJ6PH5QeJ/Tcd9fewcdKn2YF5CVop5?=
 =?us-ascii?Q?00yP80m6rJCotshUtDqOzsbwRfaBxFwFwHmScsN/44ahgJNBR/1hh4g/bHdR?=
 =?us-ascii?Q?PXP0VWWFg7WopvCm1uyOU7bXaCkzUayXkrwnStOjQeCg8W/FieRJYXE96YEE?=
 =?us-ascii?Q?TKg1LYdsHbCUzWrIq1uNWs/5W37ms7E4AfEHxjjXccK49J5czSppjiqUuDgk?=
 =?us-ascii?Q?/5jUWZWQKLuuZPjjA+7kAXNTVynqtD7Xjj4Vgx3P3gI7LP5pcZVpitU62SzE?=
 =?us-ascii?Q?wg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9957625a-2a75-4a12-eb6a-08dd3574234e
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 14:51:48.2583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /TgNhfCFdUwlOiQAAKTq76k3yk2K7NOb6dyLGU90miDnZkIQVelJYC7kRqgqz/Avf3UZNi1Q5bhbTG0wFE6bSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8008

On Wed, Jan 15, 2025 at 02:44:52PM +0000, Russell King (Oracle) wrote:
> On Tue, Jan 14, 2025 at 06:47:21PM +0200, Vladimir Oltean wrote:
> > xpcs_config_2500basex() sets DW_VR_MII_DIG_CTRL1_2G5_EN, but
> > xpcs_config_aneg_c37_sgmii() never unsets it. So, on a protocol change
> > from 2500base-x to sgmii, the DW_VR_MII_DIG_CTRL1_2G5_EN bit will remain
> > set.
> > 
> > Fixes: f27abde3042a ("net: pcs: add 2500BASEX support for Intel mGbE controller")
> > Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> Thanks!
> 
> I wonder whether, now that we have in-band capabilities, and thus
> phylink knows whether AN should be enabled or not, whether we can
> simplify all these different config functions and rely on the
> neg_mode from phylink to configure in-band appropriately.

I don't understand, many sub-functions of xpcs_do_config() use neg_mode
already.

If you're talking about replacing compat->an_mode with something derived
partially from the neg_mode and partially from state->interface, then in
principle yes, sure, but we will need new neg_modes for clause 73
auto-negotiation (to replace DW_AN_C73), plus appropriate handling in phylink.

