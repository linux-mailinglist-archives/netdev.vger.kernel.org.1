Return-Path: <netdev+bounces-136870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C319A35A7
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 08:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A798728506A
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 06:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7121885B9;
	Fri, 18 Oct 2024 06:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROinSKhy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86344187FE8;
	Fri, 18 Oct 2024 06:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729233622; cv=none; b=O4W5GEJ7FvXiNLsDW72PzocyRiwI06Me1QDDjcn8T6TDbaNhuHg71QCPxFoR0qAm4daCjIxtDOnXycZMC4iS9F7KHLAdkOmMWR6neoydZTLTYhnsOXWnEX9hTgUvPzEO54DEjF+Cl03r7ZmQRncwqX3R6zaJpOR0A9Lhvrmyza0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729233622; c=relaxed/simple;
	bh=DOkdgqVyF0AQQ94hlqyAUUW0IqpVreg8vrXgkhO5F7E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OsQzOj2GqvKFBv7bUpnSxixhtPeq1wPoHbRSypRGMkVzT4Cszun9mD/KO6MoXuhsLpgdJ5aAN72LyNceZ9iWxmSb5uFZD2B8V7L4l51o1A0GQt0geXerFZN87ZkhsTmpfWRJcp2FG7FJT7bOVWvF/MW+HN92Ld0AqNW+0xFBVM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ROinSKhy; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71e52582cf8so1208057b3a.2;
        Thu, 17 Oct 2024 23:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729233619; x=1729838419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XoXtS/KGKf23o7SadlNvmNMchc09V1cBlERiDv3SWtA=;
        b=ROinSKhywzoXt+4PvofBfYXujXxFJ0XInJlhvLZD9mp149EsXTbvDdiMLIn7DmSUws
         G/2mSicrciIiL3I/htHnp5J8ttfbbBgz44px12KpLCqdIAqoZydE0FZ0Gf6w3rYTiSIw
         O3Fn9Rdw29rDeCIuLG/coTkYO9wG8L1rQOncKwyMzX1ldP2VcpTt/bQJZRJm8NO9XksQ
         oCG5ws/WChYQ0sqDSPF6coO2S2WrAWPFX0IaTr0AXn8QyWhHYKuiJXMmED0iKEAN5v5T
         mZkyyCgJegGN+ZlXc0lHUvVNGJJmlmt7eaxHok0tLVUDHRAc4/mLDRi1BBBv1vT4MWrf
         ULUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729233619; x=1729838419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XoXtS/KGKf23o7SadlNvmNMchc09V1cBlERiDv3SWtA=;
        b=UKjoUqObMH9Qiaji+8EETYhe/Hieev3oAj53cWrG1SxI/vKPxYk5t2grq4D6g6yXgs
         hsqeY6oWmHGi6xyKQ6wAVJcbfL1ZR2WbCOgdHUyRxFnhh+ii2Yg5Ce8OxgX3BBs3Airr
         TI65JNySD2JVh3JwIa3FFHsCYFHU/QRuJlUXY0A0ikP7bYX/kdZPDXohyER5x0PHdk31
         r3d4Ax1Q3daLtrD59aadA6jx6igJPyN9luBKAWl5LXcQkcQ/nKeGNZVOXiOaoXyoGYYX
         AQ/KoYU5c86f+ozIhJVSWHBs2n+2wYutlWFk2cQdiBpZ4yoTuJ+0rRBwYsYg76ENy/TN
         KeDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFqy1N/PUIKvBtiJAwlTgWA0YmrePKt92PDHmTwbHCQyweINfSVC/DjKj6UsggPw6AogcG8OqQCYilVWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPAai4vEqbpM+DkTBvyEDaAdgS089OutOrKV+1+ynxgAZ5wt/P
	Pe4i6eImHySEgexmhjdKPU6ovzRDBQ8j0w0akNMlxhN0jEd9zNGUdivupQ==
X-Google-Smtp-Source: AGHT+IFFaWqo8s2PogDyWr1TfL5kF7TPRLJZblqmXL/T96wFz/6aJcEDmf7jOlIVt8f2REax0Z2yew==
X-Received: by 2002:a05:6a21:3987:b0:1d0:7df2:cf39 with SMTP id adf61e73a8af0-1d92c49fc2bmr1883151637.7.1729233618398;
        Thu, 17 Oct 2024 23:40:18 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20e5a74766fsm6285455ad.73.2024.10.17.23.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 23:40:17 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v2 6/8] net: stmmac: xgmac: Switch to common_fpe_configure()
Date: Fri, 18 Oct 2024 14:39:12 +0800
Message-Id: <21491b72dfbd0d396425505b6d3e2680caf5a3da.1729233020.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1729233020.git.0x1207@gmail.com>
References: <cover.1729233020.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the redundant code and share the common one.

Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  1 +
 .../net/ethernet/stmicro/stmmac/stmmac_fpe.c  | 28 +++++++------------
 2 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index c66fa6040672..e1c54f3a8ee7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -96,6 +96,7 @@
 #define XGMAC_LPIIS			BIT(5)
 #define XGMAC_PMTIS			BIT(4)
 #define XGMAC_INT_EN			0x000000b4
+#define XGMAC_FPEIE			BIT(15)
 #define XGMAC_TSIE			BIT(12)
 #define XGMAC_LPIIE			BIT(5)
 #define XGMAC_PMTIE			BIT(4)
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
index 9245e360109f..dfe911b3f486 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
@@ -360,25 +360,17 @@ static void dwxgmac3_fpe_configure(void __iomem *ioaddr,
 				   u32 num_txq, u32 num_rxq,
 				   bool tx_enable, bool pmac_enable)
 {
-	u32 value;
-
-	if (!tx_enable) {
-		value = readl(ioaddr + XGMAC_MAC_FPE_CTRL_STS);
-
-		value &= ~STMMAC_MAC_FPE_CTRL_STS_EFPE;
-
-		writel(value, ioaddr + XGMAC_MAC_FPE_CTRL_STS);
-		return;
-	}
-
-	value = readl(ioaddr + XGMAC_RXQ_CTRL1);
-	value &= ~XGMAC_FPRQ;
-	value |= (num_rxq - 1) << XGMAC_FPRQ_SHIFT;
-	writel(value, ioaddr + XGMAC_RXQ_CTRL1);
+	static const struct stmmac_fpe_configure_info dwxgmac3_fpe_info = {
+		.rxq_ctrl1_reg = XGMAC_RXQ_CTRL1,
+		.fprq_mask = XGMAC_FPRQ,
+		.fprq_shift = XGMAC_FPRQ_SHIFT,
+		.mac_fpe_reg = XGMAC_MAC_FPE_CTRL_STS,
+		.int_en_reg = XGMAC_INT_EN,
+		.int_en_bit = XGMAC_FPEIE,
+	};
 
-	value = readl(ioaddr + XGMAC_MAC_FPE_CTRL_STS);
-	value |= STMMAC_MAC_FPE_CTRL_STS_EFPE;
-	writel(value, ioaddr + XGMAC_MAC_FPE_CTRL_STS);
+	common_fpe_configure(ioaddr, cfg, num_rxq, tx_enable, pmac_enable,
+			     &dwxgmac3_fpe_info);
 }
 
 const struct stmmac_fpe_ops dwmac5_fpe_ops = {
-- 
2.34.1


