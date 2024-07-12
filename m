Return-Path: <netdev+bounces-111076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 927E892FBE4
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 15:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37E96282ECB
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 13:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8EBC171086;
	Fri, 12 Jul 2024 13:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hIN9X43K"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012020.outbound.protection.outlook.com [52.101.66.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F406916CD12;
	Fri, 12 Jul 2024 13:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720792496; cv=fail; b=B4rBcenRTg0v5Mo6rsWbSxE4TeV4Tz1wVz6kWZ3gHSLlZ92o9MqbAlidT3Sb+euWL0UktxchktNqTrT2RNFKsjl59cdAcWNK09sPNCnMx0ZDoBkLGP4L2ZEaZoSUViY/13nWIJvuCAOzB3cPm6wGcJ9Y2hj0eo0EolBKoUy7tJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720792496; c=relaxed/simple;
	bh=uA93U13abOwRgVBWi28hQt24i7nIxMAGd4fIOa1nlXk=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=a8tS/6fUj8asTRWv+0gYBikGNvkhvG4PAypjmp/8o0VmsBHIWlBynHofSx1Xl4bhyOUvjX/NkUEc7zq0YguyLiUKZuGIjH8lWzkjVu34nQ4kiIdvzowVvHQJyiXEXd5m3u4uIQguVHEUW8z1a1q2IWdp9E0rgMb9EoAk990tlCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=hIN9X43K; arc=fail smtp.client-ip=52.101.66.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=elaw1KlUak/PTzQg3KlU2S/uw3qX+LNStGJwlhpZG8smToMBDyrvd0AkU3Brae9Zr9t427OmCpzR3r14wwFGhtQxwe+HVdhVstTOez6Sd2x06fD7RqdVO6iKeyMrpa5HdssqkyhqtlDAFkVEnYQBnBeZreTy80BfYdpFDbvGyI5+4sMm43A2uNTw+PZ5dhdg4aYLQTcT72ELVkgZC1vTKNwubOmBBwGy2JIEuhB3FtebAIL+4kXmSZqi5yVTr3ujMFRx1wr3O2PQXoABHITx5mnpPaIrNSf9K15mBQFBea4BJBV8HKN9+FHyCf6+HO7VNqXxeaKBvHzF38GcFc91Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZQZMH/E+U+68F159rDS7TlLRCOciTMRaAR9pEwIJc4=;
 b=YjTCBGtKPi2+dJPre7EJb156GJYctef/dVJr+bYCJJGAgrSP7wlw71VFoq9edUuQF7HWvqImTiYLSG7Rmc2Dg/U476kc6pUaLf2NdrIE2/fqvcBkSvh5pP8OlmPCgbmky2lSaQXn8VdEYuMJyEU7KTTDachTZWsG4KM65BhhlFpy8W+hXcduaTgbh0U6R+vKb4uuL/5LkDtZCYUOMUsmcABj2DDD2DBc65uyPY4U9nAMowa+VcwfeTl0dIVqRoCfIYdvT3OlF8w49sUZTsn2jra7MOBGJgkQUHztGiwOh/Uw9vfXpYZIWKBg3aywuVU9Jvg/FV5Z+xy5EUkwL5cHKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZQZMH/E+U+68F159rDS7TlLRCOciTMRaAR9pEwIJc4=;
 b=hIN9X43K3O1IxAnm/B72VvyR2RzLVa4cSBOsic/sQuRHFlusiF+vubHEG/fxFxDCAgn7hC5S/cFsqxF7W74AteAb9WSU5iZZGh+ipVlvx0B55Iy1AHQq9T1Dcqae2rhjwgmmmXxQMagxSEYr88mb3yIW0nB6JqkXI4zFyj5rptk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com (2603:10a6:5:33::26) by
 AS4PR04MB9689.eurprd04.prod.outlook.com (2603:10a6:20b:4fc::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.36; Fri, 12 Jul 2024 13:54:51 +0000
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a]) by DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a%4]) with mapi id 15.20.7741.017; Fri, 12 Jul 2024
 13:54:51 +0000
Date: Fri, 12 Jul 2024 16:54:48 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Breno Leitao <leitao@debian.org>
Cc: Madalin Bucur <madalin.bucur@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	leit@meta.com,
	"open list:FREESCALE QORIQ DPAA ETHERNET DRIVER" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: dpaa: Fix compilation Warning
Message-ID: <20240712135448.6sxgevfu7hwgkve3@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712134817.913756-1-leitao@debian.org>
X-ClientProxiedBy: VE1PR08CA0001.eurprd08.prod.outlook.com
 (2603:10a6:803:104::14) To DB7PR04MB4555.eurprd04.prod.outlook.com
 (2603:10a6:5:33::26)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4555:EE_|AS4PR04MB9689:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b71c578-a111-4ef8-4329-08dca27a3371
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WiADx88k/7VTU0kp73Ev9M+4ULBC7aSsX5WxYbkRuOYtUBR81tvTeHK+fjy7?=
 =?us-ascii?Q?fYxhpvsDI2rcAM5EiVfhAYsVQExnrUcm+/H6KFizvE8YieK3iWehWGOV/Qwy?=
 =?us-ascii?Q?T4PC1a0bdJWJN1zijunqNKZ4AmKBVKe5499gApfoAocLpPL5Y0dhWgOQUm/F?=
 =?us-ascii?Q?/5kb9qjp0b/kfRc4gXvP33zD7e8d7EcA63YRU2ILzcPfn3QiW2xEHfXzAXC8?=
 =?us-ascii?Q?Vu+ORfScjxZH9n1/yOX7GuN6TNsrIgd7MJBpByTxaGPcRFF6eHfVNogOgwGz?=
 =?us-ascii?Q?6fqf8+EAue990geDC4l0jWOSnbEMg0mBmBct4YLUZVsmcOS0poTxGCWwZOOs?=
 =?us-ascii?Q?AzxAwit56pprmBPrtp7Wodz80dM6VWtu9kpoNPcNLE0dZjl4ceaODT+ZUVgn?=
 =?us-ascii?Q?rUvlJ7JR62n0NAyGTHkmDIH/xQ/n8QU7vXvjX8FgV+JbVEV+qBuSv0Xqk+D1?=
 =?us-ascii?Q?nTXSr/Vlye2k4pRxJ2BZgubN2JisOJTPcbdFk3uzqJRwizdwM4HmAmh2Cxrx?=
 =?us-ascii?Q?5DqRVhWM8V4Sbj1kjj7tp+4vPigatjIe6S0ae04UKjd7NsVnAq91ODOU++RI?=
 =?us-ascii?Q?SFTylTec9jjfwpV51YDV93XA455Dk3xFZKl36Hp1j4L7TjmZgB9SkSJNLxvK?=
 =?us-ascii?Q?w5w6DOO7XCZEj4wKWO1ugknF//yA/4kvTjb5b5G5MJ3q1HRLO3GJd8szyzdX?=
 =?us-ascii?Q?zJ0za9WbBlWs9xzSZm+2l176M7G5R3OKCRyREJRppK8mh4wifFKePGv6zts9?=
 =?us-ascii?Q?k2NdZsE/O18FR1QmSVkMYQq1zwonjB4110+2yGMEreBlzhUWX6qU6lJ34/Ku?=
 =?us-ascii?Q?6woJwpEHbWBLGHFs4NX4MuMKdDL259kB1D09su+xD13MmlGv4YXN/rNT2UtH?=
 =?us-ascii?Q?hFh+vuvL26DspkJOdPpvSc0TuCRbtsoSQ+LulTKsasveuFEg/MsxOESuc7Zk?=
 =?us-ascii?Q?sdMdbYZgXDemQiZWjmtO5pWfJEwihrp92m+9XgN8jx3Q1e8sDqUy+/MDoTuG?=
 =?us-ascii?Q?Qr3Fz7YMAFgfRarjTKj6doecEm2a+GMzrgJp9+75NUp60xVgy+jMzzZOiWuP?=
 =?us-ascii?Q?h3lKQSP5b4IQVU2Da5giOyvgNoU1uPXjHHXIVumXrXxsLyEygTQnju6FMwLQ?=
 =?us-ascii?Q?dumMWcTwgQqq264VvT1EMj1g2X3HZZTH+hTODq5DB+OC14ipnPcOuO9YL26k?=
 =?us-ascii?Q?YsXSmWfoBXzSk6YDZDKMX9teStsYHJFecrpAXp0eZPXIR1mnwubTopYchMqx?=
 =?us-ascii?Q?R3pLTxO0MUHz5+IEjINkQwFs2NLJVFgAvOWd68sQuqEOW+s4t/t6Nuea/vXU?=
 =?us-ascii?Q?ua8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4555.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cbstIaxErW5SC9quCTOc/PfXzXObgcQ1/qnaVYRIJ4UzDAljjmf75R30rj2y?=
 =?us-ascii?Q?pFoopqwFCkhmgbE3ju11B1QuUXVhObmQVwCNf0v5YNdiyJPEjA3pzHOt9SQh?=
 =?us-ascii?Q?ed1aLlEOYriLxA3j4wSDbfiekt6Edma4PAKxZghX/TN02mzdxGzFWIFty71E?=
 =?us-ascii?Q?po+7Sq2M6gwobQxFrxB7Hdy/WNWr87+GNzcC3iq+AEYk2/lyxL02D4REPqqS?=
 =?us-ascii?Q?ohSEwHObHZ0wxqSJjcuy+eCk1yzlTMXV0T/a6AkyutXQurKj5nWJH/0Sa4e6?=
 =?us-ascii?Q?fG8DeGHzOlJyBAywzjTAnUWRGSZlRi1tzRrJ2RWhXtVTk3SrIWByIugvPXWG?=
 =?us-ascii?Q?wPOn1R+efTfYHAr+E8br65M2IHzgG7dj26Z/jXd+NP2wLW/lb2ME3HemVPlb?=
 =?us-ascii?Q?J3eU1vHWRodMJJp8qcc70GmYMd1FVjdKss0om9EhEwF0LkdopXsQdt8TsXIj?=
 =?us-ascii?Q?hU2XMCF9Ui6tfeK0Q/jzwOagFGmJ0UCsRXrb+DhtYwdOqBY+qjKQGXJsbSxd?=
 =?us-ascii?Q?2yxWPOxfuzgGSuhWgZ50vGW6VMIElxYZfSj2ltR6G4PMvP8eDNIlf2HBLmHb?=
 =?us-ascii?Q?2YJwwx1uJaVO+t8XQG6Bkpaf3QvOSzz1GTBWM7h0zsPvh6GKcNE2pyT/48+l?=
 =?us-ascii?Q?7i+C/alS/xC1uTBjNg9d9sMr1HSfgRmAsVcU2WSDhKAOLI/Wwivz0l+Hu09c?=
 =?us-ascii?Q?myB9NYlMf+RL64Sh0D2GDdBJD/T6CgBFj8HUOBaY37Fq+Ny561zU13r1+VZI?=
 =?us-ascii?Q?bB0h41FBLQRbIIu0HMTc38A1mlCaBEg1YVzXmiYX2lxLpDl2/ZGQabNZKf2Z?=
 =?us-ascii?Q?XN8YjFZveTxVkgz2ar2t6YdDdsbKOPBqLod3CWEb0dJcP5w3DgAqpslfZF2h?=
 =?us-ascii?Q?I2B9s4n6Q7rogvJ6DJ9HoqLGUFh5AXUYdhs1/n7VqQH8K+slOUc8F7WonqxB?=
 =?us-ascii?Q?BLgNk+cE4nQkWLq0SMwIrLcAPAyys7qNg9PR633WZFA4wMHJGxqFnJGcEsCv?=
 =?us-ascii?Q?ltVvMMOoUA2NEc9oMbhrtnu3KOlILZflnXgYnrIMo97leTJgMqlB3DoqQISp?=
 =?us-ascii?Q?cBr78mXfgkeCfeOAprkpCYIY/IMvE/CeYZhd/TmwtDrh1iMYr1nCEUl1eyFk?=
 =?us-ascii?Q?f+V5EJ9QJWViyXQ2VX8YHjsCd3+DN4B9zk+Tr3vAvb0+RRad5sYcU8cNQ14U?=
 =?us-ascii?Q?cBiDUyeMnkTh+eIkc+Vp57f+M2iFoLnOPpxKWZDGSXYECvtNZjwRfJqynPH+?=
 =?us-ascii?Q?l2K/Gxt4WnrmlHEAsYQrbIiPUbCE4M9MdEISw7egqbNHIDQItu2bDjWkp7/g?=
 =?us-ascii?Q?7rxEz+9RxeLS/NptY2qi6/84eeNaDun8R7pu9g0vz4bKTtBbZR7bPgOCo5E+?=
 =?us-ascii?Q?E6Rq8aJepISww5H0gyJW2GKQIPxWJaSdl++RfMCXrCRbbmk6oEwPBOkgNll4?=
 =?us-ascii?Q?sEZJ2ixa8RsP8j+5I4vMfxfmgazlCBMnqZPnVp7t+OOFIUe4sRJWoONoyvQ3?=
 =?us-ascii?Q?JbiISFCzhDVZSIer/QdNl/Bg2a/gbRnBoCEAj7mEN5e77BETjgwKy6eIgJvD?=
 =?us-ascii?Q?pYhsQGQ2y6sz2tPEtiQv0oWXIqnhzUwDsCQctMksCXtotPPnYQHItHy/HSYV?=
 =?us-ascii?Q?Kw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b71c578-a111-4ef8-4329-08dca27a3371
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4555.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 13:54:51.5858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t3+MywDOVCJb+2u3LILxKhQG9rG37JNqJo2iaH42F9Hz1QMORZoxKw/C4+KYaLfh3jT/knRvAqjQs5VGgZjDeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9689

On Fri, Jul 12, 2024 at 06:48:16AM -0700, Breno Leitao wrote:
> Remove variables that are defined and incremented but never read.
> This issue appeared in network tests[1] as:
> 
> 	drivers/net/ethernet/freescale/dpaa/dpaa_eth_sysfs.c:38:6: warning: variable 'i' set but not used [-Wunused-but-set-variable]
> 	38 |         int i = 0;
> 	   |             ^
> 
> Link: https://netdev.bots.linux.dev/static/nipa/870263/13729811/build_clang/stderr [1]
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

