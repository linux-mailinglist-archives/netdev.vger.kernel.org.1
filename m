Return-Path: <netdev+bounces-93998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E338BDDE0
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 11:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 609D828366F
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 09:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC8314D451;
	Tue,  7 May 2024 09:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Tk3Ivp//"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2082.outbound.protection.outlook.com [40.107.8.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7738710E3;
	Tue,  7 May 2024 09:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715073391; cv=fail; b=c62bI1Rz5aKzG2lReh3jc//0wEkCXVFV96ADoyRyqAWgXqGJMlYeneg5CmEEOvyb4SGOZaXeeXvyeM0l9zVhPUK6DqlUIR0JqiYuiS35kLD2TpMJyIyktlb2esF8exX/mQ+2RnWe8HnSk5r+rgU7FocIogh7fhiHOM94lz4rKU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715073391; c=relaxed/simple;
	bh=efe9qcnH+aBT/sTjQ9taAjYFy/MLB64jraLHUy61scY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=HioWgR+ojgUHL7gdD6tjHLA3nXQY0OQw3VSRcXllW5BZ/maVKencxs8ZFN+xraLUDN7irfIWdDr0qskzj/zcdEcGeU5GgfaerRufgY4rqVc1Q/UkKl0ZTavYsJc6ZQqR2eIguneF4IsCGYAABQMObA1Odcksj/JuHPLRJivULZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Tk3Ivp//; arc=fail smtp.client-ip=40.107.8.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VbzF3/uGPiKN/hpRhwb8fJfyK41LHAL6jFZwDNvIufSvF0smaBrkKeEi2dryj11/3rSU/fuPc7f+CLHMMbCGYiHSeFW7VXNQc9OlqKgA055YyK0+u+MQFG4/xGTWlKladKh26AT3Xnp6qRGkW3VnNOegGkhUBmOBrTKIKRbgqvtQ5OmqQp7rEtIpcDjxXXF9enE3l7eO2Y7L9dqemNpR0kom8n8BSlcDKQ+hRpMasEee/fzaIjkK7BT0jwoXpLfHJJYM4Ouz4+MqZcI3XrJkEtdzJW7Q68qRk5/89YIyb60+dIj/BwE/DMImDjZWHY/WGXMCmjWgCxnUJsqgMfQNVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQwf4uzZb6j9Yr3QuYpwB5qZypSLtH8yps/50LrskBE=;
 b=JyqDk4GjO3TqgkeOMF7RzMcGUfUXg+/fx8T7GuQ8/PwoE005QV+TevqcdarJc4RtrJUflECjJlhIhf3evIkgWLqkmpM9UQWZKsEpve6rza+TbbRLcZQAMzNUHlS4+kRFjZNhkS2Dsbs8C8Fz8qaGRR3QQrhCvynRH4RpMeHBgQaEb05lrhguFoSA4DEG3WV3bMTBPvjXEYQtAzWCLtBOUOjPFPuusjUGenGPpooUsBamPhhOIRXVznV2oK0IH5R4Dxxuu1EJp3ktDXyWHkm4rXGsJXIicJBXdPUjQnW+w81cjB8+aICDX7hCa0llsuKBDLk74hRxRV8y2XZNVa85yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQwf4uzZb6j9Yr3QuYpwB5qZypSLtH8yps/50LrskBE=;
 b=Tk3Ivp//wKpHKRhjqvpqzag2e2ALmjqwWO64QQGTG1ocqcpg5Brp2fhpiB9sPtbq7mX8IopAwY1Pbh+kKW9AJXal1fXyZJE3RxeaktLqnYhMF71FeODPxbde/8LpG6y5GN/TVIGLlHWy2UoDPUv2PtbTDMJovw3eeTDOrh0PuOI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR0402MB3891.eurprd04.prod.outlook.com (2603:10a6:208:f::23)
 by DU0PR04MB9636.eurprd04.prod.outlook.com (2603:10a6:10:320::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 09:16:23 +0000
Received: from AM0PR0402MB3891.eurprd04.prod.outlook.com
 ([fe80::6562:65a4:3e00:d0ed]) by AM0PR0402MB3891.eurprd04.prod.outlook.com
 ([fe80::6562:65a4:3e00:d0ed%7]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 09:16:23 +0000
From: Wei Fang <wei.fang@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	richardcochran@gmail.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH net-next] net: fec: Convert fec driver to use lock guards
Date: Tue,  7 May 2024 17:05:20 +0800
Message-Id: <20240507090520.284821-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::13)
 To AM0PR0402MB3891.eurprd04.prod.outlook.com (2603:10a6:208:f::23)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3891:EE_|DU0PR04MB9636:EE_
X-MS-Office365-Filtering-Correlation-Id: f3b8f9f4-9887-47e9-9245-08dc6e765d68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|1800799015|376005|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8vAZPHW2mctytFYvuSoCd1CKwpIjAFyDvVefsC/zTXFtXIVZ/kYrZTVp+8np?=
 =?us-ascii?Q?pD0u2290pDgULYhhkpO6y7ja8WezMY6v9y+PMWeYf5z2vA/c4eHqtspweYSH?=
 =?us-ascii?Q?wWqZ58rQ6eYW4wzFgo57GigHBQcs4/+4x8q50lxt/lh8ZzD77OpSdNhtqxzf?=
 =?us-ascii?Q?saGqarPxzpClx4hGJUYP4JOikIDJnElq/6ttrgEogURKyYGdSbtVBFY3wTyE?=
 =?us-ascii?Q?h1/y8gDetsDA4vcxImltRuyd7auTSyCHHptS2WcaWyhz+8gf3w+pdCzhtSFp?=
 =?us-ascii?Q?7A+e2owVIO6nlTQ/XBMEjjQVwy9iTiOhI+nJRCum4pSVhyk3vjG1md4QenO0?=
 =?us-ascii?Q?OrF8mFTZJT221SiLjNYxbBbziMWQAW/w5YpNFSkUNOSeW9O5Sfvo8AFZzB+m?=
 =?us-ascii?Q?CubOrV4gJnmHos0Hah5Y9UJE+xfK9RDZ5+S8+6PnTZdiEzANWveOXV1QhFzq?=
 =?us-ascii?Q?R+yRGvg4a3+CZ3SZtOeH2dUVkxN3Hp3sGq1mkKlIE8t8LMccWEl7lkrewGHb?=
 =?us-ascii?Q?foze2NFN/F5Yp5TG2abzCrxTlKmUYWPxWL1bfMbHyh1hQcex+D7qiM+hRqT3?=
 =?us-ascii?Q?LYecyhMJVlCNhm+1f7g9QrUXaaQ3S4Y/7t9W8ep8idZRHKXEBtkQsY3cqgAJ?=
 =?us-ascii?Q?+24vC6IZTVEAnKZojGg2UjQ4MMcoKONKtBhfGa88gPxZqFxDft3WcGzWfmSw?=
 =?us-ascii?Q?WtJkXKmvxl0JtAwxwPjwAZBLyYUp2Dk1UvvJlAqyLMkOk3ck31i7SlQ5bfeo?=
 =?us-ascii?Q?QEYLVtzlbQ4YhTGHbzUW4FquQe6C7sA0lMF1JHOZxPTeNNhtBvWg23rj8XH5?=
 =?us-ascii?Q?mbILAiTnK57KXHM2y7D1O4jOP1Ru27UXYUl+iWSyU5is6+mXa1J+Nb/tEfok?=
 =?us-ascii?Q?76qbYAmml+bH4ubN1+x/a2OvEkblcemmU25o8gG1cLr3DKCEvz2lN3+4Z/EY?=
 =?us-ascii?Q?bBIgtZvKzYQbNpW1lfixkU1zkeKnT53HuM6xiw5UPs9/j/HoJOnk8f+FlXrq?=
 =?us-ascii?Q?QOMUSphN76/JerHKQP13Wu9rUqKcNGnIceKSHIImR1ur2jsAaDrEeCi+VVfg?=
 =?us-ascii?Q?0fC++3e0eQgjrNzp1t0e4n0WediCvk3XBs+hjF04ZCg/I+aXLWNVfYr6SDSw?=
 =?us-ascii?Q?tJfu1tEixcd+Z8PThUh+fEY5pVkQr2xTJR0AusNkuPBy+PqMjKugmbfbRjEf?=
 =?us-ascii?Q?WN2dC1XsfjWSM8UFCVNiHRPvTq5k4GXVdCWV6E26cMliy5xmWvdsd8R7MV/v?=
 =?us-ascii?Q?X4kzfZHUr4UcAzMYHXOqaecF2L4mIh76r203F0mI7VlLgU3rf3Fgpvti3UDV?=
 =?us-ascii?Q?/dfWHu8Pob+oyaBRWTs7jh4tdKDni9JF19IhnOcF30R09Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3891.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QX2DEozoWhRc1v/kiKzpRSe4yEeVNfqSFgyzGG0krrnHvxMo0Z+YIiLH77FW?=
 =?us-ascii?Q?wwvupiq44YgGHdivHX49Gg+Fz7RL//JyBiakqifMtCe+7T6YwhqFdeQFE/fd?=
 =?us-ascii?Q?l61qacRA+VJJkt2WV9sw7Luw3JsyNRlKt7ooopQx/WBxRV1JnKYHLVyCru9Q?=
 =?us-ascii?Q?DnkKkp6EY2IF0x6cDoR6t32mSqjv/M6OPBewxHohGRw/MIEbLAQYsoO70rlj?=
 =?us-ascii?Q?vfIsE/qTdFFHzuxr4CAGFZ6m85uGBVX0XLdG0wcFbZdvbmuA/9U5NSe7aTdm?=
 =?us-ascii?Q?bkAfXg921bN9xmSiYIv2ms35c4QWdxbU+qQb8jTwrPH5txr+4ToncGqz093y?=
 =?us-ascii?Q?R39DIM2F0LlgYvwuJYgAwRF/GmDkGUpoNVXeGOxQXFmxjSHXIc9uo54OBBJJ?=
 =?us-ascii?Q?cy+lgQwiWJ9kuGiuKPLlTOgM3xkucePLfuXLjwWbin+pI89nuYhor02GhynG?=
 =?us-ascii?Q?AVKUyTsOJXmBfl8LmXxQFq1t6g3Cl83lHhR6f2txg/zQ2rj2BCWnI6aIZ7Xa?=
 =?us-ascii?Q?KR2rAVQHbiM/yfs+7u0x/ApWV7r0gbElqEFpMII1LjJ1+IOHB1m27hkvSwcw?=
 =?us-ascii?Q?Ri98lwrkKXUTlcmX//LyTFB0qzlPxZownP3mGciZ22yIyNpBIzA5LvHbgZr5?=
 =?us-ascii?Q?ri9YiBgaPYfe2K879hmiiSF2uFr/Hi6i+PBJv+Z2TNHVAXvdEBBJJAK9y4hd?=
 =?us-ascii?Q?ZoD5huY4j5O/7SXygBqqaxwJM8X/+JV35QxDdimI5DQRG+oVTph07VasVb1r?=
 =?us-ascii?Q?CeS1lsd78EFlG0yFsO4OYlC8jHZRjgYeTGyhdyzVwfMh0obCaA0Y8MCKZ+5x?=
 =?us-ascii?Q?HXbwIUbn162sRMvAYZNWtsVd1O1AlZKH2E/N9ay2qZnpiMDHeOytbbOogJUX?=
 =?us-ascii?Q?J0hJYfGmg8kyz9xlT/mzba5TLnKmAkGIBUzMyQ3E3Mmk0fLQBj4HT7CVLCmv?=
 =?us-ascii?Q?QLU1LNtnvJwQSI1+M18snF2bLLip5Mu4FmsRYOv+f8Wk6kaPuUfMUkR61nzO?=
 =?us-ascii?Q?bQNnzimIaGZPCBfBVEUx6oq4nRUg4YmJDQtO7mtzq1/O+b0iqCA983UMqofw?=
 =?us-ascii?Q?LB2J7SzYEYzKMcKOmGqAqpVj3knvbrfACVIqVhMC3g9rv6Xi/MO5ea8+fIze?=
 =?us-ascii?Q?Dag0SOYxUs6a+oVs+EWHUhDYNp7qnHR23lSt0L+ZerPlrwsSvTY8KANuBhaj?=
 =?us-ascii?Q?VKMhRb7/UN6iegUairzIDPwV6wbH7vY0LarKKAa6+fSVpNEpBBJnStpZKDsB?=
 =?us-ascii?Q?2pLhlG3y2FOz98uFAvrcHNKhr+F3uAS4mdmtd4AMQJfOR3gIgVFK+ONunuRS?=
 =?us-ascii?Q?pKqDYJU5zkoIpQUPmFs9fR1BF26C045H5S/2WZrwPaA/1pqNEBnXrBZpEP59?=
 =?us-ascii?Q?JKT8/tMwRTFmZvV56KRkKw2WIl4KwZ+m35UdOjKvcJutZx77SGko5BGnHB7X?=
 =?us-ascii?Q?TIKiqpitrbG89pUju3iagEKhn+NDTZ5lGlw0ut9aNqpkz6lXVyxSiBSEcND5?=
 =?us-ascii?Q?ODsxpM5FlviPJHv931aF9iCAVpQQvMpYDNVX8/xK5TVEw12NeqbHjVGqLOU3?=
 =?us-ascii?Q?cToqygyJMk7ijfAL/nOS7PqLbeH7QdhkLJlc+k+p?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3b8f9f4-9887-47e9-9245-08dc6e765d68
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3891.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 09:16:23.8590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Atf4eKafOH3xFodwGKjZ7zUNg6q5XZqXEqoQjt4mNWk6CNlEhDmxV0CNks4FyKgy8uSG++kPbRyS1CytG/K3nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9636

Use guard() and scoped_guard() defined in linux/cleanup.h to automate
lock lifetime control in fec driver.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c |  37 ++++----
 drivers/net/ethernet/freescale/fec_ptp.c  | 104 +++++++++-------------
 2 files changed, 58 insertions(+), 83 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 8bd213da8fb6..5f98c0615115 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1397,12 +1397,11 @@ static void
 fec_enet_hwtstamp(struct fec_enet_private *fep, unsigned ts,
 	struct skb_shared_hwtstamps *hwtstamps)
 {
-	unsigned long flags;
 	u64 ns;
 
-	spin_lock_irqsave(&fep->tmreg_lock, flags);
-	ns = timecounter_cyc2time(&fep->tc, ts);
-	spin_unlock_irqrestore(&fep->tmreg_lock, flags);
+	scoped_guard(spinlock_irqsave, &fep->tmreg_lock) {
+		ns = timecounter_cyc2time(&fep->tc, ts);
+	}
 
 	memset(hwtstamps, 0, sizeof(*hwtstamps));
 	hwtstamps->hwtstamp = ns_to_ktime(ns);
@@ -2313,15 +2312,13 @@ static int fec_enet_clk_enable(struct net_device *ndev, bool enable)
 			return ret;
 
 		if (fep->clk_ptp) {
-			mutex_lock(&fep->ptp_clk_mutex);
-			ret = clk_prepare_enable(fep->clk_ptp);
-			if (ret) {
-				mutex_unlock(&fep->ptp_clk_mutex);
-				goto failed_clk_ptp;
-			} else {
-				fep->ptp_clk_on = true;
+			scoped_guard(mutex, &fep->ptp_clk_mutex) {
+				ret = clk_prepare_enable(fep->clk_ptp);
+				if (ret)
+					goto failed_clk_ptp;
+				else
+					fep->ptp_clk_on = true;
 			}
-			mutex_unlock(&fep->ptp_clk_mutex);
 		}
 
 		ret = clk_prepare_enable(fep->clk_ref);
@@ -2336,10 +2333,10 @@ static int fec_enet_clk_enable(struct net_device *ndev, bool enable)
 	} else {
 		clk_disable_unprepare(fep->clk_enet_out);
 		if (fep->clk_ptp) {
-			mutex_lock(&fep->ptp_clk_mutex);
-			clk_disable_unprepare(fep->clk_ptp);
-			fep->ptp_clk_on = false;
-			mutex_unlock(&fep->ptp_clk_mutex);
+			scoped_guard(mutex, &fep->ptp_clk_mutex) {
+				clk_disable_unprepare(fep->clk_ptp);
+				fep->ptp_clk_on = false;
+			}
 		}
 		clk_disable_unprepare(fep->clk_ref);
 		clk_disable_unprepare(fep->clk_2x_txclk);
@@ -2352,10 +2349,10 @@ static int fec_enet_clk_enable(struct net_device *ndev, bool enable)
 		clk_disable_unprepare(fep->clk_ref);
 failed_clk_ref:
 	if (fep->clk_ptp) {
-		mutex_lock(&fep->ptp_clk_mutex);
-		clk_disable_unprepare(fep->clk_ptp);
-		fep->ptp_clk_on = false;
-		mutex_unlock(&fep->ptp_clk_mutex);
+		scoped_guard(mutex, &fep->ptp_clk_mutex) {
+			clk_disable_unprepare(fep->clk_ptp);
+			fep->ptp_clk_on = false;
+		}
 	}
 failed_clk_ptp:
 	clk_disable_unprepare(fep->clk_enet_out);
diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
index 181d9bfbee22..ed64e077a64a 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -99,18 +99,17 @@
  */
 static int fec_ptp_enable_pps(struct fec_enet_private *fep, uint enable)
 {
-	unsigned long flags;
 	u32 val, tempval;
 	struct timespec64 ts;
 	u64 ns;
 
-	if (fep->pps_enable == enable)
-		return 0;
-
 	fep->pps_channel = DEFAULT_PPS_CHANNEL;
 	fep->reload_period = PPS_OUPUT_RELOAD_PERIOD;
 
-	spin_lock_irqsave(&fep->tmreg_lock, flags);
+	guard(spinlock_irqsave)(&fep->tmreg_lock);
+
+	if (fep->pps_enable == enable)
+		return 0;
 
 	if (enable) {
 		/* clear capture or output compare interrupt status if have.
@@ -195,7 +194,6 @@ static int fec_ptp_enable_pps(struct fec_enet_private *fep, uint enable)
 	}
 
 	fep->pps_enable = enable;
-	spin_unlock_irqrestore(&fep->tmreg_lock, flags);
 
 	return 0;
 }
@@ -204,9 +202,8 @@ static int fec_ptp_pps_perout(struct fec_enet_private *fep)
 {
 	u32 compare_val, ptp_hc, temp_val;
 	u64 curr_time;
-	unsigned long flags;
 
-	spin_lock_irqsave(&fep->tmreg_lock, flags);
+	guard(spinlock_irqsave)(&fep->tmreg_lock);
 
 	/* Update time counter */
 	timecounter_read(&fep->tc);
@@ -229,7 +226,6 @@ static int fec_ptp_pps_perout(struct fec_enet_private *fep)
 	 */
 	if (fep->perout_stime < curr_time + 100 * NSEC_PER_MSEC) {
 		dev_err(&fep->pdev->dev, "Current time is too close to the start time!\n");
-		spin_unlock_irqrestore(&fep->tmreg_lock, flags);
 		return -1;
 	}
 
@@ -257,7 +253,6 @@ static int fec_ptp_pps_perout(struct fec_enet_private *fep)
 	 */
 	writel(fep->next_counter, fep->hwp + FEC_TCCR(fep->pps_channel));
 	fep->next_counter = (fep->next_counter + fep->reload_period) & fep->cc.mask;
-	spin_unlock_irqrestore(&fep->tmreg_lock, flags);
 
 	return 0;
 }
@@ -307,13 +302,12 @@ static u64 fec_ptp_read(const struct cyclecounter *cc)
 void fec_ptp_start_cyclecounter(struct net_device *ndev)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
-	unsigned long flags;
 	int inc;
 
 	inc = 1000000000 / fep->cycle_speed;
 
 	/* grab the ptp lock */
-	spin_lock_irqsave(&fep->tmreg_lock, flags);
+	guard(spinlock_irqsave)(&fep->tmreg_lock);
 
 	/* 1ns counter */
 	writel(inc << FEC_T_INC_OFFSET, fep->hwp + FEC_ATIME_INC);
@@ -332,8 +326,6 @@ void fec_ptp_start_cyclecounter(struct net_device *ndev)
 
 	/* reset the ns time counter */
 	timecounter_init(&fep->tc, &fep->cc, 0);
-
-	spin_unlock_irqrestore(&fep->tmreg_lock, flags);
 }
 
 /**
@@ -352,7 +344,6 @@ void fec_ptp_start_cyclecounter(struct net_device *ndev)
 static int fec_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
 {
 	s32 ppb = scaled_ppm_to_ppb(scaled_ppm);
-	unsigned long flags;
 	int neg_adj = 0;
 	u32 i, tmp;
 	u32 corr_inc, corr_period;
@@ -397,7 +388,7 @@ static int fec_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
 	else
 		corr_ns = fep->ptp_inc + corr_inc;
 
-	spin_lock_irqsave(&fep->tmreg_lock, flags);
+	guard(spinlock_irqsave)(&fep->tmreg_lock);
 
 	tmp = readl(fep->hwp + FEC_ATIME_INC) & FEC_T_INC_MASK;
 	tmp |= corr_ns << FEC_T_INC_CORR_OFFSET;
@@ -407,8 +398,6 @@ static int fec_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
 	/* dummy read to update the timer. */
 	timecounter_read(&fep->tc);
 
-	spin_unlock_irqrestore(&fep->tmreg_lock, flags);
-
 	return 0;
 }
 
@@ -423,11 +412,9 @@ static int fec_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
 {
 	struct fec_enet_private *fep =
 	    container_of(ptp, struct fec_enet_private, ptp_caps);
-	unsigned long flags;
 
-	spin_lock_irqsave(&fep->tmreg_lock, flags);
+	guard(spinlock_irqsave)(&fep->tmreg_lock);
 	timecounter_adjtime(&fep->tc, delta);
-	spin_unlock_irqrestore(&fep->tmreg_lock, flags);
 
 	return 0;
 }
@@ -445,18 +432,16 @@ static int fec_ptp_gettime(struct ptp_clock_info *ptp, struct timespec64 *ts)
 	struct fec_enet_private *fep =
 	    container_of(ptp, struct fec_enet_private, ptp_caps);
 	u64 ns;
-	unsigned long flags;
 
-	mutex_lock(&fep->ptp_clk_mutex);
-	/* Check the ptp clock */
-	if (!fep->ptp_clk_on) {
-		mutex_unlock(&fep->ptp_clk_mutex);
-		return -EINVAL;
+	scoped_guard(mutex, &fep->ptp_clk_mutex) {
+		/* Check the ptp clock */
+		if (!fep->ptp_clk_on)
+			return -EINVAL;
+
+		scoped_guard(spinlock_irqsave, &fep->tmreg_lock) {
+			ns = timecounter_read(&fep->tc);
+		}
 	}
-	spin_lock_irqsave(&fep->tmreg_lock, flags);
-	ns = timecounter_read(&fep->tc);
-	spin_unlock_irqrestore(&fep->tmreg_lock, flags);
-	mutex_unlock(&fep->ptp_clk_mutex);
 
 	*ts = ns_to_timespec64(ns);
 
@@ -478,15 +463,12 @@ static int fec_ptp_settime(struct ptp_clock_info *ptp,
 	    container_of(ptp, struct fec_enet_private, ptp_caps);
 
 	u64 ns;
-	unsigned long flags;
 	u32 counter;
 
-	mutex_lock(&fep->ptp_clk_mutex);
+	guard(mutex)(&fep->ptp_clk_mutex);
 	/* Check the ptp clock */
-	if (!fep->ptp_clk_on) {
-		mutex_unlock(&fep->ptp_clk_mutex);
+	if (!fep->ptp_clk_on)
 		return -EINVAL;
-	}
 
 	ns = timespec64_to_ns(ts);
 	/* Get the timer value based on timestamp.
@@ -494,21 +476,18 @@ static int fec_ptp_settime(struct ptp_clock_info *ptp,
 	 */
 	counter = ns & fep->cc.mask;
 
-	spin_lock_irqsave(&fep->tmreg_lock, flags);
-	writel(counter, fep->hwp + FEC_ATIME);
-	timecounter_init(&fep->tc, &fep->cc, ns);
-	spin_unlock_irqrestore(&fep->tmreg_lock, flags);
-	mutex_unlock(&fep->ptp_clk_mutex);
+	scoped_guard(spinlock_irqsave, &fep->tmreg_lock) {
+		writel(counter, fep->hwp + FEC_ATIME);
+		timecounter_init(&fep->tc, &fep->cc, ns);
+	}
+
 	return 0;
 }
 
 static int fec_ptp_pps_disable(struct fec_enet_private *fep, uint channel)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&fep->tmreg_lock, flags);
+	guard(spinlock_irqsave)(&fep->tmreg_lock);
 	writel(0, fep->hwp + FEC_TCSR(channel));
-	spin_unlock_irqrestore(&fep->tmreg_lock, flags);
 
 	return 0;
 }
@@ -528,7 +507,6 @@ static int fec_ptp_enable(struct ptp_clock_info *ptp,
 	ktime_t timeout;
 	struct timespec64 start_time, period;
 	u64 curr_time, delta, period_ns;
-	unsigned long flags;
 	int ret = 0;
 
 	if (rq->type == PTP_CLK_REQ_PPS) {
@@ -563,17 +541,18 @@ static int fec_ptp_enable(struct ptp_clock_info *ptp,
 			start_time.tv_nsec = rq->perout.start.nsec;
 			fep->perout_stime = timespec64_to_ns(&start_time);
 
-			mutex_lock(&fep->ptp_clk_mutex);
-			if (!fep->ptp_clk_on) {
-				dev_err(&fep->pdev->dev, "Error: PTP clock is closed!\n");
-				mutex_unlock(&fep->ptp_clk_mutex);
-				return -EOPNOTSUPP;
+			scoped_guard(mutex, &fep->ptp_clk_mutex) {
+				if (!fep->ptp_clk_on) {
+					dev_err(&fep->pdev->dev,
+						"Error: PTP clock is closed!\n");
+					return -EOPNOTSUPP;
+				}
+
+				scoped_guard(spinlock_irqsave, &fep->tmreg_lock) {
+					/* Read current timestamp */
+					curr_time = timecounter_read(&fep->tc);
+				}
 			}
-			spin_lock_irqsave(&fep->tmreg_lock, flags);
-			/* Read current timestamp */
-			curr_time = timecounter_read(&fep->tc);
-			spin_unlock_irqrestore(&fep->tmreg_lock, flags);
-			mutex_unlock(&fep->ptp_clk_mutex);
 
 			/* Calculate time difference */
 			delta = fep->perout_stime - curr_time;
@@ -653,15 +632,14 @@ static void fec_time_keep(struct work_struct *work)
 {
 	struct delayed_work *dwork = to_delayed_work(work);
 	struct fec_enet_private *fep = container_of(dwork, struct fec_enet_private, time_keep);
-	unsigned long flags;
 
-	mutex_lock(&fep->ptp_clk_mutex);
-	if (fep->ptp_clk_on) {
-		spin_lock_irqsave(&fep->tmreg_lock, flags);
-		timecounter_read(&fep->tc);
-		spin_unlock_irqrestore(&fep->tmreg_lock, flags);
+	scoped_guard(mutex, &fep->ptp_clk_mutex) {
+		if (fep->ptp_clk_on) {
+			scoped_guard(spinlock_irqsave, &fep->tmreg_lock) {
+				timecounter_read(&fep->tc);
+			}
+		}
 	}
-	mutex_unlock(&fep->ptp_clk_mutex);
 
 	schedule_delayed_work(&fep->time_keep, HZ);
 }
-- 
2.34.1


