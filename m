Return-Path: <netdev+bounces-227305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDE4BAC238
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 10:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BE5219241FE
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 08:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E562C08BA;
	Tue, 30 Sep 2025 08:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gER8ngDI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE442BD034
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 08:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759222632; cv=none; b=YImnYI202TexpmL2BDLJtMsv7Pbd2JzY+tLSAamt3B1wqGEfiUjBndZYhrg3T4JVODCiq6MOFUNI7XLW6Zd2Tr8sNjmx8vTUhFvIbdyGgP8+3vJaXglusG04ammT0zs+HGpY+pGqepB3cWAAe7q6UzwZquAfGVL0AGmcoeCtMW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759222632; c=relaxed/simple;
	bh=VJjaWNsH1DDKW2Jy3IqFvgkMe6ID20H+UB6jcKXXWCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iFVVjYszvhoTbd39HVEs0eNLIyfS4IjoOayUzfO0UzFUcwT3ttFmOiBTcXm1aT0MjJxI2pjSmshYWj3tVYPcCYJ1ZE2+Uih8TOqtDJ5y1LEoZKuqgAzY33e+5Ta5ltwQxqQ3h+0fx7OrlMIW4vOncExCP08W7V98kz3ERDBNvKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gER8ngDI; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b07e3a77b72so1115810266b.0
        for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 01:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759222629; x=1759827429; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HSB0NMqeb+/njWkeeAcIUdy3Kf3PhEwD+GpOf+3dyt0=;
        b=gER8ngDIZjlWX/tzXEieO9kScPZXsBzmSemtdXCKgVNAAsXfaj3wrkhjeKpI3yaaRT
         0E8xXnLY3pDr8JSU7DZixcsg8/WXE0jKrejOEyb84PT2oXOYbVxgm0VAhNSBaILniFTh
         vbmAxX6AAqVnl8WG6gcM5Hn+CEFXIScFAuGmdGrHXgHHuSBW9bOohX3cJVEwkPY2qXAt
         Y4LhrjVxYth86TXqTR4Fzt/fc+9knELklLhPPg54eZotMpDquc4ldTFXIwgBIdWu8h0p
         3dvm3dyV53f8PmXi5OQ0x1f/sDTkM+8IK4zrYQ6qZgyzEVrQksmX+Mz/o28niEA+m62Q
         Fa1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759222629; x=1759827429;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HSB0NMqeb+/njWkeeAcIUdy3Kf3PhEwD+GpOf+3dyt0=;
        b=EszZEPFrB/zRfdR1l7M+wEKq89eU6EkvuLr/Iix65ztgJgpvCeZVDi/2Bsikhkl2ap
         FRm1QCkkGzqYTbM8YxmC3AfbwzsoRogfsMBp+cHnzQQ+2t577HUxg0DLCUpoBNoeL0+p
         rt9ZsOTFNKuWxg8b+tlP+IUvI6VAeS9I2wlfmS2ARsrYr71020VzSth0OFvdRU0o/vWp
         kQD48eccYf1qAQ/iyYJ8oyR9KRzSLxPOkPUUlc7/n4M7YRljrXwFk9C5SiX4usA9BM4B
         d2jldvz/yiGknft3bTw49u7hKpPgPOnDAM3OnhsVOl9RcAlV977zeqIeIUcubLqULdAM
         PGvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEkDt1RGPW09sYg9kPGoZuNERqA2hEUOZq4fNpUq1TfT7s0SNRIeAP2QlcMhotndbGbkeXxtU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdaj9idCxDlOHV8/ZT/Q5bYT96C66VLPBMKdmE4adTdD9aPqEB
	Zh9L9vk7yHhe2JGaa7DQp2xT1nkicMRCom1vIp7NK5QSNAvu3Bp9twG+wWB0FtoR1QQ=
X-Gm-Gg: ASbGncvkKTxaKHbPPeSIDZKV7Eqd2IlgdESPyUYUU1eMhjZ6Bh7/qH7yzoGPaFEpLeS
	BCW2vdSro2fS28sqQqLGDA1yB2vF0e3ObpJ4AaEctWsLS4AN64gerPm6pwfsYG4mcZc0wxUFiYz
	wCi3KjA0oVlbpThZpau9PQvY0WPic/D2sxyQvmVX7SMhbyIjA4E6xqf9xW9ItVpLLxPYmztHEgh
	6gwHXzqrkoZ+mBE2cOqraGB+uiSzjlXI4U7rClliMsd0C5IaOcWf+zm1HXcO5I7OerrGvhQrtub
	CvG07DTO2KRmOcIrUo/Bqk9EX3LN77bWLg++K5pgfRX5wwXnY6nfnLZeGxY3mugohH7hIYkI4BY
	VQ4d75ML44sjzkDlVrOYkfPjH254KgwNhqWVjiUef17wKTvJzzroJV0Btjpf7YBG1cjGs5eiE4p
	uCcp8ZRcohFj0g
X-Google-Smtp-Source: AGHT+IFCIngMW3j9SRbmutPjauEZBv35TfJsobgwIjqGW+BJzI/nRe8t1uS8No3vC+NPrpJLLqKUzQ==
X-Received: by 2002:a17:906:f58b:b0:b29:57b0:617f with SMTP id a640c23a62f3a-b4138f4576amr338772966b.1.1759222628756;
        Tue, 30 Sep 2025 01:57:08 -0700 (PDT)
Received: from ?IPV6:2001:a61:13a9:ac01:423a:d8a6:b2d:25a7? ([2001:a61:13a9:ac01:423a:d8a6:b2d:25a7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b35446f7506sm1106959166b.52.2025.09.30.01.57.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 01:57:08 -0700 (PDT)
Message-ID: <666ef6bf-46f0-4b3e-9c28-9c9b7e602900@suse.com>
Date: Tue, 30 Sep 2025 10:57:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] net: usb: ax88179_178a: add USB device driver for
 config selection
To: yicongsrfy@163.com, oneukum@suse.com, andrew+netdev@lunn.ch
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 linux-usb@vger.kernel.org, marcan@marcan.st, netdev@vger.kernel.org,
 pabeni@redhat.com, yicong@kylinos.cn
References: <5a3b2616-fcfd-483a-81a4-34dd3493a97c@suse.com>
 <20250930080709.3408463-1-yicongsrfy@163.com>
 <20250930080709.3408463-3-yicongsrfy@163.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20250930080709.3408463-3-yicongsrfy@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 30.09.25 10:07, yicongsrfy@163.com wrote:
   
> +static int ax88179_probe(struct usb_interface *intf, const struct usb_device_id *i)
> +{
> +	if (intf->cur_altsetting->desc.bInterfaceClass != USB_CLASS_VENDOR_SPEC)
> +		return -ENODEV;

This check is only necessary because you have disabled the checking
done in usbcore with the first patch in your series.
The patch you are reverting with first patch is correct however.
ax88179 can drive these devices only if they are in the vendor
specific mode.

> +	return usbnet_probe(intf, i);
> +}

> +
>   static const struct driver_info ax88179_info = {
>   	.description = "ASIX AX88179 USB 3.0 Gigabit Ethernet",
>   	.bind = ax88179_bind,
> @@ -1941,9 +1950,9 @@ static const struct usb_device_id products[] = {
>   MODULE_DEVICE_TABLE(usb, products);
>   
>   static struct usb_driver ax88179_178a_driver = {
> -	.name =		"ax88179_178a",
> +	.name =		MODULENAME,
>   	.id_table =	products,
> -	.probe =	usbnet_probe,
> +	.probe =	ax88179_probe,
>   	.suspend =	ax88179_suspend,
>   	.resume =	ax88179_resume,
>   	.reset_resume =	ax88179_resume,
> @@ -1952,7 +1961,62 @@ static struct usb_driver ax88179_178a_driver = {
>   	.disable_hub_initiated_lpm = 1,
>   };
>   
> -module_usb_driver(ax88179_178a_driver);
> +static int ax88179_cfgselector_probe(struct usb_device *udev)
> +{
> +	struct usb_host_config *c;
> +	int i, num_configs;
> +
> +	/* The vendor mode is not always config #1, so to find it out. */
> +	c = udev->config;
> +	num_configs = udev->descriptor.bNumConfigurations;
> +	for (i = 0; i < num_configs; (i++, c++)) {
> +		struct usb_interface_descriptor	*desc = NULL;
> +
> +		if (!c->desc.bNumInterfaces)
> +			continue;
> +		desc = &c->intf_cache[0]->altsetting->desc;
> +		if (desc->bInterfaceClass == USB_CLASS_VENDOR_SPEC)
> +			break;
> +	}
> +
> +	if (i == num_configs)
> +		return -ENODEV;
> +
> +	if (usb_set_configuration(udev, c->desc.bConfigurationValue)) {
> +		dev_err(&udev->dev, "Failed to set configuration %d\n",
> +			c->desc.bConfigurationValue);
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct usb_device_driver ax88179_cfgselector_driver = {
> +	.name =		MODULENAME "-cfgselector",
> +	.probe =	ax88179_cfgselector_probe,

You want this to only run if the device is in the generic mode.

> +	.id_table =	products,
But here you check only for the product ID, not for the class code.> +	.generic_subclass = 1,> +	.supports_autosuspend = 1,

You do not. It does not matter, but it is wrong.

> +};
> +
> +static int __init ax88179_driver_init(void)
> +{
> +	int ret;
> +
> +	ret = usb_register_device_driver(&ax88179_cfgselector_driver, THIS_MODULE);
> +	if (ret)
> +		return ret;
> +	return usb_register(&ax88179_178a_driver);

Missing error handling. If you cannot register ax88179_178a_driver
you definitely do not want to keep ax88179_cfgselector_driver

> +}
> +
> +static void __exit ax88179_driver_exit(void)
> +{
> +	usb_deregister(&ax88179_178a_driver);

The window for the race

> +	usb_deregister_device_driver(&ax88179_cfgselector_driver);

Wrong order. I you remove ax88179_178a_driver before you remove
ax88179_cfgselector_driver, you'll leave a window during which
devices would be switched to a mode no driver exists for.

	Regards
		Oliver



