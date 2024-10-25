Return-Path: <netdev+bounces-139250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E22CA9B1302
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 00:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07DD01C223ED
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 22:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FA31D90C8;
	Fri, 25 Oct 2024 22:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nm2LCtJ1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CF91D3628
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 22:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729897166; cv=none; b=cRM1+j+DJ/bHlYtFSYr69To/IwkoqxKa+ceEkrHftBjL9KMe7AjMnEllvc3pny+n76T+n8Xm8Se5x/h3iuWMR7CMyNHYRbrhMh3JRz2EHnAWdcMbKlBGBeWwHRkTBPIu0HS68qp7T7IEFUPL2TVegsAYifQQBILDLwf+fTwIgS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729897166; c=relaxed/simple;
	bh=gI8scchsw12WTrorSmiIgTr6EA0m2tEoISIt8mfqT2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e1fSvFT9nfiJ2OZxsz3FHhl8XineNxYQoozpS/+jx/SjOofz09OgDGjbED1h8+Bth/jpAnulZOg6hrGxP3Dub0JgbtI/tEoYD3djrI66jmvAZYpXyGkg4Xb0X1/48WttGrpwha6HfaN6Tb8WNN1re7+NQBBJCfF1IVT8TGI8xfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nm2LCtJ1; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43155abaf0bso25234365e9.0
        for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 15:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729897161; x=1730501961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w//Vkekr1IAyidnz6kyDQuv/UgqhE3tG9STQJZumHjs=;
        b=nm2LCtJ1MJYRQSN3WzqDC8V1TIujywSQmErwM61tKS+1lZtHzeC1RM/aaPXEw8dQqz
         MIDG1HjmQ+H6k0OzCTCaSOp5tjArFSC/1MVULNMtu30KVtzhGXmU1mYaRSykqAwxn7M/
         EZ70t+aj4VDJm/vl193s1YHkljUMAke1qUAPaUdU+7DKg/oGYbSy+zTU+JbWslmALPE5
         ExP3Z8FviVVe8gCqAsALWspWIqxDnzwKGtCdamrrkYbJkYhY8yeR5EzpssNaWkFLOB6R
         I8yEm/AAkGLeHvmpKun7AW88set2LeZoSsPj31sYaS0YWWikQp3otrg77THOxX0IQqVM
         QOaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729897161; x=1730501961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w//Vkekr1IAyidnz6kyDQuv/UgqhE3tG9STQJZumHjs=;
        b=HuYhT3mfjwGnDeMqK0TsZdm7EdvjbZye0z58+uqfNk6CO9I5kA/gLBNufVGEpfJudo
         g0cZla/xS/YFQFSe8NoUrUUkp3I8BivjH+VaAqaQnQBCO1hVAI1rajUxBXHtcx0p+zGi
         TRueNjWUetpwjpHsm7fHmAWIu3dGrN5NsO92Bmcow1LkRA3i5qYk+kMJI6CbeUzoz9iP
         vDywEwtmqVkHkpwh+aqRp4i/VFLEa0/Iqy7CBGJFiAkPKInf5XYyzTRjCcx6D428e+l3
         +MvxqDWS+G65RmqwqI8ayZNRh3JezeLGKutIxbcU2VCOXHsBhI3Rv+FXo1LeZqUEDB1V
         l4tQ==
X-Gm-Message-State: AOJu0YwejXsGWwU+tAqLsZ7u0x0MQmJCF+gs6hfzxVh8qMOhdRzcbs8f
	dfCOeRext+UXSvAda47AFJJ9K/t0LQokqNGdDA9PMlcs3XGkA1GUdGvqAg==
X-Google-Smtp-Source: AGHT+IE7hoLHhsuK54E0doeDy34aVWo6zGse164xVMRpQhHjtT4DfwD+APLyifVm5Qu9IcMa2ee9RA==
X-Received: by 2002:adf:fa83:0:b0:37c:d299:b5f0 with SMTP id ffacd0b85a97d-3806120c614mr511397f8f.59.1729897160951;
        Fri, 25 Oct 2024 15:59:20 -0700 (PDT)
Received: from localhost (fwdproxy-cln-010.fbsv.net. [2a03:2880:31ff:a::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b1c8a9sm2692292f8f.12.2024.10.25.15.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 15:59:20 -0700 (PDT)
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
	mohsin.bashr@gmail.com
Subject: [PATCH net-next v3] eth: fbnic: Add support to write TCE TCAM entries
Date: Fri, 25 Oct 2024 15:59:10 -0700
Message-ID: <20241025225910.30187-1-mohsin.bashr@gmail.com>
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
or deleting entries does not affect the availability of all entries,
assuming there is no significant reordering of entries.

Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
V3:
- Declare loop iterator in loop declaration
- Use unsigned type where possible

V2: https://lore.kernel.org/netdev/20241024223135.310733-1-mohsin.bashr@gmail.com
V1: https://lore.kernel.org/netdev/20241021185544.713305-1-mohsin.bashr@gmail.com
---
 drivers/net/ethernet/meta/fbnic/fbnic.h       |   1 +
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |  20 ++++
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |   1 +
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c   | 105 ++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.h   |   4 +
 5 files changed, 131 insertions(+)

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
index 337b8b3aef2f..79ddbf305127 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
@@ -587,6 +587,111 @@ static void fbnic_clear_act_tcam(struct fbnic_dev *fbd, unsigned int idx)
 		wr32(fbd, FBNIC_RPC_TCAM_ACT(idx, i), 0);
 }
 
+static void fbnic_clear_tce_tcam_entry(struct fbnic_dev *fbd, unsigned int idx)
+{
+	/* Invalidate entry and clear addr state info */
+	for (u32 i = 0; i <= FBNIC_TCE_TCAM_WORD_LEN; i++)
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
+
+	mask = &mac_addr->mask.addr16[FBNIC_TCE_TCAM_WORD_LEN - 1];
+	value = &mac_addr->value.addr16[FBNIC_TCE_TCAM_WORD_LEN - 1];
+
+	for (u32 i = 0; i < FBNIC_TCE_TCAM_WORD_LEN; i++)
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
+
+	for (u32 mac_idx = ARRAY_SIZE(fbd->mac_addr); mac_idx--;) {
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
+
+	for (u32 mac_idx = 0; mac_idx < ARRAY_SIZE(fbd->mac_addr); mac_idx++) {
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


