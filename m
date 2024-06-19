Return-Path: <netdev+bounces-105038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA0290F7C7
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 22:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 873FF1C22926
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 20:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63D815ADAD;
	Wed, 19 Jun 2024 20:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWuyVpMd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D009A15AAD9;
	Wed, 19 Jun 2024 20:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718830362; cv=none; b=ra67GHhBwS+2N5TF0Jz1Sgq3ABeBjx+KrcoevWrAy/5R33Aze8nL9ajxoOQRWW9uc5px+o8Z9QJhaSk3OXysQIbcm/oY1qNfqxUiD8DYjBhj/zNBKzzz11F1JRrsm5E/Bgf2AxH/bqsr8wJFQUfz6lGcKwFpK+49EfemZVAG+u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718830362; c=relaxed/simple;
	bh=P2xkioei4W2m9uNi4ELb7GtUzD0jzZvddau24bImCAM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H4A7bXc1P4inPnkKEiip6AUhioAzKCeQOr+Y7N+Efr1w2mG6mjEGTdgA3i9O0Tblv4R30KT0kAquLGURHEty+wdnikUoYwtmAMWdI5oJIb/vHsXcIc3DtRIDeSXJVqQjSEo4ofMCidrY9XOK4L0sZ38L2EcODiWaookaMNhn9IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RWuyVpMd; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52cc129c78fso180070e87.2;
        Wed, 19 Jun 2024 13:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718830359; x=1719435159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N0SjHiibYDqytyD6tzVsGDy7l9I6Oo4+lVbbqQc5ucQ=;
        b=RWuyVpMdfU0j0VoYxudnFYEbaX23s8/aAv0KY5QxTBS1RjzZPseXSn6MBrycJ0GkDG
         MF5q/JxCZM/mHpoeFYTc/PC/0sT195cZ4yXKRB4WDx5zhUshk/QZH3M1dYcGkiWsYDZt
         5BjYEPLwaCtomTb8uLgEcBKS5BRjAcVW3WKpRmA942cSykQanvnSP3hEbogzBWcXGN4n
         4T9uwBlLgTg2g/pbT8BhXM0p8kvXzOJ1uxaX3MCgPiZ9S1QmA+00rC7hWybdSkNlgUUF
         FULX1us61p7k5ytu2mfPnzowqLkkJrLneToxy43cNcRQDe+U/8IE6PzDVCarRbMLYlk+
         XzUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718830359; x=1719435159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N0SjHiibYDqytyD6tzVsGDy7l9I6Oo4+lVbbqQc5ucQ=;
        b=tSGYggTQSLQ6rFk1IULh8joee9P2iofU27BSFZBnmOlgrMNzuF2uWboN/MUN/mxHBD
         cdD3si6ykGeO2GE8TfhublFoKTB9Z/0tPOIaDdNdP1kSHGPe5K56jlmGbRmPAQOW/FGO
         JDPpMhw7uf+k+cTIsau49w7qj4gPRmK8vUc/S8Yn2RQO6FIMySgltb69ktSTJR1aikxv
         qilKfK7+GxvhpxhVdWPVt3AR15puvfXTEwBSrDPvAvjCf3qfjTkkMTimz3LNOhH9fMRX
         Mx+Ld97l4+rhlSTqAX9P1MZH4vvSCSdt2X+/Q1FfX1LUUfHCMs2dNOByGRIALpHo5gKq
         FTMg==
X-Forwarded-Encrypted: i=1; AJvYcCVAYPJy5x7Fg8cKMuthVLg9XifuEKHHkXaEqVnKdqoq6af8d/E46jv1pPUlALJfz81w9J+7b57YEsMmjAaVjKzoEpqm21gchwCdGISR
X-Gm-Message-State: AOJu0Yz+LWjUHRhcl45ysaWY9q5JyF2npT3AbPz0HpeLSthO+D4qTqRA
	6aq6BXvwRxTHmtq0iZj5piUh/+xN4Dz1Sm4UEBbBefk6KGzUv+Pa6RMe4ZQiZ2c=
X-Google-Smtp-Source: AGHT+IFZ0legYVXUr03i4BO8bOKXy/y42zuXxsEJWMtastBu1SiCu65HqhAJ377tszMZU8Q6wXcBoQ==
X-Received: by 2002:a05:6512:3ca4:b0:52c:cbf9:c164 with SMTP id 2adb3069b0e04-52ccbf9c387mr2172605e87.9.1718830358340;
        Wed, 19 Jun 2024 13:52:38 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56db5b2fsm697329566b.47.2024.06.19.13.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 13:52:37 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 01/12] net: dsa: vsc73xx: add port_stp_state_set function
Date: Wed, 19 Jun 2024 22:52:07 +0200
Message-Id: <20240619205220.965844-2-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619205220.965844-1-paweldembicki@gmail.com>
References: <20240619205220.965844-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This isn't a fully functional implementation of 802.1D, but
port_stp_state_set is required for a future tag8021q operations.

This implementation handles properly all states, but vsc73xx doesn't
forward STP packets.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v2,v1:
  - resend only
---
Before patch series split:
https://patchwork.kernel.org/project/netdevbpf/list/?series=841034&state=%2A&archive=both
v7:
  - implement 'vsc73xx_refresh_fwd_map' simplification
v6:
  - fix inconsistent indenting
v5:
  - remove unneeded 'RECVMASK' operations
  - reorganise vsc73xx_refresh_fwd_map function
v4:
  - fully reworked port_stp_state_set
v3:
  - use 'VSC73XX_MAX_NUM_PORTS' define
  - add 'state == BR_STATE_DISABLED' condition
  - fix style issues
v2:
  - fix kdoc
---
 drivers/net/dsa/vitesse-vsc73xx-core.c | 96 +++++++++++++++++++++++---
 1 file changed, 85 insertions(+), 11 deletions(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index 4b031fefcec6..ebeea259f019 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -164,6 +164,10 @@
 #define VSC73XX_AGENCTRL	0xf0
 #define VSC73XX_CAPRST		0xff
 
+#define VSC73XX_SRCMASKS_CPU_COPY		BIT(27)
+#define VSC73XX_SRCMASKS_MIRROR			BIT(26)
+#define VSC73XX_SRCMASKS_PORTS_MASK		GENMASK(7, 0)
+
 #define VSC73XX_MACACCESS_CPU_COPY		BIT(14)
 #define VSC73XX_MACACCESS_FWD_KILL		BIT(13)
 #define VSC73XX_MACACCESS_IGNORE_VLAN		BIT(12)
@@ -623,9 +627,6 @@ static int vsc73xx_setup(struct dsa_switch *ds)
 	vsc73xx_write(vsc, VSC73XX_BLOCK_SYSTEM, 0, VSC73XX_GMIIDELAY,
 		      VSC73XX_GMIIDELAY_GMII0_GTXDELAY_2_0_NS |
 		      VSC73XX_GMIIDELAY_GMII0_RXDELAY_2_0_NS);
-	/* Enable reception of frames on all ports */
-	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_RECVMASK,
-		      0x5f);
 	/* IP multicast flood mask (table 144) */
 	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_IFLODMSK,
 		      0xff);
@@ -788,10 +789,6 @@ static void vsc73xx_mac_link_down(struct phylink_config *config,
 	/* Allow backward dropping of frames from this port */
 	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ARBITER, 0,
 			    VSC73XX_SBACKWDROP, BIT(port), BIT(port));
-
-	/* Receive mask (disable forwarding) */
-	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
-			    VSC73XX_RECVMASK, BIT(port), 0);
 }
 
 static void vsc73xx_mac_link_up(struct phylink_config *config,
@@ -844,10 +841,6 @@ static void vsc73xx_mac_link_up(struct phylink_config *config,
 	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ARBITER, 0,
 			    VSC73XX_ARBDISC, BIT(port), 0);
 
-	/* Enable port (forwarding) in the receive mask */
-	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
-			    VSC73XX_RECVMASK, BIT(port), BIT(port));
-
 	/* Disallow backward dropping of frames from this port */
 	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ARBITER, 0,
 			    VSC73XX_SBACKWDROP, BIT(port), 0);
@@ -1039,6 +1032,86 @@ static void vsc73xx_phylink_get_caps(struct dsa_switch *dsa, int port,
 	config->mac_capabilities = MAC_SYM_PAUSE | MAC_10 | MAC_100 | MAC_1000;
 }
 
+static void vsc73xx_refresh_fwd_map(struct dsa_switch *ds, int port, u8 state)
+{
+	struct dsa_port *other_dp, *dp = dsa_to_port(ds, port);
+	struct vsc73xx *vsc = ds->priv;
+	u16 mask;
+
+	if (state != BR_STATE_FORWARDING) {
+		/* Ports that aren't in the forwarding state must not
+		 * forward packets anywhere.
+		 */
+		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+				    VSC73XX_SRCMASKS + port,
+				    VSC73XX_SRCMASKS_PORTS_MASK, 0);
+
+		dsa_switch_for_each_available_port(other_dp, ds) {
+			if (other_dp == dp)
+				continue;
+			vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+					    VSC73XX_SRCMASKS + other_dp->index,
+					    BIT(port), 0);
+		}
+
+		return;
+	}
+
+	/* Forwarding ports must forward to the CPU and to other ports
+	 * in the same bridge
+	 */
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+			    VSC73XX_SRCMASKS + CPU_PORT, BIT(port), BIT(port));
+
+	mask = BIT(CPU_PORT);
+
+	dsa_switch_for_each_user_port(other_dp, ds) {
+		int other_port = other_dp->index;
+
+		if (port == other_port || !dsa_port_bridge_same(dp, other_dp) ||
+		    other_dp->stp_state != BR_STATE_FORWARDING)
+			continue;
+
+		mask |= BIT(other_port);
+
+		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+				    VSC73XX_SRCMASKS + other_port,
+				    BIT(port), BIT(port));
+	}
+
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+			    VSC73XX_SRCMASKS + port,
+			    VSC73XX_SRCMASKS_PORTS_MASK, mask);
+}
+
+/* FIXME: STP frames aren't forwarded at this moment. BPDU frames are
+ * forwarded only from and to PI/SI interface. For more info see chapter
+ * 2.7.1 (CPU Forwarding) in datasheet.
+ * This function is required for tag_8021q operations.
+ */
+static void vsc73xx_port_stp_state_set(struct dsa_switch *ds, int port,
+				       u8 state)
+{
+	struct vsc73xx *vsc = ds->priv;
+	u32 val;
+
+	val = (state == BR_STATE_BLOCKING || state == BR_STATE_DISABLED) ?
+	      0 : BIT(port);
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+			    VSC73XX_RECVMASK, BIT(port), val);
+
+	val = (state == BR_STATE_LEARNING || state == BR_STATE_FORWARDING) ?
+	      BIT(port) : 0;
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+			    VSC73XX_LEARNMASK, BIT(port), val);
+
+	/* CPU Port should always forward packets when user ports are forwarding
+	 * so let's configure it from other ports only.
+	 */
+	if (port != CPU_PORT)
+		vsc73xx_refresh_fwd_map(ds, port, state);
+}
+
 static const struct phylink_mac_ops vsc73xx_phylink_mac_ops = {
 	.mac_config = vsc73xx_mac_config,
 	.mac_link_down = vsc73xx_mac_link_down,
@@ -1057,6 +1130,7 @@ static const struct dsa_switch_ops vsc73xx_ds_ops = {
 	.port_disable = vsc73xx_port_disable,
 	.port_change_mtu = vsc73xx_change_mtu,
 	.port_max_mtu = vsc73xx_get_max_mtu,
+	.port_stp_state_set = vsc73xx_port_stp_state_set,
 	.phylink_get_caps = vsc73xx_phylink_get_caps,
 };
 
-- 
2.34.1


