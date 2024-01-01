Return-Path: <netdev+bounces-60703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB1A8213E9
	for <lists+netdev@lfdr.de>; Mon,  1 Jan 2024 15:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07F621F2177B
	for <lists+netdev@lfdr.de>; Mon,  1 Jan 2024 14:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EFD3FEF;
	Mon,  1 Jan 2024 14:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="uVQ34vLd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78E353AA
	for <netdev@vger.kernel.org>; Mon,  1 Jan 2024 14:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1704118060; x=1735654060;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=olYcAvNYaZAmCgyTBWBZckH6YRM20MDXuroZS/5i7ao=;
  b=uVQ34vLdHB/FKNM0Cutg261OtyfQTazqgGc3KE9JsXKlUQvzYRfaC7yq
   YOlT2+y0frYuCWmA9p2nwEGauD/Y5VcnI/LLWTFQFARhMJpXWJsN8P5Eb
   Oa5kh9F1Ba+G3N2H8Jj+Fi3FqntkeVH/fsZArFjblsTddwlo5Rt/tMVki
   I=;
X-IronPort-AV: E=Sophos;i="6.04,322,1695686400"; 
   d="scan'208";a="319661557"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-6e7a78d7.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2024 14:07:40 +0000
Received: from smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1e-m6i4x-6e7a78d7.us-east-1.amazon.com (Postfix) with ESMTPS id 7C3B3806FD;
	Mon,  1 Jan 2024 14:07:39 +0000 (UTC)
Received: from EX19MTAUEA001.ant.amazon.com [10.0.44.209:35673]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.47.6:2525] with esmtp (Farcaster)
 id 476e7d0f-5e0e-4eb3-a275-914ae6d98bbd; Mon, 1 Jan 2024 14:07:38 +0000 (UTC)
X-Farcaster-Flow-ID: 476e7d0f-5e0e-4eb3-a275-914ae6d98bbd
Received: from EX19D008UEA004.ant.amazon.com (10.252.134.191) by
 EX19MTAUEA001.ant.amazon.com (10.252.134.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 1 Jan 2024 14:07:38 +0000
Received: from EX19MTAUEB001.ant.amazon.com (10.252.135.35) by
 EX19D008UEA004.ant.amazon.com (10.252.134.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 1 Jan 2024 14:07:38 +0000
Received: from dev-dsk-darinzon-1c-05962a8d.eu-west-1.amazon.com
 (172.19.80.187) by mail-relay.amazon.com (10.252.135.35) with Microsoft SMTP
 Server id 15.2.1118.40 via Frontend Transport; Mon, 1 Jan 2024 14:07:36 +0000
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
Subject: [PATCH v1 net-next 03/11] net: ena: Put orthogonal fields in ena_tx_buffer in a union
Date: Mon, 1 Jan 2024 14:07:16 +0000
Message-ID: <20240101140724.26232-4-darinzon@amazon.com>
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

The skb and xdpf pointers cannot be set together in the driver
(each TX descriptor can send either an SKB or an XDP frame), and so it
makes more sense to put them both in a union.

This decreases the overall size of the ena_tx_buffer struct which
improves cache locality.

Signed-off-by: Shay Agroskin <shayagr@amazon.com>
Signed-off-by: David Arinzon <darinzon@amazon.com>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.h | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.h b/drivers/net/ethernet/amazon/ena/ena_netdev.h
index 236d1f8..78a4dee 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.h
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.h
@@ -131,7 +131,13 @@ struct ena_napi {
 };
 
 struct ena_tx_buffer {
-	struct sk_buff *skb;
+	union {
+		struct sk_buff *skb;
+		/* XDP buffer structure which is used for sending packets in
+		 * the xdp queues
+		 */
+		struct xdp_frame *xdpf;
+	};
 	/* num of ena desc for this specific skb
 	 * (includes data desc and metadata desc)
 	 */
@@ -139,10 +145,6 @@ struct ena_tx_buffer {
 	/* num of buffers used by this skb */
 	u32 num_of_bufs;
 
-	/* XDP buffer structure which is used for sending packets in
-	 * the xdp queues
-	 */
-	struct xdp_frame *xdpf;
 
 	/* Indicate if bufs[0] map the linear data of the skb. */
 	u8 map_linear_data;
-- 
2.40.1


