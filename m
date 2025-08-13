Return-Path: <netdev+bounces-213499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5986B255C6
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 23:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1AED5A3B72
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 21:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C69030AADC;
	Wed, 13 Aug 2025 21:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fg8UlUn+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556A72F39D4
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 21:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755121398; cv=none; b=eiJql4sgMlcOG7evEAsBnHMKmL+4zl1VmQM8t00OlLjz0Ad3P0cc1WuW/FnjeoikHyYzuzvO4huTtrIKOtgEIYJKsFDBv3kbE+jfKXNFi0noSGWM58YHFEK+Xw8sW32M3h9J5yeQiYyJ7OkfPq8m2BGyz6G5f3n1KUvcaigEjQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755121398; c=relaxed/simple;
	bh=4nF6YZkBDBuuqIb0prT+ADqI4QTj6F3nNMzsZifWjyM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a/iobf3WQcv35PeUVsduXrH0WOiA7YJoYeK9U08EuhlW1JGnJ9GAXhrX00z8y32Mt9mYxC5m6SCDTKolc7/KwgA00rwjhzA8DtknyNCFEjpAmC/enKacZIVL/RcF67DulGbCGkdxRPvk29DB7dLFvL8bGXPMy5ms7YEV2oHpD6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fg8UlUn+; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-55ce521e3f4so250144e87.1
        for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 14:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755121394; x=1755726194; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GKKaoqTfnQjtq7VfRSQ7iCiQa+HTMg8WknmSU7Q3omM=;
        b=Fg8UlUn+fpDjGct+VUpSmluWKXFhX33btyWUe+3pqsTLJ68RLVsUtggpPHaOI0qNkf
         PDby99PQA8Vm1Wjbk0soYRQ/zk8gPMzclmTIFU871C0jzIO1wl+PbBOOPQOAdaxL17CD
         3A09ZfXjHHG59bvZJQWramy0/8IlrLw8SFpJbTJoIKfaix61j2uCM4pio5BRpHSIkxqU
         WswbZqAISvafcay5uFwmoIbyMS3m9h9v+CrhgrOLGTuOFSpQ1PuG3bp/HrHu1HvmDbDq
         F0P80v3bodzlLGb2PvK5ssjv4XIC2Vynt16eyNjlWEZ7AtlWg3jaibf9re8Doq3OcUO9
         BvNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755121394; x=1755726194;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GKKaoqTfnQjtq7VfRSQ7iCiQa+HTMg8WknmSU7Q3omM=;
        b=Nn2J+c25W+PVQrUQIq7gR5Wc6gQ2+TXiZg/DfF1Xtu+N6P8BjnZ7vH2D+SxkmOKwFt
         NCRGG3kE1e3P1qRs3czeDeorZwub63qz/SyDgW+iVopVzU+R/npGeTK+6iY1auAZcbOa
         SVcnOD2V0Yr87gSlg6TYH4byWUcEHQxfhUn+bj4dWth+IG058vT1DbAW1+3eoQ4f23zj
         BeAjCHzXc/pg5hmOdleBM+MgRarP08K7MQcDHo8VgyUIunKiN4U/VziTCK3T69RB9xfF
         4JFfn7nCnKJXPgQUP0FgIq3+pdbe/jcXY7zI7uAYMauZRttxj4PKAhrI3buzrWGm0r7l
         /XMQ==
X-Gm-Message-State: AOJu0Yxdpk6dxMtAvr38rXLhZx7V/9RKD493ig9QL3zFQbL9RaMIcENU
	3KrU4wgMEb/prBPbqaIELDfN3Km1WfpfttLffNsp9VRiqK9OF7+vNR/K6mSvAz6/W6U=
X-Gm-Gg: ASbGncuC5dl7R8/ZSWuiTGJLJGiQ4/IkBnBj2BXcBRpOweJrHtsHdldCyV69YxCKNzk
	z7DmZtbpdbJ+JGUXvMjtePcEgrKSpDuW2ixYOFZSIeGepa7a1U8cQoY01p+PYGnJXoevXkeid2R
	9LbnukC9wwkvSt+Uucz9Y8aRB9mvjfM3TU1kSUsg808T/Tr9Y7SxzFsf49q69MJoOk73YqQgi3q
	wjSeafDzG48lSPrsnXlQe3xkBJDtB6LOo7ZRA184QoSJPeWv4V9Q52sRIRwEw50PLYAaVsKMZd5
	r9AycEVDJ5+bMk+wvyt6uNEQEmiA3rPWH4nxx+8auWzONEiyWc82kV3hfxjMjEbr97VqQo70yrS
	wEm5BQYDNaxq3L1HPaHe+lvjDw4bgFvqBLTttmA==
X-Google-Smtp-Source: AGHT+IFkCV475soIgnLGY49reIailc9CvaFOY+m1D217f/UETtmTmy0DhMhocypASL5E/8MQHGBM3w==
X-Received: by 2002:a05:6512:138c:b0:55c:d6e0:c1a2 with SMTP id 2adb3069b0e04-55ce5086a6fmr267081e87.42.1755121394248;
        Wed, 13 Aug 2025 14:43:14 -0700 (PDT)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b95a105d4sm4732918e87.160.2025.08.13.14.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 14:43:13 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 13 Aug 2025 23:43:05 +0200
Subject: [PATCH net-next 3/4] net: dsa: ks8995: Delete sysfs register
 access
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-ks8995-to-dsa-v1-3-75c359ede3a5@linaro.org>
References: <20250813-ks8995-to-dsa-v1-0-75c359ede3a5@linaro.org>
In-Reply-To: <20250813-ks8995-to-dsa-v1-0-75c359ede3a5@linaro.org>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.2

There is some sysfs file to read and write registers randomly
in the ks8995 driver.

The contemporary way to achieve the same thing is to implement
regmap abstractions, if needed. Delete this and implement
regmap later if we want to be able to inspect individual registers.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/dsa/ks8995.c | 47 -----------------------------------------------
 1 file changed, 47 deletions(-)

diff --git a/drivers/net/dsa/ks8995.c b/drivers/net/dsa/ks8995.c
index bdee8c62315f336e380313558c66127ff0b701d3..36f6b2d87712eb95194961efe2df2d784d3aa31f 100644
--- a/drivers/net/dsa/ks8995.c
+++ b/drivers/net/dsa/ks8995.c
@@ -288,30 +288,6 @@ static int ks8995_reset(struct ks8995_switch *ks)
 	return ks8995_start(ks);
 }
 
-static ssize_t ks8995_registers_read(struct file *filp, struct kobject *kobj,
-	const struct bin_attribute *bin_attr, char *buf, loff_t off, size_t count)
-{
-	struct device *dev;
-	struct ks8995_switch *ks8995;
-
-	dev = kobj_to_dev(kobj);
-	ks8995 = dev_get_drvdata(dev);
-
-	return ks8995_read(ks8995, buf, off, count);
-}
-
-static ssize_t ks8995_registers_write(struct file *filp, struct kobject *kobj,
-	const struct bin_attribute *bin_attr, char *buf, loff_t off, size_t count)
-{
-	struct device *dev;
-	struct ks8995_switch *ks8995;
-
-	dev = kobj_to_dev(kobj);
-	ks8995 = dev_get_drvdata(dev);
-
-	return ks8995_write(ks8995, buf, off, count);
-}
-
 /* ks8995_get_revision - get chip revision
  * @ks: pointer to switch instance
  *
@@ -395,16 +371,6 @@ static int ks8995_get_revision(struct ks8995_switch *ks)
 	return err;
 }
 
-static const struct bin_attribute ks8995_registers_attr = {
-	.attr = {
-		.name   = "registers",
-		.mode   = 0600,
-	},
-	.size   = KS8995_REGS_SIZE,
-	.read   = ks8995_registers_read,
-	.write  = ks8995_registers_write,
-};
-
 /* ------------------------------------------------------------------------ */
 static int ks8995_probe(struct spi_device *spi)
 {
@@ -462,21 +428,10 @@ static int ks8995_probe(struct spi_device *spi)
 	if (err)
 		return err;
 
-	memcpy(&ks->regs_attr, &ks8995_registers_attr, sizeof(ks->regs_attr));
-	ks->regs_attr.size = ks->chip->regs_size;
-
 	err = ks8995_reset(ks);
 	if (err)
 		return err;
 
-	sysfs_attr_init(&ks->regs_attr.attr);
-	err = sysfs_create_bin_file(&spi->dev.kobj, &ks->regs_attr);
-	if (err) {
-		dev_err(&spi->dev, "unable to create sysfs file, err=%d\n",
-				    err);
-		return err;
-	}
-
 	dev_info(&spi->dev, "%s device found, Chip ID:%x, Revision:%x\n",
 		 ks->chip->name, ks->chip->chip_id, ks->revision_id);
 
@@ -487,8 +442,6 @@ static void ks8995_remove(struct spi_device *spi)
 {
 	struct ks8995_switch *ks = spi_get_drvdata(spi);
 
-	sysfs_remove_bin_file(&spi->dev.kobj, &ks->regs_attr);
-
 	/* assert reset */
 	gpiod_set_value_cansleep(ks->reset_gpio, 1);
 }

-- 
2.50.1


