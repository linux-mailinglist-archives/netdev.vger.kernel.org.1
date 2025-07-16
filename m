Return-Path: <netdev+bounces-207331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BA0B06A83
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 02:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F7923A40CA
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 00:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35291DE3AC;
	Wed, 16 Jul 2025 00:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CfgiA6wM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829231DDC1E;
	Wed, 16 Jul 2025 00:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752625795; cv=none; b=OT7CCdLI7XnL9lb/UoiwDCiH1VA0PwyGaw7Mp9mMQEVAQ6napohF3VbiiaVc+Jxbcv7ngCgnf25aEu66aykUMSW7oLjdnfVc2jYiOXa8ucF8RiGchTWWDzxLPLD3155EZTOXn3p+/jTq1rzEJxFOZ2CiPS4v9iPqv+G349sUgFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752625795; c=relaxed/simple;
	bh=HIElUqzs3zxIyz19PRiwLe0jeruLzTT0f1WnIjXKQB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pH83t6z/xkoIfPoFS45AMfn+wjRP2WjYJwFeui0Lygu5DZxgXnrsAMKpUPzb9J3Yk/EUsv/WLFgZ2P2ZrDxgxUIT43fDwOgpOaXMWItYsrQIzA1+A5dbOrEEESEI1nk1anzZ9YxLk/k2caj7Jf9IFFk60l8N/89VHhMVTI/Ln/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CfgiA6wM; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-74b27c1481bso3856938b3a.2;
        Tue, 15 Jul 2025 17:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752625794; x=1753230594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VKioL68qXreNKW/7olSTjEn+ZmCuIt+/TbGrnJytAwg=;
        b=CfgiA6wMu9B1sr+ysm4BHGWd5aRB2TEMeqAiXjeTm7HttyKTQVSTqM7D7NVwxWE14Y
         raBTV9Y+ag9uAJu/zDuc8qvPUxAdRsAI0YLHaUFFwkfXHyEvhikKcs3B1RBELMCK1mC6
         nFhoe1t99vHeJMMLuU51dXx0Lp1RQEHuGNhKX1Z4BzRvfybdhPR7kDHut8YlSH730xP6
         KzEShrYSW0H8ezhn8763rd1kade6aG6U4c/aNYE3UQh4LHoHhZYEcIaBk30feWDOGId/
         s7WNmrmUno/jrEtVhLsrun77sUTIHcFdSjFrqbAXhzZHD28GLSgpJPMZhk5SezJxXq94
         PdcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752625794; x=1753230594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VKioL68qXreNKW/7olSTjEn+ZmCuIt+/TbGrnJytAwg=;
        b=bYhNZG0PeV5nAhScetbRdFqzPD3xThxjbYG55kjcm/XleiNOD2vefel0bUFtPkPC6H
         uXLd7i0NwN/orETFfY69ZKIqBdhwiSb3qpJJPgVGX7iQLhkmzPGXpRy5INP6KiccMXWK
         EwQJACax5ItyFy0/Il/4tAbbXIaivaM7tHRcL9z7/rk8AMAEJ3TG9+q+/ROiI+K42zzm
         jeUUxJ+8U2Y3qTOLknsLdJ0AVEpkguhKAAzoNpXmf9lLKkLOEkHdfNyR5IYiklp/5/9M
         ArojwJCFjsmXZ7XYNYK4MKefsRj0STNUBJ9xaWoVcmhpog98ttJ5eMNvj0f3miXPJzSU
         4PDw==
X-Forwarded-Encrypted: i=1; AJvYcCUHFLVstBnnqrUk9g4+vUgsKsEzk/3HjDHhy756sBgTJUSHBvlHVJ370b5befiQ4DA2MZZfpK9exY6+cr2H@vger.kernel.org, AJvYcCVKarw29cKVsqbkdI77fjdmoUHLIh2d2gKg4LypXDZCdV15SEvX8eDHQfZVFqk4fHjX987Mkgf7@vger.kernel.org, AJvYcCX+nWiRHmxlqf9IIrsOlU1WnHTBfOSct71/h9NjPSxYM8c1VmyaMoHp0g1QMIS9IajRMHac9Kb7IhrU@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5M1qz6Cvfum0TzYGaVS/q2zdcPVxS4VL940Dz3bzf5H24BWuc
	53LLfbp6Jy76ppna55UoRxsg2rdeVw9TnpyTgVJRHXxRMAG869nMklFa
X-Gm-Gg: ASbGncscXD4Av5nu7rvLbJ+edg6AFqqK7vn1CEPu2VsndX2xjVSdYfPFbjen9rprRZA
	yJa9Le+6VBcl+ItnIDdvRQoZE7Ul1LBaFUXzwJ2arv724HoNqSXg15zQ9dJeQV1nBGZ0escXA1y
	o/WrVdoPYSlY6+GMYMkuVu9KFZ9N5RQKdSbV3i9F4GShgmsPWoOL5V9tyXcJTkcgVJWS3cBIUPx
	yIl++Kgs9OyS4mwSi/wCzdFsoyTc8LH1s51dwi9XGDm7vDn4uY95FUt1SNawjFitZgby/teDKTv
	xW2ou4v1mI+lqkm3fl9kPEj5yGU6Z59tnOjVoSdn7LLA1VKwss9d40LVMxuOVK/Ea8lM/kkHpRK
	H0WKyb7eWGUuCQ9DJeN6nMaaKWl1UBZcgwLVf0kI7
X-Google-Smtp-Source: AGHT+IE7etNkY4w7opyO7FpppYrrV/dz0berDstTaCgN3sgWZVK2X/UvFDsrT3O+pDxp6uDqDTgbmw==
X-Received: by 2002:a05:6300:6e17:b0:238:3f54:78f1 with SMTP id adf61e73a8af0-2383f548dadmr85188637.43.1752625793806;
        Tue, 15 Jul 2025 17:29:53 -0700 (PDT)
Received: from localhost.localdomain ([207.34.150.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ebfd2d26asm11145720b3a.76.2025.07.15.17.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 17:29:53 -0700 (PDT)
From: Kyle Hendry <kylehendrydev@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Russell King <linux@armlinux.org.uk>
Cc: noltari@gmail.com,
	jonas.gorski@gmail.com,
	Kyle Hendry <kylehendrydev@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 7/8] net: dsa: b53: mmap: Add register layout for bcm6368
Date: Tue, 15 Jul 2025 17:29:06 -0700
Message-ID: <20250716002922.230807-8-kylehendrydev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250716002922.230807-1-kylehendrydev@gmail.com>
References: <20250716002922.230807-1-kylehendrydev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ephy register info for bcm6368.

Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>
---
 drivers/net/dsa/b53/b53_mmap.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/dsa/b53/b53_mmap.c b/drivers/net/dsa/b53/b53_mmap.c
index 51303f075a1f..8f5914e2a790 100644
--- a/drivers/net/dsa/b53/b53_mmap.c
+++ b/drivers/net/dsa/b53/b53_mmap.c
@@ -49,6 +49,15 @@ static const struct b53_phy_info bcm6318_ephy_info = {
 	.ephy_offset = bcm6318_ephy_offsets,
 };
 
+static const u32 bcm6368_ephy_offsets[] = {2, 3, 4, 5};
+
+static const struct b53_phy_info bcm6368_ephy_info = {
+	.ephy_enable_mask = BIT(0),
+	.ephy_port_mask = GENMASK((ARRAY_SIZE(bcm6368_ephy_offsets) - 1), 0),
+	.ephy_bias_bit = 0,
+	.ephy_offset = bcm6368_ephy_offsets,
+};
+
 static const u32 bcm63268_ephy_offsets[] = {4, 9, 14};
 
 static const struct b53_phy_info bcm63268_ephy_info = {
@@ -347,6 +356,8 @@ static int b53_mmap_probe(struct platform_device *pdev)
 		    pdata->chip_id == BCM6328_DEVICE_ID ||
 		    pdata->chip_id == BCM6362_DEVICE_ID)
 			priv->phy_info = &bcm6318_ephy_info;
+		else if (pdata->chip_id == BCM6368_DEVICE_ID)
+			priv->phy_info = &bcm6368_ephy_info;
 		else if (pdata->chip_id == BCM63268_DEVICE_ID)
 			priv->phy_info = &bcm63268_ephy_info;
 	}
-- 
2.43.0


