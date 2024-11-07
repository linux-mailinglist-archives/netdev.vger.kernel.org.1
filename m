Return-Path: <netdev+bounces-142883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA72A9C09F2
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 16:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A2412855E2
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 15:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21662101A4;
	Thu,  7 Nov 2024 15:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmLwXIIC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE48DCA6F;
	Thu,  7 Nov 2024 15:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730992849; cv=none; b=QDtbRJ+faKoAV+lzDsbX1zt7hbJ6oF2HTB6E8Lwa7oKEx3m1eu419vsAx7RzsjHYqR3D84sCd8nhMJPFuCejIA0HYT7ApfCaP5cELj9teXo2GyZ6AtK89SPV3QMthWtDcsUwCfYSzeqHzqzBDkaeQIv8erNbloOBc59pu17VAb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730992849; c=relaxed/simple;
	bh=PGya8xVpn5kQ4JN+D1HxS573/7BJyadBjqci37UbNcw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PYmhRdXwwPg3Q3QayExDOZuvvJ53n8EgJ1RZweehIJAKBF2+dbTVxfeZguvrSsTOCB4oay3WCXh3zof0vza/igfauGMoAZhBrOG3aZoSHI8/kONTjqud/EPgEsxSI3BCj7kX896r1ofvuepPgMxjPCRN5dDApJvdBc0TCMRVjOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mmLwXIIC; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71e79f73aaeso807234b3a.3;
        Thu, 07 Nov 2024 07:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730992847; x=1731597647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xg9dz524hmF4NJqkDdqounO3gG084QkqmRm7q85Bbdk=;
        b=mmLwXIICjFbaeXACs9T5QrAV3MCCiBqQnRGqFm86x+HjYIQaSzOnJDwKl2NvegbvbS
         lyQjsb7Irfeaj4y2RaRa1ZpbpTEsDGg46Y42iBdpElhDtIgqCA/0DOWLaL38wrgdPBvJ
         58AMLevtuFnkuzLm2rB8ABx2AAKmpfPRZjdmNWQ2p2lpdMPpGAYNQrIe1ir9A/y5R2iA
         3enQp2BwSb+ON15k8O1ZbV7aDgV+MjIaWYpdSQzDvi/11iXMDsfN3AsTI45+BdTmXcVK
         WhEaia0VhIZf9jntNsaHwXVTzLvdE9e3upXlH9/ZUOTUO2cYRsRdwRd3rbq40jIJA2lz
         LE6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730992847; x=1731597647;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xg9dz524hmF4NJqkDdqounO3gG084QkqmRm7q85Bbdk=;
        b=tqK3KSzUB8R3S4RML63rczAhpwHFRzXDitLo3tgVplBw+smpoebbGvaynXJ0A7GQKG
         e0WC/lk66ipYlAe1IN9tG8mx6/nqS9BroUBSdvrnrNaaA3MvPFWx1xe9yXLY38TgNk7u
         8WX+i4c702Bzb39TBnJ/fMv7r5iBKfWh3RIKr2i5sI/GxMY3zwLmYjxa7bUHHgbpINDE
         Q/0W5IA55/5/wqnsIkH8oY/UxSOUcUylhWGme7Kg3huB7YSrvmAI5+vGryKeEOsPuabc
         qxyaSxijHZwRs3S5sEnrVjfyHvZUEulzvHdgQ/l25CK1n9UfppK2ULAXX4W7Q4JlZOL3
         vCrA==
X-Forwarded-Encrypted: i=1; AJvYcCWprkh3knYn9qQCq9/pL83h/0icrTERuOcAoyRh/2VEQhxVjU6NIZShWer7KWVvb37MWE2F4YYyWEDVVp8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7p5R1RvwKw3fZmiN3UpbYUKbJwT6bTjN88fJRcE5CMnK0w2uS
	+No9BLr8B4pDip5+7P2Pcc/rldbxD5raM7fsatsK/j1WOCePX+sq
X-Google-Smtp-Source: AGHT+IHm7Q5XKC9VEFkn2ix3dTpS7YodpO91f7RQCiOWQjszJm47KFlEIu9CE9CsgJ0wMOgRycBYGw==
X-Received: by 2002:a05:6a00:2da4:b0:71e:76ac:4fc4 with SMTP id d2e1a72fcca58-7206306f175mr60453654b3a.21.1730992846751;
        Thu, 07 Nov 2024 07:20:46 -0800 (PST)
Received: from mythos-cloud.. ([121.185.170.145])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a17ed3sm1706839b3a.142.2024.11.07.07.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 07:20:46 -0800 (PST)
From: Moon Yeounsu <yyyynoom@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andrew@lunn.ch,
	Moon Yeounsu <yyyynoom@gmail.com>
Subject: [PATCH net-next v2] net: dlink: add support for reporting stats via `ethtool -S`
Date: Fri,  8 Nov 2024 00:19:33 +0900
Message-ID: <20241107151929.37147-5-yyyynoom@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch consolidates previously unused statistics and
adds support reporting them through `ethtool -S`.

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
     tx_multicast_bytes: 0
     rx_multicast_bytes: 0
     rmon_collisions: 0
     rmon_crc_align_errors: 0
     rmon_tx_bytes: 0
     rmon_rx_bytes: 0
     rmon_tx_packets: 0
     rmon_rx_packets: 0

$ ethtool -S enp36s0 --all-groups
> Standard stats for enp36s0:
eth-mac-FramesTransmittedOK: 0
eth-mac-SingleCollisionFrames: 0
eth-mac-MultipleCollisionFrames: 0
eth-mac-FramesReceivedOK: 0
eth-mac-FrameCheckSequenceErrors: 0
eth-mac-OctetsTransmittedOK: 0
eth-mac-FramesWithDeferredXmissions: 0
eth-mac-LateCollisions: 0
eth-mac-FramesAbortedDueToXSColls: 0
eth-mac-CarrierSenseErrors: 0
eth-mac-OctetsReceivedOK: 0
eth-mac-FramesLostDueToIntMACRcvError: 0
eth-mac-MulticastFramesXmittedOK: 0
eth-mac-BroadcastFramesXmittedOK: 0
eth-mac-FramesWithExcessiveDeferral: 0
eth-mac-MulticastFramesReceivedOK: 0
eth-mac-BroadcastFramesReceivedOK: 0
eth-mac-InRangeLengthErrors: 0
eth-mac-FrameTooLongErrors: 0
eth-ctrl-MACControlFramesTransmitted: 0
eth-ctrl-MACControlFramesReceived: 0
rmon-etherStatsUndersizePkts: 0
rmon-etherStatsFragments: 0
rmon-etherStatsJabbers: 0
rx-rmon-etherStatsPkts64Octets: 0
rx-rmon-etherStatsPkts65to127Octets: 0
rx-rmon-etherStatsPkts128to255Octets: 0
rx-rmon-etherStatsPkts256to511Octets: 0
rx-rmon-etherStatsPkts512to1023Octets: 0
rx-rmon-etherStatsPkts1024to1518Octets: 0
tx-rmon-etherStatsPkts64Octets: 0
tx-rmon-etherStatsPkts65to127Octets: 0
tx-rmon-etherStatsPkts128to255Octets: 0
tx-rmon-etherStatsPkts256to511Octets: 0
tx-rmon-etherStatsPkts512to1023Octets: 0
tx-rmon-etherStatsPkts1024to1518Octets: 0

Additionally, the previous code did not manage statistics
in a structured manner, so this patch:

1. Added `u64` type stat counters to the `netdev_private` struct.
2. Defined a `dlink_stats` struct for managing statistics.
3. Registered standard statistics and driver-specific statistics
separately.
4. Compressing repetitive tasks through loops.

The code previously blocked by the `#ifdef MEM_MAPPING` preprocessor
directive has been enabled. This section relates to RMON statistics and
does not cause issues when activated. Removing unnecessary preprocessor
directives simplifies the code path and makes it more intuitive.

Tested-on: D-Link DGE-550T Rev-A3
Signed-off-by: Moon Yeounsu <yyyynoom@gmail.com>
---
Changelog:
v1: https://lore.kernel.org/netdev/20241026192651.22169-3-yyyynoom@gmail.com/
v2: Report standard statistics by specific `ethtool_ops`
A more detailed commit message about the changes.
---
 drivers/net/ethernet/dlink/dl2k.c | 356 +++++++++++++++++++++---------
 drivers/net/ethernet/dlink/dl2k.h |  85 +++++++
 2 files changed, 341 insertions(+), 100 deletions(-)

diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index d0ea92607870..e9d5ac602141 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -99,6 +99,143 @@ static const struct net_device_ops netdev_ops = {
 	.ndo_tx_timeout		= rio_tx_timeout,
 };
 
+static const struct ethtool_rmon_hist_range dlink_rmon_ranges[] = {
+	{    0,    64 },
+	{   65,   127 },
+	{  128,   255 },
+	{  256,   511 },
+	{  512,  1023 },
+	{ 1024,  1518 },
+	{ }
+};
+
+#define DEFINE_STATS(FIELD, REGS, SIZE) {				\
+	.string = #FIELD,						\
+	.stat_offset = offsetof(struct netdev_private, FIELD),		\
+	.size = sizeof(SIZE),						\
+	.regs = (REGS)							\
+}
+
+#define DEFINE_RMON_STATS(FIELD, REGS, OFFSET) {			\
+	.data_offset = offsetof(struct ethtool_rmon_stats, OFFSET),	\
+	.stat_offset = offsetof(struct netdev_private, FIELD),		\
+	.size = sizeof(u32),						\
+	.regs = (REGS)							\
+}
+
+#define DEFINE_CTRL_STATS(FIELD, REGS, OFFSET) {			\
+	.data_offset = offsetof(struct ethtool_eth_ctrl_stats, OFFSET),	\
+	.stat_offset = offsetof(struct netdev_private, FIELD),		\
+	.size = sizeof(u16),						\
+	.regs = (REGS)							\
+}
+
+#define DEFINE_MAC_STATS(FIELD, REGS, SIZE, OFFSET) {			\
+	.data_offset = offsetof(struct ethtool_eth_mac_stats, OFFSET),	\
+	.stat_offset = offsetof(struct netdev_private, FIELD),		\
+	.size = sizeof(SIZE),						\
+	.regs = (REGS),							\
+}
+
+#define STATS_SIZE		ARRAY_SIZE(stats)
+#define RMON_STATS_SIZE		ARRAY_SIZE(rmon_stats)
+#define CTRL_STATS_SIZE		ARRAY_SIZE(ctrl_stats)
+#define MAC_STATS_SIZE		ARRAY_SIZE(mac_stats)
+
+static const struct dlink_stats stats[] = {
+	DEFINE_STATS(tx_jumbo_frames, TxJumboFrames, u16),
+	DEFINE_STATS(rx_jumbo_frames, RxJumboFrames, u16),
+
+	DEFINE_STATS(tcp_checksum_errors, TCPCheckSumErrors, u16),
+	DEFINE_STATS(udp_checksum_errors, UDPCheckSumErrors, u16),
+	DEFINE_STATS(ip_checksum_errors, IPCheckSumErrors, u16),
+
+	DEFINE_STATS(tx_multicast_bytes, McstOctetXmtOk, u32),
+	DEFINE_STATS(rx_multicast_bytes, McstOctetRcvOk, u32),
+
+	DEFINE_STATS(rmon_collisions, EtherStatsCollisions, u32),
+	DEFINE_STATS(rmon_crc_align_errors, EtherStatsCRCAlignErrors, u32),
+	DEFINE_STATS(rmon_tx_bytes, EtherStatsOctetsTransmit, u32),
+	DEFINE_STATS(rmon_rx_bytes, EtherStatsOctets, u32),
+	DEFINE_STATS(rmon_tx_packets, EtherStatsPktsTransmit, u32),
+	DEFINE_STATS(rmon_rx_packets, EtherStatsPkts, u32),
+}, ctrl_stats[] = {
+	DEFINE_CTRL_STATS(tx_mac_control_frames, MacControlFramesXmtd,
+			  MACControlFramesTransmitted),
+	DEFINE_CTRL_STATS(rx_mac_control_frames, MacControlFramesRcvd,
+			  MACControlFramesReceived),
+}, mac_stats[] = {
+	DEFINE_MAC_STATS(tx_packets, FramesXmtOk,
+			 u32, FramesTransmittedOK),
+	DEFINE_MAC_STATS(rx_packets, FramesRcvOk,
+			 u32, FramesReceivedOK),
+	DEFINE_MAC_STATS(tx_bytes, OctetXmtOk,
+			 u32, OctetsTransmittedOK),
+	DEFINE_MAC_STATS(rx_bytes, OctetRcvOk,
+			 u32, OctetsReceivedOK),
+	DEFINE_MAC_STATS(single_collisions, SingleColFrames,
+			 u32, SingleCollisionFrames),
+	DEFINE_MAC_STATS(multi_collisions, MultiColFrames,
+			 u32, MultipleCollisionFrames),
+	DEFINE_MAC_STATS(late_collisions, LateCollisions,
+			 u32, LateCollisions),
+	DEFINE_MAC_STATS(rx_frames_too_long_errors, FrameTooLongErrors,
+			 u16, FrameTooLongErrors),
+	DEFINE_MAC_STATS(rx_in_range_length_errors, InRangeLengthErrors,
+			 u16, InRangeLengthErrors),
+	DEFINE_MAC_STATS(rx_frames_check_seq_errors, FramesCheckSeqErrors,
+			 u16, FrameCheckSequenceErrors),
+	DEFINE_MAC_STATS(rx_frames_lost_errors, FramesLostRxErrors,
+			 u16, FramesLostDueToIntMACRcvError),
+	DEFINE_MAC_STATS(tx_frames_abort, FramesAbortXSColls,
+			 u16, FramesAbortedDueToXSColls),
+	DEFINE_MAC_STATS(tx_carrier_sense_errors, CarrierSenseErrors,
+			 u16, CarrierSenseErrors),
+	DEFINE_MAC_STATS(tx_multicast_frames, McstFramesXmtdOk,
+			 u32, MulticastFramesXmittedOK),
+	DEFINE_MAC_STATS(rx_multicast_frames, McstFramesRcvdOk,
+			 u32, MulticastFramesReceivedOK),
+	DEFINE_MAC_STATS(tx_broadcast_frames, BcstFramesXmtdOk,
+			 u16, BroadcastFramesXmittedOK),
+	DEFINE_MAC_STATS(rx_broadcast_frames, BcstFramesRcvdOk,
+			 u16, BroadcastFramesReceivedOK),
+	DEFINE_MAC_STATS(tx_frames_deferred, FramesWDeferredXmt,
+			 u32, FramesWithDeferredXmissions),
+	DEFINE_MAC_STATS(tx_frames_excessive_deferral, FramesWEXDeferal,
+			 u16, FramesWithExcessiveDeferral),
+}, rmon_stats[] = {
+	DEFINE_RMON_STATS(rmon_under_size_packets,
+			  EtherStatsUndersizePkts, undersize_pkts),
+	DEFINE_RMON_STATS(rmon_fragments,
+			  EtherStatsFragments, fragments),
+	DEFINE_RMON_STATS(rmon_jabbers,
+			  EtherStatsJabbers, jabbers),
+	DEFINE_RMON_STATS(rmon_tx_byte_64,
+			  EtherStatsPkts64OctetTransmit, hist_tx[0]),
+	DEFINE_RMON_STATS(rmon_rx_byte_64,
+			  EtherStats64Octets, hist[0]),
+	DEFINE_RMON_STATS(rmon_tx_byte_65to127,
+			  EtherStats65to127OctetsTransmit, hist_tx[1]),
+	DEFINE_RMON_STATS(rmon_rx_byte_64to127,
+			  EtherStatsPkts65to127Octets, hist[1]),
+	DEFINE_RMON_STATS(rmon_tx_byte_128to255,
+			  EtherStatsPkts128to255OctetsTransmit, hist_tx[2]),
+	DEFINE_RMON_STATS(rmon_rx_byte_128to255,
+			  EtherStatsPkts128to255Octets, hist[2]),
+	DEFINE_RMON_STATS(rmon_tx_byte_256to511,
+			  EtherStatsPkts256to511OctetsTransmit, hist_tx[3]),
+	DEFINE_RMON_STATS(rmon_rx_byte_256to511,
+			  EtherStatsPkts256to511Octets, hist[3]),
+	DEFINE_RMON_STATS(rmon_tx_byte_512to1023,
+			  EtherStatsPkts512to1023OctetsTransmit, hist_tx[4]),
+	DEFINE_RMON_STATS(rmon_rx_byte_512to1203,
+			  EtherStatsPkts512to1023Octets, hist[4]),
+	DEFINE_RMON_STATS(rmon_tx_byte_1204to1518,
+			  EtherStatsPkts1024to1518OctetsTransmit, hist_tx[5]),
+	DEFINE_RMON_STATS(rmon_rx_byte_1204to1518,
+			  EtherStatsPkts1024to1518Octets, hist[5])
+};
+
 static int
 rio_probe1 (struct pci_dev *pdev, const struct pci_device_id *ent)
 {
@@ -137,17 +274,17 @@ rio_probe1 (struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_out_dev;
 	np->eeprom_addr = ioaddr;
 
-#ifdef MEM_MAPPING
 	/* MM registers range. */
 	ioaddr = pci_iomap(pdev, 1, 0);
 	if (!ioaddr)
 		goto err_out_iounmap;
-#endif
+
 	np->ioaddr = ioaddr;
 	np->chip_id = chip_idx;
 	np->pdev = pdev;
 	spin_lock_init (&np->tx_lock);
 	spin_lock_init (&np->rx_lock);
+	spin_lock_init(&np->stats_lock);
 
 	/* Parse manual configuration */
 	np->an_enable = 1;
@@ -287,9 +424,7 @@ rio_probe1 (struct pci_dev *pdev, const struct pci_device_id *ent)
 	dma_free_coherent(&pdev->dev, TX_TOTAL_SIZE, np->tx_ring,
 			  np->tx_ring_dma);
 err_out_iounmap:
-#ifdef MEM_MAPPING
 	pci_iounmap(pdev, np->ioaddr);
-#endif
 	pci_iounmap(pdev, np->eeprom_addr);
 err_out_dev:
 	free_netdev (dev);
@@ -1064,65 +1199,44 @@ rio_error (struct net_device *dev, int int_status)
 	}
 }
 
+#define READ_STAT(S, B, I) (*((u64 *) (((void *) B) + S[I].stat_offset)))
+#define READ_DATA(S, B, I) (*((u64 *) (((void *) B) + S[I].data_offset)))
+
+#define GET_STATS(STATS, SIZE)					\
+	for (int i = 0; i < SIZE; i++) {				\
+		if (STATS[i].size == sizeof(u32))			\
+			READ_STAT(STATS, np, i) = dr32(STATS[i].regs);	\
+		else							\
+			READ_STAT(STATS, np, i) = dr16(STATS[i].regs);	\
+	}
+
+#define CLEAR_STATS(STATS, SIZE)					\
+	for (int i = 0; i < SIZE; i++) {				\
+		if (STATS[i].size == sizeof(u32))			\
+			dr32(STATS[i].regs);				\
+		else							\
+			dr16(STATS[i].regs);				\
+	}
+
 static struct net_device_stats *
 get_stats (struct net_device *dev)
 {
 	struct netdev_private *np = netdev_priv(dev);
 	void __iomem *ioaddr = np->ioaddr;
-#ifdef MEM_MAPPING
-	int i;
-#endif
-	unsigned int stat_reg;
+	unsigned long flags;
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
-
-#ifdef MEM_MAPPING
-	for (i = 0x100; i <= 0x150; i += 4)
-		dr32(i);
-#endif
-	dr16(TxJumboFrames);
-	dr16(RxJumboFrames);
-	dr16(TCPCheckSumErrors);
-	dr16(UDPCheckSumErrors);
-	dr16(IPCheckSumErrors);
+	GET_STATS(stats, STATS_SIZE);
+	GET_STATS(rmon_stats, RMON_STATS_SIZE);
+	GET_STATS(ctrl_stats, CTRL_STATS_SIZE);
+	GET_STATS(mac_stats, MAC_STATS_SIZE);
+
+	spin_unlock_irqrestore(&np->stats_lock, flags);
+
 	return &dev->stats;
 }
 
@@ -1131,53 +1245,15 @@ clear_stats (struct net_device *dev)
 {
 	struct netdev_private *np = netdev_priv(dev);
 	void __iomem *ioaddr = np->ioaddr;
-#ifdef MEM_MAPPING
-	int i;
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
+	CLEAR_STATS(stats, STATS_SIZE);
+	CLEAR_STATS(rmon_stats, RMON_STATS_SIZE);
+	CLEAR_STATS(ctrl_stats, CTRL_STATS_SIZE);
+	CLEAR_STATS(mac_stats, MAC_STATS_SIZE);
+
 	return 0;
 }
 
@@ -1328,11 +1404,93 @@ static u32 rio_get_link(struct net_device *dev)
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
+	for (int i = 0, j = 0; i < STATS_SIZE; i++)
+		data[j++] = READ_STAT(stats, np, i);
+}
+
+static void get_ethtool_rmon_stats(
+		struct net_device *dev,
+		struct ethtool_rmon_stats *rmon_base,
+		const struct ethtool_rmon_hist_range **ranges)
+{
+	struct netdev_private *np = netdev_priv(dev);
+
+	for (int i = 0; i < RMON_STATS_SIZE; i++)
+		READ_DATA(rmon_stats, rmon_base, i) = READ_STAT(rmon_stats, np, i);
+
+	*ranges = dlink_rmon_ranges;
+}
+
+static void get_ethtool_ctrl_stats(struct net_device *dev,
+				   struct ethtool_eth_ctrl_stats *ctrl_base)
+{
+	struct netdev_private *np = netdev_priv(dev);
+
+	get_stats(dev);
+
+	if (ctrl_base->src != ETHTOOL_MAC_STATS_SRC_AGGREGATE)
+		return;
+
+	for (int i = 0; i < CTRL_STATS_SIZE; i++)
+		READ_DATA(ctrl_stats, ctrl_base, i) = READ_STAT(ctrl_stats, np, i);
+}
+
+static void get_ethtool_mac_stats(struct net_device *dev,
+				  struct ethtool_eth_mac_stats *mac_base)
+{
+	struct netdev_private *np = netdev_priv(dev);
+
+	get_stats(dev);
+
+	if (mac_base->src != ETHTOOL_MAC_STATS_SRC_AGGREGATE)
+		return;
+
+	for (int i = 0; i < MAC_STATS_SIZE; i++)
+		READ_DATA(mac_stats, mac_base, i) = READ_STAT(mac_stats, np, i);
+}
+
+
+static void get_strings(struct net_device *dev, u32 stringset, u8 *data)
+{
+	switch (stringset) {
+	case ETH_SS_STATS:
+		for (int i = 0; i < STATS_SIZE; i++) {
+			memcpy(data, stats[i].string, ETH_GSTRING_LEN);
+			data += ETH_GSTRING_LEN;
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
+	.get_rmon_stats = get_ethtool_rmon_stats,
+	.get_eth_ctrl_stats = get_ethtool_ctrl_stats,
+	.get_eth_mac_stats = get_ethtool_mac_stats,
+	.get_strings = get_strings,
+	.get_sset_count = get_sset_count
 };
 
 static int
@@ -1798,9 +1956,7 @@ rio_remove1 (struct pci_dev *pdev)
 				  np->rx_ring_dma);
 		dma_free_coherent(&pdev->dev, TX_TOTAL_SIZE, np->tx_ring,
 				  np->tx_ring_dma);
-#ifdef MEM_MAPPING
 		pci_iounmap(pdev, np->ioaddr);
-#endif
 		pci_iounmap(pdev, np->eeprom_addr);
 		free_netdev (dev);
 		pci_release_regions (pdev);
diff --git a/drivers/net/ethernet/dlink/dl2k.h b/drivers/net/ethernet/dlink/dl2k.h
index 195dc6cfd895..346c912df411 100644
--- a/drivers/net/ethernet/dlink/dl2k.h
+++ b/drivers/net/ethernet/dlink/dl2k.h
@@ -46,6 +46,7 @@
    In general, only the important configuration values or bits changed
    multiple times should be defined symbolically.
 */
+
 enum dl2x_offsets {
 	/* I/O register offsets */
 	DMACtrl = 0x00,
@@ -146,6 +147,14 @@ enum dl2x_offsets {
 	EtherStatsPkts1024to1518Octets = 0x150,
 };
 
+struct dlink_stats {
+	char string[ETH_GSTRING_LEN];
+	size_t data_offset;
+	size_t stat_offset;
+	size_t size;
+	enum dl2x_offsets regs;
+};
+
 /* Bits in the interrupt status/mask registers. */
 enum IntStatus_bits {
 	InterruptStatus = 0x0001,
@@ -374,6 +383,82 @@ struct netdev_private {
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
+	};
+
 	unsigned int rx_buf_sz;		/* Based on MTU+slack. */
 	unsigned int speed;		/* Operating speed */
 	unsigned int vlan;		/* VLAN Id */
-- 
2.47.0


