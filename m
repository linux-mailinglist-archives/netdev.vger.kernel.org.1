Return-Path: <netdev+bounces-196237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DB8AD401D
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 19:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7611178FD9
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 17:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1454F244196;
	Tue, 10 Jun 2025 17:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLBxw9h/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B687724466F
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 17:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749575491; cv=none; b=medE0DQzRwhR7CvN+o85qeJswj0UJdzn6zzs1r5Pnwn47qw5zpKOMlGsqoETtqCArF6oXivG1nkrGQrDE9eGOA8O32PY1gCSP0cT3DRHFXXqoGjwo8S2//GoxNmCLuyIxw27dHGZwvBvV/Wnm6CowOWZT6SJIB2eb+ozKTHZs8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749575491; c=relaxed/simple;
	bh=foe7ZUa8tjW+R/jhL5TN5Wz6h95KUAw9vpzG2eOJzWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sCxjqSX7eMK8KAqvbZeHEYBcKK43dKyfIywQrMZjdH7aq2hPNgDbN78h9XLON/Me9fTqEupwaoyuCcTwkWKXyECIbuPpOYCPmwGUUQ+dEosA/+pV01R79lI5BMCovTh3dgw5MEaTmx3bU8S9D49Z0vzUx5VdTeOUZTysIXrfSzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZLBxw9h/; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a503d9ef59so4789260f8f.3
        for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 10:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749575487; x=1750180287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/Ysdhpa97+FV4WyYPZfqRjTBOkL6xXma/qoOB2yQqM=;
        b=ZLBxw9h/75OTGV5Bk3TMckUYOK1RMfiPtSPMVzfPw2IyH8F8W1E1VcZI9xlhOZOd2i
         5s7sHQndeydsgrskhDuLAz7YZ/isAO9S2ntMGHyeLnTftrV/+8rJ67psQ4ZqWLAcbfK9
         pORGM89WKmiJLIsJNjzo+WWp9gNfnRq/9tm2JrXVe3667QL8Ffmkz5QX3jN2ZrsFJTdp
         u2Xf6Gs3Mk1PXmp4upmVmys4v0JO8cfiOHKRqeDalLlAokOzCa7kAn9JhCz922q+PEO7
         SvD/kZMSRr1rNfFUhKWImoHgP8eV780YB4s5D+lybhBQw8Sn7zTy381ap4XF6RyZ6tIm
         gNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749575487; x=1750180287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5/Ysdhpa97+FV4WyYPZfqRjTBOkL6xXma/qoOB2yQqM=;
        b=eLnu9lnOXkFWe+sqOLAcFSgJAvzZOQpvmuCGJf+cBeMD3VrgCpF11K1tO0Pxgft1yn
         EpYHyGScFidvJVm1PjWtiK+BDw35nJ90T7r/0M69Cze/tSM58NUsF1TDyEQ/JnX6mB4E
         HqHf0H5cSQ27gVgU1ELdBBB/1V/8g2IfbMxncT8lLRfDwZivxdVX+zkJQVfMwVgtJWv1
         0mGMRsW+ZtNrKhPNpfBXrC3ZAziTj+VHUahufhU6Y6qnj43ZNOzi6AhMwir6vMrqCLSk
         SWCHWBV+istNwx4WUswzdnLeaR6jR8q3qT2f+6Yk/zqX0MJHUlNVjpFYur6cp8ADJx9a
         5Y8w==
X-Gm-Message-State: AOJu0Yx9FNj3526CcTo0oEfWs2kQ0I2avA7JB/w5ck1iw56r9QuMzQnu
	MZpMGMi/0ES1qH7QCIj2iSrwq1vKGtHwfvoU/hiaiSmR/vNrAyKmlBEQISj31jKh
X-Gm-Gg: ASbGnct3h1nvbV9tSMTNqhdW/CFvX9ptsO+4WM6TScoID//fLuOtK5jyIOkD+ex4ukx
	NIopsZehywZp7CCE7QpN6yev/QjUKcYJJswvFhQU1I9Nm5G+XHfPkccmAvx21S3dXDUkNba33xr
	NVAdKlZFgFhxDp6G1T0BIEJ7S6/gSvXQZkbmqTzyvzcm90mPh6zghSYy0mvWO9OaEUNH8M1RTI5
	VpgVGe/W+J981R8ygxWwzUmBjJdlwKEnoO5/4RNtUjIVmnkr3gxYVxu1SODkDSnkbxwq0m0SvNX
	fxOmhOQ/vPLTXZ2eI2frc3GV7DZDsg6WaO6Hf8XlzSgl7Q5Fds0HJCrPel0=
X-Google-Smtp-Source: AGHT+IEm6iiuWErUinsHlzv/odhKUIhIPuqaWhB8jZv+wPhRfNnFs+uFS50YE29uPokjdqdZvim23A==
X-Received: by 2002:a5d:64ca:0:b0:3a5:2848:2445 with SMTP id ffacd0b85a97d-3a531ab50f2mr15437996f8f.16.1749575486439;
        Tue, 10 Jun 2025 10:11:26 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:6::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-452730c7459sm145940955e9.34.2025.06.10.10.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 10:11:25 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	kuba@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	mohsin.bashr@gmail.com,
	horms@kernel.org,
	vadim.fedorenko@linux.dev,
	sanman.p211993@gmail.com,
	jacob.e.keller@intel.com,
	lee@trager.us,
	suhui@nfschina.com
Subject: [PATCH net-next 2/2] eth: fbnic: Expand coverage of mac stats
Date: Tue, 10 Jun 2025 10:11:09 -0700
Message-ID: <20250610171109.1481229-3-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250610171109.1481229-1-mohsin.bashr@gmail.com>
References: <20250610171109.1481229-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expand coverage of MAC stats via ethtool by adding rmon and eth-ctrl
stats.

ethtool -S eth0 --groups eth-ctrl
Standard stats for eth0:
eth-ctrl-MACControlFramesTransmitted: 0
eth-ctrl-MACControlFramesReceived: 0

ethtool -S eth0 --groups rmon
Standard stats for eth0:
rmon-etherStatsUndersizePkts: 0
rmon-etherStatsOversizePkts: 0
rmon-etherStatsFragments: 0
rmon-etherStatsJabbers: 0
rx-rmon-etherStatsPkts64Octets: 32807689
rx-rmon-etherStatsPkts65to127Octets: 567512968
rx-rmon-etherStatsPkts128to255Octets: 64730266
rx-rmon-etherStatsPkts256to511Octets: 20136039
rx-rmon-etherStatsPkts512to1023Octets: 28476870
rx-rmon-etherStatsPkts1024to1518Octets: 6958335
rx-rmon-etherStatsPkts1519to2047Octets: 164
rx-rmon-etherStatsPkts2048to4095Octets: 3844
rx-rmon-etherStatsPkts4096to8191Octets: 21814
rx-rmon-etherStatsPkts8192to9216Octets: 6540818
rx-rmon-etherStatsPkts9217to9742Octets: 4180897
tx-rmon-etherStatsPkts64Octets: 8786
tx-rmon-etherStatsPkts65to127Octets: 31475804
tx-rmon-etherStatsPkts128to255Octets: 3581331
tx-rmon-etherStatsPkts256to511Octets: 2483038
tx-rmon-etherStatsPkts512to1023Octets: 4500916
tx-rmon-etherStatsPkts1024to1518Octets: 38741270
tx-rmon-etherStatsPkts1519to2047Octets: 15521
tx-rmon-etherStatsPkts2048to4095Octets: 4109
tx-rmon-etherStatsPkts4096to8191Octets: 20817
tx-rmon-etherStatsPkts8192to9216Octets: 6904055
tx-rmon-etherStatsPkts9217to9742Octets: 6757746

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   | 112 ++++++++++++++++++
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |  66 +++++++++++
 .../net/ethernet/meta/fbnic/fbnic_hw_stats.h  |  19 +++
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c   |  72 +++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h   |   4 +
 5 files changed, 273 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
index 36393a17d92d..1d8ff0cbe607 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
@@ -446,6 +446,26 @@ enum {
 #define FBNIC_TMI_ILLEGAL_PTP_REQS	0x04409		/* 0x11024 */
 #define FBNIC_TMI_GOOD_PTP_TS		0x0440a		/* 0x11028 */
 #define FBNIC_TMI_BAD_PTP_TS		0x0440b		/* 0x1102c */
+#define FBNIC_TMI_STAT_TX_PACKET_1519_2047_BYTES_L \
+					0x04433		/* 0x110cc */
+#define FBNIC_TMI_STAT_TX_PACKET_1519_2047_BYTES_H \
+					0x04434		/* 0x110d0 */
+#define FBNIC_TMI_STAT_TX_PACKET_2048_4095_BYTES_L \
+					0x04435		/* 0x110d4 */
+#define FBNIC_TMI_STAT_TX_PACKET_2048_4095_BYTES_H \
+					0x04436		/* 0x110d8 */
+#define FBNIC_TMI_STAT_TX_PACKET_4096_8191_BYTES_L \
+					0x04437		/* 0x110dc */
+#define FBNIC_TMI_STAT_TX_PACKET_4096_8191_BYTES_H \
+					0x04438		/* 0x110e0 */
+#define FBNIC_TMI_STAT_TX_PACKET_8192_9216_BYTES_L \
+					0x04439		/* 0x110e4 */
+#define FBNIC_TMI_STAT_TX_PACKET_8192_9216_BYTES_H \
+					0x0443a		/* 0x110e8 */
+#define FBNIC_TMI_STAT_TX_PACKET_9217_MAX_BYTES_L \
+					0x0443b		/* 0x110ec */
+#define FBNIC_TMI_STAT_TX_PACKET_9217_MAX_BYTES_H \
+					0x0443c		/* 0x110f0 */
 #define FBNIC_CSR_END_TMI		0x0443f	/* CSR section delimiter */
 
 /* Precision Time Protocol Registers */
@@ -674,6 +694,26 @@ enum {
 #define FBNIC_RPC_CNTR_OVR_SIZE_ERR	0x084a6		/* 0x21298 */
 
 #define FBNIC_RPC_TCAM_MACDA_VALIDATE	0x0852d		/* 0x214b4 */
+#define FBNIC_RPC_STAT_RX_PACKET_1519_2047_BYTES_L \
+					0x0855f		/* 0x2157c */
+#define FBNIC_RPC_STAT_RX_PACKET_1519_2047_BYTES_H \
+					0x08560		/* 0x21580 */
+#define FBNIC_RPC_STAT_RX_PACKET_2048_4095_BYTES_L \
+					0x08561		/* 0x21584 */
+#define FBNIC_RPC_STAT_RX_PACKET_2048_4095_BYTES_H \
+					0x08562		/* 0x21588 */
+#define FBNIC_RPC_STAT_RX_PACKET_4096_8191_BYTES_L \
+					0x08563		/* 0x2158c */
+#define FBNIC_RPC_STAT_RX_PACKET_4096_8191_BYTES_H \
+					0x08564		/* 0x21590 */
+#define FBNIC_RPC_STAT_RX_PACKET_8192_9216_BYTES_L \
+					0x08565		/* 0x21594 */
+#define FBNIC_RPC_STAT_RX_PACKET_8192_9216_BYTES_H \
+					0x08566		/* 0x21598 */
+#define FBNIC_RPC_STAT_RX_PACKET_9217_MAX_BYTES_L \
+					0x08567		/* 0x2159c */
+#define FBNIC_RPC_STAT_RX_PACKET_9217_MAX_BYTES_H \
+					0x08568		/* 0x215a0 */
 #define FBNIC_CSR_END_RPC		0x0856b	/* CSR section delimiter */
 
 /* RPC RAM Registers */
@@ -796,6 +836,46 @@ enum {
 #define FBNIC_MAC_STAT_RX_MULTICAST_H	0x11a1d		/* 0x46874 */
 #define FBNIC_MAC_STAT_RX_BROADCAST_L	0x11a1e		/* 0x46878 */
 #define FBNIC_MAC_STAT_RX_BROADCAST_H	0x11a1f		/* 0x4687c */
+#define FBNIC_MAC_STAT_RX_UNDERSIZE_L	0x11a24		/* 0x46890 */
+#define FBNIC_MAC_STAT_RX_UNDERSIZE_H	0x11a25		/* 0x46894 */
+#define FBNIC_MAC_STAT_RX_PACKET_64_BYTES_L \
+					0x11a26		/* 0x46898 */
+#define FBNIC_MAC_STAT_RX_PACKET_64_BYTES_H \
+					0x11a27		/* 0x4689c */
+#define FBNIC_MAC_STAT_RX_PACKET_65_127_BYTES_L \
+					0x11a28		/* 0x468a0 */
+#define FBNIC_MAC_STAT_RX_PACKET_65_127_BYTES_H \
+					0x11a29		/* 0x468a4 */
+#define FBNIC_MAC_STAT_RX_PACKET_128_255_BYTES_L \
+					0x11a2a		/* 0x468a8 */
+#define FBNIC_MAC_STAT_RX_PACKET_128_255_BYTES_H \
+					0x11a2b		/* 0x468ac */
+#define FBNIC_MAC_STAT_RX_PACKET_256_511_BYTES_L \
+					0x11a2c		/* 0x468b0 */
+#define FBNIC_MAC_STAT_RX_PACKET_256_511_BYTES_H \
+					0x11a2d		/* 0x468b4 */
+#define FBNIC_MAC_STAT_RX_PACKET_512_1023_BYTES_L \
+					0x11a2e		/* 0x468b8 */
+#define FBNIC_MAC_STAT_RX_PACKET_512_1023_BYTES_H \
+					0x11a2f		/* 0x468bc */
+#define FBNIC_MAC_STAT_RX_PACKET_1024_1518_BYTES_L \
+					0x11a30		/* 0x468c0 */
+#define FBNIC_MAC_STAT_RX_PACKET_1024_1518_BYTES_H \
+					0x11a31		/* 0x468c4 */
+#define FBNIC_MAC_STAT_RX_PACKET_1519_MAX_BYTES_L \
+					0x11a32		/* 0x468c8 */
+#define FBNIC_MAC_STAT_RX_PACKET_1519_MAX_BYTES_H \
+					0x11a33		/* 0x468cc */
+#define FBNIC_MAC_STAT_RX_OVERSIZE_L	0x11a34		/* 0x468d0 */
+#define FBNIC_MAC_STAT_RX_OVERSSIZE_H	0x11a35		/* 0x468d4 */
+#define FBNIC_MAC_STAT_RX_JABBER_L	0x11a36		/* 0x468d8 */
+#define FBNIC_MAC_STAT_RX_JABBER_H	0x11a37		/* 0x468dc */
+#define FBNIC_MAC_STAT_RX_FRAGMENT_L	0x11a38		/* 0x468e0 */
+#define FBNIC_MAC_STAT_RX_FRAGMENT_H	0x11a39		/* 0x468e4 */
+#define FBNIC_MAC_STAT_RX_CONTROL_FRAMES_L \
+					0x11a3c		/* 0x468f0 */
+#define FBNIC_MAC_STAT_RX_CONTROL_FRAMES_H \
+					0x11a3d		/* 0x468f4 */
 #define FBNIC_MAC_STAT_TX_BYTE_COUNT_L	0x11a3e		/* 0x468f8 */
 #define FBNIC_MAC_STAT_TX_BYTE_COUNT_H	0x11a3f		/* 0x468fc */
 #define FBNIC_MAC_STAT_TX_TRANSMITTED_OK_L \
@@ -810,6 +890,38 @@ enum {
 #define FBNIC_MAC_STAT_TX_MULTICAST_H	0x11a4b		/* 0x4692c */
 #define FBNIC_MAC_STAT_TX_BROADCAST_L	0x11a4c		/* 0x46930 */
 #define FBNIC_MAC_STAT_TX_BROADCAST_H	0x11a4d		/* 0x46934 */
+#define FBNIC_MAC_STAT_TX_PACKET_64_BYTES_L \
+					0x11a4e		/* 0x46938 */
+#define FBNIC_MAC_STAT_TX_PACKET_64_BYTES_H \
+					0x11a4f		/* 0x4693c */
+#define FBNIC_MAC_STAT_TX_PACKET_65_127_BYTES_L \
+					0x11a50		/* 0x46940 */
+#define FBNIC_MAC_STAT_TX_PACKET_65_127_BYTES_H \
+					0x11a51		/* 0x46944 */
+#define FBNIC_MAC_STAT_TX_PACKET_128_255_BYTES_L \
+					0x11a52		/* 0x46948 */
+#define FBNIC_MAC_STAT_TX_PACKET_128_255_BYTES_H \
+					0x11a53		/* 0x4694c */
+#define FBNIC_MAC_STAT_TX_PACKET_256_511_BYTES_L \
+					0x11a54		/* 0x46950 */
+#define FBNIC_MAC_STAT_TX_PACKET_256_511_BYTES_H \
+					0x11a55		/* 0x46954 */
+#define FBNIC_MAC_STAT_TX_PACKET_512_1023_BYTES_L \
+					0x11a56		/* 0x46958 */
+#define FBNIC_MAC_STAT_TX_PACKET_512_1023_BYTES_H \
+					0x11a57		/* 0x4695c */
+#define FBNIC_MAC_STAT_TX_PACKET_1024_1518_BYTES_L \
+					0x11a58		/* 0x46960 */
+#define FBNIC_MAC_STAT_TX_PACKET_1024_1518_BYTES_H \
+					0x11a59		/* 0x46964 */
+#define FBNIC_MAC_STAT_TX_PACKET_1519_MAX_BYTES_L \
+					0x11a5a		/* 0x46968 */
+#define FBNIC_MAC_STAT_TX_PACKET_1519_MAX_BYTES_H \
+					0x11a5b		/* 0x4696c */
+#define FBNIC_MAC_STAT_TX_CONTROL_FRAMES_L \
+					0x11a5e		/* 0x46978 */
+#define FBNIC_MAC_STAT_TX_CONTROL_FRAMES_H \
+					0x11a5f		/* 0x4697c */
 
 /* PCIE Comphy Registers */
 #define FBNIC_CSR_START_PCIE_SS_COMPHY	0x2442e /* CSR section delimiter */
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index 5c7556c8c4c5..6e52303796d9 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -1612,6 +1612,70 @@ fbnic_get_eth_mac_stats(struct net_device *netdev,
 			  &mac_stats->eth_mac.FrameTooLongErrors);
 }
 
+static void
+fbnic_get_eth_ctrl_stats(struct net_device *netdev,
+			 struct ethtool_eth_ctrl_stats *eth_ctrl_stats)
+{
+	struct fbnic_net *fbn = netdev_priv(netdev);
+	struct fbnic_mac_stats *mac_stats;
+	struct fbnic_dev *fbd = fbn->fbd;
+
+	mac_stats = &fbd->hw_stats.mac;
+
+	fbd->mac->get_eth_ctrl_stats(fbd, false, &mac_stats->eth_ctrl);
+
+	eth_ctrl_stats->MACControlFramesReceived =
+		mac_stats->eth_ctrl.MACControlFramesReceived.value;
+	eth_ctrl_stats->MACControlFramesTransmitted =
+		mac_stats->eth_ctrl.MACControlFramesTransmitted.value;
+}
+
+static const struct ethtool_rmon_hist_range fbnic_rmon_ranges[] = {
+	{    0,   64 },
+	{   65,  127 },
+	{  128,  255 },
+	{  256,  511 },
+	{  512, 1023 },
+	{ 1024, 1518 },
+	{ 1519, 2047 },
+	{ 2048, 4095 },
+	{ 4096, 8191 },
+	{ 8192, 9216 },
+	{ 9217, FBNIC_MAX_JUMBO_FRAME_SIZE },
+	{}
+};
+
+static void
+fbnic_get_rmon_stats(struct net_device *netdev,
+		     struct ethtool_rmon_stats *rmon_stats,
+		     const struct ethtool_rmon_hist_range **ranges)
+{
+	struct fbnic_net *fbn = netdev_priv(netdev);
+	struct fbnic_mac_stats *mac_stats;
+	struct fbnic_dev *fbd = fbn->fbd;
+	int i;
+
+	mac_stats = &fbd->hw_stats.mac;
+
+	fbd->mac->get_rmon_stats(fbd, false, &mac_stats->rmon);
+
+	rmon_stats->undersize_pkts =
+		mac_stats->rmon.undersize_pkts.value;
+	rmon_stats->oversize_pkts =
+		mac_stats->rmon.oversize_pkts.value;
+	rmon_stats->fragments =
+		mac_stats->rmon.fragments.value;
+	rmon_stats->jabbers =
+		mac_stats->rmon.jabbers.value;
+
+	for (i = 0; fbnic_rmon_ranges[i].high; i++) {
+		rmon_stats->hist[i] = mac_stats->rmon.hist[i].value;
+		rmon_stats->hist_tx[i] = mac_stats->rmon.hist_tx[i].value;
+	}
+
+	*ranges = fbnic_rmon_ranges;
+}
+
 static const struct ethtool_ops fbnic_ethtool_ops = {
 	.supported_coalesce_params	=
 				  ETHTOOL_COALESCE_USECS |
@@ -1641,6 +1705,8 @@ static const struct ethtool_ops fbnic_ethtool_ops = {
 	.get_ts_info		= fbnic_get_ts_info,
 	.get_ts_stats		= fbnic_get_ts_stats,
 	.get_eth_mac_stats	= fbnic_get_eth_mac_stats,
+	.get_eth_ctrl_stats	= fbnic_get_eth_ctrl_stats,
+	.get_rmon_stats		= fbnic_get_rmon_stats,
 };
 
 void fbnic_set_ethtool_ops(struct net_device *dev)
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
index 07e54bb75bf3..4fe239717497 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
@@ -22,6 +22,23 @@ struct fbnic_hw_stat {
 	struct fbnic_stat_counter bytes;
 };
 
+/* Note: not updated by fbnic_get_hw_stats() */
+struct fbnic_eth_ctrl_stats {
+	struct fbnic_stat_counter MACControlFramesTransmitted;
+	struct fbnic_stat_counter MACControlFramesReceived;
+};
+
+/* Note: not updated by fbnic_get_hw_stats() */
+struct fbnic_rmon_stats {
+	struct fbnic_stat_counter undersize_pkts;
+	struct fbnic_stat_counter oversize_pkts;
+	struct fbnic_stat_counter fragments;
+	struct fbnic_stat_counter jabbers;
+
+	struct fbnic_stat_counter hist[ETHTOOL_RMON_HIST_MAX];
+	struct fbnic_stat_counter hist_tx[ETHTOOL_RMON_HIST_MAX];
+};
+
 struct fbnic_eth_mac_stats {
 	struct fbnic_stat_counter FramesTransmittedOK;
 	struct fbnic_stat_counter FramesReceivedOK;
@@ -40,6 +57,8 @@ struct fbnic_eth_mac_stats {
 
 struct fbnic_mac_stats {
 	struct fbnic_eth_mac_stats eth_mac;
+	struct fbnic_eth_ctrl_stats eth_ctrl;
+	struct fbnic_rmon_stats rmon;
 };
 
 struct fbnic_tmi_stats {
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
index 10e108c1fcd0..ea5ea7e329cb 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
@@ -680,6 +680,76 @@ fbnic_mac_get_eth_mac_stats(struct fbnic_dev *fbd, bool reset,
 			    MAC_STAT_TX_BROADCAST);
 }
 
+static void
+fbnic_mac_get_eth_ctrl_stats(struct fbnic_dev *fbd, bool reset,
+			     struct fbnic_eth_ctrl_stats *ctrl_stats)
+{
+	fbnic_mac_stat_rd64(fbd, reset, ctrl_stats->MACControlFramesReceived,
+			    MAC_STAT_RX_CONTROL_FRAMES);
+	fbnic_mac_stat_rd64(fbd, reset, ctrl_stats->MACControlFramesTransmitted,
+			    MAC_STAT_TX_CONTROL_FRAMES);
+}
+
+static void
+fbnic_mac_get_rmon_stats(struct fbnic_dev *fbd, bool reset,
+			 struct fbnic_rmon_stats *rmon_stats)
+{
+	fbnic_mac_stat_rd64(fbd, reset, rmon_stats->undersize_pkts,
+			    MAC_STAT_RX_UNDERSIZE);
+	fbnic_mac_stat_rd64(fbd, reset, rmon_stats->oversize_pkts,
+			    MAC_STAT_RX_OVERSIZE);
+	fbnic_mac_stat_rd64(fbd, reset, rmon_stats->fragments,
+			    MAC_STAT_RX_FRAGMENT);
+	fbnic_mac_stat_rd64(fbd, reset, rmon_stats->jabbers,
+			    MAC_STAT_RX_JABBER);
+
+	fbnic_mac_stat_rd64(fbd, reset, rmon_stats->hist[0],
+			    MAC_STAT_RX_PACKET_64_BYTES);
+	fbnic_mac_stat_rd64(fbd, reset, rmon_stats->hist[1],
+			    MAC_STAT_RX_PACKET_65_127_BYTES);
+	fbnic_mac_stat_rd64(fbd, reset, rmon_stats->hist[2],
+			    MAC_STAT_RX_PACKET_128_255_BYTES);
+	fbnic_mac_stat_rd64(fbd, reset, rmon_stats->hist[3],
+			    MAC_STAT_RX_PACKET_256_511_BYTES);
+	fbnic_mac_stat_rd64(fbd, reset, rmon_stats->hist[4],
+			    MAC_STAT_RX_PACKET_512_1023_BYTES);
+	fbnic_mac_stat_rd64(fbd, reset, rmon_stats->hist[5],
+			    MAC_STAT_RX_PACKET_1024_1518_BYTES);
+	fbnic_mac_stat_rd64(fbd, reset, rmon_stats->hist[6],
+			    RPC_STAT_RX_PACKET_1519_2047_BYTES);
+	fbnic_mac_stat_rd64(fbd, reset, rmon_stats->hist[7],
+			    RPC_STAT_RX_PACKET_2048_4095_BYTES);
+	fbnic_mac_stat_rd64(fbd, reset, rmon_stats->hist[8],
+			    RPC_STAT_RX_PACKET_4096_8191_BYTES);
+	fbnic_mac_stat_rd64(fbd, reset, rmon_stats->hist[9],
+			    RPC_STAT_RX_PACKET_8192_9216_BYTES);
+	fbnic_mac_stat_rd64(fbd, reset, rmon_stats->hist[10],
+			    RPC_STAT_RX_PACKET_9217_MAX_BYTES);
+
+	fbnic_mac_stat_rd64(fbd, reset, rmon_stats->hist_tx[0],
+			    MAC_STAT_TX_PACKET_64_BYTES);
+	fbnic_mac_stat_rd64(fbd, reset, rmon_stats->hist_tx[1],
+			    MAC_STAT_TX_PACKET_65_127_BYTES);
+	fbnic_mac_stat_rd64(fbd, reset, rmon_stats->hist_tx[2],
+			    MAC_STAT_TX_PACKET_128_255_BYTES);
+	fbnic_mac_stat_rd64(fbd, reset, rmon_stats->hist_tx[3],
+			    MAC_STAT_TX_PACKET_256_511_BYTES);
+	fbnic_mac_stat_rd64(fbd, reset, rmon_stats->hist_tx[4],
+			    MAC_STAT_TX_PACKET_512_1023_BYTES);
+	fbnic_mac_stat_rd64(fbd, reset, rmon_stats->hist_tx[5],
+			    MAC_STAT_TX_PACKET_1024_1518_BYTES);
+	fbnic_mac_stat_rd64(fbd, reset, rmon_stats->hist_tx[6],
+			    TMI_STAT_TX_PACKET_1519_2047_BYTES);
+	fbnic_mac_stat_rd64(fbd, reset, rmon_stats->hist_tx[7],
+			    TMI_STAT_TX_PACKET_2048_4095_BYTES);
+	fbnic_mac_stat_rd64(fbd, reset, rmon_stats->hist_tx[8],
+			    TMI_STAT_TX_PACKET_4096_8191_BYTES);
+	fbnic_mac_stat_rd64(fbd, reset, rmon_stats->hist_tx[9],
+			    TMI_STAT_TX_PACKET_8192_9216_BYTES);
+	fbnic_mac_stat_rd64(fbd, reset, rmon_stats->hist_tx[10],
+			    TMI_STAT_TX_PACKET_9217_MAX_BYTES);
+}
+
 static int fbnic_mac_get_sensor_asic(struct fbnic_dev *fbd, int id,
 				     long *val)
 {
@@ -755,6 +825,8 @@ static const struct fbnic_mac fbnic_mac_asic = {
 	.pcs_get_link = fbnic_pcs_get_link_asic,
 	.pcs_get_link_event = fbnic_pcs_get_link_event_asic,
 	.get_eth_mac_stats = fbnic_mac_get_eth_mac_stats,
+	.get_eth_ctrl_stats = fbnic_mac_get_eth_ctrl_stats,
+	.get_rmon_stats = fbnic_mac_get_rmon_stats,
 	.link_down = fbnic_mac_link_down_asic,
 	.link_up = fbnic_mac_link_up_asic,
 	.get_sensor = fbnic_mac_get_sensor_asic,
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.h b/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
index 05a591653e09..4d508e1e2151 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
@@ -85,6 +85,10 @@ struct fbnic_mac {
 
 	void (*get_eth_mac_stats)(struct fbnic_dev *fbd, bool reset,
 				  struct fbnic_eth_mac_stats *mac_stats);
+	void (*get_eth_ctrl_stats)(struct fbnic_dev *fbd, bool reset,
+				   struct fbnic_eth_ctrl_stats *ctrl_stats);
+	void (*get_rmon_stats)(struct fbnic_dev *fbd, bool reset,
+			       struct fbnic_rmon_stats *rmon_stats);
 
 	void (*link_down)(struct fbnic_dev *fbd);
 	void (*link_up)(struct fbnic_dev *fbd, bool tx_pause, bool rx_pause);
-- 
2.47.1


