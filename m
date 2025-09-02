Return-Path: <netdev+bounces-219215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE09B4085B
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 17:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F3C73A255D
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 15:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6022E7F1C;
	Tue,  2 Sep 2025 15:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DXfEqtmR"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012027.outbound.protection.outlook.com [52.101.66.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324ED1DE2A0;
	Tue,  2 Sep 2025 15:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756825377; cv=fail; b=fEBL6iPcej35dVa4YO+qa6qZThTBz0B/QPlWcC5E757WDpxca2wnsXZuxHU2dwlkLmk6+aPKr3dS1oFwiBCbTMKt7//7mpJCNsKeAtrGmMdN/Cgbk/64oZ8uTKrRw1gCQPOLKxEQF9wiSVupYKmg2FQMcBNMqVU7kt5gEJno1Ts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756825377; c=relaxed/simple;
	bh=sE7jMmxYZmTI71P5FEeBiNx4aoz7cjFBhH5Y8UfmhVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rWLolwICHryOa41ZWqJiRFK9Ta9C36HNYPpBARpG9xoyFudGgqS5lg1Ako9dxePoIgQ6w7qY3MAe+0rKZhgJ/C5INZgZCSDMtK9bTHQR93omVxabHruMabMJQCYtYQCLr+ju78N1O2UJaO51u6yIZLwc81hGtgSi/R7jp+ivN9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DXfEqtmR; arc=fail smtp.client-ip=52.101.66.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MF1/LNbhgohWvBvLZrgYclAsYoUpfbvOg8u418eaiW/K8hJJWvuGQ1QKiqhR5+ng8ZPK5GSRip3rHwSh6dX2BPkIE9e3Z6O2S7fLw463amjYhZCvBhToinKYa83Ht2vcI4IgiAXSuQMgmudM4/GXufQDeyrWzmmpOsCqnWup9cjJgJutGBtVm8RkfPwvKT3AhqrN5//+j0bPwEdTd75VpCeBB4g7pIj2MpOSXCdB2BDoJI3w1fMdHzalJIqYeW4ov6DBC9S/nTXmQioq+YRgW4hddotxMf8OL9hl92kQ2Sa1Vmya18hc9tYXjSUjUmOpthIwk/OK5QB4TAqXVaAg/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sE7jMmxYZmTI71P5FEeBiNx4aoz7cjFBhH5Y8UfmhVQ=;
 b=ZIDFWUyPdWd3knLQvcANtD1Kttuh3mv26PzbI/1cwrbNaBAGP1XEQvAVRpbrR+YwtagI4+tuJrOzJVdC2VXSjZfh5FO1P/GTTJpg/OT10xe2ps3w61TiqPslo2G6qavK9i4UiOnaxmeqm2Tqjp1gjhrGOYSUV96OzVNWvFKopGLStOf4X7pvA4ZiU5VG8MxkfXbUmiOoHNDtXEsrv3hDfbsDy1WCdKEh+WaC4hAcfy516J+YPFKLYvt+bY+0QDoekYB9SiswxXGlRQralqtaI2ivZeFteqweouyhyMP06sOjhOVGYyUgC18LApOnzgBCHbcDtE1AEn9kCGdsZcgQ9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sE7jMmxYZmTI71P5FEeBiNx4aoz7cjFBhH5Y8UfmhVQ=;
 b=DXfEqtmReQoaWzoc83Lu5RQ81/QDRR5y7lXCpueo4YbH9mlr5TZk+A7sdr/QFzHY2BpbYZ1X6W279ll4eTra45e88LEPD9o6owf03B4IIsEYZaM4fYLr+56VFbiAmyaXocf5bHqHsJCAskI7QrOloAQ7Gp1AapHoHPXixIVzTXkRISq1PrpFSRr5C7soyMZQlPOVH+NExLowAzfO+ioHRWqRG6ILfSu4KAstqsKcxPLa0EROM0krp7XGg6D2nP8tXzEEpWv/8/GhQW598D3ozV1mxasavXLTRSz+WUWOQIRooMpbMKnIGiIdHvfPa+zU2K/xRWQstWoO/QwyKazSeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by PAXPR04MB8256.eurprd04.prod.outlook.com (2603:10a6:102:1c6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.12; Tue, 2 Sep
 2025 15:02:52 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc%4]) with mapi id 15.20.9094.015; Tue, 2 Sep 2025
 15:02:52 +0000
Date: Tue, 2 Sep 2025 18:02:49 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net] net: phy: transfer phy_config_inband() locking
 responsibility to phylink
Message-ID: <20250902150249.sihr23f6w5p37mpr@skbuf>
References: <20250902134141.2430896-1-vladimir.oltean@nxp.com>
 <aLb6puGVzR29GpPx@shell.armlinux.org.uk>
 <20250902144241.avfiqpmqy7xhlwqa@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902144241.avfiqpmqy7xhlwqa@skbuf>
X-ClientProxiedBy: BE1P281CA0213.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:88::18) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|PAXPR04MB8256:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ff3d54e-2435-4227-f82c-08ddea31ca64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ro0pCp9eGcBmDZBLHGLxfw8aPaaHRP8MPFuxwViMcLtizuLCqEuWhf+1s22a?=
 =?us-ascii?Q?Bf1lt6wbslRLgugGekU980oFMSRZ0MUGjVXWh7JwCBYVW364Upx+exVdheZd?=
 =?us-ascii?Q?sJSUBrV13HoUDhwRp2NSZX6JTyqRJf0V7d+AlpHi107VppojTiCI4RNEUoeC?=
 =?us-ascii?Q?Ibt7v1TYmY+FNmd9ba3s3oWi3i0OC6RpTrP7FjZbEebgXEAuo724qi3x2kyZ?=
 =?us-ascii?Q?06P1mhbuL2BWfcmgq6kExQlO3RvZnAbxxnZHEccTeITyS46XaBnq7J0FLxug?=
 =?us-ascii?Q?9CKnMaz7LvqNSnltzGKtw91xiBYsPGy9hUiUnMrZij2WtOqYOTjadD7w5wol?=
 =?us-ascii?Q?SDqbCTvkpNHYslda3p5GyiRpSPaUN1KPgtWubq1Ao9LJ0/Ms4ZVoaPEn9Z8C?=
 =?us-ascii?Q?7uU5jtrlAPEVEXuL1UFVAeRPvwgVxg8cGjMSE+O8zFqNend80titCk7iZmaf?=
 =?us-ascii?Q?ZV5UABGDOvvdBpGWPkydBbYQaPcF8wGNprJeXa8ZwlTQHsAyZhY929WW2j8L?=
 =?us-ascii?Q?c/ILrdogEuSExzs2QJASCN3oDlox90VPRLh6aCNMdLCnaLbQGbmG0KuSvE8Y?=
 =?us-ascii?Q?pscWUpXGA9ZdNKhTRu0Knrtr864/aCkjmH/uB7VA9jBu1c0ttCKBadgyZvhx?=
 =?us-ascii?Q?ClUsnXA5bAd7rAmfcCG607wS4dWFXYYg+fenU1VscDydlTYwTLy2mMwFlnCn?=
 =?us-ascii?Q?9COxKbP8ZfA7559N70rstqlJRWK+vUT+00brjM/Np2marXqzXg286vx3xZCP?=
 =?us-ascii?Q?Q+g3HS/+K4D2RbMkaREXchM6X7+6pvjCBQyKN/4+hLVQLbTRYzqwYpZdf6Tj?=
 =?us-ascii?Q?1GTOxf+zZl/KU9VtDMWSrfUdE9W8a3nquLhHWvrRjl42hyb6CgVMNR/NPmJc?=
 =?us-ascii?Q?8FbcLd02X/gTLju8jUdzkpy294SInlWAsE5td3XrLb2TKk23NODQJtGJZKtQ?=
 =?us-ascii?Q?5QXOgs11wBUA6aIez/kasNZkplpxCX5MysgCTLP11n1HiwGMckxGhRI+lraW?=
 =?us-ascii?Q?I+WR1sOGfmwMxR2hY47jC7VfvpHbbveMyAU6Ydr8KNnLPDty9VjGhjzsm+Py?=
 =?us-ascii?Q?cQv4E2+H4flinTk5/5PD/0zrstDN1OWrEppq4u6IVtoS8KQdS8fED9jgdGGR?=
 =?us-ascii?Q?w94C8jKgjjzHXdkx0egYkWebYwE8pxvqP8D+/OonqB/py0bj5rM9gbJ9HdQA?=
 =?us-ascii?Q?mCQoBoueit32bu5W0Qcc6GKd+OTs503SduIFfzZ+WFRETQINY15RKkwxlvF6?=
 =?us-ascii?Q?N9yFMhI+NHjIU3Pu6awbR9UUNqtb+zvxbdR+daXn7HfcfjaM4p0jfyMc4vqg?=
 =?us-ascii?Q?lgpxBiCQhke1SaocNKBpSbzGA9ZfJpb2K7tr+DeAjo5JAFjyHB5SEbaZ/TRw?=
 =?us-ascii?Q?WUYARSVLnaLVOdnVxcR4xPh2ViFl9tzFrNjLpDNje97JsAhVfS3/M5TNv7Td?=
 =?us-ascii?Q?zOROXUNYw3I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QxSRx3Y2YJ4Amr+rdA6xkvoud3VsohhAv9RI6e7sItVa1lA/XdN5H7rP1IIe?=
 =?us-ascii?Q?fw8/MmUFj4lql0Otiu5K9P9fjLs4lq/AGFh463Cyw5upR3seSgQQJWweTXlK?=
 =?us-ascii?Q?RxDJP5noLHSutHMHqtqTbdXAuHy8CWPv0Zy3lmRZOf92YdUC7hpoxR/ISq9J?=
 =?us-ascii?Q?2ipflhDuyeNJnI4lAaOOLedN+T93qccPXa0y4ErpgHpIhmtj+le+QsA1IEWX?=
 =?us-ascii?Q?RObFu+SHt021/c3y/WFfgGMVx4bJf0eMQascdHLGdMG4LYW2Bh2sOvbuoQsP?=
 =?us-ascii?Q?nA6O2bhklHa2G3E2TSQXtwl0HxJ8KCm0W+fo2coYWdhAZ/nBEkJHzHy4Ck/J?=
 =?us-ascii?Q?eZ57e8qNk6iZ72WQE3CxPhojQEW1tSi46EHGNt+mdhS6oh2IY6eRWk1eD2zL?=
 =?us-ascii?Q?m16CUoAONUDrIpGPwy3Bw6+O7oYixTwZ687f0ohu/InAZduA/8PoOsYIKf3Z?=
 =?us-ascii?Q?yN+ZAQ7zdBy0U81SA3HOrEJNSNAv82vqBA9i9DUx0O+rm2fTh436TANKWZMx?=
 =?us-ascii?Q?F8OcInqxil07qpmkDd+lbUFnIUiY3ze6nrsWZl+Nomh0aPOMm47e7lz6Lg26?=
 =?us-ascii?Q?gHS25sgHWsQed5xfSie6xIMYxRUiYuQ/dm56rBGSsznWzvoANDUNh5P74+0l?=
 =?us-ascii?Q?VTCIFJzcQefw3lWwilcqdXoK/KkWC+n+NQkVQxp4+vTZbnMjwDEFqYUPatYr?=
 =?us-ascii?Q?bVSTnS3IkxXy09gqX2quhg/DIsy58trqIUL3bQ35ITmU1cwJtJlNLbdnuV/s?=
 =?us-ascii?Q?YKlVXwWO00LKV+bp3pJbqJxZW+3t+JqSlnwOrv6+HcJEPNLngGfHxJpb9XMU?=
 =?us-ascii?Q?CTTjePKfblMxJs1q8XnwZoBxLshrWm0DMPfr69exQJn724Q2j304BkTUPhNG?=
 =?us-ascii?Q?TdVbvKhAFreXtV2+lshnblbcENQvQp90SAQqh/6v1lTgU4k0Ig1brrf1eUv0?=
 =?us-ascii?Q?PBGzTi2rhsUTshlBxeffX8tXP2bUgWxnikFMkjiEUV9Uz5IWEP3Wh2Udtz7R?=
 =?us-ascii?Q?KnwSfBYIZJLB1J8gZy6eDO8qAcgoCSiH/HC68HiL3bGTr72VnbZA1OTmFVXg?=
 =?us-ascii?Q?FAPQokoUI82pDxebs+xmo7fzxHAdNtePhUu7gR01Cnwx23ji96SXBvo46LF4?=
 =?us-ascii?Q?5j4zQVvzvu6p06fdCRVbYV/R4NLrLDhp5x77hJ3WaTgxMHaHoKhh7v9DKrgO?=
 =?us-ascii?Q?G0Tw8gVNVPr+ivqdqgo9tX78PXMFURpkgsaByy9pqdRYgaGs6R89s/JKAewe?=
 =?us-ascii?Q?TYr9LSCi80UDIKKedb0EgwJsKUFnApbkA+BO6uvDSersCvG1HkddzyOFy5cB?=
 =?us-ascii?Q?rJWPNz/u20ZEhxLOANtIxQshm4Q6z6LV4Fp1ZRYOIUgV4nfHu7GSzlV6CaWf?=
 =?us-ascii?Q?pKf5L78SVg6hYo6/8/p9DAfVp8ZwYnUfmODo3/FodgsKdjZO+HBzSSdBCyH/?=
 =?us-ascii?Q?OLw5YflIZ2Wen6BydKtdd2EuyayvKvwx+D/PPYBZ4EGCuZEd9boe76+Ebfd6?=
 =?us-ascii?Q?8WHbegY1mGxqXxtXX9yrINDHhtpUVVpZ/Jc/sPRRUOhWtlwLxeD5dO5ndJgo?=
 =?us-ascii?Q?lwJngwpmDxcGnx59nwJEBs1jbQUr2ic/ycw+dK8VwiknXNdSzJLKup+q5i6l?=
 =?us-ascii?Q?x2a6WdxzYxwHcVsGJM6xGC/P25K5Sfha/fTEjFHcSgWNWvkgZGbteOUQ3Zui?=
 =?us-ascii?Q?sRa7YQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ff3d54e-2435-4227-f82c-08ddea31ca64
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 15:02:52.7920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ps42Pyx8Coc7ehpDyr29Bb7SnVtRC5zPi2kB3OmWujPkP3yDJVSlZ7rK046uGbgicEpAVGh7b9oJNymWpYU/Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8256

On Tue, Sep 02, 2025 at 05:42:41PM +0300, Vladimir Oltean wrote:
> Can we disable the resolver from phylink_sfp_disconnect_phy(), to offer
> a similar guarantee that phylink_disconnect_phy() never runs with a
> concurrent resolver?

Hmm, I now noticed phylink_sfp_link_down() which does disable the
resolver already. I need to test/understand whether the SFP state
machine ever calls sfp_remove_phy() without a prior sfp_link_down(), if
the link was up.

