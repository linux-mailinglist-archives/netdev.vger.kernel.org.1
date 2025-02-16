Return-Path: <netdev+bounces-166831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3C7A377C1
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 22:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F52D3AFA39
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 21:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50C41A23B5;
	Sun, 16 Feb 2025 21:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYx9gubS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E1C33C5
	for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 21:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739740772; cv=none; b=Ic5RY74MsrItKW27bypUkmlHhorR2yWrLZZUUDVYxAx9r92B5wIPHcgBNM4UCOz8SJlYCDlBomPyvbHDgvip3AOyh/dw3XWG+lOkhRfizGxRb0cWXuzBNHplveTrDOdxuN1R2JKyBmCXechlXf4jac4nA7GC6hIzoh9OumP5ZL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739740772; c=relaxed/simple;
	bh=9/dngdYIy7/C2N20iRWJurUkmjm+MlCVuYP9WhGa0ds=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ioDwmLt3mSBnpv50gpf2wfDwnVP2SHDjN5IWENYby150bStw3GLvnuQDrNn1Fz2zlW4SIqIbMXa4zqDGmGJmTBeBkeA0ZtKC8EcUXpF6BBV4kb4wE0P+VSKoTTPVVW/7s39dP6pk6YCc+0jLN+H6tjKh8XG4L86AKOeHgpodiYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYx9gubS; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4397dff185fso4971615e9.2
        for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 13:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739740769; x=1740345569; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TeZb043BU6d031irSg1MV2e2Etb5JtzR5u+j8mxCroY=;
        b=VYx9gubSx1qNYC3thcOn9BV/XP1iBU9n7EveOb8DPdEkRaLp0HZiydt9+mqKpn6s8O
         CAfzvrs2b2lXVVGbBs1RH9RP+w7+wB8WFLzyeHW7IDbyEdqTCy1prsU6aJYpTYvmo8hk
         kLtGT/SPQRBHbAoZwV74s6aLRk3LHnp8AbOf73EFzkj7fw1RDhr6nLrLRfa+H9ACx3WH
         jlumhdIAOJPDIIJQkUfx+Ck65Kt7dOmY5fRMQZ5Vb+QVtIyN3II+dRBOCrs0kteEsOxN
         NLrc2ztwKhlr4EKecj8qeq+54QxjrMigNTRudVij4RuCP9JKrW5f61vISZgxmh2PrXdJ
         FaJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739740769; x=1740345569;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TeZb043BU6d031irSg1MV2e2Etb5JtzR5u+j8mxCroY=;
        b=mNgrmGbtpaD6cs6+BSqSCuvrYDe+ma86/WbPwcU5eKYp+ks2SjDzTVoMtM/6EyMf85
         VslyNZ+q7ZzOaZIy6t7RhzEMrBQsDXkJjZ1OgJooyJR2E15q5eBFmoe0/M6OWwNDWp9f
         SVaeS7qMCdqAu9pWkjPDIMFXQS5x5HoqnwXzU8mx0XbNXg6ruPKd0+3nqIGp4Nndufmy
         9mJU+Gq/2r7KVwMUaM2UzO8EWE5rff8FPEP2FFl807UnaBmyfcdGCwXwT8Pv5peSfe4G
         0sFTzV1BBEe7qg6UfdgiSqaIQczwTrFcCskW3Bm2QiA8MfeM9pdkctZfR6hrBD5ntuc5
         10QA==
X-Gm-Message-State: AOJu0Yw5G2rjgeXwPX04oqpF0zwyDVOcVRF2/F6ls4BoDamNxcf4qQ41
	qNcW+LikE2y74kAeUHoT8fqyTOvNFeUECVuHSCnsc18DsXraW/H/eZFJxwGU
X-Gm-Gg: ASbGncvg7kGsL+efSqCJx9tao1M24DrFag95igeBlsF3cqvJHpmv+N7/pUQp+DmComN
	t6AQey3pR3NzolS1weSlvtd2o9FmGlHlozgG2hO+7LAVEeQALAR2jGEkpouqNzSj4nC2GQ1+BJn
	66K/InkWy79xwwFRfZvoEV1ZTtcbmenyYIBuJk1no43J1ks1wnk32Gvnu9sYHqVib0x1v5A+G1N
	YjPUPrRNJFaWICJOEHO0RNgHCqLyz6nPgRyB1wvpzhM2ISpSloj1YgKr09NM+q6LokKNEKnMQJi
	0p69zyxOmGxHqaQtd1/ornIIE0IZP84lIJ9NQC7MUA6IjDTvxOCHKnkHOyl49DnXQR7ojKHWL4r
	2lolnirvzrGh7GPggHn/EvYrZuCTONAo97Qg5qQvETYBrOkgbxO58TuqZc3pyyb3WGiJq6LzeKs
	aJAF5Oypk=
X-Google-Smtp-Source: AGHT+IEm0NYI9X2W368/PpzEYly2hpl6+16TYdLiRVR6k9JtxLQdXY3cREwLBICH2zfv8ntQVv0PjQ==
X-Received: by 2002:adf:f205:0:b0:38d:d0ea:b04c with SMTP id ffacd0b85a97d-38f33f43867mr6605767f8f.38.1739740769368;
        Sun, 16 Feb 2025 13:19:29 -0800 (PST)
Received: from ?IPV6:2a02:3100:a14d:c000:1d06:77f1:27f3:ba49? (dynamic-2a02-3100-a14d-c000-1d06-77f1-27f3-ba49.310.pool.telefonica.de. [2a02:3100:a14d:c000:1d06:77f1:27f3:ba49])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38f258b4118sm10753817f8f.18.2025.02.16.13.19.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2025 13:19:28 -0800 (PST)
Message-ID: <bd121330-9e28-4bc8-8422-794bd54d561f@gmail.com>
Date: Sun, 16 Feb 2025 22:20:07 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 6/6] net: phy: c45: remove local advertisement
 parameter from genphy_c45_eee_is_active
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <3caa3151-13ac-44a8-9bb6-20f82563f698@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <3caa3151-13ac-44a8-9bb6-20f82563f698@gmail.com>
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
index fed5fb0ef..37c9a344b 100644
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
index 77b3fb843..b454e31d4 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1031,7 +1031,7 @@ static int phy_check_link_status(struct phy_device *phydev)
 	if (phydev->link && phydev->state != PHY_RUNNING) {
 		phy_check_downshift(phydev);
 		phydev->state = PHY_RUNNING;
-		err = genphy_c45_eee_is_active(phydev, NULL, NULL);
+		err = genphy_c45_eee_is_active(phydev, NULL);
 		phydev->eee_active = err > 0;
 		phydev->enable_tx_lpi = phydev->eee_cfg.tx_lpi_enabled &&
 					phydev->eee_active;
@@ -1761,7 +1761,7 @@ int phy_init_eee(struct phy_device *phydev, bool clk_stop_enable)
 	if (!phydev->drv)
 		return -EIO;
 
-	ret = genphy_c45_eee_is_active(phydev, NULL, NULL);
+	ret = genphy_c45_eee_is_active(phydev, NULL);
 	if (ret < 0)
 		return ret;
 	if (!ret)
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 26a11a0c7..c0f524579 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2022,8 +2022,7 @@ int genphy_c45_plca_set_cfg(struct phy_device *phydev,
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
2.48.1



