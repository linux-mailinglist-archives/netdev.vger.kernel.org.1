Return-Path: <netdev+bounces-237567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A946DC4D47A
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 12:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFEFE18C1FBC
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 10:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA4935581F;
	Tue, 11 Nov 2025 10:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="jcSQBGKm"
X-Original-To: netdev@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2A4351FBE;
	Tue, 11 Nov 2025 10:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762858403; cv=none; b=Gzrk7egagr08pEeLfQrkCSHJRTMY9/ZffEYhxryjVI6jdLpC0NoG1EUETanEs2ouOck7qOvp9WCya96ANNpjgylYfKmi8kD0RzqcjCkmq4MsFWtondFeqP2CpBOS2aQQ1jhfeKWKaamQ8xmQdJg5VyRG8yqYhy2ASnp54EmI7TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762858403; c=relaxed/simple;
	bh=g7mlGe76mNaw/xOZJ6E1PI1pNY6kIC2FIUf9CvUkl0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZlWwZ0gXVDfruaANJjxheEBJaL6GAktbPoDVI6qwU94G9/5yaAHd7aN++6cGdytHCkYzDZjh866OTdP5SLgNjQWTBqI+I5UJqMrBaBC43DlblEFSCnaX7jd0NE1rwKe/n9BB4ZreQQa8vxPHauNu2RPhnRYp8XSR/aGPw/+GXmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=jcSQBGKm; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 659B822D94;
	Tue, 11 Nov 2025 11:53:20 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o9Ovi-Y2y_qQ; Tue, 11 Nov 2025 11:53:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1762858399; bh=g7mlGe76mNaw/xOZJ6E1PI1pNY6kIC2FIUf9CvUkl0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jcSQBGKm/vAejL7+xus1TLVJO5Z2xoqsf80rqZbeh5HEiKnzTBGt45aBZcfa//8Ca
	 uMn/2KJ0i6BLizTda3xFqn9k3lWN+dCLiT41mKNXfTZGEMFkAgXcz6AhP/dNDtZNzw
	 YyG3QzivOllF/vG4CGlL/B1esq2Cp5Jr8S3mykX0J+165FDx0caY0tUpJG+qA1x4TU
	 YdSQlgQ9lMbRmNdyug/qN8EAkmX2GdG2uuvVr9JZcIzSHKq5KJ6r6GuqsYIdUSXuV9
	 0KMD/AFwHoPOaNGB9s9eUFBvrY/K482OuLeH5ty5qJz8bbWoPHXgpSuxlPSSGT6RJ1
	 xgqlBBBaHgELw==
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
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 1/3] net: phy: motorcomm: Support YT8531S PHY in YT6801 Ethernet controller
Date: Tue, 11 Nov 2025 10:52:50 +0000
Message-ID: <20251111105252.53487-2-ziyao@disroot.org>
In-Reply-To: <20251111105252.53487-1-ziyao@disroot.org>
References: <20251111105252.53487-1-ziyao@disroot.org>
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


