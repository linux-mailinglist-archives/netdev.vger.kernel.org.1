Return-Path: <netdev+bounces-105045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1B890F7D5
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 22:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 660981C213BE
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 20:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF8B15F30A;
	Wed, 19 Jun 2024 20:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E17B94io"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2156815B0EC;
	Wed, 19 Jun 2024 20:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718830385; cv=none; b=SYcJ/vmwf1qbpIjbUwv3gk4jxMabTioEnX9rKImoY2I1M0S196wdvhu7qXNp8oya459u5aU+X0Ra97vE3choy/rLImupV5G6UtXMl8MPN4993vVv5Im26Lh83jtjcD9qXtgi08YPIJy9dTvE9LNEXTHcVcoIkhAgjw5MlDRH3YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718830385; c=relaxed/simple;
	bh=sJtzIQgTe5Pm+BZiYMCOpJG5XnNPyMQ0wPr4m1iv3pc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SWuUDXcnUWzARRWE2AkYKYBp5ugV9ZcyQH0XWPSvJ5sJ8PfqB+ItjyKUqLmCl4bjtTIRO59ITr6Z+DT44cOXLolUHSfSoq3t4CB32fUoU9BabGC7DjXfuy3Uq7Ax6POS8+071pI4LoEN90ji/9HOi9zYZYHNHimut2kAxLnTf/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E17B94io; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a6f04afcce1so20137066b.2;
        Wed, 19 Jun 2024 13:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718830382; x=1719435182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PUhnfXU/lrSDxlQiVf/MxDrrUi5BZf6KtwkM+XW/vxM=;
        b=E17B94ioQiyQ7no0dnhVL+kUhClWbDLwUSs9WbbjjXFZXrob3DKpW/N2ZYXwMBfv7A
         nLC6MZYNELvcSoeTAqkIcjJ80u+GMVHeEeXfFDlEudfjS6lYNC65lSPKI/KwnCnG/G4H
         dqx5aNGyezaCxikKz3ENlU5EF8P25rKEU9V+6Asc4Z2yKTuWgxFQ84P0bVM19KUAFHmR
         n32iNec3u2LTZ00I0Nt0r1cMeAte2RPb+WO4+04p5vTSXzwuQ4XTy9uVgK4JwGsLtUqT
         3b27u+Kw7pPlEhsHi3EYHrJtAZNedzXUW9L1Lb/NSsel+2uBJ2MMhtHKbzLnvU/TJ9NG
         WunQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718830382; x=1719435182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PUhnfXU/lrSDxlQiVf/MxDrrUi5BZf6KtwkM+XW/vxM=;
        b=X5GNTWJQa/LH6verB2bvXT72Wf+xFf2xzSmT+JZFtnF9NY37WuN3Ex2r/X8w9grkUz
         2WfxIdN18tW7WoEtAgPJnJ+oJY94Zhx3RrOV9OWGZlQN3ajj/lhznmLeI6NXxj4i/TSz
         YJCY6v+56mkIccPeD50FUVpJOPeIlNVKR8w27oCLuFmvK4S/3a0hC/gnRqXSiaw4oKFL
         EA33bo2oZ2cuzW7URP6npJ7G1T4OizcQ5pPb5vn55H8l+12I0/ezGBBwH9J/hKZvoWj0
         PouflOsCqDPf8Faw4+liP0+bY3XUpiBgaMndMByqiOVdHOOiL73B7UZobSr9ZfzRf5cR
         idbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkcgFJ+jRAj9JLYOwTZK8pqvJTrw608MVtcF6+Ia15hqceCbdj2TykdhnRzl4psO2kGwNgDQeUnEVeSG6GJ+YHWb/CX5xL2TPjy6Fx
X-Gm-Message-State: AOJu0Ywi89y22LxciBl9i56bnPOOQPQZ0izYnoK5EB50D6mbKqFGLAt4
	NVx3pY84ocFmRTrM5DAR3h6g443AZWl205hw8FLzqF2WFfcyBNM1IZeIDGOX6Dw=
X-Google-Smtp-Source: AGHT+IGZT+NixYPPV2tQqA8aXFdFIAUa8VoCGkdmbX0ospApw05LPCLNCfMZqGs7OZKtGxqqa3+PZQ==
X-Received: by 2002:a17:906:4f04:b0:a6f:1b59:e877 with SMTP id a640c23a62f3a-a6fab7d6b9bmr210269766b.75.1718830382145;
        Wed, 19 Jun 2024 13:53:02 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56db5b2fsm697329566b.47.2024.06.19.13.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 13:53:01 -0700 (PDT)
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
Subject: [PATCH net-next v2 08/12] net: dsa: vsc73xx: Implement the tag_8021q VLAN operations
Date: Wed, 19 Jun 2024 22:52:14 +0200
Message-Id: <20240619205220.965844-9-paweldembicki@gmail.com>
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
 drivers/net/dsa/vitesse-vsc73xx-core.c | 62 ++++++++++++++++++++++++--
 2 files changed, 60 insertions(+), 4 deletions(-)

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
index 71a377a0b917..5134a3344324 100644
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
@@ -1525,6 +1536,48 @@ static int vsc73xx_port_vlan_del(struct dsa_switch *ds, int port,
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
+	int ret;
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
+		ret = vsc73xx_vlan_commit_untagged(vsc, port);
+		if (ret)
+			return ret;
+
+		ret = vsc73xx_vlan_commit_pvid(vsc, port);
+		if (ret)
+			return ret;
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
@@ -1628,6 +1681,7 @@ static const struct phylink_mac_ops vsc73xx_phylink_mac_ops = {
 static const struct dsa_switch_ops vsc73xx_ds_ops = {
 	.get_tag_protocol = vsc73xx_get_tag_protocol,
 	.setup = vsc73xx_setup,
+	.teardown = vsc73xx_teardown,
 	.phy_read = vsc73xx_phy_read,
 	.phy_write = vsc73xx_phy_write,
 	.get_strings = vsc73xx_get_strings,
@@ -1643,6 +1697,8 @@ static const struct dsa_switch_ops vsc73xx_ds_ops = {
 	.port_vlan_add = vsc73xx_port_vlan_add,
 	.port_vlan_del = vsc73xx_port_vlan_del,
 	.phylink_get_caps = vsc73xx_phylink_get_caps,
+	.tag_8021q_vlan_add = vsc73xx_tag_8021q_vlan_add,
+	.tag_8021q_vlan_del = vsc73xx_tag_8021q_vlan_del,
 };
 
 static int vsc73xx_gpio_get(struct gpio_chip *chip, unsigned int offset)
-- 
2.34.1


