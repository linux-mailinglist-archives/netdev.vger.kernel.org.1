Return-Path: <netdev+bounces-151595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A96449F02B2
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 03:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87B20188C57F
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 02:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082CF1632F1;
	Fri, 13 Dec 2024 02:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kxib8WH4"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2075.outbound.protection.outlook.com [40.107.20.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCFB84A2B;
	Fri, 13 Dec 2024 02:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734057230; cv=fail; b=oIGrCULp+JuSyTMNkadaJvuToYhS85G8VcUZh25mNROy4CbJdc9feyHpI3E0lLHxb6CEIU3dV0rkZl/rk2NYOaJyC13wiU/Kz85b/22EslISwWpv6Ha7qd9M7NH555JU7OSIwq62xZH/GCjlsJFxQZofZOzkCdGiSVxhVZIdTZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734057230; c=relaxed/simple;
	bh=CkodByBBagRtPFc+k2XsQBF8vpyHcxbbT8/Ga7p+yYE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H5pP4DYJ10I1yPg/fGp2qyqjXULM2RfF/d7Sq3bhb6LvU1Sit+QRjT9vcd+LV5xfD798H1838S3S1S2/Dee5UhTRbM8JeBojgoxix8gaNwNLjSojIVad+c3dUPv4cn3VwVC9ScR5HquRlcZ6R9zmwK4vLLAN8yElBHePPxtNLGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kxib8WH4; arc=fail smtp.client-ip=40.107.20.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YqywBd96wgW37iPkW18FmFaakQ/B5UJRLr50uL/rimzKgWv3dMpkaZjPTWIDI5K5KlEb79f2+f+LRZxrEuG9Jfp79KTmK6Xc+qbcZP9iL7tzI59NIrW3ge7wWyHGGaNWjg+ZtxWqH6PIIDhvDAVNNmERSVQnDfY5vpUf0xrRXsZhs9r00rOn15juvZgJpd6ttlzRHSRtAWwt2ZlfBPHxit47bn6Hl+ISvg3IyRGb01MTmwAIujtv/g2KHn/Gn8R7XkGuNo+zDFvobfO5VrOy4vITk7waUVvjox5P/T+9TbDmICX4Ki0Njukpjn9+Hqq9XEraZs06zI6woxgPxJ2owA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xkesW27yDubqW92IGckwU+80vzPqe2oD2O0gVTDejE=;
 b=X+rntA5KVc7iG61CzCViYz1UyO7EO8LB2kQqCofc5uR8CHDOEKyrgaxqA8qXz9Qy3OeLuV1a58b1OVAbWDdBT3sFCWZQt5wgvJ4hCy4mCaZLIZynvynP6jINpaipLEQMYStghf+cJsNM7fSRgZqev4ztgfXuP46fh5ltzJ1rjASZAUjW5f6S6k+JZkIgCftFKmbNdf/YjMMSksRXY3Z1ZMy+W+yDTJCLW9yxtQmkabTg23iIMMB1MY3H8QVFMNMNXeJQjiAazg0kHhkVfEn666HbcnzZgjugnbaWK6jyqhPWhgjahvH7RQ6iXibOU7eBCvsUYnG+ht2+Xdh6YwIdzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xkesW27yDubqW92IGckwU+80vzPqe2oD2O0gVTDejE=;
 b=kxib8WH4q38PXLgiuvsGb3U0FhszJVbZIdTo/EXtoB7/+EMTwo4f9rUElU/rZHhbM4ZWsuzKDVP+CGF79nOweKeWAeXI8smWA9OfgMjeFFqGyJZJfdKqSnFpQoFLfgjiqNKU02IK4jnnfi/y0+naGi+k2/jMD6XJAljQYTJ9ZgbuEmmp/S9iKzI+AwI3j3w2gVi+JyrFQUl5wg7WgW0K2O6/VYGZS3U6BnahepchtNPRTsFXLlrfn12mMydgqy7XHXjvLIy7jReehI87ShpcBn5zDPQEVTDE4bF5bkuBatKOebmL+fLfSMGg7RGpjP+5htQ+SSqfTqzX/w40uJ5s9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB8PR04MB7114.eurprd04.prod.outlook.com (2603:10a6:10:fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 02:33:46 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 02:33:46 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	frank.li@nxp.com,
	horms@kernel.org,
	idosch@idosch.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v8 net-next 4/4] net: enetc: add UDP segmentation offload support
Date: Fri, 13 Dec 2024 10:17:31 +0800
Message-Id: <20241213021731.1157535-5-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213021731.1157535-1-wei.fang@nxp.com>
References: <20241213021731.1157535-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0014.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::17) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DB8PR04MB7114:EE_
X-MS-Office365-Filtering-Correlation-Id: ab17f139-1752-43ef-eac5-08dd1b1e918f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NqqRSyL2ff7mhjLxueyGOoERiBkaxaKMbrwv6kt8B2cj6KeWkxMh6/FuuKkr?=
 =?us-ascii?Q?VkDDKgQzhDCqg26m9Mz7M6pH5dwjfuogrfXSF31b1LNzJvyxFTOzzoPuu4zS?=
 =?us-ascii?Q?I2rSo53bjlPjLp+5C8Ufn2PkV4BGpe1t0sg5IbvmkjKAQt8mJZN7Jr9yqEmB?=
 =?us-ascii?Q?TPySTEbpI6ZmAP2VtEgW+cDYXFrAllQTvdL4UYJss9pD4eU+nXD8D/DMaVuN?=
 =?us-ascii?Q?lfla28rW7e3xqMzAHYglHtKftdWfzBsAcqwTOo/LFEJPR9cjh9sxwdGXy83v?=
 =?us-ascii?Q?iw5JllKsvgVEwjCqP7Z2jcKw1fquAKPCAd96Bp5HaraKNGOM4p7wEj7uvxEu?=
 =?us-ascii?Q?Uw2/ojoYfn4sundphP7ohooBonVuxqktMpK7PpzIjaGbTpjpTEgIPZ6/BS1I?=
 =?us-ascii?Q?zJvDRgLMnC4P2DjulOE4/tgDtAOU9pRQanSt8MHtKVBDdEZgO4pPtIudXhBg?=
 =?us-ascii?Q?3tyRjEvKozOxC648Ab62QTuAIOD+25T3Su+66VXeSCDoIKaxgBiLEUW291i1?=
 =?us-ascii?Q?sPP8xYClmP+miOYFvKO7GF3pbU9yoOLX/UQnLZoS8tQDzEH5R4Zyo8uLxunJ?=
 =?us-ascii?Q?mqpf3iodDqW4LnoxdhVHJ5LJtH837SnxRsq4ud3KnEhRwtSuqC05SH0e9bwy?=
 =?us-ascii?Q?YzxhUgmucQg2BBerV6hYFDJ5vhd8MbFpRKfJ6B/CL150jLHDF+zOab8xUcZm?=
 =?us-ascii?Q?POYvTR2QAVfm7fXlTBaX6AEf/EKpMoqtCXoD9i/kHWQEqN/QdQxfCJD3Vkg/?=
 =?us-ascii?Q?nndAEMT6SMsSMhz0WbMrhtLMo0+EfDQ4g0ewQuTfBtxRDAIwG/dZtRap5sVG?=
 =?us-ascii?Q?zV8gAATsWiHnfwpfDwB9RnUZOAPBYiDOtXOfg/bWvLPqRSxjUcfQQGOAF3AY?=
 =?us-ascii?Q?9qCC7zFbq7fYyvUvwOK/orJdm8JcYplYDDP4C5EXfmjMB4jbNvkJB7h/Yq7F?=
 =?us-ascii?Q?80lum18UJfO2WnbOlYfQQkHDjh34ci6j8622KVbaIyp+3w38CBYfafedOnNy?=
 =?us-ascii?Q?wWLTPj26X0tprSFkmtoU8vT5qgQ6cVfFYwTJuHgCDsPuQh3yL/of2RvGMl76?=
 =?us-ascii?Q?GYH4w+INtOtb0AYVGvK3BJZSwxLhI131KMcF6+U/2UdPhDTBprmL9wRV0xJZ?=
 =?us-ascii?Q?VMx/hmO//iEdaSQA3SS6aseapui5W/SR+Y6TnP5q0NMbHFSx+NagG1pjaPmk?=
 =?us-ascii?Q?4CgBWcVcthq/FY6KaQvKivCcUKzCOUM5G8k7SBZ1JYuuBKjb0sW0nLSBuFad?=
 =?us-ascii?Q?O58591xbigbHBCcjVvifEtOYm0mAIWDeARm0PIR8MFwgbNhTNmuA7nA4GWsa?=
 =?us-ascii?Q?BfnLU3/9k6yiMoU7kbEytUTagdih6qPxCI2hkXEQdYSsy1sZ+oxsVhJdApaf?=
 =?us-ascii?Q?9GwDZVTsiXutiBDsubGqNStifR5dlETOcZ5T7TlJ6AupltMfJqMfO/7HgfI1?=
 =?us-ascii?Q?ncO6QnPSOkY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4JA5YkOfyHO2z+LTGL54oXzcMjB1F+BNcrdMQbi8sWkjRZvQE7r4XoaM0T3g?=
 =?us-ascii?Q?WYDA08KS0Rfdk2IgcKzFcE3eE6Fsqv0NSbVhMCmBjPxRbE7i226f3ZC4YebP?=
 =?us-ascii?Q?Z2pCYt66hPWd4pS3yWmN+hoxzRDmpblIaR5dKZvtXyhgAhMzYizUFXEJMVFU?=
 =?us-ascii?Q?+ZdZglIsgtoqYy9LDlMhs/tMCF1Yby7H3x8wekj9pGeYST+SbnVNiO230p9h?=
 =?us-ascii?Q?x9V4oXT1cVq2bL+6R3zEBwYr9PPIlg2pPEGs4hEOv/0xpMxGRXwte0VcMFSz?=
 =?us-ascii?Q?1FXPhOfoLmfWdWIiwq2iYrZyVeRnFHu086jqVvXz/+0XZn51IquGgGH4b5nb?=
 =?us-ascii?Q?nTZzIpd5mVGBNzYteO7w7MEGbOTTC6EOI8jmc8Qw8e+VGbVWdmSYi5FBVZ26?=
 =?us-ascii?Q?LjWJhxlk6VFxNXeZB97l/aqAzb3EOIPzKo7+6vi7Ptl5+HC/TEMssVzYNWcI?=
 =?us-ascii?Q?filuYmRGDdE5BMDjI8a3dj0z7oOPfU6oiz8ujSr8zDUXhp6hck4Wjl1fQBLS?=
 =?us-ascii?Q?rFQx4mHRZaRUAuZoCIgZ7WR0Nxm/DjR4VjpVpLwIrcNi6E9J3qK022KNLInW?=
 =?us-ascii?Q?gwi67xb/p/2j7aaxuhH8N7BjoSw+7RBvyXKsg1YNsJj7fuffAUpLnEmfE3hB?=
 =?us-ascii?Q?Dp+zJwnbPUw+bHZyCZZ6YR5HwwP5Xyja0dGkrrfxtpQGRR9KnCWP/+htKH42?=
 =?us-ascii?Q?/APyKCY853gYVRrkjjfiLusjylAPZhn7fKWywl4QZcpvNIct3o4eP+KxTb6D?=
 =?us-ascii?Q?WpFFgGfnRS2CGF6oKsqhs0ZCuF4xXfcKTCrCy8E/AOad1eR2X7+uzmpSMG6A?=
 =?us-ascii?Q?l6QS8BNF243ldBCEibywn/ZDmKyocHECb6hO7mQ+42fGTOhplRM16ytWmHNH?=
 =?us-ascii?Q?vv1hEWUQZjpS3Nb8W7sLAp0TXz1vIBsElEixxdx91gvJwai0m0BQy2XB5RYv?=
 =?us-ascii?Q?RF8jg35/gdWrT+3S0Y3aQ1cAehAOy4xIJwQbKjOEszVE/1+t6xKjJpIUr7BQ?=
 =?us-ascii?Q?i/rXM6dBLykTLS3uESAFvDus9kljI1VvXF0LAGpjjIZB7+yJvtHr0Ofjud9L?=
 =?us-ascii?Q?8EIwXAJ8qVnVnxlcV6aPqS/mj5m2nxX5YJQ/Gs97mD/8IlwcQ9+InbuO+Wf4?=
 =?us-ascii?Q?O6ggq+ZdWYfPIhcUnxEkSktyNUf+urRq/2vuhwomxE1D5jj1Ag+LTNG27W9R?=
 =?us-ascii?Q?UFlNf5DOt7rN8EjfyKJAKijkgoMRCQrJECEQPqu9v6m70E99zLkQHPaWFYZu?=
 =?us-ascii?Q?q5dZ/VxyLYAPP69NmSH9rNVPAKHcK1cEcaw8M8YZ1HHiQGQnUNAt4iujdDgp?=
 =?us-ascii?Q?DekqkGzJovbSXuVjWah2Ah1iIFRdSNxaPYyQrdSOsO8wc+bq0VGGFSv0q2wf?=
 =?us-ascii?Q?vAtY4/ME7OJtaMhl/SJ1mg8LmKG94ULu6sLeBoVGABTkKpzpgrhrxB5KfSfI?=
 =?us-ascii?Q?owwEHCDkLO8RX2pt941wRhWRM1TezNXcqN4OPxrWFg4yf2AW4ZXMR2vCMnRG?=
 =?us-ascii?Q?eMd10CKcd6//zoz43K63maAJtfBvomIer9vY1c9apAYCXMQPOMP8V5hRTysL?=
 =?us-ascii?Q?ACWN7MYkED1LeIJcY0oJN9QTMrJNkrFxzuLxnhr4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab17f139-1752-43ef-eac5-08dd1b1e918f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 02:33:46.4042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XrUmcEpVEwYKp8h+ILO/FeZmVpGabSbvtYkZq08OyixNgGBmXI2szzcJRGBQEymM7bVcTjpoX6JkTPQPnhzyyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7114

Set NETIF_F_GSO_UDP_L4 bit of hw_features and features because i.MX95
enetc and LS1028A driver implements UDP segmentation.

- i.MX95 ENETC supports UDP segmentation via LSO.
- LS1028A ENETC supports UDP segmentation since the commit 3d5b459ba0e3
("net: tso: add UDP segmentation support").

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
v2: rephrase the commit message
v3: no changes
v4: fix typo in commit message
v5 ~ v8: no changes
---
 drivers/net/ethernet/freescale/enetc/enetc_pf_common.c | 6 ++++--
 drivers/net/ethernet/freescale/enetc/enetc_vf.c        | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 31dedc665a16..3fd9b0727875 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -110,11 +110,13 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 	ndev->hw_features = NETIF_F_SG | NETIF_F_RXCSUM |
 			    NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX |
 			    NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_LOOPBACK |
-			    NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
+			    NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6 |
+			    NETIF_F_GSO_UDP_L4;
 	ndev->features = NETIF_F_HIGHDMA | NETIF_F_SG | NETIF_F_RXCSUM |
 			 NETIF_F_HW_VLAN_CTAG_TX |
 			 NETIF_F_HW_VLAN_CTAG_RX |
-			 NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
+			 NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6 |
+			 NETIF_F_GSO_UDP_L4;
 	ndev->vlan_features = NETIF_F_SG | NETIF_F_HW_CSUM |
 			      NETIF_F_TSO | NETIF_F_TSO6;
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
index 63d78b2b8670..3768752b6008 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
@@ -145,11 +145,13 @@ static void enetc_vf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 	ndev->hw_features = NETIF_F_SG | NETIF_F_RXCSUM |
 			    NETIF_F_HW_VLAN_CTAG_TX |
 			    NETIF_F_HW_VLAN_CTAG_RX |
-			    NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
+			    NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6 |
+			    NETIF_F_GSO_UDP_L4;
 	ndev->features = NETIF_F_HIGHDMA | NETIF_F_SG | NETIF_F_RXCSUM |
 			 NETIF_F_HW_VLAN_CTAG_TX |
 			 NETIF_F_HW_VLAN_CTAG_RX |
-			 NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
+			 NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6 |
+			 NETIF_F_GSO_UDP_L4;
 	ndev->vlan_features = NETIF_F_SG | NETIF_F_HW_CSUM |
 			      NETIF_F_TSO | NETIF_F_TSO6;
 
-- 
2.34.1


