Return-Path: <netdev+bounces-198937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E38ADE626
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 10:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4112B17122A
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 08:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CE527F00B;
	Wed, 18 Jun 2025 08:56:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C318B25B1C5;
	Wed, 18 Jun 2025 08:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750237015; cv=none; b=UwdSE7XY6TkGp5q2+fIwrjGo/HJ+OMytLKeWUMiSOfToY+QVfEwiHG3xlaH8PgTdwZWUCaF8gxvfCC74UKrhIcKoNUqt3+q2w3DD6KiuqxAZP/10DSkxX179b/jb8IpadDc/ZoJxoMO0QUUI1zBlS7Rqc7M0GDZpe3fLRV7jLd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750237015; c=relaxed/simple;
	bh=9To1BSpsPsNIGrHogpM+R444lxBSfMxpMbu2q+8LxE4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pB9mafOcHPup0eUOTgXc5MG2jWbJBHpQ0RnYkNbiI+lwjXk1Gm4MHNTreaJtqqVRS3eNf75uC1IlSuhjjvqBg7GYqebyiEPORdjtAfQMwmMuIBDXDLlGcIwYhZRIGBlGq2H9j7cA3PqmYltjmk9ag3dN/mmbUN8IhgNvQ4Xnnh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bMctd6GXjz6L570;
	Wed, 18 Jun 2025 16:52:09 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 6CD6B140426;
	Wed, 18 Jun 2025 16:56:49 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 18 Jun
 2025 10:56:48 +0200
Date: Wed, 18 Jun 2025 09:56:46 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Ivan Vecera <ivecera@redhat.com>
CC: <netdev@vger.kernel.org>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Jiri Pirko
	<jiri@resnulli.us>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Prathosh Satish
	<Prathosh.Satish@microchip.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Jason Gunthorpe <jgg@ziepe.ca>, Shannon Nelson
	<shannon.nelson@amd.com>, Dave Jiang <dave.jiang@intel.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, Michal Schmidt <mschmidt@redhat.com>, Petr Oros
	<poros@redhat.com>
Subject: Re: [PATCH net-next v11 03/14] dpll: Add basic Microchip ZL3073x
 support
Message-ID: <20250618095646.00004595@huawei.com>
In-Reply-To: <20250616201404.1412341-4-ivecera@redhat.com>
References: <20250616201404.1412341-1-ivecera@redhat.com>
	<20250616201404.1412341-4-ivecera@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 16 Jun 2025 22:13:53 +0200
Ivan Vecera <ivecera@redhat.com> wrote:

> Microchip Azurite ZL3073x represents chip family providing DPLL
> and optionally PHC (PTP) functionality. The chips can be connected
> be connected over I2C or SPI bus.
> 
> They have the following characteristics:
> * up to 5 separate DPLL units (channels)
> * 5 synthesizers
> * 10 input pins (references)
> * 10 outputs
> * 20 output pins (output pin pair shares one output)
> * Each reference and output can operate in either differential or
>   single-ended mode (differential mode uses 2 pins)
> * Each output is connected to one of the synthesizers
> * Each synthesizer is driven by one of the DPLL unit
> 
> The device uses 7-bit addresses and 8-bits values. It exposes 8-, 16-,
> 32- and 48-bits registers in address range <0x000,0x77F>. Due to 7bit
> addressing, the range is organized into pages of 128 bytes, with each
> page containing a page selector register at address 0x7F.
> For reading/writing multi-byte registers, the device supports bulk
> transfers.
> 
> Add basic functionality to access device registers and probe
> functionality for both I2C and SPI cases.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
A few trivial drive by comments.

> diff --git a/drivers/dpll/zl3073x/i2c.c b/drivers/dpll/zl3073x/i2c.c
> new file mode 100644
> index 0000000000000..bca1cd729895c
> --- /dev/null
> +++ b/drivers/dpll/zl3073x/i2c.c
> @@ -0,0 +1,93 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/dev_printk.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +
> +#include "core.h"
> +
> +static int zl3073x_i2c_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct zl3073x_dev *zldev;
> +
> +	zldev = zl3073x_devm_alloc(dev);
> +	if (IS_ERR(zldev))
> +		return PTR_ERR(zldev);
> +
> +	zldev->regmap = devm_regmap_init_i2c(client, &zl3073x_regmap_config);
> +	if (IS_ERR(zldev->regmap)) {
> +		dev_err_probe(dev, PTR_ERR(zldev->regmap),
> +			      "Failed to initialize regmap\n");
> +		return PTR_ERR(zldev->regmap);
As below.

> +	}

> diff --git a/drivers/dpll/zl3073x/spi.c b/drivers/dpll/zl3073x/spi.c
> new file mode 100644
> index 0000000000000..219676da71b78
> --- /dev/null
> +++ b/drivers/dpll/zl3073x/spi.c
> @@ -0,0 +1,93 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/dev_printk.h>
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/spi/spi.h>
> +
> +#include "core.h"
> +
> +static int zl3073x_spi_probe(struct spi_device *spi)
> +{
> +	struct device *dev = &spi->dev;
> +	struct zl3073x_dev *zldev;
> +
> +	zldev = zl3073x_devm_alloc(dev);
> +	if (IS_ERR(zldev))
> +		return PTR_ERR(zldev);
> +
> +	zldev->regmap = devm_regmap_init_spi(spi, &zl3073x_regmap_config);
> +	if (IS_ERR(zldev->regmap)) {
> +		dev_err_probe(dev, PTR_ERR(zldev->regmap),
> +			      "Failed to initialize regmap\n");
> +		return PTR_ERR(zldev->regmap);

return dev_err_probe();
One of it's biggest advantages is that dev_err_probe() returns the
ret value passed in avoiding duplication like this and saving
a few lines of code each time.

> +	}
> +
> +	return zl3073x_dev_probe(zldev, spi_get_device_match_data(spi));
> +}
> +
> +static const struct spi_device_id zl3073x_spi_id[] = {
> +	{
> +		.name = "zl30731",
> +		.driver_data = (kernel_ulong_t)&zl3073x_chip_info[ZL30731],

Not my subsystem so up to you, but in general over time we've found that
an enum + array tends to bring few benefits over appropriately named
zl30731_chip_info separate structures.

> +	},
> +	{
> +		.name = "zl30732",
> +		.driver_data = (kernel_ulong_t)&zl3073x_chip_info[ZL30732],
> +	},
> +	{
> +		.name = "zl30733",
> +		.driver_data = (kernel_ulong_t)&zl3073x_chip_info[ZL30733],
> +	},
> +	{
> +		.name = "zl30734",
> +		.driver_data = (kernel_ulong_t)&zl3073x_chip_info[ZL30734],
> +	},
> +	{
> +		.name = "zl30735",
> +		.driver_data = (kernel_ulong_t)&zl3073x_chip_info[ZL30735]
> +	},
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(spi, zl3073x_spi_id);
> +
> +static const struct of_device_id zl3073x_spi_of_match[] = {
> +	{
> +		.compatible = "microchip,zl30731",
> +		.data = &zl3073x_chip_info[ZL30731]
> +	},
> +	{
> +		.compatible = "microchip,zl30732",
> +		.data = &zl3073x_chip_info[ZL30732]
> +	},
> +	{
> +		.compatible = "microchip,zl30733",
> +		.data = &zl3073x_chip_info[ZL30733]
> +	},
> +	{
> +		.compatible = "microchip,zl30734",
> +		.data = &zl3073x_chip_info[ZL30734]
> +	},
> +	{
> +		.compatible = "microchip,zl30735",
> +		.data = &zl3073x_chip_info[ZL30735]
> +	},
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, zl3073x_spi_of_match);
> +
> +static struct spi_driver zl3073x_spi_driver = {
> +	.driver = {
> +		.name = "zl3073x-spi",
> +		.of_match_table = zl3073x_spi_of_match,
> +	},
> +	.probe = zl3073x_spi_probe,
> +	.id_table = zl3073x_spi_id,
> +};
> +module_spi_driver(zl3073x_spi_driver);
> +
> +MODULE_AUTHOR("Ivan Vecera <ivecera@redhat.com>");
> +MODULE_DESCRIPTION("Microchip ZL3073x SPI driver");
> +MODULE_IMPORT_NS("ZL3073X");
> +MODULE_LICENSE("GPL");


