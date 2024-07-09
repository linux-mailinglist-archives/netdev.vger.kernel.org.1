Return-Path: <netdev+bounces-110155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C64F992B205
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 10:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CB902811D4
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 08:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6179B152796;
	Tue,  9 Jul 2024 08:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YX3fUXYW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9D7152790;
	Tue,  9 Jul 2024 08:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720513365; cv=none; b=khHOh+7q3B6Zw2QunLBlyE2U5WH4OfPvntP8NzNFSawO2zFBt3k0Rjpd6yELXumvjI5U++D1c6DvRzLU5lWDABUEVyuJQzS3QlV9RYtWfxig9QOu2A6US+2SuUpE18i0vshtIlsMFlwLvpcWGxESUuOJxKmkvT5eVPv8+eMazzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720513365; c=relaxed/simple;
	bh=pukf2ZFmWYgdgj+I+fGtKpAhSns8eXa/8zLwp4d/F34=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l2Va7q7g0vfh/GK5HkXPKyA46nTGt8tUxUSgNFVV6/3QIE8vb6zLd8R6Oh9ZBA2EKvRkc5tDqz4SuVQSSA3Z7UerRkIRtVY6bkb0WNsN9h+RY/hUxY785SZXApK9q6DGlBEULYB/6kNXoSLY+LVR1bkPSrnaLkk22zQMWqfpYgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YX3fUXYW; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2c97aceb6e4so3353521a91.2;
        Tue, 09 Jul 2024 01:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720513363; x=1721118163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kG7XBsQlE3wteyMVxAgB3FeKItlmk44xoPu+CQNnd0w=;
        b=YX3fUXYWc0c6OT973d2Mwwg1eIMIBtiEfIWffJTntgchgRdcoI+VI5NhGdAs1+24G/
         syjKikwGM0Tr9cBX2IKK/j+sZJz9JgzMSwEWxc9tNYRRq3NSiYH9kj2PsxDL1+FqZ0b0
         +hO+X4F7QVDsUcSAg4uIPx9drzBbY2aOIXQ56nFivj8oNFBddTApn/Nqi+Qy9KKORVXH
         I+K9XtmLEFUl4eit7Orv4Sr1p05yb+ODqKimtEXJy70EAqqW6iTHqRLw+ntkC22FXU18
         YogLOy3iLn1QNZeOF6rsMyOY/UcqgSHzGtSherietnRhQjhNFiZ+SyVWxhilsRE+4LiG
         odGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720513363; x=1721118163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kG7XBsQlE3wteyMVxAgB3FeKItlmk44xoPu+CQNnd0w=;
        b=on0FBokciThfYjT1SVO0hKk4R4uBORZgh6HykjEIoBFh/xCqf3/+lRGlx806hdNZCa
         2rHG/KQOuDN9rm5p2z7XjM6DN18zPjUorSDoRIDm1wZk/E5b0Rv6luE+0oqpMx3NXooa
         Xy7R1R+9LuFpJE6FTEdcYyCTOd/lWPysMoqdLkCL7S/Et653pJP4mVJobGy5DfPegNS5
         Y040jLyh1x44CEIZQA1lR+6HyAXJijR3gN4yyRt76MGIYNaDtzd4s+kwQ+Km8mRKhaMa
         3LHQp1K9Epm1/T8555SbUX3wHnK8QIVBMBqnmmRy0PTtgpb7zefSuNLOY4sS/aXlJ22w
         YVTA==
X-Forwarded-Encrypted: i=1; AJvYcCUZSqTusp54Y6XwNFjr9/ExywX9rneqTmAiIdyfl8uds7ou7lCvk3RIH4IYNg9Cqx+0JwnZMQ/+sZjBjIGg/6Ub0Lw6RuIXXMWxYvHR
X-Gm-Message-State: AOJu0Ywu18KWEZnB1BkPg/qz8X2EMCyl7dqzQsCYlSLWalf0040PWatz
	jT8VfuBVzer255mRhw237VkcU/qzp0txNiYlwhBxTbXKse114A9Fb4fS5Q==
X-Google-Smtp-Source: AGHT+IFgGL6RTLzIY5jdRBvv34mJdpYMSNbt5TDn2M3+NI7ogAZwEyXUqJrg0iTQS9IS1HL8eNA2Bw==
X-Received: by 2002:a17:90a:4966:b0:2bd:d42b:22dc with SMTP id 98e67ed59e1d1-2ca35d533b9mr1624494a91.43.1720513362881;
        Tue, 09 Jul 2024 01:22:42 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2c99a92a430sm9588929a91.4.2024.07.09.01.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 01:22:42 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
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
	rock.xu@nio.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v1 1/7] net: stmmac: xgmac: drop incomplete FPE implementation
Date: Tue,  9 Jul 2024 16:21:19 +0800
Message-Id: <d142b909d0600b67b9ceadc767c4177be216f5bd.1720512888.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1720512888.git.0x1207@gmail.com>
References: <cover.1720512888.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The FPE support for xgmac is incomplete, drop it temporarily.
Once FPE implementation is refactored, xgmac support will be added.

Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  2 --
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 27 -------------------
 2 files changed, 29 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index 6a2c7d22df1e..917796293c26 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -193,8 +193,6 @@
 #define XGMAC_MDIO_ADDR			0x00000200
 #define XGMAC_MDIO_DATA			0x00000204
 #define XGMAC_MDIO_C22P			0x00000220
-#define XGMAC_FPE_CTRL_STS		0x00000280
-#define XGMAC_EFPE			BIT(0)
 #define XGMAC_ADDRx_HIGH(x)		(0x00000300 + (x) * 0x8)
 #define XGMAC_ADDR_MAX			32
 #define XGMAC_AE			BIT(31)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index 6a987cf598e4..e5bc3957041e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -1505,31 +1505,6 @@ static void dwxgmac2_set_arp_offload(struct mac_device_info *hw, bool en,
 	writel(value, ioaddr + XGMAC_RX_CONFIG);
 }
 
-static void dwxgmac3_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
-				   u32 num_txq,
-				   u32 num_rxq, bool enable)
-{
-	u32 value;
-
-	if (!enable) {
-		value = readl(ioaddr + XGMAC_FPE_CTRL_STS);
-
-		value &= ~XGMAC_EFPE;
-
-		writel(value, ioaddr + XGMAC_FPE_CTRL_STS);
-		return;
-	}
-
-	value = readl(ioaddr + XGMAC_RXQ_CTRL1);
-	value &= ~XGMAC_RQ;
-	value |= (num_rxq - 1) << XGMAC_RQ_SHIFT;
-	writel(value, ioaddr + XGMAC_RXQ_CTRL1);
-
-	value = readl(ioaddr + XGMAC_FPE_CTRL_STS);
-	value |= XGMAC_EFPE;
-	writel(value, ioaddr + XGMAC_FPE_CTRL_STS);
-}
-
 const struct stmmac_ops dwxgmac210_ops = {
 	.core_init = dwxgmac2_core_init,
 	.set_mac = dwxgmac2_set_mac,
@@ -1570,7 +1545,6 @@ const struct stmmac_ops dwxgmac210_ops = {
 	.config_l3_filter = dwxgmac2_config_l3_filter,
 	.config_l4_filter = dwxgmac2_config_l4_filter,
 	.set_arp_offload = dwxgmac2_set_arp_offload,
-	.fpe_configure = dwxgmac3_fpe_configure,
 };
 
 static void dwxlgmac2_rx_queue_enable(struct mac_device_info *hw, u8 mode,
@@ -1627,7 +1601,6 @@ const struct stmmac_ops dwxlgmac2_ops = {
 	.config_l3_filter = dwxgmac2_config_l3_filter,
 	.config_l4_filter = dwxgmac2_config_l4_filter,
 	.set_arp_offload = dwxgmac2_set_arp_offload,
-	.fpe_configure = dwxgmac3_fpe_configure,
 };
 
 int dwxgmac2_setup(struct stmmac_priv *priv)
-- 
2.34.1


