Return-Path: <netdev+bounces-220876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79948B4950C
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 18:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 274B8204057
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 16:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EF8311977;
	Mon,  8 Sep 2025 16:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="G2bJ7q96"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011067.outbound.protection.outlook.com [40.107.130.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A623B311946;
	Mon,  8 Sep 2025 16:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757348347; cv=fail; b=je5QWJG4DRaDxYcX7j6Vf1rBxFlpf8br8qKFgBH+vHLJmQL6KQcgETBbW8CqFz52MvcRSXVNyMSuaMBWtWwSdUxDB6hgD5M8yrjIRhUEBpZHSWVhPJltO6FU6IrGfp7IuVv7GxmF0AXcCyJ1lhcuAvo/q4jEl8wDKN9dc8Vrhsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757348347; c=relaxed/simple;
	bh=atFHPxULkHnp4FLfR3n+ri1XtMMb9VSJW7Qut5bTgbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AUZTbP5e9nIrt8Ooiyt+eRbOShAyOCOEz74GVYxC0blakU7i/KAzNawSQhIRTfjNcyYTRtKNp+j/spvxeh/Cm4Wqxx1nDmgWOtw8/3WGFG8YGQw4ltwTWDlRewfc2Ux5mjfZVXs02Ob+u2HtsLJWj96A5hnXF5KZNYaaHrMXMMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=G2bJ7q96; arc=fail smtp.client-ip=40.107.130.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tGLOmnIK2Fw+5jtahINC9ImhDMicZD7SB3hT5RQUZ86vhGnv4TQgB4w85CGXQDdZ4dS8qZJNurD3B+2+gLyk2gBqOfxsLGVR3oHkPsuA2L6JfI7p7ntoHcPGZKdzTIw8O4ywceQeP5o9ctMS0LVTKt7JoHo0V+prH7dGhDofcR6+DIvUrU7ZBiBeoWdiCOcDBcowWIgKMY52e0jxqjtJtg/8NGIAhs2Pl+7cpA6J0ct27F0KDW8ZeiZ0IvX0GPRQ6YXjwAouCEohQoakfB9eAfNwBDiNPDxxnQ2lB2uzzaxQ2/ElkeLztBIY1dOIl7tuFhMYTUT6C6hQzZDhcT9M+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gKzbCHOi1RSBaZhwcm0NMAzkM6Gx2uUunDDkQ47meHw=;
 b=G2drMPawKquvUX4JurNIW4s6GVRA2OD+Wcsc09noxUouA3BEtvg4/xuKxl+c58xC5S69x9gy1opXnTNCnRY2R8jCANZJXtrRsUJxnqI32iDZLuM//ASgiMjWdmjrNn2VMS1pU5/x+Kj8hVakqqvUscRREdJrP+0XFK3crRRLnfo2+ZshOj5gWuShl7wJ2DrthCzXiSyM9n/yI9zQ8FXBtXM7G9MTT3tBDMhZt/c23O1UHVLJSh/1/qarsB6sd3K8hBFuwe91idV/UsYnR77dWClHXbHrSBABfowXh7VMGe4gt3PYdNajLbWMpt0k/G2kGNjfpLxAclkU1zrWcdZT4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKzbCHOi1RSBaZhwcm0NMAzkM6Gx2uUunDDkQ47meHw=;
 b=G2bJ7q96RGhMUeHE48UP2qCVAPBvwoVbrkLHcu1qWMEjg3txTkrvy6KFoSegxEfWPUd80UiH4MqHbSCV1KHxPjwBYNXXni9FSXJ0+Y9Qk6/a3MdDZwaagQaXFQ807elv2vtkZIpmVDt6MqKKdU6DYZB/BXbhyAJtUH+Pz+SaRso/U+44EMwHiyACRKi+9EFF65hnxv2qN86Z5u5ZrvAdYqSWzJg9xanqUmbHVyqT7li41N4MVHlrEnU6eFIHwtbBjpZYkWl8e1hiTNIuazQmdmMz9cgYucgIWdz3vYXvYAM4doV41hk+SZzLhEBa0eUZlHcBOxhwGucttf+uUfGcqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by DU2PR04MB8501.eurprd04.prod.outlook.com (2603:10a6:10:2d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.12; Mon, 8 Sep
 2025 16:19:03 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%4]) with mapi id 15.20.9115.010; Mon, 8 Sep 2025
 16:19:03 +0000
From: Shenwei Wang <shenwei.wang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Cc: Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-imx@nxp.com
Subject: [PATCH v6 net-next 6/6] net: fec: enable the Jumbo frame support for i.MX8QM
Date: Mon,  8 Sep 2025 11:17:55 -0500
Message-ID: <20250908161755.608704-7-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250908161755.608704-1-shenwei.wang@nxp.com>
References: <20250908161755.608704-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P221CA0073.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:328::30) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|DU2PR04MB8501:EE_
X-MS-Office365-Filtering-Correlation-Id: d519dbc2-9b59-4ce1-24cb-08ddeef36ce0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AMRHxOQhoRyPTSFD1cg5k6LyMAtyYplcY9dn617Z4yGewLl5eovx85la4YzN?=
 =?us-ascii?Q?GebsT0rKaXay4dd2VRYh81mEVw/AHljguF+vV39uCWETnBFE7mh1oQz3DJOV?=
 =?us-ascii?Q?Xli8GtkAGw3llocuYytERVmy9cbhYhPaOTz0VOON5Nokl6/P34Sr4aYbcfvk?=
 =?us-ascii?Q?bTqGUTdTLO6MKHAkz9bVoPMZgeHRUOrFUm7j2dY04W64UjEb5Pv9Iu7TFbHF?=
 =?us-ascii?Q?BsZ8W8zZJjEspsekJ69Mqu1wT13Aa76kSMWI4sWaw5bAA3UdXTwPKPxW5hrt?=
 =?us-ascii?Q?A87iDCktmGxgweFChwrTQf5YvCQIsbkRxzmb6Bzz89Y4HEMjNBgJu30yeCEP?=
 =?us-ascii?Q?0uiNyKioFoAbCTB+5TbrVuYOATvJA6HBPjncNvF15jaeaz4CD/3eTa4OIkg/?=
 =?us-ascii?Q?QrP8tN/i9IMHi/d557a3htQAcu3InYUA9xioKTCKkq5vaaTsugVZ99UwDllz?=
 =?us-ascii?Q?hGXccyB4mSB5OUMmsEK2ihUSsmYbz1L12lCZZSbnTKgG/i7RvIsPxZroq6+6?=
 =?us-ascii?Q?8MJ8F0VknZZP1TU/uEt9ElIVBSm53SmKeMgdJpeuVlJ1TbC5vbdzrdHxdJS/?=
 =?us-ascii?Q?oed5m1PB6WAtEZUzFL0pih6n/q/428BruDyGnIL1dT3+i4PaVeZfCGsKO4p5?=
 =?us-ascii?Q?fL5qF0Ma+1moOBfJDqYao3olK2dQFI5Otta++H7UEYNuuiu1oMljqmBNyiJ+?=
 =?us-ascii?Q?1sy4EbVv5SFt3t0DPedjfwBtblKrrLhAu1YvtpowI3ASsWqxq9uTcyjXDbno?=
 =?us-ascii?Q?EkYcfwBugJOw7hV/euVsRcIK2ZShC/xzgZSReSnkKK2ngCgHE12R0yguB5ij?=
 =?us-ascii?Q?hqfPNfj4E4VrKhrOViZSdOASUKNpLsy4DVEGpTfft2L9COSTtCICZcKgDJnW?=
 =?us-ascii?Q?r/R+q6V8g+kCYAYOcqD/+M/L+1RV25J9fbUpl1ZamV5om1RYZIvHppQAZjUE?=
 =?us-ascii?Q?I5F+mmLK6LdXVHbmjKatk6TXFiwQ4XR0dfbl6ScRlvmqmWnrwbCL4tpTuwh4?=
 =?us-ascii?Q?SczUK3sLycCr+WMWwuJ8xHzUF/spymgQa1TAxzvzfI6ZaFJt3sy7DZQe5YY/?=
 =?us-ascii?Q?JRb95bIkoAU/+00dGWZI7+amWViA1xNjpucQAzm5+UzyBGlWxFb9Yk3PWhUD?=
 =?us-ascii?Q?eRYQj46ERqoWZ/d9Dy61xLE81RWp+9u61EliKVQHN4P4ygT5DjtyiZHuGsFj?=
 =?us-ascii?Q?E0p89gG+Za5mWldPrkZ9c9abdZWBIIXM0swYo7tEsg+UGCuUrIYNvnvT0LNp?=
 =?us-ascii?Q?E6dU6n4CgHkaMFlG91uuM2i7AvmTZyfgZrLltnX8ezgspZmK1KAlXL+JeYww?=
 =?us-ascii?Q?Jtdyyf+ZT77WZsPwdqIYlHPI2fWkFx+kVCYyXJrRM1Wuu7KEBQad7J6HQA1r?=
 =?us-ascii?Q?CiXi/uiIJ6xxIdlFSrpYvEbKyieApmTQuBcgpP5pTvfLIYv2tEEifJ0LCXsC?=
 =?us-ascii?Q?PX8EH5hz5k3zEcEYxm8bIG2QF2F2FVcDly9N2PrM9LEDrPF8CQUCTH7gE0o0?=
 =?us-ascii?Q?hn1CRe0E15jwWno=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HYIbSq7/OTwgbNVxkzS8DNKXV9fHzY/jseyIiSgu5mnWEepvzENJhMgeUaEK?=
 =?us-ascii?Q?Z0hf98LZrBmrs86nalzrvDxnc4fJQP4GU4m7YfKcDZNfCQRn9HRrZ7kpN5MI?=
 =?us-ascii?Q?p1FOvrhya90PyOFD1ac0RnJg+VOlxGcF74NtlHZ4tuhaM3DESYJLo78hWjs3?=
 =?us-ascii?Q?DIL0/Ps1rQl67E+i9+MNRsNbBwz3RMVYh2QS4WAAZsQJdKciAE4iDqQN9MZy?=
 =?us-ascii?Q?24HexcFsD30qpeCZP67a5eDdZn+u2TjTltLjeWLkqLJqTq1k2aIRg4p4yXc0?=
 =?us-ascii?Q?VQo8pFEsjWLSZlmNhltNEdaP35lE5XT2wx2CZ1czxRewKUQVeliDk81iq5uO?=
 =?us-ascii?Q?spvoVRJNc3MkfaZj4oQMWq1WcHyTmYilthOttKGXyAwO/E7UA3Dixu5FluEV?=
 =?us-ascii?Q?TSgTgg6sJrBiuzzrhcvK+8MOu8w2ya7m0YutgvXjXqDUVgvol9j/VOwBUxcn?=
 =?us-ascii?Q?biQ7t/QP9M/mHlmIS6LXuOLyqPDb3STJg2Y3RgUcCUa75askiTWdzvqhe9OR?=
 =?us-ascii?Q?hI6NbaeVOgMr5BjoMi1DSooS4PTXMGcSlNl+Ji7uzfu+FYEdRcOeDrbuy2mo?=
 =?us-ascii?Q?n/pHK9UbmKqRMTZC3LDmbNRhG5DagkTEwZxFMWVWrjqcjeqytQ/XF/Z+mEzG?=
 =?us-ascii?Q?ziE0o0VEKRgWhaeGYkJoBVn9e5DtosY29Ctl37ZL6nAS019K+Eqh0Ra8a4Uj?=
 =?us-ascii?Q?qy0CKUv//+N1agGYz/JvY63b5P0Z4AsLtKczALeIa2hWnc/xSXR8gbBOhJJr?=
 =?us-ascii?Q?um2ycafVMgDkSOnSJijlbwodGyhiZwHVwme/IGN+nScEVkPPREtGuaUGUyXd?=
 =?us-ascii?Q?O6cNIx1GwNNmNXCLsPdtLxIjOCtuU7AXTLGKoGCP047SESxe6RCLX9K6ltbq?=
 =?us-ascii?Q?RIT9TOcT5LWR+5jEXEIj5MYWyL/FXjFLe50JxYL1IZEs3zYBA2c93HlvpVif?=
 =?us-ascii?Q?rKmpP714lxPukQdGxuUcyFQ3Vo50Y5ResmD7+YRhuIqqDMYskhogzg0ZKD0Q?=
 =?us-ascii?Q?hZSxhHa9gdYmI8gPM5Hx1zOhgJ1FUiNuuJE944IPP37yNppgKQl/2TkqSoA9?=
 =?us-ascii?Q?vufOmumhb9HrgxGWgb5UgCIabX5Cxgr695hDbrvBsm3XaPxb0wEYW24HSyLF?=
 =?us-ascii?Q?U1GArMxRsQ1o173MBPgM3K9a2zLcasGyOng6eiopoexHDCWLr8+9l1K8zq9R?=
 =?us-ascii?Q?MvdUf6uQeyjE5Uw8Rotu6/FcDppBFxF4ko4vkDlZEJRG2EdfO02A+z9n33MD?=
 =?us-ascii?Q?bR0d43e0YgnVMOyV1S+42FBEbvkmdGOn+VbBHawFCx4xb5jlA0AOVoIRYQt7?=
 =?us-ascii?Q?UZT/k0aaOQB8gG+uOVShvHkjhXZnUPEa7WZeUSVscPaSDzdG8O+XRgODredx?=
 =?us-ascii?Q?ltigDSVZioqDL3Ao630m8rOXbf6WRBr8dNMDeaCUc5ROZVZ+O46uIEkEiQyh?=
 =?us-ascii?Q?q68t1xSUzvLiZK5s3GvEpiPjwBv30aBzdp9ImleFejQNXeoA1GXrDq+e5/ky?=
 =?us-ascii?Q?lxKKyBqAA1BFqhzrW5/b5+UJxawGRDhqsHtFUZSaf9T4b1xXt2TxqkLF97Qz?=
 =?us-ascii?Q?0WuRDGydgPGDgsgxsSQKWjivbXfXvQyI6NnSHHxu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d519dbc2-9b59-4ce1-24cb-08ddeef36ce0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 16:19:02.9861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QFIAJhoksFyzAYZPOWijftEzT/vcdH2fIiHX5xowcvcg6YrL/oUNYoYz7pbfpCcebrqxsDDqO/17xlvAnu8x/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8501

Certain i.MX SoCs, such as i.MX8QM and i.MX8QXP, feature enhanced
FEC hardware that supports Ethernet Jumbo frames with packet sizes
up to 16K bytes.

When Jumbo frames are supported, the TX FIFO may not be large enough
to hold an entire frame. To handle this, the FIFO is configured to
operate in cut-through mode when the frame size exceeds
(PKT_MAXBUF_SIZE - ETH_HLEN - ETH_FCS_LEN), which allows transmission
to begin once the FIFO reaches a certain threshold.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 drivers/net/ethernet/freescale/fec.h      |  3 +++
 drivers/net/ethernet/freescale/fec_main.c | 25 +++++++++++++++++++----
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 0127cfa5529f..41e0d85d15da 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -514,6 +514,9 @@ struct bufdesc_ex {
  */
 #define FEC_QUIRK_HAS_MDIO_C45		BIT(24)
 
+/* Jumbo Frame support */
+#define FEC_QUIRK_JUMBO_FRAME		BIT(25)
+
 struct bufdesc_prop {
 	int qid;
 	/* Address of Rx and Tx buffers */
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index a2aa08afa4bd..329320395285 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -167,7 +167,8 @@ static const struct fec_devinfo fec_imx8qm_info = {
 		  FEC_QUIRK_ERR007885 | FEC_QUIRK_BUG_CAPTURE |
 		  FEC_QUIRK_HAS_RACC | FEC_QUIRK_HAS_COALESCE |
 		  FEC_QUIRK_CLEAR_SETUP_MII | FEC_QUIRK_HAS_MULTI_QUEUES |
-		  FEC_QUIRK_DELAYED_CLKS_SUPPORT | FEC_QUIRK_HAS_MDIO_C45,
+		  FEC_QUIRK_DELAYED_CLKS_SUPPORT | FEC_QUIRK_HAS_MDIO_C45 |
+		  FEC_QUIRK_JUMBO_FRAME,
 };
 
 static const struct fec_devinfo fec_s32v234_info = {
@@ -233,6 +234,7 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address");
  * 2048 byte skbufs are allocated. However, alignment requirements
  * varies between FEC variants. Worst case is 64, so round down by 64.
  */
+#define MAX_JUMBO_BUF_SIZE	(round_down(16384 - FEC_DRV_RESERVE_SPACE - 64, 64))
 #define PKT_MAXBUF_SIZE		(round_down(2048 - 64, 64))
 #define PKT_MINBUF_SIZE		64
 
@@ -1279,8 +1281,18 @@ fec_restart(struct net_device *ndev)
 	if (fep->quirks & FEC_QUIRK_ENET_MAC) {
 		/* enable ENET endian swap */
 		ecntl |= FEC_ECR_BYTESWP;
-		/* enable ENET store and forward mode */
-		writel(FEC_TXWMRK_STRFWD, fep->hwp + FEC_X_WMRK);
+
+		/* When Jumbo Frame is enabled, the FIFO may not be large enough
+		 * to hold an entire frame. In such cases, if the MTU exceeds
+		 * (PKT_MAXBUF_SIZE - ETH_HLEN - ETH_FCS_LEN), configure the interface
+		 * to operate in cut-through mode, triggered by the FIFO threshold.
+		 * Otherwise, enable the ENET store-and-forward mode.
+		 */
+		if ((fep->quirks & FEC_QUIRK_JUMBO_FRAME) &&
+		    (ndev->mtu > (PKT_MAXBUF_SIZE - ETH_HLEN - ETH_FCS_LEN)))
+			writel(0xF, fep->hwp + FEC_X_WMRK);
+		else
+			writel(FEC_TXWMRK_STRFWD, fep->hwp + FEC_X_WMRK);
 	}
 
 	if (fep->bufdesc_ex)
@@ -4581,7 +4593,12 @@ fec_probe(struct platform_device *pdev)
 
 	fep->pagepool_order = 0;
 	fep->rx_frame_size = FEC_ENET_RX_FRSIZE;
-	fep->max_buf_size = PKT_MAXBUF_SIZE;
+
+	if (fep->quirks & FEC_QUIRK_JUMBO_FRAME)
+		fep->max_buf_size = MAX_JUMBO_BUF_SIZE;
+	else
+		fep->max_buf_size = PKT_MAXBUF_SIZE;
+
 	ndev->max_mtu = fep->max_buf_size - ETH_HLEN - ETH_FCS_LEN;
 
 	ret = register_netdev(ndev);
-- 
2.43.0


