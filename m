Return-Path: <netdev+bounces-245601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C04CD34C1
	for <lists+netdev@lfdr.de>; Sat, 20 Dec 2025 19:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C867300FE1D
	for <lists+netdev@lfdr.de>; Sat, 20 Dec 2025 18:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE77E26158C;
	Sat, 20 Dec 2025 18:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Xr4S24lG"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010017.outbound.protection.outlook.com [52.101.84.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67674D8CE;
	Sat, 20 Dec 2025 18:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766253680; cv=fail; b=mQy9pqWG/Ptjk37SW2G9isAKAwodG4SebcuFczO9HKJ67lUXct/UMckRhotkF3knTgQC3/VYzuMDP1G1qOzcpup/bwiu/3sqdfvOHSwFDKhG48SOs0Gz7UZsFQRY/7DoUaCj7G7Sl0z1ko8itqzGGDwJdaq6HPxHsbr01WjD4IA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766253680; c=relaxed/simple;
	bh=RGwXCxLLEIH3H98eoaK1jsFp0IBOZWlmsIXZL5nYsVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CoCJ1EbZVgeIZYI0wPnC7LyNskZLNFARnYJSOKk9dqIBC1H1SjKLI/hOh7uTQvaHfXm55EkRIwqWki7job585u9DBOfbfTjJqyxcRow4ren84/zBMt6uuTEntJA71hLHcbltzWsTt2kY3FYCiXgfRS6npWOVrDXfdKhXUQmxde0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Xr4S24lG; arc=fail smtp.client-ip=52.101.84.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qllwiiRZNRO0/PmThVQhb0ZDJqVQyMeZUsD9jDFyovTi4Huxzi0AnOUC8pjPweSpamOJK5blcwKwM9lWPqI+QRufa+8HilcQS5UKl2tWMpffM0kEjoIOvb0HEahbhMDnpOSRnPsX8Mz1UpGzVItMGYokw1HhkTeFE/ZauGoSECCtxQI52M7UoLrHRhett6ASsje5Gy4EFlfJZux2fvdpxUoStE3eQwaN6SXzmFFxN+PdPsWJFQ8gcbVQ2QVSvZKSKSTnFhFsipp6SUQkkzwY7swOmczRj0uT40qj+jG7fr1I+ux6wKvv4+xqATMI+2ASWF2aov5owidGS+beSnT+JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+YJLuiyuyW3SyRdGjofpZiT0p1VWPklHQcK7kCeETv0=;
 b=APn6jb2XGkPxm6IB/puk2O2r+T2ZipKTD+08coig9qHgxJk+PEq0oj1NmtcqC5DiEVd0fSVSPeAcNrNICPSOMtWGO/9bSLOJhIiMtF9sGCUyJMc2JY8FoqVbaqqrThEEHZCqve48KqgcLT/Oxzch8e4rOuw8S9XvinM3cLeurI6vlA3X9YrAPJJ/jZyLmMOG569e4jEvrs8Zfy86lgmNeHTZuoJIt0nCqMzLU3dimmUrF/gQvZ4a4oCH7ayxEgA00kcDFo+f0qKqBbS/Z/Kf/2rkgl+MwDFc1cOsfzh3AcYOZklUWb70PJRLWQgMBlqAPUF5lATwObdGETM3Sr4oiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+YJLuiyuyW3SyRdGjofpZiT0p1VWPklHQcK7kCeETv0=;
 b=Xr4S24lGSeSnjxvPsGw8N7wfKpeV4ZAInGZZpvllmyPKObRJAzIiyO5C+rKTHhqE2uTkli+ENECznIfWMNV0LtWBsYSOvHZPqTCmHft8PuijH2TdS/Pl7YLmXNgGHjNdr3b4RqHAgM9l7aYMF5MT+WWRCqI4uZYTTnim52DA/bMn1u1fXTdB2Z400t6HF7Z7gbc8kzVRY9lwdIHpkBYSWlgxdiHjxrv3SMJ+MJk0x6mRg5Poju2eGakr0jBIvF3zUidjQw8R15cNyS2ERgPXn/i+FSjdzs7v5ycjvNTzAJCM2JqeNgFZADuJMrSHBSREdcrpDB9+FUelKOwpvSW3mA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AS8PR04MB8481.eurprd04.prod.outlook.com (2603:10a6:20b:349::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Sat, 20 Dec
 2025 18:01:16 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9434.009; Sat, 20 Dec 2025
 18:01:16 +0000
Date: Sat, 20 Dec 2025 20:01:13 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jerry Wu <w.7erry@foxmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] Prevent crash when adding interface under a lag
Message-ID: <20251220180113.724txltmrkxzyaql@skbuf>
References: <tencent_9E2B81D645D04DFE191C86F128212F842B05@qq.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_9E2B81D645D04DFE191C86F128212F842B05@qq.com>
X-ClientProxiedBy: VIZP296CA0022.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a8::14) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AS8PR04MB8481:EE_
X-MS-Office365-Filtering-Correlation-Id: efc8b27e-c3d3-4886-fcaf-08de3ff1c532
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|19092799006|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EW2Y5ERykBEqeEHmfhTAJ42RbORzIYmWhW1b9mAUfHbtgh1fUzgqnsfOIStJ?=
 =?us-ascii?Q?aIzTfqRI+1GT3iLzhw+jOeT7Iknts1snkeRmUfnVhA1l6AhXnq1yPmoSm1Q2?=
 =?us-ascii?Q?iI3o7tPc2/Yi/+zXakNg0thp1O3oCNCx2rt14z5lhDRt0dSEFyVrmOrRkQT8?=
 =?us-ascii?Q?D0DkxTvCAnT29dE8dBvvmavhCrPvq3HW/FPZAK//nHviBSNem4zu6XsB369d?=
 =?us-ascii?Q?aCAlZr7ptZUO/R9+ultTvSjzEMML/Zp5iyPpxRntkVnblJ8FGGjrXj2H+1cN?=
 =?us-ascii?Q?G2SZceM7iWxmFLGIypNBFBlTCrhCFhkteKXK4h6a5E8yFAzKTKC45du6xj+W?=
 =?us-ascii?Q?nToAFmqmx9lrqrVcusgsQqyVxxZslX1a6tkfQ7puMR5UiBWd+LaIh60XEIvS?=
 =?us-ascii?Q?EMx/cy7nw5OBAmvmZP+Y7wpBmAbdQPIPYXFsQrT7yonuP48mrEcNGWVMFfjx?=
 =?us-ascii?Q?YyGM6TdlNHywjaZ4HH416PImK0YpI2HBrybRkuph3VnejgtGAJDVO3PQwb2V?=
 =?us-ascii?Q?kEvaiFOoCGEG34k6KHNKfWFFE7C7NuERv6XDH/OeRjoeT8xwR1YNOI/6yNux?=
 =?us-ascii?Q?YEyGjSTYt0jCuFmWQMNN/H1Eya2+1Ikr634J+8uDJ84L/tYSONTsX4mN5o2r?=
 =?us-ascii?Q?E+2j9uJi8RfNo9qqJCZFQH7mA+64oLLJi3y/8mcEPHGLQ1o8UXyyCxqCEPYG?=
 =?us-ascii?Q?UiKpc7iA+eROixj878bYT4QEhuthRLKbHPBD1LatmsTC6D1CYS3KLZZY4nvK?=
 =?us-ascii?Q?JgOpte/Gv+Pd8EJGzoXS6QXxhPJveTs2pVgNy+i8EglPh27ZdPHNy7ZfSFoU?=
 =?us-ascii?Q?MFWTkc5jD0HpDNrpuGSJs0XyomzSburBCqH5TW08g2tqpjth5q0oyj+U7OBu?=
 =?us-ascii?Q?8KdBbQonjVlGZGssO/zCuPJ0gprri4atSyy9YM6lJAk4/UpNJBoppevk+Xcb?=
 =?us-ascii?Q?bzf2NladWDADKe8uJvcU4cGH4lfH2459s+SB5pgI/cg3lpIz/y1vjxaFr8Q9?=
 =?us-ascii?Q?mnrIrruEcU3JnF/hRwxcl/8yfniYIeomD8vIdw+BefkxN2sW08s0baceUyT7?=
 =?us-ascii?Q?2rMyfI5LBzWBNvxKrgKQl5Y+Dyfgq3vHpSzD+gfYMN+NYduTfnt4qTu0Wi4A?=
 =?us-ascii?Q?YITN/JSIEL6DHpr7q4rqbSpsa5aeyeqjvRKOQNG45LT8TWAA7F2dGL+PKHGO?=
 =?us-ascii?Q?uOUNKm6/fZPMPxQikctk4AT1MioRR2dL7N4NkqubDd3zVz/K2WD3nk5XjJpN?=
 =?us-ascii?Q?okMMTC8zu+OvN3nEYsmN4FDDpX3+tQmHLACD9sdr5xpRR7AEN0vz/y4YtY8z?=
 =?us-ascii?Q?SThnHPTYH8iHMp5jrOO8Ke3rqV/I5Swp3JEwGrEttdGb7iWWcDV+Ok7GRQOc?=
 =?us-ascii?Q?wb4JuSAm6yFNf9JjY+/B+PlaNq4JvVMHtar+qMvdoOsIOaG9FAPD1oVAhKGk?=
 =?us-ascii?Q?UX+twqwtz80W6buEFSvnpscKc+MrhxOB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(19092799006)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y9ypWl/7DgtLsusvPU43PM2C2bVssYnTHuf95tvLsa+S/lo1f5iYeI7ughZ/?=
 =?us-ascii?Q?C0m71ecuTCOm7WHXFhGVlFQdHzrWNE7mWw21SDhml2JgV5qnwJJzrXMh/cbw?=
 =?us-ascii?Q?aquxbx2GXzEuE6pcWEf8W0et9VgjSpo15LxRvT8aDM1k0RSp6uXQLUuFHpzL?=
 =?us-ascii?Q?fQ/W1TLlGCYjUob8LyPBfkTmmF+3IZpYu+/NLXao/kg5NVnQrZpe8lIW+YL2?=
 =?us-ascii?Q?Uhsm+kshCtPozPmcCxwLO5gZc8WNQHj4ng7qzXQYMiDna3pFBHHGZjMiQ05M?=
 =?us-ascii?Q?GSLHQ/XNvs7dgocEIclrw1a3/AbZ6TnOgOdAfogBNQC0yJoBkqJnFdTtge58?=
 =?us-ascii?Q?MZlvfXEhflf8M8LVgNIjy5sOH7m496+iyAlR8+ikywPv+1IpgJzlwK7Dw+vA?=
 =?us-ascii?Q?jmVR6ZbKlVMOxKfmHywr8jtoDY6Yj4fWDCBbbhOwI1rQBNt24XW6fgPZ4qXb?=
 =?us-ascii?Q?fSoFIfvAak1hxdpbR0MDJow4xrubmLy9VNzo/1Qp/T9+Am1FVp5JcYSZ0q6O?=
 =?us-ascii?Q?hrh0Rj1ImdVjQ1ZrZafh7lzOzg5Gk30uPUkX3pTfydylv0O7xcdnVJo9Y9zI?=
 =?us-ascii?Q?zxv5y7QqpH2gDxNnz4w/N6AjGZW6h3MWQtKR+/05FLG1/MGJzo5fsB3SGHAl?=
 =?us-ascii?Q?hmhPTFxcEyoiAQBbNREJMYSQKf2kgry39JIlTKfQnV3FNF+chkXOdftQEh/q?=
 =?us-ascii?Q?xonwt/cS81UZHS7N5x1fzTKayatSjxRSCp0dUVaQ+JVaKDMlDa1XSB37OvwS?=
 =?us-ascii?Q?M8iMCXd7Xn/9VmpBh5HjGLbw285mDMOJOvQIVMciBDr+mvuse01+eYLiV2gX?=
 =?us-ascii?Q?bOAIRRqgDTWM7XQscRnBlaPNq0Z0sFHFJlbXyvoiCefrukBHXxT3ZWQLhNRo?=
 =?us-ascii?Q?BqkdP5uB/TeoanN5a+0CAaPaSarFv5tC7LZWYaiYcfMwcbolvpNqIuuisbJO?=
 =?us-ascii?Q?BLKmiKp6j/2DlI4VC3YFTV7dnQo0M/7jvTs2JRY2U5zChoBqQ94iVCrCbQ3M?=
 =?us-ascii?Q?iQ0q7NYC01qnLvNHO9hoeaYleVrrpPErO8lQzXZ5YbCwzMmv0jrqoj/qUOM2?=
 =?us-ascii?Q?uxd/slj03DKDJPrhyQIYIo+rgjC/z0JbWxG0Ib8giMcbEqBFjPfntBB1v9Pw?=
 =?us-ascii?Q?sDiAmI0UdNEpX6rCOZQftQeXz1EUGcFIC0ex6rH8wUdpUm13S90rGh3FY8Jg?=
 =?us-ascii?Q?KkrbZwuBJoVSxl2vgX2Oj1ktuOc2HdGCbmZyWcFMD44hw+PN6bSbMXycROYF?=
 =?us-ascii?Q?XdR0SLHW0JGTZrxkI06SnDPaJVNyZdOIIWCS62lwn6QsBls9KD5qvBDXHdRb?=
 =?us-ascii?Q?bhc2U/v8RyoLqR4wTTPbe6y7g5fXWIjpR2bzB6vkmZOXxSRx6a3/iAn+DiFH?=
 =?us-ascii?Q?KdieiCnhgGzNw/1lkzOh4/uERQw6FH0dO0XwJCbpvgD1L1rb8Zkdcvne0k5Y?=
 =?us-ascii?Q?zPYLSFoCFT1i7rFRLfC3Qgx5hb4NeB5BAkPc8j+plepXKweYX1vhcAhm7Ctr?=
 =?us-ascii?Q?T/5qPg7IkoSOxg+DlNzVMReNSF6zVWitVXU8xKw6quaSuE6QpMQ69nQRu9F0?=
 =?us-ascii?Q?hR3p0yGdjUbWll5PcM9EZa+2wOmNZ83AhaEUsuFsK6tLuKH7+gUfDITB3/pP?=
 =?us-ascii?Q?mU9+KqAi3bZK4q7HaTkjqiDQWv8HRDL/K2HA5JSE2QPpwJDg2DJ8Obf8SKQx?=
 =?us-ascii?Q?7rK6sBa2FSekE3hTSeN1h+RRqg5h7y+jL+WEYOWc28N4fpb8ZHmnz2q6/3RI?=
 =?us-ascii?Q?b4rqB+9jQsBcAGNQ+Xeb0hbc30iBnxNvUgE2JyEPLcjCS2e4CtiZLePui1Ox?=
X-MS-Exchange-AntiSpam-MessageData-1: d/kaLUtuT0arNSQBJvEFtcsnwcoeAnI7QSw=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efc8b27e-c3d3-4886-fcaf-08de3ff1c532
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2025 18:01:16.2150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Evtls2bcgTXQl3/3w/qgOgq2zSUaR/vWJx0BuhM/+dvWVWYFHbHHUF5NLCJKsghHg53h3M6IMR7vHocqCugXGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8481

On Sat, Dec 20, 2025 at 05:32:15PM +0000, Jerry Wu wrote:
> Commit 15faa1f67ab4 ("lan966x: Fix crash when adding interface under a lag")
> had fixed CVE-2024-26723 which is caused by NULL pointer dereference.
> ocelot_set_aggr_pgids in drivers/net/ethernet/mscc/ocelot.c contains a similar logic.
> This patch fix it in the same way as the aforementioned patch did.
> 
> Signed-off-by: Jerry Wu <w.7erry@foxmail.com>
> ---

One thing I forgot to mention is that you need to add the
"net: mscc: ocelot: Prevent ..." prefix in your commit title.
Compare with other commits on this driver and try to adapt to the style
used there.

