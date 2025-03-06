Return-Path: <netdev+bounces-172563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AADCEA556A8
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 20:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA1583B4491
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 19:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954A327BF88;
	Thu,  6 Mar 2025 19:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fky3Yh7/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F087C27BF63;
	Thu,  6 Mar 2025 19:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741289263; cv=none; b=NVaBMK6UC8O+3lSCxIOotCTgIzGLRAOwu3Z6FzmPJkOIsCjDnes8CWeSK0qzpWcxUf6MevOz4zpYJeGlMpXDn+sPNJOIkyDgsTRZsT95fKK8/5jH1Asm3ytHRvKuw80jozvYgyMRE4gb8IcgUhsXCzEuW5iwxdCv03PK+OKaKMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741289263; c=relaxed/simple;
	bh=eAIRLUnMOIy1RnBtSNDWW2wc6RIAjYLBCvYCJxZGoJM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uJxAGGKqZtWW2ma/ti14Yz34ohGwZLWydsvMP1bruizfJrxFxkFNYBNBunGfFyBu8WePhiykEY2x5fUrlq/3hQKe/QzAZwI7ZvUCQiAQaDywJX/0h8a0WEd/QEFJ8+VLSkJYEQSKJQrJoTrBZK3qOXsEK/XlFejJ6v/x0QEGzqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fky3Yh7/; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7273f35b201so549003a34.1;
        Thu, 06 Mar 2025 11:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741289261; x=1741894061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRanwQs724yOc2GriHumEsvu9jf1tyt+mqhjv2htax0=;
        b=Fky3Yh7/S1y1yEryo8G83urmu/e5cvEsFcSkw9GardjhnJ/wC4/icGWjE1J8IUZO7B
         EUIiy9F8DMGgvpCSGc45Ki+xBEjNolSXcMp7GFKiWmIrLrywuaZjjJvOzbwQSYlyqgW1
         vyaSwDBlRKk/P11JQS2MvUEaeAbPV1LrDtyuWO7FVSyKnkfda0MKKQxDnjQ6FKTjwS+O
         xrWfaLNoqmNLj5fOka5pgf77WoQUI/7Yk0idrhjEsOpCBmBd5C3+7eOo+HQZ+I3M0Jea
         v+3jTd8wNZVohq4QexkgCZxE/vUIguuQkkFo+EyNiv6GuFlckoO+kIr8Wmo7i37Toy+B
         FRWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741289261; x=1741894061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uRanwQs724yOc2GriHumEsvu9jf1tyt+mqhjv2htax0=;
        b=LvWwpA9UI/jFliYTQONAZhPuONCKZknHQgwZiGm3n1Uqd8ER90/gr8WvghNWWxLP5O
         NkvJEd6x8CjYXMpUodQdjr5TSrXpRcnY0AYGgCQHIZE3r7O8j+RqrZfd5uNEjRj3obPM
         6wLrLVqsVyshEQPakryHF+KutK48FgoT0x2S2WerSL0Xz8YzAATifFWw+ZqffWb+TEHg
         Y3tod6OldgjHls9LYVWJ5YFxDahB5mTaQJk2YN63XFIX9s0PDm7vfxGWOYkBxPJ7HDVd
         Bxmh1JETbwc9HBF5GVsdu2SbjW6EvpvFD8CI/esJ5GoEsf00vePG99nw2DNaIRfCnSyJ
         JSdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfFxO2lzAwCs1706J2UiVzHwl2rAOxtYB9P2GlnvUN8Blld++u5nJJOOULLv/M5rrS1FX2ZLuvIQqBUp4=@vger.kernel.org, AJvYcCXHo00vp5dKtV6l4hkUFm10V6ZjxL0YtObiwPNRxrZi+GP/yii6vh61nnTFl5ADu3wX8AkHhjZR@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz3NnBXTi0xZOh9xecElRqAbUwaJZXE/sS28ZWNgfO3C+QVXyE
	Gb/P6uDVIFhB9C50HisI9j3sLGUR+Jx3GYRD/ImnjNa9Q8qIhDCu
X-Gm-Gg: ASbGncsAiTI5mild9R1q4qv6PvaER4nhaJ9D65HH9khNm2WRDTubq4fEm0onvjQMiMs
	3nOfRxveqRdoNDLSpgPj5U5ebDlgM/pJEue8Jkt3kUvTv7rTiBUk5jobciZg5nUlamYhn87+6Xx
	qfZUCOULjWNsULFw29s9ced/0vVsCJppmoWy8B88Khya6FDfuL98a94dp/iE/ZgARjr3bQz5jXu
	Oc0NrFKpA7JhMo5SkhhNWr+gCaedr8caabancBTCFHDzjjSzSjAX+P6VeVpwLQdUA8RBLG62JVC
	GPujdRMEMBhyrNKIZKnMxWP6ZIsccMqqcGLSl8e3dmQmdPJ2k+g6/4WbsR9Zl3HFYh5T/fCL79t
	PrUPAkBWfzab+
X-Google-Smtp-Source: AGHT+IFDrCQJLcQ967DjPI6NPCo2uO0jc2enNTfqg0NMgR1eMxSXFU7468V3Mt4rrM2gplQpW2HU7A==
X-Received: by 2002:a05:6830:2aa8:b0:71f:c1df:121e with SMTP id 46e09a7af769-72a37b703c8mr357448a34.8.1741289261041;
        Thu, 06 Mar 2025 11:27:41 -0800 (PST)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72a2dac3887sm366338a34.7.2025.03.06.11.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 11:27:40 -0800 (PST)
From: Doug Berger <opendmb@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Doug Berger <opendmb@gmail.com>
Subject: [PATCH net-next 08/14] net: bcmgenet: remove dma_ctrl argument
Date: Thu,  6 Mar 2025 11:26:36 -0800
Message-Id: <20250306192643.2383632-9-opendmb@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306192643.2383632-1-opendmb@gmail.com>
References: <20250306192643.2383632-1-opendmb@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the individual queues manage their own DMA enables there
is no need to return dma_ctrl from bcmgenet_dma_disable() and
pass it back to bcmgenet_enable_dma().

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 .../net/ethernet/broadcom/genet/bcmgenet.c    | 21 +++++++------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index ea575e5ae499..56fe4526c479 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -3165,8 +3165,7 @@ static void bcmgenet_get_hw_addr(struct bcmgenet_priv *priv,
 	put_unaligned_be16(addr_tmp, &addr[4]);
 }
 
-/* Returns a reusable dma control register value */
-static u32 bcmgenet_dma_disable(struct bcmgenet_priv *priv, bool flush_rx)
+static void bcmgenet_dma_disable(struct bcmgenet_priv *priv, bool flush_rx)
 {
 	unsigned int i;
 	u32 reg;
@@ -3198,20 +3197,18 @@ static u32 bcmgenet_dma_disable(struct bcmgenet_priv *priv, bool flush_rx)
 		bcmgenet_rbuf_ctrl_set(priv, reg);
 		udelay(10);
 	}
-
-	return dma_ctrl;
 }
 
-static void bcmgenet_enable_dma(struct bcmgenet_priv *priv, u32 dma_ctrl)
+static void bcmgenet_enable_dma(struct bcmgenet_priv *priv)
 {
 	u32 reg;
 
 	reg = bcmgenet_rdma_readl(priv, DMA_CTRL);
-	reg |= dma_ctrl;
+	reg |= DMA_EN;
 	bcmgenet_rdma_writel(priv, reg, DMA_CTRL);
 
 	reg = bcmgenet_tdma_readl(priv, DMA_CTRL);
-	reg |= dma_ctrl;
+	reg |= DMA_EN;
 	bcmgenet_tdma_writel(priv, reg, DMA_CTRL);
 }
 
@@ -3238,7 +3235,6 @@ static void bcmgenet_netif_start(struct net_device *dev)
 static int bcmgenet_open(struct net_device *dev)
 {
 	struct bcmgenet_priv *priv = netdev_priv(dev);
-	unsigned long dma_ctrl;
 	int ret;
 
 	netif_dbg(priv, ifup, dev, "bcmgenet_open\n");
@@ -3268,7 +3264,7 @@ static int bcmgenet_open(struct net_device *dev)
 	bcmgenet_hfb_init(priv);
 
 	/* Disable RX/TX DMA and flush TX and RX queues */
-	dma_ctrl = bcmgenet_dma_disable(priv, true);
+	bcmgenet_dma_disable(priv, true);
 
 	/* Reinitialize TDMA and RDMA and SW housekeeping */
 	ret = bcmgenet_init_dma(priv);
@@ -3277,7 +3273,7 @@ static int bcmgenet_open(struct net_device *dev)
 		goto err_clk_disable;
 	}
 
-	bcmgenet_enable_dma(priv, dma_ctrl);
+	bcmgenet_enable_dma(priv);
 
 	ret = request_irq(priv->irq0, bcmgenet_isr0, IRQF_SHARED,
 			  dev->name, priv);
@@ -4067,7 +4063,6 @@ static int bcmgenet_resume(struct device *d)
 	struct net_device *dev = dev_get_drvdata(d);
 	struct bcmgenet_priv *priv = netdev_priv(dev);
 	struct bcmgenet_rxnfc_rule *rule;
-	unsigned long dma_ctrl;
 	int ret;
 
 	if (!netif_running(dev))
@@ -4105,7 +4100,7 @@ static int bcmgenet_resume(struct device *d)
 			bcmgenet_hfb_create_rxnfc_filter(priv, rule);
 
 	/* Disable RX/TX DMA and flush TX queues */
-	dma_ctrl = bcmgenet_dma_disable(priv, false);
+	bcmgenet_dma_disable(priv, false);
 
 	/* Reinitialize TDMA and RDMA and SW housekeeping */
 	ret = bcmgenet_init_dma(priv);
@@ -4114,7 +4109,7 @@ static int bcmgenet_resume(struct device *d)
 		goto out_clk_disable;
 	}
 
-	bcmgenet_enable_dma(priv, dma_ctrl);
+	bcmgenet_enable_dma(priv);
 
 	if (!device_may_wakeup(d))
 		phy_resume(dev->phydev);
-- 
2.34.1


