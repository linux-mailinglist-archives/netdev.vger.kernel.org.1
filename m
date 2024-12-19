Return-Path: <netdev+bounces-153500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D649F8551
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 21:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AA1F1882D4C
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 20:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8CC1C07CB;
	Thu, 19 Dec 2024 19:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uN6ThgxO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267F21EE7BC
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 19:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734638351; cv=none; b=FQ3AiENtsLZLKiZrKlAGy+Mrl/4i9O1AirvKxpzu/gpGIm9i9Drlo7OiP2bvNXK4OJ/dSg6S1df2yHTYEhViQEvIaBLrAToQ8Qb5BNCEce/7dvZGuhkpL+Ls1nXYTX3alzJsAEBfNKgjgsQle/aDU/x0Zol3lWE+j680XN3/680=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734638351; c=relaxed/simple;
	bh=LNk2Yj//BXYCvnGeYALUx0IGjDCStCiWRmkgerTUxYo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XcaZr7XIg2PnmP3mXYxtpKUQMDcqXeIclkZ3Ofu7t5Gf77rMP5KS4T5r0dvTPkwFhSiMFGHUSZhZuabpU+NJ1vYUafL7tj2hE1wgnUOhhgv3hH2J2s03Ur8N09Q7N4AOh63NzLffQReJ2i18enPqL+0+E4i3cBEiI9ooeCNBiyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uN6ThgxO; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa5f1909d6fso193552166b.3
        for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 11:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734638347; x=1735243147; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HUvfT27SCPJ/1I/rQ7u1CFfvkxFi4BwZuv6rcMUwBXw=;
        b=uN6ThgxOEWEMaapmYxeupmuNtxOw3GIX5wf2qXGTb9cidnV6Bpwd6NhBz0j/2fBCzf
         f6stEFeEKk4X6YJW03MPjsdLrsp+gZbYbxugtf4o6dfghrBOhds9YJOb1MBFWpP36lxx
         HPz0eOGLxry1bVQfvaughJ4I7SGHt4IirEruocPTguJZeJ0w4BF4Vdw/Hflu0oYwV9+G
         vP1NZipgv1uKOkGyehxM4E24zEQa9bJnoHkPI4FsPxbpUmnCW4S5L5TnWQqiZfPUqUmh
         TrJYsmXACtoMgXT0WO1FfjcVede83f6Y9pc7Pw08v+60ZGKGvaaR4lo351SwertJDE6J
         bq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734638347; x=1735243147;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HUvfT27SCPJ/1I/rQ7u1CFfvkxFi4BwZuv6rcMUwBXw=;
        b=jWZSb8K/RZzCBIOtcGK9Akl0JqCEr/Qi1b8n8eP1ieg/xivKe2uSgjSc4EwLaPEw8D
         ZVQ35De/1VBsbzpGnGI7mANec0ZXPRMeFE1tATPBAfERSkV7I1suSX3r78iHA4LTB/rg
         OGfuW5FI256zebdCEX6b1zoVLfBQFWtoK1Jw0A25JpbvSAx8szite91wNCSP5L5/DQm3
         TayaB2ntkMyiUc7sO/UkeWsyND5L+oe5HAS9YRfAGExVux+u+f1PCJUyS1ptSrXH/OGm
         bzb2myZLuy7R8z/WxW93YDk2SCkf9VRgGlY2+QZy199evDFkb5X9QfXB53x3bw8QD40v
         wCzg==
X-Forwarded-Encrypted: i=1; AJvYcCX36pIY2xJOyfk2RND3vduADUifsABhPSt+vfiNELN6y/CHCtueCFikDrYO1kVGZju4As77uWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH50TUEZ5+uDclWFql6IYa5ZdWmOv2braC8D4p+e/1AGRWvQhy
	PsTImTvPB4M070r976YFgUq29LuMJ/oB84oqqiizquryQJCJC+NHwyEDtcJQE3Q=
X-Gm-Gg: ASbGnctTUNTR9BTwJm+wL+fQcLwEpXw+DvBDCqEAgFqcZln9GGlIiWjUrirMzFdRz+U
	XRxDaVZPL1ctiLSeeUH/cx8yV6DKdkZW+sjpT/uBLT8Mefsyiqgj5SVD+6G/fDJuqjFhLdvtTA4
	b4O18N0vg6dAmF6fzzADZm5Q9Ytl9UjwQZiN3+uFTrIC7VYva3lpglYvvy2SCtXZX3ZeO4OxkLq
	v9NELKdwZyoHfWNiIVqIYVIXoxkiyPLvUEzwKva8lB6fUuQyQ==
X-Google-Smtp-Source: AGHT+IH/fZzedKlcK5U0wriyo0zt+BLfVIxeZ3sOC7b5Lbwtvat8IssszxYlnVAebbWoaHGw9AkAhg==
X-Received: by 2002:a17:906:478f:b0:aa6:6c46:7ca1 with SMTP id a640c23a62f3a-aac27038e93mr8059666b.10.1734638347397;
        Thu, 19 Dec 2024 11:59:07 -0800 (PST)
Received: from localhost ([2001:4090:a244:82f5:6854:cb:184:5d19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0f015b1asm98230866b.148.2024.12.19.11.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 11:59:07 -0800 (PST)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Thu, 19 Dec 2024 20:57:55 +0100
Subject: [PATCH v6 4/7] can: m_can: Support pinctrl wakeup state
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-topic-mcan-wakeup-source-v6-12-v6-4-1356c7f7cfda@baylibre.com>
References: <20241219-topic-mcan-wakeup-source-v6-12-v6-0-1356c7f7cfda@baylibre.com>
In-Reply-To: <20241219-topic-mcan-wakeup-source-v6-12-v6-0-1356c7f7cfda@baylibre.com>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, 
 Dhruva Gole <d-gole@ti.com>, Simon Horman <horms@kernel.org>, 
 Vincent MAILHOL <mailhol.vincent@wanadoo.fr>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4086; i=msp@baylibre.com;
 h=from:subject:message-id; bh=LNk2Yj//BXYCvnGeYALUx0IGjDCStCiWRmkgerTUxYo=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNJTqj7dOLK0YW7EhP5JSS/+Pw9YorDKzmGl0NlpLTKp9
 6IzhE/O7ChlYRDjYJAVU2S5+2Hhuzq56wsi1j1yhJnDygQyhIGLUwAmskiIkWHzS+bt04r/yzNO
 9NWQ8zhcIVIzp//2Kaf9Dd8/bmvyuxvP8E9Z5obMcjnNn/5xPz4Z9cxVy8jbcfAce9lGW5mz2Yu
 7bvMAAA==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

am62 requires a wakeup flag being set in pinctrl when mcan pins acts as
a wakeup source. Add support to select the wakeup state if WOL is
enabled.

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 68 +++++++++++++++++++++++++++++++++++++++++++
 drivers/net/can/m_can/m_can.h |  4 +++
 2 files changed, 72 insertions(+)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index e69e9799710b3e4cb267324e8e9db40ca02328e2..ce39685a7c42a2238ad8afd6cf53aa53c9bbb3bb 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2197,6 +2197,7 @@ static void m_can_get_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
 static int m_can_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
 {
 	struct m_can_classdev *cdev = netdev_priv(dev);
+	struct pinctrl_state *new_pinctrl_state = NULL;
 	bool wol_enable = !!(wol->wolopts & WAKE_PHY);
 	int ret;
 
@@ -2213,7 +2214,28 @@ static int m_can_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
 		return ret;
 	}
 
+	if (wol_enable)
+		new_pinctrl_state = cdev->pinctrl_state_wakeup;
+	else
+		new_pinctrl_state = cdev->pinctrl_state_default;
+
+	if (IS_ERR_OR_NULL(new_pinctrl_state))
+		return 0;
+
+	ret = pinctrl_select_state(cdev->pinctrl, new_pinctrl_state);
+	if (ret) {
+		netdev_err(cdev->net, "Failed to select pinctrl state %pE\n",
+			   ERR_PTR(ret));
+		goto err_wakeup_enable;
+	}
+
 	return 0;
+
+err_wakeup_enable:
+	/* Revert wakeup enable */
+	device_set_wakeup_enable(cdev->dev, !wol_enable);
+
+	return ret;
 }
 
 static const struct ethtool_ops m_can_ethtool_ops_coalescing = {
@@ -2341,6 +2363,44 @@ int m_can_class_get_clocks(struct m_can_classdev *cdev)
 }
 EXPORT_SYMBOL_GPL(m_can_class_get_clocks);
 
+static int m_can_class_setup_optional_pinctrl(struct m_can_classdev *class_dev)
+{
+	struct device *dev = class_dev->dev;
+	int ret;
+
+	class_dev->pinctrl = devm_pinctrl_get(dev);
+	if (IS_ERR(class_dev->pinctrl)) {
+		ret = PTR_ERR(class_dev->pinctrl);
+		class_dev->pinctrl = NULL;
+
+		if (ret == -ENODEV)
+			return 0;
+
+		return dev_err_probe(dev, ret, "Failed to get pinctrl\n");
+	}
+
+	class_dev->pinctrl_state_wakeup =
+		pinctrl_lookup_state(class_dev->pinctrl, "wakeup");
+	if (IS_ERR(class_dev->pinctrl_state_wakeup)) {
+		ret = PTR_ERR(class_dev->pinctrl_state_wakeup);
+		class_dev->pinctrl_state_wakeup = NULL;
+
+		if (ret == -ENODEV)
+			return 0;
+
+		return dev_err_probe(dev, ret, "Failed to lookup pinctrl wakeup state\n");
+	}
+
+	class_dev->pinctrl_state_default =
+		pinctrl_lookup_state(class_dev->pinctrl, "default");
+	if (IS_ERR(class_dev->pinctrl_state_default)) {
+		ret = PTR_ERR(class_dev->pinctrl_state_default);
+		return dev_err_probe(dev, ret, "Failed to lookup pinctrl default state\n");
+	}
+
+	return 0;
+}
+
 struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
 						int sizeof_priv)
 {
@@ -2381,7 +2441,15 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
 
 	m_can_of_parse_mram(class_dev, mram_config_vals);
 
+	ret = m_can_class_setup_optional_pinctrl(class_dev);
+	if (ret)
+		goto err_free_candev;
+
 	return class_dev;
+
+err_free_candev:
+	free_candev(net_dev);
+	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(m_can_class_allocate_dev);
 
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index 92b2bd8628e6b31370f4accbc2e28f3b2257a71d..b75b0dd6ccc93973d0891daac07c92b61f81dc2a 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -126,6 +126,10 @@ struct m_can_classdev {
 	struct mram_cfg mcfg[MRAM_CFG_NUM];
 
 	struct hrtimer hrtimer;
+
+	struct pinctrl *pinctrl;
+	struct pinctrl_state *pinctrl_state_default;
+	struct pinctrl_state *pinctrl_state_wakeup;
 };
 
 struct m_can_classdev *m_can_class_allocate_dev(struct device *dev, int sizeof_priv);

-- 
2.45.2


