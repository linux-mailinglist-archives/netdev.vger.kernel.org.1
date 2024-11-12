Return-Path: <netdev+bounces-144035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 040C89C52FE
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 11:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E769B22FDD
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 10:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEACC20E31D;
	Tue, 12 Nov 2024 10:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0Jg6BwN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CEB1F26F8;
	Tue, 12 Nov 2024 10:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731405859; cv=none; b=ju3spTqqMZ3XexlE/vqrKWtmbSlxEoWZJs8JtASzUeXbeVrswclDkZq2Gl+2u4pzB8T6XuRXMp6xq259dDVkFiblpUjqkk6Q7ANSGKNWcWLwKNILYJ8qt5ZH23I+XhMD3Ko9wDiTuz6F2d/m1iozMR+C19meGmRAjWnGGyF3vJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731405859; c=relaxed/simple;
	bh=919agNdlK1V2GIBvMk3kZwm6DZu8s9b3dR01G58PRI0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qLHejglN0dJ6f61CS2rEuMnvQdlpkSEB5VJ9EWsHkSsX0nINKmeEx6u+FCZ3GSS+gRw+Z2NPbBBYL0RvK16vWpt3DzHaSoZglPm8qQpYKv2/dAPf7Sbz30zLLAcldb38pDhxBUSc8CPZG+i48rVp7JZMknpCk4en/kkISy5wCrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z0Jg6BwN; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20c767a9c50so52592775ad.1;
        Tue, 12 Nov 2024 02:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731405857; x=1732010657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y96nOR+p86gk9dHM8WUv6cNXj22r1+e0au19T7evl8k=;
        b=Z0Jg6BwNni79o32uF0S6BK4MWNB5TYpZ+fIp/Z54Hz4rJOfWG/lFl4BtMSwI8cLTVq
         uUqRl4HLkk7e9mb7KNpS3FcSEbgiKwxAHVLqZbzkgQwsGL/IWiZa7P859xoBASA3y+n0
         bebu9BpxPGRy8lRzgp9GB2ygZPwL/uy4KQKnJgCdFb52zX3YIRXElmvZlAiVFpSBxuoE
         TnRhr1BKMVZbq/W8XicgbNiv5jV4co0FVEzufsoW5cUSgKd4x9GKGDfJ9q2KcuRMErfn
         cVhDX6C0Qs9p+X8Ylrk84iXBLFE5C/3uLGz2RnIslFF86EmX/5YDrqm+7JwDuaImtODP
         ukQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731405857; x=1732010657;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y96nOR+p86gk9dHM8WUv6cNXj22r1+e0au19T7evl8k=;
        b=LjcN+c4dR93SoohxPhADgy5GeWaGe5+Pz1JcYEdquFH2mJCXjXm8WTzxHBsZmyLfkj
         pzKHNGw/rXzTOEQ3rsYZaq+kx+SeteC6VL1YZat5KaQvb9O5t00k30UmaDIWflO8Te7o
         UCKoOaNVvgDjpd2EBsNqRqyFfZs4wKSK8VN1rMZKd7dy6BAmD2GiQEHVqYOn5HdRq98D
         3FCtGSWT/TDm32qb8jm9JBKd7odOcyFBQYeV5OcapXk0jXWrOeoPWvAzXv5VASAMMMw9
         1Ivc5mlffoQsYKpsdDov7H5EWDsjQj7qcS9gKh99fz/8pNfLZP+aZQckkmzeUqX5JhnS
         xoZg==
X-Forwarded-Encrypted: i=1; AJvYcCWc4JCYdpaPe+/qGiAASjuxQ9CZXpvikJP+E2v/7OmQ88godz53nz1KG6PDTkqC1PiO8CGfUXK9/u2HUfo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjZYc4A6oo43ZKoDLz6OZfQkqoqoPiIWWn0wDPebBRumMHb7ih
	vq3W23dT7rLKcwmlz0w3WyQk99YPPO8MgrObTWXCp9mMukNZnhi4
X-Google-Smtp-Source: AGHT+IGKPpY2kb/OUf45FJeV7K6d/PT715CH+JD4/8/7CpdB/wzl+XcripUSmpER+MwqdZJumkzyXw==
X-Received: by 2002:a17:903:41c6:b0:202:cbf:2d6f with SMTP id d9443c01a7336-21183db6b71mr180672835ad.57.1731405856465;
        Tue, 12 Nov 2024 02:04:16 -0800 (PST)
Received: from mythos-cloud.. ([121.185.170.145])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc7e96sm90595825ad.42.2024.11.12.02.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 02:04:16 -0800 (PST)
From: Moon Yeounsu <yyyynoom@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	andrew@lunn.ch
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Moon Yeounsu <yyyynoom@gmail.com>
Subject: [PATCH net-next v3] net: dlink: add support for reporting stats via `ethtool -S`
Date: Tue, 12 Nov 2024 19:03:28 +0900
Message-ID: <20241112100328.134730-1-yyyynoom@gmail.com>
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
 drivers/net/ethernet/dlink/dl2k.c | 625 +++++++++++++++++++++++++-----
 drivers/net/ethernet/dlink/dl2k.h |  85 ++++
 2 files changed, 610 insertions(+), 100 deletions(-)

diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index d0ea92607870..d664017f3a70 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -99,6 +99,414 @@ static const struct net_device_ops netdev_ops = {
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
+#define STATS_SIZE		ARRAY_SIZE(stats)
+#define RMON_STATS_SIZE		ARRAY_SIZE(rmon_stats)
+#define CTRL_STATS_SIZE		ARRAY_SIZE(ctrl_stats)
+#define MAC_STATS_SIZE		ARRAY_SIZE(mac_stats)
+
+static const struct dlink_stats stats[] = {
+	{
+		.string = "tx_jumbo_frames",
+		.stat_offset = offsetof(struct netdev_private,
+					tx_jumbo_frames),
+		.size = sizeof(u16),
+		.regs = TxJumboFrames
+	},
+	{
+		.string = "rx_jumbo_frames",
+		.stat_offset = offsetof(struct netdev_private,
+					rx_jumbo_frames),
+		.size = sizeof(u16),
+		.regs = RxJumboFrames
+	},
+	{
+		.string = "tcp_checksum_errors",
+		.stat_offset = offsetof(struct netdev_private,
+					tcp_checksum_errors),
+		.size = sizeof(u16),
+		.regs = TCPCheckSumErrors
+	},
+	{
+		.string = "udp_checksum_errors",
+		.stat_offset = offsetof(struct netdev_private,
+					udp_checksum_errors),
+		.size = sizeof(u16),
+		.regs = UDPCheckSumErrors
+	},
+	{
+		.string = "ip_checksum_errors",
+		.stat_offset = offsetof(struct netdev_private,
+					ip_checksum_errors),
+		.size = sizeof(u16),
+		.regs = IPCheckSumErrors
+	},
+	{
+		.string = "tx_multicast_bytes",
+		.stat_offset = offsetof(struct netdev_private,
+					tx_multicast_bytes),
+		.size = sizeof(u32),
+		.regs = McstOctetXmtOk
+	},
+	{
+		.string = "rx_multicast_bytes",
+		.stat_offset = offsetof(struct netdev_private,
+					rx_multicast_bytes),
+		.size = sizeof(u32),
+		.regs = McstOctetRcvOk
+	},
+	{
+		.string = "rmon_collisions",
+		.stat_offset = offsetof(struct netdev_private,
+					rmon_collisions),
+		.size = sizeof(u32),
+		.regs = EtherStatsCollisions
+	},
+	{
+		.string = "rmon_crc_align_errors",
+		.stat_offset = offsetof(struct netdev_private,
+					rmon_crc_align_errors),
+		.size = sizeof(u32),
+		.regs = EtherStatsCRCAlignErrors
+	},
+	{
+		.string = "rmon_tx_bytes",
+		.stat_offset = offsetof(struct netdev_private,
+					rmon_tx_bytes),
+		.size = sizeof(u32),
+		.regs = EtherStatsOctetsTransmit
+	},
+	{
+		.string = "rmon_rx_bytes",
+		.stat_offset = offsetof(struct netdev_private,
+					rmon_rx_bytes),
+		.size = sizeof(u32),
+		.regs = EtherStatsOctets
+	},
+	{
+		.string = "rmon_tx_packets",
+		.stat_offset = offsetof(struct netdev_private,
+					rmon_tx_packets),
+		.size = sizeof(u32),
+		.regs = EtherStatsPktsTransmit
+	},
+	{
+		.string = "rmon_rx_packets",
+		.stat_offset = offsetof(struct netdev_private,
+					rmon_rx_packets),
+		.size = sizeof(u32),
+		.regs = EtherStatsPkts
+	}
+}, ctrl_stats[] = {
+	{
+		.data_offset = offsetof(struct ethtool_eth_ctrl_stats,
+					MACControlFramesTransmitted),
+		.stat_offset = offsetof(struct netdev_private,
+					tx_mac_control_frames),
+		.size = sizeof(u16),
+		.regs = MacControlFramesXmtd
+	},
+	{
+		.data_offset = offsetof(struct ethtool_eth_ctrl_stats,
+					MACControlFramesReceived),
+		.stat_offset = offsetof(struct netdev_private,
+					rx_mac_control_frames),
+		.size = sizeof(u16),
+		.regs = MacControlFramesRcvd
+	}
+}, mac_stats[] = {
+	{
+		.data_offset = offsetof(struct ethtool_eth_mac_stats,
+					FramesTransmittedOK),
+		.stat_offset = offsetof(struct netdev_private,
+					tx_packets),
+		.size = sizeof(u32),
+		.regs = FramesXmtOk,
+	},
+	{
+		.data_offset = offsetof(struct ethtool_eth_mac_stats,
+					FramesReceivedOK),
+		.stat_offset = offsetof(struct netdev_private,
+					rx_packets),
+		.size = sizeof(u32),
+		.regs = FramesRcvOk,
+	},
+	{
+		.data_offset = offsetof(struct ethtool_eth_mac_stats,
+					OctetsTransmittedOK),
+		.stat_offset = offsetof(struct netdev_private,
+					tx_bytes),
+		.size = sizeof(u32),
+		.regs = OctetXmtOk,
+	},
+	{
+		.data_offset = offsetof(struct ethtool_eth_mac_stats,
+					OctetsReceivedOK),
+		.stat_offset = offsetof(struct netdev_private,
+					rx_bytes),
+		.size = sizeof(u32),
+		.regs = OctetRcvOk,
+	},
+	{
+		.data_offset = offsetof(struct ethtool_eth_mac_stats,
+					SingleCollisionFrames),
+		.stat_offset = offsetof(struct netdev_private,
+					single_collisions),
+		.size = sizeof(u32),
+		.regs = SingleColFrames,
+	},
+	{
+		.data_offset = offsetof(struct ethtool_eth_mac_stats,
+					MultipleCollisionFrames),
+		.stat_offset = offsetof(struct netdev_private,
+					multi_collisions),
+		.size = sizeof(u32),
+		.regs = MultiColFrames,
+	},
+	{
+		.data_offset = offsetof(struct ethtool_eth_mac_stats,
+					LateCollisions),
+		.stat_offset = offsetof(struct netdev_private,
+					late_collisions),
+		.size = sizeof(u32),
+		.regs = LateCollisions,
+	},
+	{
+		.data_offset = offsetof(struct ethtool_eth_mac_stats,
+					FrameTooLongErrors),
+		.stat_offset = offsetof(struct netdev_private,
+					rx_frames_too_long_errors),
+		.size = sizeof(u16),
+		.regs = FrameTooLongErrors,
+	},
+	{
+		.data_offset = offsetof(struct ethtool_eth_mac_stats,
+					InRangeLengthErrors),
+		.stat_offset = offsetof(struct netdev_private,
+					rx_in_range_length_errors),
+		.size = sizeof(u16),
+		.regs = InRangeLengthErrors,
+	},
+	{
+		.data_offset = offsetof(struct ethtool_eth_mac_stats,
+					FrameCheckSequenceErrors),
+		.stat_offset = offsetof(struct netdev_private,
+					rx_frames_check_seq_errors),
+		.size = sizeof(u16),
+		.regs = FramesCheckSeqErrors,
+	},
+	{
+		.data_offset = offsetof(struct ethtool_eth_mac_stats,
+					FramesLostDueToIntMACRcvError),
+		.stat_offset = offsetof(struct netdev_private,
+					rx_frames_lost_errors),
+		.size = sizeof(u16),
+		.regs = FramesLostRxErrors,
+	},
+	{
+		.data_offset = offsetof(struct ethtool_eth_mac_stats,
+					FramesAbortedDueToXSColls),
+		.stat_offset = offsetof(struct netdev_private,
+					tx_frames_abort),
+		.size = sizeof(u16),
+		.regs = FramesAbortXSColls,
+	},
+	{
+		.data_offset = offsetof(struct ethtool_eth_mac_stats,
+					CarrierSenseErrors),
+		.stat_offset = offsetof(struct netdev_private,
+					tx_carrier_sense_errors),
+		.size = sizeof(u16),
+		.regs = CarrierSenseErrors,
+	},
+	{
+		.data_offset = offsetof(struct ethtool_eth_mac_stats,
+					MulticastFramesXmittedOK),
+		.stat_offset = offsetof(struct netdev_private,
+					tx_multicast_frames),
+		.size = sizeof(u32),
+		.regs = McstFramesXmtdOk,
+	},
+	{
+		.data_offset = offsetof(struct ethtool_eth_mac_stats,
+					MulticastFramesReceivedOK),
+		.stat_offset = offsetof(struct netdev_private,
+					rx_multicast_frames),
+		.size = sizeof(u32),
+		.regs = McstFramesRcvdOk,
+	},
+	{
+		.data_offset = offsetof(struct ethtool_eth_mac_stats,
+					BroadcastFramesXmittedOK),
+		.stat_offset = offsetof(struct netdev_private,
+					tx_broadcast_frames),
+		.size = sizeof(u16),
+		.regs = BcstFramesXmtdOk,
+	},
+	{
+		.data_offset = offsetof(struct ethtool_eth_mac_stats,
+					BroadcastFramesReceivedOK),
+		.stat_offset = offsetof(struct netdev_private,
+					rx_broadcast_frames),
+		.size = sizeof(u16),
+		.regs = BcstFramesRcvdOk,
+	},
+	{
+		.data_offset = offsetof(struct ethtool_eth_mac_stats,
+					FramesWithDeferredXmissions),
+		.stat_offset = offsetof(struct netdev_private,
+					tx_frames_deferred),
+		.size = sizeof(u32),
+		.regs = FramesWDeferredXmt,
+	},
+	{
+		.data_offset = offsetof(struct ethtool_eth_mac_stats,
+					FramesWithExcessiveDeferral),
+		.stat_offset = offsetof(struct netdev_private,
+					tx_frames_excessive_deferral),
+		.size = sizeof(u16),
+		.regs = FramesWEXDeferal,
+	},
+}, rmon_stats[] = {
+	{
+		.data_offset = offsetof(struct ethtool_rmon_stats,
+					undersize_pkts),
+		.stat_offset = offsetof(struct netdev_private,
+					rmon_under_size_packets),
+		.size = sizeof(u32),
+		.regs = EtherStatsUndersizePkts
+	},
+	{
+		.data_offset = offsetof(struct ethtool_rmon_stats,
+					fragments),
+		.stat_offset = offsetof(struct netdev_private,
+					rmon_fragments),
+		.size = sizeof(u32),
+		.regs = EtherStatsFragments
+	},
+	{
+		.data_offset = offsetof(struct ethtool_rmon_stats,
+					fragments),
+		.stat_offset = offsetof(struct netdev_private,
+					rmon_fragments),
+		.size = sizeof(u32),
+		.regs = EtherStatsFragments
+	},
+	{
+		.stat_offset = offsetof(struct netdev_private,
+					rmon_jabbers),
+		.data_offset = offsetof(struct ethtool_rmon_stats,
+					jabbers),
+		.size = sizeof(u32),
+		.regs = EtherStatsJabbers
+	},
+	{
+		.data_offset = offsetof(struct ethtool_rmon_stats,
+					hist_tx[0]),
+		.stat_offset = offsetof(struct netdev_private,
+					rmon_tx_byte_64),
+		.size = sizeof(u32),
+		.regs = EtherStatsPkts64OctetTransmit
+	},
+	{
+		.data_offset = offsetof(struct ethtool_rmon_stats,
+					hist[0]),
+		.stat_offset = offsetof(struct netdev_private,
+					rmon_rx_byte_64),
+		.size = sizeof(u32),
+		.regs = EtherStats64Octets
+	},
+	{
+		.data_offset = offsetof(struct ethtool_rmon_stats,
+					hist_tx[1]),
+		.stat_offset = offsetof(struct netdev_private,
+					rmon_tx_byte_65to127),
+		.size = sizeof(u32),
+		.regs = EtherStats65to127OctetsTransmit
+	},
+	{
+		.data_offset = offsetof(struct ethtool_rmon_stats,
+					hist[1]),
+		.stat_offset = offsetof(struct netdev_private,
+					rmon_rx_byte_64to127),
+		.size = sizeof(u32),
+		.regs = EtherStatsPkts65to127Octets
+	},
+	{
+		.data_offset = offsetof(struct ethtool_rmon_stats,
+					hist_tx[2]),
+		.stat_offset = offsetof(struct netdev_private,
+					rmon_tx_byte_128to255),
+		.size = sizeof(u32),
+		.regs = EtherStatsPkts128to255OctetsTransmit
+	},
+	{
+		.data_offset = offsetof(struct ethtool_rmon_stats,
+					hist[2]),
+		.stat_offset = offsetof(struct netdev_private,
+					rmon_rx_byte_128to255),
+		.size = sizeof(u32),
+		.regs = EtherStatsPkts128to255Octets
+	},
+	{
+		.data_offset = offsetof(struct ethtool_rmon_stats,
+					hist_tx[3]),
+		.stat_offset = offsetof(struct netdev_private,
+					rmon_tx_byte_256to511),
+		.size = sizeof(u32),
+		.regs = EtherStatsPkts256to511OctetsTransmit
+	},
+	{
+		.data_offset = offsetof(struct ethtool_rmon_stats,
+					hist[3]),
+		.stat_offset = offsetof(struct netdev_private,
+					rmon_rx_byte_256to511),
+		.size = sizeof(u32),
+		.regs = EtherStatsPkts256to511Octets
+	},
+	{
+		.data_offset = offsetof(struct ethtool_rmon_stats,
+					hist_tx[4]),
+		.stat_offset = offsetof(struct netdev_private,
+					rmon_tx_byte_512to1023),
+		.size = sizeof(u32),
+		.regs = EtherStatsPkts512to1023OctetsTransmit
+	},
+	{
+		.data_offset = offsetof(struct ethtool_rmon_stats,
+					hist[4]),
+		.stat_offset = offsetof(struct netdev_private,
+					rmon_rx_byte_512to1203),
+		.size = sizeof(u32),
+		.regs = EtherStatsPkts512to1023Octets
+	},
+	{
+		.data_offset = offsetof(struct ethtool_rmon_stats,
+					hist_tx[5]),
+		.stat_offset = offsetof(struct netdev_private,
+					rmon_tx_byte_1204to1518),
+		.size = sizeof(u32),
+		.regs = EtherStatsPkts1024to1518OctetsTransmit
+	},
+	{
+		.data_offset = offsetof(struct ethtool_rmon_stats,
+					hist[5]),
+		.stat_offset = offsetof(struct netdev_private,
+					rmon_rx_byte_1204to1518),
+		.size = sizeof(u32),
+		.regs = EtherStatsPkts1024to1518Octets
+	}
+};
+
 static int
 rio_probe1 (struct pci_dev *pdev, const struct pci_device_id *ent)
 {
@@ -137,17 +545,17 @@ rio_probe1 (struct pci_dev *pdev, const struct pci_device_id *ent)
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
@@ -287,9 +695,7 @@ rio_probe1 (struct pci_dev *pdev, const struct pci_device_id *ent)
 	dma_free_coherent(&pdev->dev, TX_TOTAL_SIZE, np->tx_ring,
 			  np->tx_ring_dma);
 err_out_iounmap:
-#ifdef MEM_MAPPING
 	pci_iounmap(pdev, np->ioaddr);
-#endif
 	pci_iounmap(pdev, np->eeprom_addr);
 err_out_dev:
 	free_netdev (dev);
@@ -1064,65 +1470,44 @@ rio_error (struct net_device *dev, int int_status)
 	}
 }
 
+#define READ_STAT(S, B, I) (*((u64 *)(((void *)B) + (S)[I].stat_offset)))
+#define READ_DATA(S, B, I) (*((u64 *)(((void *)B) + (S)[I].data_offset)))
+
+#define GET_STATS(STATS, SIZE)					\
+	for (int i = 0; i < (SIZE); i++) {				\
+		if (STATS[i].size == sizeof(u32))			\
+			READ_STAT(STATS, np, i) = dr32(STATS[i].regs);	\
+		else							\
+			READ_STAT(STATS, np, i) = dr16(STATS[i].regs);	\
+	}
+
+#define CLEAR_STATS(STATS, SIZE)					\
+	for (int i = 0; i < (SIZE); i++) {				\
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
 
@@ -1131,53 +1516,15 @@ clear_stats (struct net_device *dev)
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
 
@@ -1328,11 +1675,91 @@ static u32 rio_get_link(struct net_device *dev)
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
+static void get_ethtool_rmon_stats(struct net_device *dev,
+				   struct ethtool_rmon_stats *rmon_base,
+				   const struct ethtool_rmon_hist_range **ranges)
+{
+	struct netdev_private *np = netdev_priv(dev);
+
+	get_stats(dev);
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
+static void get_strings(struct net_device *dev, u32 stringset, u8 *data)
+{
+	switch (stringset) {
+	case ETH_SS_STATS:
+		for (int i = 0; i < STATS_SIZE; i++)
+			ethtool_puts(&data, stats[i].string);
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
@@ -1798,9 +2225,7 @@ rio_remove1 (struct pci_dev *pdev)
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


