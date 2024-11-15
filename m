Return-Path: <netdev+bounces-145332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8424E9CF12F
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 17:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FD2F2909B6
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 16:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9A61D47C7;
	Fri, 15 Nov 2024 16:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nyGluqhz"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2049.outbound.protection.outlook.com [40.107.247.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933AA1BF37;
	Fri, 15 Nov 2024 16:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731687255; cv=fail; b=TDI3A12uBr52UhrLMxxX1qX03Zhi81C7zKBkyGLb1Q9whpLG6FCaXb9r8HM/zl6Vt+TzB+UOB6/5wrPv9lBF7tMiZ7TU5plzj23zkgCkzZF0jzflyuk1jn347IVbOguS9nAr4Z+1CcTy1CZpahQOBXctn6B/Oa3K1JHIm5iYm44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731687255; c=relaxed/simple;
	bh=QCnrZAS9CRwVXuUEoN7LTLEvcVddOeIy9Ywa0TQhzAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ShWBVKSpAiuJQGTWE8MwU9iM65KZ9NYPOsWNiNhRLp/c3+mIYd0JGNZgXHaWXc5aIcsVhy/uDUxl6bmH0aOXu1gmNxzh4mBEsPMH1A0fChGGlmUofSgAD53b9kVgAGdDJpJpntaOTgx+3VdzLJlV/0xYmFppPdQZaS9Rv5SrW/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nyGluqhz; arc=fail smtp.client-ip=40.107.247.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O5OTjDb/R+NfuuKsU5Ur5zoUXHjvUBbO4J9+IVcSiNtSv47lNGvSJ0/scq9EOBrbDkRJZr/f7A4mr1rOxytwdhlBTQ1LB2CpBA4Puk4l4+m4ZjHbglQaLfmBXdGiTvZ9QDFKbik+lKtPguf//dD/uxqw7N/ZxbUuhKSumbc3NOgE9UlZ7c9VLjiRrW/F8oq4LVBPGxgY6zf3T+a/iYcCCAyE6i2Vr1LzHFxTw5G9JhOKPuXfbGAOcARy+BkMyQfgvUquPz9LOEAGuy4OfU6Zj05Pwz771VKqCGp5903aOaPpCWf9+x27+r7E1Afg8hWrg2xyyKTL2i/d7ptYtuty9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yOXupctGr+Wsiz7kB37bCGp5a4Lp27tqlLJYLGBVvvo=;
 b=KCoW4s9/o5/oPSZkUkMy+IIo4EDG0xZmHTm5vBjPUbW2LXe9nN/Gr7srN4RIqRknV8SZxcDovF9TR0LfL/eHmjY1zB9LdZkJHZ/RHodWq4dEl4EXeQxA0X26QMvhCHCLF/xyTRV87vSIXL7kUhToqQFlRK6ceVpPr5zKt0xzIjleTUDVIlYwSCKOiiLs2/jyYFAkip10SYtpOC1+miKDWzijF58Tx0s7hmnfMrMUztJO4JUBVGT6f2wzQ68l3QQBZRtlAwqNGXsuJVQhyvpWYsNzbhwuLWte1PJep9kq5Q4YReNW3j7jghUNGaw+DtEwBhCKv0I2ytPKfVKxr+yfOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yOXupctGr+Wsiz7kB37bCGp5a4Lp27tqlLJYLGBVvvo=;
 b=nyGluqhzwwDipFU2LeWbuPCMejZ3zajIOoQJQIkidPthsVAzJMoJPE4TmNznOKsSQyiWB7RlclHJ95dAJyxBVSxlmbs7iVjzZyrpThhHvBTFF1RTuUt+99+8PQgF7RVu9YWXaUiSE0x0Vr4Qbm0e6yPIjuBnYU3LCORVUURCU/9tudbIkIrtFSS4pBhwerpd1Qeed9oyF7fTdwWXp3mrDTSmd5OQhJRybVkEVu1Fdm6k8sIc0MMKbQ8TSkkJOJ2f6sEMF79/Tf1wUMKQjxJFJC3Ls3o9jrP8htuAP8LhdKSccgqh6EB+gGUxNttJcInQN4YsOr1fyM9rkDZyULnAWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by GV1PR04MB9182.eurprd04.prod.outlook.com (2603:10a6:150:26::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 16:14:09 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc%6]) with mapi id 15.20.8158.013; Fri, 15 Nov 2024
 16:14:08 +0000
Date: Fri, 15 Nov 2024 18:14:01 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tristram Ha <tristram.ha@microchip.com>
Subject: Re: [PATCH net-next] net: phylink: improve phylink_sfp_config_phy()
 error message with empty supported
Message-ID: <20241115161401.2pfnbnsl2zv3euap@skbuf>
References: <20241114165348.2445021-1-vladimir.oltean@nxp.com>
 <54332f43-7811-426a-a756-61d63b54c725@lunn.ch>
 <ZzZCXMFRP5ulI1AD@shell.armlinux.org.uk>
Content-Type: multipart/mixed; boundary="lh7zb6nq6otmnhir"
Content-Disposition: inline
In-Reply-To: <ZzZCXMFRP5ulI1AD@shell.armlinux.org.uk>
X-ClientProxiedBy: VI1P195CA0058.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::47) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|GV1PR04MB9182:EE_
X-MS-Office365-Filtering-Correlation-Id: 11a0d2c3-6b3e-43ff-7d84-08dd05908677
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1JSNZqLTYrwydp8FyRqsqMHVTtuIqoMhGAkt7XrQbtjFghEYh0t4xdl0o35R?=
 =?us-ascii?Q?PFJCIFp1WvJIGY0k9u/QvJA2mx0XcKm9KfN43wp0GHyY+Rrak7eUUEpfDJG8?=
 =?us-ascii?Q?UDcdsO9woB2bjmSHxeJmgZRXaQRqLNlWXUhcN4tRmOjodXfaRsok2UMEl5Ka?=
 =?us-ascii?Q?MQDKzYKEKKUSKnHeOoqwaQbMNK5wYKfVubMSXuMPRyfSFi3iUHuTabGJNLJL?=
 =?us-ascii?Q?Mj1izFia2VFUmXqV6b+Ff7WWsTqAH09saN3kkeSwKWTmgFqA+5Mz4LcamclA?=
 =?us-ascii?Q?oqzMOrhe7VSDFy3Ir8vz9/mCiwhBbofN7OFFLCnqXS1qyNGm8T/qFF6gKgDZ?=
 =?us-ascii?Q?eqiNqy6w8IMuLo1QQ4ccH51emcQIfQ5z/vZASvIcJOgbl+ucgz8ta0NiQbk5?=
 =?us-ascii?Q?+TNiH0vLtaiswEeg+ffBwaQcFcDSt40JeEUkeuqW/P4AfqskY0F2wBui9BBW?=
 =?us-ascii?Q?adnlu7LRmRO7n/sQWiNY/m9m7ZtMMfluyc3adokugmKJ89pTBb32lS2hkAuB?=
 =?us-ascii?Q?yXzns6IN6/Vm5pGRgXNRl27yJTqoxaMHyh3eUFos2vjbcZR2+7G1YTUrNPnw?=
 =?us-ascii?Q?i+Whqbjxcr7xoK2B2/sQDUDjiPJsJJ9elmKFkJlxt6rCaH4As5iOoYv1GtjK?=
 =?us-ascii?Q?P1W6fkq/gFWGakUlQr3AR+2wQDYkMzdyqbf3EZKhzHvRwYx7flhz9b/qFx4w?=
 =?us-ascii?Q?ZxgK2HnyK6co7SM2wGvxRKdWa9lF/cI6bKLS/jdM0RVLerlvVfwUFPTJnScW?=
 =?us-ascii?Q?wXkfdSXqbe2A6ruxkIzgwJMcFb6eHf4RgqpCiIpkpDRZlRHdSwa/z/30+6K3?=
 =?us-ascii?Q?FgfAJeVjwMWvkCq5K54VBb+Gh7TNFsv88RRKOZKozBbR5QVyFcRjkhliP2vD?=
 =?us-ascii?Q?df7w9Ahf5STWHxRhCN4qmXwQ9qjsx5n/pViEFRF1K62QQzm1OkdZVhWKJTNT?=
 =?us-ascii?Q?T9spQfky7wqx41O3jRlfqNYEd2hNrW6Yf3Kah98Oc2pYo6th+3niez3hiNJb?=
 =?us-ascii?Q?jAxAhgXcPdbMSUnO/9p3eUy+tsDux/CamV9Sg15reMYCtDMOTV0SXWp+Otpc?=
 =?us-ascii?Q?pQW4PoXouVGsO6EingKOaJBfz7jtJO3x2tLh09BYlPbzpu1/7bI6RmIkJWi4?=
 =?us-ascii?Q?VipLgp9BCP23nqlrrRGgfnoNxPOwv/mX6KFLNM2ttI3p+KG0004soRCHNjHR?=
 =?us-ascii?Q?SRgSM4jXpGSOskLWrChAkmXbAZRvBisoSIx3nr97P3yfR0lTbTyHH0YjyYI+?=
 =?us-ascii?Q?5jyn95dKbDHNRiIZIWmO88jXQlHTci3xkLhiPiCiz2wteFJJOEBB4VBeFcre?=
 =?us-ascii?Q?vyIHrnQ8zBxCeKdLEg3nqZdL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aCSw8SqgV/ORQ1/GSjLsyM+lNw4ePTpuFoYYw//7AZyVZeNA014SoblpvhEJ?=
 =?us-ascii?Q?IVNdIiCPiSq2RTa3k31dctvvi6pbQC/pOo9MmZUjZ9oqDLwb+Z63GI7hKHtv?=
 =?us-ascii?Q?NgP72vYFuz8FEhatkFvDlZ2WA11Vl3Sqd6Z3NE7Ed6r+F82EWaqwUodhO/T3?=
 =?us-ascii?Q?13kVuYBjbazI0ATICpIGPOpfdKlh0SkAPg4+F+b+wZnCAunMkaInd936Y5jd?=
 =?us-ascii?Q?ILwhOB9fEYHDrEAI1FgwvU9t9vmWKZgLhkOGoP/INNS1pFJ7F5SBVZJbLkoW?=
 =?us-ascii?Q?Wqjxudx2ame92XPqI8R/RK1sz96JVQkaaGJXyr3BS1iiCfkb8cSIuqgOxySB?=
 =?us-ascii?Q?5G8AZXWqI4Gz8TwPoKHOIevCZHbdNpupLyQ8SqxKtnX43HONFCWmloYOR5DV?=
 =?us-ascii?Q?K1+fk9+FfnzbO5vwgnSkBuAGJiwQuF+k4hean75Eo2uuNU9DnnBwKRxrrjPd?=
 =?us-ascii?Q?xl5Q2CEO+ElMEwV/SM0KdKx+6URvh0il7+nbcCUKPUpRzMwlmI4voKoaeqWP?=
 =?us-ascii?Q?QmUKabKvRDBl2oMsTU0Kksiog5jr5lR36+3BKw4xJZhoA9mSFAsFVO77Am+t?=
 =?us-ascii?Q?aWCUwVUhlUfktDG/o3TTr9K/ea50dBdcSAtO6FZXZAMy8Hn1RGsHSvB1u+qS?=
 =?us-ascii?Q?SE5DQVJqsS34SPXGImYymGoiBMH2GMUV6cRAdmob+HbxdKAKMbpRe837RQdT?=
 =?us-ascii?Q?oktrPsJFKacRhmsd491t2HfEMJzDVI7jX+ftDY8FcwVaQNgqTqeZHCt8Y/sW?=
 =?us-ascii?Q?CsH6NVUlFLWhdyzt2YnE3g/crHoW07mrarRnT6hEIKbQoXLh0cAhShT0ADYo?=
 =?us-ascii?Q?bncp+TNAV4IDeBsCa4hc5Kz+kYJ8zmQ629FJEsImlUFiFywxfyEkeLaZbBlE?=
 =?us-ascii?Q?92NO6mtXw3k14JEsamltku+N4AVis1u/tv8wOxOYqFALmSDn0ENjqdcNIEaO?=
 =?us-ascii?Q?0YRFcI9S8hUy46IW3n/CKFvKtJ1ck/ylKwjr3heJdY0pV5ys2f83mBP0WQzk?=
 =?us-ascii?Q?EyYOHZsqo2zaFuKRM+5tXFwO/xbdCdwhc4NNkqAuP2bfRSoYGCArJnUoYNMh?=
 =?us-ascii?Q?a3MzMsSNGgaX8A+BDOTFXD3GYZEcSuKnuhf1aE1Q6HaUGZ2ArHTK0CJwy8P8?=
 =?us-ascii?Q?DDyxUa9l0/GUuidvCeTU4wDafoH8V7eSg2bcCknZfQhbtDy4GMj+Q5fsoSmJ?=
 =?us-ascii?Q?hCnaJRKeUu0MuyMuWT/o0dukL0mASZbxlyfI1ueuT0z3oiewU8/u268FJwl0?=
 =?us-ascii?Q?dWfc9EZ1rkehUrOU5tAckCuZWNoLblL7eJpMO+1KwAh5BGDX6urvEnfvJ/QD?=
 =?us-ascii?Q?0ut08VpX1gdG1W15pa49iAimPSibvLDO7l5U0H7YqCJou9FAmDN8kaBFbxIq?=
 =?us-ascii?Q?HDi6cK+GQfV1G62/eK+0PtLAvfDpiZgcn0fY9/fsJ4v6SgiPXsc9giBy0qzs?=
 =?us-ascii?Q?dP/fgtGvUqHQ9wmOsbc/f8gULKszt/+Snlv1kp90x8Y5l2C8XCDlZ1YtUlbU?=
 =?us-ascii?Q?RVtMyBLjsSoykx9bquK4f0kKsY1aeOJWdv1yFF06m1E/qmj6Vw0AA0z0o81/?=
 =?us-ascii?Q?M4K8xGti6DVfTHwTD/LC5Qzp7wkoh9SaArPmWirlLrtIS1wEARfusrDfbfFn?=
 =?us-ascii?Q?PA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11a0d2c3-6b3e-43ff-7d84-08dd05908677
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 16:14:08.1893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n5SlhGCyKV5Df0vHWlmWbgEVFDMNff6cAyxy4+mYUS3nc71USkltW3hyAejp7Xn5ApQv0B/1XmweHqPABuZZxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9182

--lh7zb6nq6otmnhir
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 14, 2024 at 06:33:00PM +0000, Russell King (Oracle) wrote:
> On Thu, Nov 14, 2024 at 06:38:13PM +0100, Andrew Lunn wrote:
> > > [   64.738270] mv88e6085 d0032004.mdio-mii:12 sfp: PHY i2c:sfp:16 (id 0x01410cc2) supports no link modes. Maybe its specific PHY driver not loaded?
> > > [   64.769731] sfp sfp: sfp_add_phy failed: -EINVAL
> > > 
> > > Of course, there may be other reasons due to which phydev->supported is
> > > empty, thus the use of the word "maybe", but I think the lack of a
> > > driver would be the most common.
> > 
> > I think this is useful.
> > 
> > I only have a minor nitpick, maybe in the commit message mention which
> > PHY drivers are typically used by SFPs, to point somebody who gets
> > this message in the right direction. The Marvell driver is one. at803x
> > i think is also used. Are then any others?
> 
> bcm84881 too. Not sure about at803x - the only SFP I know that uses
> that PHY doesn't make the PHY available to the host.

So which Kconfig options should I put down for v2? CONFIG_BCM84881_PHY
and CONFIG_MARVELL_PHY?

To avoid this "Please insert the name of your sound card" situation
reminiscent of the 90s, another thing which might be interesting to
explore would be for each PHY driver to have a stub portion always built
into the kernel, keeping an association between the phy_id/phy_id_mask
and the Kconfig information associated with it (Kconfig option, and
whether it was enabled or not).

This way we could eliminate the guesswork and the kernel would always
know and print to the user which driver, if any, could handle that PHY
ID, rather than rely on the user to know that there is a portion of the
PHY ID which needs to be masked out when searching the kernel sources
for a compatible driver.

Please see the attached patch an inelegant way in which I've actually
implemented this for the Marvell and BCM84881 drivers. My idea is to
move each driver's struct mdio_device_id to a separate stub file.
Ugly but definitely low in complexity. It produces this output:

[   64.515123] mv88e6085 d0032004.mdio-mii:12 sfp: PHY i2c:sfp:16 supports no link modes. Its driver, CONFIG_MARVELL_PHY, is compiled as module.
[   64.532233] sfp sfp: sfp_add_phy failed: -EINVAL

Let me know if something like this would be interesting to submit to
mainline.

--lh7zb6nq6otmnhir
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-net-phylink-pretty-print-Kconfig-name-and-status-of-.patch"

From 1f2a514fe6095e586203af5ffd1b0653d72d1513 Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Fri, 15 Nov 2024 18:08:56 +0200
Subject: [PATCH] net: phylink: pretty-print Kconfig name and status of PHY
 missing driver

Figuring out, based on the PHY ID, which driver is appropriate is not
always easy. This involves walking the source code and masking the PHY
ID we can get from sysfs or other places with the phy_driver phy_id_mask.

Typically users care about the PHY ID when there isn't a matching driver
already loaded. That's a problem, because exactly then is when the
kernel also has no idea what PHY driver might be adequate for a PHY ID.

My idea is to move each driver's struct mdio_device_id to a separate
stub file, always compiled into phylib. I've implemented this for the
Marvell and BCM84881 drivers, but it will have to scale for all PHY
drivers eventually. The good part is that it can be rolled out gradually,
and not all PHY drivers need to use this infrastructure from the get go.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/phy/Makefile           |  3 +
 drivers/net/phy/bcm84881.c         |  7 +--
 drivers/net/phy/bcm84881_stubs.c   | 10 ++++
 drivers/net/phy/bcm84881_stubs.h   |  3 +
 drivers/net/phy/marvell.c          | 28 +--------
 drivers/net/phy/marvell_stubs.c    | 32 ++++++++++
 drivers/net/phy/marvell_stubs.h    |  3 +
 drivers/net/phy/phy_driver_stubs.c | 96 ++++++++++++++++++++++++++++++
 drivers/net/phy/phy_driver_stubs.h | 17 ++++++
 drivers/net/phy/phylink.c          | 13 +++-
 include/linux/phy.h                |  2 +
 11 files changed, 181 insertions(+), 33 deletions(-)
 create mode 100644 drivers/net/phy/bcm84881_stubs.c
 create mode 100644 drivers/net/phy/bcm84881_stubs.h
 create mode 100644 drivers/net/phy/marvell_stubs.c
 create mode 100644 drivers/net/phy/marvell_stubs.h
 create mode 100644 drivers/net/phy/phy_driver_stubs.c
 create mode 100644 drivers/net/phy/phy_driver_stubs.h

diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index e6145153e837..123effc6fac9 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -14,6 +14,9 @@ endif
 # dedicated loadable module, so we bundle them all together into libphy.ko
 ifdef CONFIG_PHYLIB
 libphy-y			+= $(mdio-bus-y)
+libphy-y			+= phy_driver_stubs.o
+libphy-y			+= bcm84881_stubs.o
+libphy-y			+= marvell_stubs.o
 # the stubs are built-in whenever PHYLIB is built-in or module
 obj-y				+= stubs.o
 else
diff --git a/drivers/net/phy/bcm84881.c b/drivers/net/phy/bcm84881.c
index 97da3aee4942..436c028074ca 100644
--- a/drivers/net/phy/bcm84881.c
+++ b/drivers/net/phy/bcm84881.c
@@ -16,6 +16,8 @@
 #include <linux/module.h>
 #include <linux/phy.h>
 
+#include "bcm84881_stubs.h"
+
 enum {
 	MDIO_AN_C22 = 0xffe0,
 };
@@ -251,11 +253,6 @@ static struct phy_driver bcm84881_drivers[] = {
 
 module_phy_driver(bcm84881_drivers);
 
-/* FIXME: module auto-loading for Clause 45 PHYs seems non-functional */
-static struct mdio_device_id __maybe_unused bcm84881_tbl[] = {
-	{ 0xae025150, 0xfffffff0 },
-	{ },
-};
 MODULE_AUTHOR("Russell King");
 MODULE_DESCRIPTION("Broadcom BCM84881 PHY driver");
 MODULE_DEVICE_TABLE(mdio, bcm84881_tbl);
diff --git a/drivers/net/phy/bcm84881_stubs.c b/drivers/net/phy/bcm84881_stubs.c
new file mode 100644
index 000000000000..cb646c8b89fd
--- /dev/null
+++ b/drivers/net/phy/bcm84881_stubs.c
@@ -0,0 +1,10 @@
+#include "bcm84881_stubs.h"
+#include "phy_driver_stubs.h"
+
+/* FIXME: module auto-loading for Clause 45 PHYs seems non-functional */
+struct mdio_device_id __maybe_unused bcm84881_tbl[] = {
+	{ 0xae025150, 0xfffffff0 },
+	{ },
+};
+
+PHY_DRIVER_STUBS(bcm84881_tbl, CONFIG_BCM84881_PHY);
diff --git a/drivers/net/phy/bcm84881_stubs.h b/drivers/net/phy/bcm84881_stubs.h
new file mode 100644
index 000000000000..d28797596720
--- /dev/null
+++ b/drivers/net/phy/bcm84881_stubs.h
@@ -0,0 +1,3 @@
+#include <linux/mod_devicetable.h>
+
+extern struct mdio_device_id __maybe_unused bcm84881_tbl[];
diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index cd50cd6a7f75..b3313bb8681b 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -38,6 +38,8 @@
 #include <asm/irq.h>
 #include <linux/uaccess.h>
 
+#include "marvell_stubs.h"
+
 #define MII_MARVELL_PHY_PAGE		22
 #define MII_MARVELL_COPPER_PAGE		0x00
 #define MII_MARVELL_FIBER_PAGE		0x01
@@ -4143,30 +4145,4 @@ static struct phy_driver marvell_drivers[] = {
 
 module_phy_driver(marvell_drivers);
 
-static struct mdio_device_id __maybe_unused marvell_tbl[] = {
-	{ MARVELL_PHY_ID_88E1101, MARVELL_PHY_ID_MASK },
-	{ MARVELL_PHY_ID_88E3082, MARVELL_PHY_ID_MASK },
-	{ MARVELL_PHY_ID_88E1112, MARVELL_PHY_ID_MASK },
-	{ MARVELL_PHY_ID_88E1111, MARVELL_PHY_ID_MASK },
-	{ MARVELL_PHY_ID_88E1111_FINISAR, MARVELL_PHY_ID_MASK },
-	{ MARVELL_PHY_ID_88E1118, MARVELL_PHY_ID_MASK },
-	{ MARVELL_PHY_ID_88E1121R, MARVELL_PHY_ID_MASK },
-	{ MARVELL_PHY_ID_88E1145, MARVELL_PHY_ID_MASK },
-	{ MARVELL_PHY_ID_88E1149R, MARVELL_PHY_ID_MASK },
-	{ MARVELL_PHY_ID_88E1240, MARVELL_PHY_ID_MASK },
-	{ MARVELL_PHY_ID_88E1318S, MARVELL_PHY_ID_MASK },
-	{ MARVELL_PHY_ID_88E1116R, MARVELL_PHY_ID_MASK },
-	{ MARVELL_PHY_ID_88E1510, MARVELL_PHY_ID_MASK },
-	{ MARVELL_PHY_ID_88E1540, MARVELL_PHY_ID_MASK },
-	{ MARVELL_PHY_ID_88E1545, MARVELL_PHY_ID_MASK },
-	{ MARVELL_PHY_ID_88E3016, MARVELL_PHY_ID_MASK },
-	{ MARVELL_PHY_ID_88E6250_FAMILY, MARVELL_PHY_ID_MASK },
-	{ MARVELL_PHY_ID_88E6341_FAMILY, MARVELL_PHY_ID_MASK },
-	{ MARVELL_PHY_ID_88E6390_FAMILY, MARVELL_PHY_ID_MASK },
-	{ MARVELL_PHY_ID_88E6393_FAMILY, MARVELL_PHY_ID_MASK },
-	{ MARVELL_PHY_ID_88E1340S, MARVELL_PHY_ID_MASK },
-	{ MARVELL_PHY_ID_88E1548P, MARVELL_PHY_ID_MASK },
-	{ }
-};
-
 MODULE_DEVICE_TABLE(mdio, marvell_tbl);
diff --git a/drivers/net/phy/marvell_stubs.c b/drivers/net/phy/marvell_stubs.c
new file mode 100644
index 000000000000..f4770c9b38f7
--- /dev/null
+++ b/drivers/net/phy/marvell_stubs.c
@@ -0,0 +1,32 @@
+#include <linux/marvell_phy.h>
+
+#include "marvell_stubs.h"
+#include "phy_driver_stubs.h"
+
+struct mdio_device_id __maybe_unused marvell_tbl[] = {
+	{ MARVELL_PHY_ID_88E1101, MARVELL_PHY_ID_MASK },
+	{ MARVELL_PHY_ID_88E3082, MARVELL_PHY_ID_MASK },
+	{ MARVELL_PHY_ID_88E1112, MARVELL_PHY_ID_MASK },
+	{ MARVELL_PHY_ID_88E1111, MARVELL_PHY_ID_MASK },
+	{ MARVELL_PHY_ID_88E1111_FINISAR, MARVELL_PHY_ID_MASK },
+	{ MARVELL_PHY_ID_88E1118, MARVELL_PHY_ID_MASK },
+	{ MARVELL_PHY_ID_88E1121R, MARVELL_PHY_ID_MASK },
+	{ MARVELL_PHY_ID_88E1145, MARVELL_PHY_ID_MASK },
+	{ MARVELL_PHY_ID_88E1149R, MARVELL_PHY_ID_MASK },
+	{ MARVELL_PHY_ID_88E1240, MARVELL_PHY_ID_MASK },
+	{ MARVELL_PHY_ID_88E1318S, MARVELL_PHY_ID_MASK },
+	{ MARVELL_PHY_ID_88E1116R, MARVELL_PHY_ID_MASK },
+	{ MARVELL_PHY_ID_88E1510, MARVELL_PHY_ID_MASK },
+	{ MARVELL_PHY_ID_88E1540, MARVELL_PHY_ID_MASK },
+	{ MARVELL_PHY_ID_88E1545, MARVELL_PHY_ID_MASK },
+	{ MARVELL_PHY_ID_88E3016, MARVELL_PHY_ID_MASK },
+	{ MARVELL_PHY_ID_88E6250_FAMILY, MARVELL_PHY_ID_MASK },
+	{ MARVELL_PHY_ID_88E6341_FAMILY, MARVELL_PHY_ID_MASK },
+	{ MARVELL_PHY_ID_88E6390_FAMILY, MARVELL_PHY_ID_MASK },
+	{ MARVELL_PHY_ID_88E6393_FAMILY, MARVELL_PHY_ID_MASK },
+	{ MARVELL_PHY_ID_88E1340S, MARVELL_PHY_ID_MASK },
+	{ MARVELL_PHY_ID_88E1548P, MARVELL_PHY_ID_MASK },
+	{ }
+};
+
+PHY_DRIVER_STUBS(marvell_tbl, CONFIG_MARVELL_PHY);
diff --git a/drivers/net/phy/marvell_stubs.h b/drivers/net/phy/marvell_stubs.h
new file mode 100644
index 000000000000..2ba1f5af526f
--- /dev/null
+++ b/drivers/net/phy/marvell_stubs.h
@@ -0,0 +1,3 @@
+#include <linux/mod_devicetable.h>
+
+extern struct mdio_device_id __maybe_unused marvell_tbl[];
diff --git a/drivers/net/phy/phy_driver_stubs.c b/drivers/net/phy/phy_driver_stubs.c
new file mode 100644
index 000000000000..bffb9788d2b9
--- /dev/null
+++ b/drivers/net/phy/phy_driver_stubs.c
@@ -0,0 +1,96 @@
+#include <linux/phy.h>
+
+#include "phy_driver_stubs.h"
+
+struct phy_driver_stub {
+	u32 phy_id;
+	u32 phy_id_mask;
+	const char *kconfig_name;
+	const char *kconfig_status;
+	struct list_head list;
+};
+
+static LIST_HEAD(phy_driver_stubs);
+static DEFINE_MUTEX(phy_driver_stubs_lock);
+
+int phy_driver_stubs_register(const struct mdio_device_id *device_tbl,
+			      const char *kconfig_name,
+			      const char *kconfig_status)
+{
+	size_t i;
+
+	mutex_lock(&phy_driver_stubs_lock);
+
+	for (i = 0; device_tbl[i].phy_id_mask; i++) {
+		struct phy_driver_stub *stub;
+
+		stub = kzalloc(sizeof(*stub), GFP_KERNEL);
+		if (!stub) {
+			while (--i >= 0) {
+				stub = list_last_entry(&phy_driver_stubs,
+						       struct phy_driver_stub,
+						       list);
+				list_del(&stub->list);
+				kfree(stub);
+			}
+			mutex_unlock(&phy_driver_stubs_lock);
+			return -ENOMEM;
+		}
+
+		stub->phy_id = device_tbl[i].phy_id;
+		stub->phy_id_mask = device_tbl[i].phy_id_mask;
+		stub->kconfig_name = kconfig_name;
+		stub->kconfig_status = kconfig_status;
+		list_add_tail(&stub->list, &phy_driver_stubs);
+	}
+
+	mutex_unlock(&phy_driver_stubs_lock);
+
+	return 0;
+}
+
+const char *phy_library_driver_kconfig_name(u32 phy_id)
+{
+	const char *kconfig_name = NULL;
+	struct phy_driver_stub *stub;
+
+	mutex_lock(&phy_driver_stubs_lock);
+
+	list_for_each_entry(stub, &phy_driver_stubs, list) {
+		if ((phy_id & stub->phy_id_mask) != stub->phy_id)
+			continue;
+
+		/* Safe to return this pointer after unlocking the mutex,
+		 * because we never remove the stubs from memory
+		 */
+		kconfig_name = stub->kconfig_name;
+		break;
+	}
+
+	mutex_unlock(&phy_driver_stubs_lock);
+
+	return kconfig_name;
+}
+
+const char *phy_library_driver_kconfig_status(u32 phy_id)
+{
+	const char *kconfig_status = NULL;
+	struct phy_driver_stub *stub;
+
+	mutex_lock(&phy_driver_stubs_lock);
+
+	list_for_each_entry(stub, &phy_driver_stubs, list) {
+		if ((phy_id & stub->phy_id_mask) != stub->phy_id)
+			continue;
+
+		/* Safe to return this pointer after unlocking the mutex,
+		 * because we never remove the stubs from memory
+		 */
+		kconfig_status = stub->kconfig_status;
+		break;
+	}
+
+	mutex_unlock(&phy_driver_stubs_lock);
+
+	return kconfig_status;
+}
diff --git a/drivers/net/phy/phy_driver_stubs.h b/drivers/net/phy/phy_driver_stubs.h
new file mode 100644
index 000000000000..66b1165a658b
--- /dev/null
+++ b/drivers/net/phy/phy_driver_stubs.h
@@ -0,0 +1,17 @@
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+
+int phy_driver_stubs_register(const struct mdio_device_id *device_tbl,
+			      const char *kconfig_name,
+			      const char *kconfig_status);
+
+#define PHY_DRIVER_STUBS(device_id_tbl, kconfig_name)			\
+static int __init phy_driver_register_stubs(void)			\
+{									\
+	return phy_driver_stubs_register(device_id_tbl,			\
+					 __stringify(kconfig_name),	\
+					 IS_MODULE(kconfig_name) ? "compiled as module" : \
+					 IS_BUILTIN(kconfig_name) ? "built into the kernel" : \
+					 "disabled");			\
+}									\
+module_init(phy_driver_register_stubs)
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index efeff8733a52..ea8f8a47d11a 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -3220,8 +3220,17 @@ static int phylink_sfp_config_phy(struct phylink *pl, u8 mode,
 
 	linkmode_copy(support, phy->supported);
 	if (linkmode_empty(support)) {
-		phylink_err(pl, "PHY %s (id 0x%.8lx) supports no link modes. Maybe its specific PHY driver not loaded?\n",
-			    phydev_name(phy), (unsigned long)phy->phy_id);
+		const char *kconfig_name;
+
+		kconfig_name = phy_library_driver_kconfig_name(phy->phy_id);
+		if (kconfig_name) {
+			phylink_err(pl, "PHY %s supports no link modes. Its driver, %s, is %s.\n",
+				    phydev_name(phy), kconfig_name,
+				    phy_library_driver_kconfig_status(phy->phy_id));
+		} else {
+			phylink_err(pl, "PHY %s (id 0x%.8lx) supports no link modes, and appears to have no known driver\n",
+				    phydev_name(phy), (unsigned long)phy->phy_id);
+		}
 		return -EINVAL;
 	}
 
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 1e4127c495c0..c4ab5a1d225e 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2214,5 +2214,7 @@ module_exit(phy_module_exit)
 
 bool phy_driver_is_genphy(struct phy_device *phydev);
 bool phy_driver_is_genphy_10g(struct phy_device *phydev);
+const char *phy_library_driver_kconfig_name(u32 phy_id);
+const char *phy_library_driver_kconfig_status(u32 phy_id);
 
 #endif /* __PHY_H */
-- 
2.43.0


--lh7zb6nq6otmnhir--

