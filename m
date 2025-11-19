Return-Path: <netdev+bounces-239930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C15C6E16C
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 11:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9AFB84EE6F0
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 10:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222CF34E764;
	Wed, 19 Nov 2025 10:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jozRnVoP"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010035.outbound.protection.outlook.com [52.101.84.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C6E34DCC8;
	Wed, 19 Nov 2025 10:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763549346; cv=fail; b=r+lRWKsIJG0QaYN13/4Tr+xX/voFYsh+kfNvt5PFtmYMkt1VDRDXETbgoLrkcwFw7hr+OALOmyqj7v2D1df05uCjVBZekG9e9q7BZO7pIxgZpjP+Qf3WUDhi7ySvkd5e4g0e2Rs6SzlK9opJI1XNmiFeBc4UvCI31BeoIJq3JFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763549346; c=relaxed/simple;
	bh=PMs/xmtapr29yv31vvLAIgTlIQytmQEWyHpOXFfCLNg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MZAR9iFqyp05VCqjtzmBcxAolwOsShu098/UTboPrApwIIAy+fbPYuAEZ4iNsbSNi6nBA9XdOzYhjwcLtJh+6ubiY96emSD30v0ISk0++6i5TueFQHbY90b02Ikd7bkVrX1U2vKPgTYYNAMaQBzag3bNqVuFbFfmWZ84LHQrdyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jozRnVoP; arc=fail smtp.client-ip=52.101.84.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nb/H7enPX3gs5zObj2VFDPyKWOOKSMSY6AGbfT2kvWZiaWYEIdsDFNGx/gjoOKp/Fs98ghJCYIyUHBjL/15MnipZDoNuNqYwdRFVwBlwnJHEmSMSwR123oSlllua2r8OkpMiJGN7huDf3ZKIqpagcc927TI5PCYerO96dQ9xjjv4Zk9CX4phqj0eS639QSZ4l43zaOVXzHOk0iLCG5xFtSwljaGWmr0LakZjZR2SXRf9bd61HYD0i/fxJQFj6CwuRnWI2wIpJTSdNOfHkjtT8ovv/BmUAchwe4zcVNqUK3vDMywi3jOXYD5vK7Knvx6rtrHIeg8cNptBssyU5KiVnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wh1ugBt8Nkt4TSeliMD6m/ioEoY2ZTis6gDExb45f7k=;
 b=xobf1uQC7WaSbNZcnpJ9zVLsEEbsnb80fDX5B80St3Ubp/jY5nDxjgTdS98a25lQf1DwSKfJVUfs8P/7A/ytxiIBwVMdDXb8vILtfpPnWZqReP7iiGlkyF3YWwelw3Ff8VOyVIFRgJjNQ10k1+RZQw4BSXQNEfSR/iAeEhols0G9x0aVLx2EAiwHoGg0fx/qWCypgEeP5AKNMg1d4Yxz8Op88YD/bmlWHEHitCwNd+Q2uvauYHMKuG2TEJQjBetRG1rmdxB9arG7+B01G/qNeYQ/KwCf+FjLdWpXnAUJFvlbvwJfT6RP3fcr+BUFWz6EnpbdGtScLUS16v2DThokcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wh1ugBt8Nkt4TSeliMD6m/ioEoY2ZTis6gDExb45f7k=;
 b=jozRnVoPYu9CWbBAi04QbsGhX89GuzPw8vSe4HWuFK+l3FrJYuqrV6BIy9uhl5V4IE2r0nat2O7LBowyTAG8vtKkZ3JTnfz1zQ+JUdg2w/jWL6hFadoenfPm6gMJKjuH5kdWXXn5bFkColHL9b6eu8tLxVpnX1uMDiO2GLv2Xzdrw7/9HB8gLd6CElPnsl+J3am0rYxOrcSbMIBb40gnVbisBA/eGXOBTq/ybeO2JMyV/VI8OWS80eeshIfCV2Shk+R+TCUu3SlcT5hv7+1iTJhTQW9dCSezXcGvvo5K8Txu0r/Xu81Z/AcE/25CcZdIfIwwiH8zYA3+kvdqfN2WUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB10628.eurprd04.prod.outlook.com (2603:10a6:102:490::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 10:49:02 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 10:49:02 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: aziz.sellami@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 net-next 3/3] net: enetc: update the base address of port MDIO registers for ENETC v4
Date: Wed, 19 Nov 2025 18:25:57 +0800
Message-Id: <20251119102557.1041881-4-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251119102557.1041881-1-wei.fang@nxp.com>
References: <20251119102557.1041881-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0210.apcprd06.prod.outlook.com
 (2603:1096:4:68::18) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA1PR04MB10628:EE_
X-MS-Office365-Filtering-Correlation-Id: 899f69b9-9934-4a0d-9cd2-08de275940b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h4v/j2t6zrG4roYNnW7mV54kVNcPqIjBN7oSkWJuNFxzW7/x1+jWuHeKowCs?=
 =?us-ascii?Q?WKMzrl4Bu7O+SiBbRbww25RFiSA2p/ejvsFtsuyKbNO1NEwyY4EhD3HN9LrQ?=
 =?us-ascii?Q?YTsgptgq8veMY4mtX29I99WV61QYufl3VL/2q6VECEoQA3dWx9E+HC6PPl7B?=
 =?us-ascii?Q?h0pDbrD95KdmzOrB5/LbPb8wXD7Vw8bEa3JxAsf3o9UEM29EadC446CkM3yA?=
 =?us-ascii?Q?kDmStcf65rUIC2fOfHacTjmX6Eg+YLeIj6Qnw8oyGVsALDQ/7qtXy77Y1prM?=
 =?us-ascii?Q?r1KKq0gzeq39M1hoTUFpN67xzg3iXotO+x4bSl2iuAUYONnnO+GTiEiNoNv2?=
 =?us-ascii?Q?IRiNPY0jKwoVpXQJsclFSzLk4/dV/cG2xmxwvEeMnfi0uMAJGAAbNLlmcSo4?=
 =?us-ascii?Q?TZQwbMQqlE1GaVVcBswJR7WvcnJ2h5FGO7c++BinA4WbL52+pjWWt65He1i0?=
 =?us-ascii?Q?wYTpn2N2+IEm33Kbz+330lvjxSWvXNRALpA61mEBnwfyxR22Ooo/htjLtfFE?=
 =?us-ascii?Q?WB8IGdtWHZiw8W5TjToe2RIH7Jz+Q3LfXZ5TUb+o/71Pzq0z+fKR1+brPw4P?=
 =?us-ascii?Q?r6t3EhsmkhpGEsHKhS3lwZ327JNgmP709qCLRb/6r4+9DXzBvCNXVdNSGC3A?=
 =?us-ascii?Q?MdcXWgvzI5uQslTVInkBPMAV+nISoukKpShll25HZVlhdzTm5EuaxNOlRJcm?=
 =?us-ascii?Q?bBbbTNPVNAkmB/nZA6jbP9XflpcYLjdfzXAyxpIZp3RDFFFHo1NP/XlZppxJ?=
 =?us-ascii?Q?LeEpW0vCaTJgpZBEiGvk6SQP+rJg5MtDsI5rBVURb9SFlE4Jt2TJQCtl0U/x?=
 =?us-ascii?Q?nk8LLDd8g/FjEQQA6YIbCSyMxuHO/q90mih+u89Rtg8ID+bff4GYWNhF4/Wy?=
 =?us-ascii?Q?/Ay5l1kl2EZY+NbNGoAZKGAjo/L+cd8pEaGcJNQOoWgwDPVquyMwV6Fbz4Mn?=
 =?us-ascii?Q?kVsgEyY4kM7hwIrsy4J2okO0F4StGCeD3/7CUg+E0pZPwQx3Bw+E0s8XxKpM?=
 =?us-ascii?Q?73EUp8HkX6wvViOc+pqgbidRGVeyQUDzzJzsKbw5599VE+mrKqaujJYoRY6v?=
 =?us-ascii?Q?ZkDcW70qTSGq7CKdiyg7qoV8LRgZ58dyDR0CpCVAX3hqOoPGVVYjOnVgdtD2?=
 =?us-ascii?Q?0MzAb68bg5pb7YvH51tbGivUld1zkTTI3/hTByqI++bAkY4xMBkqCfPDduWm?=
 =?us-ascii?Q?YWORQxnpKPKrWxDNcFY7IRr6V7nmusz5initKXn1lOELZXN0a9ZJvjn5j4Ax?=
 =?us-ascii?Q?4CTACtVDXsAl00IEbuQaRrJSkUcmcn1w3cQW83yEb+HLEJHcnGCF2RUi7cce?=
 =?us-ascii?Q?V7033ERWsberoS/CC8PITg1f2QPbLlCmE8TNwkapfuwUoO42fbvEgJfrhOaK?=
 =?us-ascii?Q?Sjk8wAjd1ajtmJzqUyvTU+vpsaxBwnB4YWLPjMONQh9Q1UpaKb2ix1DmcBBG?=
 =?us-ascii?Q?xbO8s39DZ0P4QJQuwEAEUE2EZ3BhkKkOQUqBjLztHY39pDbiEe7xHng2HZVY?=
 =?us-ascii?Q?08yJ7tP78/opNAs4wpmoyWsL00RL5px9gk1H?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?euV1HwdykL9pNQwqueKLLA73edKM1xNdhl2I0k4d95aXC02bLmzzQS/Ve5Wd?=
 =?us-ascii?Q?hH13Xif/Q7GoICdgzzIk+8Kzy0d48OSJtF/2xuG+ErCPwX/pMN8UAbvhpm2f?=
 =?us-ascii?Q?O2E8l0/5q1vCOZ4MnMlo2zOECXL+qIHxPSA53l0JFzOqpiACTt3L+eJn9jLN?=
 =?us-ascii?Q?QXPoEDiqGiWnrvLOzrlnksfspzT1wPRYL1PzK49i/hIu7QML9hAuiw526KuY?=
 =?us-ascii?Q?snMJpZawGP6lLb+LbM43SwXyOQYRd1cGEQuAJAfkBroBhk8U/W2s+YkBfbCQ?=
 =?us-ascii?Q?7OuO9c79tbkXKhC4am0tCab9LNmpjSARui8yq1/aT59mKm72KZJoofDhUVc6?=
 =?us-ascii?Q?Yeh2uTvlg7T124mR/RUIg1dQ/QwHdodIMty60Zn2sQi2yV6vdKJEVZQfjwt7?=
 =?us-ascii?Q?YFgR3QohCvjAmOHgzA4UNT7516euI+pVGQbcQNOM2xlqSnPrD+csPUzla3k5?=
 =?us-ascii?Q?Wmw4zwpZXrYOr9ifdkV6iN3/rrJ81p+u11z0Qg642Pm8ZvEa20q13YCGkJc8?=
 =?us-ascii?Q?HqqtjhVU9Ioxa9hGGWr08jk38kPk4gfUl6h80GlZEdbIGSX4f8Z/jdTPP/zL?=
 =?us-ascii?Q?69IeydUBZE7+WakWkTui7GoTXH6r4ZBhhlb9Jh4dTkd5EfUwESHes8Q388VX?=
 =?us-ascii?Q?mAnpiJyqWttae048XMljbynakDri3vuMchFJf2IjTOucgxwy7YuB8tdKJ56M?=
 =?us-ascii?Q?n1RmJ1NzCOtuCgfjhcew11P+Xsaym/eeJO2z66u52OoCJ0WVsYY4N61fvdbS?=
 =?us-ascii?Q?c351CDHM7i4TYjreu20NwQF/Wi9ACvqmthwi4UmcGdSCaplWEtBGg/vrvWPd?=
 =?us-ascii?Q?3Of4ztJ4nQL/1W3IT7R44l1+4Ic4aI69v5g1WhHMfg0PWqsd8N/XKvX8wqnf?=
 =?us-ascii?Q?FaKMbh+yClZIYwWX3d0cAWaveT6t8+bbl7jFQOGrkaUCKtrzsghCKrw8ogxD?=
 =?us-ascii?Q?jJeF7ZFBJJtkM5utx36n8hLyGcWWG6bDyAn1d2qOUnTAN/V3by1MHWv/f0hc?=
 =?us-ascii?Q?GxWQAm7VzmqfCUNqch2NGAQ20rGL7ygSlBbnY73xgf2EdD3202JADAOieQiG?=
 =?us-ascii?Q?tUDSwJcVBYO+E9BSiozn8RsomSl6oisrhgB8zmb3v2TEsVqxzAcf1mV/4Q/1?=
 =?us-ascii?Q?0wDlFiYLMgrfxLuh92po2FTNjPbVmm+4fq0GxMpSXQJ/YKVodVkLK9lwk/SX?=
 =?us-ascii?Q?24tFvoU6U9aIHKxu3cDRruOembkYb0ArLK4ZLmYJugL0Z69zVkqKoVKgdK+I?=
 =?us-ascii?Q?0IavH8AYVIoOadpNIzOqCLF+CE2JJFxQzT3qYd0V9NZ0pnEO/X7FJXrCWV8A?=
 =?us-ascii?Q?lrJXyItvN3YKiP73hnjRdoTI8Ibldoi+j3d6yAoAr0Zr0szJuDKuTWxz6+NI?=
 =?us-ascii?Q?aOlW9xB1TFlfAGov0Ux11q4pfryI5jpSm53WNUZYvByHW4RdrCd0r3cCvNZL?=
 =?us-ascii?Q?W+NoJRhaSp8Wffijz5IPlU+Z+/cM29zevDfaz4L3O4HV19ouER9L9lv5nX04?=
 =?us-ascii?Q?gDUgaHqj4RcCcIfmlan2ks/roU8kLUDbh9j5XWhVPT1UyZEbgJq3XwynYLMD?=
 =?us-ascii?Q?pg/7GN+DDScU9X36J3o8iKjqniCElZ7pRqyA9dAZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 899f69b9-9934-4a0d-9cd2-08de275940b4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 10:49:02.7080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mf62QpKNeNXvzl4R+Ux+7ak0IJLZ47e3tGLn8LnOLPfChjARlUSpRQy91vDe/5+V5uERtXtP+f663lP3SduTVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10628

Each ENETC has a set of external MDIO registers to access its external
PHY based on its port EMDIO bus, these registers are used for MDIO bus
access, such as setting the PHY address, PHY register address and value,
read or write operations, C22 or C45 format, etc. The base address of
this set of registers has been modified in ENETC v4 and is different
from that in ENETC v1. So the base address needs to be updated so that
ENETC v4 can use port MDIO to manage its own external PHY.

Additionally, if ENETC has the PCS layer, it also has a set of internal
MDIO registers for managing its on-die PHY (PCS/Serdes). The base address
of this set of registers is also different from that of ENETC v1, so the
base address also needs to be updated so that ENETC v4 can support the
management of on-die PHY through the internal MDIO bus.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc4_hw.h   |  6 ++++++
 .../net/ethernet/freescale/enetc/enetc_pf_common.c | 14 ++++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
index ebea4298791c..3ed0f7a02767 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
@@ -170,6 +170,9 @@
 /* Port MAC 0/1 Maximum Frame Length Register */
 #define ENETC4_PM_MAXFRM(mac)		(0x5014 + (mac) * 0x400)
 
+/* Port internal MDIO base address, use to access PCS */
+#define ENETC4_PM_IMDIO_BASE		0x5030
+
 /* Port MAC 0/1 Pause Quanta Register */
 #define ENETC4_PM_PAUSE_QUANTA(mac)	(0x5054 + (mac) * 0x400)
 
@@ -198,6 +201,9 @@
 #define   SSP_1G			2
 #define  PM_IF_MODE_ENA			BIT(15)
 
+/* Port external MDIO Base address, use to access off-chip PHY */
+#define ENETC4_EMDIO_BASE		0x5c00
+
 /**********************ENETC Pseudo MAC port registers************************/
 /* Port pseudo MAC receive octets counter (64-bit) */
 #define ENETC4_PPMROCR			0x5080
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 9c634205e2a7..76263b8566bb 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -176,7 +176,12 @@ static int enetc_mdio_probe(struct enetc_pf *pf, struct device_node *np)
 	bus->parent = dev;
 	mdio_priv = bus->priv;
 	mdio_priv->hw = &pf->si->hw;
-	mdio_priv->mdio_base = ENETC_EMDIO_BASE;
+
+	if (is_enetc_rev1(pf->si))
+		mdio_priv->mdio_base = ENETC_EMDIO_BASE;
+	else
+		mdio_priv->mdio_base = ENETC4_EMDIO_BASE;
+
 	snprintf(bus->id, MII_BUS_ID_SIZE, "%s", dev_name(dev));
 
 	err = of_mdiobus_register(bus, np);
@@ -221,7 +226,12 @@ static int enetc_imdio_create(struct enetc_pf *pf)
 	bus->phy_mask = ~0;
 	mdio_priv = bus->priv;
 	mdio_priv->hw = &pf->si->hw;
-	mdio_priv->mdio_base = ENETC_PM_IMDIO_BASE;
+
+	if (is_enetc_rev1(pf->si))
+		mdio_priv->mdio_base = ENETC_PM_IMDIO_BASE;
+	else
+		mdio_priv->mdio_base = ENETC4_PM_IMDIO_BASE;
+
 	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-imdio", dev_name(dev));
 
 	err = mdiobus_register(bus);
-- 
2.34.1


