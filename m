Return-Path: <netdev+bounces-131474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF9598E932
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 06:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD051281DBA
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 04:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EE83D96A;
	Thu,  3 Oct 2024 04:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9eKgdCX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0420C22334;
	Thu,  3 Oct 2024 04:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727930728; cv=none; b=i7lU4R5A4ySREDRR84v1Sv/RO/UlxsCjzl49pgEt0N0WxcSmWVC9+DrX/8YjO06OblZyCVhoWZrG6psPgnBxqp5JVEjqwY6uBfYnRII9si9zc7EElsXMutM0pkVWXWm2H9tTdE64i6Jbm0qiNg096N6JeIYMWTtB8baibcJrmLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727930728; c=relaxed/simple;
	bh=a6NzEMqVVqoKX0z4vhqj1x2f9vRA3/HFwFm0dALmV7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DJBXpgeGlK3082Nsi+bwBfdvhhBF/Xcx0AO7LLzt2jDgeRP4DHmY5lr3OlfUKSTYHEEGrBWZDTickQFgjl/DHUrZ02h4lkaAo++16rtZaIEg0x4L/mmXNytZ/Sj2Xv8z33DbVqdf8mNVXTG03p86VNtn6Slco1bHjAoG2mdH/Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C9eKgdCX; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20bb610be6aso5263645ad.1;
        Wed, 02 Oct 2024 21:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727930726; x=1728535526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BePVZtgcofTJXKwnXZOI4NzWEkRIj4jDMasf+9fpgvk=;
        b=C9eKgdCXbPI9Y7u1HiWazjza1Z+dWfOH1CA1YOe/gf6GTqCyqsB07BVEvsTqWVJov7
         bv4gPASml+ZHsvAwh3nRBgTyDUYegE88BCNA0uFQohsJU+/ANkxyqjduzO97OMxjW8pe
         fCX3Zv1hHbWmLzNjckyGFAsE02ITWiLwdDF7z/a+wZygOnxklKldk+PxMUElJQBaL7QE
         BjJiSFdDg5/2JIs+aQnw4v9NauqmhEXPJaO0sD6t0Mnq8G8HJqj0cvVMxmKwWsPX1BOl
         DTGC+UjEGljWEitvMwz1yhQ+KeiLSWGq/8ZrDrTl3HgCw4tTAbpr/SSxcBjDEbv4UoxK
         Eyyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727930726; x=1728535526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BePVZtgcofTJXKwnXZOI4NzWEkRIj4jDMasf+9fpgvk=;
        b=GJw9nggX3OC2qyeXQZyD4z0joWtSUPd3Kxq1jrje5uzGnKTm8Q3kz9PYZxxd41RwM/
         85F37iHVVt5iTQk0UYjilqQmsUL/MyDlpqpdkGJ1og7f4FKpKBhQq1sbCIR172g1Pmen
         +ckfDVTXhXUbrepmqHp1sdP9kTXVwjopO6SkoRUMJRqeBFmPthC8NSWj7L9LLeFEzBC4
         /UfbsNeGms9ItBO+WHqlE5uzLAXboVTMMN08rG1XCzi9r2MbP4RbxAC211W0jJHFXXnJ
         ErZy7SVDdXH84l9t+zN9T/wAJFmy8QNDeNGIhdoPRFQ/3c96GTeAsi4Ex2RDDE8jTRN9
         SDJg==
X-Forwarded-Encrypted: i=1; AJvYcCXsu9R/RYFEDS6MAp5XKxNFNiSBKRrNDirFxRjRZpD54Sh0D9++mSxuwAk4z803RPZIiVRP0tzs@vger.kernel.org, AJvYcCXt73TM42Zxxh+byWVxsdskN9uB3suNUqeJGyP3wzvtH6QrrSrmD6rqdNvUxrRqCfv9N07Is3VSzR79T6s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4pE7h4ELhxx7g9Ngga5nknCXBLkqMSOKKl3mL1/c5SgS6LxyS
	hyfWH76E7xJIZHytxLMBkxkRBpsYOK5P8qB4IwE+G2YB1zg/PUP6
X-Google-Smtp-Source: AGHT+IGycI8lj9fwecsPAv/CbtxuyVh8iGB6ritXNlLsnW5+ne1WgWtbZeiBuIE0bMw3i7GIScf27g==
X-Received: by 2002:a17:903:22d1:b0:20b:8aa1:d53e with SMTP id d9443c01a7336-20bc5aaa68amr90113495ad.44.1727930726280;
        Wed, 02 Oct 2024 21:45:26 -0700 (PDT)
Received: from harry-home.bne.opengear.com (122-151-100-51.dyn.ip.vocus.au. [122.151.100.51])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beefafeefsm1257415ad.227.2024.10.02.21.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 21:45:25 -0700 (PDT)
From: Qingtao Cao <qingtao.cao.au@gmail.com>
X-Google-Original-From: Qingtao Cao <qingtao.cao@digi.com>
To: 
Cc: qingtao.cao.au@gmail.com,
	Qingtao Cao <qingtao.cao@digi.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: v2 [PATCH 1/1] net: phy: marvell: avoid bringing down fibre link when autoneg is bypassed
Date: Thu,  3 Oct 2024 14:45:16 +1000
Message-Id: <20241003044516.373102-1-qingtao.cao@digi.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 88E151x the SGMII autoneg bypass mode defaults to be enabled. When it is
activated, the device assumes a link-up status with existing configuration
in BMCR, avoid bringing down the fibre link in this case

Test case:
1. Two 88E151x connected with SFP, both enable autoneg, link is up with speed
   1000M
2. Disable autoneg on one device and explicitly set its speed to 1000M
3. The fibre link can still up with this change, otherwise not.

Signed-off-by: Qingtao Cao <qingtao.cao@digi.com>
---
 drivers/net/phy/marvell.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index 9964bf3dea2f..e3a8ad8b08dd 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -195,6 +195,10 @@
 
 #define MII_88E1510_MSCR_2		0x15
 
+#define MII_88E1510_FSCR2		0x1a
+#define MII_88E1510_FSCR2_BYPASS_ENABLE	BIT(6)
+#define MII_88E1510_FSCR2_BYPASS_STATUS	BIT(5)
+
 #define MII_VCT5_TX_RX_MDI0_COUPLING	0x10
 #define MII_VCT5_TX_RX_MDI1_COUPLING	0x11
 #define MII_VCT5_TX_RX_MDI2_COUPLING	0x12
@@ -1623,11 +1627,28 @@ static void fiber_lpa_mod_linkmode_lpa_t(unsigned long *advertising, u32 lpa)
 static int marvell_read_status_page_an(struct phy_device *phydev,
 				       int fiber, int status)
 {
+	int fscr2;
 	int lpa;
 	int err;
 
 	if (!(status & MII_M1011_PHY_STATUS_RESOLVED)) {
-		phydev->link = 0;
+		if (!fiber) {
+			phydev->link = 0;
+		} else {
+			fscr2 = phy_read(phydev, MII_88E1510_FSCR2);
+			if (fscr2 > 0) {
+				if ((fscr2 & MII_88E1510_FSCR2_BYPASS_ENABLE) &&
+				    (fscr2 & MII_88E1510_FSCR2_BYPASS_STATUS)) {
+					if (genphy_read_status_fixed(phydev) < 0)
+						phydev->link = 0;
+				} else {
+					phydev->link = 0;
+				}
+			} else {
+				phydev->link = 0;
+			}
+		}
+
 		return 0;
 	}
 
-- 
2.34.1


