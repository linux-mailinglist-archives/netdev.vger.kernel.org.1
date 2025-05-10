Return-Path: <netdev+bounces-189456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24054AB235D
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 12:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85FF9A07E16
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 10:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886C123C8A1;
	Sat, 10 May 2025 10:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/YcFKKd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875802376F5;
	Sat, 10 May 2025 10:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746872674; cv=none; b=dnmqEPAOiQXWLWrTRPPkoGLA4AKulgU7mSiStrxzKC2CC+/qhvvFpZDUIfNzeyPUJtARGDba8Rvc1C38d0BvqS6/RtKzC5GV8HRcsChkhtsy4MsV5o80hZgS4ybCuZNa1yEiAqbdu4CgwhbXUXp6Cr4NIYRC0BBAjRfb3yaAg2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746872674; c=relaxed/simple;
	bh=k2+jZG2fKDLcj1sNgat6nwbjyAPTOdXAGJj7hrPW7/M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H28LM8ydmDseFhbTEzHAFN1+T15YV/sBoaxjBF3Nzk1jccEFE2RvWGMOZiwAfKqMGFTiNzwRWA4wrthXu472h6JGGiv0H8ABRG90sYouKoI0qvYqFttZV+c/nTJADU6TViDa8UzMD+fOdD6mXLPRxuruAK7O5JQtXEa+ehn5bHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/YcFKKd; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cf257158fso19266755e9.2;
        Sat, 10 May 2025 03:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746872671; x=1747477471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0mejOF2mYhTEXxWVOimbjN00Vr4yLk+E8aCpQ2xV2aM=;
        b=X/YcFKKd19x3ceQ2NHEZIzI9zOv69S/ZzGRz0G3lkt80cOwKY45vH5WGt+ORxhbeaa
         JDIq4haSGA+Xx3Q+7B3OOTVJrb6/z87/0Y7orUZZ7xEiMfUwvgYAs7yjcb7mYOt5Y/rL
         1RduvANg1E2d44+NrRQPCvN1Z8Nq+F3vWNy1ofvYUys4HpOg2BLpiQvw6r4VKH1+Inw4
         KCYHqZ9EaC4biSZSlRUTvxOXcWlDD96NJKexn0LBM+9kR2RLHYW26puLLKx/bS/MY179
         Svk/Gr3+djMXMRPcQGndVN73WUzgqK3jpLJiTLEFkwRZxEBKfQ/kvncavxA50jUGwbyP
         KHPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746872671; x=1747477471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0mejOF2mYhTEXxWVOimbjN00Vr4yLk+E8aCpQ2xV2aM=;
        b=VKN7EmhK+I0pveqUARTrSPVmzFC4iC8/tlrmFT0x01MbzeUhzwcmEtQqtRNbiYs7B9
         XU3P3WRS5E5Y1syiE2uVSXbxG8YhVheeMG38mB3AZw8Nq9cF1tsD44GTH4BpbppQ+kLF
         3Q8WfU4v+RDzEgrEo0Uy+45iSjc9P1tqN3VfUXNBtcccsqi8im5ybCnptPj6L8rrJzQi
         51kbqSFcINWQMTVuKCEbKzbiWfjDUXCwkE58xJZx6qLxOv+oWKJbVKMBJxUHEohpFFDE
         Jg15QvEVCzN1Rz+Sw/OixfMcymBNwwtb8OcJZ91eVr+0hcVeRWR032kHCFUSonqz2cx8
         Ai/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVUGBFgzQw9GfbGJetzLLKknAu5IRpptO934pM5Qtt1NwGpz+2+iTPBzVGGV4TbhlksUxp2+oqxLjcg@vger.kernel.org, AJvYcCVg/npSCrn7j4qP/9btIADPh0BOp8uqEQ5JswfqV4AL1ZBCheznLhxuWhwuQINKJwnPskzwkYHs@vger.kernel.org, AJvYcCX7aIOSifguus9DBDhO+1SM8bHZywXdKoKx/1vSJbp5a1i/bZY3klkmNdSxC7IvpZ4WXa7+P8Gx8MJ0fDHk@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+DfcyM+q+mh13zY3bXiziP/WMbvTO3b9o0JrdMEGfi2Qyi/Pm
	XI+VhwNrH9S5uiunnoB2WNjT8sQM8yGjnuTFJB/xw9fugfCPPFng
X-Gm-Gg: ASbGnctaFqQNDSAxrgetNHeg6bk0LJKRa91H1fcXVU2bBy4pJsbWMheTzI7jPg+BxNH
	kCEcFZ2r9g9dLzMcPXw9+QICy35NiYjp1n4s1wqBhhUyCTmoOxbJqWjrsKatU95oyNLSD0hl1d9
	NrcwHHTBy83zOE4ANf4ljiilKkMpA8ug5C4zmMzHHCnsltuAvi1z4GojOov84T6IlHib2z/yRA2
	RoIHxbeAQcVPkCKtljVmxX8sRc+jQwZyMKpE3TwpY/ODyuaTiOk6XltAYdVu5OdmaAIpewbqG5t
	hQYoobGhBJ045cvDC8F61KZGf4zj7Yie2KAGbuAqJVY/Kz3Srv0UHKZmdc4epd319nlqXy5wFln
	egoyTeRDM3fZCvVKn5hTn
X-Google-Smtp-Source: AGHT+IG1BA/TZdRhN9QniKUILc+FgTk1SRS0JYI4MxMh4fAfMKw4nxkmSrVAGEo5cnG6bVfg+l5B7w==
X-Received: by 2002:a05:600c:1f16:b0:43b:d0fe:b8ac with SMTP id 5b1f17b1804b1-442d6ddef8cmr54327525e9.30.1746872670562;
        Sat, 10 May 2025 03:24:30 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-442d67df639sm57981265e9.13.2025.05.10.03.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 03:24:30 -0700 (PDT)
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
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [net-next PATCH v3 04/11] net: phylink: add phylink_release_pcs() to externally release a PCS
Date: Sat, 10 May 2025 12:23:24 +0200
Message-ID: <20250510102348.14134-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250510102348.14134-1-ansuelsmth@gmail.com>
References: <20250510102348.14134-1-ansuelsmth@gmail.com>
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


