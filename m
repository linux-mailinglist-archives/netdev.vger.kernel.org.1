Return-Path: <netdev+bounces-120069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4FD9582F2
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 11:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A4F4282F3B
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 09:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928FD18CC09;
	Tue, 20 Aug 2024 09:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mabgw+CB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C08D18C924;
	Tue, 20 Aug 2024 09:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724146775; cv=none; b=GBm8l6Gv/lgXv6cCM0ykhySyzC3b7Bj/ipIByR5JML+kkhQGw2BIKg/57MpqvxZyomBOWWtXmcSBrOExIiM2ulTRfcRO0x1iVBMA3Y1q/+NIq2zAVEWs05JCjyoOj+gZrhKumc0LCerptKRR0T1eTuKXLAn5wfDs+a19eY/YRRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724146775; c=relaxed/simple;
	bh=64jdsCFG/rW/LRC/WmG5Usf3xYiVRC/Y+mGFFtggrAA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oG0cb/puCXSmUKfV077hpCZ1gUjjoQR+tna1kIgWDsq5SmRHp+sC+7/gTa7KFLrhOmsnOEXGEF9d5UNOxYYjH6hFnVuk65bAesfCTpkaCWqYFnx07b5okAJ2rRXDbxSr9mLYVeKJPZaNt4IobhIYTmnpn9fu99A8/aXw1moAudo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mabgw+CB; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2d3d7a1e45fso3042983a91.3;
        Tue, 20 Aug 2024 02:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724146773; x=1724751573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDtdR8L72ecyhWl64ylKYwjwtNgYUGDBUuM8QKvBiWw=;
        b=Mabgw+CBFJR/QSliwCr3tBUr967u5GNuB6Qp5ojU0mdRUJWtXXSpvFcNcMtXOj5iWR
         K8SrWArRp7CTjNh77pTPnMveu70DMPLpglVx5/oE5Yly5QkBAJqZJtn+hF3YIrATEtyc
         9JEzdiv42O9LhYjcisn/xCBQyWzidgasJ0c+JlCRsB5n+1WUUXcjoXFkZvG1mSqy1pEj
         +hSXOKuBFzv7GUAoHmekpc2ZD8++RYLWKUF3m9L1GW1M1y5WTsS3UWcgf0cPq9CHSzE6
         fRZCNstzEQAs0ZseUZDCVtX4rRtCeYl/y0giWgt+I85nJon9UA2VYVgGd9zTpcn9JpXk
         J25A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724146773; x=1724751573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NDtdR8L72ecyhWl64ylKYwjwtNgYUGDBUuM8QKvBiWw=;
        b=d2cgYgq0btX8kR8ET69Q9BhcTbqoBZrq3meEuxYA/VgVf5YfmavqcQ8g91P3+ZVBqO
         FXLqspJ1uQSvl9uek+Vpaij3uTm0Ggf/vZhWTlFOO4CL2heWDefp8BzqWTKg7lVnTbnb
         h1wBsfaqI+hm1RuyFiFlNKbr2b5k4ZSHXIWzEY5qjILTwWODRCIb82jLAgko2qk1BHSI
         eOuf0OQdY70iIRImuK7cb2IdICHHv1ugbil3xJAqSMNHHVcKMk62bHRSKiX3xFsv/KHZ
         ILQh59qg3N5RBZ8M57lwdEbglm/PYvZq1GLCkoJvmRXbSrTHvIsc5MC5whWlohYfhVqv
         MxLA==
X-Forwarded-Encrypted: i=1; AJvYcCUUg6voCBCbOcQlvHE11b931FO7I1ztjbnUbesiyf1UXE4G4A2KIZiClfrops7sjWk+obvg9U1Wn6xkz/w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6WlHguZ2qTGo8BNzN+GHxpSvc5ANSg91at5SlJTEOWifvaZIh
	9ExB/jeg4sBaoC4+iCzanUSbFYGd1AGqN1d23X9e2xJ6alikMF8B
X-Google-Smtp-Source: AGHT+IFM4ALEVhEA9jwy8QPIVnmjGZziok5D7VHZfUwJtcYii+q/qpP+UCWZHHS37xt6cRdHvesDRQ==
X-Received: by 2002:a17:90a:c918:b0:2c9:7cc8:8e33 with SMTP id 98e67ed59e1d1-2d3dffc0fe9mr13661819a91.13.1724146773301;
        Tue, 20 Aug 2024 02:39:33 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2d45246061dsm3230608a91.8.2024.08.20.02.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 02:39:32 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: Serge Semin <fancer.lancer@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
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
	xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v4 7/7] net: stmmac: silence FPE kernel logs
Date: Tue, 20 Aug 2024 17:38:35 +0800
Message-Id: <3d7f0ad310e02b7c604df6da1408e141ad4c2e2e.1724145786.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1724145786.git.0x1207@gmail.com>
References: <cover.1724145786.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ethtool --show-mm can get real-time state of FPE.
Those kernel logs should keep quiet.

Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac5.c      | 8 ++++----
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
index 1e87dbc9a406..c9905caf97ff 100644
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
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 6d7aca411af7..e2e1f1d6ff39 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3378,7 +3378,7 @@ static int stmmac_fpe_start_wq(struct stmmac_priv *priv)
 
 		return -ENOMEM;
 	}
-	netdev_info(priv->dev, "FPE workqueue start");
+	netdev_dbg(priv->dev, "FPE workqueue start");
 
 	return 0;
 }
@@ -4058,7 +4058,7 @@ static void stmmac_fpe_stop_wq(struct stmmac_priv *priv)
 		priv->fpe_wq = NULL;
 	}
 
-	netdev_info(priv->dev, "FPE workqueue stop");
+	netdev_dbg(priv->dev, "FPE workqueue stop");
 }
 
 /**
-- 
2.34.1


