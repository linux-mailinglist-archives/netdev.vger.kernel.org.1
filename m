Return-Path: <netdev+bounces-141389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE539BAB1D
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 04:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4665C282111
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 03:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D87B175D32;
	Mon,  4 Nov 2024 03:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRzod3Ix"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DBC16C687
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 03:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730689992; cv=none; b=pPmqL1lDXyanJcvZGuwVi1aWj+GBKiTsPimj1uggUK9SQ3aW4WGonJ2WJjcXWqOynrYP7YLiRc5tQaztD74DO8otdJ8tI2k6GBMHV4Kg4vOuLMyBEktiFVGYsOLagQvrZWQCWx83pDoaRpDwiTFqiFRY+fAnGAOf5YTO5xtdxUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730689992; c=relaxed/simple;
	bh=qJ94Op8/FuO0I5GkkZ/tRJXufyN6tdieOjXkie31TK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TcMi+edlt5gLnvTQXM5Gc1mHQH2qgEZ6LYK0vMa5EETxAJFkybqUSGtlvxsP+LIuV6cREJO8jpEkp0XYUQIddOmNMQEZL3UlsOmHRD0pXtQg74u+EAH3Cyullm7PhYgbhsenLbNiB1WL88fidNnzlkBWkMtA6AxJsAPJFPkeaok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cRzod3Ix; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37d462c91a9so2247179f8f.2
        for <netdev@vger.kernel.org>; Sun, 03 Nov 2024 19:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730689989; x=1731294789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ogghBf1QvPtru9x8zIGpD5+u3QifNvnK9ROBLtc0yj8=;
        b=cRzod3IxKto4ZfV0ryAU5k5w03TWTPQpAt3evLe4uGthqToeTi3AV3FuNMgYrUDoJ6
         VV0vGKH5jWMZ1s0PBkaBHOH/HMK3Pye8LJw4zSL6RkuwveYLbcm9+1fOj5snFQplNJMc
         eBG2f75sfX3zL1wozltJhu3QDML//SnKG8xWj5Wi5fvRFaTtoP+962cVfRYn1qdNua2U
         mmpg7j68jBlabL2/nxeZ6865WTUwAiz39W5VBkwXTbUnX/5y3NWtnNKF5VhQyiILKTN/
         QVxbTn73A6LxmJR3jKHnl8OeOsL2e+DRYdlIsPVbRoBeR7gTpnIfuu05qx6tiNVGaJBR
         tZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730689989; x=1731294789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ogghBf1QvPtru9x8zIGpD5+u3QifNvnK9ROBLtc0yj8=;
        b=L6zPahZCp1R2xPHEovtY7H+BA1uzRXZr/ExCoIQj90f7B1rK/upoCaXNW6JKIOIjP/
         GCjiSdbCf+UHlxDymIi9iq83/a2Ooe7v4YIoTD+nPo76vBQAA0Y1WupKf23eDujqi4Z6
         nD9YO6qa03HWCk8N2xITltAOIRbrqMVQgkfwM6GbMhOyasDqFR1BzBDo+TDZ/ptMPVsj
         5FnTRFKlv+mziyiJVQvk6bn8NV/T49un4IlU9RRVsILCuMkBdcEKMJI1BuHlTHyZIYTm
         tGzZqOWhzYaI56wZEgTS8qsCyZo5IAN48UV7wULY6ge5hT1RwhR9//RQUOUQx51S6QJe
         Yhkg==
X-Gm-Message-State: AOJu0Yw1o+3BW3ivSXJArBiztq9oNF47ZvVLIB1DaR7X/pGam/rAN3S9
	74W6Tmn4+EmciSx2i99BskLFYiaauM8trkCkIz4lpnEFDtgcZ8HOjwe/u6BB
X-Google-Smtp-Source: AGHT+IHpciZxOQ2KPiv4VPWcW7NknS2pHoK85cJEftCDBBczyxdxpGuvJuVRXUbRCaNwDJSnyH6mHA==
X-Received: by 2002:a05:6000:118c:b0:374:c4c2:fc23 with SMTP id ffacd0b85a97d-381b710f70bmr12344265f8f.56.1730689988311;
        Sun, 03 Nov 2024 19:13:08 -0800 (PST)
Received: from localhost (fwdproxy-cln-000.fbsv.net. [2a03:2880:31ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7e2dsm11939923f8f.11.2024.11.03.19.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 19:13:06 -0800 (PST)
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
Subject: [PATCH net-next v5] eth: fbnic: Add support to write TCE TCAM entries
Date: Sun,  3 Nov 2024 19:13:00 -0800
Message-ID: <20241104031300.1330657-1-mohsin.bashr@gmail.com>
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

Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
V5: Add sign off at the right place
V4: https://lore.kernel.org/netdev/20241101204116.1368328-1-mohsin.bashr@gmail.com
V3: https://lore.kernel.org/netdev/20241025225910.30187-1-mohsin.bashr@gmail.com
V2: https://lore.kernel.org/netdev/20241024223135.310733-1-mohsin.bashr@gmail.com
V1: https://lore.kernel.org/netdev/20241021185544.713305-1-mohsin.bashr@gmail.com
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


