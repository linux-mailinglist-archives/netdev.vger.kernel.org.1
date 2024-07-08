Return-Path: <netdev+bounces-109931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C9992A4BF
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 16:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A9451F220B7
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 14:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FB813E042;
	Mon,  8 Jul 2024 14:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UHnOiCUb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF042744C
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 14:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720449104; cv=none; b=APVpizV3gQ6V87+/3SlVq0oiXrjBmrwLvzvdrq012bCYNMy9xchyOxyvOhOa+oX1iR1oOKAyPoJWFgADXBACz1yGz+kBWosR9znkycCxcP+xuco/oKDM96N57zh04eiBdQtJsjRDaYIAvL+bL05f2s517WLsV0V7c5BkqLvUxbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720449104; c=relaxed/simple;
	bh=FVix9PGTN8lxYiJDQpGSkaeKIY8jzSQ4Vgfu7npWV+M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Nrbchwpnqzs3z8W2GOt9rSFFFeJrbGHX0AyQ777sAYtCkUDcfSsBAV+0PnG3qrK95uulsVStMD9bYT8/jBZaGlZZkwzfWjZtWL1Q4BorFh9B+xi4LoLM4K4Flraj9uee54YI18LDxNZuZXo36PAj3vwNy8VhOMNviB5w/mV1lpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UHnOiCUb; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4266f3e0df8so1108105e9.2
        for <netdev@vger.kernel.org>; Mon, 08 Jul 2024 07:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720449099; x=1721053899; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xjykrm0qdIAVFxBsv88U7CygsnsEAm9sI6Tg1UFxFS4=;
        b=UHnOiCUby35FLF0bAi3j3u9g8HH3271qPgUaVreom/pjRvfBCKwiXhh+x2BbCOpUMj
         SPVEMtdoRAPpHhM6iY0HHl8VcAKRyF8Jwiu4d4s50XI3CssRrQiGDE6nGZSn/tY8Fepc
         s7hnMKzhTeezLTJnQpfouUfNtJN4eanXoLQwgam9LbFk+z5Y3m6VDFRLJCPEOpPDAzib
         yswxRFEJ8rLHPk7a6oIu8yRmB3PDK4QH+O+wU6hh6yRwQSrbrTwYs+nTx69bn8v+1mEE
         Fj1xS3Np5Qushl4jn+k1Bk1UziOA6btJLYG0i4wf9THZJ1TBHDmumEgaI7TTvwRUQKeu
         4fFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720449099; x=1721053899;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xjykrm0qdIAVFxBsv88U7CygsnsEAm9sI6Tg1UFxFS4=;
        b=p7rzXedakDGNhvRWa31kJydspK787HmOPTUkC22anwidycK90XQzvNCCujuQ8tCzZr
         dhXLrYzhWwAN97RWLNlNjORwt4BRF2FV5QIPUgj6nAJK/vvf8SMBSxJ+AzStKNkzmlID
         z9O/h3nnQqyp3diyQMS/rqLToGf/pgrHvnGxkTyizIfGqEe5fGe/mUcYtKk6QkCQsyxC
         ylL6Lvrl5791gp/+DV/02/nUkGBWW3tJQqvzyGU5K3kzwg5R2Lh1FQtw6CWvstr/W/W4
         PrBaNH/uBJKfkJjP8bheQiCnB55f5XbtP1Gc3oeeEVheYPgxVWbM2d0O+Ks31EkfXWaF
         2a3A==
X-Gm-Message-State: AOJu0YxjFaE7aP8B8zamMBGkGwOMHj+/VQQO7pTUXVZ3/EIdFSGectDf
	iw1qPXiM6nNvXPjgmi8s/K3W29nGvS9WyzM1stbCAm53TGDqZvFq4wKBqm7JuNg=
X-Google-Smtp-Source: AGHT+IFksh0qJqPcgvljfvOJSGe/8r6NpboWiPMrGWrNvjV7kq6Y9vcQaCk0D8KpOPRSTn4r33kXnw==
X-Received: by 2002:a5d:664b:0:b0:364:3ba5:c5af with SMTP id ffacd0b85a97d-3679de96b30mr8282279f8f.61.1720449099459;
        Mon, 08 Jul 2024 07:31:39 -0700 (PDT)
Received: from [127.0.1.1] (2a01cb09d029b5a2628cea6c7082b40d.ipv6.abo.wanadoo.fr. [2a01:cb09:d029:b5a2:628c:ea6c:7082:b40d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a043a16sm28353580f8f.0.2024.07.08.07.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 07:31:38 -0700 (PDT)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Mon, 08 Jul 2024 16:31:34 +0200
Subject: [PATCH net-next v2] net: ti: icssg-prueth: add missing deps
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-net-deps-v2-1-b22fb74da2a3@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAEX4i2YC/2WNQQ7CIBBFr9LMWkwHSwRX3sN0Ae1oJ1FooCFtm
 t5dZOvy5b+8v0OiyJTg1uwQKXPi4AvIUwPDZP2LBI+FQbaya6+tFp4WMdKcBCnsLJJyiBKKPkd
 68lpTD/hZntYF+rJMnJYQt/qRse7/uYwChb4ogwqNGbW+O7u92UU6D+ED/XEcX5r0jCOtAAAA
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, MD Danish Anwar <danishanwar@ti.com>, 
 Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Guillaume La Roque <glaroque@baylibre.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720449097; l=1105;
 i=glaroque@baylibre.com; s=20240708; h=from:subject:message-id;
 bh=FVix9PGTN8lxYiJDQpGSkaeKIY8jzSQ4Vgfu7npWV+M=;
 b=MJ92ygnHd12XNiES5m8Se7X9BA+3gEAuiRE10jTK5E9e8BFjhV1HQjPcOLX1V6hdRd6WsBmY7
 C7vVdnJj1pLDwkShZGqyZVvmancne016d7EVpuhE2Za69D8m3OAruxU
X-Developer-Key: i=glaroque@baylibre.com; a=ed25519;
 pk=xmoWMxCw4Oles0YCggjXh0FCCnECZvaDU0PaXVPxm/Y=

Add missing dependency on NET_SWITCHDEV.

Fixes: abd5576b9c57 ("net: ti: icssg-prueth: Add support for ICSSG switch firmware")
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
Changes in v2:
- Fixes shaone: put upstream shaone and not internal one.
- Link to v1: https://lore.kernel.org/r/20240708-net-deps-v1-1-835915199d88@baylibre.com
---
 drivers/net/ethernet/ti/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
index f160a3b71499..0d5a862cd78a 100644
--- a/drivers/net/ethernet/ti/Kconfig
+++ b/drivers/net/ethernet/ti/Kconfig
@@ -188,6 +188,7 @@ config TI_ICSSG_PRUETH
 	select TI_ICSS_IEP
 	select TI_K3_CPPI_DESC_POOL
 	depends on PRU_REMOTEPROC
+	depends on NET_SWITCHDEV
 	depends on ARCH_K3 && OF && TI_K3_UDMA_GLUE_LAYER
 	depends on PTP_1588_CLOCK_OPTIONAL
 	help

---
base-commit: 5483cbfd863f01126c08703898a9e71d991a9bfe
change-id: 20240708-net-deps-e514a1e5b112

Best regards,
-- 
Guillaume La Roque <glaroque@baylibre.com>


