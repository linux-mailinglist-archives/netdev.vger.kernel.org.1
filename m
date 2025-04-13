Return-Path: <netdev+bounces-181968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DEFA87221
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 15:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71B527AAF71
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 13:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3ADA1C8619;
	Sun, 13 Apr 2025 13:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dX5sXG+S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027DD1C6FF1;
	Sun, 13 Apr 2025 13:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744551392; cv=none; b=hQFQvowgykyIk5GyT3IdMLASA5srSaKgAqItLBVWv1TxmD4dMMae4jb4Pio1bwtDY1WKACGccJEkbnGp6fs7sJTj0fCGSrKz5iOk+JJFsTO2p42DKyv/dOUN0j7bEy5MPgBzJDF8h3/zK+J+1eL+OKSQTve/O1j1SUanXGwS1bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744551392; c=relaxed/simple;
	bh=N9wz+htBUt4Thh9mmvTOacndIanMl47AV5Ka9WyAOfI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Fnrs1qxi638Jw2E++GW3UFIuVnroo3Ev2KIpWfpIwb9m3i7JuhOZdem3J/JtPFIMc6p4Pl9pW3uArXMcS/YCDbG3ceLDfRk24d8iHjDnkZAIYv3wtTgJUUrRvBjqkfsukn3GKoX2uoI5HXcp5hvUzuGMZWDfAuVOheK8I7DRhkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dX5sXG+S; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7376e311086so4474874b3a.3;
        Sun, 13 Apr 2025 06:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744551390; x=1745156190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VUFOZwO8sYK8u3NtVjSug2/K/KZv864HSmO704e9cyc=;
        b=dX5sXG+SpJaZbMhIJx2LorW2McTEsLodWgJeXUDo1qIrUapncWlRXdv58qWh/IboxE
         +R3fajpvAlEhYQXhRx4G4duOoJwNzzU4Y9+BJBny7eQZZ7ToS3Oz4uwnZ/dUHb1pd1On
         ybDkhAKynixKbZPN8EDw+P9JMJVlVtVWN/IEo4JcitTVIi+e4prQYnhPEld3CFFnn+yb
         842U+SXTTCS8PSNbVF32wYPTIgToZEneTtbhN2hHkGZQdvXDKLsMo6uJUEHvxH8YthO8
         xYsYWUlD9SEpp+gL+mAynK70TBGwnkWiUPZN+qmg2SohyWZOe/I9gCE8azrL+6kffDn2
         8n7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744551390; x=1745156190;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VUFOZwO8sYK8u3NtVjSug2/K/KZv864HSmO704e9cyc=;
        b=He4nlLc2JYPKL4grFa8aAniirYmdLvSR9zCf/b4F4HFPf+M0wBMMbuljXIds0yeY7r
         RRcr6lbybgSyUDhRRF0s+uRsh7kw4iz6KjrG9qvErA/ZtMmasGaZFlDEGbSCy0UrRuQs
         2rE2bNfns/K8v4WXjVLfl3JPdUhSmJBnmNa1JB72lT4YEko3HlhuKYRV5X2lTCrXjy70
         DHU/VoI6jblidguxf2xIend5ANeuST/AjusRyH30ruQZGiCv2ImJIa0dcHk0UBLVKuKB
         jbfKpz2TAwSxJGH2WW6nx4YLhceEN3jz5kI9NkRnRQxfwI4hmAwd7H21SzeboUNsYwKp
         dspA==
X-Forwarded-Encrypted: i=1; AJvYcCWgrvEoGsDD5qqwUs3BwMRnTjTqcTJaSqwCrBYjuODL8i1dVS4CwGb7MEhLv2eGi+e5nnMeX+XKMEZVx1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsMoFi6wrEQlY59M10Np9dms/bFAgI65/UcKIklm8S+UgxliNj
	ygIGl4zjp2rlQNhgT+RLfzJ/fwknn/meOaqRCOu6Fc9C0MB9Xi28O+ODvi9b
X-Gm-Gg: ASbGnculY6W+OdcNBuRuadsJzt/14xov6w54lBQE2rha95GbA541xnURs3+MPhQTk7h
	JZknPcgf4IN+OorjWieTmK8TAe9yTTikEdCYniO7eItkwpOQcUrPUGhJNDmteKjNYwMxwphv7Kb
	0jIgmQOtE6dXOqwh2BA8rmwzD64QNTtuwKZPKf2amIZijOmoq7k5BwYkMSdGT2j8spyeawF1EmL
	MkfEN3/cwNgyFPac4lBAQGqdFTcLzcd00OxfSTJIP3ncURrRjjsX27OW/5y1KckJjpFE2kjyhj4
	QuVV9m1BdtYlDLJ7axZoiQoFs+LIzMpEydxezdrqNg==
X-Google-Smtp-Source: AGHT+IHpweNlTeR1uGmDW5uEm82HsHB8VhwXDowKUguK2g07VE1f6WoIl0m3m/fsoPdRQ4WLMLknLg==
X-Received: by 2002:a05:6a20:d04a:b0:1f5:8153:9407 with SMTP id adf61e73a8af0-201797b94ecmr12826389637.20.1744551389923;
        Sun, 13 Apr 2025 06:36:29 -0700 (PDT)
Received: from hh.localdomain ([222.247.199.118])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a2d3a5e5sm7806746a12.54.2025.04.13.06.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 06:36:29 -0700 (PDT)
From: hhtracer@gmail.com
X-Google-Original-From: huhai@kylinos.cn
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	huhai <huhai@kylinos.cn>
Subject: [PATCH v2] net: phy: Fix return value when !CONFIG_PHYLIB
Date: Sun, 13 Apr 2025 21:37:09 +0800
Message-Id: <20250413133709.5784-1-huhai@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: huhai <huhai@kylinos.cn>

Many call sites of get_phy_device() and fwnode_get_phy_node(), such as
sfp_sm_probe_phy(), phylink_fwnode_phy_connect(), etc., rely on IS_ERR()
to check for errors in the returned pointer.

Furthermore, the implementations of get_phy_device() and
fwnode_get_phy_node() themselves use ERR_PTR() to return error codes.

Therefore, when CONFIG_PHYLIB is disabled, returning NULL is incorrect,
as this would bypass IS_ERR() checks and may lead to NULL pointer
dereference.

Returning ERR_PTR(-ENXIO) is the correct and consistent way to indicate
that PHY support is not available, and it avoids such issues.

Signed-off-by: huhai <huhai@kylinos.cn>
---
 include/linux/phy.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index a2bfae80c449..be299c572d73 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1787,13 +1787,13 @@ static inline struct phy_device *device_phy_find_device(struct device *dev)
 static inline
 struct fwnode_handle *fwnode_get_phy_node(struct fwnode_handle *fwnode)
 {
-	return NULL;
+	return ERR_PTR(-ENXIO);
 }
 
 static inline
 struct phy_device *get_phy_device(struct mii_bus *bus, int addr, bool is_c45)
 {
-	return NULL;
+	return ERR_PTR(-ENXIO);
 }
 
 static inline int phy_device_register(struct phy_device *phy)
-- 
2.25.1


