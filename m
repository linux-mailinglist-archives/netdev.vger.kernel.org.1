Return-Path: <netdev+bounces-251174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C57D3B007
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 17:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBD713047194
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 16:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFBA29A322;
	Mon, 19 Jan 2026 16:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lo3Qt7da"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DCD28751B
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 16:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768838908; cv=none; b=JRUZytUKxIJbJaV3PVlZETTvRNVsGTKTX2jW0r6IUQF4O4ffTThOhZU/1OlSTODjMk3UHMeEa5Yg44hVGQLq3lo4AnkX9GkshRPah21bnsjR8SFz7gv7Sq15r4j4sSCtoMdo+PfBB/+UFzMEBAFN+AmvDfig3eaJUUDvaxih2T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768838908; c=relaxed/simple;
	bh=F7zYr1/Lw5722rlFffY20iAOuz07Wmj5fhMcJSroAco=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MF7WHo03jdSsyTZAwAVsVuGx50bYDIh90T/vDNooBCza8QaX0flWm3eMlbGarlJOdQqHnNZrTjA8JqHopLBDuck70B0YthzLSAt+dbAVV4+yPtCiTMSUfNh4qYL5vRxC7dTpyVElcCilCGMt8CSgPt51nmLdrp8xLnp5q9S3ptc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lo3Qt7da; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7b22ffa2a88so1848257b3a.1
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 08:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768838906; x=1769443706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R21ZqxoWB5P1YvOncSffb6UWp294VxNKOVm4tYrHNOM=;
        b=lo3Qt7daK4iYdYvchqGkGuIqtFLGzQRdpp8Ejvi2OJEoKHoXOY488xjhkPj1feU3N0
         nSd0lwGJAKL+KMwgx2hSLAnnR+tSNK2atZVN70xm9TZCrp0eLivdhzHqpLyEL0dh66uQ
         5iiTEqgUVPC87pE26MUAI05LDNxtmsmDmLClglt8kYpaNzylKRKOi+rCZ02DrkzgpTfd
         5l9UHRcY5N3MC6dwtS06D8TTbeBWy+UqQGM5NEVQwQxniDOCX518FWVbBP4J039WX9k2
         j/0QpbA7v73KmHgQX7uZZr8JNYRQSsTNdhI3YczrM/bLMuMhnvxz/sVOMKpp0evGsXEF
         sI/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768838906; x=1769443706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R21ZqxoWB5P1YvOncSffb6UWp294VxNKOVm4tYrHNOM=;
        b=Es4F0FhIO8BmJDTw2wmIiPoxVhLSxn6Ly4D5sOskXqLBYYvnE3cOLH/ahJN/OVIt1U
         9C17uNnUK3aeBZXCU2sePquJxW+T2ktS/DeSljdjELuXVjzy3Rgx4b41/AxvJAKWmgDV
         eLU8xZRLHm1Jpr+a4+c9OMKdzF7E2pB1YC+4NHBn/plnDzj4sOg8ZLOcFMOQhDcaCJOK
         5Uw7WFJKI/tE7tZhJQXvN9+RlmpNPPfMp5VA6BpQHKyMFmtMvoPZsuZ7mWYFgsw9ir8x
         YeL8DMkfxNfwR2QhKTpLFGZV07225E86MbSoXdHu/YOaEYcTtaY2a9UEBDFE/fkV/ZdI
         e43Q==
X-Gm-Message-State: AOJu0Yz8MgYw0zB8Oeugx4+7GMuY/La/NUgWpWF7zyZ5Cg15oZ50Most
	60kzKMaGXeW/4V2ikzC3ndgjeJIlQpSz4Ae/rB7w4+7/Twyqvg6KGrRWBebAkQ==
X-Gm-Gg: AY/fxX6PY/kqEFB39stL2v48vdpztmzSn5W3eFw7hrDUrRWV4UkO6AanfBnRL+Gv5hA
	4TY0EEhMOP1ot8k0GTZfeEQzGVikvWf5PzYJ2TEDHPRrVKPCIM6vmbSldYQKr1dqxhG+8psPfUA
	Ob0zjC0R0gjFZtg30LVl8nkYS0NZ7vkeMIGhFN1luerCq+Pdwnx4DC0kGoAxcuHp1ykBcGDLDf8
	x2eJFlPenPSeQl9jcR6L3si/r/GLffuJEFfwtr/bqRQBH8W+q8CDXV92njWzKk8w+6MjS8dxUn+
	GS+zjni55GD9S7o0dg7xaEKKIiptlq8gwgc+oGR6OUkpE3gQ8+J536rgwmYNLBNIfDKrLvhWuj5
	AHklw+2efo8SdcIcGV3mMnYJnPRLChGqF0jzg3+OEIYrdWMGclCbO3p8uw6e8teL/pc7xO69o6z
	5RabWmCrmxm8Si46oXD0rDYdYJQKq8OOBvzCGOXJc9zJQSAETbRDqM0A==
X-Received: by 2002:a05:6a21:3984:b0:364:13ca:3702 with SMTP id adf61e73a8af0-38e00d1572cmr8299751637.42.1768838905918;
        Mon, 19 Jan 2026 08:08:25 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf251a6csm9509094a12.13.2026.01.19.08.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 08:08:24 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Jian Shen <shenjian15@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Huazhong Tan <tanhuazhong@huawei.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Peng Li <lipeng321@huawei.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: hns3: fix data race in hns3_fetch_stats
Date: Tue, 20 Jan 2026 00:07:37 +0800
Message-ID: <20260119160759.1455950-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In hns3_fetch_stats(), ring statistics, protected by u64_stats_sync, are
read and accumulated in ignorance of possible u64_stats_fetch_retry()
events. These statistics are already accumulated by
hns3_ring_stats_update(). Fix this by reading them into a temporary
buffer first.

Fixes: b20d7fe51e0d ("net: hns3: add some statitics info to tx process")
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   | 69 ++++++++++---------
 1 file changed, 36 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 7b9269f6fdfc..a47464a22751 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -2530,44 +2530,47 @@ static netdev_features_t hns3_features_check(struct sk_buff *skb,
 static void hns3_fetch_stats(struct rtnl_link_stats64 *stats,
 			     struct hns3_enet_ring *ring, bool is_tx)
 {
+	struct ring_stats ring_stats;
 	unsigned int start;
 
 	do {
 		start = u64_stats_fetch_begin(&ring->syncp);
-		if (is_tx) {
-			stats->tx_bytes += ring->stats.tx_bytes;
-			stats->tx_packets += ring->stats.tx_pkts;
-			stats->tx_dropped += ring->stats.sw_err_cnt;
-			stats->tx_dropped += ring->stats.tx_vlan_err;
-			stats->tx_dropped += ring->stats.tx_l4_proto_err;
-			stats->tx_dropped += ring->stats.tx_l2l3l4_err;
-			stats->tx_dropped += ring->stats.tx_tso_err;
-			stats->tx_dropped += ring->stats.over_max_recursion;
-			stats->tx_dropped += ring->stats.hw_limitation;
-			stats->tx_dropped += ring->stats.copy_bits_err;
-			stats->tx_dropped += ring->stats.skb2sgl_err;
-			stats->tx_dropped += ring->stats.map_sg_err;
-			stats->tx_errors += ring->stats.sw_err_cnt;
-			stats->tx_errors += ring->stats.tx_vlan_err;
-			stats->tx_errors += ring->stats.tx_l4_proto_err;
-			stats->tx_errors += ring->stats.tx_l2l3l4_err;
-			stats->tx_errors += ring->stats.tx_tso_err;
-			stats->tx_errors += ring->stats.over_max_recursion;
-			stats->tx_errors += ring->stats.hw_limitation;
-			stats->tx_errors += ring->stats.copy_bits_err;
-			stats->tx_errors += ring->stats.skb2sgl_err;
-			stats->tx_errors += ring->stats.map_sg_err;
-		} else {
-			stats->rx_bytes += ring->stats.rx_bytes;
-			stats->rx_packets += ring->stats.rx_pkts;
-			stats->rx_dropped += ring->stats.l2_err;
-			stats->rx_errors += ring->stats.l2_err;
-			stats->rx_errors += ring->stats.l3l4_csum_err;
-			stats->rx_crc_errors += ring->stats.l2_err;
-			stats->multicast += ring->stats.rx_multicast;
-			stats->rx_length_errors += ring->stats.err_pkt_len;
-		}
+		ring_stats = ring->stats;
 	} while (u64_stats_fetch_retry(&ring->syncp, start));
+
+	if (is_tx) {
+		stats->tx_bytes += ring_stats.tx_bytes;
+		stats->tx_packets += ring_stats.tx_pkts;
+		stats->tx_dropped += ring_stats.sw_err_cnt;
+		stats->tx_dropped += ring_stats.tx_vlan_err;
+		stats->tx_dropped += ring_stats.tx_l4_proto_err;
+		stats->tx_dropped += ring_stats.tx_l2l3l4_err;
+		stats->tx_dropped += ring_stats.tx_tso_err;
+		stats->tx_dropped += ring_stats.over_max_recursion;
+		stats->tx_dropped += ring_stats.hw_limitation;
+		stats->tx_dropped += ring_stats.copy_bits_err;
+		stats->tx_dropped += ring_stats.skb2sgl_err;
+		stats->tx_dropped += ring_stats.map_sg_err;
+		stats->tx_errors += ring_stats.sw_err_cnt;
+		stats->tx_errors += ring_stats.tx_vlan_err;
+		stats->tx_errors += ring_stats.tx_l4_proto_err;
+		stats->tx_errors += ring_stats.tx_l2l3l4_err;
+		stats->tx_errors += ring_stats.tx_tso_err;
+		stats->tx_errors += ring_stats.over_max_recursion;
+		stats->tx_errors += ring_stats.hw_limitation;
+		stats->tx_errors += ring_stats.copy_bits_err;
+		stats->tx_errors += ring_stats.skb2sgl_err;
+		stats->tx_errors += ring_stats.map_sg_err;
+	} else {
+		stats->rx_bytes += ring_stats.rx_bytes;
+		stats->rx_packets += ring_stats.rx_pkts;
+		stats->rx_dropped += ring_stats.l2_err;
+		stats->rx_errors += ring_stats.l2_err;
+		stats->rx_errors += ring_stats.l3l4_csum_err;
+		stats->rx_crc_errors += ring_stats.l2_err;
+		stats->multicast += ring_stats.rx_multicast;
+		stats->rx_length_errors += ring_stats.err_pkt_len;
+	}
 }
 
 static void hns3_nic_get_stats64(struct net_device *netdev,
-- 
2.51.0


