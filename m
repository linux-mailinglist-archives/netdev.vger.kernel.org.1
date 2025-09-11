Return-Path: <netdev+bounces-222147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B27B53412
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 15:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0775E3A2A77
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 13:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA513340D90;
	Thu, 11 Sep 2025 13:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SuxQAa98"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA3C33EB05
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 13:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757598046; cv=none; b=HuMw2L6Vt3hI+0DR7Rn8hEwKUWdIZPnvnRcO3oCgmcd8wtvE3F5BI/ol6QMkT4AjKjFf5Slpr1odzRE/CwU7YqzuPfsg0lzSVl8XvyY7VLi4zS1u3MGcVUwmbEelChcMf62s0V87I2vK0xmo360K+xI6osASCxc6KttfI1X+0UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757598046; c=relaxed/simple;
	bh=cR+i0j2nFSKam+gq7FWSsr5apx+a/lZwZMhEZIsHfcA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OlgqE6qo55DsUa617C3UXVMWNS7vxs5WpcjF3K2xyXR56zIVwQvy5PHOK3kE+aVTP3iDvGsPOm4GNb2sJlNpUY60PAUVHCSVgUoVNdaPUqefgLD/JWZtdhnV94WaHtKPObhu0rO+Sq8DM6kJk5G/rHwtoERagnWAoLoTuX+Q6fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SuxQAa98; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45de6490e74so7344585e9.2
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 06:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757598043; x=1758202843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HxXWRqnFqGYPd1tnhNthT3WKgGhl9VmDbyQfQ/+snwM=;
        b=SuxQAa98uT2YzbAANMDIZgzMnMCwLVaPwBorQtAJ78TaFoSm9A+mQBTfz4UaT1YVGM
         hVCzl0sBQHjmOSqH9D7dSO37jV0QmrDSv1MsN+WIf3ZN0F8mLBngYU7dWVBkKDPiYddw
         HoenTvB6+lfZge9JbhdCMMc3Nun9SLoVOZM5sEBhnLpB27a/Ayt9FI046y5bDY7dIq/+
         4WO+nEdPW8OV1mLQDw3DlSkgxeRD+KuVYlX/IpsVFk7GdyiGkCwk2KqF/K1uK43RBX4J
         LA6phTA10kNDC+JAjDFuqJBqkReBQyD8TsCvj0nnoJmhBV2V+mh87//oJIgarJxWK/u5
         husQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757598043; x=1758202843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HxXWRqnFqGYPd1tnhNthT3WKgGhl9VmDbyQfQ/+snwM=;
        b=ahRhyMj8D6HUbPBwor2neTjuCrn0A6xFBvTRTywiYG8BZmVOMpY9oyInjt21S8WGW3
         R6gqEvc09Vs2Is1vkUbx4V5KfswGv9H4hhozWw/+ES5kyO2c/MqZRCW4Z3PLRn5KnkzR
         NULCTVLWMaTlGUUf6bcIc7wJWv4FRri5LenZAfRaKaOV7aK99w2Xs9biU2OXyhZLFJ0V
         zrGhJF86MGP43YBL3jJ75YID/1N307tx5OTSHXw2DBHXkUQveEGAuVEycXh1/BVJo/PL
         ijDoZR848Lp8XkwZbwAeeVxp1Y0qclll92cVKt10aKphkYmKyTYJCQqWAxRt7iR5PZM4
         uJXg==
X-Forwarded-Encrypted: i=1; AJvYcCXifY+nvsX2C6IpjlIBsahMlE4YU+7szXM07ohQECfdu8dFN3XoXFuvCH9Fywmn/4dITsS/XPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPVeLNoBMaR2xnBk08AHSyWEk4DZdz2B1lSG6X1i4e1PPE4WIH
	v2eejRIi4yvMU4Ig071QbzO0mj+Vaz/7O/C1vx6H08xUBmYtpDw4cmcc
X-Gm-Gg: ASbGnctN8oqq3ycbgi148egcvQX2LE87+KNty5Cp/VffX1DpHk+b7cnM000eEq+G3kL
	SXcIiWCCEBhaqdiacNr2x9bo00vuwAzCJaw7JLM6iR34VK+DS8umw3H7ToTsgydpYlqOywWgep3
	azIv3dYf0EhG8TLsVZyw+endusXF6TqtPZcdzo7uqkAKhIyVBMbM1zNws4zdlmb8jz4Ejal+Cfe
	jE0IsEx7UQzGACfZ6uAlvyW62hrTIll5meR9ekZWb9qu3FPrtfWlZeP1+3fGpYhx7mwS5bSX2fE
	K7wXEdxPX072x0+vB4gZl/07t6uo3lxgaB2gJ9fL7Vk2Y/Z3rpe1NIoJRtpkeTZbk2MVnFJIJW5
	lUR7tKozUekVoWfcuhWKp+tkUUVVwhWT2T+HQa6dPUqy67UmPBhyf4gCV9hTNzTG4A3UjwPeJZT
	YI48t6kg==
X-Google-Smtp-Source: AGHT+IG2KpWHVxRYHBojS5qhqOAZS3ZPHK9ADJy0kEMpbU3Dfi9X/AHkq0y0EQaVaEvtw7HYElj84g==
X-Received: by 2002:a05:600c:1d16:b0:45d:dd94:7c09 with SMTP id 5b1f17b1804b1-45ddde955c3mr180709415e9.1.1757598043155;
        Thu, 11 Sep 2025 06:40:43 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45e037d741asm23413475e9.23.2025.09.11.06.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 06:40:41 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next PATCH v17 8/8] MAINTAINERS: add myself as maintainer for AN8855
Date: Thu, 11 Sep 2025 15:39:23 +0200
Message-ID: <20250911133929.30874-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911133929.30874-1-ansuelsmth@gmail.com>
References: <20250911133929.30874-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add myself as maintainer for AN8855 DSA driver and all the related
subdriver (mfd, mdio, phy, nvmem)

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 MAINTAINERS | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b81595e9ea95..818fe884fb0a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -740,6 +740,22 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
 F:	drivers/net/ethernet/airoha/
 
+AIROHA AN8855 DSA DRIVER
+M:	Christian Marangi <ansuelsmth@gmail.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/mfd/airoha,an8855.yaml
+F:	Documentation/devicetree/bindings/net/airoha,an8855-phy.yaml
+F:	Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml
+F:	Documentation/devicetree/bindings/nvmem/airoha,an8855-efuse.yaml
+F:	drivers/mfd/airoha-an8855.c
+F:	drivers/net/dsa/an8855.c
+F:	drivers/net/dsa/an8855.h
+F:	drivers/net/phy/air_an8855.c
+F:	drivers/nvmem/an8855-efuse.c
+
 AIROHA PCIE PHY DRIVER
 M:	Lorenzo Bianconi <lorenzo@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.51.0


