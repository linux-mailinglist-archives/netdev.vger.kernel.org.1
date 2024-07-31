Return-Path: <netdev+bounces-114511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 923D0942C48
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 12:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3C441C23363
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 10:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7421D1AD3E8;
	Wed, 31 Jul 2024 10:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQyTarBD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2341AC44C;
	Wed, 31 Jul 2024 10:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722422670; cv=none; b=NG3eIFDyYnhJVGROhQlJ9gGZBelD6KwBGyeqQ7XKPD4ZPNhcJ8+wjLFNn1lY2C8+4d9jVs9wx4ij3Yp7njwgj/sQDR6eQ5SF7ZBsTLM2OjcceiNKkC5wFlPmBm/n65NEXBoNzyEhmeDkVNTU0OixiScqI4xpNu3wNLN2b/sarR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722422670; c=relaxed/simple;
	bh=ZXDpUjreLVo/wT4q+0h35tB7/2043nuYSnJ13PFOakI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TmV8S2nXEm4KhflaJTmPlnoSfMcSwmp/28BwnIcAgaI2vbwCukxf6974x3pf445fEIZz9ratywDCxXs0E3LTe84FSFvDGZutDW2kVHlsVWO0g+vw16B51zMnw3ET51YC0mOyS5d2u55aVS/UKqiASpll+Q6TdMBHgJLplgpF+gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQyTarBD; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70d2ae44790so3917148b3a.2;
        Wed, 31 Jul 2024 03:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722422668; x=1723027468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DPGHY6v5CIr+Eb9z9smFgMyzujoybq7sK/FaJAiXSc0=;
        b=DQyTarBDOIko5G3vS6ZwcUWfZ8mTNq5vMvred2Nj5lOvsJN4iKzx22w1FhInDwR7WJ
         PCJX5EtEyiKbVysVWMachldXsfTkGLlJYRmC1NNqT6X7B99A1huYOysLGNNGkOr3kUp+
         e3iB4fJ9ZTHeSRaDLQ+MLjGm1n93Tt8JnpliwAwtLZ3zSsDhPaGGNu+x58aGrrWv3jHm
         07rrOr+ZIs/5BOmsKhtPYgMkg1Te/Xjj90pXQGzOz6VnnUaw5Ch4yS71IHazAmYpXx7/
         0zxj+HIRUPUBZKfIYhi5yrvw/c5aZ24mEnrdgeyHsNDa/kpyURbt4rdqcr5qMNMtfV6J
         7fwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722422668; x=1723027468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DPGHY6v5CIr+Eb9z9smFgMyzujoybq7sK/FaJAiXSc0=;
        b=ZQOE6IcfppuN7xSxm0UcFKDMwNcFegdLzb86WEg0FKlOOYRxNVVEMsQ0IIcC9OIZpN
         DXRg9R2JssHr32wlBfKXm5dHqVFyyC4Y2JUFrELx8a06WyjHpmPvDfYT+fTQ1jnUh7wr
         cWqIch+PsLUhgwHJQjF0JO7Uu4bZcbD7dz1YVfM1gplRiV9NkgszbZ5pEAWiA8ZU5wi/
         mP9TOHv34JImy5E/I+tCBm2pmWPLM2ZI/j6dpYAMuIzDAOYiodO868UBAyhjmxb1kfu6
         VRX7mqnbHvcyYm6tbFTqKde0p3orFdZT/30I41pMKiiVYjKLjGaEkS49j6pVy73f7HGt
         mwEw==
X-Forwarded-Encrypted: i=1; AJvYcCVo+bJXeJEUanWw4JeVpJp//mmisLbqamIAASmhM9U77u6w37cwkVJh7KqI7n0KAIut6lFdA+AWGeomFQbtcI2NNKXQpIjYCuvqQAaS
X-Gm-Message-State: AOJu0YwAmOU5ZRc8CbqLnamw77vyGgozjeTSC4ulbBSxxmW8tneRhkJQ
	dtgI2gmm6dXXUZK+1lmqAwZNiHx81QhPkRxfnJZZZAtoDdrUzfQx
X-Google-Smtp-Source: AGHT+IFTctTZ1qQ55uQCVBFKWaKO8LVEq4OqBYk1wWdf3UiDgyEsaVyIy02DJQJqJ0/PrRnYWTUxGA==
X-Received: by 2002:a05:6a00:21c9:b0:70e:a4ef:e5c2 with SMTP id d2e1a72fcca58-70ecea30033mr13327588b3a.13.1722422668091;
        Wed, 31 Jul 2024 03:44:28 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7a9f816da59sm8791375a12.29.2024.07.31.03.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 03:44:27 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	xfr@outlook.com,
	rock.xu@nio.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v1 4/5] net: stmmac: drop unneeded FPE handshake code
Date: Wed, 31 Jul 2024 18:43:15 +0800
Message-Id: <62d2b178672ced64f98d51bff17006728e77dea9.1722421644.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1722421644.git.0x1207@gmail.com>
References: <cover.1722421644.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FPE is configured via ethtool-mm, the hardcoded way shall be no more.

Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 +-----
 include/linux/stmmac.h                            | 1 -
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index a5e3316bc410..fba44bd1990a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3532,13 +3532,9 @@ static int stmmac_hw_setup(struct net_device *dev, bool ptp_register)
 
 	stmmac_set_hw_vlan_mode(priv, priv->hw);
 
-	if (priv->dma_cap.fpesel) {
+	if (priv->dma_cap.fpesel)
 		stmmac_fpe_start_wq(priv);
 
-		if (priv->plat->fpe_cfg->enable)
-			stmmac_fpe_handshake(priv, true);
-	}
-
 	return 0;
 }
 
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 707a6916e51a..66eb4627bd47 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -157,7 +157,6 @@ enum stmmac_fpe_task_state_t {
 };
 
 struct stmmac_fpe_cfg {
-	bool enable;				/* FPE enable */
 	bool hs_enable;				/* FPE handshake enable */
 	enum stmmac_fpe_state lp_fpe_state;	/* Link Partner FPE state */
 	enum stmmac_fpe_state lo_fpe_state;	/* Local station FPE state */
-- 
2.34.1


