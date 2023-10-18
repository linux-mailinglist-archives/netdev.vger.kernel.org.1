Return-Path: <netdev+bounces-42362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFE17CE748
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 21:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5420C1C20B10
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 19:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DCC42BE3;
	Wed, 18 Oct 2023 19:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="DyawYl0T"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362543B297
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 19:02:59 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2072.outbound.protection.outlook.com [40.107.21.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBD5109
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 12:02:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xd6buqUHYqxMj9JlHo+mTGcefRftF2XTvj79m+Tf3nHb8nOkm3KUYPIrhX0jVvp4d6KNkszREkqF2SFxjtW69J6Gp8YHMWArZTjqX8Rpv1O+dT3IMohTa+IFPr/FH6+DYAi00YDBum47lNhiVHOE0sY1hxsj93QIIur+T5aS8Zu2zoBVKpwyNCsY6wOz/+iAx95i3MvKYZMk1Az0fwFsNLt/4HExMOLGCtSgTOBFsP4mZKV6WxHAeKwemk+Ocj/Iau/umJwPi21WGBF/T5sv36blj+avTyf7FcK4PaFsj3CWquRkLC6TxUHDMz5xHjAnduf0ID4AHvQaQ3xMs8a7aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jY2e6cMuYOvsKehYih4Fc4/GsFPqmMZZ3bVqrzPYlv0=;
 b=IH5kCqXGnaaF0wT+7dZdfcq+tiwmgxTx/QO7xy2ALIIQVNCTAcoBOnWQ+bFEZzfKuIa8sWC2k5gqBd/vym989jbkcZAZT1/r3IFcu2srO8VW5dGeVGe5RVx9h8DWXulvxDVGODksdBmdM+pK3dsGh9JWogWdkgoTfd3KXsb//M8Cg9ed529nSxEA1h65TnBTJ+t57BawrdCdMt5KXKsKSkkFs4A7JAXPEh2ihmfKGCrHizyX7ZpZccidjERR/Y0N6eMOahmC7Hk2PDHQDoAXLK+VVitSu3HcGp8YTXZZMVEgvSU6usY9vo+N0G30JasLlybWxroNjsWYzzSW/j7ymw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jY2e6cMuYOvsKehYih4Fc4/GsFPqmMZZ3bVqrzPYlv0=;
 b=DyawYl0TCMId+6wq7gkFL4DiHazgJmLz1E72Rwgvukk7hrNXJCx/2sDDNfmKcIMEIwFGzCdoJW/QGei0MltkJNHQyctZCeW4XLVLpvT6+Q30NelnJG63VbPmya60ka9jj7QyuKaFjYFY8Bos8tPrUS4DGegOqOpG9wC1kjqbxVQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by VI1PR04MB9908.eurprd04.prod.outlook.com (2603:10a6:800:1d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.52; Wed, 18 Oct
 2023 19:02:55 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617%7]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 19:02:55 +0000
From: "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To: wei.fang@nxp.com,
	shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org
Cc: sebastian.tobuschat@oss.nxp.com,
	linux-imx@nxp.com,
	netdev@vger.kernel.org,
	"Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next] net: fec: fix dev_info pointer
Date: Wed, 18 Oct 2023 22:02:29 +0300
Message-Id: <20231018190229.1880170-1-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0266.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::33) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|VI1PR04MB9908:EE_
X-MS-Office365-Filtering-Correlation-Id: 877770d5-bf58-4296-463f-08dbd00cd607
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FcpCGcKWIpU34UBdBzbX/2c+J3ICdGEZIYj1xYZMaqeU1VB1IRn+xeNL0AMkFFptENjbUovYz8QIKpzt3P5uc53UV/miaYeCIUEj5U7+3Jv5ll7y4+j9UnYHEchDrRBJ9o4LlfZuE1dRI+80USojWPzKj5hVJukFYhmxhfyU3EVqp3BZ01K0OskU5CjEKTR0KjR2cM5Ojbl3vRUyVJx4MjPUEP7mIEWAm5hwC/qWjdbFcJ8Gv1wVVtgI9nYd52zGFkzpTzamaZepATXpRcAIgbOvwFYcu1ALBZTzX4wBT9bkUo9BE8uZQMls51iZVZGIbrt46lAnMyN6TlMJKCuZtzOU8qEmgaN6jXuhj4yWciuJWL7EvmBKI77zR2ZWXD2pA3ftzpLZNah9dD0auKii3BdhuLgPbJTPt26rXsIU13NtUlMoKebpDnQ5l7WmHCywUSZmxbbazHH4E8dXFo1b4jHlP+1ngZMZx4jHPNr1rgXdripISdKaNGdsVliSSN08alCTE36sAbc+MEMQIuMAN+zAztLO3c3juaQ7gMDzBUxJ5OiSRjSWPEtlk/jx1jK/J0D+HYGquPxQQBx0/mip+lkrPnJ2Gys/MpRZ4InshLJhoUs9ob2be9y1V3U18eb5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(38350700005)(6506007)(38100700002)(5660300002)(2906002)(4326008)(8676002)(41300700001)(86362001)(83380400001)(6512007)(1076003)(26005)(2616005)(52116002)(6666004)(478600001)(6486002)(8936002)(66476007)(66556008)(316002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3K+VymMfxvC452xyYRG/BUfPghUK5PbSSaKVs+VkLmYZmzopCoDMYDh+Apec?=
 =?us-ascii?Q?YGKdSgRqencGh2XwSa/YKnY+/l1VgGAx3DkC0YM8EcgQ9hkxpB2oN5R8/tJS?=
 =?us-ascii?Q?yXQrMOytnpjVH/ok7LNR9GeoaR2U2ytXjG8uWIoi0poN1F/DwMh2sxY6lNSG?=
 =?us-ascii?Q?YKBH+T6RAb3eC5WHcwAoOMYvXQ6ft9Dcg5S/1/xSoXMzN8rB6Vl430ngnSME?=
 =?us-ascii?Q?WWKdMnaDVsU5qDlhERTb/LTiMl8Qgi/RnrfZz0SWOOA+gl8qhObYKUDKjMGx?=
 =?us-ascii?Q?MfkBAeGVYv/VUZEJo3r65oKQ58gJWyUQKChJbkxMlH3ji4ofclfvMAdySOJQ?=
 =?us-ascii?Q?Ra1rlrsNBM1+5Cqnf5z7+3Vg38WULrtb2zbN/Pwc8W0ed2z8Mm6TurrlsZ+O?=
 =?us-ascii?Q?OMsd+2+mfh9BJBk+/sXKB6vwD5myCD0Lcaoow7EG+joX8foY6aB+MDXPAqx4?=
 =?us-ascii?Q?dx4Rx066ZV7Swdt/k5BErNNBCGhyRs9ouzCcqFxr+YEC/VkahIh4olIYgxmr?=
 =?us-ascii?Q?RZY+OVcl4WCFMWKi9SA45Gg7SueA0aeisE8OSiJ/5VxiK1354E+ZMb5L+l41?=
 =?us-ascii?Q?AGCVxXZXqLWsF10BhfRpX3OH6nWPAytGwXjjNx68Lu4DeUxsxnJNbkTIdqBu?=
 =?us-ascii?Q?1gCaAyONQ15DTc88ArNhKi7/82weGN73CB/vVYcv9ZflEa6nmJVNZj/pDuKJ?=
 =?us-ascii?Q?+DY+wtE+xT6qapePLklPRo+vUCkRlFLK5StHjKowAb/ECFqTBpbMNcY0e9WP?=
 =?us-ascii?Q?vNmZVA6tr2hnlt7StMLjqlgrN6/UXETxRKC2JjOJayrvnz4T3qQmQsBaiWWj?=
 =?us-ascii?Q?sHikWPMhFSGKk8ABfnrWKSvlQA6rJms4NZwcI8iNidmjZAeBX8PyyQhZUPUW?=
 =?us-ascii?Q?MM8/THcrJ7uoWT9Kq6jeIUjxG9nGTGg6F5tUSvOv05dU1l0vTHM86A+mgvjl?=
 =?us-ascii?Q?9gTrkBsg2O4ONIjvXhBzlXEWweSYrrpmqH+sGe1fblBh4aZ4FfD4NEQSZH+g?=
 =?us-ascii?Q?N0Ppk0xICQVj3Weadw50fAqnfakxEyrilWdXKNkZ5SQCyhizgY33y4DQERhc?=
 =?us-ascii?Q?5+uate82A0cL9if8Dq07YDLZpai1RGFpYZcPqRLzhi7dVsGDcdvDgs8tfo51?=
 =?us-ascii?Q?hhRwQ4akuRD43ZZyNBPuTLyO0oF1RJcAgTFQHzWGvibFnLgO60JLCQtTigG/?=
 =?us-ascii?Q?coMnss6QT1U+u0JzlzGEa0fsq3Ikny6+ZYJ5GDeCdrdM8vHTAnbmrz60sjOH?=
 =?us-ascii?Q?K3s//Y7nHaGTxv2D837NiUbEHYxJ2tB+Pgco8KAdLOG1kW5VnBY+D3zAqPFm?=
 =?us-ascii?Q?MrniZxOrVcRNuBm0qo3f2ExuiLWSw5OE1Cen0PQkCbJhp5/UDKK1RgOG3dO7?=
 =?us-ascii?Q?ld3R+/ZMPh+EwXFICWKDb1wiJ7JAPhp4LScM//ctwo69XQBi8juOfH2xRPr0?=
 =?us-ascii?Q?Zse3Jqe+GiWA6JQLTdc+cCN0dZQ9uJMIYH23RGJjGmr/4fIcuI4NpmXsS3cj?=
 =?us-ascii?Q?yvvUwTzsAWNFKjKtSDiLtWOC4jdxZ3zNAjds6zHjb1xQFNU8Mp9/OWHDYQev?=
 =?us-ascii?Q?Rkhu21SiNVGtws9vcINwhivNp7qrNLOSIDLBsGWAulTbmzoayq8sE528Y+0k?=
 =?us-ascii?Q?FA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 877770d5-bf58-4296-463f-08dbd00cd607
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 19:02:55.4341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 79QI5u2JyZIk40hmwAoxaXCyznrFiRUhVa/51PgH4XC07Ngbin/ncRzPEfD6FCZisgHey1B5qlz7C6dRk0sEAlIsAs5YZpQG3wX4cmE4aug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9908

of_match_table.data contains pointers to struct platform_device_id, not
struct fec_devinfo. A pointer to a fec_devinfo structure is stored in
platform_device_id->driver_data.

This BUG makes the driver connect to a Generic PHY.

Discovered on Freescale i.MX6 Quad SABRE Automotive Board.

Fixes: b0377116decd ("net: ethernet: Use device_get_match_data()")
Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 5eb756871a96..b0decae956e7 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -4285,6 +4285,7 @@ static int fec_enet_init_stop_mode(struct fec_enet_private *fep,
 static int
 fec_probe(struct platform_device *pdev)
 {
+	const struct platform_device_id *pd_id;
 	struct fec_enet_private *fep;
 	struct fec_platform_data *pdata;
 	phy_interface_t interface;
@@ -4311,9 +4312,10 @@ fec_probe(struct platform_device *pdev)
 	/* setup board info structure */
 	fep = netdev_priv(ndev);
 
-	dev_info = device_get_match_data(&pdev->dev);
-	if (!dev_info)
-		dev_info = (const struct fec_devinfo *)pdev->id_entry->driver_data;
+	pd_id = device_get_match_data(&pdev->dev);
+	if (pd_id)
+		pdev->id_entry = pd_id;
+	dev_info = (const struct fec_devinfo *)pdev->id_entry->driver_data;
 	if (dev_info)
 		fep->quirks = dev_info->quirks;
 
-- 
2.34.1


