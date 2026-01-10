Return-Path: <netdev+bounces-248708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51287D0D87F
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 16:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63D923009F6A
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 15:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCEE1DF751;
	Sat, 10 Jan 2026 15:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bK9hd1C2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93221F91E3
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 15:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768058139; cv=none; b=OXmadxeWxWAYo1/Vr+q6JblpPBighyfubvo+xwZhD7EzThmwqzT2H6evf4sjccIh6PQ+RYFm+3V8Tvu65R8xumFc4f/inEyiW/xotoloeZBGnAZm+jwSOMR4WcV+2VsgPJObU+wkYQ/a+Hl1Yxgyofb8R4TOr27Z00Dd4Nn7TEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768058139; c=relaxed/simple;
	bh=Xji0EjIz8qOzSmm3rTLp5uPxCGnk8jdRCyM6rvDZ3R0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=VQtblXui7+XZxHYp18Zqvs1hNNj/Y17lAEfOpmCrCJ4wucOBtMVERV2pRmdU1ARs6mCPhw/AZ8Lj7BT2v3im3xOvPM6LBo70+G/akJZZE1Eq4/ol6tBGy1AlOSNsIZYoNQJ22DFtGLASV+w12ROsiHXb74rUtqw0q/m2whUQQg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bK9hd1C2; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4327778df7fso3155296f8f.3
        for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 07:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768058135; x=1768662935; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DA9I4x62v3wHnJ49T409glT4HZ0J1VdRuhE6SxYJ/MY=;
        b=bK9hd1C2enRCIfQvVyYhvLZ1f4inrSfAP3t99G0PHzt6DZZNd60zlFT/KxllM4UJIW
         3/bx32vwW1osGqwzqaV2Qf0D7D/1vTd2dhw7jRWYqSXC8WJasG6a3wzK6rhAEaqyUtMv
         2kkVNAbN4r3B7utdFDq4ah/G7UIIVgCaH2jIaaJ+jx5I5H+GeEsc4Qnw2X+NAm1pgeIx
         MgySIKy5ln0ogAvL5sB/gWTSeiByjOvagb19PvbVzfZbQ1HQDeUfTOxGMu0OfHAG9eju
         RfWkdI2ZyUx6Hin1MU9WmuBK4p48STZdfnayiutwmjh8cLKVaSqUUbzdBxCPkqF+SNp4
         e97A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768058135; x=1768662935;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DA9I4x62v3wHnJ49T409glT4HZ0J1VdRuhE6SxYJ/MY=;
        b=v0aJ2bg84CLgMamWmQRCkaly6Q3A7zZkQO19wGgMBb1K3KBSknENIXjIjTEazizqjS
         oZ0ObVXgab9Tpq3GB8BREeSdh2KlxJC2mcqXadYWI7R1WBSzmWhPnsZy2xBAkdQjRYZW
         Dyee/MKwUBt2oJHJtiwiX+bDNe4ykktsHAPNL4UaiKCgb24d3FGP62gvJDQuo5n2UbG8
         Rhp1TME12vHu0ngaXGTccSuPezt07rpoa+xvub/+/9vOTRLNt3UuDXCn5l0I2me8e914
         eUbFakz6Ff6bAjdKY2heZGDgvRL6e1C5kjGC+EsC9+UQC07Toy4aztUERwG8nMCc7+4B
         1soA==
X-Gm-Message-State: AOJu0YxXU13/+VL8Whmk1hkrTak3lKpLLhFpMKBFAxJgK52r0wUJcYF/
	AJXc/1gi1yMTHKdlRE1TNNMoTSI89jY7vZI5btDFmAcSPAiuyusBzgL0
X-Gm-Gg: AY/fxX41UX3I8MZFEKsrpYUzcqI94wmXSMf4kISJp5Zbv+2wRwrYOOWgMFwdZ+qLvDS
	2CAAwnO5JQjw2mwaVdTj5UuR9SaCSlWMcGRqQfjuVV1KdIz5e2cFfQk0i/vldMAZXgAL1k/Qxzk
	HQSS8NpySL5dWdVO+gSC7idbiPGHKIKOBmsaK9dGs27LXQ6wvH07FsT1fnzIX1fcQghZxkN7UYu
	RIMPGBehDm1Xjms4FBvrSnw4VG9H8mDNsxrDM8duLWas6Pi/t9e9KKvv58fSe29o4kRJiND2IZy
	rGjPUBs0oM+78PqeIbRn/UeKQ7h/0jIGAQwZV92E9W46+w0iQ2rdPfUVM3nEAt1vysgVc85GMRX
	9c0sDwGGyYbUJng0X1+hR9LZOnT9c/Jf3DMwuAySKydprrkH4I08bJLwPxFwEnqaT8vW4VJW2Mg
	2kmWBtge1LNZoJDYCsisaBcsCpdPQWDgB+sX3H/Z3tlaezUt9LKn25wX1SxFa9o1EITPqDXgOPq
	lLPKNhtZDBrzNNyz5QNEJSp2TlfnLNOjD+EsJE4ZQRUR0DrNYT+SA==
X-Google-Smtp-Source: AGHT+IHR/V43wGF8/MFttFtwyO2/1v//RWCEkbJ5yYfUqyR0J2PwxRJAPT4MkZYc1MDdN6wrN515RQ==
X-Received: by 2002:a05:6000:2584:b0:42f:ba09:aa7c with SMTP id ffacd0b85a97d-432c3765636mr18206682f8f.54.1768058134807;
        Sat, 10 Jan 2026 07:15:34 -0800 (PST)
Received: from ?IPV6:2003:ea:8f1c:1800:8cc6:804e:b81b:aa56? (p200300ea8f1c18008cc6804eb81baa56.dip0.t-ipconnect.de. [2003:ea:8f1c:1800:8cc6:804e:b81b:aa56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5edb7esm28040037f8f.30.2026.01.10.07.15.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jan 2026 07:15:34 -0800 (PST)
Message-ID: <5c390273-458f-4d92-896b-3d85f2998d7d@gmail.com>
Date: Sat, 10 Jan 2026 16:15:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v2 2/2] r8169: add support for RTL8127ATF (Fiber SFP)
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Michael Klein <michael@fossekall.de>, Daniel Golle <daniel@makrotopia.org>,
 Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Aleksander Jan Bajkowski <olek2@wp.pl>,
 Fabio Baltieri <fabio.baltieri@gmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <c2ad7819-85f5-4df8-8ecf-571dbee8931b@gmail.com>
Content-Language: en-US
In-Reply-To: <c2ad7819-85f5-4df8-8ecf-571dbee8931b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

RTL8127ATF supports a SFP+ port for fiber modules (10GBASE-SR/LR/ER/ZR and
DAC). The list of supported modes was provided by Realtek. According to the
r8127 vendor driver also 1G modules are supported, but this needs some more
complexity in the driver, and only 10G mode has been tested so far.
Therefore mainline support will be limited to 10G for now.
The SFP port signals are hidden in the chip IP and driven by firmware.
Therefore mainline SFP support can't be used here.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- move realtek_phy.h to new include/net/phy/
---
 drivers/net/ethernet/realtek/r8169_main.c | 89 ++++++++++++++++++++++-
 1 file changed, 85 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 755083852ee..faf910ecf81 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -31,6 +31,7 @@
 #include <linux/unaligned.h>
 #include <net/ip6_checksum.h>
 #include <net/netdev_queues.h>
+#include <net/phy/realtek_phy.h>
 
 #include "r8169.h"
 #include "r8169_firmware.h"
@@ -733,6 +734,7 @@ struct rtl8169_private {
 	unsigned supports_gmii:1;
 	unsigned aspm_manageable:1;
 	unsigned dash_enabled:1;
+	bool sfp_mode:1;
 	dma_addr_t counters_phys_addr;
 	struct rtl8169_counters *counters;
 	struct rtl8169_tc_offsets tc_offset;
@@ -1097,6 +1099,10 @@ static int r8168_phy_ocp_read(struct rtl8169_private *tp, u32 reg)
 	if (rtl_ocp_reg_failure(reg))
 		return 0;
 
+	/* Return dummy MII_PHYSID2 in SFP mode to match SFP PHY driver */
+	if (tp->sfp_mode && reg == (OCP_STD_PHY_BASE + 2 * MII_PHYSID2))
+		return PHY_ID_RTL_DUMMY_SFP & 0xffff;
+
 	RTL_W32(tp, GPHY_OCP, reg << 15);
 
 	return rtl_loop_wait_high(tp, &rtl_ocp_gphy_cond, 25, 10) ?
@@ -1154,6 +1160,46 @@ static void r8168_mac_ocp_modify(struct rtl8169_private *tp, u32 reg, u16 mask,
 	raw_spin_unlock_irqrestore(&tp->mac_ocp_lock, flags);
 }
 
+static void r8127_sfp_sds_phy_reset(struct rtl8169_private *tp)
+{
+	RTL_W8(tp, 0x2350, RTL_R8(tp, 0x2350) & ~BIT(0));
+	udelay(1);
+
+	RTL_W16(tp, 0x233a, 0x801f);
+	RTL_W8(tp, 0x2350, RTL_R8(tp, 0x2350) | BIT(0));
+	usleep_range(10, 20);
+}
+
+static void r8127_sfp_init_10g(struct rtl8169_private *tp)
+{
+	int val;
+
+	r8127_sfp_sds_phy_reset(tp);
+
+	RTL_W16(tp, 0x233a, 0x801a);
+	RTL_W16(tp, 0x233e, (RTL_R16(tp, 0x233e) & ~0x3003) | 0x1000);
+
+	r8168_phy_ocp_write(tp, 0xc40a, 0x0000);
+	r8168_phy_ocp_write(tp, 0xc466, 0x0003);
+	r8168_phy_ocp_write(tp, 0xc808, 0x0000);
+	r8168_phy_ocp_write(tp, 0xc80a, 0x0000);
+
+	val = r8168_phy_ocp_read(tp, 0xc804);
+	r8168_phy_ocp_write(tp, 0xc804, (val & ~0x000f) | 0x000c);
+}
+
+static void rtl_sfp_init(struct rtl8169_private *tp)
+{
+	if (tp->mac_version == RTL_GIGA_MAC_VER_80)
+		r8127_sfp_init_10g(tp);
+}
+
+static void rtl_sfp_reset(struct rtl8169_private *tp)
+{
+	if (tp->mac_version == RTL_GIGA_MAC_VER_80)
+		r8127_sfp_sds_phy_reset(tp);
+}
+
 /* Work around a hw issue with RTL8168g PHY, the quirk disables
  * PHY MCU interrupts before PHY power-down.
  */
@@ -2308,6 +2354,36 @@ static void rtl8169_get_eth_ctrl_stats(struct net_device *dev,
 		le32_to_cpu(tp->counters->rx_unknown_opcode);
 }
 
+static int rtl8169_set_link_ksettings(struct net_device *ndev,
+				      const struct ethtool_link_ksettings *cmd)
+{
+	struct rtl8169_private *tp = netdev_priv(ndev);
+	struct phy_device *phydev = tp->phydev;
+	int duplex = cmd->base.duplex;
+	int speed = cmd->base.speed;
+
+	if (!tp->sfp_mode)
+		return phy_ethtool_ksettings_set(phydev, cmd);
+
+	if (cmd->base.autoneg != AUTONEG_DISABLE)
+		return -EINVAL;
+
+	if (!phy_check_valid(speed, duplex, phydev->supported))
+		return -EINVAL;
+
+	mutex_lock(&phydev->lock);
+
+	phydev->autoneg = AUTONEG_DISABLE;
+	phydev->speed = speed;
+	phydev->duplex = duplex;
+
+	rtl_sfp_init(tp);
+
+	mutex_unlock(&phydev->lock);
+
+	return 0;
+}
+
 static const struct ethtool_ops rtl8169_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_MAX_FRAMES,
@@ -2327,7 +2403,7 @@ static const struct ethtool_ops rtl8169_ethtool_ops = {
 	.get_eee		= rtl8169_get_eee,
 	.set_eee		= rtl8169_set_eee,
 	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
-	.set_link_ksettings	= phy_ethtool_set_link_ksettings,
+	.set_link_ksettings	= rtl8169_set_link_ksettings,
 	.get_ringparam		= rtl8169_get_ringparam,
 	.get_pause_stats	= rtl8169_get_pause_stats,
 	.get_pauseparam		= rtl8169_get_pauseparam,
@@ -2435,6 +2511,9 @@ static void rtl8169_init_phy(struct rtl8169_private *tp)
 	    tp->pci_dev->subsystem_device == 0xe000)
 		phy_write_paged(tp->phydev, 0x0001, 0x10, 0xf01b);
 
+	if (tp->sfp_mode)
+		rtl_sfp_init(tp);
+
 	/* We may have called phy_speed_down before */
 	phy_speed_up(tp->phydev);
 
@@ -4800,6 +4879,10 @@ static void rtl8169_down(struct rtl8169_private *tp)
 
 	phy_stop(tp->phydev);
 
+	/* Reset SerDes PHY to bring down fiber link */
+	if (tp->sfp_mode)
+		rtl_sfp_reset(tp);
+
 	rtl8169_update_counters(tp);
 
 	pci_clear_master(tp->pci_dev);
@@ -5459,13 +5542,11 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 	tp->aspm_manageable = !rc;
 
-	/* Fiber mode on RTL8127AF isn't supported */
 	if (rtl_is_8125(tp)) {
 		u16 data = r8168_mac_ocp_read(tp, 0xd006);
 
 		if ((data & 0xff) == 0x07)
-			return dev_err_probe(&pdev->dev, -ENODEV,
-					     "Fiber mode not supported\n");
+			tp->sfp_mode = true;
 	}
 
 	tp->dash_type = rtl_get_dash_type(tp);
-- 
2.52.0



