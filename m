Return-Path: <netdev+bounces-117222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE27C94D263
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 16:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 916801F24B8F
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 14:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF12196D81;
	Fri,  9 Aug 2024 14:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzwJmFZf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C968C194C6F;
	Fri,  9 Aug 2024 14:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723214574; cv=none; b=pGUgwVjdoNWTO8wJfTkR1bgwROK0E3e1FgkW/oEb+XYsJ1mTnFQmIm/jfFdao5J9Zr6cwy0S5gMD/SUx3okGeIObuhKWQNIjDDkGf5me4lrvtZtdyDS0CXLBCr5j2/z9f3yn3h97tFEhJzckzpcshlLvlvlizYDMos9xudp5HUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723214574; c=relaxed/simple;
	bh=EuIddEfRhDaehf9hEKui7w4cVOyFJjM3xP06ctSX+f4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KodZZes+zRT0nwh8ssmGuR39iDW6WbdB+mNzoGlBLdVQR4wil+DmRto/W4VlFFzfasqaQuNW0VY1w/OLkeuRsHCBMM2rSo/WNuoMwHTYwUXkqUIHigiI38q53zLufNInpyJUAqNLIeeyYfTrXjbZcxzpLNKVP3kkbTHFkAATNcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OzwJmFZf; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1ff4568676eso20886565ad.0;
        Fri, 09 Aug 2024 07:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723214572; x=1723819372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+sxa7qTvG9KDhnWrmlJwgpsQ4FoIyL5aoUcStCTGlo=;
        b=OzwJmFZf+vaTMRclT7T1VSv4ZS2sIyo/STGai1NVbnANrD45SQntEUQ9e12IQCGp4x
         8e9Kh5KmghOWiIVDXqq7dvRbx4/OFGZkgiFhdB4PUoqlAoRLzoI5r+zU7T7C3B5p5964
         M+qlKcl6iY//ByFNwD2vHRV9isu5AW05zkt2pSmBTmZ41DqIGwyEdX7KY6mCFjbTxXSi
         XblyHWhTmhrC+Pdxfao0Jl7qJPd+CCW+Iif1Q/6g6EvFMy0DCsdMhYeOqbDSWqsdWt1V
         GgDjsOCIH9cdeWVaX5a8HHDOOegVHGR/Rxh0xT9ObiLB7iIvJesiXGHjXghRRViFMlaI
         I4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723214572; x=1723819372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z+sxa7qTvG9KDhnWrmlJwgpsQ4FoIyL5aoUcStCTGlo=;
        b=bJ0UeDhT1vJbPDld2hxIlmTAXaFzv7Sw3fXqnnCDovGJzHGgU2/R4WTC5yy/SXiPnK
         zDW6VQ7l3o/A13yIBRbxudDfogzq/blejnRW9iz6sdUBumYkf7IY4N8Om14WXxUcTNyI
         xnEIhs2Acl34XcJvS0UQNCt7lMS2/Su7ybbSVTytD0nNJ4ohbPss1OphQrHgS8QxxlDP
         k2ocQJuJRWUn8xE9t89jsE56PIbVbDIgKS2MKkjy6ww9xGBr9QMwW3KObYMPs/u3SBs1
         dwKgmbhIftX+HiYGejsIsoonYWYQ7/EC8YleJ3gBB/bVWAfA/wfKg3sXgoSMdz1ZdwLw
         X6Bg==
X-Forwarded-Encrypted: i=1; AJvYcCWGYjq4sJo46L60slwYjGl6cPoeQ4Wh0XTKLZm6Ggp5NvCfVlkN5WDoElFwLJaBmMs07T4cKFt6jnRFLnX0qjEZA0DtgoWASuQINITl
X-Gm-Message-State: AOJu0YwTScNJ/QEPpYWpFEO7VxaU95LCUmGOArrZ+COsWkntG2xukp3B
	iw7qJHCvmkqocAU44NjAVThljAfOtEKsiaZ32KEnphQfXMMUKZXJW/a3hI5W
X-Google-Smtp-Source: AGHT+IG0re+W7ZSvQjvZbUKNBa+0Uf70NomvbO9dGh/k4s7QAX5QlfhvL68ySqfM3bd7GNvbP4fReg==
X-Received: by 2002:a17:902:db05:b0:1fb:4fa4:d24 with SMTP id d9443c01a7336-200ae5eedb0mr19667355ad.50.1723214571432;
        Fri, 09 Aug 2024 07:42:51 -0700 (PDT)
Received: from localhost.localdomain ([2001:e68:5403:cdf2:8431:c235:c4a0:3975])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff5905e58fsm143581615ad.177.2024.08.09.07.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 07:42:51 -0700 (PDT)
From: Tan En De <endeneer@gmail.com>
X-Google-Original-From: Tan En De <ende.tan@starfivetech.com>
To: netdev@vger.kernel.org
Cc: alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	linux-kernel@vger.kernel.org,
	leyfoon.tan@starfivetech.com,
	Tan En De <ende.tan@starfivetech.com>
Subject: [net,1/1] net: stmmac: Set OWN bit last in dwmac4_set_rx_owner()
Date: Fri,  9 Aug 2024 22:42:29 +0800
Message-Id: <20240809144229.1370-1-ende.tan@starfivetech.com>
X-Mailer: git-send-email 2.38.1.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure that all other bits in the RDES3 descriptor are configured before
transferring ownership of the descriptor to DMA via the OWN bit.

Signed-off-by: Tan En De <ende.tan@starfivetech.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
index 1c5802e0d7f4..95aea6ad485b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
@@ -186,10 +186,13 @@ static void dwmac4_set_tx_owner(struct dma_desc *p)
 
 static void dwmac4_set_rx_owner(struct dma_desc *p, int disable_rx_ic)
 {
-	p->des3 |= cpu_to_le32(RDES3_OWN | RDES3_BUFFER1_VALID_ADDR);
+	p->des3 |= cpu_to_le32(RDES3_BUFFER1_VALID_ADDR);
 
 	if (!disable_rx_ic)
 		p->des3 |= cpu_to_le32(RDES3_INT_ON_COMPLETION_EN);
+
+	dma_wmb();
+	p->des3 |= cpu_to_le32(RDES3_OWN);
 }
 
 static int dwmac4_get_tx_ls(struct dma_desc *p)
-- 
2.34.1


