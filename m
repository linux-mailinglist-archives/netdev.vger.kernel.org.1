Return-Path: <netdev+bounces-253554-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id S+u0LIKjd2ktjwEAu9opvQ
	(envelope-from <netdev+bounces-253554-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 18:25:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 190948B6EB
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 18:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17B153003334
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 17:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90879349AF5;
	Mon, 26 Jan 2026 17:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvJLTQhg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F3D346AE8
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 17:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769448319; cv=none; b=T9DRXjuk7UbIKq/PqpXZQXpQhhw1QBjArG5kc/dpl5Wj9Fo4TfQDjnwqsxH0+stIeKe1tWIgKbRI9BbxvRMSsTYyO+XhWc47wSHLi1l4CHVdh/1AxS8M7dLZ/3aYSJlvJ3DlMnCPdR43JFZ2DYTMjpk8SrXre7BEKFjlMbZeMJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769448319; c=relaxed/simple;
	bh=Z9egbW4PzribQ2BUsv8FP0Zs6A2lyVBkqKP8TaaVKRw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GArB87U9Du7KbwB9OY6nOYSWnpTzpNSMeV7JyKsIa+sAjM9BkrpvaE8vga0Uqy+67ZFTTM6VNOt9ctvrV7QtCCkLPaDmYeGBxMRXsyoOQDGrBoQd4uAjfyP3egou1FsIhkJJgA8be0DDI/Vfr/SyfDg6ekgrklZhxP0c7vMWslg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DvJLTQhg; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4359228b7c6so3066812f8f.2
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 09:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769448316; x=1770053116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I8NCqtdKCDQg/h+vlP7+WRT2HIbB0HaXTUJf1+ishbw=;
        b=DvJLTQhgXOROjdcWLdlvc6eZZjQWHpHRFNHNbXVOTc2KfyRdXMGxD2xnR5N1L8lwNe
         bLSWYDX96uxWq1hfajZIxiWLJAm5Eqw0YO96L8g3iYUGqIujmHWeRy9aM4Yvuws0fXNl
         q7IZSWfVbwXpTfbcsrWXGnABOz0mcXCvmxlZEsH9cCooFV5En8Odx4rNCPNnjkyJLIAN
         6/WJGthpTwE/xtKVVbyi9+cOH6+yDMHSUxXWDWN93TGlbACKgJI1vLCF9dWf5pCcO5rZ
         5ftncT9I5u4wdmRl/vzfwv46amYfqo4NDJaCqbMcLApAU/LCEzT7QGV23Mtg72JeAeI/
         OGFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769448316; x=1770053116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I8NCqtdKCDQg/h+vlP7+WRT2HIbB0HaXTUJf1+ishbw=;
        b=oXXt62oa5kKt3FsnKXmifKO0why+dUu7jdOWIM9V4qHkQUc1ZVjpJ9EzO1TgHz307U
         wUfLLcROGEdPfijdD+DDsH3ZWgeYcbmM50+SbQswaYwvADZtQQJVk3OINAo3UYVMFCSL
         uITgnnBu94PfGWT0uXO92kHLqnVB1GUAMJS/NECbjSljgobcq7128w5qBwtAXY5GRxwg
         ycfZ8qybfwnoOoGdt+s4jvoK8gU4snyUhrcswJ3A3GxzwMpvUWSbzS8GFBeHdppTAMCB
         Uv/2opnQGAJxxsCErZH/6UxmELugVO1hj7YxQ3JPbdSGaRHb3o8jV/jp2sLYbLenpIlj
         bSfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoJrhBig020l3auBME5VEHomGVBaITMkPPSOjxtF7rt6LU3A9SBoSekUS1RlpEaaaK6koz0Yw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfkGTCjgzxomV2utw0WiOHRKTEdbLF/CECzhi6wLCZUJZhdDjZ
	goq7MlbjvOWV2P2NNLWuDWB3cSyNb9SFfZFsgNOl0A0E+0cIDWZdkUAb
X-Gm-Gg: AZuq6aKgfIBu9wjefxc10mb4TWQy/Q4xZZyzSBjxqSzbhlV0uT/Jw95dO4JPG7eYdza
	8zaQjsezdtVJNikEIUFXm0/7oIBwLXjGoIfvXsfSZK/v2PjAAIT4BqXgVlU6NxK5APCzs4xgXp7
	d3juNcb7ORAxBurF7LEV6VCitGx9JKF92NzGaP2w1YUATPQkgwxfYnwzJ4vQKdOUYAW7wRriW+b
	bF51Cva0lxP/9qRYv2HQQOKtow15ySHYdz0ZRWThBGyKqqxzmlwbje7ZFVJZVdf6kpdXnsWZg2A
	JX7gIHjckiG08MPbW7f7EyKX7V1OcHp7wbk1K8LBbEq231ocSMg6KVn8Sd1z1xxskuHb4CDPyBL
	WZYwK45l2hyS0PJPoy8I4OlkFgORKVzc5QyOSMarzRKRdZFhMQ0yrLHMHMFrlPkBwR9Yvm3WHTU
	yDBJWo3jls6Z8iNN6Am4/eeTHKOiXOv/vhra/Z2m0nXwByNAm/PI/rmrOHoFCV7d/2SlBL1R4Z1
	XQRo1fvKYqZHB320Z5GgRzJ/u8oS5XjU+F5leyp8ld5
X-Received: by 2002:a05:6000:2889:b0:435:9e32:2b78 with SMTP id ffacd0b85a97d-435ca0f7b5cmr7897753f8f.1.1769448315992;
        Mon, 26 Jan 2026 09:25:15 -0800 (PST)
Received: from iku.example.org ([2a06:5906:61b:2d00:6788:ac2b:89cc:7ade])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c24bf8sm31288531f8f.11.2026.01.26.09.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 09:25:15 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	netdev@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [RFC PATCH net-next] net: stmmac: Preserve bootloader MAC address across unconditional reset
Date: Mon, 26 Jan 2026 17:25:03 +0000
Message-ID: <20260126172503.238724-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253554-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[st-md-mailman.stormreply.com,lists.infradead.org,vger.kernel.org,gmail.com,bp.renesas.com,renesas.com];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,pengutronix.de,armlinux.org.uk,glider.be,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prabhakarcsengg@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,kernel,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bp.renesas.com:mid,renesas.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 190948B6EB
X-Rspamd-Action: no action

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Commit 90f522a20e3d1 ("NET: dwmac: Make dwmac reset unconditional")
asserts a reset in probe when a reset controller is present. This reset
clears the MAC address registers, so a valid address programmed by the
bootloader gets lost and the driver falls back to a random address.

Read the MAC address from the hardware registers before resetting the
hardware. Keep the existing address selection logic when no valid
address is found, and program the selected address back into the MAC
after probe so it remains consistent in hardware.

Export stmmac_bus_clks_config() so the early read path can enable the
bus clocks before accessing the MAC registers.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
Hi all,

Sending this patch as an RFC if there is an alternative/better way to
achieve this.

Cheers,
Prabhakar
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 66 ++++++++++++++++++-
 .../ethernet/stmicro/stmmac/stmmac_platform.c |  3 +-
 .../ethernet/stmicro/stmmac/stmmac_platform.h |  2 +
 3 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 347a0078f622..171bf08d6242 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -44,6 +44,7 @@
 #include <net/page_pool/helpers.h>
 #include <net/pkt_cls.h>
 #include <net/xdp_sock_drv.h>
+#include "stmmac_platform.h"
 #include "stmmac_ptp.h"
 #include "stmmac_fpe.h"
 #include "stmmac.h"
@@ -7659,11 +7660,65 @@ struct plat_stmmacenet_data *stmmac_plat_dat_alloc(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(stmmac_plat_dat_alloc);
 
+static int stmmac_read_mac_before_reset(struct stmmac_priv *priv,
+					u8 *mac_addr)
+{
+	unsigned int hi_addr, lo_addr;
+	int ret;
+
+	eth_zero_addr(mac_addr);
+
+	/* Deassert reset to allow hardware access */
+	if (priv->plat->stmmac_rst) {
+		ret = reset_control_deassert(priv->plat->stmmac_rst);
+		if (ret)
+			return ret;
+	}
+
+	/* Enable bus clocks to read MAC address */
+	ret = stmmac_bus_clks_config(priv, true);
+	if (ret) {
+		dev_warn(priv->device, "failed to enable clocks: %d\n", ret);
+		goto assert_reset;
+	}
+
+	switch (priv->plat->core_type) {
+	case DWMAC_CORE_GMAC4:
+	case DWMAC_CORE_XGMAC:
+		/* GMAC4/XGMAC: MAC Address0 High/Low Register */
+		hi_addr = 0x300;  /* GMAC_ADDR_HIGH(0) */
+		lo_addr = 0x304;  /* GMAC_ADDR_LOW(0) */
+		break;
+	case DWMAC_CORE_GMAC:
+	case DWMAC_CORE_MAC100:
+		/* GMAC/GMAC3/MAC100: MAC Address0 High/Low Register */
+		hi_addr = 0x40;   /* GMAC_ADDR_HIGH(0) */
+		lo_addr = 0x44;   /* GMAC_ADDR_LOW(0) */
+		break;
+	default:
+		hi_addr = 0;
+	}
+
+	if (hi_addr)
+		stmmac_get_mac_addr(priv->ioaddr, mac_addr, hi_addr, lo_addr);
+
+	ret = 0;
+
+	stmmac_bus_clks_config(priv, false);
+
+assert_reset:
+	if (priv->plat->stmmac_rst)
+		reset_control_assert(priv->plat->stmmac_rst);
+
+	return ret;
+}
+
 static int __stmmac_dvr_probe(struct device *device,
 			      struct plat_stmmacenet_data *plat_dat,
 			      struct stmmac_resources *res)
 {
 	struct net_device *ndev = NULL;
+	u8 saved_mac_addr[ETH_ALEN];
 	struct stmmac_priv *priv;
 	u32 rxq;
 	int i, ret = 0;
@@ -7740,6 +7795,9 @@ static int __stmmac_dvr_probe(struct device *device,
 	if ((phyaddr >= 0) && (phyaddr <= 31))
 		priv->plat->phy_addr = phyaddr;
 
+	/* Save MAC address before reset (if bootloader programmed it) */
+	stmmac_read_mac_before_reset(priv, saved_mac_addr);
+
 	if (priv->plat->stmmac_rst) {
 		ret = reset_control_assert(priv->plat->stmmac_rst);
 		reset_control_deassert(priv->plat->stmmac_rst);
@@ -7768,7 +7826,13 @@ static int __stmmac_dvr_probe(struct device *device,
 	if (priv->synopsys_id < DWMAC_CORE_5_20)
 		priv->plat->dma_cfg->dche = false;
 
-	stmmac_check_ether_addr(priv);
+	if (is_valid_ether_addr(saved_mac_addr))
+		eth_hw_addr_set(priv->dev, saved_mac_addr);
+	else
+		stmmac_check_ether_addr(priv);
+
+	/* Store the MAC address in hardware */
+	stmmac_set_umac_addr(priv, priv->hw, priv->dev->dev_addr, 0);
 
 	ndev->netdev_ops = &stmmac_netdev_ops;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 8979a50b5507..6f0393f2992d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -857,7 +857,7 @@ void stmmac_pltfr_remove(struct platform_device *pdev)
 }
 EXPORT_SYMBOL_GPL(stmmac_pltfr_remove);
 
-static int stmmac_bus_clks_config(struct stmmac_priv *priv, bool enabled)
+int stmmac_bus_clks_config(struct stmmac_priv *priv, bool enabled)
 {
 	struct plat_stmmacenet_data *plat_dat = priv->plat;
 	int ret;
@@ -888,6 +888,7 @@ static int stmmac_bus_clks_config(struct stmmac_priv *priv, bool enabled)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(stmmac_bus_clks_config);
 
 static int __maybe_unused stmmac_runtime_suspend(struct device *dev)
 {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
index 6e6561e29d6e..2d52197020a7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
@@ -20,6 +20,8 @@ struct clk *stmmac_pltfr_find_clk(struct plat_stmmacenet_data *plat_dat,
 int stmmac_get_platform_resources(struct platform_device *pdev,
 				  struct stmmac_resources *stmmac_res);
 
+int stmmac_bus_clks_config(struct stmmac_priv *priv, bool enabled);
+
 int stmmac_pltfr_probe(struct platform_device *pdev,
 		       struct plat_stmmacenet_data *plat,
 		       struct stmmac_resources *res);
-- 
2.52.0


