Return-Path: <netdev+bounces-111220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F799303E9
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 07:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB4F41C2242F
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 05:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3315137C33;
	Sat, 13 Jul 2024 05:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hq90AX6H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B817137928;
	Sat, 13 Jul 2024 05:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720850135; cv=none; b=PR5SevKflYV6lwhy35dMWKTKe4oJorS5dR+7p2JaAaShxHWsvDYVLjC0KfVwKM9gQwja2aIBiCuBZhpJXgF6LZPG+rWf8w7v2rLQLq4vb0WyCPi/dNXsHaRM/19l78T1rf17kqiOBbVe2u7bFfCNYQKlfZVf9R7W7P1ZGVEY2Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720850135; c=relaxed/simple;
	bh=m61yrLiCo/6Coqan3yroa8I4c7Fp0BM+pnhcB9oQZzk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qloy+OGXieUmx1z8E+vdOVOIznipWbb3yzAe/Cf+GlnR0lx2Gp8SLxiHdUzoetgQeySUeadhp1Kjo6hYf2W5Sgy8A43HlcyO2vZWJJ+pV+pANNHy83ccq+mgZOasBBMk7bL5lGwg1Ue9dxcPkePtxtY0TakghlxGKesF3iQ/vU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hq90AX6H; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2eea8ea8bb0so51043771fa.1;
        Fri, 12 Jul 2024 22:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720850132; x=1721454932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TJ8lt0WIPJML/L+Gu3zpYCM/DKICydm3DLZEC2BtLFY=;
        b=hq90AX6HgCNflw1ytD/c4xBC+jF411ILS1ST7lNKX2Nd7Dgi0A4EqR+UotmFN5p25A
         /SoOFePMEx/dTO15kxXjVCeMMq7Ta8vLCj6jrefbKPcaCB0bHWC9CLMZsPwg2nwhJWEW
         Le0ACv+e9NEEtTZ60XPc6S/singZya3CgCnuRHx+7dtdJ+WHeF7ZloO+tUl6nyeJIaAd
         YCA4IN+NB8q9gUip63k+ru+Sug8RmnaTVur5cnWkohSuwK92Coz11kzBVi0gGB3dDRvo
         vnb1q9DiwWJqZ0JLDhO5JnyoYOaj66nOs/QuCCXWsQzT6SQdDGafXb6nOPaLvp9WFbd5
         95zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720850132; x=1721454932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TJ8lt0WIPJML/L+Gu3zpYCM/DKICydm3DLZEC2BtLFY=;
        b=FmP8aReP8LCN74cd9YqPgUIgVfFHE3n8aGwLLOqWVK5GwS9/MfKqkSPxwbIrhLjERg
         4/ZrHISK5ybRKoaU4WIq7krZ0bRE4f0oMr3CmbxcdEYnXtQVqDQamLad++6rzBZUbtt3
         k76QL2yemmK9uNj8ZfLglc5+rvZP2pBTMQoLCwXj5V1m3hlt/dJ+MWyv96c+iz2wSElk
         rL8xtpOtchaSPobBuWt562PV4R4pdkhl+hQNeUK1sxBeceI3J7EEuQz9MIHpToP74HcB
         qJvh3tbj19HEejuRJ4CpZHyoXEfftmYjK5WktB+pgYzOsKfQB3LFp6MokHnRDEDZha5X
         8Y5A==
X-Forwarded-Encrypted: i=1; AJvYcCVUuHdRIYZGwu0jZeMpk0/qdneUoJonm8PH6NxES/w45cM3uc3HvsptQDD7S3QQyBALYVPvLtoOu8MYj63gakpVqUHPmXW2Y+hrnBwc
X-Gm-Message-State: AOJu0Yw0g9N5P9cR/RMdO/PKd57woWW685oSPf4mPfdJ7S9pAG+Gev9h
	6Pm7/vJ71jnjr2r2WI9sU8bui4zK19ntEbkVS1PNEbZTCMh4CHg6EnJv62vC
X-Google-Smtp-Source: AGHT+IHIGpOuMZbLh4SlGsMLM9NGHFZ017JxrUCmTRcLTgrAKIfbXnMlZNIOjvU18F8Znrn6y84uUQ==
X-Received: by 2002:a2e:3306:0:b0:2ee:8454:1c25 with SMTP id 38308e7fff4ca-2eeb316b020mr105005701fa.34.1720850131922;
        Fri, 12 Jul 2024 22:55:31 -0700 (PDT)
Received: from WBEC325.dom.lan ([2001:470:608f:0:b4ea:33f8:5eca:e7fc])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc7f1ceesm20515666b.126.2024.07.12.22.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 22:55:31 -0700 (PDT)
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
Subject: [PATCH net-next v3 12/12] net: dsa: vsc73xx: start treating the BR_LEARNING flag
Date: Sat, 13 Jul 2024 07:54:40 +0200
Message-Id: <20240713055443.1112925-13-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240713055443.1112925-1-paweldembicki@gmail.com>
References: <20240713055443.1112925-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch implements .port_pre_bridge_flags() and .port_bridge_flags(),
which are required for properly treating the BR_LEARNING flag. Also,
.port_stp_state_set() is tweaked and now disables learning for standalone
ports.

Disabling learning for standalone ports is required to avoid situations
where one port sees traffic originating from another, which could cause
packet drops.

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
---
v3,v2,v1:
  - resend only
---
Before patch series split:
https://patchwork.kernel.org/project/netdevbpf/list/?series=841034&state=%2A&archive=both
v8:
  - resend only
v7:
  - added 'Acked-by' and 'Reviewed-by' and improve  commit message
v6:
  - fix arranging local variables in reverse xmas tree order
v5:
  - introduce patch
---
 drivers/net/dsa/vitesse-vsc73xx-core.c | 41 ++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index 07115a9d1869..193752194b66 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -1613,6 +1613,31 @@ static int vsc73xx_tag_8021q_vlan_del(struct dsa_switch *ds, int port, u16 vid)
 	return vsc73xx_update_vlan_table(vsc, port, vid, false);
 }
 
+static int vsc73xx_port_pre_bridge_flags(struct dsa_switch *ds, int port,
+					 struct switchdev_brport_flags flags,
+					 struct netlink_ext_ack *extack)
+{
+	if (flags.mask & ~BR_LEARNING)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int vsc73xx_port_bridge_flags(struct dsa_switch *ds, int port,
+				     struct switchdev_brport_flags flags,
+				     struct netlink_ext_ack *extack)
+{
+	if (flags.mask & BR_LEARNING) {
+		u32 val = flags.val & BR_LEARNING ? BIT(port) : 0;
+		struct vsc73xx *vsc = ds->priv;
+
+		return vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+					   VSC73XX_LEARNMASK, BIT(port), val);
+	}
+
+	return 0;
+}
+
 static void vsc73xx_refresh_fwd_map(struct dsa_switch *ds, int port, u8 state)
 {
 	struct dsa_port *other_dp, *dp = dsa_to_port(ds, port);
@@ -1673,19 +1698,21 @@ static void vsc73xx_refresh_fwd_map(struct dsa_switch *ds, int port, u8 state)
 static void vsc73xx_port_stp_state_set(struct dsa_switch *ds, int port,
 				       u8 state)
 {
+	struct dsa_port *dp = dsa_to_port(ds, port);
 	struct vsc73xx *vsc = ds->priv;
-	u32 val;
+	u32 val = 0;
+
+	if (state == BR_STATE_LEARNING || state == BR_STATE_FORWARDING)
+		val = dp->learning ? BIT(port) : 0;
+
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+			    VSC73XX_LEARNMASK, BIT(port), val);
 
 	val = (state == BR_STATE_BLOCKING || state == BR_STATE_DISABLED) ?
 	      0 : BIT(port);
 	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
 			    VSC73XX_RECVMASK, BIT(port), val);
 
-	val = (state == BR_STATE_LEARNING || state == BR_STATE_FORWARDING) ?
-	      BIT(port) : 0;
-	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
-			    VSC73XX_LEARNMASK, BIT(port), val);
-
 	/* CPU Port should always forward packets when user ports are forwarding
 	 * so let's configure it from other ports only.
 	 */
@@ -1710,6 +1737,8 @@ static const struct dsa_switch_ops vsc73xx_ds_ops = {
 	.get_sset_count = vsc73xx_get_sset_count,
 	.port_enable = vsc73xx_port_enable,
 	.port_disable = vsc73xx_port_disable,
+	.port_pre_bridge_flags = vsc73xx_port_pre_bridge_flags,
+	.port_bridge_flags = vsc73xx_port_bridge_flags,
 	.port_bridge_join = dsa_tag_8021q_bridge_join,
 	.port_bridge_leave = dsa_tag_8021q_bridge_leave,
 	.port_change_mtu = vsc73xx_change_mtu,
-- 
2.34.1


