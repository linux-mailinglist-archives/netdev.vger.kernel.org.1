Return-Path: <netdev+bounces-170638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C7CA4969F
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 11:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 078CF7A6676
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 10:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A0625FA28;
	Fri, 28 Feb 2025 10:06:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-3.mail.aliyun.com (out28-3.mail.aliyun.com [115.124.28.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B4825D558;
	Fri, 28 Feb 2025 10:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740737161; cv=none; b=fkv7zsMNSCp1aiMFO7Kde9MduDMbSu0GEchqtjJ5emkno+3I65wb6exRJGn+1T+GcV4Y6gg0EwCWxhLCz7zsOUMoP/LT3cRk0FH93OM5Q5qblKreZheZjY7zO1ZDrDGBbVAPyDl4H+XIbagwSER2SR3A3nzEx4huRUIyfskwfXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740737161; c=relaxed/simple;
	bh=w1EvRB3dYdwdaRjLy1m5zA06kix0XeLvaV0nfbgkqDI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cZScpo1X7jcFDpdSzuWxXV0Kx80Vd7EZCtwId6IXwSyvEZeiKteuhXXN8yYWUPtbYGo8kNwogluWqRZfg19RdwbnA+XIJsu5HL12z9SAPXJGnJWaR5nsbvxvKpchHD614f9sniqejvTrEpLYXaUKAebFxJdCHzYTMYv2M7IXiyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from sun-VirtualBox..(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.bfyn1FV_1740736836 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 28 Feb 2025 18:00:37 +0800
From: Frank Sae <Frank.Sae@motor-comm.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Frank <Frank.Sae@motor-comm.com>,
	netdev@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Parthiban.Veerasooran@microchip.com,
	linux-kernel@vger.kernel.org,
	xiaogang.fan@motor-comm.com,
	fei.zhang@motor-comm.com,
	hua.sun@motor-comm.com
Subject: [PATCH net-next v3 07/14] phy:motorcomm: Add PHY_INTERFACE_MODE_INTERNAL to support YT6801
Date: Fri, 28 Feb 2025 18:00:13 +0800
Message-Id: <20250228100020.3944-8-Frank.Sae@motor-comm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250228100020.3944-1-Frank.Sae@motor-comm.com>
References: <20250228100020.3944-1-Frank.Sae@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

YT6801 NIC Integrated a PHY that is YT8531S, but it used GMII interface.
Add a case of PHY_INTERFACE_MODE_INTERNAL to support YT6801.

Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
---
 drivers/net/phy/motorcomm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index 0e91f5d1a..371acafd5 100644
--- a/drivers/net/phy/motorcomm.c
+++ b/drivers/net/phy/motorcomm.c
@@ -896,6 +896,12 @@ static int ytphy_rgmii_clk_delay_config(struct phy_device *phydev)
 		val |= FIELD_PREP(YT8521_RC1R_RX_DELAY_MASK, rx_reg) |
 		       FIELD_PREP(YT8521_RC1R_GE_TX_DELAY_MASK, tx_reg);
 		break;
+	case PHY_INTERFACE_MODE_INTERNAL:
+		if (phydev->drv->phy_id != PHY_ID_YT8531S)
+			return -EOPNOTSUPP;
+
+		phydev_info(phydev, "Integrated YT8531S phy of YT6801.\n");
+		return 0;
 	default: /* do not support other modes */
 		return -EOPNOTSUPP;
 	}
-- 
2.34.1


