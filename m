Return-Path: <netdev+bounces-176701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9494AA6B69B
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 10:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 065AC466560
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 09:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4716B1E571A;
	Fri, 21 Mar 2025 09:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="Wb1CTN3N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB108BEE
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 09:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742548007; cv=none; b=ch2m8OPpg4wOnRH15jc8o7mxNAFUJIh9yEkx3veJdsQ51S43v43UFPfiUq4xbD16kGQt0aQZanW9lpPNVBWbUjICRfwlYi3aVRovu5IOda9GVgPb+BjHjKgiaXkEeQBSsurRclYtYPG1hj5RkP0b281IWGlw1DfBByXKz2hpJE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742548007; c=relaxed/simple;
	bh=hzWwLsJ18SpU3HiIk3fRcaQxaqxkm0v/YbPSsEnkQRs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nt4EgzFfeP/yn/RUusnSVLDXhRfIc/ztgLDfpOQ6Xnvu/7pIa/dZML4/gruc32//X2vUGOYmCvMLf2NVLP8XkifuTqHr1ctThmX75QTb/HgF2Y0Enpg/LY4S0wyosNF2P+/1Dnp/p5ZPNZqZSnhp5NlIbQJf9YMgb/ufWjmfcIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=Wb1CTN3N; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e6c18e2c7dso3055936a12.3
        for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 02:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1742548002; x=1743152802; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5dMHpDamkM23ON0uNAsLnmSTqjFFnZk6flpDZxrlghg=;
        b=Wb1CTN3NtE1NzynYooJ0yUSCLVdkwFW8pKvvFKp9zsOuhn70Kryx4Qef4TaQrYFbJt
         Axdjv/uZ6FilEufxmaWvdw+8fYAKcKCepQ8MTQSoqMGzD6RtnsRrFle4/YBY1pIaDQTl
         U5pgqkFYksd4Rqvk6B1mW5CZzrTH1AcLkMFqXOo4jLPzwEJ/IFAvWyA2qUq9TL/dwYIr
         fPJ+x3PJx5OpmQIgMxxZN5UU7mgUW3cdDWIjNH2nuKKFmDB3WIxLqwUqnEPMmJptgxCt
         UWK00rZ4gS5/SkjN2h4kF7Jrv7/kjQH/RLJwIg3oqD8LFCnQRoKL6NHSe/eDjg/mAUa3
         GiNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742548002; x=1743152802;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5dMHpDamkM23ON0uNAsLnmSTqjFFnZk6flpDZxrlghg=;
        b=LxCg74rHKAXt+i+yNbp20Q5CRLjU05rQ1NF/FWrKWQgUl5wKhR0iZbj53282lMLfi/
         IimzRd9y1fkwDSr33en/9CEKywH42wNQufMBmWaF/R6vDkCKmGjWPGYE5vWKg6B6ANtB
         54VyWS9VXx+4waHogXoHC8qrF6/Dd1hMy6tDnp3B/HERFYZSfUFNG+Quf9KXG7wOGfBx
         8FriQ1MaDrLGUf6rDdD6ToAZI/aVb9v04vo0zUHEVYORyHyAyPv8rPAe1y3zUt+I/NkR
         fApbBAO0opMwOTczKXWP3cOklpMvi0gnWbn6+wFfcEbkOh1HlqjFGYXuVr2BhNOeXJIX
         fwZA==
X-Forwarded-Encrypted: i=1; AJvYcCVXs4s09kqQ255Fs4/W15sn3vRQiE+BV1hcTW6dlmc36+Tb7OudqOZ6CoF3AwVXxXs39kET+60=@vger.kernel.org
X-Gm-Message-State: AOJu0YxALOxAv8ZFCXecdmJPrx4FN9iwkHaCon4w1omUfncNuZEoTzKO
	yGkpENXASrhJHcTQoWazmuRIEo247ZXMYR5MvBiM1pSr3PrZojVldHfeENbF7pI=
X-Gm-Gg: ASbGncvQDbagiMhUbtM35jdMjMtBOLnmU5n5r8Zlcwj9ad2LMFyxTWqZRzCtdvvWf3z
	WdWb5y/qQ1g+e2Q5PN4noG+LS0x1jiWwzS7ThQaCa4aqv6dse5rTz/B1LpOretAcRMqKroPD2gZ
	6ah7qpFIkITlzXWAl8N6mjLto6QgUUJa8Nle1GZYR5jzUbIICjsQ0KZ/0jzozuPAZQODLMdFnjy
	caXxVwDMZh+wXhtUoWfwC6fJzE4iuaWFT2yCSnZVRRys00JD+w9pvtVCBGGbgHSjEtCXXI7PPCv
	lkIX0Hw02uCocBHiRI6HlZKRoRuXe0LeOWKfTXs7Fsw1xnuzmKdmgm2H+vqfEZqPY97l2dxlONb
	3EGURmXHWlMoX
X-Google-Smtp-Source: AGHT+IFW5/0aOsKPocsDr+Qs5W0EpqFxvqsAf+QiaIaC+i+V4kdz54uzg9xIjYFZPNdpwaq4d3sDhw==
X-Received: by 2002:a05:6402:42cb:b0:5e4:c026:2d7a with SMTP id 4fb4d7f45d1cf-5ebcd474182mr2000680a12.16.1742548002210;
        Fri, 21 Mar 2025 02:06:42 -0700 (PDT)
Received: from wkz-x13.addiva.ad (h-79-136-22-50.NA.cust.bahnhof.se. [79.136.22.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebccfb12aesm1032457a12.46.2025.03.21.02.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 02:06:41 -0700 (PDT)
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
Subject: [PATCH v2 net] net: mvpp2: Prevent parser TCAM memory corruption
Date: Fri, 21 Mar 2025 10:03:23 +0100
Message-ID: <20250321090510.2914252-1-tobias@waldekranz.com>
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

v1 -> v2:
 - Parser memory is never modified from hard IRQ context, so settle
   for disabling bottom halves in critical sections. (Maxime)

drivers/net/ethernet/marvell/mvpp2/mvpp2.h    |   3 +
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   |   3 +-
 .../net/ethernet/marvell/mvpp2/mvpp2_prs.c    | 131 +++++++++++++-----
 3 files changed, 105 insertions(+), 32 deletions(-)

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
index 9af22f497a40..b90b4f677ce7 100644
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
 
@@ -73,6 +73,18 @@ int mvpp2_prs_init_from_hw(struct mvpp2 *priv, struct mvpp2_prs_entry *pe,
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
@@ -374,7 +386,7 @@ static int mvpp2_prs_flow_find(struct mvpp2 *priv, int flow)
 		    priv->prs_shadow[tid].lu != MVPP2_PRS_LU_FLOWS)
 			continue;
 
-		mvpp2_prs_init_from_hw(priv, &pe, tid);
+		mvpp2_prs_init_from_hw_unlocked(priv, &pe, tid);
 		bits = mvpp2_prs_sram_ai_get(&pe);
 
 		/* Sram store classification lookup ID in AI bits [5:0] */
@@ -441,7 +453,7 @@ static void mvpp2_prs_mac_drop_all_set(struct mvpp2 *priv, int port, bool add)
 
 	if (priv->prs_shadow[MVPP2_PE_DROP_ALL].valid) {
 		/* Entry exist - update port only */
-		mvpp2_prs_init_from_hw(priv, &pe, MVPP2_PE_DROP_ALL);
+		mvpp2_prs_init_from_hw_unlocked(priv, &pe, MVPP2_PE_DROP_ALL);
 	} else {
 		/* Entry doesn't exist - create new */
 		memset(&pe, 0, sizeof(pe));
@@ -477,6 +489,8 @@ void mvpp2_prs_mac_promisc_set(struct mvpp2 *priv, int port,
 	unsigned int ri;
 	int tid;
 
+	spin_lock_bh(&priv->prs_spinlock);
+
 	if (l2_cast == MVPP2_PRS_L2_UNI_CAST) {
 		cast_match = MVPP2_PRS_UCAST_VAL;
 		tid = MVPP2_PE_MAC_UC_PROMISCUOUS;
@@ -489,7 +503,7 @@ void mvpp2_prs_mac_promisc_set(struct mvpp2 *priv, int port,
 
 	/* promiscuous mode - Accept unknown unicast or multicast packets */
 	if (priv->prs_shadow[tid].valid) {
-		mvpp2_prs_init_from_hw(priv, &pe, tid);
+		mvpp2_prs_init_from_hw_unlocked(priv, &pe, tid);
 	} else {
 		memset(&pe, 0, sizeof(pe));
 		mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_MAC);
@@ -520,6 +534,8 @@ void mvpp2_prs_mac_promisc_set(struct mvpp2 *priv, int port,
 	mvpp2_prs_tcam_port_set(&pe, port, add);
 
 	mvpp2_prs_hw_write(priv, &pe);
+
+	spin_unlock_bh(&priv->prs_spinlock);
 }
 
 /* Set entry for dsa packets */
@@ -539,7 +555,7 @@ static void mvpp2_prs_dsa_tag_set(struct mvpp2 *priv, int port, bool add,
 
 	if (priv->prs_shadow[tid].valid) {
 		/* Entry exist - update port only */
-		mvpp2_prs_init_from_hw(priv, &pe, tid);
+		mvpp2_prs_init_from_hw_unlocked(priv, &pe, tid);
 	} else {
 		/* Entry doesn't exist - create new */
 		memset(&pe, 0, sizeof(pe));
@@ -610,7 +626,7 @@ static void mvpp2_prs_dsa_tag_ethertype_set(struct mvpp2 *priv, int port,
 
 	if (priv->prs_shadow[tid].valid) {
 		/* Entry exist - update port only */
-		mvpp2_prs_init_from_hw(priv, &pe, tid);
+		mvpp2_prs_init_from_hw_unlocked(priv, &pe, tid);
 	} else {
 		/* Entry doesn't exist - create new */
 		memset(&pe, 0, sizeof(pe));
@@ -673,7 +689,7 @@ static int mvpp2_prs_vlan_find(struct mvpp2 *priv, unsigned short tpid, int ai)
 		    priv->prs_shadow[tid].lu != MVPP2_PRS_LU_VLAN)
 			continue;
 
-		mvpp2_prs_init_from_hw(priv, &pe, tid);
+		mvpp2_prs_init_from_hw_unlocked(priv, &pe, tid);
 		match = mvpp2_prs_tcam_data_cmp(&pe, 0, tpid);
 		if (!match)
 			continue;
@@ -726,7 +742,7 @@ static int mvpp2_prs_vlan_add(struct mvpp2 *priv, unsigned short tpid, int ai,
 			    priv->prs_shadow[tid_aux].lu != MVPP2_PRS_LU_VLAN)
 				continue;
 
-			mvpp2_prs_init_from_hw(priv, &pe, tid_aux);
+			mvpp2_prs_init_from_hw_unlocked(priv, &pe, tid_aux);
 			ri_bits = mvpp2_prs_sram_ri_get(&pe);
 			if ((ri_bits & MVPP2_PRS_RI_VLAN_MASK) ==
 			    MVPP2_PRS_RI_VLAN_DOUBLE)
@@ -760,7 +776,7 @@ static int mvpp2_prs_vlan_add(struct mvpp2 *priv, unsigned short tpid, int ai,
 
 		mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_VLAN);
 	} else {
-		mvpp2_prs_init_from_hw(priv, &pe, tid);
+		mvpp2_prs_init_from_hw_unlocked(priv, &pe, tid);
 	}
 	/* Update ports' mask */
 	mvpp2_prs_tcam_port_map_set(&pe, port_map);
@@ -800,7 +816,7 @@ static int mvpp2_prs_double_vlan_find(struct mvpp2 *priv, unsigned short tpid1,
 		    priv->prs_shadow[tid].lu != MVPP2_PRS_LU_VLAN)
 			continue;
 
-		mvpp2_prs_init_from_hw(priv, &pe, tid);
+		mvpp2_prs_init_from_hw_unlocked(priv, &pe, tid);
 
 		match = mvpp2_prs_tcam_data_cmp(&pe, 0, tpid1) &&
 			mvpp2_prs_tcam_data_cmp(&pe, 4, tpid2);
@@ -849,7 +865,7 @@ static int mvpp2_prs_double_vlan_add(struct mvpp2 *priv, unsigned short tpid1,
 			    priv->prs_shadow[tid_aux].lu != MVPP2_PRS_LU_VLAN)
 				continue;
 
-			mvpp2_prs_init_from_hw(priv, &pe, tid_aux);
+			mvpp2_prs_init_from_hw_unlocked(priv, &pe, tid_aux);
 			ri_bits = mvpp2_prs_sram_ri_get(&pe);
 			ri_bits &= MVPP2_PRS_RI_VLAN_MASK;
 			if (ri_bits == MVPP2_PRS_RI_VLAN_SINGLE ||
@@ -880,7 +896,7 @@ static int mvpp2_prs_double_vlan_add(struct mvpp2 *priv, unsigned short tpid1,
 
 		mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_VLAN);
 	} else {
-		mvpp2_prs_init_from_hw(priv, &pe, tid);
+		mvpp2_prs_init_from_hw_unlocked(priv, &pe, tid);
 	}
 
 	/* Update ports' mask */
@@ -1941,7 +1957,7 @@ static int mvpp2_prs_vid_range_find(struct mvpp2_port *port, u16 vid, u16 mask)
 		    port->priv->prs_shadow[tid].lu != MVPP2_PRS_LU_VID)
 			continue;
 
-		mvpp2_prs_init_from_hw(port->priv, &pe, tid);
+		mvpp2_prs_init_from_hw_unlocked(port->priv, &pe, tid);
 
 		mvpp2_prs_tcam_data_byte_get(&pe, 2, &byte[0], &enable[0]);
 		mvpp2_prs_tcam_data_byte_get(&pe, 3, &byte[1], &enable[1]);
@@ -1970,6 +1986,8 @@ int mvpp2_prs_vid_entry_add(struct mvpp2_port *port, u16 vid)
 
 	memset(&pe, 0, sizeof(pe));
 
+	spin_lock_bh(&priv->prs_spinlock);
+
 	/* Scan TCAM and see if entry with this <vid,port> already exist */
 	tid = mvpp2_prs_vid_range_find(port, vid, mask);
 
@@ -1988,8 +2006,10 @@ int mvpp2_prs_vid_entry_add(struct mvpp2_port *port, u16 vid)
 						MVPP2_PRS_VLAN_FILT_MAX_ENTRY);
 
 		/* There isn't room for a new VID filter */
-		if (tid < 0)
+		if (tid < 0) {
+			spin_unlock_bh(&priv->prs_spinlock);
 			return tid;
+		}
 
 		mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_VID);
 		pe.index = tid;
@@ -1997,7 +2017,7 @@ int mvpp2_prs_vid_entry_add(struct mvpp2_port *port, u16 vid)
 		/* Mask all ports */
 		mvpp2_prs_tcam_port_map_set(&pe, 0);
 	} else {
-		mvpp2_prs_init_from_hw(priv, &pe, tid);
+		mvpp2_prs_init_from_hw_unlocked(priv, &pe, tid);
 	}
 
 	/* Enable the current port */
@@ -2019,6 +2039,7 @@ int mvpp2_prs_vid_entry_add(struct mvpp2_port *port, u16 vid)
 	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_VID);
 	mvpp2_prs_hw_write(priv, &pe);
 
+	spin_unlock_bh(&priv->prs_spinlock);
 	return 0;
 }
 
@@ -2028,15 +2049,16 @@ void mvpp2_prs_vid_entry_remove(struct mvpp2_port *port, u16 vid)
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
@@ -2045,6 +2067,8 @@ void mvpp2_prs_vid_remove_all(struct mvpp2_port *port)
 	struct mvpp2 *priv = port->priv;
 	int tid;
 
+	spin_lock_bh(&priv->prs_spinlock);
+
 	for (tid = MVPP2_PRS_VID_PORT_FIRST(port->id);
 	     tid <= MVPP2_PRS_VID_PORT_LAST(port->id); tid++) {
 		if (priv->prs_shadow[tid].valid) {
@@ -2052,6 +2076,8 @@ void mvpp2_prs_vid_remove_all(struct mvpp2_port *port)
 			priv->prs_shadow[tid].valid = false;
 		}
 	}
+
+	spin_unlock_bh(&priv->prs_spinlock);
 }
 
 /* Remove VID filering entry for this port */
@@ -2060,10 +2086,14 @@ void mvpp2_prs_vid_disable_filtering(struct mvpp2_port *port)
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
@@ -2079,6 +2109,8 @@ void mvpp2_prs_vid_enable_filtering(struct mvpp2_port *port)
 
 	memset(&pe, 0, sizeof(pe));
 
+	spin_lock_bh(&priv->prs_spinlock);
+
 	pe.index = tid;
 
 	reg_val = mvpp2_read(priv, MVPP2_MH_REG(port->id));
@@ -2111,6 +2143,8 @@ void mvpp2_prs_vid_enable_filtering(struct mvpp2_port *port)
 	/* Update shadow table */
 	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_VID);
 	mvpp2_prs_hw_write(priv, &pe);
+
+	spin_unlock_bh(&priv->prs_spinlock);
 }
 
 /* Parser default initialization */
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


