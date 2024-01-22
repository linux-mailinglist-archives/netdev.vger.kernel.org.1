Return-Path: <netdev+bounces-64600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBA9835DAC
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 10:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53DBB1F25A55
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 09:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1016138F94;
	Mon, 22 Jan 2024 09:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="BeB/gHnP"
X-Original-To: netdev@vger.kernel.org
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2153.outbound.protection.outlook.com [40.92.63.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5349B38DED
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 09:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.153
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705914612; cv=fail; b=I6UZQQ1M3Fasd3m86FzPreZXPrh72VeedAxg12DAbACGNtDpKkHOBhSDyUSoO6uSn6ld7WC81jSxK3NLdcmhs0E9yKPT962XoMwNG6im6S8OYIutFVNXrLcN9pQPgO3x4N0VMa8bLrBS3cuSMhgSwckK5ayTRfdZeUqWhAQsxHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705914612; c=relaxed/simple;
	bh=y/FKn6/JtvkNHe5Yl7YGjeQ3xnE4sRSYLKuaOmfcZsI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=F/yjUpNMEUxVahUZsuh6gVUuTcJh9fV26f9RjUxJGPRezDBUybeyz6rAs3VKLHpmVABT1OJ/pVkx2CZR8SXvNnDdOGkBN8YbiACSH+Wk7gCBeujaipVDbhcRrL6vFx1baQirfgrMG1UtmUw5VqpknITCAsXVEsAASNXe1DU1VzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=BeB/gHnP; arc=fail smtp.client-ip=40.92.63.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NsBeBWEGHae6e+MzV317UG34Bj25O9TH4sUTvfHUB2xO3y9hV7/JO1zOzDStCEx6cFJhaXwKO3p9AsdeNAb6wtMbglStmVNtE1qm/U45RltPUS8v8e4y4RyzzJ6afUh1/yFEIAW8UrrKs2047xo4nrjbRKKrV74Lj+EwfYCFI9s3XMhZzLboTrniVeAnfvlgGplFxYQQ3Og9sNJyUzf1x0sze0Nei3Is81RttMeaxGPEwDjayIdc938l2uC8c/aI3kshW38bqCKaPsWUAUwoDvgnz6M8de7profpKPLCp4cNvJfyG6v1LIONaODZ+tTJ76KmhCDeReDXQTCat/2Vkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zKauP3fBPP/swl3BR05m52Ch95A07rG5Kx9lSf6I/4Y=;
 b=gm3UwHWM5G0Q3Ow6wUR9nGHM/IvP95RdSPQDHCYeD52adUFBphbZw0+GAxNZljB4HYQe03DSrzaCKNM1OZ7lsPcneoggKOrXqz9mBzPlFYw76fmP2KOLemaRkWmv5Oh6Xz3wOVmVJvYdajdJppGdMtaC9hTCGA1rkfOWPa7R3hQ0QrqfHspJTnbQMEbD3AAP0ahOtVPyvAW5x+ck8mjiGpAEw0bJOtTbVsZ/SsKaDu+0prKBm3NDiAMaSSbJi7d43/y3OuWmXMssdUx/fp613+iTVIXx252fw2q2+pp/j1Zs3UkBld/U+lGmEZeGAnmvSCLYQgbFROu/sz2EWvdTpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKauP3fBPP/swl3BR05m52Ch95A07rG5Kx9lSf6I/4Y=;
 b=BeB/gHnPIn9gmHBTFEq/OS73iqEyt7+NKMY8vnP770WwuuFtmjsTTrtw/whLVdyPefJopOQZXmlgjnHuI4Hzbwi/og10rsTdOsVppGZPu3GItvP/vNjh2bd/dzJtv++fNzEjTGmVJbDpi4jf4aAG3j5GSk+toFaT3/5hXk0lBrLZKQKPxRJIQH0HxOU9ghDlgiL+MYi56cos5p1GDSMdXpOI0GERUKFz+lkJfJGBZg6SVlSinJVaHShnahXo6UyuX2557rmSZeqid1EaBxZcTrkS68X2icCB8Pbo2rpjyYThSK5pwk8I8sZ3fkT14qnJKmYOGi3YyEa/g77xKxsfow==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by SY5P282MB4893.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:26e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 09:10:03 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4b5:c5db:e39a:e48f]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4b5:c5db:e39a:e48f%3]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 09:10:03 +0000
From: Jinjian Song <songjinjian@hotmail.com>
To: netdev@vger.kernel.org
Cc: chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	haijun.liu@mediatek.com,
	m.chetan.kumar@linux.intel.com,
	ricardo.martinez@linux.intel.com,
	loic.poulain@linaro.org,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.com,
	vsankar@lenovo.com,
	danielwinkler@google.com,
	nmarupaka@google.com,
	joey.zhao@fibocom.com,
	liuqf@fibocom.com,
	felix.yan@fibocom.com,
	Jinjian Song <jinjian.song@fibocom.com>
Subject: [net-next v5 0/4] net: wwan: t7xx: Add fastboot interface 
Date: Mon, 22 Jan 2024 17:09:36 +0800
Message-ID:
 <MEYP282MB26976C795504953B0EE632ABBB752@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [GiJnRTLBMnhIomBp9hWFeR3P0sfbY8j8]
X-ClientProxiedBy: SI2P153CA0010.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::13) To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID:
 <20240122090940.10108-1-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|SY5P282MB4893:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f1f5b14-eab9-4b5d-5fbb-08dc1b29ead8
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2facuYjWFpuBDEmjWxr/8zFTUr30D+V1Ui12Xmm8/TCg9qS4V78Gg9wsL2sXvmYbMVFiUQ6758pMKAFuTcyRcl2NTmtFS7Tb761s630TA/A9Q6P1L12Esn+X5S+NvvtTv8//3xs7Ph4Q02bqw384Q1J3ADOeb38bAGt7coNEOyGkEpYKZIRM/hEZ5XlRl7fm0hR6dlr+Zm+MVVHtt/SsaDqz4q8IA7jgFMbwjIWqbC+nqBeTdNZpv8KORp9EG6GG54JK/B6XwOD5WdROAnLbHH428x2OpS6pE8o6tqRn9J4droLRWjj4K4vM83/o+ETluejoh/rGnv8cDqLKZ9bOo24aJ8YCQfgvNKriZ+xMAmYqiDJu98odzV1jvwRLeSm6THOMNu9hICcallDSzGHJMZz0kyzMG5KBZ+uJKtXBvkLqFY9W8P/uAavGkNUQvxJQAbc72jEsQh9r8TOGAQrkCcGdUOTAwoqX0vPEiD1FuJcDMczzrfywwJQDpprcJrIb/spR0iQrUeWrM0gni6nrymMGljcQ63nvhzclPdzcxo+8OYNcebYZjtgN1x9V719d
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WF9MFDPfyMwCdCb33UbKVy13TTtfXeK2ZWF4rErxrYonzyCZpoA7yzjhWEbx?=
 =?us-ascii?Q?B33xiFX6cqFN0TSOfdmRjFQOaKv8G4WerDs4Fgm+yGPsw9AI+e8EAreeZOnE?=
 =?us-ascii?Q?87Fycu8tAmF7JyGXRyXucIBt61QAw8MUGYKPxfswkixtI2s2Duou80CZ8qHa?=
 =?us-ascii?Q?XumJZ9PGeG7+zE08wpaL28ZXh87IEaBM9U/ZGhahO2LJMgYzAl37fn5m1gPt?=
 =?us-ascii?Q?Y0cjM8Lhxf0C2L1a9AlzAtxFef4/cK84BKZz8GJOTNaZ5A4J2by2ksRoFoYE?=
 =?us-ascii?Q?je62jtlg3Ojd+16b5/SXA5RaG984HP5V+sayvaUj+v+fJXKe4PIQNenujcFq?=
 =?us-ascii?Q?JUzqRqg4FVv87pCx6KKjvIOeVvJd0VO3nxgMMPxpmDWAl5rO1yM+ORnZxf+J?=
 =?us-ascii?Q?lqw+QquUlQ6sBfRd2OUKLZcChRNFob08H4goeFXkXpaf7bbFs5VTWJIBknyz?=
 =?us-ascii?Q?DUBymnwkUHqp5EeiBrHGNR2YyY8eV5bK8lk9t7dXUQWJb7XLfU10Y+FKsZjY?=
 =?us-ascii?Q?BhCm7qI1F7A+7QpWTj4W6zlst6YjIbR6CHtqQopmPiISASDcgyIJv3JEr6+F?=
 =?us-ascii?Q?b22RU46L/PKXkhgh2vUilow3yhA/tOk0qaF8KcT5XqJQutXy52K0EkCgtn4g?=
 =?us-ascii?Q?V9tKxRdtPaHQIL9c3XVuPo5sh11Vsnb31wK80kozo728G0FgozGfru7VAzMy?=
 =?us-ascii?Q?NPHXd4KLaWJ8FYqE1jlrIeSEugdze2BRzoNRHBZUb8HcgSREl8yAq9kTixLt?=
 =?us-ascii?Q?7SGs79ts9wG1616Vfj0vRphIctJeiJoUaGuEP7mNi/f5qqEyneFyeylCLkqg?=
 =?us-ascii?Q?FHu+lcq2npkQvFsHW2g883bM10go2WnJNy9NBpdeh8dSR5rLnw2gehbzFYLa?=
 =?us-ascii?Q?vC3tfVkxbLx18AaymlCw0V1vn4t6MPzNTGmZTR8yz7aSCntsbQEsR+iHLomN?=
 =?us-ascii?Q?0ZPCFk8yVG7yB7yi5Mq2NoDUm25N7XFxdEgOMJQluxUx2V6ZGS618187qCxh?=
 =?us-ascii?Q?aux9hs2l4N8zIpsVyNPjur9LgXyyb6J8V5WwFFf/Tj6Gg5GFBKWZI1rtNKXH?=
 =?us-ascii?Q?I0Dl+FZM+IeeEW21SjCKm3aN57QSKoMxpDPaGkWP1LVNEmq5GCiVRkbjw/8Y?=
 =?us-ascii?Q?8FOHdxYx1hpB+J0W9zzAg/qGlZxZJAGf9XXcASip6nHaE4A/JK0sGfIbvuB2?=
 =?us-ascii?Q?2BOiIoCSTVgdjcWyhEN4Y6PJzcgBdRje/EFIb985NMi40JiqEAJ2xJmOHHI?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f1f5b14-eab9-4b5d-5fbb-08dc1b29ead8
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 09:10:03.6791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY5P282MB4893

From: Jinjian Song <jinjian.song@fibocom.com>

Add support for t7xx WWAN device firmware flashing & coredump collection
using fastboot interface.

Using fastboot protocol command through /dev/wwan0fastboot0 WWAN port to
support firmware flashing and coredump collection, userspace get device
mode from /sys/bus/pci/devices/${bdf}/t7xx_mode.

Jinjian Song (4):
  wwan: core: Add WWAN fastboot port type
  net: wwan: t7xx: Add sysfs attribute for device state machine
  net: wwan: t7xx: Infrastructure for early port configuration
  net: wwan: t7xx: Add fastboot WWAN port

 .../networking/device_drivers/wwan/t7xx.rst   |  42 +++++
 drivers/net/wwan/t7xx/Makefile                |   1 +
 drivers/net/wwan/t7xx/t7xx_hif_cldma.c        |  47 ++++--
 drivers/net/wwan/t7xx/t7xx_hif_cldma.h        |  18 +-
 drivers/net/wwan/t7xx/t7xx_modem_ops.c        |  10 +-
 drivers/net/wwan/t7xx/t7xx_modem_ops.h        |   1 +
 drivers/net/wwan/t7xx/t7xx_pci.c              |  98 ++++++++++-
 drivers/net/wwan/t7xx/t7xx_pci.h              |  14 +-
 drivers/net/wwan/t7xx/t7xx_port.h             |   4 +
 drivers/net/wwan/t7xx/t7xx_port_fastboot.c    | 155 ++++++++++++++++++
 drivers/net/wwan/t7xx/t7xx_port_proxy.c       | 108 ++++++++++--
 drivers/net/wwan/t7xx/t7xx_port_proxy.h       |  12 ++
 drivers/net/wwan/t7xx/t7xx_port_wwan.c        |   5 +-
 drivers/net/wwan/t7xx/t7xx_reg.h              |  24 ++-
 drivers/net/wwan/t7xx/t7xx_state_monitor.c    | 128 +++++++++++++--
 drivers/net/wwan/t7xx/t7xx_state_monitor.h    |   1 +
 drivers/net/wwan/wwan_core.c                  |   4 +
 include/linux/wwan.h                          |   2 +
 18 files changed, 613 insertions(+), 61 deletions(-)
 create mode 100644 drivers/net/wwan/t7xx/t7xx_port_fastboot.c

-- 
2.34.1


