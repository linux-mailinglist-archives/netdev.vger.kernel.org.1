Return-Path: <netdev+bounces-176414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA79DA6A282
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 10:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B1B9189BB65
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 09:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800E5221F03;
	Thu, 20 Mar 2025 09:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="02ggNpUa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3A92222D0
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 09:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742462650; cv=none; b=q1fy1uGKsdna1sQQG8AuaAytLQI/1RUYJssh4izmvdr6gHE7ru0uMTsQ8L7ONDfggz4LTp2Bur7h8pBjPnRb4m6hRne9w1WnhUMm8UfEEvvdKSPDFiBGt7LnVXO1ZDQEQyT77lQwB7QpEa6Ec8y2pYElrRMmF8mQYB+5Pa6cgNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742462650; c=relaxed/simple;
	bh=BCLMaCAqyDO9txNaovBkklP3qKIEfFWtvV6MSZrFb64=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fXKeS0+zWAVme4b0ChgBlLTPbpkaPUSu21x46vq6Dru4j5KnfHmS6o414BqFdtGzBDMlr4Fh5Qb1DjaEnXpddQc/Zk2rq5MNiu55NlAPLOehijf0fBKe8UXQSSjXcUYrLyiqO6B6J8Ai3z/sZdljp9uaIKDhNaov8ZOZ4KfFIJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=02ggNpUa; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e8be1c6ff8so1123350a12.1
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 02:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1742462646; x=1743067446; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yK0r94FjMshl77bvtbKzQPPYJ4shYcvi9U2kgl7uZ+g=;
        b=02ggNpUaQ10W7nis5kZJKlKybxDR0uv4DvEz1opgUvTbkT8aAbGh92g6pRJSS5iy+d
         Hhr4Ki95hMUaPzczuggWc1kEvALuZ4lWVknbKRttvcAaU3XoKuBGHfuRRutF82OrCuJB
         dCiEDoqYozaib3l5aL3PI8dbJ+rCJQVmxefxHtYa+AUr92E3COxFBGUBpD7vBWNWNJr3
         rNjxf3Mgu/VBQfyWEbJP9X8gSNPJUUNkLEqe9c9c6KVkOmkHQAAB1sSlKHIbnH3plbqZ
         H6WfUnxjpXPeOixybXPmxNLIfFqgcuQzsqUxq4h969ba6jK2Qxv5P3LiP+egWE/i12VM
         r15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742462646; x=1743067446;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yK0r94FjMshl77bvtbKzQPPYJ4shYcvi9U2kgl7uZ+g=;
        b=vxmr6zw2XRy3DeE5MCPWFkWxQnIe2QcmjBScXONNFQNC2zwoI2QLrTuVqZe1Rlejac
         FOJPhvWaFf+/AsFCNVLt9AJgyUfWPpN0CIMxLLqm16AfuPUNRjkmKdBXXtM8xbWUdjX5
         i2GmTD0dh1UI78wrr/ZlTRy14ZTuqYJdy3DqvzJQ0LY+dZ04KZkJnZc1eM+Vmu6BlQRT
         GBYnDe6p5A1p5dieTWPV4s8z2ip7Xy8XQQ9f32obzJ2eoiCODR3jAnRAJ2yxkD++VgzK
         WIzRtRWePHgOUol7x6aFQ+gLBEQ3b83/d8aVqTqEumNVKpQCkrtNvzY/4R0IN9YHCWVR
         I+DA==
X-Forwarded-Encrypted: i=1; AJvYcCU/opqyYMbIgM6NSkBvLp7t9PaxBGPZIiRz8AMp21HltGuNTbIOrYN6PRhYSJJJOhF4E1amaeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwueHaRdO/14fgznDvLi1W08QlMOt+hMrw19E6iuSbeJGlR2W6H
	jegNuAQqLExHF3IJCLF71N5syWddPof9pdfsvDbsPlf2RMrxiqmdzFntIqmQGpM=
X-Gm-Gg: ASbGncsTT4Iwx9KPG39YfQzpePzQwxsevRx5h2l3CsvzttNjNUl/nrwOJMUJyvE70Jx
	zH2VEJCVkkRkgCzZVwvBNcfF2tpZKGPTR1U55MS379W2/iCLVIrAPiUCHaF7AXNeIA17SqNskgY
	PFM0/6FOOA+Ah8rSDNj6orlp3etMDfCzZM36pUWOnVY3OIdLvZWTF5GOBqCeIcYzVCciLfm9Qw9
	NQASOmTgq/q9qOG9uP5ixdQ+LfEDwO9fZD/UFLjoWb7odA49BxKCTW3BM/JKV4qeV8Q+xdYqkVZ
	5It3oZGfIGU8ADFT+2KXaduZ4KyIt/+q7D+sVOfyAHpY3nMDv5NMFqeu9sEOl/OnBGWNTCsj3mF
	l1k8FjHZVlWmo
X-Google-Smtp-Source: AGHT+IE+tGW6D/E52DJBabXbD6zFAp6uTcSyuZA1ksYQ0CLFSMxi3VGuYzc5pWPJsBhA/iMNZ6e23A==
X-Received: by 2002:a05:6402:430d:b0:5e5:e1e2:327a with SMTP id 4fb4d7f45d1cf-5eba00bc6afmr2228793a12.23.1742462645389;
        Thu, 20 Mar 2025 02:24:05 -0700 (PDT)
Received: from wkz-x13.addiva.ad (h-79-136-22-50.NA.cust.bahnhof.se. [79.136.22.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816afe217sm10227451a12.80.2025.03.20.02.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 02:24:04 -0700 (PDT)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: marcin.s.wojtas@gmail.com,
	linux@armlinux.org.uk,
	andrew@lunn.ch,
	edumazet@google.com,
	pabeni@redhat.com,
	ezequiel.garcia@free-electrons.com,
	netdev@vger.kernel.org
Subject: [PATCH net] net: mvpp2: Prevent parser TCAM memory corruption
Date: Thu, 20 Mar 2025 10:17:00 +0100
Message-ID: <20250320092315.1936114-1-tobias@waldekranz.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Wires
Content-Transfer-Encoding: 8bit

Protect the parser TCAM/SRAM memory, and the cached (shadow) SRAM
information, from concurrent modifications.

Both the TCAM and SRAM tables are indirectly accessed by configuring
an index register that selects the row to read or write to. This means
that operations must be atomic in order to, e.g., avoid spreading
writes across multiple rows. Since the shadow SRAM array is used to
find free rows in the hardware table, it must also be protected in
order to avoid TOCTOU errors where multiple cores allocate the same
row.

This issue was detected in a situation where `mvpp2_set_rx_mode()` ran
concurrently on two CPUs. In this particular case the
MVPP2_PE_MAC_UC_PROMISCUOUS entry was corrupted, causing the
classifier unit to drop all incoming unicast - indicated by the
`rx_classifier_drops` counter.

Fixes: 3f518509dedc ("ethernet: Add new driver for Marvell Armada 375 network unit")
Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h    |   3 +
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   |   3 +-
 .../net/ethernet/marvell/mvpp2/mvpp2_prs.c    | 146 ++++++++++++++----
 3 files changed, 119 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
index 44fe9b68d1c2..a804a256dd07 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
@@ -1113,6 +1113,9 @@ struct mvpp2 {
 
 	/* Spinlocks for CM3 shared memory configuration */
 	spinlock_t mss_spinlock;
+
+	/* Spinlock for shared parser memory */
+	spinlock_t prs_spinlock;
 };
 
 struct mvpp2_pcpu_stats {
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index dd76c1b7ed3a..c63e5f1b168a 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -7722,8 +7722,9 @@ static int mvpp2_probe(struct platform_device *pdev)
 	if (mvpp2_read(priv, MVPP2_VER_ID_REG) == MVPP2_VER_PP23)
 		priv->hw_version = MVPP23;
 
-	/* Init mss lock */
+	/* Init locks for shared packet processor resources */
 	spin_lock_init(&priv->mss_spinlock);
+	spin_lock_init(&priv->prs_spinlock);
 
 	/* Initialize network controller */
 	err = mvpp2_init(pdev, priv);
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c
index 9af22f497a40..aa834153d99f 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c
@@ -43,8 +43,8 @@ static int mvpp2_prs_hw_write(struct mvpp2 *priv, struct mvpp2_prs_entry *pe)
 }
 
 /* Initialize tcam entry from hw */
-int mvpp2_prs_init_from_hw(struct mvpp2 *priv, struct mvpp2_prs_entry *pe,
-			   int tid)
+static int mvpp2_prs_init_from_hw_unlocked(struct mvpp2 *priv,
+					   struct mvpp2_prs_entry *pe, int tid)
 {
 	int i;
 
@@ -73,6 +73,19 @@ int mvpp2_prs_init_from_hw(struct mvpp2 *priv, struct mvpp2_prs_entry *pe,
 	return 0;
 }
 
+int mvpp2_prs_init_from_hw(struct mvpp2 *priv, struct mvpp2_prs_entry *pe,
+			   int tid)
+{
+	unsigned long flags;
+	int err;
+
+	spin_lock_irqsave(&priv->prs_spinlock, flags);
+	err = mvpp2_prs_init_from_hw_unlocked(priv, pe, tid);
+	spin_unlock_irqrestore(&priv->prs_spinlock, flags);
+
+	return err;
+}
+
 /* Invalidate tcam hw entry */
 static void mvpp2_prs_hw_inv(struct mvpp2 *priv, int index)
 {
@@ -374,7 +387,7 @@ static int mvpp2_prs_flow_find(struct mvpp2 *priv, int flow)
 		    priv->prs_shadow[tid].lu != MVPP2_PRS_LU_FLOWS)
 			continue;
 
-		mvpp2_prs_init_from_hw(priv, &pe, tid);
+		mvpp2_prs_init_from_hw_unlocked(priv, &pe, tid);
 		bits = mvpp2_prs_sram_ai_get(&pe);
 
 		/* Sram store classification lookup ID in AI bits [5:0] */
@@ -441,7 +454,7 @@ static void mvpp2_prs_mac_drop_all_set(struct mvpp2 *priv, int port, bool add)
 
 	if (priv->prs_shadow[MVPP2_PE_DROP_ALL].valid) {
 		/* Entry exist - update port only */
-		mvpp2_prs_init_from_hw(priv, &pe, MVPP2_PE_DROP_ALL);
+		mvpp2_prs_init_from_hw_unlocked(priv, &pe, MVPP2_PE_DROP_ALL);
 	} else {
 		/* Entry doesn't exist - create new */
 		memset(&pe, 0, sizeof(pe));
@@ -474,9 +487,12 @@ void mvpp2_prs_mac_promisc_set(struct mvpp2 *priv, int port,
 {
 	struct mvpp2_prs_entry pe;
 	unsigned char cast_match;
+	unsigned long flags;
 	unsigned int ri;
 	int tid;
 
+	spin_lock_irqsave(&priv->prs_spinlock, flags);
+
 	if (l2_cast == MVPP2_PRS_L2_UNI_CAST) {
 		cast_match = MVPP2_PRS_UCAST_VAL;
 		tid = MVPP2_PE_MAC_UC_PROMISCUOUS;
@@ -489,7 +505,7 @@ void mvpp2_prs_mac_promisc_set(struct mvpp2 *priv, int port,
 
 	/* promiscuous mode - Accept unknown unicast or multicast packets */
 	if (priv->prs_shadow[tid].valid) {
-		mvpp2_prs_init_from_hw(priv, &pe, tid);
+		mvpp2_prs_init_from_hw_unlocked(priv, &pe, tid);
 	} else {
 		memset(&pe, 0, sizeof(pe));
 		mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_MAC);
@@ -520,6 +536,8 @@ void mvpp2_prs_mac_promisc_set(struct mvpp2 *priv, int port,
 	mvpp2_prs_tcam_port_set(&pe, port, add);
 
 	mvpp2_prs_hw_write(priv, &pe);
+
+	spin_unlock_irqrestore(&priv->prs_spinlock, flags);
 }
 
 /* Set entry for dsa packets */
@@ -539,7 +557,7 @@ static void mvpp2_prs_dsa_tag_set(struct mvpp2 *priv, int port, bool add,
 
 	if (priv->prs_shadow[tid].valid) {
 		/* Entry exist - update port only */
-		mvpp2_prs_init_from_hw(priv, &pe, tid);
+		mvpp2_prs_init_from_hw_unlocked(priv, &pe, tid);
 	} else {
 		/* Entry doesn't exist - create new */
 		memset(&pe, 0, sizeof(pe));
@@ -610,7 +628,7 @@ static void mvpp2_prs_dsa_tag_ethertype_set(struct mvpp2 *priv, int port,
 
 	if (priv->prs_shadow[tid].valid) {
 		/* Entry exist - update port only */
-		mvpp2_prs_init_from_hw(priv, &pe, tid);
+		mvpp2_prs_init_from_hw_unlocked(priv, &pe, tid);
 	} else {
 		/* Entry doesn't exist - create new */
 		memset(&pe, 0, sizeof(pe));
@@ -673,7 +691,7 @@ static int mvpp2_prs_vlan_find(struct mvpp2 *priv, unsigned short tpid, int ai)
 		    priv->prs_shadow[tid].lu != MVPP2_PRS_LU_VLAN)
 			continue;
 
-		mvpp2_prs_init_from_hw(priv, &pe, tid);
+		mvpp2_prs_init_from_hw_unlocked(priv, &pe, tid);
 		match = mvpp2_prs_tcam_data_cmp(&pe, 0, tpid);
 		if (!match)
 			continue;
@@ -726,7 +744,7 @@ static int mvpp2_prs_vlan_add(struct mvpp2 *priv, unsigned short tpid, int ai,
 			    priv->prs_shadow[tid_aux].lu != MVPP2_PRS_LU_VLAN)
 				continue;
 
-			mvpp2_prs_init_from_hw(priv, &pe, tid_aux);
+			mvpp2_prs_init_from_hw_unlocked(priv, &pe, tid_aux);
 			ri_bits = mvpp2_prs_sram_ri_get(&pe);
 			if ((ri_bits & MVPP2_PRS_RI_VLAN_MASK) ==
 			    MVPP2_PRS_RI_VLAN_DOUBLE)
@@ -760,7 +778,7 @@ static int mvpp2_prs_vlan_add(struct mvpp2 *priv, unsigned short tpid, int ai,
 
 		mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_VLAN);
 	} else {
-		mvpp2_prs_init_from_hw(priv, &pe, tid);
+		mvpp2_prs_init_from_hw_unlocked(priv, &pe, tid);
 	}
 	/* Update ports' mask */
 	mvpp2_prs_tcam_port_map_set(&pe, port_map);
@@ -800,7 +818,7 @@ static int mvpp2_prs_double_vlan_find(struct mvpp2 *priv, unsigned short tpid1,
 		    priv->prs_shadow[tid].lu != MVPP2_PRS_LU_VLAN)
 			continue;
 
-		mvpp2_prs_init_from_hw(priv, &pe, tid);
+		mvpp2_prs_init_from_hw_unlocked(priv, &pe, tid);
 
 		match = mvpp2_prs_tcam_data_cmp(&pe, 0, tpid1) &&
 			mvpp2_prs_tcam_data_cmp(&pe, 4, tpid2);
@@ -849,7 +867,7 @@ static int mvpp2_prs_double_vlan_add(struct mvpp2 *priv, unsigned short tpid1,
 			    priv->prs_shadow[tid_aux].lu != MVPP2_PRS_LU_VLAN)
 				continue;
 
-			mvpp2_prs_init_from_hw(priv, &pe, tid_aux);
+			mvpp2_prs_init_from_hw_unlocked(priv, &pe, tid_aux);
 			ri_bits = mvpp2_prs_sram_ri_get(&pe);
 			ri_bits &= MVPP2_PRS_RI_VLAN_MASK;
 			if (ri_bits == MVPP2_PRS_RI_VLAN_SINGLE ||
@@ -880,7 +898,7 @@ static int mvpp2_prs_double_vlan_add(struct mvpp2 *priv, unsigned short tpid1,
 
 		mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_VLAN);
 	} else {
-		mvpp2_prs_init_from_hw(priv, &pe, tid);
+		mvpp2_prs_init_from_hw_unlocked(priv, &pe, tid);
 	}
 
 	/* Update ports' mask */
@@ -1941,7 +1959,7 @@ static int mvpp2_prs_vid_range_find(struct mvpp2_port *port, u16 vid, u16 mask)
 		    port->priv->prs_shadow[tid].lu != MVPP2_PRS_LU_VID)
 			continue;
 
-		mvpp2_prs_init_from_hw(port->priv, &pe, tid);
+		mvpp2_prs_init_from_hw_unlocked(port->priv, &pe, tid);
 
 		mvpp2_prs_tcam_data_byte_get(&pe, 2, &byte[0], &enable[0]);
 		mvpp2_prs_tcam_data_byte_get(&pe, 3, &byte[1], &enable[1]);
@@ -1966,10 +1984,13 @@ int mvpp2_prs_vid_entry_add(struct mvpp2_port *port, u16 vid)
 	unsigned int mask = 0xfff, reg_val, shift;
 	struct mvpp2 *priv = port->priv;
 	struct mvpp2_prs_entry pe;
+	unsigned long flags;
 	int tid;
 
 	memset(&pe, 0, sizeof(pe));
 
+	spin_lock_irqsave(&priv->prs_spinlock, flags);
+
 	/* Scan TCAM and see if entry with this <vid,port> already exist */
 	tid = mvpp2_prs_vid_range_find(port, vid, mask);
 
@@ -1988,8 +2009,10 @@ int mvpp2_prs_vid_entry_add(struct mvpp2_port *port, u16 vid)
 						MVPP2_PRS_VLAN_FILT_MAX_ENTRY);
 
 		/* There isn't room for a new VID filter */
-		if (tid < 0)
+		if (tid < 0) {
+			spin_unlock_irqrestore(&priv->prs_spinlock, flags);
 			return tid;
+		}
 
 		mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_VID);
 		pe.index = tid;
@@ -1997,7 +2020,7 @@ int mvpp2_prs_vid_entry_add(struct mvpp2_port *port, u16 vid)
 		/* Mask all ports */
 		mvpp2_prs_tcam_port_map_set(&pe, 0);
 	} else {
-		mvpp2_prs_init_from_hw(priv, &pe, tid);
+		mvpp2_prs_init_from_hw_unlocked(priv, &pe, tid);
 	}
 
 	/* Enable the current port */
@@ -2019,6 +2042,7 @@ int mvpp2_prs_vid_entry_add(struct mvpp2_port *port, u16 vid)
 	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_VID);
 	mvpp2_prs_hw_write(priv, &pe);
 
+	spin_unlock_irqrestore(&priv->prs_spinlock, flags);
 	return 0;
 }
 
@@ -2026,25 +2050,30 @@ int mvpp2_prs_vid_entry_add(struct mvpp2_port *port, u16 vid)
 void mvpp2_prs_vid_entry_remove(struct mvpp2_port *port, u16 vid)
 {
 	struct mvpp2 *priv = port->priv;
+	unsigned long flags;
 	int tid;
 
-	/* Scan TCAM and see if entry with this <vid,port> already exist */
-	tid = mvpp2_prs_vid_range_find(port, vid, 0xfff);
+	spin_lock_irqsave(&priv->prs_spinlock, flags);
 
-	/* No such entry */
-	if (tid < 0)
-		return;
+	/* Invalidate TCAM entry with this <vid,port>, if it exists */
+	tid = mvpp2_prs_vid_range_find(port, vid, 0xfff);
+	if (tid >= 0) {
+		mvpp2_prs_hw_inv(priv, tid);
+		priv->prs_shadow[tid].valid = false;
+	}
 
-	mvpp2_prs_hw_inv(priv, tid);
-	priv->prs_shadow[tid].valid = false;
+	spin_unlock_irqrestore(&priv->prs_spinlock, flags);
 }
 
 /* Remove all existing VID filters on this port */
 void mvpp2_prs_vid_remove_all(struct mvpp2_port *port)
 {
 	struct mvpp2 *priv = port->priv;
+	unsigned long flags;
 	int tid;
 
+	spin_lock_irqsave(&priv->prs_spinlock, flags);
+
 	for (tid = MVPP2_PRS_VID_PORT_FIRST(port->id);
 	     tid <= MVPP2_PRS_VID_PORT_LAST(port->id); tid++) {
 		if (priv->prs_shadow[tid].valid) {
@@ -2052,6 +2081,8 @@ void mvpp2_prs_vid_remove_all(struct mvpp2_port *port)
 			priv->prs_shadow[tid].valid = false;
 		}
 	}
+
+	spin_unlock_irqrestore(&priv->prs_spinlock, flags);
 }
 
 /* Remove VID filering entry for this port */
@@ -2059,11 +2090,16 @@ void mvpp2_prs_vid_disable_filtering(struct mvpp2_port *port)
 {
 	unsigned int tid = MVPP2_PRS_VID_PORT_DFLT(port->id);
 	struct mvpp2 *priv = port->priv;
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->prs_spinlock, flags);
 
 	/* Invalidate the guard entry */
 	mvpp2_prs_hw_inv(priv, tid);
 
 	priv->prs_shadow[tid].valid = false;
+
+	spin_unlock_irqrestore(&priv->prs_spinlock, flags);
 }
 
 /* Add guard entry that drops packets when no VID is matched on this port */
@@ -2073,12 +2109,15 @@ void mvpp2_prs_vid_enable_filtering(struct mvpp2_port *port)
 	struct mvpp2 *priv = port->priv;
 	unsigned int reg_val, shift;
 	struct mvpp2_prs_entry pe;
+	unsigned long flags;
 
 	if (priv->prs_shadow[tid].valid)
 		return;
 
 	memset(&pe, 0, sizeof(pe));
 
+	spin_lock_irqsave(&priv->prs_spinlock, flags);
+
 	pe.index = tid;
 
 	reg_val = mvpp2_read(priv, MVPP2_MH_REG(port->id));
@@ -2111,6 +2150,8 @@ void mvpp2_prs_vid_enable_filtering(struct mvpp2_port *port)
 	/* Update shadow table */
 	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_VID);
 	mvpp2_prs_hw_write(priv, &pe);
+
+	spin_unlock_irqrestore(&priv->prs_spinlock, flags);
 }
 
 /* Parser default initialization */
@@ -2217,7 +2258,7 @@ mvpp2_prs_mac_da_range_find(struct mvpp2 *priv, int pmap, const u8 *da,
 		    (priv->prs_shadow[tid].udf != udf_type))
 			continue;
 
-		mvpp2_prs_init_from_hw(priv, &pe, tid);
+		mvpp2_prs_init_from_hw_unlocked(priv, &pe, tid);
 		entry_pmap = mvpp2_prs_tcam_port_map_get(&pe);
 
 		if (mvpp2_prs_mac_range_equals(&pe, da, mask) &&
@@ -2229,7 +2270,8 @@ mvpp2_prs_mac_da_range_find(struct mvpp2 *priv, int pmap, const u8 *da,
 }
 
 /* Update parser's mac da entry */
-int mvpp2_prs_mac_da_accept(struct mvpp2_port *port, const u8 *da, bool add)
+static int mvpp2_prs_mac_da_accept_unlocked(struct mvpp2_port *port,
+					    const u8 *da, bool add)
 {
 	unsigned char mask[ETH_ALEN] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
 	struct mvpp2 *priv = port->priv;
@@ -2261,7 +2303,7 @@ int mvpp2_prs_mac_da_accept(struct mvpp2_port *port, const u8 *da, bool add)
 		/* Mask all ports */
 		mvpp2_prs_tcam_port_map_set(&pe, 0);
 	} else {
-		mvpp2_prs_init_from_hw(priv, &pe, tid);
+		mvpp2_prs_init_from_hw_unlocked(priv, &pe, tid);
 	}
 
 	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_MAC);
@@ -2317,6 +2359,18 @@ int mvpp2_prs_mac_da_accept(struct mvpp2_port *port, const u8 *da, bool add)
 	return 0;
 }
 
+int mvpp2_prs_mac_da_accept(struct mvpp2_port *port, const u8 *da, bool add)
+{
+	unsigned long flags;
+	int err;
+
+	spin_lock_irqsave(&port->priv->prs_spinlock, flags);
+	err = mvpp2_prs_mac_da_accept_unlocked(port, da, add);
+	spin_unlock_irqrestore(&port->priv->prs_spinlock, flags);
+
+	return err;
+}
+
 int mvpp2_prs_update_mac_da(struct net_device *dev, const u8 *da)
 {
 	struct mvpp2_port *port = netdev_priv(dev);
@@ -2342,9 +2396,11 @@ void mvpp2_prs_mac_del_all(struct mvpp2_port *port)
 {
 	struct mvpp2 *priv = port->priv;
 	struct mvpp2_prs_entry pe;
-	unsigned long pmap;
+	unsigned long flags, pmap;
 	int index, tid;
 
+	spin_lock_irqsave(&priv->prs_spinlock, flags);
+
 	for (tid = MVPP2_PE_MAC_RANGE_START;
 	     tid <= MVPP2_PE_MAC_RANGE_END; tid++) {
 		unsigned char da[ETH_ALEN], da_mask[ETH_ALEN];
@@ -2354,7 +2410,7 @@ void mvpp2_prs_mac_del_all(struct mvpp2_port *port)
 		    (priv->prs_shadow[tid].udf != MVPP2_PRS_UDF_MAC_DEF))
 			continue;
 
-		mvpp2_prs_init_from_hw(priv, &pe, tid);
+		mvpp2_prs_init_from_hw_unlocked(priv, &pe, tid);
 
 		pmap = mvpp2_prs_tcam_port_map_get(&pe);
 
@@ -2375,14 +2431,19 @@ void mvpp2_prs_mac_del_all(struct mvpp2_port *port)
 			continue;
 
 		/* Remove entry from TCAM */
-		mvpp2_prs_mac_da_accept(port, da, false);
+		mvpp2_prs_mac_da_accept_unlocked(port, da, false);
 	}
+
+	spin_unlock_irqrestore(&priv->prs_spinlock, flags);
 }
 
 int mvpp2_prs_tag_mode_set(struct mvpp2 *priv, int port, int type)
 {
+	unsigned long flags;
+
 	switch (type) {
 	case MVPP2_TAG_TYPE_EDSA:
+		spin_lock_irqsave(&priv->prs_spinlock, flags);
 		/* Add port to EDSA entries */
 		mvpp2_prs_dsa_tag_set(priv, port, true,
 				      MVPP2_PRS_TAGGED, MVPP2_PRS_EDSA);
@@ -2393,9 +2454,11 @@ int mvpp2_prs_tag_mode_set(struct mvpp2 *priv, int port, int type)
 				      MVPP2_PRS_TAGGED, MVPP2_PRS_DSA);
 		mvpp2_prs_dsa_tag_set(priv, port, false,
 				      MVPP2_PRS_UNTAGGED, MVPP2_PRS_DSA);
+		spin_unlock_irqrestore(&priv->prs_spinlock, flags);
 		break;
 
 	case MVPP2_TAG_TYPE_DSA:
+		spin_lock_irqsave(&priv->prs_spinlock, flags);
 		/* Add port to DSA entries */
 		mvpp2_prs_dsa_tag_set(priv, port, true,
 				      MVPP2_PRS_TAGGED, MVPP2_PRS_DSA);
@@ -2406,10 +2469,12 @@ int mvpp2_prs_tag_mode_set(struct mvpp2 *priv, int port, int type)
 				      MVPP2_PRS_TAGGED, MVPP2_PRS_EDSA);
 		mvpp2_prs_dsa_tag_set(priv, port, false,
 				      MVPP2_PRS_UNTAGGED, MVPP2_PRS_EDSA);
+		spin_unlock_irqrestore(&priv->prs_spinlock, flags);
 		break;
 
 	case MVPP2_TAG_TYPE_MH:
 	case MVPP2_TAG_TYPE_NONE:
+		spin_lock_irqsave(&priv->prs_spinlock, flags);
 		/* Remove port form EDSA and DSA entries */
 		mvpp2_prs_dsa_tag_set(priv, port, false,
 				      MVPP2_PRS_TAGGED, MVPP2_PRS_DSA);
@@ -2419,6 +2484,7 @@ int mvpp2_prs_tag_mode_set(struct mvpp2 *priv, int port, int type)
 				      MVPP2_PRS_TAGGED, MVPP2_PRS_EDSA);
 		mvpp2_prs_dsa_tag_set(priv, port, false,
 				      MVPP2_PRS_UNTAGGED, MVPP2_PRS_EDSA);
+		spin_unlock_irqrestore(&priv->prs_spinlock, flags);
 		break;
 
 	default:
@@ -2433,15 +2499,20 @@ int mvpp2_prs_add_flow(struct mvpp2 *priv, int flow, u32 ri, u32 ri_mask)
 {
 	struct mvpp2_prs_entry pe;
 	u8 *ri_byte, *ri_byte_mask;
+	unsigned long flags;
 	int tid, i;
 
 	memset(&pe, 0, sizeof(pe));
 
+	spin_lock_irqsave(&priv->prs_spinlock, flags);
+
 	tid = mvpp2_prs_tcam_first_free(priv,
 					MVPP2_PE_LAST_FREE_TID,
 					MVPP2_PE_FIRST_FREE_TID);
-	if (tid < 0)
+	if (tid < 0) {
+		spin_unlock_irqrestore(&priv->prs_spinlock, flags);
 		return tid;
+	}
 
 	pe.index = tid;
 
@@ -2461,6 +2532,7 @@ int mvpp2_prs_add_flow(struct mvpp2 *priv, int flow, u32 ri, u32 ri_mask)
 	mvpp2_prs_tcam_port_map_set(&pe, MVPP2_PRS_PORT_MASK);
 	mvpp2_prs_hw_write(priv, &pe);
 
+	spin_unlock_irqrestore(&priv->prs_spinlock, flags);
 	return 0;
 }
 
@@ -2468,10 +2540,13 @@ int mvpp2_prs_add_flow(struct mvpp2 *priv, int flow, u32 ri, u32 ri_mask)
 int mvpp2_prs_def_flow(struct mvpp2_port *port)
 {
 	struct mvpp2_prs_entry pe;
+	unsigned long flags;
 	int tid;
 
 	memset(&pe, 0, sizeof(pe));
 
+	spin_lock_irqsave(&port->priv->prs_spinlock, flags);
+
 	tid = mvpp2_prs_flow_find(port->priv, port->id);
 
 	/* Such entry not exist */
@@ -2480,8 +2555,10 @@ int mvpp2_prs_def_flow(struct mvpp2_port *port)
 		tid = mvpp2_prs_tcam_first_free(port->priv,
 						MVPP2_PE_LAST_FREE_TID,
 					       MVPP2_PE_FIRST_FREE_TID);
-		if (tid < 0)
+		if (tid < 0) {
+			spin_unlock_irqrestore(&port->priv->prs_spinlock, flags);
 			return tid;
+		}
 
 		pe.index = tid;
 
@@ -2492,28 +2569,33 @@ int mvpp2_prs_def_flow(struct mvpp2_port *port)
 		/* Update shadow table */
 		mvpp2_prs_shadow_set(port->priv, pe.index, MVPP2_PRS_LU_FLOWS);
 	} else {
-		mvpp2_prs_init_from_hw(port->priv, &pe, tid);
+		mvpp2_prs_init_from_hw_unlocked(port->priv, &pe, tid);
 	}
 
 	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_FLOWS);
 	mvpp2_prs_tcam_port_map_set(&pe, (1 << port->id));
 	mvpp2_prs_hw_write(port->priv, &pe);
 
+	spin_unlock_irqrestore(&port->priv->prs_spinlock, flags);
 	return 0;
 }
 
 int mvpp2_prs_hits(struct mvpp2 *priv, int index)
 {
+	unsigned long flags;
 	u32 val;
 
 	if (index > MVPP2_PRS_TCAM_SRAM_SIZE)
 		return -EINVAL;
 
+	spin_lock_irqsave(&priv->prs_spinlock, flags);
+
 	mvpp2_write(priv, MVPP2_PRS_TCAM_HIT_IDX_REG, index);
 
 	val = mvpp2_read(priv, MVPP2_PRS_TCAM_HIT_CNT_REG);
 
 	val &= MVPP2_PRS_TCAM_HIT_CNT_MASK;
 
+	spin_unlock_irqrestore(&priv->prs_spinlock, flags);
 	return val;
 }
-- 
2.43.0


