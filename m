Return-Path: <netdev+bounces-108033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 974C091D9D0
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 10:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51F83281CBF
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 08:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8E07E76F;
	Mon,  1 Jul 2024 08:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+FK+zgM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9B61804A;
	Mon,  1 Jul 2024 08:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719822035; cv=none; b=hMTf3Rnzilv1YWd9Flw+31SvLRiZ9ePEiHvbtzOZ2BcseMfqrhztappmcrh+ZjTSM2PAXfRjgAkqu537ej2q1eq4cfTdMlPBW3RCybskTVK/XrqhuHheXgO07epLGwZgegG2ydM/0Lng+v/bRZbpJN8kKrJlwZNRXeG08Ykl5Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719822035; c=relaxed/simple;
	bh=05S15/+/BVoyjLmU/P7ALenx2HXbOvfGSTf3w8E5qNY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CqTdHa09+H4/dOiAfN8KuAVG4P4zA8CQ64UF//yvXaeY+U50uiNPrssaPeDtHfoBplvt3VCKgkVjny9O68xLtHl+S79hQ5fnDL03R5iBSqKKXPxTPRwRXzLOywaVNTbx8Xkjgdr0pDkIJvKPu+n5BySxqo3Ba3EWUQunvFtR46c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+FK+zgM; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7067435d376so1873493b3a.0;
        Mon, 01 Jul 2024 01:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719822033; x=1720426833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MC5/1uIy6r+d6wkfwo0SgQbace/5QXNKCEPCP25Y26U=;
        b=W+FK+zgMelMenL9vILvlRCSzzpvfx6o1jpJsF7fQuxoIFLjF35rSS2sxdh+auGh6oF
         BJ8XXVSpYzWlVQbooQURcP5pfyiya3BKFuz0kLM8OVcjoGHx9J0qrOq0FFrTua9xRoLJ
         lTB0yzU6JI5tdH5lA1ByBE4VCdlThrMRwbkFeVEiXBRblFFRTvHYM0oh7kMi0677XHPd
         jVEo3Ig8UOlOJjxUloHcEfDZjo+Rw5/jHGwzFd1HLA+PTNV7gJ00DHnacx+8EN6O8Fvh
         4Mh5rNYpjIkWD9XU7ebT7iW/TXeXJZrFXBrfhEsXkBcIDLJwKpuF8lUCRqtv2O25GN47
         Okdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719822033; x=1720426833;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MC5/1uIy6r+d6wkfwo0SgQbace/5QXNKCEPCP25Y26U=;
        b=fbZX+bGLKdeH/oj3jDhKNQWeA+1hJ2vTJ5NcQgqN9cPvoJqjwwe/pjylgPdRaQgdiv
         culMMcb6cCnCe7/G0c+fyKQICuPWo/+RJmOHxBbYfh4lLqh9Ovx7kVf9k68bM0upr/4/
         hYPSbReF+D6WrNJXSUdBtbV8vEg3gFRrU8rMVMKSuwxktfbLPFw9M3+jBYibqoyztXgn
         YvGNICVi/it093JXlzP9exLEjCGTRSiPXchU+n+zXxEBezTOWPlBWzeBUdewRFoSk/8+
         F9bQKynTXytQhvcZn3qBY7ypCLchEOQJFm02kDEFaqZi5S70J8n1B63Mcj7nMFCJKyfE
         nQkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRSkKTLrDq+LjGo+GhzUN3ugSpHwEk3RBtV07YuvQ5jsTOcsZWsmlwj0AF7owSZ6RBE1/eFnOyBgYf1+1e2kqeVnbbnOurLk7w4BXZ
X-Gm-Message-State: AOJu0YxiEvrqf1ScpgM1OAH8CbvaXH7YifaZHhPHTcR1b+jeEo+BWFvY
	Vq9uyPetHZPstjs+dXZwxHbMDsJLrWyzxzYrHVRdVHiZtDOeoVwO
X-Google-Smtp-Source: AGHT+IHwmPMU7oYRhiuqelGxgEX+rgaw/YH4bqX/NunRhcIN6nUMudhE6o8PIx3RNMLJoj1enQ/H9g==
X-Received: by 2002:a05:6a00:4b13:b0:705:cc7d:ab7d with SMTP id d2e1a72fcca58-70851875908mr16008127b3a.5.1719822033063;
        Mon, 01 Jul 2024 01:20:33 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-708044ac424sm5864836b3a.161.2024.07.01.01.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 01:20:32 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>,
	Lai Peter Jun Ann <jun.ann.lai@intel.com>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	xfr@outlook.com,
	rock.xu@nio.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net v1] net: stmmac: enable HW-accelerated VLAN stripping for gmac4 only
Date: Mon,  1 Jul 2024 16:19:36 +0800
Message-Id: <20240701081936.752285-1-0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 750011e239a5 ("net: stmmac: Add support for HW-accelerated VLAN
stripping") enables MAC level VLAN tag stripping for all MAC cores, but
leaves set_hw_vlan_mode() and rx_hw_vlan() un-implemented for both gmac
and xgmac.

On gmac and xgmac, ethtool reports rx-vlan-offload is on, both MAC and
driver do nothing about VLAN packets actually, although VLAN works well.

Driver level stripping should be used on gmac and xgmac for now.

Fixes: 750011e239a5 ("net: stmmac: Add support for HW-accelerated VLAN stripping")
Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b3afc7cb7d72..c58782c41417 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7662,9 +7662,10 @@ int stmmac_dvr_probe(struct device *device,
 #ifdef STMMAC_VLAN_TAG_USED
 	/* Both mac100 and gmac support receive VLAN tag detection */
 	ndev->features |= NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_STAG_RX;
-	ndev->hw_features |= NETIF_F_HW_VLAN_CTAG_RX;
-	priv->hw->hw_vlan_en = true;
-
+	if (priv->plat->has_gmac4) {
+		ndev->hw_features |= NETIF_F_HW_VLAN_CTAG_RX;
+		priv->hw->hw_vlan_en = true;
+	}
 	if (priv->dma_cap.vlhash) {
 		ndev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
 		ndev->features |= NETIF_F_HW_VLAN_STAG_FILTER;
-- 
2.34.1


