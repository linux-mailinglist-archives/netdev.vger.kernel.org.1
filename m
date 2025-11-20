Return-Path: <netdev+bounces-240538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E88BEC76204
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 20:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 9EE2F28CA4
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 19:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322053019A3;
	Thu, 20 Nov 2025 19:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ko6uKONu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB082D6E6B
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 19:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763668264; cv=none; b=LkbF+/X82+Afy0o8R9vnL937ESUgDn+JXyOcHBd+Fj2ekaPxVMkQSNsk1w5mXN8eyrzSCKbiX/3Dbyyrrvtzwq7og4iB2yCKDIKnKBwf1oAK/wvUHBleUUmz5pm5opdbJscP6EqFXlYd0AG6UWzIjMKUbcMX9GiIQrc4z9Mqp58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763668264; c=relaxed/simple;
	bh=AC3XIuUJXRJWedH3cQ7AriKmum/CB3i3Hw86x/suSDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j2AcJIdlQX/7FuinV2BtWWnEeHK6fISMJZhmlcJgvoKMunCyRMhSCVqiC7OoF7OjB1i191NiWajz1jiXgvfI1rpQyYFdq/VoIxHtibiPMYHiU5yiB6lCQpFkSBd3ra+hj7funSE2AZxeUVNhGiKlv0OvrrbtVh/r/Zu3zgL7Adk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ko6uKONu; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47796a837c7so8569975e9.0
        for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 11:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763668261; x=1764273061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kppobf+HfqrnKfgCmTsw8ifBKt7BpqlOrevM3P0J6K8=;
        b=ko6uKONub60tYodmmkaH0Wb/cxYILfufXUXeBacK7QCrM2Wi9HsVSX476i9GVsWW/L
         XgnpE8jjvWAN2MYPxhsi0/7RXla85GbOmNn9UkoP7EA+IpALyrKRsFWpN8mWuZR9mYaV
         4bElan2WGUrbFgZYtWNV9Qu+yyjNSjyACD0L3HT6p4Z1Myyd/BxZRBzDKJe3fdazw1+8
         0B+uAq6KA6wxFz5XkY6lmp2ASSmqY7K9lKpyrgKEE4nlM55+K1VxGNOaKbwkQe/PPb8K
         9DsVioQUBF1VtulcLKUskDyAytucFNpUnpBvSpcrgdo47Qp/RVxwX8KShrRKwupWasJU
         qS3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763668261; x=1764273061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kppobf+HfqrnKfgCmTsw8ifBKt7BpqlOrevM3P0J6K8=;
        b=JbxA/9Hmh5SuN6uwKRU65IngCSgo42HgrRtqnuxomriJdbFMvz8N4iGye8A+ScqGq2
         VUTLr+1OYRc+O2wZIQqj8nstjJSfWWFPmjxWHklI+ptT3mPHxKcOErjtWihAZbXOD/Ms
         i7DKosQZoC4D68EOUpAvtJJv7XhWyxGRUemTiKuwF3C7hapmMkPl/ANlmA3xwtQOKbPN
         DjVN8OK8n1I1wPeebfZqLwg4FZZOVAjJOUcyYoLTHacXWa9xirjsSqxdzSiAMJBXz911
         BL9skNjAplsGvGMzbG7M4zSQ8F3DUtAVTS0zUwHdlydkVw5SAr4h1UOTF6irgZ2ypdEn
         N2UQ==
X-Gm-Message-State: AOJu0YxH6wFz/jdkJjkKo4SmashfhDcZUWhT6Pah1CEHxBk08szCzonE
	SJ/ke9aquAKwsh62o6rJXurnBYWlX/3Q1RHhP0cz65mptWOGOsC9U9P7
X-Gm-Gg: ASbGnctMs7RuYme+HzA1SxmWTaBgPTzY1fyam/r5t3ZSqnxU9z4gVjr494wuJs2yOs/
	vmnNDE1MpaVl8/3CRNBbdmwMVTyFr7PrQIVZ7ChFsuLn+51jQw0J/eR63eqsSi+3J+bArmfbN6W
	LEkbTYX1CSaGYTafdlV85R/EnAyAgS/W/N4nYjKVd7BGeRwCva63BJtC4duGazue1aY6UynmVB5
	/CdorAwI8vslHi8MOWa1NCP8KCpoAbBSyeNqMNY0Q+q2O10NnXHUgANlvYYbmrGRQWnUGjuEu5H
	kuNVGMwNNoy3teQqLXWOr7penbn2wT/+TQWNVzYOq02NmyZdncZQ7k5BjHthRK7sTs0ebSAHU/J
	bOFeaey+O8cODVVx9Q/T3HhAewvWG0ovS9H8ysYCJcnSJlfFV2XxUM/aPOWyGFhhky5fro9Lji9
	790uMZnxgS9pqtVI5ygilrwIzxMG6SnQ==
X-Google-Smtp-Source: AGHT+IENBLk0dQNZRsMkCQ2uReAjBiprjlbsAn/Xo5XqqTbFie50c0omTcUmw7Kww3d4abSbhugR4Q==
X-Received: by 2002:a05:600c:458e:b0:46e:396b:f5ae with SMTP id 5b1f17b1804b1-477bac0cfb5mr40650755e9.16.1763668260113;
        Thu, 20 Nov 2025 11:51:00 -0800 (PST)
Received: from localhost.localdomain ([37.228.206.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9739964sm73324225e9.1.2025.11.20.11.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 11:50:59 -0800 (PST)
From: Fabio Baltieri <fabio.baltieri@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>,
	nic_swsd@realtek.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Michael Zimmermann <sigmaepsilon92@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fabio Baltieri <fabio.baltieri@gmail.com>
Subject: [PATCH v2] r8169: add support for RTL8127ATF
Date: Thu, 20 Nov 2025 19:50:55 +0000
Message-ID: <20251120195055.3127-1-fabio.baltieri@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for ATF variant of the RTL8127, this uses an SFP transceiver
instead of the twisted pair one and only runs at 1Gbps or 10Gbps, only
10Gbps is supported with this patch.

The change is based on the r8127 driver package version 11.015.00
available on the Realtek website and also on
https://github.com/openwrt/rtl8127.

There's no public datasheet for the chip so this is just porting over
the original vendor code to the API and style of the upstream one.

Signed-off-by: Fabio Baltieri <fabio.baltieri@gmail.com>
---

Hi, did more tests with 1g mode on the v1 of this patch, the setting
itself works but triggering it from ethtool reliably seems problematic
due to some weird behavior of the phy code which end up reporting a
specific link speed when the link is down, making it impossible to set
it with ethool as it thinks it's already set.

Since it seems like supporting 1g properly needs expanding the scope of
the patch, I'm taking the suggestion from Heiner in v1 review and
stripped this down so it only supports 10g, which is likely what the
vast majority of the users need anyway.

Also tested this on suspend/resume, this is also affected by the wol
issue but with that bit set it now works correctly.

v1 -> v2
- stripped out 1g support
- moved the sds settings in rtl8169_init_phy() so it get called on
  resume
- renamed fiber_mode to sfp_mode to avoid confusion

Cheers,
Fabio

 drivers/net/ethernet/realtek/r8169_main.c | 128 +++++++++++++++++++++-
 1 file changed, 126 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index d18734fe12e..e19518c7b98 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -729,6 +729,7 @@ struct rtl8169_private {
 	unsigned supports_gmii:1;
 	unsigned aspm_manageable:1;
 	unsigned dash_enabled:1;
+	unsigned sfp_mode:1;
 	dma_addr_t counters_phys_addr;
 	struct rtl8169_counters *counters;
 	struct rtl8169_tc_offsets tc_offset;
@@ -842,7 +843,8 @@ static bool rtl_supports_eee(struct rtl8169_private *tp)
 {
 	return tp->mac_version >= RTL_GIGA_MAC_VER_34 &&
 	       tp->mac_version != RTL_GIGA_MAC_VER_37 &&
-	       tp->mac_version != RTL_GIGA_MAC_VER_39;
+	       tp->mac_version != RTL_GIGA_MAC_VER_39 &&
+	       !tp->sfp_mode;
 }
 
 static void rtl_read_mac_from_reg(struct rtl8169_private *tp, u8 *mac, int reg)
@@ -1399,6 +1401,95 @@ DECLARE_RTL_COND(rtl_ocp_tx_cond)
 	return RTL_R8(tp, IBISR0) & 0x20;
 }
 
+#define R8127_SDS_CMD 0x2348
+#define R8127_SDS_ADDR 0x234a
+#define R8127_SDS_DATA_IN 0x234c
+#define R8127_SDS_DATA_OUT 0x234e
+
+#define R8127_MAKE_SDS_ADDR(_index, _page, _reg) \
+	(((_index) << 11) | ((_page) << 5) | (_reg))
+
+#define R8127_SDS_CMD_IN BIT(0)
+#define R8127_SDS_WE_IN BIT(1)
+
+DECLARE_RTL_COND(rtl_sds_cmd_done)
+{
+	return RTL_R16(tp, R8127_SDS_CMD) & R8127_SDS_CMD_IN;
+}
+
+static u16 rtl8127_sds_phy_read(struct rtl8169_private *tp,
+				u16 index, u16 page, u16 reg)
+{
+	RTL_W16(tp, R8127_SDS_ADDR, R8127_MAKE_SDS_ADDR(index, page, reg));
+	RTL_W16(tp, R8127_SDS_CMD, R8127_SDS_CMD_IN);
+
+	if (rtl_loop_wait_low(tp, &rtl_sds_cmd_done, 1, 100))
+		return RTL_R16(tp, R8127_SDS_DATA_OUT);
+	else
+		return 0xffff;
+}
+
+static void rtl8127_sds_phy_write(struct rtl8169_private *tp,
+				  u16 index, u16 page, u16 reg, u16 val)
+{
+	RTL_W16(tp, R8127_SDS_DATA_IN, val);
+	RTL_W16(tp, R8127_SDS_ADDR, R8127_MAKE_SDS_ADDR(index, page, reg));
+	RTL_W16(tp, R8127_SDS_CMD, R8127_SDS_CMD_IN | R8127_SDS_WE_IN);
+
+	rtl_loop_wait_low(tp, &rtl_sds_cmd_done, 1, 100);
+}
+
+static void rtl8127_sds_phy_modify(struct rtl8169_private *tp,
+				   u16 index, u16 page, u16 addr,
+				   u16 mask, u16 set)
+{
+	u16 val;
+
+	val = rtl8127_sds_phy_read(tp, index, page, addr);
+	val = (val & ~mask) | set;
+	rtl8127_sds_phy_write(tp, index, page, addr, val);
+}
+
+static void rtl8127_sds_phy_reset(struct rtl8169_private *tp)
+{
+	RTL_W8(tp, 0x2350, RTL_R8(tp, 0x2350) & ~BIT(0));
+	udelay(1);
+
+	RTL_W16(tp, 0x233a, 0x801f);
+	RTL_W8(tp, 0x2350, RTL_R8(tp, 0x2350) | BIT(0));
+	udelay(10);
+}
+
+static void rtl8127_sds_phy_exit_1g(struct rtl8169_private *tp)
+{
+	rtl8127_sds_phy_modify(tp, 0, 1, 31, BIT(3), 0);
+	rtl8127_sds_phy_modify(tp, 0, 2, 0,
+			       BIT(13) | BIT(12) | BIT(6),
+			       BIT(6));
+
+	rtl8127_sds_phy_reset(tp);
+}
+
+static void rtl8127_set_sds_phy_caps_10g(struct rtl8169_private *tp)
+{
+	u16 val;
+
+	RTL_W16(tp, 0x233a, 0x801a);
+
+	val = RTL_R16(tp, 0x233e);
+	val &= BIT(13) | BIT(12) | BIT(1) | BIT(0);
+	val |= BIT(12);
+	RTL_W16(tp, 0x233e, val);
+
+	r8169_mdio_write(tp, 0xc40a, 0x0);
+	r8169_mdio_write(tp, 0xc466, 0x3);
+	r8169_mdio_write(tp, 0xc808, 0x0);
+	r8169_mdio_write(tp, 0xc80a, 0x0);
+
+	val = r8168_phy_ocp_read(tp, 0xc804);
+	r8168_phy_ocp_write(tp, 0xc804, (val & ~0x000f) | 0x000c);
+}
+
 static void rtl8168ep_stop_cmac(struct rtl8169_private *tp)
 {
 	RTL_W8(tp, IBCR2, RTL_R8(tp, IBCR2) & ~0x01);
@@ -1512,6 +1603,15 @@ static enum rtl_dash_type rtl_get_dash_type(struct rtl8169_private *tp)
 	}
 }
 
+static bool rtl_sfp_mode(struct rtl8169_private *tp)
+{
+	if (tp->mac_version == RTL_GIGA_MAC_VER_80 &&
+	    (r8168_mac_ocp_read(tp, 0xd006) & 0xff) == 0x07)
+		return true;
+
+	return false;
+}
+
 static void rtl_set_d3_pll_down(struct rtl8169_private *tp, bool enable)
 {
 	if (tp->mac_version >= RTL_GIGA_MAC_VER_25 &&
@@ -2390,7 +2490,10 @@ static void rtl8125a_config_eee_mac(struct rtl8169_private *tp)
 
 static void rtl8125b_config_eee_mac(struct rtl8169_private *tp)
 {
-	r8168_mac_ocp_modify(tp, 0xe040, 0, BIT(1) | BIT(0));
+	if (tp->sfp_mode)
+		r8168_mac_ocp_modify(tp, 0xe040, BIT(1) | BIT(0), 0);
+	else
+		r8168_mac_ocp_modify(tp, 0xe040, 0, BIT(1) | BIT(0));
 }
 
 static void rtl_rar_exgmac_set(struct rtl8169_private *tp, const u8 *addr)
@@ -2440,6 +2543,25 @@ static void rtl8169_init_phy(struct rtl8169_private *tp)
 	    tp->pci_dev->subsystem_device == 0xe000)
 		phy_write_paged(tp->phydev, 0x0001, 0x10, 0xf01b);
 
+	if (tp->sfp_mode) {
+		rtl8127_sds_phy_exit_1g(tp);
+		rtl8127_set_sds_phy_caps_10g(tp);
+
+		phy_remove_link_mode(tp->phydev, ETHTOOL_LINK_MODE_10baseT_Half_BIT);
+		phy_remove_link_mode(tp->phydev, ETHTOOL_LINK_MODE_10baseT_Full_BIT);
+		phy_remove_link_mode(tp->phydev, ETHTOOL_LINK_MODE_100baseT_Half_BIT);
+		phy_remove_link_mode(tp->phydev, ETHTOOL_LINK_MODE_100baseT_Full_BIT);
+		phy_remove_link_mode(tp->phydev, ETHTOOL_LINK_MODE_1000baseT_Full_BIT);
+		phy_remove_link_mode(tp->phydev, ETHTOOL_LINK_MODE_2500baseT_Full_BIT);
+		phy_remove_link_mode(tp->phydev, ETHTOOL_LINK_MODE_5000baseT_Full_BIT);
+
+		phy_remove_link_mode(tp->phydev, ETHTOOL_LINK_MODE_Autoneg_BIT);
+		phy_remove_link_mode(tp->phydev, ETHTOOL_LINK_MODE_Pause_BIT);
+		phy_remove_link_mode(tp->phydev, ETHTOOL_LINK_MODE_Asym_Pause_BIT);
+
+		tp->phydev->autoneg = 0;
+	}
+
 	/* We may have called phy_speed_down before */
 	phy_speed_up(tp->phydev);
 
@@ -5453,6 +5575,8 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	tp->dash_type = rtl_get_dash_type(tp);
 	tp->dash_enabled = rtl_dash_is_enabled(tp);
 
+	tp->sfp_mode = rtl_sfp_mode(tp);
+
 	tp->cp_cmd = RTL_R16(tp, CPlusCmd) & CPCMD_MASK;
 
 	if (sizeof(dma_addr_t) > 4 && tp->mac_version >= RTL_GIGA_MAC_VER_18 &&
-- 
2.47.3


