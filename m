Return-Path: <netdev+bounces-207581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B81B07F24
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 22:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC3BD7B49CB
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 20:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2EB274FFE;
	Wed, 16 Jul 2025 20:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ij1pFQBV"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011071.outbound.protection.outlook.com [52.101.70.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAE91E3762;
	Wed, 16 Jul 2025 20:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752698979; cv=fail; b=MzaK8ZRvGRmGO0qmx15DroFc1le7wajFp4kNmR/sYhBZrzle+jQ4BqtsLvn/cPajvcmG2M7z8cw6EhMrD3Y1HGH6+k3AutrlkxlSBInulAZI5JRnozHbHvI5J6CJBjZAxi+nic6TmKY18jQ7au/n1Gkyxctyni4+o9gLtYHCPug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752698979; c=relaxed/simple;
	bh=CZeoWGcEUm5j52ih3Im8kKjnJr8kLPe/+URPkSsFRiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HIgLHaGOfLyKSRgpBxS/6tIACZIq2ndb+JSoayggo/5EInw83OuJXflfC0JgjH0/yXJ6nmXxD0raJQ+AbiuAju5hMvoCaLLVdQV8cDi9eq8keLvVQp8LXSengj3bLZI/l2HOsGrM4HlCpNgvAjpvuG147rBb4oAf1RNi4zYxCK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ij1pFQBV; arc=fail smtp.client-ip=52.101.70.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vjHO/XMDlS1hlzf6RRmXzhXs81SNeOKSxtuGyTehGFpX5yv6eufC93MfLaxRAjghalsAuCcDopnWIzqgQ8wZrARDk1Uk1MS8Pc0lG/oolQWMq4s8mnUWrmXfw0Z2b4uO6xfg5m36QRWlTkw7MAFwbr9TlFUzUT65AYiqVKeBRxhMoFvJmXQHecOZ4QEOT3XTGtXkHiS9brJOhQDTaYH+yra/AAjIy3LOrrcmUiWpIRoggZlIORqz1pXM6JCKlhAY6/1pwen/LMS8UcMQWSJzOw4Z8SaexyQUpSTfA/4iVQ66quJUy8m+9CUmN9R0Vb/Avq06U4I5zs8Nid90nIi0pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1IjpgfY6O4oc+jDI0CD8b+9mrYJ0JpNaSed0oZ3y69g=;
 b=IgjwGQ8c5IGD+w9LenbbUQH/5IkrqRr8Opw+xQ4wXrNlO77un3JXbo3pfWRDP1ngtfr++oHsxqrgzS8uxn6cAwREi0Qj45XEPtIELw5kd8dlSE0uV8FgXjqxVRicKW46W9xxAzSAFzM1cmRwqPXSCjkScqQofG4TWD4I6d58k1d3atpTNpyJ/QgtRklrY2cSrj6Qhmrp4Cfq82+XGTxomDrrTqu1ZTYql0k3YPltoRVzjgRgU5opUmuZVTFgT+4DjsRlrULD6qcxK7hXzboYvU0WJ76kgslUlKQdOcwzJB+mZYBxQab2yJMRU+DYBfKcmZjEHLg+g29bj4APhpg7VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1IjpgfY6O4oc+jDI0CD8b+9mrYJ0JpNaSed0oZ3y69g=;
 b=ij1pFQBVnseVxg4EPOlAtth9Kta6bXLuCqJCKcWfA1T+D/7/d7kDCou/YZSM0vGevS37yZdUkNnxQtnuKh8E9jH0xCQTjGGlMwJ8nMiFk8LqTF1pNA6eEKCUBA6WimOqanLIS3Rds9utwRgV59BAW0AeaRbvjyLRpYhldkdQUVTLw3A1HD7tYk3cAmgRHkjGef2xRPQclx6ciCt1DBH9RdF4DK7AjEmz/AbPHKtOId/TjHRHmPURV8ZVzyKZn2HPnL//QdIZpJ2S1OK96Lm9xqjG98c44m4DSKOg1wVs1241KXgmTmCCmcK4SDcjd3rApxFyScsT0wMHHXj6QSJz5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9677.eurprd04.prod.outlook.com (2603:10a6:102:24f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.36; Wed, 16 Jul
 2025 20:49:33 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 20:49:33 +0000
Date: Wed, 16 Jul 2025 16:49:27 -0400
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
Subject: Re: [PATCH v2 net-next 10/14] net: enetc: Add
 enetc_update_ptp_sync_msg() to process PTP sync packet
Message-ID: <aHgQV8O8FPZO/cdT@lizhi-Precision-Tower-5810>
References: <20250716073111.367382-1-wei.fang@nxp.com>
 <20250716073111.367382-11-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716073111.367382-11-wei.fang@nxp.com>
X-ClientProxiedBy: AM0P190CA0025.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9677:EE_
X-MS-Office365-Filtering-Correlation-Id: 425b1601-7a5e-45ab-e0be-08ddc4aa4482
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7DvHkDGH/p3ZAom6FyCR/Du/Q7lApCyuCJw/mfeWDT8s7T2wVUHTEc5gPTvm?=
 =?us-ascii?Q?zWnfP/WYE4XPEdFwT2qG0vJJy4NdpqW26Q4It66jomHn8ruJh++AA3qnTWr9?=
 =?us-ascii?Q?Hn4C62NgQ5AJe7/GwgYVuTC0sVIaxOsSfSKIG/MQFtaOlH/nmMsu6IExACq7?=
 =?us-ascii?Q?3ttUq1UoVpkM3WftXBTzzr7J7tf7PSkBnMJRVwsaASHt3eAoq64zqxIzXtWn?=
 =?us-ascii?Q?sqCwmwvdfCyWHyJ65dQviwYuNus2oGOVCg4BbFUwhqq78g3Hy3piIcDZC7bG?=
 =?us-ascii?Q?QK/AHEP04isrCVXVXAAGOPjNLUes08uJAJpZcsYw7QQ/+rgIvpSpliwvKVPv?=
 =?us-ascii?Q?YlbKGDIpIRa6ZG8uYXse9KZ6hJfPwypovR5IP0gU0uoLOhQ3axRN9eUlkGBc?=
 =?us-ascii?Q?GaAzJO3jodFZ5kjsF6Kzu9wdgMAbWQn8uggQ9I6ltrGitTRGmtKHuX0W3knK?=
 =?us-ascii?Q?5na3Tu7dARksweoioRGq/pT2J+qq/umjKxquI0WW49YU1q7htyakOzGsYMgi?=
 =?us-ascii?Q?LEZBNCaVF3v/3ZKCjyocqL/9tZVjqI06ASzd1epsyHGB++8/IgVHXSpDuVSo?=
 =?us-ascii?Q?YWO3Pw+xZQiOHdNZq3qJ7y0yMjxW9q24NZm1GW/+ZI1ZJrLbXD4CM6bOqsIZ?=
 =?us-ascii?Q?pUsja0vsvS5GzYKezMgRvVduUO4B8U1vTrFnuw4FBVuBr9kxLJdpNDkzaiN1?=
 =?us-ascii?Q?FWhLxSd/Gww8D/KW/ypoOsH+HoqAUdvdoqycjx2+PpsWrLVIKcUkC3bPBmGY?=
 =?us-ascii?Q?W+WU+WZyMl0lMRxq/o5Ttilx5B3yaLZbFvq9upnNt6g5SaoSUym/xnGMCAuY?=
 =?us-ascii?Q?BXJ/qAjEWJ5LqFbHI81MfCrcSDoP06JhYwn7owTnoaZWDCTt7/j+Hls2/z/C?=
 =?us-ascii?Q?U1YOsSZ0v1yLOXLRRdy8yrRWCgJnbFU9dcVGiUEl22zn/6HtcZrKrLz1Gxg0?=
 =?us-ascii?Q?68dM4b3DxmrAjY41i2yzOkWu8DCw5+yR+aR6g2w4PVFVXo9D82mR8HiyJvU3?=
 =?us-ascii?Q?U09JBHK0FW4sE3ECZAHlD55bBdye20XfgOOy9bnNaLSeLvUFZ6Gg2oDcf1yX?=
 =?us-ascii?Q?VcY7lSrY/e9JKLDO79JW8eDhqckPY2xEIDywIxcqysUpJEY9iieyssM+4RnE?=
 =?us-ascii?Q?kQv2Dn4aJs7ZlwTCtchKkoBykwIMD4ov2HasJOBsxYZoLgoMuUaHq8QaHKC4?=
 =?us-ascii?Q?DI5SMsUxtRvmiaU240Zyw3tntWxD7DZDtaPFQa6puheXN4nXhtT7kWSqlYS1?=
 =?us-ascii?Q?Dsz9ovMXv9J5Rr3HjjJ8UW/YKiKf0U/19z7n7GxodW22nIY1vBleE9OWrdx9?=
 =?us-ascii?Q?ULDh1N0I1HTI0LAwAyW1kW6Pu6vj+4X9Awx65LZlXWU/xfg/wlsx7KWdU/al?=
 =?us-ascii?Q?s3s4CYmJvYwF0/fnWTwxZMMYeHOugl3iUNjMtrHXLp5EgnlRnKYrYdIf51tl?=
 =?us-ascii?Q?xqYCkJ/ny0O6ePRTV0aC5fDGXb46aaL7fMEHrCpf4qpfRSPQjnoaGA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Fz7tH6hdLeBdsTR5/pkASH6ZPb1110CKvy2262ncLvj4aJU6ptUWakBLyNK8?=
 =?us-ascii?Q?Eq2kFsJAhfv8vwfD8DNZMM9nBneM2J50pdl2mz6BzhQyFn7AOQQpb4OUq+vK?=
 =?us-ascii?Q?b25OYO07ia3uy6SRtXkOwVdf0roaco4vf9fpiY/X+tUUhGE3CzqaH6yUCxkz?=
 =?us-ascii?Q?INowNcPWbDpmMuSEluFcaHPWErq0Zpc+AkhVxl87rCL/qVx3nt+XDcPVKSdb?=
 =?us-ascii?Q?kd9N+5fX1xMdyql517C/fuvxy87VM5GGwLxZLw7K0wgZUdrZ5eEBp0VcOr/U?=
 =?us-ascii?Q?xOc2doMsiNXpLh+V6o1SnoEqgJUiQ3b/OPZXrvmVayWCtOxobYZCuK1RjFW3?=
 =?us-ascii?Q?Dtba9sYSzZPRvB2vLvv7ZAuJxJexYgwmUzLN1QnHNrGF3UOba61L6GqL8AGf?=
 =?us-ascii?Q?+iXSLny+pKLayMt1NpvuCi5hV9PC1sYvGR1GFpSpfjXWpM2ANRGYTMWgVsMo?=
 =?us-ascii?Q?F4Ph0TufMxn+8LmRV84if05WXHJnp9gQfHumMXohDJDusJjBjd3BMtqfa5U0?=
 =?us-ascii?Q?zyFykZiJZ2dvmClw3oOqVPaA92850UacYWGWfYYJByQhGCcFcWyzykeckxm2?=
 =?us-ascii?Q?qMzmfIgO4dIPiqxQw8FgDmEMXXaRKqXhJECAvSR/Fa5JsJSSCJkH2+V+cmiH?=
 =?us-ascii?Q?ovt6mhnPSDnOb4i8qcOdBO2x5qevZQetfyjDaTSSW5nHpd8nxPTKmjSNk4bu?=
 =?us-ascii?Q?it8ouokeqMNjysMdILnJHKEKD0qfOoytAez4Ft1hsWPttdOtQxKQwr2LOnZE?=
 =?us-ascii?Q?dyHvbLAzfy9rVipSIKEC7vXNXk6fWo+A8/zhGHPMVQbEUB4o/WRABkmoZ/x9?=
 =?us-ascii?Q?67+RsXnvxHeoLP4fB61m3tLLc19XgR3k0gK3w1k9qGnOwJCscB0R7ihrFXA2?=
 =?us-ascii?Q?CJPREHR0hLylLF+5XFYLn2tGmgXr5l2+TDPPO91QFb0FWavWAoyV5YlSY0to?=
 =?us-ascii?Q?2vzWZ1cPM43jXwwMepLnZO6T1YMCKjZT8lnLXBc3qZYu/lFIzNz8UjfgVM6z?=
 =?us-ascii?Q?pesg2TXfK9syox93YjseHY0z/JZagmXhfWnDxWr1oDj3HMKcujg1oqwLZtIP?=
 =?us-ascii?Q?LH8MOw3JNj2KknEUkufxvIztqyL1YoLXZGSD04Esrmgu27aKpY7F/ryk/cAD?=
 =?us-ascii?Q?u+F6UNBOSF4hoQeDHN1p13LE+viPwyuTtGbsV2J9BGUei9GcfcSja6R02Pw3?=
 =?us-ascii?Q?rUhd5xkfz1aTs405+dowdTqKLDmEm2XxkQ7yCFLEQHAZ3H+0laNAiaE61aPn?=
 =?us-ascii?Q?5velkuzT9tJUH5B26wk+udEMArZyXhyV1WBT0h+EE1fHxrJ7pxqg2A0WXh1V?=
 =?us-ascii?Q?DZ62fyoPX/z9gXx38nVBnNUo0wV65GE/wY8NEW9cmQMGpj6xmlsoqj/H0dyw?=
 =?us-ascii?Q?br3Nxnl2UKM3+5zMXWtWK0hAXeN3960R3oCyvpz5+e6E6Drg4sEIZVrUxu9i?=
 =?us-ascii?Q?OnOlYH8gRY4E9aQyQ7RM6+5d1dX9NPH5pLGeyAdATnc4vbWhldrtN8Lwfm4o?=
 =?us-ascii?Q?bjKT+A8gOxwEGVh0eXBu2sVK5gdYu8mmqCTOQ74x/i+2/lBJ5NZcpptyq+qu?=
 =?us-ascii?Q?3KngUmH4xafPXk5cNQvydBEp7Yjhs1DJLdEiOUO7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 425b1601-7a5e-45ab-e0be-08ddc4aa4482
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 20:49:33.1770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: szKoazbMRQ9HodiLD8LJQF8C4QEMphBOYJwAbkg78YxzdlEGeTRuiY7y4IHpuVP/+CMdY9PinK7maN8zxx1CGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9677

On Wed, Jul 16, 2025 at 03:31:07PM +0800, Wei Fang wrote:
> Currently, the PTP Sync packets are processed in enetc_map_tx_buffs(),
> which makes the function too long and not concise enough. Secondly,
> for the upcoming ENETC v4 one-step support, some appropriate changes
> are also needed. Therefore, enetc_update_ptp_sync_msg() is extracted
> from enetc_map_tx_buffs() as a helper function to process the PTP Sync
> packets.


net: enetc: Extract enetc_update_ptp_sync_msg() to handle PTP Sync packets

Move PTP Sync packet processing from enetc_map_tx_buffs() to a new helper
function enetc_update_ptp_sync_msg() to simplify the original function.

Prepare for upcoming ENETC v4 one-step support.

Frank


>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  drivers/net/ethernet/freescale/enetc/enetc.c  | 129 ++++++++++--------
>  .../net/ethernet/freescale/enetc/enetc_hw.h   |   1 +
>  2 files changed, 71 insertions(+), 59 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index c1373163a096..ef002ed2fdb9 100644
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
> -+			*(__be32 *)(data + tstamp_off + 2) = new_sec_l;
> -+			*(__be32 *)(data + tstamp_off + 6) = new_nsec;
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

