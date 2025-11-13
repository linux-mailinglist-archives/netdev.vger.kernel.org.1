Return-Path: <netdev+bounces-238442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA3FC58DAC
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 17:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83DCD3AFFA5
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 16:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62BC3590A8;
	Thu, 13 Nov 2025 16:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTuWJOAq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA22346792
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 16:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051599; cv=none; b=HrbIuebwy9XHY45ip3bKknAZxd1+uylghvkmMptq3XWdjqOWFwY2muYIZnkPj9y+RC7SPcvNGWWyGNcYmSaW0+O9LpQRtw3C4LwlDPmaiJdssagd83V80rUeo4URunSa9dqDDZEuCw2CrBsi/s/c5+80eAo1sJ6/ve4TkVYepsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051599; c=relaxed/simple;
	bh=J8abG1C+fsaCdjGbLeXRKseQRAROPqme8NnHBhWaf6s=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TA/x8d9yolqI+KcWXbkwpviDoL4LYsaKp6S8kUE4P5sGYsL8PtoApiGt1fVBuKG0y6lD1xgTrYwecPm1FKgTPZYnvk3TrJXrZ7n5gwxLKhL1ygre0YxoTQTH2vKiJKn5LHD6RWu2GK8nHhnEY8uutdKZ+GF6MvDk2j8fxV+7uWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CTuWJOAq; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7b8eff36e3bso1255419b3a.2
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 08:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763051597; x=1763656397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HGPAVNHD9/u69h16oXu0xtZ9L/p/RZQaMUZjQBKsHgU=;
        b=CTuWJOAqy6zKC6plxhbsWDJqj/oO2b6Cxj6jKbKsI2OUJrJnV6ybLjZK9IVRKKz2zK
         8iX70aM2+r58+OWOyh7iscj1DhFmdcOAexaxoEIvAJ3LSIMlbjPYGGRW2rkKslTjiP1a
         CyN/Ysl3t7yIut1S0e5tKInURbyB1Hls+O5eqpKQWOju3OVYH+qCoJNFTBEaqRC50xH9
         wnVmhXKRDWXnr+qIfe/+o8DMfDrIV8vhKuanoBygAZtvQObGsd3D4f9FlzFyH0smaFrA
         cGfQi8Mt7vD+IJ9Q9WwnAwyLgkoRcY6YPeQdNgG+FqTfnjiKvGZIISYAZRm5eQelIu87
         J39Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763051597; x=1763656397;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HGPAVNHD9/u69h16oXu0xtZ9L/p/RZQaMUZjQBKsHgU=;
        b=eVZ4ExFR3jEhY7Lnq30m60+PC+Ggsh12oEHmJ4irM+CkWmvUJ6TsKCU8rn2B1mtX5i
         pJnUDwWyQBNsr4T+w3Ha3kr4lbtRZpdArL8Gswm5EwiXDy4n9JrUGMR5WB81utBv7Mku
         8P7kxlzRFXxdxlwJJA8hF7/X3irtxtb8cLybblBarI5hsbw6kooUZ5+Hbq2aBfjqqiro
         JLPASjcdupebSG/KAK3/dz+Rw3usi4CyvAvgByKwvi8OdEtgWjFVtZCavackpRa3UNmW
         lRjhgBNKPllazxBxB6W7c13JsEDrA3a3G7rA8/sZ+Qujs4VhKCd89ZVdUGxJ6bwaTgjX
         4s/Q==
X-Gm-Message-State: AOJu0YxOBOFCMcN6YvtxDv0Lub9wtEKE2qjYYCERqc2MMKdS+1PqGIBQ
	i+pxG74ekTzN8UH659vLFx+cVNY7G9W8WpP4UIWkiOSIMyGCpXyji68F
X-Gm-Gg: ASbGnct59rsRc6KoyZqEeRovrPUbQlb9QLkSk+hIvbG+9zBeP+Vash7xu8E5xz5Hxi2
	3nm88Fu+E25C7fd0TREpCBVA1if/30PMWD7/8G2s3SWBnC1f5lap+J+O4gAoVSMMHF8vx4HPmck
	PpytnK/n0fzU1fP7PUTtVmW2CFA3YifP/60G0mvsRPYFYSfcyJH0vtFWBJe9eceqEKZz6GohpkB
	rphiIVLrWlwR5IVi6LoitTSxU2P7sOLjTs6r4ONQ6bCM3eDp7iEn7TM5qIwDH+wcSWn1SA78fdW
	NRIDb/pIvjAIgi794GvPTOjANAMqXJfT7lND7USHMvw8TGDv0d2OnBjsZ7pMkjqbFR7WUrDK7ja
	Q0y4CAOVLMablUcU0iiXgdua+8nGWksHo1lMomhZNy4lFu3QioC0DOTNvEAqnVXNMqWsbnEFlL5
	75UzTW61urqHgIrHG2Ri/9QhALKn+2QWgAQP9Q6eUKxVCaS9Cq+2GT4mE=
X-Google-Smtp-Source: AGHT+IFbW+pjdUCgFvJF7Em3cHWlB3aAirlMG+10ryg0ccgn4W1zyXZvH2ePErfaeFKNNRcYRZd85Q==
X-Received: by 2002:a05:6a20:432c:b0:2b9:9d3c:947a with SMTP id adf61e73a8af0-35b9fa7fae6mr272496637.5.1763051597519;
        Thu, 13 Nov 2025 08:33:17 -0800 (PST)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b924aee147sm2782782b3a.13.2025.11.13.08.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:33:17 -0800 (PST)
Subject: [net-next PATCH v4 03/10] net: pcs: xpcs: Add support for 25G, 50G,
 and 100G interfaces
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, pabeni@redhat.com,
 davem@davemloft.net
Date: Thu, 13 Nov 2025 08:33:16 -0800
Message-ID: 
 <176305159613.3573217.10928583427876316027.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <176305128544.3573217.7529629511881918177.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <176305128544.3573217.7529629511881918177.stgit@ahduyck-xeon-server.home.arpa>
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
 include/uapi/linux/mdio.h  |    3 +
 2 files changed, 104 insertions(+), 4 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 3d1bd5aac093..b33767c7b45c 100644
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
+	case PHY_INTERFACE_MODE_25GBASER:
+	case PHY_INTERFACE_MODE_50GBASER:
+	case PHY_INTERFACE_MODE_LAUI:
+	case PHY_INTERFACE_MODE_100GBASEP:
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
index c32333e1156c..2367b4f5ddd9 100644
--- a/include/uapi/linux/mdio.h
+++ b/include/uapi/linux/mdio.h
@@ -125,10 +125,13 @@
 #define MDIO_CTRL1_SPEED5G		MDIO_PMA_CTRL1_SPEED5G
 /* 100 Gb/s */
 #define MDIO_PMA_CTRL1_SPEED100G	(MDIO_CTRL1_SPEEDSELEXT | 0x0c)
+#define MDIO_PCS_CTRL1_SPEED100G	(MDIO_CTRL1_SPEEDSELEXT | 0x10)
 /* 25 Gb/s */
 #define MDIO_PMA_CTRL1_SPEED25G		(MDIO_CTRL1_SPEEDSELEXT | 0x10)
+#define MDIO_PCS_CTRL1_SPEED25G		(MDIO_CTRL1_SPEEDSELEXT | 0x14)
 /* 50 Gb/s */
 #define MDIO_PMA_CTRL1_SPEED50G		(MDIO_CTRL1_SPEEDSELEXT | 0x14)
+#define MDIO_PCS_CTRL1_SPEED50G		(MDIO_CTRL1_SPEEDSELEXT | 0x18)
 /* 2.5 Gb/s */
 #define MDIO_PMA_CTRL1_SPEED2_5G	(MDIO_CTRL1_SPEEDSELEXT | 0x18)
 /* 5 Gb/s */



