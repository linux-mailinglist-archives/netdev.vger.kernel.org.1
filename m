Return-Path: <netdev+bounces-202262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39686AECFC3
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 21:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B4B01740F0
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 19:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD4923A9AE;
	Sun, 29 Jun 2025 19:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cj2UWam9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB73B1EA7DB
	for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 19:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751223615; cv=none; b=BJpvxNBgKE2qkE9zFvSb1SeRqZKz4jG6gx3UTmXM1zOU3XEwm9ZJgeqk19ei/gAu/2zEOGv2ZCvpCPUF1TCM1/czoQYX/LLEXDWb1/C5eF9bY2CcIklr+uW+RSxmE4gIfXHKOolmzKlEkOzgjwZhP7vuA2UPR2qIlzFb1Q+7nqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751223615; c=relaxed/simple;
	bh=UoNTc52qX02+DxAnewqTZUhjup5tIf+FN3oS2Td4aRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HG91pfudvNmmX5BNRFCuE118FeecWiTw5y+eplY/07qXMm6H0eAl75KdZ8XX7Lnl42DnJ+O5rYnqf5WKv+xFG4NE1skJBMxpdu6pGkIFFYirlGCLIL69cWM4302yCBvdVIpwJ+E619T/G6T5IWpMXdFfZZkjJ0Bb12BH6OtP4I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cj2UWam9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751223610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M6dd0BdxPQckL0K4ug6lCXCJOc94fLHhkrXB/JxBoxQ=;
	b=cj2UWam9J24v25oGOGqaVkO0xxWxtJLHhcVXvSwkd/NUa58bgUipCjlweq55GIcWhnjyM5
	GLf43h7/+MrGe5iCai7RGw+KpOEGQfGf9S1wkHfAK3P3Zj9FjEU7CIqol0hNcq+jkAmjBr
	mtyUiy3wod56t9+y63ZtMb9jY8VZuiI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-BffGb6S9MYiiFFt3Q90fSQ-1; Sun,
 29 Jun 2025 15:00:07 -0400
X-MC-Unique: BffGb6S9MYiiFFt3Q90fSQ-1
X-Mimecast-MFC-AGG-ID: BffGb6S9MYiiFFt3Q90fSQ_1751223604
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AB8FB18089B4;
	Sun, 29 Jun 2025 19:00:03 +0000 (UTC)
Received: from [10.45.224.33] (unknown [10.45.224.33])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 73ADC1956095;
	Sun, 29 Jun 2025 18:59:56 +0000 (UTC)
Message-ID: <1f1e5566-a9a0-4d72-80be-81eddfe95fa3@redhat.com>
Date: Sun, 29 Jun 2025 20:59:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 03/14] dpll: Add basic Microchip ZL3073x
 support
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Prathosh Satish <Prathosh.Satish@microchip.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Jason Gunthorpe <jgg@ziepe.ca>, Shannon Nelson <shannon.nelson@amd.com>,
 Dave Jiang <dave.jiang@intel.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Michal Schmidt <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>
References: <20250616201404.1412341-1-ivecera@redhat.com>
 <20250616201404.1412341-4-ivecera@redhat.com>
 <20250618095646.00004595@huawei.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20250618095646.00004595@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17



On 18. 06. 25 10:56 dop., Jonathan Cameron wrote:
> On Mon, 16 Jun 2025 22:13:53 +0200
> Ivan Vecera <ivecera@redhat.com> wrote:
> 
>> Microchip Azurite ZL3073x represents chip family providing DPLL
>> and optionally PHC (PTP) functionality. The chips can be connected
>> be connected over I2C or SPI bus.
>>
>> They have the following characteristics:
>> * up to 5 separate DPLL units (channels)
>> * 5 synthesizers
>> * 10 input pins (references)
>> * 10 outputs
>> * 20 output pins (output pin pair shares one output)
>> * Each reference and output can operate in either differential or
>>    single-ended mode (differential mode uses 2 pins)
>> * Each output is connected to one of the synthesizers
>> * Each synthesizer is driven by one of the DPLL unit
>>
>> The device uses 7-bit addresses and 8-bits values. It exposes 8-, 16-,
>> 32- and 48-bits registers in address range <0x000,0x77F>. Due to 7bit
>> addressing, the range is organized into pages of 128 bytes, with each
>> page containing a page selector register at address 0x7F.
>> For reading/writing multi-byte registers, the device supports bulk
>> transfers.
>>
>> Add basic functionality to access device registers and probe
>> functionality for both I2C and SPI cases.
>>
>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> A few trivial drive by comments.
> 
>> diff --git a/drivers/dpll/zl3073x/i2c.c b/drivers/dpll/zl3073x/i2c.c
>> new file mode 100644
>> index 0000000000000..bca1cd729895c
>> --- /dev/null
>> +++ b/drivers/dpll/zl3073x/i2c.c
>> @@ -0,0 +1,93 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +
>> +#include <linux/dev_printk.h>
>> +#include <linux/err.h>
>> +#include <linux/i2c.h>
>> +#include <linux/module.h>
>> +#include <linux/regmap.h>
>> +
>> +#include "core.h"
>> +
>> +static int zl3073x_i2c_probe(struct i2c_client *client)
>> +{
>> +	struct device *dev = &client->dev;
>> +	struct zl3073x_dev *zldev;
>> +
>> +	zldev = zl3073x_devm_alloc(dev);
>> +	if (IS_ERR(zldev))
>> +		return PTR_ERR(zldev);
>> +
>> +	zldev->regmap = devm_regmap_init_i2c(client, &zl3073x_regmap_config);
>> +	if (IS_ERR(zldev->regmap)) {
>> +		dev_err_probe(dev, PTR_ERR(zldev->regmap),
>> +			      "Failed to initialize regmap\n");
>> +		return PTR_ERR(zldev->regmap);
> As below.
> 
>> +	}
> 
>> diff --git a/drivers/dpll/zl3073x/spi.c b/drivers/dpll/zl3073x/spi.c
>> new file mode 100644
>> index 0000000000000..219676da71b78
>> --- /dev/null
>> +++ b/drivers/dpll/zl3073x/spi.c
>> @@ -0,0 +1,93 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +
>> +#include <linux/dev_printk.h>
>> +#include <linux/err.h>
>> +#include <linux/module.h>
>> +#include <linux/regmap.h>
>> +#include <linux/spi/spi.h>
>> +
>> +#include "core.h"
>> +
>> +static int zl3073x_spi_probe(struct spi_device *spi)
>> +{
>> +	struct device *dev = &spi->dev;
>> +	struct zl3073x_dev *zldev;
>> +
>> +	zldev = zl3073x_devm_alloc(dev);
>> +	if (IS_ERR(zldev))
>> +		return PTR_ERR(zldev);
>> +
>> +	zldev->regmap = devm_regmap_init_spi(spi, &zl3073x_regmap_config);
>> +	if (IS_ERR(zldev->regmap)) {
>> +		dev_err_probe(dev, PTR_ERR(zldev->regmap),
>> +			      "Failed to initialize regmap\n");
>> +		return PTR_ERR(zldev->regmap);
> 
> return dev_err_probe();
> One of it's biggest advantages is that dev_err_probe() returns the
> ret value passed in avoiding duplication like this and saving
> a few lines of code each time.

Will fix.

>> +	}
>> +
>> +	return zl3073x_dev_probe(zldev, spi_get_device_match_data(spi));
>> +}
>> +
>> +static const struct spi_device_id zl3073x_spi_id[] = {
>> +	{
>> +		.name = "zl30731",
>> +		.driver_data = (kernel_ulong_t)&zl3073x_chip_info[ZL30731],
> 
> Not my subsystem so up to you, but in general over time we've found that
> an enum + array tends to bring few benefits over appropriately named
> zl30731_chip_info separate structures.

Will update according this.

>> +	},
>> +	{
>> +		.name = "zl30732",
>> +		.driver_data = (kernel_ulong_t)&zl3073x_chip_info[ZL30732],
>> +	},
>> +	{
>> +		.name = "zl30733",
>> +		.driver_data = (kernel_ulong_t)&zl3073x_chip_info[ZL30733],
>> +	},
>> +	{
>> +		.name = "zl30734",
>> +		.driver_data = (kernel_ulong_t)&zl3073x_chip_info[ZL30734],
>> +	},
>> +	{
>> +		.name = "zl30735",
>> +		.driver_data = (kernel_ulong_t)&zl3073x_chip_info[ZL30735]
>> +	},
>> +	{ /* sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(spi, zl3073x_spi_id);
>> +
>> +static const struct of_device_id zl3073x_spi_of_match[] = {
>> +	{
>> +		.compatible = "microchip,zl30731",
>> +		.data = &zl3073x_chip_info[ZL30731]
>> +	},
>> +	{
>> +		.compatible = "microchip,zl30732",
>> +		.data = &zl3073x_chip_info[ZL30732]
>> +	},
>> +	{
>> +		.compatible = "microchip,zl30733",
>> +		.data = &zl3073x_chip_info[ZL30733]
>> +	},
>> +	{
>> +		.compatible = "microchip,zl30734",
>> +		.data = &zl3073x_chip_info[ZL30734]
>> +	},
>> +	{
>> +		.compatible = "microchip,zl30735",
>> +		.data = &zl3073x_chip_info[ZL30735]
>> +	},
>> +	{ /* sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(of, zl3073x_spi_of_match);
>> +
>> +static struct spi_driver zl3073x_spi_driver = {
>> +	.driver = {
>> +		.name = "zl3073x-spi",
>> +		.of_match_table = zl3073x_spi_of_match,
>> +	},
>> +	.probe = zl3073x_spi_probe,
>> +	.id_table = zl3073x_spi_id,
>> +};
>> +module_spi_driver(zl3073x_spi_driver);
>> +
>> +MODULE_AUTHOR("Ivan Vecera <ivecera@redhat.com>");
>> +MODULE_DESCRIPTION("Microchip ZL3073x SPI driver");
>> +MODULE_IMPORT_NS("ZL3073X");
>> +MODULE_LICENSE("GPL");
> 

Thanks for advice.

Ivan


