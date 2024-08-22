Return-Path: <netdev+bounces-121140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D426E95BF31
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 21:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64F03285369
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 19:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F28F1D0DCF;
	Thu, 22 Aug 2024 19:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9JHh28t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55ED717588;
	Thu, 22 Aug 2024 19:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724356543; cv=none; b=JMtFhKgE1OPR8VLqDinW2jVSTVcRJ1711ocMhHaUUrc1ZiMH+uiMhum6xqZK9UNn7UuMhOdympWZ9B8hjsnh97kSVaE9/j1NjLeHlGjfq2e5FH2K+LxwjfaRuDDwQi1Xt+tVayDf97Exsy4uS+7E8YGQM+QZ/u9RBwZ30aQu2VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724356543; c=relaxed/simple;
	bh=pSfdLikYFFhh6s/EwQ1xbTLt/0Vve2xGqQsUIjLrnxs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=K0WWhps+9iteOyUcEn0iZN9KpPvpWID54D5Ed1BfAGJotaOQPnt57OT8jtnZzxY5DxF6VbzlF/BpoL/igEB2aGX3POvU5jtFQJwSGMwRkeZOtpBQElqPC+3TgRa+jOWsfNYLsXTDAi3F+QoII/ABMqOKobH1n9u7wJXgqY1+ALQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9JHh28t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28805C32782;
	Thu, 22 Aug 2024 19:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724356542;
	bh=pSfdLikYFFhh6s/EwQ1xbTLt/0Vve2xGqQsUIjLrnxs=;
	h=From:Date:Subject:To:Cc:From;
	b=W9JHh28t0uOMfhpqE+LrzAA7MZm7yXvT+vdxdSwAOeMpBLV+0lK6+pywQUPcOS5e5
	 s/qv/7+tRZShMXHPSflE1Dfy3fSH3hJf+187iey9YKmkQFgwNWt9X9h2L+jl8hIXgl
	 EnME7wYuePbwlqWnQ7O/CzSPzsBYTKo9qL2zI6uKIWq/H6/JquudiCrRpx5/znQCpg
	 BKHnQL/iGppIfgWBBEs0e2RAY4ocWfgyrs9suLs+UBn3QKFQ2HgldhQ/eXXdFwHGOd
	 K82jfzD2wPb+X62JoM98+/MijhICT+qERp7Xg+T+sT/3RG1M5LibfZbov/us7tgDvO
	 hk2+h6C97oimg==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 22 Aug 2024 20:53:04 +0100
Subject: [PATCH] net: dsa: microchip: Use standard regmap locking
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240822-net-dsa-microchip-regmap-locking-v1-1-d557073b883c@kernel.org>
X-B4-Tracking: v=1; b=H4sIAB+Xx2YC/x3NQQrCMBBG4auUWTvQxILGq4iLkPxNB20SJiJC6
 d0buvw2723UoIJGj2EjxU+alNxhLgOFxecElthNdrTTeLeWM74cm+dVgpawSGVFWn3lTwlvyYk
 dbi66q5lgZuqZqpjlfy6er30/ALAjb2ZyAAAA
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=5095; i=broonie@kernel.org;
 h=from:subject:message-id; bh=pSfdLikYFFhh6s/EwQ1xbTLt/0Vve2xGqQsUIjLrnxs=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmx5ez7kSzbLyNUTstFv5jVd8bR+9qkbHhFw0UB
 zxEAhiQBauJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZseXswAKCRAk1otyXVSH
 0BARB/4nrNnqUCZt7+Dm7TEqnF/rNGXgGSSplnGEG0snm4D6Jef7Iwz8NMskWSRiVvr9vt4Z0jo
 OyIRkSiAMRYj20lS1url5vG/wsE2s+56aqE5zXnDtDv9yJEmH326u47PMelAlGwgUS5pyiTJDuh
 RNojUgiP6e1EEt8hqdd0xKV18KK7dhSbdlbcUWSyPtJ0CvDwHWpQA2heFiC8ADKDkeFlF1ds1/e
 czuVoZ9JpssH7q3YS71PcBaAObuLxy0BPx3Eq/u2+vXqsrtMv2m4TU1Z4YxQVJazVhN45k1TOLU
 z+oAE6sLMIQ6CYB61kWIKFqnBZ5/OETFMhPqHHphfeguz5hX
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

For unclear reasons the ksz drivers use custom regmap locking which is
simply a wrapper around a standard mutex. This mutex is not used outside
of the regmap operations so the result is simply to replicate the standard
mutex based locking provided by the regmap core. Remove the redundant code
and rely on the regmap core instead.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/net/dsa/microchip/ksz8863_smi.c |  7 -------
 drivers/net/dsa/microchip/ksz9477_i2c.c |  1 -
 drivers/net/dsa/microchip/ksz_common.c  |  1 -
 drivers/net/dsa/microchip/ksz_common.h  | 15 ---------------
 drivers/net/dsa/microchip/ksz_spi.c     |  1 -
 5 files changed, 25 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8863_smi.c b/drivers/net/dsa/microchip/ksz8863_smi.c
index 5711a59e2ac9..582e744f7b68 100644
--- a/drivers/net/dsa/microchip/ksz8863_smi.c
+++ b/drivers/net/dsa/microchip/ksz8863_smi.c
@@ -105,8 +105,6 @@ static const struct regmap_config ksz8863_regmap_config[] = {
 		.pad_bits = 24,
 		.val_bits = 8,
 		.cache_type = REGCACHE_NONE,
-		.lock = ksz_regmap_lock,
-		.unlock = ksz_regmap_unlock,
 		.max_register = U8_MAX,
 	},
 	{
@@ -115,8 +113,6 @@ static const struct regmap_config ksz8863_regmap_config[] = {
 		.pad_bits = 24,
 		.val_bits = 16,
 		.cache_type = REGCACHE_NONE,
-		.lock = ksz_regmap_lock,
-		.unlock = ksz_regmap_unlock,
 		.max_register = U8_MAX,
 	},
 	{
@@ -125,8 +121,6 @@ static const struct regmap_config ksz8863_regmap_config[] = {
 		.pad_bits = 24,
 		.val_bits = 32,
 		.cache_type = REGCACHE_NONE,
-		.lock = ksz_regmap_lock,
-		.unlock = ksz_regmap_unlock,
 		.max_register = U8_MAX,
 	}
 };
@@ -150,7 +144,6 @@ static int ksz8863_smi_probe(struct mdio_device *mdiodev)
 
 	for (i = 0; i < __KSZ_NUM_REGMAPS; i++) {
 		rc = ksz8863_regmap_config[i];
-		rc.lock_arg = &dev->regmap_mutex;
 		rc.wr_table = chip->wr_table;
 		rc.rd_table = chip->rd_table;
 		dev->regmap[i] = devm_regmap_init(&mdiodev->dev,
diff --git a/drivers/net/dsa/microchip/ksz9477_i2c.c b/drivers/net/dsa/microchip/ksz9477_i2c.c
index 7d7560f23a73..59deb390e605 100644
--- a/drivers/net/dsa/microchip/ksz9477_i2c.c
+++ b/drivers/net/dsa/microchip/ksz9477_i2c.c
@@ -26,7 +26,6 @@ static int ksz9477_i2c_probe(struct i2c_client *i2c)
 
 	for (i = 0; i < __KSZ_NUM_REGMAPS; i++) {
 		rc = ksz9477_regmap_config[i];
-		rc.lock_arg = &dev->regmap_mutex;
 		dev->regmap[i] = devm_regmap_init_i2c(i2c, &rc);
 		if (IS_ERR(dev->regmap[i])) {
 			return dev_err_probe(&i2c->dev, PTR_ERR(dev->regmap[i]),
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 1491099528be..4a383c87acf8 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -4381,7 +4381,6 @@ int ksz_switch_register(struct ksz_device *dev)
 	}
 
 	mutex_init(&dev->dev_mutex);
-	mutex_init(&dev->regmap_mutex);
 	mutex_init(&dev->alu_mutex);
 	mutex_init(&dev->vlan_mutex);
 
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 5f0a628b9849..b9d4e0e9460d 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -152,7 +152,6 @@ struct ksz_device {
 	const struct ksz_chip_data *info;
 
 	struct mutex dev_mutex;		/* device access */
-	struct mutex regmap_mutex;	/* regmap access */
 	struct mutex alu_mutex;		/* ALU access */
 	struct mutex vlan_mutex;	/* vlan access */
 	const struct ksz_dev_ops *dev_ops;
@@ -600,18 +599,6 @@ static inline int ksz_prmw32(struct ksz_device *dev, int port, int offset,
 			 mask, val);
 }
 
-static inline void ksz_regmap_lock(void *__mtx)
-{
-	struct mutex *mtx = __mtx;
-	mutex_lock(mtx);
-}
-
-static inline void ksz_regmap_unlock(void *__mtx)
-{
-	struct mutex *mtx = __mtx;
-	mutex_unlock(mtx);
-}
-
 static inline bool ksz_is_ksz87xx(struct ksz_device *dev)
 {
 	return dev->chip_id == KSZ8795_CHIP_ID ||
@@ -781,8 +768,6 @@ static inline bool is_lan937x_tx_phy(struct ksz_device *dev, int port)
 		.write_flag_mask =					\
 			KSZ_SPI_OP_FLAG_MASK(KSZ_SPI_OP_WR, swp,	\
 					     regbits, regpad),		\
-		.lock = ksz_regmap_lock,				\
-		.unlock = ksz_regmap_unlock,				\
 		.reg_format_endian = REGMAP_ENDIAN_BIG,			\
 		.val_format_endian = REGMAP_ENDIAN_BIG			\
 	}
diff --git a/drivers/net/dsa/microchip/ksz_spi.c b/drivers/net/dsa/microchip/ksz_spi.c
index 8e8d83213b04..06a9e648df0c 100644
--- a/drivers/net/dsa/microchip/ksz_spi.c
+++ b/drivers/net/dsa/microchip/ksz_spi.c
@@ -65,7 +65,6 @@ static int ksz_spi_probe(struct spi_device *spi)
 
 	for (i = 0; i < __KSZ_NUM_REGMAPS; i++) {
 		rc = regmap_config[i];
-		rc.lock_arg = &dev->regmap_mutex;
 		rc.wr_table = chip->wr_table;
 		rc.rd_table = chip->rd_table;
 		dev->regmap[i] = devm_regmap_init_spi(spi, &rc);

---
base-commit: 7c626ce4bae1ac14f60076d00eafe71af30450ba
change-id: 20240822-net-dsa-microchip-regmap-locking-9e79d9314e1f

Best regards,
-- 
Mark Brown <broonie@kernel.org>


