Return-Path: <netdev+bounces-139371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4C69B1A94
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 21:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 669ED1C20CA5
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 19:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6FC1D2F67;
	Sat, 26 Oct 2024 19:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gaodhs1W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5F7146013;
	Sat, 26 Oct 2024 19:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729970865; cv=none; b=uTDcLyAXdJanhxPpN60Tc3wOWZV1R0e8ue8RZ5FFFgMHJum7vzSlyzMrnfQXKbeDMlDwpXZUS/+P9ncOPV0sxZWtCyOzdEfc2lTiHUSeJ4iYLFuRBLJAxkkwnnNPQ0ACNewf8KoVzyjRutt7sw20kG3r9pc4zO8Ekoz4yWMO7aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729970865; c=relaxed/simple;
	bh=S502IpnDIcET17mBNY89B3iht7n3JKQGTscHzyynvs4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fx6wfdXLHTo6vuso3chvuyJWu4vcQhvHao9ldsfGdhbJiPSPKHp3c4rCztVu915+BhmezDJYZju7YTLqN0Y7viL3EeVUgsnNyYiGzLrZkAl1lAnat7uGunwyQf1B6quNfqZAVlpAGuZV6LNG9pXpWp7PeTEJqOCHjtS5BXJYmFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gaodhs1W; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71e74900866so2315464b3a.1;
        Sat, 26 Oct 2024 12:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729970862; x=1730575662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fA40FaT5RXWCXZ0+bUq5D/w3OprknqZD3KhJcCeMLjw=;
        b=gaodhs1WcfFnJEDEWvT8IyxXA8+dDkMDS2Gh5hWgZ9PfQfytFRY+i/OMEgNNooNmR9
         In4/ztnEckOh86aZjAi6+I5b5OSraBnRGO+x7xhST8WB7IiDJJimQo9IVgb+YMk/YaQq
         d6FuteVkAQMIZZm/sSTycNsuXdNYaAJ9WDAj/Z/e9QihiGAF3NfvZu8iQAXtGlJPTApL
         9cbXPQwM+2926cdoXpVTcuT0qDkT6ienK++9RWmQrandSKs0oxQGfjMLYbS4FTL3dq6Y
         2w2BbrYXdBHyHMuyKtyk96iA2C9tNwZiPtbV/5WYNALCv6Yr5RJFZ+JKGFyQeT6xX5by
         uhPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729970862; x=1730575662;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fA40FaT5RXWCXZ0+bUq5D/w3OprknqZD3KhJcCeMLjw=;
        b=un6iye6p9JwZDPiu0JvjuOvAlcUokAEpAhFoknyadLrBKrsHxfWLlQX7sJb8wFY0Kg
         EABQbV42lUI/N/AZE7LSU8gpNfzV8l1+t675xWIVmruZYht93li7OymH0QRs+42yr1Rk
         yG0GVsDS1QO1hl6iNceuk0usU3nTxnREMf5Ret0ZndnqaXHG2zFJAVpdL41KQrIxhNZT
         0n6KxnkmMu3Oj0K9fLsoY1KtbERaxjStMnC7+8//9zOnIGMNXM8JRgwY+3BY31NJCRnv
         cg6+3iM67wzmVJb/gGXqZTLiZIuPPxTcRPCnF8fjK60CPNF0JIaSJRpemnEl3n148pMh
         n6Hg==
X-Forwarded-Encrypted: i=1; AJvYcCW5o7UJSvMykPPue1vV3lCGpEaTbN31f6d0luCY0khzIP61V7YybGoh8y/JSjlZUT76PrCXlhkQWA7iUcg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4YOH3Wg68XCxbWPhRhu0Xfhvx/FMh4c4vx5vp2XfwXsnEhEhZ
	f3ZvCsg4zuQJkJnJc28yuYfRhswsimONbvGQ9kALgJSpVeU6AxmO
X-Google-Smtp-Source: AGHT+IGNDiLO935y/mSqxNk0WbmrAKYAtaGFIXAmXYtebP/zB1ADiCMEKVsZcAfWqdk736Da59ze9Q==
X-Received: by 2002:a05:6a00:10c7:b0:717:9154:b5d6 with SMTP id d2e1a72fcca58-72063028d41mr5680707b3a.22.1729970861558;
        Sat, 26 Oct 2024 12:27:41 -0700 (PDT)
Received: from mythos-cloud.. ([121.185.170.145])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a3c2d4sm3045922b3a.202.2024.10.26.12.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 12:27:41 -0700 (PDT)
From: Moon Yeounsu <yyyynoom@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Moon Yeounsu <yyyynoom@gmail.com>
Subject: [PATCH net-next] net: dlink: add get_ethtool_stats in ethtool
Date: Sun, 27 Oct 2024 04:26:53 +0900
Message-ID: <20241026192651.22169-3-yyyynoom@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch implement `get_ethtool_stats` to support `ethtool -S`.

Before applying the patch:
$ ethtool -S enp36s0
> no stats available

After applying the patch:
$ ethtool -S enp36s0
> NIC statistics:
	tx_jumbo_frames: 0
	rx_jumbo_frames: 0
	tcp_checksum_errors: 0
	udp_checksum_errors: 0
	ip_checksum_errors: 0
	tx_packets: 0
	rx_packets: 74
	tx_bytes: 0
	rx_bytes: 14212
	single_collisions: 0
	multi_collisions: 0
	late_collisions: 0
	rx_frames_too_long_errors: 0
	rx_in_range_length_errors: 776
	rx_frames_check_seq_errors: 0
	rx_frames_lost_errors: 0
	tx_frames_abort: 0
	tx_carrier_sense_errors: 0
	tx_multicast_bytes: 0
	rx_multicast_bytes: 360
	tx_multicast_frames: 0
	rx_multicast_frames: 6
	tx_broadcast_frames: 0
	rx_broadcast_frames: 68
	tx_mac_control_frames: 0
	rx_mac_control_frames: 0
	tx_frames_deferred: 0
	tx_frames_excessive_deferral: 0

Tested-on: D-Link DGE-550T Rev-A3
Signed-off-by: Moon Yeounsu <yyyynoom@gmail.com>
---
 drivers/net/ethernet/dlink/dl2k.c | 229 ++++++++++++++++++------------
 drivers/net/ethernet/dlink/dl2k.h |  87 ++++++++++++
 2 files changed, 229 insertions(+), 87 deletions(-)

diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index d0ea92607870..08a1e896bc77 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -99,6 +99,88 @@ static const struct net_device_ops netdev_ops = {
 	.ndo_tx_timeout		= rio_tx_timeout,
 };
 
+#define DEFINE_STATS(FIELD, REGS, SIZE) {				\
+	.string = #FIELD,						\
+	.offset = offsetof(struct netdev_private, FIELD),		\
+	.regs = (REGS),							\
+	.size = sizeof(SIZE)						\
+}
+
+#define STATS_SIZE		ARRAY_SIZE(stats)
+
+struct dlink_stats stats[] = {
+	DEFINE_STATS(tx_jumbo_frames, TxJumboFrames, u16),
+	DEFINE_STATS(rx_jumbo_frames, RxJumboFrames, u16),
+
+	DEFINE_STATS(tcp_checksum_errors, TCPCheckSumErrors, u16),
+	DEFINE_STATS(udp_checksum_errors, UDPCheckSumErrors, u16),
+	DEFINE_STATS(ip_checksum_errors, IPCheckSumErrors, u16),
+
+	DEFINE_STATS(tx_packets, FramesXmtOk, u32),
+	DEFINE_STATS(rx_packets, FramesRcvOk, u32),
+	DEFINE_STATS(tx_bytes, OctetXmtOk, u32),
+	DEFINE_STATS(rx_bytes, OctetRcvOk, u32),
+
+	DEFINE_STATS(single_collisions, SingleColFrames, u32),
+	DEFINE_STATS(multi_collisions, MultiColFrames, u32),
+	DEFINE_STATS(late_collisions, LateCollisions, u32),
+
+	DEFINE_STATS(rx_frames_too_long_errors, FrameTooLongErrors, u16),
+	DEFINE_STATS(rx_in_range_length_errors, InRangeLengthErrors, u16),
+	DEFINE_STATS(rx_frames_check_seq_errors, FramesCheckSeqErrors, u16),
+	DEFINE_STATS(rx_frames_lost_errors, FramesLostRxErrors, u16),
+
+	DEFINE_STATS(tx_frames_abort, FramesAbortXSColls, u16),
+	DEFINE_STATS(tx_carrier_sense_errors, CarrierSenseErrors, u16),
+
+	DEFINE_STATS(tx_multicast_bytes, McstOctetXmtOk, u32),
+	DEFINE_STATS(rx_multicast_bytes, McstOctetRcvOk, u32),
+
+	DEFINE_STATS(tx_multicast_frames, McstFramesXmtdOk, u32),
+	DEFINE_STATS(rx_multicast_frames, McstFramesRcvdOk, u32),
+
+	DEFINE_STATS(tx_broadcast_frames, BcstFramesXmtdOk, u16),
+	DEFINE_STATS(rx_broadcast_frames, BcstFramesRcvdOk, u16),
+
+	DEFINE_STATS(tx_mac_control_frames, MacControlFramesXmtd, u16),
+	DEFINE_STATS(rx_mac_control_frames, MacControlFramesRcvd, u16),
+
+	DEFINE_STATS(tx_frames_deferred, FramesWDeferredXmt, u32),
+	DEFINE_STATS(tx_frames_excessive_deferral, FramesWEXDeferal, u16),
+
+#ifdef MEM_MAPPING
+	DEFINE_STATS(rmon_collisions, EtherStatsCollisions, u32),
+	DEFINE_STATS(rmon_crc_align_errors, EtherStatsCRCAlignErrors, u32),
+	DEFINE_STATS(rmon_under_size_packets, EtherStatsUndersizePkts, u32),
+	DEFINE_STATS(rmon_fragments, EtherStatsFragments, u32),
+	DEFINE_STATS(rmon_jabbers, EtherStatsJabbers, u32),
+
+	DEFINE_STATS(rmon_tx_bytes, EtherStatsOctetsTransmit, u32),
+	DEFINE_STATS(rmon_rx_bytes, EtherStatsOctets, u32),
+
+	DEFINE_STATS(rmon_tx_packets, EtherStatsPktsTransmit, u32),
+	DEFINE_STATS(rmon_rx_packets, EtherStatsPkts, u32),
+
+	DEFINE_STATS(rmon_tx_byte_64, EtherStatsPkts64OctetTransmit, u32),
+	DEFINE_STATS(rmon_rx_byte_64, EtherStats64Octets, u32),
+
+	DEFINE_STATS(rmon_tx_byte_65to127, EtherStatsPkts64OctetTransmit, u32),
+	DEFINE_STATS(rmon_rx_byte_64to127, EtherStats64Octets, u32),
+
+	DEFINE_STATS(rmon_tx_byte_128to255, EtherStatsPkts128to255OctetsTransmit, u32),
+	DEFINE_STATS(rmon_rx_byte_128to255, EtherStatsPkts128to255Octets, u32),
+
+	DEFINE_STATS(rmon_tx_byte_256to511, EtherStatsPkts256to511OctetsTransmit, u32),
+	DEFINE_STATS(rmon_rx_byte_256to511, EtherStatsPkts256to511Octets, u32),
+
+	DEFINE_STATS(rmon_tx_byte_512to1023, EtherStatsPkts512to1023OctetsTransmit, u32),
+	DEFINE_STATS(rmon_rx_byte_512to1203, EtherStatsPkts512to1023Octets, u32),
+
+	DEFINE_STATS(rmon_tx_byte_1204to1518, EtherStatsPkts1024to1518OctetsTransmit, u32),
+	DEFINE_STATS(rmon_rx_byte_1204to1518, EtherStatsPkts1024to1518Octets, u32)
+#endif
+};
+
 static int
 rio_probe1 (struct pci_dev *pdev, const struct pci_device_id *ent)
 {
@@ -148,6 +230,7 @@ rio_probe1 (struct pci_dev *pdev, const struct pci_device_id *ent)
 	np->pdev = pdev;
 	spin_lock_init (&np->tx_lock);
 	spin_lock_init (&np->rx_lock);
+	spin_lock_init(&np->stats_lock);
 
 	/* Parse manual configuration */
 	np->an_enable = 1;
@@ -1069,60 +1152,30 @@ get_stats (struct net_device *dev)
 {
 	struct netdev_private *np = netdev_priv(dev);
 	void __iomem *ioaddr = np->ioaddr;
-#ifdef MEM_MAPPING
+	unsigned long flags;
 	int i;
-#endif
-	unsigned int stat_reg;
+
+	spin_lock_irqsave(&np->stats_lock, flags);
 
 	/* All statistics registers need to be acknowledged,
 	   else statistic overflow could cause problems */
 
-	dev->stats.rx_packets += dr32(FramesRcvOk);
-	dev->stats.tx_packets += dr32(FramesXmtOk);
-	dev->stats.rx_bytes += dr32(OctetRcvOk);
-	dev->stats.tx_bytes += dr32(OctetXmtOk);
-
-	dev->stats.multicast = dr32(McstFramesRcvdOk);
-	dev->stats.collisions += dr32(SingleColFrames)
-			     +  dr32(MultiColFrames);
-
-	/* detailed tx errors */
-	stat_reg = dr16(FramesAbortXSColls);
-	dev->stats.tx_aborted_errors += stat_reg;
-	dev->stats.tx_errors += stat_reg;
-
-	stat_reg = dr16(CarrierSenseErrors);
-	dev->stats.tx_carrier_errors += stat_reg;
-	dev->stats.tx_errors += stat_reg;
-
-	/* Clear all other statistic register. */
-	dr32(McstOctetXmtOk);
-	dr16(BcstFramesXmtdOk);
-	dr32(McstFramesXmtdOk);
-	dr16(BcstFramesRcvdOk);
-	dr16(MacControlFramesRcvd);
-	dr16(FrameTooLongErrors);
-	dr16(InRangeLengthErrors);
-	dr16(FramesCheckSeqErrors);
-	dr16(FramesLostRxErrors);
-	dr32(McstOctetXmtOk);
-	dr32(BcstOctetXmtOk);
-	dr32(McstFramesXmtdOk);
-	dr32(FramesWDeferredXmt);
-	dr32(LateCollisions);
-	dr16(BcstFramesXmtdOk);
-	dr16(MacControlFramesXmtd);
-	dr16(FramesWEXDeferal);
+	for (i = 0; i < STATS_SIZE; i++) {
+		u64 *data = ((void *) np) + stats[i].offset;
+
+		if (stats[i].size == sizeof(u32))
+			*data += dr32(stats[i].regs);
+		else
+			*data += dr16(stats[i].regs);
+	}
 
 #ifdef MEM_MAPPING
 	for (i = 0x100; i <= 0x150; i += 4)
 		dr32(i);
 #endif
-	dr16(TxJumboFrames);
-	dr16(RxJumboFrames);
-	dr16(TCPCheckSumErrors);
-	dr16(UDPCheckSumErrors);
-	dr16(IPCheckSumErrors);
+
+	spin_unlock_irqrestore(&np->stats_lock, flags);
+
 	return &dev->stats;
 }
 
@@ -1131,53 +1184,18 @@ clear_stats (struct net_device *dev)
 {
 	struct netdev_private *np = netdev_priv(dev);
 	void __iomem *ioaddr = np->ioaddr;
-#ifdef MEM_MAPPING
 	int i;
-#endif
 
 	/* All statistics registers need to be acknowledged,
 	   else statistic overflow could cause problems */
-	dr32(FramesRcvOk);
-	dr32(FramesXmtOk);
-	dr32(OctetRcvOk);
-	dr32(OctetXmtOk);
-
-	dr32(McstFramesRcvdOk);
-	dr32(SingleColFrames);
-	dr32(MultiColFrames);
-	dr32(LateCollisions);
-	/* detailed rx errors */
-	dr16(FrameTooLongErrors);
-	dr16(InRangeLengthErrors);
-	dr16(FramesCheckSeqErrors);
-	dr16(FramesLostRxErrors);
-
-	/* detailed tx errors */
-	dr16(FramesAbortXSColls);
-	dr16(CarrierSenseErrors);
-
-	/* Clear all other statistic register. */
-	dr32(McstOctetXmtOk);
-	dr16(BcstFramesXmtdOk);
-	dr32(McstFramesXmtdOk);
-	dr16(BcstFramesRcvdOk);
-	dr16(MacControlFramesRcvd);
-	dr32(McstOctetXmtOk);
-	dr32(BcstOctetXmtOk);
-	dr32(McstFramesXmtdOk);
-	dr32(FramesWDeferredXmt);
-	dr16(BcstFramesXmtdOk);
-	dr16(MacControlFramesXmtd);
-	dr16(FramesWEXDeferal);
-#ifdef MEM_MAPPING
-	for (i = 0x100; i <= 0x150; i += 4)
-		dr32(i);
-#endif
-	dr16(TxJumboFrames);
-	dr16(RxJumboFrames);
-	dr16(TCPCheckSumErrors);
-	dr16(UDPCheckSumErrors);
-	dr16(IPCheckSumErrors);
+
+	for (i = 0; i < STATS_SIZE; i++) {
+		if (stats[i].size == sizeof(u32))
+			dr32(stats[i].regs);
+		else
+			dr16(stats[i].regs);
+	}
+
 	return 0;
 }
 
@@ -1328,11 +1346,48 @@ static u32 rio_get_link(struct net_device *dev)
 	return np->link_status;
 }
 
+static void get_ethtool_stats(struct net_device *dev,
+			      struct ethtool_stats __always_unused *__,
+			      u64 *data)
+{
+	struct netdev_private *np = netdev_priv(dev);
+
+	get_stats(dev);
+
+	for (int i = 0; i < STATS_SIZE; i++)
+		data[i] = *(u64 *) (((void *) np) + stats[i].offset);
+}
+
+static void get_strings(struct net_device *dev, u32 stringset, u8 *data)
+{
+	switch (stringset) {
+	case ETH_SS_STATS:
+		for (int i = 0; i < STATS_SIZE; i++) {
+			memcpy(data, stats[i].string, STATS_STRING_LEN);
+			data += STATS_STRING_LEN;
+		}
+		break;
+	}
+}
+
+static int get_sset_count(struct net_device *dev, int sset)
+{
+	switch (sset) {
+	case ETH_SS_STATS:
+		return STATS_SIZE;
+	}
+
+	return 0;
+}
+
 static const struct ethtool_ops ethtool_ops = {
 	.get_drvinfo = rio_get_drvinfo,
 	.get_link = rio_get_link,
 	.get_link_ksettings = rio_get_link_ksettings,
 	.set_link_ksettings = rio_set_link_ksettings,
+	.get_ethtool_stats = get_ethtool_stats,
+	.get_strings = get_strings,
+	.get_sset_count = get_sset_count
 };
 
 static int
diff --git a/drivers/net/ethernet/dlink/dl2k.h b/drivers/net/ethernet/dlink/dl2k.h
index 195dc6cfd895..fde6596e0ee4 100644
--- a/drivers/net/ethernet/dlink/dl2k.h
+++ b/drivers/net/ethernet/dlink/dl2k.h
@@ -38,6 +38,8 @@
 #define TX_TOTAL_SIZE	TX_RING_SIZE*sizeof(struct netdev_desc)
 #define RX_TOTAL_SIZE	RX_RING_SIZE*sizeof(struct netdev_desc)
 
+#define STATS_STRING_LEN	32
+
 /* Offsets to the device registers.
    Unlike software-only systems, device drivers interact with complex hardware.
    It's not useful to define symbolic names for every register bit in the
@@ -146,6 +148,13 @@ enum dl2x_offsets {
 	EtherStatsPkts1024to1518Octets = 0x150,
 };
 
+struct dlink_stats {
+	char string[STATS_STRING_LEN];
+	size_t offset;
+	enum dl2x_offsets regs;
+	size_t size;
+};
+
 /* Bits in the interrupt status/mask registers. */
 enum IntStatus_bits {
 	InterruptStatus = 0x0001,
@@ -374,6 +383,84 @@ struct netdev_private {
 	void __iomem *eeprom_addr;
 	spinlock_t tx_lock;
 	spinlock_t rx_lock;
+
+	spinlock_t stats_lock;
+	struct {
+		u64 tx_jumbo_frames;
+		u64 rx_jumbo_frames;
+
+		u64 tcp_checksum_errors;
+		u64 udp_checksum_errors;
+		u64 ip_checksum_errors;
+		u64 tx_packets;
+		u64 rx_packets;
+
+		u64 tx_bytes;
+		u64 rx_bytes;
+
+		u64 single_collisions;
+		u64 multi_collisions;
+		u64 late_collisions;
+
+		u64 rx_frames_too_long_errors;
+		u64 rx_in_range_length_errors;
+		u64 rx_frames_check_seq_errors;
+		u64 rx_frames_lost_errors;
+
+		u64 tx_frames_abort;
+		u64 tx_carrier_sense_errors;
+
+		u64 tx_multicast_bytes;
+		u64 rx_multicast_bytes;
+
+		u64 tx_multicast_frames;
+		u64 rx_multicast_frames;
+
+		u64 tx_broadcast_frames;
+		u64 rx_broadcast_frames;
+
+		u64 tx_broadcast_bytes;
+		u64 rx_broadcast_bytes;
+
+		u64 tx_mac_control_frames;
+		u64 rx_mac_control_frames;
+
+		u64 tx_frames_deferred;
+		u64 tx_frames_excessive_deferral;
+
+#ifdef MEM_MAPPING
+		u64 rmon_collisions;
+		u64 rmon_crc_align_errors;
+		u64 rmon_under_size_packets;
+		u64 rmon_fragments;
+		u64 rmon_jabbers;
+
+		u64 rmon_tx_bytes;
+		u64 rmon_rx_bytes;
+
+		u64 rmon_tx_packets;
+		u64 rmon_rx_packets;
+
+		u64 rmon_tx_byte_64;
+		u64 rmon_rx_byte_64;
+
+		u64 rmon_tx_byte_65to127;
+		u64 rmon_rx_byte_64to127;
+
+		u64 rmon_tx_byte_128to255;
+		u64 rmon_rx_byte_128to255;
+
+		u64 rmon_tx_byte_256to511;
+		u64 rmon_rx_byte_256to511;
+
+		u64 rmon_tx_byte_512to1023;
+		u64 rmon_rx_byte_512to1203;
+
+		u64 rmon_tx_byte_1204to1518;
+		u64 rmon_rx_byte_1204to1518;
+#endif
+	};
+
 	unsigned int rx_buf_sz;		/* Based on MTU+slack. */
 	unsigned int speed;		/* Operating speed */
 	unsigned int vlan;		/* VLAN Id */
-- 
2.47.0


