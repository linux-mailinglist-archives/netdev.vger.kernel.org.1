Return-Path: <netdev+bounces-248261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B62D060D9
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 21:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDEBD301671E
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 20:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6113432BF26;
	Thu,  8 Jan 2026 20:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2+9BOee"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B3D2E7F25
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 20:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767904107; cv=none; b=aCD1NoI/lV/eN+Hk4ygSmvY+LqBRw5vaSkg0JAlI943+27tvgfzyNw2d0bjYJFXuRiKfeTZYu7q0gqy9bVkVrcTmoenZ7hHqvUmUVEnRqfuLyqPkLmGvlk5xCfySlLRtF2kNEjJjWjnKlZ/u8r0GFfEF5flDRfvwaiwVRoSg+MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767904107; c=relaxed/simple;
	bh=jW89qN4VRp3luE88cNsb23VfoDYwtxvcJIDrafYXms4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=rEXZ2XAOcVxKb6WAM33YiMIsYWdrUybxqj2CRlYp0/YlWbpsa3/HwSmxz4SMFshkBpTEuHbk11Ge1Rj4CqKMwcGrK+4MSG8QcZQKjTXLDs41AW73jcF4prFumr5bJrVf2Pl8PmURAIgNB2u9xiEfUZ/1SYIxzIi8U17YYdEwtoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2+9BOee; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42fbc3056afso1990340f8f.2
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 12:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767904104; x=1768508904; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fwhyeCuSEzP7nY9L4GSxdidi0duVk6JTSGXQaHSvzoA=;
        b=i2+9BOeeGrWOz8lifCLS4UclgOJrIzDRuL4iiot7IZu0/nWEcobhXuVRm1wvFh0a9Z
         g0Wau7BCZNYQs3HRhmuPS3rWdkBSuQxYRSC3GMCDeF/tw+7P1tliueraZdFja2e9CouE
         SKV2Vf9v2O8lubKMclCZ+Jy29Jz/i5blB4XsOY/2r1+OS4xrZya4249axHMM7+8BaKOx
         liNLBmoQsRug0ETUZcGQGiWaZPVHQ2Eqyrgmw/8/3El2wX0dHKNdFeKEA3aw3cLTM/KV
         LGBEHk4dGc1TqIhabdUQKayYIHSzDaKfypsKK/51wCMxSMfeysVGXnxOHcokp8tk13d/
         wGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767904104; x=1768508904;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fwhyeCuSEzP7nY9L4GSxdidi0duVk6JTSGXQaHSvzoA=;
        b=VNe0sZ93f/QL0qtoUeWuAQW2CvDJPLL83MX/BDpoMmXDOFwoC91Dq1An539eh+ca1g
         zyZFyyrpVJP0PsfguprmoB491Ofocr7bM5cexUSuQSjKeBc68mfWTc5oDAm3y1mnmB5/
         cqwySp6x1wKcTCSlB0azlazjO1NyxuL1+O+xxV058VzpFFNDv+0B2OfJY44LrTi9+Y9k
         SCqan1+sh61JcV7Jaf/Trn7yY26n4mdlAlJ7vBC+EV5XGBec6FpW7rFGrFTMyKnschUf
         KNB0Tknuf/22s8THUNapejplZPuK8QvY50HhBCtKfFA4IgTtbF7t+AewsCYWj1ceJ2ba
         SuTA==
X-Gm-Message-State: AOJu0YyE9GJpNjRk8lv973cGPB8tcv76IByoPZcYcsNPFqu145NU57Pc
	fyvbPSKlhZ5f/N9wdJROo4wEs8RJjZjhvRFAHacBTSj21wjUa2+Xg601
X-Gm-Gg: AY/fxX68rd+ET2rjtaKUvW4J7syN6eJYekpDkj4u9TBOhHYrs3z69bqEKG98IcB7Alf
	Jt/a7lBX1pE8Yq/TIO68zFv6etT6UfMHB6ymPKZ63P8UF28P42jKlsxWjtTtAQkgn36kIAgXHJF
	QKabLb2iVs0YMp4GXzuySSvldGOU6IEM/s4WTiLaB2nWuWafysCDlHGusmihesN8FFwgjV+K8IO
	VS2UAcYOowMV1uxqo1BtWLXmHPit1637T5qNf+ciIf/FDAyEGbvo5ryRhhsfliAYTfXJNklfNI/
	P2+PwcrhtOCzI6lfHJrm2S8FkqUUPn0yAqGJZzfiZmONlU5MUuMDP3op9l6v92iTZE1Y7NSBEKn
	s9EHWcKacKE7dBIK74HUEdXG9kGURE52KyHQhSqsbkibWxy5SQFkXdQGy3ncxF2E6fEkaeZ3F7F
	bzG3E4sreicT7DVKqCgASz6mtdkv4vpYGXNwBtELNbRSo7+8jijH+tcqecIIO7E9DMlkW95zxrj
	QJar/R6ZxcjCZ/r+nQHIMYkuVLZRzg2Cc7qpXYsRB6ekMZ/navm4g==
X-Google-Smtp-Source: AGHT+IFIJqV7oFMIxsqnelvzYMDt+uTAFqFSGd8y5BWi/DAkG2v3dM0RM34Zmw3CFAYaY6sMEctD0g==
X-Received: by 2002:a05:6000:2dc2:b0:42b:3246:1681 with SMTP id ffacd0b85a97d-432c36340ccmr9160517f8f.18.1767904103863;
        Thu, 08 Jan 2026 12:28:23 -0800 (PST)
Received: from ?IPV6:2003:ea:8f14:a400:1d60:60fb:9b76:bf18? (p200300ea8f14a4001d6060fb9b76bf18.dip0.t-ipconnect.de. [2003:ea:8f14:a400:1d60:60fb:9b76:bf18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432d9610671sm105756f8f.34.2026.01.08.12.28.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 12:28:23 -0800 (PST)
Message-ID: <d2bab188-96de-407d-84b3-34584494aa30@gmail.com>
Date: Thu, 8 Jan 2026 21:28:20 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 2/2] r8169: add support for RTL8127ATF (Fiber SFP)
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
References: <52011433-79d3-4097-a2d3-d1cca1f66acb@gmail.com>
Content-Language: en-US
In-Reply-To: <52011433-79d3-4097-a2d3-d1cca1f66acb@gmail.com>
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
 drivers/net/ethernet/realtek/r8169_main.c | 89 ++++++++++++++++++++++-
 1 file changed, 85 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 755083852ee..cf37b4e6c4a 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -17,6 +17,7 @@
 #include <linux/delay.h>
 #include <linux/ethtool.h>
 #include <linux/phy.h>
+#include <linux/realtek_phy.h>
 #include <linux/if_vlan.h>
 #include <linux/in.h>
 #include <linux/io.h>
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



