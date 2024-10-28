Return-Path: <netdev+bounces-139421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC5F9B236E
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 04:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4D1F281682
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 03:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27C618C03A;
	Mon, 28 Oct 2024 03:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cuvu5+HG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB45318C02D;
	Mon, 28 Oct 2024 03:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730084891; cv=none; b=mZhXK6PT3uDbjOqm5yl6AFG4YAsBbLY9a/196PzACAgd6ooXSlZ3he1B5G+iPV6ZpcQLGnHupoLi3mTSWZT8XEEJ+eqWZhW3BZK8i0QfgkiGZbRq/SaHBU1v8tNaP1h6qbBZYGTlBNcVP5xI32bfSheZs3vVPYhO+yMUuCdqKWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730084891; c=relaxed/simple;
	bh=IludlujJ838qPT7HOL2bUhqb4Mv6PhSa9aKeKQxdUXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BRCoSJ8qzefxgRmT0/V156bkYdMh4Hmi4zPwti7C2529g9Xg2faM4sbBtM3rUJY4gyyBgL2AtFFe99B4N3llTHn09caRWhuc20iOLGYs//Ix+8zLVEbAx0edLmC3UlJ+4b9xwmR8/5n9LPuqt8kiKH7JmVC4v70eZmqOXKvaOPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cuvu5+HG; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7204dff188eso2332291b3a.1;
        Sun, 27 Oct 2024 20:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730084889; x=1730689689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kn52y9HQNLKC2nRbhsI1WecpIBp46gjHfUlvO0bwqrs=;
        b=cuvu5+HG7VOAQHgEgl0It3YmRws5cCYMCQA3sywnNPc538gXQkh1C7Si9o4zhRSgvf
         /XyM1Ewixgck7Zle1//O3ryq49dOZO09T1e4vFieVLi8EwX4RWt4HzDFgLU96oW8iHJ7
         l7dHnXDmy7l/wqry2Vwym+jrfwcypQQniLkfptElCWnWyFx3jJxTwuvy7Wh+PXtMM/3d
         JCuAtfMjxXBVVInewk+T/Pic9Mmq56rOXolAxSVfPJa/lJwV2ns+BEuaULfvbNMUZS+L
         vmufjPIdKtRLaVc5+QzFXFq79DvVMH0HRJdWfl/F/LGL0BkIGHpCo83RzNbsC85Xbe4B
         08uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730084889; x=1730689689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kn52y9HQNLKC2nRbhsI1WecpIBp46gjHfUlvO0bwqrs=;
        b=oizNqIhXrYLjRPZR6UeafgExYtTu5M1lG4cFnQmxQs8M5U5/voBz+8bSLqAK9a/mGy
         4L/sjHVUU6Ee5wsgEePBPkTJh2DqvOnfN9vwfZdzhYl7KyHdfO34O9OCvBaGp4M2N8zO
         Qip7cmwRfyURr67pJDmCctms8rYbxOWG9Xlco+JKLJ0y5sjuycYvwM0ivFdy/D1In0af
         DRMk1vsnLd8x1nZPbrtyfmWm5WsEftPqz2c6Y8PIA4XwvLUn3xP1oKSdzRMmlDaLQlHV
         1xRulgTXX9y0i7Rzfvmjnar95yYcoY1JXdlvLAPUtXFRkvSxdZJqYKvZ0iAQyZnojBMX
         36zw==
X-Forwarded-Encrypted: i=1; AJvYcCUatLspfkygdldyD+K8kAoe2V64DSPhQOAHExEn+OaoW7s6Mnv7ZvC3DB6/0JlzZqrLeQyDTGvPB/MRkxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCo8p1Da3uNtb2Jpn2QZb1gGrpx/ZvDY68k60av1T5zT/F1YZl
	VpgKh4bg8qfdbyhKmjmrUyrgTIphzg+pUqhrIAtcJD2I4KhFe3uRPRpZPA==
X-Google-Smtp-Source: AGHT+IFEzrmGRpALAGVKconvFr3R884KqP941Fdm7RrIlzyHNj9gSTRob3wsZU6po/99rAkn3RP7Sg==
X-Received: by 2002:a05:6a20:b58b:b0:1d9:d04:586d with SMTP id adf61e73a8af0-1d9a8533e06mr9963979637.38.1730084888563;
        Sun, 27 Oct 2024 20:08:08 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-210bbf6d327sm41414155ad.67.2024.10.27.20.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 20:08:08 -0700 (PDT)
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
Subject: [PATCH net-next v5 4/6] net: stmmac: xgmac: Rename XGMAC_RQ to XGMAC_FPRQ
Date: Mon, 28 Oct 2024 11:07:27 +0800
Message-Id: <b6f701f7618b8dd659c0cf6e1c81e3d9cfbf131e.1730084449.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1730084449.git.0x1207@gmail.com>
References: <cover.1730084449.git.0x1207@gmail.com>
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
index 05a0e1a22155..ce5dc896f9d8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
@@ -363,7 +363,7 @@ const struct stmmac_fpe_reg dwxgmac3_fpe_reg = {
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


