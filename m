Return-Path: <netdev+bounces-66482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E0983F615
	for <lists+netdev@lfdr.de>; Sun, 28 Jan 2024 16:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F414B21282
	for <lists+netdev@lfdr.de>; Sun, 28 Jan 2024 15:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBF422F17;
	Sun, 28 Jan 2024 15:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lz1fKROq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E232720DFD
	for <netdev@vger.kernel.org>; Sun, 28 Jan 2024 15:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706455197; cv=none; b=LCkiX5AdCmlo7aYoblFzYmESixwtWaASUW7ADxgJS0prlX7HCaBDO/zyq/sdX3HRqKWSjNJGNYUdqCMAdoDkabkhmuNLuDG/XwrLzjEuEY5KmfXYStntwFYaF6g6l/3qye6H4nMErjR3G8Pf3FZyqRyTtoGnMaiaIa0yRD/Qx6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706455197; c=relaxed/simple;
	bh=SBus1xIkam4Gk2P91WnEKdyJ/Hh2bAec5g5gCH/PiVA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=KuHAg1LK2HJ5vA5cR/t86N99UDi57VsKIPjbwmwHzSvcWnXINFA6X6XXk5cCoImcu130mKEGmuUyKXiXTq+9sn0KOt4oci7OJHryvOzE82TljQftKuO3Pj/jf1A+BV/6bnWS/VW9NNcvyxlqnNlEbor5UU1W6tOUkUPzxqtwYsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lz1fKROq; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40e775695c6so16824475e9.3
        for <netdev@vger.kernel.org>; Sun, 28 Jan 2024 07:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706455194; x=1707059994; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xmctjAqjJpWwXIneg1zb2K1pb8J1P08wi02W2RkIJCU=;
        b=lz1fKROqrJ/8XWi+5Evf41wYwPp76TuhZsoXNWGqRNtaq0azvEitTGd3I4iGYbINCp
         NHrG4rCV8SC/1vBaD2L/XLs9MSjdfyTH28KiEHv9XWNqVE1soJtCzvx5BRVWNWFQ2fKq
         RHhlKxhqG8FrGKulWMN9nriv7QY+/81HrTxuUGFJAFSiVj2v9cBGz0bTzWEVcsfe4nj5
         U4WIvTQlINcdz3I2HUnPkkFPLkJfxlOp1japs4Lpps0oTKY3LfItgrm2YpkURS0a7dgB
         WGoOcvqkzSeVYgwsGZfQKK5psGyHCONEKN4jEDD2y5dpvGfPBwYE0obpeH52RY7NeiCG
         BlMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706455194; x=1707059994;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xmctjAqjJpWwXIneg1zb2K1pb8J1P08wi02W2RkIJCU=;
        b=kyH7zjSe12IyGKmW1xdNXcJlyRV/nRi1mzydxeDrqJgt6H7k3tBEKQz7TdDsgrRbPE
         KlpJV6XtAFSrTDgDPP/sRJufoHlXvhMAgeapXbhlBBsNxMzLsbL/wTSu89n0mJrQ3VfH
         ReU+xV4jGtwcNja3JAMClKnR7BntmUy5P9rI5DWQWRNzqL0TXx4zLUcnEiEx0NEYAdIR
         SzWxeNiUqRWr9AQogxaNjjJfS6acSVqf9hEiPK6nR752d3EVw1UgMrivb0bjRFHpxhOj
         Ghigo1rJ4FMnjVovp85hI8xtp0r7FjpQBSuDHPYo3kuSz59rSH7NRLmWPLLAhF4p3pAr
         xYVw==
X-Gm-Message-State: AOJu0YxiHgZ8tFgR0TeOEEoyzVlUhaFSb8SaFZsASnoLbvEZzHuly8E+
	JzkYAkn0d6YNaMIQkFW/IWgNZsMOmCrE8tvJDupdPwihLgVGRkdB
X-Google-Smtp-Source: AGHT+IGDgxjhVOHNyKTbagla2z20kwIjbsk5WFxfU5hxvSTNzHY7Q1yj9MSbSgHk5+kZHG5pWfwKvA==
X-Received: by 2002:a05:600c:1987:b0:40e:f589:50bf with SMTP id t7-20020a05600c198700b0040ef58950bfmr1067928wmq.15.1706455193725;
        Sun, 28 Jan 2024 07:19:53 -0800 (PST)
Received: from ?IPV6:2a01:c22:7abd:9b00:204a:9436:1489:6133? (dynamic-2a01-0c22-7abd-9b00-204a-9436-1489-6133.c22.pool.telefonica.de. [2a01:c22:7abd:9b00:204a:9436:1489:6133])
        by smtp.googlemail.com with ESMTPSA id bi19-20020a05600c3d9300b0040ee51f1025sm6452465wmb.43.2024.01.28.07.19.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jan 2024 07:19:53 -0800 (PST)
Message-ID: <227c1053-d960-4e90-b6f3-c42a2b4e16db@gmail.com>
Date: Sun, 28 Jan 2024 16:19:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] r8169: simplify EEE handling
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

We don't have to store the EEE modes to be advertised in the driver,
phylib does this for us and stores it in phydev->advertising_eee.
phylib also takes care of properly handling the EEE advertisement.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 32 +++--------------------
 1 file changed, 4 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 3d30d4499..e0abdbcfa 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -629,7 +629,6 @@ struct rtl8169_private {
 	struct rtl8169_counters *counters;
 	struct rtl8169_tc_offsets tc_offset;
 	u32 saved_wolopts;
-	int eee_adv;
 
 	const char *fw_name;
 	struct rtl_fw *rtl_fw;
@@ -1987,17 +1986,11 @@ static int rtl8169_get_eee(struct net_device *dev, struct ethtool_keee *data)
 static int rtl8169_set_eee(struct net_device *dev, struct ethtool_keee *data)
 {
 	struct rtl8169_private *tp = netdev_priv(dev);
-	int ret;
 
 	if (!rtl_supports_eee(tp))
 		return -EOPNOTSUPP;
 
-	ret = phy_ethtool_set_eee(tp->phydev, data);
-
-	if (!ret)
-		tp->eee_adv = phy_read_mmd(dev->phydev, MDIO_MMD_AN,
-					   MDIO_AN_EEE_ADV);
-	return ret;
+	return phy_ethtool_set_eee(tp->phydev, data);
 }
 
 static void rtl8169_get_ringparam(struct net_device *dev,
@@ -2062,21 +2055,6 @@ static const struct ethtool_ops rtl8169_ethtool_ops = {
 	.set_pauseparam		= rtl8169_set_pauseparam,
 };
 
-static void rtl_enable_eee(struct rtl8169_private *tp)
-{
-	struct phy_device *phydev = tp->phydev;
-	int adv;
-
-	/* respect EEE advertisement the user may have set */
-	if (tp->eee_adv >= 0)
-		adv = tp->eee_adv;
-	else
-		adv = phy_read_mmd(phydev, MDIO_MMD_PCS, MDIO_PCS_EEE_ABLE);
-
-	if (adv >= 0)
-		phy_write_mmd(phydev, MDIO_MMD_AN, MDIO_AN_EEE_ADV, adv);
-}
-
 static enum mac_version rtl8169_get_mac_version(u16 xid, bool gmii)
 {
 	/*
@@ -2313,9 +2291,6 @@ static void rtl8169_init_phy(struct rtl8169_private *tp)
 	/* We may have called phy_speed_down before */
 	phy_speed_up(tp->phydev);
 
-	if (rtl_supports_eee(tp))
-		rtl_enable_eee(tp);
-
 	genphy_soft_reset(tp->phydev);
 }
 
@@ -5058,7 +5033,9 @@ static int r8169_mdio_register(struct rtl8169_private *tp)
 	}
 
 	tp->phydev->mac_managed_pm = true;
-
+	if (rtl_supports_eee(tp))
+		linkmode_copy(tp->phydev->advertising_eee,
+			      tp->phydev->supported_eee);
 	phy_support_asym_pause(tp->phydev);
 
 	/* PHY will be woken up in rtl_open() */
@@ -5193,7 +5170,6 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	tp->dev = dev;
 	tp->pci_dev = pdev;
 	tp->supports_gmii = ent->driver_data == RTL_CFG_NO_GBIT ? 0 : 1;
-	tp->eee_adv = -1;
 	tp->ocp_base = OCP_STD_PHY_BASE;
 
 	raw_spin_lock_init(&tp->cfg9346_usage_lock);
-- 
2.43.0


