Return-Path: <netdev+bounces-241226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C68C8197E
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 17:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6796C3495EB
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 16:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBF82989B0;
	Mon, 24 Nov 2025 16:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="fc7uAUCe"
X-Original-To: netdev@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032CF1A285;
	Mon, 24 Nov 2025 16:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764001969; cv=none; b=DAN8nbDnYvdtoobJIwLfGz716nQgB/VRAwRcb6qkCZstQJkKrDfCAN70yL5l5nf/tIXaDaJwsTp2EwgHyVAdcEZyZGWh4flFsSIHsSzbvLVBpRPEYj2sT9xWeI6becVcgRPfVe/9HXAmtjIYed1/s5xMOS1aFbtQT59YA5adU5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764001969; c=relaxed/simple;
	bh=g7mlGe76mNaw/xOZJ6E1PI1pNY6kIC2FIUf9CvUkl0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I1jZuMYEFR1jc2zhCQIK+cbObn/AAIDd2NtzgDXp0QcVPgFoZkEKqscaJ7BN+ltmPFGABXIX373Xlf1PLWuJXATF4fzzl1bWrNljjJOyt6ToHFcZ30nmAQTxA7kaRLeCqprLVoA9Q6NLe+Ly+c1tMq5PTffcf2qv19RUtCZmag8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=fc7uAUCe; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id A19C925E88;
	Mon, 24 Nov 2025 17:32:44 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ADK_3Zy4OxAN; Mon, 24 Nov 2025 17:32:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1764001963; bh=g7mlGe76mNaw/xOZJ6E1PI1pNY6kIC2FIUf9CvUkl0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fc7uAUCe/uFQ/AEcalCDLoOJJydOnry3z85zcw+NByVSYGLcyjmCerwjv41UBRXwM
	 yjMdyDV3jvqwStlIwg5fkF5YZ6JR1q9fCf9C7YTgo/kuj2EiST5Pdil9O/R/kHAJyV
	 6WcGs7c3GFCeo/f7E7bwT9lTRHycJofC2Rits5WNWwn15s/fKwE9eV9178q975L7N+
	 WQcuJnhIqdYdvaqlUsv6I+gZ1DSeBkNtA68EDGhVvxhKtwRf5icWMFsDSIBD8VwsCs
	 dTfu3V6W54VVtwX5MhfMPOkZuVpYLAgVlpBcedB/uBTRXQcVcT70X5j1YocvLkZq5s
	 IvP306ryTE/9Q==
From: Yao Zi <ziyao@disroot.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Yao Zi <ziyao@disroot.org>,
	Frank <Frank.Sae@motor-comm.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Furong Xu <0x1207@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>
Subject: [PATCH net-next v3 1/3] net: phy: motorcomm: Support YT8531S PHY in YT6801 Ethernet controller
Date: Mon, 24 Nov 2025 16:32:09 +0000
Message-ID: <20251124163211.54994-2-ziyao@disroot.org>
In-Reply-To: <20251124163211.54994-1-ziyao@disroot.org>
References: <20251124163211.54994-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

YT6801's internal PHY is confirmed as a GMII-capable variant of YT8531S
by a previous series[1] and reading PHY ID. Add support for
PHY_INTERFACE_MODE_GMII for YT8531S to allow the Ethernet driver to
reuse the PHY code for its internal PHY.

Link: https://lore.kernel.org/all/a48d76ac-db08-46d5-9528-f046a7b541dc@motor-comm.com/ # [1]
Co-developed-by: Frank Sae <Frank.Sae@motor-comm.com>
Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 drivers/net/phy/motorcomm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index 89b5b19a9bd2..b751fbc6711a 100644
--- a/drivers/net/phy/motorcomm.c
+++ b/drivers/net/phy/motorcomm.c
@@ -910,6 +910,10 @@ static int ytphy_rgmii_clk_delay_config(struct phy_device *phydev)
 		val |= FIELD_PREP(YT8521_RC1R_RX_DELAY_MASK, rx_reg) |
 		       FIELD_PREP(YT8521_RC1R_GE_TX_DELAY_MASK, tx_reg);
 		break;
+	case PHY_INTERFACE_MODE_GMII:
+		if (phydev->drv->phy_id != PHY_ID_YT8531S)
+			return -EOPNOTSUPP;
+		break;
 	default: /* do not support other modes */
 		return -EOPNOTSUPP;
 	}
-- 
2.51.2


