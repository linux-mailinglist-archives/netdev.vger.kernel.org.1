Return-Path: <netdev+bounces-262261-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CP9nLDZ5o2lvEAUAu9opvQ
	(envelope-from <netdev+bounces-262261-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 00:24:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7AE1C9AF9
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 00:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6874305540E
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 23:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DAB83E0C5C;
	Sat, 28 Feb 2026 23:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6drrikf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C46F3B3C14
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 23:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772320989; cv=none; b=mrmSO3/fyDG5kmro8ifuF3DGwaqVEYU27ciwFM0Tm/DRwgksBqkE0gKRFGFBGiGSRVgLknsC7lTIbWESiN731h2BI/dWi0lz+iX8uOma0ufqxLCrYslvUf9V5sovH7TftqBLtPxYyXIgq5WJ+vK1FH1Q+MR3I2jdtPMxodIPqKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772320989; c=relaxed/simple;
	bh=6MGxm/fgJ5bkzDB43ONDayAw+9QBpNWDaDqUHZZveWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IE3zjHkJxVGMoK6xwWxfALnxSF9Z9/7lkprSOtGv2rVPf2WKsvgGzqTcSeMzdODtiYbdOQ0oDKjT4D7lnw7XF2e2ouCbLsy3Bvq5A+VsHfLFHZX7oYTTulw/aqDiq89Da7gF8w3kJfhbZpUaXQe7cO5d1/rC53aILN16GFqUIvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6drrikf; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48375f1defeso23326445e9.0
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 15:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772320986; x=1772925786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x8gi44qcEURz8IdVWGsHR4vcJOzvUGKuaF1I7xr8jDI=;
        b=P6drrikfmhkAwMxlW9MakD6X8AX2vpYEmOABfFjcSNZtTArdBDi4mPSS1fqrzacsqp
         0aTe6bFrhIoP0Y4/tdYqG+mEOO/YTGpxF5z2XlACw9F4eLlvYglvYU7CwGYvmzYHe3+Y
         p78T6WU4J2lWwn2wcQJAkWnmSv52jcsrQ1nDaqzTwoq29iRebQjQOs0lPpZhYM42Vznf
         ga+7kLuy1ooE+hp6yd2kh405PXRlhmeH/8tJrEupU9wTX6DYjo8adgU5Nx6+ldDyCjGg
         AOyxgJuSt//OWYD0gLmShuOhcpNtzW+LFyCSB2e++Pnc4g4hMStXkmLKsuLpG5wVGlLT
         WQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772320986; x=1772925786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x8gi44qcEURz8IdVWGsHR4vcJOzvUGKuaF1I7xr8jDI=;
        b=sw/euONdd2TiOkUwryMag949QB8R1ZHhu4PWknKpGFVzugQD9+p0qUe6jIEhv1U0hV
         +eNdzEdMJ6IwAtExcLdWVRlgLJiJLE9CREm23TQfR1UZCoQJwUahKANF7n/bJYPF66FP
         OM8kujLIh26n97jAd6WBLvoA9avtymU+efpP8TuIWGrasWOXZxlr/Cr1jj4zNCpXZ1Dc
         NdiiN1FeUdNwx+UIlBq0Uu10tti5hha91WWs+jT0ofsi+RLz4NR5FUjG/Iz6L1hKltsH
         JSXb9GvNpT7pfT4vbLeCvhtAhV5uCRYbixnt1NrGjFsmqVuD+Fd7IMdUzAh0HtsgBZbB
         Ew2g==
X-Forwarded-Encrypted: i=1; AJvYcCWkB0HYj1FVpRh1BueYfPvCIo30MeJFn4Ku6EzCCoaQOvKqui9z5oUAo7JT8NvWrVehrkvq/E4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh9rhfB59r122RdsWwu/5Kzvjyvda1swTXaxUZN3Sc3cuIJqR9
	1SmztENgd4khdODHByi7bVPMMM//0S8tfq9qlsXLRGBmWNRyWCxuueN3
X-Gm-Gg: ATEYQzw0VNoWBlhhQU5lQn7w5ZEds4bzCVI2bD6aE/yFYigWrvuVBHehuAnsTkWGh0Y
	JFVSoyTxiytzfxlePzqG+YMNX6VN0IwA5StDk/+cvBS9BMRMwZEfOl4bgs4W1sdlmPhzINlgcop
	syl4CMXxnmIFgzUnJJqC9pnnt6vuY5RGs4YyHvfQlNAl6i/8Xey0+DiOFa95ioS8U7du+H5YzXz
	HaZQKiiUAImsslRGBSdQcSkKpUbv7RnYJNPxxdZP50GoWZ8nx1InN35+QzPVXC1UunYnStE+QLX
	HwvQxUqUWNvpS6jVjYg5Vd3eGD0cRCy1mRTBVAjj9lvq1cOlSnDzBzmd4rYLwW2GuapUvi5l+bx
	X/X9EdrmDw+Sut/hN0I3Wmsw2iln4oFlvmAkIvpfdBfBW89ulaMoYr557DJz/br8mV+Og8ItX5+
	40PNYDWHuP1RcLTGB38q5E4xTKOFboCoKCtucU/s8xkswMMjOt/upzgL+qTNJGT6cYUik0Jf3+W
	rVbK0A=
X-Received: by 2002:a05:600c:8106:b0:483:afbb:a064 with SMTP id 5b1f17b1804b1-483c9bb7b7emr126969785e9.1.1772320985811;
        Sat, 28 Feb 2026 15:23:05 -0800 (PST)
Received: from pc-kuba-l13.. (snat-2.cgn.sat-an.net. [176.222.226.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c70ed47sm18515680f8f.11.2026.02.28.15.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 15:23:05 -0800 (PST)
From: =?UTF-8?q?Jakub=20Van=C4=9Bk?= <linuxtardis@gmail.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Frank <Frank.Sae@motor-comm.com>,
	Sai Krishna <saikrishnag@marvell.com>,
	Daniel Golle <daniel@makrotopia.org>,
	=?UTF-8?q?Jakub=20Van=C4=9Bk?= <linuxtardis@gmail.com>
Subject: [PATCH net-next v2 3/5] net: phy: Support PHY fixups on Clause 45 PHYs
Date: Sun,  1 Mar 2026 00:22:39 +0100
Message-ID: <20260228232241.1274236-4-linuxtardis@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260228232241.1274236-1-linuxtardis@gmail.com>
References: <20260228232241.1274236-1-linuxtardis@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262261-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,motor-comm.com,marvell.com,makrotopia.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linuxtardis@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1E7AE1C9AF9
X-Rspamd-Action: no action

For Clause 45 PHYs, phydev->phy_id is zero and therefore cannot be used
to match PHY fixups. Clause 45 PHYs instead have per-MMD identifiers
stored in phydev->c45_ids. Extend phy_needs_fixup() to match against
these IDs by reusing the relevant matching logic from
genphy_match_phy_device().

Signed-off-by: Jakub Vaněk <linuxtardis@gmail.com>
---
 drivers/net/phy/phy_device.c | 56 ++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 19 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 02fc0133428d..db187d370eaa 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -472,13 +472,48 @@ int phy_register_fixup_for_id(const char *bus_id,
 }
 EXPORT_SYMBOL(phy_register_fixup_for_id);
 
+/**
+ * genphy_check_device_id - match a PHY device against a given ID
+ * @phydev: target phy_device struct
+ * @phy_id: expected PHY ID
+ * @phy_id_mask: the PHY ID mask, set bits are significant in matching
+ *
+ * Description: Checks whether the given PHY device matches the specified
+ * ID. For Clause 45 PHYs, iterates over the available device identifiers
+ * and compares them against the expected PHY ID, applying the provided mask.
+ * For Clause 22 PHYs, a direct ID comparison is performed.
+ *
+ * Return: true if the PHY device matches the masked ID, false otherwise.
+ */
+static bool genphy_check_device_id(struct phy_device *phydev,
+				   u32 phy_id, u32 phy_id_mask)
+{
+	if (phydev->is_c45) {
+		const int num_ids = ARRAY_SIZE(phydev->c45_ids.device_ids);
+		int i;
+
+		for (i = 1; i < num_ids; i++) {
+			if (phydev->c45_ids.device_ids[i] == 0xffffffff)
+				continue;
+
+			if (phy_id_compare(phydev->c45_ids.device_ids[i],
+					   phy_id, phy_id_mask))
+				return true;
+		}
+
+		return false;
+	}
+
+	return phy_id_compare(phydev->phy_id, phy_id, phy_id_mask);
+}
+
 static bool phy_needs_fixup(struct phy_device *phydev, struct phy_fixup *fixup)
 {
 	if (!strcmp(fixup->bus_id, phydev_name(phydev)))
 		return true;
 
 	if (fixup->phy_uid_mask &&
-	    phy_id_compare(phydev->phy_id, fixup->phy_uid, fixup->phy_uid_mask))
+	    genphy_check_device_id(phydev, fixup->phy_uid, fixup->phy_uid_mask))
 		return true;
 
 	return false;
@@ -522,24 +557,7 @@ static int phy_scan_fixups(struct phy_device *phydev)
 int genphy_match_phy_device(struct phy_device *phydev,
 			    const struct phy_driver *phydrv)
 {
-	if (phydev->is_c45) {
-		const int num_ids = ARRAY_SIZE(phydev->c45_ids.device_ids);
-		int i;
-
-		for (i = 1; i < num_ids; i++) {
-			if (phydev->c45_ids.device_ids[i] == 0xffffffff)
-				continue;
-
-			if (phy_id_compare(phydev->c45_ids.device_ids[i],
-					   phydrv->phy_id, phydrv->phy_id_mask))
-				return 1;
-		}
-
-		return 0;
-	}
-
-	return phy_id_compare(phydev->phy_id, phydrv->phy_id,
-			      phydrv->phy_id_mask);
+	return genphy_check_device_id(phydev, phydrv->phy_id, phydrv->phy_id_mask);
 }
 EXPORT_SYMBOL_GPL(genphy_match_phy_device);
 
-- 
2.43.0


