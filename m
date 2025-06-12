Return-Path: <netdev+bounces-197008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB90AD754B
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 17:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DA2C1885EBC
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 15:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD3027991C;
	Thu, 12 Jun 2025 15:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIT66+x6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B79B26E719
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 15:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749740912; cv=none; b=jThhDpqDN1Mp9C79eswON24YMy7h+ksNs+ojNkFTrahRKE8+q4GHYCwngO8BUHQv1XEVux1fO4uQVv+MqJpgAC6a1nWTqkqwZMpEMFhV6Q2kNoc3PjLJQsimzmOi8E3HgRB+aU3JI7W2h7ATIUYQPYA5fualq8NdNyaQkNgjr00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749740912; c=relaxed/simple;
	bh=hTyXegj7ybNw4T5GrqlmnUamJzLZsxOsxtLYYIWjVTE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KYwY/i7RTftlhds4o0WnnfCsx6lfDuilkEMlpLHtdyns7DjHEauzQiFPQrVPbA+UKYK4GDqXfIyLPPLrv/K9WziyaUsazCiKaxF4MDR3JepVzQQG75xJEBpy05RcEd5sXXt2Rr6GgBFeSrLdDtxojzlABU4dDHVvgOngU0zB7ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CIT66+x6; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b2c384b2945so829095a12.0
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 08:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749740910; x=1750345710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wo1SJR+OUxspHA8L6RCB8ukYutoibRen5VrN3hjoxjk=;
        b=CIT66+x6f6B4IkHozlJK5otiWB9WTpO+0W1qo5JrKBr67XnOxOdbbzfOMjMrlWauXM
         x+fS1uaEgVwO1xGSoY1l/nY0WNOBPW2XOBzYbP3WkHQG2vZ61vkBqvPGNISI5Us/lY0X
         bZyJOJPabx0B/GSi/+lLRzqcU+kdgXjlIZgo7QLGOg8AZ9eZKnveHyqZzdSOaZxEwqTh
         XE+Uz1aje9LBR/U+KRmIq2kB2W3Hb/Pa1yTkWAyPQoCXT7awm9anNLbH52OOv1NP5TF9
         l3hkr31sJhZhJlTACqFteThgLQYWDQzIGugaxez6aOEeXEyvNIs1qcCdIa5i5iATT0X5
         xUCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749740910; x=1750345710;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wo1SJR+OUxspHA8L6RCB8ukYutoibRen5VrN3hjoxjk=;
        b=vZwsUHvQlgjEKwgA7135dyDprf18rTJdiZl7pctc2TNETXodY5KeyZLfzTfaBL4NQy
         KnMzja+X+DucgRbKPWLSyDJl4YEtxkIaYfSiLHHHRMzgj/G/E7/wKVoiT2enClKAC1KO
         zQhbhOl7VwYzbzp/QMhUfF2jK6qTly6EWM/neI3ZTM4E/sfLaDzATz6iuS+jeAJH5QLS
         fqHTl91MuTG0DhjY/Cxb+Hi1xBEGyJiIVb3UW6z5jvVhbpGVUzZopxOFKp0teUZGDOPl
         mRPZHls4S+tq5TY/EE5TTcY0lh2CQpjZSPyhWC3tku/cb8P5SoA5ILZ0uPSpsmv4F/Xx
         JkMQ==
X-Gm-Message-State: AOJu0YzoL/Wia4ZWnk0BdbwhaS2dbuMPXABW1tWvrKmzagLcNJey0EL3
	ZwXVff/IzFgZpZ1aqscQRr6y5K/1Lr3KrgUQjGtSAn7FlIpai243eV0b
X-Gm-Gg: ASbGnctIsoCAibrgDSSDoxBqrR3M2ashqLen5bnq3FWUUgO08EedodUCwIa4pfXoOUa
	dUlBEHImOZrL0qAcsxBkFDXvthu23UtuUH577Jon9+oXJ87br64Om/ya6Ux0r/8YPyfShU3yFfq
	cK6Nq4odBDq+ebpAgP3Yt41T6EQCWRGVsZIDD8Cj8gyLxgxmiaWlNvakb1xkEtGdZm5cBTTUd+l
	2en9fAiPshgfgBRLe0+0C22vhJDBXsSOK/ppVrX1pmA8bx3mUj0giqevm3gLAeOQeP9dM8Y2ysf
	GNkWU0daKcYLkok/V2ebbtAskCiBfMV80whztkeR1aLF3gTunqQYMQvOd1FmZdVtGAYXmfX6N6Z
	EmXPz00amj01C83w=
X-Google-Smtp-Source: AGHT+IHi35oCIf4hY0+e8s95WStdObLKiHQ9+Tit7zPruqRhyQkEh2xrPplarOHLD9CpJpFt4L3Eiw==
X-Received: by 2002:a17:90b:584b:b0:311:ae39:3dad with SMTP id 98e67ed59e1d1-313d7edd210mr309564a91.30.1749740908617;
        Thu, 12 Jun 2025 08:08:28 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([98.97.39.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c1c5e2ebsm1563125a91.33.2025.06.12.08.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 08:08:28 -0700 (PDT)
Subject: [net-next PATCH v2 1/6] net: phy: Add interface types for 50G and
 100G
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: linux@armlinux.org.uk, hkallweit1@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, pabeni@redhat.com, kuba@kernel.org,
 kernel-team@meta.com, edumazet@google.com
Date: Thu, 12 Jun 2025 08:08:27 -0700
Message-ID: 
 <174974090714.3327565.13511253886768378274.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <174974059576.3327565.11541374883434516600.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <174974059576.3327565.11541374883434516600.stgit@ahduyck-xeon-server.home.arpa>
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
 drivers/net/phy/sfp-bus.c  |   22 ++++++++++++++++++++++
 include/linux/phy.h        |   12 ++++++++++++
 include/linux/sfp.h        |    1 +
 6 files changed, 60 insertions(+)

diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index e177037f9110..a8c1b60c46a4 100644
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
index 703321689726..063e4a11614c 100644
--- a/drivers/net/phy/phy_caps.c
+++ b/drivers/net/phy/phy_caps.c
@@ -345,6 +345,15 @@ unsigned long phy_caps_from_interface(phy_interface_t interface)
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
diff --git a/drivers/net/phy/sfp-bus.c b/drivers/net/phy/sfp-bus.c
index f13c00b5b449..949bf95db8df 100644
--- a/drivers/net/phy/sfp-bus.c
+++ b/drivers/net/phy/sfp-bus.c
@@ -275,6 +275,8 @@ void sfp_parse_support(struct sfp_bus *bus, const struct sfp_eeprom_id *id,
 		break;
 	case SFF8024_ECC_100GBASE_CR4:
 		phylink_set(modes, 100000baseCR4_Full);
+		phylink_set(modes, 50000baseCR2_Full);
+		__set_bit(PHY_INTERFACE_MODE_LAUI, interfaces);
 		fallthrough;
 	case SFF8024_ECC_25GBASE_CR_S:
 	case SFF8024_ECC_25GBASE_CR_N:
@@ -294,6 +296,12 @@ void sfp_parse_support(struct sfp_bus *bus, const struct sfp_eeprom_id *id,
 		phylink_set(modes, 2500baseT_Full);
 		__set_bit(PHY_INTERFACE_MODE_2500BASEX, interfaces);
 		break;
+	case SFF8024_ECC_200GBASE_CR4:
+		phylink_set(modes, 100000baseCR2_Full);
+		__set_bit(PHY_INTERFACE_MODE_100GBASEP, interfaces);
+		phylink_set(modes, 50000baseCR_Full);
+		__set_bit(PHY_INTERFACE_MODE_50GBASER, interfaces);
+		break;
 	default:
 		dev_warn(bus->sfp_dev,
 			 "Unknown/unsupported extended compliance code: 0x%02x\n",
@@ -357,6 +365,20 @@ EXPORT_SYMBOL_GPL(sfp_parse_support);
 phy_interface_t sfp_select_interface(struct sfp_bus *bus,
 				     const unsigned long *link_modes)
 {
+	if (phylink_test(link_modes, 100000baseCR2_Full) ||
+	    phylink_test(link_modes, 100000baseKR2_Full) ||
+	    phylink_test(link_modes, 100000baseSR2_Full))
+		return PHY_INTERFACE_MODE_100GBASEP;
+
+	if (phylink_test(link_modes, 50000baseCR_Full) ||
+	    phylink_test(link_modes, 50000baseKR_Full) ||
+	    phylink_test(link_modes, 50000baseSR_Full))
+		return PHY_INTERFACE_MODE_50GBASER;
+
+	if (phylink_test(link_modes, 50000baseCR2_Full) ||
+	    phylink_test(link_modes, 50000baseKR2_Full))
+		return PHY_INTERFACE_MODE_LAUI;
+
 	if (phylink_test(link_modes, 25000baseCR_Full) ||
 	    phylink_test(link_modes, 25000baseKR_Full) ||
 	    phylink_test(link_modes, 25000baseSR_Full))
diff --git a/include/linux/phy.h b/include/linux/phy.h
index e194dad1623d..5095f89b01c6 100644
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
diff --git a/include/linux/sfp.h b/include/linux/sfp.h
index 60c65cea74f6..c2034a344e49 100644
--- a/include/linux/sfp.h
+++ b/include/linux/sfp.h
@@ -334,6 +334,7 @@ enum {
 	SFF8024_ECC_10GBASE_T_SR	= 0x1c,
 	SFF8024_ECC_5GBASE_T		= 0x1d,
 	SFF8024_ECC_2_5GBASE_T		= 0x1e,
+	SFF8024_ECC_200GBASE_CR4	= 0x40,
 };
 
 /* SFP EEPROM registers */



