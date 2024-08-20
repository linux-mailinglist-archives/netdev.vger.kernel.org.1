Return-Path: <netdev+bounces-120124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA8C9585B6
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 13:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EDF21C244C8
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 11:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022B618EFC7;
	Tue, 20 Aug 2024 11:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUlREM71"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A99A18DF87;
	Tue, 20 Aug 2024 11:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724152921; cv=none; b=L8SSYj1nuDrBtPQDIs+IVbad1zcYc34JWzYvfxU3lUX8eUx5gmx/2pTFo7uVhAK7aBVW5goxQM/mzD2UvIscLbCzQEv/T0dNctwUDfFHKPLSevMzQNDBZavUYJRqmrUDIgnpKi22BrMY6MPuFFqtMr2DqA+v67qvUB8hj2F7O5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724152921; c=relaxed/simple;
	bh=UfdVmQMRHdwKlGI4AcsY8ycSuFoMf21+xG2GXzMKNCM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VCL0yHvRXxf78JGkNwi1P7X1vUu0lqt6bqaPw1Mf72QNCPDNfsBKetiakBPz5H26UP9UDblhQOYbdrxxO5ceO3bb7bvAcocl7cnEbzCuv6BjteOvs1Wk2zg/5qQFLxGo7UOY1lbQMmL6bzE7oEBh2rCJimUKB1kyGqSXksihPRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUlREM71; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fee6435a34so33877445ad.0;
        Tue, 20 Aug 2024 04:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724152919; x=1724757719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uH60Yd1GI3CU3D/wod3TAuxBQI34Kzg4R4dXcyLgk6M=;
        b=BUlREM71fcuz1FjXmkq705iRNgfEGYdvwFpBg2EyMevHoBQtNGP/hVME8obAMYu/5g
         34U5IITH/bkhgrIPDMa3CqMnml0Izb49gxELCgFERtXB2VX0hxOwqplN3SP6qwocHpAw
         rKEuFEQC9GZpD2a4X9dq9Udtn58jvA6J7gBGvk8TQVIXuiIR4ryjFKkbiYyEyTyn9yLV
         Sk1xhMDQ+XJ3bpx5i7ZwJZqPK0sNOvjF5XljREKPbJgXHCkQrj3cMm7OojSutx44Xo1i
         ABkrSPa4mTNhVpyNe0JJ47+vMuNkhLg1KWPjPZCrECB66KEeljCT2ep5DjsKbVgPaVaT
         v0QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724152919; x=1724757719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uH60Yd1GI3CU3D/wod3TAuxBQI34Kzg4R4dXcyLgk6M=;
        b=FQAYG4GPmAY2/XWHIOeTV1nRKvoElrA17UAcqAwGdRCYcCVBs7O2yrlkLc8s8cbK/Y
         /RxJYOUIrZbpoQzZDjjP0sZ26Zlz5zkPobyIIVc7f92tmfLigaoVzOZvJBlA9gWe2z1g
         nnptXa2N/E58poowHUIElndT8legf4jpwUWQCGXFCUwfK2XmaRBA7T9DpRFXlKMEVeZK
         9tzvzEq7T8cKSnuZ4oeFFcQ47G8IIvyVipWgl3Nif1U0CugrsAegMekIMN4yrqqPMXtD
         /D5WRycOpexlCG4Z6GKaEft8sBiP/36iLQ7UrBI+DSpTIW/LAMmEOgayh4+nK5sePrQV
         bUIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqyMEOuHsARmkApb4nUWZzwOGaRCPnuxmXT5bGXpoGl7p2S7jQS43AEfOvsNCUoMIPvgSaUPgHgOd/jPBLgmKlLFhCxOvWqxeKBWsb
X-Gm-Message-State: AOJu0YyIx4B2+mGS0NvBYEVbnYD5BZ6ivjLVn4XI96ISn+yp+CF0yXRc
	4fV8VJSe90r5e2k1K6j8EuqhgAwVRmvclXj1EyHrtrLlH9b6Cjug
X-Google-Smtp-Source: AGHT+IG4H2W2UWmxm3iIQNPissd+E2bV0K2IjKg1ybnv6wOED4VkqMdaFdnlLdQ2a9a2rhVaCne0HQ==
X-Received: by 2002:a17:902:e5c8:b0:202:35e0:deaf with SMTP id d9443c01a7336-20235e0e226mr80591885ad.39.1724152918682;
        Tue, 20 Aug 2024 04:21:58 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-201f03756f6sm76465355ad.172.2024.08.20.04.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 04:21:58 -0700 (PDT)
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
Subject: [PATCH net-next v5 7/7] net: stmmac: silence FPE kernel logs
Date: Tue, 20 Aug 2024 19:20:41 +0800
Message-Id: <07ea91555fe6bcf86f287549ebb23fcfbe5cc115.1724152528.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1724152528.git.0x1207@gmail.com>
References: <cover.1724152528.git.0x1207@gmail.com>
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
index dcf2b5ea7b4f..a5d01162fcc5 100644
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


