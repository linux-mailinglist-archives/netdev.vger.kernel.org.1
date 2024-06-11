Return-Path: <netdev+bounces-102697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D93990454D
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 21:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51C3E1C24898
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 19:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B908E156885;
	Tue, 11 Jun 2024 19:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHIYH+fO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB395156679;
	Tue, 11 Jun 2024 19:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718135486; cv=none; b=KPkN6bKyJwmJn3l0eTQCWIXZItlMBy6pVmc2mWQauP1HKDIHydDVempTnZ9GcG1cOsVlFooFqFccMx/ugMg8MYHzNvJXwcBSJUpFvTdfBvm0Dj3NCKqoCkRqf6f9jpiRVUNT74KZWRLmJQctfWWPzLy1iuLw82zpSPa08Zivu0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718135486; c=relaxed/simple;
	bh=2x/TeQyPN06DQxpdVXcwuP7TaDQZwqmbyTlMAl16rqU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XKEN908zr1RRePD9fi413yVcpJ4qPzWSJRzPp0QzliV1KFWbfYt/F5+6Pbr1oX/2ostHXbYrLmR4P2edMiYEjbbEtE6FuJDUwgGnH4Ff+k30mTlR1bw/2Ra4Lef/Hh+9zGJdL+vZeTcIhAWOnSfRZqOpn+228QvXNf4ZE96Kls4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SHIYH+fO; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ebed33cbaeso16560441fa.1;
        Tue, 11 Jun 2024 12:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718135483; x=1718740283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7lXnGQzCsTNRuKgirCpeRx91mu5ywCx4lqyrJRq5Um8=;
        b=SHIYH+fOdZFhl4qr4uZ2e4fE/BZ7SnYYSZzKBWafZXpcUQ/0zQmt4x84M+gWpkBfoH
         W0VH4pHo77AmmVUBSUnLbBuxhXOrGQP1N4Ce5zncO031NaHptp+RGE6hx7J6k2xnmu5j
         BrJImRozSVc+z4HJW5J3SL7Jo6zYHaiJNuhhQfd1USbRE8fKY4qbX74bPPh9Nr76Kt6A
         gD4LAPDk1hCnVFp9h0cHHfb3xVYczNP5gAl81xmkK79fp/Hx7DeFMWmdncqDSNraa+rE
         mOYHD2RLiUxs6jNoYLKDfNHDVqFLPdhO+A4DqNiSQhyga281mb8ej//4te+G5RPT1ZFE
         D2ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718135483; x=1718740283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7lXnGQzCsTNRuKgirCpeRx91mu5ywCx4lqyrJRq5Um8=;
        b=TqdXz2CP0TS7eQg6lAq8LYRjnn5tjtFu8gQ/OrUVPd5BxSO7gIOftLFegwD+1wOGP5
         bvQdYhHDSChJMIl++R+uYvRPAUUAnYesmZ25w10MxcZpqvAtbWf17nhjNoso6H6fg0mQ
         Q60ZoiRF055k03mo2fZg9aGZ3Eu/H71VEi1ivsW9mskTKLOUisS1drIhkidYRWwgSJ16
         bPwS/dA+3VzNruFEZncDFVq1VvYPgvWZwuLi4gtHk4JHXwx229SMbHenCv5WxKueIFP+
         6g51xi7EaSkbsSu7zezTKEhkNp8eOfEf1p9YWZEpEP6etcfB/LDMsr7N8tcVt6+AogqR
         L2Pw==
X-Forwarded-Encrypted: i=1; AJvYcCVQQw19im7jayQb7+2/dDwaKLd1Er+cjw8VDqdCzE2U7p4gLHYGe3pacTiWw0BUL2JEIfbIIPUshZWpTzzl3xo81DAg8Jli/lISyxfp
X-Gm-Message-State: AOJu0YxyhTg2Uiacqr7GWxeIOBV1f43Nb02eqpyJe0bvlPhaDpEvfI8K
	yZGeENm6JKetUGhZRMqltdzjEeo+4I2bfEXAAJEEQMVwKy6Hhv+SFvNsbWTnQLg=
X-Google-Smtp-Source: AGHT+IHATGLqR54VpVvNCv1vH/FBEheSgLlze+LZn3798kA3FcHJN9hUVqMi3mx7lECYgzmF6KKHTw==
X-Received: by 2002:a2e:a7c8:0:b0:2eb:e505:ebd5 with SMTP id 38308e7fff4ca-2ebe505ee5emr54597161fa.3.1718135482761;
        Tue, 11 Jun 2024 12:51:22 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57c7650b371sm5286737a12.76.2024.06.11.12.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 12:51:22 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Pawel Dembicki <paweldembicki@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 08/12] net: dsa: vsc73xx: Implement the tag_8021q VLAN operations
Date: Tue, 11 Jun 2024 21:50:00 +0200
Message-Id: <20240611195007.486919-9-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240611195007.486919-1-paweldembicki@gmail.com>
References: <20240611195007.486919-1-paweldembicki@gmail.com>
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

 drivers/net/dsa/Kconfig                |  2 +-
 drivers/net/dsa/vitesse-vsc73xx-core.c | 56 ++++++++++++++++++++++++--
 2 files changed, 54 insertions(+), 4 deletions(-)

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
index 782eddcb1169..86b88743890b 100644
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
@@ -1488,6 +1499,42 @@ static int vsc73xx_port_vlan_del(struct dsa_switch *ds, int port,
 	return 0;
 }
 
+static int vsc73xx_tag_8021q_vlan_add(struct dsa_switch *ds, int port, u16 vid,
+				      u16 flags)
+{
+	bool untagged = flags & BRIDGE_VLAN_INFO_UNTAGGED;
+	bool pvid = flags & BRIDGE_VLAN_INFO_PVID;
+	struct vsc73xx_portinfo *portinfo;
+	struct vsc73xx *vsc = ds->priv;
+	bool commit_to_hardware;
+
+	portinfo = &vsc->portinfo[port];
+
+	if (untagged) {
+		portinfo->untagged_tag_8021q_configured = true;
+		portinfo->untagged_tag_8021q = vid;
+	}
+	if (pvid) {
+		portinfo->pvid_tag_8021q_configured = true;
+		portinfo->pvid_tag_8021q = vid;
+	}
+
+	commit_to_hardware = vsc73xx_tag_8021q_active(dsa_to_port(ds, port));
+	if (commit_to_hardware) {
+		vsc73xx_vlan_commit_untagged(vsc, port);
+		vsc73xx_vlan_commit_pvid(vsc, port);
+	}
+
+	return vsc73xx_update_vlan_table(vsc, port, vid, true);
+}
+
+static int vsc73xx_tag_8021q_vlan_del(struct dsa_switch *ds, int port, u16 vid)
+{
+	struct vsc73xx *vsc = ds->priv;
+
+	return vsc73xx_update_vlan_table(vsc, port, vid, false);
+}
+
 static int vsc73xx_port_setup(struct dsa_switch *ds, int port)
 {
 	struct vsc73xx_portinfo *portinfo;
@@ -1595,6 +1642,7 @@ static const struct phylink_mac_ops vsc73xx_phylink_mac_ops = {
 static const struct dsa_switch_ops vsc73xx_ds_ops = {
 	.get_tag_protocol = vsc73xx_get_tag_protocol,
 	.setup = vsc73xx_setup,
+	.teardown = vsc73xx_teardown,
 	.phy_read = vsc73xx_phy_read,
 	.phy_write = vsc73xx_phy_write,
 	.get_strings = vsc73xx_get_strings,
@@ -1610,6 +1658,8 @@ static const struct dsa_switch_ops vsc73xx_ds_ops = {
 	.port_vlan_add = vsc73xx_port_vlan_add,
 	.port_vlan_del = vsc73xx_port_vlan_del,
 	.phylink_get_caps = vsc73xx_phylink_get_caps,
+	.tag_8021q_vlan_add = vsc73xx_tag_8021q_vlan_add,
+	.tag_8021q_vlan_del = vsc73xx_tag_8021q_vlan_del,
 };
 
 static int vsc73xx_gpio_get(struct gpio_chip *chip, unsigned int offset)
-- 
2.34.1


