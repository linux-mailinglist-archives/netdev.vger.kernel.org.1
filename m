Return-Path: <netdev+bounces-236675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DB4C3EE12
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 09:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B23C18883CB
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 08:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D85E30FF21;
	Fri,  7 Nov 2025 08:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYy/2jEt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8458B30F922
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 08:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762502885; cv=none; b=lSw6QOqHH8Cc7CS7G9y5AzQ7/4MvEfZxEhB4pFxpKSeJxJkZikEBzpbPoPi6WtuG2J616nVvPGKHMsSpit5Apk2kuY4yB63kmw2I7qmH/E0zM17bPCFsW1RLFHYjbXb01TSAx7CvuqbSUF7ZD/SAj2vJUVKj8IlVW1u3g+ooeeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762502885; c=relaxed/simple;
	bh=j0oyfuN01OPXLd9hyxYNT5N8BjkO/t6pWjUs7ekl2EE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ic/xTIPDIgaRIVg9Wa1kt0YaPqtjwf9+Alf2Z+DgyBUUdqUlKGXfTksJcrXlIcdLj3P8UXGTCo2dZoh3sMJNpWq4Xm9CI9wKQFDIls3vPCjEF7ZFXWrMb+cnUWIKET2aga7is7g2q4IPZ8Ut+wzxgCwFcd4TJT+64W7H7MQAxDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYy/2jEt; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-640860f97b5so773237a12.2
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 00:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762502882; x=1763107682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KUZshOJG4dcKBIAa7zdLK2nV4L6UQD0RZnMTyvlffFQ=;
        b=EYy/2jEtmw3HC7l/Kq53RqwQFS9qqZAWy0xv1kbIH/rTrAlwBG8mWpn+w5Wf+f11cS
         0iRrDl6O7ShPCox0rdRxxc5m7O67aZ7bzCIzPMqhDGVQFn8zW3piucycNDki01QuClCo
         wH2NjYTtLNXb9M00ZTf+zcKEMkszZWmvjKKaBInuS2AsGvZ0amZvVMSR4thCMu52pXdQ
         UeymmFx/jw0H7Gu4d71eXs05pJA9OLCuF1YfAZKLd3ZWAaHCJ4M6W5s6+jRnRBAwhsZp
         caF5LgI358hZ4vnuoSoaEYpH4ycYlufdwqqk8PGciHumvjT8KF+9d6oiLr0+cl9fNW0q
         PJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762502882; x=1763107682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KUZshOJG4dcKBIAa7zdLK2nV4L6UQD0RZnMTyvlffFQ=;
        b=XGmB8VxXXS+Zp2F96IdKtcH6Dry2eNbMnG84aRBPcKyTsuUDBu/3mHWfjqrOelVvdx
         QCt9zuEdS8cpnC86iOb6S5UFLhRhLBDHqGCEh45wtc6bQxowYsWeL9Oos94RRuYDRqQh
         5FA0+Hx1c30nJXxKy6vie/VD3mx589bNYmxLGQx8hiFJs33tN/JaEep1jvB0ljEaUhPr
         2OSjLoSJvf4Ms4PmZZix+x1xxfWGTO45B+kc44oC0pkDsxNNmMkAzCEEpLmCe5xXkcTz
         2VoEVc86duDXwkA42v85sM1sBw6ZTpOLOSFqg7BiJN+iyUE71TIR7qWW9FeOPCWm8SK3
         i8IQ==
X-Gm-Message-State: AOJu0YxKoB68BQ5t56Fq6TPM1p4A2rPWtl7jD0cWd9w+GvfKdzEnNwub
	4GWgdSYsW8g+PD7KQjyvqlAYDE800uGSV3q6YXdbOOAar9rV3cGtxoZx
X-Gm-Gg: ASbGncuaTOU1Z1Pq1JuuHtN6WSCCbccmJGy0PC9iocnzuBHYZw6UbYwBs1iO6qrFO1W
	v+2Wp4nMnNvGuGMPAG7FSBtvVtRRpPOcpmUjKU9soQqHFH+FOwdM8ufPecPzW7BgruK8kFYkBBY
	74wTGEQ20IUJ84+/jWhzrs6VWb0GhJerQBXy+0OcpZ3sEzw0gFiZe3GPDR148OdkhlT5KaqkVIB
	VoCkCRfWxwxzoSrtS87NZoL1Sr0GYO3sJo6PtOribQmngAsVx8hCWW0Ubs/1fiasB4vpkewpgMg
	DDUOwq4cvE/5eu1ePucONnnYFylTFuNXhFBGzaQLy96h6gFKT6beiAJwoDtyur+dt1+8GcOewdN
	Ri4Fxx2c+tLlkNYZL9gHRMOP83Is/xdyx43BE/dT9qG3E95Ns4rTB12jc7crOnE/WRC6yoEnBRJ
	AzWDlQAKXXU1PCMH1r877JX+z9HMOdvlTtc2T7n4mlSK7eCIUGyRUSbo0+6fkEQjsIITo=
X-Google-Smtp-Source: AGHT+IE33si3STkKaWiJ5TOQMCTy4+JpRVeKTJuZw7lB6vjQoOtoBqnMfAW/gzxY8jDDyD0iEzAakw==
X-Received: by 2002:a17:907:9617:b0:b70:fede:1b58 with SMTP id a640c23a62f3a-b72c0a5f78dmr243322566b.2.1762502881786;
        Fri, 07 Nov 2025 00:08:01 -0800 (PST)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf60ef8asm173802366b.30.2025.11.07.00.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 00:08:01 -0800 (PST)
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
Subject: [PATCH net-next 2/8] net: dsa: b53: move reading ARL entries into their own function
Date: Fri,  7 Nov 2025 09:07:43 +0100
Message-ID: <20251107080749.26936-3-jonas.gorski@gmail.com>
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

Instead of duplicating the whole code iterating over all bins for
BCM5325, factor out reading and parsing the entry into its own
functions, and name it the modern one after the first chip with that ARL
format, (BCM53)95.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 69 +++++++++++---------------------
 1 file changed, 23 insertions(+), 46 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 1b94cf7b06e8..d99e15a7a6bb 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1850,48 +1850,30 @@ static int b53_arl_rw_op(struct b53_device *dev, unsigned int op)
 	return b53_arl_op_wait(dev);
 }
 
-static int b53_arl_read(struct b53_device *dev, const u8 *mac,
-			u16 vid, struct b53_arl_entry *ent, u8 *idx)
+static void b53_arl_read_entry_25(struct b53_device *dev,
+				  struct b53_arl_entry *ent, u8 idx)
 {
-	DECLARE_BITMAP(free_bins, B53_ARLTBL_MAX_BIN_ENTRIES);
-	unsigned int i;
-	int ret;
-
-	ret = b53_arl_op_wait(dev);
-	if (ret)
-		return ret;
-
-	bitmap_zero(free_bins, dev->num_arl_bins);
-
-	/* Read the bins */
-	for (i = 0; i < dev->num_arl_bins; i++) {
-		u64 mac_vid;
-		u32 fwd_entry;
+	u64 mac_vid;
 
-		b53_read64(dev, B53_ARLIO_PAGE,
-			   B53_ARLTBL_MAC_VID_ENTRY(i), &mac_vid);
-		b53_read32(dev, B53_ARLIO_PAGE,
-			   B53_ARLTBL_DATA_ENTRY(i), &fwd_entry);
-		b53_arl_to_entry(ent, mac_vid, fwd_entry);
+	b53_read64(dev, B53_ARLIO_PAGE, B53_ARLTBL_MAC_VID_ENTRY(idx),
+		   &mac_vid);
+	b53_arl_to_entry_25(ent, mac_vid);
+}
 
-		if (!ent->is_valid) {
-			set_bit(i, free_bins);
-			continue;
-		}
-		if (!ether_addr_equal(ent->mac, mac))
-			continue;
-		if (dev->vlan_enabled && ent->vid != vid)
-			continue;
-		*idx = i;
-		return 0;
-	}
+static void b53_arl_read_entry_95(struct b53_device *dev,
+				  struct b53_arl_entry *ent, u8 idx)
+{
+	u32 fwd_entry;
+	u64 mac_vid;
 
-	*idx = find_first_bit(free_bins, dev->num_arl_bins);
-	return *idx >= dev->num_arl_bins ? -ENOSPC : -ENOENT;
+	b53_read64(dev, B53_ARLIO_PAGE, B53_ARLTBL_MAC_VID_ENTRY(idx),
+		   &mac_vid);
+	b53_read32(dev, B53_ARLIO_PAGE, B53_ARLTBL_DATA_ENTRY(idx), &fwd_entry);
+	b53_arl_to_entry(ent, mac_vid, fwd_entry);
 }
 
-static int b53_arl_read_25(struct b53_device *dev, const u8 *mac,
-			   u16 vid, struct b53_arl_entry *ent, u8 *idx)
+static int b53_arl_read(struct b53_device *dev, const u8 *mac,
+			u16 vid, struct b53_arl_entry *ent, u8 *idx)
 {
 	DECLARE_BITMAP(free_bins, B53_ARLTBL_MAX_BIN_ENTRIES);
 	unsigned int i;
@@ -1905,12 +1887,10 @@ static int b53_arl_read_25(struct b53_device *dev, const u8 *mac,
 
 	/* Read the bins */
 	for (i = 0; i < dev->num_arl_bins; i++) {
-		u64 mac_vid;
-
-		b53_read64(dev, B53_ARLIO_PAGE,
-			   B53_ARLTBL_MAC_VID_ENTRY(i), &mac_vid);
-
-		b53_arl_to_entry_25(ent, mac_vid);
+		if (is5325(dev) || is5365(dev))
+			b53_arl_read_entry_25(dev, ent, i);
+		else
+			b53_arl_read_entry_95(dev, ent, i);
 
 		if (!ent->is_valid) {
 			set_bit(i, free_bins);
@@ -1950,10 +1930,7 @@ static int b53_arl_op(struct b53_device *dev, int op, int port,
 	if (ret)
 		return ret;
 
-	if (is5325(dev) || is5365(dev))
-		ret = b53_arl_read_25(dev, addr, vid, &ent, &idx);
-	else
-		ret = b53_arl_read(dev, addr, vid, &ent, &idx);
+	ret = b53_arl_read(dev, addr, vid, &ent, &idx);
 
 	/* If this is a read, just finish now */
 	if (op)
-- 
2.43.0


