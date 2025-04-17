Return-Path: <netdev+bounces-183634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E69D9A9159A
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 09:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AA6C17EFD7
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 07:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF0422154E;
	Thu, 17 Apr 2025 07:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VFTtwG3g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C0021ADA2
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 07:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744876008; cv=none; b=U9hYiKjaL90Edzs2oBoV63SJwet5P9boJ500r1ZvYPxJXyz5DdyNCgradS2XBaJwETraqNkj+zBf8ZNJN3V38Z8enQ9W1OiPeAHdqfOpvvqMbml72+b3ARViX2XYT0GfTFYXd/ClRiARH8TY2N+zs/s80h52WESrmXOne6JUD1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744876008; c=relaxed/simple;
	bh=aSvlpjizI/Lrp13Pva6wwkw049E07MN4kZArewmdN8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=paWZVxiqSkC1tvYsd5I2TafaYtxgDn0R7BdvHbYj975aYhFykuGlfHFSua1FKH1ufZygroYuvCmRrd8hqRq5CmYWbCFdl+dvTwtjlXcGlWZbP7TbTo7Jbq818WZ8x33e9WzGZeRJLtAuuQfii3YWWKzZTChAR2Rapi9/gmEpVnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VFTtwG3g; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43d0953d3e1so482145e9.2
        for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 00:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744876005; x=1745480805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OhI+WADkGBk+0ULST+CxSRjnFxvmTJk3SgN2rfV4lm4=;
        b=VFTtwG3gRxFYqiqBb4UoDyDYv07/9oNjqp9ttYDqkGKVsODrVMpubmH27bvRnDUn+t
         Ag+ssQv8TEYkPNsuHBFocZlqzpj7qPbqGiTqmRBzJNDQJ43Pax07+Vy7ANVNFRYRitC/
         lSpC3moImHuR8ryiUJq8CTNsiUGz96Axefhfir4+UW+LgSVtK4qkiqc15t8lWLPNCP5Q
         jZOLn1JVKzgLKDok9Q3RWEP10zg+myEn7ti4Ni/y3NCy7ZSmWtP6UoBQs2e3ODRF4nms
         YEo8SVszYIvZWOTL06ow4sZKaJ5RucHZfDzOQmBZG9VZOP41K1gkOzzL1cV+MLuUCnjo
         5llg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744876005; x=1745480805;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OhI+WADkGBk+0ULST+CxSRjnFxvmTJk3SgN2rfV4lm4=;
        b=K8jbjrJ96DV107Jqruo5JdyX8Y4fkOwaYj4tgNgAf8nydx/sMtjxA4De62BMsfckzA
         ftCvuvSqjltg8IAXRq/5FYW/PPvcionBr+aoRt9wjskFdNoO1pGujdxQmudewtSdZS5k
         fTQLB2bsOrN/dGFRqVe9c1181RqpmJgfi10oSFP/Ra5IVhk63qLh4dtUpfvcKA4zsaYa
         n1njptUNUz9DYO7YbLNB8ZT6SRi+9wDJuMPwhn55b70YMbI06zP27mABuWDqzZhfwcmB
         fVl7r2ka8raoyzhPtZd2ddRBDDN0jHQQ8EcY1BYmZCkPAhEpF9i5XT9BseAfwOalAqzk
         hotg==
X-Forwarded-Encrypted: i=1; AJvYcCXuidTP6sSDMA3Pa3YZ3ivMHQj3kTFO9ruQfxZDw+CbzuaAgVPgme0iu5ZYKcGXElyB0VGEJG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzamDHrOuKV8jn6wZCFlpp8rZ69LUjGmEqeaq5tGcyabAvRLC1p
	8BgCo9w+eg8MfuCvJpem+OL0q6aU324kie6rlPn2hqyQ3fqv7stVmWphY2ccoxI=
X-Gm-Gg: ASbGncvF2/w86btftwVUBBwkd0PfbkH/cx5BgSr9S4kI7DPu9e6vGQmv6Od0xmdHwVo
	oC8yEkZyXZQZvafDts3hqA+qAlkaKwhJCl+l/z5sCDejR3JYWbAZ0U1SVJrw/DUYqonJIWFn0Gs
	zKGLdVu035B7ZTvkuby425GIuPIYIP4QUabYcqVaZm3WWTsSSRK7pLeMmVvPc9tISmrTtu5Ej6s
	hgp57TMFLRbZ+2LffxPOOZi2oAJXvwAzCjXSH2gAbqfCLdSgre9nzc2jGl1cYPG2UMNAIRhAEzD
	0J7ef7Z1wERAiRUX6zZoW7eaY1Et417RxzxMgzGgD2YrLpoXS/BjHWRXXW00OyBFadioa7o/gLI
	ZoqqoDg==
X-Google-Smtp-Source: AGHT+IGFe1ON7uLFnctXLbWHCIx251k2gOzxkcVdUkHVQsZlna6ZhlzZoF22sAc96PoeqkFuh+hKAA==
X-Received: by 2002:a05:600c:1d15:b0:43b:c938:1d0e with SMTP id 5b1f17b1804b1-44061d9b048mr8672705e9.2.1744876004978;
        Thu, 17 Apr 2025 00:46:44 -0700 (PDT)
Received: from kuoka.. (46.150.74.144.lvv.nat.volia.net. [46.150.74.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4405b4c8188sm44102175e9.5.2025.04.17.00.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 00:46:44 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ptp: Do not enable by default during compile testing
Date: Thu, 17 Apr 2025 09:46:42 +0200
Message-ID: <20250417074643.81448-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enabling the compile test should not cause automatic enabling of all
drivers, but only allow to choose to compile them.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

For longer rationale:
https://lore.kernel.org/all/191543a8-2e2e-4ac4-9b2b-d253820a0c9f@app.fastmail.com/
---
 drivers/ptp/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ptp/Kconfig b/drivers/ptp/Kconfig
index 07bf7f9aae01..204278eb215e 100644
--- a/drivers/ptp/Kconfig
+++ b/drivers/ptp/Kconfig
@@ -44,7 +44,7 @@ config PTP_1588_CLOCK_DTE
 	depends on PTP_1588_CLOCK
 	depends on NET && HAS_IOMEM
 	depends on ARCH_BCM_MOBILE || (ARCH_BCM_IPROC && !(ARCH_BCM_NSP || ARCH_BCM_5301X)) || COMPILE_TEST
-	default y
+	default y if ARCH_BCM_MOBILE || ARCH_BCM_IPROC
 	help
 	  This driver adds support for using the Digital timing engine
 	  (DTE) in the Broadcom SoC's as a PTP clock.
@@ -59,7 +59,7 @@ config PTP_1588_CLOCK_QORIQ
 	tristate "Freescale QorIQ 1588 timer as PTP clock"
 	depends on GIANFAR || FSL_DPAA_ETH || FSL_DPAA2_ETH || FSL_ENETC || FSL_ENETC_VF || COMPILE_TEST
 	depends on PTP_1588_CLOCK
-	default y
+	default y if GIANFAR || FSL_DPAA_ETH || FSL_DPAA2_ETH || FSL_ENETC || FSL_ENETC_VF
 	help
 	  This driver adds support for using the Freescale QorIQ 1588
 	  timer as a PTP clock. This clock is only useful if your PTP
-- 
2.45.2


