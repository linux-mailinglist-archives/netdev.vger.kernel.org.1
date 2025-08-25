Return-Path: <netdev+bounces-216532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 962A4B3452B
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 17:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F6C21884A63
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 15:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9989F2EE297;
	Mon, 25 Aug 2025 15:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="f5v9d0Fh"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013026.outbound.protection.outlook.com [52.101.83.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D0D21E091;
	Mon, 25 Aug 2025 15:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756134325; cv=fail; b=Wy0tKDQZCDLnzV2M/Uv4WtEbRQYWiazWtpIgFpRjtZzwAXyfrVFALXModCvrG8Vj05SwoC6N7FWQz0EXL2rnsOKOHPHhFvqlfQOrpIvsQIHioaGUNug2HcCky4+Kj/Gl0Kpk49kX3t9ONSEBwmKjzLtrer5Zg6maeMp7VsHt2E4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756134325; c=relaxed/simple;
	bh=TnzcaB1xOzk9g8Tluwn/12kSK4RWh/92rNkf8u1LK+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dRn9kVDJ7YX3WuzYSkm97cxLgLr2JhwDJ4WYoSHLlk64stGrqFpIXqyXrFOTLf3fT0K5YPDWAEz+ktjjA7Cfbc/4vByaw+MCknvfXVrWER9MijvgtrNH0dH7NiihMy1hLmWNlwsCZdqyT24fNknqMACyWGP821h4w3vc1If48nk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=f5v9d0Fh; arc=fail smtp.client-ip=52.101.83.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nN0yUQ9CM1H9ujzn9pI9iMHU8F/aLa5BHU2IzV8oUxDm7L4qONwGEBPsIWTnywEheT9g50fN4B7c5qkoX9KHZaSsnTGVuihvKoQE0I58BnOj7TYXvSCwath6giZ+usp7MQZaglfqoJ9exT+Kk5QquWdf1OKT04b7zU7aMdU4GKL84cchyUsr4SgJz7LDPHVHg0bvlH3Hy5tK/dNdDuaa3VIY+I18ClsB7F5vvHSRoGj8KLxRtlx2VOigL6bna53mFwUlHvSIMF5zAzy2penMLBmtFHakqZrjxsgdBN6VRgbSkwRCdIShOHfIa66tR/d6blwbwWLOVoAcO0ahJ0Vi3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJv50o1vLtVS5PcE0zSJrQDA/1Zv4UsNS48HrMAiCvA=;
 b=YllvWaZkwn5ayhDNM41g3b5CndTUG3rDnDLE1hCl/JdiV0RAkZ4Nykk6Tiap65yYwcU4RgXaxzR6hF5kByVSVvqGT032/FYN5Zp4MN75Q6Z4pSpDvNG/hdjgfFwcsUdMUEtTk3+gbUkWFjLVd88yCyHcT7sUxZe7a/aU/ExV6I089aA/4E4c3aD+A2QxvC9BQv5ah7kymzb6qNiwy1dFolznDreTrdDgOoWq8NT+hErAoE63sQVOg90tgx2OkD1pR8csaC7ZevTUPgthtiyKBuSISgG/Z4sNG2vean2zMVcb4oLDoHi2tx6VlL7s9qlIGM4XB8hegO2jQpF3l6zGlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJv50o1vLtVS5PcE0zSJrQDA/1Zv4UsNS48HrMAiCvA=;
 b=f5v9d0Fh8klGMUxFeTYZNg7QUD4sMNCWLlv8HZ6ND7ElpDOZR4pHysjrt4DPPGXCBrHyoCXMyfCNW1N7iiPhIwdWsMCHHTFVaGKdsxTHy05MQyqcpIalgkX0qEwB5Ggcrx6aLyEf1hj+GojqftUfC1SUG/m9R958P0qkNMntDFc721QdBRbE3gCZWWHAfpNYGMcKEn4JPwjqzJI5UGRlR09ICl4scWMF0KQpXwDiU5sKPrpjzltinGj/whr3NkE0DX01nY7+b01T/5DiCs/TFJP/Fs0TN++t34KLzOqXEz3JsoLBrRAbHSLo3ehSA17QRKXBipNKnXQHkwYfK5R/OQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by FRWPR04MB11152.eurprd04.prod.outlook.com (2603:10a6:d10:172::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.11; Mon, 25 Aug
 2025 15:05:19 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%5]) with mapi id 15.20.9073.009; Mon, 25 Aug 2025
 15:05:19 +0000
Date: Mon, 25 Aug 2025 11:05:07 -0400
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
Subject: Re: [PATCH v5 net-next 01/15] dt-bindings: ptp: add NETC Timer PTP
 clock
Message-ID: <aKx7o19FH1jF4w1+@lizhi-Precision-Tower-5810>
References: <20250825041532.1067315-1-wei.fang@nxp.com>
 <20250825041532.1067315-2-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825041532.1067315-2-wei.fang@nxp.com>
X-ClientProxiedBy: SJ0PR13CA0091.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::6) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|FRWPR04MB11152:EE_
X-MS-Office365-Filtering-Correlation-Id: 67362fc0-fdb0-4758-b1f2-08dde3e8ce94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9wKWv9jWjV+urQlcS4MD3dwl5hXozIJi/CHPNbWQQffTxmeXyEgCqfrUR0Ux?=
 =?us-ascii?Q?uovzuhNaBJmMis0obkOyhgyv/+pIF3Ptmf/WKLlX/plvuCoKWK8fIYcY+uMX?=
 =?us-ascii?Q?ZkVDduNRO8/sDgiIaiK2ogXAfvy1dJy7UpqncipfsVPHcu1bSwsxHsiXWKTE?=
 =?us-ascii?Q?hiFyKFYMbnoo5W791w5jI5Q6y1UCMVCqZQEvDhNU4qeDJamyQz4BGnooGiCC?=
 =?us-ascii?Q?rux4/DkiF7X6sYte09W+0xmVdAACK+3JBqsmyRMdP8TJIEIB1P9pNVloGCRt?=
 =?us-ascii?Q?9DYXC+9X6rOz2hSmjiYbJ0tAsFcuGfxIpopVIDkJ19wYgxiwE8WqoRU4Cgv2?=
 =?us-ascii?Q?u6g1sZxjzIdRenG0OezkEH9XQ48TDKUCiahhA4EqU6wofVG+9/hbr8gBYjP4?=
 =?us-ascii?Q?GvtUWZ2NcmUfIyh8j2dB/dhOLQnGDM9tMsuqmhYPXkRKtKk1Vbw/y8cgFH5o?=
 =?us-ascii?Q?Mv0EtjNBlYkjV2fnArWs+OVbSKsVMbxoxV/v6Q/1sN+LsxqP6znB3TAke5x+?=
 =?us-ascii?Q?14z0LHThiWHWk5H4Yws6BNlSSv0ZVKy9giMLdGTXbKCKRHUXKtERL+r7w5yY?=
 =?us-ascii?Q?XDCKoY52QBpf1ftyGvgP+aFR9IGTX/DvvPg6gV4XII4Vf05E5+CmDDf/zyjm?=
 =?us-ascii?Q?7/RDjbX/STEyH5sOf713jA2Q082omMB/GBro4xhtjTWo9LeKromgDFPOI8cH?=
 =?us-ascii?Q?EPn5C8rAOcWrc0TBD6JM/NqRqPbdzgiLd/q2EJ0M9cFrTY3hraFVlCH9SbuH?=
 =?us-ascii?Q?vc4yGMXMH3eKXVeFQcD6sLYr/yrdiL+JZAtoqtd6o96Z2MX39EpD2s5ANYr9?=
 =?us-ascii?Q?n7WBvscQ790el2SwPaQyIswe/8IacleAhZSaDQ5+YLYqPXkGw8u4uu16HTri?=
 =?us-ascii?Q?PNmqJ3LvNx+9Y82h4K4X6fK9+RVk9yJmEf40r4Ya6BMCOtwaqsAGsTmLQQ16?=
 =?us-ascii?Q?s3utgCU42+0aWKuLpzFkLkMvNAw5xAGDq8wHDcHHbQMbbWYPZVOMn9m78Fir?=
 =?us-ascii?Q?UoMXvUlmWfHksCxxy3NEkGKlqsGc+0ExwnoDIhThx3LwPJAA7JpU8lgISdGU?=
 =?us-ascii?Q?jPkVtuQqK0KA6qtzkrLHGt5bwwQlqqj9Mfd0Gdhpz341Orgb17OEnzTwHM00?=
 =?us-ascii?Q?zaNpLOEiEA/Bs9eL3dXId/I/C1aRWwcAI6m9KWbiEEl/ITvipjKn4/BZMQOd?=
 =?us-ascii?Q?TJHkRIUbbKyYwB8JD/wNXo3FrBpQMH68Q7rMkrLmS56ZLuKpz9XTHH3BJZQF?=
 =?us-ascii?Q?1i9Je7uyxnO679snWg1t8np8qBZON8BCg+2G/aJu2+9V/PWnzOMoRzA64Ujq?=
 =?us-ascii?Q?0Wz68l+ScRe/bRvT1Q5nFpZIzUeB+vLOw3c3uLYQpkVY85LnbIBJwIzf531N?=
 =?us-ascii?Q?cwTIo+QlozK/1VS6Kf0eyQ/fLPNeFLZHuWl/4MI9bhqrgAzHwqK1ol1JW4zd?=
 =?us-ascii?Q?1Bnll7cYmtddFpwdmYKXcdFpmmOX8APC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ngm67Jnjd+KN4B3EsjZEyblhEV3jGvW1qg8e3w+sQPx+XbNW+pELnug53VCI?=
 =?us-ascii?Q?Rhrof9hRwFIRliRnXdQGGgLShwdv2CUnXfgZFDM/lnCCsa+n6S1K1+h7eFRp?=
 =?us-ascii?Q?R43bVR81tAVqwKEhSvXMWLZ5R3N4KJ2G9Xuz/apielt4VXdsJs2we96VxLfo?=
 =?us-ascii?Q?HCmsOgKG9SKx4Y6Kgwh/rgiw1c2yOPj4kU9z/BdtVaRR0nrVEkn75NlrPBem?=
 =?us-ascii?Q?VY9fMGTdJjx9iQC1WDM6xuzIcfdl8PNSvi9APk7PGiAFu64FKqYSEURqvJI8?=
 =?us-ascii?Q?g/qTJ6PzaXE/zelTu70qveQJse7z6TOPFSffjWm1sR2gFdoE3bqb33ipYwIh?=
 =?us-ascii?Q?6rU/pECTi66yObvMp1gyklDtR7oSNfkQusB3EkI7yoviCt8VE9ahZEkF7GGh?=
 =?us-ascii?Q?p1KuSv6fi4hskE3wagASFTzGG09miKSamYjyxwxHHnBZMV3wNg3S3wFNWdxv?=
 =?us-ascii?Q?VZnh1VlPg0McFstamzkBDgeTvRlwn4DCSYZzdU/jPpgWVDqnjTF2PLE4QOQu?=
 =?us-ascii?Q?18Bgwv0I/SR3HnjnLrLW0aS0YFWdTTqUCtiH0tgehZarSvPTNtkH+N+9TnIw?=
 =?us-ascii?Q?PCyDvymVrVsjh2HsFCakZjQXmq3G0fmlnRiLgbKDN/KON7knCUobFOROo28q?=
 =?us-ascii?Q?88JwUtjcguFYE57AZSEmuHuAZRGlTMvIRZHJsacS3e1hFxU9fx4FQwn/hzAK?=
 =?us-ascii?Q?SqVR98JoG7ECr0aD1STyYcAa3Ey+Lxne1EUBhFVuMyl3Co/c25mEuYE4hgwK?=
 =?us-ascii?Q?pkEMiEYdtPQkYiyocQaoeZRAxkPE9dS2rXJgLO7RObM/5Q8nmJJPcVUPNdNK?=
 =?us-ascii?Q?YTn7DICiD/QjYxSpYB55v2oRCZEuLWof1+J13FTHj2xhfT4WPfwyZaezOKHh?=
 =?us-ascii?Q?PCKe+zDUNMgUiK0h2k+n3YxiBBvHjVgilV9GnwFe4JPlCJuIpr8MTRkZweG2?=
 =?us-ascii?Q?cA+Zl/dmgC7cxU3PQQJWzYBP+FtRvuMjU6kfzo1o0yvdlpdTQAm2TBv77/SW?=
 =?us-ascii?Q?Jo5/AVxD1q2cLj28kW+US4DXGwHlnR73hJpEeOAGX36LBHsgylb7lTqLPPqw?=
 =?us-ascii?Q?SLqIN8V2wpzuhtxjm4u4T1RbhyvvBaCrBPTVZAsgZ76UAims+GusaMud5oIA?=
 =?us-ascii?Q?CsK4dpVnP8flvwKt/KprVo3mGd9k4/4r6NcO0w9RrMtNFQpyxxculvvlBghz?=
 =?us-ascii?Q?wVWmiPGj47nC1zUlyY5K9kF95Q2p8ihhUb8HMI0b9oxtaPhCxQtznn10fitj?=
 =?us-ascii?Q?+IAVzML4unYiSqNN3T+r1QfdkfKawhTk55aYVS8I58/vYHGprKqFOh2we7oj?=
 =?us-ascii?Q?nnrQZ6W4LBZPir6U31zPANFseiyS4ftPo25+1t1DjEND+mR3zYU/f1w5zjlT?=
 =?us-ascii?Q?tokIONn5PAM7DNi1Rgy0t1frgCiSgWVAWrtnxyP3vEBKs5/zVOHfJPJHATpx?=
 =?us-ascii?Q?gKTNAyjYqoDk8aiEMb8AMbudEWBdMImW6gL7ygHEd20V+K9PIGUBJTYja6xj?=
 =?us-ascii?Q?4rgeF4bOQI+fkRSQ5FeYt0UTAZ9NGWdGRIlIBwEbZXUJe4iC6xBYpMf0ORVa?=
 =?us-ascii?Q?EYnuthE9aLdYEyTd3ks=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67362fc0-fdb0-4758-b1f2-08dde3e8ce94
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 15:05:19.6116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7HkiFkjDPw37z52ZI4Cagx92SE3EHen+5S0P9CO7es1PPDZemAZqeEAcMIL4BDVENbtu9QStQZLlZASp7UmVoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11152

On Mon, Aug 25, 2025 at 12:15:18PM +0800, Wei Fang wrote:
> NXP NETC (Ethernet Controller) is a multi-function PCIe Root Complex
> Integrated Endpoint (RCiEP), the Timer is one of its functions which
> provides current time with nanosecond resolution, precise periodic
> pulse, pulse on timeout (alarm), and time capture on external pulse
> support. And also supports time synchronization as required for IEEE
> 1588 and IEEE 802.1AS-2020. So add device tree binding doc for the PTP
> clock based on NETC Timer.
>
> It is worth mentioning that the reference clock of NETC Timer has three
> clock sources,

Nit: reduce such connect words. Just said

"NETC Timer have three reference clock sources. And there are clock mux
inside the NETC Timers. ...

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> but the clock mux is inside the NETC Timer. Therefore, the
> driver will parse the clock name to select the desired clock source. If
> the clocks property is not present, the NETC Timer will use the system
> clock of NETC IP as its reference clock. Because the Timer is a PCIe
> function of NETC IP, the system clock of NETC is always available to the
> Timer.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
>
> ---
> v5 changes:
> Only change the clock names, "ccm_timer" -> "ccm", "ext_1588" -> "ext"
> v4 changes:
> 1. Add the description of reference clock in the commit message
> 2. Improve the description of clocks property
> 3. Remove the description of clock-names because we have described it in
>    clocks property
> 4. Change the node name from ethernet to ptp-timer
> v3 changes:
> 1. Remove the "system" clock from clock-names
> v2 changes:
> 1. Refine the subject and the commit message
> 2. Remove "nxp,pps-channel"
> 3. Add description to "clocks" and "clock-names"
> ---
>  .../devicetree/bindings/ptp/nxp,ptp-netc.yaml | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml
>
> diff --git a/Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml b/Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml
> new file mode 100644
> index 000000000000..042de9d5a92b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/ptp/nxp,ptp-netc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP NETC V4 Timer PTP clock
> +
> +description:
> +  NETC V4 Timer provides current time with nanosecond resolution, precise
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
> +      The reference clock of NETC Timer, can be selected between 3 different
> +      clock sources using an integrated hardware mux TMR_CTRL[CK_SEL].
> +      The "ccm" means the reference clock comes from CCM of SoC.
> +      The "ext" means the reference clock comes from external IO pins.
> +      If not present, indicates that the system clock of NETC IP is selected
> +      as the reference clock.
> +
> +  clock-names:
> +    enum:
> +      - ccm
> +      - ext
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
> +        ptp-timer@18,0 {
> +            compatible = "pci1131,ee02";
> +            reg = <0x00c000 0 0 0 0>;
> +            clocks = <&scmi_clk 18>;
> +            clock-names = "ccm";
> +        };
> +    };
> --
> 2.34.1
>

