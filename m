Return-Path: <netdev+bounces-19756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A674175C1E2
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 10:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C6441C21628
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 08:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0628379D5;
	Fri, 21 Jul 2023 08:42:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAE21FA6
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 08:42:29 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2081.outbound.protection.outlook.com [40.107.22.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC00F2D53;
	Fri, 21 Jul 2023 01:42:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZqKYuhTP9I/bkvxjQ+dNN4np1FZJxk+xsia8XyrxmPmUC+PM+icaLi5o1oU9E8RMSM2z+xUA9ppcBtDkYqCVS2hQQHla0tEv5+BR1scNjPqQjGLkkaRX0UKrVyd+f2QGEAv8O+8Sf/bYOCBzrizl6FGbMroqpHaNpt7x8+PU1ZMflyfVKSH3vdir3oH+3+sSz6ulJdX9cKu2Hp6BtASWtaipv182pAeEAcO3Q7y+zNzSOYan7Sr1ye9yQxVdrNVEvUpVbBqu1JeNSIitPg/Vfj5mn7hqd6ckaLgX88F4D4A+CsOsgxyTim8VNv0Q4EaKDMkyj45BrXgrUyPj5+R5uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/GcnfV2oz4KKVcHPmS8LiJ1uOBSQU21D0/b47/naXyw=;
 b=KZ1kBeaqi6AI0WX9vt8JCtCbhpt+LKxnZH5x+cnzQMBAl9ZF7Vk6b1a/g/d8yYf8mBv57A2gXuhLwiKMn5/uMBN14F+oPhEI5Ho2onQR3E1EZDCJ2UQleqc4p8VuwYgzzS97KmrzcbcVDU66RfVH05D39zYEXsEfWqwXiL+nr5ifZdrBDyOGqfK2hgkr2B271J0UTM/2CyS7RlcekwKNZ+9vLyyKo1BJtwPOL8yq37V6dMMTBKFYdcjF2oTeH2WKwBH2XOvUpI1un3LyOz3iz5gFhDtfTgtuMgKEIol7nWnhWwuFCWgv9RIokiub1odsISYGBH/4W09TE77/+tuoPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GcnfV2oz4KKVcHPmS8LiJ1uOBSQU21D0/b47/naXyw=;
 b=iZtYkzv8rslDIIsZEYljIZuPGydMn7AGQlwGOZrfhuj52ua7aTAOgGcPJV8ccTy0nihjfqwnyQwHMEJKTV5+qcZmvUOlw08rNNmIK8AMboPUAv2iOQNhx5kArsfArCRT5OZLEMzrteS7UpAu7GiwoOk0sEfwVu7mAp702xoaY/0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by PAXPR04MB8831.eurprd04.prod.outlook.com (2603:10a6:102:20e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Fri, 21 Jul
 2023 08:42:24 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e%4]) with mapi id 15.20.6588.031; Fri, 21 Jul 2023
 08:42:24 +0000
From: Wei Fang <wei.fang@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	netdev@vger.kernel.org
Cc: linux-imx@nxp.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: fec: avoid tx queue timeout when XDP is enabled
Date: Fri, 21 Jul 2023 16:35:59 +0800
Message-Id: <20230721083559.2857312-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::16) To AM5PR04MB3139.eurprd04.prod.outlook.com
 (2603:10a6:206:8::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM5PR04MB3139:EE_|PAXPR04MB8831:EE_
X-MS-Office365-Filtering-Correlation-Id: b35553fc-0b43-427b-3d01-08db89c66750
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	edL8ImwN12enSrnm/l0Nfl0+yoyXGfpDb+U5XoHqSYjkAOUbU9uofvfE6qjkukJVYdngWCpOtWQlJwvAbgBxjDNt8jNEzYUQDCHu15ZUGHVetFaPRXRaz556tEJ2lzmD0Wm37+S6Ava3nehGN7edY4xQ1jhzSWFvAFPGLB8OtqMnC8cXvMXAVXUvLOna774w/qqLd9I0Yo+fAKfLroeOzCUdMWdznUR2ea36dRse4Ba4HZadPGC4sDh3OzoXdMHgtPEnju4KlCGwY06xvwB30ZN+A93T/Q6cARuJpRYXj08yIFKaLh9wdA7TQnPeSQjYs97VbFPUkki6vSbLRLwwRQzX5ww5peY0tpHd/0QNyhfTeVDy8pmQmYR8AwAFnP+uk0vtg2vNQjUGI+H0JG/h0dKrEo4p4rApfDLjnyKht1NeX1tvg1bGU6njjqUOy7q9XvFor+GhQ1eU6yznSRnAJEOsbewZuwutDpV4Qjc92tAJc2Pt10JNLKj1opBGt7f1cSu7yA1nxEistt9VsDTwQGeKnSHNmtdl0VZezbTsTS8dCWi3IklL1B4ZMvEZHghMAlqPl1oGtd0LO24Xva1t/IrnMJJmEynOgyKHHNRSG75hZp7H0xInU4yifX6mGd22
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(396003)(346002)(39860400002)(451199021)(38350700002)(38100700002)(478600001)(26005)(6486002)(52116002)(6666004)(6512007)(86362001)(1076003)(36756003)(186003)(6506007)(2906002)(44832011)(83380400001)(41300700001)(316002)(4326008)(8676002)(8936002)(5660300002)(66476007)(66556008)(66946007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZqXSPP6rU9mxPFwUFTEDaXH8zno5bNq5NYeuExPzr/z9t+jXrYKS9n3I8wve?=
 =?us-ascii?Q?q0+OzU9sH27BoUvG68mTF0LmnooTLtRliQw1G/0bfMGD3t6Y99pqHRcDAqVV?=
 =?us-ascii?Q?oU5kuBEvF9YefFyCwwk0C2AVPjjabmG7ImJwujYpKbcC28Bt5wCyJ+pGc+/S?=
 =?us-ascii?Q?Rl0vL4zF5j3fh4b/HlZAhs5gOFchwfVacF9UUD7fWgRlx7LsAmMLF9cHiWrE?=
 =?us-ascii?Q?dCVnI7oZxcN80rPKq1+Xc500YQBM+ICXrrP7dx6PSIXn5YF+enCTR+eyqwhn?=
 =?us-ascii?Q?M20wzrzfdiNohq1HMf+hjWPy+RM0PDSKUBxPR9Lg70Z2oa0qz75K9RdBovxl?=
 =?us-ascii?Q?sWn90Dj7wrBZ9JwGlKtcnjWgWVVBfIcTj/qCTRNwa6H/etyOuTty9fj5Cqz9?=
 =?us-ascii?Q?SKrhpV6V7iiUr9oaMOVVfcVW5zuLvkRyfzPawIY6/d3G9s8sUtQ24OvLj4TU?=
 =?us-ascii?Q?fAnUCNZtimfJ0D+gZ09c2dtSbPbZ0pDrmJ8YX6YBQm8oumnTe4FLOdGeLZBf?=
 =?us-ascii?Q?RFbj/CoON89eoXsAvikgBFIxA/BdXps/1CvL00B9F/0YbAWzjxr37qQ4kvRY?=
 =?us-ascii?Q?DOQfZN4CSTfHAHyrjPak49rtiKWMSFdHFSQ8Buhmt7dj9VG8JgBAzNTudDPw?=
 =?us-ascii?Q?SIEp/J1c0BHlhojhYik1Q+srid8KZM8gdVqYpPTueZxyPZ0wY9Bn7NqJk7On?=
 =?us-ascii?Q?EnLy7EkmZEFxa/jRJ5VMeOjiioCJTbTWX+yiop0KFz4CCW9+Z1r1YxvXbHXS?=
 =?us-ascii?Q?ZEv7pjLcturm+TuOJ7fk79wU0HdzDrCQx+6EtCXUMyFxgWrSIwJR/rBsi8vT?=
 =?us-ascii?Q?U0M3A/4WT33/P6IFGPLx/hcfWoN2zwj/gQ83X+tdCqa5tSlRZAlalB9ji2bO?=
 =?us-ascii?Q?XlsV5rMwxmKvPt54gW733SiUKjsNFXLYNg4XriVBlwpn/dWiSSxu+p6dWznZ?=
 =?us-ascii?Q?XvGVEUOVwuLvh6us7AzcmOWGbSj975dfCHxxTObbIJvWxs0MpJqGktYYLpiG?=
 =?us-ascii?Q?myq2d1tc/TZpJgjKxD6zgBqdEoELb3u2UGUWH4WYxFM9+OyEO4vTH1XZ+Y6k?=
 =?us-ascii?Q?i2QEdMqpkR5n1UMDrYoI2Lhs6gA/oPw+MQoSheyzGMrtmw8OIVdahPQmx3qu?=
 =?us-ascii?Q?f6oDNWlt1GjW1oj11/x6SI3L5BM68cvpxICw3USnH6ojPFdr+dLAk2XJdHkw?=
 =?us-ascii?Q?GMudAm49c8LLBTNbs1U16DP4Rcf6sEiQf75LODqVV47o0c3WXqjhy1WYefUv?=
 =?us-ascii?Q?FtyhiIHhokmZttbDtmR4ctWaZNkyt7nP7622KKlqUzzL5CWaxaMEjuJJX04Y?=
 =?us-ascii?Q?w/iQwtrx5QYtOxEekMnoaETDQ9Yc4NdL1+OUq4W9Lm3O+/1MX/FQaagDaUp+?=
 =?us-ascii?Q?+HGxls9tRNkPylh+QUfVvkbZDDU7idm0X0RMzP+la2Xzd8nBBD17mdRbYgnp?=
 =?us-ascii?Q?iQIPVbjTSXBuAE9IPZ7sIYcG5rgp+2HYQLhLjZSBsE5CI2DMXKRlfLI8FEZE?=
 =?us-ascii?Q?Ss0vRY1VvMBhQKfCCkUwBdbQ36ITODq9MuhgKdco9Q+h18xvAVTym0REcjTi?=
 =?us-ascii?Q?LAGPSf8XZiVQDdAkaTY7RsDFKZE5CeocIMTkzrnJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b35553fc-0b43-427b-3d01-08db89c66750
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3139.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 08:42:24.1375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XVhii2nsSnOZK83ic8X9aS6iJNOl8e6xmWMTQxZTcXl9ZCoKV5dKTNcWf64cY0pH2E8tYhl40ceh9YXfoWh88Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8831
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

According to the implementation of XDP of FEC driver, the XDP path
shares the transmit queues with the kernel network stack, so it is
possible to lead to a tx timeout event when XDP uses the tx queue
pretty much exclusively. And this event will cause the reset of the
FEC hardware.
To avoid timeout in this case, we use the txq_trans_cond_update()
interface to update txq->trans_start to jiffies so that watchdog
won't generate a transmit timeout warning.

Fixes: 6d6b39f180b8 ("net: fec: add initial XDP support")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index ec9e4bdb0c06..073d61619336 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3916,6 +3916,8 @@ static int fec_enet_xdp_xmit(struct net_device *dev,
 
 	__netif_tx_lock(nq, cpu);
 
+	/* Avoid tx timeout as XDP shares the queue with kernel stack */
+	txq_trans_cond_update(nq);
 	for (i = 0; i < num_frames; i++) {
 		if (fec_enet_txq_xmit_frame(fep, txq, frames[i]) < 0)
 			break;
-- 
2.25.1


