Return-Path: <netdev+bounces-109730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E534F929C81
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 08:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 139C71C20E6C
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 06:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBD5171D2;
	Mon,  8 Jul 2024 06:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="GM4Y2HZW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93B713AF2
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 06:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720421546; cv=none; b=ZWLs40PP0W+dKbSCuiZ/JD1iny7rbGiWQzdpb9FYNOcvOZZq2WasfZbwp4jyViEKjX64sxy2W04bEY+sfcKdqYVc6YWDNz1fIebOuBygk3EJxxjCEW26ks21yD/YNtl8f0LbGynB64v189vf0gVpNVrL/nKc0ZeVBPSPkz4KB0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720421546; c=relaxed/simple;
	bh=XGAUAZ2tJFn06FQspuaDvlm800OeXNZrlzDbL5cCwhA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=UZa8I/q6/FA579NCsgqavuItQ0+J/3gghYHb2ohFTJHLUyCxujlapU1VA+r4/TCUlTT7yXXH9NwN90U8Ix8GIdAszzjidtmF8IOBtCYPh19qBSxthhuAHMPVmotj5vGOJ/dcMVLfQj3XaePS6nhyesOOkN/HHpLSHjkxC4US+7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=GM4Y2HZW; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 978F83FE20
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 06:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1720421536;
	bh=HbzMAQQs0beQFPhhkJhPUz49qUwPsn+ZS8RIbID3OKs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=GM4Y2HZW8SHC3Vm6rGPVn+HMAnkgWBk2iBeNy/xmVEfJEgrwDDIKX729NbkMzyWXy
	 ZeisYI6Q08bXwH6oANqYaExVXpMfnlHY9onZJXqsuOkcGji1DrvAuUt11bUEvdoQF4
	 YRoIJnzyYLhtaIc9dYzb5p/kTgyxgIf0JfTixGCScUUxT4t5JziicxhFENuoZuCFLa
	 8/QevvnQ6fvLyIpHsym8e1snbZg91S0ZYfanx/xHo8SSJWt7VDMDlFY2DsHCIvq68j
	 fxbL2XLt152SqyKd1tNqal8tWaCoc7oDknc4QC942+i00ZzgXlGsWWlL7gM5mbbK9r
	 fxFrE3WbiAmaw==
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7035d9b8a65so1909840a34.3
        for <netdev@vger.kernel.org>; Sun, 07 Jul 2024 23:52:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720421535; x=1721026335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HbzMAQQs0beQFPhhkJhPUz49qUwPsn+ZS8RIbID3OKs=;
        b=VVUEZNYtltPo98/WHVBdLJn/on+rHDxM7NpsMwdAGUe7gcn2+kEYtvPR+LyqPv2qkP
         NfFdyN1ZpsNZFPPK4zs98xIVgKEYUsq5P6kmNBoipirf0KtLg62arwlO1md4/Zqp7Pez
         aq9U3MKEczUTZmzHou8Tf+CfbPh4PKiDAZzjZY0XGYycnCtjz5U+uzmUiAGoInBWsTWV
         5GPnNKo5xcXF6QwEDpo7DHGDkCZDGjWTuRHu5hbShQMveU6IMg7TgANYcQ7DOay7rbvk
         m/x/Cwd9rd/+CB6WVp/6JmieJPJ3vzZqf5CyDscYBpwKPtIcU6cVG9ngG1d+omCXFR0o
         1u/w==
X-Forwarded-Encrypted: i=1; AJvYcCWTPDe5Gb3WdKwh/CEF72GVXNs4FJMg5JWQgzNigYjRipdBwI/ayTM72A99TwEy/pVtY8pWEigCYOX9Vhz211YWnEQ9hxRR
X-Gm-Message-State: AOJu0YxZvPXDBY2Mi/JLfi+YJju+lVdMPI6Ufv+pbnYocMOCfrmYFO0t
	WgvaMpSW76BDkdPYetmgr6cpz9NOyWWsVj9iAQLoEiae8f9Uv/p7KHff+f8Lu0gdEigRzvoaJeZ
	2iS0m53yFKnpMpo9gYXCr81PlP3fRej+bXr62BvUazNJOpGt1eUJ3yQPzHR46hM9Vjm7pkg==
X-Received: by 2002:a05:6830:4121:b0:703:5be9:7eb2 with SMTP id 46e09a7af769-7035be97fb1mr10205065a34.1.1720421535289;
        Sun, 07 Jul 2024 23:52:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDdcN3FhbXbJhL25LGgTT9SMrkYrFZRj+Qr84KVRq4ZsIxJ4/dnZO5KZecMBqaC8bwrBJVHA==
X-Received: by 2002:a05:6830:4121:b0:703:5be9:7eb2 with SMTP id 46e09a7af769-7035be97fb1mr10205048a34.1.1720421534961;
        Sun, 07 Jul 2024 23:52:14 -0700 (PDT)
Received: from solution.. (125-228-254-191.hinet-ip.hinet.net. [125.228.254.191])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b15e0cefcsm4484195b3a.166.2024.07.07.23.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jul 2024 23:52:14 -0700 (PDT)
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
Subject: [PATCH v2 net] net: ethernet: mtk-star-emac: set mac_managed_pm when probing
Date: Mon,  8 Jul 2024 14:52:09 +0800
Message-ID: <20240708065210.4178980-1-jianhui.lee@canonical.com>
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
v2: apply reverse x-mas tree order declaration

v1: https://lore.kernel.org/netdev/20240703061840.3137496-1-jianhui.lee@canonical.com/

 drivers/net/ethernet/mediatek/mtk_star_emac.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/mediatek/mtk_star_emac.c b/drivers/net/ethernet/mediatek/mtk_star_emac.c
index 31aebeb2e285..25989c79c92e 100644
--- a/drivers/net/ethernet/mediatek/mtk_star_emac.c
+++ b/drivers/net/ethernet/mediatek/mtk_star_emac.c
@@ -1524,6 +1524,7 @@ static int mtk_star_probe(struct platform_device *pdev)
 {
 	struct device_node *of_node;
 	struct mtk_star_priv *priv;
+	struct phy_device *phydev;
 	struct net_device *ndev;
 	struct device *dev;
 	void __iomem *base;
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


