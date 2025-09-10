Return-Path: <netdev+bounces-221824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0185B52072
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 20:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBEF47B0EC9
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 18:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E692D24B6;
	Wed, 10 Sep 2025 18:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MO7aLsGo"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013034.outbound.protection.outlook.com [52.101.72.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1022A2D24B2;
	Wed, 10 Sep 2025 18:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757530357; cv=fail; b=moE/JAfkQwZ/KUlmKKX1vprPshX8jWKtIE0GFI4yZ+Ih9uOwgDWtN0GouRFqkxsaZUHyXxPu+mYogHL+w183XIq+f7lhbnQTFYB+cxXN6s0Ety9y+uJNzuV845f75Re14VdOBS43u3y9ek3coq6XF3ReI7O3P/iGD5QL8Tqp80k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757530357; c=relaxed/simple;
	bh=wyJRELyYbb/6Lr29fncMOuKZy37l6RRSnkiYPmY47A8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gEU0H+Fi4rkZQiCGN54OF+5WVpTJV0odjRIw01p4liyY6AO96NXn4aGlxFe0VRAi8x34tTpTRvq2dSOaCq9BNOEDDhgqy9fLCsHxhoXrg5s5TMCHhJyUojm9tVdN7pTBkiCNoX20r2vVSwUXu8BqYA6pElqrmeurqTz5/GPPe9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MO7aLsGo; arc=fail smtp.client-ip=52.101.72.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DPFj+wHBS4EdW9enq+A5/1P+XNfDJ44QXHR3AgJmpgoNJR9Ix56J6lQHEMwwtJh8Ak3LXPQvVGgrexVHuVztNC5kwN2TsAB6PK/MfW58oW5UL/GE0jJ8eyIsAXR0BqlNqy52oFK/O9iXMA2M7Pqe2FUt30wRufWTxYCfpy0/TflEZaZo4A0Cb7YFO2eAdOvutUjERmPEanGbz0SI359FcWkOM1sMsIu5rKL4sDKFKDHuqRvn6YmSFkrWZi1xqqminCVo9mCy1A7yuiR8FuSPJr6gbjfwnHovg4x5Cp0VFw8OdC8tqO90TqndPHRshBGfRymKzr2YuSRZZVRr/ONGtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HHpv/ZI+DOSHc6trVrY0xKnYcs3E8iW43quH+TH6lnM=;
 b=VLJlLiNbYu3f7UvRlpKWGFU0w9BSWJJW6iHjsD9hqN5+KUJa+FtPqDRzlK6flc5pMjXTYoEGqAV/frD6ZgpHx7SzeVp+Rg0gQM5iAWhF/bGU977R9/GXYTgeSK2YSjlZ3RTEX3Z2EK/FnxoZBknU5YEOUtK7PZWYPXpDGYLJefoJDSzoZHGY9tM9Idd3jfi67JWqsoYRMNfMHjg6kRwGPikAXHgMSD67repi3Z0kzYGB91pV1N5XyivfpDNk2keTFiniOrFPhw1+u1xCU3gi44GpcuP2Dm2lQWUCb2xsaTmaALeoU3D07zyMd0+gsX0dNqoVZsOzhqHlzm/JBGdatA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHpv/ZI+DOSHc6trVrY0xKnYcs3E8iW43quH+TH6lnM=;
 b=MO7aLsGoC3UESfJ7Zm74POCfMdy+8farAhFTMMJM/PWxBwuScE3pnOJO6w8IL7THXvJRfCj3WY/Y3TkdtFOLa/vPgbGwVq4ZgL+B0+uQS9eJ1WhAk1i1YM1DxS9l1s3IVn5EBB1zBB8a1qmcV0VyQPmIlBkTXLMCDxegvEigFyxUmZz+KbwJ6rt4Iv7QdQ1DeFAvb35VjNwUDDCWI6M50jZV7CPfsRfSd0xohLU73OhGPw4nw7W6Ccw1RaiH+RCnS376qw9qS38Df9AgGyNzEL1FA7PcgmbaTLFDhP5Fxha9taZqryr2Vl4hz0gH6UrRYwn6++DJYEAwfoRP1HV6lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by DBBPR04MB7724.eurprd04.prod.outlook.com (2603:10a6:10:209::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.16; Wed, 10 Sep
 2025 18:52:30 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%4]) with mapi id 15.20.9115.010; Wed, 10 Sep 2025
 18:52:30 +0000
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
	linux-imx@nxp.com,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v7 net-next 1/6] net: fec: use a member variable for maximum buffer size
Date: Wed, 10 Sep 2025 13:52:06 -0500
Message-ID: <20250910185211.721341-2-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910185211.721341-1-shenwei.wang@nxp.com>
References: <20250910185211.721341-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR17CA0042.namprd17.prod.outlook.com
 (2603:10b6:510:323::21) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|DBBPR04MB7724:EE_
X-MS-Office365-Filtering-Correlation-Id: 39c54597-3a3a-44c3-7331-08ddf09b3146
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|7416014|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IlSOL3HZhDr4UFrCeD8WUQTpReiYftY6hdXrlClgupmjveuuGYMdog0RPAL1?=
 =?us-ascii?Q?Bk73uGL2IEOzI/m/sJTkr+Z7JMSzNpem0F1aKoi25lxBRrvllGbwPa9oHUO2?=
 =?us-ascii?Q?FCTT6ZAwUh4AYsekXi5n/FQMktt+LoN3wkeg5XfoqauKGrfiSJFXUU9sNO7L?=
 =?us-ascii?Q?RKzRU0WD19oWoMmEDjXDQheqSeE95wN7PBq23egL8zXRYkYCwIM+RXr5p/c5?=
 =?us-ascii?Q?iS0/jhxPtcr2ZrVVRvHD921l4a7rPI8E3GeTPGGYhXBG7qFfcWSESRIoJGnM?=
 =?us-ascii?Q?P8LDic8+YXg/B+Rjf1ProcRzIUcBbJWNpO5MLrEvxS7/B0zXKUOuZuRaNfuT?=
 =?us-ascii?Q?El8RgKEsxQBTM6fNRTuuYjdWoLNS+ZZEeViIVSeMBSitR+47684qTx6UNE61?=
 =?us-ascii?Q?Eg+EknR6OdXuHtIfa2mdY/bbC4s6uCb+m70oQh5PoP/3e7mcSp+C4fI23biU?=
 =?us-ascii?Q?dsEwM1xNmSCF1y24Kh9GjuyYKBcqlOJ7iFEwnk5dAeSZ0wRfPwM4+X25dHrx?=
 =?us-ascii?Q?2lPXfhs/eEnqq8/ILelU/8hNOM3OMbBO0NZAydl3MCmcwU9PIHuffrv+A4J7?=
 =?us-ascii?Q?e2k63jVWk73o2vZk+vSy8QTOQBaMsQGMHiOVsHN/Hxr0U1BGL87mzIdh6pqE?=
 =?us-ascii?Q?w+OyqMwgSRfieUCQ+hPGcEFfXbQeyIfQ3M/qegzcBPb52eDTLbKYx8uNvC6x?=
 =?us-ascii?Q?aWkc5bbjDiW9ncvumt/OMKqmiZX1+Yf3CwiND53eSQ53ENVJQmN6B2DDxl0R?=
 =?us-ascii?Q?EbFROiKNRkB82RmBaPhOUtH3BdBRzBN4kX12HbxidcCyJ+D24qBVrIMtW2wc?=
 =?us-ascii?Q?n3I+e9wwzJ3d0eHx55kwOvIninK4aLr2O1fLaK6qSUVk8mBO9STbYpoNSY1e?=
 =?us-ascii?Q?NyCsF6dBqNkS0hyZs4TAZdc46ECUJgP/bZTzXmO2/+I74tM37iYA9PbIpf8Z?=
 =?us-ascii?Q?g6Zr9NcpXnkGiUVxJtqna8HjDaLb/HDOdlgo1EyodpHUDOB/5rBjKKam3FBl?=
 =?us-ascii?Q?L2R/UuzYqyQWnexD2z4PUZJyHpaGeJz59NkhoKCekQJCHhCyeXRBrDb1wwqF?=
 =?us-ascii?Q?S8rNNvjdktLLq9zF+m0+tr+Ugko67s42g62mrJfUKcSK6rH84GXOcIVijZNm?=
 =?us-ascii?Q?MfElfgrVeSdl6+vueyk/aJYSCksLs5teCwXN+zenATsvuUIwFKpQbAUNdZUO?=
 =?us-ascii?Q?JH4UprG1F5bXONuCSPp+15fwblVBPBfOE9U3bJME4doEAm48rhh25Y3MPwix?=
 =?us-ascii?Q?FkeoMx914wTEOKMCu0QRqZG9f2N6bTr3aGFyGh85lCXowGZnR5Z3NfVIz3eQ?=
 =?us-ascii?Q?w4+/OLnJvaEFGRYbN/8VZinVT1RfPizrmvsofnZCtv/tfNzR4WNpIbEA9C/3?=
 =?us-ascii?Q?Dv03AlGE9lhpFlBLQBSpFSVXMh9MV86LmbfxrvyNxl5o0Ev7lv5xrYWuN7K1?=
 =?us-ascii?Q?5cSfW54FvRnT537FcHJTvXFBt7/c/gBdtnJrdJE9iqmVQOvgYnnGLGi6Em+s?=
 =?us-ascii?Q?4BJ+txFHZ9SfPns=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(7416014)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wSMJsXCI8cTQUFZcZs2EAd05zsPpU+erbrHPaD/PFNm+dDhcEYJoYvVprOyn?=
 =?us-ascii?Q?WxXnN1rIGqwmm6ber1ednin6MGfF23ezgNoxyqQMUkkjQtYXsiq4fFEhkDxJ?=
 =?us-ascii?Q?Nc/LyIKGF2Z9hs4r0noM5fTBGgtO28tAB6Jjg4SqWOQ2lw+km18pL34akKp6?=
 =?us-ascii?Q?82w55IEZP37xXN/q7YiGa43MsbazlbrW3q0AtR5a8KFgxmPKN/Pt5VzKhgcC?=
 =?us-ascii?Q?7taWQCUG7v06F/mZSxRLOoCkOQpCV4viFcjguLjUB4XY/u/CGYX2l0y7Wbwn?=
 =?us-ascii?Q?OA0hmZgVIZ7llw2TGHI0bgbBM0BE365ZjWTbAmpTaOqx8Byu5ARw84lfpES8?=
 =?us-ascii?Q?C/ifnLix7gR6RoO9I58kCMYioJvj7eJXTOALEIXnImWAWLp6fMrYu09QTwtL?=
 =?us-ascii?Q?x2swvwYJQgt4kbD0zvueyTPQlS2Nvbq3CIr0y/hrpArwDXV1+WfvZdjDUaSc?=
 =?us-ascii?Q?jA8WlAblsADdl8gJZVxp94ykL5uizxOEmg2qZXJWnQlhh5sobu+kPqjnAnkj?=
 =?us-ascii?Q?UmoHoOmBVIWqCTfXNXfgy8yKVU2tUMX4cl+AXz7G6K7TsaTTxr6ujBmFBL7/?=
 =?us-ascii?Q?iC9BJYstOimsD0bg6yBWrgXi8Rgv+ZvD81vDF2WwMOFKYN0sSqM5NqULaDzW?=
 =?us-ascii?Q?XfuiwfJix4sfpZaSkP8DYZ792+Gwewk8pXxY16ege2SCVAfa1HmzTPGChfFo?=
 =?us-ascii?Q?UUHpN1j8lxFFE7CWXPDn1KpqVkTwh8IMLEiB8aVYFORUG8bszRkbSgpKggdM?=
 =?us-ascii?Q?GSEdy6fWwBjllcb+chy4K4oqRXgGjWYsNrRcuGJ+cBBdtNCs3I2mqhMG0tF8?=
 =?us-ascii?Q?sIEIKb3Yx5IRFhT3HHMMiU9+4x0GZyLbedLjplo2j49JX/cYEJ63Bx+hNaBh?=
 =?us-ascii?Q?6WP7oM/K4EKChb/TniEY8GSEOQ+FN89Gw+EpORnvAr6EZmiRM240YyDGwNj6?=
 =?us-ascii?Q?niaPZJkqAY5idHpUr5xyRZKj+b6GYNIJgh8Qy08rVURYxUvQuOX1AmqN7Ivc?=
 =?us-ascii?Q?ACv5IMKr6w55MMH7vQtH4J4Q82mUWBbNMFJWgNLKYfAOXl4nwWbP1WK7DmQX?=
 =?us-ascii?Q?XYXwTt3DwN/1VQ2pGsZYT5yQvnYBmWcbZLHJEQqL1gd9i77ZPsydpcvpJ9wO?=
 =?us-ascii?Q?+25chqhvU900zOlW5Xo5KQt8q/YPXzVuLQ02tnMm+pbaIVsP1EMHuXPyuZZO?=
 =?us-ascii?Q?OetgpoJfyKrfmZvfKp5lNdSOIHirEISkYLRrgwz8yuqs3Vf/NcB5E3KjEGEm?=
 =?us-ascii?Q?UPdBtsjOguw/ZkxT21//CxRfPRAFIm0sGofz5gIFTwGCRc43UtMSDXGPXSHe?=
 =?us-ascii?Q?387zShluNS0N5Ul7SQxsqvx+w0Jv/AXmdnnDddAH2CQx7sN8t11+HMqqYIpw?=
 =?us-ascii?Q?4WDBJZ4AdeuosRqAluxOLu4wjzZr1cJmyZ0V9lR3CQ122JjBdibx/2CkrFN9?=
 =?us-ascii?Q?LVVIaqy9K9RMK8pHn3cXf1U5jV9VxltM7Dv8uHyYh7JIbvhr42VQV7XejaGd?=
 =?us-ascii?Q?vFZ4n7dokz0H5RPTaOdVh1sNRt+2yZa4bFA9sQ2nHirT3dFlhP4cNul1M/We?=
 =?us-ascii?Q?r9atctQehZWMpdbr146NdRsBxOop9HJWaSLv+XRJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c54597-3a3a-44c3-7331-08ddf09b3146
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 18:52:29.8897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wWfDGY5yoxkh83Teym2AmOkfWagDDjPybuQnkVoWaTfN7Zse2zxiYDc7l5PHRQ73nnhuS9yRvdDu10xsiMWwrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7724

Refactor code to support Jumbo frame functionality by adding a member
variable in the fec_enet_private structure to store PKT_MAXBUF_SIZE.

Remove the OPT_FRAME_SIZE and define a new macro OPT_ARCH_HAS_MAX_FL to
indicate architectures that support configurable maximum frame length.
And update the MAX_FL register value to max_buf_size when
OPT_ARCH_HAS_MAX_FL is defined as 1.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Wei Fang <wei.fang@nxp.com>
Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 drivers/net/ethernet/freescale/fec.h      |  1 +
 drivers/net/ethernet/freescale/fec_main.c | 16 ++++++++++------
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 5c8fdcef759b..2969088dda09 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -619,6 +619,7 @@ struct fec_enet_private {
 
 	unsigned int total_tx_ring_size;
 	unsigned int total_rx_ring_size;
+	unsigned int max_buf_size;
 
 	struct	platform_device *pdev;
 
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 1383918f8a3f..93bd8cec6719 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -253,9 +253,9 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address");
 #if defined(CONFIG_M523x) || defined(CONFIG_M527x) || defined(CONFIG_M528x) || \
     defined(CONFIG_M520x) || defined(CONFIG_M532x) || defined(CONFIG_ARM) || \
     defined(CONFIG_ARM64)
-#define	OPT_FRAME_SIZE	(PKT_MAXBUF_SIZE << 16)
+#define	OPT_ARCH_HAS_MAX_FL	1
 #else
-#define	OPT_FRAME_SIZE	0
+#define	OPT_ARCH_HAS_MAX_FL	0
 #endif
 
 /* FEC MII MMFR bits definition */
@@ -1083,7 +1083,7 @@ static void fec_enet_enable_ring(struct net_device *ndev)
 	for (i = 0; i < fep->num_rx_queues; i++) {
 		rxq = fep->rx_queue[i];
 		writel(rxq->bd.dma, fep->hwp + FEC_R_DES_START(i));
-		writel(PKT_MAXBUF_SIZE, fep->hwp + FEC_R_BUFF_SIZE(i));
+		writel(fep->max_buf_size, fep->hwp + FEC_R_BUFF_SIZE(i));
 
 		/* enable DMA1/2 */
 		if (i)
@@ -1145,8 +1145,11 @@ static void
 fec_restart(struct net_device *ndev)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
-	u32 rcntl = OPT_FRAME_SIZE | FEC_RCR_MII;
 	u32 ecntl = FEC_ECR_ETHEREN;
+	u32 rcntl = FEC_RCR_MII;
+
+	if (OPT_ARCH_HAS_MAX_FL)
+		rcntl |= fep->max_buf_size << 16;
 
 	if (fep->bufdesc_ex)
 		fec_ptp_save_state(fep);
@@ -1191,7 +1194,7 @@ fec_restart(struct net_device *ndev)
 		else
 			val &= ~FEC_RACC_OPTIONS;
 		writel(val, fep->hwp + FEC_RACC);
-		writel(PKT_MAXBUF_SIZE, fep->hwp + FEC_FTRL);
+		writel(fep->max_buf_size, fep->hwp + FEC_FTRL);
 	}
 #endif
 
@@ -4559,7 +4562,8 @@ fec_probe(struct platform_device *pdev)
 	fec_enet_clk_enable(ndev, false);
 	pinctrl_pm_select_sleep_state(&pdev->dev);
 
-	ndev->max_mtu = PKT_MAXBUF_SIZE - ETH_HLEN - ETH_FCS_LEN;
+	fep->max_buf_size = PKT_MAXBUF_SIZE;
+	ndev->max_mtu = fep->max_buf_size - ETH_HLEN - ETH_FCS_LEN;
 
 	ret = register_netdev(ndev);
 	if (ret)
-- 
2.43.0


