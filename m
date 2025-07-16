Return-Path: <netdev+bounces-207566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F688B07D85
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 21:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 856863AE056
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 19:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F5F29A333;
	Wed, 16 Jul 2025 19:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="foFGkkNB"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010028.outbound.protection.outlook.com [52.101.69.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BCA1531E8;
	Wed, 16 Jul 2025 19:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752693592; cv=fail; b=CYS8sQtIzMHYT688KPZ4fW1yUDjTwOa+3Aefbl8ak/Vxjahl3wt+kForjLRf6LiDV5UF05TGxKIVcKS/YtW6LfHuKNCkavgISZiM4KbLvoSinSWBeKCk1sbLJPRCIOUFA+v3GYY0qXGxpkfeLNilaHfn0DOoGPkGblNAwulPne0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752693592; c=relaxed/simple;
	bh=/AO6BPzB0N9hcCvGrrCojJJ8Ox8McFtcPSUq0DCsOe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mibaovcQcO2CJ/+QrMJHeLRj+0UaYE5VvyzwS9VdNIqMmTIzvSBX9VwlAI39kIG3V4ALlX7UTUuHSJ08xPJFpb/6TxcTwwfDAVw6vKS3nMMg1x80CTyhn+A6p66Uo0bab+9/yskcn0JOzoEaMHcY8YMRKuZVQZvUS0gh8OT3FnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=foFGkkNB; arc=fail smtp.client-ip=52.101.69.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gp4ovySZ08rPkrmKIeZwMgJWjtIE98xCMzwdgABe7gSCMhxIfL00flKfpfehJJr7jk819y+vK9vjk8wXTfpCkkI1yV92W9+31Q173PMVqSggRKDBdwmVu+5aHCB/qHbZhO7gyxk+rbYbFMEE9AEQBAXLpYOLQh1Wd9/8hTmtgxGQ3mAaLshbj7ZvAOsNXwJ6OYS7yq35OYRh6urKaGvNmiRQHLdP7CS5aBkXFsmFiLq1Gq8wJJnrhKFsp3OsgX5VYw9Tt5FuUKuwVhrHSefjuWuy2HmoH3lbjPohbVsL7trJO3hqd+fXJ3AY/hBRj6RAlOJAZLfKsEVGqkmRF9kXhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zb/Qg+kIotVRiELngiPuAoAc7ubMpuV104YlgeKy0/M=;
 b=t2TqSdYlcVydUPRrVPmwOu8ss5BC6cbEWvMII/m+dkBlrqlbGLwLiZEJ1MuUVXEIhKGWfdBRCo/cFV2FUg3PgfgfvPAfFZlNJmC3EIeQkukkrJgWYHEyojszEKFguIz+3dwpc4o1a2lECya6EdH8vykV11IHA2oEWosRv0Qg2y5oCCB/KhuynVS6aoog6yqewxLYVWNd4tSfAFabWBFQXQAngTsdllSPZREZ4OOygsubvk1C+ggqsqSGp3203Mj9eLMZeBi4P8XkKynobl7HeEE8QEsKZBIXBoCWJrum+aFwuFtKRcGaJwWr7nFzAReqBgd+8cRMNsciFfttcy3Wlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zb/Qg+kIotVRiELngiPuAoAc7ubMpuV104YlgeKy0/M=;
 b=foFGkkNBC4R1d73tWWIz8ZYERbsKTs9MLqkQkNPd+3X2B6QR/rB5R2K96iZ2a7Ge6ZEixM/voRmDd2wPNmayPQcFmbakX7y7cPmU317eUtBJlkqylVFW59wcfEjKMDlpGXdRUVt032HsnURVQ6yGDIBXu8hxzcgWDaeCh3f75R8WZ2jotsEwF7lDa5VJ9YBCSUhAG8OqXhza2qBNWHfBSjGfnj9sRWTn8VK8oc3+lPCdQEaipwUdfU2zy0vuEJPG5Qm1gYdyK9imZRWg1vJQGKknCuYP8e9KCWcI8nJY4VtZqVnslWqS6Jv2kWIHxugnHYh5SX+B89hp5qDeMsYwxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10683.eurprd04.prod.outlook.com (2603:10a6:150:21f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 19:19:46 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 19:19:46 +0000
Date: Wed, 16 Jul 2025 15:19:40 -0400
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
Subject: Re: [PATCH v2 net-next 01/14] dt-bindings: ptp: add NETC Timer PTP
 clock
Message-ID: <aHf7TAMY+Cg/FlF1@lizhi-Precision-Tower-5810>
References: <20250716073111.367382-1-wei.fang@nxp.com>
 <20250716073111.367382-2-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716073111.367382-2-wei.fang@nxp.com>
X-ClientProxiedBy: AS4P191CA0013.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::8) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10683:EE_
X-MS-Office365-Filtering-Correlation-Id: 3781d723-b862-4586-86d8-08ddc49db9cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|366016|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EAR29Cejppz5YGRIZGEykSlLodYVUQxc5BEEGgfrQupI1RNnRFWwt690pd9j?=
 =?us-ascii?Q?2D/REsozjnH/fv59iutT3lCL15cYwClfDLrJ0XEwUky9+WERwDMtsdTV8l/l?=
 =?us-ascii?Q?hUCcoMbWJGIAQioWT7ZHETFkcTnJ0qD5Ekiz6ZYSk6yb9r9uNCQwR1+pPN6/?=
 =?us-ascii?Q?Xv94jxH/nt/dudeQW+nc8RiDpt+u87glFzPvi1C1BydW8M5L8TVE9UJtJ7TF?=
 =?us-ascii?Q?pOXcQdBjkvVPOMIQf/Srai5JE38i5O9zV/G47sznzRCE5Iz3g7kfhJhkzn0r?=
 =?us-ascii?Q?IBqKPa6hOhGlPkuIZ+gccTO2TpRuxixdOQ9AD8SWIgYoRdXtb3PNA9RurG2D?=
 =?us-ascii?Q?R1X8rM+aO3F9fgpx71tufcSmXYHWEtzgj56GEcapMtUfgS/SNbtqJ0z7lH28?=
 =?us-ascii?Q?D1eTkFDO4OU0GMV7cwlOgE/y2JpkVAF168NDX2JEC6CFo1ftb6zqGvSZKhUX?=
 =?us-ascii?Q?CJyI32dScL6OAuA4yzzXNBbVA4PW0Pk8XnhI8XEOEyKG6qdukB7VS2hNwlPh?=
 =?us-ascii?Q?3e/zSUYUiV6uBs5oTOpBMKGppE06aabTmQEsrG767p9OuUjmJjRKlxwWf3X2?=
 =?us-ascii?Q?23j409g18/BFraIhMwuk+On4RQhrriVJe3DmHz2Io2ktjQIqch2xBEcYUMXP?=
 =?us-ascii?Q?LxLouw0MDlXvKIS7Zjm+jIgDsJddK9rs1vl5W1wBQJwnQt9jp+fLOVpFti7Y?=
 =?us-ascii?Q?s50s2eSVQM2jx6sow+3jgH84fWTFL2ZhcvvegETmmyrFg6pKLLv5aN0UdwC7?=
 =?us-ascii?Q?O+7JDrt+twVT9aGJ8eKeilJ2ByBnvBNR/HW8GoTZIj0Hyf7rSfkTdNbsEU+m?=
 =?us-ascii?Q?H+SvtcF0TmpSyxDkqjNWpyTYHnHpysWPvs5jSuCnU6rRi17mmsrxQzRSRvdI?=
 =?us-ascii?Q?9K9j69Kl6OUsRQbW09R++HmmK67FAQfFk8Qi571RqaUkHjVK1VGD8XM45CJk?=
 =?us-ascii?Q?q1i8SRwxW3u4PatCdDuq/0znzl+bd+P3CGOYYH8BigT7SH2qguRzNnTlx4Q3?=
 =?us-ascii?Q?lKu9ZKykhG2F1mXup4kEagK2rZrAW7Ap8enqSgrar9MByoJ64c1xD52FUnqG?=
 =?us-ascii?Q?Cu5FBP1KNprFRtA12pgIrNaGL0Ic7NxfPzscCnhZFmmEOx/I4FbUMxgh3sqy?=
 =?us-ascii?Q?wZxn07dNkDI+nXHgJVVey0g7lim+3VuUc1Gwunk9M0tapnZI2tfCeoJ+X/KS?=
 =?us-ascii?Q?MXSmd7hdRTS45p0K2KI3zQlfd0nl0s2Ue5bEO2rYE2WjEuqGF4GVpn6DALnT?=
 =?us-ascii?Q?DFXjrsBg1vo35N85dAPo9Ycm1IXnX077yW89xMbw0lnY+AXSfQj2QAV88cn1?=
 =?us-ascii?Q?DczoMf1k/959pkDLwvaaPPlWzzp6pzLWTTk2xe0PpPJy+EcFNeVj9z+5o0QI?=
 =?us-ascii?Q?vM+yHflpzvtXeGUhpVCancYl664UtMc3R5RpwVBcHOj/egO+1Pw/w8zvDimp?=
 =?us-ascii?Q?j1UaHb/1/pVEGZef2ODVxTxNHzPzogzv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(366016)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zh3qESwz5cpcayHG8fnaCRtJxls0PuwB/wGzlUx5eZLHRFMLu5uVuVJPGTye?=
 =?us-ascii?Q?bUwcJ1pztknE70XzPikX3B0Sk/BmzlFBTUZTiZkHCAcVI+RpIL12vVelmZqm?=
 =?us-ascii?Q?1E5Ypccp/C9F0kJwY0S+NWYVFmSAyhJVGbyZdjZCcjYie+YrfkMqFza6f0dX?=
 =?us-ascii?Q?n6hjjL1UfJyW652SUqzWMso1Q/LFACHvcbmFBgfwunEb4Nvv9+beilFpbKp0?=
 =?us-ascii?Q?9qIgR5Xzltpr1iZb61ifejsROyQuzVC21fOc6Mx3MJ0daqPl1yAroZ19YkBa?=
 =?us-ascii?Q?4o0HUfayCbseACbBPUZoXy69fjcXLCgB1gNhBPhmK1zc1Hw6Iofnr2FVOpq4?=
 =?us-ascii?Q?W9AMZ/GdVmJe3wTW+bmQvqZ8lTcKcipOH8eT18+s/Wg6/qQkoA1/tQJqbhik?=
 =?us-ascii?Q?moGdtQ3EAbDxzi/faEkY+NethKfNnxHhK3qlOQgXblpy3Ft0Ppa7SzYo2dme?=
 =?us-ascii?Q?w13fYOif7iO0TG+f9yg6N0vgcQ1rEquMl1Y6HliH6Onk5U5Gl2ZYUDS7yfUl?=
 =?us-ascii?Q?Cgaa0Gk05CA/+OwtwSm1FA9xIfh45VnyeiCNygRG/eldg3diYybeqGRG0Md5?=
 =?us-ascii?Q?Rm37vxjH2YKbT737WhmL47ifIGpyTnm0H/trZEROnrtnNt0Du0SUMU0rZ3Dt?=
 =?us-ascii?Q?bFuzam/CGXXv9AYING5t15Q85yGsxK+7+NXR2WXJiXCU617rFkRzqIWk3Ms+?=
 =?us-ascii?Q?OPkjrzvtaUaOBPZ5BUWgxgKozAnuPuvlkAC0X7KaYBKmNSTnfpffrFWPYX2M?=
 =?us-ascii?Q?W8vj6CyvQMW6hYqtCUuLFDOa0+NfaddAgNzZ7I0FekJ+HICGKEihiKiEtOmt?=
 =?us-ascii?Q?2ZpqQJXqCHkEPxTM7grskRZ9h3ZXKjRJCrzHbT1gIzMs0opiq70fbebgVsew?=
 =?us-ascii?Q?L/wgNpe3GZNccNvVuuhLiObaTCnuI3waI1jrY+hGZISmlE22GLpOuHAU6EuJ?=
 =?us-ascii?Q?b5CTLvOyv69QpPpF3cIieyFHKtQ1bXW2xOAfGBRogcOQWFgqRTqpSgKeP+F/?=
 =?us-ascii?Q?rj78uM3fz7PR2PU1Df3Fr0E87HPlGK7mtbFkJx/FZ0nKmcimrXLiHnr3PwZ7?=
 =?us-ascii?Q?PRC1eA+5tjsgZN5sXTVKujbHjDwGEM0tmXV7FdPC+uaOCPip7y62igDKuKBG?=
 =?us-ascii?Q?pwtl4oQmo4/bgHyHKXkKTBYteAzxqAQBnzbj9UiDwnA3FDkyXvthnvOweQNZ?=
 =?us-ascii?Q?PRdP9/d0EQsBGE86iLRtKYCrHwYGItTMNoCOGqnGqyMXs+0bNbta4LpH26Wa?=
 =?us-ascii?Q?H21nxk1HmfQ+Biweh9VDoc6bS+dppkZQ/MULOYT6TTZTopYB0hKO7AktfnkX?=
 =?us-ascii?Q?E3W29HWaBemDHO9AR+MNmHDM6tlfvaaLbDvAAZQhzwHiUrP+5MVV7OQVdI1b?=
 =?us-ascii?Q?zuPbenI4ky+bJX771vYDgd6G+/orkdza4Yk0/YCiBcq4DZtf5ADM9W0gqlsP?=
 =?us-ascii?Q?DwNdQRKJReef/0IVRK/7j0691zFY58t+7FMz6RRLP5RUkiaYodF3NYMsQrgQ?=
 =?us-ascii?Q?/RokBo6M97O+6rhdMdfHRCBdML/NGsFTvi8mXrRTD+xxs6F0GMdlGhtmsUxH?=
 =?us-ascii?Q?vcSEDMWFfQ46UtKtB+/gE56VHUUxAHGvnS7HGI9X?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3781d723-b862-4586-86d8-08ddc49db9cf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 19:19:46.5346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GpQOnhwPdI+/rz/2mzbYoP6V9uZpo0gGLdNc1ULQLRKIELhG/jYX30uvKz+Xq4fV3Lqn0qxndxluAEL/TP8/LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10683

On Wed, Jul 16, 2025 at 03:30:58PM +0800, Wei Fang wrote:
> NXP NETC (Ethernet Controller) is a multi-function PCIe Root Complex
> Integrated Endpoint (RCiEP), the Timer is one of its functions which
> provides current time with nanosecond resolution, precise periodic
> pulse, pulse on timeout (alarm), and time capture on external pulse
> support. And also supports time synchronization as required for IEEE
> 1588 and IEEE 802.1AS-2020. So add device tree binding doc for the
> PTP clock based on NETC Timer.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>
>
> ---
> v2 changes:
> 1. Refine the subject and the commit message
> 2. Remove "nxp,pps-channel"
> 3. Add description to "clocks" and "clock-names"
> ---
>  .../devicetree/bindings/ptp/nxp,ptp-netc.yaml | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml
>
> diff --git a/Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml b/Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml
> new file mode 100644
> index 000000000000..6af1899d904f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/ptp/nxp,ptp-netc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP NETC Timer PTP clock
> +
> +description:
> +  NETC Timer provides current time with nanosecond resolution, precise
> +  periodic pulse, pulse on timeout (alarm), and time capture on external
> +  pulse support. And it supports time synchronization as required for
> +  IEEE 1588 and IEEE 802.1AS-2020.
> +
> +maintainers:
> +  - Wei Fang <wei.fang@nxp.com>
> +  - Clark Wang <xiaoning.wang@nxp.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - pci1131,ee02
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +    description:
> +      The reference clock of NETC Timer, if not present, indicates that
> +      the system clock of NETC IP is selected as the reference clock.
> +
> +  clock-names:
> +    description:
> +      NETC Timer has three reference clock sources, set TMR_CTRL[CK_SEL]
> +      by parsing clock name to select one of them as the reference clock.
> +      The "system" means that the system clock of NETC IP is used as the
> +      reference clock.
> +      The "ccm_timer" means another clock from CCM as the reference clock.
> +      The "ext_1588" means the reference clock comes from external IO pins.
> +    enum:
> +      - system
> +      - ccm_timer
> +      - ext_1588
> +
> +required:
> +  - compatible
> +  - reg
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-device.yaml
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    pcie {
> +        #address-cells = <3>;
> +        #size-cells = <2>;
> +
> +        ethernet@18,0 {
> +            compatible = "pci1131,ee02";
> +            reg = <0x00c000 0 0 0 0>;
> +            clocks = <&scmi_clk 18>;
> +            clock-names = "ccm_timer";
> +        };
> +    };
> --
> 2.34.1
>

