Return-Path: <netdev+bounces-279312-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CC6kOVwr4mns2QAAu9opvQ
	(envelope-from <netdev+bounces-279312-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 14:45:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9679741B4A0
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 14:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B1898306BFD0
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 12:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECC439D6C8;
	Fri, 17 Apr 2026 12:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BbsaZDRT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC7F39478F
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 12:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776429896; cv=none; b=Vw8lmOg0oq4p4axEfXN2En2xc4eKdtQfwWVMNs/dYDcuXZVjFdUmXx2XVhQUK+nk9/oeNidKewjf/ijONE7EuAQvdiwNfZVP8pWH6r2cMNpxe5ywxxGcwBmF1B0/zKY1gd9/LD+1sYo5n1fvNPLkhUM7o5SKxgbv+0XgE41hjPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776429896; c=relaxed/simple;
	bh=8J3euFUAkX555f6UH9lDBy9GyKozalMKu453mhRKq+A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RzjbfUdkxcS1p+sEDUoVrq6XhI2uqUfICNLMckJwQs+K6UEbTGGLj7+08csD5Jg+bltNoOjmxc+8n5eYKmiiEeQHdoYk3SF5v2nNtEKTbd6xqYs6CrxrcyZi1X7ZmY8W7xyMnPSscqfltPAyLlTLSQHZyEF2DWjNezoGd2FFTGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BbsaZDRT; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488a4bc360bso3931695e9.0
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 05:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776429892; x=1777034692; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1zS1PBWa+JXK0MkE3TTgbc7YFAJrep/RIJGz8IkXGLY=;
        b=BbsaZDRT7pc50n+3rQsOL3Tpjt22oUSU03SocCMEqcJp/TI8f0HFvGlPw6ASqTgq0t
         m2M56zFMnpN1BdU/nDbFI/afqls/r8qD215v6aSidCDT4U1t9oJf4bHrd05zEpVxeBB1
         0dolk9oOhJJ3h3Eeb0IcrZeruNzcta0GtN6T5AgkBJJ9JrOHGTrkwsUsvWGprntzjJZb
         oP8P1V2uuYg5zGeelbMhZzPBbC6bC+Km2vYeVzAxcvKxr7luPwnrAc4sqCCh1xKEM5/h
         Tui6Jz0YEGTw1vl3e96p2GU/MKH1w/rzeKGzPcghiIvNtRpV4ORzMbpWobHMszcLG9a1
         n0rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776429892; x=1777034692;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1zS1PBWa+JXK0MkE3TTgbc7YFAJrep/RIJGz8IkXGLY=;
        b=JFZs8QODCfwkvIdm0PN1iVZKajEcvv11lz3C0wEppBU+D1DcwYD01ZmigKcIFQoXRm
         1k+sk7CoPFJSGZ3DyTyA4pGW+QUpEoe4zjQYfdJWX4EkMsM0GUZKfoG6BAxsyAZeNKXI
         2PlqrDKjm8B72BFaaqWAkaDoOBe3Npv9+zcOCHkjvBDYV8bqJC35zDk327EaIkwMviCg
         6B5bTzCNtqqxeh1/gNqmSNX2tdQ5WPukwD4AAlsQvZa3ZaPAhJZBdqOTVTF6rzGBBW1E
         +q+rQwCu75khJE1B66OyzfAzLRNIfIZXbwZEjvROLGjYhq8qT2stRk9N2lVqkd6ZGIeY
         fN4g==
X-Forwarded-Encrypted: i=1; AFNElJ+lVVjPigZxh2HC7BZXvEXOz3B5WTZmvQ1ULhBQk2FrHCJIu9oNzoAUtuH7heNJXl7TFDBs7iU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhtqusu0jf45YrXbN+a8E3S+wMpuSBm8XpElDoExWQCYreO0SZ
	UJATLsX70X2IXnSedXnXzFytS6Ktt+RF6vNFOJoxgKLQE+MMLCDZGF5S
X-Gm-Gg: AeBDievMxxRbpGWD7s7+9PE0Kw3Vtce0R1WniXQjjrdHS33bR6q3gSQgv3k4H+14+Xb
	K5zQbRgv46v4Vk6NsqS9oDaZL5ACKVSlfBB/Rv+wxUAxX3j/UpoX9V6wKwcMYvl0vZzsqvN+PVj
	HYQ+Fmmw9AZQCCOa9IJidFNeJi2HA+E8mYnINYjkpx2OoYUZulwv+oUTiW8ZWjIiGyLdSatd8l4
	PS49VWmqd63C8E2vKy2xOJ03nkp9BLRP2HPSu49hanZ8FmxEGUFsSU98CO1ytJxsG/MgRHGINUE
	Q+KJIlojoC/hnreGg0RjVIv/LojikU3FsuJHHm2dol6mYRiOswZN+lWxvB0qPckUyq83W1mykrW
	gVM4SCoATyhh3qIF5H2vGESH8Gur0yNRw8jBehrDhBhHDafgZGUA3lZ0IaA3V8irE2NOUX5qw/9
	ClRyMCxkk0UtuYvA71hhDyfj450tW2dDbxde5RmcnznVqfjrtMpS+E8J7/+PqVwBEXcN3frY2e+
	20Ta9G+GLP/qcL07dTrFO31D2iJnfs=
X-Received: by 2002:a05:600c:c090:b0:488:c744:49b with SMTP id 5b1f17b1804b1-488fb74a53dmr28081015e9.7.1776429892308;
        Fri, 17 Apr 2026 05:44:52 -0700 (PDT)
Received: from [127.0.1.1] (cust-east-par-46-193-119-166.cust.wifirst.net. [46.193.119.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc100162sm47416315e9.5.2026.04.17.05.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 05:44:51 -0700 (PDT)
From: Fidelio Lawson <lawson.fidelio@gmail.com>
X-Google-Original-From: Fidelio Lawson <fidelio.lawson@exotec.com>
Date: Fri, 17 Apr 2026 14:44:27 +0200
Subject: [PATCH v4 1/3] net: dsa: microchip: implement KSZ87xx Module 3
 low-loss cable errata
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260417-ksz87xx_errata_low_loss_connections-v4-1-6c7044ec4363@exotec.com>
References: <20260417-ksz87xx_errata_low_loss_connections-v4-0-6c7044ec4363@exotec.com>
In-Reply-To: <20260417-ksz87xx_errata_low_loss_connections-v4-0-6c7044ec4363@exotec.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Marek Vasut <marex@denx.de>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Woojung Huh <Woojung.Huh@microchip.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Fidelio Lawson <fidelio.lawson@exotec.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776429890; l=7515;
 i=fidelio.lawson@exotec.com; s=20260326; h=from:subject:message-id;
 bh=8J3euFUAkX555f6UH9lDBy9GyKozalMKu453mhRKq+A=;
 b=TNlxopG6Lb2gnbhvoBiBKAbztrtqfO5uHHa8jEth4SqdDdA/sbfw9WCJlCeqekHE8sI4v2Wxf
 HIezHZSvA5CD9rJNyJTlsjsczzruBZ3NrYkI1PdM1Sb5ilZ/TdVZChl
X-Developer-Key: i=fidelio.lawson@exotec.com; a=ed25519;
 pk=866eH9Bmmpjc+ctgkr5T1uXxBefZzob3tEEuiVWZ6BI=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,bootlin.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-279312-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lawsonfidelio@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[exotec.com:mid,exotec.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9679741B4A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Implement the "Module 3: Equalizer fix for short cables" erratum from
Microchip document DS80000687C for KSZ87xx switches.

The issue affects short or low-loss cable links (e.g. CAT5e/CAT6),
where the PHY receiver equalizer may amplify high-amplitude signals
excessively, resulting in internal distortion and link establishment
failures.

KSZ87xx devices require a workaround for the Module 3 low-loss cable
condition, controlled through the switch TABLE_LINK_MD_V indirect
registers.

This change models the erratum handling as vendor-specific Clause 22 PHY
registers, virtualized by the KSZ8 DSA driver and accessed via
ksz8_r_phy() / ksz8_w_phy(). The following controls are provided:

- A boolean “short-cable” preset, which applies a documented and
  conservative configuration (LPF 62 MHz bandwidth and DSP EQ initial
  value 0), and is the recommended interface for typical use cases.

- Separate LPF bandwidth and DSP EQ initial value controls intended for
  advanced or experimental tuning. These are orthogonal and independent,
  and override the corresponding settings without requiring any specific
  ordering.

The preset and tunables act as simple setters with no implicit state
machine or invalid combinations, keeping the API predictable and aligned
with the KISS principle.

The erratum affects the shared PHY analog front-end and therefore applies
globally to the switch.

Signed-off-by: Fidelio Lawson <fidelio.lawson@exotec.com>
---
 drivers/net/dsa/microchip/ksz8.c       | 67 ++++++++++++++++++++++++++++++++++
 drivers/net/dsa/microchip/ksz8.h       |  1 +
 drivers/net/dsa/microchip/ksz8_reg.h   | 21 ++++++++++-
 drivers/net/dsa/microchip/ksz_common.h |  4 ++
 4 files changed, 92 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index c354abdafc1b..0f2b8acee80f 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -1058,6 +1058,22 @@ int ksz8_r_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 *val)
 		if (ret)
 			return ret;
 
+		break;
+	case PHY_REG_KSZ87XX_SHORT_CABLE:
+		if (!ksz_is_ksz87xx(dev))
+			return -EOPNOTSUPP;
+		data = !!(dev->lpf_bw == KSZ87XX_PHY_LPF_62MHZ &&
+				dev->eq_init == KSZ87XX_DSP_EQ_INIT_LOW_LOSS);
+		break;
+	case PHY_REG_KSZ87XX_LPF_BW:
+		if (!ksz_is_ksz87xx(dev))
+			return -EOPNOTSUPP;
+		data = dev->lpf_bw;
+		break;
+	case PHY_REG_KSZ87XX_EQ_INIT:
+		if (!ksz_is_ksz87xx(dev))
+			return -EOPNOTSUPP;
+		data = dev->eq_init;
 		break;
 	default:
 		processed = false;
@@ -1271,6 +1287,29 @@ int ksz8_w_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 val)
 		if (ret)
 			return ret;
 		break;
+	case PHY_REG_KSZ87XX_SHORT_CABLE:
+		if (!ksz_is_ksz87xx(dev))
+			return -EOPNOTSUPP;
+		ret = ksz87xx_apply_low_loss_preset(dev, !!val);
+		if (ret)
+			return ret;
+		break;
+	case PHY_REG_KSZ87XX_LPF_BW:
+		if (!ksz_is_ksz87xx(dev))
+			return -EOPNOTSUPP;
+		ret = ksz8_ind_write8(dev, TABLE_LINK_MD, KSZ87XX_REG_PHY_LPF, (u8)val);
+		if (ret)
+			return ret;
+		dev->lpf_bw = val;
+		break;
+	case PHY_REG_KSZ87XX_EQ_INIT:
+		if (!ksz_is_ksz87xx(dev))
+			return -EOPNOTSUPP;
+		ret = ksz8_ind_write8(dev, TABLE_LINK_MD, KSZ87XX_REG_DSP_EQ, (u8)val);
+		if (ret)
+			return ret;
+		dev->eq_init = val;
+		break;
 	default:
 		break;
 	}
@@ -2096,11 +2135,39 @@ int ksz8463_w_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 val)
 	return 0;
 }
 
+int ksz87xx_apply_low_loss_preset(struct ksz_device *dev, bool enable)
+{
+	/* Apply the Microchip erratum short-cable preset (LPF 62 MHz, EQ init 0) */
+	/* providing a conservative configuration for short or low-loss cables. */
+	u8 lpf_bw, eq_init;
+	int ret;
+
+	lpf_bw = KSZ87XX_PHY_LPF_62MHZ;
+	eq_init = KSZ87XX_DSP_EQ_INIT_LOW_LOSS;
+
+	if (!ksz_is_ksz87xx(dev))
+		return -EOPNOTSUPP;
+	if (!enable)
+		return 0;
+	ret = ksz8_ind_write8(dev, TABLE_LINK_MD, KSZ87XX_REG_PHY_LPF, lpf_bw);
+	if (ret)
+		return ret;
+	dev->lpf_bw = lpf_bw;
+	ret = ksz8_ind_write8(dev, TABLE_LINK_MD, KSZ87XX_REG_DSP_EQ, eq_init);
+	if (ret)
+		return ret;
+	dev->eq_init = eq_init;
+
+	return ret;
+}
+
 int ksz8_switch_init(struct ksz_device *dev)
 {
 	dev->cpu_port = fls(dev->info->cpu_ports) - 1;
 	dev->phy_port_cnt = dev->info->port_cnt - 1;
 	dev->port_mask = (BIT(dev->phy_port_cnt) - 1) | dev->info->cpu_ports;
+	dev->lpf_bw = KSZ87XX_PHY_LPF_90MHZ;
+	dev->eq_init = KSZ87XX_DSP_EQ_INIT_FACTORY;
 
 	return 0;
 }
diff --git a/drivers/net/dsa/microchip/ksz8.h b/drivers/net/dsa/microchip/ksz8.h
index 0f2cd1474b44..5cf7bd90af0f 100644
--- a/drivers/net/dsa/microchip/ksz8.h
+++ b/drivers/net/dsa/microchip/ksz8.h
@@ -66,5 +66,6 @@ int ksz8_all_queues_split(struct ksz_device *dev, int queues);
 u32 ksz8463_get_port_addr(int port, int offset);
 int ksz8463_r_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 *val);
 int ksz8463_w_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 val);
+int ksz87xx_apply_low_loss_preset(struct ksz_device *dev, bool enable);
 
 #endif
diff --git a/drivers/net/dsa/microchip/ksz8_reg.h b/drivers/net/dsa/microchip/ksz8_reg.h
index 332408567b47..5df17c463f7c 100644
--- a/drivers/net/dsa/microchip/ksz8_reg.h
+++ b/drivers/net/dsa/microchip/ksz8_reg.h
@@ -202,6 +202,10 @@
 #define REG_PORT_3_STATUS_0		0x38
 #define REG_PORT_4_STATUS_0		0x48
 
+/* KSZ87xx LinkMD registers (TABLE_LINK_MD_V) */
+#define KSZ87XX_REG_DSP_EQ			0x08   /* DSP EQ initial value */
+#define KSZ87XX_REG_PHY_LPF			0x4C   /* RX LPF bandwidth */
+
 /* For KSZ8765. */
 #define PORT_REMOTE_ASYM_PAUSE		BIT(5)
 #define PORT_REMOTE_SYM_PAUSE		BIT(4)
@@ -342,7 +346,7 @@
 #define TABLE_EEE			(TABLE_EEE_V << TABLE_EXT_SELECT_S)
 #define TABLE_ACL			(TABLE_ACL_V << TABLE_EXT_SELECT_S)
 #define TABLE_PME			(TABLE_PME_V << TABLE_EXT_SELECT_S)
-#define TABLE_LINK_MD			(TABLE_LINK_MD << TABLE_EXT_SELECT_S)
+#define TABLE_LINK_MD			(TABLE_LINK_MD_V << TABLE_EXT_SELECT_S)
 #define TABLE_READ			BIT(4)
 #define TABLE_SELECT_S			2
 #define TABLE_STATIC_MAC_V		0
@@ -729,6 +733,21 @@
 #define PHY_POWER_SAVING_ENABLE		BIT(2)
 #define PHY_REMOTE_LOOPBACK		BIT(1)
 
+/* Vendor-specific Clause 22 PHY registers (virtualized) */
+#define PHY_REG_KSZ87XX_SHORT_CABLE		0x1A
+#define PHY_REG_KSZ87XX_LPF_BW			0x1B
+#define PHY_REG_KSZ87XX_EQ_INIT			0x1C
+
+/* LPF bandwidth bits [7:6]: 00 = 90MHz (default), 01 = 62MHz, 10 = 55MHz, 11 = 44MHz  */
+#define KSZ87XX_PHY_LPF_90MHZ          0x00
+#define KSZ87XX_PHY_LPF_62MHZ          0x40
+#define KSZ87XX_PHY_LPF_55MHZ          0x80
+#define KSZ87XX_PHY_LPF_44MHZ          0xC0
+
+/* Low-loss workaround DSP EQ INIT VALUE */
+#define KSZ87XX_DSP_EQ_INIT_LOW_LOSS	0x00
+#define KSZ87XX_DSP_EQ_INIT_FACTORY		0x0F
+
 /* KSZ8463 specific registers. */
 #define P1MBCR				0x4C
 #define P1MBSR				0x4E
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 929aff4c55de..482e79cf6ae6 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -219,6 +219,10 @@ struct ksz_device {
 	 * the switch’s internal PHYs, bypassing the main SPI interface.
 	 */
 	struct mii_bus *parent_mdio_bus;
+
+	/* KSZ87xx low-loss tuning state */
+	u8 lpf_bw;		/* KSZ87XX_PHY_LPF_* */
+	u8 eq_init;		/* DSP EQ initial value */
 };
 
 /* List of supported models */

-- 
2.53.0


