Return-Path: <netdev+bounces-157462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 779D7A0A5F0
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 21:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ADC91888B3F
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 20:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD7D1B85F8;
	Sat, 11 Jan 2025 20:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiBsJ5Gd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183DB1B6544
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 20:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736627591; cv=none; b=jVjtJWQBgShnZ3GmzEtfpYrOeBRlKDBkC7sjebdyBziTh3B2/TpDKd8izMCkOOu3butXuC3JSzZ3xHFimJVC2mrseDqhhUB9C5U8HVocnLolCl9zms5UX/4/9CO/zANQcp82dLrSpliAFQGrzLwo3EnIe4iGvUNPEitB/D15lXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736627591; c=relaxed/simple;
	bh=jGtGahYagxy3Gyd77TamWfvzB38Gr40tD223axSqGbs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=UHTUYstcqVYTSHNt+P287IyvuBFfE9MjuZnI+nexvTrPJK1FPVgMYCGXq+YMsjw4YWvyAfwBi5mOURf80YJ2zqBFdB+FsSwnPhc7eMo8TK7hQFxFdK3Rec3kiK8/mWsd7kPRvw1lbHB3BbjefLl6Q+Z2tI8pZ3BFAf4niFolpYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iiBsJ5Gd; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d0d32cd31aso4268681a12.0
        for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 12:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736627588; x=1737232388; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rcgKwGYcM1PuXm8ew0W4bT/c8oWqvFDjfw0FyL4R6ww=;
        b=iiBsJ5Gdd0Wkmhbu2hCXkzJ6cNqt5/VxiOulfSbEodoKrTnt+rP0WAbpHHmdzonnaR
         JqZj/vVXqGed+RqlZVb/XwatDjugTiF9inVlXgFjIChHWIoSXjYbMC8Duj4SqttO7/Dn
         LrCwjWsXSei0RTNKxH5pzW2U+qOO4mFLP1sPHB0othVB0t5xPEK4jgn1/S8Kt4gDaQGK
         tQgibA+ozhWGw54tFVW5LGbHwEkh/gUi1SYqCtaULM8PIYdpspkXJ+wPEjjmhC+4WnSl
         bwpQYZDMjhOjfmjSx4ZSqt4Sr0E2KC3qMZ21qqyRF/whbpRLnkZR62YrOKmAw2JnR2C+
         Vrfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736627588; x=1737232388;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rcgKwGYcM1PuXm8ew0W4bT/c8oWqvFDjfw0FyL4R6ww=;
        b=iEwAkmoNl8vULVxA+0p3Tsfj40E1h/HeROv2PwZLUJtshOMXVYp4DDpBGPwEalpUlD
         0NRV5kjFGonpigog003jRhJdsCu6vUeRiOLXzHl8EnvFoyugGnJ4R1kI2frc5w7ucQCG
         BiBZ0/KGEe/fSFr828wOyrp3RUz43OTmqEIfPwqFqs6fMFZEeOTUQmEdvpOiOmavkxxl
         51nlnRtLJmxSSnOQW77sI0vAhHEguu+ESfFXNAg8kj0/MrTmvP+YP69tvzwIc05Dr8P7
         +NlhXNreLqeQHJ8eTANoYKz/qG+EfIHF/YptZuUBxT7vxyQ0gRFQBjF30b5lItwE3Ty8
         q00Q==
X-Gm-Message-State: AOJu0YwywhVrDHaMEpaJrkSnb4DLgV9zIlndwTCLxO85KR3eCfIccNap
	pFSlvw+UHgpGHkQcUuzAzmPcdLfP+Zs/NoNr+3kQaTIOVvhIDgv0
X-Gm-Gg: ASbGncsL3bfL8MKuuhhxknGfHVl2MtBEg3g5WgV0QTne3N624C76QwCiGUMR105z+nx
	5FqpPY263vRDEVWgXQalMWUcKOkMv5/AHWHGD9vv1wk1DdY3GZj0VjU35CmRuxB+wOt0R018QGJ
	SZJdsFvy2pNtNzM4VLmX7AAWpRk3oLLkgHEuLxZNn2Wcd0GDlA7cALdM0If2DQmsLSy+y9LPRDD
	VuoMFbabVgnQedtOkg3HR3qh9lvnqq1XgNAwNYvE+lPeWbI6NVmhHg8kd5vd7NQTMXXP4uI1AO4
	igZg0zNyZUaJCj8nSMcS6Zz6XVPaWv2LX4W7tOL5MjbI0iPZ9yeeDJ6SXOBPVm/Jo1hP6VVgS7D
	RtIEX8nfJnkUKg8UphkPQlUR+cleqSlaAkxoYapS2koGju8tO
X-Google-Smtp-Source: AGHT+IHGjG5qYYOapbmnFhtb5o+jf9xWlCW8L/tb3qBPfESDc/RC0ZcvXMxmSERTvu4DkHGp4hpydA==
X-Received: by 2002:a05:6402:34c2:b0:5d3:ba42:e9fa with SMTP id 4fb4d7f45d1cf-5d972e1c568mr36775975a12.16.1736627588155;
        Sat, 11 Jan 2025 12:33:08 -0800 (PST)
Received: from ?IPV6:2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd? (dynamic-2a02-3100-a90d-e100-d8f1-2ffc-4f48-89fd.310.pool.telefonica.de. [2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5d9904a4127sm3036106a12.77.2025.01.11.12.33.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jan 2025 12:33:07 -0800 (PST)
Message-ID: <8f2bacfd-b987-40ae-af56-b26d62d2a471@gmail.com>
Date: Sat, 11 Jan 2025 21:33:06 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v2 10/10] net: phy: c45: remove local advertisement
 parameter from genphy_c45_eee_is_active
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <90b3fbda-1cb7-4072-912c-b03bf542dcdb@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <90b3fbda-1cb7-4072-912c-b03bf542dcdb@gmail.com>
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
index 2558b535a..3a62fb546 100644
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



