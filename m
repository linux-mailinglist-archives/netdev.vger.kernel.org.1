Return-Path: <netdev+bounces-225244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B630B9073C
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 13:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20728189ED7F
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 11:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B0C304BC5;
	Mon, 22 Sep 2025 11:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="euXm1ZmW"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013047.outbound.protection.outlook.com [40.107.159.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D294D262A6;
	Mon, 22 Sep 2025 11:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758541289; cv=fail; b=RSgw2qVLtNl5OxxRbvKkW8oFFoCkaitAKGkvJLUNY4iAL360DIfMsRW3l7k7MOqC0Ag5oIApX2ptq6jGNGtQEXxzYfpjEa6JsuQOsTZTt2xb4d6NM4I6gG4TPH4rgRx6ohXV4qZ/afR/hdMFPjhs4WnA4Pl4MHfq5yndg3+2zTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758541289; c=relaxed/simple;
	bh=sD2E5K+7MtPoiHJodEyLj80zYChh9XlIIpXtuC1UEE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qc/dSdLJH5PjPAv3X+jrmWsBSKT++oAe95p1jEUuyGCRpmDtAVRa0+Jt8meSa9rrTzqe68P0/PKnA/q/a2m7eWtH/6DTqxF8IRNeElhU58GziH8856X7FgqzQL4GsGRl1a/BjcH/4lIZHQjy/HuxRDhIWl4XuwKGsjC9UCyEddY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=euXm1ZmW; arc=fail smtp.client-ip=40.107.159.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ngwGSd8kRb37vMwkVAYFhtjm8iYg7eusorVeZqxqt/B5wBq/jPzwIrzY9mx++SHIZ1845mUWUVJZgOkIgorVFMK+K9X9mF3if8sbui9wQSUY1dI490CFjs3fb6U2LUkc4Ta0bl8/Ti/IUCdGPKBDEk3HmPWJpVRQOBKxCEfjoc9vgUX0W4CaiQB+Kk7SZ4sfPvm+dnXfyaXcORtliEkhn015OwKbNVu0foA8czoq0mprF1aogr9AQzL3IBqaL/c7aLN6kl8uCkbejcOQwV3yo6e5iDJUeFPvQpPdYMMvBhDSjLkgOpirklxBZcdeTNKl2R4maSh5hyTh6IBI+D23Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6RPzWM77W/cCSvkWojL9kEwVMdUiG+q0lAe9GXVzm0=;
 b=MuDtU/KiQuFsku5lK8EwIQtWYmPl+TdkML0dP34G3BKdGhUjVlBw27/4U6ow9ESw55x9ypvdBeojfIs0HPBUe/EZWNY+08KWBwga//t8YJXMXKlP8EhSl1HsBH7+gqnMV2O7nNyPij2AM23js9Xz1KZIVTcNhdbYz7SeE7i6p0lF8E2LudiFnZdFDybGjRP4uAHT/Un54jZtroebIix2pJdq0JnH8ww2V5KBlqUvoeDxwP/m185lza57hmk9lyels4L7dLxSSQxIo871Xh6+hLRy42Pnljo2xBO7XmmDvhruNiZdKfPFO1ZU+o9HVTD1AgaxDgf0oYsdZPg2ZgMrrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6RPzWM77W/cCSvkWojL9kEwVMdUiG+q0lAe9GXVzm0=;
 b=euXm1ZmWYlmAh1m0bFCdFkLb0m7q9BAHdvIUeRm8OpAoRjUse1oopn+ciD0jrjQUKpxomzYiCUS26eo9hw61PggmqO7pIrQBDM2K2QGtF7f6U6EVaIjXqdeC3WW77LGDAQ/7i2sKwbcdgh1/OMXTCx+LGNr0rDsXjkiyznKbrtGVtjwdVeE7ttZquoTuWdP0cqJCjuyRi2IxBn1f/eK02jdhEo9czIkA7273Q6R0YCh0gtsSSFRVRRqww6I2zpZAORDRlrW6H0Cx93FV/xuHQkd6z9ZtaSBQdAHbZivJUQgGALhvf0Jw25lJirb14HuiekR1UjJ2r4obI8LtKdaxeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DU7PR04MB11210.eurprd04.prod.outlook.com (2603:10a6:10:5b3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Mon, 22 Sep
 2025 11:41:24 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9160.008; Mon, 22 Sep 2025
 11:41:24 +0000
Date: Mon, 22 Sep 2025 14:41:20 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, xiaoning.wang@nxp.com, yangbo.lu@nxp.com,
	richardcochran@gmail.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, Frank.Li@nxp.com, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next 0/2] net: enetc: improve the interface for
 obtaining phc_index
Message-ID: <20250922114120.bogu5vovrafeytow@skbuf>
References: <20250919084509.1846513-1-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919084509.1846513-1-wei.fang@nxp.com>
X-ClientProxiedBy: BE1P281CA0228.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8c::7) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DU7PR04MB11210:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e03bf09-2596-4d87-b804-08ddf9ccf535
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0g3PGeukngwlifzVX6M/rU06u1cncp3jVrBWi+iyAx9VkgoJ39+wFTCPXPiS?=
 =?us-ascii?Q?S7bcgePteOAFpeVlS5rwvH8JZFV2NL3AbWC0a+09OamToZT7Ks+AcIw3rVxU?=
 =?us-ascii?Q?xHu3EQlS8OaozDH0raKOVJQoZF/ROe15RsOdz6Asp1qrL1r0+NRVrEXMElIn?=
 =?us-ascii?Q?pFHJoXBhSXxSiW+ZE6zWaGxHrXCdX9w5BW5HebJLqg2pXcgBffEUpr+eb6eo?=
 =?us-ascii?Q?8zeadA5ATYpAQwa0cTM7pc7JYTGy/LY9jtGWGG/TSPztGgWnIMhjc7TR7+ak?=
 =?us-ascii?Q?9J2bFDD/3d4x/xxnvKFXVsxVHsF27Qe6QZIcVZMYfDGXTFI84X2/6VY0HNhj?=
 =?us-ascii?Q?YzP/ro5oHhxPo3OVf3lOSUincDsYs0uzQ0FrUI0EmFOEY0Yf34EIu7L1FiYZ?=
 =?us-ascii?Q?YDfXqjNwVd7mq89i0ivU0O9XxVm6+I0CPr2urAoOO4h8cz+JIm964fpfp8LT?=
 =?us-ascii?Q?GE/yVQub7/NEMLq520kdFE+vVVLzE0Xw0UPWVoh2bPUqHG1EYHcCN2Hg6bOl?=
 =?us-ascii?Q?/XtewA5/sXf07ATr4H948FEWoelmadmYg7cNFNQ+EG/2FK6WcyMtVDQNX5Ed?=
 =?us-ascii?Q?XnqGS2yQQv62IXwOEw25JzagSguajuL54pHn5xMcJX0Dh06L98exaAMkHcRm?=
 =?us-ascii?Q?PwE0FlTA0zdoyoIx1b9NECC2ED08GQPbKaTJV7HsoCCHhIjk74faqB1TQUOH?=
 =?us-ascii?Q?i/evbRjXM/qRt/Tx4geT5JdnjWPgHW7BTiyJtc9piERHJWndj0dzJ6HLAt0q?=
 =?us-ascii?Q?Fsh2u8My0xPVPW0XSUVILGdFLWZcqVb+Viay1ca4X095cr+Nnx5znx2pVe+D?=
 =?us-ascii?Q?88V/UzU7I65sTFwEho28EV9G8yTjaAp6X06LETyDEl6Abky9KmtHbWeTpPZw?=
 =?us-ascii?Q?q2/GmO4NMTJ9bF/F/TBYbTEMxbHoIYDTjGRT22HTkWYaxw9F0Gohw6QXyXat?=
 =?us-ascii?Q?cZD27+k80W50RZS6H9+4iv9W7tb7+IlLtvi4c0lU5I1KXDgyYR5XERY8x/g3?=
 =?us-ascii?Q?2PFDsK3t64Pg7mYCRc6PxWpIsw5yIHJ24Je73g8CZrtLdQHETzIDX8yom47V?=
 =?us-ascii?Q?JtEeR24heDlCSdE0QorZKhn5vJwf0bPn1rQpyWEdOOShhUbEF7NTnH2mRwhe?=
 =?us-ascii?Q?NGcEK1BYuBGDBrYCrK7AwtAUd8Zh3Lg7rYDstcPbraXX6VmhzdElZMcteK5e?=
 =?us-ascii?Q?koiDQJ8EAEfo2f/Mmvve9Q6JqOJ+nGW/0vmxWg0rrXbLX71uZirttokKJI5+?=
 =?us-ascii?Q?AkLKx7pjXxKOfGx0DmzRRkGcWruehvZcAWE70VAEisY9A3Px/xPAtV7FlFPB?=
 =?us-ascii?Q?565cHoLPYZUO2B6tmCsZCh2PYEG+uuVhSckLu7IMVuo9b44Bg0SCPZiaQM/5?=
 =?us-ascii?Q?tn2PL3I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L5ZLjTOJvk6ooGPgHO8T2tzGbON6BlW6LX4r+14K2g7Tc9srHaacUy9PA20J?=
 =?us-ascii?Q?cTtDESBd2dclYujhC53sBaoU05KexZw/EPSqcetnwoU23P5vDicj+5hAhDN8?=
 =?us-ascii?Q?ol26WPFFTnmm4TTSY0Fl4cYEeTe3keQ/ehQzNX0QYGUnjVrEok+aUh28yYYz?=
 =?us-ascii?Q?3mqRe9QcgPYo6AURiSO+slwdUHHNMFFBqrK1xQ08cEwm1tTRZ6QOmJa7W/45?=
 =?us-ascii?Q?ftKPchp1Yy9F+LSheMQtIsv1mgarlBLr2kGYkV1HM7figT4b8PxVufxq7H5/?=
 =?us-ascii?Q?MWKHdXfIg4u8npV6vcUTiDTEvMwnQNmpUOrxsDFlcarcWHAI/HSjQvAsfuhD?=
 =?us-ascii?Q?2m6yFh4TtnErEs41sdN310oPBcy3qaTW2fQbYNP8T6JYvelXl73yaqW8Bpsk?=
 =?us-ascii?Q?grkVo3HtGMIVPoQ5Tc6UVc3djLBtShtL+7Lg3F5B2eSNegQmiOKEHCdVSCYC?=
 =?us-ascii?Q?DycxJYO4eYlB5Ee/HATPjYwZhGAbj5bcd2c80R6fLt+1nzETIIZj5vwCy4yr?=
 =?us-ascii?Q?cQ8aeOmt/dvxvvXa+9JLOZVwkWfYMHReT2Dl7RkWDBbknfjs0zksUwHcZU1H?=
 =?us-ascii?Q?uDh0YKJYUNWXuUqe8QRtq0j7/qMD9YjnajwAoCaewUNHN2BnITZJek5wyi/8?=
 =?us-ascii?Q?smZN6V3/nqPWOuJWPcvlTSvIfwSXFjUtGNQBKXPGj/FeaHw2eN7GrsFDS0z0?=
 =?us-ascii?Q?9ydzUT5fQ4yN+TABGKJT6fN/AuBAhH1day3j52lkP0C+nvE0+FPbF5xZOzMl?=
 =?us-ascii?Q?EydjofQwt2MhiugK0XtLe1DSABHGpdEeIjhSGaGYGpzFPhAo2RzKDx1w5IVT?=
 =?us-ascii?Q?CFBSQrsRzeWApb4E/L1dp68fudvPlwvgdLLR9zK4tZgAyIdJEbCXSDLBz6tM?=
 =?us-ascii?Q?Mbf3G2SjIo5Fg1zzvnl5Hirn49avVVsMyeQ1omUbMtIxObdZePnDfl6J9mr+?=
 =?us-ascii?Q?2z9/LpOrVQY/k7Yvklml9zL0TnLjxbj8E2AjN19Igpe7DonI6CLHT7ZDiMUA?=
 =?us-ascii?Q?BOimJN+agqUopywWS9/Eba+sueMQGbkG+41bPVdsGdCcA+Kik0OBXYoTSjlz?=
 =?us-ascii?Q?1L2tgb/BibyGqutsC9BmPe6KoQ0U7Om8gJSp8Qi6dWQWtgXbeD29pBeUNJbE?=
 =?us-ascii?Q?UQmk8HHUDpwbApeG4jvmSVco/1jdELGevSGJaHgHf/3jLeD1opRGjopUIjmI?=
 =?us-ascii?Q?Hw80YmYtkQXB2awH+OXdBf0JAWFO0Q0l5J1+GCT8mLUNCprdU/PDpdt1iFGR?=
 =?us-ascii?Q?vFGSg2ShpPfgGXfnvnGLou6kfhSKKA46Bzm5YW/MQkiAzBgyMqGE1KViaNxh?=
 =?us-ascii?Q?sE4qS1fw3rgONf6VmNqEmBsOaRRAKE8Y+So2VOin6tBmIiLSGZtX1wddi8mw?=
 =?us-ascii?Q?UiHb1EzXqTywrgtUpN0B5rlUzJnkv6ypBD3tuBmyMIhR8gmuk7ANdwgLISNd?=
 =?us-ascii?Q?aChWjb05EEPjDynrD7ukVS8hCE4VJIt2ETs8KmfIHykRH7uT9Z2f6sACahei?=
 =?us-ascii?Q?80kPS3H2iMbSHP2l7S93MOwS75/StTfS9xzqgujrvQF0PLmyIsG0LBiHz+uo?=
 =?us-ascii?Q?PS0tNrnif9VR9Q5rQfGvhl/ZjsTvmfFBW+oq+TIUNkdxD7ru6scFEm+QddBI?=
 =?us-ascii?Q?VX8lqm/4AycXUrZKdTBLdseeLTv0ZT34lkViq45DsjmxUotizVHkrPKkcvVg?=
 =?us-ascii?Q?uDodqQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e03bf09-2596-4d87-b804-08ddf9ccf535
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 11:41:24.3656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xGb3uAMQphLJHHkssN4OQuIOIORLAx+PfUpAoiQnakz1JBZT1onQwvg2AsnRYdHB2AuMfHGZlBqs+rP0ulNW2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PR04MB11210

On Fri, Sep 19, 2025 at 04:45:07PM +0800, Wei Fang wrote:
> The first patch is to fix the issue that a sleeping function is called
> in the context of rcu_read_lock(). The second patch is to use the generic
> API instead of the custom API to get phc_index. In addition, the second
> patch depends on the first patch to work.
> 
> Note, the first patch is a fix, but the issue does not exist in the net
> tree, so the target tree is net-next.
> 
> ---
> v2 changes:
> 1. Add patch 1 to fix the issue that sleeping function called from
>    invalid context
> 2. Fix the build warning of patch 2.
> v1 link: https://lore.kernel.org/netdev/20250918074454.1742328-1-wei.fang@nxp.com/
> ---
> 
> Wei Fang (2):
>   net: enetc: fix sleeping function called from rcu_read_lock() context
>   net: enetc: use generic interfaces to get phc_index for ENETC v1
> 
>  drivers/net/ethernet/freescale/enetc/enetc.h  |  3 --
>  .../ethernet/freescale/enetc/enetc_ethtool.c  | 29 ++++++++-----------
>  .../net/ethernet/freescale/enetc/enetc_ptp.c  |  5 ----
>  3 files changed, 12 insertions(+), 25 deletions(-)
> 
> -- 
> 2.34.1
>

For the set:

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com>

