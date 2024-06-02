Return-Path: <netdev+bounces-99991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D63418D764D
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 16:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AFB51F211BC
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 14:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E9C59162;
	Sun,  2 Jun 2024 14:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eiPkrf9Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131B1548F7;
	Sun,  2 Jun 2024 14:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717339012; cv=none; b=jt0wqMVboavV92immuoAwAYcuJn/ZLt/ThvvOcFGLa2nRyhFFw/okgdA6B7/w7/ANpCUcbhcprMfeiep5b0keFTplf3tMa3j5e7mAf1fqtoll/mrxuBChASXOt557Qz5gkUjcTKQvSCegdsW7ZbcHQRtxs42SlkYa9SjdVrWNcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717339012; c=relaxed/simple;
	bh=k4gkAz+Zl8rzR8GG8wrdRjpIs+MSbIxwVH7f99/7BJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mk1NWTG/TvX/p3FqDN9WPl+eCJwKLJ07GCrlSffumI7Ur73utSgGnC5V3DsdKvh3Bi1b8SZIB1+NiaA3+JCs6E+uLI1c3OkM8B9uHXSXYE7hpykk5vLztJ/exQ8SwtKSjyIOFKbnLdMcKtpEIPzLTofxUuAZwAOkXb0wx1HttMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eiPkrf9Q; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2e95a1eff78so47006851fa.0;
        Sun, 02 Jun 2024 07:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717339009; x=1717943809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEjeTMFoJBv+1cocMj3lNi4jSjrQ54Kw3PRV3mrle98=;
        b=eiPkrf9QY5JDC9+/ljT/lCnXBWr1y4+rUiwUrIIn0XY/xUy77c2ael7eQiBn/P5svA
         FGeRvw0XeTkLAMctnECzWEEa4g120xo8iIYYHAutYV7xojpDZvzFD3tMq8GHnVxWHHnu
         wIIQESJf9PhNQsW7EzOS664QgqmfiJ8LOA0FJVcrubUh4BfHe/okf0k7j1owT+Cpi5jr
         iF6BqnArn68Lcd9BO7ZuO5c8FOb3vHoFtaE+GS3xHNtQZXnNWxsMQTMt6UfwktR41lr+
         uxeKMHSYKe10W/n7pK6THIDqTe2FE+8sXznMBDEFJUMjNQXagSkmj7izWRF6Z7R5uRCW
         8c0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717339009; x=1717943809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EEjeTMFoJBv+1cocMj3lNi4jSjrQ54Kw3PRV3mrle98=;
        b=Mc7LYGf2ux7I1tj821apR0UfoEtCfyOQjvqFPGmjXgNZ2LhoViCo3Y/CIGyJh8if2o
         KrNvrUK3gtd51pRqB1ffihcs5Uym3DIFgsAje21r59Qy86yPTNHdGdvtkCldDRGUGNlm
         /+RKAYrcx4FZ6y8QQz4t4Px1Mquoqa90s2twod+YpUfMuzlQn+c9xwH/jf4/6fGewjyX
         6naX1nXrultHQTh332xjcBoqrMYXeKfc/XOqq902S6hmv/LdB1OMpYAB7KtvIUFSpvLl
         /u35lIYwVrpanoMfGvrpiK/iXmtJLj4sPALbU4IObr0Up2FZEc7Ydof+MaXtEmgaAJKn
         iNsw==
X-Forwarded-Encrypted: i=1; AJvYcCXbSq04ZhT+6Ww2nrZAxZdT0Xh0GCWjh5l7V6C7SIwfpvNIQ4TM6CF7KjLDJzKnDD+BiCUkdmOeh49bDeF4TLAr28ObGtjLrGYX1DMD+Erw6NpdszSh9U/7PzmrKPp9Lk8j14dnA1JF6CxlSdZIX8+hmlCNOACr/MxGj87l1mBXzw==
X-Gm-Message-State: AOJu0YwnZ940VxtBMyBWLHRq/vcy+qtrwh8BzBoat/uFkizIQrdJfSnP
	Uv8UYqG5vprhR1txroN5NyQvSCtPG7CiFfOnBHzyNLT7T4O+0ruB
X-Google-Smtp-Source: AGHT+IECFWr2eN8AS3zjjnqwWdWxEdkSN5s216Gg8Y6ZUNUm8wBCeEqyvFu7aGOr2W1PCG7UzKs+oQ==
X-Received: by 2002:a2e:b5a9:0:b0:2ea:8e94:a2ea with SMTP id 38308e7fff4ca-2ea95108166mr50557881fa.6.1717339009135;
        Sun, 02 Jun 2024 07:36:49 -0700 (PDT)
Received: from localhost ([178.178.142.64])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ea91bb49ebsm9383051fa.34.2024.06.02.07.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 07:36:48 -0700 (PDT)
From: Serge Semin <fancer.lancer@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Sagar Cheluvegowda <quic_scheluve@quicinc.com>,
	Abhishek Chauhan <quic_abchauha@quicinc.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	openbmc@lists.ozlabs.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 04/10] net: pcs: xpcs: Convert xpcs_compat to dw_xpcs_compat
Date: Sun,  2 Jun 2024 17:36:18 +0300
Message-ID: <20240602143636.5839-5-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240602143636.5839-1-fancer.lancer@gmail.com>
References: <20240602143636.5839-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The xpcs_compat structure has been left as the only dw-prefix-less
structure since the previous commit. Let's unify at least the structures
naming in the driver by adding the dw_-prefix to it.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

Changelog v2:
- This is a new patch introduced on v2 stage of the review.
---
 drivers/net/pcs/pcs-xpcs.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 48c61975db22..0af6b5995113 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -143,7 +143,7 @@ enum {
 	DW_XPCS_INTERFACE_MAX,
 };
 
-struct xpcs_compat {
+struct dw_xpcs_compat {
 	const int *supported;
 	const phy_interface_t *interface;
 	int num_interfaces;
@@ -154,16 +154,16 @@ struct xpcs_compat {
 struct dw_xpcs_desc {
 	u32 id;
 	u32 mask;
-	const struct xpcs_compat *compat;
+	const struct dw_xpcs_compat *compat;
 };
 
-static const struct xpcs_compat *
+static const struct dw_xpcs_compat *
 xpcs_find_compat(const struct dw_xpcs_desc *desc, phy_interface_t interface)
 {
 	int i, j;
 
 	for (i = 0; i < DW_XPCS_INTERFACE_MAX; i++) {
-		const struct xpcs_compat *compat = &desc->compat[i];
+		const struct dw_xpcs_compat *compat = &desc->compat[i];
 
 		for (j = 0; j < compat->num_interfaces; j++)
 			if (compat->interface[j] == interface)
@@ -175,7 +175,7 @@ xpcs_find_compat(const struct dw_xpcs_desc *desc, phy_interface_t interface)
 
 int xpcs_get_an_mode(struct dw_xpcs *xpcs, phy_interface_t interface)
 {
-	const struct xpcs_compat *compat;
+	const struct dw_xpcs_compat *compat;
 
 	compat = xpcs_find_compat(xpcs->desc, interface);
 	if (!compat)
@@ -185,7 +185,7 @@ int xpcs_get_an_mode(struct dw_xpcs *xpcs, phy_interface_t interface)
 }
 EXPORT_SYMBOL_GPL(xpcs_get_an_mode);
 
-static bool __xpcs_linkmode_supported(const struct xpcs_compat *compat,
+static bool __xpcs_linkmode_supported(const struct dw_xpcs_compat *compat,
 				      enum ethtool_link_mode_bit_indices linkmode)
 {
 	int i;
@@ -277,7 +277,7 @@ static int xpcs_poll_reset(struct dw_xpcs *xpcs, int dev)
 }
 
 static int xpcs_soft_reset(struct dw_xpcs *xpcs,
-			   const struct xpcs_compat *compat)
+			   const struct dw_xpcs_compat *compat)
 {
 	int ret, dev;
 
@@ -418,7 +418,7 @@ static void xpcs_config_usxgmii(struct dw_xpcs *xpcs, int speed)
 }
 
 static int _xpcs_config_aneg_c73(struct dw_xpcs *xpcs,
-				 const struct xpcs_compat *compat)
+				 const struct dw_xpcs_compat *compat)
 {
 	int ret, adv;
 
@@ -463,7 +463,7 @@ static int _xpcs_config_aneg_c73(struct dw_xpcs *xpcs,
 }
 
 static int xpcs_config_aneg_c73(struct dw_xpcs *xpcs,
-				const struct xpcs_compat *compat)
+				const struct dw_xpcs_compat *compat)
 {
 	int ret;
 
@@ -482,7 +482,7 @@ static int xpcs_config_aneg_c73(struct dw_xpcs *xpcs,
 
 static int xpcs_aneg_done_c73(struct dw_xpcs *xpcs,
 			      struct phylink_link_state *state,
-			      const struct xpcs_compat *compat, u16 an_stat1)
+			      const struct dw_xpcs_compat *compat, u16 an_stat1)
 {
 	int ret;
 
@@ -607,7 +607,7 @@ static int xpcs_validate(struct phylink_pcs *pcs, unsigned long *supported,
 			 const struct phylink_link_state *state)
 {
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(xpcs_supported) = { 0, };
-	const struct xpcs_compat *compat;
+	const struct dw_xpcs_compat *compat;
 	struct dw_xpcs *xpcs;
 	int i;
 
@@ -633,7 +633,7 @@ void xpcs_get_interfaces(struct dw_xpcs *xpcs, unsigned long *interfaces)
 	int i, j;
 
 	for (i = 0; i < DW_XPCS_INTERFACE_MAX; i++) {
-		const struct xpcs_compat *compat = &xpcs->desc->compat[i];
+		const struct dw_xpcs_compat *compat = &xpcs->desc->compat[i];
 
 		for (j = 0; j < compat->num_interfaces; j++)
 			__set_bit(compat->interface[j], interfaces);
@@ -850,7 +850,7 @@ static int xpcs_config_2500basex(struct dw_xpcs *xpcs)
 int xpcs_do_config(struct dw_xpcs *xpcs, phy_interface_t interface,
 		   const unsigned long *advertising, unsigned int neg_mode)
 {
-	const struct xpcs_compat *compat;
+	const struct dw_xpcs_compat *compat;
 	int ret;
 
 	compat = xpcs_find_compat(xpcs->desc, interface);
@@ -915,7 +915,7 @@ static int xpcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 
 static int xpcs_get_state_c73(struct dw_xpcs *xpcs,
 			      struct phylink_link_state *state,
-			      const struct xpcs_compat *compat)
+			      const struct dw_xpcs_compat *compat)
 {
 	bool an_enabled;
 	int pcs_stat1;
@@ -1115,7 +1115,7 @@ static void xpcs_get_state(struct phylink_pcs *pcs,
 			   struct phylink_link_state *state)
 {
 	struct dw_xpcs *xpcs = phylink_pcs_to_xpcs(pcs);
-	const struct xpcs_compat *compat;
+	const struct dw_xpcs_compat *compat;
 	int ret;
 
 	compat = xpcs_find_compat(xpcs->desc, state->interface);
@@ -1269,7 +1269,7 @@ static u32 xpcs_get_id(struct dw_xpcs *xpcs)
 	return 0xffffffff;
 }
 
-static const struct xpcs_compat synopsys_xpcs_compat[DW_XPCS_INTERFACE_MAX] = {
+static const struct dw_xpcs_compat synopsys_xpcs_compat[DW_XPCS_INTERFACE_MAX] = {
 	[DW_XPCS_USXGMII] = {
 		.supported = xpcs_usxgmii_features,
 		.interface = xpcs_usxgmii_interfaces,
@@ -1314,7 +1314,7 @@ static const struct xpcs_compat synopsys_xpcs_compat[DW_XPCS_INTERFACE_MAX] = {
 	},
 };
 
-static const struct xpcs_compat nxp_sja1105_xpcs_compat[DW_XPCS_INTERFACE_MAX] = {
+static const struct dw_xpcs_compat nxp_sja1105_xpcs_compat[DW_XPCS_INTERFACE_MAX] = {
 	[DW_XPCS_SGMII] = {
 		.supported = xpcs_sgmii_features,
 		.interface = xpcs_sgmii_interfaces,
@@ -1324,7 +1324,7 @@ static const struct xpcs_compat nxp_sja1105_xpcs_compat[DW_XPCS_INTERFACE_MAX] =
 	},
 };
 
-static const struct xpcs_compat nxp_sja1110_xpcs_compat[DW_XPCS_INTERFACE_MAX] = {
+static const struct dw_xpcs_compat nxp_sja1110_xpcs_compat[DW_XPCS_INTERFACE_MAX] = {
 	[DW_XPCS_SGMII] = {
 		.supported = xpcs_sgmii_features,
 		.interface = xpcs_sgmii_interfaces,
@@ -1418,7 +1418,7 @@ static int xpcs_init_id(struct dw_xpcs *xpcs)
 
 static int xpcs_init_iface(struct dw_xpcs *xpcs, phy_interface_t interface)
 {
-	const struct xpcs_compat *compat;
+	const struct dw_xpcs_compat *compat;
 
 	compat = xpcs_find_compat(xpcs->desc, interface);
 	if (!compat)
-- 
2.43.0


