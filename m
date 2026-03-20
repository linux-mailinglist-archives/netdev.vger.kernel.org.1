Return-Path: <netdev+bounces-269906-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iC+ILtw7vWkH8AIAu9opvQ
	(envelope-from <netdev+bounces-269906-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 13:21:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8ED62DA162
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 13:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 32CBE300D54C
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 12:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992073AC0D6;
	Fri, 20 Mar 2026 12:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIktvUeW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C44248873
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 12:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774009299; cv=none; b=tYe6Tq6UVmZyvRdxMC52rKthoInc560MTf9mNYhN7McnJpKUIO5iv4JnDMxIbF3canf2uhV9iym5QpcZqV2xsEMolMUd0xe7UTvDgogqKJVWLX6xEOM6N7PejEyYXxYAm0en7rlIuFfu8DF8G4qCyipwuAZrZuv8ypPDOFcH538=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774009299; c=relaxed/simple;
	bh=ykocg146Do2pEWysqYkydaVeCQLhtlf6ZIEbVFr8ff4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RIDRTN4X6S7oHLU/TPhwc9uLmsCUlJ45Zj7htfTXerBd0+CgtfTLF5Ap0DfZkUqC0pVxOwQRCfKdaAfPffPViWBswnzzbyOTyDqNiRRcbRcXxSfzOup2G71YSIhC03hbLQbeAU9QbVIvwbxNkjkSucQZ2TWtoykqPuDSUN7apao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kIktvUeW; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so3751087eec.1
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 05:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774009296; x=1774614096; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=rTnsliriz9CfNRUwq9oMEwFIbuR4aChiZL67F1kmMW4=;
        b=kIktvUeWxxSkiT6dFH2krg+UlowwEscpBMwKlcu8wXdXfVWcYBnupiFqOjZdCbFtVw
         lEMfOiA5HbJx0VrAz1nAU0fYgYMlRoQOmPDjxeeplg9yY51Ju9yCorpO2YIldu3hP0b5
         JSqdh3i7NhuJwnAGykiCqh1rKAND0l3raceSFllnLKWskw0JWXzOg22yLQcpJeDFqOhb
         e92EMSbqhObp1eC/SagnXhUrteqfa/NLfFvceZodGXjo6p9A86LdWoI5dsMM/Q8INvgM
         gi5A9lN4VN+9SE0+5jGGxj/87SAisYyJ4Xl5Oj74NeAw6rU75iVU79rk9N8/D6XVfy54
         f1xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774009296; x=1774614096;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rTnsliriz9CfNRUwq9oMEwFIbuR4aChiZL67F1kmMW4=;
        b=m1dKjz1h4s2iWPWE92rDAiQMDf7vth2zsIYLfiGZagvykqu9VCpVrNCtLvSBjHSaDs
         GMHAPmMeBaO2atRAOeglR4GZHT6fHaLdu2Y3vH1OFuvCm200Lr43J2rkUMDQ3tzWzU9i
         4khygY81ral/cJ32djzermwJw4CXUFx93+UK9DEV8nvvqDJOe7WP4dzSIxSxXentLnBl
         x0z8iiLy/+P2btpW7c3vyV+XZjrz9Bubqt0cvVaHekpBDjL47mcot7cSdy1RTzQsI7H5
         eB6jWPdh7gQ163Lxi9l8WLLiWhWWBpX6pluAfhEtQwFTaW+1l19m+O0py3urEfYTbbyb
         gp5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWBgfPc9yeqP8pqvnxx2c6Kcp3K2l0pGL9utkeh18iyA79tdN4cdTpBOM+5IRiVgX5rUEJGR2o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6ypWA7E+j58slPnZcGn6WEQZmW4Vdb/zSafJoXhmT+eJcfXyB
	oZp6fgo5OYDg27LG3zqp5gs6nSZGUsDzS0yRkgzFfRZNLqQFN9AhSrgh
X-Gm-Gg: ATEYQzyQDQHud1UmaT2Z6wB6VrXvq18PpkfMLSokX2v23r3R3+hBYPrxaCmXGCG7x2M
	h8S32yejq7uVrvL3up+1ybqhZLsBmeww3bqYOyevBGgd3GTHdQAc89dvF4uzA1z6itd8QV+7PJc
	F6CGq7ZINBOc1XvwcTGpWMfFuFFvLX+tW8LJjdNtbEPcBVH3wv5BVPpkAMw1MfgrzArQwzhehqL
	WP1u93350mZbxg9ylhmWS5WRuqL0Tg7E+KWZTBW2btnJJ6MUi0OjQRKAT+1k8qBOEb1BXTLuxLA
	cMrh7pTS9CgK08+bfO0PCOANBIcusiS2Ctizu1nvAFo9epLnIkxdF2g4Du/7vqc9hafZiT1XL+2
	BP9DgRNdJWPYKPzKmtTNiLF99q8tBOJfc0pE1Ms4ygszme+m9wha66WI2yssgQEegiOuCssNfxD
	KTWYXxNXU1BEyAt0oriUKcCQlBHjvycO4NrT2UYZUfDXkFFn5aWSjpWSFcIOE+dpqkfVf1emXt
X-Received: by 2002:a05:7300:bc08:b0:2be:a2d8:e9e3 with SMTP id 5a478bee46e88-2c1097bff99mr1487868eec.29.1774009295865;
        Fri, 20 Mar 2026 05:21:35 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b14cadbsm3498874eec.3.2026.03.20.05.21.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 05:21:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <964752ec-8e6d-444a-aad0-80da3acb2dab@roeck-us.net>
Date: Fri, 20 Mar 2026 05:21:33 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] dpll: zl3073x: add hwmon support for input
 reference frequencies
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>,
 Petr Oros <poros@redhat.com>, Simon Horman <horms@kernel.org>
References: <20260320105915.149068-1-ivecera@redhat.com>
 <20260320105915.149068-4-ivecera@redhat.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260320105915.149068-4-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269906-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DMARC_NA(0.00)[roeck-us.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,netdev@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: B8ED62DA162
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/20/26 03:59, Ivan Vecera wrote:
> Expose measured input reference frequencies via the hwmon interface
> using custom sysfs attributes (freqN_input and freqN_label) since
> hwmon has no native frequency sensor type. The frequency values are
> read from the cached measurements updated by the periodic work thread.
> 
> Cache the device ready state in struct zl3073x_dev so that
> freq_input_show() can return -ENODATA without an I2C access when
> the device firmware is not configured.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

"frequency" is not a hardware monitoring attribute. I understand that it is
convenient to report it as one, and that other drivers implement it as well,
but that doesn't change that.

I understand that the code lives outside the hardware monitoring subsystem and is
thus not in control of its maintainers, so you can essentially do whatever you want,
even if it is wrong. That doesn't change the fact that it is wrong.

However, do _not_ try to add it into the official list of hardware monitoring
attributes. I would NACK that.

Guenter

> ---
>   drivers/dpll/zl3073x/core.c  |  4 +-
>   drivers/dpll/zl3073x/core.h  |  2 +
>   drivers/dpll/zl3073x/hwmon.c | 86 +++++++++++++++++++++++++++++++++++-
>   3 files changed, 90 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
> index 67e65f8e7e7d4..5805f87167c20 100644
> --- a/drivers/dpll/zl3073x/core.c
> +++ b/drivers/dpll/zl3073x/core.c
> @@ -874,7 +874,9 @@ int zl3073x_dev_start(struct zl3073x_dev *zldev, bool full)
>   		return rc;
>   	}
>   
> -	if (!FIELD_GET(ZL_INFO_READY, info)) {
> +	zldev->ready = !!FIELD_GET(ZL_INFO_READY, info);
> +
> +	if (!zldev->ready) {
>   		/* The ready bit indicates that the firmware was successfully
>   		 * configured and is ready for normal operation. If it is
>   		 * cleared then the configuration stored in flash is wrong
> diff --git a/drivers/dpll/zl3073x/core.h b/drivers/dpll/zl3073x/core.h
> index 99440620407da..a416b8a65f41b 100644
> --- a/drivers/dpll/zl3073x/core.h
> +++ b/drivers/dpll/zl3073x/core.h
> @@ -48,6 +48,7 @@ struct zl3073x_chip_info {
>    * @regmap: regmap to access device registers
>    * @info: detected chip info
>    * @multiop_lock: to serialize multiple register operations
> + * @ready: true if device firmware is configured and ready for normal operation
>    * @ref: array of input references' invariants
>    * @out: array of outs' invariants
>    * @synth: array of synths' invariants
> @@ -63,6 +64,7 @@ struct zl3073x_dev {
>   	struct regmap			*regmap;
>   	const struct zl3073x_chip_info	*info;
>   	struct mutex			multiop_lock;
> +	bool				ready;
>   
>   	/* Invariants */
>   	struct zl3073x_ref	ref[ZL3073X_NUM_REFS];
> diff --git a/drivers/dpll/zl3073x/hwmon.c b/drivers/dpll/zl3073x/hwmon.c
> index 4b44df4def820..96879609ce100 100644
> --- a/drivers/dpll/zl3073x/hwmon.c
> +++ b/drivers/dpll/zl3073x/hwmon.c
> @@ -2,9 +2,11 @@
>   
>   #include <linux/device.h>
>   #include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
>   
>   #include "core.h"
>   #include "hwmon.h"
> +#include "ref.h"
>   #include "regs.h"
>   
>   static int zl3073x_hwmon_read(struct device *dev,
> @@ -55,6 +57,88 @@ static const struct hwmon_chip_info zl3073x_hwmon_chip_info = {
>   	.info = zl3073x_hwmon_info,
>   };
>   
> +static ssize_t freq_input_show(struct device *dev,
> +			       struct device_attribute *devattr, char *buf)
> +{
> +	struct zl3073x_dev *zldev = dev_get_drvdata(dev);
> +	int index = to_sensor_dev_attr(devattr)->index;
> +	const struct zl3073x_ref *ref;
> +
> +	if (!zldev->ready)
> +		return -ENODATA;
> +
> +	ref = zl3073x_ref_state_get(zldev, index);
> +
> +	return sysfs_emit(buf, "%u\n", zl3073x_ref_meas_freq_get(ref));
> +}
> +
> +static ssize_t freq_label_show(struct device *dev,
> +			       struct device_attribute *devattr, char *buf)
> +{
> +	static const char * const labels[] = {
> +		"REF0P", "REF0N", "REF1P", "REF1N", "REF2P",
> +		"REF2N", "REF3P", "REF3N", "REF4P", "REF4N",
> +	};
> +	int index = to_sensor_dev_attr(devattr)->index;
> +
> +	return sysfs_emit(buf, "%s\n", labels[index]);
> +}
> +
> +static SENSOR_DEVICE_ATTR_RO(freq0_input, freq_input, 0);
> +static SENSOR_DEVICE_ATTR_RO(freq1_input, freq_input, 1);
> +static SENSOR_DEVICE_ATTR_RO(freq2_input, freq_input, 2);
> +static SENSOR_DEVICE_ATTR_RO(freq3_input, freq_input, 3);
> +static SENSOR_DEVICE_ATTR_RO(freq4_input, freq_input, 4);
> +static SENSOR_DEVICE_ATTR_RO(freq5_input, freq_input, 5);
> +static SENSOR_DEVICE_ATTR_RO(freq6_input, freq_input, 6);
> +static SENSOR_DEVICE_ATTR_RO(freq7_input, freq_input, 7);
> +static SENSOR_DEVICE_ATTR_RO(freq8_input, freq_input, 8);
> +static SENSOR_DEVICE_ATTR_RO(freq9_input, freq_input, 9);
> +
> +static SENSOR_DEVICE_ATTR_RO(freq0_label, freq_label, 0);
> +static SENSOR_DEVICE_ATTR_RO(freq1_label, freq_label, 1);
> +static SENSOR_DEVICE_ATTR_RO(freq2_label, freq_label, 2);
> +static SENSOR_DEVICE_ATTR_RO(freq3_label, freq_label, 3);
> +static SENSOR_DEVICE_ATTR_RO(freq4_label, freq_label, 4);
> +static SENSOR_DEVICE_ATTR_RO(freq5_label, freq_label, 5);
> +static SENSOR_DEVICE_ATTR_RO(freq6_label, freq_label, 6);
> +static SENSOR_DEVICE_ATTR_RO(freq7_label, freq_label, 7);
> +static SENSOR_DEVICE_ATTR_RO(freq8_label, freq_label, 8);
> +static SENSOR_DEVICE_ATTR_RO(freq9_label, freq_label, 9);
> +
> +static struct attribute *zl3073x_freq_attrs[] = {
> +	&sensor_dev_attr_freq0_input.dev_attr.attr,
> +	&sensor_dev_attr_freq0_label.dev_attr.attr,
> +	&sensor_dev_attr_freq1_input.dev_attr.attr,
> +	&sensor_dev_attr_freq1_label.dev_attr.attr,
> +	&sensor_dev_attr_freq2_input.dev_attr.attr,
> +	&sensor_dev_attr_freq2_label.dev_attr.attr,
> +	&sensor_dev_attr_freq3_input.dev_attr.attr,
> +	&sensor_dev_attr_freq3_label.dev_attr.attr,
> +	&sensor_dev_attr_freq4_input.dev_attr.attr,
> +	&sensor_dev_attr_freq4_label.dev_attr.attr,
> +	&sensor_dev_attr_freq5_input.dev_attr.attr,
> +	&sensor_dev_attr_freq5_label.dev_attr.attr,
> +	&sensor_dev_attr_freq6_input.dev_attr.attr,
> +	&sensor_dev_attr_freq6_label.dev_attr.attr,
> +	&sensor_dev_attr_freq7_input.dev_attr.attr,
> +	&sensor_dev_attr_freq7_label.dev_attr.attr,
> +	&sensor_dev_attr_freq8_input.dev_attr.attr,
> +	&sensor_dev_attr_freq8_label.dev_attr.attr,
> +	&sensor_dev_attr_freq9_input.dev_attr.attr,
> +	&sensor_dev_attr_freq9_label.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group zl3073x_freq_group = {
> +	.attrs = zl3073x_freq_attrs,
> +};
> +
> +static const struct attribute_group *zl3073x_hwmon_groups[] = {
> +	&zl3073x_freq_group,
> +	NULL,
> +};
> +
>   int zl3073x_hwmon_init(struct zl3073x_dev *zldev)
>   {
>   	struct device *hwmon;
> @@ -62,6 +146,6 @@ int zl3073x_hwmon_init(struct zl3073x_dev *zldev)
>   	hwmon = devm_hwmon_device_register_with_info(zldev->dev, "zl3073x",
>   						     zldev,
>   						     &zl3073x_hwmon_chip_info,
> -						     NULL);
> +						     zl3073x_hwmon_groups);
>   	return PTR_ERR_OR_ZERO(hwmon);
>   }


