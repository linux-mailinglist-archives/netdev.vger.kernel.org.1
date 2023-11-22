Return-Path: <netdev+bounces-50152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A087F4BA5
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 16:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF6FAB20D33
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 15:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9EB4CDFB;
	Wed, 22 Nov 2023 15:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FycSbY4X"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2072.outbound.protection.outlook.com [40.107.20.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C4D1708
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 07:51:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ipCCXBK+K6tHZYdnMjYWgfSPiVZO62OgydZPo5K4qc/T0xO0Y9d2q61ZiMT+hGgC9A/Kl4LRI7vZcx988HfoB7ND/GD1R9jfa5q5PlFoFceDIIWAjR+mTw6XOmsVAPB1llReoz5xMulJRRz8kkOQ1mDunLHN6uXoGEJbg8PR4V/0ceZw4EEHKR2VpVB2DxqiwkdzROJmXBnnVFBwz4UNasA2TOPczAM5bDlx/i1De9QpjmS0e0AJ7Dcek8pK4JwGg0vFxiEJ2yq0E1KiQchdz70npojR9B1lbzPVQrKfLFzMLFwHnixAaq1tT6Rj2OSUehZ6/c2rrHj3ZSIWEWw2lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=28qgznvQq4u962BYYRC61aD08Cz/M2rP6UPjafOnX8s=;
 b=a0FJ3+flJkl9vCp7/oqzk705+WPdmdPnf3Bjf970P9ZHoQOI37rwC1W2lcjo/L5i282V/5GHZgC7QnaarodUokzS5YLyuc3QfdegIkC9m3J68AXZ/svEbrYui0POa1wkyokWC7OUdBYS3lvvCM6fSlrxgABwlCkNVM3dPtswlfijd+JCgaOkPpCWZvXqU0W8rS/g+NHaz4n2r+efVy/dTx63sX66ARN1UmeXZMo3nPhO1T2E46DAFC9rewCA+aliNNX/YjXz5K68MNPlGVdU83V4gUIk/TnjGTNrV8/gjTMncQm30j2AlzBp2qaEVbypeU88p1czVyXBbBox4+TCtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28qgznvQq4u962BYYRC61aD08Cz/M2rP6UPjafOnX8s=;
 b=FycSbY4XFSGt/9WxdlMPfsYiaSAjIAypbtm2agfLe5ZC+jRvc25DL+KLO4hRmWHQIdEfMdCoCqXej7dxlZYPfFs8F11tCbSWBte4ZkxRFHK951NI678jayO5YTVU5P1ADo/6q7goiAos2qVBQpra/xCzoJ31KvHmTnQuwPbtpXg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com (2603:10a6:150:21::14)
 by AS8PR04MB7878.eurprd04.prod.outlook.com (2603:10a6:20b:2af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Wed, 22 Nov
 2023 15:51:33 +0000
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35]) by GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35%7]) with mapi id 15.20.7025.019; Wed, 22 Nov 2023
 15:51:33 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: andrew@lunn.ch,
	netdev@vger.kernel.org,
	Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH net 3/3] dpaa2-eth: recycle the RX buffer only after all processing done
Date: Wed, 22 Nov 2023 17:51:17 +0200
Message-Id: <20231122155117.2816724-4-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231122155117.2816724-1-ioana.ciornei@nxp.com>
References: <20231122155117.2816724-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P195CA0046.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::35) To GV1PR04MB9070.eurprd04.prod.outlook.com
 (2603:10a6:150:21::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9070:EE_|AS8PR04MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b8eaa75-a8c8-4d7d-4c50-08dbeb72e6ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	D2a6S93ADGcel9DDBv9nIoq+V2JU0h7kMaW170DiN6YB1qi71LKtRD7y0yi3mj2588tbXVOD8SsAWxOiNGzP6oDaE2i1NV3glDAhUCot2BW+goV5YpHBS+vSaYlhipHDBycj/CHFcvFBqpwsAB5Q1CxriMNTQTa0mZcTYiRbjtFEWSAFwOPwCgjJ2ooUiNBYJNW9dhYegyZCrKOWopyHwBvhOv38rWi4ge+TJKzqzDJgBAUp8wCuN6F7UBgUtN9+2M4yInUzudv4l+bYjOyCxelP7kMwOu/YZfS1Si7AXpZ1+LTRbosZ2Da8k8VTe0GvNKlUo9wBh+xquPqpN8mIWx9R+g76njDB6FLYFMAckYhuOMNbNjpM7GteWRWk8rwb0YQBOx0AIROl9aGe/qMPc//2kamze+A40AzSnuOYBuxau/zRq2Q8/xtmc39kDOdTvmOdDp42+5JI+SeIf3FLj4UvQYsaWST8ZtqEbwDyclWi9RlZgbGyl7+gOK/q/MEXMLhVL6ZWqDKmhOGEfvUooZfmInWceq5auXoqXkeBPAfjA/NLhrZgMsrIvHcusXFa
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9070.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(66556008)(66946007)(38100700002)(66476007)(36756003)(86362001)(6512007)(6506007)(83380400001)(26005)(6666004)(2616005)(6486002)(2906002)(316002)(478600001)(1076003)(8676002)(4326008)(5660300002)(41300700001)(8936002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YhPcwwRS0smwapVLAAxnjKzMh9/6j5JNKkNMEesab5w2C2C8Lk/nCaHS52wR?=
 =?us-ascii?Q?fUWCotGrDKVKn/Q0iNGjiSb2J9o2KSYT/aT2pt0bR4BxTcI7TA6xTwMQq0Fo?=
 =?us-ascii?Q?VHaDFkyHiOj1co0eA0CMrJ6U9lvXv7VNSxkdHnHgP9K4ANBekGDtXXxSic2I?=
 =?us-ascii?Q?hRHb+JJpXNi1dkOvw6niwTMV41RnS5dEnsMmQWTtHnL7i57V49poKPMW2Ijw?=
 =?us-ascii?Q?FxD15JOZpKSUTPJ/QZCWfVIRVCkw7MRIgudCM6JhS8HuubWknbged4YomkV4?=
 =?us-ascii?Q?rRVy6Rgdu7E0JSXO1y3BwjnQcc+x7C9oZhFgzy11/XffLAtQRg8TCo/1Elxc?=
 =?us-ascii?Q?3SFXIXRexXjS4g9yYZKP4Wo9DPR2ypBNUNpkPmPHam1qCIw9VjH61EgzdChq?=
 =?us-ascii?Q?si9jtEhWpNLKowphcCB/HYct2b6gxuAYo9YGX11nLoUzYi1la6g4N/ff1rCu?=
 =?us-ascii?Q?n+dFHm43ojB9lKcgjwCKt0429p5cotfr/pc4S3XXSG4Fzx0Br25LhDg1kRau?=
 =?us-ascii?Q?L2rACP3P84SHzgQadXCzq915L54Xu6/RTpvstw8v+VVOiIXTc68XBu9IKJeQ?=
 =?us-ascii?Q?KKVgtNxvln7DSoMnYDhyC7p1Keycj7S0kveQb6PPTDko0tM2ureM+ovGZMqA?=
 =?us-ascii?Q?0IRM6208rijOYMR/UqBAYNr/RDNauhooLjl2u8nBiUlVaXaldfAnwXkAOa+k?=
 =?us-ascii?Q?R9IgC27wuxvg6uCGwNopYZ+Ku47OmZstw6Dcnh02wnZZqGzX0hOmVV1ZSECb?=
 =?us-ascii?Q?17Q+TWM60xhsj/64RlopJHghM6VSTIr5H8lyfWAAbe9SCUNA7zMUckR8zDEx?=
 =?us-ascii?Q?x48fWK+ssK5GgIBnPjLg6+YKXP0mZVagjWVuEj+iB3oHFDiInO9o52f1GVHk?=
 =?us-ascii?Q?tU63bvQRXs9OMlRvksOYeKxJsZjwKS6JZDjgOUF6Aiqhvmzcrx6zrsB+7MQx?=
 =?us-ascii?Q?MyOlXFau17Q6zvpLo6Z2mqvtK/s9l0erIEpdSSId22VHE5OWiYbFTxLCTl/d?=
 =?us-ascii?Q?gG9bkF9yjqMyeuh33H7rEYp1W5SZnnQcW6LSdPqEzsjplFLuTq0YeyMqeAFC?=
 =?us-ascii?Q?l4aYJInV+0ezKc4EeJdetI1cIY8/CDo133aZ1OzqwxOF5iV9Qd98I0LYE148?=
 =?us-ascii?Q?XoRdLv8oHE0p5nGIpH5WEdCPZF7dE7Lcjc/TRVSzaEISe/oEXfwtYDTkZOJ9?=
 =?us-ascii?Q?jtfPLxx4gesMny/YzyUI5t0UG7ajdR0d3P5lAdn6c9IcTXtt0LzD6YtKpJMT?=
 =?us-ascii?Q?3FtWrK/12nyMuBggKJcofofvtdoou8ApiSJJycXObgQ8ecJj6SJAE4a4yCd9?=
 =?us-ascii?Q?TaKaczM1R/Z5PUMqZQhTFIJQcxL8IXAA5h0bTP0LiJkWWOyMIQnPYV+3hjxp?=
 =?us-ascii?Q?JEiiWK9icOqG95DA5AblxRkd5PPzZDc9pK8fSBB9mMr7PEs37JOS2N05ADCm?=
 =?us-ascii?Q?5uCIexif9a6hCeXOMTzQEoPK9yc3ZBu7wEux7g2QR4KuwgIfKUwZp6n6+UZA?=
 =?us-ascii?Q?DMZrDgzlPPcuBirqGCi4X/hQdf6IZjClu86HGfgqimJC2m4LECkesygMFmO6?=
 =?us-ascii?Q?eYAkNUQPzXUDnSanfrWMqEc+KT+vVJPNdxPoPOfI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b8eaa75-a8c8-4d7d-4c50-08dbeb72e6ca
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9070.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 15:51:33.4822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UyF0kHgs3IdNLMnAImSKH1LYWXvXsFIIGPOjx+gyrL9Rl9xBMT2NkU9z4+RMUR970vFTVhx0XUZVpJ3/+5U9jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7878

The blamed commit added support for Rx copybreak. This meant that for
certain frame sizes, a new skb was allocated and the initial data buffer
was recycled. Instead of waiting to recycle the Rx buffer only after all
processing was done on it (like accessing the parse results or timestamp
information), the code path just went ahead and re-used the buffer right
away.

This sometimes lead to corrupted HW and SW annotation areas.
Fix this by delaying the moment when the buffer is recycled.

Fixes: 50f826999a80 ("dpaa2-eth: add rx copybreak support")
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
index 774377db0b4b..888509cf1f21 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -516,8 +516,6 @@ struct sk_buff *dpaa2_eth_alloc_skb(struct dpaa2_eth_priv *priv,
 
 	memcpy(skb->data, fd_vaddr + fd_offset, fd_length);
 
-	dpaa2_eth_recycle_buf(priv, ch, dpaa2_fd_get_addr(fd));
-
 	return skb;
 }
 
@@ -589,6 +587,7 @@ void dpaa2_eth_rx(struct dpaa2_eth_priv *priv,
 	struct rtnl_link_stats64 *percpu_stats;
 	struct dpaa2_eth_drv_stats *percpu_extras;
 	struct device *dev = priv->net_dev->dev.parent;
+	bool recycle_rx_buf = false;
 	void *buf_data;
 	u32 xdp_act;
 
@@ -618,6 +617,8 @@ void dpaa2_eth_rx(struct dpaa2_eth_priv *priv,
 			dma_unmap_page(dev, addr, priv->rx_buf_size,
 				       DMA_BIDIRECTIONAL);
 			skb = dpaa2_eth_build_linear_skb(ch, fd, vaddr);
+		} else {
+			recycle_rx_buf = true;
 		}
 	} else if (fd_format == dpaa2_fd_sg) {
 		WARN_ON(priv->xdp_prog);
@@ -637,6 +638,9 @@ void dpaa2_eth_rx(struct dpaa2_eth_priv *priv,
 		goto err_build_skb;
 
 	dpaa2_eth_receive_skb(priv, ch, fd, vaddr, fq, percpu_stats, skb);
+
+	if (recycle_rx_buf)
+		dpaa2_eth_recycle_buf(priv, ch, dpaa2_fd_get_addr(fd));
 	return;
 
 err_build_skb:
-- 
2.25.1


