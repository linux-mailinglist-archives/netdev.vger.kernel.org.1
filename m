Return-Path: <netdev+bounces-215964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DADB31290
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 11:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DBB504E5B1F
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 09:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8FC2ED84E;
	Fri, 22 Aug 2025 09:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b="A0K+YxLI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A43B225762;
	Fri, 22 Aug 2025 09:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755853714; cv=fail; b=Rq1/vXQzDjDwEjZCApaB/fRfr00nhS4SDgoc2iDIVzBAcD9lqtIB5F7X7Lo3LybXT7tKoo1LFbtFjFLjMpFIEyBvFoAThNGLoqdOOqmmWbPcWhsZ5fWIml384Xb85NyyRSFi6Ong5cnPcg66D9M9ja3aAf5xzq3Ti90Yu9ur4I4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755853714; c=relaxed/simple;
	bh=636fccD9o+AY9gQUKpxakW/cCHZflZ1UxyP034rK/EU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rZZIwZzLErB+PDP3Hz/R/tXrZGnoL4JhXAJwh+DZaV4VmTh4pm4nWNrd4SJLpGZ7EIwHapx/LhkMQsHNElZJzIFIbiozFkgjVVzUqXcv0BNZK8SFiUREej9OAHXHpEMW8qD5aBzYNVjgXDZYRgKweugkWFRI4llrBaLVj1lp91A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com; spf=pass smtp.mailfrom=maxlinear.com; dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b=A0K+YxLI; arc=fail smtp.client-ip=40.107.94.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxlinear.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WRDaXTAXU3IqEHL9psUovOhL2w1kRZOwrYVTwxIK7rAA1Bxu9c9UAzAWYrNilTimOOj0FdyU/kvG8lUz49bkTRwAwH7zp5iP80ySu6hXffkoPh/qn3K8sgWxEtntx6j2BnhGga4xLv3/kM1CMQxh2VlcIVA+Oqg0ZXVU+kAjaBtDN9fIwro/x/B+T3KR3/PPPlLEaB0sEkbS/CKu/Lyn8Uz23mr5nMzmhDArUS+STE3r2K/Tn7l+YWp9a/dokpaHTLc8vGVk636ahbq16dmGJmSd0y0JcFAJpN4kJ/e6zyuMBsJWMAMjlW5VncOM4UnTRTEEojSPGwl1dKmoVHBZJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rxEmkj7WKZnmFTfPcPSBvmguCRvieEyfXi9xzmoBlF8=;
 b=OzSWoQtCb7sHp50lEAuiMawReLVcoSzLHnAcov4HnrF7K6pKzdza72DSnVHZwEoeHELBkT50htO3+G9ThWh0LEhpQKQSS4pfIcNg3m1GlPEPHMn4IqAbS/CkN3wUK8Dl8WKx7nWwhqe7D4sRIvTiDBTAXNl0T+g1TsdWvPOpOBwcb7dTWzbhQ+J38bULrX7Lt+Mw53adiH0Jh/kTsiFx1wO+E+vZN0HMOew9N1mniz+HcoQAN7tcJPXozNEEBH2xLJ2KrIkKhkQnoDaiqF4HHCP/1l0HutVLnO+YMs0pWWqY0Zj2q1dwKFqOk/cMIOQqTJqehbF34s7X4/uDAgQ9pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 174.47.1.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=maxlinear.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=maxlinear.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxEmkj7WKZnmFTfPcPSBvmguCRvieEyfXi9xzmoBlF8=;
 b=A0K+YxLIVy5NmxItk6cdk6QVW5m9HlSXfJiRuIdrQAm5E55vq75vGJAHF6u2yLfpHw/+Sl39uy9BWNdUQTyDZeCsFt6Z6ubAXacz+aumhSAUpAh3R72zsKktj6TN3T+CnDlkPVkAXDgZvVQw1Ehufq3u4pFdUfsiGZ5fryJUU33C6pzLALeOg20hTEc3XEFUSbQ6IE7w0PGi7DzChJjQeev3H9BoaK6AcIPIeB0RwHoyMGVXY5fGw8AlxMs2icTvJ/bxiT1+AR7ak1cdbNaW0lkjVFV7N7w8OJczub3oXpSNY3d8W79zsEWrHanoLYxyRqY3eWFWWvsKfEfv3KHA1A==
Received: from MN0PR04CA0008.namprd04.prod.outlook.com (2603:10b6:208:52d::22)
 by SA3PR19MB8193.namprd19.prod.outlook.com (2603:10b6:806:37e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Fri, 22 Aug
 2025 09:08:27 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:52d:cafe::88) by MN0PR04CA0008.outlook.office365.com
 (2603:10b6:208:52d::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.17 via Frontend Transport; Fri,
 22 Aug 2025 09:08:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 174.47.1.83)
 smtp.mailfrom=maxlinear.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=maxlinear.com;
Received-SPF: Pass (protection.outlook.com: domain of maxlinear.com designates
 174.47.1.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=174.47.1.83; helo=usmxlcas.maxlinear.com; pr=C
Received: from usmxlcas.maxlinear.com (174.47.1.83) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 09:08:26 +0000
Received: from sgb016.sgsw.maxlinear.com (10.23.238.16) by mail.maxlinear.com
 (10.23.38.120) with Microsoft SMTP Server id 15.1.2507.55; Fri, 22 Aug 2025
 02:08:21 -0700
From: Jack Ping CHNG <jchng@maxlinear.com>
To: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <davem@davemloft.net>, <andrew+netdev@lunn.ch>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <yzhu@maxlinear.com>,
	<sureshnagaraj@maxlinear.com>, Jack Ping CHNG <jchng@maxlinear.com>
Subject: [PATCH net-next 0/2] Add MxL Ethernet driver & devicetree binding
Date: Fri, 22 Aug 2025 17:08:07 +0800
Message-ID: <20250822090809.1464232-1-jchng@maxlinear.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|SA3PR19MB8193:EE_
X-MS-Office365-Filtering-Correlation-Id: c5fd845b-9c2e-492f-024d-08dde15b7429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Tjd6v14/ZWQxBaGs7o50E3u+agHvZyJ5NloIJBLbCXZ0DLbOPz0moPvB8kaF?=
 =?us-ascii?Q?GIZm6ZdDhcCj09QnDVjgw4Ad+L38RHd1F7T1Q3XPtfRVg0FWuJV5uOVfEeyw?=
 =?us-ascii?Q?lyaba3Er8qXxVsIPhqZpmw9hyGb9II2ys6swIH8/72kOTPCeQOLWQb/pOz5y?=
 =?us-ascii?Q?vd+6nJK9h9ASEsJ50BkAYnrwtkezjBHJ7/jy2rvgADjm5JIwzXbnwlmm9DCT?=
 =?us-ascii?Q?F0LV4NbBlg/SR71BXmQRH5iStDZccK43MHJO/oo0A+MUN4Hou5xGB35QjrTg?=
 =?us-ascii?Q?YwB6Qdb4eWfkTyRo2Np45j7xKJeI5Z/h17B5wqETfVEjpHx0mgGV39sXKKPu?=
 =?us-ascii?Q?mRy7nRpfn5mB4oXznOeJmHnJxEtGBWlfQM1DFBhKQcbc3kkRFVxJrRG0XlIX?=
 =?us-ascii?Q?UGugZvkQEtw5MpsNdwduyM+ByDdxXs3BXa8w7KmATIqYcLz0lKk+P/+39Dcc?=
 =?us-ascii?Q?VNV750UHeDcWAsidl7zzKIOahIvoNxGxaLEI+KHxbpEnXwQzaSy5tXPYyxPL?=
 =?us-ascii?Q?U1AXQpy6Af9Y39rEiNqBy5aEgwNV03ezsq4PQ4t9YOVlsDO83rCTLb364mVb?=
 =?us-ascii?Q?cQaVHJev1Kjm3TjkBkzuLT5BqoN/cPW58p2MoUSZZBEU1YJyEyV/Fa+FffUF?=
 =?us-ascii?Q?cmWgabSZitGcqN01efZPIl07VLv9HdQP+XBbyyitYCpOP8SpWpeSPJ654Syn?=
 =?us-ascii?Q?GkM8ZOtPJVp3g40yq5DrMnj0K5ETrpqTH5AVPIAYf8yQjCyh1dEstnDVwucD?=
 =?us-ascii?Q?I9ujIxXyt4uHLYwXRvC2sG+fFanLhiB3gfse7lvZHLrUGaDCVznhM73afCdE?=
 =?us-ascii?Q?xm61sTHnJ0zQci7halmMZ6OaZ6Z5M6gNK37+Qf/S90qNaMXHYUpPVbQ+A9V1?=
 =?us-ascii?Q?3fK1vCnO09vS4vIWm0pvBMqpTk1Lze77J54EfnmJOij2/GzNZ9+2TfsqY4/M?=
 =?us-ascii?Q?bC71IweQhAaz4Ll/ppuilkwZ9OdQVvAQdHU9ntruII3v5qY9V6KfD7RYeKpi?=
 =?us-ascii?Q?PU8oTfyiBm0yXOtF+bk1UKi+xyTOoOzfzg+fvPThMnCuoNPktdedHoKwwfji?=
 =?us-ascii?Q?8D91krRAbxt7ZWMDP+e+9cGHCPUVq2fC26e3UOIF2cmGm4sSrMfSlTxOv9TO?=
 =?us-ascii?Q?6AB/EZnqeY0QIJeNVPgC8/RTn91/snpsEGD++7uF0o8WBtXvlP3/zo+y/zcT?=
 =?us-ascii?Q?59yhLMF7eKdj694SE4yjYCSbFqB/vRMVe9yggpJGaMTRReh1jLdu22f2B9Rn?=
 =?us-ascii?Q?DBGNfS/Rd1jJmMGWq7Ahylf50xDkQ3EtGxjNLd1ozFvGb1x4L+P3hzXuG4FN?=
 =?us-ascii?Q?v1aFRwJ/onE7JsnmFGTr8KpBVJfjqf7JcSRu0dnA1NNgP23a6jtBMPEC2zxR?=
 =?us-ascii?Q?YuytYW72TzYNFsnJ+b4yxI+BPeNhDKj6lrLWhZTzzmkr94t/y3SwsWit3HAF?=
 =?us-ascii?Q?oSyQZpgJo4vGqStv8MRSf0Z07UGOhBQrNMcbMDqIzvYgeWi0CAgW16FmaJSU?=
 =?us-ascii?Q?ufAunbY2yIi+yd0gOkXpfAtPem9clqz8zU4D?=
X-Forefront-Antispam-Report:
	CIP:174.47.1.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:usmxlcas.maxlinear.com;PTR:174-47-1-83.static.ctl.one;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 09:08:26.2083
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5fd845b-9c2e-492f-024d-08dde15b7429
X-MS-Exchange-CrossTenant-Id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=dac28005-13e0-41b8-8280-7663835f2b1d;Ip=[174.47.1.83];Helo=[usmxlcas.maxlinear.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR19MB8193

Hello netdev maintainers,

This patch series adds support for the MaxLinear LGM SoC's Ethernet
controller, including:

Patch 1: Adds build infrastructure and the main driver for the MaxLinear LGM
SoC Ethernet controller.
Patch 2: Introduces the devicetree binding documentation for the MaxLinear LGM
Network Processor.

The driver supports multi-port operation and is integrated with standard Linux
network device driver framework. The devicetree binding documents the required
properties for the hardware description.

Please review and let me know if any changes are required.

Jack Ping CHNG (2):
  net: maxlinear: Add build support for MxL SoC
  dt-bindings: net: mxl: Add MxL LGM Network Processor SoC

 .../devicetree/bindings/net/mxl,lgm-eth.yaml  |  59 +++++
 .../device_drivers/ethernet/index.rst         |   1 +
 .../device_drivers/ethernet/maxlinear/mxl.rst |  72 ++++++
 MAINTAINERS                                   |   7 +
 drivers/net/ethernet/Kconfig                  |   1 +
 drivers/net/ethernet/Makefile                 |   1 +
 drivers/net/ethernet/maxlinear/Kconfig        |  15 ++
 drivers/net/ethernet/maxlinear/Makefile       |   6 +
 drivers/net/ethernet/maxlinear/mxl_eth.c      | 205 ++++++++++++++++++
 9 files changed, 367 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/mxl,lgm-eth.yaml
 create mode 100644 Documentation/networking/device_drivers/ethernet/maxlinear/mxl.rst
 create mode 100644 drivers/net/ethernet/maxlinear/Kconfig
 create mode 100644 drivers/net/ethernet/maxlinear/Makefile
 create mode 100644 drivers/net/ethernet/maxlinear/mxl_eth.c

-- 
2.34.1


