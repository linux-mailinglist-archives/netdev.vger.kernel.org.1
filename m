Return-Path: <netdev+bounces-244639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F08CBBEC6
	for <lists+netdev@lfdr.de>; Sun, 14 Dec 2025 19:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79E02300C2A5
	for <lists+netdev@lfdr.de>; Sun, 14 Dec 2025 18:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159392E62CE;
	Sun, 14 Dec 2025 18:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QOrSnVuq"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011051.outbound.protection.outlook.com [52.101.70.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A519030C633
	for <netdev@vger.kernel.org>; Sun, 14 Dec 2025 18:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765736758; cv=fail; b=FIKJolcJE7mr17LwOyTPGY0x3ljSaYPt/IRmgwGehUzACIIK2m6OpCL8SuCpdRVfn2GWXt0qryEu2iJaR/9ZcqX6Pv1hCn0nU+NUY8EnE1Rb3cWR74JPhIS4GUSFna1dhHHXbHYdE864wdcWtxjSDWcMiLc1Q31AvUKXqYmNmK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765736758; c=relaxed/simple;
	bh=UlYHPieR+9DAFlAMtJNlsraViOa4H4g8EpmTwneIGDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sIIKHHKj1COnstWTAXSFPQ4amIMaAa5BiQCvfgCxk/8ewjSQI4pf2+0HC81t4EPUit0tr23XeH7GbRSUAbT/ZD/cu+LYiUtorI07+sPelTonvlY4F5KgokcArdX+CRPqhiolXQABWFoS7UEvAXZfkmrcaHczmfe3wNx7sYn2tyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QOrSnVuq; arc=fail smtp.client-ip=52.101.70.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FlHjiIK6XomhNristI1ENboy6cXWP1BBdOmbizFyLOa3L+c9eO2fu/Is5SjIGLc/Jm9KssnZIXe9fmtw/OPXctuAZtG4r4bFRTkqVdA9EORfWDIrctIUllaP5TxgkEBUYkeky8XLYzuz8bk8gJfOL5/I1yfRAesZdvwjt2ywVMy0OLkxGxZyLo+luYhMfSfsNnVmfT93M40Pm+yw+Gyqi6VsGE5CNM1f/v/NChRm8N9bZOLz/joxwnBteVKKt8B48BEmyNuIeLNBzLL4eUvNJ9I/z46rn0/b7qMAHVP6fdx2CVjePcanT1uFxeBhYpeChxSJQSlCApdGnHA9T0phjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FvX7VHj13GsnIsLvm2+jE6cv16vjlfvEjLpw/A9SS2s=;
 b=ot0mikajJkipyLPNbDeeIUVQ9qw+uLTnsSd4Ras3IgqT+2rS9lEgBhJwnRvzQHf87X3XnDBvY53/q6FAMUuDSxEuf/ZJtvLRw1pSz35xk6jlwTnFwI1J2ttsaxHaKc+r7cmF+WjMNRugxpZNiJGWGtahiSPcAs1sPv9l1/HWru2+qYoc67eMzv9lXTwtyrnLhvLGIm8SaFN7i3d1CAc6t/272tjllhksutxGJjHvLuihoubiyVH101Lrq+Rx4m90jTTlGiNkrBzzs5W7XFGxuu2igMA2UBNxA2CZiq4YWPrP5yA6Zp/r//uyXdQSYRISKecMhHiDROV6B7pDz20Xuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FvX7VHj13GsnIsLvm2+jE6cv16vjlfvEjLpw/A9SS2s=;
 b=QOrSnVuqRCEBY7HS2hHm0kCtQvaIHqyojbvQR1cIUs5JY/gZsEgqMWrJ985gKTAWzKpRqoVMoAUt2Nz8RCzD4C1kmJd8G795de3dJHU5UvKfdC0X5t5WibtuJfScRDDQwiZyylmesZDEDXuUmyuSLJLyb9rZy+CzaGlpoxCEt3uQzm8SJC4suwCOUn/KgcB9dgHa1NBBFcxGkj+IvoX59j0GzmtWt/AdSNhwduQL6VxVoPWFkp/JQemGZdQzRL3nCcWFbEnF2R10Vi2lkQMnq9zipf9h7+cXZULPGRyYa935C2Kw1cP4HHGB2QyRR2kHYowKW/RaNUT9RpdZoajDNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AS8PR04MB8038.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Sun, 14 Dec
 2025 18:25:50 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9412.011; Sun, 14 Dec 2025
 18:25:50 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ma Ke <make24@iscas.ac.cn>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH net 2/2] net: dsa: fix missing put_device() in dsa_tree_find_first_conduit()
Date: Sun, 14 Dec 2025 20:24:49 +0200
Message-ID: <20251214182449.3900190-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251214182449.3900190-1-vladimir.oltean@nxp.com>
References: <20251214182449.3900190-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0223.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::44) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AS8PR04MB8038:EE_
X-MS-Office365-Filtering-Correlation-Id: 07abed99-41ec-4acf-e15f-08de3b3e358d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|10070799003|1800799024|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AjdWpHAH3yiYaSOnVV5i/R/TRHRY9TXpTTJK4RKS8FbXc1XwN9LrvDZOEE8s?=
 =?us-ascii?Q?0E9fGS824/rxlYXt49BJ8PbgeB1Uj1JzbQKF/EwQU1n9BEiFMaDwecduaAmf?=
 =?us-ascii?Q?12y93i+ZdIzRPUJsF8qZ3/xouy4A32PrIOwTJei7bfiEBzT1lwVeGBzEUQlD?=
 =?us-ascii?Q?68nlSmKFO0ZOcuM+n5CT8tv+o7BWKwwP/AN0wpwP5NgUM/uhhnIjzRMTC3m9?=
 =?us-ascii?Q?NfGJyWwpjzHJbBKkYrNos997Y7KnQkZoBaODDXE+LHvzDatqvK3eGv7E7z8D?=
 =?us-ascii?Q?yVfIni3W+Uv46bCMeX3ndwWB8nG5F1Qj9OUyYYIQ4oefVJtvv71iZJJo4yzE?=
 =?us-ascii?Q?uFcD1vMc79p0YtfSK5oq4/jnSHRNOd5da8d2p1FdvvMtQXlhoeZhEMpsTlo7?=
 =?us-ascii?Q?yVceuG7LLyAy33H78Gl67xG034b3XO95eaRmzHJXRH38gbdZRfhCPX+OcmYj?=
 =?us-ascii?Q?mhU/urGXU9OFpMYFwVid30rfFsMr5in9MQffAVPCPz6/SXI2cx6s9Z8GW5Jz?=
 =?us-ascii?Q?7aNEk3AmD8Msye3hWmDnlpr/GNtRejUIVsJUtGBLiop8pieuXW5DPSpzkLj8?=
 =?us-ascii?Q?7UpreVa+rT8x0LUt2sr8jVWy/jaY50waTqHmwOdBMCPqM5QVhqr9tTWoKUQQ?=
 =?us-ascii?Q?GxwmYdeSiMClij4POInt7Gvk+N8kqR7gY/f8Ds0FJZSylMx1xMEe8VWkaG7j?=
 =?us-ascii?Q?uwss9LWlxXzWMPqm5qCl9SXWatRDq9/WGQLta72sCY2Gv+v0a6kEC1M/AEKT?=
 =?us-ascii?Q?a2/i4b9yLAca+kDe49k9V5E4HBqKWwkEA/5d3PWUpnZtzbv3DK4X/BR2w9hK?=
 =?us-ascii?Q?qWXP4hWU2QmSBGau7XlmkgRdQPLR1W37wYFmfAU3J8oBabzML4rhfvWBD5xN?=
 =?us-ascii?Q?F0JpSMpUkIufYLwy78wQioZAYiTJZGdfqVd50O+F2KWtg0xPDA2Fh+27k5AX?=
 =?us-ascii?Q?r+ekxlCqIpAvESi0tmHfkV/xik3ivk3Mx9POaxoppfvo7ozsavvJJYScWSOW?=
 =?us-ascii?Q?d3rIuDbXiJEF5XD8TKFXNOebiCUdKqegtye7z7Np1fmV7CLTaJFGGKFyv8ND?=
 =?us-ascii?Q?BkzJ4rI+YAKmDP8zr+h2nO3KvG9fpTKzr9Q94oDMtL+vxxVZ+SGfYckoPIKQ?=
 =?us-ascii?Q?e22PvnHxayDfpLn3fYTkWiNtmql7IRSF4ENpssplk3+WKtoAcvRjRvLiA2uX?=
 =?us-ascii?Q?9CTxUBEPA4HoC19fjeOEI27Cmf/urOCRq0kpxcAXlaUxgQ5+pyHswxbqT4fi?=
 =?us-ascii?Q?rlp5Bm9zyGaJgRz6f2a6TgQvQ4WrNPbCYCMm08WTZDrKBQCI969yGnrf95z/?=
 =?us-ascii?Q?6bWXyTXbQXpVzLfTaeXMdExMMuGbocb+KLLpnIgWa/+5RthSKgZO0nOLb3Qt?=
 =?us-ascii?Q?DZD0obCela+8y/JpK6b54JByqbtzBL7T5xTKqEHw0vTAKIH7mTmTTggDQh0J?=
 =?us-ascii?Q?Y32fZJTl/4WIRtutA6YigVQ+QS065Ejh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(10070799003)(1800799024)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v1DbOvtPylYDIZwFULEgq4hEB1GaHxw90FUPL1VWuHu3TrvhRtYP+JSOfaZs?=
 =?us-ascii?Q?ENF0laWc+ypfsjIY5VN/ALPmDy87TPuQRtvwlakqsjlq8pbDhcFiaxR0kILE?=
 =?us-ascii?Q?92tmUTUTnz6oQi5zjW2Sl8gYUdX3Aej+d6XyyxnSh8QT37VMWdf/wjjxAZjR?=
 =?us-ascii?Q?oFVT2nk2LMHEqI71vdBGA29QwsCMEl+9pgRiJxkWdyGIQU0NP4RsfCtyHR5E?=
 =?us-ascii?Q?svpR14pmhVmmUONJznGixF1AZlDpWuUfAJiMBUMumd5ib5LMOXEY196vbASa?=
 =?us-ascii?Q?dVNYE2j1Ch0hTsYblb0qroAc1jENnDV9+YE8ywpMJYSixLqId+4fTNVt939s?=
 =?us-ascii?Q?1UTK6XdRnyPz5pmYlQlZWV929Sf3jKy/rhS1hSJPdRpsitm8ZyUFfoq8yCMJ?=
 =?us-ascii?Q?zt33pvKgv9uwCj2Mkwrmut9ONhzirzZf4bVTQcJBKfm2j2lw2CdVYnQ1S55g?=
 =?us-ascii?Q?dpO6w1HeMnTyDUp0KMt/TpSpomvF1oU1eS3fLbsqdXMoWO/Kgd+1FfomtcXr?=
 =?us-ascii?Q?mgPxfLQ8vSkuSiZ+cZGwunjtCK5AAIuk51biKYVpszbhMvHizsYOlXlIhihg?=
 =?us-ascii?Q?i954usgFtgP9+l+g2gcOB3e5lGEjgOshhGIZpKQN8NTpV0+bE+0KrhOc6M3k?=
 =?us-ascii?Q?rKYcGN/W7d3W8ZGLA9CqlAItdq4yzIRGi5EN121o5qd+XpC8DtaQTCgPlSMM?=
 =?us-ascii?Q?L8NcgUIY/o9u8uObNQuxwj+bCCFUTv+6c1CrSKeTjZ8Su5Sv7zLB0Tx874lN?=
 =?us-ascii?Q?PHvSANH1l3dd24qUYr8QmNyQhDCapkQwo19XMSEuxRTA7p1SucbxxoToqMD/?=
 =?us-ascii?Q?1X/Eh9XwrMUkTi3lx/XFgXdBtMBY1AZcyeU64Mzjw/5RYdQcQjHP2plLwbQp?=
 =?us-ascii?Q?b0UOfvfR0jFrdnuoXiwY4HPe9qNUSqpPC01frObtYP/YjSlRg261WTvTlz4D?=
 =?us-ascii?Q?oVeF3QZe8dH/CzIZpIxxHsNgZAyu5qOirkq/WsJ9+letj344VNE6F2vpNmi0?=
 =?us-ascii?Q?Zts09D1Z5/ToSgsJCT38CloPvepZGfHDhgvyIKc7aJz7NxpKl95a2lpVwde9?=
 =?us-ascii?Q?5ASVug7BThMe7xKHGK9fFguaGwN1OSwmpBJiOFdMs90FiNPY+dUMVG1oW0Js?=
 =?us-ascii?Q?gJtRv1gsVj0nagxWP3b2NdJiBFtmPw3l4FbzfquNIM8S+Z9xRjxBqpkNvBOc?=
 =?us-ascii?Q?QsVA2KqCSfRgKeNtRF/zaX+gZ65NZD6ukfOh1bYnp5uMtQgf78k5lamTa55r?=
 =?us-ascii?Q?Xp0TgF25+RxJehA5ss+bQo+XktC6MV4yDJmPYqlxhUVcj2XODgRJ2rmefAro?=
 =?us-ascii?Q?29ZazYTlMCgf2Bpi//qizZtA+vFQN1/GuL0Scz21I2nEJy5vpp+PZkjMYOH2?=
 =?us-ascii?Q?861i7B6wSuvJeC2wmx1CTuZPyeb9EQwpoYc86QSAzUVKbRZ66w9gSV8qNSoU?=
 =?us-ascii?Q?Ayr5nRfGgTOegGsUGBqtw9SrItgvtclqgkpFemL8cpRwJecUwPulOWwaY1zB?=
 =?us-ascii?Q?/UTH+B6bJtK5TQSSMU9gi3UN3o23MR5/wFHSbL2l+HxLTMFkIiGuTg9q01LO?=
 =?us-ascii?Q?ejqt2fdN1YTT2OOOps0gocVxr9wbNFqeDFD1F6X7Qjx4i1npy3EibU1D9+Hh?=
 =?us-ascii?Q?409Fth/rATKFQJNVPtLZZA2hjuK+l40Bka0L5RZbWSw1dWboEfSeS7aKE4sC?=
 =?us-ascii?Q?vSrfsg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07abed99-41ec-4acf-e15f-08de3b3e358d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2025 18:25:50.7110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0gAfjKX4JuCyB+iBZOJo/3GPz1oX0glPlzONdjwKOMwrfQfWcYdvoQAi9twlQIwx2IUKRsd0z/Fx0F/2Qpu8IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8038

of_find_net_device_by_node() searches net devices by their /sys/class/net/,
entry. It is documented in its kernel-doc that:

 * If successful, returns a pointer to the net_device with the embedded
 * struct device refcount incremented by one, or NULL on failure. The
 * refcount must be dropped when done with the net_device.

We are missing a put_device(&conduit->dev) which we could place at the
end of dsa_tree_find_first_conduit(). But to explain why calling
put_device() right away is safe is the same as to explain why the chosen
solution is different.

The code is very poorly split: dsa_tree_find_first_conduit() was first
introduced in commit 95f510d0b792 ("net: dsa: allow the DSA master to be
seen and changed through rtnetlink") but was first used several commits
later, in commit acc43b7bf52a ("net: dsa: allow masters to join a LAG").

Assume there is a switch with 2 CPU ports and 2 conduits, eno2 and eno3.
When we create a LAG (bonding or team device) and place eno2 and eno3
beneath it, we create a 3rd conduit (the LAG device itself), but this is
slightly different than the first two.

Namely, the cpu_dp->conduit pointer of the CPU ports does not change,
and remains pointing towards the physical Ethernet controllers which are
now LAG ports. Only 2 things change:
- the LAG device has a dev->dsa_ptr which marks it as a DSA conduit
- dsa_port_to_conduit(user port) finds the LAG and not the physical
  conduit, because of the dp->cpu_port_in_lag bit being set.

When the LAG device is destroyed, dsa_tree_migrate_ports_from_lag_conduit()
is called and this is where dsa_tree_find_first_conduit() kicks in.

This is the logical mistake and the reason why introducing code in one
patch and using it from another is bad practice. I didn't realize that I
don't have to call of_find_net_device_by_node() again; the cpu_dp->conduit
association was never undone, and is still available for direct (re)use.
There's only one concern - maybe the conduit disappeared in the
meantime, but the netdev_hold() call we made during dsa_port_parse_cpu()
(see previous change) ensures that this was not the case.

Therefore, fixing the code means reimplementing it in the simplest way.

I am blaming the time of use, since this is what "git blame" would show
if we were to monitor for the conduit's kobject's refcount remaining
elevated instead of being freed.

Tested on the NXP LS1028A, using the steps from
Documentation/networking/dsa/configuration.rst section "Affinity of user
ports to CPU ports", followed by (extra prints added by me):

$ ip link del bond0
mscc_felix 0000:00:00.5 swp3: Link is Down
bond0 (unregistering): (slave eno2): Releasing backup interface
fsl_enetc 0000:00:00.2 eno2: Link is Down
mscc_felix 0000:00:00.5 swp0: bond0 disappeared, migrating to eno2
mscc_felix 0000:00:00.5 swp1: bond0 disappeared, migrating to eno2
mscc_felix 0000:00:00.5 swp2: bond0 disappeared, migrating to eno2
mscc_felix 0000:00:00.5 swp3: bond0 disappeared, migrating to eno2

Fixes: acc43b7bf52a ("net: dsa: allow masters to join a LAG")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/dsa/dsa.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index ac7900113d2b..e3b233060242 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -367,16 +367,10 @@ static struct dsa_port *dsa_tree_find_first_cpu(struct dsa_switch_tree *dst)
 
 struct net_device *dsa_tree_find_first_conduit(struct dsa_switch_tree *dst)
 {
-	struct device_node *ethernet;
-	struct net_device *conduit;
 	struct dsa_port *cpu_dp;
 
 	cpu_dp = dsa_tree_find_first_cpu(dst);
-	ethernet = of_parse_phandle(cpu_dp->dn, "ethernet", 0);
-	conduit = of_find_net_device_by_node(ethernet);
-	of_node_put(ethernet);
-
-	return conduit;
+	return cpu_dp->conduit;
 }
 
 /* Assign the default CPU port (the first one in the tree) to all ports of the
-- 
2.43.0


