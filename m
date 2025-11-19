Return-Path: <netdev+bounces-239797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BDDC6C749
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 03:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 375AD3671F1
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 02:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF252D73A0;
	Wed, 19 Nov 2025 02:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YxBa5NWy"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010058.outbound.protection.outlook.com [52.101.69.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C322D12ED;
	Wed, 19 Nov 2025 02:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763520672; cv=fail; b=Dq3SgMIDeZriLQSCRYDl6Ey7udbMZ1c+YFAZNJ2P+0/XTOwhaiebT3nB1tUKXARht5d/6uMT2nCZ7UGh+cBwwY4m7QFaMKaX/xpnELmpfno2Te+HQM+K1l2AXwP91kxavMkrJ2/5pxl6EXSfnBjXEB/xKCVuWNu0u5Qgyfwo90I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763520672; c=relaxed/simple;
	bh=b8V2jiF2yJ6KZtERxprgg+4oiAxzbNyCJpvW/i9fIIU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=CUwpDJjTYDnrjS60j9ziwYu8/bK535Ohtpi1vSJu5cLv4z0S7bJcXFTVXeYqF+VmHQb2bow4324AKWjlin0NFS5u7LtLJOo7y7Q5TWz31GfAd4Xupk/nJWkkVADhPTI0zxiOEHoHbjbZE7/VdIGScCvWhKYKQrH0esGN2Lw+JQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YxBa5NWy; arc=fail smtp.client-ip=52.101.69.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fyk9s8WurMVWKnTt4BdvnPUA4Q4OUilyGgiLdKYbh3DWyzkCM2M0eeaEzM2UdTAnnx8sjT91Byu/36bsCnH9pq9SW0CihFJKd6kqBw0PgeXG3yPuKJTrSQVjmWYHsJNHatNomC22dkXKekmuBizygVH39/fniwpz/MFr+ZPjNP3LOy+QHoq0nm+Hq0G26yEXh14FqdIAk3O5Q2W/wNt7Kr7ra/eH/MceOjM7fFPpEO+lpEVM1FooZ0BRQEtKEITlQpGXAz/lv7687ncTWR3Ks4SQwjE554bW/f+rBae/PS5dgzBoOxHU7MMVXPWZ63P5l0YaI2HrhsF7qVZqMIWdbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GPBxWaeaQVUNsX+Q69+yF4cCGUcRuikvevFDYD8pRw4=;
 b=ss27H2Uq02UCwsYPv0Vnh/jZhuPa8syLIWYa1gbS9ZiTQb6+7kgmHhtw7pZppDYqo1uYw9GjLjIqiWJCr5lk2ug37kUj1tqW8ycRQJuSxOKIrStOtP4YhO786g1IZQpWcyx0fXENKTuKewsB7ZE7f+RbYwxBkQwJf0ZxBbVNHlpcPlWCQxa5pt4Pc9ig36JDCj561I4UTMfyanUHFxdG+X9OiqJBuZwdLzGmdvbQaUdx39G+ocfcx84+b8RpfjJzZ/k2HQl78IWYnke3/xsf+YGOAGr9rG0modgIqWTJD+ZLavfMFiNGq6Ekqg3NsTPo98t0YXLjbVM9+IhGl9sL/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPBxWaeaQVUNsX+Q69+yF4cCGUcRuikvevFDYD8pRw4=;
 b=YxBa5NWyADN3wY5DqJoZhXoeo4t+WkUE2edMnJCpO7gmtsQZeobby8f5wnwihvSUb31VNVlxnECt4Kkt1wpDyElzgQvBD2oMPkQhOlsKLab+5ndvOcJHFISMpzIVWYNOvCzuHF0H9z5vI1BtsLFNAsDC0eYC7zeVtCEl6V6c/JpI2V4brT3Lbz8aRsz0paVQHZGp8O3we/lUN40Fzm9z4AFkzmgu3rm9WhOHjbRE0oQJRgyvSgFxGtbC2oTeV7VY+o2YwPDsWxP7mUz1TLRe4l14s5zl6VEVY5IpcqfrS/6VncMNUY6y0grPDwVBh/ON1mCdmGSsqv6MPHg86ut40g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by OSKPR04MB11439.eurprd04.prod.outlook.com (2603:10a6:e10:9d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Wed, 19 Nov
 2025 02:51:06 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 02:51:06 +0000
From: Wei Fang <wei.fang@nxp.com>
To: shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	eric@nelint.com,
	Frank.Li@nxp.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 net-next 0/5] net: fec: do some cleanup for the driver
Date: Wed, 19 Nov 2025 10:51:43 +0800
Message-Id: <20251119025148.2817602-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::7)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|OSKPR04MB11439:EE_
X-MS-Office365-Filtering-Correlation-Id: d650509a-4bb4-4e6b-8569-08de27167c0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Sp9rh3eqOCSyeb2wTUqs/iTdkyU3HZY0WIa2ilPKaMfYoZkRzWxm+fEUa8oe?=
 =?us-ascii?Q?GrN4PtlMExR+AhdvVdE8I9Ttwa/PvbIG48xVABmQYMi54khCRY4B+Q7tPwC7?=
 =?us-ascii?Q?gPDtp39NC/Esza7QeGIjm2QQE9tvoBZWJs5kq6f+X/3YPC3solWTzxM/3Gy+?=
 =?us-ascii?Q?vI5Mynmo6qy/72Ytdw4qZzL+ODayrByjzUqp+U3ifWSBSg5p/5giS0dMkmJd?=
 =?us-ascii?Q?KzWrJN3gNgHmkFZnEr+fHykc6ts9e7gmzzikuTVh9bp5b5iNAFRN9pvhtiQM?=
 =?us-ascii?Q?5/KIb7ro4Tivor9ND7y1NzfYfGr0N24ziuMt9uvrMEHptgfw/46gAKmAvnfV?=
 =?us-ascii?Q?3orC0gcfhj/XIuMoG1S4vu5KR8UhS1c2FyE4vkcPc6EbKtnLiy/TV+t4N7SK?=
 =?us-ascii?Q?JOBAWrB0pk7fc2kQvvhbNC6kQmUM0AvTtMjgbPNUvOk1lBT4dJ9EUBrzmvZ5?=
 =?us-ascii?Q?4s0IRGkZCAoKJpbj7f/bQ8x2/ZBM6l7jCo62dNKKkmNQEXa/t+XQUl9MSHLx?=
 =?us-ascii?Q?0v/DNMdpBiCOMsFMWJWWUbJ2Ev75XrhGv00bX63I7Mp12t9Lh6mJNRnzCN2h?=
 =?us-ascii?Q?AAf+uVv/e5Cc76xorx1VCDh2Ht23sD3h6ALMmJP7xLjoBOIfhpUEZmFMETHT?=
 =?us-ascii?Q?qLYQu27MEFpci+u15bUq477ZYsWGVqpDOKXODrcHZELQ61G7sCB1HSzklNQA?=
 =?us-ascii?Q?g0OTRgOACG8VHXYlUa28HhYtASq3D/NNGA2UjVj769q6du02nQeU9hOJdmqe?=
 =?us-ascii?Q?xbAyMKQlGMg05S4bjII3UgFGSvhM8Q41RX5ziKCi2RGD8OPogSCGeuOuRhdp?=
 =?us-ascii?Q?GawGC7xfPewp4uODgfy0tNg7T6wGwqqeyxDuDv+NHe+msaAjAoPJgY5yt/rC?=
 =?us-ascii?Q?LNIVwlDiiR11QLPOSv9u0UW/DNXMVggoUrgBvgdjBEKUhEpx0EP3ocwv1mE/?=
 =?us-ascii?Q?CoM3OCDeR3nBG0BJj6yZpC4Zwe+bU2udN/uOTJ+pthKaFCeablbdAqmWoRm/?=
 =?us-ascii?Q?FRz+UQgSqOOMth19EpB8E9czPzshyc+D3DvkSxAcTBxGG7HYdXpsIKCLgthe?=
 =?us-ascii?Q?qHMr7A4IqJu5FWwg5IiCLYcAs7bdFSKbhqXIFPCE5o6dl4JTF6nu3rZy432B?=
 =?us-ascii?Q?HgcPXVxYnqsJUpx/pxAn0o30akM9BVUnydVF42myKhzwOZEQExt+yVnN2aZu?=
 =?us-ascii?Q?GtfReV0aEwFS+KIwz5WxKiXVD8GjqLD/p6GnYcHLqDJZajj/WJtxOn+dSQ4f?=
 =?us-ascii?Q?5P1uVK44I/VGNoI4sLV0Elxs/AW7cc1pKcRHyWWVyc7kXoNLcMRRrckjAUjf?=
 =?us-ascii?Q?D2sR0PzR2qYc97pWebWoBC7z6FvaB7N6hftRxHuhcOo8YvTRzCMIT41vLzye?=
 =?us-ascii?Q?s0BSf7ozPKQdRjkPKKT9kaBz8jUCNoNKSDqKvfQdQCShpBMndKRZAM8k2mwP?=
 =?us-ascii?Q?kqYDY/c1nrpwrh1/M76aoQD3CqpFe3uxPeXz1EdOXXYwXklmvn49EHnDSAnm?=
 =?us-ascii?Q?hUViFdGDBM0BBjoBG0pjeW+eNvZMm2SMUGLFoOIJ6IJ373rpMAK3qyv1OA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1RiwPgsCO3vAz5Eq2T6glI3LKcLJQSUkeQnqiIkTci+z8WA20mAg5goKJQmz?=
 =?us-ascii?Q?XMmmhLVyXAPKF9BS9Rx6orepQ/DL0p+Q2zONggKxTOnfFiUeWI87vN152NjM?=
 =?us-ascii?Q?q0ZcxVknatJmCFLuZHeXXhCVhjU7g75IAMDMKLk9JV1G8R6UcL2AdDVkfR39?=
 =?us-ascii?Q?dclS7Fn4R3fsbRw6Ufavwv5mtLCY+bwb+v/77uvZzWn1pj13I+hsIEqEhZnS?=
 =?us-ascii?Q?V8In8Wl1f9mhwqFoEHXBxLuhhYSVc8rLx3ABRFDbVgF+GRAwJIsCLc1VOGls?=
 =?us-ascii?Q?RpDPn8c43nj02OYROY5u7dWfCs2586F5cDYegntpenFjyaRJ88VL0dGVLX0d?=
 =?us-ascii?Q?XF4HfZg9mblv1DyrrHVKDPFvKnlrTonI2pQPAJzlNeiiyEGx8y4ESc1dVW/1?=
 =?us-ascii?Q?QcQDfZGNVuzhhdJZIV8f5gy8/b6OupP5jJfqcCh++0fGRoKirwDrpNJreAUw?=
 =?us-ascii?Q?XpV3rchqWbjitBsU2Mhmtpy+2gC5+74OMb/osJkx+r8whFIHfuWBAlx3Nw9M?=
 =?us-ascii?Q?rFuoP9rs1QJcVfZawajTg1l758abon2l/BYVIzwj8xyAPJgcbQYC7/R1h4O6?=
 =?us-ascii?Q?emLGACYBhtttvkmM1itdmDoeWCGEGN5QRaHtu1nJ+bkFqWj2pZ0ny80ApGDS?=
 =?us-ascii?Q?vDsi2KoGYukN8S8vSEISuCyzb/W59aUz1iUT/ali9kTwZrCZhfTF+BP+Imsq?=
 =?us-ascii?Q?MPbmZbvuFfuD2yBRKdXSP1bPrLk/ZNK2+zRfbuourZ7DoRAg+53HwpCnObxV?=
 =?us-ascii?Q?POzW3Bgl9H+MGxZM6vIvHgDlxOYy2ppKeHW/ORgvPwdNhr++3oUKBzrxDbnk?=
 =?us-ascii?Q?5Fz9BZcp8BUFpqSpvikE9NglkqxmVaqDt2aeG+vKAxIJXDIDWmKthX7Zsq51?=
 =?us-ascii?Q?d8fb8gZceJSRGJtbDHM0A2i8//EHocislSn4yQoAmlr8so+8BJuGLT6BiKCL?=
 =?us-ascii?Q?f1/w8s+77yzxhQQvtJcZjaPVNfDKeW4oQYwRSyreayYu3avdbbROrC2j60nF?=
 =?us-ascii?Q?vl+3KJqcVxWouFTprUZwTQvHu0sER9ESI4KKoFfQFdvmxB6O4loWRU6yHA+v?=
 =?us-ascii?Q?3HvXkZ9MHsmzO2h3k/zgsobD5R+KodO9OTfJ/kW7ixgyEEmvPG43/NtlIzuy?=
 =?us-ascii?Q?pNZKCkSFBGEbUonTskOCK6Qx04rfY00JHkS7pH340Xp6/MSUTsmNcAK6nKaX?=
 =?us-ascii?Q?g1m9e79s1JI+MwxKHone2RPVfyTJP3Y+Dyn707CydV5Sli7XCHjk5/MGC+xh?=
 =?us-ascii?Q?TQaHdJELfpxmqKk4IVnbFsjn8xNPnZLDvaI+sk+Qs3c8Ay/au6VcJyAPN6dd?=
 =?us-ascii?Q?7z+xcdnIiexEjN6NuahshxiZHYDCZZXuXJMZmUSMRVS/PzZCqxghVdVkWDqY?=
 =?us-ascii?Q?JUHbWmWiLAeZfrcCc/j9uaNrS0BOQ0gj6+OUC1dX8T78wghTnscs8+Bligu/?=
 =?us-ascii?Q?z9YHUb5MgCH34u/fb3+NsUUUFIrwr3eHp7vbhE4ZfMmWzGltc5vAi+o7M1Nm?=
 =?us-ascii?Q?r/ww0NWb0iTsoEBXQD5Zei1AHpTUaJIZJnVLlXjz4kp4U47qtoTb0/jCnqu4?=
 =?us-ascii?Q?v78Hb3rDdU5MoiQ2G2TSKc5U0YeDA63g5H7yfRDH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d650509a-4bb4-4e6b-8569-08de27167c0d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 02:51:06.0445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HjZzVDCVgv4AvjixXHg3iRbrV2x9cBgsUJBm9qzLOF1zeXhcontV6U6ubAdrNDsfuOfWncLFrn+TPXveVSTTYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR04MB11439

This patch set removes some unnecessary or invalid code from the FEC
driver. See each patch for details.

---
v3 changes:
1. Revert patch 2 to v1, fec_enet_register_offset_6ul still needs the
"#ifdef" guard, otherwise, there are some build errors
2. Fix a typo in the commit message of patch 3
3. Collect Reviewed-by tag
v2: https://lore.kernel.org/imx/20251117101921.1862427-1-wei.fang@nxp.com/
v2 changes:
1. Improve the commit message
2. Remove the "#ifdef" guard for fec_enet_register_offset_6ul
3. Add a BUILD_BUG_ON() test to ensure that FEC_ENET_XDP_HEADROOM
provides the required alignment.
4. Collect Reviewed-by tag
v1: https://lore.kernel.org/imx/20251111100057.2660101-1-wei.fang@nxp.com/
---

Wei Fang (5):
  net: fec: remove useless conditional preprocessor directives
  net: fec: simplify the conditional preprocessor directives
  net: fec: remove struct fec_enet_priv_txrx_info
  net: fec: remove rx_align from fec_enet_private
  net: fec: remove duplicate macros of the BD status

 drivers/net/ethernet/freescale/fec.h      | 30 +---------
 drivers/net/ethernet/freescale/fec_main.c | 72 ++++++++++-------------
 2 files changed, 33 insertions(+), 69 deletions(-)

-- 
2.34.1


