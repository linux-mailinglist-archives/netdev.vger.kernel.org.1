Return-Path: <netdev+bounces-214996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD1DB2C884
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 17:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEF907A5FFB
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 15:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2198523956A;
	Tue, 19 Aug 2025 15:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ERZoZJsc"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013017.outbound.protection.outlook.com [52.101.72.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B671C2367B0;
	Tue, 19 Aug 2025 15:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755617486; cv=fail; b=N+cuTurL2T5OsqpdpS8Hcsp0pfZKuEJ0qGmNlMJIYq+R39C8pOrVm951Zj1xfarf9mBc+u2soaPEZLmBeTo0nsnPZjceCg34G5ZsDBSne7Oh8Gv6Qxni7I4BJ2SfVhJgExxn8Goi4hwd2HS7PnQjz0hj26GR2OTqyAxFa8wvbS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755617486; c=relaxed/simple;
	bh=/d0yRMiVPAC8hCoWn/y2xTOZc4/QuEg+G7oe5uuVxh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZZZm7XHzujGwNqE4SGALqHuktgGx0vDP1z0/9JY6joAEnP+EXoDLsSTUAAiDPEZDio/A9bQ8xBjsJxYkhFQlQxhzK3glnf5TJhanycatiZfQ78eRvvubtmVqgbJvoWyFVvfldOp0sK434hb9GewUkDo3/+3CE0bG+O8Terhq42A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ERZoZJsc; arc=fail smtp.client-ip=52.101.72.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=caK0RnAzPffG7g0MSIL9UfBjJjX2HmxNjsYJO766Xwvbhs8tTds32Vj5/xCHZxAO8HFoQk8stCvdhlBrE597RlPFME3LR7lHt5LHtDKAneQdV178A9IVmvZyF7ppPkMoRPxeyo3TZ8snxOFXl2asHanOXBvG+z/2jeXfZywIMRxC66mTAfhmUTLYvoEOr99QuCqO45KyUEnr3p0bJAP84542KZNFG/ppjYC4ibagM/VnfmLY4esjHpmpAlvtL4h6vdmudNJ16CjrMW4+0rEWbgjKf5dcM2VpuZnp0ajcRHP8e8RslKqWqvvVjLDsWNQtKVWIj0RqJcCdVO/Tsu9PIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jk/N12QaPFc6Mtq+gsL/YOz1KTgTgGHKG6YzoafHV44=;
 b=l/bFgNj5q1c5JABg02BTdLWT/9l7sjSvftN7yKJGmGJo6K+QEw4umyA53B11ehWgbq9FcoIfgDD8di7rj0mNALdShYJO2Nb5XiNayYurYjkVpxtFmeu0EbLSl+xH9IF3LHJvfEzq4+SJZ77D/zym8wVYhEXlx4QrvkcSceFtm5g/es/g1m3cYf8PcpGgR6zKMVilANxYyxoHjKl36hVnHWl1yyCQYm3n2e/0fThWNKJynmBPMDLr5CnecWJHTswRvUmwSHx61BkBamEflO4k3rS20v2Z+sCmE3FcPwrQq5SMynMUwYY6UxLNA9g+IIjDEqWoIkZhXVVonlOR1rJihw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jk/N12QaPFc6Mtq+gsL/YOz1KTgTgGHKG6YzoafHV44=;
 b=ERZoZJscTomQapkzlUOQS/SzEFkYZwb+NP5LODJuZMKGg2LKHi2lQHvSB610+POAt5dd7+yIFRE2nzmBepHAVEtPeyjYC6mGLwtOZlUAFQDFPgbQT7KO5GZSq6ye3X+xGqaqltCzXTBbWUGh0hGR+Zjs/MpfSQ7eToly+ambZ7SiuVrVszbUOrHhuuiX8W44e7TzayYQOThp+xR4C9BsHff1+iXqQD6U6rb+05YYXWkBoQtSarqIGh5YYuInVVGXcY/IXi57lgjoGtx0ExF4ZlmRSj1dHDed+mqIkJIGlH3sLF44mYTO7ofM1nRIWPVcWq95YITjjC3xl8snXMuUmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by MRWPR04MB11492.eurprd04.prod.outlook.com (2603:10a6:501:75::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Tue, 19 Aug
 2025 15:31:14 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.011; Tue, 19 Aug 2025
 15:31:14 +0000
Date: Tue, 19 Aug 2025 11:31:05 -0400
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
Subject: Re: [PATCH v4 net-next 11/15] net: enetc: extract
 enetc_update_ptp_sync_msg() to handle PTP Sync packets
Message-ID: <aKSYuS1WeyjeCLXb@lizhi-Precision-Tower-5810>
References: <20250819123620.916637-1-wei.fang@nxp.com>
 <20250819123620.916637-12-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819123620.916637-12-wei.fang@nxp.com>
X-ClientProxiedBy: PH7P221CA0077.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:328::12) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|MRWPR04MB11492:EE_
X-MS-Office365-Filtering-Correlation-Id: c3821e36-b3e6-4d99-423f-08dddf356eac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bZorbwyuMaP1ujDUNO5bqxJTgTSOHEBLyP+pjyKetYcmWYPdd+aiRoFcX8BP?=
 =?us-ascii?Q?YMnQ5rbTXWTac4OiUBZtDjqMHANsgFiQJLCXv9YwGmIX2Qrg39t693cPek82?=
 =?us-ascii?Q?Kwzd/wSfmXipcsRoP5Ag50PSIQNJ8/8xp3BXg9xGH5v6Z4CJ0WIOzRqaxiXb?=
 =?us-ascii?Q?4HpOeauy8Np0bZOPAsClZPdlvheiflxSIc67pSWlkeieUgA9lo0ndkuPSs3P?=
 =?us-ascii?Q?JBAcM3x/h7UR6IRbdUpSz3n8/N6tWUpmYZHK9lmeW86v+rex5dexDPyR2pbR?=
 =?us-ascii?Q?Sz7ufCufggze/VxEto6vBqH7CfJ06lcWE/ilQ6DEfPL82hxj4twSKcsTIB3l?=
 =?us-ascii?Q?2gVg/37EelAt41qJcNA+mr6jROAZkIZTRZ2ryyBn1F1DfM9yVLz+CHegG4O1?=
 =?us-ascii?Q?N2gUETrCCuq+lqCvukgfixZ350kIyfxEkjucWK0bXVRA9i6q/TdbGcpTFAF+?=
 =?us-ascii?Q?sOGlThxCnjF/2J4CGfz6iFo63oKsnNTPhHlLmeonMsZPIaV2GVASQUC81a5b?=
 =?us-ascii?Q?7cJMqh7Y4otJHMUBpbEnH9nPWMn42XVc8B0dYQ6yV6aedvZcXMvIOxjvfJwG?=
 =?us-ascii?Q?tSJPkYTpDJtKKvtCm3lwjlZzL47pFAQ5UgPb+p1NlYlylYnLsLUJkFqBpoeA?=
 =?us-ascii?Q?1DXX/i22ei9H0ZNVE3cIekDajPceKXcZyHIOAmDCLaXqlfchMRs8p34cBIl5?=
 =?us-ascii?Q?GvV/4uwTNphQ0v9644LLlNgZLg/QT/5712N3tLWVD/qcRNxdw4LC+H5/rDlB?=
 =?us-ascii?Q?SknMTmmNGOvO29XfmrmuQUt61Ot2tm3Zl3lz2ScGv/7+qUsDSErIy2II8UzX?=
 =?us-ascii?Q?ENlClatPTTUPlVn3y7OOmXtzLwj1w+gFN7HwD4VoyJTHQHSZfodi9jx6Mgkc?=
 =?us-ascii?Q?DGW2X1WrFuUyUG+vlCsbqQ02RBKgUNJjx0WmyiAHNcNEqv2bBNyL9mGuSE2m?=
 =?us-ascii?Q?1e1/pgr3xyeQKWu0/K1aHqZK7Vm09jXqxfOAHUllRA4xQLv1yYwTi1HNZcx1?=
 =?us-ascii?Q?/BTGmw+H+hJJy+7pp9rj0QlGpq0RawmYw9ycbs/z1cYYJfr8F6SQbJb2TDeS?=
 =?us-ascii?Q?oeuDAGy4empyjHfRaMPpF073//zrJ97uoqM8yteEb+noytVgpUq+y1FMSBiC?=
 =?us-ascii?Q?sQa0LOmw3huwFVgKhyH6wGGuAZnio5odVp5pJ2Nru+scE4jbFCV7iB97JSs2?=
 =?us-ascii?Q?zudTqdoxXTqQKpsAansx0J2Zs0zELrDG3VBNrugzzhHL+Y7dhduzdSgfHSxa?=
 =?us-ascii?Q?kdaE4pMlF1/Cst8Bq4z+y1j4ZJewuamvb1gvPXpBNHJBMgrOjSlMkYddTHCm?=
 =?us-ascii?Q?TiVkvtUg0T4GWFPhyJiCK9RTkFDAes5eQj8cVaFteJsR09vNbOpkELwpmAc8?=
 =?us-ascii?Q?fORAAMCSJeBMSbhYjNGOc+0aPzuBs51VwU1bkyorPtbcbTVpHX5+Nl7qEicS?=
 =?us-ascii?Q?Atr7sof/wdv+uMisdcGsR0Wvvbg8d2Uct+MbVvcjAUxgd2Yz73e+Ag=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MAbvvOmjBL248b1lRHE61HCUe8wIVtlliWubZTvC9ORUaBySxjnHypN99ikv?=
 =?us-ascii?Q?bR8pOjmckqb683My30fODhQ0MJpvBpQu63vnGuIKAZwwNORQ2FlrF9acANYR?=
 =?us-ascii?Q?CkSz7SKvFyKXzu6tOD3QOGIwFf5Ef/WLPLoIv+osgIQCPCwcqbjd3m2GOH84?=
 =?us-ascii?Q?HgMYltbwSav0N6FjvnQMyIpviWYE20JuPdP6P0qsjB/0Lc26YsXSB7h7u1Z+?=
 =?us-ascii?Q?QzSh/68vGV74tGSRc8zZzFeAYSp0CrsBfFOWjeCr1RVSfAJ8zs0rxvY+m1QF?=
 =?us-ascii?Q?gjBzfu0OHe6nChSB6Nms9GIigmc6vVNd0HAK//zG6p0yU/s1OJTVERS6HPdO?=
 =?us-ascii?Q?w6fQ35E0foXf7t6itJFUOnT+6J/gpgJMt+uddgDcD6y1/QjqsSIbo8Lkzl6+?=
 =?us-ascii?Q?Gw0ca+8hrlPhqA/LCl9GwiqUupn/Il+pfIFovocQBKGoOjvlxox33bLva2Yb?=
 =?us-ascii?Q?hpFTYhfopNuGV7ILm0aKOnVerT07aQya7G9rtmokXj8Kjfp6iMZVe+cwXOfL?=
 =?us-ascii?Q?Sl7o6VQ6zlGMOqhjyREF/WGRWFEYTTZJj1rYpdIEUsY78K1h5+mQDM6an8MO?=
 =?us-ascii?Q?YKcqd7+4wu0oxYQ6EFFbZyEGM4W2egyKriypNAcWT2eF1iXB/Dzaz2YLyBSA?=
 =?us-ascii?Q?zsSQvKNcZBIOg0/hR/AtaPKBL7nXoIdeyt08GY8CbFMDqfDH6K+e5hsa4xS0?=
 =?us-ascii?Q?UngEUfZxKQrzJr57mEvUAWwAFVr3ZpnNcidDmuwmVzAKMpoLmbJLW0ne5pjg?=
 =?us-ascii?Q?UnFqWOKC2TbW+niaXBnGTKMqxrfJbVvukCUVyOfTI6YBpKkwnss1+3Xfxiqo?=
 =?us-ascii?Q?vuphtS2NRioErvZ0zapZSfXTJdryAtg3AqtJqm28NoNHIF+DUwmVWpCklEal?=
 =?us-ascii?Q?IOFXTyBd7rYTWUfOR/OwsvSulnywSB3S4h2Ur6su0uQLQs82uqtdd6nvU/FK?=
 =?us-ascii?Q?wTmBao9uzpeZdVDOssCniEQJbRWrkw5iVr7aCCSSWaE8Y/g9RPnTMJZZI6KJ?=
 =?us-ascii?Q?WvnETnIRhCgQtxSZ2R1lKaGIXEqt46yxAFvwmeyjGRWjlJcgmR1LbPdL5Mfb?=
 =?us-ascii?Q?weSa8L3cMUwVo7mNZx+x5qW44VfvsG7YoWdmudP1QwQGEGwRgunp5RKouUdh?=
 =?us-ascii?Q?O65oM2XM0R503XjnbRt8FgykXuKV2CQ4I161PoiW5RuDFKUZQq2W9Fi8CRpZ?=
 =?us-ascii?Q?9Kg6DDAFQU4J0xbjCr0xIfUdFv6OSVnBQ7nf81DRC+yTu8Zpia0iBi7yKNIa?=
 =?us-ascii?Q?T5iTcEJ6iNMCovv+GdKDhMx4/zuz5LgptItzsuMYshVzOC0m7MO39iE2lEjB?=
 =?us-ascii?Q?CSjmtVdto5atXBYHUMqgGqrYqpXNHixcgMxvRXPwdSDiSPbam/5dBzdfIx7f?=
 =?us-ascii?Q?ia1OXYo7VIX8XF0Rdr3svexha3GFgzDAs2oRTjjN/ptkh56AdDwpamgGM+A9?=
 =?us-ascii?Q?7KPLeAwfdlVebLxlqbrUlKJ309Q1Dcm0TSEggYplrfFY1N1t8p70uOJ78vqg?=
 =?us-ascii?Q?h02BJGbL13ws+mvKjQH0pgiIl8g+t4Hu2ubHMo0v4bDpNju2yojKd/3CugCZ?=
 =?us-ascii?Q?qdZYswMObjOuFi4IWOB2QBo1RS2UVsc89Hg6f3jI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3821e36-b3e6-4d99-423f-08dddf356eac
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 15:31:14.1393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tg+pqwNBeDMFReKTVT3fsBlcawiby22UdZSPlSu5ymMPKYYRfl9QPbei4WbQgAa5WHEKVZK/10K9QvYNFYdHHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB11492

On Tue, Aug 19, 2025 at 08:36:16PM +0800, Wei Fang wrote:
> Move PTP Sync packet processing from enetc_map_tx_buffs() to a new helper
> function enetc_update_ptp_sync_msg() to simplify the original function.
> Prepare for upcoming ENETC v4 one-step support. There is no functional
> change. It is worth mentioning that ENETC_TXBD_TSTAMP is added to replace
> 0x3fffffff.
>
> Prepare for upcoming ENETC v4 one-step support.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> ---
> v2: no changes
> v3: Change the subject and improve the commit message
> v4: Add ENETC_TXBD_TSTAMP to the commit message
> ---
>  drivers/net/ethernet/freescale/enetc/enetc.c  | 129 ++++++++++--------
>  .../net/ethernet/freescale/enetc/enetc_hw.h   |   1 +
>  2 files changed, 71 insertions(+), 59 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index 54ccd7c57961..ef002ed2fdb9 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -221,12 +221,79 @@ static void enetc_unwind_tx_frame(struct enetc_bdr *tx_ring, int count, int i)
>  	}
>  }
>
> +static u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
> +				     struct sk_buff *skb)
> +{
> +	struct enetc_skb_cb *enetc_cb = ENETC_SKB_CB(skb);
> +	u16 tstamp_off = enetc_cb->origin_tstamp_off;
> +	u16 corr_off = enetc_cb->correction_off;
> +	struct enetc_si *si = priv->si;
> +	struct enetc_hw *hw = &si->hw;
> +	__be32 new_sec_l, new_nsec;
> +	__be16 new_sec_h;
> +	u32 lo, hi, nsec;
> +	u8 *data;
> +	u64 sec;
> +	u32 val;
> +
> +	lo = enetc_rd_hot(hw, ENETC_SICTR0);
> +	hi = enetc_rd_hot(hw, ENETC_SICTR1);
> +	sec = (u64)hi << 32 | lo;
> +	nsec = do_div(sec, 1000000000);
> +
> +	/* Update originTimestamp field of Sync packet
> +	 * - 48 bits seconds field
> +	 * - 32 bits nanseconds field
> +	 *
> +	 * In addition, the UDP checksum needs to be updated
> +	 * by software after updating originTimestamp field,
> +	 * otherwise the hardware will calculate the wrong
> +	 * checksum when updating the correction field and
> +	 * update it to the packet.
> +	 */
> +
> +	data = skb_mac_header(skb);
> +	new_sec_h = htons((sec >> 32) & 0xffff);
> +	new_sec_l = htonl(sec & 0xffffffff);
> +	new_nsec = htonl(nsec);
> +	if (enetc_cb->udp) {
> +		struct udphdr *uh = udp_hdr(skb);
> +		__be32 old_sec_l, old_nsec;
> +		__be16 old_sec_h;
> +
> +		old_sec_h = *(__be16 *)(data + tstamp_off);
> +		inet_proto_csum_replace2(&uh->check, skb, old_sec_h,
> +					 new_sec_h, false);
> +
> +		old_sec_l = *(__be32 *)(data + tstamp_off + 2);
> +		inet_proto_csum_replace4(&uh->check, skb, old_sec_l,
> +					 new_sec_l, false);
> +
> +		old_nsec = *(__be32 *)(data + tstamp_off + 6);
> +		inet_proto_csum_replace4(&uh->check, skb, old_nsec,
> +					 new_nsec, false);
> +	}
> +
> +	*(__be16 *)(data + tstamp_off) = new_sec_h;
> +	*(__be32 *)(data + tstamp_off + 2) = new_sec_l;
> +	*(__be32 *)(data + tstamp_off + 6) = new_nsec;
> +
> +	/* Configure single-step register */
> +	val = ENETC_PM0_SINGLE_STEP_EN;
> +	val |= ENETC_SET_SINGLE_STEP_OFFSET(corr_off);
> +	if (enetc_cb->udp)
> +		val |= ENETC_PM0_SINGLE_STEP_CH;
> +
> +	enetc_port_mac_wr(priv->si, ENETC_PM0_SINGLE_STEP, val);
> +
> +	return lo & ENETC_TXBD_TSTAMP;
> +}
> +
>  static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
>  {
>  	bool do_vlan, do_onestep_tstamp = false, do_twostep_tstamp = false;
>  	struct enetc_ndev_priv *priv = netdev_priv(tx_ring->ndev);
>  	struct enetc_skb_cb *enetc_cb = ENETC_SKB_CB(skb);
> -	struct enetc_hw *hw = &priv->si->hw;
>  	struct enetc_tx_swbd *tx_swbd;
>  	int len = skb_headlen(skb);
>  	union enetc_tx_bd temp_bd;
> @@ -326,67 +393,11 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
>  		}
>
>  		if (do_onestep_tstamp) {
> -			u16 tstamp_off = enetc_cb->origin_tstamp_off;
> -			u16 corr_off = enetc_cb->correction_off;
> -			__be32 new_sec_l, new_nsec;
> -			u32 lo, hi, nsec, val;
> -			__be16 new_sec_h;
> -			u8 *data;
> -			u64 sec;
> -
> -			lo = enetc_rd_hot(hw, ENETC_SICTR0);
> -			hi = enetc_rd_hot(hw, ENETC_SICTR1);
> -			sec = (u64)hi << 32 | lo;
> -			nsec = do_div(sec, 1000000000);
> +			u32 tstamp = enetc_update_ptp_sync_msg(priv, skb);
>
>  			/* Configure extension BD */
> -			temp_bd.ext.tstamp = cpu_to_le32(lo & 0x3fffffff);
> +			temp_bd.ext.tstamp = cpu_to_le32(tstamp);
>  			e_flags |= ENETC_TXBD_E_FLAGS_ONE_STEP_PTP;
> -
> -			/* Update originTimestamp field of Sync packet
> -			 * - 48 bits seconds field
> -			 * - 32 bits nanseconds field
> -			 *
> -			 * In addition, the UDP checksum needs to be updated
> -			 * by software after updating originTimestamp field,
> -			 * otherwise the hardware will calculate the wrong
> -			 * checksum when updating the correction field and
> -			 * update it to the packet.
> -			 */
> -			data = skb_mac_header(skb);
> -			new_sec_h = htons((sec >> 32) & 0xffff);
> -			new_sec_l = htonl(sec & 0xffffffff);
> -			new_nsec = htonl(nsec);
> -			if (enetc_cb->udp) {
> -				struct udphdr *uh = udp_hdr(skb);
> -				__be32 old_sec_l, old_nsec;
> -				__be16 old_sec_h;
> -
> -				old_sec_h = *(__be16 *)(data + tstamp_off);
> -				inet_proto_csum_replace2(&uh->check, skb, old_sec_h,
> -							 new_sec_h, false);
> -
> -				old_sec_l = *(__be32 *)(data + tstamp_off + 2);
> -				inet_proto_csum_replace4(&uh->check, skb, old_sec_l,
> -							 new_sec_l, false);
> -
> -				old_nsec = *(__be32 *)(data + tstamp_off + 6);
> -				inet_proto_csum_replace4(&uh->check, skb, old_nsec,
> -							 new_nsec, false);
> -			}
> -
> -			*(__be16 *)(data + tstamp_off) = new_sec_h;
> -			*(__be32 *)(data + tstamp_off + 2) = new_sec_l;
> -			*(__be32 *)(data + tstamp_off + 6) = new_nsec;
> -
> -			/* Configure single-step register */
> -			val = ENETC_PM0_SINGLE_STEP_EN;
> -			val |= ENETC_SET_SINGLE_STEP_OFFSET(corr_off);
> -			if (enetc_cb->udp)
> -				val |= ENETC_PM0_SINGLE_STEP_CH;
> -
> -			enetc_port_mac_wr(priv->si, ENETC_PM0_SINGLE_STEP,
> -					  val);
>  		} else if (do_twostep_tstamp) {
>  			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
>  			e_flags |= ENETC_TXBD_E_FLAGS_TWO_STEP_PTP;
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> index 73763e8f4879..377c96325814 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> @@ -614,6 +614,7 @@ enum enetc_txbd_flags {
>  #define ENETC_TXBD_STATS_WIN	BIT(7)
>  #define ENETC_TXBD_TXSTART_MASK GENMASK(24, 0)
>  #define ENETC_TXBD_FLAGS_OFFSET 24
> +#define ENETC_TXBD_TSTAMP	GENMASK(29, 0)
>
>  static inline __le32 enetc_txbd_set_tx_start(u64 tx_start, u8 flags)
>  {
> --
> 2.34.1
>

