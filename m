Return-Path: <netdev+bounces-236679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFA1C3EE3F
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 09:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 988FC3B2241
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 08:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0558D3128BF;
	Fri,  7 Nov 2025 08:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WuTX3r+G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DBD3126D9
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 08:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762502890; cv=none; b=gCCCIms0J+rUr4SJdMz7LNrshSNbDEvEbLsRwc7p+kyTr2q+lEVhi3hos0g2PG5TLb7M6Lps5qhKepjHnV4EW/CUYHGANgWVVZl8jhlIaidXrOIteOiI0fZ3aOeEWUCbdn5wwm87J9MszW2TD56Yf5+RGNLzb2Z0WWOl3DURvjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762502890; c=relaxed/simple;
	bh=n1o2qVzRCeAQ0PlnG+136G/ur00iG4oZfa976larNhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NhbFULU3GfgrLpGLptQkxpPvrpDbka/NdBnTRXKZVlpT+QZnOKoJfWQCO0UELFch1+OO6aw9m7yeuCWKMhFQQOSGC8wxwTXWWYxVwmzdCPzwuk4tqvmAfl645zRCZJV5M/IDOHu+PurdBUzJu96WfoP3r0BHBi+x0GKHV6efKyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WuTX3r+G; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6406f3dcc66so824747a12.3
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 00:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762502887; x=1763107687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dJKILKo+cVHMeov0d3h84V9BorLUd9uzSRayOoEA/yU=;
        b=WuTX3r+G1X1sw5OGL6vp/F501Caoy9TsxPfF4cj7yiGZUgrdp3Rj89Ghucnn8ExuKt
         U1jT39iqVgnYyPav+BUKx5Rcfax93k0sW86hsA3yLh8J4QUVRt5j+aTGa6zMho3KeBJj
         Jj6UZw1i/5FGoBrVjBsGzLHaQGEn3JjWa3ALr3NZZtfZdbR2RV/cGmKJjlMW9sXZPsbY
         tpuzF8qyw1qOYj86kq8YQvYavIoMM5tn+R/XE+1fszIzMbDoNO97rMVqm9xmKVUygIsm
         E9ULyiQd9WlGiT6ypx2t7hrZv7hRtmg7FiplBiM3292+PVdqwDI1NQeALaDpjOEynpH4
         m8ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762502887; x=1763107687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dJKILKo+cVHMeov0d3h84V9BorLUd9uzSRayOoEA/yU=;
        b=Kj6gtTtxRBxE8r5e91r/CNyEjwChnol+jebrhYFYMfDoHUPFSMVr4QaizIySCTwb0G
         ERFCOXMdWSHz+9dyqEsPyrhWe1mctMZOo2ASTSdw2BtMwrjNYagWO+X7f5ync4dG1ViD
         DFjJRE1EtqLooVoXbY+JJrOurPZghH5HKF7/8VoB9CFB6tWYhLP0p2LjhHhAls40sMya
         O5hG6P8b29yVlHIE284YWFefRA48f7q3tfwNg+12H99GPaptG7uWl5WnNVlZ812ik/dU
         o5LCUuOB4gdDAt6beN5+ZYOz42jYQ6YxCsMzgfGDO/nShGbnamA2LOrYJ52BH1yHixK7
         csyQ==
X-Gm-Message-State: AOJu0Yxs+IdlQJnFOYqcCkf6/Db5fUDdge4k0xF24c7gFGJSnAa7aLDR
	qROrw2Y7/+QLkcRGAiZbUUdo9Do53sG2WdW85TiUnSR8LgIQ1v/jrqPb
X-Gm-Gg: ASbGncthmv9eDiY5zKXaSGAaSYKhuweQw1+sBJqq+7feNQMWlMIXNhHQTraaALwOPa0
	+4/8Zo9HdRVMxUZJa9VpVG9+tePCrOO9L9B9F9ImP0oBHWKA5nWAuYXIMUxU2crK0Et4Hk0HHOW
	+YyL9h5t7pEhhI9mnv8sdgP1RgY6ShxacsMWdVelFDfCeXr5o38lfPVWL2FVlW6wftxD6RR0nQa
	2uPqBAFk+Epg4nL6y6N/pOEdnl/Sh/1pt/njS2O/SCxvH+maff2yrZ6IwcBNpMOBd5iaplBnJcw
	xCTgrvYWAveQy6Xd8DTpJimkeMoOCpemAKJbS2ydZR+3C0mJXUeuZvhXUsAAGMX3VzdGR3tsFY/
	7LbaocqbsuEX/9cEUyc50b/rWos0eHkd7pyBrp3eCYfNV1cq8k1fMDyJV8oU08q5JUO5HzLUg9l
	un2+yVTzQBG1E91BHZP0bBssfcE06I6iLNSu/FUTyNkThL17F07991SnHV
X-Google-Smtp-Source: AGHT+IEXAnb76NwN8et4HgAWUjovTDM882xzlij+ezQZc/ebJUVc4ljJCPE7t7aQ+6LIGBtYZ8MDsg==
X-Received: by 2002:a05:6402:2712:b0:640:ae02:d7cc with SMTP id 4fb4d7f45d1cf-6413f080795mr2177261a12.3.1762502887293;
        Fri, 07 Nov 2025 00:08:07 -0800 (PST)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f713970sm3633299a12.8.2025.11.07.00.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 00:08:06 -0800 (PST)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 7/8] net: dsa: b53: add support for 5389/5397/5398 ARL entry format
Date: Fri,  7 Nov 2025 09:07:48 +0100
Message-ID: <20251107080749.26936-8-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251107080749.26936-1-jonas.gorski@gmail.com>
References: <20251107080749.26936-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BCM5389, BCM5397 and BCM5398 use a different ARL entry format with just
a 16 bit fwdentry register, as well as different search control and data
offsets.

So add appropriate ops for them and switch those chips to use them.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 53 ++++++++++++++++++++++++++++++--
 drivers/net/dsa/b53/b53_priv.h   | 26 ++++++++++++++++
 drivers/net/dsa/b53/b53_regs.h   | 13 ++++++++
 3 files changed, 89 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index c69022cc85bf..73ea9adb95b7 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1870,6 +1870,31 @@ static void b53_arl_write_entry_25(struct b53_device *dev,
 		    mac_vid);
 }
 
+static void b53_arl_read_entry_89(struct b53_device *dev,
+				  struct b53_arl_entry *ent, u8 idx)
+{
+	u64 mac_vid;
+	u16 fwd_entry;
+
+	b53_read64(dev, B53_ARLIO_PAGE, B53_ARLTBL_MAC_VID_ENTRY(idx),
+		   &mac_vid);
+	b53_read16(dev, B53_ARLIO_PAGE, B53_ARLTBL_DATA_ENTRY(idx), &fwd_entry);
+	b53_arl_to_entry_89(ent, mac_vid, fwd_entry);
+}
+
+static void b53_arl_write_entry_89(struct b53_device *dev,
+				   const struct b53_arl_entry *ent, u8 idx)
+{
+	u32 fwd_entry;
+	u64 mac_vid;
+
+	b53_arl_from_entry_89(&mac_vid, &fwd_entry, ent);
+	b53_write64(dev, B53_ARLIO_PAGE,
+		    B53_ARLTBL_MAC_VID_ENTRY(idx), mac_vid);
+	b53_write16(dev, B53_ARLIO_PAGE,
+		    B53_ARLTBL_DATA_ENTRY(idx), fwd_entry);
+}
+
 static void b53_arl_read_entry_95(struct b53_device *dev,
 				  struct b53_arl_entry *ent, u8 idx)
 {
@@ -2033,6 +2058,8 @@ static void b53_read_arl_srch_ctl(struct b53_device *dev, u8 *val)
 
 	if (is5325(dev) || is5365(dev))
 		offset = B53_ARL_SRCH_CTL_25;
+	else if (dev->chip_id == BCM5389_DEVICE_ID || is5397_98(dev))
+		offset = B53_ARL_SRCH_CTL_89;
 	else
 		offset = B53_ARL_SRCH_CTL;
 
@@ -2045,6 +2072,8 @@ static void b53_write_arl_srch_ctl(struct b53_device *dev, u8 val)
 
 	if (is5325(dev) || is5365(dev))
 		offset = B53_ARL_SRCH_CTL_25;
+	else if (dev->chip_id == BCM5389_DEVICE_ID || is5397_98(dev))
+		offset = B53_ARL_SRCH_CTL_89;
 	else
 		offset = B53_ARL_SRCH_CTL;
 
@@ -2090,6 +2119,18 @@ static void b53_arl_search_read_65(struct b53_device *dev, u8 idx,
 	b53_arl_to_entry_25(ent, mac_vid);
 }
 
+static void b53_arl_search_read_89(struct b53_device *dev, u8 idx,
+				   struct b53_arl_entry *ent)
+{
+	u16 fwd_entry;
+	u64 mac_vid;
+
+	b53_read64(dev, B53_ARLIO_PAGE, B53_ARL_SRCH_RSLT_MACVID_89,
+		   &mac_vid);
+	b53_read16(dev, B53_ARLIO_PAGE, B53_ARL_SRCH_RSLT_89, &fwd_entry);
+	b53_arl_to_entry_89(ent, mac_vid, fwd_entry);
+}
+
 static void b53_arl_search_read_95(struct b53_device *dev, u8 idx,
 				   struct b53_arl_entry *ent)
 {
@@ -2683,6 +2724,12 @@ static const struct b53_arl_ops b53_arl_ops_65 = {
 	.arl_search_read = b53_arl_search_read_65,
 };
 
+static const struct b53_arl_ops b53_arl_ops_89 = {
+	.arl_read_entry = b53_arl_read_entry_89,
+	.arl_write_entry = b53_arl_write_entry_89,
+	.arl_search_read = b53_arl_search_read_89,
+};
+
 static const struct b53_arl_ops b53_arl_ops_95 = {
 	.arl_read_entry = b53_arl_read_entry_95,
 	.arl_write_entry = b53_arl_write_entry_95,
@@ -2747,7 +2794,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.duplex_reg = B53_DUPLEX_STAT_GE,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
-		.arl_ops = &b53_arl_ops_95,
+		.arl_ops = &b53_arl_ops_89,
 	},
 	{
 		.chip_id = BCM5395_DEVICE_ID,
@@ -2775,7 +2822,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.duplex_reg = B53_DUPLEX_STAT_GE,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
-		.arl_ops = &b53_arl_ops_95,
+		.arl_ops = &b53_arl_ops_89,
 	},
 	{
 		.chip_id = BCM5398_DEVICE_ID,
@@ -2789,7 +2836,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.duplex_reg = B53_DUPLEX_STAT_GE,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
-		.arl_ops = &b53_arl_ops_95,
+		.arl_ops = &b53_arl_ops_89,
 	},
 	{
 		.chip_id = BCM53101_DEVICE_ID,
diff --git a/drivers/net/dsa/b53/b53_priv.h b/drivers/net/dsa/b53/b53_priv.h
index ef2413509b5d..d6d25bb3945b 100644
--- a/drivers/net/dsa/b53/b53_priv.h
+++ b/drivers/net/dsa/b53/b53_priv.h
@@ -353,6 +353,18 @@ static inline void b53_arl_to_entry_25(struct b53_arl_entry *ent,
 	ent->vid = mac_vid >> ARLTBL_VID_S_65;
 }
 
+static inline void b53_arl_to_entry_89(struct b53_arl_entry *ent,
+				       u64 mac_vid, u16 fwd_entry)
+{
+	memset(ent, 0, sizeof(*ent));
+	ent->port = fwd_entry & ARLTBL_DATA_PORT_ID_MASK_89;
+	ent->is_valid = !!(fwd_entry & ARLTBL_VALID_89);
+	ent->is_age = !!(fwd_entry & ARLTBL_AGE_89);
+	ent->is_static = !!(fwd_entry & ARLTBL_STATIC_89);
+	u64_to_ether_addr(mac_vid, ent->mac);
+	ent->vid = mac_vid >> ARLTBL_VID_S;
+}
+
 static inline void b53_arl_from_entry(u64 *mac_vid, u32 *fwd_entry,
 				      const struct b53_arl_entry *ent)
 {
@@ -383,6 +395,20 @@ static inline void b53_arl_from_entry_25(u64 *mac_vid,
 		*mac_vid |= ARLTBL_AGE_25;
 }
 
+static inline void b53_arl_from_entry_89(u64 *mac_vid, u32 *fwd_entry,
+					 const struct b53_arl_entry *ent)
+{
+	*mac_vid = ether_addr_to_u64(ent->mac);
+	*mac_vid |= (u64)(ent->vid & ARLTBL_VID_MASK) << ARLTBL_VID_S;
+	*fwd_entry = ent->port & ARLTBL_DATA_PORT_ID_MASK_89;
+	if (ent->is_valid)
+		*fwd_entry |= ARLTBL_VALID_89;
+	if (ent->is_static)
+		*fwd_entry |= ARLTBL_STATIC_89;
+	if (ent->is_age)
+		*fwd_entry |= ARLTBL_AGE_89;
+}
+
 static inline void b53_arl_read_entry(struct b53_device *dev,
 				      struct b53_arl_entry *ent, u8 idx)
 {
diff --git a/drivers/net/dsa/b53/b53_regs.h b/drivers/net/dsa/b53/b53_regs.h
index c36a3dfb2ee8..c303507d3034 100644
--- a/drivers/net/dsa/b53/b53_regs.h
+++ b/drivers/net/dsa/b53/b53_regs.h
@@ -346,12 +346,20 @@
 #define   ARLTBL_STATIC			BIT(15)
 #define   ARLTBL_VALID			BIT(16)
 
+/* BCM5389 ARL Table Data Entry N Register format (16 bit) */
+#define   ARLTBL_DATA_PORT_ID_MASK_89	GENMASK(8, 0)
+#define   ARLTBL_TC_MASK_89		GENMASK(12, 10)
+#define   ARLTBL_AGE_89			BIT(13)
+#define   ARLTBL_STATIC_89		BIT(14)
+#define   ARLTBL_VALID_89		BIT(15)
+
 /* Maximum number of bin entries in the ARL for all switches */
 #define B53_ARLTBL_MAX_BIN_ENTRIES	4
 
 /* ARL Search Control Register (8 bit) */
 #define B53_ARL_SRCH_CTL		0x50
 #define B53_ARL_SRCH_CTL_25		0x20
+#define B53_ARL_SRCH_CTL_89		0x30
 #define   ARL_SRCH_VLID			BIT(0)
 #define   ARL_SRCH_STDN			BIT(7)
 
@@ -359,10 +367,12 @@
 #define B53_ARL_SRCH_ADDR		0x51
 #define B53_ARL_SRCH_ADDR_25		0x22
 #define B53_ARL_SRCH_ADDR_65		0x24
+#define B53_ARL_SRCH_ADDR_89		0x31
 #define  ARL_ADDR_MASK			GENMASK(14, 0)
 
 /* ARL Search MAC/VID Result (64 bit) */
 #define B53_ARL_SRCH_RSTL_0_MACVID	0x60
+#define B53_ARL_SRCH_RSLT_MACVID_89	0x33
 
 /* Single register search result on 5325 */
 #define B53_ARL_SRCH_RSTL_0_MACVID_25	0x24
@@ -372,6 +382,9 @@
 /* ARL Search Data Result (32 bit) */
 #define B53_ARL_SRCH_RSTL_0		0x68
 
+/* BCM5389 ARL Search Data Result (16 bit) */
+#define B53_ARL_SRCH_RSLT_89		0x3b
+
 #define B53_ARL_SRCH_RSTL_MACVID(x)	(B53_ARL_SRCH_RSTL_0_MACVID + ((x) * 0x10))
 #define B53_ARL_SRCH_RSTL(x)		(B53_ARL_SRCH_RSTL_0 + ((x) * 0x10))
 
-- 
2.43.0


