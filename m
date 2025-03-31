Return-Path: <netdev+bounces-178402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D8BA76D95
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 21:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31668167544
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 19:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930282185B1;
	Mon, 31 Mar 2025 19:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZSpRL+FN"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012030.outbound.protection.outlook.com [52.101.71.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB6D215F5D;
	Mon, 31 Mar 2025 19:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743450257; cv=fail; b=ZovaOmNNQZHcJfY8i6CMPEcIduLB0UFOYMpFeSQX0Y5aKqvfYPL5qDD6kXyV8fcnPs09rZpafGFwVJWxzm6ADE/UKofhf0CJOwCKybirwc7tLz2A10ZgqLPfeBZDiLDSCv4QZDTsnJuiHBCZ9J2CXBiw4nsSONujxqyLIM1FSnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743450257; c=relaxed/simple;
	bh=gX0WjK+aV3KbsrMrt73B3jKlZ+n9uyFyifGbIKke+98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cGrAXKIsVsxwTI7H985Sxn69XX3IvH7OMyoAHXEUuYdZSNESHB6/GS8FEt1Vyq4ZBzyqC8MYOfOH8hX5TukoUzsh0YLHxE01N+XajvH2fMPAhADTziubdGKAjah6Ln5zXqXQmbPzyuv/idc8ziKAN3peA5GSJMkCsAX+wpM3A5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZSpRL+FN; arc=fail smtp.client-ip=52.101.71.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=loAFHvLhkv/v852nhqbrEiag0OcbjO+20RadppuK0wIzljfSZyBRWFIoCV0W0lDkIezuorSjwY13kfJwOzjOaf1rmQ+03LhqyrKsY+VuF6Jg7jJ+2C9VvaVA5a7ky1nIuKCUxuvEP2ZxMKQ9gTijuYUcZb/eVwqUODPcPKGn8Cka17HgfsH3JC8xmLQ+PkroZ2qZpaU7co8SfTELN880tdYHcEQebbiVpa8wnkA6tazZ9P3vcklbPBQeSwwHHkonWqJGMqVV7YxPQs2NixNBTiHdpAj88qE9tXZAK4k66qFgBMgqZjIV8yO3gkYgacr37hYK24CHNA+I66l0kV34bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zY08+tnYHYWg27kaD9YNxfY+b3RS/mmSchsnuUjA7ws=;
 b=tfqNcSPsmBO4Kl+zoXO+CaamWMXW8WtrxXZ23z64rUV6AQ0FQkzS0hgYuxPcSyjnHZoMZVIVSr2mOrI5WOuZ3CrFCr9a0UFChss4+tojggXfZFAjLYocs5WhnFHcTTdF7TElGUlPDpmTj1hGw7144d7zZAIaGrO6TFiAufSirwvUDP6fXTq5V9wlOzSt9qnS+G+i/aEdb3uhDdI6P3hp0B/znUEKGEox0budiZhGEmSQyx1Hz8OMnxxKKOymU/SmKPnyv3i2j5z1J/zObxoK3RCuLDSk81XSSbXHjgQJ4klbRd9xxX23kUgAPuDMT6DrMvlb8f5keV5E8rj52xY7yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zY08+tnYHYWg27kaD9YNxfY+b3RS/mmSchsnuUjA7ws=;
 b=ZSpRL+FNHaT1txNBbKHCgIVM3mH5lt+VJO2ZkLkgj4glV/zchJUaUgtA4Nnx8899WWGdTe/Aqxq/T0TEHqlUQa4g/kMJMZWiKS71+C/7OvsQbqgG/IkVtpLuna8LXCBNznBHN4+qJyXX1nSNSkf1dMeWH3S+Sg+RnTwcv1g8nCyZ/+Wtlx7OotOjwwkQyPv3RbyqWreGzEKFjQqRQGRLw4M+QAMkd9W9pCU+JW9vBTpowCq7o2F2SgyrfQ8DR9swzEiIr2ZfOYrnolaqFUffegb+BcdKrTUkX48S2mHG3Rs+jQ8yjOpe8r6xYAT7ISBHItb0bAxuMfWwr3AymfC9Vg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS8PR04MB8481.eurprd04.prod.outlook.com (2603:10a6:20b:349::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 19:44:12 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8534.048; Mon, 31 Mar 2025
 19:44:12 +0000
Date: Mon, 31 Mar 2025 22:44:09 +0300
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
Message-ID: <20250331194409.xllksyzfirm52x5z@skbuf>
References: <20250331153906.642530-1-vladimir.oltean@nxp.com>
 <Z-q44uKCRUtWmojl@shell.armlinux.org.uk>
 <20250331155436.zmor5g3h67773qcc@skbuf>
 <Z-q9BCY9MUzLv-LE@shell.armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-q9BCY9MUzLv-LE@shell.armlinux.org.uk>
X-ClientProxiedBy: VI1P189CA0027.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::40) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS8PR04MB8481:EE_
X-MS-Office365-Filtering-Correlation-Id: 94c007ac-ce0f-493c-7e30-08dd708c6948
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0GSZvmnbQFrhkEJUjC9/Xowx0Fi25sOfFDK0k2V13X4sy6n256Jma/GCbfdi?=
 =?us-ascii?Q?tPX941E7DEGiDCz6is7M462FSxaUZfkAGogcehg06oD9dUY3vL+Qj0iWjQqf?=
 =?us-ascii?Q?V757vXAu9cjsPOLDRb9yXRqds9E5IqNVMyQjDseWX1POX0X4Znbb/SlyFb+W?=
 =?us-ascii?Q?kj/joIrTYPETuRCZM8/tbKXC4zdP19q8lkicuXXFLJKO7Dg+UEU0hQwhipAg?=
 =?us-ascii?Q?r+6BHnkL8sADeu375w15SBcJI61AJsN8GF0kYX3meT428QMvZ8xGaVdMdpFl?=
 =?us-ascii?Q?518ACU44WifJu4D+dJBE1BPvV22l/K5oiPuzAGN0+jfvZ8wlolRjzPi1c+d3?=
 =?us-ascii?Q?0JuGwOfZww/dwxPaiGRVen0VDxJJfRLnV/0PP/SQv45/QGl38xL2Xd68zjsz?=
 =?us-ascii?Q?gqGZrcMOdxJhwtsoEDVKvXMG7slRatA93DdXDUyCRemiu3mcU97Unh86fdPb?=
 =?us-ascii?Q?lcaj5hLH147QgM3qnp7UjV1bc3RkmBhgjsmCn0OiUl/HUK54f1GyGESGLUQj?=
 =?us-ascii?Q?MG7n1BSezlHa50J7TraOlZgoXGJGkqU4Xe0gcc4K8oo2wy/EaYQAYo3c/m4e?=
 =?us-ascii?Q?MGEr9CZThXi30X7xK9N3m17/h53UuxCpmIQcfSj2W4/5U51AXDthrm0nA07z?=
 =?us-ascii?Q?3b7XhXtEdXRv0djeEwd/XffZSdwW+ItEtyEKCYoERYBex+2TOIXA1a7th1VH?=
 =?us-ascii?Q?eR/TA27l8f/rE+n74xqBFJh7V+K6XoGOP8KjxAT6MJ3EO6/LVbPUannqZIJN?=
 =?us-ascii?Q?GKMVbtD8nEnVuFwzFl1awJJtAq3f7H6Zp08cU5qe6OnYcFMF5o/TcNz56TBf?=
 =?us-ascii?Q?n3Z37LOFD09VvEP0EEe2lRuAuowUCHmD6YOlEtUoC3TT7Ko9GI+cRx9ozAir?=
 =?us-ascii?Q?LgBItHiapByvrtmscy9gMBGKDg962Q8fJbwr3Vd4ibj8yS13G5P8V31Po9l2?=
 =?us-ascii?Q?3oUUsSmXhSwlZM69YnYmOGsWWiLiAAS6jYBrtiWCBmea897yHwym+Yp5WVae?=
 =?us-ascii?Q?0CqGxdbHulilgAPl4QjYLSfRxH1LmZijcTdIGVQJ5yE/u+cj6dExPUPgGY7V?=
 =?us-ascii?Q?Iv880pUjmUK4HmDPfByG275d0S7Cs0mXHpWnYLkKrEh07iVfl0vqoTktC6cB?=
 =?us-ascii?Q?doVWJozDRDSbnpT3Kd7Z0xg7GeNv4qK1xZxeeyPEpNMZrf94dzmP0wYPfOPP?=
 =?us-ascii?Q?RVkStitvr+KjXUbPJvzHyhpHQzgcMq+UpeUGYBsUMhecDZX7rl1+nmIUpUW/?=
 =?us-ascii?Q?xgNpdFwBWvI2LnwQOYoTkd68AWJ77zJiFJ0hsBZscmBrZsq54dVaOrt+RyCZ?=
 =?us-ascii?Q?rEVKJQE+l9mYMEj2ekKt/AKPuKbnfl2vM4cMF5hq9Bvr6ffzn58jCjHarpXL?=
 =?us-ascii?Q?u8dVH/W3J1fJYpt0oLbiwB17tNlk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?svN2EJJ9+Z/L2mpFspBZ86buAZkW0LvSDFnz2XYCjWpAPA8iEJ8krHFfUXYb?=
 =?us-ascii?Q?4Ah8792yBcGjTlnl5b5Ab7EGW3MK+KPbbMefBUmuWSPVv3YBlVFWkElqFmOj?=
 =?us-ascii?Q?njDPtMgIljVaP8xSTdYSmm4ISj3jbAx298j28h+LV0TdWsDJqgEPwn4Iw/z3?=
 =?us-ascii?Q?GrGhRl7uLOV62betkTTfXXawTMY/AGRtf9XWPWkPAvbEL0B7xsZyqnP1FYIe?=
 =?us-ascii?Q?brGp6SDstBpSccZg8VKPO0o9tQGSKpzILn0HXbA0SSQ4KERK6EyH+iLeH+NL?=
 =?us-ascii?Q?+cx9TZKHEWGD9r8kNpkWfe4utPItV/01PT0V9JNp0DT9UlbOsKeCMAUT1s3e?=
 =?us-ascii?Q?k7o4JGo/VvIdvEnlcXXAJamm0VQj2ShXueOFxFjEbUriRyyajItt3v3/BFdt?=
 =?us-ascii?Q?h2ADE/f/RQywf2McmDYd0bqwBsCvyDsCZUqe+6FAljgGvixRiPKUoyk/wRHu?=
 =?us-ascii?Q?EIvC8hF/copMjy9fmLA9oTt2TbuF9APuniQvV+prSUjcoUWnog1dMQMPh+6T?=
 =?us-ascii?Q?WsVmVa/nyP4JphFpWuBj0DVCU0ybr9dTsaRSaWmYc6jQnKNeC20p6iP/fkXA?=
 =?us-ascii?Q?T/BCFSUE3awLlfXAWOym/6z8WaiYrESQrWEqzi3oV6z1t9zw2YK82tv+tO7B?=
 =?us-ascii?Q?3aWYeOkm6VHITjYaKJ7Hew6JbiMKdV9hDxGdMJ1D4FZ8yCk/YlHv50X1s/Lz?=
 =?us-ascii?Q?E/4KkRV2Qj2M3qBTb4+tmd2EY+fYl6eChgjYNVyjK/ejWEBeXVefZnT/scvy?=
 =?us-ascii?Q?R8rEDe3lks9wEo4AgCAR+Q5XIypXZe2ZBQe7M4ik6NTPeAOkjRKGW5WETUYt?=
 =?us-ascii?Q?eo/t6W2DB2Vq9gVuJ76Ib3LxweTJpGy2i7s1HLWGNjgdWUvDlOGR7LqeX8qz?=
 =?us-ascii?Q?bpg4FSeS/yoq0qV4hdYGce2B546oDOTN1pa1VSIBRuyjXQjZ2I1MMmOSeY7Y?=
 =?us-ascii?Q?OT7H6zm+mCA5PoGCh4hXpuPlaBdS/YTXJl8LhD8OGLvqDJn6To24XPDbY4vE?=
 =?us-ascii?Q?0UO/5UgZ/I8bM5YVoiy33zMbsmC2SGhxN/C3Ehwza+RHAq8U4+bpvf3NSdg0?=
 =?us-ascii?Q?MgQlPe1UnYZpBB1MDaHE/owdlqhKi9tM4JesxnzaFN7LwbQqX+4d7gURozN2?=
 =?us-ascii?Q?fBPf/CK9Jv2dFnzl7zbWbUvhAgeDH7uaU/WKSTMgm/cbqMEiHOQYdjXQmFRL?=
 =?us-ascii?Q?uHzE0nOZxf861REie3ZXNei8mP1Y9ky2hqbmVI9LeyZD3qwLajUT7FwEu/li?=
 =?us-ascii?Q?PDXdi9VQ5ii2F+HTKwFSnmp15/fnVySPoiQr43KwnnQPcggm1Bvbo/+FRQhi?=
 =?us-ascii?Q?NzF6W4aCu6d6eRhvP4Ww5uQrk+QypO5/0XFVeP8WijDzPxHSgitl0E+FudVE?=
 =?us-ascii?Q?GV5uJJf5NeyegVPQgneTfyRDSv+9zmE1bGfyiOp/VA8aj12FWWosN6w2cTQ3?=
 =?us-ascii?Q?h4XT5IoFx6Pj+iMonXxScqjeIO5DAs7rJiBMvDYQJER0UwkN72XtoDkJxBoQ?=
 =?us-ascii?Q?4Cxbm7aRjtjEec2Vebh5sZ4fyFd0+qDklDm31rY9OA1bh0xxqzSG90Ti/Q+2?=
 =?us-ascii?Q?7Th0Su//5xYlVumFSHtIAjY/Asz9mjs1h7hPCFZp0T0K9P1BfuTM9T4j4Qxj?=
 =?us-ascii?Q?nA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94c007ac-ce0f-493c-7e30-08dd708c6948
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 19:44:12.2778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p84y+CGlDBr4xO5dMY1sNzu+6eWjnqlQCrdbYoBjQreEC2ujQVu+1Iiak7KjauLm7XljGHMxcn88JLgeBsY2ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8481

On Mon, Mar 31, 2025 at 05:04:20PM +0100, Russell King (Oracle) wrote:
> Oh no. A feature merged that didn't get any users, which happened six
> months ago. :(
> 
> Can we please have a user of it in mainline soon?

Yes, that looks easily possible. I'll send two patches when net-next
opens.

