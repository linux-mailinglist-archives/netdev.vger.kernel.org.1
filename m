Return-Path: <netdev+bounces-141112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2719F9B9995
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 21:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA6EF28204F
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 20:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71291D5AA3;
	Fri,  1 Nov 2024 20:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLUnlU+l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA57168DA
	for <netdev@vger.kernel.org>; Fri,  1 Nov 2024 20:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730493691; cv=none; b=ZzIjpe23TWVeeFjQQ5BIK+DPtkhaE6PiJWnWKfKk7+5evPrZR2sS4XcQoCfArRd+KOyU+l0AlpwIOee6+mR2DnAM+3KXcHiOfOpUJp0lmPhnGAKJqKyI1hKBfoh4p0rgHLP41f2vEdw8czosplkAKV8OG9iggUOuvoEGGUN5t4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730493691; c=relaxed/simple;
	bh=QOphRyKAsxIaEFGcLo/qel+AtfTxF+JUHmxDpd5th8U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hfTRP37S9Z1E99DFb4Ehrbc7wcxnslqel4zmwHeufm73UMn6ruZY2QnT7eG9+dOWiBGWIfAWqIHGBfF006QztzPU0ZnnJLDTLuNOQSsU5Eto+Np0YJc3ROfYnr8nMPxOUluBCJahRja/ASvsk7OkBkjjJspTp9c4eV7gbSBBuZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLUnlU+l; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-431548bd1b4so19547465e9.3
        for <netdev@vger.kernel.org>; Fri, 01 Nov 2024 13:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730493688; x=1731098488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LFpXM2gzrzFolk86kxvnGgp4sU8zsgEQqSpmVmzFk+Y=;
        b=dLUnlU+lTzBt0mQLce1vwzfB5ezTFuwckw1weuo/FfDzo/0S9+vYK3RbiiQwDFP/N1
         PHCUJOKtbJIapl6TjcfiTf+GOJDWYONeRC5hgL/Kfq1nGSqQXvykuOdAc1gX7b+ePA2P
         Gj6MbyskOnqeXJZMnojr528QVQVc37XwObqo4GQqTvGSw1gxZ/GQ+5wBRMUCemLGu3FS
         WoHaFOMzT+lwZTTLvYafh71WQXHWnGN+E93BWwSy538TpTx5/njMLdcJ8oN+Ee+cxW1X
         oYsULrXYyj8fxXuQqk+98e82Y5pweW4duMUKnfSW9ZxNA4OM6rxw+ltKDJBrkF/R0zxb
         SFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730493688; x=1731098488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LFpXM2gzrzFolk86kxvnGgp4sU8zsgEQqSpmVmzFk+Y=;
        b=Qht7rHUmu+L4NnG82cZ+VodVGjVkP0pwdtqZ+DJKL6rKIss45oSspxcMo/RNHXo/X4
         dBY3MkVy9e4Vezk4Cx8xhFEeQyfiQf1fUhntZmvYmb3EQd1a9dWyaKoSrGy9WldZSCIE
         VdGZU4kbC/OdWaMitw70P5t0JoMF5lX05wjvaUt/kAxYJ4LnzxOj/yCTbjFJmARlmQ/l
         6wxeDVlD+oLeCJcFGTGNgy7/VfbmX7WVUmZo2Aoc2YVqXHLfYCl/vJIVnDDFJcgcT7im
         L40ycYYLjpDwkds8J9g6pEqcju7D0sKNUYuOLmnIQVfDXl07vmmQoNvH/JOjuR3F8blY
         h1iQ==
X-Gm-Message-State: AOJu0YxxOA3bI53J7qKM46+e2qjN85nMq9lKTKg6rTVVZHVmQOnus1X9
	wpS0SAfOa2Dw7Q8J7zShaWhW6frYfve9T5FdOsrQePPMTVCOqmDvcO1LtLzj
X-Google-Smtp-Source: AGHT+IE/QLQM9aWOi6RSdfhmGoHG0xe1YHSrHcyTJUJu2rrdpDuNeb+IJmmPa65b7VUhkdDza+mmWQ==
X-Received: by 2002:a05:600c:354e:b0:431:52f5:f48d with SMTP id 5b1f17b1804b1-43283297ac6mr42569805e9.31.1730493687426;
        Fri, 01 Nov 2024 13:41:27 -0700 (PDT)
Received: from localhost (fwdproxy-cln-001.fbsv.net. [2a03:2880:31ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7b80sm6206478f8f.10.2024.11.01.13.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 13:41:25 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	kuba@kernel.org,
	andrew@lunn.ch,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	kernel-team@meta.com,
	sanmanpradhan@meta.com,
	sdf@fomichev.me,
	vadim.fedorenko@linux.dev,
	horms@kernel.org,
	jdamato@fastly.com,
	mohsin.bashr@gmail.com
Subject: [PATCH net-next v4] eth: fbnic: Add support to write TCE TCAM entries
Date: Fri,  1 Nov 2024 13:41:16 -0700
Message-ID: <20241101204116.1368328-1-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support to redirect host-to-BMC traffic by writing MACDA entries
from the RPC (RX Parser and Classifier) to TCE-TCAM. The TCE TCAM is a
small L2 destination TCAM which is placed at the end of the TX path (TCE).

Unlike other NICs, where BMC diversion is typically handled by firmware,
for fbnic, firmware does not touch anything related to the host; hence,
the host uses TCE TCAM to divert BMC traffic.

Currently, we lack metadata to track where addresses have been written
in the TCAM, except for the last entry written. To address this issue,
we start at the opposite end of the table in each pass, so that adding
or deleting entries does not affect the availability of all entries,
assuming there is no significant reordering of entries.
---
Changes in V4:
- Update the commit message to clearly specify the role of TCE TCAM in
  fbnic
- Revert iterator related changes made in V3 back to V2, including
  iterator type and place of declaration

V3: https://lore.kernel.org/netdev/20241025225910.30187-1-mohsin.bashr@gmail.com
V2: https://lore.kernel.org/netdev/20241024223135.310733-1-mohsin.bashr@gmail.com
V1: https://lore.kernel.org/netdev/20241021185544.713305-1-mohsin.bashr@gmail.com

Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic.h       |   1 +
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |  20 ++++
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |   1 +
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c   | 110 ++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.h   |   4 +
 5 files changed, 136 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
index fec567c8fe4a..9f9cb9b3e74e 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
@@ -48,6 +48,7 @@ struct fbnic_dev {
 	struct fbnic_act_tcam act_tcam[FBNIC_RPC_TCAM_ACT_NUM_ENTRIES];
 	struct fbnic_mac_addr mac_addr[FBNIC_RPC_TCAM_MACDA_NUM_ENTRIES];
 	u8 mac_addr_boundary;
+	u8 tce_tcam_last;
 
 	/* Number of TCQs/RCQs available on hardware */
 	u16 max_num_queues;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
index 79cdd231d327..dd407089ca47 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
@@ -397,6 +397,14 @@ enum {
 #define FBNIC_TCE_DROP_CTRL_TTI_FRM_DROP_EN	CSR_BIT(1)
 #define FBNIC_TCE_DROP_CTRL_TTI_TBI_DROP_EN	CSR_BIT(2)
 
+#define FBNIC_TCE_TCAM_IDX2DEST_MAP	0x0404A		/* 0x10128 */
+#define FBNIC_TCE_TCAM_IDX2DEST_MAP_DEST_ID_0	CSR_GENMASK(3, 0)
+enum {
+	FBNIC_TCE_TCAM_DEST_MAC		= 1,
+	FBNIC_TCE_TCAM_DEST_BMC		= 2,
+	FBNIC_TCE_TCAM_DEST_FW		= 4,
+};
+
 #define FBNIC_TCE_TXB_TX_BMC_Q_CTRL	0x0404B		/* 0x1012c */
 #define FBNIC_TCE_TXB_BMC_DWRR_CTRL	0x0404C		/* 0x10130 */
 #define FBNIC_TCE_TXB_BMC_DWRR_CTRL_QUANTUM0	CSR_GENMASK(7, 0)
@@ -407,6 +415,18 @@ enum {
 #define FBNIC_TCE_TXB_BMC_DWRR_CTRL_EXT	0x0404F		/* 0x1013c */
 #define FBNIC_CSR_END_TCE		0x04050	/* CSR section delimiter */
 
+/* TCE RAM registers */
+#define FBNIC_CSR_START_TCE_RAM		0x04200	/* CSR section delimiter */
+#define FBNIC_TCE_RAM_TCAM(m, n) \
+	(0x04200 + 0x8 * (n) + (m))		/* 0x10800 + 32*n + 4*m */
+#define FBNIC_TCE_RAM_TCAM_MASK			CSR_GENMASK(15, 0)
+#define FBNIC_TCE_RAM_TCAM_VALUE		CSR_GENMASK(31, 16)
+#define FBNIC_TCE_RAM_TCAM3(n)		(0x04218 + (n))	/* 0x010860 + 4*n */
+#define FBNIC_TCE_RAM_TCAM3_DEST_MASK		CSR_GENMASK(5, 3)
+#define FBNIC_TCE_RAM_TCAM3_MCQ_MASK		CSR_BIT(7)
+#define FBNIC_TCE_RAM_TCAM3_VALIDATE		CSR_BIT(31)
+#define FBNIC_CSR_END_TCE_RAM		0x0421F	/* CSR section delimiter */
+
 /* TMI registers */
 #define FBNIC_CSR_START_TMI		0x04400	/* CSR section delimiter */
 #define FBNIC_TMI_SOP_PROT_CTRL		0x04400		/* 0x11000 */
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index c08798fad203..fc7d80db5fa6 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -273,6 +273,7 @@ void __fbnic_set_rx_mode(struct net_device *netdev)
 	/* Write updates to hardware */
 	fbnic_write_rules(fbd);
 	fbnic_write_macda(fbd);
+	fbnic_write_tce_tcam(fbd);
 }
 
 static void fbnic_set_rx_mode(struct net_device *netdev)
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
index 337b8b3aef2f..908c098cd59e 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
@@ -587,6 +587,116 @@ static void fbnic_clear_act_tcam(struct fbnic_dev *fbd, unsigned int idx)
 		wr32(fbd, FBNIC_RPC_TCAM_ACT(idx, i), 0);
 }
 
+static void fbnic_clear_tce_tcam_entry(struct fbnic_dev *fbd, unsigned int idx)
+{
+	int i;
+
+	/* Invalidate entry and clear addr state info */
+	for (i = 0; i <= FBNIC_TCE_TCAM_WORD_LEN; i++)
+		wr32(fbd, FBNIC_TCE_RAM_TCAM(idx, i), 0);
+}
+
+static void fbnic_write_tce_tcam_dest(struct fbnic_dev *fbd, unsigned int idx,
+				      struct fbnic_mac_addr *mac_addr)
+{
+	u32 dest = FBNIC_TCE_TCAM_DEST_BMC;
+	u32 idx2dest_map;
+
+	if (is_multicast_ether_addr(mac_addr->value.addr8))
+		dest |= FBNIC_TCE_TCAM_DEST_MAC;
+
+	idx2dest_map = rd32(fbd, FBNIC_TCE_TCAM_IDX2DEST_MAP);
+	idx2dest_map &= ~(FBNIC_TCE_TCAM_IDX2DEST_MAP_DEST_ID_0 << (4 * idx));
+	idx2dest_map |= dest << (4 * idx);
+
+	wr32(fbd, FBNIC_TCE_TCAM_IDX2DEST_MAP, idx2dest_map);
+}
+
+static void fbnic_write_tce_tcam_entry(struct fbnic_dev *fbd, unsigned int idx,
+				       struct fbnic_mac_addr *mac_addr)
+{
+	__be16 *mask, *value;
+	int i;
+
+	mask = &mac_addr->mask.addr16[FBNIC_TCE_TCAM_WORD_LEN - 1];
+	value = &mac_addr->value.addr16[FBNIC_TCE_TCAM_WORD_LEN - 1];
+
+	for (i = 0; i < FBNIC_TCE_TCAM_WORD_LEN; i++)
+		wr32(fbd, FBNIC_TCE_RAM_TCAM(idx, i),
+		     FIELD_PREP(FBNIC_TCE_RAM_TCAM_MASK, ntohs(*mask--)) |
+		     FIELD_PREP(FBNIC_TCE_RAM_TCAM_VALUE, ntohs(*value--)));
+
+	wrfl(fbd);
+
+	wr32(fbd, FBNIC_TCE_RAM_TCAM3(idx), FBNIC_TCE_RAM_TCAM3_MCQ_MASK |
+				       FBNIC_TCE_RAM_TCAM3_DEST_MASK |
+				       FBNIC_TCE_RAM_TCAM3_VALIDATE);
+}
+
+static void __fbnic_write_tce_tcam_rev(struct fbnic_dev *fbd)
+{
+	int tcam_idx = FBNIC_TCE_TCAM_NUM_ENTRIES;
+	int mac_idx;
+
+	for (mac_idx = ARRAY_SIZE(fbd->mac_addr); mac_idx--;) {
+		struct fbnic_mac_addr *mac_addr = &fbd->mac_addr[mac_idx];
+
+		/* Verify BMC bit is set */
+		if (!test_bit(FBNIC_MAC_ADDR_T_BMC, mac_addr->act_tcam))
+			continue;
+
+		if (!tcam_idx) {
+			dev_err(fbd->dev, "TCE TCAM overflow\n");
+			return;
+		}
+
+		tcam_idx--;
+		fbnic_write_tce_tcam_dest(fbd, tcam_idx, mac_addr);
+		fbnic_write_tce_tcam_entry(fbd, tcam_idx, mac_addr);
+	}
+
+	while (tcam_idx)
+		fbnic_clear_tce_tcam_entry(fbd, --tcam_idx);
+
+	fbd->tce_tcam_last = tcam_idx;
+}
+
+static void __fbnic_write_tce_tcam(struct fbnic_dev *fbd)
+{
+	int tcam_idx = 0;
+	int mac_idx;
+
+	for (mac_idx = 0; mac_idx < ARRAY_SIZE(fbd->mac_addr); mac_idx++) {
+		struct fbnic_mac_addr *mac_addr = &fbd->mac_addr[mac_idx];
+
+		/* Verify BMC bit is set */
+		if (!test_bit(FBNIC_MAC_ADDR_T_BMC, mac_addr->act_tcam))
+			continue;
+
+		if (tcam_idx == FBNIC_TCE_TCAM_NUM_ENTRIES) {
+			dev_err(fbd->dev, "TCE TCAM overflow\n");
+			return;
+		}
+
+		fbnic_write_tce_tcam_dest(fbd, tcam_idx, mac_addr);
+		fbnic_write_tce_tcam_entry(fbd, tcam_idx, mac_addr);
+		tcam_idx++;
+	}
+
+	while (tcam_idx < FBNIC_TCE_TCAM_NUM_ENTRIES)
+		fbnic_clear_tce_tcam_entry(fbd, tcam_idx++);
+
+	fbd->tce_tcam_last = tcam_idx;
+}
+
+void fbnic_write_tce_tcam(struct fbnic_dev *fbd)
+{
+	if (fbd->tce_tcam_last)
+		__fbnic_write_tce_tcam_rev(fbd);
+	else
+		__fbnic_write_tce_tcam(fbd);
+}
+
 void fbnic_clear_rules(struct fbnic_dev *fbd)
 {
 	u32 dest = FIELD_PREP(FBNIC_RPC_ACT_TBL0_DEST_MASK,
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.h b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.h
index d62935f722a2..0d8285fa5b45 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.h
@@ -35,6 +35,9 @@ enum {
 #define FBNIC_RPC_TCAM_ACT_WORD_LEN		11
 #define FBNIC_RPC_TCAM_ACT_NUM_ENTRIES		64
 
+#define FBNIC_TCE_TCAM_WORD_LEN			3
+#define FBNIC_TCE_TCAM_NUM_ENTRIES		8
+
 struct fbnic_mac_addr {
 	union {
 		unsigned char addr8[ETH_ALEN];
@@ -186,4 +189,5 @@ static inline int __fbnic_mc_unsync(struct fbnic_mac_addr *mac_addr)
 
 void fbnic_clear_rules(struct fbnic_dev *fbd);
 void fbnic_write_rules(struct fbnic_dev *fbd);
+void fbnic_write_tce_tcam(struct fbnic_dev *fbd);
 #endif /* _FBNIC_RPC_H_ */
-- 
2.43.5


