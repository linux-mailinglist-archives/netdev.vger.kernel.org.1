Return-Path: <netdev+bounces-178354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B777A76B60
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 17:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58AEF1882207
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 15:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD98121322E;
	Mon, 31 Mar 2025 15:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TI2xgLyW"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011025.outbound.protection.outlook.com [40.107.130.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE1C21170D;
	Mon, 31 Mar 2025 15:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743436485; cv=fail; b=SPZIB4no+uVeQvg6putjWBWl02jAjCYxMUHbVYwJZtW4mWFcaBKWjDrci4Z4Rzc4Ytxg/rg6dBSPIpNjmhn3Uxa2iQjlP8Q8MZFF10ir7hduz0cc3xnEQO7pdujX7rnMQoWz5W3cRIXGmaPIpAMpMk1Bnfpo4gRJ3O/DNA+XA2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743436485; c=relaxed/simple;
	bh=tIGy9Zf3f8hPvWeOHHP8svcxHsLNo/vUUgjHSCKeK9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NIyHAC1Osa+mONSE/ldIVsn/KOD8sDnoxys5E1IARfs0o1JwxXCyr17+J77JDLP+Jr4WE9+bcxwSv0/4fKJyevM9mJ2eu8WQUK1TfnwXaPzUkjZtHgqENIiFM4sbrwvRHHVRpf0N4qYeP34XG7O1jgSvle4CW6QBq1RvRTm9WJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TI2xgLyW; arc=fail smtp.client-ip=40.107.130.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ESC9gI37iaxKaQ/JgCgxyn4V2UEZ70aLSzF4nKLtnvYBosKqtWpE5jqqFBiFEtA0ODWXoUlwLMi/1Dnh7jXm0WNE9S0ybGzxCzcZ0hCnAArmrl2fRTw8v9MzG5KYCA+73YdO7ZV1laFhxFxID798vKP/p3MTh5G5IGFRC7I8oFtTKGhZI6IcWnAIdwrC9NqTuIjlMxxuBk/Gz0U8JK2G3lUTv7OS3LIs+TQzoJLvg7Qf3RMYjqFUfWTua6xUTocgObaOYpKlHx4MwNSOyg6ANNga2MLaPJ7beXJIZAdXPUadlCISVi9g8wqI9ofex4hPOMNl8pEVZfcZDzK9qAbXXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ruvZ4jxRX+nQqIU3lis90wjXGlZSsXwtsCIKV8GhvYY=;
 b=qVlJkpHRN7BlpHkz2r2mrcekr3CsqaxZYI2lzeXIA5xv6nUR1tsBL2Eh/0a4xZltO2I4quQDnpulHvj0rlTVa09JIZqTdYaz3yJkS+XPTBL8eW4hw+ZjjthIQLBMjbnBiTVStPyLXssTSLzaqQDjSQge6DEBHaJzqlYgvzxfopwNRdwYNe+/Sao9ffV1ey2b0xDl/DJv6eIfA8CO4NNZ7fdqq7HFr1O1UcTpVEHchQ3HZSb+jKsEFBptCHJYFMnL9D0bTtlcvtpAxzPUPlyWwy9A8MVXAd820xaSF9WYqJY4+9DSNg/X4lnjSgaeZjeouIRTV4lOq4Yjnn3oUdHDyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ruvZ4jxRX+nQqIU3lis90wjXGlZSsXwtsCIKV8GhvYY=;
 b=TI2xgLyWtyNcf1LcEPt9ONMzVr2xW3s9HggSymklZ7l98oE2gvAxAPFTh4eWoePT+4gvA2W16BJ6qdNeNQu8ImhmpkfZmNqgaEM5jW8etKwwN/O5w37XrufqMMrIC60aKqcG6c3geYqKMTYyIJj3S6ZV4Fg0HdZZ+aLKdaEihNwxzJoR741JqlUqkmLcbcEVPGLLbePmzjNvWcyoc7Gu3NYVM6vOVPUTmnLzR/DUpSm97Td/uOLWEtKUp0YJ20R0Mvok6cvHNTO8IDPHj26GL4fa8aqXl3XqiSj8zCEuXMAa/wp0VR/UWZL/4pbeTbtOhjs8bOYo0CHWKULRQDR/UA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VE1PR04MB7469.eurprd04.prod.outlook.com (2603:10a6:800:1b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 15:54:39 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8534.048; Mon, 31 Mar 2025
 15:54:39 +0000
Date: Mon, 31 Mar 2025 18:54:36 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, Ioana Ciornei <ioana.ciornei@nxp.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: pcs: lynx: fix phylink validation regression
 for phy-mode = "10g-qxgmii"
Message-ID: <20250331155436.zmor5g3h67773qcc@skbuf>
References: <20250331153906.642530-1-vladimir.oltean@nxp.com>
 <Z-q44uKCRUtWmojl@shell.armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-q44uKCRUtWmojl@shell.armlinux.org.uk>
X-ClientProxiedBy: VI1PR06CA0099.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::28) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VE1PR04MB7469:EE_
X-MS-Office365-Filtering-Correlation-Id: 53b6e897-f2f0-45e1-562f-08dd706c583c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PrAK/U6yFindPc2hzm5aJzNIUOh6K6qDAJHgTlV8t2dY0bWi4JgPKPcsn/c8?=
 =?us-ascii?Q?QR/Lzfy3To9PPIYTnDE3kJnQjxGuQWrZcRtGHKKZazM52mrNWHP4OcUfPwW4?=
 =?us-ascii?Q?GZkiV/V2ANdU1rGWnpxsIiT7MebnnkW3Bz3ioJb1+Nng5pKP3Itq7DG8jhmC?=
 =?us-ascii?Q?KkmLTpxIOkAufgZ8V+s5gfIPaVw+8Nv0vesF46dGh0grdVglsbfq9ArEWHFT?=
 =?us-ascii?Q?XksKu+ONOEx0SAPMP2Nhq4Ad9Ov53771mXk8J631MF8mOXCmzTlURyrHSWnm?=
 =?us-ascii?Q?EzZ6nDFL8SB+mxGhnzXIF1MWA+MAXt8Js1gm93lYBvAQwPKo+TRqYO5jsMcI?=
 =?us-ascii?Q?RumfrMUh5SaUh3nKXre4q5HHecYcK/grkRV00po3RGLtjbXZlISlzbzl8Eeb?=
 =?us-ascii?Q?ZYeOURcU/l07Fnp5y1p4IWwjYtceCSpUH04CLukLbgNr3l+fOq3JqeW6qfi1?=
 =?us-ascii?Q?NGHrQg0iv/fvk4ZLQJ89YclcP+P+vLpPjJSOpR5g69/GIJ+Bfr1PuXw55l41?=
 =?us-ascii?Q?B5D/qzfkcqbEKARogdiTAqraPTKH6+mxg4KEtn/0ZHcm6W74lP7WUYeNVWbK?=
 =?us-ascii?Q?T5CiB8p0aupELMhzHLt7oWcg8b9zbNrp8p0G/bF3aE+zghAFYolTHUFXgcm2?=
 =?us-ascii?Q?6Pc/bQu/S3AioPpa8ihf9M7f45WLgh4k3nrRbAn48kOpZUPYg+SDZqDKhz8G?=
 =?us-ascii?Q?VxXdU7bel5ZZqJ2OuwmxQwL0lHUIMOo/gArN16S25SBig9dUVOFq8uAAsdgU?=
 =?us-ascii?Q?btFIghFMWAByKz20EdWFFg1CdgTDJPE2ZkloX9AX6wkq8k7u598ZZxDPxiZs?=
 =?us-ascii?Q?p9TSXd4WJiq2NJC8mNvyYNCJ+I4zvS8mS9spdEGY08eWzQQKFEZb+pfjvEW7?=
 =?us-ascii?Q?RXQ1/S6SAFGalHgj/dyLStT2K1hYPgwCcYB7utjlqavLityN9LytG6VdZ25m?=
 =?us-ascii?Q?nQBD2ixuythGuO9Xo7N9bEOvFBma+mc+4TpSRkt1/RX8coT50hgXCbeHjA7s?=
 =?us-ascii?Q?Wk+JVMFDLJXB/tmj9CHSp+v9UehnSOLEMgl2AcOJxb67QvGFElMY/+dpiUT0?=
 =?us-ascii?Q?MDRtIeamTLC6ruElEQIkj5F26VWv3wHl+gE4VMo3ubsb8Q/Wf2OTEoE3xLNX?=
 =?us-ascii?Q?4nUIAIrHtuj3ZIW37awAcXRimPilHM4IlkQAXqzlGxuicfVqOZUxDxZP0Qs8?=
 =?us-ascii?Q?g8BbWH7KPSy4ZJPa5rLkvb7fzdr8oN0wv/GRPh0OSxoZhIG7+f4ikvl4Jfo3?=
 =?us-ascii?Q?S6pzSPIOAyWxj4L7N8S15hpQDMhEFTqbE7qoZiz66TDi4FPmJnF4TwNiJvON?=
 =?us-ascii?Q?J3cqEzMJOyeqVBYbUyxmb78QEIbjJSkNR1oaQEFuyxtLgw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ogLrY+Qvpi1A7pUkfuLyFO2v60wAOY67tBnRCLBrJORzWBAxog1158XiZIGo?=
 =?us-ascii?Q?K/BuCIOV235BKBFblXqIM5eh7wqn66CuK6hK9s57PyQx6s1ley6JD3R60gbI?=
 =?us-ascii?Q?JfTkJT4/XRLvlOG9HZF8LNLDCpCsS67QZ27IRb7QEAk6W8YRnb2n/p3T/yVz?=
 =?us-ascii?Q?IYJWuzWg/8+7fRA7nA5/BCizf0SDp7iaQmEtEttYVy4gZa0+48Tc0cvJ7HnM?=
 =?us-ascii?Q?o/OCPbZ63B26ugDmRzndFvWZev75XEd007VXVtY46N2cWhVtlV6JQe0hIbb2?=
 =?us-ascii?Q?Ub/EvWlS4s+Lulwv1/7xsB5i7p9sWkSVkJBSBTf0rdAgKWBiEjYG7R05SQcd?=
 =?us-ascii?Q?jB4PDCtj4B5ytFeQeU6vMIZbQA+glUYe2r8FhOSWaR7+XEFXZ3EKTM62sJGZ?=
 =?us-ascii?Q?18uSJa7+0eR5mPDMMARNtEuRE3QQDp4xHov7Ib0hdJOYS5WavhzeRfdZa2Vo?=
 =?us-ascii?Q?lUcjYDqWMnQQm9CsOZX2EXpFJI/giCtP8TaPOQ+xx3B150FYb7ar8vmZCGtV?=
 =?us-ascii?Q?hn+l0BLVqbtyisj2nbfhfsFrK6gxSbGdaobbJbjdt2RjuyLyft70fkjZDSai?=
 =?us-ascii?Q?gw3dNDYErQG74jh/8TJiid1MgOEFTltK/D8fUKb7CZBD/c/PNY8YOhororzk?=
 =?us-ascii?Q?Rz+dZTylw0sUxs7cd4Fw/T/+pVl5LjnmBiIaRJMBN1U4HgTghXZhJBj6yxye?=
 =?us-ascii?Q?wIxGaxQE409jznU4NpzonLYtE4gOafSCzCz0ets3ed0DAbARH8aKR8M3gWpO?=
 =?us-ascii?Q?lAB94/VLEAFIbC1O2tdmUbPFy9IdzXqTk4XVzK0wDI7JlDyy7Y4WPgnZMM8x?=
 =?us-ascii?Q?PEprqf1/0xNKYbNGQ/T4KJcT9x9PSRtmWgMxERbMDWuWvN6lz8jrAOXlLENR?=
 =?us-ascii?Q?nP2Te6BHBKi+SJfSsTZ8bwRGHRt13NBraCO/LQ4zLlsae3MO69FtaCXO0YQ+?=
 =?us-ascii?Q?xqxTrL3qwB17itHEhwwh/5H9BJhN5g+RAVsNLJ/fNINlEdIgXCYIQcmy2jCm?=
 =?us-ascii?Q?9V8749EcpKZh7jX+LvQewKyKaLkV3Q+WDLyClTjwmbxF9d38KI137BoyFcjA?=
 =?us-ascii?Q?TnDdEHjiJ+rrJDcgGGA5Xn00cjxx+rzhl6PeIhEMkaXXuT2PvtuctNLof4i7?=
 =?us-ascii?Q?J4HVt/ocY2LswSv5YiPE4cLPZsSsGxL4LCCatDcB/Xqd+Z7T4ABP07WZet3p?=
 =?us-ascii?Q?Vev11rjAI8/XTxR+uceQG7xyHzYOrbkYGjww5rbqWYZHNdfjNfTKyLx+OYps?=
 =?us-ascii?Q?jxldHezoZ82DRh2XGfLtY/cLAXEspa4XyIvy7TCtHyWzoxSATqhOMUqZ5VgS?=
 =?us-ascii?Q?lxLIiPDzZ4CpGK1ysy5Zd0AGZXgU0T6yI4+urC7NelptZ5C5FCfH9qYRaJPg?=
 =?us-ascii?Q?FrqEnEv2yJ/OVod9RvL6CWZl5BeJ0Q7ILJr/OF7fM3cjOEGcVzmjoFnDGybI?=
 =?us-ascii?Q?zRHBOK4wj2VKk012/rLQZ/DgClgpM65xzvsPTu2I17dYWw8DoIPy14LpeUzQ?=
 =?us-ascii?Q?uBYg/i7O1yLZx4LGOr58VRGWrWv1mLF41Xn20P7IvkjLGSbidDCoF3pvmuVo?=
 =?us-ascii?Q?1gqhNzgEU1cMMND98ZMN4nAMCdd/VCAajljnBcPR5a1JD/2kUtXckqJ2gEic?=
 =?us-ascii?Q?ZA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53b6e897-f2f0-45e1-562f-08dd706c583c
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 15:54:39.7650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YlRzzJbYncWMC05PoMGp1jximQ629N/ndA4iHJjPALYZc43rGQXw1y9mFDvEyR+JmxGh6rAN54Z9v1ixnWuX2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7469

On Mon, Mar 31, 2025 at 04:46:42PM +0100, Russell King (Oracle) wrote:
> On Mon, Mar 31, 2025 at 06:39:06PM +0300, Vladimir Oltean wrote:
> > Added by commit ce312bbc2351 ("net: pcs: lynx: accept phy-mode =
> > "10g-qxgmii" and use in felix driver"), this mode broke when the
> > lynx_interfaces[] array was introduced to populate
> > lynx->pcs.supported_interfaces, because it is absent from there.
> 
> This commit is not in net-next:
> 
> $ git log -p ce312bbc2351
> fatal: ambiguous argument 'ce312bbc2351': unknown revision or path not in the working tree.
> 
> Checking Linus' tree, it's the same.
> 
> Are you sure lynx in mainline supports this mode?
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

Oops, you're right, please ignore me. I was working on a rebase and I
didn't even think to check whether the driver support for this new PHY
mode wasn't upstream. Now I'm starting to remember how the QCA8084 also
required it, and Luo Jie upstreamed the core support without users, and
without the Felix driver patch.

pw-bot: cr

