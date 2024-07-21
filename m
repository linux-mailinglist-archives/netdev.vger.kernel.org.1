Return-Path: <netdev+bounces-112310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A10E938417
	for <lists+netdev@lfdr.de>; Sun, 21 Jul 2024 10:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85BA41F213B7
	for <lists+netdev@lfdr.de>; Sun, 21 Jul 2024 08:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9ACBE68;
	Sun, 21 Jul 2024 08:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DC8sa8JW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAD933E1;
	Sun, 21 Jul 2024 08:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721552359; cv=none; b=KEQVkT2fxmn551YRenz0NztwlWE5MuT4R93HC2cukTdi2A7PAAI6MsYdTiGyCa+mAWi0JUBqMSM0xkWvRzDgzFOZrkeW0ot+WExwzXrhmAoPZVyTAGTdGUVoSp6LDM1hax9eOw1syt7qfWbcXA8fG0ZePMHJBBFsdc2xKU9DueU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721552359; c=relaxed/simple;
	bh=ZuuqEi4S2iKFuJKwkxBMs+ZU/Sd67LLMFp02L/gM/5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q5GcKJM3opjzMp4twOWgTomaxMjhw+xDwoDW2nZNHJxosGR2GNBBEQLCH4bs5LX1W2E+/DeyBi0Mded8b3GyRdV7HRepMu92oYEilZ1YV19NeV28HoRR3nXEq1gAzKx//6Gm75jh1t00tQ9WNOLkfHmFJybn4pPsEYTbOWmoOqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DC8sa8JW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3661C116B1;
	Sun, 21 Jul 2024 08:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721552358;
	bh=ZuuqEi4S2iKFuJKwkxBMs+ZU/Sd67LLMFp02L/gM/5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DC8sa8JW/xfOr2xbyypcs6KARdNf2mwJ0nWHTkrd1Rv0zrwMyGpHu3lqFR2BGvL0a
	 uxtd0IifDa7kdKSG51qzjAn/bA7BcfdOzLWUiR60M0ijTyF2O0HbYoMxi2I/J5ukBn
	 FlbRiwW4wQxrOziEa6wzEMpeyKkbQVgxcInKZ2hK76X4C/TjIM8LMIdV/KAKW7arCv
	 bRIN0c9LRMctfPisVrMiPq4M3tNznh90IsvpKI+tYmuWjqRT2gDzS7ZwDoDdLvYJCw
	 Bx7ADf0vTPjuk4AVG7qA12YYDkwxepFmpB27Crh4WuCLIhRIfFFvHyYa8TE9krCp/2
	 OQHVcf/7UcPjw==
Date: Sun, 21 Jul 2024 09:59:12 +0100
From: Simon Horman <horms@kernel.org>
To: Ayush Singh <ayush@beagleboard.org>
Cc: jkridner@beagleboard.org, robertcnelson@beagleboard.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	greybus-dev@lists.linaro.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] greybus: gb-beagleplay: Add firmware upload API
Message-ID: <20240721085912.GB715661@kernel.org>
References: <20240719-beagleplay_fw_upgrade-v1-0-8664d4513252@beagleboard.org>
 <20240719-beagleplay_fw_upgrade-v1-3-8664d4513252@beagleboard.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719-beagleplay_fw_upgrade-v1-3-8664d4513252@beagleboard.org>

On Fri, Jul 19, 2024 at 03:15:12PM +0530, Ayush Singh wrote:
> Register with firmware upload API to allow updating firmware on cc1352p7
> without resorting to overlay for using the userspace flasher.
> 
> Communication with the bootloader can be moved out of gb-beagleplay
> driver if required, but I am keeping it here since there are no
> immediate plans to use the on-board cc1352p7 for anything other than
> greybus (BeagleConnect Technology). Additionally, there do not seem to
> any other devices using cc1352p7 or it's cousins as a co-processor.
> 
> Boot and Reset GPIOs are used to enable cc1352p7 bootloader backdoor for
> flashing. The delays while starting bootloader are taken from the
> userspace flasher since the technical specification does not provide
> sufficient information regarding it.
> 
> Flashing is skipped in case we are trying to flash the same
> image as the one that is currently present. This is determined by CRC32
> calculation of the supplied firmware and Flash data.
> 
> We also do a CRC32 check after flashing to ensure that the firmware was
> flashed properly.
> 
> Link: https://www.ti.com/lit/ug/swcu192/swcu192.pdf Ti CC1352p7 Tecnical Specification
> Link: https://openbeagle.org/beagleconnect/cc1352-flasher Userspace
> Flasher
> 
> Signed-off-by: Ayush Singh <ayush@beagleboard.org>

Hi Ayush,

A few minor points from my side.

...

> diff --git a/drivers/greybus/gb-beagleplay.c b/drivers/greybus/gb-beagleplay.c

...

> +/**
> + * enum cc1352_bootloader_cmd: CC1352 Bootloader Commands

nit: As this is a kernel doc, it should probably include documentation
     of the elements of the enum:

    * @COMMAND_DOWNLOAD: ...
    ...

    Flagged by W=1 allmodconfig builds and ./scripts/kernel-doc -none

> + */
> +enum cc1352_bootloader_cmd {
> +	COMMAND_DOWNLOAD = 0x21,
> +	COMMAND_GET_STATUS = 0x23,
> +	COMMAND_SEND_DATA = 0x24,
> +	COMMAND_RESET = 0x25,
> +	COMMAND_CRC32 = 0x27,
> +	COMMAND_BANK_ERASE = 0x2c,
> +};
> +
> +/**
> + * enum cc1352_bootloader_status: CC1352 Bootloader COMMAND_GET_STATUS response

Likewise here.

> + */
> +enum cc1352_bootloader_status {
> +	COMMAND_RET_SUCCESS = 0x40,
> +	COMMAND_RET_UNKNOWN_CMD = 0x41,
> +	COMMAND_RET_INVALID_CMD = 0x42,
> +	COMMAND_RET_INVALID_ADR = 0x43,
> +	COMMAND_RET_FLASH_FAIL = 0x44,
> +};

...

> +/**
> + * csum8: Calculate 8-bit checksum on data

Similarly, as this is a kernel doc it should probably include
documentation of of the function parameters.

> + */
> +static u8 csum8(const u8 *data, size_t size, u8 base)
> +{
> +	size_t i;
> +	u8 sum = base;
> +
> +	for (i = 0; i < size; ++i)
> +		sum += data[i];
> +
> +	return sum;
> +}

...

> +/**
> + * cc1352_bootloader_empty_pkt: Calculate the number of empty bytes in the current packet

Likewise here.

> + */
> +static size_t cc1352_bootloader_empty_pkt(const u8 *data, size_t size)
> +{
> +	size_t i;
> +
> +	for (i = 0; i < size && data[i] == 0xff; ++i)
> +		continue;
> +
> +	return i;
> +}

...

> +static int gb_fw_init(struct gb_beagleplay *bg)
> +{
> +	int ret;
> +	struct fw_upload *fwl;
> +	struct gpio_desc *desc;
> +
> +	bg->fwl = NULL;
> +	bg->boot_gpio = NULL;
> +	bg->rst_gpio = NULL;
> +	bg->flashing_mode = false;
> +	bg->fwl_cmd_response = 0;
> +	bg->fwl_ack = 0;
> +	init_completion(&bg->fwl_ack_com);
> +	init_completion(&bg->fwl_cmd_response_com);
> +
> +	desc = devm_gpiod_get(&bg->sd->dev, "boot", GPIOD_IN);
> +	if (IS_ERR(desc))
> +		return PTR_ERR(fwl);

fwl is not initialised here, and it is desc that is tested for error.
Perhaps this should be:

		return PTR_ERR(desc);

Flagged by Smatch and Coccinelle.

> +	bg->boot_gpio = desc;
> +
> +	desc = devm_gpiod_get(&bg->sd->dev, "reset", GPIOD_IN);
> +	if (IS_ERR(desc)) {
> +		ret = PTR_ERR(desc);
> +		goto free_boot;
> +	}
> +	bg->rst_gpio = desc;
> +
> +	fwl = firmware_upload_register(THIS_MODULE, &bg->sd->dev, "cc1352p7",
> +				       &cc1352_bootloader_ops, bg);
> +	if (IS_ERR(fwl)) {
> +		ret = PTR_ERR(fwl);
> +		goto free_reset;
> +	}
> +	bg->fwl = fwl;
> +
> +	return 0;
> +
> +free_reset:
> +	devm_gpiod_put(&bg->sd->dev, bg->rst_gpio);
> +	bg->rst_gpio = NULL;
> +free_boot:
> +	devm_gpiod_put(&bg->sd->dev, bg->boot_gpio);
> +	bg->boot_gpio = NULL;
> +	return ret;
> +}
> +
> +static void gb_fw_deinit(struct gb_beagleplay *bg)
> +{
> +	firmware_upload_unregister(bg->fwl);
> +}
> +
>  static int gb_beagleplay_probe(struct serdev_device *serdev)
>  {
>  	int ret = 0;
> @@ -481,6 +1077,10 @@ static int gb_beagleplay_probe(struct serdev_device *serdev)
>  	if (ret)
>  		goto free_serdev;
>  
> +	ret = gb_fw_init(bg);
> +	if (ret)
> +		goto free_hdlc;
> +
>  	ret = gb_greybus_init(bg);
>  	if (ret)
>  		goto free_hdlc;

I suspect this error path will leak resources allocated by gb_fw_init().

> @@ -500,6 +1100,7 @@ static void gb_beagleplay_remove(struct serdev_device *serdev)
>  {
>  	struct gb_beagleplay *bg = serdev_device_get_drvdata(serdev);
>  
> +	gb_fw_deinit(bg);
>  	gb_greybus_deinit(bg);
>  	gb_beagleplay_stop_svc(bg);
>  	hdlc_deinit(bg);
> 
> -- 
> 2.45.2
> 
> 

