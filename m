Return-Path: <netdev+bounces-194764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 777F1ACC50F
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 13:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65DEC17369E
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 11:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7013B22ACEF;
	Tue,  3 Jun 2025 11:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Qc4+vsRP"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010030.outbound.protection.outlook.com [52.101.84.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EDE149C41;
	Tue,  3 Jun 2025 11:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748949082; cv=fail; b=iHgtKPw4wSymeYALKbkeJMXVDmWuNl1gAF8F45ScnmBbc54zpGrvfdsQZXrmDdsF4679nSOLfJolAg6bpiX58jQMCza2zZOTKV9b2W7naXZg2JeepAp4WdBZ0YD4ZE7MxhxsqiqHbRnrq3/lgHsMzOebSNhqt2CLpdS0Z5Ubh6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748949082; c=relaxed/simple;
	bh=cmwqfcszbeT0XzRgVoenGFA8XvfEuHBtJDXq0zqnd0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=U1fu1mwpiVSQnsPk05t0xHDJrRawYqyLRbvOSWys+JPaGOkqgjlhx1w2p1TAGJZhePBdNO0gs39OCvpLzwexbs/Qkenj7Rmy8c8x+LNCVkDNaTWXxFse7MhbNRrX8yIGO5o4woutOkbB1dYeb/+80QyxAqzyRlNWfKyejrH+OYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Qc4+vsRP; arc=fail smtp.client-ip=52.101.84.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jj+FJpzO8pu1X4oVtJc23CSxfvljVmFLXD+o5aPEomLmgAnAUUGG7E9FKwDhi21WJPx2O1fbRyJ/NJQkvtLPOGIyOGmUGTeQYFYMgAPCi0BHMWrsZTf5nrSK7vidGaY/8KbPUXfm5IqF1CmtwzhCpHUonp48jCmSDDGoU0dAXUjWK3lVt3RsgEE+AjJMTWKkna8GRQP2TkqyQxPBc90U0Y0yrXt/F0vcyuVzG3+DiDmzKJAB2Fbg6tbH1Nnd1OnqgGdaH+IrlyVdHJqEqhT17Q/n5trGyolUeiLzI5YLqUrdaLyPevBs7X4uj2gtPkWqkMVpyBmjev9G6pW6FlkGMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZqCrGQP2itdV/BrEbAxXIGWcKLKh3dB3khO48Z0JFM=;
 b=F5zM0iyVImdXLV3kF7gU8HQeL8eyOD7z209qKiYU+M+wzs4lwTz1+XuJ9zcLSCDlY8hVUDHmaY22vf6WRVOuAf/SUaQPvJsolukjkSivU4VngRdLtx/rSDkdTyoHPq7vD22OkidvDQC6pX/xfgBTUeWEj2umdTHeC/Of+uESjRhpliQazr8iUn1qiqKlSQq7DBogdyN+Z3+QDTUth1jfj9VYYjEhFsJIJxnBhFMKZwcS7bm5PuRd7IupHgPUlI5l7NxPp4O7kjeRxGxnBmKptnGTk20Zz7QV0y+Jt/AveZien70CJKIKCxAgsKGNpWZjpSW/XMWKVNx/1MMwE1FWog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZqCrGQP2itdV/BrEbAxXIGWcKLKh3dB3khO48Z0JFM=;
 b=Qc4+vsRPxMIBpTvJayIkxW1WFoUfgmMKwfBA/dTzH+3Z/E8YCDT2xGxAr43l8YdOeniSGYTdYW+1AGcuC8RhvQMv09BtXJbCz1TUV2Ni8N4Pn7g1yCWEFAwoYOVQ2HQEJZwjKECyfJoop1X/OgYepmbzXQZ4LCqKdli96kOEKeV3AFdUzjmKiIucXZWOyNemqy2ASCUkhxzg9q1vQyNJe59WeZwFZ6G5Bm2pBPmCniEEAsTPz7DJWW5QFdewI31EgtHAMfF78arxPFgVWQvct4VRoy7fbR0hTOIGXAkZHMrcIRK5LQMHJii9H+JSXmFmSY6UBjVpNgZklaSmBNvuRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI1PR04MB7197.eurprd04.prod.outlook.com (2603:10a6:800:129::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Tue, 3 Jun
 2025 11:11:14 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8769.035; Tue, 3 Jun 2025
 11:11:14 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	arnd@kernel.org
Subject: [PATCH net] net: enetc: fix the netc-lib driver build dependency
Date: Tue,  3 Jun 2025 18:50:56 +0800
Message-Id: <20250603105056.4052084-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0178.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::7) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VI1PR04MB7197:EE_
X-MS-Office365-Filtering-Correlation-Id: 22bdc941-e313-4e27-b8cf-08dda28f5a8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mtO3+bESIwQPNwK4N+83JrBR950oLD/hGG5PaPPdOFOlT0PlC+SxJGppZrLc?=
 =?us-ascii?Q?2hzOIj72k3zNFI4GPvkpKlkpIdRdpkSjJLO8TMkW7IyrqksuDn5kIQ0Z/sQH?=
 =?us-ascii?Q?kKrRRpllyvH3xXQyHzBOgZbVFIlJZa1AOxNtRADGiod9iuuqgbBph+D67vXM?=
 =?us-ascii?Q?iUxkTaYU8JgkacEnP/R69plO0PC3K6f/BSkwul+SwWkgtn/3TsB2y3AZzdRY?=
 =?us-ascii?Q?O4yHoVgmz55hLG1GdwwksdU3nDKABVnjzB5cysatK982ix640FFS217Ioq2U?=
 =?us-ascii?Q?dEiNnoKDryN0FphjkKuzk/VJTL9QgB8yYXJGctFVmSwRrG3yQCW5vwh+lsFe?=
 =?us-ascii?Q?ogVPLnbUvTBHY++Y2oEn7wVI3VMdtPA1BVyn5R6EE4jM54TAA2FjzmC5cjhh?=
 =?us-ascii?Q?PhEA6/raK8cf18/2zWZWoC8kK4KMoTO6uzq+gKTGJv9phGHTjLubjdyqCFC7?=
 =?us-ascii?Q?DaQNHUEfg7z9d9KAsCTnvxgDINNgeZuDB8p6t7t8nZCPb+p+skyynDyOQaqW?=
 =?us-ascii?Q?GsYb27BqhBcNeD3ZVzp2yfmkJbgApdqlKUpJbSZk8b36rmuH0lZLpnzu/fKz?=
 =?us-ascii?Q?R9tgKpqVI5sqj7yXK6gsbj8rKiQG5qdItBnvPLK3QcY9Vs0//T60w+JuWwk5?=
 =?us-ascii?Q?DWjrRMFKuaEvkyGytDPrSzi5c0T+fj/+8nznVDb4COiqjYlno3n+BSYnHXoF?=
 =?us-ascii?Q?5G51eKjnkHxgQo1+6btlDxUuughab0PmjdesmVJaYDC3m4NPdIKEb/fxquMj?=
 =?us-ascii?Q?2mTPe1EH9jYCwfjvOUCk236Vn5vswDxSZ4QcD4UvzAnL1fc6R04nxOTl7tue?=
 =?us-ascii?Q?spHiUhLtRojapNTpHEt/VtgjraXixxHOJiv5nQMq1uPMTzhMpWK9iKv5Z5S1?=
 =?us-ascii?Q?0aGDN1RcWrRtO3OkgTW5OgIH0M8GnjWmXKMEIsCyyKXwPQ0E3Bdblpncl+n0?=
 =?us-ascii?Q?JwNM+PrJAYKHKAJ3KR2syDIT0lzIoumJccZPbOKRh/EgjsOBMMJeP2IGGguw?=
 =?us-ascii?Q?eFeoY/N3XO3njvR9Mh7e17bhpM/5swA//0hLgKrxW4b7XDD7ObXjCYsr92q2?=
 =?us-ascii?Q?X9OkLCfSB+HpOP4059wrPwqLBvLhh7aXM4PdLYnX3gpjlslAD2XxHHPYPy5p?=
 =?us-ascii?Q?pdXHKWVE2BF3L746hau/KksHc/YY++nON/uz5hRX6blirpqDiGzP8haxuqQO?=
 =?us-ascii?Q?N7f/voy5UXpWVVDG4/aJaKaSNHW9jrXsypRFrFgHZ2uG8ORlRmkxMiVT/R0E?=
 =?us-ascii?Q?SXmJBTfz6wt6KEMj8wA1ww4u3v21Yv0vCe0xg7xJ0KGqjPjD36EdqoKBQ8e6?=
 =?us-ascii?Q?03xZZqvi+YUTWkY8BQXH+LapJafTa/+6H5PdlJTv+u2i/1tHfGMAbhLu6BW3?=
 =?us-ascii?Q?bpu6GFhkyUaDX+EK5ee2CWFOxaAPFKIGqd+pWfRMpmEsu9ANiylQBHVZvtrt?=
 =?us-ascii?Q?YAhRBvk1s2PZrkaEMwsDdb4PGwNhW1h4EhYdU1QQbCYp+QRj3LdlptvhTQZd?=
 =?us-ascii?Q?jbvOj31Xs+0fn3I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rNnVhWlvwGww62BXVhiCN/tg3n4QNfrhhfEGqfrxe71+14TGa7ar6xT7XPlZ?=
 =?us-ascii?Q?f6tJQ3kHpeP/XHIQYJaCMF4pM7n5wGs+FDgTq9HiW562SZZgD2lltR6vkTG2?=
 =?us-ascii?Q?TqVU/b+lfGrdkXiq7xf8mWvx5SKqg4LIyasXiToB3oHGQ4/uQUE2p4PD+ygC?=
 =?us-ascii?Q?li8eGY+OOHIS1T6XsInZ707pe5OfmMarx9hjjBy0ZQDn2wY+zL7mE/zc0Q4w?=
 =?us-ascii?Q?KH3tA5G+Br4Sl7+PPTreTgT3r3li6XXXUhtFdzPxDb/EzBtMyEwAu906sq9Q?=
 =?us-ascii?Q?flXhozodM6LZ757R9VFQRl4z9kR1D4tLUd3Gjx9b1L02L2JOg8f29FyGWa9H?=
 =?us-ascii?Q?fFqNLgjuse9xFNIK44LmafcTo+BL1J2jOhA558MbHF03FR/hharCnglJesVA?=
 =?us-ascii?Q?aT+YM5B9EJv1HAQhN/2X1ZiC0oQBJLjSrbY/0GWN3jt9VxVVphR7uT+9sfSb?=
 =?us-ascii?Q?44FBciGjsgnLD6Y9GwIdbIK8zVMnRvHCpCqx9uM5Yq8YnRsT6rhIUcm84TjH?=
 =?us-ascii?Q?4rRl6+q5w5S55DhGfZ/jML5denacnGBFESWABqxGRMm/w3PZr0bAxfHmV+f+?=
 =?us-ascii?Q?oF4uoQhQV7TlmeEKMtTm8gX7pD047Itq8QomovBUcImkgUtCqulmmUEfh3lq?=
 =?us-ascii?Q?sAGe4/FOEzVpFRJeyGV624jJdtx6xlqQU8E4jAzBGDXB6+7yfP+Qu1j5yA1H?=
 =?us-ascii?Q?arXDsMbCDYUwapNnNwlviElWdNbPiSOrymux/kLloA9IQUZ9dA0xSrzq5lco?=
 =?us-ascii?Q?cyxpQVI4TkD9ROSLpuUyo024syIkKzm0lbjbrwH0PJ/ID+HYsJZfb0YUrPlV?=
 =?us-ascii?Q?JJDRXqvwWnAuCR66+QovYUFmKZlhEX1ew3GfO6HXjiYfQh7ebIZI0cuI6FFG?=
 =?us-ascii?Q?f058J54orkVqIu/sJKW/6WCQkPhFho5RRit7SvnwDSLjrpLgbkNTXU93Celg?=
 =?us-ascii?Q?kP7Ery/v8FgI+WQXdPTOXyDzfuUSMLUi1PmsAlpUzsDRKH4EspBHEuELzeCz?=
 =?us-ascii?Q?ClrcGGMkzVKbhYMhIPJAfF8jI3bNpT5czco/aUYcccI4qr5u9jwjw9L/S+p5?=
 =?us-ascii?Q?DTrUm/ZGL4b7CFDBhUOgvJ+NZBmAjAeCu6z+6iE822GHnJMKhw0XJPUj4lBP?=
 =?us-ascii?Q?2LXYTA1/buFJ4QtPbetA9PYwLLx2aOdZ+aEFRG6Syi8KxFjb9udVEhxoHAw8?=
 =?us-ascii?Q?7fH/G8iwMbRhLprgIRmmioIP2DqJI6z+cB63Zg73658uoTTJm+AOBeMnVzQO?=
 =?us-ascii?Q?RPyho4SmzlQZDWoHzjYCVl9O/IZxdXT5Ba/3m5YxJEvDfkklHd/fJg2952HP?=
 =?us-ascii?Q?Cchb9fGGXQzkpWeozhU1I0U15Q//4zOFVpZniajen838dol5ge+RFK3CZ8aD?=
 =?us-ascii?Q?W0nUwKVhUKR9PgB1tpjNMtUzHsa1NSR3TF2YVOPbS297RaBO0OGd0vyREcD0?=
 =?us-ascii?Q?j5xbrbJInQNRoCJiILdEQDVZkDzZ5jo2h50Ntt/dyucZOp4BhiqyrUjmMBt7?=
 =?us-ascii?Q?GzgrAFxQxIl/L24iDO/NUb+KVSU035IclbyKIgo+zaYpIuCx0JOlJ5xu3AEp?=
 =?us-ascii?Q?9QUqfo6+c1yZ1hINjYuXit3SEM+ocinHFnGz34Cn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22bdc941-e313-4e27-b8cf-08dda28f5a8e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 11:11:14.2997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +BOODE8UREkCWfUKnnqzPnykMDe5KyEv8OrGhGEW+x2PVa8UNkPYMdI9orVHlLNrZrTmTXqotHegmcXKwdTpjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7197

The kernel robot reported the following errors when the netc-lib driver
was compiled as a loadable module and the enetc-core driver was built-in.

ld.lld: error: undefined symbol: ntmp_init_cbdr
referenced by enetc_cbdr.c:88 (drivers/net/ethernet/freescale/enetc/enetc_cbdr.c:88)
ld.lld: error: undefined symbol: ntmp_free_cbdr
referenced by enetc_cbdr.c:96 (drivers/net/ethernet/freescale/enetc/enetc_cbdr.c:96)

Simply changing "tristate" to "bool" can fix this issue, but take into
account that the netc-lib driver needs to support being compiled as a
loadable module. So we can solve this issue and support "tristate" by
setting the default value.

Reported-by: Arnd Bergmann <arnd@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202505220734.x6TF6oHR-lkp@intel.com/
Fixes: 4701073c3deb ("net: enetc: add initial netc-lib driver to support NTMP")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
Arnd Bergmann has posted a similar patch [1], but it has not been updated
since the first version, perhaps he is busy with more important things.
In order to fix the issue ASAP, I made this patch. And I added the
Reported-by tag to give credit to Arnd Bergmann.
[1] https://lore.kernel.org/imx/20250520161218.3581272-1-arnd@kernel.org/
---
 drivers/net/ethernet/freescale/enetc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/freescale/enetc/Kconfig b/drivers/net/ethernet/freescale/enetc/Kconfig
index e917132d3714..06759bedb193 100644
--- a/drivers/net/ethernet/freescale/enetc/Kconfig
+++ b/drivers/net/ethernet/freescale/enetc/Kconfig
@@ -17,6 +17,7 @@ config NXP_ENETC_PF_COMMON
 
 config NXP_NETC_LIB
 	tristate
+	default y if FSL_ENETC_CORE=y && NXP_ENETC4=m
 	help
 	  This module provides common functionalities for both ENETC and NETC
 	  Switch, such as NETC Table Management Protocol (NTMP) 2.0, common tc
-- 
2.34.1


