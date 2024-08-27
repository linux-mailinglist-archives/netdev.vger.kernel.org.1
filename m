Return-Path: <netdev+bounces-122511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8ED9618E5
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 22:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 866C51C23267
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 20:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40D01D362C;
	Tue, 27 Aug 2024 20:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1efVlMy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6CA1D3638
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 20:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724792374; cv=none; b=E7LfMMMlOEGa7pDjrOabcoAEofKylxbtWc6fmpnyb+eEFaqScjU8MiH33rjEjPibye1e8nSvpDJTLac+NgZLMwq0RMwZs29Xy+pngwjXHsof/rhZmrKGhO+PjV07/oKw+/wCcTirtRz8vGFTI23WczFRBsLZX456Xz3SV+jcmjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724792374; c=relaxed/simple;
	bh=yNdm4X9bwN3kd25RH8P9yIz6aKoe+S+o/Ano3KFGA5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SGzrDe41W4D2FjlOrnoa7HnNnY5ep/t6FX3YuDJ2wyEDIY6eAm7Cs2CjuCN/YfiU+vugnmJdsyq+rYzLLK9EC6kOoiXu6+/KGTfSbQKxn9t6KzYP8sbR4Bydpa9jOK6uBDw1V5Bn3/QlfRSIAbcpERSQNPO/fEA+UbeEMBbr5ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1efVlMy; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4280ca0791bso53486835e9.1
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 13:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724792370; x=1725397170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNXRNdAf7XjBzaA2/J9yrGsmbMi6fSq2IaeI8CHTWzw=;
        b=h1efVlMyRdaADcUcLdtZWslEL++RsmvSbyNyZxAiy25A8AIQ1S/oAg09cTdlMEyG04
         O5zn8v5g8iOuM4DDduO+rwZBSZawTZfOh58UNbOqlgdUZ0TNJpPrrD3VAYAXqpe3r8f5
         d9QcabDFcNQz5O2iRNH3lrTd2XprRLAdAO1igd/aelfjEw/DBPwjbqANtKVfhzT0hnP9
         J8mx3S2RAzQB5v/G5WUtIa+XpC+Yg9UcQ3Bw3isFeNrdq+BMsft5IH87/43k8ho8kvSy
         3uAbLVtrjvRokw7l3l9xiQ1GEDZTIl/ZYK3PEHYQ1Vle+554EkZxbQBvN1I40YFoUeeg
         UJPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724792370; x=1725397170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nNXRNdAf7XjBzaA2/J9yrGsmbMi6fSq2IaeI8CHTWzw=;
        b=cRCbsEXG8gJemBGs11Dp4Nu3nnMFuO1PKqIAN7ia6Bvdb0oEm8ZeWZNeJi4RY/gjLr
         400tgYgHxdkv8kzE4WhhFscKnPYGOAvF8zkbGkyKyVnGSRhE6kHZoatUHYa6JsRMHOYb
         aCdoSElzsQWDtyAHWv64aklYP30ojfieMRDdf6pGFRoe6HW4KYTq49Cw2YCnuA0hD5+Z
         opmCd5YuOPLrezeHzs+ttM80rwGKzpVBsMFsWXpJHbgqwSFF44JrxUA6M4zmE70loA+K
         aLi8M9W4gca77+FxCQOde5Ia/a9OmvRpaLuyVsbBdJK7wO66Gwwt+R2TmP4O2OulECdc
         MV7g==
X-Gm-Message-State: AOJu0YwRVePvHfjmdl/c62ErE7NnW5cUCkgwTf7OE1nqheK/+dEtyPEV
	oS2Qlge8dvWHts2FCEQDaPQOaz8Q/KFXW6MmtOXkclZWBZtm10OwJA+2c1+q
X-Google-Smtp-Source: AGHT+IGAg6xSI2Kcec00GFGn4NlTdg4WGWJLwzl0Jxk59GJk6h8KaSP/AxrDJdPl1V/+I+HPoD2xUQ==
X-Received: by 2002:a05:600c:a08:b0:427:ff7a:79e with SMTP id 5b1f17b1804b1-42b9add47f0mr26730245e9.16.1724792369909;
        Tue, 27 Aug 2024 13:59:29 -0700 (PDT)
Received: from localhost (fwdproxy-cln-019.fbsv.net. [2a03:2880:31ff:13::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac5158485sm196997815e9.13.2024.08.27.13.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 13:59:29 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	kuba@kernel.org,
	andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	kernel-team@meta.com,
	sanmanpradhan@meta.com,
	sdf@fomichev.me,
	jdamato@fastly.com,
	mohsin.bashr@gmail.com
Subject: [PATCH net-next v2 2/2] eth: fbnic: Add support to fetch group stats
Date: Tue, 27 Aug 2024 13:59:04 -0700
Message-ID: <20240827205904.1944066-3-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240827205904.1944066-1-mohsin.bashr@gmail.com>
References: <20240827205904.1944066-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for group stats for mac. The fbnic_set_counter helps prevent
overriding the default values for counters which are not collected by the device.

The 'reset' flag in 'get_eth_mac_stats' allows choosing between
resetting the counter to recent most value or fecthing the aggregate
values of counters. This is important to cater for cases such as
device reset.

The 'fbnic_stat_rd64' read 64b stats counters in a consistent fashion using
high-low-high approach. This allows to isolate cases where counter is
wrapped between the reads.

Command: ethtool -S eth0 --groups eth-mac
Example Output:
eth-mac-FramesTransmittedOK: 421644
eth-mac-FramesReceivedOK: 3849708
eth-mac-FrameCheckSequenceErrors: 0
eth-mac-AlignmentErrors: 0
eth-mac-OctetsTransmittedOK: 64799060
eth-mac-FramesLostDueToIntMACXmitError: 0
eth-mac-OctetsReceivedOK: 5134513531
eth-mac-FramesLostDueToIntMACRcvError: 0
eth-mac-MulticastFramesXmittedOK: 568
eth-mac-BroadcastFramesXmittedOK: 454
eth-mac-MulticastFramesReceivedOK: 276106
eth-mac-BroadcastFramesReceivedOK: 26119
eth-mac-FrameTooLongErrors: 0

Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
v2: Rebase to the latest

v1: https://lore.kernel.org/netdev/20240807002445.3833895-1-mohsin.bashr@gmail.com
---
 drivers/net/ethernet/meta/fbnic/Makefile      |  1 +
 drivers/net/ethernet/meta/fbnic/fbnic.h       |  4 ++
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   | 37 ++++++++++++++
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   | 49 ++++++++++++++++++
 .../net/ethernet/meta/fbnic/fbnic_hw_stats.c  | 27 ++++++++++
 .../net/ethernet/meta/fbnic/fbnic_hw_stats.h  | 40 +++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c   | 50 +++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h   |  3 ++
 8 files changed, 211 insertions(+)
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h

diff --git a/drivers/net/ethernet/meta/fbnic/Makefile b/drivers/net/ethernet/meta/fbnic/Makefile
index 37cfc34a5118..ed4533a73c57 100644
--- a/drivers/net/ethernet/meta/fbnic/Makefile
+++ b/drivers/net/ethernet/meta/fbnic/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_FBNIC) += fbnic.o
 fbnic-y := fbnic_devlink.o \
 	   fbnic_ethtool.o \
 	   fbnic_fw.o \
+	   fbnic_hw_stats.o \
 	   fbnic_irq.o \
 	   fbnic_mac.o \
 	   fbnic_netdev.o \
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
index 28d970f81bfc..0f9e8d79461c 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
@@ -11,6 +11,7 @@
 
 #include "fbnic_csr.h"
 #include "fbnic_fw.h"
+#include "fbnic_hw_stats.h"
 #include "fbnic_mac.h"
 #include "fbnic_rpc.h"
 
@@ -47,6 +48,9 @@ struct fbnic_dev {
 
 	/* Number of TCQs/RCQs available on hardware */
 	u16 max_num_queues;
+
+	/* Local copy of hardware statistics */
+	struct fbnic_hw_stats hw_stats;
 };
 
 /* Reserve entry 0 in the MSI-X "others" array until we have filled all
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
index a64360de0552..21db509acbc1 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
@@ -660,6 +660,43 @@ enum {
 #define FBNIC_SIG_PCS_INTR_MASK		0x11816		/* 0x46058 */
 #define FBNIC_CSR_END_SIG		0x1184e /* CSR section delimiter */
 
+#define FBNIC_CSR_START_MAC_STAT	0x11a00
+#define FBNIC_MAC_STAT_RX_BYTE_COUNT_L	0x11a08		/* 0x46820 */
+#define FBNIC_MAC_STAT_RX_BYTE_COUNT_H	0x11a09		/* 0x46824 */
+#define FBNIC_MAC_STAT_RX_ALIGN_ERROR_L \
+					0x11a0a		/* 0x46828 */
+#define FBNIC_MAC_STAT_RX_ALIGN_ERROR_H \
+					0x11a0b		/* 0x4682c */
+#define FBNIC_MAC_STAT_RX_TOOLONG_L	0x11a0e		/* 0x46838 */
+#define FBNIC_MAC_STAT_RX_TOOLONG_H	0x11a0f		/* 0x4683c */
+#define FBNIC_MAC_STAT_RX_RECEIVED_OK_L	\
+					0x11a12		/* 0x46848 */
+#define FBNIC_MAC_STAT_RX_RECEIVED_OK_H	\
+					0x11a13		/* 0x4684c */
+#define FBNIC_MAC_STAT_RX_PACKET_BAD_FCS_L \
+					0x11a14		/* 0x46850 */
+#define FBNIC_MAC_STAT_RX_PACKET_BAD_FCS_H \
+					0x11a15		/* 0x46854 */
+#define FBNIC_MAC_STAT_RX_IFINERRORS_L	0x11a18		/* 0x46860 */
+#define FBNIC_MAC_STAT_RX_IFINERRORS_H	0x11a19		/* 0x46864 */
+#define FBNIC_MAC_STAT_RX_MULTICAST_L	0x11a1c		/* 0x46870 */
+#define FBNIC_MAC_STAT_RX_MULTICAST_H	0x11a1d		/* 0x46874 */
+#define FBNIC_MAC_STAT_RX_BROADCAST_L	0x11a1e		/* 0x46878 */
+#define FBNIC_MAC_STAT_RX_BROADCAST_H	0x11a1f		/* 0x4687c */
+#define FBNIC_MAC_STAT_TX_BYTE_COUNT_L	0x11a3e		/* 0x468f8 */
+#define FBNIC_MAC_STAT_TX_BYTE_COUNT_H	0x11a3f		/* 0x468fc */
+#define FBNIC_MAC_STAT_TX_TRANSMITTED_OK_L \
+					0x11a42		/* 0x46908 */
+#define FBNIC_MAC_STAT_TX_TRANSMITTED_OK_H \
+					0x11a43		/* 0x4690c */
+#define FBNIC_MAC_STAT_TX_IFOUTERRORS_L \
+					0x11a46		/* 0x46918 */
+#define FBNIC_MAC_STAT_TX_IFOUTERRORS_H \
+					0x11a47		/* 0x4691c */
+#define FBNIC_MAC_STAT_TX_MULTICAST_L	0x11a4a		/* 0x46928 */
+#define FBNIC_MAC_STAT_TX_MULTICAST_H	0x11a4b		/* 0x4692c */
+#define FBNIC_MAC_STAT_TX_BROADCAST_L	0x11a4c		/* 0x46930 */
+#define FBNIC_MAC_STAT_TX_BROADCAST_H	0x11a4d		/* 0x46934 */
 /* PUL User Registers */
 #define FBNIC_CSR_START_PUL_USER	0x31000	/* CSR section delimiter */
 #define FBNIC_PUL_OB_TLP_HDR_AW_CFG	0x3103d		/* 0xc40f4 */
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index 7064dfc9f5b0..5d980e178941 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -16,8 +16,57 @@ fbnic_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *drvinfo)
 				    sizeof(drvinfo->fw_version));
 }
 
+static void fbnic_set_counter(u64 *stat, struct fbnic_stat_counter *counter)
+{
+	if (counter->reported)
+		*stat = counter->value;
+}
+
+static void
+fbnic_get_eth_mac_stats(struct net_device *netdev,
+			struct ethtool_eth_mac_stats *eth_mac_stats)
+{
+	struct fbnic_net *fbn = netdev_priv(netdev);
+	struct fbnic_mac_stats *mac_stats;
+	struct fbnic_dev *fbd = fbn->fbd;
+	const struct fbnic_mac *mac;
+
+	mac_stats = &fbd->hw_stats.mac;
+	mac = fbd->mac;
+
+	mac->get_eth_mac_stats(fbd, false, &mac_stats->eth_mac);
+
+	fbnic_set_counter(&eth_mac_stats->FramesTransmittedOK,
+			  &mac_stats->eth_mac.FramesTransmittedOK);
+	fbnic_set_counter(&eth_mac_stats->FramesReceivedOK,
+			  &mac_stats->eth_mac.FramesReceivedOK);
+	fbnic_set_counter(&eth_mac_stats->FrameCheckSequenceErrors,
+			  &mac_stats->eth_mac.FrameCheckSequenceErrors);
+	fbnic_set_counter(&eth_mac_stats->AlignmentErrors,
+			  &mac_stats->eth_mac.AlignmentErrors);
+	fbnic_set_counter(&eth_mac_stats->OctetsTransmittedOK,
+			  &mac_stats->eth_mac.OctetsTransmittedOK);
+	fbnic_set_counter(&eth_mac_stats->FramesLostDueToIntMACXmitError,
+			  &mac_stats->eth_mac.FramesLostDueToIntMACXmitError);
+	fbnic_set_counter(&eth_mac_stats->OctetsReceivedOK,
+			  &mac_stats->eth_mac.OctetsReceivedOK);
+	fbnic_set_counter(&eth_mac_stats->FramesLostDueToIntMACRcvError,
+			  &mac_stats->eth_mac.FramesLostDueToIntMACRcvError);
+	fbnic_set_counter(&eth_mac_stats->MulticastFramesXmittedOK,
+			  &mac_stats->eth_mac.MulticastFramesXmittedOK);
+	fbnic_set_counter(&eth_mac_stats->BroadcastFramesXmittedOK,
+			  &mac_stats->eth_mac.BroadcastFramesXmittedOK);
+	fbnic_set_counter(&eth_mac_stats->MulticastFramesReceivedOK,
+			  &mac_stats->eth_mac.MulticastFramesReceivedOK);
+	fbnic_set_counter(&eth_mac_stats->BroadcastFramesReceivedOK,
+			  &mac_stats->eth_mac.BroadcastFramesReceivedOK);
+	fbnic_set_counter(&eth_mac_stats->FrameTooLongErrors,
+			  &mac_stats->eth_mac.FrameTooLongErrors);
+}
+
 static const struct ethtool_ops fbnic_ethtool_ops = {
 	.get_drvinfo		= fbnic_get_drvinfo,
+	.get_eth_mac_stats	= fbnic_get_eth_mac_stats,
 };
 
 void fbnic_set_ethtool_ops(struct net_device *dev)
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
new file mode 100644
index 000000000000..a0acc7606aa1
--- /dev/null
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
@@ -0,0 +1,27 @@
+#include "fbnic.h"
+
+u64 fbnic_stat_rd64(struct fbnic_dev *fbd, u32 reg, u32 offset)
+{
+	u32 prev_upper, upper, lower, diff;
+
+	prev_upper = rd32(fbd, reg + offset);
+	lower = rd32(fbd, reg);
+	upper = rd32(fbd, reg + offset);
+
+	diff = upper - prev_upper;
+	if (!diff)
+		return ((u64)upper << 32) | lower;
+
+	if (diff > 1)
+		dev_warn_once(fbd->dev,
+			      "Stats inconsistent, upper 32b of %#010x updating too quickly\n",
+			      reg * 4);
+
+	/* Return only the upper bits as we cannot guarantee
+	 * the accuracy of the lower bits. We will add them in
+	 * when the counter slows down enough that we can get
+	 * a snapshot with both upper values being the same
+	 * between reads.
+	 */
+	return ((u64)upper << 32);
+}
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
new file mode 100644
index 000000000000..30348904b510
--- /dev/null
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
@@ -0,0 +1,40 @@
+#include <linux/ethtool.h>
+
+#include "fbnic_csr.h"
+
+struct fbnic_stat_counter {
+	u64 value;
+	union {
+		u32 old_reg_value_32;
+		u64 old_reg_value_64;
+	} u;
+	bool reported;
+};
+
+struct fbnic_eth_mac_stats {
+	struct fbnic_stat_counter FramesTransmittedOK;
+	struct fbnic_stat_counter FramesReceivedOK;
+	struct fbnic_stat_counter FrameCheckSequenceErrors;
+	struct fbnic_stat_counter AlignmentErrors;
+	struct fbnic_stat_counter OctetsTransmittedOK;
+	struct fbnic_stat_counter FramesLostDueToIntMACXmitError;
+	struct fbnic_stat_counter OctetsReceivedOK;
+	struct fbnic_stat_counter FramesLostDueToIntMACRcvError;
+	struct fbnic_stat_counter MulticastFramesXmittedOK;
+	struct fbnic_stat_counter BroadcastFramesXmittedOK;
+	struct fbnic_stat_counter MulticastFramesReceivedOK;
+	struct fbnic_stat_counter BroadcastFramesReceivedOK;
+	struct fbnic_stat_counter FrameTooLongErrors;
+};
+
+struct fbnic_mac_stats {
+	struct fbnic_eth_mac_stats eth_mac;
+};
+
+struct fbnic_hw_stats {
+	struct fbnic_mac_stats mac;
+};
+
+u64 fbnic_stat_rd64(struct fbnic_dev *fbd, u32 reg, u32 offset);
+
+void fbnic_get_hw_stats(struct fbnic_dev *fbd);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
index 7920e7af82d9..7b654d0a6dac 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
@@ -403,6 +403,21 @@ static void fbnic_mac_init_regs(struct fbnic_dev *fbd)
 	fbnic_mac_init_txb(fbd);
 }
 
+static void __fbnic_mac_stat_rd64(struct fbnic_dev *fbd, bool reset, u32 reg,
+				  struct fbnic_stat_counter *stat)
+{
+	u64 new_reg_value;
+
+	new_reg_value = fbnic_stat_rd64(fbd, reg, 1);
+	if (!reset)
+		stat->value += new_reg_value - stat->u.old_reg_value_64;
+	stat->u.old_reg_value_64 = new_reg_value;
+	stat->reported = true;
+}
+
+#define fbnic_mac_stat_rd64(fbd, reset, __stat, __CSR) \
+	__fbnic_mac_stat_rd64(fbd, reset, FBNIC_##__CSR##_L, &(__stat))
+
 static void fbnic_mac_tx_pause_config(struct fbnic_dev *fbd, bool tx_pause)
 {
 	u32 rxb_pause_ctrl;
@@ -637,12 +652,47 @@ static void fbnic_mac_link_up_asic(struct fbnic_dev *fbd,
 	wr32(fbd, FBNIC_MAC_COMMAND_CONFIG, cmd_cfg);
 }
 
+static void
+fbnic_mac_get_eth_mac_stats(struct fbnic_dev *fbd, bool reset,
+			    struct fbnic_eth_mac_stats *mac_stats)
+{
+	fbnic_mac_stat_rd64(fbd, reset, mac_stats->OctetsReceivedOK,
+			    MAC_STAT_RX_BYTE_COUNT);
+	fbnic_mac_stat_rd64(fbd, reset, mac_stats->AlignmentErrors,
+			    MAC_STAT_RX_ALIGN_ERROR);
+	fbnic_mac_stat_rd64(fbd, reset, mac_stats->FrameTooLongErrors,
+			    MAC_STAT_RX_TOOLONG);
+	fbnic_mac_stat_rd64(fbd, reset, mac_stats->FramesReceivedOK,
+			    MAC_STAT_RX_RECEIVED_OK);
+	fbnic_mac_stat_rd64(fbd, reset, mac_stats->FrameCheckSequenceErrors,
+			    MAC_STAT_RX_PACKET_BAD_FCS);
+	fbnic_mac_stat_rd64(fbd, reset,
+			    mac_stats->FramesLostDueToIntMACRcvError,
+			    MAC_STAT_RX_IFINERRORS);
+	fbnic_mac_stat_rd64(fbd, reset, mac_stats->MulticastFramesReceivedOK,
+			    MAC_STAT_RX_MULTICAST);
+	fbnic_mac_stat_rd64(fbd, reset, mac_stats->BroadcastFramesReceivedOK,
+			    MAC_STAT_RX_BROADCAST);
+	fbnic_mac_stat_rd64(fbd, reset, mac_stats->OctetsTransmittedOK,
+			    MAC_STAT_TX_BYTE_COUNT);
+	fbnic_mac_stat_rd64(fbd, reset, mac_stats->FramesTransmittedOK,
+			    MAC_STAT_TX_TRANSMITTED_OK);
+	fbnic_mac_stat_rd64(fbd, reset,
+			    mac_stats->FramesLostDueToIntMACXmitError,
+			    MAC_STAT_TX_IFOUTERRORS);
+	fbnic_mac_stat_rd64(fbd, reset, mac_stats->MulticastFramesXmittedOK,
+			    MAC_STAT_TX_MULTICAST);
+	fbnic_mac_stat_rd64(fbd, reset, mac_stats->BroadcastFramesXmittedOK,
+			    MAC_STAT_TX_BROADCAST);
+}
+
 static const struct fbnic_mac fbnic_mac_asic = {
 	.init_regs = fbnic_mac_init_regs,
 	.pcs_enable = fbnic_pcs_enable_asic,
 	.pcs_disable = fbnic_pcs_disable_asic,
 	.pcs_get_link = fbnic_pcs_get_link_asic,
 	.pcs_get_link_event = fbnic_pcs_get_link_event_asic,
+	.get_eth_mac_stats = fbnic_mac_get_eth_mac_stats,
 	.link_down = fbnic_mac_link_down_asic,
 	.link_up = fbnic_mac_link_up_asic,
 };
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.h b/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
index f53be6e6aef9..476239a9d381 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
@@ -78,6 +78,9 @@ struct fbnic_mac {
 	bool (*pcs_get_link)(struct fbnic_dev *fbd);
 	int (*pcs_get_link_event)(struct fbnic_dev *fbd);
 
+	void (*get_eth_mac_stats)(struct fbnic_dev *fbd, bool reset,
+				  struct fbnic_eth_mac_stats *mac_stats);
+
 	void (*link_down)(struct fbnic_dev *fbd);
 	void (*link_up)(struct fbnic_dev *fbd, bool tx_pause, bool rx_pause);
 };
-- 
2.43.5


