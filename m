Return-Path: <netdev+bounces-236676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 38344C3EE1B
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 09:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B678234C10E
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 08:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E6E30F814;
	Fri,  7 Nov 2025 08:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjTGTuUr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C10530FC3F
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 08:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762502887; cv=none; b=EmHsyxYy2LdHrZEIJN+LYlV48KzcYWjARC5o3TBQVFIMcBbN/c1VHWsvcq/sXNsUHnw0/ECroKETRdR+5mVMdi2cFouHZQnPX3KwHtcY0+fRPc2RwOprOhNexmNd3eBmrUvT7zOjwqVfJZxWwwohaEnVqFys+IqcDotiXJS+6FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762502887; c=relaxed/simple;
	bh=c/ypx/7KDRitSfXO3iv/XG5GJJGXfdxf5+ySmcx3JiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I8LmvRYduRq/2d1XVIdSub+iWhwhH7zCkMRX52MODoEii+K2/dczhpXZOr1ua68i8WMHQND5fMmOdaIU884x+K05DC7JEwPUgyYNmDFFukhj++GiBsgWN3ZSrGo3MPIQwKyy3+I0ZooW2Gn+20knebyJveKQwwEWgKB9rvGPSYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QjTGTuUr; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b72134a5125so69880766b.0
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 00:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762502884; x=1763107684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AliuwcJnqc6fNYruuHtll/VWN2+GFQQMz8uQSPpdEUc=;
        b=QjTGTuUrmMwl1d16OgsrkmJ6o1hDSFNobzew3cZKkujplevGxZRuunh5VcnNtH3315
         8qFLUkV1iKs2IAdtI4jwlnaZOqn2D0vF1nSLipefVm2k2W+ofSNMiDLGM1yE/k7H4ZAE
         JCldsgVSCMy7EPAo8eqCiLJUs6FKygwLFjCUHff8PBDfACJiorqbv0ttqLpPrX2knqIf
         TLiwU4AyaSqF9Gp+wWyvwxgm8V68H+EzZlQwl1JnD36dXdlvhJTc0FA1soWPtdKHKbXl
         aWNowiEnrkvA0tjpzZw0KhXH6cKcbKTM2Pv3s6u7kGZVIOelQbSXGdScvHzkeC3O39C0
         +1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762502884; x=1763107684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AliuwcJnqc6fNYruuHtll/VWN2+GFQQMz8uQSPpdEUc=;
        b=meKvpFSMfcBrBNm6CvzUREb6a9WZDtuIqFLNN1qjINbKM29BzULc6t+ouWxghZsh45
         nLI3q9rTvtR8+JHj0SqL/0eGKK2pCMIcBCXBF2UwDKg13i7unjK+EDTO0F6D+oQL0lFi
         dzeivCDCvCmf6oy394LjGWQ7WfBvAuhSw8uuOo9J/45jl8AsKU0N19THlHLXYQGSOYLc
         4hvkJqUVc6Fbhkee7sJL0xG0iZBYj5RoLomg+6xszb/JFyW8pxO/9mDdU7+V0s5HvXwl
         1OlKmVDXNyRx/762Xqc5VA0N6QGVfckliNYImakxvkbOlUccF/jvF79qIUkc9nsW22xb
         ponw==
X-Gm-Message-State: AOJu0YzH7h2UbgAc4ARRH5B6jdIiSC8S1zOW0TY4MmRJGIQVtCyq+b5m
	2XWZK4tUwHVOxhhypLn+GC4SJh8n+f5PhqnZ0qE9anaA0eI8Mb2OmBe7
X-Gm-Gg: ASbGncsAYlc4MUJsM9iFPUzh9wbebxg85wphCPUZ9rhuwyZW9gtg/+QCExrTMI6LJFN
	KbU8cTvXvWxZzi0xxYVX5WeIKDm3WDrVCjXHQR57CAA4SzWBJAiT5drDZzPAfQlWFwmy+kA/fLH
	5cmum77Caf7rSrzsuhcsfVOWRCX0hsrNiX3A4uRvt/vH05ipfaE+j7K4zGB3bdY1x6FTMAD+lmX
	tiAU46ja70KYGg+zPEZ/4SnRHfqWGF/evrqzvr57Jpk0pVo4qf0UQEiwbZDSStTKJG0Ardmo9cB
	NKRvq00aIesh3s6Yj3VPlfbEG4ZEKGWWre9O9cXs1KtPkVf9QbYmcfierjED9DrKVDtzHYeze0e
	GC5wGnTXpWFCL2OGNO09aY8GK1uhFjI6pArK8Mn5BnR7xgKXyfbgwzhgcsh6kF1D4M/VJTBpfWq
	vRZx48QxiS68H1byn31/Unu+OsXQPYi4eYE8BFZdyFhUpwYW7Ksy91GuUh
X-Google-Smtp-Source: AGHT+IEstEw1exNyTbFuvnvrUK3nX+jDWzrwRf9MNF5NOkcJ6wg9CRw5gIOyRK6s0Hlt8IeRAvgQVw==
X-Received: by 2002:a17:907:9607:b0:b70:b5b9:1f82 with SMTP id a640c23a62f3a-b72c0abcb78mr238175466b.31.1762502882846;
        Fri, 07 Nov 2025 00:08:02 -0800 (PST)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72d32e25f6sm46179466b.5.2025.11.07.00.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 00:08:02 -0800 (PST)
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
Subject: [PATCH net-next 3/8] net: dsa: b53: move writing ARL entries into their own functions
Date: Fri,  7 Nov 2025 09:07:44 +0100
Message-ID: <20251107080749.26936-4-jonas.gorski@gmail.com>
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

Move writing ARL entries into individual functions for each format.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 38 ++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index d99e15a7a6bb..9eb7ca878e30 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1860,6 +1860,16 @@ static void b53_arl_read_entry_25(struct b53_device *dev,
 	b53_arl_to_entry_25(ent, mac_vid);
 }
 
+static void b53_arl_write_entry_25(struct b53_device *dev,
+				   const struct b53_arl_entry *ent, u8 idx)
+{
+	u64 mac_vid;
+
+	b53_arl_from_entry_25(&mac_vid, ent);
+	b53_write64(dev, B53_ARLIO_PAGE, B53_ARLTBL_MAC_VID_ENTRY(idx),
+		    mac_vid);
+}
+
 static void b53_arl_read_entry_95(struct b53_device *dev,
 				  struct b53_arl_entry *ent, u8 idx)
 {
@@ -1872,6 +1882,19 @@ static void b53_arl_read_entry_95(struct b53_device *dev,
 	b53_arl_to_entry(ent, mac_vid, fwd_entry);
 }
 
+static void b53_arl_write_entry_95(struct b53_device *dev,
+				   const struct b53_arl_entry *ent, u8 idx)
+{
+	u32 fwd_entry;
+	u64 mac_vid;
+
+	b53_arl_from_entry(&mac_vid, &fwd_entry, ent);
+	b53_write64(dev, B53_ARLIO_PAGE, B53_ARLTBL_MAC_VID_ENTRY(idx),
+		    mac_vid);
+	b53_write32(dev, B53_ARLIO_PAGE, B53_ARLTBL_DATA_ENTRY(idx),
+		    fwd_entry);
+}
+
 static int b53_arl_read(struct b53_device *dev, const u8 *mac,
 			u16 vid, struct b53_arl_entry *ent, u8 *idx)
 {
@@ -1912,9 +1935,8 @@ static int b53_arl_op(struct b53_device *dev, int op, int port,
 		      const unsigned char *addr, u16 vid, bool is_valid)
 {
 	struct b53_arl_entry ent;
-	u32 fwd_entry;
-	u64 mac, mac_vid = 0;
 	u8 idx = 0;
+	u64 mac;
 	int ret;
 
 	/* Convert the array into a 64-bit MAC */
@@ -1947,7 +1969,6 @@ static int b53_arl_op(struct b53_device *dev, int op, int port,
 		/* We could not find a matching MAC, so reset to a new entry */
 		dev_dbg(dev->dev, "{%pM,%.4d} not found, using idx: %d\n",
 			addr, vid, idx);
-		fwd_entry = 0;
 		break;
 	default:
 		dev_dbg(dev->dev, "{%pM,%.4d} found, using idx: %d\n",
@@ -1975,16 +1996,9 @@ static int b53_arl_op(struct b53_device *dev, int op, int port,
 	ent.is_age = false;
 	memcpy(ent.mac, addr, ETH_ALEN);
 	if (is5325(dev) || is5365(dev))
-		b53_arl_from_entry_25(&mac_vid, &ent);
+		b53_arl_write_entry_25(dev, &ent, idx);
 	else
-		b53_arl_from_entry(&mac_vid, &fwd_entry, &ent);
-
-	b53_write64(dev, B53_ARLIO_PAGE,
-		    B53_ARLTBL_MAC_VID_ENTRY(idx), mac_vid);
-
-	if (!is5325(dev) && !is5365(dev))
-		b53_write32(dev, B53_ARLIO_PAGE,
-			    B53_ARLTBL_DATA_ENTRY(idx), fwd_entry);
+		b53_arl_write_entry_95(dev, &ent, idx);
 
 	return b53_arl_rw_op(dev, 0);
 }
-- 
2.43.0


