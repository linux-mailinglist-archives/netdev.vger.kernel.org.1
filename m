Return-Path: <netdev+bounces-157396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D68A1A0A227
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 10:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D23A4169B9D
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 09:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E02B186E52;
	Sat, 11 Jan 2025 09:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BaexYEFP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F4524B22C
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 09:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736586740; cv=none; b=oSZtskbeu3IBGSS6qIyneLFOlIO8+8YwHfbqhJaMrOCbE98N59UWY+Juy1x2k0w6MugJyNWc7eHOPyeKz905QM/Ruy+wZXaFf3ycEhnEAcUPAjZSmNc7jtE0xS15Jx6//OmfLo9CSdkyWT9tdX66uQDrAZ0oO0+pTU6O1aT8Tyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736586740; c=relaxed/simple;
	bh=y8ouLE6cmmU99pdCwRAvS+I6FMygU1y65pjLmuDDNQU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=VP2PA2uGLFDOUs71ilTZq+VClZdvU7a1oDptv8opdNAei0Mg1ATsR5b/SMPddwEGChu2sUm6SKB59dEkkNe25OaLvElcrt7fN0IAl5i7rPAvyjKpH3BOa0MLQtB2oh3YuwgCBH/5Wtrwrk1jF0i9Xpqkx8fZ9dgNRn5nrbPEprM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BaexYEFP; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaeecbb7309so518613166b.0
        for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 01:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736586737; x=1737191537; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=U+idbRyV9sdQR+SeiUkdNzw9KezYm3bCJqa2mqqjPlY=;
        b=BaexYEFP9zcXicDspRZZinarRx4Uc/zwnt8B+0AiP7LhNx9iROPJV0gfctm+lBQyiL
         5KHAm/gBxtvc4xXeHXcbj5U3p3NDVbCYcRNCIttKsligxllNLba8PtUw+iu5WSdQhFGP
         POr+7aVXYde21IPRfKubiu8oN+aqNnUWoYuHKThxcc4e+7UGq44TFv+uxnQc9jzR7aQh
         aK7blHRngnICHE0qI+5Q7wGjqrkFunDPu1wPZqihFkBkk3hnj4VY3Qf6/ZKGNprMYxBq
         Bubbc8tpMDZcgdrHj/VIOWwRYJDIB3j58T8zkNYCLDpM9x3RFlqkmkFFC+ruK4zw5SmX
         HShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736586737; x=1737191537;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U+idbRyV9sdQR+SeiUkdNzw9KezYm3bCJqa2mqqjPlY=;
        b=SYjf+M+SK9z1f4iOZ2Mg9a3D/g2bcNJ0N1aj2oBJb6atk4QtA2lHWzqrYuaDBjmjXU
         IkxbS3KWDr9Wop8ep2kNl7qCapMPFwkk/y4YlWJAm/Y/8q3tskGCf6a79gia3c3AoJx5
         YQbBKNpkXz7R+rg4/c//7f5QWStn+ULUnASQ1UGvqNE7nqGNZ5oRsFzZwM1gaVnc1pw2
         L+vpm/5CnhXhgryLtv+hN4RS4UTBfCM6thdzBpmEvaM7qNuEcZltMfLzVpv98SnTAuPI
         Rj5g/F5V899qE9zPGUXWIm3r5Chq5bsQufTI/YRjKi3jN/luVd8/oB0JsK54AzjV4ab9
         3tRQ==
X-Gm-Message-State: AOJu0YxT8TYLZoAVkpS9ifdV+YLd5+O7926kNCzsiuEAcz0vxaQF5Ud8
	uMfFloZ1JvsJhJ8fok1gYAMZjyOzBJ1FGpqq/f3iFzeshKpMKEEw
X-Gm-Gg: ASbGnctNTF0TpOMslJA+xPvlXbXrDi1mdaCN5BpJt/w5L165RYpnp9NSDL4QXfIJ+wI
	B2pq/6Ck5l7W2CR7+vk/xg9Mm6tQmI++/IXbpmXAJg8ZOd3no6TcSI/0y3O+KXO01qF4zph9g5L
	bXh4WCQv2MUHlENRaDFRDrQcHpGtDOEXw81y3QK/igkkQuf+LZJ6mQz71ztI5Y789DFrutN2SmQ
	pSGXsuK2ekgEZySoU4DEEIgBe5NflajFu8MBRY9HBC70Meh8fD1BKWPchtuZs8AK/TtLTky2MjL
	FxP/gHN1/JzyNh3W0dIR3AozYtb1KT+0sGoYsPc+RYiRCF6Z4nMfRvkB/G7i4wdiAV3IB3n42Ji
	bc6cP+TPt3+jr1nxaLeQ+rUtBKKRM5Vs8UO+9Us9CR080EPh7
X-Google-Smtp-Source: AGHT+IE5T+aBFK3GughzDow54OsnS9MTqPtocZehLcuoHHRLS2x3/O57pKcEMy9moAgsmeX+n2uzXw==
X-Received: by 2002:a17:907:1c2a:b0:aa6:8e9e:1b5 with SMTP id a640c23a62f3a-ab2ab6a8530mr1076251266b.3.1736586736848;
        Sat, 11 Jan 2025 01:12:16 -0800 (PST)
Received: from ?IPV6:2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd? (dynamic-2a02-3100-a90d-e100-d8f1-2ffc-4f48-89fd.310.pool.telefonica.de. [2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab2c912f165sm251355866b.83.2025.01.11.01.12.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jan 2025 01:12:16 -0800 (PST)
Message-ID: <71a87ec2-5fd3-4edd-afa3-0253ff698fdd@gmail.com>
Date: Sat, 11 Jan 2025 10:12:17 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 9/9] net: phy: c45: remove local advertisement
 parameter from genphy_c45_eee_is_active
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <a002914f-8dc7-4284-bc37-724909af9160@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <a002914f-8dc7-4284-bc37-724909af9160@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

After the last user has gone, we can remove the local advertisement
parameter from genphy_c45_eee_is_active.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/phy-c45.c | 31 +++++++++----------------------
 drivers/net/phy/phy.c     |  4 ++--
 include/linux/phy.h       |  3 +--
 3 files changed, 12 insertions(+), 26 deletions(-)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 6d05aef5f..7dd113df0 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -1464,42 +1464,29 @@ EXPORT_SYMBOL_GPL(genphy_c45_plca_get_status);
 /**
  * genphy_c45_eee_is_active - get EEE status
  * @phydev: target phy_device struct
- * @adv: variable to store advertised linkmodes
  * @lp: variable to store LP advertised linkmodes
  *
- * Description: this function will read local and link partner PHY
- * advertisements. Compare them return current EEE state.
+ * Description: this function will read link partner PHY advertisement
+ * and compare it to local advertisement to return current EEE state.
  */
-int genphy_c45_eee_is_active(struct phy_device *phydev, unsigned long *adv,
-			     unsigned long *lp)
+int genphy_c45_eee_is_active(struct phy_device *phydev, unsigned long *lp)
 {
-	__ETHTOOL_DECLARE_LINK_MODE_MASK(tmp_adv) = {};
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(tmp_lp) = {};
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(common);
-	bool eee_active;
 	int ret;
 
-	ret = genphy_c45_read_eee_adv(phydev, tmp_adv);
-	if (ret)
-		return ret;
-
 	ret = genphy_c45_read_eee_lpa(phydev, tmp_lp);
 	if (ret)
 		return ret;
 
-	linkmode_and(common, tmp_adv, tmp_lp);
-	if (!linkmode_empty(tmp_adv) && !linkmode_empty(common))
-		eee_active = phy_check_valid(phydev->speed, phydev->duplex,
-					     common);
-	else
-		eee_active = false;
-
-	if (adv)
-		linkmode_copy(adv, tmp_adv);
 	if (lp)
 		linkmode_copy(lp, tmp_lp);
 
-	return eee_active;
+	linkmode_and(common, phydev->advertising_eee, tmp_lp);
+	if (linkmode_empty(common))
+		return 0;
+
+	return phy_check_valid(phydev->speed, phydev->duplex, common);
 }
 EXPORT_SYMBOL(genphy_c45_eee_is_active);
 
@@ -1516,7 +1503,7 @@ int genphy_c45_ethtool_get_eee(struct phy_device *phydev,
 {
 	int ret;
 
-	ret = genphy_c45_eee_is_active(phydev, NULL, data->lp_advertised);
+	ret = genphy_c45_eee_is_active(phydev, data->lp_advertised);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index e4b04cdaa..5812a3f12 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -988,7 +988,7 @@ static int phy_check_link_status(struct phy_device *phydev)
 	if (phydev->link && phydev->state != PHY_RUNNING) {
 		phy_check_downshift(phydev);
 		phydev->state = PHY_RUNNING;
-		err = genphy_c45_eee_is_active(phydev, NULL, NULL);
+		err = genphy_c45_eee_is_active(phydev, NULL);
 		phydev->eee_active = err > 0;
 		phydev->enable_tx_lpi = phydev->eee_cfg.tx_lpi_enabled &&
 					phydev->eee_active;
@@ -1657,7 +1657,7 @@ int phy_init_eee(struct phy_device *phydev, bool clk_stop_enable)
 	if (!phydev->drv)
 		return -EIO;
 
-	ret = genphy_c45_eee_is_active(phydev, NULL, NULL);
+	ret = genphy_c45_eee_is_active(phydev, NULL);
 	if (ret < 0)
 		return ret;
 	if (!ret)
diff --git a/include/linux/phy.h b/include/linux/phy.h
index fce29aaa9..5a6dcbd8e 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2016,8 +2016,7 @@ int genphy_c45_plca_set_cfg(struct phy_device *phydev,
 			    const struct phy_plca_cfg *plca_cfg);
 int genphy_c45_plca_get_status(struct phy_device *phydev,
 			       struct phy_plca_status *plca_st);
-int genphy_c45_eee_is_active(struct phy_device *phydev, unsigned long *adv,
-			     unsigned long *lp);
+int genphy_c45_eee_is_active(struct phy_device *phydev, unsigned long *lp);
 int genphy_c45_ethtool_get_eee(struct phy_device *phydev,
 			       struct ethtool_keee *data);
 int genphy_c45_ethtool_set_eee(struct phy_device *phydev,
-- 
2.47.1



