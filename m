Return-Path: <netdev+bounces-194835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8685CACCE60
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 22:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9958D1890E1E
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 20:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D1A223DCF;
	Tue,  3 Jun 2025 20:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YF1VMVRk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49124221D92;
	Tue,  3 Jun 2025 20:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748983749; cv=none; b=SWz1PzqhoO0YtAAXP4FMltORhCdF1+F9qAco8iDE19PJfXiFDVYH82DS/eWR8ehkQCDUyT5QCtd25vk0D7WO6cz+3rgtE5bcW2c9IQ8tBh4xfzCMvhkS4ks4+OhBc9BfyYgLqEzFWb7s4jUbxKVXxmIdhSH8XEJOGS0tIMr29s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748983749; c=relaxed/simple;
	bh=z8dWJaKSmBcpaNxvbQJBeyBiVJ30AUubz+jlLPX685c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mKZs/HWNWSeX9QieqVdsQ1P4pA61UsEvokL8IIB2TArTNz5H1485dx9XDRpN1pkLuzscRgLY5Kj+9U4UIHriMKhME8WHeTeDHZWRNhDr9+OI+jEZQXYzVh2S/4CfGQCRSj4RRx7mWy691Rddox7wAVlrXNckDTM82kMjvDrIHjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YF1VMVRk; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-451ebd3d149so8273355e9.2;
        Tue, 03 Jun 2025 13:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748983746; x=1749588546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1y5MonuZ51OuFIGrTHJyuvp7/2bU9PzjiD+ht/MTKec=;
        b=YF1VMVRkpPORV/Ssry9+IBMSSqn8NAjRFl/eMbUbhggYL1cuByZZd9iFjwfwg276h3
         grBDPYv38Sf/eJUjwOwVRCKm+4aEK5I8PvzitPWjqRw9mXW7pBjuFb4f97/Mcf2XCH1H
         Kfh+AZTFn4FvdBtlRRnmtD460dQvMPuvWaaOG8J3ZirU9l/p//FzX15WbgeW53a3f43w
         UeDS8w0gP5Af0YkvKbnBEreEXCoDGlnQrhNnIlM0zMAUyUL9/T0xRuhR6WAfbJviZ6qN
         XFb4CwakQDDRUvJ7ccV7rDK5IUZlyKs/MI8EGletutWu7lFgsL5nlEEtZYSWLxh+KjEv
         DtKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748983746; x=1749588546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1y5MonuZ51OuFIGrTHJyuvp7/2bU9PzjiD+ht/MTKec=;
        b=U/4SPReTchIlDmI7PE68hMF+57otZcwVof0x312hAWZCv9flZcScWeLInPJF47Qqzx
         4LCi/0NUJQQvoOWgFRp26N6Hedv+VhVoclxy7Pmxtp7iSaF79+BZrmn3TySTafKTCzG+
         MxG2t07P1dqcK8cCS5F8/0D6HoE0fqas7uJ/AbUxIiP4d7nLiuwzjkYGjkxKe8N73NY2
         dW6tyUn7hZzr/BctmKmZngubgY5izWlYfu/1XnLJ84Ym8w938bllRlzTXbbEkJchc4jL
         thf3JAVyy9HrNAvGYnelTdrvsAuy2J074FS/U8Pf92sN5uqtX1OUcI2n9j2HlOed8Oqm
         ye7w==
X-Forwarded-Encrypted: i=1; AJvYcCUmkcMR4EOBNITBMt3++bwMzhcWxKLiLH4OszkFo28z4FmOX3FipOEx8AD/JzniP8Rg0TmEtTFvx8DQopY=@vger.kernel.org, AJvYcCWthRF5EUKiDO/zlKtrWzoYEQjglGuxl36BAafHI73KvgiD8xka85Zy+lvielZWL6nQVZ3c+Xfq@vger.kernel.org
X-Gm-Message-State: AOJu0YyWndC/BMpOJxFrsjWt/fxoRSI99kafjEtt2gft3vQ64Kwbo+0m
	puxMKJOWfMHVDzT/5cdCOzerUjwnanYUs119CS25O/gx60RL9O3JZajP
X-Gm-Gg: ASbGncuLfuYf4a9g3+lupf27nKEE5OA2KWtnhAaLJqWESZhZtL8rkNeU+gbp+mxp+WK
	1ptLfjQquVUTO1pp1ZQAvv7pMujPj4AanHgWNK6j0Zvkeia6czLX0ueT2VtmyvdQy7CWLRsMVJn
	mUGaeRKo0RQpbjRkIfwPMZctPql2TOuEkry8AAQ7LikfxLIZFGBUCMpBSfrt36b7jQNhILYtpUb
	PQPNn/ueyhiFC1jGH6hk7m900SnMLiiACWv20spEPkJlrQVsQMUSBlGnzqSDedb9ruznNNuQ++/
	tV8U/e6s2hYiGdBwY4+WSStJqg5nm/gw4ZYCr110sv6KZ5nCD/Ufx4DDtuoTPeOQ6hyEPHpqOnJ
	CkeVcOrdlVNKE2ujxIgoXGLflpFzuj0Bu+bHT3OWIHBTSwa48GZDJngbTl+Ew2DE=
X-Google-Smtp-Source: AGHT+IGrWxT5A3PsP//vwc14wFJqopVqwUyYm9UoQnhfQvbZhwnvjIvgU5FSDz1QlHtUDDcHMu8NMQ==
X-Received: by 2002:a05:600c:8719:b0:43c:f050:fed3 with SMTP id 5b1f17b1804b1-451f0a72fd7mr1299325e9.11.1748983745278;
        Tue, 03 Jun 2025 13:49:05 -0700 (PDT)
Received: from skynet.lan (2a02-9142-4580-1500-0000-0000-0000-0008.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:1500::8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451e58c348asm26258225e9.3.2025.06.03.13.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 13:49:04 -0700 (PDT)
From: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
To: jonas.gorski@gmail.com,
	florian.fainelli@broadcom.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vivien.didelot@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dgcbueu@gmail.com
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	=?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Subject: [RFC PATCH net-next v2 01/10] net: dsa: b53: add support for FDB operations on 5325/5365
Date: Tue,  3 Jun 2025 22:48:49 +0200
Message-Id: <20250603204858.72402-2-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250603204858.72402-1-noltari@gmail.com>
References: <20250603204858.72402-1-noltari@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Florian Fainelli <f.fainelli@gmail.com>

BCM5325 and BCM5365 are part of a much older generation of switches which,
due to their limited number of ports and VLAN entries (up to 256) allowed
a single 64-bit register to hold a full ARL entry.
This requires a little bit of massaging when reading, writing and
converting ARL entries in both directions.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 104 +++++++++++++++++++++++++------
 drivers/net/dsa/b53/b53_priv.h   |  29 +++++++++
 drivers/net/dsa/b53/b53_regs.h   |   7 ++-
 3 files changed, 117 insertions(+), 23 deletions(-)

 v2: add changes requested by Jonas and fix proposed by Florian:
  - Add b53_arl_to_entry_25 function.
  - Add b53_arl_from_entry_25 function.
  - Add b53_arl_read_25 function, fixing usage of ARLTBL_VALID_25 and
    ARLTBL_VID_MASK_25.

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 132683ed3abe6..feea531732c7b 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1781,6 +1781,45 @@ static int b53_arl_read(struct b53_device *dev, u64 mac,
 	return *idx >= dev->num_arl_bins ? -ENOSPC : -ENOENT;
 }
 
+static int b53_arl_read_25(struct b53_device *dev, u64 mac,
+			   u16 vid, struct b53_arl_entry *ent, u8 *idx)
+{
+	DECLARE_BITMAP(free_bins, B53_ARLTBL_MAX_BIN_ENTRIES);
+	unsigned int i;
+	int ret;
+
+	ret = b53_arl_op_wait(dev);
+	if (ret)
+		return ret;
+
+	bitmap_zero(free_bins, dev->num_arl_bins);
+
+	/* Read the bins */
+	for (i = 0; i < dev->num_arl_bins; i++) {
+		u64 mac_vid;
+
+		b53_read64(dev, B53_ARLIO_PAGE,
+			   B53_ARLTBL_MAC_VID_ENTRY(i), &mac_vid);
+
+		b53_arl_to_entry_25(ent, mac_vid);
+
+		if (!(mac_vid & ARLTBL_VALID_25)) {
+			set_bit(i, free_bins);
+			continue;
+		}
+		if ((mac_vid & ARLTBL_MAC_MASK) != mac)
+			continue;
+		if (dev->vlan_enabled &&
+		    ((mac_vid >> ARLTBL_VID_S_65) & ARLTBL_VID_MASK_25) != vid)
+			continue;
+		*idx = i;
+		return 0;
+	}
+
+	*idx = find_first_bit(free_bins, dev->num_arl_bins);
+	return *idx >= dev->num_arl_bins ? -ENOSPC : -ENOENT;
+}
+
 static int b53_arl_op(struct b53_device *dev, int op, int port,
 		      const unsigned char *addr, u16 vid, bool is_valid)
 {
@@ -1795,14 +1834,18 @@ static int b53_arl_op(struct b53_device *dev, int op, int port,
 
 	/* Perform a read for the given MAC and VID */
 	b53_write48(dev, B53_ARLIO_PAGE, B53_MAC_ADDR_IDX, mac);
-	b53_write16(dev, B53_ARLIO_PAGE, B53_VLAN_ID_IDX, vid);
+	if (!is5325(dev))
+		b53_write16(dev, B53_ARLIO_PAGE, B53_VLAN_ID_IDX, vid);
 
 	/* Issue a read operation for this MAC */
 	ret = b53_arl_rw_op(dev, 1);
 	if (ret)
 		return ret;
 
-	ret = b53_arl_read(dev, mac, vid, &ent, &idx);
+	if (is5325(dev) || is5365(dev))
+		ret = b53_arl_read_25(dev, mac, vid, &ent, &idx);
+	else
+		ret = b53_arl_read(dev, mac, vid, &ent, &idx);
 
 	/* If this is a read, just finish now */
 	if (op)
@@ -1846,12 +1889,17 @@ static int b53_arl_op(struct b53_device *dev, int op, int port,
 	ent.is_static = true;
 	ent.is_age = false;
 	memcpy(ent.mac, addr, ETH_ALEN);
-	b53_arl_from_entry(&mac_vid, &fwd_entry, &ent);
+	if (is5325(dev) || is5365(dev))
+		b53_arl_from_entry_25(&mac_vid, &ent);
+	else
+		b53_arl_from_entry(&mac_vid, &fwd_entry, &ent);
 
 	b53_write64(dev, B53_ARLIO_PAGE,
 		    B53_ARLTBL_MAC_VID_ENTRY(idx), mac_vid);
-	b53_write32(dev, B53_ARLIO_PAGE,
-		    B53_ARLTBL_DATA_ENTRY(idx), fwd_entry);
+
+	if (!is5325(dev) && !is5365(dev))
+		b53_write32(dev, B53_ARLIO_PAGE,
+			    B53_ARLTBL_DATA_ENTRY(idx), fwd_entry);
 
 	return b53_arl_rw_op(dev, 0);
 }
@@ -1863,12 +1911,6 @@ int b53_fdb_add(struct dsa_switch *ds, int port,
 	struct b53_device *priv = ds->priv;
 	int ret;
 
-	/* 5325 and 5365 require some more massaging, but could
-	 * be supported eventually
-	 */
-	if (is5325(priv) || is5365(priv))
-		return -EOPNOTSUPP;
-
 	mutex_lock(&priv->arl_mutex);
 	ret = b53_arl_op(priv, 0, port, addr, vid, true);
 	mutex_unlock(&priv->arl_mutex);
@@ -1895,10 +1937,15 @@ EXPORT_SYMBOL(b53_fdb_del);
 static int b53_arl_search_wait(struct b53_device *dev)
 {
 	unsigned int timeout = 1000;
-	u8 reg;
+	u8 reg, offset;
+
+	if (is5325(dev) || is5365(dev))
+		offset = B53_ARL_SRCH_CTL_25;
+	else
+		offset = B53_ARL_SRCH_CTL;
 
 	do {
-		b53_read8(dev, B53_ARLIO_PAGE, B53_ARL_SRCH_CTL, &reg);
+		b53_read8(dev, B53_ARLIO_PAGE, offset, &reg);
 		if (!(reg & ARL_SRCH_STDN))
 			return 0;
 
@@ -1915,13 +1962,24 @@ static void b53_arl_search_rd(struct b53_device *dev, u8 idx,
 			      struct b53_arl_entry *ent)
 {
 	u64 mac_vid;
-	u32 fwd_entry;
 
-	b53_read64(dev, B53_ARLIO_PAGE,
-		   B53_ARL_SRCH_RSTL_MACVID(idx), &mac_vid);
-	b53_read32(dev, B53_ARLIO_PAGE,
-		   B53_ARL_SRCH_RSTL(idx), &fwd_entry);
-	b53_arl_to_entry(ent, mac_vid, fwd_entry);
+	if (is5325(dev)) {
+		b53_read64(dev, B53_ARLIO_PAGE, B53_ARL_SRCH_RSTL_0_MACVID_25,
+			   &mac_vid);
+		b53_arl_to_entry_25(ent, mac_vid);
+	} else if (is5365(dev)) {
+		b53_read64(dev, B53_ARLIO_PAGE, B53_ARL_SRCH_RSTL_0_MACVID_65,
+			   &mac_vid);
+		b53_arl_to_entry_25(ent, mac_vid);
+	} else {
+		u32 fwd_entry;
+
+		b53_read64(dev, B53_ARLIO_PAGE, B53_ARL_SRCH_RSTL_MACVID(idx),
+			   &mac_vid);
+		b53_read32(dev, B53_ARLIO_PAGE, B53_ARL_SRCH_RSTL(idx),
+			   &fwd_entry);
+		b53_arl_to_entry(ent, mac_vid, fwd_entry);
+	}
 }
 
 static int b53_fdb_copy(int port, const struct b53_arl_entry *ent,
@@ -1942,14 +2000,20 @@ int b53_fdb_dump(struct dsa_switch *ds, int port,
 	struct b53_device *priv = ds->priv;
 	struct b53_arl_entry results[2];
 	unsigned int count = 0;
+	u8 offset;
 	int ret;
 	u8 reg;
 
 	mutex_lock(&priv->arl_mutex);
 
+	if (is5325(priv) || is5365(priv))
+		offset = B53_ARL_SRCH_CTL_25;
+	else
+		offset = B53_ARL_SRCH_CTL;
+
 	/* Start search operation */
 	reg = ARL_SRCH_STDN;
-	b53_write8(priv, B53_ARLIO_PAGE, B53_ARL_SRCH_CTL, reg);
+	b53_write8(priv, offset, B53_ARL_SRCH_CTL, reg);
 
 	do {
 		ret = b53_arl_search_wait(priv);
diff --git a/drivers/net/dsa/b53/b53_priv.h b/drivers/net/dsa/b53/b53_priv.h
index a5ef7071ba07b..2238eef2a8771 100644
--- a/drivers/net/dsa/b53/b53_priv.h
+++ b/drivers/net/dsa/b53/b53_priv.h
@@ -298,6 +298,19 @@ static inline void b53_arl_to_entry(struct b53_arl_entry *ent,
 	ent->vid = mac_vid >> ARLTBL_VID_S;
 }
 
+static inline void b53_arl_to_entry_25(struct b53_arl_entry *ent,
+				       u64 mac_vid)
+{
+	memset(ent, 0, sizeof(*ent));
+	ent->port = (mac_vid >> ARLTBL_DATA_PORT_ID_S_25) &
+		     ARLTBL_DATA_PORT_ID_MASK_25;
+	ent->is_valid = !!(mac_vid & ARLTBL_VALID_25);
+	ent->is_age = !!(mac_vid & ARLTBL_AGE_25);
+	ent->is_static = !!(mac_vid & ARLTBL_STATIC_25);
+	u64_to_ether_addr(mac_vid, ent->mac);
+	ent->vid = mac_vid >> ARLTBL_VID_S_65;
+}
+
 static inline void b53_arl_from_entry(u64 *mac_vid, u32 *fwd_entry,
 				      const struct b53_arl_entry *ent)
 {
@@ -312,6 +325,22 @@ static inline void b53_arl_from_entry(u64 *mac_vid, u32 *fwd_entry,
 		*fwd_entry |= ARLTBL_AGE;
 }
 
+static inline void b53_arl_from_entry_25(u64 *mac_vid,
+					 const struct b53_arl_entry *ent)
+{
+	*mac_vid = ether_addr_to_u64(ent->mac);
+	*mac_vid |= (u64)(ent->port & ARLTBL_DATA_PORT_ID_MASK_25) <<
+			  ARLTBL_DATA_PORT_ID_S_25;
+	*mac_vid |= (u64)(ent->vid & ARLTBL_VID_MASK_25) <<
+			  ARLTBL_VID_S_65;
+	if (ent->is_valid)
+		*mac_vid |= ARLTBL_VALID_25;
+	if (ent->is_static)
+		*mac_vid |= ARLTBL_STATIC_25;
+	if (ent->is_age)
+		*mac_vid |= ARLTBL_AGE_25;
+}
+
 #ifdef CONFIG_BCM47XX
 
 #include <linux/bcm47xx_nvram.h>
diff --git a/drivers/net/dsa/b53/b53_regs.h b/drivers/net/dsa/b53/b53_regs.h
index 1fbc5a204bc72..1f15332fb2a7c 100644
--- a/drivers/net/dsa/b53/b53_regs.h
+++ b/drivers/net/dsa/b53/b53_regs.h
@@ -324,9 +324,10 @@
 #define   ARLTBL_VID_MASK		0xfff
 #define   ARLTBL_DATA_PORT_ID_S_25	48
 #define   ARLTBL_DATA_PORT_ID_MASK_25	0xf
-#define   ARLTBL_AGE_25			BIT(61)
-#define   ARLTBL_STATIC_25		BIT(62)
-#define   ARLTBL_VALID_25		BIT(63)
+#define   ARLTBL_VID_S_65		53
+#define   ARLTBL_AGE_25			BIT_ULL(61)
+#define   ARLTBL_STATIC_25		BIT_ULL(62)
+#define   ARLTBL_VALID_25		BIT_ULL(63)
 
 /* ARL Table Data Entry N Registers (32 bit) */
 #define B53_ARLTBL_DATA_ENTRY(n)	((0x10 * (n)) + 0x18)
-- 
2.39.5


