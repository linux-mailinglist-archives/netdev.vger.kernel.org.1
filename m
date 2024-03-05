Return-Path: <netdev+bounces-77383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCFE8717CB
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 09:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A8941F2234D
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 08:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5755B7FBB4;
	Tue,  5 Mar 2024 08:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKtS0+7/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D887EEFD;
	Tue,  5 Mar 2024 08:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709626427; cv=none; b=dURqNYOIEVCHwExC8duyjO8TLL3QP7rgx2VHyQ8ytvuWEVZSJ7QleLp19L/xnipT7Y3rB/88U2+iMFTn7vjjcHL0XnXnwVA1dmAKSgX4ekrtswihg3z5cm2d2wrMU9IfNbjlKDM3pr/VELz3fSOjQS3Xvhmcq+AnoJFwcBIcT2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709626427; c=relaxed/simple;
	bh=M6R1j90M3k32rYmOsNRz+DEBTgw+1FZH15C/3hoRI2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M4PflkT1SKRJ8UODiJCqvG98atyLqF/+VcKtKS71HK33de03/mURkH8kYr8hnuxY4ZNHrRrPVT2KGw24YK3z/K0zXwMjqvfYRyHTahqHLAabtQDxst+QS4FS3gaIKiThkZ1yu1RpY+WPwcxrE0dGkbqM6Xh2SWQZ58GZZnM1GuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKtS0+7/; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-563bb51c36eso6968222a12.2;
        Tue, 05 Mar 2024 00:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709626424; x=1710231224; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U6Gt+EZBI4V/HhWzGjeVEQZx0KOM59T/cCWxCZH0Fog=;
        b=cKtS0+7/91yDwgpdHP49UZQbu3bqiqD6q6Pa7I9xuX44SSHBrr7/IWqAtv3V1x6i0o
         xSbBlHqhVan4/sLtdyJo9W11OpX7br8aApatndLFnBUznhTNWH62oZ7sshHlPVUrhEnQ
         iBM0ZcaKt7DlpnpMkRlVGI6+Ym7N1WfowOTtpf6SwzRMdKPxXAD+ZhZhRRh+cS20+mPP
         yTn8xn3TDLnTE/7QzEy5YPnCW6IR8Nt4ShE2kd3XEVGuzV78+qG8HyGzcOvlmCp7EO84
         ABXuQyi/y7ADH+5vOuNCQdz0AhaO/s2A8wsg55ci7qOMDMZ9U9xAgcdEruk+jIp9D48u
         us4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709626424; x=1710231224;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U6Gt+EZBI4V/HhWzGjeVEQZx0KOM59T/cCWxCZH0Fog=;
        b=emYYEb6I8djEvmIj4sW+GyZUbe1tgn+DcLov2apYC4ieYIm1MQyuN2HvQeshszfaHJ
         KdovCFLfHVdjIga2VxVKJQX7c5iDpJ1WBXJoPreMqxjTjReHdRyD7P5hrQJ/O2jZv7j7
         mzcWUbG6IDqoojo3QchRPPjl5IbTN84FDpkIl7OsmeemMUqSudzGKwJlMUwZYACdzDFl
         Q4eoieJgLS4B5VPRV9N8tbNxpl3wJvb4BaKol1W56qD+BhOZhGPppAAAJpPrXdi0P8ln
         SlN9jnaEWrOAXQti+0gxvT3zfeu8/2b3GMhIp99DOt8EH9vLVSNis39CUb/bsh+makuZ
         Y+8g==
X-Forwarded-Encrypted: i=1; AJvYcCUBuTiKDeMQ/fRW/Im0wi/ufmRJsCg4ZybH15FO0ztUWaOUpOQuNMX1/zNbHBTYd5cNRIMpaepxGxbftsP/sh6cTbHX5J/7NyV8T489BYVp8ptSNmEBr2CcLjcrffiWFHFrpA==
X-Gm-Message-State: AOJu0YzgHHE6z61s24f6QwpVSYAJt7MHSl69bXCDt9hIL/5kb7+fShq2
	vsTyj8UJh/K8WuCxWInWBfBTfN345TQI9yo1lq/NENLOikee8C9t
X-Google-Smtp-Source: AGHT+IFSXka5QRTVVh7RGlRx/C7VXpNGAUtA3mjCM/q3IE3fFiyxdf6wfIL/yk22A7KPke2zfIQJew==
X-Received: by 2002:a17:906:e0d6:b0:a45:5328:8432 with SMTP id gl22-20020a170906e0d600b00a4553288432mr3327229ejb.50.1709626423540;
        Tue, 05 Mar 2024 00:13:43 -0800 (PST)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id tk3-20020a170907c28300b00a3f20a8d2f6sm5733793ejc.112.2024.03.05.00.13.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 00:13:43 -0800 (PST)
Message-ID: <b27e44db-d9c5-49f0-8b81-2f55cfaacb4d@gmail.com>
Date: Tue, 5 Mar 2024 09:13:41 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 2/2] net: phy: air_en8811h: Add the Airoha
 EN8811H PHY driver
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Daniel Golle <daniel@makrotopia.org>, Lucien Jheng
 <lucien.jheng@airoha.com>, Zhi-Jun You <hujy652@protonmail.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
References: <20240302183835.136036-1-ericwouds@gmail.com>
 <20240302183835.136036-3-ericwouds@gmail.com>
 <89f237e0-75d4-4690-9d43-903e087e4f46@lunn.ch>
Content-Language: en-US
From: Eric Woudstra <ericwouds@gmail.com>
In-Reply-To: <89f237e0-75d4-4690-9d43-903e087e4f46@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


Hi Andrew,

First of all, thanks for taking the time to look at the code so
extensively.

On 3/3/24 18:29, Andrew Lunn wrote:
>> +enum {
>> +	AIR_PHY_LED_DUR_BLINK_32M,
>> +	AIR_PHY_LED_DUR_BLINK_64M,
>> +	AIR_PHY_LED_DUR_BLINK_128M,
>> +	AIR_PHY_LED_DUR_BLINK_256M,
>> +	AIR_PHY_LED_DUR_BLINK_512M,
>> +	AIR_PHY_LED_DUR_BLINK_1024M,
> 
> DUR meaning duration? It has a blinks on for a little over a
> kilometre? So a wave length of a little over 2 kilometres, or a
> frequency of around 0.0005Hz :-)

It is the M for milliseconds. I can add a comment to clarify this.
If you set to 1024M, it will blink with a period of a roughly 1 second.

>> +static int __air_buckpbus_reg_write(struct phy_device *phydev,
>> +				    u32 pbus_address, u32 pbus_data,
>> +				    bool set_mode)
>> +{
>> +	int ret;
>> +
>> +	if (set_mode) {
>> +		ret = __phy_write(phydev, AIR_BPBUS_MODE,
>> +				  AIR_BPBUS_MODE_ADDR_FIXED);
>> +		if (ret < 0)
>> +			return ret;
>> +	}
> 
> What does set_mode mean?

I use this boolean to prevent writing the same value twice to the
AIR_BPBUS_MODE register, when doing an atomic modify operation. The
AIR_BPBUS_MODE is already set in the read operation, so it does not
need to be set again to the same value at the write operation.
Sadly, the address registers for read and write are different, so
I could not optimize the modify operation any more.

>> +static int en8811h_load_firmware(struct phy_device *phydev)
>> +{
>> +	struct device *dev = &phydev->mdio.dev;
>> +	const struct firmware *fw1, *fw2;
>> +	int ret;
>> +
>> +	ret = request_firmware_direct(&fw1, EN8811H_MD32_DM, dev);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret = request_firmware_direct(&fw2, EN8811H_MD32_DSP, dev);
>> +	if (ret < 0)
>> +		goto en8811h_load_firmware_rel1;
>> +
> 
> How big are these firmwares? This will map the entire contents into
> memory. There is an alternative interface which allows you to get the
> firmware in chunks. I the firmware is big, just getting 4K at a time
> might be better, especially if this is an OpenWRT class device.

The file sizes are 131072 and 16384 bytes. If you think this is too big,
I could look into using the alternative interface.

>> +static int en8811h_restart_host(struct phy_device *phydev)
>> +{
>> +	int ret;
>> +
>> +	ret = air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
>> +				     EN8811H_FW_CTRL_1_START);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
>> +				     EN8811H_FW_CTRL_1_FINISH);
>> +}
> 
> What is host in this context?

This is the EN8811H internal host to the PHY.

> Vendors do like making LED control unique. I've not seen any other MAC
> or PHY where you can blink for activity at a given speed. You cannot
> have 10 and 100 at the same time, so why are there different bits for
> them?
> 
> I _think_ this can be simplified
> ...
> Does this work?

I started out with that, but the hardware can do more. It allows
for a setup as described:

 100M link up triggers led0, only led0 blinking on traffic
1000M link up triggers led1, only led1 blinking on traffic
2500M link up triggers led0 and led1, both blinking on traffic

#define AIR_DEFAULT_TRIGGER_LED0 (BIT(TRIGGER_NETDEV_LINK_2500) | \
				 BIT(TRIGGER_NETDEV_LINK_100)  | \
				 BIT(TRIGGER_NETDEV_RX)        | \
				 BIT(TRIGGER_NETDEV_TX))
#define AIR_DEFAULT_TRIGGER_LED1 (BIT(TRIGGER_NETDEV_LINK_2500) | \
				 BIT(TRIGGER_NETDEV_LINK_1000) | \
				 BIT(TRIGGER_NETDEV_RX)        | \
				 BIT(TRIGGER_NETDEV_TX))

With the simpler code and just the slightest traffic, both leds
are blinking and no way to read the speed anymore from the leds.

So I modified it to make the most use of the possibilities of the
EN881H hardware. The EN8811H can then be used with a standard 2-led
rj45 socket.

