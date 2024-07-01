Return-Path: <netdev+bounces-108237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8DA91E782
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 20:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E84481F2266A
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 18:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34475171066;
	Mon,  1 Jul 2024 18:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P58v6CeT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E76316FF5A;
	Mon,  1 Jul 2024 18:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719858570; cv=none; b=Q7Z4VNR84Pemhs14RTaoWTqkWiCJ69eqxFgfM7fhNbmoOtX7ziDFKPw/J+GpgLlPJ5HBUqXuK6/oJSNY0QTJZsSUKNGUBbjTum1/RrXIhBduLORm8DtWCrDvyKYcWOQ4d5LPLPvQ3AutaP5RGJGKyX8KS9+JT1lzU7Xj+zGHdlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719858570; c=relaxed/simple;
	bh=VmVVULh0ROOr4wlf0PfeuUfEq8UW7k6pjpxUZ5JKt3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K8B5zndzLWsKfow7///rh9OXJfjrEQ2NGIE4wEDxweQwZxDYJYkOc8k6RQYh9CQ2hmWs7XTA4KO4ODWbVYVNhgL9yO+pyGux2wQWdPjEkU7OFrKNm9mtI5rORyuIKsR1DL0923XXO1z+FYfU6vlkyJYBsTlQKM5SD/QzzkUgngg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P58v6CeT; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52e7ad786dfso2829250e87.1;
        Mon, 01 Jul 2024 11:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719858567; x=1720463367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CG15dcTzClLXc4WlwrdlDsf9EXUtxqVafINgcgB1PXw=;
        b=P58v6CeTLjqlt3tRAYFEG5HQMXVOPQJd4MGwXhA4izBnR5Oos4p742ACxa28Pqh/Fn
         zAN0jvje9cyQkV9WDnMi6SQTsoTFi3SncIUtLQQJtqueFn44LXaJrC9K4hvw2U6ONkgh
         DtX7AUIYHaBM1odC1RkCecC6K04PHdBGrTk/a2pA20RvfQIpIblwyQ3vD+5cwKuXkDCs
         UE6+8S+j6c2EJPnirPiJemwCs8v9t2Vlhr1l7PkKNC9WJZWOlRwD4+O251Dmp6HDjxEG
         /28Tob3LTUubQJGQTnmZ8WCvXBakfqJizks9P69Bs1GIrWqKEyjT753ryvJfUKg6rN/l
         0pJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719858567; x=1720463367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CG15dcTzClLXc4WlwrdlDsf9EXUtxqVafINgcgB1PXw=;
        b=QySt9sgZGmghvxltgMnYWbxTe9J8jPc9rCYSm3/5a2dgW07lHa+TC+k8ZxJiwHI2fT
         gI/hbUwg9cU0wo/xzNJF5ZqjH0XU4csdcAJsiNOU1R+ux60TNqzsjIQimI85I7YrW78s
         N+4hajAWYGWVX3bi+gnQZYAWhEhPwNstsG4Ahv2LdP1NZbrT9uN3B7utAakZPCgWqnWu
         8Ha9p3yuCmZl0ySyuP8aDAwAeaF9TCGkGErHyhvRwEUKK90WQGUjMTwm51DDr/xEfITs
         7kStZ0RrK5Y0JjYvPMRffC01i4Gly49m3+oXPnGzsKG6vj0Y6bac0S+P095u97147HgA
         k9ng==
X-Forwarded-Encrypted: i=1; AJvYcCUdDrdosv6BxSHYPkkUpR4DLXkcYZFBsmKECutU9Wa6uROwLa2jHoFA/EJvL2WNrf3dwzFyw0tMvgzoFNIQHwV9yhozHhe+jrqLNi1hE+mNRwhIb8xSxd1UhIg9TcAFf+iTYlxYpkbA/Wwie+5dEfQYuzw2w0ObcGtoIBfEDDK7rA==
X-Gm-Message-State: AOJu0YxVHMKP+xoghqjzWIBC1RF3KZpX/GZFYnYbHWEijbj2UjPl5qFC
	lbaPmy+vmPeF39VTTsMbPi1INHtT58+Eyqy1Fqe+UXu9DEUvTuvi
X-Google-Smtp-Source: AGHT+IG1GHm+YzqOugbA4+XPMWd5VHx6eUuFeJd/fExlsHnIT0NgrHGP6PMSA0RWzEYsZFuB6hsF6g==
X-Received: by 2002:a05:6512:461:b0:52b:963d:277c with SMTP id 2adb3069b0e04-52e7b92f7c2mr2408356e87.33.1719858566333;
        Mon, 01 Jul 2024 11:29:26 -0700 (PDT)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab27b97sm1518551e87.148.2024.07.01.11.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 11:29:25 -0700 (PDT)
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
Subject: [PATCH net-next v4 04/10] net: pcs: xpcs: Convert xpcs_compat to dw_xpcs_compat
Date: Mon,  1 Jul 2024 21:28:35 +0300
Message-ID: <20240701182900.13402-5-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701182900.13402-1-fancer.lancer@gmail.com>
References: <20240701182900.13402-1-fancer.lancer@gmail.com>
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
Reviewed-by: Andrew Lunn <andrew@lunn.ch>

---

Changelog v2:
- This is a new patch introduced on v2 stage of the review.
---
 drivers/net/pcs/pcs-xpcs.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 4ed29df8c963..eefb5e1dbe21 100644
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


