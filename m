Return-Path: <netdev+bounces-78479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D023875476
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 17:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00D9F284C40
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 16:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F53912FF7D;
	Thu,  7 Mar 2024 16:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3NO9kW9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C341B12F59B;
	Thu,  7 Mar 2024 16:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709830144; cv=none; b=o0ytPi7a01qDsWyeKZ25V4Ksp3oqNjakmuCIOwxRVi4PIzkcrHonaTztoZ4Ys15PFsZkB/EpaTpY+FrDvtFwj76DEQA226NgSg2lvHeAsDzo7gaQuDGTPtJBlemtG5T4WGPmnV0vzXR3tNP6VWot3OCWEwl0aK2G1ed4kW/qV2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709830144; c=relaxed/simple;
	bh=IV04XMutDqMAi27h60naVerg2jYHbb6d6Ibqs6QXWDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MCUyk35k2AQ5x4grLbSu7LElKEYvGI1737ck6yHhctCCJkVcUXWtkdJ6QikwPs1gIVml4nNfOBNRt1pvcRLQ528MP0C9yP/qlxN0Kc4kNes22SJdc7JYswgM1ZnkdweBTbTMWInoBhbMcGVusk5V7TyziSDS9Q05Kze7+muFhWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3NO9kW9; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a441d7c6125so127360166b.2;
        Thu, 07 Mar 2024 08:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709830141; x=1710434941; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1XwLtyvBA6RDV5qqCSNmuKb5cUB038y/Fs8OWv6CO+I=;
        b=T3NO9kW96O4pfopNeWtJpBcYknPrsjxK85tgioEGdRtQriM1CpGwZV+GxUvEriBZzJ
         mDojXmWZwzechVly9pv8RYm3JNrM0SqzAhuG5aaEeJR83HrdbMLLyF3ssHUJkKCrDpql
         GlJZ7FCB189RzsOSZiihDXUPAKVhT4u3NfgLqdcHhnZdq9NooJaDCeCLE9CWKjh+fhzo
         7gTw+05aKHeuAPfsR1tpo+jRVZ6X7mVzkH2VNXqDGyZhq4zVj+rIJuA2XLGtBozgMzu2
         ze8bjMmJaARiu+wDvLoEkqq1gtHIki0H/udEoUK4Pn2tepqwoJSxen7k5QHZVnGgse3/
         O2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709830141; x=1710434941;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1XwLtyvBA6RDV5qqCSNmuKb5cUB038y/Fs8OWv6CO+I=;
        b=VAbMPKSQy4S5UaZvSZpCeHzmXptrlrD14iGvEF/czECaqaol/sKazwLsiYh2wwWmeT
         x+Ho7v+j3njAwcW+d5K/yZ+7o7aNngaodlU7EY4dXOHYRCOotmZ/x6AZA+iqnHX4H4bb
         TRLMoyIwEdnqV8GieWNlve69JwMFP0rmEjuHHBfhiFumFDPMZZIup8yLLUi8CdtTL6Ps
         +4IGFYXn6cTSChEUdMpBTvqQxtc7DSlM5mgsKKjYr647UT4h8baoKJ0QQqEKb+u8tZIQ
         Dpo9C9z+Jwm22Ji8KgdXfT+N5GVoBYRsBa3VkOrFUZTAokTs57qw6OS5BQ0VRx1XfDOo
         u1tg==
X-Forwarded-Encrypted: i=1; AJvYcCV654/cJFMQl8cWJZFcY0F/tWfsMe1FupGVxdOQenSsvOrDwtyPbWrJ5l9aySIPbSxpS0ptKMdRgAZ/+28COw9Er3kqmEIdMrb24sXFJU7um7rM636a3KkSIP+7JUrjCYQaUw==
X-Gm-Message-State: AOJu0YxE5Nv8JXwH/uYFPZHeTu28eieG/WxW6QN8qej+xJCQM60jWiz7
	e2vS5LI6Cf/uqI2YXhX3O178gUL6NmE9w5vH0Vjfzp6NBCHEUbL3
X-Google-Smtp-Source: AGHT+IHT8E+D1Qa4UDaI8Mcx/e5WQOgcxjqNulcWb7sXqRpu7+ZJUkgg2NC83SoZBfZGeKGl22SHUA==
X-Received: by 2002:a17:906:6d11:b0:a45:c4ca:57a1 with SMTP id m17-20020a1709066d1100b00a45c4ca57a1mr2698695ejr.22.1709830140459;
        Thu, 07 Mar 2024 08:49:00 -0800 (PST)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id w8-20020a170906b18800b00a43fe2d3062sm8457173ejy.158.2024.03.07.08.48.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 08:48:59 -0800 (PST)
Message-ID: <6e6e408d-3dbb-4e80-ae27-d3aaafb34b06@gmail.com>
Date: Thu, 7 Mar 2024 17:48:56 +0100
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
 <b27e44db-d9c5-49f0-8b81-2f55cfaacb4d@gmail.com>
 <99541533-625e-4ffb-b980-b2bcd016cfeb@lunn.ch>
Content-Language: en-US
From: Eric Woudstra <ericwouds@gmail.com>
In-Reply-To: <99541533-625e-4ffb-b980-b2bcd016cfeb@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/5/24 14:54, Andrew Lunn wrote:
> On Tue, Mar 05, 2024 at 09:13:41AM +0100, Eric Woudstra wrote:
>>
>> Hi Andrew,
>>
>> First of all, thanks for taking the time to look at the code so
>> extensively.
>>
>> On 3/3/24 18:29, Andrew Lunn wrote:
>>>> +enum {
>>>> +	AIR_PHY_LED_DUR_BLINK_32M,
>>>> +	AIR_PHY_LED_DUR_BLINK_64M,
>>>> +	AIR_PHY_LED_DUR_BLINK_128M,
>>>> +	AIR_PHY_LED_DUR_BLINK_256M,
>>>> +	AIR_PHY_LED_DUR_BLINK_512M,
>>>> +	AIR_PHY_LED_DUR_BLINK_1024M,
>>>
>>> DUR meaning duration? It has a blinks on for a little over a
>>> kilometre? So a wave length of a little over 2 kilometres, or a
>>> frequency of around 0.0005Hz :-)
>>
>> It is the M for milliseconds. I can add a comment to clarify this.
> 
> Or just add an S. checkpatch does not like camElcAse. So ms will call
> a warning. But from context we know it is not mega seconds.

I'll add it.

>>>> +static int __air_buckpbus_reg_write(struct phy_device *phydev,
>>>> +				    u32 pbus_address, u32 pbus_data,
>>>> +				    bool set_mode)
>>>> +{
>>>> +	int ret;
>>>> +
>>>> +	if (set_mode) {
>>>> +		ret = __phy_write(phydev, AIR_BPBUS_MODE,
>>>> +				  AIR_BPBUS_MODE_ADDR_FIXED);
>>>> +		if (ret < 0)
>>>> +			return ret;
>>>> +	}
>>>
>>> What does set_mode mean?
>>
>> I use this boolean to prevent writing the same value twice to the
>> AIR_BPBUS_MODE register, when doing an atomic modify operation. The
>> AIR_BPBUS_MODE is already set in the read operation, so it does not
>> need to be set again to the same value at the write operation.
>> Sadly, the address registers for read and write are different, so
>> I could not optimize the modify operation any more.
> 
> So there is the potential to have set_mode true when not actually
> performing a read/modify/write. Maybe have a dedicated modify
> function, and don't expose set_mode?

I'll write a dedicated modify function.


>>>> +static int en8811h_load_firmware(struct phy_device *phydev)
>>>> +{
>>>> +	struct device *dev = &phydev->mdio.dev;
>>>> +	const struct firmware *fw1, *fw2;
>>>> +	int ret;
>>>> +
>>>> +	ret = request_firmware_direct(&fw1, EN8811H_MD32_DM, dev);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +
>>>> +	ret = request_firmware_direct(&fw2, EN8811H_MD32_DSP, dev);
>>>> +	if (ret < 0)
>>>> +		goto en8811h_load_firmware_rel1;
>>>> +
>>>
>>> How big are these firmwares? This will map the entire contents into
>>> memory. There is an alternative interface which allows you to get the
>>> firmware in chunks. I the firmware is big, just getting 4K at a time
>>> might be better, especially if this is an OpenWRT class device.
>>
>> The file sizes are 131072 and 16384 bytes. If you think this is too big,
>> I could look into using the alternative interface.
> 
> What class of device is this? 128K for a PC is nothing. For an OpenWRT
> router with 128M of RAM, it might be worth using the other API.

So far, I only know of the BananaPi-R3mini, which I am using. It has 2GB
of ram. It should be ok.

>>>> +static int en8811h_restart_host(struct phy_device *phydev)
>>>> +{
>>>> +	int ret;
>>>> +
>>>> +	ret = air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
>>>> +				     EN8811H_FW_CTRL_1_START);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +
>>>> +	return air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
>>>> +				     EN8811H_FW_CTRL_1_FINISH);
>>>> +}
>>>
>>> What is host in this context?
>>
>> This is the EN8811H internal host to the PHY.
> 
> That is a very PHY centric view of the world. I would say the host is
> what is running Linux. I assume this is the datahsheets naming? Maybe
> cpu, or mcu is a better name?

I'll rename host to mcu.

>>> Vendors do like making LED control unique. I've not seen any other MAC
>>> or PHY where you can blink for activity at a given speed. You cannot
>>> have 10 and 100 at the same time, so why are there different bits for
>>> them?
>>>
>>> I _think_ this can be simplified
>>> ...
>>> Does this work?
>>
>> I started out with that, but the hardware can do more. It allows
>> for a setup as described:
>>
>>  100M link up triggers led0, only led0 blinking on traffic
>> 1000M link up triggers led1, only led1 blinking on traffic
>> 2500M link up triggers led0 and led1, both blinking on traffic
>>
>> #define AIR_DEFAULT_TRIGGER_LED0 (BIT(TRIGGER_NETDEV_LINK_2500) | \
>> 				 BIT(TRIGGER_NETDEV_LINK_100)  | \
>> 				 BIT(TRIGGER_NETDEV_RX)        | \
>> 				 BIT(TRIGGER_NETDEV_TX))
>> #define AIR_DEFAULT_TRIGGER_LED1 (BIT(TRIGGER_NETDEV_LINK_2500) | \
>> 				 BIT(TRIGGER_NETDEV_LINK_1000) | \
>> 				 BIT(TRIGGER_NETDEV_RX)        | \
>> 				 BIT(TRIGGER_NETDEV_TX))
>>
>> With the simpler code and just the slightest traffic, both leds
>> are blinking and no way to read the speed anymore from the leds.
>>
>> So I modified it to make the most use of the possibilities of the
>> EN881H hardware. The EN8811H can then be used with a standard 2-led
>> rj45 socket.
> 
> The idea is that we first have Linux blink the LEDs in software. This
> is controlled via the files in /sys/class/leds/FOO/{link|rx|tx}
> etc. If the hardware can do the same blink pattern, it can then be
> offloaded to the hardware.
> 
> If you disable hardware offload, just have set brightness, can you do
> the same pattern?
> 
> As i said, vendors do all sorts of odd things with LEDs. I would
> prefer we have a common subset most PHY support, and not try to
> support every strange mode.

Then I will keep this part of the code as in
mt798x_phy_led_hw_control_set(), only adding 2500Mbps.

>>> +	/* Select mode 1, the only mode supported */
> 
>> Maybe a comment about what mode 1 actually is?

After consulting Airoha, I can change it to:

+	/* Select mode 1, the only mode supported.
+	 * The en8811h configures the SerDes as fixed hsgmii.
+	 */

Best Regards,

Eric Woudstra

