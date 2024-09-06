Return-Path: <netdev+bounces-125965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D1496F6CE
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 16:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD0601C21264
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 14:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895E21D3621;
	Fri,  6 Sep 2024 14:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDcEQm3t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186821D31BC;
	Fri,  6 Sep 2024 14:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725633085; cv=none; b=l4D3er07mBa6EqWxAtRi/hb/O1H1QPkGq9kwVo2kiOVvYj9g91EF5Vs2Lkfu76EFtRkiASUqxdGOXpFqrHunDYnXaJGa8hbGrGvE2aRD1Rmo+WQf5P3P7rAf0vw+B/DsZXrtbl7sVQ7KiTjfHsRdbWj93UaB8UrO4b9rCNdUhgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725633085; c=relaxed/simple;
	bh=WW54gdwLUbR2vRtO4ItV9tgMkKvU53P2EOjp+KhAuI8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BSlt6jQso/ez2Jzn9JC8xLF2YQbUrd3h1JS2F6THVZxs2ZGTXqDn2w3N0jBxYtxXD+iTYqt1BakpJnhw77vqO52ktVvtosAoWmAkXNH51t+evZyv1TNcMG1CMre6+CTss/wBfxBttP9JWpIL6858vKUuyNGQj4ZfqZG9jc7Wv0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hDcEQm3t; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-204d391f53bso20122565ad.2;
        Fri, 06 Sep 2024 07:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725633083; x=1726237883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nRhWJrEYy3VMtGEOiJyga7bTazzfIqhRdV1t7XTzZag=;
        b=hDcEQm3twmMYaReTr6sShNV6XmkAIeFeqT4d5YwPmXaTl3NPfgZLFki9oadDrjVyJo
         EBpXcT/vBgT6VJlCkUg7ADuXA7EWKj+FA8rHMrKNG2WZfM75M7BZyUmYvEudrzUhxGx6
         rhoOFyhU2tM0f183tzFgDUYj1OeS/K9lMg0LQXuUjReCdjn/dqf8/CgO+nsRA6/qHNTX
         yEL/FG7lheqoiQLsZUS2+0ExDkzRJfu1tx7ZsIXzDtjbY+Zr5AbXkp/j2kJkMUsHyF1c
         7186535xxoEDm/7U7o5NdMuGaGvJjgN6ppY1BBHu9GUI0BZwvAMR/GUMuzhRwLp0Hhhe
         zomA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725633083; x=1726237883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nRhWJrEYy3VMtGEOiJyga7bTazzfIqhRdV1t7XTzZag=;
        b=f8yDABtp5aFkBf/UsUhCXRV3YK7u4K5e7XiPh8vYLztWAZWwflBVbBTWYD48YQ7z4h
         5GG/DBAHpK1W5mLhb2L4UPWywzWjrJYk5vUUxNuphpORHKXcHkYaKTtwoen77Qun+fIO
         R98uzwhS1RtyujOeaB/XWQN1GS/esmRqCI4bcgMvUxTXBeX6wE8oNejs6RmiTRRLUvfR
         HRcJjd+neReXRC7DvAZ4b/D7OQEPZlOHklG9qKy6ghvlGv5pFpsZjILIRfuCsKEiOAN6
         pN8B+A3+yr8owIafgAdf1jKYMO0rfBId9oobcIbejZDFJGhI3YXK2jiHym1MGPqL/7N3
         1BIA==
X-Forwarded-Encrypted: i=1; AJvYcCUMluRHwXsmw14pg8jVcGOvQLPFRSNY/BR30sGMX2vBSTt+r1WCKWuWOhaFZQgDCYZKfrFXXyrKE3+cIqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgrLYR0PO62vOLjfEEefk8D5H+pUQ/qlOrdu4iKg8RtnU7JbfH
	mULgIsPyd8o0zYOSPlZT6p8N46Tbilp/Fk7fWpCYsRWUmv0OBuVA
X-Google-Smtp-Source: AGHT+IHD12G59ybspMl52ExP69orF2krTF1ik13xLU72/3C/hDwxeZAUZl2YwzBjT9cjXIzWG8GICw==
X-Received: by 2002:a17:902:cf0b:b0:202:3e32:5d3e with SMTP id d9443c01a7336-206f055d122mr30488055ad.36.1725633083271;
        Fri, 06 Sep 2024 07:31:23 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-206ae94dcf3sm43951975ad.80.2024.09.06.07.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 07:31:22 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: Vladimir Oltean <olteanv@gmail.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	rmk+kernel@armlinux.org.uk,
	linux@armlinux.org.uk,
	xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v10 7/7] net: stmmac: silence FPE kernel logs
Date: Fri,  6 Sep 2024 22:30:12 +0800
Message-Id: <39943d7967f291674a97ef0572878aca273087e9.1725631883.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1725631883.git.0x1207@gmail.com>
References: <cover.1725631883.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ethtool --show-mm can get real-time state of FPE.
fpe_irq_status logs should keep quiet.

tc-taprio can always query driver state, delete unbalanced logs.

Signed-off-by: Furong Xu <0x1207@gmail.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac5.c    | 8 ++++----
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c | 4 ----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
index ab96fc055f48..08add508db84 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
@@ -620,22 +620,22 @@ int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev)
 
 	if (value & TRSP) {
 		status |= FPE_EVENT_TRSP;
-		netdev_info(dev, "FPE: Respond mPacket is transmitted\n");
+		netdev_dbg(dev, "FPE: Respond mPacket is transmitted\n");
 	}
 
 	if (value & TVER) {
 		status |= FPE_EVENT_TVER;
-		netdev_info(dev, "FPE: Verify mPacket is transmitted\n");
+		netdev_dbg(dev, "FPE: Verify mPacket is transmitted\n");
 	}
 
 	if (value & RRSP) {
 		status |= FPE_EVENT_RRSP;
-		netdev_info(dev, "FPE: Respond mPacket is received\n");
+		netdev_dbg(dev, "FPE: Respond mPacket is received\n");
 	}
 
 	if (value & RVER) {
 		status |= FPE_EVENT_RVER;
-		netdev_info(dev, "FPE: Verify mPacket is received\n");
+		netdev_dbg(dev, "FPE: Verify mPacket is received\n");
 	}
 
 	return status;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 05ffff00a524..832998bc020b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -1067,8 +1067,6 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 	if (ret)
 		goto disable;
 
-	netdev_info(priv->dev, "configured EST\n");
-
 	return 0;
 
 disable:
@@ -1087,8 +1085,6 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 
 	stmmac_fpe_map_preemption_class(priv, priv->dev, extack, 0);
 
-	netdev_info(priv->dev, "disabled FPE\n");
-
 	return ret;
 }
 
-- 
2.34.1


