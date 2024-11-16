Return-Path: <netdev+bounces-145600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EED69D0082
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 19:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D093A1F22F8C
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 18:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2B618E361;
	Sat, 16 Nov 2024 18:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNhydOj1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD3EA47
	for <netdev@vger.kernel.org>; Sat, 16 Nov 2024 18:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731782255; cv=none; b=lvobnfnMIrT913ohuCJnJbg+00BmjCZJyym/DgfzjyypsjM6kJffACt4UI/nGN9Gw2ODieK4xnA4A+1OrhqWysQl+jF6bbEZRP+yrsUjBdPSAZbwwkGxpEGobyVxe8UftijTATcvIcnWIFlMWv2ztLEgGNkIC9mY0crZqF1F3MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731782255; c=relaxed/simple;
	bh=wPBbD7HG9Qwe5W0brdfght9n0J3+w/YESGjjbEsX/gI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=r8n6kpZJbTmLuUCpEleQ/WzInDQPDc6PfTI3CGXQ0XXGd5fjrQXIm7xy8HDJYus5mqE1HuarFcZzPwkgApLRjKEXi8u4A18CBFuIed0WafwJwzanreHgLMCHDep9ijlFZGygbskkLAnLRBGZ+Dkj8Y+Apw+SuTVcrJLzVTjdrFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNhydOj1; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9e44654ae3so291392866b.1
        for <netdev@vger.kernel.org>; Sat, 16 Nov 2024 10:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731782252; x=1732387052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:autocrypt:subject:from
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5XK1fCzhMO/Tm1AG5u2TmxtRBU27t5qEMb5tIIQ9xqc=;
        b=kNhydOj1z5gngjK9MoZxxgKH2FPx4+PgPtDpZI7yhqyhb8OEWmjhIvG/PYqlzy5FGi
         jDMRxZ+lowafLgGT2WjOJOWY6Rv0srLgBwuaTPd71kRrtEmI0l7pqkylLOyfRRHbLv+G
         lRYGSSnhlo6itE2wnm+D1qUg7av/L+3K4QwMvef4dO+lxbuy9a/cxmfDQIm8DGqBXS9h
         YKe+bLNYax7v9f8zbQ3m8aRAb266wGucTSnbTc1VAnEjecvUMF/oZ1ncMeiM7tkHKN4p
         7FoufodFiLJglz14hjVwZvsVvfv0BmAD0aP6MQwRZua95PIPr2isHt2ykq1bVV9iMaiy
         aF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731782252; x=1732387052;
        h=content-transfer-encoding:cc:to:autocrypt:subject:from
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5XK1fCzhMO/Tm1AG5u2TmxtRBU27t5qEMb5tIIQ9xqc=;
        b=sGxoQaX58TyiaP2AbTz4Ptyz6nn74ev6MWVndQFruROOlLCqHoVqSgmu5H8bnbrVkE
         YIEU3NXHpaXajmXxLz10hzogGG/BD6EDxr0f+SHsiD4K5pkHM1KBGVMdRqSyoXs0vNtE
         KoHwYd4a/Z3R+cg2bR+kawNrYDfARK73pr7nHjjiscv9P5FKOCj3nQu8LP+pvsko5PLL
         2H13nbn1wT4Z+4Z055mDQUU5LrxYFheIN88wXnr+0b1OjZ8JorraOPQhrgOJu6qwB6l7
         KBN4x9NeRY/dDFXy/aeGaVqBxcZeE6pTCmwU6/Jil5sctvF3WZTmdCTsAWUP8Kp9YhKQ
         NKEw==
X-Gm-Message-State: AOJu0Yzsw4q27csiaxWTyo0hc9GJ2qMtzK8jfiVhwejaDFIIJjVX7tcz
	0Z3I5PJ8RXokissklRC63souuWNW6zTpApePQW8pAkasL99hnANX
X-Google-Smtp-Source: AGHT+IFQU1vzjNfw3yZ1S3R3OnLVAsWnskUnglkMAH2jBP2nXaTfkvlyI2mM5FreyrntV8dEo8npAw==
X-Received: by 2002:a17:907:7ea5:b0:a9a:183a:b84e with SMTP id a640c23a62f3a-aa483508b20mr615851666b.40.1731782252153;
        Sat, 16 Nov 2024 10:37:32 -0800 (PST)
Received: from ?IPV6:2a02:3100:a557:e100:45f4:697f:1405:21be? (dynamic-2a02-3100-a557-e100-45f4-697f-1405-21be.310.pool.telefonica.de. [2a02:3100:a557:e100:45f4:697f:1405:21be])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aa20e046cbfsm329771866b.162.2024.11.16.10.37.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Nov 2024 10:37:31 -0800 (PST)
Message-ID: <a9ef58a2-62d8-4122-be04-d7e61a63f16f@gmail.com>
Date: Sat, 16 Nov 2024 19:37:29 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net] net: phy: ensure that genphy_c45_an_config_eee_aneg()
 sees new value of phydev->eee_cfg.eee_enabled
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
To: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 David Miller <davem@davemloft.net>, Russell King
 <rmk+kernel@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This is a follow-up to 41ffcd95015f ("net: phy: fix phylib's dual
eee_enabled") and resolves an issue with genphy_c45_an_config_eee_aneg()
(called from genphy_c45_ethtool_set_eee) not seeing the new value of
phydev->eee_cfg.eee_enabled.

Fixes: 49168d1980e2 ("net: phy: Add phy_support_eee() indicating MAC support EEE")
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/phy.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 8876f3673..7f6594a66 100644
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
@@ -1706,18 +1705,23 @@ static void phy_ethtool_set_eee_noneg(struct phy_device *phydev,
  */
 int phy_ethtool_set_eee(struct phy_device *phydev, struct ethtool_keee *data)
 {
+	struct eee_config old_cfg;
 	int ret;
 
 	if (!phydev->drv)
 		return -EIO;
 
 	mutex_lock(&phydev->lock);
+
+	old_cfg = phydev->eee_cfg;
+	eee_to_eeecfg(&phydev->eee_cfg, data);
+
 	ret = genphy_c45_ethtool_set_eee(phydev, data);
-	if (ret >= 0) {
-		if (ret == 0)
-			phy_ethtool_set_eee_noneg(phydev, data);
-		eee_to_eeecfg(&phydev->eee_cfg, data);
-	}
+	if (ret == 0)
+		phy_ethtool_set_eee_noneg(phydev, data);
+	else if (ret < 0)
+		phydev->eee_cfg = old_cfg;
+
 	mutex_unlock(&phydev->lock);
 
 	return ret < 0 ? ret : 0;
-- 
2.47.0


