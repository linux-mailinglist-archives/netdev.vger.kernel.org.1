Return-Path: <netdev+bounces-132244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 008CA991173
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 23:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 323091C23C82
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 21:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DF51AE00C;
	Fri,  4 Oct 2024 21:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMZtAETP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD63231C87;
	Fri,  4 Oct 2024 21:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728077243; cv=none; b=f0oCGM9bcFV0ANOADfA5KS8qSCLVGQAS8M/kPTmSDdfT4KyczWlp9PUY5S0/+jC11vzJQPl4AOgsxTFulhf6cP4XwwTzfb3NAtgtc35LMjauU6QuOHeonv+doMsrIi7HN0D1BA/A+HErbXxSalnbcJl06lRaqtI81ZCzojs1yp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728077243; c=relaxed/simple;
	bh=yMaaHd9I/YC0YOJljSP8FedmNmsHkV94ryh5ibDviTs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t5iAWl637HJfF9x3Rgn6EUbMu0ORHJblK+fjSyTT1bxBN1n1vMsqZP84Ede5OtXdVzG/QHYNRf17cx0nLc12N3lenxwM25F+eRqoRHMRpsVr8WM1pypitRqvMJQE2wWVbAGUTSnC/W/lE+R/cgLFyaRCCKdvUSwd67yDa3QCzK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IMZtAETP; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-718e9c8bd83so2445434b3a.1;
        Fri, 04 Oct 2024 14:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728077241; x=1728682041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HuOt8skYPAkoSZcolV2FknQrt+4/TUpuvMcm+pccdMw=;
        b=IMZtAETPKLIs8Psvk3GpyhQLHjTXMohJ+lZZILQF7dmlQWA1H2NGvBf62/25oZx3U5
         VF0TTAy/eoAWY1mGSKOHMPi9uU3Mf49+WQpHICgHnYj2Zyvd5RyR63FGssC/CiosuZEx
         02r3NiRmRhmxQOq90Wqxe38qf5DooSfUyj7uTdLQVmWJz9HL9fD9z9RCxG4vJErScl1c
         uX0dsIuQOkgRQhE0C3fXvzTNB7F17zAo/mHZdCRxiW+fkykK6o2jFvo21isdh+gd5Bn1
         Du8/e4OLJRynxXogVCnI5PTm8hk6aTFjK8/wotVq1xQj9cbnwv5I9hlSBrMRYp7e7Yy7
         mU7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728077241; x=1728682041;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HuOt8skYPAkoSZcolV2FknQrt+4/TUpuvMcm+pccdMw=;
        b=WxyoX/2rhK1uNtAqJXCnImaNiZ7nJE/6BoPSTyJunJ3xp71KuCrkfXn/5Q1o7jS0LN
         NeHEnz97zuCm9oKYWMtvd+uClvpn12FPwUVZmFYqamwxVtOXivOQSQyzcAeCdaP5wlmg
         aY5J/1e2mZ3HfwHkUPQyeVpdlAllDGsNDQJ4hvpfiS+Vo/2TTb+ErczM3K2NTLObDdWI
         EfrT5QzA+C4eKKak7vArSILwN+pPfXkgwR7WlXcrJcKFrHbNiseJ3lTNjseENoFNV7Z6
         WYbB5/TV1Hy5a/1HeoJoFQwdvCUkHO9LmRPqhCDxWD1j1Nrn9UksdZ/9jIfBzCMHjTn8
         yn6g==
X-Forwarded-Encrypted: i=1; AJvYcCUGh4Q+qcqiRB14oNLFT4EjGxLpC5M8Gv7BUD9Hg59JUADqBfPSCD/2d/QUKu9/tbfx+GjofqDw@vger.kernel.org, AJvYcCXL1TmLvCO8FCwObRm+qGJ4971BjftVlwrUiWxq2F2+Br9wgmvUj6/R4j+VDt4lbi4K22LHBSrcVqhuKlA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhcPqrZGozpEAKc3yAqSH1TYkcyJj+R957tqqHnpC6C/XrR4Lk
	3umck/kHgLqOX6uhCaX396JjPuEwTKZ1Xi1y6Ea4z4AttSRjHxIe
X-Google-Smtp-Source: AGHT+IHJf80EA7eVfp7w7T+1wDfr1uAd13UE6o6kpCikw0o3cW93QoXGFXDriJ21AVjJSuCllwkoMw==
X-Received: by 2002:a05:6a00:3c83:b0:70d:2a1b:422c with SMTP id d2e1a72fcca58-71de22e6718mr6091066b3a.7.1728077241176;
        Fri, 04 Oct 2024 14:27:21 -0700 (PDT)
Received: from harry-home.bne.opengear.com (122-151-100-51.dyn.ip.vocus.au. [122.151.100.51])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d7d407sm317561b3a.210.2024.10.04.14.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 14:27:20 -0700 (PDT)
From: Qingtao Cao <qingtao.cao.au@gmail.com>
X-Google-Original-From: Qingtao Cao <qingtao.cao@digi.com>
To: 
Cc: Qingtao Cao <qingtao.cao@digi.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 1/1] net: phy: marvell: make use of fiber autoneg bypass mode
Date: Sat,  5 Oct 2024 07:27:11 +1000
Message-Id: <20241004212711.422811-1-qingtao.cao@digi.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

88E151x supports the SGMII autoneg bypass mode and it defaults to be
enabled. When it is activated, the device assumes a link-up status so
avoid bringing down fibre link in this case

Test case:
1. Two 88E151x are connected with SFP
2. One enables autoneg while the other is 1000BASE-X
3. On the one with autoneg, the link can still be up with this change
   otherwise not

Signed-off-by: Qingtao Cao <qingtao.cao@digi.com>
---
 drivers/net/phy/marvell.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index 9964bf3dea2f..6d48add9dc0a 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -195,6 +195,9 @@
 
 #define MII_88E1510_MSCR_2		0x15
 
+#define MII_88E151X_FSCR2		0x1a
+#define MII_88E151X_FSCR2_BYPASS_STATUS	BIT(5)
+
 #define MII_VCT5_TX_RX_MDI0_COUPLING	0x10
 #define MII_VCT5_TX_RX_MDI1_COUPLING	0x11
 #define MII_VCT5_TX_RX_MDI2_COUPLING	0x12
@@ -1623,12 +1626,24 @@ static void fiber_lpa_mod_linkmode_lpa_t(unsigned long *advertising, u32 lpa)
 static int marvell_read_status_page_an(struct phy_device *phydev,
 				       int fiber, int status)
 {
+	int fscr2;
 	int lpa;
 	int err;
 
 	if (!(status & MII_M1011_PHY_STATUS_RESOLVED)) {
 		phydev->link = 0;
-		return 0;
+		if (!fiber)
+			return 0;
+
+		/* Already on page 1 for fibre */
+		fscr2 = phy_read(phydev, MII_88E151X_FSCR2);
+		if (fscr2 < 0)
+			return fscr2;
+
+		if (!(fscr2 & MII_88E151X_FSCR2_BYPASS_STATUS))
+			return 0;
+
+		phydev->link = 1;
 	}
 
 	if (status & MII_M1011_PHY_STATUS_FULLDUPLEX)
-- 
2.34.1


