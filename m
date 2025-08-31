Return-Path: <netdev+bounces-218579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA2BB3D540
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 23:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 182D41783E6
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 21:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D9B276038;
	Sun, 31 Aug 2025 21:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Vml11YPe"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013027.outbound.protection.outlook.com [52.101.72.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B6C276048;
	Sun, 31 Aug 2025 21:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756675014; cv=fail; b=EihPFM0Yeup9uxfGhoRyfu6sh1rlE47BGedpiq5JHq7tbeNQJqQ/tyPv+U9/psmz49CP42TbrQoJmi8VdMHCXPUD0Vyua2ikamroZ/oJlkyXLUGceKd3I2dQrc51JOyxYDWX+47d0gz2xrBfQERyyEUDy6/AE1UYszqPMBCqO5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756675014; c=relaxed/simple;
	bh=amfrMx4ZE+1Fm07eSaZ1aU91xVdfyu5CRwWhEw0Z2bU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W5iMp6qtX7cdaILz8YMPWtB91MJOa+EgjrWfvd6adce56DSgzOEKP0ZZE1wSPEn3tAFBgYZOCzuLWE+H3eBMJKOTlGtb1rwhUojGHjtSmwbdTybcAr5JeRqreQETSZ+izxCD6QRRQhlRPV1UOZfE/0On1TUFfaL+6bN+ADsttNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Vml11YPe; arc=fail smtp.client-ip=52.101.72.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CjNeZyy1lMp8OVlK89flJMQZbyZHNqJi6w87oDPXaKs30PzkYD0x8k3FhS0vELR/8Zwv9rySfnZPyA3+oTC4Ir+Y84ztm7Ru8amX56uUuYVs/Q91xrikvJToKPq0xDXFsrbSO18ylsRDmdGONgM48WeL8Oek4iqZzyJsWXVEte9yFE8RtNOqzxnLZZH3mE8u/5MCTj82ErZX9TGic5SupRnU7lNsmQnjvGwmvm/rTzOU6gewmEs9KtEP0oMOhAD8fJJi/jlwYHS0mdWsrCWyLlt9KE1JSjHzacQIO7h46/eCBdSXgXz8MW+LcVi2rjgp9Yt3xZe6/PAK8XjoFMfpOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=roh2y9vbNYL/sKYopp/6x4wudpm9dpI0wF7ODxpkqjk=;
 b=FJz/yrB0ZzEkOXqQwz7TZSCxs+IBKo18jmSXXE2pNdEf4i/nGQf7l/lj1CajhxeAiTihsD91tX8oSP973IRFSY3AnL8ZUBSy6xxMWCXHM4WV+JAGvY1vD5SS6OFvrF1+JiSZluiKi41X5lTF4b5jkjR625QJfIvZRvsYASHXkSoDzeKb1kjWHjK2fyprlZ/0su/lfaFZJ2F4WpMmE1ySRsdvnbd3x1BmI0A3L7ucfx1yd7WFH+Rw/L5CdNbgWKx1zwYVmgBQELe4iqw1DKQ+v8VvkcxUyGQTVDRTA4lUNk2Dfo8ofMCDMksZO/xKu0MjN6ZDL58tJVuDNoTejCWzOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=roh2y9vbNYL/sKYopp/6x4wudpm9dpI0wF7ODxpkqjk=;
 b=Vml11YPema5xRLNV9XdEkbJ/DjRtYZ+x1gtCI+GZOCDFYUZNy+evcONwO/mKQqH4SUwhy2JaZ1eP6n1nfbtduqA+xsRQbwwrzxYaQofAofIFwrbfIYkfS8oPHFrOz11x/Q7OV/WYvL7v57VwGLCE4oGAQLi+FaPI9+UmG8nAbdqcQ4ZsRvlBfoRnbuY81Zf7fHTh/FNzemr/KATJztayAc4f5gB4DZCewWT26u7qCGtwYvMA9VRJnE77H4SOBSSoQtHE3oNEZbZ4VniaFBXHOHJ21mnle0DpSrFVkK6E+Nmdb781TWFpmjRFyJWHiFRTsSGWs850D3HGVVPCLavZyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by DB9PR04MB8250.eurprd04.prod.outlook.com (2603:10a6:10:245::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.25; Sun, 31 Aug
 2025 21:16:48 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%7]) with mapi id 15.20.9094.015; Sun, 31 Aug 2025
 21:16:48 +0000
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
Subject: [PATCH v4 net-next 5/5] net: fec: enable the Jumbo frame support for i.MX8QM
Date: Sun, 31 Aug 2025 16:15:57 -0500
Message-ID: <20250831211557.190141-6-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250831211557.190141-1-shenwei.wang@nxp.com>
References: <20250831211557.190141-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0060.namprd07.prod.outlook.com
 (2603:10b6:a03:60::37) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|DB9PR04MB8250:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ca10d04-50b5-4d41-ddfb-08dde8d3b239
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|19092799006|52116014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DvKvCFVOc08ZhtnXkMr7VuNPXlQG0pf8pQABOciLC+ZTHMMSqJJJK/1UDWOy?=
 =?us-ascii?Q?5WvtfXuKWZc1PyJ6lVOVXyS6mk3v2Hfxtrj8RmZqxRPlhpCfvbd3U5Xwf67y?=
 =?us-ascii?Q?iplwCeSWbjsfgL493hQbI892Unvp3ODv7LWlCs/tr9vzJqhIDPhJS7oP3IbM?=
 =?us-ascii?Q?mR5If3pDyhDMHcnorFxkXmMki4QtrCECFMwR+8muiwxefahl/aJgIEMdbvnu?=
 =?us-ascii?Q?LToVxz2GXN4x1vi8eWprJ5GmlUjJYQxD9NOE4bmOvFFoJVBD3CIDwy22JDIb?=
 =?us-ascii?Q?Zvkn0deqF1AQouK7Tom6JcXIexh2j6HpNWtOEAwGaY6Q9XPBQ0tuJMT3OgDN?=
 =?us-ascii?Q?pGZG4d+Nl7nfavfwO0coT0VU0BwxcHgrP3TcYHUMxiQrpgfGXAHMtO2KoTA/?=
 =?us-ascii?Q?q3TLjxpvFuwGNcpAivzHkMFlbkVHxtlpk18UGih6DpX1283ujSnJZsHk7LFX?=
 =?us-ascii?Q?nEhBCDG0aXhLGHp45HhzILuScYyVZTJH6IteIVcEVlRfxlAMWrTNBYLH60wB?=
 =?us-ascii?Q?DP9/DYb5s4oN53yKng+ApQ/OHVyqsfJHz/3LWXzH10hTWlSLElwpObvrhbLA?=
 =?us-ascii?Q?Kfo34TDMsyB5UE8cWYNG/U7zqkJUlRIcmkY4l0k6N3EGrZUPlMSPNqvX33uw?=
 =?us-ascii?Q?V1wZk86FstYb2o8EVjWkAUssE38wFtrPP/3La5kvtcc4cY9XDbgugJKKnZEK?=
 =?us-ascii?Q?wDN4hxHaNy220wuLEur8GlD9G9Aam8lTrMH/iqutjTKlULuz9ippcj/eZ0Us?=
 =?us-ascii?Q?1eDx8EMkBpvdfAjkz2+lQbvT1SRB1YOinkUI1M4CA7h6WhEF0AvDt0VbahcA?=
 =?us-ascii?Q?r+r2DBpriq+IumjuGTVUpA4ozOKiDCQSWNik34J2uEVA1a94HmlYy6HjLwyw?=
 =?us-ascii?Q?HMFB7DwZdLuiCTtxL14O3QqQ09Yki9GNtRKYzF1OLtBbmMmRnDpLhf/DmL9D?=
 =?us-ascii?Q?KQAJELo4aBddYYXJtpj+Y2L4xd/47NVbZ1WTAGz1JVrmgFqGNKs+AsnrbutJ?=
 =?us-ascii?Q?YhucGpy4ND9JYoLZoLosvnFINYHyk6hZJw7wvMhIa3ssXswQsd9fSaJSFZTo?=
 =?us-ascii?Q?bqpTiuAVMj9nM8QMaIQ5sn6KORX6oPBlW15JsJnfa6MKizxXEmu9yQDbK0iv?=
 =?us-ascii?Q?n38LrMGYEn4XYk+ADsYpePYtPPqEbQ2rZH+nnebkYY5TWoQGvg083nWk0AU/?=
 =?us-ascii?Q?BAY4SJ2TjnfCUtYUcqegmSNxrxJSGxmZPhj0CvJQqHqwAVjBvv+kUVuHcWib?=
 =?us-ascii?Q?uCGf10jXdl0TX31N20B6EblTvAaU0/HMd5qWwVRzi/nDIY67v3B1dO0NUGtR?=
 =?us-ascii?Q?pzvfz9SCJU4zTgdCHimkhSWVb0Oqv/RM5pP9P6G1YsjO86vEBLd9s8ulbP1k?=
 =?us-ascii?Q?hf04uzOkEHz+3219irw2ZYkfEw63by62xIQdfDhadHAG8wjSJBLewfxQcNTP?=
 =?us-ascii?Q?mXApWyXBn5zglHZuQT6c6tHmlXBneElbK9q+AMsddMB6ZX/gZ2PVkFUoeNjj?=
 =?us-ascii?Q?3d3M1DMyRlxWgdg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(19092799006)(52116014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CCB9PPluoL6bhVU2Yy+5K7SuFtui1o0/jTK6Dz9nIDfu8OuuqmuOTmr+7DM2?=
 =?us-ascii?Q?OllSecsu6+mSPR5N0+uVGlhhxMmppfo7ALPQjezumBSZwoeA6Rg47RdroVWV?=
 =?us-ascii?Q?eL+AHd9QkW49vyyzk1QSzRK9m3/rRoe78q19AOkCYRcuV1ZxUaVbBNjH17Fc?=
 =?us-ascii?Q?0vA7ENREIpznFlYePuT7CXDg138NZIN9DVPEr+J88+D86XRrJGoqr156BkAh?=
 =?us-ascii?Q?chuwhv2jh06TqnCRy3EI5ugjAGN4JerrZ5lVQzTVVGFBu1ozMYAvx/GXmNhs?=
 =?us-ascii?Q?iA3hhhTKZ7rdJKJUfUuhPQYLsKpwxpQMpyffdfxWMiUW3w1G8X2tpeslraTv?=
 =?us-ascii?Q?f2Pm73hUTfEqIEDzfYssrGAy4ksDdROTYKkZrWOZ55p4C9E6NA6ZJtfX3Opb?=
 =?us-ascii?Q?1OyRUKcMgugVgL1VJUG5e0Kp5v8w+hZ3djwOk5K1dR/DOEwAeZMP7qiXHM5h?=
 =?us-ascii?Q?yZ4VxxcCsaYadNh9BmvAIMDvQYcKLddZliyx42igF3jRekQZPeXQPaKQQyjY?=
 =?us-ascii?Q?Tt8w/Qgxheu1k3qv1KQBeSC9oz6EZf1F9g5bOHNMNGuZPRa9Cgv+eQ6ZMIKN?=
 =?us-ascii?Q?sLBefADqMTsQNTQaQGiUflZHkIY0SDbhzq8PwW7UjLW/QCaAROShL+zO3p+Y?=
 =?us-ascii?Q?91P3sVaFK926G5AKeshJjEOiXVuCMAqkD9SWKM2RKC3FRF7nnUBlgoWNf+Ue?=
 =?us-ascii?Q?Jt1saYeOaEF0npS4a2G9lk0y6GjlRIPKzGavdDZh6xfrkgL9Ez9AlOkbXl5Q?=
 =?us-ascii?Q?8pxFGTLa53+K8qfFafZcR0sOd+5Bs9KFD5EuGm/qEanpS58g39k12FGt9q6c?=
 =?us-ascii?Q?Ts5ZkF+ilfbm5TiABInZ27hwc+4DTeNn99nmcRYO5FI8KDS8+Hsa5Alh+clT?=
 =?us-ascii?Q?SRe44atYqqXxW5wZN3fl5PpJ54hSfX4NA1HczRKMqk0n8bkPGPIe/WypCh/C?=
 =?us-ascii?Q?1fNY69LcVQ/RbJN7t909/j84gT6XPKZq4OjUTTo3z4WAw/PpNf1gczG5Hlqs?=
 =?us-ascii?Q?G9Wk7MiDF1kvQ4OaBM+ECXkayaAPN5GaY244Jpej1ueKQdX3D+w6O99jSEOO?=
 =?us-ascii?Q?MCX852oeYZL9yYEXmZidBF2BL0H3GaWcmZmPShGkWDG/xc4KEblASb3aZ6VQ?=
 =?us-ascii?Q?oR1NFwq5UpfyUTcCAkfW4e78P2n7t8VjX6eR9Tjtr762DxoiTYBgP6uisLzN?=
 =?us-ascii?Q?dK6pC8Dsra57RHPoFrbm+2Q5N+VMTh8WhEf3iOMzNG+M1D8WaH3kXAw2eGKh?=
 =?us-ascii?Q?Wxl0yi2pJbaLjiPujYchtdDodeFyXGXDb0e9mnZexHPCV5cM2FyX99elKhEY?=
 =?us-ascii?Q?t+CJlEzz2/HPeMzZK4MdzAJujSc/idj7SSFD6YaTDuSY/BBWcm/7wKqV7MBS?=
 =?us-ascii?Q?H2TVgdOZwjHh72zY6NZnqE2NxAR9UGFW7PAK3baBq9Z6HwT4WMFu5lMYQPRo?=
 =?us-ascii?Q?4msL4H1CLnz2Rnk4TdA9afDNLC3sWBvwf1o3qdIjSxn+nc4H+F8pxMNtx356?=
 =?us-ascii?Q?63IwVUtE0TS49ySvvDHyIt6Agtxxq6MSlOXQp0eFZaxjhJLo4e9AgVkpuC8K?=
 =?us-ascii?Q?Y0Z3q3lbDD2ZFEpfEEZgiq7+fhW7anGdduuagUmX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ca10d04-50b5-4d41-ddfb-08dde8d3b239
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2025 21:16:48.5300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R/zaI54N5lkXqbiwqFASXwgHGGxrQ9RaOaaETZ2FscmY3dVi/HUm2hh3H474khhVH0NQX5BWYpvSQciK5toopQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8250

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
index f1032a11aa76..6802773c5f34 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -513,6 +513,9 @@ struct bufdesc_ex {
  */
 #define FEC_QUIRK_HAS_MDIO_C45		BIT(24)
 
+/* Jumbo Frame support */
+#define FEC_QUIRK_JUMBO_FRAME		BIT(25)
+
 struct bufdesc_prop {
 	int qid;
 	/* Address of Rx and Tx buffers */
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 43f342dd9099..9d4adc8335fe 100644
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
@@ -236,6 +237,7 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address");
 #define FEC_DRV_RESERVE_SPACE \
 	(XDP_PACKET_HEADROOM + \
 	 SKB_DATA_ALIGN((unsigned int)sizeof(struct skb_shared_info)))
+#define MAX_JUMBO_BUF_SIZE	(round_down(16384 - FEC_DRV_RESERVE_SPACE - 64, 64))
 #define PKT_MAXBUF_SIZE		(round_down(2048 - 64, 64))
 #define PKT_MINBUF_SIZE		64
 
@@ -1281,8 +1283,18 @@ fec_restart(struct net_device *ndev)
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
@@ -4615,7 +4627,12 @@ fec_probe(struct platform_device *pdev)
 
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


