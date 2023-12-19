Return-Path: <netdev+bounces-58876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7B58186D6
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 13:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4468D1F23BE0
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 12:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B3117741;
	Tue, 19 Dec 2023 12:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nZWUXEP6"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2060.outbound.protection.outlook.com [40.107.6.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D854617988
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 12:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjbGOztRGI0jhYQd7kx3OcniVgdfY+v/ZsOkh/TRKAXTusLIX3hQypuouex60RUj/4wDLOpa3XC3fLZ+xW77BLOjTT+qjK+oMy280ocdUPRFbKkiA95Pnthh4p0SoMm8UvodJDsLhIYxLvwCF9Q6QzwNFZJtyhi6vRvexuXZ7o6jaPg8XFAcNn+LDitNtWyLW7qu+figGeJiD9Bj9YzTcnYHWRo14vJfqkVZTze4ZJArZncw64hgAIlj2h8BESaPvf7lKS7kzWtWsFob8AU7KmFKUU+spvzJ4cWBfdEqvtirxMhksZtbW+ZA7LpWwvmgfAQhMvbsuoL0FKQ6tTNFmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSgle2XRst8VNAK7pCBeEyuIXKqNdGgX62wBHn0eWYk=;
 b=lJmXRJ8PRRs7PiOMU9bOffMa4ZIY1wpU45vHrPV7wj0iGI0IXVSNj1Nte338jgWhacERNrO2jLtrAhtNPSHpDxFjUQEbJr1BCAxScIlMHYvE8Culp4lma7nyBND6jo6PsSJ21pac2/VMY7mARD/NdwbubODqnYgvVnzB4Kjq6lar14ctt97FTYCP/5x5ODbGDVOpt+ja8pzfb4LEPpGiyyCNUDhhKjrIb0FUeDvnbtf4np1WJIWuXqN+e87vUTk0OcfrMyJa6H9Pbt5S6ozCoK/lmd2/DIEw1LST0mejJ3a7fOhXqGxHlsYrzRRyuMjDXqpM5ogB5QgoI7yokBZOMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSgle2XRst8VNAK7pCBeEyuIXKqNdGgX62wBHn0eWYk=;
 b=nZWUXEP6HjKfVki2d4cNDH5dvn+8DNyH9ZTSr9/hKn0O4VLqisEqxylhqoguBkzxQ28SNiZtfcOMrXRgxh0uH1dMJG++3RsJO76kNyBGDs9QZmj0VXiyjG54pS4OCyi3TOeWVxnrSS88G3EDFuzV5bXP0boUgvhIP6Fpip212xM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com (2603:10a6:150:21::14)
 by AM8PR04MB8033.eurprd04.prod.outlook.com (2603:10a6:20b:234::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 12:00:05 +0000
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35]) by GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35%7]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 12:00:05 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH net-next v3 5/8] dpaa2-switch: do not clear any interrupts automatically
Date: Tue, 19 Dec 2023 13:59:30 +0200
Message-Id: <20231219115933.1480290-6-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219115933.1480290-1-ioana.ciornei@nxp.com>
References: <20231219115933.1480290-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0004.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::10) To GV1PR04MB9070.eurprd04.prod.outlook.com
 (2603:10a6:150:21::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9070:EE_|AM8PR04MB8033:EE_
X-MS-Office365-Filtering-Correlation-Id: aed94f55-f9ba-4b6c-07a8-08dc008a09ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	I3P+7VcBl/t4vS6l38bsA0HCbuawdbY9muqjk++3XpLOgowXhqLRkJcS7hfOsykZXbENV7/iIRGjy8VhlhB38nqMxtImCardKqQD9ht0PzYRAH++XEVQat3qZE2GNfPe/+3osBcMHqwy6ZH/Lhn7PskuWbyT3z/4eRDOBY8JTwMSFC4IdsMaPDVgSA/Az2QJQYz7NldlgtOIyzR2Dt7zaSdUUU7YIvOG1gjKl9/oqtAkhAK5DR+W+i+xublkAjXJ8DvzvoxMbmCF2qSZXCxUHNco5drdg0+6UFLOf+ZbyUAnPGWcdl+KOf2i89lyVAIuU9Bqhih+z5Btlh7OV31GuJzTcxZhTvunK9AWEF+4A0NW1EHx06DKxT/YVdE/GGOzSE5JmiZUownJp8gyruAKSsy97yloAK6m0E0UI/RtnLoHWmeoH/EU0xEb+zK4NQeSBM4bIOtvOpCt2cVPrnm8KIF0WmfUXSljS8htQi2t9JcPZfWzz3PQAXU1aqBsYyJWmjbEkn2K0LpSK8fm1438yLesVNg+i6/7KS7dO9W4DOsNisN4VLDqjbnrrT02Znj0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9070.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(396003)(376002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(83380400001)(1076003)(2616005)(26005)(38100700002)(8936002)(8676002)(5660300002)(44832011)(4326008)(41300700001)(2906002)(66476007)(6506007)(66946007)(478600001)(6512007)(6486002)(66556008)(6666004)(316002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cEhrCO48V6wAaTkDaN2AbL59PGvyLb5MCHPK1e4B488Ak4Qg4Nnfsbfy/pdX?=
 =?us-ascii?Q?6Lmlt2OgvbLrpWQ0dmghm62rpkvl4fb1TPp7fPuuB5rVDTHkvjeaOHxJ5tm+?=
 =?us-ascii?Q?AWAQtoyhTtKd9AJnwogelgOX8sWl3SUS8+TDuMijERj51teUFG+03IKRbxli?=
 =?us-ascii?Q?zIO8/4Vo705upW7QdOtAO4msvdkKtfIANSlQU3H1FlWpbFetXxptcokHYGal?=
 =?us-ascii?Q?OCBzdOzTaDE3OffyTraEAEuGdJU+7f+hlByvxOx9CItB+UighMRdq8pvDMHh?=
 =?us-ascii?Q?N9wQyEFt9XG8Gqoa/PGUmYoNQs+yYDryJfpEGdqBWjqjhYwaAtOYT9zwB4rE?=
 =?us-ascii?Q?3hQ8p+ns7pqRVm7hjBJPgWL/Jd6XPihxt22BRg/LSMhvnZ+Wzc/nl4tj/hk1?=
 =?us-ascii?Q?Q9HcGegNjYqdr4123R4l9fgDryD5vwkkcoMsVoiXzNDqiD4WR6waRJ6FtOsK?=
 =?us-ascii?Q?IwZwi32mZvodlqUUufYvQKepEMLfke4h1XWTfNCK44at3MCdmRIGgfl0Qnp0?=
 =?us-ascii?Q?KJvj+svsYE4pvd2YnKpM2VetUAVJHqRmgW6ENaSGmTBVGEXQjWfIvsUKBtZR?=
 =?us-ascii?Q?E7KtXRUBD422HTyNM3x+kDUR0LPfEmWcS1IQSbcW7uJpTRPkU9MWjWZq6spo?=
 =?us-ascii?Q?N5esZWrul6SA/D7O3YafM/H/LppaVefUoVtL1VoEodvaq7g4YVPRbEpfK6zJ?=
 =?us-ascii?Q?wk4PD+L9LRvecyD0mgk2HojVkX+kgPx7spgwlz2DRUttdGfGxSQDAxh3R1IN?=
 =?us-ascii?Q?niAixjFsrntuuC0ZXU8LnMIxA6AfTSgm4z89UgVvASxr0irj/iND0r5Xrrfp?=
 =?us-ascii?Q?WIZJ8+JuofT1bJ0urFI7EHStsf88aJBWDEtWUPuYO10MGSNULiK41ejx54yo?=
 =?us-ascii?Q?tYlL33DfmFXOVBOEEyilIv1aNNC4SVtd0Hc7kMptBXcJXzNW29dS0i9SqX97?=
 =?us-ascii?Q?lDwyEgh4Dzlx+rVQE9PgkENzg16cH2IIDc3cjWclbJLK/Mdw5U7pgJoBw2/T?=
 =?us-ascii?Q?Oi7K5HJZBLAGcPwhZ1DlmqeudUafFRXX9x6PeQahoiR/7YQ17XGMXU3LYurI?=
 =?us-ascii?Q?p3tGIwdkQdFrPC+AuBqsX5mI49sW7lMZznaTx4ueZo/wxnoZE58rM1Jq+wan?=
 =?us-ascii?Q?Vw7n71fJKkUPnd1QkJ+ftAfzPwHVzHt0hvt5/7rMAdTLbr+stWHvChm9mZhz?=
 =?us-ascii?Q?7OIHvIR0oXZIGFOyE3LoIE+P+5hglzbHztoplwLA6fGdIi4FZm6UjRebkUH8?=
 =?us-ascii?Q?CYzVeDHqPS9/CflpcvaXinkB3rCy6AcIiLLmtlbgVTM4iK5PfYu9TgD9QULr?=
 =?us-ascii?Q?ioRhAw5+R3b7eiTm8PEQhFMZtVsQe3uMWAj5iurLZ3lyFmrtnp0M7rijR2q/?=
 =?us-ascii?Q?RLz7MEGFPdYGwvlPH8pa2F7D6SNK1X3Rdpl3jn9M/ysWKTXBln+VsilQVp7t?=
 =?us-ascii?Q?riHO55lBuvBwIvsPAuF0x5QDUTLhqCvJ8VvAEPTaB1mHg84D2SjkaQmQrT0T?=
 =?us-ascii?Q?QZdyYlLKrWEHu/79WMJXMFvMz4f4oEtdPPCCZ6yHsS+FYJ3sr5LAxMjgBhxG?=
 =?us-ascii?Q?J2kFadMAR0tGB2hXiH1lvnWEKdcDUrsS23c5xOyK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aed94f55-f9ba-4b6c-07a8-08dc008a09ec
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9070.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 12:00:05.2977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hiz6ukuyk9wfvsAkhsFzSsPOS78GfTsMVSKqxRB4odUEuXWqYZvvEhMOs0B8K0mwz/y03PqRZSFNKpqn6P1vrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8033

The DPSW object has multiple event sources multiplexed over the same
IRQ. The driver has the capability to configure only some of these
events to trigger the IRQ.

The dpsw_get_irq_status() can clear events automatically based on the
value stored in the 'status' variable passed to it. We don't want that
to happen because we could get into a situation when we are clearing
more events than we actually handled.

Just resort to manually clearing the events that we handled. Also, since
status is not used on the out path we remove its initialization to zero.

This change does not have a user-visible effect because the dpaa2-switch
driver enables and handles all the DPSW events which exist at the
moment.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v3:
- mention that the change does not have a user visible impact
Changes in v2:
- add a bit more info in the commit message

 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index a355295468bd..1b8d233e0802 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -1509,9 +1509,9 @@ static irqreturn_t dpaa2_switch_irq0_handler_thread(int irq_num, void *arg)
 	struct device *dev = (struct device *)arg;
 	struct ethsw_core *ethsw = dev_get_drvdata(dev);
 	struct ethsw_port_priv *port_priv;
-	u32 status = ~0;
 	int err, if_id;
 	bool had_mac;
+	u32 status;
 
 	err = dpsw_get_irq_status(ethsw->mc_io, 0, ethsw->dpsw_handle,
 				  DPSW_IRQ_INDEX_IF, &status);
@@ -1539,12 +1539,12 @@ static irqreturn_t dpaa2_switch_irq0_handler_thread(int irq_num, void *arg)
 			dpaa2_switch_port_connect_mac(port_priv);
 	}
 
-out:
 	err = dpsw_clear_irq_status(ethsw->mc_io, 0, ethsw->dpsw_handle,
 				    DPSW_IRQ_INDEX_IF, status);
 	if (err)
 		dev_err(dev, "Can't clear irq status (err %d)\n", err);
 
+out:
 	return IRQ_HANDLED;
 }
 
-- 
2.25.1


