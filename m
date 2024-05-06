Return-Path: <netdev+bounces-93711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C26788BCE2E
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 14:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73F68280946
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 12:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFF71DA23;
	Mon,  6 May 2024 12:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ei09gRNs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723F41DA22;
	Mon,  6 May 2024 12:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714999204; cv=none; b=MTlhxaXxZchbQ3uPzDNrmMze8TV/OdQe5v9/egD0k/yfMb/kF2xjiDhagGLUF55UzlY4bZHiBquZe/D8OU74DjmX2ZWkpAL8fufpT8200QbvPbLMs0KLx3wXwGZxZIM6NWfp4P52mb/1AJj/0w296213RArg0f0bjptMn+65ZI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714999204; c=relaxed/simple;
	bh=I0aEhq4nU2NqcfNEZMplKejLv864kLLf/BLQOapouH4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LtWsHb78gVwL4QvCznSte40LmO4oU+iHed08J2XQBqWOzrDLjHR+htaQRYmDMQYZJfio/DudAFLvP6PCh/0ZLsCmp7Ut+u7Zwoj7GJrPyPApIiT5bSGrSsgHaTCeCKv5Ob3zimFOT6kFSw3jdvbBsCS6bOtXRYtAFYTf1/oj0MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ei09gRNs; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41ba1ba55e8so11243485e9.1;
        Mon, 06 May 2024 05:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714999201; x=1715604001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rxjJb/KzzXIFQHfzAUi7FnhbwHdNprYeBkYOQsJcPKk=;
        b=ei09gRNspAdb2aqMI3I9Vj7edy3cn++1uV1LjRbzhzHNk2Autqa0iuz1Oed/stdicj
         pBKCwURcFKjKYvcQ79G/pa+ZD603+7RRTY7WCouQ32FgvAB+krYoBovnbmHKqZSgKFcG
         0JXwTQYwx5q7nK2Nh61yUDOvOFRTwHO2azzwHp4o/WWg05WByTyqMxwtQSa9vVOSN6gi
         fGlM9LlMjkyW97fmtLg7oMFpdm0sSr2upJUMYqyPEBr63Hv0FVYrD07U+sbB1ww+8mft
         3IccpIi0J2HEnPahGRJ8KdqgwF7wODikjdjKxqkpaXRRbW/hXlIOrS9Qp86DrkPRbWlT
         XVzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714999201; x=1715604001;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rxjJb/KzzXIFQHfzAUi7FnhbwHdNprYeBkYOQsJcPKk=;
        b=tX304PVVm0JKpPSHTt+bdVvPBRBuHyehdPwqkSKlz7sXTuqi5daV92EmARiGLka1Sy
         wkQcYnG7dKIQ0WUtF+riTPRKrJPDt60CDiqZaj/TopWDa6o0r392enqy3IjN0geig0uV
         J+SrSxmxhClX68LjNdzNp1sHzNR//4EZYkpZxcmVBZu7e2P9qaKIt7lYMOxCFnuWbpN8
         KsKgJ2WT+PhbkelrXiNxMyZLz0yhzxeJohdagOoFvMFZP5M3U8uI8WoOcbCytUd0468E
         XoITZTPwle7QHMCsSDpS0bLXAL3c6NEPw1Z46yvaEa1vKXHmKC/gQ+kS5xiuHWxxDg5R
         d9og==
X-Forwarded-Encrypted: i=1; AJvYcCUvsmOzSh6mv3E6/DkkzfqYUVEu2D/Bs9+k/mtLn025WnIXXGGToM4n+Ku52kdqpNK1vsH6hOF922WKLB4tS6urU2kQqs8eOICBJkzhQAblAfwQiOhOcKvapND5MqJXXZ/DJEH8
X-Gm-Message-State: AOJu0Yzb1dxbOD4XdDHcE3wIRukcDwkYYkGCfViqt7kiAYLnwuder3oU
	RWInOiUh6eGtVFgNgfjvl7ziYIUFPcoXGbJ+bAqaBjSEQVaAv6NO
X-Google-Smtp-Source: AGHT+IFkCu+JtPeZm2GUtpMORrZzigCeL8aXT4N3/ncy5DZ8TaVMDuXbslHscLBHDWJBFqgIrb6ZgA==
X-Received: by 2002:a05:600c:1c03:b0:41a:3868:d222 with SMTP id j3-20020a05600c1c0300b0041a3868d222mr7722487wms.0.1714999200464;
        Mon, 06 May 2024 05:40:00 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id g17-20020adfa491000000b0034de87e81c7sm10714865wrb.23.2024.05.06.05.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 05:39:59 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH] net: stmmac: dwmac-ipq806x: account for rgmii-txid/rxid/id phy-mode
Date: Mon,  6 May 2024 14:32:46 +0200
Message-ID: <20240506123248.17740-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the ipq806x dwmac driver is almost always used attached to the
CPU port of a switch and phy-mode was always set to "rgmii" or "sgmii".

Some device came up with a special configuration where the PHY is
directly attached to the GMAC port and in those case phy-mode needs to
be set to "rgmii-id" to make the PHY correctly work and receive packets.

Since the driver supports only "rgmii" and "sgmii" mode, when "rgmii-id"
(or variants) mode is set, the mode is rejected and probe fails.

Add support also for these phy-modes to correctly setup PHYs that requires
delay applied to tx/rx.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c
index 281687d7083b..4ba15873d5b1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c
@@ -171,6 +171,9 @@ static int ipq806x_gmac_set_speed(struct ipq806x_gmac *gmac, unsigned int speed)
 
 	switch (gmac->phy_mode) {
 	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
 		div = get_clk_div_rgmii(gmac, speed);
 		clk_bits = NSS_COMMON_CLK_GATE_RGMII_RX_EN(gmac->id) |
 			   NSS_COMMON_CLK_GATE_RGMII_TX_EN(gmac->id);
@@ -410,6 +413,9 @@ static int ipq806x_gmac_probe(struct platform_device *pdev)
 	val |= NSS_COMMON_GMAC_CTL_CSYS_REQ;
 	switch (gmac->phy_mode) {
 	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
 		val |= NSS_COMMON_GMAC_CTL_PHY_IFACE_SEL;
 		break;
 	case PHY_INTERFACE_MODE_SGMII:
@@ -425,6 +431,9 @@ static int ipq806x_gmac_probe(struct platform_device *pdev)
 	val &= ~(1 << NSS_COMMON_CLK_SRC_CTRL_OFFSET(gmac->id));
 	switch (gmac->phy_mode) {
 	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
 		val |= NSS_COMMON_CLK_SRC_CTRL_RGMII(gmac->id) <<
 			NSS_COMMON_CLK_SRC_CTRL_OFFSET(gmac->id);
 		break;
@@ -442,6 +451,9 @@ static int ipq806x_gmac_probe(struct platform_device *pdev)
 	val |= NSS_COMMON_CLK_GATE_PTP_EN(gmac->id);
 	switch (gmac->phy_mode) {
 	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
 		val |= NSS_COMMON_CLK_GATE_RGMII_RX_EN(gmac->id) |
 			NSS_COMMON_CLK_GATE_RGMII_TX_EN(gmac->id);
 		break;
-- 
2.43.0


