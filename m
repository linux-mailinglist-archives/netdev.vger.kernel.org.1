Return-Path: <netdev+bounces-125682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAA196E3CD
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 22:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DC971C22DF9
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 20:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174D41AB514;
	Thu,  5 Sep 2024 20:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNVZg409"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950361A705C;
	Thu,  5 Sep 2024 20:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725567318; cv=none; b=OLatSV2Vcqf/QYYNo+tQBkncBm034ZlHtjoHRVcAIrfukxtm6kIb4fLrYU+djMaqlF8baq+FJ/eIpBjJfcqUGyjH45P2M5M+xE2X//H9e+edqWiSXhfhp3nS1EanGcYcMJzfazvSApFa7LiXppKGKQO2u/VnV+k6dlXbf9wXb1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725567318; c=relaxed/simple;
	bh=bSRHX1yZKX1Frj3AlhJcHG5pMJsG9aGMAJKiYvacp/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hDsuzhh/zn/Zo5Fjbx2CJ144SldcagUGArquoZSY55+6f+GwCOctXb3CYc9T2/0IaXbXVeWUP3D9ieyJ+8sfoxX0SSjFVX3Ta9gXiWc4wWV6/9+B9OynM1lEm0Ia5fR0IBlf3I8GZ3z1aihxJP7rtKRwbUBHgcjxrjSXIa0y2wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YNVZg409; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2057835395aso12189995ad.3;
        Thu, 05 Sep 2024 13:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725567316; x=1726172116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3chJ1T19SwdPfSH8SDlP3tp4ORmuKyqtDERErOcPO0=;
        b=YNVZg4098L9Eey0lBfqyyBJxy3o6mpno9zcEksHqqMECwvo6xnG9s8UuvswIESTz+d
         8N5dLfDEV4OSlzAqX5zEahYN9ApniHJD6WJxgk6G0rqU3lBBUf6QmVNkoP/oUzpJXngg
         qxg61JrWn8eUSmeIN0FyDkkKUGhJtk7pMgjevDtP/+XAVxKMM1O+r2jaK/7OrvRmn0/7
         jsBV1s0yV2S+tiCYIUqUJ2zAuU4XnE+ZmJ4mqGrE/LX2M4+SDJUFVAuDBVTdsn2hqgh2
         toRa9vCcc7XJncj6xcTk6AgqMVNk1AbyrjzINXfuAJ4Q79KzM50Rzeh17y3hdxC10F1F
         HWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725567316; x=1726172116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T3chJ1T19SwdPfSH8SDlP3tp4ORmuKyqtDERErOcPO0=;
        b=KAwpTv9KGPLSSZ1951cX6DOVgjiZmUG5OauyPVq85mhrEtSMNoEmfBdsfCtosr8thk
         Sln3B4woJgzbwI72o948e+MFiSYjcdah7EtOVh6d3RnAQ1vLoNUW6oDOVB37GRZpQOdS
         Z5PylOGUP5ZytPFH05Jtks/0v/JzhZ1zxH8SnDr8lfgCf0zfZsqEk7zM9L5STtaIKqm1
         B7WpcOzDNHOCHD1dQERygwhTdd868Xu78/PQibuyXoJvsqipdz2hoqAfsZQ1L/920j79
         IKzst30xeTp6DE6dbTVQWy39ZwsqEP84tIuazRaL7lKU+tGEZEz9Nwq5cfsLhNotWxXP
         fsFA==
X-Forwarded-Encrypted: i=1; AJvYcCXXEdLba0O2TOfPjGUWQaGkcyvZbWPKSF08bwHPXh5ZzsLejrTWAAScnqzXkRE1JwruzgDethMhmF8LuHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNhKdK00q3VcyajG8ZcpgC5RtGkxvToITt1e2ctr7GaFT/4Di5
	17OeeUUJ5vQ7iSgsu8Df8F5U0p/dEI34S0GSOuQ0BEcxUsHgPFW0FCgYnAgD
X-Google-Smtp-Source: AGHT+IGJl+Qz+lHLDCHKPe3TKyeEXSQxX/l87XQswQctAW/TH3pYCn3NXMantg917U1RmkuX9eHhwg==
X-Received: by 2002:a17:902:cecc:b0:205:7863:2dec with SMTP id d9443c01a7336-20578633103mr180415005ad.27.1725567315706;
        Thu, 05 Sep 2024 13:15:15 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea68565sm32327075ad.294.2024.09.05.13.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 13:15:15 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	sd@queasysnail.net,
	chunkeey@gmail.com
Subject: [PATCHv3 net-next 4/9] net: ibm: emac: remove mii_bus with devm
Date: Thu,  5 Sep 2024 13:15:01 -0700
Message-ID: <20240905201506.12679-5-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905201506.12679-1-rosenp@gmail.com>
References: <20240905201506.12679-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switching to devm management of mii_bus allows to remove
mdiobus_unregister calls and thus avoids needing a mii_bus global struct
member.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/core.c | 32 +++++++++++-----------------
 drivers/net/ethernet/ibm/emac/core.h |  1 -
 2 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index 459f893a0a56..66e8be73e09b 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -2581,6 +2581,7 @@ static const struct mii_phy_ops emac_dt_mdio_phy_ops = {
 static int emac_dt_mdio_probe(struct emac_instance *dev)
 {
 	struct device_node *mii_np;
+	struct mii_bus *bus;
 	int res;
 
 	mii_np = of_get_child_by_name(dev->ofdev->dev.of_node, "mdio");
@@ -2594,23 +2595,23 @@ static int emac_dt_mdio_probe(struct emac_instance *dev)
 		goto put_node;
 	}
 
-	dev->mii_bus = devm_mdiobus_alloc(&dev->ofdev->dev);
-	if (!dev->mii_bus) {
+	bus = devm_mdiobus_alloc(&dev->ofdev->dev);
+	if (!bus) {
 		res = -ENOMEM;
 		goto put_node;
 	}
 
-	dev->mii_bus->priv = dev->ndev;
-	dev->mii_bus->parent = dev->ndev->dev.parent;
-	dev->mii_bus->name = "emac_mdio";
-	dev->mii_bus->read = &emac_mii_bus_read;
-	dev->mii_bus->write = &emac_mii_bus_write;
-	dev->mii_bus->reset = &emac_mii_bus_reset;
-	snprintf(dev->mii_bus->id, MII_BUS_ID_SIZE, "%s", dev->ofdev->name);
-	res = of_mdiobus_register(dev->mii_bus, mii_np);
+	bus->priv = dev->ndev;
+	bus->parent = dev->ndev->dev.parent;
+	bus->name = "emac_mdio";
+	bus->read = &emac_mii_bus_read;
+	bus->write = &emac_mii_bus_write;
+	bus->reset = &emac_mii_bus_reset;
+	snprintf(bus->id, MII_BUS_ID_SIZE, "%s", dev->ofdev->name);
+	res = devm_of_mdiobus_register(&dev->ofdev->dev, bus, mii_np);
 	if (res) {
 		dev_err(&dev->ofdev->dev, "cannot register MDIO bus %s (%d)",
-			dev->mii_bus->name, res);
+			bus->name, res);
 	}
 
  put_node:
@@ -2656,8 +2657,6 @@ static int emac_dt_phy_probe(struct emac_instance *dev)
 		res = emac_dt_mdio_probe(dev);
 		if (!res) {
 			res = emac_dt_phy_connect(dev, phy_handle);
-			if (res)
-				mdiobus_unregister(dev->mii_bus);
 		}
 	}
 
@@ -2697,10 +2696,8 @@ static int emac_init_phy(struct emac_instance *dev)
 
 			res = of_phy_register_fixed_link(np);
 			dev->phy_dev = of_phy_find_device(np);
-			if (res || !dev->phy_dev) {
-				mdiobus_unregister(dev->mii_bus);
+			if (res || !dev->phy_dev)
 				return res ? res : -EINVAL;
-			}
 			emac_adjust_link(dev->ndev);
 			put_device(&dev->phy_dev->mdio.dev);
 		}
@@ -3262,9 +3259,6 @@ static void emac_remove(struct platform_device *ofdev)
 	if (dev->phy_dev)
 		phy_disconnect(dev->phy_dev);
 
-	if (dev->mii_bus)
-		mdiobus_unregister(dev->mii_bus);
-
 	busy_phy_map &= ~(1 << dev->phy.address);
 	DBG(dev, "busy_phy_map now %#x" NL, busy_phy_map);
 
diff --git a/drivers/net/ethernet/ibm/emac/core.h b/drivers/net/ethernet/ibm/emac/core.h
index 295516b07662..f4bd4cd8ac4a 100644
--- a/drivers/net/ethernet/ibm/emac/core.h
+++ b/drivers/net/ethernet/ibm/emac/core.h
@@ -189,7 +189,6 @@ struct emac_instance {
 	struct mutex			mdio_lock;
 
 	/* Device-tree based phy configuration */
-	struct mii_bus			*mii_bus;
 	struct phy_device		*phy_dev;
 
 	/* ZMII infos if any */
-- 
2.46.0


