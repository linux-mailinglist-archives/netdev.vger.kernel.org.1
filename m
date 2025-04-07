Return-Path: <netdev+bounces-179655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF88EA7E025
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 15:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1585E18978C0
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 13:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9271B4140;
	Mon,  7 Apr 2025 13:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XI6b/QZM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24FF18DB03;
	Mon,  7 Apr 2025 13:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744033786; cv=none; b=K1NnfS+uQb5eZAu3F3u4xy9XZJTnaA5SbIN9z4COM70qVo2ueGchebMtnVdymSqJ9pZyAppU8bYKC/teDMJkpVnU/gVcB/wVt9pHY3zCYGBGinzZpchmd1snp2gPyW+mf+RmJSN+DErUKMDBdFimuV+wDdICzEr4qKkwOua8pwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744033786; c=relaxed/simple;
	bh=IVb6Gelsndsymg9Tq9JV2+vs32zVkKqGSvOxYsFtteM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hSIAdjpeR+fgXybF/rbrxUZJEgOwIMXryT5756siiKqZcKnv7FdRy6tePHsOYw1q5FkAKBHRl6YyOwJQ23KwInHOVcWk61ywwX06m5UIkIdvaRMgYS3lMCRIAMqYz0KWYTpIV0WVRmIKpV9z1hlxGy64tFCSRz3tvsD8ceer3tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XI6b/QZM; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-30332dfc820so4515161a91.2;
        Mon, 07 Apr 2025 06:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744033783; x=1744638583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bzFFp7usuyAeG1RiPuV0x/r1sN3EJS6m/traSmKjUSQ=;
        b=XI6b/QZM/x6GlbM3rn+uS9gFTu7V3cDm3sOBbaqLwrNR0R1ktkfaMs/oiKdAqOtll7
         fiKFSlPjUE5yRE2c98woTHUAuCacsd5IXtJUftV/BsvmEEZJf1dN7tsoAhS8VqE3ekiw
         0UIXIddlTH966YbEsOyNZZwqQRpgdKacvQ0ZnY48AbhP9ENoRxFRJStz+kjshIxQ9DF2
         rEJScZpflHee7Lfz16uZ+N8nyQFqOZ45375p7DZl9jfz9izUJVi6qQewQi6xBAw8lavu
         KBYUUtdoqUKHBbJ9Pkuqc+MCqgP8ncU8nx5HC7v/cwggUPyBsLH8/9btnSacmMcZmdmH
         x5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744033783; x=1744638583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bzFFp7usuyAeG1RiPuV0x/r1sN3EJS6m/traSmKjUSQ=;
        b=czB43FDnDfNdGCSfrBjJwyZID/y8GSKxQE0Axl4egDC3DAIixcrm7Y2ys9BLQkHMM6
         eeDp3agi9mAZWbcQfkIvBWXnZuVlBBpcwC8lEGZAUr99nb9QRvrG9Fr2FFpTmZB9G4fE
         WmHiBvB8Uxz8Lph2jYjGvFRhl0FxB+uetbHGwK0bWhW6q2v1fDjQPfZOsiFOuxBgp1GS
         gNANMRAgrGvpwehD5IdAWFESJZ+OsvWBb5apKVxTHCoYvCDROItcOc5eohXmUFLdhoW2
         kHkolf2PqzurK3Ze4+DIuyMZzYhOmi7cvDhR1hBRlbtYQhWXmMAilxezJmRmAr0iR7tZ
         nVhA==
X-Forwarded-Encrypted: i=1; AJvYcCVNBlfsHZuS3/nJCXDLbEwk86lf6d1Tp5LdaL9zWvYmFj0fNdNENNWmpNqCEZXEz5pSQrXrT1EZc10TOek=@vger.kernel.org, AJvYcCW+BHXEjGDNXCAyj86QUJK8jLP4CPKWWkjy66dw33dkFvYttBCCumnWWjv6zt4K7OOFKGDPk7eC@vger.kernel.org
X-Gm-Message-State: AOJu0YxdRAabY+k1YYjToue1lKNwR5btOQWRI/OMDSODW1VRjglWg+Bk
	u9UTHvDGWrmxhOZOHl5DIPEC6XUzTfWkN+GITo8tjFQPxSdlFipa
X-Gm-Gg: ASbGncv0TOR3M7p+c5un7kB1kfsLx/VSyv8zBmjAus2LQ4DEmk33p9lHBTqy/q2Wxl/
	KJ6rUT8FFXrqcJnGZ78tHINbD5arFWYKJaExJTLjHc5a/z196cXzsGKhZBi2dvuaD9Qi3HTgd7J
	4d2ftvH+iOjGlXPSOqsUlYYaBaDzMVsopWhDLb8LhVzEdyy5O/0QZOYQkh789leh8F0C7z13exQ
	GAg+mVWR3qC01RLXszFyx+4NFEr36enF5sGRRmR02H2Ye7RQMIRU3xZFFimIZXtpKLPBatR+JZx
	vCWkZQMmp5YRe57gWObrV42y83fzLnM7rAGbec0FUbFSWg==
X-Google-Smtp-Source: AGHT+IE5J9L5nDdot+ZyVFyB/oYName0OA49CNMFjKn+TovrzoansY1xFLJtCSNtUCZ7l5gNxiVVtA==
X-Received: by 2002:a17:90b:2f50:b0:2fe:a79e:f56f with SMTP id 98e67ed59e1d1-306af732e5bmr12556205a91.13.1744033782584;
        Mon, 07 Apr 2025 06:49:42 -0700 (PDT)
Received: from mythos-cloud.. ([125.138.201.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-305983b9d08sm8890152a91.35.2025.04.07.06.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 06:49:42 -0700 (PDT)
From: Moon Yeounsu <yyyynoom@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Moon Yeounsu <yyyynoom@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v6] net: dlink: add support for reporting stats via `ethtool -S` and `ip -s -s link show`
Date: Mon,  7 Apr 2025 22:49:27 +0900
Message-ID: <20250407134930.124307-1-yyyynoom@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch consolidates previously unused statistics and
adds support reporting them through `ethtool -S` and `ip -s -s link show`

Before applying the patch:
$ ethtool -S enp4s0
> no stats available

After applying the patch:
$ ethtool -S enp4s0
> NIC statistics:
     tx_jumbo_frames: 0
     rx_jumbo_frames: 0
     tcp_checksum_errors: 0
     udp_checksum_errors: 0
     ip_checksum_errors: 0
     tx_multicast_bytes: 1262
     rx_multicast_bytes: 540
     rmon_collisions: 0
     rmon_crc_align_errors: 0
     rmon_tx_bytes: 0
     rmon_rx_bytes: 0
     rmon_tx_packets: 0
     rmon_rx_packets: 0

$ ethtool -S enp4s0 --all-groups
> Standard stats for enp4s0:
eth-mac-FramesTransmittedOK: 7099
eth-mac-SingleCollisionFrames: 0
eth-mac-MultipleCollisionFrames: 0
eth-mac-FramesReceivedOK: 275
eth-mac-FrameCheckSequenceErrors: 0
eth-mac-OctetsTransmittedOK: 1216531
eth-mac-FramesWithDeferredXmissions: 0
eth-mac-LateCollisions: 0
eth-mac-FramesAbortedDueToXSColls: 0
eth-mac-CarrierSenseErrors: 0
eth-mac-OctetsReceivedOK: 41183
eth-mac-FramesLostDueToIntMACRcvError: 0
eth-mac-MulticastFramesXmittedOK: 17
eth-mac-BroadcastFramesXmittedOK: 10
eth-mac-FramesWithExcessiveDeferral: 0
eth-mac-MulticastFramesReceivedOK: 9
eth-mac-BroadcastFramesReceivedOK: 77
eth-mac-InRangeLengthErrors: 1052
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

$ ip -s -s link show
> ...
2: enp4s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 ...
    link/ether 00:0f:3d:cd:e6:a2 brd ff:ff:ff:ff:ff:ff
    RX:  bytes packets errors dropped  missed   mcast
         41952     282      0       6       0      28
    RX errors:  length    crc   frame    fifo overrun
                     0      0       0       0       0
    TX:  bytes packets errors dropped carrier collsns
       1447871    8096      0       0       0       0
    TX errors: aborted   fifo  window heartbt transns
                     0      0       0       0       2
...

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

`spin_[un]lock_irq()` is used to synchronize the critical section of
the `get_stats()` function, which can also be called from the top-half.
(`rio_interrupt()` -> `rio_error()` -> `get_stats()`)

Tested-on: D-Link DGE-550T Rev-A3
Signed-off-by: Moon Yeounsu <yyyynoom@gmail.com>
---
 drivers/net/ethernet/dlink/dl2k.c | 708 +++++++++++++++++++++++++-----
 drivers/net/ethernet/dlink/dl2k.h |  85 ++++
 2 files changed, 691 insertions(+), 102 deletions(-)
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
v4: https://lore.kernel.org/netdev/20241114151949.233170-2-yyyynoom@gmail.com/
- Fix incorrect maintainer email.
- Fix the issue where stats are not updating.
v5: https://lore.kernel.org/netdev/20241209092828.56082-2-yyyynoom@gmail.com/
- Remove all the macros that make code confusing.
- Restore code that updates basic stats(`dev->stats`).
- Add code that updates other `dev->stats` that can be updated.
- Include comment for `spinlock_t`
- Fix bug where duplicated stats declaration are not founded in v4 patch.
v6:
- `get_stats()` does not nest `spin_lock` before or during being called,
so `spin_[un]lock_irqsave()` has been replaced with `spin_[un]lock_irq()`.
- Code and variable declarations are now seperated.
- Update commit message to mention `get_stats()` can be called from top-half.

diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index d0ea92607870..68e6a408be05 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -99,6 +99,437 @@ static const struct net_device_ops netdev_ops = {
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
+		.string = "tx_mac_control_frames",
+		.data_offset = offsetof(struct ethtool_eth_ctrl_stats,
+					MACControlFramesTransmitted),
+		.stat_offset = offsetof(struct netdev_private,
+					tx_mac_control_frames),
+		.size = sizeof(u16),
+		.regs = MacControlFramesXmtd
+	},
+	{
+		.string = "rx_mac_control_frames",
+		.data_offset = offsetof(struct ethtool_eth_ctrl_stats,
+					MACControlFramesReceived),
+		.stat_offset = offsetof(struct netdev_private,
+					rx_mac_control_frames),
+		.size = sizeof(u16),
+		.regs = MacControlFramesRcvd
+	}
+}, mac_stats[] = {
+	{
+		.string = "tx_packets",
+		.data_offset = offsetof(struct ethtool_eth_mac_stats,
+					FramesTransmittedOK),
+		.stat_offset = offsetof(struct netdev_private,
+					tx_packets),
+		.size = sizeof(u32),
+		.regs = FramesXmtOk,
+	},
+	{
+		.string = "rx_packets",
+		.data_offset = offsetof(struct ethtool_eth_mac_stats,
+					FramesReceivedOK),
+		.stat_offset = offsetof(struct netdev_private,
+					rx_packets),
+		.size = sizeof(u32),
+		.regs = FramesRcvOk,
+	},
+	{
+		.string = "tx_bytes",
+		.data_offset = offsetof(struct ethtool_eth_mac_stats,
+					OctetsTransmittedOK),
+		.stat_offset = offsetof(struct netdev_private,
+					tx_bytes),
+		.size = sizeof(u32),
+		.regs = OctetXmtOk,
+	},
+	{
+		.string = "rx_bytes",
+		.data_offset = offsetof(struct ethtool_eth_mac_stats,
+					OctetsReceivedOK),
+		.stat_offset = offsetof(struct netdev_private,
+					rx_bytes),
+		.size = sizeof(u32),
+		.regs = OctetRcvOk,
+	},
+	{
+		.string = "single_collisions",
+		.data_offset = offsetof(struct ethtool_eth_mac_stats,
+					SingleCollisionFrames),
+		.stat_offset = offsetof(struct netdev_private,
+					single_collisions),
+		.size = sizeof(u32),
+		.regs = SingleColFrames,
+	},
+	{
+		.string = "multi_collisions",
+		.data_offset = offsetof(struct ethtool_eth_mac_stats,
+					MultipleCollisionFrames),
+		.stat_offset = offsetof(struct netdev_private,
+					multi_collisions),
+		.size = sizeof(u32),
+		.regs = MultiColFrames,
+	},
+	{
+		.string = "late_collisions",
+		.data_offset = offsetof(struct ethtool_eth_mac_stats,
+					LateCollisions),
+		.stat_offset = offsetof(struct netdev_private,
+					late_collisions),
+		.size = sizeof(u32),
+		.regs = LateCollisions,
+	},
+	{
+		.string = "rx_frames_too_long_errors",
+		.data_offset = offsetof(struct ethtool_eth_mac_stats,
+					FrameTooLongErrors),
+		.stat_offset = offsetof(struct netdev_private,
+					rx_frames_too_long_errors),
+		.size = sizeof(u16),
+		.regs = FrameTooLongErrors,
+	},
+	{
+		.string = "rx_in_range_length_errors",
+		.data_offset = offsetof(struct ethtool_eth_mac_stats,
+					InRangeLengthErrors),
+		.stat_offset = offsetof(struct netdev_private,
+					rx_in_range_length_errors),
+		.size = sizeof(u16),
+		.regs = InRangeLengthErrors,
+	},
+	{
+		.string = "rx_frames_check_seq_errors",
+		.data_offset = offsetof(struct ethtool_eth_mac_stats,
+					FrameCheckSequenceErrors),
+		.stat_offset = offsetof(struct netdev_private,
+					rx_frames_check_seq_errors),
+		.size = sizeof(u16),
+		.regs = FramesCheckSeqErrors,
+	},
+	{
+		.string = "rx_frames_lost_errors",
+		.data_offset = offsetof(struct ethtool_eth_mac_stats,
+					FramesLostDueToIntMACRcvError),
+		.stat_offset = offsetof(struct netdev_private,
+					rx_frames_lost_errors),
+		.size = sizeof(u16),
+		.regs = FramesLostRxErrors,
+	},
+	{
+		.string = "tx_frames_abort",
+		.data_offset = offsetof(struct ethtool_eth_mac_stats,
+					FramesAbortedDueToXSColls),
+		.stat_offset = offsetof(struct netdev_private,
+					tx_frames_abort),
+		.size = sizeof(u16),
+		.regs = FramesAbortXSColls,
+	},
+	{
+		.string = "tx_carrier_sense_errors",
+		.data_offset = offsetof(struct ethtool_eth_mac_stats,
+					CarrierSenseErrors),
+		.stat_offset = offsetof(struct netdev_private,
+					tx_carrier_sense_errors),
+		.size = sizeof(u16),
+		.regs = CarrierSenseErrors,
+	},
+	{
+		.string = "tx_multicast_frames",
+		.data_offset = offsetof(struct ethtool_eth_mac_stats,
+					MulticastFramesXmittedOK),
+		.stat_offset = offsetof(struct netdev_private,
+					tx_multicast_frames),
+		.size = sizeof(u32),
+		.regs = McstFramesXmtdOk,
+	},
+	{
+		.string = "rx_multicast_frames",
+		.data_offset = offsetof(struct ethtool_eth_mac_stats,
+					MulticastFramesReceivedOK),
+		.stat_offset = offsetof(struct netdev_private,
+					rx_multicast_frames),
+		.size = sizeof(u32),
+		.regs = McstFramesRcvdOk,
+	},
+	{
+		.string = "tx_broadcast_frames",
+		.data_offset = offsetof(struct ethtool_eth_mac_stats,
+					BroadcastFramesXmittedOK),
+		.stat_offset = offsetof(struct netdev_private,
+					tx_broadcast_frames),
+		.size = sizeof(u16),
+		.regs = BcstFramesXmtdOk,
+	},
+	{
+		.string = "rx_broadcast_frames",
+		.data_offset = offsetof(struct ethtool_eth_mac_stats,
+					BroadcastFramesReceivedOK),
+		.stat_offset = offsetof(struct netdev_private,
+					rx_broadcast_frames),
+		.size = sizeof(u16),
+		.regs = BcstFramesRcvdOk,
+	},
+	{
+		.string = "tx_frames_deferred",
+		.data_offset = offsetof(struct ethtool_eth_mac_stats,
+					FramesWithDeferredXmissions),
+		.stat_offset = offsetof(struct netdev_private,
+					tx_frames_deferred),
+		.size = sizeof(u32),
+		.regs = FramesWDeferredXmt,
+	},
+	{
+		.string = "tx_frames_excessive_deferral",
+		.data_offset = offsetof(struct ethtool_eth_mac_stats,
+					FramesWithExcessiveDeferral),
+		.stat_offset = offsetof(struct netdev_private,
+					tx_frames_excessive_deferral),
+		.size = sizeof(u16),
+		.regs = FramesWEXDeferal,
+	},
+}, rmon_stats[] = {
+	{
+		.string = "rmon_under_size_packets",
+		.data_offset = offsetof(struct ethtool_rmon_stats,
+					undersize_pkts),
+		.stat_offset = offsetof(struct netdev_private,
+					rmon_under_size_packets),
+		.size = sizeof(u32),
+		.regs = EtherStatsUndersizePkts
+	},
+	{
+		.string = "rmon_fragments",
+		.data_offset = offsetof(struct ethtool_rmon_stats,
+					fragments),
+		.stat_offset = offsetof(struct netdev_private,
+					rmon_fragments),
+		.size = sizeof(u32),
+		.regs = EtherStatsFragments
+	},
+	{
+		.string = "rmon_jabbers",
+		.data_offset = offsetof(struct ethtool_rmon_stats,
+					jabbers),
+		.stat_offset = offsetof(struct netdev_private,
+					rmon_jabbers),
+		.size = sizeof(u32),
+		.regs = EtherStatsJabbers
+	},
+	{
+		.string = "rmon_tx_byte_64",
+		.data_offset = offsetof(struct ethtool_rmon_stats,
+					hist_tx[0]),
+		.stat_offset = offsetof(struct netdev_private,
+					rmon_tx_byte_64),
+		.size = sizeof(u32),
+		.regs = EtherStatsPkts64OctetTransmit
+	},
+	{
+		.string = "rmon_rx_byte_64",
+		.data_offset = offsetof(struct ethtool_rmon_stats,
+					hist[0]),
+		.stat_offset = offsetof(struct netdev_private,
+					rmon_rx_byte_64),
+		.size = sizeof(u32),
+		.regs = EtherStats64Octets
+	},
+	{
+		.string = "rmon_tx_byte_65to127",
+		.data_offset = offsetof(struct ethtool_rmon_stats,
+					hist_tx[1]),
+		.stat_offset = offsetof(struct netdev_private,
+					rmon_tx_byte_65to127),
+		.size = sizeof(u32),
+		.regs = EtherStats65to127OctetsTransmit
+	},
+	{
+		.string = "rmon_rx_byte_65to127",
+		.data_offset = offsetof(struct ethtool_rmon_stats,
+					hist[1]),
+		.stat_offset = offsetof(struct netdev_private,
+					rmon_rx_byte_65to127),
+		.size = sizeof(u32),
+		.regs = EtherStatsPkts65to127Octets
+	},
+	{
+		.string = "rmon_tx_byte_128to255",
+		.data_offset = offsetof(struct ethtool_rmon_stats,
+					hist_tx[2]),
+		.stat_offset = offsetof(struct netdev_private,
+					rmon_tx_byte_128to255),
+		.size = sizeof(u32),
+		.regs = EtherStatsPkts128to255OctetsTransmit
+	},
+	{
+		.string = "rmon_rx_byte_128to255",
+		.data_offset = offsetof(struct ethtool_rmon_stats,
+					hist[2]),
+		.stat_offset = offsetof(struct netdev_private,
+					rmon_rx_byte_128to255),
+		.size = sizeof(u32),
+		.regs = EtherStatsPkts128to255Octets
+	},
+	{
+		.string = "rmon_tx_byte_256to511",
+		.data_offset = offsetof(struct ethtool_rmon_stats,
+					hist_tx[3]),
+		.stat_offset = offsetof(struct netdev_private,
+					rmon_tx_byte_256to511),
+		.size = sizeof(u32),
+		.regs = EtherStatsPkts256to511OctetsTransmit
+	},
+	{
+		.string = "rmon_rx_byte_256to511",
+		.data_offset = offsetof(struct ethtool_rmon_stats,
+					hist[3]),
+		.stat_offset = offsetof(struct netdev_private,
+					rmon_rx_byte_256to511),
+		.size = sizeof(u32),
+		.regs = EtherStatsPkts256to511Octets
+	},
+	{
+		.string = "rmon_tx_byte_512to1023",
+		.data_offset = offsetof(struct ethtool_rmon_stats,
+					hist_tx[4]),
+		.stat_offset = offsetof(struct netdev_private,
+					rmon_tx_byte_512to1023),
+		.size = sizeof(u32),
+		.regs = EtherStatsPkts512to1023OctetsTransmit
+	},
+	{
+		.string = "rmon_rx_byte_512to1023",
+		.data_offset = offsetof(struct ethtool_rmon_stats,
+					hist[4]),
+		.stat_offset = offsetof(struct netdev_private,
+					rmon_rx_byte_512to1203),
+		.size = sizeof(u32),
+		.regs = EtherStatsPkts512to1023Octets
+	},
+	{
+		.string = "rmon_tx_byte_1024to1518",
+		.data_offset = offsetof(struct ethtool_rmon_stats,
+					hist_tx[5]),
+		.stat_offset = offsetof(struct netdev_private,
+					rmon_tx_byte_1024to1518),
+		.size = sizeof(u32),
+		.regs = EtherStatsPkts1024to1518OctetsTransmit
+	},
+	{
+		.string = "rmon_rx_byte_1024to1518",
+		.data_offset = offsetof(struct ethtool_rmon_stats,
+					hist[5]),
+		.stat_offset = offsetof(struct netdev_private,
+					rmon_rx_byte_1024to1518),
+		.size = sizeof(u32),
+		.regs = EtherStatsPkts1024to1518Octets
+	}
+};
+
 static int
 rio_probe1 (struct pci_dev *pdev, const struct pci_device_id *ent)
 {
@@ -137,17 +568,16 @@ rio_probe1 (struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_out_dev;
 	np->eeprom_addr = ioaddr;
 
-#ifdef MEM_MAPPING
 	/* MM registers range. */
 	ioaddr = pci_iomap(pdev, 1, 0);
 	if (!ioaddr)
 		goto err_out_iounmap;
-#endif
 	np->ioaddr = ioaddr;
 	np->chip_id = chip_idx;
 	np->pdev = pdev;
 	spin_lock_init (&np->tx_lock);
 	spin_lock_init (&np->rx_lock);
+	spin_lock_init(&np->stats_lock);
 
 	/* Parse manual configuration */
 	np->an_enable = 1;
@@ -287,9 +717,7 @@ rio_probe1 (struct pci_dev *pdev, const struct pci_device_id *ent)
 	dma_free_coherent(&pdev->dev, TX_TOTAL_SIZE, np->tx_ring,
 			  np->tx_ring_dma);
 err_out_iounmap:
-#ifdef MEM_MAPPING
 	pci_iounmap(pdev, np->ioaddr);
-#endif
 	pci_iounmap(pdev, np->eeprom_addr);
 err_out_dev:
 	free_netdev (dev);
@@ -1064,65 +1492,99 @@ rio_error (struct net_device *dev, int int_status)
 	}
 }
 
+static void init_stats(struct netdev_private *np,
+		       const struct dlink_stats *stats, size_t size)
+{
+	void __iomem *ioaddr = np->ioaddr;
+	u64 *stat;
+
+	for (size_t i = 0; i < size; i++) {
+		stat = (void *)np + stats[i].stat_offset;
+
+		if (stats[i].size == sizeof(u32))
+			(void)dr32(stats[i].regs);
+		else
+			(void)dr16(stats[i].regs);
+
+		*stat = 0;
+	}
+}
+
+static void update_stats(struct netdev_private *np,
+			 const struct dlink_stats *stats, size_t size)
+{
+	void __iomem *ioaddr = np->ioaddr;
+	u64 *stat;
+
+	for (size_t i = 0; i < size; i++) {
+		stat = (void *)np + stats[i].stat_offset;
+
+		if (stats[i].size == sizeof(u32))
+			*stat += dr32(stats[i].regs);
+		else
+			*stat += dr16(stats[i].regs);
+	}
+}
+
+static void write_stats(struct netdev_private *np, const void *base,
+			const struct dlink_stats *stats, size_t size)
+{
+	u64 *stat, *data;
+
+	for (size_t i = 0; i < size; i++) {
+		stat = (void *)np + stats[i].stat_offset;
+		data = (void *)base + stats[i].data_offset;
+
+		*data = *stat;
+	}
+}
+
 static struct net_device_stats *
 get_stats (struct net_device *dev)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem *ioaddr = np->ioaddr;
-#ifdef MEM_MAPPING
-	int i;
-#endif
-	unsigned int stat_reg;
+
+	u64 collisions;
+	u64 tx_frames_abort;
+	u64 tx_carrier_errors;
+
+	spin_lock_irq(&np->stats_lock);
 
 	/* All statistics registers need to be acknowledged,
 	   else statistic overflow could cause problems */
+	collisions = np->single_collisions + np->multi_collisions;
+	tx_frames_abort = np->tx_frames_abort;
+	tx_carrier_errors = np->tx_carrier_sense_errors;
+
+	update_stats(np, stats, ARRAY_SIZE(stats));
+	update_stats(np, rmon_stats, ARRAY_SIZE(rmon_stats));
+	update_stats(np, ctrl_stats, ARRAY_SIZE(ctrl_stats));
+	update_stats(np, mac_stats, ARRAY_SIZE(mac_stats));
+
+	collisions = np->single_collisions + np->multi_collisions - collisions;
+	tx_frames_abort = np->tx_frames_abort - tx_frames_abort;
+	tx_carrier_errors = np->tx_carrier_sense_errors - tx_carrier_errors;
+
+	dev->stats.rx_packets = np->rx_packets;
+	dev->stats.tx_packets = np->tx_packets;
+
+	dev->stats.rx_bytes = np->rx_bytes;
+	dev->stats.tx_bytes = np->tx_bytes;
+
+	dev->stats.collisions += collisions;
+
+	dev->stats.multicast = np->tx_multicast_frames +
+			       np->rx_multicast_frames;
+
+	dev->stats.rx_over_errors = np->rx_frames_too_long_errors;
+	dev->stats.tx_aborted_errors = np->tx_frames_abort;
+	dev->stats.tx_carrier_errors = np->tx_carrier_sense_errors;
+	dev->stats.tx_window_errors = np->late_collisions;
+
+	dev->stats.tx_errors += tx_frames_abort + tx_carrier_errors;
+
+	spin_unlock_irq(&np->stats_lock);
 
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
 	return &dev->stats;
 }
 
@@ -1130,54 +1592,17 @@ static int
 clear_stats (struct net_device *dev)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem *ioaddr = np->ioaddr;
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
+	init_stats(np, stats, ARRAY_SIZE(stats));
+	init_stats(np, rmon_stats, ARRAY_SIZE(rmon_stats));
+	init_stats(np, ctrl_stats, ARRAY_SIZE(ctrl_stats));
+	init_stats(np, mac_stats, ARRAY_SIZE(mac_stats));
+
+	memset(&dev->stats, 0x00, sizeof(dev->stats));
+
 	return 0;
 }
 
@@ -1328,11 +1753,92 @@ static u32 rio_get_link(struct net_device *dev)
 	return np->link_status;
 }
 
+static void get_ethtool_stats(struct net_device *dev,
+			      struct ethtool_stats __always_unused *__,
+			      u64 *data)
+{
+	struct netdev_private *np = netdev_priv(dev);
+	u64 *stat;
+
+	get_stats(dev);
+
+	for (size_t i = 0, j = 0; i < ARRAY_SIZE(stats); i++) {
+		stat = (void *)np + stats[i].stat_offset;
+		data[j++] = *stat;
+	}
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
+	write_stats(np, base, rmon_stats, ARRAY_SIZE(rmon_stats));
+
+	*ranges = dlink_rmon_ranges;
+}
+
+static void get_ethtool_ctrl_stats(struct net_device *dev,
+				   struct ethtool_eth_ctrl_stats *base)
+{
+	struct netdev_private *np = netdev_priv(dev);
+
+	if (base->src != ETHTOOL_MAC_STATS_SRC_AGGREGATE)
+		return;
+
+	get_stats(dev);
+
+	write_stats(np, base, ctrl_stats, ARRAY_SIZE(ctrl_stats));
+}
+
+static void get_ethtool_mac_stats(struct net_device *dev,
+				  struct ethtool_eth_mac_stats *base)
+{
+	struct netdev_private *np = netdev_priv(dev);
+
+	if (base->src != ETHTOOL_MAC_STATS_SRC_AGGREGATE)
+		return;
+
+	get_stats(dev);
+
+	write_stats(np, base, mac_stats, ARRAY_SIZE(mac_stats));
+}
+
+static void get_strings(struct net_device *dev, u32 stringset, u8 *data)
+{
+	switch (stringset) {
+	case ETH_SS_STATS:
+		for (size_t i = 0; i < ARRAY_SIZE(stats); i++)
+			ethtool_puts(&data, stats[i].string);
+		break;
+	}
+}
+
+static int get_sset_count(struct net_device *dev, int sset)
+{
+	switch (sset) {
+	case ETH_SS_STATS:
+		return ARRAY_SIZE(stats);
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
@@ -1798,9 +2304,7 @@ rio_remove1 (struct pci_dev *pdev)
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
index 195dc6cfd895..643c98c4e18a 100644
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
+	// To ensure synchronization when stats are updated.
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
+		u64 rmon_rx_byte_65to127;
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
+		u64 rmon_tx_byte_1024to1518;
+		u64 rmon_rx_byte_1024to1518;
+	};
+
 	unsigned int rx_buf_sz;		/* Based on MTU+slack. */
 	unsigned int speed;		/* Operating speed */
 	unsigned int vlan;		/* VLAN Id */
-- 
2.49.0


