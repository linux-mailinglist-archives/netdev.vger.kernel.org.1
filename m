Return-Path: <netdev+bounces-197723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C893AD9B1D
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 10:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1DEC17B3F8
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 08:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3E02036FE;
	Sat, 14 Jun 2025 08:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCf3erGI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8271FF1A0;
	Sat, 14 Jun 2025 08:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749888014; cv=none; b=V5JtiMPlgGd9VXMu04uHanqMYcS1EWrnjYffWcWWAiTgejUKIkOYjwBa4smHYDKFOFkPFxh9/XuXG4qPItbNdRvTb+FludK17OIFTM1iIK49pPtZirBc4fHV+YPUdm2r5p7ADr/fLvjZYgdeihnJHNB12j72lRF2iTgTCvWU24M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749888014; c=relaxed/simple;
	bh=26o+UGPZaA/meJ/rPwsDm9Lg+d5FmvrtLi02Z5EPy7A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tF3IAImV5rUFWbD6C43l70hxBb+HXGo3S+1vxF+pv6cJJXwX/t/IU4JqRg1UUBAv2JlR9wo+qE4H8qB+aS7pTMJW7EBvoUpRxHXh9/mVm/3SLq6YMW2qHCfWVOEIICe19/C9d1LmuwASqRXFgZwYJC5BiSZHLwdFLu8rFXCrkjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TCf3erGI; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a522224582so1578288f8f.3;
        Sat, 14 Jun 2025 01:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749888011; x=1750492811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hKKuX2du2tVXvdcp256SQK3CEesyHkcmsHeAzB6+slc=;
        b=TCf3erGIYgxKf7TFceWBYlXF8jbi+0TXWpbrkWHK9Yb4CCZbFqauu0SDY/Ix5767bS
         JBIXyu6VkcLpPzE43qoRqVAavM6KRcjQ0nj9mwK/PHv2waoo3ax5uud5D6qDUXo9tbjR
         i3/ZNpkgoL+BzkF88rLOlh8FEg8XVChi9WhCCiSLJUpW7opBvhHDKisEPu5DNt/ZAuD9
         qMn2vRZLHw7HyWcyJIg3suMZfP2GMbSX79olipfkO/JKI1nzYkFXsoK0N9AxvWY6jVXB
         Mk+3klPLyiDPQ4HdGfR1k/JMX5k6WvHF/nh6odFqRAdZzvGPj85zGHV3JMQfUZWBK7rZ
         52SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749888011; x=1750492811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hKKuX2du2tVXvdcp256SQK3CEesyHkcmsHeAzB6+slc=;
        b=uXE4BAc04sz4jW8NZ13yet4ibsVMdAzwNJchpKI/X6caMKZAcHdF9FTqMt0D2BNgZn
         /f4XWzf+T7MViQgeVzHAAbrYn1E4fCf8eSC+hLq77fTJUcWCmKT3au2qoYX8plmjzU5e
         OWPuevfTa8Kzk+ldpv3kGqWJ8Be5pP+XeaPwK/gSQUGWRoyOnMoYKKuEOTGH2vvjCtny
         lJw2oXBi69Ecv8OabSFMbO6QpGseTOXsHyAxhu3HUFfy+85fxTYwkOvhzZRLCyjUN5ta
         O+02lGjZpcB6haBfqNESU4BIgupUKoOX8PzTNRij2ktTeVc2vn1blxS/9hcjq0/zby4w
         pGkg==
X-Forwarded-Encrypted: i=1; AJvYcCWOmApQdD0nuiMO6ImgXYJf4lrQglanZUH5YubM+VLesy97aflYItdE58JdihuNhsBSQrN2eZaa@vger.kernel.org, AJvYcCWiiY/4KHSxOeWjUEWbWhCyTaJw20RbDxzHl+rME76v4QofPvV8YJLMNpGXyTIlBiVnyps/esfRhX6mzhY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb37zFWrAiurfGZ7he742o9ZShvUNgHoDX0YGqMg4gIlluP5jz
	i6cl6u4UuyQyouNo4Y7idCqw4nBvZzJ7ayMeCgkvkjvuAAWbkwP3ZfgG
X-Gm-Gg: ASbGncvWMClLfNpH/Y5onGowP+ZHrxOfD7HoUB41ZgsL38z954nCzcyYWGS2UC0fUI+
	EIE4MTA0cFVoH0yK7zb33wx6+WEK6P2MKR+X6kugHv0eqvkNCL4JzMd7HkTyR7xXzn0OkdbJrmd
	+/EVgWeUqaujXD39lb/kUoUkaSaBHQ/mVJrNebjEWI4DCpUNlG3mwn5HdsR1OiBh2QB13hsCII8
	kKh762EDEXSXJYSzqdfZ/BrDyYDMxEYwbYbAVxZHIHVzzX7+CSKxILZgNO89GfMeFJF/LwTaSWI
	B6WYCwtbSKncvKoDsppr5EiRzQiy7EfnZD0JbFFiYhQ4TLeV/iz0mK/qJfMw72yltMe7yURW2sf
	/f00JmmXBMsp+G5Cfdd1OgV+Pit0WHLx8xBvui1XOOPXLZ8LnkNKfDglAhM+G+Sj370JuRl+9qQ
	==
X-Google-Smtp-Source: AGHT+IGfA3gZQ1qHGOCo6owzvyE0BChw5HQOTvt3R/X6ENN8y/A/dgVlMBY72PnUkBFUc0R5KEZ46g==
X-Received: by 2002:a05:6000:2c13:b0:3a4:d0dc:184d with SMTP id ffacd0b85a97d-3a5723a2d79mr2454318f8f.27.1749888010835;
        Sat, 14 Jun 2025 01:00:10 -0700 (PDT)
Received: from skynet.lan (2a02-9142-4580-2300-0000-0000-0000-0008.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:2300::8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532de8c50esm75443535e9.4.2025.06.14.01.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jun 2025 01:00:10 -0700 (PDT)
From: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
To: jonas.gorski@gmail.com,
	florian.fainelli@broadcom.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vivien.didelot@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dgcbueu@gmail.com
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	=?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Subject: [PATCH net-next v4 05/14] net: dsa: b53: add support for FDB operations on 5325/5365
Date: Sat, 14 Jun 2025 09:59:51 +0200
Message-Id: <20250614080000.1884236-6-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250614080000.1884236-1-noltari@gmail.com>
References: <20250614080000.1884236-1-noltari@gmail.com>
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
 drivers/net/dsa/b53/b53_common.c | 101 +++++++++++++++++++++++++------
 drivers/net/dsa/b53/b53_priv.h   |  29 +++++++++
 drivers/net/dsa/b53/b53_regs.h   |   7 ++-
 3 files changed, 115 insertions(+), 22 deletions(-)

 v4: move B53_VLAN_ID_IDX BCM5325M check to the previous patch.

 v3: add changes requested by Florian:
  - B53_VLAN_ID_IDX exists in newer BCM5325E switches.

 v2: add changes requested by Jonas and fix proposed by Florian:
  - Add b53_arl_to_entry_25 function.
  - Add b53_arl_from_entry_25 function.
  - Add b53_arl_read_25 function, fixing usage of ARLTBL_VALID_25 and
    ARLTBL_VID_MASK_25.

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index a7c75f44369a..033cd78577f7 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1764,6 +1764,45 @@ static int b53_arl_read(struct b53_device *dev, u64 mac,
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
@@ -1786,7 +1825,10 @@ static int b53_arl_op(struct b53_device *dev, int op, int port,
 	if (ret)
 		return ret;
 
-	ret = b53_arl_read(dev, mac, vid, &ent, &idx);
+	if (is5325(dev) || is5365(dev))
+		ret = b53_arl_read_25(dev, mac, vid, &ent, &idx);
+	else
+		ret = b53_arl_read(dev, mac, vid, &ent, &idx);
 
 	/* If this is a read, just finish now */
 	if (op)
@@ -1830,12 +1872,17 @@ static int b53_arl_op(struct b53_device *dev, int op, int port,
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
@@ -1847,12 +1894,6 @@ int b53_fdb_add(struct dsa_switch *ds, int port,
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
@@ -1879,10 +1920,15 @@ EXPORT_SYMBOL(b53_fdb_del);
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
 
@@ -1899,13 +1945,24 @@ static void b53_arl_search_rd(struct b53_device *dev, u8 idx,
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
@@ -1926,14 +1983,20 @@ int b53_fdb_dump(struct dsa_switch *ds, int port,
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
index e8689410b5d0..b1b9e8882ba4 100644
--- a/drivers/net/dsa/b53/b53_priv.h
+++ b/drivers/net/dsa/b53/b53_priv.h
@@ -317,6 +317,19 @@ static inline void b53_arl_to_entry(struct b53_arl_entry *ent,
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
@@ -331,6 +344,22 @@ static inline void b53_arl_from_entry(u64 *mac_vid, u32 *fwd_entry,
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
index 1fbc5a204bc7..1f15332fb2a7 100644
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


