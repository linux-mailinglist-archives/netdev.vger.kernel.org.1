Return-Path: <netdev+bounces-220132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29001B44892
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 23:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2D121CC1538
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 21:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D659C2D0C64;
	Thu,  4 Sep 2025 21:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZ7eF6Si"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA322C21F7;
	Thu,  4 Sep 2025 21:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757021565; cv=none; b=st58q5Aq5Vl+IJiFrXqKRkT0kX8nNsJd+J6+NJ9wUY6DghHbADEQS5cnPpSEeS/BdekZ1WU//SeCXPyYJ/ec/1e8ktz+P7v7KyZsfFuoRP30TehWp5mh7K01P2KcO6tKxTsy6WAMrz+BgWDPMNOi2K8EPEZV5m+bPLNf5Ge0uwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757021565; c=relaxed/simple;
	bh=mskh1ca0IFsv+ws5kBUC/1IZ+qrxNgix4I2UcawkYxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DW5/S9IBit5NFJo5tS44rqGBM02iUi5X+Ma/e8RyXS2/+v6E7kMCzfGEESh8y7WYN55MuWNtGYaIQkiTvyiT02azZY2G3Odu9nse06eSNmL34AZ9Eu6lMAYg5TJC0/wB2ieouZtYPT+BgO3LlKZqYcvuFuCwnZSE2TkeIpOw3ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jZ7eF6Si; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-809f849bdd6so162206985a.0;
        Thu, 04 Sep 2025 14:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757021563; x=1757626363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SP//4Q+uImYUL6/+8qHx67kUOU4MQKI9owsJGMxhBGo=;
        b=jZ7eF6SiQzp/asAtTns5X1fZy2N360g+HLZt5tMpONZZtOjos3T//ZaJZeubERlGg0
         /Gn6DsP4/0hR5T6iOrjYDPS52rRC3yoIplMHhESiAihWpvxHMCr8SRVCw7zYCnLk54+n
         ZxRTLAaKDKULuKbQNormcfwVjbkTMe3mubQYNiicplLMBYpWYDhhqaMEAmXcOxjQWWZX
         S08NNkVCMnLc7l31M+ja2hs16PhGbcm9TLBls+N2eO/XzQO6EpPkDmvSW3guTEfOWinW
         bTLKWFI1zuSOrnxdyrsco5Rz/8sgosFt2a0kgQqleXQBWeQyKWfMrHauwFDyHBguZWXx
         ieTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757021563; x=1757626363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SP//4Q+uImYUL6/+8qHx67kUOU4MQKI9owsJGMxhBGo=;
        b=Fk8ZcpMLJYUIbdyYO27dWaM1erWjvPdghSF7Xb71EK2cY23T7+eVLEtU0/qXJdb5DY
         GiF568jPpT2s/ic1eHdP4NJdGliT3fXqtw7gVsbt37npQaMGRS2pWvgtATKB8BAqWlyZ
         x0uFvPxQTM6dcd5GbAJcN1uqnU08+xhW4Q0mUiWFm/UfhFJpJ4v74+r28jkPrAfpKzWJ
         KBNuUX6nikczh8fMfNiswQB11Nh1Y9jhnRGlaQJJn1oBw97tv1L40WYMhDrdoZvXqgac
         +eznkcgelIeFWsKQGr0hU1TkuZ/UDO/QsGyGQcS9qDWYiOT7YcPV1d1Z30DSvwtjASE/
         TAzg==
X-Forwarded-Encrypted: i=1; AJvYcCVZdvvTbjtpG8emu2pc9gSskr3Pm5/BNJbH5xC25SIPNbuxYDteh8/dJ6ef83rMb0YbVPBnt1L3Ca6TBMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgrkIXXx0OgnFAXCNNy1yr7Ql8IcrWzaNkDenkkvp9SCL8BhIe
	M5aUt6FR93mGCBE9Nr/DjnKkMUktOms0JhKh5Qpf5dn1GyYkfyzRVwKrRjfT9A==
X-Gm-Gg: ASbGncuT0wDL7xUBjfNMVn5d7vc4Sdu5rpO8feYmA6+/zi3slyKHvV7GxEV8wCvjNoK
	oK5GC5eZE13JaqW0G74Udspyg8oDjARMHqKklkaEjOSpiKvVn9P9lVso4rApuq6tTR3N/xosdpm
	BxT5RDL3ayDyteoht1D6Arfwbn6MDMH1gtgirxqvu6/nZrw9kY/tq9Fb0dNXfEXQZGeN+cBzPU2
	j21voa2OwpgwcIDeEtrjUJBaHYZhmKlj89LNrnx1Yy8gfunj9zCVEiXrXX5Xj/jE6HJwQWuepDp
	nhDVP87rklpSobIgYBg19Jba5k7Z2ymJLQ/cuSBkeBsnYAb5N/kC9VcNd6Vtjw1GukBQyOwF40j
	fe1jAHxKdaa+dZsl108JjsgpYilDpshk3xwG5QGkAJhZduCR7v5u+/yRfKz8JPMt6e9ouXpE=
X-Google-Smtp-Source: AGHT+IEqs7POj69pxkvZDjE95U6KYOVuVkDeoyFsTxqhrP/MM9ePnYC09WI0Yur0q2gFyWQ0dNfZrw==
X-Received: by 2002:a05:620a:461e:b0:7fc:797a:942a with SMTP id af79cd13be357-7ff2b0d77d8mr2309803585a.45.1757021562704;
        Thu, 04 Sep 2025 14:32:42 -0700 (PDT)
Received: from archlinux ([2601:644:8200:acc7::9ec])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b48f635cbesm35473501cf.5.2025.09.04.14.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 14:32:42 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Sunil Goutham <sgoutham@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/CAVIUM THUNDER NETWORK DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 net-next 2/2] net: thunder_bgx: use OF loop instead of fwnode
Date: Thu,  4 Sep 2025 14:32:28 -0700
Message-ID: <20250904213228.8866-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250904213228.8866-1-rosenp@gmail.com>
References: <20250904213228.8866-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is implemented under CONFIG_OF_MDIO, which already assumes an OF
node. Also the loop already checks to see if of_node is NULL before
proceeding.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 .../net/ethernet/cavium/thunder/thunder_bgx.c | 23 +++++++------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
index a68dccb7c2da..06ca305de1b4 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
+++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
@@ -1468,30 +1468,23 @@ static int bgx_init_acpi_phy(struct bgx *bgx)
 
 static int bgx_init_of_phy(struct bgx *bgx)
 {
-	struct fwnode_handle *fwn;
-	struct device_node *node = NULL;
+	struct device_node *node = bgx->pdev->dev.of_node;
+	struct device_node *child;
 	u8 lmac = 0;
-	int err;
 
-	device_for_each_child_node(&bgx->pdev->dev, fwn) {
+	for_each_child_of_node(node, child) {
 		struct phy_device *pd;
 		struct device_node *phy_np;
+		int err;
 
-		/* Should always be an OF node.  But if it is not, we
-		 * cannot handle it, so exit the loop.
-		 */
-		node = to_of_node(fwn);
-		if (!node)
-			break;
-
-		err = of_get_mac_address(node, bgx->lmac[lmac].mac);
+		err = of_get_mac_address(child, bgx->lmac[lmac].mac);
 		if (err == -EPROBE_DEFER)
 			goto defer;
 
 		SET_NETDEV_DEV(bgx->lmac[lmac].netdev, &bgx->pdev->dev);
 		bgx->lmac[lmac].lmacid = lmac;
 
-		phy_np = of_parse_phandle(node, "phy-handle", 0);
+		phy_np = of_parse_phandle(child, "phy-handle", 0);
 		/* If there is no phy or defective firmware presents
 		 * this cortina phy, for which there is no driver
 		 * support, ignore it.
@@ -1511,7 +1504,7 @@ static int bgx_init_of_phy(struct bgx *bgx)
 
 		lmac++;
 		if (lmac == bgx->max_lmac) {
-			of_node_put(node);
+			of_node_put(child);
 			break;
 		}
 	}
@@ -1528,7 +1521,7 @@ static int bgx_init_of_phy(struct bgx *bgx)
 			bgx->lmac[lmac].phydev = NULL;
 		}
 	}
-	of_node_put(node);
+	of_node_put(child);
 	return -EPROBE_DEFER;
 }
 
-- 
2.51.0


