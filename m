Return-Path: <netdev+bounces-239952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAA5C6E5B6
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 13:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id EBC822E603
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 12:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B760C31E0FA;
	Wed, 19 Nov 2025 12:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZnHvvnt/"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011031.outbound.protection.outlook.com [40.107.130.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1381F463E;
	Wed, 19 Nov 2025 12:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763553681; cv=fail; b=ch1WrvJTMTml4xJMUiPbWYmN5pXqyR4HYyVj2jAduWj2G7gw+vuRSAR8bGONkpdMcBQBnJ8pg8fzlwMx3XNb9QrCRKGfE/wfLcaGXuoGQrPb6oVRglbyjrhxwbVUMXJSjeORKR5UTQLZNtKlHUNZaY2B1NngvthPhyyLTSXGbwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763553681; c=relaxed/simple;
	bh=B0LpyRLfFcXs2eYD/yRM7TXiuRlmscB4r0EuCysZSbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dbnTciFD6gR48xnfGLvcbd/fapikpZEXzIXPPAxxjQWNwN9ukVBMp9YhpAzXHo5Szh6UCjWpA7yU3W425QgQjkvidpbrIeuhAqsuQhAQcUz4Yk/VrlTEuVtiiokec6PeI3PyhPkoEQ2FvgiLWo/VvtWmHJaZO3D+gRBJwSimsa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZnHvvnt/; arc=fail smtp.client-ip=40.107.130.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FJFhblHI7nfm12x1dSB1EWWqOxdW2gAOwtkVJ19tgBMuI46dTMLUNDaLmy2vFnxln3umYU/DPgeVnkgyIMKuMP8G3kHLNkmg2TaLEDkDwe14G2luapuHtA4+DSBO6eL9xR7NO5fwMMEiJ0R19WUrPa+NHpba/Thdm0Cd4ls4CpVPmEGiEaOytXkC3QRqqzkLXPzQdxJ1ZRljLtsGXFyII4jJwTUILmjziboPZyHsRZE4n6alug/7PjwHDXH6pS/5UzNe84AeIbotV4zaoG8KgaMKZfrnXSeRtBifAQBrVJdCEE7y1YJ4oMuvPj+CzIvdLNzbhCLS6sN6H75pAe8XOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X7ZmNVx9dG0cCLbjELQhC8udHDF17S5maavEQV4ZuiA=;
 b=xnLYvdGcuA9iutTCI+BXuk8mfbf3flGoJw3KoZHrQcLKOuZhJAzniVZHNt+DRI+Cgr0D8Mzu3v0pvSoqvM88MaHIaYPiI2Y5QqaCLfAK2sfssdw5wIGoB9rCdbHRLKvK8fgxXoBqiISoeS0mpCHg9W6CuktUwdQVfCddsNt4KzxefJVoDOX7+uPCZFFgVGzU2njXksm8NsyFQZh7vzQJw1qXSFn4d4x99NfFYWeRgGz25/E9QXmn0T3wtBKbBEDjfU9TctQDVtwdiO0uRcwAmopkIfWKmwRxyMllflb4yvLP4XurAeHEmRJrDvJsx/wiYmVLbeaxBlBmyn7WUgOIUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7ZmNVx9dG0cCLbjELQhC8udHDF17S5maavEQV4ZuiA=;
 b=ZnHvvnt/gAvYe+MJz1EEEIWdL1spkNkHzFv1yn9I25V3ldRGbEVFuufDJi+HHw/ziMuE8r6/j451iGHAm5lkuZE5RsUTrLITBsL4H0K7crEbf344Pkp2gBLICWTsGywLN2/7ACkGPQpDZZlhhlDmsh7vGWdMbJMJGQRIsHxiowWlvDqiIy2rvCivZHvYyEjh7whyFnGDfE/VPFALCHtHspUJ4uaiIXvjNtNIej5C3bEvN5QosXYwgS4TNFYu2uGC+4ij46/2clV/UM2Vjf9YhIJEoDejtfEx3bkR2rEWSD751l/cTsDC9Crbcbw8b6b7YCiwUXxK3gGhPjqf3p13+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com (2603:10a6:10:204::9)
 by DUZPR04MB9898.eurprd04.prod.outlook.com (2603:10a6:10:4d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 12:01:15 +0000
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff]) by DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 12:01:15 +0000
Date: Wed, 19 Nov 2025 14:01:11 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: kernel test robot <lkp@intel.com>
Cc: netdev@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 14/15] net: dsa: sja1105: replace mdiobus-pcs
 with xpcs-plat driver
Message-ID: <20251119120111.voyy7rmy4mk444wo@skbuf>
References: <20251118190530.580267-15-vladimir.oltean@nxp.com>
 <20251118190530.580267-15-vladimir.oltean@nxp.com>
 <202511191835.rwfD48SW-lkp@intel.com>
 <202511191835.rwfD48SW-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202511191835.rwfD48SW-lkp@intel.com>
 <202511191835.rwfD48SW-lkp@intel.com>
X-ClientProxiedBy: VI1PR0202CA0027.eurprd02.prod.outlook.com
 (2603:10a6:803:14::40) To DBBPR04MB7497.eurprd04.prod.outlook.com
 (2603:10a6:10:204::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7497:EE_|DUZPR04MB9898:EE_
X-MS-Office365-Filtering-Correlation-Id: 472a3475-d7b6-4cb5-e589-08de27635737
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016|19092799006|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Zkh/z6esBjk14oJ0+8DWIKkexbZStFDrWZe7LLI6uCIbxVmx2roOsQt+BtY2?=
 =?us-ascii?Q?YRmuuLyAIzDoVGOZ3xmZO+fpA049lQINIKT51Ygx1n9EikFQRgk045wqxw2V?=
 =?us-ascii?Q?NekQ2CEZmlWcLz5QboYSolnNThbsccoJHY+uj6H8Y2FAIBAQMUsX7HaiPAdX?=
 =?us-ascii?Q?7aTyZU8qbKXWBUZcDlA+b5rGeM53UOHYpJoU7DY65NI8jd83qSH8/vfY8XTy?=
 =?us-ascii?Q?o2N6Y0BP3Qb6Ubf1cRAiKPUMyk5r6Js1GUgnY18MdBVqyYITco5H2rhuBCZe?=
 =?us-ascii?Q?km8MlrgWAoDqNPi2nIDMbgXgEvMhGxNgaufJJIrrW3ORn8eJGZ6969ymPM8/?=
 =?us-ascii?Q?v0UtJxFSUFz+iA2g5b95oU1ycniu2sdQCANfmgWhi/xA6AgC3Pt0OWVeP27d?=
 =?us-ascii?Q?nl3OKQzGPKrtuAJmdyXBqyXT+3NRHxpnhGvyw4nqTIp9VzLiH4xqVNMYug85?=
 =?us-ascii?Q?u6fn3f9O8cnmFU/WL/GXeAWfMCXG4PFjlT4N9Vp0TIAhfNFqOtxW+2vuG+dV?=
 =?us-ascii?Q?65Ee1ZafD2JwPvHups09Sl6YrIf5dWW31FbJU1yJUmFCN+fmPGpqKYglUSk2?=
 =?us-ascii?Q?kDQoc1Dku7umGevTzrvRDhMEG0fKu26NrjLG6IGsf1xMF8PtzFELWbT2XKmt?=
 =?us-ascii?Q?MAJxaNboHJewsBq11pAvNIHyOkhLK+qBs7WWk6nAwD0chn0lOd9ykbGOQqTb?=
 =?us-ascii?Q?tMArSJUvJSAjcSZbFudfePeA7TYRdZeMEYLObLvscLYxDJQZvUHSEEY+KtmQ?=
 =?us-ascii?Q?zs5yM76Yv2gNvrgmSFDseKMXPO2yfGQNkpahcvaQDZCnI+ygrV9H3QvKWlP4?=
 =?us-ascii?Q?CRvtWZoz/SPX2rR67cOY8BEejPaesKoUMDQIteFO5X7wsAI67uuKQPMAyeND?=
 =?us-ascii?Q?WTKDkb1DC8NBN6A9a35CFMZCnju+NqQmGvuGCIRNlPajagJFpqaH2wAxU/xA?=
 =?us-ascii?Q?D82oVrlOPcTG/ShKVRlxW/I5xMGzkw6yZEod0UBpBqrZ6sfu2BDQbvEL5up3?=
 =?us-ascii?Q?4vZMlXqMjG6Dx8ha9cNPDpdNH2IXzyokTuw7UEo7vMTFI798vSZHYuDRsiGL?=
 =?us-ascii?Q?Rgl6syqAjkVpkCqnd39qm9Zr8zvACExWfnEXtRAd+g4TiyFvTDIppjjppY14?=
 =?us-ascii?Q?dd9F0bUOf3PwZxqkwx/gqF7RaidjsCa/atrxmD2qtzKHHH9/0mr92DgtZPlz?=
 =?us-ascii?Q?imfeMwNsvV4qYhwZKswzVHvVpyGhClzfTndVgPPDsOl5df+rqrwy/Crpwqlx?=
 =?us-ascii?Q?jQNkupJWJp3e7Tiz6KI+iyLV7Gqz8asCLc16zn9iLnB7NOSBuKkNZfhnruIk?=
 =?us-ascii?Q?QdCV6moaEHixEc9vECt7N1nq5rnl0+UQTuyQz/cYaDTHNygu+db+ckHz0e0B?=
 =?us-ascii?Q?93DoxXpUS1QoOxL0cJ3VPLPXSzWg8073m4olKDn5gkHxKFy0GwD+yqM8Euqx?=
 =?us-ascii?Q?Ng9Xrmw2jLdhO9ecs4/F7U0d9cmmhCfoxuGSfjkIuSs+vJRPDU94wg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016)(19092799006)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nzYL6lKPSM8cVkTlehDVNp5uHWD5u2z4sPvflKSK1mY+ZIuuCaMMwlbvNgPY?=
 =?us-ascii?Q?kU4igYDHKP4POArbJrmC6GcgHOK3Gu+vQbseynddBYXRIG6KsznAupgdmrsh?=
 =?us-ascii?Q?L7PlebjyXiz2JgK5sRXgroV0cSaT5E5mratkV8l6/H/daDqKPgdBPqjKdBB3?=
 =?us-ascii?Q?93BMpTnyZqCu6Pw1H0GtuWYeBcXhynZJMllkT9NegsrChimoGKm0BHJxSEwH?=
 =?us-ascii?Q?eid/H31nc4UHoH39NBAzrZ77gEHsL9Rvf8fLleN8T6kLYatCQkQfjq2mMMFY?=
 =?us-ascii?Q?HP+K3Ca+apsTbwZKBBZNDXe1fe3rckORZ3nb+lsultQISuNhxwmntIFp9OcH?=
 =?us-ascii?Q?GI8ODzAMGut+VWEBGY2maRjsR3ob5U4NkXDKEx20GVhCyipNq/aio9nYJCx6?=
 =?us-ascii?Q?JcgSv2VGmLaTBcf9a9n5h2BIrX2qZEy1naqkrJkO9rnJGbW6UgTtHRxieAxp?=
 =?us-ascii?Q?uj6cWVyukXAm47WAXKJtz5+WbkmMzfHsjbtot5XCEYG334ozdOUE+2Fzocv+?=
 =?us-ascii?Q?iXK3+J3YZT5UFvR3nrrrCASyWe4dnNSrnLrkLwNZ6AhoSFTqCcDnWos2yFHP?=
 =?us-ascii?Q?8OL+wCtUGucaxrdzZyG4YS/UY3WC/Njq9wWTiWP0ZeW1XnlVAMxijG8WuUXZ?=
 =?us-ascii?Q?SjXWbgLx0Am8eeA8ZrxcU/0LvfzFqBQbNuXNPQKV+Xmvfme4NAsahJ91fiZ0?=
 =?us-ascii?Q?cOSuwPDM7cm1B74QMydT/fb7C8IS9fO88eFYMyTY/ka4c+CXWUg4UxGy/YAP?=
 =?us-ascii?Q?zVGoM2m4sqpmsaaBDAaqq1mLbeDU2o5Z532OPcj29PFjQsskCtBUlcVe0zwu?=
 =?us-ascii?Q?6aRIwLpoMD9lEH+I7cuKzATntCvBf8t6sgz1jT+dhF45GuN9ylKvV8HHNHJF?=
 =?us-ascii?Q?MOlb9fzGRpJgcEPo3RGXkywzKNXCFm75tDR+NQIVMWqGb5cOQlYmyHgwkFKh?=
 =?us-ascii?Q?rAR07OcbrAcM2/WYtwRctK9lnxWP6//OGN3jV6L1twT2+MuJZq/vnDRBF6nc?=
 =?us-ascii?Q?qXv/kHvhXxVbCfa5xT0VkJXapVhBHQfN62EuC/wP6dw7BNQRZnkH6XmEIMjW?=
 =?us-ascii?Q?xId0MjNTfPGLalF8WMRoqEIP2lWWIw89FweuM49flOg07wKEde0Nb5Sate7/?=
 =?us-ascii?Q?M0OYrhdLs5PhxoJuOk6LRrD9SP9YP9iyIv7nsPmVCuAIRE10tqXxXVk5Ajji?=
 =?us-ascii?Q?l6OqtZGdycnkvarAcp7h96yhd0gukmocV+pOMLBA5UUwwLCAj3d0k9WcVDXK?=
 =?us-ascii?Q?erHWkTEu+vlAPIgl1OJqzJt0gBuMnojgKCTrDiaD4FtX3mW9mcHd52s8deOD?=
 =?us-ascii?Q?cqOqpqqVO9L8be5p0uMag7rSI2tLHioF9g+9Q0Ul6+O8iOwjrE5/VIdHQvhE?=
 =?us-ascii?Q?DlEmgPxWoi5V4rspbX3brEhpgEVRp8N1s0uLexa/X8iV2Lzi1vbo4V8zSt+A?=
 =?us-ascii?Q?CEL0rP5CaayJ95w36FsusaI4iyJ9ogr0cwngEsmgxh9vXEYI6+CDrcbCAeql?=
 =?us-ascii?Q?1PHXRWU5KMycIrGOJB2LvL+7tJ1RcbYIlahmOffJiU8dPuQWsunzOKkud+IL?=
 =?us-ascii?Q?GAiW93Gi52Y3rtk24bR/TI33hdUZ9qGOJEFQN0aUgRUIDiMw1bgBC6Pg7jnk?=
 =?us-ascii?Q?cLocguNd70g8FpJjHqMW2fr1dfxYRF6bx36Zlf+9JcTmpsCiWeFuWSHAWbqi?=
 =?us-ascii?Q?xL5hag=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 472a3475-d7b6-4cb5-e589-08de27635737
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 12:01:15.4524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 81F5tFe3KbV4UyOGCxaKxanX/WahmqoFUOBOCzwUrcd9yc5aouDf9TVM7FLK3qvcwyIB9bD5MVxQSuyH9VfBnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9898

On Wed, Nov 19, 2025 at 07:19:59PM +0800, kernel test robot wrote:
> Hi Vladimir,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on net-next/main]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Vladimir-Oltean/net-dsa-sja1105-let-phylink-help-with-the-replay-of-link-callbacks/20251119-031300
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20251118190530.580267-15-vladimir.oltean%40nxp.com
> patch subject: [PATCH net-next 14/15] net: dsa: sja1105: replace mdiobus-pcs with xpcs-plat driver
> config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20251119/202511191835.rwfD48SW-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 15.1.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251119/202511191835.rwfD48SW-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202511191835.rwfD48SW-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/net/dsa/sja1105/sja1105_mfd.c: In function 'sja1105_create_pcs_nodes':
> >> drivers/net/dsa/sja1105/sja1105_mfd.c:145:73: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 4 has type 'resource_size_t' {aka 'unsigned int'} [-Wformat=]
>      145 |                 snprintf(node_name, sizeof(node_name), "ethernet-pcs@%llx",
>          |                                                                      ~~~^
>          |                                                                         |
>          |                                                                         long long unsigned int
>          |                                                                      %x
>      146 |                          pcs_res->res.start);
>          |                          ~~~~~~~~~~~~~~~~~~
>          |                                      |
>          |                                      resource_size_t {aka unsigned int}

I do wonder how to print resource_size_t (typedef to phys_addr_t, which
is typedeffed to u64 or u32 depending on CONFIG_PHYS_ADDR_T_64BIT).

Using %pa should be fine, like drivers/irqchip/irq-gic-v3-its.c does?

