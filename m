Return-Path: <netdev+bounces-225264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE241B9154D
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 15:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 766662A218C
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 13:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503DF30DD30;
	Mon, 22 Sep 2025 13:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lO4nwvJH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A209230C0FB
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 13:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758546784; cv=none; b=n0wpvxMEGZI9mXQ/HBlphyxYDg7OmYeU9WJXylMg762pMP37skK1zyFIkiuogt1/8oDKaIQj9TKVmwVaOKpoQe7Fm/e0v3YrDNRWG14/mH0S9DzjidOzPafGqADyhU3UVrug4uXV2hZOvFXdYPh4WsX73GGphpgL+niPvmIGNsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758546784; c=relaxed/simple;
	bh=unxmjxm6h4F/9t72n3Zmx6ePZef1LSzn6zgM64G59vU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SP5aLS4U0xY86gIfnsosA3fJ5e8P5sLFFLtxd5p/3OZwIu0XC3deP0e/iXe4XCLEkJ/Sy39jgiVrSv5XN7LArvHcSKd0g03VC7BCxRLjmOU3AkOJdb87xelaJT9PjEvQ6thcxsJjD3vm6CdmdA3furIQBjNSsrDLpZ26OyoBd5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lO4nwvJH; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b550a522a49so3676194a12.2
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 06:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758546781; x=1759151581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6BICoezk7Aqii5uI8fB/6RDKEXOngB1t0y1HJi8V6fU=;
        b=lO4nwvJHnSTArmDFKn2QFzlyq2ZF2B+3hE3Fqe+IUO41INfwT46rH9RQYjeLkbGdwL
         AJNKmy6sfpOQnWFezfusoiwyi7jST+PvEBIZIlKd4SnyXdO8vQTRYpewQmkymiJpU/ln
         OqhPXOOkVFQ4nkUoqyuKlidgVYG5ZyJaXS3ZX4b3elQHARTK+5ytuTuWZnOvdfdvEZwH
         YEpl72tScxM7eNuRZ0tcnTere7tZfpn58ZtJhLxZcwUO2SXX/v6IXHfnhPmmL21LKgQr
         lANdHipf1y449d5OVb6eD8bPxw/hR3fDO/qZ1X98DkrhpnkSyMtpe0uWbd4yV0jayNQi
         dZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758546781; x=1759151581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6BICoezk7Aqii5uI8fB/6RDKEXOngB1t0y1HJi8V6fU=;
        b=iLutIPevkEFY87WgjN+AaHkQN2ZG5yvZYJQODpNKQcQBQAvGD1/rp9CcUpAD63Uym7
         RmtcwsXNnq3FOCfK5IN1OslWgwoKSSam/OcuOW60Ku6ZynBbiKA2kxsdYT+fECrHpyhG
         8vW/oqURJl0YV3zzWnMTi7qVpx1yydX/71EhgzU3KyYgTJIy9HMtORuU0IamNTZI+UYS
         1TsMmEexsS1tTNRTeKFtmnByabtLvzymE53EFV6+COaCtChqFaQRQnbL3D/uQeE7icZu
         6uMKsrEgqCaAmbqo8aOUfkRdCQUYkmSkGM6FA3v5/PTVwaSS0yASTvcgdBIXCd99wkps
         +UIA==
X-Gm-Message-State: AOJu0Yw7POiIgLVFhnxzuca2IH3VpIitebYmegkoXRA6sKJMje91WF5W
	lJVRZg7VR34m17DP7HHCSPkd2v7MCp6oe0HYoUj2EzPtM5/KQmim3zbVsrqfjcDAKEs=
X-Gm-Gg: ASbGncsTREyiNBmIe2E96kY+7SxHwzOTOl8JP1NWcoEdfchpkS65WkwdDD9mMJWkV1C
	Mian7oAHolr/JeJP/RwlxK/9B98zSi5v2Yz/hXQUqKj+ZW8RaPODC6ERbika/VdktUXC1670xq+
	xaL322w7Rm5sdXhxJebjBZwgMN5Vdc/S7ABYHSzMXUg5lGrynFJm+/jISOxSARRpZZ6U3vtd+2I
	wwZvnxtK3MG8lMY7NrLMuic0/n7Rn2a/R5OqaLczOKDuHE8jxTocfaYxAGIE3TooUYM8M0yayur
	1WQe0Y7TVatLVOfjEZDv2aI9bqVWQYEWvbeK/QL7rIwE2Ie3gbeug0gyM6z37rFixkMwBvpHW1f
	2LsKXZoWm8rBJhEpFiS7RC+qAiVKwmQ==
X-Google-Smtp-Source: AGHT+IFCaMWxLEAqaH9OP6YhIlxxfOIJkeoBdqxz5qfmubo3eJBUEdY3PUmuBFtbQg3xg9PFsFXEEA==
X-Received: by 2002:a17:903:ac3:b0:274:9dae:6a6d with SMTP id d9443c01a7336-2749dae6c18mr64125005ad.34.1758546781613;
        Mon, 22 Sep 2025 06:13:01 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698016bff2sm130200055ad.35.2025.09.22.06.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 06:13:01 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v11 2/5] net: phy: introduce PHY_INTERFACE_MODE_REVSGMII
Date: Mon, 22 Sep 2025 21:11:40 +0800
Message-ID: <20250922131148.1917856-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922131148.1917856-1-mmyangfl@gmail.com>
References: <20250922131148.1917856-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "reverse SGMII" protocol name is a personal invention, derived from
"reverse MII" and "reverse RMII", this means: "behave like an SGMII
PHY".

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/phy/phy-core.c | 1 +
 drivers/net/phy/phy_caps.c | 1 +
 drivers/net/phy/phylink.c  | 1 +
 include/linux/phy.h        | 4 ++++
 4 files changed, 7 insertions(+)

diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index 605ca20ae192..074645840cd5 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -132,6 +132,7 @@ int phy_interface_num_ports(phy_interface_t interface)
 	case PHY_INTERFACE_MODE_TRGMII:
 	case PHY_INTERFACE_MODE_USXGMII:
 	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_REVSGMII:
 	case PHY_INTERFACE_MODE_SMII:
 	case PHY_INTERFACE_MODE_1000BASEX:
 	case PHY_INTERFACE_MODE_2500BASEX:
diff --git a/drivers/net/phy/phy_caps.c b/drivers/net/phy/phy_caps.c
index 2cc9ee97e867..9a9a8afc056f 100644
--- a/drivers/net/phy/phy_caps.c
+++ b/drivers/net/phy/phy_caps.c
@@ -299,6 +299,7 @@ unsigned long phy_caps_from_interface(phy_interface_t interface)
 	case PHY_INTERFACE_MODE_PSGMII:
 	case PHY_INTERFACE_MODE_QSGMII:
 	case PHY_INTERFACE_MODE_QUSGMII:
+	case PHY_INTERFACE_MODE_REVSGMII:
 	case PHY_INTERFACE_MODE_SGMII:
 	case PHY_INTERFACE_MODE_GMII:
 		link_caps |= BIT(LINK_CAPA_1000HD) | BIT(LINK_CAPA_1000FD);
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 1b06805f1bd7..e8e237fb9d35 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -255,6 +255,7 @@ static int phylink_interface_max_speed(phy_interface_t interface)
 	case PHY_INTERFACE_MODE_PSGMII:
 	case PHY_INTERFACE_MODE_QSGMII:
 	case PHY_INTERFACE_MODE_QUSGMII:
+	case PHY_INTERFACE_MODE_REVSGMII:
 	case PHY_INTERFACE_MODE_SGMII:
 	case PHY_INTERFACE_MODE_GMII:
 		return SPEED_1000;
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 7da9e19471c9..42d5c1f4d8ad 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -107,6 +107,7 @@ extern const int phy_basic_ports_array[3];
  * @PHY_INTERFACE_MODE_LAUI: 50 Gigabit Attachment Unit Interface
  * @PHY_INTERFACE_MODE_100GBASEP: 100GBase-P - with Clause 134 FEC
  * @PHY_INTERFACE_MODE_MIILITE: MII-Lite - MII without RXER TXER CRS COL
+ * @PHY_INTERFACE_MODE_REVSGMII: Serial gigabit media-independent interface in PHY role
  * @PHY_INTERFACE_MODE_MAX: Book keeping
  *
  * Describes the interface between the MAC and PHY.
@@ -152,6 +153,7 @@ typedef enum {
 	PHY_INTERFACE_MODE_LAUI,
 	PHY_INTERFACE_MODE_100GBASEP,
 	PHY_INTERFACE_MODE_MIILITE,
+	PHY_INTERFACE_MODE_REVSGMII,
 	PHY_INTERFACE_MODE_MAX,
 } phy_interface_t;
 
@@ -281,6 +283,8 @@ static inline const char *phy_modes(phy_interface_t interface)
 		return "100gbase-p";
 	case PHY_INTERFACE_MODE_MIILITE:
 		return "mii-lite";
+	case PHY_INTERFACE_MODE_REVSGMII:
+		return "rev-sgmii";
 	default:
 		return "unknown";
 	}
-- 
2.51.0


