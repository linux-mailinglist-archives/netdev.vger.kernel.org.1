Return-Path: <netdev+bounces-132965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59315993F39
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 09:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B2591C210C7
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 07:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DAF1DED7E;
	Tue,  8 Oct 2024 06:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eR3tXh7I"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012015.outbound.protection.outlook.com [52.101.66.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9431176FA7;
	Tue,  8 Oct 2024 06:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728368871; cv=fail; b=ny6UZfuTNimNpKNbZ7FkQ4u4T0IQi2f50kz7sfPC3kFQxatCxwnuMJxu1w2na+A4AgxZHhnasAhfFktlON2I27E5UsdON9uJRWKFZiYwt+OHoZm2CQKcYWyDA2d2HnSpd6pn85wWp5aBKAOGoyA0+8AJwHKnvXhhwS4qVGsvBzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728368871; c=relaxed/simple;
	bh=ZvUYNmY44trHqLoTU6pv1v9i7xNzNZlGK5abIklPtFc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=t+sTnL8LW2BWNOw2nBF8dZHhWgpfGZr7e7+SfC7WGqCYf7lgUonzjIsiMvoyrY2J08TYEOuis57JUIsItnU1Z+3iqrtw7O4R2U/k2NMOTJJ/xkfTEBihB0FdJBumgzBJu0bYVve8df2a6m5zJBk1be/1x5XTbFR/UJ7K+CLlWpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eR3tXh7I; arc=fail smtp.client-ip=52.101.66.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lVQ/qCR9oeLOYV1Cb34zFdOs+GnJ4+KaKa1k/wZ2DVH60KncSk77hQvH9BBbe3Zr7HLtYRIv8SoqKTzhRAsvggDaiKWOmDTRFCEOolJ91PvCqnmfTGc5IvTWgK8ygpg6kdMb86rrVrnPyNmFNuFypxo+iqETH9hzO6RTtTRq6nf87zHlDGHz8IwUzpKBc/b72Wtd1lK5NQkMk5/MVOV2XoTnPKvoMVrjfvPPcd/o7fD6Jga7pf455zQ6qQFJ623xY1C1hn+xtaquLGQPG701/KkV9shif05UVe5AnIMxVSKpsbCyNjW+d2T047f8eLwBe5eeyRv8J1XtbTDF/9Et2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZptgwN0nlsw8Pa5N3Td77WwPhTzmO5puaaKFNptaSHo=;
 b=spUb9MhfjPSPkQxrcjukqV5zDzo/glXGY/gAoK16hOIclggw8rf05peX/gfOzv3C+CZ4h7bvT1Iz8HYG10e8cEmKzlp9GicFBd3ApDVm0qlxqXe7dy2t4udnfw3zpXV+zxSpj0n4MK3dHprtIX5vP/oRZQNC1CHSudkU/tTZsuVLoRAkZ33wNzfCRinvftvU8X6SusD7xLHSvdJYNwOgBmf1KTLqgNXZd4HED+CMNmZ57Gp7ORGg+cqcq2L7dFTkJ4Oh9RLfS03TT6dIMDijRie9x8+woyIOEvLfBxL/i9SX9hKfSoYvwcjKKUw3JYP8xK1QOysvV5TzZVLGEIt2fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZptgwN0nlsw8Pa5N3Td77WwPhTzmO5puaaKFNptaSHo=;
 b=eR3tXh7ImcI7YpcBlAM43O5yqH4oAf6ZLoPHWvcMmx5oWp2fXYWaODF44Iw1DippOfrVMNg7V+eHEZre4qd4Ysb9B8rrLD6QGOA1OSjwrVRanEDI+avEh9api1lLZpoAxqMAKuwh0QmVWLBqJIbcwaSN/K8tcoOU+T3JIbbadez9N+OyZZeNO0r5CiVvPSbgvPWemVrA322+xmyu8zKHCwWoP/fVBBugfW87r6M9bxhMBWu52cDn7LV+eZCGMKsWIxtT86NcMD6RgUqbiZv31cIbI1urkbaRnylDKGZTZgTr6peK8L8ofSmSCtziNz2zyCVAZhKrJPqQjeTXcEBMEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM9PR04MB9004.eurprd04.prod.outlook.com (2603:10a6:20b:40b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 06:27:47 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Tue, 8 Oct 2024
 06:27:47 +0000
From: Wei Fang <wei.fang@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	csokas.bence@prolan.hu,
	shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com
Cc: linux@roeck-us.net,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: fec: don't save PTP state if PTP is unsupported
Date: Tue,  8 Oct 2024 14:11:53 +0800
Message-Id: <20241008061153.1977930-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:194::18) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM9PR04MB9004:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b88b632-7f1c-453e-aeff-08dce7625315
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Uog5WqBBhUaWssEA1hw3PfT+X5ilqgyyA227YiKO/KNE26Hj8mABjb/INHLS?=
 =?us-ascii?Q?YjySf2cII6cZvn1HxSJrD9yglEhh2IfAD5W5ob1JOc8yUw7AKpB/8yT7rlwf?=
 =?us-ascii?Q?J5ldbPfu1m5cniuzAIJwQUcGyuzIYbOpa1lgq9aJ4UpUDHbHZbm2qzecHwVs?=
 =?us-ascii?Q?yMaVaKBpFrvh8bKOHII4e8UqQtwydvahYVCLF4EYQWDVi7GVm5Z557dSsHwy?=
 =?us-ascii?Q?qIn716ANAIbNEz34B9xVYOrGt/CmHp+U9e4ciiAUG4bUO8fvUkADpRCzS8GE?=
 =?us-ascii?Q?lKCiLndZIop7D6SVgmL1PqI3ihrcp+es8puBAdvYcUoK24Gjo10mkgj3r6Cs?=
 =?us-ascii?Q?/V9wL4gxQ6mXVz0HYojAYxEeI2x/5T8bQn37qfu3DcUqMq7sFf4rnOT7rQDP?=
 =?us-ascii?Q?MRjVstqMuv9lSkt5W8xrZtaregRjV2ab50sK2UjW4KDfrHUBXiN4lr99S69F?=
 =?us-ascii?Q?dZB6a5O7e5NKyuMAp/6ZaFgi4g/DelYEKX/bB/Px1JO1MOk86aptugUUUcrX?=
 =?us-ascii?Q?WN5nL2DnyZx/wMzOAWxbsCj0XbWmhmwvKZpMsKpjOYSvxzEof0ocVrbIZUDO?=
 =?us-ascii?Q?j/XOXUYc+0bHxRfftcUArJGYJ6iHvKcryPtwIDWnOg93RJ9kJRmbzQYXrHVY?=
 =?us-ascii?Q?pf7UH9Z9gAZYKTdszdnbGANcu653iOLUTyAXhcR8DKajxYX/nqccW3WXb1f/?=
 =?us-ascii?Q?xxA6cUk0WW9uotC0mf6JgCvrlKZoQDyvbcocZC2eK4Sx1YsLxtNTdxlsgLfm?=
 =?us-ascii?Q?UZ2pTZa38fa/eEJ0OFu3Xez8LfGKv2EioB+Va5Bs6lSvpecczF7req7e+Fue?=
 =?us-ascii?Q?d4DN/vkrRkOeQt111fYA/ah2PB/RHMjgJG4DP8aFyD9vp82L7lcEEhGa73ru?=
 =?us-ascii?Q?E/cDbI4IeP4d+B3qkOi0VK+1X0xOsBznpOAluBSflf6fHGU6s61SsB3RDvmG?=
 =?us-ascii?Q?prg8jFl8EFo7Nx71VzfdSPbI7Fi8jVwN5sGrcm10b7TvAayhr8mFwivOd58M?=
 =?us-ascii?Q?6392zDzG6BAD3ih8U9BQME8vStPevF39kqVHJbJWpBOZjKfNxBhkC0JyzbbX?=
 =?us-ascii?Q?QmlYQzQXkDkGz9ABzjxm2Ou1jUOGBefRk66pi5tKF//KdeggZXdLOIvVjyDP?=
 =?us-ascii?Q?/81nm9HwdphzNcPQ8HXgMwXYf7uG0ntulbZowoPfDTHi43jk2OsrpxpFW/dw?=
 =?us-ascii?Q?jkUuCqg08bGsX2SHOrPpTR3RGzDoBMq1oWgBMa2+bVpuDPcCgce9ui0jVbIF?=
 =?us-ascii?Q?RKjcT7mJHywlDU4/T6+4vGi1Cu64ikZDT56gCcf/O0OWnTr6MfAFX4SGDe+O?=
 =?us-ascii?Q?fB6Zb3/aNe/2cdqJgTQiwcLUoV287kgU2sKTCJVUZJKJYw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e3z7Qi2OtPaX6+V219dpSnjzKoY0OFD+QKtJjWpuIYXpUECisfZnKf60S/LL?=
 =?us-ascii?Q?1lH0Jq/d4v+f8yAy7kE/u0Ls1ekPAuIjl2iOD/M9yn63NXwd0fwPe6hk97v8?=
 =?us-ascii?Q?feR4zPvIInVXIExXe2BOtwKKfhv8TDenDggNMumWpuGqjtQto9qmo/cXB9mS?=
 =?us-ascii?Q?Y90F4WVb0l0X1iWTbkh1SOZC11xV2z6WGd6vR9nPjyK8FQRaqsVPXRLGxYpr?=
 =?us-ascii?Q?q/d8xDWDt3E6Mam9C4E5gA+Ubjpi6+qSfWJDfJ19NBe03DpL3lNylDVHnkgU?=
 =?us-ascii?Q?A+/vZ7jQzSUiVFCFtnY/I09PvYIa18/tq2SC5ZBdWLL3FAInDMs4r9RuhW3F?=
 =?us-ascii?Q?Re9+RP+cgusEOCZIEEiG7ZdoFWK2TvciBNyhWUobydZ6YTeKNwV1gTCGLjp0?=
 =?us-ascii?Q?RgAxM25JHHcGA042IbV8stmLbLuO97BTLI3mZATiJAwoZ/MTlZegl2QI95du?=
 =?us-ascii?Q?+PVzOnTB+UmsL9RpujQQqrPlUeeX/ynTFTBAYAymv3TWd3/rkL0CYSdop0SO?=
 =?us-ascii?Q?JplSzZnm1JZzCow+L/x6+Kblw2Ajq7ijQcRhry1cHGA/XRFQ1O4FPA1MB4Kn?=
 =?us-ascii?Q?ymBNaH46MXCFkdmkUjHnUnEap5Y+4QQXfNS5uM9XpUJvWm6RisZaz74Mmjgy?=
 =?us-ascii?Q?IFfxUjCK/kcJXoVpFLniUpCLmjneqAyiQptEUeEJASl4Cwa1/79v6dMaikde?=
 =?us-ascii?Q?lydZ2Xeu07byfaTqpXD3AOURW55upAGiCNn+qfnmpcuREo/dc9wBT/zTuctd?=
 =?us-ascii?Q?pjpyUzRByauSv5Gt0PiPT6WZxQDEEn1/PR/REl5bk/Q281hCthficqcoZAxM?=
 =?us-ascii?Q?H6GUbfcw+5W/K/nMJhwbBQS7ytYukrFIBZsHlnR5wwNZabuP5noKqiBZXNT1?=
 =?us-ascii?Q?Mt00QZzWkdpr64PRC3U7eNcPrnrfksAQDugMtaQSe52Al+usnYd/+Y6SxSz7?=
 =?us-ascii?Q?g1zbL4hZRgFTYIPlADrnjFqL7TsGtXONNWHQz5wi+ODncKSC67peF1If0PPV?=
 =?us-ascii?Q?m6JqjxUUunTfD8azHCukc2vj+Qdkvrf6BlUKmwFrX14gv7PXP7cbUFwg28Nr?=
 =?us-ascii?Q?hB9Qp2xlSM7lFCJs7Z3rrpmbLCOM979ZYz7jQkRHeDjrEHCjINWfPN4Kfx4N?=
 =?us-ascii?Q?ISGOBgbxkUEXxQFK0Hnxx/ZrTdJ4ljM4kHW1B5v6NobIoeB7oQ6P9cQ+G95e?=
 =?us-ascii?Q?swk1tqKCxgmcnRajS7j9MUbaufTMkqFFG5gGKJmwNVt2mghJGl8qCcJA+FkZ?=
 =?us-ascii?Q?5jTmMph6giMJcYgqQTcX/21MjOp1bTXS5ra1K7SzMhQFfTh7XkQ9j/AYUMXw?=
 =?us-ascii?Q?9jhCmPo5HvI3lSWZAbu/w220gEZMoE4E3sV0dUwG/4OUpPechvvO4h+bahgt?=
 =?us-ascii?Q?ZT2NKd7K/WBEVOCRHWTDBvYw+PInqOp0FMiFXpmUxC0ZRd/xkNGVMyV7XzR/?=
 =?us-ascii?Q?pKryJMybLm2RvOwLWSWBwGqkd8fbJoQNJPwI/G+AZhsLiSgpqTWU+EZejJ1j?=
 =?us-ascii?Q?uRSZwSYVPkqdXwoQaxxkTtzfvYFo/cTWXLykplE9ed0LZ0YTQCj1UdWo2a8u?=
 =?us-ascii?Q?/+3KJuSJqjWiPBDFahtZj3Dx3VR93MEFUGGeCUoV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b88b632-7f1c-453e-aeff-08dce7625315
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 06:27:46.9701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SBdw6+5M3or9VPHKtMrqSVshfWzoS2jqd/FcFY3JOCveo4mToPF9vaJY8EfH0kzWwmLvfHjncGxd3L0fFb4Uuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB9004

Some platforms (such as i.MX25 and i.MX27) do not support PTP, so on
these platforms fec_ptp_init() is not called and the related members
in fep are not initialized. However, fec_ptp_save_state() is called
unconditionally, which causes the kernel to panic. Therefore, add a
condition so that fec_ptp_save_state() is not called if PTP is not
supported.

Fixes: a1477dc87dc4 ("net: fec: Restart PPS after link state change")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Closes: https://lore.kernel.org/lkml/353e41fe-6bb4-4ee9-9980-2da2a9c1c508@roeck-us.net/
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 60fb54231ead..1b55047c0237 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1077,7 +1077,8 @@ fec_restart(struct net_device *ndev)
 	u32 rcntl = OPT_FRAME_SIZE | 0x04;
 	u32 ecntl = FEC_ECR_ETHEREN;
 
-	fec_ptp_save_state(fep);
+	if (fep->bufdesc_ex)
+		fec_ptp_save_state(fep);
 
 	/* Whack a reset.  We should wait for this.
 	 * For i.MX6SX SOC, enet use AXI bus, we use disable MAC
@@ -1340,7 +1341,8 @@ fec_stop(struct net_device *ndev)
 			netdev_err(ndev, "Graceful transmit stop did not complete!\n");
 	}
 
-	fec_ptp_save_state(fep);
+	if (fep->bufdesc_ex)
+		fec_ptp_save_state(fep);
 
 	/* Whack a reset.  We should wait for this.
 	 * For i.MX6SX SOC, enet use AXI bus, we use disable MAC
-- 
2.34.1


