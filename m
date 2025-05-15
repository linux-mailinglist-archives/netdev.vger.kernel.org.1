Return-Path: <netdev+bounces-190736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5539BAB88E7
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 16:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3944C4E7FB3
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 14:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E57198E60;
	Thu, 15 May 2025 14:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JjNtrIlU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDE019CC0E
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 14:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747317969; cv=none; b=o2HwG24HPOLM5QRBSV2+J0CLxUq8qD0Ywa4wCPUI3qx/LfCiTj04Q4zsXMELz2G9DdbUuXlnChuCICpzcHCtxtIUSutKbFNMBUA8GpwMcoFa0brKdMP0tpaIhSYRJFAoeXcVaChZz6CWgvwgU5T5d4JTPktUcJ/miSIJH4uncek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747317969; c=relaxed/simple;
	bh=ZX0b7+q/WHABStHBVU2DZikmc1ff9AvZgSAY2t2c/Js=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xhhq/Gd0K7ZLWVicqkemNJC6DdULdqLsW3lPy/qDD/cPwhDeZ40hmG+p9vsbA0swB0P0WvoMAYgiBZv+0lSA1/LeFykh4MiwUPCaEduVNC2Rm1ZzPopEVSZhrtjhoiymKKSGTFJrfehpc9oEHvSOjVq3lI9hzZ/2RnAGGPvf0C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JjNtrIlU; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a0b4c828c1so111666f8f.2
        for <netdev@vger.kernel.org>; Thu, 15 May 2025 07:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747317965; x=1747922765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+TIgkAbsJjkBmPmDqXYIo5M6rm+d2Bew/nDM+VokxXo=;
        b=JjNtrIlU1pZ6D68eA95fvaW9xhtPFb4tDSOltWovIAR8kqw2S9FY6BFnoV25DBoXFv
         T23vUap+jwvsavpgbZ3W/WnPvaQ0kQMd4SN0IKc0/PZx359IgFbNS9xNXuoJ4frbUaCo
         J3oZxsaw6PZeb2WLtMetrLXfI9EXVIBfPSYScn79/bNRkwqf7aeKHfWVbRYmwRZz4LN/
         atJorZybH0aU/7y5YpQhWN7LmzaAeOOVjJ/8nufSpdLmYVNcsf11ltttXDBIXRbI9lSt
         n3+J9rlMwzN1b6QMAq9sP3nun4jEdzBkoZ+oZFbSZHEGNub25QML4zEsKe/sEHDHhNPZ
         PMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747317965; x=1747922765;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+TIgkAbsJjkBmPmDqXYIo5M6rm+d2Bew/nDM+VokxXo=;
        b=NjW7f0+rJQR6R61K5SMhvv2Bct8NFwkQOMGYqZlZmWSRVRTXodc1MxWydpGIHfTxSM
         VantJvs4jSjMMI6W0th9WpcVqGt8+WTI9c0LAcNTj2jADMewvf0A6uA+zfMzDeULjBX2
         CrmhVOIWTisTSZR39uk0hZykjtIhrSStnQIkBLDTuMaqBtCb0X5i7fZjYMJ+Qqlfk2k0
         +l0ozkIlUe5ayzic/ow+8kUnzMXCaeWq5hThdxC7WO2SN+Qbk0MNk6qROyuhH3IcAu0r
         JHYxr+AB6k0d5MuwHXYsW6tYjPzBNnLuQawGUM1DWFyoDxQaALJr0Fr9aQW/xDr+uiG0
         PI7w==
X-Forwarded-Encrypted: i=1; AJvYcCXVQ2VqaqHdopDAmW3o/l5qog9Z1l/dVD2zqyaDFQGUA7iFBm3njaKJFO9KE5chAUhpDokkylA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgkFI/Qy2k2QkK7jAb8DkyU8OweWmmtExymsh30EloeQIermy/
	fIAr4L9oclGzkzK2k+kof4bAXfLIU2II/OlaYnzPX3+79vbCcZTY953ymPhRJLI=
X-Gm-Gg: ASbGncslCZSR9w5ucxcF0mPRkxQqCysX07K00NfzU+avSoPSluReKQ7srwISWZlP9bY
	GrHZGWsdxU8PitgitM9WlxkTsphKdgqvCiuGQmCrtKhA3bddwd8awXaZmIl/NBGMTXShtTouiWe
	cZYrEdzKtwHBswer2u6iIebBMTRYsNszQN8P9v2W22k/hq4F7xJfznPWcfaLu0Zp92LqXP0f6/D
	eVsRHyYhZu4ybUTgThAGBVkA4XKRMdoRcEaHnr1kvQmch6ppYOdPnA8WNxzvih/P9JflP4iVGG7
	xqG4d8z8/b+DiR9PM6Ye8VtwwHbktOH6bzwEtVTNRG/0ESRrWqiMr/VR5sBHLYfKcCihA7HYpv7
	+nyX/WaQ60yZefg+809ZOX7ErQCXrCd1yGiE/Va0D5SDNZOdlRw==
X-Google-Smtp-Source: AGHT+IGmNKfHbbVSEmUusIJS8WAr9eTgCDfqm5Zo/ICFklsk2Vg4Y/cB3sTKH0S53Bfr8a/oTyQc9A==
X-Received: by 2002:a05:6000:4312:b0:39c:1401:6ede with SMTP id ffacd0b85a97d-3a34969a540mr2019499f8f.3.1747317965090;
        Thu, 15 May 2025 07:06:05 -0700 (PDT)
Received: from kuoka.c.hoisthospitality.com (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a4cc39sm22467224f8f.100.2025.05.15.07.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 07:06:04 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Peter Rosin <peda@axentia.se>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Andrew Davis <afd@ti.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Samuel Holland <samuel@sholland.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] mux: mmio: Fix missing CONFIG_REGMAP_MMIO
Date: Thu, 15 May 2025 16:05:56 +0200
Message-ID: <20250515140555.325601-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2480; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=ZX0b7+q/WHABStHBVU2DZikmc1ff9AvZgSAY2t2c/Js=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoJfTD9kKlTS8CAmlyX+fKZbqZ9Zq1tIycMjxZs
 vjcWGu58G6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaCX0wwAKCRDBN2bmhouD
 16JxD/9yafFSZ57/7CQ7fwg1SktQ8velRNocwh/6keD92+jYLMP8TMMAbSmo6Rkm4HU3NlJXxvr
 R3+He+hbKcvadaAlHjoJDEcEZJYDRQGsJAPNYBA98+Pq1TAV3mTCMCKabBVA8OUQcTod6YgeFCu
 bAgU5+jDiFUp72fKo13bBcnJezSvZutht/AQTcQpc7dUbX2xnOEZ/FGaqJDzvsNALGnmSZGN7Qn
 mO44h3zirGdqvjiNjKvXR2HqJiRIcjNvAUColXZ/hqtQa6DABRPx0PL0ZZDq/baRnkD3HWNMyvq
 NULJVPomtXBacEHDMSOzoErScbWm6PCRCnO7vAkwq1FqUYgpghUZXENWvm6ZN18TGCg20qr7nMX
 PBhNv4loN3d5xzIUOocZdjVy0/LGpw512RPwXiLazXZSiztq3bXGzFmlQSPxxVIbj1DKVUjZHVM
 SURHkbokvyebwCgFJP0snNf3H2s1Q+HfGoUg1YMmm9dNo949EcrMZrOKWPraZvm03QjdpyNZoY5
 p6VramH779mQPZ91xQz2G6eb4QzedSIpHt2g+1mNucf3hfb7IGTRonmqNSzfGTTUsoqbp1A1//N
 8CPiNBKrJaD5tn2CqcLPlK96Rm0DN6Dlg3NGE9CKRTHqOaNtAB4DBMeMgXKwYSyyjhggoKsjai8 x21+ePNhk/B6+jQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

MMIO mux uses now regmap_init_mmio(), so one way or another
CONFIG_REGMAP_MMIO should be enabled, because there are no stubs for
!REGMAP_MMIO case:

  ERROR: modpost: "__regmap_init_mmio_clk" [drivers/mux/mux-mmio.ko] undefined!

REGMAP_MMIO should be, because it is a non-visible symbol, but this
causes a circular dependency:

  error: recursive dependency detected!
  symbol IRQ_DOMAIN is selected by REGMAP
  symbol REGMAP default is visible depending on REGMAP_MMIO
  symbol REGMAP_MMIO is selected by MUX_MMIO
  symbol MUX_MMIO depends on MULTIPLEXER
  symbol MULTIPLEXER is selected by MDIO_BUS_MUX_MULTIPLEXER
  symbol MDIO_BUS_MUX_MULTIPLEXER depends on MDIO_DEVICE
  symbol MDIO_DEVICE is selected by PHYLIB
  symbol PHYLIB is selected by ARC_EMAC_CORE
  symbol ARC_EMAC_CORE is selected by EMAC_ROCKCHIP
  symbol EMAC_ROCKCHIP depends on OF_IRQ
  symbol OF_IRQ depends on IRQ_DOMAIN

... which we can break by changing dependency in EMAC_ROCKCHIP from
OF_IRQ to OF.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202505150312.dYbBqUhG-lkp@intel.com/
Fixes: 61de83fd8256 ("mux: mmio: Do not use syscon helper to build regmap")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Samuel Holland <samuel@sholland.org>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mux/Kconfig              | 1 +
 drivers/net/ethernet/arc/Kconfig | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig
index 80f015cf6e54..c68132e38138 100644
--- a/drivers/mux/Kconfig
+++ b/drivers/mux/Kconfig
@@ -48,6 +48,7 @@ config MUX_GPIO
 config MUX_MMIO
 	tristate "MMIO/Regmap register bitfield-controlled Multiplexer"
 	depends on OF
+	select REGMAP_MMIO
 	help
 	  MMIO/Regmap register bitfield-controlled Multiplexer controller.
 
diff --git a/drivers/net/ethernet/arc/Kconfig b/drivers/net/ethernet/arc/Kconfig
index 0d400a7d8d91..8ccedece5339 100644
--- a/drivers/net/ethernet/arc/Kconfig
+++ b/drivers/net/ethernet/arc/Kconfig
@@ -26,7 +26,7 @@ config ARC_EMAC_CORE
 config EMAC_ROCKCHIP
 	tristate "Rockchip EMAC support"
 	select ARC_EMAC_CORE
-	depends on OF_IRQ && REGULATOR
+	depends on OF && REGULATOR
 	depends on ARCH_ROCKCHIP || COMPILE_TEST
 	help
 	  Support for Rockchip RK3036/RK3066/RK3188 EMAC ethernet controllers.
-- 
2.45.2


