Return-Path: <netdev+bounces-55722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD1780C150
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 07:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFB35B20927
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 06:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5EE1F600;
	Mon, 11 Dec 2023 06:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="lDTHzZh1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED37CD
	for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 22:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702276103; x=1733812103;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8okHNn4X593Tkh2sf5jfHRxhEuyxbOmoKmPlGUX7zzo=;
  b=lDTHzZh1LTuhyQxYSnq0cQ9vTrMiJSOGcf+tXsuv6tx8JIu9wIyYb6rQ
   r1Q7EGBL32NvvBCWpWQR286bXZdgdkmYNkynjqIotj9jpkkAgmFWqW0t2
   p2QigBGSwuTpjQhMCf9LpHRdO6OU3+xiayEo1SPBLhTGunyebF0aAIkp4
   U=;
X-IronPort-AV: E=Sophos;i="6.04,267,1695686400"; 
   d="scan'208";a="367685136"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-d2040ec1.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 06:28:20 +0000
Received: from smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2c-m6i4x-d2040ec1.us-west-2.amazon.com (Postfix) with ESMTPS id A1C3D40D52;
	Mon, 11 Dec 2023 06:28:18 +0000 (UTC)
Received: from EX19MTAUEC002.ant.amazon.com [10.0.0.204:12719]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.54.31:2525] with esmtp (Farcaster)
 id b427d11c-9bc7-42e6-95d6-5191142ec41b; Mon, 11 Dec 2023 06:28:18 +0000 (UTC)
X-Farcaster-Flow-ID: b427d11c-9bc7-42e6-95d6-5191142ec41b
Received: from EX19D008UEA003.ant.amazon.com (10.252.134.116) by
 EX19MTAUEC002.ant.amazon.com (10.252.135.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 11 Dec 2023 06:28:17 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D008UEA003.ant.amazon.com (10.252.134.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 11 Dec 2023 06:28:17 +0000
Received: from dev-dsk-darinzon-1c-05962a8d.eu-west-1.amazon.com
 (172.19.80.187) by mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP
 Server id 15.2.1118.40 via Frontend Transport; Mon, 11 Dec 2023 06:28:15
 +0000
From: <darinzon@amazon.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>
CC: David Arinzon <darinzon@amazon.com>, "Woodhouse, David" <dwmw@amazon.com>,
	"Machulsky, Zorik" <zorik@amazon.com>, "Matushevsky, Alexander"
	<matua@amazon.com>, Saeed Bshara <saeedb@amazon.com>, "Wilson, Matt"
	<msw@amazon.com>, "Liguori, Anthony" <aliguori@amazon.com>, "Bshara, Nafea"
	<nafea@amazon.com>, "Belgazal, Netanel" <netanel@amazon.com>, "Saidi, Ali"
	<alisaidi@amazon.com>, "Herrenschmidt, Benjamin" <benh@amazon.com>,
	"Kiyanovski, Arthur" <akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>,
	"Agroskin, Shay" <shayagr@amazon.com>, "Itzko, Shahar" <itzko@amazon.com>,
	"Abboud, Osama" <osamaabb@amazon.com>, "Ostrovsky, Evgeny"
	<evostrov@amazon.com>, Sameeh Jubran <sameehj@amazon.com>
Subject: [PATCH v2 net 2/4] net: ena: Fix xdp drops handling due to multibuf packets
Date: Mon, 11 Dec 2023 06:27:59 +0000
Message-ID: <20231211062801.27891-3-darinzon@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231211062801.27891-1-darinzon@amazon.com>
References: <20231211062801.27891-1-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: Bulk

From: David Arinzon <darinzon@amazon.com>

Current xdp code drops packets larger than ENA_XDP_MAX_MTU.
This is an incorrect condition since the problem is not the
size of the packet, rather the number of buffers it contains.

This commit:

1. Identifies and drops XDP multi-buffer packets at the
   beginning of the function.
2. Increases the xdp drop statistic when this drop occurs.
3. Adds a one-time print that such drops are happening to
   give better indication to the user.

Fixes: 838c93dc5449 ("net: ena: implement XDP drop support")
Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>
Signed-off-by: David Arinzon <darinzon@amazon.com>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 9884ef3..c7bc572 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -1672,20 +1672,23 @@ static void ena_set_rx_hash(struct ena_ring *rx_ring,
 	}
 }
 
-static int ena_xdp_handle_buff(struct ena_ring *rx_ring, struct xdp_buff *xdp)
+static int ena_xdp_handle_buff(struct ena_ring *rx_ring, struct xdp_buff *xdp, u16 num_descs)
 {
 	struct ena_rx_buffer *rx_info;
 	int ret;
 
+	/* XDP multi-buffer packets not supported */
+	if (unlikely(num_descs > 1)) {
+		netdev_err_once(rx_ring->adapter->netdev,
+				"xdp: dropped unsupported multi-buffer packets\n");
+		ena_increase_stat(&rx_ring->rx_stats.xdp_drop, 1, &rx_ring->syncp);
+		return ENA_XDP_DROP;
+	}
+
 	rx_info = &rx_ring->rx_buffer_info[rx_ring->ena_bufs[0].req_id];
 	xdp_prepare_buff(xdp, page_address(rx_info->page),
 			 rx_info->buf_offset,
 			 rx_ring->ena_bufs[0].len, false);
-	/* If for some reason we received a bigger packet than
-	 * we expect, then we simply drop it
-	 */
-	if (unlikely(rx_ring->ena_bufs[0].len > ENA_XDP_MAX_MTU))
-		return ENA_XDP_DROP;
 
 	ret = ena_xdp_execute(rx_ring, xdp);
 
@@ -1754,7 +1757,7 @@ static int ena_clean_rx_irq(struct ena_ring *rx_ring, struct napi_struct *napi,
 			  ena_rx_ctx.l4_proto, ena_rx_ctx.hash);
 
 		if (ena_xdp_present_ring(rx_ring))
-			xdp_verdict = ena_xdp_handle_buff(rx_ring, &xdp);
+			xdp_verdict = ena_xdp_handle_buff(rx_ring, &xdp, ena_rx_ctx.descs);
 
 		/* allocate skb and fill it */
 		if (xdp_verdict == ENA_XDP_PASS)
-- 
2.40.1


