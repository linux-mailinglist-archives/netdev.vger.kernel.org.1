Return-Path: <netdev+bounces-193175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 341EFAC2BB7
	for <lists+netdev@lfdr.de>; Sat, 24 May 2025 00:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD96A1C07A3D
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 22:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122C620C006;
	Fri, 23 May 2025 22:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sima.ai header.i=@sima.ai header.b="Rux6R/Nh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF421DED77
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 22:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748038787; cv=none; b=G0gtHQLp6txozGXrgfSuBKSA3GLaItWQ1kw3Q1HmOCu5hVjCeBzBjFunc3M6HIO6WHf7Ldj6gL2+VSpUua2/11kzDPjMNCeZPRRYTjiJ0a1CAoDjYlqrIn5LxIowbnrD6OqlaH/bC4vDsxr5yqkxvglMBAGcVNA057JaIbQQRLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748038787; c=relaxed/simple;
	bh=XBS/3t020iCieSpkJX/q3pCPDsTCYHGQJz9d/9KN+nc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e5dijq2hnA25KHupjmunSqrW1j8RHdwKwYj02uDyLlmSMFisXwDJoJ1X+qS7qmgxqlOTCEuQirnRsvUAPUFu6/4pBE/ImjeuB/FKLYzggh2EPR3z4DNjxMP+Ct/CaXAfWpPzDxxzRavIx+p1715cUat8IMKzdQy+t6mMPgETZSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sima.ai; spf=pass smtp.mailfrom=sima.ai; dkim=pass (2048-bit key) header.d=sima.ai header.i=@sima.ai header.b=Rux6R/Nh; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sima.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sima.ai
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-739ab4447c7so64243b3a.0
        for <netdev@vger.kernel.org>; Fri, 23 May 2025 15:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sima.ai; s=google; t=1748038785; x=1748643585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/JnkXPK73+jyylcV6ryL6CGzS49ASbFWgmp+uGzB8Mk=;
        b=Rux6R/NhuD3s8fflH7WkRCaU6koRLv9WnFSiWDVuAXbe5G5arWsjYpQ+qsVZk7Umdu
         9mTi/OuoowhWki7TL5k04cHaQCt7rCQnCc+AULb8ZN8g00wrXqMoNE+Vj6hdJNN3XWZD
         oqkvoa7hzJt4fX4wt/3GcKINOuBEEr+iUHQOfFIK3YYsZZYEE3pAlXCqf4C+M1aoYxqH
         FfImslK1ywSXUKqhGMGd0ESYN6gyzpOzHtHf5cynPoYkfGFMTNbzHhUa/5fbaFOd2L5F
         M64nSwHfMUfXB15GGP/NQ6+6QIdOhYoYtpiraYyPe7tzuDhxrEPUvvVxGg6u1OEDeJdr
         CQ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748038785; x=1748643585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/JnkXPK73+jyylcV6ryL6CGzS49ASbFWgmp+uGzB8Mk=;
        b=wkGtlcjlYVjUYWwgoNEe4f/YevBP82MIhYehZiVHWhsN+8bdAnJ94KikXLky8XnD7d
         HlMlfE2q8uBaD36IKlaTZMRSrnQCSQoucQ7l9Vp2KCrji8EsB0R6rcW6PzZAo8B6OyqG
         TXiFH4l/7VZQrjK4ZtmtFLHhitqftGXK+lGlfF7zt+Ill187f0T+6c82Vj0nD+QAELEk
         89+JjD55M5jAA/5qTgeAbaEd/S6isFTdKCjmIqFm0+wmQm8kOFbJMIl4teLAaQf0b7Ke
         RIhFu2YqndiRgxol2R4rv+VrPEs5RCqd5MhdXD6kLMMZm9gbf8gKjqtKHpXCaZAl3ers
         ch2w==
X-Forwarded-Encrypted: i=1; AJvYcCWrxNH9YpDxfvFgbkFkgYgb8jHmA3yzuGA1cDn+NXm5bbm3bIK1Nlgy49Sss4xDRgjdV1d9sbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo6NtrsNFbyk4HGR7xvYXabyJPswKHJ5Nyx2P3ulb/MmMXVkee
	Y90KbANI5WhLBmDe8IqvtoAZHFDeKbN0Lv9jof5X5gcJpDX/+n1o+obj4fy4S+CLmZk=
X-Gm-Gg: ASbGncuOW0R1zcySoW7i6UVVnTDYPqT5ZtUxTqeFQz8MXAvksimhZ4mX7Ytp9ENsCkS
	FGLXjlOi+yHnPImwjS0Q6k3+QYJD1S8T23k1/uOIQXH9aASnnUMQKWQUPF10qGqOOaTY8O59/qg
	FElAcWqBe0fTD9Jt34+VgCTkQ2OJ7yZ0V6wLDfiU1DiWW8VlVK3sxcELcv4V77yIdy2qlLOMD+P
	6DLN2Yi3Xu87bP5DiO17riT9w/XRq/0aNEwkbd+Av9eYk/fItomQ6IbAuthX1wmsm9wTRqulyz7
	RZH37Wff4OUH0j/FUyiF2G9jR/ioYlYcBslHd4PNT0pvwXKmJ5bh/PfmRzS0LAFxZ5v/Dg==
X-Google-Smtp-Source: AGHT+IH4iorXbLRI5th5BQNEszM355fKXRMdiHktjuRWLWFcJzliHo+SpZz99EM6pMvifOreU1FWMQ==
X-Received: by 2002:a05:6a00:8083:b0:730:915c:b77 with SMTP id d2e1a72fcca58-745fde77910mr655216b3a.1.1748038784743;
        Fri, 23 May 2025 15:19:44 -0700 (PDT)
Received: from nikunj-kela-u22.eng.sima.ai ([205.234.21.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a96dfa2fsm13309759b3a.2.2025.05.23.15.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 15:19:44 -0700 (PDT)
From: Nikunj Kela <nikunj.kela@sima.ai>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com
Cc: rmk+kernel@armlinux.org.uk,
	0x1207@gmail.com,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Nikunj Kela <nikunj.kela@sima.ai>
Subject: [PATCH] net: stmmac: set multicast filter to zero if feature is unsupported
Date: Fri, 23 May 2025 15:19:38 -0700
Message-Id: <20250523221938.2980773-1-nikunj.kela@sima.ai>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hash based multicast filtering is an optional feature. Currently,
driver overrides the value of multicast_filter_bins based on the hash
table size. If the feature is not supported, hash table size reads 0
however the value of multicast_filter_bins remains set to default
HASH_TABLE_SIZE which is incorrect. Let's override it to 0 if the
feature is unsupported.

Signed-off-by: Nikunj Kela <nikunj.kela@sima.ai>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 085c09039af4..ccea9f811a05 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7241,6 +7241,9 @@ static int stmmac_hw_init(struct stmmac_priv *priv)
 					(BIT(priv->dma_cap.hash_tb_sz) << 5);
 			priv->hw->mcast_bits_log2 =
 					ilog2(priv->hw->multicast_filter_bins);
+		} else {
+			priv->hw->multicast_filter_bins = 0;
+			priv->hw->mcast_bits_log2 = 0;
 		}
 
 		/* TXCOE doesn't work in thresh DMA mode */
-- 
2.34.1


