Return-Path: <netdev+bounces-203284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51060AF11ED
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 12:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53F4C175F0C
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 10:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12621253F38;
	Wed,  2 Jul 2025 10:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="J3d/vSYk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB0A244EA0
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 10:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751452326; cv=none; b=pGx1vIY5iaRevB2fme57yaMgRagaRt88e7CGvQ+Qj7pFW8lZ7VCui6/1sH+U4EN1Jmo5azSlD7GxhLlBn+/6P+4c+YZQFS9xx8PRN6uIJmYp5Jsqnm9/d2XqOGD6DLO6V0KY12DEoPUqO0p+ZlvW2FnSR1d8z38ZNWku1D3YND4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751452326; c=relaxed/simple;
	bh=ZIPepwL1zAjT3/W18tkz2vKEYlRwn57a6PC+KSBfoZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ahtoM5t1edtbyFbB386M1sGfH7xxPEiW7H4FAKz1drsS+PC2OED73wa1Rdk2jcY/OUmmMJ5Px6MAoaLk/5Z+jDRVYWVazNLTxJggN4FRlOD23HpYSKYyYbB8MNBEIKO80GmP4EYXoc95ZggSuv/3ccBy4OW+82MQkwOK09Sk2xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=J3d/vSYk; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a6e8b1fa37so3682793f8f.2
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 03:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1751452322; x=1752057122; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zXDzDU4TR6t6LCGPz2CtkRVWsYIWYd3/8o1AXqP8JIQ=;
        b=J3d/vSYk8opocU0piDvqaKzjBrnanMQ1d0D5zxbXmNs04jPctePD1aatvNvRd6O4zI
         VoZWvUe2VeYJ3UtEyo99293Di9gZX16zX3VZRD6FVxPCA2nzl2MU4K8vU4GdbdiLbPXi
         wTG165FZqZkQhkZhuPMKoGbYrmwmFcujddWf0maC00rn6B3npN/9VT+xU0icuZbFm74w
         1SS2cfvo0h6sSqyJJgENf8ORLRL1HK8MWdri5Tza1zUjF5UyaO/WEKys+Zq89GFu0iWT
         Mvrtr3/QdBb1YA4x2pLZURJuvIMeKDH+h7rd++X6Da7FANh5KxhvNvP5B7L97eNfnAoP
         53Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751452322; x=1752057122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zXDzDU4TR6t6LCGPz2CtkRVWsYIWYd3/8o1AXqP8JIQ=;
        b=bHIKtlt81AzPeyulXoLj2NxNIETqobM01+j6/1zXj+6zJx/vkaHSt8qEBJkJEI8ICZ
         6POBw6IWo4vv0zIgkOf52hGioj2mV896k1cXqMVglTRa1BZ/zRsuMEbewxBPKy0msIJL
         QR8MdYaaDU/7GHKGwVVfCWfGn/eSvHATx15TiWMTegMZtpu7ZTY6Me7x+u9VJXOunMQ9
         o/79MRKPlZqy1BV8jQqJQfztU8fTI/ZrbF2NO0Mk7AVJ2Tc1Mi5KO9G+BZpHFtPXH0HG
         0bYUdLlyye7jVL83YK8Ki2eNh92fvFIhgWIaCo+9yaBooMcniL9gWMgDOpPTSEA/+kt+
         nRGw==
X-Gm-Message-State: AOJu0YxcdHZ8UUmZ7jQ8UPr5gMnr+Dd6OC7dLFDTdEm/ez9dKZ3Ig1t7
	LCz6FuzTDG45NL4V0FTB7nCNQKTbtCf3EcBV4WOBaq2YRjg7m1X1eUn4tj8UXWAwdV0=
X-Gm-Gg: ASbGnctXq7m/lSWoC/3lPNMzgI66qrXXvn2CpIjuMCjOYesIeD2W+W6Db22uUyw2zsB
	E01CDsxC4sGWvcOn1GxfMdiIT2zwC9CBFB09QBoHypJlhEtbbf5mwSkNxexai6+5ZwxmkWCyS0J
	ZkwUnM0jSWPL4quoY++G01yisUiH6eH4H+/hu6FroA43fGjOVFiUTxnCxtwjfw92KcKk7tWxAl4
	E+JF9bxXhQPrsU4+xofMseIbJU/Etn9BREy+clJr0Q9EtLXdvDm6Ixt+7s/Rodv/BUxIYiWbINk
	v+Ix4x3sn8nOxq3PIiIw6Iukfir/WWFbIZGvVZLM19MsI3K1+0gv1LgqqwpFE6GO3DTBJyCw8iu
	FLX5R
X-Google-Smtp-Source: AGHT+IGsTcnn79M2AkJYx6VwIu5Aao26W0bXZaJfZo1nGUhdH+xTH9BKoW+BRHywWzGq0ruyEcPoQw==
X-Received: by 2002:adf:e196:0:b0:3a8:38b3:6e32 with SMTP id ffacd0b85a97d-3b1fdf02726mr1536066f8f.8.1751452322382;
        Wed, 02 Jul 2025 03:32:02 -0700 (PDT)
Received: from jiri-mlt ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a3fe28dsm195088325e9.20.2025.07.02.03.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 03:32:02 -0700 (PDT)
Date: Wed, 2 Jul 2025 12:31:52 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Prathosh Satish <Prathosh.Satish@microchip.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Shannon Nelson <shannon.nelson@amd.com>, Dave Jiang <dave.jiang@intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>, 
	Petr Oros <poros@redhat.com>
Subject: Re: [PATCH net-next v12 07/14] dpll: zl3073x: Add clock_id field
Message-ID: <amsh2xeltgadepx22kvcq4cfyhb3psnxafqhr33ra6nznswsaq@hfq6yrb4zvo7>
References: <20250629191049.64398-1-ivecera@redhat.com>
 <20250629191049.64398-8-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250629191049.64398-8-ivecera@redhat.com>

Sun, Jun 29, 2025 at 09:10:42PM +0200, ivecera@redhat.com wrote:
>Add .clock_id to zl3073x_dev structure that will be used by later
>commits introducing DPLL feature. The clock ID is required for DPLL
>device registration.
>
>To generate this ID, use chip ID read during device initialization.
>In case where multiple zl3073x based chips are present, the chip ID
>is shifted and lower bits are filled by an unique value - using
>the I2C device address for I2C connections and the chip-select value
>for SPI connections.

You say that multiple chips may have the same chip ID? How is that
possible? Isn't it supposed to be unique?
I understand clock ID to be invariant regardless where you plug your
device. When you construct it from i2c address, sounds wrong.


>
>Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>---
> drivers/dpll/zl3073x/core.c | 6 +++++-
> drivers/dpll/zl3073x/core.h | 4 +++-
> drivers/dpll/zl3073x/i2c.c  | 4 +++-
> drivers/dpll/zl3073x/spi.c  | 4 +++-
> 4 files changed, 14 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
>index b99dd81077d56..94c78a36d9158 100644
>--- a/drivers/dpll/zl3073x/core.c
>+++ b/drivers/dpll/zl3073x/core.c
>@@ -743,13 +743,14 @@ static void zl3073x_devlink_unregister(void *ptr)
>  * zl3073x_dev_probe - initialize zl3073x device
>  * @zldev: pointer to zl3073x device
>  * @chip_info: chip info based on compatible
>+ * @dev_id: device ID to be used as part of clock ID
>  *
>  * Common initialization of zl3073x device structure.
>  *
>  * Returns: 0 on success, <0 on error
>  */
> int zl3073x_dev_probe(struct zl3073x_dev *zldev,
>-		      const struct zl3073x_chip_info *chip_info)
>+		      const struct zl3073x_chip_info *chip_info, u8 dev_id)
> {
> 	u16 id, revision, fw_ver;
> 	struct devlink *devlink;
>@@ -793,6 +794,9 @@ int zl3073x_dev_probe(struct zl3073x_dev *zldev,
> 		FIELD_GET(GENMASK(15, 8), cfg_ver),
> 		FIELD_GET(GENMASK(7, 0), cfg_ver));
> 
>+	/* Use chip ID and given dev ID as clock ID */
>+	zldev->clock_id = ((u64)id << 8) | dev_id;
>+
> 	/* Initialize mutex for operations where multiple reads, writes
> 	 * and/or polls are required to be done atomically.
> 	 */
>diff --git a/drivers/dpll/zl3073x/core.h b/drivers/dpll/zl3073x/core.h
>index 2c831f1a4a5d1..1df2dc194980d 100644
>--- a/drivers/dpll/zl3073x/core.h
>+++ b/drivers/dpll/zl3073x/core.h
>@@ -57,6 +57,7 @@ struct zl3073x_synth {
>  * @dev: pointer to device
>  * @regmap: regmap to access device registers
>  * @multiop_lock: to serialize multiple register operations
>+ * @clock_id: clock id of the device
>  * @ref: array of input references' invariants
>  * @out: array of outs' invariants
>  * @synth: array of synths' invariants
>@@ -65,6 +66,7 @@ struct zl3073x_dev {
> 	struct device		*dev;
> 	struct regmap		*regmap;
> 	struct mutex		multiop_lock;
>+	u64			clock_id;
> 
> 	/* Invariants */
> 	struct zl3073x_ref	ref[ZL3073X_NUM_REFS];
>@@ -87,7 +89,7 @@ extern const struct regmap_config zl3073x_regmap_config;
> 
> struct zl3073x_dev *zl3073x_devm_alloc(struct device *dev);
> int zl3073x_dev_probe(struct zl3073x_dev *zldev,
>-		      const struct zl3073x_chip_info *chip_info);
>+		      const struct zl3073x_chip_info *chip_info, u8 dev_id);
> 
> /**********************
>  * Registers operations
>diff --git a/drivers/dpll/zl3073x/i2c.c b/drivers/dpll/zl3073x/i2c.c
>index 7bbfdd4ed8671..13942ee43b9e5 100644
>--- a/drivers/dpll/zl3073x/i2c.c
>+++ b/drivers/dpll/zl3073x/i2c.c
>@@ -22,7 +22,9 @@ static int zl3073x_i2c_probe(struct i2c_client *client)
> 		return dev_err_probe(dev, PTR_ERR(zldev->regmap),
> 				     "Failed to initialize regmap\n");
> 
>-	return zl3073x_dev_probe(zldev, i2c_get_match_data(client));
>+	/* Initialize device and use I2C address as dev ID */
>+	return zl3073x_dev_probe(zldev, i2c_get_match_data(client),
>+				 client->addr);
> }
> 
> static const struct i2c_device_id zl3073x_i2c_id[] = {
>diff --git a/drivers/dpll/zl3073x/spi.c b/drivers/dpll/zl3073x/spi.c
>index af901b4d6dda0..670b44a7b270f 100644
>--- a/drivers/dpll/zl3073x/spi.c
>+++ b/drivers/dpll/zl3073x/spi.c
>@@ -22,7 +22,9 @@ static int zl3073x_spi_probe(struct spi_device *spi)
> 		return dev_err_probe(dev, PTR_ERR(zldev->regmap),
> 				     "Failed to initialize regmap\n");
> 
>-	return zl3073x_dev_probe(zldev, spi_get_device_match_data(spi));
>+	/* Initialize device and use SPI chip select value as dev ID */
>+	return zl3073x_dev_probe(zldev, spi_get_device_match_data(spi),
>+				 spi_get_chipselect(spi, 0));
> }
> 
> static const struct spi_device_id zl3073x_spi_id[] = {
>-- 
>2.49.0
>

