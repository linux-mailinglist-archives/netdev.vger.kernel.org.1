Return-Path: <netdev+bounces-93624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2CB8BC80F
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 09:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AC961F22358
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 07:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1ED140395;
	Mon,  6 May 2024 07:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="HHycgs2d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B8213C8E8
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 07:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714979111; cv=none; b=lZOE/tf56bIRrFMOxc3DXVE8J9AmvM8LHz5ex3rpi7LGKf+26/OJWnYrnFSCxXxip7kH+uWeHv6sdXbsPH9/KXUlatjTqx3nyXAWu9zJxZ2HkOJz7QOowupJ/V47qNi/E4ZyWQ9TJplPguow56lx20sOjS/5FfwIZwS+jpoQhEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714979111; c=relaxed/simple;
	bh=jBzPvio5m+I9R+VPZoRZOYN95Od+s6uzAuY01QLwUO4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FBD+mZtEftYMwv5Sl1k6dqnG0LhdTVbT9gOjiYgdxqWEAreJ+qzIak6+t8N4eVJD7keJV6O67wTAq09haZ7RoulTS0JFGto8vyDp4yiupi/ZcjMI5tbLgSApw9SgcIOeCMpz9JGrpPvNkmG9RA/LWsfrXy16Uj3VB650cQvcb04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=HHycgs2d; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1714979111; x=1746515111;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gh1ofUqgre/duj2ag7tkXXoA0sIVAh5XO/Bo5Xwuqmw=;
  b=HHycgs2dz6ENgkypJDHy0jvG1F2WJ1Tv3DzpvmjjwbYLU8Coly/74dIL
   Sg8Fh3OMASTBUVKMKjez9Cvvmq3cbiqY5/LPnGiRlkJA4ToK7fm1Vyq56
   woYjtrUpBZdeuWAB8D59wMAmAG9QsJLkYDyMGtlWyDxa+TubwEen5YozO
   0=;
X-IronPort-AV: E=Sophos;i="6.07,257,1708387200"; 
   d="scan'208";a="394633717"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 07:05:08 +0000
Received: from EX19MTAUEA001.ant.amazon.com [10.0.29.78:57982]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.16.208:2525] with esmtp (Farcaster)
 id b44b1178-56cb-4552-a920-58e7d4e92a8e; Mon, 6 May 2024 07:05:07 +0000 (UTC)
X-Farcaster-Flow-ID: b44b1178-56cb-4552-a920-58e7d4e92a8e
Received: from EX19D008UEA004.ant.amazon.com (10.252.134.191) by
 EX19MTAUEA001.ant.amazon.com (10.252.134.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 6 May 2024 07:05:07 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D008UEA004.ant.amazon.com (10.252.134.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 6 May 2024 07:05:07 +0000
Received: from dev-dsk-darinzon-1c-05962a8d.eu-west-1.amazon.com
 (172.19.80.187) by mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Mon, 6 May 2024 07:05:05 +0000
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
Subject: [PATCH v1 net-next 2/6] net: ena: Reduce holes in ena_com structures
Date: Mon, 6 May 2024 07:04:49 +0000
Message-ID: <20240506070453.17054-3-darinzon@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240506070453.17054-1-darinzon@amazon.com>
References: <20240506070453.17054-1-darinzon@amazon.com>
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


