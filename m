Return-Path: <netdev+bounces-83894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3072894B02
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 07:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F399628300F
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 05:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67E41E534;
	Tue,  2 Apr 2024 05:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jm0ImZcg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9781C287
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 05:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712037544; cv=none; b=FpYS4MaZXy1gb4vvNILrusfwllAjcXzIfcZpycIXxi+bxlW2byNPkdfwmRTAXCXqTJW2J77Eg6dw4orR5C36+MO4u7ovzpjumvlKYUoRh/mofiwgyTxGKGkLqcbVIUfWsTY5q2KyXKS2pyzzWPj3IFbG7V79Nzem/z1MC3JLy3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712037544; c=relaxed/simple;
	bh=w8fn6+LGaLVqhS8crIsqZ0BUgFZZpm5jp8uYVJr9sWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m79RJ8yXekZDPR23Z2S76v+4m2qTGi1IDSxODeBAvtR0xkCzJZIXHYGkMeyF5yDAyIvQwxz/n6joM+rYq3TTuGcIVLei+XiK/AJJ9/gWSUZ6fvW7T8Ng9PiFVHLaBBurCqoaWU5aBStZKn/kKi1jIPL+Qo0/l1YpGqGxKp5CPSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jm0ImZcg; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a472f8c6a55so592082666b.0
        for <netdev@vger.kernel.org>; Mon, 01 Apr 2024 22:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712037541; x=1712642341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWFVQ4guP4fCF27EbKTTsXrsTp0zlLou+J3gTsJX728=;
        b=jm0ImZcgh8zus9ld/S7zQWcK7dlor1LaHkjflZy6UJPKiUk8NyS4WjtXyDdDWTKQJR
         WhcJtg/NBT3iI3UibjyeHd5mRnp0vilJNOgMAixSnVnlo8c0i567JIJzcs2wmR/IjJ8N
         VCEkNVKBr6VZtpFypV9HgXyv2Xhl0b381Fl3taB5SXPm5kPOLgZcXHJ5ALRcMUdLS9h4
         w51a/76/JW71k4f3uyBr3BoYY/s9ldUr9JRF8QDkOev6UqSxBnD6Z3aoXonWPCKWkfWa
         uCC5V66BuKl7OWgJa6jIwEfMGFtzpOs1x4nfxTzNbaOE4i06hmUyyO8dcSeBIDDfggZd
         nBXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712037541; x=1712642341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EWFVQ4guP4fCF27EbKTTsXrsTp0zlLou+J3gTsJX728=;
        b=oih3pTE8jz6oYg62EXJseaF1yMmsx7j6oGfN2RW/TTUKA/KrtKefq1to21YqjPW7Ws
         2MeGO2eLoy7fKbP8wQx4Roiqyx4QeUTmVtFLmOm+NydLHyvLaZPvKrdyYMvQkoAb+2Ce
         aMtlX/hplY6nfW1sldOssvwDAgPTUI2ftBbqPM6M0cZqJotZitd22WnvscgfMKTEcK2/
         3EzsC+TLq3Mo53QmF+VFSofJlHPYCbjIs+mBNliRxewx/29WdJbeVZta2eEKgBlgSvaP
         mYH0GC4BQrub/Y6Hr6NTZO/0KnMQz9GfK11Bf0ML+p2LTqWZJztct8fq/rQRQTv6m6mU
         ffLg==
X-Gm-Message-State: AOJu0YzHAVrPVb7lBvnxlj4yLXBNEXs/Gkxh8T3lUggN+O6K3GpAmw2o
	c4VU6MI325sL6Cd9McBUprnJQlaqjTixnfs2UYAq68iECabR68vZ
X-Google-Smtp-Source: AGHT+IHyOmxdylBaAdGtX/ALZTJpDWBg6b5kPKmI9BNtudTkN/YuGQq1gam6eJPJ65nGBFzhgC+wjQ==
X-Received: by 2002:a17:906:c958:b0:a48:45e7:5d46 with SMTP id fw24-20020a170906c95800b00a4845e75d46mr6876565ejb.22.1712037541454;
        Mon, 01 Apr 2024 22:59:01 -0700 (PDT)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id cd1-20020a170906b34100b00a4a396ba54asm6136636ejb.93.2024.04.01.22.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 22:59:01 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	"Frank Wunderlich" <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v3 net-next 5/6] net: phy: realtek: add rtl822x_c45_get_features() to set supported ports
Date: Tue,  2 Apr 2024 07:58:47 +0200
Message-ID: <20240402055848.177580-6-ericwouds@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240402055848.177580-1-ericwouds@gmail.com>
References: <20240402055848.177580-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sets ETHTOOL_LINK_MODE_TP_BIT and ETHTOOL_LINK_MODE_MII_BIT in
phydev->supported.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 drivers/net/phy/realtek.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index af5e77fd6576..b483aa3800e2 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -844,6 +844,16 @@ static int rtl822xb_read_status(struct phy_device *phydev)
 	return 0;
 }
 
+static int rtl822x_c45_get_features(struct phy_device *phydev)
+{
+	linkmode_set_bit(ETHTOOL_LINK_MODE_TP_BIT,
+			 phydev->supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_MII_BIT,
+			 phydev->supported);
+
+	return genphy_c45_pma_read_abilities(phydev);
+}
+
 static int rtl822x_c45_config_aneg(struct phy_device *phydev)
 {
 	bool changed = false;
@@ -1273,6 +1283,7 @@ static struct phy_driver realtek_drvs[] = {
 		.name           = "RTL8221B-VB-CG 2.5Gbps PHY (C45)",
 		.config_init    = rtl822xb_config_init,
 		.get_rate_matching = rtl822xb_get_rate_matching,
+		.get_features   = rtl822x_c45_get_features,
 		.config_aneg    = rtl822x_c45_config_aneg,
 		.read_status    = rtl822xb_c45_read_status,
 		.suspend        = genphy_c45_pma_suspend,
@@ -1294,6 +1305,7 @@ static struct phy_driver realtek_drvs[] = {
 		.name           = "RTL8221B-VN-CG 2.5Gbps PHY (C45)",
 		.config_init    = rtl822xb_config_init,
 		.get_rate_matching = rtl822xb_get_rate_matching,
+		.get_features   = rtl822x_c45_get_features,
 		.config_aneg    = rtl822x_c45_config_aneg,
 		.read_status    = rtl822xb_c45_read_status,
 		.suspend        = genphy_c45_pma_suspend,
-- 
2.42.1


