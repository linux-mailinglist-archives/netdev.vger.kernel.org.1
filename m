Return-Path: <netdev+bounces-274675-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oVawKFDIzmmtqAYAu9opvQ
	(envelope-from <netdev+bounces-274675-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 21:49:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F131638DC90
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 21:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 252343008224
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 19:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F1D37B41B;
	Thu,  2 Apr 2026 19:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBA9Em2d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1532C3659F9
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 19:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775159372; cv=none; b=hQxGlSeAlTn1xaESMVWGFRygM+p69d9u4x5lz5sl4HrxjHyJMTZRnNQbE5RTv/qea0bolw1BMla9WV6FPeeqCzSoPdyb5yKhgOj/90Rwvuo+N2ZBbSFgLTj7WjoUqU9acQol54K8GnCgUtlIhKw0k6bPuZ8g6BvN4pqbgdXow8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775159372; c=relaxed/simple;
	bh=bXZVRbhyQyXsHPD+AK7JXDHMmDS9HrnLFBdnlZiPr8c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QZ/+rWAT6Rx0JKJBjolzKlSnSU9YaNcTKQbPKyr85Soq4jGHe12j7wcHCd9jd4+amHuw03Y/oEWQCupujrEbvMa/nVbCFJMh9Fxjj7k6G17Jjmf09omoV/MuHxkM0fKLC2+NeEaukBlGJzmTy3pkWmwnmEcPFIII9CixBy6c9BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mBA9Em2d; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50b268fba9aso10676461cf.3
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 12:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775159370; x=1775764170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wB0nhkRSEuZ4VZIuA2RyZ5ktjm9nKZErCv/yIZXktnY=;
        b=mBA9Em2dbPkkA7I08qzxznFEja+bCNUB7f59inF4r8dHYky7KHRmt19Tvz1S+ZvSsA
         q9komwrBLJyn6bQN3NCye9A5qsb54KE4vlsdY7YAShhleQidkIy5PIcaMCIFffvlRvZX
         ABL/dFJofiHYSnyzbgZbLLcaZMOqOSg22NSbNdUwkPsuX+SJyLkVyw/3d+0X1XGTZS3c
         zeDKWsd1xBzsmt+TeR8hAD25SE0W0PP7RAMzJn4PP1n8IELxfL3YjPSrNWNxH+Cd0Kin
         CU/MG3kp8qy4dM1XAtzz6fTnr6YM9BYyy0fMM3XCBmHdA3HhUC3W4pwPPUqNRgpyD3T6
         VS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775159370; x=1775764170;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wB0nhkRSEuZ4VZIuA2RyZ5ktjm9nKZErCv/yIZXktnY=;
        b=FVr+J2zPDrT5BOraD/Y++ayUfxuKX/AG3YiJmAWwN7MnWHwYgcY2bvs8wUGkxkGqOY
         1Caf0j39KUfucOCqyr6RnlL/XSzRYW79rKUlhdSo849ZELWrlP90uMhQ1TulL7v6gO8I
         aaHB8NwbNLnOHL06KCxf2PdsKybOTHSIjIrr+dm6uzDMG9/goc4bsVPSNL6Z3oBH27Ci
         g52pDWUAqCJ6Z/8FjRaitGGuK1V9TPKTmnQcVF3YFiFOMOwncTWTb18OPyTf3xPJwns3
         1qSFMiCnhUeKm49v7LBGIRic3oBKuC7HXVY3gHrVsbR35k4NlSEZCUCFXDcvwkRLezwJ
         9QyA==
X-Forwarded-Encrypted: i=1; AJvYcCXIPCF7gbTnNVb/4gZQmooKPEv9zeWeNWTqG0mKkrG+pQP1hq/hgwZxO8XNEiF8qV2S9xm9kmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYhJjYXzIsSlpVA4BnC+jHCG4md/ApMUFyjnKqdW9l3ouoq//I
	FI8SL+OCpyBnZIpv6znHmZYkUxPaKW/q9vP84gr8FO+V+rrronzY2lPtkUmegnvq
X-Gm-Gg: ATEYQzz0y2hZcqWZbqf8Rqm1Lt6ZyZHkds1lprLSt0lXiGRvBrhPuGjG4BR/93ixd2d
	N/Nr3jjKyeDhnsukrp8RXOAiP4R77adw10zFd/jjiJh/6XwMW9k0BZtJINbQERPLhDXzh/ZHO2U
	WMfuI5Xlt/CUl2Ek6KtfQ14HJ4Es5nBsOFOM+ayPVN2DCjK1VInTnR8xh+HSO3S8Fv/kLBZHofD
	/zDjSgyOR7oQIFmrpRP5atwEJ1gfKDp6PIHzjd3kcshETBezPB/LukE9hBnmjydaFduRsTBSYXo
	ffA5v6rm2jtF32GsXT6EHhsTU85ap+8CRQGY4ZfLeT6DI9oW7VvV6KqteUEERtaybj9NWu68+QD
	7yLvrZkCNWmGcf8n034usah4xx8tNK9wiPlN2GJ3aRlibnODqVT03DY8xa4SSgj5ALMOACThKoW
	MpqxxVhps9lTbOQMIPjS2TF08OEeBfh1zY9yerrsoEjwggxYTuUvhmoKD4UwHrbA==
X-Received: by 2002:a17:903:238b:b0:2ad:d0ff:2ed4 with SMTP id d9443c01a7336-2b28164c3d7mr6124885ad.6.1775158959241;
        Thu, 02 Apr 2026 12:42:39 -0700 (PDT)
Received: from ubunut-vm.. (c-73-240-82-137.hsd1.or.comcast.net. [73.240.82.137])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27472d5e5sm48432755ad.15.2026.04.02.12.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 12:42:38 -0700 (PDT)
From: Joel <joelcrouch@gmail.com>
To: andrew+netdev@lunn.ch
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Joel <joelcrouch@gmail.com>
Subject: [PATCH] sungem: fix PHY initialization hardware failure check and pointe style
Date: Thu,  2 Apr 2026 19:42:35 +0000
Message-ID: <20260402194235.11986-1-joelcrouch@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274675-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joelcrouch@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F131638DC90
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently, bcm5411_init does not validate the result of the PHY register
reads.  This can lead to silent failures if the hardware is unresponsive
or the MDIO bus times out, as 0xffff would be treated as valid data.

This patch:
	1: Adds a check for -EIO and 0xffff during BCM5411 initialization.
	2: Updates gem_init_phy to log an error message fi the PHY-
	   specific init fails.
	3: Cleans up pointer formatting(eg,. foo* bar to foo *bar) to
	   align with Linux Kernel Coding Style in the modified files.

Signed-off-by: Joel <joelcrouch@gmail.com>
---
 drivers/net/ethernet/sun/sungem.c |  8 +++--
 drivers/net/sungem_phy.c          | 60 +++++++++++++++++--------------
 2 files changed, 39 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/sun/sungem.c b/drivers/net/ethernet/sun/sungem.c
index 8e69d917d..525aba527 100644
--- a/drivers/net/ethernet/sun/sungem.c
+++ b/drivers/net/ethernet/sun/sungem.c
@@ -1707,8 +1707,12 @@ static void gem_init_phy(struct gem *gp)
 		sungem_phy_probe(&gp->phy_mii, gp->mii_phy_addr);
 
 		/* Init PHY */
-		if (gp->phy_mii.def && gp->phy_mii.def->ops->init)
-			gp->phy_mii.def->ops->init(&gp->phy_mii);
+		if (gp->phy_mii.def && gp->phy_mii.def->ops->init) {
+			int err = gp->phy_mii.def->ops->init(&gp->phy_mii);
+
+			if (err)
+				netdev_err(gp->dev, "PHY init failed: %d\n", err);
+		}
 	} else {
 		gem_pcs_reset(gp);
 		gem_pcs_reinit_adv(gp);
diff --git a/drivers/net/sungem_phy.c b/drivers/net/sungem_phy.c
index c10198d44..ec8800c93 100644
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
@@ -295,7 +296,12 @@ static int bcm5411_init(struct mii_phy* phy)
 	sungem_phy_write(phy, MII_BMCR, BMCR_RESET);
 	sungem_phy_write(phy, MII_BMCR, 0x1340);
 
-	data = sungem_phy_read(phy, MII_BCM5400_GB_CONTROL);
+	val = sungem_phy_read(phy, MII_BCM5400_GB_CONTROL);
+
+	if (val < 0 || val == 0xffff)
+		return -EIO;
+
+	data = (u16)val;
 	data |= MII_BCM5400_GB_CONTROL_FULLDUPLEXCAP;
 	sungem_phy_write(phy, MII_BCM5400_GB_CONTROL, data);
 
@@ -408,14 +414,14 @@ static int genmii_read_link(struct mii_phy *phy)
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
@@ -548,7 +554,7 @@ static int bcm54xx_read_link(struct mii_phy *phy)
 	u16 val;
 
 	if (phy->autoneg) {
-	    	val = sungem_phy_read(phy, MII_BCM5400_AUXSTATUS);
+		val = sungem_phy_read(phy, MII_BCM5400_AUXSTATUS);
 		link_mode = ((val & MII_BCM5400_AUXSTATUS_LINKMODE_MASK) >>
 			     MII_BCM5400_AUXSTATUS_LINKMODE_SHIFT);
 		phy->duplex = phy_BCM5400_link_table[link_mode][0] ?
@@ -568,7 +574,7 @@ static int bcm54xx_read_link(struct mii_phy *phy)
 	return 0;
 }
 
-static int marvell88e1111_init(struct mii_phy* phy)
+static int marvell88e1111_init(struct mii_phy *phy)
 {
 	u16 rev;
 
@@ -592,7 +598,7 @@ static int marvell88e1111_init(struct mii_phy* phy)
 
 #define BCM5421_MODE_MASK	(1 << 5)
 
-static int bcm5421_poll_link(struct mii_phy* phy)
+static int bcm5421_poll_link(struct mii_phy *phy)
 {
 	u32 phy_reg;
 	int mode;
@@ -616,7 +622,7 @@ static int bcm5421_poll_link(struct mii_phy* phy)
 		return 1;
 }
 
-static int bcm5421_read_link(struct mii_phy* phy)
+static int bcm5421_read_link(struct mii_phy *phy)
 {
 	u32 phy_reg;
 	int mode;
@@ -644,7 +650,7 @@ static int bcm5421_read_link(struct mii_phy* phy)
 	return 0;
 }
 
-static int bcm5421_enable_fiber(struct mii_phy* phy, int autoneg)
+static int bcm5421_enable_fiber(struct mii_phy *phy, int autoneg)
 {
 	/* enable fiber mode */
 	sungem_phy_write(phy, MII_NCONFIG, 0x9020);
@@ -665,7 +671,7 @@ static int bcm5421_enable_fiber(struct mii_phy* phy, int autoneg)
 #define BCM5461_FIBER_LINK	(1 << 2)
 #define BCM5461_MODE_MASK	(3 << 1)
 
-static int bcm5461_poll_link(struct mii_phy* phy)
+static int bcm5461_poll_link(struct mii_phy *phy)
 {
 	u32 phy_reg;
 	int mode;
@@ -691,7 +697,7 @@ static int bcm5461_poll_link(struct mii_phy* phy)
 
 #define BCM5461_FIBER_DUPLEX	(1 << 3)
 
-static int bcm5461_read_link(struct mii_phy* phy)
+static int bcm5461_read_link(struct mii_phy *phy)
 {
 	u32 phy_reg;
 	int mode;
@@ -720,7 +726,7 @@ static int bcm5461_read_link(struct mii_phy* phy)
 	return 0;
 }
 
-static int bcm5461_enable_fiber(struct mii_phy* phy, int autoneg)
+static int bcm5461_enable_fiber(struct mii_phy *phy, int autoneg)
 {
 	/* select fiber mode, enable 1000 base-X registers */
 	sungem_phy_write(phy, MII_NCONFIG, 0xfc0b);
-- 
2.43.0


