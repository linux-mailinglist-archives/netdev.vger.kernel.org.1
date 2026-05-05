Return-Path: <netdev+bounces-284551-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YN2lEq82+mm0KwMAu9opvQ
	(envelope-from <netdev+bounces-284551-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 20:27:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 299994D2A60
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 20:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 61BE030229C2
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 18:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BBF4ADDA5;
	Tue,  5 May 2026 18:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F66qPCo1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2284ADD90
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 18:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778005654; cv=none; b=n8j/GW1HuqJzgBNZ0Dv6W49HNih27Qeyrvqqb22r7tnmc1h2QM1ctrnbwi8uiW/MMy7gd0fZpWMECQTRd5+HgvN99gY13BzkpcUWjJdycchhyBhgGPsLy7gJOJnl6TiJ8ia1OFN+KN93Kl5QpLbHfslhF3dO31vtsZxT/XaXKSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778005654; c=relaxed/simple;
	bh=PkLb8wZz3LN/U9OfvMiROxZgNCLmAY4Q33Wx8Bh9oLc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yf9bevDFcL0cwKfv2QIxB1S6yBGVJoHLxp0hz4xCur+wrDMPjUottWUjje1+vv7AHTtJzUjjHZgux9q/vNHMgjJP9F3RFl+Ojm4w4x8iip8pXdfEo9AN4YdINNyNdtlwroJX/XkKdmC3Ueq9oUXBrMA+dnDyY4G3Hg7P/ysXuzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F66qPCo1; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso42986125e9.3
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 11:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778005651; x=1778610451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qWs5na6Cu2X9woRa7xyM3F4TzvlhNiNJPEUsaW9Eszc=;
        b=F66qPCo15L0/Fj9y7Y2hMMkzKPpsV2ddOd3fXyuJEbDBcji/plsYmRmVQoBbt7bjVq
         eikjmocvaa9lRUJNovGyUEFaljbHHdzG+JVberjnlu19klW4GINh3AxH0NeRk7NB4ySU
         TegYExugjfQelXuD/GX2ExFSS9GLAU8Rn7wueWp2LfxYhZLDoM8jG+Nbgya8Yb7El49T
         BbZBu9eEg5NFDyG2G5iFwU4upZw+tJtOC4Yhhzvr4UPEpZ8AqIvyE8c8mSOJVX81BJQ8
         OUTaoAiui5895g2JY1DT0NELo4bbETYo7StDdeCYcK0HlMfflZ5nHvOJ8JRnjbX61TaG
         fD/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778005651; x=1778610451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qWs5na6Cu2X9woRa7xyM3F4TzvlhNiNJPEUsaW9Eszc=;
        b=BZUE7H8GdIA+l/7ERl6FHGqtXziIjQWn2cW7npU8tOKFf1n6YwgosaiQsMFhlDa6JQ
         6J55S5dTBt8SXDszek5uTCAbhqQ2SLfSAI+jgdeSNVxqH+4Onpo/1CHBQVXAsyoX0Aki
         pvuSRV6ZtUnP83tgBXzgbjKTXN3MMCWRFCLP4XjWto95S+U3pmfRtqGRGwWgJlla6H1d
         DJQpq4GFX23ctbAquC7vSXSa1ywDQu1AMavE5B0E+G5OJaC2mQH68yOelFmLK/SuogSo
         ziHaWXa6MbLcxZxBR+XyjsZwsdcywZFojjDQhadenbUC91iPkNMaBDrDTBRPJCfXsWJN
         y2zw==
X-Forwarded-Encrypted: i=1; AFNElJ+i8xH9LvwPGn6FNnMpzG/DsOgy/0N+gh7SJT6Cpfb6jtBStULCn4+VjJ7GTxKJi9cLlQx3SRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YybhnwV8K985gCF3Wc1UrjMtn0kVUhw9ZePBhRUUYN+WFciQbLy
	+V6H+i2M3vOkoZQQzLfcgHxOuiZk7zZ9E/5r0/lEW17lnXhRkBmpMGSK
X-Gm-Gg: AeBDies4ByKpK1Iri46CDghNvhv71hHmDWAAlWnDEcdXMw1+Y5RpqceYf3uqlclYi6g
	aLx5zIraofI6gBJPogAhII7VsqckBcZygBVG917prRWDRJ9HNts71N43q0exzGTVzgYmcdhbiLY
	F/QPTsT+eeDUQgMKzuUKD05gj3la1r52/Dg90Kbff4SEGKucxJ/3fsMBdjrYwEw9gJUMr57tJSa
	mEvqGZIhI+pHMk3thLnzmgvSlqj5xpQ1bPV1xEgf6vbs3R5GONri1/Ck7hbigPEtA39ZCt2tzlZ
	NUFTDNlXNDHi+F+Tan7SjnAy2E3sq6sq+pkWWCHDE33bJrNR+GVT2ksqY9fvtQukGAv/407FQbg
	9e2J7IZKq7j7L5DWyQjDdxfCVFDvEwj5O4Edh4Pe3pvCT0yhwPOmGwpbwRceiDEYN0Ze2wiK4uN
	jh4G3px1/7CNbfYk2AmkoVKAM7FDojGK6WKMm4yzS04y0HsYUr8jeGSXjCne2pFEN3yC6n6NErx
	pA5LKY=
X-Received: by 2002:a05:600c:a110:b0:488:9e43:9690 with SMTP id 5b1f17b1804b1-48e51e17746mr5220405e9.10.1778005650787;
        Tue, 05 May 2026 11:27:30 -0700 (PDT)
Received: from Ansuel-XPS24 (host-82-59-227-65.retail.telecomitalia.it. [82.59.227.65])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48a820c865esm408208245e9.5.2026.05.05.11.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 11:27:30 -0700 (PDT)
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
Subject: [net-next RFC PATCH v5 03/10] net: phylink: add phylink_release_pcs() to externally release a PCS
Date: Tue,  5 May 2026 20:27:04 +0200
Message-ID: <20260505182713.27644-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505182713.27644-1-ansuelsmth@gmail.com>
References: <20260505182713.27644-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 299994D2A60
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-284551-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,pengutronix.de,makrotopia.org,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ansuelsmth@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt,lkml];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Add phylink_release_pcs() to externally release a PCS from a phylink
instance. This can be used to handle case when a single PCS needs to be
removed and the phylink instance needs to be refreshed.

On calling phylink_release_pcs(), the PCS will be removed from the
phylink internal PCS list and the phylink supported_interfaces value is
reparsed with the remaining PCS interfaces.

Also a phylink resolve is triggered to handle the PCS removal.

The flag force_major_config is set to make phylink resolve reconfigure
the interface (even if it didn't change) is also added.
This is needed to handle the special case when the current PCS used
by phylink is removed and a major_config is needed to propagae the
configuration change. With this option enabled we also force mac_config
even if the PHY link is not up for the in-band case.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/phylink.c | 49 +++++++++++++++++++++++++++++++++++++++
 include/linux/phylink.h   |  2 ++
 2 files changed, 51 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 1a261060d78e..ca4f4f655a31 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -923,6 +923,55 @@ static void phylink_resolve_an_pause(struct phylink_link_state *state)
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
+		pl->force_major_config = true;
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
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 9c5a43febde1..aef4a4fcf6e5 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -746,6 +746,8 @@ void phylink_disconnect_phy(struct phylink *);
 int phylink_set_fixed_link(struct phylink *,
 			   const struct phylink_link_state *);
 
+void phylink_release_pcs(struct phylink_pcs *pcs);
+
 void phylink_mac_change(struct phylink *, bool up);
 void phylink_pcs_change(struct phylink_pcs *, bool up);
 
-- 
2.53.0


