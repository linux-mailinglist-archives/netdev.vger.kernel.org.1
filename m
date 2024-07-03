Return-Path: <netdev+bounces-108755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A02A92538F
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 08:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15D33283F45
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 06:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014516A347;
	Wed,  3 Jul 2024 06:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="HRK21NSU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A4433D5
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 06:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719987534; cv=none; b=rs+FovLObh4J06H/g0BRLo1ornK9WKQJrgFROmRfCoOXc4jcVU490dCk5zeHK/7PGoGouEDYMvlPnBqrAn6B7bPvzVjcUOkFH/Esqdg65xaGJIV4QimDJkTs/ShbI1NdxOe+adNKkglnCd73Pw9D/MNlydyAjswdvaJpXoMaodA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719987534; c=relaxed/simple;
	bh=61VB0U1/4ibLbcElNxUWDU9uLD1kPVwe53Y9CP56XCs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=uZMYCzvXj3QcsGX8lZCqeGmBD++Bcf0Nbb8H0futPzoy+1DrCf+jOtpWdaVQCgqmILw0oaqzXR9xo+5EXC+uQpyuJmXyVtVvvxgqYMoygvqM+HwSmO0Jc8UsaEJAxu0x6B6W6Jb9UNwmiW//eBD4bu1LrbEZT8ATlcyUdYkECbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=HRK21NSU; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E8A813FD44
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 06:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1719987527;
	bh=U6QOa4p5DGjIW7VT0FAxsBUw54TL3D22ZXc+mN72UUw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=HRK21NSUTRR7OMDXtb4zHGLrEQPxIB0du3WOIzvS2coj1P+azstwKUTJZbPgyPe5+
	 mH1t+Y3TslfHsrzg3pzPtYogURgC7E0gFl7nq/+BF+OoYcd7eijElTKhoa8WzFaxxe
	 VixHLzU2EBTlFlBkfAOtDCvEm2yvmn9uglc5dMaGdao2ETtnAkcppCmNq2+19XmdK0
	 cXEXljhGw/XEf1N8c516C+7eowgWQ1zHlqXuP7Opo/jda9jQAJwQQgGgcFWcKIYJYx
	 nGu7XJxIu+HjxwO/zR6PEI1XFvUtoyxSntm6cf/uY3wgBhC1zVo6P90Bo4tc2DrhzS
	 jJJDMHLGte/ew==
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-707fd74da03so5280378b3a.2
        for <netdev@vger.kernel.org>; Tue, 02 Jul 2024 23:18:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719987526; x=1720592326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U6QOa4p5DGjIW7VT0FAxsBUw54TL3D22ZXc+mN72UUw=;
        b=c1ZAnB9hPnbp5OiaAt69WLdHt4zxJUO/786MzB++ohxehTgYX7E0MhhEshgvHHNIDO
         cr7y5BE9XpXePb03xyb5WSjdOyfm+GCOpOzWRUuceyoDbUYyvFHKnhJbC+5ibPiXnmrb
         TWqN6q+eLeI5b+1iKLYnrD720Vrxt/F0q6zAPSEqRnOrMUd68hCMi3TMZVa+XdclwUol
         n4F2kR2EfkT66BrK5VEW3mZJg3AtWi2pVCp7HLp+G2RgY83OQW8JOp1Vdvar0bgs2CXT
         STvzld1CUu89PhUuShrQxlpeZlYn0XHjv6bBPJGwagBTDuC3hMtqmf7YOfijCoG1gJLt
         EQOw==
X-Forwarded-Encrypted: i=1; AJvYcCVEnrFBagkOWtKtuYsPo3gqWv/71UhicYns9HtQMeAqR09XPHVpvhf59s0HUR+T6m2h9yLrF+ZAIHhHhFb+crYQ0f7j5URO
X-Gm-Message-State: AOJu0YyWpl+lqnitQIrps2wuxG2IpVobhwuzyh8BR1xq/T/SBJb8BOlD
	YFmav0rnd20FwoQheNF3DGgrE9ZqM2T8vzpo+MVgfTXPJvKPCG3Am6k1yUjRmT8vsYXMyp093ya
	f0HuIS6D1LFCn2nIREhc7odyll83Me6HE4IAaeOZHDabO3puyTPOVQL1EdHaFYBgjV2tDyQ==
X-Received: by 2002:a05:6a00:179e:b0:706:8e4:56a1 with SMTP id d2e1a72fcca58-70aaad608b0mr14664500b3a.18.1719987526090;
        Tue, 02 Jul 2024 23:18:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQC6QeXQUsDBKRVwGsKjexDIZNaCLw402fvTZemCMLNU+hjyxfH1ynCl3eSRp1HOz8hh3wqQ==
X-Received: by 2002:a05:6a00:179e:b0:706:8e4:56a1 with SMTP id d2e1a72fcca58-70aaad608b0mr14664465b3a.18.1719987525589;
        Tue, 02 Jul 2024 23:18:45 -0700 (PDT)
Received: from solution.. (125-228-254-191.hinet-ip.hinet.net. [125.228.254.191])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7080205ebbcsm9581936b3a.40.2024.07.02.23.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 23:18:45 -0700 (PDT)
From: Jian Hui Lee <jianhui.lee@canonical.com>
To: Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [RESEND PATCH net] net: ethernet: mtk-star-emac: set mac_managed_pm when probing
Date: Wed,  3 Jul 2024 14:18:40 +0800
Message-ID: <20240703061840.3137496-1-jianhui.lee@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The below commit introduced a warning message when phy state is not in
the states: PHY_HALTED, PHY_READY, and PHY_UP.
commit 744d23c71af3 ("net: phy: Warn about incorrect mdio_bus_phy_resume() state")

mtk-star-emac doesn't need mdiobus suspend/resume. To fix the warning
message during resume, indicate the phy resume/suspend is managed by the
mac when probing.

Fixes: 744d23c71af3 ("net: phy: Warn about incorrect mdio_bus_phy_resume() state")
Signed-off-by: Jian Hui Lee <jianhui.lee@canonical.com>
---
resending to add the mailing list recipient

 drivers/net/ethernet/mediatek/mtk_star_emac.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/mediatek/mtk_star_emac.c b/drivers/net/ethernet/mediatek/mtk_star_emac.c
index 31aebeb2e285..79f8a8b72c27 100644
--- a/drivers/net/ethernet/mediatek/mtk_star_emac.c
+++ b/drivers/net/ethernet/mediatek/mtk_star_emac.c
@@ -1525,6 +1525,7 @@ static int mtk_star_probe(struct platform_device *pdev)
 	struct device_node *of_node;
 	struct mtk_star_priv *priv;
 	struct net_device *ndev;
+	struct phy_device *phydev;
 	struct device *dev;
 	void __iomem *base;
 	int ret, i;
@@ -1649,6 +1650,12 @@ static int mtk_star_probe(struct platform_device *pdev)
 	netif_napi_add(ndev, &priv->rx_napi, mtk_star_rx_poll);
 	netif_napi_add_tx(ndev, &priv->tx_napi, mtk_star_tx_poll);
 
+	phydev = of_phy_find_device(priv->phy_node);
+	if (phydev) {
+		phydev->mac_managed_pm = true;
+		put_device(&phydev->mdio.dev);
+	}
+
 	return devm_register_netdev(dev, ndev);
 }
 
-- 
2.43.0


