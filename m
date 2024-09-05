Return-Path: <netdev+bounces-125404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D910196D010
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 09:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FFF01F229A2
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 07:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC3219308C;
	Thu,  5 Sep 2024 07:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtCRvia+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D683193089;
	Thu,  5 Sep 2024 07:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725519820; cv=none; b=MaetY3BiTkn34NyMcLt2tx3DjXc7NXvJq5s7QckqmUhcNO7/EuZWOZsWLMPPcH/56Wpk2NZ7kFyXU6qTQQjbQV27JzHd63EtgYdULB0kO1L2rOVHYmyHs3Md/01m1V1oJZVxxK/VrZswiRu9K+PiLw98dvCLopAw3+i3a1CaNKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725519820; c=relaxed/simple;
	bh=uATaIRx9OcP3lwMiOCbDklWScZz5mzW+ytPV1fbBNrA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BFp8Qk/kkBabsjHZAXmeK/UG4BgbfvlUseyA4xjnLN8RcWGKiQG1Acfla/YqVOzg9o1ox8EVFTzI9daxK+SGxTy6m5MBZwG1HgzdSqjo86vPhiWZwRQV0QZ2BxPp0UQO3Hc5OxjTtSp0OHrSf7iv1yAYxb4VHoNLTnUtX/STR88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KtCRvia+; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-717911ef035so139886b3a.3;
        Thu, 05 Sep 2024 00:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725519818; x=1726124618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfapUPCdk+siVEwgEq3PbpS5y/HhD3hQ8rgnXlxCpW0=;
        b=KtCRvia+w70Wn2vlOplEaP4JwjZpyHk8mdmDG6V4TY+jcl4eTwOG8ZIYKFrcNbfD64
         xCE9m90STxga/9nQyfz9s9bb9SSTuJk4tnVr80zwNv1nrlWJYzSHp+L/pyRC5NMb1YDx
         fi51Wxd+o3aNjfiq2YEQgAmTpvgrAAz22nJJSKExZKMtiXx+oHkVgvI5j6UdHDCTnMPn
         kXNtjCyf2uqKJr3rOVl8u+tB1AthTYYfc10pJG4h30ZPT44wFPg8Yu9T9XdvdBA+8i2q
         BnXJBI9bAMFW1T+5nq8H9D1WY8VsGM1krs9Fa1BcIvEfMunxac5hHZY544pODN8ApGgA
         gU5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725519818; x=1726124618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TfapUPCdk+siVEwgEq3PbpS5y/HhD3hQ8rgnXlxCpW0=;
        b=lTkoGvkv739HrmTw0+ckSf0q8IPP5kwGhSt6lWShTRTBO9JHPhkgnrpHxKUR6ry20h
         /TqD0rx2X2XcFtAiB3FZfkvlP/oRfzky/whlFi3oQCiIcuJBv7uUzH2H0FpZQaLHehng
         psIzc/WhPM1lx4iEYlU3SJhJQM4UKILlH/sDjrgV5CRfuI79HlRzuRw/QrH05i/g5/nB
         /haQ3RYutfQLXIxaNVAsoK5jjXcpAcNJaxLriZgjlT9O/5wj8X8xJrXWmE1zwXldCO3a
         HOYVTdjhh5ERiIY/IEmatgSrWHwjZCwUsI+wUXSe/KuBxQtOK7FiDtShM6tY1bIYR65L
         ULOg==
X-Forwarded-Encrypted: i=1; AJvYcCXS7ZlEPmSGDZkqd/YZliIsXp/HR8eNPLP8jncjKfC3etFV3kgluCtnxNC+hnN346Y3SlXj8lNuu9SUMfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSgAQONXLoUwQzR+l/OFpFxIPmIFcVtqht4CrErE96VbB5nCiF
	MF//c8YBgBcq6JNIGJG8t4LMDTeo63E7NyGeFQC7Y9IFSCko12Tl
X-Google-Smtp-Source: AGHT+IGii6PtVv9KvmKGnq1WevztWTEPtDxorA0y/riP75ryI+hbpR1PSKa2hS+6paAGe1PFO+09fg==
X-Received: by 2002:a05:6300:4041:b0:1ce:cde2:4458 with SMTP id adf61e73a8af0-1ced053ba33mr16509365637.35.1725519818235;
        Thu, 05 Sep 2024 00:03:38 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71778595107sm2604897b3a.150.2024.09.05.00.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 00:03:37 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: Vladimir Oltean <olteanv@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
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
Subject: [PATCH net-next v8 7/7] net: stmmac: silence FPE kernel logs
Date: Thu,  5 Sep 2024 15:02:28 +0800
Message-Id: <508ae4f14cf173c9bd8a630b8f48a59a777f716e.1725518136.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1725518135.git.0x1207@gmail.com>
References: <cover.1725518135.git.0x1207@gmail.com>
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
---
 drivers/net/ethernet/stmicro/stmmac/dwmac5.c    | 8 ++++----
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c | 4 ----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
index dd9583968962..580c02eaded3 100644
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


