Return-Path: <netdev+bounces-189591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB82AB2ACC
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 22:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9141D7ABD8D
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 20:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5742426738F;
	Sun, 11 May 2025 20:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwoD1JKD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C5125FA2B;
	Sun, 11 May 2025 20:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746994417; cv=none; b=UP6YqThZ4Zu5MufhRjLGhZdjJee/I4TBOvHPmdhKgPGhkoU5jkM1czWV4wIteVOCOJ1mkpCEXpXsdDG2OsvsMX9HVf8ztrjrFpviJlSdeph3r/NsvNNjxjkIgDawBXYfm6jj7pB3KcpoIESZGfGC2mdZAQe0J8UKTC7KdykXsYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746994417; c=relaxed/simple;
	bh=gqKPur9Mdhiy0psYhphHRNk5Arh43cVbpCy9/OXJHU0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lR/O7X4yl6FQ2MWsdP4f5y6m+FQ6xYRVBe+YorS+2LaLYSv6jMRDZgeaWckB9Yr4oYqaxPLryJ4AEuM7yYh8mmHY5cZTxNminQMakVZGVubCEgBxphYMmq4V20ECZp1+3ifdMUcA0UBLGLZ5+I/sWhtAtH0onTjnnDUkRqWe5tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bwoD1JKD; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43d0618746bso28318735e9.2;
        Sun, 11 May 2025 13:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746994413; x=1747599213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hG/K7/CcnoPnU06F7gqSInpeWfEZ3X7ik6awgPKsA9U=;
        b=bwoD1JKDGDmffh2C9rdhxjKPn7WlGwMUGU29HlHs3WPkh/IPK5fwl58RQVLTdAivc3
         hN6dxUr48bxvKUYWlXdgkZOH8mWsVmTap7x0IDvrzLGSWXJwYESmGasqsz+HGESjccZa
         bkiScheR3UngHVWeCxCJyCtFFQ6aGjIppNomjEwJYAHAvSDL8MWE6MBVi/L8G3M2Qzba
         dF4oeW1nV48P70ienagLnEuQ0GYcCylroJJ1tm+yI3SEh/kaRIvwv/QvEK0EtZzzcmc+
         NVlagTiqtSGE5S15sxm5FdUCQCWMOMm9H4Mbke1RhZCGzgPoYzwvnavimmfEJlBmGSUr
         RbHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746994413; x=1747599213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hG/K7/CcnoPnU06F7gqSInpeWfEZ3X7ik6awgPKsA9U=;
        b=Lc/cXjEDbowSYQc0MR/xl+ZCBCbhn8HuOjiiikx8GbVcb5PL0oy8IO9KC6nxJLg/ex
         AR7CfxdaHcq9WzYIfbEuBlcLSraRSElklNn8ml+UEmyYHwgkhcGG2Xb3le/ve3rwr3sW
         n91j9mUhdrNQkUdTacyXOrU5SXyL/3/S11QULIvR2vY4PpxQw6wXvf8dCTDfZA0irdGt
         sC2iSzNWuATIdBW2vj0DF90VEGsDpJVp1iqeZZpZraeM0+CAHSCWp5wWQx1TQt4w/Olh
         f9pCRuAfLd9uc2+zT61P7GnvXv3T5X1GhXFiWR4XU9HaVjc704J+C4H7RjKRg15ScE92
         2wWA==
X-Forwarded-Encrypted: i=1; AJvYcCU9QXNVjZBEnFvnyGgrb4Ty7vs/KHXz5jP3j5xU/mYg3AsN2orG7FhXoV3d2COl68BJGCmRD2Cp1y3z@vger.kernel.org, AJvYcCV1w3+Daf81E04DUoJ/AxOmVFrPKjDj6lsVyY6yft/mhW44fmNgrNc9tbzPSeZ/uPQ3B/DDA43p@vger.kernel.org, AJvYcCVQHYqUoFLByUXYTbDBQuzV7sNrUHRtCJh1Y/uSAhtTRng2kc9kGb020+F1Y0WJs1XDAuWTkkV7RCLZDMGY@vger.kernel.org
X-Gm-Message-State: AOJu0YyfXFqEDyIx1scM+rtytwaMSx0xPsOo0XRVjZqnfdKQBnBfJ4bI
	FZAp5ktg9CjQfK6ZVXvU/iBebKOg0lDnQ4gsTSavc/JKmzfnSR5S
X-Gm-Gg: ASbGncu3fbH49c5vDVRzOuAJ0wsuhfEnDBZnEBXBN3hSZO2iWnXsik4eizv3ze3eIeB
	7NdcN9iiDraBVkW5PSi+c7m58qa4LorSMALIPAou8BajOpVS8He77hQqyeYvb+M7dI3KNEp4cBP
	0igoswB2QAnm8cIh9jZKSSvXFN/+hvd8RMeVozWxF/Rxr44DL+9tRLR7nAzdsi+TgEzVCsrIalN
	+XvlTwMmvbxU7/31WB+A8ndYKo2+JYM4TtKYokb/byvNa0OFq43ZNPnDG26iqyVF8DFfQ5yJlk/
	cw/1cIu4mUvBWvN9jTWE45XXYBYZsrmrgCcjiG3Psx3TQubBt2yp4Jiwf+XTMh7U/QksklbWRHk
	+zT8sxs6e25xFvAjD2Jio
X-Google-Smtp-Source: AGHT+IGGCa7Alqq6J/p30a6EixQuNCj9gDOJTU7dC1o71lcggGsCPUwPts/GbLPkrX6Teoy99aBGYA==
X-Received: by 2002:a05:600c:8205:b0:43c:eea9:f45d with SMTP id 5b1f17b1804b1-442d6d6b6b3mr87885895e9.18.1746994413252;
        Sun, 11 May 2025 13:13:33 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-442d67ee275sm100615165e9.19.2025.05.11.13.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 13:13:32 -0700 (PDT)
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
Subject: [net-next PATCH v4 08/11] net: phylink: add .pcs_link_down PCS OP
Date: Sun, 11 May 2025 22:12:34 +0200
Message-ID: <20250511201250.3789083-9-ansuelsmth@gmail.com>
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


