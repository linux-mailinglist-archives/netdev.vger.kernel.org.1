Return-Path: <netdev+bounces-131731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE9398F5CB
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 20:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1A501C21F28
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 18:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1431AAE2B;
	Thu,  3 Oct 2024 18:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBljbog8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF361A7040;
	Thu,  3 Oct 2024 18:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727978723; cv=none; b=QlhdGHNsIge6T+whSzUOD5EmyZroFM6PCUPKhkZLnhat4LGnmXkjpiz95wEZ9pbPhltDKht5ymyQuob7OLjn52rH6H5mltYxogKCbaAuh5/oxd4J4YfZPxpR8+l6SXiPPyqn3RmwJzbiNMtJU6CiJOFpaJxl7mgOke+KaITp1tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727978723; c=relaxed/simple;
	bh=nso4VobZVcym9uuf72JSoZHmpyq74ra8SZYn85l2xAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b0c5TQqT+AUfCfpCIfYOM5JNaXpvnZawmX9XYoz7c34ht8vdyetL2oe+1wUk3uGylRwDdpGlQ2Ev4BjJOTlBGfSKrpDNom07TSYf1d9CnE7SEOEOkkGl47MCojsfbndPzlA/VNo690LNxR4KsYComgTvCUkFViCGy7JYKb6q5wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBljbog8; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e053f42932so989270a91.0;
        Thu, 03 Oct 2024 11:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727978721; x=1728583521; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=o92uYrwec6jf8i8PpiNeLzM9ef8AjMR3k4pCwlPLJiI=;
        b=aBljbog8q1UP6bPO6wGzhtmFKarNstllryDwV0wPAEsobJlPnovglAxpOrdyva82XQ
         xL85BDE2N07EE86FD/TwRYE81nfd6K3dlsmnc/Q+j6eXvK5pI6tgFoLfTTI2WbjO0dp9
         qNeSTJJ8l8Hc3dwW6D6EkSxezjmRs38fUBixsA36JXTqT9cwUuwzk5GERAS0G2q0sBGG
         Xad23HT29YYbi6TtMFZwzEDQIIRW07asw2bB7XcNcyr59yedk6s4BsQYVITNeTWUyyuS
         8wzmIqK5htmuwcUPI3JXcVjfLwjezr87ai6Ak2tcdA78N+39xmg9fFaCgvh8s7B+jgkc
         xALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727978721; x=1728583521;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o92uYrwec6jf8i8PpiNeLzM9ef8AjMR3k4pCwlPLJiI=;
        b=S0ajTPOJmIfJ5I4QMA3EwAaDvkNksSOUsrwmTVixgXbVc8lz12Xr0gcQlU5eTlt5Cn
         8kxqsACuRflGkrv0wT51wRsFkIQuDa7ignUjyAe/lyLhXJ6gQ5dU6+F2RpPFRmdQQT+Y
         A+HrAsANiClEDzQT8+As10FxMQmcEo4GZscpeXdu/Qq3rkqNX/ayjjoxmx+ma2VZlYyH
         qLaBxU5K+haoa7IZc3Pv1I0hGNCPu8PnB1WBWpMt0lTKhyRvbfwpMYcbNmfX2Vgu3Uz8
         prNYIkxDyWtL+XehK1v+8HN9jxd6UFUmWWjUyyCoe8UaVie4jGITIHTSdQopkMBYtjd6
         y6nQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHufSdHjpB5t3lTBJSO9t+OOHJNNswPtPBkWmbDzt/Ld4+V2Q7XmDfFNP8oDh01hdoVeXFA7NagYIKLQ==@vger.kernel.org, AJvYcCWfSPMcGmxYj1JsvoLgxBlT8nxUhxGhQjkW+KFR+O2Blueq5kUmrM/wi42Pln9LyRMtTC4GGAa+@vger.kernel.org
X-Gm-Message-State: AOJu0YyctcDy3GnZrM4ISg4CgTG3A9yKuuL1tis6Ji8Z9YiXj3GXqFxp
	VoBnZmkqo0GwN0tWawgQIOMTgNI/6C0yhQZ6+xvb/32ZghzI8NGx
X-Google-Smtp-Source: AGHT+IF9K2HBCJ/TF2IBchNFbWtwdfZWPfqb2ywqILuL4T3bshkgHupiJOS95MlwH82ssTxq8N5ayQ==
X-Received: by 2002:a17:90b:3b8c:b0:2d8:8f24:bd88 with SMTP id 98e67ed59e1d1-2e18466dac6mr8548154a91.14.1727978720578;
        Thu, 03 Oct 2024 11:05:20 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1bfad5df6sm1992628a91.1.2024.10.03.11.05.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 11:05:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a8483822-fa75-4f73-882b-ce7b69a98752@roeck-us.net>
Date: Thu, 3 Oct 2024 11:05:17 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] eth: fbnic: Add hardware monitoring support
 via HWMON interface
To: Sanman Pradhan <sanman.p211993@gmail.com>, netdev@vger.kernel.org
Cc: alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 jdelvare@suse.com, horms@kernel.org, mohsin.bashr@gmail.com,
 sanmanpradhan@meta.com, andrew@lunn.ch, linux-hwmon@vger.kernel.org
References: <20241003173618.2479520-1-sanman.p211993@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20241003173618.2479520-1-sanman.p211993@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/3/24 10:36, Sanman Pradhan wrote:
> From: Sanman Pradhan <sanmanpradhan@meta.com>
> 
> This patch adds support for hardware monitoring to the fbnic driver,
> allowing for temperature and voltage sensor data to be exposed to
> userspace via the HWMON interface. The driver registers a HWMON device
> and provides callbacks for reading sensor data, enabling system
> admins to monitor the health and operating conditions of fbnic.
> 
> Signed-off-by: Sanman Pradhan <sanmanpradhan@meta.com>
> 
> ---
> v2:
>    - Refined error handling in hwmon registration
>    - Improve error handling and logging for hwmon device registration failures
> 
> v1: https://lore.kernel.org/netdev/153c5be4-158e-421a-83a5-5632a9263e87@roeck-us.net/T/
> 
> ---
>   drivers/net/ethernet/meta/fbnic/Makefile      |  1 +
>   drivers/net/ethernet/meta/fbnic/fbnic.h       |  4 +
>   drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c | 80 +++++++++++++++++++
>   drivers/net/ethernet/meta/fbnic/fbnic_mac.h   |  7 ++
>   drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |  8 +-
>   5 files changed, 99 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c
> 
> diff --git a/drivers/net/ethernet/meta/fbnic/Makefile b/drivers/net/ethernet/meta/fbnic/Makefile
> index ed4533a73c57..41494022792a 100644
> --- a/drivers/net/ethernet/meta/fbnic/Makefile
> +++ b/drivers/net/ethernet/meta/fbnic/Makefile
> @@ -11,6 +11,7 @@ fbnic-y := fbnic_devlink.o \
>   	   fbnic_ethtool.o \
>   	   fbnic_fw.o \
>   	   fbnic_hw_stats.o \
> +	   fbnic_hwmon.o \
>   	   fbnic_irq.o \
>   	   fbnic_mac.o \
>   	   fbnic_netdev.o \
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
> index 0f9e8d79461c..2d3aa20bc876 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic.h
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
> @@ -18,6 +18,7 @@
>   struct fbnic_dev {
>   	struct device *dev;
>   	struct net_device *netdev;
> +	struct device *hwmon;
> 
>   	u32 __iomem *uc_addr0;
>   	u32 __iomem *uc_addr4;
> @@ -127,6 +128,9 @@ void fbnic_devlink_unregister(struct fbnic_dev *fbd);
>   int fbnic_fw_enable_mbx(struct fbnic_dev *fbd);
>   void fbnic_fw_disable_mbx(struct fbnic_dev *fbd);
> 
> +void fbnic_hwmon_register(struct fbnic_dev *fbd);
> +void fbnic_hwmon_unregister(struct fbnic_dev *fbd);
> +
>   int fbnic_pcs_irq_enable(struct fbnic_dev *fbd);
>   void fbnic_pcs_irq_disable(struct fbnic_dev *fbd);
> 
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c b/drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c
> new file mode 100644
> index 000000000000..0ff9c85f08eb
> --- /dev/null
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c
> @@ -0,0 +1,80 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) Meta Platforms, Inc. and affiliates. */
> +
> +#include <linux/hwmon.h>
> +
> +#include "fbnic.h"
> +#include "fbnic_mac.h"
> +
> +static int fbnic_hwmon_sensor_id(enum hwmon_sensor_types type)
> +{
> +	if (type == hwmon_temp)
> +		return FBNIC_SENSOR_TEMP;
> +	if (type == hwmon_in)
> +		return FBNIC_SENSOR_VOLTAGE;
> +
> +	return -EOPNOTSUPP;
> +}
> +
> +static umode_t fbnic_hwmon_is_visible(const void *drvdata,
> +				      enum hwmon_sensor_types type,
> +				      u32 attr, int channel)
> +{
> +	if (type == hwmon_temp && attr == hwmon_temp_input)
> +		return 0444;
> +	if (type == hwmon_in && attr == hwmon_in_input)
> +		return 0444;
> +
> +	return 0;
> +}
> +
> +static int fbnic_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
> +			    u32 attr, int channel, long *val)
> +{
> +	struct fbnic_dev *fbd = dev_get_drvdata(dev);
> +	const struct fbnic_mac *mac = fbd->mac;
> +	int id;
> +
> +	return id < 0 ? id : mac->get_sensor(fbd, id, val);

How does this work ? Unless I am missing something, "id" is not initialized.

Guenter

> +}
> +
> +static const struct hwmon_ops fbnic_hwmon_ops = {
> +	.is_visible = fbnic_hwmon_is_visible,
> +	.read = fbnic_hwmon_read,
> +};
> +
> +static const struct hwmon_channel_info *fbnic_hwmon_info[] = {
> +	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
> +	HWMON_CHANNEL_INFO(in, HWMON_I_INPUT),
> +	NULL
> +};
> +
> +static const struct hwmon_chip_info fbnic_chip_info = {
> +	.ops = &fbnic_hwmon_ops,
> +	.info = fbnic_hwmon_info,
> +};
> +
> +void fbnic_hwmon_register(struct fbnic_dev *fbd)
> +{
> +	if (!IS_REACHABLE(CONFIG_HWMON))
> +		return;
> +
> +	fbd->hwmon = hwmon_device_register_with_info(fbd->dev, "fbnic",
> +						     fbd, &fbnic_chip_info,
> +						     NULL);
> +	if (IS_ERR(fbd->hwmon)) {
> +		dev_notice(fbd->dev,
> +			   "Failed to register hwmon device %pe\n",
> +			fbd->hwmon);
> +		fbd->hwmon = NULL;
> +	}
> +}
> +
> +void fbnic_hwmon_unregister(struct fbnic_dev *fbd)
> +{
> +	if (!IS_REACHABLE(CONFIG_HWMON) || !fbd->hwmon)
> +		return;
> +
> +	hwmon_device_unregister(fbd->hwmon);
> +	fbd->hwmon = NULL;
> +}
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.h b/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
> index 476239a9d381..05a591653e09 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
> @@ -47,6 +47,11 @@ enum {
>   #define FBNIC_LINK_MODE_PAM4	(FBNIC_LINK_50R1)
>   #define FBNIC_LINK_MODE_MASK	(FBNIC_LINK_AUTO - 1)
> 
> +enum fbnic_sensor_id {
> +	FBNIC_SENSOR_TEMP,		/* Temp in millidegrees Centigrade */
> +	FBNIC_SENSOR_VOLTAGE,		/* Voltage in millivolts */
> +};
> +
>   /* This structure defines the interface hooks for the MAC. The MAC hooks
>    * will be configured as a const struct provided with a set of function
>    * pointers.
> @@ -83,6 +88,8 @@ struct fbnic_mac {
> 
>   	void (*link_down)(struct fbnic_dev *fbd);
>   	void (*link_up)(struct fbnic_dev *fbd, bool tx_pause, bool rx_pause);
> +
> +	int (*get_sensor)(struct fbnic_dev *fbd, int id, long *val);
>   };
> 
>   int fbnic_mac_init(struct fbnic_dev *fbd);
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
> index a4809fe0fc24..633a9aa39fe2 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
> @@ -289,6 +289,8 @@ static int fbnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> 
>   	fbnic_devlink_register(fbd);
> 
> +	fbnic_hwmon_register(fbd);
> +
>   	if (!fbd->dsn) {
>   		dev_warn(&pdev->dev, "Reading serial number failed\n");
>   		goto init_failure_mode;
> @@ -297,7 +299,7 @@ static int fbnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   	netdev = fbnic_netdev_alloc(fbd);
>   	if (!netdev) {
>   		dev_err(&pdev->dev, "Netdev allocation failed\n");
> -		goto init_failure_mode;
> +		goto ifm_hwmon_unregister;
>   	}
> 
>   	err = fbnic_netdev_register(netdev);
> @@ -308,6 +310,8 @@ static int fbnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> 
>   	return 0;
> 
> +ifm_hwmon_unregister:
> +	fbnic_hwmon_unregister(fbd);
>   ifm_free_netdev:
>   	fbnic_netdev_free(fbd);
>   init_failure_mode:
> @@ -345,6 +349,7 @@ static void fbnic_remove(struct pci_dev *pdev)
>   		fbnic_netdev_free(fbd);
>   	}
> 
> +	fbnic_hwmon_unregister(fbd);
>   	fbnic_devlink_unregister(fbd);
>   	fbnic_fw_disable_mbx(fbd);
>   	fbnic_free_irqs(fbd);
> @@ -428,6 +433,7 @@ static int __fbnic_pm_resume(struct device *dev)
>   	rtnl_unlock();
> 
>   	return 0;
> +
>   err_disable_mbx:
>   	rtnl_unlock();
>   	fbnic_fw_disable_mbx(fbd);
> --
> 2.43.5


