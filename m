Return-Path: <netdev+bounces-233056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 55391C0BACA
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 03:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 16FF54EEE11
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 02:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CFF2D3ECA;
	Mon, 27 Oct 2025 02:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GkhKdOQr"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013058.outbound.protection.outlook.com [52.101.83.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BE12D29CE;
	Mon, 27 Oct 2025 02:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761530885; cv=fail; b=ntAsRMYlUiDJybDwg8C1PzqXaM251+lq5QzKG0ebAg+P8Q/vzlRoU29GgvObPI4RNoFSTMQVG8mVOTg2DnZGYzZ6m/OOaRDX2GK4U+PuOWoyNvc1Vol3HEgIFqWBTw+K+HukRExCMYuWJaehNzbF+1S6HsTkovH0qkNWv4s233g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761530885; c=relaxed/simple;
	bh=wY0XI+Z38BYyZykRiudAYbPnbZNOY/ugQYfMdCbGVX8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JonpGG9aeOboAzfJElMnQqbREVkhTgWDgfaT0aiX8SzYrMQ47QUzlruAxpR5Z3jUJK5Sj+ryY1K6b63BJGN7fQBnJ4TOIKJKef7OlW2zVabwtWeJkB8DqubfIs7IQQ7SUUWa3DsZuW2F/tirrLpthAQzRvtUNCcEextfjM3ZlXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GkhKdOQr; arc=fail smtp.client-ip=52.101.83.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O43kyEZiPvHJWTKlU7aVepNk0+Jfc+7Td3qD3Pd104ux1MPh2yiR/tadLm57DRjYgs0x50RpTX9rm9V9K4LZ3xJflmSVbdiFKKuwsYByqScVPE6KgV20NFLeXb59NBhUN9+Ra/ts7doQJDy0DRLuS1PDqSnt5UP0TsM50EDk2jzH+IaDhNl61HBYACn2xbyYA5FQr3moz4BPJbqy8deKb9KfFADIRXMIAoLD5t2qgkrgbIsi3BAq1H3MlH3Wqwk9l/UPrQbU94zXdQjSGsDLmmZo+sx7H1a1ALQKrnDeGKEVm/3R+xT/VTEcF+L8hpF0h4whgYy6ilPNZNpbfluzNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b57bZXj/GyURIOfRZ4ia8Kit9arCLkn2Jy63fGN82mw=;
 b=NLC3NQKf7/JYltKY44XzeGjsb6oo6sj6sL06nZTzwYxxBwr3j3BWuatGA7Alw/vdrz6ajQYveLzrU2uwnrnTR02r8sAE2+Yy052pGHnqhfYEq4ABMraTsBIBNti0TvIx4edMqV1v/hmdoIeHFhf2pF8hxKKTmIpZSQvNspxNDGKEt2h6aDKABFasKFNW3SnuUynl1liNPmKS/I8zWleRHTHP/BDqcEbfz+kgAa4ZHVt91Hc2XtRHiMvR4RCtV+210jw+cz1L6BVT/JtbtI2ph9gFnLYLJmr16EaR9PlheZdQJuSOoBoib8fGua2E8e/PCmDp8oBCVx4ke5QPfdri6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b57bZXj/GyURIOfRZ4ia8Kit9arCLkn2Jy63fGN82mw=;
 b=GkhKdOQr/UfwGT6B9oWi+oDTcisBcOIYIYNv9h8XkWZQDoURscyWdUw1MRopZVGAeLKUSUTMyFKHwntZwE1hI1XEQz2AHV0egL7wlAlhP27VFvOwmqXj2IoR054xwI8OVAxNsONpDKOtYa5iapi48yooEyZJOdD9AEZcw6nfOx7dq2hdr/z3JrX2Jr/Wt6inaLmPUS4pED7oTdqQPQbkCWnD8Da1zS2IlYcAKzLkVxbMTD/CklG7qO88+xslchTJAS/EWGMVg+bePMzxVBWblEz8S8UdGuFvVVr91hKpaGd0WtsfRAVXcOxYHqKwzsZBVBfzeTPEMDe2RN1UMrmdXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB8942.eurprd04.prod.outlook.com (2603:10a6:102:20d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 02:08:02 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 02:08:02 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	Frank.Li@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v3 net-next 6/6] net: enetc: add standalone ENETC support for i.MX94
Date: Mon, 27 Oct 2025 09:45:03 +0800
Message-Id: <20251027014503.176237-7-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251027014503.176237-1-wei.fang@nxp.com>
References: <20251027014503.176237-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:4:197::15) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PAXPR04MB8942:EE_
X-MS-Office365-Filtering-Correlation-Id: 36c088fb-ea4b-48ad-bcb4-08de14fda869
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/33T1AedSgTJdGTu1sydIHDtnIzfdrOYR92QlI4JYoMm5DmLj13lNdRnPX4S?=
 =?us-ascii?Q?ysYQE0eHbHDA24kQX6wtZEr4BiCBtncj57p+V7mLl2XMxqWU6Lw1ozPBWEXm?=
 =?us-ascii?Q?dxLi1nAE33R8Xd0hPxdSnuN9Kv4MnFP7mKNwMrJtAjjpeUe3AyHLfegzdAvl?=
 =?us-ascii?Q?21R/e0ChEEGShDaYi4lFCR7KXFXEm7cNd79sP/eFKZXOv1pe6gK676qhFHQo?=
 =?us-ascii?Q?LXo9dRIpT/WYmSVCAznNuvQy1ou8K3DTdZXsYoZrW/7P6Dqq82Y3HtPCe5yf?=
 =?us-ascii?Q?2iciz5sSgTaEXc9TR+JhgPI0KKKLhnTEiq6C7ybycQzOZONGpNDRktIiQekh?=
 =?us-ascii?Q?FMfi1uQ1Zem4pd9o9GrPX6VaMsnat8tz9PKP/KVt8xnmNKXumUY0OuaNZYHF?=
 =?us-ascii?Q?QgDnx0KPI3JN7KSHtwm9kRmdpzj0RB7jywMTfrkekFpOpYSC6buZ9qydUaDo?=
 =?us-ascii?Q?YILESC+2u4kafar4RDSBdthvRlGk0p7+TrYQRlzlPkzB6wOQb9+Xtzkv70FH?=
 =?us-ascii?Q?XiUbl3oYhDGZLH429niTtBsF1kYBYlZiprQ37nVctk1GNr2MJkyzE1eRLCyz?=
 =?us-ascii?Q?RSLXy7RP4wkOo/iekbITljCDsJntF2mIy/x6wBVJtSmS6s7kF5Bo0Kjtiuox?=
 =?us-ascii?Q?a7mtsE/NUxsBCi1+PoHcznRpWeQanrbC4FmWtPwHnkFW0NIGhdCub5ig+n/T?=
 =?us-ascii?Q?CZc6kRU7eMMrpSGsQ03kzBfst5Nnm3stZVE6KViXxi1+FtSq6NO5XR5B1YVA?=
 =?us-ascii?Q?eWxea/a/UWL23JtYVC1+ILdxk50ofcVribUwskHdgO9Q3QgZUB8I01Py3ruf?=
 =?us-ascii?Q?7D8nZfj3qENPYRbGpRhdWihXWW2WBs0LxWdSEkeTGHwYFBYQ79PoiuCYvR/z?=
 =?us-ascii?Q?P575TCRJEtXUMRs13Sh91yEW20BC78v/f8XbXS/CQqU3Et0G7DFZAoRJxxjq?=
 =?us-ascii?Q?W2gKi/oAPiy2JcYg8UGmHrm+fZ6LyRVf/XS1tRSCS1Fz/t2i4KHAFRwtnpXW?=
 =?us-ascii?Q?AKqffaBfY7pnGC76btyP4ibnW5hg3DwuoI1QP71h2NzQizMAY2UY3IrMKrb2?=
 =?us-ascii?Q?hkAxImzzUju3WmjnZbtq45O9R7v6YvcSEj6n6ebKQ8S1oK++0+tsAHWYGG/+?=
 =?us-ascii?Q?iF+32/lrpJtQ1EXYbkQvNPokrtkxW4pHd3ExF5NWgUX/uz+fptV3L5C8w1Sr?=
 =?us-ascii?Q?qB5Ol22tCj7pRMvvdSQLzgvbiYKBPySJqrWbdcNnIMOS0f51J6kb/XCZrMTI?=
 =?us-ascii?Q?Jpnx1j3ls94pWOeGUSsXCL8GpKxpvSsf829JMTb+9Ikrf5anQxXIYB7S+E5K?=
 =?us-ascii?Q?Wz4ubJ9LmihWIVdzSkw+DTefhJkdZL0iL2HqHqp58zG3ZEeL5evTp9bmrn40?=
 =?us-ascii?Q?GiTYMgWdoqRP0V68eLhripP/++lLQpkzCAFeUXxSsCzjooOPL44iu+TBK2u3?=
 =?us-ascii?Q?kMPbI5cS1pnzXiuQzO/rDVwkyyJLiQfsbSzXJ2kL8tonhB6YRvOlOBssA8g7?=
 =?us-ascii?Q?0ZaH7ny0l/4b7O5W97+6fi9xh8pAMRRD4Z6C+OWWTCCf2ZrIntbYWPAg3A?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6DZ4SwxTjqJDyoKFChzUJ/OGpW9GwZ4EZ2OttENOH9qX1HAPSL7Dz2hx2U+8?=
 =?us-ascii?Q?mdFVG3QHf814rfScO2oNmdVnQ/uXhm7zHMuAvA4rue/rt1SJna/mF5qrsOaT?=
 =?us-ascii?Q?QRjPXjVDqeXp+XcI8rN1FWsUX6IwCbu46AJNgIV9KdNGA+4/pl7O5F7LYSoA?=
 =?us-ascii?Q?bKLG9gIJN2WmTF81A0jOvJViQzAG255GGEOxCLBaFW4fcrK6ZbGgB/q3aM+N?=
 =?us-ascii?Q?JOuQ7fzWwN6pxGSVxy3Ri3fh8HAaafyAp3LP5orDoIsIn45PGHLm2ajMFnRQ?=
 =?us-ascii?Q?Ag1XmZI+dgc7DORvn/XJeNw+ra9L0qMQQa66XDuavExuYSoUsTVGeTLzXKot?=
 =?us-ascii?Q?yhWbyU0EzS+tlOmPjlTWKoXacYeX9NJh0wKpi8QFCxVRYRedRrMxoyBd29yf?=
 =?us-ascii?Q?hTSdjwjq0sCmbK2cEIGkev3hqNksV7xfDhMNlB/x1hNYf+bAOBkFR+wBgZ1q?=
 =?us-ascii?Q?PIIzvZ4146qusd3uWfWgI6uT7Q2huupV2cpoNICj9LDTLZ37Lo54PmPkChrS?=
 =?us-ascii?Q?0Z+1P4PL/rpeE934j/ztFCkGAk35sqlKhDVaediK56Wr37LAkEwOGxTaStpe?=
 =?us-ascii?Q?b/ed9S7Q4FkKSbsL0eNgaGGr2sM/cNlx9SaW/aAsiFVSOCiwKxcQBFISFiv0?=
 =?us-ascii?Q?N1fE2+/cH65oxoBlRWu9Phsr/LGQxFz9iPQ1TddJwjngkuraGBNTYYjHgReD?=
 =?us-ascii?Q?aBzpn3WcE7sWNh7ttA2J5rTpTlyjAVhUfcuZ2LFK7D2HTrdvB69cy46cusre?=
 =?us-ascii?Q?Dt13PhJ0hMGxiwNbFRNf+bVS4AmPSUWkzbGHwX9eaqDP2xW84bp9PI+g6IO9?=
 =?us-ascii?Q?iKyNHUCOS/+q6mjQiVm0n/o/POpeI/iJyDO9rbtR6hHbuVZk38nKyv5TDUvF?=
 =?us-ascii?Q?BnNoSRMaQyZaecH0WCz6orNHYDSezkZ8v9D/CEElwcbaXFLMAlUhBNMQxB7q?=
 =?us-ascii?Q?TaNMOy9fs5SiYvMVvpfV791slpw+TA0j2U0Gb4Li5nVhIN1hMC9irx6uV88Z?=
 =?us-ascii?Q?32Wqh/3kYYELCR8VQ/0jomvXB498uEdiU1iPapGixTzZG7VioyneuSqS5LzP?=
 =?us-ascii?Q?Azz8DzO/u6KVjiPZr82QDOKAmQXbyD5BPbUhG5Yz+aZMCUJH0DGvYKpFbBlD?=
 =?us-ascii?Q?m1gitSXjzNXaDyJkdyeSzQLiwBSCSbZwQQ/rWf66yjaGxOl6AaliyPbHcslF?=
 =?us-ascii?Q?W1xFU5+tlM4PhpupDWS2FQXODcNBVq4Aai8hk/xVUWHzQ63CGn62O93K4Du5?=
 =?us-ascii?Q?Ho9lzj3A11qInCY/7xyJT3c7Yfkh8Fim2ZiWbtOqS5/uSCZjFZf+33LQ6wbx?=
 =?us-ascii?Q?B+qY9LlJv4feBHzeby66rDavQbf9vctVG6LJ2mUp2taDotL3q+EWET1vMl4e?=
 =?us-ascii?Q?N28RmVh6ZpMA9dc6L0THzZra4PzKi31OZe4ylYeO9MZuipm6cofcAZIcJ8aR?=
 =?us-ascii?Q?U77lchE4h+4x3mCk+mHi+/+bN6Otmsjjjdeav51olU06tv17YWz2nKI+Je1C?=
 =?us-ascii?Q?MBbWUxMuw0JcFmScQSgsbCLKuKbYKkdY59p+VWDsUPU1wntnqh387n+5kpcy?=
 =?us-ascii?Q?PFK/SfQwWA0K2qKsnsWnkqS+1wAV1BDW9dYDQBTo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36c088fb-ea4b-48ad-bcb4-08de14fda869
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 02:08:01.9915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hALqH3Se5esIN7JXM5P0Wgdp37AlwcXzLBK8nn2E4WYHpTcFjEm9g3Wr3btWdOG1+DzbjzgK0k5SjZikLItCBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8942

The revision of i.MX94 ENETC is changed to v4.3, so add this revision to
enetc_info to support i.MX94 ENETC. And add PTP suspport for i.MX94.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c         | 4 ++++
 drivers/net/ethernet/freescale/enetc/enetc_ethtool.c | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 88eeb0f51d41..15783f56dd39 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -3732,6 +3732,10 @@ static const struct enetc_platform_info enetc_info[] = {
 	  .dev_id = NXP_ENETC_PPM_DEV_ID,
 	  .data = &enetc4_ppm_data,
 	},
+	{ .revision = ENETC_REV_4_3,
+	  .dev_id = NXP_ENETC_PF_DEV_ID,
+	  .data = &enetc4_pf_data,
+	},
 };
 
 int enetc_get_driver_data(struct enetc_si *si)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index 5ef2c5f3ff8f..3e222321b937 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -936,6 +936,9 @@ static int enetc_get_phc_index_by_pdev(struct enetc_si *si)
 	case ENETC_REV_4_1:
 		devfn = PCI_DEVFN(24, 0);
 		break;
+	case ENETC_REV_4_3:
+		devfn = PCI_DEVFN(0, 1);
+		break;
 	default:
 		return -1;
 	}
-- 
2.34.1


