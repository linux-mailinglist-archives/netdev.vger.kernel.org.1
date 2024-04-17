Return-Path: <netdev+bounces-88770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFF48A87F8
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 17:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6804283576
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 15:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0501487C6;
	Wed, 17 Apr 2024 15:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inadvantage.onmicrosoft.com header.i=@inadvantage.onmicrosoft.com header.b="Y75wGAVI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2139.outbound.protection.outlook.com [40.107.100.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9247140E29
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 15:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713368534; cv=fail; b=ld8y6n0EvPKwSTgWMjvsS70YlM9vhGHtQQuZGM3d+qPguay9A1aZkb8sA2hvsWeI2QuWTV41s+zKbTEGPhsd9E3zkfqg5mjZHdxXcmVJzlEp4x/PDu84VCJIiiSXPIfIbcg0PLApdWyJnVEr4MqZazT8+dd9QMWVmYHaHEk+BGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713368534; c=relaxed/simple;
	bh=Mf6TOBfn16DyD6wYW526jOSMWJQFfcSISikr0LIO6Cs=;
	h=Date:From:To:Subject:Message-ID:Content-Type:Content-Disposition:
	 MIME-Version; b=RlI4+J8CIVQT9pSjf9tyNx58tagHz7onETkFazakgvbi97r3YCufr1xvDturFR1BL1bEAS9hBw/Unw+ITLYaWqcxdtTCQDm2WGv/47cR0EfW3h7hxsnxWpB18nZTTrKDmgDH1QtKrO9+qr2BJ66nrKbE5hcrz/nKswXoxw8VOos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-advantage.com; spf=pass smtp.mailfrom=in-advantage.com; dkim=pass (1024-bit key) header.d=inadvantage.onmicrosoft.com header.i=@inadvantage.onmicrosoft.com header.b=Y75wGAVI; arc=fail smtp.client-ip=40.107.100.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-advantage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=in-advantage.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jUA75UMAsJcMkS/3JPwzRs1SY/C+CTaK1boGO+1PoTD8gxxgtQBoxd66jlroFjx+tgkjXq4567i/i5Ur2Y9jvw3Hs4AQy8UbZ9OipoMNJ3JyHisfCSt06I/68+uR+mWQSFoCIkEiefNBommr7endDRhw3HemExFUN2kBP7vmZJYdxoqNRJb/vZNaWrI5iFFzDhfnbTBX0c6P0uojwbT3oiYzf+luMFi3C0rY7oql7CMa6Ip+1CMQ0b7z0z5TnUrsnhReWhAc2yCOwsajvjJpf4xjT5X9Aam9Y8rXG9OrpU3qLXwCLNsTa14Am/5a3KaLCkZXz+9SrNo7qjpZxjR2vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lmbYQhorSEjU9TU2i9+pjcpGQ2abWgPkFgGImOOtRJs=;
 b=k1555PxpI0T7EhpDLikgauz3kiN1HswU9Dfxy9/Qo/PijxJZ859NP+KkydmVVZO7Gp4zzZYMBl3072Ga1rQnarT/UHnS3ZVtwCmlRKkmia5mX3CnYNfere7u2Y0VHvSRcD8tUYrFp8CjAQ7m5Mj75UOphIUzAhAtKKx6n30xCPSgHvecJBtUbgxSFYLUP+3nw4waH4uqPQL8YjVFe0Ck7LRPpCJsv7EVad242Ru5RCjJwhELwDEHW2TezCNMdMHzwVZkGEgEO/Iuv+6gmuO1k7gbuqRx4PVS3cMts1sKRRELRvgkentb7dnhVSbfLnHRImjJEYLTxMJLZvARbuxXpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmbYQhorSEjU9TU2i9+pjcpGQ2abWgPkFgGImOOtRJs=;
 b=Y75wGAVIlWo7pEHgbvdelTVfA+uk5r7cP7tGruC+LBS3FmART/h6Vpi821HYlABh/8t7GmFadLmTdMW77usZJCUtUXKAtbeCoYOzjnvb/QvKWX+PlS+uFQ8zfWt/8ea1LT3/KCsXM0MLeCYXJrk+KXSoxGMiquzk2SUk7zJfFck=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from DS0PR10MB6974.namprd10.prod.outlook.com (2603:10b6:8:148::12)
 by MN6PR10MB7444.namprd10.prod.outlook.com (2603:10b6:208:472::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Wed, 17 Apr
 2024 15:42:06 +0000
Received: from DS0PR10MB6974.namprd10.prod.outlook.com
 ([fe80::1e22:8892:bfef:6cb6]) by DS0PR10MB6974.namprd10.prod.outlook.com
 ([fe80::1e22:8892:bfef:6cb6%5]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 15:42:05 +0000
Date: Wed, 17 Apr 2024 10:42:02 -0500
From: Colin Foster <colin.foster@in-advantage.com>
To: netdev@vger.kernel.org
Subject: Beaglebone Ethernet Probe Failure In 6.8+
Message-ID: <Zh/tyozk1n0cFv+l@euler>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: MN2PR06CA0007.namprd06.prod.outlook.com
 (2603:10b6:208:23d::12) To DS0PR10MB6974.namprd10.prod.outlook.com
 (2603:10b6:8:148::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6974:EE_|MN6PR10MB7444:EE_
X-MS-Office365-Filtering-Correlation-Id: 56b370a2-a6f5-4e0a-056a-08dc5ef4ef02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	d2QXoN47vUxJkAsw4zeMKyI0N87XzW5g4yM96oHiE5Q22+T2GRiSat7nH8rkWvOeUESnvucd1v3kHa2psSpdX0lAHL9tKF0TIN66BRAielyJP1/hlfMkSvoJSoGeB2TkoKi2VV3DeKyA3j9zhJC7Y8uKXDw00fv10xBZuUTkgXJhy/VmnXFoxjTwUPDievoJ8z6+v4wppxeBIs40Wm+yZjFNNFibtu9S94A1v8ud/Yj8LkLZxK0OAVk82lOtNS7eHp+8mLdtWp8Gc9RRVnL4aAlIipbHHARK/xb4X822FnMivfGJ8gnUaIfjPnX23uXrcSuFjKgG9G4UxN2gj66sgrptOSOLOudVv8pegDbNIs25Ex32jhI6samnP1YGzwTuxqz/mrLU4vfb2XzUVXbsGTY2G+t25I0kGukIIMCiiftuHUtUYvu/RIUfX4VIhfPSaYc/i3iLG6+ENNxZLDjMEIwLVieARp4hsJjp+bqZ9hovY5AX5fPx9Xo9YFPHkGZQndI2eZzkWeCzWwGsIm1iCjIFD1myzT+vlSoqV+KxL0mRAVluLayEEjLy8nXvQ8liudNXv/reSmEWAP7THZAgk37LRZuCPTRNiN9vcoLjWJVl4wITx59RGlVM7/b9MHPJXmuhPZj/I/0MifSOhYGbJD7z78o5m0OFl+jJpYX7eXs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6974.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QMB29WNmLh9ieVyBcn3fDWoX/Mq+11eZSqA2nAP19A7yLuoBBZaeVnoDssRI?=
 =?us-ascii?Q?AeOfkmmH0zbbNDMngLn/+AY+Pi2wGNAaaGmvJ8PkBVVRc+kLavsMmdy5/k9n?=
 =?us-ascii?Q?XxqRgtLUcCUPuU0vxSebVS/5Ar8Dcz57Bwy94rj5DgQBNZ/L9H0NYTCPs9XD?=
 =?us-ascii?Q?r7cfqYi8xe5EnABNv4NMFvm0Gn2vFc+dHMtBAZYsMBK9VdHRLPiHR3v4haey?=
 =?us-ascii?Q?4CXiQfb/3mvr0xwi9xdEbkcFc4fthrOQaq89yiCj3C3y41P73erGYJuQUehj?=
 =?us-ascii?Q?bJu2jZTKsWQJt3cUFz8zhsf1QYdHJXFaEHOc0AMAksA4QRnUdTK/kXZRhEz4?=
 =?us-ascii?Q?NNTd0R0N1/9IqcaouSAdT3UOSCuqQ44Do9hUQLwgCfooYiP8LXyMY5Le0epr?=
 =?us-ascii?Q?ehZDlG34JncFwMKzgoqMX9bLwHX1Y4TwGBs7WR1bmeUClQjUh0BelH5IQ80t?=
 =?us-ascii?Q?2kuAPbMfwny5PypCF2sgcVLQ+ssQ0Llgj3+YkBl5OBXpabn6S3j8DO1scgpV?=
 =?us-ascii?Q?c2Jtm42leDdRnnmUl0dU8zm/Yc9G9bMGMSHE9MGY3koDOXolAL70FwPrqyW8?=
 =?us-ascii?Q?IsX3lFns+3ClesImQzOldbDAiVBMdPO95Fac1IxIBLyK2rtnjdDWBps08j0P?=
 =?us-ascii?Q?o5tTUPl73LIU1JeIPeYRfOhdefsIrlUm67/XJY2iUeKI4JLUkz3AtoBGuHrW?=
 =?us-ascii?Q?JUYD9IsgStMU2+4OgN/6e4spkAn7t2gkBzCpZCRgzvByvJVAfrV843HYp2sP?=
 =?us-ascii?Q?ZIEozQpYAGwm1PxSMGB7jZsfX97wtBYeFJoRAJqvRazt8Luz66cMVNB2TQ76?=
 =?us-ascii?Q?sNqwpacqGAbfMPlPRwSDYZrCSq3bvdRz/qCgMfpVCtaj/08eHQ5LZGUN+ZsF?=
 =?us-ascii?Q?Amufc4vVnC76z+uCXQH1NuyL2Kol5adEkqaMhjCP44mRjekKRgBFM5beuoOB?=
 =?us-ascii?Q?Z5HIbNN8njOIGAIisU/gwvW2VEYnxEPPUfDnJSRaBw4Ok5n8Zl41FzM7Ea9Z?=
 =?us-ascii?Q?qTibptApkpk4zndWykTv/b6UKlX9sVJWt0ybz5nfyi5HktD+h/PNUMEhIMI/?=
 =?us-ascii?Q?kZbyDmYSqilLxVIfsEOihkOm6pBdlSekX8uPCE49uBkVkDCU3KrGnGjqwiCK?=
 =?us-ascii?Q?UILKzgezZiEVUULXc59dV4rY5vLax/YXyaWo6q3Qgv2oYprht18N1uYJonbN?=
 =?us-ascii?Q?Puw6a6hfGSwVKE5933W+K+iBoBis73hvQqN3MU3EjtqisH+ALtXf2c6d82Fc?=
 =?us-ascii?Q?MnAYEejuRrW4vhFVL6zkzSfqJxwXZYTOrjVUbJBOksw/LeABT+yjC9ek5HQe?=
 =?us-ascii?Q?eDmVObrsKoBG4zgVJDyQHsh9lOisLJ0B4GgIDPDBxsPGzo6T34MriOg44RDC?=
 =?us-ascii?Q?6DZYdSf6gYGAFlloscsWzPrFAzMIq3mA5sTf6DtlxH78ouOzMjHGE11tdGEH?=
 =?us-ascii?Q?MJJmtvuOpvMCJl6aeyN3Cj7VQQM1D713UcbclPD7OEtHgXqxyIymIN/8+mWu?=
 =?us-ascii?Q?XPPMun7Pvfn5bNdD5OQkFp3Efy1kB1UvuCf3XVSbEAvzhj0iYdQbB9qnU1XW?=
 =?us-ascii?Q?z58V2WLFUs0MAZooEzRxbEYygKSvOpRpbXzuu1ZU157Em4usl+6ZXu22wSlF?=
 =?us-ascii?Q?wg=3D=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56b370a2-a6f5-4e0a-056a-08dc5ef4ef02
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6974.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 15:42:05.6838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HIun8yjhsNRlxEQeHEsbTpntxzT9zk+39XN6pWrIaZS3X7ah7vwThJs0I4EKOHgOv+FKJDGjJl6n5cyoNQMFtIJqKVNrbVweWN7hSUDpHwM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7444

Hello,

I'm chasing down an issue in recent kernels. My setup is slightly
unconventional: a BBB with ETH0 as a CPU port to a DSA switch that is
controlled by SPI. I'll have hardware next week, but think it is worth
getting a discussion going.

The commit in question is commit df16c1c51d81 ("net: phy: mdio_device:
Reset device only when necessary"). This seems to cause a probe error of
the MDIO device. A dump_stack was added where the reset is skipped.

SMSC LAN8710/LAN8720: probe of 4a101000.mdio:00 failed with error -5

(actual dmesg is below)

Because this failure happens much earlier than DSA, I suspect is isn't
isolated to me and my setup - but I'm not positive at the moment.

I suspect one of the following:

1. There's an issue with my setup / configuration.

2. This is an issue for every BBB device, but probe failures don't
actually break functionality.


Depending on which of those is the case, I'll either need to:

A. revert the patch because it is causing probe failures

B. determine why the probe is failing in the MDIO driver and try to fix
that

C. Introduce an API to force resets, regardless of the previous state,
and apply that to the failure cases.


I assume the path forward is option B... but if the issue is more
widespread, options A or C might be the correct path.


I'll be able to test on hardware again next week if there's more
information needed.



[    1.539656] mdio_bus 4a101000.mdio:00: using DT '/ocp/interconnect@4a000000/segment@0/target-module@100000/switch@0/mdio@1000/ethernet-phy@0' for 'reset' GPIO lookup
[    1.539911] of_get_named_gpiod_flags: parsed 'reset-gpios' property of node '/ocp/interconnect@4a000000/segment@0/target-module@100000/switch@0/mdio@1000/ethernet-phy@0[0]' - status (0)
[    1.540193] gpio gpiochip0: Persistence not supported for GPIO 8
[    1.548962] CPU: 0 PID: 25 Comm: kworker/u2:2 Not tainted 6.7.0-rc3-00667-gdf16c1c51d81-dirty #1407
[    1.548991] Hardware name: Generic AM33XX (Flattened Device Tree)
[    1.549004] Workqueue: events_unbound deferred_probe_work_func
[    1.549044] Backtrace: 
[    1.549055]  dump_backtrace from show_stack+0x20/0x24
[    1.549098]  show_stack from dump_stack_lvl+0x60/0x78
[    1.549127]  dump_stack_lvl from dump_stack+0x18/0x1c
[    1.549156]  dump_stack from mdio_device_reset+0xc4/0xfc
[    1.549183]  mdio_device_reset from phy_probe+0x6c/0x488
[    1.549209]  phy_probe from really_probe+0xd8/0x2e8
[    1.549243]  really_probe from __driver_probe_device+0x98/0x1b0
[    1.549266]  __driver_probe_device from driver_probe_device+0x40/0x114
[    1.549291]  driver_probe_device from __device_attach_driver+0xa4/0x10c
[    1.549317]  __device_attach_driver from bus_for_each_drv+0x94/0xec
[    1.549356]  bus_for_each_drv from __device_attach+0xbc/0x1e0
[    1.549384]  __device_attach from device_initial_probe+0x1c/0x20
[    1.549408]  device_initial_probe from bus_probe_device+0x98/0x9c
[    1.549422]  bus_probe_device from device_add+0x5a8/0x778
[    1.549450]  device_add from phy_device_register+0x50/0x90
[    1.549485]  phy_device_register from fwnode_mdiobus_phy_device_register+0xd0/0x114
[    1.549511]  fwnode_mdiobus_phy_device_register from fwnode_mdiobus_register_phy+0x16c/0x1c0
[    1.549539]  fwnode_mdiobus_register_phy from __of_mdiobus_register+0x150/0x38c
[    1.549568]  __of_mdiobus_register from davinci_mdio_probe+0x2ac/0x474
[    1.549613]  davinci_mdio_probe from platform_probe+0x6c/0xcc
[    1.549646]  platform_probe from really_probe+0xd8/0x2e8
[    1.549671]  really_probe from __driver_probe_device+0x98/0x1b0
[    1.549695]  __driver_probe_device from driver_probe_device+0x40/0x114
[    1.549720]  driver_probe_device from __device_attach_driver+0xa4/0x10c
[    1.549745]  __device_attach_driver from bus_for_each_drv+0x94/0xec
[    1.549774]  bus_for_each_drv from __device_attach+0xbc/0x1e0
[    1.549802]  __device_attach from device_initial_probe+0x1c/0x20
[    1.549825]  device_initial_probe from bus_probe_device+0x98/0x9c
[    1.549839]  bus_probe_device from device_add+0x5a8/0x778
[    1.549867]  device_add from of_device_add+0x44/0x4c
[    1.549909]  of_device_add from of_platform_device_create_pdata+0xa0/0xd0
[    1.549927]  of_platform_device_create_pdata from of_platform_bus_create+0x1b4/0x384
[    1.549956]  of_platform_bus_create from of_platform_populate+0x80/0xe4
[    1.549991]  of_platform_populate from devm_of_platform_populate+0x60/0xa8
[    1.550026]  devm_of_platform_populate from cpsw_probe+0x214/0xd2c
[    1.550060]  cpsw_probe from platform_probe+0x6c/0xcc
[    1.550096]  platform_probe from really_probe+0xd8/0x2e8
[    1.550121]  really_probe from __driver_probe_device+0x98/0x1b0
[    1.550145]  __driver_probe_device from driver_probe_device+0x40/0x114
[    1.550170]  driver_probe_device from __device_attach_driver+0xa4/0x10c
[    1.550196]  __device_attach_driver from bus_for_each_drv+0x94/0xec
[    1.550224]  bus_for_each_drv from __device_attach+0xbc/0x1e0
[    1.550252]  __device_attach from device_initial_probe+0x1c/0x20
[    1.550274]  device_initial_probe from bus_probe_device+0x98/0x9c
[    1.550288]  bus_probe_device from device_add+0x5a8/0x778
[    1.550316]  device_add from of_device_add+0x44/0x4c
[    1.550353]  of_device_add from of_platform_device_create_pdata+0xa0/0xd0
[    1.550369]  of_platform_device_create_pdata from of_platform_bus_create+0x1b4/0x384
[    1.550398]  of_platform_bus_create from of_platform_populate+0x80/0xe4
[    1.550433]  of_platform_populate from sysc_probe+0xff0/0x148c
[    1.550479]  sysc_probe from platform_probe+0x6c/0xcc
[    1.550516]  platform_probe from really_probe+0xd8/0x2e8
[    1.550541]  really_probe from __driver_probe_device+0x98/0x1b0
[    1.550565]  __driver_probe_device from driver_probe_device+0x40/0x114
[    1.550589]  driver_probe_device from __device_attach_driver+0xa4/0x10c
[    1.550615]  __device_attach_driver from bus_for_each_drv+0x94/0xec
[    1.550644]  bus_for_each_drv from __device_attach+0xbc/0x1e0
[    1.550673]  __device_attach from device_initial_probe+0x1c/0x20
[    1.550696]  device_initial_probe from bus_probe_device+0x98/0x9c
[    1.550709]  bus_probe_device from device_add+0x5a8/0x778
[    1.550738]  device_add from of_device_add+0x44/0x4c
[    1.550773]  of_device_add from of_platform_device_create_pdata+0xa0/0xd0
[    1.550790]  of_platform_device_create_pdata from of_platform_bus_create+0x1b4/0x384
[    1.550819]  of_platform_bus_create from of_platform_populate+0x80/0xe4
[    1.550854]  of_platform_populate from simple_pm_bus_probe+0xd8/0xfc
[    1.550890]  simple_pm_bus_probe from platform_probe+0x6c/0xcc
[    1.550919]  platform_probe from really_probe+0xd8/0x2e8
[    1.550944]  really_probe from __driver_probe_device+0x98/0x1b0
[    1.550968]  __driver_probe_device from driver_probe_device+0x40/0x114
[    1.550992]  driver_probe_device from __device_attach_driver+0xa4/0x10c
[    1.551019]  __device_attach_driver from bus_for_each_drv+0x94/0xec
[    1.551047]  bus_for_each_drv from __device_attach+0xbc/0x1e0
[    1.551075]  __device_attach from device_initial_probe+0x1c/0x20
[    1.551098]  device_initial_probe from bus_probe_device+0x98/0x9c
[    1.551111]  bus_probe_device from device_add+0x5a8/0x778
[    1.551139]  device_add from of_device_add+0x44/0x4c
[    1.551175]  of_device_add from of_platform_device_create_pdata+0xa0/0xd0
[    1.551192]  of_platform_device_create_pdata from of_platform_bus_create+0x1b4/0x384
[    1.551220]  of_platform_bus_create from of_platform_populate+0x80/0xe4
[    1.551255]  of_platform_populate from simple_pm_bus_probe+0xd8/0xfc
[    1.551291]  simple_pm_bus_probe from platform_probe+0x6c/0xcc
[    1.551320]  platform_probe from really_probe+0xd8/0x2e8
[    1.551345]  really_probe from __driver_probe_device+0x98/0x1b0
[    1.551369]  __driver_probe_device from driver_probe_device+0x40/0x114
[    1.551394]  driver_probe_device from __device_attach_driver+0xa4/0x10c
[    1.551419]  __device_attach_driver from bus_for_each_drv+0x94/0xec
[    1.551448]  bus_for_each_drv from __device_attach+0xbc/0x1e0
[    1.551476]  __device_attach from device_initial_probe+0x1c/0x20
[    1.551499]  device_initial_probe from bus_probe_device+0x98/0x9c
[    1.551513]  bus_probe_device from device_add+0x5a8/0x778
[    1.551541]  device_add from of_device_add+0x44/0x4c
[    1.551577]  of_device_add from of_platform_device_create_pdata+0xa0/0xd0
[    1.551593]  of_platform_device_create_pdata from of_platform_bus_create+0x1b4/0x384
[    1.551622]  of_platform_bus_create from of_platform_populate+0x80/0xe4
[    1.551657]  of_platform_populate from simple_pm_bus_probe+0xd8/0xfc
[    1.551693]  simple_pm_bus_probe from platform_probe+0x6c/0xcc
[    1.551722]  platform_probe from really_probe+0xd8/0x2e8
[    1.551747]  really_probe from __driver_probe_device+0x98/0x1b0
[    1.551770]  __driver_probe_device from driver_probe_device+0x40/0x114
[    1.551795]  driver_probe_device from __device_attach_driver+0xa4/0x10c
[    1.551821]  __device_attach_driver from bus_for_each_drv+0x94/0xec
[    1.551850]  bus_for_each_drv from __device_attach+0xbc/0x1e0
[    1.551878]  __device_attach from device_initial_probe+0x1c/0x20
[    1.551901]  device_initial_probe from bus_probe_device+0x98/0x9c
[    1.551915]  bus_probe_device from deferred_probe_work_func+0x88/0xb4
[    1.551940]  deferred_probe_work_func from process_one_work+0x170/0x43c
[    1.551971]  process_one_work from worker_thread+0x2c4/0x4ec
[    1.552006]  worker_thread from kthread+0x114/0x148
[    1.552040]  kthread from ret_from_fork+0x14/0x28
[    1.552056] Exception stack(0xe006dfb0 to 0xe006dff8)
[    1.552069] dfa0:                                     00000000 00000000 00000000 00000000
[    1.552081] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    1.552091] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    1.552103]  r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c037b070 r4:c21d6140
[    1.553623] SMSC LAN8710/LAN8720: probe of 4a101000.mdio:00 failed with error -5
[    1.553762] davinci_mdio 4a101000.mdio: phy[0]: device 4a101000.mdio:00, driver SMSC LAN8710/LAN8720
[    1.554978] cpsw-switch 4a100000.switch: initialized cpsw ale version 1.4
[    1.555011] cpsw-switch 4a100000.switch: ALE Table size 1024
[    1.555210] cpsw-switch 4a100000.switch: cpts: overflow check period 500 (jiffies)
[    1.555234] cpsw-switch 4a100000.switch: CPTS: ref_clk_freq:250000000 calc_mult:2147483648 calc_shift:29 error:0 nsec/sec
[    1.555343] cpsw-switch 4a100000.switch: Detected MACID = 24:76:25:76:35:37
[    1.558098] cpsw-switch 4a100000.switch: initialized (regs 0x4a100000, pool size 256) hw_ver:0019010C 1.12 (0)
[    1.600301] debugfs: Directory '49000000.dma' with parent 'dmaengine' already present!
[    1.600356] edma 49000000.dma: TI EDMA DMA engine driver



