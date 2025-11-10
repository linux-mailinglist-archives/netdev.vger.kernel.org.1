Return-Path: <netdev+bounces-237256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD18FC47CC2
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 17:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECD851889CED
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 16:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8DD274B30;
	Mon, 10 Nov 2025 16:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KeoeNVqC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438D125A340
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 16:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762790485; cv=none; b=lVMULPI0xBqrmmGUS9ztyU9i9R/BqN+lZm+hjiPPKFp8gUZUlfwkTn1FbQfxUxmk6R3RDVdgBQUeAXGdFWZyvYoqvQlmilNC5aV6uW7DXAIne19+ySXl7ipSwQ+bJz0LMnWyYot9aBENY9M+ATaG7n3TpX1LBxuaV6B1gC9SQc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762790485; c=relaxed/simple;
	bh=CvBSJnrJJygzK5aLqcEZG5scSPAuiFuYqOO01bGZ/Hc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GnD17l5DNjUR+RexAuu5o2xk3WqDVmsoamYLGQBe7XQExobPUAjST42plfbAPG0bnYgZPL7pWgKEQZZ83FpEHpBnvZW88AojsSQNezG/hZsQFU4MEH59WW4bpVDCQRJoqpRz3/vzVZSxq+NiNvPj5ztJxZsbB4rDqcPn7nO1R4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KeoeNVqC; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-794e300e20dso2160097b3a.1
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 08:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762790481; x=1763395281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S7BGTt4EtyuLU4TAz26suCmWKrFyiFfTss9rr2mUJ/I=;
        b=KeoeNVqC9Bu8vyLCM9WWCClWdVl+y37Yfb+fOCJQRGAQmgoEMjGLepernBd8wHzNbW
         FUMX5gxLBd6nhudDYo0TKgwm8pxIJDnrTRWQlhS66kgz7flCgMo0Y9ZFDD2dq5Tb5ZYJ
         2TIBd5kI2qFAlnyRBVZUPyt54ONoZQ9Me3Runjc8I8T/BrbnrxF9EwIJAA+Q3MCllEho
         6Ik9iRUiQiRIo6hB7IjWomrr5l+Prs1VRjEbsSs3KcBraW2S9DmsA261e8imI2j0Vuns
         FEtOw7IDWSDcjvLBIo/ymfehK8MIFyQ47iFOKr11NiWzwT4+Xo7amIt9KK7Z4XAQOSRG
         pp5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762790481; x=1763395281;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S7BGTt4EtyuLU4TAz26suCmWKrFyiFfTss9rr2mUJ/I=;
        b=bnAV4tsc2FakkKOBLrS/g6heiZJGPsYA0wzs6MaHvls7A1WQaSVYix0Ssg2FWyTUJD
         Q5XH8RXsDv1+tn+IJmuXT2NJQXv40IA7PmulIe4mEmOBICHzmAsm+KWth/KGbZv9TNw6
         K2VYLc3cqoHt0OmDLO3Mj+U7Q34sa1cZd834lPo1nInIxW2QS33ua9sd+W3QWGSS/rQm
         XKHHOgcFx6HOqzECd2xGOc+iegey/WohNDlVyfutui6Mv3q916sC2N/eaize1puWfSgk
         0Y4cAzKLwaaoF+33R/cdx1NXbHXk5UVl9dQloT4tsN1ByUqlNbzfA5frLh40EVYP8dIL
         Bhiw==
X-Gm-Message-State: AOJu0YyYUe3lKrX+vhgxQSxF2LLQZIczOvhtoeOiqScFuGH+PWw380VZ
	OVY2L0kwrE7ThOPSz8UWQXB0jn90w3W+negQKd3kAURek/fPjhDOng3OsJFaCQ==
X-Gm-Gg: ASbGncslQ8Z1o7Ek3ntd0/7XBeF4beBuR0tIx4kd2BA37s0YLt4YhmZcuui0RFzzkVV
	xSYIAPzIsRPqLY7wkvqI8GnaXKVyc5x9Imvh+09fMHFRWTsLSniBS86bE1ivq02t+JOwSuNL5/2
	ORjTGn3oLfsMLwTXwHICas/FkyrnXhS/FRu5m5bDZ3im0dTW+lvOmaLdMGraTxhf9jIgDZVMp7b
	KE3JIM8dOO3OWwCEle4TXiwAxNvWCTAjXw+bcO1NWtP1ix8jUwjitlItjyFOhWe4IWpo9eFCGRH
	eos4LuRATd7UJAxa4d0GYCAJuOGUGlewTzQjtgb8BwfS6XUcqNgLx9SAcd11y6Qng6uikLy6bgx
	9KJqO8mi8vcCYa4J7hQQVZWwTsrVsJ9gUj5h4gDlo3ZdTGHdLd+hu8H66d092Cbko9+STy2odJJ
	Bn9TbwU9QhNDFJrG23fLDi/Kz7VVPt8DG7+FSkiE0j9xam
X-Google-Smtp-Source: AGHT+IGgnmcvNzBH82jsfQILK6WJtj4vUZLnpaR3B5kYwisW9tGJcgj/NKsi4B1kBoGjK4y5sGTERw==
X-Received: by 2002:a17:903:2350:b0:295:6b98:6d65 with SMTP id d9443c01a7336-297e1e611d8mr111411675ad.22.1762790480649;
        Mon, 10 Nov 2025 08:01:20 -0800 (PST)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-297d83c941esm96714505ad.44.2025.11.10.08.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:01:19 -0800 (PST)
Subject: [net-next PATCH v3 03/10] net: pcs: xpcs: Add support for 25G, 50G,
 and 100G interfaces
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, pabeni@redhat.com,
 davem@davemloft.net
Date: Mon, 10 Nov 2025 08:01:18 -0800
Message-ID: 
 <176279047835.2130772.6957093082370490671.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <176279018050.2130772.17812295685941097123.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <176279018050.2130772.17812295685941097123.stgit@ahduyck-xeon-server.home.arpa>
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
index c33aa864ef66..2da509c9c0a5 100644
--- a/include/uapi/linux/mdio.h
+++ b/include/uapi/linux/mdio.h
@@ -118,10 +118,13 @@
 #define MDIO_CTRL1_SPEED10P2B		(MDIO_CTRL1_SPEEDSELEXT | 0x04)
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



