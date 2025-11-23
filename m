Return-Path: <netdev+bounces-241052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA66C7E320
	for <lists+netdev@lfdr.de>; Sun, 23 Nov 2025 16:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D6FF4E270C
	for <lists+netdev@lfdr.de>; Sun, 23 Nov 2025 15:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE772D5A13;
	Sun, 23 Nov 2025 15:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHHWs2Z0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006D22D3A75
	for <netdev@vger.kernel.org>; Sun, 23 Nov 2025 15:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763913511; cv=none; b=kxrSXbleAmlThhKToHcQnhR9D4Dq+CBuL2ILO88hsae3+61VTjGH8Zl4tOxw0+fjFY9u6PcJ1WxWuMz3puly5uw55q33ymdB6/gKyR4tC+QPU8b6IkW6ZVvydMnUsNyjUmI5NPdzbG72O9dixF8r1b7iH/ed838KALECUVng5fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763913511; c=relaxed/simple;
	bh=Fg39oqxCWFD57H9qYw7RVursDcig49uzNEprDIQQ0pI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ux49sWUDL0AL/r2CgVmOx9a0WylgAL6bBnPMiux3g5M7Cu9sY0C9U8LrrXHWCk/axd4u8vm5B/R7DwiYFTm4j6z14rCWJbYR5IhMFw1TCd7KF+17fiCKsb4W7ZASgxv5qHpyvMdKWHtB4u6VhWVLIeKoKn7A8LRJu3U/n4nusgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHHWs2Z0; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-477b91680f8so28105615e9.0
        for <netdev@vger.kernel.org>; Sun, 23 Nov 2025 07:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763913505; x=1764518305; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7is14KbRMemBzeRCx6gev3QOFlOKrgaBSM/6R/HBYKI=;
        b=CHHWs2Z0UiopsSap4VV7F7OlHjzWZeSNPYWQP/aJrTsZS8InbUkAE56AnoIAvgi3gU
         gHTKde6K+js3kdbWiMsl1YkDzPrJo74NajaLLuFmss0OdDvRlvWocRRpWGS4mYGoyYG0
         r/ez7ZJLq8aPb2hvZTxK4rOqojDr8BjgcYyD39TELOjRRdo1wSwzU3OtUN/d0l7C6S/t
         Ia/lbEJP37K9LmIrIfjpovcNLWnetSgXjDQKWY1ZW27HF2rTp4Fg9bQWVpK7nJOWoYm6
         fA6/1oN4gHUXYUun9o6UZYTgtDxfSwWjTA/4dpp7VDBtw7CgZartfHhpLADe0cTmCE3o
         HDOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763913505; x=1764518305;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7is14KbRMemBzeRCx6gev3QOFlOKrgaBSM/6R/HBYKI=;
        b=SOFiqpkFzJzdcsZTAg1Bz/D83uOzKxeWUgKtsiX+wQT1ZBZjF7MnobjNeExuIsgqdQ
         dwUtZPz+E2gXe4Kqt2/LiZVAyhl3Q2rQFNkFwpr6LSweWaWJ5z6Lnpe5zsKpXfgNM/SP
         MlUFRqhX5E5Sy1ZjTrFBUDji/eNu5kMRU+EUWWBOGsAAhCOKJTZ1Erx/MjOpnh1/0tvP
         nn2BLSj3D/emK3e9v298C0Nt7nYgiHyprqEQlaHHIIVkddmTVh8utJugEpYMwV45wE2E
         Xu6unncDZMjfSLKZfrHS4tZH3ACbYh86AnL7/I61HFj8JhwYu7VlshmNKETfjTHZqlMP
         t2tw==
X-Forwarded-Encrypted: i=1; AJvYcCV3mC9Hrc6/0SqN2GZlmz6cVc3O40FIvg4otY8S+jNM5phcqsHI+u4jvPDyeptlwofCaxXg9yM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/WLy4k2JV/7H/YlMrRTOq1cFf6tF2MfuK6iCxE0YgXXkXiwYA
	Hg09Bnd4Cn9EzFTGdY8lWLX6yDA1fCRyUN80g81F1alksT6hcRuFdwh5
X-Gm-Gg: ASbGncueJe7cbUfroHOJ8gdXDw9rUungXEATee+gpGCFv1dxjCFuYTObhkRvrBeMvjz
	ry0hrFo6JCEBsQOcx2f/7daeh22FI6Ua6/rQVuB/pwLNOFN8sncr2VohwQKRKIXqoz28Q5vfDXf
	VwmjQjLTQgGqGKFb4owA+exnMxnYRvZ5RqUo9ClRIpjLPzng8TgFgwlTCh3X7rVh2Eo3pEEyhI9
	VDfQEppueDHmug9tpxHZHV6pHq0tz+ClUYuFLeNYXHCgH362UzmxSptNhXAhWdKOt5KZwyNzO74
	Gboq8Vf+LONd6qOfmJoU7GL81fjTVFuN/RM36PrUHKzL0V2YyxiC+cuz6VUE1YezifW7OodfPxP
	T339hPkb19zOv2x+yeY7+Yx/l87VSramDn//USp528svczjIM4wBj3JRDUzQdR4TxQ0tYKr986/
	Y5TbNrg9EgB0xLEP8nu1WjrJtpw791H7M6mtqHcSQI4UI/sRDGoluRS4S6N69TG06O66V6Y7Koe
	vlJxnR4THf0FsNTdjgmmhW4gJ4FdxUSPgJZNY8d9vtou0h2CLqKwg==
X-Google-Smtp-Source: AGHT+IGYc98a79jlMR32LLjlV7ou189uBd+yWRP6456ixvjompk4nfuO7QYPx79113vRXuAngFG5YA==
X-Received: by 2002:a05:600c:474a:b0:477:b0b9:3137 with SMTP id 5b1f17b1804b1-477c10c8886mr93627025e9.1.1763913505305;
        Sun, 23 Nov 2025 07:58:25 -0800 (PST)
Received: from ?IPV6:2003:ea:8f07:a200:c9b4:617e:3ddf:6f40? (p200300ea8f07a200c9b4617e3ddf6f40.dip0.t-ipconnect.de. [2003:ea:8f07:a200:c9b4:617e:3ddf:6f40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f363b0sm23696411f8f.13.2025.11.23.07.58.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Nov 2025 07:58:24 -0800 (PST)
Message-ID: <b012587a-2c38-4597-9af9-3ba723ba6cba@gmail.com>
Date: Sun, 23 Nov 2025 16:58:23 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] r8169: add support for RTL8127ATF
To: Fabio Baltieri <fabio.baltieri@gmail.com>
Cc: nic_swsd@realtek.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Michael Zimmermann <sigmaepsilon92@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251120195055.3127-1-fabio.baltieri@gmail.com>
 <f263daf0-70c2-46c2-af25-653ff3179cb0@gmail.com>
 <aSDLYiBftMR9ArUI@google.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <aSDLYiBftMR9ArUI@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/21/2025 9:28 PM, Fabio Baltieri wrote:
> On Thu, Nov 20, 2025 at 09:55:26PM +0100, Heiner Kallweit wrote:
>> Your patch is a good starting point, however it needs more thoughts / work how to somewhat cleanly
>> integrate Realtek's design with phylib. E.g. you would want to set 10G and aneg off via ethtool,
>> but that's not supported by phy_ethtool_ksettings_set().
>> I'll prepare patches and, if you don't mind, would provide them to you for testing, as I don't
>> own this hw.
>> At least you have a working solution for the time being. Thanks!
> 
> Sure thing, that works for me.
> 

This is a version with better integration with phylib, and with 10G support only.
Maybe I simplified the PHY/Serdes initialization too much, we'll see.
A difference to your version is that via ethtool you now can and have to set autoneg to off.

I'd appreciate if you could give it a try and provide a full dmesg log and output of "ethtool <if>".

Note: This patch applies on top of net-next and linux-next. However, if you apply it on top
of some other recent kernel version, conflicts should be easy to resolve.

---
 drivers/net/ethernet/realtek/r8169_main.c | 65 +++++++++++++++++++++--
 drivers/net/phy/realtek/realtek_main.c    | 26 +++++++++
 2 files changed, 87 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 97dbe8f8933..dbcf3d26167 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -731,6 +731,7 @@ struct rtl8169_private {
 	unsigned supports_gmii:1;
 	unsigned aspm_manageable:1;
 	unsigned dash_enabled:1;
+	bool sfp_mode:1;
 	dma_addr_t counters_phys_addr;
 	struct rtl8169_counters *counters;
 	struct rtl8169_tc_offsets tc_offset;
@@ -1094,6 +1095,10 @@ static int r8168_phy_ocp_read(struct rtl8169_private *tp, u32 reg)
 	if (rtl_ocp_reg_failure(reg))
 		return 0;
 
+	/* Return dummy MII_PHYSID2 in SFP mode to match SFP PHY driver */
+	if (tp->sfp_mode && reg == (OCP_STD_PHY_BASE + 2 * MII_PHYSID2))
+		return 0xcbff;
+
 	RTL_W32(tp, GPHY_OCP, reg << 15);
 
 	return rtl_loop_wait_high(tp, &rtl_ocp_gphy_cond, 25, 10) ?
@@ -2305,6 +2310,41 @@ static void rtl8169_get_eth_ctrl_stats(struct net_device *dev,
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
+	if (phy_is_started(phydev)) {
+		phydev->state = PHY_UP;
+		phy_trigger_machine(phydev);
+	} else {
+		_phy_start_aneg(phydev);
+	}
+
+	mutex_unlock(&phydev->lock);
+
+	return 0;
+}
+
 static const struct ethtool_ops rtl8169_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_MAX_FRAMES,
@@ -2324,7 +2364,7 @@ static const struct ethtool_ops rtl8169_ethtool_ops = {
 	.get_eee		= rtl8169_get_eee,
 	.set_eee		= rtl8169_set_eee,
 	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
-	.set_link_ksettings	= phy_ethtool_set_link_ksettings,
+	.set_link_ksettings	= rtl8169_set_link_ksettings,
 	.get_ringparam		= rtl8169_get_ringparam,
 	.get_pause_stats	= rtl8169_get_pause_stats,
 	.get_pauseparam		= rtl8169_get_pauseparam,
@@ -2436,6 +2476,22 @@ static void rtl_schedule_task(struct rtl8169_private *tp, enum rtl_flag flag)
 		clear_bit(flag, tp->wk.flags);
 }
 
+static void r8127_init_sfp_10g(struct rtl8169_private *tp)
+{
+	int val;
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
 static void rtl8169_init_phy(struct rtl8169_private *tp)
 {
 	r8169_hw_phy_config(tp, tp->phydev, tp->mac_version);
@@ -2452,6 +2508,9 @@ static void rtl8169_init_phy(struct rtl8169_private *tp)
 	    tp->pci_dev->subsystem_device == 0xe000)
 		phy_write_paged(tp->phydev, 0x0001, 0x10, 0xf01b);
 
+	if (tp->sfp_mode)
+		r8127_init_sfp_10g(tp);
+
 	/* We may have called phy_speed_down before */
 	phy_speed_up(tp->phydev);
 
@@ -5460,13 +5519,11 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
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
diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 67ecf3d4af2..296559dbc7f 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -1977,6 +1977,18 @@ static irqreturn_t rtl8221b_handle_interrupt(struct phy_device *phydev)
 	return IRQ_HANDLED;
 }
 
+static int rtlgen_sfp_get_features(struct phy_device *phydev)
+{
+	linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
+			 phydev->supported);
+	return 0;
+}
+
+static int rtlgen_sfp_config_aneg(struct phy_device *phydev)
+{
+	return 0;
+}
+
 static struct phy_driver realtek_drvs[] = {
 	{
 		PHY_ID_MATCH_EXACT(0x00008201),
@@ -2212,6 +2224,20 @@ static struct phy_driver realtek_drvs[] = {
 		.write_page     = rtl821x_write_page,
 		.read_mmd	= rtl822x_read_mmd,
 		.write_mmd	= rtl822x_write_mmd,
+	}, {
+		PHY_ID_MATCH_EXACT(0x001ccbff),
+		.name           = "Realtek SFP PHY Mode",
+		.flags		= PHY_IS_INTERNAL,
+		.probe		= rtl822x_probe,
+		.get_features   = rtlgen_sfp_get_features,
+		.config_aneg    = rtlgen_sfp_config_aneg,
+		.read_status    = rtl822x_read_status,
+		.suspend        = genphy_suspend,
+		.resume         = rtlgen_resume,
+		.read_page      = rtl821x_read_page,
+		.write_page     = rtl821x_write_page,
+		.read_mmd	= rtl822x_read_mmd,
+		.write_mmd	= rtl822x_write_mmd,
 	}, {
 		PHY_ID_MATCH_EXACT(0x001ccad0),
 		.name		= "RTL8224 2.5Gbps PHY",
-- 
2.52.0



