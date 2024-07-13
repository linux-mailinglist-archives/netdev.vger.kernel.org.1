Return-Path: <netdev+bounces-111276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3306193076B
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 23:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCF6F2828BF
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 21:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA879176258;
	Sat, 13 Jul 2024 21:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ji3P+dJd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09137176228;
	Sat, 13 Jul 2024 21:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720905420; cv=none; b=Eu0bPrko4dxN3rnxDJ+I1rbkkVauxSefgk+nJpN54Dyi93mqZ4daPEbqJtWOtq1rT+lJBr8HD1lCPegrPZ87zgvdkFfI0DMhweXAjL/0X1cVLuCEwrcQ4CiFga0+ioiXF6RN35Gk2NPStw/SdaaGFewiXcKUkerkoQoDBw11yxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720905420; c=relaxed/simple;
	bh=tge0SqcNabLNGajce4yhFbARxLS0gU8sCZZR8FMGwzk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ng83mv5Zm/yW9ihEMs3ga+BTxe/jtTMT+4hClOziOO7NSPbh/bE63aY/JQzjkF0a+yt2fpGphbbPMf/Md1WAtZLyCqiFfvRZ8hOnTfx7FBkLmOjeb2c0VdMBNvtWKj4jWqIjG+21ccp5rMgq7/Wx9RFmXQcIlZpSQEpXXvWfvuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ji3P+dJd; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-58b0beaf703so3822105a12.2;
        Sat, 13 Jul 2024 14:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720905417; x=1721510217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G8TM5AkcZMgcdMwF97vfgOyFfEnllF2s3iVrHesLG/0=;
        b=ji3P+dJdx+19m77HIOre6LT4GuH3FydszHlEErY2w8Qeu2NuE/S7J22yXRDu+8STlK
         x3GcxjrPFK9VJrXpCTephsQMl3uu5Qme6RiOzFYi6aeiw8Pbtf2TC4fYDP+0tIS04UDZ
         L+7jD4LknIlTP2ckYSIbpnZK66jst1+e8Go/FAn2A1/J0bv1xCS5WEvHgiwvoJqg1pVt
         zPsBRbtXo/PMk95QfG+v9aeAXY388454YT77rp7emGcctLAGrQ34djOWqM6oXD5e7a1U
         FVyzNGFT3ZSJnRd3yACrUBEdv65Jj839/Xa7SC7KJrPrKLpwsP0nk8XKaIWqpt7Rswje
         yw/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720905417; x=1721510217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G8TM5AkcZMgcdMwF97vfgOyFfEnllF2s3iVrHesLG/0=;
        b=vUh3h1yJQmS3Qgnde65mcflrz6FTnRRn0enf6yoS5Kilcy/1ZAuYx+1UjF+G+psdXz
         jOJqeIxwAFuM1KIcG1PXdUIcGM1CxHa+DlpR2pEf5AJbU3wudDdl429BmhHN+JunrCr1
         vtiTk1O49pItvNsag/ZkmOhn+WIjcYmQAeyNkIiURTwubfbUW9thCk/T2a97Jy17/Rk0
         KHrzBIiBDUm+d9UV93QK+2FdbO71aLfXNOJOYrq6ByUnhvzcLnkfIwdxSFRn8YtCd6C1
         kWmwDvLZVOWyPr3jwQzOzRJhVXTSfYpU98v8KD1R3YBi+oUdVkaSlsnoPmHgUHKuOT7A
         aglw==
X-Forwarded-Encrypted: i=1; AJvYcCWdgOpI8mGk0PcGHH+Zow68zeyHCqHrtAeczJ197QEoRFaa3ra+CbfK6kCLFO/Gd8Q73cmlDtI4ARhnNmSgg86flCNCf2pgAlYAodR+
X-Gm-Message-State: AOJu0YyMARqGu5fVKzzmdFcXQ6rKpghn0Gq+TkryzTNNsut8R5ZukTeh
	acFQ6n7cwsXu4z/yECzMwtjl9aHUI3XQ0TZO/8As5yEjt5C8Gz0qNuwK3STo
X-Google-Smtp-Source: AGHT+IEU0lspLj5q0KBPlQO2btemY+WpNirYIfUgdsQ/3XWAABJU1JSq13VBgny3PEeHvSY1ogkYrg==
X-Received: by 2002:a05:6402:520d:b0:58e:e2a:1b4b with SMTP id 4fb4d7f45d1cf-594ba98f273mr10353099a12.7.1720905417130;
        Sat, 13 Jul 2024 14:16:57 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b255253b6sm1187286a12.41.2024.07.13.14.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 14:16:56 -0700 (PDT)
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
Subject: [PATCH net-next v4 08/12] net: dsa: vsc73xx: Implement the tag_8021q VLAN operations
Date: Sat, 13 Jul 2024 23:16:14 +0200
Message-Id: <20240713211620.1125910-9-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240713211620.1125910-1-paweldembicki@gmail.com>
References: <20240713211620.1125910-1-paweldembicki@gmail.com>
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
v4:
  - fix 'commit_to_hardware' assigment in 'vsc73xx_tag_8021q_vlan_del'
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
 drivers/net/dsa/vitesse-vsc73xx-core.c | 73 ++++++++++++++++++++++++--
 2 files changed, 71 insertions(+), 4 deletions(-)

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
index 906bbae22861..25c3cd661b30 100644
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
@@ -1549,12 +1560,65 @@ static int vsc73xx_port_vlan_del(struct dsa_switch *ds, int port,
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
+
+	portinfo = &vsc->portinfo[port];
+
+	if (portinfo->pvid_tag_8021q_configured &&
+	    portinfo->pvid_tag_8021q == vid) {
+		struct dsa_port *dp = dsa_to_port(ds, port);
+		bool commit_to_hardware;
+		int err;
+
+		portinfo->pvid_tag_8021q_configured = false;
+
+		commit_to_hardware = vsc73xx_tag_8021q_active(dp);
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
@@ -1644,6 +1708,7 @@ static const struct phylink_mac_ops vsc73xx_phylink_mac_ops = {
 static const struct dsa_switch_ops vsc73xx_ds_ops = {
 	.get_tag_protocol = vsc73xx_get_tag_protocol,
 	.setup = vsc73xx_setup,
+	.teardown = vsc73xx_teardown,
 	.phy_read = vsc73xx_phy_read,
 	.phy_write = vsc73xx_phy_write,
 	.get_strings = vsc73xx_get_strings,
@@ -1658,6 +1723,8 @@ static const struct dsa_switch_ops vsc73xx_ds_ops = {
 	.port_vlan_add = vsc73xx_port_vlan_add,
 	.port_vlan_del = vsc73xx_port_vlan_del,
 	.phylink_get_caps = vsc73xx_phylink_get_caps,
+	.tag_8021q_vlan_add = vsc73xx_tag_8021q_vlan_add,
+	.tag_8021q_vlan_del = vsc73xx_tag_8021q_vlan_del,
 };
 
 static int vsc73xx_gpio_get(struct gpio_chip *chip, unsigned int offset)
-- 
2.34.1


