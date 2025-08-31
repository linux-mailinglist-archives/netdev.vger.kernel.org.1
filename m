Return-Path: <netdev+bounces-218575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5030B3D537
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 23:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ACA53BAEB1
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 21:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2CA2522A7;
	Sun, 31 Aug 2025 21:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FbSUjojX"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011018.outbound.protection.outlook.com [52.101.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50973248867;
	Sun, 31 Aug 2025 21:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756674993; cv=fail; b=eDO2DYfNKHKoGzvoZncKxxQsiWAGem5G8GRwSNrd3PpCioIwq3hJ5Op3gDNjf8UcboLyntSJ992Nz+2A0/eIJbEF9hyrxA7ou8c0qIXlyQNBureLjksnC1pox1AHTo+xnbotihsMQk0cfyFv1WY9KPIODn7n7ehBewJ2tvQ4Fxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756674993; c=relaxed/simple;
	bh=N5Nmf0khp7HrYTcY5Kh4Cru8V2Gvi0r1aGA9q6F9W40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kbkJSyr5jt1ktnFQlAKsjgR7MR643xJ41kMeptdO45cyLQrkuhdkGdO2le1xK9/RVGUWxI/IqEOaIhX1xoP+pcVSIne8Dn/MlGYZQRJonihkRJDDFCgZQ7O9lIiMqPQFu4Z2sP8WktzvoohJVe3SMNROzFpPfmFC4bXZDdljPJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FbSUjojX; arc=fail smtp.client-ip=52.101.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oX2qi5Y495qLqJUefHMFgynrBd1BRWG/uOMWK2l52oKr0RKtAKRS9u6sb9Kp85BjYJNqN8tzE8JvDhO/AalF+5uhIZ5zc5K7433eMhpsYQPzyUkA/P6Lo5Sm9ksHJR4S39jWhT638LDV11YfXX/pABmmPwfJWR0ceElS7xfCFxOA7VBH2SEVNFipw+xlEoLmtiuaCWzTGxMACMLf7kzJ61R4ZFgp2xNJ/JloClahJuHwgSSCzVWvqdujmrCMKFSmi6SGknmWoI9Fb9/qaavZcSkKiSgeTYPM2LCBTcbinnsVOIWPKcir3iGwWHzqnFq5mAroEP2eIpaX+qeD+zfADg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yl9Lte33e2di4/jQ3oRErJx2keP0XVawSj494Vka6l4=;
 b=GxlI9Se9D83PV+XELnX1EIF1d/1Z3Lw6mI05YI2zbgPneirYyWPTMbrErZfbhIIBzRySDLKOgFXwgRnVdIdoSrW+VGbxt6IILB/U/lvbA0yEoyNDINNq5Q04HLK4bAPtsV6Cavx8DXiWCB/8qDEbERxuHBDkLPln3pXUTpRJE4zeLsSj5v+wQ6vuCbCrtqyOmQENEj6/sovV2+8OzStB/bsi9XycSbtAnn2O86JHUO1G1Pv3Nh6tTpOLy0Bvu/VqK4CmJUyYt/Zu3lg5l+F+T06D+YlOecE4+blZWjzB7Y/qBKsqeAmXm3C5Yd30/zi2M2Tb0sM9SUXdXiAJvem1iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yl9Lte33e2di4/jQ3oRErJx2keP0XVawSj494Vka6l4=;
 b=FbSUjojXCJMqoNOYSdvBChbPWHyBecW5u1bFrc5TDmM7StBPfKPJnPlvugyEZR9CllNN07Tkvge354eTDFX7tec1XVbIF885dMfxMuMhzhEJPTyAKYJmjgc/ZlJUbxdSsw/1GVMVfueJZvBahha3WRpUn0tzt2M92ojfpVkUkuFOUOPGA4IBIft0R/SMRsyupgUH6jtik4arZh+TpuRdz6ZNcGB4tstomeR0x3wCSjrYqOAAdgF1U11lDTDHMW3m9GJKhP02+pMWx2bpa1osEeuihUHaMKKFlkjNQaS1d7VF8FDdMwpbWuEKrS8BJZNWmjBJEIiz//0HTBicfxrBwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by DB9PR04MB8250.eurprd04.prod.outlook.com (2603:10a6:10:245::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.25; Sun, 31 Aug
 2025 21:16:28 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%7]) with mapi id 15.20.9094.015; Sun, 31 Aug 2025
 21:16:28 +0000
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
Subject: [PATCH v4 net-next 1/5] net: fec: use a member variable for maximum buffer size
Date: Sun, 31 Aug 2025 16:15:53 -0500
Message-ID: <20250831211557.190141-2-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250831211557.190141-1-shenwei.wang@nxp.com>
References: <20250831211557.190141-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0178.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::33) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|DB9PR04MB8250:EE_
X-MS-Office365-Filtering-Correlation-Id: 94d08be4-06c8-4dfa-11bc-08dde8d3a674
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|19092799006|52116014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WOE0oqn87nD0Gxq2EMIF1p+MJso4YMdj4bicasPW8walzZ0kNBlsYHDUvohT?=
 =?us-ascii?Q?wmp5Ma/D80x5LC5MZ+K03/O/+wHRgy79hr3dAejG0LB5fkEW4gFhEjd9OcBl?=
 =?us-ascii?Q?Jv8MlFhdawurR0rl8ZJj/hR/J0vAvuLqaE7wxcZVGWx79/QVX8JXdSaOa/3x?=
 =?us-ascii?Q?msHrs97ZPNwR1haZKOBrSmKvBoZMWbopPSqqpP6sz2iK2s3uUpjxAJJT+M4T?=
 =?us-ascii?Q?ZfLaYejCts1VolwKLtSLb+rQ8LlGwTAvYy7luRY+lJox1baOO/t4CJwGW+hO?=
 =?us-ascii?Q?w3cJhAFFiWEyqP5tRi4oUfqz/dxpjrIE6n1+50aoLLsRi53/+8b7zYfRUuC+?=
 =?us-ascii?Q?CLYbtG311OzgpkLjeoQX79qySVDUt24JAGwvl1JNp/PHHC5Jbyq51FrZc1y6?=
 =?us-ascii?Q?LfyA65mmE/Zdk50zifjnQJcgORu8zkjPaTOQE9tyL6I75fVqsFFsO9w/3BdV?=
 =?us-ascii?Q?K4dX60jhkz8gzBCUzr/EybNyQB9xnLkWOPEmbqVyg6SAhM5HSWsHmRx2+2J0?=
 =?us-ascii?Q?cuj822ne32avFwX5zor+5nnBSUs4N/BSxUHAnXMMq5SDzSjS5LrmSn6rxGwJ?=
 =?us-ascii?Q?rnwGAv+aVGjK4dEa9f/F/RgarlNmDiPk13zi87QXEUuJgTPFf2K6WzZ4FWAL?=
 =?us-ascii?Q?uC16edH9A6mZIXHCIwetXRaxNIjUYwdtBf1FYla2CJQFECD+l4iLp1PDJtIn?=
 =?us-ascii?Q?224bzYEoYXVc9tNQciAdfZfmQxmJEsq7Zs5v5G6Q5qTZVXtSf6RunrSmC7kL?=
 =?us-ascii?Q?hO8bW6+f9EcU/Z+6sMcuC0rlJwHLOmJJp/s0A7t338XHOzP2jkKM3Kb06Tik?=
 =?us-ascii?Q?PNlIqu1s81RttKpi1jIuxZPOAlpQydk/akjNk0FZXd5M3dXSuOMAcnUpwwEV?=
 =?us-ascii?Q?mOkhofGf75mIEWrarFcdbIgLOIYsVvwcjYVHJ+65FEkI2qzcCAtkSUZh8iru?=
 =?us-ascii?Q?kudK2c1UDRzKccZlS4u82rVJ2mulTGONVMxZmYXdzlpT/5plb4fvJ2QnJ1ko?=
 =?us-ascii?Q?6U2MzvBSaPf2KBj0pLh7HcHuh20RLrNlh77Q4XftScMv2tUB/h5UmusgVHgY?=
 =?us-ascii?Q?p0C4wipg8rgHHq9aZmvS+PBpart4tErnTVcBddJ2u9kI19dc3jHjTdfBTN0S?=
 =?us-ascii?Q?AxyZN6ZdkooI686gd7gDr1hWsUMdJAfOwf+fdyyx1wiZw7DgAHtM4xBXirBP?=
 =?us-ascii?Q?pKGopXNqGSKr6ayN/TY1/2ULgowhbUwl5BVPyd4v9sN3bzwHnEw8JCkDp2A5?=
 =?us-ascii?Q?6CKv+3nkZK1+pdLtNPQ8XWM0lSboK3hI+HB1zubuCtooeMXITumbnelchYRv?=
 =?us-ascii?Q?roQ2pj4dawg2Dv2Mcr2JABaJLXBik1YXgQVUYtK5ILJcQJWPPmaK9xXX2cBx?=
 =?us-ascii?Q?p7bUzcPTPWvDDY9Esivk7/MmzJuL6Fpu+6faXseeICnZ+YgehtoaMeoKMErM?=
 =?us-ascii?Q?TDMVTRoh9wJhyqrw6QlRoyL9UzJUDB+nUZw6ixYZK38Qx4lJ0l3g67DsvPvj?=
 =?us-ascii?Q?tKWS71ilB6bbL8Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(19092799006)(52116014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OnNGnYdXL0g7TbuHIq6gETV57WgH00FQubl4Y0iRKszC/mIpj1WXbgHFGoNK?=
 =?us-ascii?Q?F7QiYRindNnu+UAm9mjDIoApJU9Krg+tN19BwVE6Fa3sN+fPN9UZxaylkuS3?=
 =?us-ascii?Q?KBKQBpnz0S0ws3ZnrRoAw/cjAH2OCZu7BqFy/ryc1sjqrd47nUBpt0vTQniM?=
 =?us-ascii?Q?BN40VCrzw9z6CrToN3URskcg3PleEW3vHwUFmrTyeqki2xD3PJ3r8gqm1bGM?=
 =?us-ascii?Q?eTEUEj5IlgBW5eGKwpXFgQCkQDYR0h5euBn5d2dIKc87iBgjawupg7e7voZQ?=
 =?us-ascii?Q?PAf+S0IExJe0srsM4A5lKnzBH11kEvVzp7dnnvlFcwmYW8sDzKcOy67k2z8K?=
 =?us-ascii?Q?MZxV1g1KXuSgZpJXOSroU3Bt2WgA3IoeSjoSDBRmIxL50PLQpwWf5whfDueW?=
 =?us-ascii?Q?9ZEcGNFLFQjAmNGi48NWvoVEyXXN4/tkAmCkznEsP6mHjzIoStW5JVvo1n1L?=
 =?us-ascii?Q?Z/9DyqmWFPDyhjim6+r2vWUWb5ksePD41dDSwKeJ5wnwRM9ZklnT8AmW1jXe?=
 =?us-ascii?Q?n8TkzoCHDouuIFMc/O/Uj5XBrBj1e4+hAP+26QEUo6oHNUOziVtpSNmFHt5a?=
 =?us-ascii?Q?ZJir+ut1CN7nIf5hn1ShkpdA+duiDN+TJK5v4OABb0qZGGuqjqkLI8dhiSNs?=
 =?us-ascii?Q?vbaiFLqHQ5l7aHP44EbUQeUHKfxk/LZSdzr8Ub+NDvjzN2c2fEk4dky8nKzj?=
 =?us-ascii?Q?Fz8KGuhL+rv7Ig8uLw2CwKhJGvrM5dyBXfLlSA7LDJFh5ZFiWjD1nJuLm75Y?=
 =?us-ascii?Q?tCQvkd+x3nEXMOnlcZz68YAjXJSvm2qx7Fv7BSJ0NKeXIphUlfTZgz69WGMl?=
 =?us-ascii?Q?H4zwagDEShOTFBzV7doHngsNjvnbToqheEcDyPgY0QWPSdsYnY5jGG/tUPHl?=
 =?us-ascii?Q?8gG97O8IMuukETj60ppnfBwVVAd0DarYN5pMf55I/wPuvYkYE4RIl3lAfwff?=
 =?us-ascii?Q?GI3HDa/oskpNdscBS0n0Y3B4aLwSfXl/EMU5ayY9wxr0Ksw/KqjX8K4T6crz?=
 =?us-ascii?Q?HhKeJUeyZJWleqwA2k+hfiiskZnCoT4EgT/JZpMS/jUtbW/f8jzQanB3l02K?=
 =?us-ascii?Q?qP9nxljxoF7rn9FoQ+3W9NZQ42qqHqH7xkaSkmQ6S/4LpCfcsttS6AomyW+k?=
 =?us-ascii?Q?Ec3YhoEXkdQx2bIVlpaTa4zM2pvfYfGaPTf8xl5x/Jl6+FznhxPEHoqkMnwy?=
 =?us-ascii?Q?7105L4ABnJtQ5h2M5dHkLntl5bIkiktbq5fCeY6dB2Dbp02fG8vtBsdSy1uV?=
 =?us-ascii?Q?9fQ1esp8crtQmTml+60WMQwj306EOm5Eu9KFa4+mJXfeBRkAh/ATCEPJtxXn?=
 =?us-ascii?Q?G1Y87b5SqsEvpLtoQCv8satmi884gk0CYFmqWMtXWX0EQqFkolTNkOpW3/x9?=
 =?us-ascii?Q?Py40wmRHmA5/Nxq+8S6oTPtAKhaLxZ0W4oVda21ykYjl2WWPAfIzPZB5cglK?=
 =?us-ascii?Q?H40xn/HRRBIfYpozFPF9VxgmPQzUKATetUFd5L/lP2ox2+vhY+xL6U3OZExz?=
 =?us-ascii?Q?beNfAq2RTf01PRPkYU0LY+Co7xZ+bJBlwsje0qEirxiI8bYELPkiEKReRHla?=
 =?us-ascii?Q?RjHTUufPBSO5jhyjN1Z4AMXFoFR7DX04QLoHtEvi?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94d08be4-06c8-4dfa-11bc-08dde8d3a674
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2025 21:16:28.6779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zg0hel0rEzCyHKsVMIY2qPD/Z+laHFyZudAf7UGfv42H8gJAzQim1xvETDldVMvMMuCqKcVEUCxtPMGD+T+Yzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8250

Refactor code to support Jumbo frame functionality by adding a member
variable in the fec_enet_private structure to store PKT_MAXBUF_SIZE.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Wei Fang <wei.fang@nxp.com>
Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>

---
 drivers/net/ethernet/freescale/fec.h      | 1 +
 drivers/net/ethernet/freescale/fec_main.c | 9 +++++----
 2 files changed, 6 insertions(+), 4 deletions(-)

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
index 1383918f8a3f..5a21000aca59 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -253,7 +253,7 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address");
 #if defined(CONFIG_M523x) || defined(CONFIG_M527x) || defined(CONFIG_M528x) || \
     defined(CONFIG_M520x) || defined(CONFIG_M532x) || defined(CONFIG_ARM) || \
     defined(CONFIG_ARM64)
-#define	OPT_FRAME_SIZE	(PKT_MAXBUF_SIZE << 16)
+#define	OPT_FRAME_SIZE	(fep->max_buf_size << 16)
 #else
 #define	OPT_FRAME_SIZE	0
 #endif
@@ -1083,7 +1083,7 @@ static void fec_enet_enable_ring(struct net_device *ndev)
 	for (i = 0; i < fep->num_rx_queues; i++) {
 		rxq = fep->rx_queue[i];
 		writel(rxq->bd.dma, fep->hwp + FEC_R_DES_START(i));
-		writel(PKT_MAXBUF_SIZE, fep->hwp + FEC_R_BUFF_SIZE(i));
+		writel(fep->max_buf_size, fep->hwp + FEC_R_BUFF_SIZE(i));

 		/* enable DMA1/2 */
 		if (i)
@@ -1191,7 +1191,7 @@ fec_restart(struct net_device *ndev)
 		else
 			val &= ~FEC_RACC_OPTIONS;
 		writel(val, fep->hwp + FEC_RACC);
-		writel(PKT_MAXBUF_SIZE, fep->hwp + FEC_FTRL);
+		writel(fep->max_buf_size, fep->hwp + FEC_FTRL);
 	}
 #endif

@@ -4559,7 +4559,8 @@ fec_probe(struct platform_device *pdev)
 	fec_enet_clk_enable(ndev, false);
 	pinctrl_pm_select_sleep_state(&pdev->dev);

-	ndev->max_mtu = PKT_MAXBUF_SIZE - ETH_HLEN - ETH_FCS_LEN;
+	fep->max_buf_size = PKT_MAXBUF_SIZE;
+	ndev->max_mtu = fep->max_buf_size - ETH_HLEN - ETH_FCS_LEN;

 	ret = register_netdev(ndev);
 	if (ret)
--
2.43.0


