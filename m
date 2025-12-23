Return-Path: <netdev+bounces-245847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AF5CD92D2
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 13:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D045300EA1F
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 12:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7AC32D0EA;
	Tue, 23 Dec 2025 12:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGE+F6Rm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BFA2882CE
	for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 12:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766491811; cv=none; b=QhsBnFxtNon5mivBDwP/LbpRYn6svQoO7jKHR8aljWrY1gd0O+Xvhyqi6hPFqeFL67WvjR6HcMdUlvE/uvepWGHIkQEBLZP0rmZh5B9qnOBTGc3EYoWq2ndXGCP+u11SfCEV7LcaKXRo7qLZNh8txoUKm8OC7H0W5tpj6yw/2wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766491811; c=relaxed/simple;
	bh=XgUw0g/NEIgEW+VG/XOEKDs722Z5GJubVhMQ0qWhJG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o2WlaL6aGBeKimfAD9NdXsSvsB8+nJmXMWLf2akvIhXIIqpVLX+ouTw2+yLb2K0bs8sg/U8J2k6OzKcJ7syYJlbKH9Rs81q0HFHkWIzTppxSI2xct13sr4AhKrC24qxKy74sKPMMznqge79CbRfC42uHtrd8XkjG0y+ElJAUBfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGE+F6Rm; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47a95efd2ceso42853035e9.2
        for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 04:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766491808; x=1767096608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/f9HflRnwVkXbTIRr+dIQ1TlNT2yG1b0bvlXXsWw0A0=;
        b=kGE+F6RmCspfYh6ZbeNfo8ll6FpqfrTfWviJ6UkWjqWG18q5P7WXUMew68cSmbvF4L
         eYzXdJ2BwC/mjrZUp4mp7ZBOFjDs160S+0lCah7ENoaOfRbXxJ1Ow5VwoZDyhtw/ZEAd
         EsC3+b2/cpwWc3qW5UmCDcycmvISC6p2HaRYAoBcnjCnR0jRYqebrpz24pWo7pgOtQx0
         UDW92r/BjTf4s/tOohHGdYwmsPeLqjoxJblibQOFwjQsWW1GJ1hdyCEcCoNuPKPj2/IY
         afgCUbh7VUTsC6qURXCArvNWVokaeslR01Ppj8rXaj2NFrQt6sH/dCxKe3BudhGiCd9v
         msDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766491808; x=1767096608;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/f9HflRnwVkXbTIRr+dIQ1TlNT2yG1b0bvlXXsWw0A0=;
        b=gCAjtIyKg3Be4KatgluI7MIzCsk8JGV7EM0yqM4wCmjD2R+IJIkZFNaYWcZ7/BovPA
         AUkIdV0WNJo4voKhmSTG+bl1RJzO47NcUFyU1e6kl3YyM7X1ChfF2P9JS0g01WYIMVb3
         o4koN12gIGnT7PJ4xP6v57cMK/eTktvN4Lb3JMmW/6aBqtLy1ZAJsU1eAEI4ThWfmnc7
         FvMRcmv+ljmIW4hQWh6yd8b+bvup42yBqy0j6QNzs/DWsUj/niBlueiz2gnBGpPB6YZ4
         VyHhzal4o0kYpvQxjsGHfdPkZ+CdxMweYCzstl/5S4sEz/Lx2aJ6Ze71ddM7Gsje1BJa
         2R3w==
X-Gm-Message-State: AOJu0YzIbtwIXfVcLobVzalTW1NdDbhpfqnUNv2bYoOmUk1hQuBheU7j
	F5idb6QVk1Mj6UxnyX9E7+KSaRA3UGn7bwS7MfHGUExY105n0Ei58zcKGBHQJQ==
X-Gm-Gg: AY/fxX4QGFykPpvgaDJ/YV6Ybw1jI9I8Er/frWygpx4Aa/xU66XA/9Zj2d4C5Cfo71J
	LfTayfGjH/zz5+4aaIZ+8gFJJwisaEYh7kcfq0CNro0fOXBVd3DlvWkCE6+LHEvNKntx2OH/OnQ
	0u0VLH1E3NxZBuRNQBDwu+RoZO7A+Wk7fi+VK+k6G3LubKlZ0EM2ZwL7AeR/BLISqPaEAGLiTly
	BmpvYObBOdHPdOvi0IKsZmzFxBmdRlDwS2z8nHbFlikk/rdaWt23NlCXBPD6XmTkE59Bj2fHiRw
	Ilz03U2mCz8zvOi2DtXCVZZK8cJcDdDjZEl3seeiU+mrbWREHwdRBF4n7GLBnPx9Ht1iuCPFBHz
	FOAFEkiagMkBkLcr6DUvIG+nyab4PB2aUKoU5pfNH0k/SgWQYmNMe+ZOV4PQTJ5JbzL0JGZdxrc
	EdTFuptHhGBpt26s5AnC6G41mDpk/UJf87johxrFQF2/yI7adCDat8aJWzf2CmrccFPBTQ5bY5F
	IzbLebmvBvfJxCeiUD8
X-Google-Smtp-Source: AGHT+IFoUZg6EVilZOy8UUnejX8ATFVdzOSIn5a3i4NKr2lM7SWQebsdVEsArAovjaNX7gydswaCrg==
X-Received: by 2002:a05:600c:3111:b0:477:b642:9dc6 with SMTP id 5b1f17b1804b1-47d195aa79cmr141220775e9.34.1766491808025;
        Tue, 23 Dec 2025 04:10:08 -0800 (PST)
Received: from Lord-Beerus.station (net-5-94-28-220.cust.vodafonedsl.it. [5.94.28.220])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d19346e48sm234347685e9.2.2025.12.23.04.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 04:10:07 -0800 (PST)
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
X-Google-Original-From: Stefano Radaelli <stefano.r@variscite.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Stefano Radaelli <stefano.r@variscite.com>,
	Xu Liang <lxu@maxlinear.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Stefano Radaelli <stefano.radaelli21@gmail.com>
Subject: [PATCH net v2] net: phy: mxl-86110: Add power management and soft reset support
Date: Tue, 23 Dec 2025 13:09:39 +0100
Message-ID: <20251223120940.407195-1-stefano.r@variscite.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefano Radaelli <stefano.r@variscite.com>

Implement soft_reset, suspend, and resume callbacks using
genphy_soft_reset(), genphy_suspend(), and genphy_resume()
to fix PHY initialization and power management issues.

The soft_reset callback is needed to properly recover the PHY after an
ifconfig down/up cycle. Without it, the PHY can remain in power-down
state, causing MDIO register access failures during config_init().
The soft reset ensures the PHY is operational before configuration.

The suspend/resume callbacks enable proper power management during
system suspend/resume cycles.

Fixes: b2908a989c59 ("net: phy: add driver for MaxLinear MxL86110 PHY")
Signed-off-by: Stefano Radaelli <stefano.r@variscite.com>
---
v2:
- Fix From:/Signed-off-by address mismatch

 drivers/net/phy/mxl-86110.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/phy/mxl-86110.c b/drivers/net/phy/mxl-86110.c
index e5d137a37a1d..42a5fe3f115f 100644
--- a/drivers/net/phy/mxl-86110.c
+++ b/drivers/net/phy/mxl-86110.c
@@ -938,6 +938,9 @@ static struct phy_driver mxl_phy_drvs[] = {
 		PHY_ID_MATCH_EXACT(PHY_ID_MXL86110),
 		.name			= "MXL86110 Gigabit Ethernet",
 		.config_init		= mxl86110_config_init,
+		.suspend		= genphy_suspend,
+		.resume			= genphy_resume,
+		.soft_reset		= genphy_soft_reset,
 		.get_wol		= mxl86110_get_wol,
 		.set_wol		= mxl86110_set_wol,
 		.led_brightness_set	= mxl86110_led_brightness_set,
-- 
2.47.3


