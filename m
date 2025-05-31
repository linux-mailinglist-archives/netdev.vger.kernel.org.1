Return-Path: <netdev+bounces-194496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E79EAC9A72
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 12:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0A1D168CC1
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 10:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A140023A9A8;
	Sat, 31 May 2025 10:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8wD5uJN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986FD239E92;
	Sat, 31 May 2025 10:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748686401; cv=none; b=ZXGXi+d1hyc8PJkb0bBpQSXl7SluuGNbjD75BC3sfy9Bjt2pqvLpQ++ISLvtOkZVdgmFjmK0QWXgIP93XJ3gmC+bEiMyN/HzBhQpcsOeVnrH2CfL4vX9ZUq0bZ+JDUgfrep5VcgIcRANBUTOfjFzkNVYt0vVrE/gTfXM8cjg/ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748686401; c=relaxed/simple;
	bh=BVLodL7VonUD/n+bxiZbWGzS0sRhhXUlSQa2zmJciWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e6A9KWOQxusFCfWn+fSWIZq3TkWVIxwjKSDjDqciCN84xjxxRDrRikcNUXIBKXyYhzxm8Zs6k/p6LD4BS99ckgZui/Q0v9d9LFL3KqMd1c6zSi88XeZcz1lHE7XK0rjDbAKD1LIXHOCt0zWYZLYO7o7skwHtjEXvVMFu5bw/iiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8wD5uJN; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a4f89c6e61so772092f8f.3;
        Sat, 31 May 2025 03:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748686393; x=1749291193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4Pr6ng1LZCz94G4fnmML3y/fZWMRy6IyMWJKeqgTNs=;
        b=O8wD5uJNSg/rSc95PY6rwmkE4qdP6638H+wHTNNKaPFGUcFLXEWl74/ugvi2/XE0BJ
         2Hb5jmfanaJwXjER8pzilNyyZQnlySr9sQnHFCox9fDz1st8erXhfjVaZKoWTDqeXDr7
         tQqGkODfleX4qeQG97tJ40n+E/T9yxxOH7bJdpE2/HddU6Ro8PmNwJjmORbFnn2UGZIs
         hF+d0KNcdSSsUzonnRvKBJO50DRfkVcSbwG39p9e0IWtSgi/qP8Ew1Z5UcugcnfsPbZD
         7rlmuinYVeTDKpFmoGVHt7f3ZJy1PIHvmRaRbKDk1Yp9quocsiB6iDp3cdme0ABDc1h6
         7Plw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748686393; x=1749291193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/4Pr6ng1LZCz94G4fnmML3y/fZWMRy6IyMWJKeqgTNs=;
        b=N3buXU47yZzjFDAMbtA5Biejo+zODB3jPujJbTY6DP8BOoRhza8oNsB2tP9zBJ3qdr
         UFiqjodVWEXvGgP77EnrE9y5RI/2BmKXw8tYvTKf93ffRW4YLI83J5tkIKqtoSelo4qa
         lJ8Gq1Euc74hhiruT56TOmHzcovLDqWcRBL8XYmTxefTQ4Nx0xNjliRqwinNhrPL/74z
         rFqwkYAOPlmX/2fhWj/kk27Hn+ia16bAst6rZ6NOx+DiToiZHwopEAudOtIHkHbXBUqo
         G+hHLLTuB/CqnaLSzo8TP7AuKBJAeSuq6cw7C20PDrlGGv5Q05/WVapLk6o40h+nrRdt
         havw==
X-Forwarded-Encrypted: i=1; AJvYcCU3ozZ5Eq6+CjktA1B6Fi0Xk756jFYDY/f/GOZO4gTCk8G7SBaqesAUqRNEzP7e7J6o4OrDc1ik@vger.kernel.org, AJvYcCV/vKLNsqgoBHYGy7ewrs/llUU+3np1Oqy/LhghWreFJJbpkmecd11EtFGQWB0LLg4X9uX9e0NMUmevDcs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh6RsEF5rVzE3S3iDjj+idxaLmScvj5xdpQgK7gBdGl76jUSHv
	v4WIy+89rEcZD8xEsHUQydfXgwaopwAp+f1aLITMmu8Kpos7BLyeOUmE
X-Gm-Gg: ASbGnctkm3u3gj3sFnl3kqUWC+sPb/NSCTRLtW6sowOEVQw+cqIyzjObOT9C39PSnZ4
	jdSKN9hwxku6f87G6UzlTn2P6/V4aq86Mnv1yNvdD1sre1LtZQK80ofw8nU7yR2WCd3hvmfcZUh
	Ak3EcnNqFT9ztKtYJ1R+y4i1wlbeYK1kqTbrTei5TtJw20VdeRKCKWvvAKkyPcJfimvZo7y+/hB
	FyL+qOZPhNH/+mEyUtDKzoVV6562YkfufVQLKS1XNsfi5vOy0faIOsmQNRDosZRAAGJBqsgZlrR
	MDgRQZRrW5r0wyuvihwvvd0CfxvcbcmERB6n9temKUZcFc3u/yTdungIk7tHPYAIuNxvJcM3Wsr
	jy2LRihvG/uSwfzfvZumiKmTu6R87VJ23x/QQgaO1axLur4n3lKzQ
X-Google-Smtp-Source: AGHT+IFCGhKTFhFdMf2cutlReI++c9wjRgdtgVVathqW7ed8loFYorLqGfQW4vQSXJwHu0NeDID06g==
X-Received: by 2002:a05:6000:2890:b0:3a4:d02e:84af with SMTP id ffacd0b85a97d-3a4fe3a816fmr1162119f8f.58.1748686393220;
        Sat, 31 May 2025 03:13:13 -0700 (PDT)
Received: from skynet.lan (2a02-9142-4580-1200-0000-0000-0000-0008.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:1200::8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d8000d5dsm44500205e9.26.2025.05.31.03.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 May 2025 03:13:12 -0700 (PDT)
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
Subject: [RFC PATCH 01/10] net: dsa: b53: add support for FDB operations on 5325/5365
Date: Sat, 31 May 2025 12:12:59 +0200
Message-Id: <20250531101308.155757-2-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250531101308.155757-1-noltari@gmail.com>
References: <20250531101308.155757-1-noltari@gmail.com>
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
 drivers/net/dsa/b53/b53_common.c | 60 +++++++++++++++++++++-----------
 drivers/net/dsa/b53/b53_priv.h   | 57 +++++++++++++++++++++---------
 drivers/net/dsa/b53/b53_regs.h   |  7 ++--
 3 files changed, 84 insertions(+), 40 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 132683ed3abe..03c1e2e75061 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1760,9 +1760,11 @@ static int b53_arl_read(struct b53_device *dev, u64 mac,
 
 		b53_read64(dev, B53_ARLIO_PAGE,
 			   B53_ARLTBL_MAC_VID_ENTRY(i), &mac_vid);
-		b53_read32(dev, B53_ARLIO_PAGE,
-			   B53_ARLTBL_DATA_ENTRY(i), &fwd_entry);
-		b53_arl_to_entry(ent, mac_vid, fwd_entry);
+
+		if (!is5325(dev) && !is5365(dev))
+			b53_read32(dev, B53_ARLIO_PAGE,
+				   B53_ARLTBL_DATA_ENTRY(i), &fwd_entry);
+		b53_arl_to_entry(dev, ent, mac_vid, fwd_entry);
 
 		if (!(fwd_entry & ARLTBL_VALID)) {
 			set_bit(i, free_bins);
@@ -1795,7 +1797,8 @@ static int b53_arl_op(struct b53_device *dev, int op, int port,
 
 	/* Perform a read for the given MAC and VID */
 	b53_write48(dev, B53_ARLIO_PAGE, B53_MAC_ADDR_IDX, mac);
-	b53_write16(dev, B53_ARLIO_PAGE, B53_VLAN_ID_IDX, vid);
+	if (!is5325(dev))
+		b53_write16(dev, B53_ARLIO_PAGE, B53_VLAN_ID_IDX, vid);
 
 	/* Issue a read operation for this MAC */
 	ret = b53_arl_rw_op(dev, 1);
@@ -1846,12 +1849,14 @@ static int b53_arl_op(struct b53_device *dev, int op, int port,
 	ent.is_static = true;
 	ent.is_age = false;
 	memcpy(ent.mac, addr, ETH_ALEN);
-	b53_arl_from_entry(&mac_vid, &fwd_entry, &ent);
+	b53_arl_from_entry(dev, &mac_vid, &fwd_entry, &ent);
 
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
@@ -1863,12 +1868,6 @@ int b53_fdb_add(struct dsa_switch *ds, int port,
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
@@ -1895,10 +1894,15 @@ EXPORT_SYMBOL(b53_fdb_del);
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
 
@@ -1917,11 +1921,19 @@ static void b53_arl_search_rd(struct b53_device *dev, u8 idx,
 	u64 mac_vid;
 	u32 fwd_entry;
 
-	b53_read64(dev, B53_ARLIO_PAGE,
-		   B53_ARL_SRCH_RSTL_MACVID(idx), &mac_vid);
-	b53_read32(dev, B53_ARLIO_PAGE,
-		   B53_ARL_SRCH_RSTL(idx), &fwd_entry);
-	b53_arl_to_entry(ent, mac_vid, fwd_entry);
+	if (is5325(dev)) {
+		b53_read64(dev, B53_ARLIO_PAGE, B53_ARL_SRCH_RSTL_0_MACVID_25,
+			   &mac_vid);
+	} else if (is5365(dev)) {
+		b53_read64(dev, B53_ARLIO_PAGE, B53_ARL_SRCH_RSTL_0_MACVID_65,
+			   &mac_vid);
+	} else {
+		b53_read64(dev, B53_ARLIO_PAGE, B53_ARL_SRCH_RSTL_MACVID(idx),
+			   &mac_vid);
+		b53_read32(dev, B53_ARLIO_PAGE, B53_ARL_SRCH_RSTL(idx),
+			   &fwd_entry);
+	}
+	b53_arl_to_entry(dev, ent, mac_vid, fwd_entry);
 }
 
 static int b53_fdb_copy(int port, const struct b53_arl_entry *ent,
@@ -1942,14 +1954,20 @@ int b53_fdb_dump(struct dsa_switch *ds, int port,
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
index a5ef7071ba07..05c5b9239bda 100644
--- a/drivers/net/dsa/b53/b53_priv.h
+++ b/drivers/net/dsa/b53/b53_priv.h
@@ -286,30 +286,55 @@ struct b53_arl_entry {
 	u8 is_static:1;
 };
 
-static inline void b53_arl_to_entry(struct b53_arl_entry *ent,
+static inline void b53_arl_to_entry(struct b53_device *dev,
+				    struct b53_arl_entry *ent,
 				    u64 mac_vid, u32 fwd_entry)
 {
 	memset(ent, 0, sizeof(*ent));
-	ent->port = fwd_entry & ARLTBL_DATA_PORT_ID_MASK;
-	ent->is_valid = !!(fwd_entry & ARLTBL_VALID);
-	ent->is_age = !!(fwd_entry & ARLTBL_AGE);
-	ent->is_static = !!(fwd_entry & ARLTBL_STATIC);
-	u64_to_ether_addr(mac_vid, ent->mac);
-	ent->vid = mac_vid >> ARLTBL_VID_S;
+	if (is5325(dev) || is5365(dev)) {
+		ent->port = (mac_vid >> ARLTBL_DATA_PORT_ID_S_25) &
+			    ARLTBL_DATA_PORT_ID_MASK_25;
+		ent->is_valid = !!(mac_vid & ARLTBL_VALID_25);
+		ent->is_age = !!(mac_vid & ARLTBL_AGE_25);
+		ent->is_static = !!(mac_vid & ARLTBL_STATIC_25);
+		u64_to_ether_addr(mac_vid, ent->mac);
+		ent->vid = mac_vid >> ARLTBL_VID_S_65;
+	} else {
+		ent->port = fwd_entry & ARLTBL_DATA_PORT_ID_MASK;
+		ent->is_valid = !!(fwd_entry & ARLTBL_VALID);
+		ent->is_age = !!(fwd_entry & ARLTBL_AGE);
+		ent->is_static = !!(fwd_entry & ARLTBL_STATIC);
+		u64_to_ether_addr(mac_vid, ent->mac);
+		ent->vid = mac_vid >> ARLTBL_VID_S;
+	}
 }
 
-static inline void b53_arl_from_entry(u64 *mac_vid, u32 *fwd_entry,
+static inline void b53_arl_from_entry(struct b53_device *dev,
+				      u64 *mac_vid, u32 *fwd_entry,
 				      const struct b53_arl_entry *ent)
 {
 	*mac_vid = ether_addr_to_u64(ent->mac);
-	*mac_vid |= (u64)(ent->vid & ARLTBL_VID_MASK) << ARLTBL_VID_S;
-	*fwd_entry = ent->port & ARLTBL_DATA_PORT_ID_MASK;
-	if (ent->is_valid)
-		*fwd_entry |= ARLTBL_VALID;
-	if (ent->is_static)
-		*fwd_entry |= ARLTBL_STATIC;
-	if (ent->is_age)
-		*fwd_entry |= ARLTBL_AGE;
+	if (is5325(dev) || is5365(dev)) {
+		*mac_vid |= (u64)(ent->port & ARLTBL_DATA_PORT_ID_MASK_25) <<
+				  ARLTBL_DATA_PORT_ID_S_25;
+		*mac_vid |= (u64)(ent->vid & ARLTBL_VID_MASK_25) <<
+				  ARLTBL_VID_S_65;
+		if (ent->is_valid)
+			*mac_vid |= ARLTBL_VALID_25;
+		if (ent->is_static)
+			*mac_vid |= ARLTBL_STATIC_25;
+		if (ent->is_age)
+			*mac_vid |= ARLTBL_AGE_25;
+	} else {
+		*mac_vid |= (u64)(ent->vid & ARLTBL_VID_MASK) << ARLTBL_VID_S;
+		*fwd_entry = ent->port & ARLTBL_DATA_PORT_ID_MASK;
+		if (ent->is_valid)
+			*fwd_entry |= ARLTBL_VALID;
+		if (ent->is_static)
+			*fwd_entry |= ARLTBL_STATIC;
+		if (ent->is_age)
+			*fwd_entry |= ARLTBL_AGE;
+	}
 }
 
 #ifdef CONFIG_BCM47XX
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


