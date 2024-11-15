Return-Path: <netdev+bounces-145397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDF59CF631
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 21:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C393F1F2283A
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 20:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F421E1027;
	Fri, 15 Nov 2024 20:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlOW9d/Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF22F1E261E;
	Fri, 15 Nov 2024 20:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731702933; cv=none; b=LKAHA+ckpfyE5ewz1jelmdPr4ZDPeS2gkmHK9bil047FUcza44d3qsZivKTccZkpv04wwfWh066bO3TC3gyJDodhm94zCxHVSEzRqsXybs9thQZ5CmYFavnIXHstIigrlHPcRBxlp37jRZ9Lll2pEwSuKsM4qKP0vpfl+FtgMHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731702933; c=relaxed/simple;
	bh=LzF3I5Hq6MTp1dCGUgBPt0qgaNlh6lImauyAmvD5FL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d55h9J4euBCJl40ZadpEtUBMznjTkV8RpZ8JmNHhl3+8lXEuKPTdMAiGrMVxhHs1UVMWRss+Ajwh7dl/VrhWZbqIzEDLTmqj6caWPyVgCjqFqDaok3z7g9ZEHkigfgCEn0IMoITeX3QhCaBYTtTd0UCP7d+/6WfcIkYAIPbAtPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nlOW9d/Y; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5cf9cd111ecso911665a12.3;
        Fri, 15 Nov 2024 12:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731702930; x=1732307730; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ihQdzcjigq3MwAp4GZsJjR8HhhpE323WMDOe7J5U1i0=;
        b=nlOW9d/Y59FpfKRyLh85OKgtWkLJjZwHNqEdDUfc7Gnq4sAeKpVBYnGQrjK6acnJRr
         gkmwUL+HHTIgylRDJOgDT2gpijE536XINW/2H2vSVZXctCJRT3UUt4RyX2CCSDh/aHNu
         am4qF5msOkk3VhZE5PP1ZaU8Yol6eZsCZv+JdyEbkXbzGeu3dMUwwpyT7AVZCLMq5oVJ
         la5Zql65o5vumLIhlA1so6NkjDisO2bHpl9bpTDCi/HDvXad1uB93KouPT8bofJfgd0A
         MUhnTUsinK1sYdgjE7+wIiHgocg5WJmIyA44rWSKX4aRdG7IaRYA5npPUQ9OB0uVRodS
         Uu9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731702930; x=1732307730;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihQdzcjigq3MwAp4GZsJjR8HhhpE323WMDOe7J5U1i0=;
        b=N11XKRH9jvcplKjEOU97yKVQcul4B4qQN3kd09QT4UnAGCW1vV15pUPTY5aYPhK3+w
         PpPagWHSCsKyki4KxBsO6beXK/KXSkhzyr589fydnhX/qCZCJJObeM/ZDUdgv7izmdjE
         Ay+oafQZH7ssh2C18jmXHx+kBze3IhU0nm61wCYHZT68TnElANF21330bE3Z7ijItrga
         a3nH3qX4iVJusbWspVyIuDJIicYWVgp/hjv+emg7XJ9QASiR/nIAa+U/pLGJO7FMwQ9z
         o9cy1kMLsPmmPacxQi9R9pE2KKwqdtnghW2InFV3Hq5Nzy4xhlS4OAnu/a+i6HYmuNmv
         h7mA==
X-Forwarded-Encrypted: i=1; AJvYcCVYq5tP4huWaF3rEPnIGSbQWbsfbsZ9atQJ8MHdEAzQmBC6ptCl/HoTH/MBVYo3HCUw0DS+VeWm@vger.kernel.org, AJvYcCX6DHE9PgZElg2/Rh/IelcWA2FYsDtoEUOGB8uygedFcgVJPJ5apOWAv3xG9+GYJ2kxeEQ+5SN2E6JZgVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YznnyPmrfhy6UE2wohMp+3nN5bk+tzETgsQ+ao2wQZsf+pnffr4
	HVq03WNar52sJYe8uZous5pEY7iT3PISkEruHvC2NkltrKJ8ioGn
X-Google-Smtp-Source: AGHT+IGOpkk3SBDDvAyJAhHV9sCmQvNV0IY3NebEAlSMrprU3Jnymqpjm5eGHzthhM+GrB+82/LNOg==
X-Received: by 2002:a05:6402:40ca:b0:5cf:a1c1:5289 with SMTP id 4fb4d7f45d1cf-5cfa1c154f1mr342181a12.21.1731702929669;
        Fri, 15 Nov 2024 12:35:29 -0800 (PST)
Received: from ?IPV6:2a02:3100:b259:e900:a13d:5aad:11c9:4490? (dynamic-2a02-3100-b259-e900-a13d-5aad-11c9-4490.310.pool.telefonica.de. [2a02:3100:b259:e900:a13d:5aad:11c9:4490])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5cf79b9f88esm1967836a12.26.2024.11.15.12.35.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 12:35:28 -0800 (PST)
Message-ID: <170a8d59-e954-4316-9b83-9b799cb60481@gmail.com>
Date: Fri, 15 Nov 2024 21:35:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 0/2] Fix 'ethtool --show-eee' during initial stage
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Choong Yong Liang <yong.liang.choong@linux.intel.com>,
 Andrew Lunn <andrew@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20241115111151.183108-1-yong.liang.choong@linux.intel.com>
 <403be2f6-bab1-4a63-bad4-c7eac1e572ee@gmail.com>
 <ZzdW2iB2OkbZxTgS@shell.armlinux.org.uk>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <ZzdW2iB2OkbZxTgS@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15.11.2024 15:12, Russell King (Oracle) wrote:
> On Fri, Nov 15, 2024 at 02:41:54PM +0100, Heiner Kallweit wrote:
>> On 15.11.2024 12:11, Choong Yong Liang wrote:
>>> From: Choong Yong Liang <yong.liang.choong@intel.com>
>>>
>>> When the MAC boots up with a Marvell PHY and phy_support_eee() is implemented,
>>> the 'ethtool --show-eee' command shows that EEE is enabled, but in actuality,
>>> the driver side is disabled. If we try to enable EEE through
>>> 'ethtool --set-eee' for a Marvell PHY, nothing happens because the eee_cfg
>>> matches the setting required to enable EEE in ethnl_set_eee().
>>>
>>> This patch series will remove phydev->eee_enabled and replace it with
>>> eee_cfg.eee_enabled. When performing genphy_c45_an_config_eee_aneg(), it
>>> will follow the master configuration to have software and hardware in sync,
>>> allowing 'ethtool --show-eee' to display the correct value during the
>>> initial stage.
>>>
>>> v2 changes:
>>>  - Implement the prototype suggested by Russell
>>>  - Check EEE before calling phy_support_eee()
>>>
>>> Thanks to Russell for the proposed prototype in [1].
>>>
>>> Reference:
>>> [1] https://patchwork.kernel.org/comment/26121323/
>>>
>>> Choong Yong Liang (2):
>>>   net: phy: replace phydev->eee_enabled with eee_cfg.eee_enabled
>>>   net: stmmac: set initial EEE policy configuration
>>>
>>>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  3 +++
>>>  drivers/net/phy/phy-c45.c                         | 11 +++++------
>>>  drivers/net/phy/phy_device.c                      |  6 +++---
>>>  include/linux/phy.h                               |  5 ++---
>>>  4 files changed, 13 insertions(+), 12 deletions(-)
>>>
>>
>> Russell submitted the proposed patch already:
>> https://patchwork.kernel.org/project/netdevbpf/patch/E1tBXAF-00341F-EQ@rmk-PC.armlinux.org.uk/
>> So there's no need for your patch 1.
> 
> Patch 1 is an updated version of that patch, minus my authorship and of
> course no sign-off. I've already marked this series as requiring changes
> in patchwork (hopefully, if I did it correctly.)
> 

The updated version adds an argument to genphy_c45_an_config_eee_aneg(),
and I wonder whether we can do better, as this results in several calls
with the same argument. The following is an alternative, to be applied
on top of your original patch. I don't have a clear preference, though.

---
 drivers/net/phy/phy.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 8876f3673..22c9bbebb 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1682,11 +1682,10 @@ EXPORT_SYMBOL(phy_ethtool_get_eee);
  * configuration.
  */
 static void phy_ethtool_set_eee_noneg(struct phy_device *phydev,
-				      struct ethtool_keee *data)
+				      struct ethtool_keee *old_cfg)
 {
-	if (phydev->eee_cfg.tx_lpi_enabled != data->tx_lpi_enabled ||
-	    phydev->eee_cfg.tx_lpi_timer != data->tx_lpi_timer) {
-		eee_to_eeecfg(&phydev->eee_cfg, data);
+	if (phydev->eee_cfg.tx_lpi_enabled != old_cfg->tx_lpi_enabled ||
+	    phydev->eee_cfg.tx_lpi_timer != old_cfg->tx_lpi_timer) {
 		phydev->enable_tx_lpi = eeecfg_mac_can_tx_lpi(&phydev->eee_cfg);
 		if (phydev->link) {
 			phydev->link = false;
@@ -1706,21 +1705,27 @@ static void phy_ethtool_set_eee_noneg(struct phy_device *phydev,
  */
 int phy_ethtool_set_eee(struct phy_device *phydev, struct ethtool_keee *data)
 {
+	struct eee_config old_cfg;
 	int ret;
 
 	if (!phydev->drv)
 		return -EIO;
 
+	old_cfg = phydev->eee_cfg;
+	eee_to_eeecfg(&phydev->eee_cfg, data);
+
 	mutex_lock(&phydev->lock);
 	ret = genphy_c45_ethtool_set_eee(phydev, data);
-	if (ret >= 0) {
-		if (ret == 0)
-			phy_ethtool_set_eee_noneg(phydev, data);
-		eee_to_eeecfg(&phydev->eee_cfg, data);
-	}
+	if (ret == 0)
+		phy_ethtool_set_eee_noneg(phydev, data);
 	mutex_unlock(&phydev->lock);
 
-	return ret < 0 ? ret : 0;
+	if (ret < 0) {
+		phydev->eee_cfg = old_cfg;
+		return ret;
+	}
+
+	return 0;
 }
 EXPORT_SYMBOL(phy_ethtool_set_eee);
 
-- 
2.47.0



