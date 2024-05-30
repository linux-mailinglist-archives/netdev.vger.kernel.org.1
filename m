Return-Path: <netdev+bounces-99473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A6E8D4FE9
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 18:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A028E282D9A
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 16:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B172124211;
	Thu, 30 May 2024 16:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NfzwVhEc"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2075.outbound.protection.outlook.com [40.107.20.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7DC3CF4F
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 16:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717086847; cv=fail; b=omHX3gImlXMTDLY26Zfq05nWw7aSIuhwnS2y+8rkc8sgrIOAfT8vDh95qpiox1nn4n7jkD/F8QNPq4hoZCI+ResexogGIUQ0k1bIMb1zAMtDUDa87/wGBxe9pfEnhT6GgxY0M9QDmZGCxKnGAyHmfz6leVe5BRGTsdDp8abchMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717086847; c=relaxed/simple;
	bh=zAOi82lwElbWjk4sX9r+p1R4tyCTGDDq9+/D3EuVCPg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P1QRlLenyolI+gIgN5yBOPqB3h3mdCuSgr6/J1nUGAtbarA2ssiPM3Ki5GiowsacL9sF1oK3j75IVcYwFigZq12HOf2Vvdn/is/+uIjsdsqk6TWg8lV910SSHthK9jhcNcrh7+WtQZ832ET55McBtzsgce1za70/bqUYwWWteDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=NfzwVhEc; arc=fail smtp.client-ip=40.107.20.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQuCU28V4XpIjOkeCPaZvBepTUvxGA63aQ/fVS7NPaRYjQQWmoRUPvSepQY+Y0x4HAJqgGPjkceb4ouogkxQNVOnugJrmsczDc8o5uoP3C389I5ZrLp0HnPHpFE6B8mFzUlCHrqqcKKdb/+MQ9xrFE1Bx+A+OU9AqKnHI5hzsdp36e++2t11TP2lFL6yDqmbzueDmlZKyS4m2Hnbu3KoRaHmiKV383BfA65VFHael7Qzbkv72OJ8goBGahnXp+TVk0k8dNYtH9xTWQoC8jiS7iOE4flp6J1/LGwENMFtjtqYzAVk/4BWmKwFyI2ULUg1CykR5r8hxRHoxHuHoCVDGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8S1pJzufn0aVv9s5+81QCgIoFK39A9YFq1fhAFT7dls=;
 b=CgruX28mh8rDrVTpJtXqmxCKE5A9+puRbHfJwE76M//Oyi2xZSheMFa4e/+NQ9y1V2lBAnrdfzfFFzJm9w3nR3vFLeJwTrmi6GQbJQTkotRVhDOFrTArRr05TDn8pVc+mWTIVyIewJfBcFS4J/vlLExBSInXHvYdmNsJbC8HHCHUWE9hjaNPwokMp3Ef2wlPrY3NGlWmTr79MBaHFOhB3zB0K+SBQcQ45T9YnE+E/k3obyde2medtVvW49OxSHC4lKGxwGycdgfTjCdNpOnuH9jvTR0B2x9sMyqChPmW8xkfa7OipQK9hefm1gIXs4MbFWKrcPoBqAgbHZJ6ZIim2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8S1pJzufn0aVv9s5+81QCgIoFK39A9YFq1fhAFT7dls=;
 b=NfzwVhEc+wB0MXCYj8fYhQLuGsvP6i6FODvlSGZNvcC9mq9EfbWQVYZ6NPgWF+Km6Pj43dIDFR9WamHdBdujkgomaMsGftLpFzG8C6BsQAjC5UDsVy2+om+NONuo4vD7bDYcQiWa1L5k0SRLgRNotfq99amjAUWMwujgSTp2RBc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com (2603:10a6:5:33::26) by
 DU0PR04MB9585.eurprd04.prod.outlook.com (2603:10a6:10:316::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.21; Thu, 30 May 2024 16:33:57 +0000
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a]) by DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a%7]) with mapi id 15.20.7611.030; Thu, 30 May 2024
 16:33:57 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Colin Foster <colin.foster@in-advantage.com>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH net-next 7/8] net: dsa: ocelot: common probing code
Date: Thu, 30 May 2024 19:33:32 +0300
Message-Id: <20240530163333.2458884-8-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240530163333.2458884-1-vladimir.oltean@nxp.com>
References: <20240530163333.2458884-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0007.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::20) To DB7PR04MB4555.eurprd04.prod.outlook.com
 (2603:10a6:5:33::26)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4555:EE_|DU0PR04MB9585:EE_
X-MS-Office365-Filtering-Correlation-Id: 15475933-4b7a-4d53-7b9b-08dc80c64d9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|52116005|1800799015|7416005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ae24eEh1zFZqT4e2HBiW4csWZ8t3hWVkpEx/bniBHVGRQPkD/mxPIeDqgXsm?=
 =?us-ascii?Q?jY9MF9VFRmvEOhf94PZ/E0zThTeWtgluChUIBDS951L/tC+FfAvmoVjzAWFV?=
 =?us-ascii?Q?TRNgj1IlKu7LkgE/1S88PWTBJLRXjLNprAH1hoohmda6vvPKi15FWclV+FRZ?=
 =?us-ascii?Q?vBNoQjcLGydcygeMDwt5NEJUWLOLxGNy+Xc25Q3sBCInL9su248GQHVLULYw?=
 =?us-ascii?Q?4XaYZ7w7rsfhtphyntFpPt2YAOxYF7qgSOnecvcMflIY53JDWwW6W+z/qdaZ?=
 =?us-ascii?Q?Y6YOApkzDCeUBBeWneDNzdiVeO4mC5E3fuB1DcVk0iskzuVxIQ7RO2Nz3tvb?=
 =?us-ascii?Q?C3Qw3EK84gidpJVJOi20rpcCWS65+tB7kDHXgBl7aRymdnnefBbdtIcLkduY?=
 =?us-ascii?Q?zIl6JhTs1hPRqfgQFSOJ9YvgX1QjJ3IMKm9/vznNQ9GQzcCfphgaOn67UP9m?=
 =?us-ascii?Q?2zW/E1xN07NY7OZlXI9Sip4kSsdaIj9Rbyapvw/KXdIUrTqwh5/h96ZK/PF8?=
 =?us-ascii?Q?Gcqzs7A7WH+Xu9+zdrX8vMgWmGCVyWHM3hE+fOU5JeSBy0nTu2YSeYeD/nAZ?=
 =?us-ascii?Q?YroLuzvFaz6voHKx3cUav4E2zlZOT6aJPa0PZZuFdnpk6GimFFLisnJ4On8A?=
 =?us-ascii?Q?HRzs0rvDHiNIQEhbwkWA//1EUbAhOT3IV9aWQ8pDhbuOgc8qiXZkX7l1VthE?=
 =?us-ascii?Q?6T8QsErmRk6f2nnUMEho72qb88seH0EAfGZ4GKlWN7ZTbMTWfWWF8oImq9CD?=
 =?us-ascii?Q?cm6EQTwUMcerM7EzhvWsdrBTXpUCkEFAADwjh9QBKRRdDUh7Km4Azwf/7m8u?=
 =?us-ascii?Q?azWCJvCSTL21rWZ2mLI6dJMhEDyEr3mAjjMRgd7wzD810mgV27fSLUcF0COk?=
 =?us-ascii?Q?cKbmJfPHyKEJM9lF36S9w5qEvRPcfden/nYkSeqYrRy/EHWJxfWvZ6S79xK7?=
 =?us-ascii?Q?QGAlZ0Da5TF1TuitgzkgPaTmIYwK3jMvQMcCkeNMFRCtni9juf9/qNYvXo1d?=
 =?us-ascii?Q?mcR61HqH83oA6sGGvze26bGcBfjlHiMQxQcXPWPA/NtYbbURSGxtS8WmmxS0?=
 =?us-ascii?Q?V2G7NwonpJW7D1tS/8/VtfgwsHB3UyvyyA97pdWbMP+BQG2OxFuDEbbM/FlB?=
 =?us-ascii?Q?xviapbmpDsktJgRjwXSzjHCMaEl4MLR0dpSGmUlyNaBCJHG7BdpIMvub9UHd?=
 =?us-ascii?Q?L3lwM05cYPLVNk35VrKt6xTa+5UggLRmTqHe0hJ4CG0EE/mzzj7m1j0zAZm8?=
 =?us-ascii?Q?0YJGyA+IFLS76iKgjh8LrqRSTkQXykTJbiBtBcWqRA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4555.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(7416005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Divg6tVeoEpYhnK422/+L4s9MJN96v2EoY7TlMWBwQGDkm/SCE+eKAmdKLex?=
 =?us-ascii?Q?ZW1w9ZCaAd+fIMw2IJaj4cm8OLXumkPje7EfdPwhFi5sUy0wePoEqeCB4OWA?=
 =?us-ascii?Q?JGLBKMNsGylNHhQ6DEEbTBigHCYytdTDUM+ZBRG9TTtdA3J4K4UHMHFJwjcU?=
 =?us-ascii?Q?aqUVYKZdhfOXG3zP9nzjdO/zAiOF3j+KNXaAvZ3K1L1Q1WpS90pIkVy8SAnP?=
 =?us-ascii?Q?FRPuDASZy8JZla87ezrLiMVoOiZtwI1GO++zYuOtsJifCj7/+8r2xSVq+zK7?=
 =?us-ascii?Q?MQJ6j45IfKkl+hQ0FS3jRCh7B9Hr+JqRBEiIZ0OPIgJCfNzdiKVxrldqXF5m?=
 =?us-ascii?Q?yn9syHbSXUApe3T8ueHATgAynitx5gXgQiRrqerXuE6YLGPY9IArthpyMylm?=
 =?us-ascii?Q?BuzVubiB62Az1sF5bn3kEbUWbCef2qYfRYNkqCvrFqB9Ft/Uyu32JumhKTnd?=
 =?us-ascii?Q?IdHzcbqXItbliR0331rYPaYOyd/MzpsqliLSWsFoUUWx09BPZFKk7uvgVHgX?=
 =?us-ascii?Q?x+R7Qy7NyLuKdhYxDf3Iw3rRd4szzy9PwuQQKruUJAtiFE2AWgApt5++qbij?=
 =?us-ascii?Q?hHClUQ33KbWXYCaAWSPnXO6vLUcr14grsHk0Jg2xwAdWXGhwGmUSYkZYVFyK?=
 =?us-ascii?Q?vxvwNsQrQ0PDazAX9BpUzqg88fgMluzEmpUPmXULigTMVjVIZQzw0uV/fVi6?=
 =?us-ascii?Q?v/YHFaaghjuy1wCDjSkXRs3HyzL3z+k3iG7L4QfjmxUV0XWYUCPiv4y7ADXU?=
 =?us-ascii?Q?XUE6fLaEcSgmI8UjXEoURInkwhN+tEHFiS8ydloLxhfhzsYndE1tuKVk5jip?=
 =?us-ascii?Q?RHWPg5ktTmeFaNV9Su6Hsq7XKletq8mtKr0WQP1dtsOAh8QTrgYlaZIM/xEw?=
 =?us-ascii?Q?Z/cu0KdC0k++oYBt1AfopQDvHggXP5HwTvUUuI0p8SRXa8WuLWP7cIejOmTZ?=
 =?us-ascii?Q?RRNkg72Xw0CldeDbdW/vIgB2+olAxLa7pNk9Ppo+fOq9LDjE2gFmhrg4fmI1?=
 =?us-ascii?Q?QS4hBATif303r9B7LPaBTYTwRgxt8/xjhKvsvasRYZ6v3sc3hDnzA0w62rG9?=
 =?us-ascii?Q?6j5V2GN4KmjIGLHBoDlukUDAlWxgRbzrqSUwwPg+2qjk0DhfvPuR67Uju3kh?=
 =?us-ascii?Q?9mzqShMiynRZoXZLG0XxK6+kvoL0tXg7Ylxm1U8WeqAa3G8hIoKBg5wwwNlF?=
 =?us-ascii?Q?YMK3kVL1zbhGuSJS3LGZnh0g9JTHVO2LujMCGyZMzU7TrHCOCWD8HKLPv+KA?=
 =?us-ascii?Q?9rVwQQQSRkhca8U2UsTBh31nCiLyQUqOorbvZv8nfKzUpjALcFRGzp7hAqPV?=
 =?us-ascii?Q?f4IWObWrVdVq/SaPKEEerwjTl6ZhFzbOfuYsHOZ+7DvkIOlbQ0R3DrHVTHvz?=
 =?us-ascii?Q?jujcIOS9sJDHkG7VBtyNDQUucXgXBcswG+Xi3wrgXz+XUCINSgFPCsthnmcY?=
 =?us-ascii?Q?/7v4b3YeITi84Y/1YHsevLkWnbsSkZ4il9sD7YJ9OiACnTynZulQ6ICM3hlN?=
 =?us-ascii?Q?bqdjyF1a5KjSL882lMkE0r2RJkYwnNg3v3apJn80rYl+yjMrK6LYQaUUqww5?=
 =?us-ascii?Q?4sRiqCerqlcirufWPfAHE0XI6XKpraffxUMyrrAzqzN1byZbAIHdCc+SO65R?=
 =?us-ascii?Q?ag=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15475933-4b7a-4d53-7b9b-08dc80c64d9e
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4555.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 16:33:57.5171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jb0k9hKle9B/QEZWAFLbGo21winBHDRsB5DeCqG+of89S+nepoHyc6geOStX+4N9AYAoPPupEYMQrFkMfXZqvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9585

Russell King suggested that felix_vsc9959, seville_vsc9953 and
ocelot_ext have a large portion of duplicated init code, which could be
made common [1].

[1]: https://lore.kernel.org/all/Zh1GvcOTXqb7CpQt@shell.armlinux.org.uk/

Here, we take the following common steps:
- "felix" and "ds" structure allocation
- "felix", "ocelot" and "ds" basic structure initialization
- dsa_register_switch() call

and we make a common function out of them.

For every driver except felix_vsc9959, this is also the entire probing
procedure. For felix_vsc9959, we also need to do some PCI-specific
stuff, which can easily be reordered to be done before, and unwound on
failure.

We also have to convert the bus-specific platform_set_drvdata() and
pci_set_drvdata() calls into dev_set_drvdata(). But this should have no
impact on the behavior.

Suggested-by: "Russell King (Oracle)" <linux@armlinux.org.uk>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/ocelot/felix.c           | 47 ++++++++++++++++++++++++
 drivers/net/dsa/ocelot/felix.h           |  5 +++
 drivers/net/dsa/ocelot/felix_vsc9959.c   | 44 +++-------------------
 drivers/net/dsa/ocelot/ocelot_ext.c      | 40 +-------------------
 drivers/net/dsa/ocelot/seville_vsc9953.c | 38 ++-----------------
 5 files changed, 63 insertions(+), 111 deletions(-)

diff --git a/drivers/net/dsa/ocelot/felix.c b/drivers/net/dsa/ocelot/felix.c
index 09c0800b18ab..accf737f7b69 100644
--- a/drivers/net/dsa/ocelot/felix.c
+++ b/drivers/net/dsa/ocelot/felix.c
@@ -2195,6 +2195,53 @@ const struct dsa_switch_ops felix_switch_ops = {
 };
 EXPORT_SYMBOL_GPL(felix_switch_ops);
 
+int felix_register_switch(struct device *dev, resource_size_t switch_base,
+			  int num_flooding_pgids, bool ptp,
+			  bool mm_supported,
+			  enum dsa_tag_protocol init_tag_proto,
+			  const struct felix_info *info)
+{
+	struct dsa_switch *ds;
+	struct ocelot *ocelot;
+	struct felix *felix;
+	int err;
+
+	felix = devm_kzalloc(dev, sizeof(*felix), GFP_KERNEL);
+	if (!felix)
+		return -ENOMEM;
+
+	ds = devm_kzalloc(dev, sizeof(*ds), GFP_KERNEL);
+	if (!ds)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, felix);
+
+	ocelot = &felix->ocelot;
+	ocelot->dev = dev;
+	ocelot->num_flooding_pgids = num_flooding_pgids;
+	ocelot->ptp = ptp;
+	ocelot->mm_supported = mm_supported;
+
+	felix->info = info;
+	felix->switch_base = switch_base;
+	felix->ds = ds;
+	felix->tag_proto = init_tag_proto;
+
+	ds->dev = dev;
+	ds->num_ports = info->num_ports;
+	ds->num_tx_queues = OCELOT_NUM_TC;
+	ds->ops = &felix_switch_ops;
+	ds->phylink_mac_ops = &felix_phylink_mac_ops;
+	ds->priv = ocelot;
+
+	err = dsa_register_switch(ds);
+	if (err)
+		dev_err_probe(dev, err, "Failed to register DSA switch\n");
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(felix_register_switch);
+
 struct net_device *felix_port_to_netdev(struct ocelot *ocelot, int port)
 {
 	struct felix *felix = ocelot_to_felix(ocelot);
diff --git a/drivers/net/dsa/ocelot/felix.h b/drivers/net/dsa/ocelot/felix.h
index e0bfea10ff52..85b4f8616003 100644
--- a/drivers/net/dsa/ocelot/felix.h
+++ b/drivers/net/dsa/ocelot/felix.h
@@ -100,6 +100,11 @@ struct felix {
 	unsigned long			host_flood_mc_mask;
 };
 
+int felix_register_switch(struct device *dev, resource_size_t switch_base,
+			  int num_flooding_pgids, bool ptp,
+			  bool mm_supported,
+			  enum dsa_tag_protocol init_tag_proto,
+			  const struct felix_info *info);
 struct net_device *felix_port_to_netdev(struct ocelot *ocelot, int port);
 int felix_netdev_to_port(struct net_device *dev);
 
diff --git a/drivers/net/dsa/ocelot/felix_vsc9959.c b/drivers/net/dsa/ocelot/felix_vsc9959.c
index ec8b124e8f61..ba37a566da39 100644
--- a/drivers/net/dsa/ocelot/felix_vsc9959.c
+++ b/drivers/net/dsa/ocelot/felix_vsc9959.c
@@ -2673,9 +2673,7 @@ static int felix_pci_probe(struct pci_dev *pdev,
 			   const struct pci_device_id *id)
 {
 	struct device *dev = &pdev->dev;
-	struct dsa_switch *ds;
-	struct ocelot *ocelot;
-	struct felix *felix;
+	resource_size_t switch_base;
 	int err;
 
 	err = pci_enable_device(pdev);
@@ -2684,45 +2682,15 @@ static int felix_pci_probe(struct pci_dev *pdev,
 		return err;
 	}
 
-	felix = devm_kzalloc(dev, sizeof(struct felix), GFP_KERNEL);
-	if (!felix) {
-		err = -ENOMEM;
-		goto out_disable;
-	}
-
-	pci_set_drvdata(pdev, felix);
-	ocelot = &felix->ocelot;
-	ocelot->dev = dev;
-	ocelot->num_flooding_pgids = OCELOT_NUM_TC;
-	felix->info = &felix_info_vsc9959;
-	felix->switch_base = pci_resource_start(pdev, VSC9959_SWITCH_PCI_BAR);
-
 	pci_set_master(pdev);
 
-	ocelot->ptp = 1;
-	ocelot->mm_supported = true;
+	switch_base = pci_resource_start(pdev, VSC9959_SWITCH_PCI_BAR);
 
-	ds = devm_kzalloc(dev, sizeof(struct dsa_switch), GFP_KERNEL);
-	if (!ds) {
-		err = -ENOMEM;
+	err = felix_register_switch(dev, switch_base, OCELOT_NUM_TC,
+				    true, true, DSA_TAG_PROTO_OCELOT,
+				    &felix_info_vsc9959);
+	if (err)
 		goto out_disable;
-	}
-
-	ds->dev = dev;
-	ds->num_ports = felix->info->num_ports;
-	ds->num_tx_queues = OCELOT_NUM_TC;
-
-	ds->ops = &felix_switch_ops;
-	ds->phylink_mac_ops = &felix_phylink_mac_ops;
-	ds->priv = ocelot;
-	felix->ds = ds;
-	felix->tag_proto = DSA_TAG_PROTO_OCELOT;
-
-	err = dsa_register_switch(ds);
-	if (err) {
-		dev_err_probe(dev, err, "Failed to register DSA switch\n");
-		goto out_disable;
-	}
 
 	return 0;
 
diff --git a/drivers/net/dsa/ocelot/ocelot_ext.c b/drivers/net/dsa/ocelot/ocelot_ext.c
index 9cd24f77dc49..5632a7248cd4 100644
--- a/drivers/net/dsa/ocelot/ocelot_ext.c
+++ b/drivers/net/dsa/ocelot/ocelot_ext.c
@@ -64,44 +64,8 @@ static const struct felix_info vsc7512_info = {
 
 static int ocelot_ext_probe(struct platform_device *pdev)
 {
-	struct device *dev = &pdev->dev;
-	struct dsa_switch *ds;
-	struct ocelot *ocelot;
-	struct felix *felix;
-	int err;
-
-	felix = devm_kzalloc(dev, sizeof(*felix), GFP_KERNEL);
-	if (!felix)
-		return -ENOMEM;
-
-	dev_set_drvdata(dev, felix);
-
-	ocelot = &felix->ocelot;
-	ocelot->dev = dev;
-
-	ocelot->num_flooding_pgids = 1;
-
-	felix->info = &vsc7512_info;
-
-	ds = devm_kzalloc(dev, sizeof(*ds), GFP_KERNEL);
-	if (!ds)
-		return -ENOMEM;
-
-	ds->dev = dev;
-	ds->num_ports = felix->info->num_ports;
-	ds->num_tx_queues = OCELOT_NUM_TC;
-
-	ds->ops = &felix_switch_ops;
-	ds->phylink_mac_ops = &felix_phylink_mac_ops;
-	ds->priv = ocelot;
-	felix->ds = ds;
-	felix->tag_proto = DSA_TAG_PROTO_OCELOT;
-
-	err = dsa_register_switch(ds);
-	if (err)
-		dev_err_probe(dev, err, "Failed to register DSA switch\n");
-
-	return err;
+	return felix_register_switch(&pdev->dev, 0, 1, false, false,
+				     DSA_TAG_PROTO_OCELOT, &vsc7512_info);
 }
 
 static void ocelot_ext_remove(struct platform_device *pdev)
diff --git a/drivers/net/dsa/ocelot/seville_vsc9953.c b/drivers/net/dsa/ocelot/seville_vsc9953.c
index 83bd0e1ee692..70782649c395 100644
--- a/drivers/net/dsa/ocelot/seville_vsc9953.c
+++ b/drivers/net/dsa/ocelot/seville_vsc9953.c
@@ -971,49 +971,17 @@ static const struct felix_info seville_info_vsc9953 = {
 static int seville_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct dsa_switch *ds;
-	struct ocelot *ocelot;
 	struct resource *res;
-	struct felix *felix;
-	int err;
-
-	felix = devm_kzalloc(dev, sizeof(struct felix), GFP_KERNEL);
-	if (!felix)
-		return -ENOMEM;
-
-	platform_set_drvdata(pdev, felix);
-
-	ocelot = &felix->ocelot;
-	ocelot->dev = dev;
-	ocelot->num_flooding_pgids = 1;
-	felix->info = &seville_info_vsc9953;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		dev_err(dev, "Invalid resource\n");
 		return -EINVAL;
 	}
-	felix->switch_base = res->start;
-
-	ds = devm_kzalloc(dev, sizeof(struct dsa_switch), GFP_KERNEL);
-	if (!ds)
-		return -ENOMEM;
-
-	ds->dev = dev;
-	ds->num_ports = felix->info->num_ports;
-	ds->num_tx_queues = OCELOT_NUM_TC;
-
-	ds->ops = &felix_switch_ops;
-	ds->phylink_mac_ops = &felix_phylink_mac_ops;
-	ds->priv = ocelot;
-	felix->ds = ds;
-	felix->tag_proto = DSA_TAG_PROTO_SEVILLE;
-
-	err = dsa_register_switch(ds);
-	if (err)
-		dev_err(dev, "Failed to register DSA switch: %d\n", err);
 
-	return err;
+	return felix_register_switch(dev, res->start, 1, false, false,
+				     DSA_TAG_PROTO_SEVILLE,
+				     &seville_info_vsc9953);
 }
 
 static void seville_remove(struct platform_device *pdev)
-- 
2.34.1


