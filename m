Return-Path: <netdev+bounces-62999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4B982AB21
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 10:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E368B2305E
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 09:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10161111A5;
	Thu, 11 Jan 2024 09:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bW7m1RzN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DDF11194
	for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 09:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40e549adb7dso24170425e9.2
        for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 01:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704966111; x=1705570911; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OjJJwhrUU78cTcBoh5uKmR3KsNd0G61piVNlDfH4Rks=;
        b=bW7m1RzNRMR6nyo78T4F2TYTQQi/3qXuZmSO+quoiJTczjAdNYqUN/CsScuh4//AAo
         JmjgFSJ1lCXhW3z4gVAKF7mK9PLI7ipab4VQ/HKtTjB3nWBlSJELS+ThINGL1HuevUOc
         W8zfqkUpn9lyhqfOVsC0bB8DJ/XvfEI9Uwlcq2EGsFJn4kFCz5tQKb9dAyMod9WZvqtZ
         mjMcnCpl1wX71YXt7rigldBGNPkC+M2nSoFQQVSKqbJKbzjChnn1JfqugEsdFT5X9kke
         a1txaRIMYSdMZ9O9BmSMzWMbT+qhYF5xuwMNMK8e4pSUwfq8miY0+zP45vxrWKPJrocY
         e+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704966111; x=1705570911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OjJJwhrUU78cTcBoh5uKmR3KsNd0G61piVNlDfH4Rks=;
        b=G4JK5JT+L/ZJOIN2otMVNMyX6EYBLA8s/fygM1i7SjtX27MA7HCSXt2fUTrDDWiSHn
         WaeFiauiyrwp6LtQ05A7WBxZ7K+kpFlcFTryEhGGqpc0/I5AmEbKKnXfiDkCDXdPmDTQ
         rObWZ+z3QZRcM307nyTgQO6fdNlGivEi99155pcxgGG6k7Ep7ClwmiAXydbf1klWNPS7
         33GiLbujYp0vBMEo6jrRlxKs546m+62Ts6C9l4zR/r9xafZVhzNhrDTtwYMc3pFHanvu
         ORW7HDzkDej2VInplP0QPDWqlug7P+48TVgXWc5/dtzMjRYVkoASKOGvlOX6T1/gUuo2
         Vqbg==
X-Gm-Message-State: AOJu0YxmUs+2dUGA/pmZ+Ddu+DZHopigozUfVbjg9OPiXkBy0zYpxZDs
	k2TbSY3CY46Waqn4Aa0BMhY=
X-Google-Smtp-Source: AGHT+IGlrdDG/cUw0/8ojNB6NGYZompS4NTkweIIwfIV5talHVMDBcAH7x/oNabs7RsRLYYMfzcyAA==
X-Received: by 2002:a05:600c:6987:b0:40d:877d:ca9 with SMTP id fp7-20020a05600c698700b0040d877d0ca9mr230839wmb.104.1704966111126;
        Thu, 11 Jan 2024 01:41:51 -0800 (PST)
Received: from skbuf ([188.25.255.36])
        by smtp.gmail.com with ESMTPSA id bg23-20020a05600c3c9700b0040d91fa270fsm1226276wmb.36.2024.01.11.01.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 01:41:50 -0800 (PST)
Date: Thu, 11 Jan 2024 11:41:48 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk,
	andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	arinc.unal@arinc9.com
Subject: Re: [PATCH net-next v3 3/8] net: dsa: realtek: common realtek-dsa
 module
Message-ID: <20240111094148.jltccq4r6b42wbgq@skbuf>
References: <20231223005253.17891-1-luizluca@gmail.com>
 <20231223005253.17891-4-luizluca@gmail.com>
 <20240108140002.wpf6zj7qv2ftx476@skbuf>
 <CAJq09z6g+qTbzzaFAy94aV6HuESAeb4aLOUHWdUkOB4+xR_vDg@mail.gmail.com>
 <20240109123658.vqftnqsxyd64ik52@skbuf>
 <CAJq09z6JF0K==fO53RcimoRgujHjEkvmDKWGK3pYQAig58j__g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJq09z6JF0K==fO53RcimoRgujHjEkvmDKWGK3pYQAig58j__g@mail.gmail.com>

On Thu, Jan 11, 2024 at 03:20:10AM -0300, Luiz Angelo Daros de Luca wrote:
> IMHO, the constant regmap_config looks cleaner than a sequence of
> assignments. However, we don't actually need 4 of them.
> As we already have a writable regmap_config in stack (to assign
> lock_arg), we can reuse the same struct and simply set
> disable_locking.
> It makes the regmap ignore all locking fields and we don't even need
> to unset them for map_nolock. Something like this:
> 
> realtek_common_probe(struct device *dev, const struct regmap_config *rc_base)
> {
> 
>        (...)
> 
>        rc = *rc_base;
>        rc.lock_arg = priv;
>        priv->map = devm_regmap_init(dev, NULL, priv, &rc);
>        if (IS_ERR(priv->map)) {
>                ret = PTR_ERR(priv->map);
>                dev_err(dev, "regmap init failed: %d\n", ret);
>                return ERR_PTR(ret);
>        }
> 
>        rc.disable_locking = true;
>        priv->map_nolock = devm_regmap_init(dev, NULL, priv, &rc);
>        if (IS_ERR(priv->map_nolock)) {
>                ret = PTR_ERR(priv->map_nolock);
>                dev_err(dev, "regmap init failed: %d\n", ret);
>                return ERR_PTR(ret);
>        }
> 
> It has a cleaner function signature and we can remove the _nolock
> constants as well.
> 
> The regmap configs still have some room for improvement, like moving
> from interfaces to variants, but this series is already too big. We
> can leave that as it is.

I was thinking something like this, does it look bad?

From 2e462507171ed0fd8393598842dc0f7e6c50d499 Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Thu, 11 Jan 2024 11:38:17 +0200
Subject: [PATCH] realtek_common_info

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/realtek/realtek-common.c | 35 ++++++++++++++++++------
 drivers/net/dsa/realtek/realtek-common.h |  9 ++++--
 drivers/net/dsa/realtek/realtek-mdio.c   | 27 ++----------------
 drivers/net/dsa/realtek/realtek-smi.c    | 35 ++++--------------------
 4 files changed, 41 insertions(+), 65 deletions(-)

diff --git a/drivers/net/dsa/realtek/realtek-common.c b/drivers/net/dsa/realtek/realtek-common.c
index 80b37e5fe780..bd6b04922b6d 100644
--- a/drivers/net/dsa/realtek/realtek-common.c
+++ b/drivers/net/dsa/realtek/realtek-common.c
@@ -22,10 +22,21 @@ void realtek_common_unlock(void *ctx)
 EXPORT_SYMBOL_GPL(realtek_common_unlock);
 
 struct realtek_priv *
-realtek_common_probe(struct device *dev, struct regmap_config rc,
-		     struct regmap_config rc_nolock)
+realtek_common_probe(struct device *dev,
+		     const struct realtek_common_info *info)
 {
 	const struct realtek_variant *var;
+	struct regmap_config rc = {
+		.reg_bits = 10, /* A4..A0 R4..R0 */
+		.val_bits = 16,
+		.reg_stride = 1,
+		/* PHY regs are at 0x8000 */
+		.max_register = 0xffff,
+		.reg_format_endian = REGMAP_ENDIAN_BIG,
+		.reg_read = info->reg_read,
+		.reg_write = info->reg_write,
+		.cache_type = REGCACHE_NONE,
+	};
 	struct realtek_priv *priv;
 	int ret;
 
@@ -40,17 +51,23 @@ realtek_common_probe(struct device *dev, struct regmap_config rc,
 
 	mutex_init(&priv->map_lock);
 
-	rc.lock_arg = priv;
-	priv->map = devm_regmap_init(dev, NULL, priv, &rc);
-	if (IS_ERR(priv->map)) {
-		ret = PTR_ERR(priv->map);
+	/* Initialize the non-locking regmap first */
+	rc.disable_locking = true;
+	priv->map_nolock = devm_regmap_init(dev, NULL, priv, &rc);
+	if (IS_ERR(priv->map_nolock)) {
+		ret = PTR_ERR(priv->map_nolock);
 		dev_err(dev, "regmap init failed: %d\n", ret);
 		return ERR_PTR(ret);
 	}
 
-	priv->map_nolock = devm_regmap_init(dev, NULL, priv, &rc_nolock);
-	if (IS_ERR(priv->map_nolock)) {
-		ret = PTR_ERR(priv->map_nolock);
+	/* Then the locking regmap */
+	rc.disable_locking = false;
+	rc.lock = realtek_common_lock;
+	rc.unlock = realtek_common_unlock;
+	rc.lock_arg = priv;
+	priv->map = devm_regmap_init(dev, NULL, priv, &rc);
+	if (IS_ERR(priv->map)) {
+		ret = PTR_ERR(priv->map);
 		dev_err(dev, "regmap init failed: %d\n", ret);
 		return ERR_PTR(ret);
 	}
diff --git a/drivers/net/dsa/realtek/realtek-common.h b/drivers/net/dsa/realtek/realtek-common.h
index 518d091ff496..71fc43d8d90a 100644
--- a/drivers/net/dsa/realtek/realtek-common.h
+++ b/drivers/net/dsa/realtek/realtek-common.h
@@ -5,11 +5,16 @@
 
 #include <linux/regmap.h>
 
+struct realtek_common_info {
+	int (*reg_read)(void *ctx, u32 reg, u32 *val);
+	int (*reg_write)(void *ctx, u32 reg, u32 val);
+};
+
 void realtek_common_lock(void *ctx);
 void realtek_common_unlock(void *ctx);
 struct realtek_priv *
-realtek_common_probe(struct device *dev, struct regmap_config rc,
-		     struct regmap_config rc_nolock);
+realtek_common_probe(struct device *dev,
+		     const struct realtek_common_info *info);
 int realtek_common_register_switch(struct realtek_priv *priv);
 void realtek_common_remove(struct realtek_priv *priv);
 
diff --git a/drivers/net/dsa/realtek/realtek-mdio.c b/drivers/net/dsa/realtek/realtek-mdio.c
index 1eed09ab3aa1..8725cd1b027b 100644
--- a/drivers/net/dsa/realtek/realtek-mdio.c
+++ b/drivers/net/dsa/realtek/realtek-mdio.c
@@ -101,31 +101,9 @@ static int realtek_mdio_read(void *ctx, u32 reg, u32 *val)
 	return ret;
 }
 
-static const struct regmap_config realtek_mdio_regmap_config = {
-	.reg_bits = 10, /* A4..A0 R4..R0 */
-	.val_bits = 16,
-	.reg_stride = 1,
-	/* PHY regs are at 0x8000 */
-	.max_register = 0xffff,
-	.reg_format_endian = REGMAP_ENDIAN_BIG,
+static const struct realtek_common_info realtek_mdio_info = {
 	.reg_read = realtek_mdio_read,
 	.reg_write = realtek_mdio_write,
-	.cache_type = REGCACHE_NONE,
-	.lock = realtek_common_lock,
-	.unlock = realtek_common_unlock,
-};
-
-static const struct regmap_config realtek_mdio_nolock_regmap_config = {
-	.reg_bits = 10, /* A4..A0 R4..R0 */
-	.val_bits = 16,
-	.reg_stride = 1,
-	/* PHY regs are at 0x8000 */
-	.max_register = 0xffff,
-	.reg_format_endian = REGMAP_ENDIAN_BIG,
-	.reg_read = realtek_mdio_read,
-	.reg_write = realtek_mdio_write,
-	.cache_type = REGCACHE_NONE,
-	.disable_locking = true,
 };
 
 int realtek_mdio_probe(struct mdio_device *mdiodev)
@@ -134,8 +112,7 @@ int realtek_mdio_probe(struct mdio_device *mdiodev)
 	struct realtek_priv *priv;
 	int ret;
 
-	priv = realtek_common_probe(dev, realtek_mdio_regmap_config,
-				    realtek_mdio_nolock_regmap_config);
+	priv = realtek_common_probe(dev, &realtek_mdio_info);
 	if (IS_ERR(priv))
 		return PTR_ERR(priv);
 
diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
index fc54190839cf..7697dc66e5e8 100644
--- a/drivers/net/dsa/realtek/realtek-smi.c
+++ b/drivers/net/dsa/realtek/realtek-smi.c
@@ -312,33 +312,6 @@ static int realtek_smi_read(void *ctx, u32 reg, u32 *val)
 	return realtek_smi_read_reg(priv, reg, val);
 }
 
-static const struct regmap_config realtek_smi_regmap_config = {
-	.reg_bits = 10, /* A4..A0 R4..R0 */
-	.val_bits = 16,
-	.reg_stride = 1,
-	/* PHY regs are at 0x8000 */
-	.max_register = 0xffff,
-	.reg_format_endian = REGMAP_ENDIAN_BIG,
-	.reg_read = realtek_smi_read,
-	.reg_write = realtek_smi_write,
-	.cache_type = REGCACHE_NONE,
-	.lock = realtek_common_lock,
-	.unlock = realtek_common_unlock,
-};
-
-static const struct regmap_config realtek_smi_nolock_regmap_config = {
-	.reg_bits = 10, /* A4..A0 R4..R0 */
-	.val_bits = 16,
-	.reg_stride = 1,
-	/* PHY regs are at 0x8000 */
-	.max_register = 0xffff,
-	.reg_format_endian = REGMAP_ENDIAN_BIG,
-	.reg_read = realtek_smi_read,
-	.reg_write = realtek_smi_write,
-	.cache_type = REGCACHE_NONE,
-	.disable_locking = true,
-};
-
 static int realtek_smi_mdio_read(struct mii_bus *bus, int addr, int regnum)
 {
 	struct realtek_priv *priv = bus->priv;
@@ -396,14 +369,18 @@ static int realtek_smi_setup_mdio(struct dsa_switch *ds)
 	return ret;
 }
 
+static const struct realtek_common_info realtek_smi_info = {
+	.reg_read = realtek_smi_read,
+	.reg_write = realtek_smi_write,
+};
+
 int realtek_smi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct realtek_priv *priv;
 	int ret;
 
-	priv = realtek_common_probe(dev, realtek_smi_regmap_config,
-				    realtek_smi_nolock_regmap_config);
+	priv = realtek_common_probe(dev, &realtek_smi_info);
 	if (IS_ERR(priv))
 		return PTR_ERR(priv);
 
-- 
2.34.1

> This case in particular might be hard to justify in the commit message
> other than "preliminary work". I'll split it as it makes review much
> easier. this series will grow from 7 to 10 patches, even after
> dropping the revert patch.

Preliminary work is fine if you explain a bit in advance why it will be
needed.

