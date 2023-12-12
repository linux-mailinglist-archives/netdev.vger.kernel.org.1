Return-Path: <netdev+bounces-56528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EFE80F36B
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 17:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17F9A281BE2
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 16:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48557A22D;
	Tue, 12 Dec 2023 16:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PduCQHHk"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2062.outbound.protection.outlook.com [40.107.105.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0833B7
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 08:44:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Utf1lGPSKefFHtW/c0It5Is/WMBMDAAnXgxvNpSl0zVhPk+i1xE848AMWw6I0MrL4xmhw0VuzQr/azVUPtM46RZsFQ8MlfmYJRU4n9u5RGXoYXR8VKfv04qBN4l0qoZwSN7zJoZoF6hLW0hnvg8kCVtkNVgIDx0pLpOYltCT68VmGrzOCPjH+0kDQ4GmRQXEX5bgTkI455t7MTGY53v05hrlhbwbSQAPCitRrL29Igk28JcFMfUBQNChevj/Y/CoDVY5RdhZfVrG6lV1LOh8UFyN2J+6iK9RQbtuDV3Wc4oyg2jHRCC38pPxweqQRUa4cFIphmc5AQoBsv6TMhrhiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FuzJXYe/B1C6hGrlnjRSqyhqWkWUUfVsiu9ifk6pb04=;
 b=bG8OF11icilNCh8+iJi3W7B9jiOo/ZqUnKZD3oXAqoLBtF/FjYtGcD3vgcc5FacA3B6kJ4ca0VCLd3ABC0ErumDrL09MUfJjnZgSjeJ93iO3yNhiCWu51guROcOCsnNOZ3nhwzG5Xa3FkvHdPIsQYOhDHpUmCiE36TbkR9llMEy4fV9ZxIIVsn+JyaUM5TR2ZUwt5yJR0OokIuh1YiXZ9dMZCSMKlrtt0eludY0IrJDsIl8blN3mYXibxJ0f8tdI38IUhE1XC4LVD1t2mAfDtj8O3YLVst5WFDLUmK6CBi/d/sMcC4vGH76GKWUIeMBj8wyboEl0ZbFOz0QouaDGQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuzJXYe/B1C6hGrlnjRSqyhqWkWUUfVsiu9ifk6pb04=;
 b=PduCQHHknsuRKz6i8G1gFhh1F7t7tb7LHSfNwoOPU7/CwVMyzRBjN5mNpvJiTm4zCmLHAZb8LDlTqmVAOF6xO7vzR8EnkZ1M9qNEFyNqHffYyirFjktdoOe5ZznTeahkGwlgInvVPNYcSnuur1OjC3CXQTKUKQPHRS+dzt500h0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com (2603:10a6:150:21::14)
 by DBBPR04MB7641.eurprd04.prod.outlook.com (2603:10a6:10:1f7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 16:43:58 +0000
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35]) by GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35%7]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 16:43:58 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: vladimir.oltean@nxp.com,
	Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH net v2 1/2] dpaa2-switch: fix size of the dma_unmap
Date: Tue, 12 Dec 2023 18:43:25 +0200
Message-Id: <20231212164326.2753457-2-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212164326.2753457-1-ioana.ciornei@nxp.com>
References: <20231212164326.2753457-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P191CA0008.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::13) To GV1PR04MB9070.eurprd04.prod.outlook.com
 (2603:10a6:150:21::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9070:EE_|DBBPR04MB7641:EE_
X-MS-Office365-Filtering-Correlation-Id: 373ff575-6279-4add-1348-08dbfb318956
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	b0VIyWGSy0BbEaAlJof+wNxH+o8C5tajNEMS3ofMuNjNE6gJhNce/TRPmkcEs/JZADVK0WUBZ/blCq1ul0SnOG1/dMprifQiLIdLIHCgLAGxgoDRIwqx4Lc3FCmR4pxbp9R9lxnrjcjNezkr+aRYQX15z+7hv+eFFNkKRapngfFC13IaePa334YAga6/DeZxGFK2YFUKYYLFvrMQvMH0SD5WH4aX532+3hKiWfhTHAraE9y6XtCfyo8b4w4vFQ8QTf5TmnELcvglWjwVcCxOCm+tmY2olotpo0Ar1NHkHWr/n3x/dauXyrPHlnf7mb+v5i+EVuovRuGstzi0hjsWY6+AW9PzavmX3fq3c7MQ8j01JA4gdjhJkQYV9akLZrpPDtvX/Je1IaYRAFJNisZs4TM3lg30BZuoDTCQqk5FROvjXeC0ZpwEn3uOSZ005AHeqB3yHjhuGUhPfMZzfyMmdyUFCQhgKcjZCCExPsRqhjJ74OoU9DXD0O7JOb1KHFeFLv7kV8wp9/QdQ0zjJCYtdwSD3OIwsNOz7Ra6npdoFWVAL5fAiaKcZQntJ7ZVcEt2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9070.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(396003)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(36756003)(83380400001)(41300700001)(8676002)(4326008)(2616005)(8936002)(66476007)(316002)(66556008)(66946007)(44832011)(86362001)(1076003)(38100700002)(6666004)(6512007)(6506007)(478600001)(6486002)(2906002)(26005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ktifr+M3b4kxLyNYbD9gYI7wBbNDdXpJj4sG1Pc1usHiWGyS3+UmtO4QJl4y?=
 =?us-ascii?Q?qSFUL6PqG7SdSIk5bL6xaoJHRA3RPasyEmWw7GmuhMcAKaw1fo5Yba9CgMsd?=
 =?us-ascii?Q?teCflFOfoD8JMlOE01mfQO6ZpDdn9YE/Q2NU/CrItdg4CsjCjwZdI63e2BFc?=
 =?us-ascii?Q?eTxuGIk0Y6hzW/gvhtRb+EpAw/4RAp8AynDcf7BX2oPpfpySOvx5OW98QYsS?=
 =?us-ascii?Q?1PPaQ4vmM1ZSykkivgeJ1Ym70y41WbQJ2KqsVza2PAnK3dBTeFc0WRmJ41Nq?=
 =?us-ascii?Q?RqpgrSIkRw0GRmxb7QEfXYNY5Xnm6p8eeaK92umsmU3Z3QFrOm4GQEE3XQVR?=
 =?us-ascii?Q?bX2nsSM35KCLe2GJYRC2WS8MDxgW4OqyvIXRPRC6lMwPouxf/4BozZsp5Hlt?=
 =?us-ascii?Q?Ve4tjSnAN2PxjK1kSOfg7Z8AZ1nOUHVY1hFtn5xyl8uDqnp47cY+FBQyLEH+?=
 =?us-ascii?Q?gI6eZHxhq++6BHRrasQ4EZH1mBSJLRTC94LKDJq1P6dSTzkRPzM8sAQqLwyX?=
 =?us-ascii?Q?FHNy1O3DN7h1lFdU1qCH3RtU+pR/zRJ3YEPTHwAFERw0FrOxy480tXoBloHc?=
 =?us-ascii?Q?TLlrajs75Z3nk37U6T6SAtp0m+WwPtSI8OEsCKpipJ+djzJMUeDYnz+1MbKa?=
 =?us-ascii?Q?JdDtNAOGYKGtDJq2o8wOM5cy5ou28QvBpwNH5Joeubd+rrXeS9lIwmpcg2rE?=
 =?us-ascii?Q?MG/WbRIHmMd0vrfODswEjegjZX7Pk9EfxkvLIVvwNnmEluXU/xhtiTk2KPMY?=
 =?us-ascii?Q?pzoJByfEN39ON7qzrCxrssfyEK3+pk4yUHTmTq9+zpX8L8oolfB9EKWHBclx?=
 =?us-ascii?Q?hJJp888IptC3to30hU+p6sZQ/AXZ7ySuh/XlHemw7hM03+TxOMH0Er65gGTR?=
 =?us-ascii?Q?FzbL6IfjrKzGHbqyJ2/wl2fx2R9n4fxcMIY7Uxa84+f5HJk26aPOZepHoYAN?=
 =?us-ascii?Q?IBfirL7zKAdtk6OnjArzQ3/grjx5qj7wPddkqeRTEqMRbMBmgE8G6EiXYVWI?=
 =?us-ascii?Q?N66Vr/Hj7T7+RPsKZhsWCNxGngPEkse36UjZYkbGEygB9PmIixTKFqY+3xm6?=
 =?us-ascii?Q?oW2FWToeHjo00wiY1Gcic2aFKcYEF0EZIQMvrXjAz/NzHUmMdugEMrEMhqwk?=
 =?us-ascii?Q?qhZP/q72wpLUtSF0CAxfxXpzsuae8bMm0wvpC3aps2HJnQwAXzGYlE95wXjm?=
 =?us-ascii?Q?GMMFtLdCWkze0CgXb2TmV61202zKEJs9W4OiVabNlhW3cIVYoztyGwIUL5yd?=
 =?us-ascii?Q?2Xpf+5fQT5iDPBTg9PkVt4I7W85wRflL37GNucRKkTFC5jGffRFBhtU3oMan?=
 =?us-ascii?Q?GTmP17cmzwW1mbkNR0If9k1OBfYAOztCkC1I3RMpwK/1+XVnztv7fOd66ljF?=
 =?us-ascii?Q?BcrAE86XsekhSPsiKI6i8bRiC7IY8aMSpz4GIr9ZaW9LgCCEBwQmBRziIXeq?=
 =?us-ascii?Q?YAXGnagsN+WmyK5664si+17U0HGmRgF/poAWMBz+ktulXsFJrW/sSDLTQt40?=
 =?us-ascii?Q?UaoamCxFR4av+WVsGiLD5X8x/KdTydqyuYUMIL03RM2JIQZZW0+t3QX1VLXG?=
 =?us-ascii?Q?azkKIdcaxdTVMYHrnPOKnJPvII77t46aCiDwThxG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 373ff575-6279-4add-1348-08dbfb318956
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9070.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 16:43:58.0333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ttXZLEqp5KAE55zjuTxgz9CtY24N5vrKDUDQF26+YUSCtJMPEpdBkqZtKtri1MlNd1x8GZFOaxWYGqfOZQ6o8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7641

The size of the DMA unmap was wrongly put as a sizeof of a pointer.
Change the value of the DMA unmap to be the actual macro used for the
allocation and the DMA map.

Fixes: 1110318d83e8 ("dpaa2-switch: add tc flower hardware offload on ingress traffic")
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
- Fixed the same issue in the 2nd dma_unmap from the remove path


 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-flower.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-flower.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-flower.c
index 4798fb7fe35d..b6a534a3e0b1 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-flower.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-flower.c
@@ -139,7 +139,8 @@ int dpaa2_switch_acl_entry_add(struct dpaa2_switch_filter_block *filter_block,
 	err = dpsw_acl_add_entry(ethsw->mc_io, 0, ethsw->dpsw_handle,
 				 filter_block->acl_id, acl_entry_cfg);
 
-	dma_unmap_single(dev, acl_entry_cfg->key_iova, sizeof(cmd_buff),
+	dma_unmap_single(dev, acl_entry_cfg->key_iova,
+			 DPAA2_ETHSW_PORT_ACL_CMD_BUF_SIZE,
 			 DMA_TO_DEVICE);
 	if (err) {
 		dev_err(dev, "dpsw_acl_add_entry() failed %d\n", err);
@@ -181,8 +182,8 @@ dpaa2_switch_acl_entry_remove(struct dpaa2_switch_filter_block *block,
 	err = dpsw_acl_remove_entry(ethsw->mc_io, 0, ethsw->dpsw_handle,
 				    block->acl_id, acl_entry_cfg);
 
-	dma_unmap_single(dev, acl_entry_cfg->key_iova, sizeof(cmd_buff),
-			 DMA_TO_DEVICE);
+	dma_unmap_single(dev, acl_entry_cfg->key_iova,
+			 DPAA2_ETHSW_PORT_ACL_CMD_BUF_SIZE, DMA_TO_DEVICE);
 	if (err) {
 		dev_err(dev, "dpsw_acl_remove_entry() failed %d\n", err);
 		kfree(cmd_buff);
-- 
2.34.1


