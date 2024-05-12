Return-Path: <netdev+bounces-95781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 872F28C36BE
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 15:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 272B61F20AA7
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 13:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CC828DA0;
	Sun, 12 May 2024 13:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="exvNs6HF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D132725763
	for <netdev@vger.kernel.org>; Sun, 12 May 2024 13:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715521622; cv=none; b=ryw1PGx/g7G5hmPj+jzSDKNr8/Jcx9O3X7Obpqplta4emVn3F+zelt03efbOkGyVqyR4RV26E3Ef+BPKBJF3CWs4kHuiB3/8e6tmMMlpJqUNuVKSRP9K1XHg6sMHIYYyYXMDqcPVcKugP2VVSzivFHJ8M3KeBmOmsuzHOmAIYvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715521622; c=relaxed/simple;
	bh=jBzPvio5m+I9R+VPZoRZOYN95Od+s6uzAuY01QLwUO4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ugvNE924/sDbVLYAooXRCc/+5G+uc/m1bV8g3weIGblKOFTxWRCqC6I/tjVs3ZFg1wttTfxzzj6W4yWR3mi7DB23sy0GFbcrdUIquSG7AzQEGa5pi3P6ROWo/QEHSGKlfkP2DdOKXw/SJBI5RTgR6KDcJjZBMCbYZkjsn0BJxzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=exvNs6HF; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1715521621; x=1747057621;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gh1ofUqgre/duj2ag7tkXXoA0sIVAh5XO/Bo5Xwuqmw=;
  b=exvNs6HFn1AYbO9RMQaeZx6mixXvEc+NpHRt36flYaexs9FqoOEgozeG
   rdqM6o8SGb59TabkrOiA7jgRv4jHV62sUQ/uQs3tFoExnGQZXMZqUhboq
   NnrU3RCaMRVjmEpuWe9uVu5bv9JamunRgxuh3gXSIgOTSb8i007Ji0gRw
   4=;
X-IronPort-AV: E=Sophos;i="6.08,155,1712620800"; 
   d="scan'208";a="418501891"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 13:46:55 +0000
Received: from EX19MTAUEC002.ant.amazon.com [10.0.44.209:17013]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.32.236:2525] with esmtp (Farcaster)
 id 8bbb3326-116d-49f9-8632-ae79af39cd34; Sun, 12 May 2024 13:46:54 +0000 (UTC)
X-Farcaster-Flow-ID: 8bbb3326-116d-49f9-8632-ae79af39cd34
Received: from EX19D008UEC004.ant.amazon.com (10.252.135.170) by
 EX19MTAUEC002.ant.amazon.com (10.252.135.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Sun, 12 May 2024 13:46:53 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D008UEC004.ant.amazon.com (10.252.135.170) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Sun, 12 May 2024 13:46:53 +0000
Received: from dev-dsk-darinzon-1c-05962a8d.eu-west-1.amazon.com
 (172.19.80.187) by mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Sun, 12 May 2024 13:46:51
 +0000
From: <darinzon@amazon.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>
CC: David Arinzon <darinzon@amazon.com>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, "Woodhouse, David" <dwmw@amazon.com>,
	"Machulsky, Zorik" <zorik@amazon.com>, "Matushevsky, Alexander"
	<matua@amazon.com>, Saeed Bshara <saeedb@amazon.com>, "Wilson, Matt"
	<msw@amazon.com>, "Liguori, Anthony" <aliguori@amazon.com>, "Bshara, Nafea"
	<nafea@amazon.com>, "Belgazal, Netanel" <netanel@amazon.com>, "Saidi, Ali"
	<alisaidi@amazon.com>, "Herrenschmidt, Benjamin" <benh@amazon.com>,
	"Kiyanovski, Arthur" <akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>,
	"Agroskin, Shay" <shayagr@amazon.com>, "Itzko, Shahar" <itzko@amazon.com>,
	"Abboud, Osama" <osamaabb@amazon.com>, "Ostrovsky, Evgeny"
	<evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>
Subject: [PATCH v2 net-next 2/5] net: ena: Reduce holes in ena_com structures
Date: Sun, 12 May 2024 13:46:34 +0000
Message-ID: <20240512134637.25299-3-darinzon@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240512134637.25299-1-darinzon@amazon.com>
References: <20240512134637.25299-1-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: David Arinzon <darinzon@amazon.com>

This patch makes two changes in order to fill holes and
reduce ther overall size of the structures ena_com_dev
and ena_com_rx_ctx.

Signed-off-by: Shahar Itzko <itzko@amazon.com>
Signed-off-by: David Arinzon <darinzon@amazon.com>
---
 drivers/net/ethernet/amazon/ena/ena_com.h     | 4 ++--
 drivers/net/ethernet/amazon/ena/ena_eth_com.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_com.h b/drivers/net/ethernet/amazon/ena/ena_com.h
index fea57eb8..fdae0cc9 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.h
+++ b/drivers/net/ethernet/amazon/ena/ena_com.h
@@ -305,6 +305,8 @@ struct ena_com_dev {
 	u16 stats_func; /* Selected function for extended statistic dump */
 	u16 stats_queue; /* Selected queue for extended statistic dump */
 
+	u32 ena_min_poll_delay_us;
+
 	struct ena_com_mmio_read mmio_read;
 
 	struct ena_rss rss;
@@ -325,8 +327,6 @@ struct ena_com_dev {
 	struct ena_intr_moder_entry *intr_moder_tbl;
 
 	struct ena_com_llq_info llq_info;
-
-	u32 ena_min_poll_delay_us;
 };
 
 struct ena_com_dev_get_features_ctx {
diff --git a/drivers/net/ethernet/amazon/ena/ena_eth_com.h b/drivers/net/ethernet/amazon/ena/ena_eth_com.h
index 72b01975..449bc496 100644
--- a/drivers/net/ethernet/amazon/ena/ena_eth_com.h
+++ b/drivers/net/ethernet/amazon/ena/ena_eth_com.h
@@ -47,7 +47,7 @@ struct ena_com_rx_ctx {
 	bool frag;
 	u32 hash;
 	u16 descs;
-	int max_bufs;
+	u16 max_bufs;
 	u8 pkt_offset;
 };
 
-- 
2.40.1


