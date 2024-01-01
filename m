Return-Path: <netdev+bounces-60704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC34D8213EA
	for <lists+netdev@lfdr.de>; Mon,  1 Jan 2024 15:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D182F1C20B0B
	for <lists+netdev@lfdr.de>; Mon,  1 Jan 2024 14:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818653D71;
	Mon,  1 Jan 2024 14:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="XtDrK93z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A5C6FAF
	for <netdev@vger.kernel.org>; Mon,  1 Jan 2024 14:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1704118066; x=1735654066;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=koAYEWrPR6TUsliM2GWXENM92sXk7f70ATCQgwIB/0Q=;
  b=XtDrK93zjXL29jyKV8xxZ5ODF8c070Rwi1DHkDb2qR2rdcmHENIoe5/Z
   6MskR8TqHFmGf0mo4hJDJcqoRydL12cjIdj27SVbkeghiC01vHphP5ps3
   Wrs9Q+mBgM0caVfKivfmaBMZHzJU3D4ajUuhvIJfP6eobCIquwXJ6YD9v
   w=;
X-IronPort-AV: E=Sophos;i="6.04,322,1695686400"; 
   d="scan'208";a="54982997"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-1box-2bm6-32cf6363.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2024 14:07:44 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-1box-2bm6-32cf6363.us-west-2.amazon.com (Postfix) with ESMTPS id 15BA780502;
	Mon,  1 Jan 2024 14:07:44 +0000 (UTC)
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:3547]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.48.93:2525] with esmtp (Farcaster)
 id a2c12f3c-5c88-44dc-8aad-36406ebebf57; Mon, 1 Jan 2024 14:07:43 +0000 (UTC)
X-Farcaster-Flow-ID: a2c12f3c-5c88-44dc-8aad-36406ebebf57
Received: from EX19D010UWA004.ant.amazon.com (10.13.138.204) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 1 Jan 2024 14:07:42 +0000
Received: from EX19MTAUWC001.ant.amazon.com (10.250.64.145) by
 EX19D010UWA004.ant.amazon.com (10.13.138.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 1 Jan 2024 14:07:42 +0000
Received: from dev-dsk-darinzon-1c-05962a8d.eu-west-1.amazon.com
 (172.19.80.187) by mail-relay.amazon.com (10.250.64.145) with Microsoft SMTP
 Server id 15.2.1118.40 via Frontend Transport; Mon, 1 Jan 2024 14:07:39 +0000
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
Subject: [PATCH v1 net-next 04/11] net: ena: Introduce total_tx_size field in ena_tx_buffer struct
Date: Mon, 1 Jan 2024 14:07:17 +0000
Message-ID: <20240101140724.26232-5-darinzon@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240101140724.26232-1-darinzon@amazon.com>
References: <20240101140724.26232-1-darinzon@amazon.com>
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


