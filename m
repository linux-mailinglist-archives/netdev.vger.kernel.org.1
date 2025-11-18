Return-Path: <netdev+bounces-239681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACE5C6B589
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 20:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 4AAF62A0A2
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 19:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB442E7180;
	Tue, 18 Nov 2025 19:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HDj4lJa7"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013015.outbound.protection.outlook.com [40.107.159.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA95E2E3B07;
	Tue, 18 Nov 2025 19:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763492758; cv=fail; b=e91nkTZBPARPgMoPWQ+xH1xiLMDGbjLxxZB5x2sGLoBBkgsB6sPQNbmHNVLAOBivTijFGJaHAjm555lL5yhSIRrHVp+rKmnz2+YnWU0fqkHU9np8TiFgBHK020O2Gxo1ZZJz5WQjzsjBIk6Sn+lN6Vm3geeKUGf3lO2tKp+YXcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763492758; c=relaxed/simple;
	bh=TRPAGKm4UvvuWvyaBRP8m04jrlw9tRE48ZcNk0hXgVw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dZHdCD9FNhb+smrKcFI/of4X9kcglz4Tsaq4zooI5jFfcZbDjsU3xCYr87NANOvpvlra0wbtwRTe1oKD57w+QOPtZ7HRaxapajuwbsUGhVUoVfND7tOhP+PQWD4m1GpVuBKxG1CDMTXNe5wpd1Uo6am+0Uougwk8Nl/+YoZNTUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HDj4lJa7; arc=fail smtp.client-ip=40.107.159.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OWtLYaLcchmINey8z1YLnVTsT/QzscL0ldR3il3d/3M3AjmpOHTKD80PVKWLRBRyJyZT2vGo1QUA6uf39Y4ikvYUX6e04m19XJKZeWqI2i5O18QwFFxAWyDLYbaw4Zlx8cQ2GfgFz16PeNBPMPYaau8NNrPSysdtYkrEfV5+nocm/YR9YbXs1NagnM2jJO/3XO89wt8kCf5ZrXCqwVZMz3FxpdfttWgZj62uwlet8xtWD0sC0CE16peGWKuD0dtgOxMyWDB9uD99gVu8pboIquoACd74GmqX6UTsHpdqR6UIT74w8TI35LL9onHOvfrKM86DaJLpe84YJEdtddRFkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NI7u70324seZy9oIR3hVpe4GjtnSdbTzrHZWzZALxw8=;
 b=YxsGd0YGeY1fLg4EU+kpyOooDY2vvzLCIrbrAYYhGWi21qcyLJfcA46HqyU9exuPXmhUhFdc/POio/m9MsBn6D6E8gnVMZPA8tce9G5PN/ToKMH/amJtULEc6bgS+AxE37MZQoCzQ3h9Z76svT8pJs4l2ARiAYCNVGgBOCUvs39PmY8T1Ua9fviQObXtCujigXFo4R3UpzVbc41oWMJj5aJ4kQQ5L6nJJerD+r9FYSqxJDyux9irxRDw1KdeYhqyDJ7TiyXFQEt4cZaT3IG7+1cZRrEEX5zkNyivA2Og2jo7DrhH94HEkVsfvsBUug4bEeDB87aJVASMk5LJ44w8Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NI7u70324seZy9oIR3hVpe4GjtnSdbTzrHZWzZALxw8=;
 b=HDj4lJa7EtE8vJbqNCTIcnB1a0VTMOAgXNq4cPVEIOxC9zaiZl5erZ+mnHCaEU4wB9ujbCzoITATQbjLMFzezwzyvgZ9c0llsDkUmDx0bN/9P8tCQHokKGRJbiArrgmPToOzL3RjY/0sDLRgCx9OHy0+7rEEGY43ORviI+9jAHob0OtH9Lq/dYwxUyHtELNWYej0Ya2eJ2Q5zK4AFF65QZ44zL46cJWtDNGsbX936w6OxqeSvPeqBviITcPSN0rqLghC/mZeH0s2QtATCssGY7S7z9LRE9/FUOh5DglooA3GzHbc0hWx33H3rLzVP2OjColBKiNGEwunSOCkLtwAmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com (2603:10a6:10:204::9)
 by PA4PR04MB7695.eurprd04.prod.outlook.com (2603:10a6:102:e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 19:05:49 +0000
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff]) by DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff%4]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 19:05:49 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next 02/15] net: mdio-regmap: permit working with non-MMIO regmaps
Date: Tue, 18 Nov 2025 21:05:17 +0200
Message-Id: <20251118190530.580267-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251118190530.580267-1-vladimir.oltean@nxp.com>
References: <20251118190530.580267-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0022.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::32) To DBBPR04MB7497.eurprd04.prod.outlook.com
 (2603:10a6:10:204::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7497:EE_|PA4PR04MB7695:EE_
X-MS-Office365-Filtering-Correlation-Id: cf2bda4b-7e51-4b04-c516-08de26d57cc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|7416014|376014|52116014|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HXUtwmgVRV0+Xl+1PYyds7kBVe+xh0GQv4WcOwo0v3ijGvEKHjQWYfUHCKZ7?=
 =?us-ascii?Q?LrBXx5DrfJ3n6T9bxzwiX4IxRFe4PRBY89I8c6wuRwXFV67CWJdyMYDp+5Xh?=
 =?us-ascii?Q?4QNi2jl0di1WGtaZXKULRcVNTlg6vP+6vSW/f0la55hnhRl85us+Qy2NXdbJ?=
 =?us-ascii?Q?uD28TXAxtDtwkbRieuxbxN8S/eZWSmRy9yEaES4+Ks6y3eCUw1MbskPUvYq2?=
 =?us-ascii?Q?qi7bxN0tOcX4Wr9Xp4vMZX0koFCuGz/ypXI0YvbbZwbHR7MzGZQWZ9Q2iQ4R?=
 =?us-ascii?Q?gOMH6Hsn8noELeYJLGiQVhC/3wjxeRCEbwdmWIHS//a+YspPMZ+JGWil3evc?=
 =?us-ascii?Q?AxeOB6tXHwG/G9sUZ93BCikkXutIvwEq0GIKRbL0mR87xXKv1e0krl61DAZZ?=
 =?us-ascii?Q?qHboA/r5E+8bkmuXweXgjMTJ3FzXpZOr/Fp0IVa155jdFbDZgLA6NFVvu2cP?=
 =?us-ascii?Q?wceenaOu+xfDPtjYfBw8/GCkGW5FruGLLr9y/O9QWhzuBB5TDunIRWtVtUwZ?=
 =?us-ascii?Q?f1cvP7mhYTQDCEYlI0RfSVeizSBONnApPcgvCCgEPQ0F4wTR0MWqe/Ju9URj?=
 =?us-ascii?Q?DEADFyX/ZaYk8r1A+ojaxr3iN7qfS+wXGPCt34ADaGTdX+uWbgjKGrPEXQ26?=
 =?us-ascii?Q?eeCej6JPeGN1LZIE7gdnIVCG7Gk76YBdWtaeHjs3Sk4wAHhU3UWChXtiDyjs?=
 =?us-ascii?Q?sjBDZUprUH+CShYEQor2IRtw8BX8mcBRvG+X03NxvKvVl7HYM8nwGSUMn5An?=
 =?us-ascii?Q?55JMvLhhO/pSbcSEayIntZLkZ96hrzjkfS7qzL2S2luBZ9sEn43zyKmtYgub?=
 =?us-ascii?Q?BW1B3ZjfSlCuE7F2vQi9fF0M8ohF7wMA8oOPliymvYJEwKkSdJJSMFK4gIL0?=
 =?us-ascii?Q?FqAB+dqJh1MmYwYC4XyDKAstkiqnnbKlonsirXyFdfLeT4HHpkiqxVEv7mXe?=
 =?us-ascii?Q?G3imfL9/MtTOw0/8MLdaknecCIQXK33d4OKe4e2JM5x0prVHM6bMskfwvulr?=
 =?us-ascii?Q?9AI82uSIjnewfVaeRaYc1UIXDvIM16EfZg8bBwAwHgGLRgFpcQzmsGlZLYAv?=
 =?us-ascii?Q?tvOocbk0nniHmvYs8jjVSLVJhQ1tJXoJqKSODazQfcJUpqfRCTe44uY0gptB?=
 =?us-ascii?Q?cLD134yZsnx7PpujPGk1j9jLMM5LE6fQqs2HWgHRE/wdvEXq/ctNQYk9Tirb?=
 =?us-ascii?Q?tRYr48t7pJCw148jv2YJdptp4gfLmgybxUmcA9A/Qs1t3KianBWeY//fZ7N/?=
 =?us-ascii?Q?os2ZaxQd3wxSpaja3czJ2jqENnoXx5gJROiSu8ftLr8+AS44h6p1UImzL8Qn?=
 =?us-ascii?Q?3SNNow9X9vaq9GhUHncZnLC/iJVKLBccKkP56M7Y4kfM1Xw/9S9H7TYrOskr?=
 =?us-ascii?Q?+JxHTo55vrO/9nfiF5JvJJfIS+HS+6HpZxbS3TVEn1e3ae+p51G1TKcWLEY1?=
 =?us-ascii?Q?YZCHgeHksRQ0BuVCxb5NLH9Do0wHzlUM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(376014)(52116014)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rdGNtND/bY6nHF/lBMSR8x1T/gXUgXYGMkJR3ZzMnI+Xr5B4N8rp98PioEH7?=
 =?us-ascii?Q?FxcGPmYheaIeCdtKawcaWziEQVFh1wyhX2k/YCTdtCgtAtJSq5ezopDyOy3u?=
 =?us-ascii?Q?qaHKUPwmMdU/1BfPzUhfQqTt+Ih8G4YHvBLI+nWd6iN169sbshjH7s3xxJsZ?=
 =?us-ascii?Q?NsuIvoRH7g3GBaCqgHvSROb9WqV7O6Re9NSllMOQ/k/5ueNqq3dxGkShqTiT?=
 =?us-ascii?Q?3Mh85/gILWR43VbsTOepMoDn+Xtp5MdlmTL0HX482w7+swtUG0BnYBs7OdnL?=
 =?us-ascii?Q?+ATofuv4D3WG0dtycE1F5LwNAf9rKXjSHzv+5EA59gqp0shW4mCKeAdFKx7d?=
 =?us-ascii?Q?epV6nstN98+EI+38XNSrO/9sNPIpTBq03efnthq6QROyi9MN5V7rxV8H6nr/?=
 =?us-ascii?Q?MMriohilJIxfMTHkyx4qjbKsZ7Qj+a0H1Ar/illKSN9mX1iSc/Ty+/VCbN16?=
 =?us-ascii?Q?RujzmfQQLWBEbRoj5wkzQrnc3Jq8qoplSj9KlTIRD3HXcKJPYmU5isKwdf0y?=
 =?us-ascii?Q?Vk6R52XFfQ70ohB8tTRs9l5cyG01lmQ6aqBwAfM+JPyOcpbMa7gX5ze+fVFT?=
 =?us-ascii?Q?Nj0ulkw3pQVnsh1YXlARvo1wuNm6iiv7oIwrcaGtT9KAa5AM2/Je1FRYzYDW?=
 =?us-ascii?Q?opXsLLPUaonljesHQ/Ix3b9Vng3vAGB8P94WNSOBEyyiTU2QiHUP13Unq3ZX?=
 =?us-ascii?Q?o2TnKMxceaii+PFal+lBBZoQF35kI4xAMwo+MiNYqZpYjJznwbT1VPUD+7Eq?=
 =?us-ascii?Q?Qa5ChLhkeVc4uK0kqkxtpbMGuW/MoSbpgSqsM+YOt74tP/vgQJBewhBoaPj9?=
 =?us-ascii?Q?pnsZe1VenUJJo/vf+rCIxbcId9D0KAKwEHwZZGvO4K9s9iAL9eFS2pKvrmfy?=
 =?us-ascii?Q?1v/ByDVzGX96CauLjqHq6PobtI/sRYkP1CFInUrRccGiWfhUVgb9qt+os7Qe?=
 =?us-ascii?Q?PtUGAL+CfvhWkTh2/LQHgpp+m/gxbWomUBdBjXU8fYdTpoAJV+htcG+clhqo?=
 =?us-ascii?Q?0qjwP8+nc6/qE8IPMX9k0dgLJgDyP6OLnGLnAx0uBM55WKEs6iRxQyvOb4jF?=
 =?us-ascii?Q?Vhhl6g0VWNgOo9eNCkEPTr0qmsnk6v661toVCk8OFmiEsxmKsmXo8TvQ27r4?=
 =?us-ascii?Q?iNQHAisvMdrUlJcKOHYSuq/1+2FeQOm4WUVsc02YV0zvhboTUVb/dedJ6EPu?=
 =?us-ascii?Q?Vy3RJy76q4M9S1NV+tXYHTvOs6g7HDF56PO/aXPNNpcjEmWzely6AdBKEgKv?=
 =?us-ascii?Q?HCTUkmTBm5dogYdttuEqptOEUCde4lvK78Izclg6wy/qod1sgRGy5C/R51NL?=
 =?us-ascii?Q?+enG+X/Q/7McL+wu3cj6IKfWsESA1XS0GViomxhVXWQhoPQD/X0HFajxNTZK?=
 =?us-ascii?Q?ewFm8gd3yRmQslvwndX7W3P3tad46QsXzH74EtXD8yOjdMcmjSH3Qjc1mfnu?=
 =?us-ascii?Q?4t3N4TAoU/FfIMyG7MoVowXRiHW4Hf5d9CHjXAS0MjbdLU/QUImQ4yF8t58d?=
 =?us-ascii?Q?wr/aQw1LM5+TJ6m2enK0hXB92fQ1gyR53i8o8odHLjosgRmPvjvSMPZuxeEF?=
 =?us-ascii?Q?1ioK69Ew2sDsv8McL8InaoD7CndLEu66UQP5IhU3ww5ZPtOKwZSnYIfql9l8?=
 =?us-ascii?Q?JyOhXV0AUV0EM15JFqcx7ms=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf2bda4b-7e51-4b04-c516-08de26d57cc7
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 19:05:49.7793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NywSUuvkgtGsUPy8A4YcGZnhssuwvxbvcME4wqD8X7MgO2jQzAJHAekbdQOkeVR9GE6ogo+G2YCBzdrksYFwjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7695

The regmap world is seemingly split into two groups which attempt to
solve different problems. Effectively, this means that not all regmap
providers are compatible with all regmap consumers.

First, we have the group where the current mdio-regmap users fit:
altera_tse_main.c and dwmac-socfpga.c use devm_regmap_init_mmio() to
ioremap their pcs_base and obtain a regmap where address zero is the
first PCS register.

Second, we have the group where MFD parent drivers call
mfd_add_devices(), having previously initialized a non-MMIO (SPI, I2C)
regmap and added it to their devres list, and MFD child drivers use
dev_get_regmap(dev->parent, NULL) in their probe function, to find the
first (and single) regmap of the MFD parent. The address zero of this
regmap is global to the entire parent, so the children need to be
parent-aware and add their own offsets for the registers that they
should manage.

This is essentially because MFD is seemingly coming from a world where
peripheral registers are all entangled with each other, but what I'm
trying to support via MFD are potentially multiple instances of the same
kind of device, at well separated address space regions.

To use MFD but provide isolated regmaps for each child device would
essentially mean to fight against the system. The problem that needs to
be now solved is that each child device needs to find the correct
regmap, which means that "dev_get_regmap(dev->parent, NULL)" transforms
either in:
- dev_get_regmap(dev, NULL): search in the child device's devres list,
  not in the parent's. But MFD does not give us a hook in between
  platform_device_alloc() and platform_device_add() where we could make
  the devm_regmap_init_spi() call for the child device. We have to make
  it for the parent.
- dev_get_regmap(dev->parent, "unique-regmap-name"): now the child
  device needs to know, in case there are multiple instances of it,
  which one is it, to ask for the right one. I've seen
  drivers/mfd/ocelot-core.c work around this rather elegantly, providing
  a resource to the child, and then the child uses resource->name to
  find the regmap of the same name in the parent. But then I also
  stumbled upon drivers/net/pcs/pcs-xpcs-plat.c which I need to support
  as an MFD child, and that superimposes its own naming scheme for the
  resources: "direct" or "indirect" - scheme which is obviously
  incompatible with namespacing per instance.

So a MFD parent needs to decide whether it is in the boat that provides
one isolated regmap for each child, or one big regmap for all. The "one
big regmap" is the lowest common denominator when considering children
like pcs-xpcs-plat.c.

This means that from mdio-regmap's perspective, it needs to deal with
regmaps coming from both kinds of providers, as neither of them is going
away.

Users who provide a big regmap but want to access only a window into it
should provide as a struct mdio_regmap_config field a resource that
describes the start and end of that window. Currently we only use the
start as an offset into the regmap, and hope that MDIO reads and writes
won't go past the end.

Cc: Mark Brown <broonie@kernel.org>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/mdio/mdio-regmap.c   | 7 +++++--
 include/linux/mdio/mdio-regmap.h | 2 ++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mdio/mdio-regmap.c b/drivers/net/mdio/mdio-regmap.c
index 8a742a8d6387..2a0e9c519fa3 100644
--- a/drivers/net/mdio/mdio-regmap.c
+++ b/drivers/net/mdio/mdio-regmap.c
@@ -19,6 +19,7 @@
 
 struct mdio_regmap_priv {
 	struct regmap *regmap;
+	unsigned int base;
 	u8 valid_addr;
 };
 
@@ -31,7 +32,7 @@ static int mdio_regmap_read_c22(struct mii_bus *bus, int addr, int regnum)
 	if (ctx->valid_addr != addr)
 		return -ENODEV;
 
-	ret = regmap_read(ctx->regmap, regnum, &val);
+	ret = regmap_read(ctx->regmap, ctx->base + regnum, &val);
 	if (ret < 0)
 		return ret;
 
@@ -46,7 +47,7 @@ static int mdio_regmap_write_c22(struct mii_bus *bus, int addr, int regnum,
 	if (ctx->valid_addr != addr)
 		return -ENODEV;
 
-	return regmap_write(ctx->regmap, regnum, val);
+	return regmap_write(ctx->regmap, ctx->base + regnum, val);
 }
 
 struct mii_bus *devm_mdio_regmap_register(struct device *dev,
@@ -66,6 +67,8 @@ struct mii_bus *devm_mdio_regmap_register(struct device *dev,
 	mr = mii->priv;
 	mr->regmap = config->regmap;
 	mr->valid_addr = config->valid_addr;
+	if (config->resource)
+		mr->base = config->resource->start;
 
 	mii->name = DRV_NAME;
 	strscpy(mii->id, config->name, MII_BUS_ID_SIZE);
diff --git a/include/linux/mdio/mdio-regmap.h b/include/linux/mdio/mdio-regmap.h
index 679d9069846b..441cead97936 100644
--- a/include/linux/mdio/mdio-regmap.h
+++ b/include/linux/mdio/mdio-regmap.h
@@ -11,10 +11,12 @@
 
 struct device;
 struct regmap;
+struct resource;
 
 struct mdio_regmap_config {
 	struct device *parent;
 	struct regmap *regmap;
+	const struct resource *resource;
 	char name[MII_BUS_ID_SIZE];
 	u8 valid_addr;
 	bool autoscan;
-- 
2.34.1


