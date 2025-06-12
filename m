Return-Path: <netdev+bounces-196844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 402F1AD6B09
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 10:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84ABD7AE259
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 08:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E1E22A7E2;
	Thu, 12 Jun 2025 08:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2LrhK6T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8647422A4EE;
	Thu, 12 Jun 2025 08:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749717479; cv=none; b=MXod1u5Idfft5lYkom1tmoj02Icov6uwcq+5/1rofUtqoT2fPBSwC6tQ8yBWVqJUdZ8jogpFH0LOELpyhDSOtxLK4kECh45+zixwpquVDBsgmH66jwwap4blSO5bKg6xbXmQNa7e2tqBB+3SjBlCVBmnYwnNDo8mNGqssKVQO4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749717479; c=relaxed/simple;
	bh=TC4HdSiEIwFy8CYTvbyXaKkGNApV91M5gHfBFsCvfdQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dwvE8jiqns+K4pXS0WeDPy0Gj0NyM+wWxrpjaG6V1ynRG8Rlsnrs3GMyJ97CCEiw+VLfP4BknpdogLZTMU3dmy8hglKacUpV5PGgMYLjmd65oejxeQlNJdPjXrF0dkuG9rlj92yRogqpuyAoEsPZnqbE2xTAcdkcd9Pol3XdFzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2LrhK6T; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-450d668c2a1so12849145e9.0;
        Thu, 12 Jun 2025 01:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749717476; x=1750322276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v6p1j1qTLF2MFMW2J8lJBrQ9BSh4eJu4r76wlgaGnm0=;
        b=R2LrhK6TngeStPinBWWZSxOOkTWmZMzxQkfpMYF8ddEQnKG7+mlkBs87Pfh/lVGoow
         tWX4UV+ay1gHVT3rO8+SaAj4nbp8V0VPNIZ8xXv6KLH2aOSvNNrvo2CLSJsvWITKIQqR
         CdP+dgvq2WndQ+KdsRwuidGBj4yfwa3CQHyeIIy+R1E4OIG7pdEEnShjYn56rsLSDzk7
         mB4q2X/vGXuQKtnXSA5Dr4sLYl8Aps7FO2nLyY/YUlL/iNT67fwlcaLEjVPsJK5NZGvW
         XXC6MoCMl/pCCbmwRhG1MmQUXiDAx7nOaA51Hrha+Glp+aOh3J5Oc/PifDtQV03ryZFv
         Upbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749717476; x=1750322276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v6p1j1qTLF2MFMW2J8lJBrQ9BSh4eJu4r76wlgaGnm0=;
        b=thO381EcMlKln8J9g7PJsuME873ike3VFOtFpK1cwQJRVTSh4AqLa2iEFPoVcovAPe
         tnFWzibKfhuKo1K9jb4JO/I6QBQ3Jtx6XNBNp5FNsIxbLD6UrfCDf6Unu7KjxrTjn0Fo
         MrDbLkdoaMqZa7ncbEeqeHX3gcc9DVzmC+13AVsW9oQkRMDvoM2192gdEejXsBiM19a4
         DXdcdVymJqZ2EEYmn9PYppacKZMtrRccLHCsCLRB2CEU4QZ0I/agtJaKJA/yhp+D/i+l
         tWEYRWIMJPZMnEG7oXSDHObYktNcqvkXFTTtbDxKcqX1Vs+FXy0t/4ZLRojWoE1gFSLw
         YMjA==
X-Forwarded-Encrypted: i=1; AJvYcCVTdq0UkFdsZNYLnloJ3EYYkaLFuadcc5/brBqvUM4ii0bg/IRiIiw/otDmCyynt0vZjYYXf6yo@vger.kernel.org, AJvYcCXwW51Zem9BvYrsBwB1h0ja9X3Qw8MT2alNc61Te7nLgLEqdhYuyzudF82kTZ7/I4rvKTSWEDLgKWI/qlU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB7imojE0wgdhIYyiZV6wLyWtDdVkH/QPdVO815ByNQG0dUKZg
	GwiTIUIqRpN+kw2/rrgrFmoLmAfrLlpKtwHj/5uQQpTeHLZCankyPoYE
X-Gm-Gg: ASbGnctH9hHEFrCm2D4keOu06fHOIunA1wlMv45CCPPFZIfUleyXrwHC648LqRp8u/U
	e4uWlQb1A3ABzqy0+qOGsxxDzJNxxD4yTBKteVA//9wkJcvIKyNumUmj1TEj9064ojQgeIgR+uB
	LWnqCDge/iMxytm/kNKeYSgz7Ah1w7KvDa4BX47EcRHuUB671Y/grx9+VfwwMeOjZMG16bFBty4
	FNjcMoXt57xfW8mS0LxrLRtGBg4qXD7K8sIgzKoNvrhOZFaA5NheTa02Vr/f1OZEEDUREo11Zh3
	bWooW8+gQgYO1+XWDLMXxNh8z9BNY8BPmrvKyW3qtSIfFIiGMycIO9hi3K3Y93wxZ4OmlD7Ibhu
	kLxml09f47fPvz2H4vIhhqYMgCEGx1okl96EFH4VYmD3qp+MgVFS8Fg3eOaZ2POorYng/DnAlnx
	z5lQ==
X-Google-Smtp-Source: AGHT+IE6XC/rxyJu1agJncMCz8ww7gnk0K0k0u9ms/Fu0Bj20CXryD0+vvWJio/WYUFMokY33rV/0Q==
X-Received: by 2002:a05:6000:2312:b0:3a5:2b1e:c49b with SMTP id ffacd0b85a97d-3a560828446mr2072372f8f.29.1749717475630;
        Thu, 12 Jun 2025 01:37:55 -0700 (PDT)
Received: from slimbook.localdomain (2a02-9142-4580-1900-0000-0000-0000-0011.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:1900::11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e224956sm13350975e9.4.2025.06.12.01.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 01:37:54 -0700 (PDT)
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
Subject: [PATCH net-next v3 05/14] net: dsa: b53: add support for FDB operations on 5325/5365
Date: Thu, 12 Jun 2025 10:37:38 +0200
Message-Id: <20250612083747.26531-6-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250612083747.26531-1-noltari@gmail.com>
References: <20250612083747.26531-1-noltari@gmail.com>
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

 v3: add changes requested by Florian:
  - B53_VLAN_ID_IDX exists in newer BCM5325E switches.

 v2: add changes requested by Jonas and fix proposed by Florian:
  - Add b53_arl_to_entry_25 function.
  - Add b53_arl_from_entry_25 function.
  - Add b53_arl_read_25 function, fixing usage of ARLTBL_VALID_25 and
    ARLTBL_VID_MASK_25.

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 2975dab6ee0bb..f897fab6b5896 100644
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
@@ -1778,14 +1817,18 @@ static int b53_arl_op(struct b53_device *dev, int op, int port,
 
 	/* Perform a read for the given MAC and VID */
 	b53_write48(dev, B53_ARLIO_PAGE, B53_MAC_ADDR_IDX, mac);
-	b53_write16(dev, B53_ARLIO_PAGE, B53_VLAN_ID_IDX, vid);
+	if (!is5325m(dev))
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
@@ -1829,12 +1872,17 @@ static int b53_arl_op(struct b53_device *dev, int op, int port,
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
@@ -1846,12 +1894,6 @@ int b53_fdb_add(struct dsa_switch *ds, int port,
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
@@ -1878,10 +1920,15 @@ EXPORT_SYMBOL(b53_fdb_del);
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
 
@@ -1898,13 +1945,24 @@ static void b53_arl_search_rd(struct b53_device *dev, u8 idx,
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
@@ -1925,14 +1983,20 @@ int b53_fdb_dump(struct dsa_switch *ds, int port,
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
index deea4d83f0e93..2da71e967310c 100644
--- a/drivers/net/dsa/b53/b53_priv.h
+++ b/drivers/net/dsa/b53/b53_priv.h
@@ -310,6 +310,19 @@ static inline void b53_arl_to_entry(struct b53_arl_entry *ent,
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
@@ -324,6 +337,22 @@ static inline void b53_arl_from_entry(u64 *mac_vid, u32 *fwd_entry,
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


