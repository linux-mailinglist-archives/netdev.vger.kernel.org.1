Return-Path: <netdev+bounces-189729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B281AB35D9
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 13:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83CCA179309
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 11:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F1F291874;
	Mon, 12 May 2025 11:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RsgGhw0q"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011053.outbound.protection.outlook.com [52.101.70.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26DA25C802;
	Mon, 12 May 2025 11:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747049063; cv=fail; b=ULu1a72jF47J9dBlPyzKr1UGBlp+zH6yBLcOOQSQHqjuMrh5FluzVEu6bjuEFRDr6WN9GQETBmcy5WizCU6Yx14YRkPHOrDVSvUocMNApQnqzBFoI8EW54J3b6jQJQ7DJZEoKtB9vF8KfsY2fri2HX0Jh9TXNh9PvKZ5tnrSPqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747049063; c=relaxed/simple;
	bh=UegbzHDupjx3YQnj9/y0NzlrMeTbOPOitg8FEnCrDr4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MXwbgVaD18KV0w6EV/xKc3ICvh2znzK95QaigNhcWEdCbGs59luFbbTmtvDJZ+T1wevwAPS/FPCOrmFD1wUwuPPJEBcVGgn9xiWFed3S0txxYlIevwU7GUfP7bjYiUDy7IK868AIWlOnpPF1RbGlGF4lkddvK3Upw1AeCAeTr/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RsgGhw0q; arc=fail smtp.client-ip=52.101.70.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bqxve1mVecPzOz4DgPgNdHe6BlG2mA9sKb67dVZBHlk3b1/4lwH59rmTNGa9AaLU2WYvJUnlnklcfzwNY+3Yh5bUPjMkgOzMWEnFx6xpbXzyHiDrzYUCCJoBxZdQSTNZVaNtCuRBXhPLPnT4bxhzom+2hjiFzTImC2sU79Lw4sCNo0hwWZIhB56X136fH/r3JMA1AdjscKM3ycfLs5uA3luuHcvSb2OOI1cT16MA7RPqoFDwBnDj5qYHfuNDLz0pVGykc8AnkI8/A8n2mMMpPNKr+agi4RTHe5Dl7gMLXJduoKEf57Z555McE3ZoEVXkhb+Qa6u7DWdKpDdyB6dRlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+No3rIZMROXw4b4s4G6To1dcq1q3BnnDNLG2qDx7aaQ=;
 b=IQTjcYCTjqeW6EcgHpXcx8P3hmucD6EiofD39tc3Fzj//dNFl6/fZUSoeOgBqMs9M+1uMHJGAtar5u34MCQ+GKazgZTbpHde43lfTQwNGz3WywoeAke+8Vt3uj5HokzgD1XkLcpS0wMsr8G0RIVuSxrrjYhSJWtVyklkmL8N6Qj8D9r/OgcZUtQR8S6z4VfnVnuVrjAXEB5Eo52SKyFaEsMfxOCvYNWEF9HttWfYNyILbfInAUdmXfVtQnmXThpIC7e4rKsM8GVsAj5osoauFVCrAUdvhcnq6eKUtuABZCYhH+yGJQCCLGmycj8u2oVqErxOdFZam9kWXT8tlnNsLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+No3rIZMROXw4b4s4G6To1dcq1q3BnnDNLG2qDx7aaQ=;
 b=RsgGhw0q1hcaPbsrMOxm1TRsGXtLBgA0FNP4XuNxiYDzZz484ECpsi+XfbQ4q35DIUVoCALPQ45Y8ZJpG8/xvErlGbmNOTQ+D1GNxYVRUZoMwT9wYCGwrKhFRWyjrQ9dUfIxH/Cwq/5qhlyfC9gMN6WbS+BGXg1gA+k/EywVxWtPE1/gzMr4hdoaMLAgFw+HxvsMnyE4k+f5gsbhtLMFnrTmKjL3aMpb5MoV8XUhgrdHzM9ElR1sQos3DFfcYE5Mwqwpzwia2LLi37tvdR5/IWrkK0Ri7hdQlHw9pLgun8v4MlKhNMH1Zzw9S60qm8RFNbuXzPB10AdEgvU5CH3YMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI0PR04MB10494.eurprd04.prod.outlook.com (2603:10a6:800:231::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.27; Mon, 12 May
 2025 11:24:17 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 11:24:17 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Simon Horman <horms@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net-next] net: enetc: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
Date: Mon, 12 May 2025 14:24:02 +0300
Message-ID: <20250512112402.4100618-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P190CA0037.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::12) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI0PR04MB10494:EE_
X-MS-Office365-Filtering-Correlation-Id: 254076dd-9c53-4845-acf5-08dd9147884c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w+z6TBFg5H25lAYYxws2fR4MRN9s1v4y181VaJnWfTrOznmwk40vHz7c7E1x?=
 =?us-ascii?Q?r4SyZsF4x3P24TFwe2UULzSRu1+cUFjHAxcWS/hOj2f/OKiW1cJPTjqZdgZL?=
 =?us-ascii?Q?pqk0km7Db6yR4ul6NpkzwCi/UQJgKG3WHP1bFevXiK1Af2yXi+l8VGx8n5EO?=
 =?us-ascii?Q?3F6RYyqvmJszy17PglfyEXEGj1U4h+37hc5kbOh6eZUa+PDkwJKq6tEsQHYA?=
 =?us-ascii?Q?0jNPPbRbUM6daBXMNpzNtEB8wB0vU5da8BFALU38b6qI5hQQFpjgju+2ueGZ?=
 =?us-ascii?Q?zEDCrn5kmSnQH6o/6kuqhgwrW4LGfVhfSEQz3IWplyIoQRU7P8pG6IX66h57?=
 =?us-ascii?Q?hQx6qg2dlOBn1aAQ630cV6nGFsBtw58iIk32mq1nJLhQFltojJgDFHUikYdK?=
 =?us-ascii?Q?9iFKyHbtdIVOjqrYjBJvmdfeB3myUf4XhugYit9bZzQePplL0rIMGfrKapWE?=
 =?us-ascii?Q?w/IV7MaU5Hs8HYa6T5mcF45CN3/+SHYAWMBk1iyPh/krb8nhEuTGAXB4QtyC?=
 =?us-ascii?Q?0AKzxXS6eLVf4CC3brfL11J9GDrCjVHzI0AUmUBkto0Y7TRRKCJ3rgfmTB8h?=
 =?us-ascii?Q?1wL5M1yKk6MNzhD7ez7HNeP+6pV4iNeyNeJq/7CkMaOxMRj8DI9/dEWgnZSR?=
 =?us-ascii?Q?0oPVuN9bAE1Qk3V4A6aZLpSDJ1Y6Xdl0EBBzoAAZ4JEb6sHtui26KR4x5Ao6?=
 =?us-ascii?Q?ujiZuKqd/BJ1CaJtsR/meaxwl+0czpuHGelpyfnqo128LSXkavlpGuRFUN/N?=
 =?us-ascii?Q?54pngSRHbkYvP4viI9swD3t97kxVZ+4B2KspC1SmWZIWfMDsHvcgyEkdP+FN?=
 =?us-ascii?Q?qZdLRryZHCIVcerP087tnBH5VetFVMQh1CZe3BSmOLHnrzRVbiFinlTIsLe0?=
 =?us-ascii?Q?waBwqfjJNbANn5hUUpEECea7Xy66VPkLtftR+Muno7Iz1yCBrLA/uCy253DQ?=
 =?us-ascii?Q?0bjlq8p3ymGjHBTbhAX2C1ClBLl4+VwGqaAW8YKIdOcCNzr5lHS6m6tGzE5r?=
 =?us-ascii?Q?/pyZQRc3Gd/cBl2/78Ia+Dxm/yEGDQ9AosT1q78HVTWvoZ5prjfoizLhy9YQ?=
 =?us-ascii?Q?lzW4fnxK1VlRyYepMDKUtAB0tKk7TvjTWGgaR6Hi2ssudfhSJCGL1h+xVCm8?=
 =?us-ascii?Q?NCRLRtySOD7UpbZkgpkTgl4YQusg39P7v9S7S19e3rrz0HRE/RPF7nmCHe9e?=
 =?us-ascii?Q?zHZdpe5ZbxdOcG+DPXh5Q/UAYyA++r3mEFhSqDaCGXPn55ckL/9k9bdrFE2m?=
 =?us-ascii?Q?VKiRQIkdu17WAqwhUlLZB6MOYICHkJlz4eKU8yAzrUt6LKuL/2VgJfEzWQdN?=
 =?us-ascii?Q?rEZLMIkfpphxr1w5oRaLUTx8Anl6dozf4GE2ibXfJ8675QToFxA8W8chsRgW?=
 =?us-ascii?Q?ZyKkru6qUP8dFps3rJ4+6AGNgClKbAou31iwVQo5MbDnSNVmtBT/h3JBGteM?=
 =?us-ascii?Q?IGaXA9Jk+NpGRY3Esio8ejhskpFHo+qHgdp7O/zNQc+hILyhmlR8ow=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IoJcAkNCPu1iu681B9y17jVhfXwFr8UsByg2IgTND4rTbWmWn8aqzcbaa7/z?=
 =?us-ascii?Q?2k41Qw21OZjR2kcrIGQUJ4uT5TCi37jXdKvFFFlaMvkY7vnNJbPIXSyx7i1h?=
 =?us-ascii?Q?BeHp5I17/OmabBuWbu7LTfNsJ25Zawqi3gvK92i97J6MwprGG52PHYd0GFQp?=
 =?us-ascii?Q?WancYv2+g/22AiQX+crw+COWXiKNtjojJJXsIdUgOAlFont9xIfufDBBwuLG?=
 =?us-ascii?Q?A6WIvDhq+vYxecGI95roen8gE/6wJxKCwciOUrL4vtlXReE0nXxhN+GYSdUq?=
 =?us-ascii?Q?Upr8jW/Od4zfyGh9QBR7x7nJvA1cOLo9bghlsyOSAg4tqkL2LALIsIR8hiE/?=
 =?us-ascii?Q?8igmm2RUXZRtSdt5iBO9AGohgd4iGkffV+RfzFvrKqYMCoak7+HeznwrmPo7?=
 =?us-ascii?Q?d/dyiKPSim7f3Jp8lwbDSpFvTgdmS+lSrhJS7j+7d5SvUka1TGnUwPqeI+ZC?=
 =?us-ascii?Q?uma0jzhHaid1xOey4it5FFylrhEKLGtZCctD8T9UXu+62TcJEMEYK/o++GvI?=
 =?us-ascii?Q?C4TQQRH8UkPOr223ncI2xPO5ApAE6FMBGj5a3jrsGF4hSIXeqMGNEjt+H7ge?=
 =?us-ascii?Q?t7uK8N2g4N0R8hCgxmpGPvc8WVgiU+Ia/frJs9eHzb1m/VPJzXG0gwLXt2zv?=
 =?us-ascii?Q?1T7DtM3gM0yaRx2VivtvUFvSjO5TWuZONeFGzL10LRTyglDIdSxk21xnUyHN?=
 =?us-ascii?Q?zjXYsUs7dPKQ4lZ1uCah5e2L7JPc11CcKRM7/dKb5YK0PZ/hIpD4pUZU42Vx?=
 =?us-ascii?Q?ZSUOI/ZaJav9WtcezdxK/Tb2JtVpRycs2VlAWI8VLRrEaYyRuWBbrQoSTv2C?=
 =?us-ascii?Q?tR48ACYfiJ9mjhicY9ZzPrqiZrJacI7grNDVB8rC1nnaqfyuHn+YaJVvxX96?=
 =?us-ascii?Q?IZ8StFOXoqmLpfdL/ASaBLS5vUkPJ4Jlv/VB2gWSbHdcE8OQW31ykpMVRxce?=
 =?us-ascii?Q?IDmOtPfygYUF6KLs4NTFUBGrExcRUQzUmwbq0bopkTvGb4tUEkDjz5W9jdSm?=
 =?us-ascii?Q?s1V0fT76KDhY+gFBhFbmZZ3bEkp/729XK0uIzY15U35STV37kMQHCLDmWIvA?=
 =?us-ascii?Q?eVHxrfjzaTAneK2Q8AiO/YRq3ua2YfVxY2nOPV0t8XePgXC3Qmbtj1NNY8Mm?=
 =?us-ascii?Q?O6dFcXpQ9w/KniWMYWDu9ut3+ioYIU3TVoMmEqExP3Q0Zt2oM+lDwSjkFWCi?=
 =?us-ascii?Q?+WdsDoas+ZOWWnnkGkESN1eqN5pmYvTYN0rjIb2qfL3CV/5IjQ9CwTqozyjf?=
 =?us-ascii?Q?Xngf5fWdpO4pfOFq5D0JiHa8PmBC2cy4BQUfaozmIXhhTG8rGPFtcsmbAUdG?=
 =?us-ascii?Q?LVZs2WHxQmWsH1OFe6/+gxI64jRp7QeHMgtTwXGaZpWsK1p6yaXDrW4J0p+r?=
 =?us-ascii?Q?XD1qLA1nazAMX9VRtou6ySd3fuPuiY6T5YI1d3r2vJdglCQ88JeC+koeMnk8?=
 =?us-ascii?Q?N3gq/4eKQ2DnXrpihYX9sshUXa2E9FACcCZe7rvvRBIls6DbBuk2SIs2LTq5?=
 =?us-ascii?Q?uoFjj7pl1VbvHWKx+mrR/LNAEEfMDf28FbTGHGMrz4xKzr9uwNeyKRnh5mFu?=
 =?us-ascii?Q?aekvL2Io7XRBULKXkUnizDG1hDjEg3pn+vBr04E1sS7+cDzoWCB0QwLbWDEU?=
 =?us-ascii?Q?bw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 254076dd-9c53-4845-acf5-08dd9147884c
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 11:24:17.3748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LozbUk3jNBh1OdSF44JYdQO71EpHkrh3qLe0QT1tt39mg/GG+11y8RCo3KQCzCHY+cxS9WpLCV3NHJ3PgYUM2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10494

New timestamping API was introduced in commit 66f7223039c0 ("net: add
NDOs for configuring hardware timestamping") from kernel v6.6. It is
time to convert the ENETC driver to the new API, so that the
ndo_eth_ioctl() path can be removed completely.

Move the enetc_hwtstamp_get() and enetc_hwtstamp_set() calls away from
enetc_ioctl() to dedicated net_device_ops for the LS1028A PF and VF
(NETC v4 does not yet implement enetc_ioctl()), adapt the prototypes and
export these symbols (enetc_ioctl() is also exported).

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2:
- remove shim definitions of enetc_hwtstamp_set() and
  enetc_hwtstamp_get(), replace them with "return -EOPNOTSUPP" if
  CONFIG_FSL_ENETC_PTP_CLOCK is not enabled.
- delete unnecessary config->flags = 0 assignment

 drivers/net/ethernet/freescale/enetc/enetc.c  | 47 +++++++++----------
 drivers/net/ethernet/freescale/enetc/enetc.h  |  6 +++
 .../net/ethernet/freescale/enetc/enetc_pf.c   |  2 +
 .../net/ethernet/freescale/enetc/enetc_vf.c   |  2 +
 4 files changed, 31 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 7e92dc0a9a49..dcc3fbac3481 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -3296,16 +3296,17 @@ void enetc_set_features(struct net_device *ndev, netdev_features_t features)
 }
 EXPORT_SYMBOL_GPL(enetc_set_features);
 
-static int enetc_hwtstamp_set(struct net_device *ndev, struct ifreq *ifr)
+int enetc_hwtstamp_set(struct net_device *ndev,
+		       struct kernel_hwtstamp_config *config,
+		       struct netlink_ext_ack *extack)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	int err, new_offloads = priv->active_offloads;
-	struct hwtstamp_config config;
 
-	if (copy_from_user(&config, ifr->ifr_data, sizeof(config)))
-		return -EFAULT;
+	if (!IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK))
+		return -EOPNOTSUPP;
 
-	switch (config.tx_type) {
+	switch (config->tx_type) {
 	case HWTSTAMP_TX_OFF:
 		new_offloads &= ~ENETC_F_TX_TSTAMP_MASK;
 		break;
@@ -3324,13 +3325,13 @@ static int enetc_hwtstamp_set(struct net_device *ndev, struct ifreq *ifr)
 		return -ERANGE;
 	}
 
-	switch (config.rx_filter) {
+	switch (config->rx_filter) {
 	case HWTSTAMP_FILTER_NONE:
 		new_offloads &= ~ENETC_F_RX_TSTAMP;
 		break;
 	default:
 		new_offloads |= ENETC_F_RX_TSTAMP;
-		config.rx_filter = HWTSTAMP_FILTER_ALL;
+		config->rx_filter = HWTSTAMP_FILTER_ALL;
 	}
 
 	if ((new_offloads ^ priv->active_offloads) & ENETC_F_RX_TSTAMP) {
@@ -3343,42 +3344,36 @@ static int enetc_hwtstamp_set(struct net_device *ndev, struct ifreq *ifr)
 
 	priv->active_offloads = new_offloads;
 
-	return copy_to_user(ifr->ifr_data, &config, sizeof(config)) ?
-	       -EFAULT : 0;
+	return 0;
 }
+EXPORT_SYMBOL_GPL(enetc_hwtstamp_set);
 
-static int enetc_hwtstamp_get(struct net_device *ndev, struct ifreq *ifr)
+int enetc_hwtstamp_get(struct net_device *ndev,
+		       struct kernel_hwtstamp_config *config)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
-	struct hwtstamp_config config;
 
-	config.flags = 0;
+	if (!IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK))
+		return -EOPNOTSUPP;
 
 	if (priv->active_offloads & ENETC_F_TX_ONESTEP_SYNC_TSTAMP)
-		config.tx_type = HWTSTAMP_TX_ONESTEP_SYNC;
+		config->tx_type = HWTSTAMP_TX_ONESTEP_SYNC;
 	else if (priv->active_offloads & ENETC_F_TX_TSTAMP)
-		config.tx_type = HWTSTAMP_TX_ON;
+		config->tx_type = HWTSTAMP_TX_ON;
 	else
-		config.tx_type = HWTSTAMP_TX_OFF;
+		config->tx_type = HWTSTAMP_TX_OFF;
 
-	config.rx_filter = (priv->active_offloads & ENETC_F_RX_TSTAMP) ?
-			    HWTSTAMP_FILTER_ALL : HWTSTAMP_FILTER_NONE;
+	config->rx_filter = (priv->active_offloads & ENETC_F_RX_TSTAMP) ?
+			     HWTSTAMP_FILTER_ALL : HWTSTAMP_FILTER_NONE;
 
-	return copy_to_user(ifr->ifr_data, &config, sizeof(config)) ?
-	       -EFAULT : 0;
+	return 0;
 }
+EXPORT_SYMBOL_GPL(enetc_hwtstamp_get);
 
 int enetc_ioctl(struct net_device *ndev, struct ifreq *rq, int cmd)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 
-	if (IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK)) {
-		if (cmd == SIOCSHWTSTAMP)
-			return enetc_hwtstamp_set(ndev, rq);
-		if (cmd == SIOCGHWTSTAMP)
-			return enetc_hwtstamp_get(ndev, rq);
-	}
-
 	if (!priv->phylink)
 		return -EOPNOTSUPP;
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 7b24f1a5969a..872d2cbd088b 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -518,6 +518,12 @@ int enetc_setup_bpf(struct net_device *ndev, struct netdev_bpf *bpf);
 int enetc_xdp_xmit(struct net_device *ndev, int num_frames,
 		   struct xdp_frame **frames, u32 flags);
 
+int enetc_hwtstamp_get(struct net_device *ndev,
+		       struct kernel_hwtstamp_config *config);
+int enetc_hwtstamp_set(struct net_device *ndev,
+		       struct kernel_hwtstamp_config *config,
+		       struct netlink_ext_ack *extack);
+
 /* ethtool */
 extern const struct ethtool_ops enetc_pf_ethtool_ops;
 extern const struct ethtool_ops enetc4_pf_ethtool_ops;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index 6560bdbff287..f63a29e2e031 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -631,6 +631,8 @@ static const struct net_device_ops enetc_ndev_ops = {
 	.ndo_setup_tc		= enetc_pf_setup_tc,
 	.ndo_bpf		= enetc_setup_bpf,
 	.ndo_xdp_xmit		= enetc_xdp_xmit,
+	.ndo_hwtstamp_get	= enetc_hwtstamp_get,
+	.ndo_hwtstamp_set	= enetc_hwtstamp_set,
 };
 
 static struct phylink_pcs *
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
index f6aed0a1ad1e..6c4b374bcb0e 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
@@ -121,6 +121,8 @@ static const struct net_device_ops enetc_ndev_ops = {
 	.ndo_set_features	= enetc_vf_set_features,
 	.ndo_eth_ioctl		= enetc_ioctl,
 	.ndo_setup_tc		= enetc_vf_setup_tc,
+	.ndo_hwtstamp_get	= enetc_hwtstamp_get,
+	.ndo_hwtstamp_set	= enetc_hwtstamp_set,
 };
 
 static void enetc_vf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
-- 
2.43.0


