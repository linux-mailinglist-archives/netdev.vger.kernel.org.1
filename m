Return-Path: <netdev+bounces-152252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8299F337F
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 15:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E472D7A180E
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 14:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073943BBF2;
	Mon, 16 Dec 2024 14:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ld17IMM1"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2069.outbound.protection.outlook.com [40.107.20.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27D929D19;
	Mon, 16 Dec 2024 14:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734360521; cv=fail; b=O4AEAEK6XT9JY92FnH1r975LArM55rrJTaBeZzUdFMk69fFG3Z7yRqtKiVKJumPcyY9pOAhaB5rnIeb2Jg11EWfoV/9hSSHEDGztU/uqw1GrIg1IQ4fIU0iE1DyrJMrvWDJ2frV/01XnHgHt6Uyor7A9vbddwmwUWw7xE6gIIh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734360521; c=relaxed/simple;
	bh=Il3brdeXd72cvNxdAUb9Grm0+LUNlUKQjZnUO/ukEsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ajVpLHNhd6KPD7BClxqiqAGaGrFxDit2hIrKf2dD8Z2TVLS9vFoqD1583hzG84eiTGeOQ8J7Q7JaP+Qg4tUKSe2PR5GdqvrQRQoWAdMO9HyimFs81f+8OUeOKjKhKkzmWcjO94f4UpKxgHWwNlnaMXEsp5CXhIkpDpsTliKCOS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ld17IMM1; arc=fail smtp.client-ip=40.107.20.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oUnk92TamiQH0XnCcGzOAvsoW2JZq0HUHnrqVBtkpWrcaBl8FpjbE+jA4T4YV0EIoLSmwEWANpJkCTVHnOf1zDFbDtFSsXL/hovulN3qzT5v6yCxb2Kpdb2odd1ZnvdDDL3VwGDrKTATbQbXc1nU1icnTI6Coig9gc7v0BoYx6IDNikD6w/xhU/CvK8pV1IUxN/2dqCwqmG0XxeZNvoABOrs2sFZLJx0bpHJ6SQBDWFIaAhCbcxQj343UqIBCiEHTeFdDJvV/E9PQn4m9ge64iLxvWYVeH56MdEg8fEZ3Qdzwr9TjkC5vvY1ec15Km9OD6fK+NosDcZysMSfh6WhYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H93AEdTrq/XPv7MDPwFpbAyE+vvjpAUQZtrT9zhTwl4=;
 b=xmEeNnDYHRMKXbP28XgxLwCkSH9SN5I7JfmHXsKd5+l4iD5WU7fBYeVkRmH5VnOba7eEtEhxaOX+NI37O1HOJ17UZTslGVMaR+TOWyb7bOAveNRvBTvA0zJyIWGd1Kg2qP4Msx4Co0C1ZVftUDzFzz9xQQxUpGx3mpszY0mcE7lfAd4D4xagQKJAEOhc3SBlnuRm0THoslUsMgTjvrGhB1UUX+Vz3ioG99uK+1hbT7z8mYy9qYSb7dwxZDCkV1vzlK3rfnYP2zul1eS71yDYAYL/9HmI/Yw6+nL3QlfuoKZanuz/tXexai6XKvVybeG0jkuDsnaW8ktRs4+cpfgX4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H93AEdTrq/XPv7MDPwFpbAyE+vvjpAUQZtrT9zhTwl4=;
 b=Ld17IMM1K7iFpvWyU3CZMV/48EoOBaSwYTFRWOawI66wVgmi4HNXg5BD+n9Cvo8iW2z1cy3OctKmK/wJgLkZZmpVRhfuxKsh/MidB40wjrvek5EAwtcxkvjojkrtY139Acmz9qp1ETIl2UPt0Op9NpId+q6gLcQ/qXCAqtB6QpQcUY46BM5IolAi7rXZ1JRlZxtRYaEriL8KH6IUXPHSVpbbVaEsGNDCZvHUJ0WbXq8n4fcSZdv0oj5qRR1sGrQpbIpYOd9rIpJG3QV+7bKUGAYQ9chUUn0j6DAPdl/Fi/iyy3fSTpWLlUUPig/oWIqUxyJl2fZwnGz3Gqm4klyCBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS8PR04MB8434.eurprd04.prod.outlook.com (2603:10a6:20b:406::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 14:48:34 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 14:48:34 +0000
Date: Mon, 16 Dec 2024 16:48:31 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Robert Hodaszi <robert.hodaszi@digi.com>
Cc: netdev@vger.kernel.org, claudiu.manoil@nxp.com,
	alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com,
	andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net 0/2] net: dsa: felix: fix VLAN-unaware reception
Message-ID: <20241216144831.yh6w7mtyaywypq7d@skbuf>
References: <20241215163334.615427-1-robert.hodaszi@digi.com>
 <20241215170921.5qlundy4jzutvze7@skbuf>
 <908ec18c-3d04-4cc9-a152-e41b17c5b315@digi.com>
 <20241216135159.jetvdglhtl6mfk2r@skbuf>
 <49d10bde-6257-4cc0-abaf-3bffb3a812c0@digi.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49d10bde-6257-4cc0-abaf-3bffb3a812c0@digi.com>
X-ClientProxiedBy: BE1P281CA0112.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7b::19) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS8PR04MB8434:EE_
X-MS-Office365-Filtering-Correlation-Id: c95637a5-7814-4650-0001-08dd1de0b74e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DWng7RmywHXYdd+OmhxyZLdlCOqITMHyjaFSKpMYxJa6KnDS/ZNxCNFcpswi?=
 =?us-ascii?Q?xJanCOBcBgvqDj9NgEjADW+yRUdOAsCeXm8OYDdSrE8KajBIxjj3d7H1qsX3?=
 =?us-ascii?Q?lPXRJTgrRiifL1mBInLKN6Hrwjh9PGFUMms3zP+Cg2t4hA4xA/Ru3hs4DnPE?=
 =?us-ascii?Q?D1X5xzmV9tgoO7/jwFQik3E8qYiPGvokh00c0TIvQxHDdMo9p2E1JlDwKGZk?=
 =?us-ascii?Q?8w7i6vo3eFrF4RNBEUc+u31kARxxTrL/76mCa8HgIVv0PgltH1Ohh8HcDzfJ?=
 =?us-ascii?Q?yU3vn4v8aIQhl1VzOD9oCtCy5nr1y4ycMI4MWmWSdQAUoAB4Mh8BGAzzoFXb?=
 =?us-ascii?Q?T6kPVNJ+crseaRNNYddnntj1+7T3VThIxYyzoOsoMcQ4TIisfGTEI/ju14FF?=
 =?us-ascii?Q?K3PT2NnM/n3wbWiZHhAMJ8H0OOyTSf0sURyFKtQgqWv3h9+xaZd7ajItqr2s?=
 =?us-ascii?Q?RHK/+ePQtVYqcoso9cE7bZvRPd6AcrMNMWmnZFOHr4cr/dC0eE+8cLlwNG5M?=
 =?us-ascii?Q?lynk9hfln0z/Fbqxe4Zmwjk2I6bmpNpkRusyclVO+Q46ZuJiejME69rlUuFa?=
 =?us-ascii?Q?ujTsBqZ2dA5JS3nNP5VMrwEJ7uE+orjzUAtApbN5mvjPe6Qy0MKgyZdSQ/7I?=
 =?us-ascii?Q?S8xODJUzyeU9zRzsMrxCbn7int2zjkEX2jaNfSjLPKf6K65v8AyFwB1JS9Kt?=
 =?us-ascii?Q?XI60f9SZQsM8ONSCSQ069+DEyRd6uaOVHt5r91b89wRAo87jwtxgKJ8V5XLa?=
 =?us-ascii?Q?rLw/bRDOoC4fjccDLKZk+CLd6H59+m3SZKuF505X+DDxtx+y0lNzUm0B+RGi?=
 =?us-ascii?Q?SzIogCYGPq45e6ZTL1RO4iDw+5KLX625i54qF74mzTXYfxUB4QSwevszD6gb?=
 =?us-ascii?Q?6j9cYuMgaRSwMme7tDPc0xgVpKTXuTEy6dbLjkqez5yqUUDkTuHeIT0/aBDP?=
 =?us-ascii?Q?q/Q9osnug1IPsrvEbj9x+B2NaKM5WDI1UGcIGlgz2ic5JZUjcYo2MkqbN24p?=
 =?us-ascii?Q?K1KPfFh9NueTwv+j2xu3Qh40nMPWAHowtkvw7AImBhoNZLIcwP4d7aJcZVA+?=
 =?us-ascii?Q?TMdHR2qqvpHxxUimjnP2K0B+BOvYcKC145a8QM/WCShjLpWIuezcx3DSgc/B?=
 =?us-ascii?Q?utQe6xe89FQ5EwIq9TyYtgltImf9RrZZxKRhVRQRpOzRSFjRp3Je9ZEu0Mt9?=
 =?us-ascii?Q?EP2pXpS37H8lYSZDiJU0E4cf4LksO2Bvpqhp0jebZqms4/qxovA50iulmS4s?=
 =?us-ascii?Q?ueJ06663N5Ypp9FdxZgnS3hnWl3/EOI+FIz0hmesWl7ecnGr9coDRPNX2snH?=
 =?us-ascii?Q?wBieLNSby3+jwWOl9BEVU1yOTt5ldMQ6+ZuG83Wl291zd42qM+k0zE5EYJtp?=
 =?us-ascii?Q?qCmUCd1pjgf5hS4xI0Q9GAN0Hg/3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S1Adg6qbe+3Gny6t/2X4p9hOjd2MlMKYlUKcTdj/TJUR2rDLf/Az9DP3aMQ9?=
 =?us-ascii?Q?7Q4XUsbmgd1HQycLcvazDVcUwB18enqMGNRVPzWoPJ7yROqN67uLiW6niLWR?=
 =?us-ascii?Q?cwlxAnYWXcNcBIU8W71hJiJOTdYy9g8xr+6Ly+mI4KkqtRV2lMHhu67v5dGB?=
 =?us-ascii?Q?xGdpP7T0wYPSlvFFqp9pcTjez63s08/DErL2A2tP8sBqxSxPBHS7mC0ejn+0?=
 =?us-ascii?Q?E9cXCLCZPTheT5fg7fRhmBIkO+K3f6RoQ/8JC8aB7YIQGbvPRU8KlKvkzZIw?=
 =?us-ascii?Q?AvETvR2GXRf4vy9z869OsZfx5XHQP1FrsQIZXJ6P5PTnKvKMCwLjiRMtHEWW?=
 =?us-ascii?Q?Oy4s0hIDAuBRzbu26VF8RUQ9bVsSWwgbpxcPy0C3BgzdX5Y8vsedGFaRsoMA?=
 =?us-ascii?Q?3SghZiB5H2BMXp8v+5nV3q6s4KexUz7OKZsTwQ1QnR4sI4LTgjgO8lNJppIR?=
 =?us-ascii?Q?2qeEzILcgJlEomIFEAvHcaXSTcLGBz7xyMdTPRW9ylx1jHGIoAcyuYDOnnzd?=
 =?us-ascii?Q?yyO8Y53QuCpuqjr2KPd2Vt7+iYl9cy8YIRAPbE6svWa3jIL+FBnQG2QKtdH6?=
 =?us-ascii?Q?qdzOYxfO/DfWFhCLdsVsnOruh7UGIQhL0beXirG7S2qgHq8JdRumfWQmsCDo?=
 =?us-ascii?Q?m13d7+BUOIbZl0+55jFRxW8UXe4429m4eMR4aBQ8WYK9wQeVXGcWhROd/Tv2?=
 =?us-ascii?Q?8DWVHeaJYDFqimqzAMXz0t7EanzQsaywhuWgbvbm7BpsL2Hut6G8Im/cN8d8?=
 =?us-ascii?Q?PyTY2/dRdfTR074NZR1Sj7z/RaBgnhLkayBFFtqsS1eIiBAtRokJS+/Bhdc+?=
 =?us-ascii?Q?ghGQ5YrVPyLZh73mbTwrLzjmLVMgGZhnz4mj+v03A4zu3H6HnSd7LOPc9P7S?=
 =?us-ascii?Q?EEJv3iNcEYa3dQIyARO+cmS463ZGD+RJMllIodHOvR88IZxd8i0mIiasPJ7O?=
 =?us-ascii?Q?0mO8D9FEGHNree4IzwIAR+k1xB5bv22e2Xle4FYy5Mdf2EGIoXcNLEdHPb58?=
 =?us-ascii?Q?Tz+JRaqeP0NXM5PRTCAxlqtMyKKoqihcWZXN/3PrdeIi/9Truw1fAk4xouWl?=
 =?us-ascii?Q?tC7TG1UlFTZhF5Wy2vIYm+iQtUJqCwMPzNCFNY5K/ign/c9oHt+ad4qa9RkI?=
 =?us-ascii?Q?MJl5HdBqFFvNVD7m+8R2dRh2lrlGA0XuvmM5Yc63uqYtUXAqQLCm2oA4iAQz?=
 =?us-ascii?Q?84RlYwhv/I/83b24ufqgVHAe1O4guARKUfyS2qioyyEupIMLuEIarb/6p23g?=
 =?us-ascii?Q?M1tUs4nwlwFF376fDA+mSpvNVRTA1Of9IrYB+Yn4osrbqzZqZBilI0T0Yavf?=
 =?us-ascii?Q?sazGpEx3/mKdyv+GoT/oD3vECsRrVR+3a9R4hZTUwFFT2ZcnzvGQsSxVQwOF?=
 =?us-ascii?Q?Zit47hxbWI7r+TXUs3NBTadKxunjFfTOowQzB5qBmbsaNMXGMxfDwmAJd0zl?=
 =?us-ascii?Q?bXIx5UGymab3IYYnkdRvdRch1BpY5IKegR49beaEk9rlPmmDILupCLDXDNmJ?=
 =?us-ascii?Q?TrbPu4ZkGAPVBVddtaTRlHoOggTANF5hoJHJwK1Tgup4De8SrFyCXylc2dox?=
 =?us-ascii?Q?cvV2wFRrBi6Z2EQiFOCG9mzL3Uf/7hf2xhT/sA0N12tUWhb+TVcTwkAI3X30?=
 =?us-ascii?Q?uQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c95637a5-7814-4650-0001-08dd1de0b74e
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 14:48:34.2940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yFceLnKMnUOxPGWgceHg7YhstCpJqOjUXb5/O9gUKOVDQ4l7HvJj6R7YvFyM4u4BpsRBZqpjNrRvPvlDsYCxZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8434

On Mon, Dec 16, 2024 at 03:39:17PM +0100, Robert Hodaszi wrote:
> Actually, what you did is exactly what I did first to fix the issue, but it broke my setup when I sent VLAN-tagged messages to the device. Now I tested again, and it is working fine. That made me think it's happening because it is stripping incorrectly the VLAN tag. Probably it was just an incorrect setup, maybe something remained set either on my PC or on the unit from the previous test.
> 
> One thing is different to my change though: you're calling the br_vlan_get_proto() twice. You can tweak performance a bit probably, if you rather pass 'proto' to both dsa_software_untag_vlan_aware_bridge and dsa_software_untag_vlan_unaware_bridge instead. So something like this:

The patch is going to become stuffy, but ok. We also have to update the
kernel-doc of the 2 untagging functions to document the new argument.
I will send a v2 tomorrow after the expiry of the 24 hour timeout for
other review comments.

