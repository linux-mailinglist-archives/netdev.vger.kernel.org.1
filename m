Return-Path: <netdev+bounces-151325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F37419EE24C
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 10:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95C8818834E6
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 09:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF6B20E337;
	Thu, 12 Dec 2024 09:11:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D699F13E40F
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 09:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733994675; cv=none; b=DJN2xQbl/jMuq9/9+sLvouamr85Yg0YbeVnFljv9OISD2/RCJkNahT7iVKf/zIH8rNcfC585iTosYlkp0jn+0sf1Oc5w7v+6jDrqXPbmMzB6YmR/QexiLqPgHeZgxiMVYw8kXzK8P/gBqU3dymo9vNyf4/9dwTHETbWr4NNHLnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733994675; c=relaxed/simple;
	bh=WDwwYJ37rfDfcKE8p30b6KSBblv0uqzeb7SmpZ5Lnl4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E10xm4bQkDRr8Il/hEo18/8k6D+szk/rfeutMUM0/bFRjb6HbhkhEhvkPS912s9ku1c0u8BUtqJdVRs3DgM9hXARL35kZcwGSar3211hDHSh1r3mZKBvSaojXemXAWnoCtuPvLiuDmmZZZNCustXtlWO6+8uG6QF2m51Dbx09oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:a086:deff:83e6:222b])
	by albert.telenet-ops.be with cmsmtp
	id nlB22D0071T2bNC06lB20e; Thu, 12 Dec 2024 10:11:05 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tLfDn-000pz0-DP;
	Thu, 12 Dec 2024 10:11:02 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tLfDp-00DEhg-UU;
	Thu, 12 Dec 2024 10:11:01 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] drm/rockchip: avoid 64-bit division
Date: Thu, 12 Dec 2024 10:10:59 +0100
Message-Id: <20241212091100.3154773-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Dividing a 64-bit integer prevents building this for 32-bit targets:

ERROR: modpost: "__aeabi_uldivmod" [drivers/gpu/drm/rockchip/rockchipdrm.ko] undefined!

As this function is not performance criticial, just Use the div_u64() helper.

Fixes: 128a9bf8ace2 ("drm/rockchip: Add basic RK3588 HDMI output support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
index 9c796ee4c303a9a9..c8b362cc2b95fd49 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
@@ -82,7 +82,7 @@ static void dw_hdmi_qp_rockchip_encoder_enable(struct drm_encoder *encoder)
 		 * comment in rk_hdptx_phy_power_on() from
 		 * drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
 		 */
-		phy_set_bus_width(hdmi->phy, rate / 100);
+		phy_set_bus_width(hdmi->phy, div_u64(rate, 100));
 	}
 }
 
-- 
2.34.1


