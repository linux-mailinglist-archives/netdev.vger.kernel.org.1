Return-Path: <netdev+bounces-177910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA31A72DDE
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 11:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 062E47A34BA
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 10:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1F612CDA5;
	Thu, 27 Mar 2025 10:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="E5F+xDJh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD02F20E6E6
	for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 10:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743071574; cv=none; b=e0Z90VJUSSca5/u2gcjrURi7KVkNk+a2YMVSVSddUj429PHsN9CiGQ5TZfWg+vUvjd6JSqtFn3upbQ7+GIrOPrMF7uV9zuTIyV2yUhCx+K7eJL2nQMK+DS1GTY5fz4hi0dD3hSZfy0E3vM+Nj4FlAUJKIZZt+NW2vaDgHmYNl0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743071574; c=relaxed/simple;
	bh=2mUxdJ21uHwG7x1sBe82EJ6MQeTlB0WPIWRD8a9ondY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jra1ytwQRzRn0gW7j6YNJ4Z+c6BK2Qy7x4BAQ3THYlqUqcTM73bjmv3cnncPbpWTuT2xtoiVA17R06TtUTiukTdrhFMzBroxbq44kWxmHa8mfhhwqueojJrRmndZu8U635m/pfKCdyV8H0u2ZSmF1YKuOFoSEEz62rXdv+ujTvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=E5F+xDJh; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac345bd8e13so138385766b.0
        for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 03:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1743071570; x=1743676370; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QwXK89mxSdfmuJR1/wg5oQtNJQj1cM7/gY8WIAvqtd0=;
        b=E5F+xDJhAkrW8iPoB8HtGQXqJsUpRRL85qiiXoMA0GGI39THO2YHOblsoewpK2PzqS
         5G+y01HBfuqajfKX3bFHGptxFGM3lu7ULqgoYY5ttlGTybxyvnZG2U7UZ9+V49BwyFZI
         YjS6vtDHoc1jpVbtC7rWVB/3xuYwvAytGceMeA3cFXM3mzViNrArieZMPa7hkhgrJ/xN
         zQrmb3GNShXr7kchFmenqh1nx8RJERapA/ZMzLSl71BRDOa7SsOyn/lIrIRqRaZ+kFRF
         0XCIF9kHf8sAcg29jLaPh5IU7+wPf1y5L/WjjUj2L1d4OHKWPxKtdRTaqo7xKlRNx4JM
         gmiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743071570; x=1743676370;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QwXK89mxSdfmuJR1/wg5oQtNJQj1cM7/gY8WIAvqtd0=;
        b=JD8Gf8NfQYu+zjryzp6HdQc/bE2ohsfOKYtmhMKWQVUqRbqy9RlzxOZlZzN/wNo+zP
         lC+OJhSo10JVOVigH0/ihfFGiCXpLF0MnyFsRhUC1gFIxyqffA0twNVRB83b+cZ+rpka
         wjJPqynsLynltqsm5+XpHwQldMr0A9oy6Tz1Yi8Xc+rhGcKMY8J8oYiHgBCYfiKkmdlg
         JQ61+oqGwSOmsri5BpAeTCRnYFutV3qQesLbWIvCz//ScgJIS+31TvIPp05vI+zEpnvL
         BmcgLP4Y4CebK5Cbc8N0E+vjf+xvDsP+Xu82qCMuIRx/AFbk89w4blhUI9D0wJo5e0pA
         FcPg==
X-Forwarded-Encrypted: i=1; AJvYcCWNX4wYHtasZNUml6+n2Jckm1+uN45Oifbc0ZhAr7hNqYXhvOakzdnoIqjQnWDz/VyiIsGCEK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaOXBpzwPXzqMnD4GKfcfYoIud8aw+ILMTvzXtTtLjKcwe7xXf
	m+U038rJRc3nxh+hISHgG8rVrw6vrSDsMLab+7L3XV3XkCXWezASGEefxt1urKo=
X-Gm-Gg: ASbGncskMT7lBfuyccBRo8byF+mA9N5z3dt3OovIuvgsi4EGj4Y8tgYkXUB6IiLkO/K
	3QsERbCRbYOtlKd23H/FiNQqaqIUvFdr2ewaG8qeUFWolxwRJW4qGp8fMRmTvDiyEkvpiNSc3Hq
	fdrzWyVblax6Vvw0dbeVtEDwTSz1/QrIWpmEHhn1mK4ozGnxGfNuINkzU9MTujszXMiZtYFcIdk
	WpITzCyckAhI3NdCFU5pMVRRTB0sqR2s7CWnDl4Cjv003+TaX4g49NrSKMdKAzfRHZ3mStdA+6k
	E5SvNqGAPNtC9EpJDwWgaeBrvJ3HCjQgjeKU0WYyZjzCoZawyV+KSfqDR7l2JyW4g5FpbHOPNYh
	3XvB6ctR+EpKf
X-Google-Smtp-Source: AGHT+IEqtVFlkaYOk7PVw+0bwIyQcixzPOqEo7In8r4IcdTzDc7Ca1N3UC/mdLxM/q23os3x65NOrQ==
X-Received: by 2002:a17:907:6e87:b0:ac1:e332:b1f5 with SMTP id a640c23a62f3a-ac6fb10b123mr285041866b.37.1743071569580;
        Thu, 27 Mar 2025 03:32:49 -0700 (PDT)
Received: from wkz-x13.addiva.ad (h-79-136-22-50.NA.cust.bahnhof.se. [79.136.22.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef8675a9sm1200047566b.28.2025.03.27.03.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 03:32:48 -0700 (PDT)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: maxime.chevallier@bootlin.com,
	marcin.s.wojtas@gmail.com,
	linux@armlinux.org.uk,
	andrew@lunn.ch,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH v4 net] net: mvpp2: Prevent parser TCAM memory corruption
Date: Thu, 27 Mar 2025 11:30:49 +0100
Message-ID: <20250327103139.567970-1-tobias@waldekranz.com>
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

v3 -> v4:
 - Move memory allocations outside of atomic region in
   mvpp2_prs_default_init() (Maxime)

v2 -> v3:
 - Note the fact that prs_spinlock also protects the SRAM shadow table
   (Andrew)
 - Add lockdep assertions for HW table accesses (Andrew/Jakub)
 - Add locking to the init path, since it uses the table access
   functions that are now annotated with lockdep assertions

v1 -> v2:
 - Parser memory is never modified from hard IRQ context, so settle
   for disabling bottom halves in critical sections. (Maxime)

 drivers/net/ethernet/marvell/mvpp2/mvpp2.h    |   3 +
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   |   3 +-
 .../net/ethernet/marvell/mvpp2/mvpp2_prs.c    | 201 ++++++++++++------
 3 files changed, 140 insertions(+), 67 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
index 44fe9b68d1c2..061fcd444d50 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
@@ -1113,6 +1113,9 @@ struct mvpp2 {
 
 	/* Spinlocks for CM3 shared memory configuration */
 	spinlock_t mss_spinlock;
+
+	/* Spinlock for shared PRS parser memory and shadow table */
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
index 9af22f497a40..a96edc7dc0de 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c
@@ -23,6 +23,8 @@ static int mvpp2_prs_hw_write(struct mvpp2 *priv, struct mvpp2_prs_entry *pe)
 {
 	int i;
 
+	lockdep_assert_held(&priv->prs_spinlock);
+
 	if (pe->index > MVPP2_PRS_TCAM_SRAM_SIZE - 1)
 		return -EINVAL;
 
@@ -43,11 +45,13 @@ static int mvpp2_prs_hw_write(struct mvpp2 *priv, struct mvpp2_prs_entry *pe)
 }
 
 /* Initialize tcam entry from hw */
-int mvpp2_prs_init_from_hw(struct mvpp2 *priv, struct mvpp2_prs_entry *pe,
-			   int tid)
+static int mvpp2_prs_init_from_hw_unlocked(struct mvpp2 *priv,
+					   struct mvpp2_prs_entry *pe, int tid)
 {
 	int i;
 
+	lockdep_assert_held(&priv->prs_spinlock);
+
 	if (tid > MVPP2_PRS_TCAM_SRAM_SIZE - 1)
 		return -EINVAL;
 
@@ -73,6 +77,18 @@ int mvpp2_prs_init_from_hw(struct mvpp2 *priv, struct mvpp2_prs_entry *pe,
 	return 0;
 }
 
+int mvpp2_prs_init_from_hw(struct mvpp2 *priv, struct mvpp2_prs_entry *pe,
+			   int tid)
+{
+	int err;
+
+	spin_lock_bh(&priv->prs_spinlock);
+	err = mvpp2_prs_init_from_hw_unlocked(priv, pe, tid);
+	spin_unlock_bh(&priv->prs_spinlock);
+
+	return err;
+}
+
 /* Invalidate tcam hw entry */
 static void mvpp2_prs_hw_inv(struct mvpp2 *priv, int index)
 {
@@ -374,7 +390,7 @@ static int mvpp2_prs_flow_find(struct mvpp2 *priv, int flow)
 		    priv->prs_shadow[tid].lu != MVPP2_PRS_LU_FLOWS)
 			continue;
 
-		mvpp2_prs_init_from_hw(priv, &pe, tid);
+		mvpp2_prs_init_from_hw_unlocked(priv, &pe, tid);
 		bits = mvpp2_prs_sram_ai_get(&pe);
 
 		/* Sram store classification lookup ID in AI bits [5:0] */
@@ -441,7 +457,7 @@ static void mvpp2_prs_mac_drop_all_set(struct mvpp2 *priv, int port, bool add)
 
 	if (priv->prs_shadow[MVPP2_PE_DROP_ALL].valid) {
 		/* Entry exist - update port only */
-		mvpp2_prs_init_from_hw(priv, &pe, MVPP2_PE_DROP_ALL);
+		mvpp2_prs_init_from_hw_unlocked(priv, &pe, MVPP2_PE_DROP_ALL);
 	} else {
 		/* Entry doesn't exist - create new */
 		memset(&pe, 0, sizeof(pe));
@@ -469,14 +485,17 @@ static void mvpp2_prs_mac_drop_all_set(struct mvpp2 *priv, int port, bool add)
 }
 
 /* Set port to unicast or multicast promiscuous mode */
-void mvpp2_prs_mac_promisc_set(struct mvpp2 *priv, int port,
-			       enum mvpp2_prs_l2_cast l2_cast, bool add)
+static void mvpp2_prs_mac_promisc_set_unlocked(struct mvpp2 *priv, int port,
+					       enum mvpp2_prs_l2_cast l2_cast,
+					       bool add)
 {
 	struct mvpp2_prs_entry pe;
 	unsigned char cast_match;
 	unsigned int ri;
 	int tid;
 
+	lockdep_assert_held(&priv->prs_spinlock);
+
 	if (l2_cast == MVPP2_PRS_L2_UNI_CAST) {
 		cast_match = MVPP2_PRS_UCAST_VAL;
 		tid = MVPP2_PE_MAC_UC_PROMISCUOUS;
@@ -489,7 +508,7 @@ void mvpp2_prs_mac_promisc_set(struct mvpp2 *priv, int port,
 
 	/* promiscuous mode - Accept unknown unicast or multicast packets */
 	if (priv->prs_shadow[tid].valid) {
-		mvpp2_prs_init_from_hw(priv, &pe, tid);
+		mvpp2_prs_init_from_hw_unlocked(priv, &pe, tid);
 	} else {
 		memset(&pe, 0, sizeof(pe));
 		mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_MAC);
@@ -522,6 +541,14 @@ void mvpp2_prs_mac_promisc_set(struct mvpp2 *priv, int port,
 	mvpp2_prs_hw_write(priv, &pe);
 }
 
+void mvpp2_prs_mac_promisc_set(struct mvpp2 *priv, int port,
+			       enum mvpp2_prs_l2_cast l2_cast, bool add)
+{
+		spin_lock_bh(&priv->prs_spinlock);
+		mvpp2_prs_mac_promisc_set_unlocked(priv, port, l2_cast, add);
+		spin_unlock_bh(&priv->prs_spinlock);
+}
+
 /* Set entry for dsa packets */
 static void mvpp2_prs_dsa_tag_set(struct mvpp2 *priv, int port, bool add,
 				  bool tagged, bool extend)
@@ -539,7 +566,7 @@ static void mvpp2_prs_dsa_tag_set(struct mvpp2 *priv, int port, bool add,
 
 	if (priv->prs_shadow[tid].valid) {
 		/* Entry exist - update port only */
-		mvpp2_prs_init_from_hw(priv, &pe, tid);
+		mvpp2_prs_init_from_hw_unlocked(priv, &pe, tid);
 	} else {
 		/* Entry doesn't exist - create new */
 		memset(&pe, 0, sizeof(pe));
@@ -610,7 +637,7 @@ static void mvpp2_prs_dsa_tag_ethertype_set(struct mvpp2 *priv, int port,
 
 	if (priv->prs_shadow[tid].valid) {
 		/* Entry exist - update port only */
-		mvpp2_prs_init_from_hw(priv, &pe, tid);
+		mvpp2_prs_init_from_hw_unlocked(priv, &pe, tid);
 	} else {
 		/* Entry doesn't exist - create new */
 		memset(&pe, 0, sizeof(pe));
@@ -673,7 +700,7 @@ static int mvpp2_prs_vlan_find(struct mvpp2 *priv, unsigned short tpid, int ai)
 		    priv->prs_shadow[tid].lu != MVPP2_PRS_LU_VLAN)
 			continue;
 
-		mvpp2_prs_init_from_hw(priv, &pe, tid);
+		mvpp2_prs_init_from_hw_unlocked(priv, &pe, tid);
 		match = mvpp2_prs_tcam_data_cmp(&pe, 0, tpid);
 		if (!match)
 			continue;
@@ -726,7 +753,7 @@ static int mvpp2_prs_vlan_add(struct mvpp2 *priv, unsigned short tpid, int ai,
 			    priv->prs_shadow[tid_aux].lu != MVPP2_PRS_LU_VLAN)
 				continue;
 
-			mvpp2_prs_init_from_hw(priv, &pe, tid_aux);
+			mvpp2_prs_init_from_hw_unlocked(priv, &pe, tid_aux);
 			ri_bits = mvpp2_prs_sram_ri_get(&pe);
 			if ((ri_bits & MVPP2_PRS_RI_VLAN_MASK) ==
 			    MVPP2_PRS_RI_VLAN_DOUBLE)
@@ -760,7 +787,7 @@ static int mvpp2_prs_vlan_add(struct mvpp2 *priv, unsigned short tpid, int ai,
 
 		mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_VLAN);
 	} else {
-		mvpp2_prs_init_from_hw(priv, &pe, tid);
+		mvpp2_prs_init_from_hw_unlocked(priv, &pe, tid);
 	}
 	/* Update ports' mask */
 	mvpp2_prs_tcam_port_map_set(&pe, port_map);
@@ -800,7 +827,7 @@ static int mvpp2_prs_double_vlan_find(struct mvpp2 *priv, unsigned short tpid1,
 		    priv->prs_shadow[tid].lu != MVPP2_PRS_LU_VLAN)
 			continue;
 
-		mvpp2_prs_init_from_hw(priv, &pe, tid);
+		mvpp2_prs_init_from_hw_unlocked(priv, &pe, tid);
 
 		match = mvpp2_prs_tcam_data_cmp(&pe, 0, tpid1) &&
 			mvpp2_prs_tcam_data_cmp(&pe, 4, tpid2);
@@ -849,7 +876,7 @@ static int mvpp2_prs_double_vlan_add(struct mvpp2 *priv, unsigned short tpid1,
 			    priv->prs_shadow[tid_aux].lu != MVPP2_PRS_LU_VLAN)
 				continue;
 
-			mvpp2_prs_init_from_hw(priv, &pe, tid_aux);
+			mvpp2_prs_init_from_hw_unlocked(priv, &pe, tid_aux);
 			ri_bits = mvpp2_prs_sram_ri_get(&pe);
 			ri_bits &= MVPP2_PRS_RI_VLAN_MASK;
 			if (ri_bits == MVPP2_PRS_RI_VLAN_SINGLE ||
@@ -880,7 +907,7 @@ static int mvpp2_prs_double_vlan_add(struct mvpp2 *priv, unsigned short tpid1,
 
 		mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_VLAN);
 	} else {
-		mvpp2_prs_init_from_hw(priv, &pe, tid);
+		mvpp2_prs_init_from_hw_unlocked(priv, &pe, tid);
 	}
 
 	/* Update ports' mask */
@@ -1213,8 +1240,8 @@ static void mvpp2_prs_mac_init(struct mvpp2 *priv)
 	/* Create dummy entries for drop all and promiscuous modes */
 	mvpp2_prs_drop_fc(priv);
 	mvpp2_prs_mac_drop_all_set(priv, 0, false);
-	mvpp2_prs_mac_promisc_set(priv, 0, MVPP2_PRS_L2_UNI_CAST, false);
-	mvpp2_prs_mac_promisc_set(priv, 0, MVPP2_PRS_L2_MULTI_CAST, false);
+	mvpp2_prs_mac_promisc_set_unlocked(priv, 0, MVPP2_PRS_L2_UNI_CAST, false);
+	mvpp2_prs_mac_promisc_set_unlocked(priv, 0, MVPP2_PRS_L2_MULTI_CAST, false);
 }
 
 /* Set default entries for various types of dsa packets */
@@ -1533,12 +1560,6 @@ static int mvpp2_prs_vlan_init(struct platform_device *pdev, struct mvpp2 *priv)
 	struct mvpp2_prs_entry pe;
 	int err;
 
-	priv->prs_double_vlans = devm_kcalloc(&pdev->dev, sizeof(bool),
-					      MVPP2_PRS_DBL_VLANS_MAX,
-					      GFP_KERNEL);
-	if (!priv->prs_double_vlans)
-		return -ENOMEM;
-
 	/* Double VLAN: 0x88A8, 0x8100 */
 	err = mvpp2_prs_double_vlan_add(priv, ETH_P_8021AD, ETH_P_8021Q,
 					MVPP2_PRS_PORT_MASK);
@@ -1941,7 +1962,7 @@ static int mvpp2_prs_vid_range_find(struct mvpp2_port *port, u16 vid, u16 mask)
 		    port->priv->prs_shadow[tid].lu != MVPP2_PRS_LU_VID)
 			continue;
 
-		mvpp2_prs_init_from_hw(port->priv, &pe, tid);
+		mvpp2_prs_init_from_hw_unlocked(port->priv, &pe, tid);
 
 		mvpp2_prs_tcam_data_byte_get(&pe, 2, &byte[0], &enable[0]);
 		mvpp2_prs_tcam_data_byte_get(&pe, 3, &byte[1], &enable[1]);
@@ -1970,6 +1991,8 @@ int mvpp2_prs_vid_entry_add(struct mvpp2_port *port, u16 vid)
 
 	memset(&pe, 0, sizeof(pe));
 
+	spin_lock_bh(&priv->prs_spinlock);
+
 	/* Scan TCAM and see if entry with this <vid,port> already exist */
 	tid = mvpp2_prs_vid_range_find(port, vid, mask);
 
@@ -1988,8 +2011,10 @@ int mvpp2_prs_vid_entry_add(struct mvpp2_port *port, u16 vid)
 						MVPP2_PRS_VLAN_FILT_MAX_ENTRY);
 
 		/* There isn't room for a new VID filter */
-		if (tid < 0)
+		if (tid < 0) {
+			spin_unlock_bh(&priv->prs_spinlock);
 			return tid;
+		}
 
 		mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_VID);
 		pe.index = tid;
@@ -1997,7 +2022,7 @@ int mvpp2_prs_vid_entry_add(struct mvpp2_port *port, u16 vid)
 		/* Mask all ports */
 		mvpp2_prs_tcam_port_map_set(&pe, 0);
 	} else {
-		mvpp2_prs_init_from_hw(priv, &pe, tid);
+		mvpp2_prs_init_from_hw_unlocked(priv, &pe, tid);
 	}
 
 	/* Enable the current port */
@@ -2019,6 +2044,7 @@ int mvpp2_prs_vid_entry_add(struct mvpp2_port *port, u16 vid)
 	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_VID);
 	mvpp2_prs_hw_write(priv, &pe);
 
+	spin_unlock_bh(&priv->prs_spinlock);
 	return 0;
 }
 
@@ -2028,15 +2054,16 @@ void mvpp2_prs_vid_entry_remove(struct mvpp2_port *port, u16 vid)
 	struct mvpp2 *priv = port->priv;
 	int tid;
 
-	/* Scan TCAM and see if entry with this <vid,port> already exist */
-	tid = mvpp2_prs_vid_range_find(port, vid, 0xfff);
+	spin_lock_bh(&priv->prs_spinlock);
 
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
+	spin_unlock_bh(&priv->prs_spinlock);
 }
 
 /* Remove all existing VID filters on this port */
@@ -2045,6 +2072,8 @@ void mvpp2_prs_vid_remove_all(struct mvpp2_port *port)
 	struct mvpp2 *priv = port->priv;
 	int tid;
 
+	spin_lock_bh(&priv->prs_spinlock);
+
 	for (tid = MVPP2_PRS_VID_PORT_FIRST(port->id);
 	     tid <= MVPP2_PRS_VID_PORT_LAST(port->id); tid++) {
 		if (priv->prs_shadow[tid].valid) {
@@ -2052,6 +2081,8 @@ void mvpp2_prs_vid_remove_all(struct mvpp2_port *port)
 			priv->prs_shadow[tid].valid = false;
 		}
 	}
+
+	spin_unlock_bh(&priv->prs_spinlock);
 }
 
 /* Remove VID filering entry for this port */
@@ -2060,10 +2091,14 @@ void mvpp2_prs_vid_disable_filtering(struct mvpp2_port *port)
 	unsigned int tid = MVPP2_PRS_VID_PORT_DFLT(port->id);
 	struct mvpp2 *priv = port->priv;
 
+	spin_lock_bh(&priv->prs_spinlock);
+
 	/* Invalidate the guard entry */
 	mvpp2_prs_hw_inv(priv, tid);
 
 	priv->prs_shadow[tid].valid = false;
+
+	spin_unlock_bh(&priv->prs_spinlock);
 }
 
 /* Add guard entry that drops packets when no VID is matched on this port */
@@ -2079,6 +2114,8 @@ void mvpp2_prs_vid_enable_filtering(struct mvpp2_port *port)
 
 	memset(&pe, 0, sizeof(pe));
 
+	spin_lock_bh(&priv->prs_spinlock);
+
 	pe.index = tid;
 
 	reg_val = mvpp2_read(priv, MVPP2_MH_REG(port->id));
@@ -2111,6 +2148,8 @@ void mvpp2_prs_vid_enable_filtering(struct mvpp2_port *port)
 	/* Update shadow table */
 	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_VID);
 	mvpp2_prs_hw_write(priv, &pe);
+
+	spin_unlock_bh(&priv->prs_spinlock);
 }
 
 /* Parser default initialization */
@@ -2118,6 +2157,20 @@ int mvpp2_prs_default_init(struct platform_device *pdev, struct mvpp2 *priv)
 {
 	int err, index, i;
 
+	priv->prs_shadow = devm_kcalloc(&pdev->dev, MVPP2_PRS_TCAM_SRAM_SIZE,
+					sizeof(*priv->prs_shadow),
+					GFP_KERNEL);
+	if (!priv->prs_shadow)
+		return -ENOMEM;
+
+	priv->prs_double_vlans = devm_kcalloc(&pdev->dev, sizeof(bool),
+					      MVPP2_PRS_DBL_VLANS_MAX,
+					      GFP_KERNEL);
+	if (!priv->prs_double_vlans)
+		return -ENOMEM;
+
+	spin_lock_bh(&priv->prs_spinlock);
+
 	/* Enable tcam table */
 	mvpp2_write(priv, MVPP2_PRS_TCAM_CTRL_REG, MVPP2_PRS_TCAM_EN_MASK);
 
@@ -2136,12 +2189,6 @@ int mvpp2_prs_default_init(struct platform_device *pdev, struct mvpp2 *priv)
 	for (index = 0; index < MVPP2_PRS_TCAM_SRAM_SIZE; index++)
 		mvpp2_prs_hw_inv(priv, index);
 
-	priv->prs_shadow = devm_kcalloc(&pdev->dev, MVPP2_PRS_TCAM_SRAM_SIZE,
-					sizeof(*priv->prs_shadow),
-					GFP_KERNEL);
-	if (!priv->prs_shadow)
-		return -ENOMEM;
-
 	/* Always start from lookup = 0 */
 	for (index = 0; index < MVPP2_MAX_PORTS; index++)
 		mvpp2_prs_hw_port_init(priv, index, MVPP2_PRS_LU_MH,
@@ -2158,26 +2205,13 @@ int mvpp2_prs_default_init(struct platform_device *pdev, struct mvpp2 *priv)
 	mvpp2_prs_vid_init(priv);
 
 	err = mvpp2_prs_etype_init(priv);
-	if (err)
-		return err;
-
-	err = mvpp2_prs_vlan_init(pdev, priv);
-	if (err)
-		return err;
-
-	err = mvpp2_prs_pppoe_init(priv);
-	if (err)
-		return err;
-
-	err = mvpp2_prs_ip6_init(priv);
-	if (err)
-		return err;
-
-	err = mvpp2_prs_ip4_init(priv);
-	if (err)
-		return err;
+	err = err ? : mvpp2_prs_vlan_init(pdev, priv);
+	err = err ? : mvpp2_prs_pppoe_init(priv);
+	err = err ? : mvpp2_prs_ip6_init(priv);
+	err = err ? : mvpp2_prs_ip4_init(priv);
 
-	return 0;
+	spin_unlock_bh(&priv->prs_spinlock);
+	return err;
 }
 
 /* Compare MAC DA with tcam entry data */
@@ -2217,7 +2251,7 @@ mvpp2_prs_mac_da_range_find(struct mvpp2 *priv, int pmap, const u8 *da,
 		    (priv->prs_shadow[tid].udf != udf_type))
 			continue;
 
-		mvpp2_prs_init_from_hw(priv, &pe, tid);
+		mvpp2_prs_init_from_hw_unlocked(priv, &pe, tid);
 		entry_pmap = mvpp2_prs_tcam_port_map_get(&pe);
 
 		if (mvpp2_prs_mac_range_equals(&pe, da, mask) &&
@@ -2229,7 +2263,8 @@ mvpp2_prs_mac_da_range_find(struct mvpp2 *priv, int pmap, const u8 *da,
 }
 
 /* Update parser's mac da entry */
-int mvpp2_prs_mac_da_accept(struct mvpp2_port *port, const u8 *da, bool add)
+static int mvpp2_prs_mac_da_accept_unlocked(struct mvpp2_port *port,
+					    const u8 *da, bool add)
 {
 	unsigned char mask[ETH_ALEN] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
 	struct mvpp2 *priv = port->priv;
@@ -2261,7 +2296,7 @@ int mvpp2_prs_mac_da_accept(struct mvpp2_port *port, const u8 *da, bool add)
 		/* Mask all ports */
 		mvpp2_prs_tcam_port_map_set(&pe, 0);
 	} else {
-		mvpp2_prs_init_from_hw(priv, &pe, tid);
+		mvpp2_prs_init_from_hw_unlocked(priv, &pe, tid);
 	}
 
 	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_MAC);
@@ -2317,6 +2352,17 @@ int mvpp2_prs_mac_da_accept(struct mvpp2_port *port, const u8 *da, bool add)
 	return 0;
 }
 
+int mvpp2_prs_mac_da_accept(struct mvpp2_port *port, const u8 *da, bool add)
+{
+	int err;
+
+	spin_lock_bh(&port->priv->prs_spinlock);
+	err = mvpp2_prs_mac_da_accept_unlocked(port, da, add);
+	spin_unlock_bh(&port->priv->prs_spinlock);
+
+	return err;
+}
+
 int mvpp2_prs_update_mac_da(struct net_device *dev, const u8 *da)
 {
 	struct mvpp2_port *port = netdev_priv(dev);
@@ -2345,6 +2391,8 @@ void mvpp2_prs_mac_del_all(struct mvpp2_port *port)
 	unsigned long pmap;
 	int index, tid;
 
+	spin_lock_bh(&priv->prs_spinlock);
+
 	for (tid = MVPP2_PE_MAC_RANGE_START;
 	     tid <= MVPP2_PE_MAC_RANGE_END; tid++) {
 		unsigned char da[ETH_ALEN], da_mask[ETH_ALEN];
@@ -2354,7 +2402,7 @@ void mvpp2_prs_mac_del_all(struct mvpp2_port *port)
 		    (priv->prs_shadow[tid].udf != MVPP2_PRS_UDF_MAC_DEF))
 			continue;
 
-		mvpp2_prs_init_from_hw(priv, &pe, tid);
+		mvpp2_prs_init_from_hw_unlocked(priv, &pe, tid);
 
 		pmap = mvpp2_prs_tcam_port_map_get(&pe);
 
@@ -2375,14 +2423,17 @@ void mvpp2_prs_mac_del_all(struct mvpp2_port *port)
 			continue;
 
 		/* Remove entry from TCAM */
-		mvpp2_prs_mac_da_accept(port, da, false);
+		mvpp2_prs_mac_da_accept_unlocked(port, da, false);
 	}
+
+	spin_unlock_bh(&priv->prs_spinlock);
 }
 
 int mvpp2_prs_tag_mode_set(struct mvpp2 *priv, int port, int type)
 {
 	switch (type) {
 	case MVPP2_TAG_TYPE_EDSA:
+		spin_lock_bh(&priv->prs_spinlock);
 		/* Add port to EDSA entries */
 		mvpp2_prs_dsa_tag_set(priv, port, true,
 				      MVPP2_PRS_TAGGED, MVPP2_PRS_EDSA);
@@ -2393,9 +2444,11 @@ int mvpp2_prs_tag_mode_set(struct mvpp2 *priv, int port, int type)
 				      MVPP2_PRS_TAGGED, MVPP2_PRS_DSA);
 		mvpp2_prs_dsa_tag_set(priv, port, false,
 				      MVPP2_PRS_UNTAGGED, MVPP2_PRS_DSA);
+		spin_unlock_bh(&priv->prs_spinlock);
 		break;
 
 	case MVPP2_TAG_TYPE_DSA:
+		spin_lock_bh(&priv->prs_spinlock);
 		/* Add port to DSA entries */
 		mvpp2_prs_dsa_tag_set(priv, port, true,
 				      MVPP2_PRS_TAGGED, MVPP2_PRS_DSA);
@@ -2406,10 +2459,12 @@ int mvpp2_prs_tag_mode_set(struct mvpp2 *priv, int port, int type)
 				      MVPP2_PRS_TAGGED, MVPP2_PRS_EDSA);
 		mvpp2_prs_dsa_tag_set(priv, port, false,
 				      MVPP2_PRS_UNTAGGED, MVPP2_PRS_EDSA);
+		spin_unlock_bh(&priv->prs_spinlock);
 		break;
 
 	case MVPP2_TAG_TYPE_MH:
 	case MVPP2_TAG_TYPE_NONE:
+		spin_lock_bh(&priv->prs_spinlock);
 		/* Remove port form EDSA and DSA entries */
 		mvpp2_prs_dsa_tag_set(priv, port, false,
 				      MVPP2_PRS_TAGGED, MVPP2_PRS_DSA);
@@ -2419,6 +2474,7 @@ int mvpp2_prs_tag_mode_set(struct mvpp2 *priv, int port, int type)
 				      MVPP2_PRS_TAGGED, MVPP2_PRS_EDSA);
 		mvpp2_prs_dsa_tag_set(priv, port, false,
 				      MVPP2_PRS_UNTAGGED, MVPP2_PRS_EDSA);
+		spin_unlock_bh(&priv->prs_spinlock);
 		break;
 
 	default:
@@ -2437,11 +2493,15 @@ int mvpp2_prs_add_flow(struct mvpp2 *priv, int flow, u32 ri, u32 ri_mask)
 
 	memset(&pe, 0, sizeof(pe));
 
+	spin_lock_bh(&priv->prs_spinlock);
+
 	tid = mvpp2_prs_tcam_first_free(priv,
 					MVPP2_PE_LAST_FREE_TID,
 					MVPP2_PE_FIRST_FREE_TID);
-	if (tid < 0)
+	if (tid < 0) {
+		spin_unlock_bh(&priv->prs_spinlock);
 		return tid;
+	}
 
 	pe.index = tid;
 
@@ -2461,6 +2521,7 @@ int mvpp2_prs_add_flow(struct mvpp2 *priv, int flow, u32 ri, u32 ri_mask)
 	mvpp2_prs_tcam_port_map_set(&pe, MVPP2_PRS_PORT_MASK);
 	mvpp2_prs_hw_write(priv, &pe);
 
+	spin_unlock_bh(&priv->prs_spinlock);
 	return 0;
 }
 
@@ -2472,6 +2533,8 @@ int mvpp2_prs_def_flow(struct mvpp2_port *port)
 
 	memset(&pe, 0, sizeof(pe));
 
+	spin_lock_bh(&port->priv->prs_spinlock);
+
 	tid = mvpp2_prs_flow_find(port->priv, port->id);
 
 	/* Such entry not exist */
@@ -2480,8 +2543,10 @@ int mvpp2_prs_def_flow(struct mvpp2_port *port)
 		tid = mvpp2_prs_tcam_first_free(port->priv,
 						MVPP2_PE_LAST_FREE_TID,
 					       MVPP2_PE_FIRST_FREE_TID);
-		if (tid < 0)
+		if (tid < 0) {
+			spin_unlock_bh(&port->priv->prs_spinlock);
 			return tid;
+		}
 
 		pe.index = tid;
 
@@ -2492,13 +2557,14 @@ int mvpp2_prs_def_flow(struct mvpp2_port *port)
 		/* Update shadow table */
 		mvpp2_prs_shadow_set(port->priv, pe.index, MVPP2_PRS_LU_FLOWS);
 	} else {
-		mvpp2_prs_init_from_hw(port->priv, &pe, tid);
+		mvpp2_prs_init_from_hw_unlocked(port->priv, &pe, tid);
 	}
 
 	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_FLOWS);
 	mvpp2_prs_tcam_port_map_set(&pe, (1 << port->id));
 	mvpp2_prs_hw_write(port->priv, &pe);
 
+	spin_unlock_bh(&port->priv->prs_spinlock);
 	return 0;
 }
 
@@ -2509,11 +2575,14 @@ int mvpp2_prs_hits(struct mvpp2 *priv, int index)
 	if (index > MVPP2_PRS_TCAM_SRAM_SIZE)
 		return -EINVAL;
 
+	spin_lock_bh(&priv->prs_spinlock);
+
 	mvpp2_write(priv, MVPP2_PRS_TCAM_HIT_IDX_REG, index);
 
 	val = mvpp2_read(priv, MVPP2_PRS_TCAM_HIT_CNT_REG);
 
 	val &= MVPP2_PRS_TCAM_HIT_CNT_MASK;
 
+	spin_unlock_bh(&priv->prs_spinlock);
 	return val;
 }
-- 
2.43.0


