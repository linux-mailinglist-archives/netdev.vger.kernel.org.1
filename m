Return-Path: <netdev+bounces-111216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E1C9303E1
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 07:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDD5F1C20CBC
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 05:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE39C3A8C0;
	Sat, 13 Jul 2024 05:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oen9mT7Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EDC13213B;
	Sat, 13 Jul 2024 05:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720850122; cv=none; b=pbf7BpLUz/V1gHTvLCRgf38IWhojTgHUOzokfNDEk4pcKNq8/nLW101g5uBAnQ4xwYnT8PNWRbwo0qNtpRYOHlZNVoGRRqWZ10syPeumjzC8CWnE40tZF1A6OizgGDaXTDbGRXq9P/U9FYEfz8y2Vp5b/0AoMKvLEB+4GKtbH1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720850122; c=relaxed/simple;
	bh=o/rCHzh3TsTzS58J1nVqrbuxucT8W6zofidoHk39b/k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GeAA0uFSJkOEyApeQToSCyYz6D6AWqLHvIiFwk+/EgTpsAIwAoogJ34OEEBjT7Ki5D6o03ZKIB19mXIZBuJcKaqC09z9sq7xOYKkqePI+2pr4FJZ1WwdunedoQFLj3rcLomyRbIlOUcpAHvTV8bN+xlCqITOTVZ/zucY4P9+164=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oen9mT7Z; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-58ba3e38028so3490561a12.0;
        Fri, 12 Jul 2024 22:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720850118; x=1721454918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Smj8J5s5NHO9oAwsf7t0gw+QE3FJUlLdGOJ8zQu72pA=;
        b=Oen9mT7Z14HAsEgvzyzL6j3WRic6pHC72IR4LZxSlaGy0XFCqtU6Avy11g70cxp01l
         6rSBa7yEg9qe72HA2g2mhH3HMKxnBKGdfl8HtG6RJT59nkxacZZvnV4ZeR7wTEqyQcdg
         qbYb7GGak/pvvgzKNrKugGFTc3YUj5Zug2P2860fd2R1QMmbOPXA+OZwwJmHGepwpuUB
         CzASob/OFBhuGTF/RgEC18QrMEGZ8KhUJOGmZ2e9JyQolzxoJ3A9bWqKmKhqSzyEl7am
         9w5mVhX/pyl3gkbL8q5td1dp1gjhEZNPDG3aBUI5stUQWpkfi77Aw4eEFZ0skjaaFC/5
         xLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720850118; x=1721454918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Smj8J5s5NHO9oAwsf7t0gw+QE3FJUlLdGOJ8zQu72pA=;
        b=H0BVSbKb4QoC3LxxrmarOe66cHpY6Tgj3DtRldkYJ4TL1uG21g22q67/99Z1nwSO0s
         +SlvoYjtzzDma5SD6OTTgbcCSbNU4AVJyCiuPRrPD6UEWbRIXFo0DBQP/FWvKemvwtFH
         D6vEgPRtzbOYTBtBJj2D7aU/S7Tc93KDi1hCDrrFjvn6s0vMmXvUoxwygMDCAjIz5LYg
         BjUQXJxq6NVbsTEJyhyWE9ldhYAdDko7HmMIJ3bc5NZPue4rrEkNkqsORHe/C2RoYWk2
         hTVLuaa/VEXIlufUv5fRchpbgeL1JiGh9ejCvxVNznsZ969ojdyrhvlz+UxXB0g5gLY0
         drNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTUeTbaVu6qUcDslJL0mzKofFYvsvFQ6GaHxVonAv73qSQVq9R3dT1VjktXWKvfnyWL2ELr+Kl+49iVm2koWzjNuR/MTILfUVx3mt6
X-Gm-Message-State: AOJu0Yx9fzHGlVroYDVxalqj2DIs65m4cZwDcylixwORbRPN+Ezt3vL2
	fTHS+jTmSYMm2sxFxmLDGRbKofSMqw136YJcQEgV1X7qUCTHMme5WPRv8J5G
X-Google-Smtp-Source: AGHT+IF+2rT9s61GDiwbfXXXulSczYSCLc6RBnbOgDV0Vxh7atrS8pjs8zEZXlvp6mdEaymCBDK1Gw==
X-Received: by 2002:a17:907:d8a:b0:a72:7c0d:8fdc with SMTP id a640c23a62f3a-a780b68a311mr1099772066b.14.1720850118221;
        Fri, 12 Jul 2024 22:55:18 -0700 (PDT)
Received: from WBEC325.dom.lan ([2001:470:608f:0:b4ea:33f8:5eca:e7fc])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc7f1ceesm20515666b.126.2024.07.12.22.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 22:55:17 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 08/12] net: dsa: vsc73xx: Implement the tag_8021q VLAN operations
Date: Sat, 13 Jul 2024 07:54:36 +0200
Message-Id: <20240713055443.1112925-9-paweldembicki@gmail.com>
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

This patch is a simple implementation of 802.1q tagging in the vsc73xx
driver. Currently, devices with DSA_TAG_PROTO_NONE are not functional.
The VSC73XX family doesn't provide any tag support for external Ethernet
ports.

The only option available is VLAN-based tagging, which requires constant
hardware VLAN filtering. While the VSC73XX family supports provider
bridging, it only supports QinQ without full implementation of 802.1AD.
This means it only allows the doubled 0x8100 TPID.

In the simple port mode, QinQ is enabled to preserve forwarding of
VLAN-tagged frames.

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v3:
  - added the pvid remove routine to 'vsc73xx_tag_8021q_vlan_del'
  - used 'vsc73xx_vlan_commit_settings' in 'commit_to_hardware' routine
v2:
  - handle raturn values of 'vsc73xx_vlan_commit*' functions
v1:
  - added dsa_tag_8021q_unregister in teardown function
  - moved dsa_tag_8021q_register after vlan database clean operation
---
Before patch series split:
https://patchwork.kernel.org/project/netdevbpf/list/?series=841034&state=%2A&archive=both
v8:
  - resend only
v7:
  - adjust tag8021q implementation for vlan filtering implementation
    changes
v6:
  - resend only
v5:
  - improve commit message
v4:
  - adjust tag8021q implementation for changed untagged vlan storage
  - minor fixes
v3:
  - Split tagger and tag implementation into separate commits
---
 drivers/net/dsa/Kconfig                |  2 +-
 drivers/net/dsa/vitesse-vsc73xx-core.c | 70 ++++++++++++++++++++++++--
 2 files changed, 68 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
index 8508b5145bc1..2d10b4d6cfbb 100644
--- a/drivers/net/dsa/Kconfig
+++ b/drivers/net/dsa/Kconfig
@@ -127,7 +127,7 @@ config NET_DSA_SMSC_LAN9303_MDIO
 
 config NET_DSA_VITESSE_VSC73XX
 	tristate
-	select NET_DSA_TAG_NONE
+	select NET_DSA_TAG_VSC73XX_8021Q
 	select FIXED_PHY
 	select VITESSE_PHY
 	select GPIOLIB
diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index 57a6f34805bd..71be5acb291b 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -597,7 +597,7 @@ static enum dsa_tag_protocol vsc73xx_get_tag_protocol(struct dsa_switch *ds,
 	 * cannot access the tag. (See "Internal frame header" section
 	 * 3.9.1 in the manual.)
 	 */
-	return DSA_TAG_PROTO_NONE;
+	return DSA_TAG_PROTO_VSC73XX_8021Q;
 }
 
 static int vsc73xx_wait_for_vlan_table_cmd(struct vsc73xx *vsc)
@@ -687,7 +687,7 @@ vsc73xx_update_vlan_table(struct vsc73xx *vsc, int port, u16 vid, bool set)
 static int vsc73xx_setup(struct dsa_switch *ds)
 {
 	struct vsc73xx *vsc = ds->priv;
-	int i;
+	int i, ret;
 
 	dev_info(vsc->dev, "set up the switch\n");
 
@@ -768,7 +768,18 @@ static int vsc73xx_setup(struct dsa_switch *ds)
 
 	INIT_LIST_HEAD(&vsc->vlans);
 
-	return 0;
+	rtnl_lock();
+	ret = dsa_tag_8021q_register(ds, htons(ETH_P_8021Q));
+	rtnl_unlock();
+
+	return ret;
+}
+
+static void vsc73xx_teardown(struct dsa_switch *ds)
+{
+	rtnl_lock();
+	dsa_tag_8021q_unregister(ds);
+	rtnl_unlock();
 }
 
 static void vsc73xx_init_port(struct vsc73xx *vsc, int port)
@@ -1543,12 +1554,62 @@ static int vsc73xx_port_vlan_del(struct dsa_switch *ds, int port,
 		vsc73xx_bridge_vlan_remove_port(vsc73xx_vlan, port);
 
 	commit_to_hardware = !vsc73xx_tag_8021q_active(dsa_to_port(ds, port));
+
 	if (commit_to_hardware)
 		return vsc73xx_vlan_commit_settings(vsc, port);
 
 	return 0;
 }
 
+static int vsc73xx_tag_8021q_vlan_add(struct dsa_switch *ds, int port, u16 vid,
+				      u16 flags)
+{
+	bool pvid = flags & BRIDGE_VLAN_INFO_PVID;
+	struct vsc73xx_portinfo *portinfo;
+	struct vsc73xx *vsc = ds->priv;
+	bool commit_to_hardware;
+	int ret;
+
+	portinfo = &vsc->portinfo[port];
+
+	if (pvid) {
+		portinfo->pvid_tag_8021q_configured = true;
+		portinfo->pvid_tag_8021q = vid;
+	}
+
+	commit_to_hardware = vsc73xx_tag_8021q_active(dsa_to_port(ds, port));
+	if (commit_to_hardware) {
+		ret = vsc73xx_vlan_commit_settings(vsc, port);
+		if (ret)
+			return ret;
+	}
+
+	return vsc73xx_update_vlan_table(vsc, port, vid, true);
+}
+
+static int vsc73xx_tag_8021q_vlan_del(struct dsa_switch *ds, int port, u16 vid)
+{
+	struct vsc73xx_portinfo *portinfo;
+	struct vsc73xx *vsc = ds->priv;
+	bool commit_to_hardware;
+	int err;
+
+	portinfo = &vsc->portinfo[port];
+
+	if (portinfo->pvid_tag_8021q_configured &&
+	    portinfo->pvid_tag_8021q == vid) {
+		portinfo->pvid_tag_8021q_configured = false;
+
+		if (commit_to_hardware) {
+			err = vsc73xx_vlan_commit_settings(vsc, port);
+			if (err)
+				return err;
+		}
+	}
+
+	return vsc73xx_update_vlan_table(vsc, port, vid, false);
+}
+
 static void vsc73xx_refresh_fwd_map(struct dsa_switch *ds, int port, u8 state)
 {
 	struct dsa_port *other_dp, *dp = dsa_to_port(ds, port);
@@ -1638,6 +1699,7 @@ static const struct phylink_mac_ops vsc73xx_phylink_mac_ops = {
 static const struct dsa_switch_ops vsc73xx_ds_ops = {
 	.get_tag_protocol = vsc73xx_get_tag_protocol,
 	.setup = vsc73xx_setup,
+	.teardown = vsc73xx_teardown,
 	.phy_read = vsc73xx_phy_read,
 	.phy_write = vsc73xx_phy_write,
 	.get_strings = vsc73xx_get_strings,
@@ -1652,6 +1714,8 @@ static const struct dsa_switch_ops vsc73xx_ds_ops = {
 	.port_vlan_add = vsc73xx_port_vlan_add,
 	.port_vlan_del = vsc73xx_port_vlan_del,
 	.phylink_get_caps = vsc73xx_phylink_get_caps,
+	.tag_8021q_vlan_add = vsc73xx_tag_8021q_vlan_add,
+	.tag_8021q_vlan_del = vsc73xx_tag_8021q_vlan_del,
 };
 
 static int vsc73xx_gpio_get(struct gpio_chip *chip, unsigned int offset)
-- 
2.34.1


