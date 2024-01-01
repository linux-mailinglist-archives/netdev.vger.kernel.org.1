Return-Path: <netdev+bounces-60738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1990C821521
	for <lists+netdev@lfdr.de>; Mon,  1 Jan 2024 20:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE9F11F2179C
	for <lists+netdev@lfdr.de>; Mon,  1 Jan 2024 19:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F83AD52F;
	Mon,  1 Jan 2024 19:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="hi5WZGfD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925DDDDAB
	for <netdev@vger.kernel.org>; Mon,  1 Jan 2024 19:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1704136167; x=1735672167;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=koAYEWrPR6TUsliM2GWXENM92sXk7f70ATCQgwIB/0Q=;
  b=hi5WZGfDtQvojZvQCYxROTD+y0Nj4ndeCnBI+NjwoiLTQ9rUoBUj6s1Y
   J3bYdmhLKH/d9jvDcZtx+kwbkH482HEde0DYMaYaVziEgrliGFrpWt5TO
   OGNBsyvkSBUtAOdLbGZUwCe9zj4oE0ktW8HIPrhYN5JWWeP1WZyqV35Ux
   w=;
X-IronPort-AV: E=Sophos;i="6.04,322,1695686400"; 
   d="scan'208";a="628636479"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-1box-2bm6-32cf6363.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2024 19:09:24 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-1box-2bm6-32cf6363.us-west-2.amazon.com (Postfix) with ESMTPS id 4E6028A1D8;
	Mon,  1 Jan 2024 19:09:23 +0000 (UTC)
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:11547]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.236:2525] with esmtp (Farcaster)
 id 32801553-b78c-48e3-98f1-115a5a0793c4; Mon, 1 Jan 2024 19:09:22 +0000 (UTC)
X-Farcaster-Flow-ID: 32801553-b78c-48e3-98f1-115a5a0793c4
Received: from EX19D010UWB003.ant.amazon.com (10.13.138.81) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 1 Jan 2024 19:09:22 +0000
Received: from EX19MTAUWC001.ant.amazon.com (10.250.64.145) by
 EX19D010UWB003.ant.amazon.com (10.13.138.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 1 Jan 2024 19:09:22 +0000
Received: from dev-dsk-darinzon-1c-05962a8d.eu-west-1.amazon.com
 (172.19.80.187) by mail-relay.amazon.com (10.250.64.145) with Microsoft SMTP
 Server id 15.2.1118.40 via Frontend Transport; Mon, 1 Jan 2024 19:09:19 +0000
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
	<evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>
Subject: [PATCH v2 net-next 04/11] net: ena: Introduce total_tx_size field in ena_tx_buffer struct
Date: Mon, 1 Jan 2024 19:08:48 +0000
Message-ID: <20240101190855.18739-5-darinzon@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240101190855.18739-1-darinzon@amazon.com>
References: <20240101190855.18739-1-darinzon@amazon.com>
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

To avoid de-referencing skb or xdp_frame when we poll for TX completion
(where they might not be in the cache), save the total TX packet size in
the ena_tx_buffer object representing the packet.

Also the 'print_once' field's type was changed from u32 to u8 to allow
adding the 'total_tx_size' without changing the total size of the
struct.

Signed-off-by: Shay Agroskin <shayagr@amazon.com>
Signed-off-by: David Arinzon <darinzon@amazon.com>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 3 ++-
 drivers/net/ethernet/amazon/ena/ena_netdev.h | 4 +++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index b7f300b..3c84259 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -130,6 +130,7 @@ int ena_xmit_common(struct ena_adapter *adapter,
 	u64_stats_update_end(&ring->syncp);
 
 	tx_info->tx_descs = nb_hw_desc;
+	tx_info->total_tx_size = bytes;
 	tx_info->last_jiffies = jiffies;
 	tx_info->print_once = 0;
 
@@ -842,7 +843,7 @@ static int ena_clean_tx_irq(struct ena_ring *tx_ring, u32 budget)
 			  "tx_poll: q %d skb %p completed\n", tx_ring->qid,
 			  skb);
 
-		tx_bytes += skb->len;
+		tx_bytes += tx_info->total_tx_size;
 		dev_kfree_skb(skb);
 		tx_pkts++;
 		total_done += tx_info->tx_descs;
diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.h b/drivers/net/ethernet/amazon/ena/ena_netdev.h
index 78a4dee..d3fc03f 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.h
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.h
@@ -145,12 +145,14 @@ struct ena_tx_buffer {
 	/* num of buffers used by this skb */
 	u32 num_of_bufs;
 
+	/* Total size of all buffers in bytes */
+	u32 total_tx_size;
 
 	/* Indicate if bufs[0] map the linear data of the skb. */
 	u8 map_linear_data;
 
 	/* Used for detect missing tx packets to limit the number of prints */
-	u32 print_once;
+	u8 print_once;
 	/* Save the last jiffies to detect missing tx packets
 	 *
 	 * sets to non zero value on ena_start_xmit and set to zero on
-- 
2.40.1


