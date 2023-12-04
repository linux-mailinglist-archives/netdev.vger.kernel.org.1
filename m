Return-Path: <netdev+bounces-53548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0521803A6D
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 17:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A91B1C20AEC
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 16:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356392E642;
	Mon,  4 Dec 2023 16:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="U0tQVLAF"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2087.outbound.protection.outlook.com [40.107.7.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175309A
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 08:36:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZjRDl9iJZNYIlfUgKah3+zrdO6TuSTH6YUs8f2wbEhjvoqrA20YWn0HsHdUo9wcGcSAM92N8wx0zryWnu5prNGHqRgOPUkd1roEP+aDcRCOBf/Is8wKxo5GwXKMnNZe5DLGSG5//FtJgzb2/PzY3Wfk1wFVDtkxzcg9tMFefl9JRd1n/n5SQpX3MXlEHydXHobsLx2bkO23VsEZKG24juKmwTOZDzkj4o1dTwjQ2klOhzHrrq9yLqfW7B8Q+GmJXQDfV8F+SN9dtumw/8NVueyKdutDIlOiDTfCwfoqi4XvnI/fk81R7602oIgm07RDDzwI2tMY1WRP49Sq5HV7YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ZCF1I4gb7hhdiMaWHGzKdRL8CZko9JD4K8fbasLbGE=;
 b=LoE8HnlhnBEz/R5uEqa7qCPPYUvCnXhjRAUiSWZVfmB52yV5q90um/TAcysB9pqXwLfEQ6lFxBL8QEuk8LMd0qntRomzfwN56QtUq9hLJ6XCmvENUO7+BWIoNziyho5trIs2cvqnRJiUF13aim8fnfUhvfrmZykG1e+gwUG1W1NJwWojuWo8T0V0+gRacMQUhPgwq/6GYB8RDHXg/BqUDrP8wfp+H7Ap43pHlSNoA4jRK1JvvC5KU1Xd8JSJ5xwtjWutpPb9rUs31I40V4OFdQn/zgNc5iPRcZNnGrwvR5M6sO0gSPQUOLD6nhYvCtOsNJZJYmKPSaJimGVcoR3tbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ZCF1I4gb7hhdiMaWHGzKdRL8CZko9JD4K8fbasLbGE=;
 b=U0tQVLAFrZRDhVOXtd7yArirm0+7QAxFrQ364fYGKfpr86yyuj5MolIjv5NLtpv6GtPKIoLgMn+325ASMoR8eKCCNR0gLG9YKuxwoTR7oDOHZqPQjYihlyO/zrzopdUk7yk4LUpOqyg2gGQN13uoHjrRqRSbQzAXuK6K8lYtN1A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com (2603:10a6:150:21::14)
 by AM9PR04MB8356.eurprd04.prod.outlook.com (2603:10a6:20b:3b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.22; Mon, 4 Dec
 2023 16:36:02 +0000
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35]) by GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35%7]) with mapi id 15.20.7068.022; Mon, 4 Dec 2023
 16:36:02 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 4/8] dpaa2-switch: add ENDPOINT_CHANGED to the irq_mask
Date: Mon,  4 Dec 2023 18:35:24 +0200
Message-Id: <20231204163528.1797565-5-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231204163528.1797565-1-ioana.ciornei@nxp.com>
References: <20231204163528.1797565-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0216.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::20) To GV1PR04MB9070.eurprd04.prod.outlook.com
 (2603:10a6:150:21::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9070:EE_|AM9PR04MB8356:EE_
X-MS-Office365-Filtering-Correlation-Id: 873f7bb8-6958-427a-8c5b-08dbf4e71aa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	d39AV7oYaT+xIqXEHtK3g0RiC7y4GumvcyI7yH5STbtNxnTZClFGNLLlkn/vnwQ6ZpLmMQndHQjGtb4e/BCk+Q1oWPX2RvDElbmU2UzKIBprQnalsB6O3k2wLGOW5ZxRiexcGWdLIJF0gph77+hqMOca5xuhck6ZiDucg5IY4QR4Y1qgj5RRxAL2TgdtWwL70yu7glMfZUeQHabkhLMhLcegB462osG/BkifJ8izt2hAHbrizVKQSi+0i+SObX66gNvU3SSl1/6y99FDUZP4kL14oRBP2b7iytrqjFLLKR8pJym08XRQs/X31y/NMdI2GmE0tS0zdowm3ed4WMQxuC+yM0/Fu5PUWAvdVcTLG+JgjyZUHfE6KxHgLBATiPkJyOGPNt4PEtrWkYPMpd+FZvBtXYqMm0gRXvDPHT/MIj1+kt7JNnVMOZGRH4pzv26YYD7VBYU4dyrTC7drHhGxKT4ZRTpbh4uNymCcXel4KWYanTDnfBMbGYj9lD0awzJXIM1jgPQf24m8u4BbZxsj5cz6uOD/44Jr/dfvYqUhB1agUwv6ZqlI+Bbh+AbjTQ9U
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9070.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(136003)(366004)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66556008)(66476007)(44832011)(316002)(66946007)(5660300002)(4326008)(8936002)(8676002)(6486002)(38100700002)(83380400001)(86362001)(478600001)(2906002)(6666004)(26005)(2616005)(6506007)(6512007)(36756003)(1076003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rV4YMfG3nPrsNIjhRXrq0HUQst5HO1IP4LUtN3vaaSwWtnFhFPs53ISi+Ojh?=
 =?us-ascii?Q?zC0nIpIOxgRM3mn5R5EPYsC2BbAMGPzN0qqg2K09+ISv4YJquY2g+Ldudxo2?=
 =?us-ascii?Q?nurkcXw9MGd4iJsMFtc/eDN4yruGUdVxX5Vd0IZb82D/YIeFRAZkcLdBMREX?=
 =?us-ascii?Q?sWQ416I8xtixEF8w0t49t0ydCR6hGTXy3CXOlYGi6lwQfVD4W1YuYlkdli8m?=
 =?us-ascii?Q?blSsKqF/nZpQ96PICQ6Tj8JVRW6DuXVw3flvhMgKZvOn0mKrZ4cUl31gjkfs?=
 =?us-ascii?Q?Mt5Cl4okD58+/PGBiRjBJYB1C087ClDfGliUPRWF8DsAMAbpksvRVKDLgWU8?=
 =?us-ascii?Q?sUeXfWhtEV7p1xEqqcAJqHFoE8xzWBPYaEXU7PgEluOorcVS9GuPCOZEuWf6?=
 =?us-ascii?Q?Kv1z1xYSdcfsN4lFNhy/jxVwzkVpb31/XRAgGELsC3f2d1omYc18W9Jqgtx6?=
 =?us-ascii?Q?UuJ9eto2iR238lFTa6frR+GupHq0IN/2T3FMebYU4a+JEl7hm7v0t6q+SkMR?=
 =?us-ascii?Q?awHjSaeN//QdWF2W7HUX47yAmsB0qVATpm1D5vbGKdCLG+6pV5SQ/Y8J5DJz?=
 =?us-ascii?Q?0QigaFrvWcAJ9B5S8mmE80lpoAcAs2W57dhMBVXWtghKzNENe2fxxwZgrNBY?=
 =?us-ascii?Q?+wdBEJSjxh5K/Rbyl4xyH4PhIsvVljzME+PZz5EtDAolBUvoech3qgxe42Rw?=
 =?us-ascii?Q?3RPDgGG2aQTBRvl1GWbxHAvZIrUe7tN+tWkcDZbbykP75dCUl3ApfEnBAgTB?=
 =?us-ascii?Q?H95Y9cG8obfiOYndyg4DYpkhYajAzYXnU3O/u0yJRwoJMIT87Q39R7K0Ix9s?=
 =?us-ascii?Q?f+w1bLPcdnG8SHaaEF6bmPBBrY8CF+gZmd/tvxPXZuxML4DuBrJrecI+q3DF?=
 =?us-ascii?Q?LpFF3iIaub2e/mrubvhAvH4xPNfheS4r51Ktfbtu4Sy31QfyvPYxQO4Gk+4y?=
 =?us-ascii?Q?SqOjnjk64VSuxqwVpJkScktIk+mkDg3uDxAdNEhKaz5tM/++9Jk3Xv/qCI3Y?=
 =?us-ascii?Q?CnYiBlvOnfD5gy2kxRLNh1rKIb9/KMhO9Ex+Xy1wAe/kwJ59MYeyokest+P5?=
 =?us-ascii?Q?DL277bLuhRpacBBvJClJkyVRZZWewsq9iNMum63JfvJ5sNLzC4DEu9oc/E57?=
 =?us-ascii?Q?RdUWL3YMAieWsLUL+nqZM5Lcjml43CtMWFXMvR9f47nm3+/64o2xPu5uA7WG?=
 =?us-ascii?Q?8aC2TWfuUNvH20ExRk/mDnwblMYKnS+ToaKtoR7wVxFYkI28yRh3Bg31xhYf?=
 =?us-ascii?Q?aaOPQAw/tOp+2hnKr4dX9toLIS0mocvPIheRuWk9UoNQ3Ia3A/GsyepxmsGb?=
 =?us-ascii?Q?tqPYldddvToTGMos7M13wMHGJLBOv1ErR7SRnQ9jGJu5iPZQNDlS7azsEMFH?=
 =?us-ascii?Q?Md63KuSQg3jTuHl3oJk8c9l3w6f0qa7w+qt3phZJyE6g7rVjZysixLx0DAeL?=
 =?us-ascii?Q?qdXMcVKKMLWFE8p4Ohh/Q+gYCURwpWmdk47mPc6nSTAFbdvkaiLtfWHGlfGI?=
 =?us-ascii?Q?KeuKkVzic0fzTbE3CFFjlB4cubp3j3OpUwTxG0GGkxo9/u5wlttM9KfWTCQm?=
 =?us-ascii?Q?dTm4IPfaIs+Sr9FucpFcdo3CORaqx6e3XttgZpIA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 873f7bb8-6958-427a-8c5b-08dbf4e71aa3
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9070.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 16:36:02.5607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TiOSxPUX0Hf/tgB530vDuudIw4mBMPo/hOxmaR850OMtDVDodZfdSpV355ayedw1hsECPNaH6FnFbsaAqR8TBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8356

Add the ENDPOINT_CHANGED irq to the irq_mask since it was omitted in the
blamed commit.

Fixes: 84cba72956fd ("dpaa2-switch: integrate the MAC endpoint support")
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 654dd10df307..e91ade7c7c93 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -1550,9 +1550,9 @@ static irqreturn_t dpaa2_switch_irq0_handler_thread(int irq_num, void *arg)
 
 static int dpaa2_switch_setup_irqs(struct fsl_mc_device *sw_dev)
 {
+	u32 mask = DPSW_IRQ_EVENT_LINK_CHANGED | DPSW_IRQ_EVENT_ENDPOINT_CHANGED;
 	struct device *dev = &sw_dev->dev;
 	struct ethsw_core *ethsw = dev_get_drvdata(dev);
-	u32 mask = DPSW_IRQ_EVENT_LINK_CHANGED;
 	struct fsl_mc_device_irq *irq;
 	int err;
 
-- 
2.25.1


