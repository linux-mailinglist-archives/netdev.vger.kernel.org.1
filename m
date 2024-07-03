Return-Path: <netdev+bounces-109059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C678926BED
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 00:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7B491F22B23
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 22:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFAF1946B4;
	Wed,  3 Jul 2024 22:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="KbdUyR7U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC05A13C8EE
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 22:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720047023; cv=none; b=arddzglhWpqJ5hd1a7s9jDLa/GJmEMkSPnDo310jidCbgNghR9gxdNvoEhwEhNjhSyjunUpcKcHrhhf59J1cY3NpTyOVqZmok3A+aAQYxJ9rUlcPPdMvaakvEHo1i8Yf6UIX420b/D2CIO/ltMiEQL8ViHdSbFSnALEnfxQfn0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720047023; c=relaxed/simple;
	bh=vWqf0Ku/TZihcy3YsfNgD8uDJxw8f2hi3jOdZ1h10GY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RjTz4zuZ6mpPRsKN1tfxjoUyYQKV0namFnPrittB26PHQUcDhuAf5u7PY1cFj4inq+LYhCleoupIiIu+w1ZVtjj8bSuH7VsdpITKCb27+9fc4CjnRIgpkenWrme0QVfoBsi2yECuSpbjNuFoz7ui6dK+DxcVr7e8mPvL5yjd7Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=KbdUyR7U; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-707040e3017so4296486a12.3
        for <netdev@vger.kernel.org>; Wed, 03 Jul 2024 15:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1720047021; x=1720651821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4+4223rrxsI4aokhw13pQNiFvacvgaAEpuPuOjIrohQ=;
        b=KbdUyR7UauBUKG63z6BkN3/bYtpO4h2UTrByGOVcDbumBVs6BJtFPuAUmupDrdoKNb
         NUsCA78lOH5t2YpKouMsvFNnCgOSqQqhz5wOxNVX6n3G8m9elqmL92H/wPVcaDmNBfXm
         w+Hu4NCoLMpTgzYydylTIff8nwhwxbY89ts9ut1MzFg4G/UmoaG/Wg+/Fow6L7/IlLb3
         DeKuOjofKQ1Rth0tT3Dl2c4sla1uDdS338yF6ABWoXdl810tJevMKTVGFHgY4kUuRdfw
         XtAiL9vpvDM5ogQ1U6LlJbGsI+CLxeFbGvGlA/5K5TYz6yHFPW3lgwVe58Wn27LlLbg6
         YPRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720047021; x=1720651821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4+4223rrxsI4aokhw13pQNiFvacvgaAEpuPuOjIrohQ=;
        b=Xqt3LvpIiHsA3tBdCj3rgIL1lkyUy9foqwsG8cxFhpbS9lNTQK6TlMnMlr2ZmO0+gt
         +3NyoG+qqgGVUl3ESpWXI2GN25eI0APWyGbiot16M43J3XXJst2Ogwh6hfBHN7ckwgUx
         SM/MJisr5DAENIDFwNtL9NM3FneNS0rNr/UMcoD74GYNLXswvjkpMMvabR1ClxL0wceo
         2sr7sFMka2U9KYWyjZSa2Jrd5R5zD9OXKECQXhwSXe9jgL+GvZuHFWCD9KhibwFUv+VO
         dC7H856mjFcdd7PjHxxehlzjFM327+56s59AtTXJxibTDa0k1067BMB5F4l7B3tVpMKX
         wr5w==
X-Forwarded-Encrypted: i=1; AJvYcCWqB7Iy5xeqZ8FL9rpoNzWzNYbOOi5NQIFpGF+4pZXd6IOLK2TP8vMl63kcjItWny6A5AfryOp+iAc1H6vdfRF7zowAGsy/
X-Gm-Message-State: AOJu0Yz02y6uG112Z+jEG5arVLp6RM+oTdFXej43AnN/BMgywzbatS+h
	u6AJpE9zbbmZWb37F+reF0NnTM0CfPAICNrZiaeFDrSARC7iQ0ngy42c+ObvgA==
X-Google-Smtp-Source: AGHT+IHosrRUDkz8fvCnRyH6UzAXi6KAalZdOFs9yqUXqj5RAe1YOZdin8uEoC4yMDi0SosN7b8Sug==
X-Received: by 2002:a05:6a20:c22:b0:1be:d7b1:2869 with SMTP id adf61e73a8af0-1bef624618fmr13517436637.56.1720047020994;
        Wed, 03 Jul 2024 15:50:20 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:af8e:aa48:5140:2b5b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1faf75b3407sm40242185ad.85.2024.07.03.15.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 15:50:20 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	cai.huoqing@linux.dev,
	netdev@vger.kernel.org,
	felipe@sipanda.io
Cc: Tom Herbert <tom@herbertland.com>
Subject: [RFC net-next 02/10] skbuff: Add csum_valid_crc32 flag
Date: Wed,  3 Jul 2024 15:48:42 -0700
Message-Id: <20240703224850.1226697-3-tom@herbertland.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240703224850.1226697-1-tom@herbertland.com>
References: <20240703224850.1226697-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a device gets notification of that a CRC has been validated
(either for SCTP or FCOE) then this is treated as an instance of
checksum-unnecessary. This creates a few problems:

1) It's incompatible with checksum-complete. We cannot do checksum-
   complete with a validate CRC at the same time
2) Checksum-unnecessary conversion may erase the indication of
   the offloaded CRC. For instance in a SCTP/UDP packet where the
   driver reports both the non-zero UDP checksum and the CRC
   have been validated (i.e. csum_level is set to 1), then checksum-
   complete conversion erases the indication and the host has to compute
   the CRC again
3) It just seems awkward in general to be mixing fundamentally different
   verifications, and wouldn't be surprising if there are bugs lurking
   in this area

This patch introduces csum_valid_crc32 flag in the skbuff. This is
used to inidicate an offloaded CRC. It's independent of the checksum
fields.

Additionally, some helper functions are added:
   - skb_csum_crc32_unnecessary
   - skb_set_csum_crc32_unnecessary
   - skb_reset_csum_crc32_unnecessary

Add comment about new method for offloading SCTP and FCOE RX CRC

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 include/linux/skbuff.h | 40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 7fd6ce4df0ec..8706984ea56e 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -119,8 +119,6 @@
  *       zero UDP checksum for either IPv4 or IPv6, the networking stack
  *       may perform further validation in this case.
  *     - GRE: only if the checksum is present in the header.
- *     - SCTP: indicates the CRC in SCTP header has been validated.
- *     - FCOE: indicates the CRC in FC frame has been validated.
  *
  *   &sk_buff.csum_level indicates the number of consecutive checksums found in
  *   the packet minus one that have been verified as %CHECKSUM_UNNECESSARY.
@@ -142,7 +140,6 @@
  *
  *   - Even if device supports only some protocols, but is able to produce
  *     skb->csum, it MUST use CHECKSUM_COMPLETE, not CHECKSUM_UNNECESSARY.
- *   - CHECKSUM_COMPLETE is not applicable to SCTP and FCoE protocols.
  *
  * - %CHECKSUM_PARTIAL
  *
@@ -156,6 +153,15 @@
  *   packet that are after the checksum being offloaded are not considered to
  *   be verified.
  *
+ * SCTP or FCOE CRC in received packets verfied by device
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ * An SCTP or FCOE CRC may be verified by device and reported as valid by a
+ * driver. This is done by setting skb->csum_valid_crc32 to 1. The helper
+ * function skb_set_csum_crc32_unnecessary should be called to do that.
+ * The CRC validation can be checked by calling skb_csum_crc32_unnecessary
+ * and cleared by calling skb_reset_csum_crc32_unnecessary
+ *
  * Checksumming on transmit for non-GSO
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  *
@@ -1008,6 +1014,9 @@ struct sk_buff {
 #if IS_ENABLED(CONFIG_IP_SCTP)
 	__u8			csum_is_crc32:1;
 #endif
+#if IS_ENABLED(CONFIG_IP_SCTP) || IS_ENABLED(CONFIG_FCOE)
+	__u8			csum_valid_crc32:1;
+#endif
 
 #if defined(CONFIG_NET_SCHED) || defined(CONFIG_NET_XGRESS)
 	__u16			tc_index;	/* traffic control index */
@@ -4453,6 +4462,31 @@ static inline int skb_csum_unnecessary(const struct sk_buff *skb)
 		 skb_checksum_start_offset(skb) >= 0));
 }
 
+static inline int skb_csum_crc32_unnecessary(const struct sk_buff *skb)
+{
+#if IS_ENABLED(CONFIG_IP_SCTP) || IS_ENABLED(CONFIG_FCOE)
+	return (skb->csum_valid_crc32 ||
+		(skb->ip_summed == CHECKSUM_PARTIAL &&
+		 skb_checksum_start_offset(skb) >= 0));
+#else
+	return 0;
+#endif
+}
+
+static inline void skb_reset_csum_crc32_unnecessary(struct sk_buff *skb)
+{
+#if IS_ENABLED(CONFIG_IP_SCTP) || IS_ENABLED(CONFIG_FCOE)
+	skb->csum_valid_crc32 = 0;
+#endif
+}
+
+static inline void skb_set_csum_crc32_unnecessary(struct sk_buff *skb)
+{
+#if IS_ENABLED(CONFIG_IP_SCTP) || IS_ENABLED(CONFIG_FCOE)
+	skb->csum_valid_crc32 = 1;
+#endif
+}
+
 /**
  *	skb_checksum_complete - Calculate checksum of an entire packet
  *	@skb: packet to process
-- 
2.34.1


