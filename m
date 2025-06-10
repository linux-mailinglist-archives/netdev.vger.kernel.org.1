Return-Path: <netdev+bounces-196150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF6FAD3BAF
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 16:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E5D61627C2
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 14:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B522192EE;
	Tue, 10 Jun 2025 14:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKA/Y206"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932961DA62E
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 14:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749567079; cv=none; b=K1+422Yo3VUBeIZvBB7JlS2m4RQl/k4haCSv6cPBO+a03Q0DiIuK5iql2Oe8a3XL8/lT+JjYvpxFZb/QIYmITMQ4/h4DuugbqGWRhoNLIu5WuS8sZsJR98s6gk1Kcb0K44eln9F526wnZZfzjuFilTXqkSkPkDANryf2WdcSOqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749567079; c=relaxed/simple;
	bh=hTyXegj7ybNw4T5GrqlmnUamJzLZsxOsxtLYYIWjVTE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jeo/u2tt0z5MjtTWfMBYVPP9Ob85coXHDUp/uM3TFS4cnIBMO8DSYv0/7ed5zF0JxJ0bW+xa7zU6EUdPLDLkyc5Cht/5U/aDWlgGVp5sI42iLb7NyyF3t9l/ny/c6EAWCHtEjut5jICi/ccjXNnE/6+vhhCOcz5XfDKOdYwRnJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKA/Y206; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b271f3ae786so3770395a12.3
        for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 07:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749567076; x=1750171876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wo1SJR+OUxspHA8L6RCB8ukYutoibRen5VrN3hjoxjk=;
        b=MKA/Y206KdJJq34l3uM1f/APG2QRbAKSeLsPAns6k96PC+dYfXO/UY0cj5JZceJNRX
         Cnq9V6xokFEVW9GNOO7vMzwufPoByGxeWtErnAdD4k8OLRDL8cT1xcXzNDL8jJ1b3k1C
         WoyCaRjFdoe9h/SDznr1UG0AQ0P15pMgpBbX+W6W2db/nl8ES6qVOb/HaZhpKOdkhmc/
         kPB8qj+zbjiZX5LwaXRDl/7bkKLB/i/m0sFoYVyGP8+QBF5D0kSKvpuARMGukTqOM1hu
         wzV/LSfdcnvILW362ckAqlpW8VhaEGYXeIFFJe+hqga+x8NCFSCTkK53nM8dPeouaFrL
         wX2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749567076; x=1750171876;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wo1SJR+OUxspHA8L6RCB8ukYutoibRen5VrN3hjoxjk=;
        b=QAJgsFIpsxpFR6Xmm/isiIIVAK68TSERF6MreeyOWoDAqnd2SCdaDv12xC3Xg14oVO
         p6n+4vjIbRHItv/n4gYQm4MaHNXN2QFHNoRiJE0XnydlPIe5+VNjE8bGopdkUx/hXF09
         ahmxWSQUU9UUnmBTjQj0CoTKL8vsDpaYHfokLL5d/Lwl8eqtb2aU1dYyFVC0t1BBuL69
         dQF/S+M7/eyNtDGG0/+KRZ+JAuyfSixur+4KnFm1EulrKh3ETXQ2QTU3QxA1oIXCY0ay
         REiXFDpnzrah0R67MiPi6/qR0hVVIcRqESKc0420qaGZy0BkgbbsAs/dWjlINJhguJ+U
         4K2Q==
X-Gm-Message-State: AOJu0YzxVK/946cCq3BZkqWawfx/I3lW9mv4O4MgVwYrvnIuGyc3KQT6
	dcon1YLvJFXxkuW79xYRa3ysmDyUYAz6LZ07/u4dhYpgKhysK41A10IlClEAGw==
X-Gm-Gg: ASbGncunSv41bap8dslqf+85WUwgrwpJP8MkTUa8A9UxZw+76Z5BO/j+WEWg7C7rTt8
	+AR3JohTQqkiaZZkc0kVo1i5H9a2SQjKXIThsdVko2aBpPpQJJRdtxrMQy+RcBK77hduhHNIg3T
	BtgpEE/kCVZtZ07EdK/XsnDoRffMAFeY0vUzow+8SKT6f81s07RbQ6vmKYFKhWyuFy+BM1Y7Za9
	B+bNavdtagfG6Hmna3G6fbIp7BEdPuCFImwRCbN5LJebiO/3k9A+IeFbVn9eLhJ0xUry/Y+sr+A
	CPq/DsXhe7BQsaTDXUnuv6kjPaHWqJotH5E3qtdb8c58M9sBkqowfIhOUSvPB273yRyGorQ/4/F
	kFvln8da31vjCssIoKYs+ZkS2
X-Google-Smtp-Source: AGHT+IEBJR2/lJ8SqrfYqTemt8w5QQ1XambkAZo7gWE0epa4x9CuIMXxCa3OluvJy3Z5pvBKzf9bJg==
X-Received: by 2002:a05:6a20:9183:b0:203:9660:9e4a with SMTP id adf61e73a8af0-21ee68a7218mr24891924637.41.1749567076522;
        Tue, 10 Jun 2025 07:51:16 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([98.97.33.92])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482af7b08fsm7798948b3a.64.2025.06.10.07.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 07:51:16 -0700 (PDT)
Subject: [net-next PATCH 1/6] net: phy: Add interface types for 50G and 100G
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: linux@armlinux.org.uk, hkallweit1@gmail.com, andrew@lunn.ch,
 davem@davemloft.net, pabeni@redhat.com, kuba@kernel.org
Date: Tue, 10 Jun 2025 07:51:15 -0700
Message-ID: 
 <174956707507.2686723.1302808055667500691.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <174956639588.2686723.10994827055234129182.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <174956639588.2686723.10994827055234129182.stgit@ahduyck-xeon-server.home.arpa>
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



