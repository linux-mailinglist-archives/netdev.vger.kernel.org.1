Return-Path: <netdev+bounces-240814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 745D3C7AE59
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 17:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3E1C14ED5FD
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 16:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC192E7165;
	Fri, 21 Nov 2025 16:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1fM2/vX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE8D2E9757
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 16:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763743207; cv=none; b=T4T35fAgzy/CBoTDpMT/mAF4tE4MnNkApQ4wtBK+CMkpQHxCLAhEq07eCxT/MT5Q1p4FpLzlif9cIsYVdNu7ZqBiOMwicNQ7cUtp6K8BOCqcx8WV9+SeR4To8L1ffEJED3i3z/RTHjQqFDqbIHFmp/lahFwe3/A8erw/mnHDUeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763743207; c=relaxed/simple;
	bh=JU8bswAzoTbbdhtSYCsCJMKTaaHsAd5LttsoA2TtsjM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BJrqFXLafBNNAsUMPCoUIIy0ygreDHkxACIWWMAVdTel276zeYhgil8d9LDwzIJDK8bCoPRfikBCeZKpBLsqXDBn6VYNmWjgK0sIeWIQxN95atNSaJT4ggI7TrKG/yn/3nbUPzMo9fUFOC2QXt+cJL21xtobugEFLfV+EmBf6qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X1fM2/vX; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-298456bb53aso27100275ad.0
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 08:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763743204; x=1764348004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EWcIbQMIxAMCsObT8R6vBndTpbH9PYOfF1CFBF/9I/g=;
        b=X1fM2/vX5eNSj6DE6kE2k9pzfnEXQ5e/+kfE8yvs6H0yxPwUIheru+bMi9frRC7txp
         EtlKKgWmEE3++v+8F1COfkQdy9zQ15wwpSkU1/Qw/8nQSDfcY9BQy09AkqXQc8vBHQ3N
         vATglCqf1mSjXiKp372fm8o+5fxuIavIevbzd99STGwBxBGmNc7AS+MACRQDP8ZJg5AC
         T7MbYeKkbWE5M+64J+Y9fm+q1eSFvXXfv9IzHYx8jVkhATNTUCkSj1JT1axIrlp9SBc7
         g9aYpXFAwIlhcGyykJLxNmm0VGwHGNlysJoWV1MjyJimBvwvuZ8kX8dsM1f3TdXZ1DSs
         5rkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763743204; x=1764348004;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EWcIbQMIxAMCsObT8R6vBndTpbH9PYOfF1CFBF/9I/g=;
        b=XZRKoP0FQa1R4rGWSBoO8IbTxxB2RRJmMryf5UiGTV79lDy7ospieB2MB1meGMwLaO
         731ZJdC/W6or8afvz2WdOzrhtDfN0vkslH+UA1nD0gbvQq3CfejJJgoZrkbCaoSpEx9i
         SbZU8cTWBNXe1OUFbGi2ZfH84OgICYwiXOjini7iQ1dfBeQdq09l9Da/Tr32zWzRtkbQ
         sG1o7+5QMos+OawJA5BYBtENr58/Yn8vCo2I6a9gylN3EhNiOwaxoJwX4W4Q5azcm5Ap
         n2E0P83g8zxYdad55SgABQOTxMRswKsa1hnHtLgTWj8vyg6t0Q5zv8dPuevDIxQl8G5A
         zC9w==
X-Gm-Message-State: AOJu0YzFhoj9/7zu7ml658b0KlYxtNrWeo2ZD0I7J4Yt1VmrnIQu8L9/
	hA0ubQCVbCUvYF5ZIZ65CH6xN8g8BWKigX0WdRYMb2RdqhUpZWrEL2+f5e+epw==
X-Gm-Gg: ASbGncvDFykDcaeTHpyZwK+vR/NKFVHkxLVsvKlck4og/hq78e+RwLR0sYnL3POVBAJ
	X4sS9sbcrabia5oZm4zFvDhpG/0CzyvLBfH4I2sYv7nXIgF5liN9ENJzqTt7j5tvsMsas9xqvvs
	nK7rjuQuN4AAlWGB4ouF/kKFgb48xjPPXlWz791OT3SHdKch2n9Rb69f3QzLEif5Fp08Ny7X3y3
	RMzXRZaihPkcvvIg9NrG4LIwU9cJuO8U7mgU9u4pkTwD56EJwfmLMioLoX+MW3HeAgAFAXPi5Bl
	UPnO51sawLtwuJ7lv2vfblvCVA/0XiWEu/BA2lMPulh/o9hdo0JlJ28rBJQN3WxL+QSoZ0SE79c
	nKqr3u34IYCqv3g/D80wylVB9RnU6r6BTpqTp71ntpFmkSOrFbyJc2bVwtBkCYbVeVd3PSmOIyz
	3esNQiPsC9vcn76KuP/YY9N+DyHDPsTq9ClLJ7Yzg5aa7Q
X-Google-Smtp-Source: AGHT+IG0T8oO6A7MCaTT+idDDT/PmNa51xb8Vb2CuZSDEsTWWRwTPuqzloZ/yHAOE2VxBAh0D2y6HQ==
X-Received: by 2002:a17:903:11d1:b0:273:ab5f:a507 with SMTP id d9443c01a7336-29b6c405de9mr33679845ad.21.1763743203949;
        Fri, 21 Nov 2025 08:40:03 -0800 (PST)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b12d07esm60520225ad.26.2025.11.21.08.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 08:40:03 -0800 (PST)
Subject: [net-next PATCH v5 2/9] net: pcs: xpcs: Add support for 25G, 50G,
 and 100G interfaces
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, pabeni@redhat.com,
 davem@davemloft.net
Date: Fri, 21 Nov 2025 08:40:02 -0800
Message-ID: 
 <176374320248.959489.11649590675011158859.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <176374310349.959489.838154632023183753.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <176374310349.959489.838154632023183753.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

With this change we are adding support for 25G, 50G, and 100G interface
types to the XPCS driver. This had supposedly been enabled with the
addition of XLGMII but I don't see any capability for configuration there
so I suspect it may need to be refactored in the future.

With this change we can enable the XPCS driver with the selected interface
and it should be able to detect link, speed, and report the link status to
the phylink interface.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/pcs/pcs-xpcs.c |  105 ++++++++++++++++++++++++++++++++++++++++++--
 include/uapi/linux/mdio.h  |    6 +++
 2 files changed, 107 insertions(+), 4 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 3d1bd5aac093..9fb9d4fd2a5b 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -37,6 +37,16 @@ static const int xpcs_10gkr_features[] = {
 	__ETHTOOL_LINK_MODE_MASK_NBITS,
 };
 
+static const int xpcs_25gbaser_features[] = {
+	ETHTOOL_LINK_MODE_MII_BIT,
+	ETHTOOL_LINK_MODE_Pause_BIT,
+	ETHTOOL_LINK_MODE_Asym_Pause_BIT,
+	ETHTOOL_LINK_MODE_25000baseCR_Full_BIT,
+	ETHTOOL_LINK_MODE_25000baseKR_Full_BIT,
+	ETHTOOL_LINK_MODE_25000baseSR_Full_BIT,
+	__ETHTOOL_LINK_MODE_MASK_NBITS,
+};
+
 static const int xpcs_xlgmii_features[] = {
 	ETHTOOL_LINK_MODE_Pause_BIT,
 	ETHTOOL_LINK_MODE_Asym_Pause_BIT,
@@ -67,6 +77,40 @@ static const int xpcs_xlgmii_features[] = {
 	__ETHTOOL_LINK_MODE_MASK_NBITS,
 };
 
+static const int xpcs_50gbaser_features[] = {
+	ETHTOOL_LINK_MODE_MII_BIT,
+	ETHTOOL_LINK_MODE_Pause_BIT,
+	ETHTOOL_LINK_MODE_Asym_Pause_BIT,
+	ETHTOOL_LINK_MODE_50000baseKR_Full_BIT,
+	ETHTOOL_LINK_MODE_50000baseSR_Full_BIT,
+	ETHTOOL_LINK_MODE_50000baseCR_Full_BIT,
+	ETHTOOL_LINK_MODE_50000baseLR_ER_FR_Full_BIT,
+	ETHTOOL_LINK_MODE_50000baseDR_Full_BIT,
+	__ETHTOOL_LINK_MODE_MASK_NBITS,
+};
+
+static const int xpcs_50gbaser2_features[] = {
+	ETHTOOL_LINK_MODE_MII_BIT,
+	ETHTOOL_LINK_MODE_Pause_BIT,
+	ETHTOOL_LINK_MODE_Asym_Pause_BIT,
+	ETHTOOL_LINK_MODE_50000baseCR2_Full_BIT,
+	ETHTOOL_LINK_MODE_50000baseKR2_Full_BIT,
+	ETHTOOL_LINK_MODE_50000baseSR2_Full_BIT,
+	__ETHTOOL_LINK_MODE_MASK_NBITS,
+};
+
+static const int xpcs_100gbasep_features[] = {
+	ETHTOOL_LINK_MODE_MII_BIT,
+	ETHTOOL_LINK_MODE_Pause_BIT,
+	ETHTOOL_LINK_MODE_Asym_Pause_BIT,
+	ETHTOOL_LINK_MODE_100000baseKR2_Full_BIT,
+	ETHTOOL_LINK_MODE_100000baseSR2_Full_BIT,
+	ETHTOOL_LINK_MODE_100000baseCR2_Full_BIT,
+	ETHTOOL_LINK_MODE_100000baseLR2_ER2_FR2_Full_BIT,
+	ETHTOOL_LINK_MODE_100000baseDR2_Full_BIT,
+	__ETHTOOL_LINK_MODE_MASK_NBITS,
+};
+
 static const int xpcs_10gbaser_features[] = {
 	ETHTOOL_LINK_MODE_Pause_BIT,
 	ETHTOOL_LINK_MODE_Asym_Pause_BIT,
@@ -523,9 +567,38 @@ static int xpcs_get_max_xlgmii_speed(struct dw_xpcs *xpcs,
 	return speed;
 }
 
-static void xpcs_resolve_pma(struct dw_xpcs *xpcs,
-			     struct phylink_link_state *state)
+static int xpcs_c45_read_pcs_speed(struct dw_xpcs *xpcs,
+				   struct phylink_link_state *state)
 {
+	int pcs_ctrl1;
+
+	pcs_ctrl1 = xpcs_read(xpcs, MDIO_MMD_PCS, MDIO_CTRL1);
+	if (pcs_ctrl1 < 0)
+		return pcs_ctrl1;
+
+	switch (pcs_ctrl1 & MDIO_CTRL1_SPEEDSEL) {
+	case MDIO_PCS_CTRL1_SPEED25G:
+		state->speed = SPEED_25000;
+		break;
+	case MDIO_PCS_CTRL1_SPEED50G:
+		state->speed =  SPEED_50000;
+		break;
+	case MDIO_PCS_CTRL1_SPEED100G:
+		state->speed = SPEED_100000;
+		break;
+	default:
+		state->speed = SPEED_UNKNOWN;
+		break;
+	}
+
+	return 0;
+}
+
+static int xpcs_resolve_pma(struct dw_xpcs *xpcs,
+			    struct phylink_link_state *state)
+{
+	int err = 0;
+
 	state->pause = MLO_PAUSE_TX | MLO_PAUSE_RX;
 	state->duplex = DUPLEX_FULL;
 
@@ -536,10 +609,18 @@ static void xpcs_resolve_pma(struct dw_xpcs *xpcs,
 	case PHY_INTERFACE_MODE_XLGMII:
 		state->speed = xpcs_get_max_xlgmii_speed(xpcs, state);
 		break;
+	case PHY_INTERFACE_MODE_100GBASEP:
+	case PHY_INTERFACE_MODE_LAUI:
+	case PHY_INTERFACE_MODE_50GBASER:
+	case PHY_INTERFACE_MODE_25GBASER:
+		err = xpcs_c45_read_pcs_speed(xpcs, state);
+		break;
 	default:
 		state->speed = SPEED_UNKNOWN;
 		break;
 	}
+
+	return err;
 }
 
 static int xpcs_validate(struct phylink_pcs *pcs, unsigned long *supported,
@@ -945,10 +1026,10 @@ static int xpcs_get_state_c73(struct dw_xpcs *xpcs,
 
 		phylink_resolve_c73(state);
 	} else {
-		xpcs_resolve_pma(xpcs, state);
+		ret = xpcs_resolve_pma(xpcs, state);
 	}
 
-	return 0;
+	return ret;
 }
 
 static int xpcs_get_state_c37_sgmii(struct dw_xpcs *xpcs,
@@ -1312,10 +1393,26 @@ static const struct dw_xpcs_compat synopsys_xpcs_compat[] = {
 		.interface = PHY_INTERFACE_MODE_10GKR,
 		.supported = xpcs_10gkr_features,
 		.an_mode = DW_AN_C73,
+	}, {
+		.interface = PHY_INTERFACE_MODE_25GBASER,
+		.supported = xpcs_25gbaser_features,
+		.an_mode = DW_AN_C73,
 	}, {
 		.interface = PHY_INTERFACE_MODE_XLGMII,
 		.supported = xpcs_xlgmii_features,
 		.an_mode = DW_AN_C73,
+	}, {
+		.interface = PHY_INTERFACE_MODE_50GBASER,
+		.supported = xpcs_50gbaser_features,
+		.an_mode = DW_AN_C73,
+	}, {
+		.interface = PHY_INTERFACE_MODE_LAUI,
+		.supported = xpcs_50gbaser2_features,
+		.an_mode = DW_AN_C73,
+	}, {
+		.interface = PHY_INTERFACE_MODE_100GBASEP,
+		.supported = xpcs_100gbasep_features,
+		.an_mode = DW_AN_C73,
 	}, {
 		.interface = PHY_INTERFACE_MODE_10GBASER,
 		.supported = xpcs_10gbaser_features,
diff --git a/include/uapi/linux/mdio.h b/include/uapi/linux/mdio.h
index 9ee6eeae64b8..f23cab33e586 100644
--- a/include/uapi/linux/mdio.h
+++ b/include/uapi/linux/mdio.h
@@ -123,6 +123,12 @@
  */
 #define MDIO_CTRL1_SPEED2_5G		MDIO_PMA_CTRL1_SPEED2_5G
 #define MDIO_CTRL1_SPEED5G		MDIO_PMA_CTRL1_SPEED5G
+/* 100 Gb/s */
+#define MDIO_PCS_CTRL1_SPEED100G	(MDIO_CTRL1_SPEEDSELEXT | 0x10)
+/* 25 Gb/s */
+#define MDIO_PCS_CTRL1_SPEED25G		(MDIO_CTRL1_SPEEDSELEXT | 0x14)
+/* 50 Gb/s */
+#define MDIO_PCS_CTRL1_SPEED50G		(MDIO_CTRL1_SPEEDSELEXT | 0x18)
 /* 2.5 Gb/s */
 #define MDIO_PMA_CTRL1_SPEED2_5G	(MDIO_CTRL1_SPEEDSELEXT | 0x18)
 /* 5 Gb/s */



