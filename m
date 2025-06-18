Return-Path: <netdev+bounces-199255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3415ADF931
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 00:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A836C561FB4
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 22:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E98D27E066;
	Wed, 18 Jun 2025 22:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3PjOOrX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D1B27E062
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 22:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750284445; cv=none; b=Xt6OkgxrRkbYYVNTFK3O73BGsiby7cW/LuUkmnA8Yyk9lNG64q7xXbgaaozMzvw48E7poZPJN8yfs4P6zovX40P9XDyzF3/UCmxKAgP00fLBakORs7GS689VEMxiAQiQlA+Im6f2fLUH/+wQMkRW+M/v0s57EUD1vNSHZ+afiFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750284445; c=relaxed/simple;
	bh=BQK+FnDJjKJYHXQc46bo54lyCIkhddtRawauzfZ0AOM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LSFj4nuCiBkhZaHMN5/VMPO3xxesyG+pXH44LMOvLXXIbcE6zCS98NqzXL0ryyh+8f2R0Hd8q050F2qapGeVa93KrhGCzjiYi7CKEsN3wyRE+frNM+awrC5JhLBe03r85NyfQBB+Xd5SOBYF1WaJI7L6lMzFf/QzbcY6uKV30yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3PjOOrX; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-74865da80c4so51946b3a.3
        for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 15:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750284443; x=1750889243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lgm93aLVM45r4dAdrY72ElrrJwGL+STlu2mdGh7p6/A=;
        b=f3PjOOrX+9Kpgr2jnqvvvh+kMUGY5EcxaO6dgexsh1v2JjJsWq730JoQlG+1g4gC5x
         rlk8FFtiVb5hA1T1GI1yIXvUtgpmaO6z0gU0W8POsk9ARr6LSibnbxgpKfl2Sd5Nj2WD
         DAkwMZHnMbkQXjZEcvJCLfq25e85OPoBUnb7Tu0WX2Wvzkz7hHJfSGmKjEX8EnspoqYa
         ZN1Q/J33ejcOWSFsf8UX7+mSPniYgJxOfudi+YraKsWArWBlyrDyVgUFIwY2mfXe1NNO
         OzlD0NnCpDCXKxg6QrnLy1eM3RjHu1Hqc85pI3jKFuQ5E5w0xSh2uaUdHq8r02GZKpwg
         akRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750284443; x=1750889243;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lgm93aLVM45r4dAdrY72ElrrJwGL+STlu2mdGh7p6/A=;
        b=GMAmIs/PCwULPdIHEQuJq8fSeXmZwq02pDkBgj0zctI+FzUDEZTfOcV95/i3wG+p1w
         RvZbaUJ5tmwmMZvJI+jrEXfT3x2fnSt34psYoXX4vRQmj8ZpWdRTgi+gfxcgAHrLwzxp
         pzLB4OB/xle5OqG1Yn2BvwHBrGzRowyM9fd5Kjjj8Odou1XoH5dEOe+EljH5L+Yr9CP3
         +6qNKkM9VCROvCUb6uwv98OirnKg+bBUHtcxUWG4BSfqodhijuzSgxieQEM2lK/Ara/9
         C58N6S5iE1FGS3o3FtU4vJfDimWThQhBaGJo9cwKxywQdv7x0JFasoROiH5BM3Q3PTYH
         dkEA==
X-Gm-Message-State: AOJu0YxyGZow3RRAslsML0DEOxLQ97nyEylRSN/dUxp1fRiLKqgx35cb
	Q5pH83czljUMFBp0NdUfOANMQVbGkn5h2uJrl+4zgGeODm+MKnuBObFB
X-Gm-Gg: ASbGnct0wt8dA9u+ZRxS3r9Qh2fa8jcDu9139MkxJ9LWE9ETyEpySoYitkDIxloUSAR
	NarEMgfExKKxuhvAEMEW4a46QdSp3letlJQsIjM5Mk/+6IR//inLIkk0TJYsZEibZ1F+bfxxSTQ
	5t1WPasSAleRplu/Q9jpKBt6k83maHtS5wPi6vn/as5hnZU/xuXr2xNUq9hWLeGuWlOtWm/9rl3
	qOl1T7/UesZYs1XX2EPqu9A0yfXN8tAdOndyh8CIVSe/NOeQobC6M5dZvoj9WiqToJmRV3Demp3
	D0TSruYTvXPUuSQio1fZYKHu4HHhiqiBYyMCkhESG4HjakPlVnDCFFNc/oMbg0vp71GOI8cPnXv
	FjBroZ+Zt1nJNr1XCbV2JN9AAbV0NDSE=
X-Google-Smtp-Source: AGHT+IGQd8EkfSmu/Bri/HQ1mniEgPO+2dpqdMNaWcgmz6yxbZDH1f5VexBMRcgMmJTgdSViNxvd4w==
X-Received: by 2002:a05:6a21:329c:b0:21f:54f0:3b84 with SMTP id adf61e73a8af0-21fbd581fd3mr31650459637.35.1750284443527;
        Wed, 18 Jun 2025 15:07:23 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b31bcfa71f9sm3311077a12.13.2025.06.18.15.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 15:07:23 -0700 (PDT)
Subject: [net-next PATCH v3 1/8] net: phy: Add interface types for 50G and
 100G
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: linux@armlinux.org.uk, hkallweit1@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, pabeni@redhat.com, kuba@kernel.org,
 kernel-team@meta.com, edumazet@google.com
Date: Wed, 18 Jun 2025 15:07:22 -0700
Message-ID: 
 <175028444205.625704.4191700324472974116.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <175028434031.625704.17964815932031774402.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <175028434031.625704.17964815932031774402.stgit@ahduyck-xeon-server.home.arpa>
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

Add support for 802.3cd based interface types 50GBASE-R and 100GBASE-P.
This choice in naming is based on section 135 of the 802.3-2022 IEEE
Standard.

In addition it is adding support for what I am referring to as LAUI
which is based on annex 135C of the IEEE Standard, and shares many
similarities with the 25/50G consortium. The main difference between the
two is that IEEE spec refers to LAUI as the AUI before the RS(544/514) FEC,
whereas the 25/50G use this lane and frequency combination after going
through RS(528/514), Base-R or no FEC at all.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/phy/phy-core.c |    3 +++
 drivers/net/phy/phy_caps.c |    9 +++++++++
 drivers/net/phy/phylink.c  |   13 +++++++++++++
 include/linux/phy.h        |   12 ++++++++++++
 4 files changed, 37 insertions(+)

diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index 27f1833563ab..c480bb40fa73 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -142,6 +142,9 @@ int phy_interface_num_ports(phy_interface_t interface)
 	case PHY_INTERFACE_MODE_RXAUI:
 	case PHY_INTERFACE_MODE_XAUI:
 	case PHY_INTERFACE_MODE_1000BASEKX:
+	case PHY_INTERFACE_MODE_50GBASER:
+	case PHY_INTERFACE_MODE_LAUI:
+	case PHY_INTERFACE_MODE_100GBASEP:
 		return 1;
 	case PHY_INTERFACE_MODE_QSGMII:
 	case PHY_INTERFACE_MODE_QUSGMII:
diff --git a/drivers/net/phy/phy_caps.c b/drivers/net/phy/phy_caps.c
index 38417e288611..d11ce1c7e712 100644
--- a/drivers/net/phy/phy_caps.c
+++ b/drivers/net/phy/phy_caps.c
@@ -351,6 +351,15 @@ unsigned long phy_caps_from_interface(phy_interface_t interface)
 		link_caps |= BIT(LINK_CAPA_40000FD);
 		break;
 
+	case PHY_INTERFACE_MODE_50GBASER:
+	case PHY_INTERFACE_MODE_LAUI:
+		link_caps |= BIT(LINK_CAPA_50000FD);
+		break;
+
+	case PHY_INTERFACE_MODE_100GBASEP:
+		link_caps |= BIT(LINK_CAPA_100000FD);
+		break;
+
 	case PHY_INTERFACE_MODE_INTERNAL:
 		link_caps |= LINK_CAPA_ALL;
 		break;
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 0faa3d97e06b..67218d278ce6 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -127,6 +127,9 @@ do {									\
 #endif
 
 static const phy_interface_t phylink_sfp_interface_preference[] = {
+	PHY_INTERFACE_MODE_100GBASEP,
+	PHY_INTERFACE_MODE_50GBASER,
+	PHY_INTERFACE_MODE_LAUI,
 	PHY_INTERFACE_MODE_25GBASER,
 	PHY_INTERFACE_MODE_USXGMII,
 	PHY_INTERFACE_MODE_10GBASER,
@@ -274,6 +277,13 @@ static int phylink_interface_max_speed(phy_interface_t interface)
 	case PHY_INTERFACE_MODE_XLGMII:
 		return SPEED_40000;
 
+	case PHY_INTERFACE_MODE_50GBASER:
+	case PHY_INTERFACE_MODE_LAUI:
+		return SPEED_50000;
+
+	case PHY_INTERFACE_MODE_100GBASEP:
+		return SPEED_100000;
+
 	case PHY_INTERFACE_MODE_INTERNAL:
 	case PHY_INTERFACE_MODE_NA:
 	case PHY_INTERFACE_MODE_MAX:
@@ -798,6 +808,9 @@ static int phylink_parse_mode(struct phylink *pl,
 		case PHY_INTERFACE_MODE_10GKR:
 		case PHY_INTERFACE_MODE_10GBASER:
 		case PHY_INTERFACE_MODE_XLGMII:
+		case PHY_INTERFACE_MODE_50GBASER:
+		case PHY_INTERFACE_MODE_LAUI:
+		case PHY_INTERFACE_MODE_100GBASEP:
 			caps = ~(MAC_SYM_PAUSE | MAC_ASYM_PAUSE);
 			caps = phylink_get_capabilities(pl->link_config.interface, caps,
 							RATE_MATCH_NONE);
diff --git a/include/linux/phy.h b/include/linux/phy.h
index b037aab7b71d..74c1bcf64b3c 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -103,6 +103,9 @@ extern const int phy_basic_ports_array[3];
  * @PHY_INTERFACE_MODE_QUSGMII: Quad Universal SGMII
  * @PHY_INTERFACE_MODE_1000BASEKX: 1000Base-KX - with Clause 73 AN
  * @PHY_INTERFACE_MODE_10G_QXGMII: 10G-QXGMII - 4 ports over 10G USXGMII
+ * @PHY_INTERFACE_MODE_50GBASER: 50GBase-R - with Clause 134 FEC
+ * @PHY_INTERFACE_MODE_LAUI: 50 Gigabit Attachment Unit Interface
+ * @PHY_INTERFACE_MODE_100GBASEP: 100GBase-P - with Clause 134 FEC
  * @PHY_INTERFACE_MODE_MAX: Book keeping
  *
  * Describes the interface between the MAC and PHY.
@@ -144,6 +147,9 @@ typedef enum {
 	PHY_INTERFACE_MODE_QUSGMII,
 	PHY_INTERFACE_MODE_1000BASEKX,
 	PHY_INTERFACE_MODE_10G_QXGMII,
+	PHY_INTERFACE_MODE_50GBASER,
+	PHY_INTERFACE_MODE_LAUI,
+	PHY_INTERFACE_MODE_100GBASEP,
 	PHY_INTERFACE_MODE_MAX,
 } phy_interface_t;
 
@@ -260,6 +266,12 @@ static inline const char *phy_modes(phy_interface_t interface)
 		return "qusgmii";
 	case PHY_INTERFACE_MODE_10G_QXGMII:
 		return "10g-qxgmii";
+	case PHY_INTERFACE_MODE_50GBASER:
+		return "50gbase-r";
+	case PHY_INTERFACE_MODE_LAUI:
+		return "laui";
+	case PHY_INTERFACE_MODE_100GBASEP:
+		return "100gbase-p";
 	default:
 		return "unknown";
 	}



