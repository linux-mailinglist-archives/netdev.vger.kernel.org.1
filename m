Return-Path: <netdev+bounces-280928-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Ei+HtXk6mleFQAAu9opvQ
	(envelope-from <netdev+bounces-280928-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 05:34:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E5E459792
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 05:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34976301A1C0
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 03:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AAC1B4F1F;
	Fri, 24 Apr 2026 03:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipGVJrgs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F274232395
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 03:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777001640; cv=none; b=L9Hgpd1KZwsUPrrBadH20BKn3xMVqFJQ8rCYxO7UaZsBA5ep8LP7Fn/3nN/Wg2XS1rrrWeoMIoFycwRg1Xp877sjeaCEnXlhhNwPaOfAyVnqDKF94cVkLd6ZACRuzvq1WEAaHGae76jLvqYoJtXK2wDed5WIaX9l3ChtlAjfmNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777001640; c=relaxed/simple;
	bh=3g6vPL5+/PxV4UaI5AcFZF+A9nSA/8Iqy3bMWU0IT9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h5ly6SrRbHwk2X/Aklm18UcLZ3CGhUO/4IWZFlPHSX7MvJ+F8ytL3PONFKcYJruiyCGOgd4c0OFLN94FNR0X0DUJAV4K31x8pWgAfCEdsKLHAJeEdU4gleeRVoIMKUsNzhiT80R/rBtS6vmtO4FHLjDjg8VthhzWBIdnQMe2d6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ipGVJrgs; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c76b994f7a8so2893193a12.3
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 20:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777001638; x=1777606438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HjcmI+vdIFbJbnXF21GNXemf/C/ERw0Tr8dDCWxWsys=;
        b=ipGVJrgs6/ZJZaaFA8ghhLEcqSDnfMJOEi2e6Y6jGCjvy74rj8ccCzMEQrSauIlR2R
         pNPigBXr7s6kPasx9KntXU7v7BDpFrV/KEB815gacpT3tYUs1zd1ZEtUmQFsL2n28CBM
         yB86gf/wxO/9EwYgCxad3QeLF2X8GI7s340O1Qak6mVJwtAaeCj0y7JcKDuCn7JlpDM5
         EGhKCJgpppvUtp2kAaOIzvzwePySugRfiyxlg5s1OCRDljP4TGoQJUoQOTW4cxXqzdwY
         si31WZOet0KO+R7nS0PhD5M+w2G/jdyKIu9OnzXepS9916awvViAM/SEMxV18fU24IgU
         YJqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777001638; x=1777606438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HjcmI+vdIFbJbnXF21GNXemf/C/ERw0Tr8dDCWxWsys=;
        b=tBAF3F8CzIK/7C3Lwry3S32pipJ3ariolTL//vdPF6UradJ/ubseAtOvX0TE9W8yVx
         eXC0hK5VFi1WsE+eBYBt61infWrlkOTbmLgiobKBad0FlcnfqYPo1HxX4tpHR05QhsPC
         CO/w4LPhih+gp68YFHyCvH+sxxN7EkVjrtPB5Vtbu/9T5bBLC10eyTlLKxM0HqBkVgJJ
         Ppj3zOXOxsAdyif/0Yd79k0K4AktPsG6pgpiusXbeHPGoDCaCi50sGQvevSRa3uYEkBz
         VJ4tuVHChCgBcbVE0kMP5bFBowesyCuxv9FLPWoobE+/bQcqMraYVnoSd+VIUGAOsdrg
         9t4w==
X-Gm-Message-State: AOJu0Yw4Ytkfn43IvlspS/hUMsGJQLTWTpO/xB8zcVDAnXO5vDvMwWBV
	W5UfSL2jog8tR5EhrsBcngaN9r4Hh4hpALepCh4yGcaCoSvkiT6ZlrjeLfCdl/qs
X-Gm-Gg: AeBDiev7C4hyycoNlSwzzJ3D2YwPcabcAJvlHn0EIOVFXcABT4pLLHVJpqefSbiV0fa
	IsQAKL52zs4VfJJnHcXSWZs5mRagOLC/7td3wkqwfUBYtO54YwK07/AhUnx8AZbKGTrIPV1BvbV
	3miL3QGDSrvL7kyBD7JNVEpd2wHytv2sBSw8BWwy0ELfL+zO/2NJzT5SKcod/m73sAqmE1jfG6H
	DAdS1p9Lme6zmKv9qY+DVHCNYXvyVDIs9Vfqx5FxkETniEvyuQcYoSNgJRXp7jCWYqDLlJ8D+hn
	aegbhHFKHlxrkBdnmizvZ7ArUSv1noyr+kMlYRFpDKh5JpaOrHO0iIGCdN1mUwwUr4XIjSU0Cgp
	J9Uv4O0B+/H/iccM109QgLIdBfELlMA4N5nOEh/3fOR1NIWh3I8wUcDcnOwvQzOb3LMX6qlwZQ/
	9o2eiPApuI7eMFfQVdqU0dZWMYhAl0qf4MwNk5o/u/JLGpYzfDp5CHjqgHQiXGYoICL2tUAZZA
X-Received: by 2002:a05:6a00:2993:b0:7e8:4471:ae55 with SMTP id d2e1a72fcca58-82f8c92a621mr30886720b3a.33.1777001637956;
        Thu, 23 Apr 2026 20:33:57 -0700 (PDT)
Received: from ubunut-vm.. (c-73-240-82-137.hsd1.or.comcast.net. [73.240.82.137])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9cbb1dsm23797624b3a.14.2026.04.23.20.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 20:33:57 -0700 (PDT)
From: Joel <joelcrouch@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Joel <joelcrouch@gmail.com>
Subject: [PATCH v2 1/2] sungem: fix pointer formatting and indentation
Date: Fri, 24 Apr 2026 03:33:47 +0000
Message-ID: <20260424033348.1917-2-joelcrouch@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424033348.1917-1-joelcrouch@gmail.com>
References: <20260424033348.1917-1-joelcrouch@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D4E5E459792
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280928-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joelcrouch@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Align with Linux Kernel Coding Style by placing the asterisk with the variable name and correcting indentation in bcm54xx_read_link.
---
 drivers/net/sungem_phy.c | 53 ++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 26 deletions(-)

diff --git a/drivers/net/sungem_phy.c b/drivers/net/sungem_phy.c
index c10198d44..44cbe1938 100644
--- a/drivers/net/sungem_phy.c
+++ b/drivers/net/sungem_phy.c
@@ -44,27 +44,27 @@ static const int phy_BCM5400_link_table[8][3] = {
 	{ 1, 0, 1 },	/* 1000BT */
 };
 
-static inline int __sungem_phy_read(struct mii_phy* phy, int id, int reg)
+static inline int __sungem_phy_read(struct mii_phy *phy, int id, int reg)
 {
 	return phy->mdio_read(phy->dev, id, reg);
 }
 
-static inline void __sungem_phy_write(struct mii_phy* phy, int id, int reg, int val)
+static inline void __sungem_phy_write(struct mii_phy *phy, int id, int reg, int val)
 {
 	phy->mdio_write(phy->dev, id, reg, val);
 }
 
-static inline int sungem_phy_read(struct mii_phy* phy, int reg)
+static inline int sungem_phy_read(struct mii_phy *phy, int reg)
 {
 	return phy->mdio_read(phy->dev, phy->mii_id, reg);
 }
 
-static inline void sungem_phy_write(struct mii_phy* phy, int reg, int val)
+static inline void sungem_phy_write(struct mii_phy *phy, int reg, int val)
 {
 	phy->mdio_write(phy->dev, phy->mii_id, reg, val);
 }
 
-static int reset_one_mii_phy(struct mii_phy* phy, int phy_id)
+static int reset_one_mii_phy(struct mii_phy *phy, int phy_id)
 {
 	u16 val;
 	int limit = 10000;
@@ -88,7 +88,7 @@ static int reset_one_mii_phy(struct mii_phy* phy, int phy_id)
 	return limit <= 0;
 }
 
-static int bcm5201_init(struct mii_phy* phy)
+static int bcm5201_init(struct mii_phy *phy)
 {
 	u16 data;
 
@@ -101,7 +101,7 @@ static int bcm5201_init(struct mii_phy* phy)
 	return 0;
 }
 
-static int bcm5201_suspend(struct mii_phy* phy)
+static int bcm5201_suspend(struct mii_phy *phy)
 {
 	sungem_phy_write(phy, MII_BCM5201_INTERRUPT, 0);
 	sungem_phy_write(phy, MII_BCM5201_MULTIPHY, MII_BCM5201_MULTIPHY_SUPERISOLATE);
@@ -109,7 +109,7 @@ static int bcm5201_suspend(struct mii_phy* phy)
 	return 0;
 }
 
-static int bcm5221_init(struct mii_phy* phy)
+static int bcm5221_init(struct mii_phy *phy)
 {
 	u16 data;
 
@@ -132,7 +132,7 @@ static int bcm5221_init(struct mii_phy* phy)
 	return 0;
 }
 
-static int bcm5221_suspend(struct mii_phy* phy)
+static int bcm5221_suspend(struct mii_phy *phy)
 {
 	u16 data;
 
@@ -147,7 +147,7 @@ static int bcm5221_suspend(struct mii_phy* phy)
 	return 0;
 }
 
-static int bcm5241_init(struct mii_phy* phy)
+static int bcm5241_init(struct mii_phy *phy)
 {
 	u16 data;
 
@@ -170,7 +170,7 @@ static int bcm5241_init(struct mii_phy* phy)
 	return 0;
 }
 
-static int bcm5241_suspend(struct mii_phy* phy)
+static int bcm5241_suspend(struct mii_phy *phy)
 {
 	u16 data;
 
@@ -185,7 +185,7 @@ static int bcm5241_suspend(struct mii_phy* phy)
 	return 0;
 }
 
-static int bcm5400_init(struct mii_phy* phy)
+static int bcm5400_init(struct mii_phy *phy)
 {
 	u16 data;
 
@@ -214,7 +214,7 @@ static int bcm5400_init(struct mii_phy* phy)
 	return 0;
 }
 
-static int bcm5400_suspend(struct mii_phy* phy)
+static int bcm5400_suspend(struct mii_phy *phy)
 {
 #if 0 /* Commented out in Darwin... someone has those dawn docs ? */
 	sungem_phy_write(phy, MII_BMCR, BMCR_PDOWN);
@@ -222,7 +222,7 @@ static int bcm5400_suspend(struct mii_phy* phy)
 	return 0;
 }
 
-static int bcm5401_init(struct mii_phy* phy)
+static int bcm5401_init(struct mii_phy *phy)
 {
 	u16 data;
 	int rev;
@@ -270,7 +270,7 @@ static int bcm5401_init(struct mii_phy* phy)
 	return 0;
 }
 
-static int bcm5401_suspend(struct mii_phy* phy)
+static int bcm5401_suspend(struct mii_phy *phy)
 {
 #if 0 /* Commented out in Darwin... someone has those dawn docs ? */
 	sungem_phy_write(phy, MII_BMCR, BMCR_PDOWN);
@@ -278,8 +278,9 @@ static int bcm5401_suspend(struct mii_phy* phy)
 	return 0;
 }
 
-static int bcm5411_init(struct mii_phy* phy)
+static int bcm5411_init(struct mii_phy *phy)
 {
+	int val;
 	u16 data;
 
 	/* Here's some more Apple black magic to setup
@@ -408,14 +409,14 @@ static int genmii_read_link(struct mii_phy *phy)
 	return 0;
 }
 
-static int generic_suspend(struct mii_phy* phy)
+static int generic_suspend(struct mii_phy *phy)
 {
 	sungem_phy_write(phy, MII_BMCR, BMCR_PDOWN);
 
 	return 0;
 }
 
-static int bcm5421_init(struct mii_phy* phy)
+static int bcm5421_init(struct mii_phy *phy)
 {
 	u16 data;
 	unsigned int id;
@@ -548,7 +549,7 @@ static int bcm54xx_read_link(struct mii_phy *phy)
 	u16 val;
 
 	if (phy->autoneg) {
-	    	val = sungem_phy_read(phy, MII_BCM5400_AUXSTATUS);
+		val = sungem_phy_read(phy, MII_BCM5400_AUXSTATUS);
 		link_mode = ((val & MII_BCM5400_AUXSTATUS_LINKMODE_MASK) >>
 			     MII_BCM5400_AUXSTATUS_LINKMODE_SHIFT);
 		phy->duplex = phy_BCM5400_link_table[link_mode][0] ?
@@ -568,7 +569,7 @@ static int bcm54xx_read_link(struct mii_phy *phy)
 	return 0;
 }
 
-static int marvell88e1111_init(struct mii_phy* phy)
+static int marvell88e1111_init(struct mii_phy *phy)
 {
 	u16 rev;
 
@@ -592,7 +593,7 @@ static int marvell88e1111_init(struct mii_phy* phy)
 
 #define BCM5421_MODE_MASK	(1 << 5)
 
-static int bcm5421_poll_link(struct mii_phy* phy)
+static int bcm5421_poll_link(struct mii_phy *phy)
 {
 	u32 phy_reg;
 	int mode;
@@ -616,7 +617,7 @@ static int bcm5421_poll_link(struct mii_phy* phy)
 		return 1;
 }
 
-static int bcm5421_read_link(struct mii_phy* phy)
+static int bcm5421_read_link(struct mii_phy *phy)
 {
 	u32 phy_reg;
 	int mode;
@@ -644,7 +645,7 @@ static int bcm5421_read_link(struct mii_phy* phy)
 	return 0;
 }
 
-static int bcm5421_enable_fiber(struct mii_phy* phy, int autoneg)
+static int bcm5421_enable_fiber(struct mii_phy *phy, int autoneg)
 {
 	/* enable fiber mode */
 	sungem_phy_write(phy, MII_NCONFIG, 0x9020);
@@ -665,7 +666,7 @@ static int bcm5421_enable_fiber(struct mii_phy* phy, int autoneg)
 #define BCM5461_FIBER_LINK	(1 << 2)
 #define BCM5461_MODE_MASK	(3 << 1)
 
-static int bcm5461_poll_link(struct mii_phy* phy)
+static int bcm5461_poll_link(struct mii_phy *phy)
 {
 	u32 phy_reg;
 	int mode;
@@ -691,7 +692,7 @@ static int bcm5461_poll_link(struct mii_phy* phy)
 
 #define BCM5461_FIBER_DUPLEX	(1 << 3)
 
-static int bcm5461_read_link(struct mii_phy* phy)
+static int bcm5461_read_link(struct mii_phy *phy)
 {
 	u32 phy_reg;
 	int mode;
@@ -720,7 +721,7 @@ static int bcm5461_read_link(struct mii_phy* phy)
 	return 0;
 }
 
-static int bcm5461_enable_fiber(struct mii_phy* phy, int autoneg)
+static int bcm5461_enable_fiber(struct mii_phy *phy, int autoneg)
 {
 	/* select fiber mode, enable 1000 base-X registers */
 	sungem_phy_write(phy, MII_NCONFIG, 0xfc0b);
-- 
2.43.0


