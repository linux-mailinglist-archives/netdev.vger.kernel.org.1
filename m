Return-Path: <netdev+bounces-212046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 094E0B1D81D
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 14:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C4EA1760F5
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 12:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56B52522B6;
	Thu,  7 Aug 2025 12:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="jINjAgi1"
X-Original-To: netdev@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013007.outbound.protection.outlook.com [40.107.44.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551B524728B;
	Thu,  7 Aug 2025 12:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754570475; cv=fail; b=aANjZmU+SmxKi+7qd2gEkLcQG1MvrJfEsHnSR0/PiZBDfGbvLJXqdC7DpXQ3TawyTYIt3XbDlgJ4M6zQXlrRsPUOctnoliFR+S0i43x6lsHkWoXX5f+OQOzDjQqpiGcAj98BHAJ9TLo03cfDkewNDLx9IMX0JYdVuWD6IEA19wc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754570475; c=relaxed/simple;
	bh=fSgTeeZ6xS1wbURk5WarpLx7S+2sfYesJLyBaE+hN7A=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=FeJs1RQATyy1M8ZR6DGTtwgtn2BnLhX/FTSOvud36jXQaHugTXRsIzTaqNXkFQPRmISzJSApFfH9KY7tVVpYwUBgwDwV+yBHmFFmdXz/xNjDa4Ne4T2Q0lAsLMfSKCfol8ihPiPO0OO/7o01xTir2DpFEGX3KKSQ+QNC9xbaprA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=jINjAgi1; arc=fail smtp.client-ip=40.107.44.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vEgb/k40SZ2gZHrJ9gm/NxJDUsy6UxHS8KpxdQZWfBq1H16IHuKEGqzOFTj1Be9rEUiskr9dKHAGL3rNPUJ8In0+4zF/l4dcjaeuCxsFYcfK7MO3nDE7BuGF4Vpkr+3OYbP8Zsu+W9JxNJLWyAxKXo0PvtGBxZdPf0WDPwt2aEZq/uMyD9axiQjrcAjw6Z+wKwkq0T2xiAW1wxW7NJr+0hrXbpti1A/I7E26BK+lTAwHiP/L/LhrQJrrPSoDba468gGQxfxECPdTZ4dYk7yPgbnFTQwtR4MTiK1m7bmDWEiUKpX0CJHVYBgFjgPKa+ACVS7wnkCzd3cK6h5V9NRnKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZLrig63aqCGzWKFZPHwYMwhO2/LnMytvvPSrVuts8o=;
 b=TBf8v7KjkGvUHDUgsF4BPAmXe1tgl6Cpu4IN/m1Ut5Spp0tysCpfChDDchWPWCI6eG/xL0vc6cktynnNVOcpGppPmpuY9bBKOxqjyadltA2vWbdtAJTfLl+69v1mfF9htk1HZG45dCPxM1t55lfTCD7nMRdNK0y3XK11NWr3+EgZkeVcgvUXBTqb7ovQvbtK5hDouOdza67gVPHTi0ogkEt4cP8v61RoyZct/7c+D820oLTJojXuF8ppTPbnhjgaUFyX0CLy7YOyYQ9lBwLCirFwrKj93Jr4vaE9PuirB9JGy+4PakGB7DDfCjTasnRzMF6jbS3CXsreLrXYRhHVgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZLrig63aqCGzWKFZPHwYMwhO2/LnMytvvPSrVuts8o=;
 b=jINjAgi1zlOzga8ehgWLduO+JNgSbWA+vHPorYI/b35drs/nky1l7i62l6g86REuoemsf4tYUxYoWXy7V/3Bs3kAjtouKriqoLeO69gCP4KdkTCO3/1pUEDcpHje5R2cLowBVaChqLTilX46YPb+8Loesu8+78n6zeQXxaVD0kGkTwx7o2DwVcinKZbOGz/zd2pqSeX5AIrot8oqjUZ2U4m0zEwD3e2baqM/s4m1M1qNdYETowr0tnGc7wbj5Gk53A40lEWJsjkmjyWf3z0seywjqP/+Mmltn9eRr6NQ6yY5WFoX/3Up9UmOjFagiHr9Zcz0YLdL6O/m60gXoigMsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by TY2PPF70F768FD5.apcprd06.prod.outlook.com (2603:1096:408::795) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Thu, 7 Aug
 2025 12:41:10 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%5]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 12:41:10 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org (open list:CAVIUM LIQUIDIO NETWORK DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH] ethernet: liquidio: Remove unnecessary memset
Date: Thu,  7 Aug 2025 20:40:53 +0800
Message-Id: <20250807124055.495489-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::17)
 To SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|TY2PPF70F768FD5:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ceab912-f5d3-4217-6015-08ddd5afafb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FfvqD5mmVPXMh7WPIeaXBigokHgX5g5TAEqFl+jgWMY0GkYrniLKyc+x3Tq7?=
 =?us-ascii?Q?9tK4N+0DU8bQQ1SrFw2HjrqDuYf1gbE4eD7/qPGvUMv67x5uosqmr2/oC6pH?=
 =?us-ascii?Q?bI9+oNoXO2oRnyhapEXVIygysE9jYs8FiGKfL77SM46DtNt+JNKf62CHclRl?=
 =?us-ascii?Q?bOKcJYYrt3dqni1ssMHtRr42PUhPnPWSp45sBaJF+g2MyxTXiC7di1Rv9Mw/?=
 =?us-ascii?Q?2gfqh47GcfbAKK7kkWyx7ouYn2enNgMlO2Q5H0TOEV5A7fBl8Tw+draE7vSX?=
 =?us-ascii?Q?90c64lN6rZXPHJ0sSaDVzRiEcUK2OybxMaZObGg+q8AP6fst+Pu3ztoMkP15?=
 =?us-ascii?Q?fjIzCiY2jtpwIV1hT0qYN7fCjXpaUWGA01LznLr3v/amZoca1bu489zxyqoG?=
 =?us-ascii?Q?r4A+oBumdo5CzGCU9U7Hjj0yfliJFY1uUuS/NAHmDRSIkEEh21CwWVpkid2M?=
 =?us-ascii?Q?kbe7k4ROGctADGG/zS8PM+h5YC6tTGMA8SCGJh3f3f4T6krkDFYAc8Xw1bAc?=
 =?us-ascii?Q?LrnBXahNYN5VnyiflVG1PUuc1hEV7SryDsBZm4pnYd6H4ZHZYSG2RABMYBRh?=
 =?us-ascii?Q?Yo4XxU1eZ6UWZA5bS9z16qpb2AfFD+X4DlkCG7C1k+Zvicgevwe7Vy/BMII7?=
 =?us-ascii?Q?mz1DVFMZduOuP8q4LSNOjMKSMv6GCaaDggSAz0dg1NWbjBaMPAButt/OYkeF?=
 =?us-ascii?Q?GZ23Lh0dV30njAZdkPwG4gRQfN1ry38T7pwlO3bv/9dfOOKH+qDvcqpicfXJ?=
 =?us-ascii?Q?zTrpf6yhJcriDon0c3uFvkp8zII0+s0yaAeqbRTrqiW2AXOyV4ujRF3PqzAD?=
 =?us-ascii?Q?6UO24jpAmMh6gZVk5QtqWkBiHxTu4Anvw2ziQcRVLGE/uxs/jsqexSclBYlt?=
 =?us-ascii?Q?wGoLjJw2vBx3r3mLs7utj4TlZeCXeWsFl00NLcjvdQdWxTDvkSzI8zdadKOB?=
 =?us-ascii?Q?bJy0Q67RL8YiI7h3c923lDUlIknXjkaTFCLH6WcenjRS5DxbRoicCvAYtLCr?=
 =?us-ascii?Q?W4Sowf8f//emp22XLbURBQ1Vj4FegiYcII4RdxyabLhScjdC+yZ/nL6ye+if?=
 =?us-ascii?Q?mM0Z7ClHzUeaweoXvQWTizpoDOzs2r/ZlDwkfgWN6MOJvseopP6evtB71JKt?=
 =?us-ascii?Q?dQ8yOtzBZ2ADAqd1Mr4RQCw7RJ04mjJIp2cXbZKascBv57Pciscg3GEgMF30?=
 =?us-ascii?Q?NUPsf6X57KM87RquoQ0Z3zh0VyS7DuqaIzha+swFRiB9N4cQZnbAlXty7AJQ?=
 =?us-ascii?Q?JGn/EIkm2tshxqr0EZad7wMIkdQhUqkJa11GQbbp1IHPCiyeoW/zdXK1dErT?=
 =?us-ascii?Q?IX3tWIex+DGsFft/FNQJpg8f+0pB5PHIKAe5r1MNoTYQ5s43KiduKnOkvdr/?=
 =?us-ascii?Q?F1Y0aLg3APowoEy+HXTZ1o+eGVEIYqdx5oQCxl5TSM1DpNi7bmURe99nLI3+?=
 =?us-ascii?Q?HMzyTXCIvfgKeCdL4kMaD7LnTYzdcyIKoLKQ9ZUCB8d1y0rXIfWTOw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GN3ByTHOlgkcJcE8IyudTWxR3TyJkomr6AL+Er367Hc3WbhDRbLGIHhZmbFH?=
 =?us-ascii?Q?pcnIcdJfazUjrKqlI1823ZB2IiCjJsdni5hdnzbfzwk9JSlmvoGaXVOqu+io?=
 =?us-ascii?Q?HZZty6IBAVmxLlv9H0cXWvr1Vsb8Ryqxxz08cQfLU+AVN8j6Mfl3H8g7wJ1d?=
 =?us-ascii?Q?EBRbhmydhIhbow45SlL/NSEt1VBl/RaW185OlaYTnB9GAT52Q/9jdSluculY?=
 =?us-ascii?Q?Uadow8dz+yr8gP/i26Q+7zbEovsTI+cM/v5QRWvFevJk7agcYdI/fxIC2x2T?=
 =?us-ascii?Q?GwkVAv5FjOLveAO9UNJdps/KBFqWPpMdfBmdR+wd2cqppNYEYvSsCnwMCuRG?=
 =?us-ascii?Q?UdnJeMUaJnX87IR/4m+5SaO+Ocwk4WRIiik5smvKb13l5i3s0dmhCuxORo/q?=
 =?us-ascii?Q?+9ia/6NxH6CyW4/5QH7f+xLM4h+eRo2UgjRmy8Nj3ZPWMIrKtXmURPG7XdCc?=
 =?us-ascii?Q?JdFwMGB45C4zobuNp9n4+D6spKD+txix/zcsc4r8xBW9+Md0aPPsW/qTIMNt?=
 =?us-ascii?Q?204U95TgG5NSnjaU/y8CxsfqYKLP3Th582n1LDwWxTSMUq3GN3r+WShIE60N?=
 =?us-ascii?Q?Lgt2Zpc/Mr/iQDtLIt0vfVh07CX5iyXDduTexsj27S29ezCxaUMueXBEhQVb?=
 =?us-ascii?Q?HxjXDFST7j77UZpUC9cEXuOsDoUxOvN+MRRVmAPINDID83qww2ysC5vsKfFs?=
 =?us-ascii?Q?FYEbJgFsi+KfhgDKWfF/bTdC8FNMkRHwzUt1/akjR/aDcBuNUk6UVCgG6obN?=
 =?us-ascii?Q?sG8LJG8zXwhwdE0mA/Fe3rWTIqtsTaQa135sc5mG+DNBZjSVLP0b78ph+47x?=
 =?us-ascii?Q?RxplGbZKC6gjtD2Mmb+TCiq2J56uoJbsOetV5ZoSWbaGZQXFwTb3BzF/zQh2?=
 =?us-ascii?Q?4yRJ2YN+pRW69SXMbSAZwfzxshTGc02lFpw8k1B7bxyRMznJZfnyPeL54aBc?=
 =?us-ascii?Q?pfVUMMzK6a8lR0kw0Lqv3V2zmUCyvLVWbNYaUNf1UKELwPczMWMQOX18NTi/?=
 =?us-ascii?Q?7KQxYkeE642XSP9ECDQ5nKABNtNHxDBbt7rIUsQqMliogOclx/l11RACRykp?=
 =?us-ascii?Q?LlAdG3jvndMZiqReMWHfnMYA58vnRCzo76Si/rIVwHl6PJJASzIgolDp43A4?=
 =?us-ascii?Q?LSgAVz4BlVwuOF4KYkHk9z0jYddTSaJwsN4xzbFXBfQiwSQ+YDlh7nZgbE7/?=
 =?us-ascii?Q?Vcxh1y3LekxtKHGo7RKzZLVvfZoGRmxUv8TsenA9R2k3fpNN+7TDY1kEsYoi?=
 =?us-ascii?Q?DIx5PPklNwT+bO1Ln9oUQsk0STgGq442m1ZEhdyoKGx3RPtm4c1kIRt6dV2A?=
 =?us-ascii?Q?fyFuHsJaXAb5iVz9h93AGg7xsuGrdeJG7Czw45rD6wkh9mwY3V+T/4hj50nU?=
 =?us-ascii?Q?WuoHeqJEVjnz/GeLNKdW+H2qzx8cA9E02Z+Cm3NmcwthETJlQ1NCMeQaFzVm?=
 =?us-ascii?Q?M9DRaMbbUbNcLri/wlvVzVs16lRXJcQY+I4R6yREjCcdrtpJdU0y0g0dcD2h?=
 =?us-ascii?Q?nodBcAbMiRtqrrza1eU2UpiVXkh1PR5FRBTBxL7UXvnAYoI6SajlvV1uy0Bz?=
 =?us-ascii?Q?eYFejUnriw1v8Zfk/wwFZmUV6/L2eUciD2rBdTm1?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ceab912-f5d3-4217-6015-08ddd5afafb0
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 12:41:10.2206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vgONRnnoXy1dMMlatKbTH8PCJMZSQzvDx5ICCyPYadmKqiZ7OOY0rDnHmNc9IMvKP/sKOtNulXPS/GkBjb8yiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPF70F768FD5

vzalloc_node() or vzalloc() has already been initialized to full 0 space,
there is no need to use memset() to initialize again.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 drivers/net/ethernet/cavium/liquidio/octeon_device.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/octeon_device.c b/drivers/net/ethernet/cavium/liquidio/octeon_device.c
index 1753bb87dfbd..4d7d7a4da92e 100644
--- a/drivers/net/ethernet/cavium/liquidio/octeon_device.c
+++ b/drivers/net/ethernet/cavium/liquidio/octeon_device.c
@@ -893,7 +893,6 @@ int octeon_setup_instr_queues(struct octeon_device *oct)
 			vzalloc(sizeof(struct octeon_instr_queue));
 	if (!oct->instr_queue[0])
 		return 1;
-	memset(oct->instr_queue[0], 0, sizeof(struct octeon_instr_queue));
 	oct->instr_queue[0]->q_index = 0;
 	oct->instr_queue[0]->app_ctx = (void *)(size_t)0;
 	oct->instr_queue[0]->ifidx = 0;
-- 
2.34.1


