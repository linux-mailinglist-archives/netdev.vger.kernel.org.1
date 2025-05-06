Return-Path: <netdev+bounces-188468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 559A5AACE9F
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 22:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3EFF4E87B0
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 20:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD251DB92E;
	Tue,  6 May 2025 20:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WziRD3kL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB14C154C15;
	Tue,  6 May 2025 20:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746561955; cv=none; b=Syk/EaIow7bIV5PD+wzRBVQM2HiHyWlL6PZGODA1iM6SRhkefg0wM0MsIdAUimtiQDJ5NDk4jaePRJdOgoQ9ay0KheY/54/XUAfJuUfoLavVjICFAVhoh7MQnC0qkUx8xgOu4UPh3OBM5I9esgkBCLdxqtvYVeiulo/1OERkZaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746561955; c=relaxed/simple;
	bh=Vc8goCosyNTcloDeAlaa5IUKWdgUtjK4FNq95DhtKsA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=T5tpAOL3jHmgFYG3/ckzEFDr1k7ypwY87A+DJ5H5brtP96jcS2RH/blUzxd4CPrcJ7voh4575OicI0OSuD/Q25NG5zwSGSy+ERvyAp8o7z3DFjOWhJDnxNGcCQclwQIbEKz+CI6wT8Vi37MgtTL23a4Kh30/pAxt6Msot2SqfsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WziRD3kL; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a0ac853894so1021961f8f.3;
        Tue, 06 May 2025 13:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746561952; x=1747166752; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aMWYiIi78gnim735+ByvoA9LRygUh+Thcf80rOQyKzA=;
        b=WziRD3kLZbkbgb48G433dzGC2XKGdzl7FilA9GfTT9GSkq7NotEAxMeeMSy5U7nINQ
         axYpx9Uxb1F52J7o0hyC9VsPYurJWy1FJV3wKp4xdJq9rD6qlL0YIMOPwgrsem6xP5It
         F7csJw5BUUX+MnA2eBKuVf058QuZXFuKSNEJL4uiYVNw0B6q8NgSeLJuYxqf1x62sVl6
         Vv/3rgxsslG/hbjR/emWqgbeDfSh8ZrqQ21bZo4z9e1Qs3kDPfExPH1krypkcbEGA5eH
         vpgBBac6ihmoabFftUjQEWxI/c2sfSQCOUlTtcVHU3/LInV+gdn2jmFVCk6R7ge2rLSo
         8w/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746561952; x=1747166752;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aMWYiIi78gnim735+ByvoA9LRygUh+Thcf80rOQyKzA=;
        b=A4nW8KdtyOyoh4ba5yVVBSVPjsrtXBElSUim/tHF+1o+CGmxqDaRTFBP1PZqujhFwh
         /R3MrTkeMMMFO15Vyosw3Ir2g6WEqcMVfkKQTI+sG7fds5xc9rrIUXwqFWEkYdd5kuZp
         kqrIX+tIYl9jSNcx2B1yTaYR2vWKd28dWT2k0suZ4Ha/U+8f+ZTPKBAP3bypjw1XnRlR
         xgO/E9aPIxXbh7soRAT4i/x8xPCbwhZ9dwFBoVa9JIQGVqnUqmaEIKOnQ9+LuTZg5CHd
         O1L+3z/LatClQvSXQYei56XwlI3/DZMB/dD+PUrmkVwImkJuPkyqZkW2ZLqG8CbGiwXX
         zKEw==
X-Forwarded-Encrypted: i=1; AJvYcCU6TgJU7i5CsNN95STKb8hY2dsRwstzicRcqIER/CvT7gxiJJaQh9UPD/TWxyPqIpEPF5Zw1WlkO4gLdzg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVK9bV1LY3VfEFob+RmjLYcig7VB25ZxJP9a0MQ1e4gWSFN/XH
	bayL6n6jVvUUdyOIvS5KymcP8Tm8lFWNk+VF0nASwVazRHwZdR43
X-Gm-Gg: ASbGnct4fOJHKp/X0NOwMW0i26SCiXpaK5A3EbVwk7pvacihu2Ioh0Wij1+aQR0dbfT
	YAuBA0AH5UGnFLT86eIGK404C85HcZGDITHXEM0vZpQM3Jt+WMuFqkw629JTuIyfF08/tEziOjH
	TQC/nsgPpQJqv/lAbUS8KMblqSAzMukWYB6XkmXIux9aXcOci5G6+q4+z9nEngPloO8eNpdb3Lu
	0tKfrCsyoc4ejj5PT478ilDxu329jhtUh6TAv0YsHEpo9LSac7Qere4WchhNtUtc3WTYyqaD2wE
	uoW3XZN7116mpxG3fgpA+u8Fb52ixdgXqzhD68heNDG+eFSU1wq5uNn+PvtBKSYFHruDv1E6TOY
	rtS4SQleq/WLb4R8UimD+RuThCiz1SExE0pDFXEIRp53+0q2IcPTYyrjKL+jmFH1RMjDUeXqQa/
	xTB5jPsOWel3TCDQo=
X-Google-Smtp-Source: AGHT+IFGoJtOSvtk/zScm3E4pvgJKafv0H7boTtd59hCg9N1ZWMmOE0Ej5hIL3zlayAywGQl/9Y1Jw==
X-Received: by 2002:a05:6000:2dc3:b0:3a0:836e:4a26 with SMTP id ffacd0b85a97d-3a0b49f197dmr558854f8f.37.1746561951885;
        Tue, 06 May 2025 13:05:51 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f1e:3100:7d71:fe93:a7b8:4520? (p200300ea8f1e31007d71fe93a7b84520.dip0.t-ipconnect.de. [2003:ea:8f1e:3100:7d71:fe93:a7b8:4520])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a0b348419dsm1302229f8f.23.2025.05.06.13.05.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 13:05:51 -0700 (PDT)
Message-ID: <c5452c26-f947-4b0c-928d-13ba8d133a43@gmail.com>
Date: Tue, 6 May 2025 22:06:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Sander Vanheule <sander@svanheule.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] regmap: remove MDIO support
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

MDIO regmap support was added with 1f89d2fe1607 as only patch from a
series. The rest of the series wasn't applied. Therefore MDIO regmap
has never had a user.

Link: https://lore.kernel.org/all/cover.1621279162.git.sander@svanheule.net/
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/base/regmap/Kconfig       |   6 +-
 drivers/base/regmap/Makefile      |   1 -
 drivers/base/regmap/regmap-mdio.c | 121 ------------------------------
 include/linux/regmap.h            |  44 -----------
 4 files changed, 1 insertion(+), 171 deletions(-)
 delete mode 100644 drivers/base/regmap/regmap-mdio.c

diff --git a/drivers/base/regmap/Kconfig b/drivers/base/regmap/Kconfig
index b1affac70..8ae3271cb 100644
--- a/drivers/base/regmap/Kconfig
+++ b/drivers/base/regmap/Kconfig
@@ -5,9 +5,8 @@
 
 config REGMAP
 	bool
-	default y if (REGMAP_I2C || REGMAP_SPI || REGMAP_SPMI || REGMAP_W1 || REGMAP_AC97 || REGMAP_MMIO || REGMAP_IRQ || REGMAP_SOUNDWIRE || REGMAP_SOUNDWIRE_MBQ || REGMAP_SCCB || REGMAP_I3C || REGMAP_SPI_AVMM || REGMAP_MDIO || REGMAP_FSI)
+	default y if (REGMAP_I2C || REGMAP_SPI || REGMAP_SPMI || REGMAP_W1 || REGMAP_AC97 || REGMAP_MMIO || REGMAP_IRQ || REGMAP_SOUNDWIRE || REGMAP_SOUNDWIRE_MBQ || REGMAP_SCCB || REGMAP_I3C || REGMAP_SPI_AVMM || REGMAP_FSI)
 	select IRQ_DOMAIN if REGMAP_IRQ
-	select MDIO_BUS if REGMAP_MDIO
 	help
 	  Enable support for the Register Map (regmap) access API.
 
@@ -56,9 +55,6 @@ config REGMAP_W1
 	tristate
 	depends on W1
 
-config REGMAP_MDIO
-	tristate
-
 config REGMAP_MMIO
 	tristate
 
diff --git a/drivers/base/regmap/Makefile b/drivers/base/regmap/Makefile
index 5fdd0845b..f47d5a2a7 100644
--- a/drivers/base/regmap/Makefile
+++ b/drivers/base/regmap/Makefile
@@ -20,5 +20,4 @@ obj-$(CONFIG_REGMAP_SOUNDWIRE_MBQ) += regmap-sdw-mbq.o
 obj-$(CONFIG_REGMAP_SCCB) += regmap-sccb.o
 obj-$(CONFIG_REGMAP_I3C) += regmap-i3c.o
 obj-$(CONFIG_REGMAP_SPI_AVMM) += regmap-spi-avmm.o
-obj-$(CONFIG_REGMAP_MDIO) += regmap-mdio.o
 obj-$(CONFIG_REGMAP_FSI) += regmap-fsi.o
diff --git a/drivers/base/regmap/regmap-mdio.c b/drivers/base/regmap/regmap-mdio.c
deleted file mode 100644
index 9573bf3b5..000000000
--- a/drivers/base/regmap/regmap-mdio.c
+++ /dev/null
@@ -1,121 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <linux/errno.h>
-#include <linux/mdio.h>
-#include <linux/module.h>
-#include <linux/regmap.h>
-
-#define REGVAL_MASK		GENMASK(15, 0)
-#define REGNUM_C22_MASK		GENMASK(4, 0)
-/* Clause-45 mask includes the device type (5 bit) and actual register number (16 bit) */
-#define REGNUM_C45_MASK		GENMASK(20, 0)
-
-static int regmap_mdio_c22_read(void *context, unsigned int reg, unsigned int *val)
-{
-	struct mdio_device *mdio_dev = context;
-	int ret;
-
-	if (unlikely(reg & ~REGNUM_C22_MASK))
-		return -ENXIO;
-
-	ret = mdiodev_read(mdio_dev, reg);
-	if (ret < 0)
-		return ret;
-
-	*val = ret & REGVAL_MASK;
-
-	return 0;
-}
-
-static int regmap_mdio_c22_write(void *context, unsigned int reg, unsigned int val)
-{
-	struct mdio_device *mdio_dev = context;
-
-	if (unlikely(reg & ~REGNUM_C22_MASK))
-		return -ENXIO;
-
-	return mdiodev_write(mdio_dev, reg, val);
-}
-
-static const struct regmap_bus regmap_mdio_c22_bus = {
-	.reg_write = regmap_mdio_c22_write,
-	.reg_read = regmap_mdio_c22_read,
-};
-
-static int regmap_mdio_c45_read(void *context, unsigned int reg, unsigned int *val)
-{
-	struct mdio_device *mdio_dev = context;
-	unsigned int devad;
-	int ret;
-
-	if (unlikely(reg & ~REGNUM_C45_MASK))
-		return -ENXIO;
-
-	devad = reg >> REGMAP_MDIO_C45_DEVAD_SHIFT;
-	reg = reg & REGMAP_MDIO_C45_REGNUM_MASK;
-
-	ret = mdiodev_c45_read(mdio_dev, devad, reg);
-	if (ret < 0)
-		return ret;
-
-	*val = ret & REGVAL_MASK;
-
-	return 0;
-}
-
-static int regmap_mdio_c45_write(void *context, unsigned int reg, unsigned int val)
-{
-	struct mdio_device *mdio_dev = context;
-	unsigned int devad;
-
-	if (unlikely(reg & ~REGNUM_C45_MASK))
-		return -ENXIO;
-
-	devad = reg >> REGMAP_MDIO_C45_DEVAD_SHIFT;
-	reg = reg & REGMAP_MDIO_C45_REGNUM_MASK;
-
-	return mdiodev_c45_write(mdio_dev, devad, reg, val);
-}
-
-static const struct regmap_bus regmap_mdio_c45_bus = {
-	.reg_write = regmap_mdio_c45_write,
-	.reg_read = regmap_mdio_c45_read,
-};
-
-struct regmap *__regmap_init_mdio(struct mdio_device *mdio_dev,
-	const struct regmap_config *config, struct lock_class_key *lock_key,
-	const char *lock_name)
-{
-	const struct regmap_bus *bus;
-
-	if (config->reg_bits == 5 && config->val_bits == 16)
-		bus = &regmap_mdio_c22_bus;
-	else if (config->reg_bits == 21 && config->val_bits == 16)
-		bus = &regmap_mdio_c45_bus;
-	else
-		return ERR_PTR(-EOPNOTSUPP);
-
-	return __regmap_init(&mdio_dev->dev, bus, mdio_dev, config, lock_key, lock_name);
-}
-EXPORT_SYMBOL_GPL(__regmap_init_mdio);
-
-struct regmap *__devm_regmap_init_mdio(struct mdio_device *mdio_dev,
-	const struct regmap_config *config, struct lock_class_key *lock_key,
-	const char *lock_name)
-{
-	const struct regmap_bus *bus;
-
-	if (config->reg_bits == 5 && config->val_bits == 16)
-		bus = &regmap_mdio_c22_bus;
-	else if (config->reg_bits == 21 && config->val_bits == 16)
-		bus = &regmap_mdio_c45_bus;
-	else
-		return ERR_PTR(-EOPNOTSUPP);
-
-	return __devm_regmap_init(&mdio_dev->dev, bus, mdio_dev, config, lock_key, lock_name);
-}
-EXPORT_SYMBOL_GPL(__devm_regmap_init_mdio);
-
-MODULE_AUTHOR("Sander Vanheule <sander@svanheule.net>");
-MODULE_DESCRIPTION("regmap MDIO Module");
-MODULE_LICENSE("GPL v2");
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index d17c5ea3d..c1058499e 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -28,7 +28,6 @@ struct fsi_device;
 struct i2c_client;
 struct i3c_device;
 struct irq_domain;
-struct mdio_device;
 struct slim_device;
 struct spi_device;
 struct spmi_device;
@@ -38,14 +37,6 @@ struct regmap_field;
 struct snd_ac97;
 struct sdw_slave;
 
-/*
- * regmap_mdio address encoding. IEEE 802.3ae clause 45 addresses consist of a
- * device address and a register address.
- */
-#define REGMAP_MDIO_C45_DEVAD_SHIFT	16
-#define REGMAP_MDIO_C45_DEVAD_MASK	GENMASK(20, 16)
-#define REGMAP_MDIO_C45_REGNUM_MASK	GENMASK(15, 0)
-
 /*
  * regmap.reg_shift indicates by how much we must shift registers prior to
  * performing any operation. It's a signed value, positive numbers means
@@ -635,10 +626,6 @@ struct regmap *__regmap_init_i2c(struct i2c_client *i2c,
 				 const struct regmap_config *config,
 				 struct lock_class_key *lock_key,
 				 const char *lock_name);
-struct regmap *__regmap_init_mdio(struct mdio_device *mdio_dev,
-				 const struct regmap_config *config,
-				 struct lock_class_key *lock_key,
-				 const char *lock_name);
 struct regmap *__regmap_init_sccb(struct i2c_client *i2c,
 				  const struct regmap_config *config,
 				  struct lock_class_key *lock_key,
@@ -700,10 +687,6 @@ struct regmap *__devm_regmap_init_i2c(struct i2c_client *i2c,
 				      const struct regmap_config *config,
 				      struct lock_class_key *lock_key,
 				      const char *lock_name);
-struct regmap *__devm_regmap_init_mdio(struct mdio_device *mdio_dev,
-				      const struct regmap_config *config,
-				      struct lock_class_key *lock_key,
-				      const char *lock_name);
 struct regmap *__devm_regmap_init_sccb(struct i2c_client *i2c,
 				       const struct regmap_config *config,
 				       struct lock_class_key *lock_key,
@@ -813,19 +796,6 @@ int regmap_attach_dev(struct device *dev, struct regmap *map,
 	__regmap_lockdep_wrapper(__regmap_init_i2c, #config,		\
 				i2c, config)
 
-/**
- * regmap_init_mdio() - Initialise register map
- *
- * @mdio_dev: Device that will be interacted with
- * @config: Configuration for register map
- *
- * The return value will be an ERR_PTR() on error or a valid pointer to
- * a struct regmap.
- */
-#define regmap_init_mdio(mdio_dev, config)				\
-	__regmap_lockdep_wrapper(__regmap_init_mdio, #config,		\
-				mdio_dev, config)
-
 /**
  * regmap_init_sccb() - Initialise register map
  *
@@ -1045,20 +1015,6 @@ bool regmap_ac97_default_volatile(struct device *dev, unsigned int reg);
 	__regmap_lockdep_wrapper(__devm_regmap_init_i2c, #config,	\
 				i2c, config)
 
-/**
- * devm_regmap_init_mdio() - Initialise managed register map
- *
- * @mdio_dev: Device that will be interacted with
- * @config: Configuration for register map
- *
- * The return value will be an ERR_PTR() on error or a valid pointer
- * to a struct regmap.  The regmap will be automatically freed by the
- * device management code.
- */
-#define devm_regmap_init_mdio(mdio_dev, config)				\
-	__regmap_lockdep_wrapper(__devm_regmap_init_mdio, #config,	\
-				mdio_dev, config)
-
 /**
  * devm_regmap_init_sccb() - Initialise managed register map
  *
-- 
2.49.0


