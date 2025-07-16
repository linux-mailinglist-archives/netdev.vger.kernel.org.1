Return-Path: <netdev+bounces-207584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AD5B07F33
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 23:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 391D91604F8
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 21:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F4B290D83;
	Wed, 16 Jul 2025 21:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AtlotHzD"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010025.outbound.protection.outlook.com [52.101.69.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3187028D8F8;
	Wed, 16 Jul 2025 21:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752699687; cv=fail; b=H1VmcPfUWTaJIEwv5KFFQQJ+tks2F3mEkGWwBELe69WKYQjd2y0oKcntTXmk2FAfPVfOBr8JSAeRtKkovbLjKBOpq3BxkbFsBWwJQx4+C79EmaBEenYDPnL85zzbge52SKCwqwZHZNjz5HZsBvOWEUh5uw9XavDQYJjqxCmgNVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752699687; c=relaxed/simple;
	bh=LOnsBeMVLOT1J0iJuzOBlsc9dOriqgZ1QGws/07c3yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n8UHL6tVYTnWknbm6rZVXrZ5Y4EDT0QqIAtJJM0hWc0NcnI2jWQU3k26e5Spnod3fncrImWIewdBQ+HKOyNI4zQclQexHGcKQKc5uSZekAlGADrIqWVSlG15CpeWTCxCKgZK/TP07cU162GGN8cbZm6kBhXGsT4EU5vVyxZJojY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AtlotHzD; arc=fail smtp.client-ip=52.101.69.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TXaPkK4+ulUy2InISiCGV6kgYNhDXijycepM6GPg+ULPJ9pIohFamT2MFF/DkppTdjKCjRL/mRYGCx3wo/bUxpdIeucQTIgW0jKaLB5XmWYyym3dMiTE3CJE+Vy2/PlvYwsiuN/Q1x5TJ9akwz8XhZUsWYLu1rnee1v9tMhkb/zjUqzF5/ffy43EKojyxN+DCz3O/tW8Mmw4pcd20e1J37hxn6IZD5gUB9EigATZiq9j+6Pra85fA7y89ktOitF2xszLhFgz1XmFfAGNwhFQGmNr+HmMNx8cGeF9rUnxOvV5+giRkwBhtUSTKoPoT8SMwobEiG0ZThdw7QtQo+o9Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjl0Kdl4nObLHBdniWikLwKLErDfoeIhc9ASnyg3fxM=;
 b=VC3oQ5WjJs96vd7EsvrGcmAqKyuDi+KkAZ6Epx3FCYYGHjKxH85LkRLruFXA4bDpJ4fh4i6YpkBoBghPSgIJaz8HZiyViO92x8VhDXs/STxE9W0kvvu+PDSowX7OlRNOy6nOjjvo8/GvyidRKZj/cw/IRNTPncEROOSA4RIEUOKCIogQXCt5yf4jTLjXXjRH1iT/OdAJVccsBtw7zxceF/c3WFPeBHmqQitztzA4AjJvUllKQK6C2JjkEp9eAPLLIgJRlDtyZE4NnbFCFEwpTI+VkcFgzk/cFht0ll6/iPoY3j6BeFB9t7bcJIJ7E45aN5ZyMwERdeNl8uBFoMZ6vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjl0Kdl4nObLHBdniWikLwKLErDfoeIhc9ASnyg3fxM=;
 b=AtlotHzDvEU+j4PDzs1FY/cMdO/mIr7Y+VQ59cxw9OXefAoHwbiRfy5Tg/otRVMxD56lJkC833a5VGu7zuhXpJ1o+gOL78uOs/ln3DWo/IDiQ638nA1DjzXZh4hrJiDfksKJiMte2wIlQbA5xumD1ANqSjWihUjgzk24NvJSqM1m/79K2qCB87YTPdQKhSMReB76AP5IaCOdIQq0Df88+eiUkD+Z8x55eaoZ8H4gb1YPSDqUMsgZiC0aweyB+p+rQuO3kJn2+AGSj1EKFHvnTXARJTcmadzFNDq9CKybsQ/zysqytvMt3bjehAppfofeLGXk6w8Li0pcSZH4A3riEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB7040.eurprd04.prod.outlook.com (2603:10a6:800:121::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 21:01:22 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 21:01:22 +0000
Date: Wed, 16 Jul 2025 17:01:15 -0400
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	richardcochran@gmail.com, claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
	shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
	fushi.peng@nxp.com, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, kernel@pengutronix.de
Subject: Re: [PATCH v2 net-next 12/14] net: enetc: add PTP synchronization
 support for ENETC v4
Message-ID: <aHgTG1hIXoN45cQo@lizhi-Precision-Tower-5810>
References: <20250716073111.367382-1-wei.fang@nxp.com>
 <20250716073111.367382-13-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716073111.367382-13-wei.fang@nxp.com>
X-ClientProxiedBy: AM0PR03CA0012.eurprd03.prod.outlook.com
 (2603:10a6:208:14::25) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB7040:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c83c035-10c9-439e-c6fd-08ddc4abeb10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hqjPlDN6XNymtG+sep/uikB3wKjAZoe6n4RFut3zbmhWVo1f4q79yAiZzrOW?=
 =?us-ascii?Q?+vt/AQA8Vk/9KrqHsxYUpa+c8yDnYYxAhhMFVinOMWy+Pjr14f+ANS8g+lah?=
 =?us-ascii?Q?KhqopJWnAESe8XFULnn6GQWUg32HfB6bhQbQFKKN90ouseJXLtMYX8dMxEeT?=
 =?us-ascii?Q?0YBcBAovPIpfJeK0M3TF+mVFmNyVtzhGXv8MDdBFmxlilJwnc4X08qZ/Chs2?=
 =?us-ascii?Q?hXd4l9J5ZMM1hdseaVg1z/Uh35kBXrLNbXwdeMYyWCJoETGO2YDZKvlr1CO3?=
 =?us-ascii?Q?xeq4/N8fbmAscc8OuMka973TQgvCEQjE/iDTto7iaFsCOe+kchkNDDCfYJF4?=
 =?us-ascii?Q?zrMrjjkU4u9FsbE8XFXvgWiik49TRW/V13nt4+jWeD+byso/X6OCa9lSp/Ss?=
 =?us-ascii?Q?A1+p49pz/FiAPcYqptc0fEUG4o8NnrPngA1bhSnxrfHYRebm+aZHjMPSfaoa?=
 =?us-ascii?Q?nYkkjA/C3jxrn84z4jG/eQoEKsmZQ/CimoED64u8yGrfcdx6OILnzrjMcY/A?=
 =?us-ascii?Q?Z3A1XUQCMA+VEJmCAmOpkh3/kff9bbMT2H69o2uIOp/k4BzaDA3hN+ngdqw0?=
 =?us-ascii?Q?wS/EqEvaSVP9PWwZfS10ExIDZaqtfdJSpdZdhjh0dG4a/YmcKHmPA2v9Tzh8?=
 =?us-ascii?Q?CHBE1p1h/kSqVDUaWMQtgqSz7e97twzn20YdkU+IxuXnKen9LTRvZZYdC5tD?=
 =?us-ascii?Q?N00a8mDeEvrDNQSJdrq/VWupiec3GD87xiej85Evj4EhjYdea/1g2ndn2C1x?=
 =?us-ascii?Q?eAZrhRK4kXucVZ2qdXx01jWR6Sjqfda+o0FuM0fAChJsTesqrUaoUlBKaeat?=
 =?us-ascii?Q?EoS4qpjRi42zfhRT6TcbT1S1U7qg5/dPgl2fty9Ko6zTupTz/LAF4uJrAIiI?=
 =?us-ascii?Q?7TyJAYP9cOD+CcsNSreiQTX3CJO97Hd92DXqYUZo2BdBDP2OCQtgUDUxuWON?=
 =?us-ascii?Q?1UTz98yNmctvy4bdf42LUehXvh2fbXiRqiWO410X4Sh1xUq+N4mDy5EM1a4G?=
 =?us-ascii?Q?GiRUion3Te9a4mToJuRFbAXqB459oZv0FS9jf1NImHPwIK3d2GbEtEmDUTtB?=
 =?us-ascii?Q?+K0S5BcC7gQ4N2+TpqxHNv+uhACJWDpn/DNzmq7PLcPHERtZRqSoQU+PUuLZ?=
 =?us-ascii?Q?kThBSjgLrZbDV2QmNKmcJk47It34qD1Zc5xo8nTYrs2Lhma2lcb3w9V7rtXc?=
 =?us-ascii?Q?gzIN46+hpyXm5ZkHzglMxiT8sIRqmbyFSs2wfVjmpjftVskgw9uXbYMTKkLR?=
 =?us-ascii?Q?0PNpNjKC7pUq+ffpIFdpMBjHQgjHb4GWonp0DkdvC0EhxFIaNSFzR9GK7g98?=
 =?us-ascii?Q?ptjq+5kqezhYJ7CCwnRFBpzH/ObLQCkWFo8DxZgi6eyNoCze1T+tHRAx2b9h?=
 =?us-ascii?Q?zpCxyHOetwlbrRxue+V6wBXEqGerF2IZc/DfTOtaJgd9dh8RipUm1ZTd7caA?=
 =?us-ascii?Q?jkWZUX86XmLR1xYmA9gmZQGScOc7z0IbAOdvdmyxy+QZrL0coHxklQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aor7M7SyTwrQB6kzGBEAyDSSXBItFggw6DbRlFF/57mCokZEBdlXoYQh9oqH?=
 =?us-ascii?Q?FtwLteYrXWc7jzLWBNBiqH89v7HD0vkclohLUR7ccr0uZ9wuovJ2bsWgsQIH?=
 =?us-ascii?Q?z1YIpc/QKPfWacYQ4Zr/3K3ocK9wk25sbSKwua/qw46nuFRkj3AmZU+xMk0I?=
 =?us-ascii?Q?a7MwDWJgeKCaiTrpTrcfZYFQTQn/SjWwcpjOZma2GA/UozueJr9XjZiSW3Kx?=
 =?us-ascii?Q?kZ1gI8mEhymM/xbZHA+vegdgDsGupgQ2ReMopjoGNKkWE1+CR0Ri+wapiFBh?=
 =?us-ascii?Q?he423/D4dGRfdKwDUOG0E6me7gqWvK90sKNzfzr8ciivGRjF9zE0D95Nn6gy?=
 =?us-ascii?Q?8O1tybBSPpZGF5uPYHBkBL4HizURnayrFOTNqvLYwqQekD5MGdrQnNkKJG+O?=
 =?us-ascii?Q?GeULR3hsnXTxld1v4omhY/jqkEG4hhTdDuGdKF6SYVJgCrQvhwaPGP7jSTGj?=
 =?us-ascii?Q?Fwc40gHvg29bC2AiP0upucHHfUXHCzZ1QgnYEdyXg5Pvy32Vgs8ShxKgCwIL?=
 =?us-ascii?Q?bxXKM+hPYZA4GHf5WbQRuc0W64T9HvwpqAiNEtlXsNRknh1fMLJ2pUWX/IK9?=
 =?us-ascii?Q?2W74VBJ6Fb7DL/WF0VK1NdlIAq896wS8Z+fxZYKcSaYeF/Sw/A79PjCIxOqH?=
 =?us-ascii?Q?R6oqrwReIgGY6UXjKdkhVOlEMAXwJ5BF6MIZkAO2oSDZBV5vAk4EjlcrkSFi?=
 =?us-ascii?Q?0c3cAaCJwVt2rm2bw35hPhhtmUs59yb47vIxnbS3TbHkI/DFWoTJSfaKtCID?=
 =?us-ascii?Q?8rFWoFAxJzC30CclKrOPwuvmXktScd8WrB5o9ajzC9Mne0BRSntnYDu1cwVq?=
 =?us-ascii?Q?DCpDeuUAsvicJzxhiu1lG3CHXZDBfvR0Y56kxDQA2g/MjMtz37RBOPrzI6Rs?=
 =?us-ascii?Q?dSG1X6IeVCB7zUUkClZYYlGH7VsI1fswVdwQjSUzWMwH+KX5ZtAjilS9S7x/?=
 =?us-ascii?Q?9fdruCVuMNppTCiVQo0I7cElf4FQmGxILW+y8RaxiajHWDnqucaEzBECsv17?=
 =?us-ascii?Q?veTyBEPADkDXDziaLSaekVWv+u4LaJOqRyRPQYMFaoy5uB3WDv6dEf4KHprj?=
 =?us-ascii?Q?720QUyugOHGjkDpulsIGNlGFk+o4jmu+HHjqVGNP3g1pKsyWhm3emuOGrp0w?=
 =?us-ascii?Q?4EpTK15Nq2tF5PemVF/BLCCD7AO451UI2fLujez8vkZQjaycwvTfvU98THU1?=
 =?us-ascii?Q?1YgkuRly69qVqitzewUdTSZxu0vs2bT7OnBxrw7WtaPn3xHxSG9WzbSbtmVC?=
 =?us-ascii?Q?FRjfXtbXnOpSWC9FWjzmGiY/E5bjndgmT8Lb2CgZ0OjQRtrU9mn++kNrS43B?=
 =?us-ascii?Q?LxSB/W++cW02cgGCRB7A/atUJ8b0lQrbvyGL3LB9K50SHWqfwj13+tzq3TTw?=
 =?us-ascii?Q?1yDjxY0pd98DjQooK97QQlRNNhHZZpZnHJs8bYe+Bl9nQA4ZmF/jq2SyP5mX?=
 =?us-ascii?Q?m9aNN5XtuOcbZektJm7Q/4OUrAXofBJWbYYuJAWbNSUZj22VlNb8oF/7WzOb?=
 =?us-ascii?Q?yBlKZVG2VerVsGTgMjGJQXpeTYnhSL067GnXml/Ia18rikzU+LlLTg3q2g0X?=
 =?us-ascii?Q?P8h69l7GD04BhYaHgBT1jmmgiWzbcTYHvFo/hS/r?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c83c035-10c9-439e-c6fd-08ddc4abeb10
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 21:01:22.0578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IdYxfLLpfISGAO12oJAZ5wwixjqJUO2B3wsWTPj7t3UAC8/LWr1Bby28F5oG1+ATV66KF5lG02keLCfSbWwfMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7040

On Wed, Jul 16, 2025 at 03:31:09PM +0800, Wei Fang wrote:
> Regarding PTP, ENETC v4 has some changes compared to ENETC v1 (LS1028A),
> mainly as follows.
>
> 1. ENETC v4 uses a different PTP driver, so the way to get phc_index is
> different from LS1028A. Therefore, enetc_get_ts_info() has been modified
> appropriately to be compatible with ENETC v1 and v4.
>
> 2. The hardware of ENETC v4 does not support "dma-coherent", therefore,
> to support PTP one-step, the PTP sync packets must be modified before
> calling dma_map_single() to map the DMA cache of the packets. Otherwise,
> the modification is invalid, the originTimestamp and correction fields
> of the sent packets will still be the values before the modification.
>
> 3. The PMa_SINGLE_STEP register has changed in ENETC v4, not only the
> register offset, but also some register fields. Therefore, two helper
> functions are added, enetc_set_one_step_ts() for ENETC v1 and
> enetc4_set_one_step_ts() for ENETC v4.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
>
> ---
> v2 changes:
> 1. Move the definition of enetc_ptp_clock_is_enabled() to resolve build
> errors.
> 2. Add parsing of "nxp,netc-timer" property to get PCIe device of NETC
> Timer.
> ---
>  drivers/net/ethernet/freescale/enetc/enetc.c  | 55 +++++++----
>  drivers/net/ethernet/freescale/enetc/enetc.h  |  8 ++
>  .../net/ethernet/freescale/enetc/enetc4_hw.h  |  6 ++
>  .../net/ethernet/freescale/enetc/enetc4_pf.c  |  3 +
>  .../ethernet/freescale/enetc/enetc_ethtool.c  | 92 ++++++++++++++++---
>  5 files changed, 135 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index 4325eb3d9481..6e04dd825a95 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -221,6 +221,31 @@ static void enetc_unwind_tx_frame(struct enetc_bdr *tx_ring, int count, int i)
>  	}
>  }
>
> +static void enetc_set_one_step_ts(struct enetc_si *si, bool udp, int offset)
> +{
> +	u32 val = ENETC_PM0_SINGLE_STEP_EN;
> +
> +	val |= ENETC_SET_SINGLE_STEP_OFFSET(offset);
> +	if (udp)
> +		val |= ENETC_PM0_SINGLE_STEP_CH;
> +
> +	/* the "Correction" field of a packet is updated based on the
> +	 * current time and the timestamp provided
> +	 */
> +	enetc_port_mac_wr(si, ENETC_PM0_SINGLE_STEP, val);
> +}
> +
> +static void enetc4_set_one_step_ts(struct enetc_si *si, bool udp, int offset)
> +{
> +	u32 val = PM_SINGLE_STEP_EN;
> +
> +	val |= PM_SINGLE_STEP_OFFSET_SET(offset);
> +	if (udp)
> +		val |= PM_SINGLE_STEP_CH;
> +
> +	enetc_port_mac_wr(si, ENETC4_PM_SINGLE_STEP(0), val);
> +}
> +
>  static u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
>  				     struct sk_buff *skb)
>  {
> @@ -234,7 +259,6 @@ static u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
>  	u32 lo, hi, nsec;
>  	u8 *data;
>  	u64 sec;
> -	u32 val;
>
>  	lo = enetc_rd_hot(hw, ENETC_SICTR0);
>  	hi = enetc_rd_hot(hw, ENETC_SICTR1);
> @@ -279,12 +303,10 @@ static u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
>  	*(__be32 *)(data + tstamp_off + 6) = new_nsec;
>
>  	/* Configure single-step register */
> -	val = ENETC_PM0_SINGLE_STEP_EN;
> -	val |= ENETC_SET_SINGLE_STEP_OFFSET(corr_off);
> -	if (enetc_cb->udp)
> -		val |= ENETC_PM0_SINGLE_STEP_CH;
> -
> -	enetc_port_mac_wr(priv->si, ENETC_PM0_SINGLE_STEP, val);
> +	if (is_enetc_rev1(si))
> +		enetc_set_one_step_ts(si, enetc_cb->udp, corr_off);
> +	else
> +		enetc4_set_one_step_ts(si, enetc_cb->udp, corr_off);

Can you use callback function to avoid change this logic when new version
appear in future?

>
>  	return lo & ENETC_TXBD_TSTAMP;
>  }
> @@ -303,6 +325,7 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
>  	unsigned int f;
>  	dma_addr_t dma;
>  	u8 flags = 0;
> +	u32 tstamp;
>
>  	enetc_clear_tx_bd(&temp_bd);
>  	if (skb->ip_summed == CHECKSUM_PARTIAL) {
> @@ -327,6 +350,13 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
>  		}
>  	}
>
> +	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
> +		do_onestep_tstamp = true;
> +		tstamp = enetc_update_ptp_sync_msg(priv, skb);
> +	} else if (enetc_cb->flag & ENETC_F_TX_TSTAMP) {
> +		do_twostep_tstamp = true;
> +	}
> +
>  	i = tx_ring->next_to_use;
>  	txbd = ENETC_TXBD(*tx_ring, i);
>  	prefetchw(txbd);
> @@ -346,11 +376,6 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
>  	count++;
>
>  	do_vlan = skb_vlan_tag_present(skb);
> -	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP)
> -		do_onestep_tstamp = true;
> -	else if (enetc_cb->flag & ENETC_F_TX_TSTAMP)
> -		do_twostep_tstamp = true;
> -

why need move this block up?

>  	tx_swbd->do_twostep_tstamp = do_twostep_tstamp;
>  	tx_swbd->qbv_en = !!(priv->active_offloads & ENETC_F_QBV);
>  	tx_swbd->check_wb = tx_swbd->do_twostep_tstamp || tx_swbd->qbv_en;
> @@ -393,8 +418,6 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
>  		}
>
>  		if (do_onestep_tstamp) {
> -			u32 tstamp = enetc_update_ptp_sync_msg(priv, skb);
> -
>  			/* Configure extension BD */
>  			temp_bd.ext.tstamp = cpu_to_le32(tstamp);
>  			e_flags |= ENETC_TXBD_E_FLAGS_ONE_STEP_PTP;
> @@ -3314,7 +3337,7 @@ int enetc_hwtstamp_set(struct net_device *ndev,
>  	struct enetc_ndev_priv *priv = netdev_priv(ndev);
>  	int err, new_offloads = priv->active_offloads;
>
> -	if (!IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK))
> +	if (!enetc_ptp_clock_is_enabled(priv->si))
>  		return -EOPNOTSUPP;
>
>  	switch (config->tx_type) {
> @@ -3364,7 +3387,7 @@ int enetc_hwtstamp_get(struct net_device *ndev,
>  {
>  	struct enetc_ndev_priv *priv = netdev_priv(ndev);
>
> -	if (!IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK))
> +	if (!enetc_ptp_clock_is_enabled(priv->si))
>  		return -EOPNOTSUPP;
>
>  	if (priv->active_offloads & ENETC_F_TX_ONESTEP_SYNC_TSTAMP)
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
> index c65aa7b88122..6bacd851358c 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.h
> @@ -598,6 +598,14 @@ static inline void enetc_cbd_free_data_mem(struct enetc_si *si, int size,
>  void enetc_reset_ptcmsdur(struct enetc_hw *hw);
>  void enetc_set_ptcmsdur(struct enetc_hw *hw, u32 *queue_max_sdu);
>
> +static inline bool enetc_ptp_clock_is_enabled(struct enetc_si *si)
> +{
> +	if (is_enetc_rev1(si))
> +		return IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK);
> +
> +	return IS_ENABLED(CONFIG_PTP_1588_CLOCK_NETC);
> +}
> +

why v1 check CONFIG_FSL_ENETC_PTP_CLOCK and other check
CONFIG_PTP_1588_CLOCK_NETC

Frank
>  #ifdef CONFIG_FSL_ENETC_QOS
>  int enetc_qos_query_caps(struct net_device *ndev, void *type_data);
>  int enetc_setup_tc_taprio(struct net_device *ndev, void *type_data);
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
> index aa25b445d301..a8113c9057eb 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
> @@ -171,6 +171,12 @@
>  /* Port MAC 0/1 Pause Quanta Threshold Register */
>  #define ENETC4_PM_PAUSE_THRESH(mac)	(0x5064 + (mac) * 0x400)
>
> +#define ENETC4_PM_SINGLE_STEP(mac)	(0x50c0 + (mac) * 0x400)
> +#define  PM_SINGLE_STEP_CH		BIT(6)
> +#define  PM_SINGLE_STEP_OFFSET		GENMASK(15, 7)
> +#define   PM_SINGLE_STEP_OFFSET_SET(o)  FIELD_PREP(PM_SINGLE_STEP_OFFSET, o)
> +#define  PM_SINGLE_STEP_EN		BIT(31)
> +
>  /* Port MAC 0 Interface Mode Control Register */
>  #define ENETC4_PM_IF_MODE(mac)		(0x5300 + (mac) * 0x400)
>  #define  PM_IF_MODE_IFMODE		GENMASK(2, 0)
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> index b3dc1afeefd1..107f59169e67 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> @@ -569,6 +569,9 @@ static const struct net_device_ops enetc4_ndev_ops = {
>  	.ndo_set_features	= enetc4_pf_set_features,
>  	.ndo_vlan_rx_add_vid	= enetc_vlan_rx_add_vid,
>  	.ndo_vlan_rx_kill_vid	= enetc_vlan_rx_del_vid,
> +	.ndo_eth_ioctl		= enetc_ioctl,
> +	.ndo_hwtstamp_get	= enetc_hwtstamp_get,
> +	.ndo_hwtstamp_set	= enetc_hwtstamp_set,
>  };
>
>  static struct phylink_pcs *
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
> index 961e76cd8489..404dcb102b47 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
> @@ -2,8 +2,11 @@
>  /* Copyright 2017-2019 NXP */
>
>  #include <linux/ethtool_netlink.h>
> +#include <linux/fsl/netc_global.h>
>  #include <linux/net_tstamp.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
> +
>  #include "enetc.h"
>
>  static const u32 enetc_si_regs[] = {
> @@ -877,23 +880,49 @@ static int enetc_set_coalesce(struct net_device *ndev,
>  	return 0;
>  }
>
> -static int enetc_get_ts_info(struct net_device *ndev,
> -			     struct kernel_ethtool_ts_info *info)
> +static struct pci_dev *enetc4_get_default_timer_pdev(struct enetc_si *si)
>  {
> -	struct enetc_ndev_priv *priv = netdev_priv(ndev);
> -	int *phc_idx;
> -
> -	phc_idx = symbol_get(enetc_phc_index);
> -	if (phc_idx) {
> -		info->phc_index = *phc_idx;
> -		symbol_put(enetc_phc_index);
> +	struct pci_bus *bus = si->pdev->bus;
> +	int domain = pci_domain_nr(bus);
> +	int bus_num = bus->number;
> +	int devfn;
> +
> +	switch (si->revision) {
> +	case ENETC_REV_4_1:
> +		devfn = PCI_DEVFN(24, 0);
> +		break;
> +	default:
> +		return NULL;
>  	}
>
> -	if (!IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK)) {
> -		info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE;
> +	return pci_dev_get(pci_get_domain_bus_and_slot(domain, bus_num, devfn));
> +}
>
> -		return 0;
> -	}
> +static struct pci_dev *enetc4_get_timer_pdev(struct enetc_si *si)
> +{
> +	struct device_node *np = si->pdev->dev.of_node;
> +	struct fwnode_handle *timer_fwnode;
> +	struct device_node *timer_np;
> +
> +	if (!np)
> +		return enetc4_get_default_timer_pdev(si);
> +
> +	timer_np = of_parse_phandle(np, "nxp,netc-timer", 0);
> +	if (!timer_np)
> +		return enetc4_get_default_timer_pdev(si);
> +
> +	timer_fwnode = of_fwnode_handle(timer_np);
> +	of_node_put(timer_np);
> +	if (!timer_fwnode)
> +		return NULL;
> +
> +	return pci_dev_get(to_pci_dev(timer_fwnode->dev));
> +}
> +
> +static void enetc_get_ts_generic_info(struct net_device *ndev,
> +				      struct kernel_ethtool_ts_info *info)
> +{
> +	struct enetc_ndev_priv *priv = netdev_priv(ndev);
>
>  	info->so_timestamping = SOF_TIMESTAMPING_TX_HARDWARE |
>  				SOF_TIMESTAMPING_RX_HARDWARE |
> @@ -908,6 +937,42 @@ static int enetc_get_ts_info(struct net_device *ndev,
>
>  	info->rx_filters = (1 << HWTSTAMP_FILTER_NONE) |
>  			   (1 << HWTSTAMP_FILTER_ALL);
> +}
> +
> +static int enetc_get_ts_info(struct net_device *ndev,
> +			     struct kernel_ethtool_ts_info *info)
> +{
> +	struct enetc_ndev_priv *priv = netdev_priv(ndev);
> +	struct enetc_si *si = priv->si;
> +	struct pci_dev *timer_pdev;
> +	int *phc_idx;
> +
> +	if (!enetc_ptp_clock_is_enabled(si))
> +		goto timestamp_tx_sw;
> +
> +	if (is_enetc_rev1(si)) {
> +		phc_idx = symbol_get(enetc_phc_index);
> +		if (phc_idx) {
> +			info->phc_index = *phc_idx;
> +			symbol_put(enetc_phc_index);
> +		}
> +	} else {
> +		timer_pdev = enetc4_get_timer_pdev(si);
> +		if (!timer_pdev)
> +			goto timestamp_tx_sw;
> +
> +		info->phc_index = netc_timer_get_phc_index(timer_pdev);
> +		pci_dev_put(timer_pdev);
> +		if (info->phc_index < 0)
> +			goto timestamp_tx_sw;
> +	}
> +
> +	enetc_get_ts_generic_info(ndev, info);
> +
> +	return 0;
> +
> +timestamp_tx_sw:
> +	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE;
>
>  	return 0;
>  }
> @@ -1296,6 +1361,7 @@ const struct ethtool_ops enetc4_pf_ethtool_ops = {
>  	.get_rxfh = enetc_get_rxfh,
>  	.set_rxfh = enetc_set_rxfh,
>  	.get_rxfh_fields = enetc_get_rxfh_fields,
> +	.get_ts_info = enetc_get_ts_info,
>  };
>
>  void enetc_set_ethtool_ops(struct net_device *ndev)
> --
> 2.34.1
>

