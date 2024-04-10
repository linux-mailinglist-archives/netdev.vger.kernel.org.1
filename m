Return-Path: <netdev+bounces-86472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0817C89EE9D
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 11:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72FDF1F28048
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 09:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0FC159214;
	Wed, 10 Apr 2024 09:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="N8I2X96q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200A1159211
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 09:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712740468; cv=none; b=ScnVhw76tD13fh2Okmx2swdrh5lt34Mvu6t8Chmo/mjD7PAgTwd9mHzHzmcUUDlypAjdOwiBdaZgNNzCwakMoEF4weR2W3GdSWykjk3dmC8AY5OHA70ekD1MNYlxXJqY2BCUzVnwOGjF9InPxk1QP/Hv5Vm7sGIFzMxlKbB/hNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712740468; c=relaxed/simple;
	bh=TdG0Rwap9dMGlP8yVrnQhIYCYzTF6q2P1ACUM6scITk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sIMeSrPbCfndb9/7cFdmulWTbpazGZZwz/fBviuvCi0eOcsxYc4f1ubs3AARjAaHpcbpw/wnaLHdtllxZ71Wi2jSszuztoa4smie5W/N4cGSnYoyUMTg021qsjYsVS5hPi4p9RW34G0FrF72R4jANHCf38Qzk3k9AMV7L7dDjnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=N8I2X96q; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1712740467; x=1744276467;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pqZ4qePdmPy8BY6yby6mNC4YLalaI8wZvhZ0bZ8mDgc=;
  b=N8I2X96q88vmui2F2OIbTI2mbCVudBf1DOqHR4Z7t837Jq8xheiOZedM
   t4hXxDrwRvNOD965lEEjam5b62sIc6uDt4FVS8h637UbLbQDP6S2rBL0N
   IRBrTT5M2pNnZV7ZUjJsp2mpOBLillEnDoCUY8s8PRU2AUoqQUrPTlxAp
   s=;
X-IronPort-AV: E=Sophos;i="6.07,190,1708387200"; 
   d="scan'208";a="646792481"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 09:14:25 +0000
Received: from EX19MTAUEC001.ant.amazon.com [10.0.29.78:55891]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.13.143:2525] with esmtp (Farcaster)
 id d8c0f5ce-f7e3-4974-8936-ca604a415d79; Wed, 10 Apr 2024 09:14:24 +0000 (UTC)
X-Farcaster-Flow-ID: d8c0f5ce-f7e3-4974-8936-ca604a415d79
Received: from EX19D008UEC002.ant.amazon.com (10.252.135.242) by
 EX19MTAUEC001.ant.amazon.com (10.252.135.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 10 Apr 2024 09:14:24 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D008UEC002.ant.amazon.com (10.252.135.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 10 Apr 2024 09:14:24 +0000
Received: from dev-dsk-darinzon-1c-05962a8d.eu-west-1.amazon.com
 (172.19.80.187) by mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Wed, 10 Apr 2024 09:14:22
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
Subject: [PATCH v1 net 4/4] net: ena: Set tx_info->xdpf value to NULL
Date: Wed, 10 Apr 2024 09:13:58 +0000
Message-ID: <20240410091358.16289-5-darinzon@amazon.com>
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

The patch mentioned in the `Fixes` tag removed the explicit assignment
of tx_info->xdpf to NULL with the justification that there's no need
to set tx_info->xdpf to NULL and tx_info->num_of_bufs to 0 in case
of a mapping error. Both values won't be used once the mapping function
returns an error, and their values would be overridden by the next
transmitted packet.

While both values do indeed get overridden in the next transmission
call, the value of tx_info->xdpf is also used to check whether a TX
descriptor's transmission has been completed (i.e. a completion for it
was polled).

An example scenario:
1. Mapping failed, tx_info->xdpf wasn't set to NULL
2. A VF reset occurred leading to IO resource destruction and
   a call to ena_free_tx_bufs() function
3. Although the descriptor whose mapping failed was freed by the
   transmission function, it still passes the check
     if (!tx_info->skb)

   (skb and xdp_frame are in a union)
4. The xdp_frame associated with the descriptor is freed twice

This patch returns the assignment of NULL to tx_info->xdpf to make the
cleaning function knows that the descriptor is already freed.

Fixes: 504fd6a5390c ("net: ena: fix DMA mapping function issues in XDP")
Signed-off-by: Shay Agroskin <shayagr@amazon.com>
Signed-off-by: David Arinzon <darinzon@amazon.com>
---
 drivers/net/ethernet/amazon/ena/ena_xdp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_xdp.c b/drivers/net/ethernet/amazon/ena/ena_xdp.c
index 337c435d..5b175e7e 100644
--- a/drivers/net/ethernet/amazon/ena/ena_xdp.c
+++ b/drivers/net/ethernet/amazon/ena/ena_xdp.c
@@ -89,7 +89,7 @@ int ena_xdp_xmit_frame(struct ena_ring *tx_ring,
 
 	rc = ena_xdp_tx_map_frame(tx_ring, tx_info, xdpf, &ena_tx_ctx);
 	if (unlikely(rc))
-		return rc;
+		goto err;
 
 	ena_tx_ctx.req_id = req_id;
 
@@ -112,7 +112,9 @@ int ena_xdp_xmit_frame(struct ena_ring *tx_ring,
 
 error_unmap_dma:
 	ena_unmap_tx_buff(tx_ring, tx_info);
+err:
 	tx_info->xdpf = NULL;
+
 	return rc;
 }
 
-- 
2.40.1


