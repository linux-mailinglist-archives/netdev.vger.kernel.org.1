Return-Path: <netdev+bounces-157544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7C3A0A9A3
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 14:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12A26166E76
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 13:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8D31B6CE1;
	Sun, 12 Jan 2025 13:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mldbl9r3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8692C175BF
	for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 13:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736688848; cv=none; b=nDXk7M2Hu4tvi9q04hHyMfYLKa2vzi2F7ysbrJXv1AMQJYuVdgILb6Q64h5sPQviGBDyuZuozLU1fXkFZBOyh3LfTMrKTetp5xpOLydHzZjICVOBNSYSxZIAfVd3GZrXCxn0Ry1f02tTzk9X1XEWWr+Ge6dXQM42V40332JeOCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736688848; c=relaxed/simple;
	bh=kCvjZJzWCBRswqz6ulY8ze+LqU3T9Eo4PllDqIZSTCQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=UDvqTr5CqE3huZANU49RztEbpS7ophkso+14M9mRBEYfN8CbcrtrUyKCZuQOu7HBo1przyZt6OVWuEJR1jNsOTlKUlpo+TyVrxkxkkTNsf9J8o7+S6nPp2kWlyCQ5X4NKCP4xGb4QqMNLrie3gWjkcS0FtEFFc8ZpO2BXzcZees=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mldbl9r3; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3862b40a6e0so1873244f8f.0
        for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 05:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736688845; x=1737293645; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4I/tkVfVax/I3gN2LyIMTHEdHpZTVBkCkQk81ZWjuvs=;
        b=Mldbl9r3zdefBgZkuE/vzpjCJ4fbpX2W030qES3IrsyIzb6oM3I3QMWOTUeyoMAChz
         gPAWv4bgI5ndPi7P3HieQzcueV9E+tgDJthYDoKO5Uhce1srqWY4J2EENvhiKT096yzB
         MqDEEtpbX9mh4aiW1NLJAGIxJOx17em0TF8JmaYoXnJvduU6iwbnQen+9xiS95BWBjOd
         j8SqetgaZIzZbe3IQs7w4t5nGifOwl3T4ydG0ktuGOxnWP7lEKliib3Ky+/pCIwgn20X
         YUVocLu9xxj5j9M172WnWsKiX95njazo2PFumAzaGl1wCu4TKzU1aHd+OhE0Vz9q0hVv
         Sr3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736688845; x=1737293645;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4I/tkVfVax/I3gN2LyIMTHEdHpZTVBkCkQk81ZWjuvs=;
        b=UqWD1V+Hs4ABl5054htAf7wrnR2tjwikb+cYJJXFm2ob+n2MyD4Gjt7bXbxFMjXw+a
         bAmBOf7qOKm66ctvuoje76SclDcWOOut53JYRl+YeHoTQKUYARfgtpSeHZ3XEQL61AFS
         i7NMCALGUXXdJ04FYbH9w1OR2fxULM+iepFOTkd6gwTmR1FmImP3NSjc/0TnTuacsGfo
         k8P6snHEUFprkq0iKHHTBtJFIHWDkEotHxnkKnLycFCNMer3Y3qc9CDqWun8VUPhGCQ4
         TBF5r+RzgyxV4o23qGvPy+n3xLdW/NeOj7/QyVJ5iSatzqbFGNeNG4XaHgQWOoF+maIH
         df6w==
X-Gm-Message-State: AOJu0YzRM+x0Bg3M6OoYrSrWIHadMhf8C+q69ToEf7tMAiNcKgjymoiT
	mQrMAHHoY7RPK9jm9GoeqawX2JZ4RLQVDUvGkAuD7GsRm1zcNH68
X-Gm-Gg: ASbGncts6nK1ebmwj6ARScP1MLy23gpFxNpYWo+r2bx7jQW6ChOjwYPbGrtJQAwE8FR
	dgy7liyh9wrtEk9BvMigNR4n90Ys9UHrYAqduzbcbp+AVIeFEA+4luBTA9KrfdfO44TvmExDXWj
	SO2DXO3zaSpNUpJVyxTLSTQPQk9z0DUYG2Y7TJSBFeoybrd5D++UdyLHxHjoGh4m6DYbsi4lokn
	7Ce9Lo5+jEt+x+IxlHPNSHN+zT07+DgNm2JjVSYwf6gUro/V7bsYgCat2we9oQr34wecCdObFEu
	lnHKq4Vfa4XVD4imrCVa89RU/GtvJNXRsV9L8S2VJXK06DuZO/Ku/XlGr903pP9knl1iDwgX5+t
	KW5IDLpU0KbOt8rLIliD9xzu4yAHttI9MkXsl/FsvFiDQrXOv
X-Google-Smtp-Source: AGHT+IFisLCkInUwsueYFxunBOrDi2C+MdL9c2fFZqzk7pfXHC6iLlDdehdJD7JPc9Z2Rzq/HHUAkg==
X-Received: by 2002:a05:6000:1566:b0:385:f1f2:13f1 with SMTP id ffacd0b85a97d-38a87303e62mr15293880f8f.22.1736688844742;
        Sun, 12 Jan 2025 05:34:04 -0800 (PST)
Received: from ?IPV6:2a02:3100:b0d5:ab00:44ab:526d:76d3:604a? (dynamic-2a02-3100-b0d5-ab00-44ab-526d-76d3-604a.310.pool.telefonica.de. [2a02:3100:b0d5:ab00:44ab:526d:76d3:604a])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-436e9d8faa5sm113558825e9.1.2025.01.12.05.34.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jan 2025 05:34:04 -0800 (PST)
Message-ID: <b674e60e-a638-4b8c-88f8-3f6b019b158a@gmail.com>
Date: Sun, 12 Jan 2025 14:34:03 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v3 10/10] net: phy: c45: remove local advertisement
 parameter from genphy_c45_eee_is_active
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <5e36223a-ee52-4dff-93d5-84dbf49187b5@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <5e36223a-ee52-4dff-93d5-84dbf49187b5@gmail.com>
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
index 0fb5e20f3..9f2d8987c 100644
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



