Return-Path: <netdev+bounces-154896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D8FA0044B
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 07:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E71211881293
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 06:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDA81C173F;
	Fri,  3 Jan 2025 06:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LddhqLa7"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2088.outbound.protection.outlook.com [40.107.103.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D1A1B2183;
	Fri,  3 Jan 2025 06:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735885424; cv=fail; b=GP4ygaWRBYsir20JQIN9w194sWW4Ox+O6jmCpOPMKLfK3I5MD3dgRSTCDn1NKrdCcAtmWu4tYBJKlh4OWp1qP0O0lHc5siMPqvT79l/EAsskJ/u3jE9hOV/NS6uaBVNopEtM4k9FtX1rlymXnQr7NYz14m1GfjadPmxHajrzl2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735885424; c=relaxed/simple;
	bh=7rFRv+QFGSor6bou53ANciafI/s6SbREgrM8l7OQP8c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qHwPiEG/hmMCaBfgtuHlYw+x3VyhA0ktXoI3AhTJc1j4urRLdbeHzNBwP/6ojQQFdepHpzhsskA800K2Jvuva1yFatU93O2VYflqyp5i/iPnSMFrGCP5uRX/9MZW04J3MpH3KnUvLOtCsbube/YiY93nyuuoH1pWiZAZ8uvRbEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LddhqLa7; arc=fail smtp.client-ip=40.107.103.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VNPdM3U2cQt4wNzwBnvgUTn3v4zAB+3SdzgEkX+epFFXbSVO9+OvlW7LdBfWJWROYgyFAkQjdW2Khz0vIgRjCGjszCw9uzTpcDsHvEwByXCyJerQg1vT/Ov8fOe5qSXux1eBy4LT+RXl+EXxbTZL8rxQfVZ34WO3ycKahscxwBNPnBlm9hF5+cbiZHypOCnTLnZMwo1KT22tJrSmGhmC2v7LI0Hq+phMhsWcXws9wmiCZVUQprlZI9x483RjsySqbU3ZmtRio963GdXOA78SbjDmgy0AgKgOUEPQ/tvetyfxZ37zH7e+SEzdULFLeS5+96mgst0aDosycqrFN9yqkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SKmbdyjlUOnASRV1UUrBtrrn//m7/BQBjZhIlweh76w=;
 b=Uw86rrG+90qFt1lECsBBInVVPh3yIaDEgjIRT6Aypp6XAXRGJbBy5d20tsRoMj63Ckn//nLr30jgPxnr9O3p1Yqer86CMmmwpXU6dGi5kFLd/ngwl2X85bZBUEWgreJUPhSi2p6fU6ZiKEoJ4LmyzGBrS+o/viokHxchUDJjUtnvQ0tIFpTsd0Didehfywu05bmayg7ar6A8m0y7gUTSBGK7fDlhI+sK9GJEcSHSFORIUilNnI8hO4nEWL0GpGXJFziLikwMwwtNulYDenqzqaqVm1wQwSJtbKUONWIWqA9XJnZE/ep5h+G/uPCzHUKl1MNs/dcmstnGyz0IElDyWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKmbdyjlUOnASRV1UUrBtrrn//m7/BQBjZhIlweh76w=;
 b=LddhqLa71Q1J/I5/UiyWMnIgQTBCNyACZ3VdXlihd5szeQ/D6ovZRYUOJgwzlkKrHNVQo9gCuKD+839eQTB2Q21s5vRDQBuQ5dzeIHAoYdTjha4j43j6wEixojx/98AxCV5O6nrDEq8sRonP5dcT/IUmyI+37CxxfIra4ArzW4AJ6Ps3bVe3BS+Cj9MVjUbIAhJxtwP2/XSpFUDOautJfiZsMp3g56HwxkEAFo0CFQyPx6NsRIlGvyzPr2CFbMUNExTkCBzPwiqIxIQ4P5ggSK6FtABNognhzP+WjD+uAHLRr9XUJJDmkbPXWwMofRwmQAdb/sEO8jGRYSSOwdo+QA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB9PR04MB9331.eurprd04.prod.outlook.com (2603:10a6:10:36d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Fri, 3 Jan
 2025 06:23:34 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.8314.013; Fri, 3 Jan 2025
 06:23:34 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	christophe.leroy@csgroup.eu
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH net-next 08/13] net: enetc: enable RSS feature by default
Date: Fri,  3 Jan 2025 14:06:04 +0800
Message-Id: <20250103060610.2233908-9-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250103060610.2233908-1-wei.fang@nxp.com>
References: <20250103060610.2233908-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0127.apcprd03.prod.outlook.com
 (2603:1096:4:91::31) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DB9PR04MB9331:EE_
X-MS-Office365-Filtering-Correlation-Id: 2064172a-1899-47df-ed00-08dd2bbf26af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EKyXHaR0n0tSiZioKvjc1PGJ8UoDdwNncuFbw1yE0Q4vKkzQblzE2DcZGTjs?=
 =?us-ascii?Q?5Y4s+SUtsIPeXW3d6DkVUWVQ241/AbjUwQ3cOD90GYQzIH4M7YD2wPpFjtDB?=
 =?us-ascii?Q?WpeF8HdNGPD/PI1hEtAjiJdObJKqgF0lxbie2OTZvvFwj10tQ2rExizZURhR?=
 =?us-ascii?Q?6MyRY0K2RtnDYNQY74Uzc4BFGtGPTDHunCJbx5xV5iVU+qRvESlLnbfULMLX?=
 =?us-ascii?Q?IWn707q/hOE70TWU8Mkum+NWwqspIiBOJkgED+unxRuD/ecPNxsDVHSLgrQt?=
 =?us-ascii?Q?g4aln6q7oAUpvnZSVH0IPjkprPP3XhhKmWQbI46JZp/zHh9t8aR1FCPUCWxz?=
 =?us-ascii?Q?E7RFrPbnX1riOkW+2ai+7w1ON7XlUEaOYFFaBD3Xpx7hmCX4bPuQs/orOTTP?=
 =?us-ascii?Q?GxUASf+7xYOu9D+V1ZNslM5lDB5DlaU8GL40+rpNtSObEUo7117mrrdZ7mev?=
 =?us-ascii?Q?p/nz1MuONPHzApEIXuNBCV+eQJLlccywFcN0BtiEI0MkAqppj9SAGUshoi00?=
 =?us-ascii?Q?kepH+CqwWH3cw7MAq+ktf4q3NrFhykTyfsdgNKm414ywrQL7RyLz9QyXl46b?=
 =?us-ascii?Q?sIVGT9/LfW16protDhNW5MiQWr/Qfem8GwVjj0iciYx06mz/gZ+Y5XMoAZcg?=
 =?us-ascii?Q?F1DMDY1vX5UT5Vtt2zdg+x1+fuY8ysXXegEx0l6UrX0jGN74rTKzgKxvrzGe?=
 =?us-ascii?Q?eUCKhSzjlAf2SBMRocFM0wNKGvoZOMxk2pHDQ5gUQQP+2LmL/I0SdVQETo9a?=
 =?us-ascii?Q?cLpaSNnCupOlo7IR3J5ZGzGQqDcajMq48tNsya7dOFxoW9gAM5AxqsiB73DS?=
 =?us-ascii?Q?HOc1jrNSH1EppK4WyPBDwQ0b3atXxeZstYTDybGGmT+fH0LLUim3SwQJNGZA?=
 =?us-ascii?Q?4x/ZxOGkwsiyx0gU8G+5dVaq6wtLsv20H0CsmerlaSHJRHn4lbg9ceh7bYU3?=
 =?us-ascii?Q?S8hUT5NpdIy9aeU2XoKsXKT7EALTel+fmtEVEEho0cOrZValY+qjiVXGjpE1?=
 =?us-ascii?Q?efOEiB713dsMb33IVBi5bvTkl0GHAR7gveiLHmH389+buu3r7Ki08GFfHToW?=
 =?us-ascii?Q?7J3yf1aKl+ND6YXHJEyhNxtbbVfEaLFBtE3H+AQK1MCqYI8zaykuKwUnOi7/?=
 =?us-ascii?Q?no/nY6i7Oo5xcemtqD6obsB6zOmcriXUYJsWiBnFv6UCqPC9TI4dbVmFjXuW?=
 =?us-ascii?Q?eTLeNm6dV6yl9TDXdOsiazPIxitfDIbazMSHSAuv2Nje+7lcnCoYlUfT5tVM?=
 =?us-ascii?Q?blVyybiCSTkQYnm9ZOGS1zSzUSIaF9rFvetTn6p1UyZqFKl7ofnBAyzxrkkr?=
 =?us-ascii?Q?+oJD5ln1FBaFzigV2lCPB6xPSLkCbxZeYeQEsFJZgkN5+0dywL+Q0r8I5awg?=
 =?us-ascii?Q?0kOV1H6FvEr4yrNTu7Zgx9h4/OjAS8Re6K65+0FVRExkq4QZZfLK/hy7YzTf?=
 =?us-ascii?Q?asQ9VGJ7jojndQVjwSoXaz1mTXBpZNQp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8OVgjBIta+AVFL7JE7GpRlp42pL3nqqVTZZxo4ZDr6Bjy8xblB57MWN1LzC6?=
 =?us-ascii?Q?1gDBIG/er+zTNAFdriy0s+JE0ciV0P7RYIU/aRIKmZxDuhxvPtlTLqvMtUor?=
 =?us-ascii?Q?pvdQzOVZXBBzwtRY5d3sXVCZCLtvO1WzpC2EK3NyX7ae57ve152d662tiD/5?=
 =?us-ascii?Q?bwvTD+Uoqk4lV0X0Z88Xx3/gaHoODlw0TtKeIZSr7ieINXOFuUKh0ZILpDw7?=
 =?us-ascii?Q?VwSi4bgpwWksG8GSOWyavgds/wy/1WLPLxhRh+Ht/hphQpfWqXr5lzVGgjva?=
 =?us-ascii?Q?jWS3KaNYzbKkufV4g7Cc7pPE12rlmxK/k5y/R2BgIe5S8f1i68ea+PszNk5s?=
 =?us-ascii?Q?73giBgnt6XrhJRhWgFYE2FDWMKfUVKnRpKAI9Fw7e6+KqKvSawG6B6HFvxam?=
 =?us-ascii?Q?2zOEiClxzj8duAD2e+HVDlnvARb5HxVBSSLhk5TgnT/sGlWl7qXRwZKyiyRR?=
 =?us-ascii?Q?+JPVkFIaUf5HUCpoY1X5eHwm2oRbyPaY2DBtribNCq0dBIPQofac3YZldV5/?=
 =?us-ascii?Q?aP4h6dNTNk3Gs7cQaQJAKXFr2BYOI1V64bM5n+WHcUNCwsJeRlfgGwT7CdQO?=
 =?us-ascii?Q?BCWv3VUUaf3PvBhnm5o0E7UL37g92c8Z58z39ibHRwWqk1/nkDlvBKGoFM+r?=
 =?us-ascii?Q?XRdbzVJ13rpeVn3D1QbUhomPO1ZmpuFaI6TRWsB06TZkzqF8awOqzwc6x5fq?=
 =?us-ascii?Q?xJ+MepBcKqlGaIGdmlpZ4QQ5ZaG3lv3epEMYVq4rFHCVYWMrQMiA0BttXDlq?=
 =?us-ascii?Q?y1mwK0PM+LguG1/CReh6qgdjZ0p/o7KuTVx2zbkg5RoFGNpTrP4yCeKZ2Euv?=
 =?us-ascii?Q?4h+HOsl3G2C1BEqo9IwME8uR+CGODkVjCtrbxNvKkEp8d2eqzZva/b2FrFcV?=
 =?us-ascii?Q?WtvpAlf5bqZKhW6H+9qeZ31nCBIdxEblXdI+xYn0aB9ok/HTJLszUBihKn6r?=
 =?us-ascii?Q?EHinERH4X3RExuxuV5FtqLnwwtEiDapbCLPufs/WUTwj1C9qWJz2Xe++dA4t?=
 =?us-ascii?Q?Y0nwSwxkZzlCjoiHBRfZELbO2PuZEchohsffikGeGTvaicMm25yDnqSRQ3gX?=
 =?us-ascii?Q?zKqfAAG9d3ZbFry94S2Vj4wvPWp85M8is4fLPilBEl5pj8QrbOtKlXZYDNI4?=
 =?us-ascii?Q?uPjgELSkmv97CwUWRoyBay6pvLvZ4pApfvsgqL3YCdvAzivNrHlc4pbDaBYL?=
 =?us-ascii?Q?JC0a7Xbzxo3Cg8atHFp6NqYCEjZoLtmSNpPqEb0kmp14uK6gNSm0yAHHy5Qn?=
 =?us-ascii?Q?YQ57m8AIJ5lOj8w1PskKaLOAGxVKtxh3G9IeESpaKCaqP/JS9FKFGc7XkUs+?=
 =?us-ascii?Q?AU5PMSGYmO9XaS2Gj+iu0FBUImDEvl0zW18oSgqTLwDmaAQzUj5Og6DHyUka?=
 =?us-ascii?Q?l7O5r74F8q8XD6//HLSkX3k6I4XuMY33yFWhKhoz5aTQnAFp60GD07jOOIuX?=
 =?us-ascii?Q?Ej16zffnoi3nPxelCK/zNo2N3n14sUSWbLzfuUPGI9N1dMeSeY/ysb34Iu97?=
 =?us-ascii?Q?BMn/TPizk00vO+gk6TgtDlJhsLEik+644Mne1qH8OuhGI8Lx5tbhJ+1vcczL?=
 =?us-ascii?Q?aPs8019lYS4yUeKGGsXY+MbNpjC2mH0psbFnzx0o?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2064172a-1899-47df-ed00-08dd2bbf26af
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 06:23:34.6351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BiJzmxKRC97dk7hSnfa+pqNSuDocSVZqd5x6oU14NIAv+82/vpjwSHtzasLy7x5Z5S/u9RzQX5dLWbO0ByYl7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9331

Receive side scaling (RSS) is a network driver technology that enables
the efficient distribution of network receive processing across multiple
CPUs in multiprocessor systems. Therefore, it is better to enable RSS by
default so that the CPU load can be balanced and network performance can
be improved when then network is enabled.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c  | 35 ++++++++++---------
 .../freescale/enetc/enetc_pf_common.c         |  4 ++-
 .../net/ethernet/freescale/enetc/enetc_vf.c   |  4 ++-
 3 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 233f58e57a20..e27b031c4f46 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -2378,6 +2378,22 @@ static void enetc_set_lso_flags_mask(struct enetc_hw *hw)
 	enetc_wr(hw, ENETC4_SILSOSFMR1, 0);
 }
 
+static int enetc_set_rss(struct net_device *ndev, int en)
+{
+	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+	struct enetc_hw *hw = &priv->si->hw;
+	u32 reg;
+
+	enetc_wr(hw, ENETC_SIRBGCR, priv->num_rx_rings);
+
+	reg = enetc_rd(hw, ENETC_SIMR);
+	reg &= ~ENETC_SIMR_RSSE;
+	reg |= (en) ? ENETC_SIMR_RSSE : 0;
+	enetc_wr(hw, ENETC_SIMR, reg);
+
+	return 0;
+}
+
 int enetc_configure_si(struct enetc_ndev_priv *priv)
 {
 	struct enetc_si *si = priv->si;
@@ -2398,6 +2414,9 @@ int enetc_configure_si(struct enetc_ndev_priv *priv)
 		err = enetc_setup_default_rss_table(si, priv->num_rx_rings);
 		if (err)
 			return err;
+
+		if (priv->ndev->features & NETIF_F_RXHASH)
+			enetc_set_rss(priv->ndev, true);
 	}
 
 	return 0;
@@ -3190,22 +3209,6 @@ struct net_device_stats *enetc_get_stats(struct net_device *ndev)
 }
 EXPORT_SYMBOL_GPL(enetc_get_stats);
 
-static int enetc_set_rss(struct net_device *ndev, int en)
-{
-	struct enetc_ndev_priv *priv = netdev_priv(ndev);
-	struct enetc_hw *hw = &priv->si->hw;
-	u32 reg;
-
-	enetc_wr(hw, ENETC_SIRBGCR, priv->num_rx_rings);
-
-	reg = enetc_rd(hw, ENETC_SIMR);
-	reg &= ~ENETC_SIMR_RSSE;
-	reg |= (en) ? ENETC_SIMR_RSSE : 0;
-	enetc_wr(hw, ENETC_SIMR, reg);
-
-	return 0;
-}
-
 static void enetc_enable_rxvlan(struct net_device *ndev, bool en)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index c346e0e3ad37..a737a7f8c79e 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -128,8 +128,10 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 	if (si->hw_features & ENETC_SI_F_LSO)
 		priv->active_offloads |= ENETC_F_LSO;
 
-	if (si->num_rss)
+	if (si->num_rss) {
 		ndev->hw_features |= NETIF_F_RXHASH;
+		ndev->features |= NETIF_F_RXHASH;
+	}
 
 	/* TODO: currently, i.MX95 ENETC driver does not support advanced features */
 	if (!is_enetc_rev1(si)) {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
index 072e5b40a199..3372a9a779a6 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
@@ -155,8 +155,10 @@ static void enetc_vf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 	ndev->vlan_features = NETIF_F_SG | NETIF_F_HW_CSUM |
 			      NETIF_F_TSO | NETIF_F_TSO6;
 
-	if (si->num_rss)
+	if (si->num_rss) {
 		ndev->hw_features |= NETIF_F_RXHASH;
+		ndev->features |= NETIF_F_RXHASH;
+	}
 
 	/* pick up primary MAC address from SI */
 	enetc_load_primary_mac_addr(&si->hw, ndev);
-- 
2.34.1


