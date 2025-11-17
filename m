Return-Path: <netdev+bounces-239220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D57C4C65EC1
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 20:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 57192293EC
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 19:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFA0332EAB;
	Mon, 17 Nov 2025 19:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0QZ2KUV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC79B32ED5D
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 19:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763407024; cv=none; b=qN6okiKsIWD9c72V7hkXTCI0Vdn+fD3w7EGuYkzFuerjO5khf9JBYTYB17F79o0XPS5/Num5ojJ9Gdp8SYp4EUOdWxcktlxQB6imwP1IfmhvoBFzIb4pg+rzM5MpDpUPRioMRjMLk0aIzaB++h34xU7O1o+PpHuA+6DKGn0v6/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763407024; c=relaxed/simple;
	bh=/hHa5zPRvz+I/woa1hdHm8HUtts0R0kUp9bHSnw48qQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ojxVT0+ttLugJ0qnxH6n81BRyaYfOvPpll+J1q6jKALGYizqoNyiYeSn29xTcwg3ol2Pa+SyMbEGFzbpepfYhcgkaLdOzt4kSMcFEgpv6VUnSvvLa70GMSGGKaoVlN4+B2JG4CAiX8NrDL2hcyZWv4c/66KlXyHrb4Usdfp4jdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L0QZ2KUV; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-477a219dbcaso12932675e9.3
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 11:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763407021; x=1764011821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xo1ELbvL44Csa9yw65dnwItj9j4+8K4ql2BpDTVf2NI=;
        b=L0QZ2KUVDu2NWLXd4HrZKkX9exOmaUNJOL0glopD4pSP3rh0GdPFnoo3PtGNmzR4T1
         bY6wj/lsdyZeA8cikZeTn/fhvxgNwt+ZbNYcdKdCpt4KhmiRLO5LwV6+pVdVhw8ihdES
         9Mqbdiw8sMxTamyFzKLS1koxPMn05X4+wrlKzzidWcIMXjV7+sG7gAvEo2rJMSMhy4Xj
         xM3LHcluSGgfHVYipTOg+MbM8dSDkXAIcs5pZdGJn9QTwJCz/KAVtFHBizqU3Jfx3qBH
         xCeVZ/dmE/R4B9IP3pxyHcXYwsbPVcU1KneelerPmDrQre0cDX45q/vfw9CYFmJg/1RR
         BNqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763407021; x=1764011821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xo1ELbvL44Csa9yw65dnwItj9j4+8K4ql2BpDTVf2NI=;
        b=B6G9X1QHLVMlO9C0gJdXSXkFzeOvLQHhfhtGe9dGvGziTXx3XETxeH6Wb1CZv/i/bK
         9q+bVueC0HH3JGt/BiFqlIHg3GQJh9ZC4A9TwXoeiuxNwa7d2R7M3B4faLhevqrgNklW
         0ubR+Rl/EPtygpWTxLSSS+GhmRfMeKhN9oN3f/ykGGgrKPrR9HcMkUJrLCPaMzCc0gvv
         uoCuaf6hQ7MA4aWhjFweaAF4K2YvjgWUDUgAO8MLjWm7Dux0AIY1ymv6+VwOX3SNdUTy
         36voYtoWIDAuXzKEmL9RrHpvFEsobOH5utHAks6kdq8w6/e5wAkJ73c5hUKmLbC/1ICH
         DUtQ==
X-Gm-Message-State: AOJu0YxZxnKI7pCs+sGQeJAuBuYv4/0KmG2ILdK5I+KYoEHRkRVzyh4I
	0SmJ+5fywB4Wm7yuDv7/Ey5o8y5YIs88um0q9HoL/dDW7ICCW2Wwbvzx
X-Gm-Gg: ASbGnctV7KCDTuros7m4sRG66e+YExifBBiTCbk+wxgLiRu3lfTQZO1w+QYexMUuCBt
	QTr6Zv1hzEOv+oNJXqre11BRVvHXd6YXyD51OZHv/mDzwj102xx0somD8Y+A5j28O81reySUcAy
	V5TbHoHdt72dR2r+ui+R3CIHeSq/cio6iRJXLe1Ph5zMuRvnpcklFUbBcVZQRMhbNuT+3G66BHK
	loeCur19zBp6dis5wYtvSID4SV+F+IjoO8lhZ7jM/eRWYPIOuGTkD1aDH/3ngqSpd1x1MjxCCRM
	+qels1Sr//42JHtW3lmfkB7bILSLJvUnfy/MX/bX3blHm0r5v+Mc8ZMLeMAs31+T0e3iHFdD7vg
	l+Sj0qKQ5nQo2Mn1SHyIj1UA1MPA40cPAIDjBhWlnvb/KnMqPwK1RuGKcf3oCAWg24zvmY0KFmi
	bA6QZxSJ/ekjkLmtIManvZ1jqeX0Dj1LBCJ2k+Zwye
X-Google-Smtp-Source: AGHT+IFzUA08jkIlszt70iNbTyohk9Q0kYbN/q/wKmModoWntIWg0lzwGx1pWB6z8ka24fIRO9In3Q==
X-Received: by 2002:a05:600c:4685:b0:477:8b77:1573 with SMTP id 5b1f17b1804b1-4778fe5e88emr127724555e9.14.1763407020634;
        Mon, 17 Nov 2025 11:17:00 -0800 (PST)
Received: from localhost.localdomain ([37.228.206.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477975022ecsm161218075e9.4.2025.11.17.11.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 11:16:59 -0800 (PST)
From: Fabio Baltieri <fabio.baltieri@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>,
	nic_swsd@realtek.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fabio Baltieri <fabio.baltieri@gmail.com>
Subject: [PATCH] r8169: add support for RTL8127ATF
Date: Mon, 17 Nov 2025 19:16:57 +0000
Message-ID: <20251117191657.4106-1-fabio.baltieri@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for ATF variant of the RTL8127, this uses an SFP transceiver
instead of the twisted pair one and only runs at 1Gbps or 10Gbps.

The change is based on the r8127 driver package version 11.015.00
available on the Realtek website and also on
https://github.com/openwrt/rtl8127.

There's no public datasheet for the chip so this is just porting over
the original vendor code to the API and style of the upstream one.

Signed-off-by: Fabio Baltieri <fabio.baltieri@gmail.com>
---

Hi, this is a port of the fiber specific configuration code found in the
Realtek r8127 driver to the upstream one, basically just configuring the
serdes and making sure eee is disabled for good when the specific chip
variant is detected.

The code is full of magics and there's no public datasheet for the chip
so not much space to clarify what the individual registers/bits do, but
that seems to be the norm for this driver.

Tested this with a pair of RTL8127ATF based cards connected to each
other directly both with a 10G fiber transceivers and DAC cable and with
the other end running either the same r8169 upstream driver or the
Realtek r8127 one. Tested both 10G and 1G speed, connection seems to be
stable in all combinations.

That's all the 10G gear I have, though I also run this in a system with
other r8169 based cards just in case and things seems to work as
expected.

Cheers,
Fabio

---
 drivers/net/ethernet/realtek/r8169_main.c | 179 +++++++++++++++++++++-
 1 file changed, 176 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index d18734fe12e..7676c2af90e 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -729,6 +729,7 @@ struct rtl8169_private {
 	unsigned supports_gmii:1;
 	unsigned aspm_manageable:1;
 	unsigned dash_enabled:1;
+	unsigned fiber_mode:1;
 	dma_addr_t counters_phys_addr;
 	struct rtl8169_counters *counters;
 	struct rtl8169_tc_offsets tc_offset;
@@ -842,7 +843,8 @@ static bool rtl_supports_eee(struct rtl8169_private *tp)
 {
 	return tp->mac_version >= RTL_GIGA_MAC_VER_34 &&
 	       tp->mac_version != RTL_GIGA_MAC_VER_37 &&
-	       tp->mac_version != RTL_GIGA_MAC_VER_39;
+	       tp->mac_version != RTL_GIGA_MAC_VER_39 &&
+	       !tp->fiber_mode;
 }
 
 static void rtl_read_mac_from_reg(struct rtl8169_private *tp, u8 *mac, int reg)
@@ -1399,6 +1401,119 @@ DECLARE_RTL_COND(rtl_ocp_tx_cond)
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
+static void rtl8127_set_sds_phy_caps_1g(struct rtl8169_private *tp)
+{
+	u16 val;
+
+	rtl8127_sds_phy_modify(tp, 0, 1, 31, 0, BIT(3));
+	rtl8127_sds_phy_modify(tp, 0, 2, 0,
+			       BIT(13) | BIT(12) | BIT(6),
+			       BIT(12) | BIT(6));
+	RTL_W16(tp, 0x233a, 0x8004);
+
+	val = RTL_R16(tp, 0x233e);
+	val &= BIT(13) | BIT(12) | BIT(1) | BIT(0);
+	val |= BIT(1);
+	RTL_W16(tp, 0x233e, val);
+
+	r8169_mdio_write(tp, 0xc40a, 0x0);
+	r8169_mdio_write(tp, 0xc466, 0x0);
+	r8169_mdio_write(tp, 0xc808, 0x0);
+	r8169_mdio_write(tp, 0xc80a, 0x0);
+
+	val = r8168_phy_ocp_read(tp, 0xc804);
+	r8168_phy_ocp_write(tp, 0xc804, (val & ~0x000f) | 0x000c);
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
@@ -1512,6 +1627,15 @@ static enum rtl_dash_type rtl_get_dash_type(struct rtl8169_private *tp)
 	}
 }
 
+static bool rtl_fiber_mode(struct rtl8169_private *tp)
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
@@ -2293,6 +2417,27 @@ static void rtl8169_get_eth_ctrl_stats(struct net_device *dev,
 		le32_to_cpu(tp->counters->rx_unknown_opcode);
 }
 
+static int rtl8169_set_link_ksettings(struct net_device *ndev,
+				      const struct ethtool_link_ksettings *cmd)
+{
+	struct rtl8169_private *tp = netdev_priv(ndev);
+
+	if (tp->fiber_mode) {
+		if (cmd->base.speed != SPEED_1000 &&
+		    cmd->base.speed != SPEED_10000)
+			return -EINVAL;
+
+		rtl8127_sds_phy_exit_1g(tp);
+
+		if (cmd->base.speed == SPEED_1000)
+			rtl8127_set_sds_phy_caps_1g(tp);
+		else
+			rtl8127_set_sds_phy_caps_10g(tp);
+	}
+
+	return phy_ethtool_set_link_ksettings(ndev, cmd);
+}
+
 static const struct ethtool_ops rtl8169_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_MAX_FRAMES,
@@ -2312,7 +2457,7 @@ static const struct ethtool_ops rtl8169_ethtool_ops = {
 	.get_eee		= rtl8169_get_eee,
 	.set_eee		= rtl8169_set_eee,
 	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
-	.set_link_ksettings	= phy_ethtool_set_link_ksettings,
+	.set_link_ksettings	= rtl8169_set_link_ksettings,
 	.get_ringparam		= rtl8169_get_ringparam,
 	.get_pause_stats	= rtl8169_get_pause_stats,
 	.get_pauseparam		= rtl8169_get_pauseparam,
@@ -2390,7 +2535,10 @@ static void rtl8125a_config_eee_mac(struct rtl8169_private *tp)
 
 static void rtl8125b_config_eee_mac(struct rtl8169_private *tp)
 {
-	r8168_mac_ocp_modify(tp, 0xe040, 0, BIT(1) | BIT(0));
+	if (tp->fiber_mode)
+		r8168_mac_ocp_modify(tp, 0xe040, BIT(1) | BIT(0), 0);
+	else
+		r8168_mac_ocp_modify(tp, 0xe040, 0, BIT(1) | BIT(0));
 }
 
 static void rtl_rar_exgmac_set(struct rtl8169_private *tp, const u8 *addr)
@@ -2440,6 +2588,22 @@ static void rtl8169_init_phy(struct rtl8169_private *tp)
 	    tp->pci_dev->subsystem_device == 0xe000)
 		phy_write_paged(tp->phydev, 0x0001, 0x10, 0xf01b);
 
+	if (tp->fiber_mode) {
+		phy_remove_link_mode(tp->phydev, ETHTOOL_LINK_MODE_10baseT_Half_BIT);
+		phy_remove_link_mode(tp->phydev, ETHTOOL_LINK_MODE_10baseT_Full_BIT);
+		phy_remove_link_mode(tp->phydev, ETHTOOL_LINK_MODE_100baseT_Half_BIT);
+		phy_remove_link_mode(tp->phydev, ETHTOOL_LINK_MODE_100baseT_Full_BIT);
+		phy_remove_link_mode(tp->phydev, ETHTOOL_LINK_MODE_2500baseT_Full_BIT);
+		phy_remove_link_mode(tp->phydev, ETHTOOL_LINK_MODE_5000baseT_Full_BIT);
+
+		phy_remove_link_mode(tp->phydev, ETHTOOL_LINK_MODE_Autoneg_BIT);
+		phy_remove_link_mode(tp->phydev, ETHTOOL_LINK_MODE_Pause_BIT);
+		phy_remove_link_mode(tp->phydev, ETHTOOL_LINK_MODE_Asym_Pause_BIT);
+
+		tp->phydev->autoneg = 0;
+		tp->phydev->port = PORT_FIBRE;
+	}
+
 	/* We may have called phy_speed_down before */
 	phy_speed_up(tp->phydev);
 
@@ -4893,6 +5057,13 @@ static int rtl_open(struct net_device *dev)
 		goto err_free_irq;
 
 	rtl8169_up(tp);
+
+	if (tp->fiber_mode) {
+		rtl8127_sds_phy_exit_1g(tp);
+
+		rtl8127_set_sds_phy_caps_10g(tp);
+	}
+
 	rtl8169_init_counter_offsets(tp);
 	netif_start_queue(dev);
 out:
@@ -5453,6 +5624,8 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	tp->dash_type = rtl_get_dash_type(tp);
 	tp->dash_enabled = rtl_dash_is_enabled(tp);
 
+	tp->fiber_mode = rtl_fiber_mode(tp);
+
 	tp->cp_cmd = RTL_R16(tp, CPlusCmd) & CPCMD_MASK;
 
 	if (sizeof(dma_addr_t) > 4 && tp->mac_version >= RTL_GIGA_MAC_VER_18 &&
-- 
2.47.3


