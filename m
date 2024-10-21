Return-Path: <netdev+bounces-137617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D23119A72AF
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 20:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E21F1F22716
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 18:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5945C1FB3D0;
	Mon, 21 Oct 2024 18:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvwgRyQA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F231FAC31
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 18:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729536962; cv=none; b=AjFO7793WSH9fcj6UQrqo72yjBTAS7Ifl/fLNxDzkZuLZu0CaMwVIXiOYZVC0aZcHoaJ1NO/1b+hH5C52ohcLwvd3w/snQ3QUHB5YXZdgWr5TouSzq+s84j9IFV2g8mRg9hgyp3wjFlBT3ZnA+nXEE09UFcPZWIs9avPuVRNvpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729536962; c=relaxed/simple;
	bh=w9Zrs9d8/Ed9yVK9I1Ah5OAVaelT3ecV85j/hqCRaAU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sh82erk0F/m3pr82b3CnKTdY7L5U178CrwgyWKf1GAdjlgztSpaVxYPhX3FYTwSF3e7cps9ZWVSS1tKmnjksTcMsKEkA0FtEpv9bAD1t2tFWnaoEAMmQhm6GtQhi2X9h5eglt/YNg1Ekw3xlD02YO20nu4NHFEPh2sIyrL8+j6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EvwgRyQA; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4315baa51d8so47531425e9.0
        for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 11:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729536958; x=1730141758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/wKrzcbhNCfaTftpiLlZQP8/9PsJgPmODc+798NHLA0=;
        b=EvwgRyQAnd1K8kBecbUZSinlO0O39jxbHp6G1KDX8i73lqjBaIzwe8qLGVYb5J2uy5
         kTSgc4K0XW2Ravy2q3FFaVl5J7wIVBKlql8+Mypvh1VPeu6yjLNb3+A2bk0h9MzP3noG
         2L8ASNT8sCB2m6vzDV4X7sQ8pEQLgEHWSV8xlDEALzyK+B7+eUPjDXbMugK4Skam70sF
         P3LNfmyjUbjlujjlOWzlyLozS8et7gMZfANHY850DwEo5bO8OtvEGjMDxGoAKNA2QyoY
         N5flfUVreP1hTl7aO9zxdd1KLX3kub2gX/0kGL8Z2VgdSEoNfkKkAq5kZHxRMm4rXKAY
         853A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729536958; x=1730141758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/wKrzcbhNCfaTftpiLlZQP8/9PsJgPmODc+798NHLA0=;
        b=d/F9cRGDhA8zKenWD1foeyirz7moTLwW/PTjhMI4FCbl6/5qTB2H1uDhvNRuyFzNAg
         M8PLNTqdPU170HMSzzKvKDKdn7zEIfAdjdaN6lakM/4YE08BqHeduDYubT91HeRnvIlw
         s+Oy32hj26T0BgMI2wiprfgMJuYiFMc7V///etDPJwgGns7AaAa4f2ZwEdHRxct8fC8R
         SlXlmW4c+xwq9F5tQtT7GxOQuMdioSdZd4sRwGv4leudCXnIWZqr7z+imDtVAItsdiFH
         xayxPw5zf7cTcF9m+iC0TqZgKRtddAhXYZcNS0y5uMT6754mvGRvWOqhzCnMqJB6Zt1l
         YYXQ==
X-Gm-Message-State: AOJu0YxC5p2O7ZBgwaFlqpZrYNP0CWkPOQhHHXxaGoXHd4pZFn6p2uT9
	asFiXEh7n2W3u1ry4sK8wwYKStXPrhkAt6+rBnVdMV4TEFXdSwbRM6fRtw==
X-Google-Smtp-Source: AGHT+IFjqcZR21uDBi1MDecReF9l7QKUcDXlucGKPyMu8RKLr6dLU9GFICApCkSgHl/27u7aoC22TQ==
X-Received: by 2002:adf:f64f:0:b0:37c:cc96:d1ce with SMTP id ffacd0b85a97d-37ef214d505mr111379f8f.24.1729536957696;
        Mon, 21 Oct 2024 11:55:57 -0700 (PDT)
Received: from localhost (fwdproxy-cln-030.fbsv.net. [2a03:2880:31ff:1e::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b9bf8esm4909776f8f.110.2024.10.21.11.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 11:55:57 -0700 (PDT)
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
	vadim.fedorenko@linux.dev,
	mohsin.bashr@gmail.com
Subject: [PATCH net-next] eth: fbnic: Add support to write TCE TCAM entries
Date: Mon, 21 Oct 2024 11:55:44 -0700
Message-ID: <20241021185544.713305-1-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for writing to the tce tcam to enable host to bmc traffic.
Currently, we lack metadata to track where addresses have been written
in the tcam, except for the last entry written. To address this issue,
we start at the opposite end of the table in each pass, so that adding
or deleting entries does not affect the availability of all entrie,
assuming there is no significant reordering of entries.

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


