Return-Path: <netdev+bounces-171514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA1CA4D50D
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 08:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88C36170E82
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 07:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1133E1FBE85;
	Tue,  4 Mar 2025 07:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LDcBJFav"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2059.outbound.protection.outlook.com [40.107.21.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC75C1F891C;
	Tue,  4 Mar 2025 07:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741073985; cv=fail; b=C62MN/QnExBvSb5qxDac0VssnNsqYcAfypkzPr/pwJVmD7SeMOrZbuySQQHtpj6lOJDyNgUDTTlAUDspsEndVlrZXFEDStHxq6wFMiVXMjTUNBkntyIZYArHydJOFcI0kKCuJmwgO//ym0TTSj0ofKZvTLpP7U88K5xOX3n7+2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741073985; c=relaxed/simple;
	bh=I8O3haXaW2W9ZxW0nRQypkNSSiZTitBw5YAHmARPJww=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rZs4jIcy2fbfSxavF+Oq813ODHlLNkAlX1kbIpPlIoUQaX6CLDNPhk/k1oJJPgHDHZnp4pwkB/cxL38VhUNJzzrIFFrzJNTAVFWaeV62JZg0EcbVYidPPUx+3aEjF8pw/xESzkmTVWc49lc0X9yTM5gBTrnA15YB+QuR1OT14wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LDcBJFav; arc=fail smtp.client-ip=40.107.21.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iWb4GS/Dip0UEXBNDm8K8uQNq9ue6dSjBqfwLYfJwdpDyrznrrxOsGQyGv3ia/jg2tTOBMxo9S89wSfer1HcOL/NvLoVdLIrlECAnZVR50zfe1sC9foRBgPe9oFoCLE72bxlx4qFicQVSWr3pReeuHlLYkKQNQPqYmWuN1uCdi+3Fl5z4qR98dgN9oz7JmMp28j25smPpDDIs01YhXaPra2mS8IFgzhSxLzDZK5W2bzZMnhs+CONbMwL7jF/AiISKB4oM2zP7OX3nkskE+ukccKQOT+ltG3w9HyiFC2FejkE+qhSAp09DzampiA9I/ypLQHdl7wiLlh6MER7eaif6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EL6332cKC7WViwONLr9k54vnj9FzBS+8p3izjBPSkO4=;
 b=O6iJP8b2m1gURLhgYZw6/ZPxE1BpMsiGIgXSQrkZ0XZy4lljbbkon6IxBglbZOdsuyGJdATvnRVeDwnYkxhnZu/2iawLw4umauJA7GeoowcfmDiezwfU5hW0rUVX7zFFS3fCFiPLFtYGhSdLaeLZ9iQ1rkdYQN0wU24WrD9FVIn1S1qxooU5YQXBYw1gsusAeObDC/lNTQjEQTzcErc0UT86GB1QiwSpBaR+et3GAVZhuTK9mieTCBDgfC1HMcxPVsZJilIyknqZMzMaMR/Ck8YXTaNR8ur53R6Jrc5Fb7SoEwoN5gESKswQS4kvIliK2F0L1S11a1WhtdEkpHMXAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EL6332cKC7WViwONLr9k54vnj9FzBS+8p3izjBPSkO4=;
 b=LDcBJFavGyrbkHOFmJgIeNm3X361TMDM5psPnz3m/qem4kz/SBr4ecouGWsBVMAbHyn3b2oxg3P0rNLWHESe8h6Oe+SH7CKZFppOnbKIRkeVT87qSsDU+Emw2f2J0S6bIGupXLgzhrcF3rY4kxbY6D4nEZagJU5g0SbHHhX7CAlLPLO68eFJb+gTzBH3/bpiRnt+Au7jzBbQNKxiyAz9HnG+yq2m3dR+XihiCN8RCCX0RJk0+6YRlKrb25m2GUbOg1trtVYJR1Et0iXfuUpWGX1MZcpwDmimlkk3rFx77M+x5sSykuQmcyc9Z4MvkMu4H/qVvlXGM6gQ8KncJxiunA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI2PR04MB11171.eurprd04.prod.outlook.com (2603:10a6:800:29a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Tue, 4 Mar
 2025 07:39:41 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8466.020; Tue, 4 Mar 2025
 07:39:40 +0000
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
Subject: [PATCH v3 net-next 05/13] net: enetc: add debugfs interface to dump MAC filter
Date: Tue,  4 Mar 2025 15:21:53 +0800
Message-Id: <20250304072201.1332603-6-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250304072201.1332603-1-wei.fang@nxp.com>
References: <20250304072201.1332603-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::19)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VI2PR04MB11171:EE_
X-MS-Office365-Filtering-Correlation-Id: 57d4a040-3108-46f5-5702-08dd5aefb926
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|366016|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pO53ym7lqEb2pbxVRFgsdx5LGsx9ZaQj4ihF6CWEr2E0l46GIQ7YRmpNeHVi?=
 =?us-ascii?Q?SMQ4gvp/HFpKV4o8s1dGanFEg9i1SVjmbSWKMALI68VLrp2jXQ2y+wMvYHCH?=
 =?us-ascii?Q?B3QzffcKAQJI2bPBu3VR32nErhaM/7SY8LJnq5qYTpAD2Tn9yBGJDN59J49I?=
 =?us-ascii?Q?huEuYB9h6hGiW/xaBoSSHzaLRJXxO3O2W+tTf9sADayaVb2JIQ0mABjAtC1j?=
 =?us-ascii?Q?AdM3lp/lXR9khHq19gs8Kl/uOpJ6pdM2qtjWD8DoiqGRGPizuTh6MYBsy2Oi?=
 =?us-ascii?Q?4KHGr0ox559Kmz/kqPdy8XYtAX3vnL1UuZsQWaluIH4G1VjbCpUWSR3uCD0+?=
 =?us-ascii?Q?7bFwUCysOw53jKyX8q33n+tEOG0/d/Z4tK164xqH5fm0ILkvdEyYqtbp0xfZ?=
 =?us-ascii?Q?i4/kRcO0iVRa0PBYQdFxA3Fvt8+xOHzjX1YU0EzHwDChFs219RRtqE1EC1r/?=
 =?us-ascii?Q?5Kp8qIKLegf82jtKYTgLnsWDD1XfLzzM/uDm+EIKgXZX//Gp7KJdEdShuf8T?=
 =?us-ascii?Q?vmMhyX5MZHpA5HOpcGspI698grc9qrlazVgcJzmYPnd7ao9mmIdpdtm3yySP?=
 =?us-ascii?Q?uoahFqF0t+v+kE1c2Pj06C0+F4IrSRb+gr77oo16r6yPNaE6O5uhERAd5ZVB?=
 =?us-ascii?Q?RHDRLKR8ekuWFGHC8doBJCWVROAljIZLo+EZOTqCkqK0/rERJbmqn+8CR/m1?=
 =?us-ascii?Q?14iyHTt2vHOyeSUM8Bmrr0jMqu6SYHMRimRILJS0ZkfZNdwMzKAIyIA3DWol?=
 =?us-ascii?Q?+qmoffOWSInGMnQGBDmc5QdY+F6xryC+LJQIyMAK7ejgH84XRpKRgn3pB+RE?=
 =?us-ascii?Q?eSaUs3fDm9vF9sH4fjrdHuHQ+Snl4OTMUcLQV3uxeAnj8XWb2naCs4mJOe8L?=
 =?us-ascii?Q?kol2BwCrMBCxb7RTnydYXvM3fMCAAl+ozXd6Ro15J1i+RiOttjJkG0NIioVh?=
 =?us-ascii?Q?TH8n7nagi1B8alQXYJ2Atbf3q7EcX15+ilodoxpwT2N6uuLoNcEE1sxc2R7T?=
 =?us-ascii?Q?ZWnW3A6E0vGvlf5Spbr6ua3aYQFW8oPSe4gIFyX7jkxX64ODFipDqHcdxU+X?=
 =?us-ascii?Q?v909mH4BKIDGT57NHIu4n1sN1ofqY77r3bLCSgHLeDeltpn/5TtHndom66zW?=
 =?us-ascii?Q?6/njmk7DeUDJ3NGABrVkJWZex4oh4v1D6YAl7oGdXLwTvOktcyz3iTOYqxdx?=
 =?us-ascii?Q?jQo6mz6K9QaCacOsWZV64Noj36/rj1G7uOqBM89D19UrXuj+J6/lnmnrqhiF?=
 =?us-ascii?Q?nPiRKhXWe/wkn++UBO4CWKDW5Abp5TsV69Tlhw9jgPWE56lSAbyT6kQBpQsA?=
 =?us-ascii?Q?aluk5fuGAK1TUgu7v3wNm6uZBiByfHikpP+7zh7/xADCiR3btJj2mL6x5mAG?=
 =?us-ascii?Q?bhh9LKB27Cir7DCfwblNdrd5yoiFxbJgHdBjOFrpwlaxzRuaJzKAoL326ghe?=
 =?us-ascii?Q?33VOngOj/MYdaaas5QAlXFOEqyVdeUnE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(366016)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CBhq3Djjrvh1ODkPjpwgnp7OGaLuZ/i96WI6YHVBZIW2ALWJpuKC/Ku96DWT?=
 =?us-ascii?Q?hVhQ0rf8U/fuJ3UnfAeflvYUUfQ3VRi1JxFeg666uvXJE9PZ9lQ2Af/WufD0?=
 =?us-ascii?Q?V7Z8RH5J+bMxEqe9gEOLh6xa2khND+unpVE5XquaYjOGyOQEaL5LHa0mVI2W?=
 =?us-ascii?Q?wWFj2/hqt19rQ7IDBDf4+lqDejimVPK3aMx9wNiAUAtPx2QzpepUtyIJ5kJM?=
 =?us-ascii?Q?/Tlk9JC7Vr8Xmfi1jRbKW2Y23rnuJ8cmNAtxm+tTjMiRxHKnPXyqMicBjvmY?=
 =?us-ascii?Q?erbas3Tz31MJ6Ufwk08qqZv7k1+qgBLr14awm1ycsy0bS4uAsr5yGE7BnmFk?=
 =?us-ascii?Q?j1kYFtUYn/4Hk31obTCFQme/93EzTRSA+OIosPGudzgKuhcHewy5IbhRtVuu?=
 =?us-ascii?Q?QAgGVoKX9YtHYgkpkUKX9+v6vEcdMxr9xQsV5HOvNifEMCXde7zfBIPmf8G9?=
 =?us-ascii?Q?UeVnazdDJqBct1OVFCzy7hWDzMDaJFHEzH6wapiUkhzT487F+pBpWuIpZyHK?=
 =?us-ascii?Q?mExU+8ZTn+Oh+mKgdegHKr/lafPtlgZ0qwMJ2h3SUn+cPzmoRcw2+mixzWIA?=
 =?us-ascii?Q?JSOXDJZegbxSvJHmmnZagoKrsfPLiWno3X/HFygltQmbEfmJ2EiSGBg1fDNH?=
 =?us-ascii?Q?9p7Hf4eKPcStsyr80VR2HbgLHeZmXxst7FyHvgndSMpvL/X75LMifAwzumqG?=
 =?us-ascii?Q?95w0NIIwOJMuO34izJ4RDtqRtzNk7k87pRS8oNRZiP3DzWgBAlSV1kdb3Y94?=
 =?us-ascii?Q?sSNWp72N0Lld15Vyp8kgdgh3LbJLBGNeeDCLHgmX+TeWkdwxb5aXC9X2+BTo?=
 =?us-ascii?Q?fGs/39nlfo21n2CuJtPLiQ6XueeuATs6w922QftVchRiDVueQtCNkLFg1YWp?=
 =?us-ascii?Q?7T1etfh0FjDy+vl1dT8Q9pQg8wh/tIaSC8Zlj8vxsHmjpXLKGjjuotEFVR/m?=
 =?us-ascii?Q?vqBGbOam6jSzWHqenvu0CxjceD2t0kkPD3AgbkOtbV2MH9i8zdmPv14S/Zcp?=
 =?us-ascii?Q?4yPuB7BsZ0mFJYUYd0JrZQHym6MVN79mAV0bhJRALzQMC0wiFjqA9s0AxaTr?=
 =?us-ascii?Q?BM3BdZP4XOLSrp7WbASoBP2hx4keruo9tOXNH4G/CRBESVIl6sPHKogKKvqr?=
 =?us-ascii?Q?WbSKXsFMLF8NptO7xRd6F/BeFfs8/uptU/E3YwcRrGZDEZQX5A6k7cy9kc3c?=
 =?us-ascii?Q?eMVKjfD8M/yR3373SsUSRagUo8/4MdyK6PiIP5Raa+CHX9ZL1yzbptZ8THEk?=
 =?us-ascii?Q?Snz23pWlRDz2KY3k/LjrehoaMDjfv+ngOmPMgiO7HQXoXzaep+Yd6gZ2kRPz?=
 =?us-ascii?Q?s5X0weh2WpYJoFnlgFKXlcXbZQXUCNJRm+7HSgc9weOfO+WdS02HECQLVt1H?=
 =?us-ascii?Q?P5PVh2mI0ujQuUC683kxClQVmwfw8rL0hNOFeDZbVywK4rhNSWlkQWDqIzYV?=
 =?us-ascii?Q?aaIuz7ux+zpKMxeeSi4zJH2xhllRx9JxoNNHEoOFlVslQIp+rDjuim1SU2/E?=
 =?us-ascii?Q?PgjRpk/e6OK/fsWdIKRsBzTn8gI6tJ4mfxDGt7yIcjjbjN5gtadKRwbsAp/S?=
 =?us-ascii?Q?fiwxB6ep5betXBvz3uRQOftvurkIeJ3bIvPSKcbs?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57d4a040-3108-46f5-5702-08dd5aefb926
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 07:39:40.8670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0p45MhLZ6dK8V8X6FtXnP5NPVGhm8bi4mQFQSZaa4tyQhFo9Id4mAmzu2kVMOgMYOVSifKtNaltZ+7OGdDS5Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11171

ENETC's MAC filter consists of hash MAC filter and exact MAC filter. Hash
MAC filter is a 64-entry hash table consisting of two 32-bit registers.
Exact MAC filter is implemented by configuring MAC address filter table
through command BD ring. The table is stored in ENETC's internal memory
and needs to be read through command BD ring. In order to facilitate
debugging, added a debugfs interface to get the relevant information
about MAC filter.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/Makefile |  1 +
 drivers/net/ethernet/freescale/enetc/enetc.h  |  1 +
 .../ethernet/freescale/enetc/enetc4_debugfs.c | 93 +++++++++++++++++++
 .../ethernet/freescale/enetc/enetc4_debugfs.h | 20 ++++
 .../net/ethernet/freescale/enetc/enetc4_pf.c  |  4 +
 5 files changed, 119 insertions(+)
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc4_debugfs.h

diff --git a/drivers/net/ethernet/freescale/enetc/Makefile b/drivers/net/ethernet/freescale/enetc/Makefile
index 707a68e26971..f1c5ad45fd76 100644
--- a/drivers/net/ethernet/freescale/enetc/Makefile
+++ b/drivers/net/ethernet/freescale/enetc/Makefile
@@ -16,6 +16,7 @@ fsl-enetc-$(CONFIG_FSL_ENETC_QOS) += enetc_qos.o
 
 obj-$(CONFIG_NXP_ENETC4) += nxp-enetc4.o
 nxp-enetc4-y := enetc4_pf.o
+nxp-enetc4-$(CONFIG_DEBUG_FS) += enetc4_debugfs.o
 
 obj-$(CONFIG_FSL_ENETC_VF) += fsl-enetc-vf.o
 fsl-enetc-vf-y := enetc_vf.o
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 4dba91408e3d..ca1bc85c0ac9 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -318,6 +318,7 @@ struct enetc_si {
 	struct enetc_mac_filter mac_filter[MADDR_TYPE];
 	struct workqueue_struct *workqueue;
 	struct work_struct rx_mode_task;
+	struct dentry *debugfs_root;
 };
 
 #define ENETC_SI_ALIGN	32
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c b/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
new file mode 100644
index 000000000000..3a660c80344a
--- /dev/null
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright 2025 NXP */
+
+#include <linux/device.h>
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+
+#include "enetc_pf.h"
+#include "enetc4_debugfs.h"
+
+#define is_en(x)	(x) ? "Enabled" : "Disabled"
+
+static void enetc_show_si_mac_hash_filter(struct seq_file *s, int i)
+{
+	struct enetc_si *si = s->private;
+	struct enetc_hw *hw = &si->hw;
+	u32 hash_h, hash_l;
+
+	hash_l = enetc_port_rd(hw, ENETC4_PSIUMHFR0(i));
+	hash_h = enetc_port_rd(hw, ENETC4_PSIUMHFR1(i));
+	seq_printf(s, "SI %d unicast MAC hash filter: 0x%08x%08x\n",
+		   i, hash_h, hash_l);
+
+	hash_l = enetc_port_rd(hw, ENETC4_PSIMMHFR0(i));
+	hash_h = enetc_port_rd(hw, ENETC4_PSIMMHFR1(i));
+	seq_printf(s, "SI %d multicast MAC hash filter: 0x%08x%08x\n",
+		   i, hash_h, hash_l);
+}
+
+static int enetc_mac_filter_show(struct seq_file *s, void *data)
+{
+	struct maft_entry_data maft_data;
+	struct enetc_si *si = s->private;
+	struct enetc_hw *hw = &si->hw;
+	struct maft_keye_data *keye;
+	struct enetc_pf *pf;
+	int i, err, num_si;
+	u32 val;
+
+	pf = enetc_si_priv(si);
+	num_si = pf->caps.num_vsi + 1;
+
+	val = enetc_port_rd(hw, ENETC4_PSIPMMR);
+	for (i = 0; i < num_si; i++) {
+		seq_printf(s, "SI %d Unicast Promiscuous mode: %s\n",
+			   i, is_en(PSIPMMR_SI_MAC_UP(i) & val));
+		seq_printf(s, "SI %d Multicast Promiscuous mode: %s\n",
+			   i, is_en(PSIPMMR_SI_MAC_MP(i) & val));
+	}
+
+	/* MAC hash filter table */
+	for (i = 0; i < num_si; i++)
+		enetc_show_si_mac_hash_filter(s, i);
+
+	if (!pf->num_mfe)
+		return 0;
+
+	/* MAC address filter table */
+	seq_puts(s, "Show MAC address filter table\n");
+	for (i = 0; i < pf->num_mfe; i++) {
+		memset(&maft_data, 0, sizeof(maft_data));
+		err = ntmp_maft_query_entry(&si->ntmp.cbdrs, i, &maft_data);
+		if (err)
+			return err;
+
+		keye = &maft_data.keye;
+		seq_printf(s, "Entry %d, MAC: %pM, SI bitmap: 0x%04x\n", i,
+			   keye->mac_addr, le16_to_cpu(maft_data.cfge.si_bitmap));
+	}
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(enetc_mac_filter);
+
+void enetc_create_debugfs(struct enetc_si *si)
+{
+	struct net_device *ndev = si->ndev;
+	struct dentry *root;
+
+	root = debugfs_create_dir(netdev_name(ndev), NULL);
+	if (IS_ERR(root))
+		return;
+
+	si->debugfs_root = root;
+
+	debugfs_create_file("mac_filter", 0444, root, si, &enetc_mac_filter_fops);
+}
+
+void enetc_remove_debugfs(struct enetc_si *si)
+{
+	debugfs_remove_recursive(si->debugfs_root);
+	si->debugfs_root = NULL;
+}
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.h b/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.h
new file mode 100644
index 000000000000..96caca35f79d
--- /dev/null
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
+/* Copyright 2025 NXP */
+
+#ifndef __ENETC4_DEBUGFS_H
+#define __ENETC4_DEBUGFS_H
+
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+void enetc_create_debugfs(struct enetc_si *si);
+void enetc_remove_debugfs(struct enetc_si *si);
+#else
+static inline void enetc_create_debugfs(struct enetc_si *si)
+{
+}
+
+static inline void enetc_remove_debugfs(struct enetc_si *si)
+{
+}
+#endif
+
+#endif
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 305781ccefd0..c696eb4f0488 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -8,6 +8,7 @@
 #include <linux/unaligned.h>
 
 #include "enetc_pf_common.h"
+#include "enetc4_debugfs.h"
 
 #define ENETC_SI_MAX_RING_NUM	8
 
@@ -1176,6 +1177,8 @@ static int enetc4_pf_probe(struct pci_dev *pdev,
 	if (err)
 		goto err_netdev_create;
 
+	enetc_create_debugfs(si);
+
 	return 0;
 
 err_netdev_create:
@@ -1193,6 +1196,7 @@ static void enetc4_pf_remove(struct pci_dev *pdev)
 	struct enetc_si *si = pci_get_drvdata(pdev);
 	struct enetc_pf *pf = enetc_si_priv(si);
 
+	enetc_remove_debugfs(si);
 	enetc4_pf_netdev_destroy(si);
 	enetc4_pf_free(pf);
 	destroy_workqueue(si->workqueue);
-- 
2.34.1


