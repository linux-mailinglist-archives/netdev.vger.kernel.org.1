Return-Path: <netdev+bounces-157388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D63A0A21C
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 10:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BF8A188C21D
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 09:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708D415445D;
	Sat, 11 Jan 2025 09:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHiXk11L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD4224B259
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 09:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736586189; cv=none; b=huOe73UxWumiqPfKF8F5C9NPg75g/nQJClX1AR4lWi4Hp9MVHgJPSoHLfzbBF7eaXFVm0fNXBFqUkbWuQtW+2oGiAerXdgKiBNRnE5h40ji+CCn4SofZgmt9lgGrOCwO7lxEPyxo0IJNXoYJTRaFLdu22+W/zOz9sTLBi+lhOvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736586189; c=relaxed/simple;
	bh=Cf7M+ZMP4gSExHOq6C5BklT7emUjrLT48BvByhJ+frY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=WAw+elQprWIl0PPwIPBPH+3wC7Yakfad9B81+z7L4kZqYRbAwopz5DVNe6dDrYq4+gGLuPOZrvQSikrN+nGIMv0AiQ2eUn5VmKH+Zc3cG3ZVkGaAljCkWb0ZJLQvhQUfxnfiEYLq8qr0fk36cGU6jMb7FE5Q+UAO7l6JyIpZfi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHiXk11L; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa6c0dbce1fso383422966b.2
        for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 01:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736586186; x=1737190986; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+CM5019PVqbCfLD5uBLhFM7h6xi0D3irHgnC4Bb8RcA=;
        b=aHiXk11L1ltGdZBbCAoJRifZ5AW722E/UTjAEVeci0/YYuor8f1mFcID6LZljRgyXF
         bCG8X+1cJ+YzAGZtY8kBGBi7StogmEUh8gi0NRQGo+8PVEH5m14rk01TuqXeA2PnTsLM
         POwcqtvIKHpzkSctI3h6n27ETbDiyPF4ljTTpLN75nyqngsoAq8gOs3bH6yxkKWDDUga
         QQBnR2X6NpWsjHkTRKbwZMe5YrU2ZEzIaZ9dlebUT4qmP2+km9fj4kgMMJBEM6Fe5PGB
         1McmXyWNWvOVJhqke9UyqpI/svavLfeUbqnJWQJejqwp8eCkUfCU4R3rmbWIHOOkF2zO
         lm1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736586186; x=1737190986;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+CM5019PVqbCfLD5uBLhFM7h6xi0D3irHgnC4Bb8RcA=;
        b=rRNf9f0NZ1FXD1xB25bMzpWYnX/Cy/teeh+rUspiqim39in6rbvJ5qZCYYlVE5pGft
         /IWX/RNHjkk7H6qnvFFM+oWVeYAdnX5dR5e2Adjcry8GWRj2iJ2sUIT/2F/mZGoBqGAV
         g4PdEriwySs7wZH694vaIjuswPc8OVHc9dMvz0cyJmOeuFUcBK6r8CUgVWW4z/xkctXA
         CzBUep4Ws34YpDf4eYV0cKj0q4nG3akbcuAwzGnIubF0DpQLyQ6X9WusV3EciXpdm8qb
         nGPqaZBTcIkHSSxy+JzlSApY0k6Y3DgddeBkI75ihZ0Qj0P3gf6GAR830b7y0tzNqX1u
         pRtA==
X-Gm-Message-State: AOJu0Yyt+8gVvjla93yqdkmPZMUkRWOX1URmtgvIex9gPRrYrOLOLIHU
	0IIi7cEtpkwPXplU0UBClFV39SmI+aT0D6cWqM2wZVeFAc5E7IRE
X-Gm-Gg: ASbGncv6Bg83LWkBSDzGT82yHIrTQlPtfjkzG5eyphGZHI33u8spf5Hmlfo3pIw1oSq
	AcrpIRslBgQ3PBsDbSfEWNG7TZV6ZA/CA1AQAnMcqs52XNA0V1mJZiLukbiTAHQV61zYDlmIkjM
	AWwfn2qxh6aDfY4w5ou5XeUhqVYZSqrZAw3M9UcSJGR12VVQ0NrCuY1/3OJfskk4BGiuE6tNpTV
	ZyXnTwmJVJykvSXQGbVUPUveSvV7qlL9aSTsvvmMuPuYcfM6pWkbDjhpP3Cp0LnSSeaPN2cNXvl
	ruMyRgGItDJFXkP5UYcZICyvUQInEkTrPifoQZHlXi1rmX/1sF/GvnqMVsKhAVZtyo4XfXDgDzy
	rGg2SA/KDcPMH3uJO8wDVCfx6WZmnYQteEOBOdgWDYAVHhs5d
X-Google-Smtp-Source: AGHT+IGZ8yDFCJ5GKDLhn7nTSykmsS+FFOMd5xV3rXptc2PW9mDfRht8nFauw9JIuUM3PdkTG92kjg==
X-Received: by 2002:a05:6402:50d4:b0:5d0:9054:b119 with SMTP id 4fb4d7f45d1cf-5d972e63dd4mr29058014a12.21.1736586185702;
        Sat, 11 Jan 2025 01:03:05 -0800 (PST)
Received: from ?IPV6:2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd? (dynamic-2a02-3100-a90d-e100-d8f1-2ffc-4f48-89fd.310.pool.telefonica.de. [2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab2c956488dsm252001266b.109.2025.01.11.01.02.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jan 2025 01:03:04 -0800 (PST)
Message-ID: <64d6848e-ff0c-49c7-b4e1-6d43752c854f@gmail.com>
Date: Sat, 11 Jan 2025 10:02:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 1/9] net: phy: rename eee_broken_modes to
 eee_disabled_modes
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

This bitmap is used also if the MAC doesn't support an EEE mode.
So the mode isn't necessarily broken in the PHY. Therefore rename
the bitmap.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/phy-c45.c    | 2 +-
 drivers/net/phy/phy-core.c   | 2 +-
 drivers/net/phy/phy_device.c | 2 +-
 include/linux/phy.h          | 6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 0dac08e85..468d24611 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -686,7 +686,7 @@ static int genphy_c45_write_eee_adv(struct phy_device *phydev,
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(tmp);
 	int val, changed = 0;
 
-	linkmode_andnot(tmp, adv, phydev->eee_broken_modes);
+	linkmode_andnot(tmp, adv, phydev->eee_disabled_modes);
 
 	if (linkmode_intersects(phydev->supported_eee, PHY_EEE_CAP1_FEATURES)) {
 		val = linkmode_to_mii_eee_cap1_t(tmp);
diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index 6bf3ec985..beeb0ef2f 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -388,7 +388,7 @@ void of_set_phy_supported(struct phy_device *phydev)
 void of_set_phy_eee_broken(struct phy_device *phydev)
 {
 	struct device_node *node = phydev->mdio.dev.of_node;
-	unsigned long *modes = phydev->eee_broken_modes;
+	unsigned long *modes = phydev->eee_disabled_modes;
 
 	if (!IS_ENABLED(CONFIG_OF_MDIO) || !node)
 		return;
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index bdc997f59..f6a5f986f 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3016,7 +3016,7 @@ void phy_disable_eee(struct phy_device *phydev)
 	phydev->eee_cfg.tx_lpi_enabled = false;
 	phydev->eee_cfg.eee_enabled = false;
 	/* don't let userspace re-enable EEE advertisement */
-	linkmode_fill(phydev->eee_broken_modes);
+	linkmode_fill(phydev->eee_disabled_modes);
 }
 EXPORT_SYMBOL_GPL(phy_disable_eee);
 
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 5bc71d599..c5dc2dbf0 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -629,7 +629,7 @@ struct macsec_ops;
  * @eee_cfg: User configuration of EEE
  * @lp_advertising: Current link partner advertised linkmodes
  * @host_interfaces: PHY interface modes supported by host
- * @eee_broken_modes: Energy efficient ethernet modes which should be prohibited
+ * @eee_disabled_modes: Energy efficient ethernet modes not to be advertised
  * @autoneg: Flag autoneg being used
  * @rate_matching: Current rate matching mode
  * @link: Current link state
@@ -745,7 +745,7 @@ struct phy_device {
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported_eee);
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(advertising_eee);
 	/* Energy efficient ethernet modes which should be prohibited */
-	__ETHTOOL_DECLARE_LINK_MODE_MASK(eee_broken_modes);
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(eee_disabled_modes);
 	bool enable_tx_lpi;
 	bool eee_active;
 	struct eee_config eee_cfg;
@@ -1324,7 +1324,7 @@ int phy_speed_down_core(struct phy_device *phydev);
  */
 static inline void phy_set_eee_broken(struct phy_device *phydev, u32 link_mode)
 {
-	linkmode_set_bit(link_mode, phydev->eee_broken_modes);
+	linkmode_set_bit(link_mode, phydev->eee_disabled_modes);
 }
 
 /**
-- 
2.47.1



