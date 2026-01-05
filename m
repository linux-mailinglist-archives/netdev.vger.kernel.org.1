Return-Path: <netdev+bounces-247102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E947BCF481E
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 16:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DAFBD301DE3B
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 15:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801CF3446CA;
	Mon,  5 Jan 2026 15:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QurvtCqD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5125132ED4E
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 15:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767628200; cv=none; b=Ok4aUEp1dTi5oa/yza+xnwm63gB0IH+fMU/D20ktT2rdsgB8y1mHPVHgdVIyoB+/CVoIEYyTGLe+2GVEObuwkAv4Q3jsCYc9mT2kkSK5i9QG57MIXnOt40NqhDFKSjuGBpaKfHuZMiSrL7LiesTc9Na5SiIR4uZzzZ6zPSefIqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767628200; c=relaxed/simple;
	bh=olQyVYH0Ag2RJAuLBgwkYLxW77WAllEc9l+jkla2DQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u8VqeReHD1s0nWqhEkafqFGl+2x0MQvCw15vhwiJBzUnw3Jx0kSmC/Knxmj418ZEnsy9W1IKbRW1aghw5j436oKU1q+RErXdkV+zLPc/Lhjynv0TfOxf3/+q7NHmamjDnHZic7Rpw6zKDErkXYaS+2eDwtpL/Tf02sDMsvo0EE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QurvtCqD; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b728a43e410so14062566b.1
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 07:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767628193; x=1768232993; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DuXlLK2RIL3I+JB1SrVBkkjGCSZRxW7su/cgJs2ojpw=;
        b=QurvtCqDL8vIrw9lAnOhKC7W5/cRjcyZJKktQ9+ujr4M5JZrZUng90vhIK8du39mSP
         Q/M3JmCNobe0XtodWoMlKlq/bCN44aXB3da3cqxYcga1eIBbm1iPzU5/il0esJXoeyqT
         mq0Q+y8ehEei2Q832jgSp7Zdt7qwv2Jj5zlX3KAtC3Oq3QFTbYBpAiLlYuvxaUdFOiAu
         MrRonFkqIJEUbW0EWI7znc7vWgtswvhH+eEWVApKhdsU/KWGK562QOGhaGqowWBHvcmI
         /Et8c4KXSzo7oBxc75poYENApj7dhj4zbF8ZrX/aOeH4qDiskT+aMOJzqhMCCTGfoh5Q
         GNaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767628193; x=1768232993;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DuXlLK2RIL3I+JB1SrVBkkjGCSZRxW7su/cgJs2ojpw=;
        b=P6dM80K+NEAbPOMbaHMmGf4QeSHJGGWrhCawqxzN0oLGtm3UQQHBemEDZN7yv0KU3W
         kNTC+wDelSTQ6xssWbLJoL43mjpVhdPwvqSh8IoBR2TKaiOR1Z4lZ3/SfzuOXVCSloLV
         ZHusHLuHcNc6f9Ifn35TTtQMTknvH+C3lls8rHjIK1FFhi86FudyTYbEwY5gWhkO5r5T
         8oRaP3AMFGpfyKKtprj0VL2jmSgfBAco+jyejZHwTQnPF395FW3jhUPbP7Me3rO4FRZ1
         5njJBQppmrgCKLHfY72oJiolsyp1zZ5EBzQsnYi+rXY6yzOVehv3yNz8xbswJ7IJC2lp
         0bow==
X-Gm-Message-State: AOJu0YxZZkDewW1V2JMb/AqC2SHNSodd5HqFz84crXC6WHQP+xGgm0oY
	nsAIpuO8ehHPulA9f7tfr2lp8sunPVC0Tc0cKKPE4cWe0yse62i/tSWphmGdNw==
X-Gm-Gg: AY/fxX4cOVkVnmeJ2+qpDqYpm4RMvHllCglrHFiQRnGzGC9DBy1lnXNmNm3yfIINDhI
	fHb6Vy77inGDUUhGxCdt6EsgNYu+RmDylKV0ejjRw/LOsS64SqjHuNQNpjwVoTcmbaDOTWncMpn
	envKshQmfttpdk1nHg+wC5WFt/hpYFFOpaSHucNwQD3bfblFXGappwP6aeqRETTC0pZRSEkS53n
	+yBE+rU60Mwahb/yUOUY19Oi7LB5J0Um0AC0fvf75HEX9Hty8vXFokDRp9TQj2tMUhXAPf1kLEO
	EqeaxxIN1UfIlD2enmK7PzDhgqGKsRFSBSiUDPhlf11w4IoX7qcpK1YD6XWONjKGhAlBTYAQtBq
	U8Yif18tZnMwoTM/fGRWeP/gEsKqnktSXneUMyCzNGptqQaVmQy4c6bxxbfMvWXpPVkRYKH384x
	2L3sJ00vEDnSTktMPS5vBYd1P96S4OIJmtFaqyLap6JzD4tcXjoAVhmF6Dlk3Ej1kg
X-Google-Smtp-Source: AGHT+IGTcaItzX7HWOz93kzAf22nt1bsFCnAPA784RIhU2WoxE4dAY76osHO6taYvvS2ivmDpGRAng==
X-Received: by 2002:a17:906:f598:b0:b76:e6bd:7bcd with SMTP id a640c23a62f3a-b8426a864ffmr24637866b.20.1767628193235;
        Mon, 05 Jan 2026 07:49:53 -0800 (PST)
Received: from [192.168.255.3] (217-8-142-46.pool.kielnet.net. [46.142.8.217])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507618cc59sm111239a12.28.2026.01.05.07.49.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jan 2026 07:49:52 -0800 (PST)
Message-ID: <4628df96-5ad7-411b-9b9d-4084cb5da87a@gmail.com>
Date: Mon, 5 Jan 2026 16:49:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: sfp: add SMBus I2C block support
Content-Language: en-US
To: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>
References: <20260105154653.575397-1-jelonek.jonas@gmail.com>
From: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <20260105154653.575397-1-jelonek.jonas@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Sorry for the noise, messed that version up.
Will send a v3 quickly.

Best regards,
Jonas Jelonek

On 05.01.26 16:46, Jonas Jelonek wrote:
> Commit 7662abf4db94 ("net: phy: sfp: Add support for SMBus module access")
> added support for SMBus-only controllers for module access. However,
> this is restricted to single-byte accesses and has the implication that
> hwmon is disabled (due to missing atomicity of 16-bit accesses) and
> warnings are printed.
>
> There are probably a lot of SMBus-only I2C controllers out in the wild
> which support block reads. Right now, they don't work with SFP modules.
> This applies - amongst others - to I2C/SMBus-only controllers in Realtek
> longan and mango SoCs.
>
> Downstream in OpenWrt, a patch similar to the abovementioned patch is
> used for current LTS kernel 6.12. However, this uses byte-access for all
> kinds of access and thus disregards the atomicity for wider access.
>
> Introduce read/write SMBus I2C block operations to support SMBus-only
> controllers with appropriate support for block read/write. Those
> operations are used for all accesses if supported, otherwise the
> single-byte operations will be used. With block reads, atomicity for
> 16-bit reads as required by hwmon is preserved and thus, hwmon can be
> used.
>
> The implementation requires the I2C_FUNC_SMBUS_I2C_BLOCK to be
> supported as it relies on reading a pre-defined amount of bytes.
> This isn't intended by the official SMBus Block Read but supported by
> several I2C controllers/drivers.
>
> Support for word access is not implemented due to issues regarding
> endianness.
>
> Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
>
> ---
> v2: return number of written bytes in sfp_smbus_block_write
> v1: https://lore.kernel.org/netdev/20251228213331.472887-1-jelonek.jonas@gmail.com/
> ---
>  drivers/net/phy/sfp.c | 77 +++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 75 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
> index 6166e9196364..4f2175397534 100644
> --- a/drivers/net/phy/sfp.c
> +++ b/drivers/net/phy/sfp.c
> @@ -744,6 +744,35 @@ static int sfp_smbus_byte_read(struct sfp *sfp, bool a2, u8 dev_addr,
>  	return data - (u8 *)buf;
>  }
>  
> +static int sfp_smbus_block_read(struct sfp *sfp, bool a2, u8 dev_addr,
> +				void *buf, size_t len)
> +{
> +	size_t block_size = sfp->i2c_block_size;
> +	union i2c_smbus_data smbus_data;
> +	u8 bus_addr = a2 ? 0x51 : 0x50;
> +	u8 *data = buf;
> +	u8 this_len;
> +	int ret;
> +
> +	while (len) {
> +		this_len = min(len, block_size);
> +
> +		smbus_data.block[0] = this_len;
> +		ret = i2c_smbus_xfer(sfp->i2c, bus_addr, 0,
> +				     I2C_SMBUS_READ, dev_addr,
> +				     I2C_SMBUS_I2C_BLOCK_DATA, &smbus_data);
> +		if (ret < 0)
> +			return ret;
> +
> +		memcpy(data, &smbus_data.block[1], this_len);
> +		len -= this_len;
> +		data += this_len;
> +		dev_addr += this_len;
> +	}
> +
> +	return data - (u8 *)buf;
> +}
> +
>  static int sfp_smbus_byte_write(struct sfp *sfp, bool a2, u8 dev_addr,
>  				void *buf, size_t len)
>  {
> @@ -765,26 +794,70 @@ static int sfp_smbus_byte_write(struct sfp *sfp, bool a2, u8 dev_addr,
>  		dev_addr++;
>  	}
>  
> +	return data - (u8 *)buf;
> +}
> +
> +static int sfp_smbus_block_write(struct sfp *sfp, bool a2, u8 dev_addr,
> +				 void *buf, size_t len)
> +{
> +	size_t block_size = sfp->i2c_block_size;
> +	union i2c_smbus_data smbus_data;
> +	u8 bus_addr = a2 ? 0x51 : 0x50;
> +	u8 *data = buf;
> +	u8 this_len;
> +	int ret;
> +
> +	while (len) {
> +		this_len = min(len, block_size);
> +
> +		smbus_data.block[0] = this_len;
> +		memcpy(&smbus_data.block[1], data, this_len);
> +		ret = i2c_smbus_xfer(sfp->i2c, bus_addr, 0,
> +				     I2C_SMBUS_WRITE, dev_addr,
> +				     I2C_SMBUS_I2C_BLOCK_DATA, &smbus_data);
> +		if (ret)
> +			return ret;
> +
> +		len -= this_len;
> +		data += this_len;
> +		dev_addr += this_len;
> +	}
> +
>  	return 0;
>  }
>  
>  static int sfp_i2c_configure(struct sfp *sfp, struct i2c_adapter *i2c)
>  {
> +	size_t max_block_size;
> +
>  	sfp->i2c = i2c;
>  
>  	if (i2c_check_functionality(i2c, I2C_FUNC_I2C)) {
>  		sfp->read = sfp_i2c_read;
>  		sfp->write = sfp_i2c_write;
> -		sfp->i2c_max_block_size = SFP_EEPROM_BLOCK_SIZE;
> +		max_block_size = SFP_EEPROM_BLOCK_SIZE;
> +	} else if (i2c_check_functionality(i2c, I2C_FUNC_SMBUS_I2C_BLOCK)) {
> +		sfp->read = sfp_smbus_block_read;
> +		sfp->write = sfp_smbus_block_write;
> +
> +		max_block_size = SFP_EEPROM_BLOCK_SIZE;
> +		if (i2c->quirks && i2c->quirks->max_read_len)
> +			max_block_size = min(max_block_size,
> +					     i2c->quirks->max_read_len);
> +		if (i2c->quirks && i2c->quirks->max_write_len)
> +			max_block_size = min(max_block_size,
> +					     i2c->quirks->max_write_len);
> +
>  	} else if (i2c_check_functionality(i2c, I2C_FUNC_SMBUS_BYTE_DATA)) {
>  		sfp->read = sfp_smbus_byte_read;
>  		sfp->write = sfp_smbus_byte_write;
> -		sfp->i2c_max_block_size = 1;
> +		max_block_size = 1;
>  	} else {
>  		sfp->i2c = NULL;
>  		return -EINVAL;
>  	}
>  
> +	sfp->i2c_max_block_size = max_block_size;
>  	return 0;
>  }
>  
>
> base-commit: c303e8b86d9dbd6868f5216272973292f7f3b7f1


