Return-Path: <netdev+bounces-189587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 378D6AB2ABC
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 22:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 947583B9496
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 20:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DBF264A60;
	Sun, 11 May 2025 20:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwuX1eGZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A112D263F3A;
	Sun, 11 May 2025 20:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746994410; cv=none; b=qpbZ42YAxkujq/Yhtda5ChfCrmYbNOn545sAGxOT3A5iI1gu3/6wdxb3omfRpvdZHPDb8nYKmExY8BbH+L+t7QgwhTmwetkfD1Ge62RG4WkQ+DMUr6vcZh3unDCu7ADdJzoYAX3hkDXE7ULKKxKOjSY33srg5fdNXl+yJJn0Rq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746994410; c=relaxed/simple;
	bh=k2+jZG2fKDLcj1sNgat6nwbjyAPTOdXAGJj7hrPW7/M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O33vXNzgoqPk+yR80Q/ttHDUg1OClG5xakIc/a4/k9FFUg9KT+Z0CyGa5JGI39xltyTkrpRi68mefU8vc6iArZU+iZfLOrbeTqlV57/3tbs2ZTndvNSMwaW+GcUxO6iJYcvSDvmUwGrK2uS37w/hO6HaRjXyohDC+UR00MqEPsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HwuX1eGZ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a0ebf39427so2886975f8f.3;
        Sun, 11 May 2025 13:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746994407; x=1747599207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0mejOF2mYhTEXxWVOimbjN00Vr4yLk+E8aCpQ2xV2aM=;
        b=HwuX1eGZ4OYTWFZYiW3QfU/T2ZfbIbt+nyS/sf5gkwyhUHGX7obFbQH67pF4IT2odK
         bXfdnhkmHNJJStbgvMXXm718DWQOT0KhFCU611cw89cov0zCjGM4bZRI1i0xLDyvz9Ru
         826iANaHTxBlDJrkXM4rVmGGhIm4iQjliPFB0FOyLm/Xwo8SBootXfIdyjqMp4TuT458
         T/H7lxSJTtWSBPSFr4YdzYuG5gEF5cKSiN8LHlsEWX44rcSEvZdNnwPlyQ6h6BkPxrUR
         4OkYbD5rnQ6ED/GfDtnHyfZviGapmI9roX2NeVKoxFSo8tgfEzvFXlagUCpQhUBhTyIW
         DrvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746994407; x=1747599207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0mejOF2mYhTEXxWVOimbjN00Vr4yLk+E8aCpQ2xV2aM=;
        b=oggbpUt03qQ9BY1bCqYX2KnsfiTJNxdPKM2hERR9eS432FcoAVaxB/VaOGguhzKnJ/
         hsW6GDoT1/GqT8IE371Lv/OZAhKrs4yHeKbVku4VHsQxMQqCe2f6in2inAEv4fOYTTyR
         M+vQLKWhe2L7+XcJ+fZNfl8g2UBKwH9j45Sjy9npT5IjvrMMDqSWBK01TTZq1twJTYfw
         9lUVldKKF9Y7K7x8AMcIkQRC1utdL/Qg05sDvOwg5yFm6Bek1R0Nc1veMLzxfuUcdUSb
         ES9t63zvDOV3/MkI1+e68rna/qr64Cpdn8gB68sD0vceXVGwUyTrTdo3juqWDf0NzDkL
         JnaA==
X-Forwarded-Encrypted: i=1; AJvYcCUyAwz5Xwjuav2DmTYvOOmKt+U7UyPJS9g5rBCRX52LmnucAyREtSTnpd4amnQ81610lpdVxKgX5xwg@vger.kernel.org, AJvYcCVFGsOgAgF+dbmGaVta5/Qrww4hAJY/DtKdZcvNIp2L2fx0Qlor5AS6dAev0hkEqaS6A9ptLjnM/zStaX/l@vger.kernel.org, AJvYcCXNjtg+W8vo01qTX6ZfUuPVpQsPHmdeYtfouxbXbJ+cbzj8bip2iI3X5HtVDt8D1XPJQeu9ls/B@vger.kernel.org
X-Gm-Message-State: AOJu0YwN1UBALss8fJIJb/lQERdeyCS7lY96h/eVU+6Ck5MS9lh1yzai
	/K5w5ZOt3BCL1lpAgNo8uWxiIBV0T3GdgK8JENfKmQ1AKchavxN8
X-Gm-Gg: ASbGncuegFUom4ZvLXF/PhKuVs91NrZdv3Opjzbt5EgnJZyLe08yz/7PfKlYbv39NH5
	xXQMO40EP/rREeIxW/vCK+s3HQ0HKl98ttzFzYm7EG+72VDegZAHe/DiYAfqua+CmDWBXC2tFSa
	TpOEzINDOR2ZX8bqRZ3uhFmQpluai0nwHcWKR8e+M2kEa5cU+2IFEQkYPwvbRhV1/EMchI7Cf34
	sJP3Byu+jqjCJQM3VqGA+ia34U3U7TFv+huJwVc3VJOmx3H66mdEtxgiozwVud90YmO4u1wLftb
	sRMa52U4QxmJExcAVVW/85NVnfivu4xykwWIVx/vK4Z0bXK7nqQx1eZ2H3yi5GzobYWWlEeCWI3
	tnE2P9N6HOK84FkkYNiVUg2k/574WFvw=
X-Google-Smtp-Source: AGHT+IFXCPvOH+Bl0GOCcZZfsHkVWH8TlBB8Wsfu39SLQaVZ3YE4Fzkrf4cNMCkqAZKJSKwW3S53LQ==
X-Received: by 2002:a05:6000:18ae:b0:3a0:831d:267c with SMTP id ffacd0b85a97d-3a1f6433a0bmr9412917f8f.18.1746994406860;
        Sun, 11 May 2025 13:13:26 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-442d67ee275sm100615165e9.19.2025.05.11.13.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 13:13:26 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	llvm@lists.linux.dev
Subject: [net-next PATCH v4 04/11] net: phylink: add phylink_release_pcs() to externally release a PCS
Date: Sun, 11 May 2025 22:12:30 +0200
Message-ID: <20250511201250.3789083-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250511201250.3789083-1-ansuelsmth@gmail.com>
References: <20250511201250.3789083-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add phylink_release_pcs() to externally release a PCS from a phylink
instance. This can be used to handle case when a single PCS needs to be
removed and the phylink instance needs to be refreshed.

On calling phylink_release_pcs(), the PCS will be removed from the
phylink internal PCS list and the phylink supported_interfaces value is
reparsed with the remaining PCS interfaces.

Also a phylink resolve is triggered to handle the PCS removal.

A flag to make phylink resolve reconfigure the interface (even if it
didn't change) is also added. This is needed to handle the special
case when the current PCS used by phylink is removed and a major_config
is needed to propagae the configuration change. With this option
enabled we also force mac_config even if the PHY link is not up for
the in-band case.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/phylink.c | 58 ++++++++++++++++++++++++++++++++++++++-
 include/linux/phylink.h   |  2 ++
 2 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 95d7e06dee56..2f28c4c83062 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -84,6 +84,7 @@ struct phylink {
 	bool link_failed;
 	bool suspend_link_up;
 	bool major_config_failed;
+	bool reconfig_interface;
 	bool mac_supports_eee_ops;
 	bool mac_supports_eee;
 	bool phy_enable_tx_lpi;
@@ -895,6 +896,55 @@ static void phylink_resolve_an_pause(struct phylink_link_state *state)
 	}
 }
 
+/**
+ * phylink_release_pcs - Removes a PCS from the phylink PCS available list
+ * @pcs: a pointer to the phylink_pcs struct to be released
+ *
+ * This function release a PCS from the phylink PCS available list if
+ * actually in use. It also refreshes the supported interfaces of the
+ * phylink instance by copying the supported interfaces from the phylink
+ * conf and merging the supported interfaces of the remaining available PCS
+ * in the list and trigger a resolve.
+ */
+void phylink_release_pcs(struct phylink_pcs *pcs)
+{
+	struct phylink *pl;
+
+	ASSERT_RTNL();
+
+	pl = pcs->phylink;
+	if (!pl)
+		return;
+
+	list_del(&pcs->list);
+	pcs->phylink = NULL;
+
+	/* Check if we are removing the PCS currently
+	 * in use by phylink. If this is the case,
+	 * force phylink resolve to reconfigure the interface
+	 * mode and set the phylink PCS to NULL.
+	 */
+	if (pl->pcs == pcs) {
+		mutex_lock(&pl->state_mutex);
+
+		pl->reconfig_interface = true;
+		pl->pcs = NULL;
+
+		mutex_unlock(&pl->state_mutex);
+	}
+
+	/* Refresh supported interfaces */
+	phy_interface_copy(pl->supported_interfaces,
+			   pl->config->supported_interfaces);
+	list_for_each_entry(pcs, &pl->pcs_list, list)
+		phy_interface_or(pl->supported_interfaces,
+				 pl->supported_interfaces,
+				 pcs->supported_interfaces);
+
+	phylink_run_resolve(pl);
+}
+EXPORT_SYMBOL_GPL(phylink_release_pcs);
+
 static unsigned int phylink_pcs_inband_caps(struct phylink_pcs *pcs,
 				    phy_interface_t interface)
 {
@@ -1688,6 +1738,10 @@ static void phylink_resolve(struct work_struct *w)
 		if (pl->phydev)
 			link_state.link &= pl->phy_state.link;
 
+		/* Force mac_config if we need to reconfig the interface */
+		if (pl->reconfig_interface)
+			mac_config = true;
+
 		/* Only update if the PHY link is up */
 		if (pl->phydev && pl->phy_state.link) {
 			/* If the interface has changed, force a link down
@@ -1722,7 +1776,8 @@ static void phylink_resolve(struct work_struct *w)
 		phylink_apply_manual_flow(pl, &link_state);
 
 	if (mac_config) {
-		if (link_state.interface != pl->link_config.interface) {
+		if (link_state.interface != pl->link_config.interface ||
+		    pl->reconfig_interface) {
 			/* The interface has changed, force the link down and
 			 * then reconfigure.
 			 */
@@ -1732,6 +1787,7 @@ static void phylink_resolve(struct work_struct *w)
 			}
 			phylink_major_config(pl, false, &link_state);
 			pl->link_config.interface = link_state.interface;
+			pl->reconfig_interface = false;
 		}
 	}
 
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index ef0b5a0729c8..c5496c063b6a 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -717,6 +717,8 @@ void phylink_disconnect_phy(struct phylink *);
 int phylink_set_fixed_link(struct phylink *,
 			   const struct phylink_link_state *);
 
+void phylink_release_pcs(struct phylink_pcs *pcs);
+
 void phylink_mac_change(struct phylink *, bool up);
 void phylink_pcs_change(struct phylink_pcs *, bool up);
 
-- 
2.48.1


