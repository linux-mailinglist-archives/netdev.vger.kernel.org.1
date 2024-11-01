Return-Path: <netdev+bounces-141030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC5C9B921D
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 14:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60269B23B5B
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 13:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371A21A724C;
	Fri,  1 Nov 2024 13:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXYwjLmj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA9419F118;
	Fri,  1 Nov 2024 13:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730467950; cv=none; b=nzgliT+hJDDfBZSyewTufkcqiFMMXr9xdDLoPobGoGaBtlNtU11I0yAyyFSyrvRbCILsVohQDCkfNWGLbl3dai+ZZhs/4adgv33YLE3aZSxN+PwhTZ6ySdIuW9f4npLD0hiHCW51w/hD6XhrTjMbc0ptgVzrrS6a65QeH+wjkjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730467950; c=relaxed/simple;
	bh=EVgjUADOKJliBI+X2CiKlanC3rMmnsBG76IuWDoTGAE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lgkZhAcxCR70vlkzNgeCX7fQedHoaIr+GHc7LpLIpdwxZCeW8+/kcYKvENFriV1LcFx9QvRjJ7YgJp+HExY1+AN1VPnBWcZQiU4nfAWl1JiY78hQNUJMt70ait3gnA0KqtVNmMF4XSX2V9NL/z3Hj1gQnpi3CugWHRr+TZ/5Qf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXYwjLmj; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7e9e38dd5f1so1573411a12.0;
        Fri, 01 Nov 2024 06:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730467947; x=1731072747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7AYX/UegsJeayFQV7mwBWHowTbFu2IFH/WWSPA7go14=;
        b=aXYwjLmjXs007R3ftCygNcK09HjBADCGjJRHDR5wVjkJ4/lcPOnV60VFl9GyircS8G
         U37SENe4avrcifzLdVZbINpEIQYrQE0mAIgluEsglURtz8yraD6ALC4j9UZma0YRCQv/
         uTX0X2QRJ3+Tl5+OD4rgOrB4+iTiRxWe04TW+/ca8qHmV3R96XrcK1unCdSEUxxY/QDn
         /XC6KkMO9vp4UGnjmCK2rv4z6eWO0IcYWb3WBEkW/rbtwx+PIx4Owe2KMqjqDUyQePAh
         9XOsZIxkGjKC8v/sT5hEQugOHsZGlmym0cX3/6pX08Gn+ybkZOHq0/IYqAwEzAlau4RA
         U37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730467947; x=1731072747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7AYX/UegsJeayFQV7mwBWHowTbFu2IFH/WWSPA7go14=;
        b=vL+P+xoWX435SJOQ7N6xSeslxgmXVzuRbK5sKRVqa90BlZ8fdnhe0Zhh9wrUIAs0SF
         V3yiRfkQAh0sojKTgPI9OOfz9kMf3/HxRcsVySg7+Q+MYN3tcAS9kfuhFz75fA/IzXUZ
         /Tm9qY7ArBajraoGEzFiinNTSpaleF4E/4tKjaExXumkx9ztM4ls6kiXCpQdXHh5MY/B
         fpgVoGCABMfpWUdbgIvViDOLBwYuVm64UYmVNH57sfiOIUHw73AhDZiq2xEkDuXcFvYe
         XHP6p/BXTmvgi1i9kqNSteyRxSX7RwANopR44YFrE7eKhoOnmGODr/NwxCBfCzRMbePQ
         y/gA==
X-Forwarded-Encrypted: i=1; AJvYcCUxo/mDi1U0kNlcEhMc/Uap/TPYz8LvqkH8Mw+hY8CgEKy5CJqcym+yVZLPaLw7j/EpijWxN7JQQR/t8Q8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOT5tzdI8RQHST763a9fTY/yfNsJ7vy+dFjbz5yHx/0CQ3Frmn
	id+C3IJgIurxtFs5TDdoKv8mQVu/kCietVP6QK77k7JMrti4H5nojvwzVw==
X-Google-Smtp-Source: AGHT+IG8CKrWDPB/2PbcjHGCaNFZgB8BK2WVp3xqAYoGbvg7ecSpi/WZf9vbDUIiX/52SjUlfNjCRg==
X-Received: by 2002:a17:90b:3848:b0:2e2:aef9:8f60 with SMTP id 98e67ed59e1d1-2e8f0d531ffmr24629842a91.0.1730467946920;
        Fri, 01 Nov 2024 06:32:26 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7ee452ac4ffsm2425552a12.25.2024.11.01.06.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 06:32:26 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	andrew+netdev@lunn.ch,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v8 6/8] net: stmmac: xgmac: Rename XGMAC_RQ to XGMAC_FPRQ
Date: Fri,  1 Nov 2024 21:31:33 +0800
Message-Id: <611991edf9e9d6fac8b29c3fe952791b193ca179.1730449003.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1730449003.git.0x1207@gmail.com>
References: <cover.1730449003.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Synopsys XGMAC Databook defines MAC_RxQ_Ctrl1 register:
RQ: Frame Preemption Residue Queue

XGMAC_FPRQ is more readable and more consistent with GMAC4.

Signed-off-by: Furong Xu <0x1207@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h   | 2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index efd47db05dbc..a04a79003692 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -84,7 +84,7 @@
 #define XGMAC_MCBCQEN			BIT(15)
 #define XGMAC_MCBCQ			GENMASK(11, 8)
 #define XGMAC_MCBCQ_SHIFT		8
-#define XGMAC_RQ			GENMASK(7, 4)
+#define XGMAC_FPRQ			GENMASK(7, 4)
 #define XGMAC_UPQ			GENMASK(3, 0)
 #define XGMAC_UPQ_SHIFT			0
 #define XGMAC_RXQ_CTRL2			0x000000a8
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
index ab717c9bba41..5ccdc6887b28 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
@@ -364,7 +364,7 @@ const struct stmmac_fpe_reg dwxgmac3_fpe_reg = {
 	.mac_fpe_reg = XGMAC_MAC_FPE_CTRL_STS,
 	.mtl_fpe_reg = XGMAC_MTL_FPE_CTRL_STS,
 	.rxq_ctrl1_reg = XGMAC_RXQ_CTRL1,
-	.fprq_mask = XGMAC_RQ,
+	.fprq_mask = XGMAC_FPRQ,
 	.int_en_reg = XGMAC_INT_EN,
 	.int_en_bit = XGMAC_FPEIE,
 };
-- 
2.34.1


