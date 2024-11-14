Return-Path: <netdev+bounces-144954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4D29C8DD0
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 16:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C15B1F24FFD
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 15:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D10B1420A8;
	Thu, 14 Nov 2024 15:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFtixhuA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FF013CFA8;
	Thu, 14 Nov 2024 15:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731597766; cv=none; b=iF/hlUbzEZla4hTYZ5nx8aDNexdmoDBVVV48YFzBtplyuHWqVFU57T5X/Ont8AB/zFQuA5/xGLZIfIlImDszu9ZvEnQgTu2Pz7ppxb/htFCxSawdvXIhsxdABsJzDVvHPNS0Nz96kjsXGs8eS7MQWneZb5aGW4+kzIOJOoGYk20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731597766; c=relaxed/simple;
	bh=Y4ENPQ4jqr3sDSum6WZ90SpSI+DVpjDqlMXlMguhkKM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BiTz2Ye/0GHdjHV8Mhs0p2WCMIFgHCTiKvYH1O1WKbM/PK4YluWHUpfMYAvJeHJvZfUP4aGCmw5vOc7cBuqffQhOzLbGKTb4meKMPFmHnVr+NaoIttOMzReE7lNViWqrbp36G6MPqFA8qRta1IDp2VnSILTwLE9YPSJfxcIo/po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HFtixhuA; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7e6d04f74faso557169a12.1;
        Thu, 14 Nov 2024 07:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731597763; x=1732202563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XGIPuPoEk6hMreIa3JbZtLWr442phbAIM4UylmG5XxU=;
        b=HFtixhuAbHajTBZMhfARXEkfNuhopSoUXBUODCSizHfnk9kSuh0Vhhp9vHkjW1dHIE
         ZvNql1mW5wlZvwImCsNjg5G6DJh6lf2j+LQbOvllLWnVOfJb/ZltdfneKcmc7MeRYk/Q
         AQpv8YirgtgZwNl489AHfcqCfMMKTCCARLyrwg4jvmsgzLk2IpiHsijJIPsApitw7g7g
         ea9iM7dSWQoiVlxrX9LA4YkpC1QSMgeYZiN6LMbAnmKHM30JpfR3ZDVdUwMlwMRCVFae
         NHtZUHA/+pZQXoMykzxN24FIls0jO2tvjcBpi1sOEl2BNkN0Ca+nZix+IR6vWekRBXX/
         MaFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731597763; x=1732202563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XGIPuPoEk6hMreIa3JbZtLWr442phbAIM4UylmG5XxU=;
        b=nzCse3X2s3TpPGSxH6dNwv6cxXZPfvkzbCiy3gxsbu8acDtRJyqdRQSuAcC4QFtVDB
         oz1YJuByVEJ9M1Xjwg02VJ4LxfgZqLMPt+t4k+BogEd1P+8BE6kyygOePIpzLGaXZOLh
         qIVg2V3+mTXFsGJx+zdDhZNzMiDtXjv3XvhFTH5f4BlIATY3yupb74ZgxNc1tJSpTgTt
         IyHy9s5zy0/1prsDQbJsVP1J6MU69ew8RxbOEHAFPHh8JZVOm7bmC/8EKCwjfplpmTWo
         kcKhv8aMfZkXz60XjExMY3pdcJPISF2EiRN7FSxb7JHGIngalblKyzttfZHB+cwWmVtL
         UEcA==
X-Forwarded-Encrypted: i=1; AJvYcCUEJAt2vMpL4LkpWjtrWKDTywRD0sftna3rMLg77rpa8G2wRZqHu4icPbGLl03LiYs6+glQ8ipT@vger.kernel.org, AJvYcCWUMdMJb2rolSZVb2jocKzXaRXOZCLfXdAEIQpN8eNbcWxLLMVkz7qyFhm+N0DxY9jMVjhDwpfnrhePXxE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8DU0GYXGvZVm10lgvV++7xlGtYNK3b7cgXOZovs1qTHM1S0cQ
	rnNZ+06wk2+lz8ehLZ7tKz7ULs2AagTN0i11sVr7VejiqilbxmQu
X-Google-Smtp-Source: AGHT+IHPkRjFeMuKVg8SS2sClSV7gG6wYztTGo+0AEi4Wtcb0qQ7iAkruQoBvVAc/5aG/rGBAJOKyA==
X-Received: by 2002:a17:90b:1d0a:b0:2e2:ad14:e467 with SMTP id 98e67ed59e1d1-2e9fe611ff6mr5420527a91.3.1731597763100;
        Thu, 14 Nov 2024 07:22:43 -0800 (PST)
Received: from mythos-cloud.. ([121.185.170.145])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7246a5ce6a7sm1375889b3a.37.2024.11.14.07.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 07:22:42 -0800 (PST)
From: Moon Yeounsu <yyyynoom@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Moon Yeounsu <yyyynoom@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4] net: dlink: add support for reporting stats via `ethtool -S`
Date: Fri, 15 Nov 2024 00:19:48 +0900
Message-ID: <20241114151949.233170-2-yyyynoom@gmail.com>
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
NIC statistics:
     tx_jumbo_frames: 0
     rx_jumbo_frames: 0
     tcp_checksum_errors: 0
     udp_checksum_errors: 0
     ip_checksum_errors: 0
     tx_multicast_bytes: 0
     rx_multicast_bytes: 1260
     rmon_collisions: 0
     rmon_crc_align_errors: 0
     rmon_tx_bytes: 0
     rmon_rx_bytes: 0
     rmon_tx_packets: 0
     rmon_rx_packets: 0

$ ethtool -S enp36s0 --all-groups
> Standard stats for enp36s0:
eth-mac-FramesTransmittedOK: 1
eth-mac-SingleCollisionFrames: 0
eth-mac-MultipleCollisionFrames: 0
eth-mac-FramesReceivedOK: 93
eth-mac-FrameCheckSequenceErrors: 0
eth-mac-OctetsTransmittedOK: 60
eth-mac-FramesWithDeferredXmissions: 0
eth-mac-LateCollisions: 0
eth-mac-FramesAbortedDueToXSColls: 0
eth-mac-CarrierSenseErrors: 0
eth-mac-OctetsReceivedOK: 30708
eth-mac-FramesLostDueToIntMACRcvError: 7844
eth-mac-MulticastFramesXmittedOK: 0
eth-mac-BroadcastFramesXmittedOK: 0
eth-mac-FramesWithExcessiveDeferral: 0
eth-mac-MulticastFramesReceivedOK: 21
eth-mac-BroadcastFramesReceivedOK: 72
eth-mac-InRangeLengthErrors: 9324
eth-mac-FrameTooLongErrors: 0
eth-ctrl-MACControlFramesTransmitted: 1
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
v2: https://lore.kernel.org/netdev/20241107151929.37147-5-yyyynoom@gmail.com/
- Report standard statistics by specific `ethtool_ops`.
- A more detailed commit message about the changes.
v3: https://lore.kernel.org/netdev/20241112100328.134730-1-yyyynoom@gmail.com/
- Add missing maintainer email.
- Use `ethtool_puts()`.
- Remove multiple empty lines.
- Restrict the use of hard-to-follow macros.
v4:
- Fix incorrect maintainer email.
- Fix the issue where stats are not updating.
---
 drivers/net/ethernet/dlink/dl2k.c | 626 +++++++++++++++++++++++++-----
 drivers/net/ethernet/dlink/dl2k.h |  85 ++++
 2 files changed, 611 insertions(+), 100 deletions(-)

diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index d0ea92607870..c209e2574e83 100644
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
+#define GET_STATS(STATS, SIZE)						\
+	for (int i = 0; i < (SIZE); i++) {				\
+		if (STATS[i].size == sizeof(u32))			\
+			READ_STAT(STATS, np, i) += dr32(STATS[i].regs);	\
+		else							\
+			READ_STAT(STATS, np, i) += dr16(STATS[i].regs);	\
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
 
@@ -1328,11 +1675,92 @@ static u32 rio_get_link(struct net_device *dev)
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
+static void
+get_ethtool_rmon_stats(struct net_device *dev,
+		       struct ethtool_rmon_stats *base,
+		       const struct ethtool_rmon_hist_range **ranges)
+{
+	struct netdev_private *np = netdev_priv(dev);
+
+	get_stats(dev);
+
+	for (int i = 0; i < RMON_STATS_SIZE; i++)
+		READ_DATA(rmon_stats, base, i) = READ_STAT(rmon_stats, np, i);
+
+	*ranges = dlink_rmon_ranges;
+}
+
+static void get_ethtool_ctrl_stats(struct net_device *dev,
+				   struct ethtool_eth_ctrl_stats *base)
+{
+	struct netdev_private *np = netdev_priv(dev);
+
+	get_stats(dev);
+
+	if (base->src != ETHTOOL_MAC_STATS_SRC_AGGREGATE)
+		return;
+
+	for (int i = 0; i < CTRL_STATS_SIZE; i++)
+		READ_DATA(ctrl_stats, base, i) = READ_STAT(ctrl_stats, np, i);
+}
+
+static void get_ethtool_mac_stats(struct net_device *dev,
+				  struct ethtool_eth_mac_stats *base)
+{
+	struct netdev_private *np = netdev_priv(dev);
+
+	get_stats(dev);
+
+	if (base->src != ETHTOOL_MAC_STATS_SRC_AGGREGATE)
+		return;
+
+	for (int i = 0; i < MAC_STATS_SIZE; i++)
+		READ_DATA(mac_stats, base, i) = READ_STAT(mac_stats, np, i);
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
@@ -1798,9 +2226,7 @@ rio_remove1 (struct pci_dev *pdev)
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


