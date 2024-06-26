Return-Path: <netdev+bounces-107071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 767E5919AE5
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 01:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A80B1C21CFE
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 23:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92339194129;
	Wed, 26 Jun 2024 23:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vap7R0oF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B8D16DECE;
	Wed, 26 Jun 2024 23:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719442964; cv=none; b=ldxowIQ/V/CgiRmpPGTuuJuBiXpYVSwPf2YjJ3Pxt+9ue6UOR2B806NL1g75DOTX5Lfw9i4+QFZyy57iQPwi+W+jWBAvtfVZzuqOdqrKZSf9yoaY7LKPOjSOzkr8gPLRwAu5mQcXVh1F62UCrngiacuynomUxeeLIYR4x7pHbBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719442964; c=relaxed/simple;
	bh=waMaWwVTAEdz9IH+VoWxk/+NAOZB6XqX0ykqavX0vVU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ErMOWbz/4tG6G4xMj45PfTiKoEq9Bcl8uzJG/Y0jXvzv7joB7Oz/H7q8KewsPgNCx95Hn+CQF3Or+HfjmNFrXWskZK5+TQyjX5X+6NGQeRMMRLpJpjFD0AfPZR2B5j4Csda1aIlQbu2xfly4RXBmZq73tef+XkUo9W2PGYGEU+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vap7R0oF; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-36733f09305so486403f8f.3;
        Wed, 26 Jun 2024 16:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719442960; x=1720047760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NAJk1RSD/g2Au/xPPJMCGAYOralse1en4fR7+vO+8cY=;
        b=Vap7R0oF0uyrrWSBLXrmvRaQau3TT2H2+ZuHmwljWPtTwGCkuHHL7N9/chCyGxc7fH
         8W+wwQ2J9C8dmjqJL8DrlDL1J3QijA7fNVpeOgLvCstJwZpTYqjUV3todlID18gFpu8e
         td0cczWnMrY7TYF7Bkelcd4kkn4minxYZWlaXvHt5gV/V9OwUFEiw4OeOrTkHtEJNjgZ
         rMfpZU8hf83mVBsLfnGxemianSNBJ8Q/1vHLPAYFE6dwPkSRqB/fHFRDmrrqs3W+E708
         fxf4xfdV0Sg7Apx3YuBd4sLYykd1il8DJJCLt5s2JPy3k0oiKUSchVzRusXWRas0KEu2
         i9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719442960; x=1720047760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NAJk1RSD/g2Au/xPPJMCGAYOralse1en4fR7+vO+8cY=;
        b=upX+4wHbfqB/GEgyGTwIaw4gfWfjWuhNooD/p9qE3jLeTqIy/uKfHTI20XOfTHR6Tu
         tCj0lJFVRfW1IAUKT2SRasuRNZ82WbFJGsACC9chG6LtZgX7vfZ1xRld0wA5CQMcVaSL
         gV+PRAnMi4uvWeNwQSY8RuHp+w7x6PmmmNKwtu++MWpOLndMYN5WbDHzsnOq5tdAWxPQ
         JMZS3/xiVpqjzdoI1bL3YaS00jscdEYG9ZdBDAN67NMBaXY9jiz9KYmFAoC8O+lEHdSX
         Xj/bhbnHIAlXUP4Uu++KYlnIJd8evPEbmiT3ChqPNNby4t5tkesmkA+5lvjVR2+39PV0
         /X5A==
X-Forwarded-Encrypted: i=1; AJvYcCXVZT2IDCyjh5MzTDkIzRKEO5uI6bJTGiv6HHxIubdK0Vte7VDZ2pvYzWxBp2XzHCfkWgnbrgB6aNY9K1/Vtr6I5Yt9F24afTUI/wY7eQLpBwDc/uZKnfAL9hGyJqYUAp1/X3iy
X-Gm-Message-State: AOJu0YzFhsgteVVpp/PDzn5mErAchOUflpo1/TAZlv0XF19yEc1UTXzh
	WHsTguVI80FPnTbEHD7RuHF/RHwO2lmwfmgi5aBB623mKA5r7eDD
X-Google-Smtp-Source: AGHT+IFx75OukCsnuCm7UDC/2Tya7oWLHIdytfrhU91yOf48bO168ZutamIQE3dBqNjmYvev6I3JjQ==
X-Received: by 2002:a05:6000:18a1:b0:366:ee9b:847 with SMTP id ffacd0b85a97d-366ee9b09a1mr9472510f8f.14.1719442960310;
        Wed, 26 Jun 2024 16:02:40 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3674357c1c8sm114843f8f.9.2024.06.26.16.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 16:02:39 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Christian Marangi <ansuelsmth@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Jiasheng Jiang <jiasheng@iscas.ac.cn>,
	"justinstitt@google.com" <justinstitt@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next RFC PATCH 2/2] net: dsa: qca: qca8k: convert to guard API
Date: Thu, 27 Jun 2024 01:02:32 +0200
Message-ID: <20240626230241.6765-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240626230241.6765-1-ansuelsmth@gmail.com>
References: <20240626230241.6765-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert every entry of mutex_lock/unlock() to guard API.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/dsa/qca/qca8k-8xxx.c   |  99 +++++++----------------
 drivers/net/dsa/qca/qca8k-common.c | 122 ++++++++++++-----------------
 2 files changed, 81 insertions(+), 140 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index b3c27cf538e8..2d9526b696f2 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -6,6 +6,7 @@
  * Copyright (c) 2016 John Crispin <john@phrozen.org>
  */
 
+#include <linux/cleanup.h>
 #include <linux/module.h>
 #include <linux/phy.h>
 #include <linux/netdevice.h>
@@ -321,12 +322,11 @@ static int qca8k_read_eth(struct qca8k_priv *priv, u32 reg, u32 *val, int len)
 	if (!skb)
 		return -ENOMEM;
 
-	mutex_lock(&mgmt_eth_data->mutex);
+	guard(mutex)(&mgmt_eth_data->mutex);
 
 	/* Check if the mgmt_conduit if is operational */
 	if (!priv->mgmt_conduit) {
 		kfree_skb(skb);
-		mutex_unlock(&mgmt_eth_data->mutex);
 		return -EINVAL;
 	}
 
@@ -350,8 +350,6 @@ static int qca8k_read_eth(struct qca8k_priv *priv, u32 reg, u32 *val, int len)
 
 	ack = mgmt_eth_data->ack;
 
-	mutex_unlock(&mgmt_eth_data->mutex);
-
 	if (ret <= 0)
 		return -ETIMEDOUT;
 
@@ -373,12 +371,11 @@ static int qca8k_write_eth(struct qca8k_priv *priv, u32 reg, u32 *val, int len)
 	if (!skb)
 		return -ENOMEM;
 
-	mutex_lock(&mgmt_eth_data->mutex);
+	guard(mutex)(&mgmt_eth_data->mutex);
 
 	/* Check if the mgmt_conduit if is operational */
 	if (!priv->mgmt_conduit) {
 		kfree_skb(skb);
-		mutex_unlock(&mgmt_eth_data->mutex);
 		return -EINVAL;
 	}
 
@@ -398,8 +395,6 @@ static int qca8k_write_eth(struct qca8k_priv *priv, u32 reg, u32 *val, int len)
 
 	ack = mgmt_eth_data->ack;
 
-	mutex_unlock(&mgmt_eth_data->mutex);
-
 	if (ret <= 0)
 		return -ETIMEDOUT;
 
@@ -434,17 +429,13 @@ qca8k_read_mii(struct qca8k_priv *priv, uint32_t reg, uint32_t *val)
 
 	qca8k_split_addr(reg, &r1, &r2, &page);
 
-	mutex_lock_nested(&bus->mdio_lock, MDIO_MUTEX_NESTED);
+	guard(mdio_mutex_nested)(&bus->mdio_lock);
 
 	ret = qca8k_set_page(priv, page);
 	if (ret < 0)
-		goto exit;
-
-	ret = qca8k_mii_read32(bus, 0x10 | r2, r1, val);
+		return ret;
 
-exit:
-	mutex_unlock(&bus->mdio_lock);
-	return ret;
+	return qca8k_mii_read32(bus, 0x10 | r2, r1, val);
 }
 
 static int
@@ -456,17 +447,15 @@ qca8k_write_mii(struct qca8k_priv *priv, uint32_t reg, uint32_t val)
 
 	qca8k_split_addr(reg, &r1, &r2, &page);
 
-	mutex_lock_nested(&bus->mdio_lock, MDIO_MUTEX_NESTED);
+	guard(mdio_mutex_nested)(&bus->mdio_lock);
 
 	ret = qca8k_set_page(priv, page);
 	if (ret < 0)
-		goto exit;
+		return ret;
 
 	qca8k_mii_write32(bus, 0x10 | r2, r1, val);
 
-exit:
-	mutex_unlock(&bus->mdio_lock);
-	return ret;
+	return 0;
 }
 
 static int
@@ -480,24 +469,21 @@ qca8k_regmap_update_bits_mii(struct qca8k_priv *priv, uint32_t reg,
 
 	qca8k_split_addr(reg, &r1, &r2, &page);
 
-	mutex_lock_nested(&bus->mdio_lock, MDIO_MUTEX_NESTED);
+	guard(mdio_mutex_nested)(&bus->mdio_lock);
 
 	ret = qca8k_set_page(priv, page);
 	if (ret < 0)
-		goto exit;
+		return ret;
 
 	ret = qca8k_mii_read32(bus, 0x10 | r2, r1, &val);
 	if (ret < 0)
-		goto exit;
+		return ret;
 
 	val &= ~mask;
 	val |= write_val;
 	qca8k_mii_write32(bus, 0x10 | r2, r1, val);
 
-exit:
-	mutex_unlock(&bus->mdio_lock);
-
-	return ret;
+	return 0;
 }
 
 static int
@@ -673,7 +659,7 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
 	 * We therefore need to lock the MDIO bus onto which the switch is
 	 * connected.
 	 */
-	mutex_lock(&priv->bus->mdio_lock);
+	guard(mutex)(&priv->bus->mdio_lock);
 
 	/* Actually start the request:
 	 * 1. Send mdio master packet
@@ -681,13 +667,11 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
 	 * 3. Get the data if we are reading
 	 * 4. Reset the mdio master (even with error)
 	 */
-	mutex_lock(&mgmt_eth_data->mutex);
+	guard(mutex)(&mgmt_eth_data->mutex);
 
 	/* Check if mgmt_conduit is operational */
 	mgmt_conduit = priv->mgmt_conduit;
 	if (!mgmt_conduit) {
-		mutex_unlock(&mgmt_eth_data->mutex);
-		mutex_unlock(&priv->bus->mdio_lock);
 		ret = -EINVAL;
 		goto err_mgmt_conduit;
 	}
@@ -774,9 +758,6 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
 	wait_for_completion_timeout(&mgmt_eth_data->rw_done,
 				    QCA8K_ETHERNET_TIMEOUT);
 
-	mutex_unlock(&mgmt_eth_data->mutex);
-	mutex_unlock(&priv->bus->mdio_lock);
-
 	return ret;
 
 	/* Error handling before lock */
@@ -830,24 +811,21 @@ qca8k_mdio_write(struct qca8k_priv *priv, int phy, int regnum, u16 data)
 
 	qca8k_split_addr(QCA8K_MDIO_MASTER_CTRL, &r1, &r2, &page);
 
-	mutex_lock_nested(&bus->mdio_lock, MDIO_MUTEX_NESTED);
+	guard(mdio_mutex_nested)(&bus->mdio_lock);
 
 	ret = qca8k_set_page(priv, page);
 	if (ret)
-		goto exit;
+		return ret;
 
 	qca8k_mii_write32(bus, 0x10 | r2, r1, val);
 
 	ret = qca8k_mdio_busy_wait(bus, QCA8K_MDIO_MASTER_CTRL,
 				   QCA8K_MDIO_MASTER_BUSY);
 
-exit:
 	/* even if the busy_wait timeouts try to clear the MASTER_EN */
 	qca8k_mii_write_hi(bus, 0x10 | r2, r1 + 1, 0);
 
-	mutex_unlock(&bus->mdio_lock);
-
-	return ret;
+	return 0;
 }
 
 static int
@@ -867,7 +845,7 @@ qca8k_mdio_read(struct qca8k_priv *priv, int phy, int regnum)
 
 	qca8k_split_addr(QCA8K_MDIO_MASTER_CTRL, &r1, &r2, &page);
 
-	mutex_lock_nested(&bus->mdio_lock, MDIO_MUTEX_NESTED);
+	guard(mdio_mutex_nested)(&bus->mdio_lock);
 
 	ret = qca8k_set_page(priv, page);
 	if (ret)
@@ -886,12 +864,7 @@ qca8k_mdio_read(struct qca8k_priv *priv, int phy, int regnum)
 	/* even if the busy_wait timeouts try to clear the MASTER_EN */
 	qca8k_mii_write_hi(bus, 0x10 | r2, r1 + 1, 0);
 
-	mutex_unlock(&bus->mdio_lock);
-
-	if (ret >= 0)
-		ret = val & QCA8K_MDIO_MASTER_DATA_MASK;
-
-	return ret;
+	return ret >= 0 ? val & QCA8K_MDIO_MASTER_DATA_MASK : ret;
 }
 
 static int
@@ -1698,7 +1671,7 @@ qca8k_get_ethtool_stats_eth(struct dsa_switch *ds, int port, u64 *data)
 
 	mib_eth_data = &priv->mib_eth_data;
 
-	mutex_lock(&mib_eth_data->mutex);
+	guard(mutex)(&mib_eth_data->mutex);
 
 	reinit_completion(&mib_eth_data->rw_done);
 
@@ -1706,25 +1679,16 @@ qca8k_get_ethtool_stats_eth(struct dsa_switch *ds, int port, u64 *data)
 	mib_eth_data->data = data;
 	refcount_set(&mib_eth_data->port_parsed, QCA8K_NUM_PORTS);
 
-	mutex_lock(&priv->reg_mutex);
-
 	/* Send mib autocast request */
-	ret = regmap_update_bits(priv->regmap, QCA8K_REG_MIB,
-				 QCA8K_MIB_FUNC | QCA8K_MIB_BUSY,
-				 FIELD_PREP(QCA8K_MIB_FUNC, QCA8K_MIB_CAST) |
-				 QCA8K_MIB_BUSY);
-
-	mutex_unlock(&priv->reg_mutex);
-
+	scoped_guard(mutex)(&priv->reg_mutex)
+		ret = regmap_update_bits(priv->regmap, QCA8K_REG_MIB,
+					 QCA8K_MIB_FUNC | QCA8K_MIB_BUSY,
+					 FIELD_PREP(QCA8K_MIB_FUNC, QCA8K_MIB_CAST) |
+					 QCA8K_MIB_BUSY);
 	if (ret)
-		goto exit;
-
-	ret = wait_for_completion_timeout(&mib_eth_data->rw_done, QCA8K_ETHERNET_TIMEOUT);
-
-exit:
-	mutex_unlock(&mib_eth_data->mutex);
+		return ret;
 
-	return ret;
+	return wait_for_completion_timeout(&mib_eth_data->rw_done, QCA8K_ETHERNET_TIMEOUT);
 }
 
 static u32 qca8k_get_phy_flags(struct dsa_switch *ds, int port)
@@ -1761,13 +1725,10 @@ qca8k_conduit_change(struct dsa_switch *ds, const struct net_device *conduit,
 	if (dp->index != 0)
 		return;
 
-	mutex_lock(&priv->mgmt_eth_data.mutex);
-	mutex_lock(&priv->mib_eth_data.mutex);
+	guard(mutex)(&priv->mgmt_eth_data.mutex);
+	guard(mutex)(&priv->mib_eth_data.mutex);
 
 	priv->mgmt_conduit = operational ? (struct net_device *)conduit : NULL;
-
-	mutex_unlock(&priv->mib_eth_data.mutex);
-	mutex_unlock(&priv->mgmt_eth_data.mutex);
 }
 
 static int qca8k_connect_tag_protocol(struct dsa_switch *ds,
diff --git a/drivers/net/dsa/qca/qca8k-common.c b/drivers/net/dsa/qca/qca8k-common.c
index 7f80035c5441..e020474de514 100644
--- a/drivers/net/dsa/qca/qca8k-common.c
+++ b/drivers/net/dsa/qca/qca8k-common.c
@@ -6,6 +6,7 @@
  * Copyright (c) 2016 John Crispin <john@phrozen.org>
  */
 
+#include <linux/cleanup.h>
 #include <linux/netdevice.h>
 #include <net/dsa.h>
 #include <linux/if_bridge.h>
@@ -215,10 +216,10 @@ static int qca8k_fdb_add(struct qca8k_priv *priv, const u8 *mac,
 {
 	int ret;
 
-	mutex_lock(&priv->reg_mutex);
+	guard(mutex)(&priv->reg_mutex);
+
 	qca8k_fdb_write(priv, vid, port_mask, mac, aging);
 	ret = qca8k_fdb_access(priv, QCA8K_FDB_LOAD, -1);
-	mutex_unlock(&priv->reg_mutex);
 
 	return ret;
 }
@@ -228,19 +229,19 @@ static int qca8k_fdb_del(struct qca8k_priv *priv, const u8 *mac,
 {
 	int ret;
 
-	mutex_lock(&priv->reg_mutex);
+	guard(mutex)(&priv->reg_mutex);
+
 	qca8k_fdb_write(priv, vid, port_mask, mac, 0);
 	ret = qca8k_fdb_access(priv, QCA8K_FDB_PURGE, -1);
-	mutex_unlock(&priv->reg_mutex);
 
 	return ret;
 }
 
 void qca8k_fdb_flush(struct qca8k_priv *priv)
 {
-	mutex_lock(&priv->reg_mutex);
+	guard(mutex)(&priv->reg_mutex);
+
 	qca8k_fdb_access(priv, QCA8K_FDB_FLUSH, -1);
-	mutex_unlock(&priv->reg_mutex);
 }
 
 static int qca8k_fdb_search_and_insert(struct qca8k_priv *priv, u8 port_mask,
@@ -249,22 +250,22 @@ static int qca8k_fdb_search_and_insert(struct qca8k_priv *priv, u8 port_mask,
 	struct qca8k_fdb fdb = { 0 };
 	int ret;
 
-	mutex_lock(&priv->reg_mutex);
+	guard(mutex)(&priv->reg_mutex);
 
 	qca8k_fdb_write(priv, vid, 0, mac, 0);
 	ret = qca8k_fdb_access(priv, QCA8K_FDB_SEARCH, -1);
 	if (ret < 0)
-		goto exit;
+		return ret;
 
 	ret = qca8k_fdb_read(priv, &fdb);
 	if (ret < 0)
-		goto exit;
+		return ret;
 
 	/* Rule exist. Delete first */
 	if (fdb.aging) {
 		ret = qca8k_fdb_access(priv, QCA8K_FDB_PURGE, -1);
 		if (ret)
-			goto exit;
+			return ret;
 	} else {
 		fdb.aging = aging;
 	}
@@ -273,11 +274,7 @@ static int qca8k_fdb_search_and_insert(struct qca8k_priv *priv, u8 port_mask,
 	fdb.port_mask |= port_mask;
 
 	qca8k_fdb_write(priv, vid, fdb.port_mask, mac, fdb.aging);
-	ret = qca8k_fdb_access(priv, QCA8K_FDB_LOAD, -1);
-
-exit:
-	mutex_unlock(&priv->reg_mutex);
-	return ret;
+	return qca8k_fdb_access(priv, QCA8K_FDB_LOAD, -1);
 }
 
 static int qca8k_fdb_search_and_del(struct qca8k_priv *priv, u8 port_mask,
@@ -286,40 +283,34 @@ static int qca8k_fdb_search_and_del(struct qca8k_priv *priv, u8 port_mask,
 	struct qca8k_fdb fdb = { 0 };
 	int ret;
 
-	mutex_lock(&priv->reg_mutex);
+	guard(mutex)(&priv->reg_mutex);
 
 	qca8k_fdb_write(priv, vid, 0, mac, 0);
 	ret = qca8k_fdb_access(priv, QCA8K_FDB_SEARCH, -1);
 	if (ret < 0)
-		goto exit;
+		return ret;
 
 	ret = qca8k_fdb_read(priv, &fdb);
 	if (ret < 0)
-		goto exit;
+		return ret;
 
 	/* Rule doesn't exist. Why delete? */
-	if (!fdb.aging) {
-		ret = -EINVAL;
-		goto exit;
-	}
+	if (!fdb.aging)
+		return -EINVAL;
 
 	ret = qca8k_fdb_access(priv, QCA8K_FDB_PURGE, -1);
 	if (ret)
-		goto exit;
+		return ret;
 
 	/* Only port in the rule is this port. Don't re insert */
 	if (fdb.port_mask == port_mask)
-		goto exit;
+		return ret;
 
 	/* Remove port from port mask */
 	fdb.port_mask &= ~port_mask;
 
 	qca8k_fdb_write(priv, vid, fdb.port_mask, mac, fdb.aging);
-	ret = qca8k_fdb_access(priv, QCA8K_FDB_LOAD, -1);
-
-exit:
-	mutex_unlock(&priv->reg_mutex);
-	return ret;
+	return qca8k_fdb_access(priv, QCA8K_FDB_LOAD, -1);
 }
 
 static int qca8k_vlan_access(struct qca8k_priv *priv,
@@ -367,14 +358,15 @@ static int qca8k_vlan_add(struct qca8k_priv *priv, u8 port, u16 vid,
 	if (vid == 0)
 		return 0;
 
-	mutex_lock(&priv->reg_mutex);
+	guard(mutex)(&priv->reg_mutex);
+
 	ret = qca8k_vlan_access(priv, QCA8K_VLAN_READ, vid);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	ret = qca8k_read(priv, QCA8K_REG_VTU_FUNC0, &reg);
 	if (ret < 0)
-		goto out;
+		return ret;
 	reg |= QCA8K_VTU_FUNC0_VALID | QCA8K_VTU_FUNC0_IVL_EN;
 	reg &= ~QCA8K_VTU_FUNC0_EG_MODE_PORT_MASK(port);
 	if (untagged)
@@ -384,13 +376,9 @@ static int qca8k_vlan_add(struct qca8k_priv *priv, u8 port, u16 vid,
 
 	ret = qca8k_write(priv, QCA8K_REG_VTU_FUNC0, reg);
 	if (ret)
-		goto out;
-	ret = qca8k_vlan_access(priv, QCA8K_VLAN_LOAD, vid);
-
-out:
-	mutex_unlock(&priv->reg_mutex);
+		return ret;
 
-	return ret;
+	return qca8k_vlan_access(priv, QCA8K_VLAN_LOAD, vid);
 }
 
 static int qca8k_vlan_del(struct qca8k_priv *priv, u8 port, u16 vid)
@@ -399,14 +387,15 @@ static int qca8k_vlan_del(struct qca8k_priv *priv, u8 port, u16 vid)
 	int ret, i;
 	bool del;
 
-	mutex_lock(&priv->reg_mutex);
+	guard(mutex)(&priv->reg_mutex);
+
 	ret = qca8k_vlan_access(priv, QCA8K_VLAN_READ, vid);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	ret = qca8k_read(priv, QCA8K_REG_VTU_FUNC0, &reg);
 	if (ret < 0)
-		goto out;
+		return ret;
 	reg &= ~QCA8K_VTU_FUNC0_EG_MODE_PORT_MASK(port);
 	reg |= QCA8K_VTU_FUNC0_EG_MODE_PORT_NOT(port);
 
@@ -421,46 +410,39 @@ static int qca8k_vlan_del(struct qca8k_priv *priv, u8 port, u16 vid)
 		}
 	}
 
-	if (del) {
-		ret = qca8k_vlan_access(priv, QCA8K_VLAN_PURGE, vid);
-	} else {
-		ret = qca8k_write(priv, QCA8K_REG_VTU_FUNC0, reg);
-		if (ret)
-			goto out;
-		ret = qca8k_vlan_access(priv, QCA8K_VLAN_LOAD, vid);
-	}
+	if (del)
+		return qca8k_vlan_access(priv, QCA8K_VLAN_PURGE, vid);
 
-out:
-	mutex_unlock(&priv->reg_mutex);
 
-	return ret;
+	ret = qca8k_write(priv, QCA8K_REG_VTU_FUNC0, reg);
+	if (ret)
+		return ret;
+
+	return qca8k_vlan_access(priv, QCA8K_VLAN_LOAD, vid);
 }
 
 int qca8k_mib_init(struct qca8k_priv *priv)
 {
 	int ret;
 
-	mutex_lock(&priv->reg_mutex);
+	guard(mutex)(&priv->reg_mutex);
+
 	ret = regmap_update_bits(priv->regmap, QCA8K_REG_MIB,
 				 QCA8K_MIB_FUNC | QCA8K_MIB_BUSY,
 				 FIELD_PREP(QCA8K_MIB_FUNC, QCA8K_MIB_FLUSH) |
 				 QCA8K_MIB_BUSY);
 	if (ret)
-		goto exit;
+		return ret;
 
 	ret = qca8k_busy_wait(priv, QCA8K_REG_MIB, QCA8K_MIB_BUSY);
 	if (ret)
-		goto exit;
+		return ret;
 
 	ret = regmap_set_bits(priv->regmap, QCA8K_REG_MIB, QCA8K_MIB_CPU_KEEP);
 	if (ret)
-		goto exit;
-
-	ret = qca8k_write(priv, QCA8K_REG_MODULE_EN, QCA8K_MODULE_EN_MIB);
+		return ret;
 
-exit:
-	mutex_unlock(&priv->reg_mutex);
-	return ret;
+	return qca8k_write(priv, QCA8K_REG_MODULE_EN, QCA8K_MODULE_EN_MIB);
 }
 
 void qca8k_port_set_status(struct qca8k_priv *priv, int port, int enable)
@@ -541,20 +523,18 @@ int qca8k_set_mac_eee(struct dsa_switch *ds, int port,
 	u32 reg;
 	int ret;
 
-	mutex_lock(&priv->reg_mutex);
+	guard(mutex)(&priv->reg_mutex);
+
 	ret = qca8k_read(priv, QCA8K_REG_EEE_CTRL, &reg);
 	if (ret < 0)
-		goto exit;
+		return ret;
 
 	if (eee->eee_enabled)
 		reg |= lpi_en;
 	else
 		reg &= ~lpi_en;
-	ret = qca8k_write(priv, QCA8K_REG_EEE_CTRL, reg);
 
-exit:
-	mutex_unlock(&priv->reg_mutex);
-	return ret;
+	return qca8k_write(priv, QCA8K_REG_EEE_CTRL, reg);
 }
 
 int qca8k_get_mac_eee(struct dsa_switch *ds, int port,
@@ -708,9 +688,9 @@ void qca8k_port_fast_age(struct dsa_switch *ds, int port)
 {
 	struct qca8k_priv *priv = ds->priv;
 
-	mutex_lock(&priv->reg_mutex);
+	guard(mutex)(&priv->reg_mutex);
+
 	qca8k_fdb_access(priv, QCA8K_FDB_FLUSH_PORT, port);
-	mutex_unlock(&priv->reg_mutex);
 }
 
 int qca8k_set_ageing_time(struct dsa_switch *ds, unsigned int msecs)
@@ -841,7 +821,8 @@ int qca8k_port_fdb_dump(struct dsa_switch *ds, int port,
 	bool is_static;
 	int ret = 0;
 
-	mutex_lock(&priv->reg_mutex);
+	guard(mutex)(&priv->reg_mutex);
+
 	while (cnt-- && !qca8k_fdb_next(priv, &_fdb, port)) {
 		if (!_fdb.aging)
 			break;
@@ -850,7 +831,6 @@ int qca8k_port_fdb_dump(struct dsa_switch *ds, int port,
 		if (ret)
 			break;
 	}
-	mutex_unlock(&priv->reg_mutex);
 
 	return 0;
 }
-- 
2.45.1


