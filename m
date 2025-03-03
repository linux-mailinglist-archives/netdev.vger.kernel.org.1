Return-Path: <netdev+bounces-171174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FA0A4BC2B
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 11:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B410616F596
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 10:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEF21F153E;
	Mon,  3 Mar 2025 10:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dewesoft.com header.i=@dewesoft.com header.b="yoHrYcY8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96579A94A
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 10:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740997681; cv=none; b=Y+H0AkDDbGrWPlRha3yOdVP8QKn4ji+fIeQoXg+k+QrzAHU+aU15Z/ljR9AyTUN3McxIB4KcDs2WHmKgOYCX12xNAsipFwwV6q2HUaCbaCuyHpdkgdB0u2c/iuhi1kBmgSk7Z4ZGnO3H1I/kpTNFXryPbXwNG9bYffWVYSZpkg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740997681; c=relaxed/simple;
	bh=4wt6m0NvfbDukJoRfu7PhPG4dz0cll8Nf7VX9i3rQIY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YZqcQeM0i8xSn5UFuZ9LMFMA/C0wtffx1Dk8VLi6Et5Luo6Ne6SsNjotwWDSqwDGhxVMmWtvofrAHO84Kknk2F3vDf6auBTtlUV/pbAJ6xNYl7hVWM8X+LWHbQ3YsFljgOHSICLaOiaTEKWalvGKlQPvGth2y2AUOrcmUUpdJzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dewesoft.com; spf=pass smtp.mailfrom=dewesoft.com; dkim=pass (1024-bit key) header.d=dewesoft.com header.i=@dewesoft.com header.b=yoHrYcY8; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dewesoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dewesoft.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e058ca6806so6840410a12.3
        for <netdev@vger.kernel.org>; Mon, 03 Mar 2025 02:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dewesoft.com; s=google; t=1740997678; x=1741602478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cZzgUSOPusx3oBA+xxosOa4Kzj/VvTGGLduJlowSEfY=;
        b=yoHrYcY8kSE8ebZ217wP+pIgkKf2ZywALMbBFIZ8aZeKE3mNXVDi7WfX/T2tg5A/3J
         orxZpnLhuOFy0JE4fn7Mb2njCEj/g9oj3bLjHJpUre4Bs8nMgMikabvjPimI85Al/fq2
         zuUndRvn3CxWV6QgOZUR15FSkoYrBlQFy+sRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740997678; x=1741602478;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cZzgUSOPusx3oBA+xxosOa4Kzj/VvTGGLduJlowSEfY=;
        b=Z8smG2PReflLVOYCcCJ8rdkKMZGkVtHNDFztFb+O1PFbfhbnyyNzj3mFWmUkKPA9Rl
         LcpSLvPPNekekn0I7E4IFb32BxzIhm3uYj6UOPbJ/IrCyLBjt6cq/llmU2AAIgh+silF
         tQUOEgNBS82CdYVgOg8+kelCIHJ6BzF1HmWv4LSCO0t/E4vNexIHHeHUjCqECnJ6F/fF
         1iQxPLMqxOy5bZ8XSPntZUSX4tcpvijMrMtMISihSIlQjyQSXU5K4YTic6m7V4sKWVMs
         k40LuATzcHKPnjFTZJpLu8SrTLfJBuMUeGU5VUhwoGSVNAJV5AJwe/HUEKNgQP5oxLCA
         +pbA==
X-Gm-Message-State: AOJu0YxHSHJSoTux2bK99G/DTX36jNADpPRPUPRW9CcT58etqZRcxKT2
	YQbEZejpdLpAIVrSTsBxGG3TlfkegGtVNEyjbVHTUTwohCmFhn1o92EL2QzIhRk=
X-Gm-Gg: ASbGncszUr2v0GqhNlXnWV0JA7b9/nkKUUeuqZgUgvHpmKC8oV8pCYvWQPMrIH4xYMs
	lVJ3QJ28tKagevkM6DLtlJ00yv8Xbzvdt59TX92fGc6kIF2hnlQo5iBa29n+EI/MFGkbPqDb/DU
	KLJLNVa98BqabwT5vVCu+egGqGfXw8DT3IYnS4dFynZopZjsdEIktRwe9KffMxgDVRgiLPRfzwK
	bSjbMRmlgErPoPmMzuX9zdMhWo2oU1J9xwCOOfymWDK7RzVBZXAkeodpsrjaKFtNJouSSIrClWL
	EXtUOqhYB0lLOxLwEHsdqXjcbnLHEVkZ+0h+PGROuzDMPzuuX6Ef
X-Google-Smtp-Source: AGHT+IGgE7euTBhWkkSsy3GfdjM0j7aC6RPT5+pACUQR6QcAKHHItQuKahfGTFuJw08nUkIBSXYWqw==
X-Received: by 2002:a05:6402:35c6:b0:5dc:c943:7b6 with SMTP id 4fb4d7f45d1cf-5e4d6ad4a6amr14869794a12.3.1740997677760;
        Mon, 03 Mar 2025 02:27:57 -0800 (PST)
Received: from gabrsko.. ([213.250.0.74])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3bb747csm6773284a12.42.2025.03.03.02.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 02:27:56 -0800 (PST)
From: Viktar Palstsiuk <viktar.palstsiuk@dewesoft.com>
To: andrew@lunn.ch,
	hkallweit1@gmail.com
Cc: netdev@vger.kernel.org,
	Viktar Palstsiuk <viktar.palstsiuk@dewesoft.com>
Subject: [PATCH] net: phy: dp83869: fix status reporting for speed optimization
Date: Mon,  3 Mar 2025 11:27:39 +0100
Message-Id: <20250303102739.137058-1-viktar.palstsiuk@dewesoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Speed optimization is enabled for the PHY, but unlike the DP83867,
the DP83869 driver does not take the PHY status register into account.

Update link speed and duplex settings based on the DP83869 PHY status
register, which is necessary when speed optimization occurs.

Signed-off-by: Viktar Palstsiuk <viktar.palstsiuk@dewesoft.com>
---
 drivers/net/phy/dp83869.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/net/phy/dp83869.c b/drivers/net/phy/dp83869.c
index a62cd838a9ea..fd61d4fbe81d 100644
--- a/drivers/net/phy/dp83869.c
+++ b/drivers/net/phy/dp83869.c
@@ -20,6 +20,7 @@
 #define DP83869_DEVADDR		0x1f
 
 #define MII_DP83869_PHYCTRL	0x10
+#define MII_DP83869_PHYSTS	0x11
 #define MII_DP83869_MICR	0x12
 #define MII_DP83869_ISR		0x13
 #define DP83869_CFG2		0x14
@@ -123,6 +124,12 @@
 #define DP83869_WOL_SEC_EN		BIT(5)
 #define DP83869_WOL_ENH_MAC		BIT(7)
 
+/* PHY STS bits */
+#define DP83869_PHYSTS_1000			BIT(15)
+#define DP83869_PHYSTS_100			BIT(14)
+#define DP83869_PHYSTS_DUPLEX			BIT(13)
+#define DP83869_PHYSTS_LINK			BIT(10)
+
 /* CFG2 bits */
 #define DP83869_DOWNSHIFT_EN		(BIT(8) | BIT(9))
 #define DP83869_DOWNSHIFT_ATTEMPT_MASK	(BIT(10) | BIT(11))
@@ -165,6 +172,7 @@ static int dp83869_config_aneg(struct phy_device *phydev)
 
 static int dp83869_read_status(struct phy_device *phydev)
 {
+	int status = phy_read(phydev, MII_DP83869_PHYSTS);
 	struct dp83869_private *dp83869 = phydev->priv;
 	bool changed;
 	int ret;
@@ -185,6 +193,21 @@ static int dp83869_read_status(struct phy_device *phydev)
 		}
 	}
 
+	if (status < 0)
+		return status;
+
+	if (status & DP83869_PHYSTS_DUPLEX)
+		phydev->duplex = DUPLEX_FULL;
+	else
+		phydev->duplex = DUPLEX_HALF;
+
+	if (status & DP83869_PHYSTS_1000)
+		phydev->speed = SPEED_1000;
+	else if (status & DP83869_PHYSTS_100)
+		phydev->speed = SPEED_100;
+	else
+		phydev->speed = SPEED_10;
+
 	return 0;
 }
 
-- 
2.34.1


