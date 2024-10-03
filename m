Return-Path: <netdev+bounces-131780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C8698F8DE
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 23:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAA921F21837
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 21:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12971AC429;
	Thu,  3 Oct 2024 21:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOVknHXL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8926A8D2;
	Thu,  3 Oct 2024 21:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727990634; cv=none; b=sDzN0qNKkBtEFZBgh4EGndL/RSlryluOfebMn+k2NMqrgicuUnqXGowJMqltAwai8xZ4zZ7bW4ATw9jIXVWfSKy7/5YGE69+OagiwfkhhZO7k0oxVaOn+Js3crooylm1YHpInnH8g7OjdVJfovrVFop1eOkDxP/APi3z7EXj+js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727990634; c=relaxed/simple;
	bh=XkPodv5x+4X8rRam3/OSCeg7VfU/gmndd4VUsGSa9xk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nso5hyZOmS0YORXy0poB0SsdLsnUoad2v2gxVe3IIgs2mbCCIyscx4WXo/BfjLHVIePNE9Uu1bGQMumBvLN14pSdY2AVwLT1dBFdfOozvTlnSVcMW9r+lDcYwAP52jMU6NjftGZ2lPS0uqrTi/6P69vLPhkk7uoVL9NQKBeL0+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOVknHXL; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20ba8d92af9so11156155ad.3;
        Thu, 03 Oct 2024 14:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727990633; x=1728595433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OZJebFLhmCbD8vxz1djIvYLFLd1HvoGFeWNCSLBmx+0=;
        b=hOVknHXLYdTu549rXWZXiOEQi2RWuMvtrnlEbSRBDXRIsRvEPfpLYxJc6/AO8opUUl
         gxkg7Xbt3SCwYlV3Vwh36SY7b3Mgj9DypbPtefNaa0qV4p9AiYppfDqfsC2dy8I51gwh
         Vzew0kGcQwA/I5WhEWibV/b6mpU5ychSi5yu3/JbVMXEv7s8d90xY1Et29qxBFZtJNS0
         xVp0lCnVgt3xT4oa2UM+5rapqIWaMNpOToO7V8+YtdUNLw2lIxJMwXYqw0KqUnxj29BS
         HxY5oUxn0kLp5X+i2tmIIaq4extVP5j730JO4zgZMifjHF7HQq/+df4bJxcbzPLv/iuG
         43Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727990633; x=1728595433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OZJebFLhmCbD8vxz1djIvYLFLd1HvoGFeWNCSLBmx+0=;
        b=Q9T2eUgwAtLVkL3ZZZtKRhA9jN/b4eRJLA3nvq1x0nPhIgmi4xig4LHr8gCIuNq/nk
         wdMX0CGDykHd5nUfRjEEVjTNUZNQvXYnNROImnJXnBB/quuaPd77TsoheEmQ4HoSvbve
         RLL8kTBDWcPR7NcVrFob4AiY6IAKtdxxF6jgeR89d03qc7D3Lsgf4HOOPJeJglMpdnMF
         wrhmvdhRNJ4nne7ryByoAJPu68id9ZYCtxxVb4Ck7niYHbbcprFlUqikqz7TtxisRmmv
         lu/1Tm1VwK1mYHpveooyyBl4yGlKUpumKtRl0cW8+7K8uqIJrI/Yxo9ovMqYwMXRIE6F
         6nqw==
X-Forwarded-Encrypted: i=1; AJvYcCW6v05RMVhYA2/70u53i0/tjJsfpgDvr3+bA5F1oXQmvFbSNmEZucliXufNz18Fu1XfAtw8ovEsCMnK7po=@vger.kernel.org, AJvYcCX628lg6YZOXLupXnN3qfHYyBSLXJmlGw34Wkb8B3KectsB/H9+9N0RRbVFgK6jqXGIGPtK3y9I@vger.kernel.org
X-Gm-Message-State: AOJu0YyrFyULEmYrZf1eeYjvci76bJritG++s+oDp/QQeiHvAucwR377
	T6RiPD6GnwYPWd+s+Uib68hqNb8+hJ5yeexc73Me/t3fUMtHU2nB
X-Google-Smtp-Source: AGHT+IG3qat9ib2ZYD4jI7+42ZtVBUMBwVsYIF39VxObv3F3h/MnHY1JxztwfCd/tpIGBtPR6nxE3Q==
X-Received: by 2002:a17:902:ecd1:b0:207:2093:99bb with SMTP id d9443c01a7336-20bfe03529bmr6608385ad.31.1727990632635;
        Thu, 03 Oct 2024 14:23:52 -0700 (PDT)
Received: from luna.turtle.lan ([2601:1c2:c184:dc00:b8ac:3fa:437b:85fa])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beead2541sm13271745ad.19.2024.10.03.14.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 14:23:52 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH] net: dsa: bcm_sf2: fix crossbar port bitwidth logic
Date: Thu,  3 Oct 2024 14:23:01 -0700
Message-ID: <20241003212301.1339647-1-CFSworks@gmail.com>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SF2 crossbar register is a packed bitfield, giving the index of the
external port selected for each of the internal ports. On BCM4908 (the
only currently-supported switch family with a crossbar), there are 2
internal ports and 3 external ports, so there are 2 bits per internal
port.

The driver currently conflates the "bits per port" and "number of ports"
concepts, lumping both into the `num_crossbar_int_ports` field. Since it
is currently only possible for either of these counts to have a value of
2, there is no behavioral error resulting from this situation for now.

Make the code more readable (and support the future possibility of
larger crossbars) by adding a `num_crossbar_ext_bits` field to represent
the "bits per port" count and relying on this where appropriate instead.

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 drivers/net/dsa/bcm_sf2.c | 9 ++++++---
 drivers/net/dsa/bcm_sf2.h | 1 +
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
index 0e663ec0c12a..3ae794a30ace 100644
--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -513,12 +513,12 @@ static void bcm_sf2_crossbar_setup(struct bcm_sf2_priv *priv)
 	u32 reg;
 	int i;
 
-	mask = BIT(priv->num_crossbar_int_ports) - 1;
+	mask = BIT(priv->num_crossbar_ext_bits) - 1;
 
 	reg = reg_readl(priv, REG_CROSSBAR);
 	switch (priv->type) {
 	case BCM4908_DEVICE_ID:
-		shift = CROSSBAR_BCM4908_INT_P7 * priv->num_crossbar_int_ports;
+		shift = CROSSBAR_BCM4908_INT_P7 * priv->num_crossbar_ext_bits;
 		reg &= ~(mask << shift);
 		if (0) /* FIXME */
 			reg |= CROSSBAR_BCM4908_EXT_SERDES << shift;
@@ -536,7 +536,7 @@ static void bcm_sf2_crossbar_setup(struct bcm_sf2_priv *priv)
 
 	reg = reg_readl(priv, REG_CROSSBAR);
 	for (i = 0; i < priv->num_crossbar_int_ports; i++) {
-		shift = i * priv->num_crossbar_int_ports;
+		shift = i * priv->num_crossbar_ext_bits;
 
 		dev_dbg(dev, "crossbar int port #%d - ext port #%d\n", i,
 			(reg >> shift) & mask);
@@ -1260,6 +1260,7 @@ struct bcm_sf2_of_data {
 	unsigned int core_reg_align;
 	unsigned int num_cfp_rules;
 	unsigned int num_crossbar_int_ports;
+	unsigned int num_crossbar_ext_bits;
 };
 
 static const u16 bcm_sf2_4908_reg_offsets[] = {
@@ -1288,6 +1289,7 @@ static const struct bcm_sf2_of_data bcm_sf2_4908_data = {
 	.reg_offsets	= bcm_sf2_4908_reg_offsets,
 	.num_cfp_rules	= 256,
 	.num_crossbar_int_ports = 2,
+	.num_crossbar_ext_bits = 2,
 };
 
 /* Register offsets for the SWITCH_REG_* block */
@@ -1399,6 +1401,7 @@ static int bcm_sf2_sw_probe(struct platform_device *pdev)
 	priv->core_reg_align = data->core_reg_align;
 	priv->num_cfp_rules = data->num_cfp_rules;
 	priv->num_crossbar_int_ports = data->num_crossbar_int_ports;
+	priv->num_crossbar_ext_bits = data->num_crossbar_ext_bits;
 
 	priv->rcdev = devm_reset_control_get_optional_exclusive(&pdev->dev,
 								"switch");
diff --git a/drivers/net/dsa/bcm_sf2.h b/drivers/net/dsa/bcm_sf2.h
index f95f4880b69e..4fda075a3449 100644
--- a/drivers/net/dsa/bcm_sf2.h
+++ b/drivers/net/dsa/bcm_sf2.h
@@ -75,6 +75,7 @@ struct bcm_sf2_priv {
 	unsigned int			core_reg_align;
 	unsigned int			num_cfp_rules;
 	unsigned int			num_crossbar_int_ports;
+	unsigned int			num_crossbar_ext_bits;
 
 	/* spinlock protecting access to the indirect registers */
 	spinlock_t			indir_lock;
-- 
2.44.2


