Return-Path: <netdev+bounces-184247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5810BA93FC8
	for <lists+netdev@lfdr.de>; Sat, 19 Apr 2025 00:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F37E73B5FA2
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 22:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A641324418E;
	Fri, 18 Apr 2025 22:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="EP3JhQsr"
X-Original-To: netdev@vger.kernel.org
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazon11021127.outbound.protection.outlook.com [40.93.199.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4104245031;
	Fri, 18 Apr 2025 22:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.199.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745014494; cv=fail; b=X2HtZSQJgMMcGqY9gxNqD5RK6uBIuVI2YxejYJwEjn0vkHEr22Z4pCe/tn4NCdCi8eG2RVh0aDF/A0TcdmlzC09CEiK+ZvxgMmwfOpUzz1asUHCJFqVFK4kwkTY6phxZW3Zqc9NGGwGYk4FpU5TCJv0ZiYb2v1yHshth5CTLaXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745014494; c=relaxed/simple;
	bh=0gMXefLJQ/p1dxLaRYqCs4S056jBjSawIo/i7JR3WAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Y0WMBeAZnUCuwqOeTGpE7J6V4U7mvg3hl2obs7sGe5EYuTWWJREtcfC1PbRcWskYnTQ+HUmEHuGVnvwvLqdDhjDxAYDMVgyxH4Znp//RLjRiQ7+YW3C6whh9tVesYThVVn30ae35RAS4Vpw0KW+ibsMm7bfVdxQAc747QsGwWpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=EP3JhQsr; arc=fail smtp.client-ip=40.93.199.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pBLqEspmj8G9garP+zxvIBwHKaoVVNz8WVjqKg8qu6VwLoEeQAKixjDWnIA8w9rNLqyCMtgEDA12zVctTaOBMAGPAIPoZgz09BpxImPO1Jt2fw0VwXmYRWGxL4IoX6cQy172+jaxKI5TR92usAwc7whQKAqxYXmcJMs2lg3/DA8ZqcFFdzuHdtkDrfbd4zMS3jIDMFpIV/9UI1KAR+cWSKIHEmkAdxYbzs6KNSyHMoB4oY7XCZl2txVcdfDhD8ZO/G3um5qlBvG2ATK8vwwmxtzbj5IURab7h/wNhRVxDYtFNr17xEOuD32XLlwd+mY5ylU8+kHr6zeShdAodvsPbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ri42EEo50+Y3mHHwexN7ic4L3cUEu7v6ZrwhboatRvA=;
 b=FQVWJ66DJPJZXgX9MVXlOzLTrA6XiC+jKiPeh3VMule5tGdE6W1RzVIHWbMHNsQEcJvtTSKtp1rqtAd8EBNvNxpvBGwYLoCkSzmKwKuvXEmafXFc2XNWO8D6cmc6U1H+QHBe2Flbyx4huVZmV6uyfsnCciHf5jyu2GDupgL+nj43RY4AxCdpo1RKWDJwqyDswa8cqpW3KffN4reeEOC5d7NAiri+ge6vvzCzR0/KjrYfRAC9/Ijwew2E3cHMpeWT0dIZWy7bwnsojn3HExYy0X3GXQHG99X+bmQy8kQexzZCB+nYXdddYrjopZ781Wz0YHBOsNZdWGgNpbValYe4CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ri42EEo50+Y3mHHwexN7ic4L3cUEu7v6ZrwhboatRvA=;
 b=EP3JhQsrX+WSoGFBA8iwdHqIQ6SOyGkp6Ns40URJvKjhirtC76KOHy2EKHmeG75qSlD6EeiG7UdaKMYGKhANlCb0NUkCp71tJodwfE+Z3KFpJtNlbWOdV5D4QTbiCg0zcAXhxYhBjyEw36pV1i7NGr5pe5bYDA8iebNfjxIOy3Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 DS2PR01MB9277.prod.exchangelabs.com (2603:10b6:8:27d::17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.22; Fri, 18 Apr 2025 22:14:45 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%5]) with mapi id 15.20.8655.025; Fri, 18 Apr 2025
 22:14:44 +0000
From: admiyo@os.amperecomputing.com
To: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Adam Young <admiyo@os.amperecomputing.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: [PATCH] mctp pcc: Implement MCTP over PCC Transport
Date: Fri, 18 Apr 2025 18:14:31 -0400
Message-ID: <20250418221438.368203-1-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0021.namprd13.prod.outlook.com
 (2603:10b6:806:21::26) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|DS2PR01MB9277:EE_
X-MS-Office365-Filtering-Correlation-Id: af413719-6291-47f0-5eea-08dd7ec66c89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ruicmG6iywb79wNqIvE1fp+roOmp7pH9j2hUH5cVWsu195uMT2m5wGO5h7hd?=
 =?us-ascii?Q?KmVIsGk+g8gbTZu8Y4rW0dYe6ldXUBwWxPlf7/aLUGnhi26M9XCvDzs4EQM4?=
 =?us-ascii?Q?SK4Dhe34uXUIlQMOwh38lzQsYlpPXTmrrqxg4JcgHXCIvOeTYdR+fa6vAQgB?=
 =?us-ascii?Q?YKa610pbbXSKYTtJ/SbQ4lFotsXh9mGA9QcH3oZe1F4EbwUDd8YaKDi+R7Ip?=
 =?us-ascii?Q?NR74zh8asLqBQ9jlgj+4dzRFq80qGHO0O2BiV8Z/5pIVy5gCB0SxR51gMcF7?=
 =?us-ascii?Q?/JnICajn+LJGtkR3P6ZIR+HhE5VUUnTrptvlLkGWeEoGjB6fz+Mymsnx6f2h?=
 =?us-ascii?Q?UYAqVnVJP6TDDtnJ4+6OTb03C6X1szueWh58sM/CNaLKdHloVBnvryi+JQrn?=
 =?us-ascii?Q?FJBwQf6XgHxOYJKdwn4S6H/Izny8x93Cp1xwxZA+Y2QyQ8ehz7EC/BNxUii4?=
 =?us-ascii?Q?V/DO+6RTUFz/ZHjwQc2orBCa08zoUSyNRqjbJLfkrfAtSATH4uclQh87+c+F?=
 =?us-ascii?Q?spXjhknG3Mfki3T0mxL7BX0rQzA8fbgdk9BRQentJPzd8Wc9suZJVKwExYlt?=
 =?us-ascii?Q?4NFXhNJhHmyznTK53K+5Ba7FUSORQnt+O5zFxFK7JXLCxVsZgxSBtgsJ2eyI?=
 =?us-ascii?Q?4Vwok2ryhAVOruS1PxJ0BOaMr92TFj18nTA8MCunoIel30RMyX8BM4B32tdq?=
 =?us-ascii?Q?8Gzlnc0IWP+fau2tqMBvZNJQBnRWaCNpE/zUedRzu15fR7rAxcXr/pub9IzV?=
 =?us-ascii?Q?H/TE9aGXMWOiIMAl2UTEajrK6ae9tVqtJIgKhOQGHYp+e/fOcMFtlmCZkN34?=
 =?us-ascii?Q?Xhf8+qUalaV92wSINq3weA5nVoRhdp3Tfdhux4a+Epv863dCMLiiqyQ2hZ+S?=
 =?us-ascii?Q?qVR3xbqCUF8Zei2xl9IC/pQXzPxO5K7LoQiloMJQkXEBAe4KBZl1tK7wiY/J?=
 =?us-ascii?Q?jb2lO4cg59yDZSPzRwk6f4WR10r4UFagWUjvuhywlzorSHaj/wDtUhmlTaZx?=
 =?us-ascii?Q?bVwJc4StjNLsUhxaTpCDN/fdk6CnDDGUayFd85RgjvaCFS4dJfBTiHDJdwOF?=
 =?us-ascii?Q?dP06naR75cP/1TTIyUGgIDERNvZrZ3SZ0sl3UQXnhOgTkJN1rkmQyrqbcCsv?=
 =?us-ascii?Q?4XAgTrR+vD9ShzEx4aOWqOlgq2F07w8JS0MjOn0QZpeE3Q4Fqd7BZcTY3gw0?=
 =?us-ascii?Q?TS8KUPqGGTNctp+1WMdNmgxELARMi2iUsfVdilMlQeZ6RIPbo5xVwVHfx+WY?=
 =?us-ascii?Q?jGbY0+la2bvgXj46jgpv4Ap4O1+ZMONsTPaxrW2vd+uUKriDHkkha5KBs5K3?=
 =?us-ascii?Q?cVUt+kPnB9QmOVzXgf3saHnaRyXXSaCmvzyk7xxeJGpZwJaMy85sM446MQJf?=
 =?us-ascii?Q?z7D7evQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(10070799003)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZbcVZAZJ0uawV8kUjk0D60ll6mJ5DCCVRRa7HM90p8NA3uIduV5CdyxTASM/?=
 =?us-ascii?Q?/Xrtq7BizAz6vgQNq8AkFPN8KlwHR66pARiKcs4HPzgIx9unynSB+swm97xD?=
 =?us-ascii?Q?1tvnqipC5X2mCoQC5IIOLRmErd9XpF5XtVBgb7cx0Wt41mudUKAukjFDO2uC?=
 =?us-ascii?Q?MmC+dbKrSqmnqtIFNkDc3bMzaEswadOaoMyHxX7XqBXnFPqLBM+piYT22t/b?=
 =?us-ascii?Q?RnnhN2y1SBGWQwRrgDAKHbbDfiWl48M57vokSgukRyIU8GAksK5UCcEryRvl?=
 =?us-ascii?Q?i4wEoX8op7M55wbI5jTIj0zo0MfzddoPv+VEnJuS879TncMdZrf2dBYIBnow?=
 =?us-ascii?Q?A3kBQl5eEjUR9NMH3cVU/jJwvjTWGhUH2iD7zrBnVSAVCvN+CVonHYSWGumE?=
 =?us-ascii?Q?gu62WGz/YwJtTd2AALSbEbf1HQIa/yA+SciOscA2oh57GmJEMV91/qL8LVTL?=
 =?us-ascii?Q?OjH8RpV0eA75ElwSq90l3bGrc4rtZxPGQmKMx9hssZd5zchm97vGjhUJlbTe?=
 =?us-ascii?Q?rF3Ljbssvh1wEqNuoowsZGcDKeGM3XB1Ta7kZTtHu5/Gmt2Z2xQFlM+G20nu?=
 =?us-ascii?Q?RUdi5B4FTROdaXkCwgCCC5JqfZbtS2QrYWuhOzGPrBLH2Cb9jVB04YVB/xWf?=
 =?us-ascii?Q?C/5uQqwOxPCudJTA1T1KnSUwFKqUqMGKjxqxzDmf+K7OT7XoUiXPZ5vbkBaE?=
 =?us-ascii?Q?Yl/+NpUfGhwCRSme06R7hRL66PmnCAcnB8ZwVOYrOlxzJeHiS1IKCJFx/vuN?=
 =?us-ascii?Q?Y/hf8GS/cQHCPj6jXYiYTw2J4SKk3ulBTjgoAhXU4wnxjMBvpXc+R2nFTFDv?=
 =?us-ascii?Q?+gnE3J3gG/kz1HonEufNqR4cvkrEj2oo7UDto/rE8quLMlOCxbbLkDq4uZz9?=
 =?us-ascii?Q?ImQI5ofnkBrjUObFktLMmKDxrig2/EpoNoqMWFJmfRuHQqyIIHD+vlOO1Dvu?=
 =?us-ascii?Q?9AdE7f5Fm3pJbHN8MTg9NaRXO2IQLnvf+goitZAgfQHo4nw4YlzpA9NKHcaA?=
 =?us-ascii?Q?ji5VPNqCI4ZF5+RibZ2gjxR9dSclTruoejBM7y/wqjPhX1zHo0FkFPQSFIur?=
 =?us-ascii?Q?H3MXgpOBxDSlxkLfm9J6wKc1k7+lABhgsQ1rfkNAGufrY5YIKKSAW6GfNy8k?=
 =?us-ascii?Q?z7FCJlSwM352Cq0BB85kO48PbCNZiNs0wtWfetnbcAw3HEVUGvVZkwmTC90o?=
 =?us-ascii?Q?2911+14SdKeRGJfvc3q+mW0iT+y9ynZQ9FYOZ9OdxxJWk+e2tcChwB4asNg0?=
 =?us-ascii?Q?vccxxEdywdiZS95aOuQ+8kz0kMtKqyUQ5zunRJ3EE/jPz9Jlmprf5l2GRSJY?=
 =?us-ascii?Q?DNrD4YRRq42SUFf/73DtCxQWFE5zppwK1g4VbUd1AkFloOQQswWRooScA96e?=
 =?us-ascii?Q?zsDAzj+zctuDKLp36pBTxTDd4BTNGOvqHWGCmj1Y0HbPrSvxPMvVXgZPitXP?=
 =?us-ascii?Q?p+zOFk8kaL7quQ1Mydvw/RV191tM11JTCtqNbY5Rir8f9vPGqltSSDAULySv?=
 =?us-ascii?Q?a9yAHEMWHyv2UfV8rQbNKjzWbqMNDjVJCBHlaRf2wGJVacfjs4HoruELmiCI?=
 =?us-ascii?Q?v5wMB173MH/MoADNmJ8tNOO9z0w7/Owdixwl5NlGsj1dfEjAOnZwck+RvxdU?=
 =?us-ascii?Q?mRxGZPvWbj5eUDTN1lXeyZQmLGCZk8jus+PxrkxmoRBB2/jI9dck1zeks3ZH?=
 =?us-ascii?Q?adApZ9t3HIFGuGYrf8MSnzUykHI=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af413719-6291-47f0-5eea-08dd7ec66c89
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 22:14:44.8060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i+anNxn4LOKeKHG4o46pSaPUwYzenlyomDAQXCO36UkFFXyh8S/u+ZhYHCJE30QikFg02RAZPGbeFP1FhTaBlgjafU0hc8hLAuK+VZdQGoXULu164RWH5AdP+85hBPir
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR01MB9277

From: Adam Young <admiyo@os.amperecomputing.com>

Implementation of network driver for
Management Control Transport Protocol(MCTP) over
Platform Communication Channel(PCC)

DMTF DSP:0292
https://www.dmtf.org/sites/default/files/standards/documents/\
DSP0292_1.0.0WIP50.pdf

MCTP devices are specified via ACPI by entries
in DSDT/SDST and reference channels specified
in the PCCT.

Communication with other devices use the PCC based
doorbell mechanism.

Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
---
 MAINTAINERS                 |   5 +
 drivers/net/mctp/Kconfig    |  13 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 314 ++++++++++++++++++++++++++++++++++++
 4 files changed, 333 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c59316109e3f..065271e9f05c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14204,6 +14204,11 @@ F:	include/net/mctpdevice.h
 F:	include/net/netns/mctp.h
 F:	net/mctp/
 
+MANAGEMENT COMPONENT TRANSPORT PROTOCOL (MCTP) over PCC (MCTP-PCC) Driver
+M:	Adam Young <admiyo@os.amperecomputing.com>
+S:	Maintained
+F:	drivers/net/mctp/mctp-pcc.c
+
 MAPLE TREE
 M:	Liam R. Howlett <Liam.Howlett@oracle.com>
 L:	maple-tree@lists.infradead.org
diff --git a/drivers/net/mctp/Kconfig b/drivers/net/mctp/Kconfig
index cf325ab0b1ef..f69d0237f058 100644
--- a/drivers/net/mctp/Kconfig
+++ b/drivers/net/mctp/Kconfig
@@ -57,6 +57,19 @@ config MCTP_TRANSPORT_USB
 	  MCTP-over-USB interfaces are peer-to-peer, so each interface
 	  represents a physical connection to one remote MCTP endpoint.
 
+config MCTP_TRANSPORT_PCC
+	tristate "MCTP PCC transport"
+	depends on ACPI
+	help
+	  Provides a driver to access MCTP devices over PCC transport,
+	  A MCTP protocol network device is created via ACPI for each
+	  entry in the DST/SDST that matches the identifier. The Platform
+	  communication channels are selected from the corresponding
+	  entries in the PCCT.
+
+	  Say y here if you need to connect to MCTP endpoints over PCC. To
+	  compile as a module, use m; the module will be called mctp-pcc.
+
 endmenu
 
 endif
diff --git a/drivers/net/mctp/Makefile b/drivers/net/mctp/Makefile
index c36006849a1e..2276f148df7c 100644
--- a/drivers/net/mctp/Makefile
+++ b/drivers/net/mctp/Makefile
@@ -1,3 +1,4 @@
+obj-$(CONFIG_MCTP_TRANSPORT_PCC) += mctp-pcc.o
 obj-$(CONFIG_MCTP_SERIAL) += mctp-serial.o
 obj-$(CONFIG_MCTP_TRANSPORT_I2C) += mctp-i2c.o
 obj-$(CONFIG_MCTP_TRANSPORT_I3C) += mctp-i3c.o
diff --git a/drivers/net/mctp/mctp-pcc.c b/drivers/net/mctp/mctp-pcc.c
new file mode 100644
index 000000000000..9332a070cabf
--- /dev/null
+++ b/drivers/net/mctp/mctp-pcc.c
@@ -0,0 +1,314 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * mctp-pcc.c - Driver for MCTP over PCC.
+ * Copyright (c) 2024, Ampere Computing LLC
+ */
+
+/* Implementation of MCTP over PCC DMTF Specification DSP0256
+ * https://www.dmtf.org/sites/default/files/standards/documents/DSP0256_2.0.0WIP50.pdf
+ */
+
+#include <linux/acpi.h>
+#include <linux/if_arp.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/platform_device.h>
+#include <linux/string.h>
+
+#include <acpi/acpi_bus.h>
+#include <acpi/acpi_drivers.h>
+#include <acpi/acrestyp.h>
+#include <acpi/actbl.h>
+#include <net/mctp.h>
+#include <net/mctpdevice.h>
+#include <acpi/pcc.h>
+
+#define MCTP_PAYLOAD_LENGTH     256
+#define MCTP_CMD_LENGTH         4
+#define MCTP_PCC_VERSION        0x1 /* DSP0253 defines a single version: 1 */
+#define MCTP_SIGNATURE          "MCTP"
+#define MCTP_SIGNATURE_LENGTH   (sizeof(MCTP_SIGNATURE) - 1)
+#define MCTP_HEADER_LENGTH      12
+#define MCTP_MIN_MTU            68
+#define PCC_MAGIC               0x50434300
+#define PCC_HEADER_FLAG_REQ_INT 0x1
+#define PCC_HEADER_FLAGS        PCC_HEADER_FLAG_REQ_INT
+#define PCC_DWORD_TYPE          0x0c
+
+struct mctp_pcc_hdr {
+	__le32 signature;
+	__le32 flags;
+	__le32 length;
+	char mctp_signature[MCTP_SIGNATURE_LENGTH];
+};
+
+struct mctp_pcc_mailbox {
+	u32 index;
+	struct pcc_mbox_chan *chan;
+	struct mbox_client client;
+};
+
+/* The netdev structure. One of these per PCC adapter. */
+struct mctp_pcc_ndev {
+	/* spinlock to serialize access to PCC outbox buffer and registers
+	 * Note that what PCC calls registers are memory locations, not CPU
+	 * Registers.  They include the fields used to synchronize access
+	 * between the OS and remote endpoints.
+	 *
+	 * Only the Outbox needs a spinlock, to prevent multiple
+	 * sent packets triggering multiple attempts to over write
+	 * the outbox.  The Inbox buffer is controlled by the remote
+	 * service and a spinlock would have no effect.
+	 */
+	spinlock_t lock;
+	struct mctp_dev mdev;
+	struct acpi_device *acpi_device;
+	struct mctp_pcc_mailbox inbox;
+	struct mctp_pcc_mailbox outbox;
+};
+
+static void mctp_pcc_client_rx_callback(struct mbox_client *c, void *buffer)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct mctp_pcc_hdr mctp_pcc_hdr;
+	struct mctp_skb_cb *cb;
+	struct sk_buff *skb;
+	void *skb_buf;
+	u32 data_len;
+
+	mctp_pcc_ndev = container_of(c, struct mctp_pcc_ndev, inbox.client);
+	memcpy_fromio(&mctp_pcc_hdr, mctp_pcc_ndev->inbox.chan->shmem,
+		      sizeof(struct mctp_pcc_hdr));
+	data_len = le32_to_cpu(mctp_pcc_hdr.length) + MCTP_HEADER_LENGTH;
+	if (data_len > mctp_pcc_ndev->mdev.dev->mtu) {
+		dev_dstats_rx_dropped(mctp_pcc_ndev->mdev.dev);
+		return;
+	}
+
+	skb = netdev_alloc_skb(mctp_pcc_ndev->mdev.dev, data_len);
+	if (!skb) {
+		dev_dstats_rx_dropped(mctp_pcc_ndev->mdev.dev);
+		return;
+	}
+	dev_dstats_rx_add(mctp_pcc_ndev->mdev.dev, data_len);
+
+	skb->protocol = htons(ETH_P_MCTP);
+	skb_buf = skb_put(skb, data_len);
+	memcpy_fromio(skb_buf, mctp_pcc_ndev->inbox.chan->shmem, data_len);
+
+	skb_reset_mac_header(skb);
+	skb_pull(skb, sizeof(struct mctp_pcc_hdr));
+	skb_reset_network_header(skb);
+	cb = __mctp_cb(skb);
+	cb->halen = 0;
+	netif_rx(skb);
+}
+
+static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct net_device *ndev)
+{
+	struct mctp_pcc_ndev *mpnd = netdev_priv(ndev);
+	struct mctp_pcc_hdr  *mctp_pcc_header;
+	void __iomem *buffer;
+	unsigned long flags;
+	int len = skb->len;
+	int rc;
+
+	dev_dstats_tx_add(ndev, len);
+
+	spin_lock_irqsave(&mpnd->lock, flags);
+	rc = skb_cow_head(skb, sizeof(struct mctp_pcc_hdr));
+	if (rc)
+		return rc;
+
+	mctp_pcc_header = skb_push(skb, sizeof(struct mctp_pcc_hdr));
+	buffer = mpnd->outbox.chan->shmem;
+	mctp_pcc_header->signature = cpu_to_le32(PCC_MAGIC | mpnd->outbox.index);
+	mctp_pcc_header->flags = cpu_to_le32(PCC_HEADER_FLAGS);
+	memcpy(mctp_pcc_header->mctp_signature, MCTP_SIGNATURE,
+	       MCTP_SIGNATURE_LENGTH);
+	mctp_pcc_header->length = cpu_to_le32(len + MCTP_SIGNATURE_LENGTH);
+
+	memcpy_toio(buffer, skb->data, skb->len);
+	mpnd->outbox.chan->mchan->mbox->ops->send_data(mpnd->outbox.chan->mchan,
+						    NULL);
+	spin_unlock_irqrestore(&mpnd->lock, flags);
+
+	dev_consume_skb_any(skb);
+	return NETDEV_TX_OK;
+}
+
+static const struct net_device_ops mctp_pcc_netdev_ops = {
+	.ndo_start_xmit = mctp_pcc_tx,
+};
+
+static const struct mctp_netdev_ops mctp_netdev_ops = {
+	NULL
+};
+
+static void mctp_pcc_setup(struct net_device *ndev)
+{
+	ndev->type = ARPHRD_MCTP;
+	ndev->hard_header_len = 0;
+	ndev->tx_queue_len = 0;
+	ndev->flags = IFF_NOARP;
+	ndev->netdev_ops = &mctp_pcc_netdev_ops;
+	ndev->needs_free_netdev = true;
+	ndev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS;
+}
+
+struct mctp_pcc_lookup_context {
+	int index;
+	u32 inbox_index;
+	u32 outbox_index;
+};
+
+static acpi_status lookup_pcct_indices(struct acpi_resource *ares,
+				       void *context)
+{
+	struct mctp_pcc_lookup_context *luc = context;
+	struct acpi_resource_address32 *addr;
+
+	switch (ares->type) {
+	case PCC_DWORD_TYPE:
+		break;
+	default:
+		return AE_OK;
+	}
+
+	addr = ACPI_CAST_PTR(struct acpi_resource_address32, &ares->data);
+	switch (luc->index) {
+	case 0:
+		luc->outbox_index = addr[0].address.minimum;
+		break;
+	case 1:
+		luc->inbox_index = addr[0].address.minimum;
+		break;
+	}
+	luc->index++;
+	return AE_OK;
+}
+
+static void mctp_cleanup_netdev(void *data)
+{
+	struct net_device *ndev = data;
+
+	mctp_unregister_netdev(ndev);
+}
+
+static void mctp_cleanup_channel(void *data)
+{
+	struct pcc_mbox_chan *chan = data;
+
+	pcc_mbox_free_channel(chan);
+}
+
+static int mctp_pcc_initialize_mailbox(struct device *dev,
+				       struct mctp_pcc_mailbox *box, u32 index)
+{
+	int ret;
+
+	box->index = index;
+	box->chan = pcc_mbox_request_channel(&box->client, index);
+	if (IS_ERR(box->chan))
+		return PTR_ERR(box->chan);
+	ret = devm_add_action_or_reset(dev, mctp_cleanup_channel, box->chan);
+	if (ret)
+		return -EINVAL;
+	return 0;
+}
+
+static int mctp_pcc_driver_add(struct acpi_device *acpi_dev)
+{
+	struct mctp_pcc_lookup_context context = {0, 0, 0};
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct device *dev = &acpi_dev->dev;
+	struct net_device *ndev;
+	acpi_handle dev_handle;
+	acpi_status status;
+	int mctp_pcc_mtu;
+	char name[32];
+	int rc;
+
+	dev_dbg(dev, "Adding mctp_pcc device for HID %s\n",
+		acpi_device_hid(acpi_dev));
+	dev_handle = acpi_device_handle(acpi_dev);
+	status = acpi_walk_resources(dev_handle, "_CRS", lookup_pcct_indices,
+				     &context);
+	if (!ACPI_SUCCESS(status)) {
+		dev_err(dev, "FAILURE to lookup PCC indexes from CRS\n");
+		return -EINVAL;
+	}
+
+	/* inbox initialization */
+	snprintf(name, sizeof(name), "mctpipcc%d", context.inbox_index);
+	ndev = alloc_netdev(sizeof(struct mctp_pcc_ndev), name, NET_NAME_PREDICTABLE,
+			    mctp_pcc_setup);
+	if (!ndev)
+		return -ENOMEM;
+
+	mctp_pcc_ndev = netdev_priv(ndev);
+	spin_lock_init(&mctp_pcc_ndev->lock);
+
+	rc = mctp_pcc_initialize_mailbox(dev, &mctp_pcc_ndev->inbox,
+					 context.inbox_index);
+	if (rc)
+		goto free_netdev;
+	mctp_pcc_ndev->inbox.client.rx_callback = mctp_pcc_client_rx_callback;
+
+	/* outbox initialization */
+	rc = mctp_pcc_initialize_mailbox(dev, &mctp_pcc_ndev->outbox,
+					 context.outbox_index);
+	if (rc)
+		goto free_netdev;
+
+	mctp_pcc_ndev->acpi_device = acpi_dev;
+	mctp_pcc_ndev->inbox.client.dev = dev;
+	mctp_pcc_ndev->outbox.client.dev = dev;
+	mctp_pcc_ndev->mdev.dev = ndev;
+	acpi_dev->driver_data = mctp_pcc_ndev;
+
+	/* There is no clean way to pass the MTU to the callback function
+	 * used for registration, so set the values ahead of time.
+	 */
+	mctp_pcc_mtu = mctp_pcc_ndev->outbox.chan->shmem_size -
+		sizeof(struct mctp_pcc_hdr);
+	ndev->mtu = MCTP_MIN_MTU;
+	ndev->max_mtu = mctp_pcc_mtu;
+	ndev->min_mtu = MCTP_MIN_MTU;
+
+	/* ndev needs to be freed before the iomemory (mapped above) gets
+	 * unmapped,  devm resources get freed in reverse to the order they
+	 * are added.
+	 */
+	rc = mctp_register_netdev(ndev, &mctp_netdev_ops, MCTP_PHYS_BINDING_PCC);
+	if (rc)
+		goto free_netdev;
+	return devm_add_action_or_reset(dev, mctp_cleanup_netdev, ndev);
+free_netdev:
+	free_netdev(ndev);
+	return rc;
+}
+
+static const struct acpi_device_id mctp_pcc_device_ids[] = {
+	{ "DMT0001"},
+	{}
+};
+
+static struct acpi_driver mctp_pcc_driver = {
+	.name = "mctp_pcc",
+	.class = "Unknown",
+	.ids = mctp_pcc_device_ids,
+	.ops = {
+		.add = mctp_pcc_driver_add,
+	},
+};
+
+module_acpi_driver(mctp_pcc_driver);
+
+MODULE_DEVICE_TABLE(acpi, mctp_pcc_device_ids);
+
+MODULE_DESCRIPTION("MCTP PCC ACPI device");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Adam Young <admiyo@os.amperecomputing.com>");
-- 
2.43.0


