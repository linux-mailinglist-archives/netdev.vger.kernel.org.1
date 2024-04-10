Return-Path: <netdev+bounces-86471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1896E89EE9C
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 11:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 946D7B24D82
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 09:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CDE159208;
	Wed, 10 Apr 2024 09:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="mHgiuBQe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DB6156C69
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 09:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712740466; cv=none; b=LoW3umXkbXppeUgDpAeKUL/l/cS679gpd7KKtvW+85HCHWQtCCgy2edNnjH/1vvTYJhP0uug0Y4OB0no/NDzLmICr9+YISJ/z6Luu9UvwnDRm8vbnifHjvOZUxy2M72GmSo+/gQKKxDc+yhewsvJVw2AEXrxs+C+OFy9kFjeBto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712740466; c=relaxed/simple;
	bh=+5JFjDy3bOZ7IMG7kx/Nq5pui+8+vfJCKUudoICMfHk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VH1jb5lB8jQ6l9a4x0S2ewsUdXpc+UpoPdkcpvHOHy5mu6oAMtfKOgRK2TO5jHcCLlO37NZQtbY/ZDqL7L2svVN/OFImwSzDpWkp1DhCqs9wlLccj9CMqxR1wwKxDMX+cwKWwts17aTRsedcYcLyg/nKKx/dP7VwlYwVEfw0yMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=mHgiuBQe; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1712740465; x=1744276465;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3Mys68B/T+QyG2Wvz0wb5/Nns8ktpu2TcYEHj9bBcNc=;
  b=mHgiuBQeEBomwv+mBGFtC5RIGMxu3o+n7qx3ikrbqJ8emp90IE5TC0MY
   +pZ7QvdFjeN78YtbsSAWMVL0A2dSBcCDikCf4dJM9zCTJdfDAputgOD1t
   bMv/32Ju70xTp+cHO7FrbkA8gwOWWX69ilQ5LIUWGLvhzq3tEPc87/OVS
   g=;
X-IronPort-AV: E=Sophos;i="6.07,190,1708387200"; 
   d="scan'208";a="388716189"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 09:14:22 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:43401]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.38.10:2525] with esmtp (Farcaster)
 id a82faf3b-690c-4655-b726-d0366349d00d; Wed, 10 Apr 2024 09:14:21 +0000 (UTC)
X-Farcaster-Flow-ID: a82faf3b-690c-4655-b726-d0366349d00d
Received: from EX19D010UWB001.ant.amazon.com (10.13.138.63) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 10 Apr 2024 09:14:20 +0000
Received: from EX19MTAUWC001.ant.amazon.com (10.250.64.145) by
 EX19D010UWB001.ant.amazon.com (10.13.138.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 10 Apr 2024 09:14:20 +0000
Received: from dev-dsk-darinzon-1c-05962a8d.eu-west-1.amazon.com
 (172.19.80.187) by mail-relay.amazon.com (10.250.64.145) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Wed, 10 Apr 2024 09:14:17
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
	<evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>, Netanel Belgazal
	<netanel@annapurnalabs.com>, Sameeh Jubran <sameehj@amazon.com>
Subject: [PATCH v1 net 3/4] net: ena: Fix incorrect descriptor free behavior
Date: Wed, 10 Apr 2024 09:13:57 +0000
Message-ID: <20240410091358.16289-4-darinzon@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240410091358.16289-1-darinzon@amazon.com>
References: <20240410091358.16289-1-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: David Arinzon <darinzon@amazon.com>

ENA has two types of TX queues:
- queues which only process TX packets arriving from the network stack
- queues which only process TX packets forwarded to it by XDP_REDIRECT
  or XDP_TX instructions

The ena_free_tx_bufs() cycles through all descriptors in a TX queue
and unmaps + frees every descriptor that hasn't been acknowledged yet
by the device (uncompleted TX transactions).
The function assumes that the processed TX queue is necessarily from
the first category listed above and ends up using napi_consume_skb()
for descriptors belonging to an XDP specific queue.

This patch solves a bug in which, in case of a VF reset, the
descriptors aren't freed correctly, leading to crashes.

Fixes: 548c4940b9f1 ("net: ena: Implement XDP_TX action")
Signed-off-by: Shay Agroskin <shayagr@amazon.com>
Signed-off-by: David Arinzon <darinzon@amazon.com>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 59befc0f..be5acfa4 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -718,8 +718,11 @@ void ena_unmap_tx_buff(struct ena_ring *tx_ring,
 static void ena_free_tx_bufs(struct ena_ring *tx_ring)
 {
 	bool print_once = true;
+	bool is_xdp_ring;
 	u32 i;
 
+	is_xdp_ring = ENA_IS_XDP_INDEX(tx_ring->adapter, tx_ring->qid);
+
 	for (i = 0; i < tx_ring->ring_size; i++) {
 		struct ena_tx_buffer *tx_info = &tx_ring->tx_buffer_info[i];
 
@@ -739,10 +742,15 @@ static void ena_free_tx_bufs(struct ena_ring *tx_ring)
 
 		ena_unmap_tx_buff(tx_ring, tx_info);
 
-		dev_kfree_skb_any(tx_info->skb);
+		if (is_xdp_ring)
+			xdp_return_frame(tx_info->xdpf);
+		else
+			dev_kfree_skb_any(tx_info->skb);
 	}
-	netdev_tx_reset_queue(netdev_get_tx_queue(tx_ring->netdev,
-						  tx_ring->qid));
+
+	if (!is_xdp_ring)
+		netdev_tx_reset_queue(netdev_get_tx_queue(tx_ring->netdev,
+							  tx_ring->qid));
 }
 
 static void ena_free_all_tx_bufs(struct ena_adapter *adapter)
-- 
2.40.1


