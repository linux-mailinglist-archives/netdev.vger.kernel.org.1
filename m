Return-Path: <netdev+bounces-193288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73240AC376F
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 02:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C1B27A5EF8
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 00:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7484120330;
	Mon, 26 May 2025 00:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIEZImPH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA666B676;
	Mon, 26 May 2025 00:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748219428; cv=none; b=n4aoANET+QKaRt3fGkJa87/YqN4ZUW5iGcrFO6XmYgLa4reMBC06m8c8Va7J9bnhZF4UDKqxrXkzswRcwaYRu98BmK4OcNEPACnOMjUHutU9P53Ax8YL7vmqvg3P++jNKX6T2TnXNBnFnoC+epoyFYWxzW5t1fQRAZKhyUYEOmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748219428; c=relaxed/simple;
	bh=ocL9xN3l5CZIkJMP4iIsK/bvcDmu7NvmAZRKme5JHYE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kNjjqyaj37LHXU9te/4seuNTpmYSdpejWClNsc0tDUm5twFBp5P/YPDYKBpu8ELTvIsKlNbYbsGCLGL9KV8AOAQMpXtlsWOzQmR+ddgTNXli7EKjmpLLiOsaKjg5hpXiHXXfpbpJfMROwmhg8/l9GMmuJs/rb4AzuPu7GFP1X1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nIEZImPH; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3da82c6c5d4so15820285ab.1;
        Sun, 25 May 2025 17:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748219426; x=1748824226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QlxuW8EiAaobylr07WlFl9Wc9Vavh5mNNDPDEO1zHCA=;
        b=nIEZImPHDqgapq09bYJ2Rue4GbxvfmCG9QwnbRHWVeZs2J8MkwMWn35G6ussQ7HbQb
         mrkpxKAgHGP1nQ3YxgAPX2b5RFIFNNc9MI4nK3pN5RvzbYBMonKeujHNAyBVZKI7MyUZ
         KTK5e76qPpVWzAtJHazdWR6vxM3/2P9VAQemDJ6fhGEVQSIJPdTJIUqxx4iSQQQ9nHMR
         LyN7W/1uvDIvY/wgx+kseFpCASZlX/SSuHrxrpwBX9HHJdgJ2o8BC7jnSPrLboFGZr1T
         QH0T08QVOScbTQ49PsiiaPIdl1ip9DOB4Nmgl20KSzffgBiAxa/caEtO66vGq1MSfkIN
         E1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748219426; x=1748824226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QlxuW8EiAaobylr07WlFl9Wc9Vavh5mNNDPDEO1zHCA=;
        b=XrsOqrK5p9+EmwLsEPim+I2EgkcnmEMjrsY7bVzEUDxH9e5b61NoZtXfnn22XeqJ/L
         QHNESy3eVXddPlpvbu/LPF9u2GBPkApymdnHHBqn1aLwZrMQmXeDe/Mq05RRifd0Evym
         PBRzs/ecAxrtfGrU6N6tIV7MAk1CEa0u0rW9XJnxB+4CpX+zJQRkhq+dEPNhFAMdSiLw
         wQBXe5EqbsrcjYj3vUXRdLXuLHgZL4cHTm1V+S16Qz7eQbltj1IgHrIl0f5SFwmjzvVg
         OiOPrYYmR/2I1hNlPgRXIuB+Jaa929WCEB2IipqhH5Xdh99DZ0To/S3FRn0ribMDhRuS
         /FVQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/Oyb+Skp9tUhMWQovLIgUvUrCqNbi/3/zNcjjdTQ8kY8guP0V3qSkQ3KiBw2b+s6GgxxZzPN2iCCEo20=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/YNOpTolpeVWknaH9+MlT0Z6fBu9iac0ttYnUVVR7L+4v/K1X
	zwcAIdSoPNiQr2mhvtq+KgGe8et+EN3RJygL/6n56hK/zQ34xFZVNMMjt5t3OAOs
X-Gm-Gg: ASbGnctydkHA6CXP09hLGcfsW1XtluNXZDCjL06mkIsgWWgvbzOj6SJyqehN/dphSrQ
	IDZc07I9cFQG8aYfrmDWzTmgaC3K5uVBSwOtsuRp74Nv9JtwN1rSvgBRjGi1Ab9ObSCPOVhGgpE
	DebtosCL5IGLLGhq0xT0Z8LUj8wJYI/C/+QQ48FGm/Fhz538yRZZmOMtmxejZekKMo57WiTci/G
	PvTtkhzMEJjdund3GkpkqX0uDesWSDlZl9GbSmZwxcQoI9hsqLH66QM7Y6aaQZ3J+ood+ozwSBz
	E6VxSO6IKewxXeBZIaFotYcMlCkHpECnoW0eGDCA2/X+Nq+3BhxDGALPPzV/xlv+1TuD5VJbnHS
	glmY3oStES8KCXlFnZN4bdzGWtIjgEw==
X-Google-Smtp-Source: AGHT+IEUiP1VLM7hATU3uX+Sltx9XV9gv6KswEzefF313KmIFDOZCAlrrtUCSCIruHAM39yxFL/YfA==
X-Received: by 2002:a05:6e02:1988:b0:3dc:8c77:4d28 with SMTP id e9e14a558f8ab-3dc9b6aa09bmr58114665ab.1.1748219425742;
        Sun, 25 May 2025 17:30:25 -0700 (PDT)
Received: from james-x399.localdomain (97-118-146-220.hlrn.qwest.net. [97.118.146.220])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3dc85ef07dcsm25532785ab.36.2025.05.25.17.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 17:30:25 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-sunxi@lists.linux.dev,
	James Hilliard <james.hilliard1@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Furong Xu <0x1207@gmail.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] net: stmmac: allow drivers to explicitly select PHY device
Date: Sun, 25 May 2025 18:29:21 -0600
Message-Id: <20250526002924.2567843-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some devices like the Allwinner H616 need the ability to select a phy
in cases where multiple PHY's may be present in a device tree due to
needing the ability to support multiple SoC variants with runtime
PHY selection.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 22 +++++++++++++------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 59d07d0d3369..949c4a8a1456 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1210,17 +1210,25 @@ static int stmmac_init_phy(struct net_device *dev)
 	 */
 	if (!phy_fwnode || IS_ERR(phy_fwnode)) {
 		int addr = priv->plat->phy_addr;
-		struct phy_device *phydev;
+		struct phy_device *phydev = NULL;
 
-		if (addr < 0) {
-			netdev_err(priv->dev, "no phy found\n");
-			return -ENODEV;
+		if (priv->plat->phy_node) {
+			phy_fwnode = of_fwnode_handle(priv->plat->phy_node);
+			phydev = fwnode_phy_find_device(phy_fwnode);
+			fwnode_handle_put(phy_fwnode);
 		}
 
-		phydev = mdiobus_get_phy(priv->mii, addr);
 		if (!phydev) {
-			netdev_err(priv->dev, "no phy at addr %d\n", addr);
-			return -ENODEV;
+			if (addr < 0) {
+				netdev_err(priv->dev, "no phy found\n");
+				return -ENODEV;
+			}
+
+			phydev = mdiobus_get_phy(priv->mii, addr);
+			if (!phydev) {
+				netdev_err(priv->dev, "no phy at addr %d\n", addr);
+				return -ENODEV;
+			}
 		}
 
 		ret = phylink_connect_phy(priv->phylink, phydev);
-- 
2.34.1


