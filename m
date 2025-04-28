Return-Path: <netdev+bounces-186384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04497A9EEB1
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 13:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 520BC189BAAF
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 11:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B11F25F7AA;
	Mon, 28 Apr 2025 11:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LqsobgHs"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2079.outbound.protection.outlook.com [40.107.22.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4011367;
	Mon, 28 Apr 2025 11:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745838960; cv=fail; b=GZ1+ncEtrY1gTvaJumSLky6wNvZPfdLXeu6GhV4kRZtTvDaguV4lidf9kY3i6RMxX9XtmvgJVmGKDYHE7EblFGxkF+j507WoRuDN/hFhcc2x4UKh+ocOTPppUwtH3tGRvk7766hQS9NGZwI/7ORwiSvfcb6ydqR+0+WArKjzbCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745838960; c=relaxed/simple;
	bh=zxLrmQmn5VF8r2kYAoLdh+jHqghbzCMl4sWhEJLZnKc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=L3haJVQdzbydZXEdH35PXqFLlmeIJGF9EK5p+gW7TCz9p+ICaGKXWJGx27HAw7GY2JZUNt9sigB98SRFLsO54zM8MyCCv4WlIbo2j3OFAPmmd2LahbeyThczDocE1kqMG/tAVgHPGCCNiCOGAcKaOEJkMN/Qj+vceEDNlkobV8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LqsobgHs; arc=fail smtp.client-ip=40.107.22.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hIvbdXUBNd0a0XS9nhXgEFeRbB2Zhu9rLJ+gtOQon7FQRsPdGIZQUSSmvQITP19oWznKyAYvWDgzWND6a5me7ag7ygGRCUeTL4ASEv6T8RFr3rBG4MWwg0PHI3xz3PRjimrcWQ39bdSr/bN4dlWHBV/CaQW53LnE6FkssyPHM4+E17+2l2AXz4a3whBPNNEf/2mtKdRXMJvZnbc7EHOf14gaWzWwY3aH+As/gRV5KTwPQ+UGw/r9/qtMfVJSFTR+O0FLETWrryp7GXbX/GA6sbmzOFjqABa1r3rQOTcr3z3x0KvlJB3JxjnyMddqCNBu/4sUx3DJlln1sSBBFG/67g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QqBob/xRglktit8te2Z2QXwAFCEZPahTfIQzk4W7iuM=;
 b=FT4mvPW++UVatfxrXCkm3MsPKHHaCQlQjlyf0Pecco0TtNEBq1RXtM5HtOjq/1rtAQRiqyqNLEXSjKY7VIRFYoQp+tD/kQBiVx3oX/wWzjHgvcHcAPN9PduZQZ3w1mIcjSl05a7bSnPJ8Hl3+i4tlf/nGT0IJ0nb/PJvtwWGtB/D3V/bJgxDrgoPPzdRH94J3FB12WTEtyt5naQ6vBB97EZLJyRlnbccvk/bD+oo5HcJ7yDSZyXy6vmW0/aa9DqhLEM6O8/WWYHFGPpHpCGICyncWjmva6/Ev2hzjOrhVENDXuCG7jW5rkQ5gAu9MeEF9Pmb8jRoXUlwnc2xJWAfBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QqBob/xRglktit8te2Z2QXwAFCEZPahTfIQzk4W7iuM=;
 b=LqsobgHs9cTdbWJDZl89NfWkPlbbJn1QuAGmMbjktLjTKqa1erV+xX7Xn/0U3PLUfF3ISD49Va42aStWCSVeFlahGWY98cjqEwpnHLIzJsV5nv9+w2MtOpAgV6F5Wqv87+l2toOOg8s4HSsSoKmTMzIRg+Jng2j9ePKCli3yZVRYuLZATX4xLtTOGLjJ2flWqK4WdcqEvoExb+A13V8EP5kYvskWT+65LnnNvhk1odxqiyy+aWTb7I4B1s4NbqALWbVyUFq1syX7nI4KzYb05OAsdURrmjQ5Vt6+AHMPbmujNdXZgD8gRzaZmvOYBveL0j3cq31SVhT0ctQB4zltQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB10360.eurprd04.prod.outlook.com (2603:10a6:102:44c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 28 Apr
 2025 11:15:55 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.8678.025; Mon, 28 Apr 2025
 11:15:55 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: christophe.leroy@csgroup.eu,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 net-next 00/14] Add more features for ENETC v4 - round 2
Date: Mon, 28 Apr 2025 18:56:43 +0800
Message-Id: <20250428105657.3283130-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0019.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::6)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA1PR04MB10360:EE_
X-MS-Office365-Filtering-Correlation-Id: 7207322c-ffb1-4ac4-521c-08dd86460b27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0Gyw/aUZSzUS3/fdKS+ZuQOS7Co3RmVPIn/hAri9sTtyqD2X+6V/mAsdlNQC?=
 =?us-ascii?Q?bv7QsAb0Yby1tazU5KCmKZhJ9WldxqfbBrqe0wlB5wo82G0dQANHqRXL/WqF?=
 =?us-ascii?Q?lWKVFf2LesQHoSIh8vAT8wSgU433mGQ+jiNH5tTgprv/5IzSI5YT9z4OmbHx?=
 =?us-ascii?Q?ErJRDIXEUwpHmXHYs1Lm6TwjFndH1/ZYxJxatrYLzwFxPgVGn5D3iicEgPwf?=
 =?us-ascii?Q?1sUT2wJ6sQOsy+emIw9M9a7dvo2uK3FnR3zQQaSrhlIiYoHa8ug+wlV50ap6?=
 =?us-ascii?Q?c6DXMVGalN37RS+0/AQXT/i5Cxgu7+UJMd0Sx3PCiTWAcoJyCnYyzVcso/gK?=
 =?us-ascii?Q?OF3tyJob/eXMruATUKfJX6bnn16eSyJa3RQ8mLK1O2JuxpmlTKCG6vyPJd9s?=
 =?us-ascii?Q?fN60fSDm8IOHhmTLITP69s1bbHQ0PFUHqNI2b7tX1zirq+xe9/qCjQzj5gKL?=
 =?us-ascii?Q?1QY82xLk23c1h5uw7w8OkmcqcIUHtGMudMc6J+pBmzH1Xr1olSL/lNQ8UpCK?=
 =?us-ascii?Q?Qh0EQlHX4EF7ncxdNMDnwFNLql4bsTPSHLu8Knp8jZ4xQaBdskboRUhzyYqO?=
 =?us-ascii?Q?LzsHSc71DDgrft93z5mxU6u47kf7lRE4UPY+rQfFdgL9XPB6qIPTQzg1fdu4?=
 =?us-ascii?Q?6gM02C9yX4alMz9VvjEjxJ8kr3Elde7nA8WX+XX4H7Sp5RyY0mwMMDRXUYqP?=
 =?us-ascii?Q?7dkZO1hpdqt4GPciU8BLOf5ZXrDeixMey6AhSc6cmf6Bg+dUPsv5HXDxURz0?=
 =?us-ascii?Q?CtbKQffRo3DMVJgMdxz6mwY7LJ6Ferj7XtWyp0mw6/xTa1C4oUOcMRC17ZcN?=
 =?us-ascii?Q?cPlJpt84j0FgNQ3Tjy8Y3XMvSIi77XydTZHXZ5iM0Dn0xqtG3u6BGEZIPQSJ?=
 =?us-ascii?Q?HTE6If4mUtKYiss0wCmSWVFz7nszYg5R5huk825vUduHfYcaLaU8i1pfyAgc?=
 =?us-ascii?Q?MYPWOVY2+uEai5hnpD4GCxvHjg2QfSdCRQpkw1TVijjbAdSPC9s9HzXhs8tu?=
 =?us-ascii?Q?dkjwg0ofV4Wt77tbEAzSkilJfQLC9TlVX0VEo+UtcLiHvSem0oDmiGGX1JS0?=
 =?us-ascii?Q?u5EmM1fRPSF1UuvpnUMfpBV8SjnQKeHA2AnWtDKS0C85HdnwY/zTWYsAsDHb?=
 =?us-ascii?Q?wrRocO56CxKxBQFyF9BbRs7x9zVeMJmmLRplMnHmEVef6EwUzLfdFfbUuvmf?=
 =?us-ascii?Q?n49x3gDylExYUzNSY6m0OGrxcnGVlQS2R2omPLPGkUPg5UjHVNb9K/4oqhjc?=
 =?us-ascii?Q?DrBwblhvpiXJ7WAzW3NN622DPigwx5Li19e2Dzal844Wq2noXO+ZqtwXtoq8?=
 =?us-ascii?Q?CvtVKCO9Ic7BmxhWBJCEmm//lFkY+UvUZfjPYERGCVuSRrSyy5fXjEzutVPO?=
 =?us-ascii?Q?P+QAaHeqTXWDCVf3iHpU9WyjsVAbrIR6C5Wn5F2eUlA/W9bWKgPAvuJP8tRH?=
 =?us-ascii?Q?1lRHwziV7tWlgnM3gHAooX74Hy4MBfj9oRX3Ka2HkkhDG445ZsVWYlIjPLX2?=
 =?us-ascii?Q?e00A9JURWN3ydiE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WQUnFN6j0i2CD2Ddd5sWfC66xN8Q6szVwD2jDiU03iLi4Gqzfpqoe/De1ejS?=
 =?us-ascii?Q?vv+m9pQfKM4BbVAqdVkTwGx9tuw7geolaF4Rn0q5DreELaKKOazKrvyCKOWH?=
 =?us-ascii?Q?rNtVWPzt/36Whozwk87J4QeU1ZIVtBwMNy2gtOMHbE5FdvKqq0Ik56firFvp?=
 =?us-ascii?Q?5u4B4eUeWvBHdEJwWDqTgDkSOd9ukcYMPGq/VeZXx1QWCKhjxFB2At/jqA/p?=
 =?us-ascii?Q?QUmeu1eOiiIhHmJWeNoT02qxUAt7rvI0koX/gvLnEVZi0lbvuTJwRlpdVAT9?=
 =?us-ascii?Q?Oo29KRx6VWRTALb2TaqD+ZrtMF9e3VPX6gAdQ5NoRd633NjjzKNF7e4sfV92?=
 =?us-ascii?Q?qBMk40I3Ws/82AnXt3ALq3vnLNDW7+/LjkS0AFk5eHXd5DWQ0R8uPMV9VWq7?=
 =?us-ascii?Q?zKZ3X1g/XLZiEanQmCS9lwS3j5lQJce1atyZdKX+A5X8KivUhVFrH4L0BNFh?=
 =?us-ascii?Q?Z2Zi9VZiOgjJmeFkzeP3ppVo7T8v/ZD/5qhRFMe11KMDylHs8MvLMs37v5dE?=
 =?us-ascii?Q?+3atWCIykGnnHAoeFs4xDndoM5je7cWb4libw+Zfo7dnsCwnLTjZhHeBS2Fl?=
 =?us-ascii?Q?wt1h0uuQdmnqfReLXRKjFfMEdvSTJh4u1DcVA7kRLATelDnmoeAO8PKu2mSS?=
 =?us-ascii?Q?jfVQTFW+V+Mvvm3iBsX+5xfbW7A5ran9Z2oSrJAM6Qnv0v8SYpK9UnbnYd0U?=
 =?us-ascii?Q?tiWv1lDTvFbZVk7GZLZGvC3xP1zjaS9gHeJi3Pj38oPJCRxB/bSNjJc3943R?=
 =?us-ascii?Q?U01h+c3EkUHSaspk3WF1F7+EPv1ActIMmGpkXrhaXJXIqpMK3CEmotvDdDBn?=
 =?us-ascii?Q?1MIh7Rj9kIntL2UbxAHDVuvOPEgce6Wkgf6+Lfik+3jbtIpkCaC3JZQ4sfqV?=
 =?us-ascii?Q?uww+5H1tRNoSL8UoQYxYhyR/u15UgtZKwDZapObqs4OLrRLLqEzW02rbAcEj?=
 =?us-ascii?Q?PB8CFjaEZPwqmHmwxNO97l1jwWg3BqLrv/8f5PDupV5gvqndZy/gbaPbh7vA?=
 =?us-ascii?Q?Y5zEnl5sOfNQIbRgKTRRww9eSAstBHVepmKpEw7gKNt5p9wDMnYLQlJpajXy?=
 =?us-ascii?Q?Dt9VpRnv79ACEuwo3SZU9HMow5cDXLn1kKC9hpUxvOiqjgIwl3UyAV4eImUs?=
 =?us-ascii?Q?CX/Aiiz2uWfO8cKYjGN9R7cZ3wiRshnMheAR9YusN3TSVtLZO2/QIaZypiGx?=
 =?us-ascii?Q?GbiiNBwm4cA33q0m0iUCejrxqA3eoClrBs1nNmifP6Jxc8xS4I5zfmhdDQQy?=
 =?us-ascii?Q?gDzUlOUfPFc+qZPS8R/ERTEwgJwZPKCxLTVqan8kdQUq9RVA+m1L9GabSNKO?=
 =?us-ascii?Q?vNROClQRqs2DqaXaiB6CXQ2g/GM7+ewJnMfLk9Tws1bnEP5RzvmmIIJgfM7p?=
 =?us-ascii?Q?qCxwz9floEbCevuDrgMchIT/nHEfBiASf+BCKm2JVTBuL8r1FXPIZgJD0ipi?=
 =?us-ascii?Q?5WreMPKbgWljlUF2A5zPfHpjZsNEiECUp4CSngYnSCnJwKKzApwTFUO4yD2L?=
 =?us-ascii?Q?bakcah/l6DrZrgVIrMzE0kVlUJ4luuao6oCaEOo9Qf3QJkMNtlv1EmUWQeZS?=
 =?us-ascii?Q?b1MappVXgATtTcNCliQru3jMjIwHw11NqiwURSC4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7207322c-ffb1-4ac4-521c-08dd86460b27
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 11:15:55.2230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bTqxe+fXBfCKBq0cAlDkWF/1SjkTl1Go/mb9ywxuVM0u9jcHotrc3uIF4QkEGULIWbZazNaLFERA/xO6W3g7xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10360

This patch set adds the following features.
1. Compared with ENETC v1, the formats of tables and command BD of ENETC
v4 have changed significantly, and the two are not compatible. Therefore,
in order to support the NETC Table Management Protocol (NTMP) v2.0, we
introduced the netc-lib driver and added support for MAC address filter
table and RSS table.
2. Add MAC filter and VLAN filter support for i.MX95 ENETC PF.
3. Add RSS support for i.MX95 ENETC PF.
4. Add loopback support for i.MX95 ENETC PF.

---
v1 Link: https://lore.kernel.org/imx/20250103060610.2233908-1-wei.fang@nxp.com/
v2 Link: https://lore.kernel.org/imx/20250113082245.2332775-1-wei.fang@nxp.com/
v3 Link: https://lore.kernel.org/imx/20250304072201.1332603-1-wei.fang@nxp.com/
v4 Link: https://lore.kernel.org/imx/20250311053830.1516523-1-wei.fang@nxp.com/
v5 Link: https://lore.kernel.org/imx/20250411095752.3072696-1-wei.fang@nxp.com/
---

Wei Fang (14):
  net: enetc: add initial netc-lib driver to support NTMP
  net: enetc: add command BD ring support for i.MX95 ENETC
  net: enetc: move generic MAC filtering interfaces to enetc-core
  net: enetc: add MAC filtering for i.MX95 ENETC PF
  net: enetc: add debugfs interface to dump MAC filter
  net: enetc: add set/get_rss_table() hooks to enetc_si_ops
  net: enetc: make enetc_set_rss_key() reusable
  net: enetc: add RSS support for i.MX95 ENETC PF
  net: enetc: change enetc_set_rss() to void type
  net: enetc: enable RSS feature by default
  net: enetc: extract enetc_refresh_vlan_ht_filter()
  net: enetc: move generic VLAN hash filter functions to
    enetc_pf_common.c
  net: enetc: add VLAN filtering support for i.MX95 ENETC PF
  net: enetc: add loopback support for i.MX95 ENETC PF

 MAINTAINERS                                   |   1 +
 drivers/net/ethernet/freescale/enetc/Kconfig  |   8 +
 drivers/net/ethernet/freescale/enetc/Makefile |   4 +
 drivers/net/ethernet/freescale/enetc/enetc.c  |  76 ++-
 drivers/net/ethernet/freescale/enetc/enetc.h  |  45 +-
 .../ethernet/freescale/enetc/enetc4_debugfs.c |  90 ++++
 .../ethernet/freescale/enetc/enetc4_debugfs.h |  20 +
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  12 +
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 368 +++++++++++++-
 .../net/ethernet/freescale/enetc/enetc_cbdr.c |  50 ++
 .../ethernet/freescale/enetc/enetc_ethtool.c  |  74 ++-
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 105 +---
 .../net/ethernet/freescale/enetc/enetc_pf.h   |  14 +-
 .../freescale/enetc/enetc_pf_common.c         |  93 +++-
 .../freescale/enetc/enetc_pf_common.h         |   3 +
 .../net/ethernet/freescale/enetc/enetc_vf.c   |  10 +-
 drivers/net/ethernet/freescale/enetc/ntmp.c   | 462 ++++++++++++++++++
 .../ethernet/freescale/enetc/ntmp_private.h   | 103 ++++
 include/linux/fsl/ntmp.h                      | 121 +++++
 19 files changed, 1485 insertions(+), 174 deletions(-)
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc4_debugfs.h
 create mode 100644 drivers/net/ethernet/freescale/enetc/ntmp.c
 create mode 100644 drivers/net/ethernet/freescale/enetc/ntmp_private.h
 create mode 100644 include/linux/fsl/ntmp.h

-- 
2.34.1


