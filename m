Return-Path: <netdev+bounces-198536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C277ADC97A
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 13:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CF843A23C7
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 11:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CFB211A3C;
	Tue, 17 Jun 2025 11:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WI9WNo5u"
X-Original-To: netdev@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8B51EDA3C;
	Tue, 17 Jun 2025 11:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750160024; cv=none; b=olTcUWZLIApVob6RCIpGj/J/9XhMg1kF0hQepAYAmglAcMpHGZyLpLO5qb6CRlMTQnen+uJhciUPjr89BOpVnf2Wt2fT8hvhtmBclqtSPNhWSA8FMNE/UL5DwysAJ/39liUve/xjLupP5GVBTdGB34KoxlDMGImez+MhpSrrmso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750160024; c=relaxed/simple;
	bh=jrgGdbP5apEQcDQ6yICK0dFB5pKV+9fGdc5AglGKEA0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=S1J/M9lt70DKaq/xGCYKnELbMGvKmg1O2ShhXGrg8dktOd+iP2kDucQIaUqJM6SfSgD51mbrkKU5FdViEsYdEpi0x9wweh3sVsQVesq7xieNIAO3LK+p5Qg6GYrwuhdQuyAyvFmJCR0Lt4/yKdo0KI4cW8odPK6Mr4ZIw9tZ2Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WI9WNo5u; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 16A1A2117F96; Tue, 17 Jun 2025 04:33:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 16A1A2117F96
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1750160023;
	bh=mKTNlW0AkzZv+T51lkhj5+K+zcs0xhJdeNPYEm/GAs4=;
	h=From:To:Cc:Subject:Date:From;
	b=WI9WNo5uIStGKShk9LQnljONwGpcrCZKMnaGmNxfChSOW/r5f9cGRuHrC/9+sBzH2
	 ZpplGvcYcJ9VgOFhXKrNgnV/aoBWGc2EdulBjkzYtNL1RgQKiZaFpzKkSU31+G9A83
	 F+0Hdo8jKAOMWOYkGkiu+fa0x+CgAgTvwlDy5OeM=
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Dexuan Cui <decui@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Long Li <longli@microsoft.com>,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>,
	Shiraz Saleem <shirazsaleem@microsoft.com>
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	netdev@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paul Rosswurm <paulros@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: [PATCH net-next] net: mana: Set tx_packets to post gso processing packet count
Date: Tue, 17 Jun 2025 04:33:41 -0700
Message-Id: <1750160021-24589-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Allow tx_packets and tx_bytes counter in the driver to represent
the packets transmitted post GSO processing.

Currently they are populated as bigger pre-GSO packets and bytes

Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index e68b8190bb7a..c3b6478cb1d3 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -251,10 +251,10 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	struct netdev_queue *net_txq;
 	struct mana_stats_tx *tx_stats;
 	struct gdma_queue *gdma_sq;
+	int err, len, num_gso_seg;
 	unsigned int csum_type;
 	struct mana_txq *txq;
 	struct mana_cq *cq;
-	int err, len;
 
 	if (unlikely(!apc->port_is_up))
 		goto tx_drop;
@@ -407,6 +407,7 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	skb_queue_tail(&txq->pending_skbs, skb);
 
 	len = skb->len;
+	num_gso_seg = skb_is_gso(skb) ? skb_shinfo(skb)->gso_segs : 1;
 	net_txq = netdev_get_tx_queue(ndev, txq_idx);
 
 	err = mana_gd_post_work_request(gdma_sq, &pkg.wqe_req,
@@ -431,10 +432,13 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	/* skb may be freed after mana_gd_post_work_request. Do not use it. */
 	skb = NULL;
 
+	/* Populated the packet and bytes counters based on post GSO packet
+	 * calculations
+	 */
 	tx_stats = &txq->stats;
 	u64_stats_update_begin(&tx_stats->syncp);
-	tx_stats->packets++;
-	tx_stats->bytes += len;
+	tx_stats->packets += num_gso_seg;
+	tx_stats->bytes += len + ((num_gso_seg - 1) * gso_hs);
 	u64_stats_update_end(&tx_stats->syncp);
 
 tx_busy:

base-commit: 8909f5f4ecd551c2299b28e05254b77424c8c7dc
-- 
2.34.1


