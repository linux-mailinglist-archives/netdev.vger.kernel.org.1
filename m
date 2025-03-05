Return-Path: <netdev+bounces-171961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B33CA4FA68
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 10:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35A823A7D8F
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 09:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17CA204873;
	Wed,  5 Mar 2025 09:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dewesoft.com header.i=@dewesoft.com header.b="TZb77446"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6939C2E3373
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 09:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741167680; cv=none; b=TrtRnFT0Oy75NQZ1wlKHSABQt+QMLWKsLNNo+t//KCj8QTtaKIIuXwVBEFNiX6NI0/pbMTAOFZzPw65xHiVc1joP3Cjqc8/rw4ZHzMl0SfMuUy7UdfNfijwWY1MTPhqGoRq0akvsfYLxHV90VHbuApGvjAvd8uOnhCwpcUFrJsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741167680; c=relaxed/simple;
	bh=trNi25fPqVG6Fqrmsk/barvH7EFYSr/sQAYcA056EXY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xt+OFtsN+VpHsUhpUBgzcaj7KAh5JYkDktUGYc0NJjdmibebG02s7BQHNINltsmk5aqwmoZoOgP463mZUwDWRsEeSEG/eBl8yMzdXqjcLBcoQd+H8c7u1WI+yZJP70pSOsuEAuUi9KV29L1z6n+0s+Flbr19zjJxX+dLsKcx1TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dewesoft.com; spf=pass smtp.mailfrom=dewesoft.com; dkim=pass (1024-bit key) header.d=dewesoft.com header.i=@dewesoft.com header.b=TZb77446; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dewesoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dewesoft.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aaec111762bso1212711566b.2
        for <netdev@vger.kernel.org>; Wed, 05 Mar 2025 01:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dewesoft.com; s=google; t=1741167676; x=1741772476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ay3CQX0yBtOqGSgW/CUfOd4T3Z3WHFfRZCKxHtRUCQ0=;
        b=TZb77446e6WChCaqg7Dfoz/KKUkhmXhz0IcnzpBSJCIVCo1y7gooJD+sDsIsS83VeB
         RB+6EnoaKN0+10yhUA8XKP6ImKeokKSU3sOcCt63Mi1uwfVvUE2a4++YFkUandiAjMUm
         KazgDf9iKezxQ4/T9Ix4wQyb1I86hJuhNFOms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741167676; x=1741772476;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ay3CQX0yBtOqGSgW/CUfOd4T3Z3WHFfRZCKxHtRUCQ0=;
        b=NN9l7hVSNYAKd4RNTvb674gxRhxpK9BQy6T5SPpehMbHkHqB09qZcziG9Mq8JSfwc5
         G2wMGpB2MudirdUN9GPUG2QESXBVbIB2esul/ZPN4wjXPxpKeNWbeSPiy2IGb9kdAqvn
         3IyIqqNLIquSNsQzrfwaM99G4eE5D8LHDf2ThZmvtr0PQfe6xKkwfSxJCMUVOhdggtGg
         y7fRCFZ2ysImbkhIv4D3JfTAVzYzUsxkg9YopRtwEn7VtpJpqdk6AEy2d+4jJ0ltMbm5
         eWjhZB5B7BFlvWJ+LjhxjE0gzgvnBFzHzN7YLsb2l9qmqCPVIFRH0EgPxUpfK0BhhECs
         jFeA==
X-Gm-Message-State: AOJu0YzfGiicBwKcTNIP29UgdDkFQNS8XIzQx+Pmt2MA/22EPXN+Lpk7
	ciaSKkKtHq5Q4zyPTBnECapthS5iDIUgMIMTnTHZPHv10y1keXvf7TU9cq+NhpE=
X-Gm-Gg: ASbGncsr4EWg5lcZDDzxx2YL28alkdRduQoUwpCUXFIQbbmcGNgcMXOk69QhMfzg43A
	Zg382UViJwhqBa4f2gX8AvnGecEME26sOH+h7gASZgWyI140teyw9/nK+z+HZQ6CfbPV5NWG5ls
	TVwRcXowVL4yItx1bYzoftKcBW+sQL6VKjLvieZkjsM+/jb7OjK5ceNeIv+FQt3jibjOJLmWqHB
	6/XFNH2pBHRhyK4uKjpx9Ya6snFgVDb70aSANrzeKK17xzgchsvqKpODsOP7e98NvpTLxltSt09
	KwnxwxmLMhB6kQS1rfZBrZH78rWLc6iEQUmXI25fy+28enSbA8Da
X-Google-Smtp-Source: AGHT+IFAeM7FFfz87AHvCPIENeVF3wp8a2ORYfgT6IR1g9/88xPYRz6wHZ+ImIgZm8gZQnixnLXgAA==
X-Received: by 2002:a17:907:9726:b0:ac1:da09:5d32 with SMTP id a640c23a62f3a-ac20d84621cmr267310666b.6.1741167676574;
        Wed, 05 Mar 2025 01:41:16 -0800 (PST)
Received: from gabrsko.. ([213.250.0.74])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac00b19ae66sm451526166b.121.2025.03.05.01.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 01:41:15 -0800 (PST)
From: Viktar Palstsiuk <viktar.palstsiuk@dewesoft.com>
To: andrew@lunn.ch,
	hkallweit1@gmail.com
Cc: netdev@vger.kernel.org,
	Viktar Palstsiuk <viktar.palstsiuk@dewesoft.com>
Subject: [PATCH v2] net: phy: dp83869: fix status reporting for link downshift
Date: Wed,  5 Mar 2025 10:40:53 +0100
Message-Id: <20250305094053.893577-1-viktar.palstsiuk@dewesoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Speed optimization, also known as link downshift, is enabled for the PHY,
but unlike the DP83867, the DP83869 driver does not take
the PHY status register into account.

Update link speed and duplex settings based on the DP83869 PHY status
register, which is necessary when link downshift occurs.

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


