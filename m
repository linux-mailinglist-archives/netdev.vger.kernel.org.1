Return-Path: <netdev+bounces-189460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3F8AB2368
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 12:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50B9A4C5924
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 10:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29622459DC;
	Sat, 10 May 2025 10:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDPiStJ1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BE5243956;
	Sat, 10 May 2025 10:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746872679; cv=none; b=O1d/eTmQQvOe1ZdVNinQP/7BDIo0bzZuSsg16WukMFzTIQMNrLbw7oYVn1jThmtwuk+ix9Bq/iWpmvItBTmfy0GVfOLZtZT5gMHop+m4rFQG0pSBdHaXEjkdc/bDmSBV+pj2zaxq7UqLlqtPmz2Jdq1OGWqrAPnE/zgx5BB7ofo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746872679; c=relaxed/simple;
	bh=gqKPur9Mdhiy0psYhphHRNk5Arh43cVbpCy9/OXJHU0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J4t8Nho4k0ENEDzEvYZjAD6f9xBA2/60Mnj9Oz8EHE/MosFWQiGJy2NZ3EqKq2FaZ/78JSqX5wuXSce15rC97k+nlLSgk7/gGy8t5gY/cIIZRfE78jrBCE3fHuzdONee93HtpC0V72IJ9T2BgM2sNYGKpasFnXAU1LAtPWDQUwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iDPiStJ1; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cf628cb14so27424195e9.1;
        Sat, 10 May 2025 03:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746872676; x=1747477476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hG/K7/CcnoPnU06F7gqSInpeWfEZ3X7ik6awgPKsA9U=;
        b=iDPiStJ1vP+llxs8JOgVUNR2GxPf+9figfRj/v1GcCAldPEkAps/0AUOJWmS7TBTvR
         0urIFBxtSz3tefDPldFdMXKmnA0t47BbkpXj1ud82EMegZttWQdvbIYhOZ4wC54/nH/N
         s7sXo98jxSDN4RFLs2Yd8Ahx7/wBtb7jXnP6CIKvnSRGdz+sUTaB0doIV8iPBN4dkZh/
         jfOBTBarh/dTQiFmSu6MHnTKgj6FyaNjKkP1aPsSqNWEhQk7bxmj23juzaW7EsEQg4/B
         2QdIeTWrcyeiZuQtXmd21el40nUFSwXKOMAidHo1WFDXVwVzfFKy2C5bz1I9zDzUN7K1
         d0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746872676; x=1747477476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hG/K7/CcnoPnU06F7gqSInpeWfEZ3X7ik6awgPKsA9U=;
        b=hDhzBBYAZicAgob1j4gNAACJgJBcO57RKS5Z8cYmH9R9ZVw6L4IPh5N5Gb3kVctB38
         y4j8DkBxmTd3mt8aG7QcZsXDPZdMET9+UR6bvRzZeXSC3ABTltKEpyESinp6UQ/BMz44
         mkq3XeczZD51AiRhwprQQe03Eq6tF6nDmbZffQPYVprS5cvKsYWkqwMUrgb93FccxS2A
         aamL8ZIUsl5lTH2nhmQ193gebyQSlIRQIvtHPbwS5+islwPfkAhLAgXdlNJBobacS0Ig
         Z8HhUFndUCrR0na+NGHJV/PMPuIRd+VVjRN5ZsQTYG7AS34YjKiLhaGD5N1KDyxkLpSs
         JSww==
X-Forwarded-Encrypted: i=1; AJvYcCVeYBfqyHKflvuh6lmNiFaIVpA09Y6jMW1wqEH4Lr0bJirallziErFnMmcfJrKMaRcWvbUNAz+n0uLV@vger.kernel.org, AJvYcCWQOh38fk/nzSrma1wfPip/ORBiI+BXamoN+DjSNpy0utm1gbDpZNjmGPwRu7iSo6sj5sHbvVEs@vger.kernel.org, AJvYcCWtBFepaQHWdgshY1vcqHO1TSZfST9VwTW0PFv9MRY2hbNGM6eW528JBQOADFUH/Fh/Ai4EmKXft1CBv4Vp@vger.kernel.org
X-Gm-Message-State: AOJu0YxCLCabcSaRBvwDcPZcD2BfuCnTgoCLrbYzBC+D+gq364WlTdt9
	0N1I2f5ILrirRyTbdsA41G9s2RqgBs3wMOqQ9doaK4Qftd803ohL
X-Gm-Gg: ASbGncucw8De8WXrUHCBKowRYyZ5lwWJvM0NtKlSGQpbJWYzJVvqo4PxCwr0RL9pIQo
	MIsBd2cPTj5wnD/PI5DMMz4APBCznuizd3IjFS1AbswIuS67Uwqa9fD693Gy6RIxW77ogwHDGrS
	jyVUizO+dvfXLrS6Z9TQq6YVwraltrJIapW2S/FBKxtEn1X4Qs/mqEy9SUTI8Hy6W/YS7G5uH5p
	tYUAiVL56Ysov/bjivpJxyh8ILdq13QdAcPAgRQxUHinDPnltssXuS2HDtSUM49gvaPtZyEk/uN
	2FoElia/cpn9pQbbtiy8UrN+g58CZU8/rsZHu3JiaT1TReiqgfFXdi33xh+aHYFTy4AM+yXCT/V
	QwiOqfRv9JddO+9S9TLsQ
X-Google-Smtp-Source: AGHT+IGg0viPLMVzU1ZZnxohpVFCHhptymHD57tQJ0jp+PpbU8jq5GZV781lNRt/rouBpcfZ9YplfA==
X-Received: by 2002:a5d:5f86:0:b0:3a0:b559:cf35 with SMTP id ffacd0b85a97d-3a0b986af1cmr9537590f8f.0.1746872675757;
        Sat, 10 May 2025 03:24:35 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-442d67df639sm57981265e9.13.2025.05.10.03.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 03:24:35 -0700 (PDT)
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
Subject: [net-next PATCH v3 08/11] net: phylink: add .pcs_link_down PCS OP
Date: Sat, 10 May 2025 12:23:28 +0200
Message-ID: <20250510102348.14134-9-ansuelsmth@gmail.com>
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

Permit for PCS driver to define specific operation to torn down the link
between the MAC and the PCS.

This might be needed for some PCS that reset counter or require special
reset to correctly work if the link needs to be restored later.

On phylink_link_down() call, the additional phylink_pcs_link_down() will
be called before .mac_link_down to torn down the link.

PCS driver will need to define .pcs_link_down to make use of this.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/phylink.c | 8 ++++++++
 include/linux/phylink.h   | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 1a4df0d24aa2..39cd15e30598 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1009,6 +1009,12 @@ static void phylink_pcs_link_up(struct phylink_pcs *pcs, unsigned int neg_mode,
 		pcs->ops->pcs_link_up(pcs, neg_mode, interface, speed, duplex);
 }
 
+static void phylink_pcs_link_down(struct phylink_pcs *pcs)
+{
+	if (pcs && pcs->ops->pcs_link_down)
+		pcs->ops->pcs_link_down(pcs);
+}
+
 static void phylink_pcs_disable_eee(struct phylink_pcs *pcs)
 {
 	if (pcs && pcs->ops->pcs_disable_eee)
@@ -1686,6 +1692,8 @@ static void phylink_link_down(struct phylink *pl)
 
 	phylink_deactivate_lpi(pl);
 
+	phylink_pcs_link_down(pl->pcs);
+
 	pl->mac_ops->mac_link_down(pl->config, pl->act_link_an_mode,
 				   pl->cur_interface);
 	phylink_info(pl, "Link is Down\n");
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index c5496c063b6a..8b3d1dfb83a1 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -494,6 +494,7 @@ struct phylink_pcs {
  * @pcs_an_restart: restart 802.3z BaseX autonegotiation.
  * @pcs_link_up: program the PCS for the resolved link configuration
  *               (where necessary).
+ * @pcs_link_down: torn down link between MAC and PCS.
  * @pcs_disable_eee: optional notification to PCS that EEE has been disabled
  *		     at the MAC.
  * @pcs_enable_eee: optional notification to PCS that EEE will be enabled at
@@ -521,6 +522,7 @@ struct phylink_pcs_ops {
 	void (*pcs_an_restart)(struct phylink_pcs *pcs);
 	void (*pcs_link_up)(struct phylink_pcs *pcs, unsigned int neg_mode,
 			    phy_interface_t interface, int speed, int duplex);
+	void (*pcs_link_down)(struct phylink_pcs *pcs);
 	void (*pcs_disable_eee)(struct phylink_pcs *pcs);
 	void (*pcs_enable_eee)(struct phylink_pcs *pcs);
 	int (*pcs_pre_init)(struct phylink_pcs *pcs);
-- 
2.48.1


