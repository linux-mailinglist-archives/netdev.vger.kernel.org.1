Return-Path: <netdev+bounces-179487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A713A7D0F5
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 00:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E226E3A6515
	for <lists+netdev@lfdr.de>; Sun,  6 Apr 2025 22:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6542222CB;
	Sun,  6 Apr 2025 22:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDemkutA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E31221735;
	Sun,  6 Apr 2025 22:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743977709; cv=none; b=f3HKz43UBwJG69CM5iE1OpDCeD7coYwW4tLyKiNSIrThN3o6EEf2joFtXBcHbQug1Y6UEVIzGj/DvqEkOD9R4LvPt2gEqagWccDhB5YjMKlBN3EDQbfrnfuEIYN8RD84eKjseSj4MaJmiM5ed/4YyT5/6JpW42YtSkaJOO6QEJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743977709; c=relaxed/simple;
	bh=5UYlusK9SsEebsrJ4FFWg5Z8bzYzQNkVa7MxT3MQmEQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eUqBcxmRojyciYwdwtM+jFOz2BgQcC53sRAkaY0EZom66MMTplzxNCZ8elkI4/VtS3evUi6uRSln3wtJKbvC97+PDpEkedSyaYkvKaQFyd2Q4hbPiPrLblpnCEZe05yxBBY7tHj7Bd/5aNKmP2upcZ4kljK3+YNJAHbXyNnjqeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NDemkutA; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cf628cb14so31146725e9.1;
        Sun, 06 Apr 2025 15:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743977706; x=1744582506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dHvlV+lAo07PEsn7Y5rgyOxBhBSPObcKBZUiEs7jo8c=;
        b=NDemkutAjLXvnRG8O5sqT5hVCo67l9IU1WNq8NWSkYNytZXGu8TiNGJBYRMVyycYcf
         ipBtDsWT6UTBOOETwc5zdWy5lZpMWSLCDs+KcQT/RDPrQUrXZAoL06cNdwEVhy0z8cry
         d5rqjjR2qsQlra1LTJMNSo4baAi5Q8tz8R7DxlHwVgHqouDi4YKGScjEj1mislAVTJ4c
         ZVzHoeT6IJfmvFZk4tIjTXdz9oFp+xXmadsbhPrR1bvtJPwxOO/VBm0WceL4CoXansGo
         QTABg6ASDPQqXMVHYxg1vX8oyGJVVxh/X+iaE8huRD06Q2o+Z68cXMgBwET+8RIh8Od+
         iA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743977706; x=1744582506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dHvlV+lAo07PEsn7Y5rgyOxBhBSPObcKBZUiEs7jo8c=;
        b=pDHomGqGWUSAqSp1qY3jdF+rA66ftjWQzmb3L/G6Ab3m4/gKFvp0ImX3EEQEhbym3K
         47pCkO8mId1s+ab0sIrEK3xmL30BPs2nXfcgWV0eHZD4uyWHKuaWdPAbqC0Um4dFhomf
         I8YYCwwqaYBDNeesD3BWy5Zjrh8FBOhfBefEWaS1JT5VoXujymMtBsLYPqUyxhZ9OX5g
         wTppIDzv9SM2cvIzisAc0lcb5ZS2d6h7JdECj5hkkYcaXmonuKmwY2FWMSm3XJxs351U
         KgPn5f+XeHm81ABnODiE/6NUEtzK13H5Kg1v++tFYBSf0+Aoxx3MLxfFkF9K/rRApuZl
         hjUA==
X-Forwarded-Encrypted: i=1; AJvYcCVf5j3FDhnE6LJzZo0BrBmcgIvlvEeJTy9gvfRcLzHDlJYjI1+7GXgtOgfwgmVrk7rfF3IYsULLwg3ckuah@vger.kernel.org, AJvYcCWL7tCJ3noyo0yYdvfkzlTSl84RTTSgW3dmTGMCTGSBnRgDJaBoye67egFoGtweNv878oEsq+H5sDYe@vger.kernel.org, AJvYcCXThcDyRUEI4pBNTZFJptzs50n0MXm/g/i/234kQAShyVceMh/4z8M2Z/o18PjIRC8LCv8s7iQz@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+0naPj2Zq8zDyzG9fq3MR1FIgM3hYGAchVab7oG42Kq+Lah73
	85aCLugy+/nYnwuQQ00mhXeKhMw2TmAr3J4+zRNIrjumCO2T9+Ck
X-Gm-Gg: ASbGncuOaH+Mn2YlyqreUFZ+unr3AfWFLSitnH/Q2N6ejLuqeHQ4GILFA6GqJThkW+O
	TOgOjm+DNXYfVO08kyMBTpwjZwrwrR84n2LjRA2wvWfyYQORz0B3gAFNKu4A16S+obJupMreEXr
	6rZ0xre2azV39qSq+p32JkzW9wGEaB5Gg38nTOCluX1nt+/LflTI+/+FDTkd1UARVebeEl+m7zK
	NETGFcufYjcmFDrbQfQrp/z9K2cm8mdPCCxcbfir+G7nrEm76UZ1Rbllq8vDwlcs1hY0koLW/Cy
	8ql7Ct7RxqN1k7uUnT2xWS/ZVZBpWnAfMFda0CFSr/GLmpVTizlKlH4ccGr6rbvkxe33eXBB7px
	tiZSOhFahojFyC4x2bfVJYIQs
X-Google-Smtp-Source: AGHT+IFRTaVaadmWLO6m7IMNHXw2Yzhsjhiip2R7g0xWIMlaJ4D41OkBeAWnSLDQM4PNIiZljl1KyQ==
X-Received: by 2002:a05:600c:1e1b:b0:43d:16a0:d98d with SMTP id 5b1f17b1804b1-43eceee3375mr103173255e9.15.1743977705889;
        Sun, 06 Apr 2025 15:15:05 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43ec366aa29sm111517055e9.39.2025.04.06.15.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 15:15:05 -0700 (PDT)
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
	Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	"Lei Wei (QUIC)" <quic_leiwei@quicinc.com>
Subject: [RFC PATCH net-next v2 05/11] net: phylink: add phylink_release_pcs() to externally release a PCS
Date: Mon,  7 Apr 2025 00:13:58 +0200
Message-ID: <20250406221423.9723-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250406221423.9723-1-ansuelsmth@gmail.com>
References: <20250406221423.9723-1-ansuelsmth@gmail.com>
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

It's also added to phylink a flag to make phylink resolve reconfigure
the interface mode (even if it didn't change). This is needed to handle
the special case when the current PCS used by phylink is removed and a
major_config is needed to propagae the configuration change. With this
option enabled we also force mac_config even if the PHY link is not up
for the in-band case.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/phylink.c | 58 ++++++++++++++++++++++++++++++++++++++-
 include/linux/phylink.h   |  2 ++
 2 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index f889fced379d..e6bb6e5cb63e 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -90,6 +90,7 @@ struct phylink {
 
 	bool link_failed;
 	bool major_config_failed;
+	bool reconfig_interface;
 	bool mac_supports_eee_ops;
 	bool mac_supports_eee;
 	bool phy_enable_tx_lpi;
@@ -901,6 +902,55 @@ static void phylink_resolve_an_pause(struct phylink_link_state *state)
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
@@ -1694,6 +1744,10 @@ static void phylink_resolve(struct work_struct *w)
 		if (pl->phydev)
 			link_state.link &= pl->phy_state.link;
 
+		/* Force mac_config if we need to reconfig the interface */
+		if (pl->reconfig_interface)
+			mac_config = true;
+
 		/* Only update if the PHY link is up */
 		if (pl->phydev && pl->phy_state.link) {
 			/* If the interface has changed, force a link down
@@ -1728,7 +1782,8 @@ static void phylink_resolve(struct work_struct *w)
 		phylink_apply_manual_flow(pl, &link_state);
 
 	if (mac_config) {
-		if (link_state.interface != pl->link_config.interface) {
+		if (link_state.interface != pl->link_config.interface ||
+		    pl->reconfig_interface) {
 			/* The interface has changed, force the link down and
 			 * then reconfigure.
 			 */
@@ -1738,6 +1793,7 @@ static void phylink_resolve(struct work_struct *w)
 			}
 			phylink_major_config(pl, false, &link_state);
 			pl->link_config.interface = link_state.interface;
+			pl->reconfig_interface = false;
 		}
 	}
 
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 7d69e6a44f68..09e19859a71c 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -708,6 +708,8 @@ void phylink_disconnect_phy(struct phylink *);
 int phylink_set_fixed_link(struct phylink *,
 			   const struct phylink_link_state *);
 
+void phylink_release_pcs(struct phylink_pcs *pcs);
+
 void phylink_mac_change(struct phylink *, bool up);
 void phylink_pcs_change(struct phylink_pcs *, bool up);
 
-- 
2.48.1


