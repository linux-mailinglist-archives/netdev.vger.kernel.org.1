Return-Path: <netdev+bounces-105141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D31AF90FCE2
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 08:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70DC528558E
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 06:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED5C40858;
	Thu, 20 Jun 2024 06:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4/+uca+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFB540848;
	Thu, 20 Jun 2024 06:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718865661; cv=none; b=at7bhvoCDWO9tgqaJxHs/HYzt5b95DE63MFEAOcuWg7a6ODvtqh8vfQTygy4e3UAB0RAxaEIhS4oonGH/n9+o/lriJHoQQObpqZyYqqW0f/BcBr6Rv1rOrbK6MSMmlHAtCSU249bsMKh9twu6Pg9VCUpcMihJrCMRWdjaJOqEvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718865661; c=relaxed/simple;
	bh=UzzGZvEE5qzqnyqLhkrTBSAmBpUlFkIi/FE1mJkkpJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GpKu7lJH25TNj7sFmxpgrDpVJXphqXFQhswxL4poLFQ0qUFBh1Ugpy+6/l5AbWqPfQJCr37D0wc3QNVvenqG6U0UKvJl42ick7y3TfgkL2P2fZc57tFsmbAZruMHE8fKdk+sJMNJWKEbSNJbw+9RGXtQV1WGjUu3ndU+TZuQz6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4/+uca+; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2bfffa3c748so485945a91.3;
        Wed, 19 Jun 2024 23:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718865659; x=1719470459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dj4QZeFx+AVC51p11hlg4kzbDA2elF0sWu+Rp1qJlwA=;
        b=m4/+uca+AsSkt+BVHgBimm7KSElcOqANLihePTNielo5FZ0d9s5hbpRRN5nHcBuymj
         p5pfrYRGa03XsSn8eIG85PhEs3e3TxgZez2THKDQFL4h01kDvz9BthfZIT4pn+Prcp9c
         eQ7PWKXnDqlBnB6jiHo7fcwfkhCEv0ph1nbQRRdCec4DHpRcrVbY+obgihPzafMPXRsb
         DTWqBhfGxLRWeN90l7RNosipbSEDCQTe7sGX4dXJOLwIdHYXbwVdj+gJrJDSHhLWneN3
         K/2KODzptlfO/QbKby7vYDbyzWYid2AZDW7bJ0w7Og/3uNcr2FYBOm4Wj7FmNHIjHmKr
         K/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718865659; x=1719470459;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dj4QZeFx+AVC51p11hlg4kzbDA2elF0sWu+Rp1qJlwA=;
        b=IxhTxfJlSngvWUZMM77Z78ipuUa7yyfhVZb7417oKrkkPnUOJ0pTSxvSQOZPQnMCaW
         JY+ORA9vcViNafkbOcPwN+0U9OVMoMSHB3yFrG5xEQdH3HbH1UMZR2uEqPZervBURaJG
         tvYE7z6z+YSoZmFa0fRkPQRm9lnJcVQR99c3wJYM8JVemqGrV+a2p+bPjojQV/YaL1+F
         Wczadj2WV71+DF4959Mugz+dwgkiXGHIuJUYTaGrJBvOyKaUmFtX2j6NPCpuHkrWpGn0
         UDrTvsVCuL5Iyl37hFjwp4eAcS7LQAxT7FPY7mB19AjJbJJfrPDf0JhhaThU12stfuTO
         5b3A==
X-Forwarded-Encrypted: i=1; AJvYcCXpmkVo2KM4FPVZL0s4XLmwH90+t4QI18RIJOraHZN5hqFWPcBi0Ri2koElGD7IVqbvw/u8QAQGBf8/6Bi11Op8SlR4wGQFlk2hqPkZ
X-Gm-Message-State: AOJu0YwGWhSrvVETK7x6k9Kw0RhbKEAn54bmVIrXuaOb8IK0iLgGULrw
	scH/msDNxdNReUbrv35TCF426OjxsaNOteTQSmDF9PZihYVBM90M
X-Google-Smtp-Source: AGHT+IFNC7FgO9HSN1gJ1UcHOVjndxJnOiiessKD+THr8O0UlSmH6s/UeMfmg86hakwBC98pUI/Xuw==
X-Received: by 2002:a17:90a:ea92:b0:2c4:b300:1b4c with SMTP id 98e67ed59e1d1-2c7b5cc49f5mr4163646a91.24.1718865659045;
        Wed, 19 Jun 2024 23:40:59 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2c7e50f7c90sm862442a91.9.2024.06.19.23.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 23:40:58 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	xfr@outlook.com,
	rock.xu@nio.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v1] net: stmmac: init more plat members from DT
Date: Thu, 20 Jun 2024 14:40:04 +0800
Message-Id: <20240620064004.573280-1-0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A new option to init some useful members of plat_stmmacenet_data from DT.

Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 54797edc9b38..b86cfb2570ab 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -497,6 +497,8 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 
 	of_property_read_u32(np, "rx-fifo-depth", &plat->rx_fifo_size);
 
+	of_property_read_u32(np, "host-dma-width", &plat->host_dma_width);
+
 	plat->force_sf_dma_mode =
 		of_property_read_bool(np, "snps,force_sf_dma_mode");
 
@@ -561,6 +563,8 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 		plat->pmt = 1;
 		if (of_property_read_bool(np, "snps,tso"))
 			plat->flags |= STMMAC_FLAG_TSO_EN;
+		if (of_property_read_bool(np, "snps,no-sph"))
+			plat->flags |= STMMAC_FLAG_SPH_DISABLE;
 	}
 
 	if (of_device_is_compatible(np, "snps,dwmac-3.610") ||
@@ -573,8 +577,11 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 	if (of_device_is_compatible(np, "snps,dwxgmac")) {
 		plat->has_xgmac = 1;
 		plat->pmt = 1;
+		of_property_read_u32(np, "max-frame-size", &plat->maxmtu);
 		if (of_property_read_bool(np, "snps,tso"))
 			plat->flags |= STMMAC_FLAG_TSO_EN;
+		if (of_property_read_bool(np, "snps,no-sph"))
+			plat->flags |= STMMAC_FLAG_SPH_DISABLE;
 	}
 
 	dma_cfg = devm_kzalloc(&pdev->dev, sizeof(*dma_cfg),
-- 
2.34.1


