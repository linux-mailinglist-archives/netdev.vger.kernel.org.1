Return-Path: <netdev+bounces-196013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D587AAD31DE
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 11:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BADE16D20D
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 09:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B802D28AAE3;
	Tue, 10 Jun 2025 09:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="i7cx6frK"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011016.outbound.protection.outlook.com [40.107.130.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303D11FF5F9;
	Tue, 10 Jun 2025 09:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749547520; cv=fail; b=A7O4LQVwRBBPNI2vqQwrkdm+pOSCxnKGym1S/oSzFz0vF9Jyxs5UhoQXyU9m9lRD205WrJMm5JU2ZQOZ6ncF88lIGIptDEENpWJp47gFHFB2Of//nNcSisQeo5nLVH+NgTTCpW2SQcSeVqVzlisZtMvBnHa2eMxe2kI4/RbjbJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749547520; c=relaxed/simple;
	bh=afGPBRoFR8qn/SbRycHc7jptXjhADWpHyaSWWTqzeOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hVPzxdFV/VvFtmqZKeCrYE7nQ+GU4ZafxPPNW5DdRoUlwYeJKUtPUuIVn0nuv1Tv2FT8snVYm2WpC4Wl8mDLZLmlnDdZV/tSvRInNeME2q7TNnbUOn8wHEQbCR4zXMZKVJN9Sqff6H9OgY0gznDtmBV9PIZWNPcMZZWySqT/938=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=i7cx6frK; arc=fail smtp.client-ip=40.107.130.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZrbO4a3vFel4C0M2l4qSr7W+1pUwOv5shnPsQ6B4wWlPInSeboNGa6h6pdGZz2iMlI7SKQSiIxpr82IwlronN9GaV8+Zng4mxm1vplT0PpwFnIGeh85Jg/Uf/2UHl99/OH4HVhQPi3pQuimY8T6/mNuGHhP4KEc3mXn8+o4PheZE86X5R2wpT7XD6dssKG5TeRbI2TCZCtkbLheTBLxIEMFEzL+zoBPTwx4IjhNAHB0wPmPvpWelGK2oPc+BSwSNnsobdY8PpSsrRXBwtgtYrsfVyZD8vYgG2vH+l42/rvslww07vMx6d0YpU7Vu2CkSGNK6IGIoM0nNKFxWThiD7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KtSFHDqCsIkf1iQ7Dhwq+Rgln9mAb3UEoYp2yGhElrI=;
 b=ls9XeNZIRYxmtM2cdpAK0atQ829greeg3v25Pq4lwO3Tox7Ocry0Z/DZCPkTU8pQVHoZMKB3zHiJRZDzUs3N5UBzEL8xh5BNO/48UnfPTkxeC8lQ/r2ZwuDeYctJRhVXlDFpN8WgrMDT9epUNjZesg/QRmhUYarbvWPO5RuCHgcPRBkNouX2oW7C4Zfvp33uWTXD8A6Ta+NZA4EhhcikLGzMEQVc9cYo0Iwcnx5tHOUcteEPzfDNMqlKv8PhxGnjkw4Im2R+9dVej9S1tyBr94/r0DmfZXeFV36xCSyItiVxMXuXnbkqUyXkJ7JxE+yMs+thwWSv4cNS6j0k3z0IFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KtSFHDqCsIkf1iQ7Dhwq+Rgln9mAb3UEoYp2yGhElrI=;
 b=i7cx6frKXYpB7rAXkKLK/aXYxjXFptBrZboDPIn5rkIuPZfm83UXZq3FpPiGpZkDl0k3HoRRzojjarOjLMSNqRiBCzBy4iy8kd3x+hOFuNxDryt0lEE5OgGEz2jjz0BF79T7YTFCoNJbbB5fnfin1fzUYGe7Min+kBkdvrTgV9YTpcl52+ILLgYHXJ8eFLHGqrIliW5MYEjI9xXEVtE8psOX33B7siotyJuYbEHBAu2MG1sc8a0Y7jvFhLP1r/mB24DiaV4zlYVP/CiY9wQJFj52IT5iiYY9Z54zKPL7EqhipME30kO5mQ+X2ihpRI2LiF5L5hs+osoQFoqx8+XbbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DB9PR04MB8251.eurprd04.prod.outlook.com (2603:10a6:10:24f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.25; Tue, 10 Jun
 2025 09:25:14 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 09:25:14 +0000
Date: Tue, 10 Jun 2025 12:25:11 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Meghana Malladi <m-malladi@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Simon Horman <horms@kernel.org>,
	Guillaume La Roque <glaroque@baylibre.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Roger Quadros <rogerq@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, srk@ti.com,
	Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH net-next v10] net: ti: icssg-prueth: add TAPRIO offload
 support
Message-ID: <20250610092511.ggf2kqpdokzvn352@skbuf>
References: <20250502104235.492896-1-danishanwar@ti.com>
 <20250506154631.gvzt75gl2saqdpqj@skbuf>
 <5e928ff0-e75b-4618-b84c-609138598801@ti.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e928ff0-e75b-4618-b84c-609138598801@ti.com>
X-ClientProxiedBy: VI1PR0102CA0093.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::34) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DB9PR04MB8251:EE_
X-MS-Office365-Filtering-Correlation-Id: 714293a7-8042-4525-e97d-08dda800b4aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QjCuaEdW6Sag3CX7goWZ01RJanzjl71j+Nk6vkyeCrR08qqO4bFL5zbFPYeX?=
 =?us-ascii?Q?8A6uLLISX4otvGjATzoYu4piMT0Uz1wXAPrho++z4hk6D+IDy+x1/o2WRca8?=
 =?us-ascii?Q?E7MBGFCfHdGmLS/JMQdNo6rx+T+h/uw23RHDf6hvswiore1TI1nRPaPyDkvX?=
 =?us-ascii?Q?5wTmciKZeQNGPq5fvoti6SwNOA1p/8I1Bd2q3dOov/xA0dNPIlsQoruE4tq6?=
 =?us-ascii?Q?I1Dp4ypefxfyOXwQJUIqGFl/jniBFWERZRTYJTgo1z3d+FCyDj1jX3MrAJyR?=
 =?us-ascii?Q?hdj0ZXxXHvBpZyKOt73olFQ65Zvh0jERAgzu3iqt2zxyAQfXBrloI6a++GUj?=
 =?us-ascii?Q?CeOE4Nma2FO/fBdL/y5JG1RXo72es9NPvKJlOyd08yHA39lAzFVIiazXnhYT?=
 =?us-ascii?Q?xAlnj3R8YbCCJ1926mzI+9WQRLZgZRFoyfomdYA16sNCvkRMyWaJFhEEJtmu?=
 =?us-ascii?Q?7un0GPrOAkrWgZGiD/n/IG+Adwgc+1BX07lh+OyyztQUx2xO+MCySSiMmifK?=
 =?us-ascii?Q?9UXkXWXM169l+zncOJ44WySNJWEVYxEoCj05IN4nCnwYnF3ODht4VG/4fVHI?=
 =?us-ascii?Q?k6xcMjYR0QIPQNNqx5wTMGE8+M7GOjkh56HC3TzVMVWzrOeh3LYv2Et3jkgF?=
 =?us-ascii?Q?0XkLr4b4s/tO20Q++PBiQlgdFvPi7rhpSp4oamazcnhm1flZ1cH8JUa9M98s?=
 =?us-ascii?Q?JokQQeZJrG2OBG7+3FXgr6MEPqCTUXiwg9PdtrdC3z33CnepBXI1mtAEohPg?=
 =?us-ascii?Q?0DdW6QLEpPRt6FLfFr7QP/+adPcUbZ/an2o4qqUvuSUjdDEbBdx+nHdUx80Z?=
 =?us-ascii?Q?KhPWOu42rC3UfitYx2hv2uAwr8+ikt86I8vDi0VwO1hXnjFs487+oK/r4vLz?=
 =?us-ascii?Q?GTn9jdo2ils3nW5AsTgiszOGHIo8ooM8ApI38+U0pFuKL3TMz7uHyTLrmXoo?=
 =?us-ascii?Q?eO+7BPMhilqCdpCyLIOekvz6lV1wK7VFsIQR/ASCDgEfiHz2B0bTmt/Tt9ec?=
 =?us-ascii?Q?iA+gkMEj4CMSGr0XjRint7FWcqMmA9gLApwo84BIcr2Mmv+xonoey+t9uBnm?=
 =?us-ascii?Q?k9ovUc/qHvOBZJZeJDRqhfLXXQRprgQX8Lo0Af6shFrLnv93SJMrg3DTKvXm?=
 =?us-ascii?Q?KbEFN4ivZgieo8o4I/gv8j7d896e9sLMxOIZTtvUDV2z50KfkIl7owpRTavj?=
 =?us-ascii?Q?OKmBTb2dlwN0nu0jeK12nGaIkXgZ2U2vFfC/XEMn/Cq8AYJYOi7QBnkWMLKF?=
 =?us-ascii?Q?LQoK78D8zfpbII0tMGKJs1rNKvdHQvpnkEY8e6szKNMIDJjuVrxlqSfhOTHy?=
 =?us-ascii?Q?ZpexpMoFTcWVkvNNMavPZqBoK/bqFjxZr3XDo+2Q26Djhu65mpJmQdb6F7sr?=
 =?us-ascii?Q?L62ttbW1jL15TNQKUCbarntb6h/XSEfs/QscvIf0wfWPWG5HDlQPB+EKELOf?=
 =?us-ascii?Q?6AsOcSgImN4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MuVRWKr6JvI68xD9l62t0R372QXJCK1RyS8jLXh85op+TkRs2uUYqc9lAmOI?=
 =?us-ascii?Q?DC4CnhHQZ8nJ1ntZWDPeGA7UTDImUcK1ksLDrSr2rHrH0NbPmbiPG/6Ea2WZ?=
 =?us-ascii?Q?by8FVSx9qygRphoGKxn2z91TZRohgz6yVRkwH9orjVGl6g4xuTl1d90Ua696?=
 =?us-ascii?Q?owi0NyBto+S2dM4XYimmshP0sBk0M39fbPglm1shPYrGSZSqDkl1fhVTOpzp?=
 =?us-ascii?Q?QspeunFnI/Zx+EaIwevZocx9c8ekc3YF/XyRxRxNspK18HcMfZ4ntQzsm27d?=
 =?us-ascii?Q?6ErhpIhjOmM+Zp7QyPL9u4yp3PwcgKVRCIWrA0NxMEt1rC43DaGcdH6ZEKFy?=
 =?us-ascii?Q?ouN1JBAHl58Yo0M0Ks9siyG1hV47evdwr/ND0rklZwzvtAcXx8heSivTTTqI?=
 =?us-ascii?Q?MucRVr9o9rpXw8eU+WfxT1wyl9hiDvl87qFmDaPXiEyE+xdDftti9LvB8deD?=
 =?us-ascii?Q?yzHg8vn5Wl07ZrFy9ENJGgbxY4auEhNQl7Le2TKi6TVexDzMPx2gYtYJXo5q?=
 =?us-ascii?Q?LGl3ndH9wZ0Xd/UqLYU0qX/xs97Ss8FgLaB0SmWsWphbVDJF6pLTJIzSOeAQ?=
 =?us-ascii?Q?xoSI/Ug4gzXWpfns5cRv8U2ti7hdpaqkbDtd7h3loGFnkrtEo+G8MTnxBEN9?=
 =?us-ascii?Q?uMbWCtM0W9B0yKYD+z7WWrohNpKaaflPhsdV0OKb6C/INYzVvLkq4HgGKQT5?=
 =?us-ascii?Q?dvFkBrfainTqpuN+4Y+TYiVbUfFQ3IQfM1/fkhl7dU60jYXBQV2STqhs4XUe?=
 =?us-ascii?Q?B3JcNB6y+mvvqyd37tfXbgI0ElmdZjxBZ4ZU/+s7kOwdLzKdVH+b5y3R/IEg?=
 =?us-ascii?Q?dRfrlBVOmIDrX1kgApOVl+E7f/M3yEfVQ/CjKQZ7d74OVzrCTfsngp0cYGol?=
 =?us-ascii?Q?hoNcfJmXVLDv8p8aYxMBysoIaY9XK9w6DeD5Uoy6TQ5MpzdvYHXGuSmD2WP3?=
 =?us-ascii?Q?3N1n6uCuvBv6lSsytrFwLJVCeg6yLLRUKRhaVtWAVuEtqctVFz1rnOo3CxEa?=
 =?us-ascii?Q?OvgNF3/0y+bEe7f4ra5waODclWzqylP8q9v9IxZPZClpXNfQdSczbmQYn9Bw?=
 =?us-ascii?Q?ddaHpYCmwuj1iVt9Skys+YuBX1w9FNxd6q/SdrmMYRRR41IMKXooswFK8OxY?=
 =?us-ascii?Q?uD2TAtjKGL8qXuqGG30nSCM6SqOGTxVHW436HZ54SBC4ZCoXHjfpYL8t0mqZ?=
 =?us-ascii?Q?mKl4Wsgvc1reuB2vqEhO12+rGB5i2i+L/1yXx8mH+mq4O2wNh+jL2dHR5GAv?=
 =?us-ascii?Q?rI14t7+szd+DOF52iMmv3oHL9E9ddU6gA49hkvzG9fBZ2K/syT+LLuvESyAU?=
 =?us-ascii?Q?szvkuiWOhMwbyRIUYyMsCrMwkEi9Wc6s5XKDuBzoalKEDgCWs8/DeR0YZhzp?=
 =?us-ascii?Q?lA18k+K1Yab0Q1hQB1iGOIsatddJLdGMcmaCcCHtlmhiVa3ZZeoyDBWoHTFM?=
 =?us-ascii?Q?RIoVyBCysvYhrGnXjMgjlWMjmiKx3X/iS18WM7AosKzeo4QAvIRygG2y3+Ou?=
 =?us-ascii?Q?2MBYWTeSHTpassePbXGrlbDrrDcK91F+b+O+bQSe3EGW5KlAZjxjUAzbjV1l?=
 =?us-ascii?Q?MztKp0IUa7K79B1SXqhS7nuNYqbE6qAaM/kiRLJ6QXO4hU4xM7FSUzK7ky/U?=
 =?us-ascii?Q?Ww=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 714293a7-8042-4525-e97d-08dda800b4aa
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 09:25:14.2709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ccNRQx70YN8X92+7SIMD0ON+vin5leyKmwIz6ZpYc+Ckg4o692kMRSF4zAianGy4uqTyXKtUaVSGLhEC2yEEzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8251

On Thu, May 15, 2025 at 04:24:50PM +0530, MD Danish Anwar wrote:
> To compensate this, whatever extension firmware applies need to be added
> during current time calculation. Below is the code for that.
> 
>       ts += readl(prueth->shram.va + TIMESYNC_CYCLE_EXTN_TIME);
> 
> Now the current time becomes,
> 	counter0* 1ms + counter1 + EXTEND

What will the TIMESYNC_CYCLE_EXTN_TIME register read (and what is its
exact meaning)? Is its value derived from TAS_CONFIG_CYCLE_EXTEND? I'm
asking because the driver only writes TIMESYNC_CYCLE_EXTN_TIME to zero
(for a reason that isn't clear to me either).

